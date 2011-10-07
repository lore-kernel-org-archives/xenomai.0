MIME-Version: 1.0
In-Reply-To: <CACFV95LnySGuKP2NQ+BcYk-wuk+S9Gh2iu1Xmqh9VLNsH1Az0w@domain.hid>
References: <CACFV95JranppM+ZDoqsgjO5nJ-Th2fFAD0HowBSkL-t_wQ-t4w@domain.hid>
	<4E8F1643.1050700@domain.hid>
	<CACFV95LnySGuKP2NQ+BcYk-wuk+S9Gh2iu1Xmqh9VLNsH1Az0w@domain.hid>
From: Siva kumar Balasubramanian <sivakumar.bs@domain.hid>
Date: Fri, 7 Oct 2011 21:57:47 +0530
Message-ID: <CACFV95+0bWjvQfotboZkHA-ynNWAdYLfqn3RYprr9gpY=hUSNg@domain.hid>
Content-Type: multipart/alternative; boundary=20cf301af5852e015704aeb7edf6
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

--20cf301af5852e015704aeb7edf6
Content-Type: text/plain; charset=ISO-8859-1

After running make Devices also ,

i am getting error

/usr/xenomai/bin/xeno-load: line 180: 3347 Segmentation fault $suflag $*
$cmdargs

My log file link http://pastebin.com/PpnnmnuW

Thanks
sivakumar

On Fri, Oct 7, 2011 at 9:25 PM, Siva kumar Balasubramanian <
sivakumar.bs@domain.hid> wrote:

> Mini2440 is based on s3c2440,
>
> I did the following steps to patch xenomai for Mini2440
>
> I patched the adeos-ipipe-2.6.37.6-arm-1.18-03.patch to linux
> kernel-2.6.37.6
>
> I used mini2440_defconfig as configuration file, i did  not made any
> changes
>
> After sucessful compilation, i booted the mini2440 compiled kernel
>
> I crosscompiled xenomai-2.5.6 using the following command
>
> ./configure --build=x86_64-pc-linux-gnu --host=arm-linux
> --enable-arm-mach=s3c2410 --enable-arm-tsc
>
> make
>
> make install
>
> I copied the directory xenomai to /usr
>
> Did i missed any step
>
> When i try to run xeno-test i got following error
>
> Xenomai: /dev/rtheap is missing
>
> (chardev, major=10 minor=254)
>
>
> I created rtheap using the following command
>
> mknod /dev/rtheap c 10 254
>
> The device is created in /dev
>
> Now i am getting following error when i run ./xeno-test
>
>  /usr/xenomai/bin/xeno-load: line 180: 3347 Segmentation fault $suflag $*
> $cmdargs
>
>
>


-- 
Regards
sivakumar

--20cf301af5852e015704aeb7edf6
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<font face=3D"arial,helvetica,sans-serif">After running make Devices also ,=
</font><div><font class=3D"Apple-style-span" face=3D"arial, helvetica, sans=
-serif"><br></font></div><div><font class=3D"Apple-style-span" face=3D"aria=
l, helvetica, sans-serif">i am getting error=A0</font></div>

<div><font class=3D"Apple-style-span" face=3D"arial, helvetica, sans-serif"=
><br></font></div><div><font class=3D"Apple-style-span" face=3D"arial, helv=
etica, sans-serif">/usr/xenomai/bin/xeno-load: line 180: 3347 Segmentation =
fault $suflag $* $cmdargs</font></div>

<div><font class=3D"Apple-style-span" face=3D"arial, helvetica, sans-serif"=
><br></font></div><div><font class=3D"Apple-style-span" face=3D"arial, helv=
etica, sans-serif">My log file link=A0</font><a href=3D"http://pastebin.com=
/PpnnmnuW">http://pastebin.com/PpnnmnuW</a></div>

<div><br></div><div>Thanks</div><div>sivakumar</div><div><div><br><div clas=
s=3D"gmail_quote">On Fri, Oct 7, 2011 at 9:25 PM, Siva kumar Balasubramania=
n <span dir=3D"ltr">&lt;<a href=3D"mailto:sivakumar.bs@domain.hid">sivakumar=
.bs@domain.hid</a>&gt;</span> wrote:<br>

<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex;"><font face=3D"arial,helvetica,sans-serif">M=
ini2440 is based on s3c2440,=A0</font><div><font face=3D"arial,helvetica,sa=
ns-serif"><br>

</font></div><div><font face=3D"arial,helvetica,sans-serif">I did the follo=
wing steps to patch xenomai for Mini2440</font></div>
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
-serif"><br></font></div><div><font face=3D"arial, helvetica, sans-serif">D=
id i missed any step</font></div>


<div><font face=3D"arial, helvetica, sans-serif"><br></font></div><div><fon=
t face=3D"arial, helvetica, sans-serif">When i try to run xeno-test i got f=
ollowing error</font></div>
<div><font face=3D"arial, helvetica, sans-serif"><br></font></div><div><fon=
t face=3D"arial, helvetica, sans-serif"><div class=3D"im"><span style=3D"fo=
nt-size:13px;background-color:rgb(255, 255, 255)"><p style=3D"margin-top:0p=
x;margin-bottom:0px;margin-left:0px;margin-right:0px;text-indent:0px">


Xenomai: /dev/rtheap is missing</p><p style=3D"margin-top:0px;margin-bottom=
:0px;margin-left:0px;margin-right:0px;text-indent:0px">(chardev, major=3D10=
 minor=3D254)</p><p style=3D"margin-top:0px;margin-bottom:0px;margin-left:0=
px;margin-right:0px;text-indent:0px">


<br></p></span></div>I created rtheap using the following command</font></d=
iv><div><font face=3D"arial, helvetica, sans-serif">=A0=A0</font></div><div=
><font face=3D"arial, helvetica, sans-serif">mknod /dev/rtheap c 10 254</fo=
nt></div>


<div><font face=3D"arial, helvetica, sans-serif"><br></font></div><div><fon=
t face=3D"arial, helvetica, sans-serif">The device is created in /dev</font=
></div><div><font face=3D"arial, helvetica, sans-serif"><br>
</font></div><div><span style=3D"font-family:arial, helvetica, sans-serif">=
Now i am getting following error when i run ./xeno-test</span></div><div><f=
ont face=3D"arial, helvetica, sans-serif"><br>
</font></div><div><font face=3D"arial, helvetica, sans-serif">
<p style=3D"margin-top:0px;margin-bottom:0px;margin-left:0px;margin-right:0=
px;text-indent:0px">/usr/xenomai/bin/xeno-load: line 180:  3347 Segmentatio=
n fault      $suflag $* $cmdargs</p></font></div>
<div><font face=3D"arial, helvetica, sans-serif"><br></font></div><div><fon=
t face=3D"arial, helvetica, sans-serif"><br></font></div>
</blockquote></div><br><br clear=3D"all"><div><br></div>-- <br><div>Regards=
</div>sivakumar<br>
</div></div>

--20cf301af5852e015704aeb7edf6--

