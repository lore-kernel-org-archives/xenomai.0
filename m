MIME-Version: 1.0
In-Reply-To: <CAMwkeZxybKS+-B2C_yaYX3_XSYnAKcj8xfX_YOgQ6Kt=mNTzJQ@mail.gmail.com>
References: <CAMwkeZy-9Qw0LALq8rrJQKET_Bu7UHgu8YYoFw1z6jdS687fBg@domain.hid>
	<CAGc_wL172OGHZ-8SG8e77Fp5qwHqKvTY610aQsr3WA_bp+3HRg@domain.hid>
	<CAMwkeZyvyhHPZTWz1LiaOhWA9TdrQaXMo833Ej5JRwJR3Da2xw@domain.hid>
	<CAMwkeZxinGD8_yEYmo+ySHx9dzU6hEM4BFH4jejnTMd87f0M9Q@mail.gmail.com>
	<CAMesUR4+G-Bx9tDUPajp4EcKP70zLvQuLyjLeyNpfyrmCpwBBw@domain.hid>
	<CAMwkeZyQwtJbcMjOiSnmzoRDud+4=6Nt2NOcEdFG_+1QVSHoSQ@mail.gmail.com>
	<CAMwkeZzajkK7gRYH5cnAW1-5HvgxQyUogDZKpms1FUyLtwxpdg@domain.hid>
	<CAMesUR67RpFHRiNcd-yfR9WF2FRe1U3yBdXWP2dU30aQovCHKQ@mail.gmail.com>
	<CAMwkeZxybKS+-B2C_yaYX3_XSYnAKcj8xfX_YOgQ6Kt=mNTzJQ@mail.gmail.com>
Date: Thu, 6 Oct 2011 15:49:23 -0300
Message-ID: <CAMwkeZzrfuB1Uf7f1eqG8zEvgeYMXrRspzUANeOaJR2qQUmhOQ@mail.gmail.com>
From: =?UTF-8?Q?Fernando_Herrero_Carr=C3=B3n?= <elferdo@domain.hid>
Content-Type: multipart/alternative; boundary=bcaec5215e5d86f2da04aea5c8dd
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

--bcaec5215e5d86f2da04aea5c8dd
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

El 5 de octubre de 2011 20:06, Fernando Herrero Carr=C3=B3n
<elferdo@domain.hid>escribi=C3=B3:

> El 5 de octubre de 2011 18:16, Alexis Berlemont <
> alexis.berlemont@domain.hid> escribi=C3=B3:
>
>> I think the problem might be located at two different places:
>> 1) Either the DMA controller is badly configured and it copies the
>> properly acquired values to wrong places.
>> 2) Or the DAQ-STC module is badly configured; so, the  DMA controller
>> copies the wrong values to right places.
>>
>> Concerning the alternative 1, I think it is not the most probable one.
>> Why? Because, the DMA controller (the MITE) is configured the same way
>> whatever the NI acquisition board holds it (or nearly).
>> To check this idea: let's make a little test with cmd_read.
>>
>> If cmd_read is launched with the option -m (map), we get direct
>> access, in user space, to the memory area the DMA controller is
>> supposed to shot to.
>>
>> So, just after a4l_mmap (before the DMA controller shots anything):
>> 367:            /* Map the analog input subdevice buffer */
>> 368:            ret =3D a4l_mmap(&dsc, cmd.idx_subd, buf_size, &map);
>> you can have a look at the values hold by the buffer:
>> - If the values are already 0x8000, we might conclude that the DMA
>> controller does not send anything there.
>> - If the values are not 0x8000, then we are sure that the DMA
>> controller does behave as expected. Consequently we can skip
>> alternative 1) and focus on the second one.
>>
>> If the DAQ is not properly configured; things are getting a little bit
>> simpler (if we have the documentation /. developer manual of your
>> acquisition card). We just have to find which stuff was not properly
>> configured.  A simple solution could be the monitoring of the status
>> registers. In such a case, I can send you a patch which will dump the
>> content of these registers.
>>
>> But before going that way, could you make the test with cmd_read + mmap?
>>
>> Regards,
>>
>> Alexis.
>>
>
> Ok, I'll check those tomorrow. From what I recall, I checked cmd_read jus=
t
> passing the '-m' option and resulted in the same behaviour, but I'll rech=
eck
> tomorrow.
>
> What I find somewhat surprising is that I got it working with comedi, so =
I
> guess that the register programming should also be working with analogy. =
The
> only difference I have managed to find so far between the analogy and the
> comedi drivers, besides generic buffer management, is that comedi appears=
 to
