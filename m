Message-ID: <449A76D0.30800@domain.hid>
Date: Thu, 22 Jun 2006 12:54:08 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigB20F919D08EF32D84BE8EB1F"
Sender: jan.kiszka@domain.hid
Subject: [Xenomai-core] [PATCH] provide ipipe_traceing via nucleus interface
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
--------------enigB20F919D08EF32D84BE8EB1F
Content-Type: multipart/mixed; boundary="------------020203080109040103070408"

This is a multi-part message in MIME format.
--------------020203080109040103070408
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi,

having to load xeno_timerbench and to open its device just for
triggering the I-pipe tracer was not a smart decision of mine. This
patch makes is more comfortable to call the tracer from user space.

The latency test still traces fine, but cyclic suffers from some likely
unrelated problem on my box (doesn't run at all, no xeno-thread except
the main one) - needs a closer look later.

Jan


PS: I realised that rttesting.h and the related devices are not yet
cleanly structured with respect to the RTDM profile idea (timer
benchmark and switch test devices have no interface in common). I'm
currently considering to merge all tests into a single device (maybe
using multiple source files), also reducing the complexity for the test
user. Comments are welcome.

--------------020203080109040103070408
Content-Type: text/x-patch;
 name="xn_sys_ipipe_trace.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline;
 filename="xn_sys_ipipe_trace.patch"

Index: include/asm-generic/syscall.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- include/asm-generic/syscall.h	(Revision 1252)
+++ include/asm-generic/syscall.h	(Arbeitskopie)
@@ -30,6 +30,13 @@
 #define __xn_sys_info       4	/* xnshadow_get_info(muxid,&info) */
 #define __xn_sys_arch       5	/* r =3D xnarch_local_syscall(args) */
=20
+#define __xn_sys_trace_begin    6   /* ipipe_trace_begin(v) */
+#define __xn_sys_trace_end      7   /* ipipe_trace_end(v) */
+#define __xn_sys_trace_freeze   8   /* ipipe_trace_freeze(v) */
+#define __xn_sys_trace_specl    9   /* ipipe_trace_special(special_id, v=
) */
+#define __xn_sys_trace_mreset   10  /* ipipe_trace_max_reset() */
+#define __xn_sys_trace_freset   11  /* ipipe_trace_frozen_reset() */
+
 #define XENOMAI_LINUX_DOMAIN  0
 #define XENOMAI_XENO_DOMAIN   1
=20
Index: include/rtdm/rttesting.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- include/rtdm/rttesting.h	(Revision 1252)
+++ include/rtdm/rttesting.h	(Arbeitskopie)
@@ -1,6 +1,6 @@
 /**
  * @file
- * Real-Time Driver Model for Xenomai, benchmark device profile header
+ * Real-Time Driver Model for Xenomai, testing device profile header
  *
  * @note Copyright (C) 2005 Jan Kiszka <jan.kiszka@domain.hid>
  *
@@ -18,16 +18,16 @@
  * along with Xenomai; if not, write to the Free Software Foundation,
  * Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.
  *
- * @ingroup rtbenchmark
+ * @ingroup rttesting
  */
=20
 /*!
  * @ingroup profiles
- * @defgroup rtbenchmark Timer benchmark Device
+ * @defgroup rttesting Testing Device
  *
- * This group of devices is intended to provide in-kernel benchmark resu=
lts.
+ * This group of devices is intended to provide in-kernel testing result=
s.
  * Feel free to comment on this profile via the Xenomai mailing list
- * (Xenomai-help@domain.hid) or directly to the author (jan.kiszka@domain.hid).=
 @n
+ * (xenomai@xenomai.org) or directly to the author (jan.kiszka@domain.hid).=
 @n
  * @n
  *
  * @par Device Characteristics
@@ -91,11 +91,6 @@ typedef struct rtbnch_overall_result {
     long                    *histogram_max;
 } rtbnch_overall_result_t;
=20
-typedef struct rtbnch_trace_special {
-    unsigned char           id;
-    long                    v;
-} rtbnch_trace_special_t;
-
=20
 #define RTIOC_TYPE_BENCHMARK        RTDM_CLASS_TESTING
=20
@@ -120,24 +115,6 @@ typedef struct rtbnch_trace_special {
=20
 #define RTBNCH_RTIOC_STOP_TMTEST        \
     _IOWR(RTIOC_TYPE_BENCHMARK, 0x11, struct rtbnch_overall_result)
-
-#define RTBNCH_RTIOC_BEGIN_TRACE        \
-    _IOW(RTIOC_TYPE_BENCHMARK, 0x20, long)
-
-#define RTBNCH_RTIOC_END_TRACE          \
-    _IOW(RTIOC_TYPE_BENCHMARK, 0x21, long)
-
-#define RTBNCH_RTIOC_FREEZE_TRACE       \
-    _IOW(RTIOC_TYPE_BENCHMARK, 0x22, long)
-
-#define RTBNCH_RTIOC_REFREEZE_TRACE     \
-    _IOW(RTIOC_TYPE_BENCHMARK, 0x23, long)
-
-#define RTBNCH_RTIOC_SPECIAL_TRACE      \
-    _IOW(RTIOC_TYPE_BENCHMARK, 0x24, unsigned char)
-
-#define RTBNCH_RTIOC_SPECIAL_TRACE_EX   \
-    _IOW(RTIOC_TYPE_BENCHMARK, 0x25, struct rtbnch_trace_special)
 /** @} */
