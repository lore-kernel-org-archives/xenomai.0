From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [PATCH v7 3/3] libtraceevent: Add xenomai_schedparams plugin for
 libtraceevent
Date: Sat, 12 Mar 2022 14:00:02 +0100
Message-ID: <20b0e0f350b051bb0644cdc3d07434169c6b15e6.1647090002.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1647090002.git.jan.kiszka@siemens.com>
References: <cover.1647090002.git.jan.kiszka@siemens.com>
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

For cobalt thread, there is special struct param_ex data stored in
data record, we need to parse and print its content out correctly
to hint user.

Signed-off-by: Hongzhan Chen <hongzhan.chen@intel.com>
[Jan: rework installation]
Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 configure.ac                                  |   1 +
 tracing/Makefile.am                           |   7 +-
 tracing/README                                |  84 ++++++++++
 tracing/libtraceevent/Makefile.am             |  19 +++
 .../plugin_xenomai_schedparams.c              | 158 ++++++++++++++++++
 5 files changed, 268 insertions(+), 1 deletion(-)
 create mode 100644 tracing/README
 create mode 100644 tracing/libtraceevent/Makefile.am
 create mode 100644 tracing/libtraceevent/plugin_xenomai_schedparams.c

diff --git a/configure.ac b/configure.ac
index 034368e5a5..e9f46630d4 100644
--- a/configure.ac
+++ b/configure.ac
@@ -978,6 +978,7 @@ AC_CONFIG_FILES([ \
 	scripts/xeno \
 	tracing/Makefile \
 	tracing/kernelshark/Makefile \
+	tracing/libtraceevent/Makefile \
 	lib/Makefile \
 	lib/boilerplate/Makefile \
 	lib/boilerplate/init/Makefile \
diff --git a/tracing/Makefile.am b/tracing/Makefile.am
index 885a9497f7..da7d979f9a 100644
--- a/tracing/Makefile.am
+++ b/tracing/Makefile.am
@@ -4,5 +4,10 @@ if XENO_KSHARK_PLUGIN
 SUBDIRS += kernelshark
 endif
 
+if XENO_LIBTRACEEVENT_PLUGIN
+SUBDIRS += libtraceevent
+endif
+
 DIST_SUBDIRS = 		\
-	kernelshark
+	kernelshark	\
+	libtraceevent
diff --git a/tracing/README b/tracing/README
new file mode 100644
index 0000000000..298797052e
--- /dev/null
+++ b/tracing/README
@@ -0,0 +1,84 @@
+
+What is it?
+=============
+
+  The modules under this folder is plugins implemented for Xenomai tracing.
+  kernelshark subdir includes plugin for KernelShark.
+  libtraceevent subduir includes plugin for libtraceevent.
+
+Dependencies
+================================
+
+  For KernelShark plugin:
+      Building standlone plugin for KernelShark depends on
+      following patchset after kernelshark-v2.1.0:
+         kernel-shark: Install missing headers (commit 5419186f4bbad68aa16849882a8f12fa9adb22c5)
+         kernel-shark: Add KsPluginsGUI.hpp/.cpp (commit 59b5763c7c52b703e3b8e05be801f7c85365c9d3)
+         kernel-shark: Load 'ctrl' interface for user plugins (commit e35970770b71f0cc849870512a806dff96bf19e1)
+
+      If you cannot confirm that your local installed KernelShark include these patches,
+      please refer to https://kernelshark.org/build.html to download updated code
+      and build & install again.
+
+How to build and install plugin?
+====================================
+
+    goto your xenomai folder
+    ./scripts/bootstrap
+    ./configure --enable-xxx-plugin
+    cd tracing/xxx/
+    make
+    sudo make install
+
+    Note: Please replace xxx with your module name that you want to build and install plugin.
+
+How to use plugin?
+====================================
+
+  For KernelShark plugin:
+
+      kernelshark -p your_path_of_libplugin_xenomai_cobalt_switch_events.so your_path_of_trace.dat
+
+  For libtraceevent plugin:
+
+      While libtracevent and its plugins is installed correctly, the plugins
+      would be loaded automatically by other module such as libtracecmd after
+      corresponding tracing tool such as KernelShark or trace-cmd run.
+
+What the difference is after plug works?
+===============================================
+
+  For KernelShark plugin:
+      1. For those trace log which does not include cobalt_switch_context event, you may
+         not expect that there is any difference after Xenomai plugin is loaded.
+
+      2. But when there is cobalt_switch_context event in trace log, the plugin would
+         analysis cobalt_switch_context event and visualize the OOB state.
+
+      3. How to check OOB state with cobalt blue hollow box?
+
+         3.1. Please check if there is cobalt_switch_context events existing in the
+              log using search boxes in the list area of kernelshark GUI.
+
+         3.2. When there is cobalt_switch_context events existing in the log, please goto
+              task plots dialog to choose tasks that you may want to check its OOB state by
+              clicking menu Plots->Tasks and then hit "Apply".
+
+         3.3. Selected tasks would be added to the bottom of the graph area as task plots.
+              You may zoom in to check if there is cobalt blue hollow box showing in
+              the corresponding task bar/plot if the time span is really large and
+              there is too much events.
+
+         3.4. When you double click the hollow box, there is two vertical lines
+              that marked as "Mark A" and "Mark B" which you may use to measure time of
+              running in OOB state between two cobalt_switch_context events.
+
+         Note:
+              Please refer to [1] about introduction of search boxes or task plot or  "Mark A" &
+              "Mark B" on Graph Control Area for more detailed info.
+
+  For libtraceevent plugin:
+
+      It would try to show sched_param_ex param correctly.
+
+[1]: https://kernelshark.org/Documentation.html
diff --git a/tracing/libtraceevent/Makefile.am b/tracing/libtraceevent/Makefile.am
new file mode 100644
index 0000000000..542d71cb6f
--- /dev/null
+++ b/tracing/libtraceevent/Makefile.am
@@ -0,0 +1,19 @@
+libsub_LTLIBRARIES = plugin_xenomai_schedparams.la
+
+plugin_xenomai_schedparams_la_SOURCES =	\
+	plugin_xenomai_schedparams.c
+
+plugin_xenomai_schedparams_la_CPPFLAGS =	\
+	$(LIBTRACEEVENT_CFLAGS)			\
+	-I$(top_srcdir)/include
+
+plugin_xenomai_schedparams_la_LDFLAGS =		\
+	$(LIBTRACEEVENT_LIBS)			\
+	-module -avoid-version -nostartfiles
+
+AM_LIBTOOLFLAGS = --silent --tag=disable-static
+
+libsubdir := $(libdir)/traceevent/plugins
+
+install-data-hook:
+	$(RM) $(DESTDIR)$(libsubdir)/$(libsub_LTLIBRARIES)
diff --git a/tracing/libtraceevent/plugin_xenomai_schedparams.c b/tracing/libtraceevent/plugin_xenomai_schedparams.c
new file mode 100644
index 0000000000..01234fe5f0
--- /dev/null
+++ b/tracing/libtraceevent/plugin_xenomai_schedparams.c
@@ -0,0 +1,158 @@
+// SPDX-License-Identifier: LGPL-2.1
+/*
+ * Copyright (C) 2021 Intel Inc, Hongzhan Chen <hongzhan.chen@intel.com>
+ */
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <linux/sched.h>
+#include <cobalt/uapi/sched.h>
+#include <sched.h>
+#include "event-parse.h"
+#include "trace-seq.h"
+
+static void write_policy(struct trace_seq *p, int policy)
+{
+	trace_seq_printf(p, "policy=");
+
+	switch (policy) {
+	case SCHED_QUOTA:
+		trace_seq_printf(p, "quota ");
+		break;
+	case SCHED_TP:
+		trace_seq_printf(p, "tp ");
+		break;
+	case SCHED_NORMAL:
+		trace_seq_printf(p, "normal ");
+		break;
+	case SCHED_SPORADIC:
+		trace_seq_printf(p, "sporadic ");
+		break;
+	case SCHED_RR:
+		trace_seq_printf(p, "rr ");
+		break;
+	case SCHED_FIFO:
+		trace_seq_printf(p, "fifo ");
+		break;
+	case SCHED_COBALT:
+		trace_seq_printf(p, "cobalt ");
+		break;
+	case SCHED_WEAK:
+		trace_seq_printf(p, "weak ");
+		break;
+	default:
+		trace_seq_printf(p, "unknown ");
+		break;
+	}
+}
+
+/* save param */
+static void write_param(struct tep_format_field *field,
+				struct tep_record *record,
+				struct trace_seq *p, int policy)
+{
+	int offset;
+	struct sched_param_ex *params;
+
+	offset = field->offset;
+
+	if (!strncmp(field->type, "__data_loc", 10)) {
+		unsigned long long v;
+
+		if (tep_read_number_field(field, record->data, &v)) {
+			trace_seq_printf(p, "invalid_data_loc");
+			return;
+		}
+		offset = v & 0xffff;
+
+	}
+
+	params = (struct sched_param_ex *)((char *)record->data + offset);
+
+	trace_seq_printf(p, "param: { ");
+
+	switch (policy) {
+	case SCHED_QUOTA:
+		trace_seq_printf(p, "priority=%d, group=%d",
+				 params->sched_priority,
+				 params->sched_quota_group);
+		break;
+	case SCHED_TP:
+		trace_seq_printf(p, "priority=%d, partition=%d",
+				 params->sched_priority,
+				 params->sched_tp_partition);
+		break;
+	case SCHED_NORMAL:
+		break;
+	case SCHED_SPORADIC:
+		trace_seq_printf(p, "priority=%d, low_priority=%d, ",
+				 params->sched_priority,
+				 params->sched_ss_low_priority);
+
+		trace_seq_printf(p, "budget=(%ld.%09ld), period=(%ld.%09ld), ",
+				 params->sched_ss_init_budget.tv_sec,
+				 params->sched_ss_init_budget.tv_nsec);
+
+		trace_seq_printf(p, "maxrepl=%d",
+				 params->sched_ss_max_repl);
+		break;
+	case SCHED_RR:
+	case SCHED_FIFO:
+	case SCHED_COBALT:
+	case SCHED_WEAK:
+	default:
+		trace_seq_printf(p, "priority=%d", params->sched_priority);
+		break;
+	}
+	trace_seq_printf(p, " }");
+	trace_seq_putc(p, '\0');
+
+}
+
+static int cobalt_schedparam_handler(struct trace_seq *s,
+				struct tep_record *record,
+				struct tep_event *event, void *context)
+{
+	struct tep_format_field *field;
+	unsigned long long val;
+
+	if (tep_get_field_val(s, event, "pth", record, &val, 1))
+		return trace_seq_putc(s, '!');
+	trace_seq_puts(s, "pth: ");
+	trace_seq_printf(s, "0x%08llx ", val);
+
+	if (tep_get_field_val(s, event, "policy", record, &val, 1) == 0)
+		write_policy(s, val);
+
+	field = tep_find_field(event, "param_ex");
+	if (field)
+		write_param(field, record, s, val);
+
+	return 0;
+}
+
+int TEP_PLUGIN_LOADER(struct tep_handle *tep)
+{
+	tep_register_event_handler(tep, -1, "cobalt_posix", "cobalt_pthread_setschedparam",
+					cobalt_schedparam_handler, NULL);
+
+	tep_register_event_handler(tep, -1, "cobalt_posix", "cobalt_pthread_getschedparam",
+					cobalt_schedparam_handler, NULL);
+
+	tep_register_event_handler(tep, -1, "cobalt_posix", "cobalt_pthread_create",
+					cobalt_schedparam_handler, NULL);
+
+	return 0;
+}
+
+void TEP_PLUGIN_UNLOADER(struct tep_handle *tep)
+{
+	tep_unregister_event_handler(tep, -1, "cobalt_posix", "cobalt_pthread_setschedparam",
+					cobalt_schedparam_handler, NULL);
+
+	tep_unregister_event_handler(tep, -1, "cobalt_posix", "cobalt_pthread_getschedparam",
+					cobalt_schedparam_handler, NULL);
+
+	tep_unregister_event_handler(tep, -1, "cobalt_posix", "cobalt_pthread_create",
+					cobalt_schedparam_handler, NULL);
+}
-- 
2.34.1


