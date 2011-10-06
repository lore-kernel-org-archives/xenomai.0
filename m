MIME-Version: 1.0
In-Reply-To: <CAMesUR5AvmUDW8wq4e9EtOgnpRtMD_qe8rQe7acgFT6KzdeYAg@domain.hid>
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
Date: Thu, 6 Oct 2011 19:18:45 -0300
Message-ID: <CAMwkeZxAvBeY=0c49N+QtUYCKCTiGo4yc9TAEQPLJAJmBXPn+A@mail.gmail.com>
From: =?UTF-8?Q?Fernando_Herrero_Carr=C3=B3n?= <elferdo@domain.hid>
Content-Type: multipart/alternative; boundary=bcaec53af23a3a8de404aea8b5dd
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

--bcaec53af23a3a8de404aea8b5dd
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

El 6 de octubre de 2011 18:31, Alexis Berlemont
<alexis.berlemont@domain.hid>escribi=C3=B3:

> Hi,
>
> 2011/10/6 Fernando Herrero Carr=C3=B3n <elferdo@domain.hid>:
> >
> >
> > El 5 de octubre de 2011 20:06, Fernando Herrero Carr=C3=B3n <
> elferdo@domain.hid>
> > escribi=C3=B3:
> >>
> >> El 5 de octubre de 2011 18:16, Alexis Berlemont
> >> <alexis.berlemont@domain.hid> escribi=C3=B3:
> >>>
> >>> I think the problem might be located at two different places:
> >>> 1) Either the DMA controller is badly configured and it copies the
> >>> properly acquired values to wrong places.
> >>> 2) Or the DAQ-STC module is badly configured; so, the  DMA controller
> >>> copies the wrong values to right places.
> >>>
> >>> Concerning the alternative 1, I think it is not the most probable one=
.
> >>> Why? Because, the DMA controller (the MITE) is configured the same wa=
y
> >>> whatever the NI acquisition board holds it (or nearly).
> >>> To check this idea: let's make a little test with cmd_read.
> >>>
> >>> If cmd_read is launched with the option -m (map), we get direct
> >>> access, in user space, to the memory area the DMA controller is
> >>> supposed to shot to.
> >>>
> >>> So, just after a4l_mmap (before the DMA controller shots anything):
> >>> 367:            /* Map the analog input subdevice buffer */
> >>> 368:            ret =3D a4l_mmap(&dsc, cmd.idx_subd, buf_size, &map);
> >>> you can have a look at the values hold by the buffer:
> >>> - If the values are already 0x8000, we might conclude that the DMA
> >>> controller does not send anything there.
> >>> - If the values are not 0x8000, then we are sure that the DMA
> >>> controller does behave as expected. Consequently we can skip
> >>> alternative 1) and focus on the second one.
> >>>
> >>> If the DAQ is not properly configured; things are getting a little bi=
t
> >>> simpler (if we have the documentation /. developer manual of your
> >>> acquisition card). We just have to find which stuff was not properly
> >>> configured.  A simple solution could be the monitoring of the status
> >>> registers. In such a case, I can send you a patch which will dump the
> >>> content of these registers.
> >>>
> >>> But before going that way, could you make the test with cmd_read +
> mmap?
> >>>
> >>> Regards,
> >>>
> >>> Alexis.
> >>
> >> Ok, I'll check those tomorrow. From what I recall, I checked cmd_read
> just
> >> passing the '-m' option and resulted in the same behaviour, but I'll
> recheck
> >> tomorrow.
> >>
> >> What I find somewhat surprising is that I got it working with comedi, =
so
> I
> >> guess that the register programming should also be working with analog=
y.
> The
> >> only difference I have managed to find so far between the analogy and
> the
> >> comedi drivers, besides generic buffer management, is that comedi
> appears to
> >> handle DMA through the "generic device" interface (as in
> >> http://www.mjmwired.net/kernel/Documentation/DMA-API.txt) and analogy
> >> handles DMA through the PCI interface (as in
> >>
> http://m8-android-kernel.googlecode.com/svn/trunk/Documentation/DMA-mappi=
ng.txt
> ).
> >> But this is merely speculation.
> >>
> >> I'll look tomorrow at your two options in more detail.
> >>
> >> Thanks for your help!
> >> Fernando
> >
> > Dear Alexis,
> >
> > I just repeated the tests with mmap.
> >
> > Running the provided example of "cmd_read" with either "-m" or "-m -r"
> only
> > dumps the 0x8000 value. _Sometimes_, very rarely, I can get to see
> different
> > values not far from that one, but if I get to plot it it just looks lik=
e
> > noise. I don't know what is causing those values and I cannot reproduce
> the
> > conditions for them.
> >
> > Now I used gdb to step through the process (with my own code) and here =
is
> > the sequence:
> >
> > -  I run up to the line where the "mmapping" happens. I check that map =
=3D=3D
> > NULL and after I run the "mmap()" it gets a different value and ret =3D=
=3D 0,
> > ok.
> >
> > - I do a
> > print *(unsigned short *)map@domain.hid
> >
> >   to dump the contents of the buffer and it is all filled with zeroes a=
t
> > this point.
> >
> > - I setup my command structure like this:
> >
> >     cmd.idx_subd =3D 0;
> >     cmd.start_src =3D TRIG_NOW;
> >     cmd.start_arg =3D 0;
> >     cmd.flags =3D TRIG_WAKE_EOS;
> >     cmd.scan_begin_src =3D TRIG_TIMER;
> >     cmd.scan_begin_arg =3D 1e9 / INPUT_FREQ;
> >     cmd.convert_src =3D TRIG_NOW;
> >     cmd.convert_arg =3D 0;
> >     cmd.chan_descs =3D chanlist;
> >     cmd.nb_chan =3D NICHAN;
> >     cmd.scan_end_src =3D TRIG_COUNT;
> >     cmd.scan_end_arg    =3D NICHAN;
> >
> >     cmd.stop_src =3D TRIG_COUNT;
> >     cmd.stop_arg =3D SAMPLE_HISTORY;
> >
> > with
> >
> > INPUT_FREQ =3D 1000 (1kHz)
> > NICHAN =3D 1   (I have also tried 4 and 8 with no difference in results=
)
> >
> > and call the a4l_snd_command() function, which returns without errors.
> >
> > I dump the contents of the buffer and it is still filled with zeroes.
> >
> > - I declare
> >
> > unsigned long front =3D 0;
> >
> > and call
> >
> > ret =3D a4l_mark_bufrw(&dev_input, 0, front, &front);
> >
> > at this point the buffer gets filled with 0x8000:
> >
> >
> > (gdb) print *(unsigned short *)map@domain.hid $1 =3D {0 <repeats 100 times>}
> > (gdb) n     <------------------ calls a4l_mark_bufrw()
> >
> > 186            if (front =3D=3D 0) {
> >
> > (gdb) print /x*(unsigned short *)map@domain.hid
> > $2 =3D {0x8000 <repeats 100 times>}
> >
> > Now I find it funny that the value read is always the same. Could it be
> that
> > everything is working fine and it is the board itself that is
> transferring
> > that value? Could it be an indicator for an error condition?
>
> I don't think it is an error indicator; errors are reported in
> dedicated status registers.
>
>
Yep, you're right on that one...


> If I understand correctly, most of the times you acquire 0x8000 and a
> few times other values. That could mean that 0x8000 values are really
> produced by the ADC converter. By the way, 0x8000 is not a meaningless
> value (0x0000 - 0xFFFF median). I don't know which range was selected
> (-5V / 5V by default?) but it could mean that the card is acquiring a
> continuous 0V signal.
>


> Which channel are you using?
> Could you test each channel separately and all of them at once?
> Could try another range? 0V / 5V could be a great candidate: with this
> one the acquired values could be 0x0000 instead of 0x8000.
>
>
That makes sense, but with insn_read I get the right waveshape, with the
same setup. I am reading a 3Hz, 3V input signal. Unfortunately, this board
reports only one possible range. The output of cmd_read -v reports:

cmd_read: device analogy0 opened (fd=3D0)
cmd_read: basic descriptor retrieved
     subdevices count =3D 14
     read subdevice index =3D 0
     write subdevice index =3D 0
cmd_read: complex descriptor retrieved
cmd_read: channel 0
     ranges count =3D 1
     bit width =3D 16 (bits)

Now here goes a crazy thing. I modified
ksrc/drivers/analogy/national_instruments/mio_common.c:ni_ai_cmd() so that
every time a command is issued the buffer is filled with 0x0f. That is, I
added the following line:

    memset(subd->buf->buf, 0x0f, subd->buf->size);

Now I repeat the same sequence as in my previous mail with gdb:

- Map the buffer, check address and content (buffer has some leftovers from
previous runs)

ret =3D a4l_mmap(&dev_input, 0, buf_size, &map);

(gdb) print map
$1 =3D (void *) 0x7ffff7fc8000
(gdb) print /x*(unsigned short *)map@domain.hid
$2 =3D {0x600, 0x5e04, 0x0 <repeats 98 times>}

- Issue the command and recheck contents. Now the buffer is filled with
0x0f0f

(gdb) n
173        setup_input_card(&dev_input);

(gdb) n
Channel 0 has 16 bits and 1 different ranges
175        unsigned long front =3D 0;

(gdb) print /x*(unsigned short *)map@domain.hid
$3 =3D {0xf0f <repeats 100 times>}

- Call a4l_mark_bufrw() and recheck contents. 70 samples have changed
values, 30 remain the same. In those samples that changed value, only one
bit changed!!

(gdb) n
177        for(int scan =3D 0; scan < SAMPLE_HISTORY; scan++)

(gdb) n
180            ret =3D a4l_mark_bufrw(&dev_input, 0, front, &front);

(gdb) n
186            if (front =3D=3D 0) {

(gdb) print /x*(unsigned short *)map@domain.hid
$4 =3D {0x8f0f <repeats 70 times>, 0xf0f <repeats 30 times>}

So there is either an 'or' operation or an addition operation with 0x8000
that is changing those values. As you said, 0x8000 is a very representative
value. It represents zero on a 16 DAQ like mine, and it is also a value use=
d
as a mask in various places:

./ksrc/drivers/analogy/national_instruments/ni_stc.h:#define
_bit15             0x8000
./ksrc/drivers/analogy/national_instruments/ni_stc.h:#define
Calibration_Channel_6143_RelayOn   0x8000 (which happens to be my DAQ...)

Running cmd_read only yields the 0x8f0f value now, by the way.

I now it's hard to imagine what is happening without having the board
yourself, so I really appreciate your help.

Thanks!
Fernando

--bcaec53af23a3a8de404aea8b5dd
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div class=3D"gmail_quote">El 6 de octubre de 2011 18:31, Alexis Berlemont =
<span dir=3D"ltr">&lt;<a href=3D"mailto:alexis.berlemont@domain.hid">alexis.=
berlemont@domain.hid</a>&gt;</span> escribi=C3=B3:<br><blockquote class=3D"g=
mail_quote" style=3D"margin: 0pt 0pt 0pt 0.8ex; border-left: 1px solid rgb(=
204, 204, 204); padding-left: 1ex;">
Hi,<br>
<br>
2011/10/6 Fernando Herrero Carr=C3=B3n &lt;<a href=3D"mailto:elferdo@domain.hid.=
com">elferdo@domain.hid</a>&gt;:<br>
<div><div></div><div class=3D"h5">&gt;<br>
&gt;<br>
&gt; El 5 de octubre de 2011 20:06, Fernando Herrero Carr=C3=B3n &lt;<a hre=
f=3D"mailto:elferdo@domain.hid">elferdo@domain.hid</a>&gt;<br>
&gt; escribi=C3=B3:<br>
&gt;&gt;<br>
&gt;&gt; El 5 de octubre de 2011 18:16, Alexis Berlemont<br>
&gt;&gt; &lt;<a href=3D"mailto:alexis.berlemont@domain.hid">alexis.berlemont=
@gmail.com</a>&gt; escribi=C3=B3:<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; I think the problem might be located at two different places:<=
br>
&gt;&gt;&gt; 1) Either the DMA controller is badly configured and it copies=
 the<br>
&gt;&gt;&gt; properly acquired values to wrong places.<br>
&gt;&gt;&gt; 2) Or the DAQ-STC module is badly configured; so, the =C2=A0DM=
A controller<br>
&gt;&gt;&gt; copies the wrong values to right places.<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; Concerning the alternative 1, I think it is not the most proba=
ble one.<br>
&gt;&gt;&gt; Why? Because, the DMA controller (the MITE) is configured the =
same way<br>
&gt;&gt;&gt; whatever the NI acquisition board holds it (or nearly).<br>
&gt;&gt;&gt; To check this idea: let&#39;s make a little test with cmd_read=
.<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; If cmd_read is launched with the option -m (map), we get direc=
t<br>
&gt;&gt;&gt; access, in user space, to the memory area the DMA controller i=
s<br>
&gt;&gt;&gt; supposed to shot to.<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; So, just after a4l_mmap (before the DMA controller shots anyth=
ing):<br>
&gt;&gt;&gt; 367: =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* Map the analo=
g input subdevice buffer */<br>
&gt;&gt;&gt; 368: =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D a4l_mmap=
(&amp;dsc, cmd.idx_subd, buf_size, &amp;map);<br>
&gt;&gt;&gt; you can have a look at the values hold by the buffer:<br>
&gt;&gt;&gt; - If the values are already 0x8000, we might conclude that the=
 DMA<br>
&gt;&gt;&gt; controller does not send anything there.<br>
&gt;&gt;&gt; - If the values are not 0x8000, then we are sure that the DMA<=
br>
&gt;&gt;&gt; controller does behave as expected. Consequently we can skip<b=
r>
&gt;&gt;&gt; alternative 1) and focus on the second one.<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; If the DAQ is not properly configured; things are getting a li=
ttle bit<br>
&gt;&gt;&gt; simpler (if we have the documentation /. developer manual of y=
our<br>
&gt;&gt;&gt; acquisition card). We just have to find which stuff was not pr=
operly<br>
&gt;&gt;&gt; configured. =C2=A0A simple solution could be the monitoring of=
 the status<br>
