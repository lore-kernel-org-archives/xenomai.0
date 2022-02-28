From: Hongzhan Chen <hongzhan.chen@intel.com>
Subject: [PATCH 4/4] libtraceevent: Add Add xenomai_schedparams plugin for
 libtraceevent
Date: Mon, 28 Feb 2022 00:40:55 -0500
Message-Id: <20220228054055.16112-5-hongzhan.chen@intel.com>
In-Reply-To: <20220228054055.16112-1-hongzhan.chen@intel.com>
References: <20220228054055.16112-1-hongzhan.chen@intel.com>
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org, jan.kiszka@siemens.com

For cobalt thread, there is special struct param_ex data stored in
data record, we need to parse and print its content out correctly
to hint user when using libtraceevent.

Signed-off-by: Hongzhan Chen <hongzhan.chen@intel.com>
---
 configure.ac                                  |   1 +
 kernel-shark/Makefile.am                      |   6 +-
 kernel-shark/libtraceevent/Makefile.am        |  10 +
 kernel-shark/libtraceevent/README             |  30 +++
 .../plugin_xenomai_schedparams.c              | 201 ++++++++++++++++++
 5 files changed, 246 insertions(+), 2 deletions(-)
 create mode 100644 kernel-shark/libtraceevent/Makefile.am
 create mode 100644 kernel-shark/libtraceevent/README
 create mode 100644 kernel-shark/libtraceevent/plugin_xenomai_schedparams.c

diff --git a/configure.ac b/configure.ac
index b2e233494..1dc8e4cff 100644
--- a/configure.ac
+++ b/configure.ac
@@ -959,6 +959,7 @@ AC_CONFIG_FILES([ \
 	scripts/xeno \
 	kernel-shark/Makefile \
 	kernel-shark/kernelshark/Makefile \
+	kernel-shark/libtraceevent/Makefile \
 	lib/Makefile \
 	lib/boilerplate/Makefile \
 	lib/boilerplate/init/Makefile \
diff --git a/kernel-shark/Makefile.am b/kernel-shark/Makefile.am
index 8bdf1f906..35ebe3954 100644
--- a/kernel-shark/Makefile.am
+++ b/kernel-shark/Makefile.am
@@ -1,6 +1,8 @@
 
 SUBDIRS =		\
-	kernelshark
+	kernelshark	\
+	libtraceevent
 
 DIST_SUBDIRS = 		\
-	kernelshark
+	kernelshark	\
+	libtraceevent
diff --git a/kernel-shark/libtraceevent/Makefile.am b/kernel-shark/libtraceevent/Makefile.am
new file mode 100644
index 000000000..e6ae6f319
--- /dev/null
+++ b/kernel-shark/libtraceevent/Makefile.am
@@ -0,0 +1,10 @@
+
+lib_LTLIBRARIES = libplugin_xenomai_schedparams.la
+
+TRACEEVENR_INCLUDS ?= /usr/local/include/traceevent
+
+libplugin_xenomai_schedparams_la_SOURCES =	\
+	plugin_xenomai_schedparams.c
+
+libplugin_xenomai_schedparams_la_CPPFLAGS =	\
+	-I$(TRACEEVENR_INCLUDS)
diff --git a/kernel-shark/libtraceevent/README b/kernel-shark/libtraceevent/README
new file mode 100644
index 000000000..8a55749fa
--- /dev/null
+++ b/kernel-shark/libtraceevent/README
@@ -0,0 +1,30 @@
+
+What is it?
+=============
+
+  It is Xenomai plugin on libtracevent to parse struct param_ex
+  out correctly for trace log.
+
+How to compile?
+================================
+
+Preparation:
+
+  - GIT clone:
+
+      https://git.kernel.org/pub/scm/libs/libtrace/libtraceevent.git
+
+  - build and install libtraceevent:
+
+      make;
+      sudo make install
+
+How to use built lib?
+===============================
+
+  Please copy built libplugin_xenomai_schedparams.so to 
+  /usr/local/lib/traceevent/plugins/ or 
+  /usr/local/lib64/traceevent/plugins/ depending your system.
+  When libtracevent and its plugins is installed correctly, the plugins
+  would be loaded automatically by other module such as libtracecmd after
+  kernel-shark run.
diff --git a/kernel-shark/libtraceevent/plugin_xenomai_schedparams.c b/kernel-shark/libtraceevent/plugin_xenomai_schedparams.c
new file mode 100644
index 000000000..731e525ba
--- /dev/null
+++ b/kernel-shark/libtraceevent/plugin_xenomai_schedparams.c
@@ -0,0 +1,201 @@
+// SPDX-License-Identifier: LGPL-2.1
+/*
+ * Copyright (C) 2021 Intel Inc, Hongzhan Chen <hongzhan.chen@intel.com>
+ */
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <linux/sched.h>
+
+#include "event-parse.h"
+#include "trace-seq.h"
+
+
+#define SCHED_SPORADIC		10
+#define SCHED_TP		11
+#define SCHED_QUOTA		12
+
+#define SCHED_COBALT		42
+#define SCHED_WEAK		43
+
+struct __sched_ss_param {
+	int __sched_low_priority;
+	struct timespec __sched_repl_period;
+	struct timespec __sched_init_budget;
+	int __sched_max_repl;
+};
+
+struct __sched_rr_param {
+	struct timespec __sched_rr_quantum;
+};
+
+struct __sched_tp_param {
+	int __sched_partition;
+};
+
+struct __sched_quota_param {
+	int __sched_group;
+};
+
+struct sched_param_ex {
+	int sched_priority;
+	union {
+		struct __sched_ss_param ss;
+		struct __sched_rr_param rr;
+		struct __sched_tp_param tp;
+		struct __sched_quota_param quota;
+	} sched_u;
+};
+
+#define sched_quota_group	sched_u.quota.__sched_group
+#define sched_tp_partition	sched_u.tp.__sched_partition
+#define sched_ss_low_priority	sched_u.ss.__sched_low_priority
+#define sched_ss_repl_period	sched_u.ss.__sched_repl_period
+#define sched_ss_init_budget	sched_u.ss.__sched_init_budget
+#define sched_ss_max_repl	sched_u.ss.__sched_max_repl
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
2.17.1