=20
=20
Index: include/nucleus/ipipe_trace.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- include/nucleus/ipipe_trace.h	(Revision 0)
+++ include/nucleus/ipipe_trace.h	(Revision 0)
@@ -0,0 +1,82 @@
+/*
+ * Copyright (C) 2006 Jan Kiszka <jan.kiszka@domain.hid>.
+ *
+ * Xenomai is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published
+ * by the Free Software Foundation; either version 2 of the License,
+ * or (at your option) any later version.
+ *
+ * Xenomai is distributed in the hope that it will be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with Xenomai; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA
+ * 02111-1307, USA.
+ *
+ * User space interface to the I-pipe tracer.
+ */
+
+#ifndef _XENO_NUCLEUS_IPIPE_TRACE_H
+#define _XENO_NUCLEUS_IPIPE_TRACE_H
+
+#ifndef __XENO_SIM__
+#include <asm/xenomai/syscall.h>
+#endif /* __XENO_SIM__ */
+
+#ifdef __KERNEL__
+
+#ifdef __cplusplus
+extern "C" {
+#endif
+
+#ifdef CONFIG_IPIPE_TRACE
+#include <linux/ipipe_trace.h>
+#endif /* CONFIG_IPIPE_TRACE */
+
+#ifdef __cplusplus
+}
+#endif
+
+#elif !defined(__XENO_SIM__)
+
+static inline void ipipe_trace_begin(unsigned long v)
+{
+    XENOMAI_SYSCALL1(__xn_sys_trace_begin, v);
+}
+
+static inline void ipipe_trace_end(unsigned long v)
+{
+    XENOMAI_SYSCALL1(__xn_sys_trace_end, v);
+}
+
+static inline void ipipe_trace_freeze(unsigned long v)
+{
+    XENOMAI_SYSCALL1(__xn_sys_trace_freeze, v);
+}
+
+static inline void ipipe_trace_special(unsigned char special_id, unsigne=
d long v)
+{
+    XENOMAI_SYSCALL2(__xn_sys_trace_specl, special_id, v);
+}
+
+static inline int ipipe_trace_max_reset(void)
+{
+    return XENOMAI_SYSCALL0(__xn_sys_trace_mreset);
+}
+
+static inline int ipipe_trace_frozen_reset(void)
+{
+    return XENOMAI_SYSCALL0(__xn_sys_trace_freset);
+}
+
+#endif /* __KERNEL__ */
+
+#define ipipe_trace_refreeze(v) do { \
+    ipipe_trace_frozen_reset(); \
+    ipipe_trace_freeze(v); \
+} while (0)
+
+#endif /* !_XENO_NUCLEUS_IPIPE_TRACE_H */
Index: src/testsuite/latency/latency.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- src/testsuite/latency/latency.c	(Revision 1252)
+++ src/testsuite/latency/latency.c	(Arbeitskopie)
@@ -12,6 +12,7 @@
 #include <native/timer.h>
 #include <native/sem.h>
 #include <rtdm/rttesting.h>
+#include <nucleus/ipipe_trace.h>
=20
 RT_TASK latency_task, display_task;
=20
@@ -130,8 +131,7 @@ void latency (void *cookie)
=20
             if (freeze_max && (dt > gmaxjitter) && !(finished || warmup)=
)
                 {
-                rt_dev_ioctl(benchdev, RTBNCH_RTIOC_REFREEZE_TRACE,
-                             rt_timer_tsc2ns(dt));
+                ipipe_trace_refreeze(rt_timer_tsc2ns(dt));
                 gmaxjitter =3D dt;
                 }
=20
@@ -545,7 +545,7 @@ int main (int argc, char **argv)
=20
     mlockall(MCL_CURRENT|MCL_FUTURE);
