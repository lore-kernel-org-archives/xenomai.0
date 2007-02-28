Message-ID: <45E57D55.10402@domain.hid>
Date: Wed, 28 Feb 2007 14:02:13 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] prepare-kernel options
References: <200702281217.36362.paul_c@domain.hid>
In-Reply-To: <200702281217.36362.paul_c@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig7CE6288FC41BA11D6A75F348"
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
Cc: xenomai-core <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig7CE6288FC41BA11D6A75F348
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Paul wrote:
> A little background - On Debian installations, a set of tools have been=
=20
> provided to allow kernel packages to be quickly & simply generated. It =
is=20
> something I do quite regularly with the following steps:
>  * Extract kernel sources in /tmp
>  * Apply patches
>  * Copy an existing .config over - Run `make oldconfig`
>  * make-kpkg binary-arch (produces kernel-image and kernel-header packa=
ges)
>  * Install/reboot
>=20
> It may sound a long winded method, but it does allow me to use the gene=
rated=20
> packages to install on any number of other machines.

[Related question from my side:]

Would you be willing to provide debian package generation rules for
Xenomai? Something that would spit out .deb files when calling, say,
"make deb KERNEL=3Dlinux-2.6.x.tar.bz2 CONFIG=3Dmy-kernel-config" in a
configured userland build directory? That way we could automatise binary
package generation for kernel, user libs, development headers, and
documentation. And that would allow us to finally distribute them for
generic targets like x86 and x86_64 along with the usual tar files.

I think such a feature (maybe later enhanceable by RPM) would both be
interesting for replicable custom installations as well as for a
reference kernel distribution to provide a Xenomai quick-start.

>=20
> The problem - prepare-kernel.sh creates symlinks to assorted files in t=
he=20
> Xenomai source tree. Not a problem if the same tree exists in the same =

> location on the target machine. As yet, there is no xenomai Debian pack=
age,=20
> and the build location may not be the same as the install location - Th=
is=20
> results in a large number of dangling symlinks which thwarts attempts t=
o=20
> compile out of tree modules using the kernel-headers package. I suspect=
 the=20
> same issues would exist for RPM packages and NFS mounted targets.
>=20
> A solution - Instead of creating symlinks, the files need to be copied =
in to=20
> the kernel source tree. Most people will use symlinks as it simplifies =
the=20
> `svn up`/make process and avoids having to run prepare-kernel each time=
=2E I=20
> propose a trivial patch that retains the original behaviour and provide=
s an=20
> option to turn off symlinks (patch attached).
>=20

Would this build procedure already help you?

http://www.rts.uni-hannover.de/xenomai/lxr/source/README.INSTALL?a=3Di386=
#203

Jan


--------------enig7CE6288FC41BA11D6A75F348
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFF5X1VniDOoMHTA+kRAiamAJ9DL3Ajtw1YuLLMfPCKws32TvNikQCeJY1G
4hBLgfg4Q8EI/jjqmBWqLS4=
=mdhK
-----END PGP SIGNATURE-----

--------------enig7CE6288FC41BA11D6A75F348--

