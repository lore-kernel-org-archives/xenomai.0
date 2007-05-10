Message-ID: <46434561.2090309@domain.hid>
Date: Thu, 10 May 2007 18:16:33 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <20070510120938.307800@domain.hid>
In-Reply-To: <20070510120938.307800@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigF4B2F23906A8D38C61D0EBD5"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-help] high latency with Intel Core 2 Duo
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Karl Reichert <Karl-Trampe@domain.hid>
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigF4B2F23906A8D38C61D0EBD5
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Karl Reichert wrote:
> Hello,
>=20
>  I'm using an Intel Core 2 Duo at work and an AMD XP3000+ at home. I in=
stalled Xenomai 2.3.1 with nearly same configuration at both and run the =
xeno-test. I get 10 times higher latency with Core 2 Duo. How is it possi=
ble? May the SMP be the reason?

SMP surely increases latencies (more synchronisation overhead), but the
tests you ran were also far to short for a thorough comparison. 2 us
worst-case is far too good, even on high end. Also 20 us on loaded SMP
boxes may not hold. Leave the test running for a longer period ("-T"
parameter, I think).

Jan


--------------enigF4B2F23906A8D38C61D0EBD5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFGQ0VhniDOoMHTA+kRAvuZAJ0d7Ad4bN+N/OF46aQbh2xpmKqAKgCfSqAb
h6+hnn9Ik0UTfX9CJ8wycac=
=9XW3
-----END PGP SIGNATURE-----

--------------enigF4B2F23906A8D38C61D0EBD5--

