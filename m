Message-ID: <461D65BC.2090406@domain.hid>
Date: Thu, 12 Apr 2007 00:48:28 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigC385A1139ADF35B2F0858A1C"
Sender: jan.kiszka@domain.hid
Subject: [Xenomai-core] CAN_RAW, CAN_PROTO_RAW, and Socket-CAN
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
--------------enigC385A1139ADF35B2F0858A1C
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Hi Wolfgang,

something is inconsistent about CAN_RAW in RT-Socket-CAN compared to
plain Socket-CAN. Also, the latter doesn't know any CAN_PROTO_xxx unless
I oversee something. Please have a look.

(I received a private complaint of a user trying to compile rtcan_rtt
against 2.3.x.)

Jan


--------------enigC385A1139ADF35B2F0858A1C
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFGHWW8niDOoMHTA+kRAgGbAJ4iXZHJR4+11ppKy8jWI/OE7k3x/QCfcaTN
vYR6fINj939AbjHbditTbpU=
=gsCr
-----END PGP SIGNATURE-----

--------------enigC385A1139ADF35B2F0858A1C--

