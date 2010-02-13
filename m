MIME-Version: 1.0
In-Reply-To: <4B73ED7A.9090803@domain.hid>
References: <1f3e02581002110136x481f99cby7edbb811af7f905b@domain.hid> 
	<4B73ED7A.9090803@domain.hid>
From: Sergey Didenko <didenkos@domain.hid>
Date: Sat, 13 Feb 2010 11:26:09 +0900
Message-ID: <1f3e02581002121826j9341915v1349a2188e75927@domain.hid>
Content-Type: multipart/alternative; boundary=000e0cd2e2429c625f047f721ceb
Subject: Re: [Xenomai-help] [ARM-MV88F6290] Xenomai 2.5.1 latency test
	results (still negative and huge)
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
Cc: xenomai@xenomai.org

--000e0cd2e2429c625f047f721ceb
Content-Type: text/plain; charset=UTF-8

Thank you, Gilles

1) Yeah, I understand that my application (originally written for VxWorks)
is not adapted somehow to work properly under Xenomai (the threads are
switching to secondary mode very often, for example)..ok..but, test
application is also running under xenomai and if I define the highest
priority for my test task it should show the best latency it can ever get
from Xenomai, I'm I right?
Could you please comment what kind of BUG I should try find out...in how
should I optimize my application?

2) which options you usualy use for diff command to make the proper (I mean
the format which is commonly used by Xenomai guys) diff file?

3) Do you have enough documentation where I can find the answers for my
questions?
Looks like yes, since you ignore answering the questions I asked you. Give
me the links on it then, please!

Thank you,
Sergey

On 11 February 2010 20:43, Gilles Chanteperdrix <
gilles.chanteperdrix@xenomai.org> wrote:

> Sergey Didenko wrote:
> > Hello
> >
> > As a unit:
> > 1) Board MV88F6290
> > 2) Linux Kernel 2.6.29
> > 3) Xenomai version 2.5.1
> >
> > I have new latency test results for Xenomai 2.5.1!
> >
> > I adjusted /proc/xenomai/latency value for kernel mode from 9503 to 5099
> > (making minimum latency more close to 0)
> > And there is a big difference (in comparission with xenomai 2.4.9
> version)
> > in case of user-mode, with xenomai 2.4.9, adjusted value was 4400, but
> with
> > xenomai 2.5.1 I have to set it to 44300 (! 10 times bigger) to get the
> > minimum latency very close to 0.
> > All test for user mode I did with value /proc/xenomai/latency = 0
> > All test for kernel mode I did with value /proc/xenomai/latency = 5100
>
> I can confirm that Xenomai is working well on other ARM platforms. So,
> this issue is specific to your platform. Look for the bug in your code.
>
>
> --
>                                             Gilles.
>

--000e0cd2e2429c625f047f721ceb
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<span class=3D"Apple-style-span" style=3D"font-family: arial, sans-serif; f=
ont-size: 13px; border-collapse: collapse; "><div>Thank you, Gilles</div><d=
iv><br></div>1) Yeah, I understand that my application (originally written =
for VxWorks) is not adapted somehow to work properly under Xenomai (the thr=
eads are switching to secondary mode very often, for example)..ok..but, tes=
t application is also running under xenomai and if I define the highest pri=
ority for my test task it should show the best latency it can ever get from=
 Xenomai, I&#39;m I right?<br>

Could you please comment what kind of BUG I should try find out...in how sh=
ould I optimize my application?<br><br>2)=C2=A0which options you usualy use=
 for diff command to make the proper (I mean the format which is commonly u=
sed by Xenomai guys) diff file?</span><div>

<font class=3D"Apple-style-span" face=3D"arial, sans-serif"><span class=3D"=
Apple-style-span" style=3D"border-collapse: collapse;"><br></span></font></=
div><div><font class=3D"Apple-style-span" face=3D"arial, sans-serif"><span =
class=3D"Apple-style-span" style=3D"border-collapse: collapse;">3) Do you h=
ave enough documentation where I can find the answers for my questions?=C2=
=A0</span></font></div>

<div><font class=3D"Apple-style-span" face=3D"arial, sans-serif"><span clas=
s=3D"Apple-style-span" style=3D"border-collapse: collapse;">Looks like yes,=
 since you ignore answering the questions I asked you. Give me the links on=
 it then, please!</span></font></div>

<div><font class=3D"Apple-style-span" face=3D"arial, sans-serif"><span clas=
s=3D"Apple-style-span" style=3D"border-collapse: collapse; "><br></span></f=
ont></div><div><font class=3D"Apple-style-span" face=3D"arial, sans-serif">=
<span class=3D"Apple-style-span" style=3D"border-collapse: collapse;">Thank=
 you,</span></font></div>

<div><font class=3D"Apple-style-span" face=3D"arial, sans-serif"><span clas=
s=3D"Apple-style-span" style=3D"border-collapse: collapse;">Sergey<br></spa=
n></font><br><div class=3D"gmail_quote">On 11 February 2010 20:43, Gilles C=
hanteperdrix <span dir=3D"ltr">&lt;<a href=3D"mailto:gilles.chanteperdrix@xenomai.org=
enomai.org">gilles.chanteperdrix@xenomai.org</a>&gt;</span> wrote:<br>

<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex;"><div class=3D"im">Sergey Didenko wrote:<br>
&gt; Hello<br>
&gt;<br>
&gt; As a unit:<br>
&gt; 1) Board MV88F6290<br>
&gt; 2) Linux Kernel 2.6.29<br>
&gt; 3) Xenomai version 2.5.1<br>
&gt;<br>
&gt; I have new latency test results for Xenomai 2.5.1!<br>
&gt;<br>
&gt; I adjusted /proc/xenomai/latency value for kernel mode from 9503 to 50=
99<br>
&gt; (making minimum latency more close to 0)<br>
&gt; And there is a big difference (in comparission with xenomai 2.4.9 vers=
ion)<br>
&gt; in case of user-mode, with xenomai 2.4.9, adjusted value was 4400, but=
 with<br>
&gt; xenomai 2.5.1 I have to set it to 44300 (! 10 times bigger) to get the=
<br>
&gt; minimum latency very close to 0.<br>
&gt; All test for user mode I did with value /proc/xenomai/latency =3D 0<br=
>
&gt; All test for kernel mode I did with value /proc/xenomai/latency =3D 51=
00<br>
<br>
</div>I can confirm that Xenomai is working well on other ARM platforms. So=
,<br>
this issue is specific to your platform. Look for the bug in your code.<br>
<br>
<br>
--<br>
<font color=3D"#888888"> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Gilles.<br>
</font></blockquote></div><br></div>

--000e0cd2e2429c625f047f721ceb--