&gt;&gt;&gt; registers. In such a case, I can send you a patch which will d=
ump the<br>
&gt;&gt;&gt; content of these registers.<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; But before going that way, could you make the test with cmd_re=
ad + mmap?<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; Regards,<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; Alexis.<br>
&gt;&gt;<br>
&gt;&gt; Ok, I&#39;ll check those tomorrow. From what I recall, I checked c=
md_read just<br>
&gt;&gt; passing the &#39;-m&#39; option and resulted in the same behaviour=
, but I&#39;ll recheck<br>
&gt;&gt; tomorrow.<br>
&gt;&gt;<br>
&gt;&gt; What I find somewhat surprising is that I got it working with come=
di, so I<br>
&gt;&gt; guess that the register programming should also be working with an=
alogy. The<br>
&gt;&gt; only difference I have managed to find so far between the analogy =
and the<br>
&gt;&gt; comedi drivers, besides generic buffer management, is that comedi =
appears to<br>
&gt;&gt; handle DMA through the &quot;generic device&quot; interface (as in=
<br>
&gt;&gt; <a href=3D"http://www.mjmwired.net/kernel/Documentation/DMA-API.tx=
t" target=3D"_blank">http://www.mjmwired.net/kernel/Documentation/DMA-API.t=
xt</a>) and analogy<br>
&gt;&gt; handles DMA through the PCI interface (as in<br>
&gt;&gt; <a href=3D"http://m8-android-kernel.googlecode.com/svn/trunk/Docum=
entation/DMA-mapping.txt" target=3D"_blank">http://m8-android-kernel.google=
code.com/svn/trunk/Documentation/DMA-mapping.txt</a>).<br>
&gt;&gt; But this is merely speculation.<br>
&gt;&gt;<br>
&gt;&gt; I&#39;ll look tomorrow at your two options in more detail.<br>
&gt;&gt;<br>
&gt;&gt; Thanks for your help!<br>
&gt;&gt; Fernando<br>
&gt;<br>
&gt; Dear Alexis,<br>
&gt;<br>
&gt; I just repeated the tests with mmap.<br>
&gt;<br>
&gt; Running the provided example of &quot;cmd_read&quot; with either &quot=
;-m&quot; or &quot;-m -r&quot; only<br>
&gt; dumps the 0x8000 value. _Sometimes_, very rarely, I can get to see dif=
ferent<br>
&gt; values not far from that one, but if I get to plot it it just looks li=
ke<br>
&gt; noise. I don&#39;t know what is causing those values and I cannot repr=
oduce the<br>
&gt; conditions for them.<br>
&gt;<br>
&gt; Now I used gdb to step through the process (with my own code) and here=
 is<br>
