Message-ID: <499B36C5.3060104@domain.hid>
Date: Tue, 17 Feb 2009 23:14:29 +0100
From: Roman Pisl <rpisl@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------010905010903030702080102"
Subject: [Xenomai-help] BUG fs/buffer.c with Linux 2.6.26,27
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

This is a multi-part message in MIME format.
--------------010905010903030702080102
Content-Type: text/plain; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: 7bit

Hello,
I'm porting our application to Xenomai and I found a bug with Linux 
2.6.26 and 2.6.27 (and also .19) and Xenomai 2.4.6.1. This happens when 
the application is running and there is hard disk activity. It happens 
also when latency test is running for a while. Linux 2.6.16 with Xenomai 
2.4.6.1 works without problem. So this is solution for now.

Tested on x86 - thinkpad laptop and pentium 4 desktop.

I'm not a kernel hacker but surely try to help with fixing. I'd like to 
see this fixed.

Thank you.

Roman Pisl



--------------010905010903030702080102
Content-Type: text/plain;
 name="bug26.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="bug26.txt"

Linux version 2.6.26-xenomai (root@domain.hid) (gcc version 4.1.2 (Gentoo 4.1.2 p1.1)) #6 SMP Tue Feb 17 15:06:54 CET 2009
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 00000000000a0000 (usable)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000003ff71000 (usable)
 BIOS-e820: 000000003ff71000 - 000000003ff73000 (ACPI NVS)
 BIOS-e820: 000000003ff73000 - 000000003ff94000 (ACPI data)
 BIOS-e820: 000000003ff94000 - 0000000040000000 (reserved)
 BIOS-e820: 00000000fec00000 - 00000000fec10000 (reserved)
 BIOS-e820: 00000000fee00000 - 00000000fee10000 (reserved)
 BIOS-e820: 00000000ffb00000 - 0000000100000000 (reserved)
127MB HIGHMEM available.
896MB LOWMEM available.
found SMP MP-table at [c00fe710] 000fe710
Entering add_active_range(0, 0, 262001) 0 entries of 256 used
Zone PFN ranges:
  DMA             0 ->     4096
  Normal       4096 ->   229376
  HighMem    229376 ->   262001
Movable zone start PFN for each node
early_node_map[1] active PFN ranges
    0:        0 ->   262001
On node 0 totalpages: 262001
  DMA zone: 32 pages used for memmap
  DMA zone: 0 pages reserved
  DMA zone: 4064 pages, LIFO batch:0
  Normal zone: 1760 pages used for memmap
  Normal zone: 223520 pages, LIFO batch:31
  HighMem zone: 255 pages used for memmap
  HighMem zone: 32370 pages, LIFO batch:7
  Movable zone: 0 pages used for memmap
DMI 2.3 present.
ACPI: RSDP 000FEBA0, 0014 (r0 DELL  )
ACPI: RSDT 000FD501, 0038 (r1 DELL    GX260          6 ASL        61)
ACPI: FACP 000FD539, 0074 (r1 DELL    GX260          6 ASL        61)
ACPI: DSDT FFFD5D84, 2563 (r1   DELL    dt_ex     1000 MSFT  100000D)
ACPI: FACS 3FF71000, 0040
ACPI: SSDT FFFD82E7, 00A7 (r1   DELL    st_ex     1000 MSFT  100000D)
ACPI: APIC 000FD5AD, 006C (r1 DELL    GX260          6 ASL        61)
ACPI: BOOT 000FD619, 0028 (r1 DELL    GX260          6 ASL        61)
ACPI: ASF! 000FD641, 0067 (r16 DELL    GX260          6 ASL        61)
ACPI: PM-Timer IO Port: 0x808
ACPI: Local APIC address 0xfee00000
ACPI: LAPIC (acpi_id[0x01] lapic_id[0x00] enabled)
ACPI: LAPIC (acpi_id[0x02] lapic_id[0x01] disabled)
ACPI: LAPIC (acpi_id[0x03] lapic_id[0x01] disabled)
ACPI: LAPIC (acpi_id[0x04] lapic_id[0x03] disabled)
ACPI: IOAPIC (id[0x01] address[0xfec00000] gsi_base[0])
IOAPIC[0]: apic_id 1, version 32, address 0xfec00000, GSI 0-23
ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
ACPI: IRQ0 used by override.
ACPI: IRQ2 used by override.
ACPI: IRQ9 used by override.
Enabling APIC mode:  Flat.  Using 1 I/O APICs
Using ACPI (MADT) for SMP configuration information
Allocating PCI resources starting at 50000000 (gap: 40000000:bec00000)
SMP: Allowing 2 CPUs, 1 hotplug CPUs
PERCPU: Allocating 1617832 bytes of per cpu data
NR_CPUS: 2, nr_cpu_ids: 2
Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 259954
Kernel command line: ro root=/dev/sda3
mapped APIC to ffffb000 (fee00000)
mapped IOAPIC to ffffa000 (fec00000)
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Initializing CPU#0
PID hash table entries: 4096 (order: 12, 16384 bytes)
Detected 2391.241 MHz processor.
I-pipe 2.0-16: pipeline enabled.
Console: colour VGA+ 80x25
console [tty0] enabled
Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
Memory: 1027892k/1048004k available (2927k kernel code, 19440k reserved, 1365k data, 1796k init, 130500k highmem)
virtual kernel memory layout:
    fixmap  : 0xfff9b000 - 0xfffff000   ( 400 kB)
    pkmap   : 0xff800000 - 0xffc00000   (4096 kB)
    vmalloc : 0xf8800000 - 0xff7fe000   ( 111 MB)
    lowmem  : 0xc0000000 - 0xf8000000   ( 896 MB)
      .init : 0xc0538000 - 0xc06f9000   (1796 kB)
      .data : 0xc03dbc92 - 0xc0531350   (1365 kB)
      .text : 0xc0100000 - 0xc03dbc92   (2927 kB)
Checking if this processor honours the WP bit even in supervisor mode...Ok.
CPA: page pool initialized 1 of 1 pages preallocated
SLUB: Genslabs=12, HWalign=128, Order=0-3, MinObjects=0, CPUs=2, Nodes=1
Calibrating delay using timer specific routine.. 4788.44 BogoMIPS (lpj=9576898)
Mount-cache hash table entries: 512
CPU: Trace cache: 12K uops, L1 D cache: 8K
CPU: L2 cache: 512K
CPU: Hyper-Threading is disabled
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU0: Intel P4/Xeon Extended MCE MSRs (12) available
CPU0: Thermal monitoring enabled
Checking 'hlt' instruction... OK.
SMP alternatives: switching to UP code
ACPI: Core revision 20080321
Parsing all Control Methods:
Table [DSDT](id 0001) - 303 Objects with 29 Devices 116 Methods 21 Regions
Parsing all Control Methods:
Table [SSDT](id 0002) - 7 Objects with 0 Devices 1 Methods 0 Regions
 tbxface-0598 [00] tb_load_namespace     : ACPI Tables successfully acquired
evxfevnt-0091 [00] enable                : Transition to ACPI mode successful
ENABLING IO-APIC IRQs
..TIMER: vector=0x31 apic1=0 pin1=2 apic2=-1 pin2=-1
CPU0: Intel(R) Pentium(R) 4 CPU 2.40GHz stepping 04
Brought up 1 CPUs
Total of 1 processors activated (4788.44 BogoMIPS).
net_namespace: 632 bytes
NET: Registered protocol family 16
No dock devices found.
ACPI: bus type pci registered
PCI: PCI BIOS revision 2.10 entry at 0xfbdf8, last bus=2
PCI: Using configuration type 1 for base access
Setting up standard PCI resources
evgpeblk-0956 [00] ev_create_gpe_block   : GPE 00 to 1F [_GPE] 4 regs on int 0x9
ACPI: EC: Look up EC in DSDT
Completing Region/Field/Buffer/Package initialization:..........................................
Initialized 17/21 Regions 0/0 Fields 9/9 Buffers 16/16 Packages (319 nodes)
Initializing Device/Processor/Thermal objects by executing _INI methods:....
Executed 4 _INI methods requiring 3 _STA executions (examined 33 objects)
evgpeblk-1052 [00] ev_initialize_gpe_bloc: Found 7 Wake, Enabled 1 Runtime GPEs in this block
ACPI: Interpreter enabled
ACPI: (supports S0 S5)
ACPI: Using IOAPIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (0000:00)
* The chipset may have PM-Timer Bug. Due to workarounds for a bug,
* this clock source is slow. If you are sure your timer does not have
* this bug, please use "acpi_pm_good" to disable the workaround
pci 0000:00:1f.0: quirk: region 0800-087f claimed by ICH4 ACPI/GPIO/TCO
pci 0000:00:1f.0: quirk: region 0880-08bf claimed by ICH4 GPIO
PCI: Transparent bridge - 0000:00:1e.0
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PCI1._PRT]
ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 7 9 10 *11 12 15)
ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 7 9 10 *11 12 15)
ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 6 7 *9 10 11 12 15)
ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 6 7 9 *10 11 12 15)
ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 6 7 9 10 11 12 15) *0, disabled.
ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 6 7 9 10 11 12 15) *0, disabled.
ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 5 6 7 9 10 11 12 15) *0, disabled.
ACPI: PCI Interrupt Link [LNKH] (IRQs *3 4 5 6 7 9 10 11 12 15)
Linux Plug and Play Support v0.97 (c) Adam Belay
pnp: PnP ACPI init
ACPI: bus type pnp registered
pnp: PnP ACPI: found 12 devices
ACPI: ACPI bus type pnp unregistered
SCSI subsystem initialized
libata version 3.00 loaded.
usbcore: registered new interface driver usbfs
usbcore: registered new interface driver hub
usbcore: registered new device driver usb
PCI: Using ACPI for IRQ routing
system 00:00: iomem range 0x0-0x9ffff could not be reserved
system 00:00: iomem range 0x100000-0xffffff could not be reserved
system 00:00: iomem range 0x1000000-0x3ff70fff could not be reserved
system 00:00: iomem range 0xf0000-0xfffff could not be reserved
system 00:00: iomem range 0xfec00000-0xfec0ffff could not be reserved
system 00:00: iomem range 0xfee00000-0xfee0ffff could not be reserved
system 00:00: iomem range 0xffb00000-0xffbfffff could not be reserved
system 00:00: iomem range 0xffc00000-0xffffffff could not be reserved
system 00:0b: ioport range 0x800-0x85f has been reserved
system 00:0b: ioport range 0xc00-0xc7f has been reserved
system 00:0b: ioport range 0x860-0x8ff could not be reserved
PCI: Bridge: 0000:00:01.0
  IO window: e000-efff
  MEM window: 0xff800000-0xff9fffff
  PREFETCH window: 0x00000000f0000000-0x00000000f7ffffff
