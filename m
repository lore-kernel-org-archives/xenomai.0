MIME-Version: 1.0
In-Reply-To: <CAMesUR59KFH=hjpo=fr8DCHeg50driuitcikc5HfHTZWG5ct8A@mail.gmail.com>
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
	<CAMesUR5AvmUDW8wq4e9EtOgnpRtMD_qe8rQe7acgFT6KzdeYAg@domain.hid>
	<CAMwkeZxAvBeY=0c49N+QtUYCKCTiGo4yc9TAEQPLJAJmBXPn+A@mail.gmail.com>
	<CAMesUR59KFH=hjpo=fr8DCHeg50driuitcikc5HfHTZWG5ct8A@mail.gmail.com>
Date: Mon, 10 Oct 2011 12:27:11 -0300
Message-ID: <CAMwkeZyPorMx9n1Y8YAEJE4hUh49=u9Mr_tj7qzYAnquMa60rw@domain.hid>
From: =?UTF-8?Q?Fernando_Herrero_Carr=C3=B3n?= <elferdo@domain.hid>
Content-Type: multipart/alternative; boundary=bcaec5215d7bbf128d04aef36c60
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
To: Xenomai help <xenomai@xenomai.org>

--bcaec5215d7bbf128d04aef36c60
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

El 7 de octubre de 2011 19:06, Alexis Berlemont
<alexis.berlemont@domain.hid>escribi=C3=B3:

> Hi,
>
> 2011/10/7 Fernando Herrero Carr=C3=B3n <elferdo@domain.hid>:
> > El 6 de octubre de 2011 18:31, Alexis Berlemont <
> alexis.berlemont@domain.hid>
> > escribi=C3=B3:
> >>
> >> Hi,
> >>
> >> 2011/10/6 Fernando Herrero Carr=C3=B3n <elferdo@domain.hid>:
> >> >
> >> >
> >> > El 5 de octubre de 2011 20:06, Fernando Herrero Carr=C3=B3n
> >> > <elferdo@domain.hid>
> >> > escribi=C3=B3:
> >> >>
> >> >> El 5 de octubre de 2011 18:16, Alexis Berlemont
> >> >> <alexis.berlemont@domain.hid> escribi=C3=B3:
> >> >>>
> >> >>> I think the problem might be located at two different places:
> >> >>> 1) Either the DMA controller is badly configured and it copies the
> >> >>> properly acquired values to wrong places.
> >> >>> 2) Or the DAQ-STC module is badly configured; so, the  DMA
> controller
> >> >>> copies the wrong values to right places.
> >> >>>
> >> >>> Concerning the alternative 1, I think it is not the most probable
> one.
> >> >>> Why? Because, the DMA controller (the MITE) is configured the same
> way
> >> >>> whatever the NI acquisition board holds it (or nearly).
> >> >>> To check this idea: let's make a little test with cmd_read.
> >> >>>
> >> >>> If cmd_read is launched with the option -m (map), we get direct
> >> >>> access, in user space, to the memory area the DMA controller is
> >> >>> supposed to shot to.
> >> >>>
> >> >>> So, just after a4l_mmap (before the DMA controller shots anything)=
:
> >> >>> 367:            /* Map the analog input subdevice buffer */
> >> >>> 368:            ret =3D a4l_mmap(&dsc, cmd.idx_subd, buf_size, &ma=
p);
> >> >>> you can have a look at the values hold by the buffer:
> >> >>> - If the values are already 0x8000, we might conclude that the DMA
> >> >>> controller does not send anything there.
> >> >>> - If the values are not 0x8000, then we are sure that the DMA
> >> >>> controller does behave as expected. Consequently we can skip
> >> >>> alternative 1) and focus on the second one.
> >> >>>
> >> >>> If the DAQ is not properly configured; things are getting a little
> bit
> >> >>> simpler (if we have the documentation /. developer manual of your
> >> >>> acquisition card). We just have to find which stuff was not proper=
ly
> >> >>> configured.  A simple solution could be the monitoring of the stat=
us
> >> >>> registers. In such a case, I can send you a patch which will dump
> the
> >> >>> content of these registers.
> >> >>>
> >> >>> But before going that way, could you make the test with cmd_read +
> >> >>> mmap?
> >> >>>
> >> >>> Regards,
> >> >>>
> >> >>> Alexis.
> >> >>
> >> >> Ok, I'll check those tomorrow. From what I recall, I checked cmd_re=
ad
> >> >> just
> >> >> passing the '-m' option and resulted in the same behaviour, but I'l=
l
> >> >> recheck
> >> >> tomorrow.
> >> >>
> >> >> What I find somewhat surprising is that I got it working with comed=
i,
> >> >> so I
> >> >> guess that the register programming should also be working with
> >> >> analogy. The
> >> >> only difference I have managed to find so far between the analogy a=
nd
> >> >> the
> >> >> comedi drivers, besides generic buffer management, is that comedi
> >> >> appears to
> >> >> handle DMA through the "generic device" interface (as in
> >> >> http://www.mjmwired.net/kernel/Documentation/DMA-API.txt) and
> analogy
> >> >> handles DMA through the PCI interface (as in
> >> >>
> >> >>
> http://m8-android-kernel.googlecode.com/svn/trunk/Documentation/DMA-mappi=
ng.txt
> ).
> >> >> But this is merely speculation.
> >> >>
> >> >> I'll look tomorrow at your two options in more detail.
> >> >>
> >> >> Thanks for your help!
> >> >> Fernando
> >> >
> >> > Dear Alexis,
> >> >
> >> > I just repeated the tests with mmap.
> >> >
> >> > Running the provided example of "cmd_read" with either "-m" or "-m -=
r"
> >> > only
> >> > dumps the 0x8000 value. _Sometimes_, very rarely, I can get to see
> >> > different
> >> > values not far from that one, but if I get to plot it it just looks
> like
> >> > noise. I don't know what is causing those values and I cannot
> reproduce
> >> > the
> >> > conditions for them.
> >> >
> >> > Now I used gdb to step through the process (with my own code) and he=
re
> >> > is
> >> > the sequence:
> >> >
> >> > -  I run up to the line where the "mmapping" happens. I check that m=
ap
> >> > =3D=3D
> >> > NULL and after I run the "mmap()" it gets a different value and ret =
=3D=3D
> >> > 0,
> >> > ok.
> >> >
> >> > - I do a
> >> > print *(unsigned short *)map@domain.hid
> >> >
> >> >   to dump the contents of the buffer and it is all filled with zeroe=
s
> at
> >> > this point.
> >> >
> >> > - I setup my command structure like this:
> >> >
> >> >     cmd.idx_subd =3D 0;
> >> >     cmd.start_src =3D TRIG_NOW;
> >> >     cmd.start_arg =3D 0;
> >> >     cmd.flags =3D TRIG_WAKE_EOS;
> >> >     cmd.scan_begin_src =3D TRIG_TIMER;
> >> >     cmd.scan_begin_arg =3D 1e9 / INPUT_FREQ;
> >> >     cmd.convert_src =3D TRIG_NOW;
> >> >     cmd.convert_arg =3D 0;
> >> >     cmd.chan_descs =3D chanlist;
> >> >     cmd.nb_chan =3D NICHAN;
> >> >     cmd.scan_end_src =3D TRIG_COUNT;
> >> >     cmd.scan_end_arg    =3D NICHAN;
> >> >
> >> >     cmd.stop_src =3D TRIG_COUNT;
> >> >     cmd.stop_arg =3D SAMPLE_HISTORY;
> >> >
> >> > with
> >> >
> >> > INPUT_FREQ =3D 1000 (1kHz)
> >> > NICHAN =3D 1   (I have also tried 4 and 8 with no difference in resu=
lts)
> >> >
> >> > and call the a4l_snd_command() function, which returns without error=
s.
> >> >
> >> > I dump the contents of the buffer and it is still filled with zeroes=
.
> >> >
> >> > - I declare
> >> >
> >> > unsigned long front =3D 0;
> >> >
> >> > and call
> >> >
> >> > ret =3D a4l_mark_bufrw(&dev_input, 0, front, &front);
> >> >
> >> > at this point the buffer gets filled with 0x8000:
> >> >
> >> >
> >> > (gdb) print *(unsigned short *)map@domain.hid $1 =3D {0 <repeats 100 times>=
}
> >> > (gdb) n     <------------------ calls a4l_mark_bufrw()
> >> >
> >> > 186            if (front =3D=3D 0) {
> >> >
> >> > (gdb) print /x*(unsigned short *)map@domain.hid
> >> > $2 =3D {0x8000 <repeats 100 times>}
> >> >
> >> > Now I find it funny that the value read is always the same. Could it
> be
> >> > that
> >> > everything is working fine and it is the board itself that is
> >> > transferring
> >> > that value? Could it be an indicator for an error condition?
> >>
> >> I don't think it is an error indicator; errors are reported in
> >> dedicated status registers.
> >>
> >
> > Yep, you're right on that one...
> >
> >>
> >> If I understand correctly, most of the times you acquire 0x8000 and a
> >> few times other values. That could mean that 0x8000 values are really
> >> produced by the ADC converter. By the way, 0x8000 is not a meaningless
> >> value (0x0000 - 0xFFFF median). I don't know which range was selected
> >> (-5V / 5V by default?) but it could mean that the card is acquiring a
> >> continuous 0V signal.
> >
> >
> >>
> >> Which channel are you using?
> >> Could you test each channel separately and all of them at once?
> >> Could try another range? 0V / 5V could be a great candidate: with this
> >> one the acquired values could be 0x0000 instead of 0x8000.
> >>
> >
> > That makes sense, but with insn_read I get the right waveshape, with th=
e
> > same setup. I am reading a 3Hz, 3V input signal. Unfortunately, this
> board
> > reports only one possible range. The output of cmd_read -v reports:
> >
> > cmd_read: device analogy0 opened (fd=3D0)
> > cmd_read: basic descriptor retrieved
> >      subdevices count =3D 14
> >      read subdevice index =3D 0
> >      write subdevice index =3D 0
> > cmd_read: complex descriptor retrieved
> > cmd_read: channel 0
> >      ranges count =3D 1
> >      bit width =3D 16 (bits)
> >
> > Now here goes a crazy thing. I modified
> > ksrc/drivers/analogy/national_instruments/mio_common.c:ni_ai_cmd() so
> that
> > every time a command is issued the buffer is filled with 0x0f. That is,=
 I
> > added the following line:
> >
> >     memset(subd->buf->buf, 0x0f, subd->buf->size);
> >
> > Now I repeat the same sequence as in my previous mail with gdb:
> >
> > - Map the buffer, check address and content (buffer has some leftovers
> from
> > previous runs)
> >
> > ret =3D a4l_mmap(&dev_input, 0, buf_size, &map);
> >
> > (gdb) print map
> > $1 =3D (void *) 0x7ffff7fc8000
> > (gdb) print /x*(unsigned short *)map@domain.hid
> > $2 =3D {0x600, 0x5e04, 0x0 <repeats 98 times>}
> >
> > - Issue the command and recheck contents. Now the buffer is filled with
> > 0x0f0f
> >
> > (gdb) n
> > 173        setup_input_card(&dev_input);
> >
> > (gdb) n
> > Channel 0 has 16 bits and 1 different ranges
> > 175        unsigned long front =3D 0;
> >
> > (gdb) print /x*(unsigned short *)map@domain.hid
> > $3 =3D {0xf0f <repeats 100 times>}
> >
> > - Call a4l_mark_bufrw() and recheck contents. 70 samples have changed
> > values, 30 remain the same. In those samples that changed value, only o=
ne
> > bit changed!!
> >
> > (gdb) n
> > 177        for(int scan =3D 0; scan < SAMPLE_HISTORY; scan++)
> >
> > (gdb) n
> > 180            ret =3D a4l_mark_bufrw(&dev_input, 0, front, &front);
> >
> > (gdb) n
> > 186            if (front =3D=3D 0) {
> >
> > (gdb) print /x*(unsigned short *)map@domain.hid
> > $4 =3D {0x8f0f <repeats 70 times>, 0xf0f <repeats 30 times>}
> >
> > So there is either an 'or' operation or an addition operation with 0x80=
00
> > that is changing those values. As you said, 0x8000 is a very
> representative
> > value. It represents zero on a 16 DAQ like mine, and it is also a value
> used
> > as a mask in various places:
> >
> > ./ksrc/drivers/analogy/national_instruments/ni_stc.h:#define
> > _bit15             0x8000
> > ./ksrc/drivers/analogy/national_instruments/ni_stc.h:#define
> > Calibration_Channel_6143_RelayOn   0x8000 (which happens to be my DAQ..=
.)
> >
> > Running cmd_read only yields the 0x8f0f value now, by the way.
> >
> > I now it's hard to imagine what is happening without having the board
> > yourself, so I really appreciate your help.
>
> I may have an idea thanks to your additional test. I cant' figure out
> how a DMA controller could perform a or / add operation on memory with
> one single write shot; so, this operation must be done by the CPU.
>
> The only way for the CPU to interfere is through a munge operaiton,
> let's have a look at ni_ai_munge16:
>
> static void ni_ai_munge16(a4l_subd_t *subd, void *buf, unsigned long size=
)
> {
>        a4l_dev_t *dev =3D subd->dev;
>        a4l_cmd_t *cmd =3D a4l_get_cmd(subd);
>        int chan_idx =3D a4l_get_chan(subd);
>        unsigned int i;
>        sampl_t *array =3D buf;
>
>        for (i =3D 0; i < size / sizeof(sampl_t); i++) {
> #if (defined(CONFIG_XENO_DRIVERS_ANALOGY_NI_MITE) || \
>     defined(CONFIG_XENO_DRIVERS_ANALOGY_NI_MITE_MODULE))
>                array[i] =3D le16_to_cpu(array[i]);
> #endif /* CONFIG_XENO_DRIVERS_ANALOGY_NI_MITE */
>
> ###### HERE
>                array[i] +=3D devpriv->ai_offset[chan_idx];
> ######## HERE
>
>                chan_idx++;
>                chan_idx %=3D cmd->nb_chan;
>        }
> }
>
> According to the code in ni_load_channelgain_list, I think ai_offset
> is set to 0x8000 in your case.
>
> Could you empty the function ni_ai_munge16 and check that the buffer
> is not modified anymore?
>
> If it is the case, let's go back to your first theory: the DMA controller=
.
>
>
Dear Alexis,

Yes, I commented out that line you mentioned and indeed the buffer is now
filled with 0x0f0f instead of 0x8f0f. So yes, I still suspect it has to do
with the DMA transfers.

Recalling, it seems that everything is working with the DMA except this ver=
y
point. I mean, I set my board to transfer data at the end of every scan
(with .flags =3D TRIG_WAKE_EOS) and I program a given frequency, say 1kHz. =
The
dmesg reports an interrupt from the board with the right timing and my
"a4l_async_read()" call gets unblocked apparently with the right timing as
well. At the end of buffer.c:a4l_buf_evt() I dump the value of "count",
which reports the number of bytes transferred in the current event, and it
reports the expected value (except in some cases, which I will comment on a
separate mail).

So I would like to check the following points:

- Check that the subdevice's buffer is properly configured when the device
is set up and/or when the command is launched.

- Check that the DMA programming is actually using that buffer.

- Check that the read operation is accessing the right buffer as well.

I can't think of many other things going wrong. While writing this email I
have thought of some further tests, so here is the result :)

I have changed the size of the default buffer using analogy_config. First, =
I
have specified:

sudo /usr/xenomai/sbin/analogy_config -v analogy0 -S 4

Then I have run cmd_read, with the same results, but I have dumped some
values at "ni_ai_setup_MITE_dma()" and at a4l_buf_evt():

[ 3115.793026] Analogy: analogy_ni_pcimio: ni_ai_setup_MITE_dma: beginning
[ 3115.793029] Analogy: analogy_ni_pcimio: ni_ai_setup_MITE_dma: buf->buf:
ffffc90001893000; buf->end_count 800; buf->prd_count 0; buf->cns_count 0;
buf->tmp_count 0
[ 3115.793035] Analogy: analogy_ni_pcimio: ni_ai_cmd: exit
[ 3116.593187] Analogy: analogy_ni_pcimio: ni_mio_common: interrupt:
a_status=3D90f0 ai_mite_status=3D00200000
[ 3116.593189] Analogy: analogy_ni_pcimio: ni_mio_common: SC_TC interrupt
[ 3116.593191] Analogy: Signalling event. Available data to user: 800. Two
first bytes in buffer: 15d 15d. Buffer pointer: ffffc90001893000

Now I changed the size of the buffer to 8, which aparently resulted in a
buffer reallocation:

[ 3119.523172] Analogy: analogy_ni_pcimio: ni_ai_setup_MITE_dma: beginning
[ 3119.523175] Analogy: analogy_ni_pcimio: ni_ai_setup_MITE_dma: buf->buf:
ffffc9000189b000; buf->end_count 800; buf->prd_count 0; buf->cns_count 0;
buf->tmp_count 0
[ 3119.523181] Analogy: analogy_ni_pcimio: ni_ai_cmd: exit
[ 3120.323332] Analogy: analogy_ni_pcimio: ni_mio_common: interrupt:
a_status=3D90f0 ai_mite_status=3D00200000
[ 3120.323335] Analogy: analogy_ni_pcimio: ni_mio_common: SC_TC interrupt
[ 3120.323336] Analogy: Signalling event. Available data to user: 800. Two
first bytes in buffer: 15d 15d. Buffer pointer: ffffc9000189b000

I don't know if this is really useful, but this is proving that at least
"ni_ai_setup_MITE_dma()" and "a4l_buf_evt()" are consistent in their notion
of buffer.

Best regards,
Fernando

--bcaec5215d7bbf128d04aef36c60
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<br><br><div class=3D"gmail_quote">El 7 de octubre de 2011 19:06, Alexis Be=
rlemont <span dir=3D"ltr">&lt;<a href=3D"mailto:alexis.berlemont@domain.hid"=
>alexis.berlemont@domain.hid</a>&gt;</span> escribi=C3=B3:<br><blockquote cl=
ass=3D"gmail_quote" style=3D"margin: 0pt 0pt 0pt 0.8ex; border-left: 1px so=
lid rgb(204, 204, 204); padding-left: 1ex;">
Hi,<br>
<br>
2011/10/7 Fernando Herrero Carr=C3=B3n &lt;<a href=3D"mailto:elferdo@domain.hid.=
com">elferdo@domain.hid</a>&gt;:<br>
<div><div></div><div class=3D"h5">&gt; El 6 de octubre de 2011 18:31, Alexi=
s Berlemont &lt;<a href=3D"mailto:alexis.berlemont@domain.hid">alexis.berlem=
ont@domain.hid</a>&gt;<br>
&gt; escribi=C3=B3:<br>
&gt;&gt;<br>
&gt;&gt; Hi,<br>
&gt;&gt;<br>
&gt;&gt; 2011/10/6 Fernando Herrero Carr=C3=B3n &lt;<a href=3D"mailto:elfer=
do@domain.hid">elferdo@domain.hid</a>&gt;:<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; El 5 de octubre de 2011 20:06, Fernando Herrero Carr=C3=B3n<b=
r>
&gt;&gt; &gt; &lt;<a href=3D"mailto:elferdo@domain.hid">elferdo@domain.hid</a=
>&gt;<br>
&gt;&gt; &gt; escribi=C3=B3:<br>
&gt;&gt; &gt;&gt;<br>
&gt;&gt; &gt;&gt; El 5 de octubre de 2011 18:16, Alexis Berlemont<br>
&gt;&gt; &gt;&gt; &lt;<a href=3D"mailto:alexis.berlemont@domain.hid">alexis.=
berlemont@domain.hid</a>&gt; escribi=C3=B3:<br>
&gt;&gt; &gt;&gt;&gt;<br>
&gt;&gt; &gt;&gt;&gt; I think the problem might be located at two different=
 places:<br>
&gt;&gt; &gt;&gt;&gt; 1) Either the DMA controller is badly configured and =
it copies the<br>
&gt;&gt; &gt;&gt;&gt; properly acquired values to wrong places.<br>
&gt;&gt; &gt;&gt;&gt; 2) Or the DAQ-STC module is badly configured; so, the=
 =C2=A0DMA controller<br>
