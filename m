Message-ID: <441B2204.1070406@domain.hid>
Date: Fri, 17 Mar 2006 21:54:28 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig12EBD621CE0EA9342C6A6E9C"
Sender: jan.kiszka@domain.hid
Subject: [Xenomai-core] O(1) scheduler broken
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai-core <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig12EBD621CE0EA9342C6A6E9C
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi,

I just wanted to test how much the worst-cast jitters improve when
running multiple timed threads over the O(1) scheduler instead of the
default one. Unfortunately, it already crashes my box with the standard
latency test. All debug stuff on and serial console attached still does
not give any output. Looks like a really fatal scheduler crash. :(

Anyone any ideas?
Jan


--------------enig12EBD621CE0EA9342C6A6E9C
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFEGyIEniDOoMHTA+kRAt06AJ9fG8G/vCk3UE5f3aaKdV4LrOeDjgCeJoNg
Ta32NVVCKExecR6jsJC8wQI=
=1AKs
-----END PGP SIGNATURE-----

--------------enig12EBD621CE0EA9342C6A6E9C--

