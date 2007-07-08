Message-ID: <4690B86C.1000907@domain.hid>
Date: Sun, 08 Jul 2007 12:11:56 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <2404.194.199.21.225.1181233422.squirrel@domain.hid>	<4668440F.7020706@domain.hid>	<20070608124927.1b789a9e@domain.hid>	<46693B6B.1010201@domain.hid>	<20070625175107.438849fa@domain.hid>	<467FF391.8020401@domain.hid>	<20070627105726.7db7a459@domain.hid>	<46825054.7030800@domain.hid>
	<20070629164326.15579570@domain.hid>
In-Reply-To: <20070629164326.15579570@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigC4CD76E3530B3C4F1108DDE0"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-core] measuring tasks execution time
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Daniel Simon <Daniel.Simon@domain.hid>
Cc: xenomai-core <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigC4CD76E3530B3C4F1108DDE0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Daniel Simon wrote:
> please find attached a new patch following these ideas:
>  (patch against svn trunk Revision: 2672)=20
>=20

Based on this version, I integrated your patch into my patch stack. The
actual rt_task_inquire interface is totally untested, but the rest
appears to cause no regressions here. See

http://www.rts.uni-hannover.de/rtaddon/patches/xenomai

namely the enhance-thread-stats.patch. It may depend on some of the
previous patches in the stack, but only organisationally, not technically=
=2E

You are welcome to test, fix, improve, or just use it. Looking forward
to your feedback!

Jan


--------------enigC4CD76E3530B3C4F1108DDE0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFGkLhsniDOoMHTA+kRAq38AJ0fn6olRa8V4voeNQrjr2Wg4ADmlgCfWFXA
pv5WRdnNJsQKmWv0mdMyNnU=
=xelX
-----END PGP SIGNATURE-----

--------------enigC4CD76E3530B3C4F1108DDE0--