PCI: Bridge: 0000:00:1e.0
  IO window: d000-dfff
  MEM window: 0xff600000-0xff7fffff
  PREFETCH window: disabled.
PCI: Setting latency timer of device 0000:00:1e.0 to 64
NET: Registered protocol family 2
IP route cache hash table entries: 32768 (order: 5, 131072 bytes)
TCP established hash table entries: 131072 (order: 8, 1048576 bytes)
TCP bind hash table entries: 65536 (order: 7, 524288 bytes)
TCP: Hash tables configured (established 131072 bind 65536)
TCP reno registered
NET: Registered protocol family 1
Simple Boot Flag value 0x87 read from CMOS RAM was invalid
Simple Boot Flag at 0x7a set to 0x1
Machine check exception polling timer started.
IA-32 Microcode Update Driver: v1.14a <tigran@domain.hid>
I-pipe: Domain Xenomai registered.
Xenomai: hal/i386 started.
Xenomai: real-time nucleus v2.4.6 (Bamboo) loaded.
Xenomai: SMI-enabled chipset found
Xenomai: SMI workaround failed!
Xenomai: starting native API services.
Xenomai: starting POSIX services.
Xenomai: starting RTDM services.
highmem bounce pool size: 64 pages
Total HugeTLB memory allocated, 0
msgmni has been set to 1753
io scheduler noop registered
io scheduler anticipatory registered
io scheduler deadline registered
io scheduler cfq registered (default)
pci 0000:01:00.0: Boot video device
Real Time Clock Driver v1.12ac
Linux agpgart interface v0.103
agpgart: Detected an Intel 830M Chipset.
agpgart: AGP aperture is 128M @ 0xe8000000
ACPI: PCI Interrupt 0000:01:00.0[A] -> GSI 16 (level, low) -> IRQ 16
radeonfb: Found Intel x86 BIOS ROM Image
radeonfb: Retrieved PLL infos from BIOS
radeonfb: Reference=27.00 MHz (RefDiv=12) Memory=245.00 Mhz, System=170.00 MHz
radeonfb: PLL min 20000 max 35000
i2c-adapter i2c-1: unable to read EDID block.
i2c-adapter i2c-1: unable to read EDID block.
Switched to high resolution mode on CPU 0
i2c-adapter i2c-1: unable to read EDID block.
i2c-adapter i2c-3: unable to read EDID block.
i2c-adapter i2c-3: unable to read EDID block.
i2c-adapter i2c-3: unable to read EDID block.
radeonfb: Monitor 1 type CRT found
radeonfb: EDID probed
radeonfb: Monitor 2 type no found
Console: switching to colour frame buffer device 160x64
radeonfb (0000:01:00.0): ATI Radeon 5157 "QW"
input: Power Button (FF) as /class/input/input0
ACPI: Power Button (FF) [PWRF]
input: Power Button (CM) as /class/input/input1
ACPI: Power Button (CM) [VBTN]
Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing disabled
serial8250: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
00:09: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
brd: module loaded
loop: module loaded
Intel(R) PRO/1000 Network Driver - version 7.3.20-k2
Copyright (c) 1999-2006 Intel Corporation.
ACPI: PCI Interrupt 0000:02:0c.0[A] -> GSI 18 (level, low) -> IRQ 18
e1000: 0000:02:0c.0: e1000_probe: (PCI:33MHz:32-bit) 00:08:74:2a:e8:60
e1000: eth0: e1000_probe: Intel(R) PRO/1000 Network Connection
8139too Fast Ethernet driver 0.9.28
ACPI: PCI Interrupt 0000:02:07.0[A] -> GSI 16 (level, low) -> IRQ 16
eth1: RealTek RTL8139 at 0xf8816c00, 00:1f:1f:14:69:b1, IRQ 16
eth1:  Identified 8139 chip type 'RTL-8100B/8139D'
3ware Storage Controller device driver for Linux v1.26.02.002.
Driver 'sd' needs updating - please use bus_type methods
Driver 'sr' needs updating - please use bus_type methods
ata_piix 0000:00:1f.1: version 2.12
ata_piix 0000:00:1f.1: enabling device (0005 -> 0007)
ACPI: PCI Interrupt 0000:00:1f.1[A] -> GSI 18 (level, low) -> IRQ 18
PCI: Setting latency timer of device 0000:00:1f.1 to 64
scsi0 : ata_piix
scsi1 : ata_piix
ata1: PATA max UDMA/100 cmd 0x1f0 ctl 0x3f6 bmdma 0xffa0 irq 14
ata2: PATA max UDMA/100 cmd 0x170 ctl 0x376 bmdma 0xffa8 irq 15
ata1.00: ATA-7: ST3500630A, 3.AAE, max UDMA/100
ata1.00: 976773168 sectors, multi 8: LBA48 
ata1.01: ATA-5: WDC WD400BB-60DGA0, 05.03E05, max UDMA/100
ata1.01: 78165360 sectors, multi 8: LBA 
ata1.00: configured for UDMA/100
ata1.01: configured for UDMA/100
ata2.00: ATAPI: HL-DT-ST DVDRAM GSA-H12N, UL01, max UDMA/66
ata2.01: ATAPI: SAMSUNG DVD-ROM SD-616T, F308, max UDMA/33
ata2.00: configured for UDMA/66
ata2.01: configured for UDMA/33
scsi 0:0:0:0: Direct-Access     ATA      ST3500630A       3.AA PQ: 0 ANSI: 5
sd 0:0:0:0: [sda] 976773168 512-byte hardware sectors (500108 MB)
sd 0:0:0:0: [sda] Write Protect is off
sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
sd 0:0:0:0: [sda] 976773168 512-byte hardware sectors (500108 MB)
sd 0:0:0:0: [sda] Write Protect is off
sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
 sda: sda1 sda2 sda3 sda4 < >
sd 0:0:0:0: [sda] Attached SCSI disk
sd 0:0:0:0: Attached scsi generic sg0 type 0
scsi 0:0:1:0: Direct-Access     ATA      WDC WD400BB-60DG 05.0 PQ: 0 ANSI: 5
sd 0:0:1:0: [sdb] 78165360 512-byte hardware sectors (40021 MB)
sd 0:0:1:0: [sdb] Write Protect is off
sd 0:0:1:0: [sdb] Mode Sense: 00 3a 00 00
sd 0:0:1:0: [sdb] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
sd 0:0:1:0: [sdb] 78165360 512-byte hardware sectors (40021 MB)
sd 0:0:1:0: [sdb] Write Protect is off
sd 0:0:1:0: [sdb] Mode Sense: 00 3a 00 00
sd 0:0:1:0: [sdb] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
 sdb: sdb1
