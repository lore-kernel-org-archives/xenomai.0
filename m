From: "Urs.Eichholzer" <urs.eichholzer@domain.hid>
Date: Wed, 28 May 2008 09:43:57 +0700
Message-ID: <000501c8c06c$adb72100$2201a8c0@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_NextPart_000_0006_01C8C0A7.5A15F900"
Subject: [Xenomai-help] General questions
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

------=_NextPart_000_0006_01C8C0A7.5A15F900
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi all,
 
We have some general questions
 
Our setup is:
Hardware MPC5200B on Microsys MPX5200
Linux version: 2.6.19
Adeos Patch: Compatible with this Linux
Xenomai version: 2.3.0
 
1.) Is the RT CAN socket deterministic? If I send immediately after
knowing the code is in 4 mS gap interval, how long does the rt socket
send this to the connected device from the time I command rt_dev_send to
the real seding in the Xenomai? Will the Xenomai RT-CAN socket sending
be interrupted by another task or resource? 
 
2.) Are all task application in Xenomai interruptable (or blockable) by
another task or resource irregardless of priority? If this happens....
What is the most time delay it will consume to switch back to my
rt-application task if it is blocked? Lets say I am sending CAN and at
the same time 4 more rt-application are running...
 
3.) Is the highest priority application task can also be blocked by
another process or resource? Will this task yield to another task or
resource if it will be needed? For how long this task switching will
occur so that my application takes control again?
 
4.) Where is rt_timer_read gets its timer value? Is this a predetermined
resolution set in the Xenomai-OS? Is there any relationship of this
timer value in real system pulse?  
 
5.) Is there a way that I can send directly to the RT socket buffer so
that the xenomai can directly send the message without going to the
rt_dev_send on the opened socket? Or is this way impossible and the only
way to send in real-time is through RT CAN socket?
 
6.)  Is an rt application which runs in a periodic task mode will really
executed in periodic intervals? What if the end of the code is not yet
reached and the periodic interval is triggered? Will the task just
continues or will it resign? And then what will happen? Is the periodic
interval will not resign its code when the interval and the code running
overlapped? Will the application code be blocked or will still remain in
running state?
 
7.)  Is there a general protection for a running code that it will be
unblockable for all task and resource for certain lines to be executed?
It is like I will enter to a critical code section and after sending my
CAN message will leave the critical section so that my application will
be able to send immediately and will not be blocked....
 
8.) Why is it that the RT socket CAN of xenomai is still collecting the
incoming frames of an opened socket handle even if it is not requesting
for a read? If the socket will not read, the buffer is becoming full and
will trigger the message buffer full (message discarded). Isn't it that
the xenomai should throw away this frame and free the buffer since the
default timeout will be triggered? The buffer is still being used until
the message overflows when the socket will not read instead of handling
the timeout... It is like as if the CAN device handler will pass the
received CAN message to ALL referenced opened handle eveif it is not
requesting to read the message. Isn't it that if a timeout is already
defined, it should throw away and clear the buffer instead of
continously buffering the "unwanted" frames of the opened socket handle?

 
 
My question might be related or not related to my problem. But I need at
least some of the answers so I can use effectively use the Xenomai task
and have the scheduling in real-time that is accurate to the needed
specification of the project I needed. Please give some recommendation
and comments on things what we might use to address the need of our
real-time project application...
 
Best Regards
 
Urs 
 

------=_NextPart_000_0006_01C8C0A7.5A15F900
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
span.EmailStyle17
	{mso-style-type:personal-compose;
	mso-style-noshow:yes;
	mso-ansi-font-size:10.0pt;
	mso-bidi-font-size:10.0pt;
	font-family:Arial;
	mso-ascii-font-family:Arial;
	mso-hansi-font-family:Arial;
	mso-bidi-font-family:Arial;
	color:windowtext;}
span.SpellE
	{mso-style-name:"";
	mso-spl-e:yes;}
span.GramE
	{mso-style-name:"";
	mso-gram-e:yes;}
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

<p class=3DMsoNormal =
style=3D'mso-layout-grid-align:none;text-autospace:none'><font
size=3D2 face=3D"Courier New"><span =
style=3D'font-size:10.0pt;font-family:"Courier New"'>Hi
all,<o:p></o:p></span></font></p>

