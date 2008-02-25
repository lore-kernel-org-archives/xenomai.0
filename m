Message-ID: <47C27772.1060005@domain.hid>
Date: Mon, 25 Feb 2008 09:08:18 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <47BF446E.50300@domain.hid> <47C02848.70604@domain.hid>
	<47C0819E.8040000@domain.hid>
In-Reply-To: <47C0819E.8040000@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigD787E08E8311D2420CCED2DC"
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
--------------enigD787E08E8311D2420CCED2DC
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable

Wolfgang Grandegger wrote:
> Jan Kiszka wrote:
>> Wolfgang Grandegger wrote:
>>> Hello,
>>>
>>> I'm proud to announce "gpioirqbench", a benchmark tool to measure
>>> external interrupt latencies. It is derived from Jan's irqbench [1] f=
or
>>> the PC. Instead of using the serial or parallel port, it uses GPIO pi=
ns
>>> on embedded systems. It measures the time between the generation of a=
n
>>> interrupt triggered by a GPIO pin and the reply by either the interru=
pt
>>> service routine, a kernel-space task or a user-space task. As reply,
>>> another GPIO pin will be toggled. The setup consists of two systems, =
the
>>> log host and the test target. The log host triggers the interrupt on =
the
>>> test target and measures the latency. This benchmark is primarily for=

>>> Xenomai/RTDM, but it can also be used for plain Linux or even Linux-r=
t
>>> (with the real-time preemption patch).
>> Nice stuff! Still I have a few conceptual questions: :->
>=20
> I did expect them ;-).
>=20
>> 1. Why do you need a Xenomai measurement host? On first glance, you ar=
e
>>    just spinning on the reply for the RT target. Why not use plain Lin=
ux
>>    for this to increase portability? Most beautiful would be a pure
>>    userspace approach like for irqbench. What prevents this here?
>=20
> Well, I'm not a hardware expert and therefore it was not obvious to me
> how to connect GPIO pins to the standard PC. To avoid electrical
> incompatibilities, I chose my good old TQM855L module as log host.
> I agree, that this solution is rather special and that the one for
> irqbench would be much better. Any ideas how to interface GPIO pins wit=
h
> the PC?

Misunderstanding: I'm not talking about porting the host part to a PC,=20
that is a different thing and surely involves some hardware work (unless =

the PC board already has compatible IO ports). I was talking about=20
running the host part on _plain_ Linux on whatever arch providing the IO =

hardware, and maybe also running it without a kernel helper (by poking=20
directly into to IO - if that is feasible). Latency-wise there is no=20
need for a RTOS on the host side as you run the critical part with IRQs=20
disabled.

>=20
>> 2. Do you see a chance to integrate the target'S GPIO interface into t=
he
>>    exiting irqbench backend? That would make it easy to merge the
>>    Xenomai version into the tree.
>=20
> In the end I preferred to make a separated distribution, as various
> parts are very hardware specific and the driver can also be built as
> normal Linux character device driver.

I don't want to replace your distribution, I want to enhance the Xenomai =

benchmark that comes with the releases. And maybe I also want to trigger =

the development of more standard benchmark tools (compatible kernel/user =

APIs on the targets, reusable host-side tools). :)

Jan


--------------enigD787E08E8311D2420CCED2DC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFHwnd0niDOoMHTA+kRAo1LAJ4n4udjIQmndO6EYCGr9m2IE7xYkACfRnCp
PTvGGhh8LRYlf5ALtVKWEPo=
=fKWW
-----END PGP SIGNATURE-----

--------------enigD787E08E8311D2420CCED2DC--

