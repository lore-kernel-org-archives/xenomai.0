Message-ID: <20090219183812.6bslw8zfkk44sgko@domain.hid>
Date: Thu, 19 Feb 2009 18:38:12 +0100
From: Roman Pisl <rpisl@domain.hid>
References: <499B36C5.3060104@domain.hid> <499C5E49.90002@domain.hid>
In-Reply-To: <499C5E49.90002@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="=_2cgrwpf9e5no"
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] BUG fs/buffer.c with Linux 2.6.26,27
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

This message is in MIME format.

--=_2cgrwpf9e5no
Content-Type: text/plain;
	charset=ISO-8859-2;
	DelSp="Yes";
	format="flowed"
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

Hello Philippe, Jan and other experts,
I did some tests on the desktop and the bug is still present.

I tried both disabling CONFIG_PREEMPT and applying __ipipe_syscall_root patch.

Unfortunately I couldn't test Xenomai from trunk with our application,  
because events are probably broken - attached example segfaults on  
rt_event_wait. So I still use 2.4.6.1 and that is the reason for the  
problem with void rthal_propagate_irq when  
adeos-ipipe-2.6.27.13-x86-2.2-05.patch is applied.

Jan wrote:
The tracer log for .27 looks strange - did you apply my
ipipe-trace-over-ftrace patch or just enabled the existing code? In the
latter case, the .26-based trace log would be nice to cross-check and
exclude tracer artifacts.

Sorry, but I don't know where this patch comes from. I enabled  
existing code only.

.configs and logs are attached.

Roman


--=_2cgrwpf9e5no
Content-Type: text/plain;
	charset=ISO-8859-2;
	name="bug_2.6.26_xeno_2.4.6.1.txt"
Content-Disposition: attachment;
	filename="bug_2.6.26_xeno_2.4.6.1.txt"
Content-Transfer-Encoding: quoted-printable

Linux version 2.6.26.8-xenomai (root@domain.hid) (gcc version 4.1.2 (Gentoo 4.=
1.2 p1.1)) #1 SMP Thu Feb 19 18:04:25 CET 2009
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
PERCPU: Allocating 3190696 bytes of per cpu data
NR_CPUS: 2, nr_cpu_ids: 2
Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 259954
Kernel command line: ro root=3D/dev/sda3
mapped APIC to ffffb000 (fee00000)
mapped IOAPIC to ffffa000 (fec00000)
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Initializing CPU#0
PID hash table entries: 4096 (order: 12, 16384 bytes)
Detected 2391.298 MHz processor.
I-pipe 2.0-16: pipeline enabled.
Console: colour VGA+ 80x25
console [tty0] enabled
Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
Memory: 1022772k/1048004k available (2925k kernel code, 24560k reserved, 136=
6k data, 3332k init, 130500k highmem)
virtual kernel memory layout:
    fixmap  : 0xfff9b000 - 0xfffff000   ( 400 kB)
    pkmap   : 0xff800000 - 0xffc00000   (4096 kB)
    vmalloc : 0xf8800000 - 0xff7fe000   ( 111 MB)
    lowmem  : 0xc0000000 - 0xf8000000   ( 896 MB)
      .init : 0xc0538000 - 0xc0879000   (3332 kB)
      .data : 0xc03db7f2 - 0xc0531330   (1366 kB)
      .text : 0xc0100000 - 0xc03db7f2   (2925 kB)
Checking if this processor honours the WP bit even in supervisor mode...Ok.
CPA: page pool initialized 1 of 1 pages preallocated
SLUB: Genslabs=3D12, HWalign=3D128, Order=3D0-3, MinObjects=3D0, CPUs=3D2, N=
odes=3D1
Calibrating delay using timer specific routine.. 4787.26 BogoMIPS (lpj=3D957=
4528)
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
evxfevnt-0091 [00] enable                : Transition to ACPI mode successfu=
l
ENABLING IO-APIC IRQs
..TIMER: vector=3D0x31 apic1=3D0 pin1=3D2 apic2=3D-1 pin2=3D-1
CPU0: Intel(R) Pentium(R) 4 CPU 2.40GHz stepping 04
Brought up 1 CPUs
Total of 1 processors activated (4787.26 BogoMIPS).
net_namespace: 632 bytes
NET: Registered protocol family 16
No dock devices found.
ACPI: bus type pci registered
PCI: PCI BIOS revision 2.10 entry at 0xfbdf8, last bus=3D2
PCI: Using configuration type 1 for base access
Setting up standard PCI resources
evgpeblk-0956 [00] ev_create_gpe_block   : GPE 00 to 1F [_GPE] 4 regs on int=
 0x9
ACPI: EC: Look up EC in DSDT
Completing Region/Field/Buffer/Package initialization:......................=
....................
Initialized 17/21 Regions 0/0 Fields 9/9 Buffers 16/16 Packages (319 nodes)
Initializing Device/Processor/Thermal objects by executing _INI methods:....
Executed 4 _INI methods requiring 3 _STA executions (examined 33 objects)
evgpeblk-1052 [00] ev_initialize_gpe_bloc: Found 7 Wake, Enabled 1 Runtime G=
PEs in this block
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
msgmni has been set to 1743
io scheduler noop registered
io scheduler anticipatory registered
io scheduler deadline registered
io scheduler cfq registered (default)
pci 0000:01:00.0: Boot video device
ACPI: PCI Interrupt 0000:01:00.0[A] -> GSI 16 (level, low) -> IRQ 16
radeonfb: Found Intel x86 BIOS ROM Image
radeonfb: Retrieved PLL infos from BIOS
radeonfb: Reference=3D27.00 MHz (RefDiv=3D12) Memory=3D245.00 Mhz, System=3D=
170.00 MHz
radeonfb: PLL min 20000 max 35000
i2c-adapter i2c-1: unable to read EDID block.
i2c-adapter i2c-1: unable to read EDID block.
i2c-adapter i2c-1: unable to read EDID block.
Switched to high resolution mode on CPU 0
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
Real Time Clock Driver v1.12ac
Linux agpgart interface v0.103
agpgart: Detected an Intel 830M Chipset.
agpgart: AGP aperture is 128M @ 0xe8000000
Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing disabled
serial8250: ttyS0 at I/O 0x3f8 (irq =3D 4) is a 16550A
00:09: ttyS0 at I/O 0x3f8 (irq =3D 4) is a 16550A
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
ata1.00: 976773168 sectors, multi 8: LBA48=20
ata1.01: ATA-5: WDC WD400BB-60DGA0, 05.03E05, max UDMA/100
ata1.01: 78165360 sectors, multi 8: LBA=20
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
sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support=
 DPO or FUA
sd 0:0:0:0: [sda] 976773168 512-byte hardware sectors (500108 MB)
sd 0:0:0:0: [sda] Write Protect is off
sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support=
 DPO or FUA
 sda: sda1 sda2 sda3 sda4 < >
sd 0:0:0:0: [sda] Attached SCSI disk
sd 0:0:0:0: Attached scsi generic sg0 type 0
scsi 0:0:1:0: Direct-Access     ATA      WDC WD400BB-60DG 05.0 PQ: 0 ANSI: 5
sd 0:0:1:0: [sdb] 78165360 512-byte hardware sectors (40021 MB)
sd 0:0:1:0: [sdb] Write Protect is off
sd 0:0:1:0: [sdb] Mode Sense: 00 3a 00 00
sd 0:0:1:0: [sdb] Write cache: enabled, read cache: enabled, doesn't support=
 DPO or FUA
sd 0:0:1:0: [sdb] 78165360 512-byte hardware sectors (40021 MB)
sd 0:0:1:0: [sdb] Write Protect is off
sd 0:0:1:0: [sdb] Mode Sense: 00 3a 00 00
sd 0:0:1:0: [sdb] Write cache: enabled, read cache: enabled, doesn't support=
 DPO or FUA
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
usb 1-6: new high speed USB device using ehci_hcd and address 2
ACPI: PCI Interrupt 0000:00:1d.2[C] -> GSI 18 (level, low) -> IRQ 18
PCI: Setting latency timer of device 0000:00:1d.2 to 64
uhci_hcd 0000:00:1d.2: UHCI Host Controller
uhci_hcd 0000:00:1d.2: new USB bus registered, assigned bus number 4
uhci_hcd 0000:00:1d.2: irq 18, io base 0x0000ff40
usb usb4: configuration #1 chosen from 1 choice
hub 4-0:1.0: USB hub found
hub 4-0:1.0: 2 ports detected
usb 1-6: configuration #1 chosen from 1 choice
usbcore: registered new interface driver usblp
Initializing USB Mass Storage driver...
scsi2 : SCSI emulation for USB Mass Storage devices
usbcore: registered new interface driver usb-storage
USB Mass Storage support registered.
usb-storage: device found at 2
usb-storage: waiting for device to settle before scanning
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
Freeing unused kernel memory: 3332k freed
scsi 2:0:0:0: Direct-Access     -Pretec  04GB             1.00 PQ: 0 ANSI: 2
sd 2:0:0:0: [sdc] 7897088 512-byte hardware sectors (4043 MB)
sd 2:0:0:0: [sdc] Write Protect is off
sd 2:0:0:0: [sdc] Mode Sense: 00 00 00 00
sd 2:0:0:0: [sdc] Assuming drive cache: write through
sd 2:0:0:0: [sdc] 7897088 512-byte hardware sectors (4043 MB)
sd 2:0:0:0: [sdc] Write Protect is off
sd 2:0:0:0: [sdc] Mode Sense: 00 00 00 00
sd 2:0:0:0: [sdc] Assuming drive cache: write through
 sdc:
sd 2:0:0:0: [sdc] Attached SCSI removable disk
sd 2:0:0:0: Attached scsi generic sg4 type 0
usb-storage: device scan complete
EXT3 FS on sda3, internal journal
fuse init (API version 7.9)
ADDRCONF(NETDEV_UP): eth0: link is not ready
e1000: eth0: e1000_watchdog: NIC Link is Up 1000 Mbps Full Duplex, Flow Cont=
rol: RX/TX
ADDRCONF(NETDEV_CHANGE): eth0: link becomes ready
eth0: no IPv6 routers present
------------[ cut here ]------------
kernel BUG at fs/buffer.c:1290!
invalid opcode: 0000 [#1] SMP=20
Modules linked in: fuse

Pid: 5202, comm: emerge Not tainted (2.6.26.8-xenomai #1)
EIP: 0060:[<c01b99a6>] EFLAGS: 00010246 CPU: 0
EIP is at __find_get_block+0x39/0x1cd
EAX: 00000000 EBX: 00000000 ECX: 00000000 EDX: ffffffff
ESI: 00000000 EDI: f7820200 EBP: f71b5c78 ESP: f71b5c3c
 DS: 007b ES: 007b FS: 00d8 GS: 0033 SS: 0068
Process emerge (pid: 5202, ti=3Df71b4000 task=3Df7cc7b80 task.ti=3Df71b4000)=
<0>
I-pipe domain Linux
Stack: 00f0f80f 00000000 000055c0 c188b0ac 00000282 00000000 c09b5900 000000=
00=20
       00000000 00000000 f7b469f8 f71b5cd0 00000000 00000000 f7b469f8 f71b5c=
d0=20
       c01b9b59 00001000 00f0f80f 00000000 f7820200 00000000 c01d77a6 000000=
00=20
Call Trace:
 [<c01b9b59>] ? __getblk+0x1f/0x24c
 [<c01d77a6>] ? ext3_getblk+0xe/0x18b
 [<c01d77e7>] ? ext3_getblk+0x4f/0x18b
 [<c01d7839>] ? ext3_getblk+0xa1/0x18b
 [<c01da9f7>] ? ext3_find_entry+0x331/0x599
 [<c01323ee>] ? up_read+0x8/0x18
 [<c014362a>] ? __ipipe_restore_root+0x8/0x29
 [<c03d77d8>] ? _spin_lock+0x8/0x1e
 [<c01dc0b4>] ? ext3_lookup+0xe/0xa7
 [<c0113323>] ? mcount+0x1f/0x23
 [<c01dc0d0>] ? ext3_lookup+0x2a/0xa7
 [<c01a385c>] ? do_lookup+0xb6/0x153
 [<c01a4e92>] ? __link_path_walk+0x6eb/0xab4
 [<c01a325b>] ? path_get+0x8/0x27
 [<c0113323>] ? mcount+0x1f/0x23
 [<c01a5299>] ? path_walk+0x3e/0x77
 [<c01a551e>] ? do_path_lookup+0x124/0x13f
 [<c01a466e>] ? getname+0x67/0xa0
 [<c01a5dbb>] ? __user_walk_fd+0x34/0x4d
 [<c01a001b>] ? vfs_stat_fd+0x1e/0x45
 [<c022c8da>] ? _atomic_dec_and_lock+0xa/0x4c
 [<c0113323>] ? mcount+0x1f/0x23
 [<c01a0105>] ? vfs_stat+0x16/0x18
 [<c01a0120>] ? sys_stat64+0x19/0x2d
 [<c0112dc6>] ? __ipipe_syscall_root+0xa/0x143
 [<c0113323>] ? mcount+0x1f/0x23
 [<c0112dc6>] ? __ipipe_syscall_root+0xa/0x143
 [<c0102c30>] ? sysenter_past_esp+0x79/0x7d
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
Code: 89 c7 89 55 c4 89 4d c8 9c fa 64 a1 00 31 57 c0 8d 80 80 42 57 c0 0f b=
a 20 00 19 d2 9d 83 fa 01 19 c0 25 00 02 00 00 85 c0 75 04 <0f> 0b eb fe b8 =
00 c6 9a c0 e8 26 8f f8 ff 9c fa 64 a1 00 31 57=20
EIP: [<c01b99a6>] __find_get_block+0x39/0x1cd SS:ESP 0068:f71b5c3c
I-pipe tracer log (1000 points):
     #func                    0 ipipe_trace_panic_freeze+0x9 (oops_enter+0xd=
)
     #func                    0 oops_enter+0x8 (die+0x1a)
     #func                    0 die+0xe (do_trap+0x8f)
     #func                   -1 search_module_extables+0xa (search_exception=
_tables+0x27)
     #func                   -3 search_extable+0x9 (search_exception_tables+=
0x1c)
     #func                   -3 search_exception_tables+0x9 (fixup_exception=
+0x13)
     #func                   -3 fixup_exception+0x9 (do_trap+0x70)
     #func                   -4 do_trap+0xe (do_invalid_op+0x71)
     #func                   -5 kprobe_exceptions_notify+0xe (notifier_call_=
chain+0x30)
     #func                   -5 notifier_call_chain+0xe (__atomic_notifier_c=
all_chain+0x16)
     #func                   -5 __atomic_notifier_call_chain+0x8 (atomic_not=
ifier_call_chain+0x11)
     #func                   -6 atomic_notifier_call_chain+0x8 (notify_die+0=
x32)
     #func                   -6 notify_die+0xb (do_invalid_op+0x48)
     #func                   -6 do_invalid_op+0xd (__ipipe_handle_exception+=
0x16b)
     #func                   -7 __ipipe_handle_exception+0xe (error_code+0x7=
7)
     #func                   -8 __find_get_block+0xe (__getblk+0x1f)
     #func                   -9 __getblk+0xe (ext3_getblk+0xa1)
     #func                  -11 ext3_get_branch+0xe (ext3_get_blocks_handle+=
0x82)
     #func                  -12 ext3_block_to_path+0xe (ext3_get_blocks_hand=
le+0x58)
     #func                  -12 ext3_get_blocks_handle+0x11 (ext3_getblk+0x4=
f)
     #func                  -13 ext3_getblk+0xe (ext3_find_entry+0x331)
     #func                  -14 ext3_find_entry+0x11 (ext3_lookup+0x2a)
     #func                  -15 ext3_lookup+0xe (do_lookup+0xb6)
     #func                  -15 _spin_lock+0x8 (d_alloc+0x144)
     #func                  -15 __ipipe_restore_root+0x8 (kmem_cache_alloc+0=
x97)
     #func                  -16 ipipe_check_context+0x9 (kmem_cache_alloc+0x=
24)
     #func                  -16 kmem_cache_alloc+0xe (d_alloc+0x23)
     #func                  -16 d_alloc+0xe (do_lookup+0x99)
     #func                  -17 __d_lookup+0xe (d_lookup+0x27)
     #func                  -17 d_lookup+0xb (do_lookup+0x7b)
     #func                  -17 ipipe_check_context+0x9 (mutex_lock+0x18)
     #func                  -17 mutex_lock+0xc (do_lookup+0x71)
     #func                  -18 __d_lookup+0xe (do_lookup+0x2a)
     #func                  -18 do_lookup+0xe (__link_path_walk+0x6eb)
     #func                  -18 generic_permission+0xb (ext3_permission+0x12=
)
     #func                  -19 ext3_permission+0x8 (permission+0x8d)
     #func                  -19 permission+0xe (vfs_permission+0x15)
     #func                  -19 vfs_permission+0x8 (__link_path_walk+0x117)
     #func                  -19 _atomic_dec_and_lock+0xa (dput+0x2e)
     #func                  -19 dput+0x9 (__link_path_walk+0x556)
     #func                  -20 __follow_mount+0xb (do_lookup+0x54)
     #func                  -20 memcmp+0xa (__d_lookup+0xa0)
     #func                  -20 _spin_lock+0x8 (__d_lookup+0x67)
     #func                  -20 __d_lookup+0xe (do_lookup+0x2a)
     #func                  -20 do_lookup+0xe (__link_path_walk+0x2b9)
     #func                  -21 generic_permission+0xb (ext3_permission+0x12=
)
     #func                  -21 ext3_permission+0x8 (permission+0x8d)
     #func                  -21 permission+0xe (vfs_permission+0x15)
     #func                  -21 vfs_permission+0x8 (__link_path_walk+0x117)
     #func                  -21 _atomic_dec_and_lock+0xa (dput+0x2e)
     #func                  -21 dput+0x9 (__link_path_walk+0x556)
     #func                  -22 __follow_mount+0xb (do_lookup+0x54)
     #func                  -22 memcmp+0xa (__d_lookup+0xa0)
     #func                  -22 _spin_lock+0x8 (__d_lookup+0x67)
     #func                  -23 __d_lookup+0xe (do_lookup+0x2a)
     #func                  -23 do_lookup+0xe (__link_path_walk+0x2b9)
     #func                  -23 generic_permission+0xb (ext3_permission+0x12=
)
     #func                  -23 ext3_permission+0x8 (permission+0x8d)
     #func                  -23 permission+0xe (vfs_permission+0x15)
     #func                  -23 vfs_permission+0x8 (__link_path_walk+0x117)
     #func                  -24 _atomic_dec_and_lock+0xa (dput+0x2e)
     #func                  -24 dput+0x9 (__link_path_walk+0x556)
     #func                  -24 __follow_mount+0xb (do_lookup+0x54)
     #func                  -24 memcmp+0xa (__d_lookup+0xa0)
     #func                  -24 _spin_lock+0x8 (__d_lookup+0x67)
     #func                  -25 __d_lookup+0xe (do_lookup+0x2a)
     #func                  -25 do_lookup+0xe (__link_path_walk+0x2b9)
     #func                  -25 generic_permission+0xb (ext3_permission+0x12=
)
     #func                  -26 ext3_permission+0x8 (permission+0x8d)
     #func                  -26 permission+0xe (vfs_permission+0x15)
     #func                  -26 vfs_permission+0x8 (__link_path_walk+0x117)
     #func                  -26 _atomic_dec_and_lock+0xa (dput+0x2e)
     #func                  -26 dput+0x9 (__link_path_walk+0x556)
     #func                  -26 __follow_mount+0xb (do_lookup+0x54)
     #func                  -27 memcmp+0xa (__d_lookup+0xa0)
     #func                  -27 _spin_lock+0x8 (__d_lookup+0x67)
     #func                  -28 __d_lookup+0xe (do_lookup+0x2a)
     #func                  -28 do_lookup+0xe (__link_path_walk+0x2b9)
     #func                  -28 generic_permission+0xb (ext3_permission+0x12=
)
     #func                  -28 ext3_permission+0x8 (permission+0x8d)
     #func                  -28 permission+0xe (vfs_permission+0x15)
     #func                  -28 vfs_permission+0x8 (__link_path_walk+0x117)
     #func                  -29 _atomic_dec_and_lock+0xa (dput+0x2e)
     #func                  -29 dput+0x9 (__link_path_walk+0x556)
     #func                  -30 __follow_mount+0xb (do_lookup+0x54)
     #func                  -30 memcmp+0xa (__d_lookup+0xa0)
     #func                  -31 _spin_lock+0x8 (__d_lookup+0x67)
     #func                  -32 __d_lookup+0xe (do_lookup+0x2a)
     #func                  -32 do_lookup+0xe (__link_path_walk+0x2b9)
     #func                  -33 generic_permission+0xb (ext3_permission+0x12=
)
     #func                  -33 ext3_permission+0x8 (permission+0x8d)
     #func                  -34 permission+0xe (vfs_permission+0x15)
     #func                  -34 vfs_permission+0x8 (__link_path_walk+0x117)
     #func                  -35 __link_path_walk+0xe (path_walk+0x3e)
     #func                  -35 path_get+0x8 (path_walk+0x35)
     #func                  -35 path_walk+0xe (do_path_lookup+0x124)
     #func                  -36 path_get+0x8 (do_path_lookup+0xb3)
     #func                  -37 _read_lock+0x8 (do_path_lookup+0x46)
     #func                  -37 do_path_lookup+0xe (__user_walk_fd+0x34)
     #func                  -38 ipipe_check_context+0x9 (strncpy_from_user+0=
x36)
     #func                  -38 strncpy_from_user+0xb (getname+0x67)
     #func                  -38 __ipipe_restore_root+0x8 (kmem_cache_alloc+0=
x97)
     #func                  -39 ipipe_check_context+0x9 (kmem_cache_alloc+0x=
24)
     #func                  -39 kmem_cache_alloc+0xe (getname+0x1f)
     #func                  -40 getname+0xe (__user_walk_fd+0x1a)
     #func                  -40 __user_walk_fd+0xe (vfs_stat_fd+0x1e)
     #func                  -40 vfs_stat_fd+0xe (vfs_stat+0x16)
     #func                  -41 vfs_stat+0x8 (sys_stat64+0x19)
     #func                  -41 sys_stat64+0xc (sysenter_past_esp+0x79)
     #func                  -41 __ipipe_syscall_root+0xa (sysenter_past_esp+=
0x51)
 |   #end     0x8000000d    -67 __ipipe_unstall_iret_root+0x6f (sysenter_exi=
t+0x0)
 |   #begin   0x80000000    -67 __ipipe_unstall_iret_root+0x1e (sysenter_exi=
t+0x0)
     #func                  -67 __ipipe_unstall_iret_root+0x9 (sysenter_exit=
+0x0)
     #func                  -68 _atomic_dec_and_lock+0xa (mntput_no_expire+0=
x1d)
     #func                  -68 mntput_no_expire+0xe (__fput+0x145)
     #func                  -69 _spin_lock+0x8 (dput+0x3e)
     #func                  -69 _spin_lock+0x8 (_atomic_dec_and_lock+0x32)
     #func                  -69 _atomic_dec_and_lock+0xa (dput+0x2e)
     #func                  -70 ipipe_check_context+0x9 (dput+0x22)
     #func                  -70 dput+0x9 (__fput+0x12c)
     #func                  -70 __ipipe_restore_root+0x8 (call_rcu+0x8f)
     #func                  -71 ipipe_check_context+0x9 (call_rcu+0x1f)
     #func                  -71 call_rcu+0xa (__fput+0x124)
     #func                  -71 __percpu_counter_add+0xe (__fput+0x118)
     #func                  -72 _spin_lock+0x8 (file_kill+0x19)
     #func                  -72 file_kill+0x9 (__fput+0xec)
     #func                  -72 put_pid+0x8 (__fput+0xe5)
     #func                  -73 module_put+0x8 (__fput+0xdd)
     #func                  -74 ext3_release_file+0xb (__fput+0xa8)
     #func                  -74 locks_remove_flock+0xe (__fput+0x93)
     #func                  -75 inotify_inode_queue_event+0xe (__fput+0x7a)
     #func                  -76 inotify_dentry_parent_queue_event+0xe (__fpu=
t+0x6b)
     #func                  -76 ipipe_check_context+0x9 (__fput+0x2c)
     #func                  -77 __fput+0xe (fput+0x1c)
     #func                  -77 fput+0x8 (filp_close+0x55)
     #func                  -77 locks_remove_posix+0xd (filp_close+0x4e)
     #func                  -78 dnotify_flush+0xe (filp_close+0x45)
     #func                  -78 filp_close+0xb (sys_close+0x6d)
     #func                  -79 _spin_lock+0x8 (sys_close+0x24)
     #func                  -79 sys_close+0xa (sysenter_past_esp+0x79)
     #func                  -81 __ipipe_syscall_root+0xa (sysenter_past_esp+=
0x51)
 |   #end     0xffffff16  -1448 ipipe_ipi3+0x3d ()
 |   #func                -1448 __ipipe_walk_pipeline+0xe (__ipipe_handle_ir=
q+0x152)
 |  #*func                -1449 __ipipe_set_irq_pending+0xe (__ipipe_schedul=
e_irq+0x6d)
 |  #*func                -1449 __ipipe_schedule_irq+0xe (rthal_irq_host_pen=
d+0x1f)
 |  #*func                -1449 rthal_irq_host_pend+0x8 (xnintr_clock_handle=
r+0x131)
 |  #*func                -1450 xntimer_next_local_shot+0xe (xntimer_tick_ap=
eriodic+0x1b9)
 |  #*func                -1451 xntimer_tick_aperiodic+0xe (xnintr_clock_han=
dler+0x6b)
 |  #*func                -1451 xnintr_clock_handler+0xe (__ipipe_dispatch_w=
ired+0xe0)
 |   #func                -1451 __ipipe_dispatch_wired+0xe (__ipipe_handle_i=
rq+0x83)
 |   #func                -1452 __ipipe_ack_apic+0x8 (__ipipe_handle_irq+0x7=
a)
 |   #func                -1453 __ipipe_handle_irq+0xe (ipipe_ipi3+0x33)
 |   #begin   0xffffff16  -1454 ipipe_ipi3+0x2e ()
 |   #end     0xffffff16  -4821 ipipe_ipi3+0x3d ()
 |   #func                -4821 __ipipe_walk_pipeline+0xe (__ipipe_handle_ir=
q+0x152)
 |  #*[ 5202] emerge  90  -4822 xnpod_schedule+0xc7b (xnintr_clock_handler+0=
x117)
 |  #*func                -4823 __switch_to+0xe (xnpod_schedule+0xb78)
 |  #*[ 5200] LevelTa 90  -4824 xnpod_schedule+0xeb (xnpod_suspend_thread+0x=
1e2)
 |  #*func                -4824 xnpod_schedule+0x11 (xnpod_suspend_thread+0x=
1e2)
 |  #*func                -4824 xnpod_suspend_thread+0xe (xnshadow_relax+0x9=
5)
 |  #*[ 5202] emerge  90  -4826 xnpod_schedule_runnable+0x4a (rpi_push+0x22d=
)
 |  #*func                -4826 xnpod_schedule_runnable+0x11 (rpi_push+0x22d=
)
 |  #*func                -4828 rpi_push+0xe (xnshadow_relax+0x73)
 |  #*func                -4829 __ipipe_set_irq_pending+0xe (__ipipe_schedul=
e_irq+0x6d)
 |  #*func                -4830 __ipipe_schedule_irq+0xe (rthal_apc_schedule=
+0x76)
 |  #*func                -4830 rthal_apc_schedule+0xb (schedule_linux_call+=
0xa4)
 |  #*func                -4831 schedule_linux_call+0xe (xnshadow_relax+0x62=
)
 |  +*func                -4831 xnshadow_relax+0xe (xnpod_trap_fault+0x140)
 |  +*func                -4831 xnpod_trap_fault+0xd (xnarch_trap_fault+0x1f=
)
 |  +*func                -4832 xnarch_trap_fault+0xb (exception_event+0x3d)
 |  +*func                -4832 exception_event+0xa (__ipipe_dispatch_event+=
0xe6)
 |  +*func                -4832 __ipipe_dispatch_event+0xe (__ipipe_handle_e=
xception+0xd0)
 |  + func                -4833 __ipipe_handle_exception+0xe (error_code+0x7=
7)
 |  + end     0x80000000  -4834 __ipipe_restore_pipeline_head+0xc6 (rt_event=
_wait+0x1d9)
 |  # func                -4834 __ipipe_restore_pipeline_head+0x9 (rt_event_=
wait+0x1d9)
 |  # [ 5200] LevelTa 90  -4836 xnpod_schedule+0xc7b (xnpod_suspend_thread+0=
x1e2)
 |  # func                -4837 __switch_to+0xe (xnpod_schedule+0xb78)
 |  # [ 5201] TimerTa 80  -4839 xnpod_schedule+0xeb (rt_event_signal+0x10c)
 |  # func                -4839 xnpod_schedule+0x11 (rt_event_signal+0x10c)
 |  # [ 5200] LevelTa 90  -4840 xnpod_resume_thread+0x9d (xnsynch_wakeup_thi=
s_sleeper+0xc6)
 |  # func                -4840 xnpod_resume_thread+0xe (xnsynch_wakeup_this=
_sleeper+0xc6)
 |  # func                -4840 xnsynch_wakeup_this_sleeper+0xe (rt_event_si=
gnal+0xe4)
 |  + begin   0x80000000  -4841 rt_event_signal+0x24 (__rt_event_signal+0x49=
)
    + func                -4841 rt_event_signal+0xe (__rt_event_signal+0x49)
 |  + end     0x80000000  -4842 __ipipe_restore_pipeline_head+0xc6 (xnregist=
ry_fetch+0x112)
 |  # func                -4842 __ipipe_restore_pipeline_head+0x9 (xnregistr=
y_fetch+0x112)
 |  + begin   0x80000000  -4843 xnregistry_fetch+0x1e (__rt_event_signal+0x3=
4)
    + func                -4843 xnregistry_fetch+0xa (__rt_event_signal+0x34=
)
    + func                -4843 __rt_event_signal+0xd (hisyscall_event+0x136=
)
    + func                -4845 hisyscall_event+0xe (__ipipe_dispatch_event+=
0xe6)
 |  + end     0x80000001  -4845 __ipipe_dispatch_event+0xd6 (__ipipe_syscall=
_root+0x8d)
 |  + begin   0x80000001  -4846 __ipipe_dispatch_event+0x2c (__ipipe_syscall=
_root+0x8d)
    + func                -4846 __ipipe_dispatch_event+0xe (__ipipe_syscall_=
root+0x8d)
    + func                -4846 __ipipe_syscall_root+0xa (system_call+0x29)
 |  + end     0x80000001  -4854 __ipipe_dispatch_event+0x1db (__ipipe_syscal=
l_root+0x8d)
 |  + begin   0x80000001  -4855 __ipipe_dispatch_event+0x109 (__ipipe_syscal=
l_root+0x8d)
 |  + end     0x80000000  -4857 __ipipe_restore_pipeline_head+0xc6 (xnpod_wa=
it_thread_period+0x145)
 |  # func                -4857 __ipipe_restore_pipeline_head+0x9 (xnpod_wai=
t_thread_period+0x145)
 |  # func                -4858 xntimer_get_overruns+0xe (xnpod_wait_thread_=
period+0xe5)
 |  # [ 5201] TimerTa 80  -4860 xnpod_schedule+0xc7b (xnpod_suspend_thread+0=
x1e2)
 |  # func                -4862 __switch_to+0xe (xnpod_schedule+0xb78)
 |  # [ 5202] emerge  -1  -4865 xnpod_schedule+0xeb (xnintr_clock_handler+0x=
117)
 |  # func                -4866 xnpod_schedule+0x11 (xnintr_clock_handler+0x=
117)
 |  # func                -4866 xntimer_next_local_shot+0xe (xntimer_tick_ap=
eriodic+0x1b9)
 |  # [ 5201] TimerTa 80  -4868 xnpod_resume_thread+0x9d (xnthread_periodic_=
handler+0x28)
 |  # func                -4868 xnpod_resume_thread+0xe (xnthread_periodic_h=
andler+0x28)
 |  # func                -4868 xnthread_periodic_handler+0x8 (xntimer_tick_=
aperiodic+0x99)
 |  # func                -4869 xntimer_tick_aperiodic+0xe (xnintr_clock_han=
dler+0x6b)
 |  # func                -4869 xnintr_clock_handler+0xe (__ipipe_dispatch_w=
ired+0xe0)
 |   +func                -4869 __ipipe_dispatch_wired+0xe (__ipipe_handle_i=
rq+0x83)
 |   +func                -4870 __ipipe_ack_apic+0x8 (__ipipe_handle_irq+0x7=
a)
 |   +func                -4870 __ipipe_handle_irq+0xe (ipipe_ipi3+0x33)
 |   +begin   0xffffff16  -4870 ipipe_ipi3+0x2e ()
 |   +end     0x8000000d  -5274 __ipipe_unstall_iret_root+0x6f (restore_noch=
eck_notrace+0x0)
 |   #begin   0x80000000  -5274 __ipipe_unstall_iret_root+0x1e (restore_noch=
eck_notrace+0x0)
     #func                -5274 __ipipe_unstall_iret_root+0x9 (restore_noche=
ck_notrace+0x0)
 |   +end     0x80000000  -5275 __ipipe_unstall_root+0x54 (__ipipe_restore_r=
oot+0x27)
 |   +func                -5275 __ipipe_unstall_root+0x8 (__ipipe_restore_ro=
ot+0x27)
 |   +func                -5275 __ipipe_restore_root+0x8 (__ipipe_handle_exc=
eption+0x194)
 |   +begin   0x80000000  -5275 __ipipe_handle_exception+0x17d (error_code+0=
x77)
     +func                -5275 up_read+0x8 (do_page_fault+0x2e7)
     +func                -5276 __inc_zone_state+0xe (__inc_zone_page_state+=
0x1d)
     +func                -5276 __inc_zone_page_state+0x8 (__page_set_anon_r=
map+0x32)
     +func                -5276 __page_set_anon_rmap+0x9 (page_add_new_anon_=
rmap+0x2e)
     +func                -5276 page_add_new_anon_rmap+0x9 (handle_mm_fault+=
0x1c9)
     +func                -5276 lru_cache_add_active+0x9 (handle_mm_fault+0x=
1bc)
     +func                -5277 _spin_lock+0x8 (handle_mm_fault+0x1aa)
     +func                -5277 page_address+0xe (handle_mm_fault+0x19d)
     +func                -5277 ipipe_check_context+0x9 (kunmap_atomic+0x4f)
     +func                -5277 kunmap_atomic+0x9 (get_page_from_freelist+0x=
325)
     +func                -5281 ipipe_check_context+0x9 (kmap_atomic_prot+0x=
1b)
     +func                -5281 kmap_atomic_prot+0xb (kmap_atomic+0x13)
     +func                -5281 kmap_atomic+0x8 (get_page_from_freelist+0x30=
6)
 |   +end     0x80000000  -5282 __ipipe_unstall_root+0x54 (__ipipe_restore_r=
oot+0x27)
 |   #begin   0x80000000  -5282 __ipipe_unstall_root+0x1a (__ipipe_restore_r=
oot+0x27)
     #func                -5282 __ipipe_unstall_root+0x8 (__ipipe_restore_ro=
ot+0x27)
     #func                -5282 __ipipe_restore_root+0x8 (get_page_from_free=
list+0x285)
     +func                -5283 ipipe_check_context+0x9 (get_page_from_freel=
ist+0x127)
     +func                -5283 zone_watermark_ok+0xe (get_page_from_freelis=
t+0x8a)
     +func                -5283 next_zones_zonelist+0x9 (get_page_from_freel=
ist+0x3a5)
     +func                -5283 next_zones_zonelist+0x9 (get_page_from_freel=
ist+0x2f)
     +func                -5283 get_page_from_freelist+0xe (__alloc_pages_in=
ternal+0xc2)
     +func                -5284 ipipe_check_context+0x9 (__alloc_pages_inter=
nal+0x96)
     +func                -5284 __alloc_pages_internal+0xe (__alloc_pages+0x=
f)
     +func                -5284 __alloc_pages+0x8 (handle_mm_fault+0x145)
     +func                -5284 ipipe_check_context+0x9 (anon_vma_prepare+0x=
1d)
     +func                -5284 anon_vma_prepare+0xe (handle_mm_fault+0x12c)
     +func                -5285 page_address+0xe (handle_mm_fault+0xa1)
     +func                -5285 handle_mm_fault+0xe (do_page_fault+0x290)
     +func                -5286 find_vma+0xa (do_page_fault+0x214)
     +func                -5286 down_read_trylock+0x9 (do_page_fault+0x1e5)
 |   +end     0x80000000  -5286 __ipipe_unstall_root+0x54 (do_page_fault+0x1=
bf)
 |   #begin   0x80000000  -5286 __ipipe_unstall_root+0x1a (do_page_fault+0x1=
bf)
     #func                -5286 __ipipe_unstall_root+0x8 (do_page_fault+0x1b=
f)
 |   #end     0x80000000  -5287 do_page_fault+0x3d (__ipipe_handle_exception=
+0x16b)
 |   #func                -5287 do_page_fault+0xe (__ipipe_handle_exception+=
0x16b)
 |   +func                -5288 __ipipe_handle_exception+0xe (error_code+0x7=
7)
 |   +end     0x8000000d  -5295 __ipipe_unstall_iret_root+0x6f (restore_noch=
eck_notrace+0x0)
 |   #begin   0x80000000  -5295 __ipipe_unstall_iret_root+0x1e (restore_noch=
eck_notrace+0x0)
     #func                -5295 __ipipe_unstall_iret_root+0x9 (restore_noche=
ck_notrace+0x0)
 |   +end     0x80000001  -5295 math_state_restore+0x96 (device_not_availabl=
e+0x4a)
 |   +begin   0x80000001  -5296 math_state_restore+0x71 (device_not_availabl=
e+0x4a)
     +func                -5296 math_state_restore+0xe (device_not_available=
+0x4a)
     +func                -5297 __ipipe_divert_exception+0xb (device_not_ava=
ilable+0x33)
 |   +end     0x8000000d  -5393 __ipipe_unstall_iret_root+0x6f (restore_noch=
eck_notrace+0x0)
 |   #begin   0x80000000  -5393 __ipipe_unstall_iret_root+0x1e (restore_noch=
eck_notrace+0x0)
     #func                -5393 __ipipe_unstall_iret_root+0x9 (restore_noche=
ck_notrace+0x0)
 |   #end     0xffffff16  -5393 ipipe_ipi3+0x3d ()
 |   +end     0x8000000d  -5394 __ipipe_unstall_iret_root+0x6f (restore_noch=
eck_notrace+0x0)
 |   #begin   0x80000000  -5394 __ipipe_unstall_iret_root+0x1e (restore_noch=
eck_notrace+0x0)
     #func                -5394 __ipipe_unstall_iret_root+0x9 (restore_noche=
ck_notrace+0x0)
     #func                -5395 idle_cpu+0x8 (irq_exit+0x62)
     #func                -5395 __ipipe_restore_root+0x8 (do_softirq+0x75)
     #func                -5395 ipipe_check_context+0x9 (_local_bh_enable+0x=
89)
     #func                -5395 _local_bh_enable+0x8 (__do_softirq+0xfb)
     +func                -5396 ipipe_check_context+0x9 (__do_softirq+0xa1)
     +func                -5396 __rcu_process_callbacks+0xb (rcu_process_cal=
lbacks+0x36)
     +func                -5396 rcu_start_batch+0x8 (__rcu_process_callbacks=
+0xa3)
     +func                -5396 _spin_lock+0x8 (__rcu_process_callbacks+0x95=
)
 |   +end     0x80000000  -5397 __ipipe_unstall_root+0x54 (__rcu_process_cal=
lbacks+0x7e)
 |   #begin   0x80000000  -5397 __ipipe_unstall_root+0x1a (__rcu_process_cal=
lbacks+0x7e)
     #func                -5397 __ipipe_unstall_root+0x8 (__rcu_process_call=
backs+0x7e)
     +func                -5397 ipipe_check_context+0x9 (__rcu_process_callb=
acks+0x4c)
     +func                -5397 __rcu_process_callbacks+0xb (rcu_process_cal=
lbacks+0x1f)
     +func                -5397 rcu_process_callbacks+0x8 (__do_softirq+0x77=
)
 |   +end     0x80000000  -5398 __ipipe_unstall_root+0x54 (run_timer_softirq=
+0x17c)
 |   #begin   0x80000000  -5398 __ipipe_unstall_root+0x1a (run_timer_softirq=
+0x17c)
     #func                -5398 __ipipe_unstall_root+0x8 (run_timer_softirq+=
0x17c)
     +func                -5398 ipipe_check_context+0x9 (_spin_lock_irq+0x15=
)
     +func                -5399 _spin_lock_irq+0x9 (run_timer_softirq+0x150)
 |   +end     0x80000000  -5399 __ipipe_unstall_root+0x54 (__ipipe_restore_r=
oot+0x27)
 |   #begin   0x80000000  -5399 __ipipe_unstall_root+0x1a (__ipipe_restore_r=
oot+0x27)
     #func                -5399 __ipipe_unstall_root+0x8 (__ipipe_restore_ro=
ot+0x27)
     #func                -5399 __ipipe_restore_root+0x8 (_spin_unlock_irqre=
store+0x1d)
     #func                -5399 _spin_unlock_irqrestore+0x8 (cfq_idle_slice_=
timer+0x6e)
     +func                -5400 ipipe_check_context+0x9 (_spin_lock_irqsave+=
0x15)
     +func                -5400 _spin_lock_irqsave+0x9 (cfq_idle_slice_timer=
+0x19)
     +func                -5400 cfq_idle_slice_timer+0xa (run_timer_softirq+=
0x122)
 |   +end     0x80000000  -5401 __ipipe_unstall_root+0x54 (run_timer_softirq=
+0x113)
 |   #begin   0x80000000  -5401 __ipipe_unstall_root+0x1a (run_timer_softirq=
+0x113)
     #func                -5401 __ipipe_unstall_root+0x8 (run_timer_softirq+=
0x113)
     #func                -5401 timer_stats_update_stats+0x11 (run_timer_sof=
tirq+0xf2)
     +func                -5402 ipipe_check_context+0x9 (_spin_lock_irq+0x15=
)
     +func                -5402 _spin_lock_irq+0x9 (run_timer_softirq+0x37)
     +func                -5403 hrtimer_run_pending+0xe (run_timer_softirq+0=
x22)
     +func                -5403 run_timer_softirq+0xe (__do_softirq+0x77)
 |   +end     0x80000000  -5404 __ipipe_unstall_root+0x54 (__do_softirq+0x69=
)
 |   #begin   0x80000000  -5404 __ipipe_unstall_root+0x1a (__do_softirq+0x69=
)
     #func                -5404 __ipipe_unstall_root+0x8 (__do_softirq+0x69)
     #func                -5404 ipipe_check_context+0x9 (__do_softirq+0x2e)
     #func                -5404 __do_softirq+0xe (do_softirq+0x62)
     #func                -5405 ipipe_check_context+0x9 (do_softirq+0x23)
     #func                -5405 do_softirq+0x9 (irq_exit+0x47)
     #func                -5405 ipipe_check_context+0x9 (irq_exit+0x12)
     #func                -5406 irq_exit+0x8 (smp_apic_timer_interrupt+0x66)
 |   #end     0x80000000  -5406 __ipipe_restore_pipeline_head+0xc6 (xnarch_n=
ext_htick_shot+0xdb)
 |  *#func                -5406 __ipipe_restore_pipeline_head+0x9 (xnarch_ne=
xt_htick_shot+0xdb)
 |  *#func                -5408 xnarch_ns_to_tsc+0xe (xntimer_start_aperiodi=
c+0x66)
 |  *#func                -5408 xntimer_start_aperiodic+0xe (xnarch_next_hti=
ck_shot+0x90)
 |   #begin   0x80000000  -5408 xnarch_next_htick_shot+0x1e (clockevents_pro=
gram_event+0xc5)
     #func                -5408 xnarch_next_htick_shot+0xa (clockevents_prog=
ram_event+0xc5)
     #func                -5409 clockevents_program_event+0xe (tick_dev_prog=
ram_event+0x2d)
     #func                -5409 set_normalized_timespec+0x8 (ktime_get_ts+0x=
45)
     #func                -5409 native_read_tsc+0x8 (read_tsc+0xe)
     #func                -5410 read_tsc+0x9 (getnstimeofday+0x3c)
     #func                -5410 getnstimeofday+0xe (ktime_get_ts+0x25)
     #func                -5410 ktime_get_ts+0xa (ktime_get+0x16)
     #func                -5410 ktime_get+0xc (tick_dev_program_event+0x19)
     #func                -5410 tick_dev_program_event+0xe (tick_program_eve=
nt+0x27)
     #func                -5410 tick_program_event+0xa (hrtimer_interrupt+0x=
129)
     #func                -5411 rb_insert_color+0xe (enqueue_hrtimer+0xd6)
     #func                -5411 enqueue_hrtimer+0xe (__run_hrtimer+0x7b)
     #func                -5411 _spin_lock+0x8 (__run_hrtimer+0x59)
     #func                -5412 ktime_add_safe+0xb (hrtimer_forward+0xdb)
     #func                -5412 hrtimer_forward+0xe (tick_sched_timer+0x8d)
     #func                -5412 profile_tick+0xa (tick_sched_timer+0x6e)
     #func                -5414 run_posix_cpu_timers+0xe (update_process_tim=
es+0x49)
     #func                -5414 find_first_bit+0xa (__first_cpu+0x12)
     #func                -5414 __first_cpu+0x8 (scheduler_tick+0xed)
     #func                -5415 idle_cpu+0x8 (scheduler_tick+0xb2)
     #func                -5415 update_curr+0xd (task_tick_fair+0x34)
     #func                -5416 task_tick_fair+0xe (scheduler_tick+0xa9)
     #func                -5416 __update_sched_clock+0xe (sched_clock_cpu+0x=
123)
     #func                -5416 __ipipe_restore_root+0x8 (native_sched_clock=
+0xbc)
     #func                -5416 ipipe_check_context+0x9 (native_sched_clock+=
0x54)
     #func                -5417 native_read_tsc+0x8 (native_sched_clock+0x46=
)
     #func                -5417 native_sched_clock+0xe (sched_clock_cpu+0x78=
)
     #func                -5417 sched_clock_cpu+0xe (scheduler_tick+0x41)
     #func                -5417 _spin_lock+0x8 (scheduler_tick+0x36)
     #func                -5418 __update_sched_clock+0xe (sched_clock_tick+0=
xa1)
     #func                -5418 set_normalized_timespec+0x8 (ktime_get_ts+0x=
45)
     #func                -5418 native_read_tsc+0x8 (read_tsc+0xe)
     #func                -5418 read_tsc+0x9 (getnstimeofday+0x3c)
     #func                -5418 getnstimeofday+0xe (ktime_get_ts+0x25)
     #func                -5418 ktime_get_ts+0xa (ktime_get+0x16)
     #func                -5419 ktime_get+0xc (sched_clock_tick+0x7c)
     #func                -5419 __ipipe_restore_root+0x8 (native_sched_clock=
+0xbc)
     #func                -5419 ipipe_check_context+0x9 (native_sched_clock+=
0x54)
     #func                -5419 native_read_tsc+0x8 (native_sched_clock+0x46=
)
     #func                -5419 native_sched_clock+0xe (sched_clock_tick+0x7=
1)
     #func                -5420 sched_clock_tick+0xe (scheduler_tick+0x2f)
     #func                -5420 scheduler_tick+0xe (update_process_times+0x4=
2)
     #func                -5420 __ipipe_restore_root+0x8 (raise_softirq+0x9b=
)
     #func                -5420 ipipe_check_context+0x9 (raise_softirq+0x16)
     #func                -5421 raise_softirq+0xa (rcu_check_callbacks+0x77)
     #func                -5421 rcu_check_callbacks+0x9 (update_process_time=
s+0x3d)
     #func                -5421 __rcu_pending+0x8 (rcu_pending+0x21)
     #func                -5421 rcu_pending+0x9 (update_process_times+0x30)
     #func                -5421 __ipipe_restore_root+0x8 (cpu_clock+0x146)
     #func                -5422 __update_sched_clock+0xe (sched_clock_cpu+0x=
123)
     #func                -5423 __ipipe_restore_root+0x8 (native_sched_clock=
+0xbc)
     #func                -5423 ipipe_check_context+0x9 (native_sched_clock+=
0x54)
     #func                -5423 native_read_tsc+0x8 (native_sched_clock+0x46=
)
     #func                -5424 native_sched_clock+0xe (sched_clock_cpu+0x78=
)
     #func                -5424 sched_clock_cpu+0xe (cpu_clock+0x6f)
     #func                -5425 ipipe_check_context+0x9 (cpu_clock+0x1b)
     #func                -5425 cpu_clock+0xe (get_timestamp+0xd)
     #func                -5425 get_timestamp+0x8 (__touch_softlockup_watchd=
og+0x21)
     #func                -5425 __touch_softlockup_watchdog+0xa (softlockup_=
tick+0x7a)
     #func                -5426 softlockup_tick+0xe (run_local_timers+0x1c)
     #func                -5426 __ipipe_restore_root+0x8 (raise_softirq+0x9b=
)
     #func                -5426 ipipe_check_context+0x9 (raise_softirq+0x16)
     #func                -5427 raise_softirq+0xa (run_local_timers+0x17)
     #func                -5427 hrtimer_run_queues+0xe (run_local_timers+0xd=
)
     #func                -5427 run_local_timers+0x8 (update_process_times+0=
x29)
     #func                -5428 account_user_time_scaled+0x8 (account_proces=
s_tick+0x25)
     #func                -5428 account_user_time+0xa (account_process_tick+=
0x19)
     #func                -5428 account_process_tick+0x9 (update_process_tim=
es+0x24)
     #func                -5428 update_process_times+0xb (update_root_proces=
s_times+0x26)
     #func                -5429 update_root_process_times+0xa (tick_sched_ti=
mer+0x64)
     #func                -5430 __ipipe_restore_root+0x8 (_spin_unlock_irqre=
store+0x1d)
     #func                -5430 _spin_unlock_irqrestore+0x8 (clocksource_get=
_next+0x41)
     #func                -5430 ipipe_check_context+0x9 (_spin_lock_irqsave+=
0x15)
     #func                -5431 _spin_lock_irqsave+0x9 (clocksource_get_next=
+0x12)
     #func                -5431 clocksource_get_next+0x8 (update_wall_time+0=
x51d)
     #func                -5431 update_xtime_cache+0xa (update_wall_time+0x5=
18)
     #func                -5433 native_read_tsc+0x8 (read_tsc+0xe)
     #func                -5433 read_tsc+0x9 (update_wall_time+0x23)
     #func                -5433 update_wall_time+0xe (do_timer+0x23)
     #func                -5433 do_timer+0xe (tick_do_update_jiffies64+0xb3)
     #func                -5434 _spin_lock+0x8 (tick_do_update_jiffies64+0x1=
c)
     #func                -5434 tick_do_update_jiffies64+0xe (tick_sched_tim=
er+0x48)
     #func                -5434 set_normalized_timespec+0x8 (ktime_get_ts+0x=
45)
     #func                -5435 native_read_tsc+0x8 (read_tsc+0xe)
     #func                -5435 read_tsc+0x9 (getnstimeofday+0x3c)
     #func                -5435 getnstimeofday+0xe (ktime_get_ts+0x25)
     #func                -5435 ktime_get_ts+0xa (ktime_get+0x16)
     #func                -5435 ktime_get+0xc (tick_sched_timer+0x1e)
     #func                -5435 tick_sched_timer+0xe (__run_hrtimer+0x50)
     #func                -5436 timer_stats_update_stats+0x11 (__run_hrtimer=
+0x3e)
     #func                -5437 rb_erase+0xe (__remove_hrtimer+0x64)
     #func                -5437 rb_next+0x8 (__remove_hrtimer+0x37)
     #func                -5437 __remove_hrtimer+0xb (__run_hrtimer+0x28)
     #func                -5437 __run_hrtimer+0xe (hrtimer_interrupt+0xeb)
     #func                -5438 _spin_lock+0x8 (hrtimer_interrupt+0x6e)
     #func                -5438 _spin_lock+0x8 (hrtimer_interrupt+0x6e)
     #func                -5439 set_normalized_timespec+0x8 (ktime_get_ts+0x=
45)
     #func                -5440 native_read_tsc+0x8 (read_tsc+0xe)
     #func                -5440 read_tsc+0x9 (getnstimeofday+0x3c)
     #func                -5441 getnstimeofday+0xe (ktime_get_ts+0x25)
     #func                -5442 ktime_get_ts+0xa (ktime_get+0x16)
     #func                -5442 ktime_get+0xc (hrtimer_interrupt+0x49)
     #func                -5443 hrtimer_interrupt+0xe (smp_apic_timer_interr=
upt+0x61)
     #func                -5443 idle_cpu+0x8 (irq_enter+0x51)
     #func                -5444 ipipe_check_context+0x9 (irq_enter+0x3c)
     #func                -5444 idle_cpu+0x8 (irq_enter+0x17)
     #func                -5444 irq_enter+0x9 (smp_apic_timer_interrupt+0x1c=
)
     #func                -5445 smp_apic_timer_interrupt+0xa (__ipipe_sync_s=
tage+0x147)
 |   #end     0x80000000  -5445 __ipipe_sync_stage+0xf4 (__ipipe_walk_pipeli=
ne+0xc9)
 |   +func                -5446 __ipipe_sync_stage+0xe (__ipipe_walk_pipelin=
e+0xc9)
 |   +func                -5446 __ipipe_walk_pipeline+0xe (__ipipe_handle_ir=
q+0x152)
 |  # func                -5447 __ipipe_set_irq_pending+0xe (__ipipe_schedul=
e_irq+0x6d)
 |  # func                -5447 __ipipe_schedule_irq+0xe (rthal_irq_host_pen=
d+0x1f)
 |  # func                -5448 rthal_irq_host_pend+0x8 (xnintr_clock_handle=
r+0x131)
 |  # func                -5449 xntimer_next_local_shot+0xe (xntimer_tick_ap=
eriodic+0x1b9)
 |  # func                -5451 xntimer_tick_aperiodic+0xe (xnintr_clock_han=
dler+0x6b)
 |  # func                -5452 xnintr_clock_handler+0xe (__ipipe_dispatch_w=
ired+0xe0)
 |   +func                -5452 __ipipe_dispatch_wired+0xe (__ipipe_handle_i=
rq+0x83)
 |   +func                -5453 __ipipe_ack_apic+0x8 (__ipipe_handle_irq+0x7=
a)
 |   +func                -5453 __ipipe_handle_irq+0xe (ipipe_ipi3+0x33)
 |   +begin   0xffffff16  -5454 ipipe_ipi3+0x2e ()
 |   +end     0x8000000d  -5507 __ipipe_unstall_iret_root+0x6f (restore_noch=
eck_notrace+0x0)
 |   #begin   0x80000000  -5507 __ipipe_unstall_iret_root+0x1e (restore_noch=
eck_notrace+0x0)
     #func                -5507 __ipipe_unstall_iret_root+0x9 (restore_noche=
ck_notrace+0x0)
 |   +end     0x80000000  -5508 __ipipe_unstall_root+0x54 (__ipipe_restore_r=
oot+0x27)
 |   +func                -5508 __ipipe_unstall_root+0x8 (__ipipe_restore_ro=
ot+0x27)
 |   +func                -5508 __ipipe_restore_root+0x8 (__ipipe_handle_exc=
eption+0x194)
 |   +begin   0x80000000  -5508 __ipipe_handle_exception+0x17d (error_code+0=
x77)
     +func                -5509 up_read+0x8 (do_page_fault+0x2e7)
     +func                -5509 __inc_zone_state+0xe (__inc_zone_page_state+=
0x1d)
     +func                -5509 __inc_zone_page_state+0x8 (__page_set_anon_r=
map+0x32)
     +func                -5510 __page_set_anon_rmap+0x9 (page_add_new_anon_=
rmap+0x2e)
     +func                -5510 page_add_new_anon_rmap+0x9 (handle_mm_fault+=
0x1c9)
     +func                -5510 lru_cache_add_active+0x9 (handle_mm_fault+0x=
1bc)
     +func                -5511 _spin_lock+0x8 (handle_mm_fault+0x1aa)
     +func                -5511 page_address+0xe (handle_mm_fault+0x19d)
     +func                -5511 ipipe_check_context+0x9 (kunmap_atomic+0x4f)
     +func                -5512 kunmap_atomic+0x9 (get_page_from_freelist+0x=
325)
     +func                -5515 ipipe_check_context+0x9 (kmap_atomic_prot+0x=
1b)
     +func                -5515 kmap_atomic_prot+0xb (kmap_atomic+0x13)
     +func                -5515 kmap_atomic+0x8 (get_page_from_freelist+0x30=
6)
 |   +end     0x80000000  -5515 __ipipe_unstall_root+0x54 (__ipipe_restore_r=
oot+0x27)
 |   #begin   0x80000000  -5516 __ipipe_unstall_root+0x1a (__ipipe_restore_r=
oot+0x27)
     #func                -5516 __ipipe_unstall_root+0x8 (__ipipe_restore_ro=
ot+0x27)
     #func                -5516 __ipipe_restore_root+0x8 (get_page_from_free=
list+0x285)
     +func                -5516 ipipe_check_context+0x9 (get_page_from_freel=
ist+0x127)
     +func                -5517 zone_watermark_ok+0xe (get_page_from_freelis=
t+0x8a)
     +func                -5517 next_zones_zonelist+0x9 (get_page_from_freel=
ist+0x3a5)
     +func                -5517 next_zones_zonelist+0x9 (get_page_from_freel=
ist+0x2f)
     +func                -5518 get_page_from_freelist+0xe (__alloc_pages_in=
ternal+0xc2)
     +func                -5518 ipipe_check_context+0x9 (__alloc_pages_inter=
nal+0x96)
     +func                -5519 __alloc_pages_internal+0xe (__alloc_pages+0x=
f)
     +func                -5519 __alloc_pages+0x8 (handle_mm_fault+0x145)
     +func                -5519 ipipe_check_context+0x9 (anon_vma_prepare+0x=
1d)
     +func                -5520 anon_vma_prepare+0xe (handle_mm_fault+0x12c)
     +func                -5520 page_address+0xe (handle_mm_fault+0xa1)
     +func                -5520 handle_mm_fault+0xe (do_page_fault+0x290)
     +func                -5521 find_vma+0xa (do_page_fault+0x214)
     +func                -5521 down_read_trylock+0x9 (do_page_fault+0x1e5)
 |   +end     0x80000000  -5521 __ipipe_unstall_root+0x54 (do_page_fault+0x1=
bf)
 |   #begin   0x80000000  -5522 __ipipe_unstall_root+0x1a (do_page_fault+0x1=
bf)
     #func                -5522 __ipipe_unstall_root+0x8 (do_page_fault+0x1b=
f)
 |   #end     0x80000000  -5522 do_page_fault+0x3d (__ipipe_handle_exception=
+0x16b)
 |   #func                -5522 do_page_fault+0xe (__ipipe_handle_exception+=
0x16b)
 |   +func                -5524 __ipipe_handle_exception+0xe (error_code+0x7=
7)
 |   +end     0x8000000d  -6717 __ipipe_unstall_iret_root+0x6f (sysenter_exi=
t+0x0)
 |   #begin   0x80000000  -6717 __ipipe_unstall_iret_root+0x1e (sysenter_exi=
t+0x0)
     #func                -6717 __ipipe_unstall_iret_root+0x9 (sysenter_exit=
+0x0)
     +func                -6718 up_write+0x8 (sys_munmap+0x3e)
 |   +end     0x80000000  -6718 __ipipe_unstall_root+0x54 (__ipipe_restore_r=
oot+0x27)
 |   #begin   0x80000000  -6718 __ipipe_unstall_root+0x1a (__ipipe_restore_r=
oot+0x27)
     #func                -6718 __ipipe_unstall_root+0x8 (__ipipe_restore_ro=
ot+0x27)
     #func                -6719 __ipipe_restore_root+0x8 (kmem_cache_free+0x=
b5)
     +func                -6719 ipipe_check_context+0x9 (kmem_cache_free+0x4=
3)
     +func                -6719 kmem_cache_free+0xe (remove_vma+0x50)
     +func                -6719 ipipe_check_context+0x9 (remove_vma+0x19)
     +func                -6720 remove_vma+0xa (do_munmap+0x182)
     +func                -6720 vm_stat_account+0xa (do_munmap+0x17b)
     +func                -6721 flush_tlb_mm+0xc (unmap_region+0xcf)
     +func                -6721 free_pgd_range+0xe (free_pgtables+0x8c)
     +func                -6722 unlink_file_vma+0xb (free_pgtables+0x2f)
     +func                -6722 _spin_lock+0x8 (anon_vma_unlink+0x1a)
     +func                -6722 anon_vma_unlink+0xa (free_pgtables+0x28)
     +func                -6722 free_pgtables+0xe (unmap_region+0xb7)
     +func                -6723 vm_acct_memory+0x8 (unmap_region+0x91)
 |   +end     0x80000000  -6723 __ipipe_unstall_root+0x54 (__ipipe_restore_r=
oot+0x27)
 |   #begin   0x80000000  -6724 __ipipe_unstall_root+0x1a (__ipipe_restore_r=
oot+0x27)
     #func                -6724 __ipipe_unstall_root+0x8 (__ipipe_restore_ro=
ot+0x27)
     #func                -6724 __ipipe_restore_root+0x8 (free_hot_cold_page=
+0x183)
     #func                -6725 get_pageblock_flags_group+0xe (free_hot_cold=
_page+0x149)
     +func                -6725 ipipe_check_context+0x9 (free_hot_cold_page+=
0xd4)
     +func                -6725 free_hot_cold_page+0xe (free_hot_page+0xf)
     +func                -6726 free_hot_page+0x8 (put_page+0x97)
 |   +end     0x80000000  -6726 __ipipe_unstall_root+0x54 (__ipipe_restore_r=
oot+0x27)
 |   #begin   0x80000000  -6726 __ipipe_unstall_root+0x1a (__ipipe_restore_r=
oot+0x27)
     #func                -6726 __ipipe_unstall_root+0x8 (__ipipe_restore_ro=
ot+0x27)
     #func                -6726 __ipipe_restore_root+0x8 (_spin_unlock_irqre=
store+0x1d)
     #func                -6727 _spin_unlock_irqrestore+0x8 (put_page+0x90)
     #func                -6727 __dec_zone_state+0xe (put_page+0x83)
     +func                -6727 ipipe_check_context+0x9 (_spin_lock_irqsave+=
0x15)
     +func                -6727 _spin_lock_irqsave+0x9 (put_page+0x47)
     +func                -6728 put_page+0xb (free_page_and_swap_cache+0x37)
     +func                -6728 free_page_and_swap_cache+0x9 (unmap_vmas+0x2=
81)
     +func                -6728 __dec_zone_state+0xe (__dec_zone_page_state+=
0x1d)
     +func                -6729 __dec_zone_page_state+0x8 (page_remove_rmap+=
0xd7)
     +func                -6729 page_remove_rmap+0xa (unmap_vmas+0x265)
     +func                -6730 vm_normal_page+0x9 (unmap_vmas+0x18b)
     +func                -6730 _spin_lock+0x8 (unmap_vmas+0x44f)
     +func                -6730 page_address+0xe (unmap_vmas+0x436)
     +func                -6731 unmap_vmas+0xe (unmap_region+0x87)
     +func                -6732 hweight32+0x8 (unmap_region+0x4b)
     +func                -6732 release_pages+0xe (__pagevec_lru_add_active+=
0xad)
 |   +end     0x80000000  -6732 __ipipe_unstall_root+0x54 (__pagevec_lru_add=
_active+0xa0)
 |   #begin   0x80000000  -6732 __ipipe_unstall_root+0x1a (__pagevec_lru_add=
_active+0xa0)
     #func                -6733 __ipipe_unstall_root+0x8 (__pagevec_lru_add_=
active+0xa0)
     #func                -6733 __inc_zone_state+0xe (__pagevec_lru_add_acti=
ve+0x85)
     #func                -6733 __inc_zone_state+0xe (__pagevec_lru_add_acti=
ve+0x85)
     #func                -6733 __inc_zone_state+0xe (__pagevec_lru_add_acti=
ve+0x85)
     #func                -6734 __inc_zone_state+0xe (__pagevec_lru_add_acti=
ve+0x85)
     #func                -6734 __inc_zone_state+0xe (__pagevec_lru_add_acti=
ve+0x85)
     #func                -6734 __inc_zone_state+0xe (__pagevec_lru_add_acti=
ve+0x85)
     #func                -6734 __inc_zone_state+0xe (__pagevec_lru_add_acti=
ve+0x85)
     #func                -6734 __inc_zone_state+0xe (__pagevec_lru_add_acti=
ve+0x85)
     #func                -6735 __inc_zone_state+0xe (__pagevec_lru_add_acti=
ve+0x85)
     +func                -6735 ipipe_check_context+0x9 (_spin_lock_irq+0x15=
)
     +func                -6735 _spin_lock_irq+0x9 (__pagevec_lru_add_active=
+0x51)
     +func                -6736 __pagevec_lru_add_active+0xe (drain_cpu_page=
vecs+0x38)
     +func                -6736 release_pages+0xe (__pagevec_lru_add+0xa8)
 |   +end     0x80000000  -6736 __ipipe_unstall_root+0x54 (__pagevec_lru_add=
+0x9b)
 |   #begin   0x80000000  -6736 __ipipe_unstall_root+0x1a (__pagevec_lru_add=
+0x9b)
     #func                -6736 __ipipe_unstall_root+0x8 (__pagevec_lru_add+=
0x9b)
     #func                -6737 __inc_zone_state+0xe (__pagevec_lru_add+0x80=
)
     #func                -6737 __inc_zone_state+0xe (__pagevec_lru_add+0x80=
)
     #func                -6737 __inc_zone_state+0xe (__pagevec_lru_add+0x80=
)
     #func                -6737 __inc_zone_state+0xe (__pagevec_lru_add+0x80=
)
     #func                -6738 __inc_zone_state+0xe (__pagevec_lru_add+0x80=
)
     #func                -6738 __inc_zone_state+0xe (__pagevec_lru_add+0x80=
)
     #func                -6738 __inc_zone_state+0xe (__pagevec_lru_add+0x80=
)
     #func                -6738 __inc_zone_state+0xe (__pagevec_lru_add+0x80=
)
     +func                -6739 ipipe_check_context+0x9 (_spin_lock_irq+0x15=
)
     +func                -6739 _spin_lock_irq+0x9 (__pagevec_lru_add+0x51)
     +func                -6740 __pagevec_lru_add+0xe (drain_cpu_pagevecs+0x=
22)
     +func                -6740 drain_cpu_pagevecs+0xa (lru_add_drain+0x13)
     +func                -6740 lru_add_drain+0x8 (unmap_region+0x34)
     +func                -6741 unmap_region+0xe (do_munmap+0x149)
     +func                -6741 arch_unmap_area_topdown+0x8 (do_munmap+0x130=
)
     +func                -6741 rb_erase+0xe (do_munmap+0xe5)
     +func                -6741 __anon_vma_link+0x9 (__vma_link+0x49)
     +func                -6741 __rb_rotate_right+0xb (rb_insert_color+0x5a)
     +func                -6742 rb_insert_color+0xe (__vma_link_rb+0x2d)
     +func                -6742 __vma_link_rb+0xa (__vma_link+0x42)
     +func                -6742 __vma_link+0xa (vma_adjust+0x2dd)
     +func                -6742 find_vma_prepare+0xe (vma_adjust+0x2ac)
     +func                -6743 _spin_lock+0x8 (vma_adjust+0x1a9)
     +func                -6743 vma_adjust+0xe (split_vma+0xcc)
     +func                -6743 memcpy+0xe (split_vma+0x5f)
 |   +end     0x80000000  -6743 __ipipe_unstall_root+0x54 (__ipipe_restore_r=
oot+0x27)
 |   #begin   0x80000000  -6744 __ipipe_unstall_root+0x1a (__ipipe_restore_r=
oot+0x27)
     #func                -6744 __ipipe_unstall_root+0x8 (__ipipe_restore_ro=
ot+0x27)
     #func                -6744 __ipipe_restore_root+0x8 (kmem_cache_alloc+0=
x97)
     #func                -6744 _spin_lock+0x8 (__slab_alloc+0x96)
     #func                -6744 deactivate_slab+0xb (__slab_alloc+0x81)
     #func                -6745 __slab_alloc+0xe (kmem_cache_alloc+0x73)
     +func                -6745 ipipe_check_context+0x9 (kmem_cache_alloc+0x=
24)
     +func                -6745 kmem_cache_alloc+0xe (split_vma+0x4d)
     +func                -6745 split_vma+0xe (do_munmap+0xb5)
     +func                -6745 find_vma+0xa (do_munmap+0x9c)
     +func                -6746 __anon_vma_link+0x9 (__vma_link+0x49)
     +func                -6746 rb_insert_color+0xe (__vma_link_rb+0x2d)
     +func                -6746 __vma_link_rb+0xa (__vma_link+0x42)
     +func                -6746 __vma_link+0xa (vma_adjust+0x2dd)
     +func                -6747 find_vma_prepare+0xe (vma_adjust+0x2ac)
     +func                -6748 _spin_lock+0x8 (vma_adjust+0x1a9)
     +func                -6748 vma_adjust+0xe (split_vma+0xcc)
     +func                -6749 memcpy+0xe (split_vma+0x5f)
 |   +end     0x80000000  -6750 __ipipe_unstall_root+0x54 (__ipipe_restore_r=
oot+0x27)
 |   #begin   0x80000000  -6750 __ipipe_unstall_root+0x1a (__ipipe_restore_r=
oot+0x27)
     #func                -6750 __ipipe_unstall_root+0x8 (__ipipe_restore_ro=
ot+0x27)
     #func                -6750 __ipipe_restore_root+0x8 (kmem_cache_alloc+0=
x97)
     #func                -6751 _spin_lock+0x8 (__slab_alloc+0x96)
     #func                -6751 deactivate_slab+0xb (__slab_alloc+0x81)
     #func                -6752 __slab_alloc+0xe (kmem_cache_alloc+0x73)
     +func                -6753 ipipe_check_context+0x9 (kmem_cache_alloc+0x=
24)
     +func                -6753 kmem_cache_alloc+0xe (split_vma+0x4d)
     +func                -6753 split_vma+0xe (do_munmap+0x86)
     +func                -6754 find_vma_prev+0xb (do_munmap+0x58)
     +func                -6755 do_munmap+0xe (sys_munmap+0x35)
     +func                -6755 ipipe_check_context+0x9 (down_write+0x15)
     +func                -6755 down_write+0x9 (sys_munmap+0x28)
     +func                -6756 __blocking_notifier_call_chain+0xe (blocking=
_notifier_call_chain+0x11)
     +func                -6756 blocking_notifier_call_chain+0x8 (profile_mu=
nmap+0x16)
     +func                -6756 profile_munmap+0x8 (sys_munmap+0x21)
     +func                -6757 sys_munmap+0xa (sysenter_past_esp+0x79)
     +func                -6757 __ipipe_syscall_root+0xa (sysenter_past_esp+=
0x51)
 |   +end     0x8000000d  -6758 __ipipe_unstall_iret_root+0x6f (sysenter_exi=
t+0x0)
 |   #begin   0x80000000  -6758 __ipipe_unstall_iret_root+0x1e (sysenter_exi=
t+0x0)
     #func                -6758 __ipipe_unstall_iret_root+0x9 (sysenter_exit=
+0x0)
     +func                -6759 _atomic_dec_and_lock+0xa (mntput_no_expire+0=
x1d)
     +func                -6759 mntput_no_expire+0xe (__fput+0x145)
     +func                -6759 _spin_lock+0x8 (dput+0x3e)
     +func                -6760 _spin_lock+0x8 (_atomic_dec_and_lock+0x32)
     +func                -6760 _atomic_dec_and_lock+0xa (dput+0x2e)
     +func                -6760 ipipe_check_context+0x9 (dput+0x22)
     +func                -6760 dput+0x9 (__fput+0x12c)
 |   +end     0x80000000  -6761 __ipipe_unstall_root+0x54 (__ipipe_restore_r=
oot+0x27)
 |   #begin   0x80000000  -6761 __ipipe_unstall_root+0x1a (__ipipe_restore_r=
oot+0x27)
     #func                -6761 __ipipe_unstall_root+0x8 (__ipipe_restore_ro=
ot+0x27)
     #func                -6761 __ipipe_restore_root+0x8 (call_rcu+0x8f)
     +func                -6762 ipipe_check_context+0x9 (call_rcu+0x1f)
     +func                -6762 call_rcu+0xa (__fput+0x124)
     +func                -6763 __percpu_counter_add+0xe (__fput+0x118)
     +func                -6764 _spin_lock+0x8 (file_kill+0x19)
     +func                -6764 file_kill+0x9 (__fput+0xec)
     +func                -6765 put_pid+0x8 (__fput+0xe5)
     +func                -6765 module_put+0x8 (__fput+0xdd)
     +func                -6767 ext3_release_file+0xb (__fput+0xa8)
     +func                -6768 locks_remove_flock+0xe (__fput+0x93)
     +func                -6768 inotify_inode_queue_event+0xe (__fput+0x7a)
     +func                -6769 inotify_dentry_parent_queue_event+0xe (__fpu=
t+0x6b)
     +func                -6769 ipipe_check_context+0x9 (__fput+0x2c)
     +func                -6769 __fput+0xe (fput+0x1c)
     +func                -6769 fput+0x8 (filp_close+0x55)
     +func                -6770 locks_remove_posix+0xd (filp_close+0x4e)
     +func                -6770 dnotify_flush+0xe (filp_close+0x45)
     +func                -6771 filp_close+0xb (sys_close+0x6d)
     +func                -6772 _spin_lock+0x8 (sys_close+0x24)
     +func                -6772 sys_close+0xa (sysenter_past_esp+0x79)
     +func                -6772 __ipipe_syscall_root+0xa (sysenter_past_esp+=
0x51)
 |   +end     0x8000000d  -7202 __ipipe_unstall_iret_root+0x6f (restore_noch=
eck_notrace+0x0)
 |   #begin   0x80000000  -7202 __ipipe_unstall_iret_root+0x1e (restore_noch=
eck_notrace+0x0)
     #func                -7202 __ipipe_unstall_iret_root+0x9 (restore_noche=
ck_notrace+0x0)
 |   +end     0x80000000  -7203 __ipipe_unstall_root+0x54 (__ipipe_restore_r=
oot+0x27)
 |   +func                -7203 __ipipe_unstall_root+0x8 (__ipipe_restore_ro=
ot+0x27)
 |   +func                -7203 __ipipe_restore_root+0x8 (__ipipe_handle_exc=
eption+0x194)
 |   +begin   0x80000000  -7203 __ipipe_handle_exception+0x17d (error_code+0=
x77)
     +func                -7203 up_read+0x8 (do_page_fault+0x2e7)
     +func                -7204 __inc_zone_state+0xe (__inc_zone_page_state+=
0x1d)
     +func                -7204 __inc_zone_page_state+0x8 (__page_set_anon_r=
map+0x32)
     +func                -7204 __page_set_anon_rmap+0x9 (page_add_new_anon_=
rmap+0x2e)
     +func                -7204 page_add_new_anon_rmap+0x9 (handle_mm_fault+=
0x1c9)
     +func                -7204 lru_cache_add_active+0x9 (handle_mm_fault+0x=
1bc)
     +func                -7204 _spin_lock+0x8 (handle_mm_fault+0x1aa)
     +func                -7205 page_address+0xe (handle_mm_fault+0x19d)
     +func                -7205 ipipe_check_context+0x9 (kunmap_atomic+0x4f)
     +func                -7205 kunmap_atomic+0x9 (get_page_from_freelist+0x=
325)
     +func                -7210 ipipe_check_context+0x9 (kmap_atomic_prot+0x=
1b)
     +func                -7210 kmap_atomic_prot+0xb (kmap_atomic+0x13)
     +func                -7210 kmap_atomic+0x8 (get_page_from_freelist+0x30=
6)
 |   +end     0x80000000  -7210 __ipipe_unstall_root+0x54 (__ipipe_restore_r=
oot+0x27)
 |   #begin   0x80000000  -7210 __ipipe_unstall_root+0x1a (__ipipe_restore_r=
oot+0x27)
     #func                -7211 __ipipe_unstall_root+0x8 (__ipipe_restore_ro=
ot+0x27)
     #func                -7211 __ipipe_restore_root+0x8 (get_page_from_free=
list+0x285)
     #func                -7211 __mod_zone_page_state+0xb (__rmqueue_smalles=
t+0x8b)
     #func                -7211 __rmqueue_smallest+0xe (__rmqueue+0x1b)
     #func                -7211 __rmqueue+0xe (rmqueue_bulk+0x35)
     #func                -7212 __mod_zone_page_state+0xb (__rmqueue_smalles=
t+0x8b)
     #func                -7212 __rmqueue_smallest+0xe (__rmqueue+0x1b)
     #func                -7212 __rmqueue+0xe (rmqueue_bulk+0x35)
     #func                -7212 __mod_zone_page_state+0xb (__rmqueue_smalles=
t+0x8b)
     #func                -7212 __rmqueue_smallest+0xe (__rmqueue+0x1b)
     #func                -7213 __rmqueue+0xe (rmqueue_bulk+0x35)
     #func                -7213 __mod_zone_page_state+0xb (__rmqueue_smalles=
t+0x8b)
     #func                -7213 __rmqueue_smallest+0xe (__rmqueue+0x1b)
     #func                -7213 __rmqueue+0xe (rmqueue_bulk+0x35)
     #func                -7213 __mod_zone_page_state+0xb (__rmqueue_smalles=
t+0x8b)
     #func                -7213 __rmqueue_smallest+0xe (__rmqueue+0x1b)
     #func                -7214 __rmqueue+0xe (rmqueue_bulk+0x35)
     #func                -7214 __mod_zone_page_state+0xb (__rmqueue_smalles=
t+0x8b)
     #func                -7214 __rmqueue_smallest+0xe (__rmqueue+0x1b)
     #func                -7214 __rmqueue+0xe (rmqueue_bulk+0x35)
     #func                -7214 __mod_zone_page_state+0xb (__rmqueue_smalles=
t+0x8b)
     #func                -7215 __rmqueue_smallest+0xe (__rmqueue+0x1b)
     #func                -7215 __rmqueue+0xe (rmqueue_bulk+0x35)
     #func                -7215 _spin_lock+0x8 (rmqueue_bulk+0x26)
     #func                -7215 rmqueue_bulk+0xe (get_page_from_freelist+0x1=
dd)
     +func                -7215 ipipe_check_context+0x9 (get_page_from_freel=
ist+0x127)
     +func                -7216 zone_watermark_ok+0xe (get_page_from_freelis=
t+0x8a)
     +func                -7216 next_zones_zonelist+0x9 (get_page_from_freel=
ist+0x3a5)
     +func                -7216 next_zones_zonelist+0x9 (get_page_from_freel=
ist+0x2f)
     +func                -7216 get_page_from_freelist+0xe (__alloc_pages_in=
ternal+0xc2)
     +func                -7216 ipipe_check_context+0x9 (__alloc_pages_inter=
nal+0x96)
     +func                -7216 __alloc_pages_internal+0xe (__alloc_pages+0x=
f)
     +func                -7216 __alloc_pages+0x8 (handle_mm_fault+0x145)
     +func                -7217 ipipe_check_context+0x9 (anon_vma_prepare+0x=
1d)
     +func                -7217 anon_vma_prepare+0xe (handle_mm_fault+0x12c)
     +func                -7217 page_address+0xe (handle_mm_fault+0xa1)
     +func                -7217 handle_mm_fault+0xe (do_page_fault+0x290)
     +func                -7217 find_vma+0xa (do_page_fault+0x214)
     +func                -7217 down_read_trylock+0x9 (do_page_fault+0x1e5)
 |   +end     0x80000000  -7218 __ipipe_unstall_root+0x54 (do_page_fault+0x1=
bf)
 |   #begin   0x80000000  -7218 __ipipe_unstall_root+0x1a (do_page_fault+0x1=
bf)
     #func                -7218 __ipipe_unstall_root+0x8 (do_page_fault+0x1b=
f)
 |   #end     0x80000000  -7218 do_page_fault+0x3d (__ipipe_handle_exception=
+0x16b)
 |   #func                -7218 do_page_fault+0xe (__ipipe_handle_exception+=
0x16b)
 |   +func                -7219 __ipipe_handle_exception+0xe (error_code+0x7=
7)
 |   +end     0x8000000d  -7240 __ipipe_unstall_iret_root+0x6f (restore_noch=
eck_notrace+0x0)
 |   #begin   0x80000000  -7240 __ipipe_unstall_iret_root+0x1e (restore_noch=
eck_notrace+0x0)
     #func                -7240 __ipipe_unstall_iret_root+0x9 (restore_noche=
ck_notrace+0x0)
 |   +end     0x80000000  -7241 __ipipe_unstall_root+0x54 (__ipipe_restore_r=
oot+0x27)
 |   +func                -7241 __ipipe_unstall_root+0x8 (__ipipe_restore_ro=
ot+0x27)
 |   +func                -7241 __ipipe_restore_root+0x8 (__ipipe_handle_exc=
eption+0x194)
 |   +begin   0x80000000  -7241 __ipipe_handle_exception+0x17d (error_code+0=
x77)
     +func                -7241 up_read+0x8 (do_page_fault+0x2e7)
     +func                -7241 __inc_zone_state+0xe (__inc_zone_page_state+=
0x1d)
     +func                -7242 __inc_zone_page_state+0x8 (__page_set_anon_r=
map+0x32)
     +func                -7242 __page_set_anon_rmap+0x9 (page_add_new_anon_=
rmap+0x2e)
     +func                -7242 page_add_new_anon_rmap+0x9 (handle_mm_fault+=
0x1c9)
     +func                -7242 lru_cache_add_active+0x9 (handle_mm_fault+0x=
1bc)
     +func                -7242 _spin_lock+0x8 (handle_mm_fault+0x1aa)
     +func                -7242 page_address+0xe (handle_mm_fault+0x19d)
     +func                -7243 ipipe_check_context+0x9 (kunmap_atomic+0x4f)
     +func                -7243 kunmap_atomic+0x9 (get_page_from_freelist+0x=
325)
     +func                -7246 ipipe_check_context+0x9 (kmap_atomic_prot+0x=
1b)
     +func                -7247 kmap_atomic_prot+0xb (kmap_atomic+0x13)
     +func                -7247 kmap_atomic+0x8 (get_page_from_freelist+0x30=
6)
 |   +end     0x80000000  -7247 __ipipe_unstall_root+0x54 (__ipipe_restore_r=
oot+0x27)
 |   #begin   0x80000000  -7247 __ipipe_unstall_root+0x1a (__ipipe_restore_r=
oot+0x27)
     #func                -7247 __ipipe_unstall_root+0x8 (__ipipe_restore_ro=
ot+0x27)
     #func                -7247 __ipipe_restore_root+0x8 (get_page_from_free=
list+0x285)
     +func                -7248 ipipe_check_context+0x9 (get_page_from_freel=
ist+0x127)
     +func                -7248 zone_watermark_ok+0xe (get_page_from_freelis=
t+0x8a)
     +func                -7248 next_zones_zonelist+0x9 (get_page_from_freel=
ist+0x3a5)
     +func                -7248 next_zones_zonelist+0x9 (get_page_from_freel=
ist+0x2f)
     +func                -7248 get_page_from_freelist+0xe (__alloc_pages_in=
ternal+0xc2)
     +func                -7248 ipipe_check_context+0x9 (__alloc_pages_inter=
nal+0x96)
     +func                -7249 __alloc_pages_internal+0xe (__alloc_pages+0x=
f)
     +func                -7249 __alloc_pages+0x8 (handle_mm_fault+0x145)
     +func                -7249 ipipe_check_context+0x9 (anon_vma_prepare+0x=
1d)
     +func                -7249 anon_vma_prepare+0xe (handle_mm_fault+0x12c)
     +func                -7249 page_address+0xe (handle_mm_fault+0xa1)
     +func                -7249 handle_mm_fault+0xe (do_page_fault+0x290)
     +func                -7250 find_vma+0xa (do_page_fault+0x214)
     +func                -7250 down_read_trylock+0x9 (do_page_fault+0x1e5)
 |   +end     0x80000000  -7250 __ipipe_unstall_root+0x54 (do_page_fault+0x1=
bf)
 |   #begin   0x80000000  -7250 __ipipe_unstall_root+0x1a (do_page_fault+0x1=
bf)
     #func                -7250 __ipipe_unstall_root+0x8 (do_page_fault+0x1b=
f)
 |   #end     0x80000000  -7251 do_page_fault+0x3d (__ipipe_handle_exception=
+0x16b)
 |   #func                -7251 do_page_fault+0xe (__ipipe_handle_exception+=
0x16b)
 |   +func                -7251 __ipipe_handle_exception+0xe (error_code+0x7=
7)
 |   +end     0x8000000d  -7274 __ipipe_unstall_iret_root+0x6f (restore_noch=
eck_notrace+0x0)
 |   #begin   0x80000000  -7274 __ipipe_unstall_iret_root+0x1e (restore_noch=
eck_notrace+0x0)
     #func                -7275 __ipipe_unstall_iret_root+0x9 (restore_noche=
ck_notrace+0x0)
 |   +end     0x80000000  -7275 __ipipe_unstall_root+0x54 (__ipipe_restore_r=
oot+0x27)
 |   +func                -7275 __ipipe_unstall_root+0x8 (__ipipe_restore_ro=
ot+0x27)
 |   +func                -7275 __ipipe_restore_root+0x8 (__ipipe_handle_exc=
eption+0x194)
 |   +begin   0x80000000  -7275 __ipipe_handle_exception+0x17d (error_code+0=
x77)
     +func                -7275 up_read+0x8 (do_page_fault+0x2e7)
     +func                -7276 __inc_zone_state+0xe (__inc_zone_page_state+=
0x1d)
     +func                -7276 __inc_zone_page_state+0x8 (__page_set_anon_r=
map+0x32)
     +func                -7276 __page_set_anon_rmap+0x9 (page_add_new_anon_=
rmap+0x2e)
     +func                -7276 page_add_new_anon_rmap+0x9 (handle_mm_fault+=
0x1c9)
     +func                -7276 lru_cache_add_active+0x9 (handle_mm_fault+0x=
1bc)
     +func                -7276 _spin_lock+0x8 (handle_mm_fault+0x1aa)
     +func                -7277 page_address+0xe (handle_mm_fault+0x19d)
     +func                -7277 ipipe_check_context+0x9 (kunmap_atomic+0x4f)
     +func                -7277 kunmap_atomic+0x9 (get_page_from_freelist+0x=
325)
     +func                -7281 ipipe_check_context+0x9 (kmap_atomic_prot+0x=
1b)
     +func                -7281 kmap_atomic_prot+0xb (kmap_atomic+0x13)
     +func                -7281 kmap_atomic+0x8 (get_page_from_freelist+0x30=
6)
 |   +end     0x80000000  -7281 __ipipe_unstall_root+0x54 (__ipipe_restore_r=
oot+0x27)
 |   #begin   0x80000000  -7281 __ipipe_unstall_root+0x1a (__ipipe_restore_r=
oot+0x27)
     #func                -7282 __ipipe_unstall_root+0x8 (__ipipe_restore_ro=
ot+0x27)
     #func                -7282 __ipipe_restore_root+0x8 (get_page_from_free=
list+0x285)
     +func                -7282 ipipe_check_context+0x9 (get_page_from_freel=
ist+0x127)
     +func                -7282 zone_watermark_ok+0xe (get_page_from_freelis=
t+0x8a)
     +func                -7282 next_zones_zonelist+0x9 (get_page_from_freel=
ist+0x3a5)
     +func                -7282 next_zones_zonelist+0x9 (get_page_from_freel=
ist+0x2f)
     +func                -7283 get_page_from_freelist+0xe (__alloc_pages_in=
ternal+0xc2)
     +func                -7283 ipipe_check_context+0x9 (__alloc_pages_inter=
nal+0x96)
     +func                -7283 __alloc_pages_internal+0xe (__alloc_pages+0x=
f)
     +func                -7283 __alloc_pages+0x8 (handle_mm_fault+0x145)
     +func                -7283 ipipe_check_context+0x9 (anon_vma_prepare+0x=
1d)
     +func                -7283 anon_vma_prepare+0xe (handle_mm_fault+0x12c)
     +func                -7284 page_address+0xe (handle_mm_fault+0xa1)
     +func                -7284 handle_mm_fault+0xe (do_page_fault+0x290)
     +func                -7284 find_vma+0xa (do_page_fault+0x214)
     +func                -7284 down_read_trylock+0x9 (do_page_fault+0x1e5)
 |   +end     0x80000000  -7284 __ipipe_unstall_root+0x54 (do_page_fault+0x1=
bf)
 |   #begin   0x80000000  -7285 __ipipe_unstall_root+0x1a (do_page_fault+0x1=
bf)
     #func                -7285 __ipipe_unstall_root+0x8 (do_page_fault+0x1b=
f)
 |   #end     0x80000000  -7285 do_page_fault+0x3d (__ipipe_handle_exception=
+0x16b)
 |   #func                -7285 do_page_fault+0xe (__ipipe_handle_exception+=
0x16b)
 |   +func                -7285 __ipipe_handle_exception+0xe (error_code+0x7=
7)
 |   +end     0x8000000d  -7318 __ipipe_unstall_iret_root+0x6f (restore_noch=
eck_notrace+0x0)
 |   #begin   0x80000000  -7318 __ipipe_unstall_iret_root+0x1e (restore_noch=
eck_notrace+0x0)
     #func                -7318 __ipipe_unstall_iret_root+0x9 (restore_noche=
ck_notrace+0x0)
 |   +end     0x80000000  -7319 __ipipe_unstall_root+0x54 (__ipipe_restore_r=
oot+0x27)
 |   +func                -7319 __ipipe_unstall_root+0x8 (__ipipe_restore_ro=
ot+0x27)
 |   +func                -7319 __ipipe_restore_root+0x8 (__ipipe_handle_exc=
eption+0x194)
 |   +begin   0x80000000  -7319 __ipipe_handle_exception+0x17d (error_code+0=
x77)
     +func                -7319 up_read+0x8 (do_page_fault+0x2e7)
     +func                -7319 __inc_zone_state+0xe (__inc_zone_page_state+=
0x1d)
     +func                -7320 __inc_zone_page_state+0x8 (__page_set_anon_r=
map+0x32)
     +func                -7320 __page_set_anon_rmap+0x9 (page_add_new_anon_=
rmap+0x2e)
     +func                -7320 page_add_new_anon_rmap+0x9 (handle_mm_fault+=
0x1c9)
     +func                -7320 lru_cache_add_active+0x9 (handle_mm_fault+0x=
1bc)
     +func                -7320 _spin_lock+0x8 (handle_mm_fault+0x1aa)
     +func                -7320 page_address+0xe (handle_mm_fault+0x19d)
     +func                -7321 ipipe_check_context+0x9 (kunmap_atomic+0x4f)
     +func                -7321 kunmap_atomic+0x9 (get_page_from_freelist+0x=
325)
     +func                -7325 ipipe_check_context+0x9 (kmap_atomic_prot+0x=
1b)
     +func                -7325 kmap_atomic_prot+0xb (kmap_atomic+0x13)
     +func                -7326 kmap_atomic+0x8 (get_page_from_freelist+0x30=
6)
 |   +end     0x80000000  -7326 __ipipe_unstall_root+0x54 (__ipipe_restore_r=
oot+0x27)
 |   #begin   0x80000000  -7326 __ipipe_unstall_root+0x1a (__ipipe_restore_r=
oot+0x27)
     #func                -7326 __ipipe_unstall_root+0x8 (__ipipe_restore_ro=
ot+0x27)
     #func                -7326 __ipipe_restore_root+0x8 (get_page_from_free=
list+0x285)
     +func                -7326 ipipe_check_context+0x9 (get_page_from_freel=
ist+0x127)
     +func                -7327 zone_watermark_ok+0xe (get_page_from_freelis=
t+0x8a)
     +func                -7327 next_zones_zonelist+0x9 (get_page_from_freel=
ist+0x3a5)
     +func                -7327 next_zones_zonelist+0x9 (get_page_from_freel=
ist+0x2f)
     +func                -7327 get_page_from_freelist+0xe (__alloc_pages_in=
ternal+0xc2)
     +func                -7327 ipipe_check_context+0x9 (__alloc_pages_inter=
nal+0x96)
     +func                -7327 __alloc_pages_internal+0xe (__alloc_pages+0x=
f)
     +func                -7328 __alloc_pages+0x8 (handle_mm_fault+0x145)
     +func                -7328 ipipe_check_context+0x9 (anon_vma_prepare+0x=
1d)
     +func                -7328 anon_vma_prepare+0xe (handle_mm_fault+0x12c)
     +func                -7328 page_address+0xe (handle_mm_fault+0xa1)
     +func                -7328 handle_mm_fault+0xe (do_page_fault+0x290)
     +func                -7328 find_vma+0xa (do_page_fault+0x214)
     +func                -7329 down_read_trylock+0x9 (do_page_fault+0x1e5)
 |   +end     0x80000000  -7329 __ipipe_unstall_root+0x54 (do_page_fault+0x1=
bf)
 |   #begin   0x80000000  -7329 __ipipe_unstall_root+0x1a (do_page_fault+0x1=
bf)
     #func                -7329 __ipipe_unstall_root+0x8 (do_page_fault+0x1b=
f)
 |   #end     0x80000000  -7329 do_page_fault+0x3d (__ipipe_handle_exception=
+0x16b)
 |   #func                -7329 do_page_fault+0xe (__ipipe_handle_exception+=
0x16b)
 |   +func                -7330 __ipipe_handle_exception+0xe (error_code+0x7=
7)
 |   +end     0x8000000d  -7345 __ipipe_unstall_iret_root+0x6f (restore_noch=
eck_notrace+0x0)
 |   #begin   0x80000000  -7345 __ipipe_unstall_iret_root+0x1e (restore_noch=
eck_notrace+0x0)
     #func                -7345 __ipipe_unstall_iret_root+0x9 (restore_noche=
ck_notrace+0x0)
 |   +end     0x80000000  -7345 __ipipe_unstall_root+0x54 (__ipipe_restore_r=
oot+0x27)
 |   +func                -7345 __ipipe_unstall_root+0x8 (__ipipe_restore_ro=
ot+0x27)
 |   +func                -7345 __ipipe_restore_root+0x8 (__ipipe_handle_exc=
eption+0x194)
 |   +begin   0x80000000  -7346 __ipipe_handle_exception+0x17d (error_code+0=
x77)
     +func                -7346 up_read+0x8 (do_page_fault+0x2e7)
     +func                -7346 __inc_zone_state+0xe (__inc_zone_page_state+=
0x1d)
     +func                -7346 __inc_zone_page_state+0x8 (__page_set_anon_r=
map+0x32)
     +func                -7346 __page_set_anon_rmap+0x9 (page_add_new_anon_=
rmap+0x2e)
     +func                -7346 page_add_new_anon_rmap+0x9 (handle_mm_fault+=
0x1c9)
     +func                -7347 lru_cache_add_active+0x9 (handle_mm_fault+0x=
1bc)
     +func                -7347 _spin_lock+0x8 (handle_mm_fault+0x1aa)
     +func                -7347 page_address+0xe (handle_mm_fault+0x19d)
     +func                -7347 ipipe_check_context+0x9 (kunmap_atomic+0x4f)
     +func                -7348 kunmap_atomic+0x9 (get_page_from_freelist+0x=
325)
     +func                -7354 ipipe_check_context+0x9 (kmap_atomic_prot+0x=
1b)
     +func                -7354 kmap_atomic_prot+0xb (kmap_atomic+0x13)
     +func                -7354 kmap_atomic+0x8 (get_page_from_freelist+0x30=
6)
 |   +end     0x80000000  -7354 __ipipe_unstall_root+0x54 (__ipipe_restore_r=
oot+0x27)
 |   #begin   0x80000000  -7354 __ipipe_unstall_root+0x1a (__ipipe_restore_r=
oot+0x27)
     #func                -7354 __ipipe_unstall_root+0x8 (__ipipe_restore_ro=
ot+0x27)
     #func                -7354 __ipipe_restore_root+0x8 (get_page_from_free=
list+0x285)
     +func                -7355 ipipe_check_context+0x9 (get_page_from_freel=
ist+0x127)
     +func                -7355 zone_watermark_ok+0xe (get_page_from_freelis=
t+0x8a)
     +func                -7355 next_zones_zonelist+0x9 (get_page_from_freel=
ist+0x3a5)
     +func                -7355 next_zones_zonelist+0x9 (get_page_from_freel=
ist+0x2f)
     +func                -7355 get_page_from_freelist+0xe (__alloc_pages_in=
ternal+0xc2)
     +func                -7356 ipipe_check_context+0x9 (__alloc_pages_inter=
nal+0x96)
     +func                -7356 __alloc_pages_internal+0xe (__alloc_pages+0x=
f)
     +func                -7356 __alloc_pages+0x8 (handle_mm_fault+0x145)
     +func                -7356 ipipe_check_context+0x9 (anon_vma_prepare+0x=
1d)
     +func                -7356 anon_vma_prepare+0xe (handle_mm_fault+0x12c)
     +func                -7356 page_address+0xe (handle_mm_fault+0xa1)
     +func                -7357 handle_mm_fault+0xe (do_page_fault+0x290)
     +func                -7357 find_vma+0xa (do_page_fault+0x214)
     +func                -7357 down_read_trylock+0x9 (do_page_fault+0x1e5)
 |   +end     0x80000000  -7357 __ipipe_unstall_root+0x54 (do_page_fault+0x1=
bf)
 |   #begin   0x80000000  -7357 __ipipe_unstall_root+0x1a (do_page_fault+0x1=
bf)
     #func                -7358 __ipipe_unstall_root+0x8 (do_page_fault+0x1b=
f)
 |   #end     0x80000000  -7358 do_page_fault+0x3d (__ipipe_handle_exception=
+0x16b)
 |   #func                -7358 do_page_fault+0xe (__ipipe_handle_exception+=
0x16b)
 |   +func                -7358 __ipipe_handle_exception+0xe (error_code+0x7=
7)
 |   +end     0x8000000d  -7404 __ipipe_unstall_iret_root+0x6f (restore_noch=
eck_notrace+0x0)
 |   #begin   0x80000000  -7404 __ipipe_unstall_iret_root+0x1e (restore_noch=
eck_notrace+0x0)
     #func                -7404 __ipipe_unstall_iret_root+0x9 (restore_noche=
ck_notrace+0x0)
 |   +end     0x80000000  -7405 __ipipe_unstall_root+0x54 (__ipipe_restore_r=
oot+0x27)
 |   +func                -7405 __ipipe_unstall_root+0x8 (__ipipe_restore_ro=
ot+0x27)
 |   +func                -7405 __ipipe_restore_root+0x8 (__ipipe_handle_exc=
eption+0x194)
 |   +begin   0x80000000  -7405 __ipipe_handle_exception+0x17d (error_code+0=
x77)
     +func                -7405 up_read+0x8 (do_page_fault+0x2e7)
     +func                -7405 __inc_zone_state+0xe (__inc_zone_page_state+=
0x1d)
     +func                -7406 __inc_zone_page_state+0x8 (__page_set_anon_r=
map+0x32)
     +func                -7406 __page_set_anon_rmap+0x9 (page_add_new_anon_=
rmap+0x2e)
     +func                -7406 page_add_new_anon_rmap+0x9 (handle_mm_fault+=
0x1c9)
     +func                -7406 lru_cache_add_active+0x9 (handle_mm_fault+0x=
1bc)
     +func                -7406 _spin_lock+0x8 (handle_mm_fault+0x1aa)
     +func                -7406 page_address+0xe (handle_mm_fault+0x19d)
     +func                -7407 ipipe_check_context+0x9 (kunmap_atomic+0x4f)
     +func                -7407 kunmap_atomic+0x9 (get_page_from_freelist+0x=
325)
     +func                -7413 ipipe_check_context+0x9 (kmap_atomic_prot+0x=
1b)
     +func                -7413 kmap_atomic_prot+0xb (kmap_atomic+0x13)
     +func                -7413 kmap_atomic+0x8 (get_page_from_freelist+0x30=
6)
 |   +end     0x80000000  -7414 __ipipe_unstall_root+0x54 (__ipipe_restore_r=
oot+0x27)
 |   #begin   0x80000000  -7414 __ipipe_unstall_root+0x1a (__ipipe_restore_r=
oot+0x27)
     #func                -7414 __ipipe_unstall_root+0x8 (__ipipe_restore_ro=
ot+0x27)
     #func                -7414 __ipipe_restore_root+0x8 (get_page_from_free=
list+0x285)
     +func                -7414 ipipe_check_context+0x9 (get_page_from_freel=
ist+0x127)
     +func                -7414 zone_watermark_ok+0xe (get_page_from_freelis=
t+0x8a)
     +func                -7415 next_zones_zonelist+0x9 (get_page_from_freel=
ist+0x3a5)
     +func                -7415 next_zones_zonelist+0x9 (get_page_from_freel=
ist+0x2f)
     +func                -7415 get_page_from_freelist+0xe (__alloc_pages_in=
ternal+0xc2)
     +func                -7415 ipipe_check_context+0x9 (__alloc_pages_inter=
nal+0x96)
     +func                -7415 __alloc_pages_internal+0xe (__alloc_pages+0x=
f)
     +func                -7415 __alloc_pages+0x8 (handle_mm_fault+0x145)
     +func                -7416 ipipe_check_context+0x9 (anon_vma_prepare+0x=
1d)
     +func                -7416 anon_vma_prepare+0xe (handle_mm_fault+0x12c)
     +func                -7416 page_address+0xe (handle_mm_fault+0xa1)
     +func                -7416 handle_mm_fault+0xe (do_page_fault+0x290)
     +func                -7416 find_vma+0xa (do_page_fault+0x214)
     +func                -7417 down_read_trylock+0x9 (do_page_fault+0x1e5)
 |   +end     0x80000000  -7417 __ipipe_unstall_root+0x54 (do_page_fault+0x1=
bf)
 |   #begin   0x80000000  -7417 __ipipe_unstall_root+0x1a (do_page_fault+0x1=
bf)
     #func                -7417 __ipipe_unstall_root+0x8 (do_page_fault+0x1b=
f)
 |   #end     0x80000000  -7417 do_page_fault+0x3d (__ipipe_handle_exception=
+0x16b)
 |   #func                -7418 do_page_fault+0xe (__ipipe_handle_exception+=
0x16b)
 |   +func                -7418 __ipipe_handle_exception+0xe (error_code+0x7=
7)
 |   +end     0x8000000d  -7473 __ipipe_unstall_iret_root+0x6f (restore_noch=
eck_notrace+0x0)
 |   #begin   0x80000000  -7474 __ipipe_unstall_iret_root+0x1e (restore_noch=
eck_notrace+0x0)
     #func                -7474 __ipipe_unstall_iret_root+0x9 (restore_noche=
ck_notrace+0x0)
 |   +end     0x80000000  -7474 __ipipe_unstall_root+0x54 (__ipipe_restore_r=
oot+0x27)
 |   +func                -7474 __ipipe_unstall_root+0x8 (__ipipe_restore_ro=
ot+0x27)
 |   +func                -7474 __ipipe_restore_root+0x8 (__ipipe_handle_exc=
eption+0x194)
 |   +begin   0x80000000  -7474 __ipipe_handle_exception+0x17d (error_code+0=
x77)
     +func                -7475 up_read+0x8 (do_page_fault+0x2e7)
     +func                -7475 __inc_zone_state+0xe (__inc_zone_page_state+=
0x1d)
     +func                -7475 __inc_zone_page_state+0x8 (__page_set_anon_r=
map+0x32)
     +func                -7475 __page_set_anon_rmap+0x9 (page_add_new_anon_=
rmap+0x2e)
     +func                -7475 page_add_new_anon_rmap+0x9 (handle_mm_fault+=
0x1c9)
     +func                -7476 lru_cache_add_active+0x9 (handle_mm_fault+0x=
1bc)
     +func                -7476 _spin_lock+0x8 (handle_mm_fault+0x1aa)
     +func                -7476 page_address+0xe (handle_mm_fault+0x19d)
     +func                -7476 ipipe_check_context+0x9 (kunmap_atomic+0x4f)
     +func                -7477 kunmap_atomic+0x9 (get_page_from_freelist+0x=
325)
     +func                -7480 ipipe_check_context+0x9 (kmap_atomic_prot+0x=
1b)
     +func                -7480 kmap_atomic_prot+0xb (kmap_atomic+0x13)
     +func                -7480 kmap_atomic+0x8 (get_page_from_freelist+0x30=
6)
 |   +end     0x80000000  -7480 __ipipe_unstall_root+0x54 (__ipipe_restore_r=
oot+0x27)
 |   #begin   0x80000000  -7481 __ipipe_unstall_root+0x1a (__ipipe_restore_r=
oot+0x27)
     #func                -7481 __ipipe_unstall_root+0x8 (__ipipe_restore_ro=
ot+0x27)
     #func                -7481 __ipipe_restore_root+0x8 (get_page_from_free=
list+0x285)
     +func                -7481 ipipe_check_context+0x9 (get_page_from_freel=
ist+0x127)
     +func                -7482 zone_watermark_ok+0xe (get_page_from_freelis=
t+0x8a)
     +func                -7482 next_zones_zonelist+0x9 (get_page_from_freel=
ist+0x3a5)
     +func                -7482 next_zones_zonelist+0x9 (get_page_from_freel=
ist+0x2f)
     +func                -7482 get_page_from_freelist+0xe (__alloc_pages_in=
ternal+0xc2)
     +func                -7482 ipipe_check_context+0x9 (__alloc_pages_inter=
nal+0x96)
     +func                -7482 __alloc_pages_internal+0xe (__alloc_pages+0x=
f)
     +func                -7483 __alloc_pages+0x8 (handle_mm_fault+0x145)
     +func                -7483 ipipe_check_context+0x9 (anon_vma_prepare+0x=
1d)
     +func                -7483 anon_vma_prepare+0xe (handle_mm_fault+0x12c)
     +func                -7483 page_address+0xe (handle_mm_fault+0xa1)
     +func                -7484 handle_mm_fault+0xe (do_page_fault+0x290)
     +func                -7484 find_vma+0xa (do_page_fault+0x214)
     +func                -7484 down_read_trylock+0x9 (do_page_fault+0x1e5)
 |   +end     0x80000000  -7484 __ipipe_unstall_root+0x54 (do_page_fault+0x1=
bf)
 |   #begin   0x80000000  -7484 __ipipe_unstall_root+0x1a (do_page_fault+0x1=
bf)
     #func                -7485 __ipipe_unstall_root+0x8 (do_page_fault+0x1b=
f)
 |   #end     0x80000000  -7485 do_page_fault+0x3d (__ipipe_handle_exception=
+0x16b)
 |   #func                -7485 do_page_fault+0xe (__ipipe_handle_exception+=
0x16b)
 |   +func                -7485 __ipipe_handle_exception+0xe (error_code+0x7=
7)
 |   +end     0x8000000d  -7541 __ipipe_unstall_iret_root+0x6f (restore_noch=
eck_notrace+0x0)
 |   #begin   0x80000000  -7541 __ipipe_unstall_iret_root+0x1e (restore_noch=
eck_notrace+0x0)
     #func                -7542 __ipipe_unstall_iret_root+0x9 (restore_noche=
ck_notrace+0x0)
 |   +end     0x80000000  -7542 __ipipe_unstall_root+0x54 (__ipipe_restore_r=
oot+0x27)
 |   +func                -7542 __ipipe_unstall_root+0x8 (__ipipe_restore_ro=
ot+0x27)
 |   +func                -7542 __ipipe_restore_root+0x8 (__ipipe_handle_exc=
eption+0x194)
 |   +begin   0x80000000  -7542 __ipipe_handle_exception+0x17d (error_code+0=
x77)
     +func                -7542 up_read+0x8 (do_page_fault+0x2e7)
     +func                -7543 __inc_zone_state+0xe (__inc_zone_page_state+=
0x1d)
     +func                -7543 __inc_zone_page_state+0x8 (__page_set_anon_r=
map+0x32)
     +func                -7543 __page_set_anon_rmap+0x9 (page_add_new_anon_=
rmap+0x2e)
     +func                -7543 page_add_new_anon_rmap+0x9 (handle_mm_fault+=
0x1c9)
     +func                -7543 lru_cache_add_active+0x9 (handle_mm_fault+0x=
1bc)
     +func                -7544 _spin_lock+0x8 (handle_mm_fault+0x1aa)
     +func                -7544 page_address+0xe (handle_mm_fault+0x19d)
     +func                -7544 ipipe_check_context+0x9 (kunmap_atomic+0x4f)
     +func                -7544 kunmap_atomic+0x9 (get_page_from_freelist+0x=
325)
     +func                -7548 ipipe_check_context+0x9 (kmap_atomic_prot+0x=
1b)
     +func                -7548 kmap_atomic_prot+0xb (kmap_atomic+0x13)
     +func                -7548 kmap_atomic+0x8 (get_page_from_freelist+0x30=
6)
 |   +end     0x80000000  -7548 __ipipe_unstall_root+0x54 (__ipipe_restore_r=
oot+0x27)
---[ end trace 28ab5eb1b829afa9 ]---

--=_2cgrwpf9e5no
Content-Type: text/plain;
	charset=ISO-8859-2;
	name="bug_2.6.27_xeno_2.4.6.1.txt"
Content-Disposition: attachment;
	filename="bug_2.6.27_xeno_2.4.6.1.txt"
Content-Transfer-Encoding: quoted-printable

Linux version 2.6.27.18-xenomai (root@domain.hid) (gcc version 4.1.2 (Gentoo 4=
.1.2 p1.1)) #1 SMP Thu Feb 19 17:11:53 CET 2009
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
DMI 2.3 present.
last_pfn =3D 0x3ff71 max_arch_pfn =3D 0x100000
kernel direct mapping tables up to 38000000 @ 7000-c000
ACPI: RSDP 000FEBA0, 0014 (r0 DELL  )
ACPI: RSDT 000FD501, 0038 (r1 DELL    GX260          6 ASL        61)
ACPI: FACP 000FD539, 0074 (r1 DELL    GX260          6 ASL        61)
ACPI: DSDT FFFD5D84, 2563 (r1   DELL    dt_ex     1000 MSFT  100000D)
ACPI: FACS 3FF71000, 0040
ACPI: SSDT FFFD82E7, 00A7 (r1   DELL    st_ex     1000 MSFT  100000D)
ACPI: APIC 000FD5AD, 006C (r1 DELL    GX260          6 ASL        61)
ACPI: BOOT 000FD619, 0028 (r1 DELL    GX260          6 ASL        61)
ACPI: ASF! 000FD641, 0067 (r16 DELL    GX260          6 ASL        61)
127MB HIGHMEM available.
896MB LOWMEM available.
  mapped low ram: 0 - 38000000
  low ram: 00000000 - 38000000
  bootmap 00008000 - 0000f000
(8 early reservations) =3D=3D> bootmem [0000000000 - 0038000000]
  #0 [0000000000 - 0000001000]   BIOS data page =3D=3D> [0000000000 - 000000=
1000]
  #1 [0000001000 - 0000002000]    EX TRAMPOLINE =3D=3D> [0000001000 - 000000=
2000]
  #2 [0000006000 - 0000007000]       TRAMPOLINE =3D=3D> [0000006000 - 000000=
7000]
  #3 [0000100000 - 0000a0e8e8]    TEXT DATA BSS =3D=3D> [0000100000 - 0000a0=
e8e8]
  #4 [0000a0f000 - 0000a13000]    INIT_PG_TABLE =3D=3D> [0000a0f000 - 0000a1=
3000]
  #5 [000009fc00 - 0000100000]    BIOS reserved =3D=3D> [000009fc00 - 000010=
0000]
  #6 [0000007000 - 0000008000]          PGTABLE =3D=3D> [0000007000 - 000000=
8000]
  #7 [0000008000 - 000000f000]          BOOTMAP =3D=3D> [0000008000 - 000000=
f000]
found SMP MP-table at [c00fe710] 000fe710
Zone PFN ranges:
  DMA      0x00000000 -> 0x00001000
  Normal   0x00001000 -> 0x00038000
  HighMem  0x00038000 -> 0x0003ff71
Movable zone start PFN for each node
early_node_map[2] active PFN ranges
    0: 0x00000000 -> 0x000000a0
    0: 0x00000100 -> 0x0003ff71
On node 0 totalpages: 261905
free_area_init_node: node 0, pgdat c0533580, node_mem_map c1000000
  DMA zone: 3968 pages, LIFO batch:0
  Normal zone: 223520 pages, LIFO batch:31
  HighMem zone: 32370 pages, LIFO batch:7
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
SMP: Allowing 2 CPUs, 1 hotplug CPUs
mapped APIC to ffffb000 (fee00000)
mapped IOAPIC to ffffa000 (fec00000)
Allocating PCI resources starting at 50000000 (gap: 40000000:bec00000)
PERCPU: Allocating 3190556 bytes of per cpu data
NR_CPUS: 2, nr_cpu_ids: 2, nr_node_ids 1
Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 259858
Kernel command line: ro root=3D/dev/sda3
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Initializing CPU#0
PID hash table entries: 4096 (order: 12, 16384 bytes)
TSC: PIT calibration confirmed by PMTIMER.
TSC: using PIT calibration value
Detected 2391.127 MHz processor.
I-pipe 2.2-04: pipeline enabled.
Console: colour VGA+ 80x25
console [tty0] enabled
Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
Memory: 1022656k/1048004k available (2978k kernel code, 24672k reserved, 139=
4k data, 3356k init, 130500k highmem)
virtual kernel memory layout:
    fixmap  : 0xfff9f000 - 0xfffff000   ( 384 kB)
    pkmap   : 0xff800000 - 0xffc00000   (4096 kB)
    vmalloc : 0xf8800000 - 0xff7fe000   ( 111 MB)
    lowmem  : 0xc0000000 - 0xf8000000   ( 896 MB)
      .init : 0xc054c000 - 0xc0893000   (3356 kB)
      .data : 0xc03e8aba - 0xc05453c8   (1394 kB)
      .text : 0xc0100000 - 0xc03e8aba   (2978 kB)
Checking if this processor honours the WP bit even in supervisor mode...Ok.
CPA: page pool initialized 1 of 1 pages preallocated
SLUB: Genslabs=3D12, HWalign=3D128, Order=3D0-3, MinObjects=3D0, CPUs=3D2, N=
odes=3D1
Calibrating delay loop (skipped), value calculated using timer frequency.. 4=
782.25 BogoMIPS (lpj=3D9564508)
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
ACPI: Core revision 20080609
Parsing all Control Methods:
Table [DSDT](id 0001) - 303 Objects with 29 Devices 116 Methods 21 Regions
Parsing all Control Methods:
Table [SSDT](id 0002) - 7 Objects with 0 Devices 1 Methods 0 Regions
 tbxface-0596 [00] tb_load_namespace     : ACPI Tables successfully acquired
evxfevnt-0091 [00] enable                : Transition to ACPI mode successfu=
l
ENABLING IO-APIC IRQs
..TIMER: vector=3D0x31 apic1=3D0 pin1=3D2 apic2=3D-1 pin2=3D-1
CPU0: Intel(R) Pentium(R) 4 CPU 2.40GHz stepping 04
Brought up 1 CPUs
Total of 1 processors activated (4782.25 BogoMIPS).
net_namespace: 812 bytes
NET: Registered protocol family 16
No dock devices found.
ACPI: bus type pci registered
PCI: PCI BIOS revision 2.10 entry at 0xfbdf8, last bus=3D2
PCI: Using configuration type 1 for base access
evgpeblk-0957 [00] ev_create_gpe_block   : GPE 00 to 1F [_GPE] 4 regs on int=
 0x9
ACPI: EC: Look up EC in DSDT
Completing Region/Field/Buffer/Package initialization:......................=
....................
Initialized 17/21 Regions 0/0 Fields 9/9 Buffers 16/16 Packages (319 nodes)
Initializing Device/Processor/Thermal objects by executing _INI methods:....
Executed 4 _INI methods requiring 3 _STA executions (examined 33 objects)
evgpeblk-1054 [00] ev_initialize_gpe_bloc: Found 7 Wake, Enabled 1 Runtime G=
PEs in this block
ACPI: Interpreter enabled
ACPI: (supports S0 S5)
ACPI: Using IOAPIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (0000:00)
PCI: 0000:00:00.0 reg 10 32bit mmio: [e8000000, efffffff]
PCI: 0000:00:1d.0 reg 20 io port: [ff80, ff9f]
PCI: 0000:00:1d.1 reg 20 io port: [ff60, ff7f]
PCI: 0000:00:1d.2 reg 20 io port: [ff40, ff5f]
PCI: 0000:00:1d.7 reg 10 32bit mmio: [ffa20800, ffa20bff]
pci 0000:00:1d.7: PME# supported from D0 D3hot D3cold
pci 0000:00:1d.7: PME# disabled
* The chipset may have PM-Timer Bug. Due to workarounds for a bug,
* this clock source is slow. If you are sure your timer does not have
* this bug, please use "acpi_pm_good" to disable the workaround
HPET not enabled in BIOS. You might try hpet=3Dforce boot option
pci 0000:00:1f.0: quirk: region 0800-087f claimed by ICH4 ACPI/GPIO/TCO
pci 0000:00:1f.0: quirk: region 0880-08bf claimed by ICH4 GPIO
PCI: 0000:00:1f.1 reg 10 io port: [0, 7]
PCI: 0000:00:1f.1 reg 14 io port: [0, 3]
PCI: 0000:00:1f.1 reg 18 io port: [0, 7]
PCI: 0000:00:1f.1 reg 1c io port: [0, 3]
PCI: 0000:00:1f.1 reg 20 io port: [ffa0, ffaf]
PCI: 0000:00:1f.1 reg 24 32bit mmio: [0, 3ff]
PCI: 0000:00:1f.3 reg 20 io port: [cc80, cc9f]
PCI: 0000:00:1f.5 reg 10 io port: [c800, c8ff]
PCI: 0000:00:1f.5 reg 14 io port: [cc40, cc7f]
PCI: 0000:00:1f.5 reg 18 32bit mmio: [ffa20400, ffa205ff]
PCI: 0000:00:1f.5 reg 1c 32bit mmio: [ffa20000, ffa200ff]
pci 0000:00:1f.5: PME# supported from D0 D3hot D3cold
pci 0000:00:1f.5: PME# disabled
PCI: 0000:01:00.0 reg 10 32bit mmio: [f0000000, f7ffffff]
PCI: 0000:01:00.0 reg 14 io port: [ec00, ecff]
PCI: 0000:01:00.0 reg 18 32bit mmio: [ff8f0000, ff8fffff]
PCI: 0000:01:00.0 reg 30 32bit mmio: [80000000, 8001ffff]
pci 0000:01:00.0: supports D1
pci 0000:01:00.0: supports D2
PCI: bridge 0000:00:01.0 io port: [e000, efff]
PCI: bridge 0000:00:01.0 32bit mmio: [ff800000, ff9fffff]
PCI: bridge 0000:00:01.0 32bit mmio pref: [f0000000, f7ffffff]
PCI: 0000:02:07.0 reg 10 io port: [dc00, dcff]
PCI: 0000:02:07.0 reg 14 32bit mmio: [ff6ffc00, ff6ffcff]
pci 0000:02:07.0: supports D1
pci 0000:02:07.0: supports D2
pci 0000:02:07.0: PME# supported from D1 D2 D3hot D3cold
pci 0000:02:07.0: PME# disabled
PCI: 0000:02:0c.0 reg 10 32bit mmio: [ff6c0000, ff6dffff]
PCI: 0000:02:0c.0 reg 18 io port: [d8c0, d8ff]
pci 0000:02:0c.0: PME# supported from D0 D3hot D3cold
pci 0000:02:0c.0: PME# disabled
pci 0000:00:1e.0: transparent bridge
PCI: bridge 0000:00:1e.0 io port: [d000, dfff]
PCI: bridge 0000:00:1e.0 32bit mmio: [ff600000, ff7fffff]
bus 00 -> node 0
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
pnp 00:0b: io resource (0x800-0x85f) overlaps 0000:00:1f.0 BAR 7 (0x800-0x87=
f), disabling
pnp 00:0b: io resource (0x860-0x8ff) overlaps 0000:00:1f.0 BAR 7 (0x800-0x87=
f), disabling
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
system 00:0b: ioport range 0xc00-0xc7f has been reserved
pci 0000:00:01.0: PCI bridge, secondary bus 0000:01
pci 0000:00:01.0:   IO window: 0xe000-0xefff
pci 0000:00:01.0:   MEM window: 0xff800000-0xff9fffff
pci 0000:00:01.0:   PREFETCH window: 0x000000f0000000-0x000000f7ffffff
pci 0000:00:1e.0: PCI bridge, secondary bus 0000:02
pci 0000:00:1e.0:   IO window: 0xd000-0xdfff
pci 0000:00:1e.0:   MEM window: 0xff600000-0xff7fffff
pci 0000:00:1e.0:   PREFETCH window: disabled
pci 0000:00:1e.0: setting latency timer to 64
bus: 00 index 0 io port: [0, ffff]
bus: 00 index 1 mmio: [0, ffffffffffffffff]
bus: 01 index 0 io port: [e000, efff]
bus: 01 index 1 mmio: [ff800000, ff9fffff]
bus: 01 index 2 mmio: [f0000000, f7ffffff]
bus: 01 index 3 mmio: [0, 0]
bus: 02 index 0 io port: [d000, dfff]
bus: 02 index 1 mmio: [ff600000, ff7fffff]
bus: 02 index 2 mmio: [0, 0]
bus: 02 index 3 io port: [0, ffff]
bus: 02 index 4 mmio: [0, ffffffffffffffff]
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
HugeTLB registered 4 MB page size, pre-allocated 0 pages
msgmni has been set to 1743
io scheduler noop registered
io scheduler anticipatory registered
io scheduler deadline registered
io scheduler cfq registered (default)
pci 0000:01:00.0: Boot video device
radeonfb 0000:01:00.0: PCI INT A -> GSI 16 (level, low) -> IRQ 16
radeonfb: Found Intel x86 BIOS ROM Image
radeonfb: Retrieved PLL infos from BIOS
radeonfb: Reference=3D27.00 MHz (RefDiv=3D12) Memory=3D245.00 Mhz, System=3D=
170.00 MHz
radeonfb: PLL min 20000 max 35000
i2c-adapter i2c-1: unable to read EDID block.
i2c-adapter i2c-1: unable to read EDID block.
i2c-adapter i2c-1: unable to read EDID block.
Switched to high resolution mode on CPU 0
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
Real Time Clock Driver v1.12ac
Linux agpgart interface v0.103
agpgart-intel 0000:00:00.0: Intel 830M Chipset
agpgart-intel 0000:00:00.0: AGP aperture is 128M @ 0xe8000000
Serial: 8250/16550 driver4 ports, IRQ sharing disabled
serial8250: ttyS0 at I/O 0x3f8 (irq =3D 4) is a 16550A
00:09: ttyS0 at I/O 0x3f8 (irq =3D 4) is a 16550A
brd: module loaded
loop: module loaded
Intel(R) PRO/1000 Network Driver - version 7.3.21-k3-NAPI
Copyright (c) 1999-2006 Intel Corporation.
e1000 0000:02:0c.0: PCI INT A -> GSI 18 (level, low) -> IRQ 18
e1000: 0000:02:0c.0: e1000_probe: (PCI:33MHz:32-bit) 00:08:74:2a:e8:60
e1000: eth0: e1000_probe: Intel(R) PRO/1000 Network Connection
8139too Fast Ethernet driver 0.9.28
8139too 0000:02:07.0: PCI INT A -> GSI 16 (level, low) -> IRQ 16
eth1: RealTek RTL8139 at 0xf8816c00, 00:1f:1f:14:69:b1, IRQ 16
eth1:  Identified 8139 chip type 'RTL-8100B/8139D'
3ware Storage Controller device driver for Linux v1.26.02.002.
Driver 'sd' needs updating - please use bus_type methods
Driver 'sr' needs updating - please use bus_type methods
ata_piix 0000:00:1f.1: version 2.12
ata_piix 0000:00:1f.1: enabling device (0005 -> 0007)
ata_piix 0000:00:1f.1: PCI INT A -> GSI 18 (level, low) -> IRQ 18
ata_piix 0000:00:1f.1: setting latency timer to 64
scsi0 : ata_piix
scsi1 : ata_piix
ata1: PATA max UDMA/100 cmd 0x1f0 ctl 0x3f6 bmdma 0xffa0 irq 14
ata2: PATA max UDMA/100 cmd 0x170 ctl 0x376 bmdma 0xffa8 irq 15
ata1.00: ATA-7: ST3500630A, 3.AAE, max UDMA/100
ata1.00: 976773168 sectors, multi 8: LBA48=20
ata1.01: ATA-5: WDC WD400BB-60DGA0, 05.03E05, max UDMA/100
ata1.01: 78165360 sectors, multi 8: LBA=20
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
sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support=
 DPO or FUA
sd 0:0:0:0: [sda] 976773168 512-byte hardware sectors (500108 MB)
sd 0:0:0:0: [sda] Write Protect is off
sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support=
 DPO or FUA
 sda: sda1 sda2 sda3 sda4 < >
sd 0:0:0:0: [sda] Attached SCSI disk
sd 0:0:0:0: Attached scsi generic sg0 type 0
scsi 0:0:1:0: Direct-Access     ATA      WDC WD400BB-60DG 05.0 PQ: 0 ANSI: 5
sd 0:0:1:0: [sdb] 78165360 512-byte hardware sectors (40021 MB)
sd 0:0:1:0: [sdb] Write Protect is off
sd 0:0:1:0: [sdb] Mode Sense: 00 3a 00 00
sd 0:0:1:0: [sdb] Write cache: enabled, read cache: enabled, doesn't support=
 DPO or FUA
sd 0:0:1:0: [sdb] 78165360 512-byte hardware sectors (40021 MB)
sd 0:0:1:0: [sdb] Write Protect is off
sd 0:0:1:0: [sdb] Mode Sense: 00 3a 00 00
sd 0:0:1:0: [sdb] Write cache: enabled, read cache: enabled, doesn't support=
 DPO or FUA
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
ehci_hcd 0000:00:1d.7: PCI INT D -> GSI 23 (level, low) -> IRQ 23
ehci_hcd 0000:00:1d.7: setting latency timer to 64
ehci_hcd 0000:00:1d.7: EHCI Host Controller
ehci_hcd 0000:00:1d.7: new USB bus registered, assigned bus number 1
ehci_hcd 0000:00:1d.7: debug port 1
ehci_hcd 0000:00:1d.7: cache line size of 128 is not supported
ehci_hcd 0000:00:1d.7: irq 23, io mem 0xffa20800
ehci_hcd 0000:00:1d.7: USB 2.0 started, EHCI 1.00, driver 10 Dec 2004
usb usb1: configuration #1 chosen from 1 choice
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 6 ports detected
ohci_hcd: 2006 August 04 USB 1.1 'Open' Host Controller (OHCI) Driver
USB Universal Host Controller Interface driver v3.0
uhci_hcd 0000:00:1d.0: PCI INT A -> GSI 16 (level, low) -> IRQ 16
uhci_hcd 0000:00:1d.0: setting latency timer to 64
uhci_hcd 0000:00:1d.0: UHCI Host Controller
uhci_hcd 0000:00:1d.0: new USB bus registered, assigned bus number 2
uhci_hcd 0000:00:1d.0: irq 16, io base 0x0000ff80
usb usb2: configuration #1 chosen from 1 choice
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 2 ports detected
usb 1-6: new high speed USB device using ehci_hcd and address 2
uhci_hcd 0000:00:1d.1: PCI INT B -> GSI 19 (level, low) -> IRQ 19
uhci_hcd 0000:00:1d.1: setting latency timer to 64
uhci_hcd 0000:00:1d.1: UHCI Host Controller
uhci_hcd 0000:00:1d.1: new USB bus registered, assigned bus number 3
uhci_hcd 0000:00:1d.1: irq 19, io base 0x0000ff60
usb usb3: configuration #1 chosen from 1 choice
hub 3-0:1.0: USB hub found
hub 3-0:1.0: 2 ports detected
usb 1-6: configuration #1 chosen from 1 choice
uhci_hcd 0000:00:1d.2: PCI INT C -> GSI 18 (level, low) -> IRQ 18
uhci_hcd 0000:00:1d.2: setting latency timer to 64
uhci_hcd 0000:00:1d.2: UHCI Host Controller
uhci_hcd 0000:00:1d.2: new USB bus registered, assigned bus number 4
uhci_hcd 0000:00:1d.2: irq 18, io base 0x0000ff40
usb usb4: configuration #1 chosen from 1 choice
hub 4-0:1.0: USB hub found
hub 4-0:1.0: 2 ports detected
usbcore: registered new interface driver usblp
Initializing USB Mass Storage driver...
scsi2 : SCSI emulation for USB Mass Storage devices
usb-storage: device found at 2
usb-storage: waiting for device to settle before scanning
usbcore: registered new interface driver usb-storage
USB Mass Storage support registered.
PNP: PS/2 Controller [PNP0303:KBD,PNP0f13:MOU] at 0x60,0x64 irq 1,12
serio: i8042 KBD port at 0x60,0x64 irq 1
serio: i8042 AUX port at 0x60,0x64 irq 12
mice: PS/2 mouse device common for all mice
cpuidle: using governor ladder
cpuidle: using governor menu
oprofile: using NMI interrupt.
TCP cubic registered
NET: Registered protocol family 10
IPv6 over IPv4 tunneling driver
NET: Registered protocol family 17
Using IPI No-Shortcut mode
input: AT Translated Set 2 keyboard as /class/input/input2
input: ImPS/2 Logitech Wheel Mouse as /class/input/input3
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
Freeing unused kernel memory: 3356k freed
scsi 2:0:0:0: Direct-Access     -Pretec  04GB             1.00 PQ: 0 ANSI: 2
sd 2:0:0:0: [sdc] 7897088 512-byte hardware sectors (4043 MB)
sd 2:0:0:0: [sdc] Write Protect is off
sd 2:0:0:0: [sdc] Mode Sense: 00 00 00 00
sd 2:0:0:0: [sdc] Assuming drive cache: write through
sd 2:0:0:0: [sdc] 7897088 512-byte hardware sectors (4043 MB)
sd 2:0:0:0: [sdc] Write Protect is off
sd 2:0:0:0: [sdc] Mode Sense: 00 00 00 00
sd 2:0:0:0: [sdc] Assuming drive cache: write through
 sdc:
sd 2:0:0:0: [sdc] Attached SCSI removable disk
sd 2:0:0:0: Attached scsi generic sg4 type 0
usb-storage: device scan complete
EXT3 FS on sda3, internal journal
fuse init (API version 7.9)
ADDRCONF(NETDEV_UP): eth0: link is not ready
e1000: eth0: e1000_watchdog: NIC Link is Up 1000 Mbps Full Duplex, Flow Cont=
rol: RX/TX
ADDRCONF(NETDEV_CHANGE): eth0: link becomes ready
eth0: no IPv6 routers present
------------[ cut here ]------------
kernel BUG at fs/buffer.c:1289!
invalid opcode: 0000 [#1] SMP=20
Modules linked in: fuse

Pid: 5991, comm: emerge Not tainted (2.6.27.18-xenomai #1)
EIP: 0060:[<c01bcb84>] EFLAGS: 00010246 CPU: 0
EIP is at __find_get_block+0x39/0x1cd
EAX: 00000000 EBX: 00000000 ECX: 00000000 EDX: ffffffff
ESI: 00000000 EDI: f7420200 EBP: f6e1fc68 ESP: f6e1fc2c
 DS: 007b ES: 007b FS: 00d8 GS: 0033 SS: 0068
Process emerge (pid: 5991, ti=3Df6e1e000 task=3Df6dd1f80 task.ti=3Df6e1e000)=
<0>
I-pipe domain Linux
Stack: 00f0f811 00000000 0000637c c1adebcc 00000286 00000000 c09d3600 000000=
00=20
       00000000 00000000 f7755358 f6e1fcc0 00000000 00000000 f7755358 f6e1fc=
c0=20
       c01bcd37 00001000 00f0f811 00000000 f7420200 00000000 c01db1dc 000000=
00=20
Call Trace:
 [<c01bcd37>] ? __getblk+0x1f/0x251
 [<c01db1dc>] ? ext3_getblk+0xe/0x18f
 [<c01db21d>] ? ext3_getblk+0x4f/0x18f
 [<c01db26f>] ? ext3_getblk+0xa1/0x18f
 [<c01de428>] ? ext3_find_entry+0x31e/0x595
 [<c014556e>] ? __ipipe_restore_root+0x8/0x29
 [<c03e48c0>] ? _spin_lock+0x8/0x1e
 [<c01dfb28>] ? ext3_lookup+0xe/0xa7
 [<c0113857>] ? mcount+0x1f/0x23
 [<c01dfb44>] ? ext3_lookup+0x2a/0xa7
 [<c01a6d64>] ? do_lookup+0xb6/0x153
 [<c01a833d>] ? __link_path_walk+0x6af/0xa3c
 [<c01a6798>] ? path_get+0x8/0x27
 [<c0113857>] ? mcount+0x1f/0x23
 [<c01a8708>] ? path_walk+0x3e/0x77
 [<c01a8861>] ? do_path_lookup+0xe4/0xfe
 [<c01a9215>] ? __path_lookup_intent_open+0x47/0x79
 [<c01a925c>] ? path_lookup_open+0x15/0x17
 [<c01a9405>] ? do_filp_open+0x9b/0x5ac
 [<c01b1dcb>] ? expand_files+0xe/0x235
 [<c0113857>] ? mcount+0x1f/0x23
 [<c01b2053>] ? alloc_fd+0x61/0xd9
 [<c019eead>] ? do_sys_open+0x49/0xc3
 [<c019ef73>] ? sys_open+0x23/0x2b
 [<c0102cf8>] ? sysenter_do_call+0x12/0x16
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
Code: 89 c7 89 55 c4 89 4d c8 9c fa 64 a1 00 d1 58 c0 8d 80 80 e2 58 c0 0f b=
a 20 00 19 d2 9d 83 fa 01 19 c0 25 00 02 00 00 85 c0 75 04 <0f> 0b eb fe b8 =
00 a3 9c c0 e8 b7 7c f8 ff 9c fa 64 a1 00 d1 58=20
EIP: [<c01bcb84>] __find_get_block+0x39/0x1cd SS:ESP 0068:f6e1fc2c
I-pipe tracer log (1000 points):
     #func                    0 ipipe_trace_panic_freeze+0x9 (oops_enter+0xd=
)
     #func                    0 oops_enter+0x8 (oops_begin+0xe)
     #func                    0 oops_begin+0x9 (die+0x19)
     #func                    0 die+0xe (do_trap+0x8f)
     #func                   -2 search_module_extables+0xa (search_exception=
_tables+0x27)
     #func                   -4 search_extable+0x9 (search_exception_tables+=
0x1c)
     #func                   -5 search_exception_tables+0x9 (fixup_exception=
+0x13)
     #func                   -5 fixup_exception+0x9 (do_trap+0x70)
     #func                   -5 do_trap+0xe (do_invalid_op+0x71)
     #func                   -6 kprobe_exceptions_notify+0xe (notifier_call_=
chain+0x30)
     #func                   -7 notifier_call_chain+0xe (__atomic_notifier_c=
all_chain+0x16)
     #func                   -7 __atomic_notifier_call_chain+0x8 (atomic_not=
ifier_call_chain+0x11)
     #func                   -7 atomic_notifier_call_chain+0x8 (notify_die+0=
x32)
     #func                   -7 notify_die+0xb (do_invalid_op+0x48)
     #func                   -8 do_invalid_op+0xd (__ipipe_handle_exception+=
0x16e)
     #func                   -8 __ipipe_handle_exception+0xe (error_code+0x7=
7)
     #func                  -10 __find_get_block+0xe (__getblk+0x1f)
     #func                  -10 __getblk+0xe (ext3_getblk+0xa1)
     #func                  -11 ext3_get_branch+0xe (ext3_get_blocks_handle+=
0x82)
     #func                  -12 ext3_block_to_path+0xe (ext3_get_blocks_hand=
le+0x58)
     #func                  -12 ext3_get_blocks_handle+0x11 (ext3_getblk+0x4=
f)
     #func                  -13 ext3_getblk+0xe (ext3_find_entry+0x31e)
     #func                  -15 ext3_find_entry+0x11 (ext3_lookup+0x2a)
     #func                  -15 ext3_lookup+0xe (do_lookup+0xb6)
     #func                  -16 _spin_lock+0x8 (d_alloc+0x144)
     #func                  -16 __ipipe_restore_root+0x8 (kmem_cache_alloc+0=
x97)
     #func                  -17 ipipe_check_context+0x9 (kmem_cache_alloc+0x=
24)
     #func                  -17 kmem_cache_alloc+0xe (d_alloc+0x23)
     #func                  -17 d_alloc+0xe (do_lookup+0x99)
     #func                  -17 __d_lookup+0xe (d_lookup+0x27)
     #func                  -18 d_lookup+0xb (do_lookup+0x7b)
     #func                  -18 _cond_resched+0x8 (mutex_lock+0x1d)
     #func                  -18 ipipe_check_context+0x9 (mutex_lock+0x18)
     #func                  -18 mutex_lock+0xc (do_lookup+0x71)
     #func                  -19 __d_lookup+0xe (do_lookup+0x2a)
     #func                  -19 do_lookup+0xe (__link_path_walk+0x6af)
     #func                  -19 generic_permission+0xb (ext3_permission+0x12=
)
     #func                  -19 ext3_permission+0x8 (inode_permission+0x5f)
     #func                  -19 inode_permission+0xa (vfs_permission+0x13)
     #func                  -19 vfs_permission+0x8 (__link_path_walk+0x117)
     #func                  -20 _atomic_dec_and_lock+0xa (dput+0x33)
     #func                  -20 dput+0x9 (__link_path_walk+0x51a)
     #func                  -20 __follow_mount+0xb (do_lookup+0x54)
     #func                  -20 memcmp+0xa (__d_lookup+0xa6)
     #func                  -20 _spin_lock+0x8 (__d_lookup+0x67)
     #func                  -20 __d_lookup+0xe (do_lookup+0x2a)
     #func                  -20 do_lookup+0xe (__link_path_walk+0x2b9)
     #func                  -21 generic_permission+0xb (ext3_permission+0x12=
)
     #func                  -21 ext3_permission+0x8 (inode_permission+0x5f)
     #func                  -21 inode_permission+0xa (vfs_permission+0x13)
     #func                  -21 vfs_permission+0x8 (__link_path_walk+0x117)
     #func                  -21 _atomic_dec_and_lock+0xa (dput+0x33)
     #func                  -21 dput+0x9 (__link_path_walk+0x51a)
     #func                  -22 __follow_mount+0xb (do_lookup+0x54)
     #func                  -22 memcmp+0xa (__d_lookup+0xa6)
     #func                  -22 _spin_lock+0x8 (__d_lookup+0x67)
     #func                  -22 __d_lookup+0xe (do_lookup+0x2a)
     #func                  -22 do_lookup+0xe (__link_path_walk+0x2b9)
     #func                  -22 generic_permission+0xb (ext3_permission+0x12=
)
     #func                  -22 ext3_permission+0x8 (inode_permission+0x5f)
     #func                  -23 inode_permission+0xa (vfs_permission+0x13)
     #func                  -23 vfs_permission+0x8 (__link_path_walk+0x117)
     #func                  -23 _atomic_dec_and_lock+0xa (dput+0x33)
     #func                  -23 dput+0x9 (__link_path_walk+0x51a)
     #func                  -23 __follow_mount+0xb (do_lookup+0x54)
     #func                  -23 memcmp+0xa (__d_lookup+0xa6)
     #func                  -23 _spin_lock+0x8 (__d_lookup+0x67)
     #func                  -24 __d_lookup+0xe (do_lookup+0x2a)
     #func                  -24 do_lookup+0xe (__link_path_walk+0x2b9)
     #func                  -24 generic_permission+0xb (ext3_permission+0x12=
)
     #func                  -24 ext3_permission+0x8 (inode_permission+0x5f)
     #func                  -24 inode_permission+0xa (vfs_permission+0x13)
     #func                  -24 vfs_permission+0x8 (__link_path_walk+0x117)
     #func                  -25 _atomic_dec_and_lock+0xa (dput+0x33)
     #func                  -25 dput+0x9 (__link_path_walk+0x51a)
     #func                  -25 __follow_mount+0xb (do_lookup+0x54)
     #func                  -25 memcmp+0xa (__d_lookup+0xa6)
     #func                  -25 _spin_lock+0x8 (__d_lookup+0x67)
     #func                  -25 __d_lookup+0xe (do_lookup+0x2a)
     #func                  -25 do_lookup+0xe (__link_path_walk+0x2b9)
     #func                  -26 generic_permission+0xb (ext3_permission+0x12=
)
     #func                  -26 ext3_permission+0x8 (inode_permission+0x5f)
     #func                  -26 inode_permission+0xa (vfs_permission+0x13)
     #func                  -26 vfs_permission+0x8 (__link_path_walk+0x117)
     #func                  -26 _atomic_dec_and_lock+0xa (dput+0x33)
     #func                  -26 dput+0x9 (__link_path_walk+0x51a)
     #func                  -26 __follow_mount+0xb (do_lookup+0x54)
     #func                  -27 memcmp+0xa (__d_lookup+0xa6)
     #func                  -27 _spin_lock+0x8 (__d_lookup+0x67)
     #func                  -27 __d_lookup+0xe (do_lookup+0x2a)
     #func                  -27 do_lookup+0xe (__link_path_walk+0x2b9)
     #func                  -27 generic_permission+0xb (ext3_permission+0x12=
)
     #func                  -27 ext3_permission+0x8 (inode_permission+0x5f)
     #func                  -28 inode_permission+0xa (vfs_permission+0x13)
     #func                  -28 vfs_permission+0x8 (__link_path_walk+0x117)
     #func                  -28 __link_path_walk+0xe (path_walk+0x3e)
     #func                  -28 path_get+0x8 (path_walk+0x35)
     #func                  -28 path_walk+0xe (do_path_lookup+0xe4)
     #func                  -28 path_get+0x8 (do_path_lookup+0x73)
     #func                  -28 _read_lock+0x8 (do_path_lookup+0x43)
     #func                  -28 do_path_lookup+0xe (__path_lookup_intent_ope=
n+0x47)
     #func                  -29 __percpu_counter_add+0xe (get_empty_filp+0x8=
c)
     #func                  -29 __ipipe_restore_root+0x8 (kmem_cache_alloc+0=
x97)
     #func                  -29 ipipe_check_context+0x9 (kmem_cache_alloc+0x=
24)
     #func                  -29 kmem_cache_alloc+0xe (get_empty_filp+0x6f)
     #func                  -29 get_empty_filp+0xa (__path_lookup_intent_ope=
n+0x23)
     #func                  -30 __path_lookup_intent_open+0xe (path_lookup_o=
pen+0x15)
     #func                  -30 path_lookup_open+0x8 (do_filp_open+0x9b)
     #func                  -30 do_filp_open+0xe (do_sys_open+0x49)
     #func                  -30 expand_files+0xe (alloc_fd+0x61)
     #func                  -30 find_next_zero_bit+0xa (alloc_fd+0x52)
     #func                  -30 _spin_lock+0x8 (alloc_fd+0x2a)
     #func                  -31 alloc_fd+0xe (do_sys_open+0x33)
     #func                  -31 _cond_resched+0x8 (strncpy_from_user+0x3b)
     #func                  -31 ipipe_check_context+0x9 (strncpy_from_user+0=
x36)
     #func                  -31 strncpy_from_user+0xb (getname+0x67)
     #func                  -31 __ipipe_restore_root+0x8 (kmem_cache_alloc+0=
x97)
     #func                  -32 ipipe_check_context+0x9 (kmem_cache_alloc+0x=
24)
     #func                  -32 kmem_cache_alloc+0xe (getname+0x1f)
     #func                  -32 getname+0xe (do_sys_open+0x19)
     #func                  -32 do_sys_open+0xe (sys_open+0x23)
     #func                  -32 sys_open+0xb (sysenter_do_call+0x12)
     #func                  -32 __ipipe_syscall_root+0xa (sysenter_past_esp+=
0x51)
 |   #end     0x8000000d    -33 __ipipe_unstall_iret_root+0x64 (sysenter_out=
+0x0)
 |   #begin   0x80000000    -34 __ipipe_unstall_iret_root+0x2e (sysenter_out=
+0x0)
     #func                  -34 __ipipe_unstall_iret_root+0xa (sysenter_out+=
0x0)
     #func                  -34 __ipipe_restore_root+0x8 (kmem_cache_free+0x=
b5)
     #func                  -34 ipipe_check_context+0x9 (kmem_cache_free+0x4=
3)
     #func                  -34 kmem_cache_free+0xe (do_sys_open+0xb8)
     #func                  -34 _spin_lock+0x8 (put_unused_fd+0x23)
     #func                  -35 put_unused_fd+0xa (do_sys_open+0x5b)
     #func                  -35 __ipipe_restore_root+0x8 (call_rcu+0x8f)
     #func                  -35 ipipe_check_context+0x9 (call_rcu+0x1f)
     #func                  -35 call_rcu+0xa (put_filp+0x3a)
     #func                  -35 __percpu_counter_add+0xe (put_filp+0x2e)
     #func                  -35 file_kill+0x9 (put_filp+0x1d)
     #func                  -35 put_filp+0x9 (release_open_intent+0x16)
     #func                  -36 release_open_intent+0x8 (__path_lookup_inten=
t_open+0x6f)
     #func                  -36 _atomic_dec_and_lock+0xa (mntput_no_expire+0=
x1d)
     #func                  -36 mntput_no_expire+0xe (path_put+0x25)
     #func                  -36 _atomic_dec_and_lock+0xa (dput+0x33)
     #func                  -36 dput+0x9 (path_put+0x13)
     #func                  -36 path_put+0x9 (path_walk+0x6e)
     #func                  -37 _atomic_dec_and_lock+0xa (mntput_no_expire+0=
x1d)
     #func                  -37 mntput_no_expire+0xe (path_put+0x25)
     #func                  -37 _spin_lock+0x8 (dput+0x43)
     #func                  -37 _spin_lock+0x8 (_atomic_dec_and_lock+0x32)
     #func                  -37 _atomic_dec_and_lock+0xa (dput+0x33)
     #func                  -37 _cond_resched+0x8 (dput+0x27)
     #func                  -37 ipipe_check_context+0x9 (dput+0x22)
     #func                  -38 dput+0x9 (path_put+0x13)
     #func                  -38 path_put+0x9 (__link_path_walk+0xa11)
     #func                  -38 _atomic_dec_and_lock+0xa (dput+0x33)
     #func                  -38 dput+0x9 (__link_path_walk+0x91f)
     #func                  -38 __follow_mount+0xb (do_lookup+0x54)
     #func                  -38 memcmp+0xa (__d_lookup+0xa6)
     #func                  -39 _spin_lock+0x8 (__d_lookup+0x67)
     #func                  -39 __d_lookup+0xe (do_lookup+0x2a)
     #func                  -39 do_lookup+0xe (__link_path_walk+0x6af)
     #func                  -39 generic_permission+0xb (ext3_permission+0x12=
)
     #func                  -39 ext3_permission+0x8 (inode_permission+0x5f)
     #func                  -40 inode_permission+0xa (vfs_permission+0x13)
     #func                  -40 vfs_permission+0x8 (__link_path_walk+0x117)
     #func                  -40 _atomic_dec_and_lock+0xa (dput+0x33)
     #func                  -40 dput+0x9 (__link_path_walk+0x51a)
     #func                  -40 __follow_mount+0xb (do_lookup+0x54)
     #func                  -40 memcmp+0xa (__d_lookup+0xa6)
     #func                  -40 _spin_lock+0x8 (__d_lookup+0x67)
     #func                  -41 __d_lookup+0xe (do_lookup+0x2a)
     #func                  -41 do_lookup+0xe (__link_path_walk+0x2b9)
     #func                  -41 generic_permission+0xb (ext3_permission+0x12=
)
     #func                  -41 ext3_permission+0x8 (inode_permission+0x5f)
     #func                  -41 inode_permission+0xa (vfs_permission+0x13)
     #func                  -41 vfs_permission+0x8 (__link_path_walk+0x117)
     #func                  -41 _atomic_dec_and_lock+0xa (dput+0x33)
     #func                  -42 dput+0x9 (__link_path_walk+0x51a)
     #func                  -42 __follow_mount+0xb (do_lookup+0x54)
     #func                  -42 memcmp+0xa (__d_lookup+0xa6)
     #func                  -42 _spin_lock+0x8 (__d_lookup+0x67)
     #func                  -42 __d_lookup+0xe (do_lookup+0x2a)
     #func                  -42 do_lookup+0xe (__link_path_walk+0x2b9)
     #func                  -43 generic_permission+0xb (ext3_permission+0x12=
)
     #func                  -43 ext3_permission+0x8 (inode_permission+0x5f)
     #func                  -43 inode_permission+0xa (vfs_permission+0x13)
     #func                  -43 vfs_permission+0x8 (__link_path_walk+0x117)
     #func                  -43 _atomic_dec_and_lock+0xa (dput+0x33)
     #func                  -43 dput+0x9 (__link_path_walk+0x51a)
     #func                  -43 __follow_mount+0xb (do_lookup+0x54)
     #func                  -44 memcmp+0xa (__d_lookup+0xa6)
     #func                  -44 _spin_lock+0x8 (__d_lookup+0x67)
     #func                  -44 __d_lookup+0xe (do_lookup+0x2a)
     #func                  -44 do_lookup+0xe (__link_path_walk+0x2b9)
     #func                  -44 generic_permission+0xb (ext3_permission+0x12=
)
     #func                  -44 ext3_permission+0x8 (inode_permission+0x5f)
     #func                  -44 inode_permission+0xa (vfs_permission+0x13)
     #func                  -45 vfs_permission+0x8 (__link_path_walk+0x117)
     #func                  -45 _atomic_dec_and_lock+0xa (dput+0x33)
     #func                  -45 dput+0x9 (__link_path_walk+0x51a)
     #func                  -45 __follow_mount+0xb (do_lookup+0x54)
     #func                  -45 memcmp+0xa (__d_lookup+0xa6)
     #func                  -45 _spin_lock+0x8 (__d_lookup+0x67)
     #func                  -46 __d_lookup+0xe (do_lookup+0x2a)
     #func                  -46 do_lookup+0xe (__link_path_walk+0x2b9)
     #func                  -46 generic_permission+0xb (ext3_permission+0x12=
)
     #func                  -46 ext3_permission+0x8 (inode_permission+0x5f)
     #func                  -46 inode_permission+0xa (vfs_permission+0x13)
     #func                  -46 vfs_permission+0x8 (__link_path_walk+0x117)
     #func                  -46 _atomic_dec_and_lock+0xa (dput+0x33)
     #func                  -47 dput+0x9 (__link_path_walk+0x51a)
     #func                  -47 __follow_mount+0xb (do_lookup+0x54)
     #func                  -47 memcmp+0xa (__d_lookup+0xa6)
     #func                  -47 _spin_lock+0x8 (__d_lookup+0x67)
     #func                  -47 __d_lookup+0xe (do_lookup+0x2a)
     #func                  -47 do_lookup+0xe (__link_path_walk+0x2b9)
     #func                  -48 generic_permission+0xb (ext3_permission+0x12=
)
     #func                  -48 ext3_permission+0x8 (inode_permission+0x5f)
     #func                  -48 inode_permission+0xa (vfs_permission+0x13)
     #func                  -48 vfs_permission+0x8 (__link_path_walk+0x117)
     #func                  -48 __link_path_walk+0xe (path_walk+0x3e)
     #func                  -48 path_get+0x8 (path_walk+0x35)
     #func                  -48 path_walk+0xe (do_path_lookup+0xe4)
     #func                  -49 path_get+0x8 (do_path_lookup+0x73)
     #func                  -49 _read_lock+0x8 (do_path_lookup+0x43)
     #func                  -49 do_path_lookup+0xe (__path_lookup_intent_ope=
n+0x47)
     #func                  -49 __percpu_counter_add+0xe (get_empty_filp+0x8=
c)
     #func                  -49 __ipipe_restore_root+0x8 (kmem_cache_alloc+0=
x97)
     #func                  -50 ipipe_check_context+0x9 (kmem_cache_alloc+0x=
24)
     #func                  -50 kmem_cache_alloc+0xe (get_empty_filp+0x6f)
     #func                  -50 get_empty_filp+0xa (__path_lookup_intent_ope=
n+0x23)
     #func                  -50 __path_lookup_intent_open+0xe (path_lookup_o=
pen+0x15)
     #func                  -50 path_lookup_open+0x8 (do_filp_open+0x9b)
     #func                  -50 do_filp_open+0xe (do_sys_open+0x49)
     #func                  -50 expand_files+0xe (alloc_fd+0x61)
     #func                  -51 find_next_zero_bit+0xa (alloc_fd+0x52)
     #func                  -51 _spin_lock+0x8 (alloc_fd+0x2a)
     #func                  -51 alloc_fd+0xe (do_sys_open+0x33)
     #func                  -51 _cond_resched+0x8 (strncpy_from_user+0x3b)
     #func                  -51 ipipe_check_context+0x9 (strncpy_from_user+0=
x36)
     #func                  -52 strncpy_from_user+0xb (getname+0x67)
     #func                  -52 __ipipe_restore_root+0x8 (kmem_cache_alloc+0=
x97)
     #func                  -52 ipipe_check_context+0x9 (kmem_cache_alloc+0x=
24)
     #func                  -52 kmem_cache_alloc+0xe (getname+0x1f)
     #func                  -52 getname+0xe (do_sys_open+0x19)
     #func                  -52 do_sys_open+0xe (sys_open+0x23)
     #func                  -53 sys_open+0xb (sysenter_do_call+0x12)
     #func                  -53 __ipipe_syscall_root+0xa (sysenter_past_esp+=
0x51)
 |   #end     0x8000000d    -54 __ipipe_unstall_iret_root+0x64 (sysenter_out=
+0x0)
 |   #begin   0x80000000    -54 __ipipe_unstall_iret_root+0x2e (sysenter_out=
+0x0)
     #func                  -55 __ipipe_unstall_iret_root+0xa (sysenter_out+=
0x0)
     #func                  -55 __ipipe_restore_root+0x8 (kmem_cache_free+0x=
b5)
     #func                  -55 ipipe_check_context+0x9 (kmem_cache_free+0x4=
3)
     #func                  -55 kmem_cache_free+0xe (do_sys_open+0xb8)
     #func                  -55 _spin_lock+0x8 (put_unused_fd+0x23)
     #func                  -55 put_unused_fd+0xa (do_sys_open+0x5b)
     #func                  -56 __ipipe_restore_root+0x8 (call_rcu+0x8f)
     #func                  -56 ipipe_check_context+0x9 (call_rcu+0x1f)
     #func                  -56 call_rcu+0xa (put_filp+0x3a)
     #func                  -56 __percpu_counter_add+0xe (put_filp+0x2e)
     #func                  -56 file_kill+0x9 (put_filp+0x1d)
     #func                  -56 put_filp+0x9 (release_open_intent+0x16)
     #func                  -57 release_open_intent+0x8 (__path_lookup_inten=
t_open+0x6f)
     #func                  -57 _atomic_dec_and_lock+0xa (mntput_no_expire+0=
x1d)
     #func                  -57 mntput_no_expire+0xe (path_put+0x25)
     #func                  -57 _atomic_dec_and_lock+0xa (dput+0x33)
     #func                  -57 dput+0x9 (path_put+0x13)
     #func                  -57 path_put+0x9 (path_walk+0x6e)
     #func                  -57 _atomic_dec_and_lock+0xa (mntput_no_expire+0=
x1d)
     #func                  -58 mntput_no_expire+0xe (path_put+0x25)
     #func                  -58 _spin_lock+0x8 (dput+0x43)
     #func                  -58 _spin_lock+0x8 (_atomic_dec_and_lock+0x32)
     #func                  -58 _atomic_dec_and_lock+0xa (dput+0x33)
     #func                  -58 _cond_resched+0x8 (dput+0x27)
     #func                  -58 ipipe_check_context+0x9 (dput+0x22)
     #func                  -58 dput+0x9 (path_put+0x13)
     #func                  -59 path_put+0x9 (__link_path_walk+0xa11)
     #func                  -59 _atomic_dec_and_lock+0xa (dput+0x33)
     #func                  -59 dput+0x9 (__link_path_walk+0x91f)
     #func                  -59 __follow_mount+0xb (do_lookup+0x54)
     #func                  -59 memcmp+0xa (__d_lookup+0xa6)
     #func                  -59 _spin_lock+0x8 (__d_lookup+0x67)
     #func                  -60 __d_lookup+0xe (do_lookup+0x2a)
     #func                  -60 do_lookup+0xe (__link_path_walk+0x6af)
     #func                  -60 generic_permission+0xb (ext3_permission+0x12=
)
     #func                  -60 ext3_permission+0x8 (inode_permission+0x5f)
     #func                  -61 inode_permission+0xa (vfs_permission+0x13)
     #func                  -61 vfs_permission+0x8 (__link_path_walk+0x117)
     #func                  -61 _atomic_dec_and_lock+0xa (dput+0x33)
     #func                  -61 dput+0x9 (__link_path_walk+0x51a)
     #func                  -61 __follow_mount+0xb (do_lookup+0x54)
     #func                  -61 memcmp+0xa (__d_lookup+0xa6)
     #func                  -61 _spin_lock+0x8 (__d_lookup+0x67)
     #func                  -62 __d_lookup+0xe (do_lookup+0x2a)
     #func                  -62 do_lookup+0xe (__link_path_walk+0x2b9)
     #func                  -62 generic_permission+0xb (ext3_permission+0x12=
)
     #func                  -62 ext3_permission+0x8 (inode_permission+0x5f)
     #func                  -62 inode_permission+0xa (vfs_permission+0x13)
     #func                  -62 vfs_permission+0x8 (__link_path_walk+0x117)
     #func                  -63 _atomic_dec_and_lock+0xa (dput+0x33)
     #func                  -63 dput+0x9 (__link_path_walk+0x51a)
     #func                  -63 __follow_mount+0xb (do_lookup+0x54)
     #func                  -63 memcmp+0xa (__d_lookup+0xa6)
     #func                  -63 _spin_lock+0x8 (__d_lookup+0x67)
     #func                  -63 __d_lookup+0xe (do_lookup+0x2a)
     #func                  -63 do_lookup+0xe (__link_path_walk+0x2b9)
     #func                  -64 generic_permission+0xb (ext3_permission+0x12=
)
     #func                  -64 ext3_permission+0x8 (inode_permission+0x5f)
     #func                  -64 inode_permission+0xa (vfs_permission+0x13)
     #func                  -64 vfs_permission+0x8 (__link_path_walk+0x117)
     #func                  -64 _atomic_dec_and_lock+0xa (dput+0x33)
     #func                  -64 dput+0x9 (__link_path_walk+0x51a)
     #func                  -64 __follow_mount+0xb (do_lookup+0x54)
     #func                  -65 memcmp+0xa (__d_lookup+0xa6)
     #func                  -65 _spin_lock+0x8 (__d_lookup+0x67)
     #func                  -65 __d_lookup+0xe (do_lookup+0x2a)
     #func                  -65 do_lookup+0xe (__link_path_walk+0x2b9)
     #func                  -65 generic_permission+0xb (ext3_permission+0x12=
)
     #func                  -65 ext3_permission+0x8 (inode_permission+0x5f)
     #func                  -66 inode_permission+0xa (vfs_permission+0x13)
     #func                  -66 vfs_permission+0x8 (__link_path_walk+0x117)
     #func                  -66 _atomic_dec_and_lock+0xa (dput+0x33)
     #func                  -66 dput+0x9 (__link_path_walk+0x51a)
     #func                  -66 __follow_mount+0xb (do_lookup+0x54)
     #func                  -66 memcmp+0xa (__d_lookup+0xa6)
     #func                  -67 _spin_lock+0x8 (__d_lookup+0x67)
     #func                  -67 __d_lookup+0xe (do_lookup+0x2a)
     #func                  -67 do_lookup+0xe (__link_path_walk+0x2b9)
     #func                  -67 generic_permission+0xb (ext3_permission+0x12=
)
     #func                  -67 ext3_permission+0x8 (inode_permission+0x5f)
     #func                  -67 inode_permission+0xa (vfs_permission+0x13)
     #func                  -67 vfs_permission+0x8 (__link_path_walk+0x117)
     #func                  -68 _atomic_dec_and_lock+0xa (dput+0x33)
     #func                  -68 dput+0x9 (__link_path_walk+0x51a)
     #func                  -68 __follow_mount+0xb (do_lookup+0x54)
     #func                  -68 memcmp+0xa (__d_lookup+0xa6)
     #func                  -68 _spin_lock+0x8 (__d_lookup+0x67)
     #func                  -68 __d_lookup+0xe (do_lookup+0x2a)
     #func                  -68 do_lookup+0xe (__link_path_walk+0x2b9)
     #func                  -69 generic_permission+0xb (ext3_permission+0x12=
)
     #func                  -69 ext3_permission+0x8 (inode_permission+0x5f)
     #func                  -69 inode_permission+0xa (vfs_permission+0x13)
     #func                  -69 vfs_permission+0x8 (__link_path_walk+0x117)
     #func                  -69 __link_path_walk+0xe (path_walk+0x3e)
     #func                  -69 path_get+0x8 (path_walk+0x35)
     #func                  -69 path_walk+0xe (do_path_lookup+0xe4)
     #func                  -70 path_get+0x8 (do_path_lookup+0x73)
     #func                  -70 _read_lock+0x8 (do_path_lookup+0x43)
     #func                  -70 do_path_lookup+0xe (__path_lookup_intent_ope=
n+0x47)
     #func                  -70 __percpu_counter_add+0xe (get_empty_filp+0x8=
c)
     #func                  -70 __ipipe_restore_root+0x8 (kmem_cache_alloc+0=
x97)
     #func                  -71 ipipe_check_context+0x9 (kmem_cache_alloc+0x=
24)
     #func                  -71 kmem_cache_alloc+0xe (get_empty_filp+0x6f)
     #func                  -71 get_empty_filp+0xa (__path_lookup_intent_ope=
n+0x23)
     #func                  -71 __path_lookup_intent_open+0xe (path_lookup_o=
pen+0x15)
     #func                  -71 path_lookup_open+0x8 (do_filp_open+0x9b)
     #func                  -71 do_filp_open+0xe (do_sys_open+0x49)
     #func                  -72 expand_files+0xe (alloc_fd+0x61)
     #func                  -72 find_next_zero_bit+0xa (alloc_fd+0x52)
     #func                  -72 _spin_lock+0x8 (alloc_fd+0x2a)
     #func                  -72 alloc_fd+0xe (do_sys_open+0x33)
     #func                  -73 _cond_resched+0x8 (strncpy_from_user+0x3b)
     #func                  -73 ipipe_check_context+0x9 (strncpy_from_user+0=
x36)
     #func                  -73 strncpy_from_user+0xb (getname+0x67)
     #func                  -73 __ipipe_restore_root+0x8 (kmem_cache_alloc+0=
x97)
     #func                  -73 ipipe_check_context+0x9 (kmem_cache_alloc+0x=
24)
     #func                  -73 kmem_cache_alloc+0xe (getname+0x1f)
     #func                  -74 getname+0xe (do_sys_open+0x19)
     #func                  -74 do_sys_open+0xe (sys_open+0x23)
     #func                  -74 sys_open+0xb (sysenter_do_call+0x12)
     #func                  -74 __ipipe_syscall_root+0xa (sysenter_past_esp+=
0x51)
 |   #end     0x8000000d    -76 __ipipe_unstall_iret_root+0x64 (sysenter_out=
+0x0)
 |   #begin   0x80000000    -76 __ipipe_unstall_iret_root+0x2e (sysenter_out=
+0x0)
     #func                  -76 __ipipe_unstall_iret_root+0xa (sysenter_out+=
0x0)
     #func                  -76 __ipipe_restore_root+0x8 (kmem_cache_free+0x=
b5)
     #func                  -77 ipipe_check_context+0x9 (kmem_cache_free+0x4=
3)
     #func                  -77 kmem_cache_free+0xe (do_sys_open+0xb8)
     #func                  -77 _spin_lock+0x8 (put_unused_fd+0x23)
     #func                  -77 put_unused_fd+0xa (do_sys_open+0x5b)
     #func                  -78 __ipipe_restore_root+0x8 (call_rcu+0x8f)
     #func                  -78 ipipe_check_context+0x9 (call_rcu+0x1f)
     #func                  -78 call_rcu+0xa (put_filp+0x3a)
     #func                  -78 __percpu_counter_add+0xe (put_filp+0x2e)
     #func                  -78 file_kill+0x9 (put_filp+0x1d)
     #func                  -78 put_filp+0x9 (release_open_intent+0x16)
     #func                  -79 release_open_intent+0x8 (__path_lookup_inten=
t_open+0x6f)
     #func                  -79 _atomic_dec_and_lock+0xa (mntput_no_expire+0=
x1d)
     #func                  -79 mntput_no_expire+0xe (path_put+0x25)
     #func                  -79 _atomic_dec_and_lock+0xa (dput+0x33)
     #func                  -79 dput+0x9 (path_put+0x13)
     #func                  -79 path_put+0x9 (path_walk+0x6e)
     #func                  -80 _atomic_dec_and_lock+0xa (mntput_no_expire+0=
x1d)
     #func                  -80 mntput_no_expire+0xe (path_put+0x25)
     #func                  -80 _spin_lock+0x8 (dput+0x43)
     #func                  -80 _spin_lock+0x8 (_atomic_dec_and_lock+0x32)
     #func                  -80 _atomic_dec_and_lock+0xa (dput+0x33)
     #func                  -80 _cond_resched+0x8 (dput+0x27)
     #func                  -81 ipipe_check_context+0x9 (dput+0x22)
     #func                  -81 dput+0x9 (path_put+0x13)
     #func                  -81 path_put+0x9 (__link_path_walk+0xa11)
     #func                  -81 _atomic_dec_and_lock+0xa (dput+0x33)
     #func                  -81 dput+0x9 (__link_path_walk+0x91f)
     #func                  -81 __follow_mount+0xb (do_lookup+0x54)
     #func                  -82 memcmp+0xa (__d_lookup+0xa6)
     #func                  -82 _spin_lock+0x8 (__d_lookup+0x67)
     #func                  -82 __d_lookup+0xe (do_lookup+0x2a)
     #func                  -82 do_lookup+0xe (__link_path_walk+0x6af)
     #func                  -82 generic_permission+0xb (ext3_permission+0x12=
)
     #func                  -82 ext3_permission+0x8 (inode_permission+0x5f)
     #func                  -83 inode_permission+0xa (vfs_permission+0x13)
     #func                  -83 vfs_permission+0x8 (__link_path_walk+0x117)
     #func                  -83 _atomic_dec_and_lock+0xa (dput+0x33)
     #func                  -83 dput+0x9 (__link_path_walk+0x51a)
     #func                  -83 __follow_mount+0xb (do_lookup+0x54)
     #func                  -83 memcmp+0xa (__d_lookup+0xa6)
     #func                  -83 _spin_lock+0x8 (__d_lookup+0x67)
     #func                  -84 __d_lookup+0xe (do_lookup+0x2a)
     #func                  -84 do_lookup+0xe (__link_path_walk+0x2b9)
     #func                  -84 generic_permission+0xb (ext3_permission+0x12=
)
     #func                  -84 ext3_permission+0x8 (inode_permission+0x5f)
     #func                  -84 inode_permission+0xa (vfs_permission+0x13)
     #func                  -84 vfs_permission+0x8 (__link_path_walk+0x117)
     #func                  -85 _atomic_dec_and_lock+0xa (dput+0x33)
     #func                  -85 dput+0x9 (__link_path_walk+0x51a)
     #func                  -85 __follow_mount+0xb (do_lookup+0x54)
     #func                  -85 memcmp+0xa (__d_lookup+0xa6)
     #func                  -85 _spin_lock+0x8 (__d_lookup+0x67)
     #func                  -85 __d_lookup+0xe (do_lookup+0x2a)
     #func                  -85 do_lookup+0xe (__link_path_walk+0x2b9)
     #func                  -86 generic_permission+0xb (ext3_permission+0x12=
)
     #func                  -86 ext3_permission+0x8 (inode_permission+0x5f)
     #func                  -86 inode_permission+0xa (vfs_permission+0x13)
     #func                  -86 vfs_permission+0x8 (__link_path_walk+0x117)
     #func                  -86 _atomic_dec_and_lock+0xa (dput+0x33)
     #func                  -86 dput+0x9 (__link_path_walk+0x51a)
     #func                  -86 __follow_mount+0xb (do_lookup+0x54)
     #func                  -87 memcmp+0xa (__d_lookup+0xa6)
     #func                  -87 _spin_lock+0x8 (__d_lookup+0x67)
     #func                  -87 __d_lookup+0xe (do_lookup+0x2a)
     #func                  -87 do_lookup+0xe (__link_path_walk+0x2b9)
     #func                  -87 generic_permission+0xb (ext3_permission+0x12=
)
     #func                  -87 ext3_permission+0x8 (inode_permission+0x5f)
     #func                  -88 inode_permission+0xa (vfs_permission+0x13)
     #func                  -88 vfs_permission+0x8 (__link_path_walk+0x117)
     #func                  -88 _atomic_dec_and_lock+0xa (dput+0x33)
     #func                  -88 dput+0x9 (__link_path_walk+0x51a)
     #func                  -88 __follow_mount+0xb (do_lookup+0x54)
     #func                  -88 memcmp+0xa (__d_lookup+0xa6)
     #func                  -88 _spin_lock+0x8 (__d_lookup+0x67)
     #func                  -89 __d_lookup+0xe (do_lookup+0x2a)
     #func                  -89 do_lookup+0xe (__link_path_walk+0x2b9)
     #func                  -89 generic_permission+0xb (ext3_permission+0x12=
)
     #func                  -89 ext3_permission+0x8 (inode_permission+0x5f)
     #func                  -89 inode_permission+0xa (vfs_permission+0x13)
     #func                  -89 vfs_permission+0x8 (__link_path_walk+0x117)
     #func                  -90 _atomic_dec_and_lock+0xa (dput+0x33)
     #func                  -90 dput+0x9 (__link_path_walk+0x51a)
     #func                  -90 __follow_mount+0xb (do_lookup+0x54)
     #func                  -90 memcmp+0xa (__d_lookup+0xa6)
     #func                  -90 _spin_lock+0x8 (__d_lookup+0x67)
     #func                  -90 __d_lookup+0xe (do_lookup+0x2a)
     #func                  -91 do_lookup+0xe (__link_path_walk+0x2b9)
     #func                  -91 generic_permission+0xb (ext3_permission+0x12=
)
     #func                  -91 ext3_permission+0x8 (inode_permission+0x5f)
     #func                  -91 inode_permission+0xa (vfs_permission+0x13)
     #func                  -91 vfs_permission+0x8 (__link_path_walk+0x117)
     #func                  -91 __link_path_walk+0xe (path_walk+0x3e)
     #func                  -92 path_get+0x8 (path_walk+0x35)
     #func                  -92 path_walk+0xe (do_path_lookup+0xe4)
     #func                  -92 path_get+0x8 (do_path_lookup+0x73)
     #func                  -92 _read_lock+0x8 (do_path_lookup+0x43)
     #func                  -92 do_path_lookup+0xe (__path_lookup_intent_ope=
n+0x47)
     #func                  -92 __percpu_counter_add+0xe (get_empty_filp+0x8=
c)
     #func                  -93 __ipipe_restore_root+0x8 (kmem_cache_alloc+0=
x97)
     #func                  -93 ipipe_check_context+0x9 (kmem_cache_alloc+0x=
24)
     #func                  -94 kmem_cache_alloc+0xe (get_empty_filp+0x6f)
     #func                  -94 get_empty_filp+0xa (__path_lookup_intent_ope=
n+0x23)
     #func                  -94 __path_lookup_intent_open+0xe (path_lookup_o=
pen+0x15)
     #func                  -95 path_lookup_open+0x8 (do_filp_open+0x9b)
     #func                  -95 do_filp_open+0xe (do_sys_open+0x49)
     #func                  -96 expand_files+0xe (alloc_fd+0x61)
     #func                  -97 find_next_zero_bit+0xa (alloc_fd+0x52)
     #func                  -98 _spin_lock+0x8 (alloc_fd+0x2a)
     #func                  -98 alloc_fd+0xe (do_sys_open+0x33)
     #func                  -99 _cond_resched+0x8 (strncpy_from_user+0x3b)
     #func                  -99 ipipe_check_context+0x9 (strncpy_from_user+0=
x36)
     #func                  -99 strncpy_from_user+0xb (getname+0x67)
     #func                  -99 __ipipe_restore_root+0x8 (kmem_cache_alloc+0=
x97)
     #func                  -99 ipipe_check_context+0x9 (kmem_cache_alloc+0x=
24)
     #func                  -99 kmem_cache_alloc+0xe (getname+0x1f)
     #func                 -100 getname+0xe (do_sys_open+0x19)
     #func                 -100 do_sys_open+0xe (sys_open+0x23)
     #func                 -100 sys_open+0xb (sysenter_do_call+0x12)
     #func                 -100 __ipipe_syscall_root+0xa (sysenter_past_esp+=
0x51)
 |   #end     0x8000000d   -106 __ipipe_unstall_iret_root+0x64 (sysenter_out=
+0x0)
 |   #begin   0x80000000   -106 __ipipe_unstall_iret_root+0x2e (sysenter_out=
+0x0)
     #func                 -106 __ipipe_unstall_iret_root+0xa (sysenter_out+=
0x0)
     #func                 -106 __ipipe_restore_root+0x8 (kmem_cache_free+0x=
b5)
     #func                 -106 ipipe_check_context+0x9 (kmem_cache_free+0x4=
3)
     #func                 -107 kmem_cache_free+0xe (user_path_at+0x4f)
     #func                 -107 _atomic_dec_and_lock+0xa (mntput_no_expire+0=
x1d)
     #func                 -107 mntput_no_expire+0xe (path_put+0x25)
     #func                 -107 _atomic_dec_and_lock+0xa (dput+0x33)
     #func                 -107 dput+0x9 (path_put+0x13)
     #func                 -108 path_put+0x9 (path_walk+0x6e)
     #func                 -108 _atomic_dec_and_lock+0xa (mntput_no_expire+0=
x1d)
     #func                 -108 mntput_no_expire+0xe (path_put+0x25)
     #func                 -108 _spin_lock+0x8 (dput+0x43)
     #func                 -108 _spin_lock+0x8 (_atomic_dec_and_lock+0x32)
     #func                 -109 _atomic_dec_and_lock+0xa (dput+0x33)
     #func                 -109 _cond_resched+0x8 (dput+0x27)
     #func                 -109 ipipe_check_context+0x9 (dput+0x22)
     #func                 -109 dput+0x9 (path_put+0x13)
     #func                 -109 path_put+0x9 (__link_path_walk+0xa11)
     #func                 -109 _atomic_dec_and_lock+0xa (dput+0x33)
     #func                 -110 dput+0x9 (__link_path_walk+0x91f)
     #func                 -110 __follow_mount+0xb (do_lookup+0x54)
     #func                 -110 memcmp+0xa (__d_lookup+0xa6)
     #func                 -110 _spin_lock+0x8 (__d_lookup+0x67)
     #func                 -111 __d_lookup+0xe (do_lookup+0x2a)
     #func                 -111 do_lookup+0xe (__link_path_walk+0x6af)
     #func                 -111 generic_permission+0xb (ext3_permission+0x12=
)
     #func                 -111 ext3_permission+0x8 (inode_permission+0x5f)
     #func                 -111 inode_permission+0xa (vfs_permission+0x13)
     #func                 -112 vfs_permission+0x8 (__link_path_walk+0x117)
     #func                 -112 _atomic_dec_and_lock+0xa (dput+0x33)
     #func                 -112 dput+0x9 (__link_path_walk+0x51a)
     #func                 -112 __follow_mount+0xb (do_lookup+0x54)
     #func                 -112 memcmp+0xa (__d_lookup+0xa6)
     #func                 -112 _spin_lock+0x8 (__d_lookup+0x67)
     #func                 -113 __d_lookup+0xe (do_lookup+0x2a)
     #func                 -113 do_lookup+0xe (__link_path_walk+0x2b9)
     #func                 -113 generic_permission+0xb (ext3_permission+0x12=
)
     #func                 -114 ext3_permission+0x8 (inode_permission+0x5f)
     #func                 -114 inode_permission+0xa (vfs_permission+0x13)
     #func                 -114 vfs_permission+0x8 (__link_path_walk+0x117)
     #func                 -114 _atomic_dec_and_lock+0xa (dput+0x33)
     #func                 -114 dput+0x9 (__link_path_walk+0x51a)
     #func                 -114 __follow_mount+0xb (do_lookup+0x54)
     #func                 -115 memcmp+0xa (__d_lookup+0xa6)
     #func                 -115 _spin_lock+0x8 (__d_lookup+0x67)
     #func                 -115 __d_lookup+0xe (do_lookup+0x2a)
     #func                 -115 do_lookup+0xe (__link_path_walk+0x2b9)
     #func                 -116 generic_permission+0xb (ext3_permission+0x12=
)
     #func                 -116 ext3_permission+0x8 (inode_permission+0x5f)
     #func                 -116 inode_permission+0xa (vfs_permission+0x13)
     #func                 -116 vfs_permission+0x8 (__link_path_walk+0x117)
     #func                 -116 _atomic_dec_and_lock+0xa (dput+0x33)
     #func                 -116 dput+0x9 (__link_path_walk+0x51a)
     #func                 -117 __follow_mount+0xb (do_lookup+0x54)
     #func                 -117 memcmp+0xa (__d_lookup+0xa6)
     #func                 -117 _spin_lock+0x8 (__d_lookup+0x67)
     #func                 -118 __d_lookup+0xe (do_lookup+0x2a)
     #func                 -118 do_lookup+0xe (__link_path_walk+0x2b9)
     #func                 -118 generic_permission+0xb (ext3_permission+0x12=
)
     #func                 -118 ext3_permission+0x8 (inode_permission+0x5f)
     #func                 -118 inode_permission+0xa (vfs_permission+0x13)
     #func                 -119 vfs_permission+0x8 (__link_path_walk+0x117)
     #func                 -119 _atomic_dec_and_lock+0xa (dput+0x33)
     #func                 -119 dput+0x9 (__link_path_walk+0x51a)
     #func                 -119 __follow_mount+0xb (do_lookup+0x54)
     #func                 -120 memcmp+0xa (__d_lookup+0xa6)
     #func                 -120 _spin_lock+0x8 (__d_lookup+0x67)
     #func                 -120 __d_lookup+0xe (do_lookup+0x2a)
     #func                 -120 do_lookup+0xe (__link_path_walk+0x2b9)
     #func                 -120 generic_permission+0xb (ext3_permission+0x12=
)
     #func                 -121 ext3_permission+0x8 (inode_permission+0x5f)
     #func                 -121 inode_permission+0xa (vfs_permission+0x13)
     #func                 -121 vfs_permission+0x8 (__link_path_walk+0x117)
     #func                 -121 _atomic_dec_and_lock+0xa (dput+0x33)
     #func                 -121 dput+0x9 (__link_path_walk+0x51a)
     #func                 -122 __follow_mount+0xb (do_lookup+0x54)
     #func                 -123 memcmp+0xa (__d_lookup+0xa6)
     #func                 -124 _spin_lock+0x8 (__d_lookup+0x67)
     #func                 -124 __d_lookup+0xe (do_lookup+0x2a)
     #func                 -125 do_lookup+0xe (__link_path_walk+0x2b9)
     #func                 -125 generic_permission+0xb (ext3_permission+0x12=
)
     #func                 -125 ext3_permission+0x8 (inode_permission+0x5f)
     #func                 -126 inode_permission+0xa (vfs_permission+0x13)
     #func                 -126 vfs_permission+0x8 (__link_path_walk+0x117)
     #func                 -127 __link_path_walk+0xe (path_walk+0x3e)
     #func                 -127 path_get+0x8 (path_walk+0x35)
     #func                 -127 path_walk+0xe (do_path_lookup+0xe4)
     #func                 -128 path_get+0x8 (do_path_lookup+0x73)
     #func                 -129 _read_lock+0x8 (do_path_lookup+0x43)
     #func                 -129 do_path_lookup+0xe (user_path_at+0x41)
     #func                 -130 _cond_resched+0x8 (strncpy_from_user+0x3b)
     #func                 -130 ipipe_check_context+0x9 (strncpy_from_user+0=
x36)
     #func                 -130 strncpy_from_user+0xb (getname+0x67)
     #func                 -131 __ipipe_restore_root+0x8 (kmem_cache_alloc+0=
x97)
     #func                 -132 ipipe_check_context+0x9 (kmem_cache_alloc+0x=
24)
     #func                 -132 kmem_cache_alloc+0xe (getname+0x1f)
     #func                 -133 getname+0xe (user_path_at+0x1a)
     #func                 -133 user_path_at+0xe (vfs_stat_fd+0x1e)
     #func                 -134 vfs_stat_fd+0xe (vfs_stat+0x16)
     #func                 -134 vfs_stat+0x8 (sys_stat64+0x19)
     #func                 -134 sys_stat64+0xc (sysenter_do_call+0x12)
     #func                 -135 __ipipe_syscall_root+0xa (sysenter_past_esp+=
0x51)
 |   #end     0x8000000d   -152 __ipipe_unstall_iret_root+0x64 (sysenter_out=
+0x0)
 |   #begin   0x80000000   -152 __ipipe_unstall_iret_root+0x2e (sysenter_out=
+0x0)
     #func                 -152 __ipipe_unstall_iret_root+0xa (sysenter_out+=
0x0)
     #func                 -152 _atomic_dec_and_lock+0xa (mntput_no_expire+0=
x1d)
     #func                 -152 mntput_no_expire+0xe (__fput+0x14a)
     #func                 -152 _spin_lock+0x8 (dput+0x43)
     #func                 -153 _spin_lock+0x8 (_atomic_dec_and_lock+0x32)
     #func                 -153 _atomic_dec_and_lock+0xa (dput+0x33)
     #func                 -153 _cond_resched+0x8 (dput+0x27)
     #func                 -153 ipipe_check_context+0x9 (dput+0x22)
     #func                 -153 dput+0x9 (__fput+0x131)
     #func                 -153 __ipipe_restore_root+0x8 (call_rcu+0x8f)
     #func                 -154 ipipe_check_context+0x9 (call_rcu+0x1f)
     #func                 -154 call_rcu+0xa (__fput+0x129)
     #func                 -154 __percpu_counter_add+0xe (__fput+0x11d)
     #func                 -154 _spin_lock+0x8 (file_kill+0x19)
     #func                 -154 file_kill+0x9 (__fput+0xf1)
     #func                 -155 put_pid+0x8 (__fput+0xea)
     #func                 -155 module_put+0x8 (__fput+0xe2)
     #func                 -155 ext3_release_file+0xb (__fput+0xad)
     #func                 -155 locks_remove_flock+0xe (__fput+0x98)
     #func                 -156 inotify_inode_queue_event+0xe (__fput+0x7f)
     #func                 -156 inotify_dentry_parent_queue_event+0xe (__fpu=
t+0x70)
     #func                 -156 _cond_resched+0x8 (__fput+0x31)
     #func                 -156 ipipe_check_context+0x9 (__fput+0x2c)
     #func                 -156 __fput+0xe (fput+0x1c)
     #func                 -157 fput+0x8 (filp_close+0x55)
     #func                 -157 locks_remove_posix+0xd (filp_close+0x4e)
     #func                 -157 dnotify_flush+0xe (filp_close+0x45)
     #func                 -158 filp_close+0xb (sys_close+0x6d)
     #func                 -158 _spin_lock+0x8 (sys_close+0x24)
     #func                 -158 sys_close+0xa (sysenter_do_call+0x12)
     #func                 -158 __ipipe_syscall_root+0xa (sysenter_past_esp+=
0x51)
 |   #end     0x8000000d   -244 __ipipe_unstall_iret_root+0x64 (sysenter_out=
+0x0)
 |   #begin   0x80000000   -244 __ipipe_unstall_iret_root+0x2e (sysenter_out=
+0x0)
     #func                 -244 __ipipe_unstall_iret_root+0xa (sysenter_out+=
0x0)
     #func                 -244 _atomic_dec_and_lock+0xa (mntput_no_expire+0=
x1d)
     #func                 -245 mntput_no_expire+0xe (__fput+0x14a)
     #func                 -245 _spin_lock+0x8 (dput+0x43)
     #func                 -245 _spin_lock+0x8 (_atomic_dec_and_lock+0x32)
     #func                 -245 _atomic_dec_and_lock+0xa (dput+0x33)
     #func                 -245 _cond_resched+0x8 (dput+0x27)
     #func                 -245 ipipe_check_context+0x9 (dput+0x22)
     #func                 -246 dput+0x9 (__fput+0x131)
     #func                 -246 __ipipe_restore_root+0x8 (call_rcu+0x8f)
     #func                 -246 ipipe_check_context+0x9 (call_rcu+0x1f)
     #func                 -246 call_rcu+0xa (__fput+0x129)
     #func                 -246 __percpu_counter_add+0xe (__fput+0x11d)
     #func                 -246 _spin_lock+0x8 (file_kill+0x19)
     #func                 -247 file_kill+0x9 (__fput+0xf1)
     #func                 -247 put_pid+0x8 (__fput+0xea)
     #func                 -247 module_put+0x8 (__fput+0xe2)
     #func                 -247 ext3_release_file+0xb (__fput+0xad)
     #func                 -247 locks_remove_flock+0xe (__fput+0x98)
     #func                 -248 inotify_inode_queue_event+0xe (__fput+0x7f)
     #func                 -248 inotify_dentry_parent_queue_event+0xe (__fpu=
t+0x70)
     #func                 -248 _cond_resched+0x8 (__fput+0x31)
     #func                 -248 ipipe_check_context+0x9 (__fput+0x2c)
     #func                 -249 __fput+0xe (fput+0x1c)
     #func                 -249 fput+0x8 (filp_close+0x55)
     #func                 -249 locks_remove_posix+0xd (filp_close+0x4e)
     #func                 -249 dnotify_flush+0xe (filp_close+0x45)
     #func                 -250 filp_close+0xb (sys_close+0x6d)
     #func                 -250 _spin_lock+0x8 (sys_close+0x24)
     #func                 -250 sys_close+0xa (sysenter_do_call+0x12)
     #func                 -250 __ipipe_syscall_root+0xa (sysenter_past_esp+=
0x51)
 |   #end     0x8000000d   -322 __ipipe_unstall_iret_root+0x64 (sysenter_out=
+0x0)
 |   #begin   0x80000000   -322 __ipipe_unstall_iret_root+0x2e (sysenter_out=
+0x0)
     #func                 -322 __ipipe_unstall_iret_root+0xa (sysenter_out+=
0x0)
     #func                 -323 _atomic_dec_and_lock+0xa (mntput_no_expire+0=
x1d)
     #func                 -323 mntput_no_expire+0xe (__fput+0x14a)
     #func                 -324 _spin_lock+0x8 (dput+0x43)
     #func                 -324 _spin_lock+0x8 (_atomic_dec_and_lock+0x32)
     #func                 -324 _atomic_dec_and_lock+0xa (dput+0x33)
     #func                 -325 _cond_resched+0x8 (dput+0x27)
     #func                 -325 ipipe_check_context+0x9 (dput+0x22)
     #func                 -325 dput+0x9 (__fput+0x131)
     #func                 -326 __ipipe_restore_root+0x8 (call_rcu+0x8f)
     #func                 -326 ipipe_check_context+0x9 (call_rcu+0x1f)
     #func                 -326 call_rcu+0xa (__fput+0x129)
     #func                 -328 __percpu_counter_add+0xe (__fput+0x11d)
     #func                 -328 _spin_lock+0x8 (file_kill+0x19)
     #func                 -328 file_kill+0x9 (__fput+0xf1)
     #func                 -329 put_pid+0x8 (__fput+0xea)
     #func                 -329 module_put+0x8 (__fput+0xe2)
     #func                 -331 ext3_release_file+0xb (__fput+0xad)
     #func                 -331 locks_remove_flock+0xe (__fput+0x98)
     #func                 -332 inotify_inode_queue_event+0xe (__fput+0x7f)
     #func                 -333 inotify_dentry_parent_queue_event+0xe (__fpu=
t+0x70)
     #func                 -333 _cond_resched+0x8 (__fput+0x31)
     #func                 -334 ipipe_check_context+0x9 (__fput+0x2c)
     #func                 -334 __fput+0xe (fput+0x1c)
     #func                 -334 fput+0x8 (filp_close+0x55)
     #func                 -335 locks_remove_posix+0xd (filp_close+0x4e)
     #func                 -335 dnotify_flush+0xe (filp_close+0x45)
     #func                 -336 filp_close+0xb (sys_close+0x6d)
     #func                 -338 _spin_lock+0x8 (sys_close+0x24)
     #func                 -338 sys_close+0xa (sysenter_do_call+0x12)
     #func                 -339 __ipipe_syscall_root+0xa (sysenter_past_esp+=
0x51)
 |   #end     0xffffff16   -339 ipipe_ipi3+0x3d (sysenter_past_esp+0x38)
 |   #func                 -340 __ipipe_walk_pipeline+0xe (__ipipe_dispatch_=
wired_nocheck+0x8a)
 |  #*func                 -340 __ipipe_set_irq_pending+0xb (rthal_irq_host_=
pend+0x4a)
 |  #*func                 -341 rthal_irq_host_pend+0xb (xnintr_clock_handle=
r+0x131)
 |  #*func                 -342 xntimer_next_local_shot+0xe (xntimer_tick_ap=
eriodic+0x1b9)
 |  #*func                 -342 xntimer_tick_aperiodic+0xe (xnintr_clock_han=
dler+0x6b)
 |  #*func                 -343 xnintr_clock_handler+0xe (__ipipe_dispatch_w=
ired_nocheck+0x58)
 |   #func                 -343 __ipipe_dispatch_wired_nocheck+0xe (__ipipe_=
dispatch_wired+0x66)
 |   #func                 -343 __ipipe_dispatch_wired+0x9 (__ipipe_handle_i=
rq+0xad)
 |   #func                 -344 __ipipe_ack_apic+0x8 (__ipipe_handle_irq+0xa=
4)
 |   #func                 -344 __ipipe_handle_irq+0xe (ipipe_ipi3+0x33)
 |   #begin   0xffffff16   -346 ipipe_ipi3+0x2e (sysenter_past_esp+0x38)
 |   #end     0x8000000d  -4242 __ipipe_unstall_iret_root+0x64 (restore_noch=
eck_notrace+0x0)
 |   #begin   0x80000000  -4242 __ipipe_unstall_iret_root+0x2e (restore_noch=
eck_notrace+0x0)
     #func                -4243 __ipipe_unstall_iret_root+0xa (restore_noche=
ck_notrace+0x0)
 |   #func                -4243 __ipipe_restore_root+0x8 (__ipipe_handle_exc=
eption+0x197)
 |   #begin   0x80000000  -4243 __ipipe_handle_exception+0x180 (error_code+0=
x77)
     #func                -4243 up_read+0x8 (do_page_fault+0x324)
     #func                -4244 __inc_zone_state+0xe (__inc_zone_page_state+=
0x1d)
     #func                -4244 __inc_zone_page_state+0x8 (__page_set_anon_r=
map+0x32)
     #func                -4244 __page_set_anon_rmap+0x9 (page_add_new_anon_=
rmap+0x2e)
     #func                -4244 page_add_new_anon_rmap+0x9 (handle_mm_fault+=
0x1ad)
     #func                -4244 lru_cache_add_active+0x9 (handle_mm_fault+0x=
1a0)
     #func                -4244 _spin_lock+0x8 (handle_mm_fault+0x18e)
     #func                -4244 page_address+0xe (handle_mm_fault+0x181)
     #func                -4245 ipipe_check_context+0x9 (kunmap_atomic+0x4f)
     #func                -4245 kunmap_atomic+0x9 (get_page_from_freelist+0x=
328)
     #func                -4250 ipipe_check_context+0x9 (kmap_atomic_prot+0x=
1b)
     #func                -4250 kmap_atomic_prot+0xb (kmap_atomic+0x13)
     #func                -4250 kmap_atomic+0x8 (get_page_from_freelist+0x30=
9)
     #func                -4250 __ipipe_restore_root+0x8 (get_page_from_free=
list+0x285)
     #func                -4250 ipipe_check_context+0x9 (get_page_from_freel=
ist+0x127)
     #func                -4250 zone_watermark_ok+0xe (get_page_from_freelis=
t+0x8a)
     #func                -4251 next_zones_zonelist+0x9 (get_page_from_freel=
ist+0x37c)
     #func                -4251 next_zones_zonelist+0x9 (get_page_from_freel=
ist+0x2f)
     #func                -4251 get_page_from_freelist+0xe (__alloc_pages_in=
ternal+0xc7)
     #func                -4251 _cond_resched+0x8 (__alloc_pages_internal+0x=
9b)
     #func                -4251 ipipe_check_context+0x9 (__alloc_pages_inter=
nal+0x96)
     #func                -4252 __alloc_pages_internal+0xe (handle_mm_fault+=
0x12b)
     #func                -4252 _cond_resched+0x8 (anon_vma_prepare+0x22)
     #func                -4252 ipipe_check_context+0x9 (anon_vma_prepare+0x=
1d)
     #func                -4252 anon_vma_prepare+0xe (handle_mm_fault+0x110)
     #func                -4253 page_address+0xe (handle_mm_fault+0xa1)
     #func                -4253 handle_mm_fault+0xe (do_page_fault+0x2cd)
     #func                -4253 find_vma+0xa (do_page_fault+0x251)
     #func                -4253 down_read_trylock+0x9 (do_page_fault+0x222)
 |   #end     0x80000000  -4253 do_page_fault+0x3d (__ipipe_handle_exception=
+0x16e)
 |   #func                -4254 do_page_fault+0xe (__ipipe_handle_exception+=
0x16e)
 |   #func                -4254 __ipipe_handle_exception+0xe (error_code+0x7=
7)
 |   #end     0x8000000d  -4839 __ipipe_unstall_iret_root+0x64 (restore_noch=
eck_notrace+0x0)
 |   #begin   0x80000000  -4839 __ipipe_unstall_iret_root+0x2e (restore_noch=
eck_notrace+0x0)
     #func                -4839 __ipipe_unstall_iret_root+0xa (restore_noche=
ck_notrace+0x0)
 |   +func                -4839 __ipipe_restore_root+0x8 (__ipipe_handle_exc=
eption+0x197)
 |   +begin   0x80000000  -4840 __ipipe_handle_exception+0x180 (error_code+0=
x77)
     +func                -4840 up_read+0x8 (do_page_fault+0x324)
     +func                -4840 __inc_zone_state+0xe (__inc_zone_page_state+=
0x1d)
     +func                -4840 __inc_zone_page_state+0x8 (__page_set_anon_r=
map+0x32)
     +func                -4841 __page_set_anon_rmap+0x9 (page_add_new_anon_=
rmap+0x2e)
     +func                -4841 page_add_new_anon_rmap+0x9 (handle_mm_fault+=
0x1ad)
     +func                -4841 lru_cache_add_active+0x9 (handle_mm_fault+0x=
1a0)
     +func                -4841 _spin_lock+0x8 (handle_mm_fault+0x18e)
     +func                -4841 page_address+0xe (handle_mm_fault+0x181)
     +func                -4842 ipipe_check_context+0x9 (kunmap_atomic+0x4f)
     +func                -4842 kunmap_atomic+0x9 (get_page_from_freelist+0x=
328)
     +func                -4847 ipipe_check_context+0x9 (kmap_atomic_prot+0x=
1b)
     +func                -4847 kmap_atomic_prot+0xb (kmap_atomic+0x13)
     +func                -4847 kmap_atomic+0x8 (get_page_from_freelist+0x30=
9)
 |   +end     0x80000000  -4848 __ipipe_unstall_root+0x4d (__ipipe_restore_r=
oot+0x27)
 |   #begin   0x80000000  -4848 __ipipe_unstall_root+0x2a (__ipipe_restore_r=
oot+0x27)
     #func                -4848 __ipipe_unstall_root+0x9 (__ipipe_restore_ro=
ot+0x27)
     #func                -4848 __ipipe_restore_root+0x8 (get_page_from_free=
list+0x285)
     +func                -4848 ipipe_check_context+0x9 (get_page_from_freel=
ist+0x127)
     +func                -4849 zone_watermark_ok+0xe (get_page_from_freelis=
t+0x8a)
     +func                -4849 next_zones_zonelist+0x9 (get_page_from_freel=
ist+0x37c)
     +func                -4849 next_zones_zonelist+0x9 (get_page_from_freel=
ist+0x2f)
     +func                -4850 get_page_from_freelist+0xe (__alloc_pages_in=
ternal+0xc7)
     +func                -4850 _cond_resched+0x8 (__alloc_pages_internal+0x=
9b)
     +func                -4850 ipipe_check_context+0x9 (__alloc_pages_inter=
nal+0x96)
     +func                -4850 __alloc_pages_internal+0xe (handle_mm_fault+=
0x12b)
     +func                -4850 _cond_resched+0x8 (anon_vma_prepare+0x22)
     +func                -4851 ipipe_check_context+0x9 (anon_vma_prepare+0x=
1d)
     +func                -4851 anon_vma_prepare+0xe (handle_mm_fault+0x110)
     +func                -4852 page_address+0xe (handle_mm_fault+0xa1)
     +func                -4852 handle_mm_fault+0xe (do_page_fault+0x2cd)
     +func                -4852 find_vma+0xa (do_page_fault+0x251)
     +func                -4853 down_read_trylock+0x9 (do_page_fault+0x222)
 |   +end     0x80000000  -4853 __ipipe_unstall_root+0x4d (do_page_fault+0x1=
fc)
 |   +end     0x8000000d  -4853 __ipipe_unstall_iret_root+0x64 (restore_noch=
eck_notrace+0x0)
 |   #begin   0x80000000  -4853 __ipipe_unstall_iret_root+0x2e (restore_noch=
eck_notrace+0x0)
     #func                -4854 __ipipe_unstall_iret_root+0xa (restore_noche=
ck_notrace+0x0)
     #func                -4854 idle_cpu+0x8 (irq_exit+0x62)
     #func                -4854 __ipipe_restore_root+0x8 (do_softirq+0x75)
     #func                -4854 ipipe_check_context+0x9 (_local_bh_enable+0x=
89)
     #func                -4854 _local_bh_enable+0x8 (__do_softirq+0xfb)
     +func                -4855 ipipe_check_context+0x9 (__do_softirq+0xa1)
 |   +end     0x80000000  -4855 __ipipe_unstall_root+0x4d (run_timer_softirq=
+0x17c)
 |   #begin   0x80000000  -4855 __ipipe_unstall_root+0x2a (run_timer_softirq=
+0x17c)
     #func                -4855 __ipipe_unstall_root+0x9 (run_timer_softirq+=
0x17c)
     +func                -4856 ipipe_check_context+0x9 (_spin_lock_irq+0x15=
)
     +func                -4856 _spin_lock_irq+0x9 (run_timer_softirq+0x37)
     +func                -4857 hrtimer_run_pending+0xe (run_timer_softirq+0=
x22)
     +func                -4857 run_timer_softirq+0xe (__do_softirq+0x77)
 |   +end     0x80000000  -4857 __ipipe_unstall_root+0x4d (__do_softirq+0x69=
)
 |   #begin   0x80000000  -4857 __ipipe_unstall_root+0x2a (__do_softirq+0x69=
)
     #func                -4858 __ipipe_unstall_root+0x9 (__do_softirq+0x69)
     #func                -4858 ipipe_check_context+0x9 (__do_softirq+0x2e)
     #func                -4858 __do_softirq+0xe (do_softirq+0x62)
     #func                -4858 ipipe_check_context+0x9 (do_softirq+0x23)
     #func                -4858 do_softirq+0x9 (irq_exit+0x47)
     #func                -4859 ipipe_check_context+0x9 (irq_exit+0x12)
     #func                -4859 irq_exit+0x8 (smp_apic_timer_interrupt+0x66)
 |   #end     0x80000000  -4859 __ipipe_restore_pipeline_head+0xb8 (xnarch_n=
ext_htick_shot+0xdb)
 |  *#func                -4860 __ipipe_restore_pipeline_head+0xb (xnarch_ne=
xt_htick_shot+0xdb)
 |  *#func                -4860 xntimer_next_local_shot+0xe (xntimer_start_a=
periodic+0x1c5)
 |  *#func                -4861 xnarch_ns_to_tsc+0xe (xntimer_start_aperiodi=
c+0x66)
 |  *#func                -4862 xntimer_start_aperiodic+0xe (xnarch_next_hti=
ck_shot+0x90)
 |   #begin   0x80000000  -4862 xnarch_next_htick_shot+0x1e (clockevents_pro=
gram_event+0xc5)
     #func                -4862 xnarch_next_htick_shot+0xa (clockevents_prog=
ram_event+0xc5)
     #func                -4862 clockevents_program_event+0xe (tick_dev_prog=
ram_event+0x2d)
     #func                -4863 set_normalized_timespec+0x8 (ktime_get_ts+0x=
45)
     #func                -4863 native_read_tsc+0x8 (read_tsc+0xe)
     #func                -4863 read_tsc+0x9 (getnstimeofday+0x54)
     #func                -4863 getnstimeofday+0xe (ktime_get_ts+0x25)
     #func                -4863 ktime_get_ts+0xa (ktime_get+0x16)
     #func                -4863 ktime_get+0xc (tick_dev_program_event+0x19)
     #func                -4864 tick_dev_program_event+0xe (tick_program_eve=
nt+0x27)
     #func                -4864 tick_program_event+0xa (hrtimer_interrupt+0x=
129)
     #func                -4864 rb_insert_color+0xe (enqueue_hrtimer+0xd5)
     #func                -4865 enqueue_hrtimer+0xe (__run_hrtimer+0x80)
     #func                -4865 _spin_lock+0x8 (__run_hrtimer+0x5e)
     #func                -4865 ktime_add_safe+0xb (hrtimer_forward+0xdb)
     #func                -4865 ktime_divns+0xe (hrtimer_forward+0x82)
     #func                -4866 hrtimer_forward+0xe (tick_sched_timer+0x8d)
     #func                -4866 profile_pc+0xa (profile_tick+0x4b)
     #func                -4866 profile_tick+0xa (tick_sched_timer+0x6e)
     #func                -4867 run_posix_cpu_timers+0xe (update_process_tim=
es+0x49)
     #func                -4867 idle_cpu+0x8 (scheduler_tick+0xb2)
     #func                -4867 calc_delta_mine+0xe (update_curr+0x48)
     #func                -4867 update_curr+0xb (task_tick_fair+0x34)
     #func                -4868 task_tick_fair+0xe (scheduler_tick+0xa9)
     #func                -4868 __update_sched_clock+0xe (sched_clock_cpu+0x=
163)
     #func                -4868 __ipipe_restore_root+0x8 (native_sched_clock=
+0xbc)
     #func                -4868 ipipe_check_context+0x9 (native_sched_clock+=
0x54)
     #func                -4869 native_read_tsc+0x8 (native_sched_clock+0x46=
)
     #func                -4869 native_sched_clock+0xe (sched_clock_cpu+0x7d=
)
     #func                -4869 sched_clock_cpu+0xe (scheduler_tick+0x41)
     #func                -4869 _spin_lock+0x8 (scheduler_tick+0x36)
     #func                -4869 __update_sched_clock+0xe (sched_clock_tick+0=
xa4)
     #func                -4870 __ipipe_restore_root+0x8 (native_sched_clock=
+0xbc)
     #func                -4870 ipipe_check_context+0x9 (native_sched_clock+=
0x54)
     #func                -4870 native_read_tsc+0x8 (native_sched_clock+0x46=
)
     #func                -4870 native_sched_clock+0xe (sched_clock_tick+0x7=
9)
     #func                -4870 set_normalized_timespec+0x8 (ktime_get_ts+0x=
45)
     #func                -4871 native_read_tsc+0x8 (read_tsc+0xe)
     #func                -4871 read_tsc+0x9 (getnstimeofday+0x54)
     #func                -4871 getnstimeofday+0xe (ktime_get_ts+0x25)
     #func                -4871 ktime_get_ts+0xa (ktime_get+0x16)
     #func                -4871 ktime_get+0xc (sched_clock_tick+0x6e)
     #func                -4871 sched_clock_tick+0xb (scheduler_tick+0x2f)
     #func                -4871 scheduler_tick+0xe (update_process_times+0x4=
2)
     #func                -4872 __rcu_pending+0x8 (rcu_pending+0x3b)
     #func                -4872 __rcu_pending+0x8 (rcu_pending+0x21)
     #func                -4872 rcu_pending+0x9 (update_process_times+0x30)
     #func                -4873 __ipipe_restore_root+0x8 (cpu_clock+0x59)
     #func                -4873 __update_sched_clock+0xe (sched_clock_cpu+0x=
163)
     #func                -4873 __ipipe_restore_root+0x8 (native_sched_clock=
+0xbc)
     #func                -4874 ipipe_check_context+0x9 (native_sched_clock+=
0x54)
     #func                -4874 native_read_tsc+0x8 (native_sched_clock+0x46=
)
     #func                -4874 native_sched_clock+0xe (sched_clock_cpu+0x7d=
)
     #func                -4874 sched_clock_cpu+0xe (cpu_clock+0x41)
     #func                -4874 ipipe_check_context+0x9 (cpu_clock+0x19)
     #func                -4875 cpu_clock+0xd (get_timestamp+0xd)
     #func                -4875 get_timestamp+0x8 (softlockup_tick+0x95)
     #func                -4875 softlockup_tick+0xe (run_local_timers+0x1c)
     #func                -4876 __ipipe_restore_root+0x8 (raise_softirq+0x9b=
)
     #func                -4876 ipipe_check_context+0x9 (raise_softirq+0x16)
     #func                -4876 raise_softirq+0xa (run_local_timers+0x17)
     #func                -4877 hrtimer_run_queues+0xe (run_local_timers+0xd=
)
     #func                -4877 run_local_timers+0x8 (update_process_times+0=
x29)
     #func                -4877 account_system_time_scaled+0x8 (account_proc=
ess_tick+0x42)
     #func                -4877 account_system_time+0xe (account_process_tic=
k+0x36)
     #func                -4878 account_process_tick+0x9 (update_process_tim=
es+0x24)
     #func                -4878 update_process_times+0xb (update_root_proces=
s_times+0x26)
     #func                -4878 update_root_process_times+0xa (tick_sched_ti=
mer+0x64)
     #func                -4878 __ipipe_restore_root+0x8 (_spin_unlock_irqre=
store+0x1d)
     #func                -4879 _spin_unlock_irqrestore+0x8 (clocksource_get=
_next+0x41)
     #func                -4879 ipipe_check_context+0x9 (_spin_lock_irqsave+=
0x15)
     #func                -4879 _spin_lock_irqsave+0x9 (clocksource_get_next=
+0x12)
     #func                -4879 clocksource_get_next+0x8 (update_wall_time+0=
x53c)
     #func                -4880 update_xtime_cache+0xa (update_wall_time+0x5=
37)
     #func                -4880 native_read_tsc+0x8 (read_tsc+0xe)
     #func                -4880 read_tsc+0x9 (update_wall_time+0x23)
     #func                -4880 update_wall_time+0xe (do_timer+0x23)
     #func                -4881 do_timer+0xe (tick_do_update_jiffies64+0xe1)
     #func                -4881 ktime_divns+0xe (tick_do_update_jiffies64+0x=
bf)
     #func                -4882 _spin_lock+0x8 (tick_do_update_jiffies64+0x4=
2)
     #func                -4882 tick_do_update_jiffies64+0xe (tick_sched_tim=
er+0x48)
     #func                -4882 set_normalized_timespec+0x8 (ktime_get_ts+0x=
45)
     #func                -4882 native_read_tsc+0x8 (read_tsc+0xe)
     #func                -4882 read_tsc+0x9 (getnstimeofday+0x54)
     #func                -4883 getnstimeofday+0xe (ktime_get_ts+0x25)
     #func                -4883 ktime_get_ts+0xa (ktime_get+0x16)
     #func                -4883 ktime_get+0xc (tick_sched_timer+0x1e)
     #func                -4883 tick_sched_timer+0xe (__run_hrtimer+0x55)
     #func                -4884 timer_stats_update_stats+0x11 (__run_hrtimer=
+0x3e)
     #func                -4884 rb_erase+0xe (__remove_hrtimer+0x64)
     #func                -4885 rb_next+0x8 (__remove_hrtimer+0x37)
     #func                -4885 __remove_hrtimer+0xb (__run_hrtimer+0x28)
     #func                -4885 __run_hrtimer+0xe (hrtimer_interrupt+0xeb)
     #func                -4886 _spin_lock+0x8 (hrtimer_interrupt+0x6e)
     #func                -4886 _spin_lock+0x8 (hrtimer_interrupt+0x6e)
     #func                -4887 set_normalized_timespec+0x8 (ktime_get_ts+0x=
45)
     #func                -4887 native_read_tsc+0x8 (read_tsc+0xe)
     #func                -4887 read_tsc+0x9 (getnstimeofday+0x54)
     #func                -4888 getnstimeofday+0xe (ktime_get_ts+0x25)
     #func                -4888 ktime_get_ts+0xa (ktime_get+0x16)
     #func                -4888 ktime_get+0xc (hrtimer_interrupt+0x49)
     #func                -4889 hrtimer_interrupt+0xe (smp_apic_timer_interr=
upt+0x61)
     #func                -4889 idle_cpu+0x8 (irq_enter+0x51)
     #func                -4889 ipipe_check_context+0x9 (irq_enter+0x3c)
     #func                -4890 idle_cpu+0x8 (irq_enter+0x17)
     #func                -4890 irq_enter+0x9 (smp_apic_timer_interrupt+0x1c=
)
     #func                -4890 smp_apic_timer_interrupt+0xa (__ipipe_sync_s=
tage+0x109)
 |   #end     0x80000000  -4890 __ipipe_sync_stage+0xb6 (__ipipe_unstall_roo=
t+0x3c)
 |   +func                -4891 __ipipe_sync_stage+0xe (__ipipe_unstall_root=
+0x3c)
 |   #begin   0x80000000  -4891 __ipipe_unstall_root+0x2a (do_page_fault+0x1=
fc)
     #func                -4891 __ipipe_unstall_root+0x9 (do_page_fault+0x1f=
c)
 |   #end     0x80000000  -4891 do_page_fault+0x3d (__ipipe_handle_exception=
+0x16e)
 |   #func                -4892 do_page_fault+0xe (__ipipe_handle_exception+=
0x16e)
 |   #func                -4892 __ipipe_handle_exception+0xe (error_code+0x7=
7)
 |   #end     0x8000000d  -4894 __ipipe_unstall_iret_root+0x64 (sysenter_out=
+0x0)
 |   #begin   0x80000000  -4894 __ipipe_unstall_iret_root+0x2e (sysenter_out=
+0x0)
     #func                -4894 __ipipe_unstall_iret_root+0xa (sysenter_out+=
0x0)
     #func                -4895 up_write+0x8 (sys_brk+0xe1)
     #func                -4895 _spin_lock+0x8 (vma_adjust+0x1b4)
     #func                -4896 vma_adjust+0xe (vma_merge+0xc9)
     #func                -4897 can_vma_merge_after+0x9 (vma_merge+0x69)
     #func                -4897 vma_merge+0xe (do_brk+0x14d)
     #func                -4898 vm_acct_memory+0x8 (__vm_enough_memory+0x1c)
     #func                -4898 __vm_enough_memory+0xe (cap_vm_enough_memory=
+0x2e)
     #func                -4899 cap_capable+0x9 (cap_vm_enough_memory+0x1e)
     #func                -4899 cap_vm_enough_memory+0xa (do_brk+0x119)
     #func                -4899 may_expand_vm+0x8 (do_brk+0xef)
     #func                -4900 find_vma_prepare+0xe (do_brk+0xbd)
     #func                -4901 do_brk+0xe (sys_brk+0xc6)
     #func                -4901 find_vma+0xa (sys_brk+0xaa)
     #func                -4902 _cond_resched+0x8 (down_write+0x1a)
     #func                -4902 ipipe_check_context+0x9 (down_write+0x15)
     #func                -4902 down_write+0x9 (sys_brk+0x25)
     #func                -4903 sys_brk+0xe (sysenter_do_call+0x12)
     #func                -4904 __ipipe_syscall_root+0xa (sysenter_past_esp+=
0x51)
 |   #end     0x8000000d  -11562 __ipipe_unstall_iret_root+0x64 (restore_noc=
heck_notrace+0x0)
 |   #begin   0x80000000  -11562 __ipipe_unstall_iret_root+0x2e (restore_noc=
heck_notrace+0x0)
     #func                -11563 __ipipe_unstall_iret_root+0xa (restore_noch=
eck_notrace+0x0)
 |   #func                -11563 __ipipe_restore_root+0x8 (__ipipe_handle_ex=
ception+0x197)
 |   #begin   0x80000000  -11564 __ipipe_handle_exception+0x180 (error_code+=
0x77)
     #func                -11564 up_read+0x8 (do_page_fault+0x324)
     #func                -11564 __inc_zone_state+0xe (__inc_zone_page_state=
+0x1d)
     #func                -11564 __inc_zone_page_state+0x8 (__page_set_anon_=
rmap+0x32)
     #func                -11565 __page_set_anon_rmap+0x9 (page_add_new_anon=
_rmap+0x2e)
     #func                -11565 page_add_new_anon_rmap+0x9 (handle_mm_fault=
+0x1ad)
     #func                -11565 lru_cache_add_active+0x9 (handle_mm_fault+0=
x1a0)
     #func                -11566 _spin_lock+0x8 (handle_mm_fault+0x18e)
     #func                -11566 page_address+0xe (handle_mm_fault+0x181)
     #func                -11566 ipipe_check_context+0x9 (kunmap_atomic+0x4f=
)
     #func                -11567 kunmap_atomic+0x9 (get_page_from_freelist+0=
x328)
     #func                -11572 ipipe_check_context+0x9 (kmap_atomic_prot+0=
x1b)
     #func                -11572 kmap_atomic_prot+0xb (kmap_atomic+0x13)
     #func                -11572 kmap_atomic+0x8 (get_page_from_freelist+0x3=
09)
     #func                -11572 __ipipe_restore_root+0x8 (get_page_from_fre=
elist+0x285)
     #func                -11573 ipipe_check_context+0x9 (get_page_from_free=
list+0x127)
     #func                -11573 zone_watermark_ok+0xe (get_page_from_freeli=
st+0x8a)
     #func                -11574 next_zones_zonelist+0x9 (get_page_from_free=
list+0x37c)
     #func                -11574 next_zones_zonelist+0x9 (get_page_from_free=
list+0x2f)
     #func                -11574 get_page_from_freelist+0xe (__alloc_pages_i=
nternal+0xc7)
     #func                -11575 _cond_resched+0x8 (__alloc_pages_internal+0=
x9b)
     #func                -11575 ipipe_check_context+0x9 (__alloc_pages_inte=
rnal+0x96)
     #func                -11575 __alloc_pages_internal+0xe (handle_mm_fault=
+0x12b)
     #func                -11576 _cond_resched+0x8 (anon_vma_prepare+0x22)
     #func                -11576 ipipe_check_context+0x9 (anon_vma_prepare+0=
x1d)
     #func                -11576 anon_vma_prepare+0xe (handle_mm_fault+0x110=
)
     #func                -11577 page_address+0xe (handle_mm_fault+0xa1)
     #func                -11578 handle_mm_fault+0xe (do_page_fault+0x2cd)
     #func                -11579 find_vma+0xa (do_page_fault+0x251)
     #func                -11579 down_read_trylock+0x9 (do_page_fault+0x222)
 |   #end     0xffffff16  -11579 ipipe_ipi3+0x3d (do_page_fault+0x45)
 |   #func                -11580 __ipipe_walk_pipeline+0xe (__ipipe_dispatch=
_wired_nocheck+0x8a)
 |  #*func                -11581 __ipipe_set_irq_pending+0xb (rthal_irq_host=
_pend+0x4a)
 |  #*func                -11581 rthal_irq_host_pend+0xb (xnintr_clock_handl=
er+0x131)
 |  #*func                -11582 xntimer_next_local_shot+0xe (xntimer_tick_a=
periodic+0x1b9)
 |  #*func                -11583 xntimer_tick_aperiodic+0xe (xnintr_clock_ha=
ndler+0x6b)
 |  #*func                -11583 xnintr_clock_handler+0xe (__ipipe_dispatch_=
wired_nocheck+0x58)
 |   #func                -11583 __ipipe_dispatch_wired_nocheck+0xe (__ipipe=
_dispatch_wired+0x66)
 |   #func                -11584 __ipipe_dispatch_wired+0x9 (__ipipe_handle_=
irq+0xad)
 |   #func                -11584 __ipipe_ack_apic+0x8 (__ipipe_handle_irq+0x=
a4)
 |   #func                -11585 __ipipe_handle_irq+0xe (ipipe_ipi3+0x33)
 |   #begin   0xffffff16  -11585 ipipe_ipi3+0x2e (do_page_fault+0x45)
 |   #end     0x80000000  -11586 do_page_fault+0x3d (__ipipe_handle_exceptio=
n+0x16e)
 |   #func                -11587 do_page_fault+0xe (__ipipe_handle_exception=
+0x16e)
 |   #func                -11588 __ipipe_handle_exception+0xe (error_code+0x=
77)
 |   #end     0x8000000d  -20476 __ipipe_unstall_iret_root+0x64 (restore_noc=
heck_notrace+0x0)
 |   #begin   0x80000000  -20476 __ipipe_unstall_iret_root+0x2e (restore_noc=
heck_notrace+0x0)
     #func                -20477 __ipipe_unstall_iret_root+0xa (restore_noch=
eck_notrace+0x0)
 |   +func                -20477 __ipipe_restore_root+0x8 (__ipipe_handle_ex=
ception+0x197)
 |   +begin   0x80000000  -20477 __ipipe_handle_exception+0x180 (error_code+=
0x77)
---[ end trace 9e535809d686fa52 ]---

--=_2cgrwpf9e5no
Content-Type: text/plain;
	charset=ISO-8859-2;
	name="bug_2.6.27_xeno_2.4.6.1_ipipe_syscall_root_patch.txt"
Content-Disposition: attachment;
	filename="bug_2.6.27_xeno_2.4.6.1_ipipe_syscall_root_patch.txt"
Content-Transfer-Encoding: quoted-printable

Linux version 2.6.27.18-xenomai (root@domain.hid) (gcc version 4.1.2 (Gentoo 4=
.1.2 p1.1)) #2 SMP Thu Feb 19 17:24:36 CET 2009
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
DMI 2.3 present.
last_pfn =3D 0x3ff71 max_arch_pfn =3D 0x100000
kernel direct mapping tables up to 38000000 @ 7000-c000
ACPI: RSDP 000FEBA0, 0014 (r0 DELL  )
ACPI: RSDT 000FD501, 0038 (r1 DELL    GX260          6 ASL        61)
ACPI: FACP 000FD539, 0074 (r1 DELL    GX260          6 ASL        61)
ACPI: DSDT FFFD5D84, 2563 (r1   DELL    dt_ex     1000 MSFT  100000D)
ACPI: FACS 3FF71000, 0040
ACPI: SSDT FFFD82E7, 00A7 (r1   DELL    st_ex     1000 MSFT  100000D)
ACPI: APIC 000FD5AD, 006C (r1 DELL    GX260          6 ASL        61)
ACPI: BOOT 000FD619, 0028 (r1 DELL    GX260          6 ASL        61)
ACPI: ASF! 000FD641, 0067 (r16 DELL    GX260          6 ASL        61)
127MB HIGHMEM available.
896MB LOWMEM available.
  mapped low ram: 0 - 38000000
  low ram: 00000000 - 38000000
  bootmap 00008000 - 0000f000
(8 early reservations) =3D=3D> bootmem [0000000000 - 0038000000]
  #0 [0000000000 - 0000001000]   BIOS data page =3D=3D> [0000000000 - 000000=
1000]
  #1 [0000001000 - 0000002000]    EX TRAMPOLINE =3D=3D> [0000001000 - 000000=
2000]
  #2 [0000006000 - 0000007000]       TRAMPOLINE =3D=3D> [0000006000 - 000000=
7000]
  #3 [0000100000 - 0000a0e8e8]    TEXT DATA BSS =3D=3D> [0000100000 - 0000a0=
e8e8]
  #4 [0000a0f000 - 0000a13000]    INIT_PG_TABLE =3D=3D> [0000a0f000 - 0000a1=
3000]
  #5 [000009fc00 - 0000100000]    BIOS reserved =3D=3D> [000009fc00 - 000010=
0000]
  #6 [0000007000 - 0000008000]          PGTABLE =3D=3D> [0000007000 - 000000=
8000]
  #7 [0000008000 - 000000f000]          BOOTMAP =3D=3D> [0000008000 - 000000=
f000]
found SMP MP-table at [c00fe710] 000fe710
Zone PFN ranges:
  DMA      0x00000000 -> 0x00001000
  Normal   0x00001000 -> 0x00038000
  HighMem  0x00038000 -> 0x0003ff71
Movable zone start PFN for each node
early_node_map[2] active PFN ranges
    0: 0x00000000 -> 0x000000a0
    0: 0x00000100 -> 0x0003ff71
On node 0 totalpages: 261905
free_area_init_node: node 0, pgdat c0533580, node_mem_map c1000000
  DMA zone: 3968 pages, LIFO batch:0
  Normal zone: 223520 pages, LIFO batch:31
  HighMem zone: 32370 pages, LIFO batch:7
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
SMP: Allowing 2 CPUs, 1 hotplug CPUs
mapped APIC to ffffb000 (fee00000)
mapped IOAPIC to ffffa000 (fec00000)
Allocating PCI resources starting at 50000000 (gap: 40000000:bec00000)
PERCPU: Allocating 3190556 bytes of per cpu data
NR_CPUS: 2, nr_cpu_ids: 2, nr_node_ids 1
Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 259858
Kernel command line: ro root=3D/dev/sda3
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Initializing CPU#0
PID hash table entries: 4096 (order: 12, 16384 bytes)
TSC: PIT calibration confirmed by PMTIMER.
TSC: using PMTIMER calibration value
Detected 2391.134 MHz processor.
I-pipe 2.2-04: pipeline enabled.
Console: colour VGA+ 80x25
console [tty0] enabled
Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
Memory: 1022656k/1048004k available (2978k kernel code, 24672k reserved, 139=
4k data, 3356k init, 130500k highmem)
virtual kernel memory layout:
    fixmap  : 0xfff9f000 - 0xfffff000   ( 384 kB)
    pkmap   : 0xff800000 - 0xffc00000   (4096 kB)
    vmalloc : 0xf8800000 - 0xff7fe000   ( 111 MB)
    lowmem  : 0xc0000000 - 0xf8000000   ( 896 MB)
      .init : 0xc054c000 - 0xc0893000   (3356 kB)
      .data : 0xc03e8aba - 0xc05453c8   (1394 kB)
      .text : 0xc0100000 - 0xc03e8aba   (2978 kB)
Checking if this processor honours the WP bit even in supervisor mode...Ok.
CPA: page pool initialized 1 of 1 pages preallocated
SLUB: Genslabs=3D12, HWalign=3D128, Order=3D0-3, MinObjects=3D0, CPUs=3D2, N=
odes=3D1
Calibrating delay loop (skipped), value calculated using timer frequency.. 4=
782.26 BogoMIPS (lpj=3D9564536)
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
ACPI: Core revision 20080609
Parsing all Control Methods:
Table [DSDT](id 0001) - 303 Objects with 29 Devices 116 Methods 21 Regions
Parsing all Control Methods:
Table [SSDT](id 0002) - 7 Objects with 0 Devices 1 Methods 0 Regions
 tbxface-0596 [00] tb_load_namespace     : ACPI Tables successfully acquired
evxfevnt-0091 [00] enable                : Transition to ACPI mode successfu=
l
ENABLING IO-APIC IRQs
..TIMER: vector=3D0x31 apic1=3D0 pin1=3D2 apic2=3D-1 pin2=3D-1
CPU0: Intel(R) Pentium(R) 4 CPU 2.40GHz stepping 04
Brought up 1 CPUs
Total of 1 processors activated (4782.26 BogoMIPS).
net_namespace: 812 bytes
NET: Registered protocol family 16
No dock devices found.
ACPI: bus type pci registered
PCI: PCI BIOS revision 2.10 entry at 0xfbdf8, last bus=3D2
PCI: Using configuration type 1 for base access
evgpeblk-0957 [00] ev_create_gpe_block   : GPE 00 to 1F [_GPE] 4 regs on int=
 0x9
ACPI: EC: Look up EC in DSDT
Completing Region/Field/Buffer/Package initialization:......................=
....................
Initialized 17/21 Regions 0/0 Fields 9/9 Buffers 16/16 Packages (319 nodes)
Initializing Device/Processor/Thermal objects by executing _INI methods:....
Executed 4 _INI methods requiring 3 _STA executions (examined 33 objects)
evgpeblk-1054 [00] ev_initialize_gpe_bloc: Found 7 Wake, Enabled 1 Runtime G=
PEs in this block
ACPI: Interpreter enabled
ACPI: (supports S0 S5)
ACPI: Using IOAPIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (0000:00)
PCI: 0000:00:00.0 reg 10 32bit mmio: [e8000000, efffffff]
PCI: 0000:00:1d.0 reg 20 io port: [ff80, ff9f]
PCI: 0000:00:1d.1 reg 20 io port: [ff60, ff7f]
PCI: 0000:00:1d.2 reg 20 io port: [ff40, ff5f]
PCI: 0000:00:1d.7 reg 10 32bit mmio: [ffa20800, ffa20bff]
pci 0000:00:1d.7: PME# supported from D0 D3hot D3cold
pci 0000:00:1d.7: PME# disabled
* The chipset may have PM-Timer Bug. Due to workarounds for a bug,
* this clock source is slow. If you are sure your timer does not have
* this bug, please use "acpi_pm_good" to disable the workaround
HPET not enabled in BIOS. You might try hpet=3Dforce boot option
pci 0000:00:1f.0: quirk: region 0800-087f claimed by ICH4 ACPI/GPIO/TCO
pci 0000:00:1f.0: quirk: region 0880-08bf claimed by ICH4 GPIO
PCI: 0000:00:1f.1 reg 10 io port: [0, 7]
PCI: 0000:00:1f.1 reg 14 io port: [0, 3]
PCI: 0000:00:1f.1 reg 18 io port: [0, 7]
PCI: 0000:00:1f.1 reg 1c io port: [0, 3]
PCI: 0000:00:1f.1 reg 20 io port: [ffa0, ffaf]
PCI: 0000:00:1f.1 reg 24 32bit mmio: [0, 3ff]
PCI: 0000:00:1f.3 reg 20 io port: [cc80, cc9f]
PCI: 0000:00:1f.5 reg 10 io port: [c800, c8ff]
PCI: 0000:00:1f.5 reg 14 io port: [cc40, cc7f]
PCI: 0000:00:1f.5 reg 18 32bit mmio: [ffa20400, ffa205ff]
PCI: 0000:00:1f.5 reg 1c 32bit mmio: [ffa20000, ffa200ff]
pci 0000:00:1f.5: PME# supported from D0 D3hot D3cold
pci 0000:00:1f.5: PME# disabled
PCI: 0000:01:00.0 reg 10 32bit mmio: [f0000000, f7ffffff]
PCI: 0000:01:00.0 reg 14 io port: [ec00, ecff]
PCI: 0000:01:00.0 reg 18 32bit mmio: [ff8f0000, ff8fffff]
PCI: 0000:01:00.0 reg 30 32bit mmio: [80000000, 8001ffff]
pci 0000:01:00.0: supports D1
pci 0000:01:00.0: supports D2
PCI: bridge 0000:00:01.0 io port: [e000, efff]
PCI: bridge 0000:00:01.0 32bit mmio: [ff800000, ff9fffff]
PCI: bridge 0000:00:01.0 32bit mmio pref: [f0000000, f7ffffff]
PCI: 0000:02:07.0 reg 10 io port: [dc00, dcff]
PCI: 0000:02:07.0 reg 14 32bit mmio: [ff6ffc00, ff6ffcff]
pci 0000:02:07.0: supports D1
pci 0000:02:07.0: supports D2
pci 0000:02:07.0: PME# supported from D1 D2 D3hot D3cold
pci 0000:02:07.0: PME# disabled
PCI: 0000:02:0c.0 reg 10 32bit mmio: [ff6c0000, ff6dffff]
PCI: 0000:02:0c.0 reg 18 io port: [d8c0, d8ff]
pci 0000:02:0c.0: PME# supported from D0 D3hot D3cold
pci 0000:02:0c.0: PME# disabled
pci 0000:00:1e.0: transparent bridge
PCI: bridge 0000:00:1e.0 io port: [d000, dfff]
PCI: bridge 0000:00:1e.0 32bit mmio: [ff600000, ff7fffff]
bus 00 -> node 0
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
pnp 00:0b: io resource (0x800-0x85f) overlaps 0000:00:1f.0 BAR 7 (0x800-0x87=
f), disabling
pnp 00:0b: io resource (0x860-0x8ff) overlaps 0000:00:1f.0 BAR 7 (0x800-0x87=
f), disabling
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
system 00:0b: ioport range 0xc00-0xc7f has been reserved
pci 0000:00:01.0: PCI bridge, secondary bus 0000:01
pci 0000:00:01.0:   IO window: 0xe000-0xefff
pci 0000:00:01.0:   MEM window: 0xff800000-0xff9fffff
pci 0000:00:01.0:   PREFETCH window: 0x000000f0000000-0x000000f7ffffff
pci 0000:00:1e.0: PCI bridge, secondary bus 0000:02
pci 0000:00:1e.0:   IO window: 0xd000-0xdfff
pci 0000:00:1e.0:   MEM window: 0xff600000-0xff7fffff
pci 0000:00:1e.0:   PREFETCH window: disabled
pci 0000:00:1e.0: setting latency timer to 64
bus: 00 index 0 io port: [0, ffff]
bus: 00 index 1 mmio: [0, ffffffffffffffff]
bus: 01 index 0 io port: [e000, efff]
bus: 01 index 1 mmio: [ff800000, ff9fffff]
bus: 01 index 2 mmio: [f0000000, f7ffffff]
bus: 01 index 3 mmio: [0, 0]
bus: 02 index 0 io port: [d000, dfff]
bus: 02 index 1 mmio: [ff600000, ff7fffff]
bus: 02 index 2 mmio: [0, 0]
bus: 02 index 3 io port: [0, ffff]
bus: 02 index 4 mmio: [0, ffffffffffffffff]
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
HugeTLB registered 4 MB page size, pre-allocated 0 pages
msgmni has been set to 1743
io scheduler noop registered
io scheduler anticipatory registered
io scheduler deadline registered
io scheduler cfq registered (default)
pci 0000:01:00.0: Boot video device
radeonfb 0000:01:00.0: PCI INT A -> GSI 16 (level, low) -> IRQ 16
radeonfb: Found Intel x86 BIOS ROM Image
radeonfb: Retrieved PLL infos from BIOS
radeonfb: Reference=3D27.00 MHz (RefDiv=3D12) Memory=3D245.00 Mhz, System=3D=
170.00 MHz
radeonfb: PLL min 20000 max 35000
i2c-adapter i2c-1: unable to read EDID block.
i2c-adapter i2c-1: unable to read EDID block.
i2c-adapter i2c-1: unable to read EDID block.
Switched to high resolution mode on CPU 0
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
Real Time Clock Driver v1.12ac
Linux agpgart interface v0.103
agpgart-intel 0000:00:00.0: Intel 830M Chipset
agpgart-intel 0000:00:00.0: AGP aperture is 128M @ 0xe8000000
Serial: 8250/16550 driver4 ports, IRQ sharing disabled
serial8250: ttyS0 at I/O 0x3f8 (irq =3D 4) is a 16550A
00:09: ttyS0 at I/O 0x3f8 (irq =3D 4) is a 16550A
brd: module loaded
loop: module loaded
Intel(R) PRO/1000 Network Driver - version 7.3.21-k3-NAPI
Copyright (c) 1999-2006 Intel Corporation.
e1000 0000:02:0c.0: PCI INT A -> GSI 18 (level, low) -> IRQ 18
e1000: 0000:02:0c.0: e1000_probe: (PCI:33MHz:32-bit) 00:08:74:2a:e8:60
e1000: eth0: e1000_probe: Intel(R) PRO/1000 Network Connection
8139too Fast Ethernet driver 0.9.28
8139too 0000:02:07.0: PCI INT A -> GSI 16 (level, low) -> IRQ 16
eth1: RealTek RTL8139 at 0xf8816c00, 00:1f:1f:14:69:b1, IRQ 16
eth1:  Identified 8139 chip type 'RTL-8100B/8139D'
3ware Storage Controller device driver for Linux v1.26.02.002.
Driver 'sd' needs updating - please use bus_type methods
Driver 'sr' needs updating - please use bus_type methods
ata_piix 0000:00:1f.1: version 2.12
ata_piix 0000:00:1f.1: enabling device (0005 -> 0007)
ata_piix 0000:00:1f.1: PCI INT A -> GSI 18 (level, low) -> IRQ 18
ata_piix 0000:00:1f.1: setting latency timer to 64
scsi0 : ata_piix
scsi1 : ata_piix
ata1: PATA max UDMA/100 cmd 0x1f0 ctl 0x3f6 bmdma 0xffa0 irq 14
ata2: PATA max UDMA/100 cmd 0x170 ctl 0x376 bmdma 0xffa8 irq 15
ata1.00: ATA-7: ST3500630A, 3.AAE, max UDMA/100
ata1.00: 976773168 sectors, multi 8: LBA48=20
ata1.01: ATA-5: WDC WD400BB-60DGA0, 05.03E05, max UDMA/100
ata1.01: 78165360 sectors, multi 8: LBA=20
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
sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support=
 DPO or FUA
sd 0:0:0:0: [sda] 976773168 512-byte hardware sectors (500108 MB)
sd 0:0:0:0: [sda] Write Protect is off
sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support=
 DPO or FUA
 sda: sda1 sda2 sda3 sda4 < >
sd 0:0:0:0: [sda] Attached SCSI disk
sd 0:0:0:0: Attached scsi generic sg0 type 0
scsi 0:0:1:0: Direct-Access     ATA      WDC WD400BB-60DG 05.0 PQ: 0 ANSI: 5
sd 0:0:1:0: [sdb] 78165360 512-byte hardware sectors (40021 MB)
sd 0:0:1:0: [sdb] Write Protect is off
sd 0:0:1:0: [sdb] Mode Sense: 00 3a 00 00
sd 0:0:1:0: [sdb] Write cache: enabled, read cache: enabled, doesn't support=
 DPO or FUA
sd 0:0:1:0: [sdb] 78165360 512-byte hardware sectors (40021 MB)
sd 0:0:1:0: [sdb] Write Protect is off
sd 0:0:1:0: [sdb] Mode Sense: 00 3a 00 00
sd 0:0:1:0: [sdb] Write cache: enabled, read cache: enabled, doesn't support=
 DPO or FUA
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
ehci_hcd 0000:00:1d.7: PCI INT D -> GSI 23 (level, low) -> IRQ 23
ehci_hcd 0000:00:1d.7: setting latency timer to 64
ehci_hcd 0000:00:1d.7: EHCI Host Controller
ehci_hcd 0000:00:1d.7: new USB bus registered, assigned bus number 1
ehci_hcd 0000:00:1d.7: debug port 1
ehci_hcd 0000:00:1d.7: cache line size of 128 is not supported
ehci_hcd 0000:00:1d.7: irq 23, io mem 0xffa20800
ehci_hcd 0000:00:1d.7: USB 2.0 started, EHCI 1.00, driver 10 Dec 2004
usb usb1: configuration #1 chosen from 1 choice
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 6 ports detected
ohci_hcd: 2006 August 04 USB 1.1 'Open' Host Controller (OHCI) Driver
USB Universal Host Controller Interface driver v3.0
uhci_hcd 0000:00:1d.0: PCI INT A -> GSI 16 (level, low) -> IRQ 16
uhci_hcd 0000:00:1d.0: setting latency timer to 64
uhci_hcd 0000:00:1d.0: UHCI Host Controller
uhci_hcd 0000:00:1d.0: new USB bus registered, assigned bus number 2
uhci_hcd 0000:00:1d.0: irq 16, io base 0x0000ff80
usb usb2: configuration #1 chosen from 1 choice
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 2 ports detected
usb 1-6: new high speed USB device using ehci_hcd and address 2
uhci_hcd 0000:00:1d.1: PCI INT B -> GSI 19 (level, low) -> IRQ 19
uhci_hcd 0000:00:1d.1: setting latency timer to 64
uhci_hcd 0000:00:1d.1: UHCI Host Controller
uhci_hcd 0000:00:1d.1: new USB bus registered, assigned bus number 3
uhci_hcd 0000:00:1d.1: irq 19, io base 0x0000ff60
usb usb3: configuration #1 chosen from 1 choice
hub 3-0:1.0: USB hub found
hub 3-0:1.0: 2 ports detected
usb 1-6: configuration #1 chosen from 1 choice
uhci_hcd 0000:00:1d.2: PCI INT C -> GSI 18 (level, low) -> IRQ 18
uhci_hcd 0000:00:1d.2: setting latency timer to 64
uhci_hcd 0000:00:1d.2: UHCI Host Controller
uhci_hcd 0000:00:1d.2: new USB bus registered, assigned bus number 4
uhci_hcd 0000:00:1d.2: irq 18, io base 0x0000ff40
usb usb4: configuration #1 chosen from 1 choice
hub 4-0:1.0: USB hub found
hub 4-0:1.0: 2 ports detected
usbcore: registered new interface driver usblp
Initializing USB Mass Storage driver...
scsi2 : SCSI emulation for USB Mass Storage devices
usb-storage: device found at 2
usb-storage: waiting for device to settle before scanning
usbcore: registered new interface driver usb-storage
USB Mass Storage support registered.
PNP: PS/2 Controller [PNP0303:KBD,PNP0f13:MOU] at 0x60,0x64 irq 1,12
serio: i8042 KBD port at 0x60,0x64 irq 1
serio: i8042 AUX port at 0x60,0x64 irq 12
mice: PS/2 mouse device common for all mice
cpuidle: using governor ladder
cpuidle: using governor menu
oprofile: using NMI interrupt.
TCP cubic registered
NET: Registered protocol family 10
IPv6 over IPv4 tunneling driver
NET: Registered protocol family 17
Using IPI No-Shortcut mode
input: AT Translated Set 2 keyboard as /class/input/input2
input: ImPS/2 Logitech Wheel Mouse as /class/input/input3
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
Freeing unused kernel memory: 3356k freed
scsi 2:0:0:0: Direct-Access     -Pretec  04GB             1.00 PQ: 0 ANSI: 2
sd 2:0:0:0: [sdc] 7897088 512-byte hardware sectors (4043 MB)
sd 2:0:0:0: [sdc] Write Protect is off
sd 2:0:0:0: [sdc] Mode Sense: 00 00 00 00
sd 2:0:0:0: [sdc] Assuming drive cache: write through
sd 2:0:0:0: [sdc] 7897088 512-byte hardware sectors (4043 MB)
sd 2:0:0:0: [sdc] Write Protect is off
sd 2:0:0:0: [sdc] Mode Sense: 00 00 00 00
sd 2:0:0:0: [sdc] Assuming drive cache: write through
 sdc:
sd 2:0:0:0: [sdc] Attached SCSI removable disk
sd 2:0:0:0: Attached scsi generic sg4 type 0
usb-storage: device scan complete
EXT3 FS on sda3, internal journal
fuse init (API version 7.9)
e1000: eth0: e1000_watchdog: NIC Link is Up 1000 Mbps Full Duplex, Flow Cont=
rol: RX/TX
ADDRCONF(NETDEV_UP): eth0: link is not ready
ADDRCONF(NETDEV_CHANGE): eth0: link becomes ready
eth0: no IPv6 routers present
------------[ cut here ]------------
kernel BUG at fs/buffer.c:1289!
invalid opcode: 0000 [#1] SMP=20
Modules linked in: fuse

Pid: 5202, comm: emerge Not tainted (2.6.27.18-xenomai #2)
EIP: 0060:[<c01bcb80>] EFLAGS: 00010246 CPU: 0
EIP is at __find_get_block+0x39/0x1cd
EAX: 00000000 EBX: f773a000 ECX: 00000000 EDX: ffffffff
ESI: 00000000 EDI: f7420200 EBP: f6dd1c18 ESP: f6dd1bdc
 DS: 007b ES: 007b FS: 00d8 GS: 0033 SS: 0068
Process emerge (pid: 5202, ti=3Df6dd0000 task=3Df7833100 task.ti=3Df6dd0000)=
<0>
I-pipe domain Linux
Stack: 00d7b83d 00000000 000024cd c18409e4 00000286 00000000 c09d3600 000000=
00=20
       f773a000 00000000 f7728458 f6dd1c70 f773a000 00000000 f7728458 f6dd1c=
70=20
       c01bcd33 00001000 00d7b83d 00000000 f7420200 00000000 c01db1d8 000000=
00=20
Call Trace:
 [<c01bcd33>] ? __getblk+0x1f/0x251
 [<c01db1d8>] ? ext3_getblk+0xe/0x18f
 [<c01db219>] ? ext3_getblk+0x4f/0x18f
 [<c01db26b>] ? ext3_getblk+0xa1/0x18f
 [<c01dde8e>] ? dx_probe+0xe/0x286
 [<c01dbfcf>] ? ext3_bread+0x19/0x78
 [<c01ddebc>] ? dx_probe+0x3c/0x286
 [<c01de1d6>] ? ext3_find_entry+0xd0/0x595
 [<c03e48c0>] ? _spin_lock+0x8/0x1e
 [<c01dfb24>] ? ext3_lookup+0xe/0xa7
 [<c0113853>] ? mcount+0x1f/0x23
 [<c01dfb40>] ? ext3_lookup+0x2a/0xa7
 [<c01a6d60>] ? do_lookup+0xb6/0x153
 [<c01a8339>] ? __link_path_walk+0x6af/0xa3c
 [<c01a6794>] ? path_get+0x8/0x27
 [<c0113853>] ? mcount+0x1f/0x23
 [<c01a8704>] ? path_walk+0x3e/0x77
 [<c01a885d>] ? do_path_lookup+0xe4/0xfe
 [<c01a9211>] ? __path_lookup_intent_open+0x47/0x79
 [<c01a9258>] ? path_lookup_open+0x15/0x17
 [<c01a9401>] ? do_filp_open+0x9b/0x5ac
 [<c01b1dc7>] ? expand_files+0xe/0x235
 [<c0113853>] ? mcount+0x1f/0x23
 [<c01b204f>] ? alloc_fd+0x61/0xd9
 [<c019eea9>] ? do_sys_open+0x49/0xc3
 [<c019ef6f>] ? sys_open+0x23/0x2b
 [<c0102cf8>] ? sysenter_do_call+0x12/0x16
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
Code: 89 c7 89 55 c4 89 4d c8 9c fa 64 a1 00 d1 58 c0 8d 80 80 e2 58 c0 0f b=
a 20 00 19 d2 9d 83 fa 01 19 c0 25 00 02 00 00 85 c0 75 04 <0f> 0b eb fe b8 =
00 a3 9c c0 e8 b7 7c f8 ff 9c fa 64 a1 00 d1 58=20
EIP: [<c01bcb80>] __find_get_block+0x39/0x1cd SS:ESP 0068:f6dd1bdc
I-pipe tracer log (1000 points):
     #func                    0 ipipe_trace_panic_freeze+0x9 (oops_enter+0xd=
)
     #func                    0 oops_enter+0x8 (oops_begin+0xe)
     #func                    0 oops_begin+0x9 (die+0x19)
     #func                    0 die+0xe (do_trap+0x8f)
     #func                   -2 search_module_extables+0xa (search_exception=
_tables+0x27)
     #func                   -3 search_extable+0x9 (search_exception_tables+=
0x1c)
     #func                   -3 search_exception_tables+0x9 (fixup_exception=
+0x13)
     #func                   -3 fixup_exception+0x9 (do_trap+0x70)
     #func                   -4 do_trap+0xe (do_invalid_op+0x71)
     #func                   -5 kprobe_exceptions_notify+0xe (notifier_call_=
chain+0x30)
     #func                   -5 notifier_call_chain+0xe (__atomic_notifier_c=
all_chain+0x16)
     #func                   -5 __atomic_notifier_call_chain+0x8 (atomic_not=
ifier_call_chain+0x11)
     #func                   -5 atomic_notifier_call_chain+0x8 (notify_die+0=
x32)
     #func                   -6 notify_die+0xb (do_invalid_op+0x48)
     #func                   -6 do_invalid_op+0xd (__ipipe_handle_exception+=
0x16e)
     #func                   -7 __ipipe_handle_exception+0xe (error_code+0x7=
7)
     #func                   -8 __find_get_block+0xe (__getblk+0x1f)
     #func                   -8 __getblk+0xe (ext3_getblk+0xa1)
     #func                   -8 ext3_get_branch+0xe (ext3_get_blocks_handle+=
0x82)
     #func                   -8 ext3_block_to_path+0xe (ext3_get_blocks_hand=
le+0x58)
     #func                   -8 ext3_get_blocks_handle+0x11 (ext3_getblk+0x4=
f)
     #func                   -8 ext3_getblk+0xe (ext3_bread+0x19)
     #func                   -9 ext3_bread+0xd (dx_probe+0x3c)
     #func                   -9 dx_probe+0xe (ext3_find_entry+0xd0)
     #func                   -9 ext3_find_entry+0x11 (ext3_lookup+0x2a)
     #func                  -10 ext3_lookup+0xe (do_lookup+0xb6)
     #func                  -10 _spin_lock+0x8 (d_alloc+0x144)
     #func                  -10 __ipipe_restore_root+0x8 (kmem_cache_alloc+0=
x97)
     +func                  -11 ipipe_check_context+0x9 (__slab_alloc+0x266)
     +func                  -11 setup_object+0xa (__slab_alloc+0x23a)
     +func                  -11 setup_object+0xa (__slab_alloc+0x20f)
     +func                  -11 setup_object+0xa (__slab_alloc+0x20f)
     +func                  -11 setup_object+0xa (__slab_alloc+0x20f)
     +func                  -12 setup_object+0xa (__slab_alloc+0x20f)
     +func                  -12 setup_object+0xa (__slab_alloc+0x20f)
     +func                  -12 setup_object+0xa (__slab_alloc+0x20f)
     +func                  -12 setup_object+0xa (__slab_alloc+0x20f)
     +func                  -12 setup_object+0xa (__slab_alloc+0x20f)
     +func                  -12 setup_object+0xa (__slab_alloc+0x20f)
     +func                  -12 setup_object+0xa (__slab_alloc+0x20f)
     +func                  -13 setup_object+0xa (__slab_alloc+0x20f)
     +func                  -13 setup_object+0xa (__slab_alloc+0x20f)
     +func                  -13 setup_object+0xa (__slab_alloc+0x20f)
     +func                  -13 setup_object+0xa (__slab_alloc+0x20f)
     +func                  -13 setup_object+0xa (__slab_alloc+0x20f)
     +func                  -13 setup_object+0xa (__slab_alloc+0x20f)
     +func                  -14 setup_object+0xa (__slab_alloc+0x20f)
     +func                  -14 setup_object+0xa (__slab_alloc+0x20f)
     +func                  -14 setup_object+0xa (__slab_alloc+0x20f)
     +func                  -14 setup_object+0xa (__slab_alloc+0x20f)
     +func                  -14 setup_object+0xa (__slab_alloc+0x20f)
     +func                  -15 setup_object+0xa (__slab_alloc+0x20f)
     +func                  -15 setup_object+0xa (__slab_alloc+0x20f)
     +func                  -15 setup_object+0xa (__slab_alloc+0x20f)
     +func                  -15 setup_object+0xa (__slab_alloc+0x20f)
     +func                  -15 setup_object+0xa (__slab_alloc+0x20f)
     +func                  -15 setup_object+0xa (__slab_alloc+0x20f)
     +func                  -16 setup_object+0xa (__slab_alloc+0x20f)
     +func                  -16 setup_object+0xa (__slab_alloc+0x20f)
     +func                  -16 setup_object+0xa (__slab_alloc+0x20f)
     +func                  -17 page_address+0xe (__slab_alloc+0x1b8)
 |   +end     0x80000000    -18 __ipipe_unstall_root+0x4d (__ipipe_restore_r=
oot+0x27)
 |   #begin   0x80000000    -18 __ipipe_unstall_root+0x2a (__ipipe_restore_r=
oot+0x27)
     #func                  -18 __ipipe_unstall_root+0x9 (__ipipe_restore_ro=
ot+0x27)
     #func                  -18 __ipipe_restore_root+0x8 (mod_zone_page_stat=
e+0x5e)
     #func                  -18 __mod_zone_page_state+0xb (mod_zone_page_sta=
te+0x4c)
     +func                  -19 ipipe_check_context+0x9 (mod_zone_page_state=
+0x1f)
     +func                  -19 mod_zone_page_state+0xe (__slab_alloc+0x18d)
 |   +end     0x80000000    -19 __ipipe_unstall_root+0x4d (__ipipe_restore_r=
oot+0x27)
 |   #begin   0x80000000    -19 __ipipe_unstall_root+0x2a (__ipipe_restore_r=
oot+0x27)
     #func                  -20 __ipipe_unstall_root+0x9 (__ipipe_restore_ro=
ot+0x27)
     #func                  -20 __ipipe_restore_root+0x8 (get_page_from_free=
list+0x285)
     +func                  -20 ipipe_check_context+0x9 (get_page_from_freel=
ist+0x127)
     +func                  -21 zone_watermark_ok+0xe (get_page_from_freelis=
t+0x8a)
     +func                  -22 next_zones_zonelist+0x9 (get_page_from_freel=
ist+0x37c)
     +func                  -22 next_zones_zonelist+0x9 (get_page_from_freel=
ist+0x2f)
     +func                  -23 get_page_from_freelist+0xe (__alloc_pages_in=
ternal+0xc7)
     +func                  -24 ipipe_check_context+0x9 (__cond_resched+0x39=
)
 |   +end     0x80000000    -24 __ipipe_unstall_root+0x4d (finish_task_switc=
h+0x2e)
 |   #begin   0x80000000    -24 __ipipe_unstall_root+0x2a (finish_task_switc=
h+0x2e)
     #func                  -24 __ipipe_unstall_root+0x9 (finish_task_switch=
+0x2e)
     #func                  -25 finish_task_switch+0xe (schedule+0x637)
 |   #end     0x80000000    -25 schedule+0x618 (__cond_resched+0x2f)
 |   #func                  -25 __switch_to+0xe (schedule+0x5da)
 |   #begin   0x80000000    -26 schedule+0x3c1 (gatekeeper_thread+0xeb)
     #func                  -26 hrtick_start_fair+0x8 (pick_next_task_fair+0=
xa1)
     #func                  -26 rb_erase+0xe (__dequeue_entity+0x78)
     #func                  -27 rb_next+0x8 (__dequeue_entity+0x24)
     #func                  -27 __dequeue_entity+0xe (set_next_entity+0x19)
     #func                  -27 set_next_entity+0xa (pick_next_task_fair+0x9=
5)
     #func                  -27 pick_next_task_fair+0xe (schedule+0x32f)
     #func                  -28 balance_runtime+0xe (update_curr_rt+0xd9)
     #func                  -28 _spin_lock+0x8 (update_curr_rt+0x8d)
     #func                  -28 update_curr_rt+0xe (put_prev_task_rt+0x10)
     #func                  -28 put_prev_task_rt+0x9 (schedule+0x31d)
     #func                  -28 pull_rt_task+0xe (pre_schedule_rt+0x1d)
     #func                  -29 pre_schedule_rt+0x8 (schedule+0x161)
     #func                  -29 update_rt_migration+0x8 (dequeue_rt_stack+0x=
173)
     #func                  -29 __ipipe_restore_root+0x8 (_spin_unlock_irqre=
store+0x1d)
     #func                  -29 _spin_unlock_irqrestore+0x8 (cpupri_set+0xad=
)
     #func                  -29 ipipe_check_context+0x9 (_spin_lock_irqsave+=
0x15)
     #func                  -30 _spin_lock_irqsave+0x9 (cpupri_set+0x8a)
     #func                  -30 __ipipe_restore_root+0x8 (_spin_unlock_irqre=
store+0x1d)
     #func                  -30 _spin_unlock_irqrestore+0x8 (cpupri_set+0x78=
)
     #func                  -30 ipipe_check_context+0x9 (_spin_lock_irqsave+=
0x15)
     #func                  -30 _spin_lock_irqsave+0x9 (cpupri_set+0x51)
     #func                  -30 convert_prio+0x8 (cpupri_set+0x2d)
     #func                  -31 cpupri_set+0xe (dequeue_rt_stack+0x16b)
     #func                  -31 dequeue_rt_stack+0xe (dequeue_task_rt+0x1b)
     #func                  -31 balance_runtime+0xe (update_curr_rt+0xd9)
     #func                  -31 _spin_lock+0x8 (update_curr_rt+0x8d)
     #func                  -31 update_curr_rt+0xe (dequeue_task_rt+0x13)
     #func                  -32 dequeue_task_rt+0xa (dequeue_task+0x77)
     #func                  -32 dequeue_task+0xe (deactivate_task+0x1e)
     #func                  -32 deactivate_task+0x9 (schedule+0x140)
     #func                  -32 _spin_lock+0x8 (schedule+0xe4)
     #func                  -32 __update_sched_clock+0xe (sched_clock_cpu+0x=
163)
     #func                  -33 __ipipe_restore_root+0x8 (native_sched_clock=
+0xbc)
     #func                  -33 ipipe_check_context+0x9 (native_sched_clock+=
0x54)
     #func                  -33 native_read_tsc+0x8 (native_sched_clock+0x46=
)
     #func                  -33 native_sched_clock+0xe (sched_clock_cpu+0x7d=
)
     #func                  -33 sched_clock_cpu+0xe (schedule+0xce)
     +func                  -34 ipipe_check_context+0x9 (schedule+0xac)
     +func                  -34 ipipe_check_context+0x9 (schedule+0x64)
     +func                  -34 schedule+0xe (gatekeeper_thread+0xeb)
 |   +end     0x80000000    -34 __ipipe_unstall_root+0x4d (__ipipe_restore_r=
oot+0x27)
 |   #begin   0x80000000    -35 __ipipe_unstall_root+0x2a (__ipipe_restore_r=
oot+0x27)
     #func                  -35 __ipipe_unstall_root+0x9 (__ipipe_restore_ro=
ot+0x27)
     #func                  -35 __ipipe_restore_root+0x8 (_spin_unlock_irqre=
store+0x1d)
     #func                  -35 _spin_unlock_irqrestore+0x8 (up+0x30)
     +func                  -35 ipipe_check_context+0x9 (_spin_lock_irqsave+=
0x15)
     +func                  -35 _spin_lock_irqsave+0x9 (up+0x11)
     +func                  -36 up+0xa (gatekeeper_thread+0xe6)
 |   +end     0x80000000    -36 __ipipe_restore_pipeline_head+0xb8 (gatekeep=
er_thread+0x1da)
 |  # [  222] gatekee -1    -37 xnpod_schedule+0xc7a (xnpod_schedule_handler=
+0x5b)
 |  # func                  -38 __switch_to+0xe (xnpod_schedule+0xb77)
 |  # [ 5195] LevelTa 90    -38 xnpod_schedule+0xeb (xnpod_suspend_thread+0x=
1e2)
 |  # func                  -39 xnpod_schedule+0x11 (xnpod_suspend_thread+0x=
1e2)
 |  # func                  -39 xnpod_suspend_thread+0xe (xnsynch_sleep_on+0=
x115)
 |  # func                  -39 xnsynch_sleep_on+0xe (rt_event_wait+0x156)
 |  + begin   0x80000000    -40 rt_event_wait+0x27 (__rt_event_wait+0x7f)
    + func                  -40 rt_event_wait+0xe (__rt_event_wait+0x7f)
    + func                  -40 __copy_from_user_ll_nozero+0xa (__rt_event_w=
ait+0x6a)
 |  + end     0x80000000    -40 __ipipe_restore_pipeline_head+0xb8 (xnregist=
ry_fetch+0x112)
 |  # func                  -40 __ipipe_restore_pipeline_head+0xb (xnregistr=
y_fetch+0x112)
 |  + begin   0x80000000    -41 xnregistry_fetch+0x1e (__rt_event_wait+0x45)
    + func                  -41 xnregistry_fetch+0xa (__rt_event_wait+0x45)
    + func                  -41 __rt_event_wait+0xe (hisyscall_event+0x136)
    + func                  -41 hisyscall_event+0xe (__ipipe_dispatch_event+=
0xe5)
 |  + end     0x80000001    -41 __ipipe_dispatch_event+0xd5 (__ipipe_syscall=
_root+0x8d)
 |  + begin   0x80000001    -42 __ipipe_dispatch_event+0x2c (__ipipe_syscall=
_root+0x8d)
    + func                  -42 __ipipe_dispatch_event+0xe (__ipipe_syscall_=
root+0x8d)
    + func                  -42 __ipipe_syscall_root+0xa (system_call+0x29)
 |  + end     0x80000001    -43 __ipipe_dispatch_event+0x1da (__ipipe_syscal=
l_root+0x8d)
 |  + begin   0x80000001    -43 __ipipe_dispatch_event+0x108 (__ipipe_syscal=
l_root+0x8d)
 |  + end     0x80000000    -43 __ipipe_restore_pipeline_head+0xb8 (rt_mutex=
_release+0x14d)
 |  # func                  -44 __ipipe_restore_pipeline_head+0xb (rt_mutex_=
release+0x14d)
 |  # func                  -44 xnsynch_wakeup_one_sleeper+0xe (rt_mutex_rel=
ease+0xe7)
 |  + begin   0x80000000    -44 rt_mutex_release+0x5c (__rt_mutex_release+0x=
3c)
    + func                  -44 rt_mutex_release+0xb (__rt_mutex_release+0x3=
c)
 |  + end     0x80000000    -44 __ipipe_restore_pipeline_head+0xb8 (xnregist=
ry_fetch+0x112)
 |  # func                  -44 __ipipe_restore_pipeline_head+0xb (xnregistr=
y_fetch+0x112)
 |  + begin   0x80000000    -45 xnregistry_fetch+0x1e (__rt_mutex_release+0x=
33)
    + func                  -45 xnregistry_fetch+0xa (__rt_mutex_release+0x3=
3)
    + func                  -45 __rt_mutex_release+0xc (hisyscall_event+0x13=
6)
    + func                  -45 hisyscall_event+0xe (__ipipe_dispatch_event+=
0xe5)
 |  + end     0x80000001    -45 __ipipe_dispatch_event+0xd5 (__ipipe_syscall=
_root+0x8d)
 |  + begin   0x80000001    -46 __ipipe_dispatch_event+0x2c (__ipipe_syscall=
_root+0x8d)
    + func                  -46 __ipipe_dispatch_event+0xe (__ipipe_syscall_=
root+0x8d)
    + func                  -46 __ipipe_syscall_root+0xa (system_call+0x29)
 |  + end     0x80000001    -47 __ipipe_dispatch_event+0x1da (__ipipe_syscal=
l_root+0x8d)
 |  + begin   0x80000001    -47 __ipipe_dispatch_event+0x108 (__ipipe_syscal=
l_root+0x8d)
 |  + end     0x80000000    -47 __ipipe_restore_pipeline_head+0xb8 (rt_mutex=
_release+0x14d)
 |  # func                  -47 __ipipe_restore_pipeline_head+0xb (rt_mutex_=
release+0x14d)
 |  # func                  -48 xnsynch_wakeup_one_sleeper+0xe (rt_mutex_rel=
ease+0xe7)
 |  + begin   0x80000000    -48 rt_mutex_release+0x5c (__rt_mutex_release+0x=
3c)
    + func                  -48 rt_mutex_release+0xb (__rt_mutex_release+0x3=
c)
 |  + end     0x80000000    -49 __ipipe_restore_pipeline_head+0xb8 (xnregist=
ry_fetch+0x112)
 |  # func                  -49 __ipipe_restore_pipeline_head+0xb (xnregistr=
y_fetch+0x112)
 |  + begin   0x80000000    -49 xnregistry_fetch+0x1e (__rt_mutex_release+0x=
33)
    + func                  -49 xnregistry_fetch+0xa (__rt_mutex_release+0x3=
3)
    + func                  -49 __rt_mutex_release+0xc (hisyscall_event+0x13=
6)
    + func                  -49 hisyscall_event+0xe (__ipipe_dispatch_event+=
0xe5)
 |  + end     0x80000001    -50 __ipipe_dispatch_event+0xd5 (__ipipe_syscall=
_root+0x8d)
 |  + begin   0x80000001    -50 __ipipe_dispatch_event+0x2c (__ipipe_syscall=
_root+0x8d)
    + func                  -50 __ipipe_dispatch_event+0xe (__ipipe_syscall_=
root+0x8d)
    + func                  -50 __ipipe_syscall_root+0xa (system_call+0x29)
 |  + end     0x80000001    -51 __ipipe_dispatch_event+0x1da (__ipipe_syscal=
l_root+0x8d)
 |  + begin   0x80000001    -52 __ipipe_dispatch_event+0x108 (__ipipe_syscal=
l_root+0x8d)
 |  + end     0x80000000    -52 __ipipe_restore_pipeline_head+0xb8 (rt_mutex=
_acquire+0x187)
 |  # func                  -52 __ipipe_restore_pipeline_head+0xb (rt_mutex_=
acquire+0x187)
 |  + begin   0x80000000    -52 rt_mutex_acquire+0x65 (__rt_mutex_acquire+0x=
5f)
    + func                  -53 rt_mutex_acquire+0xe (__rt_mutex_acquire+0x5=
f)
 |  + end     0x80000000    -53 __ipipe_restore_pipeline_head+0xb8 (xnregist=
ry_fetch+0x112)
 |  # func                  -53 __ipipe_restore_pipeline_head+0xb (xnregistr=
y_fetch+0x112)
 |  + begin   0x80000000    -53 xnregistry_fetch+0x1e (__rt_mutex_acquire+0x=
47)
    + func                  -54 xnregistry_fetch+0xa (__rt_mutex_acquire+0x4=
7)
    + func                  -54 __copy_from_user_ll_nozero+0xa (__rt_mutex_a=
cquire+0x3f)
    + func                  -54 __rt_mutex_acquire+0xd (hisyscall_event+0x13=
6)
    + func                  -54 hisyscall_event+0xe (__ipipe_dispatch_event+=
0xe5)
 |  + end     0x80000001    -54 __ipipe_dispatch_event+0xd5 (__ipipe_syscall=
_root+0x8d)
 |  + begin   0x80000001    -55 __ipipe_dispatch_event+0x2c (__ipipe_syscall=
_root+0x8d)
    + func                  -55 __ipipe_dispatch_event+0xe (__ipipe_syscall_=
root+0x8d)
    + func                  -55 __ipipe_syscall_root+0xa (system_call+0x29)
 |  + end     0x80000001    -82 __ipipe_dispatch_event+0x1da (__ipipe_syscal=
l_root+0x8d)
 |  + begin   0x80000001    -82 __ipipe_dispatch_event+0x108 (__ipipe_syscal=
l_root+0x8d)
 |  + end     0x80000000    -82 __ipipe_restore_pipeline_head+0xb8 (rt_mutex=
_acquire+0x187)
 |  # func                  -82 __ipipe_restore_pipeline_head+0xb (rt_mutex_=
acquire+0x187)
 |  + begin   0x80000000    -83 rt_mutex_acquire+0x65 (__rt_mutex_acquire+0x=
5f)
    + func                  -83 rt_mutex_acquire+0xe (__rt_mutex_acquire+0x5=
f)
 |  + end     0x80000000    -84 __ipipe_restore_pipeline_head+0xb8 (xnregist=
ry_fetch+0x112)
 |  # func                  -84 __ipipe_restore_pipeline_head+0xb (xnregistr=
y_fetch+0x112)
 |  + begin   0x80000000    -84 xnregistry_fetch+0x1e (__rt_mutex_acquire+0x=
47)
    + func                  -84 xnregistry_fetch+0xa (__rt_mutex_acquire+0x4=
7)
    + func                  -85 __copy_from_user_ll_nozero+0xa (__rt_mutex_a=
cquire+0x3f)
    + func                  -85 __rt_mutex_acquire+0xd (losyscall_event+0xad=
)
 |  + end     0x80000000    -85 __ipipe_restore_pipeline_head+0xb8 (xnshadow=
_harden+0x1c9)
 |  # begin   0x80000000    -85 __ipipe_restore_pipeline_head+0x34 (xnshadow=
_harden+0x1c9)
    # func                  -86 __ipipe_restore_pipeline_head+0xb (xnshadow_=
harden+0x1c9)
    # func                  -87 xnpod_switch_fpu+0xb (xnshadow_harden+0xe3)
 |  # end     0x80000000    -87 schedule+0x618 (xnshadow_harden+0xa4)
 |  # func                  -88 __switch_to+0xe (schedule+0x5da)
 |  # [ 5202] emerge  -1    -88 xnpod_schedule+0xeb (xnpod_schedule_handler+=
0x5b)
 |  # func                  -89 xnpod_schedule+0x11 (xnpod_schedule_handler+=
0x5b)
 |  # func                  -89 xnpod_schedule_handler+0x9 (__virq_end+0x37)
 |  + func                  -89 __ipipe_sync_stage+0xe (ipipe_suspend_domain=
+0x94)
 |  + func                  -89 ipipe_suspend_domain+0xe (__ipipe_walk_pipel=
ine+0x8b)
 |   +func                  -90 __ipipe_walk_pipeline+0xe (__ipipe_restore_p=
ipeline_head+0xa7)
 |  *+func                  -90 __ipipe_restore_pipeline_head+0xb (gatekeepe=
r_thread+0x1da)
 |  *+func                  -90 __ipipe_set_irq_pending+0xb (__ipipe_dispatc=
h_wired+0x5b)
 |  *+func                  -90 __ipipe_dispatch_wired+0x9 (__ipipe_handle_i=
rq+0xad)
 |  *+func                  -91 __ipipe_handle_irq+0xe (ipipe_trigger_irq+0x=
a0)
 |  *+func                  -91 memcpy+0xe (ipipe_trigger_irq+0x9b)
 |  *+func                  -91 ipipe_trigger_irq+0xe (xnpod_schedule+0x34)
 |  *+func                  -91 xnpod_schedule+0x11 (gatekeeper_thread+0x18e=
)
 |  *+[ 5195] LevelTa 90    -91 xnpod_resume_thread+0x9d (gatekeeper_thread+=
0x189)
 |  *+func                  -92 xnpod_resume_thread+0xe (gatekeeper_thread+0=
x189)
 |   +begin   0x80000000    -92 gatekeeper_thread+0x122 (kthread+0x40)
 |   +end     0x80000000    -92 __ipipe_restore_pipeline_head+0xb8 (rpi_pop+=
0x2a2)
 |  *+func                  -92 __ipipe_restore_pipeline_head+0xb (rpi_pop+0=
x2a2)
 |  *+[ 5202] emerge  -1    -93 xnpod_schedule_runnable+0x4a (rpi_pop+0x25a)
 |  *+func                  -93 xnpod_schedule_runnable+0x11 (rpi_pop+0x25a)
 |   +begin   0x80000000    -93 rpi_pop+0x1f7 (gatekeeper_thread+0x110)
 |   +end     0x80000000    -93 __ipipe_restore_pipeline_head+0xb8 (rpi_pop+=
0x1cc)
 |  *+func                  -94 __ipipe_restore_pipeline_head+0xb (rpi_pop+0=
x1cc)
 |   +begin   0x80000000    -94 rpi_pop+0x3e (gatekeeper_thread+0x110)
     +func                  -94 rpi_pop+0xe (gatekeeper_thread+0x110)
     +func                  -95 kthread_should_stop+0x8 (gatekeeper_thread+0=
xf0)
     +func                  -95 post_schedule_rt+0x9 (finish_task_switch+0x4=
2)
 |   +end     0x80000000    -95 __ipipe_unstall_root+0x4d (finish_task_switc=
h+0x2e)
 |   #begin   0x80000000    -95 __ipipe_unstall_root+0x2a (finish_task_switc=
h+0x2e)
     #func                  -96 __ipipe_unstall_root+0x9 (finish_task_switch=
+0x2e)
     #func                  -96 finish_task_switch+0xe (schedule+0x637)
 |   #end     0x80000000    -96 schedule+0x618 (gatekeeper_thread+0xeb)
 |   #func                  -96 __switch_to+0xe (schedule+0x5da)
 |   #begin   0x80000000    -97 schedule+0x3c1 (xnshadow_harden+0xa4)
 |   #end     0x80000001    -97 __ipipe_dispatch_event+0x1da (schedule+0x3af=
)
 |   #begin   0x80000001    -97 __ipipe_dispatch_event+0x108 (schedule+0x3af=
)
 |   #end     0x80000000    -97 __ipipe_restore_pipeline_head+0xb8 (schedule=
_event+0x478)
 |  *#func                  -98 __ipipe_restore_pipeline_head+0xb (schedule_=
event+0x478)
 |   #begin   0x80000000    -98 schedule_event+0x281 (__ipipe_dispatch_event=
+0xe5)
     #func                  -98 schedule_event+0xe (__ipipe_dispatch_event+0=
xe5)
 |   #end     0x80000001    -99 __ipipe_dispatch_event+0xd5 (schedule+0x3af)
 |   #begin   0x80000001    -99 __ipipe_dispatch_event+0x2c (schedule+0x3af)
     #func                  -99 __ipipe_dispatch_event+0xe (schedule+0x3af)
     #func                  -99 pick_next_task_rt+0x9 (schedule+0x340)
     #func                 -100 balance_runtime+0xe (update_curr_rt+0xd9)
     #func                 -100 _spin_lock+0x8 (update_curr_rt+0x8d)
     #func                 -100 update_curr_rt+0xe (put_prev_task_rt+0x10)
     #func                 -100 put_prev_task_rt+0x9 (schedule+0x31d)
     #func                 -100 pre_schedule_rt+0x8 (schedule+0x161)
     #func                 -100 update_rt_migration+0x8 (dequeue_rt_stack+0x=
173)
     #func                 -101 dequeue_rt_stack+0xe (dequeue_task_rt+0x1b)
     #func                 -101 balance_runtime+0xe (update_curr_rt+0xd9)
     #func                 -101 _spin_lock+0x8 (update_curr_rt+0x8d)
     #func                 -101 update_curr_rt+0xe (dequeue_task_rt+0x13)
     #func                 -102 dequeue_task_rt+0xa (dequeue_task+0x77)
     #func                 -102 dequeue_task+0xe (deactivate_task+0x1e)
     #func                 -102 deactivate_task+0x9 (schedule+0x140)
     #func                 -102 _spin_lock+0x8 (schedule+0xe4)
     #func                 -103 __update_sched_clock+0xe (sched_clock_cpu+0x=
163)
     #func                 -103 __ipipe_restore_root+0x8 (native_sched_clock=
+0xbc)
     #func                 -103 ipipe_check_context+0x9 (native_sched_clock+=
0x54)
     #func                 -103 native_read_tsc+0x8 (native_sched_clock+0x46=
)
     #func                 -103 native_sched_clock+0xe (sched_clock_cpu+0x7d=
)
     #func                 -104 sched_clock_cpu+0xe (schedule+0xce)
     +func                 -104 ipipe_check_context+0x9 (schedule+0xac)
     +func                 -104 ipipe_check_context+0x9 (schedule+0x64)
     +func                 -104 schedule+0xe (xnshadow_harden+0xa4)
 |   +end     0x80000000   -104 __ipipe_unstall_root+0x4d (__ipipe_restore_r=
oot+0x27)
 |   #begin   0x80000000   -105 __ipipe_unstall_root+0x2a (__ipipe_restore_r=
oot+0x27)
     #func                 -105 __ipipe_unstall_root+0x9 (__ipipe_restore_ro=
ot+0x27)
     #func                 -105 __ipipe_restore_root+0x8 (_spin_unlock_irqre=
store+0x1d)
     #func                 -105 _spin_unlock_irqrestore+0x8 (__wake_up_sync+=
0x3f)
     #func                 -105 __ipipe_restore_root+0x8 (_spin_unlock_irqre=
store+0x1d)
     #func                 -105 _spin_unlock_irqrestore+0x8 (try_to_wake_up+=
0x12a)
     #func                 -105 task_wake_up_rt+0x8 (try_to_wake_up+0x10a)
     #func                 -106 resched_task+0x9 (check_preempt_curr_rt+0x8f=
)
     #func                 -106 check_preempt_curr_rt+0xd (try_to_wake_up+0x=
f4)
     #func                 -106 update_rt_migration+0x8 (__enqueue_rt_entity=
+0xb2)
     #func                 -106 __ipipe_restore_root+0x8 (_spin_unlock_irqre=
store+0x1d)
     #func                 -106 _spin_unlock_irqrestore+0x8 (cpupri_set+0xad=
)
     #func                 -107 ipipe_check_context+0x9 (_spin_lock_irqsave+=
0x15)
     #func                 -107 _spin_lock_irqsave+0x9 (cpupri_set+0x8a)
     #func                 -107 __ipipe_restore_root+0x8 (_spin_unlock_irqre=
store+0x1d)
     #func                 -107 _spin_unlock_irqrestore+0x8 (cpupri_set+0x78=
)
     #func                 -107 ipipe_check_context+0x9 (_spin_lock_irqsave+=
0x15)
     #func                 -108 _spin_lock_irqsave+0x9 (cpupri_set+0x51)
     #func                 -108 convert_prio+0x8 (cpupri_set+0x2d)
     #func                 -108 cpupri_set+0xe (__enqueue_rt_entity+0x9b)
     #func                 -108 __enqueue_rt_entity+0xe (enqueue_task_rt+0x3=
8)
     #func                 -108 dequeue_rt_stack+0xe (enqueue_task_rt+0x24)
     #func                 -108 enqueue_task_rt+0xb (enqueue_task+0x12)
     #func                 -109 enqueue_task+0xa (activate_task+0x1e)
     #func                 -109 activate_task+0x9 (try_to_wake_up+0xe0)
     #func                 -109 __update_sched_clock+0xe (sched_clock_cpu+0x=
163)
     #func                 -109 __ipipe_restore_root+0x8 (native_sched_clock=
+0xbc)
     #func                 -109 ipipe_check_context+0x9 (native_sched_clock+=
0x54)
     #func                 -110 native_read_tsc+0x8 (native_sched_clock+0x46=
)
     #func                 -110 native_sched_clock+0xe (sched_clock_cpu+0x7d=
)
     #func                 -110 sched_clock_cpu+0xe (try_to_wake_up+0xc6)
     #func                 -110 select_task_rq_rt+0x9 (try_to_wake_up+0x86)
     #func                 -111 _spin_lock+0x8 (task_rq_lock+0x5d)
     #func                 -111 ipipe_check_context+0x9 (task_rq_lock+0x1d)
     #func                 -111 task_rq_lock+0xe (try_to_wake_up+0x51)
     #func                 -111 try_to_wake_up+0xe (default_wake_function+0x=
10)
     #func                 -112 default_wake_function+0x8 (__wake_up_common+=
0x34)
     #func                 -112 __wake_up_common+0xe (__wake_up_sync+0x36)
     +func                 -112 ipipe_check_context+0x9 (_spin_lock_irqsave+=
0x15)
     +func                 -112 _spin_lock_irqsave+0x9 (__wake_up_sync+0x1e)
     +func                 -112 __wake_up_sync+0xe (xnshadow_harden+0x9f)
 |   +end     0x80000000   -113 __ipipe_unstall_root+0x4d (__ipipe_restore_r=
oot+0x27)
 |   #begin   0x80000000   -113 __ipipe_unstall_root+0x2a (__ipipe_restore_r=
oot+0x27)
     #func                 -113 __ipipe_unstall_root+0x9 (__ipipe_restore_ro=
ot+0x27)
     #func                 -113 __ipipe_restore_root+0x8 (_spin_unlock_irqre=
store+0x1d)
     #func                 -113 _spin_unlock_irqrestore+0x8 (down_interrupti=
ble+0x35)
     +func                 -114 ipipe_check_context+0x9 (_spin_lock_irqsave+=
0x15)
     +func                 -114 _spin_lock_irqsave+0x9 (down_interruptible+0=
x12)
     +func                 -114 down_interruptible+0xb (xnshadow_harden+0x56=
)
     +func                 -114 xnshadow_harden+0xe (losyscall_event+0x7d)
     +func                 -114 losyscall_event+0xe (__ipipe_dispatch_event+=
0xe5)
 |   +end     0x80000001   -115 __ipipe_dispatch_event+0xd5 (__ipipe_syscall=
_root+0x8d)
 |  + begin   0x80000001   -115 __ipipe_dispatch_event+0x108 (__ipipe_syscal=
l_root+0x8d)
    + func                 -115 hisyscall_event+0xe (__ipipe_dispatch_event+=
0xe5)
 |  + end     0x80000001   -115 __ipipe_dispatch_event+0xd5 (__ipipe_syscall=
_root+0x8d)
 |   +begin   0x80000001   -116 __ipipe_dispatch_event+0x2c (__ipipe_syscall=
_root+0x8d)
     +func                 -116 __ipipe_dispatch_event+0xe (__ipipe_syscall_=
root+0x8d)
     +func                 -116 __ipipe_syscall_root+0xa (system_call+0x29)
 |   +end     0x8000000d   -117 __ipipe_unstall_iret_root+0x64 (sysenter_out=
+0x0)
 |   #begin   0x80000000   -118 __ipipe_unstall_iret_root+0x2e (sysenter_out=
+0x0)
     #func                 -118 __ipipe_unstall_iret_root+0xa (sysenter_out+=
0x0)
     +func                 -118 fput+0x8 (sys_write+0x5c)
     +func                 -118 inotify_inode_queue_event+0xe (vfs_write+0xf=
6)
     +func                 -119 inotify_dentry_parent_queue_event+0xe (vfs_w=
rite+0xe7)
     +func                 -120 _spin_lock+0x8 (dnotify_parent+0x20)
     +func                 -120 dnotify_parent+0xb (vfs_write+0xd9)
 |   +end     0x80000000   -120 __ipipe_unstall_root+0x4d (__ipipe_restore_r=
oot+0x27)
 |   #begin   0x80000000   -120 __ipipe_unstall_root+0x2a (__ipipe_restore_r=
oot+0x27)
     #func                 -120 __ipipe_unstall_root+0x9 (__ipipe_restore_ro=
ot+0x27)
     #func                 -121 __ipipe_restore_root+0x8 (_spin_unlock_irqre=
store+0x1d)
     #func                 -121 _spin_unlock_irqrestore+0x8 (tty_ldisc_deref=
+0x61)
     #func                 -121 __ipipe_restore_root+0x8 (_spin_unlock_irqre=
store+0x1d)
     #func                 -121 _spin_unlock_irqrestore+0x8 (__wake_up+0x36)
     #func                 -121 __wake_up_common+0xe (__wake_up+0x2d)
     #func                 -121 ipipe_check_context+0x9 (_spin_lock_irqsave+=
0x15)
     #func                 -122 _spin_lock_irqsave+0x9 (__wake_up+0x1a)
     #func                 -122 __wake_up+0xe (tty_ldisc_deref+0x54)
     +func                 -122 ipipe_check_context+0x9 (_spin_lock_irqsave+=
0x15)
     +func                 -122 _spin_lock_irqsave+0x9 (tty_ldisc_deref+0x1e=
)
     +func                 -122 tty_ldisc_deref+0xa (tty_write+0x1ae)
 |   +end     0x80000000   -123 __ipipe_unstall_root+0x4d (__ipipe_restore_r=
oot+0x27)
 |   #begin   0x80000000   -123 __ipipe_unstall_root+0x2a (__ipipe_restore_r=
oot+0x27)
     #func                 -123 __ipipe_unstall_root+0x9 (__ipipe_restore_ro=
ot+0x27)
     #func                 -123 __ipipe_restore_root+0x8 (_spin_unlock_irqre=
store+0x1d)
     #func                 -123 _spin_unlock_irqrestore+0x8 (__wake_up+0x36)
     #func                 -123 __wake_up_common+0xe (__wake_up+0x2d)
     +func                 -124 ipipe_check_context+0x9 (_spin_lock_irqsave+=
0x15)
     +func                 -124 _spin_lock_irqsave+0x9 (__wake_up+0x1a)
     +func                 -124 __wake_up+0xe (tty_write_unlock+0x2f)
     +func                 -124 mutex_unlock+0x8 (tty_write_unlock+0x1c)
     +func                 -125 tty_write_unlock+0x9 (tty_write+0x1a6)
     +func                 -125 timespec_trunc+0xe (current_fs_time+0x1b)
     +func                 -126 current_kernel_time+0xa (current_fs_time+0x1=
0)
     +func                 -126 current_fs_time+0x9 (tty_write+0x196)
 |   +end     0x80000000   -126 __ipipe_unstall_root+0x4d (__ipipe_restore_r=
oot+0x27)
 |   #begin   0x80000000   -127 __ipipe_unstall_root+0x2a (__ipipe_restore_r=
oot+0x27)
     #func                 -127 __ipipe_unstall_root+0x9 (__ipipe_restore_ro=
ot+0x27)
     #func                 -127 __ipipe_restore_root+0x8 (_spin_unlock_irqre=
store+0x1d)
     #func                 -127 _spin_unlock_irqrestore+0x8 (remove_wait_que=
ue+0x39)
     +func                 -127 ipipe_check_context+0x9 (_spin_lock_irqsave+=
0x15)
     +func                 -128 _spin_lock_irqsave+0x9 (remove_wait_queue+0x=
14)
     +func                 -128 remove_wait_queue+0xb (write_chan+0x27c)
 |   +end     0x80000000   -128 __ipipe_unstall_root+0x4d (__ipipe_restore_r=
oot+0x27)
 |   #begin   0x80000000   -128 __ipipe_unstall_root+0x2a (__ipipe_restore_r=
oot+0x27)
     #func                 -128 __ipipe_unstall_root+0x9 (__ipipe_restore_ro=
ot+0x27)
     #func                 -128 __ipipe_restore_root+0x8 (_spin_unlock_irqre=
store+0x1d)
     #func                 -129 _spin_unlock_irqrestore+0x8 (release_console=
_sem+0x185)
     #func                 -129 __ipipe_restore_root+0x8 (_spin_unlock_irqre=
store+0x1d)
     #func                 -129 _spin_unlock_irqrestore+0x8 (up+0x30)
     #func                 -129 ipipe_check_context+0x9 (_spin_lock_irqsave+=
0x15)
     #func                 -129 _spin_lock_irqsave+0x9 (up+0x11)
     #func                 -129 up+0xa (release_console_sem+0x178)
     +func                 -130 ipipe_check_context+0x9 (_spin_lock_irqsave+=
0x15)
     +func                 -130 _spin_lock_irqsave+0x9 (release_console_sem+=
0x41)
     +func                 -130 release_console_sem+0xe (con_flush_chars+0x3=
4)
     +func                 -130 set_cursor+0x9 (con_flush_chars+0x2f)
 |   +end     0x80000000   -130 __ipipe_unstall_root+0x4d (__ipipe_restore_r=
oot+0x27)
 |   #begin   0x80000000   -130 __ipipe_unstall_root+0x2a (__ipipe_restore_r=
oot+0x27)
     #func                 -131 __ipipe_unstall_root+0x9 (__ipipe_restore_ro=
ot+0x27)
     #func                 -131 __ipipe_restore_root+0x8 (_spin_unlock_irqre=
store+0x1d)
     #func                 -131 _spin_unlock_irqrestore+0x8 (down+0x30)
     +func                 -131 ipipe_check_context+0x9 (_spin_lock_irqsave+=
0x15)
     +func                 -131 _spin_lock_irqsave+0x9 (down+0x11)
     +func                 -131 down+0xa (acquire_console_sem+0x3b)
     +func                 -132 acquire_console_sem+0x8 (con_flush_chars+0x2=
0)
     +func                 -132 con_flush_chars+0x9 (write_chan+0x20e)
     +func                 -132 unlock_kernel+0x8 (opost+0x199)
     +func                 -132 notifier_call_chain+0xe (__atomic_notifier_c=
all_chain+0x16)
     +func                 -132 __atomic_notifier_call_chain+0x8 (atomic_not=
ifier_call_chain+0x11)
     +func                 -132 atomic_notifier_call_chain+0x8 (notify_updat=
e+0x27)
     +func                 -133 notify_update+0xb (do_con_write+0x174d)
 |   +end     0x80000000   -133 __ipipe_unstall_root+0x4d (__ipipe_restore_r=
oot+0x27)
 |   #begin   0x80000000   -133 __ipipe_unstall_root+0x2a (__ipipe_restore_r=
oot+0x27)
     #func                 -133 __ipipe_unstall_root+0x9 (__ipipe_restore_ro=
ot+0x27)
     #func                 -133 __ipipe_restore_root+0x8 (_spin_unlock_irqre=
store+0x1d)
     #func                 -133 _spin_unlock_irqrestore+0x8 (release_console=
_sem+0x185)
     #func                 -133 __ipipe_restore_root+0x8 (_spin_unlock_irqre=
store+0x1d)
     #func                 -134 _spin_unlock_irqrestore+0x8 (up+0x30)
     #func                 -134 ipipe_check_context+0x9 (_spin_lock_irqsave+=
0x15)
     #func                 -134 _spin_lock_irqsave+0x9 (up+0x11)
     #func                 -134 up+0xa (release_console_sem+0x178)
     +func                 -134 ipipe_check_context+0x9 (_spin_lock_irqsave+=
0x15)
     +func                 -134 _spin_lock_irqsave+0x9 (release_console_sem+=
0x41)
     +func                 -135 release_console_sem+0xe (do_con_write+0x1746=
)
     +func                 -135 _cond_resched+0x8 (console_conditional_sched=
ule+0x16)
     +func                 -135 console_conditional_schedule+0x8 (do_con_wri=
te+0x1741)
     +func                 -135 notifier_call_chain+0xe (__atomic_notifier_c=
all_chain+0x16)
     +func                 -135 __atomic_notifier_call_chain+0x8 (atomic_not=
ifier_call_chain+0x11)
     +func                 -136 atomic_notifier_call_chain+0x8 (notify_write=
+0x23)
     +func                 -136 notify_write+0xb (lf+0x47)
     +func                 -154 memcpy+0xe (memmove+0x16)
     +func                 -154 memmove+0xb (scrup+0x96)
     +func                 -154 scrup+0xe (lf+0x20)
     +func                 -154 lf+0x9 (do_con_write+0x7fd)
     +func                 -154 notifier_call_chain+0xe (__atomic_notifier_c=
all_chain+0x16)
     +func                 -155 __atomic_notifier_call_chain+0x8 (atomic_not=
ifier_call_chain+0x11)
     +func                 -155 atomic_notifier_call_chain+0x8 (do_con_write=
+0x31e)
 |   +end     0x80000000   -155 __ipipe_unstall_root+0x4d (__ipipe_restore_r=
oot+0x27)
 |   #begin   0x80000000   -155 __ipipe_unstall_root+0x2a (__ipipe_restore_r=
oot+0x27)
     #func                 -155 __ipipe_unstall_root+0x9 (__ipipe_restore_ro=
ot+0x27)
     #func                 -155 __ipipe_restore_root+0x8 (_spin_unlock_irqre=
store+0x1d)
     #func                 -156 _spin_unlock_irqrestore+0x8 (down+0x30)
     +func                 -156 ipipe_check_context+0x9 (_spin_lock_irqsave+=
0x15)
     +func                 -156 _spin_lock_irqsave+0x9 (down+0x11)
     +func                 -156 down+0xa (acquire_console_sem+0x3b)
     +func                 -156 acquire_console_sem+0x8 (do_con_write+0x91)
 |   +end     0x80000000   -156 __ipipe_unstall_root+0x4d (__ipipe_restore_r=
oot+0x27)
 |   #begin   0x80000000   -156 __ipipe_unstall_root+0x2a (__ipipe_restore_r=
oot+0x27)
     #func                 -157 __ipipe_unstall_root+0x9 (__ipipe_restore_ro=
ot+0x27)
     #func                 -157 __ipipe_restore_root+0x8 (_spin_unlock_irqre=
store+0x1d)
     #func                 -157 _spin_unlock_irqrestore+0x8 (release_console=
_sem+0x185)
     #func                 -157 __ipipe_restore_root+0x8 (_spin_unlock_irqre=
store+0x1d)
     #func                 -157 _spin_unlock_irqrestore+0x8 (up+0x30)
     #func                 -158 ipipe_check_context+0x9 (_spin_lock_irqsave+=
0x15)
     #func                 -158 _spin_lock_irqsave+0x9 (up+0x11)
     #func                 -158 up+0xa (release_console_sem+0x178)
     +func                 -158 ipipe_check_context+0x9 (_spin_lock_irqsave+=
0x15)
     +func                 -158 _spin_lock_irqsave+0x9 (release_console_sem+=
0x41)
     +func                 -158 release_console_sem+0xe (do_con_write+0x8c)
 |   +end     0x80000000   -158 __ipipe_unstall_root+0x4d (__ipipe_restore_r=
oot+0x27)
 |   #begin   0x80000000   -159 __ipipe_unstall_root+0x2a (__ipipe_restore_r=
oot+0x27)
     #func                 -159 __ipipe_unstall_root+0x9 (__ipipe_restore_ro=
ot+0x27)
     #func                 -159 __ipipe_restore_root+0x8 (_spin_unlock_irqre=
store+0x1d)
     #func                 -159 _spin_unlock_irqrestore+0x8 (down+0x30)
     +func                 -159 ipipe_check_context+0x9 (_spin_lock_irqsave+=
0x15)
     +func                 -159 _spin_lock_irqsave+0x9 (down+0x11)
     +func                 -160 down+0xa (acquire_console_sem+0x3b)
     +func                 -160 acquire_console_sem+0x8 (do_con_write+0x42)
     +func                 -160 _cond_resched+0x8 (do_con_write+0x3d)
     +func                 -160 ipipe_check_context+0x9 (do_con_write+0x38)
     +func                 -160 do_con_write+0x11 (con_put_char+0x32)
     +func                 -160 con_put_char+0xc (tty_put_char+0x1e)
     +func                 -161 tty_put_char+0xc (opost+0x194)
     +func                 -161 notifier_call_chain+0xe (__atomic_notifier_c=
all_chain+0x16)
     +func                 -161 __atomic_notifier_call_chain+0x8 (atomic_not=
ifier_call_chain+0x11)
     +func                 -161 atomic_notifier_call_chain+0x8 (notify_updat=
e+0x27)
     +func                 -161 notify_update+0xb (do_con_write+0x174d)
 |   +end     0x80000000   -161 __ipipe_unstall_root+0x4d (__ipipe_restore_r=
oot+0x27)
 |   #begin   0x80000000   -161 __ipipe_unstall_root+0x2a (__ipipe_restore_r=
oot+0x27)
     #func                 -162 __ipipe_unstall_root+0x9 (__ipipe_restore_ro=
ot+0x27)
     #func                 -162 __ipipe_restore_root+0x8 (_spin_unlock_irqre=
store+0x1d)
     #func                 -162 _spin_unlock_irqrestore+0x8 (release_console=
_sem+0x185)
     #func                 -162 __ipipe_restore_root+0x8 (_spin_unlock_irqre=
store+0x1d)
     #func                 -162 _spin_unlock_irqrestore+0x8 (up+0x30)
     #func                 -162 ipipe_check_context+0x9 (_spin_lock_irqsave+=
0x15)
     #func                 -163 _spin_lock_irqsave+0x9 (up+0x11)
     #func                 -163 up+0xa (release_console_sem+0x178)
     +func                 -163 ipipe_check_context+0x9 (_spin_lock_irqsave+=
0x15)
     +func                 -163 _spin_lock_irqsave+0x9 (release_console_sem+=
0x41)
     +func                 -163 release_console_sem+0xe (do_con_write+0x1746=
)
     +func                 -163 _cond_resched+0x8 (console_conditional_sched=
ule+0x16)
     +func                 -164 console_conditional_schedule+0x8 (do_con_wri=
te+0x1741)
     +func                 -164 notifier_call_chain+0xe (__atomic_notifier_c=
all_chain+0x16)
     +func                 -164 __atomic_notifier_call_chain+0x8 (atomic_not=
ifier_call_chain+0x11)
     +func                 -164 atomic_notifier_call_chain+0x8 (notify_write=
+0x23)
     +func                 -164 notify_write+0xb (do_con_write+0x832)
     +func                 -164 notifier_call_chain+0xe (__atomic_notifier_c=
all_chain+0x16)
     +func                 -165 __atomic_notifier_call_chain+0x8 (atomic_not=
ifier_call_chain+0x11)
     +func                 -165 atomic_notifier_call_chain+0x8 (do_con_write=
+0x31e)
 |   +end     0x80000000   -165 __ipipe_unstall_root+0x4d (__ipipe_restore_r=
oot+0x27)
 |   #begin   0x80000000   -165 __ipipe_unstall_root+0x2a (__ipipe_restore_r=
oot+0x27)
     #func                 -165 __ipipe_unstall_root+0x9 (__ipipe_restore_ro=
ot+0x27)
     #func                 -165 __ipipe_restore_root+0x8 (_spin_unlock_irqre=
store+0x1d)
     #func                 -165 _spin_unlock_irqrestore+0x8 (down+0x30)
     +func                 -166 ipipe_check_context+0x9 (_spin_lock_irqsave+=
0x15)
     +func                 -166 _spin_lock_irqsave+0x9 (down+0x11)
     +func                 -166 down+0xa (acquire_console_sem+0x3b)
     +func                 -166 acquire_console_sem+0x8 (do_con_write+0x91)
 |   +end     0x80000000   -166 __ipipe_unstall_root+0x4d (__ipipe_restore_r=
oot+0x27)
 |   #begin   0x80000000   -166 __ipipe_unstall_root+0x2a (__ipipe_restore_r=
oot+0x27)
     #func                 -167 __ipipe_unstall_root+0x9 (__ipipe_restore_ro=
ot+0x27)
     #func                 -167 __ipipe_restore_root+0x8 (_spin_unlock_irqre=
store+0x1d)
     #func                 -167 _spin_unlock_irqrestore+0x8 (release_console=
_sem+0x185)
     #func                 -167 __ipipe_restore_root+0x8 (_spin_unlock_irqre=
store+0x1d)
     #func                 -167 _spin_unlock_irqrestore+0x8 (up+0x30)
     #func                 -167 ipipe_check_context+0x9 (_spin_lock_irqsave+=
0x15)
     #func                 -168 _spin_lock_irqsave+0x9 (up+0x11)
     #func                 -168 up+0xa (release_console_sem+0x178)
     +func                 -168 ipipe_check_context+0x9 (_spin_lock_irqsave+=
0x15)
     +func                 -168 _spin_lock_irqsave+0x9 (release_console_sem+=
0x41)
     +func                 -168 release_console_sem+0xe (do_con_write+0x8c)
 |   +end     0x80000000   -168 __ipipe_unstall_root+0x4d (__ipipe_restore_r=
oot+0x27)
 |   #begin   0x80000000   -169 __ipipe_unstall_root+0x2a (__ipipe_restore_r=
oot+0x27)
     #func                 -169 __ipipe_unstall_root+0x9 (__ipipe_restore_ro=
ot+0x27)
     #func                 -169 __ipipe_restore_root+0x8 (_spin_unlock_irqre=
store+0x1d)
     #func                 -169 _spin_unlock_irqrestore+0x8 (down+0x30)
     +func                 -169 ipipe_check_context+0x9 (_spin_lock_irqsave+=
0x15)
     +func                 -169 _spin_lock_irqsave+0x9 (down+0x11)
     +func                 -170 down+0xa (acquire_console_sem+0x3b)
     +func                 -170 acquire_console_sem+0x8 (do_con_write+0x42)
     +func                 -170 _cond_resched+0x8 (do_con_write+0x3d)
     +func                 -170 ipipe_check_context+0x9 (do_con_write+0x38)
     +func                 -170 do_con_write+0x11 (con_put_char+0x32)
     +func                 -170 con_put_char+0xc (tty_put_char+0x1e)
     +func                 -171 tty_put_char+0xc (opost+0x93)
     +func                 -171 lock_kernel+0x8 (opost+0x2c)
     +func                 -171 con_write_room+0x8 (tty_write_room+0x1d)
     +func                 -171 tty_write_room+0x8 (opost+0x1a)
     +func                 -171 opost+0xe (write_chan+0x1ee)
     +func                 -172 unlock_kernel+0x8 (write_chan+0x1cf)
 |   +end     0x80000000   -172 __ipipe_unstall_root+0x4d (__ipipe_restore_r=
oot+0x27)
 |   #begin   0x80000000   -172 __ipipe_unstall_root+0x2a (__ipipe_restore_r=
oot+0x27)
     #func                 -172 __ipipe_unstall_root+0x9 (__ipipe_restore_ro=
ot+0x27)
     #func                 -172 __ipipe_restore_root+0x8 (_spin_unlock_irqre=
store+0x1d)
     #func                 -172 _spin_unlock_irqrestore+0x8 (release_console=
_sem+0x185)
     #func                 -173 __ipipe_restore_root+0x8 (_spin_unlock_irqre=
store+0x1d)
     #func                 -173 _spin_unlock_irqrestore+0x8 (up+0x30)
     #func                 -173 ipipe_check_context+0x9 (_spin_lock_irqsave+=
0x15)
     #func                 -173 _spin_lock_irqsave+0x9 (up+0x11)
     #func                 -173 up+0xa (release_console_sem+0x178)
     +func                 -173 ipipe_check_context+0x9 (_spin_lock_irqsave+=
0x15)
     +func                 -174 _spin_lock_irqsave+0x9 (release_console_sem+=
0x41)
     +func                 -174 release_console_sem+0xe (con_flush_chars+0x3=
4)
     +func                 -174 set_cursor+0x9 (con_flush_chars+0x2f)
 |   +end     0x80000000   -174 __ipipe_unstall_root+0x4d (__ipipe_restore_r=
oot+0x27)
 |   #begin   0x80000000   -174 __ipipe_unstall_root+0x2a (__ipipe_restore_r=
oot+0x27)
     #func                 -174 __ipipe_unstall_root+0x9 (__ipipe_restore_ro=
ot+0x27)
     #func                 -174 __ipipe_restore_root+0x8 (_spin_unlock_irqre=
store+0x1d)
     #func                 -175 _spin_unlock_irqrestore+0x8 (down+0x30)
     +func                 -175 ipipe_check_context+0x9 (_spin_lock_irqsave+=
0x15)
     +func                 -175 _spin_lock_irqsave+0x9 (down+0x11)
     +func                 -175 down+0xa (acquire_console_sem+0x3b)
     +func                 -175 acquire_console_sem+0x8 (con_flush_chars+0x2=
0)
     +func                 -175 con_flush_chars+0x9 (con_write+0x1a)
     +func                 -176 notifier_call_chain+0xe (__atomic_notifier_c=
all_chain+0x16)
     +func                 -176 __atomic_notifier_call_chain+0x8 (atomic_not=
ifier_call_chain+0x11)
     +func                 -176 atomic_notifier_call_chain+0x8 (notify_updat=
e+0x27)
     +func                 -176 notify_update+0xb (do_con_write+0x174d)
 |   +end     0x80000000   -176 __ipipe_unstall_root+0x4d (__ipipe_restore_r=
oot+0x27)
 |   #begin   0x80000000   -176 __ipipe_unstall_root+0x2a (__ipipe_restore_r=
oot+0x27)
     #func                 -177 __ipipe_unstall_root+0x9 (__ipipe_restore_ro=
ot+0x27)
     #func                 -177 __ipipe_restore_root+0x8 (_spin_unlock_irqre=
store+0x1d)
     #func                 -177 _spin_unlock_irqrestore+0x8 (release_console=
_sem+0x185)
     #func                 -177 __ipipe_restore_root+0x8 (_spin_unlock_irqre=
store+0x1d)
     #func                 -177 _spin_unlock_irqrestore+0x8 (up+0x30)
     #func                 -177 ipipe_check_context+0x9 (_spin_lock_irqsave+=
0x15)
     #func                 -178 _spin_lock_irqsave+0x9 (up+0x11)
     #func                 -178 up+0xa (release_console_sem+0x178)
     +func                 -178 ipipe_check_context+0x9 (_spin_lock_irqsave+=
0x15)
     +func                 -178 _spin_lock_irqsave+0x9 (release_console_sem+=
0x41)
     +func                 -178 release_console_sem+0xe (do_con_write+0x1746=
)
     +func                 -178 _cond_resched+0x8 (console_conditional_sched=
ule+0x16)
     +func                 -178 console_conditional_schedule+0x8 (do_con_wri=
te+0x1741)
     +func                 -179 notifier_call_chain+0xe (__atomic_notifier_c=
all_chain+0x16)
     +func                 -179 __atomic_notifier_call_chain+0x8 (atomic_not=
ifier_call_chain+0x11)
     +func                 -179 atomic_notifier_call_chain+0x8 (notify_write=
+0x23)
     +func                 -179 notify_write+0xb (do_con_write+0x673)
     +func                 -179 conv_uni_to_pc+0x8 (do_con_write+0x42d)
     +func                 -180 notifier_call_chain+0xe (__atomic_notifier_c=
all_chain+0x16)
     +func                 -180 __atomic_notifier_call_chain+0x8 (atomic_not=
ifier_call_chain+0x11)
     +func                 -180 atomic_notifier_call_chain+0x8 (do_con_write=
+0x31e)
     +func                 -180 notifier_call_chain+0xe (__atomic_notifier_c=
all_chain+0x16)
     +func                 -180 __atomic_notifier_call_chain+0x8 (atomic_not=
ifier_call_chain+0x11)
     +func                 -180 atomic_notifier_call_chain+0x8 (notify_write=
+0x23)
     +func                 -180 notify_write+0xb (do_con_write+0x673)
     +func                 -181 conv_uni_to_pc+0x8 (do_con_write+0x42d)
     +func                 -181 notifier_call_chain+0xe (__atomic_notifier_c=
all_chain+0x16)
     +func                 -181 __atomic_notifier_call_chain+0x8 (atomic_not=
ifier_call_chain+0x11)
     +func                 -181 atomic_notifier_call_chain+0x8 (do_con_write=
+0x31e)
     +func                 -181 notifier_call_chain+0xe (__atomic_notifier_c=
all_chain+0x16)
     +func                 -181 __atomic_notifier_call_chain+0x8 (atomic_not=
ifier_call_chain+0x11)
     +func                 -181 atomic_notifier_call_chain+0x8 (notify_write=
+0x23)
     +func                 -182 notify_write+0xb (do_con_write+0x673)
     +func                 -182 conv_uni_to_pc+0x8 (do_con_write+0x42d)
     +func                 -182 notifier_call_chain+0xe (__atomic_notifier_c=
all_chain+0x16)
     +func                 -182 __atomic_notifier_call_chain+0x8 (atomic_not=
ifier_call_chain+0x11)
     +func                 -182 atomic_notifier_call_chain+0x8 (do_con_write=
+0x31e)
     +func                 -182 notifier_call_chain+0xe (__atomic_notifier_c=
all_chain+0x16)
     +func                 -182 __atomic_notifier_call_chain+0x8 (atomic_not=
ifier_call_chain+0x11)
     +func                 -183 atomic_notifier_call_chain+0x8 (notify_write=
+0x23)
     +func                 -183 notify_write+0xb (do_con_write+0x673)
     +func                 -183 conv_uni_to_pc+0x8 (do_con_write+0x42d)
     +func                 -183 notifier_call_chain+0xe (__atomic_notifier_c=
all_chain+0x16)
     +func                 -183 __atomic_notifier_call_chain+0x8 (atomic_not=
ifier_call_chain+0x11)
     +func                 -183 atomic_notifier_call_chain+0x8 (do_con_write=
+0x31e)
     +func                 -183 notifier_call_chain+0xe (__atomic_notifier_c=
all_chain+0x16)
     +func                 -184 __atomic_notifier_call_chain+0x8 (atomic_not=
ifier_call_chain+0x11)
     +func                 -184 atomic_notifier_call_chain+0x8 (notify_write=
+0x23)
     +func                 -184 notify_write+0xb (do_con_write+0x673)
     +func                 -184 conv_uni_to_pc+0x8 (do_con_write+0x42d)
     +func                 -184 notifier_call_chain+0xe (__atomic_notifier_c=
all_chain+0x16)
     +func                 -184 __atomic_notifier_call_chain+0x8 (atomic_not=
ifier_call_chain+0x11)
     +func                 -184 atomic_notifier_call_chain+0x8 (do_con_write=
+0x31e)
     +func                 -185 notifier_call_chain+0xe (__atomic_notifier_c=
all_chain+0x16)
     +func                 -185 __atomic_notifier_call_chain+0x8 (atomic_not=
ifier_call_chain+0x11)
     +func                 -185 atomic_notifier_call_chain+0x8 (notify_write=
+0x23)
     +func                 -185 notify_write+0xb (do_con_write+0x673)
     +func                 -185 conv_uni_to_pc+0x8 (do_con_write+0x42d)
     +func                 -185 notifier_call_chain+0xe (__atomic_notifier_c=
all_chain+0x16)
     +func                 -185 __atomic_notifier_call_chain+0x8 (atomic_not=
ifier_call_chain+0x11)
     +func                 -186 atomic_notifier_call_chain+0x8 (do_con_write=
+0x31e)
     +func                 -186 notifier_call_chain+0xe (__atomic_notifier_c=
all_chain+0x16)
     +func                 -186 __atomic_notifier_call_chain+0x8 (atomic_not=
ifier_call_chain+0x11)
     +func                 -186 atomic_notifier_call_chain+0x8 (notify_write=
+0x23)
     +func                 -186 notify_write+0xb (do_con_write+0x673)
     +func                 -186 conv_uni_to_pc+0x8 (do_con_write+0x42d)
     +func                 -187 notifier_call_chain+0xe (__atomic_notifier_c=
all_chain+0x16)
     +func                 -187 __atomic_notifier_call_chain+0x8 (atomic_not=
ifier_call_chain+0x11)
     +func                 -187 atomic_notifier_call_chain+0x8 (do_con_write=
+0x31e)
     +func                 -187 notifier_call_chain+0xe (__atomic_notifier_c=
all_chain+0x16)
     +func                 -187 __atomic_notifier_call_chain+0x8 (atomic_not=
ifier_call_chain+0x11)
     +func                 -187 atomic_notifier_call_chain+0x8 (notify_write=
+0x23)
     +func                 -187 notify_write+0xb (do_con_write+0x673)
     +func                 -187 conv_uni_to_pc+0x8 (do_con_write+0x42d)
     +func                 -188 notifier_call_chain+0xe (__atomic_notifier_c=
all_chain+0x16)
     +func                 -188 __atomic_notifier_call_chain+0x8 (atomic_not=
ifier_call_chain+0x11)
     +func                 -188 atomic_notifier_call_chain+0x8 (do_con_write=
+0x31e)
     +func                 -188 notifier_call_chain+0xe (__atomic_notifier_c=
all_chain+0x16)
     +func                 -188 __atomic_notifier_call_chain+0x8 (atomic_not=
ifier_call_chain+0x11)
     +func                 -188 atomic_notifier_call_chain+0x8 (notify_write=
+0x23)
     +func                 -188 notify_write+0xb (do_con_write+0x673)
     +func                 -189 conv_uni_to_pc+0x8 (do_con_write+0x42d)
     +func                 -189 notifier_call_chain+0xe (__atomic_notifier_c=
all_chain+0x16)
     +func                 -189 __atomic_notifier_call_chain+0x8 (atomic_not=
ifier_call_chain+0x11)
     +func                 -189 atomic_notifier_call_chain+0x8 (do_con_write=
+0x31e)
     +func                 -189 notifier_call_chain+0xe (__atomic_notifier_c=
all_chain+0x16)
     +func                 -189 __atomic_notifier_call_chain+0x8 (atomic_not=
ifier_call_chain+0x11)
     +func                 -190 atomic_notifier_call_chain+0x8 (notify_write=
+0x23)
     +func                 -190 notify_write+0xb (do_con_write+0x673)
     +func                 -190 conv_uni_to_pc+0x8 (do_con_write+0x42d)
     +func                 -190 notifier_call_chain+0xe (__atomic_notifier_c=
all_chain+0x16)
     +func                 -190 __atomic_notifier_call_chain+0x8 (atomic_not=
ifier_call_chain+0x11)
     +func                 -190 atomic_notifier_call_chain+0x8 (do_con_write=
+0x31e)
     +func                 -191 notifier_call_chain+0xe (__atomic_notifier_c=
all_chain+0x16)
     +func                 -191 __atomic_notifier_call_chain+0x8 (atomic_not=
ifier_call_chain+0x11)
     +func                 -191 atomic_notifier_call_chain+0x8 (notify_write=
+0x23)
     +func                 -191 notify_write+0xb (do_con_write+0x673)
     +func                 -194 conv_uni_to_pc+0x8 (do_con_write+0x42d)
     +func                 -194 notifier_call_chain+0xe (__atomic_notifier_c=
all_chain+0x16)
     +func                 -194 __atomic_notifier_call_chain+0x8 (atomic_not=
ifier_call_chain+0x11)
     +func                 -194 atomic_notifier_call_chain+0x8 (do_con_write=
+0x31e)
 |   +end     0x80000000   -195 __ipipe_unstall_root+0x4d (__ipipe_restore_r=
oot+0x27)
 |   #begin   0x80000000   -195 __ipipe_unstall_root+0x2a (__ipipe_restore_r=
oot+0x27)
     #func                 -195 __ipipe_unstall_root+0x9 (__ipipe_restore_ro=
ot+0x27)
     #func                 -196 __ipipe_restore_root+0x8 (_spin_unlock_irqre=
store+0x1d)
     #func                 -196 _spin_unlock_irqrestore+0x8 (down+0x30)
     +func                 -196 ipipe_check_context+0x9 (_spin_lock_irqsave+=
0x15)
     +func                 -196 _spin_lock_irqsave+0x9 (down+0x11)
     +func                 -196 down+0xa (acquire_console_sem+0x3b)
     +func                 -196 acquire_console_sem+0x8 (do_con_write+0x91)
 |   +end     0x80000000   -196 __ipipe_unstall_root+0x4d (__ipipe_restore_r=
oot+0x27)
 |   #begin   0x80000000   -197 __ipipe_unstall_root+0x2a (__ipipe_restore_r=
oot+0x27)
     #func                 -197 __ipipe_unstall_root+0x9 (__ipipe_restore_ro=
ot+0x27)
     #func                 -197 __ipipe_restore_root+0x8 (_spin_unlock_irqre=
store+0x1d)
     #func                 -197 _spin_unlock_irqrestore+0x8 (release_console=
_sem+0x185)
     #func                 -197 __ipipe_restore_root+0x8 (_spin_unlock_irqre=
store+0x1d)
     #func                 -197 _spin_unlock_irqrestore+0x8 (up+0x30)
     #func                 -198 ipipe_check_context+0x9 (_spin_lock_irqsave+=
0x15)
     #func                 -198 _spin_lock_irqsave+0x9 (up+0x11)
     #func                 -198 up+0xa (release_console_sem+0x178)
     +func                 -198 ipipe_check_context+0x9 (_spin_lock_irqsave+=
0x15)
     +func                 -198 _spin_lock_irqsave+0x9 (release_console_sem+=
0x41)
     +func                 -198 release_console_sem+0xe (do_con_write+0x8c)
 |   +end     0x80000000   -199 __ipipe_unstall_root+0x4d (__ipipe_restore_r=
oot+0x27)
 |   #begin   0x80000000   -199 __ipipe_unstall_root+0x2a (__ipipe_restore_r=
oot+0x27)
     #func                 -199 __ipipe_unstall_root+0x9 (__ipipe_restore_ro=
ot+0x27)
     #func                 -199 __ipipe_restore_root+0x8 (_spin_unlock_irqre=
store+0x1d)
     #func                 -200 _spin_unlock_irqrestore+0x8 (down+0x30)
     +func                 -200 ipipe_check_context+0x9 (_spin_lock_irqsave+=
0x15)
     +func                 -200 _spin_lock_irqsave+0x9 (down+0x11)
     +func                 -200 down+0xa (acquire_console_sem+0x3b)
     +func                 -200 acquire_console_sem+0x8 (do_con_write+0x42)
     +func                 -200 _cond_resched+0x8 (do_con_write+0x3d)
     +func                 -200 ipipe_check_context+0x9 (do_con_write+0x38)
     +func                 -201 do_con_write+0x11 (con_write+0x11)
     +func                 -201 con_write+0xa (write_chan+0x1c8)
 |   +end     0x80000000   -201 __ipipe_unstall_root+0x4d (__ipipe_restore_r=
oot+0x27)
 |   #begin   0x80000000   -202 __ipipe_unstall_root+0x2a (__ipipe_restore_r=
oot+0x27)
     #func                 -202 __ipipe_unstall_root+0x9 (__ipipe_restore_ro=
ot+0x27)
     #func                 -202 __ipipe_restore_root+0x8 (_spin_unlock_irqre=
store+0x1d)
     #func                 -202 _spin_unlock_irqrestore+0x8 (release_console=
_sem+0x185)
     #func                 -202 __ipipe_restore_root+0x8 (_spin_unlock_irqre=
store+0x1d)
     #func                 -202 _spin_unlock_irqrestore+0x8 (up+0x30)
     #func                 -203 ipipe_check_context+0x9 (_spin_lock_irqsave+=
0x15)
     #func                 -203 _spin_lock_irqsave+0x9 (up+0x11)
     #func                 -203 up+0xa (release_console_sem+0x178)
     +func                 -203 ipipe_check_context+0x9 (_spin_lock_irqsave+=
0x15)
     +func                 -204 _spin_lock_irqsave+0x9 (release_console_sem+=
0x41)
     +func                 -204 release_console_sem+0xe (con_flush_chars+0x3=
4)
     +func                 -205 set_cursor+0x9 (con_flush_chars+0x2f)
 |   +end     0x80000000   -205 __ipipe_unstall_root+0x4d (__ipipe_restore_r=
oot+0x27)
 |   #begin   0x80000000   -206 __ipipe_unstall_root+0x2a (__ipipe_restore_r=
oot+0x27)
     #func                 -206 __ipipe_unstall_root+0x9 (__ipipe_restore_ro=
ot+0x27)
     #func                 -206 __ipipe_restore_root+0x8 (_spin_unlock_irqre=
store+0x1d)
     #func                 -206 _spin_unlock_irqrestore+0x8 (down+0x30)
     +func                 -206 ipipe_check_context+0x9 (_spin_lock_irqsave+=
0x15)
     +func                 -207 _spin_lock_irqsave+0x9 (down+0x11)
     +func                 -207 down+0xa (acquire_console_sem+0x3b)
     +func                 -207 acquire_console_sem+0x8 (con_flush_chars+0x2=
0)
     +func                 -207 con_flush_chars+0x9 (write_chan+0x1bb)
     +func                 -208 lock_kernel+0x8 (write_chan+0xec)
     +func                 -208 con_write_room+0x8 (tty_write_room+0x1d)
     +func                 -209 tty_write_room+0x8 (write_chan+0xd6)
     +func                 -209 tty_hung_up_p+0x8 (write_chan+0x94)
 |   +end     0x80000000   -210 __ipipe_unstall_root+0x4d (__ipipe_restore_r=
oot+0x27)
 |   #begin   0x80000000   -210 __ipipe_unstall_root+0x2a (__ipipe_restore_r=
oot+0x27)
     #func                 -210 __ipipe_unstall_root+0x9 (__ipipe_restore_ro=
ot+0x27)
     #func                 -210 __ipipe_restore_root+0x8 (_spin_unlock_irqre=
store+0x1d)
     #func                 -210 _spin_unlock_irqrestore+0x8 (add_wait_queue+=
0x35)
     +func                 -211 ipipe_check_context+0x9 (_spin_lock_irqsave+=
0x15)
     +func                 -211 _spin_lock_irqsave+0x9 (add_wait_queue+0x1a)
     +func                 -211 add_wait_queue+0xb (write_chan+0x68)
     +func                 -212 write_chan+0xe (tty_write+0x14f)
     +func                 -213 __copy_from_user_ll+0xa (copy_from_user+0x40=
)
     +func                 -213 _cond_resched+0x8 (copy_from_user+0x35)
     +func                 -213 ipipe_check_context+0x9 (copy_from_user+0x30=
)
     +func                 -213 copy_from_user+0xb (tty_write+0x13c)
     +func                 -214 mutex_trylock+0x9 (tty_write_lock+0x19)
     +func                 -214 tty_write_lock+0xa (tty_write+0x9d)
 |   +end     0x80000000   -215 __ipipe_unstall_root+0x4d (__ipipe_restore_r=
oot+0x27)
 |   #begin   0x80000000   -215 __ipipe_unstall_root+0x2a (__ipipe_restore_r=
oot+0x27)
     #func                 -215 __ipipe_unstall_root+0x9 (__ipipe_restore_ro=
ot+0x27)
     #func                 -215 __ipipe_restore_root+0x8 (_spin_unlock_irqre=
store+0x1d)
     #func                 -216 _spin_unlock_irqrestore+0x8 (tty_ldisc_try+0=
x31)
     +func                 -216 ipipe_check_context+0x9 (_spin_lock_irqsave+=
0x15)
     +func                 -216 _spin_lock_irqsave+0x9 (tty_ldisc_try+0x18)
     +func                 -216 tty_ldisc_try+0xa (tty_ldisc_ref_wait+0x14)
     +func                 -217 tty_ldisc_ref_wait+0xd (tty_write+0x77)
     +func                 -218 tty_paranoia_check+0x9 (tty_write+0x2c)
     +func                 -219 tty_write+0xe (vfs_write+0x91)
     +func                 -219 rw_verify_area+0xe (vfs_write+0x6f)
     +func                 -220 vfs_write+0xe (sys_write+0x40)
     +func                 -221 fget_light+0xb (sys_write+0x1d)
     +func                 -221 sys_write+0xd (sysenter_do_call+0x12)
 |   +end     0x80000001   -222 __ipipe_dispatch_event+0x1da (__ipipe_syscal=
l_root+0x8d)
 |   +begin   0x80000001   -222 __ipipe_dispatch_event+0x108 (__ipipe_syscal=
l_root+0x8d)
     +func                 -222 losyscall_event+0xe (__ipipe_dispatch_event+=
0xe5)
 |   +end     0x80000001   -222 __ipipe_dispatch_event+0xd5 (__ipipe_syscall=
_root+0x8d)
 |  + begin   0x80000001   -223 __ipipe_dispatch_event+0x108 (__ipipe_syscal=
l_root+0x8d)
    + func                 -223 hisyscall_event+0xe (__ipipe_dispatch_event+=
0xe5)
 |  + end     0x80000001   -223 __ipipe_dispatch_event+0xd5 (__ipipe_syscall=
_root+0x8d)
 |   +begin   0x80000001   -223 __ipipe_dispatch_event+0x2c (__ipipe_syscall=
_root+0x8d)
     +func                 -223 __ipipe_dispatch_event+0xe (__ipipe_syscall_=
root+0x8d)
     +func                 -224 __ipipe_syscall_root+0xa (sysenter_past_esp+=
0x51)
 |   +end     0x8000000d   -232 __ipipe_unstall_iret_root+0x64 (restore_noch=
eck_notrace+0x0)
 |   #begin   0x80000000   -232 __ipipe_unstall_iret_root+0x2e (restore_noch=
eck_notrace+0x0)
     #func                 -232 __ipipe_unstall_iret_root+0xa (restore_noche=
ck_notrace+0x0)
 |   +end     0x80000001   -233 __ipipe_syscall_root+0x12d (system_call+0x29=
)
 |   +begin   0x80000001   -233 __ipipe_syscall_root+0xff (system_call+0x29)
 |   +end     0x80000001   -233 __ipipe_dispatch_event+0x1da (__ipipe_syscal=
l_root+0x8d)
 |  + begin   0x80000001   -233 __ipipe_dispatch_event+0x108 (__ipipe_syscal=
l_root+0x8d)
 |  + end     0x80000000   -234 __ipipe_restore_pipeline_head+0xb8 (rt_event=
_clear+0xde)
 |  # func                 -234 __ipipe_restore_pipeline_head+0xb (rt_event_=
clear+0xde)
 |  + begin   0x80000000   -234 rt_event_clear+0x23 (__rt_event_clear+0x64)
    + func                 -234 rt_event_clear+0xb (__rt_event_clear+0x64)
 |  + end     0x80000000   -234 __ipipe_restore_pipeline_head+0xb8 (xnregist=
ry_fetch+0x112)
 |  # func                 -235 __ipipe_restore_pipeline_head+0xb (xnregistr=
y_fetch+0x112)
 |  + begin   0x80000000   -235 xnregistry_fetch+0x1e (__rt_event_clear+0x4d=
)
    + func                 -235 xnregistry_fetch+0xa (__rt_event_clear+0x4d)
    + func                 -235 __rt_event_clear+0xe (hisyscall_event+0x136)
    + func                 -236 hisyscall_event+0xe (__ipipe_dispatch_event+=
0xe5)
 |  + end     0x80000001   -236 __ipipe_dispatch_event+0xd5 (__ipipe_syscall=
_root+0x8d)
 |   +begin   0x80000001   -236 __ipipe_dispatch_event+0x2c (__ipipe_syscall=
_root+0x8d)
     +func                 -236 __ipipe_dispatch_event+0xe (__ipipe_syscall_=
root+0x8d)
     +func                 -237 __ipipe_syscall_root+0xa (system_call+0x29)
 |   +end     0x8000000d   -238 __ipipe_unstall_iret_root+0x64 (restore_noch=
eck_notrace+0x0)
 |   #begin   0x80000000   -239 __ipipe_unstall_iret_root+0x2e (restore_noch=
eck_notrace+0x0)
     #func                 -239 __ipipe_unstall_iret_root+0xa (restore_noche=
ck_notrace+0x0)
 |   +end     0x80000001   -239 __ipipe_syscall_root+0x12d (system_call+0x29=
)
 |   +begin   0x80000001   -239 __ipipe_syscall_root+0xff (system_call+0x29)
 |   +end     0x80000001   -240 __ipipe_dispatch_event+0x1da (__ipipe_syscal=
l_root+0x8d)
 |   +begin   0x80000001   -240 __ipipe_dispatch_event+0x108 (__ipipe_syscal=
l_root+0x8d)
 |   +end     0x8000000d   -240 __ipipe_unstall_iret_root+0x64 (restore_noch=
eck_notrace+0x0)
 |   +begin   0x80000000   -241 __ipipe_unstall_iret_root+0x2e (restore_noch=
eck_notrace+0x0)
     +func                 -241 __ipipe_unstall_iret_root+0xa (restore_noche=
ck_notrace+0x0)
 |   +end     0x80000000   -241 __ipipe_unstall_root+0x4d (__ipipe_restore_r=
oot+0x27)
 |   +func                 -241 __ipipe_unstall_root+0x9 (__ipipe_restore_ro=
ot+0x27)
 |   +func                 -241 __ipipe_restore_root+0x8 (__ipipe_handle_exc=
eption+0x197)
 |   +begin   0x80000000   -242 __ipipe_handle_exception+0x180 (error_code+0=
x77)
     +func                 -243 search_extable+0x9 (search_exception_tables+=
0x1c)
     +func                 -243 search_exception_tables+0x9 (fixup_exception=
+0x13)
     +func                 -244 fixup_exception+0x9 (do_page_fault+0x419)
     +func                 -244 up_read+0x8 (do_page_fault+0x33d)
     +func                 -247 find_vma+0xa (do_page_fault+0x251)
     +func                 -247 down_read_trylock+0x9 (do_page_fault+0x222)
 |   +end     0x80000000   -247 __ipipe_unstall_root+0x4d (do_page_fault+0x1=
fc)
 |   +begin   0x80000000   -247 __ipipe_unstall_root+0x2a (do_page_fault+0x1=
fc)
     +func                 -248 __ipipe_unstall_root+0x9 (do_page_fault+0x1f=
c)
     +func                 -248 do_page_fault+0xe (__ipipe_handle_exception+=
0x16e)
 |   +end     0x80000001   -249 __ipipe_dispatch_event+0x1da (__ipipe_handle=
_exception+0xd0)
 |   +begin   0x80000001   -249 __ipipe_dispatch_event+0x108 (__ipipe_handle=
_exception+0xd0)
     +func                 -250 post_schedule_rt+0x9 (finish_task_switch+0x4=
2)
 |   +end     0x80000000   -250 __ipipe_unstall_root+0x4d (finish_task_switc=
h+0x2e)
 |   #begin   0x80000000   -250 __ipipe_unstall_root+0x2a (finish_task_switc=
h+0x2e)
     #func                 -251 __ipipe_unstall_root+0x9 (finish_task_switch=
+0x2e)
     #func                 -251 finish_task_switch+0xe (ipipe_reenter_root+0=
x26)
     #func                 -251 ipipe_reenter_root+0xb (xnshadow_relax+0xe3)
 |   #end     0x80000000   -252 __ipipe_restore_pipeline_head+0xb8 (xnshadow=
_relax+0xb3)
 |  *#func                 -252 __ipipe_restore_pipeline_head+0xb (xnshadow_=
relax+0xb3)
 |   #[ 5202] emerge  90   -252 xnpod_schedule+0xc7a (xnpod_suspend_thread+0=
x1e2)
 |   #func                 -253 __switch_to+0xe (xnpod_schedule+0xb77)
 |   #begin   0x80000000   -254 schedule+0x3c1 (__cond_resched+0x2f)
 |   #end     0x80000001   -254 __ipipe_dispatch_event+0x1da (schedule+0x3af=
)
 |   #begin   0x80000001   -254 __ipipe_dispatch_event+0x108 (schedule+0x3af=
)
 |   #end     0x80000000   -255 __ipipe_restore_pipeline_head+0xb8 (schedule=
_event+0x569)
 |  *#func                 -255 __ipipe_restore_pipeline_head+0xb (schedule_=
event+0x569)
 |  *#[ 5202] emerge  90   -255 xnpod_schedule_runnable+0x4a (schedule_event=
+0x521)
 |  *#func                 -255 xnpod_schedule_runnable+0x11 (schedule_event=
+0x521)
 |   #begin   0x80000000   -256 schedule_event+0x4b4 (__ipipe_dispatch_event=
+0xe5)
     #func                 -257 schedule_event+0xe (__ipipe_dispatch_event+0=
xe5)
 |   #end     0x80000001   -257 __ipipe_dispatch_event+0xd5 (schedule+0x3af)
 |   #begin   0x80000001   -258 __ipipe_dispatch_event+0x2c (schedule+0x3af)
     #func                 -258 __ipipe_dispatch_event+0xe (schedule+0x3af)
     #func                 -259 pick_next_task_rt+0x9 (schedule+0x340)
     #func                 -259 rb_insert_color+0xe (__enqueue_entity+0xe8)
     #func                 -260 __enqueue_entity+0xe (put_prev_task_fair+0x4=
2)
     #func                 -260 calc_delta_mine+0xe (update_curr+0x48)
     #func                 -260 update_curr+0xb (put_prev_task_fair+0x33)
     #func                 -261 put_prev_task_fair+0xa (schedule+0x31d)
     #func                 -261 _spin_lock+0x8 (schedule+0xe4)
     #func                 -261 __update_sched_clock+0xe (sched_clock_cpu+0x=
163)
     #func                 -262 __ipipe_restore_root+0x8 (native_sched_clock=
+0xbc)
     #func                 -262 ipipe_check_context+0x9 (native_sched_clock+=
0x54)
     #func                 -262 native_read_tsc+0x8 (native_sched_clock+0x46=
)
     #func                 -262 native_sched_clock+0xe (sched_clock_cpu+0x7d=
)
     #func                 -262 sched_clock_cpu+0xe (schedule+0xce)
     +func                 -263 ipipe_check_context+0x9 (schedule+0xac)
     +func                 -263 ipipe_check_context+0x9 (schedule+0x64)
     +func                 -263 schedule+0xe (__cond_resched+0x2f)
     +func                 -264 ipipe_check_context+0x9 (__cond_resched+0x1c=
)
     +func                 -264 ipipe_check_context+0x9 (__cond_resched+0x12=
)
     +func                 -264 __cond_resched+0x8 (_cond_resched+0x29)
     +func                 -264 _cond_resched+0x8 (__alloc_pages_internal+0x=
9b)
     +func                 -264 ipipe_check_context+0x9 (__alloc_pages_inter=
nal+0x96)
     +func                 -265 __alloc_pages_internal+0xe (__slab_alloc+0x1=
1e)
 |   +end     0x80000000   -265 __ipipe_unstall_root+0x4d (__slab_alloc+0xe6=
)
 |   +end     0x8000000d   -265 __ipipe_unstall_iret_root+0x64 (restore_noch=
eck_notrace+0x0)
 |   #begin   0x80000000   -266 __ipipe_unstall_iret_root+0x2e (restore_noch=
eck_notrace+0x0)
     #func                 -266 __ipipe_unstall_iret_root+0xa (restore_noche=
ck_notrace+0x0)
     #func                 -266 idle_cpu+0x8 (irq_exit+0x62)
     #func                 -267 ipipe_check_context+0x9 (irq_exit+0x12)
     #func                 -267 irq_exit+0x8 (__xirq_end+0x40)
 |   #end     0x80000001   -267 ipipe_trigger_irq+0x7b (xnpod_schedule+0x34)
 |   #func                 -268 __ipipe_walk_pipeline+0xe (__ipipe_dispatch_=
wired_nocheck+0x8a)
 |  #*[ 5202] emerge  -1   -268 xnpod_schedule+0xc7a (xnpod_schedule_handler=
+0x5b)
 |  #*func                 -269 __switch_to+0xe (xnpod_schedule+0xb77)
 |  #*[ 5196] TimerTa 80   -270 xnpod_schedule+0xeb (xnpod_suspend_thread+0x=
1e2)
 |  #*func                 -270 xnpod_schedule+0x11 (xnpod_suspend_thread+0x=
1e2)
 |  #*func                 -271 xnpod_suspend_thread+0xe (xnpod_wait_thread_=
period+0xc4)
 |  +*begin   0x80000000   -271 xnpod_wait_thread_period+0x35 (rt_task_wait_=
period+0x45)
    +*func                 -271 xnpod_wait_thread_period+0xe (rt_task_wait_p=
eriod+0x45)
    +*func                 -271 rt_task_wait_period+0x8 (__rt_task_wait_peri=
od+0x34)
    +*func                 -272 __rt_task_wait_period+0xd (hisyscall_event+0=
x136)
    +*func                 -272 hisyscall_event+0xe (__ipipe_dispatch_event+=
0xe5)
 |  +*end     0x80000001   -272 __ipipe_dispatch_event+0xd5 (__ipipe_syscall=
_root+0x8d)
 |  +*begin   0x80000001   -273 __ipipe_dispatch_event+0x2c (__ipipe_syscall=
_root+0x8d)
    +*func                 -273 __ipipe_dispatch_event+0xe (__ipipe_syscall_=
root+0x8d)
    +*func                 -273 __ipipe_syscall_root+0xa (system_call+0x29)
 |  +*end     0x80000001   -275 __ipipe_dispatch_event+0x1da (__ipipe_syscal=
l_root+0x8d)
 |  +*begin   0x80000001   -275 __ipipe_dispatch_event+0x108 (__ipipe_syscal=
l_root+0x8d)
 |  +*end     0x80000000   -275 __ipipe_restore_pipeline_head+0xb8 (rt_event=
_signal+0x15e)
 |  #*func                 -275 __ipipe_restore_pipeline_head+0xb (rt_event_=
signal+0x15e)
 |  #*[ 5196] TimerTa 80   -276 xnpod_schedule+0xc7a (rt_event_signal+0x10c)
 |  #*func                 -277 __switch_to+0xe (xnpod_schedule+0xb77)
 |  #*[ 5202] emerge  -1   -278 xnpod_schedule+0xeb (xnpod_schedule_handler+=
0x5b)
 |  #*func                 -278 xnpod_schedule+0x11 (xnpod_schedule_handler+=
0x5b)
 |  #*func                 -279 xnpod_schedule_handler+0x9 (__ipipe_dispatch=
_wired_nocheck+0x58)
 |   #func                 -279 __ipipe_dispatch_wired_nocheck+0xe (__ipipe_=
dispatch_wired+0x66)
 |   #func                 -279 __ipipe_dispatch_wired+0x9 (__ipipe_handle_i=
rq+0xad)
 |   #func                 -280 __ipipe_handle_irq+0xe (ipipe_trigger_irq+0x=
6e)
 |   #func                 -280 memcpy+0xe (ipipe_trigger_irq+0x69)
 |   #begin   0x80000001   -280 ipipe_trigger_irq+0x4b (xnpod_schedule+0x34)
     #func                 -280 ipipe_trigger_irq+0xe (xnpod_schedule+0x34)
     #func                 -280 xnpod_schedule+0x11 (lostage_handler+0x17a)
     #func                 -281 __ipipe_restore_root+0x8 (_spin_unlock_irqre=
store+0x1d)
     #func                 -281 _spin_unlock_irqrestore+0x8 (try_to_wake_up+=
0x12a)
     #func                 -281 task_wake_up_rt+0x8 (try_to_wake_up+0x10a)
     #func                 -281 resched_task+0x9 (check_preempt_wakeup+0x116=
)
     #func                 -282 calc_delta_mine+0xe (update_curr+0x48)
     #func                 -282 update_curr+0xb (check_preempt_wakeup+0x51)
     #func                 -282 __update_sched_clock+0xe (sched_clock_cpu+0x=
163)
     #func                 -283 __ipipe_restore_root+0x8 (native_sched_clock=
+0xbc)
     #func                 -283 ipipe_check_context+0x9 (native_sched_clock+=
0x54)
     #func                 -283 native_read_tsc+0x8 (native_sched_clock+0x46=
)
     #func                 -283 native_sched_clock+0xe (sched_clock_cpu+0x7d=
)
     #func                 -283 sched_clock_cpu+0xe (check_preempt_wakeup+0x=
3c)
     #func                 -283 check_preempt_wakeup+0xe (try_to_wake_up+0xf=
4)
     #func                 -284 update_rt_migration+0x8 (__enqueue_rt_entity=
+0xb2)
     #func                 -285 __ipipe_restore_root+0x8 (_spin_unlock_irqre=
store+0x1d)
     #func                 -285 _spin_unlock_irqrestore+0x8 (cpupri_set+0xad=
)
     #func                 -285 ipipe_check_context+0x9 (_spin_lock_irqsave+=
0x15)
     #func                 -285 _spin_lock_irqsave+0x9 (cpupri_set+0x8a)
     #func                 -286 __ipipe_restore_root+0x8 (_spin_unlock_irqre=
store+0x1d)
     #func                 -286 _spin_unlock_irqrestore+0x8 (cpupri_set+0x78=
)
     #func                 -286 ipipe_check_context+0x9 (_spin_lock_irqsave+=
0x15)
     #func                 -286 _spin_lock_irqsave+0x9 (cpupri_set+0x51)
     #func                 -287 convert_prio+0x8 (cpupri_set+0x2d)
     #func                 -287 cpupri_set+0xe (__enqueue_rt_entity+0x9b)
     #func                 -288 __enqueue_rt_entity+0xe (enqueue_task_rt+0x3=
8)
     #func                 -289 dequeue_rt_stack+0xe (enqueue_task_rt+0x24)
     #func                 -289 enqueue_task_rt+0xb (enqueue_task+0x12)
     #func                 -289 enqueue_task+0xa (activate_task+0x1e)
     #func                 -290 activate_task+0x9 (try_to_wake_up+0xe0)
     #func                 -290 __update_sched_clock+0xe (sched_clock_cpu+0x=
163)
     #func                 -291 __ipipe_restore_root+0x8 (native_sched_clock=
+0xbc)
     #func                 -292 ipipe_check_context+0x9 (native_sched_clock+=
0x54)
     #func                 -292 native_read_tsc+0x8 (native_sched_clock+0x46=
)
     #func                 -292 native_sched_clock+0xe (sched_clock_cpu+0x7d=
)
     #func                 -293 sched_clock_cpu+0xe (try_to_wake_up+0xc6)
     #func                 -293 select_task_rq_rt+0x9 (try_to_wake_up+0x86)
     #func                 -294 _spin_lock+0x8 (task_rq_lock+0x5d)
     #func                 -294 ipipe_check_context+0x9 (task_rq_lock+0x1d)
     #func                 -294 task_rq_lock+0xe (try_to_wake_up+0x51)
     #func                 -294 try_to_wake_up+0xe (wake_up_process+0x14)
     #func                 -295 wake_up_process+0x8 (lostage_handler+0x160)
 |   #end     0x80000000   -295 __ipipe_restore_pipeline_head+0xb8 (lostage_=
handler+0x159)
 |  *#func                 -295 __ipipe_restore_pipeline_head+0xb (lostage_h=
andler+0x159)
 |  *#[ 5202] emerge  -1   -295 xnpod_schedule_runnable+0x4a (lostage_handle=
r+0x111)
 |  *#func                 -296 xnpod_schedule_runnable+0x11 (lostage_handle=
r+0x111)
 |   #begin   0x80000000   -296 lostage_handler+0xa3 (rthal_apc_handler+0x5f=
)
     #func                 -297 lostage_handler+0xe (rthal_apc_handler+0x5f)
     #func                 -297 rthal_apc_handler+0xa (__xirq_end+0x38)
     #func                 -298 idle_cpu+0x8 (irq_enter+0x51)
     #func                 -298 ipipe_check_context+0x9 (irq_enter+0x3c)
     #func                 -298 idle_cpu+0x8 (irq_enter+0x17)
     #func                 -298 irq_enter+0x9 (__xirq_end+0x1c)
 |   #end     0x80000000   -299 __ipipe_sync_stage+0xb6 (__ipipe_unstall_roo=
t+0x3c)
 |   +func                 -299 __ipipe_sync_stage+0xe (__ipipe_unstall_root=
+0x3c)
 |   #begin   0x80000000   -299 __ipipe_unstall_root+0x2a (__slab_alloc+0xe6=
)
     #func                 -300 __ipipe_unstall_root+0x9 (__slab_alloc+0xe6)
     #func                 -300 deactivate_slab+0xb (__slab_alloc+0x81)
     #func                 -301 __slab_alloc+0xe (kmem_cache_alloc+0x73)
     #func                 -301 ipipe_check_context+0x9 (kmem_cache_alloc+0x=
24)
     #func                 -301 kmem_cache_alloc+0xe (d_alloc+0x23)
     #func                 -302 d_alloc+0xe (do_lookup+0x99)
     #func                 -302 __d_lookup+0xe (d_lookup+0x27)
     #func                 -302 d_lookup+0xb (do_lookup+0x7b)
     #func                 -302 _cond_resched+0x8 (mutex_lock+0x1d)
     #func                 -302 ipipe_check_context+0x9 (mutex_lock+0x18)
     #func                 -302 mutex_lock+0xc (do_lookup+0x71)
     #func                 -303 __d_lookup+0xe (do_lookup+0x2a)
     #func                 -303 do_lookup+0xe (__link_path_walk+0x6af)
     #func                 -303 generic_permission+0xb (ext3_permission+0x12=
)
     #func                 -303 ext3_permission+0x8 (inode_permission+0x5f)
     #func                 -303 inode_permission+0xa (vfs_permission+0x13)
     #func                 -303 vfs_permission+0x8 (__link_path_walk+0x117)
     #func                 -304 _atomic_dec_and_lock+0xa (dput+0x33)
     #func                 -304 dput+0x9 (__link_path_walk+0x51a)
     #func                 -304 __follow_mount+0xb (do_lookup+0x54)
     #func                 -304 memcmp+0xa (__d_lookup+0xa6)
     #func                 -304 _spin_lock+0x8 (__d_lookup+0x67)
     #func                 -304 __d_lookup+0xe (do_lookup+0x2a)
     #func                 -305 do_lookup+0xe (__link_path_walk+0x2b9)
     #func                 -305 generic_permission+0xb (ext3_permission+0x12=
)
     #func                 -305 ext3_permission+0x8 (inode_permission+0x5f)
     #func                 -305 inode_permission+0xa (vfs_permission+0x13)
     #func                 -305 vfs_permission+0x8 (__link_path_walk+0x117)
     #func                 -305 _atomic_dec_and_lock+0xa (dput+0x33)
     #func                 -306 dput+0x9 (__link_path_walk+0x51a)
     #func                 -306 __follow_mount+0xb (do_lookup+0x54)
---[ end trace 1ddaac15a27fa568 ]---

--=_2cgrwpf9e5no
Content-Type: text/plain;
	charset=ISO-8859-2;
	name="config_2.6.26"
Content-Disposition: attachment;
	filename="config_2.6.26"
Content-Transfer-Encoding: quoted-printable

#
# Automatically generated make config: don't edit
# Linux kernel version: 2.6.26.8
# Thu Feb 19 17:47:19 2009
#
# CONFIG_64BIT is not set
CONFIG_X86_32=3Dy
# CONFIG_X86_64 is not set
CONFIG_X86=3Dy
CONFIG_ARCH_DEFCONFIG=3D"arch/x86/configs/i386_defconfig"
# CONFIG_GENERIC_LOCKBREAK is not set
CONFIG_GENERIC_TIME=3Dy
CONFIG_GENERIC_CMOS_UPDATE=3Dy
CONFIG_CLOCKSOURCE_WATCHDOG=3Dy
CONFIG_GENERIC_CLOCKEVENTS=3Dy
CONFIG_GENERIC_CLOCKEVENTS_BROADCAST=3Dy
CONFIG_LOCKDEP_SUPPORT=3Dy
CONFIG_STACKTRACE_SUPPORT=3Dy
CONFIG_HAVE_LATENCYTOP_SUPPORT=3Dy
CONFIG_FAST_CMPXCHG_LOCAL=3Dy
CONFIG_MMU=3Dy
CONFIG_ZONE_DMA=3Dy
CONFIG_GENERIC_ISA_DMA=3Dy
CONFIG_GENERIC_IOMAP=3Dy
CONFIG_GENERIC_BUG=3Dy
CONFIG_GENERIC_HWEIGHT=3Dy
# CONFIG_GENERIC_GPIO is not set
CONFIG_ARCH_MAY_HAVE_PC_FDC=3Dy
# CONFIG_RWSEM_GENERIC_SPINLOCK is not set
CONFIG_RWSEM_XCHGADD_ALGORITHM=3Dy
# CONFIG_ARCH_HAS_ILOG2_U32 is not set
# CONFIG_ARCH_HAS_ILOG2_U64 is not set
CONFIG_ARCH_HAS_CPU_IDLE_WAIT=3Dy
CONFIG_GENERIC_CALIBRATE_DELAY=3Dy
# CONFIG_GENERIC_TIME_VSYSCALL is not set
CONFIG_ARCH_HAS_CPU_RELAX=3Dy
CONFIG_ARCH_HAS_CACHE_LINE_SIZE=3Dy
CONFIG_HAVE_SETUP_PER_CPU_AREA=3Dy
# CONFIG_HAVE_CPUMASK_OF_CPU_MAP is not set
CONFIG_ARCH_HIBERNATION_POSSIBLE=3Dy
CONFIG_ARCH_SUSPEND_POSSIBLE=3Dy
# CONFIG_ZONE_DMA32 is not set
CONFIG_ARCH_POPULATES_NODE_MAP=3Dy
# CONFIG_AUDIT_ARCH is not set
CONFIG_ARCH_SUPPORTS_AOUT=3Dy
CONFIG_ARCH_SUPPORTS_OPTIMIZED_INLINING=3Dy
CONFIG_GENERIC_HARDIRQS=3Dy
CONFIG_GENERIC_IRQ_PROBE=3Dy
CONFIG_GENERIC_PENDING_IRQ=3Dy
CONFIG_X86_SMP=3Dy
CONFIG_X86_32_SMP=3Dy
CONFIG_X86_HT=3Dy
CONFIG_X86_BIOS_REBOOT=3Dy
CONFIG_X86_TRAMPOLINE=3Dy
CONFIG_KTIME_SCALAR=3Dy
CONFIG_DEFCONFIG_LIST=3D"/lib/modules/$UNAME_RELEASE/.config"

#
# General setup
#
CONFIG_EXPERIMENTAL=3Dy
CONFIG_LOCK_KERNEL=3Dy
CONFIG_INIT_ENV_ARG_LIMIT=3D32
CONFIG_LOCALVERSION=3D""
CONFIG_LOCALVERSION_AUTO=3Dy
CONFIG_SWAP=3Dy
CONFIG_SYSVIPC=3Dy
CONFIG_SYSVIPC_SYSCTL=3Dy
CONFIG_POSIX_MQUEUE=3Dy
# CONFIG_BSD_PROCESS_ACCT is not set
# CONFIG_TASKSTATS is not set
# CONFIG_AUDIT is not set
CONFIG_IKCONFIG=3Dy
CONFIG_IKCONFIG_PROC=3Dy
CONFIG_LOG_BUF_SHIFT=3D19
# CONFIG_CGROUPS is not set
CONFIG_HAVE_UNSTABLE_SCHED_CLOCK=3Dy
# CONFIG_GROUP_SCHED is not set
CONFIG_SYSFS_DEPRECATED=3Dy
CONFIG_SYSFS_DEPRECATED_V2=3Dy
CONFIG_RELAY=3Dy
CONFIG_NAMESPACES=3Dy
# CONFIG_UTS_NS is not set
# CONFIG_IPC_NS is not set
# CONFIG_USER_NS is not set
# CONFIG_PID_NS is not set
CONFIG_BLK_DEV_INITRD=3Dy
CONFIG_INITRAMFS_SOURCE=3D""
CONFIG_CC_OPTIMIZE_FOR_SIZE=3Dy
CONFIG_SYSCTL=3Dy
# CONFIG_EMBEDDED is not set
CONFIG_UID16=3Dy
CONFIG_SYSCTL_SYSCALL=3Dy
CONFIG_SYSCTL_SYSCALL_CHECK=3Dy
CONFIG_KALLSYMS=3Dy
CONFIG_KALLSYMS_ALL=3Dy
# CONFIG_KALLSYMS_EXTRA_PASS is not set
CONFIG_HOTPLUG=3Dy
CONFIG_PRINTK=3Dy
CONFIG_BUG=3Dy
CONFIG_ELF_CORE=3Dy
CONFIG_PCSPKR_PLATFORM=3Dy
CONFIG_COMPAT_BRK=3Dy
CONFIG_BASE_FULL=3Dy
CONFIG_FUTEX=3Dy
CONFIG_ANON_INODES=3Dy
CONFIG_EPOLL=3Dy
CONFIG_SIGNALFD=3Dy
CONFIG_TIMERFD=3Dy
CONFIG_EVENTFD=3Dy
CONFIG_SHMEM=3Dy
CONFIG_VM_EVENT_COUNTERS=3Dy
CONFIG_SLUB_DEBUG=3Dy
# CONFIG_SLAB is not set
CONFIG_SLUB=3Dy
# CONFIG_SLOB is not set
CONFIG_PROFILING=3Dy
# CONFIG_MARKERS is not set
CONFIG_OPROFILE=3Dy
CONFIG_HAVE_OPROFILE=3Dy
CONFIG_KPROBES=3Dy
CONFIG_KRETPROBES=3Dy
CONFIG_HAVE_KPROBES=3Dy
CONFIG_HAVE_KRETPROBES=3Dy
# CONFIG_HAVE_DMA_ATTRS is not set
CONFIG_PROC_PAGE_MONITOR=3Dy
CONFIG_SLABINFO=3Dy
CONFIG_RT_MUTEXES=3Dy
# CONFIG_TINY_SHMEM is not set
CONFIG_BASE_SMALL=3D0
CONFIG_MODULES=3Dy
# CONFIG_MODULE_FORCE_LOAD is not set
CONFIG_MODULE_UNLOAD=3Dy
CONFIG_MODULE_FORCE_UNLOAD=3Dy
# CONFIG_MODVERSIONS is not set
# CONFIG_MODULE_SRCVERSION_ALL is not set
CONFIG_KMOD=3Dy
CONFIG_STOP_MACHINE=3Dy
CONFIG_BLOCK=3Dy
CONFIG_LBD=3Dy
# CONFIG_BLK_DEV_IO_TRACE is not set
# CONFIG_LSF is not set
# CONFIG_BLK_DEV_BSG is not set

#
# IO Schedulers
#
CONFIG_IOSCHED_NOOP=3Dy
CONFIG_IOSCHED_AS=3Dy
CONFIG_IOSCHED_DEADLINE=3Dy
CONFIG_IOSCHED_CFQ=3Dy
# CONFIG_DEFAULT_AS is not set
# CONFIG_DEFAULT_DEADLINE is not set
CONFIG_DEFAULT_CFQ=3Dy
# CONFIG_DEFAULT_NOOP is not set
CONFIG_DEFAULT_IOSCHED=3D"cfq"
CONFIG_CLASSIC_RCU=3Dy

#
# Real-time sub-system
#
CONFIG_XENOMAI=3Dy
CONFIG_XENO_GENERIC_STACKPOOL=3Dy
CONFIG_XENO_OPT_NUCLEUS=3Dy
CONFIG_XENO_OPT_PERVASIVE=3Dy
# CONFIG_XENO_OPT_ISHIELD is not set
CONFIG_XENO_OPT_PRIOCPL=3Dy
CONFIG_XENO_OPT_PIPELINE_HEAD=3Dy
CONFIG_XENO_OPT_PIPE=3Dy
CONFIG_XENO_OPT_PIPE_NRDEV=3D32
CONFIG_XENO_OPT_REGISTRY=3Dy
CONFIG_XENO_OPT_REGISTRY_NRSLOTS=3D512
CONFIG_XENO_OPT_SYS_HEAPSZ=3D128
CONFIG_XENO_OPT_SYS_STACKPOOLSZ=3D32
CONFIG_XENO_OPT_STATS=3Dy
CONFIG_XENO_OPT_DEBUG=3Dy
# CONFIG_XENO_OPT_DEBUG_NUCLEUS is not set
# CONFIG_XENO_OPT_DEBUG_QUEUES is not set
# CONFIG_XENO_OPT_DEBUG_REGISTRY is not set
# CONFIG_XENO_OPT_DEBUG_TIMERS is not set
CONFIG_XENO_OPT_WATCHDOG=3Dy
CONFIG_XENO_OPT_WATCHDOG_TIMEOUT=3D4
# CONFIG_XENO_OPT_SHIRQ is not set

#
# Timing
#
# CONFIG_XENO_OPT_TIMING_PERIODIC is not set
CONFIG_XENO_OPT_TIMING_SCHEDLAT=3D0

#
# Scalability
#
CONFIG_XENO_OPT_SCALABLE_SCHED=3Dy
CONFIG_XENO_OPT_TIMER_LIST=3Dy
# CONFIG_XENO_OPT_TIMER_HEAP is not set
# CONFIG_XENO_OPT_TIMER_WHEEL is not set

#
# Machine
#
CONFIG_XENO_HW_FPU=3Dy

#
# NMI watchdog
#
# CONFIG_XENO_HW_NMI_DEBUG_LATENCY is not set

#
# SMI workaround
#
# CONFIG_XENO_HW_SMI_DETECT_DISABLE is not set
CONFIG_XENO_HW_SMI_DETECT=3Dy
CONFIG_XENO_HW_SMI_WORKAROUND=3Dy
CONFIG_XENO_HW_SMI_ALL=3Dy

#
# Interfaces
#
CONFIG_XENO_SKIN_NATIVE=3Dy
CONFIG_XENO_OPT_NATIVE_PERIOD=3D0
CONFIG_XENO_OPT_NATIVE_PIPE=3Dy
CONFIG_XENO_OPT_NATIVE_PIPE_BUFSZ=3D1024
CONFIG_XENO_OPT_NATIVE_REGISTRY=3Dy
CONFIG_XENO_OPT_NATIVE_SEM=3Dy
CONFIG_XENO_OPT_NATIVE_EVENT=3Dy
CONFIG_XENO_OPT_NATIVE_MUTEX=3Dy
CONFIG_XENO_OPT_NATIVE_COND=3Dy
CONFIG_XENO_OPT_NATIVE_QUEUE=3Dy
CONFIG_XENO_OPT_NATIVE_HEAP=3Dy
CONFIG_XENO_OPT_NATIVE_ALARM=3Dy
CONFIG_XENO_OPT_NATIVE_MPS=3Dy
# CONFIG_XENO_OPT_NATIVE_INTR is not set
CONFIG_XENO_OPT_DEBUG_NATIVE=3Dy
CONFIG_XENO_SKIN_POSIX=3Dy
CONFIG_XENO_OPT_POSIX_PERIOD=3D0
# CONFIG_XENO_OPT_POSIX_SHM is not set
# CONFIG_XENO_OPT_POSIX_INTR is not set
# CONFIG_XENO_OPT_POSIX_SELECT is not set
CONFIG_XENO_OPT_DEBUG_POSIX=3Dy
# CONFIG_XENO_SKIN_PSOS is not set
# CONFIG_XENO_SKIN_UITRON is not set
# CONFIG_XENO_SKIN_VRTX is not set
# CONFIG_XENO_SKIN_VXWORKS is not set
# CONFIG_XENO_SKIN_RTAI is not set
CONFIG_XENO_SKIN_RTDM=3Dy
CONFIG_XENO_OPT_RTDM_PERIOD=3D0
CONFIG_XENO_OPT_RTDM_FILDES=3D128
# CONFIG_XENO_OPT_RTDM_SELECT is not set
CONFIG_XENO_OPT_DEBUG_RTDM=3Dy

#
# Drivers
#

#
# Serial drivers
#
# CONFIG_XENO_DRIVERS_16550A is not set

#
# Testing drivers
#
CONFIG_XENO_KLATENCY_MODULE=3Dm
CONFIG_XENO_DRIVERS_TIMERBENCH=3Dm
CONFIG_XENO_DRIVERS_KLATENCY=3Dm
CONFIG_XENO_DRIVERS_IRQBENCH=3Dm
CONFIG_XENO_DRIVERS_SWITCHTEST=3Dm

#
# CAN drivers
#
# CONFIG_XENO_DRIVERS_CAN is not set

#
# Processor type and features
#
CONFIG_TICK_ONESHOT=3Dy
CONFIG_NO_HZ=3Dy
CONFIG_HIGH_RES_TIMERS=3Dy
CONFIG_GENERIC_CLOCKEVENTS_BUILD=3Dy
CONFIG_SMP=3Dy
CONFIG_X86_PC=3Dy
# CONFIG_X86_ELAN is not set
# CONFIG_X86_VOYAGER is not set
# CONFIG_X86_NUMAQ is not set
# CONFIG_X86_SUMMIT is not set
# CONFIG_X86_BIGSMP is not set
# CONFIG_X86_VISWS is not set
# CONFIG_X86_GENERICARCH is not set
# CONFIG_X86_ES7000 is not set
# CONFIG_X86_RDC321X is not set
# CONFIG_X86_VSMP is not set
CONFIG_SCHED_NO_NO_OMIT_FRAME_POINTER=3Dy
# CONFIG_M386 is not set
# CONFIG_M486 is not set
# CONFIG_M586 is not set
# CONFIG_M586TSC is not set
# CONFIG_M586MMX is not set
# CONFIG_M686 is not set
# CONFIG_MPENTIUMII is not set
# CONFIG_MPENTIUMIII is not set
# CONFIG_MPENTIUMM is not set
CONFIG_MPENTIUM4=3Dy
# CONFIG_MK6 is not set
# CONFIG_MK7 is not set
# CONFIG_MK8 is not set
# CONFIG_MCRUSOE is not set
# CONFIG_MEFFICEON is not set
# CONFIG_MWINCHIPC6 is not set
# CONFIG_MWINCHIP2 is not set
# CONFIG_MWINCHIP3D is not set
# CONFIG_MGEODEGX1 is not set
# CONFIG_MGEODE_LX is not set
# CONFIG_MCYRIXIII is not set
# CONFIG_MVIAC3_2 is not set
# CONFIG_MVIAC7 is not set
# CONFIG_MPSC is not set
# CONFIG_MCORE2 is not set
# CONFIG_GENERIC_CPU is not set
CONFIG_X86_GENERIC=3Dy
CONFIG_X86_CPU=3Dy
CONFIG_X86_CMPXCHG=3Dy
CONFIG_X86_L1_CACHE_SHIFT=3D7
CONFIG_X86_XADD=3Dy
CONFIG_X86_WP_WORKS_OK=3Dy
CONFIG_X86_INVLPG=3Dy
CONFIG_X86_BSWAP=3Dy
CONFIG_X86_POPAD_OK=3Dy
CONFIG_X86_GOOD_APIC=3Dy
CONFIG_X86_INTEL_USERCOPY=3Dy
CONFIG_X86_USE_PPRO_CHECKSUM=3Dy
CONFIG_X86_TSC=3Dy
CONFIG_X86_CMOV=3Dy
CONFIG_X86_MINIMUM_CPU_FAMILY=3D4
CONFIG_X86_DEBUGCTLMSR=3Dy
CONFIG_HPET_TIMER=3Dy
CONFIG_HPET_EMULATE_RTC=3Dy
CONFIG_DMI=3Dy
# CONFIG_IOMMU_HELPER is not set
CONFIG_NR_CPUS=3D2
CONFIG_SCHED_SMT=3Dy
CONFIG_SCHED_MC=3Dy
CONFIG_PREEMPT_NONE=3Dy
# CONFIG_PREEMPT_VOLUNTARY is not set
# CONFIG_PREEMPT is not set
CONFIG_IPIPE=3Dy
CONFIG_IPIPE_DOMAINS=3D4
CONFIG_IPIPE_COMPAT=3Dy
CONFIG_IPIPE_DELAYED_ATOMICSW=3Dy
CONFIG_X86_LOCAL_APIC=3Dy
CONFIG_X86_IO_APIC=3Dy
CONFIG_X86_MCE=3Dy
CONFIG_X86_MCE_NONFATAL=3Dy
CONFIG_X86_MCE_P4THERMAL=3Dy
CONFIG_VM86=3Dy
# CONFIG_TOSHIBA is not set
# CONFIG_I8K is not set
CONFIG_X86_REBOOTFIXUPS=3Dy
CONFIG_MICROCODE=3Dy
CONFIG_MICROCODE_OLD_INTERFACE=3Dy
CONFIG_X86_MSR=3Dy
CONFIG_X86_CPUID=3Dy
# CONFIG_NOHIGHMEM is not set
CONFIG_HIGHMEM4G=3Dy
# CONFIG_HIGHMEM64G is not set
CONFIG_PAGE_OFFSET=3D0xC0000000
CONFIG_HIGHMEM=3Dy
CONFIG_ARCH_FLATMEM_ENABLE=3Dy
CONFIG_ARCH_SPARSEMEM_ENABLE=3Dy
CONFIG_ARCH_SELECT_MEMORY_MODEL=3Dy
CONFIG_SELECT_MEMORY_MODEL=3Dy
CONFIG_FLATMEM_MANUAL=3Dy
# CONFIG_DISCONTIGMEM_MANUAL is not set
# CONFIG_SPARSEMEM_MANUAL is not set
CONFIG_FLATMEM=3Dy
CONFIG_FLAT_NODE_MEM_MAP=3Dy
CONFIG_SPARSEMEM_STATIC=3Dy
# CONFIG_SPARSEMEM_VMEMMAP_ENABLE is not set
CONFIG_PAGEFLAGS_EXTENDED=3Dy
CONFIG_SPLIT_PTLOCK_CPUS=3D4
CONFIG_RESOURCES_64BIT=3Dy
CONFIG_ZONE_DMA_FLAG=3D1
CONFIG_BOUNCE=3Dy
CONFIG_VIRT_TO_BUS=3Dy
# CONFIG_HIGHPTE is not set
# CONFIG_MATH_EMULATION is not set
CONFIG_MTRR=3Dy
# CONFIG_X86_PAT is not set
# CONFIG_EFI is not set
# CONFIG_IRQBALANCE is not set
CONFIG_SECCOMP=3Dy
# CONFIG_HZ_100 is not set
CONFIG_HZ_250=3Dy
# CONFIG_HZ_300 is not set
# CONFIG_HZ_1000 is not set
CONFIG_HZ=3D250
CONFIG_SCHED_HRTICK=3Dy
# CONFIG_KEXEC is not set
# CONFIG_CRASH_DUMP is not set
CONFIG_PHYSICAL_START=3D0x100000
# CONFIG_RELOCATABLE is not set
CONFIG_PHYSICAL_ALIGN=3D0x100000
CONFIG_HOTPLUG_CPU=3Dy
CONFIG_COMPAT_VDSO=3Dy
CONFIG_ARCH_ENABLE_MEMORY_HOTPLUG=3Dy

#
# Power management options
#
CONFIG_PM=3Dy
# CONFIG_PM_DEBUG is not set
# CONFIG_SUSPEND is not set
# CONFIG_HIBERNATION is not set
CONFIG_ACPI=3Dy
CONFIG_ACPI_PROCFS=3Dy
CONFIG_ACPI_PROCFS_POWER=3Dy
CONFIG_ACPI_SYSFS_POWER=3Dy
CONFIG_ACPI_PROC_EVENT=3Dy
CONFIG_ACPI_AC=3Dy
CONFIG_ACPI_BATTERY=3Dy
CONFIG_ACPI_BUTTON=3Dy
CONFIG_ACPI_FAN=3Dy
CONFIG_ACPI_DOCK=3Dy
# CONFIG_ACPI_BAY is not set
# CONFIG_ACPI_PROCESSOR is not set
# CONFIG_ACPI_WMI is not set
# CONFIG_ACPI_ASUS is not set
# CONFIG_ACPI_TOSHIBA is not set
# CONFIG_ACPI_CUSTOM_DSDT is not set
CONFIG_ACPI_BLACKLIST_YEAR=3D2001
CONFIG_ACPI_DEBUG=3Dy
# CONFIG_ACPI_DEBUG_FUNC_TRACE is not set
CONFIG_ACPI_EC=3Dy
CONFIG_ACPI_POWER=3Dy
CONFIG_ACPI_SYSTEM=3Dy
CONFIG_X86_PM_TIMER=3Dy
CONFIG_ACPI_CONTAINER=3Dy
# CONFIG_ACPI_SBS is not set

#
# CPU Frequency scaling
#
# CONFIG_CPU_FREQ is not set
CONFIG_CPU_IDLE=3Dy
CONFIG_CPU_IDLE_GOV_LADDER=3Dy
CONFIG_CPU_IDLE_GOV_MENU=3Dy

#
# Bus options (PCI etc.)
#
CONFIG_PCI=3Dy
# CONFIG_PCI_GOBIOS is not set
# CONFIG_PCI_GOMMCONFIG is not set
# CONFIG_PCI_GODIRECT is not set
# CONFIG_PCI_GOOLPC is not set
CONFIG_PCI_GOANY=3Dy
CONFIG_PCI_BIOS=3Dy
CONFIG_PCI_DIRECT=3Dy
CONFIG_PCI_MMCONFIG=3Dy
CONFIG_PCI_DOMAINS=3Dy
# CONFIG_PCIEPORTBUS is not set
CONFIG_ARCH_SUPPORTS_MSI=3Dy
CONFIG_PCI_MSI=3Dy
CONFIG_PCI_LEGACY=3Dy
# CONFIG_PCI_DEBUG is not set
# CONFIG_HT_IRQ is not set
CONFIG_ISA_DMA_API=3Dy
# CONFIG_ISA is not set
# CONFIG_MCA is not set
# CONFIG_SCx200 is not set
# CONFIG_OLPC is not set
# CONFIG_PCCARD is not set
# CONFIG_HOTPLUG_PCI is not set

#
# Executable file formats / Emulations
#
CONFIG_BINFMT_ELF=3Dy
# CONFIG_BINFMT_AOUT is not set
# CONFIG_BINFMT_MISC is not set

#
# Networking
#
CONFIG_NET=3Dy

#
# Networking options
#
CONFIG_PACKET=3Dy
# CONFIG_PACKET_MMAP is not set
CONFIG_UNIX=3Dy
CONFIG_XFRM=3Dy
# CONFIG_XFRM_USER is not set
# CONFIG_XFRM_SUB_POLICY is not set
# CONFIG_XFRM_MIGRATE is not set
# CONFIG_XFRM_STATISTICS is not set
# CONFIG_NET_KEY is not set
CONFIG_INET=3Dy
CONFIG_IP_MULTICAST=3Dy
# CONFIG_IP_ADVANCED_ROUTER is not set
CONFIG_IP_FIB_HASH=3Dy
CONFIG_IP_PNP=3Dy
CONFIG_IP_PNP_DHCP=3Dy
# CONFIG_IP_PNP_BOOTP is not set
# CONFIG_IP_PNP_RARP is not set
# CONFIG_NET_IPIP is not set
# CONFIG_NET_IPGRE is not set
# CONFIG_IP_MROUTE is not set
# CONFIG_ARPD is not set
# CONFIG_SYN_COOKIES is not set
# CONFIG_INET_AH is not set
# CONFIG_INET_ESP is not set
# CONFIG_INET_IPCOMP is not set
# CONFIG_INET_XFRM_TUNNEL is not set
CONFIG_INET_TUNNEL=3Dy
CONFIG_INET_XFRM_MODE_TRANSPORT=3Dy
CONFIG_INET_XFRM_MODE_TUNNEL=3Dy
# CONFIG_INET_XFRM_MODE_BEET is not set
# CONFIG_INET_LRO is not set
CONFIG_INET_DIAG=3Dy
CONFIG_INET_TCP_DIAG=3Dy
# CONFIG_TCP_CONG_ADVANCED is not set
CONFIG_TCP_CONG_CUBIC=3Dy
CONFIG_DEFAULT_TCP_CONG=3D"cubic"
# CONFIG_TCP_MD5SIG is not set
# CONFIG_IP_VS is not set
CONFIG_IPV6=3Dy
# CONFIG_IPV6_PRIVACY is not set
# CONFIG_IPV6_ROUTER_PREF is not set
# CONFIG_IPV6_OPTIMISTIC_DAD is not set
# CONFIG_INET6_AH is not set
# CONFIG_INET6_ESP is not set
# CONFIG_INET6_IPCOMP is not set
# CONFIG_IPV6_MIP6 is not set
# CONFIG_INET6_XFRM_TUNNEL is not set
# CONFIG_INET6_TUNNEL is not set
CONFIG_INET6_XFRM_MODE_TRANSPORT=3Dy
CONFIG_INET6_XFRM_MODE_TUNNEL=3Dy
# CONFIG_INET6_XFRM_MODE_BEET is not set
# CONFIG_INET6_XFRM_MODE_ROUTEOPTIMIZATION is not set
CONFIG_IPV6_SIT=3Dy
CONFIG_IPV6_NDISC_NODETYPE=3Dy
# CONFIG_IPV6_TUNNEL is not set
# CONFIG_IPV6_MULTIPLE_TABLES is not set
# CONFIG_IPV6_MROUTE is not set
# CONFIG_NETWORK_SECMARK is not set
CONFIG_NETFILTER=3Dy
# CONFIG_NETFILTER_DEBUG is not set
CONFIG_NETFILTER_ADVANCED=3Dy

#
# Core Netfilter Configuration
#
CONFIG_NETFILTER_NETLINK=3Dm
# CONFIG_NETFILTER_NETLINK_QUEUE is not set
CONFIG_NETFILTER_NETLINK_LOG=3Dm
# CONFIG_NF_CONNTRACK is not set
# CONFIG_NETFILTER_XTABLES is not set

#
# IP: Netfilter Configuration
#
# CONFIG_IP_NF_QUEUE is not set
# CONFIG_IP_NF_IPTABLES is not set
# CONFIG_IP_NF_ARPTABLES is not set

#
# IPv6: Netfilter Configuration
#
# CONFIG_IP6_NF_QUEUE is not set
# CONFIG_IP6_NF_IPTABLES is not set
# CONFIG_IP_DCCP is not set
# CONFIG_IP_SCTP is not set
# CONFIG_TIPC is not set
# CONFIG_ATM is not set
# CONFIG_BRIDGE is not set
# CONFIG_VLAN_8021Q is not set
# CONFIG_DECNET is not set
# CONFIG_LLC2 is not set
# CONFIG_IPX is not set
# CONFIG_ATALK is not set
# CONFIG_X25 is not set
# CONFIG_LAPB is not set
# CONFIG_ECONET is not set
# CONFIG_WAN_ROUTER is not set
# CONFIG_NET_SCHED is not set

#
# Network testing
#
# CONFIG_NET_PKTGEN is not set
# CONFIG_NET_TCPPROBE is not set
# CONFIG_HAMRADIO is not set
# CONFIG_CAN is not set
# CONFIG_IRDA is not set
# CONFIG_BT is not set
# CONFIG_AF_RXRPC is not set

#
# Wireless
#
# CONFIG_CFG80211 is not set
# CONFIG_WIRELESS_EXT is not set
# CONFIG_MAC80211 is not set
# CONFIG_IEEE80211 is not set
# CONFIG_RFKILL is not set
# CONFIG_NET_9P is not set

#
# Device Drivers
#

#
# Generic Driver Options
#
CONFIG_UEVENT_HELPER_PATH=3D"/sbin/hotplug"
CONFIG_STANDALONE=3Dy
CONFIG_PREVENT_FIRMWARE_BUILD=3Dy
CONFIG_FW_LOADER=3Dy
# CONFIG_DEBUG_DRIVER is not set
# CONFIG_DEBUG_DEVRES is not set
# CONFIG_SYS_HYPERVISOR is not set
# CONFIG_CONNECTOR is not set
# CONFIG_MTD is not set
# CONFIG_PARPORT is not set
CONFIG_PNP=3Dy
# CONFIG_PNP_DEBUG is not set

#
# Protocols
#
CONFIG_PNPACPI=3Dy
CONFIG_BLK_DEV=3Dy
# CONFIG_BLK_DEV_FD is not set
# CONFIG_BLK_CPQ_DA is not set
# CONFIG_BLK_CPQ_CISS_DA is not set
# CONFIG_BLK_DEV_DAC960 is not set
# CONFIG_BLK_DEV_UMEM is not set
# CONFIG_BLK_DEV_COW_COMMON is not set
CONFIG_BLK_DEV_LOOP=3Dy
# CONFIG_BLK_DEV_CRYPTOLOOP is not set
# CONFIG_BLK_DEV_NBD is not set
# CONFIG_BLK_DEV_SX8 is not set
# CONFIG_BLK_DEV_UB is not set
CONFIG_BLK_DEV_RAM=3Dy
CONFIG_BLK_DEV_RAM_COUNT=3D16
CONFIG_BLK_DEV_RAM_SIZE=3D4096
# CONFIG_BLK_DEV_XIP is not set
# CONFIG_CDROM_PKTCDVD is not set
# CONFIG_ATA_OVER_ETH is not set
# CONFIG_MISC_DEVICES is not set
CONFIG_HAVE_IDE=3Dy
# CONFIG_IDE is not set

#
# SCSI device support
#
# CONFIG_RAID_ATTRS is not set
CONFIG_SCSI=3Dy
CONFIG_SCSI_DMA=3Dy
# CONFIG_SCSI_TGT is not set
CONFIG_SCSI_NETLINK=3Dy
# CONFIG_SCSI_PROC_FS is not set

#
# SCSI support type (disk, tape, CD-ROM)
#
CONFIG_BLK_DEV_SD=3Dy
# CONFIG_CHR_DEV_ST is not set
# CONFIG_CHR_DEV_OSST is not set
CONFIG_BLK_DEV_SR=3Dy
# CONFIG_BLK_DEV_SR_VENDOR is not set
CONFIG_CHR_DEV_SG=3Dy
# CONFIG_CHR_DEV_SCH is not set

#
# Some SCSI devices (e.g. CD jukebox) support multiple LUNs
#
# CONFIG_SCSI_MULTI_LUN is not set
# CONFIG_SCSI_CONSTANTS is not set
# CONFIG_SCSI_LOGGING is not set
# CONFIG_SCSI_SCAN_ASYNC is not set
CONFIG_SCSI_WAIT_SCAN=3Dm

#
# SCSI Transports
#
CONFIG_SCSI_SPI_ATTRS=3Dy
CONFIG_SCSI_FC_ATTRS=3Dy
# CONFIG_SCSI_ISCSI_ATTRS is not set
# CONFIG_SCSI_SAS_LIBSAS is not set
# CONFIG_SCSI_SRP_ATTRS is not set
CONFIG_SCSI_LOWLEVEL=3Dy
# CONFIG_ISCSI_TCP is not set
CONFIG_BLK_DEV_3W_XXXX_RAID=3Dy
# CONFIG_SCSI_3W_9XXX is not set
# CONFIG_SCSI_ACARD is not set
# CONFIG_SCSI_AACRAID is not set
CONFIG_SCSI_AIC7XXX=3Dy
CONFIG_AIC7XXX_CMDS_PER_DEVICE=3D32
CONFIG_AIC7XXX_RESET_DELAY_MS=3D5000
CONFIG_AIC7XXX_DEBUG_ENABLE=3Dy
CONFIG_AIC7XXX_DEBUG_MASK=3D0
CONFIG_AIC7XXX_REG_PRETTY_PRINT=3Dy
# CONFIG_SCSI_AIC7XXX_OLD is not set
CONFIG_SCSI_AIC79XX=3Dy
CONFIG_AIC79XX_CMDS_PER_DEVICE=3D32
CONFIG_AIC79XX_RESET_DELAY_MS=3D4000
# CONFIG_AIC79XX_DEBUG_ENABLE is not set
CONFIG_AIC79XX_DEBUG_MASK=3D0
# CONFIG_AIC79XX_REG_PRETTY_PRINT is not set
# CONFIG_SCSI_AIC94XX is not set
# CONFIG_SCSI_DPT_I2O is not set
# CONFIG_SCSI_ADVANSYS is not set
# CONFIG_SCSI_ARCMSR is not set
# CONFIG_MEGARAID_NEWGEN is not set
# CONFIG_MEGARAID_LEGACY is not set
# CONFIG_MEGARAID_SAS is not set
# CONFIG_SCSI_HPTIOP is not set
# CONFIG_SCSI_BUSLOGIC is not set
# CONFIG_SCSI_DMX3191D is not set
# CONFIG_SCSI_EATA is not set
# CONFIG_SCSI_FUTURE_DOMAIN is not set
# CONFIG_SCSI_GDTH is not set
# CONFIG_SCSI_IPS is not set
# CONFIG_SCSI_INITIO is not set
# CONFIG_SCSI_INIA100 is not set
# CONFIG_SCSI_MVSAS is not set
# CONFIG_SCSI_STEX is not set
# CONFIG_SCSI_SYM53C8XX_2 is not set
# CONFIG_SCSI_IPR is not set
# CONFIG_SCSI_QLOGIC_1280 is not set
# CONFIG_SCSI_QLA_FC is not set
# CONFIG_SCSI_QLA_ISCSI is not set
# CONFIG_SCSI_LPFC is not set
# CONFIG_SCSI_DC395x is not set
# CONFIG_SCSI_DC390T is not set
# CONFIG_SCSI_NSP32 is not set
# CONFIG_SCSI_DEBUG is not set
# CONFIG_SCSI_SRP is not set
CONFIG_ATA=3Dy
# CONFIG_ATA_NONSTANDARD is not set
CONFIG_ATA_ACPI=3Dy
CONFIG_SATA_PMP=3Dy
CONFIG_SATA_AHCI=3Dy
# CONFIG_SATA_SIL24 is not set
CONFIG_ATA_SFF=3Dy
# CONFIG_SATA_SVW is not set
CONFIG_ATA_PIIX=3Dy
# CONFIG_SATA_MV is not set
# CONFIG_SATA_NV is not set
# CONFIG_PDC_ADMA is not set
# CONFIG_SATA_QSTOR is not set
# CONFIG_SATA_PROMISE is not set
# CONFIG_SATA_SX4 is not set
# CONFIG_SATA_SIL is not set
# CONFIG_SATA_SIS is not set
# CONFIG_SATA_ULI is not set
# CONFIG_SATA_VIA is not set
# CONFIG_SATA_VITESSE is not set
# CONFIG_SATA_INIC162X is not set
# CONFIG_PATA_ACPI is not set
# CONFIG_PATA_ALI is not set
# CONFIG_PATA_AMD is not set
# CONFIG_PATA_ARTOP is not set
# CONFIG_PATA_ATIIXP is not set
# CONFIG_PATA_CMD640_PCI is not set
# CONFIG_PATA_CMD64X is not set
# CONFIG_PATA_CS5520 is not set
# CONFIG_PATA_CS5530 is not set
# CONFIG_PATA_CS5535 is not set
# CONFIG_PATA_CS5536 is not set
# CONFIG_PATA_CYPRESS is not set
# CONFIG_PATA_EFAR is not set
# CONFIG_ATA_GENERIC is not set
# CONFIG_PATA_HPT366 is not set
# CONFIG_PATA_HPT37X is not set
# CONFIG_PATA_HPT3X2N is not set
# CONFIG_PATA_HPT3X3 is not set
# CONFIG_PATA_IT821X is not set
# CONFIG_PATA_IT8213 is not set
# CONFIG_PATA_JMICRON is not set
# CONFIG_PATA_TRIFLEX is not set
# CONFIG_PATA_MARVELL is not set
CONFIG_PATA_MPIIX=3Dy
CONFIG_PATA_OLDPIIX=3Dy
# CONFIG_PATA_NETCELL is not set
# CONFIG_PATA_NINJA32 is not set
# CONFIG_PATA_NS87410 is not set
# CONFIG_PATA_NS87415 is not set
# CONFIG_PATA_OPTI is not set
# CONFIG_PATA_OPTIDMA is not set
# CONFIG_PATA_PDC_OLD is not set
# CONFIG_PATA_RADISYS is not set
# CONFIG_PATA_RZ1000 is not set
# CONFIG_PATA_SC1200 is not set
# CONFIG_PATA_SERVERWORKS is not set
# CONFIG_PATA_PDC2027X is not set
# CONFIG_PATA_SIL680 is not set
# CONFIG_PATA_SIS is not set
# CONFIG_PATA_VIA is not set
# CONFIG_PATA_WINBOND is not set
# CONFIG_PATA_SCH is not set
# CONFIG_MD is not set
# CONFIG_FUSION is not set

#
# IEEE 1394 (FireWire) support
#

#
# Enable only one of the two stacks, unless you know what you are doing
#
# CONFIG_FIREWIRE is not set
CONFIG_IEEE1394=3Dy
CONFIG_IEEE1394_OHCI1394=3Dy
# CONFIG_IEEE1394_PCILYNX is not set
# CONFIG_IEEE1394_SBP2 is not set
# CONFIG_IEEE1394_ETH1394_ROM_ENTRY is not set
# CONFIG_IEEE1394_ETH1394 is not set
CONFIG_IEEE1394_RAWIO=3Dy
# CONFIG_IEEE1394_VIDEO1394 is not set
# CONFIG_IEEE1394_DV1394 is not set
# CONFIG_IEEE1394_VERBOSEDEBUG is not set
# CONFIG_I2O is not set
# CONFIG_MACINTOSH_DRIVERS is not set
CONFIG_NETDEVICES=3Dy
CONFIG_NETDEVICES_MULTIQUEUE=3Dy
# CONFIG_DUMMY is not set
# CONFIG_BONDING is not set
# CONFIG_MACVLAN is not set
# CONFIG_EQUALIZER is not set
# CONFIG_TUN is not set
# CONFIG_VETH is not set
# CONFIG_NET_SB1000 is not set
# CONFIG_ARCNET is not set
# CONFIG_PHYLIB is not set
CONFIG_NET_ETHERNET=3Dy
CONFIG_MII=3Dy
# CONFIG_HAPPYMEAL is not set
# CONFIG_SUNGEM is not set
# CONFIG_CASSINI is not set
# CONFIG_NET_VENDOR_3COM is not set
# CONFIG_NET_TULIP is not set
# CONFIG_HP100 is not set
# CONFIG_IBM_NEW_EMAC_ZMII is not set
# CONFIG_IBM_NEW_EMAC_RGMII is not set
# CONFIG_IBM_NEW_EMAC_TAH is not set
# CONFIG_IBM_NEW_EMAC_EMAC4 is not set
CONFIG_NET_PCI=3Dy
# CONFIG_PCNET32 is not set
# CONFIG_AMD8111_ETH is not set
# CONFIG_ADAPTEC_STARFIRE is not set
# CONFIG_B44 is not set
# CONFIG_FORCEDETH is not set
# CONFIG_EEPRO100 is not set
# CONFIG_E100 is not set
# CONFIG_FEALNX is not set
# CONFIG_NATSEMI is not set
# CONFIG_NE2K_PCI is not set
# CONFIG_8139CP is not set
CONFIG_8139TOO=3Dy
# CONFIG_8139TOO_PIO is not set
# CONFIG_8139TOO_TUNE_TWISTER is not set
# CONFIG_8139TOO_8129 is not set
# CONFIG_8139_OLD_RX_RESET is not set
# CONFIG_R6040 is not set
# CONFIG_SIS900 is not set
# CONFIG_EPIC100 is not set
# CONFIG_SUNDANCE is not set
# CONFIG_TLAN is not set
# CONFIG_VIA_RHINE is not set
# CONFIG_SC92031 is not set
CONFIG_NETDEV_1000=3Dy
# CONFIG_ACENIC is not set
# CONFIG_DL2K is not set
CONFIG_E1000=3Dy
# CONFIG_E1000_NAPI is not set
# CONFIG_E1000_DISABLE_PACKET_SPLIT is not set
# CONFIG_E1000E is not set
# CONFIG_E1000E_ENABLED is not set
# CONFIG_IP1000 is not set
# CONFIG_IGB is not set
# CONFIG_NS83820 is not set
# CONFIG_HAMACHI is not set
# CONFIG_YELLOWFIN is not set
# CONFIG_R8169 is not set
# CONFIG_SIS190 is not set
# CONFIG_SKGE is not set
# CONFIG_SKY2 is not set
# CONFIG_VIA_VELOCITY is not set
# CONFIG_TIGON3 is not set
# CONFIG_BNX2 is not set
# CONFIG_QLA3XXX is not set
# CONFIG_ATL1 is not set
# CONFIG_NETDEV_10000 is not set
# CONFIG_TR is not set

#
# Wireless LAN
#
# CONFIG_WLAN_PRE80211 is not set
# CONFIG_WLAN_80211 is not set
# CONFIG_IWLWIFI_LEDS is not set

#
# USB Network Adapters
#
# CONFIG_USB_CATC is not set
# CONFIG_USB_KAWETH is not set
# CONFIG_USB_PEGASUS is not set
# CONFIG_USB_RTL8150 is not set
# CONFIG_USB_USBNET is not set
# CONFIG_WAN is not set
# CONFIG_FDDI is not set
# CONFIG_HIPPI is not set
# CONFIG_PPP is not set
# CONFIG_SLIP is not set
# CONFIG_NET_FC is not set
# CONFIG_NETCONSOLE is not set
# CONFIG_NETPOLL is not set
# CONFIG_NET_POLL_CONTROLLER is not set
# CONFIG_ISDN is not set
# CONFIG_PHONE is not set

#
# Input device support
#
CONFIG_INPUT=3Dy
# CONFIG_INPUT_FF_MEMLESS is not set
# CONFIG_INPUT_POLLDEV is not set

#
# Userland interfaces
#
CONFIG_INPUT_MOUSEDEV=3Dy
CONFIG_INPUT_MOUSEDEV_PSAUX=3Dy
CONFIG_INPUT_MOUSEDEV_SCREEN_X=3D1024
CONFIG_INPUT_MOUSEDEV_SCREEN_Y=3D768
# CONFIG_INPUT_JOYDEV is not set
CONFIG_INPUT_EVDEV=3Dy
# CONFIG_INPUT_EVBUG is not set

#
# Input Device Drivers
#
CONFIG_INPUT_KEYBOARD=3Dy
CONFIG_KEYBOARD_ATKBD=3Dy
# CONFIG_KEYBOARD_SUNKBD is not set
# CONFIG_KEYBOARD_LKKBD is not set
# CONFIG_KEYBOARD_XTKBD is not set
# CONFIG_KEYBOARD_NEWTON is not set
# CONFIG_KEYBOARD_STOWAWAY is not set
CONFIG_INPUT_MOUSE=3Dy
CONFIG_MOUSE_PS2=3Dy
CONFIG_MOUSE_PS2_ALPS=3Dy
CONFIG_MOUSE_PS2_LOGIPS2PP=3Dy
CONFIG_MOUSE_PS2_SYNAPTICS=3Dy
CONFIG_MOUSE_PS2_LIFEBOOK=3Dy
CONFIG_MOUSE_PS2_TRACKPOINT=3Dy
# CONFIG_MOUSE_PS2_TOUCHKIT is not set
# CONFIG_MOUSE_SERIAL is not set
# CONFIG_MOUSE_APPLETOUCH is not set
# CONFIG_MOUSE_VSXXXAA is not set
# CONFIG_INPUT_JOYSTICK is not set
# CONFIG_INPUT_TABLET is not set
# CONFIG_INPUT_TOUCHSCREEN is not set
# CONFIG_INPUT_MISC is not set

#
# Hardware I/O ports
#
CONFIG_SERIO=3Dy
CONFIG_SERIO_I8042=3Dy
# CONFIG_SERIO_SERPORT is not set
# CONFIG_SERIO_CT82C710 is not set
# CONFIG_SERIO_PCIPS2 is not set
CONFIG_SERIO_LIBPS2=3Dy
# CONFIG_SERIO_RAW is not set
# CONFIG_GAMEPORT is not set

#
# Character devices
#
CONFIG_VT=3Dy
CONFIG_VT_CONSOLE=3Dy
CONFIG_HW_CONSOLE=3Dy
# CONFIG_VT_HW_CONSOLE_BINDING is not set
CONFIG_DEVKMEM=3Dy
# CONFIG_SERIAL_NONSTANDARD is not set
# CONFIG_NOZOMI is not set

#
# Serial drivers
#
CONFIG_SERIAL_8250=3Dy
CONFIG_SERIAL_8250_CONSOLE=3Dy
CONFIG_FIX_EARLYCON_MEM=3Dy
CONFIG_SERIAL_8250_PCI=3Dy
CONFIG_SERIAL_8250_PNP=3Dy
CONFIG_SERIAL_8250_NR_UARTS=3D4
CONFIG_SERIAL_8250_RUNTIME_UARTS=3D4
# CONFIG_SERIAL_8250_EXTENDED is not set

#
# Non-8250 serial port support
#
CONFIG_SERIAL_CORE=3Dy
CONFIG_SERIAL_CORE_CONSOLE=3Dy
# CONFIG_SERIAL_JSM is not set
CONFIG_UNIX98_PTYS=3Dy
CONFIG_LEGACY_PTYS=3Dy
CONFIG_LEGACY_PTY_COUNT=3D256
# CONFIG_IPMI_HANDLER is not set
# CONFIG_HW_RANDOM is not set
# CONFIG_NVRAM is not set
CONFIG_RTC=3Dy
# CONFIG_R3964 is not set
# CONFIG_APPLICOM is not set
# CONFIG_SONYPI is not set
# CONFIG_MWAVE is not set
# CONFIG_PC8736x_GPIO is not set
# CONFIG_NSC_GPIO is not set
# CONFIG_CS5535_GPIO is not set
CONFIG_RAW_DRIVER=3Dy
CONFIG_MAX_RAW_DEVS=3D256
CONFIG_HPET=3Dy
CONFIG_HPET_RTC_IRQ=3Dy
CONFIG_HPET_MMAP=3Dy
# CONFIG_HANGCHECK_TIMER is not set
# CONFIG_TCG_TPM is not set
# CONFIG_TELCLOCK is not set
CONFIG_DEVPORT=3Dy
CONFIG_I2C=3Dy
CONFIG_I2C_BOARDINFO=3Dy
# CONFIG_I2C_CHARDEV is not set
CONFIG_I2C_HELPER_AUTO=3Dy
CONFIG_I2C_ALGOBIT=3Dy

#
# I2C Hardware Bus support
#
# CONFIG_I2C_ALI1535 is not set
# CONFIG_I2C_ALI1563 is not set
# CONFIG_I2C_ALI15X3 is not set
# CONFIG_I2C_AMD756 is not set
# CONFIG_I2C_AMD8111 is not set
# CONFIG_I2C_I801 is not set
# CONFIG_I2C_I810 is not set
# CONFIG_I2C_PIIX4 is not set
# CONFIG_I2C_NFORCE2 is not set
# CONFIG_I2C_OCORES is not set
# CONFIG_I2C_PARPORT_LIGHT is not set
# CONFIG_I2C_PROSAVAGE is not set
# CONFIG_I2C_SAVAGE4 is not set
# CONFIG_I2C_SIMTEC is not set
# CONFIG_SCx200_ACB is not set
# CONFIG_I2C_SIS5595 is not set
# CONFIG_I2C_SIS630 is not set
# CONFIG_I2C_SIS96X is not set
# CONFIG_I2C_TAOS_EVM is not set
# CONFIG_I2C_STUB is not set
# CONFIG_I2C_TINY_USB is not set
# CONFIG_I2C_VIA is not set
# CONFIG_I2C_VIAPRO is not set
# CONFIG_I2C_VOODOO3 is not set
# CONFIG_I2C_PCA_PLATFORM is not set

#
# Miscellaneous I2C Chip support
#
# CONFIG_DS1682 is not set
# CONFIG_SENSORS_EEPROM is not set
# CONFIG_SENSORS_PCF8574 is not set
# CONFIG_PCF8575 is not set
# CONFIG_SENSORS_PCF8591 is not set
# CONFIG_SENSORS_MAX6875 is not set
# CONFIG_SENSORS_TSL2550 is not set
# CONFIG_I2C_DEBUG_CORE is not set
# CONFIG_I2C_DEBUG_ALGO is not set
# CONFIG_I2C_DEBUG_BUS is not set
# CONFIG_I2C_DEBUG_CHIP is not set
# CONFIG_SPI is not set
# CONFIG_W1 is not set
CONFIG_POWER_SUPPLY=3Dy
# CONFIG_POWER_SUPPLY_DEBUG is not set
# CONFIG_PDA_POWER is not set
# CONFIG_BATTERY_DS2760 is not set
# CONFIG_HWMON is not set
CONFIG_THERMAL=3Dy
# CONFIG_WATCHDOG is not set

#
# Sonics Silicon Backplane
#
CONFIG_SSB_POSSIBLE=3Dy
# CONFIG_SSB is not set

#
# Multifunction device drivers
#
# CONFIG_MFD_SM501 is not set
# CONFIG_HTC_PASIC3 is not set

#
# Multimedia devices
#

#
# Multimedia core support
#
# CONFIG_VIDEO_DEV is not set
# CONFIG_DVB_CORE is not set
# CONFIG_VIDEO_MEDIA is not set

#
# Multimedia drivers
#
# CONFIG_DAB is not set

#
# Graphics support
#
CONFIG_AGP=3Dy
# CONFIG_AGP_ALI is not set
# CONFIG_AGP_ATI is not set
# CONFIG_AGP_AMD is not set
# CONFIG_AGP_AMD64 is not set
CONFIG_AGP_INTEL=3Dy
# CONFIG_AGP_NVIDIA is not set
# CONFIG_AGP_SIS is not set
# CONFIG_AGP_SWORKS is not set
# CONFIG_AGP_VIA is not set
# CONFIG_AGP_EFFICEON is not set
CONFIG_DRM=3Dm
# CONFIG_DRM_TDFX is not set
# CONFIG_DRM_R128 is not set
CONFIG_DRM_RADEON=3Dm
# CONFIG_DRM_I810 is not set
# CONFIG_DRM_I830 is not set
# CONFIG_DRM_I915 is not set
# CONFIG_DRM_MGA is not set
# CONFIG_DRM_SIS is not set
# CONFIG_DRM_VIA is not set
# CONFIG_DRM_SAVAGE is not set
# CONFIG_VGASTATE is not set
# CONFIG_VIDEO_OUTPUT_CONTROL is not set
CONFIG_FB=3Dy
# CONFIG_FIRMWARE_EDID is not set
CONFIG_FB_DDC=3Dy
CONFIG_FB_CFB_FILLRECT=3Dy
CONFIG_FB_CFB_COPYAREA=3Dy
CONFIG_FB_CFB_IMAGEBLIT=3Dy
# CONFIG_FB_CFB_REV_PIXELS_IN_BYTE is not set
# CONFIG_FB_SYS_FILLRECT is not set
# CONFIG_FB_SYS_COPYAREA is not set
# CONFIG_FB_SYS_IMAGEBLIT is not set
# CONFIG_FB_FOREIGN_ENDIAN is not set
# CONFIG_FB_SYS_FOPS is not set
# CONFIG_FB_SVGALIB is not set
# CONFIG_FB_MACMODES is not set
CONFIG_FB_BACKLIGHT=3Dy
CONFIG_FB_MODE_HELPERS=3Dy
# CONFIG_FB_TILEBLITTING is not set

#
# Frame buffer hardware drivers
#
# CONFIG_FB_CIRRUS is not set
# CONFIG_FB_PM2 is not set
# CONFIG_FB_CYBER2000 is not set
# CONFIG_FB_ARC is not set
# CONFIG_FB_ASILIANT is not set
# CONFIG_FB_IMSTT is not set
# CONFIG_FB_VGA16 is not set
CONFIG_FB_VESA=3Dy
# CONFIG_FB_EFI is not set
# CONFIG_FB_N411 is not set
# CONFIG_FB_HGA is not set
# CONFIG_FB_S1D13XXX is not set
# CONFIG_FB_NVIDIA is not set
# CONFIG_FB_RIVA is not set
# CONFIG_FB_I810 is not set
# CONFIG_FB_LE80578 is not set
# CONFIG_FB_INTEL is not set
# CONFIG_FB_MATROX is not set
CONFIG_FB_RADEON=3Dy
CONFIG_FB_RADEON_I2C=3Dy
CONFIG_FB_RADEON_BACKLIGHT=3Dy
# CONFIG_FB_RADEON_DEBUG is not set
# CONFIG_FB_ATY128 is not set
# CONFIG_FB_ATY is not set
# CONFIG_FB_S3 is not set
# CONFIG_FB_SAVAGE is not set
# CONFIG_FB_SIS is not set
# CONFIG_FB_NEOMAGIC is not set
# CONFIG_FB_KYRO is not set
# CONFIG_FB_3DFX is not set
# CONFIG_FB_VOODOO1 is not set
# CONFIG_FB_VT8623 is not set
# CONFIG_FB_CYBLA is not set
# CONFIG_FB_TRIDENT is not set
# CONFIG_FB_ARK is not set
# CONFIG_FB_PM3 is not set
# CONFIG_FB_GEODE is not set
# CONFIG_FB_VIRTUAL is not set
CONFIG_BACKLIGHT_LCD_SUPPORT=3Dy
CONFIG_LCD_CLASS_DEVICE=3Dm
CONFIG_BACKLIGHT_CLASS_DEVICE=3Dy
# CONFIG_BACKLIGHT_CORGI is not set
# CONFIG_BACKLIGHT_PROGEAR is not set

#
# Display device support
#
# CONFIG_DISPLAY_SUPPORT is not set

#
# Console display driver support
#
CONFIG_VGA_CONSOLE=3Dy
CONFIG_VGACON_SOFT_SCROLLBACK=3Dy
CONFIG_VGACON_SOFT_SCROLLBACK_SIZE=3D128
CONFIG_VIDEO_SELECT=3Dy
CONFIG_DUMMY_CONSOLE=3Dy
CONFIG_FRAMEBUFFER_CONSOLE=3Dy
# CONFIG_FRAMEBUFFER_CONSOLE_DETECT_PRIMARY is not set
# CONFIG_FRAMEBUFFER_CONSOLE_ROTATION is not set
# CONFIG_FONTS is not set
CONFIG_FONT_8x8=3Dy
CONFIG_FONT_8x16=3Dy
CONFIG_LOGO=3Dy
CONFIG_LOGO_LINUX_MONO=3Dy
CONFIG_LOGO_LINUX_VGA16=3Dy
CONFIG_LOGO_LINUX_CLUT224=3Dy

#
# Sound
#
CONFIG_SOUND=3Dy

#
# Advanced Linux Sound Architecture
#
# CONFIG_SND is not set

#
# Open Sound System
#
# CONFIG_SOUND_PRIME is not set
# CONFIG_HID_SUPPORT is not set
CONFIG_USB_SUPPORT=3Dy
CONFIG_USB_ARCH_HAS_HCD=3Dy
CONFIG_USB_ARCH_HAS_OHCI=3Dy
CONFIG_USB_ARCH_HAS_EHCI=3Dy
CONFIG_USB=3Dy
# CONFIG_USB_DEBUG is not set
# CONFIG_USB_ANNOUNCE_NEW_DEVICES is not set

#
# Miscellaneous USB options
#
CONFIG_USB_DEVICEFS=3Dy
# CONFIG_USB_DEVICE_CLASS is not set
# CONFIG_USB_DYNAMIC_MINORS is not set
# CONFIG_USB_SUSPEND is not set
# CONFIG_USB_OTG is not set

#
# USB Host Controller Drivers
#
# CONFIG_USB_C67X00_HCD is not set
CONFIG_USB_EHCI_HCD=3Dy
# CONFIG_USB_EHCI_ROOT_HUB_TT is not set
# CONFIG_USB_EHCI_TT_NEWSCHED is not set
# CONFIG_USB_ISP116X_HCD is not set
# CONFIG_USB_ISP1760_HCD is not set
CONFIG_USB_OHCI_HCD=3Dy
# CONFIG_USB_OHCI_BIG_ENDIAN_DESC is not set
# CONFIG_USB_OHCI_BIG_ENDIAN_MMIO is not set
CONFIG_USB_OHCI_LITTLE_ENDIAN=3Dy
CONFIG_USB_UHCI_HCD=3Dy
# CONFIG_USB_SL811_HCD is not set
# CONFIG_USB_R8A66597_HCD is not set

#
# USB Device Class drivers
#
# CONFIG_USB_ACM is not set
CONFIG_USB_PRINTER=3Dy
# CONFIG_USB_WDM is not set

#
# NOTE: USB_STORAGE enables SCSI, and 'SCSI disk support'
#

#
# may also be needed; see USB_STORAGE Help for more information
#
CONFIG_USB_STORAGE=3Dy
# CONFIG_USB_STORAGE_DEBUG is not set
# CONFIG_USB_STORAGE_DATAFAB is not set
# CONFIG_USB_STORAGE_FREECOM is not set
# CONFIG_USB_STORAGE_ISD200 is not set
# CONFIG_USB_STORAGE_DPCM is not set
# CONFIG_USB_STORAGE_USBAT is not set
# CONFIG_USB_STORAGE_SDDR09 is not set
# CONFIG_USB_STORAGE_SDDR55 is not set
# CONFIG_USB_STORAGE_JUMPSHOT is not set
# CONFIG_USB_STORAGE_ALAUDA is not set
# CONFIG_USB_STORAGE_ONETOUCH is not set
# CONFIG_USB_STORAGE_KARMA is not set
# CONFIG_USB_STORAGE_CYPRESS_ATACB is not set
# CONFIG_USB_LIBUSUAL is not set

#
# USB Imaging devices
#
# CONFIG_USB_MDC800 is not set
# CONFIG_USB_MICROTEK is not set
CONFIG_USB_MON=3Dy

#
# USB port drivers
#
# CONFIG_USB_SERIAL is not set

#
# USB Miscellaneous drivers
#
# CONFIG_USB_EMI62 is not set
# CONFIG_USB_EMI26 is not set
# CONFIG_USB_ADUTUX is not set
# CONFIG_USB_AUERSWALD is not set
# CONFIG_USB_RIO500 is not set
# CONFIG_USB_LEGOTOWER is not set
# CONFIG_USB_LCD is not set
# CONFIG_USB_BERRY_CHARGE is not set
# CONFIG_USB_LED is not set
# CONFIG_USB_CYPRESS_CY7C63 is not set
# CONFIG_USB_CYTHERM is not set
# CONFIG_USB_PHIDGET is not set
# CONFIG_USB_IDMOUSE is not set
# CONFIG_USB_FTDI_ELAN is not set
# CONFIG_USB_APPLEDISPLAY is not set
# CONFIG_USB_SISUSBVGA is not set
# CONFIG_USB_LD is not set
# CONFIG_USB_TRANCEVIBRATOR is not set
# CONFIG_USB_IOWARRIOR is not set
# CONFIG_USB_TEST is not set
# CONFIG_USB_ISIGHTFW is not set
# CONFIG_USB_GADGET is not set
# CONFIG_MMC is not set
# CONFIG_MEMSTICK is not set
# CONFIG_NEW_LEDS is not set
# CONFIG_ACCESSIBILITY is not set
# CONFIG_INFINIBAND is not set
# CONFIG_EDAC is not set
# CONFIG_RTC_CLASS is not set
# CONFIG_DMADEVICES is not set
# CONFIG_UIO is not set

#
# Firmware Drivers
#
# CONFIG_EDD is not set
# CONFIG_DELL_RBU is not set
# CONFIG_DCDBAS is not set
CONFIG_DMIID=3Dy
# CONFIG_ISCSI_IBFT_FIND is not set

#
# File systems
#
CONFIG_EXT2_FS=3Dy
CONFIG_EXT2_FS_XATTR=3Dy
CONFIG_EXT2_FS_POSIX_ACL=3Dy
# CONFIG_EXT2_FS_SECURITY is not set
# CONFIG_EXT2_FS_XIP is not set
CONFIG_EXT3_FS=3Dy
CONFIG_EXT3_FS_XATTR=3Dy
CONFIG_EXT3_FS_POSIX_ACL=3Dy
# CONFIG_EXT3_FS_SECURITY is not set
# CONFIG_EXT4DEV_FS is not set
CONFIG_JBD=3Dy
CONFIG_FS_MBCACHE=3Dy
# CONFIG_REISERFS_FS is not set
# CONFIG_JFS_FS is not set
CONFIG_FS_POSIX_ACL=3Dy
# CONFIG_XFS_FS is not set
# CONFIG_OCFS2_FS is not set
CONFIG_DNOTIFY=3Dy
CONFIG_INOTIFY=3Dy
CONFIG_INOTIFY_USER=3Dy
# CONFIG_QUOTA is not set
# CONFIG_AUTOFS_FS is not set
CONFIG_AUTOFS4_FS=3Dy
CONFIG_FUSE_FS=3Dm
CONFIG_GENERIC_ACL=3Dy

#
# CD-ROM/DVD Filesystems
#
CONFIG_ISO9660_FS=3Dy
# CONFIG_JOLIET is not set
# CONFIG_ZISOFS is not set
# CONFIG_UDF_FS is not set

#
# DOS/FAT/NT Filesystems
#
CONFIG_FAT_FS=3Dy
CONFIG_MSDOS_FS=3Dy
CONFIG_VFAT_FS=3Dy
CONFIG_FAT_DEFAULT_CODEPAGE=3D437
CONFIG_FAT_DEFAULT_IOCHARSET=3D"iso8859-1"
# CONFIG_NTFS_FS is not set

#
# Pseudo filesystems
#
CONFIG_PROC_FS=3Dy
CONFIG_PROC_KCORE=3Dy
CONFIG_PROC_SYSCTL=3Dy
CONFIG_SYSFS=3Dy
CONFIG_TMPFS=3Dy
CONFIG_TMPFS_POSIX_ACL=3Dy
CONFIG_HUGETLBFS=3Dy
CONFIG_HUGETLB_PAGE=3Dy
# CONFIG_CONFIGFS_FS is not set

#
# Miscellaneous filesystems
#
# CONFIG_ADFS_FS is not set
# CONFIG_AFFS_FS is not set
# CONFIG_HFS_FS is not set
# CONFIG_HFSPLUS_FS is not set
# CONFIG_BEFS_FS is not set
# CONFIG_BFS_FS is not set
# CONFIG_EFS_FS is not set
# CONFIG_CRAMFS is not set
# CONFIG_VXFS_FS is not set
# CONFIG_MINIX_FS is not set
# CONFIG_HPFS_FS is not set
# CONFIG_QNX4FS_FS is not set
# CONFIG_ROMFS_FS is not set
# CONFIG_SYSV_FS is not set
# CONFIG_UFS_FS is not set
CONFIG_NETWORK_FILESYSTEMS=3Dy
# CONFIG_NFS_FS is not set
# CONFIG_NFSD is not set
# CONFIG_SMB_FS is not set
CONFIG_CIFS=3Dy
# CONFIG_CIFS_STATS is not set
# CONFIG_CIFS_WEAK_PW_HASH is not set
# CONFIG_CIFS_XATTR is not set
# CONFIG_CIFS_DEBUG2 is not set
# CONFIG_CIFS_EXPERIMENTAL is not set
# CONFIG_NCP_FS is not set
# CONFIG_CODA_FS is not set
# CONFIG_AFS_FS is not set

#
# Partition Types
#
# CONFIG_PARTITION_ADVANCED is not set
CONFIG_MSDOS_PARTITION=3Dy
CONFIG_NLS=3Dy
CONFIG_NLS_DEFAULT=3D"iso8859-1"
CONFIG_NLS_CODEPAGE_437=3Dy
# CONFIG_NLS_CODEPAGE_737 is not set
# CONFIG_NLS_CODEPAGE_775 is not set
# CONFIG_NLS_CODEPAGE_850 is not set
# CONFIG_NLS_CODEPAGE_852 is not set
# CONFIG_NLS_CODEPAGE_855 is not set
# CONFIG_NLS_CODEPAGE_857 is not set
# CONFIG_NLS_CODEPAGE_860 is not set
# CONFIG_NLS_CODEPAGE_861 is not set
# CONFIG_NLS_CODEPAGE_862 is not set
# CONFIG_NLS_CODEPAGE_863 is not set
# CONFIG_NLS_CODEPAGE_864 is not set
# CONFIG_NLS_CODEPAGE_865 is not set
# CONFIG_NLS_CODEPAGE_866 is not set
# CONFIG_NLS_CODEPAGE_869 is not set
# CONFIG_NLS_CODEPAGE_936 is not set
# CONFIG_NLS_CODEPAGE_950 is not set
# CONFIG_NLS_CODEPAGE_932 is not set
# CONFIG_NLS_CODEPAGE_949 is not set
# CONFIG_NLS_CODEPAGE_874 is not set
# CONFIG_NLS_ISO8859_8 is not set
# CONFIG_NLS_CODEPAGE_1250 is not set
# CONFIG_NLS_CODEPAGE_1251 is not set
CONFIG_NLS_ASCII=3Dy
CONFIG_NLS_ISO8859_1=3Dy
CONFIG_NLS_ISO8859_2=3Dy
# CONFIG_NLS_ISO8859_3 is not set
# CONFIG_NLS_ISO8859_4 is not set
# CONFIG_NLS_ISO8859_5 is not set
# CONFIG_NLS_ISO8859_6 is not set
# CONFIG_NLS_ISO8859_7 is not set
# CONFIG_NLS_ISO8859_9 is not set
# CONFIG_NLS_ISO8859_13 is not set
# CONFIG_NLS_ISO8859_14 is not set
CONFIG_NLS_ISO8859_15=3Dy
# CONFIG_NLS_KOI8_R is not set
# CONFIG_NLS_KOI8_U is not set
CONFIG_NLS_UTF8=3Dy
# CONFIG_DLM is not set

#
# Kernel hacking
#
CONFIG_TRACE_IRQFLAGS_SUPPORT=3Dy
# CONFIG_PRINTK_TIME is not set
CONFIG_ENABLE_WARN_DEPRECATED=3Dy
# CONFIG_ENABLE_MUST_CHECK is not set
CONFIG_FRAME_WARN=3D1024
CONFIG_MAGIC_SYSRQ=3Dy
CONFIG_UNUSED_SYMBOLS=3Dy
# CONFIG_DEBUG_FS is not set
# CONFIG_HEADERS_CHECK is not set
CONFIG_IPIPE_DEBUG=3Dy
CONFIG_IPIPE_DEBUG_CONTEXT=3Dy
CONFIG_IPIPE_TRACE=3Dy
CONFIG_IPIPE_TRACE_ENABLE=3Dy
CONFIG_IPIPE_TRACE_MCOUNT=3Dy
CONFIG_IPIPE_TRACE_IRQSOFF=3Dy
CONFIG_IPIPE_TRACE_SHIFT=3D15
# CONFIG_IPIPE_TRACE_VMALLOC is not set
CONFIG_IPIPE_TRACE_PANIC=3Dy
CONFIG_IPIPE_TRACE_ENABLE_VALUE=3D1
CONFIG_DEBUG_KERNEL=3Dy
# CONFIG_DEBUG_SHIRQ is not set
CONFIG_DETECT_SOFTLOCKUP=3Dy
# CONFIG_SCHED_DEBUG is not set
# CONFIG_SCHEDSTATS is not set
CONFIG_TIMER_STATS=3Dy
# CONFIG_DEBUG_OBJECTS is not set
# CONFIG_SLUB_DEBUG_ON is not set
# CONFIG_SLUB_STATS is not set
# CONFIG_DEBUG_RT_MUTEXES is not set
# CONFIG_RT_MUTEX_TESTER is not set
# CONFIG_DEBUG_SPINLOCK is not set
# CONFIG_DEBUG_MUTEXES is not set
# CONFIG_DEBUG_LOCK_ALLOC is not set
# CONFIG_PROVE_LOCKING is not set
# CONFIG_LOCK_STAT is not set
# CONFIG_DEBUG_SPINLOCK_SLEEP is not set
# CONFIG_DEBUG_LOCKING_API_SELFTESTS is not set
# CONFIG_DEBUG_KOBJECT is not set
# CONFIG_DEBUG_HIGHMEM is not set
CONFIG_DEBUG_BUGVERBOSE=3Dy
# CONFIG_DEBUG_INFO is not set
# CONFIG_DEBUG_VM is not set
# CONFIG_DEBUG_WRITECOUNT is not set
# CONFIG_DEBUG_LIST is not set
# CONFIG_DEBUG_SG is not set
CONFIG_FRAME_POINTER=3Dy
# CONFIG_BOOT_PRINTK_DELAY is not set
# CONFIG_RCU_TORTURE_TEST is not set
# CONFIG_KPROBES_SANITY_TEST is not set
# CONFIG_BACKTRACE_SELF_TEST is not set
# CONFIG_LKDTM is not set
# CONFIG_FAULT_INJECTION is not set
# CONFIG_LATENCYTOP is not set
# CONFIG_PROVIDE_OHCI1394_DMA_INIT is not set
# CONFIG_SAMPLES is not set
CONFIG_HAVE_ARCH_KGDB=3Dy
# CONFIG_KGDB is not set
# CONFIG_NONPROMISC_DEVMEM is not set
CONFIG_EARLY_PRINTK=3Dy
CONFIG_DEBUG_STACKOVERFLOW=3Dy
# CONFIG_DEBUG_STACK_USAGE is not set
# CONFIG_DEBUG_PAGEALLOC is not set
# CONFIG_X86_PTDUMP is not set
# CONFIG_DEBUG_RODATA is not set
# CONFIG_DEBUG_NX_TEST is not set
# CONFIG_4KSTACKS is not set
CONFIG_X86_FIND_SMP_CONFIG=3Dy
CONFIG_X86_MPPARSE=3Dy
CONFIG_DOUBLEFAULT=3Dy
CONFIG_IO_DELAY_TYPE_0X80=3D0
CONFIG_IO_DELAY_TYPE_0XED=3D1
CONFIG_IO_DELAY_TYPE_UDELAY=3D2
CONFIG_IO_DELAY_TYPE_NONE=3D3
CONFIG_IO_DELAY_0X80=3Dy
# CONFIG_IO_DELAY_0XED is not set
# CONFIG_IO_DELAY_UDELAY is not set
# CONFIG_IO_DELAY_NONE is not set
CONFIG_DEFAULT_IO_DELAY_TYPE=3D0
# CONFIG_CPA_DEBUG is not set

#
# Security options
#
# CONFIG_KEYS is not set
# CONFIG_SECURITY is not set
# CONFIG_SECURITY_FILE_CAPABILITIES is not set
CONFIG_CRYPTO=3Dy

#
# Crypto core or helper
#
# CONFIG_CRYPTO_MANAGER is not set
# CONFIG_CRYPTO_GF128MUL is not set
# CONFIG_CRYPTO_NULL is not set
# CONFIG_CRYPTO_CRYPTD is not set
# CONFIG_CRYPTO_AUTHENC is not set
# CONFIG_CRYPTO_TEST is not set

#
# Authenticated Encryption with Associated Data
#
# CONFIG_CRYPTO_CCM is not set
# CONFIG_CRYPTO_GCM is not set
# CONFIG_CRYPTO_SEQIV is not set

#
# Block modes
#
# CONFIG_CRYPTO_CBC is not set
# CONFIG_CRYPTO_CTR is not set
# CONFIG_CRYPTO_CTS is not set
# CONFIG_CRYPTO_ECB is not set
# CONFIG_CRYPTO_LRW is not set
# CONFIG_CRYPTO_PCBC is not set
# CONFIG_CRYPTO_XTS is not set

#
# Hash modes
#
# CONFIG_CRYPTO_HMAC is not set
# CONFIG_CRYPTO_XCBC is not set

#
# Digest
#
# CONFIG_CRYPTO_CRC32C is not set
# CONFIG_CRYPTO_MD4 is not set
# CONFIG_CRYPTO_MD5 is not set
# CONFIG_CRYPTO_MICHAEL_MIC is not set
# CONFIG_CRYPTO_SHA1 is not set
# CONFIG_CRYPTO_SHA256 is not set
# CONFIG_CRYPTO_SHA512 is not set
# CONFIG_CRYPTO_TGR192 is not set
# CONFIG_CRYPTO_WP512 is not set

#
# Ciphers
#
# CONFIG_CRYPTO_AES is not set
# CONFIG_CRYPTO_AES_586 is not set
# CONFIG_CRYPTO_ANUBIS is not set
# CONFIG_CRYPTO_ARC4 is not set
# CONFIG_CRYPTO_BLOWFISH is not set
# CONFIG_CRYPTO_CAMELLIA is not set
# CONFIG_CRYPTO_CAST5 is not set
# CONFIG_CRYPTO_CAST6 is not set
# CONFIG_CRYPTO_DES is not set
# CONFIG_CRYPTO_FCRYPT is not set
# CONFIG_CRYPTO_KHAZAD is not set
# CONFIG_CRYPTO_SALSA20 is not set
# CONFIG_CRYPTO_SALSA20_586 is not set
# CONFIG_CRYPTO_SEED is not set
# CONFIG_CRYPTO_SERPENT is not set
# CONFIG_CRYPTO_TEA is not set
# CONFIG_CRYPTO_TWOFISH is not set
# CONFIG_CRYPTO_TWOFISH_586 is not set

#
# Compression
#
# CONFIG_CRYPTO_DEFLATE is not set
# CONFIG_CRYPTO_LZO is not set
CONFIG_CRYPTO_HW=3Dy
# CONFIG_CRYPTO_DEV_PADLOCK is not set
# CONFIG_CRYPTO_DEV_GEODE is not set
# CONFIG_CRYPTO_DEV_HIFN_795X is not set
CONFIG_HAVE_KVM=3Dy
CONFIG_VIRTUALIZATION=3Dy
# CONFIG_KVM is not set
# CONFIG_LGUEST is not set
# CONFIG_VIRTIO_PCI is not set
# CONFIG_VIRTIO_BALLOON is not set

#
# Library routines
#
CONFIG_BITREVERSE=3Dy
CONFIG_GENERIC_FIND_FIRST_BIT=3Dy
CONFIG_GENERIC_FIND_NEXT_BIT=3Dy
# CONFIG_CRC_CCITT is not set
# CONFIG_CRC16 is not set
# CONFIG_CRC_ITU_T is not set
CONFIG_CRC32=3Dy
# CONFIG_CRC7 is not set
# CONFIG_LIBCRC32C is not set
CONFIG_PLIST=3Dy
CONFIG_HAS_IOMEM=3Dy
CONFIG_HAS_IOPORT=3Dy
CONFIG_HAS_DMA=3Dy

--=_2cgrwpf9e5no
Content-Type: text/plain;
	charset=ISO-8859-2;
	name="config_2.6.27"
Content-Disposition: attachment;
	filename="config_2.6.27"
Content-Transfer-Encoding: quoted-printable

#
# Automatically generated make config: don't edit
# Linux kernel version: 2.6.27.18
# Thu Feb 19 16:53:23 2009
#
# CONFIG_64BIT is not set
CONFIG_X86_32=3Dy
# CONFIG_X86_64 is not set
CONFIG_X86=3Dy
CONFIG_ARCH_DEFCONFIG=3D"arch/x86/configs/i386_defconfig"
# CONFIG_GENERIC_LOCKBREAK is not set
CONFIG_GENERIC_TIME=3Dy
CONFIG_GENERIC_CMOS_UPDATE=3Dy
CONFIG_CLOCKSOURCE_WATCHDOG=3Dy
CONFIG_GENERIC_CLOCKEVENTS=3Dy
CONFIG_GENERIC_CLOCKEVENTS_BROADCAST=3Dy
CONFIG_LOCKDEP_SUPPORT=3Dy
CONFIG_STACKTRACE_SUPPORT=3Dy
CONFIG_HAVE_LATENCYTOP_SUPPORT=3Dy
CONFIG_FAST_CMPXCHG_LOCAL=3Dy
CONFIG_MMU=3Dy
CONFIG_ZONE_DMA=3Dy
CONFIG_GENERIC_ISA_DMA=3Dy
CONFIG_GENERIC_IOMAP=3Dy
CONFIG_GENERIC_BUG=3Dy
CONFIG_GENERIC_HWEIGHT=3Dy
# CONFIG_GENERIC_GPIO is not set
CONFIG_ARCH_MAY_HAVE_PC_FDC=3Dy
# CONFIG_RWSEM_GENERIC_SPINLOCK is not set
CONFIG_RWSEM_XCHGADD_ALGORITHM=3Dy
# CONFIG_ARCH_HAS_ILOG2_U32 is not set
# CONFIG_ARCH_HAS_ILOG2_U64 is not set
CONFIG_ARCH_HAS_CPU_IDLE_WAIT=3Dy
CONFIG_GENERIC_CALIBRATE_DELAY=3Dy
# CONFIG_GENERIC_TIME_VSYSCALL is not set
CONFIG_ARCH_HAS_CPU_RELAX=3Dy
CONFIG_ARCH_HAS_DEFAULT_IDLE=3Dy
CONFIG_ARCH_HAS_CACHE_LINE_SIZE=3Dy
CONFIG_HAVE_SETUP_PER_CPU_AREA=3Dy
# CONFIG_HAVE_CPUMASK_OF_CPU_MAP is not set
CONFIG_ARCH_HIBERNATION_POSSIBLE=3Dy
CONFIG_ARCH_SUSPEND_POSSIBLE=3Dy
# CONFIG_ZONE_DMA32 is not set
CONFIG_ARCH_POPULATES_NODE_MAP=3Dy
# CONFIG_AUDIT_ARCH is not set
CONFIG_ARCH_SUPPORTS_AOUT=3Dy
CONFIG_ARCH_SUPPORTS_OPTIMIZED_INLINING=3Dy
CONFIG_GENERIC_HARDIRQS=3Dy
CONFIG_GENERIC_IRQ_PROBE=3Dy
CONFIG_GENERIC_PENDING_IRQ=3Dy
CONFIG_X86_SMP=3Dy
CONFIG_X86_32_SMP=3Dy
CONFIG_X86_HT=3Dy
CONFIG_X86_BIOS_REBOOT=3Dy
CONFIG_X86_TRAMPOLINE=3Dy
CONFIG_KTIME_SCALAR=3Dy
CONFIG_DEFCONFIG_LIST=3D"/lib/modules/$UNAME_RELEASE/.config"

#
# General setup
#
CONFIG_EXPERIMENTAL=3Dy
CONFIG_LOCK_KERNEL=3Dy
CONFIG_INIT_ENV_ARG_LIMIT=3D32
CONFIG_LOCALVERSION=3D""
CONFIG_LOCALVERSION_AUTO=3Dy
CONFIG_SWAP=3Dy
CONFIG_SYSVIPC=3Dy
CONFIG_SYSVIPC_SYSCTL=3Dy
CONFIG_POSIX_MQUEUE=3Dy
# CONFIG_BSD_PROCESS_ACCT is not set
# CONFIG_TASKSTATS is not set
# CONFIG_AUDIT is not set
CONFIG_IKCONFIG=3Dy
CONFIG_IKCONFIG_PROC=3Dy
CONFIG_LOG_BUF_SHIFT=3D19
# CONFIG_CGROUPS is not set
CONFIG_HAVE_UNSTABLE_SCHED_CLOCK=3Dy
# CONFIG_GROUP_SCHED is not set
CONFIG_SYSFS_DEPRECATED=3Dy
CONFIG_SYSFS_DEPRECATED_V2=3Dy
CONFIG_RELAY=3Dy
CONFIG_NAMESPACES=3Dy
# CONFIG_UTS_NS is not set
# CONFIG_IPC_NS is not set
# CONFIG_USER_NS is not set
# CONFIG_PID_NS is not set
CONFIG_BLK_DEV_INITRD=3Dy
CONFIG_INITRAMFS_SOURCE=3D""
CONFIG_CC_OPTIMIZE_FOR_SIZE=3Dy
CONFIG_SYSCTL=3Dy
# CONFIG_EMBEDDED is not set
CONFIG_UID16=3Dy
CONFIG_SYSCTL_SYSCALL=3Dy
CONFIG_KALLSYMS=3Dy
CONFIG_KALLSYMS_ALL=3Dy
# CONFIG_KALLSYMS_EXTRA_PASS is not set
CONFIG_HOTPLUG=3Dy
CONFIG_PRINTK=3Dy
CONFIG_BUG=3Dy
CONFIG_ELF_CORE=3Dy
CONFIG_PCSPKR_PLATFORM=3Dy
CONFIG_COMPAT_BRK=3Dy
CONFIG_BASE_FULL=3Dy
CONFIG_FUTEX=3Dy
CONFIG_ANON_INODES=3Dy
CONFIG_EPOLL=3Dy
CONFIG_SIGNALFD=3Dy
CONFIG_TIMERFD=3Dy
CONFIG_EVENTFD=3Dy
CONFIG_SHMEM=3Dy
CONFIG_VM_EVENT_COUNTERS=3Dy
CONFIG_SLUB_DEBUG=3Dy
# CONFIG_SLAB is not set
CONFIG_SLUB=3Dy
# CONFIG_SLOB is not set
CONFIG_PROFILING=3Dy
# CONFIG_MARKERS is not set
CONFIG_OPROFILE=3Dy
CONFIG_HAVE_OPROFILE=3Dy
CONFIG_KPROBES=3Dy
CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS=3Dy
CONFIG_KRETPROBES=3Dy
CONFIG_HAVE_IOREMAP_PROT=3Dy
CONFIG_HAVE_KPROBES=3Dy
CONFIG_HAVE_KRETPROBES=3Dy
# CONFIG_HAVE_ARCH_TRACEHOOK is not set
# CONFIG_HAVE_DMA_ATTRS is not set
CONFIG_USE_GENERIC_SMP_HELPERS=3Dy
# CONFIG_HAVE_CLK is not set
CONFIG_PROC_PAGE_MONITOR=3Dy
CONFIG_HAVE_GENERIC_DMA_COHERENT=3Dy
CONFIG_SLABINFO=3Dy
CONFIG_RT_MUTEXES=3Dy
# CONFIG_TINY_SHMEM is not set
CONFIG_BASE_SMALL=3D0
CONFIG_MODULES=3Dy
# CONFIG_MODULE_FORCE_LOAD is not set
CONFIG_MODULE_UNLOAD=3Dy
CONFIG_MODULE_FORCE_UNLOAD=3Dy
# CONFIG_MODVERSIONS is not set
# CONFIG_MODULE_SRCVERSION_ALL is not set
CONFIG_KMOD=3Dy
CONFIG_STOP_MACHINE=3Dy
CONFIG_BLOCK=3Dy
CONFIG_LBD=3Dy
# CONFIG_BLK_DEV_IO_TRACE is not set
# CONFIG_LSF is not set
# CONFIG_BLK_DEV_BSG is not set
# CONFIG_BLK_DEV_INTEGRITY is not set

#
# IO Schedulers
#
CONFIG_IOSCHED_NOOP=3Dy
CONFIG_IOSCHED_AS=3Dy
CONFIG_IOSCHED_DEADLINE=3Dy
CONFIG_IOSCHED_CFQ=3Dy
# CONFIG_DEFAULT_AS is not set
# CONFIG_DEFAULT_DEADLINE is not set
CONFIG_DEFAULT_CFQ=3Dy
# CONFIG_DEFAULT_NOOP is not set
CONFIG_DEFAULT_IOSCHED=3D"cfq"
CONFIG_CLASSIC_RCU=3Dy

#
# Real-time sub-system
#
CONFIG_XENOMAI=3Dy
CONFIG_XENO_GENERIC_STACKPOOL=3Dy
CONFIG_XENO_OPT_NUCLEUS=3Dy
CONFIG_XENO_OPT_PERVASIVE=3Dy
# CONFIG_XENO_OPT_ISHIELD is not set
CONFIG_XENO_OPT_PRIOCPL=3Dy
CONFIG_XENO_OPT_PIPELINE_HEAD=3Dy
CONFIG_XENO_OPT_PIPE=3Dy
CONFIG_XENO_OPT_PIPE_NRDEV=3D32
CONFIG_XENO_OPT_REGISTRY=3Dy
CONFIG_XENO_OPT_REGISTRY_NRSLOTS=3D512
CONFIG_XENO_OPT_SYS_HEAPSZ=3D128
CONFIG_XENO_OPT_SYS_STACKPOOLSZ=3D32
CONFIG_XENO_OPT_STATS=3Dy
CONFIG_XENO_OPT_DEBUG=3Dy
# CONFIG_XENO_OPT_DEBUG_NUCLEUS is not set
# CONFIG_XENO_OPT_DEBUG_QUEUES is not set
# CONFIG_XENO_OPT_DEBUG_REGISTRY is not set
# CONFIG_XENO_OPT_DEBUG_TIMERS is not set
CONFIG_XENO_OPT_WATCHDOG=3Dy
CONFIG_XENO_OPT_WATCHDOG_TIMEOUT=3D4
# CONFIG_XENO_OPT_SHIRQ is not set

#
# Timing
#
# CONFIG_XENO_OPT_TIMING_PERIODIC is not set
CONFIG_XENO_OPT_TIMING_SCHEDLAT=3D0

#
# Scalability
#
CONFIG_XENO_OPT_SCALABLE_SCHED=3Dy
CONFIG_XENO_OPT_TIMER_LIST=3Dy
# CONFIG_XENO_OPT_TIMER_HEAP is not set
# CONFIG_XENO_OPT_TIMER_WHEEL is not set

#
# Machine
#
CONFIG_XENO_HW_FPU=3Dy

#
# NMI watchdog
#
# CONFIG_XENO_HW_NMI_DEBUG_LATENCY is not set

#
# SMI workaround
#
# CONFIG_XENO_HW_SMI_DETECT_DISABLE is not set
CONFIG_XENO_HW_SMI_DETECT=3Dy
CONFIG_XENO_HW_SMI_WORKAROUND=3Dy
CONFIG_XENO_HW_SMI_ALL=3Dy

#
# Interfaces
#
CONFIG_XENO_SKIN_NATIVE=3Dy
CONFIG_XENO_OPT_NATIVE_PERIOD=3D0
CONFIG_XENO_OPT_NATIVE_PIPE=3Dy
CONFIG_XENO_OPT_NATIVE_PIPE_BUFSZ=3D1024
CONFIG_XENO_OPT_NATIVE_REGISTRY=3Dy
CONFIG_XENO_OPT_NATIVE_SEM=3Dy
CONFIG_XENO_OPT_NATIVE_EVENT=3Dy
CONFIG_XENO_OPT_NATIVE_MUTEX=3Dy
CONFIG_XENO_OPT_NATIVE_COND=3Dy
CONFIG_XENO_OPT_NATIVE_QUEUE=3Dy
CONFIG_XENO_OPT_NATIVE_HEAP=3Dy
CONFIG_XENO_OPT_NATIVE_ALARM=3Dy
CONFIG_XENO_OPT_NATIVE_MPS=3Dy
# CONFIG_XENO_OPT_NATIVE_INTR is not set
CONFIG_XENO_OPT_DEBUG_NATIVE=3Dy
CONFIG_XENO_SKIN_POSIX=3Dy
CONFIG_XENO_OPT_POSIX_PERIOD=3D0
# CONFIG_XENO_OPT_POSIX_SHM is not set
# CONFIG_XENO_OPT_POSIX_INTR is not set
# CONFIG_XENO_OPT_POSIX_SELECT is not set
CONFIG_XENO_OPT_DEBUG_POSIX=3Dy
# CONFIG_XENO_SKIN_PSOS is not set
# CONFIG_XENO_SKIN_UITRON is not set
# CONFIG_XENO_SKIN_VRTX is not set
# CONFIG_XENO_SKIN_VXWORKS is not set
# CONFIG_XENO_SKIN_RTAI is not set
CONFIG_XENO_SKIN_RTDM=3Dy
CONFIG_XENO_OPT_RTDM_PERIOD=3D0
CONFIG_XENO_OPT_RTDM_FILDES=3D128
# CONFIG_XENO_OPT_RTDM_SELECT is not set
CONFIG_XENO_OPT_DEBUG_RTDM=3Dy

#
# Drivers
#

#
# Serial drivers
#
# CONFIG_XENO_DRIVERS_16550A is not set

#
# Testing drivers
#
CONFIG_XENO_KLATENCY_MODULE=3Dm
CONFIG_XENO_DRIVERS_TIMERBENCH=3Dm
CONFIG_XENO_DRIVERS_KLATENCY=3Dm
CONFIG_XENO_DRIVERS_IRQBENCH=3Dm
CONFIG_XENO_DRIVERS_SWITCHTEST=3Dm

#
# CAN drivers
#
# CONFIG_XENO_DRIVERS_CAN is not set

#
# Processor type and features
#
CONFIG_TICK_ONESHOT=3Dy
CONFIG_NO_HZ=3Dy
CONFIG_HIGH_RES_TIMERS=3Dy
CONFIG_GENERIC_CLOCKEVENTS_BUILD=3Dy
CONFIG_SMP=3Dy
CONFIG_X86_FIND_SMP_CONFIG=3Dy
CONFIG_X86_MPPARSE=3Dy
CONFIG_X86_PC=3Dy
# CONFIG_X86_ELAN is not set
# CONFIG_X86_VOYAGER is not set
# CONFIG_X86_GENERICARCH is not set
# CONFIG_X86_VSMP is not set
# CONFIG_X86_RDC321X is not set
CONFIG_SCHED_NO_NO_OMIT_FRAME_POINTER=3Dy
# CONFIG_MEMTEST is not set
# CONFIG_M386 is not set
# CONFIG_M486 is not set
# CONFIG_M586 is not set
# CONFIG_M586TSC is not set
# CONFIG_M586MMX is not set
# CONFIG_M686 is not set
# CONFIG_MPENTIUMII is not set
# CONFIG_MPENTIUMIII is not set
# CONFIG_MPENTIUMM is not set
CONFIG_MPENTIUM4=3Dy
# CONFIG_MK6 is not set
# CONFIG_MK7 is not set
# CONFIG_MK8 is not set
# CONFIG_MCRUSOE is not set
# CONFIG_MEFFICEON is not set
# CONFIG_MWINCHIPC6 is not set
# CONFIG_MWINCHIP2 is not set
# CONFIG_MWINCHIP3D is not set
# CONFIG_MGEODEGX1 is not set
# CONFIG_MGEODE_LX is not set
# CONFIG_MCYRIXIII is not set
# CONFIG_MVIAC3_2 is not set
# CONFIG_MVIAC7 is not set
# CONFIG_MPSC is not set
# CONFIG_MCORE2 is not set
# CONFIG_GENERIC_CPU is not set
CONFIG_X86_GENERIC=3Dy
CONFIG_X86_CPU=3Dy
CONFIG_X86_CMPXCHG=3Dy
CONFIG_X86_L1_CACHE_SHIFT=3D7
CONFIG_X86_XADD=3Dy
CONFIG_X86_WP_WORKS_OK=3Dy
CONFIG_X86_INVLPG=3Dy
CONFIG_X86_BSWAP=3Dy
CONFIG_X86_POPAD_OK=3Dy
CONFIG_X86_INTEL_USERCOPY=3Dy
CONFIG_X86_USE_PPRO_CHECKSUM=3Dy
CONFIG_X86_TSC=3Dy
CONFIG_X86_CMOV=3Dy
CONFIG_X86_MINIMUM_CPU_FAMILY=3D4
CONFIG_X86_DEBUGCTLMSR=3Dy
CONFIG_HPET_TIMER=3Dy
CONFIG_HPET_EMULATE_RTC=3Dy
CONFIG_DMI=3Dy
# CONFIG_IOMMU_HELPER is not set
CONFIG_NR_CPUS=3D2
CONFIG_SCHED_SMT=3Dy
CONFIG_SCHED_MC=3Dy
# CONFIG_PREEMPT_NONE is not set
CONFIG_PREEMPT_VOLUNTARY=3Dy
# CONFIG_PREEMPT is not set
CONFIG_IPIPE=3Dy
CONFIG_IPIPE_DOMAINS=3D4
CONFIG_IPIPE_COMPAT=3Dy
CONFIG_IPIPE_DELAYED_ATOMICSW=3Dy
CONFIG_X86_LOCAL_APIC=3Dy
CONFIG_X86_IO_APIC=3Dy
CONFIG_X86_MCE=3Dy
CONFIG_X86_MCE_NONFATAL=3Dy
CONFIG_X86_MCE_P4THERMAL=3Dy
CONFIG_VM86=3Dy
# CONFIG_TOSHIBA is not set
# CONFIG_I8K is not set
CONFIG_X86_REBOOTFIXUPS=3Dy
CONFIG_MICROCODE=3Dy
CONFIG_MICROCODE_OLD_INTERFACE=3Dy
CONFIG_X86_MSR=3Dy
CONFIG_X86_CPUID=3Dy
# CONFIG_NOHIGHMEM is not set
CONFIG_HIGHMEM4G=3Dy
# CONFIG_HIGHMEM64G is not set
CONFIG_PAGE_OFFSET=3D0xC0000000
CONFIG_HIGHMEM=3Dy
CONFIG_ARCH_FLATMEM_ENABLE=3Dy
CONFIG_ARCH_SPARSEMEM_ENABLE=3Dy
CONFIG_ARCH_SELECT_MEMORY_MODEL=3Dy
CONFIG_SELECT_MEMORY_MODEL=3Dy
CONFIG_FLATMEM_MANUAL=3Dy
# CONFIG_DISCONTIGMEM_MANUAL is not set
# CONFIG_SPARSEMEM_MANUAL is not set
CONFIG_FLATMEM=3Dy
CONFIG_FLAT_NODE_MEM_MAP=3Dy
CONFIG_SPARSEMEM_STATIC=3Dy
# CONFIG_SPARSEMEM_VMEMMAP_ENABLE is not set
CONFIG_PAGEFLAGS_EXTENDED=3Dy
CONFIG_SPLIT_PTLOCK_CPUS=3D4
CONFIG_RESOURCES_64BIT=3Dy
CONFIG_ZONE_DMA_FLAG=3D1
CONFIG_BOUNCE=3Dy
CONFIG_VIRT_TO_BUS=3Dy
# CONFIG_HIGHPTE is not set
# CONFIG_X86_RESERVE_LOW_64K is not set
# CONFIG_MATH_EMULATION is not set
CONFIG_MTRR=3Dy
# CONFIG_MTRR_SANITIZER is not set
# CONFIG_X86_PAT is not set
# CONFIG_EFI is not set
# CONFIG_IRQBALANCE is not set
CONFIG_SECCOMP=3Dy
# CONFIG_HZ_100 is not set
CONFIG_HZ_250=3Dy
# CONFIG_HZ_300 is not set
# CONFIG_HZ_1000 is not set
CONFIG_HZ=3D250
CONFIG_SCHED_HRTICK=3Dy
# CONFIG_KEXEC is not set
# CONFIG_CRASH_DUMP is not set
CONFIG_PHYSICAL_START=3D0x100000
# CONFIG_RELOCATABLE is not set
CONFIG_PHYSICAL_ALIGN=3D0x100000
CONFIG_HOTPLUG_CPU=3Dy
CONFIG_COMPAT_VDSO=3Dy
CONFIG_ARCH_ENABLE_MEMORY_HOTPLUG=3Dy

#
# Power management options
#
CONFIG_PM=3Dy
# CONFIG_PM_DEBUG is not set
# CONFIG_SUSPEND is not set
# CONFIG_HIBERNATION is not set
CONFIG_ACPI=3Dy
CONFIG_ACPI_PROCFS=3Dy
CONFIG_ACPI_PROCFS_POWER=3Dy
CONFIG_ACPI_SYSFS_POWER=3Dy
CONFIG_ACPI_PROC_EVENT=3Dy
CONFIG_ACPI_AC=3Dy
CONFIG_ACPI_BATTERY=3Dy
CONFIG_ACPI_BUTTON=3Dy
CONFIG_ACPI_FAN=3Dy
CONFIG_ACPI_DOCK=3Dy
# CONFIG_ACPI_BAY is not set
# CONFIG_ACPI_PROCESSOR is not set
# CONFIG_ACPI_WMI is not set
# CONFIG_ACPI_ASUS is not set
# CONFIG_ACPI_TOSHIBA is not set
# CONFIG_ACPI_CUSTOM_DSDT is not set
CONFIG_ACPI_BLACKLIST_YEAR=3D2001
CONFIG_ACPI_DEBUG=3Dy
# CONFIG_ACPI_DEBUG_FUNC_TRACE is not set
CONFIG_ACPI_EC=3Dy
# CONFIG_ACPI_PCI_SLOT is not set
CONFIG_ACPI_POWER=3Dy
CONFIG_ACPI_SYSTEM=3Dy
CONFIG_X86_PM_TIMER=3Dy
CONFIG_ACPI_CONTAINER=3Dy
# CONFIG_ACPI_SBS is not set

#
# CPU Frequency scaling
#
# CONFIG_CPU_FREQ is not set
CONFIG_CPU_IDLE=3Dy
CONFIG_CPU_IDLE_GOV_LADDER=3Dy
CONFIG_CPU_IDLE_GOV_MENU=3Dy

#
# Bus options (PCI etc.)
#
CONFIG_PCI=3Dy
# CONFIG_PCI_GOBIOS is not set
# CONFIG_PCI_GOMMCONFIG is not set
# CONFIG_PCI_GODIRECT is not set
# CONFIG_PCI_GOOLPC is not set
CONFIG_PCI_GOANY=3Dy
CONFIG_PCI_BIOS=3Dy
CONFIG_PCI_DIRECT=3Dy
CONFIG_PCI_MMCONFIG=3Dy
CONFIG_PCI_DOMAINS=3Dy
# CONFIG_PCIEPORTBUS is not set
CONFIG_ARCH_SUPPORTS_MSI=3Dy
CONFIG_PCI_MSI=3Dy
CONFIG_PCI_LEGACY=3Dy
# CONFIG_PCI_DEBUG is not set
# CONFIG_HT_IRQ is not set
CONFIG_ISA_DMA_API=3Dy
# CONFIG_ISA is not set
# CONFIG_MCA is not set
# CONFIG_SCx200 is not set
# CONFIG_OLPC is not set
# CONFIG_PCCARD is not set
# CONFIG_HOTPLUG_PCI is not set

#
# Executable file formats / Emulations
#
CONFIG_BINFMT_ELF=3Dy
# CONFIG_BINFMT_AOUT is not set
# CONFIG_BINFMT_MISC is not set
CONFIG_NET=3Dy

#
# Networking options
#
CONFIG_PACKET=3Dy
# CONFIG_PACKET_MMAP is not set
CONFIG_UNIX=3Dy
CONFIG_XFRM=3Dy
# CONFIG_XFRM_USER is not set
# CONFIG_XFRM_SUB_POLICY is not set
# CONFIG_XFRM_MIGRATE is not set
# CONFIG_XFRM_STATISTICS is not set
# CONFIG_NET_KEY is not set
CONFIG_INET=3Dy
CONFIG_IP_MULTICAST=3Dy
# CONFIG_IP_ADVANCED_ROUTER is not set
CONFIG_IP_FIB_HASH=3Dy
CONFIG_IP_PNP=3Dy
CONFIG_IP_PNP_DHCP=3Dy
# CONFIG_IP_PNP_BOOTP is not set
# CONFIG_IP_PNP_RARP is not set
# CONFIG_NET_IPIP is not set
# CONFIG_NET_IPGRE is not set
# CONFIG_IP_MROUTE is not set
# CONFIG_ARPD is not set
# CONFIG_SYN_COOKIES is not set
# CONFIG_INET_AH is not set
# CONFIG_INET_ESP is not set
# CONFIG_INET_IPCOMP is not set
# CONFIG_INET_XFRM_TUNNEL is not set
CONFIG_INET_TUNNEL=3Dy
CONFIG_INET_XFRM_MODE_TRANSPORT=3Dy
CONFIG_INET_XFRM_MODE_TUNNEL=3Dy
# CONFIG_INET_XFRM_MODE_BEET is not set
# CONFIG_INET_LRO is not set
CONFIG_INET_DIAG=3Dy
CONFIG_INET_TCP_DIAG=3Dy
# CONFIG_TCP_CONG_ADVANCED is not set
CONFIG_TCP_CONG_CUBIC=3Dy
CONFIG_DEFAULT_TCP_CONG=3D"cubic"
# CONFIG_TCP_MD5SIG is not set
# CONFIG_IP_VS is not set
CONFIG_IPV6=3Dy
# CONFIG_IPV6_PRIVACY is not set
# CONFIG_IPV6_ROUTER_PREF is not set
# CONFIG_IPV6_OPTIMISTIC_DAD is not set
# CONFIG_INET6_AH is not set
# CONFIG_INET6_ESP is not set
# CONFIG_INET6_IPCOMP is not set
# CONFIG_IPV6_MIP6 is not set
# CONFIG_INET6_XFRM_TUNNEL is not set
# CONFIG_INET6_TUNNEL is not set
CONFIG_INET6_XFRM_MODE_TRANSPORT=3Dy
CONFIG_INET6_XFRM_MODE_TUNNEL=3Dy
# CONFIG_INET6_XFRM_MODE_BEET is not set
# CONFIG_INET6_XFRM_MODE_ROUTEOPTIMIZATION is not set
CONFIG_IPV6_SIT=3Dy
CONFIG_IPV6_NDISC_NODETYPE=3Dy
# CONFIG_IPV6_TUNNEL is not set
# CONFIG_IPV6_MULTIPLE_TABLES is not set
# CONFIG_IPV6_MROUTE is not set
# CONFIG_NETWORK_SECMARK is not set
CONFIG_NETFILTER=3Dy
# CONFIG_NETFILTER_DEBUG is not set
CONFIG_NETFILTER_ADVANCED=3Dy

#
# Core Netfilter Configuration
#
CONFIG_NETFILTER_NETLINK=3Dm
# CONFIG_NETFILTER_NETLINK_QUEUE is not set
CONFIG_NETFILTER_NETLINK_LOG=3Dm
# CONFIG_NF_CONNTRACK is not set
# CONFIG_NETFILTER_XTABLES is not set

#
# IP: Netfilter Configuration
#
# CONFIG_IP_NF_QUEUE is not set
# CONFIG_IP_NF_IPTABLES is not set
# CONFIG_IP_NF_ARPTABLES is not set

#
# IPv6: Netfilter Configuration
#
# CONFIG_IP6_NF_QUEUE is not set
# CONFIG_IP6_NF_IPTABLES is not set
# CONFIG_IP_DCCP is not set
# CONFIG_IP_SCTP is not set
# CONFIG_TIPC is not set
# CONFIG_ATM is not set
# CONFIG_BRIDGE is not set
# CONFIG_VLAN_8021Q is not set
# CONFIG_DECNET is not set
# CONFIG_LLC2 is not set
# CONFIG_IPX is not set
# CONFIG_ATALK is not set
# CONFIG_X25 is not set
# CONFIG_LAPB is not set
# CONFIG_ECONET is not set
# CONFIG_WAN_ROUTER is not set
# CONFIG_NET_SCHED is not set

#
# Network testing
#
# CONFIG_NET_PKTGEN is not set
# CONFIG_NET_TCPPROBE is not set
# CONFIG_HAMRADIO is not set
# CONFIG_CAN is not set
# CONFIG_IRDA is not set
# CONFIG_BT is not set
# CONFIG_AF_RXRPC is not set

#
# Wireless
#
# CONFIG_CFG80211 is not set
# CONFIG_WIRELESS_EXT is not set
# CONFIG_MAC80211 is not set
# CONFIG_IEEE80211 is not set
# CONFIG_RFKILL is not set
# CONFIG_NET_9P is not set

#
# Device Drivers
#

#
# Generic Driver Options
#
CONFIG_UEVENT_HELPER_PATH=3D"/sbin/hotplug"
CONFIG_STANDALONE=3Dy
CONFIG_PREVENT_FIRMWARE_BUILD=3Dy
CONFIG_FW_LOADER=3Dy
# CONFIG_FIRMWARE_IN_KERNEL is not set
CONFIG_EXTRA_FIRMWARE=3D""
# CONFIG_DEBUG_DRIVER is not set
# CONFIG_DEBUG_DEVRES is not set
# CONFIG_SYS_HYPERVISOR is not set
# CONFIG_CONNECTOR is not set
# CONFIG_MTD is not set
# CONFIG_PARPORT is not set
CONFIG_PNP=3Dy
# CONFIG_PNP_DEBUG is not set

#
# Protocols
#
CONFIG_PNPACPI=3Dy
CONFIG_BLK_DEV=3Dy
# CONFIG_BLK_DEV_FD is not set
# CONFIG_BLK_CPQ_DA is not set
# CONFIG_BLK_CPQ_CISS_DA is not set
# CONFIG_BLK_DEV_DAC960 is not set
# CONFIG_BLK_DEV_UMEM is not set
# CONFIG_BLK_DEV_COW_COMMON is not set
CONFIG_BLK_DEV_LOOP=3Dy
# CONFIG_BLK_DEV_CRYPTOLOOP is not set
# CONFIG_BLK_DEV_NBD is not set
# CONFIG_BLK_DEV_SX8 is not set
# CONFIG_BLK_DEV_UB is not set
CONFIG_BLK_DEV_RAM=3Dy
CONFIG_BLK_DEV_RAM_COUNT=3D16
CONFIG_BLK_DEV_RAM_SIZE=3D4096
# CONFIG_BLK_DEV_XIP is not set
# CONFIG_CDROM_PKTCDVD is not set
# CONFIG_ATA_OVER_ETH is not set
# CONFIG_BLK_DEV_HD is not set
# CONFIG_MISC_DEVICES is not set
CONFIG_HAVE_IDE=3Dy
# CONFIG_IDE is not set

#
# SCSI device support
#
# CONFIG_RAID_ATTRS is not set
CONFIG_SCSI=3Dy
CONFIG_SCSI_DMA=3Dy
# CONFIG_SCSI_TGT is not set
CONFIG_SCSI_NETLINK=3Dy
# CONFIG_SCSI_PROC_FS is not set

#
# SCSI support type (disk, tape, CD-ROM)
#
CONFIG_BLK_DEV_SD=3Dy
# CONFIG_CHR_DEV_ST is not set
# CONFIG_CHR_DEV_OSST is not set
CONFIG_BLK_DEV_SR=3Dy
# CONFIG_BLK_DEV_SR_VENDOR is not set
CONFIG_CHR_DEV_SG=3Dy
# CONFIG_CHR_DEV_SCH is not set

#
# Some SCSI devices (e.g. CD jukebox) support multiple LUNs
#
# CONFIG_SCSI_MULTI_LUN is not set
# CONFIG_SCSI_CONSTANTS is not set
# CONFIG_SCSI_LOGGING is not set
# CONFIG_SCSI_SCAN_ASYNC is not set
CONFIG_SCSI_WAIT_SCAN=3Dm

#
# SCSI Transports
#
CONFIG_SCSI_SPI_ATTRS=3Dy
CONFIG_SCSI_FC_ATTRS=3Dy
# CONFIG_SCSI_ISCSI_ATTRS is not set
# CONFIG_SCSI_SAS_LIBSAS is not set
# CONFIG_SCSI_SRP_ATTRS is not set
CONFIG_SCSI_LOWLEVEL=3Dy
# CONFIG_ISCSI_TCP is not set
CONFIG_BLK_DEV_3W_XXXX_RAID=3Dy
# CONFIG_SCSI_3W_9XXX is not set
# CONFIG_SCSI_ACARD is not set
# CONFIG_SCSI_AACRAID is not set
CONFIG_SCSI_AIC7XXX=3Dy
CONFIG_AIC7XXX_CMDS_PER_DEVICE=3D32
CONFIG_AIC7XXX_RESET_DELAY_MS=3D5000
CONFIG_AIC7XXX_DEBUG_ENABLE=3Dy
CONFIG_AIC7XXX_DEBUG_MASK=3D0
CONFIG_AIC7XXX_REG_PRETTY_PRINT=3Dy
# CONFIG_SCSI_AIC7XXX_OLD is not set
CONFIG_SCSI_AIC79XX=3Dy
CONFIG_AIC79XX_CMDS_PER_DEVICE=3D32
CONFIG_AIC79XX_RESET_DELAY_MS=3D4000
# CONFIG_AIC79XX_DEBUG_ENABLE is not set
CONFIG_AIC79XX_DEBUG_MASK=3D0
# CONFIG_AIC79XX_REG_PRETTY_PRINT is not set
# CONFIG_SCSI_AIC94XX is not set
# CONFIG_SCSI_DPT_I2O is not set
# CONFIG_SCSI_ADVANSYS is not set
# CONFIG_SCSI_ARCMSR is not set
# CONFIG_MEGARAID_NEWGEN is not set
# CONFIG_MEGARAID_LEGACY is not set
# CONFIG_MEGARAID_SAS is not set
# CONFIG_SCSI_HPTIOP is not set
# CONFIG_SCSI_BUSLOGIC is not set
# CONFIG_SCSI_DMX3191D is not set
# CONFIG_SCSI_EATA is not set
# CONFIG_SCSI_FUTURE_DOMAIN is not set
# CONFIG_SCSI_GDTH is not set
# CONFIG_SCSI_IPS is not set
# CONFIG_SCSI_INITIO is not set
# CONFIG_SCSI_INIA100 is not set
# CONFIG_SCSI_MVSAS is not set
# CONFIG_SCSI_STEX is not set
# CONFIG_SCSI_SYM53C8XX_2 is not set
# CONFIG_SCSI_IPR is not set
# CONFIG_SCSI_QLOGIC_1280 is not set
# CONFIG_SCSI_QLA_FC is not set
# CONFIG_SCSI_QLA_ISCSI is not set
# CONFIG_SCSI_LPFC is not set
# CONFIG_SCSI_DC395x is not set
# CONFIG_SCSI_DC390T is not set
# CONFIG_SCSI_NSP32 is not set
# CONFIG_SCSI_DEBUG is not set
# CONFIG_SCSI_SRP is not set
# CONFIG_SCSI_DH is not set
CONFIG_ATA=3Dy
# CONFIG_ATA_NONSTANDARD is not set
CONFIG_ATA_ACPI=3Dy
CONFIG_SATA_PMP=3Dy
CONFIG_SATA_AHCI=3Dy
# CONFIG_SATA_SIL24 is not set
CONFIG_ATA_SFF=3Dy
# CONFIG_SATA_SVW is not set
CONFIG_ATA_PIIX=3Dy
# CONFIG_SATA_MV is not set
# CONFIG_SATA_NV is not set
# CONFIG_PDC_ADMA is not set
# CONFIG_SATA_QSTOR is not set
# CONFIG_SATA_PROMISE is not set
# CONFIG_SATA_SX4 is not set
# CONFIG_SATA_SIL is not set
# CONFIG_SATA_SIS is not set
# CONFIG_SATA_ULI is not set
# CONFIG_SATA_VIA is not set
# CONFIG_SATA_VITESSE is not set
# CONFIG_SATA_INIC162X is not set
# CONFIG_PATA_ACPI is not set
# CONFIG_PATA_ALI is not set
# CONFIG_PATA_AMD is not set
# CONFIG_PATA_ARTOP is not set
# CONFIG_PATA_ATIIXP is not set
# CONFIG_PATA_CMD640_PCI is not set
# CONFIG_PATA_CMD64X is not set
# CONFIG_PATA_CS5520 is not set
# CONFIG_PATA_CS5530 is not set
# CONFIG_PATA_CS5535 is not set
# CONFIG_PATA_CS5536 is not set
# CONFIG_PATA_CYPRESS is not set
# CONFIG_PATA_EFAR is not set
# CONFIG_ATA_GENERIC is not set
# CONFIG_PATA_HPT366 is not set
# CONFIG_PATA_HPT37X is not set
# CONFIG_PATA_HPT3X2N is not set
# CONFIG_PATA_HPT3X3 is not set
# CONFIG_PATA_IT821X is not set
# CONFIG_PATA_IT8213 is not set
# CONFIG_PATA_JMICRON is not set
# CONFIG_PATA_TRIFLEX is not set
# CONFIG_PATA_MARVELL is not set
CONFIG_PATA_MPIIX=3Dy
CONFIG_PATA_OLDPIIX=3Dy
# CONFIG_PATA_NETCELL is not set
# CONFIG_PATA_NINJA32 is not set
# CONFIG_PATA_NS87410 is not set
# CONFIG_PATA_NS87415 is not set
# CONFIG_PATA_OPTI is not set
# CONFIG_PATA_OPTIDMA is not set
# CONFIG_PATA_PDC_OLD is not set
# CONFIG_PATA_RADISYS is not set
# CONFIG_PATA_RZ1000 is not set
# CONFIG_PATA_SC1200 is not set
# CONFIG_PATA_SERVERWORKS is not set
# CONFIG_PATA_PDC2027X is not set
# CONFIG_PATA_SIL680 is not set
# CONFIG_PATA_SIS is not set
# CONFIG_PATA_VIA is not set
# CONFIG_PATA_WINBOND is not set
# CONFIG_PATA_SCH is not set
# CONFIG_MD is not set
# CONFIG_FUSION is not set

#
# IEEE 1394 (FireWire) support
#

#
# Enable only one of the two stacks, unless you know what you are doing
#
# CONFIG_FIREWIRE is not set
CONFIG_IEEE1394=3Dy
CONFIG_IEEE1394_OHCI1394=3Dy
# CONFIG_IEEE1394_PCILYNX is not set
# CONFIG_IEEE1394_SBP2 is not set
# CONFIG_IEEE1394_ETH1394_ROM_ENTRY is not set
# CONFIG_IEEE1394_ETH1394 is not set
CONFIG_IEEE1394_RAWIO=3Dy
# CONFIG_IEEE1394_VIDEO1394 is not set
# CONFIG_IEEE1394_DV1394 is not set
# CONFIG_IEEE1394_VERBOSEDEBUG is not set
# CONFIG_I2O is not set
# CONFIG_MACINTOSH_DRIVERS is not set
CONFIG_NETDEVICES=3Dy
# CONFIG_DUMMY is not set
# CONFIG_BONDING is not set
# CONFIG_MACVLAN is not set
# CONFIG_EQUALIZER is not set
# CONFIG_TUN is not set
# CONFIG_VETH is not set
# CONFIG_NET_SB1000 is not set
# CONFIG_ARCNET is not set
# CONFIG_PHYLIB is not set
CONFIG_NET_ETHERNET=3Dy
CONFIG_MII=3Dy
# CONFIG_HAPPYMEAL is not set
# CONFIG_SUNGEM is not set
# CONFIG_CASSINI is not set
# CONFIG_NET_VENDOR_3COM is not set
# CONFIG_NET_TULIP is not set
# CONFIG_HP100 is not set
# CONFIG_IBM_NEW_EMAC_ZMII is not set
# CONFIG_IBM_NEW_EMAC_RGMII is not set
# CONFIG_IBM_NEW_EMAC_TAH is not set
# CONFIG_IBM_NEW_EMAC_EMAC4 is not set
CONFIG_NET_PCI=3Dy
# CONFIG_PCNET32 is not set
# CONFIG_AMD8111_ETH is not set
# CONFIG_ADAPTEC_STARFIRE is not set
# CONFIG_B44 is not set
# CONFIG_FORCEDETH is not set
# CONFIG_EEPRO100 is not set
# CONFIG_E100 is not set
# CONFIG_FEALNX is not set
# CONFIG_NATSEMI is not set
# CONFIG_NE2K_PCI is not set
# CONFIG_8139CP is not set
CONFIG_8139TOO=3Dy
# CONFIG_8139TOO_PIO is not set
# CONFIG_8139TOO_TUNE_TWISTER is not set
# CONFIG_8139TOO_8129 is not set
# CONFIG_8139_OLD_RX_RESET is not set
# CONFIG_R6040 is not set
# CONFIG_SIS900 is not set
# CONFIG_EPIC100 is not set
# CONFIG_SUNDANCE is not set
# CONFIG_TLAN is not set
# CONFIG_VIA_RHINE is not set
# CONFIG_SC92031 is not set
CONFIG_NETDEV_1000=3Dy
# CONFIG_ACENIC is not set
# CONFIG_DL2K is not set
CONFIG_E1000=3Dy
# CONFIG_E1000_DISABLE_PACKET_SPLIT is not set
# CONFIG_E1000E is not set
# CONFIG_IP1000 is not set
# CONFIG_IGB is not set
# CONFIG_NS83820 is not set
# CONFIG_HAMACHI is not set
# CONFIG_YELLOWFIN is not set
# CONFIG_R8169 is not set
# CONFIG_SIS190 is not set
# CONFIG_SKGE is not set
# CONFIG_SKY2 is not set
# CONFIG_VIA_VELOCITY is not set
# CONFIG_TIGON3 is not set
# CONFIG_BNX2 is not set
# CONFIG_QLA3XXX is not set
# CONFIG_ATL1 is not set
# CONFIG_ATL1E is not set
# CONFIG_NETDEV_10000 is not set
# CONFIG_TR is not set

#
# Wireless LAN
#
# CONFIG_WLAN_PRE80211 is not set
# CONFIG_WLAN_80211 is not set
# CONFIG_IWLWIFI_LEDS is not set

#
# USB Network Adapters
#
# CONFIG_USB_CATC is not set
# CONFIG_USB_KAWETH is not set
# CONFIG_USB_PEGASUS is not set
# CONFIG_USB_RTL8150 is not set
# CONFIG_USB_USBNET is not set
# CONFIG_WAN is not set
# CONFIG_FDDI is not set
# CONFIG_HIPPI is not set
# CONFIG_PPP is not set
# CONFIG_SLIP is not set
# CONFIG_NET_FC is not set
# CONFIG_NETCONSOLE is not set
# CONFIG_NETPOLL is not set
# CONFIG_NET_POLL_CONTROLLER is not set
# CONFIG_ISDN is not set
# CONFIG_PHONE is not set

#
# Input device support
#
CONFIG_INPUT=3Dy
# CONFIG_INPUT_FF_MEMLESS is not set
# CONFIG_INPUT_POLLDEV is not set

#
# Userland interfaces
#
CONFIG_INPUT_MOUSEDEV=3Dy
CONFIG_INPUT_MOUSEDEV_PSAUX=3Dy
CONFIG_INPUT_MOUSEDEV_SCREEN_X=3D1024
CONFIG_INPUT_MOUSEDEV_SCREEN_Y=3D768
# CONFIG_INPUT_JOYDEV is not set
CONFIG_INPUT_EVDEV=3Dy
# CONFIG_INPUT_EVBUG is not set

#
# Input Device Drivers
#
CONFIG_INPUT_KEYBOARD=3Dy
CONFIG_KEYBOARD_ATKBD=3Dy
# CONFIG_KEYBOARD_SUNKBD is not set
# CONFIG_KEYBOARD_LKKBD is not set
# CONFIG_KEYBOARD_XTKBD is not set
# CONFIG_KEYBOARD_NEWTON is not set
# CONFIG_KEYBOARD_STOWAWAY is not set
CONFIG_INPUT_MOUSE=3Dy
CONFIG_MOUSE_PS2=3Dy
CONFIG_MOUSE_PS2_ALPS=3Dy
CONFIG_MOUSE_PS2_LOGIPS2PP=3Dy
CONFIG_MOUSE_PS2_SYNAPTICS=3Dy
CONFIG_MOUSE_PS2_LIFEBOOK=3Dy
CONFIG_MOUSE_PS2_TRACKPOINT=3Dy
# CONFIG_MOUSE_PS2_TOUCHKIT is not set
# CONFIG_MOUSE_SERIAL is not set
# CONFIG_MOUSE_APPLETOUCH is not set
# CONFIG_MOUSE_BCM5974 is not set
# CONFIG_MOUSE_VSXXXAA is not set
# CONFIG_INPUT_JOYSTICK is not set
# CONFIG_INPUT_TABLET is not set
# CONFIG_INPUT_TOUCHSCREEN is not set
# CONFIG_INPUT_MISC is not set

#
# Hardware I/O ports
#
CONFIG_SERIO=3Dy
CONFIG_SERIO_I8042=3Dy
# CONFIG_SERIO_SERPORT is not set
# CONFIG_SERIO_CT82C710 is not set
# CONFIG_SERIO_PCIPS2 is not set
CONFIG_SERIO_LIBPS2=3Dy
# CONFIG_SERIO_RAW is not set
# CONFIG_GAMEPORT is not set

#
# Character devices
#
CONFIG_VT=3Dy
CONFIG_CONSOLE_TRANSLATIONS=3Dy
CONFIG_VT_CONSOLE=3Dy
CONFIG_HW_CONSOLE=3Dy
# CONFIG_VT_HW_CONSOLE_BINDING is not set
CONFIG_DEVKMEM=3Dy
# CONFIG_SERIAL_NONSTANDARD is not set
# CONFIG_NOZOMI is not set

#
# Serial drivers
#
CONFIG_SERIAL_8250=3Dy
CONFIG_SERIAL_8250_CONSOLE=3Dy
CONFIG_FIX_EARLYCON_MEM=3Dy
CONFIG_SERIAL_8250_PCI=3Dy
CONFIG_SERIAL_8250_PNP=3Dy
CONFIG_SERIAL_8250_NR_UARTS=3D4
CONFIG_SERIAL_8250_RUNTIME_UARTS=3D4
# CONFIG_SERIAL_8250_EXTENDED is not set

#
# Non-8250 serial port support
#
CONFIG_SERIAL_CORE=3Dy
CONFIG_SERIAL_CORE_CONSOLE=3Dy
# CONFIG_SERIAL_JSM is not set
CONFIG_UNIX98_PTYS=3Dy
CONFIG_LEGACY_PTYS=3Dy
CONFIG_LEGACY_PTY_COUNT=3D256
# CONFIG_IPMI_HANDLER is not set
# CONFIG_HW_RANDOM is not set
# CONFIG_NVRAM is not set
CONFIG_RTC=3Dy
# CONFIG_R3964 is not set
# CONFIG_APPLICOM is not set
# CONFIG_SONYPI is not set
# CONFIG_MWAVE is not set
# CONFIG_PC8736x_GPIO is not set
# CONFIG_NSC_GPIO is not set
# CONFIG_CS5535_GPIO is not set
CONFIG_RAW_DRIVER=3Dy
CONFIG_MAX_RAW_DEVS=3D256
CONFIG_HPET=3Dy
CONFIG_HPET_RTC_IRQ=3Dy
CONFIG_HPET_MMAP=3Dy
# CONFIG_HANGCHECK_TIMER is not set
# CONFIG_TCG_TPM is not set
# CONFIG_TELCLOCK is not set
CONFIG_DEVPORT=3Dy
CONFIG_I2C=3Dy
CONFIG_I2C_BOARDINFO=3Dy
# CONFIG_I2C_CHARDEV is not set
CONFIG_I2C_HELPER_AUTO=3Dy
CONFIG_I2C_ALGOBIT=3Dy

#
# I2C Hardware Bus support
#

#
# PC SMBus host controller drivers
#
# CONFIG_I2C_ALI1535 is not set
# CONFIG_I2C_ALI1563 is not set
# CONFIG_I2C_ALI15X3 is not set
# CONFIG_I2C_AMD756 is not set
# CONFIG_I2C_AMD8111 is not set
# CONFIG_I2C_I801 is not set
# CONFIG_I2C_ISCH is not set
# CONFIG_I2C_PIIX4 is not set
# CONFIG_I2C_NFORCE2 is not set
# CONFIG_I2C_SIS5595 is not set
# CONFIG_I2C_SIS630 is not set
# CONFIG_I2C_SIS96X is not set
# CONFIG_I2C_VIA is not set
# CONFIG_I2C_VIAPRO is not set

#
# I2C system bus drivers (mostly embedded / system-on-chip)
#
# CONFIG_I2C_OCORES is not set
# CONFIG_I2C_SIMTEC is not set

#
# External I2C/SMBus adapter drivers
#
# CONFIG_I2C_PARPORT_LIGHT is not set
# CONFIG_I2C_TAOS_EVM is not set
# CONFIG_I2C_TINY_USB is not set

#
# Graphics adapter I2C/DDC channel drivers
#
# CONFIG_I2C_VOODOO3 is not set

#
# Other I2C/SMBus bus drivers
#
# CONFIG_I2C_PCA_PLATFORM is not set
# CONFIG_I2C_STUB is not set
# CONFIG_SCx200_ACB is not set

#
# Miscellaneous I2C Chip support
#
# CONFIG_DS1682 is not set
# CONFIG_AT24 is not set
# CONFIG_SENSORS_EEPROM is not set
# CONFIG_SENSORS_PCF8574 is not set
# CONFIG_PCF8575 is not set
# CONFIG_SENSORS_PCA9539 is not set
# CONFIG_SENSORS_PCF8591 is not set
# CONFIG_SENSORS_MAX6875 is not set
# CONFIG_SENSORS_TSL2550 is not set
# CONFIG_I2C_DEBUG_CORE is not set
# CONFIG_I2C_DEBUG_ALGO is not set
# CONFIG_I2C_DEBUG_BUS is not set
# CONFIG_I2C_DEBUG_CHIP is not set
# CONFIG_SPI is not set
CONFIG_ARCH_WANT_OPTIONAL_GPIOLIB=3Dy
# CONFIG_GPIOLIB is not set
# CONFIG_W1 is not set
CONFIG_POWER_SUPPLY=3Dy
# CONFIG_POWER_SUPPLY_DEBUG is not set
# CONFIG_PDA_POWER is not set
# CONFIG_BATTERY_DS2760 is not set
# CONFIG_HWMON is not set
CONFIG_THERMAL=3Dy
# CONFIG_WATCHDOG is not set

#
# Sonics Silicon Backplane
#
CONFIG_SSB_POSSIBLE=3Dy
# CONFIG_SSB is not set

#
# Multifunction device drivers
#
# CONFIG_MFD_CORE is not set
# CONFIG_MFD_SM501 is not set
# CONFIG_HTC_PASIC3 is not set
# CONFIG_MFD_TMIO is not set

#
# Multimedia devices
#

#
# Multimedia core support
#
# CONFIG_VIDEO_DEV is not set
# CONFIG_DVB_CORE is not set
# CONFIG_VIDEO_MEDIA is not set

#
# Multimedia drivers
#
# CONFIG_DAB is not set

#
# Graphics support
#
CONFIG_AGP=3Dy
# CONFIG_AGP_ALI is not set
# CONFIG_AGP_ATI is not set
# CONFIG_AGP_AMD is not set
# CONFIG_AGP_AMD64 is not set
CONFIG_AGP_INTEL=3Dy
# CONFIG_AGP_NVIDIA is not set
# CONFIG_AGP_SIS is not set
# CONFIG_AGP_SWORKS is not set
# CONFIG_AGP_VIA is not set
# CONFIG_AGP_EFFICEON is not set
CONFIG_DRM=3Dm
# CONFIG_DRM_TDFX is not set
# CONFIG_DRM_R128 is not set
CONFIG_DRM_RADEON=3Dm
# CONFIG_DRM_I810 is not set
# CONFIG_DRM_I830 is not set
# CONFIG_DRM_I915 is not set
# CONFIG_DRM_MGA is not set
# CONFIG_DRM_SIS is not set
# CONFIG_DRM_VIA is not set
# CONFIG_DRM_SAVAGE is not set
# CONFIG_VGASTATE is not set
# CONFIG_VIDEO_OUTPUT_CONTROL is not set
CONFIG_FB=3Dy
# CONFIG_FIRMWARE_EDID is not set
CONFIG_FB_DDC=3Dy
CONFIG_FB_CFB_FILLRECT=3Dy
CONFIG_FB_CFB_COPYAREA=3Dy
CONFIG_FB_CFB_IMAGEBLIT=3Dy
# CONFIG_FB_CFB_REV_PIXELS_IN_BYTE is not set
# CONFIG_FB_SYS_FILLRECT is not set
# CONFIG_FB_SYS_COPYAREA is not set
# CONFIG_FB_SYS_IMAGEBLIT is not set
# CONFIG_FB_FOREIGN_ENDIAN is not set
# CONFIG_FB_SYS_FOPS is not set
# CONFIG_FB_SVGALIB is not set
# CONFIG_FB_MACMODES is not set
CONFIG_FB_BACKLIGHT=3Dy
CONFIG_FB_MODE_HELPERS=3Dy
# CONFIG_FB_TILEBLITTING is not set

#
# Frame buffer hardware drivers
#
# CONFIG_FB_CIRRUS is not set
# CONFIG_FB_PM2 is not set
# CONFIG_FB_CYBER2000 is not set
# CONFIG_FB_ARC is not set
# CONFIG_FB_ASILIANT is not set
# CONFIG_FB_IMSTT is not set
# CONFIG_FB_VGA16 is not set
CONFIG_FB_VESA=3Dy
# CONFIG_FB_EFI is not set
# CONFIG_FB_N411 is not set
# CONFIG_FB_HGA is not set
# CONFIG_FB_S1D13XXX is not set
# CONFIG_FB_NVIDIA is not set
# CONFIG_FB_RIVA is not set
# CONFIG_FB_I810 is not set
# CONFIG_FB_LE80578 is not set
# CONFIG_FB_INTEL is not set
# CONFIG_FB_MATROX is not set
CONFIG_FB_RADEON=3Dy
CONFIG_FB_RADEON_I2C=3Dy
CONFIG_FB_RADEON_BACKLIGHT=3Dy
# CONFIG_FB_RADEON_DEBUG is not set
# CONFIG_FB_ATY128 is not set
# CONFIG_FB_ATY is not set
# CONFIG_FB_S3 is not set
# CONFIG_FB_SAVAGE is not set
# CONFIG_FB_SIS is not set
# CONFIG_FB_NEOMAGIC is not set
# CONFIG_FB_KYRO is not set
# CONFIG_FB_3DFX is not set
# CONFIG_FB_VOODOO1 is not set
# CONFIG_FB_VT8623 is not set
# CONFIG_FB_CYBLA is not set
# CONFIG_FB_TRIDENT is not set
# CONFIG_FB_ARK is not set
# CONFIG_FB_PM3 is not set
# CONFIG_FB_CARMINE is not set
# CONFIG_FB_GEODE is not set
# CONFIG_FB_VIRTUAL is not set
CONFIG_BACKLIGHT_LCD_SUPPORT=3Dy
CONFIG_LCD_CLASS_DEVICE=3Dm
# CONFIG_LCD_ILI9320 is not set
# CONFIG_LCD_PLATFORM is not set
CONFIG_BACKLIGHT_CLASS_DEVICE=3Dy
# CONFIG_BACKLIGHT_CORGI is not set
# CONFIG_BACKLIGHT_PROGEAR is not set
# CONFIG_BACKLIGHT_MBP_NVIDIA is not set

#
# Display device support
#
# CONFIG_DISPLAY_SUPPORT is not set

#
# Console display driver support
#
CONFIG_VGA_CONSOLE=3Dy
CONFIG_VGACON_SOFT_SCROLLBACK=3Dy
CONFIG_VGACON_SOFT_SCROLLBACK_SIZE=3D128
CONFIG_VIDEO_SELECT=3Dy
CONFIG_DUMMY_CONSOLE=3Dy
CONFIG_FRAMEBUFFER_CONSOLE=3Dy
# CONFIG_FRAMEBUFFER_CONSOLE_DETECT_PRIMARY is not set
# CONFIG_FRAMEBUFFER_CONSOLE_ROTATION is not set
# CONFIG_FONTS is not set
CONFIG_FONT_8x8=3Dy
CONFIG_FONT_8x16=3Dy
CONFIG_LOGO=3Dy
CONFIG_LOGO_LINUX_MONO=3Dy
CONFIG_LOGO_LINUX_VGA16=3Dy
CONFIG_LOGO_LINUX_CLUT224=3Dy
CONFIG_SOUND=3Dy
# CONFIG_SND is not set
# CONFIG_SOUND_PRIME is not set
# CONFIG_HID_SUPPORT is not set
CONFIG_USB_SUPPORT=3Dy
CONFIG_USB_ARCH_HAS_HCD=3Dy
CONFIG_USB_ARCH_HAS_OHCI=3Dy
CONFIG_USB_ARCH_HAS_EHCI=3Dy
CONFIG_USB=3Dy
# CONFIG_USB_DEBUG is not set
# CONFIG_USB_ANNOUNCE_NEW_DEVICES is not set

#
# Miscellaneous USB options
#
CONFIG_USB_DEVICEFS=3Dy
# CONFIG_USB_DEVICE_CLASS is not set
# CONFIG_USB_DYNAMIC_MINORS is not set
# CONFIG_USB_SUSPEND is not set
# CONFIG_USB_OTG is not set
CONFIG_USB_MON=3Dy

#
# USB Host Controller Drivers
#
# CONFIG_USB_C67X00_HCD is not set
CONFIG_USB_EHCI_HCD=3Dy
# CONFIG_USB_EHCI_ROOT_HUB_TT is not set
# CONFIG_USB_EHCI_TT_NEWSCHED is not set
# CONFIG_USB_ISP116X_HCD is not set
# CONFIG_USB_ISP1760_HCD is not set
CONFIG_USB_OHCI_HCD=3Dy
# CONFIG_USB_OHCI_BIG_ENDIAN_DESC is not set
# CONFIG_USB_OHCI_BIG_ENDIAN_MMIO is not set
CONFIG_USB_OHCI_LITTLE_ENDIAN=3Dy
CONFIG_USB_UHCI_HCD=3Dy
# CONFIG_USB_SL811_HCD is not set
# CONFIG_USB_R8A66597_HCD is not set

#
# USB Device Class drivers
#
# CONFIG_USB_ACM is not set
CONFIG_USB_PRINTER=3Dy
# CONFIG_USB_WDM is not set

#
# NOTE: USB_STORAGE enables SCSI, and 'SCSI disk support'
#

#
# may also be needed; see USB_STORAGE Help for more information
#
CONFIG_USB_STORAGE=3Dy
# CONFIG_USB_STORAGE_DEBUG is not set
# CONFIG_USB_STORAGE_DATAFAB is not set
# CONFIG_USB_STORAGE_FREECOM is not set
# CONFIG_USB_STORAGE_ISD200 is not set
# CONFIG_USB_STORAGE_DPCM is not set
# CONFIG_USB_STORAGE_USBAT is not set
# CONFIG_USB_STORAGE_SDDR09 is not set
# CONFIG_USB_STORAGE_SDDR55 is not set
# CONFIG_USB_STORAGE_JUMPSHOT is not set
# CONFIG_USB_STORAGE_ALAUDA is not set
# CONFIG_USB_STORAGE_ONETOUCH is not set
# CONFIG_USB_STORAGE_KARMA is not set
# CONFIG_USB_STORAGE_CYPRESS_ATACB is not set
# CONFIG_USB_LIBUSUAL is not set

#
# USB Imaging devices
#
# CONFIG_USB_MDC800 is not set
# CONFIG_USB_MICROTEK is not set

#
# USB port drivers
#
# CONFIG_USB_SERIAL is not set

#
# USB Miscellaneous drivers
#
# CONFIG_USB_EMI62 is not set
# CONFIG_USB_EMI26 is not set
# CONFIG_USB_ADUTUX is not set
# CONFIG_USB_RIO500 is not set
# CONFIG_USB_LEGOTOWER is not set
# CONFIG_USB_LCD is not set
# CONFIG_USB_BERRY_CHARGE is not set
# CONFIG_USB_LED is not set
# CONFIG_USB_CYPRESS_CY7C63 is not set
# CONFIG_USB_CYTHERM is not set
# CONFIG_USB_PHIDGET is not set
# CONFIG_USB_IDMOUSE is not set
# CONFIG_USB_FTDI_ELAN is not set
# CONFIG_USB_APPLEDISPLAY is not set
# CONFIG_USB_SISUSBVGA is not set
# CONFIG_USB_LD is not set
# CONFIG_USB_TRANCEVIBRATOR is not set
# CONFIG_USB_IOWARRIOR is not set
# CONFIG_USB_TEST is not set
# CONFIG_USB_ISIGHTFW is not set
# CONFIG_USB_GADGET is not set
# CONFIG_MMC is not set
# CONFIG_MEMSTICK is not set
# CONFIG_NEW_LEDS is not set
# CONFIG_ACCESSIBILITY is not set
# CONFIG_INFINIBAND is not set
# CONFIG_EDAC is not set
# CONFIG_RTC_CLASS is not set
# CONFIG_DMADEVICES is not set
# CONFIG_UIO is not set

#
# Firmware Drivers
#
# CONFIG_EDD is not set
CONFIG_FIRMWARE_MEMMAP=3Dy
# CONFIG_DELL_RBU is not set
# CONFIG_DCDBAS is not set
CONFIG_DMIID=3Dy
# CONFIG_ISCSI_IBFT_FIND is not set

#
# File systems
#
CONFIG_EXT2_FS=3Dy
CONFIG_EXT2_FS_XATTR=3Dy
CONFIG_EXT2_FS_POSIX_ACL=3Dy
# CONFIG_EXT2_FS_SECURITY is not set
# CONFIG_EXT2_FS_XIP is not set
CONFIG_EXT3_FS=3Dy
CONFIG_EXT3_FS_XATTR=3Dy
CONFIG_EXT3_FS_POSIX_ACL=3Dy
# CONFIG_EXT3_FS_SECURITY is not set
# CONFIG_EXT4DEV_FS is not set
CONFIG_JBD=3Dy
CONFIG_FS_MBCACHE=3Dy
# CONFIG_REISERFS_FS is not set
# CONFIG_JFS_FS is not set
CONFIG_FS_POSIX_ACL=3Dy
# CONFIG_XFS_FS is not set
# CONFIG_OCFS2_FS is not set
CONFIG_DNOTIFY=3Dy
CONFIG_INOTIFY=3Dy
CONFIG_INOTIFY_USER=3Dy
# CONFIG_QUOTA is not set
# CONFIG_AUTOFS_FS is not set
CONFIG_AUTOFS4_FS=3Dy
CONFIG_FUSE_FS=3Dm
CONFIG_GENERIC_ACL=3Dy

#
# CD-ROM/DVD Filesystems
#
CONFIG_ISO9660_FS=3Dy
# CONFIG_JOLIET is not set
# CONFIG_ZISOFS is not set
# CONFIG_UDF_FS is not set

#
# DOS/FAT/NT Filesystems
#
CONFIG_FAT_FS=3Dy
CONFIG_MSDOS_FS=3Dy
CONFIG_VFAT_FS=3Dy
CONFIG_FAT_DEFAULT_CODEPAGE=3D437
CONFIG_FAT_DEFAULT_IOCHARSET=3D"iso8859-1"
# CONFIG_NTFS_FS is not set

#
# Pseudo filesystems
#
CONFIG_PROC_FS=3Dy
CONFIG_PROC_KCORE=3Dy
CONFIG_PROC_SYSCTL=3Dy
CONFIG_SYSFS=3Dy
CONFIG_TMPFS=3Dy
CONFIG_TMPFS_POSIX_ACL=3Dy
CONFIG_HUGETLBFS=3Dy
CONFIG_HUGETLB_PAGE=3Dy
# CONFIG_CONFIGFS_FS is not set

#
# Miscellaneous filesystems
#
# CONFIG_ADFS_FS is not set
# CONFIG_AFFS_FS is not set
# CONFIG_HFS_FS is not set
# CONFIG_HFSPLUS_FS is not set
# CONFIG_BEFS_FS is not set
# CONFIG_BFS_FS is not set
# CONFIG_EFS_FS is not set
# CONFIG_CRAMFS is not set
# CONFIG_VXFS_FS is not set
# CONFIG_MINIX_FS is not set
# CONFIG_OMFS_FS is not set
# CONFIG_HPFS_FS is not set
# CONFIG_QNX4FS_FS is not set
# CONFIG_ROMFS_FS is not set
# CONFIG_SYSV_FS is not set
# CONFIG_UFS_FS is not set
CONFIG_NETWORK_FILESYSTEMS=3Dy
# CONFIG_NFS_FS is not set
# CONFIG_NFSD is not set
# CONFIG_SMB_FS is not set
CONFIG_CIFS=3Dy
# CONFIG_CIFS_STATS is not set
# CONFIG_CIFS_WEAK_PW_HASH is not set
# CONFIG_CIFS_XATTR is not set
# CONFIG_CIFS_DEBUG2 is not set
# CONFIG_CIFS_EXPERIMENTAL is not set
# CONFIG_NCP_FS is not set
# CONFIG_CODA_FS is not set
# CONFIG_AFS_FS is not set

#
# Partition Types
#
# CONFIG_PARTITION_ADVANCED is not set
CONFIG_MSDOS_PARTITION=3Dy
CONFIG_NLS=3Dy
CONFIG_NLS_DEFAULT=3D"iso8859-1"
CONFIG_NLS_CODEPAGE_437=3Dy
# CONFIG_NLS_CODEPAGE_737 is not set
# CONFIG_NLS_CODEPAGE_775 is not set
# CONFIG_NLS_CODEPAGE_850 is not set
# CONFIG_NLS_CODEPAGE_852 is not set
# CONFIG_NLS_CODEPAGE_855 is not set
# CONFIG_NLS_CODEPAGE_857 is not set
# CONFIG_NLS_CODEPAGE_860 is not set
# CONFIG_NLS_CODEPAGE_861 is not set
# CONFIG_NLS_CODEPAGE_862 is not set
# CONFIG_NLS_CODEPAGE_863 is not set
# CONFIG_NLS_CODEPAGE_864 is not set
# CONFIG_NLS_CODEPAGE_865 is not set
# CONFIG_NLS_CODEPAGE_866 is not set
# CONFIG_NLS_CODEPAGE_869 is not set
# CONFIG_NLS_CODEPAGE_936 is not set
# CONFIG_NLS_CODEPAGE_950 is not set
# CONFIG_NLS_CODEPAGE_932 is not set
# CONFIG_NLS_CODEPAGE_949 is not set
# CONFIG_NLS_CODEPAGE_874 is not set
# CONFIG_NLS_ISO8859_8 is not set
# CONFIG_NLS_CODEPAGE_1250 is not set
# CONFIG_NLS_CODEPAGE_1251 is not set
CONFIG_NLS_ASCII=3Dy
CONFIG_NLS_ISO8859_1=3Dy
CONFIG_NLS_ISO8859_2=3Dy
# CONFIG_NLS_ISO8859_3 is not set
# CONFIG_NLS_ISO8859_4 is not set
# CONFIG_NLS_ISO8859_5 is not set
# CONFIG_NLS_ISO8859_6 is not set
# CONFIG_NLS_ISO8859_7 is not set
# CONFIG_NLS_ISO8859_9 is not set
# CONFIG_NLS_ISO8859_13 is not set
# CONFIG_NLS_ISO8859_14 is not set
CONFIG_NLS_ISO8859_15=3Dy
# CONFIG_NLS_KOI8_R is not set
# CONFIG_NLS_KOI8_U is not set
CONFIG_NLS_UTF8=3Dy
# CONFIG_DLM is not set

#
# Kernel hacking
#
CONFIG_TRACE_IRQFLAGS_SUPPORT=3Dy
# CONFIG_PRINTK_TIME is not set
CONFIG_ENABLE_WARN_DEPRECATED=3Dy
# CONFIG_ENABLE_MUST_CHECK is not set
CONFIG_FRAME_WARN=3D1024
CONFIG_MAGIC_SYSRQ=3Dy
CONFIG_UNUSED_SYMBOLS=3Dy
# CONFIG_DEBUG_FS is not set
# CONFIG_HEADERS_CHECK is not set
CONFIG_IPIPE_DEBUG=3Dy
CONFIG_IPIPE_DEBUG_CONTEXT=3Dy
CONFIG_IPIPE_TRACE=3Dy
CONFIG_IPIPE_TRACE_ENABLE=3Dy
CONFIG_IPIPE_TRACE_MCOUNT=3Dy
CONFIG_IPIPE_TRACE_IRQSOFF=3Dy
CONFIG_IPIPE_TRACE_SHIFT=3D15
# CONFIG_IPIPE_TRACE_VMALLOC is not set
CONFIG_IPIPE_TRACE_PANIC=3Dy
CONFIG_IPIPE_TRACE_ENABLE_VALUE=3D1
CONFIG_DEBUG_KERNEL=3Dy
# CONFIG_DEBUG_SHIRQ is not set
CONFIG_DETECT_SOFTLOCKUP=3Dy
# CONFIG_BOOTPARAM_SOFTLOCKUP_PANIC is not set
CONFIG_BOOTPARAM_SOFTLOCKUP_PANIC_VALUE=3D0
# CONFIG_SCHED_DEBUG is not set
# CONFIG_SCHEDSTATS is not set
CONFIG_TIMER_STATS=3Dy
# CONFIG_DEBUG_OBJECTS is not set
# CONFIG_SLUB_DEBUG_ON is not set
# CONFIG_SLUB_STATS is not set
# CONFIG_DEBUG_RT_MUTEXES is not set
# CONFIG_RT_MUTEX_TESTER is not set
# CONFIG_DEBUG_SPINLOCK is not set
# CONFIG_DEBUG_MUTEXES is not set
# CONFIG_DEBUG_LOCK_ALLOC is not set
# CONFIG_PROVE_LOCKING is not set
# CONFIG_LOCK_STAT is not set
# CONFIG_DEBUG_SPINLOCK_SLEEP is not set
# CONFIG_DEBUG_LOCKING_API_SELFTESTS is not set
# CONFIG_DEBUG_KOBJECT is not set
# CONFIG_DEBUG_HIGHMEM is not set
CONFIG_DEBUG_BUGVERBOSE=3Dy
# CONFIG_DEBUG_INFO is not set
# CONFIG_DEBUG_VM is not set
# CONFIG_DEBUG_WRITECOUNT is not set
CONFIG_DEBUG_MEMORY_INIT=3Dy
# CONFIG_DEBUG_LIST is not set
# CONFIG_DEBUG_SG is not set
CONFIG_FRAME_POINTER=3Dy
# CONFIG_BOOT_PRINTK_DELAY is not set
# CONFIG_RCU_TORTURE_TEST is not set
# CONFIG_KPROBES_SANITY_TEST is not set
# CONFIG_BACKTRACE_SELF_TEST is not set
# CONFIG_LKDTM is not set
# CONFIG_FAULT_INJECTION is not set
# CONFIG_LATENCYTOP is not set
CONFIG_SYSCTL_SYSCALL_CHECK=3Dy
CONFIG_HAVE_FTRACE=3Dy
CONFIG_HAVE_DYNAMIC_FTRACE=3Dy
# CONFIG_IRQSOFF_TRACER is not set
# CONFIG_SYSPROF_TRACER is not set
# CONFIG_SCHED_TRACER is not set
# CONFIG_CONTEXT_SWITCH_TRACER is not set
# CONFIG_PROVIDE_OHCI1394_DMA_INIT is not set
# CONFIG_SAMPLES is not set
CONFIG_HAVE_ARCH_KGDB=3Dy
# CONFIG_KGDB is not set
# CONFIG_STRICT_DEVMEM is not set
CONFIG_X86_VERBOSE_BOOTUP=3Dy
CONFIG_EARLY_PRINTK=3Dy
CONFIG_DEBUG_STACKOVERFLOW=3Dy
# CONFIG_DEBUG_STACK_USAGE is not set
# CONFIG_DEBUG_PAGEALLOC is not set
# CONFIG_DEBUG_PER_CPU_MAPS is not set
# CONFIG_X86_PTDUMP is not set
# CONFIG_DEBUG_RODATA is not set
# CONFIG_DEBUG_NX_TEST is not set
# CONFIG_4KSTACKS is not set
CONFIG_DOUBLEFAULT=3Dy
# CONFIG_MMIOTRACE is not set
CONFIG_IO_DELAY_TYPE_0X80=3D0
CONFIG_IO_DELAY_TYPE_0XED=3D1
CONFIG_IO_DELAY_TYPE_UDELAY=3D2
CONFIG_IO_DELAY_TYPE_NONE=3D3
CONFIG_IO_DELAY_0X80=3Dy
# CONFIG_IO_DELAY_0XED is not set
# CONFIG_IO_DELAY_UDELAY is not set
# CONFIG_IO_DELAY_NONE is not set
CONFIG_DEFAULT_IO_DELAY_TYPE=3D0
# CONFIG_CPA_DEBUG is not set
# CONFIG_OPTIMIZE_INLINING is not set

#
# Security options
#
# CONFIG_KEYS is not set
# CONFIG_SECURITY is not set
# CONFIG_SECURITY_FILE_CAPABILITIES is not set
CONFIG_CRYPTO=3Dy

#
# Crypto core or helper
#
# CONFIG_CRYPTO_MANAGER is not set
# CONFIG_CRYPTO_GF128MUL is not set
# CONFIG_CRYPTO_NULL is not set
# CONFIG_CRYPTO_CRYPTD is not set
# CONFIG_CRYPTO_AUTHENC is not set
# CONFIG_CRYPTO_TEST is not set

#
# Authenticated Encryption with Associated Data
#
# CONFIG_CRYPTO_CCM is not set
# CONFIG_CRYPTO_GCM is not set
# CONFIG_CRYPTO_SEQIV is not set

#
# Block modes
#
# CONFIG_CRYPTO_CBC is not set
# CONFIG_CRYPTO_CTR is not set
# CONFIG_CRYPTO_CTS is not set
# CONFIG_CRYPTO_ECB is not set
# CONFIG_CRYPTO_LRW is not set
# CONFIG_CRYPTO_PCBC is not set
# CONFIG_CRYPTO_XTS is not set

#
# Hash modes
#
# CONFIG_CRYPTO_HMAC is not set
# CONFIG_CRYPTO_XCBC is not set

#
# Digest
#
# CONFIG_CRYPTO_CRC32C is not set
# CONFIG_CRYPTO_MD4 is not set
# CONFIG_CRYPTO_MD5 is not set
# CONFIG_CRYPTO_MICHAEL_MIC is not set
# CONFIG_CRYPTO_RMD128 is not set
# CONFIG_CRYPTO_RMD160 is not set
# CONFIG_CRYPTO_RMD256 is not set
# CONFIG_CRYPTO_RMD320 is not set
# CONFIG_CRYPTO_SHA1 is not set
# CONFIG_CRYPTO_SHA256 is not set
# CONFIG_CRYPTO_SHA512 is not set
# CONFIG_CRYPTO_TGR192 is not set
# CONFIG_CRYPTO_WP512 is not set

#
# Ciphers
#
# CONFIG_CRYPTO_AES is not set
# CONFIG_CRYPTO_AES_586 is not set
# CONFIG_CRYPTO_ANUBIS is not set
# CONFIG_CRYPTO_ARC4 is not set
# CONFIG_CRYPTO_BLOWFISH is not set
# CONFIG_CRYPTO_CAMELLIA is not set
# CONFIG_CRYPTO_CAST5 is not set
# CONFIG_CRYPTO_CAST6 is not set
# CONFIG_CRYPTO_DES is not set
# CONFIG_CRYPTO_FCRYPT is not set
# CONFIG_CRYPTO_KHAZAD is not set
# CONFIG_CRYPTO_SALSA20 is not set
# CONFIG_CRYPTO_SALSA20_586 is not set
# CONFIG_CRYPTO_SEED is not set
# CONFIG_CRYPTO_SERPENT is not set
# CONFIG_CRYPTO_TEA is not set
# CONFIG_CRYPTO_TWOFISH is not set
# CONFIG_CRYPTO_TWOFISH_586 is not set

#
# Compression
#
# CONFIG_CRYPTO_DEFLATE is not set
# CONFIG_CRYPTO_LZO is not set
CONFIG_CRYPTO_HW=3Dy
# CONFIG_CRYPTO_DEV_PADLOCK is not set
# CONFIG_CRYPTO_DEV_GEODE is not set
# CONFIG_CRYPTO_DEV_HIFN_795X is not set
CONFIG_HAVE_KVM=3Dy
CONFIG_VIRTUALIZATION=3Dy
# CONFIG_KVM is not set
# CONFIG_LGUEST is not set
# CONFIG_VIRTIO_PCI is not set
# CONFIG_VIRTIO_BALLOON is not set

#
# Library routines
#
CONFIG_BITREVERSE=3Dy
CONFIG_GENERIC_FIND_FIRST_BIT=3Dy
CONFIG_GENERIC_FIND_NEXT_BIT=3Dy
# CONFIG_CRC_CCITT is not set
# CONFIG_CRC16 is not set
# CONFIG_CRC_T10DIF is not set
# CONFIG_CRC_ITU_T is not set
CONFIG_CRC32=3Dy
# CONFIG_CRC7 is not set
# CONFIG_LIBCRC32C is not set
CONFIG_PLIST=3Dy
CONFIG_HAS_IOMEM=3Dy
CONFIG_HAS_IOPORT=3Dy
CONFIG_HAS_DMA=3Dy

--=_2cgrwpf9e5no
Content-Type: text/plain;
	charset=ISO-8859-2;
	name="testev.c"
Content-Disposition: attachment;
	filename="testev.c"
Content-Transfer-Encoding: 7bit

#include <stdio.h>
#include <sys/mman.h>
#include <native/task.h>
#include <native/event.h>

RT_EVENT ev;

void task2_func(void *arg)
{
	int i = 0;
	printf("Wait\n");
	//rt_event_wait segfaults with xenomai from trunk
	rt_event_wait(&ev, 1, NULL, TM_INFINITE, EV_ALL);
	printf("Event!\n");
}

int main(int argc, char **argv)
{
	RT_TASK task1, task2;
	mlockall(MCL_CURRENT|MCL_FUTURE);

	rt_task_shadow(&task1, "Task 1", 10, 0);
	if (rt_event_create(&ev, NULL, 0, EV_PRIO))
	{
	    rt_printf("Could no create event!\n");
	}
	rt_task_spawn(&task2, "Task 2", 0, 11, 0, task2_func, NULL);

	printf("Sleeping...\n");
	rt_task_sleep(1000000000);
	printf("Resumed, set event!\n");
	rt_event_signal(&ev, 1);
	
	pause();
}

--=_2cgrwpf9e5no--


