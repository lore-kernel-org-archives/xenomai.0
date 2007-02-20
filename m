Message-ID: <45DB5623.7090507@domain.hid>
Date: Tue, 20 Feb 2007 21:12:19 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigB18254FCDC2541F202DFD055"
Sender: jan.kiszka@domain.hid
Subject: [Xenomai-core] [PATCH] DECLARE_XNLOCK vs. DEFINE_XNLOCK
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
--------------enigB18254FCDC2541F202DFD055
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

This patch renames DECLARE_*XNLOCK to DEFINE_*XNLOCK, defines real DECLAR=
E_XNLOCK +
DECLARE_EXTERN_XNLOCK and applies it on several users.

Jan

---
 include/asm-generic/system.h |   10 +++++++---
 include/asm-sim/system.h     |    4 +++-
 include/nucleus/heap.h       |    4 +---
 include/nucleus/pod.h        |    4 +---
 ksrc/nucleus/intr.c          |    4 +---
 ksrc/nucleus/pod.c           |    2 +-
 ksrc/nucleus/shadow.c        |    2 +-
 ksrc/skins/posix/registry.c  |    4 +---
 ksrc/skins/posix/registry.h  |    4 +---
 ksrc/skins/rtdm/core.c       |    4 +---
 ksrc/skins/rtdm/core.h       |    4 +---
 ksrc/skins/rtdm/device.c     |    5 +----
 12 files changed, 20 insertions(+), 31 deletions(-)

Index: include/asm-generic/system.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- include/asm-generic/system.h	(Revision 2216)
+++ include/asm-generic/system.h	(Arbeitskopie)
@@ -245,8 +245,10 @@ static inline void xnlock_init (xnlock_t
     *lock =3D XNARCH_LOCK_UNLOCKED;
 }
=20
-#define DECLARE_XNLOCK(lock)		xnlock_t lock =3D XNARCH_LOCK_UNLOCKED
-#define DECLARE_PRIVATE_XNLOCK(lock) static DECLARE_XNLOCK(lock)
+#define DECLARE_XNLOCK(lock)		xnlock_t lock
+#define DECLARE_EXTERN_XNLOCK(lock)	extern xnlock_t lock
+#define DEFINE_XNLOCK(lock)		xnlock_t lock =3D XNARCH_LOCK_UNLOCKED
+#define DEFINE_PRIVATE_XNLOCK(lock) static DEFINE_XNLOCK(lock)
=20
 #if XENO_DEBUG(NUCLEUS)
=20
@@ -386,7 +388,9 @@ static inline void xnlock_put_irqrestore
 #define xnlock_clear_irqon(lock)       rthal_local_irq_enable()
=20
 #define DECLARE_XNLOCK(lock)
-#define DECLARE_PRIVATE_XNLOCK(lock)
+#define DECLARE_EXTERN_XNLOCK(lock)
+#define DEFINE_XNLOCK(lock)
+#define DEFINE_PRIVATE_XNLOCK(lock)
=20
 #endif /* !CONFIG_SMP */
=20
Index: include/asm-sim/system.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- include/asm-sim/system.h	(Revision 2216)
+++ include/asm-sim/system.h	(Arbeitskopie)
@@ -79,7 +79,9 @@ typedef unsigned long xnlock_t;
 #define xnlock_clear_irqon(lock)       mvm_set_irqmask(0)
=20
 #define DECLARE_XNLOCK(lock)
-#define DECLARE_PRIVATE_XNLOCK(lock)
+#define DECLARE_EXTERN_XNLOCK(lock)
+#define DEFINE_XNLOCK(lock)
+#define DEFINE_PRIVATE_XNLOCK(lock)
=20
 #define XNARCH_NR_CPUS              1
