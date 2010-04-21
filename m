MIME-Version: 1.0
Date: Wed, 21 Apr 2010 16:55:24 +0530
Message-ID: <k2xbfcfb7e81004210425l88dbbb99gb8b1ec4dd254300d@domain.hid>
From: Nero Fernandez <grimlynch@domain.hid>
Content-Type: multipart/alternative; boundary=001636b14ca344b9b50484bd73eb
Subject: [Xenomai-core] [xeno_switchtest] missing linux-dev registration?
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai@xenomai.org

--001636b14ca344b9b50484bd73eb
Content-Type: text/plain; charset=ISO-8859-1

This is regarding the pervasive error "Unable to open switchtest device"
while
trying to test context-switch timings using 'switchtest' testsuite
application.

Looking at the testsuite code, i found that
  - 'latency' (which can successfully operate the xeno_switchtest driver )
     uses rtdm_dev_xxx calls whereas
 - 'switchtest' application uses the posix 'open'/'close' system-calls
    for driver-interaction

Looking at ksrc/drivers/testing/switchtest.c, i found that there is no
registration
of switchtest under linux-device-driver subsystem (even as a misc driver
like rtnet or rtheap do).
Thus, there doesnt seem to be a way through which a linux-process (non-RT
mode)
may access xeno_switchtest driver through /dev/rttest<x>
(or the new /dev/rttest-switchtst<x>
  ref: https://mail.gna.org/public/xenomai-git/2010-04/msg00073.html).

In case there is such a registration required, i would be more than willing
to contribute.

In case, the 'open' system-call is handled by one of the skins
 (i have native, posix,rtai and rtdm enabled in my kernel-config),
kindly point out the code and enlighten.

Thanks for running this awesome project and all the help/pointers.

--001636b14ca344b9b50484bd73eb
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

This is regarding the pervasive error &quot;Unable to open switchtest devic=
e&quot; while <br>trying to test context-switch timings using &#39;switchte=
st&#39; testsuite application.<br><br>Looking at the testsuite code, i foun=
d that <br>
=A0 - &#39;latency&#39; (which can successfully operate the xeno_switchtest=
 driver ) <br>=A0=A0=A0=A0 uses rtdm_dev_xxx calls whereas <br>=A0- &#39;sw=
itchtest&#39; application uses the posix &#39;open&#39;/&#39;close&#39; sys=
tem-calls <br>
=A0=A0=A0 for driver-interaction<br><br>Looking at ksrc/drivers/testing/swi=
tchtest.c, i found that there is no registration<br>of switchtest under lin=
ux-device-driver subsystem (even as a misc driver like rtnet or rtheap do).=
<br>
Thus, there doesnt seem to be a way through which a linux-process (non-RT m=
ode)<br>may access xeno_switchtest driver through /dev/rttest&lt;x&gt; <br>=
(or the new /dev/rttest-switchtst&lt;x&gt;<br>=A0 ref: <a href=3D"https://m=
ail.gna.org/public/xenomai-git/2010-04/msg00073.html">https://mail.gna.org/=
public/xenomai-git/2010-04/msg00073.html</a>).<br>
<br>In case there is such a registration required, i would be more than wil=
ling to contribute.<br><br>In case, the &#39;open&#39; system-call is handl=
ed by one of the skins<br>=A0(i have native, posix,rtai and rtdm enabled in=
 my kernel-config),<br>
kindly point out the code and enlighten.<br><br>Thanks for running this awe=
some project and all the help/pointers.<br>

--001636b14ca344b9b50484bd73eb--

