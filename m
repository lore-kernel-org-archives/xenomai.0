Message-ID: <4C4BC6D6.8070806@domain.hid>
Date: Sat, 24 Jul 2010 22:08:38 -0700
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
	<4C478313.2030606@domain.hid>
	<4C48C1BB.8080606@domain.hid> <4C48C2CE.1030706@domain.hid>
	<4C4A292F.5040900@domain.hid>
	<4C4ADFC6.1010900@domain.hid> <4C4B35F1.60103@domain.hid>
	<4C4B379F.9040107@domain.hid>
In-Reply-To: <4C4B379F.9040107@domain.hid>
Content-Type: multipart/alternative;
	boundary="------------060008020109000509000507"
Subject: Re: [Xenomai-help] Adeos patch prevents IRQ 384 (MMC Chip Detect)
 on omap-2.6.33
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

This is a multi-part message in MIME format.
--------------060008020109000509000507
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit

  Test 1 results:
With the Adeos patch installed, but Adeos disabled, the system ran 
normally. IRQ 384s were presented and serviced.  (The SD card removal 
amd insertion was handled correctly.)

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
OMAP3 beagleboard.org # setenv bootargs 'console=ttyS2,115200n8 
ip=192.168.1.81:192.168.1.80:192.168.1.1:255.25
5.255.0:beagleboard:eth0:off root=/dev/nfs rw 
nfsroot=192.168.1.80:/home/Bob/NFSROOT,nolock,rsize=1024,wsize=10
24 rootwait'
OMAP3 beagleboard.org # boot
mmc1 is available
reading uImage

1902408 bytes read
## Booting kernel from Legacy Image at 80300000 ...
    Image Name:   Angstrom/2.6.33/beagleboard
    Image Type:   ARM Linux Kernel Image (uncompressed)
    Data Size:    1902344 Bytes =  1.8 MB
    Load Address: 80008000
    Entry Point:  80008000
    Verifying Checksum ... OK
    Loading Kernel Image ... OK
OK

Starting kernel ...

Uncompressing Linux... done, booting the kernel.
Linux version 2.6.33 (Bob@domain.hid) (gcc version 4.3.3 (GCC) ) #2 
Sat Jul 24 16:32:00 PDT 2010
CPU: ARMv7 Processor [411fc083] revision 3 (ARMv7), cr=10c53c7f
CPU: VIPT nonaliasing data cache, VIPT nonaliasing instruction cache
Machine: OMAP3 Beagle Board
Memory policy: ECC disabled, Data cache writeback
OMAP3430/3530 ES3.0 (l2cache iva sgx neon isp )
SRAM: Mapped pa 0x40200000 to va 0xfe400000 size: 0x100000
Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 65024
Kernel command line: console=ttyS2,115200n8 
ip=192.168.1.81:192.168.1.80:192.168.1.1:255.255.255.0:beagleboard:
eth0:off root=/dev/nfs rw 
nfsroot=192.168.1.80:/home/Bob/NFSROOT,nolock,rsize=1024,wsize=1024 rootwait
PID hash table entries: 1024 (order: 0, 4096 bytes)
Dentry cache hash table entries: 32768 (order: 5, 131072 bytes)
Inode-cache hash table entries: 16384 (order: 4, 65536 bytes)
Memory: 128MB 128MB = 256MB total
Memory: 255872KB available (3292K code, 286K data, 120K init, 0K highmem)
Hierarchical RCU implementation.
RCU-based detection of stalled CPUs is enabled.
NR_IRQS:402
Clocking rate (Crystal/Core/MPU): 26.0/332/500 MHz
Reprogramming SDRC clock to 332000000 Hz
GPMC revision 5.0
IRQ: Found an INTC at 0xfa200000 (revision 4.0) with 96 interrupts
Total of 96 interrupts on 1 active controller
OMAP GPIO hardware version 2.5
OMAP clockevent source: GPTIMER1 at 13000000 Hz
Console: colour dummy device 80x30
Calibrating delay loop... 498.07 BogoMIPS (lpj=2490368)
Mount-cache hash table entries: 512
CPU: Testing write buffer coherency: ok
devtmpfs: initialized
regulator: core version 0.5
NET: Registered protocol family 16
Found NAND on CS0
Registering NAND on CS0
OMAP DMA hardware revision 4.0
bio: create slab <bio-0> at 0
SCSI subsystem initialized
usbcore: registered new interface driver usbfs
usbcore: registered new interface driver hub
usbcore: registered new device driver usb
i2c_omap i2c_omap.1: bus 1 rev3.12 at 2600 kHz
twl4030: PIH (irq 7) chaining IRQs 368..375
twl4030: power (irq 373) chaining IRQs 376..383
twl4030: gpio (irq 368) chaining IRQs 384..401
regulator: VUSB1V5: 1500 mV normal standby
regulator: VUSB1V8: 1800 mV normal standby
regulator: VUSB3V1: 3100 mV normal standby
twl4030_usb twl4030_usb: Initialized TWL4030 USB module
regulator: VMMC1: 1850 <--> 3150 mV at 3000 mV normal standby
regulator: VDAC: 1800 mV normal standby
regulator: VDVI: 1800 mV normal standby
regulator: VSIM: 1800 <--> 3000 mV at 1800 mV normal standby
i2c_omap i2c_omap.3: bus 3 rev3.12 at 100 kHz
Switching to clocksource gp timer
musb_hdrc: version 6.0, musb-dma, otg (peripheral+host), debug=0
musb_hdrc: USB OTG mode controller at fa0ab000 using DMA, IRQ 92
NET: Registered protocol family 2
IP route cache hash table entries: 2048 (order: 1, 8192 bytes)
TCP established hash table entries: 8192 (order: 4, 65536 bytes)
TCP bind hash table entries: 8192 (order: 3, 32768 bytes)
TCP: Hash tables configured (established 8192 bind 8192)
TCP reno registered
UDP hash table entries: 256 (order: 0, 4096 bytes)
UDP-Lite hash table entries: 256 (order: 0, 4096 bytes)
NET: Registered protocol family 1
RPC: Registered udp transport module.
RPC: Registered tcp transport module.
RPC: Registered tcp NFSv4.1 backchannel transport module.
VFS: Disk quotas dquot_6.5.2
Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)
JFFS2 version 2.2. (NAND) ï¿½Â© 2001-2006 Red Hat, Inc.
msgmni has been set to 500
alg: No test for stdrng (krng)
Block layer SCSI generic (bsg) driver version 0.4 loaded (major 253)
io scheduler noop registered
io scheduler deadline registered
io scheduler cfq registered (default)
Serial: 8250/16550 driver, 4 ports, IRQ sharing enabled
serial8250.0: ttyS0 at MMIO 0x4806a000 (irq = 72) is a ST16654
serial8250.1: ttyS1 at MMIO 0x4806c000 (irq = 73) is a ST16654
serial8250.2: ttyS2 at MMIO 0x49020000 (irq = 74) is a ST16654
console [ttyS2] enabled
brd: module loaded
loop: module loaded
usbcore: registered new interface driver asix
usbcore: registered new interface driver cdc_ether
usbcore: registered new interface driver net1080
usbcore: registered new interface driver cdc_subset
usbcore: registered new interface driver zaurus
usbmon: debugfs is not available
ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
ehci-omap ehci-omap.0: OMAP-EHCI Host Controller
ehci-omap ehci-omap.0: new USB bus registered, assigned bus number 1
ehci-omap ehci-omap.0: irq 77, io mem 0x48064800
ehci-omap ehci-omap.0: USB 2.0 started, EHCI 1.00
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 3 ports detected
twl_rtc twl_rtc: rtc core: registered twl_rtc as rtc0
twl_rtc twl_rtc: Power up reset detected.
twl_rtc twl_rtc: Enabling TWL-RTC.
i2c /dev entries driver
TCP cubic registered
NET: Registered protocol family 17
NET: Registered protocol family 15
Power Management for TI OMAP3.
VFP support v0.3: implementor 41 architecture 3 part 30 variant c rev 1
regulator_init_complete: incomplete constraints, leaving VDVI on
regulator_init_complete: incomplete constraints, leaving VDAC on
twl_rtc twl_rtc: setting system clock to 2000-01-01 00:00:00 UTC (946684800)
usb 1-2: new high speed USB device using ehci-omap and address 2
mmc0: new high speed SDHC card at address 1234
mmcblk0: mmc0:1234 SA04G 3.68 GiB
  mmcblk0: p1 p2
