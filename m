From: "Wayne Call" <wcall@domain.hid>
Date: Fri, 10 Apr 2009 14:22:02 -0600
Message-ID: <000001c9ba1a$02e1ac70$08a50550$@com>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_NextPart_000_0001_01C9B9E7.B8473C70"
Content-Language: en-us
Subject: [Xenomai-help] Section Mismatch
Reply-To: wcall@domain.hid
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

This is a multipart message in MIME format.

------=_NextPart_000_0001_01C9B9E7.B8473C70
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit

I get the following "Section mismatch" warnings when attempting to build the
lm73_rtdm.c and lpl_twi_uart_rtdm.c drivers.  What causes a mismatch?

 

 

WARNING: arch/blackfin/mach-bf537/boards/lm73_rtdm.o - Section mismatch:
reference to .init.data:_device_tmpl from .text between
'_rt_lm73_sensor_device_create' (at offset 0x108) and
'_rt_lm73_sensor_ioctl'

WARNING: arch/blackfin/mach-bf537/boards/lm73_rtdm.o - Section mismatch:
reference to .init.data:_device_tmpl from .text between
'_rt_lm73_sensor_device_create' (at offset 0x114) and
'_rt_lm73_sensor_ioctl'

WARNING: arch/blackfin/mach-bf537/boards/lpl_twi_uart_rtdm.o - Section
mismatch: reference to .init.data:_device_tmpl from .text after
'_rt_lpl_twi_uart_device_create' (at offset 0x298)

WARNING: arch/blackfin/mach-bf537/boards/lpl_twi_uart_rtdm.o - Section
mismatch: reference to .init.data:_device_tmpl from .text after
'_rt_lpl_twi_uart_device_create' (at offset 0x2a4)

 

 

The "Section mismatch" might be related to the following code?

 

 
static const struct rtdm_device __initdata device_tmpl = {
    struct_version:     RTDM_DEVICE_STRUCT_VER,
 
    device_flags:       RTDM_NAMED_DEVICE | RTDM_EXCLUSIVE,
    device_name:        "",
    open_rt:            rt_lm73_sensor_open,
    ops: {
        close_rt:       rt_lm73_sensor_close,
        ioctl_rt:       rt_lm73_sensor_ioctl,
    },
    device_class:       RTDM_CLASS_LM73,
    driver_name:        "lm73_sensor_rtd",
    driver_version:     RTDM_DRIVER_VER(1, 0, 0),
    peripheral_name:    "i2c_lm73",
    provider_name:      "LonePeakLabs.Inc",
};

 

 

Wayne

 


------=_NextPart_000_0001_01C9B9E7.B8473C70
Content-Type: text/html;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" =
xmlns:o=3D"urn:schemas-microsoft-com:office:office" =
xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" =
xmlns=3D"http://www.w3.org/TR/REC-html40">

<head>
<meta http-equiv=3DContent-Type content=3D"text/html; =
charset=3Dus-ascii">
<meta name=3DGenerator content=3D"Microsoft Word 12 (filtered medium)">
<style>
<!--
 /* Font Definitions */
 @font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
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
pre
	{mso-style-priority:99;
	mso-style-link:"HTML Preformatted Char";
	margin:0in;
	margin-bottom:.0001pt;
	font-size:10.0pt;
	font-family:"Courier New";}
span.EmailStyle17
	{mso-style-type:personal-compose;
	font-family:"Calibri","sans-serif";
	color:windowtext;}
span.HTMLPreformattedChar
	{mso-style-name:"HTML Preformatted Char";
	mso-style-priority:99;
	mso-style-link:"HTML Preformatted";
	font-family:"Courier New";}
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

<p class=3DMsoNormal style=3D'background:white'><span =
style=3D'font-size:10.0pt;
font-family:"Courier New";color:black'>I get the following =
&#8220;Section
mismatch&#8221; warnings when attempting to build the lm73_rtdm.c and
lpl_twi_uart_rtdm.c drivers.&nbsp; What causes a =
mismatch?<o:p></o:p></span></p>

