Message-ID: <519FAAC8.4010600@nta-inc.net>
Date: Fri, 24 May 2013 13:00:40 -0500
From: Jeff Webb <jeff.webb@nta-inc.net>
MIME-Version: 1.0
References: <519BC3CB.1020300@nta-inc.net> <519E441B.2010800@nta-inc.net>
	<CAPRPZsAQ2aucriuNSz1j4rYMo3rp6CZ_okATFnWuR7sd2+_GQQ@mail.gmail.com>
	<519E8762.3030309@nta-inc.net>
In-Reply-To: <519E8762.3030309@nta-inc.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] IRQ issue (was Ethernet driver issue)
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

On 05/23/2013 04:17 PM, Jeff Webb wrote:
> On 05/23/2013 12:39 PM, Jeroen Van den Keybus wrote:
>> If you mean INTx+, yes. In combination with DisINT- it indicates a pending interrupt.
>
> Yes, that's what I meant.  Thanks for confirming -- that helps.
>
>> Check with lspci what your PCI-PCIe bridge is. I once had serious issues with an ASMedia bridge that did not send an PCIe IRQ deassert message. Could be a mainboard issue as well.



I recreated the scenario where I plug in a PCIe->PCI adapter and plug the ethernet card into that.  For what it's worth, this is the PCIe->PCI adapter info:

01:00.0 PCI bridge: Pericom Semiconductor Device e111 (rev 02) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0, Cache Line Size: 64 bytes
	Bus: primary=01, secondary=02, subordinate=02, sec-latency=64
	I/O behind bridge: 0000c000-0000cfff
	Memory behind bridge: f3d00000-f3efffff
	Secondary status: 66MHz+ FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- <SERR- <PERR-
	BridgeCtl: Parity- SERR+ NoISA- VGA- MAbort- >Reset- FastB2B-
		PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
	Capabilities: <access denied>
	Kernel modules: shpchp

(Remember, this is not the adapter on my motherboard, but just something I am plugging in for test purposes.)  When I'm running vanilla linux (3.5.7) with this configuration, everything seems to work fine (the ethernet card, the mouse/keyboard, and no spurious interrupts).  Under xenomai, the ethernet card works, but within a few seconds the mouse and keyboard become extremely delayed as I mentioned in a previous email.  This behavior is consistent and repeatable, so it seems to confirm that the problem has to do with xenomai.  In this case, the lspci output seems to indicate a pending interrupt like before, but this time it seems to be associated with the USB system, and not the PCI ethernet card.  This makes sense to me, since the USB is obviously malfunctioning under this test.

00:1a.1 USB controller: Intel Corporation 82801JI (ICH10 Family) USB UHCI Controller #5 (prog-if 00 [UHCI])
         Subsystem: Dell Device 0293
         Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
         Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx+
         Latency: 0
         Interrupt: pin B routed to IRQ 17
         Region 4: I/O ports at ff00 [size=32]
         Capabilities: <access denied>
         Kernel driver in use: uhci_hcd

02:04.0 Ethernet controller: Intel Corporation 82541PI Gigabit Ethernet Controller (rev 05)
         Subsystem: Intel Corporation PRO/1000 GT Desktop Adapter
         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR+ FastB2B- DisINTx-
         Status: Cap+ 66MHz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
         Latency: 64 (63750ns min), Cache Line Size: 64 bytes
         Interrupt: pin A routed to IRQ 28
         Region 0: Memory at f3dc0000 (32-bit, non-prefetchable) [size=128K]
         Region 1: Memory at f3de0000 (32-bit, non-prefetchable) [size=128K]
         Region 2: I/O ports at ccc0 [size=64]
         Expansion ROM at f3e00000 [disabled] [size=128K]
         Capabilities: <access denied>
         Kernel driver in use: e1000
         Kernel modules: e1000

>> Since you experience very slow response with another PCI-PCIe bridge, also check the number of IRQs in /proc/interrupts and proc/xenomai/irq.

