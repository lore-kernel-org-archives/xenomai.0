Message-ID: <4BAB1709.9000601@domain.hid>
Date: Thu, 25 Mar 2010 08:55:53 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <4BA9E7E0.6040206@domain.hid> <4BA8F900.5000602@domain.hid>
	<4BA39C3D.1040802@domain.hid> <4BA4EF75.7010202@domain.hid>
	<4BA74820.2090401@domain.hid> <4BA8752E.8090407@domain.hid>
	<4BA8C15E.5050707@domain.hid> <4BA8F517.3060705@domain.hid>
	<4BA8F732.10206@domain.hid>
	<2d0b8e.10245.1278e1771a8.Coremail.robert165@domain.hid>
	<63e73d99.3c71.127933ea91c.Coremail.robert165@domain.hid>
In-Reply-To: <63e73d99.3c71.127933ea91c.Coremail.robert165@domain.hid>
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
> =E5=9C=A82010-03-24 18:22:24=EF=BC=8C"Gilles Chanteperdrix" <gilles.cha=
nteperdrix@domain.hid> =E5=86=99=E9=81=93=EF=BC=9A
>>robert165 wrote:
>>> Hi Jan, I am new to xenomai, I am writing a gpio driver based on
>>> your "RTDM skeleton v1.1". There is a problem that when I complied
>>> and run your skeleton in a at91rm9200 broad with TIMERINT, the output=

>>> is not show one line one second but very fast. The problem is still
>>> whenever I changed the following codes in demo_interrupt()
>>>=20
>>> #ifdef TIMERINT if (events > XXX){=20
>>> rtdm_event_signal(&ctx->irq_event); event=3D0; } ... events++;
>>>=20
>>> And, it seems likely in my own irq_handle of a gpio irq. When the irq=

>>> arrive, the irq_handle repeats many times. Should I mask the same irq=

>>> in irq_handle? I did it by write the PIO interrupt mask register, but=

>>> no effect.
>>
>>Which interrupt is TIMERINT?
>=20
> TIMERINT is timer interrupt.
>=20
> It is in the demo of rtdm driver, the sourse is:
>=20
> http://www.captain.at/xenomai-real-time-driver-example.php
>=20
> Best wishes,=20

Yes, but I was wondering which timer interrupt:
- if you are talking about the AT91 "system interrupt", it is shared
between several peripherals, including the DBGU serial port, and can not
be used in a real-time driver for this reason;
- if you are talking about the TC interrupt, it is handled by the
I-pipe, and you can not register a handler for your own driver either.

IOW, what value of TIMERINT do you use?

And I do not really understand why you use the timer interrupt. If you
are interested in interrupts coming from a GPIO, why not register a
handler for the GPIO interrupt?

Regards.

--=20
					    Gilles.


