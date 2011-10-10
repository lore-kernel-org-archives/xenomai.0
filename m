MIME-Version: 1.0
In-Reply-To: <4E92B7AC.8040502@domain.hid>
References: <CACFV95JranppM+ZDoqsgjO5nJ-Th2fFAD0HowBSkL-t_wQ-t4w@domain.hid>
	<4E8F1643.1050700@domain.hid>
	<CACFV95LnySGuKP2NQ+BcYk-wuk+S9Gh2iu1Xmqh9VLNsH1Az0w@domain.hid>
	<4E8F2CFA.1070306@domain.hid>
	<CACFV95LX8U8U=UW6EicEjRYSjToSmL9-PPVf=n16GfKW9pLsPg@domain.hid>
	<4E907256.1010707@domain.hid>
	<CACFV95KWbC_ehmHqrh+E_dTfeMzvOabFSNLYe6LDvRWG-_V+6w@domain.hid>
	<4E92B7AC.8040502@domain.hid>
From: Siva kumar Balasubramanian <sivakumar.bs@domain.hid>
Date: Mon, 10 Oct 2011 15:13:53 +0530
Message-ID: <CACFV95KO42VMre6dwfrZvO-1NYvV+Z8F-GtLKsdeMJZO1bYqbQ@mail.gmail.com>
Content-Type: multipart/alternative; boundary=20cf307f3b8a2bacd504aeeea273
Subject: Re: [Xenomai-help] Xenomai: /dev/rtheap is missing (chardev,
 major=10 minor=254) in mini2440
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

--20cf307f3b8a2bacd504aeeea273
Content-Type: text/plain; charset=ISO-8859-1

I am getting same error after patching latest xenomai-2.6.0.rc4 with
kernel-2.6.37.6

Compilation log http://pastebin.com/WdD2Tzqd

My configuration file http://pastebin.com/kcjH1tGF


- sivakumar

On Mon, Oct 10, 2011 at 2:45 PM, Gilles Chanteperdrix <
gilles.chanteperdrix@xenomai.org> wrote:

> On 10/10/2011 10:45 AM, Siva kumar Balasubramanian wrote:
> > I am using xenomai-2.5.6.
> >
> > When i tried with xenomai-2.6.0-rc1 with kernel-2.6.37.6. It gets error
> > during kernel compilation
> >
> > Which kernel and xenomai version is working in mini2440
> >
> > I tried vanilla kernel 2.6.35.9 with mini2440_defconfig , i am getting
> error
> > while booting
> >
> >  Log file of error http://pastebin.com/L2mffkym
>
> The only non-working version is kernel 2.6.37 (and later) with xenomai
> 2.5.6. Please try 2.6.0-rc4 instead of -rc1. However, I am surprised
> that the kernel does not build with the 2.6.37 patch, as I build-tested
> it. Could you put the compilation logs on a pastebin?
>
> The error you have with 2.6.35.9 does not seem to be related to xenomai.
>
> --
>                                            Gilles.
>

--20cf307f3b8a2bacd504aeeea273
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<font face=3D"arial,helvetica,sans-serif">I am getting same error after pat=
ching latest xenomai-2.6.0.rc4 with kernel-2.6.37.6</font><div><font face=
=3D"arial,helvetica,sans-serif"><br></font></div><div><font face=3D"arial,h=
elvetica,sans-serif">Compilation log=A0<a href=3D"http://pastebin.com/WdD2T=
zqd">http://pastebin.com/WdD2Tzqd</a></font></div>

<div><font face=3D"arial,helvetica,sans-serif"><br></font></div><div><font =
face=3D"arial,helvetica,sans-serif">My configuration file=A0<a href=3D"http=
://pastebin.com/kcjH1tGF">http://pastebin.com/kcjH1tGF</a></font></div><div=
><font face=3D"arial,helvetica,sans-serif"><br>

</font></div><div><font face=3D"arial,helvetica,sans-serif"><br></font></di=
v><div><font class=3D"Apple-style-span" face=3D"arial, helvetica, sans-seri=
f">- sivakumar</font></div><div><br><div class=3D"gmail_quote">On Mon, Oct =
10, 2011 at 2:45 PM, Gilles Chanteperdrix <span dir=3D"ltr">&lt;<a href=3D"=
mailto:gilles.chanteperdrix@xenomai.org">gilles.chanteperdrix@xenomai.org</=
a>&gt;</span> wrote:<br>

<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex;"><div class=3D"im">On 10/10/2011 10:45 AM, S=
iva kumar Balasubramanian wrote:<br>
&gt; I am using xenomai-2.5.6.<br>
&gt;<br>
&gt; When i tried with xenomai-2.6.0-rc1 with kernel-2.6.37.6. It gets erro=
r<br>
&gt; during kernel compilation<br>
&gt;<br>
&gt; Which kernel and xenomai version is working in mini2440<br>
&gt;<br>
&gt; I tried vanilla kernel 2.6.35.9 with mini2440_defconfig , i am getting=
 error<br>
&gt; while booting<br>
&gt;<br>
&gt; =A0Log file of error <a href=3D"http://pastebin.com/L2mffkym" target=
=3D"_blank">http://pastebin.com/L2mffkym</a><br>
<br>
</div>The only non-working version is kernel 2.6.37 (and later) with xenoma=
i<br>
2.5.6. Please try 2.6.0-rc4 instead of -rc1. However, I am surprised<br>
that the kernel does not build with the 2.6.37 patch, as I build-tested<br>
it. Could you put the compilation logs on a pastebin?<br>
<br>
The error you have with 2.6.35.9 does not seem to be related to xenomai.<br=
>
<font color=3D"#888888"><br>
--<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0Gilles.<br>
</font></blockquote></div><br><br clear=3D"all"><div><br></div><br>
</div>

--20cf307f3b8a2bacd504aeeea273--

