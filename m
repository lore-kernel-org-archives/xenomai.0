Message-ID: <46722AD0.10607@domain.hid>
Date: Fri, 15 Jun 2007 07:59:44 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig55ED2DC2B6B260E0717C515F"
Sender: jan.kiszka@domain.hid
Subject: [Xenomai-core] [JANITOR][PATCH] Avoid deprecated SA_SHIRQ
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
--------------enig55ED2DC2B6B260E0717C515F
Content-Type: multipart/mixed;
 boundary="------------070709030905090304040607"

This is a multi-part message in MIME format.
--------------070709030905090304040607
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Kernel 2.6.22 starts to nag about this.

--------------070709030905090304040607
Content-Type: text/plain;
 name="IRQF_SHARED.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline;
 filename="IRQF_SHARED.patch"

Index: xenomai/include/asm-generic/wrappers.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- xenomai/include/asm-generic/wrappers.h	(Revision 2576)
+++ xenomai/include/asm-generic/wrappers.h	(Arbeitskopie)
@@ -265,6 +265,10 @@
 #define DECLARE_WORK_FUNC(f)		void f(struct work_struct *work)
 #endif /* >=3D 2.6.20 */
=20
+#if LINUX_VERSION_CODE < KERNEL_VERSION(2,6,18)
+#define IRQF_SHARED			SA_SHIRQ
+#endif /* < 2.6.18 */
+
 #endif /* LINUX_VERSION_CODE < KERNEL_VERSION(2,5,0) */
=20
 #endif /* _XENO_ASM_GENERIC_WRAPPERS_H */
Index: xenomai/ksrc/arch/arm/hal.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- xenomai/ksrc/arch/arm/hal.c	(Revision 2576)
+++ xenomai/ksrc/arch/arm/hal.c	(Arbeitskopie)
@@ -107,12 +107,12 @@
=20
     if (rthal_linux_irq[irq].count++ =3D=3D 0 && rthal_irq_descp(irq)->a=
ction) {
         rthal_linux_irq[irq].flags =3D rthal_irq_descp(irq)->action->fla=
gs;
-        rthal_irq_descp(irq)->action->flags |=3D SA_SHIRQ;
+        rthal_irq_descp(irq)->action->flags |=3D IRQF_SHARED;
     }
=20
     spin_unlock_irqrestore(rthal_irq_desc_lock(irq), flags);
=20
-    return request_irq(irq, handler, SA_SHIRQ, name, dev_id);
+    return request_irq(irq, handler, IRQF_SHARED, name, dev_id);
 }
=20
 int rthal_irq_host_release(unsigned irq, void *dev_id)
Index: xenomai/ksrc/arch/powerpc/hal.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- xenomai/ksrc/arch/powerpc/hal.c	(Revision 2576)
+++ xenomai/ksrc/arch/powerpc/hal.c	(Arbeitskopie)
@@ -236,12 +236,12 @@
=20
     if (rthal_linux_irq[irq].count++ =3D=3D 0 && rthal_irq_descp(irq)->a=
ction) {
         rthal_linux_irq[irq].flags =3D rthal_irq_descp(irq)->action->fla=
gs;
-        rthal_irq_descp(irq)->action->flags |=3D SA_SHIRQ;
+        rthal_irq_descp(irq)->action->flags |=3D IRQF_SHARED;
     }
=20
     spin_unlock_irqrestore(&rthal_irq_descp(irq)->lock, flags);
=20
-    return request_irq(irq, handler, SA_SHIRQ, name, dev_id);
+    return request_irq(irq, handler, IRQF_SHARED, name, dev_id);
 }
=20
 int rthal_irq_host_release(unsigned irq, void *dev_id)
Index: xenomai/ksrc/arch/ia64/hal.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- xenomai/ksrc/arch/ia64/hal.c	(Revision 2576)
+++ xenomai/ksrc/arch/ia64/hal.c	(Arbeitskopie)
@@ -151,12 +151,12 @@
=20
     if (rthal_linux_irq[irq].count++ =3D=3D 0 && rthal_irq_descp(irq)->a=
ction) {
         rthal_linux_irq[irq].flags =3D rthal_irq_descp(irq)->action->fla=
gs;
-        rthal_irq_descp(irq)->action->flags |=3D SA_SHIRQ;
+        rthal_irq_descp(irq)->action->flags |=3D IRQF_SHARED;
     }
