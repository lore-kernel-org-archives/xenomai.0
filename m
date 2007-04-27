Message-ID: <4632092F.3020607@domain.hid>
Date: Fri, 27 Apr 2007 16:31:11 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <4631FF09.2000601@domain.hid> <4631F925.2090100@domain.hid>
	<4850965.1177589052502.JavaMail.ngmail@domain.hid>	
	<4631E30B.6060701@domain.hid> <1177679680.5010.78.camel@domain.hid>
	<23595872.1177680700618.JavaMail.ngmail@domain.hid>
	<784082.1177682909759.JavaMail.ngmail@domain.hid>
In-Reply-To: <784082.1177682909759.JavaMail.ngmail@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig1CCB6C29008649AE62D3454A"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-help] Xenomai and MSI enabled crashes kernel
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: "M. Koehrer" <mathias_koehrer@domain.hid>
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig1CCB6C29008649AE62D3454A
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

M. Koehrer wrote:
> Hi Jan,=20
>=20
> here is the result - I have logged with a serial console (as my kernel =
freezes).
> There are many printk messages...
>=20
> I hope that helps a little bit

Not yet (was a silly patch, please revert first). Another try

--- linux-2.6.20.orig/include/asm-i386/ipipe.h
+++ linux-2.6.20/include/asm-i386/ipipe.h
@@ -262,6 +262,9 @@ static inline unsigned long __ipipe_ffnz
 do { \
 	local_irq_enable_nohead(ipd);				 \
 	if (ipd =3D=3D ipipe_root_domain) {				 \
+if (!ipd->irqs[irq].handler) { \
+	ipipe_set_printk_sync(ipd); printk("irq=3D%d\n", irq); BUG(); \
+}; \
 		if (likely(!ipipe_virtual_irq_p(irq))) {	 \
 			__ipipe_call_root_xirq_handler(ipd,irq); \
 		} else {					 \



--------------enig1CCB6C29008649AE62D3454A
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFGMgkvniDOoMHTA+kRAgHMAJ9jukfPpgrpfoAc0CFl+axY0fcPOQCbBinY
3rb66iaXBfiW08qhjyJ9nKg=
=38CX
-----END PGP SIGNATURE-----

--------------enig1CCB6C29008649AE62D3454A--