&gt; the sequence:<br>
&gt;<br>
&gt; -=C2=A0 I run up to the line where the &quot;mmapping&quot; happens. I=
 check that map =3D=3D<br>
&gt; NULL and after I run the &quot;mmap()&quot; it gets a different value =
and ret =3D=3D 0,<br>
&gt; ok.<br>
&gt;<br>
&gt; - I do a<br>
&gt; print *(unsigned short *)map@domain.hid<br>
&gt;<br>
&gt; =C2=A0 to dump the contents of the buffer and it is all filled with ze=
roes at<br>
&gt; this point.<br>
&gt;<br>
&gt; - I setup my command structure like this:<br>
&gt;<br>
&gt; =C2=A0=C2=A0=C2=A0 cmd.idx_subd =3D 0;<br>
&gt; =C2=A0=C2=A0=C2=A0 cmd.start_src =3D TRIG_NOW;<br>
&gt; =C2=A0=C2=A0=C2=A0 cmd.start_arg =3D 0;<br>
&gt; =C2=A0=C2=A0=C2=A0 cmd.flags =3D TRIG_WAKE_EOS;<br>
&gt; =C2=A0=C2=A0=C2=A0 cmd.scan_begin_src =3D TRIG_TIMER;<br>
&gt; =C2=A0=C2=A0=C2=A0 cmd.scan_begin_arg =3D 1e9 / INPUT_FREQ;<br>
&gt; =C2=A0=C2=A0=C2=A0 cmd.convert_src =3D TRIG_NOW;<br>
&gt; =C2=A0=C2=A0=C2=A0 cmd.convert_arg =3D 0;<br>
&gt; =C2=A0=C2=A0=C2=A0 cmd.chan_descs =3D chanlist;<br>
&gt; =C2=A0=C2=A0=C2=A0 cmd.nb_chan =3D NICHAN;<br>
&gt; =C2=A0=C2=A0=C2=A0 cmd.scan_end_src =3D TRIG_COUNT;<br>
&gt; =C2=A0=C2=A0=C2=A0 cmd.scan_end_arg=C2=A0=C2=A0=C2=A0 =3D NICHAN;<br>
&gt;<br>
&gt; =C2=A0=C2=A0=C2=A0 cmd.stop_src =3D TRIG_COUNT;<br>
&gt; =C2=A0=C2=A0=C2=A0 cmd.stop_arg =3D SAMPLE_HISTORY;<br>
&gt;<br>
&gt; with<br>
&gt;<br>
&gt; INPUT_FREQ =3D 1000 (1kHz)<br>
&gt; NICHAN =3D 1=C2=A0=C2=A0 (I have also tried 4 and 8 with no difference=
 in results)<br>