> handle DMA through the "generic device" interface (as in
> http://www.mjmwired.net/kernel/Documentation/DMA-API.txt) and analogy
> handles DMA through the PCI interface (as in
> http://m8-android-kernel.googlecode.com/svn/trunk/Documentation/DMA-mappi=
ng.txt).
> But this is merely speculation.
>
> I'll look tomorrow at your two options in more detail.
>
> Thanks for your help!
> Fernando
>

Dear Alexis,

I just repeated the tests with mmap.

Running the provided example of "cmd_read" with either "-m" or "-m -r" only
dumps the 0x8000 value. _Sometimes_, very rarely, I can get to see differen=
t
values not far from that one, but if I get to plot it it just looks like
noise. I don't know what is causing those values and I cannot reproduce the
conditions for them.

Now I used gdb to step through the process (with my own code) and here is
the sequence:

-  I run up to the line where the "mmapping" happens. I check that map =3D=
=3D
NULL and after I run the "mmap()" it gets a different value and ret =3D=3D =
0,
ok.

- I do a
print *(unsigned short *)map@domain.hid

  to dump the contents of the buffer and it is all filled with zeroes at
this point.

- I setup my command structure like this:

    cmd.idx_subd =3D 0;
    cmd.start_src =3D TRIG_NOW;
    cmd.start_arg =3D 0;
    cmd.flags =3D TRIG_WAKE_EOS;
    cmd.scan_begin_src =3D TRIG_TIMER;
    cmd.scan_begin_arg =3D 1e9 / INPUT_FREQ;
    cmd.convert_src =3D TRIG_NOW;
    cmd.convert_arg =3D 0;
    cmd.chan_descs =3D chanlist;
    cmd.nb_chan =3D NICHAN;
    cmd.scan_end_src =3D TRIG_COUNT;
    cmd.scan_end_arg    =3D NICHAN;

    cmd.stop_src =3D TRIG_COUNT;
    cmd.stop_arg =3D SAMPLE_HISTORY;

with

INPUT_FREQ =3D 1000 (1kHz)
NICHAN =3D 1   (I have also tried 4 and 8 with no difference in results)

and call the a4l_snd_command() function, which returns without errors.

I dump the contents of the buffer and it is still filled with zeroes.

- I declare

unsigned long front =3D 0;

and call

ret =3D a4l_mark_bufrw(&dev_input, 0, front, &front);

at this point the buffer gets filled with 0x8000:


(gdb) print *(unsigned short *)map@domain.hid $1 =3D {0 <repeats 100 times>}
(gdb) n     <------------------ calls a4l_mark_bufrw()

186            if (front =3D=3D 0) {

(gdb) print /x*(unsigned short *)map@domain.hid
$2 =3D {0x8000 <repeats 100 times>}

Now I find it funny that the value read is always the same. Could it be tha=
t
everything is working fine and it is the board itself that is transferring
that value? Could it be an indicator for an error condition?

Best regards,
Fernando

--bcaec5215e5d86f2da04aea5c8dd
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<br><br><div class=3D"gmail_quote">El 5 de octubre de 2011 20:06, Fernando =
Herrero Carr=C3=B3n <span dir=3D"ltr">&lt;<a href=3D"mailto:elferdo@domain.hid=
om">elferdo@domain.hid</a>&gt;</span> escribi=C3=B3:<br><blockquote class=3D=
"gmail_quote" style=3D"margin: 0pt 0pt 0pt 0.8ex; border-left: 1px solid rg=
b(204, 204, 204); padding-left: 1ex;">
<div class=3D"gmail_quote">El 5 de octubre de 2011 18:16, Alexis Berlemont =
<span dir=3D"ltr">&lt;<a href=3D"mailto:alexis.berlemont@domain.hid" target=
=3D"_blank">alexis.berlemont@domain.hid</a>&gt;</span> escribi=C3=B3:<div><d=
iv></div><div class=3D"h5">
<div>
</div><blockquote class=3D"gmail_quote" style=3D"margin: 0pt 0pt 0pt 0.8ex;=
 border-left: 1px solid rgb(204, 204, 204); padding-left: 1ex;">I think the=
 problem might be located at two different places:<br>
1) Either the DMA controller is badly configured and it copies the<br>
properly acquired values to wrong places.<br>
2) Or the DAQ-STC module is badly configured; so, the =C2=A0DMA controller<=
br>
copies the wrong values to right places.<br>
<br>
Concerning the alternative 1, I think it is not the most probable one.<br>
Why? Because, the DMA controller (the MITE) is configured the same way<br>
whatever the NI acquisition board holds it (or nearly).<br>
To check this idea: let&#39;s make a little test with cmd_read.<br>
<br>
If cmd_read is launched with the option -m (map), we get direct<br>
access, in user space, to the memory area the DMA controller is<br>
supposed to shot to.<br>
<br>
So, just after a4l_mmap (before the DMA controller shots anything):<br>
367: =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* Map the analog input subde=
vice buffer */<br>
368: =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D a4l_mmap(&amp;dsc, cm=
d.idx_subd, buf_size, &amp;map);<br>
you can have a look at the values hold by the buffer:<br>
- If the values are already 0x8000, we might conclude that the DMA<br>
controller does not send anything there.<br>
- If the values are not 0x8000, then we are sure that the DMA<br>
controller does behave as expected. Consequently we can skip<br>
alternative 1) and focus on the second one.<br>
<br>
If the DAQ is not properly configured; things are getting a little bit<br>
simpler (if we have the documentation /. developer manual of your<br>
acquisition card). We just have to find which stuff was not properly<br>
configured. =C2=A0A simple solution could be the monitoring of the status<b=
r>
registers. In such a case, I can send you a patch which will dump the<br>
content of these registers.<br>
<br>
But before going that way, could you make the test with cmd_read + mmap?<br=
>
<br>
Regards,<br>
<font color=3D"#888888"><br>
Alexis.<br>
</font></blockquote></div></div></div><br>Ok, I&#39;ll check those tomorrow=
. From what I recall, I checked cmd_read just passing the &#39;-m&#39; opti=
on and resulted in the same behaviour, but I&#39;ll recheck tomorrow.<br>
<br>What I find somewhat surprising is that I got it working with comedi, s=
o I guess that the register programming should also be working with analogy=
. The only difference I have managed to find so far between the analogy and=
 the comedi drivers, besides generic buffer management, is that comedi appe=
