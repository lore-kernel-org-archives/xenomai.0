From: Hongzhan Chen <hongzhan.chen@intel.com>
Subject: [PATCH v5 3/3] libtraceevent: Add xenomai_schedparams plugin for
 libtraceevent
Date: Tue,  8 Mar 2022 21:30:20 -0500
Message-Id: <20220309023020.4883-3-hongzhan.chen@intel.com>
In-Reply-To: <20220309023020.4883-1-hongzhan.chen@intel.com>
References: <20220309023020.4883-1-hongzhan.chen@intel.com>
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org, jan.kiszka@siemens.com, florian.bezdeka@siemens.com

For cobalt thread, there is special struct param_ex data stored in
data record, we need to parse and print its content out correctly
to hint user.

Signed-off-by: Hongzhan Chen <hongzhan.chen@intel.com>
---
 configure.ac                                  |  26 +++
 tracing/Makefile.am                           |  15 +-
 tracing/libtraceevent/Makefile.am             |  19 +++
 tracing/libtraceevent/README                  |  35 ++++
 .../plugin_xenomai_schedparams.c              | 158 ++++++++++++++++++
 5 files changed, 252 insertions(+), 1 deletion(-)
 create mode 100644 tracing/libtraceevent/Makefile.am
 create mode 100644 tracing/libtraceevent/README
 create mode 100644 tracing/libtraceevent/plugin_xenomai_schedparams.c

diff --git a/configure.ac b/configure.ac
index 586880a93..e855b7f3c 100644
--- a/configure.ac
+++ b/configure.ac
@@ -851,6 +851,29 @@ AC_MSG_RESULT($xeno_build_kernelshark)
 
 AM_CONDITIONAL([BUILD_KERNELSHARK], [test x$xeno_build_kernelshark = xtrue])
 
+xeno_build_libtraceevent=false
+AC_MSG_CHECKING(build libtraceevent plugin)
+AC_ARG_WITH(libtraceevent,
+    AS_HELP_STRING([--with-libtraceevent],[build libtraceevent plugin]),
+    [
+	case "$withval" in
+	"" | y | ye | yes) xeno_build_libtraceevent=true;;
+	n | no) xeno_build_libtraceevent=false;;
+	esac
+	if eval test x$xeno_build_libtraceevent = xtrue; then
+		PKG_CHECK_MODULES(libtraceevent, libtraceevent, [xeno_build_libtraceevent=true], [xeno_build_libtraceevent=false])
+		if eval test x$xeno_build_libtraceevent = xtrue; then
+			TRACEEVENT_INCLUDS="$libtraceevent_CFLAGS"
+			AC_SUBST([TRACEEVENT_INSTALLDIR], [$(pkg-config --variable=libdir libtraceevent)])
+		else
+			AC_MSG_ERROR([You must install libtraceevent at first before building libtraceevent plugin for xenomai])
+		fi
+	fi
+    ], [xeno_build_libtraceevent=false])
+AC_MSG_RESULT($xeno_build_libtraceevent)
+
+AM_CONDITIONAL([BUILD_LIBTRACEEVENT], [test x$xeno_build_libtraceevent = xtrue])
+
 AC_MSG_CHECKING([for test source generation])
 AC_RUN_IFELSE([AC_LANG_PROGRAM([[ ]], [[ ]])],
     [AC_MSG_RESULT(ok)], [AC_MSG_RESULT(failed)], [AC_MSG_RESULT(untestable)])
@@ -963,6 +986,8 @@ AC_SUBST(XENO_BUILD_ARGS)
 AC_SUBST(CORE)
 AC_SUBST(KS_INCLUDS)
 AC_SUBST(KS_INSTALLDIR)