&gt;<br>
&gt; and call the a4l_snd_command() function, which returns without errors.=
<br>
&gt;<br>
&gt; I dump the contents of the buffer and it is still filled with zeroes.<=
br>
&gt;<br>
&gt; - I declare<br>
&gt;<br>
&gt; unsigned long front =3D 0;<br>
&gt;<br>
&gt; and call<br>
&gt;<br>
&gt; ret =3D a4l_mark_bufrw(&amp;dev_input, 0, front, &amp;front);<br>
&gt;<br>
&gt; at this point the buffer gets filled with 0x8000:<br>
&gt;<br>
&gt;<br>
&gt; (gdb) print *(unsigned short *)map@domain.hid $1 =3D {0 &lt;repeats 100 times=
&gt;}<br>
&gt; (gdb) n=C2=A0=C2=A0=C2=A0=C2=A0 &lt;------------------ calls a4l_mark_=
bufrw()<br>
&gt;<br>
&gt; 186=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 if (front =
=3D=3D 0) {<br>
&gt;<br>
&gt; (gdb) print /x*(unsigned short *)map@domain.hid<br>
&gt; $2 =3D {0x8000 &lt;repeats 100 times&gt;}<br>
&gt;<br>
&gt; Now I find it funny that the value read is always the same. Could it b=
e that<br>
&gt; everything is working fine and it is the board itself that is transfer=
ring<br>
&gt; that value? Could it be an indicator for an error condition?<br>
<br>
</div></div>I don&#39;t think it is an error indicator; errors are reported=
 in<br>
dedicated status registers.<br>
<br></blockquote><div><br>Yep, you&#39;re right on that one...<br>=C2=A0</d=
iv><blockquote class=3D"gmail_quote" style=3D"margin: 0pt 0pt 0pt 0.8ex; bo=
rder-left: 1px solid rgb(204, 204, 204); padding-left: 1ex;">
If I understand correctly, most of the times you acquire 0x8000 and a<br>
few times other values. That could mean that 0x8000 values are really<br>
produced by the ADC converter. By the way, 0x8000 is not a meaningless<br>
value (0x0000 - 0xFFFF median). I don&#39;t know which range was selected<b=
r>
(-5V / 5V by default?) but it could mean that the card is acquiring a<br>
continuous 0V signal.<br></blockquote><div>=C2=A0</div><blockquote class=3D=
"gmail_quote" style=3D"margin: 0pt 0pt 0pt 0.8ex; border-left: 1px solid rg=
b(204, 204, 204); padding-left: 1ex;">
Which channel are you using?<br>
Could you test each channel separately and all of them at once?<br>
Could try another range? 0V / 5V could be a great candidate: with this<br>
one the acquired values could be 0x0000 instead of 0x8000.<br>
<br>
</blockquote><div><br>That makes sense, but with insn_read I get the right =
waveshape, with the same setup. I am reading a 3Hz, 3V input signal. Unfort=
unately, this board reports only one possible range. The output of cmd_read=
 -v reports:<br>
<br><div style=3D"margin-left: 40px;">cmd_read: device analogy0 opened (fd=
=3D0)<br>cmd_read: basic descriptor retrieved<br>=C2=A0=C2=A0=C2=A0 =C2=A0s=
ubdevices count =3D 14<br>=C2=A0=C2=A0=C2=A0 =C2=A0read subdevice index =3D=
 0<br>=C2=A0=C2=A0=C2=A0 =C2=A0write subdevice index =3D 0<br>cmd_read: com=
plex descriptor retrieved<br>
cmd_read: channel 0<br>=C2=A0=C2=A0=C2=A0 =C2=A0ranges count =3D 1<br>=C2=
=A0=C2=A0=C2=A0 =C2=A0bit width =3D 16 (bits)<br><br></div>Now here goes a =
crazy thing. I modified ksrc/drivers/analogy/national_instruments/mio_commo=
n.c:ni_ai_cmd() so that every time a command is issued the buffer is filled=
 with 0x0f. That is, I added the following line:<br>
<br><div style=3D"margin-left: 40px;">=C2=A0=C2=A0=C2=A0 memset(subd-&gt;bu=
f-&gt;buf, 0x0f, subd-&gt;buf-&gt;size);<br></div><br>Now I repeat the same=
 sequence as in my previous mail with gdb:<br><br>- Map the buffer, check a=
ddress and content (buffer has some leftovers from previous runs)<br>
<br><div style=3D"margin-left: 40px;">ret =3D a4l_mmap(&amp;dev_input, 0, b=
uf_size, &amp;map);<br><br>(gdb) print map<br>$1 =3D (void *) 0x7ffff7fc800=
0<br>(gdb) print /x*(unsigned short *)map@domain.hid<br>$2 =3D {0x600, 0x5e04, 0x0=
 &lt;repeats 98 times&gt;}<br>
<br></div>- Issue the command and recheck contents. Now the buffer is fille=
d with 0x0f0f<br><br><div style=3D"margin-left: 40px;">(gdb) n<br>173=C2=A0=
=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 setup_input_card(&amp;dev_input);<br><br>(g=
db) n<br>Channel 0 has 16 bits and 1 different ranges<br>
175=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 unsigned long front =3D 0;<br><br>=
(gdb) print /x*(unsigned short *)map@domain.hid<br>$3 =3D {0xf0f &lt;repeats 100 t=
imes&gt;}<br></div><br>- Call a4l_mark_bufrw() and recheck contents. 70 sam=
ples have changed values, 30 remain the same. In those samples that changed=
 value, only one bit changed!!<br>
<br><div style=3D"margin-left: 40px;">(gdb) n<br>177=C2=A0=C2=A0=C2=A0 =C2=
=A0=C2=A0=C2=A0 for(int scan =3D 0; scan &lt; SAMPLE_HISTORY; scan++)<br><b=
r>(gdb) n<br>180=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 re=
t =3D a4l_mark_bufrw(&amp;dev_input, 0, front, &amp;front);<br><br>(gdb) n<=
br>
186=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 if (front =3D=
=3D 0) {<br><br>(gdb) print /x*(unsigned short *)map@domain.hid<br>$4 =3D {0x8f0f =
&lt;repeats 70 times&gt;, 0xf0f &lt;repeats 30 times&gt;}<br></div><br></di=
v></div>So there is either an &#39;or&#39; operation or an addition operati=
on with 0x8000 that is changing those values. As you said, 0x8000 is a very=
 representative value. It represents zero on a 16 DAQ like mine, and it is =
also a value used as a mask in various places:<br>
<br>./ksrc/drivers/analogy/national_instruments/ni_stc.h:#define _bit15=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0x800=
0<br>./ksrc/drivers/analogy/national_instruments/ni_stc.h:#define Calibrati=
on_Channel_6143_RelayOn=C2=A0=C2=A0 0x8000 (which happens to be my DAQ...)<=
br>
<br>Running cmd_read only yields the 0x8f0f value now, by the way.<br><br>I=
 now it&#39;s hard to imagine what is happening without having the board yo=
urself, so I really appreciate your help.<br><br>Thanks!<br>Fernando<br>
<br>

--bcaec53af23a3a8de404aea8b5dd--

