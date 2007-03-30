Message-ID: <460C60E9.6010307@domain.hid>
Date: Fri, 30 Mar 2007 02:59:21 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigC3F53BC544E262C2339ED3C3"
Sender: jan.kiszka@domain.hid
Subject: [Xenomai-core] iovec overwriting by CAN stack
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Wolfgang Grandegger <wg@domain.hid>
Cc: xenomai-core <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigC3F53BC544E262C2339ED3C3
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Hi Wolfgang,

it's late, so I may have misread somecode, but don't you "update" the
iovec descriptors a user passes on send/recvmsg on return (namely
iovec_len)? I received some complaints about this /wrt to in-kernel CAN
stack usage.

I always considered the same well-know behaviour of RTnet a bug, but now
I found your code is doing this systematically, also for user space
callers. Is this behaviour undefined or even required according POSIX or
whatever?

Jan


--------------enigC3F53BC544E262C2339ED3C3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFGDGDpniDOoMHTA+kRAhblAJ9mOQqJcSic7ZhkVb9MlP8uoaDbTACfSO2/
8UmwQfkngYt4vWvT1PXShVs=
=a9am
-----END PGP SIGNATURE-----

--------------enigC3F53BC544E262C2339ED3C3--

