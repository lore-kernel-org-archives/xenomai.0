From: =?iso-8859-1?Q?Hans_S=F8ndergaard_=28HSO=29?= <HSO@VIAUC.DK>
Date: Fri, 14 Aug 2009 09:31:31 +0200
Message-ID: <0AB95BFCF14F984980DE7149C21D6B90065D58B59F@FND-MAILB03.VIA.DK>
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_0AB95BFCF14F984980DE7149C21D6B90065D58B59FFNDMAILB03VIA_"
MIME-Version: 1.0
Subject: [Xenomai-help] rt_mutex_acquire returns -3
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: "xenomai@xenomai.org" <xenomai@xenomai.org>

--_000_0AB95BFCF14F984980DE7149C21D6B90065D58B59FFNDMAILB03VIA_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

I use objects of type:

typedef struct object {
  RT_MUTEX *rt_lock;
  ..
} Object;

int err =3D rt_mutex_create (ob->rt_lock, NULL);
printf ("[alloc.c]: rt_mutex_create err: %d; #%d \n", err, __LINE__);

err =3D rt_mutex_acquire (ob->rt_lock, TM_INFINITE);
printf ("[lock.c]: rt_mutex_acquire, err: %d; #%d \n", err, __LINE__);

On creation, rt_mutex_create returns 0 (as expected).
On acquiring, rt_mutex_acquire returns -3,
but this return value is not included among the possible return values in t=
he documentation of Mutex services.

Could you please explain what this return value -3 means?

Best regards
Hans So



--_000_0AB95BFCF14F984980DE7149C21D6B90065D58B59FFNDMAILB03VIA_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" xmlns:o=3D"urn:schemas-micr=
osoft-com:office:office" xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" xmlns=3D"http:=
//www.w3.org/TR/REC-html40">

<head>
<meta http-equiv=3DContent-Type content=3D"text/html; charset=3Diso-8859-1"=
>
<meta name=3DGenerator content=3D"Microsoft Word 12 (filtered medium)">
<style>
<!--
 /* Font Definitions */
 @font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
@font-face
	{font-family:Verdana;
	panose-1:2 11 6 4 3 5 4 4 2 4;}
 /* Style Definitions */
 p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0cm;
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
	font-family:"Verdana","sans-serif";
	color:windowtext;
	font-weight:normal;
	font-style:normal;
	text-decoration:none none;}
.MsoChpDefault
	{mso-style-type:export-only;}
@page Section1
	{size:612.0pt 792.0pt;
	margin:3.0cm 2.0cm 3.0cm 2.0cm;}
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

<body lang=3DDA link=3Dblue vlink=3Dpurple>

<div class=3DSection1>

<p class=3DMsoNormal><span lang=3DEN-US style=3D'font-size:10.0pt;font-fami=
ly:"Verdana","sans-serif"'>I
use objects of type:<o:p></o:p></span></p>

<p class=3DMsoNormal><span lang=3DEN-US style=3D'font-size:10.0pt;font-fami=
ly:"Verdana","sans-serif"'><o:p>&nbsp;</o:p></span></p>

