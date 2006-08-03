Message-ID: <20060803154437.90346.qmail@domain.hid>
Date: Thu, 3 Aug 2006 08:44:37 -0700 (PDT)
From: shailesh joshi <zoshi_s@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/alternative; boundary="0-1467913123-1154619877=:90016"
Content-Transfer-Encoding: 8bit
Subject: [Xenomai-help] Interrupt Problem.
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

--0-1467913123-1154619877=:90016
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hello,
  =20
  I am trying to interfce a DAQ board to a PC via a PCI card. I am facing t=
he following problem:
  =20
  I am trying to send an interrupt from the Board to the PC. However, the i=
nterrupt is only registered in the PCI cards internal registers and not by =
Xenomai, ie.  the /proc/xenomai/ interface registers interrupt 10 in the li=
st (namely, handler is being installed) but the count for both cpus remains=
 at 0.=20
  =20
  To give a hint of the code, i am using a modified version of the RTDM dri=
ver example from captain.at. The only parts i haven't incorporated are thos=
e for MMAP, else the code is fast the same. Could anyone suggest what i mig=
ht be doing wrong here??
  =20
  =20
  Regards,
  Shailesh Joshi

 	=09
---------------------------------
Talk is cheap. Use Yahoo! Messenger to make PC-to-Phone calls.  Great rates=
 starting at 1=A2/min.
--0-1467913123-1154619877=:90016
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<div>Hello,</div>  <div>&nbsp;</div>  <div>I am trying to interfce a DAQ bo=
ard to a PC via a PCI card. I am facing the following problem:</div>  <div>=
&nbsp;</div>  <div>I am trying to send an interrupt from the Board to the P=
C. However, the interrupt is only registered in the PCI cards internal regi=
sters and not by Xenomai, ie.&nbsp; the /proc/xenomai/ interface registers =
interrupt 10 in the list (namely, handler is being installed) but the count=
 for both cpus remains at 0. </div>  <div>&nbsp;</div>  <div>To give a hint=
 of the code, i am using a modified version of the RTDM driver example from=
 captain.at. The only parts i haven't incorporated are those for MMAP, else=
 the code is fast the same. Could anyone suggest what i might be doing wron=
g here??</div>  <div>&nbsp;</div>  <div>&nbsp;</div>  <div>Regards,</div>  =
<div>Shailesh Joshi</div><p>&#32;
		<hr size=3D1>Talk is cheap. Use Yahoo! Messenger to make PC-to-Phone call=
s. <a href=3D"http://us.rd.yahoo.com/mail_us/taglines/postman7/*http://us.r=
d.yahoo.com/evt=3D39666/*http://messenger.yahoo.com"> Great rates starting =
at 1=A2/min.
--0-1467913123-1154619877=:90016--

