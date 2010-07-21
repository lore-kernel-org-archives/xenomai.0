Message-ID: <4C478313.2030606@domain.hid>
Date: Wed, 21 Jul 2010 16:30:27 -0700
From: Bob Feretich <bob.feretich@domain.hid>
MIME-Version: 1.0
References: <4C43C83F.5030401@domain.hid>
	<4C43D265.9080609@domain.hid>	<4C43FC4F.3010006@domain.hid>
	<4C440D6F.1060204@domain.hid>	<4C44E9C9.3020600@domain.hid>
	<4C454C0C.6000100@domain.hid>	<4C4550C8.3070504@domain.hid>
	<4C45541C.5090507@domain.hid> <4C45CEE6.5000903@domain.hid>
	<4C460506.3010103@domain.hid> <4C46141F.50103@domain.hid>
	<4C468040.3030509@domain.hid> <4C468485.5060408@domain.hid>
	<4C47597F.1010406@domain.hid>
In-Reply-To: <4C47597F.1010406@domain.hid>
Content-Type: multipart/alternative;
	boundary="------------020106030802090208000600"
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
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>, xenomai@xenomai.org

This is a multi-part message in MIME format.
--------------020106030802090208000600
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit

  When I boot the vanilla 2.6.32 omap kernel and mount the SD-card as 
the root file system no interrupts occur on IRQ 384. So, this change 
must have occurred in the 2.6.32 release.
That *may* mean that the Adeos patch will work  with 2.6.32.

Although this kernel did not cause IRQ 384 interrupts, there were two 
IRQ 378 interrupts from the USB power system. I believe that the IRQ 378 
interrupts are handled via I2C by the same kernel task that handles IRQ 
384.  If I am guessing correctly, the lack of interrupts on IRQ 384 
would permit the kernel to boot even with an Adeos patch applied. The 
interrupts on IRQ 378 could then be checked to see if they were handled 
by the I2C interrupt handler. This Level2 2 interrupt handler task 
should be invoked by the IRQ 7 interrupts, read the twl chip, and post 
interrupts to IRQ 378. If something is wrong, then the IRQ 378 counter 
won't reflect the IRQ 7 count.

How difficult is it to port enough of the Adeos patch to 2.6.32 to 
permit booting with Xenomai disabled?

I will examine the 2.6.32 kernel development logs for entries related to 
this change.

Regards,
Bob Feretich

Console log follows...
Texas Instruments X-Loader 1.4.2 (Feb 19 2009 - 12:01:24)
Reading boot sector
Loading u-boot.bin from mmc


U-Boot 2009.06-rc2 (Nov 02 2009 - 23:57:20)

OMAP3530-GP ES3.0, CPU-OPP2 L3-165MHz
OMAP3 Beagle board + LPDDR/NAND
DRAM:  256 MB
NAND:  256 MiB
In:    serial
Out:   serial
Err:   serial
Board revision C
Die ID #317000030000000004013f8a1701a01b
Hit any key to stop autoboot:  0
mmc1 is available
reading uImage

2659320 bytes read
## Booting kernel from Legacy Image at 80300000 ...
    Image Name:   Angstrom/2.6.32/beagleboard
    Image Type:   ARM Linux Kernel Image (uncompressed)
    Data Size:    2659256 Bytes =  2.5 MB
    Load Address: 80008000
    Entry Point:  80008000
    Verifying Checksum ... OK
    Loading Kernel Image ... OK
OK

Starting kernel ...

