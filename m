Message-ID: <444118FF.7020509@domain.hid>
Date: Sat, 15 Apr 2006 18:02:07 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] [PATCH] detect problematic kernel configs
References: <443E9A8D.2090300@domain.hid>
	<17473.3055.737663.656203@domain.hid>
In-Reply-To: <17473.3055.737663.656203@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigBE336643BCD20059172EE211"
Sender: jan.kiszka@domain.hid
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai-core <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigBE336643BCD20059172EE211
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Gilles Chanteperdrix wrote:
> Jan Kiszka wrote:
>  > Hi,
>  >=20
>  > this patch tries to reduce the traps newbies may tap by leaving (for=
 us)
>  > well-known problematic kernel switches on. And are there any futher =
I
>  > forgot, e.g. on other archs?
>  >=20
>  > Jan
>  > Index: ksrc/arch/i386/Kconfig
>  > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>  > --- ksrc/arch/i386/Kconfig	(revision 924)
>  > +++ ksrc/arch/i386/Kconfig	(working copy)
>  > @@ -194,3 +194,19 @@ depends on XENO_OPT_NUCLEUS
>  >  source "drivers/xenomai/Kconfig"
>  > =20
>  >  endmenu
>  > +
>  > +if XENOMAI =3D y
>  > +
>  > +comment "WARNING: Potential latency killers detected!"
>  > +        depends on PM || ACPI || CPU_FREQ
>  > +
>  > +comment "Power Management (PM)"
>  > +        depends on PM
>  > +
>  > +comment "ACPI"
>  > +        depends on ACPI
>=20
> Only ACPI_PROCESSOR is a latency killer.
>=20

Good point. Are there also some more fine-grained switches under
CONFIG_PM? Never tried this in details, always picked the safe way.

Jan


--------------enigBE336643BCD20059172EE211
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFEQRj/niDOoMHTA+kRAq9VAJ4qhU7JCuWEUxEtP3omskqmJyXSpQCePjNP
6sAQDyrer8EDMfMZ//mBqhM=
=a+kb
-----END PGP SIGNATURE-----

--------------enigBE336643BCD20059172EE211--

