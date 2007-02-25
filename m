From: Paul <paul_c@domain.hid>
Subject: Re: [Xenomai-core] x86_64 - Initial results.
Date: Sun, 25 Feb 2007 18:42:25 +0000
References: <200702241526.22786.paul_c@domain.hid>
	<200702251557.19205.paul_c@domain.hid> <45E1B345.4050304@domain.hid>
In-Reply-To: <45E1B345.4050304@domain.hid>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_Rid4FVOcfiKyv2o"
Message-Id: <200702251842.25248.paul_c@domain.hid>
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: xenomai@xenomai.org

--Boundary-00=_Rid4FVOcfiKyv2o
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Sunday 25 February 2007 16:03, Jan Kiszka wrote:
> > =A0The attached trace logs provide little information - Also included d=
mesg
>
> One more try please: we also need CONFIG_IPIPE_TRACE_MCOUNT.

With both CONFIG_IPIPE_TRACE_MCOUNT and CONFIG_IPIPE_TRACE_VMALLOC enabled,=
=20
the system auto-reboots as soon as the kernel starts to uncompress. Disabli=
ng=20
the latter restores normal service.

On Sunday 25 February 2007 16:09, Gilles Chanteperdrix wrote:
> Option "NoAccel"

Results are still the same - Latency goes to pot and hangs as soon as X sta=
rts=20
up. Quite likely the offending trace isn't getting logged..


Regards, Paul.




--Boundary-00=_Rid4FVOcfiKyv2o
Content-Type: text/plain;
  charset="iso-8859-1";
  name="dmesg"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="dmesg"

