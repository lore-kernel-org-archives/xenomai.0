MIME-Version: 1.0
In-Reply-To: <4D4A8354.7010209@domain.hid>
References: <AANLkTi=pm4BfNAwCzw-6HLOiKfJQmgMQdPmVXTcCBSBs@domain.hid>
	<4D49CF24.9080700@domain.hid>
	<AANLkTinaTVSJW1jQzn7+jbsQgNE+HAEOXLEK3LC0MoWR@mail.gmail.com>
	<4D49D608.5020006@domain.hid>
	<AANLkTinU4b-SY6Vy7=Ss+Nxrp-+qEZ6qsTudBsmrjbh_@domain.hid>
	<4D4A80F6.5020600@domain.hid> <4D4A8354.7010209@domain.hid>
Date: Thu, 3 Feb 2011 22:24:19 -0600
Message-ID: <AANLkTim3M6fPN5u6AjNn5xdwbOM9AmzB+yG2w37o1A3J@mail.gmail.com>
From: at91_enthus <nwromania@domain.hid>
Content-Type: multipart/alternative; boundary=e0cb4e6ff3658165b1049b6d41a0
Subject: Re: [Xenomai-help] I-pipe clock source change and MMC issues (AT91)
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

--e0cb4e6ff3658165b1049b6d41a0
Content-Type: text/plain; charset=ISO-8859-1

On Thu, Feb 3, 2011 at 4:28 AM, Gilles Chanteperdrix <
gilles.chanteperdrix@xenomai.org> wrote:

