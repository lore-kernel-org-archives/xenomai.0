Message-ID: <4576B1F1.5040604@domain.hid>
Date: Wed, 06 Dec 2006 13:05:05 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <457686F3.1080008@domain.hid> <1165405238.7218.102.camel@domain.hid>
In-Reply-To: <1165405238.7218.102.camel@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig2F8C85E0AF8D40B55B4CFCD2"
Sender: jan.kiszka@domain.hid
Subject: [Xenomai-core] Re: How to hook genirq best
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: rpm@xenomai.org
Cc: adeos-main <adeos-main@gna.org>, xenomai-core <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig2F8C85E0AF8D40B55B4CFCD2
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Philippe Gerum wrote:
> On Wed, 2006-12-06 at 10:01 +0100, Jan Kiszka wrote:
>> Hi all,
>=20
>> I had a look at the related part in 2.6.19-i386-1.6-01 meanwhile, and
>> there seems to be a concise pattern for the irq_chip changes:
>>
>> .ipipe_ack =3D (.mask_ack) ? .mask_ack : .ack;
>> .ipipe_eoi =3D .eoi;
>>
>=20
> The complete pattern is:
>=20
> .ipipe_ack =3D .mask_ack | .ack
> .ipipe_eoi =3D .eoi
> .mask_ack | .ack =3D nop

Yep, forgot to mention the nop-setting.

>=20
> Then, target routines from the addressed IRQ chip controllers have to b=
e
> ironed with hw interrupt masking for spinlock control.
>=20
>> I agree with Wolfgang, these changes indeed require a lot of patching
>> already on x86 because often two versions of the irq_chip definition
>> have to be provided (and there is the risk to miss one as it currently=

>> seems to be the case in visws_apic.c).
>=20
> The Colbalt PIIx4 has not been patched on purpose: it deals with a
> master multiplexed interrupt which feeds a number of virtual IRQs
> downward. Problem is that this scheme requires a specific I-pipe
> handling (like we added for ARM) to act as the demux, and which is not
> available yet for x86. So better not patch than patching erroneously or=

> incompletely; it's the principle of least surprise: Cobalt+PIIx4 is not=

> usable yet with the I-pipe, and one would know it immediately.

I see.

>=20
> Finding the appropriate spots for patching the descriptors is basically=

> a matter of grepping 'struct irq_chip' in the arch-dep section. It's
> manageable.
>=20
>> I must confess that I do not see the advantage of the approach to patc=
h
>> the irq_chip definitions directly. Rather, one of the following ways
>> should scale better over a large number of irq_chips:
>>
>> A) Perform patching during runtime when I-pipe is taking over the IRQs=
=2E
>> Should be a trivial loop over all IRQ descriptors. Either overwrite th=
e
>> existing irq_chips (i.e. like sketched above) or provide new pseudo
>> irq_chip structures to Linux.
>=20
> This approach - which used to be the one followed with legacy Adeos
> patches - was the source of major dysfunctioning at boot time on x86,
> particularly with PCI irq routing on APIC-enabled systems. Same with MS=
I
> stuff. It still works fine on ppc (and likely ARM) though. This said, a=
t
> that time, we used to shuffle the IDT contents too, so maybe it's time
> to have a second look.

Yes, because the irq_chip is not the IDT. We would patch static function
pointers a few levels up now.

>=20
>> B) Patch the users of chip->ack/eoi/mask_ack or whatever. Given that
>> this should basically be confined to kernel/irq/chip.c,
>=20
> This was the implementation of the draft patch I sent. It's ok, as soon=

> as you can rely on the above assumption. That's the whole point.
>=20
>>  it looks
>> manageable too and would also avoid any useless runtime checks for NUL=
L
>> handlers
>>  or even calling void functions.
>>
>=20
> AFAIC, this is something which is perfectly acceptable for platforms
> that require/need it. This is the purpose of decoupling Adeos ports:
> allow each arch to implement the best approach. Blackfin, x86, ia64 hav=
e
> few PICs, so patching the irq_chip descriptor is more elegant than
> fiddling with the generic IRQ flow control (/me think), basically
> because this is a per-arch, per-PIC logic. ARM, and ppc's would likely
> prefer the other approach due to the huge number of PIC variants.
>=20
> The other important issue is that patching the call sites does not
> preclude from analysing each and every PIC control routine, for ironing=

> them. When the number of PICs is small enough, it's clearly safer to
> have all changes at one location (i.e. the PIC management file). At
> least, you know what has been adapted; but it's (only) a matter of
> (maintainer's) taste.

Having a look at new/updated PIC code is one (unavoidable) thing,
actually having to touch it and keeping the changes in sync even with
only minor style changes or the code is another.

>=20
>> Another topic is how to deal with pending IRQs. I haven't looked throu=
gh
>> all cases yet, but already the fasteoi one seems to differ in I-pipe
>> when comparing to a similar situation in -rt: threaded IRQs. -rt ends
>> (eoi) and masks such IRQs that are about to be deferred to thread
>> context, I-pipe only ends them.
>=20
> --- arch/i386/kernel/ipipe.c~	2006-12-03 18:12:59.000000000 +0100
> +++ arch/i386/kernel/ipipe.c	2006-12-06 12:36:21.000000000 +0100
> @@ -167,10 +167,12 @@
>  static int __ipipe_ack_irq(unsigned irq)
>  {
>  	irq_desc_t *desc =3D irq_desc + irq;
> +
> +	desc->chip->ipipe_ack(irq);
> +

Might be NULL for some chips like fasteoi ones, no?

>  	if (desc->handle_irq =3D=3D &handle_fasteoi_irq)
>  		desc->chip->ipipe_eoi(irq);
> -	else
> -		desc->chip->ipipe_ack(irq);
> +
>  	return 1;
>  }
> =20
> This is not relevant to the way we hook genirq though; we need to handl=
e
> this in the primary I-pipe handler anyway.
>=20
>>  Generally, the question remains for me
>> if at least IRQs arriving to a stalled I-pipe domain should always be
>> masked on ack and unmask when being replayed.
>=20
> What particular (problematic) case do you have in mind regarding this?

Recurring IRQs of the same source to a stalled domain, potentially
disturbing a higher prio domain (even if they do not get beyond I-pipe
core stubs). -rt has to deal with the same issue for low-prio threaded
IRQs, and I don't see a reason yet why we should differ when they keep
the line masked after the first or the second event.

Jan


--------------enig2F8C85E0AF8D40B55B4CFCD2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFFdrHyniDOoMHTA+kRAuF2AJ44mpKLOlteFxJj5SB9Z9Io15GgUACdFjwQ
9f1R06Fgn+1o8YILXa1Qaww=
=gaCE
-----END PGP SIGNATURE-----

--------------enig2F8C85E0AF8D40B55B4CFCD2--

