Message-ID: <519BC3CB.1020300@nta-inc.net>
Date: Tue, 21 May 2013 13:58:19 -0500
From: Jeff Webb <jeff.webb@nta-inc.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [Xenomai] Ethernet driver issue
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Xenomai <xenomai@xenomai.org>

I am setting up a new lab machine (x86-64) with two ethernet interfaces (one on-board, and one in a PCI slot).  The secondary PCI card works fine under standard linux, but does not work when running a xenomai-patched kernel.  In the latter case, the OS brings up the eth1 interface, but I am unable to ping anything.  No bytes are received as shown via 'ifconfig':

eth1      Link encap:Ethernet  HWaddr 90:e2:ba:1b:61:70
           inet addr:192.168.12.21  Bcast:192.168.12.255  Mask:255.255.255.0
           inet6 addr: fe80::92e2:baff:fe1b:6170/64 Scope:Link
           UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
           RX packets:0 errors:0 dropped:84 overruns:0 frame:0
           TX packets:34 errors:0 dropped:0 overruns:0 carrier:0
           collisions:0 txqueuelen:1000
           RX bytes:0 (0.0 B)  TX bytes:8040 (8.0 KB)

This machine is a quad-core Xeon W3520 @ 2.67GHz running Ubuntu 12.04.  I started out with a custom-built 3.5.7/xenomai-2.6.2.1 kernel package using Ubuntu's config as a starting point.  When that didn't work, I rebuilt a vanilla 3.5.7 kernel using the same configuration.  The ethernet worked fine under that kernel, so it seems be a xenomai/i-pipe related issue.  I then built a kernel using code from the ipipe-core-3.5.7 and xenomai-2.6 git repositories, but this did not improve things.  I don't see any kernel panics, but I see a couple of spurious interrupt messages in the syslog:

[   28.585160] I-pipe: spurious interrupt 32
[   68.537855] I-pipe: spurious interrupt 32

That is not the IRQ associated with the ethernet card.  I have seen this same message on other machines, but I have not tracked down the cause.  Here is the output of 'sudo lcpci -vv' for the problematic ethernet card under xenomai:

06:04.0 Ethernet controller: Intel Corporation 82541PI Gigabit Ethernet Controller (rev 05)
         Subsystem: Intel Corporation PRO/1000 GT Desktop Adapter
         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR+ FastB2B- DisINTx-
         Status: Cap+ 66MHz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx+
         Latency: 64 (63750ns min), Cache Line Size: 64 bytes
         Interrupt: pin A routed to IRQ 16
         Region 0: Memory at f3bc0000 (32-bit, non-prefetchable) [size=128K]
         Region 1: Memory at f3be0000 (32-bit, non-prefetchable) [size=128K]
         Region 2: I/O ports at ccc0 [size=64]
         Expansion ROM at f3c00000 [disabled] [size=128K]
         Capabilities: [dc] Power Management version 2
                 Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
                 Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=1 PME-
         Capabilities: [e4] PCI-X non-bridge device
                 Command: DPERE- ERO+ RBC=512 OST=1
                 Status: Dev=00:00.0 64bit- 133MHz- SCD- USC- DC=simple DMMRBC=2048 DMOST=1 DMCRS=8 RSCEM- 266MHz- 533MHz-
         Kernel driver in use: e1000
         Kernel modules: e1000

On a working kernel, the output is similar, except for the last character in the status line:

         Status: Cap+ 66MHz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-

