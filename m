From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <12104543.1177686610343.JavaMail.ngmail@domain.hid>
References: <1177686318.5010.106.camel@domain.hid>
	<1177683592.5010.84.camel@domain.hid> <4631FF09.2000601@domain.hid>
	<4631F925.2090100@domain.hid>
	<4850965.1177589052502.JavaMail.ngmail@domain.hid>
	<4631E30B.6060701@domain.hid> <1177679680.5010.78.camel@domain.hid>
	<23595872.1177680700618.JavaMail.ngmail@domain.hid>
	<784082.1177682909759.JavaMail.ngmail@domain.hid>
	<1646519.1177684097169.JavaMail.ngmail@domain.hid>
	<1177685762.5010.104.camel@domain.hid>
	<12104543.1177686610343.JavaMail.ngmail@domain.hid>
Content-Type: text/plain
Date: Fri, 27 Apr 2007 22:39:22 +0200
Message-Id: <1177706363.5010.158.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: Philippe Gerum <philippe.gerum@domain.hid>
Subject: Re: [Xenomai-help] Xenomai and MSI enabled crashes kernel
Reply-To: rpm@xenomai.org
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: "M. Koehrer" <mathias_koehrer@domain.hid>
Cc: xenomai@xenomai.org, jan.kiszka@domain.hid

On Fri, 2007-04-27 at 17:10 +0200, M. Koehrer wrote:
> Hi Philippe,
> 
> here is the next result (I have switched off the "quiet" kernel parameter to get everything).
> 

There is a SMP-related bugfix regarding our IPI namespace I need to
backport from x86_64 to x86. Not sure this is what bites us here yet,
but there is no use to chase the wild goose. In any case, CONFIG_PCI_MSI
clearly worsens the situation regarding this issue.

