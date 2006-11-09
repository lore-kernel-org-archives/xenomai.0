Message-ID: <45538D53.5090305@domain.hid>
Date: Thu, 09 Nov 2006 21:19:31 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] I-pipe patch for ARM S3C24xx (v4)
References: <E1GiChy-0006Bp-5K@mailer.emlix.com>
In-Reply-To: <E1GiChy-0006Bp-5K@mailer.emlix.com>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig92B02502A92EA1EF0204C0F8"
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
To: Sebastian Smolorz <ssm@domain.hid>
Cc: xenomai-core <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig92B02502A92EA1EF0204C0F8
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Sebastian Smolorz wrote:
> Hi all,
>=20
> now that the teething problems of my I-pipe port to the S3C24xx are cur=
ed=20
> (hopefully ...) I'm going to iterate it to v4. We've established a proj=
ect=20
> homepage for that port
> http://opensource.emlix.com/ipipe-s3c24xx/
> in order to concentrate the source code and information at one point. P=
robably=20
> tomorrow I will come up with a patch in order to address point 2 in my =
email=20
> from 27.10.2006 ([1]). After that I can go to v5 of my patch and beg fo=
r=20
> integration. :-)

Nice to hear.

>=20
> However, there is one disturbing issue. When I execute
>=20
> dd if=3D/dev/zero of=3D/dev/null
>=20
> and the latency test in userspace with a period not less than 150 us th=
e worst=20
> case latency is about 220 us. But when I start latency with -p 100 I ge=
t a=20
> softlock like the one attached. I guess this is the same problem as Det=
lef=20
> Vollmann described in [2]. So I think it's time for a big fat ARM-speci=
fic=20
> warning in the troubleshooting file and perhaps a modification of the=20
> testsuite so that if being compiled for ARM the default sample periods =
are=20
> greater than the 100 us now.

Something is preventing the watchdog kthread from being executed for
more than 10 s. Maybe this is just a sign that the systems is hopelessly
overloaded (what are average latencies?). Maybe it is a real IRQ or
scheduling issue in Linux caused by I-pipe. Maybe it is time to port the
I-pipe tracer... ;)

Jan


--------------enig92B02502A92EA1EF0204C0F8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFFU41TniDOoMHTA+kRAt1pAJwMJkAY0P6X7v+151IsayJdZA/OAQCfaP+J
O3ElW8ruGEGlN2FwVBrk2FM=
=popJ
-----END PGP SIGNATURE-----

--------------enig92B02502A92EA1EF0204C0F8--

