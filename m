Message-ID: <4A72BFBA.8040209@domain.hid>
Date: Fri, 31 Jul 2009 11:56:10 +0200
From: Theo Veenker <T.J.G.Veenker@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-help] high latencies with Intel P45 ICH10
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Xenomai help <xenomai@xenomai.org>

Hi,

I'm replacing a number of old machines in our lab by new ones with an
MSI P45 Neo3 mobo. On the new hardware I'm seeing high latencies with
Xenomai 2.4.8 on kernel 2.6.29.5. The latency thingy reports many
overruns:
RTT|  00:00:01  (periodic user-mode task, 100 us period, priority 99)
RTH|-----lat min|-----lat avg|-----lat max|-overrun|----lat best|---lat worst
RTD|       4.083|       9.100|       9.807|       0|       4.083|       9.807
RTD|       4.137|       9.280|    1804.493|      18|       4.083|    1804.493
RTD|       3.451|       9.099|      14.337|      18|       3.451|    1804.493
RTD|       3.864|       9.281|    1820.762|      36|       3.451|    1820.762
RTD|       4.017|       9.102|       9.917|      36|       3.451|    1820.762
RTD|       4.121|       9.273|    1742.710|      53|       3.451|    1820.762

I've tried UP/SMP both with and without disabling SMI. No CONFIG_ACPI_PROCESSOR
etc. PCI_MSI is disabled too. I do not see the "Xenomai: SMI-enabled chipset
found..." message in the messages log file. Is that correct or is this hardware
too new for this version of Xenomai?


Here's the output of lspci:

00:00.0 Host bridge: Intel Corporation Eaglelake DRAM Controller (rev 02)
	Subsystem: Micro-Star International Co., Ltd. Unknown device 7514
	Flags: bus master, fast devsel, latency 0
	Capabilities: [e0] Vendor Specific Information

00:01.0 PCI bridge: Intel Corporation Eaglelake PCI Express Root Port (rev 02) (prog-if 00 [Normal decode])
	Flags: bus master, fast devsel, latency 0
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
	I/O behind bridge: 0000c000-0000cfff
	Memory behind bridge: fe900000-fe9fffff
	Prefetchable memory behind bridge: 00000000d0000000-00000000dfffffff
	Capabilities: [88] Subsystem: Micro-Star International Co., Ltd. Unknown device 7514
	Capabilities: [80] Power Management version 3
	Capabilities: [90] Message Signalled Interrupts: Mask- 64bit- Queue=0/0 Enable-
	Capabilities: [a0] Express Root Port (Slot+) IRQ 0
	Capabilities: [100] Virtual Channel
	Capabilities: [140] Unknown (5)

00:1a.0 USB Controller: Intel Corporation 82801JI (ICH10 Family) USB UHCI Controller #4 (prog-if 00 [UHCI])
	Subsystem: Micro-Star International Co., Ltd. Unknown device 7514
	Flags: bus master, medium devsel, latency 0, IRQ 10
	I/O ports at bc00 [size=32]
	Capabilities: [50] #13 [0306]

00:1a.1 USB Controller: Intel Corporation 82801JI (ICH10 Family) USB UHCI Controller #5 (prog-if 00 [UHCI])
	Subsystem: Micro-Star International Co., Ltd. Unknown device 7514
	Flags: bus master, medium devsel, latency 0, IRQ 11
	I/O ports at b880 [size=32]
	Capabilities: [50] #13 [0306]

00:1a.2 USB Controller: Intel Corporation 82801JI (ICH10 Family) USB UHCI Controller #6 (prog-if 00 [UHCI])
	Subsystem: Micro-Star International Co., Ltd. Unknown device 7514
	Flags: bus master, medium devsel, latency 0, IRQ 15
	I/O ports at b800 [size=32]
	Capabilities: [50] #13 [0306]

00:1a.7 USB Controller: Intel Corporation 82801JI (ICH10 Family) USB2 EHCI Controller #2 (prog-if 20 [EHCI])
	Subsystem: Micro-Star International Co., Ltd. Unknown device 7514
	Flags: bus master, medium devsel, latency 0, IRQ 14
	Memory at fe8ffc00 (32-bit, non-prefetchable) [size=1K]
	Capabilities: [50] Power Management version 2
	Capabilities: [58] Debug port
	Capabilities: [98] #13 [0306]

00:1b.0 Audio device: Intel Corporation 82801JI (ICH10 Family) HD Audio Controller
	Subsystem: Micro-Star International Co., Ltd. Unknown device 7514
	Flags: bus master, fast devsel, latency 0, IRQ 3
	Memory at fe8f8000 (64-bit, non-prefetchable) [size=16K]
	Capabilities: [50] Power Management version 2
	Capabilities: [60] Message Signalled Interrupts: Mask- 64bit+ Queue=0/0 Enable-
	Capabilities: [70] Express Unknown type IRQ 0
	Capabilities: [100] Virtual Channel
	Capabilities: [130] Unknown (5)

