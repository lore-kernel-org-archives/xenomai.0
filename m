Message-ID: <4C43FC4F.3010006@domain.hid>
Date: Mon, 19 Jul 2010 00:18:39 -0700
From: Bob Feretich <bob.feretich@domain.hid>
MIME-Version: 1.0
References: <4C43C83F.5030401@domain.hid> <4C43D265.9080609@domain.hid>
In-Reply-To: <4C43D265.9080609@domain.hid>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
Subject: Re: [Xenomai-help] Adeos patched kernel hangs mounting root file
 system
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

  Thank you for the quick reply.

I rebuilt the non-Adeos patched kernel with the 32 KHz clocked disabled. 
It booted correctly, so that wasn't the problem.  I didn't see any other 
significant differences in the console boot logs.

The console log for the non-Adeos patched kernel with the 32 KHz clocked 
disabled is pasted below. The /proc/interrupts contents is displayed at 
the end.

I used the 1.16-01 patch.

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
> 1867604 bytes read
> ## Booting kernel from Legacy Image at 80300000 ...
>    Image Name:   Angstrom/2.6.31/beagleboard
>    Image Type:   ARM Linux Kernel Image (uncompressed)
>    Data Size:    1867540 Bytes =  1.8 MB
>    Load Address: 80008000
>    Entry Point:  80008000
>    Verifying Checksum ... OK
>    Loading Kernel Image ... OK
> OK
>
> Starting kernel ...
>
> Uncompressing 
> Linux.........................................................................................
> ............................. done, booting the kernel.
> Linux version 2.6.31-omap1 (Bob@domain.hid) (gcc version 4.3.3 (GCC) 
> ) #2 Sun Jul 18 22:38:24 PDT 2010
> CPU: ARMv7 Processor [411fc083] revision 3 (ARMv7), cr=10c53c7f
> CPU: VIPT nonaliasing data cache, VIPT nonaliasing instruction cache
> Machine: OMAP3 Beagle Board
> Memory policy: ECC disabled, Data cache writeback
> OMAP3430 ES3.0
> SRAM: Mapped pa 0x40200000 to va 0xe3000000 size: 0x100000
> Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 65024
> Kernel command line: console=ttyS2,115200n8 root=/dev/mmcblk0p2 rw 
> rootfstype=ext3 rootwait
> PID hash table entries: 1024 (order: 10, 4096 bytes)
> Dentry cache hash table entries: 32768 (order: 5, 131072 bytes)
> Inode-cache hash table entries: 16384 (order: 4, 65536 bytes)
> Memory: 128MB 128MB = 256MB total
> Memory: 255872KB available (3232K code, 290K data, 132K init, 0K highmem)
> NR_IRQS:402
> Clocking rate (Crystal/Core/MPU): 26.0/332/500 MHz
> Reprogramming SDRC clock to 332000000 Hz
> GPMC revision 5.0
> IRQ: Found an INTC at 0xd8200000 (revision 4.0) with 96 interrupts
> Total of 96 interrupts on 1 active controller
> OMAP34xx GPIO hardware version 2.5
> OMAP clockevent source: GPTIMER1 at 13000000 Hz
> Console: colour dummy device 80x30
> Calibrating delay loop... 498.07 BogoMIPS (lpj=2490368)
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
> musb_hdrc: version 6.0, musb-dma, otg (peripheral+host), debug=0
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
> JFFS2 version 2.2. (NAND) ï¿½Â© 2001-2006 Red Hat, Inc.
> msgmni has been set to 500
> alg: No test for stdrng (krng)
> Block layer SCSI generic (bsg) driver version 0.4 loaded (major 254)
> io scheduler noop registered
> io scheduler anticipatory registered (default)
> io scheduler deadline registered
> io scheduler cfq registered
> Serial: 8250/16550 driver, 4 ports, IRQ sharing enabled
> serial8250.0: ttyS0 at MMIO 0x4806a000 (irq = 72) is a ST16654
> serial8250.1: ttyS1 at MMIO 0x4806c000 (irq = 73) is a ST16654
> serial8250.2: ttyS2 at MMIO 0x49020000 (irq = 74) is a ST16654
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
> usb usb1: New USB device found, idVendor=1d6b, idProduct=0002
> usb usb1: New USB device strings: Mfr=3, Product=2, SerialNumber=1
> usb usb1: Product: OMAP-EHCI Host Controller
> usb usb1: Manufacturer: Linux 2.6.31-omap1 ehci_hcd
> usb usb1: SerialNumber: ehci-omap.0
> usb usb1: configuration #1 chosen from 1 choice
> hub 1-0:1.0: USB hub found
> hub 1-0:1.0: 3 ports detected
> g_ether gadget: using random self ethernet address
> g_ether gadget: using random host ethernet address
> usb0: MAC 8a:fe:ec:d2:7c:3d
> usb0: HOST MAC 9a:ca:2d:10:da:55
> g_ether gadget: Ethernet Gadget, version: Memorial Day 2008
> g_ether gadget: g_ether ready
> musb_hdrc musb_hdrc: MUSB HDRC host driver
> musb_hdrc musb_hdrc: new USB bus registered, assigned bus number 2
> usb usb2: New USB device found, idVendor=1d6b, idProduct=0002
> usb usb2: New USB device strings: Mfr=3, Product=2, SerialNumber=1
> usb usb2: Product: MUSB HDRC host driver
> usb usb2: Manufacturer: Linux 2.6.31-omap1 musb-hcd
> usb usb2: SerialNumber: musb_hdrc
> usb usb2: configuration #1 chosen from 1 choice
> hub 2-0:1.0: USB hub found
> hub 2-0:1.0: 1 port detected
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
> Waiting for root device /dev/mmcblk0p2...
> mmc0: new high speed SDHC card at address 1234
> mmcblk0: mmc0:1234 SA04G 3.68 GiB
>  mmcblk0: p1 p2
> kjournald starting.  Commit interval 5 seconds
> EXT3 FS on mmcblk0p2, internal journal
> EXT3-fs: mounted filesystem with writeback data mode.
> VFS: Mounted root (ext3 filesystem) on device 179:2.
> Freeing init memory: 132K
> INIT: version 2.86 booting
> Please wait: booting...
> Starting udev
> Remounting root file system...
> Caching udev devnodes
> Populating dev cache
> root: mount: mounting rootfs on / failed: No such file or directory
> Configuring network interfaces... ifconfig: SIOCGIFFLAGS: No such device
> done.
> Setting up IP spoofing protection: rp_filter.
> hwclock: can't open '/dev/misc/rtc': No such file or directory
> Tue May 18 20:58:00 UTC 2010
> hwclock: can't open '/dev/misc/rtc': No such file or directory
> Configuring update-modules.
> Starting to configure packages...
> Nothing to be done
> Finished to configure packages.
> INIT: Entering runlevel: 5
> Creating Dropbear SSH server RSA host key.
> Will output 1024 bit rsa secret key to 
> '/etc/dropbear/dropbear_rsa_host_key'
> Generating key, this may take a while...
> Public key portion is:
> ssh-rsa 
> AAAAB3NzaC1yc2EAAAADAQABAAAAgwDJb1gWi2/u83v7e+S9Ij31aK/QMD72J47fdtDm4jn37GTq6JpL7UxsmcTGRB30bmKFzMhP
> w0uCsbTAeU29KOG6BdlSYK1oI5bDl7jdYHeBvhoejrDCvdp3R9//3rVs0y+c7WYgDRid5aOxSSUAg2j+Ec6PuGniLBNYWOG7mJmru79P 
> roo
> t@domain.hid
> Fingerprint: md5 c6:e9:c0:07:33:e3:5c:61:35:a5:e0:24:e0:41:03:86
> Starting Dropbear SSH server: dropbear.
> Starting syslogd/klogd: done
>
> .-------.
> |       |                  .-.
> |   |   |-----.-----.-----.| |   .----..-----.-----.
> |       |     | __  |  ---'| '--.|  .-'|     |     |
> |   |   |  |  |     |---  ||  --'|  |  |  '  | | | |
> '---'---'--'--'--.  |-----''----''--'  '-----'-'-'-'
>                 -'  |
>                 '---'
>
> The Angstrom Distribution beagleboard ttyS2
>
> Angstrom 2010.4-test-20100518 beagleboard ttyS2
>
> beagleboard login: root
> root@domain.hid:~# cat /proc/interrupts
>            CPU0
>   7:          2        INTC  TWL4030-PIH
>  11:          0        INTC  prcm
>  12:       1078        INTC  DMA
>  37:       1009        INTC  gp timer
>  56:        273        INTC  i2c_omap
>  61:          0        INTC  i2c_omap
>  72:          1        INTC  serial idle
>  73:          1        INTC  serial idle
>  74:        158        INTC  serial idle, serial
>  77:          0        INTC  ehci_hcd:usb1
>  83:       1346        INTC  mmc0
>  92:          1        INTC  musb_hdrc
>  93:          0        INTC  musb_hdrc
> 378:          2     twl4030  twl4030_usb
> 384:          0     twl4030  mmc0
> Err:          0
> root@domain.hid:~# 
Regards,
Bob Feretich

On 7/18/2010 9:19 PM, Gilles Chanteperdrix wrote:
> Bob Feretich wrote:
>> I suspect that the change in the event source timer rate is confusing
>> the waiting for the root file system to mount.
>>
>> Does anyone know a way to fix this?
> The Adeos patch simply forces Kconfig to disable the 32kHz clock,
> because with a 32kHz clock source, we would only get a 30us granularity
> for timer and clock services, which we find unacceptable. But the option
> exists for a vanilla kernel as well.
>
> You should try and disable the 32kHz clock on a vanilla kernel, if you
> get the same issue, you should report it to the proper mailing list. If
> you do net get it, then you have another issue, such as a edge/level
> interrupts issue, and should give us more details such as the contents
> of /proc/interrupts.
>
> I also happen to run an OMAP3 based system, and I can mount and write to
> an SD card with Xenomai without any problem (it is a 2.6.33 kernel,
> tested with I-pipe version 1.16-01 and 1.17-01).
>

