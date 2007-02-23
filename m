Message-Id: <s5df0e39.037@domain.hid>
Date: Fri, 23 Feb 2007 15:55:35 +0100
From: "Nicolas BLANCHARD" <n.blanchard@domain.hid>
Subject: Re: [Xenomai-core] rtdm, rtc and printk driver.
Mime-Version: 1.0
Content-Type: multipart/alternative; boundary="=__Part85A11277.0__="
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai@xenomai.org, jan.kiszka@domain.hid

--=__Part85A11277.0__=
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit


>>>> Jan Kiszka <jan.kiszka@domain.hid> 23.02 14:47 >>>
>Nicolas BLANCHARD wrote:
>> Hello,
>>  
>> I've write a little rtdm driver to r/w RealTimeClock on rtc146818
>> chipset.
>
>/me not having done much with rtc (hmm, a lot of years back on PCs, I
>think): can this chip be found in normal PC hardware? Or is it only
on
>specific embedded boards? (Means: can I actually play with your
driver? :) )
 
Motorola 146818 circuit is a 6800 peripheral CMOS device,
it's often used with processors 6800 and 8085.
I think it's used on a lot of x86 board.
 
>
>> I also use this driver to write kernel message from user-space
>> (printk).
>>  
>> In attachment you can find an archive with the driver and an example
of
>> use (just code).
>> to compil, you must change kernel sources directory
(KERNELSOURCEDIR
>> flag).
>>  
>> It Based on code of Jan Kiszka found in http://www.captain.at/ 
>>  
>> I hope it could be interesting.
>> All feedback are welcome.
>>  
>
>You will get it. Thanks for sharing your code!
>
>Jan
 
Nicolas Blanchard


--=__Part85A11277.0__=
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Description: HTML

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD>
<META http-equiv=3DContent-Type content=3D"text/html; charset=3Diso-8859-1"=
>
<META content=3D"MSHTML 6.00.2900.2180" name=3DGENERATOR></HEAD>
<BODY style=3D"MARGIN: 4px 4px 1px; FONT: 10pt Tahoma"><BR>&gt;&gt;&gt;&gt;=
 Jan=20
Kiszka &lt;jan.kiszka@domain.hid&gt; 23.02 14:47 &gt;&gt;&gt;<BR>
<DIV>&gt;Nicolas BLANCHARD wrote:<BR>&gt;&gt; Hello,<BR>&gt;&gt;&nbsp;=20
<BR>&gt;&gt; I've write a little rtdm driver to r/w RealTimeClock on=20
rtc146818<BR>&gt;&gt; chipset.<BR>&gt;<BR>&gt;/me not having done much =
with rtc=20
(hmm, a lot of years back on PCs, I<BR>&gt;think): can this chip be found =
in=20
normal PC hardware? Or is it only on<BR>&gt;specific embedded boards? =
(Means:=20
can I actually play with your driver? :) )</DIV>
<DIV>&nbsp;</DIV>
<DIV>Motorola 146818 circuit is a 6800 peripheral CMOS device,</DIV>
<DIV>it's often used with processors 6800 and 8085.</DIV>
<DIV>I think it's used on a lot of x86 board.</DIV>
<DIV>&nbsp;</DIV>
<DIV>&gt;<BR>&gt;&gt; I also use this driver to write kernel message =
from=20
user-space<BR>&gt;&gt; (printk).<BR>&gt;&gt;&nbsp; <BR>&gt;&gt; In =
attachment=20
you can find an archive with the driver and an example of<BR>&gt;&gt; use =
(just=20
code).<BR>&gt;&gt; to compil, you must change kernel sources directory=20
(KERNELSOURCEDIR<BR>&gt;&gt; flag).<BR>&gt;&gt;&nbsp; <BR>&gt;&gt; It =
Based on=20
code of Jan Kiszka found in <A=20
href=3D"http://www.captain.at/">http://www.captain.at/</A><BR>&gt;&gt;&nbsp=
;=20
<BR>&gt;&gt; I hope it could be interesting.<BR>&gt;&gt; All feedback =
are=20
welcome.<BR>&gt;&gt;&nbsp; <BR>&gt;<BR>&gt;You will get it. Thanks for =
sharing=20
your code!<BR>&gt;<BR>&gt;Jan</DIV>
<DIV>&nbsp;</DIV>
<DIV>Nicolas Blanchard<BR></DIV></BODY></HTML>

--=__Part85A11277.0__=--