Uncompressing 
Linux....................................................................................................
......................................................................... done, 
booting the kernel.
[    0.000000] Linux version 2.6.32 (Bob@domain.hid) (gcc version 
4.3.3 (GCC) ) #1 PREEMPT Wed Jul 21 14:15:03 PDT 20
10
[    0.000000] CPU: ARMv7 Processor [411fc083] revision 3 (ARMv7), 
cr=10c53c7f
[    0.000000] CPU: VIPT nonaliasing data cache, VIPT nonaliasing 
instruction cache
[    0.000000] Machine: OMAP3 Beagle Board
[    0.000000] Memory policy: ECC disabled, Data cache writeback
[    0.000000] OMAP3430/3530 ES3.0 (l2cache iva sgx neon isp )
[    0.000000] SRAM: Mapped pa 0x40200000 to va 0xfe400000 size: 0x100000
[    0.000000] Built 1 zonelists in Zone order, mobility grouping on.  
Total pages: 65024
[    0.000000] Kernel command line: console=ttyS2,115200n8 
root=/dev/mmcblk0p2 rw rootfstype=ext3 rootwait
[    0.000000] PID hash table entries: 1024 (order: 0, 4096 bytes)
[    0.000000] Dentry cache hash table entries: 32768 (order: 5, 131072 
bytes)
[    0.000000] Inode-cache hash table entries: 16384 (order: 4, 65536 bytes)
[    0.000000] Memory: 128MB 128MB = 256MB total
[    0.000000] Memory: 253952KB available (4860K code, 559K data, 164K 
init, 0K highmem)
[    0.000000] Hierarchical RCU implementation.
[    0.000000] NR_IRQS:402
[    0.000000] Clocking rate (Crystal/Core/MPU): 26.0/332/500 MHz
[    0.000000] Reprogramming SDRC clock to 332000000 Hz
[    0.000000] GPMC revision 5.0
[    0.000000] IRQ: Found an INTC at 0xfa200000 (revision 4.0) with 96 
interrupts
[    0.000000] Total of 96 interrupts on 1 active controller
[    0.000000] OMAP GPIO hardware version 2.5
[    0.000000] OMAP clockevent source: GPTIMER12 at 32768 Hz
[    0.000000] Console: colour dummy device 80x30
[    0.000000] Calibrating delay loop... 480.01 BogoMIPS (lpj=1875968)
[    0.000000] Mount-cache hash table entries: 512
[    0.000000] CPU: Testing write buffer coherency: ok
[    0.000000] devtmpfs: initialized
[    0.000000] regulator: core version 0.5
[    0.000000] NET: Registered protocol family 16
[    0.000000] Found NAND on CS0
[    0.000000] Registering NAND on CS0
[   18.373596] OMAP DMA hardware revision 4.0
[   18.379821] bio: create slab <bio-0> at 0
[   18.381439] SCSI subsystem initialized
[   18.382171] usbcore: registered new interface driver usbfs
[   18.382354] usbcore: registered new interface driver hub
[   18.382568] usbcore: registered new device driver usb
[   18.383026] i2c_omap i2c_omap.1: bus 1 rev3.12 at 2600 kHz
[   18.386108] twl4030: PIH (irq 7) chaining IRQs 368..375
[   18.386138] twl4030: power (irq 373) chaining IRQs 376..383
[   18.386505] twl4030: gpio (irq 368) chaining IRQs 384..401
[   18.387969] regulator: VUSB1V5: 1500 mV normal standby
[   18.388305] regulator: VUSB1V8: 1800 mV normal standby
[   18.388671] regulator: VUSB3V1: 3100 mV normal standby
[   18.390106] twl4030_usb twl4030_usb: Initialized TWL4030 USB module
[   18.390563] regulator: VMMC1: 1850 <--> 3150 mV normal standby
[   18.390869] regulator: VDAC: 1800 mV normal standby
[   18.391204] regulator: VPLL2: 1800 mV normal standby
[   18.391510] regulator: VSIM: 1800 <--> 3000 mV normal standby
[   18.403625] i2c_omap i2c_omap.3: bus 3 rev3.12 at 100 kHz
[   18.404998] Switching to clocksource 32k_counter
[   18.416595] musb_hdrc: version 6.0, musb-dma, otg (peripheral+host), 
debug=0
[   18.420166] musb_hdrc: USB OTG mode controller at fa0ab000 using DMA, 
IRQ 92
[   18.420898] NET: Registered protocol family 2
[   18.421173] IP route cache hash table entries: 2048 (order: 1, 8192 
bytes)
[   18.421844] TCP established hash table entries: 8192 (order: 4, 65536 
bytes)
[   18.422088] TCP bind hash table entries: 8192 (order: 3, 32768 bytes)
[   18.422241] TCP: Hash tables configured (established 8192 bind 8192)
[   18.422271] TCP reno registered
[   18.422546] NET: Registered protocol family 1
[   18.423095] RPC: Registered udp transport module.
[   18.423095] RPC: Registered tcp transport module.
[   18.423126] RPC: Registered tcp NFSv4.1 backchannel transport module.
[   18.425628] VFS: Disk quotas dquot_6.5.2
[   18.425750] Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)
[   18.427154] squashfs: version 4.0 (2009/01/31) Phillip Lougher
[   18.428161] JFFS2 version 2.2. (NAND) (SUMMARY)  ï¿½Ý© 2001-2006 Red 
Hat, Inc.
[   18.429351] msgmni has been set to 496
[   18.434722] alg: No test for stdrng (krng)
[   18.435089] Block layer SCSI generic (bsg) driver version 0.4 loaded 
(major 254)
[   18.435119] io scheduler noop registered
[   18.435150] io scheduler anticipatory registered
[   18.435150] io scheduler deadline registered
[   18.435333] io scheduler cfq registered (default)
[   18.447570] Serial: 8250/16550 driver, 4 ports, IRQ sharing enabled
[   18.468475] serial8250.0: ttyS0 at MMIO 0x4806a000 (irq = 72) is a 
ST16654
[   18.488403] serial8250.1: ttyS1 at MMIO 0x4806c000 (irq = 73) is a 
ST16654
[   18.508300] serial8250.2: ttyS2 at MMIO 0x49020000 (irq = 74) is a 
ST16654
[   18.940307] console [ttyS2] enabled
[   18.952697] brd: module loaded
[   18.960174] loop: module loaded
[   18.964416] omap2-nand driver initializing
[   18.968963] NAND device: Manufacturer ID: 0x2c, Chip ID: 0xba (Micron 
NAND 256MiB 1,8V 16-bit)
[   18.978149] cmdlinepart partition parsing not available
[   18.983489] Creating 5 MTD partitions on "omap2-nand":
[   18.988677] 0x000000000000-0x000000080000 : "X-Loader"
[   18.995330] 0x000000080000-0x000000260000 : "U-Boot"
[   19.002105] 0x000000260000-0x000000280000 : "U-Boot Env"
[   19.008514] 0x000000280000-0x000000680000 : "Kernel"
[   19.016113] 0x000000680000-0x000010000000 : "File System"
[   19.124450] usbcore: registered new interface driver catc
[   19.129882] catc: v2.8:CATC EL1210A NetMate USB Ethernet driver
[   19.135955] usbcore: registered new interface driver kaweth
[   19.141632] pegasus: v0.6.14 (2006/09/27), Pegasus/Pegasus II USB 
Ethernet driver
[   19.149261] usbcore: registered new interface driver pegasus
[   19.154998] rtl8150: v0.6.2 (2004/08/27):rtl8150 based usb-ethernet 
driver
[   19.162048] usbcore: registered new interface driver rtl8150
[   19.167846] usbcore: registered new interface driver asix
[   19.173400] usbcore: registered new interface driver cdc_ether
[   19.179412] usbcore: registered new interface driver dm9601
[   19.185119] usbcore: registered new interface driver smsc95xx
[   19.191040] usbcore: registered new interface driver gl620a
[   19.196777] usbcore: registered new interface driver net1080
[   19.202575] usbcore: registered new interface driver plusb
[   19.208190] usbcore: registered new interface driver rndis_host
[   19.214263] usbcore: registered new interface driver cdc_subset
[   19.220367] usbcore: registered new interface driver zaurus
[   19.226104] usbcore: registered new interface driver MOSCHIP 
usb-ethernet driver
[   19.234161] Initializing USB Mass Storage driver...
[   19.239196] usbcore: registered new interface driver usb-storage
[   19.245330] USB Mass Storage support registered.
[   19.250061] g_ether gadget: using random self ethernet address
[   19.255950] g_ether gadget: using random host ethernet address
[   19.262390] usb0: MAC 76:ff:8e:a3:38:74
[   19.266326] usb0: HOST MAC 92:e6:7c:a6:1a:38
[   19.270660] g_ether gadget: Ethernet Gadget, version: Memorial Day 2008
[   19.277374] g_ether gadget: g_ether ready
[   19.281433] musb_hdrc musb_hdrc: MUSB HDRC host driver
[   19.287078] musb_hdrc musb_hdrc: new USB bus registered, assigned bus 
number 1
[   19.294555] usb usb1: New USB device found, idVendor=1d6b, idProduct=0002
[   19.301422] usb usb1: New USB device strings: Mfr=3, Product=2, 
SerialNumber=1
[   19.308715] usb usb1: Product: MUSB HDRC host driver
[   19.313751] usb usb1: Manufacturer: Linux 2.6.32 musb-hcd
[   19.319213] usb usb1: SerialNumber: musb_hdrc
[   19.324157] usb usb1: configuration #1 chosen from 1 choice
[   19.330078] hub 1-0:1.0: USB hub found
[   19.333953] hub 1-0:1.0: 1 port detected
[   19.338867] mice: PS/2 mouse device common for all mice
[   19.344665] input: gpio-keys as /devices/platform/gpio-keys/input/input0
[   19.352996] input: twl4030_pwrbutton as 
/devices/platform/i2c_omap.1/i2c-1/1-0049/twl4030_pwrbutton/input/input1
[   19.363922] i2c /dev entries driver
[   19.475860] Registered led device: beagleboard::usr0
[   19.481018] Registered led device: beagleboard::usr1
[   19.486724] Registered led device: beagleboard::pmu_stat
[   19.492309] oprofile: using arm/armv7
[   19.496276] TCP cubic registered
[   19.499603] NET: Registered protocol family 17
[   19.504119] NET: Registered protocol family 15
[   19.508728] ThumbEE CPU extension supported.
[   19.513031] Power Management for TI OMAP3.
[   19.528015] VFP support v0.3: implementor 41 architecture 3 part 30 
variant c rev 1
[   19.536712] registered taskstats version 1
[   19.542541] regulator_init_complete: incomplete constraints, leaving 
VDVI on
[   19.549804] regulator_init_complete: incomplete constraints, leaving 
VDAC on
[   19.557556] Waiting for root device /dev/mmcblk0p2...
[   19.842773] mmc0: new high speed SDHC card at address cd63
[   19.848846] mmcblk0: mmc0:cd63 SD04G 3.69 GiB
[   19.853790]  mmcblk0: p1 p2
[   19.896240] kjournald starting.  Commit interval 5 seconds
[   20.155639] EXT3 FS on mmcblk0p2, internal journal
[   20.160491] EXT3-fs: mounted filesystem with writeback data mode.
[   20.166717] VFS: Mounted root (ext3 filesystem) on device 179:2.
[   20.175598] devtmpfs: mounted
[   20.178741] Freeing init memory: 164K
INIT: version 2.86 booting
Please wait: booting...
Starting udev
Remounting root file system...
Caching udev devnodes
Populating dev cache
root: mount: mounting rootfs on / failed: No such file or directory
Configuring network interfaces... ifconfig: SIOCGIFFLAGS: No such device
done.
Setting up IP spoofing protection: rp_filter.
hwclock: can't open '/dev/misc/rtc': No such file or directory
Tue May 18 20:58:00 UTC 2010
hwclock: can't open '/dev/misc/rtc': No such file or directory
Configuring update-modules.
Starting to configure packages...
Nothing to be done
Finished to configure packages.
INIT: Entering runlevel: 5
Creating Dropbear SSH server RSA host key.
Will output 1024 bit rsa secret key to '/etc/dropbear/dropbear_rsa_host_key'
Generating key, this may take a while...
Public key portion is:
ssh-rsa 
AAAAB3NzaC1yc2EAAAADAQABAAAAgwCFnP91SQbJJLLS7KMeQYYjBm2KLETrqGJtmHxTotPEBJi8cgFBkW2ZBk8mgz+u92kJOkKmk/UJtV/gkXo
sibLr41W2CJyf6ILPujqZk0RvGxybuW5dp18C2rP9uW3vPhQ4GDrXG3s5i7r/s5hvgWtY8QDXcYVLtZUsx6B/fufK+aaT 
root@domain.hid
Fingerprint: md5 59:56:33:4a:a7:8f:ba:e6:33:43:2d:d1:3d:a6:83:1e
Starting Dropbear SSH server: dropbear.
Starting syslogd/klogd: done

