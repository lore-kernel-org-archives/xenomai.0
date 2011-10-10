MIME-Version: 1.0
In-Reply-To: <4E907256.1010707@domain.hid>
References: <CACFV95JranppM+ZDoqsgjO5nJ-Th2fFAD0HowBSkL-t_wQ-t4w@domain.hid>
	<4E8F1643.1050700@domain.hid>
	<CACFV95LnySGuKP2NQ+BcYk-wuk+S9Gh2iu1Xmqh9VLNsH1Az0w@domain.hid>
	<4E8F2CFA.1070306@domain.hid>
	<CACFV95LX8U8U=UW6EicEjRYSjToSmL9-PPVf=n16GfKW9pLsPg@domain.hid>
	<4E907256.1010707@domain.hid>
From: Siva kumar Balasubramanian <sivakumar.bs@domain.hid>
Date: Mon, 10 Oct 2011 14:15:19 +0530
Message-ID: <CACFV95KWbC_ehmHqrh+E_dTfeMzvOabFSNLYe6LDvRWG-_V+6w@domain.hid>
Content-Type: multipart/alternative; boundary=20cf303bfb56b8e28404aeedd016
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

--20cf303bfb56b8e28404aeedd016
Content-Type: text/plain; charset=ISO-8859-1

I am using xenomai-2.5.6.

When i tried with xenomai-2.6.0-rc1 with kernel-2.6.37.6. It gets error
during kernel compilation

Which kernel and xenomai version is working in mini2440

I tried vanilla kernel 2.6.35.9 with mini2440_defconfig , i am getting error
while booting

 Log file of error http://pastebin.com/L2mffkym




On Sat, Oct 8, 2011 at 9:25 PM, Gilles Chanteperdrix <
gilles.chanteperdrix@xenomai.org> wrote:

> On 10/08/2011 08:28 AM, Siva kumar Balasubramanian wrote:
> > After  configuring --enable-arm-eabi , now i am getting following message
> >
> > Xenomai: native skin or CONFIG_XENO_OPT_PERVASIVE disabled.(modprobe xeno
> > native?)
> >
> > i downloaded  adeos-ipipe-2.6.37.6-arm-1.18-03.patch separately and
> patched
> > with kernel-2.6.37.6.
> > and configured the kernel as mini2440_defconfig, and compiled the kernel
> >
> > i missed the prepare-kernel.sh step.
> >
> >
> > If i patch the xenomai using the following step , the kernel is not
> booting
> >
> > $xenomai_root/scripts/prepare-kernel.sh --arch=arm \
> >   --adeos=$xenomai_root/ksrc/arch/arm/patches/adeos-ipipe-2.6.37.6-arm-*
> \
> >   --linux=$linux_tree
> >
> > After patching i used mini2440_defconfig. The kernel is not booting
> > From the log i find it is hanging in
> >
> > ohci_hcd: USB 1.1 'Open' Host Controller (OHCI) Driver
> >
> > s3c2410-ohci s3c2410-ohci: S3C24XX OHCI
> >
> > s3c2410-ohci s3c2410-ohci: new USB bus registered, assigned bus number 1
> >
> > s3c2410-ohci s3c2410-ohci: irq 42, io mem 0x49000000
> >
> >
> > My complete log file is in http://pastebin.com/Z64key6P
>
> What version of xenomai are you using? Only 2.6.0 works with 2.6.37.
>
>
> --
>                                                                Gilles.
>



-- 
Regards
sivakumar

--20cf303bfb56b8e28404aeedd016
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<font face=3D"arial,helvetica,sans-serif">I am using xenomai-2.5.6.</font><=
div><font face=3D"arial,helvetica,sans-serif"><br></font></div><div><font f=
ace=3D"arial,helvetica,sans-serif">When i tried with xenomai-2.6.0-rc1 with=
 kernel-2.6.37.6. It gets error during kernel compilation</font></div>

