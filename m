Message-ID: <44E5C769.4050605@domain.hid>
Date: Fri, 18 Aug 2006 15:58:01 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] [PATCH] speed up building of posix apps
References: <44E5ACFA.50905@domain.hid>
	<17637.50472.580142.331066@domain.hid>
In-Reply-To: <17637.50472.580142.331066@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigDBBAE67B22E98F17C1EF140B"
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
--------------enigDBBAE67B22E98F17C1EF140B
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Gilles Chanteperdrix wrote:
> Jan Kiszka wrote:
>  > Hi,
>  >=20
>  > with the growing number of wrapped posix applications also their fai=
rly
>  > slow build process became visible. It somehow scaled badly.
>  >=20
>  > I had the idea to pass all wrapping commands to the linker via a fil=
e
>  > for quite some time. Now I tried it and it gives a nice speedup of
>  > roughly 400% for me when building typical single-file apps (mileage =
may
>  > vary, I'm building on vmware box...). Moreover, it beautifies the
>  > compiler output.
>  >=20
>  > Tested on various setups, no regressions known so far.
>  >=20
>  > Jan
>  >=20
>  >=20
>  > PS: What about the silence-libtool patch? I've heard neither ack nor=

>  > nack so far.
>  > Index: configure.in
>  > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>  > --- configure.in	(revision 1453)
>  > +++ configure.in	(working copy)
>  > @@ -525,8 +525,7 @@ XENO_USER_APP_CFLAGS=3D$XENO_USER_CFLAGS
>  >  XENO_USER_CFLAGS=3D"$XENO_USER_CFLAGS -D__IN_XENO__ -Wstrict-protot=
ypes"
>  >  XENO_USER_APP_LDFLAGS=3D$XENO_USER_LDFLAGS
>  > =20
>  > -XENO_POSIX_WRAPPERS=3D`while read symbol; do echo -n "-Wl,--wrap,$s=
ymbol "; done \
>  > -        < $srcdir/src/skins/posix/posix.wrappers`
>  > +XENO_POSIX_WRAPPERS=3D"-Wl,@`cd $srcdir && pwd`/src/skins/posix/pos=
ix.wrappers"
>=20
> Does not work here: the @ is passed to ld which does not know how to
> handle it.
>=20
>=20

Mmm, which version of ld do you have? If it's different from 2.16.91,
please check if "man ld" says something about the "@file" option.

Also, could you mail me the output of the build run?


--------------enigDBBAE67B22E98F17C1EF140B
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFE5cdpniDOoMHTA+kRAi75AJ9RIkn2dBsy0SWHn3VbbI4b7U20qwCfcuFK
CFz80B4K2kmJFUEB/A2KfKA=
=nhrt
-----END PGP SIGNATURE-----

--------------enigDBBAE67B22E98F17C1EF140B--

