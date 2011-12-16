MIME-Version: 1.0
In-Reply-To: <CAMwkeZw4X15HU7ABUhvLpXuu1Sbspen6FK7XvjHiQLXg0AcazQ@mail.gmail.com>
References: <4EE9FD4A.1090202@domain.hid>
	<CAMwkeZw4X15HU7ABUhvLpXuu1Sbspen6FK7XvjHiQLXg0AcazQ@mail.gmail.com>
Date: Fri, 16 Dec 2011 13:16:59 +0100
Message-ID: <CAMwkeZy+SwPoJzccvoDMC8Uwj0YpAQAthDAC1D1_h+8MHVexRw@domain.hid>
From: =?UTF-8?Q?Fernando_Herrero_Carr=C3=B3n?= <elferdo@domain.hid>
Content-Type: multipart/alternative; boundary=f46d04138f93e9b1ab04b4349334
Subject: Re: [Xenomai-help] Big differences in analogy interrupt handling
	time
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Anders Blomdell <anders.blomdell@domain.hid>
Cc: Xenomai-help@domain.hid

--f46d04138f93e9b1ab04b4349334
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

El 15 de diciembre de 2011 18:28, Fernando Herrero Carr=C3=B3n <elferdo@domain.hid=
il.com
> escribi=C3=B3:

> 2011/12/15 Anders Blomdell <anders.blomdell@domain.hid>
>
> Hi,
>>
>> I'm trying to tweak out good performance with Analogy and a NI-6221 card=
,
>> and after getting weird results with the attached program (long and very
>> varying interrupt latencies). The machine I'm running on is a 'Intel(R)
>> Core(TM)2 CPU 6420 @ 2.13GHz', no frequency scaling, no X, low load,  on=
ly
>> one CPU enabled to minimize influence from other Linux tasks. As can be
>> seen from the frozen traces (formatted and time shifted to be examined w=
ith
>> 'pr -mtT -w 200 A B'), the time spent in the interrupt handling varies
>> between 263 and 329 us and there is variation even in repeated code path=
s
>> [which are bogus in themselves, why busy-wait 10 us in an interrupt
>> routine?], so cache poisoning should not be the issue.
>>
>> Anybody that has any insights to share?
>>
>>
> Hi everyone there,
>
> In fact, I came accross this same issue some months ago, but haven't had
> time to write on the list up to now.
>
> Actually, there seems to be some old inherited code from the early comedi
> days. In the file ksrc/drivers/analogy/national_instruments/mio_common.c
> there is a function that handles transfers called "ni_handle_eos()". You
> can see:
>
> static void ni_handle_eos(a4l_subd_t *subd)
> {
>         a4l_dev_t *dev =3D subd->dev;
>
>         if (devpriv->aimode =3D=3D AIMODE_SCAN) {
>                 static const int timeout =3D 10;
>                 int i;
>
>                 for (i =3D 0; i < timeout; i++) {
>                         ni_sync_ai_dma(subd);
>                         /* TODO: stop when the transfer is really over */
>                         a4l_udelay(1);
>                 }
>         }
>
>         /* Handle special case of single scan using AI_End_On_End_Of_Scan
> */
>         if ((devpriv->ai_cmd2 & AI_End_On_End_Of_Scan)) {
>                 shutdown_ai_command(subd);
>         }
> }
>
> Just remove the "for" loop and the a4l_udelay, and leave
> ni_sync_ai_dma(subd):
>
> static void ni_handle_eos(a4l_subd_t *subd)
> {
>         a4l_dev_t *dev =3D subd->dev;
>
>         if (devpriv->aimode =3D=3D AIMODE_SCAN) {
>                 static const int timeout =3D 10;
>                 int i;
>
>                 ni_sync_ai_dma(subd);
>         }
>
>         /* Handle special case of single scan using AI_End_On_End_Of_Scan
> */
>         if ((devpriv->ai_cmd2 & AI_End_On_End_Of_Scan)) {
>                 shutdown_ai_command(subd);
>         }
> }
>
>
>
By the way, there is a similar construct in the same file, in function
"handle_a_interrupt()" which should also be checked:

        if (status & AI_FIFO_Half_Full_St) {
                int i;
                static const int timeout =3D 10;

                /* PCMCIA cards (at least 6036) seem to stop producing
                   interrupts if we fail to get the fifo less than half
                   full, so loop to be sure. */

                for (i =3D 0; i < timeout; ++i) {
                        ni_handle_fifo_half_full(subd);
                        if ((devpriv->stc_readw(dev, AI_Status_1_Register) =
&
                             AI_FIFO_Half_Full_St) =3D=3D 0)
                                break;
                }

This looks like some ugly hack, but I don't own a PCMCIA card to test this.
Removing it didn't hurt me, either.

Fernando.

--f46d04138f93e9b1ab04b4349334
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<br><div class=3D"gmail_quote">El 15 de diciembre de 2011 18:28, Fernando H=
errero Carr=C3=B3n <span dir=3D"ltr">&lt;<a href=3D"mailto:elferdo@domain.hid=
m">elferdo@domain.hid</a>&gt;</span> escribi=C3=B3:<br><blockquote class=3D"=
gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-=
left:1ex">
<blockquote style=3D"margin:0 0 0 40px;border:none;padding:0px"><blockquote=
 style=3D"margin:0 0 0 40px;border:none;padding:0px"><div class=3D"gmail_qu=
ote">2011/12/15 Anders Blomdell <span dir=3D"ltr">&lt;<a href=3D"mailto:and=
ers.blomdell@domain.hid" target=3D"_blank">anders.blomdell@domain.hid.=
se</a>&gt;</span></div>

</blockquote></blockquote><div class=3D"gmail_quote"><div class=3D"im"><blo=
ckquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #c=
cc solid;padding-left:1ex">Hi,<br>
<br>
I&#39;m trying to tweak out good performance with Analogy and a NI-6221 car=
d, and after getting weird results with the attached program (long and very=
 varying interrupt latencies). The machine I&#39;m running on is a &#39;Int=
el(R) Core(TM)2 CPU 6420 @ 2.13GHz&#39;, no frequency scaling, no X, low lo=
ad, =C2=A0only one CPU enabled to minimize influence from other Linux tasks=
. As can be seen from the frozen traces (formatted and time shifted to be e=
xamined with &#39;pr -mtT -w 200 A B&#39;), the time spent in the interrupt=
 handling varies between 263 and 329 us and there is variation even in repe=
ated code paths [which are bogus in themselves, why busy-wait 10 us in an i=
nterrupt routine?], so cache poisoning should not be the issue.<br>


<br>
Anybody that has any insights to share?<br><br></blockquote><div><br></div>=
</div><div>Hi everyone there,</div><div><br></div><div>In fact, I came accr=
oss this same issue some months ago, but haven&#39;t had time to write on t=
he list up to now.</div>

<div><br></div><div>Actually, there seems to be some old inherited code fro=
m the early comedi days. In the file ksrc/drivers/analogy/national_instrume=
nts/mio_common.c there is a function that handles transfers called &quot;ni=
_handle_eos()&quot;. You can see:</div>

<div><br></div><div><div>static void ni_handle_eos(a4l_subd_t *subd)</div><=
div>{</div><div>=C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0a4l_dev_t *dev =3D subd-&g=
t;dev;</div><div><br></div><div>=C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0if (devpri=
v-&gt;aimode =3D=3D AIMODE_SCAN) {</div><div>=C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0static const int timeout =3D 10;</div>

<div>=C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0int i;</d=
iv><div><br></div><div>=C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0for (i =3D 0; i &lt; timeout; i++) {</div><div>=C2=A0=C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ni=
_sync_ai_dma(subd);</div><div>=C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* TODO: stop when the transfe=
r is really over */</div>

<div>=C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0a4l_udelay(1);</div><div>=C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}</div><div>=C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=
=A0}</div><div><br></div><div>=C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0/* Handle sp=
ecial case of single scan using AI_End_On_End_Of_Scan */</div><div>=C2=A0=
=C2=A0 =C2=A0 =C2=A0 =C2=A0if ((devpriv-&gt;ai_cmd2 &amp; AI_End_On_End_Of_=
Scan)) {</div>

<div>=C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0shutdown_=
ai_command(subd);</div><div>=C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0}</div><div>}<=
/div></div><div><br></div><div>Just remove the &quot;for&quot; loop and the=
 a4l_udelay, and leave ni_sync_ai_dma(subd):</div><div><br></div>
<div>
<div>static void ni_handle_eos(a4l_subd_t *subd)</div><div>{</div><div>=C2=
=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0a4l_dev_t *dev =3D subd-&gt;dev;</div><div><b=
r></div><div>=C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0if (devpriv-&gt;aimode =3D=3D=
 AIMODE_SCAN) {</div><div>=C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0static const int timeout =3D 10;</div>

<div>=C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0int i;</d=
iv><div><br></div><div>=C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0ni_sync_ai_dma(subd);</div><div>=C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0=
}</div><div><br></div><div>=C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0/* Handle speci=
al case of single scan using AI_End_On_End_Of_Scan */</div><div>

=C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0if ((devpriv-&gt;ai_cmd2 &amp; AI_End_On_E=
nd_Of_Scan)) {</div><div>=C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0shutdown_ai_command(subd);</div><div>=C2=A0=C2=A0 =C2=A0 =C2=
=A0 =C2=A0}</div><div>}</div></div><div><br></div><br></div></blockquote></=
div><br>By the way, there is a similar construct in the same file, in funct=
ion &quot;handle_a_interrupt()&quot; which should also be checked:<br>
<br><div style=3D"margin-left:40px">=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 if (status &amp; AI_FIFO_Half_Full_St) {<br>=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int i;<br>=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 static const int timeout =3D 10;<br><br>=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /*=
 PCMCIA cards (at least 6036) seem to stop producing<br>
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 interrupts if we fail to get the fifo les=
s than half<br>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 full, so loop to be sure. =
*/<br><br>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 for (i =3D 0; i &lt; timeout; ++i) {<br>=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ni_handle_fifo_ha=
lf_full(subd);<br>
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if ((devpri=
v-&gt;stc_readw(dev, AI_Status_1_Register) &amp;<br>=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 AI=
_FIFO_Half_Full_St) =3D=3D 0)<br>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 break=
;<br>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 }<br><br></div>This looks like some ugly hack, but I =
don&#39;t own a PCMCIA card to test this. Removing it didn&#39;t hurt me, e=
ither.<br>
<br>Fernando.<br>

--f46d04138f93e9b1ab04b4349334--

