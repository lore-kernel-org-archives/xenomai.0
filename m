From: "Ivan Kalatchev" <ivan.kalatchev@domain.hid>
Date: Mon, 11 Jan 2010 17:04:35 -0500
Message-ID: <001101ca930a$1052fa70$30f8ef50$@kalatchev@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_NextPart_000_0012_01CA92E0.277CF270"
Content-Language: en-ca
Subject: [Xenomai-help] Viper board (ARM XScale) problems with Xenomai-2.4.10
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Xenomai-help@domain.hid

This is a multi-part message in MIME format.

------=_NextPart_000_0012_01CA92E0.277CF270
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi,

 

I was trying to upgrade my application running on Viper (2.6.16.28 kernel
with xenomai 2.3.1)  to 

kernel 2.6.30.10 with xenomai 2.4.10 and ran into couple of problems.

 

1. My application uses real-time hook to CPLD interrupt, which is chained
interrupt.

   In Xenomai 2.4.10 for some reason general purpose interrupt handler for
chained interrupt is assigned  to I-pipe  acknowledgment handler during
board initialization:

 

in kernel/irq/chip.c:  

 

_set_irq_hanler(...

 

#ifdef CONFIG_IPIPE

               else if (is_chained) {

               desc->ipipe_ack = handle;

               desc->ipipe_end = &__ipipe_noend_irq;

               handle = &__ipipe_noack_irq;

#endif    

 

As a result, when CPLD interrupt happened, general purpose interrupt from
Linux domain is executed as part of ipipe interrupt acknowledgment. After
that my real-time interrupt handler gets executed. This is not normal, as my
handler supposed to replace general purpose handler, which should not be
executed at all, unless I want it to be executed.  I  fixed this problem by
reassigning ipipe acknowledgment to __ipipe_ack_edge_irq, and not changing
handler at all, and it worked in my case. But this probably can break some
other code.

 

2. USB on Viepr is not working with I-pipe.  

 

I found the cause of this problem. Again for some reason, I-pipe patch
changes type of the USB and all other multiplexed interrupts from edge to
level interrupt, which they are in original Linux kernel. Of course, this
breaks everything. I fixed USB by changing back interrupts type from level
to edge in arch/arm/plat-pxa/gpio.c:

 

void __intit pxa_init_gpio(

               instead of 

#ifndef CONFIG_IPIPE

               set_irq_handler(irq,handle_edge_irq);

#else

               set_irq_handler(irq,handle_level_irq);

#endif

 

I'm using just 

               set_irq_handler(irq,handle_edge_irq);

, as it was in original Linux code and everything works fine.

 

Shouldn't changes to interrupt code in Xenomai depend on particular board
and not be part of the common code? 

 

I would appreciate any response regarding these issues.

 

Regards,

 

Ivan

 


------=_NextPart_000_0012_01CA92E0.277CF270
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
	margin:72.0pt 72.0pt 72.0pt 72.0pt;}
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

<body lang=3DEN-CA link=3Dblue vlink=3Dpurple>

<div class=3DSection1>

<p class=3DMsoNormal>Hi,<o:p></o:p></p>

<p class=3DMsoNormal>&nbsp;<o:p></o:p></p>

<p class=3DMsoNormal>I was trying to upgrade my application running on =
Viper
(2.6.16.28 kernel with xenomai 2.3.1)&nbsp; to <o:p></o:p></p>

<p class=3DMsoNormal>kernel 2.6.30.10 with xenomai 2.4.10 and ran into =
couple of
problems.<o:p></o:p></p>

<p class=3DMsoNormal><o:p>&nbsp;</o:p></p>

<p class=3DMsoNormal>1. My application uses real-time hook to CPLD =
interrupt, which
is chained interrupt.<o:p></o:p></p>

<p class=3DMsoNormal>&nbsp;&nbsp; In Xenomai 2.4.10 for some reason =
general
purpose interrupt handler for chained interrupt is assigned &nbsp;to =
I-pipe
&nbsp;acknowledgment handler during board initialization:<o:p></o:p></p>

<p class=3DMsoNormal><o:p>&nbsp;</o:p></p>

<p class=3DMsoNormal>in kernel/irq/chip.c:&nbsp; <o:p></o:p></p>

<p class=3DMsoNormal><o:p>&nbsp;</o:p></p>

<p class=3DMsoNormal>_<i>set_irq</i>_hanler(...<o:p></o:p></p>

<p class=3DMsoNormal><o:p>&nbsp;</o:p></p>

<p class=3DMsoNormal>#ifdef CONFIG_IPIPE<o:p></o:p></p>

<p =
class=3DMsoNormal>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
else if (is_chained) {<o:p></o:p></p>

<p =
class=3DMsoNormal>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
desc-&gt;ipipe_ack =3D handle;<o:p></o:p></p>

<p =
class=3DMsoNormal>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
desc-&gt;ipipe_end =3D &amp;__ipipe_noend_irq;<o:p></o:p></p>

<p =
class=3DMsoNormal>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
handle =3D &amp;__ipipe_noack_irq;<o:p></o:p></p>

<p class=3DMsoNormal>#endif&nbsp;&nbsp;&nbsp; <o:p></o:p></p>

<p class=3DMsoNormal><o:p>&nbsp;</o:p></p>

<p class=3DMsoNormal>As a result, when CPLD interrupt happened, general =
purpose
interrupt from Linux domain is executed as part of ipipe interrupt =
acknowledgment.
After that my real-time interrupt handler gets executed. This is not =
normal, as
my handler supposed to replace general purpose handler, which should not =
be
executed at all, unless I want it to be executed. &nbsp;I&nbsp; fixed =
this
problem by reassigning ipipe acknowledgment to __ipipe_ack_edge_irq, and =
not
changing handler at all, and it worked in my case. But this probably can =
break
some other code.<o:p></o:p></p>

<p class=3DMsoNormal><o:p>&nbsp;</o:p></p>

<p class=3DMsoNormal>2. USB on Viepr is not working with I-pipe. =
&nbsp;<o:p></o:p></p>

<p class=3DMsoNormal><o:p>&nbsp;</o:p></p>

<p class=3DMsoNormal>I found the cause of this problem. Again for some =
reason,
I-pipe patch changes type of the USB and all other multiplexed =
interrupts from
edge to level interrupt, which they are in original Linux kernel. Of =
course,
this breaks everything. I fixed USB by changing back interrupts type =
from level
to edge in arch/arm/plat-pxa/gpio.c:<o:p></o:p></p>

<p class=3DMsoNormal><o:p>&nbsp;</o:p></p>

<p class=3DMsoNormal>void __intit pxa_init_gpio(<o:p></o:p></p>

<p =
class=3DMsoNormal>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp; instead
of <o:p></o:p></p>

<p class=3DMsoNormal>#ifndef CONFIG_IPIPE<o:p></o:p></p>

<p =
class=3DMsoNormal>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
set_irq_handler(irq,handle_edge_irq);<o:p></o:p></p>

<p class=3DMsoNormal>#else<o:p></o:p></p>

<p =
class=3DMsoNormal>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
set_irq_handler(irq,handle_level_irq);<o:p></o:p></p>

<p class=3DMsoNormal>#endif<o:p></o:p></p>

<p class=3DMsoNormal><o:p>&nbsp;</o:p></p>

<p class=3DMsoNormal>I'm using just <o:p></o:p></p>

<p =
class=3DMsoNormal>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
set_irq_handler(irq,handle_edge_irq);<o:p></o:p></p>

<p class=3DMsoNormal>, as it was in original Linux code and everything =
works
fine.<o:p></o:p></p>

<p class=3DMsoNormal><o:p>&nbsp;</o:p></p>

<p class=3DMsoNormal>Shouldn't changes to interrupt code in Xenomai =
depend on particular
board and not be part of the common code? <o:p></o:p></p>

<p class=3DMsoNormal><o:p>&nbsp;</o:p></p>

<p class=3DMsoNormal>I would appreciate any response regarding these =
issues.<o:p></o:p></p>

<p class=3DMsoNormal><o:p>&nbsp;</o:p></p>

<p class=3DMsoNormal>Regards,<o:p></o:p></p>

<p class=3DMsoNormal><o:p>&nbsp;</o:p></p>

<p class=3DMsoNormal>Ivan<o:p></o:p></p>

<p class=3DMsoNormal><o:p>&nbsp;</o:p></p>

</div>

</body>

</html>

------=_NextPart_000_0012_01CA92E0.277CF270--


