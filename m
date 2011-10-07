MIME-Version: 1.0
In-Reply-To: <4E8F1643.1050700@domain.hid>
References: <CACFV95JranppM+ZDoqsgjO5nJ-Th2fFAD0HowBSkL-t_wQ-t4w@domain.hid>
	<4E8F1643.1050700@domain.hid>
From: Siva kumar Balasubramanian <sivakumar.bs@domain.hid>
Date: Fri, 7 Oct 2011 21:25:13 +0530
Message-ID: <CACFV95LnySGuKP2NQ+BcYk-wuk+S9Gh2iu1Xmqh9VLNsH1Az0w@domain.hid>
Content-Type: multipart/alternative; boundary=20cf30434f54a6c08a04aeb7781b
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

--20cf30434f54a6c08a04aeb7781b
Content-Type: text/plain; charset=ISO-8859-1

Mini2440 is based on s3c2440,

I did the following steps to patch xenomai for Mini2440

I patched the adeos-ipipe-2.6.37.6-arm-1.18-03.patch to linux
kernel-2.6.37.6

I used mini2440_defconfig as configuration file, i did  not made any changes

After sucessful compilation, i booted the mini2440 compiled kernel

I crosscompiled xenomai-2.5.6 using the following command

./configure --build=x86_64-pc-linux-gnu --host=arm-linux
--enable-arm-mach=s3c2410 --enable-arm-tsc

make

make install

I copied the directory xenomai to /usr

Did i missed any step

When i try to run xeno-test i got following error

Xenomai: /dev/rtheap is missing

(chardev, major=10 minor=254)


I created rtheap using the following command

mknod /dev/rtheap c 10 254

The device is created in /dev

Now i am getting following error when i run ./xeno-test

 /usr/xenomai/bin/xeno-load: line 180: 3347 Segmentation fault $suflag $*
$cmdargs

--20cf30434f54a6c08a04aeb7781b
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<font face=3D"arial,helvetica,sans-serif">Mini2440 is based on s3c2440,=A0<=
/font><div><font face=3D"arial,helvetica,sans-serif"><br></font></div><div>=
<font face=3D"arial,helvetica,sans-serif">I did the following steps to patc=
h xenomai for Mini2440</font></div>

<div><font face=3D"arial,helvetica,sans-serif"><br></font></div><div><font =
face=3D"arial,helvetica,sans-serif">I patched the=A0adeos-ipipe-2.6.37.6-ar=
m-1.18-03.patch to linux kernel-2.6.37.6</font></div><div><font face=3D"ari=
al,helvetica,sans-serif"><br>

</font></div><div><font face=3D"arial,helvetica,sans-serif">I used mini2440=
_defconfig as configuration file, i did =A0not made any changes</font></div=
><div><font face=3D"arial,helvetica,sans-serif"><br></font></div><div><font=
 face=3D"arial,helvetica,sans-serif">After sucessful compilation, i booted =
the mini2440 compiled kernel</font></div>

<div><font face=3D"arial,helvetica,sans-serif"><br></font></div><div><font =
face=3D"arial,helvetica,sans-serif">I crosscompiled xenomai-2.5.6 using the=
 following command</font></div><div><font face=3D"arial,helvetica,sans-seri=
f"><br>

</font></div><div><font face=3D"arial,helvetica,sans-serif">./configure --b=
uild=3Dx86_64-pc-linux-gnu --host=3Darm-linux --enable-arm-mach=3Ds3c2410 -=
-enable-arm-tsc</font></div><div><font face=3D"arial,helvetica,sans-serif">=
<br></font></div>

<div><font face=3D"arial,helvetica,sans-serif">make</font></div><div><font =
face=3D"arial,helvetica,sans-serif"><br></font></div><div><font face=3D"ari=
al,helvetica,sans-serif">make install</font></div><div><font face=3D"arial,=
helvetica,sans-serif"><br>

</font></div><div><font face=3D"arial,helvetica,sans-serif">I copied the di=
rectory xenomai to /usr</font></div><div><font face=3D"arial,helvetica,sans=
-serif"><br></font></div><div><font class=3D"Apple-style-span" face=3D"aria=
l, helvetica, sans-serif">Did i missed any step</font></div>

<div><font class=3D"Apple-style-span" face=3D"arial, helvetica, sans-serif"=
><br></font></div><div><font class=3D"Apple-style-span" face=3D"arial, helv=
etica, sans-serif">When i try to run xeno-test i got following error</font>=
</div>

<div><font class=3D"Apple-style-span" face=3D"arial, helvetica, sans-serif"=
><br></font></div><div><font class=3D"Apple-style-span" face=3D"arial, helv=
etica, sans-serif"><span class=3D"Apple-style-span" style=3D"font-size: 13p=
x; background-color: rgb(255, 255, 255); "><p style=3D"margin-top: 0px; mar=
gin-bottom: 0px; margin-left: 0px; margin-right: 0px; text-indent: 0px; ">

Xenomai: /dev/rtheap is missing</p><p style=3D"margin-top: 0px; margin-bott=
om: 0px; margin-left: 0px; margin-right: 0px; text-indent: 0px; ">(chardev,=
 major=3D10 minor=3D254)</p><p style=3D"margin-top: 0px; margin-bottom: 0px=
; margin-left: 0px; margin-right: 0px; text-indent: 0px; ">

<br></p></span>I created rtheap using the following command</font></div><di=
v><font class=3D"Apple-style-span" face=3D"arial, helvetica, sans-serif">=
=A0=A0</font></div><div><font class=3D"Apple-style-span" face=3D"arial, hel=
vetica, sans-serif">mknod /dev/rtheap c 10 254</font></div>

<div><font class=3D"Apple-style-span" face=3D"arial, helvetica, sans-serif"=
><br></font></div><div><font class=3D"Apple-style-span" face=3D"arial, helv=
etica, sans-serif">The device is created in /dev</font></div><div><font cla=
ss=3D"Apple-style-span" face=3D"arial, helvetica, sans-serif"><br>

</font></div><div><span class=3D"Apple-style-span" style=3D"font-family: ar=
ial, helvetica, sans-serif; ">Now i am getting following error when i run .=
/xeno-test</span></div><div><font class=3D"Apple-style-span" face=3D"arial,=
 helvetica, sans-serif"><br>

</font></div><div><font class=3D"Apple-style-span" face=3D"arial, helvetica=
, sans-serif">
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px;">/usr/xenomai/bin/xeno-load: l=
ine 180:  3347 Segmentation fault      $suflag $* $cmdargs</p></font></div>

<div><font class=3D"Apple-style-span" face=3D"arial, helvetica, sans-serif"=
><br></font></div><div><font class=3D"Apple-style-span" face=3D"arial, helv=
etica, sans-serif"><br></font></div>

--20cf30434f54a6c08a04aeb7781b--

