Message-ID: <46850218.40909@domain.hid>
Date: Fri, 29 Jun 2007 14:59:04 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <op.tuom7dvpt06gyn@domain.hid>
In-Reply-To: <op.tuom7dvpt06gyn@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigDE21B223CD8A18506E714564"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-help] Kompiling an RT Kernel Module
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Axel Beierlein <belatronix@domain.hid>
Cc: "Xenomai-help@domain.hid" <Xenomai-help@domain.hid>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigDE21B223CD8A18506E714564
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Axel Beierlein wrote:
> Hello,
>=20
> Now a few hours i try to compile a simple file as an RT Kernel Module a=
nd =20
> i get errors over errors.
> I have included the kernel sources and the xenomai sources in different=
 =20
> ways. I get many "in file includes" and other errors.
>=20
> What are the minimal requirements to compile such a native rt module?  =

> (include path, lib path ....)

Just a standard kernel module makefile you'll find almost anywhere + a
Xenomai include path, ie.

EXTRA_CFLAGS :=3D -I$(KSRC)/include/xenomai
(taken from your cited example)

> I can?t use the output of xeno-config cause the rootfs on my target(ppc=
) =20
> is mounted over NFS from my development host(i386). I have a look at th=
e =20

You don't need to for a pure kernel module target. Just pick that
example and follow its instructions: Clear APPLICATIONS, put your module
into MODULES, then run make: "make KSRC=3D<kernel-src>". Must work, reall=
y.

> makefile http://svn.gna.org/svn/xenomai/trunk/examples/common/Makefile =
but =20
> that solved not my probs. On the contrary it confuses me more and more =
=20
> cause i don?t understand why the Makro KSRC is defined as an pointer to=
 =20
> the librarys and this Makro was also used to point to the Kernelheaders=
=2E

Try to find out what is behind /lib/modules/`uname -r`/build on your
box... :->
(Note that "$(shell <command>)" in a makefile means `<command>` in your
shell.)

>=20
> Is there anywhere an example working with support for cross-developemen=
t?

If you use a cross-compiler, additionally pass its prefix like this:

make KSRC=3D... CROSS_COMPILE=3D...

If you compile for a different arch, add ARCH=3D... as well.

>=20
> I?ve compiled the running kernel with all xenomai stuff inside (no =20
> modules) but with module load support on.
>=20
> Axel
>=20
> sorry for my terrible English ;-)

It's very well readable! I guess you haven't seen truly terrible English
on mailing lists yet. ;)

Jan


PS: If someone feels like adding a few words / references about "how do
I compile a kernel module for Xenomai?" to the wiki, please go ahead!


--------------enigDE21B223CD8A18506E714564
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFGhQIbniDOoMHTA+kRAvNAAJ90WSc/f7WloEGzTy8lQyfLJ+m2GgCfTm8W
MQBrSii4Ork5LYa6SNHPZSk=
=QSsx
-----END PGP SIGNATURE-----

--------------enigDE21B223CD8A18506E714564--

