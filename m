In-Reply-To: <4A028D87.1000808@domain.hid>
Message-ID: <OF1C549C14.3B0140AE-ONC12575AF.0029BD65-C12575AF.002BAE78@domain.hid>
From: henning.richter@domain.hid
Date: Thu, 7 May 2009 09:57:07 +0200
MIME-Version: 1.0
Content-type: multipart/alternative; 
	Boundary="0__=4EBBFF3CDFBA3BF58f9e8a93df938690918c4EBBFF3CDFBA3BF5"
Content-Disposition: inline
Subject: Re: [Xenomai-help] gatekeeper/0
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

--0__=4EBBFF3CDFBA3BF58f9e8a93df938690918c4EBBFF3CDFBA3BF5
Content-type: text/plain; charset=US-ASCII


I'm running in graphical mode (Kubuntu 8.10 with Kde4).
Now it freezes while 'cat /proc/xenomai/sched'
The Scroll/Lock -LED and the Caps-Lock-Led were flashing.

cat /proc/xenomai/irq         (while running my rt task)
IRQ   CPU0
6:    19144 rt_eepro_100
230:  0     [IPI]
233:  68798 [timer]
234:  0     [critical sync]
258:  83    [virtual]

cat /proc/interrupts          (while running my rt task)
      CPU0
0:    40    XT-PIC-XT   timer
1:    411   XT-PIC-XT   i8042
2:    0     XT-PIC-XT   cascade
3:    2     XT-PIC-XT
4:    2     XT-PIC-XT
5:    54863 XT-PIC-XT   uhci_hcd:usb2, i915@domain.hid, eth3
6:    140   XT-PIC-XT
7:    6380  XT-PIC-XT   ehci_hcd:usb1
8:    2     XT-PIC-XT   rtc0
9:    20    XT-PIC-XT   acpi
10:   2     XT-PIC-XT
11:   2     XT-PIC-XT
12:   4403  XT-PIC-XT   i8042
14:   9713  XT-PIC-XT   ata_piix
15:   27142 XT-PIC-XT   uhci_hcd:usb3, ata_piix, eth1, eth2
NMI:  0     Non-maskable interrupts
LOC:  61661 Local timer interrupts
RES:  0     Rescheduling interrupts
CAL:  0     function call interrupts
TLB:  0     TLB shootdowns
SPU   0     Spurious interrupts
ERR:  0
MIS:  0


A few seconds after i gathered this information the system freezes again.
The .config is the same as yesterday with one change -> ACPI is now enabled
and the
ACPI_PROCESSOR disabled.
I now try to gather more information via netconsole.


Henning




henning.richter@domain.hid wrote:
> Now I'm using xenomai 2.4.7 on kernel 2.6.27.19.
>
> The sigxcpu example from xenomai is now working correctly.
>
> After removing some outputs there are no more modeswitches in my task,
> apart from some debugging output while initilization.
>
> But now my system is no longer stable. It freezes.

Show us /proc/interrupts, /proc/xenomai/irq, your .config if it changed.

What kind of freeze is this? Do you run in graphical or in text mode? If
in graphical mode, try and get the console output using serial console
or netconsole.

Does the system restart when you hit the keyboard?

Does the system freeze when using the latency test alone? Same question
with switchtest?

--
                                                 Gilles.

--0__=4EBBFF3CDFBA3BF58f9e8a93df938690918c4EBBFF3CDFBA3BF5
Content-type: text/html; charset=US-ASCII
Content-Disposition: inline

<html><body>
<p><font face="Arial">I'm running in graphical mode (Kubuntu 8.10 with Kde4).</font><br>
<font face="Arial">Now it freezes while 'cat /proc/xenomai/sched'</font><br>
The Scroll/Lock -LED and the Caps-Lock-Led were flashing.<br>
<br>
cat /proc/xenomai/irq		(while running my rt task)<br>
IRQ	CPU0<br>
6:	19144	rt_eepro_100<br>
230:	0	[IPI]<br>
233:	68798	[timer]<br>
234:	0	[critical sync]<br>
258:	83	[virtual]<br>
<br>
cat /proc/interrupts		(while running my rt task)<br>
	CPU0<br>
0:	40	XT-PIC-XT	timer<br>
1:	411	XT-PIC-XT	i8042<br>
2:	0	XT-PIC-XT	cascade<br>
3:	2	XT-PIC-XT<br>
4:	2	XT-PIC-XT<br>
5:	54863	XT-PIC-XT	uhci_hcd:usb2, i915@domain.hid, eth3<br>
6:	140	XT-PIC-XT<br>
7:	6380	XT-PIC-XT	ehci_hcd:usb1<br>
8:	2	XT-PIC-XT	rtc0<br>
9:	20	XT-PIC-XT	acpi<br>
10:	2	XT-PIC-XT<br>
11:	2	XT-PIC-XT<br>
12:	4403	XT-PIC-XT	i8042<br>
14:	9713	XT-PIC-XT	ata_piix<br>
15:	27142	XT-PIC-XT	uhci_hcd:usb3, ata_piix, eth1, eth2<br>
NMI:	0	Non-maskable interrupts<br>
LOC:	61661	Local timer interrupts<br>
RES:	0	Rescheduling interrupts<br>
CAL:	0	function call interrupts<br>
TLB:	0	TLB shootdowns<br>
SPU	0	Spurious interrupts<br>
ERR:	0<br>
MIS:	0<br>
<br>
<br>
A few seconds after i gathered this information the system freezes again.<br>
The .config is the same as yesterday with one change -&gt; ACPI is now enabled and the<br>
ACPI_PROCESSOR disabled.<br>
I now try to gather more information via netconsole.<br>
<br>
<br>
Henning<br>
<br>
<br>
<br>
<br>
<tt>henning.richter@domain.hid wrote:<br>
&gt; Now I'm using xenomai 2.4.7 on kernel 2.6.27.19.<br>
&gt; <br>
&gt; The sigxcpu example from xenomai is now working correctly.<br>
&gt; <br>
&gt; After removing some outputs there are no more modeswitches in my task,<br>
&gt; apart from some debugging output while initilization.<br>
&gt; <br>
&gt; But now my system is no longer stable. It freezes.<br>
<br>
Show us /proc/interrupts, /proc/xenomai/irq, your .config if it changed.<br>
<br>
What kind of freeze is this? Do you run in graphical or in text mode? If<br>
in graphical mode, try and get the console output using serial console<br>
or netconsole.<br>
<br>
Does the system restart when you hit the keyboard?<br>
<br>
Does the system freeze when using the latency test alone? Same question<br>
with switchtest?<br>
<br>
-- <br>
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; Gilles.<br>
</tt><br>
</body></html>
--0__=4EBBFF3CDFBA3BF58f9e8a93df938690918c4EBBFF3CDFBA3BF5--