ars to handle DMA through the &quot;generic device&quot; interface (as in <=
a href=3D"http://www.mjmwired.net/kernel/Documentation/DMA-API.txt" target=
=3D"_blank">http://www.mjmwired.net/kernel/Documentation/DMA-API.txt</a>) a=
nd analogy handles DMA through the PCI interface (as in <a href=3D"http://m=
8-android-kernel.googlecode.com/svn/trunk/Documentation/DMA-mapping.txt" ta=
rget=3D"_blank">http://m8-android-kernel.googlecode.com/svn/trunk/Documenta=
tion/DMA-mapping.txt</a>). But this is merely speculation.<br>

<br>I&#39;ll look tomorrow at your two options in more detail.<br><br>Thank=
s for your help!<br><font color=3D"#888888">Fernando<br></font></blockquote=
><div><br>Dear Alexis,<br><br>I just repeated the tests with mmap.<br><br>
Running the provided example of &quot;cmd_read&quot; with either &quot;-m&q=
uot; or &quot;-m -r&quot; only dumps the 0x8000 value. _Sometimes_, very ra=
rely, I can get to see different values not far from that one, but if I get=
 to plot it it just looks like noise. I don&#39;t know what is causing thos=
e values and I cannot reproduce the conditions for them.<br>
<br>Now I used gdb to step through the process (with my own code) and here =
is the sequence:<br><br>-=C2=A0 I run up to the line where the &quot;mmappi=
ng&quot; happens. I check that map =3D=3D NULL and after I run the &quot;mm=
ap()&quot; it gets a different value and ret =3D=3D 0, ok.<br>
<br>- I do a<br><div style=3D"margin-left: 40px;">print *(unsigned short *)=
map@domain.hid<br><br></div>=C2=A0 to dump the contents of the buffer and it is al=
l filled with zeroes at this point.<br><br>- I setup my command structure l=
ike this:<br>
<br><div style=3D"margin-left: 40px;">=C2=A0=C2=A0=C2=A0 cmd.idx_subd =3D 0=
;<br>=C2=A0=C2=A0=C2=A0 cmd.start_src =3D TRIG_NOW;<br>=C2=A0=C2=A0=C2=A0 c=
md.start_arg =3D 0;<br>=C2=A0=C2=A0=C2=A0 cmd.flags =3D TRIG_WAKE_EOS;<br>=
=C2=A0=C2=A0=C2=A0 cmd.scan_begin_src =3D TRIG_TIMER;<br>=C2=A0=C2=A0=C2=A0=
 cmd.scan_begin_arg =3D 1e9 / INPUT_FREQ;<br>
=C2=A0=C2=A0=C2=A0 cmd.convert_src =3D TRIG_NOW;<br>=C2=A0=C2=A0=C2=A0 cmd.=
convert_arg =3D 0;<br>=C2=A0=C2=A0=C2=A0 cmd.chan_descs =3D chanlist;<br>=
=C2=A0=C2=A0=C2=A0 cmd.nb_chan =3D NICHAN;<br>=C2=A0=C2=A0=C2=A0 cmd.scan_e=
nd_src =3D TRIG_COUNT;<br>=C2=A0=C2=A0=C2=A0 cmd.scan_end_arg=C2=A0=C2=A0=
=C2=A0 =3D NICHAN;<br><br>=C2=A0=C2=A0=C2=A0 cmd.stop_src =3D TRIG_COUNT;<b=
r>
=C2=A0=C2=A0=C2=A0 cmd.stop_arg =3D SAMPLE_HISTORY;<br><br></div>with<br><d=
iv style=3D"margin-left: 40px;"><br>INPUT_FREQ =3D 1000 (1kHz)<br>NICHAN =
=3D 1=C2=A0=C2=A0 (I have also tried 4 and 8 with no difference in results)=
<br><br></div>and call the a4l_snd_command() function, which returns withou=
t errors.<br>
<br>I dump the contents of the buffer and it is still filled with zeroes.<b=
r><br>- I declare<br><br><div style=3D"margin-left: 40px;">unsigned long fr=
ont =3D 0;<br><br></div>and call<br><br><div style=3D"margin-left: 40px;">r=
et =3D a4l_mark_bufrw(&amp;dev_input, 0, front, &amp;front);<br>
<br></div></div></div>at this point the buffer gets filled with 0x8000:<br>=
<br><div style=3D"margin-left: 40px;"><br>(gdb) print *(unsigned short *)ma=
p@domain.hid $1 =3D {0 &lt;repeats 100 times&gt;}<br>(gdb) n=C2=A0=C2=A0=C2=A0=C2=
=A0 &lt;------------------ calls a4l_mark_bufrw()<br>
<br>186=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 if (front =
=3D=3D 0) {<br><br>(gdb) print /x*(unsigned short *)map@domain.hid<br>$2 =3D {0x80=
00 &lt;repeats 100 times&gt;}<br><br></div>Now I find it funny that the val=
ue read is always the same. Could it be that everything is working fine and=
 it is the board itself that is transferring that value? Could it be an ind=
icator for an error condition?<br>
<br>Best regards,<br>Fernando<br><div style=3D"margin-left: 40px;"><br></di=
v>

--bcaec5215e5d86f2da04aea5c8dd--