eth0: register 'asix' at usb-ehci-omap.0-2, ASIX AX88772 USB 2.0 
Ethernet, 00:50:b6:05:d2:0c
eth0: link down
eth0: link up, 100Mbps, half-duplex, lpa 0x40A1
IP-Config: Complete:
      device=eth0, addr=192.168.1.81, mask=255.255.255.0, gw=192.168.1.1,
      host=beagleboard, domain=, nis-domain=(none),
      bootserver=192.168.1.80, rootserver=192.168.1.80, rootpath=
Looking up port of RPC 100003/2 on 192.168.1.80
Looking up port of RPC 100005/1 on 192.168.1.80
VFS: Mounted root (nfs filesystem) on device 0:13.
devtmpfs: mounted
Freeing init memory: 120K
INIT: version 2.86 booting
Please wait: booting...
Starting udev
EXT2-fs (mmcblk0p2): warning: mounting ext3 filesystem as ext2
Remounting root file system...
Caching udev devnodes
Populating dev cache
root: mount: mounting rootfs on / failed: No such file or directory
NOT configuring network interfaces: / is an NFS mount
Tue May 18 20:58:00 UTC 2010
Starting to configure packages...
Nothing to be done
Finished to configure packages.
INIT: Entering runlevel: 5
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
root@domain.hid:~# /proc/interrupts
-sh: /proc/interrupts: Permission denied
root@domain.hid:~# cat /proc/interrupts
            CPU0
   7:          0        INTC  TWL4030-PIH
  11:          0        INTC  prcm
  12:        198        INTC  DMA
  37:       2267        INTC  gp timer
  56:        318        INTC  i2c_omap
  61:          0        INTC  i2c_omap
  72:          1        INTC  serial idle
  73:          1        INTC  serial idle
  74:        177        INTC  serial idle, serial
  77:      11313        INTC  ehci_hcd:usb1
  83:        126        INTC  mmc0
  92:          0        INTC  musb_hdrc
  93:          0        INTC  musb_hdrc
378:          0     twl4030  twl4030_usb
379:          0     twl4030  rtc0
384:          0     twl4030  mmc0
Err:          0
root@domain.hid:~# df
Filesystem           1K-blocks      Used Available Use% Mounted on
/dev/root             15868228   8775884   6931324  56% /
devtmpfs                128088       132    127956   0% /dev
none                    128088       132    127956   0% /dev
/dev/mmcblk0p1          197676      2075    195602   1% /media/mmcblk0p1
/dev/mmcblk0p2         3605300     72764   3349396   2% /media/mmcblk0p2
tmpfs                   128088        16    128072   0% /var/volatile
tmpfs                   128088         0    128088   0% /dev/shm
tmpfs                   128088         0    128088   0% /media/ram
root@domain.hid:~# umount /dev/mmcblk0p1
root@domain.hid:~# umount /dev/mmcblk0p2
root@domain.hid:~# df
Filesystem           1K-blocks      Used Available Use% Mounted on
/dev/root             15868228   8775884   6931324  56% /
devtmpfs                128088       132    127956   0% /dev
none                    128088       132    127956   0% /dev
tmpfs                   128088        16    128072   0% /var/volatile
tmpfs                   128088         0    128088   0% /dev/shm
tmpfs                   128088         0    128088   0% /media/ram

***** removed SD card   **************************************************

root@domain.hid:~# mmc0: card 1234 removed
root@domain.hid:~# cat /proc/interrupts
            CPU0
   7:          1        INTC  TWL4030-PIH
  11:          0        INTC  prcm
  12:        537        INTC  DMA
  37:       3789        INTC  gp timer
  56:        338        INTC  i2c_omap
  61:          0        INTC  i2c_omap
  72:          1        INTC  serial idle
  73:          1        INTC  serial idle
  74:        311        INTC  serial idle, serial
  77:      13030        INTC  ehci_hcd:usb1
  83:        192        INTC  mmc0
  92:          0        INTC  musb_hdrc
  93:          0        INTC  musb_hdrc
378:          0     twl4030  twl4030_usb
379:          0     twl4030  rtc0
384:          1     twl4030  mmc0
Err:          0

*************** inserted SD card  ***********************

root@domain.hid:~# mmc0: new high speed SDHC card at address 1234
mmcblk0: mmc0:1234 SA04G 3.68 GiB
  mmcblk0: p1 p2
EXT2-fs (mmcblk0p2): warning: mounting ext3 filesystem as ext2

root@domain.hid:~# cat /proc/interrupts
            CPU0
   7:          2        INTC  TWL4030-PIH
  11:          0        INTC  prcm
  12:        684        INTC  DMA
  37:       4292        INTC  gp timer
  56:        366        INTC  i2c_omap
  61:          0        INTC  i2c_omap
  72:          1        INTC  serial idle
  73:          1        INTC  serial idle
  74:        391        INTC  serial idle, serial
  77:      14060        INTC  ehci_hcd:usb1
  83:        312        INTC  mmc0
  92:          0        INTC  musb_hdrc
  93:          0        INTC  musb_hdrc
378:          0     twl4030  twl4030_usb
379:          0     twl4030  rtc0
384:          2     twl4030  mmc0
Err:          0
root@domain.hid:~# df
Filesystem           1K-blocks      Used Available Use% Mounted on
/dev/root             15868228   8775884   6931324  56% /
devtmpfs                128088       132    127956   0% /dev
none                    128088       132    127956   0% /dev
tmpfs                   128088        16    128072   0% /var/volatile
tmpfs                   128088         0    128088   0% /dev/shm
tmpfs                   128088         0    128088   0% /media/ram
/dev/mmcblk0p1          197676      2075    195602   1% /media/mmcblk0p1
/dev/mmcblk0p2         3605300     72764   3349396   2% /media/mmcblk0p2
root@domain.hid:~#

Test 2 results:
With the Adeos patch installed,  Adeos enabled, Xenomai disabled, the 
spurious irpt patch reverted....
The system ran normally, until an IRQ 384 occurred. Then continuous 
spurious interrupts occurred.
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

1942588 bytes read
## Booting kernel from Legacy Image at 80300000 ...
    Image Name:   Angstrom/2.6.33/beagleboard
    Image Type:   ARM Linux Kernel Image (uncompressed)
    Data Size:    1942524 Bytes =  1.9 MB
    Load Address: 80008000
    Entry Point:  80008000
    Verifying Checksum ... OK
    Loading Kernel Image ... OK
OK

Starting kernel ...

