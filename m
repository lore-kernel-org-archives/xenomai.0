Message-ID: <45D6C4BA.2030900@domain.hid>
Date: Sat, 17 Feb 2007 10:02:50 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig9CE870623C9B7CF7E0CE1ADE"
Sender: jan.kiszka@domain.hid
Subject: [Xenomai-core] [RFC][PATCH 2/2] examplary syscall instrumentation
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

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig9CE870623C9B7CF7E0CE1ADE
Content-Type: multipart/mixed; boundary="------------020401030001090403010100"

This is a multi-part message in MIME format.
--------------020401030001090403010100
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Based on librtprint, this is an attempt to unintrusively (/wrt timing)
instrument Xenomai syscalls inside the user space libs.

The support is compiled into the skin libs if --enable-debug was passed
to configure. To switch rt-syscall tracing on for an RT application, the
environment variable XNTRACE_SYS has to be defined (to whatever). Output
happens to stderr so far. Here is a demo trace of the rtprint example
from the previous patch:

> # XNTRACE_SYS=3D examples/native/rtprint
> [b7df36c0 Task 1] ENTER rt_task_shadow(task=3D0xbfd55aa8, name=3DTask 1=
, prio=3D10, mode=3D0x0)
> [b7df36c0 Task 1]  EXIT rt_task_shadow() =3D 0
> [b7df36c0 Task 1] ENTER rt_task_create(task=3D0xbfd55aa0, name=3DTask 2=
, stksize=3D0, prio=3D11, mode=3D0x0)
> [b7df36c0 Task 1]  EXIT rt_task_create() =3D 0
> [b7df36c0 Task 1] ENTER rt_task_start(task=3D0xbfd55aa0, entry=3D0x8048=
754, cookie=3D(nil))
> [b7f65b90 Task 2] ENTER rt_task_trampoline(cookie=3D(nil))
> This triggers auto-init of rt_print for the calling thread.
> A last switch to secondary mode can occure here, but future invocations=
 of rt_printf are safe.
> [b7f65b90 Task 2] ENTER rt_task_sleep(delay=3D3333333)
> [b7df36c0 Task 1]  EXIT rt_task_start() =3D 0
> [b7df36c0 Task 1] ENTER rt_task_sleep(delay=3D5000000)
> [b7f65b90 Task 2]  EXIT rt_task_sleep() =3D 0
> b7f65b90 Task 2: #1 Yet another RT printer - but to stderr.
> [b7f65b90 Task 2] ENTER rt_task_sleep(delay=3D3333333)
> [b7df36c0 Task 1]  EXIT rt_task_sleep() =3D 0
=2E..

Besides introducing the generic bits of rt-syscall tracing, this patch
also instruments very few functions of the native and the posix skin. As
I said earlier, full instrumentation like this requires a) a consensus
that we want this and b) quite some typing work which could luckily
happen step by step.

Yet further ideas to enhance this approach:
 o Time stamping based on cheap TSCs could be added.
 o A lib-internal handler for SIGXCHG could be installed, and the
   related mode switch signal could be forced on. That way the tracing
   back-end would become aware of switches from primary to secondary
   mode and could report this automatically.
 o Support to dump the trace to a file could be provided (already
   possibly via redirection "2>output-file", but may contain stderr
   stuff from the traced program).

OK, looking forward to any feedback.

Jan

--------------020401030001090403010100
Content-Type: text/x-patch;
 name="rtsystrace.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline;
 filename="rtsystrace.patch"

---
 configure.in                    |   20 ++++++++---
 include/asm-generic/Makefile.am |    2 -
 include/asm-generic/bits/bind.h |   12 +++++++
 include/asm-generic/usystrace.h |   59 +++++++++++++++++++++++++++++++++=
+
 src/skins/native/Makefile.am    |    2 -
 src/skins/native/init.c         |    3 +
 src/skins/native/task.c         |   68 ++++++++++++++++++++++++++++++++-=
-------
 src/skins/posix/Makefile.am     |    2 -
 src/skins/posix/clock.c         |   26 ++++++++++++---
 src/skins/posix/init.c          |    3 +
 src/skins/posix/mutex.c         |   21 +++++++++++-
 src/skins/posix/thread.c        |   15 ++++++--
 12 files changed, 200 insertions(+), 33 deletions(-)

Index: xenomai/configure.in
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- xenomai.orig/configure.in
+++ xenomai/configure.in
@@ -111,15 +111,22 @@ dnl
=20
 dnl Debug build (default: off)
