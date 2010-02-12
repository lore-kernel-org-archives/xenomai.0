MIME-Version: 1.0
In-Reply-To: <4B750157.6080000@domain.hid>
References: <8b216e9e1002100327h3aa332ddl13ec590fcb81f0b7@domain.hid> 
	<4B7447AD.5050401@domain.hid>
	<8b216e9e1002111024h7c87d0c1n9f36a91602e52cd6@domain.hid> 
	<4B744ED4.2000200@domain.hid>
	<8b216e9e1002111053gf6b4b2mf605e8c3b9f1c235@domain.hid> 
	<4B745CAB.5000404@domain.hid>
	<8b216e9e1002111215h1c1dac81w1a1ca1d19a37378c@domain.hid> 
	<4B746FFE.20204@domain.hid>
	<8b216e9e1002111430h5687cb9udfad3e08da08d83a@domain.hid> 
	<4B750157.6080000@domain.hid>
From: =?ISO-8859-1?Q?Felipe_Brand=E3o_Cavalcanti?= <cavalkaf@domain.hid>
Date: Fri, 12 Feb 2010 19:23:50 +0100
Message-ID: <8b216e9e1002121023qa0f4d6n33c773110cfc78fd@domain.hid>
Content-Type: multipart/alternative; boundary=00504502b08aaaf7bf047f6b5fb1
Subject: Re: [Xenomai-help] Problems when cross-compiling Xenomai
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: Xenomai help <xenomai@xenomai.org>

--00504502b08aaaf7bf047f6b5fb1
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Pardon my ignorance, but how do you apply the kernel patch?

Ive tried using the patch -p0 < /home/jdoe/Desktop/vanilla-igep-initial.dif=
f
command in the directory of the vanilla 2.6.30 kernel, but I get some
errors:

patching file b/arch/arm/configs/igep0020b_defconfig
can't find file to patch at input line 2093
Perhaps you used the wrong -p or --strip option?
The text leading up to this was:
--------------------------
|diff --git a/arch/arm/mach-omap2/Kconfig b/arch/arm/mach-omap2/Kconfig
|index aad194f..5677e7d 100644
|--- a/arch/arm/mach-omap2/Kconfig
|+++ b/arch/arm/mach-omap2/Kconfig
--------------------------

I am doing something wrong, or should I grab the kernel from the git
repository?

Thanks again for the help,
     -Felipe Brandao Cavalcanti

2010/2/12 Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>

