Message-ID: <497AE64B.2000304@domain.hid>
Date: Sat, 24 Jan 2009 10:58:35 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <4979727E.6060304@domain.hid> <49799B02.1010202@domain.hid>
	<4979F92A.70702@domain.hid> <497A074A.1050104@domain.hid>
	<497A09E5.5080906@domain.hid>
In-Reply-To: <497A09E5.5080906@domain.hid>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai-help] PowerPC irq unmask
Reply-To: rpm@xenomai.org
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: federico.ridolfo@domain.hid
Cc: xenomai@xenomai.org

Federico Ridolfo wrote:

Ok, things look clearer now. As an introductory remark, the actual OF data =
does
not match the comments found in your dts file, which does not help at all (=
e.g.
PSC0 is tagged as PSC1 etc). The device description blob seems to match
otherwise, at least for the PSCs.

> irq: irq_create_mapping(0xc041d2a0, 0x81)
> irq: -> using host @c041d2a0
> irq: -> existing mapping on virq 129
> f0002000.serial: ttyPSC0 at MMIO 0xf0002000 (irq =3D 129) is a MPC52xx PSC
> irq: irq_create_mapping(0xc041d2a0, 0x82)
> irq: -> using host @c041d2a0
> irq: -> obtained virq 130
> f0002200.serial: ttyPSC1 at MMIO 0xf0002200 (irq =3D 130) is a MPC52xx PSC
> irq: irq_create_mapping(0xc041d2a0, 0x8b)
> irq: -> using host @c041d2a0
> irq: -> obtained virq 139
> f0002600.serial: ttyPSC3 at MMIO 0xf0002600 (irq =3D 139) is a MPC52xx PSC
> irq: irq_create_mapping(0xc041d2a0, 0x8c)
> irq: -> using host @c041d2a0
> irq: -> obtained virq 140
> f0002800.serial: ttyPSC4 at MMIO 0xf0002800 (irq =3D 140) is a MPC52xx PSC

<snip>

This is where you loaded the psc_psi module, which in turn caused two more =
IRQs
to be mapped and claimed by the driver. This explains part of the behavior =
you
observed: at init time, all IRQ descriptors point at a dummy interrupt chip
controller, which has no unmask handler (i.e. NULL); and the kernel provide=
s no
default unmask handler whatsoever.

Therefore, until the psc_spi module is loaded, there is no unmask handler f=
or
PSC3 and PSC6 IRQs, since those have not been mapped and claimed by the dri=
ver
yet. Hence, -ENODEV is received when rtdm_irq_request() attempts to enable =
the line.

Second issue: once the driver is loaded, and you attempt to load your RTDM
driver, the board locks up badly. At that point, you don't receive -ENODEV
anymore since PSC3 and PSC6 IRQs have been mapped, so they do have a valid
unmask handler (unloading your driver won't dispose of the mapping).
This means that your RTDM driver is missing a call to e.g.
irq_of_parse_and_map(), in order to map the PSC3 and PSC6 IRQs you want to =
use,
and get back their actual virtual numbers to pass to rtdm_irq_request(); as
Wolfgang pointed out, you should go through the OF parsing to get those val=
ues,
and never use pre-defined constants now that you depend on a device tree. Y=
ou
may want to have a look at the CAN drivers in the Xenomai drivers/ area to =
find
out how to retrieve the OF node that corresponds to some device by name (i.=
e.
of_find_compatible_node()).

Regarding the lockup, I suspect this has something to do with your RTDM
interrupt handler; the PSC3/PSC6 IRQs are level ones, so your board likely =
locks
up out of an interrupt storm, due to a bad device acknowledge or something
alike. In any case, you want to fix the IRQ mapping issue first, so that you
don't need to fiddle with the standard psc_spi driver to get those mapped. =
This
should reduce the number of opportunities for breakage when looking at the
second issue.

> irq: irq_create_mapping(0xc041d2a0, 0x83)
> irq: -> using host @c041d2a0
> irq: -> obtained virq 131
> mpc52xx-psc-spi f0002400.spi: probe called without platform data, no
> (de)activate_cs function will be called
> irq: irq_create_mapping(0xc041d2a0, 0x84)
> irq: -> using host @c041d2a0
> irq: -> obtained virq 132
> mpc52xx-psc-spi f0002c00.spi: probe called without platform data, no
> (de)activate_cs function will be called
>=20
> Philippe Gerum wrote:
>> Federico Ridolfo wrote:
>>  =20
>>> Ok, i'm debugging the problem, but i have not a solution.
>>> I compiled the kernel with the debug switch for irq.c.
>>> In addition i added the mpc52xx_psc_spi module in my
>>> .config.
>>> So, now i'm sure that the irq used in mpc52xx_psc_spi
>>> for the PSC3 is 131 and for PSC6 is 132:
>>>
>>> # dmesg
>>> mpc52xx-psc-spi f0002400.spi: probe called without platform data, no
>>> (de)activate_cs function will be called
>>> irq: irq_create_mapping(0xc041d2a0, 0x84)
>>> irq: -> using host @c041d2a0
>>> irq: -> obtained virq 132
>>>
>>>    =20
>> Please send all the IRQ related information, you get in the boot log, be=
cause
>> the few lines above do not match what your dts file below says.
>>
>> As far as I understand those lines, the generic IRQ code is asked to cre=
ate a
>> virtual mapping for hwirq 132 out of the OF specs, and this hint is kept=
 so that
>> you actually get virq 132. So far so good.
>>
>> However, to get asked for 132, your dts file should have specified an in=
tspec
>> which rather looks like { 2 4 <sense-type> } and not { 2 3 <sense-type> =
} as
>> mentioned in the spi@domain.hid block. { 2 3 <sense-type> } for PSC3 in =
SPI mode would
>> rather give us hwirq 131 (the hairy computation determining the hwirq nu=
mber
>> from the inspec is available from mpc52xx_irqhost_xlate()).
>>
>> So either you are not booting with the blob that matches the dts file be=
low, or
>> the console output above is misleading. In short, I'm lost.
>>
>>  =20
>>> I'm using the same irqs for my rtdm spi driver, but it doesn=ECt work.
>>> If i reboot the board and try my rtdm driver, the result is -ENODEV
>>>
>>> If i "modprobe  mpc52xx_psc_spi"  and retry my rtdm driver -> the board
>>> hangs for ever.
>>> I have the same result  also if i "rrmod mpc52xx_psc_spi" before.
>>> My dts is:
>>> /dts-v1/;
>>>

--=20
Philippe.

