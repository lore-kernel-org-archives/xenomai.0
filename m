Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="----_=_NextPart_001_01C93D4C.0C43D286"
Date: Sun, 2 Nov 2008 17:35:18 -0700
Message-ID: <51CAD0CE1504444DBE77CBBE51A0135D533259@domain.hid>
From: "Steven Seeger" <sseeger@domain.hid>
Subject: [Xenomai-help] fpu context switch issue
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

------_=_NextPart_001_01C93D4C.0C43D286
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_002_01C93D4C.0C43D286"


------_=_NextPart_002_01C93D4C.0C43D286
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

I'm having a weird issue. Sometimes when I run the attached program I
see one of the "shouldn't see this" printouts. However, it only fails if
I also link in another userspace library that doesn't do anything. (No
libraries are being called here.)

=20

I've had issues with a couple of other xenomai apps. I get a nan on a
double operation sometimes right after the app first loads, and then
it's ok after that. This error in the attached program always happens on
the first call in the higher priority task (started second.)

=20

Running 2.4.5 with 2.6.26.3 and also 2.6.25.9. AMD Geode LX800 board.

=20

Any suggestions?


Thanks,

Steven

=20

=20


------_=_NextPart_002_01C93D4C.0C43D286
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
	{font-family:"\@MS Mincho";
	panose-1:2 2 6 9 4 2 5 8 3 4;}
 /* Style Definitions */
 p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
	margin-bottom:.0001pt;
	font-size:11.0pt;
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
	font-family:"Calibri","sans-serif";
	color:windowtext;}
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

<p class=3DMsoNormal>I&#8217;m having a weird issue. Sometimes when I =
run the
attached program I see one of the &#8220;shouldn&#8217;t see this&#8221;
printouts. However, it only fails if I also link in another userspace =
library
that doesn&#8217;t do anything. (No libraries are being called =
here.)<o:p></o:p></p>

<p class=3DMsoNormal><o:p>&nbsp;</o:p></p>

<p class=3DMsoNormal>I&#8217;ve had issues with a couple of other =
xenomai apps. I
get a nan on a double operation sometimes right after the app first =
loads, and
then it&#8217;s ok after that. This error in the attached program always
happens on the first call in the higher priority task (started =
second.)<o:p></o:p></p>

<p class=3DMsoNormal><o:p>&nbsp;</o:p></p>

<p class=3DMsoNormal>Running 2.4.5 with 2.6.26.3 and also 2.6.25.9. AMD =
Geode
LX800 board.<o:p></o:p></p>

<p class=3DMsoNormal><o:p>&nbsp;</o:p></p>

<p class=3DMsoNormal>Any suggestions?<o:p></o:p></p>

<p class=3DMsoNormal><br>
Thanks,<o:p></o:p></p>

<p class=3DMsoNormal>Steven<o:p></o:p></p>

<p class=3DMsoNormal><o:p>&nbsp;</o:p></p>

<p class=3DMsoNormal><o:p>&nbsp;</o:p></p>

</div>

</body>

</html>

------_=_NextPart_002_01C93D4C.0C43D286--

------_=_NextPart_001_01C93D4C.0C43D286
Content-Type: application/octet-stream;
	name="double_test.cpp"
Content-Transfer-Encoding: base64
Content-Description: double_test.cpp
Content-Disposition: attachment;
	filename="double_test.cpp"

I2luY2x1ZGUgPHN5cy9tbWFuLmg+CiNpbmNsdWRlIDxpb3N0cmVhbT4KI2luY2x1ZGUgPG5hdGl2
ZS90YXNrLmg+CgpzdGF0aWMgUlRfVEFTSyB0YXNrLHRhc2syOwoKdm9pZCBmdW5jKHZvaWQqKQp7
CiAgICB2b2xhdGlsZSBkb3VibGUgbWluID0gMTAuMDsKICAgIHZvbGF0aWxlIGRvdWJsZSB2YWwg
PSAyNS4wOwogICAgcnVuWzBdID0gdHJ1ZTsKICAgIAogICAgZm9yKDs7KQogICAgewogICAgICAg
IGlmKHZhbCA+IG1pbikgewogICAgICAgICAgICAKICAgICAgICB9CiAgICAgICAgZWxzZSBzdGQ6
OmNvdXQgPDwgInNob3VsZG4ndCBzZWUgdGhpcyAiIDw8IG1pbiA8PCAnICcgPDwgdmFsIDw8IHN0
ZDo6ZW5kbDsKICAgICAgICAKICAgICAgICBydF90YXNrX3NsZWVwKDEwMDAwMCk7CiAgICB9CiAg
ICAKfQoKdm9pZCBmdW5jMih2b2lkKikKewogICAgdm9sYXRpbGUgZG91YmxlIG1pbiA9IDUuMDsK
ICAgIHZvbGF0aWxlIGRvdWJsZSB2YWwgPSAyMC4wOwogICAgCiAgICBydW5bMV0gPSB0cnVlOwog
ICAgCiAgICBmb3IoOzspCiAgICB7CiAgICAgICAgaWYodmFsID4gbWluKSB7CiAgICAgICAgICAg
IAogICAgICAgIH0KICAgICAgICBlbHNlIHN0ZDo6Y291dCA8PCAic2hvdWxkbid0IHNlZSB0aGlz
ICIgPDwgbWluIDw8ICcgJyA8PCB2YWwgPDwgc3RkOjplbmRsOwogICAgICAgIAogICAgICAgIHJ0
X3Rhc2tfc2xlZXAoMTAwMDAwKTsKICAgIH0KfQoKaW50IG1haW4oKQp7CiAgICBtbG9ja2FsbChN
Q0xfQ1VSUkVOVCB8IE1DTF9GVVRVUkUpOwogICAgCiAgICBydF90YXNrX3NwYXduKCZ0YXNrLCAi
ZHVtbXkiLCA0MCwgNTAsIDAsIGZ1bmMsIDApOwogICAgcnRfdGFza19zcGF3bigmdGFzazIsICJk
dW1teTIiLCA0MCwgNjAsIDAsIGZ1bmMyLCAwKTsKICAgIAogICAgdXNsZWVwKDUwMDAwMCk7CiAg
ICAKICAgIHJldHVybiAwOwp9Cg==

------_=_NextPart_001_01C93D4C.0C43D286--