This is the output of /proc/interrupts under xenomai:

             CPU0       CPU1       CPU2       CPU3       CPU4       CPU5       CPU6       CPU7
    0:         77          0          0          0          0          0          0          0   IO-APIC-edge      timer
    1:          3          0          0          0          0          0          0          0   IO-APIC-edge      i8042
    7:          1          0          0          0          0          0          0          0   IO-APIC-edge      parport0
    8:          1          0          0          0          0          0          0          0   IO-APIC-edge      rtc0
    9:          0          0          0          0          0          0          0          0   IO-APIC-fasteoi   acpi
   12:          4          0          0          0          0          0          0          0   IO-APIC-edge      i8042
   16:         38          0          0          0          0          0          0          0   IO-APIC-fasteoi   uhci_hcd:usb3, eth1
   17:        200       5351        351          0          0          0          0          0   IO-APIC-fasteoi   uhci_hcd:usb4, uhci_hcd:usb7
   18:          0          0          0          0          0          0          0          0   IO-APIC-fasteoi   uhci_hcd:usb8
   22:          3          0          0          0          0          0          0          0   IO-APIC-fasteoi   ehci_hcd:usb1, uhci_hcd:usb5
   23:         60          0          0          0          0          0          0          0   IO-APIC-fasteoi   ehci_hcd:usb2, uhci_hcd:usb6
   34:        113        131          0          0          0          0          0          0   IO-APIC-fasteoi   snd_hda_intel
   66:       6177          0       9890          0          0          0          0          0   PCI-MSI-edge      ahci
   67:        245          0          0        129          0          0          0          0   PCI-MSI-edge      snd_hda_intel
   68:         55          0          0          0          0       5804          0          0   PCI-MSI-edge      eth0
  NMI:         16         11         17          9         15         19         14         19   Non-maskable interrupts
  LOC:      25255      14281      21555      14835      16608      18121      14736      19355   Local timer interrupts
  SPU:          0          0          0          0          0          0          0          0   Spurious interrupts
  PMI:         16         11         17          9         15         19         14         19   Performance monitoring interrupts
  IWI:          0          0          0          0          0          0          0          0   IRQ work interrupts
  RTR:          7          0          0          0          0          0          0          0   APIC ICR read retries
  RES:      40927      39497      33477      29679       5827       6441       7713       5641   Rescheduling interrupts
  CAL:        242        360        425        393        418        416        393        339   Function call interrupts
  TLB:        743        739        826        819        659       1038       1074       1160   TLB shootdowns
  TRM:          0          0          0          0          0          0          0          0   Thermal event interrupts
  THR:          0          0          0          0          0          0          0          0   Threshold APIC interrupts
  MCE:          0          0          0          0          0          0          0          0   Machine check exceptions
  MCP:          4          4          4          4          4          4          4          4   Machine check polls
  ERR:          0
  MIS:          0

On a working kernel, I get this:

             CPU0       CPU1       CPU2       CPU3       CPU4       CPU5       CPU6       CPU7
    0:         76          0          0          0          0          0          0          0   IO-APIC-edge      timer
    1:          3          0          0          0          0          0          0          0   IO-APIC-edge      i8042
    7:          1          0          0          0          0          0          0          0   IO-APIC-edge      parport0
    8:          1          0          0          0          0          0          0          0   IO-APIC-edge      rtc0
    9:          0          0          0          0          0          0          0          0   IO-APIC-fasteoi   acpi
   12:          4          0          0          0          0          0          0          0   IO-APIC-edge      i8042
   16:         35          0          0          0       1032          0          0          0   IO-APIC-fasteoi   uhci_hcd:usb3, eth1
   17:         86        393        460          0          0          0          0          0   IO-APIC-fasteoi   uhci_hcd:usb4, uhci_hcd:usb7
   18:          0          0          0          0          0          0          0          0   IO-APIC-fasteoi   uhci_hcd:usb8
   22:          3          0          0          0          0          0          0          0   IO-APIC-fasteoi   ehci_hcd:usb1, uhci_hcd:usb5
   23:         61          0          0          0          0          0          0          0   IO-APIC-fasteoi   ehci_hcd:usb2, uhci_hcd:usb6
   34:        193        232          0          0          0          0          0          0   IO-APIC-fasteoi   snd_hda_intel
   66:       6247          0       8704          0          0          0          0          0   PCI-MSI-edge      ahci
   67:        245          0          0         57          0          0          0          0   PCI-MSI-edge      snd_hda_intel
   68:         80          0          0          0          0      11328          0          0   PCI-MSI-edge      eth0
  NMI:          7         10         11          9         14         17         14         14   Non-maskable interrupts
  LOC:      30352       9408      12686       7699       6434       9800       8633       6039   Local timer interrupts
  SPU:          0          0          0          0          0          0          0          0   Spurious interrupts
  PMI:          7         10         11          9         14         17         14         14   Performance monitoring interrupts
  IWI:          0          0          0          0          0          0          0          0   IRQ work interrupts
  RTR:          7          0          0          0          0          0          0          0   APIC ICR read retries
  RES:      12970       1023        383        210        176        123        114        157   Rescheduling interrupts
  CAL:        152        385        395        397        371        388        404        389   Function call interrupts
  TLB:        579        604        677        666        925        763       1179       1090   TLB shootdowns
  TRM:          0          0          0          0          0          0          0          0   Thermal event interrupts
  THR:          0          0          0          0          0          0          0          0   Threshold APIC interrupts
  MCE:          0          0          0          0          0          0          0          0   Machine check exceptions
  MCP:          8          8          8          8          8          8          8          8   Machine check polls

So, it seems to me that some IRQ 16 interrupts are not getting through to linux.

Can anyone tell me how to proceed in debugging this issue?  What other information do you need?

Thanks,

-Jeff

