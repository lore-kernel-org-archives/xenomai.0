Message-ID: <45D0EDBC.5020402@domain.hid>
Date: Mon, 12 Feb 2007 23:44:12 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] interrupt latencies (irqloop/irqbench)
References: <45D0E411.4010807@domain.hid>
In-Reply-To: <45D0E411.4010807@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig2B7BB4D67E0B055311FCF11A"
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
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig2B7BB4D67E0B055311FCF11A
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Markus Franke wrote:
> Dear all,
>=20
> I am doing some latency benchmarks with irqbench/irqloop.
> Everything works fine with irqloop in testmode (1=3Duser, 2=3Dkernel an=
d
> 3=3Dirq handler) But when trying to start with testmode 4=3Dhard IRQ
> handler, I get the following message:
>=20
> ---snip---
> irqloop: error starting test: Resource temporarily unavailable
> ---snap---
>=20
> This occurs somewhere when calling:
>=20
> 	ioctl(benchdev, RTTST_RTIOC_IRQBENCH_START, &config)
>=20
> Any quick suggestions how to solve this problem?

This test mode exploits the I-pipe support for multiple domains
intensively. By default, Xenomai is configured to be the topmost domain
and is optimised for this use case. But it can also be "second-best" and
let someone else be first in the interrupt pipeline - e.g. xeno_irqloop.
To achieve this, switch off CONFIG_XENO_OPT_PIPELINE_HEAD (nucleus
option) and retry the test.

But while watching the (probably) impressive numbers, keep the
restricted usage scenario of such stacked domains in mind. This kind of
super domains lacks any RTOS environment that Xenomai provides. It's
only useful for simple jobs that can be done within an IRQ handler and
do not need an RT-scheduler.

> By the way: I read already the provided document in "txt" folder.
>=20

Then there is a bug - in the doc. :)

Jan


--------------enig2B7BB4D67E0B055311FCF11A
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iD8DBQFF0O2/niDOoMHTA+kRAqBvAJsEyMUHrpjgbKQDZfR+jfj9IKqLQwCfRDRy
Lut4vLnQS3TZDPG28LV6tFs=
=gI/5
-----END PGP SIGNATURE-----

--------------enig2B7BB4D67E0B055311FCF11A--

