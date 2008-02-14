Content-Type: text/plain; charset="us-ascii"
Date: Thu, 14 Feb 2008 08:34:23 +0100
From: timo.pallach@domain.hid
Message-ID: <20080214073423.118970@domain.hid>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-help] code -19 after rebooting the xenomai-kernel
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

I am tying to install Xenomai on a Beckhoff CX1010.

I use the following components:
Adeos: adeos-ipipe-2.6.22-i386-1.10-12.patch
Xenomai: xenomai-2.4.1.tar.bz2
Linux: actual linux-source-2.6.22.tar.bz2 from the ubuntu repository (ubuntu-server)

The compilation works without errors
("make-kpkg --initrd --revision=$KERNEL_REVISION_XENOMAI kernel_image").
After installing the the kernel via "dpkg -i $XENOMAI_KERNEL.deb" rebooting into the new XENOMAI_KERNEL fails showing the attached lines in the dmesg.

Is there some additionally debug or log information of the xenomai-system?
Or does any one have any ideas what I am doing wrong?

[    0.000000] Linux version 2.6.22.9 (abc@domain.hid) (gcc version 4.1.3 20070929 (prerelease) (Ubuntu 4.1.2-16ubuntu2)) #1 SMP Wed Feb 13 20:54:03 CET 2008 (Ubuntu 2.6.22-14.52-generic)
[    0.000000] BIOS-provided physical RAM map:
[    0.000000]  BIOS-e820: 0000000000000000 - 000000000009e800 (usable)
[    0.000000]  BIOS-e820: 000000000009e800 - 00000000000a0000 (reserved)
[    0.000000]  BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
[    0.000000]  BIOS-e820: 0000000000100000 - 000000000efc0000 (usable)
[    0.000000]  BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
[    0.000000] 0MB HIGHMEM available.
[    0.000000] 239MB LOWMEM available.
[    0.000000] Entering add_active_range(0, 0, 61376) 0 entries of 256 used
[    0.000000] Zone PFN ranges:
[    0.000000]   DMA             0 ->     4096
[    0.000000]   Normal       4096 ->    61376
[    0.000000]   HighMem     61376 ->    61376
[    0.000000] early_node_map[1] active PFN ranges
[    0.000000]     0:        0 ->    61376
[    0.000000] On node 0 totalpages: 61376
[    0.000000]   DMA zone: 32 pages used for memmap
[    0.000000]   DMA zone: 0 pages reserved
[    0.000000]   DMA zone: 4064 pages, LIFO batch:0
[    0.000000]   Normal zone: 447 pages used for memmap
[    0.000000]   Normal zone: 56833 pages, LIFO batch:15
[    0.000000]   HighMem zone: 0 pages used for memmap
[    0.000000] DMI 2.2 present.
[    0.000000] Allocating PCI resources starting at 10000000 (gap: 0efc0000:f1030000)
[    0.000000] Built 1 zonelists.  Total pages: 60897
[    0.000000] Kernel command line: root=UUID=18801f09-9cfc-4177-8d08-851e7da0d027 ro quiet splash lapic=1
[    0.000000] No local APIC present or hardware disabled
[    0.000000] mapped APIC to ffffd000 (011ed000)
[    0.000000] Initializing CPU#0
[    0.000000] PID hash table entries: 1024 (order: 10, 4096 bytes)
[    0.000000] Detected 498.076 MHz processor.
[   12.075638] I-pipe 1.10-12: pipeline enabled.
[   12.076951] Console: colour VGA+ 80x25
[   12.077100] Dentry cache hash table entries: 32768 (order: 5, 131072 bytes)
[   12.077752] Inode-cache hash table entries: 16384 (order: 4, 65536 bytes)
[   12.112178] Memory: 199164k/245504k available (2083k kernel code, 45672k reserved, 860k data, 296k init, 0k highmem)
[   12.112233] virtual kernel memory layout:
[   12.112241]     fixmap  : 0xfff54000 - 0xfffff000   ( 684 kB)
[   12.112251]     pkmap   : 0xff800000 - 0xffc00000   (4096 kB)
[   12.112261]     vmalloc : 0xcf800000 - 0xff7fe000   ( 767 MB)
[   12.112271]     lowmem  : 0xc0000000 - 0xcefc0000   ( 239 MB)
[   12.112281]       .init : 0xc03e6000 - 0xc0430000   ( 296 kB)
[   12.112291]       .data : 0xc0308d01 - 0xc03dfe24   ( 860 kB)
[   12.112301]       .text : 0xc0100000 - 0xc0308d01   (2083 kB)
[   12.112326] Checking if this processor honours the WP bit even in supervisor mode... Ok.
[   12.112502] SLUB: Genslabs=22, HWalign=32, Order=0-1, MinObjects=4, CPUs=1, Nodes=1
[   12.192516] Calibrating delay using timer specific routine.. 997.44 BogoMIPS (lpj=1994884)
[   12.192615] Security Framework v1.0.0 initialized
[   12.192641] SELinux:  Disabled at boot.
[   12.192732] Mount-cache hash table entries: 512
[   12.193114] CPU: After generic identify, caps: 0088a93d c0c0a13d 00000000 00000000 00000000 00000000 00000000
[   12.193158] CPU: L1 I Cache: 64K (32 bytes/line), D cache 64K (32 bytes/line)
[   12.193176] CPU: L2 Cache: 128K (32 bytes/line)
[   12.193189] CPU: After all inits, caps: 0088a93d c0c0a13d 00000000 00000000 00000000 00000000 00000000
[   12.193232] Compat vDSO mapped to ffffe000.
[   12.193263] Checking 'hlt' instruction... OK.
[   12.208597] SMP alternatives: switching to UP code
[   12.209508] Freeing SMP alternatives: 14k freed
[   12.209614] CPU0: AMD Geode(TM) Integrated Processor by AMD PCS stepping 02
[   12.209639] SMP motherboard not detected.
[   12.209653] Local APIC not detected. Using dummy APIC emulation.
[   12.209798] Brought up 1 CPUs
[   12.210300] NET: Registered protocol family 16
[   12.210617] EISA bus registered
[   12.216119] PCI: PCI BIOS revision 2.10 entry at 0xfa6d0, last bus=0
[   12.216135] PCI: Using configuration type 1
[   12.216147] Setting up standard PCI resources
[   12.226773] Linux Plug and Play Support v0.97 (c) Adam Belay
[   12.226820] PnPBIOS: Scanning system for PnP BIOS support...
[   12.227103] PnPBIOS: Found PnP BIOS installation structure at 0xc00fb030
[   12.227127] PnPBIOS: PnP BIOS version 1.0, entry 0xf0000:0xb060, dseg 0xf0000
[   12.229708] PnPBIOS: 14 nodes reported by PnP BIOS; 14 recorded by driver
[   12.229891] PCI: Probing PCI hardware
[   12.229912] PCI: Probing PCI hardware (bus 00)
[   12.232998] PCI: Firmware left 0000:00:0d.0 e100 interrupts enabled, disabling
[   12.233093] PCI: Firmware left 0000:00:0e.0 e100 interrupts enabled, disabling
[   12.239934] PCI: Using IRQ router NatSemi [1022/2090] at 0000:00:0f.0
[   12.257266] NET: Registered protocol family 8
[   12.257279] NET: Registered protocol family 20
[   12.257521] pnp: 00:07: iomem range 0x0-0x9ffff could not be reserved
[   12.257543] pnp: 00:07: iomem range 0xfffc0000-0xffffffff could not be reserved
[   12.257565] pnp: 00:07: iomem range 0xfee00000-0xfee0ffff has been reserved
[   12.257587] pnp: 00:07: iomem range 0x100000-0xffffff could not be reserved
[   12.257621] pnp: 00:08: iomem range 0xf0000-0xf3fff could not be reserved
[   12.257642] pnp: 00:08: iomem range 0xf4000-0xf7fff could not be reserved
[   12.257663] pnp: 00:08: iomem range 0xf8000-0xfbfff could not be reserved
[   12.257684] pnp: 00:08: iomem range 0xfc000-0xfffff could not be reserved
[   12.258910] NET: Registered protocol family 2
[   12.260488] Time: tsc clocksource has been installed.
[   12.260548] Switched to high resolution mode on CPU 0
[   12.296589] IP route cache hash table entries: 2048 (order: 1, 8192 bytes)
[   12.296725] TCP established hash table entries: 8192 (order: 4, 98304 bytes)
[   12.297059] TCP bind hash table entries: 8192 (order: 4, 65536 bytes)
[   12.297275] TCP: Hash tables configured (established 8192 bind 8192)
[   12.297291] TCP reno registered
[   12.309066] checking if image is initramfs... it is
[   34.334559] Freeing initrd memory: 39399k freed
[   34.335650] audit: initializing netlink socket (disabled)
[   34.335690] audit(1202971824.153:1): initialized
[   34.335779] Xenomai: Local APIC absent or disabled!
[   34.335788]          Disable APIC support or pass "lapic=1" as bootparam.
[   34.335806] Xenomai: system init failed, code -19.
[   34.335887] Xenomai: native skin init failed, code -19.
[   34.335959] Xenomai: starting POSIX services.
[   34.335973] Xenomai: POSIX skin init failed, code -19.
[   34.336045] Xenomai: RTDM skin init failed, code -19.
[   34.347627] VFS: Disk quotas dquot_6.5.1
[   34.347918] Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)
[   34.348510] io scheduler noop registered
[   34.348524] io scheduler anticipatory registered
[   34.348537] io scheduler deadline registered
[   34.348650] io scheduler cfq registered (default)
[   34.348734] Boot video device is 0000:00:01.1
[   34.361906] isapnp: Scanning for PnP cards...
[   34.718479] isapnp: No Plug & Play device found
[   34.826029] Real Time Clock Driver v1.12ac
[   34.826048] Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing enabled
[   34.826222] serial8250: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
[   34.826678] serial8250: ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
[   34.827159] serial8250: ttyS2 at I/O 0x3e8 (irq = 4) is a 16550A
[   34.827640] serial8250: ttyS3 at I/O 0x2e8 (irq = 3) is a 16550A
[   34.829151] 00:0b: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
[   34.830128] 00:0e: ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
[   34.830962] 00:11: ttyS2 at I/O 0x3e8 (irq = 11) is a 16550A
[   34.831788] 00:12: ttyS3 at I/O 0x2e8 (irq = 10) is a 16550A
[   34.834833] RAMDISK driver initialized: 16 RAM disks of 65536K size 1024 blocksize
[   34.835724] input: Macintosh mouse button emulation as /class/input/input0
[   34.836070] PNP: PS/2 Controller [PNP0303] at 0x60,0x64 irq 1
[   34.836087] PNP: PS/2 controller doesn't have AUX irq; using default 12
[   34.838703] serio: i8042 KBD port at 0x60,0x64 irq 1
[   34.838744] serio: i8042 AUX port at 0x60,0x64 irq 12
[   34.839373] mice: PS/2 mouse device common for all mice
[   34.839774] EISA: Probing bus 0 at eisa.0
[   34.839803] Cannot allocate resource for EISA slot 1
[   34.839866] Cannot allocate resource for EISA slot 6
[   34.839905] EISA: Detected 0 cards.
[   34.840397] TCP cubic registered
[   34.840459] NET: Registered protocol family 1
[   34.840568] Using IPI No-Shortcut mode
[   34.841326] Freeing unused kernel memory: 296k freed
[   35.871018] fuse init (API version 7.8)
[   38.025772] e100: Intel(R) PRO/100 Network Driver, 3.5.17-k4-NAPI
[   38.025792] e100: Copyright(c) 1999-2006 Intel Corporation
[   38.025945] PCI: setting IRQ 15 as level-triggered
[   38.025961] PCI: Found IRQ 15 for device 0000:00:0d.0
[   38.026136] PCI: Sharing IRQ 15 with 0000:00:0f.3
[   38.026280] PCI: Setting latency timer of device 0000:00:0d.0 to 64
[   38.049766] e100: eth0: e100_probe: addr 0xeffff000, irq 15, MAC addr 00:01:05:02:65:23
[   38.049850] PCI: setting IRQ 7 as level-triggered
[   38.049865] PCI: Found IRQ 7 for device 0000:00:0e.0
[   38.050141] PCI: Setting latency timer of device 0000:00:0e.0 to 64
[   38.195935] e100: eth1: e100_probe: addr 0xefffe000, irq 7, MAC addr 00:01:05:02:65:24
[   38.267308] SCSI subsystem initialized
[   38.302779] libata version 2.21 loaded.
[   38.350776] Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
[   38.350800] ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
[   38.354873] AMD5536: IDE controller at PCI slot 0000:00:0f.2
[   38.355040] AMD5536: chipset revision 1
[   38.355053] AMD5536: not 100% native mode: will probe irqs later
[   38.355207] AMD5536: 0000:00:0f.2 (rev 01) UDMA100 controller
[   38.355284]     ide0: BM-DMA at 0xfd00-0xfd07, BIOS settings: hda:DMA, hdb:pio
[   38.355346] Probing IDE interface ide0...
[   38.487422] usbcore: registered new interface driver usbfs
[   38.487512] usbcore: registered new interface driver hub
[   38.487605] usbcore: registered new device driver usb
[   38.492512] ohci_hcd: 2006 August 04 USB 1.1 'Open' Host Controller (OHCI) Driver
[   38.963338] hda: TRANSCEND, ATA DISK drive
[   39.635507] ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
[   39.636275] PCI: Found IRQ 7 for device 0000:00:0f.4
[   39.636499] PCI: Sharing IRQ 7 with 0000:00:0f.5
[   39.636591] PCI: Setting latency timer of device 0000:00:0f.4 to 64
[   39.636632] ohci_hcd 0000:00:0f.4: OHCI Host Controller
[   39.636996] ohci_hcd 0000:00:0f.4: new USB bus registered, assigned bus number 1
[   39.637047] ohci_hcd 0000:00:0f.4: irq 7, io mem 0xefffd000
[   39.672286] hda: max request size: 128KiB
[   39.672307] hda: 15924384 sectors (8153 MB) w/1KiB Cache, CHS=15798/16/63, UDMA(33)
[   39.672438]  hda: hda1 hda2
[   39.697222] usb usb1: configuration #1 chosen from 1 choice
[   39.697346] hub 1-0:1.0: USB hub found
[   39.697378] hub 1-0:1.0: 4 ports detected
[   39.799784] PCI: Found IRQ 7 for device 0000:00:0f.5
[   39.799987] PCI: Sharing IRQ 7 with 0000:00:0f.4
[   39.800099] PCI: Setting latency timer of device 0000:00:0f.5 to 64
[   39.800140] ehci_hcd 0000:00:0f.5: EHCI Host Controller
[   39.800257] ehci_hcd 0000:00:0f.5: new USB bus registered, assigned bus number 2
[   39.822807] ehci_hcd 0000:00:0f.5: irq 7, io mem 0xefffc000
[   39.822837] ehci_hcd 0000:00:0f.5: USB 2.0 started, EHCI 1.00, driver 10 Dec 2004
[   39.823226] usb usb2: configuration #1 chosen from 1 choice
[   39.823346] hub 2-0:1.0: USB hub found
[   39.823376] hub 2-0:1.0: 4 ports detected
[   40.148042] kjournald starting.  Commit interval 5 seconds
[   40.148083] EXT3-fs: mounted filesystem with ordered data mode.
[   44.696534] e100: eth0: e100_watchdog: link up, 100Mbps, full-duplex
[   45.722189] NET: Registered protocol family 10
[   45.722573] lo: Disabled Privacy Extensions
[   49.463040] cs5535_gpio: base=0x6100 mask=0xb003c66 major=253
[   50.793056] AMD Geode RNG detected
[   51.291717] PCI: Found IRQ 15 for device 0000:00:01.2
[   51.291793] PCI: Sharing IRQ 15 with 0000:00:01.1
[   51.291989] geode-aes: GEODE AES engine enabled.
[   54.121505] loop: module loaded
[   54.252435] lp: driver loaded but no devices found
[   54.402069] Adding 498004k swap on /dev/hda1.  Priority:-1 extents:1 across:498004k
[   54.538929] EXT3 FS on hda2, internal journal
[   55.806771] eth0: no IPv6 routers present