[    0.000000] Linux version 2.6.19.3-xenomai (paul@domain.hid) (gcc version 4.1.2 20061115 (prerelease) (Debian 4.1.1-21)) #7 Sun Feb 25 17:58:53 GMT 2007
[    0.000000] Command line: root=/dev/sda2 ro splash=silent vga=788 
[    0.000000] BIOS-provided physical RAM map:
[    0.000000]  BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
[    0.000000]  BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
[    0.000000]  BIOS-e820: 00000000000e4000 - 0000000000100000 (reserved)
[    0.000000]  BIOS-e820: 0000000000100000 - 000000001ffb0000 (usable)
[    0.000000]  BIOS-e820: 000000001ffb0000 - 000000001ffc0000 (ACPI data)
[    0.000000]  BIOS-e820: 000000001ffc0000 - 000000001fff0000 (ACPI NVS)
[    0.000000]  BIOS-e820: 000000001fff0000 - 0000000020000000 (reserved)
[    0.000000]  BIOS-e820: 00000000ff780000 - 0000000100000000 (reserved)
[    0.000000] Entering add_active_range(0, 0, 159) 0 entries of 256 used
[    0.000000] Entering add_active_range(0, 256, 130992) 1 entries of 256 used
[    0.000000] end_pfn_map = 1048576
[    0.000000] DMI 2.3 present.
[    0.000000] ACPI: RSDP (v000 ACPIAM                                ) @ 0x00000000000fa810
[    0.000000] ACPI: RSDT (v001 A M I  OEMRSDT  0x01000723 MSFT 0x00000097) @ 0x000000001ffb0000
[    0.000000] ACPI: FADT (v001 A M I  OEMFACP  0x01000723 MSFT 0x00000097) @ 0x000000001ffb0200
[    0.000000] ACPI: MADT (v001 A M I  OEMAPIC  0x01000723 MSFT 0x00000097) @ 0x000000001ffb0390
[    0.000000] ACPI: OEMB (v001 A M I  OEMBIOS  0x01000723 MSFT 0x00000097) @ 0x000000001ffc0040
[    0.000000] ACPI: DSDT (v001  A0277 A0277001 0x00000001 MSFT 0x0100000d) @ 0x0000000000000000
[    0.000000] Entering add_active_range(0, 0, 159) 0 entries of 256 used
[    0.000000] Entering add_active_range(0, 256, 130992) 1 entries of 256 used
[    0.000000] Zone PFN ranges:
[    0.000000]   DMA             0 ->     4096
[    0.000000]   DMA32        4096 ->  1048576
[    0.000000]   Normal    1048576 ->  1048576
[    0.000000] early_node_map[2] active PFN ranges
[    0.000000]     0:        0 ->      159
[    0.000000]     0:      256 ->   130992
[    0.000000] On node 0 totalpages: 130895
[    0.000000]   DMA zone: 56 pages used for memmap
[    0.000000]   DMA zone: 1700 pages reserved
[    0.000000]   DMA zone: 2243 pages, LIFO batch:0
[    0.000000]   DMA32 zone: 1734 pages used for memmap
[    0.000000]   DMA32 zone: 125162 pages, LIFO batch:31
[    0.000000]   Normal zone: 0 pages used for memmap
[    0.000000] ACPI: PM-Timer IO Port: 0x808
[    0.000000] ACPI: Local APIC address 0xfee00000
[    0.000000] ACPI: LAPIC (acpi_id[0x01] lapic_id[0x00] enabled)
[    0.000000] Processor #0 (Bootup-CPU)
[    0.000000] ACPI: LAPIC (acpi_id[0x02] lapic_id[0x01] enabled)
[    0.000000] Processor #1
[    0.000000] WARNING: NR_CPUS limit of 1 reached. Processor ignored.
[    0.000000] ACPI: IOAPIC (id[0x02] address[0xfec00000] gsi_base[0])
[    0.000000] IOAPIC[0]: apic_id 2, address 0xfec00000, GSI 0-23
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
[    0.000000] ACPI: IRQ0 used by override.
[    0.000000] ACPI: IRQ2 used by override.
[    0.000000] ACPI: IRQ9 used by override.
[    0.000000] Setting APIC routing to flat
[    0.000000] Using ACPI (MADT) for SMP configuration information
[    0.000000] Nosave address range: 000000000009f000 - 00000000000a0000
[    0.000000] Nosave address range: 00000000000a0000 - 00000000000e4000
[    0.000000] Nosave address range: 00000000000e4000 - 0000000000100000
[    0.000000] Allocating PCI resources starting at 30000000 (gap: 20000000:df780000)
[    0.000000] Built 1 zonelists.  Total pages: 127405
[    0.000000] Kernel command line: root=/dev/sda2 ro splash=silent vga=788 
[    0.000000] Initializing CPU#0
[    0.000000] PID hash table entries: 2048 (order: 11, 16384 bytes)
[   28.777403] time.c: Using 3.579545 MHz WALL PM GTOD PIT/TSC timer.
[   28.777410] time.c: Detected 2403.177 MHz processor.
[   28.777485] I-pipe 1.0-04: pipeline enabled.
[   28.777553] Console: colour dummy device 80x25
[   28.778250] Dentry cache hash table entries: 65536 (order: 7, 524288 bytes)
[   28.778657] Inode-cache hash table entries: 32768 (order: 6, 262144 bytes)
[   28.778737] Checking aperture...
[   28.778745] CPU 0: aperture @ f0000000 size 64 MB
[   28.786774] Memory: 502760k/523968k available (2089k kernel code, 20568k reserved, 3940k data, 184k init)
[   28.863385] Calibrating delay using timer specific routine.. 4817.66 BogoMIPS (lpj=9635322)
[   28.863522] Mount-cache hash table entries: 256
[   28.863751] CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
[   28.863761] CPU: L2 Cache: 512K (64 bytes/line)
[   28.863777] CPU: AMD Athlon(tm) 64 X2 Dual Core Processor 4600+ stepping 02
[   28.863800] ACPI: Core revision 20060707
[   28.915014] Using local APIC timer interrupts.
[   28.956635] result 12516560
[   28.956645] Detected 12.516 MHz APIC timer.
[   28.959360] testing NMI watchdog ... OK.
[   28.999664] checking if image is initramfs... it is
[   29.424500] Freeing initrd memory: 5630k freed
[   29.431286] NET: Registered protocol family 16
[   29.431474] ACPI: bus type pci registered
[   29.431490] PCI: Using configuration type 1
[   29.458905] ACPI: Interpreter enabled
[   29.458927] ACPI: Using IOAPIC for interrupt routing
[   29.464867] ACPI: PCI Root Bridge [PCI0] (0000:00)
[   29.464892] PCI: Probing PCI hardware (bus 00)
[   29.478789] PCI: enabled onboard AC97/MC97 devices
[   29.479367] Boot video device is 0000:01:00.0
[   29.479462] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
[   29.578826] ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 7 10 *11 14 15)
[   29.580142] ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 7 *10 11 14 15)
[   29.581349] ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 *5 7 10 11 14 15)
[   29.582557] ACPI: PCI Interrupt Link [LNKD] (IRQs *3 4 5 7 10 11 14 15)
[   29.583800] ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 7 10 11 14 15) *0, disabled.
[   29.585019] ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 7 10 11 14 15) *0, disabled.
[   29.586239] ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 5 7 10 11 14 15) *0, disabled.
[   29.587535] ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 5 7 10 11 14 15) *0, disabled.
[   29.588087] Linux Plug and Play Support v0.97 (c) Adam Belay
[   29.588202] PCI: Using ACPI for IRQ routing
[   29.588210] PCI: If a device doesn't work, try "pci=routeirq".  If it helps, post a report
[   29.588234] PCI: Cannot allocate resource region 0 of device 0000:00:00.0
[   29.588613] agpgart: Detected AGP bridge 0
[   29.591349] agpgart: AGP aperture is 64M @ 0xf0000000
[   29.591404] PCI-DMA: Disabling IOMMU.
[   29.594283] pnp: the driver 'system' has been registered
[   29.595083] PCI: Bridge: 0000:00:01.0
[   29.595098]   IO window: disabled.
[   29.595109]   MEM window: faf00000-fbffffff
[   29.595119]   PREFETCH window: f8000000-f9ffffff
[   29.595152] PCI: Setting latency timer of device 0000:00:01.0 to 64
[   29.595285] NET: Registered protocol family 2
[   29.635306] IP route cache hash table entries: 4096 (order: 3, 32768 bytes)
[   29.635505] TCP established hash table entries: 16384 (order: 5, 131072 bytes)
[   29.635631] TCP bind hash table entries: 8192 (order: 4, 65536 bytes)
[   29.635700] TCP: Hash tables configured (established 16384 bind 8192)
[   29.635709] TCP reno registered
[   29.636782] audit: initializing netlink socket (disabled)
[   29.636819] audit(1172427326.824:1): initialized
[   29.636877] I-pipe: Domain Xenomai registered.
[   29.636896] Xenomai: hal/x86_64 started.
[   29.639998] Xenomai: real-time nucleus v2.4-devel (Bells Of Lal) loaded.
[   29.640312] VFS: Disk quotas dquot_6.5.1
[   29.640358] Dquot-cache hash table entries: 512 (order 0, 4096 bytes)
[   29.640548] io scheduler noop registered
[   29.640558] io scheduler anticipatory registered
[   29.640568] io scheduler deadline registered
[   29.640598] io scheduler cfq registered (default)
[   29.641853] vesafb: framebuffer at 0xf8000000, mapped to 0xffffc20000080000, using 1875k, total 16384k
[   29.641874] vesafb: mode is 800x600x16, linelength=1600, pages=3
[   29.641882] vesafb: scrolling: redraw
[   29.641890] vesafb: Truecolor: size=0:5:6:5, shift=0:11:5:0
[   29.664310] Console: switching to colour frame buffer device 100x37
[   29.686434] fb0: VESA VGA frame buffer device
[   29.694294] Linux agpgart interface v0.101 (c) Dave Jones
[   29.694677] Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing enabled
[   29.695401] serial8250: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
[   29.696296] pnp: the driver 'serial' has been registered
[   29.697960] RAMDISK driver initialized: 16 RAM disks of 65536K size 1024 blocksize
[   29.698767] pnp: the driver 'i8042 kbd' has been registered
[   29.698843] pnp: the driver 'i8042 aux' has been registered
[   29.698988] pnp: the driver 'i8042 kbd' has been unregistered
[   29.699057] pnp: the driver 'i8042 aux' has been unregistered
[   29.699064] PNP: No PS/2 controller found. Probing ports directly.
[   29.700229] serio: i8042 KBD port at 0x60,0x64 irq 1
[   29.700575] serio: i8042 AUX port at 0x60,0x64 irq 12
[   29.701281] mice: PS/2 mouse device common for all mice
[   29.701859] TCP bic registered
[   29.702080] NET: Registered protocol family 1
[   29.702386] NET: Registered protocol family 17
[   29.707511] ACPI: (supports S0 S1 S3 S4 S5)
[   29.712390] Freeing unused kernel memory: 184k freed
[   29.732477] input: AT Translated Set 2 keyboard as /class/input/input0
[   30.337843] ACPI: PCI Interrupt 0000:00:0a.0[A] -> GSI 17 (level, low) -> IRQ 17
[   30.345255] skge 1.9 addr 0xfa700000 irq 17 chip Yukon-Lite rev 9
[   30.352793] skge eth0: addr 00:11:d8:e9:b5:fb
[   30.449509] SCSI subsystem initialized
[   30.485526] libata version 2.00 loaded.
[   30.493279] sata_via 0000:00:0f.0: version 2.0
[   30.493317] ACPI: PCI Interrupt 0000:00:0f.0[B] -> GSI 20 (level, low) -> IRQ 20
[   30.501613] sata_via 0000:00:0f.0: routed to hard irq line 10
[   30.510214] ata1: SATA max UDMA/133 cmd 0xD000 ctl 0xC802 bmdma 0xB800 irq 20
[   30.519228] ata2: SATA max UDMA/133 cmd 0xC400 ctl 0xC002 bmdma 0xB808 irq 20
[   30.528246] scsi0 : sata_via
[   30.594634] Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
[   30.604387] ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
[   30.726952] ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[   30.894355] ata1.00: ATA-7, max UDMA7, 488397168 sectors: LBA48 NCQ (depth 0/32)
[   30.905301] ata1.00: ata1: dev 0 multi count 16
[   30.935067] ata1.00: configured for UDMA/133
[   30.946304] scsi1 : sata_via
[   31.158851] ata2: SATA link down 1.5 Gbps (SStatus 0 SControl 300)
[   31.181362] ATA: abnormal status 0x7F on port 0xC407
[   31.193107] scsi 0:0:0:0: Direct-Access     ATA      SAMSUNG SP2504C  VT10 PQ: 0 ANSI: 5
[   31.207479] VP_IDE: IDE controller at PCI slot 0000:00:0f.1
[   31.219198] ACPI: PCI Interrupt 0000:00:0f.1[A] -> GSI 20 (level, low) -> IRQ 20
[   31.230978] VP_IDE: chipset revision 6
[   31.242439] VP_IDE: not 100% native mode: will probe irqs later
[   31.253966] VP_IDE: VIA vt8237 (rev 00) IDE UDMA133 controller on pci0000:00:0f.1
[   31.265598]     ide0: BM-DMA at 0xfc00-0xfc07, BIOS settings: hda:DMA, hdb:pio
[   31.277623]     ide1: BM-DMA at 0xfc08-0xfc0f, BIOS settings: hdc:DMA, hdd:pio
[   31.289435] Probing IDE interface ide0...
[   31.317834] SCSI device sda: 488397168 512-byte hdwr sectors (250059 MB)
[   31.329845] sda: Write Protect is off
[   31.341705] sda: Mode Sense: 00 3a 00 00
[   31.341775] SCSI device sda: drive cache: write back
[   31.354040] SCSI device sda: 488397168 512-byte hdwr sectors (250059 MB)
[   31.366381] sda: Write Protect is off
[   31.378548] sda: Mode Sense: 00 3a 00 00
[   31.378877] SCSI device sda: drive cache: write back
[   31.391082]  sda: sda1 sda2 sda3
[   31.410925] sd 0:0:0:0: Attached scsi disk sda
[   31.654831] hda: HDT722525DLAT80, ATA DISK drive
[   32.338916] ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
[   32.351238] Probing IDE interface ide1...
[   33.214472] hdc: LITE-ON CD-RW SOHR-5238S, ATAPI CD/DVD-ROM drive
[   33.901638] ide1 at 0x170-0x177,0x376 on irq 15
[   33.952960] hda: max request size: 512KiB
[   33.988265] hda: 488397168 sectors (250059 MB) w/7674KiB Cache, CHS=30401/255/63, UDMA(133)
[   34.000679] hda: cache flushes supported
[   34.012703]  hda: hda1 hda2 hda3 hda4
[   34.044060] hdc: ATAPI 52X CD-ROM CD-R/RW drive, 2048kB Cache, UDMA(33)
[   34.056104] Uniform CD-ROM driver Revision: 3.20
[   34.897873] kjournald starting.  Commit interval 5 seconds
[   34.909134] EXT3-fs: mounted filesystem with ordered data mode.
[   37.511253] pnp: the driver 'parport_pc' has been registered
[   37.512094] parport0: PC-style at 0x378 [PCSPP]
[   37.618227] ACPI: PCI Interrupt 0000:00:0b.0[A] -> GSI 16 (level, low) -> IRQ 16
[   37.629165] PCI parallel port detected: 9710:9805, I/O at 0xa800(0x9800)
[   37.629212] parport1: PC-style at 0xa800 (0x9800) [PCSPP,TRISTATE]
[   37.728159] input: GenPS/2 Genius Mouse as /class/input/input1
[   37.740252] PCI parallel port detected: 9710:9805, I/O at 0x8800(0x8400)
[   37.740300] parport2: PC-style at 0x8800 (0x8400) [PCSPP,TRISTATE]
[   38.763538] Adding 530136k swap on /dev/hda2.  Priority:-1 extents:1 across:530136k
[   38.939202] EXT3 FS on sda2, internal journal
[   39.439813] loop: loaded (max 8 devices)
[   39.786496] kjournald starting.  Commit interval 5 seconds
[   39.801019] EXT3 FS on sda1, internal journal
[   39.812733] EXT3-fs: mounted filesystem with ordered data mode.
[   39.830088] kjournald starting.  Commit interval 5 seconds
[   39.845078] EXT3 FS on sda3, internal journal
[   39.857119] EXT3-fs: mounted filesystem with ordered data mode.
[   40.771274] NET: Registered protocol family 10
[   40.783840] lo: Disabled Privacy Extensions
[   41.531911] skge eth0: enabling interface
[   41.548883] ADDRCONF(NETDEV_UP): eth0: link is not ready
[   43.811193] skge eth0: Link is up at 10 Mbps, half duplex, flow control none
[   43.824030] ADDRCONF(NETDEV_CHANGE): eth0: link becomes ready
[   53.989631] eth0: no IPv6 routers present
[   54.263359] lp0: using parport0 (polling).
[   54.276942] lp1: using parport1 (polling).
[   54.290669] lp2: using parport2 (polling).
[   54.319744] ppdev: user-space parallel port driver
[  129.969601] Xenomai: starting native API services.
[  130.031160] Xenomai: starting RTDM services.
[  185.878488] NMI Watchdog detected LOCKUP on CPU 0
[  185.878940] CPU 0 
[  185.879303] Modules linked in: xeno_timerbench xeno_rtdm xeno_native ppdev lp ipv6 loop tsdev serio_raw i2c_viapro psmouse i2c_core parport_pc parport evdev ide_cd cdrom ide_disk pata_via ata_generic generic sd_mod via82cxxx ide_core sata_via libata scsi_mod skge
[  185.883918] Pid: 2585, comm: sampling-2583 Not tainted 2.6.19.3-xenomai #7
[  185.884532] RIP: 0010:[<ffffffff802581a5>]  [<ffffffff802581a5>] __ipipe_trace+0x145/0x380
[  185.885471] RSP: 0018:ffff81001af73d98  EFLAGS: 00000003
[  185.886005] RAX: 0000000000001000 RBX: ffff81001af73f58 RCX: 000000000000000c
[  185.886655] RDX: ffffffff804d3300 RSI: 0000000000000001 RDI: 0000000000000002
[  185.887307] RBP: ffff81001af73dc8 R08: ffffffff8085d100 R09: 0000000000000001
[  185.887956] R10: 0000000000000000 R11: 0000000000000206 R12: ffffffff80621070
[  185.888606] R13: ffffffff806b87a0 R14: 0000000000000000 R15: 0000000000003c93
[  185.889284] FS:  0000000040021960(0063) GS:ffffffff807e4000(0000) knlGS:0000000000000000
[  185.890002] CS:  0010 DS: 0000 ES: 0000 CR0: 00000000c005003b
[  185.890564] CR2: 00002b2ac9b9e000 CR3: 000000001b0de000 CR4: 00000000000006e0
[  185.891174] I-pipe domain Xenomai
[  185.891528] Stack:  0000000000000292 ffff81001af73f58 0000000000000006 ffff81001b162280
[  185.892714]  0000000058454e4f ffff81001ad60f50 ffff81001af73e48 ffffffff80216522
[  185.893761]  ffffffff88146ea0 0000000000000008 0000000000000038 ffff81001af73f58
[  185.894707] Call Trace:
[  185.895438]  [<ffffffff80216522>] mcount+0x42/0x70
[  186.101834] DWARF2 unwinder stuck at mcount+0x42/0x70
[  186.102291] 
[  186.102545] Leftover inexact backtrace:
[  186.102823] 
[  186.103826]  [<ffffffff88137b79>] :xeno_native:__rt_task_wait_period+0x19/0x90
[  186.104761]  [<ffffffff80264b3b>] hisyscall_event+0x1bb/0x300
[  186.105516]  [<ffffffff80264980>] hisyscall_event+0x0/0x300
[  186.106270]  [<ffffffff80256c77>] __ipipe_dispatch_event+0xc7/0x1b0
[  186.107257]  [<ffffffff802162ed>] __ipipe_syscall_root+0x8d/0x160
[  186.108018]  [<ffffffff8040781f>] __ipipe_syscall_root_thunk+0x35/0x3a
[  186.108950]  [<ffffffff80209ac7>] system_call+0x57/0x9b
[  186.109917] 
[  186.110152] 
[  186.110291] Code: 83 fe 04 74 16 48 8b 52 08 48 8b 42 08 0f 18 08 48 81 fa 10 
[  186.114827]  