.-------.
|       |                  .-.
|   |   |-----.-----.-----.| |   .----..-----.-----.
|       |     | __  |  ---'| '--.|  .-'|     |     |
|   |   |  |  |     |---  ||  --'|  |  |  '  | | | |
'---'---'--'--'--.  |-----''----''--'  '-----'-'-'-'
                 -'  |
                 '---'

The Angstrom Distribution beagleboard ttyS2

Angstrom 2010.4-test-20100518 beagleboard ttyS2

beagleboard login: root
root@domain.hid:~# cat /proc/interrupts
            CPU0
   7:          2        INTC  TWL4030-PIH
  11:          0        INTC  prcm
  12:       1114        INTC  DMA
  56:        304        INTC  i2c_omap
  61:          0        INTC  i2c_omap
  72:          1        INTC  serial idle
  73:          1        INTC  serial idle
  74:        201        INTC  serial idle, serial
  83:       1976        INTC  mmc0
  92:          1        INTC  musb_hdrc
  93:          0        INTC  musb_hdrc
  95:       3266        INTC  gp timer
167:          0        GPIO  user
376:          0     twl4030  twl4030_pwrbutton
378:          2     twl4030  twl4030_usb
384:          0     twl4030  mmc0
Err:          0
root@domain.hid:~#

