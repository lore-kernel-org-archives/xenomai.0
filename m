MIME-Version: 1.0
In-Reply-To: <4E9337AC.60100@domain.hid>
References: <CACFV95JranppM+ZDoqsgjO5nJ-Th2fFAD0HowBSkL-t_wQ-t4w@domain.hid>
	<4E8F1643.1050700@domain.hid>
	<CACFV95LnySGuKP2NQ+BcYk-wuk+S9Gh2iu1Xmqh9VLNsH1Az0w@domain.hid>
	<4E8F2CFA.1070306@domain.hid>
	<CACFV95LX8U8U=UW6EicEjRYSjToSmL9-PPVf=n16GfKW9pLsPg@domain.hid>
	<4E907256.1010707@domain.hid>
	<CACFV95KWbC_ehmHqrh+E_dTfeMzvOabFSNLYe6LDvRWG-_V+6w@domain.hid>
	<4E92B7AC.8040502@domain.hid>
	<CACFV95KO42VMre6dwfrZvO-1NYvV+Z8F-GtLKsdeMJZO1bYqbQ@mail.gmail.com>
	<4E9337AC.60100@domain.hid>
From: Siva kumar Balasubramanian <sivakumar.bs@domain.hid>
Date: Tue, 11 Oct 2011 10:51:15 +0530
Message-ID: <CACFV95LQgGvy=KXzCV-peV3ybZJaHiMguNsktQLOBbwqWH2Ydw@domain.hid>
Content-Type: multipart/alternative; boundary=90e6ba6e844ec374e204aeff14e0
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

--90e6ba6e844ec374e204aeff14e0
Content-Type: text/plain; charset=ISO-8859-1

The patch works, Thank you for fixing this

Now i was able to build without errors. I got mini2440 booting

I was able to run xeno-test

But when i try to test Helloworld program. I found the following libraries
missing

error while loading shared libraries: librtdk.so.0: cannot open shared
object file: No such file or directory




On Mon, Oct 10, 2011 at 11:51 PM, Gilles Chanteperdrix <
gilles.chanteperdrix@xenomai.org> wrote:

> On 10/10/2011 11:43 AM, Siva kumar Balasubramanian wrote:
> > I am getting same error after patching latest xenomai-2.6.0.rc4 with
> > kernel-2.6.37.6
> >
> > Compilation log http://pastebin.com/WdD2Tzqd
> >
> > My configuration file http://pastebin.com/kcjH1tGF
>
> Please try the following patch:
>
> http://git.xenomai.org/?p=xenomai-head.git;a=commitdiff;h=ff5a1b259383c1e2407f5677e8124608b41a689e;hp=aa44db3d5ee270c3b92a1017f7c136ffa1e2cc4d
>
> --
>                                                                Gilles.
>

--90e6ba6e844ec374e204aeff14e0
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<font face=3D"arial,helvetica,sans-serif">The patch works, Thank you for fi=
xing this</font><div><font face=3D"arial,helvetica,sans-serif"><br></font><=
/div><div><font face=3D"arial,helvetica,sans-serif">Now i was able to build=
 without errors. I got mini2440 booting</font></div>

<div><font face=3D"arial,helvetica,sans-serif"><br></font></div><div><font =
face=3D"arial,helvetica,sans-serif">I was able to run xeno-test</font></div=
><div><font face=3D"arial,helvetica,sans-serif"><br></font></div><div><font=
 face=3D"arial,helvetica,sans-serif">But when i try to test Helloworld prog=
ram. I found the following libraries missing</font></div>

<div><font face=3D"arial,helvetica,sans-serif"><br></font></div><div><font =
face=3D"arial,helvetica,sans-serif">

<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px;">error while loading shared li=
braries: librtdk.so.0: cannot open shared object file: No such file or dire=
ctory</p>

<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px;"><br></p><p style=3D" margin-t=
op:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-ind=
ent:0; text-indent:0px;">

<br></p></font><br><div class=3D"gmail_quote">On Mon, Oct 10, 2011 at 11:51=
 PM, Gilles Chanteperdrix <span dir=3D"ltr">&lt;<a href=3D"mailto:gilles.ch=
anteperdrix@domain.hid">gilles.chanteperdrix@xenomai.org</a>&gt;</span> wr=
ote:<br>

<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex;"><div class=3D"im">On 10/10/2011 11:43 AM, S=
iva kumar Balasubramanian wrote:<br>
&gt; I am getting same error after patching latest xenomai-2.6.0.rc4 with<b=
r>
&gt; kernel-2.6.37.6<br>
&gt;<br>
&gt; Compilation log <a href=3D"http://pastebin.com/WdD2Tzqd" target=3D"_bl=
ank">http://pastebin.com/WdD2Tzqd</a><br>
&gt;<br>
&gt; My configuration file <a href=3D"http://pastebin.com/kcjH1tGF" target=
=3D"_blank">http://pastebin.com/kcjH1tGF</a><br>
<br>
</div>Please try the following patch:<br>
<a href=3D"http://git.xenomai.org/?p=3Dxenomai-head.git;a=3Dcommitdiff;h=3D=
ff5a1b259383c1e2407f5677e8124608b41a689e;hp=3Daa44db3d5ee270c3b92a1017f7c13=
6ffa1e2cc4d" target=3D"_blank">http://git.xenomai.org/?p=3Dxenomai-head.git=
;a=3Dcommitdiff;h=3Dff5a1b259383c1e2407f5677e8124608b41a689e;hp=3Daa44db3d5=
ee270c3b92a1017f7c136ffa1e2cc4d</a><br>


<font color=3D"#888888"><br>
--<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0Gilles.<br>
</font></blockquote></div><br><br clear=3D"all"><div><br></div><br>
</div>

--90e6ba6e844ec374e204aeff14e0--

