MIME-Version: 1.0
In-Reply-To: <4E09DCC2.30709@domain.hid>
References: <BANLkTimFiO9JAdvYjpnx9bpvFo2W1zYX3g@domain.hid>
	<4E0478F7.40706@domain.hid>
	<BANLkTikFipPQVsa3tYPGSgEbQEzKEC7mEw@domain.hid>
	<4E09DCC2.30709@domain.hid>
Date: Tue, 28 Jun 2011 17:06:23 +0200
Message-ID: <BANLkTi=1FwjGE5xVdepRhSifab-cMEHj3g@domain.hid>
From: suresh reddy <sureshreddy.balijepalli@domain.hid>
Content-Type: multipart/alternative; boundary=bcaec501673fd53b9704a6c7020c
Subject: Re: [Xenomai-help] Fwd: Regarding booting
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

--bcaec501673fd53b9704a6c7020c
Content-Type: text/plain; charset=ISO-8859-1

On 28 June 2011 15:53, Gilles Chanteperdrix <
gilles.chanteperdrix@xenomai.org> wrote:

> On 06/28/2011 03:08 PM, suresh reddy wrote:
> > Hi all ,
> >
> > i have followed  through the below mentioned procedure  and i have
> strucked
> > in the final step of boot process.
> >
> > modprobe: FATAL: Could not load /lib/modules/2.6.37.6/modules.dep: No
> such
> > file or directory
>
> The below mentioned procedure was to test whether xenomai worked on your
> panda board, and by no means a complete installation of Xenomai. The
> conclusion is: Xenomai works on your board.
>
> Now, if you want a complete installation, refer to Xenomai installation
> instructions,

Do you mean  complete instructions as below on my host machine  as mentioned
in 2.1 of xenomai document and

$ $xenomai_root/scripts/prepare-kernel.sh --arch=x86 \
  --adeos=$xenomai_root/ksrc/arch/x86/patches/adeos-ipipe-2.6.29.4-x86-X.Y-ZZ.patch
\
  --linux=$linux_tree
$ cd $linux_tree
$ make [ARCH=i386] xconfig/gconfig/menuconfig # select the kernel and
Xenomai options
$ make [ARCH=i386] bzImage modules # then install as needed
$ mkdir $build_root && cd $build_root
$ $xenomai_root/configure --enable-x86-sep (*) \
  [--host=i686-linux CFLAGS="-m32 -O2" LDFLAGS="-m32"]

$ make install

preparing and building the target kernel as mentioned in 1.1 of the document
which i have done until now.

$ $xenomai_root/scripts/prepare-kernel.sh --arch=arm \
  --adeos=$xenomai_root/ksrc/arch/arm/patches/adeos-ipipe-2.6.20-arm-* \
  --linux=$linux_tree
$ cd $linux_tree
$ make ARCH=arm CROSS_COMPILE=arm-linux- O=$build_root csb637_defconfig
$ make ARCH=arm CROSS_COMPILE=arm-linux- O=$build_root bzImage modules
# [manually install the kernel image, system map and modules to the
proper location]
$ cd $build_root
$ $xenomai_root/configure --build=i686-pc-linux-gnu --host=arm-linux
--enable-arm-mach=at91rm9200 --enable-arm-tsc
$ make DESTDIR=$staging_dir install



Is this completes the complete installation process ?











and for the linux kernel installation, refer to any
> website you want explaining how to install a Linux kernel with its
> modules. Like I already told you, teaching you how to install a Linux
> kernel is clearly not what the xenomai-help mailing list is for.
>
> --
>                                             Gilles.
>



-- 

Suresh balijepalli
Rosenehim,Baveria.

--bcaec501673fd53b9704a6c7020c
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br><br><div class=3D"gmail_quote">On 28 June 2011 15:53, =
Gilles Chanteperdrix <span dir=3D"ltr">&lt;<a href=3D"mailto:gilles.chantep=
erdrix@domain.hid">gilles.chanteperdrix@xenomai.org</a>&gt;</span> wrote:<=
br><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left=
:1px #ccc solid;padding-left:1ex;">
<div class=3D"im">On 06/28/2011 03:08 PM, suresh reddy wrote:<br>
&gt; Hi all ,<br>
&gt;<br>
&gt; i have followed =A0through the below mentioned procedure =A0and i have=
 strucked<br>