<div><font face=3D"arial,helvetica,sans-serif"><br></font></div><div><font =
face=3D"arial,helvetica,sans-serif">Which kernel and xenomai version is wor=
king in mini2440</font></div><div><font face=3D"arial,helvetica,sans-serif"=
><br>

</font></div><div><font face=3D"arial,helvetica,sans-serif">I tried vanilla=
 kernel 2.6.35.9 with mini2440_defconfig , i am getting error while booting=
</font></div><div><font face=3D"arial,helvetica,sans-serif"><br></font></di=
v>

<div><font face=3D"arial,helvetica,sans-serif">

<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px;">Log file of error=A0<span cla=
ss=3D"Apple-style-span" style=3D"font-family: arial; "><a href=3D"http://pa=
stebin.com/L2mffkym">http://pastebin.com/L2mffkym</a></span></p>

<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px;"><br></p><p style=3D" margin-t=
op:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-ind=
ent:0; text-indent:0px;">

<br></p><p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; ma=
rgin-right:0px; -qt-block-indent:0; text-indent:0px;"><br></p></font><div c=
lass=3D"gmail_quote">On Sat, Oct 8, 2011 at 9:25 PM, Gilles Chanteperdrix <=
span dir=3D"ltr">&lt;<a href=3D"mailto:gilles.chanteperdrix@xenomai.org">gi=
lles.chanteperdrix@domain.hid</a>&gt;</span> wrote:<br>

<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex;"><div class=3D"im">On 10/08/2011 08:28 AM, S=
iva kumar Balasubramanian wrote:<br>
&gt; After =A0configuring --enable-arm-eabi , now i am getting following me=
ssage<br>
&gt;<br>
&gt; Xenomai: native skin or CONFIG_XENO_OPT_PERVASIVE disabled.(modprobe x=
eno<br>
&gt; native?)<br>
&gt;<br>
&gt; i downloaded =A0adeos-ipipe-2.6.37.6-arm-1.18-03.patch separately and =
patched<br>
&gt; with kernel-2.6.37.6.<br>
&gt; and configured the kernel as mini2440_defconfig, and compiled the kern=
el<br>
&gt;<br>
&gt; i missed the prepare-kernel.sh step.<br>
&gt;<br>
&gt;<br>
&gt; If i patch the xenomai using the following step , the kernel is not bo=
oting<br>
&gt;<br>
&gt; $xenomai_root/scripts/prepare-kernel.sh --arch=3Darm \<br>
&gt; =A0 --adeos=3D$xenomai_root/ksrc/arch/arm/patches/adeos-ipipe-2.6.37.6=
-arm-* \<br>
&gt; =A0 --linux=3D$linux_tree<br>
&gt;<br>
&gt; After patching i used mini2440_defconfig. The kernel is not booting<br=
>
&gt; From the log i find it is hanging in<br>
&gt;<br>
&gt; ohci_hcd: USB 1.1 &#39;Open&#39; Host Controller (OHCI) Driver<br>
&gt;<br>
&gt; s3c2410-ohci s3c2410-ohci: S3C24XX OHCI<br>
&gt;<br>
&gt; s3c2410-ohci s3c2410-ohci: new USB bus registered, assigned bus number=
 1<br>
&gt;<br>
&gt; s3c2410-ohci s3c2410-ohci: irq 42, io mem 0x49000000<br>
&gt;<br>
&gt;<br>
&gt; My complete log file is in <a href=3D"http://pastebin.com/Z64key6P" ta=
rget=3D"_blank">http://pastebin.com/Z64key6P</a><br>
<br>
</div>What version of xenomai are you using? Only 2.6.0 works with 2.6.37.<=
br>
<font color=3D"#888888"><br>
<br>
--<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0Gilles.<br>
</font></blockquote></div><br><br clear=3D"all"><div><br></div>-- <br><div>=
Regards</div>sivakumar<br>
</div>

--20cf303bfb56b8e28404aeedd016--

