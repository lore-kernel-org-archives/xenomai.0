MIME-Version: 1.0
Date: Mon, 6 Jun 2011 17:46:53 +0200
Message-ID: <BANLkTi=gonDhctX-5w=L1f_rQP-JVNSDYQ@mail.gmail.com>
From: suresh reddy <sureshreddy.balijepalli@domain.hid>
Content-Type: multipart/alternative; boundary=20cf3033475136f02604a50d037c
Subject: Re: [Xenomai-help] pandaboard -deconfig
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai@xenomai.org

--20cf3033475136f02604a50d037c
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Dear Xenomai Team,

$xenomai_root/scripts/prepare-kernel.sh --arch=3Darm \
  --adeos=3D$xenomai_root/ksrc/arch/arm/patches/adeos-ipipe-2.6.20-arm-* \
  --linux=3D$linux_tree$ cd $linux_tree
$ make ARCH=3Darm CROSS_COMPILE=3Darm-linux- O=3D$build_root csb637_defconf=
ig


I  have doubts in above highlighted issues .

1. CD $linux_tree

i have taken snapshot of ipipe-gch from xenomai git repository. (It is
patched kernel)

*On my host pc (intel )*

i changed to  CD =A7 ipipe-gch   (since this is the ipipe patched linux ker=
nel
tree). Is this the correct way ?


2. if i make menu config im entering into host pc (i mean i386
configuration) but not the arm . how can i configure for pandaboard .

--20cf3033475136f02604a50d037c
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div><br></div><div><br></div><div><br></div><div>Dear Xen=
omai Team,</div><div><br></div><div><meta http-equiv=3D"content-type" conte=
nt=3D"text/html; charset=3Dutf-8"><span class=3D"Apple-style-span" style=3D=
"font-family: sans-serif; font-size: 13px; line-height: 19px; "><pre style=
=3D"padding-top: 1em; padding-right: 1em; padding-bottom: 1em; padding-left=
: 1em; border-top-width: 1px; border-right-width: 1px; border-bottom-width:=
 1px; border-left-width: 1px; border-top-style: dashed; border-right-style:=
 dashed; border-bottom-style: dashed; border-left-style: dashed; border-top=
-color: rgb(47, 111, 171); border-right-color: rgb(47, 111, 171); border-bo=
ttom-color: rgb(47, 111, 171); border-left-color: rgb(47, 111, 171); backgr=
ound-color: rgb(249, 249, 249); line-height: 1.1em; ">
<span class=3D"Apple-style-span" style=3D"color: black; ">$xenomai_root/scr=
ipts/prepare-kernel.sh --arch=3Darm \
  --adeos=3D$xenomai_root/ksrc/arch/arm/patches/adeos-ipipe-2.6.20-arm-* \
  --linux=3D$linux_tree
</span><font class=3D"Apple-style-span" color=3D"#33CC00">$ cd $linux_tree<=
/font>
$ make ARCH=3Darm CROSS_COMPILE=3Darm-linux- O=3D$build_root <font class=3D=
"Apple-style-span" color=3D"#6633FF">csb637_defconfig</font>
</pre></span></div><div><br></div><div>I =A0have doubts in above highlighte=
d issues .</div><div><br></div><div>1. CD $linux_tree</div><div><br></div><=
div>i have taken snapshot of ipipe-gch from xenomai git repository. (It is =
patched kernel)</div>
<div><br></div><div><b>On my host pc (intel )</b>=A0</div><div><br></div><d=
iv>i changed to =A0<font class=3D"Apple-style-span" color=3D"#009900">CD =
=A7 ipipe-gch</font> =A0 (since this is the ipipe patched linux kernel tree=
). Is this the correct way ?</div>
<div><br></div><div><br></div><div>2. if i make menu config im entering int=
o host pc (i mean i386 configuration) but not the arm . how can i configure=
 for pandaboard .=A0</div><div><br></div><div><br></div><div><br></div><div=
>
<br></div><div><br></div><div><br></div><div><br></div><div><br></div><div>=
<br></div><div><br></div><div><br></div><div><br></div><div><br></div><div>=
<br></div><div><br></div><div><br></div><br>
</div>

--20cf3033475136f02604a50d037c--

