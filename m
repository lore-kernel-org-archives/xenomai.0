MIME-Version: 1.0
In-Reply-To: <4B729B04.9010909@domain.hid>
References: <8b216e9e1002100327h3aa332ddl13ec590fcb81f0b7@domain.hid> 
	<4B729B04.9010909@domain.hid>
From: =?ISO-8859-1?Q?Felipe_Brand=E3o_Cavalcanti?= <cavalkaf@domain.hid>
Date: Wed, 10 Feb 2010 12:49:58 +0100
Message-ID: <8b216e9e1002100349y71f40d9ct9cbf496846f33f2e@domain.hid>
Content-Type: multipart/alternative; boundary=001636e0a72d687b41047f3da3cb
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

--001636e0a72d687b41047f3da3cb
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

2010/2/10 Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>

> Felipe Brand=E3o Cavalcanti wrote:
> > Hello,
> >
> > I am having some problems when trying to cross-compile the userspace
> portion
> > of the latest Xenomai (2.5.1) for ARM. I am attempting to get Xenomai
> > running on a IGEPv2 OMAP board (Beagleboard based), so I am
> cross-compiling
> > with bitbake on top of a poky Linux distribution.
>
> Do you have the same problem if you build Xenomai user-space portion
> running the standard build procedure without additional CFLAGS and LDFLAG=
S?
>
>
I have not tried this - the cross compiler automatically adds them, and I a=
m
not sure what I can remove. However, I will try removing them to see what
works. One thing that I noticed using the -k option in the make command is
that compiling fails only in the testsuite.

I found an old thread with a similar problem:
https://mail.gna.org/public/xenomai-help/2008-07/msg00141.html


>  --
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

--001636e0a72d687b41047f3da3cb
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<br><br><div class=3D"gmail_quote">2010/2/10 Gilles Chanteperdrix <span dir=
=3D"ltr">&lt;<a href=3D"mailto:gilles.chanteperdrix@xenomai.org">gil=
les.chanteperdrix@domain.hid</a>&gt;</span><br><blockquote class=3D=
"gmail_quote" style=3D"border-left: 1px solid rgb(204, 204, 204); margin: 0=
pt 0pt 0pt 0.8ex; padding-left: 1ex;">

<div class=3D"im">Felipe Brand=E3o Cavalcanti wrote:<br>
&gt; Hello,<br>
&gt;<br>
&gt; I am having some problems when trying to cross-compile the userspace p=
ortion<br>
&gt; of the latest Xenomai (2.5.1) for ARM. I am attempting to get Xenomai<=
br>
&gt; running on a IGEPv2 OMAP board (Beagleboard based), so I am cross-comp=
iling<br>
&gt; with bitbake on top of a poky Linux distribution.<br>
<br>
</div>Do you have the same problem if you build Xenomai user-space portion<=
br>
running the standard build procedure without additional CFLAGS and LDFLAGS?=
<br>
<font color=3D"#888888"><br></font></blockquote><div><br>I have not tried t=
his - the cross compiler automatically adds them, and I am not sure what I =
can remove. However, I will try removing them to see what works. One thing =
that I noticed using the -k option in the make command is that compiling fa=
ils only in the testsuite.<br>

<br>I found an old thread with a similar problem: <a href=3D"https://mail.g=
na.org/public/xenomai-help/2008-07/msg00141.html">https://mail.gna.org/publ=
ic/xenomai-help/2008-07/msg00141.html</a><br>=A0</div><blockquote class=3D"=
gmail_quote" style=3D"border-left: 1px solid rgb(204, 204, 204); margin: 0p=
t 0pt 0pt 0.8ex; padding-left: 1ex;">

<font color=3D"#888888">
--<br>
Gilles Chanteperdrix, Free Electrons<br>
Kernel, drivers, real-time and embedded Linux<br>
development, consulting, training and support.<br>
<a href=3D"http://free-electrons.com" target=3D"_blank">http://free-electro=
ns.com</a><br>
<br>
</font></blockquote></div><br><br clear=3D"all"><br>-- <br> =A0 =A0 =A0 -Fe=
lipe Brand=E3o Cavalcanti<br> =A0 =A0 =A0 LARA - Robotics and Automation La=
boratory<br> =A0 =A0 =A0 Department of Electrical Engineering<br> =A0 =A0 =
=A0 UnB - University of Bras=EDlia, Brazil<br>

 =A0 =A0 =A0 <a href=3D"http://www.lara.unb.br/~fbcavalcanti/">http://www.l=
ara.unb.br/~fbcavalcanti/</a><br>

--001636e0a72d687b41047f3da3cb--

