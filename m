Message-ID: <4631FF09.2000601@domain.hid>
Date: Fri, 27 Apr 2007 15:47:53 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <4631F925.2090100@domain.hid>
	<4850965.1177589052502.JavaMail.ngmail@domain.hid>	
	<4631E30B.6060701@domain.hid> <1177679680.5010.78.camel@domain.hid>
	<23595872.1177680700618.JavaMail.ngmail@domain.hid>
In-Reply-To: <23595872.1177680700618.JavaMail.ngmail@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigC92B18C93D786F42946DEC00"
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
--------------enigC92B18C93D786F42946DEC00
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

M. Koehrer wrote:
> Hi all,
>=20
> sure, I can provide support in testing (as this is reproducable at my P=
C).

Then please start like this:

--- linux-2.6.20.orig/arch/i386/kernel/ipipe.c
+++ linux-2.6.20/arch/i386/kernel/ipipe.c
@@ -777,6 +777,7 @@ int __ipipe_handle_irq(struct pt_regs re
     m_ack =3D 0;
    } else
     m_ack =3D 1;
+printk("%d %d %d\n", regs.orig_eax, irq, IPIPE_NR_IRQS);

    ipipe_load_cpuid();


TIA,
Jan


PS: Thanks for the vmlinux. The oops must be somewhere in
__ipipe_walk_pipeline - likely due to a inconsistent irq number.


--------------enigC92B18C93D786F42946DEC00
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFGMf8JniDOoMHTA+kRAvFCAJ40todtC3g4ysupdhCcTMBi1w6MVQCfUnji
BBZ3fzmIKp8c7wtyln7llNM=
=u8Wi
-----END PGP SIGNATURE-----

--------------enigC92B18C93D786F42946DEC00--