sd 0:0:1:0: [sdb] Attached SCSI disk
sd 0:0:1:0: Attached scsi generic sg1 type 0
scsi 1:0:0:0: CD-ROM            HL-DT-ST DVDRAM GSA-H12N  UL01 PQ: 0 ANSI: 5
sr0: scsi3-mmc drive: 48x/48x writer dvd-ram cd/rw xa/form2 cdda tray
Uniform CD-ROM driver Revision: 3.20
sr 1:0:0:0: Attached scsi CD-ROM sr0
sr 1:0:0:0: Attached scsi generic sg2 type 5
scsi 1:0:1:0: CD-ROM            SAMSUNG  DVD-ROM SD-616T  F308 PQ: 0 ANSI: 5
sr1: scsi3-mmc drive: 1x/48x cd/rw xa/form2 cdda tray
sr 1:0:1:0: Attached scsi CD-ROM sr1
sr 1:0:1:0: Attached scsi generic sg3 type 5
ieee1394: raw1394: /dev/raw1394 device initialized
usbmon: debugfs is not available
ACPI: PCI Interrupt 0000:00:1d.7[D] -> GSI 23 (level, low) -> IRQ 23
PCI: Setting latency timer of device 0000:00:1d.7 to 64
ehci_hcd 0000:00:1d.7: EHCI Host Controller
ehci_hcd 0000:00:1d.7: new USB bus registered, assigned bus number 1
ehci_hcd 0000:00:1d.7: debug port 1
PCI: cache line size of 128 is not supported by device 0000:00:1d.7
ehci_hcd 0000:00:1d.7: irq 23, io mem 0xffa20800
ehci_hcd 0000:00:1d.7: USB 2.0 started, EHCI 1.00, driver 10 Dec 2004
usb usb1: configuration #1 chosen from 1 choice
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 6 ports detected
ohci_hcd: 2006 August 04 USB 1.1 'Open' Host Controller (OHCI) Driver
USB Universal Host Controller Interface driver v3.0
ACPI: PCI Interrupt 0000:00:1d.0[A] -> GSI 16 (level, low) -> IRQ 16
PCI: Setting latency timer of device 0000:00:1d.0 to 64
uhci_hcd 0000:00:1d.0: UHCI Host Controller
uhci_hcd 0000:00:1d.0: new USB bus registered, assigned bus number 2
uhci_hcd 0000:00:1d.0: irq 16, io base 0x0000ff80
usb usb2: configuration #1 chosen from 1 choice
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 2 ports detected
ACPI: PCI Interrupt 0000:00:1d.1[B] -> GSI 19 (level, low) -> IRQ 19
PCI: Setting latency timer of device 0000:00:1d.1 to 64
uhci_hcd 0000:00:1d.1: UHCI Host Controller
uhci_hcd 0000:00:1d.1: new USB bus registered, assigned bus number 3
uhci_hcd 0000:00:1d.1: irq 19, io base 0x0000ff60
usb usb3: configuration #1 chosen from 1 choice
hub 3-0:1.0: USB hub found
hub 3-0:1.0: 2 ports detected
ACPI: PCI Interrupt 0000:00:1d.2[C] -> GSI 18 (level, low) -> IRQ 18
PCI: Setting latency timer of device 0000:00:1d.2 to 64
uhci_hcd 0000:00:1d.2: UHCI Host Controller
uhci_hcd 0000:00:1d.2: new USB bus registered, assigned bus number 4
uhci_hcd 0000:00:1d.2: irq 18, io base 0x0000ff40
usb usb4: configuration #1 chosen from 1 choice
hub 4-0:1.0: USB hub found
hub 4-0:1.0: 2 ports detected
usbcore: registered new interface driver usblp
Initializing USB Mass Storage driver...
usbcore: registered new interface driver usb-storage
USB Mass Storage support registered.
PNP: PS/2 Controller [PNP0303:KBD,PNP0f13:MOU] at 0x60,0x64 irq 1,12
serio: i8042 KBD port at 0x60,0x64 irq 1
serio: i8042 AUX port at 0x60,0x64 irq 12
mice: PS/2 mouse device common for all mice
input: AT Translated Set 2 keyboard as /class/input/input2
cpuidle: using governor ladder
cpuidle: using governor menu
oprofile: using NMI interrupt.
TCP cubic registered
NET: Registered protocol family 10
IPv6 over IPv4 tunneling driver
NET: Registered protocol family 17
Using IPI No-Shortcut mode
input: ImPS/2 Logitech Wheel Mouse as /class/input/input3
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
Freeing unused kernel memory: 1796k freed
EXT3 FS on sda3, internal journal
fuse init (API version 7.9)
ADDRCONF(NETDEV_UP): eth0: link is not ready
e1000: eth0: e1000_watchdog: NIC Link is Up 1000 Mbps Full Duplex, Flow Control: RX/TX
ADDRCONF(NETDEV_CHANGE): eth0: link becomes ready
eth0: no IPv6 routers present
[drm] Initialized drm 1.1.0 20060810
[drm] Initialized radeon 1.29.0 20080528 on minor 0
agpgart: Found an AGP 2.0 compliant device at 0000:00:00.0.
agpgart: Putting AGP V2 device at 0000:00:00.0 into 4x mode
agpgart: Putting AGP V2 device at 0000:01:00.0 into 4x mode
[drm] Setting GART location based on new memory map
[drm] Loading R100 Microcode
[drm] writeback test succeeded in 1 usecs
agpgart: Found an AGP 2.0 compliant device at 0000:00:00.0.
agpgart: Putting AGP V2 device at 0000:00:00.0 into 4x mode
agpgart: Putting AGP V2 device at 0000:01:00.0 into 4x mode
[drm] Loading R100 Microcode
agpgart: Found an AGP 2.0 compliant device at 0000:00:00.0.
agpgart: Putting AGP V2 device at 0000:00:00.0 into 4x mode
agpgart: Putting AGP V2 device at 0000:01:00.0 into 4x mode
[drm] Loading R100 Microcode
agpgart: Found an AGP 2.0 compliant device at 0000:00:00.0.
agpgart: Putting AGP V2 device at 0000:00:00.0 into 4x mode
agpgart: Putting AGP V2 device at 0000:01:00.0 into 4x mode
[drm] Loading R100 Microcode
agpgart: Found an AGP 2.0 compliant device at 0000:00:00.0.
agpgart: Putting AGP V2 device at 0000:00:00.0 into 4x mode
agpgart: Putting AGP V2 device at 0000:01:00.0 into 4x mode
[drm] Loading R100 Microcode
agpgart: Found an AGP 2.0 compliant device at 0000:00:00.0.
agpgart: Putting AGP V2 device at 0000:00:00.0 into 4x mode
agpgart: Putting AGP V2 device at 0000:01:00.0 into 4x mode
[drm] Loading R100 Microcode
agpgart: Found an AGP 2.0 compliant device at 0000:00:00.0.
agpgart: Putting AGP V2 device at 0000:00:00.0 into 4x mode
agpgart: Putting AGP V2 device at 0000:01:00.0 into 4x mode
[drm] Loading R100 Microcode
------------[ cut here ]------------
kernel BUG at fs/buffer.c:1290!
invalid opcode: 0000 [#1] SMP 
Modules linked in: radeon drm fuse

Pid: 15295, comm: eix Not tainted (2.6.26-xenomai #6)
EIP: 0060:[<c01b996a>] EFLAGS: 00010246 CPU: 0
EIP is at __find_get_block+0x39/0x1cd
EAX: 00000000 EBX: f5f201a0 ECX: 00000000 EDX: ffffffff
ESI: 00000000 EDI: f7820200 EBP: f5f6bd84 ESP: f5f6bd48
 DS: 007b ES: 007b FS: 00d8 GS: 0033 SS: 0068
Process eix (pid: 15295, ti=f5f6a000 task=f5fbb800 task.ti=f5f6a000)<0>
I-pipe domain Linux
Stack: 01dae868 00000000 000014ca c1949b1c 00000286 00000000 c07b5900 00000000 
       f5f201a0 00000000 f7be9e98 f5f6bddc f5f201a0 00000000 f7be9e98 f5f6bddc 
       c01b9b1d 00001000 01dae868 00000000 f7820200 00000000 c01d77f2 00000000 
Call Trace:
 [<c01b9b1d>] ? __getblk+0x1f/0x251
 [<c01d77f2>] ? ext3_getblk+0xe/0x190
 [<c01d7833>] ? ext3_getblk+0x4f/0x190
 [<c01d7885>] ? ext3_getblk+0xa1/0x190
 [<c01dbaa5>] ? htree_dirblock_to_tree+0xe/0x126
 [<c01d85f3>] ? ext3_bread+0x19/0x78
 [<c01dbabb>] ? htree_dirblock_to_tree+0x24/0x126
 [<c01dbc1a>] ? ext3_htree_fill_tree+0x5d/0x19a
 [<c011338f>] ? mcount+0x1f/0x23
 [<c01d4d23>] ? free_rb_tree_fname+0xe/0x7f
 [<c01d512d>] ? ext3_readdir+0x1d8/0x5ff
 [<c01a74c2>] ? filldir+0x0/0xc6
 [<c03d68be>] ? _cond_resched+0x8/0x34
 [<c011338f>] ? mcount+0x1f/0x23
 [<c03d68be>] ? _cond_resched+0x8/0x34
 [<c01a75de>] ? vfs_readdir+0x56/0x82
 [<c01a74c2>] ? filldir+0x0/0xc6
 [<c01a7842>] ? sys_getdents+0x64/0xa2
 [<c0102c44>] ? sysenter_past_esp+0x79/0x7d
 =======================
Code: 89 c7 89 55 c4 89 4d c8 9c fa 64 a1 00 31 57 c0 8d 80 80 42 57 c0 0f ba 20 00 19 d2 9d 83 fa 01 19 c0 25 00 02 00 00 85 c0 75 04 <0f> 0b eb fe b8 00 c6 7a c0 e8 3e 8e f8 ff 9c fa 64 a1 00 31 57 
EIP: [<c01b996a>] __find_get_block+0x39/0x1cd SS:ESP 0068:f5f6bd48
I-pipe tracer log (100 points):
     #func                    0 ipipe_trace_panic_freeze+0x9 (oops_enter+0xd)
     #func                    0 oops_enter+0x8 (die+0x1a)
     #func                    0 die+0xe (do_trap+0x8f)
     #func                   -2 search_module_extables+0xa (search_exception_tables+0x27)
     #func                   -3 search_extable+0x9 (search_exception_tables+0x1c)
     #func                   -3 search_exception_tables+0x9 (fixup_exception+0x13)
     #func                   -4 fixup_exception+0x9 (do_trap+0x70)
     #func                   -4 do_trap+0xe (do_invalid_op+0x71)
     #func                   -5 kprobe_exceptions_notify+0xe (notifier_call_chain+0x30)
     #func                   -6 notifier_call_chain+0xe (__atomic_notifier_call_chain+0x16)
     #func                   -6 __atomic_notifier_call_chain+0x8 (atomic_notifier_call_chain+0x11)
     #func                   -6 atomic_notifier_call_chain+0x8 (notify_die+0x32)
     #func                   -7 notify_die+0xb (do_invalid_op+0x48)
     #func                   -7 do_invalid_op+0xd (__ipipe_handle_exception+0x16b)
     #func                   -8 __ipipe_handle_exception+0xe (error_code+0x77)
     #func                   -8 __find_get_block+0xe (__getblk+0x1f)
     #func                   -9 __getblk+0xe (ext3_getblk+0xa1)
     #func                  -10 ext3_get_branch+0xe (ext3_get_blocks_handle+0x82)
     #func                  -10 ext3_block_to_path+0xe (ext3_get_blocks_handle+0x58)
     #func                  -11 ext3_get_blocks_handle+0x11 (ext3_getblk+0x4f)
     #func                  -11 ext3_getblk+0xe (ext3_bread+0x19)
     #func                  -12 ext3_bread+0xd (htree_dirblock_to_tree+0x24)
     #func                  -12 htree_dirblock_to_tree+0xe (ext3_htree_fill_tree+0x5d)
     #func                  -13 ext3_htree_fill_tree+0xe (ext3_readdir+0x1d8)
     #func                  -13 free_rb_tree_fname+0xe (ext3_readdir+0x1b4)
     #func                  -13 rb_first+0x8 (ext3_readdir+0x187)
     #func                  -14 __ipipe_restore_root+0x8 (kmem_cache_alloc+0x97)
     #func                  -15 ipipe_check_context+0x9 (kmem_cache_alloc+0x24)
     #func                  -15 kmem_cache_alloc+0xe (ext3_readdir+0x91)
     #func                  -16 ext3_readdir+0xe (vfs_readdir+0x56)
     #func                  -16 _cond_resched+0x8 (mutex_lock_killable+0x1a)
     #func                  -16 ipipe_check_context+0x9 (mutex_lock_killable+0x15)
     #func                  -16 mutex_lock_killable+0x9 (vfs_readdir+0x34)
     #func                  -17 vfs_readdir+0xe (sys_getdents+0x64)
     #func                  -17 fget+0xa (sys_getdents+0x38)
     #func                  -17 sys_getdents+0xe (sysenter_past_esp+0x79)
     #func                  -17 __ipipe_syscall_root+0xa (sysenter_past_esp+0x51)
 |   #end     0x8000000d    -28 __ipipe_unstall_iret_root+0x6f (sysenter_exit+0x0)
 |   #begin   0x80000000    -28 __ipipe_unstall_iret_root+0x1e (sysenter_exit+0x0)
     #func                  -28 __ipipe_unstall_iret_root+0x9 (sysenter_exit+0x0)
     #func                  -28 fput+0x8 (sys_fcntl64+0x64)
     #func                  -28 _spin_lock+0x8 (set_close_on_exec+0x26)
     #func                  -29 set_close_on_exec+0xb (do_fcntl+0xfc)
     #func                  -29 do_fcntl+0xe (sys_fcntl64+0x5a)
     #func                  -30 fget+0xa (sys_fcntl64+0x1b)
     #func                  -30 sys_fcntl64+0xb (sysenter_past_esp+0x79)
     #func                  -30 __ipipe_syscall_root+0xa (sysenter_past_esp+0x51)
 |   #end     0x8000000d    -31 __ipipe_unstall_iret_root+0x6f (sysenter_exit+0x0)
 |   #begin   0x80000000    -31 __ipipe_unstall_iret_root+0x1e (sysenter_exit+0x0)
     #func                  -31 __ipipe_unstall_iret_root+0x9 (sysenter_exit+0x0)
     #func                  -32 __copy_to_user_ll+0xa (copy_to_user+0x42)
     #func                  -32 _cond_resched+0x8 (copy_to_user+0x37)
     #func                  -32 ipipe_check_context+0x9 (copy_to_user+0x32)
     #func                  -32 copy_to_user+0xb (cp_new_stat64+0xf0)
     #func                  -33 cp_new_stat64+0xe (sys_fstat64+0x27)
     #func                  -33 fput+0x8 (vfs_fstat+0x33)
     #func                  -33 generic_fillattr+0xb (vfs_getattr+0x32)
     #func                  -33 vfs_getattr+0xb (vfs_fstat+0x2a)
     #func                  -34 fget+0xa (vfs_fstat+0x17)
     #func                  -34 vfs_fstat+0xb (sys_fstat64+0x19)
     #func                  -34 sys_fstat64+0xc (sysenter_past_esp+0x79)
     #func                  -35 __ipipe_syscall_root+0xa (sysenter_past_esp+0x51)
 |   #end     0x8000000d    -35 __ipipe_unstall_iret_root+0x6f (sysenter_exit+0x0)
 |   #begin   0x80000000    -36 __ipipe_unstall_iret_root+0x1e (sysenter_exit+0x0)
     #func                  -36 __ipipe_unstall_iret_root+0x9 (sysenter_exit+0x0)
     #func                  -36 __ipipe_restore_root+0x8 (kmem_cache_free+0xb5)
     #func                  -36 ipipe_check_context+0x9 (kmem_cache_free+0x43)
     #func                  -37 kmem_cache_free+0xe (do_sys_open+0xb6)
     #func                  -37 _spin_lock+0x8 (fd_install+0x26)
     #func                  -37 fd_install+0xb (do_sys_open+0xa6)
     #func                  -37 inotify_inode_queue_event+0xe (do_sys_open+0x9c)
     #func                  -37 inotify_dentry_parent_queue_event+0xe (do_sys_open+0x8d)
     #func                  -38 file_ra_state_init+0x8 (__dentry_open+0x123)
     #func                  -39 _spin_lock+0x8 (file_move+0x1c)
     #func                  -39 file_move+0xa (__dentry_open+0xe5)
     #func                  -39 __dentry_open+0xe (nameidata_to_filp+0x24)
     #func                  -39 nameidata_to_filp+0xa (do_filp_open+0x317)
     #func                  -40 generic_permission+0xb (ext3_permission+0x12)
     #func                  -40 ext3_permission+0x8 (permission+0x8d)
     #func                  -40 permission+0xe (vfs_permission+0x15)
     #func                  -40 vfs_permission+0x8 (may_open+0x95)
     #func                  -41 may_open+0xe (do_filp_open+0x2f4)
     #func                  -42 _atomic_dec_and_lock+0xa (mntput_no_expire+0x1d)
     #func                  -42 mntput_no_expire+0xe (path_put+0x25)
     #func                  -42 _atomic_dec_and_lock+0xa (dput+0x33)
     #func                  -42 dput+0x9 (path_put+0x13)
     #func                  -42 path_put+0x9 (path_walk+0x6e)
     #func                  -43 _atomic_dec_and_lock+0xa (dput+0x33)
     #func                  -43 dput+0x9 (__link_path_walk+0x997)
     #func                  -44 __follow_mount+0xb (do_lookup+0x54)
     #func                  -44 memcmp+0xa (__d_lookup+0xa0)
     #func                  -44 _spin_lock+0x8 (__d_lookup+0x67)
     #func                  -44 __d_lookup+0xe (do_lookup+0x2a)
     #func                  -45 do_lookup+0xe (__link_path_walk+0x6eb)
     #func                  -45 generic_permission+0xb (ext3_permission+0x12)
     #func                  -45 ext3_permission+0x8 (permission+0x8d)
     #func                  -46 permission+0xe (vfs_permission+0x15)
     #func                  -46 vfs_permission+0x8 (__link_path_walk+0x117)
     #func                  -46 _atomic_dec_and_lock+0xa (dput+0x33)
     #func                  -46 dput+0x9 (__link_path_walk+0x556)
---[ end trace 95793bdff26e224f ]---

--------------010905010903030702080102
Content-Type: text/plain;
 name="bug27.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="bug27.txt"

Linux version 2.6.27-gentoo-r8-xenomai (root@domain.hid) (gcc version 4.1.2 (Gentoo 4.1.2 p1.1)) #8 PREEMPT Tue Feb 17 19:38:11 CET 2009
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009f000 (usable)
 BIOS-e820: 000000000009f000 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000d2000 - 00000000000d4000 (reserved)
 BIOS-e820: 00000000000dc000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000001fee0000 (usable)
 BIOS-e820: 000000001fee0000 - 000000001fef5000 (ACPI data)
 BIOS-e820: 000000001fef5000 - 000000001ff00000 (ACPI NVS)
 BIOS-e820: 000000001ff00000 - 0000000020000000 (reserved)
 BIOS-e820: 00000000e0000000 - 00000000f0000000 (reserved)
 BIOS-e820: 00000000f0008000 - 00000000f000c000 (reserved)
 BIOS-e820: 00000000fec00000 - 00000000fec10000 (reserved)
 BIOS-e820: 00000000fed14000 - 00000000fed1a000 (reserved)
 BIOS-e820: 00000000fed20000 - 00000000fed90000 (reserved)
 BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
 BIOS-e820: 00000000ff000000 - 0000000100000000 (reserved)
DMI present.
last_pfn = 0x1fee0 max_arch_pfn = 0x100000
kernel direct mapping tables up to 1fee0000 @ 7000-d000
ACPI: RSDP 000F6BF0, 0024 (r2 IBM   )
ACPI: XSDT 1FEE6FF2, 005C (r1 IBM    TP-76        1220  LTP        0)
ACPI: FACP 1FEE7100, 00F4 (r3 IBM    TP-76        1220 IBM         1)
ACPI Warning (tbfadt-0442): Optional field "Gpe1Block" has zero address or length: 000000000000102C/0 [20080609]
ACPI: DSDT 1FEE72E7, DB08 (r1 IBM    TP-76        1220 MSFT  100000E)
ACPI: FACS 1FEF6000, 0040
ACPI: SSDT 1FEE72B4, 0033 (r1 IBM    TP-76        1220 MSFT  100000E)
ACPI: ECDT 1FEF4DEF, 0052 (r1 IBM    TP-76        1220 IBM         1)
ACPI: TCPA 1FEF4E41, 0032 (r1 IBM    TP-76        1220 PTL         1)
ACPI: APIC 1FEF4E73, 005A (r1 IBM    TP-76        1220 IBM         1)
ACPI: MCFG 1FEF4ECD, 003E (r1 IBM    TP-76        1220 IBM         1)
ACPI: BOOT 1FEF4FD8, 0028 (r1 IBM    TP-76        1220  LTP        1)
510MB LOWMEM available.
  mapped low ram: 0 - 1fee0000
  low ram: 00000000 - 1fee0000
  bootmap 00001000 - 00004fdc
(6 early reservations) ==> bootmem [0000000000 - 001fee0000]
  #0 [0000000000 - 0000001000]   BIOS data page ==> [0000000000 - 0000001000]
  #1 [0000100000 - 0000753628]    TEXT DATA BSS ==> [0000100000 - 0000753628]
  #2 [0000754000 - 0000757000]    INIT_PG_TABLE ==> [0000754000 - 0000757000]
  #3 [000009f000 - 0000100000]    BIOS reserved ==> [000009f000 - 0000100000]
  #4 [0000007000 - 0000009000]          PGTABLE ==> [0000007000 - 0000009000]
  #5 [0000001000 - 0000005000]          BOOTMAP ==> [0000001000 - 0000005000]
Zone PFN ranges:
  DMA      0x00000000 -> 0x00001000
  Normal   0x00001000 -> 0x0001fee0
Movable zone start PFN for each node
early_node_map[2] active PFN ranges
    0: 0x00000000 -> 0x0000009f
    0: 0x00000100 -> 0x0001fee0
On node 0 totalpages: 130687
free_area_init_node: node 0, pgdat c069f060, node_mem_map c1000000
  DMA zone: 3967 pages, LIFO batch:0
  Normal zone: 125698 pages, LIFO batch:31
ACPI: PM-Timer IO Port: 0x1008
ACPI: Local APIC address 0xfee00000
ACPI: LAPIC (acpi_id[0x01] lapic_id[0x00] enabled)
ACPI: LAPIC_NMI (acpi_id[0x01] high edge lint[0x1])
ACPI: IOAPIC (id[0x01] address[0xfec00000] gsi_base[0])
IOAPIC[0]: apic_id 1, version 32, address 0xfec00000, GSI 0-23
ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
ACPI: IRQ0 used by override.
ACPI: IRQ2 used by override.
ACPI: IRQ9 used by override.
Enabling APIC mode:  Flat.  Using 1 I/O APICs
Using ACPI (MADT) for SMP configuration information
mapped APIC to ffffb000 (fee00000)
mapped IOAPIC to ffffa000 (fec00000)
PM: Registered nosave memory: 000000000009f000 - 00000000000a0000
PM: Registered nosave memory: 00000000000a0000 - 00000000000d2000
PM: Registered nosave memory: 00000000000d2000 - 00000000000d4000
PM: Registered nosave memory: 00000000000d4000 - 00000000000dc000
PM: Registered nosave memory: 00000000000dc000 - 0000000000100000
Allocating PCI resources starting at 30000000 (gap: 20000000:c0000000)
Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 129665
Kernel command line: root=/dev/sda3 vga=792
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Initializing CPU#0
PID hash table entries: 2048 (order: 11, 8192 bytes)
Extended CMOS year: 2000
TSC: PIT calibration confirmed by PMTIMER.
TSC: using PIT calibration value
Detected 1861.979 MHz processor.
I-pipe 2.1-02: pipeline enabled.
Console: colour dummy device 80x25
console [tty0] enabled
Dentry cache hash table entries: 65536 (order: 6, 262144 bytes)
Inode-cache hash table entries: 32768 (order: 5, 131072 bytes)
Memory: 511492k/523136k available (4328k kernel code, 11016k reserved, 1461k data, 260k init, 0k highmem)
virtual kernel memory layout:
    fixmap  : 0xfffb9000 - 0xfffff000   ( 280 kB)
    vmalloc : 0xe0800000 - 0xfffb7000   ( 503 MB)
    lowmem  : 0xc0000000 - 0xdfee0000   ( 510 MB)
      .init : 0xc06aa000 - 0xc06eb000   ( 260 kB)
      .data : 0xc053a3de - 0xc06a7a90   (1461 kB)
      .text : 0xc0100000 - 0xc053a3de   (4328 kB)
Checking if this processor honours the WP bit even in supervisor mode...Ok.
CPA: page pool initialized 1 of 1 pages preallocated
Calibrating delay loop (skipped), value calculated using timer frequency.. 3723.95 BogoMIPS (lpj=7447916)
Mount-cache hash table entries: 512
CPU: L1 I cache: 32K, L1 D cache: 32K
CPU: L2 cache: 2048K
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU: Intel(R) Pentium(R) M processor 1.86GHz stepping 08
Checking 'hlt' instruction... OK.
Freeing SMP alternatives: 0k freed
ACPI: Core revision 20080609
ENABLING IO-APIC IRQs
..TIMER: vector=0x31 apic1=0 pin1=2 apic2=-1 pin2=-1
net_namespace: 588 bytes
NET: Registered protocol family 16
ACPI: ACPI Dock Station Driver
ACPI: bus type pci registered
PCI: MCFG configuration 0: base e0000000 segment 0 buses 0 - 255
PCI: MCFG area at e0000000 reserved in E820
PCI: Using MMCONFIG for extended config space
PCI: Using configuration type 1 for base access
ACPI: EC: EC description table is found, configuring boot EC
ACPI: EC: non-query interrupt received, switching to interrupt mode
ACPI: Interpreter enabled
ACPI: (supports S0 S3 S4 S5)
ACPI: Using IOAPIC for interrupt routing
ACPI: EC: GPE = 0x1c, I/O: command/status = 0x66, data = 0x62
ACPI: EC: driver started in interrupt mode
ACPI: PCI Root Bridge [PCI0] (0000:00)
pci 0000:00:01.0: PME# supported from D0 D3hot D3cold
pci 0000:00:01.0: PME# disabled
pci 0000:00:1c.0: PME# supported from D0 D3hot D3cold
pci 0000:00:1c.0: PME# disabled
pci 0000:00:1c.2: PME# supported from D0 D3hot D3cold
pci 0000:00:1c.2: PME# disabled
PCI: 0000:00:1d.0 reg 20 io port: [1800, 181f]
PCI: 0000:00:1d.1 reg 20 io port: [1820, 183f]
PCI: 0000:00:1d.2 reg 20 io port: [1840, 185f]
PCI: 0000:00:1d.3 reg 20 io port: [1860, 187f]
PCI: 0000:00:1d.7 reg 10 32bit mmio: [a8000000, a80003ff]
pci 0000:00:1d.7: PME# supported from D0 D3hot D3cold
pci 0000:00:1d.7: PME# disabled
PCI: 0000:00:1e.2 reg 10 io port: [1c00, 1cff]
PCI: 0000:00:1e.2 reg 14 io port: [1880, 18bf]
PCI: 0000:00:1e.2 reg 18 32bit mmio: [a8000800, a80009ff]
PCI: 0000:00:1e.2 reg 1c 32bit mmio: [a8000400, a80004ff]
pci 0000:00:1e.2: PME# supported from D0 D3hot D3cold
pci 0000:00:1e.2: PME# disabled
PCI: 0000:00:1e.3 reg 10 io port: [2400, 24ff]
PCI: 0000:00:1e.3 reg 14 io port: [2000, 207f]
pci 0000:00:1e.3: PME# supported from D0 D3hot D3cold
pci 0000:00:1e.3: PME# disabled
pci 0000:00:1f.0: Force enabled HPET at 0xfed00000
pci 0000:00:1f.0: quirk: region 1000-107f claimed by ICH6 ACPI/GPIO/TCO
pci 0000:00:1f.0: quirk: region 1180-11bf claimed by ICH6 GPIO
PCI: 0000:00:1f.2 reg 10 io port: [0, 7]
PCI: 0000:00:1f.2 reg 14 io port: [0, 3]
PCI: 0000:00:1f.2 reg 18 io port: [0, 7]
PCI: 0000:00:1f.2 reg 1c io port: [0, 3]
PCI: 0000:00:1f.2 reg 20 io port: [18c0, 18cf]
pci 0000:00:1f.2: PME# supported from D3hot
pci 0000:00:1f.2: PME# disabled
PCI: 0000:00:1f.3 reg 20 io port: [18e0, 18ff]
PCI: 0000:01:00.0 reg 10 32bit mmio: [c0000000, c7ffffff]
PCI: 0000:01:00.0 reg 14 io port: [3000, 30ff]
PCI: 0000:01:00.0 reg 18 32bit mmio: [a8100000, a810ffff]
PCI: 0000:01:00.0 reg 30 32bit mmio: [0, 1ffff]
pci 0000:01:00.0: supports D1
pci 0000:01:00.0: supports D2
PCI: bridge 0000:00:01.0 io port: [3000, 3fff]
PCI: bridge 0000:00:01.0 32bit mmio: [a8100000, a81fffff]
PCI: bridge 0000:00:01.0 32bit mmio pref: [c0000000, c7ffffff]
PCI: 0000:02:00.0 reg 10 64bit mmio: [a8200000, a820ffff]
pci 0000:02:00.0: PME# supported from D3hot D3cold
pci 0000:02:00.0: PME# disabled
PCI: bridge 0000:00:1c.0 32bit mmio: [a8200000, a82fffff]
PCI: bridge 0000:00:1c.2 io port: [4000, 4fff]
PCI: bridge 0000:00:1c.2 32bit mmio: [a8300000, a83fffff]
PCI: bridge 0000:00:1c.2 64bit mmio pref: [c8000000, c80fffff]
PCI: 0000:04:00.0 reg 10 32bit mmio: [a8400000, a8400fff]
pci 0000:04:00.0: supports D1
pci 0000:04:00.0: supports D2
pci 0000:04:00.0: PME# supported from D0 D1 D2 D3hot D3cold
pci 0000:04:00.0: PME# disabled
PCI: 0000:04:00.1 reg 10 32bit mmio: [b1000000, b10007ff]
pci 0000:04:00.1: PME# supported from D0 D3hot D3cold
pci 0000:04:00.1: PME# disabled
PCI: 0000:04:02.0 reg 10 32bit mmio: [a8401000, a8401fff]
pci 0000:04:02.0: PME# supported from D0 D3hot D3cold
pci 0000:04:02.0: PME# disabled
pci 0000:00:1e.0: transparent bridge
PCI: bridge 0000:00:1e.0 io port: [5000, 8fff]
PCI: bridge 0000:00:1e.0 32bit mmio: [a8400000, b7ffffff]
PCI: bridge 0000:00:1e.0 64bit mmio pref: [d0000000, d7ffffff]
bus 00 -> node 0
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.AGP_._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.EXP0._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.EXP2._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PCI1._PRT]
ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 7 9 10 *11)
ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 7 9 10 *11)
ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 6 7 9 10 *11)
ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 6 7 9 10 *11)
ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 6 7 9 10 *11)
ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 6 7 9 10 *11)
ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 5 6 7 9 10 *11)
ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 5 6 7 9 10 *11)
ACPI: Power Resource [PUBS] (on)
Linux Plug and Play Support v0.97 (c) Adam Belay
pnp: PnP ACPI init
ACPI: bus type pnp registered
pnp: PnP ACPI: found 14 devices
ACPI: ACPI bus type pnp unregistered
SCSI subsystem initialized
libata version 3.00 loaded.
usbcore: registered new interface driver usbfs
usbcore: registered new interface driver hub
usbcore: registered new device driver usb
dca service started, version 1.4
PCI: Using ACPI for IRQ routing
hpet clockevent registered
hpet0: at MMIO 0xfed00000, IRQs 2, 8, 0
hpet0: 3 64-bit timers, 14318180 Hz
system 00:00: iomem range 0x0-0x9ffff could not be reserved
system 00:00: iomem range 0xc0000-0xc3fff could not be reserved
system 00:00: iomem range 0xc4000-0xc7fff could not be reserved
system 00:00: iomem range 0xc8000-0xcbfff could not be reserved
system 00:00: iomem range 0xcc000-0xcffff could not be reserved
system 00:00: iomem range 0xd0000-0xd3fff could not be reserved
system 00:00: iomem range 0xdc000-0xdffff could not be reserved
system 00:00: iomem range 0xe0000-0xe3fff could not be reserved
system 00:00: iomem range 0xe4000-0xe7fff could not be reserved
system 00:00: iomem range 0xe8000-0xebfff could not be reserved
system 00:00: iomem range 0xec000-0xeffff could not be reserved
system 00:00: iomem range 0xf0000-0xfffff could not be reserved
system 00:00: iomem range 0x100000-0x1fffffff could not be reserved
system 00:00: iomem range 0xfec00000-0xffffffff could not be reserved
system 00:02: ioport range 0x1000-0x107f has been reserved
system 00:02: ioport range 0x1180-0x11bf has been reserved
system 00:02: ioport range 0x15e0-0x15ef has been reserved
system 00:02: ioport range 0x1600-0x1641 has been reserved
system 00:02: ioport range 0x1644-0x167f has been reserved
system 00:02: iomem range 0xe0000000-0xefffffff could not be reserved
system 00:02: iomem range 0xf0008000-0xf000bfff could not be reserved
system 00:02: iomem range 0xfed14000-0xfed17fff could not be reserved
system 00:02: iomem range 0xfed18000-0xfed18fff could not be reserved
system 00:02: iomem range 0xfed19000-0xfed19fff could not be reserved
pci 0000:00:01.0: PCI bridge, secondary bus 0000:01
pci 0000:00:01.0:   IO window: 0x3000-0x3fff
pci 0000:00:01.0:   MEM window: 0xa8100000-0xa81fffff
pci 0000:00:01.0:   PREFETCH window: 0x000000c0000000-0x000000c7ffffff
pci 0000:00:1c.0: PCI bridge, secondary bus 0000:02
pci 0000:00:1c.0:   IO window: disabled
pci 0000:00:1c.0:   MEM window: 0xa8200000-0xa82fffff
pci 0000:00:1c.0:   PREFETCH window: disabled
pci 0000:00:1c.2: PCI bridge, secondary bus 0000:03
pci 0000:00:1c.2:   IO window: 0x4000-0x4fff
pci 0000:00:1c.2:   MEM window: 0xa8300000-0xa83fffff
pci 0000:00:1c.2:   PREFETCH window: 0x000000c8000000-0x000000c80fffff
pci 0000:04:00.0: CardBus bridge, secondary bus 0000:05
pci 0000:04:00.0:   IO window: 0x005000-0x0050ff
pci 0000:04:00.0:   IO window: 0x005400-0x0054ff
pci 0000:04:00.0:   PREFETCH window: 0xd0000000-0xd3ffffff
pci 0000:04:00.0:   MEM window: 0xac000000-0xafffffff
pci 0000:00:1e.0: PCI bridge, secondary bus 0000:04
pci 0000:00:1e.0:   IO window: 0x5000-0x8fff
pci 0000:00:1e.0:   MEM window: 0xa8400000-0xb7ffffff
pci 0000:00:1e.0:   PREFETCH window: 0x000000d0000000-0x000000d7ffffff
pci 0000:00:01.0: PCI INT A -> GSI 16 (level, low) -> IRQ 16
pci 0000:00:01.0: setting latency timer to 64
pci 0000:00:1c.0: PCI INT A -> GSI 20 (level, low) -> IRQ 20
pci 0000:00:1c.0: setting latency timer to 64
pci 0000:00:1c.2: PCI INT C -> GSI 22 (level, low) -> IRQ 22
pci 0000:00:1c.2: setting latency timer to 64
pci 0000:00:1e.0: setting latency timer to 64
pci 0000:04:00.0: PCI INT A -> GSI 16 (level, low) -> IRQ 16
bus: 00 index 0 io port: [0, ffff]
bus: 00 index 1 mmio: [0, ffffffff]
bus: 01 index 0 io port: [3000, 3fff]
bus: 01 index 1 mmio: [a8100000, a81fffff]
bus: 01 index 2 mmio: [c0000000, c7ffffff]
bus: 01 index 3 mmio: [0, 0]
bus: 02 index 0 mmio: [0, 0]
bus: 02 index 1 mmio: [a8200000, a82fffff]
bus: 02 index 2 mmio: [0, 0]
bus: 02 index 3 mmio: [0, 0]
bus: 03 index 0 io port: [4000, 4fff]
bus: 03 index 1 mmio: [a8300000, a83fffff]
bus: 03 index 2 mmio: [c8000000, c80fffff]
bus: 03 index 3 mmio: [0, 0]
bus: 04 index 0 io port: [5000, 8fff]
bus: 04 index 1 mmio: [a8400000, b7ffffff]
bus: 04 index 2 mmio: [d0000000, d7ffffff]
bus: 04 index 3 io port: [0, ffff]
bus: 04 index 4 mmio: [0, ffffffff]
bus: 05 index 0 io port: [5000, 50ff]
bus: 05 index 1 io port: [5400, 54ff]
bus: 05 index 2 mmio: [d0000000, d3ffffff]
bus: 05 index 3 mmio: [ac000000, afffffff]
NET: Registered protocol family 2
IP route cache hash table entries: 4096 (order: 2, 16384 bytes)
TCP established hash table entries: 16384 (order: 5, 131072 bytes)
TCP bind hash table entries: 16384 (order: 4, 65536 bytes)
TCP: Hash tables configured (established 16384 bind 16384)
TCP reno registered
NET: Registered protocol family 1
Simple Boot Flag at 0x35 set to 0x1
Machine check exception polling timer started.
audit: initializing netlink socket (disabled)
type=2000 audit(1234911984.164:1): initialized
I-pipe: Domain Xenomai registered.
Xenomai: hal/i386 started.
Xenomai: real-time nucleus v2.4.6 (Bamboo) loaded.
Xenomai: SMI-enabled chipset found, but SMI workaround disabled
         (check CONFIG_XENO_HW_SMI_WORKAROUND). You may encounter
         high interrupt latencies!
