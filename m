Message-ID: <47C02848.70604@domain.hid>
Date: Sat, 23 Feb 2008 15:06:00 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <47BF446E.50300@domain.hid>
In-Reply-To: <47BF446E.50300@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigB6F1FB0F1A8D9B5E4BAD75B7"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-help] gpioirqbench: measuring external interrupt
	latencies
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Wolfgang Grandegger <wg@domain.hid>
Cc: xenomai-help <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigB6F1FB0F1A8D9B5E4BAD75B7
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Wolfgang Grandegger wrote:
> Hello,
>=20
> I'm proud to announce "gpioirqbench", a benchmark tool to measure
> external interrupt latencies. It is derived from Jan's irqbench [1] for=

> the PC. Instead of using the serial or parallel port, it uses GPIO pins=

> on embedded systems. It measures the time between the generation of an
> interrupt triggered by a GPIO pin and the reply by either the interrupt=

> service routine, a kernel-space task or a user-space task. As reply,
> another GPIO pin will be toggled. The setup consists of two systems, th=
e
> log host and the test target. The log host triggers the interrupt on th=
e
> test target and measures the latency. This benchmark is primarily for
> Xenomai/RTDM, but it can also be used for plain Linux or even Linux-rt
> (with the real-time preemption patch).

Nice stuff! Still I have a few conceptual questions: :->

1. Why do you need a Xenomai measurement host? On first glance, you are
   just spinning on the reply for the RT target. Why not use plain Linux
   for this to increase portability? Most beautiful would be a pure
   userspace approach like for irqbench. What prevents this here?

2. Do you see a chance to integrate the target'S GPIO interface into the
   exiting irqbench backend? That would make it easy to merge the
   Xenomai version into the tree.

Jan


--------------enigB6F1FB0F1A8D9B5E4BAD75B7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.4-svn0 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iD8DBQFHwChLniDOoMHTA+kRAs+jAJ9jUJfmoLU1wkEQXuF3XHYUs/2xngCfdjhy
IJGENDH9aRF8nr2Xj/CI4UQ=
=QbjH
-----END PGP SIGNATURE-----

--------------enigB6F1FB0F1A8D9B5E4BAD75B7--

