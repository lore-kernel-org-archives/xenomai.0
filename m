MIME-Version: 1.0
In-Reply-To: <4D49D608.5020006@domain.hid>
References: <AANLkTi=pm4BfNAwCzw-6HLOiKfJQmgMQdPmVXTcCBSBs@domain.hid>
	<4D49CF24.9080700@domain.hid>
	<AANLkTinaTVSJW1jQzn7+jbsQgNE+HAEOXLEK3LC0MoWR@mail.gmail.com>
	<4D49D608.5020006@domain.hid>
Date: Wed, 2 Feb 2011 16:22:16 -0600
Message-ID: <AANLkTinU4b-SY6Vy7=Ss+Nxrp-+qEZ6qsTudBsmrjbh_@domain.hid>
From: at91_enthus <nwromania@domain.hid>
Content-Type: multipart/alternative; boundary=0023543a2a04dec6b7049b541448
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

--0023543a2a04dec6b7049b541448
Content-Type: text/plain; charset=ISO-8859-1

On Wed, Feb 2, 2011 at 4:09 PM, Gilles Chanteperdrix <
gilles.chanteperdrix@xenomai.org> wrote:

> at91_enthus wrote:
> >
> >
> > On Wed, Feb 2, 2011 at 3:39 PM, Gilles Chanteperdrix
> > <gilles.chanteperdrix@xenomai.org
> > <mailto:gilles.chanteperdrix@xenomai.org>> wrote:
> >
> >     at91_enthus wrote:
> >     > Hi.
> >     >
> >     > In order to get better accuracy with Xenomai, I modified the I-pipe
> >     > timebase (MCK divider) in arch/arm.mach-at91/at91_ipipe_time.c.
> >     > Unfortunately, I cannot mount the rootfs on the MMC, since the MMC
> >     > controller is no longer functioning. I tried to change TCx in
> kernel
> >     > configuration to no avail.
> >     > When I switch back to a timebase of 1 MHz, the MMC works fine.
> >
> >     The thing is that we are a bit tight on AT91. A 16 bits counter is
> used
> >     for both the timer and the tsc emulation, and this tsc must be
> refreshed
> >     at least once before it wraps. The problem is that since it is a 16
> bits
> >     counter, it wraps really fast, on my AT91SAM9263 it wraps in 20 ms,
> and
> >     since the Linux default period is 10ms we are actually quite close to
> >     the limit.
> >
> >     Anyway, trying to get a better accuracy than 1us is kind of useless
> on
> >     AT91, since even reading this counter takes more than 1us. So, you
> are
> >     not in fact improving anything. The 1MHz is even a bit overkill.
>
> On the other hand, the AT91SAM9G20 may be running at a better frequency.
> But with latencies in the order of tens of microseconds, having a better
> accuracy than 1us still does not make really much sense.




> Why do you need
> this accuracy?
>

I want to time stamp the samples from a 8 channel SPI-based ADC. I know that
a conversion takes between 3 and 5 microseconds depending on the SPI clock.
What I want is to adapt the code to acquire a fixed number of samples in
user space (I knew it was a long shot). Plain, Xenomai-free, userland
application was out of the question, so I figured that a userspace
application in Xenomai run at highest priority should do the trick.

On a second thought, a simple linux kernel module is what I want (this way I
can use interrupts and one of the platform's six timers).

R.

--0023543a2a04dec6b7049b541448
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<br><br><div class=3D"gmail_quote">On Wed, Feb 2, 2011 at 4:09 PM, Gilles C=
hanteperdrix <span dir=3D"ltr">&lt;<a href=3D"mailto:gilles.chanteperdrix@xenomai.org=
enomai.org">gilles.chanteperdrix@xenomai.org</a>&gt;</span> wrote:<br><bloc=
kquote class=3D"gmail_quote" style=3D"margin: 0pt 0pt 0pt 0.8ex; border-lef=
t: 1px solid rgb(204, 204, 204); padding-left: 1ex;">
<div class=3D"im">at91_enthus wrote:<br>
&gt;<br>
&gt;<br>
&gt; On Wed, Feb 2, 2011 at 3:39 PM, Gilles Chanteperdrix<br>
&gt; &lt;<a href=3D"mailto:gilles.chanteperdrix@xenomai.org">gilles.chantep=
erdrix@domain.hid</a><br>
</div><div class=3D"im">&gt; &lt;mailto:<a href=3D"mailto:gilles.chanteperd=
rix@domain.hid">gilles.chanteperdrix@xenomai.org</a>&gt;&gt; wrote:<br>
&gt;<br>
&gt; =A0 =A0 at91_enthus wrote:<br>
&gt; =A0 =A0 &gt; Hi.<br>
&gt; =A0 =A0 &gt;<br>
&gt; =A0 =A0 &gt; In order to get better accuracy with Xenomai, I modified =
the I-pipe<br>
&gt; =A0 =A0 &gt; timebase (MCK divider) in arch/arm.mach-at91/at91_ipipe_t=
ime.c.<br>
&gt; =A0 =A0 &gt; Unfortunately, I cannot mount the rootfs on the MMC, sinc=
e the MMC<br>
&gt; =A0 =A0 &gt; controller is no longer functioning. I tried to change TC=
x in kernel<br>
&gt; =A0 =A0 &gt; configuration to no avail.<br>
&gt; =A0 =A0 &gt; When I switch back to a timebase of 1 MHz, the MMC works =
fine.<br>
&gt;<br>
&gt; =A0 =A0 The thing is that we are a bit tight on AT91. A 16 bits counte=
r is used<br>
&gt; =A0 =A0 for both the timer and the tsc emulation, and this tsc must be=
 refreshed<br>
&gt; =A0 =A0 at least once before it wraps. The problem is that since it is=
 a 16 bits<br>
&gt; =A0 =A0 counter, it wraps really fast, on my AT91SAM9263 it wraps in 2=
0 ms, and<br>
&gt; =A0 =A0 since the Linux default period is 10ms we are actually quite c=
lose to<br>
&gt; =A0 =A0 the limit.<br>
&gt;<br>
&gt; =A0 =A0 Anyway, trying to get a better accuracy than 1us is kind of us=
eless on<br>
&gt; =A0 =A0 AT91, since even reading this counter takes more than 1us. So,=
 you are<br>
&gt; =A0 =A0 not in fact improving anything. The 1MHz is even a bit overkil=
l.<br>
<br>
</div>On the other hand, the AT91SAM9G20 may be running at a better frequen=
cy.<br>
But with latencies in the order of tens of microseconds, having a better<br=
>
accuracy than 1us still does not make really much sense.</blockquote><div><=
br>=A0</div><blockquote class=3D"gmail_quote" style=3D"margin: 0pt 0pt 0pt =
0.8ex; border-left: 1px solid rgb(204, 204, 204); padding-left: 1ex;"> Why =
do you need<br>

this accuracy?<font color=3D"#888888"><br></font></blockquote><div>=A0</div=
></div>I want to time stamp the samples from a 8 channel SPI-based ADC. I k=
now that a conversion takes between 3 and 5 microseconds depending on the S=
PI clock. What I want is to adapt the code to acquire a fixed number of sam=
ples in user space (I knew it was a long shot). Plain, Xenomai-free, userla=
nd application was out of the question, so I figured that a userspace appli=
cation in Xenomai run at highest priority should do the trick. <br>
<br>On a second thought, a simple linux kernel module is what I want (this =
way I can use interrupts and one of the platform&#39;s six timers).<br><br>=
R.=A0 <br>

--0023543a2a04dec6b7049b541448--