Xenomai: starting native API services.
Xenomai: starting POSIX services.
Xenomai: starting RTDM services.
Installing knfsd (copyright (C) 1996 okir@domain.hid).
msgmni has been set to 999
io scheduler noop registered
io scheduler anticipatory registered
io scheduler deadline registered
io scheduler cfq registered (default)
pci 0000:01:00.0: Boot video device
lp: driver loaded but no devices found
radeonfb 0000:01:00.0: power state changed by ACPI to D0
radeonfb 0000:01:00.0: PCI INT A -> GSI 16 (level, low) -> IRQ 16
radeonfb: Retrieved PLL infos from BIOS
radeonfb: Reference=27.00 MHz (RefDiv=6) Memory=300.00 Mhz, System=230.00 MHz
radeonfb: PLL min 20000 max 40000
Non-DDC laptop panel detected
radeonfb: Monitor 1 type LCD found
radeonfb: Monitor 2 type no found
radeonfb: panel ID string: Samsung LTN150P1-L02    
radeonfb: detected LVDS panel size from BIOS: 1400x1050
radeondb: BIOS provided dividers will be used
radeonfb: Dynamic Clock Power Management enabled
fbcon: ATI Radeon 5460 (fb0) is primary device
Console: switching to colour frame buffer device 175x65
radeonfb (0000:01:00.0): ATI Radeon 5460 "T`"
ACPI: AC Adapter [AC] (on-line)
ACPI: Battery Slot [BAT0] (battery present)
input: Power Button (FF) as /devices/LNXSYSTM:00/LNXPWRBN:00/input/input0
ACPI: Power Button (FF) [PWRF]
input: Lid Switch as /devices/LNXSYSTM:00/device:00/PNP0C0D:00/input/input1
ACPI: Lid Switch [LID]
input: Sleep Button (CM) as /devices/LNXSYSTM:00/device:00/PNP0C0E:00/input/input2
ACPI: Sleep Button (CM) [SLPB]
Serial: 8250/16550 driver4 ports, IRQ sharing disabled
serial 00:0a: activated
00:0a: ttyS0 at I/O 0x3f8 (irq = 4) is a NS16550A
serial 0000:00:1e.3: PCI INT B -> GSI 23 (level, low) -> IRQ 23
serial 0000:00:1e.3: PCI INT B disabled
parport_pc 00:0b: reported by Plug and Play ACPI
parport0: PC-style at 0x3bc, irq 7 [PCSPP,TRISTATE]
lp0: using parport0 (interrupt-driven).
loop: module loaded
Intel(R) PRO/1000 Network Driver - version 7.3.20-k3-NAPI
Copyright (c) 1999-2006 Intel Corporation.
tg3.c:v3.94 (August 14, 2008)
tg3 0000:02:00.0: PCI INT A -> GSI 16 (level, low) -> IRQ 16
tg3 0000:02:00.0: setting latency timer to 64
eth0: Tigon3 [partno(BCM95751M) rev 4101 PHY(5750)] (PCI Express) 10/100/1000Base-T Ethernet 00:0a:e4:c5:98:e8
eth0: RXcsums[1] LinkChgREG[0] MIirq[0] ASF[0] WireSpeed[1] TSOcap[1]
eth0: dma_rwctrl[76180000] dma_mask[64-bit]
QLogic Fibre Channel HBA Driver: 8.02.01-k7
Driver 'sd' needs updating - please use bus_type methods
Driver 'sr' needs updating - please use bus_type methods
ata_piix 0000:00:1f.2: version 2.12
ata_piix 0000:00:1f.2: MAP [ P0 P2 IDE IDE ]
ata_piix 0000:00:1f.2: setting latency timer to 64
scsi0 : ata_piix
scsi1 : ata_piix
ata1: SATA max UDMA/133 cmd 0x1f0 ctl 0x3f6 bmdma 0x18c0 irq 14
ata2: PATA max UDMA/100 cmd 0x170 ctl 0x376 bmdma 0x18c8 irq 15
Switched to high resolution mode on CPU 0
ata1.00: ATA-6: FUJITSU MHV2060AH, 00840096, max UDMA/100
ata1.00: 117210240 sectors, multi 16: LBA 
ata1.00: applying bridge limits
ata1.00: configured for UDMA/100
ata2.00: ATAPI: MATSHITADVD-RAM UJ-830Sx, 1.00, max UDMA/33
ata2.00: configured for UDMA/33
scsi 0:0:0:0: Direct-Access     ATA      FUJITSU MHV2060A 0084 PQ: 0 ANSI: 5
sd 0:0:0:0: [sda] 117210240 512-byte hardware sectors (60012 MB)
sd 0:0:0:0: [sda] Write Protect is off
sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
sd 0:0:0:0: [sda] 117210240 512-byte hardware sectors (60012 MB)
sd 0:0:0:0: [sda] Write Protect is off
sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
 sda: sda1 sda2 sda3 sda4
