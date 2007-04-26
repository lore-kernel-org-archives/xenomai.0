Message-ID: <4630B46C.9050809@domain.hid>
Date: Thu, 26 Apr 2007 16:17:16 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <4630655A.50204@domain.hid>
In-Reply-To: <4630655A.50204@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigD22F6C6A436D3E9037A0B922"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-core] [PATCH] fix smp build error of native skin
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
--------------enigD22F6C6A436D3E9037A0B922
Content-Type: multipart/mixed;
 boundary="------------000506050904090708050406"

This is a multi-part message in MIME format.
--------------000506050904090708050406
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Jan Kiszka wrote:
> We need nucleus/pod.h because xeno_flush_rq() refers to nklock.
>=20

That was too simple, utterly breaking elsewhere.

The problem was actually that a bit too much stuff (here: native/ppd.h)
got included in userspace. Here comes a fix + more cleanups of the
native headers. Hope I'm not causing regressions (only in projects that
where sloppy about inclusions before).

Jan

--------------000506050904090708050406
Content-Type: text/plain;
 name="native-include-cleanup.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline;
 filename="native-include-cleanup.patch"

---
 include/native/alarm.h    |    7 ++++---
 include/native/cond.h     |    5 +++--
 include/native/event.h    |    3 ++-
 include/native/heap.h     |    3 ++-
 include/native/intr.h     |    5 +++--
 include/native/mutex.h    |    5 +++--
 include/native/pipe.h     |    3 ++-
 include/native/ppd.h      |    1 +
 include/native/queue.h    |    3 ++-
 include/native/sem.h      |    3 ++-
 include/native/task.h     |    5 +++--
 include/native/timer.h    |    5 ++++-
 ksrc/skins/native/task.c  |    1 +
 src/skins/native/timer.c  |    2 +-
 src/utils/can/rtcansend.c |    1 +
 15 files changed, 34 insertions(+), 18 deletions(-)

Index: xenomai/include/native/alarm.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- xenomai.orig/include/native/alarm.h
+++ xenomai/include/native/alarm.h
@@ -22,10 +22,7 @@
 #ifndef _XENO_ALARM_H
 #define _XENO_ALARM_H
=20
-#include <nucleus/timer.h>
-#include <nucleus/synch.h>
 #include <native/types.h>
