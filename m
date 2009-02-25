Message-ID: <49A5904A.2020800@domain.hid>
Date: Wed, 25 Feb 2009 19:39:06 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-core] [PATCH 2/2] rtdk: Add assert_context helpers
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai-core <xenomai@xenomai.org>

Provide assert_nrt helper that checks if the caller is either not a
shadow thread or is currently running in relaxed mode. If not, SIG_XCPU
is raised.

This service is then used to provide wrappers for glibc functions that
are not realtime-safe but do not always trigger a syscall. Such
functions may therefore be used by RT threads in primary mode for quite
a while without being detected via some Xenomai mode switch. Moreover,
some functions that go through the vsyscall page even to raise an
ordinary syscall may not allow proper stack backtraces, making it harder
to find their callers.

So far we provide wrappers (for use with the --wrap linker switch) for
malloc/free, gettimeofday and clock_gettime. Adding more (if there
are/will be more) is trivial.

Signed-off-by: Jan Kiszka <jan.kiszka@domain.hid>
---

 src/rtdk/Makefile.am      |    5 +-
 src/rtdk/assert_context.c |   97 +++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 100 insertions(+), 2 deletions(-)
 create mode 100644 src/rtdk/assert_context.c

diff --git a/src/rtdk/Makefile.am b/src/rtdk/Makefile.am
index cb80262..5b76b5d 100644
--- a/src/rtdk/Makefile.am
+++ b/src/rtdk/Makefile.am
@@ -1,10 +1,11 @@
 lib_LTLIBRARIES = librtdk.la
 
-librtdk_la_LDFLAGS = -version-info 0:0:0 -lpthread
+librtdk_la_LDFLAGS = -version-info 0:0:0 -lpthread -lrt
 
 librtdk_la_SOURCES = \
 	init.c \
-	rt_print.c
+	rt_print.c \
+	assert_context.c
 
 librtdk_la_CPPFLAGS = \
 	@XENO_USER_CFLAGS@ \
diff --git a/src/rtdk/assert_context.c b/src/rtdk/assert_context.c
new file mode 100644
index 0000000..e01fc93
--- /dev/null
+++ b/src/rtdk/assert_context.c
@@ -0,0 +1,97 @@
+/*
+ * Copyright (C) 2008 Jan Kiszka <jan.kiszka@domain.hid>.
+ *
+ * This library is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU Lesser General Public
+ * License as published by the Free Software Foundation; either
+ * version 2 of the License, or (at your option) any later version.
+ *
+ * This library is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * Lesser General Public License for more details.
+
+ * You should have received a copy of the GNU Lesser General Public
+ * License along with this library; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA.
+ */
+
+#include <signal.h>
+#include <stdlib.h>
+#include <time.h>
+#include <sys/time.h>
+
+#include <nucleus/thread.h>
+#include <asm-generic/syscall.h>
+#include <asm-generic/bits/current.h>
+
+void assert_nrt(void)
+{
+	xnthread_info_t info;
+	int err;
+
+	if (unlikely(xeno_get_current() != XN_NO_HANDLE &&
+		     !(xeno_get_current_mode() & XNRELAX))) {
+
+		err = XENOMAI_SYSCALL1(__xn_sys_current_info, &info);
+
+		if (err) {
+			fprintf(stderr, "__xn_sys_current_info failed: %s\n",
+				strerror(-err));
+			return;
+		}
+
+		if (info.state & XNTRAPSW)
+			pthread_kill(pthread_self(), SIGXCPU);
+	}
+}
+
+/* Memory allocation services */
+__attribute__ ((weak))
+void *__real_malloc(size_t size)
+{
+	return malloc(size);
+}
+
+void *__warp_malloc(size_t size)
+{
+	assert_nrt();
+	return __real_malloc(size);
+}
+
+__attribute__ ((weak))
+void __real_free(void *ptr)
+{
+	free(ptr);
+}
+
+void __warp_free(void *ptr)
+{
+	assert_nrt();
+	__real_free(ptr);
+}
+
+/* vsyscall-based services */
+__attribute__ ((weak))
+int __real_gettimeofday(struct timeval *tv, struct timezone *tz)
+{
+	return gettimeofday(tv, tz);
+}
+
+int __wrap_gettimeofday(struct timeval *tv, struct timezone *tz)
+{
+	assert_nrt();
+	return __real_gettimeofday(tv, tz);
+}
+
+__attribute__ ((weak))
+int __real_clock_gettime(clockid_t clk_id, struct timespec *tp)
+{
+	return clock_gettime(clk_id, tp);
+}
+
+int __wrap_clock_gettime(clockid_t clk_id, struct timespec *tp)
+{
+	assert_nrt();
+	return __real_clock_gettime(clk_id, tp);
+}

