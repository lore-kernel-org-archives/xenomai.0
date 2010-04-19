Message-ID: <4BCCB830.80704@domain.hid>
Date: Mon, 19 Apr 2010 22:08:16 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig3A76AEAD27B82160A5C7A817"
Sender: jan.kiszka@domain.hid
Subject: [Xenomai-core] [RFC][PATCH] Automatically generate
	CONFIG_XENO_OPT_DEBUG stubs
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>, Philippe Gerum <rpm@xenomai.org>
Cc: xenomai-core <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig3A76AEAD27B82160A5C7A817
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

This avoids forgetting to add the #ifndef-#define lines for debug
switches that shall be used with nucleus/assert.h. Generation takes
place during the prepare-kernel step, thus doesn't prolongs the normal
build.

Signed-off-by: Jan Kiszka <jan.kiszka@domain.hid>
---
 include/asm-generic/system.h     |    4 ----
 include/native/types.h           |    4 ----
 include/nucleus/assert.h         |   11 +++++++++++
 include/nucleus/bheap.h          |    4 ----
 include/nucleus/heap.h           |    4 ----
 include/nucleus/queue.h          |    4 ----
 include/nucleus/sched-sporadic.h |    4 ----
 include/nucleus/sched.h          |    4 ----
 include/nucleus/timer.h          |    4 ----
 include/psos+/ppd.h              |    4 ----
 include/rtdm/rtdm_driver.h       |    4 ----
 include/vxworks/ppd.h            |    4 ----
 ksrc/nucleus/bufd.c              |    4 ----
 ksrc/nucleus/pod.c               |    4 ----
 ksrc/nucleus/registry.c          |    4 ----
 ksrc/nucleus/sched.c             |    4 ----
 ksrc/nucleus/shadow.c            |    4 ----
 ksrc/nucleus/synch.c             |    4 ----
 ksrc/skins/posix/internal.h      |    4 ----
 ksrc/skins/rtdm/internal.h       |    4 ----
 ksrc/skins/uitron/ppd.h          |    4 ----
 scripts/prepare-kernel.sh        |   11 +++++++++++
 22 files changed, 22 insertions(+), 80 deletions(-)

diff --git a/include/asm-generic/system.h b/include/asm-generic/system.h
index a2c8fb9..59d4408 100644
--- a/include/asm-generic/system.h
+++ b/include/asm-generic/system.h
@@ -44,10 +44,6 @@
 /* debug support */
 #include <nucleus/assert.h>