On 7/21/2010 1:33 PM, Bob Feretich wrote:
> I reverted the patch that you suggested. Spurious interrupts crashed 
> the kernel during boot. (console log below)
>
> The only data that I have to go on for the difference between the 
> Adeos hang on 2.6.31 and successful boot on 2.6.33 is interrupts on 
> IRQ 384, which occur on 2.6.31 but not 2.6.33.
> This change in interrupts is independent of the Adeos patch, so I will 
> build a vanilla 2.6.32 kernel and see if the interrupts occur there. 
> This may help isolate which kernel change made the difference.
>
> Regards,
> Bob Feretich
>
> Boot log with 2.6.31 patch reverted...
> Texas Instruments X-Loader 1.4.2 (Feb 19 2009 - 12:01:24)
> Reading boot sector
> ... snipped ...

--------------020106030802090208000600
Content-Type: text/html; charset="utf-8"
Content-Transfer-Encoding: 8bit

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <meta content="text/html; charset=UTF-8" http-equiv="Content-Type">
  </head>
  <body bgcolor="#ffffff" text="#000000">
    When I boot the vanilla 2.6.32 omap kernel and mount the SD-card as
    the root file system no interrupts occur on IRQ 384. So, this change
    must have occurred in the 2.6.32 release.<br>
    That *may* mean that the Adeos patch will work  with 2.6.32.<br>
    <br>
    Although this kernel did not cause IRQ 384 interrupts, there were
    two IRQ 378 interrupts from the USB power system. I believe that the
    IRQ 378 interrupts are handled via I2C by the same kernel task that
    handles IRQ 384.  If I am guessing correctly, the lack of interrupts
    on IRQ 384 would permit the kernel to boot even with an Adeos patch
    applied. The interrupts on IRQ 378 could then be checked to see if
    they were handled by the I2C interrupt handler. This Level2 2
    interrupt handler task should be invoked by the IRQ 7 interrupts,
    read the twl chip, and post interrupts to IRQ 378. If something is
    wrong, then the IRQ 378 counter won't reflect the IRQ 7 count.<br>
    <br>
    How difficult is it to port enough of the Adeos patch to 2.6.32 to
    permit booting with Xenomai disabled?<br>
    <br>
    I will examine the 2.6.32 kernel development logs for entries
    related to this change.<br>
    <br>
    Regards,<br>
    Bob Feretich<br>
    <br>
    Console log follows...<br>
    <small><tt>Texas Instruments X-Loader 1.4.2 (Feb 19 2009 - 12:01:24)<br>
        Reading boot sector<br>
        Loading u-boot.bin from mmc<br>
        <br>
        <br>
        U-Boot 2009.06-rc2 (Nov 02 2009 - 23:57:20)<br>
        <br>
        OMAP3530-GP ES3.0, CPU-OPP2 L3-165MHz<br>
        OMAP3 Beagle board + LPDDR/NAND<br>
        DRAM:  256 MB<br>
        NAND:  256 MiB<br>
        In:    serial<br>
        Out:   serial<br>
        Err:   serial<br>
        Board revision C<br>
        Die ID #317000030000000004013f8a1701a01b<br>
        Hit any key to stop autoboot:  0 <br>
        mmc1 is available<br>
        reading uImage<br>
        <br>
        2659320 bytes read<br>
        ## Booting kernel from Legacy Image at 80300000 ...<br>
           Image Name:   Angstrom/2.6.32/beagleboard<br>
           Image Type:   ARM Linux Kernel Image (uncompressed)<br>
           Data Size:    2659256 Bytes =  2.5 MB<br>
           Load Address: 80008000<br>
           Entry Point:  80008000<br>
           Verifying Checksum ... OK<br>
           Loading Kernel Image ... OK<br>
        OK<br>
        <br>
        Starting kernel ...<br>
        <br>
        Uncompressing
