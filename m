From: "Gregory Gosse" <gregory.gosse@domain.hid>
Date: Wed, 4 Jan 2012 15:31:09 +0100
Message-ID: <000301cccaed$80667540$81335fc0$@soterem.fr>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_NextPart_000_0004_01CCCAF5.E22F7120"
Content-Language: fr
Subject: [Xenomai-help] unresolved symbol - check the xenomai installation
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

This is a multipart message in MIME format.

------=_NextPart_000_0004_01CCCAF5.E22F7120
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hello,

 

I have read here http://www.armadeus.com/wiki/index.php?title=Xenomai 

That the following commands can be used to check the xenomai installation :

$ dmesg | grep Xenomai

$ xeno-test

 

It gives the following results for me


root@domain.hid:~# dmesg | grep Xenomai 

[    2.229354] I-pipe: Domain Xenomai registered. 

[    2.229358] Xenomai: hal/i386 started. 

[    2.229368] Xenomai: scheduling class idle registered. 

[    2.229370] Xenomai: scheduling class rt registered. 

[    2.229804] Xenomai: real-time nucleus v2.6.0 (Movin' On) loaded. 

[    2.229806] Xenomai: debug mode enabled. 

[    2.229877] Xenomai: starting native API services. 

[    2.229878] Xenomai: starting POSIX services. 

[    2.229899] Xenomai: starting RTDM services.

 


Xeno-test

.

.

Utilisation 2313:  W.... 

 2316:  W..X. 

 2317:  GS... 

 2338:  W...V 

[Domain info] 

id=0x58454e4f 

priority=topmost 

 

mercredi 4 janvier 2012, 15:01:00 (UTC+0100) 

running: cat /proc/ipipe/version 

2.10-01 

 

mercredi 4 janvier 2012, 15:01:00 (UTC+0100) 

running: generate_loads 1 

dd workload started, pids 2602 stored in /var/lock/xeno-test.2461.pids 

 2602 pts/0    00:00:00 dd 

something died a 2602 or 

something died a 2602 or 

something died a 2602 or 

something died a 2602 or

.

.

 

I'm still unable to compile the native examples . The 'make' command  gives
such errors :


/tmp/ccqQeLZj.o: In function `demo':

trivial-periodic.c:(.text+0x2f): undefined reference to
`rt_task_set_periodic'

trivial-periodic.c:(.text+0x34): undefined reference to `rt_timer_read'

trivial-periodic.c:(.text+0x46): undefined reference to
`rt_task_wait_period'

trivial-periodic.c:(.text+0x4b): undefined reference to `rt_timer_read'

 

 

Please . Any idea to go further ?

 

Gregory

 


------=_NextPart_000_0004_01CCCAF5.E22F7120
Content-Type: text/html;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" =
xmlns:o=3D"urn:schemas-microsoft-com:office:office" =
xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" =
xmlns=3D"http://www.w3.org/TR/REC-html40"><head><META =
HTTP-EQUIV=3D"Content-Type" CONTENT=3D"text/html; =
charset=3Dus-ascii"><meta name=3DGenerator content=3D"Microsoft Word 14 =
(filtered medium)"><style><!--
/* Font Definitions */
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
@font-face
	{font-family:Tahoma;
	panose-1:2 11 6 4 3 5 4 4 2 4;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0cm;
	margin-bottom:.0001pt;
	font-size:11.0pt;
	font-family:"Calibri","sans-serif";
	mso-fareast-language:EN-US;}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:blue;
	text-decoration:underline;}
a:visited, span.MsoHyperlinkFollowed
	{mso-style-priority:99;
	color:purple;
	text-decoration:underline;}
p.MsoPlainText, li.MsoPlainText, div.MsoPlainText
	{mso-style-priority:99;
	mso-style-link:"Texte brut Car";
	margin:0cm;
	margin-bottom:.0001pt;
	font-size:11.0pt;
	font-family:"Calibri","sans-serif";
	mso-fareast-language:EN-US;}
p.MsoAcetate, li.MsoAcetate, div.MsoAcetate
	{mso-style-priority:99;
	mso-style-link:"Texte de bulles Car";
	margin:0cm;
	margin-bottom:.0001pt;
	font-size:8.0pt;
	font-family:"Tahoma","sans-serif";
	mso-fareast-language:EN-US;}
span.TextebrutCar
	{mso-style-name:"Texte brut Car";
	mso-style-priority:99;
	mso-style-link:"Texte brut";
	font-family:"Calibri","sans-serif";}
span.TextedebullesCar
	{mso-style-name:"Texte de bulles Car";
	mso-style-priority:99;
	mso-style-link:"Texte de bulles";
	font-family:"Tahoma","sans-serif";}
.MsoChpDefault
	{mso-style-type:export-only;
	font-family:"Calibri","sans-serif";
	mso-fareast-language:EN-US;}
@page WordSection1
	{size:612.0pt 792.0pt;
	margin:70.85pt 70.85pt 70.85pt 70.85pt;}
div.WordSection1
	{page:WordSection1;}
--></style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext=3D"edit" spidmax=3D"1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext=3D"edit">
<o:idmap v:ext=3D"edit" data=3D"1" />
</o:shapelayout></xml><![endif]--></head><body lang=3DFR link=3Dblue =
vlink=3Dpurple><div class=3DWordSection1><p class=3DMsoPlainText><span =
lang=3DEN-US>Hello,<o:p></o:p></span></p><p class=3DMsoPlainText><span =
lang=3DEN-US><o:p>&nbsp;</o:p></span></p><p class=3DMsoPlainText><span =
lang=3DEN-US>I have read here <a =
href=3D"http://www.armadeus.com/wiki/index.php?title=3DXenomai">http://ww=
w.armadeus.com/wiki/index.php?title=3DXenomai</a> =
<o:p></o:p></span></p><p class=3DMsoPlainText><span lang=3DEN-US>That =
the following commands can be used to check the xenomai installation =
:<o:p></o:p></span></p><p class=3DMsoPlainText><span lang=3DEN-US>$ =
dmesg | grep Xenomai<o:p></o:p></span></p><p class=3DMsoPlainText><span =
lang=3DEN-US>$ xeno-test<o:p></o:p></span></p><p =
class=3DMsoPlainText><span lang=3DEN-US><o:p>&nbsp;</o:p></span></p><p =
class=3DMsoPlainText><span lang=3DEN-US>It gives the following results =
for me<o:p></o:p></span></p><table class=3DMsoTableGrid border=3D1 =
cellspacing=3D0 cellpadding=3D0 =
style=3D'border-collapse:collapse;border:none'><tr><td width=3D636 =
valign=3Dtop style=3D'width:477.3pt;border:solid windowtext =
1.0pt;padding:0cm 5.4pt 0cm 5.4pt'><p class=3DMsoPlainText><span =
lang=3DEN-US>root@domain.hid:~# dmesg | grep Xenomai =
<o:p></o:p></span></p><p class=3DMsoPlainText><span =
lang=3DEN-US>[&nbsp;&nbsp;&nbsp; 2.229354] I-pipe: Domain Xenomai =
registered. <o:p></o:p></span></p><p class=3DMsoPlainText><span =
lang=3DEN-US>[&nbsp;&nbsp;&nbsp; 2.229358] Xenomai: hal/i386 started. =
<o:p></o:p></span></p><p class=3DMsoPlainText><span =
lang=3DEN-US>[&nbsp;&nbsp;&nbsp; 2.229368] Xenomai: scheduling class =
idle registered. <o:p></o:p></span></p><p class=3DMsoPlainText><span =
lang=3DEN-US>[&nbsp;&nbsp;&nbsp; 2.229370] Xenomai: scheduling class rt =
registered. <o:p></o:p></span></p><p class=3DMsoPlainText><span =
lang=3DEN-US>[&nbsp;&nbsp;&nbsp; 2.229804] Xenomai: real-time nucleus =
v2.6.0 (Movin' On) loaded. <o:p></o:p></span></p><p =
class=3DMsoPlainText><span lang=3DEN-US>[&nbsp;&nbsp;&nbsp; 2.229806] =
Xenomai: debug mode enabled. <o:p></o:p></span></p><p =
class=3DMsoPlainText><span lang=3DEN-US>[&nbsp;&nbsp;&nbsp; 2.229877] =
Xenomai: starting native API services. <o:p></o:p></span></p><p =
class=3DMsoPlainText><span lang=3DEN-US>[&nbsp;&nbsp;&nbsp; 2.229878] =
Xenomai: starting POSIX services. <o:p></o:p></span></p><p =
class=3DMsoPlainText><span lang=3DEN-US>[&nbsp;&nbsp;&nbsp; 2.229899] =
Xenomai: starting RTDM =
services.<o:p></o:p></span></p></td></tr></table><p =
class=3DMsoPlainText><span =
lang=3DEN-US><o:p>&nbsp;</o:p></span></p><table class=3DMsoTableGrid =
border=3D1 cellspacing=3D0 cellpadding=3D0 =
style=3D'border-collapse:collapse;border:none'><tr><td width=3D636 =
valign=3Dtop style=3D'width:477.3pt;border:solid windowtext =
1.0pt;padding:0cm 5.4pt 0cm 5.4pt'><p class=3DMsoPlainText><span =
lang=3DEN-US>Xeno-test<o:p></o:p></span></p><p =
class=3DMsoPlainText><span lang=3DEN-US>&#8230;<o:p></o:p></span></p><p =
class=3DMsoPlainText>&#8230;<o:p></o:p></p><p =
class=3DMsoPlainText>Utilisation 2313:&nbsp; W.... <o:p></o:p></p><p =
class=3DMsoPlainText>&nbsp;2316:&nbsp; W..X. <o:p></o:p></p><p =
class=3DMsoPlainText>&nbsp;2317:&nbsp; GS... <o:p></o:p></p><p =
class=3DMsoPlainText>&nbsp;<span lang=3DEN-US>2338:&nbsp; W...V =
<o:p></o:p></span></p><p class=3DMsoPlainText><span lang=3DEN-US>[Domain =
info] <o:p></o:p></span></p><p class=3DMsoPlainText><span =
lang=3DEN-US>id=3D0x58454e4f <o:p></o:p></span></p><p =
class=3DMsoPlainText><span lang=3DEN-US>priority=3Dtopmost =
<o:p></o:p></span></p><p class=3DMsoPlainText><span =
lang=3DEN-US>&nbsp;<o:p></o:p></span></p><p class=3DMsoPlainText><span =
lang=3DEN-US>mercredi 4 janvier 2012, 15:01:00 (UTC+0100) =
<o:p></o:p></span></p><p class=3DMsoPlainText><span =
lang=3DEN-US>running: cat /proc/ipipe/version <o:p></o:p></span></p><p =
class=3DMsoPlainText><span lang=3DEN-US>2.10-01 <o:p></o:p></span></p><p =
class=3DMsoPlainText><span lang=3DEN-US>&nbsp;<o:p></o:p></span></p><p =
class=3DMsoPlainText><span lang=3DEN-US>mercredi 4 janvier 2012, =
15:01:00 (UTC+0100) <o:p></o:p></span></p><p class=3DMsoPlainText><span =
lang=3DEN-US>running: generate_loads 1 <o:p></o:p></span></p><p =
class=3DMsoPlainText><span lang=3DEN-US>dd workload started, pids 2602 =
stored in /var/lock/xeno-test.2461.pids <o:p></o:p></span></p><p =
class=3DMsoPlainText><span lang=3DEN-US>&nbsp;2602 =
pts/0&nbsp;&nbsp;&nbsp; 00:00:00 dd <o:p></o:p></span></p><p =
class=3DMsoPlainText><span lang=3DEN-US>something died a 2602 or =
<o:p></o:p></span></p><p class=3DMsoPlainText><span =
lang=3DEN-US>something died a 2602 or <o:p></o:p></span></p><p =
class=3DMsoPlainText><span lang=3DEN-US>something died a 2602 or =
<o:p></o:p></span></p><p class=3DMsoPlainText><span =
lang=3DEN-US>something died a 2602 or<o:p></o:p></span></p><p =
class=3DMsoPlainText><span lang=3DEN-US>&#8230;<o:p></o:p></span></p><p =
class=3DMsoPlainText><span =
lang=3DEN-US>&#8230;<o:p></o:p></span></p></td></tr></table><p =
class=3DMsoPlainText><span lang=3DEN-US><o:p>&nbsp;</o:p></span></p><p =
class=3DMsoPlainText><span lang=3DEN-US>I&#8217;m still unable to =
compile the native examples . The &#8216;make&#8217; command &nbsp;gives =
such errors :<o:p></o:p></span></p><table class=3DMsoTableGrid =
border=3D1 cellspacing=3D0 cellpadding=3D0 =
style=3D'border-collapse:collapse;border:none'><tr><td width=3D636 =
valign=3Dtop style=3D'width:477.3pt;border:solid windowtext =
1.0pt;padding:0cm 5.4pt 0cm 5.4pt'><p class=3DMsoPlainText><span =
lang=3DEN-US style=3D'font-family:"Courier =
New";color:red'>/tmp/ccqQeLZj.o: In function =
`demo':<o:p></o:p></span></p><p class=3DMsoPlainText><span lang=3DEN-US =
style=3D'font-family:"Courier =
New";color:red'>trivial-periodic.c:(.text+0x2f): undefined reference to =
`rt_task_set_periodic'<o:p></o:p></span></p><p =
class=3DMsoPlainText><span lang=3DEN-US style=3D'font-family:"Courier =
New";color:red'>trivial-periodic.c:(.text+0x34): undefined reference to =
`rt_timer_read'<o:p></o:p></span></p><p class=3DMsoPlainText><span =
lang=3DEN-US style=3D'font-family:"Courier =
New";color:red'>trivial-periodic.c:(.text+0x46): undefined reference to =
`rt_task_wait_period'<o:p></o:p></span></p><p class=3DMsoPlainText><span =
lang=3DEN-US style=3D'font-family:"Courier =
New";color:red'>trivial-periodic.c:(.text+0x4b): undefined reference to =
`rt_timer_read'<o:p></o:p></span></p><p class=3DMsoPlainText><span =
lang=3DEN-US><o:p>&nbsp;</o:p></span></p></td></tr></table><p =
class=3DMsoPlainText><span lang=3DEN-US><o:p>&nbsp;</o:p></span></p><p =
class=3DMsoPlainText><span lang=3DEN-US>Please . Any idea to go further =
?<o:p></o:p></span></p><p class=3DMsoPlainText><span =
lang=3DEN-US><o:p>&nbsp;</o:p></span></p><p class=3DMsoPlainText><span =
lang=3DEN-US>Gregory<o:p></o:p></span></p><p class=3DMsoPlainText><span =
lang=3DEN-US><o:p>&nbsp;</o:p></span></p></div></body></html>
------=_NextPart_000_0004_01CCCAF5.E22F7120--


