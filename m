From: Michael Pustylnik <MichaelPustylnik@domain.hid>
Date: Thu, 12 Apr 2012 11:45:04 -0400
Message-ID: <990B36E792F1A4488D3E2B1C46FD62D692DDD85791@domain.hid>
References: <4F7333E7.7030608@domain.hid> <4F7339A8.6060701@domain.hid>
	<4F735716.4020508@domain.hid> <4F7C7DEA.5070201@domain.hid>
In-Reply-To: <4F7C7DEA.5070201@domain.hid>
Content-Language: en-US
Content-Type: multipart/mixed;
	boundary="_004_990B36E792F1A4488D3E2B1C46FD62D692DDD85791corpmail2_"
MIME-Version: 1.0
Subject: Re: [Xenomai-help] Interrupt latency greater than 250ms
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Philippe Gerum <rpm@xenomai.org>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

--_004_990B36E792F1A4488D3E2B1C46FD62D692DDD85791corpmail2_
Content-Type: multipart/alternative;
	boundary="_000_990B36E792F1A4488D3E2B1C46FD62D692DDD85791corpmail2_"

--_000_990B36E792F1A4488D3E2B1C46FD62D692DDD85791corpmail2_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

The code masking the interrupt in IPIC (call for ipipe_pre_cascade_noeoi())=
  initially showed up in the patch you recommended (see your email attached=
).
Later on it was integrated in Xenomai commit "9a5e42df8bccc59620c08caeb4b9f=
e92dbf94a1b".

As shown in the trail below, it keeps interrupts all the time until the sch=
eduler returns, thus breaking real-time responsiveness.
A solution to this is probably to remove calling ipipe_pre_cascade_noeoi() =
and let the cascading handler mask the interrupt. Am I missing something? D=
o you think it is safe to use this solution?


Michael Pustylnik, P.Eng.
Senior Software Engineer
RuggedCom Inc.
www.ruggedcom.com<http://www.ruggedcom.com/>
300 Applewood Crescent
Concord, Ontario, L4K 5C7
Tel:  (905)482-4523
Fax: (905)856-1995



________________________________
From: xenomai-help-bounces@domain.hid [mailto:xenomai-help-bounces@domain.hid] On=
 Behalf Of Makarand Pradhan
Sent: Wednesday, April 04, 2012 12:59 PM
To: Philippe Gerum
Cc: xenomai@xenomai.org
Subject: Re: [Xenomai-help] Interrupt latency greater than 250ms. Question.

Hi Philippe,

We have found that the problem is that the interrupt is unexpectedly held m=
asked at the IPIC level for a long time. Please find the trace below:

 2552 :|  + func               -54413    0.590  qe_ic_cascade_low_ipic+0x8 =
(__ipipe_ack_irq+0x2c)
 2553 :|  + func               -54412    0.696  qe_ic_get_low_irq+0x8 (qe_i=
c_cascade_low_ipic+0x30)
 2554 :|  + func               -54411    0.666  irq_linear_revmap+0x8 (qe_i=
c_get_low_irq+0x5c)

MASK in IPIC (SIMSR_H register bit 1)
 2555 :|  + func               -54411    0.606  ipic_mask_irq+0x8 (qe_ic_ca=
scade_low_ipic+0x48)
 2556 :|  + func               -54410    0.590  irqd_to_hwirq+0x8 (ipic_mas=
k_irq+0x30)
 2557 :|  + func               -54410    0.909  __ipipe_spin_lock_irqsave+0=
x8 (ipic_mask_irq+0x40)
 2558 :|  # func               -54409    0.727  __ipipe_spin_unlock_irqrest=
ore+0x8 (ipic_mask_irq+0xa8      )
 2559 :|  + func               -54408    0.560  __ipipe_qe_ic_cascade_irq+0=
x8 (qe_ic_cascade_low_ipic+      0x5c)
 2560 :|  + begin   0x0000002b -54407    0.530  __ipipe_qe_ic_cascade_irq+0=
x2c (qe_ic_cascade_low_ipic      +0x5c)
 2561 :|  + func               -54407    0.651  __ipipe_handle_irq+0x8 (__i=
pipe_qe_ic_cascade_irq+0x38      )
 2562 :|  + func               -54406    0.939  __ipipe_ack_level_irq+0x8 (=
__ipipe_handle_irq+0xbc)

MASK in QUICC (CIMR register bit 11)
 2563 :|  + func               -54405    0.787  qe_ic_mask_irq+0x8 (__ipipe=
_ack_level_irq+0x40)

XENOMAI SCHEDULER IS INVOKED
 2576 :|  # func               -54393    0.590  __xnpod_schedule+0x8 (xnint=
r_irq_handler+0x1f8)

UNMASK in QUICC (done by our user space handler)
 2595 :   + func               -54377    0.621  __rt_intr_enable+0x8 [xeno_=
native] (hisyscall_event+0x      1e4)