Linux....................................................................................................<br>
        .........................................................................
        done, booting the kernel.<br>
        [    0.000000] Linux version 2.6.32 (<a class="moz-txt-link-abbreviated" href="mailto:Bob@domain.hid">Bob@domain.hid</a>) (gcc
        version 4.3.3 (GCC) ) #1 PREEMPT Wed Jul 21 14:15:03 PDT 20<br>
        10<br>
        [    0.000000] CPU: ARMv7 Processor [411fc083] revision 3
        (ARMv7), cr=10c53c7f<br>
        [    0.000000] CPU: VIPT nonaliasing data cache, VIPT
        nonaliasing instruction cache<br>
        [    0.000000] Machine: OMAP3 Beagle Board<br>
        [    0.000000] Memory policy: ECC disabled, Data cache writeback<br>
        [    0.000000] OMAP3430/3530 ES3.0 (l2cache iva sgx neon isp )<br>
        [    0.000000] SRAM: Mapped pa 0x40200000 to va 0xfe400000 size:
        0x100000<br>
        [    0.000000] Built 1 zonelists in Zone order, mobility
        grouping on.  Total pages: 65024<br>
        [    0.000000] Kernel command line: console=ttyS2,115200n8
        root=/dev/mmcblk0p2 rw rootfstype=ext3 rootwait<br>
        [    0.000000] PID hash table entries: 1024 (order: 0, 4096
        bytes)<br>
        [    0.000000] Dentry cache hash table entries: 32768 (order: 5,
        131072 bytes)<br>
        [    0.000000] Inode-cache hash table entries: 16384 (order: 4,
        65536 bytes)<br>
        [    0.000000] Memory: 128MB 128MB = 256MB total<br>
        [    0.000000] Memory: 253952KB available (4860K code, 559K
        data, 164K init, 0K highmem)<br>
        [    0.000000] Hierarchical RCU implementation.<br>
        [    0.000000] NR_IRQS:402<br>
        [    0.000000] Clocking rate (Crystal/Core/MPU): 26.0/332/500
        MHz<br>
        [    0.000000] Reprogramming SDRC clock to 332000000 Hz<br>
        [    0.000000] GPMC revision 5.0<br>
        [    0.000000] IRQ: Found an INTC at 0xfa200000 (revision 4.0)
        with 96 interrupts<br>
        [    0.000000] Total of 96 interrupts on 1 active controller<br>
        [    0.000000] OMAP GPIO hardware version 2.5<br>
        [    0.000000] OMAP clockevent source: GPTIMER12 at 32768 Hz<br>
        [    0.000000] Console: colour dummy device 80x30<br>
        [    0.000000] Calibrating delay loop... 480.01 BogoMIPS
        (lpj=1875968)<br>
        [    0.000000] Mount-cache hash table entries: 512<br>
        [    0.000000] CPU: Testing write buffer coherency: ok<br>
        [    0.000000] devtmpfs: initialized<br>
        [    0.000000] regulator: core version 0.5<br>
        [    0.000000] NET: Registered protocol family 16<br>
        [    0.000000] Found NAND on CS0<br>
        [    0.000000] Registering NAND on CS0<br>
        [   18.373596] OMAP DMA hardware revision 4.0<br>
        [   18.379821] bio: create slab &lt;bio-0&gt; at 0<br>
        [   18.381439] SCSI subsystem initialized<br>
        [   18.382171] usbcore: registered new interface driver usbfs<br>
        [   18.382354] usbcore: registered new interface driver hub<br>
        [   18.382568] usbcore: registered new device driver usb<br>
        [   18.383026] i2c_omap i2c_omap.1: bus 1 rev3.12 at 2600 kHz<br>
        [   18.386108] twl4030: PIH (irq 7) chaining IRQs 368..375<br>
        [   18.386138] twl4030: power (irq 373) chaining IRQs 376..383<br>
        [   18.386505] twl4030: gpio (irq 368) chaining IRQs 384..401<br>
        [   18.387969] regulator: VUSB1V5: 1500 mV normal standby<br>
        [   18.388305] regulator: VUSB1V8: 1800 mV normal standby<br>
        [   18.388671] regulator: VUSB3V1: 3100 mV normal standby<br>
        [   18.390106] twl4030_usb twl4030_usb: Initialized TWL4030 USB
        module<br>
        [   18.390563] regulator: VMMC1: 1850 &lt;--&gt; 3150 mV normal
        standby<br>
        [   18.390869] regulator: VDAC: 1800 mV normal standby<br>
        [   18.391204] regulator: VPLL2: 1800 mV normal standby<br>
        [   18.391510] regulator: VSIM: 1800 &lt;--&gt; 3000 mV normal
        standby<br>
        [   18.403625] i2c_omap i2c_omap.3: bus 3 rev3.12 at 100 kHz<br>
        [   18.404998] Switching to clocksource 32k_counter<br>
        [   18.416595] musb_hdrc: version 6.0, musb-dma, otg
        (peripheral+host), debug=0<br>
        [   18.420166] musb_hdrc: USB OTG mode controller at fa0ab000
        using DMA, IRQ 92<br>
        [   18.420898] NET: Registered protocol family 2<br>
        [   18.421173] IP route cache hash table entries: 2048 (order:
        1, 8192 bytes)<br>
        [   18.421844] TCP established hash table entries: 8192 (order:
        4, 65536 bytes)<br>
        [   18.422088] TCP bind hash table entries: 8192 (order: 3,
        32768 bytes)<br>
        [   18.422241] TCP: Hash tables configured (established 8192
        bind 8192)<br>
        [   18.422271] TCP reno registered<br>
        [   18.422546] NET: Registered protocol family 1<br>
        [   18.423095] RPC: Registered udp transport module.<br>
        [   18.423095] RPC: Registered tcp transport module.<br>
        [   18.423126] RPC: Registered tcp NFSv4.1 backchannel transport
        module.<br>
        [   18.425628] VFS: Disk quotas dquot_6.5.2<br>
        [   18.425750] Dquot-cache hash table entries: 1024 (order 0,
        4096 bytes)<br>
        [   18.427154] squashfs: version 4.0 (2009/01/31) Phillip
        Lougher<br>
        [   18.428161] JFFS2 version 2.2. (NAND) (SUMMARY)  ï¿½Ý©
        2001-2006 Red Hat, Inc.<br>
        [   18.429351] msgmni has been set to 496<br>
        [   18.434722] alg: No test for stdrng (krng)<br>
        [   18.435089] Block layer SCSI generic (bsg) driver version 0.4
        loaded (major 254)<br>
        [   18.435119] io scheduler noop registered<br>
        [   18.435150] io scheduler anticipatory registered<br>
        [   18.435150] io scheduler deadline registered<br>
        [   18.435333] io scheduler cfq registered (default)<br>
        [   18.447570] Serial: 8250/16550 driver, 4 ports, IRQ sharing
        enabled<br>
        [   18.468475] serial8250.0: ttyS0 at MMIO 0x4806a000 (irq = 72)
        is a ST16654<br>
        [   18.488403] serial8250.1: ttyS1 at MMIO 0x4806c000 (irq = 73)
        is a ST16654<br>
        [   18.508300] serial8250.2: ttyS2 at MMIO 0x49020000 (irq = 74)
        is a ST16654<br>
        [   18.940307] console [ttyS2] enabled<br>
        [   18.952697] brd: module loaded<br>
        [   18.960174] loop: module loaded<br>
        [   18.964416] omap2-nand driver initializing<br>
        [   18.968963] NAND device: Manufacturer ID: 0x2c, Chip ID: 0xba
        (Micron NAND 256MiB 1,8V 16-bit)<br>
        [   18.978149] cmdlinepart partition parsing not available<br>
        [   18.983489] Creating 5 MTD partitions on "omap2-nand":<br>
        [   18.988677] 0x000000000000-0x000000080000 : "X-Loader"<br>
        [   18.995330] 0x000000080000-0x000000260000 : "U-Boot"<br>
        [   19.002105] 0x000000260000-0x000000280000 : "U-Boot Env"<br>
        [   19.008514] 0x000000280000-0x000000680000 : "Kernel"<br>
        [   19.016113] 0x000000680000-0x000010000000 : "File System"<br>
        [   19.124450] usbcore: registered new interface driver catc<br>
        [   19.129882] catc: v2.8:CATC EL1210A NetMate USB Ethernet
        driver<br>
        [   19.135955] usbcore: registered new interface driver kaweth<br>
        [   19.141632] pegasus: v0.6.14 (2006/09/27), Pegasus/Pegasus II
        USB Ethernet driver<br>
        [   19.149261] usbcore: registered new interface driver pegasus<br>
        [   19.154998] rtl8150: v0.6.2 (2004/08/27):rtl8150 based
        usb-ethernet driver<br>
        [   19.162048] usbcore: registered new interface driver rtl8150<br>
        [   19.167846] usbcore: registered new interface driver asix<br>
        [   19.173400] usbcore: registered new interface driver
        cdc_ether<br>
        [   19.179412] usbcore: registered new interface driver dm9601<br>
        [   19.185119] usbcore: registered new interface driver smsc95xx<br>
        [   19.191040] usbcore: registered new interface driver gl620a<br>
        [   19.196777] usbcore: registered new interface driver net1080<br>
        [   19.202575] usbcore: registered new interface driver plusb<br>
        [   19.208190] usbcore: registered new interface driver
        rndis_host<br>
        [   19.214263] usbcore: registered new interface driver
        cdc_subset<br>
        [   19.220367] usbcore: registered new interface driver zaurus<br>
        [   19.226104] usbcore: registered new interface driver MOSCHIP
        usb-ethernet driver<br>
        [   19.234161] Initializing USB Mass Storage driver...<br>
        [   19.239196] usbcore: registered new interface driver
        usb-storage<br>
        [   19.245330] USB Mass Storage support registered.<br>
        [   19.250061] g_ether gadget: using random self ethernet
        address<br>
        [   19.255950] g_ether gadget: using random host ethernet
        address<br>
        [   19.262390] usb0: MAC 76:ff:8e:a3:38:74<br>
        [   19.266326] usb0: HOST MAC 92:e6:7c:a6:1a:38<br>
        [   19.270660] g_ether gadget: Ethernet Gadget, version:
        Memorial Day 2008<br>
        [   19.277374] g_ether gadget: g_ether ready<br>
        [   19.281433] musb_hdrc musb_hdrc: MUSB HDRC host driver<br>
        [   19.287078] musb_hdrc musb_hdrc: new USB bus registered,
        assigned bus number 1<br>
        [   19.294555] usb usb1: New USB device found, idVendor=1d6b,
        idProduct=0002<br>
        [   19.301422] usb usb1: New USB device strings: Mfr=3,
        Product=2, SerialNumber=1<br>
        [   19.308715] usb usb1: Product: MUSB HDRC host driver<br>
        [   19.313751] usb usb1: Manufacturer: Linux 2.6.32 musb-hcd<br>
        [   19.319213] usb usb1: SerialNumber: musb_hdrc<br>
        [   19.324157] usb usb1: configuration #1 chosen from 1 choice<br>
        [   19.330078] hub 1-0:1.0: USB hub found<br>
        [   19.333953] hub 1-0:1.0: 1 port detected<br>
        [   19.338867] mice: PS/2 mouse device common for all mice<br>
        [   19.344665] input: gpio-keys as
        /devices/platform/gpio-keys/input/input0<br>
        [   19.352996] input: twl4030_pwrbutton as
        /devices/platform/i2c_omap.1/i2c-1/1-0049/twl4030_pwrbutton/input/input1<br>
        [   19.363922] i2c /dev entries driver<br>
        [   19.475860] Registered led device: beagleboard::usr0<br>
        [   19.481018] Registered led device: beagleboard::usr1<br>
        [   19.486724] Registered led device: beagleboard::pmu_stat<br>
        [   19.492309] oprofile: using arm/armv7<br>
        [   19.496276] TCP cubic registered<br>
        [   19.499603] NET: Registered protocol family 17<br>
        [   19.504119] NET: Registered protocol family 15<br>
        [   19.508728] ThumbEE CPU extension supported.<br>
        [   19.513031] Power Management for TI OMAP3.<br>
        [   19.528015] VFP support v0.3: implementor 41 architecture 3
        part 30 variant c rev 1<br>
        [   19.536712] registered taskstats version 1<br>
        [   19.542541] regulator_init_complete: incomplete constraints,
        leaving VDVI on<br>
        [   19.549804] regulator_init_complete: incomplete constraints,
        leaving VDAC on<br>
        [   19.557556] Waiting for root device /dev/mmcblk0p2...<br>
        [   19.842773] mmc0: new high speed SDHC card at address cd63<br>
        [   19.848846] mmcblk0: mmc0:cd63 SD04G 3.69 GiB <br>
        [   19.853790]  mmcblk0: p1 p2<br>
        [   19.896240] kjournald starting.  Commit interval 5 seconds<br>
        [   20.155639] EXT3 FS on mmcblk0p2, internal journal<br>
        [   20.160491] EXT3-fs: mounted filesystem with writeback data
        mode.<br>
        [   20.166717] VFS: Mounted root (ext3 filesystem) on device
        179:2.<br>
        [   20.175598] devtmpfs: mounted<br>
        [   20.178741] Freeing init memory: 164K<br>
        INIT: version 2.86 booting<br>
        Please wait: booting...<br>
        Starting udev<br>
        Remounting root file system...<br>
        Caching udev devnodes<br>
        Populating dev cache<br>
        root: mount: mounting rootfs on / failed: No such file or
        directory<br>
        Configuring network interfaces... ifconfig: SIOCGIFFLAGS: No
        such device<br>
        done.<br>
        Setting up IP spoofing protection: rp_filter.<br>
        hwclock: can't open '/dev/misc/rtc': No such file or directory<br>
        Tue May 18 20:58:00 UTC 2010<br>
        hwclock: can't open '/dev/misc/rtc': No such file or directory<br>
        Configuring update-modules.<br>
        Starting to configure packages...<br>
        Nothing to be done<br>
        Finished to configure packages.<br>
        INIT: Entering runlevel: 5<br>
        Creating Dropbear SSH server RSA host key.<br>
        Will output 1024 bit rsa secret key to
        '/etc/dropbear/dropbear_rsa_host_key'<br>
        Generating key, this may take a while...<br>
        Public key portion is:<br>
        ssh-rsa
