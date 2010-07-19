Message-ID: <4C43C83F.5030401@domain.hid>
Date: Sun, 18 Jul 2010 20:36:31 -0700
From: Bob Feretich <bob.feretich@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"; format="flowed"
Content-Transfer-Encoding: quoted-printable
Subject: [Xenomai-help] Adeos patched kernel hangs mounting root file system
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

  I have been trying to apply the Adeos patch to a 2.6.31 system. The=20
patch applies cleanly, but the system (BeagleBoard) boot hangs waiting=20
for the root file system to be mounted via the SD card (/dev/mmcblk0p2).

Note: Although the Adeos patch is applied, Xenomai is not configured in=20
the .config file.
(The boot still hangs in the same spot if Xenomai is configured, but a=20
few more Xenomai messages appear,)
> Reading boot sector
> Loading u-boot.bin from mmc
>
>
> U-Boot 2009.06-rc2 (Nov 02 2009 - 23:57:20)
>
> OMAP3530-GP ES3.0, CPU-OPP2 L3-165MHz
> OMAP3 Beagle board + LPDDR/NAND
> DRAM:  256 MB
> NAND:  256 MiB
> In:    serial
> Out:   serial
> Err:   serial
> Board revision C
> Die ID #317000030000000004013f8a1701a01b
> Hit any key to stop autoboot:  0
> mmc1 is available
> reading uImage
>
> 1911632 bytes read
> ## Booting kernel from Legacy Image at 80300000 ...
>    Image Name:   Angstrom/2.6.31/beagleboard
>    Image Type:   ARM Linux Kernel Image (uncompressed)
>    Data Size:    1911568 Bytes =3D  1.8 MB
>    Load Address: 80008000
>    Entry Point:  80008000
>    Verifying Checksum ... OK
>    Loading Kernel Image ... OK
> OK
>
> Starting kernel ...
>
> Uncompressing=20
> Linux....................................................................=
............................
> ......................... done, booting the kernel.
> Linux version 2.6.31-omap1 (Bob@domain.hid) (gcc version 4.3.3 (GCC)=20
> ) #2 Sun Jul 18 18:16:32 PDT 2010
> CPU: ARMv7 Processor [411fc083] revision 3 (ARMv7), cr=3D10c53c7f
> CPU: VIPT nonaliasing data cache, VIPT nonaliasing instruction cache
> Machine: OMAP3 Beagle Board
> Memory policy: ECC disabled, Data cache writeback
> OMAP3430 ES3.0
> SRAM: Mapped pa 0x40200000 to va 0xe3000000 size: 0x100000
> Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 65024
> Kernel command line: console=3DttyS2,115200n8 root=3D/dev/mmcblk0p2 rw=20
> rootfstype=3Dext3 rootwait
> PID hash table entries: 1024 (order: 10, 4096 bytes)
> Dentry cache hash table entries: 32768 (order: 5, 131072 bytes)
> Inode-cache hash table entries: 16384 (order: 4, 65536 bytes)
> Memory: 128MB 128MB =3D 256MB total
> Memory: 255744KB available (3320K code, 332K data, 132K init, 0K highmem)
> NR_IRQS:402
> Clocking rate (Crystal/Core/MPU): 26.0/332/500 MHz
> Reprogramming SDRC clock to 332000000 Hz
> GPMC revision 5.0
> IRQ: Found an INTC at 0xd8200000 (revision 4.0) with 96 interrupts
> Total of 96 interrupts on 1 active controller
> OMAP34xx GPIO hardware version 2.5
> OMAP clockevent source: GPTIMER1 at 13000000 Hz
> I-pipe 1.16-01: pipeline enabled.
> Console: colour dummy device 80x30
> Calibrating delay loop... 498.07 BogoMIPS (lpj=3D2490368)
> Mount-cache hash table entries: 512
> CPU: Testing write buffer coherency: ok
> regulator: core version 0.5
> NET: Registered protocol family 16
> Found NAND on CS0
> Registering NAND on CS0
> OMAP DMA hardware revision 4.0
> bio: create slab <bio-0> at 0
> i2c_omap i2c_omap.1: bus 1 rev3.12 at 2600 kHz
> twl4030: PIH (irq 7) chaining IRQs 368..375
> twl4030: power (irq 373) chaining IRQs 376..383
> twl4030: gpio (irq 368) chaining IRQs 384..401
> regulator: VMMC1: 1850 <--> 3150 mV normal standby
> regulator: VDAC: 1800 mV normal standby
> regulator: VUSB1V5: 1500 mV normal standby
> regulator: VUSB1V8: 1800 mV normal standby
> regulator: VUSB3V1: 3100 mV normal standby
> regulator: VPLL2: 1800 mV normal standby
> regulator: VSIM: 1800 <--> 3000 mV normal standby
> i2c_omap i2c_omap.3: bus 3 rev3.12 at 100 kHz
> SCSI subsystem initialized
> twl4030_usb twl4030_usb: Initialized TWL4030 USB module
> usbcore: registered new interface driver usbfs
> usbcore: registered new interface driver hub
> usbcore: registered new device driver usb
> musb_hdrc: version 6.0, musb-dma, otg (peripheral+host), debug=3D0
> musb_hdrc: USB OTG mode controller at d80ab000 using DMA, IRQ 92
> NET: Registered protocol family 2
> IP route cache hash table entries: 2048 (order: 1, 8192 bytes)
> TCP established hash table entries: 8192 (order: 4, 65536 bytes)
> TCP bind hash table entries: 8192 (order: 3, 32768 bytes)
> TCP: Hash tables configured (established 8192 bind 8192)
> TCP reno registered
> NET: Registered protocol family 1
> VFS: Disk quotas dquot_6.5.2
> Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)
> JFFS2 version 2.2. (NAND) =EF=BF=BD=C2=A9 2001-2006 Red Hat, Inc.
> msgmni has been set to 499
> alg: No test for stdrng (krng)
> Block layer SCSI generic (bsg) driver version 0.4 loaded (major 253)
> io scheduler noop registered
> io scheduler anticipatory registered (default)
> io scheduler deadline registered
> io scheduler cfq registered
> Serial: 8250/16550 driver, 4 ports, IRQ sharing enabled
> serial8250.0: ttyS0 at MMIO 0x4806a000 (irq =3D 72) is a ST16654
> serial8250.1: ttyS1 at MMIO 0x4806c000 (irq =3D 73) is a ST16654
> serial8250.2: ttyS2 at MMIO 0x49020000 (irq =3D 74) is a ST16654
> console [ttyS2] enabled
> brd: module loaded
> loop: module loaded
> i2c /dev entries driver
> usbcore: registered new interface driver asix
> usbcore: registered new interface driver cdc_ether
> usbcore: registered new interface driver net1080
> usbcore: registered new interface driver cdc_subset
> usbcore: registered new interface driver zaurus
> usbmon: debugfs is not available
> ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
> ehci-omap ehci-omap.0: OMAP-EHCI Host Controller
> ehci-omap ehci-omap.0: new USB bus registered, assigned bus number 1
> ehci-omap ehci-omap.0: irq 77, io mem 0x48064800
> ehci-omap ehci-omap.0: USB 2.0 started, EHCI 1.00
> usb usb1: New USB device found, idVendor=3D1d6b, idProduct=3D0002
> usb usb1: New USB device strings: Mfr=3D3, Product=3D2, SerialNumber=3D1
> usb usb1: Product: OMAP-EHCI Host Controller
> usb usb1: Manufacturer: Linux 2.6.31-omap1 ehci_hcd
> usb usb1: SerialNumber: ehci-omap.0
> usb usb1: configuration #1 chosen from 1 choice
> hub 1-0:1.0: USB hub found
> hub 1-0:1.0: 3 ports detected
> g_ether gadget: using random self ethernet address
> g_ether gadget: using random host ethernet address
> usb0: MAC c2:de:6e:33:e8:94
> usb0: HOST MAC de:88:51:65:85:d5
> g_ether gadget: Ethernet Gadget, version: Memorial Day 2008
> g_ether gadget: g_ether ready
> musb_hdrc musb_hdrc: MUSB HDRC host driver
> musb_hdrc musb_hdrc: new USB bus registered, assigned bus number 2
> usb usb2: New USB device found, idVendor=3D1d6b, idProduct=3D0002
> usb usb2: New USB device strings: Mfr=3D3, Product=3D2, SerialNumber=3D1
> usb usb2: Product: MUSB HDRC host driver
> usb usb2: Manufacturer: Linux 2.6.31-omap1 musb-hcd
> usb usb2: SerialNumber: musb_hdrc
> usb usb2: configuration #1 chosen from 1 choice
> hub 2-0:1.0: USB hub found
> hub 2-0:1.0: 1 port detected
> twl4030_rtc twl4030_rtc: rtc core: registered twl4030_rtc as rtc0
> sdhci: Secure Digital Host Controller Interface driver
> sdhci: Copyright(c) Pierre Ossman
> mmci-omap-hs mmci-omap-hs.0: Failed to get debounce clock
> TCP cubic registered
> NET: Registered protocol family 17
> NET: Registered protocol family 15
> RPC: Registered udp transport module.
> RPC: Registered tcp transport module.
> Power Management for TI OMAP3.
> VFP support v0.3: implementor 41 architecture 3 part 30 variant c rev 1
> regulator_init_complete: incomplete constraints, leaving VDVI on
> regulator_init_complete: incomplete constraints, leaving VDAC on
> twl4030_rtc twl4030_rtc: setting system clock to 2000-01-01 00:05:44=20
> UTC (946685144)
> Waiting for root device /dev/mmcblk0p2...

