From: VEYSSIERE Nicolas <nicolas.veyssiere@domain.hid>
Date: Wed, 22 Jun 2011 12:44:06 +0200
Message-ID: <18303_1308739447_4E01C777_18303_558_1_ECB646CBB62FD044927FDEDF0252D3E701E388B3612E@THSONEA01CMS03P.one.grp>
Content-Language: fr-FR
Content-Type: multipart/alternative;
	boundary="_000_ECB646CBB62FD044927FDEDF0252D3E701E388B3612ETHSONEA01CM_"
MIME-Version: 1.0
Subject: [Xenomai-help] Kernel panic on boot with 2.5.6
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: "xenomai@xenomai.org" <xenomai@xenomai.org>

--_000_ECB646CBB62FD044927FDEDF0252D3E701E388B3612ETHSONEA01CM_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hello,

I succesfully build a 2.6.38.8 kernel with the latest adeos patch and Xenom=
ai 2.5.6, but it kernel panic :

[    1.195878] Pid: 1, comm: swapper Tainted: G         D W     2.6.38-xeno=
mai-r6 #1
[    1.196878] Call Trace:
[    1.196878]  [<c14ae979>] ? panic+0x50/0x145
[    1.197878]  [<c1031250>] ? do_exit+0x5c/0x6be
[    1.198877]  [<c14b071c>] ? _raw_spin_unlock_irqrestore+0xe/0x10
[    1.199877]  [<c102e487>] ? kmsg_dump+0x35/0xb5
[    1.200877]  [<c14b1b32>] ? oops_end+0xa0/0xa8
[    1.201877]  [<c101b448>] ? no_context+0x110/0x11a
[    1.201877]  [<c101b570>] ? __bad_area_nosemaphore+0x11e/0x126
[    1.202877]  [<c101b585>] ? bad_area_nosemaphore+0xd/0x10
[    1.203877]  [<c14b32c1>] ? do_page_fault+0x1c0/0x36b
[    1.203877]  [<c10144da>] ? __ipipe_handle_exception+0x24f/0x288
[    1.203877]  [<c14b11af>] ? error_code+0x5f/0x70
[    1.204876]  [<c10736fe>] ? __xirq_end+0x12/0x2e
[    1.205876]  [<c107472a>] ? ipipe_register_domain+0x1d8/0x1e4
[    1.205876]  [<c108e46e>] ? rthal_init+0x17d/0x20c
[    1.206876]  [<c139e098>] ? rthal_domain_entry+0x0/0x39
[    1.207876]  [<c1706c3d>] ? __xeno_sys_init+0x41/0x261
[    1.208876]  [<c108a4a2>] ? pmu_dev_alloc+0x64/0x7d
[    1.208876]  [<c1001076>] ? do_one_initcall+0x71/0x133
[    1.209876]  [<c1706bfc>] ? __xeno_sys_init+0x0/0x261
[    1.210876]  [<c16f4382>] ? kernel_init+0x128/0x1a4
[    1.211875]  [<c16f425a>] ? kernel_init+0x0/0x1a4
[    1.212875]  [<c1002d06>] ? kernel_thread_helper+0x6/0x10


Could it be a problem with the fact that this system is a virtual box VM ?


Thanks.

--
Nicolas VEYSSIERE

--_000_ECB646CBB62FD044927FDEDF0252D3E701E388B3612ETHSONEA01CM_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" xmlns:o=3D"urn:schemas-micr=
osoft-com:office:office" xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" xmlns=3D"http:=
//www.w3.org/TR/REC-html40">

<head>
<meta http-equiv=3DContent-Type content=3D"text/html; charset=3Dus-ascii">
<meta name=3DGenerator content=3D"Microsoft Word 12 (filtered medium)">
<style>
<!--
 /* Font Definitions */
 @font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
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
	font-family:"Calibri","sans-serif";
	color:windowtext;}
.MsoChpDefault
	{mso-style-type:export-only;}
@page Section1
	{size:612.0pt 792.0pt;
	margin:70.85pt 70.85pt 70.85pt 70.85pt;}
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

<body lang=3DFR link=3Dblue vlink=3Dpurple>

<div class=3DSection1>

<p class=3DMsoNormal>Hello,<o:p></o:p></p>

