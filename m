From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [PATCH v8 2/4] KernelShark: Add xenomai_cobalt_switch_events plugin
 for KernelShark
Date: Mon, 14 Mar 2022 11:01:00 +0100
Message-ID: <aff219aec319c8d994b9d8f488456abc5245fbf2.1647252062.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1647252062.git.jan.kiszka@siemens.com>
References: <cover.1647252062.git.jan.kiszka@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

From: Hongzhan Chen <hongzhan.chen@intel.com>

For Xenomai-cobalt enabled system, cobalt_switch_context means
that there is schedule and context switch in companion core(realtime
core), which we may need to do special treatment and take correct
action as main kernel sched_switch to visualize out-of-band state
of realtime tasks running in cobalt core. To achive our target,
we implement following:

  1. store corresponding cobalt_switch_context events into
     container data.
  2. modify pid stored in entry to be equal to next_pid to
     show correct color in cpu bar when cobalt_switch_context
     event happen.
  3. show blue hollow box to mark out-of-band state according to
     cobalt_switch_context events.
  4. clickable cobalt_switch_context plugin shapes.

Signed-off-by: Hongzhan Chen <hongzhan.chen@intel.com>
[Jan: rework installation]
Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 Makefile.am                                   |   4 +
 configure.ac                                  |   2 +
 tracing/Makefile.am                           |   8 +
 tracing/kernelshark/CobaltSwitchEvents.cpp    | 156 ++++++++++++++++
 tracing/kernelshark/Makefile.am               |  20 ++
 .../xenomai_cobalt_switch_events.c            | 174 ++++++++++++++++++
 .../xenomai_cobalt_switch_events.h            |  58 ++++++
 7 files changed, 422 insertions(+)
 create mode 100644 tracing/Makefile.am
 create mode 100644 tracing/kernelshark/CobaltSwitchEvents.cpp
 create mode 100644 tracing/kernelshark/Makefile.am
 create mode 100644 tracing/kernelshark/xenomai_cobalt_switch_events.c
 create mode 100644 tracing/kernelshark/xenomai_cobalt_switch_events.h

diff --git a/Makefile.am b/Makefile.am
index 604644277e..bd3e4bfb18 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -18,6 +18,9 @@ SUBDIRS += 		\
 	testsuite
 endif
 
+SUBDIRS +=		\
+	tracing
+
 EXTRA_DIST = kernel debian
 
 DIST_SUBDIRS =		\
@@ -26,6 +29,7 @@ DIST_SUBDIRS =		\
 	doc		\
 	include		\
 	lib 		\
+	tracing		\
 	scripts		\
 	testsuite	\
 	utils
