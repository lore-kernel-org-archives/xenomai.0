Message-ID: <48D6241A.4090109@domain.hid>
Date: Sun, 21 Sep 2008 12:38:18 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <48CE8CE7.6030209@domain.hid> <48D177B1.7000009@domain.hid>
	<48D2184F.3000009@domain.hid> <48D34C63.90304@domain.hid>
	<48D3B1F3.1020408@domain.hid>
In-Reply-To: <48D3B1F3.1020408@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig0B2E98881AC564D5BFA6D070"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-help] keyboard interrupt
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Harco Kuppens <h.kuppens@domain.hid>
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig0B2E98881AC564D5BFA6D070
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Harco Kuppens wrote:
>=20
> everything is getting clearer know thanks :)
> but still a got some things not really clear to may,
> hope you still have time to answer them.
>=20
>=20
> Jan Kiszka wrote:
>> Yes. For correct handling of shared IRQs, _all_ associate IRQ handlers=

>> must have been executed before the EOI can be sent. The reason is this=
:
>>
>> For level-triggered IRQs, all hardware devices that may have raised th=
e
>> IRQ line must be checked and told to lower it again before sending EOI=
=2E
>> Otherwise the IRQ will immediately be triggered again and you end up i=
n
>> an endless loop, bricking your box.
>>  =20
> ok, a raised line does not the information how many devices could have
> raised them, so you have to handle them all to prevent missing one.
> only after handling them all (they all are lowered) you can send=20
> 'end-of-IRQ' signal
>=20
> thus when after handling one device all other devices have to be
> rechecked because  in the meantime they could have raised the line
>> For edge-triggered IRQs, there problem is different. Here the shared I=
RQ
>> handling algorithm is to consult all handler in a loop until they all
>> reported "not for me" in a row. If you fail to do this, you risk loosi=
ng
>> IRQs. Consider IRQ source A and B. Now an IRQ is raised by B. First, t=
he
>> handler for A will be called. It return "not for me". Now it happens
>> that A also raised the IRQ right at this time. If you now simply log t=
he
>> IRQ for later handling by B and send the EOI, you take away the chance=

>> for handle A to react on the IRQ. At best you create latency, at worst=
 A
>> will never send an IRQ again...
>>  =20
> so you should after handling B again have to call all handlers to see i=
f
> they report all "not for me" ?
> so you would call handler A twice, right?
>=20
>=20
> Thus when finally when handled all device you send the 'end-of-IRQ' sig=
nal.
>=20
> After reading the explanation above I suppose that when handling an IRQ=

> X, there are no new entries for that IRQ X stored in  the PIC controlle=
r.
> So the next interrupt after the 'end-of-IRQ' signal will be another
> interrupt than the one we just dealed.
>=20
> at section  8.8.4 off the Intel APIC documentation  /IA-32 Intel
> Architecture Software Developer's Manual, Volume 3A: System Programming=

> Guide, Part 1
> <http://developer.intel.com/design/processor/manuals/253668.pdf>/ I rea=
d
> a very clear piece of explaining text :
>=20
>    The local APIC queues the fixed interrupts that it accepts in one of=

>    two interrupt pending registers: the interrupt request register
>    (IRR) or in-service register (ISR). These two 256-bit read-only
>    registers are shown in Figure 8-20. The 256 bits in these registers
>    represent the 256 possible vectors; vectors 0 through 15 are
>    reserved by the APIC (see also: Section 8.5.2, "Valid Interrupt
>    Vectors").
>=20
>    The IRR contains the active interrupt requests that have been
>    accepted, but not yet dispatched to the processor for servicing.
>    When the local APIC accepts an interrupt, it sets the bit in the IRR=

>    that corresponds the vector of the accepted interrupt. When the
>    processor core is ready to handle the next interrupt, the local APIC=

>    clears the highest priority IRR bit that is set and sets the
>    corresponding ISR bit. The vector for the highest priority bit set
>    in the ISR is then dispatched to the processor core for servicing.
>=20
>    While the processor is servicing the highest priority interrupt, the=

>    local APIC can send additional fixed interrupts by setting bits in
>    the IRR. When the interrupt service routine issues a write to the
>    EOI register (see Section 8.8.5, "Signaling Interrupt Servicing
>    Completion"), the local APIC responds by clearing the highest
>    priority ISR bit that is set. It then repeats the process of
>    clearing the highest priority bit in the IRR and setting the
>    corresponding bit in the ISR. The processor core then begins
>    executing the service routing for the highest priority bit set in
>    the ISR.
>=20
>    If more than one interrupt is generated with the same vector number,=

>    the local APIC can set the bit for the vector both in the IRR and
>    the ISR. This means that for the Pentium 4 and Intel Xeon
>    processors, the IRR and ISR can queue two interrupts for each
>    interrupt vector: one in the IRR and one in the ISR. Any additional
>    interrupts issued for the same interrupt vector are collapsed into
>    the single bit in the IRR.
>=20
>    For the P6 family and Pentium processors, the IRR and ISR registers
>    can queue no more than two interrupts per priority level, and will
>    reject other interrupts that are received within the same priority
>    level.
>=20
>    If the local APIC receives an interrupt with a priority higher than
>    that of the interrupt currently in serviced, and interrupts are
>    enabled in the processor core, the local APIC dispatches the higher
>    priority interrupt to the processor immediately (without waiting for=

>    a write to the EOI register). The currently executing interrupt
>    handler is then interrupted so the higher-priority interrupt can be
>    handled. When the handling of the higher-priority interrupt has been=

>    completed, the servicing of the interrupted interrupt is resumed.
>=20
>=20
>=20
> So another interrupt can be queued in the APIC  in the IRR register tho=
ugh.
> But we just handled all devices for that IRQ, so I would say it could b=
e
> skipped. Or not?
>=20
>=20
> I'm also I little bit confused about the term "acknowledge", I couldn't=

> find that word in the intel documentation.
> In your previous mail you said that linux did the "acking".
> In a book I found it means unblocking the PIC, but I would suppose not
> for the IRQ handled, but for all other IRQ's.
> Because I understand now that no other IRQs of the same type cann't be
> handled until the 'end-of-IRQ' signal.
>=20
> Thus what does 'acknowledege' exactly mean?

That the CPU confirms the interrupt controller that it picked up a
specific IRQ event. Depending on the IRQ type, this triggers various
activities in the interrupt controller. For some IRQ types, this can
also be a nop.

Note that the APIC is only one of the countless interrupt controllers in
this universe, implementing only a few of the possible IRQ types. The
universe is large, so a lot of very strange interrupt controllers
exist... ;)
(You may want to study vanilla Linux genirq code, how it handles all the
IRQ types - ipipe is a special case, not immediately revealing the hw
requirements behind it.)

Jan


--------------enig0B2E98881AC564D5BFA6D070
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iEYEARECAAYFAkjWJB0ACgkQniDOoMHTA+kRbgCeI2+NaFvFcyjrWs5SKLzRPLic
ErsAniy1EEUfyqdJLKBCwNjyyoQh64m7
=Wa6m
-----END PGP SIGNATURE-----

--------------enig0B2E98881AC564D5BFA6D070--