<p class=3DMsoNormal><o:p>&nbsp;</o:p></p>

<p class=3DMsoNormal>I succesfully build a 2.6.38.8 kernel with the latest =
adeos
patch and Xenomai 2.5.6, but it kernel panic :<o:p></o:p></p>

<p class=3DMsoNormal><o:p>&nbsp;</o:p></p>

<p class=3DMsoNormal><span style=3D'font-family:"Courier New"'>[&nbsp;&nbsp=
;&nbsp;
1.195878] Pid: 1, comm: swapper Tainted:
G&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; D W&nbsp;&nbsp;&nbsp;&nbs=
p;
2.6.38-xenomai-r6 #1<o:p></o:p></span></p>

<p class=3DMsoNormal><span style=3D'font-family:"Courier New"'>[&nbsp;&nbsp=
;&nbsp;
1.196878] Call Trace:<o:p></o:p></span></p>

<p class=3DMsoNormal><span style=3D'font-family:"Courier New"'>[&nbsp;&nbsp=
; &nbsp;1.196878]&nbsp;
[&lt;c14ae979&gt;] ? panic+0x50/0x145<o:p></o:p></span></p>

<p class=3DMsoNormal><span style=3D'font-family:"Courier New"'>[&nbsp;&nbsp=
; &nbsp;1.197878]&nbsp;
[&lt;c1031250&gt;] ? do_exit+0x5c/0x6be<o:p></o:p></span></p>

<p class=3DMsoNormal><span style=3D'font-family:"Courier New"'>[&nbsp;&nbsp=
; &nbsp;1.198877]&nbsp;
[&lt;c14b071c&gt;] ? _raw_spin_unlock_irqrestore+0xe/0x10<o:p></o:p></span>=
</p>

<p class=3DMsoNormal><span style=3D'font-family:"Courier New"'>[&nbsp;&nbsp=
; &nbsp;1.199877]&nbsp;
[&lt;c102e487&gt;] ? kmsg_dump+0x35/0xb5<o:p></o:p></span></p>

<p class=3DMsoNormal><span style=3D'font-family:"Courier New"'>[&nbsp;&nbsp=
; &nbsp;1.200877]&nbsp;
[&lt;c14b1b32&gt;] ? oops_end+0xa0/0xa8<o:p></o:p></span></p>

<p class=3DMsoNormal><span style=3D'font-family:"Courier New"'>[&nbsp;&nbsp=
; &nbsp;1.201877]&nbsp;
[&lt;c101b448&gt;] ? no_context+0x110/0x11a<o:p></o:p></span></p>

<p class=3DMsoNormal><span style=3D'font-family:"Courier New"'>[&nbsp;&nbsp=
; &nbsp;1.201877]&nbsp;
[&lt;c101b570&gt;] ? __bad_area_nosemaphore+0x11e/0x126<o:p></o:p></span></=
p>

<p class=3DMsoNormal><span style=3D'font-family:"Courier New"'>[&nbsp;&nbsp=
; &nbsp;1.202877]&nbsp;
[&lt;c101b585&gt;] ? bad_area_nosemaphore+0xd/0x10<o:p></o:p></span></p>

<p class=3DMsoNormal><span style=3D'font-family:"Courier New"'>[&nbsp;&nbsp=
; &nbsp;1.203877]&nbsp;
[&lt;c14b32c1&gt;] ? do_page_fault+0x1c0/0x36b<o:p></o:p></span></p>

<p class=3DMsoNormal><span style=3D'font-family:"Courier New"'>[&nbsp;&nbsp=
; &nbsp;1.203877]&nbsp;
[&lt;c10144da&gt;] ? __ipipe_handle_exception+0x24f/0x288<o:p></o:p></span>=
</p>

<p class=3DMsoNormal><span style=3D'font-family:"Courier New"'>[&nbsp;&nbsp=
; &nbsp;1.203877]&nbsp;
[&lt;c14b11af&gt;] ? error_code+0x5f/0x70<o:p></o:p></span></p>

<p class=3DMsoNormal><span style=3D'font-family:"Courier New"'>[&nbsp;&nbsp=
; &nbsp;1.204876]&nbsp;
[&lt;c10736fe&gt;] ? __xirq_end+0x12/0x2e<o:p></o:p></span></p>

