MIME-Version: 1.0
In-Reply-To: <CAMwkeZxinGD8_yEYmo+ySHx9dzU6hEM4BFH4jejnTMd87f0M9Q@mail.gmail.com>
References: <CAMwkeZy-9Qw0LALq8rrJQKET_Bu7UHgu8YYoFw1z6jdS687fBg@domain.hid>
	<CAGc_wL172OGHZ-8SG8e77Fp5qwHqKvTY610aQsr3WA_bp+3HRg@domain.hid>
	<CAMwkeZyvyhHPZTWz1LiaOhWA9TdrQaXMo833Ej5JRwJR3Da2xw@domain.hid>
	<CAMwkeZxinGD8_yEYmo+ySHx9dzU6hEM4BFH4jejnTMd87f0M9Q@mail.gmail.com>
Date: Fri, 30 Sep 2011 00:16:28 +0200
Message-ID: <CAMesUR4+G-Bx9tDUPajp4EcKP70zLvQuLyjLeyNpfyrmCpwBBw@domain.hid>
From: Alexis Berlemont <alexis.berlemont@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai-help] Command code working with comedi not working
	with analogy
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: =?ISO-8859-1?Q?Fernando_Herrero_Carr=F3n?= <elferdo@domain.hid>
Cc: xenomai@xenomai.org

Hi,

