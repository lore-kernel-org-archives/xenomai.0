Message-ID: <45819EFA.2090908@domain.hid>
Date: Thu, 14 Dec 2006 19:59:06 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Adeos-main] Latency trace on ARM
References: <E1GutB2-0005VT-Vb@domain.hid>
In-Reply-To: <E1GutB2-0005VT-Vb@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigD9A913F4E488B690C319BA9E"
Sender: jan.kiszka@domain.hid
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: </public/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: Sebastian Smolorz <ssm@domain.hid>
Cc: adeos-main@gna.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigD9A913F4E488B690C319BA9E
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Sebastian Smolorz wrote:
> Hi,
>=20
> we all know that the latency test should not be run with a period of 10=
0 us=20
> because it easily gets locked up. The attached trace illustrates this p=
roblem=20
> in detail. It shows that a timer interrupt needs about 50 us to be proc=
essed.=20
> Furthermore, there is not enough time between two timer interrupts for =
the=20
> latency task to get all its work done.
>=20
> The current I-pipe tracer patch for ARM is available at=20
> http://opensource.emlix.com/ipipe-s3c24xx/download/ipipe-tracer-arm.pat=
ch_v4
>=20
> Comments welcome.

Something is still broken, given all those "N"s in Delay column. Is
there something like NMI at all on your board?

BTW, two asses the tracer's overhead, you may want to run some
consecutive ipipe_trace_specials and watch the result in the log. Should
be around 1.something per trace point.

Jan


--------------enigD9A913F4E488B690C319BA9E
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFFgZ76niDOoMHTA+kRAtjSAJ4hUSD1KWmlMw2uznAkhoNFz2dhcgCdFVWK
00hCVb5jLBH7bVQZ1G4RGYw=
=Aw6W
-----END PGP SIGNATURE-----

--------------enigD9A913F4E488B690C319BA9E--