-#include <native/ppd.h>
=20
 typedef struct rt_alarm_info {
=20
@@ -43,6 +40,10 @@ typedef struct rt_alarm_placeholder {
=20
 #if defined(__KERNEL__) || defined(__XENO_SIM__)
=20
+#include <nucleus/timer.h>
+#include <nucleus/synch.h>
+#include <native/ppd.h>
+
 #define XENO_ALARM_MAGIC 0x55550909
=20
 typedef struct rt_alarm {
Index: xenomai/include/native/pipe.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- xenomai.orig/include/native/pipe.h
+++ xenomai/include/native/pipe.h
@@ -25,7 +25,6 @@
 #include <nucleus/pipe.h>
 #include <nucleus/heap.h>
 #include <native/types.h>
-#include <native/ppd.h>
=20
 /* Operation flags. */
 #define P_NORMAL  XNPIPE_NORMAL
@@ -39,6 +38,8 @@ typedef struct rt_pipe_placeholder {
=20
 #ifdef __KERNEL__
=20
+#include <native/ppd.h>
+
 #define XENO_PIPE_MAGIC  0x55550202
=20
 #define P_SYNCWAIT  0
Index: xenomai/include/native/task.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- xenomai.orig/include/native/task.h
+++ xenomai/include/native/task.h
@@ -24,8 +24,7 @@
=20
 #include <nucleus/core.h>
 #include <nucleus/thread.h>
-#include <nucleus/synch.h>
-#include <native/timer.h>
+#include <native/types.h>
=20
 /* Creation flags. */
 #define T_FPU     XNFPU
@@ -112,6 +111,8 @@ typedef struct rt_task_mcb {
=20
 #if (defined(__KERNEL__) || defined(__XENO_SIM__)) && !defined(DOXYGEN_C=
PP)
=20
+#include <nucleus/synch.h>
+
 #define XENO_TASK_MAGIC 0x55550101
=20
 typedef struct rt_task {
Index: xenomai/include/native/mutex.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- xenomai.orig/include/native/mutex.h
+++ xenomai/include/native/mutex.h
@@ -22,9 +22,7 @@
 #ifndef _XENO_MUTEX_H
 #define _XENO_MUTEX_H
=20
-#include <nucleus/synch.h>
 #include <native/types.h>
-#include <native/ppd.h>
=20
 struct rt_task;
=20
@@ -44,6 +42,9 @@ typedef struct rt_mutex_placeholder {
=20
 #if (defined(__KERNEL__) || defined(__XENO_SIM__)) && !defined(DOXYGEN_C=
PP)
=20
+#include <nucleus/synch.h>
+#include <native/ppd.h>
+
 #define XENO_MUTEX_MAGIC 0x55550505
=20
 typedef struct __rt_mutex {
Index: xenomai/include/native/intr.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- xenomai.orig/include/native/intr.h
+++ xenomai/include/native/intr.h
@@ -22,10 +22,8 @@
 #ifndef _XENO_INTR_H
 #define _XENO_INTR_H
=20
-#include <nucleus/synch.h>
 #include <nucleus/intr.h>
 #include <native/types.h>
-#include <native/ppd.h>
=20
 /* Creation flag. */
 #define I_NOAUTOENA  XN_ISR_NOENABLE  /* Do not auto-enable interrupt ch=
annel
@@ -50,6 +48,9 @@ typedef struct rt_intr_placeholder {
=20
 #if (defined(__KERNEL__) || defined(__XENO_SIM__)) && !defined(DOXYGEN_C=
PP)
=20
+#include <nucleus/synch.h>
+#include <native/ppd.h>
+
 #define XENO_INTR_MAGIC 0x55550a0a
=20
 /* Creation flags. */
Index: xenomai/include/native/heap.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- xenomai.orig/include/native/heap.h
+++ xenomai/include/native/heap.h
@@ -25,7 +25,6 @@
 #include <nucleus/synch.h>
 #include <nucleus/heap.h>
 #include <native/types.h>
-#include <native/ppd.h>
=20
 /* Creation flags. */
 #define H_PRIO     XNSYNCH_PRIO	/* Pend by task priority order. */
@@ -61,6 +60,8 @@ typedef struct rt_heap_placeholder {
=20
 #if defined(__KERNEL__) || defined(__XENO_SIM__)
=20
+#include <native/ppd.h>
+
 #define XENO_HEAP_MAGIC 0x55550808
=20
 typedef struct rt_heap {
Index: xenomai/include/native/timer.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- xenomai.orig/include/native/timer.h
+++ xenomai/include/native/timer.h
@@ -22,7 +22,6 @@
 #ifndef _XENO_TIMER_H
 #define _XENO_TIMER_H
=20
-#include <nucleus/timer.h>
 #include <native/types.h>
=20
 #define TM_ONESHOT XN_APERIODIC_TICK
@@ -36,7 +35,11 @@ typedef struct rt_timer_info {
 } RT_TIMER_INFO;
=20
 #if defined(__KERNEL__) || defined(__XENO_SIM__)
+
+#include <nucleus/timer.h>
+
 extern xntbase_t *__native_tbase;
+
 #endif /* __KERNEL__ || __XENO_SIM__ */
=20
 #ifdef __cplusplus
Index: xenomai/include/native/event.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- xenomai.orig/include/native/event.h
+++ xenomai/include/native/event.h
@@ -24,7 +24,6 @@
=20
 #include <nucleus/synch.h>
 #include <native/types.h>
-#include <native/ppd.h>
=20
 /* Creation flags. */
 #define EV_PRIO  XNSYNCH_PRIO	/* Pend by task priority order. */
@@ -50,6 +49,8 @@ typedef struct rt_event_placeholder {
=20
 #if (defined(__KERNEL__) || defined(__XENO_SIM__)) && !defined(DOXYGEN_C=
PP)
=20
+#include <native/ppd.h>
+
 #define XENO_EVENT_MAGIC 0x55550404
=20
 typedef struct rt_event {
Index: xenomai/include/native/cond.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- xenomai.orig/include/native/cond.h
+++ xenomai/include/native/cond.h
@@ -22,9 +22,7 @@
 #ifndef _XENO_COND_H
 #define _XENO_COND_H
=20
-#include <nucleus/synch.h>
 #include <native/mutex.h>
-#include <native/ppd.h>
=20
 typedef struct rt_cond_info {
=20
@@ -42,6 +40,9 @@ typedef struct rt_cond_placeholder {
=20
 #if (defined(__KERNEL__) || defined(__XENO_SIM__)) && !defined(DOXYGEN_C=
PP)
=20
+#include <nucleus/synch.h>
+#include <native/ppd.h>
+
 #define XENO_COND_MAGIC 0x55550606
=20
 typedef struct rt_cond {
Index: xenomai/include/native/ppd.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- xenomai.orig/include/native/ppd.h
+++ xenomai/include/native/ppd.h
@@ -22,6 +22,7 @@
 #ifndef _XENO_PPD_H
 #define _XENO_PPD_H
=20
+#include <nucleus/pod.h>
 #include <nucleus/ppd.h>
 #include <nucleus/heap.h>
=20
Index: xenomai/include/native/sem.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- xenomai.orig/include/native/sem.h
+++ xenomai/include/native/sem.h
@@ -24,7 +24,6 @@
=20
 #include <nucleus/synch.h>
 #include <native/types.h>
-#include <native/ppd.h>
=20
 /* Creation flags. */
 #define S_PRIO  XNSYNCH_PRIO	/* Pend by task priority order. */
@@ -47,6 +46,8 @@ typedef struct rt_sem_placeholder {
=20
 #if (defined(__KERNEL__) || defined(__XENO_SIM__)) && !defined(DOXYGEN_C=
PP)
=20
+#include <native/ppd.h>
+
 #define XENO_SEM_MAGIC 0x55550303
=20
 typedef struct rt_sem {
Index: xenomai/include/native/queue.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- xenomai.orig/include/native/queue.h
+++ xenomai/include/native/queue.h
@@ -25,7 +25,6 @@
 #include <nucleus/synch.h>
 #include <nucleus/heap.h>
 #include <native/types.h>
-#include <native/ppd.h>
=20
 /* Creation flags. */
 #define Q_PRIO   XNSYNCH_PRIO	/* Pend by task priority order. */
@@ -72,6 +71,8 @@ typedef struct rt_queue_placeholder {
=20
 #if defined(__KERNEL__) || defined(__XENO_SIM__)
=20
+#include <native/ppd.h>
+
 #define XENO_QUEUE_MAGIC 0x55550707
=20
 typedef struct rt_queue {
Index: xenomai/src/utils/can/rtcansend.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- xenomai.orig/src/utils/can/rtcansend.c
+++ xenomai/src/utils/can/rtcansend.c
@@ -8,6 +8,7 @@
 #include <sys/mman.h>
=20
 #include <native/task.h>
+#include <native/timer.h>
 #include <native/pipe.h>
=20
 #include <rtdm/rtcan.h>
Index: xenomai/src/skins/native/timer.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- xenomai.orig/src/skins/native/timer.c
+++ xenomai/src/skins/native/timer.c
@@ -17,7 +17,7 @@
  */
=20
 #include <native/syscall.h>
-#include <native/task.h>
+#include <native/timer.h>
=20
 extern int __native_muxid;
=20
Index: xenomai/ksrc/skins/native/task.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- xenomai.orig/ksrc/skins/native/task.c
+++ xenomai/ksrc/skins/native/task.c
@@ -48,6 +48,7 @@
 #include <nucleus/heap.h>
 #include <nucleus/registry.h>
 #include <native/task.h>
+#include <native/timer.h>
=20
 static DECLARE_XNQUEUE(__xeno_task_q);
=20

--------------000506050904090708050406--

--------------enigD22F6C6A436D3E9037A0B922
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFGMLRsniDOoMHTA+kRAhNXAJ4jYui8PMS3K5sbsO4iH2YH0xuuFACghSAV
HJExLTaSso0qZIRIjwXF9Yw=
=8MIk
-----END PGP SIGNATURE-----

--------------enigD22F6C6A436D3E9037A0B922--

