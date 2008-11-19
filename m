Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C94A77.D0E36FBD"
Date: Wed, 19 Nov 2008 11:51:21 -0700
Message-ID: <51CAD0CE1504444DBE77CBBE51A0135D533618@domain.hid>
In-Reply-To: <67b6b3430811170927t74f809edg1b0c6aaf1a9d2709@domain.hid>
References: <51CAD0CE1504444DBE77CBBE51A0135D533259@domain.hid>
	<49100825.9000502@domain.hid> <4915C4D3.8030304@domain.hid>
	<67b6b3430811101607k75eaa084ga387c453096d2710@domain.hid>
	<1c74c6152ff1b52eaa3dd84f4b912b29.squirrel@domain.hid>
	<51CAD0CE1504444DBE77CBBE51A0135D53344A@slcmail.slc.mew.int>
	<67b6b3430811111432o1ca14e87w7ccab4ab95dd591e@domain.hid>
	<491C0B50.6030507@domain.hid>
	<67b6b3430811131959r6bc22545wd4e3df613c15fc7b@domain.hid>
	<491D39E8.3090105@domain.hid>
	<67b6b3430811170927t74f809edg1b0c6aaf1a9d2709@domain.hid>
From: "Steven Seeger" <sseeger@domain.hid>
Subject: Re: [Xenomai-help] fpu context switch issue
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Mark Saiia <mark.saiia@domain.hid>, Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org


This is a multi-part message in MIME format.

------_=_NextPart_001_01C94A77.D0E36FBD
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Have there been any thoughts on this issue? We have reverted back to
2.6.23.12 with r3415 for now. Our apps (including the test I posted
earlier) work in this older environment. We'd like to use the newer
environment because many other bugs have been fixed.

=20

BTW, the older environment works correctly on both our geode boards.

=20

Thanks,

Steven

=20

