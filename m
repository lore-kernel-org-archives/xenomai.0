From: "??" <ma.q@domain.hid>
Date: Thu, 8 Mar 2012 11:13:16 +0800
Message-ID: <001501ccfcd9$67d9ede0$378dc9a0$@q@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_NextPart_000_0016_01CCFD1C.75FD2DE0"
Content-Language: zh-cn
Subject: [Xenomai-help] Xenomai stop working
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

This is a multi-part message in MIME format.

------=_NextPart_000_0016_01CCFD1C.75FD2DE0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi

  I have installed xenomai-2.5.6 on imx53 quick start board with Linux
2.6.35, it works well but stop working when I do some kernel real time task.

  When it stop working, system is not totally down, it will be recovered
after about 8~9 minutes, which comes
<dict://key.60705A9F3503084A844B4ABE47E5D62A/regular> regularly. Console
operation is as normal if no IO task and without increasing of timer
interrupt count(cat /proc/interrupt) before xenomai coming back. I have also
tested it with Linux 2.6.38 and xenomai-2.6.0, nothing has changed.

  Maybe there are some bugs in my task code, or some misuse of the skin
interface. I need help to get some idea:

  1 Is there any situation lead to such case(stalled about 8~9 minutes)?

  2 Can ipipe trace and proc information give anything useful, which I have
to get deeper into implements.

 


------=_NextPart_000_0016_01CCFD1C.75FD2DE0
Content-Type: text/html;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" =
xmlns:o=3D"urn:schemas-microsoft-com:office:office" =
xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" =
xmlns=3D"http://www.w3.org/TR/REC-html40"><head><META =
HTTP-EQUIV=3D"Content-Type" CONTENT=3D"text/html; =
charset=3Dus-ascii"><meta name=3DGenerator content=3D"Microsoft Word 12 =
(filtered medium)"><style><!--
/* Font Definitions */
@font-face
	{font-family:\5B8B\4F53;
	panose-1:2 1 6 0 3 1 1 1 1 1;}
@font-face
	{font-family:\5B8B\4F53;
	panose-1:2 1 6 0 3 1 1 1 1 1;}
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
@font-face
	{font-family:"\@\5B8B\4F53";
	panose-1:2 1 6 0 3 1 1 1 1 1;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0cm;
	margin-bottom:.0001pt;
	text-align:justify;
	text-justify:inter-ideograph;
	font-size:10.5pt;
	font-family:"Calibri","sans-serif";}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:blue;
	text-decoration:underline;}
a:visited, span.MsoHyperlinkFollowed
	{mso-style-priority:99;
	color:purple;
	text-decoration:underline;}
span.EmailStyle17
	{mso-style-type:personal-compose;
	font-family:\5B8B\4F53;
	color:windowtext;
	font-weight:normal;
	font-style:normal;
	text-decoration:none none;}
.MsoChpDefault
	{mso-style-type:export-only;}
/* Page Definitions */
@page WordSection1
	{size:612.0pt 792.0pt;
	margin:72.0pt 90.0pt 72.0pt 90.0pt;}
div.WordSection1
	{page:WordSection1;}
--></style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext=3D"edit" spidmax=3D"1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext=3D"edit">
<o:idmap v:ext=3D"edit" data=3D"1" />
</o:shapelayout></xml><![endif]--></head><body lang=3DZH-CN link=3Dblue =
vlink=3Dpurple style=3D'text-justify-trim:punctuation'><div =
class=3DWordSection1><p class=3DMsoNormal><span lang=3DEN-US =
style=3D'font-size:9.0pt;font-family:&#23435;&#20307;'>Hi<o:p></o:p></spa=
n></p><p class=3DMsoNormal style=3D'line-height:14.4pt'><span =
lang=3DEN-US =
style=3D'font-size:9.0pt;font-family:&#23435;&#20307;'>&nbsp; I have =
installed xenomai-2.5.6 on imx53 quick start board with Linux 2.6.35, it =
works well but stop working when I do some kernel real time =
task.<o:p></o:p></span></p><p class=3DMsoNormal =
style=3D'line-height:14.4pt'><span lang=3DEN-US =
style=3D'font-size:9.0pt;font-family:&#23435;&#20307;'>&nbsp; When it =
stop working, system is not totally down, it will be recovered after =
about 8~9 minutes, which comes <a =
href=3D"dict://key.60705A9F3503084A844B4ABE47E5D62A/regular" =
title=3D"&#26597;&#25214;: regular"><span =
style=3D'color:windowtext;text-decoration:none'>regular</span></a>ly. =
Console operation is as normal if no IO task and without increasing of =
timer interrupt count(cat /proc/interrupt) before xenomai coming back. I =
have also tested it with Linux 2.6.38 and xenomai-2.6.0, nothing has =
changed.<o:p></o:p></span></p><p class=3DMsoNormal =
style=3D'line-height:14.4pt'><span lang=3DEN-US =
style=3D'font-size:9.0pt;font-family:&#23435;&#20307;'>&nbsp; Maybe =
there are some bugs in my task code, or some misuse of the skin =
interface. I need help to get some idea:<o:p></o:p></span></p><p =
class=3DMsoNormal style=3D'line-height:14.4pt'><span lang=3DEN-US =
style=3D'font-size:9.0pt;font-family:&#23435;&#20307;'>&nbsp; 1 Is there =
any situation lead to such case(stalled about 8~9 =
minutes)?<o:p></o:p></span></p><p class=3DMsoNormal =
style=3D'line-height:14.4pt'><span lang=3DEN-US =
style=3D'font-size:9.0pt;font-family:&#23435;&#20307;'>&nbsp; 2 Can =
ipipe trace and proc information give anything useful, which I have to =
get deeper into implements.<o:p></o:p></span></p><p =
class=3DMsoNormal><span lang=3DEN-US =
style=3D'font-size:9.0pt;font-family:&#23435;&#20307;'><o:p>&nbsp;</o:p><=
/span></p></div></body></html>
------=_NextPart_000_0016_01CCFD1C.75FD2DE0--