--Boundary-00=_Rid4FVOcfiKyv2o
Content-Type: text/plain;
  charset="iso-8859-1";
  name="max"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="max"

I-pipe worst-case tracing service on 2.6.19.3-xenomai/ipipe-1.0-04
------------------------------------------------------------
Begin: 312405493468 cycles, Trace Points: 6 (-10/+1), Length: 4001 us
Calibrated minimum trace-point overhead: 0.037 us

 +----- Hard IRQs ('|': locked)
 |+---- <unused>
 ||+--- <unused>
 |||+-- Xenomai
 ||||+- Linux ('*': domain stalled, '+': current, '#': current+stalled)
 |||||                        +---------- Delay flag ('+': > 1 us, '!': > 10 us)
 |||||                        |        +- NMI noise ('N')
 |||||                        |        |
      Type    User Val.   Time    Delay  Function (Parent)
 |  *+func                  -1    0.277  xnintr_init+0x9 (xnpod_enable_timesource+0x97)
 |  *+func                  -1    0.065  __ipipe_restore_pipeline_head+0x16 (xnpod_enable_timesource+0xbc)
 |   +end     0x80000000    -1    0.261  __ipipe_restore_pipeline_head+0xb1 (xnpod_enable_timesource+0xbc)
     +func                  -1    0.300  rthal_timer_request+0xc (xnpod_enable_timesource+0xc8)
     +func                   0    0.078  rthal_irq_release+0x9 (rthal_timer_request+0x19)
     +func                   0    0.307  ipipe_virtualize_irq+0x21 (rthal_irq_release+0x31)
 |   +begin   0x80000001     0    0.272  ipipe_virtualize_irq+0xa1 (rthal_irq_release+0x31)
 |   +end     0x80000001     0    0.194  ipipe_virtualize_irq+0x1cc (rthal_irq_release+0x31)
     +func                   0    0.054  rthal_critical_enter+0x16 (rthal_timer_request+0x32)
     +func                   0    0.048  ipipe_critical_enter+0xe (rthal_critical_enter+0x1e)
