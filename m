MIME-Version: 1.0
In-Reply-To: <CAMwkeZzajkK7gRYH5cnAW1-5HvgxQyUogDZKpms1FUyLtwxpdg@domain.hid>
References: <CAMwkeZy-9Qw0LALq8rrJQKET_Bu7UHgu8YYoFw1z6jdS687fBg@domain.hid>
	<CAGc_wL172OGHZ-8SG8e77Fp5qwHqKvTY610aQsr3WA_bp+3HRg@domain.hid>
	<CAMwkeZyvyhHPZTWz1LiaOhWA9TdrQaXMo833Ej5JRwJR3Da2xw@domain.hid>
	<CAMwkeZxinGD8_yEYmo+ySHx9dzU6hEM4BFH4jejnTMd87f0M9Q@mail.gmail.com>
	<CAMesUR4+G-Bx9tDUPajp4EcKP70zLvQuLyjLeyNpfyrmCpwBBw@domain.hid>
	<CAMwkeZyQwtJbcMjOiSnmzoRDud+4=6Nt2NOcEdFG_+1QVSHoSQ@mail.gmail.com>
	<CAMwkeZzajkK7gRYH5cnAW1-5HvgxQyUogDZKpms1FUyLtwxpdg@domain.hid>
Date: Wed, 5 Oct 2011 23:16:00 +0200
Message-ID: <CAMesUR67RpFHRiNcd-yfR9WF2FRe1U3yBdXWP2dU30aQovCHKQ@mail.gmail.com>
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

2011/10/4 Fernando Herrero Carr=F3n <elferdo@domain.hid>:
> El 3 de octubre de 2011 18:41, Fernando Herrero Carr=F3n <elferdo@domain.hid=
om>
> escribi=F3:
>>
>> El 30 de septiembre de 2011 00:16, Alexis Berlemont
>> <alexis.berlemont@domain.hid> escribi=F3:
>>>
>>> Hi,
>>> [...]
>>> With insn_read, did you manage to acquire correct values at least?
>>>
>>
>> Dear Alexis,
>> insn_read does indeed work. If I run "insn_read -S 1000" I get my input
>> sampled at approx 125kHz. Running cmd_read with and without '-m' only
>> returns 0x8000.
>>
>> I have been playing around with __a4l_info and the driver code to track
>> down my problem. I am not familiar at all with low-level DAQ programming=
, so
>> I just followed my intuition.
>>
>> I modified
>> buffer.c:a4l_read_buf and buffer.h:__consume
>>
>> to dump the values that were being consumed from the internal buffer.
>> There I found the infamous 0x8000, so my conclusion is that those values=
 are
>> traveling along the kernel side. I decided I would go the other way arou=
nd
>> and modified
>>
>> drivers/analogy/national_instruments/mio_common.c: handle_a_interrupt
>> and drivers/analogy/buffer.c: a4l_buf_evt
>>
>> I guess that interrupt is being generated every time a DMA transfer has
>> been completed from the DAQ to analogy's internal=A0 buffer. I dump vari=
able
>> "count" in a4l_buf_evt and it always reports the appropriate byte count =
to
>> be transferred, which is "number of channels" * 2.
>>
>> My guess is that the DMA transfers are being performed to the wrong plac=
e,
>> because the whole procedure seems to be working ok otherwise.
>>
>> All help is appreciated,
>> Fernando
>>
>>
>
> Dear all,
>
> More updates on this. I just tested both the "cmd_read" example and my ow=
n
> code on the analogy_fake device. They're both working, I get a sawtooth
> shape. So my guess is still that there is some error in the DMA transfer =
in
> the NI driver(s).
>
> Could anyone please help me indicating where DMA is setup in the NI drive=
rs?
> I'll try to have a look at it myself, but a more experienced advice would=
 be
> helpful.
>

I think the problem might be located at two different places:
1) Either the DMA controller is badly configured and it copies the
properly acquired values to wrong places.
2) Or the DAQ-STC module is badly configured; so, the  DMA controller
copies the wrong values to right places.

Concerning the alternative 1, I think it is not the most probable one.
Why? Because, the DMA controller (the MITE) is configured the same way
whatever the NI acquisition board holds it (or nearly).
To check this idea: let's make a little test with cmd_read.

If cmd_read is launched with the option -m (map), we get direct
access, in user space, to the memory area the DMA controller is
supposed to shot to.

So, just after a4l_mmap (before the DMA controller shots anything):
367:		/* Map the analog input subdevice buffer */
368:		ret =3D a4l_mmap(&dsc, cmd.idx_subd, buf_size, &map);
you can have a look at the values hold by the buffer:
- If the values are already 0x8000, we might conclude that the DMA
controller does not send anything there.
- If the values are not 0x8000, then we are sure that the DMA
controller does behave as expected. Consequently we can skip
alternative 1) and focus on the second one.

If the DAQ is not properly configured; things are getting a little bit
simpler (if we have the documentation /. developer manual of your
acquisition card). We just have to find which stuff was not properly
configured.  A simple solution could be the monitoring of the status
registers. In such a case, I can send you a patch which will dump the
content of these registers.

But before going that way, could you make the test with cmd_read + mmap?

Regards,

Alexis.

