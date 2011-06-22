From: Sambasiva Rao Manchili <sambasiva.manchili@domain.hid>
Date: Wed, 22 Jun 2011 12:58:38 +0200
Message-ID: <509DA52866E38F47878413CF102D751F70A7E43FFE@poseidon.nexus-ag.com>
References: <18303_1308739447_4E01C777_18303_558_1_ECB646CBB62FD044927FDEDF0252D3E701E388B3612E@THSONEA01CMS03P.one.grp>
In-Reply-To: <18303_1308739447_4E01C777_18303_558_1_ECB646CBB62FD044927FDEDF0252D3E701E388B3612E@THSONEA01CMS03P.one.grp>
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_509DA52866E38F47878413CF102D751F70A7E43FFEposeidonnexus_"
MIME-Version: 1.0
Subject: Re: [Xenomai-help] Kernel panic on boot with 2.5.6
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: VEYSSIERE Nicolas <nicolas.veyssiere@domain.hid>, "xenomai@xenomai.org" <xenomai@xenomai.org>

--_000_509DA52866E38F47878413CF102D751F70A7E43FFEposeidonnexus_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

HI Nicolas,
For me similar panic was solved by adding
noapic and acpi=3Dnoirq options in Kernel Boot parameters while booting edi=
t and add them and  please see if it helps.

Samba


________________________________
From: xenomai-help-bounces@domain.hid [mailto:xenomai-help-bounces@domain.hid] On=
 Behalf Of VEYSSIERE Nicolas
Sent: Wednesday, 22. June, 2011 12:44
To: xenomai@xenomai.org
Subject: [Xenomai-help] Kernel panic on boot with 2.5.6

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

________________________________
This email and any attachment may contain confidential information which is=
 intended for use only by the addressee(s) named above. If you received thi=
s email by mistake, please notify the sender immediately, and delete the em=
ail from your system. You are prohibited from copying, disseminating or oth=
erwise using the email or any attachment.

--_000_509DA52866E38F47878413CF102D751F70A7E43FFEposeidonnexus_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<html xmlns=3D"http://www.w3.org/TR/REC-html40" xmlns:v=3D"urn:schemas-micr=
osoft-com:vml" xmlns:o=3D"urn:schemas-microsoft-com:office:office" xmlns:w=
=3D"urn:schemas-microsoft-com:office:word" xmlns:m=3D"http://schemas.micros=
oft.com/office/2004/12/omml">
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<meta name=3D"GENERATOR" content=3D"MSHTML 8.00.6001.19046">
<style>@font-face {
	font-family: Cambria Math;
}
@font-face {
	font-family: Calibri;
}
@page Section1 {size: 612.0pt 792.0pt; margin: 70.85pt 70.85pt 70.85pt 70.8=
5pt; }
P.MsoNormal {
	MARGIN: 0cm 0cm 0pt; FONT-FAMILY: "Calibri","sans-serif"; FONT-SIZE: 11pt
}
LI.MsoNormal {
	MARGIN: 0cm 0cm 0pt; FONT-FAMILY: "Calibri","sans-serif"; FONT-SIZE: 11pt
}
DIV.MsoNormal {
	MARGIN: 0cm 0cm 0pt; FONT-FAMILY: "Calibri","sans-serif"; FONT-SIZE: 11pt
}
A:link {
	COLOR: blue; TEXT-DECORATION: underline; mso-style-priority: 99
}
SPAN.MsoHyperlink {
	COLOR: blue; TEXT-DECORATION: underline; mso-style-priority: 99
}
A:visited {
	COLOR: purple; TEXT-DECORATION: underline; mso-style-priority: 99
}
SPAN.MsoHyperlinkFollowed {
	COLOR: purple; TEXT-DECORATION: underline; mso-style-priority: 99
}
SPAN.EmailStyle17 {
	FONT-FAMILY: "Calibri","sans-serif"; COLOR: windowtext; mso-style-type: pe=
rsonal-compose
}
.MsoChpDefault {
	mso-style-type: export-only
}
DIV.Section1 {
	page: Section1
}
</style><!--[if gte mso 9]><xml>
 <o:shapedefaults v:ext=3D"edit" spidmax=3D"1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
 <o:shapelayout v:ext=3D"edit">
  <o:idmap v:ext=3D"edit" data=3D"1" />
 </o:shapelayout></xml><![endif]-->