<p class=3DMsoNormal =
style=3D'mso-layout-grid-align:none;text-autospace:none'><font
size=3D2 face=3D"Courier New"><span =
style=3D'font-size:10.0pt;font-family:"Courier =
New"'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal =
style=3D'mso-layout-grid-align:none;text-autospace:none'><font
size=3D2 face=3D"Courier New"><span =
style=3D'font-size:10.0pt;font-family:"Courier New"'>We
have some general questions<o:p></o:p></span></font></p>

<p class=3DMsoNormal =
style=3D'mso-layout-grid-align:none;text-autospace:none'><font
size=3D2 face=3D"Courier New"><span =
style=3D'font-size:10.0pt;font-family:"Courier =
New"'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal =
style=3D'mso-layout-grid-align:none;text-autospace:none'><font
size=3D2 face=3D"Courier New"><span =
style=3D'font-size:10.0pt;font-family:"Courier New"'>Our
setup is:<o:p></o:p></span></font></p>

<p class=3DMsoNormal =
style=3D'mso-layout-grid-align:none;text-autospace:none'><font
size=3D2 face=3D"Courier New"><span =
style=3D'font-size:10.0pt;font-family:"Courier New"'>Hardware
MPC5200B on <span class=3DSpellE>Microsys</span> =
MPX5200<o:p></o:p></span></font></p>

<p class=3DMsoNormal =
style=3D'mso-layout-grid-align:none;text-autospace:none'><font
size=3D2 face=3D"Courier New"><span =
style=3D'font-size:10.0pt;font-family:"Courier New"'>Linux
version: 2.6.19<o:p></o:p></span></font></p>

<p class=3DMsoNormal =
style=3D'mso-layout-grid-align:none;text-autospace:none'><span
class=3DSpellE><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:10.0pt;
font-family:"Courier New"'>Adeos</span></font></span><font size=3D2
face=3D"Courier New"><span =
style=3D'font-size:10.0pt;font-family:"Courier New"'>
Patch: Compatible with this Linux<o:p></o:p></span></font></p>

<p class=3DMsoNormal =
style=3D'mso-layout-grid-align:none;text-autospace:none'><span
class=3DSpellE><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:10.0pt;
font-family:"Courier New"'>Xenomai</span></font></span><font size=3D2
face=3D"Courier New"><span =
style=3D'font-size:10.0pt;font-family:"Courier New"'>
version: 2.3.0<o:p></o:p></span></font></p>

<p class=3DMsoNormal =
style=3D'mso-layout-grid-align:none;text-autospace:none'><font
size=3D2 face=3D"Courier New"><span =
style=3D'font-size:10.0pt;font-family:"Courier =
New"'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal =
style=3D'mso-layout-grid-align:none;text-autospace:none'><font
size=3D2 face=3D"Courier New"><span =
style=3D'font-size:10.0pt;font-family:"Courier New"'>1.)
Is the RT CAN socket deterministic? If I send immediately after knowing =
the
code is in 4 <span class=3DSpellE>mS</span> gap interval, how long does =
the <span
class=3DSpellE><span class=3DGramE>rt</span></span> socket send this to =
the
connected device from the time I command <span =
class=3DSpellE>rt_dev_send</span>
to the real <span class=3DSpellE>seding</span> in the <span =
class=3DSpellE>Xenomai</span>?
Will the <span class=3DSpellE>Xenomai</span> RT-CAN socket sending be =
interrupted
by another task or resource? <o:p></o:p></span></font></p>

<p class=3DMsoNormal =
style=3D'mso-layout-grid-align:none;text-autospace:none'><font
size=3D2 face=3D"Courier New"><span =
style=3D'font-size:10.0pt;font-family:"Courier New"'><span
style=3D'mso-spacerun:yes'>&nbsp;</span><o:p></o:p></span></font></p>

<p class=3DMsoNormal =
style=3D'mso-layout-grid-align:none;text-autospace:none'><font
size=3D2 face=3D"Courier New"><span =
style=3D'font-size:10.0pt;font-family:"Courier New"'>2.)
Are all task application in <span class=3DSpellE>Xenomai</span> <span
class=3DSpellE>interruptable</span> (or <span =
class=3DSpellE>blockable</span>) by
another task or resource irregardless of priority? <span =
class=3DGramE>If this
happens....</span> What is the most time delay it will consume to switch =
back
to my <span class=3DSpellE>rt</span>-application task if it is blocked? =
<span
class=3DGramE>Lets</span> say I am sending CAN and at the same time 4 =
more <span
class=3DSpellE>rt</span>-application are =
running...<o:p></o:p></span></font></p>

