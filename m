Message-ID: <4CB753EC.9010107@domain.hid>
Date: Thu, 14 Oct 2010 21:03:08 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <4CB06CE9.9090204@domain.hid>	
	<1287070938.1628.20.camel@domain.hid>
	<4CB72B5D.1070304@domain.hid>
	<1287073013.1628.25.camel@domain.hid>
	<4CB743FA.20504@domain.hid> <4CB7482C.9060602@domain.hid>
In-Reply-To: <4CB7482C.9060602@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig66926D356FC6821E0AB454E1"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-core] [forge] irqbench removal
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Wolfgang Grandegger <wg@domain.hid>
Cc: Xenomai core <Xenomai-core@domain.hid>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig66926D356FC6821E0AB454E1
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Am 14.10.2010 20:13, Wolfgang Grandegger wrote:
> Hi Jan,
>=20
> On 10/14/2010 07:55 PM, Jan Kiszka wrote:
>> Am 14.10.2010 18:16, Philippe Gerum wrote:
>>> On Thu, 2010-10-14 at 18:10 +0200, Jan Kiszka wrote:
>>>> Am 14.10.2010 17:42, Philippe Gerum wrote:
>>>>> On Sat, 2010-10-09 at 15:23 +0200, Jan Kiszka wrote:
>>>>>> Philippe,
>>>>>>
>>>>>> irqbench does not inherently depend on a third I-pipe domain. It i=
s a
>>>>>> useful testcase, the only in our portfolio that targets a peripher=
al
>>>>>> device use case. In fact, it was only of the first test cases for =
Native
>>>>>> RTDM IIRC.
>>>>>>
>>>>>> Please revert the removal and then cut out only the few parts that=

>>>>>> actually instantiate an additional domain (i.e. mode 3.
>>>>>
>>>>> So, what do we do with this? Any chance we move to arch-neutral cod=
e for
>>>>> this test?
>>>>
>>>> Arch-neutral is impossible due to the inherent hardware dependency. =
But
>>>> I'm waiting on some comments by Wolfgang on their work as that's
>>>> probably the best requirements source for multi-arch support.
>>>
>>> I mean that the bulk of the code could be made arch-neutral, with onl=
y
>>> callouts to solve the arch-dependent/uart issues. Typically, 16550's =
are
>>> not uncommon on powerpc, but we obviously don't program them via
>>> ioports. A second level of indirection could provide the entire chip
>>> handling, to fit other uarts, maybe?
>>
>> If there are suitable UARTs around, refactoring the code accordingly a=
nd
>> maybe adding support for one of them as reference would be a good next=

>> step. But first I would like to understand (or recall - I think Wolfga=
ng
>> once explained it) the motivations for not going this path with the
>> gpiobench test and learn its requirements to avoid doing refactorings
>> twice or more.
>=20
> Well, it's a long time ago that I wrote gpioirqbench, which is derived
> from Jan's irqbench. Obviously, it uses GPIO pins to signal events
> instead of signals from the parallel port or serial line. I never
> supported the serial line for embedded boards.

What was the reason? That it is too often blocked by a terminal?

> You can get the code with:
>=20
>   $ git clone git://git.denx.de/gpioirqbench
>=20
> It uses a simple hw abstruction layer defined in target/gpioirq-hw.h:
>=20
> http://git.denx.de/?p=3Dgpioirqbench.git;a=3Dblob;f=3Dtarget/gpioirq-hw=
=2Eh;h=3D76849da0964c7dbb6831fe02374922dcf89b3bb1;hb=3DHEAD

Is this abstracting the target side, right?

>=20
> Don't know if it's generic enough to support the parallel and serial
> port interface as well. Anyway, with working generic GPIO lib support,
> it's quite simple to support new hardware, e.g. i.MX31 boards.
>=20
> The host side to measure precisely the latency is even more tricky.

Depends. If you can map the GPIO output on something RS232 or parallel
port compatible, you are done. Usually, there is always some x86 box
around with one of those ports, even in 2010. Would it make sense to
specify the electrical interface between host and target accordingly?
That would allow to concentrate on the target, the more interesting part.=


Jan


--------------enig66926D356FC6821E0AB454E1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.15 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org/

iEYEARECAAYFAky3U+8ACgkQitSsb3rl5xQfZgCdH6FiEjarf54WqoylWbHvDWwG
oAkAoNGusELY8Hd7lw0lxVEkazal6JC1
=fZDV
-----END PGP SIGNATURE-----

--------------enig66926D356FC6821E0AB454E1--