=20
-#ifndef CONFIG_XENO_OPT_DEBUG_XNLOCK
-#define CONFIG_XENO_OPT_DEBUG_XNLOCK 0
-#endif
-
 #ifdef __cplusplus
 extern "C" {
 #endif
diff --git a/include/native/types.h b/include/native/types.h
index 0dd721f..5f858ab 100644
--- a/include/native/types.h
+++ b/include/native/types.h
@@ -32,10 +32,6 @@
=20
 #if defined(__KERNEL__) || defined(__XENO_SIM__)
=20
-#ifndef CONFIG_XENO_OPT_DEBUG_NATIVE
-#define CONFIG_XENO_OPT_DEBUG_NATIVE  0
-#endif
-
 typedef xnticks_t RTIME;
=20
 typedef xnsticks_t SRTIME;
diff --git a/include/nucleus/assert.h b/include/nucleus/assert.h
index 9cb88af..05942a1 100644
--- a/include/nucleus/assert.h
+++ b/include/nucleus/assert.h
@@ -20,7 +20,10 @@
 #ifndef _XENO_NUCLEUS_ASSERT_H
 #define _XENO_NUCLEUS_ASSERT_H
=20
+#ifdef __KERNEL__
+
 #include <nucleus/types.h>
+#include <nucleus/debug_defines.h>
=20
 #define XENO_DEBUG(subsystem)   (CONFIG_XENO_OPT_DEBUG_##subsystem > 0)
=20
@@ -38,4 +41,12 @@
         xnpod_fatal("bug at %s:%d (%s)", __FILE__, __LINE__, (#cond)); \=

 } while(0)
=20
+#else /* !__KERNEL__ */
+
+#define XENO_DEBUG(subsystem)			(0)
+#define XENO_ASSERT(subsystem,cond,action)	do { } while (0)
+#define XENO_BUGON(subsystem,cond)		do { } while (0)
+
+#endif /* !__KERNEL__ */
+
 #endif /* !_XENO_NUCLEUS_ASSERT_H */
diff --git a/include/nucleus/bheap.h b/include/nucleus/bheap.h
index 8b7798e..6319aae 100644
--- a/include/nucleus/bheap.h
+++ b/include/nucleus/bheap.h
@@ -25,10 +25,6 @@
 /* debug support */
 #include <nucleus/assert.h>
=20
-#ifndef CONFIG_XENO_OPT_DEBUG_QUEUES
-#define CONFIG_XENO_OPT_DEBUG_QUEUES 0
-#endif
-
 /* Priority queue implementation, using a binary heap. */
=20
 typedef unsigned long long bheap_key_t;
diff --git a/include/nucleus/heap.h b/include/nucleus/heap.h
index 77fefa6..fecdb79 100644
--- a/include/nucleus/heap.h
+++ b/include/nucleus/heap.h
@@ -46,10 +46,6 @@
=20
 #if defined(__KERNEL__) || defined(__XENO_SIM__)
=20
-#ifndef CONFIG_XENO_OPT_DEBUG_NUCLEUS
-#define CONFIG_XENO_OPT_DEBUG_NUCLEUS 0
-#endif
-
 #define XNHEAP_PAGE_SIZE	512 /* A reasonable value for the xnheap page s=
ize */
 #define XNHEAP_PAGE_MASK	(~(XNHEAP_PAGE_SIZE-1))
 #define XNHEAP_PAGE_ALIGN(addr)	(((addr)+XNHEAP_PAGE_SIZE-1)&XNHEAP_PAGE=
_MASK)
diff --git a/include/nucleus/queue.h b/include/nucleus/queue.h
index e243f2f..15ec537 100644
--- a/include/nucleus/queue.h
+++ b/include/nucleus/queue.h
@@ -24,10 +24,6 @@
 #include <nucleus/types.h>
 #include <nucleus/assert.h>
=20
-#ifndef CONFIG_XENO_OPT_DEBUG_QUEUES
-#define CONFIG_XENO_OPT_DEBUG_QUEUES 0
-#endif
-
 /* Basic element holder */
=20
 typedef struct xnholder {
diff --git a/include/nucleus/sched-sporadic.h b/include/nucleus/sched-spo=
radic.h
index ecebc55..dfeec76 100644
--- a/include/nucleus/sched-sporadic.h
+++ b/include/nucleus/sched-sporadic.h
@@ -29,10 +29,6 @@
=20
 #ifdef CONFIG_XENO_OPT_SCHED_SPORADIC
=20
-#ifndef CONFIG_XENO_OPT_DEBUG_NUCLEUS
-#define CONFIG_XENO_OPT_DEBUG_NUCLEUS 0
-#endif
-
 #include <nucleus/heap.h>
=20
 extern struct xnsched_class xnsched_class_sporadic;
diff --git a/include/nucleus/sched.h b/include/nucleus/sched.h
index c96d65d..68fe069 100644
--- a/include/nucleus/sched.h
+++ b/include/nucleus/sched.h
@@ -36,10 +36,6 @@
 #include <nucleus/sched-tp.h>
 #include <nucleus/sched-sporadic.h>
=20
-#ifndef CONFIG_XENO_OPT_DEBUG_NUCLEUS
-#define CONFIG_XENO_OPT_DEBUG_NUCLEUS 0
-#endif
-
 /* Sched status flags */
 #define XNKCOUT		0x80000000	/* Sched callout context */
 #define XNHTICK		0x40000000	/* Host tick pending  */
diff --git a/include/nucleus/timer.h b/include/nucleus/timer.h
index ef05822..f2e0b19 100644
--- a/include/nucleus/timer.h
+++ b/include/nucleus/timer.h
@@ -28,10 +28,6 @@
=20
 #if defined(__KERNEL__) || defined(__XENO_SIM__)
=20
-#ifndef CONFIG_XENO_OPT_DEBUG_TIMERS
-#define CONFIG_XENO_OPT_DEBUG_TIMERS  0
-#endif
-
 #define XNTIMER_WHEELSIZE 64
 #define XNTIMER_WHEELMASK (XNTIMER_WHEELSIZE - 1)
=20
diff --git a/include/psos+/ppd.h b/include/psos+/ppd.h
index 09ea13f..ff2301d 100644
--- a/include/psos+/ppd.h
+++ b/include/psos+/ppd.h
@@ -25,10 +25,6 @@
 #include <nucleus/pod.h>
 #include <nucleus/ppd.h>
=20
-#ifndef CONFIG_XENO_OPT_DEBUG_PSOS
-#define CONFIG_XENO_OPT_DEBUG_PSOS  0
-#endif
-
 typedef struct psos_resource_holder {
=20
 	xnshadow_ppd_t ppd;
diff --git a/include/rtdm/rtdm_driver.h b/include/rtdm/rtdm_driver.h
index 1a4097b..1e99400 100644
--- a/include/rtdm/rtdm_driver.h
+++ b/include/rtdm/rtdm_driver.h
@@ -47,10 +47,6 @@
 #include <asm-generic/xenomai/pci_ids.h>
 #endif /* CONFIG_PCI */
=20
-#ifndef CONFIG_XENO_OPT_DEBUG_RTDM
-#define CONFIG_XENO_OPT_DEBUG_RTDM	0
-#endif
-
 struct rtdm_dev_context;
 typedef struct xnselector rtdm_selector_t;
 enum rtdm_selecttype;
diff --git a/include/vxworks/ppd.h b/include/vxworks/ppd.h
index 245c9b7..4553983 100644
--- a/include/vxworks/ppd.h
+++ b/include/vxworks/ppd.h
@@ -25,10 +25,6 @@
 #include <nucleus/pod.h>
 #include <nucleus/ppd.h>
=20
-#ifndef CONFIG_XENO_OPT_DEBUG_VXWORKS
-#define CONFIG_XENO_OPT_DEBUG_VXWORKS  0
-#endif
-
 typedef struct wind_resource_holder {
=20
 	xnshadow_ppd_t ppd;
diff --git a/ksrc/nucleus/bufd.c b/ksrc/nucleus/bufd.c
index 8dd655c..d9e1646 100644
--- a/ksrc/nucleus/bufd.c
+++ b/ksrc/nucleus/bufd.c
@@ -146,10 +146,6 @@
 #include <nucleus/bufd.h>
 #include <nucleus/assert.h>
=20
-#ifndef CONFIG_XENO_OPT_DEBUG_NUCLEUS
-#define CONFIG_XENO_OPT_DEBUG_NUCLEUS  0
-#endif
-
 #ifdef CONFIG_XENO_OPT_PERVASIVE
=20
 #include <asm/xenomai/syscall.h>
diff --git a/ksrc/nucleus/pod.c b/ksrc/nucleus/pod.c
index 93713f2..ddaa114 100644
--- a/ksrc/nucleus/pod.c
+++ b/ksrc/nucleus/pod.c
@@ -46,10 +46,6 @@
 #include <nucleus/select.h>
 #include <asm/xenomai/bits/pod.h>
=20
-#ifndef CONFIG_XENO_OPT_DEBUG_NUCLEUS
-#define CONFIG_XENO_OPT_DEBUG_NUCLEUS 0
-#endif
-
 /*
  * NOTE: We need to initialize the globals; remember that this code
  * also runs over the simulator in user-space.
diff --git a/ksrc/nucleus/registry.c b/ksrc/nucleus/registry.c
index 9958dd3..ac09257 100644
--- a/ksrc/nucleus/registry.c
+++ b/ksrc/nucleus/registry.c
@@ -42,10 +42,6 @@
 #include <nucleus/thread.h>
 #include <nucleus/assert.h>
=20
-#ifndef CONFIG_XENO_OPT_DEBUG_REGISTRY
-#define CONFIG_XENO_OPT_DEBUG_REGISTRY  0
-#endif
-
 static xnobject_t *registry_obj_slots;
=20
 static xnqueue_t registry_obj_freeq;	/* Free objects. */
diff --git a/ksrc/nucleus/sched.c b/ksrc/nucleus/sched.c
index 4ec0013..6bd21fe 100644
--- a/ksrc/nucleus/sched.c
+++ b/ksrc/nucleus/sched.c
@@ -529,10 +529,6 @@ void xnsched_migrate_passive(struct xnthread *thread=
, struct xnsched *sched)
=20
 #ifdef CONFIG_XENO_OPT_SCALABLE_SCHED
=20
-#ifndef CONFIG_XENO_OPT_DEBUG_QUEUES
-#define CONFIG_XENO_OPT_DEBUG_QUEUES 0
-#endif
-
 void initmlq(struct xnsched_mlq *q, int loprio, int hiprio)
 {
 	int prio;
diff --git a/ksrc/nucleus/shadow.c b/ksrc/nucleus/shadow.c
index 539d952..94188ba 100644
--- a/ksrc/nucleus/shadow.c
+++ b/ksrc/nucleus/shadow.c
@@ -55,10 +55,6 @@
 #include <asm/xenomai/syscall.h>
 #include <asm/xenomai/bits/shadow.h>
=20
-#ifndef CONFIG_XENO_OPT_DEBUG_NUCLEUS
-#define CONFIG_XENO_OPT_DEBUG_NUCLEUS  0
-#endif
-
 static int xn_gid_arg =3D -1;
 module_param_named(xenomai_gid, xn_gid_arg, int, 0644);
 MODULE_PARM_DESC(xenomai_gid, "GID of the group with access to Xenomai s=
ervices");
diff --git a/ksrc/nucleus/synch.c b/ksrc/nucleus/synch.c
index 619929e..cdad592 100644
--- a/ksrc/nucleus/synch.c
+++ b/ksrc/nucleus/synch.c
@@ -36,10 +36,6 @@
 #include <nucleus/thread.h>
 #include <nucleus/module.h>
=20
-#ifndef CONFIG_XENO_OPT_DEBUG_NUCLEUS
-#define CONFIG_XENO_OPT_DEBUG_NUCLEUS 0
-#endif
-
 #define w_bprio(t)	xnsched_weighted_bprio(t)
 #define w_cprio(t)	xnsched_weighted_cprio(t)
=20
diff --git a/ksrc/skins/posix/internal.h b/ksrc/skins/posix/internal.h
index dcc71e9..7ef6d9c 100644
--- a/ksrc/skins/posix/internal.h
+++ b/ksrc/skins/posix/internal.h
@@ -28,10 +28,6 @@
 /* debug support */
 #include <nucleus/assert.h>
=20
-#ifndef CONFIG_XENO_OPT_DEBUG_POSIX
-#define CONFIG_XENO_OPT_DEBUG_POSIX 0
-#endif
-
 #define PSE51_MAGIC(n) (0x8686##n##n)
 #define PSE51_ANY_MAGIC         PSE51_MAGIC(00)
 #define PSE51_THREAD_MAGIC      PSE51_MAGIC(01)
diff --git a/ksrc/skins/rtdm/internal.h b/ksrc/skins/rtdm/internal.h
index a05cd7d..699b79f 100644
--- a/ksrc/skins/rtdm/internal.h
+++ b/ksrc/skins/rtdm/internal.h
@@ -28,10 +28,6 @@
 #include <nucleus/ppd.h>
 #include <rtdm/rtdm_driver.h>
=20
-#ifndef CONFIG_XENO_OPT_DEBUG_RTDM_APPL
-#define CONFIG_XENO_OPT_DEBUG_RTDM_APPL	0
-#endif
-
 #define RTDM_FD_MAX			CONFIG_XENO_OPT_RTDM_FILDES
=20
 #define DEF_DEVNAME_HASHTAB_SIZE	256	/* entries in name hash table */
diff --git a/ksrc/skins/uitron/ppd.h b/ksrc/skins/uitron/ppd.h
index 305a1e8..d8d582b 100644
--- a/ksrc/skins/uitron/ppd.h
+++ b/ksrc/skins/uitron/ppd.h
@@ -25,10 +25,6 @@
 #include <nucleus/pod.h>
 #include <nucleus/ppd.h>
=20
-#ifndef CONFIG_XENO_OPT_DEBUG_UITRON
-#define CONFIG_XENO_OPT_DEBUG_UITRON  0
-#endif
-
 typedef struct ui_resource_holder {
=20
 	xnshadow_ppd_t ppd;
diff --git a/scripts/prepare-kernel.sh b/scripts/prepare-kernel.sh
index 24b1f17..d8038e0 100755
--- a/scripts/prepare-kernel.sh
+++ b/scripts/prepare-kernel.sh
@@ -584,6 +584,17 @@ for d in include/* ; do
     fi
 done
=20
+kconfigs=3D`find $xenomai_root/ksrc -name Kconfig`
+debug_defines=3D$linux_tree/include/xenomai/nucleus/debug_defines.h
+rm -f $debug_defines
+for debugopt in `grep XENO_OPT_DEBUG_ $kconfigs | cut -d' ' -f2`; do
+    cat >>$debug_defines <<EOF
+#ifndef CONFIG_$debugopt
+#define CONFIG_$debugopt 0
+#endif
+EOF
+done
+
 if test "x$output_patch" !=3D "x"; then
     if test x$verbose =3D x1; then
     echo 'Generating patch.'



--------------enig3A76AEAD27B82160A5C7A817
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iEYEARECAAYFAkvMuDAACgkQitSsb3rl5xSiugCcCQcDJxfUTZ9J8og2xyUHcluP
qe4An3arEWxYjULh/w/LiYHAf4agaoYi
=c5sQ
-----END PGP SIGNATURE-----

--------------enig3A76AEAD27B82160A5C7A817--

