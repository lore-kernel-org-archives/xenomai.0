Message-ID: <4B06912C.8020607@domain.hid>
Date: Fri, 20 Nov 2009 13:53:00 +0100
From: Benjamin Biegel <biegel@domain.hid>
MIME-Version: 1.0
References: <4B068626.8060000@domain.hid> <4B068939.9060405@domain.hid>
In-Reply-To: <4B068939.9060405@domain.hid>
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] I can send -but how to receive using
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
  <meta content="text/html;charset=ISO-8859-1" http-equiv="Content-Type">
</head>
<body bgcolor="#ffffff" text="#000000">
Originally we had one nomac PC on a TDMA network, which did only work
from the nomac-PC to TDMA-PC. After your post we tried using two PCs
with both nomac - which works. This is what we need, so thanks!<br>
<br>
Benjamin<br>
<br>
<br>
Jan Kiszka wrote:
<blockquote cite="mid:4B068939.9060405@domain.hid" type="cite">
  <pre wrap="">Benjamin Biegel wrote:
  </pre>
  <blockquote type="cite">
    <pre wrap="">Hello

I have inserted the modules rtnet, rtipv4, rtpacket, rt_eepro100, rtcfg, 
rtmac and nomac.

But after setting up vnic0 i can only send packets (this works) but not 
receive any.

I use
rtifconfig rteth0 up IP MASK promisc
nomaccfg rteth0 attach
ifconfig vnic 0 up IP MASK

    </pre>
  </blockquote>
  <pre wrap=""><!---->
Did you set up a peer box with nomac as well - or who is supposed to
send you packets? If so, does sending&amp;receiving work for rteth0 itself
(e.g. rtping)?

Jan

  </pre>
</blockquote>
<br>
</body>
</html>