UNMASK in IPIC (after 50ms, i.e. only after the scheduler returns):
31637 :|   #end     0x0000002b  -518+   2.272  __ipipe_qe_ic_cascade_irq+0x=
40 (qe_ic_cascade_low_ipic+      0x5c)
31638 :|   #func                -516+   1.090  ipic_unmask_irq+0x8 (qe_ic_c=
ascade_low_ipic+0x70)

As you can see from the trace above, the interrupt is held masked at the IP=
IC level all the time until the Xenomai scheduler returns and is only unmas=
ked after that.
Is it really the way it should be? Shouldn't the interrupt be unmasked at t=
he IPIC level right after masking it at the QUICC engine level?
Rgds,
Mak.


On 28/03/12 02:23 PM, Makarand Pradhan wrote:

Hi Philippe,



On 28/03/12 12:17 PM, Philippe Gerum wrote:

The log says your code wants to control when the IRQ is enabled again,

by calling rt_intr_enable() from userland. I guess you are setting

I_NOAUTOENA too. Correct?



That is correct. I_NOAUTOENA is used in rt_intr_create. Otherwise the

level trigerred interrupt will not allow the userland processing of the

int. The userland handler is very small and it unconditionally

rt_intr_enables the intr.



Testing indicates that the interrupt is always enabled from user space

within 250 usec after kernel gets the interrupt.



I have noted that unless I see "#end 0x0000002b" and a hit to the

ipic_unmask_irq, the next interrupt is not processed.



And this is getting delayed once in a while which causes a delay in

processing the next interrupt.



So the sequence of events leading to the problem is:



1. Get interrupt: #begin   0x0000002b noted in ipipe trace

2. Intr enabled from user space. Always happens roughly within 250usec.

3. #end 0x0000002b noted in ipipe trace where the int is unmasked by ipipe.



When I see the problem, step 3 is delayed. I am trying to capture a

trace where the begin, int enable and end are captured.



Your thoughts on what might cause this delay would be appreciated.



Rgds,

Mak.














--

___________________________________________________________________________

NOTICE OF CONFIDENTIALITY:

This e-mail and any attachments may contain confidential and privileged inf=
ormation.  If you are

not the intended recipient, please notify the sender immediately by return =
e-mail and delete this

e-mail and any copies.  Any dissemination or use of this information by a p=
erson other than the

intended recipient is unauthorized and may be illegal.

_____________________________________________________________________





No virus found in this incoming message.
Checked by AVG - www.avg.com
Version: 8.5.455 / Virus Database: 271.1.1/4175 - Release Date: 04/03/12 18=
:35:00

--_000_990B36E792F1A4488D3E2B1C46FD62D692DDD85791corpmail2_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" xmlns:o=3D"urn:schemas-micr=
osoft-com:office:office" xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:st1=3D"urn:schemas-microsoft-com:office:smarttags" xmlns=3D"http://ww=
w.w3.org/TR/REC-html40">

