Message-ID: <45CB42EB.400@domain.hid>
Date: Thu, 08 Feb 2007 16:34:03 +0100
From: Jan Kiszka <kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] 2.6.20 compiling problems
References: <45CB3B5C.9020200@domain.hid>
In-Reply-To: <45CB3B5C.9020200@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig23296A9C54B4AB743EE0AE14"
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Maksym Veremeyenko <verem@domain.hid>
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig23296A9C54B4AB743EE0AE14
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Maksym Veremeyenko wrote:
> Hi!
>=20
> i try to compile xenomai-2.3.0 + kernel-2.6.20 +
> adeos-ipipe-2.6.20-i386-1.7-01 but get a compiler errors:
>=20
> kernel/xenomai/nucleus/registry.c:71:70: error: macro "DECLARE_WORK"
> passed 3 arguments, but takes just 2
> kernel/xenomai/nucleus/registry.c:71: warning: type defaults to =E2=80=98=
int=E2=80=99 in
> declaration of =E2=80=98DECLARE_WORK=E2=80=99
> kernel/xenomai/nucleus/registry.c: In function =E2=80=98registry_proc_s=
chedule=E2=80=99:
> kernel/xenomai/nucleus/registry.c:388: error: =E2=80=98registry_proc_wo=
rk=E2=80=99
> undeclared (first use in this function)
> kernel/xenomai/nucleus/registry.c:388: error: (Each undeclared
> identifier is reported only once
> kernel/xenomai/nucleus/registry.c:388: error: for each function it
> appears in.)
> make[3]: *** [kernel/xenomai/nucleus/registry.o] Error 1
> make[2]: *** [kernel/xenomai/nucleus] Error 2
> make[1]: *** [kernel/xenomai] Error 2
> make: *** [kernel] Error 2
>=20

That's due to the work queue changes in 2.6.20. You need latest Xenomai
SVN, either v2.3.x or trunk.

Jan


--------------enig23296A9C54B4AB743EE0AE14
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFFy0LrncNeS9Q0k+IRAhTzAJ9LR2zPi63S/cyk4ylcXif0Ty6xvgCgz+S1
TA5z68iA5yi/j74h+yc+vU8=
=F7LF
-----END PGP SIGNATURE-----

--------------enig23296A9C54B4AB743EE0AE14--