+AC_SUBST(TRACEEVENT_INCLUDS)
+AC_SUBST(TRACEEVENT_INSTALLDIR)
 
 
 AC_CONFIG_FILES([ \
@@ -973,6 +998,7 @@ AC_CONFIG_FILES([ \
 	scripts/xeno \
 	tracing/Makefile \
 	tracing/kernelshark/Makefile \
+	tracing/libtraceevent/Makefile \
 	lib/Makefile \
 	lib/boilerplate/Makefile \
 	lib/boilerplate/init/Makefile \
diff --git a/tracing/Makefile.am b/tracing/Makefile.am
index 25c3e033c..8f3d20adf 100644
--- a/tracing/Makefile.am
+++ b/tracing/Makefile.am
@@ -1,6 +1,19 @@
 if BUILD_KERNELSHARK
 SUBDIRS = kernelshark
+
+if BUILD_LIBTRACEEVENT
+SUBDIRS +=	 \
+	libtraceevent
+endif
+
+else
+
+if BUILD_LIBTRACEEVENT
+SUBDIRS = libtraceevent
+endif
+
 endif
 
 DIST_SUBDIRS = 		\
-	kernelshark
+	kernelshark	\
+	libtraceevent
diff --git a/tracing/libtraceevent/Makefile.am b/tracing/libtraceevent/Makefile.am
new file mode 100644
index 000000000..9c6ab505b
--- /dev/null
+++ b/tracing/libtraceevent/Makefile.am
@@ -0,0 +1,19 @@
+
+lib_LTLIBRARIES = libplugin_xenomai_schedparams.la
+
+libplugin_xenomai_schedparams_la_SOURCES =	\
+	plugin_xenomai_schedparams.c
+
+libplugin_xenomai_schedparams_la_CPPFLAGS =	\
+	$(TRACEEVENT_INCLUDS)			\
+	-I$(top_srcdir)/include
+
+install-libLTLIBRARIES: $(lib_LTLIBRARIES)
+	echo "$(LIBTOOL) $(AM_LIBTOOLFLAGS) $(LIBTOOLFLAGS) --mode=install \
+		$(INSTALL_DATA) $(lib_LTLIBRARIES)  '$(TRACEEVENT_INSTALLDIR)/traceevent/plugins/'";	\
+	$(LIBTOOL) $(AM_LIBTOOLFLAGS) $(LIBTOOLFLAGS) --mode=install \
+		$(INSTALL_DATA) $(lib_LTLIBRARIES)  "$(TRACEEVENT_INSTALLDIR)/traceevent/plugins/"
+
+uninstall-libLTLIBRARIES: $(lib_LTLIBRARIES)
+	echo "$(LIBTOOL) $(AM_LIBTOOLFLAGS) $(LIBTOOLFLAGS) --mode=uninstall $(RM) '$(TRACEEVENT_INSTALLDIR)/traceevent/plugins/$(lib_LTLIBRARIES)'";	\
+	$(LIBTOOL) $(AM_LIBTOOLFLAGS) $(LIBTOOLFLAGS) --mode=uninstall $(RM) "$(TRACEEVENT_INSTALLDIR)/traceevent/plugins/$(lib_LTLIBRARIES)"
diff --git a/tracing/libtraceevent/README b/tracing/libtraceevent/README
new file mode 100644
index 000000000..984f17dee
--- /dev/null
+++ b/tracing/libtraceevent/README
@@ -0,0 +1,35 @@
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
+Building & Install plugin
+
+    goto your xenomai folder
+    ./scripts/bootstrap
+    ./configure --with-libtraceevent
+    make
+    sudo make -C tracing/libtraceevent install
+
+How to use built lib?
+===============================
+
+  While libtracevent and its plugins is installed correctly, the plugins
+  would be loaded automatically by other module such as libtracecmd after
+  corresponding tracing tool such as kernelshark or tracecmd run.
diff --git a/tracing/libtraceevent/plugin_xenomai_schedparams.c b/tracing/libtraceevent/plugin_xenomai_schedparams.c
new file mode 100644
index 000000000..01234fe5f
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
2.17.1