<p class=3DMsoNormal><span lang=3DEN-US style=3D'font-size:10.0pt;font-fami=
ly:"Courier New"'>typedef
struct object {<o:p></o:p></span></p>

<p class=3DMsoNormal><span lang=3DEN-US style=3D'font-size:10.0pt;font-fami=
ly:"Courier New"'>=A0
RT_MUTEX *rt_lock;<o:p></o:p></span></p>

<p class=3DMsoNormal><span lang=3DEN-US style=3D'font-size:10.0pt;font-fami=
ly:"Courier New"'>=A0
..<o:p></o:p></span></p>

<p class=3DMsoNormal><span lang=3DEN-US style=3D'font-size:10.0pt;font-fami=
ly:"Courier New"'>}
Object;<o:p></o:p></span></p>

<p class=3DMsoNormal><span lang=3DEN-US style=3D'font-size:10.0pt;font-fami=
ly:"Courier New"'><o:p>&nbsp;</o:p></span></p>

<p class=3DMsoNormal><span lang=3DEN-US style=3D'font-size:10.0pt;font-fami=
ly:"Courier New"'>int
err =3D rt_mutex_create (ob-&gt;rt_lock, NULL);<o:p></o:p></span></p>

<p class=3DMsoNormal><span lang=3DEN-US style=3D'font-size:10.0pt;font-fami=
ly:"Courier New"'>printf
(&quot;[alloc.c]: rt_mutex_create err: %d; #%d \n&quot;, err, __LINE__);<o:=
p></o:p></span></p>

<p class=3DMsoNormal><span lang=3DEN-US style=3D'font-size:10.0pt;font-fami=
ly:"Courier New"'><o:p>&nbsp;</o:p></span></p>

<p class=3DMsoNormal><span lang=3DEN-US style=3D'font-size:10.0pt;font-fami=
ly:"Courier New"'>err
=3D rt_mutex_acquire (ob-&gt;rt_lock, TM_INFINITE);<o:p></o:p></span></p>

<p class=3DMsoNormal><span lang=3DEN-US style=3D'font-size:10.0pt;font-fami=
ly:"Courier New"'>printf
(&quot;[lock.c]: rt_mutex_acquire, err: %d; #%d \n&quot;, err, __LINE__);<o=
:p></o:p></span></p>

<p class=3DMsoNormal><span lang=3DEN-US style=3D'font-size:10.0pt;font-fami=
ly:"Verdana","sans-serif"'><o:p>&nbsp;</o:p></span></p>

<p class=3DMsoNormal><span lang=3DEN-US style=3D'font-size:10.0pt;font-fami=
ly:"Verdana","sans-serif"'>On
creation, rt_mutex_create returns 0 (as expected).<o:p></o:p></span></p>

<p class=3DMsoNormal><span lang=3DEN-US style=3D'font-size:10.0pt;font-fami=
ly:"Verdana","sans-serif"'>On
acquiring, rt_mutex_acquire returns -3,<o:p></o:p></span></p>

<p class=3DMsoNormal><span lang=3DEN-US style=3D'font-size:10.0pt;font-fami=
ly:"Verdana","sans-serif"'>but
this return value is not included among the possible return values in the
documentation of Mutex services.<o:p></o:p></span></p>

<p class=3DMsoNormal><span lang=3DEN-US style=3D'font-size:10.0pt;font-fami=
ly:"Verdana","sans-serif"'><o:p>&nbsp;</o:p></span></p>

<p class=3DMsoNormal><span lang=3DEN-US style=3D'font-size:10.0pt;font-fami=
ly:"Verdana","sans-serif"'>Could
you please explain what this return value -3 means?<o:p></o:p></span></p>

<p class=3DMsoNormal><span lang=3DEN-US style=3D'font-size:10.0pt;font-fami=
ly:"Verdana","sans-serif"'><o:p>&nbsp;</o:p></span></p>

<p class=3DMsoNormal><span lang=3DEN-US style=3D'font-size:10.0pt;font-fami=
ly:"Verdana","sans-serif"'>Best
regards<o:p></o:p></span></p>

<p class=3DMsoNormal><span lang=3DEN-US style=3D'font-size:10.0pt;font-fami=
ly:"Verdana","sans-serif"'>Hans
So=A0 <o:p></o:p></span></p>

<p class=3DMsoNormal><span lang=3DEN-US style=3D'font-size:10.0pt;font-fami=
ly:"Verdana","sans-serif"'><o:p>&nbsp;</o:p></span></p>

<p class=3DMsoNormal><o:p>&nbsp;</o:p></p>

</div>

</body>

</html>

--_000_0AB95BFCF14F984980DE7149C21D6B90065D58B59FFNDMAILB03VIA_--

