Message-Id: <s5def92b.000@domain.hid>
Date: Fri, 23 Feb 2007 14:26:14 +0100
From: "Nicolas BLANCHARD" <n.blanchard@domain.hid>
Subject: [Xenomai-core] rtdm, rtc and printk driver.
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=__Part7E5AE866.0__="
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai@xenomai.org

--=__Part7E5AE866.0__=
Content-Type: multipart/alternative; boundary="=__Part7E5AE866.1__="

--=__Part7E5AE866.1__=
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hello,
 
I've write a little rtdm driver to r/w RealTimeClock on rtc146818
chipset.
I also use this driver to write kernel message from user-space
(printk).
 
In attachment you can find an archive with the driver and an example of
use (just code).
to compil, you must change kernel sources directory (KERNELSOURCEDIR
flag).
 
It Based on code of Jan Kiszka found in http://www.captain.at/
 
I hope it could be interesting.
All feedback are welcome.
 
(linux 2.6.19.2, xeno 2.3, hal 1.6-03)
 
blanchard nicolas 

--=__Part7E5AE866.1__=
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Description: HTML

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD>
<META http-equiv=3DContent-Type content=3D"text/html; charset=3Diso-8859-1"=
>
<META content=3D"MSHTML 6.00.2900.2180" name=3DGENERATOR></HEAD>
<BODY style=3D"MARGIN: 4px 4px 1px; FONT: 10pt Tahoma">
<DIV>Hello,</DIV>
<DIV>&nbsp;</DIV>
<DIV>I've write a little rtdm driver to r/w RealTimeClock on rtc146818=20
chipset.</DIV>
<DIV>I also use this driver to write kernel message from user-space=20
(printk).</DIV>
<DIV>&nbsp;</DIV>
<DIV>In attachment you can find an archive with the driver and an example =
of=20
use&nbsp;(just code).</DIV>
<DIV>to compil, you must change kernel sources directory (KERNELSOURCEDIR=
=20
flag).</DIV>
<DIV>&nbsp;</DIV>
<DIV>It Based on code of Jan Kiszka found in <A=20
href=3D"http://www.captain.at/">http://www.captain.at/</A></DIV>
<DIV>&nbsp;</DIV>
<DIV>I hope it could be interesting.</DIV>
<DIV>All feedback are welcome.</DIV>
<DIV>&nbsp;</DIV>
<DIV>(linux 2.6.19.2, xeno 2.3, hal 1.6-03)</DIV>
<DIV>&nbsp;</DIV>
<DIV>blanchard nicolas&nbsp;</DIV></BODY></HTML>

--=__Part7E5AE866.1__=--

--=__Part7E5AE866.0__=
Content-Type: application/octet-stream; name="rtc146818.tar.gz"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="rtc146818.tar.gz"

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
vwHb4QhUAFAAAA==

--=__Part7E5AE866.0__=--