>|   +begin   0x80000001     0! 4000.752  ipipe_critical_enter+0x20 (rthal_critical_enter+0x1e)
:|   +func                4000    0.059  rthal_irq_request+0x9 (rthal_timer_request+0xe0)
:|   +func                4000    0.126  ipipe_virtualize_irq+0x21 (rthal_irq_request+0x3f)
:|   +func                4000    0.060  rthal_critical_exit+0x9 (rthal_timer_request+0xe8)
:|   +func                4000    0.043  ipipe_critical_exit+0xe (rthal_critical_exit+0x14)
<|   +end     0x80000001  4001    0.200  ipipe_critical_exit+0x20 (rthal_critical_exit+0x14)
 |   +begin   0x000000ef  4001    0.000  ipipe_trace_begin_thunk+0x35 (ipipe_critical_exit+0x22)

--Boundary-00=_Rid4FVOcfiKyv2o
Content-Type: text/plain;
  charset="iso-8859-1";
  name="frozen"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="frozen"

I-pipe frozen back-tracing service on 2.6.19.3-xenomai/ipipe-1.0-04
------------------------------------------------------------
Freeze: 434598593698 cycles, Trace Points: 30 (+100)
Calibrated minimum trace-point overhead: 0.037 us

 +----- Hard IRQs ('|': locked)
 |+---- <unused>
 ||+--- <unused>
 |||+-- Xenomai
 ||||+- Linux ('*': domain stalled, '+': current, '#': current+stalled)
 |||||                        +---------- Delay flag ('+': > 1 us, '!': > 10 us)
 |||||                        |        +- NMI noise ('N')
 |||||                        |        |
      Type    User Val.   Time    Delay  Function (Parent)
