Message-ID: <455DCBAB.4090204@domain.hid>
Date: Fri, 17 Nov 2006 15:48:11 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] System freezes with Xenomai 2.2.5 and kernel 2.6.17
References: <20061117143512.191580@domain.hid>
In-Reply-To: <20061117143512.191580@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig07AF9D932501E8320373AEC9"
Sender: jan.kiszka@domain.hid
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: karre@domain.hid
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig07AF9D932501E8320373AEC9
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

karre@domain.hid wrote:
> Hi,
>=20
> I tried to install a real time system using Suse Linux 10.1 with a Vani=
lla-Kernel 2.6.17 and Xenomai 2.2.5.
>=20
> There were no error messages except "Cannot determine dependencies of m=
odule reiserfs", though the system was bootable and actually had access t=
o reiserfs-partitions.
>=20
> Another suspicious fact was numberous "nothing to do"-messages during c=
ompilation of Xenomai.

User-space part, I guess. Likely you already built it, no?

>=20
> Now the system is bootable and Xenomai reported that hal&x86, real-time=
 nucleus, nataive API, POSIX and RDTM services had started. Unfortunately=
, the system freezes unrecoverably shortly after login.

=2Econfig, please. I'm running such a setup (SuSE 10.1, 2.6.17.14, latest=

Xenomai) successfully on my notebook.

Please make sure, that your build is really consistent. When in doubt,
try a "make clean; make; make modules_install install" cycle and check
if it helps. Could you have accidentally mixed up modules from some
non-Xenomai 2.6.17-build with the Xenomai-enabled version?

>=20
> Can this be cause of I couldn't include "Interrupt pipeline" into the k=
ernel? There was no way to elect it in menuconfig, there was --- instead =
of [ ], [*] or [M] beneath this option.

The "---" means that you cannot disable this essential feature, it will
be forcibly compiled-in when you enable Xenomai.

>=20
> Thank you in advance for any advice!
>=20
> Richard
>=20

Jan


--------------enig07AF9D932501E8320373AEC9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFFXcurniDOoMHTA+kRAm8DAJ93SEMQiMNw1/3hyNSHeaTvK3k39QCaAtqK
hRyaPyC3vYJxwfHFWsVcADQ=
=bZMr
-----END PGP SIGNATURE-----

--------------enig07AF9D932501E8320373AEC9--

