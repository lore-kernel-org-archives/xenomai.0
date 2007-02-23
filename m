Message-ID: <45DF7933.6090803@domain.hid>
Date: Sat, 24 Feb 2007 00:30:59 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig55A328B95587156D0F1C4A2F"
Sender: jan.kiszka@domain.hid
Subject: [Xenomai-core] [RFT] RTnet on x86_64
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: rtnet-users <rtnet-users@domain.hid>
Cc: rtnet-developers <rtnet-developers@domain.hid>, xenomai-core <xenomai@xenomai.org>, xenoma-help <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig55A328B95587156D0F1C4A2F
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Hi,

recent development on Xenomai and the underlying I-pipe patch [1]
reached a point where real experiments on yet another architecture for
RTnet are starting to make sense.

In fact, RTnet has been enabled to build over x86_64 already two weeks
back, including a necessary fix to the RTDM layer. I just checked again:
it still compiles fine. 8)

I'm lacking a test platform, so _you_ have the unique chance to be the
first person running RTnet on 64 bits! Grab a 2.6.19 kernel and the
latest I-pipe patch [2], checkout Xenomai [3] and RTnet trunk [4]. Put
everything on some native 64-bit Linux installation and give it hell.

Ah, and don't forget to report your findings!

Jan

[1] https://mail.gna.org/public/xenomai-core/2007-02/msg00205.html
[2] http://download.gna.org/adeos/patches/v2.6/x86_64/
[3] https://gna.org/svn/?group=3Dxenomai
[4] http://sourceforge.net/svn/?group_id=3D68976


--------------enig55A328B95587156D0F1C4A2F
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFF33kzniDOoMHTA+kRAv02AJsEibH0GIfirkYuZGsdQ71o8F1ZfwCfeRcL
/HkbMz8hvic82YRqFLTCEwo=
=TyaN
-----END PGP SIGNATURE-----

--------------enig55A328B95587156D0F1C4A2F--