> Felipe Brand=E3o Cavalcanti wrote:
> > 2010/2/11 Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org=
>
> >
> >> Felipe Brand=E3o Cavalcanti wrote:
> >>> 2010/2/11 Gilles Chanteperdrix <
> gilles.chanteperdrix@xenomai.org>
> >>>
> >>>> Felipe Brand=E3o Cavalcanti wrote:
> >>>>> 2010/2/11 Gilles Chanteperdrix <
> >> gilles.chanteperdrix@xenomai.org>
> >>>>>> Felipe Brand=E3o Cavalcanti wrote:
> >>>>>>> Sending the boot log and the xeno-test output as attachments.
> >>>>>> [    0.000000] OMAP clockevent source: GPTIMER12 at 32768 Hz
> >>>>>>
> >>>>>> Definitely not OK. We do not want this unprecise clockevent source=
.
> >>>>>> Disable it in the kernel configuration (option
> CONFIG_OMAP_32K_TIMER).
> >>>>>>
> >>>>>>
> >>>>> This is very interesting - this option doesnt seem to be set in my
> >>>> current
> >>>>> kernel config. Ive attached my .config.
> >>>> Selecting GPTIMER 1 should work. But if you get lockups or thing lik=
e
> >>>> that, please try with a vanilla 2.6.30 to see if you get them.
> >>>>
> >>>>
> >>> Great - changing GPTIMER to 1 did the trick! Gilles, thank you very
> much!
> >>>
> >>> Here are the results of the first latency test, under 100% load:
> >>>
> >>> RTT|  00:08:46  (periodic user-mode task, 1000 us period, priority 99=
)
> >>> RTH|----lat min|----lat avg|----lat max|-overrun|---msw|---lat
> best|--lat
> >>> worst
> >>> RTD|     12.999|     13.769|     18.846|       0|     0|     12.538|
> >>> 44.692
> >>> RTD|     13.076|     13.769|     20.692|       0|     0|     12.538|
> >>> 44.692
> >>> RTD|     12.923|     13.769|     18.076|       0|     0|     12.538|
> >>> 44.692
> >>> RTD|     12.846|     13.769|     20.153|       0|     0|     12.538|
> >>> 44.692
> >>> RTD|     12.999|     13.769|     18.692|       0|     0|     12.538|
> >>> 44.692
> >>> RTD|     12.999|     13.769|     19.230|       0|     0|     12.538|
> >>> 44.692
> >>> RTD|     13.076|     13.769|     18.769|       0|     0|     12.538|
> >>> 44.692
> >>> RTD|     13.076|     13.769|     19.153|       0|     0|     12.538|
> >>> 44.692
> >>> RTD|     12.846|     13.769|     19.999|       0|     0|     12.538|
> >>> 44.692
> >>>
> >>> BTW, the system does seem a lot more stable now - no random errors. I
> >> will
> >>> run some more tests, and will send in the results later - I will
> document
> >>> the procedure and post it online once we get Xenomai running well in
> the
> >>> IGEPv2.
> >> Ok. Good news. I would have liked to find out what was this building
> >> issue of yours, at least to be able to use your rootfs build system
> >> instead of building xenomai manually.
> >>
> >>
> > In the end, I did get it to work with my build system (bitbake, running
> on
> > the standard IGEP virtual machine) - I modified the configuration files
> so
> > the
> > ASNEEDED =3D "-Wl,--as-needed"
> > became
> > ASNEEDED =3D ""
>
> Could you try re-enabling --as-needed with the following patch?
>
> diff --git a/scripts/wrap-link.sh b/scripts/wrap-link.sh
> index f4826ac..09944f5 100755
> --- a/scripts/wrap-link.sh
> +++ b/scripts/wrap-link.sh
> @@ -34,7 +34,14 @@ add_linker_flag() {
>        stage1_args=3D"$stage1_args -Wl,--wrap $@"
>        next_is_wrapped_symbol=3Dfalse
>     else
> -       add_2stages "$@"
> +       case "$@" in
> +       *--as-needed*)
> +               stage2_args=3D"$stage2_args $@"
> +               ;;
> +       *)
> +               add_2stages "$@"
> +               ;;
> +       esac
>     fi
>  }
>
>
> >
> > Xenomai builds cleanly afterwards, even with the modified optimization
> > flags.
> > I am attaching the bitbake file I used for reference.
> >
> > The challenge is getting the IGEP running cleanly now - if the network =
is
> > connected, the systems becomes unstable and crashes randomly, and
> MMC/SDIO
> > (and therefore, Wifi) support is disabled. I am attempting to get the
> > patches individually from the folks at ISEE (the makers of the IGEP
> board)
> > so I can get a clean system running. I need a rock-solid system for thi=
s
> > project - our lab is building a small UAV, and the IGEP with Xenomai is
> > going to be the central controller.
>
> Ok. Please test the I-pipe patch for 2.6.30. In another mail which you
> may have missed, I sent you a patch which adds basic IGEP support to
> 2.6.32. You can probably use that patch to get basic IGEP support on
> 2.6.30. This is not a definitive solution, it is just a test to see if
> either something in the android kernel is incompatible with Xenomai, or
> if you are having a problem with the I-pipe patch for 2.6.28.
>
> --
> Gilles Chanteperdrix, Free Electrons
> Kernel, drivers, real-time and embedded Linux
> development, consulting, training and support.
> http://free-electrons.com
>
>


--=20
      -Felipe Brand=E3o Cavalcanti
      LARA - Robotics and Automation Laboratory
      Department of Electrical Engineering
      UnB - University of Bras=EDlia, Brazil
      http://www.lara.unb.br/~fbcavalcanti/

--00504502b08aaaf7bf047f6b5fb1
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Pardon my ignorance, but how do you apply the kernel patch?<br><br>Ive trie=
d using the patch -p0 &lt; /home/jdoe/Desktop/vanilla-igep-initial.diff com=
mand in the directory of the vanilla 2.6.30 kernel, but I get some errors:<=
br>

<br>patching file b/arch/arm/configs/igep0020b_defconfig<br>can&#39;t find =
file to patch at input line 2093<br>Perhaps you used the wrong -p or --stri=
p option?<br>The text leading up to this was:<br>--------------------------=
<br>

|diff --git a/arch/arm/mach-omap2/Kconfig b/arch/arm/mach-omap2/Kconfig<br>=
|index aad194f..5677e7d 100644<br>|--- a/arch/arm/mach-omap2/Kconfig<br>|++=
+ b/arch/arm/mach-omap2/Kconfig<br>--------------------------<br><br>I am d=
oing something wrong, or should I grab the kernel from the git repository?<=
br>

<br>Thanks again for the help,<br>=A0=A0=A0=A0 -Felipe Brandao Cavalcanti<b=
r><br><div class=3D"gmail_quote">2010/2/12 Gilles Chanteperdrix <span dir=
=3D"ltr">&lt;<a href=3D"mailto:gilles.chanteperdrix@xenomai.org">gil=
les.chanteperdrix@domain.hid</a>&gt;</span><br>

