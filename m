MIME-Version: 1.0
Date: Sat, 23 Oct 2010 20:33:43 -0400
Message-ID: <AANLkTinONvkO75DF7mrWJQC1zosSZv-_hstOyi-AxpAK@mail.gmail.com>
From: Ali Khan <ali.khan1430@domain.hid>
Content-Type: multipart/alternative; boundary=0016364ef6fa2b0a230493520761
Subject: [Xenomai-help] denx ELDK installation...xenomai error
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

--0016364ef6fa2b0a230493520761
Content-Type: text/plain; charset=ISO-8859-1

Hi,

I am using Ubuntu 10.10 and I tried installing denx ELDK (ppc-2007-01-19) on
my laptop in /opt/eldk as a root user.

The installation seems to go fine however I am getting the following error
messages towards the end:

Preparing...                ###########################################
[100%]
   1:xenomai-ppc_4xxFP      ###########################################
[100%]
Configuring Xenomai kernel...
  CLEAN   scripts/basic
  CLEAN   scripts/kconfig
  CLEAN   include/config
  CLEAN   .config.old include/asm include/linux/autoconf.h
include/linux/version.h include/linux/utsrelease.h
/opt/eldk/ppc_4xxFP/usr/local/xenomai/kbuild/scripts/prepare-kernel.sh: line
376: patch: command not found
prepare-kernel.sh: Unable to patch kernel 2.6.19.2 with
adeos-ipipe-2.6.19-ppc-1.5-01.patch.
error: %post(xenomai-ppc_4xxFP-2.3.0-1.ppc) scriptlet failed, exit status 2


I would really appreciate if you can help me out.

Thanks,
Ali

--0016364ef6fa2b0a230493520761
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi,<br><br>I am using Ubuntu 10.10 and I tried installing denx ELDK (ppc-20=
07-01-19) on my laptop in /opt/eldk as a root user.<br><br>The installation=
 seems to go fine however I am getting the following error messages towards=
 the end:<br>
<br>Preparing...=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 #############=
############################## [100%]<br>=A0=A0 1:xenomai-ppc_4xxFP=A0=A0=
=A0=A0=A0 ########################################### [100%]<br>Configuring=
 Xenomai kernel...<br>=A0 CLEAN=A0=A0 scripts/basic<br>
=A0 CLEAN=A0=A0 scripts/kconfig<br>=A0 CLEAN=A0=A0 include/config<br>=A0 CL=
EAN=A0=A0 .config.old include/asm include/linux/autoconf.h include/linux/ve=
rsion.h include/linux/utsrelease.h<br>/opt/eldk/ppc_4xxFP/usr/local/xenomai=
/kbuild/scripts/prepare-kernel.sh: line 376: patch: command not found<br>
prepare-kernel.sh: Unable to patch kernel 2.6.19.2 with adeos-ipipe-2.6.19-=
ppc-1.5-01.patch.<br>error: %post(xenomai-ppc_4xxFP-2.3.0-1.ppc) scriptlet =
failed, exit status 2<br><br><br>I would really appreciate if you can help =
me out.<br>
<br>Thanks,<br>Ali<br>

--0016364ef6fa2b0a230493520761--

