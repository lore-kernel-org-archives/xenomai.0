MIME-Version: 1.0
In-Reply-To: <4D49CF24.9080700@domain.hid>
References: <AANLkTi=pm4BfNAwCzw-6HLOiKfJQmgMQdPmVXTcCBSBs@domain.hid>
	<4D49CF24.9080700@domain.hid>
Date: Wed, 2 Feb 2011 16:00:29 -0600
Message-ID: <AANLkTinaTVSJW1jQzn7+jbsQgNE+HAEOXLEK3LC0MoWR@mail.gmail.com>
From: at91_enthus <nwromania@domain.hid>
Content-Type: multipart/alternative; boundary=90e6ba6150dcfd80f9049b53c6b5
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

--90e6ba6150dcfd80f9049b53c6b5
Content-Type: text/plain; charset=ISO-8859-1

On Wed, Feb 2, 2011 at 3:39 PM, Gilles Chanteperdrix <
gilles.chanteperdrix@xenomai.org> wrote:

> at91_enthus wrote:
> > Hi.
> >
> > In order to get better accuracy with Xenomai, I modified the I-pipe
> > timebase (MCK divider) in arch/arm.mach-at91/at91_ipipe_time.c.
> > Unfortunately, I cannot mount the rootfs on the MMC, since the MMC
> > controller is no longer functioning. I tried to change TCx in kernel
> > configuration to no avail.
> > When I switch back to a timebase of 1 MHz, the MMC works fine.
>
> The thing is that we are a bit tight on AT91. A 16 bits counter is used
> for both the timer and the tsc emulation, and this tsc must be refreshed
> at least once before it wraps. The problem is that since it is a 16 bits
> counter, it wraps really fast, on my AT91SAM9263 it wraps in 20 ms, and
> since the Linux default period is 10ms we are actually quite close to
> the limit.
>
> Anyway, trying to get a better accuracy than 1us is kind of useless on
> AT91, since even reading this counter takes more than 1us. So, you are
> not in fact improving anything. The 1MHz is even a bit overkill.
>
> --
>                                                                 Gilles.
>


Thank you.

--90e6ba6150dcfd80f9049b53c6b5
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<br><br><div class=3D"gmail_quote">On Wed, Feb 2, 2011 at 3:39 PM, Gilles C=
hanteperdrix <span dir=3D"ltr">&lt;<a href=3D"mailto:gilles.chanteperdrix@xenomai.org=
enomai.org">gilles.chanteperdrix@xenomai.org</a>&gt;</span> wrote:<br><bloc=
kquote class=3D"gmail_quote" style=3D"margin: 0pt 0pt 0pt 0.8ex; border-lef=
t: 1px solid rgb(204, 204, 204); padding-left: 1ex;">
<div class=3D"im">at91_enthus wrote:<br>
&gt; Hi.<br>
&gt;<br>
&gt; In order to get better accuracy with Xenomai, I modified the I-pipe<br=
>
&gt; timebase (MCK divider) in arch/arm.mach-at91/at91_ipipe_time.c.<br>
&gt; Unfortunately, I cannot mount the rootfs on the MMC, since the MMC<br>
&gt; controller is no longer functioning. I tried to change TCx in kernel<b=
r>
&gt; configuration to no avail.<br>
&gt; When I switch back to a timebase of 1 MHz, the MMC works fine.<br>
<br>
</div>The thing is that we are a bit tight on AT91. A 16 bits counter is us=
ed<br>
for both the timer and the tsc emulation, and this tsc must be refreshed<br=
>
at least once before it wraps. The problem is that since it is a 16 bits<br=
>
counter, it wraps really fast, on my AT91SAM9263 it wraps in 20 ms, and<br>
since the Linux default period is 10ms we are actually quite close to<br>
the limit.<br>
<br>
Anyway, trying to get a better accuracy than 1us is kind of useless on<br>
AT91, since even reading this counter takes more than 1us. So, you are<br>
not in fact improving anything. The 1MHz is even a bit overkill.<br>
<br>
--<br>
<font color=3D"#888888"> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0Gilles.<br>
</font></blockquote></div><br><br>Thank you.<br>

--90e6ba6150dcfd80f9049b53c6b5--