sd 0:0:0:0: [sda] Attached SCSI disk
sd 0:0:0:0: Attached scsi generic sg0 type 0
scsi 1:0:0:0: CD-ROM            MATSHITA DVD-RAM UJ-830Sx 1.00 PQ: 0 ANSI: 5
sr0: scsi3-mmc drive: 24x/24x writer dvd-ram cd/rw xa/form2 cdda tray
Uniform CD-ROM driver Revision: 3.20
sr 1:0:0:0: Attached scsi CD-ROM sr0
sr 1:0:0:0: Attached scsi generic sg1 type 5
ehci_hcd 0000:00:1d.7: power state changed by ACPI to D0
ehci_hcd 0000:00:1d.7: PCI INT D -> GSI 19 (level, low) -> IRQ 19
ehci_hcd 0000:00:1d.7: setting latency timer to 64
ehci_hcd 0000:00:1d.7: EHCI Host Controller
ehci_hcd 0000:00:1d.7: new USB bus registered, assigned bus number 1
ehci_hcd 0000:00:1d.7: debug port 1
ehci_hcd 0000:00:1d.7: cache line size of 32 is not supported
ehci_hcd 0000:00:1d.7: irq 19, io mem 0xa8000000
ehci_hcd 0000:00:1d.7: USB 2.0 started, EHCI 1.00, driver 10 Dec 2004
usb usb1: configuration #1 chosen from 1 choice
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 8 ports detected
usb usb1: New USB device found, idVendor=1d6b, idProduct=0002
usb usb1: New USB device strings: Mfr=3, Product=2, SerialNumber=1
usb usb1: Product: EHCI Host Controller
usb usb1: Manufacturer: Linux 2.6.27-gentoo-r8-xenomai ehci_hcd
usb usb1: SerialNumber: 0000:00:1d.7
USB Universal Host Controller Interface driver v3.0
uhci_hcd 0000:00:1d.0: power state changed by ACPI to D0
uhci_hcd 0000:00:1d.0: PCI INT A -> GSI 16 (level, low) -> IRQ 16
uhci_hcd 0000:00:1d.0: setting latency timer to 64
uhci_hcd 0000:00:1d.0: UHCI Host Controller
uhci_hcd 0000:00:1d.0: new USB bus registered, assigned bus number 2
uhci_hcd 0000:00:1d.0: irq 16, io base 0x00001800
usb usb2: configuration #1 chosen from 1 choice
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 2 ports detected
usb usb2: New USB device found, idVendor=1d6b, idProduct=0001
usb usb2: New USB device strings: Mfr=3, Product=2, SerialNumber=1
usb usb2: Product: UHCI Host Controller
usb usb2: Manufacturer: Linux 2.6.27-gentoo-r8-xenomai uhci_hcd
usb usb2: SerialNumber: 0000:00:1d.0
uhci_hcd 0000:00:1d.1: power state changed by ACPI to D0
uhci_hcd 0000:00:1d.1: PCI INT B -> GSI 17 (level, low) -> IRQ 17
uhci_hcd 0000:00:1d.1: setting latency timer to 64
uhci_hcd 0000:00:1d.1: UHCI Host Controller
uhci_hcd 0000:00:1d.1: new USB bus registered, assigned bus number 3
uhci_hcd 0000:00:1d.1: irq 17, io base 0x00001820
usb usb3: configuration #1 chosen from 1 choice
hub 3-0:1.0: USB hub found
hub 3-0:1.0: 2 ports detected
usb usb3: New USB device found, idVendor=1d6b, idProduct=0001
usb usb3: New USB device strings: Mfr=3, Product=2, SerialNumber=1
usb usb3: Product: UHCI Host Controller
usb usb3: Manufacturer: Linux 2.6.27-gentoo-r8-xenomai uhci_hcd
usb usb3: SerialNumber: 0000:00:1d.1
uhci_hcd 0000:00:1d.2: PCI INT C -> GSI 18 (level, low) -> IRQ 18
uhci_hcd 0000:00:1d.2: setting latency timer to 64
uhci_hcd 0000:00:1d.2: UHCI Host Controller
uhci_hcd 0000:00:1d.2: new USB bus registered, assigned bus number 4
uhci_hcd 0000:00:1d.2: irq 18, io base 0x00001840
usb usb4: configuration #1 chosen from 1 choice
hub 4-0:1.0: USB hub found
hub 4-0:1.0: 2 ports detected
usb usb4: New USB device found, idVendor=1d6b, idProduct=0001
usb usb4: New USB device strings: Mfr=3, Product=2, SerialNumber=1
usb usb4: Product: UHCI Host Controller
usb usb4: Manufacturer: Linux 2.6.27-gentoo-r8-xenomai uhci_hcd
usb usb4: SerialNumber: 0000:00:1d.2
uhci_hcd 0000:00:1d.3: PCI INT D -> GSI 19 (level, low) -> IRQ 19
uhci_hcd 0000:00:1d.3: setting latency timer to 64
uhci_hcd 0000:00:1d.3: UHCI Host Controller
uhci_hcd 0000:00:1d.3: new USB bus registered, assigned bus number 5
uhci_hcd 0000:00:1d.3: irq 19, io base 0x00001860
usb usb5: configuration #1 chosen from 1 choice
hub 5-0:1.0: USB hub found
hub 5-0:1.0: 2 ports detected
usb 4-1: new full speed USB device using uhci_hcd and address 2
usb usb5: New USB device found, idVendor=1d6b, idProduct=0001
usb usb5: New USB device strings: Mfr=3, Product=2, SerialNumber=1
usb usb5: Product: UHCI Host Controller
usb usb5: Manufacturer: Linux 2.6.27-gentoo-r8-xenomai uhci_hcd
usb usb5: SerialNumber: 0000:00:1d.3
usb 4-1: configuration #1 chosen from 1 choice
usb 4-1: New USB device found, idVendor=0a5c, idProduct=201e
usb 4-1: New USB device strings: Mfr=1, Product=2, SerialNumber=0
usb 4-1: Product: IBM Bluetooth Module
usb 4-1: Manufacturer: Broadcom
usb 4-2: new full speed USB device using uhci_hcd and address 3
usb 4-2: configuration #1 chosen from 1 choice
usb 4-2: New USB device found, idVendor=0483, idProduct=2016
usb 4-2: New USB device strings: Mfr=1, Product=2, SerialNumber=0
usb 4-2: Product: Biometric Coprocessor
usb 4-2: Manufacturer: STMicroelectronics
usbcore: registered new interface driver usblp
Initializing USB Mass Storage driver...
usbcore: registered new interface driver usb-storage
USB Mass Storage support registered.
PNP: PS/2 Controller [PNP0303:KBD,PNP0f13:MOU] at 0x60,0x64 irq 1,12
serio: i8042 KBD port at 0x60,0x64 irq 1
serio: i8042 AUX port at 0x60,0x64 irq 12
mice: PS/2 mouse device common for all mice
input: AT Translated Set 2 keyboard as /devices/platform/i8042/serio0/input/input3
hdaps: supported laptop not found!
hdaps: driver init failed (ret=-19)!
device-mapper: ioctl: 4.14.0-ioctl (2008-04-23) initialised: dm-devel@domain.hid
cpuidle: using governor ladder
cpuidle: using governor menu
usbcore: registered new interface driver usbhid
usbhid: v2.6:USB HID core driver
Advanced Linux Sound Architecture Driver Version 1.0.17.
Intel ICH 0000:00:1e.2: PCI INT A -> GSI 22 (level, low) -> IRQ 22
Intel ICH 0000:00:1e.2: setting latency timer to 64
Synaptics Touchpad, model: 1, fw: 5.9, id: 0x2c6ab1, caps: 0x884793/0x0
serio: Synaptics pass-through port at isa0060/serio1/input0
input: SynPS/2 Synaptics TouchPad as /devices/platform/i8042/serio1/input/input4
intel8x0_measure_ac97_clock: measured 55558 usecs
intel8x0: clocking to 48000
ALSA device list:
  #0: Intel ICH6 with AD1981B at irq 22
