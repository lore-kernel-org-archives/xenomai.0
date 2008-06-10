Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C8CB03.A4147892"
Date: Tue, 10 Jun 2008 08:09:47 -0600
Message-ID: <51CAD0CE1504444DBE77CBBE51A0135D470A4D@slcmail.slc.mew.int>
From: "Steven Seeger" <sseeger@domain.hid>
Subject: [Xenomai-help] native queue and timeout
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

------_=_NextPart_001_01C8CB03.A4147892
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hello all. I grabbed svn 3956 and am having a slight problem with
2.6.25.6.

=20

I spawn a native thread that does the following:

=20

        int res;

       =20

        printf("reading..\n");

        res =3D rt_queue_read(&ql, &level_data, sizeof(unsigned long =
int),
TM_INFINITE);

        printf("done?\n");

        if(res!=3Dsizeof(unsigned long int)) {

            rtlog(RTLOG_LEVEL_EMERG, "level thread went wrong. retval
%d", res);

            abort();

        }

=20

The queue "ql" is bound to successfully. The queue is created in another
userspace application. My binding code looks like this:

=20

    if(rt_queue_bind(&ql, "rtlog level", TM_NONBLOCK)) {

        fprintf(stderr, "failed to bind to rtlog level queue -- is
rtlogd running?\n");

        abort();

    }

=20

"ql" is: RT_QUEUE ql;

=20

Now, in the native thread, the call to rt_queue_read always returns with
-ETIMEDOUT  (-110) which makes no sense because I am passing
TM_INFINITE. I made sure my include files were up to date.

=20

Any idea?

=20

Thanks,

Steven

=20


------_=_NextPart_001_01C8CB03.A4147892
Content-Type: text/html;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" =
xmlns:o=3D"urn:schemas-microsoft-com:office:office" =
xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" =
xmlns=3D"http://www.w3.org/TR/REC-html40">

<head>
<META HTTP-EQUIV=3D"Content-Type" CONTENT=3D"text/html; =
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
@font-face
	{font-family:Monaco;
	panose-1:0 0 0 0 0 0 0 0 0 0;}
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

<p class=3DMsoNormal>Hello all. I grabbed svn 3956 and am having a =
slight problem
with 2.6.25.6.<o:p></o:p></p>

<p class=3DMsoNormal><o:p>&nbsp;</o:p></p>

<p class=3DMsoNormal>I spawn a native thread that does the =
following:<o:p></o:p></p>

<p class=3DMsoNormal><o:p>&nbsp;</o:p></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><span =
style=3D'font-size:10.0pt;
font-family:Monaco;color:black'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; </span><span style=3D'font-size:10.0pt;
font-family:Monaco;color:#760F50'>int</span><span =
style=3D'font-size:10.0pt;
font-family:Monaco;color:black'> res;<o:p></o:p></span></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><span =
style=3D'font-size:10.0pt;
font-family:Monaco;color:black'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; <o:p></o:p></span></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><span =
style=3D'font-size:10.0pt;
font-family:Monaco;color:black'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; printf(</span><span style=3D'font-size:
10.0pt;font-family:Monaco;color:#891315'>&quot;reading..\n&quot;</span><s=
pan
style=3D'font-size:10.0pt;font-family:Monaco;color:black'>);<o:p></o:p></=
span></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><span =
style=3D'font-size:10.0pt;
font-family:Monaco;color:black'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; res =3D rt_queue_read(&amp;ql,
&amp;level_data, </span><span =
style=3D'font-size:10.0pt;font-family:Monaco;
color:#760F50'>sizeof</span><span =
style=3D'font-size:10.0pt;font-family:Monaco;
color:black'>(</span><span style=3D'font-size:10.0pt;font-family:Monaco;
color:#760F50'>unsigned</span><span =
style=3D'font-size:10.0pt;font-family:Monaco;
color:black'> </span><span style=3D'font-size:10.0pt;font-family:Monaco;
color:#760F50'>long</span><span =
style=3D'font-size:10.0pt;font-family:Monaco;
color:black'> </span><span style=3D'font-size:10.0pt;font-family:Monaco;
color:#760F50'>int</span><span =
style=3D'font-size:10.0pt;font-family:Monaco;
color:black'>), TM_INFINITE);<o:p></o:p></span></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><span =
style=3D'font-size:10.0pt;
font-family:Monaco;color:black'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; printf(</span><span style=3D'font-size:
10.0pt;font-family:Monaco;color:#891315'>&quot;done?\n&quot;</span><span
style=3D'font-size:10.0pt;font-family:Monaco;color:black'>);<o:p></o:p></=
span></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><span =
style=3D'font-size:10.0pt;
font-family:Monaco;color:black'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; </span><span style=3D'font-size:10.0pt;
font-family:Monaco;color:#760F50'>if</span><span =
style=3D'font-size:10.0pt;
font-family:Monaco;color:black'>(res!=3D</span><span =
style=3D'font-size:10.0pt;
font-family:Monaco;color:#760F50'>sizeof</span><span =
style=3D'font-size:10.0pt;
font-family:Monaco;color:black'>(</span><span style=3D'font-size:10.0pt;
font-family:Monaco;color:#760F50'>unsigned</span><span =
style=3D'font-size:10.0pt;
font-family:Monaco;color:black'> </span><span style=3D'font-size:10.0pt;
font-family:Monaco;color:#760F50'>long</span><span =
style=3D'font-size:10.0pt;
font-family:Monaco;color:black'> </span><span style=3D'font-size:10.0pt;
font-family:Monaco;color:#760F50'>int</span><span =
style=3D'font-size:10.0pt;
font-family:Monaco;color:black'>)) {<o:p></o:p></span></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><span =
style=3D'font-size:10.0pt;
font-family:Monaco;color:black'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; rtlog(RTLOG_LEVEL_EMERG, </span><span
style=3D'font-size:10.0pt;font-family:Monaco;color:#891315'>&quot;level =
thread
went wrong. retval %d&quot;</span><span =
style=3D'font-size:10.0pt;font-family:
Monaco;color:black'>, res);<o:p></o:p></span></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><span =
style=3D'font-size:10.0pt;
font-family:Monaco;color:black'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; abort();<o:p></o:p></span></p>

