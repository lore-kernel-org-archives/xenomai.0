From: Sambasiva Rao Manchili <sambasiva.manchili@domain.hid>
Date: Thu, 1 Sep 2011 12:23:24 +0200
Message-ID: <509DA52866E38F47878413CF102D751FED236D782F@poseidon.nexus-ag.com>
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_509DA52866E38F47878413CF102D751FED236D782Fposeidonnexus_"
MIME-Version: 1.0
Subject: [Xenomai-help] taskDelete(tid) on VxWorks Skin ?
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: "Xenomai-help@domain.hid" <Xenomai-help@domain.hid>

--_000_509DA52866E38F47878413CF102D751FED236D782Fposeidonnexus_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hallo,
During cleanup routines we call taskDelete(tid)   but for some reasons we s=
ee that taskDelete is not working as expected though status returned by tas=
kDelete call is 0(OK) and
further leads to crash as the task still exists(not deleted as assumed to b=
e deleted with taskDelete) and trying to do something....which is not valid=
 any more.
We use options as 0 while creating task.

Also tried taskDeleteForce, but did not help.   Any hints please.

To my knowledge,  Xenomai does not support any Hooks adding and deleing cal=
ls of Vxworks, we did not use them either.

But I got some info from  the following URL.
<http://www.xenomai.org/documentation/trunk/html/api/group__pod.html#gd2b76=
1fb70cad30339f092edb4a89587>


Thank you,
samba.

Sambasiva Rao Manchili
Software Development Engineer
________________________________

NEXUS TELECOM AG
Network and Service Investigation
Feldbachstrasse 80
8634 Hombrechtikon
Switzerland

Direct/mobile: +41 78 750 6808
Main: +41 44 355 6611
Email: sambasiva.manchili@domain.hid <mailto:sambasiva.manchili@domain.hid=
telecom.com>
Website: www.nexustelecom.com<http://www.nexustelecom.com/>

  [cid:335065507@domain.hid]


________________________________
This email and any attachment may contain confidential information which is=
 intended for use only by the addressee(s) named above. If you received thi=
s email by mistake, please notify the sender immediately, and delete the em=
ail from your system. You are prohibited from copying, disseminating or oth=
erwise using the email or any attachment.

--_000_509DA52866E38F47878413CF102D751FED236D782Fposeidonnexus_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<meta name=3D"GENERATOR" content=3D"MSHTML 8.00.6001.19120">
</head>
<body>
<div><span class=3D"962261410-01092011"><font size=3D"2" face=3D"Tahoma">Ha=
llo,</font></span></div>
<div><span class=3D"962261410-01092011"><font size=3D"2" face=3D"Tahoma">Du=
ring cleanup routines we call taskDelete(tid)&nbsp;&nbsp; but for some reas=
ons we see that taskDelete is not working as expected though status returne=
d by taskDelete call is 0(OK) and
</font></span></div>
<div><span class=3D"962261410-01092011"><font size=3D"2" face=3D"Tahoma">fu=
rther leads to crash as the task still exists(not deleted as assumed to be =
deleted&nbsp;with taskDelete)&nbsp;and trying to do something....which is n=
ot valid any more.</font></span></div>
<div><span class=3D"962261410-01092011"><font size=3D"2" face=3D"Tahoma">We=
 use options as 0 while creating task.</font></span></div>
<div><span class=3D"962261410-01092011"><font size=3D"2" face=3D"Tahoma"></=
font></span>&nbsp;</div>
<div><span class=3D"962261410-01092011"><font size=3D"2" face=3D"Tahoma">Al=
so tried taskDeleteForce, but did not help.&nbsp;&nbsp; Any hints please.</=
font></span></div>
<div><span class=3D"962261410-01092011"><font size=3D"2" face=3D"Tahoma"></=
font></span>&nbsp;</div>
<div><span class=3D"962261410-01092011"><font size=3D"2" face=3D"Tahoma">To=
 my knowledge,&nbsp; Xenomai does not support any Hooks adding and deleing =
