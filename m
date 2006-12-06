Message-ID: <45774C47.9050307@domain.hid>
Date: Thu, 07 Dec 2006 00:03:35 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <457686F3.1080008@domain.hid> <1165405238.7218.102.camel@domain.hid>	
	<4576B1F1.5040604@domain.hid> <1165441950.7218.182.camel@domain.hid>
In-Reply-To: <1165441950.7218.182.camel@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigC9E95E32118F339B577888AC"
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
--------------enigC9E95E32118F339B577888AC
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Philippe Gerum wrote:
> On Wed, 2006-12-06 at 13:05 +0100, Jan Kiszka wrote:
>> Philippe Gerum wrote:
>=20
> [...]
>=20
>>> The other important issue is that patching the call sites does not
>>> preclude from analysing each and every PIC control routine, for ironi=
ng
>>> them. When the number of PICs is small enough, it's clearly safer to
>>> have all changes at one location (i.e. the PIC management file). At
>>> least, you know what has been adapted; but it's (only) a matter of
>>> (maintainer's) taste.
>> Having a look at new/updated PIC code is one (unavoidable) thing,
>> actually having to touch it and keeping the changes in sync even with
>> only minor style changes or the code is another.
>>
>=20
> It's not a problem to fix minor style changes in arch-dep code; but it
> can be very annoying to forget important changes in generic the code. S=
o
> your argument cuts both ways. Really, it's a matter of where one thinks=

> the code is going to change in the most significant way. Regarding x86
> (and I'm not arguing for any other arch, here), I see less changes to
> happen in the PIC-dependent routines, than at their call sites, as more=

> archs are being converted to use the genirq layer. In any case, I don't=

> see this issue as being critical; it would be easy to change the
> implementation overnight without any drawback imposed on client code.

Ok, let's see how other archs work this out and then decide how to
consolidate the solutions. I would just try to find a common way, also
to make understanding the patch mechanisms easier (for future ports).

>=20
> [...]
>=20
>>> --- arch/i386/kernel/ipipe.c~	2006-12-03 18:12:59.000000000 +0100
>>> +++ arch/i386/kernel/ipipe.c	2006-12-06 12:36:21.000000000 +0100
>>> @@ -167,10 +167,12 @@
>>>  static int __ipipe_ack_irq(unsigned irq)
>>>  {
>>>  	irq_desc_t *desc =3D irq_desc + irq;
>>> +
>>> +	desc->chip->ipipe_ack(irq);
>>> +
>> Might be NULL for some chips like fasteoi ones, no?
>>
>=20
> Not for x86, ipipe_ack is always valid, and __ipipe_ack_irq() which
> calls it is arch-dependent, so we are safe. Controlling the irq_chip

lapic_chip?

Moreover, calling [ipipe_]ack is flow type specific. So you would also
have to install a no-op handler for fasteoi chips e.g. Given that
ioapic_chip seems to be used for both edge-triggered and fast irqs, your
previous version looks better.

> descriptor, instead of generalizing the logic from the generic code
> (which could not have told you that), is an advantage here.
>=20
>>>  	if (desc->handle_irq =3D=3D &handle_fasteoi_irq)
>>>  		desc->chip->ipipe_eoi(irq);
>>> -	else
>>> -		desc->chip->ipipe_ack(irq);
>>> +
>>>  	return 1;
>>>  }
>>> =20
>>> This is not relevant to the way we hook genirq though; we need to han=
dle
>>> this in the primary I-pipe handler anyway.
>>>
>>>>  Generally, the question remains for me
>>>> if at least IRQs arriving to a stalled I-pipe domain should always b=
e
>>>> masked on ack and unmask when being replayed.
>>> What particular (problematic) case do you have in mind regarding this=
?
>> Recurring IRQs of the same source to a stalled domain, potentially
>> disturbing a higher prio domain (even if they do not get beyond I-pipe=

>> core stubs). -rt has to deal with the same issue for low-prio threaded=

>> IRQs, and I don't see a reason yet why we should differ when they keep=

>> the line masked after the first or the second event.
>>
>=20
> This problem should be addressed at a higher level: how do we prevent
> low-priority IRQs from ever happening when a high priority domain is
> running, so that such IRQs could not even hit the primary Adeos handler=
=2E
> Currently, the pipeline head optimization avoids such perturbation when=

> the high priority domain is stalled by masking the interrupts at CPU
> level; what we need is to extend this to the unstalled state.

Yep.

>=20
> This issue goes beyond the quick hack of masking recurring IRQs, and
> IIRC, we discussed it briefly on this list some months ago. This is wha=
t
> would bring a significant improvement wrt determinism.

As long as we do not fall back behind previous characteristics of
I-pipe, I see no problem with addressing this in an even smarter way
later. Is this patch equivalent, e.g. to 1.5's behaviour?

Jan


--------------enigC9E95E32118F339B577888AC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFFd0xHniDOoMHTA+kRAkWeAJ4uvfZEOt/fdZvNKk8Oojp8FHKXKACffJjU
Tg3N8AJPDlh5ki9VWBSBIaE=
=fDnD
-----END PGP SIGNATURE-----

--------------enigC9E95E32118F339B577888AC--

