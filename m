MIME-Version: 1.0
In-Reply-To: <4CD70AF7.90802@domain.hid>
References: <AANLkTinQotwe=EwATsmdKnanN-ZwT8c+CobzBRDqptEj@domain.hid>
	<4CCB4573.30607@domain.hid> <4CD68353.6030600@domain.hid>
	<AANLkTinfxNrqc0VZh=RAzpFzPBPVhPmzDC1zviDdwr=0@domain.hid>
	<4CD6DE9F.7000100@domain.hid>
	<AANLkTikioAXv_TuO-8x4G7Q_0TJKqmiMc_nytRBQrzNg@domain.hid>
	<4CD70AF7.90802@domain.hid>
Date: Sun, 7 Nov 2010 14:34:27 -0600
Message-ID: <AANLkTi=DN-0nycqq2Mn4NQ_aZ-dh2mdCtJgxdQMYbRRL@mail.gmail.com>
From: at91_enthus <nwromania@domain.hid>
Content-Type: multipart/alternative; boundary=0016368e2aec134d8d04947c6ff5
Subject: Re: [Xenomai-help] High resolution timers disabled on AT91SAM9G20
 board after patching
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

--0016368e2aec134d8d04947c6ff5
Content-Type: text/plain; charset=ISO-8859-1

Xeno-test is the only benchmark I have for the time being (I just started
with xenomai).
So if you consider that  "dd if=.. of=.."  is a reliable load, then yes.

Here's a snippet of xeno-test's output:

warming up...
RTT|  00:00:01  (periodic user-mode task, 1000 us period, priority 99)
RTH|----lat min|----lat avg|----lat max|-overrun|---msw|---lat best|--lat
worst
RTD|     12.596|     13.565|     24.224|       0|     0|     12.596|
24.224
RTD|     12.596|     13.565|     32.945|       0|     0|     12.596|
32.945
RTD|     13.565|     13.565|     37.790|       0|     0|     12.596|
37.790

R.

On Sun, Nov 7, 2010 at 2:24 PM, Gilles Chanteperdrix <
gilles.chanteperdrix@xenomai.org> wrote:

> at91_enthus wrote:
> > Indeed, there's a huge difference regarding minimum and average latencies
> > now that FCSE is enabled and HRT and CONFIG_PREEMPT are disabled. I get
> > around 13.5 microseconds average latencies.
>
> Wow. Under load?
>
> --
>                                                                 Gilles.
>

--0016368e2aec134d8d04947c6ff5
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Xeno-test is the only benchmark I have for the time being (I just started w=
ith xenomai).=A0<div>So if you consider that =A0&quot;dd if=3D.. of=3D..&qu=
ot; =A0is a reliable load, then yes.<div><br></div><div>Here&#39;s a snippe=
t of xeno-test&#39;s output:</div>
<div><br></div><div><div>warming up...</div><div>RTT| =A000:00:01 =A0(perio=
dic user-mode task, 1000 us period, priority 99)</div><div>RTH|----lat min|=
----lat avg|----lat max|-overrun|---msw|---lat best|--lat worst</div><div>R=
TD| =A0 =A0 12.596| =A0 =A0 13.565| =A0 =A0 24.224| =A0 =A0 =A0 0| =A0 =A0 =
0| =A0 =A0 12.596| =A0 =A0 24.224</div>
<div>RTD| =A0 =A0 12.596| =A0 =A0 13.565| =A0 =A0 32.945| =A0 =A0 =A0 0| =
=A0 =A0 0| =A0 =A0 12.596| =A0 =A0 32.945</div><div>RTD| =A0 =A0 13.565| =
=A0 =A0 13.565| =A0 =A0 37.790| =A0 =A0 =A0 0| =A0 =A0 0| =A0 =A0 12.596| =
=A0 =A0 37.790</div><div><br></div><div>R.</div><br><div class=3D"gmail_quo=
te">
On Sun, Nov 7, 2010 at 2:24 PM, Gilles Chanteperdrix <span dir=3D"ltr">&lt;=
<a href=3D"mailto:gilles.chanteperdrix@xenomai.org">gilles.chanteperdrix@xenomai.org=
nomai.org</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_quote" style=
=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex;">
<div class=3D"im">at91_enthus wrote:<br>
&gt; Indeed, there&#39;s a huge difference regarding minimum and average la=
tencies<br>
&gt; now that FCSE is enabled and HRT and CONFIG_PREEMPT are disabled. I ge=
t<br>
&gt; around 13.5 microseconds average latencies.<br>
<br>
</div>Wow. Under load?<br>
<br>
--<br>
<font color=3D"#888888"> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0Gilles.<br>
</font></blockquote></div><br></div></div>

--0016368e2aec134d8d04947c6ff5--