calls of Vxworks, we did not use them either.</font></span></div>
<div><span class=3D"962261410-01092011"><font size=3D"2" face=3D"Tahoma"></=
font></span>&nbsp;</div>
<div><span class=3D"962261410-01092011"><font size=3D"2" face=3D"Tahoma">Bu=
t I got some info from &nbsp;the following URL.</font></span></div>
<div><span class=3D"962261410-01092011"><font size=3D"2" face=3D"Tahoma">&l=
t;<a href=3D"http://www.xenomai.org/documentation/trunk/html/api/group__pod=
.html#gd2b761fb70cad30339f092edb4a89587"><font size=3D"3" face=3D"Times New=
 Roman">http://www.xenomai.org/documentation/trunk/html/api/group__pod.html=
#gd2b761fb70cad30339f092edb4a89587</font></a>&gt;</font></span></div>
<div><font size=3D"2" face=3D"Tahoma"></font>&nbsp;</div>
<div><font size=3D"2" face=3D"Tahoma"></font>&nbsp;</div>
<div><span class=3D"962261410-01092011"><font size=3D"2" face=3D"Tahoma">Th=
ank you,</font></span></div>
<div><span class=3D"962261410-01092011"><font size=3D"2" face=3D"Tahoma">sa=
mba.</font></span></div>
<div><span class=3D"962261410-01092011"></span>&nbsp;</div>
<div align=3D"left"><font face=3D"Verdana"><font size=3D"2"><strong>Sambasi=
va Rao Manchili<br>
</strong>Software Development Engineer <br>
________________________________<br>
&nbsp;<br>
</font><font color=3D"#007bc0" size=3D"3"><b>NEXUS TELECOM AG</b></font></f=
ont> <font color=3D"#000000" size=3D"2" face=3D"Verdana, Arial, Helvetica, =
sans-serif">
<br>
Network and Service Investigation<br>
</div>
</font><font color=3D"#000000" size=3D"2" face=3D"Verdana, Arial, Helvetica=
, sans-serif">
<div align=3D"left"><span class=3D"335065507-19072011"><font size=3D"2" fac=
e=3D"Arial">Feldbachstrasse 80</font></span></div>
<div align=3D"left"><span class=3D"335065507-19072011">8634 Hombrechtikon</=
span></div>
<div align=3D"left">Switzerland<br>
<br>
Direct/mobile: &#43;41 78 750 6808<br>
Main: &#43;41 44 355 6611<br>
Email: <a title=3D"mailto:sambasiva.manchili@domain.hid" href=3D"mail=
to:sambasiva.manchili@domain.hid">
<font title=3D"mailto:sambasiva.manchili@domain.hid" color=3D"#000000=
" size=3D"2" face=3D"Verdana, Arial, Helvetica, sans-serif">sambasiva.manch=
ili@domain.hid
</font></a><br>
Website: <a title=3D"http://www.nexustelecom.com/" href=3D"http://www.nexus=
telecom.com/">
<font title=3D"http://www.nexustelecom.com/" color=3D"#000000" size=3D"2" f=
ace=3D"Verdana, Arial, Helvetica, sans-serif">www.nexustelecom.com</font></=
a><br>
<br>
&nbsp;<span style=3D"FONT-FAMILY: Verdana; mso-bidi-font-family: Arial">
<?xml:namespace prefix=20
=3D o ns =3D "urn:schemas-microsoft-com:office:office" />
<o:p><img border=3D"0" hspace=3D"0" alt=3D"" align=3D"baseline" src=3D"cid:=
335065507@domain.hid"></o:p></span></font></div>
<div>&nbsp;</div>
<br>
<hr>
<font face=3D"Arial" color=3D"Gray" size=3D"1">This email and any attachmen=
t may contain confidential information which is intended for use only by th=
e addressee(s) named above. If you received this email by mistake, please n=
otify the sender immediately, and delete
 the email from your system. You are prohibited from copying, disseminating=
 or otherwise using the email or any attachment.<br>
</font>
</body>
</html>

--_000_509DA52866E38F47878413CF102D751FED236D782Fposeidonnexus_--