&gt;&gt; &gt;&gt;&gt; copies the wrong values to right places.<br>
&gt;&gt; &gt;&gt;&gt;<br>
&gt;&gt; &gt;&gt;&gt; Concerning the alternative 1, I think it is not the m=
ost probable one.<br>
&gt;&gt; &gt;&gt;&gt; Why? Because, the DMA controller (the MITE) is config=
ured the same way<br>
&gt;&gt; &gt;&gt;&gt; whatever the NI acquisition board holds it (or nearly=
).<br>
&gt;&gt; &gt;&gt;&gt; To check this idea: let&#39;s make a little test with=
 cmd_read.<br>
&gt;&gt; &gt;&gt;&gt;<br>
&gt;&gt; &gt;&gt;&gt; If cmd_read is launched with the option -m (map), we =
get direct<br>
&gt;&gt; &gt;&gt;&gt; access, in user space, to the memory area the DMA con=
troller is<br>
&gt;&gt; &gt;&gt;&gt; supposed to shot to.<br>
&gt;&gt; &gt;&gt;&gt;<br>
&gt;&gt; &gt;&gt;&gt; So, just after a4l_mmap (before the DMA controller sh=
ots anything):<br>
&gt;&gt; &gt;&gt;&gt; 367: =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* Map =
the analog input subdevice buffer */<br>
&gt;&gt; &gt;&gt;&gt; 368: =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D=
 a4l_mmap(&amp;dsc, cmd.idx_subd, buf_size, &amp;map);<br>
