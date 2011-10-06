MIME-Version: 1.0
In-Reply-To: <CAMwkeZzrfuB1Uf7f1eqG8zEvgeYMXrRspzUANeOaJR2qQUmhOQ@mail.gmail.com>
References: <CAMwkeZy-9Qw0LALq8rrJQKET_Bu7UHgu8YYoFw1z6jdS687fBg@domain.hid>
	<CAGc_wL172OGHZ-8SG8e77Fp5qwHqKvTY610aQsr3WA_bp+3HRg@domain.hid>
	<CAMwkeZyvyhHPZTWz1LiaOhWA9TdrQaXMo833Ej5JRwJR3Da2xw@domain.hid>
	<CAMwkeZxinGD8_yEYmo+ySHx9dzU6hEM4BFH4jejnTMd87f0M9Q@mail.gmail.com>
	<CAMesUR4+G-Bx9tDUPajp4EcKP70zLvQuLyjLeyNpfyrmCpwBBw@domain.hid>
	<CAMwkeZyQwtJbcMjOiSnmzoRDud+4=6Nt2NOcEdFG_+1QVSHoSQ@mail.gmail.com>
	<CAMwkeZzajkK7gRYH5cnAW1-5HvgxQyUogDZKpms1FUyLtwxpdg@domain.hid>
	<CAMesUR67RpFHRiNcd-yfR9WF2FRe1U3yBdXWP2dU30aQovCHKQ@mail.gmail.com>
	<CAMwkeZxybKS+-B2C_yaYX3_XSYnAKcj8xfX_YOgQ6Kt=mNTzJQ@mail.gmail.com>
	<CAMwkeZzrfuB1Uf7f1eqG8zEvgeYMXrRspzUANeOaJR2qQUmhOQ@mail.gmail.com>
Date: Thu, 6 Oct 2011 23:31:47 +0200
Message-ID: <CAMesUR5AvmUDW8wq4e9EtOgnpRtMD_qe8rQe7acgFT6KzdeYAg@domain.hid>
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
Cc: Xenomai help <xenomai@xenomai.org>

Hi,

2011/10/6 Fernando Herrero Carr=F3n <elferdo@domain.hid>:
>
>
> El 5 de octubre de 2011 20:06, Fernando Herrero Carr=F3n <elferdo@domain.hid=
om>
> escribi=F3:
>>
>> El 5 de octubre de 2011 18:16, Alexis Berlemont
>> <alexis.berlemont@domain.hid> escribi=F3:
>>>
>>> I think the problem might be located at two different places:
>>> 1) Either the DMA controller is badly configured and it copies the
>>> properly acquired values to wrong places.
>>> 2) Or the DAQ-STC module is badly configured; so, the =A0DMA controller
>>> copies the wrong values to right places.
>>>
>>> Concerning the alternative 1, I think it is not the most probable one.
>>> Why? Because, the DMA controller (the MITE) is configured the same way
>>> whatever the NI acquisition board holds it (or nearly).
>>> To check this idea: let's make a little test with cmd_read.
>>>
>>> If cmd_read is launched with the option -m (map), we get direct
>>> access, in user space, to the memory area the DMA controller is
>>> supposed to shot to.
>>>
>>> So, just after a4l_mmap (before the DMA controller shots anything):
>>> 367: =A0 =A0 =A0 =A0 =A0 =A0/* Map the analog input subdevice buffer */
>>> 368: =A0 =A0 =A0 =A0 =A0 =A0ret =3D a4l_mmap(&dsc, cmd.idx_subd, buf_si=
ze, &map);
>>> you can have a look at the values hold by the buffer:
>>> - If the values are already 0x8000, we might conclude that the DMA
>>> controller does not send anything there.
>>> - If the values are not 0x8000, then we are sure that the DMA
>>> controller does behave as expected. Consequently we can skip
>>> alternative 1) and focus on the second one.
>>>
>>> If the DAQ is not properly configured; things are getting a little bit
>>> simpler (if we have the documentation /. developer manual of your
>>> acquisition card). We just have to find which stuff was not properly
>>> configured. =A0A simple solution could be the monitoring of the status
>>> registers. In such a case, I can send you a patch which will dump the
>>> content of these registers.
>>>
>>> But before going that way, could you make the test with cmd_read + mmap=
?
>>>
>>> Regards,
>>>
>>> Alexis.
>>
>> Ok, I'll check those tomorrow. From what I recall, I checked cmd_read ju=
st
>> passing the '-m' option and resulted in the same behaviour, but I'll rec=
heck
>> tomorrow.
>>
>> What I find somewhat surprising is that I got it working with comedi, so=
 I
