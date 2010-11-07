MIME-Version: 1.0
In-Reply-To: <4CD6DE9F.7000100@domain.hid>
References: <AANLkTinQotwe=EwATsmdKnanN-ZwT8c+CobzBRDqptEj@domain.hid>
	<4CCB4573.30607@domain.hid> <4CD68353.6030600@domain.hid>
	<AANLkTinfxNrqc0VZh=RAzpFzPBPVhPmzDC1zviDdwr=0@domain.hid>
	<4CD6DE9F.7000100@domain.hid>
Date: Sun, 7 Nov 2010 13:45:30 -0600
Message-ID: <AANLkTikioAXv_TuO-8x4G7Q_0TJKqmiMc_nytRBQrzNg@domain.hid>
From: at91_enthus <nwromania@domain.hid>
Content-Type: multipart/alternative; boundary=00504502d9560c183004947bc010
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

--00504502d9560c183004947bc010
Content-Type: text/plain; charset=ISO-8859-1

Indeed, there's a huge difference regarding minimum and average latencies
now that FCSE is enabled and HRT and CONFIG_PREEMPT are disabled. I get
around 13.5 microseconds average latencies.

Thanks a lot.

On Sun, Nov 7, 2010 at 11:15 AM, Gilles Chanteperdrix <
gilles.chanteperdrix@xenomai.org> wrote:

> at91_enthus wrote:
> > Yes, it solved the issue.
> >
> > There is  one thing that bothers me, though. When I run  "xeno-test", the
> > average and minimal  latencies are constant all the time.
> >
> > The unpatched version of the xeno kernel seems more consistent when it
> comes
> > to minimum, maximum and average latencies.
> >
> > I attached a couple of snippets of  xeno-test outputs .
>
> Do not trust xeno-test too much. Are you sure the only difference
> between the two runs is the patch, for instance, have you not played
> with the CONFIG_ARM_FCSE option? Also, good benchmarks are done with
> running a separate load, and not with xeno-test, in fact.
>
> Also, using the high-res timers configuration has a high overhead on
> such low-end configurations as AT91s, so has CONFIG_PREEMPT. So, if you
> are looking for a configuration with the lowest overhead possible, I
> would recommend disabling CONFIG_HIGH_RES_TIMERS and using
> CONFIG_PREEMPT_NONE or CONFIG_PREEMPT_VOLUNTARY, and relying on Xenomai
> for the low latency and high resolution timer features. (You can measure
> the overhead of kernel options with the hackbench test for instance).
>
> On the AT91 I have (AT91SAM9263), the minimum and average latencies
> oscillate much less than for your unpatched kernel, either with or
> without the patch so I wonder if you would not have another issue. Do
> you have FCSE enabled?
>
> To give you an idea of the figures here, with FCSE enabled, the minimal
> latency is around 15us and the average latency around 50us. And they
> vary in a 5us range, they do not make big jumps.
>
>
> --
>                                                                 Gilles.
>

--00504502d9560c183004947bc010
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Indeed, there&#39;s a huge difference regarding minimum and average latenci=
es now that FCSE is enabled and HRT and CONFIG_PREEMPT are disabled. I get =
around 13.5 microseconds average latencies.<br><br>Thanks a lot.=A0 <br><br=
>
<div class=3D"gmail_quote">On Sun, Nov 7, 2010 at 11:15 AM, Gilles Chantepe=
rdrix <span dir=3D"ltr">&lt;<a href=3D"mailto:gilles.chanteperdrix@xenomai.org.=
org">gilles.chanteperdrix@xenomai.org</a>&gt;</span> wrote:<br><blockquote =
class=3D"gmail_quote" style=3D"margin: 0pt 0pt 0pt 0.8ex; border-left: 1px =
solid rgb(204, 204, 204); padding-left: 1ex;">
<div class=3D"im">at91_enthus wrote:<br>
&gt; Yes, it solved the issue.<br>
&gt;<br>
&gt; There is =A0one thing that bothers me, though. When I run =A0&quot;xen=
o-test&quot;, the<br>
&gt; average and minimal =A0latencies are constant all the time.<br>
&gt;<br>
&gt; The unpatched version of the xeno kernel seems more consistent when it=
 comes<br>
&gt; to minimum, maximum and average latencies.<br>
&gt;<br>
&gt; I attached a couple of snippets of =A0xeno-test outputs .<br>
<br>
</div>Do not trust xeno-test too much. Are you sure the only difference<br>
between the two runs is the patch, for instance, have you not played<br>
with the CONFIG_ARM_FCSE option? Also, good benchmarks are done with<br>
running a separate load, and not with xeno-test, in fact.<br>
<br>
Also, using the high-res timers configuration has a high overhead on<br>
such low-end configurations as AT91s, so has CONFIG_PREEMPT. So, if you<br>
are looking for a configuration with the lowest overhead possible, I<br>
would recommend disabling CONFIG_HIGH_RES_TIMERS and using<br>
CONFIG_PREEMPT_NONE or CONFIG_PREEMPT_VOLUNTARY, and relying on Xenomai<br>
for the low latency and high resolution timer features. (You can measure<br=
>
the overhead of kernel options with the hackbench test for instance).<br>
<br>
On the AT91 I have (AT91SAM9263), the minimum and average latencies<br>
oscillate much less than for your unpatched kernel, either with or<br>
without the patch so I wonder if you would not have another issue. Do<br>
you have FCSE enabled?<br>
<br>
To give you an idea of the figures here, with FCSE enabled, the minimal<br>
latency is around 15us and the average latency around 50us. And they<br>
vary in a 5us range, they do not make big jumps.<br>
<br>
<br>
--<br>
<font color=3D"#888888"> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0Gilles.<br>
</font></blockquote></div><br>

--00504502d9560c183004947bc010--

