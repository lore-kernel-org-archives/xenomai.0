MIME-Version: 1.0
In-Reply-To: <CAODUr7sPaWd8TZcGORicCAkHPJTdpnmec6YQJ-5SgEF79Y9AMw@domain.hid>
References: <CAODUr7sPaWd8TZcGORicCAkHPJTdpnmec6YQJ-5SgEF79Y9AMw@domain.hid>
Date: Wed, 24 Aug 2011 09:15:30 +0200
Message-ID: <CAKvQZ_3OrpDTQyZPmrZQVb8yHTdMnb1KjcQWWwwPUOrLi--XNw@domain.hid>
From: Willy Lambert <lambert.willy@domain.hid>
Content-Type: multipart/alternative; boundary=0016363b8e66c81ac204ab3b13e4
Subject: Re: [Xenomai-help] Help with hardware usage
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Luis Rossi <luisf.rossi@domain.hid>
Cc: xenomai@xenomai.org

--0016363b8e66c81ac204ab3b13e4
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

2011/8/24 Luis Rossi <luisf.rossi@domain.hid>

> Hi, i need to run a Xenomai on a Atom processor (PC/104+). My problem is
> that i have just 2GB solid state memory on my board. I was trying to emul=
ate
> the building process on a virtual machine here (a I7 processor) but
> installing a very basic Debian (about 500K of vemory usage), an them
> building the kernel, consumed my whole memory (i limited the VM to 2GB)..=
. 2
> questions.. is there anything i can do to reduce the hardware memory
> consumed during the kernel build with Xenomai? Second.. is it possible to
> build a kernel to another different computer? I mean i could build the
> kernel here on my I7 and them just install it on the Atom.. but how shoul=
d i
> do that?
>
> Thank you!
>
>
Hi,

This is not a xenomai related question. I think this is a general linux
question. I highly suggest you don't compile on you target as it will be
slow and is maybe not possible due to the limited RAM you have (first of al=
l
use "-j1" or CONCURRENCY_BUILD=3D1 depending of the way you build the kerne=
l.

As you have 2 x86 processor you don't even have to cross compile so if you
build the kernel with debian packages on your i7 they'll run on your target
Atom. But care about your .config that will be different.



> --
> Lu=EDs Filipe Rossi
> Electrical Engineer
> Biomechatronics Lab. / Grupo de Sensores Integr=E1veis e Sistemas
> Escola Polit=E9cnica
> Universidade de S=E3o Paulo
> Cel. +55 (11) 7662-9234
>
>
> _______________________________________________
> Xenomai-help mailing list
> Xenomai-help@domain.hid
> https://mail.gna.org/listinfo/xenomai-help
>
>

--0016363b8e66c81ac204ab3b13e4
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<br><br><div class=3D"gmail_quote">2011/8/24 Luis Rossi <span dir=3D"ltr">&=
lt;<a href=3D"mailto:luisf.rossi@domain.hid">luisf.rossi@domain.hid</a>&gt;</=
span><br><blockquote class=3D"gmail_quote" style=3D"margin: 0pt 0pt 0pt 0.8=
ex; border-left: 1px solid rgb(204, 204, 204); padding-left: 1ex;">
Hi, i need to run a Xenomai on a Atom processor (PC/104+). My problem is th=
at i have just 2GB solid state memory on my board. I was trying to emulate =
the building process on a virtual machine here (a I7 processor) but install=
ing a very basic Debian (about 500K of vemory usage), an them building the =
kernel, consumed my whole memory (i limited the VM to 2GB)... 2 questions..=
 is there anything i can do to reduce the hardware memory consumed during t=
he kernel build with Xenomai? Second.. is it possible to build a kernel to =
another different computer? I mean i could build the kernel here on my I7 a=
nd them just install it on the Atom.. but how should i do that?<div>

<br></div><div>Thank you!<br clear=3D"all"><font color=3D"#888888"><div><br=
></div></font></div></blockquote><div><br>Hi,<br><br>This is not a xenomai =
related question. I think this is a general linux question. I highly sugges=
t you don&#39;t compile on you target as it will be slow and is maybe not p=
ossible due to the limited RAM you have (first of all use &quot;-j1&quot; o=
r CONCURRENCY_BUILD=3D1 depending of the way you build the kernel.<br>
<br>As you have 2 x86 processor you don&#39;t even have to cross compile so=
 if you build the kernel with debian packages on your i7 they&#39;ll run on=
 your target Atom. But care about your .config that will be different.<br>
<br>=A0</div><blockquote class=3D"gmail_quote" style=3D"margin: 0pt 0pt 0pt=
 0.8ex; border-left: 1px solid rgb(204, 204, 204); padding-left: 1ex;"><div=
><font color=3D"#888888"><div></div>-- <br><div>Lu=EDs Filipe Rossi<br>Elec=
trical Engineer</div>

<div><span style=3D"text-transform: none; text-indent: 0px; border-collapse=
: separate; font: medium &#39;Times New Roman&#39;; white-space: normal; le=
tter-spacing: normal; color: rgb(0, 0, 0); word-spacing: 0px;"><span style=
=3D"border-collapse: collapse; font-family: arial,sans-serif; font-size: 13=
px;">Biomechatronics Lab. / <span style=3D"text-transform: none; text-inden=
t: 0px; border-collapse: separate; font: medium &#39;Times New Roman&#39;; =
white-space: normal; letter-spacing: normal; color: rgb(0, 0, 0); word-spac=
ing: 0px;"><span style=3D"border-collapse: collapse; font-family: arial,san=
s-serif; font-size: 13px;">Grupo de Sensores Integr=E1veis e Sistemas</span=
></span></span></span></div>


<div>Escola Polit=E9cnica<br>Universidade de S=E3o Paulo</div>
<div>Cel. <a href=3D"tel:%2B55%20%2811%29%207662-9234" value=3D"+5511766292=
34" target=3D"_blank">+55 (11) 7662-9234</a></div><br>
</font></div>
<br>_______________________________________________<br>
Xenomai-help mailing list<br>
<a href=3D"mailto:Xenomai-help@domain.hid">Xenomai-help@domain.hid</a><br>
<a href=3D"https://mail.gna.org/listinfo/xenomai-help" target=3D"_blank">ht=
tps://mail.gna.org/listinfo/xenomai-help</a><br>
<br></blockquote></div><br>

--0016363b8e66c81ac204ab3b13e4--