<p class=3DMsoNormal =
style=3D'mso-layout-grid-align:none;text-autospace:none'><font
size=3D2 face=3D"Courier New"><span =
style=3D'font-size:10.0pt;font-family:"Courier New"'><span
style=3D'mso-spacerun:yes'>&nbsp;</span><o:p></o:p></span></font></p>

<p class=3DMsoNormal =
style=3D'mso-layout-grid-align:none;text-autospace:none'><font
size=3D2 face=3D"Courier New"><span =
style=3D'font-size:10.0pt;font-family:"Courier New"'>3.)
Is the highest priority application task can also be blocked by another =
process
or resource? Will this task yield to another task or resource if it will =
be
needed? For how long this task switching will occur so that my =
application
takes control again?<o:p></o:p></span></font></p>

<p class=3DMsoNormal =
style=3D'mso-layout-grid-align:none;text-autospace:none'><font
size=3D2 face=3D"Courier New"><span =
style=3D'font-size:10.0pt;font-family:"Courier New"'><span
style=3D'mso-spacerun:yes'>&nbsp;</span><o:p></o:p></span></font></p>

<p class=3DMsoNormal =
style=3D'mso-layout-grid-align:none;text-autospace:none'><span
class=3DGramE><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:10.0pt;
font-family:"Courier New"'>4.) Where is <span =
class=3DSpellE>rt_timer_read</span></span></font></span><font
size=3D2 face=3D"Courier New"><span =
style=3D'font-size:10.0pt;font-family:"Courier New"'>
gets its timer value? Is this a predetermined resolution set in the =
<span
class=3DSpellE>Xenomai</span>-OS? Is there any relationship of this =
timer value
in real system pulse?<span style=3D'mso-spacerun:yes'>&nbsp; =
</span><o:p></o:p></span></font></p>

<p class=3DMsoNormal =
style=3D'mso-layout-grid-align:none;text-autospace:none'><font
size=3D2 face=3D"Courier New"><span =
style=3D'font-size:10.0pt;font-family:"Courier New"'><span
style=3D'mso-spacerun:yes'>&nbsp;</span><o:p></o:p></span></font></p>

<p class=3DMsoNormal =
style=3D'mso-layout-grid-align:none;text-autospace:none'><font
size=3D2 face=3D"Courier New"><span =
style=3D'font-size:10.0pt;font-family:"Courier New"'>5.)
Is there a way that I can send directly to the RT socket buffer so that =
the <span
class=3DSpellE>xenomai</span> can directly send the message without =
going to the <span
class=3DSpellE>rt_dev_send</span> on the opened socket? Or <span =
class=3DGramE>is</span>
this way impossible and the only way to send in real-time is through RT =
CAN socket?<o:p></o:p></span></font></p>

<p class=3DMsoNormal =
style=3D'mso-layout-grid-align:none;text-autospace:none'><font
size=3D2 face=3D"Courier New"><span =
style=3D'font-size:10.0pt;font-family:"Courier New"'><span
style=3D'mso-spacerun:yes'>&nbsp;</span><o:p></o:p></span></font></p>

<p class=3DMsoNormal =
style=3D'mso-layout-grid-align:none;text-autospace:none'><font
size=3D2 face=3D"Courier New"><span =
style=3D'font-size:10.0pt;font-family:"Courier New"'>6.)<span
style=3D'mso-spacerun:yes'>&nbsp; </span>Is an <span =
class=3DSpellE><span
class=3DGramE>rt</span></span> application which runs in a periodic task =
mode
will really executed in periodic intervals? What if the end of the code =
is not
yet reached and the periodic interval is triggered? Will the task just
continues or will it resign? And then what will happen? Is the periodic
interval will not resign its code when the interval and the code running
overlapped? Will the application code be blocked or will still remain in
running state?<o:p></o:p></span></font></p>

<p class=3DMsoNormal =
style=3D'mso-layout-grid-align:none;text-autospace:none'><font
size=3D2 face=3D"Courier New"><span =
style=3D'font-size:10.0pt;font-family:"Courier New"'><span
style=3D'mso-spacerun:yes'>&nbsp;</span><o:p></o:p></span></font></p>

