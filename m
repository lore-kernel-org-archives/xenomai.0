Message-ID: <443D3B03.3090208@domain.hid>
Date: Wed, 12 Apr 2006 19:38:11 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] question about the latency test running	on	Blackfin
References: <1CFEB358338412458B21FAA0D78FE86D042A2FEE@rennsmail02.eu.thmulti.com>	
	<1144294706.12272.32.camel@domain.hid>
	<4434BDBD.9060102@domain.hid>	
	<1144412822.21632.10.camel@domain.hid>
	<44365CFA.1020506@domain.hid>	
	<1144809772.7286.47.camel@domain.hid> <443CB06C.2080202@domain.hid>
	<1144844898.7808.34.camel@domain.hid>
In-Reply-To: <1144844898.7808.34.camel@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigB264D1ACA456E5F47FE9FE73"
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
To: adam li <yi.li@domain.hid>
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigB264D1ACA456E5F47FE9FE73
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

adam li wrote:
> Thanks for the suggestions.=20
>=20
> I am using Blackfin 533 on the STAMP board. The core frequency is 398
> MHz.These data are got when there is not special workload, only uClinux=

> running.
>=20
> I tried to run "latency" test in Mode 0 (user space task) for 60 sec,
> with the "calibrator" as work load, this time the worst case schedule
> latency becomes 82 us.=20

Dare to run the test for a longer period than just a minute. It may
happen that certain events (IRQs) hit your RT test only vary rarely, but
still cause a few more us latency. Basically, this is one reason why you
should run multiple i/o loads in parallel, as each of them can delay
your critical real-time job a bit more.

>=20
> As you mentioned:
>=20
> ">Yes, Xenomai is a hard-RT system. But this doesn't depend on a
> specific
>> worst-case latency number, rather on the fact that a hardware-dependen=
t
>> upper limit can be provided that is independent of the (here:) Linux l=
oad"
>=20
> Can I understand like this: Given the hardware and the workload, the
> upper limit (worst case latency) is "determinative", regardless of what=

> is happening in Linux?

Yes. Xenomai's worst-case latencies do not depend on what kind of
programs are running under Linux and what Linux services they use, they
only depend on the hardware devices (IRQs, buses, etc.) they are using.

>=20
> But still another confusion, as we can see from the test result, given
> the hardware and the workload, each time running the "latency" test cas=
e
> will result in an average latency and a worst case value, but how can w=
e
> "make sure" that using such hardware and such workload, the worst case
> latency is "sure" to bellow certain upper limit? In other words, is it
> possible that in some case, the worst case latency may go beyond the
> observed upper limit? Or can I say that, there is such possibility, but=

> the probability is rare (statistically).
>=20

In theory, by a complete static code analysis in combination with a good
model of all involved hardware components of the system. But this is
impractical for such complex systems.

Therefore, one tries to reduce the amount of code to analyse and then
derives a rough model from it. Xenomai helps here by decoupling the RT
core from Linux with all its applications. Furthermore, one defines a
simplified hardware model for a specific system. And then tests are
performed to measure worst-case latencies of individual components or
the whole application to verify the model and generate input for
projections of non-testable scenarios.

Well, in practice, one only measures a lot of stuff over a real long
time, takes the numbers, multiplies them by 2 (or more), and prays that
this will be good enough. :)

Jan


--------------enigB264D1ACA456E5F47FE9FE73
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFEPTsDniDOoMHTA+kRAruSAJ9Jv4cL1/45TzSjmb3MC2I8XHnE6ACeKDSW
GOWN2v0XvS8jr7Iv6loqYSs=
=c2KW
-----END PGP SIGNATURE-----

--------------enigB264D1ACA456E5F47FE9FE73--