Uncompressing Linux... done, booting the kernel.
Linux version 2.6.33 (Bob@domain.hid) (gcc version 4.3.3 (GCC) ) #3 
Sat Jul 24 19:40:30 PDT 2010
CPU: ARMv7 Processor [411fc083] revision 3 (ARMv7), cr=10c53c7f
CPU: VIPT nonaliasing data cache, VIPT nonaliasing instruction cache
Machine: OMAP3 Beagle Board
Memory policy: ECC disabled, Data cache writeback
OMAP3430/3530 ES3.0 (l2cache iva sgx neon isp )
SRAM: Mapped pa 0x40200000 to va 0xfe400000 size: 0x100000
Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 65024
Kernel command line: console=ttyS2,115200n8 
ip=192.168.1.81:192.168.1.80:192.168.1.1:255.255.255.0:beagleboard:
eth0:off root=/dev/nfs rw 
nfsroot=192.168.1.80:/home/Bob/NFSROOT,nolock,rsize=1024,wsize=1024 rootwait
PID hash table entries: 1024 (order: 0, 4096 bytes)
Dentry cache hash table entries: 32768 (order: 5, 131072 bytes)
Inode-cache hash table entries: 16384 (order: 4, 65536 bytes)
Memory: 128MB 128MB = 256MB total
Memory: 255744KB available (3360K code, 341K data, 132K init, 0K highmem)
Hierarchical RCU implementation.
RCU-based detection of stalled CPUs is enabled.
NR_IRQS:402
Clocking rate (Crystal/Core/MPU): 26.0/332/500 MHz
Reprogramming SDRC clock to 332000000 Hz
GPMC revision 5.0
IRQ: Found an INTC at 0xfa200000 (revision 4.0) with 96 interrupts
Total of 96 interrupts on 1 active controller
OMAP GPIO hardware version 2.5
OMAP clockevent source: GPTIMER1 at 13000000 Hz
I-pipe 1.16-01: pipeline enabled.
Console: colour dummy device 80x30
Calibrating delay loop... 498.07 BogoMIPS (lpj=2490368)
Mount-cache hash table entries: 512
CPU: Testing write buffer coherency: ok
devtmpfs: initialized
regulator: core version 0.5
NET: Registered protocol family 16
Found NAND on CS0
Registering NAND on CS0
OMAP DMA hardware revision 4.0
bio: create slab <bio-0> at 0
SCSI subsystem initialized
usbcore: registered new interface driver usbfs
usbcore: registered new interface driver hub
usbcore: registered new device driver usb
i2c_omap i2c_omap.1: bus 1 rev3.12 at 2600 kHz
twl4030: PIH (irq 7) chaining IRQs 368..375
twl4030: power (irq 373) chaining IRQs 376..383
twl4030: gpio (irq 368) chaining IRQs 384..401
regulator: VUSB1V5: 1500 mV normal standby
regulator: VUSB1V8: 1800 mV normal standby
regulator: VUSB3V1: 3100 mV normal standby
twl4030_usb twl4030_usb: Initialized TWL4030 USB module
regulator: VMMC1: 1850 <--> 3150 mV at 3000 mV normal standby
regulator: VDAC: 1800 mV normal standby
regulator: VDVI: 1800 mV normal standby
regulator: VSIM: 1800 <--> 3000 mV at 1800 mV normal standby
i2c_omap i2c_omap.3: bus 3 rev3.12 at 100 kHz
Switching to clocksource gp timer
musb_hdrc: version 6.0, musb-dma, otg (peripheral+host), debug=0
musb_hdrc: USB OTG mode controller at fa0ab000 using DMA, IRQ 92
NET: Registered protocol family 2
IP route cache hash table entries: 2048 (order: 1, 8192 bytes)
TCP established hash table entries: 8192 (order: 4, 65536 bytes)
TCP bind hash table entries: 8192 (order: 3, 32768 bytes)
TCP: Hash tables configured (established 8192 bind 8192)
TCP reno registered
UDP hash table entries: 256 (order: 0, 4096 bytes)
UDP-Lite hash table entries: 256 (order: 0, 4096 bytes)
NET: Registered protocol family 1
RPC: Registered udp transport module.
RPC: Registered tcp transport module.
RPC: Registered tcp NFSv4.1 backchannel transport module.
VFS: Disk quotas dquot_6.5.2
Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)
JFFS2 version 2.2. (NAND) ï¿½Â© 2001-2006 Red Hat, Inc.
msgmni has been set to 499
alg: No test for stdrng (krng)
Block layer SCSI generic (bsg) driver version 0.4 loaded (major 253)
io scheduler noop registered
io scheduler deadline registered
io scheduler cfq registered (default)
Serial: 8250/16550 driver, 4 ports, IRQ sharing enabled
serial8250.0: ttyS0 at MMIO 0x4806a000 (irq = 72) is a ST16654
serial8250.1: ttyS1 at MMIO 0x4806c000 (irq = 73) is a ST16654
serial8250.2: ttyS2 at MMIO 0x49020000 (irq = 74) is a ST16654
console [ttyS2] enabled
brd: module loaded
loop: module loaded
usbcore: registered new interface driver asix
usbcore: registered new interface driver cdc_ether
usbcore: registered new interface driver net1080
usbcore: registered new interface driver cdc_subset
usbcore: registered new interface driver zaurus
usbmon: debugfs is not available
ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
ehci-omap ehci-omap.0: OMAP-EHCI Host Controller
ehci-omap ehci-omap.0: new USB bus registered, assigned bus number 1
ehci-omap ehci-omap.0: irq 77, io mem 0x48064800
ehci-omap ehci-omap.0: USB 2.0 started, EHCI 1.00
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 3 ports detected
twl_rtc twl_rtc: rtc core: registered twl_rtc as rtc0
twl_rtc twl_rtc: Power up reset detected.
twl_rtc twl_rtc: Enabling TWL-RTC.
i2c /dev entries driver
TCP cubic registered
NET: Registered protocol family 17
NET: Registered protocol family 15
Power Management for TI OMAP3.
VFP support v0.3: implementor 41 architecture 3 part 30 variant c rev 1
regulator_init_complete: incomplete constraints, leaving VDVI on
regulator_init_complete: incomplete constraints, leaving VDAC on
twl_rtc twl_rtc: setting system clock to 2000-01-01 00:00:00 UTC (946684800)
usb 1-2: new high speed USB device using ehci-omap and address 2
mmc0: new high speed SDHC card at address 1234
mmcblk0: mmc0:1234 SA04G 3.68 GiB
  mmcblk0: p1 p2
eth0: register 'asix' at usb-ehci-omap.0-2, ASIX AX88772 USB 2.0 
Ethernet, 00:50:b6:05:d2:0c
eth0: link down
eth0: link up, 100Mbps, half-duplex, lpa 0x40A1
IP-Config: Complete:
      device=eth0, addr=192.168.1.81, mask=255.255.255.0, gw=192.168.1.1,
      host=beagleboard, domain=, nis-domain=(none),
      bootserver=192.168.1.80, rootserver=192.168.1.80, rootpath=
Looking up port of RPC 100003/2 on 192.168.1.80
Looking up port of RPC 100005/1 on 192.168.1.80
VFS: Mounted root (nfs filesystem) on device 0:13.
devtmpfs: mounted
Freeing init memory: 132K
INIT: version 2.86 booting
Please wait: booting...
Starting udev
udev: starting version 151

udevadm settle - timeout of 3 seconds reached, the event queue contains:
   /sys/devices/platform/ehci-omap.0/usb1/1-2/1-2:1.0/net/eth0 (326)
   
/sys/devices/platform/mmci-omap-hs.0/mmc_host/mmc0/mmc0:1234/block/mmcblk0 
(347)
   
/sys/devices/platform/mmci-omap-hs.0/mmc_host/mmc0/mmc0:1234/block/mmcblk0/mmcblk0p1 
(348)
   
/sys/devices/platform/mmci-omap-hs.0/mmc_host/mmc0/mmc0:1234/block/mmcblk0/mmcblk0p2 
(349)
Remounting root file system...
Caching udev devnodes
Populating dev cachemv: cannot rename '/tmp/uname': No such file or 
directory
EXT2-fs (mmcblk0p2): warning: mounting ext3 filesystem as ext2
root: mount: mounting rootfs on / failed: No such file or directory
NOT configuring network interfaces: / is an NFS mount
Tue May 18 20:58:00 UTC 2010
Starting to configure packages...
Nothing to be done
Finished to configure packages.
INIT: Entering runlevel: 5
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
   7:          0        INTC  TWL4030-PIH
  11:          0        INTC  prcm
  12:        517        INTC  DMA
  37:       1062        INTC  gp timer
  56:        318        INTC  i2c_omap
  61:          0        INTC  i2c_omap
  72:          1        INTC  serial idle
  73:          1        INTC  serial idle
  74:        117        INTC  serial idle, serial
  77:      12033        INTC  ehci_hcd:usb1
  83:        171        INTC  mmc0
  92:          0        INTC  musb_hdrc
  93:          0        INTC  musb_hdrc
