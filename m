MIME-Version: 1.0
In-Reply-To: <4DD6CFFA.50108@domain.hid>
References: <BANLkTimo07YLRZKw2faMv3r5MuBeG047zQ@mail.gmail.com>
	<4DD55CEE.4030607@domain.hid>
	<BANLkTim2KPKjhgSSAcyF4g1-CVFXFsCjTw@domain.hid>
	<4DD6CFFA.50108@domain.hid>
Date: Fri, 20 May 2011 20:54:00 -1100
Message-ID: <BANLkTikVPXqV=PBBFS-fwAtDox8S0EPb3g@domain.hid>
From: suresh reddy <sureshreddy.balijepalli@domain.hid>
Content-Type: multipart/alternative; boundary=bcaec53ae8a0939ce504a3c48aab
Subject: Re: [Xenomai-help] Regarding available stable versions for
	pandaboard
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

--bcaec53ae8a0939ce504a3c48aab
Content-Type: text/plain; charset=ISO-8859-1

On 20 May 2011 09:32, Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org
> wrote:

> On 05/20/2011 11:26 AM, suresh reddy wrote:
> > On 05/19/2011 04:41 PM, suresh reddy wrote:
> >> Hi all,
> >>
> >> iam running ubuntu 10.04 on my pandaboard  with the kernel
> > 2.6.35-903-omap4.
> >>
> >> the latest linux kernel available is 2.6.38 and  the xenomai latest
> >> version is v2.5.6. My question is is it compatible if i compile with the
> >> available adeos patch for pandaboard?
> >
> > Yes. You may have to adjust include/asm-arm/hal.h, as explained in the
> > arm porting guide though.
> >
> >
> > Ok. So,the linux kernel 2.6.38 and xenomai latest version with two
> > macros adding in
> > include/asm-arm/hal.h will make it compile  for pandaboard  .
>
> No. You can not use linux kernel 2.6.38, you need to pick the ipipe tree
> from the git I sent you a link in a previous mail.
>

 yes i understanded that i have to take ipipe code from your previous mail
and xenomai code of latest stable release but what i did not understanded is

linux kernel code .Do i need to download the linux kernel code from
www.kernel.org  or its just enough to download the ipipe and xenomai to
/usr/src/
directory where omap4 linux kernel headers were there . And compile them .

>
> > Does the board supports CONFIG_GENERIC_TIME and
> > CONFIG_GENERIC_CLOCKSOURCES ?
>
> I do not understand how this question is related to Xenomai.
>
>     It does not related but the two macros needed to be provide in the
xenomai's include/asm-arm/hal.h will depends on that .

Thanks
Suresh balijepalli
Rosenehim,Baveria.

--bcaec53ae8a0939ce504a3c48aab
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br><br><div class=3D"gmail_quote">On 20 May 2011 09:32, G=
illes Chanteperdrix <span dir=3D"ltr">&lt;<a href=3D"mailto:gilles.chantepe=
rdrix@domain.hid">gilles.chanteperdrix@xenomai.org</a>&gt;</span> wrote:<b=
r><blockquote class=3D"gmail_quote" style=3D"margin: 0pt 0pt 0pt 0.8ex; bor=
der-left: 1px solid rgb(204, 204, 204); padding-left: 1ex;">
<div class=3D"im">On 05/20/2011 11:26 AM, suresh reddy wrote:<br>
&gt; On 05/19/2011 04:41 PM, suresh reddy wrote:<br>
&gt;&gt; Hi all,<br>
&gt;&gt;<br>
&gt;&gt; iam running ubuntu 10.04 on my pandaboard =A0with the kernel<br>
&gt; 2.6.35-903-omap4.<br>
&gt;&gt;<br>
&gt;&gt; the latest linux kernel available is 2.6.38 and =A0the xenomai lat=
est<br>
&gt;&gt; version is v2.5.6. My question is is it compatible if i compile wi=
th the<br>
&gt;&gt; available adeos patch for pandaboard?<br>
&gt;<br>
&gt; Yes. You may have to adjust include/asm-arm/hal.h, as explained in the=
<br>
&gt; arm porting guide though.<br>
&gt;<br>
&gt;<br>
&gt; Ok. So,the linux kernel 2.6.38 and xenomai latest version with two<br>
&gt; macros adding in<br>
&gt; include/asm-arm/hal.h will make it compile =A0for pandaboard =A0.<br>
<br>
</div>No. You can not use linux kernel 2.6.38, you need to pick the ipipe t=
ree<br>
from the git I sent you a link in a previous mail.<br></blockquote><div>=A0=
<br>=A0<span style=3D"color: rgb(0, 0, 153);">yes i understanded that i hav=
e to take ipipe code from your previous mail and xenomai code of latest sta=
ble release but what i did not understanded is </span><br style=3D"color: r=
gb(0, 0, 153);">
<span style=3D"color: rgb(0, 0, 153);">linux kernel code .Do i need to down=
load the linux kernel code from <a href=3D"http://www.kernel.org">www.kerne=
l.org</a>=A0 or its just enough to download the ipipe and xenomai to /usr/s=
rc/</span><br style=3D"color: rgb(0, 0, 153);">
<span style=3D"color: rgb(0, 0, 153);">directory where omap4 linux kernel h=
eaders were there . And compile them .</span><br style=3D"color: rgb(0, 0, =
153);"></div><blockquote class=3D"gmail_quote" style=3D"margin: 0pt 0pt 0pt=
 0.8ex; border-left: 1px solid rgb(204, 204, 204); padding-left: 1ex;">

<div class=3D"im"><br>
&gt; Does the board supports CONFIG_GENERIC_TIME and<br>
&gt; CONFIG_GENERIC_CLOCKSOURCES ?<br>
<br>
</div>I do not understand how this question is related to Xenomai.<br>
<br></blockquote><div>=A0 =A0<span style=3D"color: rgb(0, 0, 153);"> It doe=
s not related but the two macros needed to be provide in the xenomai&#39;s =
include/asm-arm/hal.h will depends on that .</span> <br></div></div><br>Tha=
nks<br>
Suresh balijepalli<br>Rosenehim,Baveria.<br>
</div>

--bcaec53ae8a0939ce504a3c48aab--