<head>
<META HTTP-EQUIV=3D"Content-Type" CONTENT=3D"text/html; charset=3Dus-ascii"=
>
<meta name=3DGenerator content=3D"Microsoft Word 11 (filtered medium)">
<!--[if !mso]>
<style>
v\:* {behavior:url(#default#VML);}
o\:* {behavior:url(#default#VML);}
w\:* {behavior:url(#default#VML);}
.shape {behavior:url(#default#VML);}
</style>
<![endif]--><o:SmartTagType
 namespaceuri=3D"urn:schemas-microsoft-com:office:smarttags" name=3D"Postal=
Code"/>
<o:SmartTagType namespaceuri=3D"urn:schemas-microsoft-com:office:smarttags"
 name=3D"State"/>
<o:SmartTagType namespaceuri=3D"urn:schemas-microsoft-com:office:smarttags"
 name=3D"City"/>
<o:SmartTagType namespaceuri=3D"urn:schemas-microsoft-com:office:smarttags"
 name=3D"place"/>
<o:SmartTagType namespaceuri=3D"urn:schemas-microsoft-com:office:smarttags"
 name=3D"Street"/>
<o:SmartTagType namespaceuri=3D"urn:schemas-microsoft-com:office:smarttags"
 name=3D"address"/>
<!--[if !mso]>
<style>
st1\:*{behavior:url(#default#ieooui) }
</style>
<![endif]-->
<style>
<!--
 /* Font Definitions */
 @font-face
	{font-family:Batang;
	panose-1:2 3 6 0 0 1 1 1 1 1;}
@font-face
	{font-family:Tahoma;
	panose-1:2 11 6 4 3 5 4 4 2 4;}
@font-face
	{font-family:"\@Batang";
	panose-1:0 0 0 0 0 0 0 0 0 0;}
 /* Style Definitions */
 p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
	margin-bottom:.0001pt;
	font-size:12.0pt;
	font-family:"Times New Roman";
	color:black;}
a:link, span.MsoHyperlink
	{color:blue;
	text-decoration:underline;}
a:visited, span.MsoHyperlinkFollowed
	{color:purple;
	text-decoration:underline;}
p
	{mso-margin-top-alt:auto;
	margin-right:0in;
	mso-margin-bottom-alt:auto;
	margin-left:0in;
	font-size:12.0pt;
	font-family:"Times New Roman";}
pre
	{margin:0in;
	margin-bottom:.0001pt;
	font-size:10.0pt;
	font-family:"Courier New";
	color:black;}
span.EmailStyle18
	{mso-style-type:personal-reply;
	font-family:Arial;
	color:navy;}
@page Section1
	{size:8.5in 11.0in;
	margin:1.0in 1.25in 1.0in 1.25in;}
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

<body bgcolor=3Dwhite lang=3DEN-US link=3Dblue vlink=3Dpurple>

<div class=3DSection1>

<p class=3DMsoNormal><font size=3D2 color=3Dnavy face=3DArial><span style=
=3D'font-size:
10.0pt;font-family:Arial;color:navy'>The code masking the interrupt in IPIC
(call for</span></font> <font size=3D2 color=3Dnavy face=3DArial><span
style=3D'font-size:10.0pt;font-family:Arial;color:navy'>ipipe_pre_cascade_n=
oeoi())
&nbsp;initially showed up in the patch you recommended (see your email atta=
ched).<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 color=3Dnavy face=3DArial><span style=
=3D'font-size:
10.0pt;font-family:Arial;color:navy'>Later on it was integrated in Xenomai =
commit
&quot;9a5e42df8bccc59620c08caeb4b9fe92dbf94a1b&quot;.<o:p></o:p></span></fo=
nt></p>

<p class=3DMsoNormal><font size=3D2 color=3Dnavy face=3DArial><span style=
=3D'font-size:
10.0pt;font-family:Arial;color:navy'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 color=3Dnavy face=3DArial><span style=
=3D'font-size:
10.0pt;font-family:Arial;color:navy'>As shown in the trail below, it keeps
interrupts all the time until the scheduler returns, thus breaking real-tim=
e
responsiveness.<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 color=3Dnavy face=3DArial><span style=
=3D'font-size:
10.0pt;font-family:Arial;color:navy'>A solution to this is probably to remo=
ve calling
ipipe_pre_cascade_noeoi() and let the cascading handler mask the interrupt.=
 Am
I missing something? Do you think it is safe to use this solution?<o:p></o:=
p></span></font></p>

<p class=3DMsoNormal><font size=3D2 color=3Dnavy face=3DArial><span style=
=3D'font-size:
10.0pt;font-family:Arial;color:navy'><o:p>&nbsp;</o:p></span></font></p>

<div>

<p><font size=3D2 color=3Dnavy face=3DArial><span style=3D'font-size:10.0pt=
;font-family:
Arial;color:navy'>Michael Pustylnik, P.Eng.<br>
Senior Software Engineer<br>
<b><span style=3D'font-weight:bold'>RuggedCom Inc.</span></b><br>
<a href=3D"http://www.ruggedcom.com/"><font color=3Dred><span style=3D'colo=
r:red'>www.ruggedcom.com</span></font></a><br>
<st1:Street w:st=3D"on"><st1:address w:st=3D"on">300&nbsp;Applewood Crescen=
t</st1:address></st1:Street><br>
<st1:place w:st=3D"on"><st1:City w:st=3D"on">Concord</st1:City>, <st1:State=
 w:st=3D"on">Ontario</st1:State>,
 <st1:PostalCode w:st=3D"on">L4K 5C7</st1:PostalCode></st1:place><br>
Tel:&nbsp; (905)482-4523<br>
Fax: (905)856-1995</span></font><font color=3Dnavy><span style=3D'color:nav=
y'><o:p></o:p></span></font></p>

<p><font size=3D3 color=3Dnavy face=3D"Times New Roman"><span style=3D'font=
-size:12.0pt;
color:navy'>&nbsp;</span></font><o:p></o:p></p>

</div>

<div>

<div class=3DMsoNormal align=3Dcenter style=3D'text-align:center'><font siz=
e=3D3
color=3Dblack face=3D"Times New Roman"><span style=3D'font-size:12.0pt;colo=
r:windowtext'>

<hr size=3D2 width=3D"100%" align=3Dcenter tabindex=3D-1>

</span></font></div>

<p class=3DMsoNormal><b><font size=3D2 color=3Dblack face=3DTahoma><span
style=3D'font-size:10.0pt;font-family:Tahoma;color:windowtext;font-weight:b=
old'>From:</span></font></b><font
size=3D2 color=3Dblack face=3DTahoma><span style=3D'font-size:10.0pt;font-f=
amily:Tahoma;
color:windowtext'> xenomai-help-bounces@domain.hid
[mailto:xenomai-help-bounces@domain.hid] <b><span style=3D'font-weight:bold'>O=
n
Behalf Of </span></b>Makarand Pradhan<br>
<b><span style=3D'font-weight:bold'>Sent:</span></b> Wednesday, April 04, 2=
012
12:59 PM<br>
<b><span style=3D'font-weight:bold'>To:</span></b> Philippe Gerum<br>
<b><span style=3D'font-weight:bold'>Cc:</span></b> xenomai@xenomai.org<br>
<b><span style=3D'font-weight:bold'>Subject:</span></b> Re: [Xenomai-help]
Interrupt latency greater than 250ms. Question.</span></font><font color=3D=
black><span
style=3D'color:windowtext'><o:p></o:p></span></font></p>

</div>

<p class=3DMsoNormal><font size=3D3 color=3Dblack face=3D"Times New Roman">=
<span
style=3D'font-size:12.0pt'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal style=3D'mso-margin-top-alt:auto;margin-bottom:12.0pt'=
><font
size=3D3 color=3Dblack face=3D"Times New Roman"><span style=3D'font-size:12=
.0pt'>Hi
Philippe,<br>
<br>
We have found that the problem is that the interrupt is unexpectedly held
masked at the IPIC level for a long time. Please find the trace below:<br>
<br>
&nbsp;2552 :|&nbsp; +
func&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;
-54413&nbsp;&nbsp;&nbsp; 0.590&nbsp; qe_ic_cascade_low_ipic+0x8
(__ipipe_ack_irq+0x2c)<br>
&nbsp;2553 :|&nbsp; +
func&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;
-54412&nbsp;&nbsp;&nbsp; 0.696&nbsp; qe_ic_get_low_irq+0x8
(qe_ic_cascade_low_ipic+0x30)<br>
&nbsp;2554 :|&nbsp; +
func&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;
-54411&nbsp;&nbsp;&nbsp; 0.666&nbsp; irq_linear_revmap+0x8
(qe_ic_get_low_irq+0x5c)<br>
<br>
<b><span style=3D'font-weight:bold'>MASK in IPIC (SIMSR_H register bit 1)</=
span></b><br>
&nbsp;2555 :|&nbsp; +
func&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;
-54411&nbsp;&nbsp;&nbsp; 0.606&nbsp; ipic_mask_irq+0x8
(qe_ic_cascade_low_ipic+0x48)<br>
&nbsp;2556 :|&nbsp; + func&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
-54410&nbsp;&nbsp;&nbsp; 0.590&nbsp; irqd_to_hwirq+0x8 (ipic_mask_irq+0x30)=
<br>
&nbsp;2557 :|&nbsp; +
func&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;
-54410&nbsp;&nbsp;&nbsp; 0.909&nbsp; __ipipe_spin_lock_irqsave+0x8
(ipic_mask_irq+0x40)<br>
&nbsp;2558 :|&nbsp; #
func&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;
-54409&nbsp;&nbsp;&nbsp; 0.727&nbsp; __ipipe_spin_unlock_irqrestore+0x8 (ip=
ic_mask_irq+0xa8&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
)<br>
&nbsp;2559 :|&nbsp; +
func&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;
-54408&nbsp;&nbsp;&nbsp; 0.560&nbsp; __ipipe_qe_ic_cascade_irq+0x8
(qe_ic_cascade_low_ipic+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x5c)&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<br>
&nbsp;2560 :|&nbsp; + begin&nbsp;&nbsp; 0x0000002b -54407&nbsp;&nbsp;&nbsp;
0.530&nbsp; __ipipe_qe_ic_cascade_irq+0x2c
(qe_ic_cascade_low_ipic&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
+0x5c)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; <br>
&nbsp;2561 :|&nbsp; +
func&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;
-54407&nbsp;&nbsp;&nbsp; 0.651&nbsp; __ipipe_handle_irq+0x8
(__ipipe_qe_ic_cascade_irq+0x38&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; )<br>
&nbsp;2562 :|&nbsp; +
func&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;
-54406&nbsp;&nbsp;&nbsp; 0.939&nbsp; __ipipe_ack_level_irq+0x8
(__ipipe_handle_irq+0xbc)<br>
<br>
<b><span style=3D'font-weight:bold'>MASK in QUICC (CIMR register bit 11)</s=
pan></b><br>
&nbsp;2563 :|&nbsp; +
func&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;
-54405&nbsp;&nbsp;&nbsp; 0.787&nbsp; qe_ic_mask_irq+0x8
(__ipipe_ack_level_irq+0x40)<br>
<br>
<b><span style=3D'font-weight:bold'>XENOMAI SCHEDULER IS INVOKED</span></b>=
<br>
&nbsp;2576 :|&nbsp; #
func&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;
-54393&nbsp;&nbsp;&nbsp; 0.590&nbsp; __xnpod_schedule+0x8
(xnintr_irq_handler+0x1f8)<br>
<b><span style=3D'font-weight:bold'><br>
UNMASK in QUICC (done by our user space handler)</span></b><br>
&nbsp;2595 :&nbsp;&nbsp; +
func&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;
-54377&nbsp;&nbsp;&nbsp; 0.621&nbsp; __rt_intr_enable+0x8 [xeno_native]
(hisyscall_event+0x&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1e4)<br>
<br>
<b><span style=3D'font-weight:bold'>UNMASK in IPIC (after 50ms, i.e. only a=
fter
the scheduler returns):</span></b><br>
31637 :|&nbsp;&nbsp; #end&nbsp;&nbsp;&nbsp;&nbsp; 0x0000002b&nbsp;
-518+&nbsp;&nbsp; 2.272&nbsp; __ipipe_qe_ic_cascade_irq+0x40
(qe_ic_cascade_low_ipic+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x5c)<br>
31638 :|&nbsp;&nbsp;
#func&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;
-516+&nbsp;&nbsp; 1.090&nbsp; ipic_unmask_irq+0x8 (qe_ic_cascade_low_ipic+0=
x70)<br>
<br>
<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'mso-margin-top-alt:auto;mso-margin-bottom-alt=
:auto'><font
size=3D3 color=3Dblack face=3D"Times New Roman"><span style=3D'font-size:12=
.0pt'>As you
can see from the trace above, the interrupt is held masked at the IPIC leve=
l
all the time until the Xenomai scheduler returns and is only unmasked after
that.<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'mso-margin-top-alt:auto;mso-margin-bottom-alt=
:auto'><font
size=3D3 color=3Dblack face=3D"Times New Roman"><span style=3D'font-size:12=
.0pt'>Is it
really the way it should be? Shouldn&#8217;t the interrupt be unmasked at t=
he IPIC
level right after masking it at the QUICC engine level?<o:p></o:p></span></=
font></p>

<p class=3DMsoNormal style=3D'mso-margin-top-alt:auto;mso-margin-bottom-alt=
:auto'><font
size=3D3 color=3Dblack face=3D"Times New Roman"><span style=3D'font-size:12=
.0pt'>Rgds,<br>
Mak.<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D3 color=3Dblack face=3D"Times New Roman">=
<span
style=3D'font-size:12.0pt'><br>
<br>
On 28/03/12 02:23 PM, Makarand Pradhan wrote: <o:p></o:p></span></font></p>

<pre wrap=3D""><font size=3D2 color=3Dblack face=3D"Courier New"><span
style=3D'font-size:10.0pt'>Hi Philippe,<o:p></o:p></span></font></pre><pre>=
<font
size=3D2 color=3Dblack face=3D"Courier New"><span style=3D'font-size:10.0pt=
'><o:p>&nbsp;</o:p></span></font></pre><pre><font
size=3D2 color=3Dblack face=3D"Courier New"><span style=3D'font-size:10.0pt=
'>On 28/03/12 12:17 PM, Philippe Gerum wrote:<o:p></o:p></span></font></pre=
>

<blockquote style=3D'margin-top:5.0pt;margin-bottom:5.0pt' type=3Dcite><pre=
 wrap=3D""><font
size=3D2 color=3Dblack face=3D"Courier New"><span style=3D'font-size:10.0pt=
'>The log says your code wants to control when the IRQ is enabled again,<o:=
p></o:p></span></font></pre><pre><font
size=3D2 color=3Dblack face=3D"Courier New"><span style=3D'font-size:10.0pt=
'>by calling rt_intr_enable() from userland. I guess you are setting<o:p></=
o:p></span></font></pre><pre><font
size=3D2 color=3Dblack face=3D"Courier New"><span style=3D'font-size:10.0pt=
'>I_NOAUTOENA too. Correct?<o:p></o:p></span></font></pre></blockquote>

<pre wrap=3D""><font size=3D2 color=3Dblack face=3D"Courier New"><span
style=3D'font-size:10.0pt'><o:p>&nbsp;</o:p></span></font></pre><pre><font
size=3D2 color=3Dblack face=3D"Courier New"><span style=3D'font-size:10.0pt=
'>That is correct. I_NOAUTOENA is used in rt_intr_create. Otherwise the <o:=
p></o:p></span></font></pre><pre><font
size=3D2 color=3Dblack face=3D"Courier New"><span style=3D'font-size:10.0pt=
'>level trigerred interrupt will not allow the userland processing of the <=
o:p></o:p></span></font></pre><pre><font
size=3D2 color=3Dblack face=3D"Courier New"><span style=3D'font-size:10.0pt=
'>int. The userland handler is very small and it unconditionally <o:p></o:p=
></span></font></pre><pre><font
size=3D2 color=3Dblack face=3D"Courier New"><span style=3D'font-size:10.0pt=
'>rt_intr_enables the intr.<o:p></o:p></span></font></pre><pre><font
size=3D2 color=3Dblack face=3D"Courier New"><span style=3D'font-size:10.0pt=
'><o:p>&nbsp;</o:p></span></font></pre><pre><font
size=3D2 color=3Dblack face=3D"Courier New"><span style=3D'font-size:10.0pt=
'>Testing indicates that the interrupt is always enabled from user space <o=
:p></o:p></span></font></pre><pre><font
size=3D2 color=3Dblack face=3D"Courier New"><span style=3D'font-size:10.0pt=
'>within 250 usec after kernel gets the interrupt.<o:p></o:p></span></font>=
</pre><pre><font
size=3D2 color=3Dblack face=3D"Courier New"><span style=3D'font-size:10.0pt=
'><o:p>&nbsp;</o:p></span></font></pre><pre><font
size=3D2 color=3Dblack face=3D"Courier New"><span style=3D'font-size:10.0pt=
'>I have noted that unless I see &quot;#end 0x0000002b&quot; and a hit to t=
he <o:p></o:p></span></font></pre><pre><font
size=3D2 color=3Dblack face=3D"Courier New"><span style=3D'font-size:10.0pt=
'>ipic_unmask_irq, the next interrupt is not processed.<o:p></o:p></span></=
font></pre><pre><font
size=3D2 color=3Dblack face=3D"Courier New"><span style=3D'font-size:10.0pt=
'><o:p>&nbsp;</o:p></span></font></pre><pre><font
size=3D2 color=3Dblack face=3D"Courier New"><span style=3D'font-size:10.0pt=
'>And this is getting delayed once in a while which causes a delay in <o:p>=
</o:p></span></font></pre><pre><font
size=3D2 color=3Dblack face=3D"Courier New"><span style=3D'font-size:10.0pt=
'>processing the next interrupt.<o:p></o:p></span></font></pre><pre><font
size=3D2 color=3Dblack face=3D"Courier New"><span style=3D'font-size:10.0pt=
'><o:p>&nbsp;</o:p></span></font></pre><pre><font
size=3D2 color=3Dblack face=3D"Courier New"><span style=3D'font-size:10.0pt=
'>So the sequence of events leading to the problem is:<o:p></o:p></span></f=
ont></pre><pre><font
size=3D2 color=3Dblack face=3D"Courier New"><span style=3D'font-size:10.0pt=
'><o:p>&nbsp;</o:p></span></font></pre><pre><font
size=3D2 color=3Dblack face=3D"Courier New"><span style=3D'font-size:10.0pt=
'>1. Get interrupt: #begin&nbsp;&nbsp; 0x0000002b noted in ipipe trace<o:p>=
</o:p></span></font></pre><pre><font
size=3D2 color=3Dblack face=3D"Courier New"><span style=3D'font-size:10.0pt=
'>2. Intr enabled from user space. Always happens roughly within 250usec.<o=
:p></o:p></span></font></pre><pre><font
size=3D2 color=3Dblack face=3D"Courier New"><span style=3D'font-size:10.0pt=
'>3. #end 0x0000002b noted in ipipe trace where the int is unmasked by ipip=
e.<o:p></o:p></span></font></pre><pre><font
size=3D2 color=3Dblack face=3D"Courier New"><span style=3D'font-size:10.0pt=
'><o:p>&nbsp;</o:p></span></font></pre><pre><font
size=3D2 color=3Dblack face=3D"Courier New"><span style=3D'font-size:10.0pt=
'>When I see the problem, step 3 is delayed. I am trying to capture a <o:p>=
</o:p></span></font></pre><pre><font
size=3D2 color=3Dblack face=3D"Courier New"><span style=3D'font-size:10.0pt=
'>trace where the begin, int enable and end are captured.<o:p></o:p></span>=
</font></pre><pre><font
size=3D2 color=3Dblack face=3D"Courier New"><span style=3D'font-size:10.0pt=
'><o:p>&nbsp;</o:p></span></font></pre><pre><font
size=3D2 color=3Dblack face=3D"Courier New"><span style=3D'font-size:10.0pt=
'>Your thoughts on what might cause this delay would be appreciated.<o:p></=
o:p></span></font></pre><pre><font
size=3D2 color=3Dblack face=3D"Courier New"><span style=3D'font-size:10.0pt=
'><o:p>&nbsp;</o:p></span></font></pre><pre><font
size=3D2 color=3Dblack face=3D"Courier New"><span style=3D'font-size:10.0pt=
'>Rgds,<o:p></o:p></span></font></pre><pre><font
size=3D2 color=3Dblack face=3D"Courier New"><span style=3D'font-size:10.0pt=
'>Mak.<o:p></o:p></span></font></pre><pre><font
size=3D2 color=3Dblack face=3D"Courier New"><span style=3D'font-size:10.0pt=
'><o:p>&nbsp;</o:p></span></font></pre><pre><font
size=3D2 color=3Dblack face=3D"Courier New"><span style=3D'font-size:10.0pt=
'><o:p>&nbsp;</o:p></span></font></pre><pre><font
size=3D2 color=3Dblack face=3D"Courier New"><span style=3D'font-size:10.0pt=
'><o:p>&nbsp;</o:p></span></font></pre><pre><font
size=3D2 color=3Dblack face=3D"Courier New"><span style=3D'font-size:10.0pt=
'><o:p>&nbsp;</o:p></span></font></pre><pre><font
size=3D2 color=3Dblack face=3D"Courier New"><span style=3D'font-size:10.0pt=
'><o:p>&nbsp;</o:p></span></font></pre>

<p class=3DMsoNormal><font size=3D3 color=3Dblack face=3D"Times New Roman">=
<span
style=3D'font-size:12.0pt'><br>
<br>
<br>
<o:p></o:p></span></font></p>

<pre><font size=3D2 color=3Dblack face=3D"Courier New"><span style=3D'font-=
size:10.0pt'>-- <o:p></o:p></span></font></pre><pre><font
size=3D2 color=3Dblack face=3D"Courier New"><span style=3D'font-size:10.0pt=
'>_________________________________________________________________________=
__<o:p></o:p></span></font></pre><pre><font
size=3D2 color=3Dblack face=3D"Courier New"><span style=3D'font-size:10.0pt=
'>NOTICE OF CONFIDENTIALITY:<o:p></o:p></span></font></pre><pre><font
size=3D2 color=3Dblack face=3D"Courier New"><span style=3D'font-size:10.0pt=
'>This e-mail and any attachments may contain confidential and privileged i=
nformation. &nbsp;If you are<o:p></o:p></span></font></pre><pre><font
size=3D2 color=3Dblack face=3D"Courier New"><span style=3D'font-size:10.0pt=
'>not the intended recipient, please notify the sender immediately by retur=
n e-mail and delete this<o:p></o:p></span></font></pre><pre><font
size=3D2 color=3Dblack face=3D"Courier New"><span style=3D'font-size:10.0pt=
'>e-mail and any copies.&nbsp; Any dissemination or use of this information=
 by a person other than the<o:p></o:p></span></font></pre><pre><font
size=3D2 color=3Dblack face=3D"Courier New"><span style=3D'font-size:10.0pt=
'>intended recipient is unauthorized and may be illegal.<o:p></o:p></span><=
/font></pre><pre><font
size=3D2 color=3Dblack face=3D"Courier New"><span style=3D'font-size:10.0pt=
'>_____________________________________________________________________<o:p=
></o:p></span></font></pre><pre><font
size=3D2 color=3Dblack face=3D"Courier New"><span style=3D'font-size:10.0pt=
'><o:p>&nbsp;</o:p></span></font></pre><pre><font
size=3D2 color=3Dblack face=3D"Courier New"><span style=3D'font-size:10.0pt=
'> <o:p></o:p></span></font></pre></div>

</body>

</html>
<P><FONT SIZE=3D2 FACE=3D"Arial">No virus found in this incoming message.<B=
R>
Checked by AVG - www.avg.com<BR>
Version: 8.5.455 / Virus Database: 271.1.1/4175 - Release Date: 04/03/12 18=
:35:00<BR>
</FONT></P>

<P><FONT SIZE=3D2 FACE=3D"Arial"> </FONT> </P>=

--_000_990B36E792F1A4488D3E2B1C46FD62D692DDD85791corpmail2_--

--_004_990B36E792F1A4488D3E2B1C46FD62D692DDD85791corpmail2_
Content-Type: message/rfc822

Received: from spam1.ruggedcom.com (204.50.148.10) by
 corpmail2.ruggedcom.local (10.200.2.21) with Microsoft SMTP Server id
 8.2.176.0; Thu, 12 Apr 2012 10:57:37 -0400
Received: from caffeine.csclub.uwaterloo.ca (caffeine.csclub.uwaterloo.ca
 [129.97.134.17]) by spam1.ruggedcom.com with ESMTP id 8XR6gJukfnIcTLOJ for
 <MichaelPustylnik@domain.hid>; Thu, 12 Apr 2012 11:26:17 -0400 (EDT)
Received: by caffeine.csclub.uwaterloo.ca (Postfix, from userid 20367)	id
 8C9E45A2B; Thu, 12 Apr 2012 10:57:36 -0400 (EDT)
Received: from xenomai.org (xenomai.org [88.191.95.136])	by
 caffeine.csclub.uwaterloo.ca (Postfix) with ESMTPS id 7A3451DABF	for
 <lsorense@domain.hid>; Thu,  3 Nov 2011 11:38:55 -0400 (EDT)
Received: from lgp44-6-88-185-217-115.fbx.proxad.net ([88.185.217.115]
 helo=[192.168.0.8])	by xenomai.org with esmtpsa
 (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)	(Exim 4.69)	(envelope-from
 <rpm@xenomai.org>)	id 1RLzNV-0007sa-Rx; Thu, 03 Nov 2011 16:38:54 +0100
From: Philippe Gerum <rpm@xenomai.org>
To: Lennart Sorensen <lsorense@domain.hid>
CC: "adeos-main@gna.org" <adeos-main@gna.org>
Date: Thu, 3 Nov 2011 11:38:55 -0400
Subject: Re: [Adeos-main] irq related kernel crash with adeos 3.0.4 powerpc.
Thread-Topic: [Adeos-main] irq related kernel crash with adeos 3.0.4 powerpc.
Thread-Index: Ac0YvJn3NQD3GqqPTnWgRphZ0Cvrpg==
Message-ID: <4EB2B58F.3070600@domain.hid>
References: <20111102201210.GY30117@domain.hid>
	<4EB1B691.9020801@domain.hid>
 <20111103151353.GB30117@domain.hid>
In-Reply-To: <20111103151353.GB30117@domain.hid>
X-MS-Exchange-Organization-AuthAs: Anonymous
X-MS-Exchange-Organization-AuthSource: RCexchangeSVR1.ruggedcom.local
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.23)
 Gecko/20110922 Thunderbird/3.1.15
x-barracuda-envelope-from: lsorense@domain.hid
x-barracuda-connect: caffeine.csclub.uwaterloo.ca[129.97.134.17]
x-barracuda-url: http://spamd.ruggedcom.com:8000/cgi-mod/mark.cgi
x-barracuda-start-time: 1334244377
x-asg-orig-subj: Re: [Adeos-main] irq related kernel crash with adeos 3.0.4
 powerpc.
x-barracuda-spam-report: Code version 3.2, rules version 3.2.2.93914	Rule
 breakdown below	 pts rule name              description	----
 ---------------------- --------------------------------------------------
x-barracuda-spam-status: No, SCORE=0.00 using per-user scores of
 TAG_LEVEL=1000.0 QUARANTINE_LEVEL=4.0 KILL_LEVEL=5.0 tests=
x-barracuda-spam-score: 0.00
x-asg-debug-id: 1334244377-02eb9c15c3977010001-OF1NVq
x-virus-scanned: by bsmtpd at ruggedcom.com
x-original-to: lsorense@domain.hid
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0

On 11/03/2011 04:13 PM, Lennart Sorensen wrote:
> On Wed, Nov 02, 2011 at 10:30:57PM +0100, Philippe Gerum wrote:
>> Does this help? If not, then your .config would be welcome.
>>
>> diff --git a/arch/powerpc/sysdev/qe_lib/qe_ic.c b/arch/powerpc/sysdev/qe=
_lib/qe_ic.c
>> index 707d297..c1e0b7e 100644
>> --- a/arch/powerpc/sysdev/qe_lib/qe_ic.c
>> +++ b/arch/powerpc/sysdev/qe_lib/qe_ic.c
>> @@ -257,6 +257,9 @@ static struct irq_chip qe_ic_irq_chip =3D {
>>   	.irq_unmask =3D qe_ic_unmask_irq,
>>   	.irq_mask =3D qe_ic_mask_irq,
>>   	.irq_mask_ack =3D qe_ic_mask_irq,
>> +#ifdef CONFIG_IPIPE
>> +	.irq_eoi =3D qe_ic_mask_irq,
>> +#endif
>>   };
>>
>>   static int qe_ic_host_match(struct irq_host *h, struct device_node *no=
de)
>=20
> No, that unfortunately didn't help.
>=20
> So here is the capture of the entire boot, and the .config file I am usin=
g.
>=20

Thanks. Meanwhile you may want to try this one. This is aimed at fixing an =
issue with acking
cascaded IPIC irqs over the pipeline.

http://download.gna.org/adeos/patches/v3.x/powerpc/adeos-ipipe-3.0.8-powerp=
c-2.13-04.patch

>=20
>=20
>=20
> _______________________________________________
> Adeos-main mailing list
> Adeos-main@domain.hid
> https://mail.gna.org/listinfo/adeos-main


--=20
Philippe.

No virus found in this incoming message.
Checked by AVG - www.avg.com=20
Version: 8.5.455 / Virus Database: 271.1.1/4327 - Release Date: 04/10/12 19=
:55:00

--_004_990B36E792F1A4488D3E2B1C46FD62D692DDD85791corpmail2_--

