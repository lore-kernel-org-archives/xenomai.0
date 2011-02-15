MIME-Version: 1.0
In-Reply-To: <20101220154041.48C75CDE29A@gemini.denx.de>
References: <AANLkTikiCm5B-KwteOfzTwtCV8RXj1QFgfQCAmCCoC8V@mail.gmail.com>
	<20101220154041.48C75CDE29A@gemini.denx.de>
Date: Tue, 15 Feb 2011 10:22:16 +0100
Message-ID: <AANLkTi=C3FQ_Cms9qanmc1dgMgSvMC1Rrt-0X0tOPZMp@domain.hid>
From: Marten Lootsma <m.lootsma@domain.hid>
Content-Type: multipart/alternative; boundary=20cf3054a04951034e049c4eb3f1
Subject: Re: [Xenomai-help] Xenomai on Freescale iMX35
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Wolfgang Denk <wd@domain.hid>
Cc: xenomai@xenomai.org

--20cf3054a04951034e049c4eb3f1
Content-Type: text/plain; charset=ISO-8859-1

Dear Wolfgang Denk,

Thank you for your answer. If I understood correctly the Freescale kernel
development has been added to the mailline kernel tree:
http://opensource.freescale.com/git?p=imx/linux-2.6-imx.git;a=summary
http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=tree;f=arch/arm/mach-mx3;h=8021c7efda789b8fe5ae3e896b62ae125b231958;hb=795abaf1e4e188c4171e3cd3dbb11a9fcacaf505

Is this what you meant?

Can you inform me on the particular things that need to be done (or point me
to the information), and what is approximately the development time needed.

Thank you,
Marten Lootsma


On 20 December 2010 16:40, Wolfgang Denk <wd@domain.hid> wrote:

> Dear Marten Lootsma,
>
> In message <AANLkTikiCm5B-KwteOfzTwtCV8RXj1QFgfQCAmCCoC8V@mail.gmail.com>
> you wrote:
> >
> > We have a platform with a Freescale iMX35 processor and we would like to
> use
> > Xenomai. We have kernel versions 2.6.28 and 2.6.31 running (customized
> with
> > Freescale and our own patches for hardware support). I read that support
> is
> > included for the iMX31 and 51 which are closely related. In the trac I
> saw
> > some iMX35 related commits as well.
> >
> > 1. What is the status of the support for iMX35?
>
> Normally there is not support at all available for the LTIB kernels
> provided by Freescale.  Xenomai focusses on support for the mainline
> kernel tree.
>
> > 2. And if needed what is a good starting point for
> implementing/contributing
> > the port to iMX35?
>
> In the first step, support for the i.MX35 needs to be added for
> mainline Linux, and pushed upstream.
>
> [Please feel free to contact me if you need help doing this.]
>
> Best regards,
>
> Wolfgang Denk
>
> --
> DENX Software Engineering GmbH,     MD: Wolfgang Denk & Detlev Zundel
> HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
> Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@domain.hid
> "A fractal is by definition a set for which the Hausdorff Besicovitch
> dimension strictly exceeds the topological dimension."
> - Mandelbrot, _The Fractal Geometry of Nature_
>

--20cf3054a04951034e049c4eb3f1
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Dear Wolfgang Denk,<br><br>Thank you for your answer. If I understood corre=
ctly the Freescale kernel development has been added to the mailline kernel=
 tree:<br><a href=3D"http://opensource.freescale.com/git?p=3Dimx/linux-2.6-=
imx.git;a=3Dsummary">http://opensource.freescale.com/git?p=3Dimx/linux-2.6-=
imx.git;a=3Dsummary</a><br>
<a href=3D"http://git.kernel.org/?p=3Dlinux/kernel/git/torvalds/linux-2.6.g=
it;a=3Dtree;f=3Darch/arm/mach-mx3;h=3D8021c7efda789b8fe5ae3e896b62ae125b231=
958;hb=3D795abaf1e4e188c4171e3cd3dbb11a9fcacaf505">http://git.kernel.org/?p=
=3Dlinux/kernel/git/torvalds/linux-2.6.git;a=3Dtree;f=3Darch/arm/mach-mx3;h=
=3D8021c7efda789b8fe5ae3e896b62ae125b231958;hb=3D795abaf1e4e188c4171e3cd3db=
b11a9fcacaf505</a><br>
<br>Is this what you meant?<br><br>Can you inform me on the particular thin=
gs that need to be done (or point me to the information), and what is appro=
ximately the development time needed.<br><br>Thank you,<br>Marten Lootsma<b=
r>
<br><br><div class=3D"gmail_quote">On 20 December 2010 16:40, Wolfgang Denk=
 <span dir=3D"ltr">&lt;<a href=3D"mailto:wd@domain.hid">wd@domain.hid</a>&gt;</sp=
an> wrote:<br><blockquote class=3D"gmail_quote" style=3D"margin: 0pt 0pt 0p=
t 0.8ex; border-left: 1px solid rgb(204, 204, 204); padding-left: 1ex;">
Dear Marten Lootsma,<br>
<div class=3D"im"><br>
In message &lt;<a href=3D"mailto:AANLkTikiCm5B-KwteOfzTwtCV8RXj1QFgfQCAmCCo=
C8V@mail.gmail.com">AANLkTikiCm5B-KwteOfzTwtCV8RXj1QFgfQCAmCCoC8V@mail.gmai=
l.com</a>&gt; you wrote:<br>
&gt;<br>
&gt; We have a platform with a Freescale iMX35 processor and we would like =
to use<br>
&gt; Xenomai. We have kernel versions 2.6.28 and 2.6.31 running (customized=
 with<br>
&gt; Freescale and our own patches for hardware support). I read that suppo=
rt is<br>
&gt; included for the iMX31 and 51 which are closely related. In the trac I=
 saw<br>
&gt; some iMX35 related commits as well.<br>
&gt;<br>
&gt; 1. What is the status of the support for iMX35?<br>
<br>
</div>Normally there is not support at all available for the LTIB kernels<b=
r>
provided by Freescale. =A0Xenomai focusses on support for the mainline<br>
kernel tree.<br>
<div class=3D"im"><br>
&gt; 2. And if needed what is a good starting point for implementing/contri=
buting<br>
&gt; the port to iMX35?<br>
<br>
</div>In the first step, support for the i.MX35 needs to be added for<br>
mainline Linux, and pushed upstream.<br>
<br>
[Please feel free to contact me if you need help doing this.]<br>
<br>
Best regards,<br>
<br>
Wolfgang Denk<br>
<font color=3D"#888888"><br>
--<br>
DENX Software Engineering GmbH, =A0 =A0 MD: Wolfgang Denk &amp; Detlev Zund=
el<br>
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany<br>
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: <a href=3D"mailt=
o:wd@domain.hid">wd@domain.hid</a><br>
&quot;A fractal is by definition a set for which the Hausdorff Besicovitch<=
br>
dimension strictly exceeds the topological dimension.&quot;<br>
- Mandelbrot, _The Fractal Geometry of Nature_<br>
</font></blockquote></div><br>

--20cf3054a04951034e049c4eb3f1--

