MIME-Version: 1.0
In-Reply-To: <22150A2C94CC924695BE248F94CD11F2D375@domain.hid>
References: <22150A2C94CC924695BE248F94CD11F2CD0F@EXDB4.ug.kth.se>
	<4C2A518F.8030302@domain.hid>
	<22150A2C94CC924695BE248F94CD11F2CDC2@domain.hid>
	<4C2B0043.1070108@domain.hid>
	<AANLkTikdRdEXJd97HKlWzUmon8bu94n-ATNozWyOmTOu@domain.hid>
	<22150A2C94CC924695BE248F94CD11F2D063@domain.hid>
	<AANLkTinqA_l4Jersd-1EfCMecqal2ZkSepe5DhtQAEJ3@domain.hid>
	<22150A2C94CC924695BE248F94CD11F2D27F@EXDB4.ug.kth.se>
	<22150A2C94CC924695BE248F94CD11F2D375@domain.hid>
Date: Fri, 2 Jul 2010 09:35:59 -0300
Message-ID: <AANLkTim_SammJL0EU9GG_68dlOLX8XlU-pY_h7gyyNuR@mail.gmail.com>
From: =?ISO-8859-1?Q?Felipe_Brand=E3o_Cavalcanti?= <cavalkaf@domain.hid>
Content-Type: multipart/alternative; boundary=0016363b91644d7bae048a66d495
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
To: Fredrik Asplund <fasplund@domain.hid>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

--0016363b91644d7bae048a66d495
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

2010/7/2 Fredrik Asplund <fasplund@domain.hid>

> >>I've edited the bitbake files for the kernel, but what I usually do is =
to
> >>run the unpack script, replace the flush.c file, and keep the process
> going.
> >>The defconfig is pretty much standard, except that I've enabled several
> >>debugging options and got rid of a few troublesome pieces of code (powe=
r
> >>management, CPU Freq. scaling, etc...). As for the edits, they seem ver=
y
> >>similar to yours, but I didn't look at them very carefully.
> >>Fredrik, did you managed to get a kernel compiled at all?
> >
> >Yes, no problems in compiling, but I have not yet had the time to actual=
ly
> run the resulting image. I will >check where my setup crashes (no doubt i=
t
> will... :/) and compare our files to see if I can figure something >out.
>
> Now I had time to test the resulting image. It boots up without obvious
> problems and does not seem to be unstable over time either.
>
> However, I am unsure of how to test if Xenomai *actually* works (I found
> xeno-test in /usr/bin/, but I am unsure of how to judge the output... the=
re
> does not seem to be any ERROR messages in it though). Anyone who can tell=
 me
> how to do this?
>
> (BTW - I will add a description on what I did + the files to my project
> wiki. I will send you a link when it is done, sometime this weekend I
> guess...)
>
>
Great! Can you send me the uImage for testing?


> / Fredrik
>



--=20
      -Felipe Brand=E3o Cavalcanti
      LARA - Automation and Robotics Laboratory
      Department of Electrical Engineering
      UnB - University of Bras=EDlia, Brazil
      http://www.lara.unb.br/~fbcavalcanti/

--0016363b91644d7bae048a66d495
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<br><br><div class=3D"gmail_quote">2010/7/2 Fredrik Asplund <span dir=3D"lt=
r">&lt;<a href=3D"mailto:fasplund@domain.hid">fasplund@domain.hid</a>&gt;</span><br=
><blockquote class=3D"gmail_quote" style=3D"border-left: 1px solid rgb(204,=
 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
<div><div></div><div class=3D"h5">&gt;&gt;I&#39;ve edited the bitbake files=
 for the kernel, but what I usually do is to<br>
&gt;&gt;run the unpack script, replace the flush.c file, and keep the proce=
ss going.<br>
&gt;&gt;The defconfig is pretty much standard, except that I&#39;ve enabled=
 several<br>
&gt;&gt;debugging options and got rid of a few troublesome pieces of code (=
power<br>
&gt;&gt;management, CPU Freq. scaling, etc...). As for the edits, they seem=
 very<br>
&gt;&gt;similar to yours, but I didn&#39;t look at them very carefully.<br>
&gt;&gt;Fredrik, did you managed to get a kernel compiled at all?<br>
&gt;<br>
&gt;Yes, no problems in compiling, but I have not yet had the time to actua=
lly run the resulting image. I will &gt;check where my setup crashes (no do=
ubt it will... :/) and compare our files to see if I can figure something &=
gt;out.<br>

<br>
</div></div>Now I had time to test the resulting image. It boots up without=
 obvious problems and does not seem to be unstable over time either.<br>
<br>
However, I am unsure of how to test if Xenomai *actually* works (I found xe=
no-test in /usr/bin/, but I am unsure of how to judge the output... there d=
oes not seem to be any ERROR messages in it though). Anyone who can tell me=
 how to do this?<br>

<br>
(BTW - I will add a description on what I did + the files to my project wik=
i. I will send you a link when it is done, sometime this weekend I guess...=
)<br>
<font color=3D"#888888"><br></font></blockquote><div><br>Great! Can you sen=
d me the uImage for testing?<br>=A0</div><blockquote class=3D"gmail_quote" =
style=3D"border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8=
ex; padding-left: 1ex;">
<font color=3D"#888888">
/ Fredrik<br>
</font></blockquote></div><br><br clear=3D"all"><br>-- <br> =A0 =A0 =A0 -Fe=
lipe Brand=E3o Cavalcanti<br> =A0 =A0 =A0 LARA - Automation and Robotics La=
boratory<br> =A0 =A0 =A0 Department of Electrical Engineering<br> =A0 =A0 =
=A0 UnB - University of Bras=EDlia, Brazil<br>
 =A0 =A0 =A0 <a href=3D"http://www.lara.unb.br/~fbcavalcanti/">http://www.l=
ara.unb.br/~fbcavalcanti/</a><br>

--0016363b91644d7bae048a66d495--