=20
     spin_unlock_irqrestore(&rthal_irq_descp(irq)->lock, flags);
=20
-    return request_irq(irq, handler, SA_SHIRQ, name, dev_id);
+    return request_irq(irq, handler, IRQF_SHARED, name, dev_id);
 }
=20
 int rthal_irq_host_release(unsigned irq, void *dev_id)
Index: xenomai/ksrc/arch/blackfin/hal.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- xenomai/ksrc/arch/blackfin/hal.c	(Revision 2576)
+++ xenomai/ksrc/arch/blackfin/hal.c	(Arbeitskopie)
@@ -162,10 +162,10 @@
 	if (rthal_linux_irq[irq].count++ =3D=3D 0 && rthal_irq_descp(irq)->acti=
on) {
 		rthal_linux_irq[irq].flags =3D
 		    rthal_irq_descp(irq)->action->flags;
-		rthal_irq_descp(irq)->action->flags |=3D SA_SHIRQ;
+		rthal_irq_descp(irq)->action->flags |=3D IRQF_SHARED;
 	}
=20
-	return request_irq(irq, handler, SA_SHIRQ, name, dev_id);
+	return request_irq(irq, handler, IRQF_SHARED, name, dev_id);
 }
=20
 int rthal_irq_host_release(unsigned irq, void *dev_id)
Index: xenomai/ksrc/arch/i386/hal.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- xenomai/ksrc/arch/i386/hal.c	(Revision 2576)
+++ xenomai/ksrc/arch/i386/hal.c	(Arbeitskopie)
@@ -416,12 +416,12 @@
=20
     if (rthal_linux_irq[irq].count++ =3D=3D 0 && rthal_irq_descp(irq)->a=
ction) {
         rthal_linux_irq[irq].flags =3D rthal_irq_descp(irq)->action->fla=
gs;
-        rthal_irq_descp(irq)->action->flags |=3D SA_SHIRQ;
+        rthal_irq_descp(irq)->action->flags |=3D IRQF_SHARED;
     }
=20
     spin_unlock_irqrestore(&rthal_irq_descp(irq)->lock, flags);
=20
-    return request_irq(irq, handler, SA_SHIRQ, name, dev_id);
+    return request_irq(irq, handler, IRQF_SHARED, name, dev_id);
 }
=20
 int rthal_irq_host_release(unsigned irq, void *dev_id)
Index: xenomai/ksrc/arch/x86_64/hal.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- xenomai/ksrc/arch/x86_64/hal.c	(Revision 2576)
+++ xenomai/ksrc/arch/x86_64/hal.c	(Arbeitskopie)
@@ -201,12 +201,12 @@
 	if (rthal_linux_irq[irq].count++ =3D=3D 0 && rthal_irq_descp(irq)->acti=
on) {
 		rthal_linux_irq[irq].flags =3D
 		    rthal_irq_descp(irq)->action->flags;
-		rthal_irq_descp(irq)->action->flags |=3D SA_SHIRQ;
+		rthal_irq_descp(irq)->action->flags |=3D IRQF_SHARED;
 	}
=20
 	spin_unlock_irqrestore(&rthal_irq_descp(irq)->lock, flags);
=20
-	return request_irq(irq, handler, SA_SHIRQ, name, dev_id);
+	return request_irq(irq, handler, IRQF_SHARED, name, dev_id);
 }
=20
 int rthal_irq_host_release(unsigned irq, void *dev_id)

--------------070709030905090304040607--

--------------enig55ED2DC2B6B260E0717C515F
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFGcirQniDOoMHTA+kRAoA3AJ9eherrw6fnUZWs+lWEq0hZBaKUngCfcJxw
9RzU+WgnRsQHEw4p1zZWlKo=
=CmnZ
-----END PGP SIGNATURE-----

--------------enig55ED2DC2B6B260E0717C515F--