378:          0     twl4030  twl4030_usb
379:          0     twl4030  rtc0
384:          0     twl4030  mmc0
Err:          0
root@domain.hid:~# df
Filesystem           1K-blocks      Used Available Use% Mounted on
/dev/root             15868228   8775276   6931932  56% /
devtmpfs                128024       128    127896   0% /dev
none                    128024       128    127896   0% /dev
/dev/mmcblk0p1          197676      2114    195562   1% /media/mmcblk0p1
tmpfs                   128024        16    128008   0% /var/volatile
tmpfs                   128024         0    128024   0% /dev/shm
tmpfs                   128024         0    128024   0% /media/ram
/dev/mmcblk0p2         3605300     72764   3349396   2% /media/mmcblk0p2
root@domain.hid:~# umount /dev/mmcblk0p1
root@domain.hid:~# umount /dev/mmcblk0p2
root@domain.hid:~#
root@domain.hid:~# *********    # remove sd card ####   
***********************
root@domain.hid:~#
root@domain.hid:~# cat /proc/interrupts
            CPU0
   7:      32919        INTC  TWL4030-PIH
  11:          0        INTC  prcm
  12:        835        INTC  DMA
  37:       1703        INTC  gp timer
  56:      99075        INTC  i2c_omap
  61:          0        INTC  i2c_omap
  72:          1        INTC  serial idle
  73:          1        INTC  serial idle
  74:        252        INTC  serial idle, serial
  77:      12455        INTC  ehci_hcd:usb1
  83:        233        INTC  mmc0
  92:          0        INTC  musb_hdrc
  93:          0        INTC  musb_hdrc
378:          0     twl4030  twl4030_usb
379:          0     twl4030  rtc0
384:          0     twl4030  mmc0
Err:          0
root@domain.hid:~# cat /proc/interrupts
            CPU0
   7:      61279        INTC  TWL4030-PIH
  11:          0        INTC  prcm
  12:        835        INTC  DMA
  37:       1989        INTC  gp timer
  56:     184159        INTC  i2c_omap
  61:          0        INTC  i2c_omap
  72:          1        INTC  serial idle
  73:          1        INTC  serial idle
  74:        279        INTC  serial idle, serial
  77:      12507        INTC  ehci_hcd:usb1
  83:        233        INTC  mmc0
  92:          0        INTC  musb_hdrc
  93:          0        INTC  musb_hdrc
378:          0     twl4030  twl4030_usb
379:          0     twl4030  rtc0
384:          0     twl4030  mmc0
Err:          0
root@domain.hid irq 95: 0xffffffdf, please flush posted write 
for irq 56
Spurious irq 95: 0xffffffdf, please flush posted write for irq 56
Spurious irq 95: 0xffffffdf, please flush posted write for irq 56
Spurious irq 95: 0xffffffdf, please flush posted write for irq 56
Spurious irq 95: 0xffffffdf, please flush posted write for irq 56
Spurious irq 95: 0xffffffdf, please flush posted write for irq 56
Spurious irq 95: 0xffffffdf, please flush posted write for irq 56
... snipped ... About 1023 spurious irpt msgs occurred.

The beginning of the spurious irpt messages was not consistent. They 
usually started occuring soon, but not immediately after the SD card was 
removed. As you can see above, I was able to enter a couple commands 
before the interrupts began. Sometimes the messages occurred before the 
removal of the SD card. I think that any kind of i2c probed level 2 
interrupt triggers the problem.

I was fast enough to display /proc/interrupts after I pulled out the SD 
card (above) and befre the spurrious irpts occurred. The IRQ 384 irpt is 
not shown  in /proc/interrupts and no "removed" message occurred. 
Without the Adeos patch (or with CONFIG_IPIPE disabled), the removel 
mesage was immediate.

Regards,
Bob Feretich











On 7/24/2010 11:57 AM, Gilles Chanteperdrix wrote:
> Bob Feretich wrote:
>>    Let me make sure I understand.
>> The most recent report from me contained console logs of two boots.
>> The first was 2.6.33 with no Adeos patch applied.
>> The second was 2.6.33 with the Adeos patch and Xenomai enabled
>> (CONFIG_IPIPE=y) and CONFIG_XENOMAI=y).
>>
>> You want me to perform to tests:
>>
>>     1. 2.6.33 with the Adeos patch applied, but .config edited to turn
>>        off CONFIG_IPIPE and CONFIG_XENOMAI.
> That is, if when you tested the kernel patched with Adeos you never
> turned CONFIG_IPIPE off.
>
>>     2. Assuming test #1 passes the interrupts successfully, 2.6.33 with
>>        the Adeos patch applied, CONFIG_IPIPE=y, CONFIG_XENOMAI off, and
>>        revert the change to drivers/i2c/busses/i2c-omap.c.
>>
>> Is that correct?
> Yep.
>
>