</head>
<body lang=3D"FR" link=3D"blue" vlink=3D"purple">
<div dir=3D"ltr" align=3D"left"><span class=3D"499055610-22062011"><font co=
lor=3D"#0000ff" size=3D"2" face=3D"Arial">HI Nicolas,</font></span></div>
<div dir=3D"ltr" align=3D"left"><span class=3D"499055610-22062011"><font co=
lor=3D"#0000ff" size=3D"2" face=3D"Arial">For me similar panic was solved b=
y adding
</font></span></div>
<div dir=3D"ltr" align=3D"left"><span class=3D"499055610-22062011"><font co=
lor=3D"#0000ff" size=3D"2" face=3D"Arial">noapic and acpi=3Dnoirq options i=
n Kernel Boot parameters while booting edit and add them and&nbsp; please s=
ee if it helps.</font></span></div>
<div dir=3D"ltr" align=3D"left"><span class=3D"499055610-22062011"><font co=
lor=3D"#0000ff" size=3D"2" face=3D"Arial"></font></span>&nbsp;</div>
<div dir=3D"ltr" align=3D"left"><span class=3D"499055610-22062011"><font co=
lor=3D"#0000ff" size=3D"2" face=3D"Arial">Samba</font></span></div>
<div dir=3D"ltr" align=3D"left"><span class=3D"499055610-22062011"><font co=
lor=3D"#0000ff" size=3D"2" face=3D"Arial"></font></span>&nbsp;</div>
<br>
<div dir=3D"ltr" lang=3D"en-us" class=3D"OutlookMessageHeader" align=3D"lef=
t">
<hr tabindex=3D"-1">
<font size=3D"2" face=3D"Tahoma"><b>From:</b> xenomai-help-bounces@domain.hid =
[mailto:xenomai-help-bounces@domain.hid]
<b>On Behalf Of </b>VEYSSIERE Nicolas<br>
<b>Sent:</b> Wednesday, 22. June, 2011 12:44<br>
<b>To:</b> xenomai@xenomai.org<br>
<b>Subject:</b> [Xenomai-help] Kernel panic on boot with 2.5.6<br>
</font><br>
</div>
<div></div>
<div class=3D"Section1">
<p class=3D"MsoNormal">Hello,<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">I succesfully build a 2.6.38.8 kernel with the lates=
t adeos patch and Xenomai 2.5.6, but it kernel panic :<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal"><span style=3D"FONT-FAMILY: 'Courier New'">[&nbsp;&n=
bsp;&nbsp; 1.195878] Pid: 1, comm: swapper Tainted: G&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp; D W&nbsp;&nbsp;&nbsp;&nbsp; 2.6.38-xenomai-r6 #1=
<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"FONT-FAMILY: 'Courier New'">[&nbsp;&n=
bsp;&nbsp; 1.196878] Call Trace:<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"FONT-FAMILY: 'Courier New'">[&nbsp;&n=
bsp; &nbsp;1.196878]&nbsp; [&lt;c14ae979&gt;] ? panic&#43;0x50/0x145<o:p></=
o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"FONT-FAMILY: 'Courier New'">[&nbsp;&n=
bsp; &nbsp;1.197878]&nbsp; [&lt;c1031250&gt;] ? do_exit&#43;0x5c/0x6be<o:p>=
</o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"FONT-FAMILY: 'Courier New'">[&nbsp;&n=
bsp; &nbsp;1.198877]&nbsp; [&lt;c14b071c&gt;] ? _raw_spin_unlock_irqrestore=
&#43;0xe/0x10<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"FONT-FAMILY: 'Courier New'">[&nbsp;&n=
bsp; &nbsp;1.199877]&nbsp; [&lt;c102e487&gt;] ? kmsg_dump&#43;0x35/0xb5<o:p=
></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"FONT-FAMILY: 'Courier New'">[&nbsp;&n=
bsp; &nbsp;1.200877]&nbsp; [&lt;c14b1b32&gt;] ? oops_end&#43;0xa0/0xa8<o:p>=
</o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"FONT-FAMILY: 'Courier New'">[&nbsp;&n=
bsp; &nbsp;1.201877]&nbsp; [&lt;c101b448&gt;] ? no_context&#43;0x110/0x11a<=
o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"FONT-FAMILY: 'Courier New'">[&nbsp;&n=
bsp; &nbsp;1.201877]&nbsp; [&lt;c101b570&gt;] ? __bad_area_nosemaphore&#43;=
0x11e/0x126<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"FONT-FAMILY: 'Courier New'">[&nbsp;&n=
bsp; &nbsp;1.202877]&nbsp; [&lt;c101b585&gt;] ? bad_area_nosemaphore&#43;0x=
d/0x10<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"FONT-FAMILY: 'Courier New'">[&nbsp;&n=
bsp; &nbsp;1.203877]&nbsp; [&lt;c14b32c1&gt;] ? do_page_fault&#43;0x1c0/0x3=
6b<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"FONT-FAMILY: 'Courier New'">[&nbsp;&n=
bsp; &nbsp;1.203877]&nbsp; [&lt;c10144da&gt;] ? __ipipe_handle_exception&#4=
3;0x24f/0x288<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"FONT-FAMILY: 'Courier New'">[&nbsp;&n=
bsp; &nbsp;1.203877]&nbsp; [&lt;c14b11af&gt;] ? error_code&#43;0x5f/0x70<o:=
p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"FONT-FAMILY: 'Courier New'">[&nbsp;&n=
bsp; &nbsp;1.204876]&nbsp; [&lt;c10736fe&gt;] ? __xirq_end&#43;0x12/0x2e<o:=
p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"FONT-FAMILY: 'Courier New'">[&nbsp;&n=
bsp; &nbsp;1.205876]&nbsp; [&lt;c107472a&gt;] ? ipipe_register_domain&#43;0=
x1d8/0x1e4<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"FONT-FAMILY: 'Courier New'">[&nbsp;&n=
bsp; &nbsp;1.205876]&nbsp; [&lt;c108e46e&gt;] ? rthal_init&#43;0x17d/0x20c<=
o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"FONT-FAMILY: 'Courier New'">[&nbsp;&n=
bsp; &nbsp;1.206876]&nbsp; [&lt;c139e098&gt;] ? rthal_domain_entry&#43;0x0/=
0x39<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"FONT-FAMILY: 'Courier New'">[&nbsp;&n=
bsp; &nbsp;1.207876]&nbsp; [&lt;c1706c3d&gt;] ? __xeno_sys_init&#43;0x41/0x=
261<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"FONT-FAMILY: 'Courier New'">[&nbsp;&n=
bsp; &nbsp;1.208876]&nbsp; [&lt;c108a4a2&gt;] ? pmu_dev_alloc&#43;0x64/0x7d=
<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"FONT-FAMILY: 'Courier New'">[&nbsp;&n=
bsp; &nbsp;1.208876]&nbsp; [&lt;c1001076&gt;] ? do_one_initcall&#43;0x71/0x=
133<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"FONT-FAMILY: 'Courier New'">[&nbsp;&n=
bsp; &nbsp;1.209876]&nbsp; [&lt;c1706bfc&gt;] ? __xeno_sys_init&#43;0x0/0x2=
61<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"FONT-FAMILY: 'Courier New'">[&nbsp;&n=
bsp; &nbsp;1.210876]&nbsp; [&lt;c16f4382&gt;] ? kernel_init&#43;0x128/0x1a4=
<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"FONT-FAMILY: 'Courier New'">[&nbsp;&n=
bsp; &nbsp;1.211875]&nbsp; [&lt;c16f425a&gt;] ? kernel_init&#43;0x0/0x1a4<o=
:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"FONT-FAMILY: 'Courier New'">[&nbsp;&n=
bsp; &nbsp;1.212875]&nbsp; [&lt;c1002d06&gt;] ? kernel_thread_helper&#43;0x=
6/0x10<o:p></o:p></span></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Could it be a problem with the fact that this system=
 is a virtual box VM ?<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Thanks.<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p style=3D"LINE-HEIGHT: 9pt; mso-line-height-rule: exactly" class=3D"MsoNo=
rmal"><span style=3D"FONT-FAMILY: 'Courier New'; FONT-SIZE: 10pt">--
</span><span style=3D"FONT-FAMILY: 'Courier New'; FONT-SIZE: 10pt"><o:p></o=
:p></span></p>
<p style=3D"LINE-HEIGHT: 9pt; mso-line-height-rule: exactly" class=3D"MsoNo=
rmal"><span style=3D"FONT-FAMILY: 'Courier New'; FONT-SIZE: 10pt">Nicolas V=
EYSSIERE</span><o:p></o:p></p>
</div>
<br>
<hr>
<font face=3D"Arial" color=3D"Gray" size=3D"1">This email and any attachmen=
t may contain confidential information which is intended for use only by th=
e addressee(s) named above. If you received this email by mistake, please n=
otify the sender immediately, and delete
 the email from your system. You are prohibited from copying, disseminating=
 or otherwise using the email or any attachment.<br>
</font>
</body>
</html>

--_000_509DA52866E38F47878413CF102D751F70A7E43FFEposeidonnexus_--