=20
-    if ((test_mode !=3D USER_TASK) || freeze_max)
+    if (test_mode !=3D USER_TASK)
         {
         char devname[RTDM_MAX_DEVNAME_LEN];
=20
Index: src/testsuite/cyclic/cyclictest.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- src/testsuite/cyclic/cyclictest.c	(Revision 1252)
+++ src/testsuite/cyclic/cyclictest.c	(Arbeitskopie)
@@ -36,7 +36,7 @@
 #include <sys/mman.h>
=20
 #if IPIPE_TRACE
-#include <rtdm/rttesting.h>
+#include <nucleus/ipipe_trace.h>
 #endif
=20
 /* Ugly, but .... */
@@ -93,11 +93,6 @@ struct thread_stat {
 static int test_shutdown;
 static int tracelimit =3D 100000;
 static struct timespec start;
-#if IPIPE_TRACE
-static int benchdev =3D -1;
-#else
-#define benchdev -1
-#endif
=20
 static inline void tsnorm(struct timespec *ts)
 {
@@ -266,7 +261,7 @@ void *timerthread(void *param)
 			stat->max =3D diff;
 #if IPIPE_TRACE
 			if (stat->traced)
-				ioctl(benchdev, RTBNCH_RTIOC_REFREEZE_TRACE, diff);
+				ipipe_trace_refreeze(diff);
 #endif
 		}
=20
@@ -411,9 +406,6 @@ static void process_options (int argc, c
=20
 static void sighand(int sig)
 {
-#if IPIPE_TRACE
-	close(benchdev);
-#endif
 	test_shutdown =3D 1;
 }
=20
@@ -469,10 +461,6 @@ int main(int argc, char **argv)
 	if (!stat)
 		goto outpar;
=20
-#if IPIPE_TRACE
-	benchdev =3D open("rtbenchmark0", O_RDWR);
-#endif
-
 	clock_gettime(clocksources[clocksel], &start);
=20
 	for (i =3D 0; i < num_threads; i++) {
@@ -500,7 +488,7 @@ int main(int argc, char **argv)
 		pthread_attr_setstacksize(&thattr, 131072);
 		pthread_create(&stat[i].thread, &thattr, timerthread, &par[i]);
 		stat[i].threadstarted =3D 1;
-		stat[i].traced =3D (i =3D=3D 0 && benchdev >=3D 0);
+		stat[i].traced =3D (i =3D=3D 0 && IPIPE_TRACE > 0);
 	}
 =09
 	while (!test_shutdown) {
Index: ksrc/drivers/testing/timerbench.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- ksrc/drivers/testing/timerbench.c	(Revision 1252)
+++ ksrc/drivers/testing/timerbench.c	(Arbeitskopie)
@@ -232,55 +232,6 @@ int rt_tmbench_close(struct rtdm_dev_con
 }
=20
=20
-#ifdef CONFIG_IPIPE_TRACE
-int tracer_ioctl(int request, rtdm_user_info_t *user_info, void *arg)
-{
-    switch (request) {
-        case RTBNCH_RTIOC_BEGIN_TRACE:
-            ipipe_trace_begin((long)arg);
-            break;
-
-        case RTBNCH_RTIOC_END_TRACE:
-            ipipe_trace_end((long)arg);
-            break;
-
-        case RTBNCH_RTIOC_REFREEZE_TRACE:
-            ipipe_trace_frozen_reset();
-            /* fall through */
-
-        case RTBNCH_RTIOC_FREEZE_TRACE:
-            ipipe_trace_freeze((long)arg);
-            break;
-
-        case RTBNCH_RTIOC_SPECIAL_TRACE:
-            ipipe_trace_special((long)arg, 0);
-            break;
-
-        case RTBNCH_RTIOC_SPECIAL_TRACE_EX: {
-            struct rtbnch_trace_special special;
-
-            if (user_info) {
-                if (!rtdm_read_user_ok(user_info, arg,
-                                       sizeof(struct rtbnch_trace_specia=
l)) ||
-                    rtdm_copy_from_user(user_info, &special, arg,
-                                        sizeof(struct rtbnch_trace_speci=
al)))
-                    return 0;
-            } else
-                special =3D *(struct rtbnch_trace_special *)arg;
-            ipipe_trace_special(special.id, special.v);
-            break;
-        }
-
-        default:
-            return 0;
-    }
-    return 1;
-}
-#else /* !CONFIG_IPIPE_TRACE */
-#define tracer_ioctl(request, user_info, arg)   (0)
-#endif /* CONFIG_IPIPE_TRACE */
-
-
 int rt_tmbench_ioctl_nrt(struct rtdm_dev_context *context,
                          rtdm_user_info_t *user_info, int request, void =
*arg)
 {
@@ -288,9 +239,6 @@ int rt_tmbench_ioctl_nrt(struct rtdm_dev
     int                         ret =3D 0;
=20
=20
-    if (tracer_ioctl(request, user_info, arg))
-        return 0;
-
     ctx =3D (struct rt_tmbench_context *)context->dev_private;
=20
     switch (request) {
@@ -475,9 +423,6 @@ int rt_tmbench_ioctl_rt(struct rtdm_dev_
     int                         ret =3D 0;
=20
=20
-    if (tracer_ioctl(request, user_info, arg))
-        return 0;
-
     ctx =3D (struct rt_tmbench_context *)context->dev_private;
=20
     switch (request) {
Index: ksrc/nucleus/shadow.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- ksrc/nucleus/shadow.c	(Revision 1252)
+++ ksrc/nucleus/shadow.c	(Arbeitskopie)
@@ -1261,6 +1261,48 @@ static int xnshadow_sys_barrier(struct t
 	return xnshadow_wait_barrier(regs);
 }
=20
+#ifdef CONFIG_IPIPE_TRACE
+static int notrace xnshadow_sys_trace_begin(struct task_struct *curr,
+					    struct pt_regs *regs)
+{
+	ipipe_trace_begin(__xn_reg_arg1(regs));
+	return 0;
+}
+
+static int notrace xnshadow_sys_trace_end(struct task_struct *curr,
+					  struct pt_regs *regs)
+{
+	ipipe_trace_end(__xn_reg_arg1(regs));
+	return 0;
+}
+
+static int notrace xnshadow_sys_trace_freeze(struct task_struct *curr,
+					     struct pt_regs *regs)
+{
+	ipipe_trace_freeze(__xn_reg_arg1(regs));
+	return 0;
+}
+
+static int notrace xnshadow_sys_trace_special(struct task_struct *curr,
+					      struct pt_regs *regs)
+{
+	ipipe_trace_special(__xn_reg_arg1(regs), __xn_reg_arg2(regs));
+	return 0;
+}
+
+static int notrace xnshadow_sys_trace_mreset(struct task_struct *curr,
+					     struct pt_regs *regs)
+{
+	return ipipe_trace_max_reset();
+}
+
+static int notrace xnshadow_sys_trace_freset(struct task_struct *curr,
+					     struct pt_regs *regs)
+{
+	return ipipe_trace_frozen_reset();
+}
+#endif /* CONFIG_IPIPE_TRACE */
+
 static xnsysent_t xnshadow_systab[] =3D {
 	[__xn_sys_migrate] =3D {&xnshadow_sys_migrate, __xn_exec_current},
 	[__xn_sys_arch] =3D {&xnshadow_sys_arch, __xn_exec_any},
@@ -1268,6 +1310,17 @@ static xnsysent_t xnshadow_systab[] =3D {
 	[__xn_sys_info] =3D {&xnshadow_sys_info, __xn_exec_lostage},
 	[__xn_sys_completion] =3D {&xnshadow_sys_completion, __xn_exec_lostage}=
,
 	[__xn_sys_barrier] =3D {&xnshadow_sys_barrier, __xn_exec_lostage},
+#ifdef CONFIG_IPIPE_TRACE
+	[__xn_sys_trace_begin] =3D {&xnshadow_sys_trace_begin, __xn_exec_any},
+	[__xn_sys_trace_end] =3D {&xnshadow_sys_trace_end, __xn_exec_any},
+	[__xn_sys_trace_freeze] =3D {&xnshadow_sys_trace_freeze, __xn_exec_any}=
,
+	[__xn_sys_trace_specl] =3D {&xnshadow_sys_trace_special, __xn_exec_any}=
,
+	[__xn_sys_trace_mreset] =3D {&xnshadow_sys_trace_mreset, __xn_exec_any}=
,
+	[__xn_sys_trace_freset] =3D {&xnshadow_sys_trace_freset, __xn_exec_any}=
,
+#else /* !CONFIG_IPIPE_TRACE */
+	/* has to be filled up with an ENOSYS returning handler once further
+	   syscalls follow */
+#endif /* CONFIG_IPIPE_TRACE */
 };
=20
 static inline int substitute_linux_syscall(struct task_struct *curr,

--------------020203080109040103070408--

--------------enigB20F919D08EF32D84BE8EB1F
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iD8DBQFEmnbQniDOoMHTA+kRAizgAJ0e3gSZmjZpieTGqvBes8zNnRrK8ACbByAo
1Mr28qAaxzJMjLQocseKOs4=
=F4nj
-----END PGP SIGNATURE-----

--------------enigB20F919D08EF32D84BE8EB1F--