&gt;&gt; &gt;&gt;&gt; you can have a look at the values hold by the buffer:=
<br>
&gt;&gt; &gt;&gt;&gt; - If the values are already 0x8000, we might conclude=
 that the DMA<br>
&gt;&gt; &gt;&gt;&gt; controller does not send anything there.<br>
&gt;&gt; &gt;&gt;&gt; - If the values are not 0x8000, then we are sure that=
 the DMA<br>
&gt;&gt; &gt;&gt;&gt; controller does behave as expected. Consequently we c=
an skip<br>
&gt;&gt; &gt;&gt;&gt; alternative 1) and focus on the second one.<br>
&gt;&gt; &gt;&gt;&gt;<br>
&gt;&gt; &gt;&gt;&gt; If the DAQ is not properly configured; things are get=
ting a little bit<br>
&gt;&gt; &gt;&gt;&gt; simpler (if we have the documentation /. developer ma=
nual of your<br>
&gt;&gt; &gt;&gt;&gt; acquisition card). We just have to find which stuff w=
as not properly<br>
&gt;&gt; &gt;&gt;&gt; configured. =C2=A0A simple solution could be the moni=
toring of the status<br>
&gt;&gt; &gt;&gt;&gt; registers. In such a case, I can send you a patch whi=
ch will dump the<br>
&gt;&gt; &gt;&gt;&gt; content of these registers.<br>
&gt;&gt; &gt;&gt;&gt;<br>
&gt;&gt; &gt;&gt;&gt; But before going that way, could you make the test wi=
th cmd_read +<br>
&gt;&gt; &gt;&gt;&gt; mmap?<br>
&gt;&gt; &gt;&gt;&gt;<br>
&gt;&gt; &gt;&gt;&gt; Regards,<br>
&gt;&gt; &gt;&gt;&gt;<br>
&gt;&gt; &gt;&gt;&gt; Alexis.<br>
&gt;&gt; &gt;&gt;<br>
&gt;&gt; &gt;&gt; Ok, I&#39;ll check those tomorrow. From what I recall, I =
checked cmd_read<br>
&gt;&gt; &gt;&gt; just<br>
&gt;&gt; &gt;&gt; passing the &#39;-m&#39; option and resulted in the same =
behaviour, but I&#39;ll<br>
&gt;&gt; &gt;&gt; recheck<br>
&gt;&gt; &gt;&gt; tomorrow.<br>
&gt;&gt; &gt;&gt;<br>
&gt;&gt; &gt;&gt; What I find somewhat surprising is that I got it working =
with comedi,<br>
&gt;&gt; &gt;&gt; so I<br>
&gt;&gt; &gt;&gt; guess that the register programming should also be workin=
g with<br>
&gt;&gt; &gt;&gt; analogy. The<br>
&gt;&gt; &gt;&gt; only difference I have managed to find so far between the=
 analogy and<br>