<p class=3DMsoNormal style=3D'background:white'><span =
style=3D'font-size:10.0pt;
font-family:"Courier New";color:black'><o:p>&nbsp;</o:p></span></p>

<p class=3DMsoNormal style=3D'background:white'><span =
style=3D'font-size:10.0pt;
font-family:"Courier New";color:black'><o:p>&nbsp;</o:p></span></p>

<p class=3DMsoNormal style=3D'background:white'><span =
style=3D'font-size:10.0pt;
font-family:"Courier New";color:black'>WARNING:
arch/blackfin/mach-bf537/boards/lm73_rtdm.o - Section mismatch: =
reference to
.init.data:_device_tmpl from .text between =
'_rt_lm73_sensor_device_create' (at
offset 0x108) and '_rt_lm73_sensor_ioctl'<o:p></o:p></span></p>

<p class=3DMsoNormal style=3D'background:white'><span =
style=3D'font-size:10.0pt;
font-family:"Courier New";color:black'>WARNING:
arch/blackfin/mach-bf537/boards/lm73_rtdm.o - Section mismatch: =
reference to
.init.data:_device_tmpl from .text between =
'_rt_lm73_sensor_device_create' (at
offset 0x114) and '_rt_lm73_sensor_ioctl'<o:p></o:p></span></p>

<p class=3DMsoNormal style=3D'background:white'><span =
style=3D'font-size:10.0pt;
font-family:"Courier New";color:black'>WARNING:
arch/blackfin/mach-bf537/boards/lpl_twi_uart_rtdm.o - Section mismatch:
reference to .init.data:_device_tmpl from .text after
'_rt_lpl_twi_uart_device_create' (at offset 0x298)<o:p></o:p></span></p>

<p class=3DMsoNormal style=3D'background:white'><span =
style=3D'font-size:10.0pt;
font-family:"Courier New";color:black'>WARNING:
arch/blackfin/mach-bf537/boards/lpl_twi_uart_rtdm.o - Section mismatch:
reference to .init.data:_device_tmpl from .text after
'_rt_lpl_twi_uart_device_create' (at offset 0x2a4)<o:p></o:p></span></p>

<p class=3DMsoNormal style=3D'background:white'><span =
style=3D'font-size:10.0pt;
font-family:"Courier New";color:black'><o:p>&nbsp;</o:p></span></p>

<p class=3DMsoNormal style=3D'background:white'><span =
style=3D'font-size:10.0pt;
font-family:"Courier New";color:black'><o:p>&nbsp;</o:p></span></p>

<p class=3DMsoNormal style=3D'background:white'><span =
style=3D'font-size:10.0pt;
font-family:"Courier New";color:black'>The &#8220;Section =
mismatch&#8221; might
be related to the following code?<o:p></o:p></span></p>

<p class=3DMsoNormal style=3D'background:white'><span =
style=3D'font-size:10.0pt;
font-family:"Courier New";color:black'><o:p>&nbsp;</o:p></span></p>