:|  +*func                -244+   6.981  __ipipe_handle_irq+0x21 (common_interrupt+0x78)
:|  +*func                -238+   6.956  __ipipe_ack_apic+0x9 (__ipipe_handle_irq+0x87)
:|  +*func                -231+   7.615  __ipipe_dispatch_wired+0xc (__ipipe_handle_irq+0x91)
:|  #*func                -223+   6.951  xnintr_clock_handler+0x9 (__ipipe_dispatch_wired+0x94)
:|  #*func                -216+   7.210  xnintr_irq_handler+0x21 (xnintr_clock_handler+0x1b)
:|  #*func                -209+   6.806  xnpod_announce_tick+0x9 (xnintr_irq_handler+0x53)
:|  #*func                -202+   8.189  xntimer_tick_aperiodic+0x12 (xnpod_announce_tick+0xe)
:|  #*func                -194!  15.715  xnthread_periodic_handler+0x9 (xntimer_tick_aperiodic+0x88)
:|  +*func                -178+   7.395  __ipipe_walk_pipeline+0x10 (__ipipe_handle_irq+0x1d2)
:|  +*end     0x00000128  -171+   7.640  __ipipe_handle_irq+0x1da (common_interrupt+0x78)
:|  +*end     0x80000000  -163!  10.317  __ipipe_trace_irqs_on+0xe (__ipipe_trace_irqs_on_thunk+0x35)
:|  +*begin   0x000000f7  -153+   9.672  ipipe_trace_begin_thunk+0x35 (__ipipe_trace+0x364)
:|  +*begin   0x80000000  -143+   7.570  __ipipe_trace_irqs_off+0xe (__ipipe_trace_irqs_off_thunk+0x35)
:|  +*func                -135+   6.981  __ipipe_handle_irq+0x21 (common_interrupt+0x78)
:|  +*func                -128+   6.981  __ipipe_ack_apic+0x9 (__ipipe_handle_irq+0x87)
:|  +*func                -122+   7.615  __ipipe_dispatch_wired+0xc (__ipipe_handle_irq+0x91)
:|  #*func                -114+   6.976  xnintr_clock_handler+0x9 (__ipipe_dispatch_wired+0x94)
:|  #*func                -107+   7.210  xnintr_irq_handler+0x21 (xnintr_clock_handler+0x1b)
:|  #*func                -100+   6.756  xnpod_announce_tick+0x9 (xnintr_irq_handler+0x53)
:|  #*func                 -93+   8.159  xntimer_tick_aperiodic+0x12 (xnpod_announce_tick+0xe)
:|  #*func                 -85!  15.995  xnthread_periodic_handler+0x9 (xntimer_tick_aperiodic+0x88)
:|  +*func                 -69+   7.310  __ipipe_walk_pipeline+0x10 (__ipipe_handle_irq+0x1d2)
:|  +*end     0x00000128   -61+   7.695  __ipipe_handle_irq+0x1da (common_interrupt+0x78)
:|  +*end     0x80000000   -54!  13.617  __ipipe_trace_irqs_on+0xe (__ipipe_trace_irqs_on_thunk+0x35)
:   +*func                 -40+   7.240  xnshadow_sys_trace+0x16 (hisyscall_event+0x1bb)
:   +*func                 -33+   6.606  ipipe_trace_frozen_reset+0xa (xnshadow_sys_trace+0x8a)
:   +*func                 -26+   7.126  __ipipe_global_path_lock+0xa (ipipe_trace_frozen_reset+0x14)
:|  +*begin   0x80000001   -19!  12.339  __ipipe_global_path_lock+0x1c (ipipe_trace_frozen_reset+0x14)
:|  +*end     0x80000001    -7+   7.360  __ipipe_global_path_unlock+0x62 (ipipe_trace_frozen_reset+0x61)
<   +*freeze  0x002e883e     0    9.153  xnshadow_sys_trace+0x94 (hisyscall_event+0x1bb)
 |  +*begin   0x80000001     9    7.275  __ipipe_dispatch_event+0xe9 (__ipipe_syscall_root+0x8d)
 |  +*end     0x80000001    16    7.760  __ipipe_dispatch_event+0x191 (__ipipe_syscall_root+0x8d)
 |  +*begin   0x000000f7    24    8.069  ipipe_trace_begin_thunk+0x35 (__ipipe_dispatch_event+0x194)
 |  +*begin   0x80000000    32    7.580  __ipipe_trace_irqs_off+0xe (__ipipe_trace_irqs_off_thunk+0x35)
 |  +*func                  39    7.196  __ipipe_handle_irq+0x21 (common_interrupt+0x78)
 |  +*func                  47    7.096  __ipipe_ack_apic+0x9 (__ipipe_handle_irq+0x87)
 |  +*func                  54    7.830  __ipipe_dispatch_wired+0xc (__ipipe_handle_irq+0x91)
 |  #*func                  61    6.896  xnintr_clock_handler+0x9 (__ipipe_dispatch_wired+0x94)
 |  #*func                  68    7.440  xnintr_irq_handler+0x21 (xnintr_clock_handler+0x1b)
 |  #*func                  76    6.771  xnpod_announce_tick+0x9 (xnintr_irq_handler+0x53)
 |  #*func                  83    8.419  xntimer_tick_aperiodic+0x12 (xnpod_announce_tick+0xe)
 |  #*func                  91   15.880  xnthread_periodic_handler+0x9 (xntimer_tick_aperiodic+0x88)
 |  +*func                 107    7.555  __ipipe_walk_pipeline+0x10 (__ipipe_handle_irq+0x1d2)
 |  +*end     0x00000128   114    7.795  __ipipe_handle_irq+0x1da (common_interrupt+0x78)
 |  +*end     0x80000000   122   10.287  __ipipe_trace_irqs_on+0xe (__ipipe_trace_irqs_on_thunk+0x35)
 |  +*begin   0x000000f7   133    8.029  ipipe_trace_begin_thunk+0x35 (__ipipe_dispatch_event+0x194)
 |  +*begin   0x80000000   141    7.590  __ipipe_trace_irqs_off+0xe (__ipipe_trace_irqs_off_thunk+0x35)
 |  +*func                 148    7.196  __ipipe_handle_irq+0x21 (common_interrupt+0x78)
 |  +*func                 155    7.091  __ipipe_ack_apic+0x9 (__ipipe_handle_irq+0x87)
 |  +*func                 162    7.830  __ipipe_dispatch_wired+0xc (__ipipe_handle_irq+0x91)
 |  #*func                 170    6.851  xnintr_clock_handler+0x9 (__ipipe_dispatch_wired+0x94)
 |  #*func                 177    7.440  xnintr_irq_handler+0x21 (xnintr_clock_handler+0x1b)
 |  #*func                 185    6.771  xnpod_announce_tick+0x9 (xnintr_irq_handler+0x53)
 |  #*func                 191    8.424  xntimer_tick_aperiodic+0x12 (xnpod_announce_tick+0xe)
 |  #*func                 200   15.920  xnthread_periodic_handler+0x9 (xntimer_tick_aperiodic+0x88)
 |  +*func                 216    7.545  __ipipe_walk_pipeline+0x10 (__ipipe_handle_irq+0x1d2)
 |  +*end     0x00000128   223    7.815  __ipipe_handle_irq+0x1da (common_interrupt+0x78)
 |  +*end     0x80000000   231   10.287  __ipipe_trace_irqs_on+0xe (__ipipe_trace_irqs_on_thunk+0x35)
 |  +*begin   0x000000f7   241    8.029  ipipe_trace_begin_thunk+0x35 (__ipipe_dispatch_event+0x194)
 |  +*begin   0x80000000   249    7.610  __ipipe_trace_irqs_off+0xe (__ipipe_trace_irqs_off_thunk+0x35)
 |  +*func                 257    7.196  __ipipe_handle_irq+0x21 (common_interrupt+0x78)
 |  +*func                 264    7.091  __ipipe_ack_apic+0x9 (__ipipe_handle_irq+0x87)
 |  +*func                 271    7.890  __ipipe_dispatch_wired+0xc (__ipipe_handle_irq+0x91)
 |  #*func                 279    6.851  xnintr_clock_handler+0x9 (__ipipe_dispatch_wired+0x94)
 |  #*func                 286    7.475  xnintr_irq_handler+0x21 (xnintr_clock_handler+0x1b)
 |  #*func                 293    6.776  xnpod_announce_tick+0x9 (xnintr_irq_handler+0x53)
 |  #*func                 300    8.384  xntimer_tick_aperiodic+0x12 (xnpod_announce_tick+0xe)
 |  #*func                 309   15.975  xnthread_periodic_handler+0x9 (xntimer_tick_aperiodic+0x88)
 |  +*func                 325    7.545  __ipipe_walk_pipeline+0x10 (__ipipe_handle_irq+0x1d2)
 |  +*end     0x00000128   332    7.730  __ipipe_handle_irq+0x1da (common_interrupt+0x78)
 |  +*end     0x80000000   340   10.337  __ipipe_trace_irqs_on+0xe (__ipipe_trace_irqs_on_thunk+0x35)
 |  +*begin   0x000000f7   350    8.029  ipipe_trace_begin_thunk+0x35 (__ipipe_dispatch_event+0x194)
 |  +*begin   0x80000000   358    7.615  __ipipe_trace_irqs_off+0xe (__ipipe_trace_irqs_off_thunk+0x35)
 |  +*func                 366    7.196  __ipipe_handle_irq+0x21 (common_interrupt+0x78)
 |  +*func                 373    7.041  __ipipe_ack_apic+0x9 (__ipipe_handle_irq+0x87)
 |  +*func                 380    7.870  __ipipe_dispatch_wired+0xc (__ipipe_handle_irq+0x91)
 |  #*func                 388    6.851  xnintr_clock_handler+0x9 (__ipipe_dispatch_wired+0x94)
 |  #*func                 395    7.390  xnintr_irq_handler+0x21 (xnintr_clock_handler+0x1b)
 |  #*func                 402    6.826  xnpod_announce_tick+0x9 (xnintr_irq_handler+0x53)
 |  #*func                 409    8.384  xntimer_tick_aperiodic+0x12 (xnpod_announce_tick+0xe)
 |  #*func                 417   16.289  xnthread_periodic_handler+0x9 (xntimer_tick_aperiodic+0x88)
 |  +*func                 434    7.555  __ipipe_walk_pipeline+0x10 (__ipipe_handle_irq+0x1d2)
 |  +*end     0x00000128   441    7.715  __ipipe_handle_irq+0x1da (common_interrupt+0x78)
 |  +*end     0x80000000   449   10.262  __ipipe_trace_irqs_on+0xe (__ipipe_trace_irqs_on_thunk+0x35)
 |  +*begin   0x80000000   459   11.181  __ipipe_syscall_root+0x14b (__ipipe_syscall_root_thunk+0x35)
    +*func                 470    7.385  __ipipe_syscall_root+0xc (__ipipe_syscall_root_thunk+0x35)
    +*func                 478    6.806  __ipipe_dispatch_event+0x16 (__ipipe_syscall_root+0x8d)
 |  +*begin   0x80000001   485    7.410  __ipipe_dispatch_event+0x37 (__ipipe_syscall_root+0x8d)
 |  +*end     0x80000001   492    6.746  __ipipe_dispatch_event+0xb6 (__ipipe_syscall_root+0x8d)
    +*func                 499    9.353  hisyscall_event+0x21 (__ipipe_dispatch_event+0xc7)
    +*func                 508    7.136  __rt_task_wait_period+0x19 [xeno_native] (hisyscall_event+0x1bb)
    +*func                 515    6.486  rt_task_wait_period+0x9 [xeno_native] (__rt_task_wait_period+0x4f [xeno_native])
 |  +*begin   0x000000f7   522    8.104  ipipe_trace_begin_thunk+0x35 (__ipipe_trace+0x364)
 |  +*begin   0x80000000   530    7.595  __ipipe_trace_irqs_off+0xe (__ipipe_trace_irqs_off_thunk+0x35)
 |  +*func                 537    7.245  __ipipe_handle_irq+0x21 (common_interrupt+0x78)
 |  +*func                 545    7.096  __ipipe_ack_apic+0x9 (__ipipe_handle_irq+0x87)
 |  +*func                 552    7.895  __ipipe_dispatch_wired+0xc (__ipipe_handle_irq+0x91)
 |  #*func                 560    6.836  xnintr_clock_handler+0x9 (__ipipe_dispatch_wired+0x94)
 |  #*func                 567    7.355  xnintr_irq_handler+0x21 (xnintr_clock_handler+0x1b)
 |  #*func                 574    6.816  xnpod_announce_tick+0x9 (xnintr_irq_handler+0x53)
 |  #*func                 581    8.389  xntimer_tick_aperiodic+0x12 (xnpod_announce_tick+0xe)
 |  #*func                 589   15.975  xnthread_periodic_handler+0x9 (xntimer_tick_aperiodic+0x88)
 |  +*func                 605    7.560  __ipipe_walk_pipeline+0x10 (__ipipe_handle_irq+0x1d2)
 |  +*end     0x00000128   613    7.650  __ipipe_handle_irq+0x1da (common_interrupt+0x78)
 |  +*end     0x80000000   620   10.411  __ipipe_trace_irqs_on+0xe (__ipipe_trace_irqs_on_thunk+0x35)
 |  +*begin   0x000000f7   631    8.099  ipipe_trace_begin_thunk+0x35 (__ipipe_trace+0x364)
 |  +*begin   0x80000000   639    7.555  __ipipe_trace_irqs_off+0xe (__ipipe_trace_irqs_off_thunk+0x35)
 |  +*func                 646    7.220  __ipipe_handle_irq+0x21 (common_interrupt+0x78)
 |  +*func                 654    7.081  __ipipe_ack_apic+0x9 (__ipipe_handle_irq+0x87)
 |  +*func                 661    7.880  __ipipe_dispatch_wired+0xc (__ipipe_handle_irq+0x91)
 |  #*func                 669    6.896  xnintr_clock_handler+0x9 (__ipipe_dispatch_wired+0x94)
 |  #*func                 675    7.395  xnintr_irq_handler+0x21 (xnintr_clock_handler+0x1b)
 |  #*func                 683    6.836  xnpod_announce_tick+0x9 (xnintr_irq_handler+0x53)
 |  #*func                 690    8.384  xntimer_tick_aperiodic+0x12 (xnpod_announce_tick+0xe)
 |  #*func                 698   15.940  xnthread_periodic_handler+0x9 (xntimer_tick_aperiodic+0x88)
 |  +*func                 714    7.610  __ipipe_walk_pipeline+0x10 (__ipipe_handle_irq+0x1d2)
 |  +*end     0x00000128   722    7.650  __ipipe_handle_irq+0x1da (common_interrupt+0x78)
 |  +*end     0x80000000   729   10.401  __ipipe_trace_irqs_on+0xe (__ipipe_trace_irqs_on_thunk+0x35)
 |  +*begin   0x000000f7   740    8.124  ipipe_trace_begin_thunk+0x35 (__ipipe_trace+0x364)
 |  +*begin   0x80000000   748    7.560  __ipipe_trace_irqs_off+0xe (__ipipe_trace_irqs_off_thunk+0x35)
 |  +*func                 755    7.225  __ipipe_handle_irq+0x21 (common_interrupt+0x78)
 |  +*func                 763    7.081  __ipipe_ack_apic+0x9 (__ipipe_handle_irq+0x87)
 |  +*func                 770    7.845  __ipipe_dispatch_wired+0xc (__ipipe_handle_irq+0x91)
 |  #*func                 777    6.901  xnintr_clock_handler+0x9 (__ipipe_dispatch_wired+0x94)
 |  #*func                 784    7.340  xnintr_irq_handler+0x21 (xnintr_clock_handler+0x1b)
 |  #*func                 792    6.786  xnpod_announce_tick+0x9 (xnintr_irq_handler+0x53)
 |  #*func                 798    8.474  xntimer_tick_aperiodic+0x12 (xnpod_announce_tick+0xe)
 |  #*func                 807   15.950  xnthread_periodic_handler+0x9 (xntimer_tick_aperiodic+0x88)
 |  +*func                 823    7.990  __ipipe_walk_pipeline+0x10 (__ipipe_handle_irq+0x1d2)
 |  +*end     0x00000128   831    0.000  __ipipe_handle_irq+0x1da (common_interrupt+0x78)

--Boundary-00=_Rid4FVOcfiKyv2o--

