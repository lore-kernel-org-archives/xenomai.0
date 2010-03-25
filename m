Message-ID: <4BAB69F9.7070105@domain.hid>
Date: Thu, 25 Mar 2010 14:49:45 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <4BAB1709.9000601@domain.hid> <4BA9E7E0.6040206@domain.hid>
	<4BA8F900.5000602@domain.hid> <4BA39C3D.1040802@domain.hid>
	<4BA4EF75.7010202@domain.hid> <4BA74820.2090401@domain.hid>
	<4BA8752E.8090407@domain.hid> <4BA8C15E.5050707@domain.hid>
	<4BA8F517.3060705@domain.hid> <4BA8F732.10206@domain.hid>
	<2d0b8e.10245.1278e1771a8.Coremail.robert165@domain.hid>
	<63e73d99.3c71.127933ea91c.Coremail.robert165@domain.hid>
	<1a51bc0.b6de.127955f4dc7.Coremail.robert165@domain.hid>
In-Reply-To: <1a51bc0.b6de.127955f4dc7.Coremail.robert165@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai-help] Problem in irq_handle
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: robert165 <robert165@domain.hid>
Cc: xenomai-help <xenomai@xenomai.org>

robert165 wrote:
>=20
>=20
>=20
> =E5=9C=A82010-03-25 15:55:53=EF=BC=8C"Gilles Chanteperdrix"
> <gilles.chanteperdrix@xenomai.org> =E5=86=99=E9=81=93=EF=BC=9A
>> robert165 wrote:
>>>=20
>>> =E5=9C=A82010-03-24 18:22:24=EF=BC=8C"Gilles Chanteperdrix"
>>> <gilles.chanteperdrix@xenomai.org> =E5=86=99=E9=81=93=EF=BC=9A
>>>> robert165 wrote:
>>>>> Hi Jan, I am new to xenomai, I am writing a gpio driver based
>>>>> on your "RTDM skeleton v1.1". There is a problem that when I
>>>>> complied and run your skeleton in a at91rm9200 broad with
>>>>> TIMERINT, the output is not show one line one second but very
>>>>> fast. The problem is still whenever I changed the following
>>>>> codes in demo_interrupt()
>>>>>=20
>>>>> #ifdef TIMERINT if (events > XXX){=20
>>>>> rtdm_event_signal(&ctx->irq_event); event=3D0; } ... events++;
>>>>>=20
>>>>> And, it seems likely in my own irq_handle of a gpio irq. When
>>>>> the irq arrive, the irq_handle repeats many times. Should I
>>>>> mask the same irq in irq_handle? I did it by write the PIO
>>>>> interrupt mask register, but no effect.
>>>> Which interrupt is TIMERINT?
>>> TIMERINT is timer interrupt.
>>>=20
>>> It is in the demo of rtdm driver, the sourse is:
>>>=20
>>> http://www.captain.at/xenomai-real-time-driver-example.php
>>>=20
>>> Best wishes,
>> Yes, but I was wondering which timer interrupt: - if you are
>> talking about the AT91 "system interrupt", it is shared between
>> several peripherals, including the DBGU serial port, and can not be
>> used in a real-time driver for this reason; - if you are talking
>> about the TC interrupt, it is handled by the I-pipe, and you can
>> not register a handler for your own driver either.
>>=20
>> IOW, what value of TIMERINT do you use?
> What I said is  the the original codes of Jan, I just compiled and
> run it without any modification. The value of TIMERINT is 0.

Ok. In fact, I am afraid Jan's code is for x86, not AT91. Since that
driver was written, RTDM gained support for timers, so, hooking into the
timer interrupt is no longer needed if you want a handler to be
triggered periodically.

>=20
>> And I do not really understand why you use the timer interrupt. If
>> you are interested in interrupts coming from a GPIO, why not
>> register a handler for the GPIO interrupt?
> I did not use the  timer interrupt in my own GPIO driver, that is a
> real GPIO interrupt. I put a printk() in irq_handle , when the int
> arrived, the irq_handle repeat many times. I used RTDM_IRQTYPE_EDGE,
> masked the irq in irq_handle by write irq_mask_register. Results are
> the same. Regards, Luo

If you want to mask an irq, you should not write directly to registers,
you should use the linux kernel APIs. Anyway, I think that is not your
problem, your problem is a known one with edge and level interrupts.
Could you try setting up the irq as level instead of edge?

If it does not work, try and also call:
set_irq_handler(<irq number>, handle_level_irq)

--=20
					    Gilles.


