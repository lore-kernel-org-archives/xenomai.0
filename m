From: Sambasiva Rao Manchili <sambasiva.manchili@domain.hid>
Date: Wed, 3 Aug 2011 12:15:52 +0200
Message-ID: <509DA52866E38F47878413CF102D751FD4207794F0@domain.hid>
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_509DA52866E38F47878413CF102D751FD4207794F0poseidonnexus_"
MIME-Version: 1.0
Subject: [Xenomai-help] Xenomai VxWorks Skin--->semTake
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
Cc: Antonio Gambin <antonio.gambin@domain.hid>

--_000_509DA52866E38F47878413CF102D751FD4207794F0poseidonnexus_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hallo ,
Most of  code containing semTake with (WAIT_FOREVER ) ported from VxWorks t=
o Linux using Xenomai is working, but only the following semTake is always =
failing.

For Example:-
semTake( restab_access_smp, 1200).

Semaphore created successfully and exists.
Any reason and any hint?

Semaphore created without ERROR as follows.
if ((restab_access_smp =3D semMCreate (SEM_Q_PRIORITY | SEM_DELETE_SAFE
           | SEM_INVERSION_SAFE)) =3D=3D NULL)
{
   ERROR
}

Thanks,
Samba.


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

--_000_509DA52866E38F47878413CF102D751FD4207794F0poseidonnexus_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<meta name=3D"GENERATOR" content=3D"MSHTML 8.00.6001.19088">
</head>
<body>
<div><font size=3D"2" face=3D"Tahoma"><span class=3D"662580910-03082011">Ha=
llo ,</span></font></div>
<div><font size=3D"2" face=3D"Tahoma"><span class=3D"662580910-03082011">Mo=
st of&nbsp; code containing semTake with (WAIT_FOREVER )&nbsp;ported from V=
xWorks to Linux using Xenomai is working, but only the following semTake is=
 always failing.</span></font></div>
<div><font size=3D"2" face=3D"Tahoma"><span class=3D"662580910-03082011"></=
span></font>&nbsp;</div>
<div><font size=3D"2" face=3D"Tahoma"><span class=3D"662580910-03082011"><u=
>For Example:-</u></span></font></div>
<div><font face=3D"Tahoma"><font size=3D"2">semTake( restab_access_smp,&nbs=
p;<span class=3D"662580910-03082011">1200</span>)<span class=3D"662580910-0=
3082011">.</span></font></font></div>
<div><font face=3D"Tahoma"><font size=3D"2"><span class=3D"662580910-030820=
11"></span></font></font>&nbsp;</div>
<div><font face=3D"Tahoma"><font size=3D"2"><span class=3D"662580910-030820=
11">Semaphore created successfully and exists.
</span></font></font></div>
<div><font face=3D"Tahoma"><font size=3D"2"><span class=3D"662580910-030820=
11">Any reason and any hint?</span></font></font></div>
<div><font face=3D"Tahoma"><font size=3D"2"><span class=3D"662580910-030820=
11"></span></font></font>&nbsp;</div>
<div><font face=3D"Tahoma"><font size=3D"2"><span class=3D"662580910-030820=
11">Semaphore created&nbsp;without ERROR&nbsp;as follows.</span></font></fo=
nt></div>
<div><font face=3D"Tahoma"><font size=3D"2"><span class=3D"662580910-030820=
11">if ((restab_access_smp =3D semMCreate (SEM_Q_PRIORITY | SEM_DELETE_SAFE=
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; | SEM_INVERSIO=
N_SAFE)) =3D=3D NULL)</span></font></font></div>
<div><font face=3D"Tahoma"><font size=3D"2"><span class=3D"662580910-030820=
11">{</span></font></font></div>
<div><font face=3D"Tahoma"><font size=3D"2"><span class=3D"662580910-030820=
11">&nbsp;&nbsp; ERROR</span></font></font></div>
<div><font face=3D"Tahoma"><font size=3D"2"><span class=3D"662580910-030820=
11">}</span></font></font></div>
<div><font face=3D"Tahoma"><font size=3D"2"><span class=3D"662580910-030820=
11"></span></font></font>&nbsp;</div>
<div><font face=3D"Tahoma"><font size=3D"2"><span class=3D"662580910-030820=
11">Thanks,</span></font></font></div>
<div><font face=3D"Tahoma"><font size=3D"2"><span class=3D"662580910-030820=
11">Samba.</span></font></font></div>
<div><font size=3D"2" face=3D"Tahoma"></font>&nbsp;</div>
<div>&nbsp;</div>
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

--_000_509DA52866E38F47878413CF102D751FD4207794F0poseidonnexus_--


