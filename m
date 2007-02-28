Message-ID: <45E58AFE.7020609@domain.hid>
Date: Wed, 28 Feb 2007 15:00:30 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] prepare-kernel options
References: <200702281217.36362.paul_c@domain.hid> <45E57D55.10402@domain.hid>
	<200702281351.46807.paul_c@domain.hid>
In-Reply-To: <200702281351.46807.paul_c@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig400A6AC33D715CB645F347E4"
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
To: Paul <paul_c@domain.hid>
Cc: xenomai-core <xenomai@xenomai.org>, rlenglet@domain.hid

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig400A6AC33D715CB645F347E4
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Paul wrote:
> On Wednesday 28 February 2007 13:02, Jan Kiszka wrote:
> <snip>
>> [Related question from my side:]
>>
>> Would you be willing to provide debian package generation rules for
>> Xenomai? Something that would spit out .deb files when calling, say,
>> "make deb KERNEL=3Dlinux-2.6.x.tar.bz2 CONFIG=3Dmy-kernel-config" in a=

>> configured userland build directory? That way we could automatise bina=
ry
>> package generation for kernel, user libs, development headers, and
>> documentation. And that would allow us to finally distribute them for
>> generic targets like x86 and x86_64 along with the usual tar files.
>=20
> To have a Debian rule set is indeed my ultimate goal (but I wouldn't wa=
nt t=20
> tread on anyone's toes if it is already in hand). - I suspect a number =
of=20

Romain once worked on this. Don't know what happened to his effort, if
something might be reusable or so. I CC'ed him.

> potential users would like to try Xenomai but are put off by kernel=20
> compilation... But rather than a `make deb` rule, a small script would =
be=20
> better - Debian's packaging system generates (amongst other things) a s=
ource=20
> tarball, and to include auto-generated files doesn't feel right.. Calli=
ng the=20
> `make dist` rule may solve that issue.
>=20
>> I think such a feature (maybe later enhanceable by RPM) would both be
>> interesting for replicable custom installations as well as for a
>> reference kernel distribution to provide a Xenomai quick-start.
>=20
> Indeed - Point a potential user to a repository, let them experiment wi=
th a=20
> (hopefully) working kernel, and when they need/want specific vmlinuz op=
tions,=20
> they have a reference point to work from. The "Debian way" also greatly=
=20
> simplifies the task of building packages.
>=20
> <snip>
>> Would this build procedure already help you?
>> http://www.rts.uni-hannover.de/xenomai/lxr/source/README.INSTALL?a=3Di=
386#203
>=20
> Ah, yes.. It's the same doc in the top level Xenomai tree ;)
>=20
> As Gilles has pointed out, there are already a couple of options in=20
> prepare-kernel.sh to aid package generation - If nobody else is working=
 on=20
> that area, I'll put a patch together over the next few days and submit =
it for=20
> review.
>=20

Great!

Jan


--------------enig400A6AC33D715CB645F347E4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFF5Yr+niDOoMHTA+kRAkGnAJ0Y95WM2p7S8xGVsdJXb6eMZ86O7QCfaonZ
CyPJhoQMBLxJUHfYe/hcwu8=
=Dack
-----END PGP SIGNATURE-----

--------------enig400A6AC33D715CB645F347E4--

