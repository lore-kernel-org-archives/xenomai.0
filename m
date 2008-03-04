Date: Tue, 4 Mar 2008 18:12:11 +0100 (CET)
From: Klaas Gadeyne <klaas.gadeyne@domain.hid>
Message-ID: <Pine.LNX.4.64.0803041734290.26008@domain.hid>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Subject: [Xenomai-help] Shared IRQ issue with Xeno Peak PCI CAN driver
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai@xenomai.org

Hi,

we're having a problem finding a non-shared IRQ for a PEAK systems can
board in a particular industrial SBC with PCI backplane [*].
Loading the xeno_can_peak_pci driver fails due to a "so-called" IRQ
conflict. (see below)

However, it seems the IRQ (12) is not assigned, so this shouldn't be a
problem [**]?

zeus:~# uname -a
Linux zeus 2.6.24-ipipe-2.0-03 #1 PREEMPT Tue Mar 4 14:54:02 CET 2008
            i686 GNU/Linux
zeus:~# cat /proc/interrupts
            CPU0
   0:     527508    XT-PIC-XT        timer
   1:        301    XT-PIC-XT        i8042
   2:          0    XT-PIC-XT        cascade
  10:        770    XT-PIC-XT        eth0
  11:       4386    XT-PIC-XT        libata
  14:       4333    XT-PIC-XT        ide0
  15:          0    XT-PIC-XT        libata
NMI:          0   Non-maskable interrupts
TRM:          0   Thermal event interrupts
SPU:          0   Spurious interrupts
ERR:          0
zeus:~# modprobe xeno_can_peak_pci
zeus:~# dmesg | tail
rtcan: registered rtcan0
PEAK-PCI-CAN: base_addr=f8a62400 conf_addr=f88b0000 irq=12
IRQ = 12
ERROR -16: IRQ 12 is busy, check shared interrupt support!
ERROR -16 while trying to register SJA1000 device!
Removing PEAK-PCI SJA1000 device rtcan0
Unregistering SJA1000 device rtcan0
RTCAN: unregistered rtcan0
PEAK-PCI-CAN: probe of 0000:04:06.0 failed with error -16
zeus:~# lspci -vv | tail
         Capabilities: [b0] Slot ID: 0 slots, First-, chassis 00

04:06.0 Network controller: Unknown device 001c:0001 (rev 02)
         Subsystem: Unknown device 001c:0004
         Control: I/O- Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop-
         ParErr- Stepping- SERR- FastB2B-
         Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium
         >TAbort- <TAbort- <MAbort- >SERR- <PERR-
         Interrupt: pin A routed to IRQ 12
         Region 0: Memory at d0100000 (32-bit, non-prefetchable)
         [size=64K]
         Region 1: Memory at d0110000 (32-bit, non-prefetchable)
         [size=64K]


Any hints on how to debug this?  We've already tried everything
described in the FAQ (I guess), but we don't understand there's a
conflict even if nothing is listed in /proc/interrupts?

Thx,

Klaas

[*] Putting the card in another pc works out just fine.


