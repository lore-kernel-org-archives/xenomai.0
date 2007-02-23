Message-ID: <45DEFBEA.7010407@domain.hid>
Date: Fri, 23 Feb 2007 15:36:26 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] latency hangs on AT91RM9200
References: <45DECFAF.60304@domain.hid>
	<45DEE913.9080809@domain.hid>	<45DEF122.2060406@domain.hid>
	<45DEF605.2060402@domain.hid> <45DEF6AA.5030609@domain.hid>
In-Reply-To: <45DEF6AA.5030609@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig0B2BF11965A81BF9F0C9AE9C"
Sender: jan.kiszka@domain.hid
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Steven Scholz <steven.scholz@domain.hid>
Cc: Xenomai-core@domain.hid

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig0B2BF11965A81BF9F0C9AE9C
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Steven Scholz wrote:
> Gilles,
>=20
>>> Sure but I would still not expect the system to hang!
>>> As I said missing a deadline is bad but ok.
>>> But hanging the whole system is not quite ok.
>> I want this bug solved too, especially since I am not sure that we wil=
l
>> only see it with too short periods.
>=20
> Makes us two! ;-)
>=20

BTW, do you have the nucleus option "disable priority coupling" set or
not in your config (the latter is default, ie. it's on)? The other bug
is triggered when prio coupling is on, and doesn't appear while it's
off. Just to collect more patterns...

Jan


--------------enig0B2BF11965A81BF9F0C9AE9C
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFF3vvqniDOoMHTA+kRArHVAJ40u+5xgFSSQrrCf1H1gHTnyG//2wCfbp/3
h5rBdWYlaEI2DFp+T9gGZRw=
=d0Ph
-----END PGP SIGNATURE-----

--------------enig0B2BF11965A81BF9F0C9AE9C--