2011/9/29 Fernando Herrero Carr=F3n <elferdo@domain.hid>:
> El 28 de septiembre de 2011 12:19, Fernando Herrero Carr=F3n
> <elferdo@domain.hid> escribi=F3:
>>
>> 2011/9/28 Julien Delange <julien.delange@domain.hid>
>>>
>>> 2011/9/27 Fernando Herrero Carr=F3n <elferdo@domain.hid>:
>>> > [snip]
>>>
>>> Dear Fernando,
>>>
>>> Would it be possible to provide more information about your bug, in
>>> particular, the configuration of the board (which is analogy0, ...)
>>> and the code you are trying to use ?
>>>
>>> Also, as Gilles said, please also try the latest rc release, it might
>>> solve your issues.
>>>
>>> Thanks,
>>
>> Dear Gilles and Julien,
>>
>> Thanks for your replies. I will try the latest RC and let you know.
>>
>> These are the details of my setup:
>>
>> - Dmesg output:
>>
>> =A0Analogy: MITE: Available NI device IDs: 0x1870 0x70c0
>>
>> - lspci:
>> 01:05.0 Class ff00: National Instruments Device 70c0 (this should be the
>> NI 6143) <- used for AO
>> 01:06.0 Class ff00: National Instruments PCI-6713 <- used for AI
>>
>> - analogy-config:
>> /usr/xenomai/sbin/analogy_config=A0 analogy0 analogy_ni_pcimio 1,5
>> /usr/xenomai/sbin/analogy_config=A0 analogy1 analogy_ni_pcimio 1,6
>>
>> - cat /proc/analogy/devices
>> --=A0 Analogy devices --
>>
>> | idx | status | driver
>> |=A0 00 | Linked | analogy_ni_pcimio
>> |=A0 01 | Linked | analogy_ni_pcimio
>> |=A0 02 | Unused | No driver
>> [...]
>>
>> - cat /proc/analogy/00-analogy_ni_pcimio
>> --=A0 Subdevices --
>>
>> | idx | type
>> |=A0 00 | Analog input subdevice
>> |=A0 01 | Unused subdevice
>> |=A0 02 | Digital input/output subdevice
>> |=A0 03 | Unused subdevice
>> |=A0 04 | Unused subdevice
>> |=A0 05 | Calibration subdevice
>> |=A0 06 | Memory subdevice
>> |=A0 07 | Digital input/output subdevice
>> |=A0 08 | Unused subdevice
>> |=A0 09 | Serial subdevice
>> |=A0 10 | Unused subdevice
>> |=A0 11 | Counter subdevice
>> |=A0 12 | Counter subdevice
>> |=A0 13 | Counter subdevice
>>
>> - cat /proc/analogy/01-analogy_ni_pcimio
>> --=A0 Subdevices --
>>
>> | idx | type
>> |=A0 00 | Unused subdevice
>> |=A0 01 | Analog output subdevice
>> |=A0 02 | Digital input/output subdevice
>> |=A0 03 | Unused subdevice
>> |=A0 04 | Unused subdevice
>> |=A0 05 | Calibration subdevice
>> |=A0 06 | Memory subdevice
>> |=A0 07 | Digital input/output subdevice
>> |=A0 08 | Unused subdevice
>> |=A0 09 | Serial subdevice
>> |=A0 10 | Unused subdevice
>> |=A0 11 | Counter subdevice
>> |=A0 12 | Counter subdevice
>> |=A0 13 | Counter subdevice
>>
>> Thanks,
>> Fernando
>
> Dear all,
>
> I have followed your advice and just tested with the following
> kernel/xenomai versions:
>
> Linux ******** 2.6.38.8-xenomai-2.6rc4 #1 SMP PREEMPT Thu Sep 29 16:17:41
> BRT 2011 x86_64 GNU/Linux
>
> Now both "cmd_read" and my own code are running, but "a4l_async_read" rea=
ds
> either garbage or either value of 0 or 0x8000. In order to make cmd_read
> work with my board I had to make the following changes to the code:
>
> --- cmd_read.c.orig=A0=A0=A0 2011-09-29 16:40:50.000000000 -0300
> +++ cmd_read.c=A0=A0=A0 2011-09-29 16:41:04.000000000 -0300
> @@ -66,8 +66,8 @@
> =A0=A0=A0=A0 .start_arg =3D 0,
> =A0=A0=A0=A0 .scan_begin_src =3D TRIG_TIMER,
> =A0=A0=A0=A0 .scan_begin_arg =3D 8000000,=A0=A0=A0 /* in ns */
> -=A0=A0=A0 .convert_src =3D TRIG_TIMER,
> -=A0=A0=A0 .convert_arg =3D 500000,=A0=A0=A0 /* in ns */
> +=A0=A0=A0 .convert_src =3D TRIG_NOW,
> +=A0=A0=A0 .convert_arg =3D 00000,=A0=A0=A0 /* in ns */
> =A0=A0=A0=A0 .scan_end_src =3D TRIG_COUNT,
> =A0=A0=A0=A0 .scan_end_arg =3D 0,
> =A0=A0=A0=A0 .stop_src =3D TRIG_COUNT,
>
> otherwise the drive would complain about "the driver cmd_test failed" or
> something like that, because my board has 8 parallel ADCs.
>
> If I run my program (see attachment) and call dmesg I can see:
>
> [=A0 641.237710] Analogy: analogy_ni_pcimio: ni_ai_cmd: start
> [=A0 641.237718] Analogy: analogy_ni_pcimio: ni_ai_cmd:
> Interrupt_A_Enable_Register =3D 0x0031
> [=A0 641.237723] Analogy: analogy_ni_pcimio: ni_ai_cmd: exit
> [=A0 641.238874] Analogy: analogy_ni_pcimio: ni_mio_common: interrupt:
> a_status=3D90b0 ai_mite_status=3D00200000
> [=A0 641.239872] Analogy: analogy_ni_pcimio: ni_mio_common: interrupt:
> a_status=3D9030 ai_mite_status=3D00200000
> [...]
> [=A0 642.237879] Analogy: analogy_ni_pcimio: ni_mio_common: interrupt:
> a_status=3D9070 ai_mite_status=3D00200000
> [=A0 642.237881] Analogy: analogy_ni_pcimio: ni_mio_common: SC_TC interru=
pt
>
> I just checked my setup with our RTAI/comedi code and it is properly
> working. The input card is attached to a 3Hz sine wave generator with 1V
> peek-to-peek. If I run the attached program, the output looks like this:
>
> Analogy device analogy_ni_pcimio.
> Channel 0 has 16 bits and 1 different ranges
> 32768
> 32768
> 32768
> 32768
> 32768
> [...]
> 32768
>
> Any help on debugging this would be greatly appreciated.

With insn_read, did you manage to acquire correct values at least?

>
> Sincerely,
> Fernando
>
> _______________________________________________
> Xenomai-help mailing list
> Xenomai-help@domain.hid
> https://mail.gna.org/listinfo/xenomai-help
>
>

Alexis.