<blockquote class=3D"gmail_quote" style=3D"border-left: 1px solid rgb(204, =
204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;"><div><div></div><=
div class=3D"h5">Felipe Brand=E3o Cavalcanti wrote:<br>
&gt; 2010/2/11 Gilles Chanteperdrix &lt;<a href=3D"mailto:gilles.chanteperd=
rix@domain.hid">gilles.chanteperdrix@xenomai.org</a>&gt;<br>
&gt;<br>
&gt;&gt; Felipe Brand=E3o Cavalcanti wrote:<br>
&gt;&gt;&gt; 2010/2/11 Gilles Chanteperdrix &lt;<a href=3D"mailto:gilles.ch=
anteperdrix@domain.hid">gilles.chanteperdrix@xenomai.org</a>=
&gt;<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; Felipe Brand=E3o Cavalcanti wrote:<br>
&gt;&gt;&gt;&gt;&gt; 2010/2/11 Gilles Chanteperdrix &lt;<br>
&gt;&gt; <a href=3D"mailto:gilles.chanteperdrix@xenomai.org">gilles.=
chanteperdrix@domain.hid</a>&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt; Felipe Brand=E3o Cavalcanti wrote:<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt; Sending the boot log and the xeno-test output =
as attachments.<br>
&gt;&gt;&gt;&gt;&gt;&gt; [ =A0 =A00.000000] OMAP clockevent source: GPTIMER=
12 at 32768 Hz<br>
&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt; Definitely not OK. We do not want this unprecise c=
lockevent source.<br>
&gt;&gt;&gt;&gt;&gt;&gt; Disable it in the kernel configuration (option CON=
FIG_OMAP_32K_TIMER).<br>
&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt; This is very interesting - this option doesnt seem to =
be set in my<br>
&gt;&gt;&gt;&gt; current<br>
&gt;&gt;&gt;&gt;&gt; kernel config. Ive attached my .config.<br>
&gt;&gt;&gt;&gt; Selecting GPTIMER 1 should work. But if you get lockups or=
 thing like<br>
&gt;&gt;&gt;&gt; that, please try with a vanilla 2.6.30 to see if you get t=
hem.<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt; Great - changing GPTIMER to 1 did the trick! Gilles, thank you=
 very much!<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; Here are the results of the first latency test, under 100% loa=
d:<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; RTT| =A000:08:46 =A0(periodic user-mode task, 1000 us period, =
priority 99)<br>
&gt;&gt;&gt; RTH|----lat min|----lat avg|----lat max|-overrun|---msw|---lat=
 best|--lat<br>