>> guess that the register programming should also be working with analogy.=
 The
>> only difference I have managed to find so far between the analogy and th=
e
>> comedi drivers, besides generic buffer management, is that comedi appear=
s to
>> handle DMA through the "generic device" interface (as in
>> http://www.mjmwired.net/kernel/Documentation/DMA-API.txt) and analogy
>> handles DMA through the PCI interface (as in
>> http://m8-android-kernel.googlecode.com/svn/trunk/Documentation/DMA-mapp=
ing.txt).
>> But this is merely speculation.
>>
>> I'll look tomorrow at your two options in more detail.
>>
>> Thanks for your help!
>> Fernando
>
> Dear Alexis,
>
> I just repeated the tests with mmap.
>
> Running the provided example of "cmd_read" with either "-m" or "-m -r" on=
ly
> dumps the 0x8000 value. _Sometimes_, very rarely, I can get to see differ=
ent
> values not far from that one, but if I get to plot it it just looks like
> noise. I don't know what is causing those values and I cannot reproduce t=
he
> conditions for them.
>
> Now I used gdb to step through the process (with my own code) and here is
> the sequence:
>
> -=A0 I run up to the line where the "mmapping" happens. I check that map =
=3D=3D
> NULL and after I run the "mmap()" it gets a different value and ret =3D=
=3D 0,
> ok.
>
> - I do a
> print *(unsigned short *)map@domain.hid
>
> =A0 to dump the contents of the buffer and it is all filled with zeroes a=
t
> this point.
>
> - I setup my command structure like this:
>
> =A0=A0=A0 cmd.idx_subd =3D 0;
> =A0=A0=A0 cmd.start_src =3D TRIG_NOW;
> =A0=A0=A0 cmd.start_arg =3D 0;
> =A0=A0=A0 cmd.flags =3D TRIG_WAKE_EOS;
> =A0=A0=A0 cmd.scan_begin_src =3D TRIG_TIMER;
> =A0=A0=A0 cmd.scan_begin_arg =3D 1e9 / INPUT_FREQ;
> =A0=A0=A0 cmd.convert_src =3D TRIG_NOW;
> =A0=A0=A0 cmd.convert_arg =3D 0;
> =A0=A0=A0 cmd.chan_descs =3D chanlist;
> =A0=A0=A0 cmd.nb_chan =3D NICHAN;
> =A0=A0=A0 cmd.scan_end_src =3D TRIG_COUNT;
> =A0=A0=A0 cmd.scan_end_arg=A0=A0=A0 =3D NICHAN;
>
> =A0=A0=A0 cmd.stop_src =3D TRIG_COUNT;
> =A0=A0=A0 cmd.stop_arg =3D SAMPLE_HISTORY;
>
> with
>
> INPUT_FREQ =3D 1000 (1kHz)
> NICHAN =3D 1=A0=A0 (I have also tried 4 and 8 with no difference in resul=
ts)
>
> and call the a4l_snd_command() function, which returns without errors.
>
> I dump the contents of the buffer and it is still filled with zeroes.
>
> - I declare
>
> unsigned long front =3D 0;
>
> and call
>
> ret =3D a4l_mark_bufrw(&dev_input, 0, front, &front);
>
> at this point the buffer gets filled with 0x8000:
>
>
> (gdb) print *(unsigned short *)map@domain.hid $1 =3D {0 <repeats 100 times>}
> (gdb) n=A0=A0=A0=A0 <------------------ calls a4l_mark_bufrw()
>
> 186=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 if (front =3D=3D 0) {
>
> (gdb) print /x*(unsigned short *)map@domain.hid
> $2 =3D {0x8000 <repeats 100 times>}
>
> Now I find it funny that the value read is always the same. Could it be t=
hat
> everything is working fine and it is the board itself that is transferrin=
g
> that value? Could it be an indicator for an error condition?

I don't think it is an error indicator; errors are reported in
dedicated status registers.

If I understand correctly, most of the times you acquire 0x8000 and a
few times other values. That could mean that 0x8000 values are really
produced by the ADC converter. By the way, 0x8000 is not a meaningless
value (0x0000 - 0xFFFF median). I don't know which range was selected
(-5V / 5V by default?) but it could mean that the card is acquiring a
continuous 0V signal.

Which channel are you using?
Could you test each channel separately and all of them at once?
Could try another range? 0V / 5V could be a great candidate: with this
one the acquired values could be 0x0000 instead of 0x8000.

Best regards,

Alexis.

