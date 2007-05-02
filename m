Message-ID: <463890DF.9040604@domain.hid>
Date: Wed, 02 May 2007 15:23:43 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <26575694.1178110645829.JavaMail.ngmail@domain.hid>
In-Reply-To: <26575694.1178110645829.JavaMail.ngmail@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigA12AC20AF32634C6CFA3CE0D"
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
--------------enigA12AC20AF32634C6CFA3CE0D
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

M. Koehrer wrote:
> Hi Jan,
>=20
> I have looked closed into that issue.
> For that I have added a global array that is written within =20
> __ipipe_handle_irq() (file arch/i386/kernel/ipipe.c):
>=20
>                 extern int xxx_int[];
>                 irq =3D ~irq;
>=20
>                 xxx_int[0] =3D irq;
>=20
> #ifdef CONFIG_X86_LOCAL_APIC
>                 {
>                         unsigned vector =3D irq + FIRST_EXTERNAL_VECTOR=
;
>                         if (vector >=3D FIRST_SYSTEM_VECTOR)
>                                 irq =3D ipipe_apic_vector_irq(vector);
>                 }
>=20
>                  xxx_int[1] =3D irq;
>=20
>=20
> This global variable is printed out within the kernel trap.
> It returns the values 0xcf and 0xe0 (207 and 224) for xxx_int[0], xxx_i=
nt[1].
> And this is the really strange thing as the IRQ for the e1000 should be=
 219 (on a non-adeos-patched kernel).
> I do not know what happens here, but it looks really strange...
>=20

Please make xxx_irq per-cpu to exclude ugly races with the second CPU
handling IRQs in parallel. Also re-apply Philippe's vectoring
instrumentation and post the full kernel log to have a consistent picture=
=2E

Jan


--------------enigA12AC20AF32634C6CFA3CE0D
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFGOJDfniDOoMHTA+kRArZEAJwMzt8B/EuwMKKiwWJUqao2lbg9ewCeMN7R
y+VZc3nItJ2uE6QdHLVohM8=
=XqHy
-----END PGP SIGNATURE-----

--------------enigA12AC20AF32634C6CFA3CE0D--

