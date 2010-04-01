Date: Thu, 01 Apr 2010 19:41:11 +0800
From: qhuanj <qiuhj@domain.hid>
Sender: qiuhj@domain.hid
Message-id: <005601cad190$3ac84660$df1a010a@domain.hid>
MIME-version: 1.0
Content-type: multipart/alternative;
	boundary="Boundary_(ID_MfTqnppgmXOKB9eA7qlNrQ)"
Subject: [Xenomai-core] problem to uitron skin
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai@xenomai.org

This is a multi-part message in MIME format.

--Boundary_(ID_MfTqnppgmXOKB9eA7qlNrQ)
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi

 

I want to porting uitron based application to linux, and I decided to use
xenomai uitron skin.

 

I patched the kernel, make the xenomai package and installed user space
library and header file 

 

The application can be built , but something was wrong when I ran the
program

 

The error message is "Xenomai uITRON skin init: shd_tsk() failed, status
-33"

 

I found the error code "-33" mean parameter error ,but I can not understood,
any help?

 

Any doc for uitron skin ?

 

Thank you!

---------------------------------------------------------------------------------------------------
Confidentiality Notice: The information contained in this e-mail and any accompanying attachment(s) 
is intended only for the use of the intended recipient and may be confidential and/or privileged of 
Neusoft Corporation, its subsidiaries and/or its affiliates. If any reader of this communication is 
not the intended recipient, unauthorized use, forwarding, printing,  storing, disclosure or copying 
is strictly prohibited, and may be unlawful.If you have received this communication in error,please 
immediately notify the sender by return e-mail, and delete the original message and all copies from 
your system. Thank you. 
---------------------------------------------------------------------------------------------------

--Boundary_(ID_MfTqnppgmXOKB9eA7qlNrQ)
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: 7bit

<html xmlns:o="urn:schemas-microsoft-com:office:office" xmlns:w="urn:schemas-microsoft-com:office:word" xmlns:st1="urn:schemas-microsoft-com:office:smarttags" xmlns="http://www.w3.org/TR/REC-html40">

<head>
<META HTTP-EQUIV="Content-Type" CONTENT="text/html; charset=us-ascii">
<meta name=Generator content="Microsoft Word 11 (filtered medium)">
<o:SmartTagType namespaceuri="urn:schemas-microsoft-com:office:smarttags"
 name="chmetcnv"/>
