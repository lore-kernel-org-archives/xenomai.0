From: "Urs.Eichholzer" <urs.eichholzer@domain.hid>
Date: Thu, 28 Feb 2008 19:54:19 +0700
Message-ID: <001501c87a09$08a9f6f0$2401a8c0@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_NextPart_000_0016_01C87A43.B508CEF0"
Subject: [Xenomai-help] FW: xeno_can: socket buffer overflow for fd=0
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

This is a multi-part message in MIME format.

------=_NextPart_000_0016_01C87A43.B508CEF0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit

Dear Xenomai Help
 
The write to CAN is fast and have no problem... this can  be performed
fast and even in microsecond  resolution 

The read to CAN is working... but not fast enough as we expect it should
be reading the network... The Xenomai CAN  can  read the network
transfers in seconds and  about 40 milliseconds but once the read is
performed on a much faster rate... the Xenomai CAN is having errors
already... The message is:
xeno_can: socket buffer overflow for fd=0

Something like this would be printed on screen and the system scrolls
with this message again and again.

Here are some of the remedies I tried but still this problem occurs:

1.) Increase the buffer size for receive in the menuconfig from 1024 to
4096, same problem.

2.) Link the CAN drivers statically to the OS, same problem.

3.) Link the CAN drivers with dynamic loading of driver, same problem.

4.) Create my own test program, same problem

5.) Create my own xenomai task based on how a task should be made, same
problem...


I have investigated this and it is coming from the rtdm file of
Xenomai... when it detects  a low buffer resource, it will  trigger this
error. But allocating more buffer space to 4096 will not solve this
problem. On my investigation, the problem is buried deep in the Xenomai
itself for the CAN driver and RTCAN socket. The file which is
responsible for this is involved in the Xenomai RTCAN driver support.
 
Best Regards
 
Urs
 

------=_NextPart_000_0016_01C87A43.B508CEF0
Content-Type: text/html;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" =
xmlns:o=3D"urn:schemas-microsoft-com:office:office" =
xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns=3D"http://www.w3.org/TR/REC-html40">

<head>
<META HTTP-EQUIV=3D"Content-Type" CONTENT=3D"text/html; =
charset=3Dus-ascii">


<meta name=3DProgId content=3DWord.Document>
<meta name=3DGenerator content=3D"Microsoft Word 10">
<meta name=3DOriginator content=3D"Microsoft Word 10">
<link rel=3DFile-List href=3D"cid:filelist.xml@domain.hid">
<!--[if gte mso 9]><xml>
 <o:OfficeDocumentSettings>
  <o:DoNotRelyOnCSS/>
 </o:OfficeDocumentSettings>
</xml><![endif]--><!--[if gte mso 9]><xml>
 <w:WordDocument>
  <w:SpellingState>Clean</w:SpellingState>
  <w:GrammarState>Clean</w:GrammarState>
  <w:DocumentKind>DocumentEmail</w:DocumentKind>
  <w:EnvelopeVis/>
  <w:Compatibility>
   <w:BreakWrappedTables/>
   <w:SnapToGridInCell/>
   <w:ApplyBreakingRules/>
   <w:WrapTextWithPunct/>
   <w:UseAsianBreakRules/>
  </w:Compatibility>
  <w:BrowserLevel>MicrosoftInternetExplorer4</w:BrowserLevel>
 </w:WordDocument>
</xml><![endif]-->
<style>
<!--
 /* Style Definitions */
 p.MsoNormal, li.MsoNormal, div.MsoNormal
	{mso-style-parent:"";
	margin:0in;
	margin-bottom:.0001pt;
	mso-pagination:widow-orphan;
	font-size:12.0pt;
	font-family:"Times New Roman";
	mso-fareast-font-family:"Times New Roman";}
a:link, span.MsoHyperlink
	{color:blue;
	text-decoration:underline;
	text-underline:single;}
a:visited, span.MsoHyperlinkFollowed
	{color:purple;
	text-decoration:underline;
	text-underline:single;}
p.MsoAutoSig, li.MsoAutoSig, div.MsoAutoSig
	{margin:0in;
	margin-bottom:.0001pt;
	mso-pagination:widow-orphan;
	font-size:12.0pt;
	font-family:"Times New Roman";
	mso-fareast-font-family:"Times New Roman";}
span.EmailStyle18
	{mso-style-type:personal;
	mso-style-noshow:yes;
	mso-ansi-font-size:10.0pt;
	mso-bidi-font-size:10.0pt;
	font-family:Arial;
	mso-ascii-font-family:Arial;
	mso-hansi-font-family:Arial;
	mso-bidi-font-family:Arial;
	color:windowtext;}