Here is /proc/interrupts for the above configuration:

             CPU0       CPU1       CPU2       CPU3       CPU4       CPU5       CPU6       CPU7
    0:         77          0          0          0          0          0          0          0   IO-APIC-edge      timer
    1:          3          0          0          0          0          0          0          0   IO-APIC-edge      i8042
    7:          1          0          0          0          0          0          0          0   IO-APIC-edge      parport0
    8:          1          0          0          0          0          0          0          0   IO-APIC-edge      rtc0
    9:          0          0          0          0          0          0          0          0   IO-APIC-fasteoi   acpi
   12:          4          0          0          0          0          0          0          0   IO-APIC-edge      i8042
   16:         42          0          0          0          0          0          0          0   IO-APIC-fasteoi   uhci_hcd:usb3
   17:        199         43          0        576          0          0          0          0   IO-APIC-fasteoi   uhci_hcd:usb4, uhci_hcd:usb7
   18:          0          0          0          0          0          0          0          0   IO-APIC-fasteoi   uhci_hcd:usb8
   22:          3          0          0          0          0          0          0          0   IO-APIC-fasteoi   ehci_hcd:usb1, uhci_hcd:usb5
   23:         60          0          0          0          0          0          0          0   IO-APIC-fasteoi   ehci_hcd:usb2, uhci_hcd:usb6
   28:         43          0          0          0        291          0          0          0   IO-APIC-fasteoi   eth1
   34:        243          0          0          0          0          0          0          0   IO-APIC-fasteoi   snd_hda_intel
   66:       6206          0       7582          0          0          0          0          0   PCI-MSI-edge      ahci
   67:        245         58          0         11          0          0          0          0   PCI-MSI-edge      snd_hda_intel
   68:        309          0          0          0          0       2365          0          0   PCI-MSI-edge      eth0
  NMI:         10          5         10          4         15         18         14         16   Non-maskable interrupts
  LOC:      11262       7593      11187       7486       9941      12152       9752      10769   Local timer interrupts
  SPU:          0          0          0          0          0          0          0          0   Spurious interrupts
  PMI:         10          5         10          4         15         18         14         16   Performance monitoring interrupts
  IWI:          0          0          0          0          0          0          0          0   IRQ work interrupts
  RTR:          7          0          0          0          0          0          0          0   APIC ICR read retries
  RES:      12821      12277      11275       7505       6297       5263       7275       4130   Rescheduling interrupts
  CAL:        224        359        402        406        385        420        411        355   Function call interrupts
  TLB:        494        611        637        526        616        889       1104        952   TLB shootdowns
  TRM:          0          0          0          0          0          0          0          0   Thermal event interrupts
  THR:          0          0          0          0          0          0          0          0   Threshold APIC interrupts
  MCE:          0          0          0          0          0          0          0          0   Machine check exceptions
  MCP:          2          2          2          2          2          2          2          2   Machine check polls
  ERR:          0
  MIS:          0

Here is /proc/xenomai/irq:

IRQ         CPU0        CPU1        CPU2        CPU3        CPU4        CPU5        CPU6        CPU7
16672:      137861       40965       37428       38394       30406       57161       27699       26446         [timer]
16673:           0           1           1           1           1           1           1           1         [reschedule]
16674:           0           1           1           1           1           1           1           1         [timer-ipi]
16675:           0           0           0           0           0           0           0           0         [sync]
16707:           0           0           0           0           0           0           0           0         [virtual]

>> Also check very thoroughly that the issue does not occur in plain Linux (check dmesg for 'Nobody cared'). It can take hours of testing to trigger the problem and maybe the I-pipe exposes it more quickly. My personal feeling on the problem back then was that it could have something to do with the interrupt being serviced very fast.

Still no sign of this.  I haven't done hours of testing under standard linux, but linux seems to work fine with a configuration that reproducibly produces the problem under xenomai.

I still always get something like this under Xenomai:

[   26.589844] I-pipe: spurious interrupt 32
[   36.596341] I-pipe: spurious interrupt 32

I'm not sure whether this is related or not, because the interrupt number is always 32, but it seems fishy.

Any pointers on how to proceed next would be appreciated.

Thanks,

Jeff


