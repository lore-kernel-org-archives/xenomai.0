Message-ID: <45C8FA2B.5020806@domain.hid>
Date: Tue, 06 Feb 2007 22:59:07 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] Multiple NIC trouble
References: <cbe23c50702061337yc411319l881b9402e4677d6d@domain.hid>
In-Reply-To: <cbe23c50702061337yc411319l881b9402e4677d6d@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig6DA12B4D15E4F091CF689457"
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
To: Eric Noulard <eric.noulard@domain.hid>
Cc: Xenomai help <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig6DA12B4D15E4F091CF689457
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Eric Noulard wrote:
> I am about to begin to use Xenomai
> on a dual-core x86_64 box.
>=20
> I installed FC6 i386 (32bits) since the adeos patch for x86_64
> was not there when I did the install, I may go back
> to run xenomai on x86_64 since I install both systems (x86_64 and i386)=

>=20
> Nevertheless I have three 32bits kernels
>=20
> 2.6.19-vanilla     (pure kernel.org kernel)
> 2.6.20-rc1-rtXX (precompiled from Ingo Molnar)
> 2.6.19-xenomai (vanilla + adeos-ipipe-2.6.19-i386-1.6-03.patch)
>=20
> The box has 3 ethernet interface (2 on-board + 1 on an additionnal NIC)=

>=20
> eth0 is the additionnal NIC
> eth1,eth2 the on-board I/F
>=20
> eth1 used for corporate LAN
> eth0 "should" be used for private network (only 2 machines for now)
>=20
> With this config the machine boots properly with the non-xenomai
> kernels with eth1 and eth0 up and running.
>=20
> If I boot the xenomai kernel the machine hangs
> (even sysrq does not help) as soon as  the system tries to ifup eth0.
>=20
> If I disable eth0 the xenomai kernel boots until the end.
> If I try to ifup eth0 "manually" afterward I got the same "hang".
>=20
> I have no log and sysrq does not work !!
>=20
> How would you suggest me to investigate that problem?
>=20

 o check if you have MSI enabled, if yes, try to disable it

 o try cpus=3D1 or !SMP

 o check if ipipe-1.7-00 makes a difference (it shouldn't, the fixed
   issue in 1.6-03 showed a different bug pattern)

 o post your .config so that we can have a look

Jan


--------------enig6DA12B4D15E4F091CF689457
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFFyPosniDOoMHTA+kRAnR2AJ9d6tRXolHvLhO8fSwSJoSZhCj+oACeIclU
KrqjvCkktPGhAJGPv3irQgc=
=CBHg
-----END PGP SIGNATURE-----

--------------enig6DA12B4D15E4F091CF689457--