<p class=3DMsoNormal =
style=3D'mso-layout-grid-align:none;text-autospace:none'><font
size=3D2 face=3D"Courier New"><span =
style=3D'font-size:10.0pt;font-family:"Courier New"'>7.)<span
style=3D'mso-spacerun:yes'>&nbsp; </span>Is there a general protection =
for a
running code that it will be <span class=3DSpellE>unblockable</span> for =
all task
and resource for certain lines to be executed? It is like I will enter =
to a
critical code section and after sending my CAN message will leave the =
critical
section so that my application will be able to send immediately and will =
not be
blocked....<o:p></o:p></span></font></p>

<p class=3DMsoNormal =
style=3D'mso-layout-grid-align:none;text-autospace:none'><font
size=3D2 face=3D"Courier New"><span =
style=3D'font-size:10.0pt;font-family:"Courier New"'><span
style=3D'mso-spacerun:yes'>&nbsp;</span><o:p></o:p></span></font></p>

<p class=3DMsoNormal =
style=3D'mso-layout-grid-align:none;text-autospace:none'><span
class=3DGramE><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:10.0pt;
font-family:"Courier New"'>8.) Why is it that the RT socket CAN of <span
class=3DSpellE>xenomai</span></span></font></span><font size=3D2 =
face=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier New"'> is still =
collecting the
incoming frames of an opened socket handle even if it is not requesting =
for a
read? If the socket will not read, the buffer is becoming full and will =
trigger
the message buffer full (message discarded). Isn't it that the <span
class=3DSpellE>xenomai</span> should throw away this frame and free the =
buffer
since the default timeout will be triggered? The buffer is still being =
used
until the message overflows when the socket will not read instead of =
handling
the timeout... It is like as if the CAN device handler will pass the =
received
CAN message to ALL referenced opened handle <span =
class=3DSpellE>eveif</span> it
is not requesting to read the message. Isn't it that if a timeout is =
already
defined, it should throw away and clear the buffer instead of <span
class=3DSpellE>continously</span> buffering the &quot;unwanted&quot; =
frames of
the opened socket handle? <o:p></o:p></span></font></p>

<p class=3DMsoNormal =
style=3D'mso-layout-grid-align:none;text-autospace:none'><font
size=3D2 face=3D"Courier New"><span =
style=3D'font-size:10.0pt;font-family:"Courier New"'><span
style=3D'mso-spacerun:yes'>&nbsp;</span><o:p></o:p></span></font></p>

<p class=3DMsoNormal =
style=3D'mso-layout-grid-align:none;text-autospace:none'><font
size=3D2 face=3D"Courier New"><span =
style=3D'font-size:10.0pt;font-family:"Courier New"'><span
style=3D'mso-spacerun:yes'>&nbsp;</span><o:p></o:p></span></font></p>

<p class=3DMsoNormal =
style=3D'mso-layout-grid-align:none;text-autospace:none'><font
size=3D2 face=3D"Courier New"><span =
style=3D'font-size:10.0pt;font-family:"Courier New"'>My
question might be related or not related to my problem. But I need at =
least
some of the answers so I can use effectively use the <span =
class=3DSpellE>Xenomai</span>
task and have the scheduling in real-time that is accurate to the needed
specification of the project I needed. Please give some recommendation =
and
comments on things what we might use to address the need of our =
real-time
project application...<o:p></o:p></span></font></p>

<p class=3DMsoNormal =
style=3D'mso-layout-grid-align:none;text-autospace:none'><font
size=3D2 face=3D"Courier New"><span =
style=3D'font-size:10.0pt;font-family:"Courier New"'><span
style=3D'mso-spacerun:yes'>&nbsp;</span><o:p></o:p></span></font></p>

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
style=3D'font-size:12.0pt;mso-ansi-language:DE-CH;mso-no-proof:yes'>Urs =
<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D3 face=3D"Times New Roman"><span =
lang=3DDE
style=3D'font-size:12.0pt;mso-ansi-language:DE'><o:p>&nbsp;</o:p></span><=
/font></p>

</div>

</body>

</html>

------=_NextPart_000_0006_01C8C0A7.5A15F900--


