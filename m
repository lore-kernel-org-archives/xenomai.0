From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <46BEF1FE.8040508@domain.hid>
References: <46BC4DCE.80003@domain.hid>  <46BC5033.5040602@domain.hid>
	<1186761724.6006.6.camel@domain.hid>  <46BCA91A.1050209@domain.hid>
	<1186769510.6006.22.camel@domain.hid>  <46BEF1FE.8040508@domain.hid>
Content-Type: text/plain
Date: Sun, 12 Aug 2007 17:44:02 +0200
Message-Id: <1186933442.6006.67.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: Philippe Gerum <philippe.gerum@domain.hid>
Subject: Re: [Xenomai-core] [2.6.22-BUG] inconsistent Linux IRQ mask
Reply-To: rpm@xenomai.org
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
Cc: xenomai-core <xenomai@xenomai.org>

On Sun, 2007-08-12 at 13:41 +0200, Jan Kiszka wrote:
> Philippe Gerum wrote:
> > On Fri, 2007-08-10 at 20:06 +0200, Jan Kiszka wrote:
> >> Philippe Gerum wrote:
> >>> On Fri, 2007-08-10 at 13:46 +0200, Jan Kiszka wrote:
> >>>> Jan Kiszka wrote:
> >>>>> Hi Philippe,
> >>>>>
> >>>>> this appears to be related to 2.6.22+ only:
> >>>>>
> >>>>>  ------------[ cut here ]------------
> >>>>>  kernel BUG at fs/buffer.c:1230!
> >>>>>  invalid opcode: 0000 [#1]
> >>>>>  PREEMPT
> >>>>>  Modules linked in: xeno_rtdm xeno_nucleus ip6t_LOG xt_TCPMSS nvram uinput snd_pcm_oss cifs snd_mixer_oss snd_seq snd_seq_device radeon drm wlan_tkip af_packet thinkpad_acpi button battery ac ip6t_REJECT xt_state iptable_nat nf_nat ip6table_mangle nf_conntrack_ipv4 nf_conntrack nfnetlink ip6table_filter ip6_tables ipv6 nls_iso8859_1 nls_cp437 vfat fat nls_utf8 ntfs dm_mod fuse wlan_scan_sta ath_rate_sample pcmcia snd_intel8x0 firmware_class snd_ac97_codec ac97_bus snd_pcm ath_pci nsc_ircc wlan ide_cd irda snd_timer e100 cdrom ath_hal(P) snd i2c_i801 uhci_hcd ehci_hcd mii yenta_socket rsrc_nonstatic soundcore usbcore snd_page_alloc i2c_core intel_agp crc_ccitt pcmcia_core agpgart parport_pc lp parport reiserfs edd fan piix ide_disk ide_core
> >>>>>  CPU:    0
> >>>>>  EIP:    0060:[<c0187fc3>]    Tainted: P       VLI
> >>>>>  EFLAGS: 00210246   (2.6.22.2-adeos #7)
> >>>>>  EIP is at __find_get_block+0x2c/0x1e8
> >>>>>  eax: 00000000   ebx: e3635dac   ecx: 00000000   edx: 00002e4e
> >>>>>  esi: 00001000   edi: eeeb3080   ebp: e3635b30   esp: e3635af8
> >>>>>  ds: 007b   es: 007b   fs: 0000  gs: 0033  ss: 0068
> >>>>>  Process kio_file (pid: 7433, ti=e3634000 task=e6d780b0 task.ti=e3634000)<0>
> >>>>>  I-pipe domain Linux
> >>>>>  Stack: 00002e4e 00000000 c16e0718 eff36a90 e3634000 e3635b1c c0308f1e c05dd700
> >>>>>         00000000 e3635b2c c030bbfd e3635dac 00001000 e3635db4 e3635b98 c01881a4
> >>>>>         00001000 c05dd700 511c5a51 00000022 c014aade 00002e4e 00000000 eeeb3080
> >>>>>  Call Trace:
> >>>>>   [<c0104fd0>] show_trace_log_lvl+0x1f/0x34
> >>>>>   [<c0105085>] show_stack_log_lvl+0xa0/0xa8
> >>>>>   [<c0105294>] show_registers+0x207/0x35c
> >>>>>   [<c01054fd>] die+0x114/0x22a
> >>>>>   [<c01056a1>] do_trap+0x8e/0xa7
> >>>>>   [<c0105a2f>] do_invalid_op+0x8d/0x97
> >>>>>   [<c0113b1a>] __ipipe_handle_exception+0xb1/0x11f
> >>>>>   [<c030be53>] error_code+0x6f/0x7c
> >>>>>   [<c01881a4>] __getblk+0x25/0x29a
> >>>>>   [<f0bdc058>] search_by_key+0x97/0xe38 [reiserfs]
> >>>>>   [<f0bc6c10>] search_by_entry_key+0x20/0x231 [reiserfs]
> >>>>>   [<f0bc6e96>] reiserfs_find_entry+0x75/0x2d0 [reiserfs]
> >>>>>   [<f0bc7643>] reiserfs_lookup+0x6d/0x122 [reiserfs]
> >>>>> ...
> >>>>>
> >>>>> I get this over 2.6.22.2 with latest trunk + ipipe-1.9-03, only
> >>>>> modprobe'ing xeno_rtdm (so that the nucleus becomes active) and then
> >>>>> logging into KDE. Same box, same Xenomai, but 2.6.20.15: no problem at
> >>>>> all (also xeno-text runs fine here, BTW). When Xenomai is inactive,
> >>>>> 2.6.22 makes no problems as well. Note that the tracer is compiled in,
> >>>>> but is deactivated. Activating it (with the hope to get a panic
> >>>>> backtrace) makes the issue disappear as well.
> >>>> Ah, and then there was this warning once (same kernel that reliably BUGs):
> >>>>
> >>>> WARNING: at kernel/softirq.c:138 local_bh_enable()
> >>>>  [<c0104fd0>] show_trace_log_lvl+0x1f/0x34
> >>>>  [<c0105c62>] show_trace+0x17/0x19
> >>>>  [<c0105cfc>] dump_stack+0x1a/0x1c
> >>>>  [<c011f38a>] local_bh_enable+0x53/0xb3
> >>>>  [<c028b6d5>] lock_sock_nested+0xbe/0xc6
> >>>>  [<c0288feb>] sock_fasync+0x68/0x125
> >>>>  [<c028a0f3>] sock_close+0x2a/0x38
> >>>>  [<c016bc1a>] __fput+0xb9/0x195
> >>>>  [<c016bd11>] fput+0x1b/0x1d
> >>>>  [<c0169572>] filp_close+0x59/0x61
> >>>>  [<c016a5cd>] sys_close+0x73/0xab
> >>>>  [<c0103f05>] sysenter_past_esp+0x6e/0x72
> >>>>
> >>>> Probably a different symptom of the same bug.
> >>>>
> >>> Does this disappear with PREEMPT off?
> >>>
> >> Nope.
> > 
> > Good.
> > 
> 
> Hmm, whatever this means.
> 

This means you could disable all the invasive PREEMPT machinery and
still produce the bug, which is good and generally simplifies debugging.
I cannot address this issue yet, I will get back to it later when time
allows.

> In case you have no clue yet what goes wrong, here comes a panic
> backtrace I was finally able to get hold of:
> 

Thanks. Will have a look at this.

> 
> Linux version 2.6.22.2-adeos (kiszka@domain.hid) (gcc version 4.1.2 20061115 (prerelease) (SUSE Linux)) #12 Sun Aug 12 12:47:31 CEST 2007
> BIOS-provided physical RAM map:
>  BIOS-e820: 0000000000000000 - 000000000009f000 (usable)
>  BIOS-e820: 000000000009f000 - 00000000000a0000 (reserved)
>  BIOS-e820: 00000000000e0000 - 0000000000100000 (reserved)
>  BIOS-e820: 0000000000100000 - 000000002ff60000 (usable)
>  BIOS-e820: 000000002ff60000 - 000000002ff79000 (ACPI data)
>  BIOS-e820: 000000002ff79000 - 000000002ff7b000 (ACPI NVS)
>  BIOS-e820: 000000002ff80000 - 0000000030000000 (reserved)
>  BIOS-e820: 00000000ff800000 - 0000000100000000 (reserved)
> 767MB LOWMEM available.
> Entering add_active_range(0, 0, 196448) 0 entries of 256 used
> Zone PFN ranges:
>   DMA             0 ->     4096
>   Normal       4096 ->   196448
> early_node_map[1] active PFN ranges
>     0:        0 ->   196448
> On node 0 totalpages: 196448
>   DMA zone: 32 pages used for memmap
>   DMA zone: 0 pages reserved
>   DMA zone: 4064 pages, LIFO batch:0
>   Normal zone: 1502 pages used for memmap
>   Normal zone: 190850 pages, LIFO batch:31
> DMI present.
> ACPI: RSDP 000F6D30, 0024 (r2 IBM   )
> ACPI: XSDT 2FF6EDB7, 004C (r1 IBM    TP-1P        1330  LTP        0)
> ACPI: FACP 2FF6EF00, 00F4 (r3 IBM    TP-1P        1330 IBM         1)
> ACPI Warning (tbfadt-0434): Optional field "Gpe1Block" has zero address or length: 000000000000102C/0 [20070126]
> ACPI: DSDT 2FF6F0E7, 9DEB (r1 IBM    TP-1P        1330 MSFT  100000E)
> ACPI: FACS 2FF7A000, 0040
> ACPI: SSDT 2FF6F0B4, 0033 (r1 IBM    TP-1P        1330 MSFT  100000E)
> ACPI: ECDT 2FF78ED2, 0052 (r1 IBM    TP-1P        1330 IBM         1)
> ACPI: TCPA 2FF78F24, 0032 (r1 IBM    TP-1P        1330 PTL         1)
> ACPI: BOOT 2FF78FD8, 0028 (r1 IBM    TP-1P        1330  LTP        1)
> ACPI: PM-Timer IO Port: 0x1008
> Allocating PCI resources starting at 40000000 (gap: 30000000:cf800000)
> Built 1 zonelists.  Total pages: 194914
> Kernel command line: root=/dev/hda5 vga=0x317 selinux=0 resume=/dev/hda7 lapic nmi_watchdog=0
> Local APIC disabled by BIOS -- reenabling.
> Found and enabled local APIC!
> mapped APIC to ffffd000 (fee00000)
> Enabling fast FPU save and restore... done.
> Enabling unmasked SIMD FPU exception support... done.
> Initializing CPU#0
> PID hash table entries: 4096 (order: 12, 16384 bytes)
> Detected 1298.960 MHz processor.
> I-pipe 1.9-03: pipeline enabled.
> Console: colour dummy device 80x25
> Lock dependency validator: Copyright (c) 2006 Red Hat, Inc., Ingo Molnar
> ... MAX_LOCKDEP_SUBCLASSES:    8
> ... MAX_LOCK_DEPTH:          30
> ... MAX_LOCKDEP_KEYS:        2048
> ... CLASSHASH_SIZE:           1024
> ... MAX_LOCKDEP_ENTRIES:     8192
> ... MAX_LOCKDEP_CHAINS:      16384
> ... CHAINHASH_SIZE:          8192
>  memory used by lock dependency info: 992 kB
>  per task-struct memory footprint: 1200 bytes
> Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
> Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
> Memory: 767700k/785792k available (2067k kernel code, 17516k reserved, 2603k data, 204k init, 0k highmem)
> virtual kernel memory layout:
>     fixmap  : 0xfffb7000 - 0xfffff000   ( 288 kB)
>     vmalloc : 0xf0800000 - 0xfffb5000   ( 247 MB)
>     lowmem  : 0xc0000000 - 0xeff60000   ( 767 MB)
>       .init : 0xc0592000 - 0xc05c5000   ( 204 kB)
>       .data : 0xc0304ef1 - 0xc058fcdc   (2603 kB)
>       .text : 0xc0100000 - 0xc0304ef1   (2067 kB)
> Checking if this processor honours the WP bit even in supervisor mode... Ok.
> Calibrating delay using timer specific routine.. 2599.44 BogoMIPS (lpj=5198888)
> Mount-cache hash table entries: 512
> CPU: After generic identify, caps: a7e9fbbf 00000000 00000000 00000000 00000180 00000000 00000000
> CPU: L1 I cache: 32K, L1 D cache: 32K
> CPU: L2 cache: 1024K
> CPU: After all inits, caps: a7e9fbbf 00000000 00000000 00002040 00000180 00000000 00000000
> Intel machine check architecture supported.
> Intel machine check reporting enabled on CPU#0.
> Compat vDSO mapped to ffffe000.
> CPU: Intel(R) Pentium(R) M processor 1300MHz stepping 05
> Checking 'hlt' instruction... OK.
> ACPI: Core revision 20070126
> ACPI: setting ELCR to 0200 (from 0e00)
> NET: Registered protocol family 16
> ACPI: bus type pci registered
> PCI: PCI BIOS revision 2.10 entry at 0xfd936, last bus=5
> PCI: Using configuration type 1
> Setting up standard PCI resources
> ACPI: Interpreter enabled
> ACPI: (supports S0 S3 S4 S5)
> ACPI: Using PIC for interrupt routing
> ACPI: PCI Root Bridge [PCI0] (0000:00)
> PCI: Probing PCI hardware (bus 00)
> PCI quirk: region 1000-107f claimed by ICH4 ACPI/GPIO/TCO
> PCI quirk: region 1180-11bf claimed by ICH4 GPIO
> PCI: Firmware left 0000:02:08.0 e100 interrupts enabled, disabling
> PCI: Transparent bridge - 0000:00:1e.0
> ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
> ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.AGP_._PRT]
> ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PCI1._PRT]
> ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 7 9 10 *11)
> ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 7 *9 10 11)
> ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 6 7 9 10 *11)
> ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 6 7 9 10 *11)
> ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 6 7 9 *10 11)
> ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 6 7 9 10 11) *0, disabled.
> ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 5 6 7 9 10 11) *0, disabled.
> ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 5 6 7 9 10 *11)
> ACPI: Power Resource [PUBS] (on)
> Linux Plug and Play Support v0.97 (c) Adam Belay
> pnp: PnP ACPI init
> ACPI: bus type pnp registered
> pnp: PnP ACPI: found 12 devices
> ACPI: ACPI bus type pnp unregistered
> PCI: Using ACPI for IRQ routing
> PCI: If a device doesn't work, try "pci=routeirq".  If it helps, post a report
> pnp: 00:00: iomem range 0x0-0x9ffff could not be reserved
> pnp: 00:00: iomem range 0xc0000-0xc3fff could not be reserved
> pnp: 00:00: iomem range 0xc4000-0xc7fff could not be reserved
> pnp: 00:00: iomem range 0xc8000-0xcbfff could not be reserved
> Time: tsc clocksource has been installed.
> PCI: Bridge: 0000:00:01.0
>   IO window: 3000-3fff
>   MEM window: c0100000-c01fffff
>   PREFETCH window: e0000000-e7ffffff
> PCI: Bus 3, cardbus bridge: 0000:02:00.0
>   IO window: 00004000-000040ff
>   IO window: 00004400-000044ff
>   PREFETCH window: e8000000-ebffffff
>   MEM window: c4000000-c7ffffff
> PCI: Bridge: 0000:00:1e.0
>   IO window: 4000-8fff
>   MEM window: c0200000-cfffffff
>   PREFETCH window: e8000000-efffffff
> PCI: Setting latency timer of device 0000:00:1e.0 to 64
> ACPI: PCI Interrupt Link [LNKD] enabled at IRQ 11
> PCI: setting IRQ 11 as level-triggered
> ACPI: PCI Interrupt 0000:02:00.0[A] -> Link [LNKD] -> GSI 11 (level, low) -> IRQ 11
> NET: Registered protocol family 2
> IP route cache hash table entries: 32768 (order: 5, 131072 bytes)
> TCP established hash table entries: 65536 (order: 9, 2883584 bytes)
> TCP bind hash table entries: 65536 (order: 9, 2883584 bytes)
> TCP: Hash tables configured (established 65536 bind 65536)
> TCP reno registered
> checking if image is initramfs... it is
> Freeing initrd memory: 3065k freed
> Switched to high resolution mode on CPU 0
> Simple Boot Flag at 0x35 set to 0x1
> audit: initializing netlink socket (disabled)
> audit(1186924402.672:1): initialized
> Total HugeTLB memory allocated, 0
> VFS: Disk quotas dquot_6.5.1
> Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)
> io scheduler noop registered
> io scheduler anticipatory registered (default)
> io scheduler deadline registered
> io scheduler cfq registered
> Boot video device is 0000:01:00.0
> vesafb: framebuffer at 0xe0000000, mapped to 0xf0880000, using 3072k, total 32768k
> vesafb: mode is 1024x768x16, linelength=2048, pages=20
> vesafb: protected mode interface info at c000:53cf
> vesafb: pmi: set display start = c00c5463, set palette = c00c54af
> vesafb: pmi: ports = 3010 3016 3054 3038 303c 305c 3000 3004 30b0 30b2 30b4 
> vesafb: scrolling: redraw
> vesafb: Truecolor: size=0:5:6:5, shift=0:11:5:0
> Console: switching to colour frame buffer device 128x48
> fb0: VESA VGA frame buffer device
> isapnp: Scanning for PnP cards...
> isapnp: No Plug & Play device found
> Real Time Clock Driver v1.12ac
> intel_rng: FWH not detected
> Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing enabled
> pnp: Device 00:09 activated.
> 00:09: ttyS0 at I/O 0x3f8 (irq = 4) is a NS16550A
> ACPI: PCI Interrupt Link [LNKB] enabled at IRQ 9
> PCI: setting IRQ 9 as level-triggered
> ACPI: PCI Interrupt 0000:00:1f.6[B] -> Link [LNKB] -> GSI 9 (level, low) -> IRQ 9
> ACPI: PCI interrupt for device 0000:00:1f.6 disabled
> floppy0: no floppy controllers found
> RAMDISK driver initialized: 16 RAM disks of 64000K size 1024 blocksize
> loop: module loaded
> PNP: PS/2 Controller [PNP0303:KBD,PNP0f13:MOU] at 0x60,0x64 irq 1,12
> serio: i8042 KBD port at 0x60,0x64 irq 1
> serio: i8042 AUX port at 0x60,0x64 irq 12
> mice: PS/2 mouse device common for all mice
> input: AT Translated Set 2 keyboard as /class/input/input0
> input: PC Speaker as /class/input/input1
> Synaptics Touchpad, model: 1, fw: 5.9, id: 0x2c6ab1, caps: 0x884793/0x0
> serio: Synaptics pass-through port at isa0060/serio1/input0
> input: SynPS/2 Synaptics TouchPad as /class/input/input2
> ip_tables: (C) 2000-2006 Netfilter Core Team
> arp_tables: (C) 2002 David S. Miller
> NET: Registered protocol family 1
> Using IPI Shortcut mode
> Freeing unused kernel memory: 204k freed
> Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
> ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
> ICH4: IDE controller at PCI slot 0000:00:1f.1
> PCI: Enabling device 0000:00:1f.1 (0005 -> 0007)
> ACPI: PCI Interrupt Link [LNKC] enabled at IRQ 11
> ACPI: PCI Interrupt 0000:00:1f.1[A] -> Link [LNKC] -> GSI 11 (level, low) -> IRQ 11
> ICH4: chipset revision 1
> ICH4: not 100% native mode: will probe irqs later
>     ide0: BM-DMA at 0x1860-0x1867, BIOS settings: hda:DMA, hdb:pio
>     ide1: BM-DMA at 0x1868-0x186f, BIOS settings: hdc:DMA, hdd:pio
> Probing IDE interface ide0...
> hda: FUJITSU MHS2030AT, ATA DISK drive
> hda: selected mode 0x45
> ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
> hda: max request size: 128KiB
> hda: 58605120 sectors (30005 MB) w/2048KiB Cache, CHS=62016/15/63, UDMA(100)
> hda: cache flushes supported
>  hda: hda1 hda2 hda3 < hda5 hda6 hda7 > hda4
> Probing IDE interface ide1...
> hdc: HL-DT-STCD-RW/DVD DRIVE GCC-4240N, ATAPI CD/DVD-ROM drive
> hdc: selected mode 0x42
> ide1 at 0x170-0x177,0x376 on irq 15
> BIOS EDD facility v0.16 2004-Jun-25, 1 devices found
> swsusp: Basic memory bitmaps created
> swsusp: Basic memory bitmaps freed
> Attempting manual resume
> IBM TrackPoint firmware: 0x0e, buttons: 3/3
> ReiserFS: hda5: found reiserfs format "3.6" with standard journal
> ReiserFS: hda5: using ordered data mode
> ReiserFS: hda5: journal params: device hda5, size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
> ReiserFS: hda5: checking transaction log (hda5)
> input: TPPS/2 IBM TrackPoint as /class/input/input3
> ReiserFS: hda5: Using r5 hash to sort names
> parport_pc 00:0a: reported by Plug and Play ACPI
> parport0: PC-style at 0x378, irq 7 [PCSPP,TRISTATE]
> lp0: using parport0 (interrupt-driven).
> Linux agpgart interface v0.102 (c) Dave Jones
> usbcore: registered new interface driver usbfs
> usbcore: registered new interface driver hub
> usbcore: registered new device driver usb
> agpgart: Detected an Intel 855PM Chipset.
> agpgart: AGP aperture is 256M @ 0xd0000000
> ACPI: PCI Interrupt Link [LNKH] enabled at IRQ 11
> ACPI: PCI Interrupt 0000:00:1d.7[D] -> Link [LNKH] -> GSI 11 (level, low) -> IRQ 11
> PCI: Setting latency timer of device 0000:00:1d.7 to 64
> ehci_hcd 0000:00:1d.7: EHCI Host Controller
> ehci_hcd 0000:00:1d.7: new USB bus registered, assigned bus number 1
> ehci_hcd 0000:00:1d.7: debug port 1
> PCI: cache line size of 32 is not supported by device 0000:00:1d.7
> ehci_hcd 0000:00:1d.7: irq 11, io mem 0xc0000000
> ehci_hcd 0000:00:1d.7: USB 2.0 started, EHCI 1.00, driver 10 Dec 2004
> usb usb1: configuration #1 chosen from 1 choice
> hub 1-0:1.0: USB hub found
> hub 1-0:1.0: 6 ports detected
> USB Universal Host Controller Interface driver v3.0
> ACPI: PCI Interrupt Link [LNKA] enabled at IRQ 11
> ACPI: PCI Interrupt 0000:00:1d.0[A] -> Link [LNKA] -> GSI 11 (level, low) -> IRQ 11
> PCI: Setting latency timer of device 0000:00:1d.0 to 64
> uhci_hcd 0000:00:1d.0: UHCI Host Controller
> uhci_hcd 0000:00:1d.0: new USB bus registered, assigned bus number 2
> uhci_hcd 0000:00:1d.0: irq 11, io base 0x00001800
> usb usb2: configuration #1 chosen from 1 choice
> hub 2-0:1.0: USB hub found
> hub 2-0:1.0: 2 ports detected
> ACPI: PCI Interrupt 0000:00:1d.1[B] -> Link [LNKD] -> GSI 11 (level, low) -> IRQ 11
> PCI: Setting latency timer of device 0000:00:1d.1 to 64
> uhci_hcd 0000:00:1d.1: UHCI Host Controller
> uhci_hcd 0000:00:1d.1: new USB bus registered, assigned bus number 3
> uhci_hcd 0000:00:1d.1: irq 11, io base 0x00001820
> usb usb3: configuration #1 chosen from 1 choice
> hub 3-0:1.0: USB hub found
> hub 3-0:1.0: 2 ports detected
> ACPI: PCI Interrupt 0000:00:1d.2[C] -> Link [LNKC] -> GSI 11 (level, low) -> IRQ 11
> PCI: Setting latency timer of device 0000:00:1d.2 to 64
> uhci_hcd 0000:00:1d.2: UHCI Host Controller
> uhci_hcd 0000:00:1d.2: new USB bus registered, assigned bus number 4
> uhci_hcd 0000:00:1d.2: irq 11, io base 0x00001840
> usb usb4: configuration #1 chosen from 1 choice
> hub 4-0:1.0: USB hub found
> hub 4-0:1.0: 2 ports detected
> ACPI: PCI Interrupt 0000:00:1f.3[B] -> Link [LNKB] -> GSI 9 (level, low) -> IRQ 9
> e100: Intel(R) PRO/100 Network Driver, 3.5.17-k4-NAPI
> e100: Copyright(c) 1999-2006 Intel Corporation
> ACPI: PCI Interrupt Link [LNKE] enabled at IRQ 10
> PCI: setting IRQ 10 as level-triggered
> ACPI: PCI Interrupt 0000:02:08.0[A] -> Link [LNKE] -> GSI 10 (level, low) -> IRQ 10
> e100: eth0: e100_probe: addr 0xc0210000, irq 10, MAC addr 00:06:1B:D3:98:42
> ath_hal: version magic '2.6.22.2-adeos preempt mod_unload PENTIUMM ' should be '2.6.22.2-adeos mod_unload PENTIUMM '
> hdc: ATAPI 24X DVD-ROM CD-R/RW drive, 2048kB Cache, UDMA(33)
> Uniform CD-ROM driver Revision: 3.20
> NET: Registered protocol family 23
> Yenta: CardBus bridge found at 0000:02:00.0 [1014:0528]
> Yenta: Using INTVAL to route CSC interrupts to PCI
> Yenta: Routing CardBus interrupts to PCI
> Yenta TI: socket 0000:02:00.0, mfunc 0x01d11002, devctl 0x64
> nsc-ircc, chip->init
> nsc-ircc, Found chip at base=0x02e
> nsc-ircc, driver loaded (Dag Brattli)
> IrDA: Registered device irda0
> nsc-ircc, Found dongle: HP HSDL-1100/HSDL-2100
> Yenta: ISA IRQ mask 0x0070, PCI irq 11
> Socket status: 30000007
> pcmcia: parent PCI bridge I/O window: 0x4000 - 0x8fff
> cs: IO port probe 0x4000-0x8fff: clean.
> pcmcia: parent PCI bridge Memory window: 0xc0200000 - 0xcfffffff
> pcmcia: parent PCI bridge Memory window: 0xe8000000 - 0xefffffff
> wlan: version magic '2.6.22.2-adeos preempt mod_unload PENTIUMM ' should be '2.6.22.2-adeos mod_unload PENTIUMM '
> ACPI: PCI Interrupt 0000:00:1f.5[B] -> Link [LNKB] -> GSI 9 (level, low) -> IRQ 9
> PCI: Setting latency timer of device 0000:00:1f.5 to 64
> ath_pci: version magic '2.6.22.2-adeos preempt mod_unload PENTIUMM ' should be '2.6.22.2-adeos mod_unload PENTIUMM '
> cs: IO port probe 0x100-0x3af: clean.
> cs: IO port probe 0x3e0-0x4ff: excluding 0x4d0-0x4d7
> cs: IO port probe 0x820-0x8ff: clean.
> cs: IO port probe 0xc00-0xcf7: clean.
> cs: IO port probe 0xa00-0xaff: clean.
> intel8x0_measure_ac97_clock: measured 55229 usecs
> intel8x0: clocking to 48000
> Adding 786200k swap on /dev/hda7.  Priority:42 extents:1 across:786200k
> fuse init (API version 7.8)
> device-mapper: ioctl: 4.11.0-ioctl (2006-10-12) initialised: dm-devel@domain.hid
> NTFS driver 2.1.28 [Flags: R/W MODULE].
> NTFS volume version 3.1.
> NTFS-fs warning (device hda1): load_system_files(): Unsupported volume flags 0x4000 encountered.
> NTFS-fs warning (device hda1): load_system_files(): Volume has unsupported flags set.  Will not be able to remount read-write.  Run chkdsk and mount in Windows.
> NTFS-fs warning (device hda1): load_system_files(): $LogFile is not clean.  Will not be able to remount read-write.  Mount in Windows.
> NTFS-fs warning (device hda1): load_system_files(): Windows is hibernated.  Will not be able to remount read-write.  Run chkdsk.
> ath_hal: version magic '2.6.22.2-adeos preempt mod_unload PENTIUMM ' should be '2.6.22.2-adeos mod_unload PENTIUMM '
> wlan: version magic '2.6.22.2-adeos preempt mod_unload PENTIUMM ' should be '2.6.22.2-adeos mod_unload PENTIUMM '
> ath_pci: version magic '2.6.22.2-adeos preempt mod_unload PENTIUMM ' should be '2.6.22.2-adeos mod_unload PENTIUMM '
> NET: Registered protocol family 10
> lo: Disabled Privacy Extensions
> ip6_tables: (C) 2000-2006 Netfilter Core Team
> Netfilter messages via NETLINK v0.30.
> nf_conntrack version 0.5.0 (6139 buckets, 49112 max)
> ACPI: AC Adapter [AC] (on-line)
> ACPI: Battery Slot [BAT0] (battery absent)
> input: Power Button (FF) as /class/input/input4
> ACPI: Power Button (FF) [PWRF]
> input: Lid Switch as /class/input/input5
> ACPI: Lid Switch [LID]
> input: Sleep Button (CM) as /class/input/input6
> ACPI: Sleep Button (CM) [SLPB]
> thinkpad_acpi: ThinkPad ACPI Extras v0.14
> thinkpad_acpi: http://ibm-acpi.sf.net/
> [drm] Initialized drm 1.1.0 20060810
> ACPI: PCI Interrupt 0000:01:00.0[A] -> Link [LNKA] -> GSI 11 (level, low) -> IRQ 11
> [drm] Initialized radeon 1.27.0 20060524 on minor 0
> agpgart: Found an AGP 2.0 compliant device at 0000:00:00.0.
> agpgart: Putting AGP V2 device at 0000:00:00.0 into 1x mode
> agpgart: Putting AGP V2 device at 0000:01:00.0 into 1x mode
> [drm] Setting GART location based on new memory map
> [drm] writeback test succeeded in 2 usecs
> audit(1186917286.070:2): audit_backlog_limit=256 old=64 by auid=4294967295 res=1
>  CIFS VFS: Error connecting to IPv4 socket. Aborting operation
>  CIFS VFS: cifs_mount failed w/return code = -101
> audit(1186917286.570:3): audit_pid=4731 old=0 by auid=4294967295
> Non-volatile memory driver v1.2
> input: /usr/sbin/thinkpad-keys as /class/input/input7
> I-pipe: Domain Xenomai registered.
> Xenomai: hal/x86 started.
> Xenomai: real-time nucleus v2.4-rc1 (Bells Of Lal) loaded.
> Xenomai: SMI-enabled chipset found, enabling SMI workaround.
> Xenomai: starting RTDM services.
> agpgart: Found an AGP 2.0 compliant device at 0000:00:00.0.
> agpgart: Putting AGP V2 device at 0000:00:00.0 into 1x mode
> agpgart: Putting AGP V2 device at 0000:01:00.0 into 1x mode
> ------------[ cut here ]------------
> kernel BUG at fs/buffer.c:1230!
> invalid opcode: 0000 [#1]
> Modules linked in: xeno_rtdm xeno_nucleus ip6t_LOG xt_TCPMSS nvram uinput snd_pcm_oss snd_mixer_oss cifs snd_seq snd_seq_device radeon drm thinkpad_acpi button battery ac ip6t_REJECT xt_state iptable_nat nf_nat ip6table_mangle nf_conntrack_ipv4 nf_conntrack nfnetlink ip6table_filter ip6_tables ipv6 nls_iso8859_1 nls_cp437 vfat fat nls_utf8 ntfs dm_mod fuse pcmcia firmware_class snd_intel8x0 snd_ac97_codec nsc_ircc yenta_socket ac97_bus snd_pcm irda ide_cd rsrc_nonstatic e100 cdrom pcmcia_core snd_timer mii crc_ccitt i2c_i801 i2c_core snd uhci_hcd ehci_hcd soundcore intel_agp usbcore snd_page_alloc agpgart parport_pc lp parport reiserfs edd fan piix ide_disk ide_core
> CPU:    0
> EIP:    0060:[<c0185237>]    Not tainted VLI
> EFLAGS: 00210246   (2.6.22.2-adeos #12)
> EIP is at __find_get_block+0x2b/0x1a2
> eax: 00000000   ebx: e4727d34   ecx: 00000000   edx: 00002e4e
> esi: 00002e4e   edi: 00000000   ebp: e4727ab8   esp: e4727a84
> ds: 007b   es: 007b   fs: 0000  gs: 0033  ss: 0068
> Process kbuildsycoca (pid: 5719, ti=e4726000 task=e6cb0b50 task.ti=e4726000)<0>
> I-pipe domain Linux
> Stack: eee72080 00001e70 00200286 00000002 e4727d34 00001000 e4727d3c e4727ab8 
>        c0113c1c 00000000 e4727d34 00001000 e4727d3c e4727b20 c01853d3 00001000 
>        00000002 00000800 c03e1780 00000000 00002e4e 00000000 eee72080 00000002 
> Call Trace:
>  [<c0104ea4>] show_trace_log_lvl+0x1f/0x34
>  [<c0104f59>] show_stack_log_lvl+0xa0/0xa8
>  [<c010514a>] show_registers+0x1e9/0x2f0
>  [<c010534f>] die+0xfe/0x216
>  [<c01054f5>] do_trap+0x8e/0xa7
>  [<c0105883>] do_invalid_op+0x8d/0x97
>  [<c0113b8a>] __ipipe_handle_exception+0xb1/0x11f
>  [<c030404b>] error_code+0x6f/0x7c
>  [<c01853d3>] __getblk+0x25/0x29a
>  [<f0bdabac>] search_by_key+0x97/0xe38 [reiserfs]
>  [<f0bc5c10>] search_by_entry_key+0x20/0x231 [reiserfs]
>  [<f0bc5e96>] reiserfs_find_entry+0x75/0x2d0 [reiserfs]
>  [<f0bc6623>] reiserfs_lookup+0x68/0x106 [reiserfs]
>  [<c016f2c3>] do_lookup+0xa5/0x142
>  [<c0170f0f>] __link_path_walk+0x726/0xb22
>  [<c0171359>] link_path_walk+0x4e/0xc1
>  [<c01713e9>] path_walk+0x1d/0x1f
>  [<c0171674>] do_path_lookup+0x17e/0x1e2
>  [<c0172060>] __path_lookup_intent_open+0x49/0x7a
>  [<c017210e>] path_lookup_open+0x26/0x2c
>  [<c017220b>] open_namei+0x72/0x59c
>  [<c016784f>] do_filp_open+0x2b/0x40
>  [<c01678ac>] do_sys_open+0x48/0xc7
>  [<c016796d>] sys_open+0x21/0x23
>  [<c0103e19>] syscall_call+0x7/0xb
>  =======================
> Code: 55 89 e5 57 56 53 83 ec 28 e8 de e9 f8 ff 89 45 cc a1 80 17 3e c0 89 d6 89 cf 83 e0 01 83 f8 01 19 c0 25 00 02 00 00 85 c0 75 04 <0f> 0b eb fe b8 80 17 3e c0 e8 f1 48 fc ff 31 c9 8b 1c 8d 60 ac 
> EIP: [<c0185237>] __find_get_block+0x2b/0x1a2 SS:ESP 0068:e4727a84
> I-pipe tracer log (100 points):
>      #func                    0 ipipe_trace_panic_freeze+0x9 (bust_spinlocks+0x11)
>      #func                    0 bust_spinlocks+0x8 (die+0x65)
>      #func                    0 _raw_spin_lock+0xe (_spin_lock_irqsave+0x61)
>      #func                    0 __ipipe_restore_root+0x8 (lock_acquire+0x92)
>      #func                   -1 __lock_acquire+0xe (lock_acquire+0x7c)
>      #func                   -1 ipipe_check_context+0xc (lock_acquire+0x2d)
>      #func                   -1 lock_acquire+0xe (_spin_lock_irqsave+0x5a)
>      #func                   -1 ipipe_check_context+0xc (_spin_lock_irqsave+0x38)
>      #func                   -1 ipipe_check_context+0xc (_spin_lock_irqsave+0x19)
>      #func                   -1 _spin_lock_irqsave+0xd (die+0x45)
>      #func                   -2 do_oops_enter_exit+0x9 (oops_enter+0x12)
>      #func                   -3 debug_locks_off+0x8 (oops_enter+0xd)
>      #func                   -3 oops_enter+0x8 (die+0x1a)
>      #func                   -3 die+0xe (do_trap+0x8e)
>      #func                   -4 ipipe_check_context+0xc (_spin_unlock_irqrestore+0x45)
>      #func                   -4 __ipipe_restore_root+0x8 (_spin_unlock_irqrestore+0x3b)
>      #func                   -4 _raw_spin_unlock+0x9 (_spin_unlock_irqrestore+0x25)
>      #func                   -4 __ipipe_restore_root+0x8 (lock_release+0x176)
>      #func                   -4 ipipe_check_context+0xc (lock_release+0x32)
>      #func                   -5 lock_release+0xe (_spin_unlock_irqrestore+0x1e)
>      #func                   -5 _spin_unlock_irqrestore+0xa (search_module_extables+0x6d)
>      #func                   -6 search_extable+0xb (search_module_extables+0x46)
>      #func                  -10 search_extable+0xb (search_module_extables+0x46)
>      #func                  -12 search_extable+0xb (search_module_extables+0x46)
>      #func                  -18 search_extable+0xb (search_module_extables+0x46)
>      #func                  -19 _raw_spin_lock+0xe (_spin_lock_irqsave+0x61)
>      #func                  -19 __ipipe_restore_root+0x8 (lock_acquire+0x92)
>      #func                  -19 __lock_acquire+0xe (lock_acquire+0x7c)
>      #func                  -19 ipipe_check_context+0xc (lock_acquire+0x2d)
>      #func                  -19 lock_acquire+0xe (_spin_lock_irqsave+0x5a)
>      #func                  -20 ipipe_check_context+0xc (_spin_lock_irqsave+0x38)
>      #func                  -20 ipipe_check_context+0xc (_spin_lock_irqsave+0x19)
>      #func                  -20 _spin_lock_irqsave+0xd (search_module_extables+0x1d)
>      #func                  -20 search_module_extables+0xe (search_exception_tables+0x27)
>      #func                  -22 search_extable+0xb (search_exception_tables+0x1c)
>      #func                  -22 search_exception_tables+0x9 (fixup_exception+0x13)
>      #func                  -22 fixup_exception+0x9 (do_trap+0x6f)
>      #func                  -22 do_trap+0xe (do_invalid_op+0x8d)
>      #func                  -23 ipipe_check_context+0xc (__atomic_notifier_call_chain+0x45)
>      #func                  -23 notifier_call_chain+0xe (__atomic_notifier_call_chain+0x39)
>      #func                  -23 ipipe_check_context+0xc (__atomic_notifier_call_chain+0x1e)
>      #func                  -23 __atomic_notifier_call_chain+0xe (atomic_notifier_call_chain+0x1f)
>      #func                  -23 atomic_notifier_call_chain+0xb (notify_die+0x32)
>      #func                  -24 notify_die+0xb (do_invalid_op+0x59)
>      #func                  -24 do_invalid_op+0x10 (__ipipe_handle_exception+0xb1)
>      #func                  -24 __ipipe_handle_exception+0xe (error_code+0x6f)
>      #func                  -25 __find_get_block+0xe (__getblk+0x25)
>      #func                  -25 __getblk+0xe (search_by_key+0x97 [reiserfs])
>      #func                  -25 decrement_counters_in_path+0xc [reiserfs] (search_by_key+0x2a [reiserfs])
>      #func                  -25 search_by_key+0x11 [reiserfs] (search_by_entry_key+0x20 [reiserfs])
>  |   #end     0xffffff16    -26 ipipe_ipi3+0x3d (__ipipe_trace+0x2fd)
>  |  #*func                  -26 __ipipe_schedule_irq+0xe (rthal_irq_host_pend+0x19)
>  |  #*func                  -26 rthal_irq_host_pend+0x8 (xnintr_clock_handler+0xa2 [xeno_nucleus])
>  |  #*func                  -27 xntimer_next_local_shot+0xe [xeno_nucleus] (xntimer_tick_aperiodic+0x19a [xeno_nucleus])
>  |  #*func                  -27 xntimer_tick_aperiodic+0xe [xeno_nucleus] (xnintr_clock_handler+0x27 [xeno_nucleus])
>  |  #*func                  -27 xnintr_clock_handler+0xb [xeno_nucleus] (__virq_end+0x1b)
>  |  +*func                  -28 __ipipe_sync_stage+0xe (ipipe_suspend_domain+0x6e)
>  |  +*func                  -28 ipipe_suspend_domain+0xe (__ipipe_walk_pipeline+0x4b)
>  |   #func                  -28 __ipipe_walk_pipeline+0xa (__ipipe_handle_irq+0x14e)
>  |  #*func                  -29 __ipipe_dispatch_wired+0xb (__ipipe_handle_irq+0x67)
>  |  #*func                  -29 __ipipe_handle_irq+0xe (ipipe_trigger_irq+0x97)
>  |  #*func                  -29 memcpy+0xe (ipipe_trigger_irq+0x92)
>  |  #*func                  -29 ipipe_trigger_irq+0xe (xntimer_next_local_shot+0x77 [xeno_nucleus])
>  |  #*func                  -30 xntimer_next_local_shot+0xe [xeno_nucleus] (xntimer_tick_aperiodic+0x19a [xeno_nucleus])
>  |  #*func                  -30 xntimer_tick_aperiodic+0xe [xeno_nucleus] (xnintr_clock_handler+0x27 [xeno_nucleus])
>  |  #*func                  -30 xnintr_clock_handler+0xb [xeno_nucleus] (__ipipe_dispatch_wired+0x73)
>  |  #*end     0x8000000d    -31 __ipipe_unstall_iret_root+0x60 (restore_nocheck_notrace+0x0)
>  |  # begin   0x80000000    -31 __ipipe_unstall_iret_root+0x1e (restore_nocheck_notrace+0x0)
>     # func                  -31 __ipipe_unstall_iret_root+0x9 (restore_nocheck_notrace+0x0)
>  |  # end     0x80000000    -31 __ipipe_unstall_root+0x44 (__ipipe_restore_root+0x1b)
>  |  #*begin   0x80000000    -32 __ipipe_unstall_root+0x1a (__ipipe_restore_root+0x1b)
>     #*func                  -32 __ipipe_unstall_root+0x8 (__ipipe_restore_root+0x1b)
>     #*func                  -32 __ipipe_restore_root+0x8 (__ipipe_handle_exception+0xc7)
>  |  #*end     0x80000000    -33 do_page_fault+0x28 (__ipipe_handle_exception+0xb1)
>  |  #*func                  -33 do_page_fault+0xe (__ipipe_handle_exception+0xb1)
>  |  # func                  -33 __ipipe_handle_exception+0xe (error_code+0x6f)
>  |   +func                  -33 __ipipe_dispatch_wired+0xb (__ipipe_handle_irq+0x67)
>  |   +func                  -34 __ipipe_ack_apic+0x8 (__ipipe_handle_irq+0x5e)
>  |   +func                  -34 __ipipe_handle_irq+0xe (ipipe_ipi3+0x33)
>  |   +begin   0xffffff16    -34 ipipe_ipi3+0x2e (__ipipe_trace+0x2fd)
>      +func                  -34 search_by_entry_key+0xe [reiserfs] (reiserfs_find_entry+0x75 [reiserfs])
>      +func                  -34 _make_cpu_key+0x8 [reiserfs] (make_cpu_key+0x49 [reiserfs])
>      +func                  -35 make_cpu_key+0xe [reiserfs] (reiserfs_find_entry+0x5e [reiserfs])
>      +func                  -35 r5_hash+0x9 [reiserfs] (get_third_component+0x40 [reiserfs])
>      +func                  -35 get_third_component+0xa [reiserfs] (reiserfs_find_entry+0x36 [reiserfs])
>      +func                  -35 reiserfs_find_entry+0xe [reiserfs] (reiserfs_lookup+0x68 [reiserfs])
>      +func                  -36 memset+0xd (reiserfs_lookup+0x2a [reiserfs])
>      +func                  -36 reiserfs_lookup+0x11 [reiserfs] (do_lookup+0xa5)
>      +func                  -36 ipipe_check_context+0xc (_spin_unlock+0x2c)
>      +func                  -36 _raw_spin_unlock+0x9 (_spin_unlock+0x22)
>  |   +end     0x80000000    -36 __ipipe_unstall_root+0x44 (__ipipe_restore_root+0x1b)
>  |   #begin   0x80000000    -36 __ipipe_unstall_root+0x1a (__ipipe_restore_root+0x1b)
>      #func                  -37 __ipipe_unstall_root+0x8 (__ipipe_restore_root+0x1b)
>      #func                  -37 __ipipe_restore_root+0x8 (lock_release+0x176)
>      +func                  -37 ipipe_check_context+0xc (lock_release+0x32)
>      +func                  -37 lock_release+0xe (_spin_unlock+0x1b)
>      +func                  -37 _spin_unlock+0x9 (d_alloc+0x187)
>      +func                  -38 _raw_spin_lock+0xe (_spin_lock+0x41)
>  |   +end     0x80000000    -38 __ipipe_unstall_root+0x44 (__ipipe_restore_root+0x1b)
>  |   #begin   0x80000000    -38 __ipipe_unstall_root+0x1a (__ipipe_restore_root+0x1b)
> 
> 
> Someone leaves a light on when returning from the virtualised clock
> interrupt. What is that page fault about we see in trace?
> 
> Jan
> 
-- 
Philippe.



