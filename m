Message-ID: <45BE0272.5050401@domain.hid>
Date: Mon, 29 Jan 2007 15:19:30 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] Some Input needed about latency and cyclictest
	results
References: <ac3922a00701290419q529f609h61c1c910711dbc5e@domain.hid>
In-Reply-To: <ac3922a00701290419q529f609h61c1c910711dbc5e@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigF5897BC9E23E25B1B94A8B22"
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
To: Syed Amer Gilani <amg@domain.hid>
Cc: xenomai-help <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigF5897BC9E23E25B1B94A8B22
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Syed Amer Gilani wrote:
> I am currently in the process of writing a report about how well the
> realtime results are with xenomai for a project. For this i am of
> course using latency and cyclictest. But the results are somewhat odd.
> With Load from dd and external ping -f, latency returns results i am
> expecting: http://systec.de/dump/latency-load.png
> But without Load there is a odd "hole" from 3us to 5us:
> http://systec.de/dump/latency-noload.png
> Can this somehow be explained?

Maybe a cache granularity effect: either the caches are hot and can
serve most requests of the benchmark directly so that you get latencies
<3 us, or parts of them have been overwritten, and it takes typically >5
us to replace the required content.

> cyclictest also has this hole: http://systec.de/dump/cyclictest.png
> But i am not sure if i completely understand what cyclictest does. Is
> it the same as latency just for the posix skin?

Yes and no. latency can benchmark timed user space, kernel space, and
IRQ handler scenarios, but only for one event per program instance.
cyclictest can also run multiple events (tasks), but only in user space.
latency is using native+rtdm skin, cyclictest the posix skin. So the
best comparison between both tools is running a single task in user
space at the same interval with each of them (and let them run roughly
the same time...).

Jan


--------------enigF5897BC9E23E25B1B94A8B22
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFFvgJ4niDOoMHTA+kRArYAAJwLZ1bWFDq8ykukDlRMFs2g4678wQCfQTsO
4MrXdhiNRHsbOqfbyxyqGrk=
=pRLj
-----END PGP SIGNATURE-----

--------------enigF5897BC9E23E25B1B94A8B22--

