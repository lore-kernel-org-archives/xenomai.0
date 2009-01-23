MIME-Version: 1.0
In-Reply-To: <4979920B.7050104@domain.hid>
References: <8e2adebc0812311008j76d745f9r539a1b9108f8903d@domain.hid>
	<495BB5AE.1010805@domain.hid>
	<8e2adebc0901221104y18d09bb5l3d5645f77e4f42ed@domain.hid>
	<4978C5A1.4080302@domain.hid>
	<8e2adebc0901221408q3bd65bfeu29b7cfe8ce3bb05e@domain.hid>
	<4978EEDC.6040307@domain.hid>
	<8e2adebc0901221506y31e9930aq51e3b26fe4ce4e15@domain.hid>
	<4979920B.7050104@domain.hid>
Date: Fri, 23 Jan 2009 21:07:39 +0530
Message-ID: <8e2adebc0901230737w5ea5d4acl33a9876d5de0653d@domain.hid>
From: Mandar Thite <mandarthite@domain.hid>
Content-Type: multipart/alternative; boundary=000e0cd28c0642baea0461282be7
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

--000e0cd28c0642baea0461282be7
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Hello,
Let me first express my sincere apologies to Gilles, Philippe and everyone
contributing to this mailing list, for inadvertently making a nuisance of
myself.

Not that I don't have clear theoretical aspects, but I might have mistaken
in putting the question in right manner, for, being a newcomer to this area.
Please forgive me for that. Henceforth, I will certainly make it a point to
think twice before posting to the list.

Thanks.
-Mandar

On Fri, Jan 23, 2009 at 3:16 PM, Philippe Gerum <rpm@xenomai.org> wrote:

> Mandar Thite wrote:
> > Hi Gilles,
> >
> > I have a problem in following paragraph...
> >
> > /**********
> > a function is expected to update the tsc area from time to time (at
> > least once before the underlying counter reaches the same value again,
> > in order to avoid losing some wrap arounds). If the free-running counter
> > wraps fast, the best place to do this is __ipipe_mach_acktimer. If the
> > free-running counter wraps slowly, doing this from Linux timer interrupt
> > will reduce the timer interrupt latency.
> > **********/
> >
> > How do I decide if, for my platform, "free-running counter" wraps fast
> > or slow? Or iow, what does it depend upon?
> >
>
> If you need someone to explain what a free running counter is, or why a
> timer-related counter may wrap fast or slow, then I'm afraid there is no
> way you
> could achieve your port before hell freezes. Make everyone a favor, do your
> homework first, please.
>
> Besides, the least you could do is attaching your code since you want
> people to
> help with it. A good practice is to send the current state of your work as
> a
> patch with your initial question so that people understand where you are at
> this
> point, then update the list with improved releases of this work from time
> to
> time, as progress is made. This would clear a rather irritating feeling we
> have
> that you are offloading your work to the list.
>
> > On Fri, Jan 23, 2009 at 3:40 AM, Gilles Chanteperdrix
> > <gilles.chanteperdrix@xenomai.org
> > <mailto:gilles.chanteperdrix@xenomai.org>> wrote:
> >
> >     Mandar Thite wrote:
> >     > Hi again,
> >     > Platform specific code for "clock_event_device" timer
> >     initialization in
> >     > "arch/arm/mach-omap1/time.c" is starting the timer in "autoreload
> >     mode" as
> >     > per "HZ" value. Is this ok for functioning of I-pipe or needs a
> >     > modification(i mean should it be started in "one shot mode")?
> >     > Thanks. ---Mandar
> >
> >     Xenomai requires one shot mode.
> >
> >     --
> >                                                Gilles.
> >
> >
> >
> > ------------------------------------------------------------------------
> >
> > _______________________________________________
> > Xenomai-help mailing list
> > Xenomai-help@domain.hid
> > https://mail.gna.org/listinfo/xenomai-help
>
>
> --
> Philippe.
>

--000e0cd28c0642baea0461282be7
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hello,<br>Let me first express my sincere apologies to Gilles, Philippe and=
 everyone contributing to this mailing list, for inadvertently making a nui=
