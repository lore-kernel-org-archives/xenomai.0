MIME-Version: 1.0
In-Reply-To: <4C2D9FF0.3030502@domain.hid>
References: <22150A2C94CC924695BE248F94CD11F2CD0F@EXDB4.ug.kth.se>
	<4C2A518F.8030302@domain.hid>
	<22150A2C94CC924695BE248F94CD11F2CDC2@domain.hid>
	<4C2B0043.1070108@domain.hid>
	<AANLkTikdRdEXJd97HKlWzUmon8bu94n-ATNozWyOmTOu@domain.hid>
	<22150A2C94CC924695BE248F94CD11F2D063@domain.hid>
	<AANLkTinqA_l4Jersd-1EfCMecqal2ZkSepe5DhtQAEJ3@domain.hid>
	<4C2D9FF0.3030502@domain.hid>
Date: Fri, 2 Jul 2010 09:34:57 -0300
Message-ID: <AANLkTimVmtZIfQUWqmUhV2wygzMETn6sfBAy-ggnSpeS@mail.gmail.com>
From: =?ISO-8859-1?Q?Felipe_Brand=E3o_Cavalcanti?= <cavalkaf@domain.hid>
Content-Type: multipart/alternative; boundary=0016363b916497cf7a048a66d0f0
Subject: Re: [Xenomai-help] Xenomai and Gumstix Overo
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
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

--0016363b916497cf7a048a66d0f0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

2010/7/2 Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>

> Felipe Brand=E3o Cavalcanti wrote:
> > Sorry for the late reply.
> >
> > Anyway, I did enable Xenomai in the kernel itself, so no modules
> > involved - can't modprobe anything.
> >
> > As for the vanilla kernel, I've tried for a while to get it working
> > right on my board, but no luck. I am not sure if it has support to all
> > the peripherals, or if there is something that I am doing wrong (used
> > the defconfig, no modifications).
> >
> > I've edited the bitbake files for the kernel, but what I usually do is
> > to run the unpack script, replace the flush.c file, and keep the proces=
s
> > going. The defconfig is pretty much standard, except that I've enabled
> > several debugging options and got rid of a few troublesome pieces of
> > code (power management, CPU Freq. scaling, etc...). As for the edits,
> > they seem very similar to yours, but I didn't look at them very
> carefully.
> >
> > Fredrik, did you managed to get a kernel compiled at all?
>
> What about the EABI?
>

EABI is disabled in both the kernel-space and the user-space portion. Will
try with it later, just to be sure.


>
> --
>                                             Gilles.
>
>


--=20
      -Felipe Brand=E3o Cavalcanti
      LARA - Automation and Robotics Laboratory
      Department of Electrical Engineering
      UnB - University of Bras=EDlia, Brazil
      http://www.lara.unb.br/~fbcavalcanti/

--0016363b916497cf7a048a66d0f0
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

2010/7/2 Gilles Chanteperdrix <span dir=3D"ltr">&lt;<a href=3D"mailto:gille=
s.chanteperdrix@domain.hid">gilles.chanteperdrix@xenomai.org</a>&gt;</span=
><br><div class=3D"gmail_quote"><blockquote class=3D"gmail_quote" style=3D"=
border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; paddi=
ng-left: 1ex;">
<div class=3D"im">Felipe Brand=E3o Cavalcanti wrote:<br>
&gt; Sorry for the late reply.<br>
&gt;<br>
&gt; Anyway, I did enable Xenomai in the kernel itself, so no modules<br>
&gt; involved - can&#39;t modprobe anything.<br>
&gt;<br>
&gt; As for the vanilla kernel, I&#39;ve tried for a while to get it workin=
g<br>
&gt; right on my board, but no luck. I am not sure if it has support to all=
<br>
&gt; the peripherals, or if there is something that I am doing wrong (used<=
br>
&gt; the defconfig, no modifications).<br>
&gt;<br>
&gt; I&#39;ve edited the bitbake files for the kernel, but what I usually d=
o is<br>
&gt; to run the unpack script, replace the flush.c file, and keep the proce=
ss<br>
&gt; going. The defconfig is pretty much standard, except that I&#39;ve ena=
bled<br>
&gt; several debugging options and got rid of a few troublesome pieces of<b=
r>
&gt; code (power management, CPU Freq. scaling, etc...). As for the edits,<=
br>
&gt; they seem very similar to yours, but I didn&#39;t look at them very ca=
refully.<br>
&gt;<br>
&gt; Fredrik, did you managed to get a kernel compiled at all?<br>
<br>
</div>What about the EABI?<br></blockquote><div><br>EABI is disabled in bot=
h the kernel-space and the user-space portion. Will try with it later, just=
 to be sure.<br>=A0</div><blockquote class=3D"gmail_quote" style=3D"border-=
left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left=
: 1ex;">

<br>
--<br>
<font color=3D"#888888"> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0Gilles.<br>
<br>
</font></blockquote></div><br><br clear=3D"all"><br>-- <br> =A0 =A0 =A0 -Fe=
lipe Brand=E3o Cavalcanti<br> =A0 =A0 =A0 LARA - Automation and Robotics La=
boratory<br> =A0 =A0 =A0 Department of Electrical Engineering<br> =A0 =A0 =
=A0 UnB - University of Bras=EDlia, Brazil<br>
 =A0 =A0 =A0 <a href=3D"http://www.lara.unb.br/~fbcavalcanti/">http://www.l=
ara.unb.br/~fbcavalcanti/</a><br>

--0016363b916497cf7a048a66d0f0--