diff --git a/configure.ac b/configure.ac
index 7387bb3560..4d11a6e421 100644
--- a/configure.ac
+++ b/configure.ac
@@ -975,6 +975,8 @@ AC_CONFIG_FILES([ \
 	scripts/Makefile \
 	scripts/xeno-config:scripts/xeno-config-$rtcore_type.in \
 	scripts/xeno \
+	tracing/Makefile \
+	tracing/kernelshark/Makefile \
 	lib/Makefile \
 	lib/boilerplate/Makefile \
 	lib/boilerplate/init/Makefile \
diff --git a/tracing/Makefile.am b/tracing/Makefile.am
new file mode 100644
index 0000000000..885a9497f7
--- /dev/null
+++ b/tracing/Makefile.am
@@ -0,0 +1,8 @@
+SUBDIRS =
+
+if XENO_KSHARK_PLUGIN
+SUBDIRS += kernelshark
+endif
+
+DIST_SUBDIRS = 		\
+	kernelshark
diff --git a/tracing/kernelshark/CobaltSwitchEvents.cpp b/tracing/kernelshark/CobaltSwitchEvents.cpp
new file mode 100644
index 0000000000..3a521bdfc0
--- /dev/null
+++ b/tracing/kernelshark/CobaltSwitchEvents.cpp
@@ -0,0 +1,156 @@
+// SPDX-License-Identifier: LGPL-2.1
+
+/*
+ * Copyright (C) 2021 Intel Inc, Hongzhan Chen <hongzhan.chen@intel.com>
+ */
+
+/**
+ *  @file    CobaltSwitchEvents.cpp
+ *  @brief   Defines a callback function for Xenomai Cobalt context switch
+ *           events used to plot in cobalt blue the out-of-band state of
+ *           the task
+ */
+
+// KernelShark
+#include "libkshark.h"
+#include "libkshark-plugin.h"
+#include "xenomai_cobalt_switch_events.h"
+#include "KsPlotTools.hpp"
+#include "KsPlugins.hpp"
+#include "KsPluginsGUI.hpp"
+
+static void *ks4xenomai_ptr;
+
+/**
+ * @brief Provide the plugin with a pointer to the KsMainWindow object (the GUI
+ * itself) such that the plugin can manipulate the GUI.
+ */
+__hidden void *plugin_set_gui_ptr(void *gui_ptr)
+{
+	ks4xenomai_ptr = gui_ptr;
+	return nullptr;
+}
+
+/**
+ * This class represents the graphical element visualizing OOB state between
+ *  two cobalt_switch_context events.
+ */
+class XenomaiSwitchBox : public LatencyBox
+{
+	/** On double click do. */
+	void _doubleClick() const override
+	{
+		markEntryB(ks4xenomai_ptr, _data[1]->entry);
+		markEntryA(ks4xenomai_ptr, _data[0]->entry);
+	}
+};
+
+/*
+ * Ideally, the cobalt_switch_context has to be the last trace event recorded before
+ * the task is preempted. Because of this, when the data is loaded (the first pass),
+ * the "pid" field of the cobalt_switch_context entries gets edited by this plugin
+ * to be equal to the "next pid" of the cobalt_switch_context event. However, in
+ * reality the cobalt_switch_context event may be followed by some trailing events
+ * from the same task (printk events for example). This has the effect of extending
+ * the graph of the task outside of the actual duration of the task. The "second
+ * pass" over the data is used to fix this problem. It takes advantage of the
+ * "next" field of the entry (this field is set during the first pass) to search
+ * for trailing events after the "cobalt_switch_context". In addition, when
+ * we find that it try to switch in-band because next-pid is zero, we prefer to
+ * skip this event because it try to leave oob not enterring.
+ */
+static void secondPass(plugin_cobalt_context *plugin_ctx)
+{
+	kshark_data_container *cSS;
+	kshark_entry *e;
+	int pid_rec, switch_inband;
+
+	cSS = plugin_ctx->cs_data;
+	for (ssize_t i = 0; i < cSS->size; ++i) {
+		switch_inband = plugin_cobalt_check_switch_inband(
+				cSS->data[i]->field);
+
+		/* we skip cobalt_switch_context that try to
+		 * switch into in-band state because we just handle
+		 * out-of-band
+		 */
+		if (switch_inband)
+			continue;
+		pid_rec = plugin_sched_get_pid(cSS->data[i]->field);
+		e = cSS->data[i]->entry;
+		if (!e->next || e->pid == 0 ||
+		    e->event_id == e->next->event_id ||
+		    pid_rec != e->next->pid)
+			continue;
+
+		e = e->next;
+		/* Find all trailing events. */
+		for (; e->next; e = e->next) {
+			if (e->pid == plugin_sched_get_pid(
+						cSS->data[i]->field)) {
+				/*
+				 * Change the "pid" to be equal to the "next
+				 * pid" of the cobalt_switch_context event
+				 * and leave a sign that you edited this
+				 * entry.
+				 */
+				e->pid = cSS->data[i]->entry->pid;
+				e->visible &= ~KS_PLUGIN_UNTOUCHED_MASK;
+
+				/*  This is the last trailing event, we finish
+				 *  this round.
+				 */
+				if (e->next->pid != plugin_sched_get_pid(
+						cSS->data[i]->field))
+					break;
+			}
+		}
+	}
+}
+
+/**
+ * @brief Plugin's draw function.
+ *
+ * @param argv_c: A C pointer to be converted to KsCppArgV (C++ struct).
+ * @param sd: Data stream identifier.
+ * @param pid: Process Id.
+ * @param draw_action: Draw action identifier.
+ */
+__hidden void plugin_cobalt_draw(kshark_cpp_argv *argv_c,
+			  int sd, int pid, int draw_action)
+{
+	plugin_cobalt_context *plugin_ctx;
+
+	if (!(draw_action & KSHARK_TASK_DRAW) || pid == 0)
+		return;
+
+	plugin_ctx = __get_context(sd);
+	if (!plugin_ctx)
+		return;
+
+	KsCppArgV *argvCpp = KS_ARGV_TO_CPP(argv_c);
+
+	if (!plugin_ctx->second_pass_done) {
+		/* The second pass is not done yet. */
+		secondPass(plugin_ctx);
+		plugin_ctx->second_pass_done = true;
+	}
+
+	IsApplicableFunc checkFieldCS = [=] (kshark_data_container *d,
+					     ssize_t i) {
+		return !(plugin_cobalt_check_switch_inband(d->data[i]->field)) &&
+			d->data[i]->entry->pid == pid;
+	};
+
+	IsApplicableFunc checkEntryPid = [=] (kshark_data_container *d,
+					      ssize_t i) {
+		return plugin_sched_get_pid(d->data[i]->field) == pid;
+	};
+
+	eventFieldIntervalPlot(argvCpp,
+			       plugin_ctx->cs_data, checkFieldCS,
+			       plugin_ctx->cs_data, checkEntryPid,
+			       makeLatencyBox<XenomaiSwitchBox>,
+			       {0, 71, 171}, // Cobalt Blue
+			       -1);         // Default size
+}
diff --git a/tracing/kernelshark/Makefile.am b/tracing/kernelshark/Makefile.am
new file mode 100644
index 0000000000..954805e53d
--- /dev/null
+++ b/tracing/kernelshark/Makefile.am
@@ -0,0 +1,20 @@
+libsub_LTLIBRARIES = plugin_xenomai_cobalt_switch_events.la
+
+plugin_xenomai_cobalt_switch_events_la_SOURCES =	\
+	CobaltSwitchEvents.cpp				\
+	xenomai_cobalt_switch_events.c			\
+	xenomai_cobalt_switch_events.h
+
+plugin_xenomai_cobalt_switch_events_la_CPPFLAGS  =	\
+	$(LIBKSHARK_CFLAGS)
+
+plugin_xenomai_cobalt_switch_events_la_LDFLAGS =	\
+	$(LIBKSHARK_LIBS)				\
+	-module -avoid-version
+
+AM_LIBTOOLFLAGS = --silent --tag=disable-static
+
+libsubdir := $(libdir)/kernelshark/plugins
+
+install-data-hook:
+	$(RM) $(DESTDIR)$(libsubdir)/$(libsub_LTLIBRARIES)
diff --git a/tracing/kernelshark/xenomai_cobalt_switch_events.c b/tracing/kernelshark/xenomai_cobalt_switch_events.c
new file mode 100644
index 0000000000..758966df74
--- /dev/null
+++ b/tracing/kernelshark/xenomai_cobalt_switch_events.c
@@ -0,0 +1,174 @@
+// SPDX-License-Identifier: LGPL-2.1
+
+/*
+ * Copyright (C) 2021 Intel Inc, Hongzhan Chen <hongzhan.chen@intel.com>
+ */
+
+/**
+ *  @file    xenomai_cobalt_switch_events.c
+ *  @brief   handle xenomai cobalt switch context event
+ */
+
+// C
+#include <stdlib.h>
+#include <stdio.h>
+
+// trace-cmd
+#include <trace-cmd.h>
+
+// KernelShark
+#include "xenomai_cobalt_switch_events.h"
+#include "libkshark-tepdata.h"
+
+/** Plugin context instance. */
+
+//! @cond Doxygen_Suppress
+
+#define SWITCH_INBAND_SHIFT	PREV_STATE_SHIFT
+
+#define SWITCH_INBAND_MASK	PREV_STATE_MASK
+
+//! @endcond
+
+static void cobalt_free_context(struct plugin_cobalt_context *plugin_ctx)
+{
+	if (!plugin_ctx)
+		return;
+
+	kshark_free_data_container(plugin_ctx->cs_data);
+}
+
+/* Use the most significant byte to store state marking switch in-band. */
+static void plugin_cobalt_set_switch_inband_state(ks_num_field_t *field,
+					ks_num_field_t inband_state)
+{
+	unsigned long long mask = SWITCH_INBAND_MASK << SWITCH_INBAND_SHIFT;
+	*field &= ~mask;
+	*field |= (inband_state & SWITCH_INBAND_MASK) << SWITCH_INBAND_SHIFT;
+}
+
+/**
+ * @brief Retrieve the state of switch-in-band from the data field stored in
+ *        the kshark_data_container object.
+ *
+ * @param field: Input location for the data field.
+ */
+__hidden int plugin_cobalt_check_switch_inband(ks_num_field_t field)
+{
+	unsigned long long mask = SWITCH_INBAND_MASK << SWITCH_INBAND_SHIFT;
+
+	return (field & mask) >> SWITCH_INBAND_SHIFT;
+}
+
+/** A general purpose macro is used to define plugin context. */
+KS_DEFINE_PLUGIN_CONTEXT(struct plugin_cobalt_context, cobalt_free_context);
+
+static bool plugin_cobalt_init_context(struct kshark_data_stream *stream,
+				      struct plugin_cobalt_context *plugin_ctx)
+{
+	struct tep_event *event;
+
+	if (!kshark_is_tep(stream))
+		return false;
+
+	plugin_ctx->tep = kshark_get_tep(stream);
+
+	event = tep_find_event_by_name(plugin_ctx->tep,
+					"cobalt_core", "cobalt_switch_context");
+	if (!event)
+		return false;
+
+	plugin_ctx->cobalt_switch_event = event;
+	plugin_ctx->cobalt_switch_next_field =
+		tep_find_any_field(event, "next_pid");
+
+	plugin_ctx->second_pass_done = false;
+
+	plugin_ctx->cs_data = kshark_init_data_container();
+	if (!plugin_ctx->cs_data)
+		return false;
+
+	return true;
+}
+
+static void plugin_cobalt_switch_action(struct kshark_data_stream *stream,
+				      void *rec, struct kshark_entry *entry)
+{
+	struct tep_record *record = (struct tep_record *) rec;
+	struct plugin_cobalt_context *plugin_ctx;
+	unsigned long long next_pid;
+	ks_num_field_t ks_field = 0;
+	int ret;
+
+	plugin_ctx = __get_context(stream->stream_id);
+	if (!plugin_ctx)
+		return;
+
+	ret = tep_read_number_field(plugin_ctx->cobalt_switch_next_field,
+				    record->data, &next_pid);
+
+	if (ret == 0 && next_pid >= 0) {
+		plugin_sched_set_pid(&ks_field, entry->pid);
+		if (next_pid == 0) {
+			plugin_cobalt_set_switch_inband_state(&ks_field,
+					SWITCH_INBAND_STATE);
+		}
+
+		kshark_data_container_append(plugin_ctx->cs_data,
+				entry, ks_field);
+
+		if (next_pid > 0)
+			entry->pid = next_pid;
+	}
+}
+
+/** Load this plugin. */
+int KSHARK_PLOT_PLUGIN_INITIALIZER(struct kshark_data_stream *stream)
+{
+	struct plugin_cobalt_context *plugin_ctx;
+
+	plugin_ctx = __init(stream->stream_id);
+	if (!plugin_ctx || !plugin_cobalt_init_context(stream, plugin_ctx)) {
+		__close(stream->stream_id);
+		return 0;
+	}
+
+	if (plugin_ctx->cobalt_switch_event) {
+		kshark_register_event_handler(stream,
+						plugin_ctx->cobalt_switch_event->id,
+						plugin_cobalt_switch_action);
+	}
+
+	kshark_register_draw_handler(stream, plugin_cobalt_draw);
+
+	return 1;
+}
+
+/** Unload this plugin. */
+int KSHARK_PLOT_PLUGIN_DEINITIALIZER(struct kshark_data_stream *stream)
+{
+	struct plugin_cobalt_context *plugin_ctx = __get_context(stream->stream_id);
+	int ret = 0;
+
+	if (plugin_ctx) {
+		if (plugin_ctx->cobalt_switch_event) {
+			kshark_unregister_event_handler(stream,
+							plugin_ctx->cobalt_switch_event->id,
+							plugin_cobalt_switch_action);
+		}
+
+		kshark_unregister_draw_handler(stream, plugin_cobalt_draw);
+
+		ret = 1;
+	}
+
+	__close(stream->stream_id);
+
+	return ret;
+}
+
+/** Initialize the control interface of the plugin. */
+void *KSHARK_MENU_PLUGIN_INITIALIZER(void *gui_ptr)
+{
+	return plugin_set_gui_ptr(gui_ptr);
+}
diff --git a/tracing/kernelshark/xenomai_cobalt_switch_events.h b/tracing/kernelshark/xenomai_cobalt_switch_events.h
new file mode 100644
index 0000000000..f7f4593ff9
--- /dev/null
+++ b/tracing/kernelshark/xenomai_cobalt_switch_events.h
@@ -0,0 +1,58 @@
+/* SPDX-License-Identifier: LGPL-2.1 */
+
+/*
+ * Copyright (C) 2021 Intel Inc, Hongzhan Chen<hongzhan.chen@intel.com>
+ */
+
+/**
+ *  @file    xenomai_cobalt_switch_events.h
+ *  @brief   Plugin for xenomai cobalt switch context event
+ */
+
+#ifndef _KS_PLUGIN_COBALT_SWITCH_H
+#define _KS_PLUGIN_COBALT_SWITCH_H
+
+// KernelShark
+#include "libkshark.h"
+#include "plugins/common_sched.h"
+
+#ifdef __cplusplus
+extern "C" {
+#endif
+
+/** cobalt_switch_context is trying to switch in-band. */
+#define SWITCH_INBAND_STATE	1
+
+/** Structure representing a plugin-specific context. */
+struct plugin_cobalt_context {
+	/** Page event used to parse the page. */
+	struct tep_handle	*tep;
+
+	/** Pointer to the cobalt_switch_event object. */
+	struct tep_event	*cobalt_switch_event;
+
+	 /** Pointer to the cobalt_switch_next_field format descriptor. */
+	struct tep_format_field *cobalt_switch_next_field;
+
+	/** True if the second pass is already done. */
+	bool	second_pass_done;
+
+	/** Data container for cobalt_switch_context data. */
+	struct kshark_data_container	*cs_data;
+
+};
+
+KS_DECLARE_PLUGIN_CONTEXT_METHODS(struct plugin_cobalt_context)
+
+int plugin_cobalt_check_switch_inband(ks_num_field_t field);
+
+void plugin_cobalt_draw(struct kshark_cpp_argv *argv, int sd, int pid,
+		 int draw_action);
+
+void *plugin_set_gui_ptr(void *gui_ptr);
+
+#ifdef __cplusplus
+}
+#endif
+
+#endif
-- 
2.34.1