=20
-debug_symbols=3D
-AC_MSG_CHECKING(for debug symbols)
+CONFIG_DEBUG=3D
+AC_MSG_CHECKING(for debug support)
 AC_ARG_ENABLE(debug,
 	AS_HELP_STRING([--enable-debug], [Enable debug support in nucleus and d=
ebug symbols in programs]),
 	[case "$enableval" in
-	y | yes) debug_symbols=3Dy ;;
-	*) unset debug_symbols ;;
+	y | yes) CONFIG_DEBUG=3Dy ;;
+	*) unset CONFIG_DEBUG ;;
 	esac])
-AC_MSG_RESULT(${debug_symbols:-no})
+AC_MSG_RESULT(${CONFIG_DEBUG:-no})
+
+if test x$CONFIG_DEBUG =3D xy ; then
+	SYSTRACE_LIB=3D"-L\$(top_builddir)/src/rtprint -lrtprint"
+else
+	unset SYSTRACE_LIB
+fi
+AC_SUBST(SYSTRACE_LIB)
=20
 dnl SMP support (default: off)
=20
@@ -419,6 +426,7 @@ dnl don't need to make particular cases=20
 dnl also be compiled in user-space libs.
 dnl
=20
+test x$CONFIG_DEBUG =3D xy && AC_DEFINE(CONFIG_DEBUG,1,[config])
 test x$CONFIG_XENO_X86_SEP =3D xy && AC_DEFINE(CONFIG_XENO_X86_SEP,1,[co=
nfig])
 test x$CONFIG_SMP =3D xy && AC_DEFINE(CONFIG_SMP,1,[config])
 test x$CONFIG_X86_TSC =3D xy && AC_DEFINE(CONFIG_X86_TSC,1,[config])
@@ -531,7 +539,7 @@ case $XENO_TARGET_ARCH in
         ;;
 esac
=20
-if test x$debug_symbols =3D xy; then
+if test x$CONFIG_DEBUG =3D xy; then
    XENO_USER_CFLAGS=3D"-g $XENO_USER_CFLAGS"
 else
    XENO_USER_CFLAGS=3D"-O2 $XENO_USER_CFLAGS"
Index: xenomai/include/asm-generic/Makefile.am
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- xenomai.orig/include/asm-generic/Makefile.am
+++ xenomai/include/asm-generic/Makefile.am
@@ -1,5 +1,5 @@
 includedir =3D $(prefix)/include/asm-generic
=20
-include_HEADERS =3D features.h hal.h syscall.h system.h wrappers.h
+include_HEADERS =3D features.h hal.h syscall.h system.h usystrace.h wrap=
pers.h
=20
 SUBDIRS =3D bits
Index: xenomai/include/asm-generic/bits/bind.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- xenomai.orig/include/asm-generic/bits/bind.h
+++ xenomai/include/asm-generic/bits/bind.h
@@ -8,6 +8,10 @@
 #include <signal.h>
 #include <asm/xenomai/syscall.h>
=20
+#ifdef CONFIG_DEBUG
+int __xeno_systrace;
+#endif /* CONFIG_DEBUG */
+
 void xeno_handle_mlock_alert(int sig);
=20
 static inline int