&gt;&gt;&gt; worst<br>
&gt;&gt;&gt; RTD| =A0 =A0 12.999| =A0 =A0 13.769| =A0 =A0 18.846| =A0 =A0 =
=A0 0| =A0 =A0 0| =A0 =A0 12.538|<br>
&gt;&gt;&gt; 44.692<br>
&gt;&gt;&gt; RTD| =A0 =A0 13.076| =A0 =A0 13.769| =A0 =A0 20.692| =A0 =A0 =
=A0 0| =A0 =A0 0| =A0 =A0 12.538|<br>
&gt;&gt;&gt; 44.692<br>
&gt;&gt;&gt; RTD| =A0 =A0 12.923| =A0 =A0 13.769| =A0 =A0 18.076| =A0 =A0 =
=A0 0| =A0 =A0 0| =A0 =A0 12.538|<br>
&gt;&gt;&gt; 44.692<br>
&gt;&gt;&gt; RTD| =A0 =A0 12.846| =A0 =A0 13.769| =A0 =A0 20.153| =A0 =A0 =
=A0 0| =A0 =A0 0| =A0 =A0 12.538|<br>
&gt;&gt;&gt; 44.692<br>
&gt;&gt;&gt; RTD| =A0 =A0 12.999| =A0 =A0 13.769| =A0 =A0 18.692| =A0 =A0 =
=A0 0| =A0 =A0 0| =A0 =A0 12.538|<br>
&gt;&gt;&gt; 44.692<br>
&gt;&gt;&gt; RTD| =A0 =A0 12.999| =A0 =A0 13.769| =A0 =A0 19.230| =A0 =A0 =
=A0 0| =A0 =A0 0| =A0 =A0 12.538|<br>
&gt;&gt;&gt; 44.692<br>
&gt;&gt;&gt; RTD| =A0 =A0 13.076| =A0 =A0 13.769| =A0 =A0 18.769| =A0 =A0 =
=A0 0| =A0 =A0 0| =A0 =A0 12.538|<br>
&gt;&gt;&gt; 44.692<br>
&gt;&gt;&gt; RTD| =A0 =A0 13.076| =A0 =A0 13.769| =A0 =A0 19.153| =A0 =A0 =
=A0 0| =A0 =A0 0| =A0 =A0 12.538|<br>
&gt;&gt;&gt; 44.692<br>
&gt;&gt;&gt; RTD| =A0 =A0 12.846| =A0 =A0 13.769| =A0 =A0 19.999| =A0 =A0 =
=A0 0| =A0 =A0 0| =A0 =A0 12.538|<br>
&gt;&gt;&gt; 44.692<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; BTW, the system does seem a lot more stable now - no random er=
rors. I<br>
&gt;&gt; will<br>
&gt;&gt;&gt; run some more tests, and will send in the results later - I wi=
ll document<br>
&gt;&gt;&gt; the procedure and post it online once we get Xenomai running w=
ell in the<br>
&gt;&gt;&gt; IGEPv2.<br>
&gt;&gt; Ok. Good news. I would have liked to find out what was this buildi=
ng<br>
&gt;&gt; issue of yours, at least to be able to use your rootfs build syste=
m<br>
&gt;&gt; instead of building xenomai manually.<br>
&gt;&gt;<br>
&gt;&gt;<br>
&gt; In the end, I did get it to work with my build system (bitbake, runnin=
g on<br>
&gt; the standard IGEP virtual machine) - I modified the configuration file=
s so<br>
&gt; the<br>
&gt; ASNEEDED =3D &quot;-Wl,--as-needed&quot;<br>
&gt; became<br>
&gt; ASNEEDED =3D &quot;&quot;<br>
<br>
</div></div>Could you try re-enabling --as-needed with the following patch?=
<br>
<br>
diff --git a/scripts/wrap-link.sh b/scripts/wrap-link.sh<br>
index f4826ac..09944f5 100755<br>
--- a/scripts/wrap-link.sh<br>
+++ b/scripts/wrap-link.sh<br>
@@ -34,7 +34,14 @@ add_linker_flag() {<br>
 =A0 =A0 =A0 =A0stage1_args=3D&quot;$stage1_args -Wl,--wrap $@&quot;<br>
 =A0 =A0 =A0 =A0next_is_wrapped_symbol=3Dfalse<br>
 =A0 =A0 else<br>
- =A0 =A0 =A0 add_2stages &quot;$@&quot;<br>
+ =A0 =A0 =A0 case &quot;$@&quot; in<br>
+ =A0 =A0 =A0 *--as-needed*)<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 stage2_args=3D&quot;$stage2_args $@&quot;<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 ;;<br>
+ =A0 =A0 =A0 *)<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 add_2stages &quot;$@&quot;<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 ;;<br>
+ =A0 =A0 =A0 esac<br>
 =A0 =A0 fi<br>
<div class=3D"im">=A0}<br>
<br>
<br>
&gt;<br>
&gt; Xenomai builds cleanly afterwards, even with the modified optimization=
<br>
&gt; flags.<br>
&gt; I am attaching the bitbake file I used for reference.<br>
&gt;<br>
&gt; The challenge is getting the IGEP running cleanly now - if the network=
 is<br>
&gt; connected, the systems becomes unstable and crashes randomly, and MMC/=
SDIO<br>
&gt; (and therefore, Wifi) support is disabled. I am attempting to get the<=
br>
&gt; patches individually from the folks at ISEE (the makers of the IGEP bo=
ard)<br>
&gt; so I can get a clean system running. I need a rock-solid system for th=
is<br>
&gt; project - our lab is building a small UAV, and the IGEP with Xenomai i=
s<br>
&gt; going to be the central controller.<br>
<br>
</div>Ok. Please test the I-pipe patch for 2.6.30. In another mail which yo=
u<br>
may have missed, I sent you a patch which adds basic IGEP support to<br>
2.6.32. You can probably use that patch to get basic IGEP support on<br>
2.6.30. This is not a definitive solution, it is just a test to see if<br>
either something in the android kernel is incompatible with Xenomai, or<br>
if you are having a problem with the I-pipe patch for 2.6.28.<br>
<font color=3D"#888888"><br>
--<br>
</font><div><div></div><div class=3D"h5">Gilles Chanteperdrix, Free Electro=
ns<br>
Kernel, drivers, real-time and embedded Linux<br>
development, consulting, training and support.<br>
<a href=3D"http://free-electrons.com" target=3D"_blank">http://free-electro=
ns.com</a><br>
<br>
</div></div></blockquote></div><br><br clear=3D"all"><br>-- <br> =A0 =A0 =
=A0 -Felipe Brand=E3o Cavalcanti<br> =A0 =A0 =A0 LARA - Robotics and Automa=
tion Laboratory<br> =A0 =A0 =A0 Department of Electrical Engineering<br> =
=A0 =A0 =A0 UnB - University of Bras=EDlia, Brazil<br>

 =A0 =A0 =A0 <a href=3D"http://www.lara.unb.br/~fbcavalcanti/">http://www.l=
ara.unb.br/~fbcavalcanti/</a><br>

--00504502b08aaaf7bf047f6b5fb1--

