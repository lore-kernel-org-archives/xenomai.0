Message-ID: <46852AA1.40906@domain.hid>
Date: Fri, 29 Jun 2007 17:52:01 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <2404.194.199.21.225.1181233422.squirrel@domain.hid>	<4668440F.7020706@domain.hid>	<20070608124927.1b789a9e@domain.hid>	<46693B6B.1010201@domain.hid>	<20070625175107.438849fa@domain.hid>	<467FF391.8020401@domain.hid>	<20070627105726.7db7a459@domain.hid>	<46825054.7030800@domain.hid>	<20070629164326.15579570@domain.hid>	<46851E97.7030402@domain.hid>
	<20070629172907.698f9586@domain.hid>
In-Reply-To: <20070629172907.698f9586@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig08196B11BA9E458B7D07357D"
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
--------------enig08196B11BA9E458B7D07357D
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Daniel Simon wrote:
> On Fri, 29 Jun 2007 17:00:39 +0200
> Jan Kiszka <jan.kiszka@domain.hid> wrote:
>=20
>> Exectime is only updated on task switches. So you are not obtaining th=
e true
>> value when requesting your own data. Use the same formula for both cas=
es.
>=20
> yes, but like that the fraction of time spent in the current execution =
is not
> accounted, which might be sometimes useful (e.g. to integrate the cost =
of a
> feedback scheduler in the total control budget)

Yeah, true, I applied the inverse logic. However, this interface is
inconsistent, one should expects the same algorithm applied on both
local as well as remote task queries. Why do you differentiate?

>=20
> another potentially useful feature would be also accounting the executi=
on time
> spent in secondary mode... no idea on how to do that.=20
> BTW, Posix defines an optional CLOCK_THREAD_CPUTIME which is assumed to=
 provide
> this measure ?

This should work for shadow threads to retrieve their secondary-mode
runtime. Give it a try.

Jan


--------------enig08196B11BA9E458B7D07357D
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFGhSqhniDOoMHTA+kRAkLIAJ9RvZZd0J5KROAC8TOFuF0qLFfqHACfYrin
2kJKrxMczMrh7gwr0fLI5p8=
=lcGf
-----END PGP SIGNATURE-----

--------------enig08196B11BA9E458B7D07357D--

