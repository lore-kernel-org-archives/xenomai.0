Message-ID: <47051CF3.70202@domain.hid>
Date: Thu, 04 Oct 2007 19:03:47 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <4704AEF3.4030105@domain.hid>	
	<1191490451.20623.54.camel@domain.hid>	<1191500570.20623.63.camel@domain.hid>
	<47050C2B.4020208@domain.hid>
In-Reply-To: <47050C2B.4020208@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig3E9B4357C4EB562BB8784B52"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-core] [BUG] IO-APIC stall due to broken fasteoi
	handling
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
Cc: adeos-main@gna.org, Xenomai-core@domain.hid

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig3E9B4357C4EB562BB8784B52
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Jan Kiszka wrote:
> Philippe Gerum wrote:
>> On Thu, 2007-10-04 at 11:34 +0200, Philippe Gerum wrote:=20
>>>> Well, this trace also reveals a second bug that can cause nasty prio=
rity
>>>> inversion: a high-prio domains executes when a fasteoi-IRQ arrives f=
or a
>>>> low-prio domain. This will now block all IRQs until the low-prio dom=
ain
>>>> was able to run its IRQ handler completely. Thus we must _mask_ fast=
eoi
>>>> IRQs for low-prio domains while high-prio ones are running!
>>>>
>>> This code was actually there up to 2.6.17-1.5-02, and was removed at
>>> some point in the 2.6.19 series, due to some severe conflicts with th=
e
>>> vanilla IO-APIC support which used to be a hell of a moving target at=

>>> that time. I guess it's time to bring this code back.
>>>
>> Does the following work for you?
>>
>> diff --git a/arch/i386/kernel/io_apic.c b/arch/i386/kernel/io_apic.c
>> index 2ae79e9..517937b 100644
>> --- a/arch/i386/kernel/io_apic.c
>> +++ b/arch/i386/kernel/io_apic.c
>> @@ -2022,6 +2022,8 @@ static void ack_ioapic_quirk_irq(unsigned int ir=
q)
>>  		__unmask_and_level_IO_APIC_irq(irq);
>>  		spin_unlock(&ioapic_lock);
>>  	}
>> +
>> +	__mask_IO_APIC_irq(irq);
>>  }
>> =20
>>  static int ioapic_retrigger_irq(unsigned int irq)
>> diff --git a/kernel/irq/chip.c b/kernel/irq/chip.c
>> index ba497a7..1560b4a 100644
>> --- a/kernel/irq/chip.c
>> +++ b/kernel/irq/chip.c
>> @@ -422,8 +422,13 @@ handle_fasteoi_irq(unsigned int irq, struct irq_d=
esc *desc)
>> =20
>>  	spin_lock(&desc->lock);
>>  	desc->status &=3D ~IRQ_INPROGRESS;
>> +#ifdef CONFIG_IPIPE
>> +	desc->chip->unmask(irq);
>> +out:
>> +#else
>>  out:
>>  	desc->chip->eoi(irq);
>> +#endif
>> =20
>>  	spin_unlock(&desc->lock);
>>  }
>> @@ -533,11 +538,12 @@ void fastcall __ipipe_end_level_irq(unsigned irq=
, struct irq_desc *desc)
>> =20
>>  void fastcall __ipipe_ack_fasteoi_irq(unsigned irq, struct irq_desc *=
desc)
>>  {
>> +	desc->chip->eoi(irq);
>>  }
>> =20
>>  void fastcall __ipipe_end_fasteoi_irq(unsigned irq, struct irq_desc *=
desc)
>>  {
>> -	desc->chip->eoi(irq);
>> +	desc->chip->unmask(irq);
>>  }
>> =20
>>  void fastcall __ipipe_ack_edge_irq(unsigned irq, struct irq_desc *des=
c)
>>
>=20
> Good news: The patches seems to stabilise the Xenomai-free use of
> I-pipe. I'm writing this mail while compiling a kernel on an
> i-pipe-enabled 2.6.22-box.
>=20
> Bad news: Loading Xenomai still causes a hard reboot after while. Maybe=

> I was too quick with re-importing the no-COW bits. Now trying to revert=

> them again to check if they are still involved in nasty page faults...

No-COW: not guilty.

The system still reboots or locks up when I modprobe e.g. xeno_rtdm
before logging into X. I threw my laptop in some corner (other work is
calling), but I will try to look into this over the weekend or so. I'm
hoping we still get oopses/backtraces/whatever.

Jan


--------------enig3E9B4357C4EB562BB8784B52
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iD8DBQFHBRz3niDOoMHTA+kRAjqfAJ9gWkp2HD75N+Y9AWG2pV6RPFtqUQCePEbQ
guggPaHlSR/I3UDzTacvxUU=
=PQZk
-----END PGP SIGNATURE-----

--------------enig3E9B4357C4EB562BB8784B52--