I think the hang may have something to do with "OMAP clockevent source:=20
GPTIMER1 at 13000000 Hz". The Adeo patch changes this from the GPTimer12=20
at 32768 Hz.
(Note that on this chip, GPTimer12 is one of the timers with special=20
time-of-day (exact 1 millisecond tick capability) logic.)

The below is the diff result comparing against a successful boot log=20
without the Adeos patch.

> [Bob@domain.hid ~]$  diff L100718BootNoXeno.txt=20
> L100718BootXenoPatchedButDisabled.txt
> 20c20
> < 1885804 bytes read
> ---
> > 1911632 bytes read
> 24c24
> <    Data Size:    1885740 Bytes =3D  1.8 MB
> ---
> >    Data Size:    1911568 Bytes =3D  1.8 MB
> 34,35c34,35
> < ....................... done, booting the kernel.
> < Linux version 2.6.31-omap1 (Bob@domain.hid) (gcc version 4.3.3=20
> (GCC) ) #1 Sun Jul 18 00:08:49 PDT 2010
> ---
> > ......................... done, booting the kernel.
> > Linux version 2.6.31-omap1 (Bob@domain.hid) (gcc version 4.3.3=20
> (GCC) ) #2 Sun Jul 18 18:16:32 PDT 2010
> 48c48
> < Memory: 255872KB available (3264K code, 291K data, 132K init, 0K=20
> highmem)
> ---
> > Memory: 255744KB available (3320K code, 332K data, 132K init, 0K=20
> highmem)
> 56c56,57
> < OMAP clockevent source: GPTIMER12 at 32768 Hz
> ---
> > OMAP clockevent source: GPTIMER1 at 13000000 Hz
> > I-pipe 1.16-01: pipeline enabled.
> 58c59
> < Calibrating delay loop... 477.86 BogoMIPS (lpj=3D1863680)
> ---
> > Calibrating delay loop... 498.07 BogoMIPS (lpj=3D2490368)
> 96c97
> < msgmni has been set to 500
> ---
> > msgmni has been set to 499
> 132,133c133,134
> < usb0: MAC 22:8d:c8:09:48:2e
> < usb0: HOST MAC 36:3d:ab:d8:fa:11
> ---
> > usb0: MAC c2:de:6e:33:e8:94
> > usb0: HOST MAC de:88:51:65:85:d5
> 147,148d147
> < twl4030_rtc twl4030_rtc: Power up reset detected.
> < twl4030_rtc twl4030_rtc: Enabling TWL4030-RTC.
> 161c160
> < twl4030_rtc twl4030_rtc: setting system clock to 2000-01-01 00:00:00=20
> UTC (946684800)
> ---
> > twl4030_rtc twl4030_rtc: setting system clock to 2000-01-01 00:05:44=20
> UTC (946685144)
The is where the console output of the Adeos patched kernel stops.
> 163,203d161
> < mmc0: new high speed SDHC card at address 1234
> < mmcblk0: mmc0:1234 SA04G 3.68 GiB
> <  mmcblk0: p1 p2
> < kjournald starting.  Commit interval 5 seconds
> < EXT3 FS on mmcblk0p2, internal journal
> < EXT3-fs: recovery complete.
> < EXT3-fs: mounted filesystem with writeback data mode.
> < VFS: Mounted root (ext3 filesystem) on device 179:2.
> < Freeing init memory: 132K
> < INIT: version 2.86 booting
> < Please wait: booting...
> < Starting udev
> < Remounting root file system...
> < Caching udev devnodes
> < Populating dev cache
> < root: mount: mounting rootfs on / failed: No such file or directory
> < Configuring network interfaces... ifconfig: SIOCGIFFLAGS: No such device
> < done.
> < Setting up IP spoofing protection: rp_filter.
> < Tue May 18 20:58:00 UTC 2010
> < Starting to configure packages...
> < Nothing to be done
> < Finished to configure packages.
> < INIT: Entering runlevel: 5
> < Starting Dropbear SSH server: dropbear.
> < Starting syslogd/klogd: done
> <
> < .-------.
> < |       |                  .-.
> < |   |   |-----.-----.-----.| |   .----..-----.-----.
> < |       |     | __  |  ---'| '--.|  .-'|     |     |
> < |   |   |  |  |     |---  ||  --'|  |  |  '  | | | |
> < '---'---'--'--'--.  |-----''----''--'  '-----'-'-'-'
> <                 -'  |
> <                 '---'
> <
> < The Angstrom Distribution beagleboard ttyS2
> <
> < Angstrom 2010.4-test-20100518 beagleboard ttyS2
> <
> < beagleboard login:
> [Bob@domain.hid ~]$=20
Although the above console log states "Angstrom", most of the=20
distribution specific patches have been removed. Only the USB driver and=20
MADC patches remain. These show no conflicts with Adeos patches.

I suspect that the change in the event source timer rate is confusing=20
the waiting for the root file system to mount.

Does anyone know a way to fix this?

Regards,
Bob Feretich







