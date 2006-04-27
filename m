Message-ID: <4450EF53.1050808@domain.hid>
Date: Thu, 27 Apr 2006 18:20:35 +0200
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] IRQ1 forwarded to Linux?
References: <1146143577.3671.3.camel@domain.hid>	
	<1146149090.2938.33.camel@domain.hid>	
	<4450DB97.9010708@domain.hid>
	<1146152162.2938.42.camel@domain.hid>
In-Reply-To: <1146152162.2938.42.camel@domain.hid>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Guillaume Boutillier <guillaume.boutillier@domain.hid>
Cc: xenomai@xenomai.org

Guillaume Boutillier wrote:
>>Guillaume Boutillier wrote:
>>
>>>Hello,
>>>
>>>
>>>
>>>>>ROSSIER Daniel wrote:
>>>>>
>>>>>
>>>>>>Hello,
>>>>>>
>>>>>>
>>>>>>
>>>>>>We have a small Xeno application which implements an interrupt serv=
ice=20
>>>>>>(ISR) on IRQ 1 (keyboard) =E2=80=93 quite stupid, but
>>>>>>
>>>>>
>>>>>Sorry,
>>>>>
>>>>>- $ cat /proc/ipipe/Linux
>>>>>+ $ cat /proc/ipipe/Xenomai
>>>
>>>
>>>I checked when I run my application...=20
>>>But I couldn't understand the meaning of the different flags : accepte=
d,
>>>passed and grabbed?!=20
>>>
>>
>>What about posting the output to this list? Maybe someone could help.
>>
>=20
>=20
> Sorry I forgot the results...
>=20
> when I run the application with RT_INTR_PROPAGATE :
>=20
> $ cat /proc/ipipe/Xenomai
> Priority=3D200, Id=3D0x58454e4f
> irq0-1: grabbed
> irq2-31: passed
> irq32-33: passed, virtual
> irq34: grabbed, virtual
>=20
> $ cat /proc/ipipe/Linux
> Priority=3D100, Id=3D0x00000000
> irq0-15: accepted
> irq32-33: grabbed, virtual
> irq34: passed, virtual
>=20
>=20
> when I run the application with RT_INTR_HANDLED
>=20
> $ cat /proc/ipipe/Xenomai
> Priority=3D200, Id=3D0x58454e4f
> irq0-1: grabbed
> irq2-31: passed
> irq32-33: passed, virtual
> irq34: grabbed, virtual
>=20
> $ cat /proc/ipipe/Linux
> Priority=3D100, Id=3D0x00000000
> irq0-15: accepted
> irq32-33: grabbed, virtual
> irq34: passed, virtual
>=20

"grabbed" means that the domain intercepts the IRQ, and will let its own=20
handler decide whether the interrupt needs to be propagated down the=20
pipeline or not (a manual call to ipipe_propagate_irq will be needed if=20
so). IOW, Adeos stops scanning the pipeline chain upon IRQ receipt after=20
this domain's stage; it would do that otherwise to discover new=20
(lower-priority) domains wanting to handle this IRQ too.

"accepted" means that Adeos will let the domain process the IRQ, and=20
keep on searching for (lower-priority) domains wanting to handle it too.

"passed" means that Adeos will not ask the domain to handle the IRQ, but=20
will try to pass it to the next domain down the pipeline.

"discarded" means to make as if the IRQ never happened starting from the=20
current one, i.e. neither the current nor the lower-priority domain will=20
ever know about it.

Regarding the specific case of the keyboard input still working despite=20
the kbd interrupts can't flow, it's likely due to the fact that the=20
input sub-system (i8042 serio driver) also polls the attached devices=20
according to a HZ/20 period, in addition to handling the interrupts.

--=20

Philippe.