From: Mark Saiia [mailto:mark.saiia@domain.hid
Sent: Monday, November 17, 2008 10:27 AM
To: Gilles Chanteperdrix
Cc: Steven Seeger; xenomai@xenomai.org
Subject: Re: [Xenomai-help] fpu context switch issue

=20

Just a quick update.  I haven't had a chance to do as you suggested
(2.6.23 w/2.4.5), but will get to it when I have a chance.  My previous
post was incorrect.  The older version of the app was somewhat
different.  We recreated the environment that was on on the app backup
flash with Xenomai 2.6.23.12 w/ Xenomai r3415.  The newer version of the
app still  exhibits floating point errors on this older platform.  Yet
we ran the simple test program numerous times on the older platform and
did not see any incorrect behavior.  I am attempting to make a
determination as to what in the larger app causes the floating point
issue to arise.

Mark

On Fri, Nov 14, 2008 at 12:42 AM, Gilles Chanteperdrix
<gilles.chanteperdrix@xenomai.org> wrote:

Mark Saiia wrote:
> Gilles,
>
> No noticeable difference using 2.4.5 w/ 2.6.26.3.  I was testing using
the
> app we first noticed the behavior on.  I will run the simple test
program
> tomorrow, but fully expect to see the erroneous behavior.  I also had
the
> chance to test the patch on a GX1 board, and noticed the error as
well. We
> have a version of the app, that I was testing today, running on
2.6.23.12 w/
> Xenomai svn of around February 2008 (I don't have the revision number
in
> front of me at the moment) that works properly.

Could you test 2.6.23 with Xenomai 2.4.5? This way we would know if we
are looking for a problem in the I-pipe patch or in Xenomai.

--
                                           Gilles.

=20


------_=_NextPart_001_01C94A77.D0E36FBD
Content-Type: text/html;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" =
xmlns:o=3D"urn:schemas-microsoft-com:office:office" =
xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:x=3D"urn:schemas-microsoft-com:office:excel" =
xmlns:p=3D"urn:schemas-microsoft-com:office:powerpoint" =
xmlns:a=3D"urn:schemas-microsoft-com:office:access" =
xmlns:dt=3D"uuid:C2F41010-65B3-11d1-A29F-00AA00C14882" =
xmlns:s=3D"uuid:BDC6E3F0-6DA3-11d1-A2A3-00AA00C14882" =
xmlns:rs=3D"urn:schemas-microsoft-com:rowset" xmlns:z=3D"#RowsetSchema" =
xmlns:b=3D"urn:schemas-microsoft-com:office:publisher" =
xmlns:ss=3D"urn:schemas-microsoft-com:office:spreadsheet" =
xmlns:c=3D"urn:schemas-microsoft-com:office:component:spreadsheet" =
xmlns:odc=3D"urn:schemas-microsoft-com:office:odc" =
xmlns:oa=3D"urn:schemas-microsoft-com:office:activation" =
xmlns:html=3D"http://www.w3.org/TR/REC-html40" =
xmlns:q=3D"http://schemas.xmlsoap.org/soap/envelope/" xmlns:D=3D"DAV:" =
xmlns:x2=3D"http://schemas.microsoft.com/office/excel/2003/xml" =
xmlns:ois=3D"http://schemas.microsoft.com/sharepoint/soap/ois/" =
xmlns:dir=3D"http://schemas.microsoft.com/sharepoint/soap/directory/" =
xmlns:ds=3D"http://www.w3.org/2000/09/xmldsig#" =
xmlns:dsp=3D"http://schemas.microsoft.com/sharepoint/dsp" =
xmlns:udc=3D"http://schemas.microsoft.com/data/udc" =
xmlns:xsd=3D"http://www.w3.org/2001/XMLSchema" =
xmlns:sub=3D"http://schemas.microsoft.com/sharepoint/soap/2002/1/alerts/"=
 xmlns:ec=3D"http://www.w3.org/2001/04/xmlenc#" =
xmlns:sp=3D"http://schemas.microsoft.com/sharepoint/" =
xmlns:sps=3D"http://schemas.microsoft.com/sharepoint/soap/" =
xmlns:xsi=3D"http://www.w3.org/2001/XMLSchema-instance" =
xmlns:udcxf=3D"http://schemas.microsoft.com/data/udc/xmlfile" =
xmlns:wf=3D"http://schemas.microsoft.com/sharepoint/soap/workflow/" =
xmlns:mver=3D"http://schemas.openxmlformats.org/markup-compatibility/2006=
" xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" =
xmlns:mrels=3D"http://schemas.openxmlformats.org/package/2006/relationshi=
ps" =
xmlns:ex12t=3D"http://schemas.microsoft.com/exchange/services/2006/types"=
 =
xmlns:ex12m=3D"http://schemas.microsoft.com/exchange/services/2006/messag=
es" xmlns:Z=3D"urn:schemas-microsoft-com:" xmlns:st=3D"&#1;" =
xmlns=3D"http://www.w3.org/TR/REC-html40">

<head>
<meta http-equiv=3DContent-Type content=3D"text/html; =
charset=3Dus-ascii">
<meta name=3DGenerator content=3D"Microsoft Word 12 (filtered medium)">
<style>
<!--
 /* Font Definitions */
 @font-face
	{font-family:"MS Mincho";
	panose-1:2 2 6 9 4 2 5 8 3 4;}
@font-face
	{font-family:"MS Mincho";
	panose-1:2 2 6 9 4 2 5 8 3 4;}
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
@font-face
	{font-family:Tahoma;
	panose-1:2 11 6 4 3 5 4 4 2 4;}
@font-face
	{font-family:"\@MS Mincho";
	panose-1:2 2 6 9 4 2 5 8 3 4;}
 /* Style Definitions */
 p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
	margin-bottom:.0001pt;
	font-size:12.0pt;
	font-family:"Times New Roman","serif";}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:blue;
	text-decoration:underline;}
a:visited, span.MsoHyperlinkFollowed
	{mso-style-priority:99;
	color:purple;
	text-decoration:underline;}