00:1c.0 PCI bridge: Intel Corporation 82801JI (ICH10 Family) PCI Express Port 1 (prog-if 00 [Normal decode])
	Flags: bus master, fast devsel, latency 0
	Bus: primary=00, secondary=02, subordinate=02, sec-latency=0
	I/O behind bridge: 0000d000-0000dfff
	Memory behind bridge: fea00000-feafffff
	Capabilities: [40] Express Root Port (Slot+) IRQ 0
	Capabilities: [80] Message Signalled Interrupts: Mask- 64bit- Queue=0/0 Enable-
	Capabilities: [90] Subsystem: Micro-Star International Co., Ltd. Unknown device 7514
	Capabilities: [a0] Power Management version 2
	Capabilities: [100] Virtual Channel
	Capabilities: [180] Unknown (5)

00:1c.1 PCI bridge: Intel Corporation 82801JI (ICH10 Family) PCI Express Port 2 (prog-if 00 [Normal decode])
	Flags: bus master, fast devsel, latency 0
	Bus: primary=00, secondary=03, subordinate=03, sec-latency=0
	Capabilities: [40] Express Root Port (Slot+) IRQ 0
	Capabilities: [80] Message Signalled Interrupts: Mask- 64bit- Queue=0/0 Enable-
	Capabilities: [90] Subsystem: Micro-Star International Co., Ltd. Unknown device 7514
	Capabilities: [a0] Power Management version 2
	Capabilities: [100] Virtual Channel
	Capabilities: [180] Unknown (5)

00:1c.5 PCI bridge: Intel Corporation 82801JI (ICH10 Family) PCI Express Port 6 (prog-if 00 [Normal decode])
	Flags: bus master, fast devsel, latency 0
	Bus: primary=00, secondary=04, subordinate=04, sec-latency=0
	I/O behind bridge: 0000e000-0000efff
	Memory behind bridge: feb00000-febfffff
	Prefetchable memory behind bridge: 00000000fdf00000-00000000fdffffff
	Capabilities: [40] Express Root Port (Slot+) IRQ 0
	Capabilities: [80] Message Signalled Interrupts: Mask- 64bit- Queue=0/0 Enable-
	Capabilities: [90] Subsystem: Micro-Star International Co., Ltd. Unknown device 7514
	Capabilities: [a0] Power Management version 2
	Capabilities: [100] Virtual Channel
	Capabilities: [180] Unknown (5)

00:1d.0 USB Controller: Intel Corporation 82801JI (ICH10 Family) USB UHCI Controller #1 (prog-if 00 [UHCI])
	Subsystem: Micro-Star International Co., Ltd. Unknown device 7514
	Flags: bus master, medium devsel, latency 0, IRQ 6
	I/O ports at b480 [size=32]
	Capabilities: [50] #13 [0306]

00:1d.1 USB Controller: Intel Corporation 82801JI (ICH10 Family) USB UHCI Controller #2 (prog-if 00 [UHCI])
	Subsystem: Micro-Star International Co., Ltd. Unknown device 7514
	Flags: bus master, medium devsel, latency 0, IRQ 15
	I/O ports at b400 [size=32]
	Capabilities: [50] #13 [0306]

00:1d.2 USB Controller: Intel Corporation 82801JI (ICH10 Family) USB UHCI Controller #3 (prog-if 00 [UHCI])
	Subsystem: Micro-Star International Co., Ltd. Unknown device 7514
	Flags: bus master, medium devsel, latency 0, IRQ 14
	I/O ports at b080 [size=32]
	Capabilities: [50] #13 [0306]

00:1d.7 USB Controller: Intel Corporation 82801JI (ICH10 Family) USB2 EHCI Controller #1 (prog-if 20 [EHCI])
	Subsystem: Micro-Star International Co., Ltd. Unknown device 7514
	Flags: bus master, medium devsel, latency 0, IRQ 6
	Memory at fe8ff800 (32-bit, non-prefetchable) [size=1K]
	Capabilities: [50] Power Management version 2
	Capabilities: [58] Debug port
	Capabilities: [98] #13 [0306]

00:1e.0 PCI bridge: Intel Corporation 82801 PCI Bridge (rev 90) (prog-if 01 [Subtractive decode])
	Flags: bus master, fast devsel, latency 0
	Bus: primary=00, secondary=05, subordinate=05, sec-latency=32
	Capabilities: [50] Subsystem: Micro-Star International Co., Ltd. Unknown device 7514

00:1f.0 ISA bridge: Intel Corporation 82801JIR (ICH10R) LPC Interface Controller
	Subsystem: Micro-Star International Co., Ltd. Unknown device 7514
	Flags: bus master, medium devsel, latency 0
	Capabilities: [e0] Vendor Specific Information