&gt;&gt; &gt;&gt; the<br>
&gt;&gt; &gt;&gt; comedi drivers, besides generic buffer management, is tha=
t comedi<br>
&gt;&gt; &gt;&gt; appears to<br>
&gt;&gt; &gt;&gt; handle DMA through the &quot;generic device&quot; interfa=
ce (as in<br>
&gt;&gt; &gt;&gt; <a href=3D"http://www.mjmwired.net/kernel/Documentation/D=
MA-API.txt" target=3D"_blank">http://www.mjmwired.net/kernel/Documentation/=
DMA-API.txt</a>) and analogy<br>
&gt;&gt; &gt;&gt; handles DMA through the PCI interface (as in<br>
&gt;&gt; &gt;&gt;<br>
&gt;&gt; &gt;&gt; <a href=3D"http://m8-android-kernel.googlecode.com/svn/tr=
unk/Documentation/DMA-mapping.txt" target=3D"_blank">http://m8-android-kern=
el.googlecode.com/svn/trunk/Documentation/DMA-mapping.txt</a>).<br>
&gt;&gt; &gt;&gt; But this is merely speculation.<br>
&gt;&gt; &gt;&gt;<br>
&gt;&gt; &gt;&gt; I&#39;ll look tomorrow at your two options in more detail=
.<br>
&gt;&gt; &gt;&gt;<br>
&gt;&gt; &gt;&gt; Thanks for your help!<br>
&gt;&gt; &gt;&gt; Fernando<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; Dear Alexis,<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; I just repeated the tests with mmap.<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; Running the provided example of &quot;cmd_read&quot; with eit=
her &quot;-m&quot; or &quot;-m -r&quot;<br>
&gt;&gt; &gt; only<br>
&gt;&gt; &gt; dumps the 0x8000 value. _Sometimes_, very rarely, I can get t=
o see<br>
&gt;&gt; &gt; different<br>
&gt;&gt; &gt; values not far from that one, but if I get to plot it it just=
 looks like<br>
&gt;&gt; &gt; noise. I don&#39;t know what is causing those values and I ca=
nnot reproduce<br>
&gt;&gt; &gt; the<br>
&gt;&gt; &gt; conditions for them.<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; Now I used gdb to step through the process (with my own code)=
 and here<br>
