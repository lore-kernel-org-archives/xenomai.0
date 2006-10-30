Message-ID: <45461766.4060208@domain.hid>
Date: Mon, 30 Oct 2006 16:16:54 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] xenomai revision 1772 on arm
References: <1162218640.4993.5.camel@domain.hid> <454613C5.2090100@domain.hid>
In-Reply-To: <454613C5.2090100@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
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
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai-help <xenomai@xenomai.org>

Gilles Chanteperdrix wrote:
> Schl=E4gl Manfred jun. wrote:
>=20
>> Hi!
>>
>> Should be a hint, if anyone has similar Problems:
>>
>> Xenomai (rev. 1772) was not running on my platform. (no
>> timer_tick-calls; timer stopped)
>>
>> I had to do following downgrade:
>>
>> Index: include/asm-arm/hal.h
>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> --- include/asm-arm/hal.h       (revision 1772)
>> +++ include/asm-arm/hal.h       (working copy)
>> @@ -103,10 +103,13 @@
>> =20
>>  static inline void rthal_timer_program_shot (unsigned long delay)
>>  {
>> +    if(!delay)
>> +        delay =3D 10;
>> +    __ipipe_mach_set_dec(delay);
>> -    if(!delay)
>> -        rthal_trigger_irq(RTHAL_TIMER_IRQ);
>> -     else
>> -       __ipipe_mach_set_dec(delay);
>>  }
>> =20
>>      /* Private interface -- Internal use only */
>>
>>
>> It's simply a workaround yet. I'll try to find the error in my
>> timer-handling.
>=20
>=20
> You probably have the same problem as PXA, you can not program
> the timer for a too short delay, you should handle this in the
> implementation of __ipipe_mach_set_dec for your platform, not
> in the platform independent code.

Forget about my answer, what you observe is abnormal, rthal_trigger_irq
should work.

--=20
                                                  Gilles Chanteperdrix

