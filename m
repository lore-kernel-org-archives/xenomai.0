MIME-Version: 1.0
In-Reply-To: <4D4C7F10.3020703@domain.hid>
References: <AANLkTi=pm4BfNAwCzw-6HLOiKfJQmgMQdPmVXTcCBSBs@domain.hid>
	<4D49CF24.9080700@domain.hid>
	<AANLkTinaTVSJW1jQzn7+jbsQgNE+HAEOXLEK3LC0MoWR@mail.gmail.com>
	<4D49D608.5020006@domain.hid>
	<AANLkTinU4b-SY6Vy7=Ss+Nxrp-+qEZ6qsTudBsmrjbh_@domain.hid>
	<4D4A80F6.5020600@domain.hid> <4D4A8354.7010209@domain.hid>
	<AANLkTim3M6fPN5u6AjNn5xdwbOM9AmzB+yG2w37o1A3J@mail.gmail.com>
	<4D4C7F10.3020703@domain.hid>
Date: Fri, 4 Feb 2011 18:23:04 -0600
Message-ID: <AANLkTi=QiGXpMwdY3tEz=Qo0tO8Q5fe1xnPpo+dX3eEP@mail.gmail.com>
From: at91_enthus <nwromania@domain.hid>
Content-Type: multipart/alternative; boundary=e0cb4e70021b93ab0a049b7e00e7
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

--e0cb4e70021b93ab0a049b7e00e7
Content-Type: text/plain; charset=ISO-8859-1

On Fri, Feb 4, 2011 at 4:34 PM, Gilles Chanteperdrix <
gilles.chanteperdrix@xenomai.org> wrote:

> at91_enthus wrote:
> > On Thu, Feb 3, 2011 at 4:28 AM, Gilles Chanteperdrix <
> > gilles.chanteperdrix@xenomai.org> wrote:
> >
> >> Gilles Chanteperdrix wrote:
> >>> at91_enthus wrote:
> >>>> On Wed, Feb 2, 2011 at 4:09 PM, Gilles Chanteperdrix <
> >>>> gilles.chanteperdrix@xenomai.org> wrote:
> >>>>
> >>>>> at91_enthus wrote:
> >>>>>> On Wed, Feb 2, 2011 at 3:39 PM, Gilles Chanteperdrix
> >>>>>> <gilles.chanteperdrix@xenomai.org
> >>>>>> <mailto:gilles.chanteperdrix@xenomai.org>> wrote:
> >>>>>>
> >>>>>>     at91_enthus wrote:
> >>>>>>     > Hi.
> >>>>>>     >
> >>>>>>     > In order to get better accuracy with Xenomai, I modified the
> >> I-pipe
> >>>>>>     > timebase (MCK divider) in
> arch/arm.mach-at91/at91_ipipe_time.c.
> >>>>>>     > Unfortunately, I cannot mount the rootfs on the MMC, since the
> >> MMC
> >>>>>>     > controller is no longer functioning. I tried to change TCx in
> >>>>> kernel
> >>>>>>     > configuration to no avail.
> >>>>>>     > When I switch back to a timebase of 1 MHz, the MMC works fine.
> >>>>>>
> >>>>>>     The thing is that we are a bit tight on AT91. A 16 bits counter
> is
> >>>>> used
> >>>>>>     for both the timer and the tsc emulation, and this tsc must be
> >>>>> refreshed
> >>>>>>     at least once before it wraps. The problem is that since it is a
> >> 16
> >>>>> bits
> >>>>>>     counter, it wraps really fast, on my AT91SAM9263 it wraps in 20
> >> ms,
> >>>>> and
> >>>>>>     since the Linux default period is 10ms we are actually quite
> close
> >> to
> >>>>>>     the limit.
> >>>>>>
> >>>>>>     Anyway, trying to get a better accuracy than 1us is kind of
> >> useless
> >>>>> on
> >>>>>>     AT91, since even reading this counter takes more than 1us. So,
> you
> >>>>> are
> >>>>>>     not in fact improving anything. The 1MHz is even a bit overkill.
> >>>>> On the other hand, the AT91SAM9G20 may be running at a better
> >> frequency.
> >>>>> But with latencies in the order of tens of microseconds, having a
> >> better
> >>>>> accuracy than 1us still does not make really much sense.
> >>>>
> >>>>
> >>>>> Why do you need
> >>>>> this accuracy?
> >>>>>
> >>>> I want to time stamp the samples from a 8 channel SPI-based ADC. I
> know
> >> that
> >>>> a conversion takes between 3 and 5 microseconds depending on the SPI
> >> clock.
> >>>> What I want is to adapt the code to acquire a fixed numb
> >> er of samples in
> >>>> user space (I knew it was a long shot). Plain, Xenomai-free, userland
> >>>> application was out of the question, so I figured that a userspace
> >>>> application in Xenomai run at highest priority should doand the trick.
> >>>>
> >>>> On a second thought, a simple linux kernel module is what I want (this
> >> way I
> >>>> can use interrupts and one of the platform's six timers).
> >>> You can use interrupts and the platform's six timers in a Xenomai
> driver
> >>> based on the RTDM skin. The thing is, what interrupt latency is your
> >> target?
> >> To make myself clear:
> >> you got:
> >> - the AD conversion (amounts for an unknown amount of time between 3 and
> >> 5us)
> >> - the SPI interrupt
> >> - some unknown interrupt latency which amouunts to several tens of
> >> microseconds with Xenomai, and to a few hundreds of microseconds with
> >> Linux.
> >> - the interrupt handler is invoked.
> >>
> >
> > What good will it make to have a timestamping precision with a
> >> sub-microsecond range in the interrupt handler code?
> >>
> >> --
> >>                                             Gilles.
> >>
> >
> > Rookie mistake. Indeed, I can have everything in userspace using Xenomai.
> I
> > wrote a simple program that did a periodic job every 100 us and the
> jitter
> > was very small (around 20 us without load and around 35 us with SSH-ing
> and
> > Xenomai compilation running on board).
> >
> > Somewhat unrelated to this thread, I found that when I invoked
> > rt_task_set_periodic(), I got very precise timings (as expected).
> However,
> > when I tried to insert small delays using rt_timer_spin(), the errors
> > (t_meas - t_spin_func_argument) were not large, but noticeable. For
> example,
> > I can precisely measure a 50 us periodic task on the scope. With the same
> > interval in rt_timer_spin(), I get 55-60 us. As far as I understood, all
> > timing-related functions use the same time base, so what's the reason for
> > this behavior?
>
>

Where do you use rt_timer_spin, in kernel-space, or in user-space?


User space.


> How
> long do you spin?
>
>
50000 nsec.


R.

>

--e0cb4e70021b93ab0a049b7e00e7
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<br><br><div class=3D"gmail_quote">On Fri, Feb 4, 2011 at 4:34 PM, Gilles C=
hanteperdrix <span dir=3D"ltr">&lt;<a href=3D"mailto:gilles.chanteperdrix@xenomai.org=
enomai.org">gilles.chanteperdrix@xenomai.org</a>&gt;</span> wrote:<br><bloc=
kquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #cc=
c solid;padding-left:1ex;">
<div><div class=3D"h5">at91_enthus wrote:<br>
&gt; On Thu, Feb 3, 2011 at 4:28 AM, Gilles Chanteperdrix &lt;<br>
&gt; <a href=3D"mailto:gilles.chanteperdrix@xenomai.org">gilles.chanteperdr=
ix@domain.hid</a>&gt; wrote:<br>
&gt;<br>
&gt;&gt; Gilles Chanteperdrix wrote:<br>
&gt;&gt;&gt; at91_enthus wrote:<br>
&gt;&gt;&gt;&gt; On Wed, Feb 2, 2011 at 4:09 PM, Gilles Chanteperdrix &lt;<=
br>
&gt;&gt;&gt;&gt; <a href=3D"mailto:gilles.chanteperdrix@xenomai.org">gilles=
.chanteperdrix@domain.hid</a>&gt; wrote:<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt; at91_enthus wrote:<br>
&gt;&gt;&gt;&gt;&gt;&gt; On Wed, Feb 2, 2011 at 3:39 PM, Gilles Chanteperdr=
ix<br>
&gt;&gt;&gt;&gt;&gt;&gt; &lt;<a href=3D"mailto:gilles.chanteperdrix@xenomai.org=
.org">gilles.chanteperdrix@xenomai.org</a><br>
&gt;&gt;&gt;&gt;&gt;&gt; &lt;mailto:<a href=3D"mailto:gilles.chanteperdrix@=
xenomai.org">gilles.chanteperdrix@xenomai.org</a>&gt;&gt; wrote:<br>
&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt; =A0 =A0 at91_enthus wrote:<br>
&gt;&gt;&gt;&gt;&gt;&gt; =A0 =A0 &gt; Hi.<br>
&gt;&gt;&gt;&gt;&gt;&gt; =A0 =A0 &gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt; =A0 =A0 &gt; In order to get better accuracy with =
Xenomai, I modified the<br>
&gt;&gt; I-pipe<br>
&gt;&gt;&gt;&gt;&gt;&gt; =A0 =A0 &gt; timebase (MCK divider) in arch/arm.ma=
ch-at91/at91_ipipe_time.c.<br>
&gt;&gt;&gt;&gt;&gt;&gt; =A0 =A0 &gt; Unfortunately, I cannot mount the roo=
tfs on the MMC, since the<br>
&gt;&gt; MMC<br>
&gt;&gt;&gt;&gt;&gt;&gt; =A0 =A0 &gt; controller is no longer functioning. =
I tried to change TCx in<br>
&gt;&gt;&gt;&gt;&gt; kernel<br>
&gt;&gt;&gt;&gt;&gt;&gt; =A0 =A0 &gt; configuration to no avail.<br>
&gt;&gt;&gt;&gt;&gt;&gt; =A0 =A0 &gt; When I switch back to a timebase of 1=
 MHz, the MMC works fine.<br>
&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt; =A0 =A0 The thing is that we are a bit tight on AT=
91. A 16 bits counter is<br>
&gt;&gt;&gt;&gt;&gt; used<br>
&gt;&gt;&gt;&gt;&gt;&gt; =A0 =A0 for both the timer and the tsc emulation, =
and this tsc must be<br>
&gt;&gt;&gt;&gt;&gt; refreshed<br>
&gt;&gt;&gt;&gt;&gt;&gt; =A0 =A0 at least once before it wraps. The problem=
 is that since it is a<br>
&gt;&gt; 16<br>
&gt;&gt;&gt;&gt;&gt; bits<br>
&gt;&gt;&gt;&gt;&gt;&gt; =A0 =A0 counter, it wraps really fast, on my AT91S=
AM9263 it wraps in 20<br>
&gt;&gt; ms,<br>
&gt;&gt;&gt;&gt;&gt; and<br>
&gt;&gt;&gt;&gt;&gt;&gt; =A0 =A0 since the Linux default period is 10ms we =
are actually quite close<br>
&gt;&gt; to<br>
&gt;&gt;&gt;&gt;&gt;&gt; =A0 =A0 the limit.<br>
&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt; =A0 =A0 Anyway, trying to get a better accuracy th=
an 1us is kind of<br>
&gt;&gt; useless<br>
&gt;&gt;&gt;&gt;&gt; on<br>
&gt;&gt;&gt;&gt;&gt;&gt; =A0 =A0 AT91, since even reading this counter take=
s more than 1us. So, you<br>
&gt;&gt;&gt;&gt;&gt; are<br>
&gt;&gt;&gt;&gt;&gt;&gt; =A0 =A0 not in fact improving anything. The 1MHz i=
s even a bit overkill.<br>
&gt;&gt;&gt;&gt;&gt; On the other hand, the AT91SAM9G20 may be running at a=
 better<br>
&gt;&gt; frequency.<br>
&gt;&gt;&gt;&gt;&gt; But with latencies in the order of tens of microsecond=
s, having a<br>
&gt;&gt; better<br>
&gt;&gt;&gt;&gt;&gt; accuracy than 1us still does not make really much sens=
e.<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt; Why do you need<br>
&gt;&gt;&gt;&gt;&gt; this accuracy?<br>
&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; I want to time stamp the samples from a 8 channel SPI-base=
d ADC. I know<br>
&gt;&gt; that<br>
&gt;&gt;&gt;&gt; a conversion takes between 3 and 5 microseconds depending =
on the SPI<br>
&gt;&gt; clock.<br>
&gt;&gt;&gt;&gt; What I want is to adapt the code to acquire a fixed numb<b=
r>
&gt;&gt; er of samples in<br>
&gt;&gt;&gt;&gt; user space (I knew it was a long shot). Plain, Xenomai-fre=
e, userland<br>
&gt;&gt;&gt;&gt; application was out of the question, so I figured that a u=
serspace<br>
&gt;&gt;&gt;&gt; application in Xenomai run at highest priority should doan=
d the trick.<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; On a second thought, a simple linux kernel module is what =
I want (this<br>
&gt;&gt; way I<br>
&gt;&gt;&gt;&gt; can use interrupts and one of the platform&#39;s six timer=
s).<br>
&gt;&gt;&gt; You can use interrupts and the platform&#39;s six timers in a =
Xenomai driver<br>
&gt;&gt;&gt; based on the RTDM skin. The thing is, what interrupt latency i=
s your<br>
&gt;&gt; target?<br>
&gt;&gt; To make myself clear:<br>
&gt;&gt; you got:<br>
&gt;&gt; - the AD conversion (amounts for an unknown amount of time between=
 3 and<br>
&gt;&gt; 5us)<br>
&gt;&gt; - the SPI interrupt<br>
&gt;&gt; - some unknown interrupt latency which amouunts to several tens of=
<br>
&gt;&gt; microseconds with Xenomai, and to a few hundreds of microseconds w=
ith<br>
&gt;&gt; Linux.<br>
&gt;&gt; - the interrupt handler is invoked.<br>
&gt;&gt;<br>
&gt;<br>
&gt; What good will it make to have a timestamping precision with a<br>
&gt;&gt; sub-microsecond range in the interrupt handler code?<br>
&gt;&gt;<br>
&gt;&gt; --<br>
&gt;&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 Gilles.<br>
&gt;&gt;<br>
&gt;<br>
&gt; Rookie mistake. Indeed, I can have everything in userspace using Xenom=
ai. I<br>
&gt; wrote a simple program that did a periodic job every 100 us and the ji=
tter<br>
&gt; was very small (around 20 us without load and around 35 us with SSH-in=
g and<br>
&gt; Xenomai compilation running on board).<br>
&gt;<br>
&gt; Somewhat unrelated to this thread, I found that when I invoked<br>
&gt; rt_task_set_periodic(), I got very precise timings (as expected). Howe=
ver,<br>
&gt; when I tried to insert small delays using rt_timer_spin(), the errors<=
br>
&gt; (t_meas - t_spin_func_argument) were not large, but noticeable. For ex=
ample,<br>
&gt; I can precisely measure a 50 us periodic task on the scope. With the s=
ame<br>
&gt; interval in rt_timer_spin(), I get 55-60 us. As far as I understood, a=
ll<br>
&gt; timing-related functions use the same time base, so what&#39;s the rea=
son for<br>
&gt; this behavior?<br>
<br>
</div></div>=A0</blockquote><blockquote class=3D"gmail_quote" style=3D"marg=
in:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex;">Where do you us=
e rt_timer_spin, in kernel-space, or in user-space? </blockquote><div><br><=
/div>
<div>User space.</div><div>=A0</div><blockquote class=3D"gmail_quote" style=
=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex;">How<br>
long do you spin?<br>
<br></blockquote><div><br></div><div>50000 nsec.</div><div><br></div><div><=
br></div><div>R.</div><blockquote class=3D"gmail_quote" style=3D"margin:0 0=
 0 .8ex;border-left:1px #ccc solid;padding-left:1ex;">
</blockquote></div>

--e0cb4e70021b93ab0a049b7e00e7--