=20
Index: include/nucleus/heap.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- include/nucleus/heap.h	(Revision 2216)
+++ include/nucleus/heap.h	(Arbeitskopie)
@@ -89,9 +89,7 @@ typedef struct xnheap {
=20
 	xnqueue_t extents;
=20
-#ifdef CONFIG_SMP
-	xnlock_t lock;
-#endif /* CONFIG_SMP */
+	DECLARE_XNLOCK(lock);
=20
 	caddr_t buckets[XNHEAP_NBUCKETS];
=20
Index: include/nucleus/pod.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- include/nucleus/pod.h	(Revision 2216)
+++ include/nucleus/pod.h	(Arbeitskopie)
@@ -219,9 +219,7 @@ typedef struct xnpod xnpod_t;
=20
 extern xnpod_t *nkpod;
=20
-#ifdef CONFIG_SMP
-extern xnlock_t nklock;
-#endif /* CONFIG_SMP */
+DECLARE_EXTERN_XNLOCK(nklock);
=20
 extern u_long nkschedlat;
=20
Index: ksrc/skins/posix/registry.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- ksrc/skins/posix/registry.c	(Revision 2216)
+++ ksrc/skins/posix/registry.c	(Arbeitskopie)
@@ -322,9 +322,7 @@ int pse51_desc_get(pse51_desc_t ** descp
=20
 #if defined(__KERNEL__) && defined(CONFIG_XENO_OPT_PERVASIVE)
=20
-#ifdef CONFIG_SMP
-xnlock_t pse51_assoc_lock;
-#endif
+DEFINE_XNLOCK(pse51_assoc_lock);
=20
 static int pse51_assoc_lookup_inner(pse51_assocq_t * q,
 				    pse51_assoc_t ** passoc,
Index: ksrc/skins/posix/registry.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- ksrc/skins/posix/registry.h	(Revision 2216)
+++ ksrc/skins/posix/registry.h	(Arbeitskopie)
@@ -90,9 +90,7 @@ int pse51_desc_destroy(pse51_desc_t *des
 #if defined(__KERNEL__) && defined(CONFIG_XENO_OPT_PERVASIVE)
 struct mm_struct;
=20
-#ifdef CONFIG_SMP
-extern xnlock_t pse51_assoc_lock;
-#endif
+DECLARE_EXTERN_XNLOCK(pse51_assoc_lock);
=20
 typedef xnqueue_t pse51_assocq_t;
=20
Index: ksrc/skins/rtdm/device.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- ksrc/skins/rtdm/device.c	(Revision 2216)
+++ ksrc/skins/rtdm/device.c	(Arbeitskopie)
@@ -61,10 +61,7 @@ static int          name_hashkey_mask;
 static int          proto_hashkey_mask;
=20
 DECLARE_MUTEX(nrt_dev_lock);
-
-#ifdef CONFIG_SMP
-xnlock_t            rt_dev_lock =3D XNARCH_LOCK_UNLOCKED;
-#endif /* CONFIG_SMP */
+DEFINE_PRIVATE_XNLOCK(rt_dev_lock);
=20
 #ifndef MODULE
 int                 rtdm_initialised =3D 0;
Index: ksrc/skins/rtdm/core.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- ksrc/skins/rtdm/core.c	(Revision 2216)
+++ ksrc/skins/rtdm/core.c	(Arbeitskopie)
@@ -45,9 +45,7 @@ static unsigned long    used_fildes[FD_B
 int                     open_fildes;    /* amount of used descriptors */=

 xntbase_t               *rtdm_tbase;
=20
-#ifdef CONFIG_SMP
-xnlock_t                rt_fildes_lock =3D XNARCH_LOCK_UNLOCKED;
-#endif /* !CONFIG_SMP */
+DEFINE_XNLOCK(rt_fildes_lock);
=20
=20
 /**
Index: ksrc/skins/rtdm/core.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- ksrc/skins/rtdm/core.h	(Revision 2216)
+++ ksrc/skins/rtdm/core.h	(Arbeitskopie)
@@ -24,9 +24,7 @@
 #include <rtdm/rtdm_driver.h>
=20
=20
-#ifdef CONFIG_SMP
-extern xnlock_t             rt_fildes_lock;
-#endif /* CONFIG_SMP */
+DECLARE_EXTERN_XNLOCK(rt_fildes_lock);
=20
 #define RTDM_FD_MAX         CONFIG_XENO_OPT_RTDM_FILDES
=20
Index: ksrc/nucleus/intr.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- ksrc/nucleus/intr.c	(Revision 2216)
+++ ksrc/nucleus/intr.c	(Arbeitskopie)
@@ -39,9 +39,7 @@
=20
 #define XNINTR_MAX_UNHANDLED	1000
=20
-#ifdef CONFIG_SMP
-xnlock_t intrlock =3D XNARCH_LOCK_UNLOCKED;
-#endif /* CONFIG_SMP */
+DEFINE_PRIVATE_XNLOCK(intrlock);
=20
 xnintr_t nkclock;
=20
Index: ksrc/nucleus/pod.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- ksrc/nucleus/pod.c	(Revision 2216)
+++ ksrc/nucleus/pod.c	(Arbeitskopie)
@@ -56,7 +56,7 @@
=20
 xnpod_t *nkpod =3D NULL;
=20
-DECLARE_XNLOCK(nklock);
+DEFINE_XNLOCK(nklock);
=20
 u_long nkschedlat =3D 0;
=20
Index: ksrc/nucleus/shadow.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- ksrc/nucleus/shadow.c	(Revision 2216)
+++ ksrc/nucleus/shadow.c	(Arbeitskopie)
@@ -175,7 +175,7 @@ void xnpod_discard_iface_proc(struct xns
  * its base priority, i.e. the lowest available level.
  */
=20
-DECLARE_PRIVATE_XNLOCK(rpilock);
+DEFINE_PRIVATE_XNLOCK(rpilock);
=20
 #define rpi_p(t)	((t)->rpi !=3D NULL)
=20



--------------enigB18254FCDC2541F202DFD055
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFF21YjniDOoMHTA+kRAt2xAJ9ji0cV4MGhfM1s+QWva2lWsyVU8QCfbOO/
j8HuEmpOQ6JJRjkUmAzbPwM=
=3LJK
-----END PGP SIGNATURE-----

--------------enigB18254FCDC2541F202DFD055--

