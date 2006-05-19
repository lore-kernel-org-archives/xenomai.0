Message-ID: <446E08CF.6060505@domain.hid>
Date: Fri, 19 May 2006 20:05:03 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] Almost running - kernel BUG in add_preempt_count
	at	kernel/sched.c:2819!
References: <B4D14EA407C38B4DAF92B8EAC9249D7F0179D3BC@mspex01.go.mts.com>
In-Reply-To: <B4D14EA407C38B4DAF92B8EAC9249D7F0179D3BC@mspex01.go.mts.com>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigAF3BB5E8CA5C023DE09FF466"
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
To: "Rosenow, Jim" <Jim.Rosenow@domain.hid>
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigAF3BB5E8CA5C023DE09FF466
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Rosenow, Jim wrote:
> Hi,
>=20
> I've almost got my mvme5500 running.  I get the following error when bo=
oting up.
>=20
> kernel BUG in add_preempt_count at kernel/sched.c:2819!
>=20
> Oops: kernel access of bad area, sig: 11 [#1]
>=20
> I'm a little new at this and don't know whether I'm looking at a xenoma=
i problem, an adeos problem, or something else.
>=20
> Any help and direction would be appreciated.
>=20

If unsure where the problem comes from, try to boot a clean kernel
(unpatched) first, then a patched one but with disabled ipipe, and then
one with disabled xenomai. If the bug seems to be ipipe/xeno-related,
please report the patch and the xenomai versions, and also any potential
board-specific patches.

Jan


--------------enigAF3BB5E8CA5C023DE09FF466
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFEbgjPniDOoMHTA+kRAiNVAJ4yxTN5U4vuaH9d6xrdV9HSDNhrEwCfcwyW
bMikWwrdwmQfIHF8RnFHI58=
=1ICw
-----END PGP SIGNATURE-----

--------------enigAF3BB5E8CA5C023DE09FF466--