&gt;&gt; &gt; is<br>
&gt;&gt; &gt; the sequence:<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; -=C2=A0 I run up to the line where the &quot;mmapping&quot; h=
appens. I check that map<br>
&gt;&gt; &gt; =3D=3D<br>
&gt;&gt; &gt; NULL and after I run the &quot;mmap()&quot; it gets a differe=
nt value and ret =3D=3D<br>
&gt;&gt; &gt; 0,<br>
&gt;&gt; &gt; ok.<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; - I do a<br>
&gt;&gt; &gt; print *(unsigned short *)map@domain.hid<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; =C2=A0 to dump the contents of the buffer and it is all fille=
d with zeroes at<br>
&gt;&gt; &gt; this point.<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; - I setup my command structure like this:<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; =C2=A0=C2=A0=C2=A0 cmd.idx_subd =3D 0;<br>
&gt;&gt; &gt; =C2=A0=C2=A0=C2=A0 cmd.start_src =3D TRIG_NOW;<br>
&gt;&gt; &gt; =C2=A0=C2=A0=C2=A0 cmd.start_arg =3D 0;<br>
&gt;&gt; &gt; =C2=A0=C2=A0=C2=A0 cmd.flags =3D TRIG_WAKE_EOS;<br>
&gt;&gt; &gt; =C2=A0=C2=A0=C2=A0 cmd.scan_begin_src =3D TRIG_TIMER;<br>
&gt;&gt; &gt; =C2=A0=C2=A0=C2=A0 cmd.scan_begin_arg =3D 1e9 / INPUT_FREQ;<b=
r>
&gt;&gt; &gt; =C2=A0=C2=A0=C2=A0 cmd.convert_src =3D TRIG_NOW;<br>
&gt;&gt; &gt; =C2=A0=C2=A0=C2=A0 cmd.convert_arg =3D 0;<br>
&gt;&gt; &gt; =C2=A0=C2=A0=C2=A0 cmd.chan_descs =3D chanlist;<br>
&gt;&gt; &gt; =C2=A0=C2=A0=C2=A0 cmd.nb_chan =3D NICHAN;<br>
&gt;&gt; &gt; =C2=A0=C2=A0=C2=A0 cmd.scan_end_src =3D TRIG_COUNT;<br>
&gt;&gt; &gt; =C2=A0=C2=A0=C2=A0 cmd.scan_end_arg=C2=A0=C2=A0=C2=A0 =3D NIC=
HAN;<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; =C2=A0=C2=A0=C2=A0 cmd.stop_src =3D TRIG_COUNT;<br>
&gt;&gt; &gt; =C2=A0=C2=A0=C2=A0 cmd.stop_arg =3D SAMPLE_HISTORY;<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; with<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; INPUT_FREQ =3D 1000 (1kHz)<br>
&gt;&gt; &gt; NICHAN =3D 1=C2=A0=C2=A0 (I have also tried 4 and 8 with no d=
ifference in results)<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; and call the a4l_snd_command() function, which returns withou=
t errors.<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; I dump the contents of the buffer and it is still filled with=
 zeroes.<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; - I declare<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; unsigned long front =3D 0;<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; and call<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; ret =3D a4l_mark_bufrw(&amp;dev_input, 0, front, &amp;front);=
