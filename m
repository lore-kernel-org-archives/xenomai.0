Message-ID: <49879.131.173.32.74.1184076657.squirrel@domain.hid>
In-Reply-To: <46938A2D.3030009@domain.hid>
References: <34174.131.173.32.74.1184072898.squirrel@domain.hid>
	<46938A2D.3030009@domain.hid>
Date: Tue, 10 Jul 2007 16:10:57 +0200 (CEST)
From: bboese@domain.hid
MIME-Version: 1.0
Content-Type: text/plain;charset=iso-8859-1
Subject: Re: [Xenomai-help] SMI workaround failed
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
Cc: xenomai@xenomai.org

> As you already learned how to compile, here is the next chance to
> practice: we have Xenomai 2.3.2 with I-pipe 1.8-05 now. :)
Never change a running system ?  :)
I'd like to solve my latency problem before spending more time on compiling.

> That is _very_ high and, if true, can even be problematic for an
> ordinary non-RT system. Did you disable frequency scaling in your kernel
> config (if not, that would break the measurement under Xenomai)?
Yes, I did.

> You could try switching off individual SMI features, either in your
> kernel config or - easier for experimenting - with this userland tool:
>
> http://www.rts.uni-hannover.de/rtaddon/#smictrl
> http://www.rts.uni-hannover.de/rtaddon/smictrl.tar.bz2
>
Ok, I'll try the tool.

> Maybe just that "switch off everything" is blocked by your hardware.
> Moreover, it would be interesting to know your PCI IDs (lspci; lspci -n)
> for reference.
lspci
00:00.0 Host bridge: Intel Corporation 82945G/GZ/P/PL Memory Controller
Hub (rev 02)
00:01.0 PCI bridge: Intel Corporation 82945G/GZ/P/PL PCI Express Root Port
(rev 02)
00:1c.0 PCI bridge: Intel Corporation 82801G (ICH7 Family) PCI Express
Port 1 (rev 01)
00:1c.1 PCI bridge: Intel Corporation 82801G (ICH7 Family) PCI Express
Port 2 (rev 01)
00:1d.0 USB Controller: Intel Corporation 82801G (ICH7 Family) USB UHCI #1
(rev 01)
00:1d.1 USB Controller: Intel Corporation 82801G (ICH7 Family) USB UHCI #2
(rev 01)
00:1d.2 USB Controller: Intel Corporation 82801G (ICH7 Family) USB UHCI #3
(rev 01)
00:1d.3 USB Controller: Intel Corporation 82801G (ICH7 Family) USB UHCI #4
(rev 01)
00:1d.7 USB Controller: Intel Corporation 82801G (ICH7 Family) USB2 EHCI
Controller (rev 01)
00:1e.0 PCI bridge: Intel Corporation 82801 PCI Bridge (rev e1)
00:1e.2 Multimedia audio controller: Intel Corporation 82801G (ICH7
Family) AC'97 Audio Controller (rev 01)
00:1f.0 ISA bridge: Intel Corporation 82801GB/GR (ICH7 Family) LPC
Interface Bridge (rev 01)
00:1f.1 IDE interface: Intel Corporation 82801G (ICH7 Family) IDE
Controller (rev 01)
00:1f.2 IDE interface: Intel Corporation 82801GB/GR/GH (ICH7 Family)
Serial ATA Storage Controller IDE (rev 01)
00:1f.3 SMBus: Intel Corporation 82801G (ICH7 Family) SMBus Controller
(rev 01)
01:00.0 VGA compatible controller: ATI Technologies Inc RV380 [Radeon X600
(PCIE)]
01:00.1 Display controller: ATI Technologies Inc RV380 [Radeon X600]
02:00.0 Ethernet controller: Broadcom Corporation NetXtreme BCM5751
Gigabit Ethernet PCI Express (rev 01)
04:02.0 Signal processing controller: Meilhaus Electronic GmbH Unknown
device 4660 (rev 02)

lspci -v
00:00.0 0600: 8086:2770 (rev 02)
00:01.0 0604: 8086:2771 (rev 02)
00:1c.0 0604: 8086:27d0 (rev 01)
00:1c.1 0604: 8086:27d2 (rev 01)
00:1d.0 0c03: 8086:27c8 (rev 01)
00:1d.1 0c03: 8086:27c9 (rev 01)
00:1d.2 0c03: 8086:27ca (rev 01)
00:1d.3 0c03: 8086:27cb (rev 01)
00:1d.7 0c03: 8086:27cc (rev 01)
00:1e.0 0604: 8086:244e (rev e1)
00:1e.2 0401: 8086:27de (rev 01)
00:1f.0 0601: 8086:27b8 (rev 01)
00:1f.1 0101: 8086:27df (rev 01)
00:1f.2 0101: 8086:27c0 (rev 01)
00:1f.3 0c05: 8086:27da (rev 01)
01:00.0 0300: 1002:5b62
01:00.1 0380: 1002:5b72
02:00.0 0200: 14e4:1677 (rev 01)
04:02.0 1180: 1402:4660 (rev 02)


Kind regards,
Bastian Boese