<!--[if !mso]>
<style>
st1\:*{behavior:url(#default#ieooui) }
</style>
<![endif]-->
<style>
<!--
 /* Font Definitions */
 @font-face
	{font-family:&#23435;&#20307;;
	panose-1:2 1 6 0 3 1 1 1 1 1;}
@font-face
	{font-family:"\@&#23435;&#20307;";
	panose-1:2 1 6 0 3 1 1 1 1 1;}
 /* Style Definitions */
 p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0cm;
	margin-bottom:.0001pt;
	text-align:justify;
	text-justify:inter-ideograph;
	font-size:10.5pt;
	font-family:"Times New Roman";}
a:link, span.MsoHyperlink
	{color:blue;
	text-decoration:underline;}
a:visited, span.MsoHyperlinkFollowed
	{color:purple;
	text-decoration:underline;}
span.EmailStyle17
	{mso-style-type:personal-compose;
	font-family:Arial;
	color:windowtext;}
 /* Page Definitions */
 @page Section1
	{size:595.3pt 841.9pt;
	margin:72.0pt 90.0pt 72.0pt 90.0pt;
	layout-grid:15.6pt;}
div.Section1
	{page:Section1;}
-->
</style>

</head>

<body lang=ZH-CN link=blue vlink=purple style='text-justify-trim:punctuation'>

<div class=Section1 style='layout-grid:15.6pt'>

<p class=MsoNormal align=left style='text-align:left;text-autospace:none'><font
size=1 face=&#23435;&#20307;><span lang=EN-US style='font-size:9.0pt;font-family:&#23435;&#20307;'>Hi<o:p></o:p></span></font></p>

<p class=MsoNormal align=left style='text-align:left;text-autospace:none'><font
size=1 face=&#23435;&#20307;><span lang=EN-US style='font-size:9.0pt;font-family:&#23435;&#20307;'><o:p>&nbsp;</o:p></span></font></p>

<p class=MsoNormal align=left style='text-align:left;text-autospace:none'><font
size=1 face=&#23435;&#20307;><span lang=EN-US style='font-size:9.0pt;font-family:&#23435;&#20307;'>I want
to porting uitron based application to linux, and I decided to use xenomai
uitron skin.<o:p></o:p></span></font></p>

<p class=MsoNormal align=left style='text-align:left;text-autospace:none'><font
size=1 face=&#23435;&#20307;><span lang=EN-US style='font-size:9.0pt;font-family:&#23435;&#20307;'><o:p>&nbsp;</o:p></span></font></p>

<p class=MsoNormal align=left style='text-align:left;text-autospace:none'><font
size=1 face=&#23435;&#20307;><span lang=EN-US style='font-size:9.0pt;font-family:&#23435;&#20307;'>I
patched the kernel, make the xenomai package and installed user space library
and header file <o:p></o:p></span></font></p>

<p class=MsoNormal align=left style='text-align:left;text-autospace:none'><font
size=1 face=&#23435;&#20307;><span lang=EN-US style='font-size:9.0pt;font-family:&#23435;&#20307;'><o:p>&nbsp;</o:p></span></font></p>

<p class=MsoNormal align=left style='text-align:left;text-autospace:none'><font
size=1 face=&#23435;&#20307;><span lang=EN-US style='font-size:9.0pt;font-family:&#23435;&#20307;'>The
application can be built , but something was wrong when I ran the program<o:p></o:p></span></font></p>

<p class=MsoNormal align=left style='text-align:left;text-autospace:none'><font
size=1 face=&#23435;&#20307;><span lang=EN-US style='font-size:9.0pt;font-family:&#23435;&#20307;'><o:p>&nbsp;</o:p></span></font></p>

<p class=MsoNormal align=left style='text-align:left;text-autospace:none'><font
size=1 face=&#23435;&#20307;><span lang=EN-US style='font-size:9.0pt;font-family:&#23435;&#20307;'>The
error message is </span></font><font size=1><span lang=EN-US style='font-size:
9.0pt'>&#8220;</span></font><font size=1 face=&#23435;&#20307;><span lang=EN-US style='font-size:
9.0pt;font-family:&#23435;&#20307;'>Xenomai uITRON skin init: shd_tsk() failed, status <st1:chmetcnv
TCSC="0" NumberType="1" Negative="True" HasSpace="False" SourceValue="33"
UnitName="&#8221;" w:st="on">-33<font face="Times New Roman"><span style='font-family:
 "Times New Roman"'>&#8221;</span></font></st1:chmetcnv><o:p></o:p></span></font></p>

<p class=MsoNormal align=left style='text-align:left;text-autospace:none'><font
size=1 face=&#23435;&#20307;><span lang=EN-US style='font-size:9.0pt;font-family:&#23435;&#20307;'><o:p>&nbsp;</o:p></span></font></p>

<p class=MsoNormal align=left style='text-align:left;text-autospace:none'><font
size=1 face=&#23435;&#20307;><span lang=EN-US style='font-size:9.0pt;font-family:&#23435;&#20307;'>I found
the error code </span></font><font size=1><span lang=EN-US style='font-size:
9.0pt'>&#8220;</span></font><st1:chmetcnv TCSC="0" NumberType="1" Negative="True"
HasSpace="False" SourceValue="33" UnitName="&#8221;" w:st="on"><font size=1 face=&#23435;&#20307;><span
 lang=EN-US style='font-size:9.0pt;font-family:&#23435;&#20307;'>-33</span></font><font
 size=1><span lang=EN-US style='font-size:9.0pt'>&#8221;</span></font></st1:chmetcnv><font
size=1 face=&#23435;&#20307;><span lang=EN-US style='font-size:9.0pt;font-family:&#23435;&#20307;'> mean
parameter error ,but I can not understood, any help?<o:p></o:p></span></font></p>

<p class=MsoNormal align=left style='text-align:left;text-autospace:none'><font
size=1 face=&#23435;&#20307;><span lang=EN-US style='font-size:9.0pt;font-family:&#23435;&#20307;'><o:p>&nbsp;</o:p></span></font></p>

<p class=MsoNormal align=left style='text-align:left;text-autospace:none'><font
size=1 face=&#23435;&#20307;><span lang=EN-US style='font-size:9.0pt;font-family:&#23435;&#20307;'>Any doc
for uitron skin ?<o:p></o:p></span></font></p>

<p class=MsoNormal align=left style='text-align:left;text-autospace:none'><font
size=1 face=&#23435;&#20307;><span lang=EN-US style='font-size:9.0pt;font-family:&#23435;&#20307;'><o:p>&nbsp;</o:p></span></font></p>

<p class=MsoNormal><font size=1 face=&#23435;&#20307;><span style='font-size:9.0pt;
font-family:&#23435;&#20307;'>Thank you!</span></font><font size=1 face=Arial><span
lang=EN-US style='font-size:9.0pt;font-family:Arial'><o:p></o:p></span></font></p>

</div>

<pre>---------------------------------------------------------------------------------------------------
Confidentiality Notice: The information contained in this e-mail and any accompanying attachment(s) 
is intended only for the use of the intended recipient and may be confidential and/or privileged of 
Neusoft Corporation, its subsidiaries and/or its affiliates. If any reader of this communication is 
not the intended recipient, unauthorized use, forwarding, printing,  storing, disclosure or copying 
is strictly prohibited, and may be unlawful.If you have received this communication in error,please 
immediately notify the sender by return e-mail, and delete the original message and all copies from 
your system. Thank you. 
---------------------------------------------------------------------------------------------------
</pre></body>

</html>

--Boundary_(ID_MfTqnppgmXOKB9eA7qlNrQ)--


