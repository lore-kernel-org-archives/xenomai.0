MIME-Version: 1.0
In-Reply-To: <4EE9FD4A.1090202@domain.hid>
References: <4EE9FD4A.1090202@domain.hid>
Date: Thu, 15 Dec 2011 18:28:12 +0100
Message-ID: <CAMwkeZw4X15HU7ABUhvLpXuu1Sbspen6FK7XvjHiQLXg0AcazQ@mail.gmail.com>
From: =?UTF-8?Q?Fernando_Herrero_Carr=C3=B3n?= <elferdo@domain.hid>
Content-Type: multipart/alternative; boundary=14dae9c0902e15a15104b424cfec
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

--14dae9c0902e15a15104b424cfec
Content-Type: text/plain; charset=UTF-8

2011/12/15 Anders Blomdell <anders.blomdell@domain.hid>

Hi,
>
> I'm trying to tweak out good performance with Analogy and a NI-6221 card,
> and after getting weird results with the attached program (long and very
> varying interrupt latencies). The machine I'm running on is a 'Intel(R)
> Core(TM)2 CPU 6420 @ 2.13GHz', no frequency scaling, no X, low load,  only
> one CPU enabled to minimize influence from other Linux tasks. As can be
> seen from the frozen traces (formatted and time shifted to be examined with
> 'pr -mtT -w 200 A B'), the time spent in the interrupt handling varies
> between 263 and 329 us and there is variation even in repeated code paths
> [which are bogus in themselves, why busy-wait 10 us in an interrupt
> routine?], so cache poisoning should not be the issue.
>
> Anybody that has any insights to share?
>
>
Hi everyone there,

In fact, I came accross this same issue some months ago, but haven't had
time to write on the list up to now.

Actually, there seems to be some old inherited code from the early comedi
days. In the file ksrc/drivers/analogy/national_instruments/mio_common.c
there is a function that handles transfers called "ni_handle_eos()". You
can see:

static void ni_handle_eos(a4l_subd_t *subd)
{
        a4l_dev_t *dev = subd->dev;

        if (devpriv->aimode == AIMODE_SCAN) {
                static const int timeout = 10;
                int i;

                for (i = 0; i < timeout; i++) {
                        ni_sync_ai_dma(subd);
                        /* TODO: stop when the transfer is really over */
                        a4l_udelay(1);
                }
        }

        /* Handle special case of single scan using AI_End_On_End_Of_Scan */
        if ((devpriv->ai_cmd2 & AI_End_On_End_Of_Scan)) {
                shutdown_ai_command(subd);
        }
}

Just remove the "for" loop and the a4l_udelay, and leave
ni_sync_ai_dma(subd):

static void ni_handle_eos(a4l_subd_t *subd)
{
        a4l_dev_t *dev = subd->dev;

        if (devpriv->aimode == AIMODE_SCAN) {
                static const int timeout = 10;
                int i;

                ni_sync_ai_dma(subd);
        }

        /* Handle special case of single scan using AI_End_On_End_Of_Scan */
        if ((devpriv->ai_cmd2 & AI_End_On_End_Of_Scan)) {
                shutdown_ai_command(subd);
        }
}

This is working for me, for the time being.

Hope this helps,
Fernando

--14dae9c0902e15a15104b424cfec
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<blockquote class=3D"webkit-indent-blockquote" style=3D"margin:0 0 0 40px;b=
order:none;padding:0px"><blockquote class=3D"webkit-indent-blockquote" styl=
e=3D"margin:0 0 0 40px;border:none;padding:0px"><div class=3D"gmail_quote">=
2011/12/15 Anders Blomdell <span dir=3D"ltr">&lt;<a href=3D"mailto:anders.b=
lomdell@domain.hid">anders.blomdell@domain.hid</a>&gt;</span></div>
</blockquote></blockquote><div class=3D"gmail_quote"><blockquote class=3D"g=
mail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-l=
eft:1ex">Hi,<br>
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
<div>Hi everyone there,</div><div><br></div><div>In fact, I came accross th=
is same issue some months ago, but haven&#39;t had time to write on the lis=
t up to now.</div>
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
 a4l_udelay, and leave ni_sync_ai_dma(subd):</div><div><br></div><div>
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
=A0 =C2=A0}</div><div>}</div></div><div><br></div><div>This is working for =
me, for the time being.</div>
<div><br></div><div>Hope this helps,</div><div>Fernando</div></div>

--14dae9c0902e15a15104b424cfec--