<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; at this point the buffer gets filled with 0x8000:<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; (gdb) print *(unsigned short *)map@domain.hid $1 =3D {0 &lt;repeats =
100 times&gt;}<br>
&gt;&gt; &gt; (gdb) n=C2=A0=C2=A0=C2=A0=C2=A0 &lt;------------------ calls =
a4l_mark_bufrw()<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; 186=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 i=
f (front =3D=3D 0) {<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; (gdb) print /x*(unsigned short *)map@domain.hid<br>
&gt;&gt; &gt; $2 =3D {0x8000 &lt;repeats 100 times&gt;}<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; Now I find it funny that the value read is always the same. C=
ould it be<br>
&gt;&gt; &gt; that<br>
&gt;&gt; &gt; everything is working fine and it is the board itself that is=
<br>
&gt;&gt; &gt; transferring<br>
&gt;&gt; &gt; that value? Could it be an indicator for an error condition?<=
br>
&gt;&gt;<br>
&gt;&gt; I don&#39;t think it is an error indicator; errors are reported in=
<br>
&gt;&gt; dedicated status registers.<br>
&gt;&gt;<br>
&gt;<br>
&gt; Yep, you&#39;re right on that one...<br>
&gt;<br>
&gt;&gt;<br>
&gt;&gt; If I understand correctly, most of the times you acquire 0x8000 an=
d a<br>
&gt;&gt; few times other values. That could mean that 0x8000 values are rea=
lly<br>
&gt;&gt; produced by the ADC converter. By the way, 0x8000 is not a meaning=
less<br>
&gt;&gt; value (0x0000 - 0xFFFF median). I don&#39;t know which range was s=
elected<br>
&gt;&gt; (-5V / 5V by default?) but it could mean that the card is acquirin=
g a<br>
&gt;&gt; continuous 0V signal.<br>
&gt;<br>
&gt;<br>
&gt;&gt;<br>
&gt;&gt; Which channel are you using?<br>
&gt;&gt; Could you test each channel separately and all of them at once?<br=
>
&gt;&gt; Could try another range? 0V / 5V could be a great candidate: with =
this<br>
&gt;&gt; one the acquired values could be 0x0000 instead of 0x8000.<br>
&gt;&gt;<br>
&gt;<br>
&gt; That makes sense, but with insn_read I get the right waveshape, with t=
he<br>
&gt; same setup. I am reading a 3Hz, 3V input signal. Unfortunately, this b=
oard<br>
&gt; reports only one possible range. The output of cmd_read -v reports:<br=
>
&gt;<br>
&gt; cmd_read: device analogy0 opened (fd=3D0)<br>
&gt; cmd_read: basic descriptor retrieved<br>
&gt; =C2=A0=C2=A0=C2=A0 =C2=A0subdevices count =3D 14<br>
&gt; =C2=A0=C2=A0=C2=A0 =C2=A0read subdevice index =3D 0<br>
&gt; =C2=A0=C2=A0=C2=A0 =C2=A0write subdevice index =3D 0<br>
&gt; cmd_read: complex descriptor retrieved<br>
&gt; cmd_read: channel 0<br>
&gt; =C2=A0=C2=A0=C2=A0 =C2=A0ranges count =3D 1<br>
&gt; =C2=A0=C2=A0=C2=A0 =C2=A0bit width =3D 16 (bits)<br>
&gt;<br>
&gt; Now here goes a crazy thing. I modified<br>
&gt; ksrc/drivers/analogy/national_instruments/mio_common.c:ni_ai_cmd() so =
that<br>
&gt; every time a command is issued the buffer is filled with 0x0f. That is=
, I<br>
&gt; added the following line:<br>
&gt;<br>
&gt; =C2=A0=C2=A0=C2=A0 memset(subd-&gt;buf-&gt;buf, 0x0f, subd-&gt;buf-&gt=
;size);<br>
&gt;<br>
&gt; Now I repeat the same sequence as in my previous mail with gdb:<br>
&gt;<br>
&gt; - Map the buffer, check address and content (buffer has some leftovers=
 from<br>
&gt; previous runs)<br>
&gt;<br>
&gt; ret =3D a4l_mmap(&amp;dev_input, 0, buf_size, &amp;map);<br>
&gt;<br>
&gt; (gdb) print map<br>
&gt; $1 =3D (void *) 0x7ffff7fc8000<br>
&gt; (gdb) print /x*(unsigned short *)map@domain.hid<br>
&gt; $2 =3D {0x600, 0x5e04, 0x0 &lt;repeats 98 times&gt;}<br>
&gt;<br>
&gt; - Issue the command and recheck contents. Now the buffer is filled wit=
h<br>
&gt; 0x0f0f<br>
&gt;<br>
&gt; (gdb) n<br>
&gt; 173=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 setup_input_card(&amp;dev_inp=
ut);<br>
&gt;<br>
&gt; (gdb) n<br>
&gt; Channel 0 has 16 bits and 1 different ranges<br>
&gt; 175=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 unsigned long front =3D 0;<br=
>
&gt;<br>
&gt; (gdb) print /x*(unsigned short *)map@domain.hid<br>
&gt; $3 =3D {0xf0f &lt;repeats 100 times&gt;}<br>
&gt;<br>
&gt; - Call a4l_mark_bufrw() and recheck contents. 70 samples have changed<=
br>
&gt; values, 30 remain the same. In those samples that changed value, only =
one<br>
&gt; bit changed!!<br>
&gt;<br>
&gt; (gdb) n<br>
&gt; 177=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 for(int scan =3D 0; scan &lt;=
 SAMPLE_HISTORY; scan++)<br>
&gt;<br>
&gt; (gdb) n<br>
&gt; 180=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 ret =3D a4=
l_mark_bufrw(&amp;dev_input, 0, front, &amp;front);<br>
&gt;<br>
&gt; (gdb) n<br>
&gt; 186=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 if (front =
=3D=3D 0) {<br>
&gt;<br>
&gt; (gdb) print /x*(unsigned short *)map@domain.hid<br>
&gt; $4 =3D {0x8f0f &lt;repeats 70 times&gt;, 0xf0f &lt;repeats 30 times&gt=
;}<br>
&gt;<br>
&gt; So there is either an &#39;or&#39; operation or an addition operation =
with 0x8000<br>
&gt; that is changing those values. As you said, 0x8000 is a very represent=
ative<br>
&gt; value. It represents zero on a 16 DAQ like mine, and it is also a valu=
e used<br>
&gt; as a mask in various places:<br>
&gt;<br>
&gt; ./ksrc/drivers/analogy/national_instruments/ni_stc.h:#define<br>
&gt; _bit15=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 0x8000<br>
&gt; ./ksrc/drivers/analogy/national_instruments/ni_stc.h:#define<br>
&gt; Calibration_Channel_6143_RelayOn=C2=A0=C2=A0 0x8000 (which happens to =
be my DAQ...)<br>
&gt;<br>
&gt; Running cmd_read only yields the 0x8f0f value now, by the way.<br>
&gt;<br>
&gt; I now it&#39;s hard to imagine what is happening without having the bo=
ard<br>
&gt; yourself, so I really appreciate your help.<br>
<br>
</div></div>I may have an idea thanks to your additional test. I cant&#39; =
figure out<br>
how a DMA controller could perform a or / add operation on memory with<br>
one single write shot; so, this operation must be done by the CPU.<br>
<br>
The only way for the CPU to interfere is through a munge operaiton,<br>
let&#39;s have a look at ni_ai_munge16:<br>
<br>
static void ni_ai_munge16(a4l_subd_t *subd, void *buf, unsigned long size)<=
br>
{<br>
 =C2=A0 =C2=A0 =C2=A0 =C2=A0a4l_dev_t *dev =3D subd-&gt;dev;<br>
 =C2=A0 =C2=A0 =C2=A0 =C2=A0a4l_cmd_t *cmd =3D a4l_get_cmd(subd);<br>
 =C2=A0 =C2=A0 =C2=A0 =C2=A0int chan_idx =3D a4l_get_chan(subd);<br>
 =C2=A0 =C2=A0 =C2=A0 =C2=A0unsigned int i;<br>
 =C2=A0 =C2=A0 =C2=A0 =C2=A0sampl_t *array =3D buf;<br>
<br>
 =C2=A0 =C2=A0 =C2=A0 =C2=A0for (i =3D 0; i &lt; size / sizeof(sampl_t); i+=
+) {<br>
#if (defined(CONFIG_XENO_DRIVERS_ANALOGY_NI_MITE) || \<br>
 =C2=A0 =C2=A0 defined(CONFIG_XENO_DRIVERS_ANALOGY_NI_MITE_MODULE))<br>
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0array[i] =3D le16_t=
o_cpu(array[i]);<br>
#endif /* CONFIG_XENO_DRIVERS_ANALOGY_NI_MITE */<br>
<br>
###### HERE<br>
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0array[i] +=3D devpr=
iv-&gt;ai_offset[chan_idx];<br>
######## HERE<br>
<br>
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0chan_idx++;<br>
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0chan_idx %=3D cmd-&=
gt;nb_chan;<br>
 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
}<br>
<br>
According to the code in ni_load_channelgain_list, I think ai_offset<br>
is set to 0x8000 in your case.<br>
<br>
Could you empty the function ni_ai_munge16 and check that the buffer<br>
is not modified anymore?<br>
<br>
If it is the case, let&#39;s go back to your first theory: the DMA controll=
er.<br>
<br></blockquote></div><br>Dear Alexis,<br><br>Yes, I commented out that li=
ne you mentioned and indeed the buffer is now filled with 0x0f0f instead of=
 0x8f0f. So yes, I still suspect it has to do with the DMA transfers.<br>
<br>Recalling, it seems that everything is working with the DMA except this=
 very point. I mean, I set my board to transfer data at the end of every sc=
an (with .flags =3D TRIG_WAKE_EOS) and I program a given frequency, say 1kH=
z. The dmesg reports an interrupt from the board with the right timing and =
my &quot;a4l_async_read()&quot; call gets unblocked apparently with the rig=
ht timing as well. At the end of buffer.c:a4l_buf_evt() I dump the value of=
 &quot;count&quot;, which reports the number of bytes transferred in the cu=
rrent event, and it reports the expected value (except in some cases, which=
 I will comment on a separate mail).<br>
<br>So I would like to check the following points:<br><br>- Check that the =
subdevice&#39;s buffer is properly configured when the device is set up and=
/or when the command is launched.<br><br>- Check that the DMA programming i=
s actually using that buffer.<br>
<br>- Check that the read operation is accessing the right buffer as well.<=
br><br>I can&#39;t think of many other things going wrong. While writing th=
is email I have thought of some further tests, so here is the result :)<br>
<br>I have changed the size of the default buffer using analogy_config. Fir=
st, I have specified:<br><br><div style=3D"margin-left: 40px;">sudo /usr/xe=
nomai/sbin/analogy_config -v analogy0 -S 4<br><br></div>Then I have run cmd=
_read, with the same results, but I have dumped some values at &quot;ni_ai_=
setup_MITE_dma()&quot; and at a4l_buf_evt():<br>
<br><div style=3D"margin-left: 40px;">[ 3115.793026] Analogy: analogy_ni_pc=
imio: ni_ai_setup_MITE_dma: beginning<br>[ 3115.793029] Analogy: analogy_ni=
_pcimio: ni_ai_setup_MITE_dma: buf-&gt;buf: ffffc90001893000; buf-&gt;end_c=
ount 800; buf-&gt;prd_count 0; buf-&gt;cns_count 0; buf-&gt;tmp_count 0<br>
[ 3115.793035] Analogy: analogy_ni_pcimio: ni_ai_cmd: exit<br>[ 3116.593187=
] Analogy: analogy_ni_pcimio: ni_mio_common: interrupt: a_status=3D90f0 ai_=
mite_status=3D00200000<br>[ 3116.593189] Analogy: analogy_ni_pcimio: ni_mio=
_common: SC_TC interrupt<br>
[ 3116.593191] Analogy: Signalling event. Available data to user: 800. Two =
first bytes in buffer: 15d 15d. Buffer pointer: ffffc90001893000<br><br></d=
iv>Now I changed the size of the buffer to 8, which aparently resulted in a=
 buffer reallocation:<br>
<br><div style=3D"margin-left: 40px;">[ 3119.523172] Analogy: analogy_ni_pc=
imio: ni_ai_setup_MITE_dma: beginning<br>[ 3119.523175] Analogy: analogy_ni=
_pcimio: ni_ai_setup_MITE_dma: buf-&gt;buf: ffffc9000189b000; buf-&gt;end_c=
ount 800; buf-&gt;prd_count 0; buf-&gt;cns_count 0; buf-&gt;tmp_count 0<br>
[ 3119.523181] Analogy: analogy_ni_pcimio: ni_ai_cmd: exit<br>[ 3120.323332=
] Analogy: analogy_ni_pcimio: ni_mio_common: interrupt: a_status=3D90f0 ai_=
mite_status=3D00200000<br>[ 3120.323335] Analogy: analogy_ni_pcimio: ni_mio=
_common: SC_TC interrupt<br>
[ 3120.323336] Analogy: Signalling event. Available data to user: 800. Two =
first bytes in buffer: 15d 15d. Buffer pointer: ffffc9000189b000<br><br></d=
iv>I don&#39;t know if this is really useful, but this is proving that at l=
east &quot;ni_ai_setup_MITE_dma()&quot; and &quot;a4l_buf_evt()&quot; are c=
onsistent in their notion of buffer.<br>
<br>Best regards,<br>Fernando<br>

--bcaec5215d7bbf128d04aef36c60--