<p class=3DMsoNormal><span =
style=3D'font-size:10.0pt;font-family:Monaco;color:black'>&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;
}<o:p></o:p></span></p>

<p class=3DMsoNormal><span =
style=3D'font-size:10.0pt;font-family:Monaco;color:black'><o:p>&nbsp;</o:=
p></span></p>

<p class=3DMsoNormal><span =
style=3D'font-size:10.0pt;font-family:Monaco;color:black'>The
queue &#8220;ql&#8221; is bound to successfully. The queue is created in
another userspace application. My binding code looks like =
this:<o:p></o:p></span></p>

<p class=3DMsoNormal><span =
style=3D'font-size:10.0pt;font-family:Monaco;color:black'><o:p>&nbsp;</o:=
p></span></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><span =
style=3D'font-size:10.0pt;
font-family:Monaco;color:black'>&nbsp;&nbsp;&nbsp; </span><span =
style=3D'font-size:10.0pt;
font-family:Monaco;color:#760F50'>if</span><span =
style=3D'font-size:10.0pt;
font-family:Monaco;color:black'>(rt_queue_bind(&amp;ql, </span><span
style=3D'font-size:10.0pt;font-family:Monaco;color:#891315'>&quot;rtlog
level&quot;</span><span =
style=3D'font-size:10.0pt;font-family:Monaco;color:black'>,
TM_NONBLOCK)) {<o:p></o:p></span></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><span =
style=3D'font-size:10.0pt;
font-family:Monaco;color:black'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; fprintf(stderr, </span><span
style=3D'font-size:10.0pt;font-family:Monaco;color:#891315'>&quot;failed =
to bind
to rtlog level queue -- is rtlogd running?\n&quot;</span><span
style=3D'font-size:10.0pt;font-family:Monaco;color:black'>);<o:p></o:p></=
span></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><span =
style=3D'font-size:10.0pt;
font-family:Monaco;color:black'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; abort();<o:p></o:p></span></p>

<p class=3DMsoNormal><span =
style=3D'font-size:10.0pt;font-family:Monaco;color:black'>&nbsp;&nbsp;&nb=
sp;
}<o:p></o:p></span></p>

<p class=3DMsoNormal><span =
style=3D'font-size:10.0pt;font-family:Monaco;color:black'><o:p>&nbsp;</o:=
p></span></p>

<p class=3DMsoNormal><span =
style=3D'font-size:10.0pt;font-family:Monaco;color:black'>&#8220;ql&#8221=
;
is: RT_QUEUE ql;<o:p></o:p></span></p>

<p class=3DMsoNormal><span =
style=3D'font-size:10.0pt;font-family:Monaco;color:black'><o:p>&nbsp;</o:=
p></span></p>

<p class=3DMsoNormal><span =
style=3D'font-size:10.0pt;font-family:Monaco;color:black'>Now,
in the native thread, the call to rt_queue_read always returns with =
-ETIMEDOUT &nbsp;(-110)
which makes no sense because I am passing TM_INFINITE. I made sure my =
include
files were up to date.<o:p></o:p></span></p>

<p class=3DMsoNormal><span =
style=3D'font-size:10.0pt;font-family:Monaco;color:black'><o:p>&nbsp;</o:=
p></span></p>

<p class=3DMsoNormal><span =
style=3D'font-size:10.0pt;font-family:Monaco;color:black'>Any
idea?<o:p></o:p></span></p>

<p class=3DMsoNormal><span =
style=3D'font-size:10.0pt;font-family:Monaco;color:black'><o:p>&nbsp;</o:=
p></span></p>

<p class=3DMsoNormal><span =
style=3D'font-size:10.0pt;font-family:Monaco;color:black'>Thanks,<o:p></o=
:p></span></p>

<p class=3DMsoNormal><span =
style=3D'font-size:10.0pt;font-family:Monaco;color:black'>Steven<o:p></o:=
p></span></p>

<p class=3DMsoNormal><o:p>&nbsp;</o:p></p>

</div>

</body>

</html>

------_=_NextPart_001_01C8CB03.A4147892--

