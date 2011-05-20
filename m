MIME-Version: 1.0
In-Reply-To: <4DD55CEE.4030607@domain.hid>
References: <BANLkTimo07YLRZKw2faMv3r5MuBeG047zQ@mail.gmail.com>
	<4DD55CEE.4030607@domain.hid>
Date: Fri, 20 May 2011 11:26:53 +0200
Message-ID: <BANLkTim2KPKjhgSSAcyF4g1-CVFXFsCjTw@domain.hid>
From: suresh reddy <sureshreddy.balijepalli@domain.hid>
Content-Type: multipart/alternative; boundary=bcaec53ae8a0e87b6504a3b1b8a4
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

--bcaec53ae8a0e87b6504a3b1b8a4
Content-Type: text/plain; charset=ISO-8859-1

 On 05/19/2011 04:41 PM, suresh reddy wrote:
> Hi all,
>
> iam running ubuntu 10.04 on my pandaboard  with the kernel
2.6.35-903-omap4.
>
> the latest linux kernel available is 2.6.38 and  the xenomai latest
> version is v2.5.6. My question is is it compatible if i compile with the
> available adeos patch for pandaboard?

Yes. You may have to adjust include/asm-arm/hal.h, as explained in the
arm porting guide though.


Ok. So,the linux kernel 2.6.38 and xenomai latest version with two macros
adding in
include/asm-arm/hal.h will make it compile  for pandaboard  .
Does the board supports CONFIG_GENERIC_TIME and CONFIG_GENERIC_CLOCKSOURCES
?

Thanks for the help
Suresh balijepalli
Rosenehim,Baveria.

--bcaec53ae8a0e87b6504a3b1b8a4
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div style=3D"border-collapse: collapse; font-family: aria=
l, sans-serif; font-size: 13px; "><div style=3D"color:rgb(80, 0, 80)">
On 05/19/2011 04:41 PM, suresh reddy wrote:<br>&gt; Hi all,<br>&gt;<br>&gt;=
 iam running ubuntu 10.04 on my pandaboard =A0with the kernel 2.6.35-903-om=
ap4.<br>&gt;<br>&gt; the latest linux kernel available is 2.6.38 and =A0the=
 xenomai latest<br>

&gt; version is v2.5.6. My question is is it compatible if i compile with t=
he<br>&gt; available adeos patch for pandaboard?<br><br></div></div><font c=
lass=3D"Apple-style-span" color=3D"#FF6666"><font class=3D"Apple-style-span=
" face=3D"arial, sans-serif"><span class=3D"Apple-style-span" style=3D"bord=
er-collapse: collapse;">Yes. You may have to adjust include/asm-arm/hal.h, =
as explained in the</span></font><br>
<font class=3D"Apple-style-span" face=3D"arial, sans-serif"><span class=3D"=
Apple-style-span" style=3D"border-collapse: collapse;">arm porting guide th=
ough.</span></font></font><br><br><div><br></div><div>Ok. So,the linux kern=
el 2.6.38 and xenomai latest version with two macros adding in=A0</div>
<div><meta http-equiv=3D"content-type" content=3D"text/html; charset=3Dutf-=
8"><span class=3D"Apple-style-span" style=3D"font-family: arial, sans-serif=
; border-collapse: collapse; color: rgb(255, 102, 102); ">include/asm-arm/h=
al.h </span><span class=3D"Apple-style-span" style=3D"font-family: arial, s=
ans-serif; border-collapse: collapse; ">will make it compile =A0for pandabo=
ard =A0.</span></div>
<div><font class=3D"Apple-style-span" face=3D"arial, sans-serif"><span clas=
s=3D"Apple-style-span" style=3D"border-collapse: collapse;">Does the board =
supports CONFIG_GENERIC_TIME and CONFIG_GENERIC_CLOCKSOURCES ?</span></font=
></div>
<div><br></div><div>Thanks for the help<br>Suresh balijepalli<br>Rosenehim,=
Baveria.<br>
</div></div>

--bcaec53ae8a0e87b6504a3b1b8a4--

