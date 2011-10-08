MIME-Version: 1.0
In-Reply-To: <4E8F2CFA.1070306@domain.hid>
References: <CACFV95JranppM+ZDoqsgjO5nJ-Th2fFAD0HowBSkL-t_wQ-t4w@domain.hid>
	<4E8F1643.1050700@domain.hid>
	<CACFV95LnySGuKP2NQ+BcYk-wuk+S9Gh2iu1Xmqh9VLNsH1Az0w@domain.hid>
	<4E8F2CFA.1070306@domain.hid>
From: Siva kumar Balasubramanian <sivakumar.bs@domain.hid>
Date: Sat, 8 Oct 2011 11:58:09 +0530
Message-ID: <CACFV95LX8U8U=UW6EicEjRYSjToSmL9-PPVf=n16GfKW9pLsPg@domain.hid>
Content-Type: multipart/alternative; boundary=90e6ba6e83428d17c704aec3aa50
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

--90e6ba6e83428d17c704aec3aa50
Content-Type: text/plain; charset=ISO-8859-1

After  configuring --enable-arm-eabi , now i am getting following message

Xenomai: native skin or CONFIG_XENO_OPT_PERVASIVE disabled.(modprobe xeno
native?)

i downloaded  adeos-ipipe-2.6.37.6-arm-1.18-03.patch separately and patched
with kernel-2.6.37.6.
and configured the kernel as mini2440_defconfig, and compiled the kernel

i missed the prepare-kernel.sh step.


If i patch the xenomai using the following step , the kernel is not booting

$xenomai_root/scripts/prepare-kernel.sh --arch=arm \
  --adeos=$xenomai_root/ksrc/arch/arm/patches/adeos-ipipe-2.6.37.6-arm-* \
  --linux=$linux_tree

After patching i used mini2440_defconfig. The kernel is not booting
>From the log i find it is hanging in

ohci_hcd: USB 1.1 'Open' Host Controller (OHCI) Driver

s3c2410-ohci s3c2410-ohci: S3C24XX OHCI

s3c2410-ohci s3c2410-ohci: new USB bus registered, assigned bus number 1

s3c2410-ohci s3c2410-ohci: irq 42, io mem 0x49000000


My complete log file is in http://pastebin.com/Z64key6P

Thanks
sivakumar



On Fri, Oct 7, 2011 at 10:16 PM, Gilles Chanteperdrix <
gilles.chanteperdrix@xenomai.org> wrote:

> On 10/07/2011 05:55 PM, Siva kumar Balasubramanian wrote:
> > Mini2440 is based on s3c2440,
> >
> > I did the following steps to patch xenomai for Mini2440
> >
> > I patched the adeos-ipipe-2.6.37.6-arm-1.18-03.patch to linux
> > kernel-2.6.37.6
> >
> > I used mini2440_defconfig as configuration file, i did  not made any
> changes
> >
> > After sucessful compilation, i booted the mini2440 compiled kernel
> >
> > I crosscompiled xenomai-2.5.6 using the following command
> >
> > ./configure --build=x86_64-pc-linux-gnu --host=arm-linux
> > --enable-arm-mach=s3c2410 --enable-arm-tsc
>
> So, no porting involved finally.
>
> You are probably missing --enable-arm-eabi. Note that if you start with
> xenomai 2.6.0, the configuration is much easier (basically, you just run
> configure with no arguments and it works).
>
> And xenomai 2.6.0's xeno-test should work better.
>
> --
>                                            Gilles.
>



-- 
Regards
sivakumar

--90e6ba6e83428d17c704aec3aa50
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<font face=3D"arial,helvetica,sans-serif">After=A0<span class=3D"Apple-styl=
e-span" style=3D"font-family: arial; ">=A0configuring=A0--enable-arm-eabi ,=
 now i am getting following message</span></font><div><br><div>Xenomai: nat=
ive skin or CONFIG_XENO_OPT_PERVASIVE disabled.(modprobe xeno native?)</div=
>

<div><br></div><div>i downloaded =A0adeos-ipipe-2.6.37.6-arm-1.18-03.patch =
separately and patched with kernel-2.6.37.6.</div><div>and configured the k=
ernel as mini2440_defconfig, and compiled the kernel=A0</div><div><br></div=
>

<div>i missed the prepare-kernel.sh step.=A0</div><div><br></div><div><br><=
/div><div>If i patch the xenomai using the following step , the kernel is n=
ot booting</div><div><br></div><div><div>$xenomai_root/scripts/prepare-kern=
el.sh --arch=3Darm \</div>

<div>=A0 --adeos=3D$xenomai_root/ksrc/arch/arm/patches/adeos-ipipe-2.6.37.6=
-arm-* \</div><div>=A0 --linux=3D$linux_tree</div></div><div><br></div><div=
>After patching i used mini2440_defconfig. The kernel is not booting</div><=
div>

>From the log i find it is hanging in=A0</div><div><br></div><div>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px;">ohci_hcd: USB 1.1 &#39;Open&#=
39; Host Controller (OHCI) Driver</p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px;">s3c2410-ohci s3c2410-ohci: S3=
C24XX OHCI</p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px;">s3c2410-ohci s3c2410-ohci: ne=
w USB bus registered, assigned bus number 1</p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px;">s3c2410-ohci s3c2410-ohci: ir=
q 42, io mem 0x49000000</p>
<p style=3D"-qt-paragraph-type:empty; margin-top:0px; margin-bottom:0px; ma=
rgin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px;"></p>=
</div><div><br></div><div>My complete log file is in=A0<a href=3D"http://pa=
stebin.com/Z64key6P">http://pastebin.com/Z64key6P</a></div>

<div><br></div><div>Thanks</div><div>sivakumar</div><div><br></div><div><br=
></div><div><br><div class=3D"gmail_quote">On Fri, Oct 7, 2011 at 10:16 PM,=
 Gilles Chanteperdrix <span dir=3D"ltr">&lt;<a href=3D"mailto:gilles.chante=
perdrix@domain.hid">gilles.chanteperdrix@xenomai.org</a>&gt;</span> wrote:=
<br>

<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex;"><div class=3D"im">On 10/07/2011 05:55 PM, S=
iva kumar Balasubramanian wrote:<br>
&gt; Mini2440 is based on s3c2440,<br>
&gt;<br>
&gt; I did the following steps to patch xenomai for Mini2440<br>
&gt;<br>
&gt; I patched the adeos-ipipe-2.6.37.6-arm-1.18-03.patch to linux<br>
&gt; kernel-2.6.37.6<br>
&gt;<br>
&gt; I used mini2440_defconfig as configuration file, i did =A0not made any=
 changes<br>
&gt;<br>
&gt; After sucessful compilation, i booted the mini2440 compiled kernel<br>
&gt;<br>
&gt; I crosscompiled xenomai-2.5.6 using the following command<br>
&gt;<br>
&gt; ./configure --build=3Dx86_64-pc-linux-gnu --host=3Darm-linux<br>
&gt; --enable-arm-mach=3Ds3c2410 --enable-arm-tsc<br>
<br>
</div>So, no porting involved finally.<br>
<br>
You are probably missing --enable-arm-eabi. Note that if you start with<br>
xenomai 2.6.0, the configuration is much easier (basically, you just run<br=
>
configure with no arguments and it works).<br>
<br>
And xenomai 2.6.0&#39;s xeno-test should work better.<br>
<font color=3D"#888888"><br>
--<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0Gilles.<br>
</font></blockquote></div><br><br clear=3D"all"><div><br></div>-- <br><div>=
Regards</div>sivakumar<br>
</div></div>

--90e6ba6e83428d17c704aec3aa50--