span.EmailStyle19
	{mso-style-type:personal-reply;
	mso-style-noshow:yes;
	mso-ansi-font-size:10.0pt;
	mso-bidi-font-size:10.0pt;
	font-family:Arial;
	mso-ascii-font-family:Arial;
	mso-hansi-font-family:Arial;
	mso-bidi-font-family:Arial;
	color:navy;}
span.SpellE
	{mso-style-name:"";
	mso-spl-e:yes;}
@page Section1
	{size:595.3pt 841.9pt;
	margin:1.0in 1.25in 1.0in 1.25in;
	mso-header-margin:.5in;
	mso-footer-margin:.5in;
	mso-paper-source:0;}
div.Section1
	{page:Section1;}
-->
</style>
<!--[if gte mso 10]>
<style>
 /* Style Definitions */=20
 table.MsoNormalTable
	{mso-style-name:"Table Normal";
	mso-tstyle-rowband-size:0;
	mso-tstyle-colband-size:0;
	mso-style-noshow:yes;
	mso-style-parent:"";
	mso-padding-alt:0in 5.4pt 0in 5.4pt;
	mso-para-margin:0in;
	mso-para-margin-bottom:.0001pt;
	mso-pagination:widow-orphan;
	font-size:10.0pt;
	font-family:"Times New Roman";}
</style>
<![endif]-->
</head>

<body lang=3DEN-GB link=3Dblue vlink=3Dpurple =
style=3D'tab-interval:.5in'>

<div class=3DSection1>

<p class=3DMsoNormal><font size=3D3 color=3Dblack face=3D"Times New =
Roman"><span
style=3D'font-size:12.0pt;color:black'>Dear <span =
class=3DSpellE>Xenomai</span>
Help<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D3 color=3Dblack face=3D"Times New =
Roman"><span
style=3D'font-size:12.0pt;color:black'><o:p>&nbsp;</o:p></span></font></p=
>

<p class=3DMsoNormal><font size=3D3 color=3Dblack face=3D"Times New =
Roman"><span
style=3D'font-size:12.0pt;color:black'>The write to CAN is fast and have =
no
problem... this can&nbsp; be performed fast and even in =
microsecond&nbsp;
resolution <br>
<br>
The read to CAN is working... but not fast enough as we expect it should =
be
reading the network... The Xenomai CAN&nbsp; can&nbsp; read the network
transfers in seconds and&nbsp; about 40 milliseconds but once the read =
is
performed on a much faster rate... the Xenomai CAN is having errors =
already...
The message is:<br>
xeno_can: socket buffer overflow for fd=3D0<br>
<br>
Something like this would be printed on screen and the system scrolls =
with this
message again and again.<br>
<br>
Here are some of the remedies I tried but still this problem occurs:<br>
<br>
1.) Increase the buffer size for receive in the menuconfig from 1024 to =
4096,
same problem.<br>
<br>
2.) Link the CAN drivers statically to the OS, same problem.<br>
<br>
3.) Link the CAN drivers with dynamic loading of driver, same =
problem.<br>
<br>
4.) Create my own test program, same problem<br>
<br>
5.) Create my own xenomai task based on how a task should be made, same
problem...<br>
<br>
<br>
I have investigated this and it is coming from the rtdm file of&nbsp;
Xenomai... when it detects&nbsp; a low buffer resource, it will&nbsp; =
trigger
this error. But allocating more buffer space to 4096 will not solve this
problem. On my investigation, the problem is buried deep in the Xenomai =
itself
for the CAN driver and RTCAN socket. The file which is responsible for =
this is
involved in the Xenomai RTCAN driver support.</span></font><font =
size=3D2
face=3DArial><span =
style=3D'font-size:10.0pt;font-family:Arial'><o:p></o:p></span></font></p=
>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoAutoSig><font size=3D3 face=3D"Times New Roman"><span =
lang=3DDE-CH
style=3D'font-size:12.0pt;mso-ansi-language:DE-CH;mso-no-proof:yes'>Best =
Regards<o:p></o:p></span></font></p>

<p class=3DMsoAutoSig><font size=3D3 face=3D"Times New Roman"><span =
lang=3DDE-CH
style=3D'font-size:12.0pt;mso-ansi-language:DE-CH;mso-no-proof:yes'><o:p>=
&nbsp;</o:p></span></font></p>

<p class=3DMsoAutoSig><font size=3D3 face=3D"Times New Roman"><span =
lang=3DDE-CH
style=3D'font-size:12.0pt;mso-ansi-language:DE-CH;mso-no-proof:yes'>Urs</=
span><o:p></o:p></font></p>

<p class=3DMsoNormal><font size=3D3 face=3D"Times New Roman"><span =
style=3D'font-size:
12.0pt'><o:p>&nbsp;</o:p></span></font></p>

</div>

</body>

</html>

------=_NextPart_000_0016_01C87A43.B508CEF0--