--------------060008020109000509000507
Content-Type: text/html; charset="utf-8"
Content-Transfer-Encoding: 8bit

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <meta content="text/html; charset=UTF-8" http-equiv="Content-Type">
  </head>
  <body bgcolor="#ffffff" text="#000000">
    Test 1 results:<br>
    With the Adeos patch installed, but Adeos disabled, the system ran
    normally. IRQ 384s were presented and serviced.  (The SD card
    removal amd insertion was handled correctly.)<br>
    <br>
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
        OMAP3 beagleboard.org # setenv bootargs 'console=ttyS2,115200n8
        ip=192.168.1.81:192.168.1.80:192.168.1.1:255.25<br>
        5.255.0:beagleboard:eth0:off root=/dev/nfs rw
        nfsroot=192.168.1.80:/home/Bob/NFSROOT,nolock,rsize=1024,wsize=10<br>
        24 rootwait'<br>
        OMAP3 beagleboard.org # boot<br>
        mmc1 is available<br>
        reading uImage<br>
        <br>
        1902408 bytes read<br>
        ## Booting kernel from Legacy Image at 80300000 ...<br>
           Image Name:   Angstrom/2.6.33/beagleboard<br>
           Image Type:   ARM Linux Kernel Image (uncompressed)<br>
           Data Size:    1902344 Bytes =  1.8 MB<br>
           Load Address: 80008000<br>
           Entry Point:  80008000<br>
           Verifying Checksum ... OK<br>
           Loading Kernel Image ... OK<br>
        OK<br>
        <br>
        Starting kernel ...<br>
        <br>
        Uncompressing Linux... done, booting the kernel.<br>
        Linux version 2.6.33 (<a class="moz-txt-link-abbreviated" href="mailto:Bob@domain.hid">Bob@domain.hid</a>) (gcc version 4.3.3 (GCC)
        ) #2 Sat Jul 24 16:32:00 PDT 2010<br>
        CPU: ARMv7 Processor [411fc083] revision 3 (ARMv7), cr=10c53c7f<br>
        CPU: VIPT nonaliasing data cache, VIPT nonaliasing instruction
        cache<br>
        Machine: OMAP3 Beagle Board<br>
        Memory policy: ECC disabled, Data cache writeback<br>
        OMAP3430/3530 ES3.0 (l2cache iva sgx neon isp )<br>
        SRAM: Mapped pa 0x40200000 to va 0xfe400000 size: 0x100000<br>
        Built 1 zonelists in Zone order, mobility grouping on.  Total
        pages: 65024<br>
        Kernel command line: console=ttyS2,115200n8
        ip=192.168.1.81:192.168.1.80:192.168.1.1:255.255.255.0:beagleboard:<br>
        eth0:off root=/dev/nfs rw
        nfsroot=192.168.1.80:/home/Bob/NFSROOT,nolock,rsize=1024,wsize=1024
        rootwait<br>
        PID hash table entries: 1024 (order: 0, 4096 bytes)<br>
        Dentry cache hash table entries: 32768 (order: 5, 131072 bytes)<br>
        Inode-cache hash table entries: 16384 (order: 4, 65536 bytes)<br>
        Memory: 128MB 128MB = 256MB total<br>
        Memory: 255872KB available (3292K code, 286K data, 120K init, 0K
        highmem)<br>
        Hierarchical RCU implementation.<br>
        RCU-based detection of stalled CPUs is enabled.<br>
        NR_IRQS:402<br>
        Clocking rate (Crystal/Core/MPU): 26.0/332/500 MHz<br>
        Reprogramming SDRC clock to 332000000 Hz<br>
        GPMC revision 5.0<br>
        IRQ: Found an INTC at 0xfa200000 (revision 4.0) with 96
        interrupts<br>
        Total of 96 interrupts on 1 active controller<br>
        OMAP GPIO hardware version 2.5<br>
        OMAP clockevent source: GPTIMER1 at 13000000 Hz<br>
        Console: colour dummy device 80x30<br>
        Calibrating delay loop... 498.07 BogoMIPS (lpj=2490368)<br>
        Mount-cache hash table entries: 512<br>
        CPU: Testing write buffer coherency: ok<br>
        devtmpfs: initialized<br>
        regulator: core version 0.5<br>
        NET: Registered protocol family 16<br>
        Found NAND on CS0<br>
        Registering NAND on CS0<br>
        OMAP DMA hardware revision 4.0<br>
        bio: create slab &lt;bio-0&gt; at 0<br>
        SCSI subsystem initialized<br>
        usbcore: registered new interface driver usbfs<br>
        usbcore: registered new interface driver hub<br>
        usbcore: registered new device driver usb<br>
        i2c_omap i2c_omap.1: bus 1 rev3.12 at 2600 kHz<br>
        twl4030: PIH (irq 7) chaining IRQs 368..375<br>
        twl4030: power (irq 373) chaining IRQs 376..383<br>
        twl4030: gpio (irq 368) chaining IRQs 384..401<br>
        regulator: VUSB1V5: 1500 mV normal standby<br>
        regulator: VUSB1V8: 1800 mV normal standby<br>
        regulator: VUSB3V1: 3100 mV normal standby<br>
        twl4030_usb twl4030_usb: Initialized TWL4030 USB module<br>
        regulator: VMMC1: 1850 &lt;--&gt; 3150 mV at 3000 mV normal
        standby<br>
        regulator: VDAC: 1800 mV normal standby<br>
        regulator: VDVI: 1800 mV normal standby<br>
        regulator: VSIM: 1800 &lt;--&gt; 3000 mV at 1800 mV normal
        standby<br>
        i2c_omap i2c_omap.3: bus 3 rev3.12 at 100 kHz<br>
        Switching to clocksource gp timer<br>
        musb_hdrc: version 6.0, musb-dma, otg (peripheral+host), debug=0<br>
        musb_hdrc: USB OTG mode controller at fa0ab000 using DMA, IRQ 92<br>
        NET: Registered protocol family 2<br>
        IP route cache hash table entries: 2048 (order: 1, 8192 bytes)<br>
        TCP established hash table entries: 8192 (order: 4, 65536 bytes)<br>
        TCP bind hash table entries: 8192 (order: 3, 32768 bytes)<br>
        TCP: Hash tables configured (established 8192 bind 8192)<br>
        TCP reno registered<br>
        UDP hash table entries: 256 (order: 0, 4096 bytes)<br>
        UDP-Lite hash table entries: 256 (order: 0, 4096 bytes)<br>
        NET: Registered protocol family 1<br>
        RPC: Registered udp transport module.<br>
        RPC: Registered tcp transport module.<br>
        RPC: Registered tcp NFSv4.1 backchannel transport module.<br>
        VFS: Disk quotas dquot_6.5.2<br>
        Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)<br>
        JFFS2 version 2.2. (NAND) ï¿½Â© 2001-2006 Red Hat, Inc.<br>
        msgmni has been set to 500<br>
        alg: No test for stdrng (krng)<br>
        Block layer SCSI generic (bsg) driver version 0.4 loaded (major
        253)<br>
        io scheduler noop registered<br>
        io scheduler deadline registered<br>
        io scheduler cfq registered (default)<br>
        Serial: 8250/16550 driver, 4 ports, IRQ sharing enabled<br>
        serial8250.0: ttyS0 at MMIO 0x4806a000 (irq = 72) is a ST16654<br>
        serial8250.1: ttyS1 at MMIO 0x4806c000 (irq = 73) is a ST16654<br>
        serial8250.2: ttyS2 at MMIO 0x49020000 (irq = 74) is a ST16654<br>
        console [ttyS2] enabled<br>
        brd: module loaded<br>
        loop: module loaded<br>
        usbcore: registered new interface driver asix<br>
        usbcore: registered new interface driver cdc_ether<br>
        usbcore: registered new interface driver net1080<br>
        usbcore: registered new interface driver cdc_subset<br>
        usbcore: registered new interface driver zaurus<br>
        usbmon: debugfs is not available<br>
        ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver<br>
        ehci-omap ehci-omap.0: OMAP-EHCI Host Controller<br>
        ehci-omap ehci-omap.0: new USB bus registered, assigned bus
        number 1<br>
        ehci-omap ehci-omap.0: irq 77, io mem 0x48064800<br>
        ehci-omap ehci-omap.0: USB 2.0 started, EHCI 1.00<br>
        hub 1-0:1.0: USB hub found<br>
        hub 1-0:1.0: 3 ports detected<br>
        twl_rtc twl_rtc: rtc core: registered twl_rtc as rtc0<br>
        twl_rtc twl_rtc: Power up reset detected.<br>
        twl_rtc twl_rtc: Enabling TWL-RTC.<br>
        i2c /dev entries driver<br>
        TCP cubic registered<br>
        NET: Registered protocol family 17<br>
        NET: Registered protocol family 15<br>
        Power Management for TI OMAP3.<br>
        VFP support v0.3: implementor 41 architecture 3 part 30 variant
        c rev 1<br>
        regulator_init_complete: incomplete constraints, leaving VDVI on<br>
        regulator_init_complete: incomplete constraints, leaving VDAC on<br>
        twl_rtc twl_rtc: setting system clock to 2000-01-01 00:00:00 UTC
        (946684800)<br>
        usb 1-2: new high speed USB device using ehci-omap and address 2<br>
        mmc0: new high speed SDHC card at address 1234<br>
        mmcblk0: mmc0:1234 SA04G 3.68 GiB <br>
         mmcblk0: p1 p2<br>
        eth0: register 'asix' at usb-ehci-omap.0-2, ASIX AX88772 USB 2.0
        Ethernet, 00:50:b6:05:d2:0c<br>
        eth0: link down<br>
        eth0: link up, 100Mbps, half-duplex, lpa 0x40A1<br>
        IP-Config: Complete:<br>
             device=eth0, addr=192.168.1.81, mask=255.255.255.0,
        gw=192.168.1.1,<br>
             host=beagleboard, domain=, nis-domain=(none),<br>
             bootserver=192.168.1.80, rootserver=192.168.1.80, rootpath=<br>
        Looking up port of RPC 100003/2 on 192.168.1.80<br>
        Looking up port of RPC 100005/1 on 192.168.1.80<br>
        VFS: Mounted root (nfs filesystem) on device 0:13.<br>
        devtmpfs: mounted<br>
        Freeing init memory: 120K<br>
        INIT: version 2.86 booting<br>
        Please wait: booting...<br>
        Starting udev<br>
        EXT2-fs (mmcblk0p2): warning: mounting ext3 filesystem as ext2<br>
        Remounting root file system...<br>
        Caching udev devnodes<br>
        Populating dev cache<br>
        root: mount: mounting rootfs on / failed: No such file or
        directory<br>
        NOT configuring network interfaces: / is an NFS mount<br>
        Tue May 18 20:58:00 UTC 2010<br>
        Starting to configure packages...<br>
        Nothing to be done<br>
        Finished to configure packages.<br>
        INIT: Entering runlevel: 5<br>
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
        root@domain.hid:~# /proc/interrupts<br>
        -sh: /proc/interrupts: Permission denied<br>
        root@domain.hid:~# cat /proc/interrupts<br>
                   CPU0<br>
          7:          0        INTC  TWL4030-PIH<br>
         11:          0        INTC  prcm<br>
         12:        198        INTC  DMA<br>
         37:       2267        INTC  gp timer<br>
         56:        318        INTC  i2c_omap<br>
         61:          0        INTC  i2c_omap<br>
         72:          1        INTC  serial idle<br>
         73:          1        INTC  serial idle<br>
         74:        177        INTC  serial idle, serial<br>
         77:      11313        INTC  ehci_hcd:usb1<br>
         83:        126        INTC  mmc0<br>
         92:          0        INTC  musb_hdrc<br>
         93:          0        INTC  musb_hdrc<br>
        378:          0     twl4030  twl4030_usb<br>
        379:          0     twl4030  rtc0<br>
        384:          0     twl4030  mmc0<br>
        Err:          0<br>
        root@domain.hid:~# df<br>
        Filesystem           1K-blocks      Used Available Use% Mounted
        on<br>
        /dev/root             15868228   8775884   6931324  56% /<br>
        devtmpfs                128088       132    127956   0% /dev<br>
        none                    128088       132    127956   0% /dev<br>
        /dev/mmcblk0p1          197676      2075    195602   1%
        /media/mmcblk0p1<br>
        /dev/mmcblk0p2         3605300     72764   3349396   2%
        /media/mmcblk0p2<br>
        tmpfs                   128088        16    128072   0%
        /var/volatile<br>
        tmpfs                   128088         0    128088   0% /dev/shm<br>
        tmpfs                   128088         0    128088   0%
        /media/ram<br>
        root@domain.hid:~# umount /dev/mmcblk0p1<br>
        root@domain.hid:~# umount /dev/mmcblk0p2<br>
        root@domain.hid:~# df<br>
        Filesystem           1K-blocks      Used Available Use% Mounted
        on<br>
        /dev/root             15868228   8775884   6931324  56% /<br>
        devtmpfs                128088       132    127956   0% /dev<br>
        none                    128088       132    127956   0% /dev<br>
        tmpfs                   128088        16    128072   0%
        /var/volatile<br>
        tmpfs                   128088         0    128088   0% /dev/shm<br>
        tmpfs                   128088         0    128088   0%
        /media/ram<br>
        <br>
        ***** removed SD card  
        **************************************************<br>
        <br>
        root@domain.hid:~# mmc0: card 1234 removed<br>
        root@domain.hid:~# cat /proc/interrupts<br>
                   CPU0<br>
          7:          1        INTC  TWL4030-PIH<br>
         11:          0        INTC  prcm<br>
         12:        537        INTC  DMA<br>
         37:       3789        INTC  gp timer<br>
         56:        338        INTC  i2c_omap<br>
         61:          0        INTC  i2c_omap<br>
         72:          1        INTC  serial idle<br>
         73:          1        INTC  serial idle<br>
         74:        311        INTC  serial idle, serial<br>
         77:      13030        INTC  ehci_hcd:usb1<br>
         83:        192        INTC  mmc0<br>
         92:          0        INTC  musb_hdrc<br>
         93:          0        INTC  musb_hdrc<br>
        378:          0     twl4030  twl4030_usb<br>
        379:          0     twl4030  rtc0<br>
        384:          1     twl4030  mmc0<br>
        Err:          0<br>
        <br>
        *************** inserted SD card  ***********************<br>
        <br>
        root@domain.hid:~# mmc0: new high speed SDHC card at address
        1234<br>
        mmcblk0: mmc0:1234 SA04G 3.68 GiB <br>
         mmcblk0: p1 p2<br>
        EXT2-fs (mmcblk0p2): warning: mounting ext3 filesystem as ext2<br>
        <br>
        root@domain.hid:~# cat /proc/interrupts<br>
                   CPU0<br>
          7:          2        INTC  TWL4030-PIH<br>
         11:          0        INTC  prcm<br>
         12:        684        INTC  DMA<br>
         37:       4292        INTC  gp timer<br>
         56:        366        INTC  i2c_omap<br>
         61:          0        INTC  i2c_omap<br>
         72:          1        INTC  serial idle<br>
         73:          1        INTC  serial idle<br>
         74:        391        INTC  serial idle, serial<br>
         77:      14060        INTC  ehci_hcd:usb1<br>
         83:        312        INTC  mmc0<br>
         92:          0        INTC  musb_hdrc<br>
         93:          0        INTC  musb_hdrc<br>
        378:          0     twl4030  twl4030_usb<br>
        379:          0     twl4030  rtc0<br>
        384:          2     twl4030  mmc0<br>
        Err:          0<br>
        root@domain.hid:~# df<br>
        Filesystem           1K-blocks      Used Available Use% Mounted
        on<br>
        /dev/root             15868228   8775884   6931324  56% /<br>
        devtmpfs                128088       132    127956   0% /dev<br>
        none                    128088       132    127956   0% /dev<br>
        tmpfs                   128088        16    128072   0%
        /var/volatile<br>
        tmpfs                   128088         0    128088   0% /dev/shm<br>
        tmpfs                   128088         0    128088   0%
        /media/ram<br>
        /dev/mmcblk0p1          197676      2075    195602   1%
        /media/mmcblk0p1<br>
        /dev/mmcblk0p2         3605300     72764   3349396   2%
        /media/mmcblk0p2<br>
        root@domain.hid:~#</tt></small><br>
    <br>
    Test 2 results:<br>
    With the Adeos patch installed,  Adeos enabled, Xenomai disabled,
    the spurious irpt patch reverted....<br>
    The system ran normally, until an IRQ 384 occurred. Then continuous
    spurious interrupts occurred.<br>
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
        1942588 bytes read<br>
        ## Booting kernel from Legacy Image at 80300000 ...<br>
           Image Name:   Angstrom/2.6.33/beagleboard<br>
           Image Type:   ARM Linux Kernel Image (uncompressed)<br>
           Data Size:    1942524 Bytes =  1.9 MB<br>
           Load Address: 80008000<br>
           Entry Point:  80008000<br>
           Verifying Checksum ... OK<br>
           Loading Kernel Image ... OK<br>
        OK<br>
        <br>
        Starting kernel ...<br>
        <br>
        Uncompressing Linux... done, booting the kernel.<br>
        Linux version 2.6.33 (<a class="moz-txt-link-abbreviated" href="mailto:Bob@domain.hid">Bob@domain.hid</a>) (gcc version 4.3.3 (GCC)
        ) #3 Sat Jul 24 19:40:30 PDT 2010<br>
        CPU: ARMv7 Processor [411fc083] revision 3 (ARMv7), cr=10c53c7f<br>
        CPU: VIPT nonaliasing data cache, VIPT nonaliasing instruction
        cache<br>
        Machine: OMAP3 Beagle Board<br>
        Memory policy: ECC disabled, Data cache writeback<br>
        OMAP3430/3530 ES3.0 (l2cache iva sgx neon isp )<br>
        SRAM: Mapped pa 0x40200000 to va 0xfe400000 size: 0x100000<br>
        Built 1 zonelists in Zone order, mobility grouping on.  Total
        pages: 65024<br>
        Kernel command line: console=ttyS2,115200n8
        ip=192.168.1.81:192.168.1.80:192.168.1.1:255.255.255.0:beagleboard:<br>
        eth0:off root=/dev/nfs rw
        nfsroot=192.168.1.80:/home/Bob/NFSROOT,nolock,rsize=1024,wsize=1024
        rootwait<br>
        PID hash table entries: 1024 (order: 0, 4096 bytes)<br>
        Dentry cache hash table entries: 32768 (order: 5, 131072 bytes)<br>
        Inode-cache hash table entries: 16384 (order: 4, 65536 bytes)<br>
        Memory: 128MB 128MB = 256MB total<br>
        Memory: 255744KB available (3360K code, 341K data, 132K init, 0K
        highmem)<br>
        Hierarchical RCU implementation.<br>
        RCU-based detection of stalled CPUs is enabled.<br>
        NR_IRQS:402<br>
        Clocking rate (Crystal/Core/MPU): 26.0/332/500 MHz<br>
        Reprogramming SDRC clock to 332000000 Hz<br>
        GPMC revision 5.0<br>
        IRQ: Found an INTC at 0xfa200000 (revision 4.0) with 96
        interrupts<br>
        Total of 96 interrupts on 1 active controller<br>
        OMAP GPIO hardware version 2.5<br>
        OMAP clockevent source: GPTIMER1 at 13000000 Hz<br>
        I-pipe 1.16-01: pipeline enabled.<br>
        Console: colour dummy device 80x30<br>
        Calibrating delay loop... 498.07 BogoMIPS (lpj=2490368)<br>
        Mount-cache hash table entries: 512<br>
        CPU: Testing write buffer coherency: ok<br>
        devtmpfs: initialized<br>
        regulator: core version 0.5<br>
        NET: Registered protocol family 16<br>
        Found NAND on CS0<br>
        Registering NAND on CS0<br>
        OMAP DMA hardware revision 4.0<br>
        bio: create slab &lt;bio-0&gt; at 0<br>
        SCSI subsystem initialized<br>
        usbcore: registered new interface driver usbfs<br>
        usbcore: registered new interface driver hub<br>
        usbcore: registered new device driver usb<br>
        i2c_omap i2c_omap.1: bus 1 rev3.12 at 2600 kHz<br>
        twl4030: PIH (irq 7) chaining IRQs 368..375<br>
        twl4030: power (irq 373) chaining IRQs 376..383<br>
        twl4030: gpio (irq 368) chaining IRQs 384..401<br>
        regulator: VUSB1V5: 1500 mV normal standby<br>
        regulator: VUSB1V8: 1800 mV normal standby<br>
        regulator: VUSB3V1: 3100 mV normal standby<br>
        twl4030_usb twl4030_usb: Initialized TWL4030 USB module<br>
        regulator: VMMC1: 1850 &lt;--&gt; 3150 mV at 3000 mV normal
        standby<br>
        regulator: VDAC: 1800 mV normal standby<br>
        regulator: VDVI: 1800 mV normal standby<br>
        regulator: VSIM: 1800 &lt;--&gt; 3000 mV at 1800 mV normal
        standby<br>
        i2c_omap i2c_omap.3: bus 3 rev3.12 at 100 kHz<br>
        Switching to clocksource gp timer<br>
        musb_hdrc: version 6.0, musb-dma, otg (peripheral+host), debug=0<br>
        musb_hdrc: USB OTG mode controller at fa0ab000 using DMA, IRQ 92<br>
        NET: Registered protocol family 2<br>
        IP route cache hash table entries: 2048 (order: 1, 8192 bytes)<br>
        TCP established hash table entries: 8192 (order: 4, 65536 bytes)<br>
        TCP bind hash table entries: 8192 (order: 3, 32768 bytes)<br>
        TCP: Hash tables configured (established 8192 bind 8192)<br>
        TCP reno registered<br>
        UDP hash table entries: 256 (order: 0, 4096 bytes)<br>
        UDP-Lite hash table entries: 256 (order: 0, 4096 bytes)<br>
        NET: Registered protocol family 1<br>
        RPC: Registered udp transport module.<br>
        RPC: Registered tcp transport module.<br>
        RPC: Registered tcp NFSv4.1 backchannel transport module.<br>
        VFS: Disk quotas dquot_6.5.2<br>
        Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)<br>
        JFFS2 version 2.2. (NAND) ï¿½Â© 2001-2006 Red Hat, Inc.<br>
        msgmni has been set to 499<br>
        alg: No test for stdrng (krng)<br>
        Block layer SCSI generic (bsg) driver version 0.4 loaded (major
        253)<br>
        io scheduler noop registered<br>
        io scheduler deadline registered<br>
        io scheduler cfq registered (default)<br>
        Serial: 8250/16550 driver, 4 ports, IRQ sharing enabled<br>
        serial8250.0: ttyS0 at MMIO 0x4806a000 (irq = 72) is a ST16654<br>
        serial8250.1: ttyS1 at MMIO 0x4806c000 (irq = 73) is a ST16654<br>
        serial8250.2: ttyS2 at MMIO 0x49020000 (irq = 74) is a ST16654<br>
        console [ttyS2] enabled<br>
        brd: module loaded<br>
        loop: module loaded<br>
        usbcore: registered new interface driver asix<br>
        usbcore: registered new interface driver cdc_ether<br>
        usbcore: registered new interface driver net1080<br>
        usbcore: registered new interface driver cdc_subset<br>
        usbcore: registered new interface driver zaurus<br>
        usbmon: debugfs is not available<br>
        ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver<br>
        ehci-omap ehci-omap.0: OMAP-EHCI Host Controller<br>
        ehci-omap ehci-omap.0: new USB bus registered, assigned bus
        number 1<br>
        ehci-omap ehci-omap.0: irq 77, io mem 0x48064800<br>
        ehci-omap ehci-omap.0: USB 2.0 started, EHCI 1.00<br>
        hub 1-0:1.0: USB hub found<br>
        hub 1-0:1.0: 3 ports detected<br>
        twl_rtc twl_rtc: rtc core: registered twl_rtc as rtc0<br>
        twl_rtc twl_rtc: Power up reset detected.<br>
        twl_rtc twl_rtc: Enabling TWL-RTC.<br>
        i2c /dev entries driver<br>
        TCP cubic registered<br>
        NET: Registered protocol family 17<br>
        NET: Registered protocol family 15<br>
        Power Management for TI OMAP3.<br>
        VFP support v0.3: implementor 41 architecture 3 part 30 variant
        c rev 1<br>
        regulator_init_complete: incomplete constraints, leaving VDVI on<br>
        regulator_init_complete: incomplete constraints, leaving VDAC on<br>
        twl_rtc twl_rtc: setting system clock to 2000-01-01 00:00:00 UTC
        (946684800)<br>
        usb 1-2: new high speed USB device using ehci-omap and address 2<br>
        mmc0: new high speed SDHC card at address 1234<br>
        mmcblk0: mmc0:1234 SA04G 3.68 GiB <br>
         mmcblk0: p1 p2<br>
        eth0: register 'asix' at usb-ehci-omap.0-2, ASIX AX88772 USB 2.0
        Ethernet, 00:50:b6:05:d2:0c<br>
        eth0: link down<br>
        eth0: link up, 100Mbps, half-duplex, lpa 0x40A1<br>
        IP-Config: Complete:<br>
             device=eth0, addr=192.168.1.81, mask=255.255.255.0,
        gw=192.168.1.1,<br>
             host=beagleboard, domain=, nis-domain=(none),<br>
             bootserver=192.168.1.80, rootserver=192.168.1.80, rootpath=<br>
        Looking up port of RPC 100003/2 on 192.168.1.80<br>
        Looking up port of RPC 100005/1 on 192.168.1.80<br>
        VFS: Mounted root (nfs filesystem) on device 0:13.<br>
        devtmpfs: mounted<br>
        Freeing init memory: 132K<br>
        INIT: version 2.86 booting<br>
        Please wait: booting...<br>
        Starting udev<br>
        udev: starting version 151<br>
        <br>
        udevadm settle - timeout of 3 seconds reached, the event queue
        contains:<br>
          /sys/devices/platform/ehci-omap.0/usb1/1-2/1-2:1.0/net/eth0
        (326)<br>
         
        /sys/devices/platform/mmci-omap-hs.0/mmc_host/mmc0/mmc0:1234/block/mmcblk0
        (347)<br>
         
        /sys/devices/platform/mmci-omap-hs.0/mmc_host/mmc0/mmc0:1234/block/mmcblk0/mmcblk0p1
        (348)<br>
         
        /sys/devices/platform/mmci-omap-hs.0/mmc_host/mmc0/mmc0:1234/block/mmcblk0/mmcblk0p2
        (349)<br>
        Remounting root file system...<br>
        Caching udev devnodes<br>
        Populating dev cachemv: cannot rename '/tmp/uname': No such file
        or directory<br>
        EXT2-fs (mmcblk0p2): warning: mounting ext3 filesystem as ext2<br>
        root: mount: mounting rootfs on / failed: No such file or
        directory<br>
        NOT configuring network interfaces: / is an NFS mount<br>
        Tue May 18 20:58:00 UTC 2010<br>
        Starting to configure packages...<br>
        Nothing to be done<br>
        Finished to configure packages.<br>
        INIT: Entering runlevel: 5<br>
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
          7:          0        INTC  TWL4030-PIH<br>
         11:          0        INTC  prcm<br>
         12:        517        INTC  DMA<br>
         37:       1062        INTC  gp timer<br>
         56:        318        INTC  i2c_omap<br>
         61:          0        INTC  i2c_omap<br>
         72:          1        INTC  serial idle<br>
         73:          1        INTC  serial idle<br>
         74:        117        INTC  serial idle, serial<br>
         77:      12033        INTC  ehci_hcd:usb1<br>
         83:        171        INTC  mmc0<br>
         92:          0        INTC  musb_hdrc<br>
         93:          0        INTC  musb_hdrc<br>
        378:          0     twl4030  twl4030_usb<br>
        379:          0     twl4030  rtc0<br>
        384:          0     twl4030  mmc0<br>
        Err:          0<br>
        root@domain.hid:~# df<br>
        Filesystem           1K-blocks      Used Available Use% Mounted
        on<br>
        /dev/root             15868228   8775276   6931932  56% /<br>
        devtmpfs                128024       128    127896   0% /dev<br>
        none                    128024       128    127896   0% /dev<br>
        /dev/mmcblk0p1          197676      2114    195562   1%
        /media/mmcblk0p1<br>
        tmpfs                   128024        16    128008   0%
        /var/volatile<br>
        tmpfs                   128024         0    128024   0% /dev/shm<br>
        tmpfs                   128024         0    128024   0%
        /media/ram<br>
        /dev/mmcblk0p2         3605300     72764   3349396   2%
        /media/mmcblk0p2<br>
        root@domain.hid:~# umount /dev/mmcblk0p1<br>
        root@domain.hid:~# umount /dev/mmcblk0p2<br>
        root@domain.hid:~# <br>
        root@domain.hid:~# *********    # remove sd card ####  
        ***********************<br>
        root@domain.hid:~# <br>
        root@domain.hid:~# cat /proc/interrupts<br>
                   CPU0<br>
          7:      32919        INTC  TWL4030-PIH<br>
         11:          0        INTC  prcm<br>
         12:        835        INTC  DMA<br>
         37:       1703        INTC  gp timer<br>
         56:      99075        INTC  i2c_omap<br>
         61:          0        INTC  i2c_omap<br>
         72:          1        INTC  serial idle<br>
         73:          1        INTC  serial idle<br>
         74:        252        INTC  serial idle, serial<br>
         77:      12455        INTC  ehci_hcd:usb1<br>
         83:        233        INTC  mmc0<br>
         92:          0        INTC  musb_hdrc<br>
         93:          0        INTC  musb_hdrc<br>
        378:          0     twl4030  twl4030_usb<br>
        379:          0     twl4030  rtc0<br>
        384:          0     twl4030  mmc0<br>
        Err:          0<br>
        root@domain.hid:~# cat /proc/interrupts<br>
                   CPU0<br>
          7:      61279        INTC  TWL4030-PIH<br>
         11:          0        INTC  prcm<br>
         12:        835        INTC  DMA<br>
         37:       1989        INTC  gp timer<br>
         56:     184159        INTC  i2c_omap<br>
         61:          0        INTC  i2c_omap<br>
         72:          1        INTC  serial idle<br>
         73:          1        INTC  serial idle<br>
         74:        279        INTC  serial idle, serial<br>
         77:      12507        INTC  ehci_hcd:usb1<br>
         83:        233        INTC  mmc0<br>
         92:          0        INTC  musb_hdrc<br>
         93:          0        INTC  musb_hdrc<br>
        378:          0     twl4030  twl4030_usb<br>
        379:          0     twl4030  rtc0<br>
        384:          0     twl4030  mmc0<br>
        Err:          0<br>
        root@domain.hid irq 95: 0xffffffdf, please flush
        posted write for irq 56<br>
        Spurious irq 95: 0xffffffdf, please flush posted write for irq
        56</tt></small><br>
    <small><tt>Spurious irq 95: 0xffffffdf, please flush posted write
        for irq 56<br>
        Spurious irq 95: 0xffffffdf, please flush posted write for irq
        56<br>
        Spurious irq 95: 0xffffffdf, please flush posted write for irq
        56<br>
        Spurious irq 95: 0xffffffdf, please flush posted write for irq
        56<br>
        Spurious irq 95: 0xffffffdf, please flush posted write for irq
        56<br>
        ... snipped ... About 1023 spurious irpt msgs occurred.<br>
      </tt></small><br>
    The beginning of the spurious irpt messages was not consistent. They
    usually started occuring soon, but not immediately after the SD card
    was removed. As you can see above, I was able to enter a couple
    commands before the interrupts began. Sometimes the messages
    occurred before the removal of the SD card. I think that any kind of
    i2c probed level 2 interrupt triggers the problem.<br>
    <br>
    I was fast enough to display /proc/interrupts after I pulled out the
    SD card (above) and befre the spurrious irpts occurred. The IRQ 384
    irpt is not shown  in /proc/interrupts and no "removed" message
    occurred. Without the Adeos patch (or with CONFIG_IPIPE disabled),
    the removel mesage was immediate.<br>
    <br>
    Regards,<br>
    Bob Feretich<br>
    <br>
    <br>
    <br>
    <br>
    <br>
    <br>
    <br>
    <br>
    <br>
    <br>
    <br>
    On 7/24/2010 11:57 AM, Gilles Chanteperdrix wrote:
    <blockquote cite="mid:4C4B379F.9040107@domain.hid" type="cite">
      <pre wrap="">Bob Feretich wrote:
</pre>
      <blockquote type="cite">
        <pre wrap="">  Let me make sure I understand.
The most recent report from me contained console logs of two boots.
The first was 2.6.33 with no Adeos patch applied.
The second was 2.6.33 with the Adeos patch and Xenomai enabled 
(CONFIG_IPIPE=y) and CONFIG_XENOMAI=y).

You want me to perform to tests:

   1. 2.6.33 with the Adeos patch applied, but .config edited to turn
      off CONFIG_IPIPE and CONFIG_XENOMAI.
</pre>
      </blockquote>
      <pre wrap="">
That is, if when you tested the kernel patched with Adeos you never
turned CONFIG_IPIPE off.

</pre>
      <blockquote type="cite">
        <pre wrap="">   2. Assuming test #1 passes the interrupts successfully, 2.6.33 with
      the Adeos patch applied, CONFIG_IPIPE=y, CONFIG_XENOMAI off, and
      revert the change to drivers/i2c/busses/i2c-omap.c.

Is that correct?
</pre>
      </blockquote>
      <pre wrap="">
Yep.


</pre>
    </blockquote>
  </body>
</html>

--------------060008020109000509000507--

