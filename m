From: "Charlton, John" <john.charlton@domain.hid>
Date: Mon, 21 Jun 2010 10:52:37 -0400
Message-ID: <CF7FB0793253794F9F45991443E5FE200935FF897B@us194mx002.tycoelectronics.net>
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_CF7FB0793253794F9F45991443E5FE200935FF897Bus194mx002tyc_"
MIME-Version: 1.0
Subject: [Xenomai-help] rt_dev_send() does not timeout
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: "'xenomai@xenomai.org'" <xenomai@xenomai.org>

--_000_CF7FB0793253794F9F45991443E5FE200935FF897Bus194mx002tyc_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

We are experiencing a problem with the user mode CanFestival library when i=
t calls rt_dev_send() when the CAN bus is disconnected.  In that case the r=
tcan driver info is:

root@domain.hid:~# cat /proc/rtcan/rtcan0/info
Device     rtcan0
Controller SJA1000
Board      PEAK-PCI
Clock-Hz   8000000
Baudrate   1000000
Bit-time   brp=3D1 prop_seg=3D0 phase_seg1=3D5 phase_seg2=3D2 sjw=3D1 sam=
=3D0
Ctrl-Mode
State      passive
TX-Counter 1
RX-Counter 0
Errors     2
Refcount   3
root@domain.hid:~#

The rt_dev_send() function hangs and does not timeout or return an error an=
d never returns. We are using Xenomai 2.5.2 with linux 2.6.32.7.

John


--_000_CF7FB0793253794F9F45991443E5FE200935FF897Bus194mx002tyc_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<meta name=3D"Generator" content=3D"Microsoft Exchange Server">
<!-- converted from rtf -->
<style><!-- .EmailQuote { margin-left: 1pt; padding-left: 4pt; border-left:=
 #800000 2px solid; } --></style>
</head>
<body>
<font face=3D"Arial, sans-serif" size=3D"2">
<div>We are experiencing a problem with the user mode CanFestival library w=
hen it calls rt_dev_send() when the CAN bus is disconnected.&nbsp; In that =
case the rtcan driver info is:</div>
<div>&nbsp;</div>
<div><font face=3D"Courier New, monospace">root@domain.hid:~# cat /proc/rtca=
n/rtcan0/info</font></div>
<div><font face=3D"Courier New, monospace">Device&nbsp;&nbsp;&nbsp;&nbsp; r=
tcan0</font></div>
<div><font face=3D"Courier New, monospace">Controller SJA1000</font></div>
<div><font face=3D"Courier New, monospace">Board&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; PEAK-PCI</font></div>
<div><font face=3D"Courier New, monospace">Clock-Hz&nbsp;&nbsp; 8000000</fo=
nt></div>
<div><font face=3D"Courier New, monospace">Baudrate&nbsp;&nbsp; 1000000</fo=
nt></div>
<div><font face=3D"Courier New, monospace">Bit-time&nbsp;&nbsp; brp=3D1 pro=
p_seg=3D0 phase_seg1=3D5 phase_seg2=3D2 sjw=3D1 sam=3D0</font></div>
<div><font face=3D"Courier New, monospace">Ctrl-Mode</font></div>
<div><font face=3D"Courier New, monospace">State&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; passive</font></div>
<div><font face=3D"Courier New, monospace">TX-Counter 1</font></div>
<div><font face=3D"Courier New, monospace">RX-Counter 0</font></div>
<div><font face=3D"Courier New, monospace">Errors&nbsp;&nbsp;&nbsp;&nbsp; 2=
</font></div>
<div><font face=3D"Courier New, monospace">Refcount&nbsp;&nbsp; 3</font></d=
iv>
<div><font face=3D"Courier New, monospace">root@domain.hid:~#</font></div>
<div><font face=3D"Courier New, monospace">&nbsp;</font></div>
<div>The rt_dev_send() function hangs and does not timeout or return an err=
or and never returns. We are using Xenomai 2.5.2 with linux 2.6.32.7.</div>
<div>&nbsp;</div>
<div>John</div>
<div>&nbsp;</div>
</font>
</body>
</html>

--_000_CF7FB0793253794F9F45991443E5FE200935FF897Bus194mx002tyc_--

