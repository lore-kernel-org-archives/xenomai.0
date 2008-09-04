Date: Thu, 04 Sep 2008 16:47:05 +0200
From: "stephane ancelot" <sancelot@domain.hid>
Content-Type: text/plain; format=flowed; delsp=yes; charset=utf-8
MIME-Version: 1.0
References: <op.uguvqlusnuwxn3@domain.hid> <op.ugx5nqgunuwxn3@domain.hid>
	<48BFA4C1.1040800@domain.hid>
Message-ID: <op.ugyoorx2nuwxn3@domain.hid>
In-Reply-To: <48BFA4C1.1040800@domain.hid>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai-help] spurious interrupt with latest release
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
Cc: xenomai@xenomai.org

Le Thu, 04 Sep 2008 11:05:05 +0200, Gilles Chanteperdrix =20
<gilles.chanteperdrix@xenomai.org> a =C3=A9crit:

> stephane ancelot wrote:
>> Hi,
>> Finally since I did not understand why this happened and to inhibit an=
y
>> driver writing related problems,I made the following architecture :
>>
>> a single 5ms task triggs a PLX 9050 INTCSR software register to activa=
te
>> INTA  (level irq)
>>
>> the rtdm interupt handler checks if IT comes from the PLX, disable PLX=
 =20
>> IT,
>> resets the software register , reenable PLX it,
>> and ack irq rtdm
>>
>> However at random time , I have always spurious interrupt in this =20
>> handler.
>> The time it occurs is random .
>>
>> attached my kernel config.gz
>
> Hi,
>
> Did you check the differences in masking/acking/unmasking interrupts fo=
r
> the interrupt controller you use between the I-pipe patch that works an=
d
> the I-pipe patch that does not work ?
>

I know that it rocks with
kernel 2.6.24.2 and  adeos-ipipe-2.6.24-x86-2.0-03.patch

it does not with :
kernel 2.6.26.2 and adeos-ipipe-2.6.26-x86-2.0-09.patch

Having a look at the patch I did not manage to find big differencies only=
 =20
in entry_32.S sysenter for enabling hw it, but I am not sure if this part=
 =20
of code may be related to my problem

The routed IRQ number is 18d

enabling ipipe and kernel debugging options does not help.


It would be useful , if I could reproduce the problem using a standard =20
component of the PC to trig an IT like the PLX soft register, in order =20
produce a regression test and some people being able to reproduce =20
it.Supposing the same problem should appear :-)



Best Regards
Steph


> Regards.
>



