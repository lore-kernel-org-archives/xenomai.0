Message-ID: <49076938.6040806@domain.hid>
Date: Tue, 28 Oct 2008 20:34:16 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <4905B40D.5050109@domain.hid>
In-Reply-To: <4905B40D.5050109@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigC1AAA25171B66C6BFCCE3901"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-core] CAN filter issues
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Sebastian Smolorz <smolorz@domain.hid>
Cc: xenomai-core <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigC1AAA25171B66C6BFCCE3901
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Sebastian Smolorz wrote:
> Hi Wolfgang,
>=20
> we currently face an issue regarding the filtering of CAN messages sinc=
e=20
> Xenomai 2.4. It was introduced in rev. 2202 (I know it is long ago but =

> the problem popped up last week). The line in question is
>=20
> http://www.rts.uni-hannover.de/xenomai/lxr/source/ksrc/drivers/can/rtca=
n_raw_filter.c?v=3D2.3.5#064
>=20
> and
>=20
> http://www.rts.uni-hannover.de/xenomai/lxr/source/ksrc/drivers/can/rtca=
n_raw_filter.c?v=3D2.4.4#062
>=20
> respectively.
>=20
> What worries me is the removal of the AND-operation (can_id & can_mask)=
=2E=20
>  From my POV this offends the CAN specification which says that the CAN=
=20
> filter mask shall indicate which bits are taken into account when=20
> comparing a CAN identifier and which shall be seen as "don't care".
>=20
>  From your Changelog entry the reason for this modification was to be u=
p=20
> to date with the Linux Socket CAN project. So maybe there is also the=20
> need to bring up this topic on their ML, too.

No, this looks like a Xenomai-exclusive bug. If I quick-read mainline
correctly, this line prevents that bits in can_id which should be
ignored according to the mask can cause problems when they are set:

http://git.kernel.org/?p=3Dlinux/kernel/git/torvalds/linux-2.6.git;a=3Dbl=
ob;f=3Dnet/can/af_can.c;h=3D7d4d2b3c137ef6b84598d9bebd50b1a69dfaf707;hb=3D=
HEAD#l340

So, unless I'm now also misled, we are basically lacking a final

recv_filter->can_id &=3D recv_filter->can_mask;

in rtcan_raw_mount_filter. Wolfgang, correct?

Jan


--------------enigC1AAA25171B66C6BFCCE3901
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.8 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iEYEARECAAYFAkkHaT0ACgkQniDOoMHTA+mR1ACeOkI6VfL5O3vXEiAXapFYLNUL
VI8AmgKzH4mvbI8Hr1WleKCfAQppvSBa
=+Zyo
-----END PGP SIGNATURE-----

--------------enigC1AAA25171B66C6BFCCE3901--

