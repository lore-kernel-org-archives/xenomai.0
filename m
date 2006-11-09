Message-ID: <4553997C.5050304@domain.hid>
Date: Thu, 09 Nov 2006 22:11:24 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] I-pipe patch for ARM S3C24xx (v4)
References: <E1GiChy-0006Bp-5K@mailer.emlix.com> <45538D53.5090305@domain.hid>
	<200611092152.01896.Sebastian.Smolorz@domain.hid>
In-Reply-To: <200611092152.01896.Sebastian.Smolorz@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig4BCA3A0F52B8A66AA6C9909C"
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
To: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig4BCA3A0F52B8A66AA6C9909C
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Sebastian Smolorz wrote:
> Jan Kiszka wrote:
>> Sebastian Smolorz wrote:
>>> However, there is one disturbing issue. When I execute
>>>
>>> dd if=3D/dev/zero of=3D/dev/null
>>>
>>> and the latency test in userspace with a period not less than 150 us =
the
>>> worst case latency is about 220 us. But when I start latency with -p =
100
>>> I get a softlock like the one attached. I guess this is the same prob=
lem
>>> as Detlef Vollmann described in [2]. So I think it's time for a big f=
at
>>> ARM-specific warning in the troubleshooting file and perhaps a
>>> modification of the testsuite so that if being compiled for ARM the
>>> default sample periods are greater than the 100 us now.
>> Something is preventing the watchdog kthread from being executed for
>> more than 10 s. Maybe this is just a sign that the systems is hopeless=
ly
>> overloaded (what are average latencies?).
>=20
> They are 120-130 us.

Which is a good sign that the board is basically only flushing caches
when running the test at this frequency. Still the question remains if
the BUG is an expectable behaviour or a sign for hidden problems.

>=20
>> Maybe it is a real IRQ or=20
>> scheduling issue in Linux caused by I-pipe. Maybe it is time to port t=
he
>> I-pipe tracer... ;)
>=20
> With the latest Adeos upgrade for ARM the I-pipe tracer was integrated,=
 wasn't=20
> it? I was already taking its usage into account.

The arch-independent code is merged for ARM, but it still takes to port
ipipe-mcount.S and likely ipipe_read_tsc + related services. Not much to
do, though. Take a look at the code in PREEMPT_RT for the mcount part.

Jan


--------------enig4BCA3A0F52B8A66AA6C9909C
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFFU5mBniDOoMHTA+kRAorPAJ9EhgKFFyNqYE59kFscpWx/3kFdEgCeP8f3
XUf4fH0vmMhL7woTNa8q73M=
=B0gc
-----END PGP SIGNATURE-----

--------------enig4BCA3A0F52B8A66AA6C9909C--

