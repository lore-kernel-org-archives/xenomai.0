Message-ID: <45D2E1D1.6060407@domain.hid>
Date: Wed, 14 Feb 2007 11:17:53 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] CONFIG_PREEMPT & irqbench
References: <45D25145.3000407@domain.hid>
	<45D2CE27.5040303@domain.hid> <45D2CF9E.40308@domain.hid>
	<45D2DD6C.9010005@domain.hid>
In-Reply-To: <45D2DD6C.9010005@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig1F3F072983A46A89076F3FA4"
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
To: Markus.Franke@domain.hid
Cc: Xenomai-help@domain.hid

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig1F3F072983A46A89076F3FA4
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Markus Franke wrote:
>> Hmm, I should have better said "tiny". This experience is based on
>> I-pipe tracer observations, and I guess you don't have that thing on,
>> have you?
>=20
> I have set:
>=20
> ---snip---
> # CONFIG_IPIPE_DEBUG is not set
> CONFIG_IPIPE_TRACE_ENABLE_VALUE=3D0
> ---snap---
>=20
> in both kernels (either with preempt or without).
>=20
>> How much is the difference? How long did you measure to exclude noise.=

>=20
> The difference is about 1 us (in average and worst case) when running
> irqloop in IRQ handler mode.
>=20
> I have been running the measurements for 1 minute under heavy load with=

> an interrupt frequency of 1 ms. This gives 60000 samples. Is this too
> less in order to exclude noise?

1 us is definitely in the noise region even on today's high-end PCs,
specifically when running the test that short. 1/2 hour, or better
several hours are required to gain reliable worst-case numbers.

Regarding the average, your test duration is likely enough. It indicates
that CONFIG_PREEMPT worsens the cache hit-rate slightly.

Jan


--------------enig1F3F072983A46A89076F3FA4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFF0uHSniDOoMHTA+kRAs1TAJ9dgA+SaoJR6VY5W5A295W/4zUIwQCggM8r
w3C9ZAFLHAGydKzT7QnczVM=
=lIKY
-----END PGP SIGNATURE-----

--------------enig1F3F072983A46A89076F3FA4--

