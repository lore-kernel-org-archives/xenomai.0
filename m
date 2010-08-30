MIME-Version: 1.0
Date: Mon, 30 Aug 2010 21:31:17 +0530
Message-ID: <AANLkTin4EBuE7jeKeeJorBVk+CGy=6w86o2_DzjHLdUs@domain.hid>
From: Prakash A S <asprakash83@domain.hid>
Content-Type: multipart/alternative; boundary=00504502e2fd21403a048f0c93b1
Subject: [Xenomai-help] Xeno-test failed on ARM AT91RM9200 processor
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

--00504502e2fd21403a048f0c93b1
Content-Type: text/plain; charset=ISO-8859-1

Hi,
    I am trying to port Xenomai-2.4.0 on ARM AT91RM9200 processor. I used
adeos-ipipe-2.6.20-arm-1.7-06.patch with Linux kernel 2.6.20. All the stuffs
went fine, compiled the kernel and ported on the same processor. The xenomai
components loaded fine while loading the kernel image. However when I
executed the xeno-test, I am getting the error,  "please build busybox's ash
with support for getopts" and quit the test.

I am using BusyBox-1.15.3 enabled with GETOPT. I noticed that the "getopts"
link is not available with the busybox bin. But it has only "getopt". I
checked few other latest version of Busybox. But I could not find it in
other versions also. However the x86 desktop Linux contains both getopt and
getopts.

Few online guides claimed that the getopts is builtin with Busybox. I
created an getopts softlink for busybox manually anf then tried the
xeno-test. But getting the error,  "getopts: applet not found". I could not
find the exact reason for this issue. I also tried to execute the tests
separately like latency, switchtest,.etc. But getting the same error, "syntax
error: word unexpected (expecting ")")".

FYI, the busybox configured with ASH shell.

Help me to solve the issues.

-Prakash

--00504502e2fd21403a048f0c93b1
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi,<br>=A0=A0=A0 I am trying to port Xenomai-2.4.0 on ARM AT91RM9200 proces=
sor. I used adeos-ipipe-2.6.20-arm-1.7-06.patch with Linux kernel 2.6.20. A=
ll the stuffs went fine, compiled the kernel and ported on the same process=
or. The xenomai components loaded fine while loading the kernel image. Howe=
ver when I executed the xeno-test, I am getting the error,=A0 &quot;please =
build busybox&#39;s ash with support for getopts&quot; and quit the test.<b=
r>

<br>I am using BusyBox-1.15.3 enabled with GETOPT. I noticed that the &quot=
;getopts&quot; link is not available with the busybox bin. But it has only =
&quot;getopt&quot;. I checked few other latest version of Busybox. But I co=
uld not find it in other versions also. However the x86 desktop Linux conta=
ins both getopt and getopts.<br>
<br>Few online guides claimed that the getopts is builtin with Busybox. I c=
reated an getopts softlink for busybox manually anf then tried the xeno-tes=
t. But getting the error,=A0 <style type=3D"text/css">e: pre-wrap; }</style=
>&quot;getopts: applet not found&quot;. I could not find the exact reason f=
or this issue. I also tried to execute the tests separately like latency, s=
witchtest,.etc. But getting the same error, <style type=3D"text/css">{ whit=
e-space: pre-wrap; }</style>&quot;syntax error: word unexpected (expecting =
&quot;)&quot;)&quot;.<br>
<br>FYI, the busybox configured with ASH shell.<br><br>Help me to solve the=
 issues.<br><br>-Prakash<br>=20


--00504502e2fd21403a048f0c93b1--

