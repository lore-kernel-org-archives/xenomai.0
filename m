MIME-Version: 1.0
In-Reply-To: <4978EEDC.6040307@domain.hid>
References: <8e2adebc0812311008j76d745f9r539a1b9108f8903d@domain.hid>
	<495BB5AE.1010805@domain.hid>
	<8e2adebc0901221104y18d09bb5l3d5645f77e4f42ed@domain.hid>
	<4978C5A1.4080302@domain.hid>
	<8e2adebc0901221408q3bd65bfeu29b7cfe8ce3bb05e@domain.hid>
	<4978EEDC.6040307@domain.hid>
Date: Fri, 23 Jan 2009 04:36:26 +0530
Message-ID: <8e2adebc0901221506y31e9930aq51e3b26fe4ce4e15@domain.hid>
From: Mandar Thite <mandarthite@domain.hid>
Content-Type: multipart/alternative; boundary=000e0cd2508862ef3c04611a5217
Subject: Re: [Xenomai-help] ARM I-pipe port to OMAP osk board
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai@xenomai.org

--000e0cd2508862ef3c04611a5217
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Hi Gilles,

I have a problem in following paragraph...

/**********
a function is expected to update the tsc area from time to time (at least
once before the underlying counter reaches the same value again, in order to
avoid losing some wrap arounds). If the free-running counter wraps fast, the
best place to do this is __ipipe_mach_acktimer. If the free-running counter
wraps slowly, doing this from Linux timer interrupt will reduce the timer
interrupt latency.
**********/

How do I decide if, for my platform, "free-running counter" wraps fast or
slow? Or iow, what does it depend upon?

On Fri, Jan 23, 2009 at 3:40 AM, Gilles Chanteperdrix <
gilles.chanteperdrix@xenomai.org> wrote:

> Mandar Thite wrote:
> > Hi again,
> > Platform specific code for "clock_event_device" timer initialization in
> > "arch/arm/mach-omap1/time.c" is starting the timer in "autoreload mode"
> as
> > per "HZ" value. Is this ok for functioning of I-pipe or needs a
> > modification(i mean should it be started in "one shot mode")?
> > Thanks. ---Mandar
>
> Xenomai requires one shot mode.
>
> --
>                                             Gilles.
>

--000e0cd2508862ef3c04611a5217
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi Gilles,<br><br>I have a problem in following paragraph...<br><br>/******=
****<br>a function is expected to update the tsc area from time to time (at
least once before the underlying counter reaches the same value again,
in order to avoid losing some wrap arounds). If the free-running
counter wraps fast, the best place to do this is __ipipe_mach_acktimer.
If the free-running counter wraps slowly, doing this from Linux timer
interrupt will reduce the timer interrupt latency.<br>**********/<br><br>Ho=
w do I decide if, for my platform,  &quot;free-running
counter&quot; wraps fast or slow? Or iow, what does it depend upon?<br><br>=
<div class=3D"gmail_quote">On Fri, Jan 23, 2009 at 3:40 AM, Gilles Chantepe=
rdrix <span dir=3D"ltr">&lt;<a href=3D"mailto:gilles.chanteperdrix@xenomai.org.=
org">gilles.chanteperdrix@xenomai.org</a>&gt;</span> wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"border-left: 1px solid rgb(204, =
204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;"><div class=3D"Ih2=
E3d">Mandar Thite wrote:<br>
&gt; Hi again,<br>
&gt; Platform specific code for &quot;clock_event_device&quot; timer initia=
lization in<br>
&gt; &quot;arch/arm/mach-omap1/time.c&quot; is starting the timer in &quot;=
autoreload mode&quot; as<br>
&gt; per &quot;HZ&quot; value. Is this ok for functioning of I-pipe or need=
s a<br>
&gt; modification(i mean should it be started in &quot;one shot mode&quot;)=
?<br>
&gt; Thanks. ---Mandar<br>
<br>
</div>Xenomai requires one shot mode.<br>
<br>
--<br>
<font color=3D"#888888"> &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &=
nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;=
 &nbsp; &nbsp; &nbsp; &nbsp;Gilles.<br>
</font></blockquote></div><br>

--000e0cd2508862ef3c04611a5217--