<p class=3DMsoNormal><span style=3D'font-family:"Courier New"'>[&nbsp;&nbsp=
; &nbsp;1.205876]&nbsp;
[&lt;c107472a&gt;] ? ipipe_register_domain+0x1d8/0x1e4<o:p></o:p></span></p=
>

<p class=3DMsoNormal><span style=3D'font-family:"Courier New"'>[&nbsp;&nbsp=
; &nbsp;1.205876]&nbsp;
[&lt;c108e46e&gt;] ? rthal_init+0x17d/0x20c<o:p></o:p></span></p>

<p class=3DMsoNormal><span style=3D'font-family:"Courier New"'>[&nbsp;&nbsp=
; &nbsp;1.206876]&nbsp;
[&lt;c139e098&gt;] ? rthal_domain_entry+0x0/0x39<o:p></o:p></span></p>

<p class=3DMsoNormal><span style=3D'font-family:"Courier New"'>[&nbsp;&nbsp=
; &nbsp;1.207876]&nbsp;
[&lt;c1706c3d&gt;] ? __xeno_sys_init+0x41/0x261<o:p></o:p></span></p>

<p class=3DMsoNormal><span style=3D'font-family:"Courier New"'>[&nbsp;&nbsp=
; &nbsp;1.208876]&nbsp;
[&lt;c108a4a2&gt;] ? pmu_dev_alloc+0x64/0x7d<o:p></o:p></span></p>

<p class=3DMsoNormal><span style=3D'font-family:"Courier New"'>[&nbsp;&nbsp=
; &nbsp;1.208876]&nbsp;
[&lt;c1001076&gt;] ? do_one_initcall+0x71/0x133<o:p></o:p></span></p>

<p class=3DMsoNormal><span style=3D'font-family:"Courier New"'>[&nbsp;&nbsp=
; &nbsp;1.209876]&nbsp;
[&lt;c1706bfc&gt;] ? __xeno_sys_init+0x0/0x261<o:p></o:p></span></p>

<p class=3DMsoNormal><span style=3D'font-family:"Courier New"'>[&nbsp;&nbsp=
; &nbsp;1.210876]&nbsp;
[&lt;c16f4382&gt;] ? kernel_init+0x128/0x1a4<o:p></o:p></span></p>

<p class=3DMsoNormal><span style=3D'font-family:"Courier New"'>[&nbsp;&nbsp=
; &nbsp;1.211875]&nbsp;
[&lt;c16f425a&gt;] ? kernel_init+0x0/0x1a4<o:p></o:p></span></p>

<p class=3DMsoNormal><span style=3D'font-family:"Courier New"'>[&nbsp;&nbsp=
; &nbsp;1.212875]&nbsp;
[&lt;c1002d06&gt;] ? kernel_thread_helper+0x6/0x10<o:p></o:p></span></p>

<p class=3DMsoNormal><o:p>&nbsp;</o:p></p>

<p class=3DMsoNormal><o:p>&nbsp;</o:p></p>

<p class=3DMsoNormal>Could it be a problem with the fact that this system i=
s a
virtual box VM ?<o:p></o:p></p>

<p class=3DMsoNormal><o:p>&nbsp;</o:p></p>

<p class=3DMsoNormal><o:p>&nbsp;</o:p></p>

<p class=3DMsoNormal>Thanks.<o:p></o:p></p>

<p class=3DMsoNormal><o:p>&nbsp;</o:p></p>

<p class=3DMsoNormal style=3D'line-height:9.0pt;mso-line-height-rule:exactl=
y'><span
style=3D'font-size:10.0pt;font-family:"Courier New"'>-- </span><span
style=3D'font-size:10.0pt;font-family:"Courier New"'><o:p></o:p></span></p>

<p class=3DMsoNormal style=3D'line-height:9.0pt;mso-line-height-rule:exactl=
y'><span
style=3D'font-size:10.0pt;font-family:"Courier New"'>Nicolas VEYSSIERE</spa=
n><o:p></o:p></p>

</div>

</body>

</html>

--_000_ECB646CBB62FD044927FDEDF0252D3E701E388B3612ETHSONEA01CM_--

