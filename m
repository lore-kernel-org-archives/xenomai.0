Message-ID: <4CC92876.1050608@domain.hid>
Date: Thu, 28 Oct 2010 09:38:30 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <20101007115728.GA24500@domain.hid>	
	<4CADBDC2.8080600@domain.hid>
	<20101008070148.GB2255@domain.hid>	
	<1286530884.13186.109.camel@domain.hid>	
	<20101013090353.GA6902@domain.hid>	
	<1286961375.1759.71.camel@domain.hid>	
	<20101013092617.GB6902@domain.hid>	
	<1286981521.1759.83.camel@domain.hid>	
	<1288025329.26618.132.camel@domain.hid> <4CC5C80E.2070004@domain.hid>	
	<1288033731.26618.161.camel@domain.hid> <4CC5D742.9080307@domain.hid>	
	<1288034435.26618.164.camel@domain.hid> <4CC5D8FF.5080109@domain.hid>	
	<1288041166.26618.182.camel@domain.hid> <4CC5F525.7040206@domain.hid>	
	<1288042858.26618.204.camel@domain.hid> <4CC5FAE6.6010305@domain.hid>	
	<1288068231.26618.224.camel@domain.hid>
	<4CC665A1.9040707@domain.hid>	 <4CC72D27.3010607@domain.hid>
	<1288243034.1816.14.camel@domain.hid> <4CC926BE.7040105@domain.hid>
In-Reply-To: <4CC926BE.7040105@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig390B5C748439F586343E31CE"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-help] kernel oopses when killing realtime task
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Philippe Gerum <rpm@xenomai.org>
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig390B5C748439F586343E31CE
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Am 28.10.2010 09:31, Jan Kiszka wrote:
> This sounds like it's best discussed based on patches.
>=20

BTW, this is my current idea to make deregistration via
ipipe_virtualize_irq safe against ongoing IRQs, ie. the risk to invoke
a NULL handler:


From: Jan Kiszka <jan.kiszka@domain.hid>

ipipe: Catch ongoing IRQs while deregistering from the line

If ipipe_virtualize_irq is called for an IRQ that may be under
processing on a different CPU, we must not clear the handler to avoid
NULL pointer failures. However, this IRQ-on-the-fly already became
spurious before the caller invoked ipipe_virtualize_irq. So install a
dummy handler that swallows the event silently.

Signed-off-by: Jan Kiszka <jan.kiszka@domain.hid>
---
 kernel/ipipe/core.c |   30 ++++++++++++++++++++++++------
 1 files changed, 24 insertions(+), 6 deletions(-)

diff --git a/kernel/ipipe/core.c b/kernel/ipipe/core.c
index b3a8139..bf43bb8 100644
--- a/kernel/ipipe/core.c
+++ b/kernel/ipipe/core.c
@@ -277,6 +277,18 @@ void __init ipipe_init(void)
 	       IPIPE_VERSION_STRING);
 }
=20
+static void ipipe_final_irq_handler(unsigned irq, struct irq_desc *desc)=

+{
+	/*
+	 * De-virtualization of an IRQ may race with ongoing IRQ delivery on a
+	 * different CPU. This handler catches the delivery and ends the
+	 * request. It is assumed to be the final event as the caller of
+	 * ipipe_virtualize_irq() is supposed to have disabled any related IRQ
+	 * source at device level before deregistering the interrupt.
+	 */
+	desc->ipipe_end(irq, desc);
+}
+
 void __ipipe_init_stage(struct ipipe_domain *ipd)
 {
 	struct ipipe_percpu_domain_data *p;
@@ -292,7 +304,7 @@ void __ipipe_init_stage(struct ipipe_domain *ipd)
=20
 	for (n =3D 0; n < IPIPE_NR_IRQS; n++) {
 		ipd->irqs[n].acknowledge =3D NULL;
-		ipd->irqs[n].handler =3D NULL;
+		ipd->irqs[n].handler =3D ipipe_final_irq_handler;
 		ipd->irqs[n].control =3D IPIPE_PASS_MASK;	/* Pass but don't handle */
 	}
=20
@@ -924,14 +936,20 @@ int ipipe_virtualize_irq(struct ipipe_domain *ipd,
 		    ~(IPIPE_HANDLE_MASK | IPIPE_STICKY_MASK |
 		      IPIPE_EXCLUSIVE_MASK | IPIPE_WIRED_MASK);
=20
-		ipd->irqs[irq].handler =3D NULL;
+		ipd->irqs[irq].handler =3D ipipe_final_irq_handler;
+		/*
+		 * Make sure we never call the old handler with an invalid
+		 * cookie. The dummy handler ignores the cookie. Set it first.
+		 */
+		smp_mb();
 		ipd->irqs[irq].cookie =3D NULL;
-		ipd->irqs[irq].acknowledge =3D NULL;
+		ipd->irqs[irq].acknowledge =3D
+			ipipe_root_domain->irqs[irq].acknowledge;
 		ipd->irqs[irq].control =3D modemask;
=20
 		if (irq < NR_IRQS && !ipipe_virtual_irq_p(irq)) {
 			desc =3D irq_to_desc(irq);
-			if (old_handler && desc)
+			if (old_handler !=3D ipipe_final_irq_handler && desc)
 				__ipipe_disable_irqdesc(ipd, irq);
 		}
=20
@@ -941,7 +959,7 @@ int ipipe_virtualize_irq(struct ipipe_domain *ipd,
 	if (handler =3D=3D IPIPE_SAME_HANDLER) {
 		cookie =3D ipd->irqs[irq].cookie;
 		handler =3D old_handler;
-		if (handler =3D=3D NULL) {
+		if (handler =3D=3D ipipe_final_irq_handler) {
 			ret =3D -EINVAL;
 			goto unlock_and_exit;
 		}
@@ -1024,7 +1042,7 @@ int ipipe_control_irq(struct ipipe_domain *ipd, uns=
igned int irq,
 		goto out;
 	}
=20
-	if (ipd->irqs[irq].handler =3D=3D NULL)
+	if (ipd->irqs[irq].handler =3D=3D ipipe_final_irq_handler)
 		setmask &=3D ~(IPIPE_HANDLE_MASK | IPIPE_STICKY_MASK);
=20
 	if ((setmask & IPIPE_STICKY_MASK) !=3D 0)
--=20
1.7.1


I'm not your 100% happy with the fact that the old acknowledge handler
may be paired with ipipe_finale_irq_handler this way, but I see no
better approach so far.

So this patch just had to be paired with a barrier after the
deregistration (in Xenomai) to ensure all users of the old handlers and
cookies are done.

Jan


--------------enig390B5C748439F586343E31CE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.15 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org/

iEYEARECAAYFAkzJKHYACgkQitSsb3rl5xRfngCdHdkAc78Fex7Dnmt1j2aHA9R1
MHEAoMlwcbj06jB6xOdRBRLsfwCXISv/
=NkyD
-----END PGP SIGNATURE-----

--------------enig390B5C748439F586343E31CE--