AAAAB3NzaC1yc2EAAAADAQABAAAAgwCFnP91SQbJJLLS7KMeQYYjBm2KLETrqGJtmHxTotPEBJi8cgFBkW2ZBk8mgz+u92kJOkKmk/UJtV/gkXo<br>
        sibLr41W2CJyf6ILPujqZk0RvGxybuW5dp18C2rP9uW3vPhQ4GDrXG3s5i7r/s5hvgWtY8QDXcYVLtZUsx6B/fufK+aaT
        root@domain.hid<br>
        Fingerprint: md5 59:56:33:4a:a7:8f:ba:e6:33:43:2d:d1:3d:a6:83:1e<br>
        Starting Dropbear SSH server: dropbear.<br>
        Starting syslogd/klogd: done<br>
        <br>
        .-------.                                           <br>
        |       |                  .-.                      <br>
        |   |   |-----.-----.-----.| |   .----..-----.-----.<br>
        |       |     | __  |  ---'| '--.|  .-'|     |     |<br>
        |   |   |  |  |     |---  ||  --'|  |  |  '  | | | |<br>
        '---'---'--'--'--.  |-----''----''--'  '-----'-'-'-'<br>
                        -'  |<br>
                        '---'<br>
        <br>
        The Angstrom Distribution beagleboard ttyS2<br>
        <br>
        Angstrom 2010.4-test-20100518 beagleboard ttyS2<br>
        <br>
        beagleboard login: root<br>
        root@domain.hid:~# cat /proc/interrupts<br>
                   CPU0<br>
          7:          2        INTC  TWL4030-PIH<br>
         11:          0        INTC  prcm<br>
         12:       1114        INTC  DMA<br>
         56:        304        INTC  i2c_omap<br>
         61:          0        INTC  i2c_omap<br>
         72:          1        INTC  serial idle<br>
         73:          1        INTC  serial idle<br>
         74:        201        INTC  serial idle, serial<br>
         83:       1976        INTC  mmc0<br>
         92:          1        INTC  musb_hdrc<br>
         93:          0        INTC  musb_hdrc<br>
         95:       3266        INTC  gp timer<br>
        167:          0        GPIO  user<br>
        376:          0     twl4030  twl4030_pwrbutton<br>
        378:          2     twl4030  twl4030_usb<br>
        384:          0     twl4030  mmc0<br>
        Err:          0<br>
        root@domain.hid:~# <br>
      </tt></small><br>
    On 7/21/2010 1:33 PM, Bob Feretich wrote:
    <blockquote cite="mid:4C47597F.1010406@domain.hid" type="cite">
      <meta content="text/html; charset=UTF-8" http-equiv="Content-Type">
      I reverted the patch that you suggested. Spurious interrupts
      crashed the kernel during boot. (console log below)<br>
      <br>
      The only data that I have to go on for the difference between the
      Adeos hang on 2.6.31 and successful boot on 2.6.33 is interrupts
      on IRQ 384, which occur on 2.6.31 but not 2.6.33.<br>
      This change in interrupts is independent of the Adeos patch, so I
      will build a vanilla 2.6.32 kernel and see if the interrupts occur
      there. This may help isolate which kernel change made the
      difference.<br>
      <br>
      Regards,<br>
      Bob Feretich<br>
      <br>
      Boot log with 2.6.31 patch reverted...<br>
      <small><tt>Texas Instruments X-Loader 1.4.2 (Feb 19 2009 -
          12:01:24)<br>
          Reading boot sector<br>
          ... snipped ...<br>
        </tt></small></blockquote>
  </body>
</html>

--------------020106030802090208000600--