> Gilles Chanteperdrix wrote:
> > at91_enthus wrote:
> >> On Wed, Feb 2, 2011 at 4:09 PM, Gilles Chanteperdrix <
> >> gilles.chanteperdrix@xenomai.org> wrote:
> >>
> >>> at91_enthus wrote:
> >>>> On Wed, Feb 2, 2011 at 3:39 PM, Gilles Chanteperdrix
> >>>> <gilles.chanteperdrix@xenomai.org
> >>>> <mailto:gilles.chanteperdrix@xenomai.org>> wrote:
> >>>>
> >>>>     at91_enthus wrote:
> >>>>     > Hi.
> >>>>     >
> >>>>     > In order to get better accuracy with Xenomai, I modified the
> I-pipe
> >>>>     > timebase (MCK divider) in arch/arm.mach-at91/at91_ipipe_time.c.
> >>>>     > Unfortunately, I cannot mount the rootfs on the MMC, since the
> MMC
> >>>>     > controller is no longer functioning. I tried to change TCx in
> >>> kernel
> >>>>     > configuration to no avail.
> >>>>     > When I switch back to a timebase of 1 MHz, the MMC works fine.
> >>>>
> >>>>     The thing is that we are a bit tight on AT91. A 16 bits counter is
> >>> used
> >>>>     for both the timer and the tsc emulation, and this tsc must be
> >>> refreshed
> >>>>     at least once before it wraps. The problem is that since it is a
> 16
> >>> bits
> >>>>     counter, it wraps really fast, on my AT91SAM9263 it wraps in 20
> ms,
> >>> and
> >>>>     since the Linux default period is 10ms we are actually quite close
> to
> >>>>     the limit.
> >>>>
> >>>>     Anyway, trying to get a better accuracy than 1us is kind of
> useless
> >>> on
> >>>>     AT91, since even reading this counter takes more than 1us. So, you
> >>> are
> >>>>     not in fact improving anything. The 1MHz is even a bit overkill.
> >>> On the other hand, the AT91SAM9G20 may be running at a better
> frequency.
> >>> But with latencies in the order of tens of microseconds, having a
> better
> >>> accuracy than 1us still does not make really much sense.
> >>
> >>
> >>
> >>> Why do you need
> >>> this accuracy?
> >>>
> >> I want to time stamp the samples from a 8 channel SPI-based ADC. I know
> that
> >> a conversion takes between 3 and 5 microseconds depending on the SPI
> clock.
> >> What I want is to adapt the code to acquire a fixed numb
>
> er of samples in
> >> user space (I knew it was a long shot). Plain, Xenomai-free, userland
> >> application was out of the question, so I figured that a userspace
> >> application in Xenomai run at highest priority should doand the trick.
> >>
> >> On a second thought, a simple linux kernel module is what I want (this
> way I
> >> can use interrupts and one of the platform's six timers).
> >
> > You can use interrupts and the platform's six timers in a Xenomai driver
> > based on the RTDM skin. The thing is, what interrupt latency is your
> target?
> >
>
> To make myself clear:
> you got:
> - the AD conversion (amounts for an unknown amount of time between 3 and
> 5us)
> - the SPI interrupt
> - some unknown interrupt latency which amouunts to several tens of
> microseconds with Xenomai, and to a few hundreds of microseconds with
> Linux.
> - the interrupt handler is invoked.
>

What good will it make to have a timestamping precision with a
> sub-microsecond range in the interrupt handler code?
>
> --
>                                             Gilles.
>

Rookie mistake. Indeed, I can have everything in userspace using Xenomai. I
wrote a simple program that did a periodic job every 100 us and the jitter
was very small (around 20 us without load and around 35 us with SSH-ing and
Xenomai compilation running on board).

Somewhat unrelated to this thread, I found that when I invoked
rt_task_set_periodic(), I got very precise timings (as expected). However,
when I tried to insert small delays using rt_timer_spin(), the errors
(t_meas - t_spin_func_argument) were not large, but noticeable. For example,
I can precisely measure a 50 us periodic task on the scope. With the same
interval in rt_timer_spin(), I get 55-60 us. As far as I understood, all
timing-related functions use the same time base, so what's the reason for
this behavior?


Regards,
R.

--e0cb4e6ff3658165b1049b6d41a0
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<br><br><div class=3D"gmail_quote">On Thu, Feb 3, 2011 at 4:28 AM, Gilles C=
hanteperdrix <span dir=3D"ltr">&lt;<a href=3D"mailto:gilles.chanteperdrix@xenomai.org=
enomai.org">gilles.chanteperdrix@xenomai.org</a>&gt;</span> wrote:<br><bloc=
kquote class=3D"gmail_quote" style=3D"margin: 0pt 0pt 0pt 0.8ex; border-lef=
t: 1px solid rgb(204, 204, 204); padding-left: 1ex;">
<div><div></div><div class=3D"h5">Gilles Chanteperdrix wrote:<br>
&gt; at91_enthus wrote:<br>
&gt;&gt; On Wed, Feb 2, 2011 at 4:09 PM, Gilles Chanteperdrix &lt;<br>
&gt;&gt; <a href=3D"mailto:gilles.chanteperdrix@xenomai.org">gilles.chantep=
erdrix@domain.hid</a>&gt; wrote:<br>
&gt;&gt;<br>
&gt;&gt;&gt; at91_enthus wrote:<br>
&gt;&gt;&gt;&gt; On Wed, Feb 2, 2011 at 3:39 PM, Gilles Chanteperdrix<br>
&gt;&gt;&gt;&gt; &lt;<a href=3D"mailto:gilles.chanteperdrix@xenomai.org">gi=
lles.chanteperdrix@domain.hid</a><br>
&gt;&gt;&gt;&gt; &lt;mailto:<a href=3D"mailto:gilles.chanteperdrix@xenomai.org.=
org">gilles.chanteperdrix@xenomai.org</a>&gt;&gt; wrote:<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; =A0 =A0 at91_enthus wrote:<br>
&gt;&gt;&gt;&gt; =A0 =A0 &gt; Hi.<br>
&gt;&gt;&gt;&gt; =A0 =A0 &gt;<br>
&gt;&gt;&gt;&gt; =A0 =A0 &gt; In order to get better accuracy with Xenomai,=
 I modified the I-pipe<br>
&gt;&gt;&gt;&gt; =A0 =A0 &gt; timebase (MCK divider) in arch/arm.mach-at91/=
at91_ipipe_time.c.<br>
&gt;&gt;&gt;&gt; =A0 =A0 &gt; Unfortunately, I cannot mount the rootfs on t=
he MMC, since the MMC<br>
&gt;&gt;&gt;&gt; =A0 =A0 &gt; controller is no longer functioning. I tried =
to change TCx in<br>
&gt;&gt;&gt; kernel<br>
&gt;&gt;&gt;&gt; =A0 =A0 &gt; configuration to no avail.<br>
&gt;&gt;&gt;&gt; =A0 =A0 &gt; When I switch back to a timebase of 1 MHz, th=
e MMC works fine.<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; =A0 =A0 The thing is that we are a bit tight on AT91. A 16=
 bits counter is<br>
&gt;&gt;&gt; used<br>
&gt;&gt;&gt;&gt; =A0 =A0 for both the timer and the tsc emulation, and this=
 tsc must be<br>
&gt;&gt;&gt; refreshed<br>
&gt;&gt;&gt;&gt; =A0 =A0 at least once before it wraps. The problem is that=
 since it is a 16<br>
&gt;&gt;&gt; bits<br>
&gt;&gt;&gt;&gt; =A0 =A0 counter, it wraps really fast, on my AT91SAM9263 i=
t wraps in 20 ms,<br>
&gt;&gt;&gt; and<br>
&gt;&gt;&gt;&gt; =A0 =A0 since the Linux default period is 10ms we are actu=
ally quite close to<br>
&gt;&gt;&gt;&gt; =A0 =A0 the limit.<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; =A0 =A0 Anyway, trying to get a better accuracy than 1us i=
s kind of useless<br>
&gt;&gt;&gt; on<br>
&gt;&gt;&gt;&gt; =A0 =A0 AT91, since even reading this counter takes more t=
han 1us. So, you<br>
&gt;&gt;&gt; are<br>
&gt;&gt;&gt;&gt; =A0 =A0 not in fact improving anything. The 1MHz is even a=
 bit overkill.<br>
&gt;&gt;&gt; On the other hand, the AT91SAM9G20 may be running at a better =
frequency.<br>
&gt;&gt;&gt; But with latencies in the order of tens of microseconds, havin=
g a better<br>
&gt;&gt;&gt; accuracy than 1us still does not make really much sense.<br>
&gt;&gt;<br>
&gt;&gt;<br>
&gt;&gt;<br>
&gt;&gt;&gt; Why do you need<br>
&gt;&gt;&gt; this accuracy?<br>
&gt;&gt;&gt;<br>
&gt;&gt; I want to time stamp the samples from a 8 channel SPI-based ADC. I=
 know that<br>
&gt;&gt; a conversion takes between 3 and 5 microseconds depending on the S=
PI clock.<br>
&gt;&gt; What I want is to adapt the code to acquire a fixed numb<br>
<br>
er of samples in<br>
&gt;&gt; user space (I knew it was a long shot). Plain, Xenomai-free, userl=
and<br>
&gt;&gt; application was out of the question, so I figured that a userspace=
<br>
</div></div>&gt;&gt; application in Xenomai run at highest priority should =
doand the trick.<br>
<div class=3D"im">&gt;&gt;<br>
&gt;&gt; On a second thought, a simple linux kernel module is what I want (=
this way I<br>
&gt;&gt; can use interrupts and one of the platform&#39;s six timers).<br>
&gt;<br>
&gt; You can use interrupts and the platform&#39;s six timers in a Xenomai =
driver<br>
&gt; based on the RTDM skin. The thing is, what interrupt latency is your t=
arget?<br>
&gt;<br>
<br>
</div>To make myself clear:<br>
you got:<br>
- the AD conversion (amounts for an unknown amount of time between 3 and<br=
>
5us)<br>
- the SPI interrupt<br>
- some unknown interrupt latency which amouunts to several tens of<br>
microseconds with Xenomai, and to a few hundreds of microseconds with Linux=
.<br>
- the interrupt handler is invoked.<br>
=A0</blockquote><blockquote class=3D"gmail_quote" style=3D"margin: 0pt 0pt =
0pt 0.8ex; border-left: 1px solid rgb(204, 204, 204); padding-left: 1ex;">
What good will it make to have a timestamping precision with a<br>
sub-microsecond range in the interrupt handler code?<br>
<br>
--<br>
<font color=3D"#888888"> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0Gilles.<br>
</font></blockquote></div><br>Rookie mistake. Indeed, I can have everything=
 in userspace using=20
Xenomai. I wrote a simple program that did a periodic job every 100 us=20
and the jitter was very small (around 20 us without load and around 35=20
us with SSH-ing and Xenomai compilation running on board).<br><br>Somewhat =
unrelated to this thread, I found that when I invoked rt_task_set_periodic(=
), I got very precise timings (as expected). However, when I tried to inser=
t small delays using rt_timer_spin(), the errors (t_meas - t_spin_func_argu=
ment) were not large, but noticeable. For example, I can precisely measure =
a 50 us periodic task on the scope. With the same interval in rt_timer_spin=
(), I get 55-60 us. As far as I understood, all timing-related functions us=
e the same time base, so what&#39;s the reason for this behavior?<br>
<br><br>Regards,<br>R.<br>

--e0cb4e6ff3658165b1049b6d41a0--