ip_tables: (C) 2000-2006 Netfilter Core Team
TCP cubic registered
NET: Registered protocol family 17
RPC: Registered udp transport module.
RPC: Registered tcp transport module.
ieee80211: 802.11 data/management/control stack, git-1.1.13
ieee80211: Copyright (C) 2004-2005 Intel Corporation <jketreno@domain.hid>
ieee80211_crypt: registered algorithm 'NULL'
ieee80211_crypt: registered algorithm 'WEP'
Using IPI Shortcut mode
IBM TrackPoint firmware: 0x0e, buttons: 3/3
input: TPPS/2 IBM TrackPoint as /devices/platform/i8042/serio1/serio2/input/input5
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
Freeing unused kernel memory: 260k freed
input: Video Bus as /devices/LNXSYSTM:00/device:00/PNP0A08:00/device:03/device:04/input/input6
ACPI: Video Device [VID] (multi-head: yes  rom: no  post: no)
Linux agpgart interface v0.103
Yenta: CardBus bridge found at 0000:04:00.0 [1014:0532]
ipw2200: Intel(R) PRO/Wireless 2200/2915 Network Driver, 1.2.2k
ipw2200: Copyright(c) 2003-2006 Intel Corporation
Yenta: ISA IRQ mask 0x0c38, PCI irq 16
Socket status: 30000006
pcmcia: parent PCI bridge I/O window: 0x5000 - 0x8fff
pcmcia: parent PCI bridge Memory window: 0xa8400000 - 0xb7ffffff
pcmcia: parent PCI bridge Memory window: 0xd0000000 - 0xd7ffffff
ipw2200 0000:04:02.0: PCI INT A -> GSI 21 (level, low) -> IRQ 21
ipw2200: Detected Intel PRO/Wireless 2915ABG Network Connection
firmware: requesting ipw2200-bss.fw
ipw2200: ipw2200-bss.fw request_firmware failed: Reason -2
ipw2200: Unable to load firmware: -2
ipw2200: failed to register network device
ipw2200 0000:04:02.0: PCI INT A disabled
ipw2200: probe of 0000:04:02.0 failed with error -5
EXT3 FS on sda3, internal journal
Non-volatile memory driver v1.2
thinkpad_acpi: ThinkPad ACPI Extras v0.21
thinkpad_acpi: http://ibm-acpi.sf.net/
thinkpad_acpi: ThinkPad BIOS 76ET62WW (1.22 ), EC 76HT14WW-1.04
thinkpad_acpi: IBM ThinkPad    , model 1846AQG
Registered led device: tpacpi::thinklight
Registered led device: tpacpi::power
Registered led device: tpacpi:orange:batt
Registered led device: tpacpi:green:batt
Registered led device: tpacpi::dock_active
Registered led device: tpacpi::bay_active
Registered led device: tpacpi::dock_batt
Registered led device: tpacpi::unknown_led
Registered led device: tpacpi::standby
thinkpad_acpi: fan_init: initial fan status is unknown, assuming it is in auto mode
input: ThinkPad Extra Buttons as /devices/virtual/input/input7
fuse init (API version 7.9)
Adding 1020592k swap on /dev/sda4.  Priority:-1 extents:1 across:1020592k
thinkpad_acpi: setting the hotkey mask to 0x0000ffff is likely not the best way to go about it
thinkpad_acpi: please consider using the driver defaults, and refer to up-to-date thinkpad-acpi documentation
------------[ cut here ]------------
kernel BUG at fs/buffer.c:1289!
invalid opcode: 0000 [#1] PREEMPT 
Modules linked in: fuse thinkpad_acpi rfkill led_class nvram ipw2200 yenta_socket intel_agp rsrc_nonstatic agpgart evdev video

Pid: 5530, comm: emerge Not tainted (2.6.27-gentoo-r8-xenomai #8)
EIP: 0060:[<c01c8b27>] EFLAGS: 00210296 CPU: 0
EIP is at __find_get_block+0x187/0x1b0
EAX: ffffffff EBX: 00000001 ECX: 00000000 EDX: 002848a0
ESI: 00000000 EDI: 002848a0 EBP: 00000000 ESP: de0efc40
 DS: 007b ES: 007b FS: 0000 GS: 0033 SS: 0068
Process emerge (pid: 5530, ti=de0ee000 task=df182af0 task.ti=de0ee000)<0>
I-pipe domain Linux
Stack: df402900 df106130 c02bde96 de0efc68 c02bed95 00000001 df106130 df7eb89c 
       002848a0 00000001 00000000 df7eb924 00000000 c01c8b73 00001000 00000000 
       000000d0 df8c8840 de0efcb4 002848a0 00000000 df402900 df34b5c0 00000000 
Call Trace:
 [<c02bde96>] elv_insert+0x156/0x220
 [<c02bed95>] drive_stat_acct+0x105/0x110
 [<c01c8b73>] __getblk+0x23/0x2a0
 [<c01ef819>] ext3_getblk+0xb9/0x1d0
 [<c01f31e5>] ext3_find_entry+0x215/0x640
 [<c02c0fbb>] submit_bio+0x6b/0xf0
 [<c0157f73>] __ipipe_dispatch_wired+0xa3/0xe0
 [<c011400d>] __ipipe_handle_irq+0x8d/0x1e0
 [<c011b0d8>] finish_task_switch+0x28/0x90
 [<c01b79ac>] dput+0x1c/0x160
 [<c01bd1a3>] mntput_no_expire+0x13/0xf0
 [<c01af479>] __link_path_walk+0x309/0xc80
 [<c01f4e5e>] ext3_lookup+0x3e/0xd0
 [<c01b83ab>] d_alloc+0x1b/0x190
 [<c01add06>] do_lookup+0x176/0x1a0
 [<c01af8c4>] __link_path_walk+0x754/0xc80
 [<c01afe30>] path_walk+0x40/0x90
 [<c01aff8b>] do_path_lookup+0x7b/0x190
 [<c01aefba>] getname+0x9a/0xf0
 [<c01b09f7>] user_path_at+0x37/0x70
 [<c01574c5>] __virq_end+0x0/0xb
 [<c0120060>] update_console_cmdline+0x70/0x90
 [<c01a96e2>] vfs_stat_fd+0x22/0x60
 [<c01a97cf>] sys_stat64+0xf/0x30
 [<c01b79ac>] dput+0x1c/0x160
 [<c01a700a>] __fput+0x10a/0x190
 [<c01bd1a3>] mntput_no_expire+0x13/0xf0
 [<c01a4347>] filp_close+0x47/0x80
 [<c01a5820>] sys_close+0x60/0xc0
 [<c0103188>] sysenter_do_call+0x12/0x16
 =======================
Code: 89 d8 e8 fd fd ff ff eb 84 89 d6 8d 56 ff 8b 04 95 e0 59 73 c0 85 d2 89 04 b5 e0 59 73 c0 75 e9 89 1d e0 59 73 c0 e9 e1 fe ff ff <0f> 0b eb fe 90 8d 74 26 00 e8 fb e9 36 00 e9 ec fe ff ff 8d b6 
EIP: [<c01c8b27>] __find_get_block+0x187/0x1b0 SS:ESP 0068:de0efc40
---[ end trace ca60ca60b291a95f ]---

--------------010905010903030702080102--

