Message-ID: <468F409B.7090805@domain.hid>
Date: Sat, 07 Jul 2007 09:28:27 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <468ED509.8060105@domain.hid>
In-Reply-To: <468ED509.8060105@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig653EFFECFCC0C91DC53755F3"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-core] [PATCH] reduce config complexity of intr.c
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
--------------enig653EFFECFCC0C91DC53755F3
Content-Type: multipart/mixed;
 boundary="------------020408090902050002050103"

This is a multi-part message in MIME format.
--------------020408090902050002050103
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Jan Kiszka wrote:
> ...
> Then I reordered some code to avoid warnings for the non-shared non-SMP=

> case AND to fix a probable compilation issue of the simulator (due to
> unknown ____cacheline_aligned_in_smp).

And this add-on patch is needed to make the simulator really build again.=


Jan


--------------020408090902050002050103
Content-Type: text/x-patch;
 name="xnintr-sim-fix.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline;
 filename="xnintr-sim-fix.patch"

---
 include/asm-generic/system.h |    1 +
 include/asm-sim/system.h     |    2 ++
 ksrc/nucleus/intr.c          |   10 +++++-----
 ksrc/nucleus/module.c        |    4 ++--
 4 files changed, 10 insertions(+), 7 deletions(-)

Index: xenomai/include/asm-generic/system.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- xenomai.orig/include/asm-generic/system.h
+++ xenomai/include/asm-generic/system.h
@@ -123,6 +123,7 @@ typedef struct { atomic_t owner; } xnloc
=20
 #define XNARCH_NR_CPUS               RTHAL_NR_CPUS
=20
+#define XNARCH_NR_IRQS               RTHAL_NR_IRQS
 #define XNARCH_TIMER_IRQ	     RTHAL_TIMER_IRQ
=20
 #define XNARCH_ROOT_STACKSZ   0	/* Only a placeholder -- no stack */
Index: xenomai/include/asm-sim/system.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- xenomai.orig/include/asm-sim/system.h
+++ xenomai/include/asm-sim/system.h
@@ -85,6 +85,8 @@ typedef unsigned long xnlock_t;
=20
 #define XNARCH_NR_CPUS              1
=20
+#define XNARCH_NR_IRQS              256
+
 /* Should be equal to the value used for creating the mvmtimer object (m=
vm_start_timer). */
 #define XNARCH_TIMER_IRQ	    1
=20
Index: xenomai/ksrc/nucleus/intr.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- xenomai.orig/ksrc/nucleus/intr.c
+++ xenomai/ksrc/nucleus/intr.c
@@ -141,7 +141,7 @@ typedef struct xnintr_irq {
=20
 } ____cacheline_aligned_in_smp xnintr_irq_t;
=20
-static xnintr_irq_t xnirqs[RTHAL_NR_IRQS];
+static xnintr_irq_t xnirqs[XNARCH_NR_IRQS];
=20
 /*
  * Low-level interrupt handler dispatching the user-defined ISRs for
@@ -292,7 +292,7 @@ static inline int xnintr_irq_attach(xnin
 	xnintr_t *prev, **p =3D &shirq->handlers;
 	int err;
=20
-	if (intr->irq >=3D RTHAL_NR_IRQS)
+	if (intr->irq >=3D XNARCH_NR_IRQS)
 		return -EINVAL;
=20
 	if (__testbits(intr->flags, XN_ISR_ATTACHED))
@@ -346,7 +346,7 @@ static inline int xnintr_irq_detach(xnin
 	xnintr_t *e, **p =3D &shirq->handlers;
 	int err =3D 0;
=20
-	if (intr->irq >=3D RTHAL_NR_IRQS)
+	if (intr->irq >=3D XNARCH_NR_IRQS)
 		return -EINVAL;
=20
 	if (!__testbits(intr->flags, XN_ISR_ATTACHED))
@@ -386,7 +386,7 @@ typedef struct xnintr_irq {
=20
 } ____cacheline_aligned_in_smp xnintr_irq_t;
=20
-static xnintr_irq_t xnirqs[RTHAL_NR_IRQS];
+static xnintr_irq_t xnirqs[XARCH_NR_IRQS];
 #endif /* CONFIG_SMP */
=20
 static inline int xnintr_irq_attach(xnintr_t *intr)
@@ -477,7 +477,7 @@ static void xnintr_irq_handler(unsigned=20
 int xnintr_mount(void)
 {
 	int i;
-	for (i =3D 0; i < RTHAL_NR_IRQS; ++i)
+	for (i =3D 0; i < XNARCH_NR_IRQS; ++i)
 		xnlock_init(&xnirqs[i].lock);
 	return 0;
 }
Index: xenomai/ksrc/nucleus/module.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- xenomai.orig/ksrc/nucleus/module.c
+++ xenomai/ksrc/nucleus/module.c
@@ -438,7 +438,7 @@ static int stat_seq_open(struct inode *i
 	}
=20
 	/* Iterate over all IRQ numbers, ... */
-	for (irq =3D 0; irq < RTHAL_NR_IRQS; irq++) {
+	for (irq =3D 0; irq < XNARCH_NR_IRQS; irq++) {
 		xnintr_t *prev =3D NULL;
 		int cpu =3D 0;
 		int err;
@@ -865,7 +865,7 @@ static int irq_read_proc(char *page,
 		p +=3D sprintf(p, "        CPU%d", cpu);
 	}
=20
-	for (irq =3D 0; irq < RTHAL_NR_IRQS; irq++) {
+	for (irq =3D 0; irq < XNARCH_NR_IRQS; irq++) {
=20
 		if (rthal_irq_handler(&rthal_domain, irq) =3D=3D NULL)
 			continue;


--------------020408090902050002050103--

--------------enig653EFFECFCC0C91DC53755F3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iD8DBQFGj0CcniDOoMHTA+kRAhuwAJsGc0RwP8Fzw4i/klx0InIbzzbq4ACfVNxz
Qg8V+VttZwg5hjNJFiuq9Ko=
=a9Ms
-----END PGP SIGNATURE-----

--------------enig653EFFECFCC0C91DC53755F3--

