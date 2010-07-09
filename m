MIME-Version: 1.0
Date: Fri, 9 Jul 2010 10:28:44 +0300
Message-ID: <AANLkTim9bUjQBI43P2Z7DL4ZQsZdjMMQ3ZZf2p54bAso@domain.hid>
From: =?ISO-8859-9?Q?G=F6rkem_Karado=F0an?= <gkaradagan@domain.hid>
Content-Type: multipart/alternative; boundary=0016e6d433ae580008048aef5a30
Subject: [Xenomai-help] xenomia adeos pacht error
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai@xenomai.org

--0016e6d433ae580008048aef5a30
Content-Type: text/plain; charset=ISO-8859-1

hi all,

i follow this install introduction (
http://www.xenomai.org/documentation/xenomai-2.5/README.INSTALL)

and i write this code

/opt/xenomai-2.5.3/scripts/prepare-kernel.sh --arch=arm \
  --adeos=/opt/xenomai-2.5.3/ksrc/arch/arm/patches/adeos-ipipe-2.6.20-arm-*
\
--linux=/opt/linux-02.01.03.11/

and i got this error codes

Hunk #1 FAILED at 156.
1 out of 1 hunk FAILED -- saving rejects to file mm/vmalloc.c.rej
prepare-kernel.sh: Unable to patch kernel 2.6.29-rc3 with
adeos-ipipe-2.6.20-arm-1.8-03.patch.

i use linux-02.01.03.11 because of omap3530. Do you know which pacht is able
with kernel 2.6.29.rc3..

thanks...

--0016e6d433ae580008048aef5a30
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

hi all,<br><br>i follow this install introduction (<a href=3D"http://www.xe=
nomai.org/documentation/xenomai-2.5/README.INSTALL">http://www.xenomai.org/=
documentation/xenomai-2.5/README.INSTALL</a>)<br><br>and i write this code =
<br>
<br>/opt/xenomai-2.5.3/scripts/prepare-kernel.sh --arch=3Darm \<br>=A0 --ad=
eos=3D/opt/xenomai-2.5.3/ksrc/arch/arm/patches/adeos-ipipe-2.6.20-arm-* \<b=
r>--linux=3D/opt/linux-02.01.03.11/<br><br>and i got this error codes<br><b=
r>Hunk #1 FAILED at 156.<br>
1 out of 1 hunk FAILED -- saving rejects to file mm/vmalloc.c.rej<br>prepar=
e-kernel.sh: Unable to patch kernel 2.6.29-rc3 with adeos-ipipe-2.6.20-arm-=
1.8-03.patch.<br><br>i use linux-02.01.03.11 because of omap3530. Do you kn=
ow which pacht is able with kernel 2.6.29.rc3..<br>
<br>thanks...<br><br><br>

--0016e6d433ae580008048aef5a30--

