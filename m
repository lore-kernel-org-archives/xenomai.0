MIME-Version: 1.0
In-Reply-To: <4E01E4D1.2090601@domain.hid>
References: <BANLkTimKq+oq5oG3d9H+TWs1S0HVCXaPLQ@mail.gmail.com>
	<4E01E4D1.2090601@domain.hid>
Date: Wed, 22 Jun 2011 17:58:32 +0200
Message-ID: <BANLkTim268o3835dTxxbCccf-vM1Z9=NYg@domain.hid>
From: suresh reddy <sureshreddy.balijepalli@domain.hid>
Content-Type: multipart/alternative; boundary=20cf3079ba824b824e04a64f0ab2
Subject: Re: [Xenomai-help] booting on pandaboard
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
Cc: Xenomai help <xenomai@xenomai.org>

--20cf3079ba824b824e04a64f0ab2
Content-Type: text/plain; charset=ISO-8859-1

On 22 June 2011 14:49, Gilles Chanteperdrix <
gilles.chanteperdrix@xenomai.org> wrote:

> On 06/22/2011 02:33 PM, suresh reddy wrote:
> > console=ttyS2,115200n8
>
> console is ttyO2, not ttyS2.
>


Dear Giles ,
that is not problem because of ttys2 or O2 settings . I followed
http://omappedia.org/wiki/Minimal-FS_Booting

that and  the below bootargs

fatload mmc 0:1 0x80000000 uImage
setenv bootargs ro elevator=noop vram=32M
mem=460M@0x80000000mem=256M@0xA0000000root=/dev/mmcblk0p2
console=ttyO2,115200n8 fixrtc earlyprintk  bootm
0x80000000


still i did not saw anything on my terminal . then only i sent a mail to
xenomai help mailing list .



> I have asked you this several time, but please stop using the Xenomai
> mailing list instead of doing your homework. Everything about pandaboard
> is documented on its wiki. Use the wiki first, then ask questions on
> this list when you do not find them here.
>
> Really, installing Xenomai takes five minutes when you know how to do
> it, at most one day when you are a beginner.
>
> You have been asking questions on this mailing list for weeks. And at
> every step, we do your work in your stead, and you learn nothing.
>
> Don't you see that there may be a problem?
>
> --
>                                             Gilles.
>



-- 

Suresh balijepalli
Rosenehim,Baveria.

--20cf3079ba824b824e04a64f0ab2
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br><br><div class=3D"gmail_quote">On 22 June 2011 14:49, =
Gilles Chanteperdrix <span dir=3D"ltr">&lt;<a href=3D"mailto:gilles.chantep=
erdrix@domain.hid" target=3D"_blank">gilles.chanteperdrix@xenomai.org</a>&=
gt;</span> wrote:<br>


<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">
On 06/22/2011 02:33 PM, suresh reddy wrote:<br>
&gt; console=3DttyS2,115200n8<br>
<br>
console is ttyO2, not ttyS2.<br></blockquote><div><br></div><div>=A0</div><=
div>Dear Giles ,</div><div>that is not problem because of ttys2 or O2 setti=
ngs . I followed =A0<a href=3D"http://omappedia.org/wiki/Minimal-FS_Booting=
" target=3D"_blank">http://omappedia.org/wiki/Minimal-FS_Booting</a></div>

<div><br></div><div>that and =A0the below bootargs</div><div><br></div><div=
><meta http-equiv=3D"content-type" content=3D"text/html; charset=3Dutf-8"><=
span class=3D"Apple-style-span" style=3D"font-family: Consolas, &#39;Lucida=
 Console&#39;, monospace, Verdana, sans-serif, &#39;sans serif&#39;; font-s=
ize: 13px; "><div>
<span>fatload mmc 0:1 0x80000000 uImage</span></div><div><span>setenv boota=
rgs ro elevator=3Dnoop vram=3D32M mem=3D460M@0x80000000 mem=3D256M@0xA00000=
00 root=3D/dev/mmcblk0p2 console=3DttyO2,115200n8 fixrtc earlyprintk=A0</sp=
an>=A0bootm 0x80000000</div>
<div><br></div><div><br></div><div>still i did not saw anything on my termi=
nal . then only i sent a mail to xenomai help mailing list .</div><div><br>=
</div></span></div><div>
=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;borde=
r-left:1px #ccc solid;padding-left:1ex">

I have asked you this several time, but please stop using the Xenomai<br>
mailing list instead of doing your homework. Everything about pandaboard<br=
>
is documented on its wiki. Use the wiki first, then ask questions on<br>
this list when you do not find them here.<br>
<br>
Really, installing Xenomai takes five minutes when you know how to do<br>
it, at most one day when you are a beginner.<br>
<br>
You have been asking questions on this mailing list for weeks. And at<br>
every step, we do your work in your stead, and you learn nothing.<br>
<br>
Don&#39;t you see that there may be a problem?<br>
<br>
--<br>
<font color=3D"#888888"> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0Gilles.<br>
</font></blockquote></div><br><br clear=3D"all"><br>-- <br><br>Suresh balij=
epalli<br>Rosenehim,Baveria.<br>
</div>

--20cf3079ba824b824e04a64f0ab2--