<pre style=3D'background:white'><b><span =
style=3D'color:purple'><o:p>&nbsp;</o:p></span></b></pre><pre
style=3D'background:white'><b><span =
style=3D'color:purple'>static</span></b><span
style=3D'color:black'> </span><b><span =
style=3D'color:purple'>const</span></b><span
style=3D'color:black'> </span><b><span =
style=3D'color:purple'>struct</span></b><span
style=3D'color:black'> rtdm_device __initdata device_tmpl =3D =
</span><span
style=3D'color:maroon'>{</span><span =
style=3D'color:black'><o:p></o:p></span></pre><pre
style=3D'background:white'><span =
style=3D'color:black'>&nbsp;&nbsp;&nbsp; =
struct_version:&nbsp;&nbsp;&nbsp;&nbsp; =
RTDM_DEVICE_STRUCT_VER,<o:p></o:p></span></pre><pre
style=3D'background:white'><span =
style=3D'color:black'><o:p>&nbsp;</o:p></span></pre><pre
style=3D'background:white'><span =
style=3D'color:black'>&nbsp;&nbsp;&nbsp; =
device_flags:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RTDM_NAMED_DEVICE | =
RTDM_EXCLUSIVE,<o:p></o:p></span></pre><pre
style=3D'background:white'><span =
style=3D'color:black'>&nbsp;&nbsp;&nbsp; =
device_name:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span><span
style=3D'color:teal'>&quot;&quot;</span><span =
style=3D'color:black'>,<o:p></o:p></span></pre><pre
style=3D'background:white'><span =
style=3D'color:black'>&nbsp;&nbsp;&nbsp; =
open_rt:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; rt_lm73_sensor_open,<o:p></o:p></span></pre><pre
style=3D'background:white'><span =
style=3D'color:black'>&nbsp;&nbsp;&nbsp; ops: </span><span
style=3D'color:maroon'>{</span><span =
style=3D'color:black'><o:p></o:p></span></pre><pre
style=3D'background:white'><span =
style=3D'color:black'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
close_rt:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
rt_lm73_sensor_close,<o:p></o:p></span></pre><pre
style=3D'background:white'><span =
style=3D'color:black'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
ioctl_rt:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
rt_lm73_sensor_ioctl,<o:p></o:p></span></pre><pre
style=3D'background:white'><span =
style=3D'color:black'>&nbsp;&nbsp;&nbsp; </span><span
style=3D'color:maroon'>}</span><span =
style=3D'color:black'>,<o:p></o:p></span></pre><pre
style=3D'background:white'><span =
style=3D'color:black'>&nbsp;&nbsp;&nbsp; =
device_class:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
RTDM_CLASS_LM73,<o:p></o:p></span></pre><pre
style=3D'background:white'><span =
style=3D'color:black'>&nbsp;&nbsp;&nbsp; =
driver_name:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span><span
style=3D'color:teal'>&quot;lm73_sensor_rtd&quot;</span><span =
style=3D'color:black'>,<o:p></o:p></span></pre><pre
style=3D'background:white'><span =
style=3D'color:black'>&nbsp;&nbsp;&nbsp; =
driver_version:&nbsp;&nbsp;&nbsp;&nbsp; =
<b>RTDM_DRIVER_VER</b>(</span><span
style=3D'color:navy'>1</span><span style=3D'color:black'>, </span><span
style=3D'color:navy'>0</span><span style=3D'color:black'>, </span><span
style=3D'color:navy'>0</span><span =
style=3D'color:black'>),<o:p></o:p></span></pre><pre
style=3D'background:white'><span =
style=3D'color:black'>&nbsp;&nbsp;&nbsp; =
peripheral_name:&nbsp;&nbsp;&nbsp; </span><span
style=3D'color:teal'>&quot;i2c_lm73&quot;</span><span =
style=3D'color:black'>,<o:p></o:p></span></pre><pre
style=3D'background:white'><span =
style=3D'color:black'>&nbsp;&nbsp;&nbsp; =
provider_name:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span><span
style=3D'color:teal'>&quot;LonePeakLabs.Inc&quot;</span><span =
style=3D'color:black'>,<o:p></o:p></span></pre><pre
style=3D'background:white'><span style=3D'color:maroon'>}</span><span
style=3D'color:black'>;<o:p></o:p></span></pre>

<p class=3DMsoNormal style=3D'background:white'><span =
style=3D'font-size:10.0pt;
font-family:"Courier New";color:black'><o:p>&nbsp;</o:p></span></p>

<p class=3DMsoNormal><o:p>&nbsp;</o:p></p>

<p class=3DMsoNormal>Wayne<o:p></o:p></p>

<p class=3DMsoNormal><o:p>&nbsp;</o:p></p>

</div>

</body>

</html>

------=_NextPart_000_0001_01C9B9E7.B8473C70--