&gt; in the final step of boot process.<br>
&gt;<br>
&gt; modprobe: FATAL: Could not load /lib/modules/<a href=3D"http://2.6.37.=
6/modules.dep" target=3D"_blank">2.6.37.6/modules.dep</a>: No such<br>
&gt; file or directory<br>
<br>
</div>The below mentioned procedure was to test whether xenomai worked on y=
our<br>
panda board, and by no means a complete installation of Xenomai. The<br>
conclusion is: Xenomai works on your board.<br>
<br><font class=3D"Apple-style-span" color=3D"#FF0000">
Now, if you want a complete installation, refer to Xenomai installation<br>
instructions, </font></blockquote><div>Do you mean =A0complete instructions=
 as below on my host machine =A0as mentioned in 2.1 of xenomai document and=
=A0</div><div><br></div><meta http-equiv=3D"content-type" content=3D"text/h=
tml; charset=3Dutf-8"><span class=3D"Apple-style-span" style=3D"font-family=
: &#39;Times New Roman&#39;; font-size: medium; "><pre style=3D"word-wrap: =
break-word; white-space: pre-wrap; ">
$ $xenomai_root/scripts/prepare-kernel.sh --arch=3Dx86 \
  --adeos=3D$xenomai_root/ksrc/arch/x86/patches/adeos-ipipe-2.6.29.4-x86-X.=
Y-ZZ.patch \
  --linux=3D$linux_tree
$ cd $linux_tree
$ make [ARCH=3Di386] xconfig/gconfig/menuconfig # select the kernel and Xen=
omai options
$ make [ARCH=3Di386] bzImage modules # then install as needed
$ mkdir $build_root &amp;&amp; cd $build_root
$ $xenomai_root/configure --enable-x86-sep (*) \
  [--host=3Di686-linux CFLAGS=3D&quot;-m32 -O2&quot; LDFLAGS=3D&quot;-m32&q=
uot;]=A0</pre></span><div><span class=3D"Apple-style-span" style=3D"font-fa=
mily: monospace; font-size: medium; white-space: pre-wrap; ">$ make install=
</span>=A0</div>
<div>=A0</div><div>preparing and building the target kernel as mentioned in=
 1.1 of the document which i have done until now.</div><div><br></div><div>=
<meta http-equiv=3D"content-type" content=3D"text/html; charset=3Dutf-8"><s=
pan class=3D"Apple-style-span" style=3D"font-family: &#39;Times New Roman&#=
39;; font-size: medium; "><pre style=3D"word-wrap: break-word; white-space:=
 pre-wrap; ">
$ $xenomai_root/scripts/prepare-kernel.sh --arch=3Darm \
  --adeos=3D$xenomai_root/ksrc/arch/arm/patches/adeos-ipipe-2.6.20-arm-* \
  --linux=3D$linux_tree
$ cd $linux_tree
$ make ARCH=3Darm CROSS_COMPILE=3Darm-linux- O=3D$build_root csb637_defconf=
ig
$ make ARCH=3Darm CROSS_COMPILE=3Darm-linux- O=3D$build_root bzImage module=
s
# [manually install the kernel image, system map and modules to the proper =
location]
$ cd $build_root
$ $xenomai_root/configure --build=3Di686-pc-linux-gnu --host=3Darm-linux --=
enable-arm-mach=3Dat91rm9200 --enable-arm-tsc
$ make DESTDIR=3D$staging_dir install</pre><pre style=3D"word-wrap: break-w=
ord; white-space: pre-wrap; "><br></pre><pre style=3D"word-wrap: break-word=
; white-space: pre-wrap; "><br></pre><pre style=3D"word-wrap: break-word; w=
hite-space: pre-wrap; ">
Is this completes the complete installation process ?</pre><pre style=3D"wo=
rd-wrap: break-word; white-space: pre-wrap; "><br></pre><pre style=3D"word-=
wrap: break-word; white-space: pre-wrap; "><br></pre><pre style=3D"word-wra=
p: break-word; white-space: pre-wrap; ">
<br></pre><pre style=3D"word-wrap: break-word; white-space: pre-wrap; "><br=
></pre></span></div><div><br></div><div><br></div><div><br></div><div><br><=
/div><div><br></div><div><br></div><blockquote class=3D"gmail_quote" style=
=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex;">
and for the linux kernel installation, refer to any<br>
website you want explaining how to install a Linux kernel with its<br>
modules. Like I already told you, teaching you how to install a Linux<br>
kernel is clearly not what the xenomai-help mailing list is for.<br>
<br>
--<br>
<font color=3D"#888888"> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0Gilles.<br>
</font></blockquote></div><br><br clear=3D"all"><br>-- <br><br>Suresh balij=
epalli<br>Rosenehim,Baveria.<br>
</div>

--bcaec501673fd53b9704a6c7020c--