span.EmailStyle17
	{mso-style-type:personal-reply;
	font-family:"Calibri","sans-serif";
	color:#1F497D;}
.MsoChpDefault
	{mso-style-type:export-only;}
@page Section1
	{size:8.5in 11.0in;
	margin:1.0in 1.0in 1.0in 1.0in;}
div.Section1
	{page:Section1;}
-->
</style>
<!--[if gte mso 9]><xml>
 <o:shapedefaults v:ext=3D"edit" spidmax=3D"1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
 <o:shapelayout v:ext=3D"edit">
  <o:idmap v:ext=3D"edit" data=3D"1" />
 </o:shapelayout></xml><![endif]-->
</head>

<body lang=3DEN-US link=3Dblue vlink=3Dpurple>

<div class=3DSection1>

<p class=3DMsoNormal><span =
style=3D'font-size:11.0pt;font-family:"Calibri","sans-serif";
color:#1F497D'>Have there been any thoughts on this issue? We have =
reverted
back to 2.6.23.12 with r3415 for now. Our apps (including the test I =
posted earlier)
work in this older environment. We&#8217;d like to use the newer =
environment because
many other bugs have been fixed.<o:p></o:p></span></p>

<p class=3DMsoNormal><span =
style=3D'font-size:11.0pt;font-family:"Calibri","sans-serif";
color:#1F497D'><o:p>&nbsp;</o:p></span></p>

<p class=3DMsoNormal><span =
style=3D'font-size:11.0pt;font-family:"Calibri","sans-serif";
color:#1F497D'>BTW, the older environment works correctly on both our =
geode
boards.<o:p></o:p></span></p>

<p class=3DMsoNormal><span =
style=3D'font-size:11.0pt;font-family:"Calibri","sans-serif";
color:#1F497D'><o:p>&nbsp;</o:p></span></p>

<p class=3DMsoNormal><span =
style=3D'font-size:11.0pt;font-family:"Calibri","sans-serif";
color:#1F497D'>Thanks,<o:p></o:p></span></p>

<p class=3DMsoNormal><span =
style=3D'font-size:11.0pt;font-family:"Calibri","sans-serif";
color:#1F497D'>Steven<o:p></o:p></span></p>

<p class=3DMsoNormal><span =
style=3D'font-size:11.0pt;font-family:"Calibri","sans-serif";
color:#1F497D'><o:p>&nbsp;</o:p></span></p>

<div style=3D'border:none;border-left:solid blue 1.5pt;padding:0in 0in =
0in 4.0pt'>

<div>

<div style=3D'border:none;border-top:solid #B5C4DF 1.0pt;padding:3.0pt =
0in 0in 0in'>

<p class=3DMsoNormal><b><span =
style=3D'font-size:10.0pt;font-family:"Tahoma","sans-serif"'>From:</span>=
</b><span
style=3D'font-size:10.0pt;font-family:"Tahoma","sans-serif"'> Mark Saiia
[mailto:mark.saiia@domain.hid] <br>
<b>Sent:</b> Monday, November 17, 2008 10:27 AM<br>
<b>To:</b> Gilles Chanteperdrix<br>
<b>Cc:</b> Steven Seeger; xenomai@xenomai.org<br>
<b>Subject:</b> Re: [Xenomai-help] fpu context switch =
issue<o:p></o:p></span></p>

</div>

</div>

<p class=3DMsoNormal><o:p>&nbsp;</o:p></p>

<p class=3DMsoNormal style=3D'margin-bottom:12.0pt'>Just a quick =
update.&nbsp; I
haven't had a chance to do as you suggested (2.6.23 w/2.4.5), but will =
get to
it when I have a chance.&nbsp; My previous post was incorrect.&nbsp; The =
older
version of the app was somewhat different.&nbsp; We recreated the =
environment
that was on on the app backup flash with Xenomai <a =
href=3D"http://2.6.23.12">2.6.23.12</a>
w/ Xenomai r3415.&nbsp; The newer version of the app still&nbsp; =
exhibits
floating point errors on this older platform.&nbsp; Yet we ran the =
simple test
program numerous times on the older platform and did not see any =
incorrect
behavior.&nbsp; I am attempting to make a determination as to what in =
the
larger app causes the floating point issue to arise.<br>
<br>
Mark<o:p></o:p></p>

<div>

<p class=3DMsoNormal>On Fri, Nov 14, 2008 at 12:42 AM, Gilles =
Chanteperdrix &lt;<a
href=3D"mailto:gilles.chanteperdrix@xenomai.org">gilles.chanteperdrix@xenomai.org=
omai.org</a>&gt;
wrote:<o:p></o:p></p>

<div>

<p class=3DMsoNormal style=3D'margin-bottom:12.0pt'>Mark Saiia =
wrote:<br>
&gt; Gilles,<br>
&gt;<br>
&gt; No noticeable difference using 2.4.5 w/ <a href=3D"http://2.6.26.3"
target=3D"_blank">2.6.26.3</a>. &nbsp;I was testing using the<br>
&gt; app we first noticed the behavior on. &nbsp;I will run the simple =
test
program<br>
&gt; tomorrow, but fully expect to see the erroneous behavior. &nbsp;I =
also had
the<br>
&gt; chance to test the patch on a GX1 board, and noticed the error as =
well. We<br>
&gt; have a version of the app, that I was testing today, running on <a
href=3D"http://2.6.23.12" target=3D"_blank">2.6.23.12</a> w/<br>
&gt; Xenomai svn of around February 2008 (I don't have the revision =
number in<br>
&gt; front of me at the moment) that works properly.<o:p></o:p></p>

</div>

<p class=3DMsoNormal>Could you test 2.6.23 with Xenomai 2.4.5? This way =
we would
know if we<br>
are looking for a problem in the I-pipe patch or in Xenomai.<br>
<br>
--<br>
<span style=3D'color:#888888'>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; =
&nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; =
&nbsp;
&nbsp; &nbsp; &nbsp; &nbsp;Gilles.</span><o:p></o:p></p>

</div>

<p class=3DMsoNormal><o:p>&nbsp;</o:p></p>

</div>

</div>

</body>

</html>

------_=_NextPart_001_01C94A77.D0E36FBD--