@@ -21,6 +25,10 @@ xeno_bind_skin(unsigned skin_magic, cons
 	xeno_arch_features_check();
 #endif /* xeno_arch_features_check */
=20
+#ifdef CONFIG_DEBUG
+	__xeno_systrace =3D !!getenv("XNTRACE_SYS");
+#endif /* CONFIG_DEBUG */
+
 	muxid =3D XENOMAI_SYSBIND(skin_magic,
 				XENOMAI_FEAT_DEP, XENOMAI_ABI_REV, &finfo);
 	switch (muxid) {
@@ -75,6 +83,10 @@ xeno_bind_skin_opt(unsigned skin_magic,=20
 	xeno_arch_features_check();
 #endif /* xeno_arch_features_check */
=20
+#ifdef CONFIG_DEBUG
+	__xeno_systrace =3D !!getenv("XNTRACE_SYS");
+#endif /* CONFIG_DEBUG */
+
 	muxid =3D XENOMAI_SYSBIND(skin_magic,
 				XENOMAI_FEAT_DEP, XENOMAI_ABI_REV, &finfo);
 	switch (muxid) {
Index: xenomai/include/asm-generic/usystrace.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- /dev/null
+++ xenomai/include/asm-generic/usystrace.h
@@ -0,0 +1,59 @@
+/*
+ * Copyright (C) 2007 Jan Kiszka <jan.kiszka@domain.hid>.
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
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307 =
 USA.
+ */
+
+#ifndef _XENO_ASM_GENERIC_USYSTRACE_H
+#define _XENO_ASM_GENERIC_USYSTRACE_H
+
+#include <xeno_config.h>
+#include <rtprint.h>
+
+#define SYSTRACE_VOID				"<void>"
+
+#define systrace_str(string)			(string) ? string : "(nil)"
+
+#ifdef CONFIG_DEBUG
+
+extern int __xeno_systrace;
+
+#define systrace_init()				rt_print_auto_init(1)
+#define systrace_init_thread(name)		rt_print_init(0, name)
+
+#define systrace_enter(func, arg_format, ...) \
+do { \
+	if (__xeno_systrace) \
+		rt_fprintf(stderr, "[%s] ENTER %s(" arg_format ")\n", \
+			   rt_print_buffer_name(), func, ##__VA_ARGS__); \
+} while (0)
+
+#define systrace_exit(func, ret_format, ...) \
+do { \
+	if (__xeno_systrace) \
+		rt_fprintf(stderr, "[%s]  EXIT %s() =3D " ret_format "\n", \
+			   rt_print_buffer_name(), func, ##__VA_ARGS__); \
+} while (0)
+
+#else /* !CONFIG_DEBUG */
+
+#define systrace_init()				do { } while (0)
+#define systrace_init_thread(name)		do { } while (0)
+#define systrace_enter(func, arg_format, ...)	do { } while (0)
+#define systrace_exit(func, ret_format, ...)	do { } while (0)
+
+#endif /* !CONFIG_DEBUG */
+
+#endif /* !_XENO_ASM_GENERIC_USYSTRACE_H */
Index: xenomai/src/skins/native/Makefile.am
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- xenomai.orig/src/skins/native/Makefile.am
+++ xenomai/src/skins/native/Makefile.am
@@ -1,6 +1,6 @@
 lib_LTLIBRARIES =3D libnative.la
=20
-libnative_la_LDFLAGS =3D -version-info 0:0:0 -lpthread
+libnative_la_LDFLAGS =3D -version-info 0:0:0 -lpthread @SYSTRACE_LIB@
=20
 libnative_la_SOURCES =3D \
 	alarm.c \
Index: xenomai/src/skins/native/init.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- xenomai.orig/src/skins/native/init.c
+++ xenomai/src/skins/native/init.c
@@ -26,6 +26,7 @@
 #include <native/task.h>
 #include <asm-generic/bits/bind.h>
 #include <asm-generic/bits/mlock_alert.h>
+#include <asm-generic/usystrace.h>
=20
 pthread_key_t __native_tskey;
=20
@@ -49,4 +50,6 @@ void __init_xeno_interface(void)
 		fprintf(stderr, "Xenomai: failed to allocate new TSD key?!\n");
 		exit(1);
 	}
+
+	systrace_init();
 }
Index: xenomai/src/skins/native/task.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- xenomai.orig/src/skins/native/task.c
+++ xenomai/src/skins/native/task.c
@@ -26,6 +26,7 @@
 #include <limits.h>
 #include <native/syscall.h>
 #include <native/task.h>
+#include <asm-generic/usystrace.h>
=20
 extern pthread_key_t __native_tskey;
=20
@@ -54,6 +55,8 @@ static void *rt_task_trampoline(void *co
 	struct rt_arg_bulk bulk;
 	long err;
=20
+	systrace_init_thread(iargs->name);
+
 	if (iargs->prio > 0) {
 		/* Ok, this looks like weird, but we need this. */
 		param.sched_priority =3D sched_get_priority_max(SCHED_FIFO);
@@ -85,8 +88,11 @@ static void *rt_task_trampoline(void *co
 		err =3D XENOMAI_SYSCALL2(__xn_sys_barrier, &entry, &cookie);
 	while (err =3D=3D -EINTR);
=20
-	if (!err)
+	if (!err) {
+		systrace_enter(__FUNCTION__, "cookie=3D%p", cookie);
 		entry(cookie);
+		systrace_exit(__FUNCTION__, SYSTRACE_VOID);
+	}
=20
       fail:
=20
@@ -103,6 +109,10 @@ int rt_task_create(RT_TASK *task,
 	pthread_t thid;
 	int err;
=20
+	systrace_enter(__FUNCTION__, "task=3D%p, name=3D%s, stksize=3D%d, "
+		       "prio=3D%d, mode=3D0x%x", task, systrace_str(name),
+		       stksize, prio, mode);
+
 	/* Migrate this thread to the Linux domain since we are about to
 	   issue a series of regular kernel syscalls in order to create
 	   the new Linux thread, which in turn will be mapped to a
@@ -135,24 +145,39 @@ int rt_task_create(RT_TASK *task,
 	}
 	pthread_attr_setschedparam(&thattr, &param);
=20
-	err =3D pthread_create(&thid, &thattr, &rt_task_trampoline, &iargs);
+	err =3D -pthread_create(&thid, &thattr, &rt_task_trampoline, &iargs);
=20
-	if (err)
-		return -err;
+	if (!err) {
+		/* Wait for sync with rt_task_trampoline() */
+		err =3D XENOMAI_SYSCALL1(__xn_sys_completion, &completion);
+	}
=20
-	/* Wait for sync with rt_task_trampoline() */
-	return XENOMAI_SYSCALL1(__xn_sys_completion, &completion);
+	systrace_exit(__FUNCTION__, "%d", err);
+	return err;
 }
=20
 int rt_task_start(RT_TASK *task, void (*entry) (void *cookie), void *coo=
kie)
 {
-	return XENOMAI_SKINCALL3(__native_muxid,
-				 __native_task_start, task, entry, cookie);
+	int err;
+
+	systrace_enter(__FUNCTION__, "task=3D%p, entry=3D%p, cookie=3D%p",
+		       task, entry, cookie);
+
+	err =3D XENOMAI_SKINCALL3(__native_muxid,
+				__native_task_start, task, entry, cookie);
+
+	systrace_exit(__FUNCTION__, "%d", err);
+	return err;
 }
=20
 int rt_task_shadow(RT_TASK *task, const char *name, int prio, int mode)
 {
 	struct rt_arg_bulk bulk;
+	int err;
+
+	systrace_init_thread(name);
+	systrace_enter(__FUNCTION__, "task=3D%p, name=3D%s, prio=3D%d, mode=3D0=
x%x",
+		       task, systrace_str(name), prio, mode);
=20
 	/* rt_task_delete requires asynchronous cancellation */
 	pthread_setcanceltype(PTHREAD_CANCEL_ASYNCHRONOUS, NULL);
@@ -165,8 +190,11 @@ int rt_task_shadow(RT_TASK *task, const=20
 	bulk.a4 =3D (u_long)mode;
 	bulk.a5 =3D (u_long)pthread_self();
=20
-	return XENOMAI_SKINCALL2(__native_muxid, __native_task_create, &bulk,
-				 NULL);
+	err =3D XENOMAI_SKINCALL2(__native_muxid, __native_task_create, &bulk,
+				NULL);
+
+	systrace_exit(__FUNCTION__, "%d", err);
+	return err;
 }
=20
 int rt_task_bind(RT_TASK *task, const char *name, RTIME timeout)
@@ -216,8 +244,16 @@ int rt_task_set_periodic(RT_TASK *task,=20
=20
 int rt_task_wait_period(unsigned long *overruns_r)
 {
-	return XENOMAI_SKINCALL1(__native_muxid,
-				 __native_task_wait_period, overruns_r);
+	int err;
+
+	systrace_enter(__FUNCTION__, "overruns_r=3D%p", overruns_r);
+
+	err =3D XENOMAI_SKINCALL1(__native_muxid,
+				__native_task_wait_period, overruns_r);
+
+	systrace_exit(__FUNCTION__, "%d, *overruns_r=3D%d", err,
+		      (overruns_r) ? *overruns_r : 0);
+	return err;
 }
=20
 int rt_task_set_priority(RT_TASK *task, int prio)
@@ -228,8 +264,14 @@ int rt_task_set_priority(RT_TASK *task,=20
=20
 int rt_task_sleep(RTIME delay)
 {
-	return XENOMAI_SKINCALL1(__native_muxid, __native_task_sleep, &delay);
+	int err;
=20
+	systrace_enter(__FUNCTION__, "delay=3D%llu", delay);
+
+	err =3D XENOMAI_SKINCALL1(__native_muxid, __native_task_sleep, &delay);=

+
+	systrace_exit(__FUNCTION__, "%d", err);
+	return err;
 }
=20
 int rt_task_sleep_until(RTIME date)
Index: xenomai/src/skins/posix/Makefile.am
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- xenomai.orig/src/skins/posix/Makefile.am
+++ xenomai/src/skins/posix/Makefile.am
@@ -2,7 +2,7 @@ includedir =3D $(prefix)/include/posix
=20
 lib_LTLIBRARIES =3D libpthread_rt.la
=20
-libpthread_rt_la_LDFLAGS =3D -version-info 0:0:0 -lpthread
+libpthread_rt_la_LDFLAGS =3D -version-info 0:0:0 -lpthread @SYSTRACE_LIB=
@
=20
 libpthread_rt_la_SOURCES =3D \
 	init.c \
Index: xenomai/src/skins/posix/clock.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- xenomai.orig/src/skins/posix/clock.c
+++ xenomai/src/skins/posix/clock.c
@@ -20,6 +20,7 @@
 #include <pthread.h>		/* For pthread_setcanceltype. */
 #include <posix/syscall.h>
 #include <time.h>
+#include <asm-generic/xenomai/usystrace.h>
=20
 extern int __pse51_muxid;
=20
@@ -39,15 +40,22 @@ int __wrap_clock_getres(clockid_t clock_
=20
 int __wrap_clock_gettime(clockid_t clock_id, struct timespec *tp)
 {
-	int err =3D -XENOMAI_SKINCALL2(__pse51_muxid,
-				     __pse51_clock_gettime,
-				     clock_id,
-				     tp);
+	int err;
+
+	systrace_enter("clock_gettime", "clock_id=3D%d, tp=3D%p", clock_id, tp)=
;
+
+	err =3D XENOMAI_SKINCALL2(__pse51_muxid,
+				 __pse51_clock_gettime,
+				 clock_id,
+				 tp);
+
+	systrace_exit("clock_gettime", "%d, tp=3D{%d, %d}", err,
+		      tp ? tp->tv_sec : 0, tp ? tp->tv_nsec : 0);
=20
 	if (!err)
 		return 0;
=20
-	errno =3D err;
+	errno =3D -err;
 	return -1;
 }
=20
@@ -71,6 +79,11 @@ int __wrap_clock_nanosleep(clockid_t clo
 {
 	int err, oldtype;
=20
+	systrace_enter("clock_nanosleep", "clock_id=3D%d, flags=3D0x%x, "
+		       "rqtp=3D%p {%d, %d}, rmtp=3D%p", clock_id, flags, rqtp,
+		       rqtp ? rqtp->tv_sec : 0, rqtp ? rqtp->tv_nsec : 0,
+		       rmtp);
+
 	pthread_setcanceltype(PTHREAD_CANCEL_ASYNCHRONOUS, &oldtype);
=20
 	err =3D -XENOMAI_SKINCALL4(__pse51_muxid,
@@ -79,6 +92,9 @@ int __wrap_clock_nanosleep(clockid_t clo
=20
 	pthread_setcanceltype(oldtype, NULL);
=20
+	systrace_exit("clock_nanosleep", "%d, rmtp=3D{%d, %d}", err,
+		      rmtp ? rmtp->tv_sec : 0, rmtp ? rmtp->tv_nsec : 0);
+
 	return err;
 }
=20
Index: xenomai/src/skins/posix/init.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- xenomai.orig/src/skins/posix/init.c
+++ xenomai/src/skins/posix/init.c
@@ -28,6 +28,7 @@
 #include <rtdm/syscall.h>
 #include <asm-generic/bits/bind.h>
 #include <asm-generic/bits/mlock_alert.h>
+#include <asm-generic/xenomai/usystrace.h>
=20
 int __pse51_muxid =3D -1;
 int __rtdm_muxid =3D -1;
@@ -85,4 +86,6 @@ void __init_posix_interface(void)
 		}
 		fork_handler_registered =3D 1;
 	}
+
+	systrace_init();
 }
Index: xenomai/src/skins/posix/mutex.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- xenomai.orig/src/skins/posix/mutex.c
+++ xenomai/src/skins/posix/mutex.c
@@ -19,6 +19,7 @@
 #include <errno.h>
 #include <posix/syscall.h>
 #include <pthread.h>
+#include <asm-generic/xenomai/usystrace.h>
=20
 extern int __pse51_muxid;
=20
@@ -97,12 +98,16 @@ int __wrap_pthread_mutex_lock(pthread_mu
 	union __xeno_mutex *_mutex =3D (union __xeno_mutex *)mutex;
 	int err;
=20
+	systrace_enter("pthread_mutex_lock", "mutex=3D%p", mutex);
+
 	do {
 		err =3D XENOMAI_SKINCALL1(__pse51_muxid,
 					__pse51_mutex_lock,
 					&_mutex->shadow_mutex);
 	} while (err =3D=3D -EINTR);
=20
+	systrace_exit("pthread_mutex_lock", "%d", -err);
+
 	return -err;
 }
=20
@@ -112,12 +117,17 @@ int __wrap_pthread_mutex_timedlock(pthre
 	union __xeno_mutex *_mutex =3D (union __xeno_mutex *)mutex;
 	int err;
=20
+	systrace_enter("pthread_mutex_timedlock", "mutex=3D%p, to=3D%p {%d, %d}=
",
+		       mutex, to, to ? to->tv_sec : 0, to ? to->tv_nsec : 0);
+
 	do {
 		err =3D XENOMAI_SKINCALL2(__pse51_muxid,
 					__pse51_mutex_timedlock,
 					&_mutex->shadow_mutex, to);
 	} while (err =3D=3D -EINTR);
=20
+	systrace_exit("pthread_mutex_timedlock", "%d", -err);
+
 	return -err;
 }
=20
@@ -132,7 +142,14 @@ int __wrap_pthread_mutex_trylock(pthread
 int __wrap_pthread_mutex_unlock(pthread_mutex_t * mutex)
 {
 	union __xeno_mutex *_mutex =3D (union __xeno_mutex *)mutex;
+	int err;
=20
-	return -XENOMAI_SKINCALL1(__pse51_muxid,
-				  __pse51_mutex_unlock, &_mutex->shadow_mutex);
+	systrace_enter("pthread_mutex_unlock", "mutex=3D%p", mutex);
+
+	err =3D -XENOMAI_SKINCALL1(__pse51_muxid,
+				 __pse51_mutex_unlock, &_mutex->shadow_mutex);
+
+	systrace_exit("pthread_mutex_unlock", "%d", err);
+
+	return err;
 }
Index: xenomai/src/skins/posix/thread.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- xenomai.orig/src/skins/posix/thread.c
+++ xenomai/src/skins/posix/thread.c
@@ -22,6 +22,7 @@
 #include <pthread.h>
 #include <semaphore.h>
 #include <posix/syscall.h>
+#include <asm-generic/xenomai/usystrace.h>
=20
 extern int __pse51_muxid;
=20
@@ -36,18 +37,22 @@ int __wrap_pthread_setschedparam(pthread
 	pthread_t myself =3D pthread_self();
 	int err, promoted;
=20
+	systrace_enter("pthread_setschedparam", "pthread=3D%p, policy=3D%d, "
+		       "param=3D%p {%d}", thread, policy, param,
+		       param ? param->sched_priority : 0);
+
 	err =3D -XENOMAI_SKINCALL5(__pse51_muxid,
 				 __pse51_thread_setschedparam,
 				 thread, policy, param, myself, &promoted);
=20
-	if (err =3D=3D EPERM)
-		return __real_pthread_setschedparam(thread, policy, param);
-
 	if (!err && promoted) {
 		signal(SIGHARDEN, &__pthread_sigharden_handler);
 		if (policy !=3D SCHED_OTHER)
 			XENOMAI_SYSCALL1(__xn_sys_migrate, XENOMAI_XENO_DOMAIN);
-	}
+	} else if (err =3D=3D EPERM)
+		err =3D __real_pthread_setschedparam(thread, policy, param);
+
+	systrace_exit("pthread_setschedparam", "%d%", err);
=20
 	return err;
 }
@@ -114,7 +119,9 @@ static void *__pthread_trampoline(void *
 	if (!err) {
 		if (policy !=3D SCHED_OTHER)
 			XENOMAI_SYSCALL1(__xn_sys_migrate, XENOMAI_XENO_DOMAIN);
+		systrace_enter("pthread_trampoline", "cookie=3D%p", cookie);
 		status =3D start(cookie);
+		systrace_exit("pthread_trampoline", "%p", status);
 	} else
 		status =3D (void *)-err;
=20


--------------020401030001090403010100--

--------------enig9CE870623C9B7CF7E0CE1ADE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iD8DBQFF1sS6niDOoMHTA+kRAj9PAKCA1oN1xgAKd8ugGC04sJQPJ9HD4gCggjV1
BsmahJkkZsJyX6PhbmPg1WQ=
=8yrG
-----END PGP SIGNATURE-----

--------------enig9CE870623C9B7CF7E0CE1ADE--