sance of myself.<br><br>Not that I don&#39;t have clear theoretical aspects=
, but I might have mistaken in putting the question in right manner, for, b=
eing a newcomer to this area. Please forgive me for that. Henceforth, I wil=
l certainly make it a point to think twice before posting to the list.<br>
<br>Thanks.<br>-Mandar<br><br><div class=3D"gmail_quote">On Fri, Jan 23, 20=
09 at 3:16 PM, Philippe Gerum <span dir=3D"ltr">&lt;<a href=3D"mailto:rpm@xenomai.org=
enomai.org">rpm@xenomai.org</a>&gt;</span> wrote:<br><blockquote class=3D"g=
mail_quote" style=3D"border-left: 1px solid rgb(204, 204, 204); margin: 0pt=
 0pt 0pt 0.8ex; padding-left: 1ex;">
<div class=3D"Ih2E3d">Mandar Thite wrote:<br>
&gt; Hi Gilles,<br>
&gt;<br>
&gt; I have a problem in following paragraph...<br>
&gt;<br>
&gt; /**********<br>
&gt; a function is expected to update the tsc area from time to time (at<br=
>
&gt; least once before the underlying counter reaches the same value again,=
<br>
&gt; in order to avoid losing some wrap arounds). If the free-running count=
er<br>
&gt; wraps fast, the best place to do this is __ipipe_mach_acktimer. If the=
<br>
&gt; free-running counter wraps slowly, doing this from Linux timer interru=
pt<br>
&gt; will reduce the timer interrupt latency.<br>
&gt; **********/<br>
&gt;<br>
&gt; How do I decide if, for my platform, &quot;free-running counter&quot; =
wraps fast<br>
&gt; or slow? Or iow, what does it depend upon?<br>
&gt;<br>
<br>
</div>If you need someone to explain what a free running counter is, or why=
 a<br>
timer-related counter may wrap fast or slow, then I&#39;m afraid there is n=
o way you<br>
could achieve your port before hell freezes. Make everyone a favor, do your=
<br>
homework first, please.<br>
<br>
Besides, the least you could do is attaching your code since you want peopl=
e to<br>
help with it. A good practice is to send the current state of your work as =
a<br>
patch with your initial question so that people understand where you are at=
 this<br>
point, then update the list with improved releases of this work from time t=
o<br>
time, as progress is made. This would clear a rather irritating feeling we =
have<br>
that you are offloading your work to the list.<br>
<div class=3D"Ih2E3d"><br>
&gt; On Fri, Jan 23, 2009 at 3:40 AM, Gilles Chanteperdrix<br>
&gt; &lt;<a href=3D"mailto:gilles.chanteperdrix@xenomai.org">gilles.chantep=
erdrix@domain.hid</a><br>
</div><div class=3D"Ih2E3d">&gt; &lt;mailto:<a href=3D"mailto:gilles.chante=
perdrix@domain.hid">gilles.chanteperdrix@xenomai.org</a>&gt;&gt; wrote:<br=
>
&gt;<br>
&gt; &nbsp; &nbsp; Mandar Thite wrote:<br>
&gt; &nbsp; &nbsp; &gt; Hi again,<br>
&gt; &nbsp; &nbsp; &gt; Platform specific code for &quot;clock_event_device=
&quot; timer<br>
&gt; &nbsp; &nbsp; initialization in<br>
&gt; &nbsp; &nbsp; &gt; &quot;arch/arm/mach-omap1/time.c&quot; is starting =
the timer in &quot;autoreload<br>
&gt; &nbsp; &nbsp; mode&quot; as<br>
&gt; &nbsp; &nbsp; &gt; per &quot;HZ&quot; value. Is this ok for functionin=
g of I-pipe or needs a<br>
&gt; &nbsp; &nbsp; &gt; modification(i mean should it be started in &quot;o=
ne shot mode&quot;)?<br>
&gt; &nbsp; &nbsp; &gt; Thanks. ---Mandar<br>
&gt;<br>
&gt; &nbsp; &nbsp; Xenomai requires one shot mode.<br>
&gt;<br>
&gt; &nbsp; &nbsp; --<br>
&gt; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; =
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp=
; &nbsp; &nbsp; &nbsp;Gilles.<br>
&gt;<br>
&gt;<br>
&gt;<br>
</div>&gt; ----------------------------------------------------------------=
--------<br>
&gt;<br>
&gt; _______________________________________________<br>
&gt; Xenomai-help mailing list<br>
&gt; <a href=3D"mailto:Xenomai-help@domain.hid">Xenomai-help@domain.hid</a><br>
&gt; <a href=3D"https://mail.gna.org/listinfo/xenomai-help" target=3D"_blan=
k">https://mail.gna.org/listinfo/xenomai-help</a><br>
<br>
<br>
--<br>
<font color=3D"#888888">Philippe.<br>
</font></blockquote></div><br>

--000e0cd28c0642baea0461282be7--