00:1f.2 SATA controller: Intel Corporation 82801JI (ICH10 Family) SATA AHCI Controller (prog-if 01 [AHCI 1.0])
	Subsystem: Micro-Star International Co., Ltd. Unknown device 7514
	Flags: bus master, 66MHz, medium devsel, latency 0, IRQ 15
	I/O ports at b000 [size=8]
	I/O ports at ac00 [size=4]
	I/O ports at a880 [size=8]
	I/O ports at a800 [size=4]
	I/O ports at a480 [size=32]
	Memory at fe8ff000 (32-bit, non-prefetchable) [size=2K]
	Capabilities: [80] Message Signalled Interrupts: Mask- 64bit- Queue=0/4 Enable-
	Capabilities: [70] Power Management version 3
	Capabilities: [a8] #12 [0010]
	Capabilities: [b0] #13 [0306]

00:1f.3 SMBus: Intel Corporation 82801JI (ICH10 Family) SMBus Controller
	Subsystem: Micro-Star International Co., Ltd. Unknown device 7514
	Flags: medium devsel, IRQ 14
	Memory at fe8fec00 (64-bit, non-prefetchable) [size=256]
	I/O ports at 0400 [size=32]

01:00.0 VGA compatible controller: ATI Technologies Inc Unknown device 9490 (prog-if 00 [VGA controller])
	Subsystem: PC Partner Limited Unknown device e100
	Flags: bus master, fast devsel, latency 0, IRQ 10
	Memory at d0000000 (64-bit, prefetchable) [size=256M]
	Memory at fe9f0000 (64-bit, non-prefetchable) [size=64K]
	I/O ports at c000 [size=256]
	Expansion ROM at fe9c0000 [disabled] [size=128K]
	Capabilities: [50] Power Management version 3
	Capabilities: [58] Express Legacy Endpoint IRQ 0
	Capabilities: [a0] Message Signalled Interrupts: Mask- 64bit+ Queue=0/0 Enable-
	Capabilities: [100] Unknown (11)

01:00.1 Audio device: ATI Technologies Inc Unknown device aa38
	Subsystem: PC Partner Limited Unknown device aa38
	Flags: bus master, fast devsel, latency 0, IRQ 5
	Memory at fe9ec000 (64-bit, non-prefetchable) [size=16K]
	Capabilities: [50] Power Management version 3
	Capabilities: [58] Express Legacy Endpoint IRQ 0
	Capabilities: [a0] Message Signalled Interrupts: Mask- 64bit+ Queue=0/0 Enable-
	Capabilities: [100] Unknown (11)

02:00.0 SATA controller: JMicron Technologies, Inc. JMicron 20360/20363 AHCI Controller (rev 03) (prog-if 01 [AHCI 1.0])
	Subsystem: JMicron Technologies, Inc. JMicron 20360/20363 AHCI Controller
	Flags: bus master, fast devsel, latency 0, IRQ 10
	Memory at feafe000 (32-bit, non-prefetchable) [size=8K]
	Capabilities: [68] Power Management version 2
	Capabilities: [50] Express Legacy Endpoint IRQ 1

02:00.1 IDE interface: JMicron Technologies, Inc. JMicron 20360/20363 AHCI Controller (rev 03) (prog-if 85 [Master SecO PriO])
	Subsystem: JMicron Technologies, Inc. JMicron 20360/20363 AHCI Controller
	Flags: fast devsel, IRQ 5
	I/O ports at dc00 [size=8]
	I/O ports at d880 [size=4]
	I/O ports at d800 [size=8]
	I/O ports at d480 [size=4]
	I/O ports at d400 [size=16]
	Capabilities: [68] Power Management version 2

04:00.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL8111/8168B PCI Express Gigabit Ethernet controller (rev 02)
	Subsystem: Micro-Star International Co., Ltd. Unknown device 514c
	Flags: bus master, fast devsel, latency 0, IRQ 5
	I/O ports at e800 [size=256]
	Memory at fdfff000 (64-bit, prefetchable) [size=4K]
	Memory at fdfe0000 (64-bit, prefetchable) [size=64K]
	[virtual] Expansion ROM at fdf00000 [disabled] [size=64K]
	Capabilities: [40] Power Management version 3
	Capabilities: [50] Message Signalled Interrupts: Mask- 64bit+ Queue=0/1 Enable-
	Capabilities: [70] Express Endpoint IRQ 1
	Capabilities: [b0] MSI-X: Enable- Mask- TabSize=2
	Capabilities: [d0] Vital Product Data
	Capabilities: [100] Advanced Error Reporting
	Capabilities: [140] Virtual Channel
	Capabilities: [160] Device Serial Number 00-00-00-00-00-00-00-00

Hope someone has a suggestion.

Theo