> Regards
> 
> Mathias
> ++++++++++++++++++++++++++++++++++++++++++++++++++
> 
> Linux version 2.6.20.4 (root@domain.hid) (gcc version 4.1.2 20061115 (prerelease) (Debian 4.1.1-21)) #18 SMP Fri Apr 27 16:58:38 GMT-2 2007
> BIOS-provided physical RAM map:
> sanitize start
> sanitize end
> copy_e820_map() start: 0000000000000000 size: 000000000009e000 end: 000000000009e000 type: 1
> copy_e820_map() type is E820_RAM
> copy_e820_map() start: 000000000009e000 size: 0000000000002000 end: 00000000000a0000 type: 2
> copy_e820_map() start: 00000000000ca000 size: 0000000000002000 end: 00000000000cc000 type: 2
> copy_e820_map() start: 00000000000e4000 size: 000000000001c000 end: 0000000000100000 type: 2
> copy_e820_map() start: 0000000000100000 size: 000000001fde0000 end: 000000001fee0000 type: 1
> copy_e820_map() type is E820_RAM
> copy_e820_map() start: 000000001fee0000 size: 0000000000009000 end: 000000001fee9000 type: 3
> copy_e820_map() start: 000000001fee9000 size: 0000000000017000 end: 000000001ff00000 type: 4
> copy_e820_map() start: 000000001ff00000 size: 0000000000100000 end: 0000000020000000 type: 2
> copy_e820_map() start: 00000000fec00000 size: 0000000000010000 end: 00000000fec10000 type: 2
> copy_e820_map() start: 00000000fee00000 size: 0000000000001000 end: 00000000fee01000 type: 2
> copy_e820_map() start: 00000000ff000000 size: 0000000001000000 end: 0000000100000000 type: 2
>  BIOS-e820: 0000000000000000 - 000000000009e000 (usable)
>  BIOS-e820: 000000000009e000 - 00000000000a0000 (reserved)
>  BIOS-e820: 00000000000ca000 - 00000000000cc000 (reserved)
>  BIOS-e820: 00000000000e4000 - 0000000000100000 (reserved)
>  BIOS-e820: 0000000000100000 - 000000001fee0000 (usable)
>  BIOS-e820: 000000001fee0000 - 000000001fee9000 (ACPI data)
>  BIOS-e820: 000000001fee9000 - 000000001ff00000 (ACPI NVS)
>  BIOS-e820: 000000001ff00000 - 0000000020000000 (reserved)
>  BIOS-e820: 00000000fec00000 - 00000000fec10000 (reserved)
>  BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
>  BIOS-e820: 00000000ff000000 - 0000000100000000 (reserved)
> 510MB LOWMEM available.
> found SMP MP-table at 000f5f40
> Zone PFN ranges:
>   DMA             0 ->     4096
>   Normal       4096 ->   130784
> early_node_map[1] active PFN ranges
>     0:        0 ->   130784
> DMI present.
> ACPI: PM-Timer IO Port: 0x1008
> ACPI: LAPIC (acpi_id[0x00] lapic_id[0x00] enabled)
> Processor #0 15:6 APIC version 20
> ACPI: LAPIC (acpi_id[0x01] lapic_id[0x01] enabled)
> Processor #1 15:6 APIC version 20
> ACPI: LAPIC_NMI (acpi_id[0x00] high edge lint[0x1])
> ACPI: LAPIC_NMI (acpi_id[0x01] high edge lint[0x1])
> ACPI: IOAPIC (id[0x02] address[0xfec00000] gsi_base[0])
> IOAPIC[0]: apic_id 2, version 32, address 0xfec00000, GSI 0-23
> ACPI: IOAPIC (id[0x03] address[0xfec10000] gsi_base[24])
> IOAPIC[1]: apic_id 3, version 32, address 0xfec10000, GSI 24-47
> ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 high edge)
> ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
> Enabling APIC mode:  Flat.  Using 2 I/O APICs
> Using ACPI (MADT) for SMP configuration information
> Allocating PCI resources starting at 30000000 (gap: 20000000:dec00000)
> Detected 3192.197 MHz processor.
> Built 1 zonelists.  Total pages: 129763
> Kernel command line: root=/dev/sda5 vga=ext isolcpus=1,3,7 console=ttyS0,115200n8
> Enabling fast FPU save and restore... done.
> Enabling unmasked SIMD FPU exception support... done.
> Initializing CPU#0
> PID hash table entries: 2048 (order: 11, 8192 bytes)
> I-pipe 1.7-03: pipeline enabled.
> Console: colour VGA+ 80x50
> Dentry cache hash table entries: 65536 (order: 6, 262144 bytes)
> Inode-cache hash table entries: 32768 (order: 5, 131072 bytes)
> Memory: 513860k/523136k available (2256k kernel code, 8696k reserved, 893k data, 224k init, 0k highmem)
> virtual kernel memory layout:
>     fixmap  : 0xfffb7000 - 0xfffff000   ( 288 kB)
>     vmalloc : 0xe0800000 - 0xfffb5000   ( 503 MB)
>     lowmem  : 0xc0000000 - 0xdfee0000   ( 510 MB)
>       .init : 0xc041a000 - 0xc0452000   ( 224 kB)
>       .data : 0xc03341f1 - 0xc041360c   ( 893 kB)
>       .text : 0xc0100000 - 0xc03341f1   (2256 kB)
> Checking if this processor honours the WP bit even in supervisor mode... Ok.
> Calibrating delay using timer specific routine.. 6389.64 BogoMIPS (lpj=12779283)
> Mount-cache hash table entries: 512
> monitor/mwait feature present.
> using mwait in idle threads.
> CPU: Trace cache: 12K uops, L1 D cache: 16K
> CPU: L2 cache: 2048K
> CPU: Physical Processor ID: 0
> CPU: Processor Core ID: 0
> Intel machine check architecture supported.
> Intel machine check reporting enabled on CPU#0.
> CPU0: Intel P4/Xeon Extended MCE MSRs (24) available
> Compat vDSO mapped to ffffe000.
> Checking 'hlt' instruction... OK.
> Freeing SMP alternatives: 15k freed
> ACPI: Core revision 20060707
> CPU0: Intel(R) Pentium(R) D CPU 3.20GHz stepping 02
> Booting processor 1/1 eip 2000
> Initializing CPU#1
> Calibrating delay using timer specific routine.. 6384.56 BogoMIPS (lpj=12769139)
> monitor/mwait feature present.
> CPU: Trace cache: 12K uops, L1 D cache: 16K
> CPU: L2 cache: 2048K
> CPU: Physical Processor ID: 0
> CPU: Processor Core ID: 1
> Intel machine check architecture supported.
> Intel machine check reporting enabled on CPU#1.
> CPU1: Intel P4/Xeon Extended MCE MSRs (24) available
> CPU1: Thermal monitoring enabled
> CPU1: Intel(R) Pentium(R) D CPU 3.20GHz stepping 02
> Total of 2 processors activated (12774.21 BogoMIPS).
> ENABLING IO-APIC IRQs
> IRQ 1 vectored at #39
> IRQ 3 vectored at #41
> IRQ 4 vectored at #49
> IRQ 5 vectored at #51
> IRQ 6 vectored at #59
> IRQ 7 vectored at #61
> IRQ 8 vectored at #69
> IRQ 9 vectored at #71
> IRQ 10 vectored at #79
> IRQ 11 vectored at #81
> IRQ 12 vectored at #89
> IRQ 13 vectored at #91
> IRQ 14 vectored at #99
> IRQ 15 vectored at #a1
> ..TIMER: vector=0x31 apic1=0 pin1=2 apic2=-1 pin2=-1
> checking TSC synchronization across 2 CPUs: passed.
> Brought up 2 CPUs
> migration_cost=0
> NET: Registered protocol family 16
> ACPI: bus type pci registered
> PCI: BIOS Bug: MCFG area at f0000000 is not E820-reserved
> PCI: Not using MMCONFIG.
> PCI: PCI BIOS revision 2.10 entry at 0xfd877, last bus=10
> PCI: Using configuration type 1
> Setting up standard PCI resources
> ACPI: Interpreter enabled
> ACPI: Using IOAPIC for interrupt routing
> ACPI: PCI Root Bridge [PCI0] (0000:00)
> PCI quirk: region 1000-107f claimed by ICH6 ACPI/GPIO/TCO
> PCI quirk: region 1180-11bf claimed by ICH6 GPIO
> 0000:00:1f.1: trying to change BAR0 from 0000 to 01F0
> 0000:00:1f.1: trying to change BAR1 from 0000 to 03F4
> 0000:00:1f.1: trying to change BAR2 from 0000 to 0170
> 0000:00:1f.1: trying to change BAR3 from 0000 to 0374
> PCI: PXH quirk detected, disabling MSI for SHPC device
> PCI: Firmware left 0000:0a:06.0 e100 interrupts enabled, disabling
> PCI: Transparent bridge - 0000:00:1e.0
> ACPI: PCI Interrupt Link [LNKA] (IRQs 3 *10 11 14 15)
> ACPI: PCI Interrupt Link [LNKB] (IRQs 3 10 *11 14 15)
> ACPI: PCI Interrupt Link [LNKC] (IRQs 3 10 11 14 15) *5
> ACPI: PCI Interrupt Link [LNKD] (IRQs 3 *10 11 14 15)
> ACPI: PCI Interrupt Link [LNKE] (IRQs 3 10 *11 14 15)
> ACPI: PCI Interrupt Link [LNKF] (IRQs 3 10 11 14 15) *0, disabled.
> ACPI: PCI Interrupt Link [LNKG] (IRQs 3 10 11 14 15) *0, disabled.
> ACPI: PCI Interrupt Link [LNKH] (IRQs 3 10 11 14 15) *12
> Linux Plug and Play Support v0.97 (c) Adam Belay
> pnp: PnP ACPI init
> pnp: PnP ACPI: found 12 devices
> SCSI subsystem initialized
> PCI: Using ACPI for IRQ routing
> PCI: If a device doesn't work, try "pci=routeirq".  If it helps, post a report
> PCI: Bridge: 0000:01:00.0
>   IO window: disabled.
>   MEM window: e0100000-e1ffffff
>   PREFETCH window: e8000000-efffffff
> PCI: Bridge: 0000:00:01.0
>   IO window: disabled.
>   MEM window: e0100000-e1ffffff
>   PREFETCH window: e8000000-efffffff
> PCI: Bridge: 0000:03:00.0
>   IO window: disabled.
>   MEM window: disabled.
>   PREFETCH window: disabled.
> PCI: Bridge: 0000:00:1c.0
>   IO window: disabled.
>   MEM window: e2000000-e20fffff
>   PREFETCH window: disabled.
> PCI: Bridge: 0000:00:1c.4
>   IO window: 4000-4fff
>   MEM window: e2100000-e21fffff
>   PREFETCH window: disabled.
> PCI: Bridge: 0000:00:1c.5
>   IO window: 5000-5fff
>   MEM window: e2200000-e22fffff
>   PREFETCH window: disabled.
> PCI: Bridge: 0000:00:1e.0
>   IO window: 6000-6fff
>   MEM window: e2300000-e3ffffff
>   PREFETCH window: 30000000-300fffff
> IRQ 16 vectored at #a9
> ACPI: PCI Interrupt 0000:00:01.0[A] -> GSI 16 (level, low) -> IRQ 16
> IRQ 17 vectored at #b1
> ACPI: PCI Interrupt 0000:00:1c.0[A] -> GSI 17 (level, low) -> IRQ 17
> ACPI: PCI Interrupt 0000:00:1c.4[A] -> GSI 17 (level, low) -> IRQ 17
> ACPI: PCI Interrupt 0000:00:1c.5[B] -> GSI 16 (level, low) -> IRQ 16
> NET: Registered protocol family 2
> IP route cache hash table entries: 4096 (order: 2, 16384 bytes)
> TCP established hash table entries: 16384 (order: 5, 131072 bytes)
> TCP bind hash table entries: 8192 (order: 4, 65536 bytes)
> TCP: Hash tables configured (established 16384 bind 8192)
> TCP reno registered
> checking if image is initramfs...it isn't (no cpio magic); looks like an initrd
> Freeing initrd memory: 348k freed
> Simple Boot Flag at 0x37 set to 0x1
> Machine check exception polling timer started.
> audit: initializing netlink socket (disabled)
> audit(1177686146.976:1): initialized
> Installing knfsd (copyright (C) 1996 okir@domain.hid).
> io scheduler noop registered
> io scheduler anticipatory registered (default)
> io scheduler deadline registered
> io scheduler cfq registered
> assign_interrupt_mode Found MSI capability
> IRQ 223 vectored at #b9
> assign_interrupt_mode Found MSI capability
> IRQ 222 vectored at #c1
> assign_interrupt_mode Found MSI capability
> IRQ 221 vectored at #c9
> assign_interrupt_mode Found MSI capability
> IRQ 220 vectored at #d1
> input: Power Button (FF) as /class/input/input0
> ACPI: Power Button (FF) [PWRF]
> input: Power Button (CM) as /class/input/input1
> ACPI: Power Button (CM) [PWRB]
> lp: driver loaded but no devices found
> Linux agpgart interface v0.101 (c) Dave Jones
> [drm] Initialized drm 1.1.0 20060810
> Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing disabled
> serial8250: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
> serial8250: ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
> 00:09: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
> 00:0a: ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
> IRQ 18 vectored at #d9
> ACPI: PCI Interrupt 0000:05:00.3[C] -> GSI 18 (level, low) -> IRQ 18
> 0000:05:00.3: ttyS2 at I/O 0x4020 (irq = 18) is a 16550A
> parport: PnPBIOS parport detected.
> parport0: PC-style at 0x378 (0x778), irq 7 [PCSPP(,...)]
> lp0: using parport0 (interrupt-driven).
> floppy0: no floppy controllers found
> RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
> loop: loaded (max 8 devices)
> Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
> ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
> ICH7: IDE controller at PCI slot 0000:00:1f.1
> ACPI: PCI Interrupt 0000:00:1f.1[A] -> GSI 18 (level, low) -> IRQ 18
> ICH7: chipset revision 1
> ICH7: not 100% native mode: will probe irqs later
>     ide0: BM-DMA at 0x3020-0x3027, BIOS settings: hda:DMA, hdb:pio
> hda: HL-DT-STDVD-ROM GDR8164B, ATAPI CD/DVD-ROM drive
> ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
> hda: ATAPI 52X DVD-ROM drive, 256kB Cache, UDMA(33)
> Uniform CD-ROM driver Revision: 3.20
> ata_piix 0000:00:1f.2: MAP [ P0 P2 P1 P3 ]
> IRQ 19 vectored at #e1
> ACPI: PCI Interrupt 0000:00:1f.2[B] -> GSI 19 (level, low) -> IRQ 19
> ata1: SATA max UDMA/133 cmd 0x3068 ctl 0x305E bmdma 0x3030 irq 19
> ata2: SATA max UDMA/133 cmd 0x3060 ctl 0x305A bmdma 0x3038 irq 19
> scsi0 : ata_piix
> ata1.00: ATA-7, max UDMA/133, 160836480 sectors: LBA48 NCQ (depth 0/32)
> ata1.00: ata1: dev 0 multi count 16
> ata1.00: configured for UDMA/133
> scsi1 : ata_piix
> ATA: abnormal status 0x7F on port 0x3067
> scsi 0:0:0:0: Direct-Access     ATA      Hitachi HDS72168 P21O PQ: 0 ANSI: 5
> SCSI device sda: 160836480 512-byte hdwr sectors (82348 MB)
> sda: Write Protect is off
> SCSI device sda: write cache: enabled, read cache: enabled, doesn't support DPO or FUA
> SCSI device sda: 160836480 512-byte hdwr sectors (82348 MB)
> sda: Write Protect is off
> SCSI device sda: write cache: enabled, read cache: enabled, doesn't support DPO or FUA
>  sda: sda1 sda2 < sda5 sda6 sda7 >
> sd 0:0:0:0: Attached scsi disk sda
> sd 0:0:0:0: Attached scsi generic sg0 type 0
> PNP: PS/2 Controller [PNP0303:KBC0,PNP0f13:MSE0] at 0x60,0x64 irq 1,12
> serio: i8042 KBD port at 0x60,0x64 irq 1
> mice: PS/2 mouse device common for all mice
> input: AT Translated Set 2 keyboard as /class/input/input2
> input: PC Speaker as /class/input/input3
> TCP cubic registered
> NET: Registered protocol family 1
> NET: Registered protocol family 17
> Starting balanced_irq
> Using IPI Shortcut mode
> RAMDISK: Compressed image found at block 0
> Time: tsc clocksource has been installed.
> VFS: Mounted root (minix filesystem).
> Requested Root Partition: sda5. OK
> ReiserFS: sda5: found reiserfs format "3.6" with standard journal
> ReiserFS: sda5: using ordered data mode
> ReiserFS: sda5: journal params: device sda5, size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
> ReiserFS: sda5: checking transaction log (sda5)
> ReiserFS: sda5: Using r5 hash to sort names
> VFS: Mounted root (reiserfs filesystem) readonly.
> Trying to move old root to /initrd ... /initrd does not exist. Ignored.
> Unmounting old root
> Trying to free ramdisk memory ... okay
> Freeing unused kernel memory: 224k freed
> INIT: version 2.86 booting
> Setting parameters of disc: (none).
> Setting the system clock..
> Mounting proc filesystem
> mount: proc already mounted
> Cleaning up ifupdown....
> Loading kernel modules...done.
> Loading device-mapper support.
> Checking file systems...fsck 1.40-WIP (14-Nov-2006)
> done.
> Setting kernel variables...done.
> Checking /etc/fstab.
> Mounting local filesystems...ReiserFS: sda1: found reiserfs format "3.6" with standard journal
> ReiserFS: sda1: using ordered data mode
> ReiserFS: sda1: journal params: device sda1, size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
> ReiserFS: sda1: checking transaction log (sda1)
> ReiserFS: sda1: Using r5 hash to sort names
> done.
> Activating swapfile swap...done.
> Configuring network interfaces...Intel(R) PRO/1000 Network Driver - version 7.3.15-k2
> Copyright (c) 1999-2006 Intel Corporation.
> ACPI: PCI Interrupt 0000:05:00.0[A] -> GSI 16 (level, low) -> IRQ 16
> e1000: 0000:05:00.0: e1000_probe: (PCI Express:2.5Gb/s:Width x1) 00:30:48:5a:f9:0a
> e1000: eth0: e1000_probe: Intel(R) PRO/1000 Network Connection
> IRQ 219 vectored at #e9
> BUG: unable to handle kernel paging request at virtual address 511203b2
>  printing eip:
> c03e5680
> *pde = 00000000
> Oops: 0002 [#1]
> SMP 
> Modules linked in: e1000
> CPU:    0
> EIP:    0060:[<c03e5680>]    Not tainted VLI
> EFLAGS: 00010092   (2.6.20.4 #18)
> EIP is at 0xc03e5680
> eax: c011226c   ebx: 00000006   ecx: c0114375   edx: dfc1a000
> esi: 00000046   edi: ffffffff   ebp: 00000000   esp: dfc1be24
> ds: 007b   es: 007b   ss: 0068
> Process ifconfig (pid: 1241, ti=dfc1a000 task=dfcb3030 task.ti=dfc1a000)
> Stack: 000000db 00000000 c03d9100 c010efa9 00006d80 00000001 00000060 e099a210 
>        00000286 ffffff24 df7015c8 00000000 0000000f 00000001 c0103439 df7015c8 
>        e099a0ff e09c0000 00000000 0000000f 00000001 80080740 c14a007b df70007b 
> Call Trace:
>  [<c010efa9>] __ipipe_handle_irq+0x1b9/0x20b
>  [<e099a210>] e1000_set_multi+0x111/0x189 [e1000]
>  [<c0103439>] common_interrupt+0x21/0x38
>  [<e099a0ff>] e1000_set_multi+0x0/0x189 [e1000]
>  [<e099a210>] e1000_set_multi+0x111/0x189 [e1000]
>  [<c02dcfb1>] __dev_mc_upload+0x1d/0x1e
>  [<c02dd0d1>] dev_mc_upload+0x24/0x37
>  [<c02db5dc>] dev_open+0x44/0x62
>  [<c02da0a9>] dev_change_flags+0x47/0xe4
>  [<c030d1c2>] devinet_ioctl+0x252/0x56f
>  [<c02db1ba>] dev_ifsioc+0x113/0x38d
>  [<c02d15d4>] sock_ioctl+0x0/0x1ad
>  [<c02d1762>] sock_ioctl+0x18e/0x1ad
>  [<c02d15d4>] sock_ioctl+0x0/0x1ad
>  [<c015e1bf>] do_ioctl+0x1f/0x62
>  [<c015e446>] vfs_ioctl+0x244/0x256
>  [<c015e48b>] sys_ioctl+0x33/0x4c
>  [<c01029f3>] sysenter_past_esp+0x6c/0x70
>  =======================
> Code: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 <00> 91 3d c0 00 91 3d c0 00 00 00 00 00 00 00 00 00 00 00 00 00 
> EIP: [<c03e5680>] 0xc03e5680 SS:ESP 0068:dfc1be24
>  <0>Kernel panic - not syncing: Fatal exception in interrupt
>  BUG: at arch/i386/kernel/smp.c:565 smp_call_function()
>  [<c010b903>] smp_call_function+0x66/0x10a
>  [<c0118e3a>] printk+0x62/0xd5
>  [<c010b9c2>] smp_send_stop+0x1b/0x2b
>  [<c01183d5>] panic+0x4d/0xe4
>  [<c0103f71>] die+0x1f2/0x226
>  [<c01116a4>] do_page_fault+0x447/0x517
>  [<c013fbae>] __alloc_pages+0x52/0x286
>  [<c010f643>] __ipipe_handle_exception+0xce/0x158
>  [<c01521e3>] kmem_cache_alloc+0x5d/0x67
>  [<c010bb1e>] smp_call_function_interrupt+0x31/0x4c
>  [<c033339d>] error_code+0x81/0x90
>  [<c0114375>] try_to_wake_up+0x33c/0x346
>  [<c011226c>] __activate_task+0x1c/0x29
>  [<c010efa9>] __ipipe_handle_irq+0x1b9/0x20b
>  [<e099a210>] e1000_set_multi+0x111/0x189 [e1000]
>  [<c0103439>] common_interrupt+0x21/0x38
>  [<e099a0ff>] e1000_set_multi+0x0/0x189 [e1000]
>  [<e099a210>] e1000_set_multi+0x111/0x189 [e1000]
>  [<c02dcfb1>] __dev_mc_upload+0x1d/0x1e
>  [<c02dd0d1>] dev_mc_upload+0x24/0x37
>  [<c02db5dc>] dev_open+0x44/0x62
>  [<c02da0a9>] dev_change_flags+0x47/0xe4
>  [<c030d1c2>] devinet_ioctl+0x252/0x56f
>  [<c02db1ba>] dev_ifsioc+0x113/0x38d
>  [<c02d15d4>] sock_ioctl+0x0/0x1ad
>  [<c02d1762>] sock_ioctl+0x18e/0x1ad
>  [<c02d15d4>] sock_ioctl+0x0/0x1ad
>  [<c015e1bf>] do_ioctl+0x1f/0x62
>  [<c015e446>] vfs_ioctl+0x244/0x256
>  [<c015e48b>] sys_ioctl+0x33/0x4c
>  [<c01029f3>] sysenter_past_esp+0x6c/0x70
>  =======================
> 
> 
> 
> 
> ----- Original Nachricht ----
> Von:     Philippe Gerum <rpm@xenomai.org>
> An:      "M. Koehrer" <mathias_koehrer@domain.hid>
> Datum:   27.04.2007 17:05
> Betreff: Re: Re: [Xenomai-help] Xenomai and MSI enabled crashes kernel
> 
> > On Fri, 2007-04-27 at 16:56 +0200, Philippe Gerum wrote:
> > > On Fri, 2007-04-27 at 16:28 +0200, M. Koehrer wrote:
> > > > Hello Philippe,
> > > > 
> > > > here it is: (I have no idea what BUGON does...)
> > > > 
> > > 
> > > This patch will print out the irq/vector mappings. I'm interested in
> > > reading this output.
> > > 
> > > --- arch/i386/kernel/io_apic.c~	2007-02-26 10:31:39.000000000 +0100
> > > +++ arch/i386/kernel/io_apic.c	2007-04-27 16:51:51.000000000 +0200
> > > @@ -1259,6 +1259,7 @@
> > >  	current_vector = vector;
> > >  	current_offset = offset;
> > >  	irq_vector[irq] = vector;
> > > +	printk("IRQ %d vectored at #%2x\n", irq, vector);
> > 
> > Please s/%2x/%.2x
> > 
> > >  
> > >  	return vector;
> > >  }
> > > 
> > -- 
> > Philippe.
> > 
> > 
> > 
> 
-- 
Philippe.



