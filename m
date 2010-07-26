Message-ID: <4C4CEB8E.2000004@domain.hid>
Date: Sun, 25 Jul 2010 18:57:34 -0700
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
	<4C4B379F.9040107@domain.hid> <4C4BC6D6.8070806@domain.hid>
	<4C4C02BC.4010306@domain.hid>
In-Reply-To: <4C4C02BC.4010306@domain.hid>
Content-Type: multipart/alternative;
	boundary="------------070306090603050605080609"
Subject: Re: [Xenomai-help] Adeos patch prevents IRQ 384 (MMC Chip Detect)
 on omap-2.6.33 - working now
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
--------------070306090603050605080609
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit

  I applied the below patches to the 2.6.33 BeagleBoard system, they WORKED.
Then I edited the 2.6.31 kernel to reflect the same patches, it WORKED too!

Below are the console logs.

2.6.33 with Xenomai enabled...
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

2053552 bytes read
## Booting kernel from Legacy Image at 80300000 ...
    Image Name:   Angstrom/2.6.33/beagleboard
    Image Type:   ARM Linux Kernel Image (uncompressed)
    Data Size:    2053488 Bytes =  2 MB
    Load Address: 80008000
    Entry Point:  80008000
    Verifying Checksum ... OK
    Loading Kernel Image ... OK
OK

Starting kernel ...

Uncompressing Linux... done, booting the kernel.
Linux version 2.6.33 (Bob@domain.hid) (gcc version 4.3.3 (GCC) ) #3 
Sun Jul 25 14:20:13 PDT 2010
CPU: ARMv7 Processor [411fc083] revision 3 (ARMv7), cr=10c53c7f
CPU: VIPT nonaliasing data cache, VIPT nonaliasing instruction cache
Machine: OMAP3 Beagle Board
Memory policy: ECC disabled, Data cache writeback
OMAP3430/3530 ES3.0 (l2cache iva sgx neon isp )
SRAM: Mapped pa 0x40200000 to va 0xfe400000 size: 0x100000
Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 65024
Kernel command line: console=ttyS2,115200n8 
ip=192.168.1.81:192.168.1.80:192.168.1.1:255.255.255.0:beagleboard:et
h0:off root=/dev/nfs rw 
nfsroot=192.168.1.80:/home/Bob/NFSROOT,nolock,rsize=1024,wsize=1024 rootwait
PID hash table entries: 1024 (order: 0, 4096 bytes)
Dentry cache hash table entries: 32768 (order: 5, 131072 bytes)
Inode-cache hash table entries: 16384 (order: 4, 65536 bytes)
Memory: 128MB 128MB = 256MB total
Memory: 255360KB available (3592K code, 435K data, 132K init, 0K highmem)
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
I-pipe: Domain Xenomai registered.
Xenomai: hal/arm started.
Xenomai: scheduling class idle registered.
Xenomai: scheduling class rt registered.
Xenomai: real-time nucleus v2.5.3 (Hordes Of Locusts) loaded.
Xenomai: starting native API services.
Xenomai: starting POSIX services.
Xenomai: starting RTDM services.
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
i2c /dev entries driver
TCP cubic registered
NET: Registered protocol family 17
NET: Registered protocol family 15
Power Management for TI OMAP3.
VFP support v0.3: implementor 41 architecture 3 part 30 variant c rev 1
regulator_init_complete: incomplete constraints, leaving VDVI on
regulator_init_complete: incomplete constraints, leaving VDAC on
drivers/rtc/hctosys.c: unable to open rtc device (rtc0)
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
   /sys/devices/platform/ehci-omap.0/usb1/1-2/1-2:1.0/net/eth0 (369)
   
/sys/devices/platform/mmci-omap-hs.0/mmc_host/mmc0/mmc0:1234/block/mmcblk0 
(389)
   
/sys/devices/platform/mmci-omap-hs.0/mmc_host/mmc0/mmc0:1234/block/mmcblk0/mmcblk0p1 
(390)
   
/sys/devices/platform/mmci-omap-hs.0/mmc_host/mmc0/mmc0:1234/block/mmcblk0/mmcblk0p2 
(391)
Remounting root file system...
Caching udev devnodes
Populating dev cachemv: cannot rename '/tmp/uname': No such file or 
directory
EXT2-fs (mmcblk0p2): warning: mounting ext3 filesystem as ext2
EXT2-fs (mmcblk0p2): warning: mounting unchecked fs, running e2fsck is 
recommended
root: mount: mounting rootfs on / failed: No such file or directory
NOT configuring network interfaces: / is an NFS mount
hwclock: can't open '/dev/misc/rtc': No such file or directory
Tue May 18 20:58:00 UTC 2010
hwclock: can't open '/dev/misc/rtc': No such file or directory
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
root@domain.hid:~# ls /proc
1              22             9              irq            self
10             28             buddyinfo      kallsyms       slabinfo
11             29             bus            kmsg           softirqs
12             3              cmdline        kpagecount     stat
13             4              cpu            kpageflags     swaps
130            5              cpuinfo        loadavg        sys
131            52             crypto         locks          sysrq-trigger
14             6              devices        meminfo        sysvipc
15             626            diskstats      misc           timer_list
16             629            driver         modules        tty
17             631            execdomains    mounts         uptime
18             633            filesystems    mtd            version
19             634            fs             net            vmallocinfo
190            635            interrupts     pagetypeinfo   vmstat
2              637            iomem          partitions     xenomai
20             7              ioports        sched_debug    zoneinfo
21             8              ipipe          scsi
root@domain.hid:~# cat /proc/interrupts
            CPU0
   7:          0        INTC  TWL4030-PIH
  11:          0        INTC  prcm
  12:        444        INTC  DMA
  37:       1232        INTC  gp timer
  56:        262        INTC  i2c_omap
  61:          0        INTC  i2c_omap
  72:          1        INTC  serial idle
  73:          1        INTC  serial idle
  74:        175        INTC  serial idle, serial
  77:      12663        INTC  ehci_hcd:usb1
  83:        146        INTC  mmc0
  92:          0        INTC  musb_hdrc
  93:          0        INTC  musb_hdrc
378:          0     twl4030  twl4030_usb
384:          0     twl4030  mmc0
Err:          0
root@domain.hid:~# df
Filesystem           1K-blocks      Used Available Use% Mounted on
/dev/root             15868228   8776716   6930492  56% /
devtmpfs                127860       128    127732   0% /dev
none                    127860       128    127732   0% /dev
/dev/mmcblk0p1          197676      2222    195454   1% /media/mmcblk0p1
/dev/mmcblk0p2         3605300     72764   3349396   2% /media/mmcblk0p2
tmpfs                   127860        16    127844   0% /var/volatile
tmpfs                   127860         0    127860   0% /dev/shm
tmpfs                   127860         0    127860   0% /media/ram
root@domain.hid:~#
root@domain.hid:~# umount /dev/mmcblk0p1
root@domain.hid:~# umount /dev/mmcblk0p2
root@domain.hid:~#
root@domain.hid:~# # Remove SD Card
root@domain.hid:~#
root@domain.hid:~# mmc0: card 1234 removed

root@domain.hid:~# cat /proc/interrupts
            CPU0
   7:          1        INTC  TWL4030-PIH
  11:          0        INTC  prcm
  12:        752        INTC  DMA
  37:       1909        INTC  gp timer
  56:        283        INTC  i2c_omap
  61:          0        INTC  i2c_omap
  72:          1        INTC  serial idle
  73:          1        INTC  serial idle
  74:        335        INTC  serial idle, serial
  77:      13622        INTC  ehci_hcd:usb1
  83:        217        INTC  mmc0
  92:          0        INTC  musb_hdrc
  93:          0        INTC  musb_hdrc
378:          0     twl4030  twl4030_usb
384:          1     twl4030  mmc0
Err:          0
root@domain.hid:~# df
Filesystem           1K-blocks      Used Available Use% Mounted on
/dev/root             15868228   8776716   6930492  56% /
devtmpfs                127860       116    127744   0% /dev
none                    127860       116    127744   0% /dev
tmpfs                   127860        16    127844   0% /var/volatile
tmpfs                   127860         0    127860   0% /dev/shm
tmpfs                   127860         0    127860   0% /media/ram
root@domain.hid:~#
root@domain.hid:~#  # insert SD card
root@domain.hid:~#
root@domain.hid:~# mmc0: new high speed SDHC card at address 1234
mmcblk0: mmc0:1234 SA04G 3.68 GiB
  mmcblk0: p1 p2
EXT2-fs (mmcblk0p2): warning: mounting ext3 filesystem as ext2
EXT2-fs (mmcblk0p2): warning: mounting unchecked fs, running e2fsck is 
recommended

root@domain.hid:~# cat /proc/interrupts
            CPU0
   7:          2        INTC  TWL4030-PIH
  11:          0        INTC  prcm
  12:        900        INTC  DMA
  37:       2471        INTC  gp timer
  56:        311        INTC  i2c_omap
  61:          0        INTC  i2c_omap
  72:          1        INTC  serial idle
  73:          1        INTC  serial idle
  74:        456        INTC  serial idle, serial
  77:      14699        INTC  ehci_hcd:usb1
  83:        330        INTC  mmc0
  92:          0        INTC  musb_hdrc
  93:          0        INTC  musb_hdrc
378:          0     twl4030  twl4030_usb
384:          2     twl4030  mmc0
Err:          0
root@domain.hid:~# df
Filesystem           1K-blocks      Used Available Use% Mounted on
/dev/root             15868228   8776716   6930492  56% /
devtmpfs                127860       128    127732   0% /dev
none                    127860       128    127732   0% /dev
tmpfs                   127860        16    127844   0% /var/volatile
tmpfs                   127860         0    127860   0% /dev/shm
tmpfs                   127860         0    127860   0% /media/ram
/dev/mmcblk0p1          197676      2222    195454   1% /media/mmcblk0p1
/dev/mmcblk0p2         3605300     72764   3349396   2% /media/mmcblk0p2
root@domain.hid:~# cat /proc/xenomai
cat: read error: Is a directory
root@domain.hid:~# cat /proc/ipipe
cat: read error: Is a directory
root@domain.hid:~# ls /proc/ipipe
Linux    Xenomai  version
root@domain.hid:~# ls /proc/ipipe/Xenomai
/proc/ipipe/Xenomai
root@domain.hid:~# cat /proc/ipipe/Xenomai
        +----- Handling ([A]ccepted, [G]rabbed, [W]ired, [D]iscarded)
        |+---- Sticky
        ||+--- Locked
        |||+-- Exclusive
        ||||+- Virtual
[IRQ]  |||||
   37:  W..X.
  418:  W...V
[Domain info]
id=0x58454e4f
priority=topmost
root@domain.hid:~# ls /proc/xenomai
acct          heap          registry      stat          version
apc           interfaces    rtdm          timebases
faults        irq           sched         timer
hal           latency       schedclasses  timerstat
root@domain.hid:~# cat /proc/xenomai/irq
IRQ         CPU0
  37:        3903         [timer]
418:           0         [virtual]
root@domain.hid:~#

2.6.31 with Xenomai enabled (booted both from NFS (below) and the 
SD-card, both worked)
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

1902512 bytes read
## Booting kernel from Legacy Image at 80300000 ...
    Image Name:   Angstrom/2.6.33/beagleboard
    Image Type:   ARM Linux Kernel Image (uncompressed)
    Data Size:    1902448 Bytes =  1.8 MB
    Load Address: 80008000
    Entry Point:  80008000
    Verifying Checksum ... OK
    Loading Kernel Image ... OK
OK

Starting kernel ...

Uncompressing Linux... done, booting the kernel.
Linux version 2.6.33 (rhino@domain.hid) (gcc version 4.3.3 (GCC) ) #2 
Sun Jul 25 14:45:37 PDT 2010
CPU: ARMv7 Processor [411fc083] revision 3 (ARMv7), cr=10c53c7f
CPU: VIPT nonaliasing data cache, VIPT nonaliasing instruction cache
Machine: OMAP3 Beagle Board
Memory policy: ECC disabled, Data cache writeback
OMAP3430/3530 ES3.0 (l2cache iva sgx neon isp )
SRAM: Mapped pa 0x40200000 to va 0xfe400000 size: 0x100000
Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 65024
Kernel command line: console=ttyS2,115200n8 
ip=192.168.1.81:192.168.1.80:192.168.1.1:255.255.255.0:beagleboard:et
h0:off root=/dev/nfs rw 
nfsroot=192.168.1.80:/home/Bob/NFSROOT,nolock,rsize=1024,wsize=1024 rootwait
PID hash table entries: 1024 (order: 0, 4096 bytes)
Dentry cache hash table entries: 32768 (order: 5, 131072 bytes)
Inode-cache hash table entries: 16384 (order: 4, 65536 bytes)
Memory: 128MB 128MB = 256MB total
Memory: 255872KB available (3284K code, 285K data, 128K init, 0K highmem)
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
Power Management for TI OMAP3.
VFP support v0.3: implementor 41 architecture 3 part 30 variant c rev 1
regulator_init_complete: incomplete constraints, leaving VDVI on
regulator_init_complete: incomplete constraints, leaving VDAC on
twl_rtc twl_rtc: setting system clock to 2000-01-01 00:00:00 UTC (946684800)
usb 1-2: new high speed USB device using ehci-omap and address 2
mmc0: new high speed SDHC card at address 71df
mmcblk0: mmc0:71df SD04G 3.69 GiB
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
Freeing init memory: 128K
INIT: version 2.86 booting
Please wait: booting...
Starting udev
EXT2-fs (mmcblk0p2): error: couldn't mount because of unsupported 
optional features (4)
kjournald starting.  Commit interval 5 seconds
EXT3-fs (mmcblk0p2): using internal journal
EXT3-fs (mmcblk0p2): recovery complete
EXT3-fs (mmcblk0p2): mounted filesystem with writeback data mode
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

2020284 bytes read
## Booting kernel from Legacy Image at 80300000 ...
    Image Name:   Angstrom/2.6.31/beagleboard
    Image Type:   ARM Linux Kernel Image (uncompressed)
    Data Size:    2020220 Bytes =  1.9 MB
    Load Address: 80008000
    Entry Point:  80008000
    Verifying Checksum ... OK
    Loading Kernel Image ... OK
OK

Starting kernel ...

Uncompressing 
Linux..............................................................................................
................................... done, booting the kernel.
Linux version 2.6.31-omap1 (Bob@domain.hid) (gcc version 4.3.3 (GCC) ) 
#1 Sun Jul 25 16:58:55 PDT 2010
CPU: ARMv7 Processor [411fc083] revision 3 (ARMv7), cr=10c53c7f
CPU: VIPT nonaliasing data cache, VIPT nonaliasing instruction cache
Machine: OMAP3 Beagle Board
Memory policy: ECC disabled, Data cache writeback
OMAP3430 ES3.0
SRAM: Mapped pa 0x40200000 to va 0xe3000000 size: 0x100000
Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 65024
Kernel command line: console=ttyS2,115200n8 
ip=192.168.1.81:192.168.1.80:192.168.1.1:255.255.255.0:beagleboard:et
h0:off root=/dev/nfs rw 
nfsroot=192.168.1.80:/home/Bob/NFSROOT,nolock,rsize=1024,wsize=1024 rootwait
PID hash table entries: 1024 (order: 10, 4096 bytes)
Dentry cache hash table entries: 32768 (order: 5, 131072 bytes)
Inode-cache hash table entries: 16384 (order: 4, 65536 bytes)
Memory: 128MB 128MB = 256MB total
Memory: 255488KB available (3548K code, 412K data, 136K init, 0K highmem)
NR_IRQS:402
Clocking rate (Crystal/Core/MPU): 26.0/332/500 MHz
Reprogramming SDRC clock to 332000000 Hz
GPMC revision 5.0
IRQ: Found an INTC at 0xd8200000 (revision 4.0) with 96 interrupts
Total of 96 interrupts on 1 active controller
OMAP34xx GPIO hardware version 2.5
OMAP clockevent source: GPTIMER1 at 13000000 Hz
I-pipe 1.16-01: pipeline enabled.
Console: colour dummy device 80x30
Calibrating delay loop... 498.07 BogoMIPS (lpj=2490368)
Mount-cache hash table entries: 512
CPU: Testing write buffer coherency: ok
regulator: core version 0.5
NET: Registered protocol family 16
Found NAND on CS0
Registering NAND on CS0
OMAP DMA hardware revision 4.0
bio: create slab <bio-0> at 0
i2c_omap i2c_omap.1: bus 1 rev3.12 at 2600 kHz
twl4030: PIH (irq 7) chaining IRQs 368..375
twl4030: power (irq 373) chaining IRQs 376..383
twl4030: gpio (irq 368) chaining IRQs 384..401
regulator: VMMC1: 1850 <--> 3150 mV normal standby
regulator: VDAC: 1800 mV normal standby
regulator: VUSB1V5: 1500 mV normal standby
regulator: VUSB1V8: 1800 mV normal standby
regulator: VUSB3V1: 3100 mV normal standby
regulator: VPLL2: 1800 mV normal standby
regulator: VSIM: 1800 <--> 3000 mV normal standby
i2c_omap i2c_omap.3: bus 3 rev3.12 at 100 kHz
SCSI subsystem initialized
twl4030_usb twl4030_usb: Initialized TWL4030 USB module
usbcore: registered new interface driver usbfs
usbcore: registered new interface driver hub
usbcore: registered new device driver usb
musb_hdrc: version 6.0, musb-dma, otg (peripheral+host), debug=0
musb_hdrc: USB OTG mode controller at d80ab000 using DMA, IRQ 92
NET: Registered protocol family 2
IP route cache hash table entries: 2048 (order: 1, 8192 bytes)
TCP established hash table entries: 8192 (order: 4, 65536 bytes)
TCP bind hash table entries: 8192 (order: 3, 32768 bytes)
TCP: Hash tables configured (established 8192 bind 8192)
TCP reno registered
NET: Registered protocol family 1
I-pipe: Domain Xenomai registered.
Xenomai: hal/arm started.
Xenomai: scheduling class idle registered.
Xenomai: scheduling class rt registered.
Xenomai: real-time nucleus v2.5.3 (Hordes Of Locusts) loaded.
Xenomai: starting native API services.
Xenomai: starting POSIX services.
Xenomai: starting RTDM services.
VFS: Disk quotas dquot_6.5.2
Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)
JFFS2 version 2.2. (NAND) ï¿½Â© 2001-2006 Red Hat, Inc.
msgmni has been set to 499
alg: No test for stdrng (krng)
Block layer SCSI generic (bsg) driver version 0.4 loaded (major 253)
io scheduler noop registered
io scheduler anticipatory registered (default)
io scheduler deadline registered
io scheduler cfq registered
Serial: 8250/16550 driver, 4 ports, IRQ sharing enabled
serial8250.0: ttyS0 at MMIO 0x4806a000 (irq = 72) is a ST16654
serial8250.1: ttyS1 at MMIO 0x4806c000 (irq = 73) is a ST16654
serial8250.2: ttyS2 at MMIO 0x49020000 (irq = 74) is a ST16654
console [ttyS2] enabled
brd: module loaded
loop: module loaded
i2c /dev entries driver
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
usb usb1: New USB device found, idVendor=1d6b, idProduct=0002
usb usb1: New USB device strings: Mfr=3, Product=2, SerialNumber=1
usb usb1: Product: OMAP-EHCI Host Controller
usb usb1: Manufacturer: Linux 2.6.31-omap1 ehci_hcd
usb usb1: SerialNumber: ehci-omap.0
usb usb1: configuration #1 chosen from 1 choice
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 3 ports detected
g_ether gadget: using random self ethernet address
g_ether gadget: using random host ethernet address
usb0: MAC 36:3c:3a:f5:b5:ed
usb0: HOST MAC ce:32:fc:bb:54:f2
g_ether gadget: Ethernet Gadget, version: Memorial Day 2008
g_ether gadget: g_ether ready
musb_hdrc musb_hdrc: MUSB HDRC host driver
musb_hdrc musb_hdrc: new USB bus registered, assigned bus number 2
usb usb2: New USB device found, idVendor=1d6b, idProduct=0002
usb usb2: New USB device strings: Mfr=3, Product=2, SerialNumber=1
usb usb2: Product: MUSB HDRC host driver
usb usb2: Manufacturer: Linux 2.6.31-omap1 musb-hcd
usb usb2: SerialNumber: musb_hdrc
usb usb2: configuration #1 chosen from 1 choice
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 1 port detected
mmci-omap-hs mmci-omap-hs.0: Failed to get debounce clock
TCP cubic registered
NET: Registered protocol family 17
NET: Registered protocol family 15
RPC: Registered udp transport module.
RPC: Registered tcp transport module.
Power Management for TI OMAP3.
VFP support v0.3: implementor 41 architecture 3 part 30 variant c rev 1
regulator_init_complete: incomplete constraints, leaving VDVI on
regulator_init_complete: incomplete constraints, leaving VDAC on
drivers/rtc/hctosys.c: unable to open rtc device (rtc0)
usb 1-2: new high speed USB device using ehci-omap and address 2
mmc0: new high speed SD card at address dd7b
mmcblk0: mmc0:dd7b SD02G 1.87 GiB
  mmcblk0: p1 p2
usb 1-2: New USB device found, idVendor=0b95, idProduct=7720
usb 1-2: New USB device strings: Mfr=1, Product=2, SerialNumber=3
usb 1-2: Product: AX88772
usb 1-2: Manufacturer: ASIX Elec. Corp.
usb 1-2: SerialNumber: 000001
usb 1-2: configuration #1 chosen from 1 choice
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
Freeing init memory: 136K
INIT: version 2.86 booting
Please wait: booting...
Starting udev
EXT2-fs warning (device mmcblk0p2): ext2_fill_super: mounting ext3 
filesystem as ext2
Remounting root file system...
Caching udev devnodes
Populating dev cache
root: mount: mounting rootfs on / failed: No such file or directory
NOT configuring network interfaces: / is an NFS mount
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
AAAAB3NzaC1yc2EAAAADAQABAAAAgwCyuGR5NlHYDfmcD6+zGcZ6PKDReZKrofcLvBt3gMLNTnH55vAvOf+xvuWsPQCjBjEs/6EqSV1z/
CvhafTDQcEHvyPf6NRLAdeYF8IT8JIwZQZXUOVazcY0uL3xsfBeGKOdt9XKTc4JOD/xrZhFixKETXKC1ZY0CLA7h+su1N6NufHH 
root@domain.hid
ard
Fingerprint: md5 87:48:4b:38:af:ed:85:7f:0f:c3:49:17:96:1a:14:6d
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
root@domain.hid:~# df
Filesystem           1K-blocks      Used Available Use% Mounted on
/dev/root             15868228   8777056   6930152  56% /
none                    127896       132    127764   0% /dev
/dev/mmcblk0p1          197676      2190    195487   1% /media/mmcblk0p1
/dev/mmcblk0p2         1731460     35396   1608112   2% /media/mmcblk0p2
tmpfs                   127896        16    127880   0% /var/volatile
tmpfs                   127896         0    127896   0% /dev/shm
tmpfs                   127896         0    127896   0% /media/ram
root@domain.hid:~# cat /proc/interrupts
            CPU0
   7:          2        INTC  TWL4030-PIH
  11:          0        INTC  prcm
  12:       3238        INTC  DMA
  37:       1833        INTC  gp timer
  56:        273        INTC  i2c_omap
  61:          0        INTC  i2c_omap
  72:          1        INTC  serial idle
  73:          1        INTC  serial idle
  74:        188        INTC  serial idle, serial
  77:      13354        INTC  ehci_hcd:usb1
  83:       6343        INTC  mmc0
  92:          1        INTC  musb_hdrc
  93:          0        INTC  musb_hdrc
378:          2     twl4030  twl4030_usb
384:          0     twl4030  mmc0
Err:          0
root@domain.hid:~# umount /dev/mmcblk0p1
root@domain.hid:~# umount /dev/mmcblk0p2
root@domain.hid:~#
root@domain.hid:~# # removing SD card
root@domain.hid:~#
root@domain.hid:~# mmc0: card dd7b removed

root@domain.hid:~# cat /proc/interrupts
            CPU0
   7:          3        INTC  TWL4030-PIH
  11:          0        INTC  prcm
  12:       3245        INTC  DMA
  37:       2575        INTC  gp timer
  56:        294        INTC  i2c_omap
  61:          0        INTC  i2c_omap
  72:          1        INTC  serial idle
  73:          1        INTC  serial idle
  74:        321        INTC  serial idle, serial
  77:      14305        INTC  ehci_hcd:usb1
  83:       6599        INTC  mmc0
  92:          1        INTC  musb_hdrc
  93:          0        INTC  musb_hdrc
378:          2     twl4030  twl4030_usb
384:          1     twl4030  mmc0
Err:          0
root@domain.hid:~# df
Filesystem           1K-blocks      Used Available Use% Mounted on
/dev/root             15868228   8777056   6930152  56% /
none                    127896       120    127776   0% /dev
tmpfs                   127896        16    127880   0% /var/volatile
tmpfs                   127896         0    127896   0% /dev/shm
tmpfs                   127896         0    127896   0% /media/ram
root@domain.hid:~#
root@domain.hid:~# # inserting SD card
root@domain.hid:~#
root@domain.hid:~# mmc0: new high speed SD card at address dd7b
mmcblk0: mmc0:dd7b SD02G 1.87 GiB
  mmcblk0: p1 p2
EXT2-fs warning (device mmcblk0p2): ext2_fill_super: mounting ext3 
filesystem as ext2

root@domain.hid:~# df
Filesystem           1K-blocks      Used Available Use% Mounted on
/dev/root             15868228   8777056   6930152  56% /
none                    127896       132    127764   0% /dev
tmpfs                   127896        16    127880   0% /var/volatile
tmpfs                   127896         0    127896   0% /dev/shm
tmpfs                   127896         0    127896   0% /media/ram
/dev/mmcblk0p2         1731460     35396   1608112   2% /media/mmcblk0p2
/dev/mmcblk0p1          197676      2190    195487   1% /media/mmcblk0p1
root@domain.hid:~# cat /proc/interrupts
            CPU0
   7:          4        INTC  TWL4030-PIH
  11:          0        INTC  prcm
  12:       6482        INTC  DMA
  37:       3246        INTC  gp timer
  56:        317        INTC  i2c_omap
  61:          0        INTC  i2c_omap
  72:          1        INTC  serial idle
  73:          1        INTC  serial idle
  74:        463        INTC  serial idle, serial
  77:      15483        INTC  ehci_hcd:usb1
  83:      12938        INTC  mmc0
  92:          1        INTC  musb_hdrc
  93:          0        INTC  musb_hdrc
378:          2     twl4030  twl4030_usb
384:          2     twl4030  mmc0
Err:          0

Note that twl_4030_usb interrupts are being passed too.
Thanks Gilles. Great job!
Regards,
Bob feretich

On 7/25/2010 2:24 AM, Gilles Chanteperdrix wrote:
> Bob Feretich wrote:
>>    Test 1 results:
>> With the Adeos patch installed, but Adeos disabled, the system ran
>> normally. IRQ 384s were presented and serviced.  (The SD card removal
>> amd insertion was handled correctly.)
> Ok. Could you try the following patch? It fixes the "always growing PIH
> interrupt count" number here, and now I have some twl4030_usb
> interrupts. However, I could not test the SD card insertion/removal,
> because I am working on the board remotely.
>
> diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
> index 8d608a1..0037e31 100644
> --- a/drivers/i2c/busses/i2c-omap.c
> +++ b/drivers/i2c/busses/i2c-omap.c
> @@ -478,10 +478,6 @@ static int omap_i2c_xfer_msg(struct i2c_adapter *adap,
>   	if (msg->len == 0)
>   		return -EINVAL;
>
> -#ifdef CONFIG_IPIPE
> -	disable_irq(dev->irq);
> -#endif /* CONFIG_IPIPE */
> -
>   	omap_i2c_write_reg(dev, OMAP_I2C_SA_REG, msg->addr);
>
>   	/* REVISIT: Could the STB bit of I2C_CON be used with probing? */
> @@ -525,9 +521,6 @@ static int omap_i2c_xfer_msg(struct i2c_adapter *adap,
>
>   			/* Let the user know if i2c is in a bad state */
>   			if (time_after(jiffies, delay)) {
> -#ifdef CONFIG_IPIPE
> -				enable_irq(dev->irq);
> -#endif /* CONFIG_IPIPE */
>   				dev_err(dev->dev, "controller timed out "
>   				"waiting for start condition to finish\n");
>   				return -ETIMEDOUT;
> @@ -539,9 +532,6 @@ static int omap_i2c_xfer_msg(struct i2c_adapter *adap,
>   		w&= ~OMAP_I2C_CON_STT;
>   		omap_i2c_write_reg(dev, OMAP_I2C_CON_REG, w);
>   	}
> -#ifdef CONFIG_IPIPE
> -	enable_irq(dev->irq);
> -#endif /* CONFIG_IPIPE */
>
>   	/*
>   	 * REVISIT: We should abort the transfer on signals, but the bus goes
> diff --git a/drivers/mfd/twl4030-irq.c b/drivers/mfd/twl4030-irq.c
> index 9df9a5a..fb4b9f2 100644
> --- a/drivers/mfd/twl4030-irq.c
> +++ b/drivers/mfd/twl4030-irq.c
> @@ -332,7 +332,7 @@ static int twl4030_irq_thread(void *data)
>   					note_interrupt(module_irq, d,
>   							IRQ_NONE);
>   				else
> -					d->handle_irq(module_irq, d);
> +					ipipe_handle_irq_cond(module_irq);
>   			}
>   		}
>   		local_irq_enable();
>

--------------070306090603050605080609
Content-Type: text/html; charset="utf-8"
Content-Transfer-Encoding: 8bit

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <meta content="text/html; charset=UTF-8" http-equiv="Content-Type">
    <title></title>
  </head>
  <body bgcolor="#ffffff" text="#000000">
    I applied the below patches to the 2.6.33 BeagleBoard system, they
    WORKED.<br>
    Then I edited the 2.6.31 kernel to reflect the same patches, it
    WORKED too!<br>
    <br>
    Below are the console logs.<br>
    <br>
    2.6.33 with Xenomai enabled...<br>
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
        2053552 bytes read<br>
        ## Booting kernel from Legacy Image at 80300000 ...<br>
           Image Name:   Angstrom/2.6.33/beagleboard<br>
           Image Type:   ARM Linux Kernel Image (uncompressed)<br>
           Data Size:    2053488 Bytes =  2 MB<br>
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
        ) #3 Sun Jul 25 14:20:13 PDT 2010<br>
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
        ip=192.168.1.81:192.168.1.80:192.168.1.1:255.255.255.0:beagleboard:et<br>
        h0:off root=/dev/nfs rw
        nfsroot=192.168.1.80:/home/Bob/NFSROOT,nolock,rsize=1024,wsize=1024
        rootwait<br>
        PID hash table entries: 1024 (order: 0, 4096 bytes)<br>
        Dentry cache hash table entries: 32768 (order: 5, 131072 bytes)<br>
        Inode-cache hash table entries: 16384 (order: 4, 65536 bytes)<br>
        Memory: 128MB 128MB = 256MB total<br>
        Memory: 255360KB available (3592K code, 435K data, 132K init, 0K
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
        I-pipe: Domain Xenomai registered.<br>
        Xenomai: hal/arm started.<br>
        Xenomai: scheduling class idle registered.<br>
        Xenomai: scheduling class rt registered.<br>
        Xenomai: real-time nucleus v2.5.3 (Hordes Of Locusts) loaded.<br>
        Xenomai: starting native API services.<br>
        Xenomai: starting POSIX services.<br>
        Xenomai: starting RTDM services.<br>
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
        i2c /dev entries driver<br>
        TCP cubic registered<br>
        NET: Registered protocol family 17<br>
        NET: Registered protocol family 15<br>
        Power Management for TI OMAP3.<br>
        VFP support v0.3: implementor 41 architecture 3 part 30 variant
        c rev 1<br>
        regulator_init_complete: incomplete constraints, leaving VDVI on<br>
        regulator_init_complete: incomplete constraints, leaving VDAC on<br>
        drivers/rtc/hctosys.c: unable to open rtc device (rtc0)<br>
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
        (369)<br>
         
        /sys/devices/platform/mmci-omap-hs.0/mmc_host/mmc0/mmc0:1234/block/mmcblk0
        (389)<br>
         
        /sys/devices/platform/mmci-omap-hs.0/mmc_host/mmc0/mmc0:1234/block/mmcblk0/mmcblk0p1
        (390)<br>
         
        /sys/devices/platform/mmci-omap-hs.0/mmc_host/mmc0/mmc0:1234/block/mmcblk0/mmcblk0p2
        (391)<br>
        Remounting root file system...<br>
        Caching udev devnodes<br>
        Populating dev cachemv: cannot rename '/tmp/uname': No such file
        or directory<br>
        EXT2-fs (mmcblk0p2): warning: mounting ext3 filesystem as ext2<br>
        EXT2-fs (mmcblk0p2): warning: mounting unchecked fs, running
        e2fsck is recommended<br>
        root: mount: mounting rootfs on / failed: No such file or
        directory<br>
        NOT configuring network interfaces: / is an NFS mount<br>
        hwclock: can't open '/dev/misc/rtc': No such file or directory<br>
        Tue May 18 20:58:00 UTC 2010<br>
        hwclock: can't open '/dev/misc/rtc': No such file or directory<br>
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
        root@domain.hid:~# ls /proc<br>
        1              22             9              irq            self<br>
        10             28             buddyinfo      kallsyms      
        slabinfo<br>
        11             29             bus            kmsg          
        softirqs<br>
        12             3              cmdline        kpagecount     stat<br>
        13             4              cpu            kpageflags    
        swaps<br>
        130            5              cpuinfo        loadavg        sys<br>
        131            52             crypto         locks         
        sysrq-trigger<br>
        14             6              devices        meminfo       
        sysvipc<br>
        15             626            diskstats      misc          
        timer_list<br>
        16             629            driver         modules        tty<br>
        17             631            execdomains    mounts        
        uptime<br>
        18             633            filesystems    mtd           
        version<br>
        19             634            fs             net           
        vmallocinfo<br>
        190            635            interrupts     pagetypeinfo  
        vmstat<br>
        2              637            iomem          partitions    
        xenomai<br>
        20             7              ioports        sched_debug   
        zoneinfo<br>
        21             8              ipipe          scsi<br>
        root@domain.hid:~# cat /proc/interrupts<br>
                   CPU0<br>
          7:          0        INTC  TWL4030-PIH<br>
         11:          0        INTC  prcm<br>
         12:        444        INTC  DMA<br>
         37:       1232        INTC  gp timer<br>
         56:        262        INTC  i2c_omap<br>
         61:          0        INTC  i2c_omap<br>
         72:          1        INTC  serial idle<br>
         73:          1        INTC  serial idle<br>
         74:        175        INTC  serial idle, serial<br>
         77:      12663        INTC  ehci_hcd:usb1<br>
         83:        146        INTC  mmc0<br>
         92:          0        INTC  musb_hdrc<br>
         93:          0        INTC  musb_hdrc<br>
        378:          0     twl4030  twl4030_usb<br>
        384:          0     twl4030  mmc0<br>
        Err:          0<br>
        root@domain.hid:~# df<br>
        Filesystem           1K-blocks      Used Available Use% Mounted
        on<br>
        /dev/root             15868228   8776716   6930492  56% /<br>
        devtmpfs                127860       128    127732   0% /dev<br>
        none                    127860       128    127732   0% /dev<br>
        /dev/mmcblk0p1          197676      2222    195454   1%
        /media/mmcblk0p1<br>
        /dev/mmcblk0p2         3605300     72764   3349396   2%
        /media/mmcblk0p2<br>
        tmpfs                   127860        16    127844   0%
        /var/volatile<br>
        tmpfs                   127860         0    127860   0% /dev/shm<br>
        tmpfs                   127860         0    127860   0%
        /media/ram<br>
        root@domain.hid:~# <br>
        root@domain.hid:~# umount /dev/mmcblk0p1<br>
        root@domain.hid:~# umount /dev/mmcblk0p2<br>
        root@domain.hid:~# <br>
        root@domain.hid:~# # Remove SD Card<br>
        root@domain.hid:~# <br>
        root@domain.hid:~# mmc0: card 1234 removed<br>
        <br>
        root@domain.hid:~# cat /proc/interrupts<br>
                   CPU0<br>
          7:          1        INTC  TWL4030-PIH<br>
         11:          0        INTC  prcm<br>
         12:        752        INTC  DMA<br>
         37:       1909        INTC  gp timer<br>
         56:        283        INTC  i2c_omap<br>
         61:          0        INTC  i2c_omap<br>
         72:          1        INTC  serial idle<br>
         73:          1        INTC  serial idle<br>
         74:        335        INTC  serial idle, serial<br>
         77:      13622        INTC  ehci_hcd:usb1<br>
         83:        217        INTC  mmc0<br>
         92:          0        INTC  musb_hdrc<br>
         93:          0        INTC  musb_hdrc<br>
        378:          0     twl4030  twl4030_usb<br>
        384:          1     twl4030  mmc0<br>
        Err:          0<br>
        root@domain.hid:~# df<br>
        Filesystem           1K-blocks      Used Available Use% Mounted
        on<br>
        /dev/root             15868228   8776716   6930492  56% /<br>
        devtmpfs                127860       116    127744   0% /dev<br>
        none                    127860       116    127744   0% /dev<br>
        tmpfs                   127860        16    127844   0%
        /var/volatile<br>
        tmpfs                   127860         0    127860   0% /dev/shm<br>
        tmpfs                   127860         0    127860   0%
        /media/ram<br>
        root@domain.hid:~# <br>
        root@domain.hid:~#  # insert SD card<br>
        root@domain.hid:~# <br>
        root@domain.hid:~# mmc0: new high speed SDHC card at address
        1234<br>
        mmcblk0: mmc0:1234 SA04G 3.68 GiB <br>
         mmcblk0: p1 p2<br>
        EXT2-fs (mmcblk0p2): warning: mounting ext3 filesystem as ext2<br>
        EXT2-fs (mmcblk0p2): warning: mounting unchecked fs, running
        e2fsck is recommended<br>
        <br>
        root@domain.hid:~# cat /proc/interrupts<br>
                   CPU0<br>
          7:          2        INTC  TWL4030-PIH<br>
         11:          0        INTC  prcm<br>
         12:        900        INTC  DMA<br>
         37:       2471        INTC  gp timer<br>
         56:        311        INTC  i2c_omap<br>
         61:          0        INTC  i2c_omap<br>
         72:          1        INTC  serial idle<br>
         73:          1        INTC  serial idle<br>
         74:        456        INTC  serial idle, serial<br>
         77:      14699        INTC  ehci_hcd:usb1<br>
         83:        330        INTC  mmc0<br>
         92:          0        INTC  musb_hdrc<br>
         93:          0        INTC  musb_hdrc<br>
        378:          0     twl4030  twl4030_usb<br>
        384:          2     twl4030  mmc0<br>
        Err:          0<br>
        root@domain.hid:~# df<br>
        Filesystem           1K-blocks      Used Available Use% Mounted
        on<br>
        /dev/root             15868228   8776716   6930492  56% /<br>
        devtmpfs                127860       128    127732   0% /dev<br>
        none                    127860       128    127732   0% /dev<br>
        tmpfs                   127860        16    127844   0%
        /var/volatile<br>
        tmpfs                   127860         0    127860   0% /dev/shm<br>
        tmpfs                   127860         0    127860   0%
        /media/ram<br>
        /dev/mmcblk0p1          197676      2222    195454   1%
        /media/mmcblk0p1<br>
        /dev/mmcblk0p2         3605300     72764   3349396   2%
        /media/mmcblk0p2<br>
        root@domain.hid:~# cat /proc/xenomai   <br>
        cat: read error: Is a directory<br>
        root@domain.hid:~# cat /proc/ipipe  <br>
        cat: read error: Is a directory<br>
        root@domain.hid:~# ls /proc/ipipe   <br>
        Linux    Xenomai  version<br>
        root@domain.hid:~# ls /proc/ipipe/Xenomai <br>
        /proc/ipipe/Xenomai<br>
        root@domain.hid:~# cat /proc/ipipe/Xenomai   <br>
               +----- Handling ([A]ccepted, [G]rabbed, [W]ired,
        [D]iscarded)<br>
               |+---- Sticky<br>
               ||+--- Locked<br>
               |||+-- Exclusive<br>
               ||||+- Virtual<br>
        [IRQ]  |||||<br>
          37:  W..X.<br>
         418:  W...V<br>
        [Domain info]<br>
        id=0x58454e4f<br>
        priority=topmost<br>
        root@domain.hid:~# ls /proc/xenomai   <br>
        acct          heap          registry      stat          version<br>
        apc           interfaces    rtdm          timebases<br>
        faults        irq           sched         timer<br>
        hal           latency       schedclasses  timerstat<br>
        root@domain.hid:~# cat /proc/xenomai/irq<br>
        IRQ         CPU0<br>
         37:        3903         [timer]<br>
        418:           0         [virtual]<br>
        root@domain.hid:~# </tt></small><br>
    <br>
    2.6.31 with Xenomai enabled (booted both from NFS (below) and the
    SD-card, both worked)<br>
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
        1902512 bytes read<br>
        ## Booting kernel from Legacy Image at 80300000 ...<br>
           Image Name:   Angstrom/2.6.33/beagleboard<br>
           Image Type:   ARM Linux Kernel Image (uncompressed)<br>
           Data Size:    1902448 Bytes =  1.8 MB<br>
           Load Address: 80008000<br>
           Entry Point:  80008000<br>
           Verifying Checksum ... OK<br>
           Loading Kernel Image ... OK<br>
        OK<br>
        <br>
        Starting kernel ...<br>
        <br>
        Uncompressing Linux... done, booting the kernel.<br>
        Linux version 2.6.33 (<a class="moz-txt-link-abbreviated" href="mailto:rhino@domain.hid">rhino@domain.hid</a>) (gcc version 4.3.3
        (GCC) ) #2 Sun Jul 25 14:45:37 PDT 2010<br>
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
        ip=192.168.1.81:192.168.1.80:192.168.1.1:255.255.255.0:beagleboard:et<br>
        h0:off root=/dev/nfs rw
        nfsroot=192.168.1.80:/home/Bob/NFSROOT,nolock,rsize=1024,wsize=1024
        rootwait<br>
        PID hash table entries: 1024 (order: 0, 4096 bytes)<br>
        Dentry cache hash table entries: 32768 (order: 5, 131072 bytes)<br>
        Inode-cache hash table entries: 16384 (order: 4, 65536 bytes)<br>
        Memory: 128MB 128MB = 256MB total<br>
        Memory: 255872KB available (3284K code, 285K data, 128K init, 0K
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
        Power Management for TI OMAP3.<br>
        VFP support v0.3: implementor 41 architecture 3 part 30 variant
        c rev 1<br>
        regulator_init_complete: incomplete constraints, leaving VDVI on<br>
        regulator_init_complete: incomplete constraints, leaving VDAC on<br>
        twl_rtc twl_rtc: setting system clock to 2000-01-01 00:00:00 UTC
        (946684800)<br>
        usb 1-2: new high speed USB device using ehci-omap and address 2<br>
        mmc0: new high speed SDHC card at address 71df<br>
        mmcblk0: mmc0:71df SD04G 3.69 GiB <br>
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
        Freeing init memory: 128K<br>
        INIT: version 2.86 booting<br>
        Please wait: booting...<br>
        Starting udev<br>
        EXT2-fs (mmcblk0p2): error: couldn't mount because of
        unsupported optional features (4)<br>
        kjournald starting.  Commit interval 5 seconds<br>
        EXT3-fs (mmcblk0p2): using internal journal<br>
        EXT3-fs (mmcblk0p2): recovery complete<br>
        EXT3-fs (mmcblk0p2): mounted filesystem with writeback data mode<br>
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
        <br>
        Texas Instruments X-Loader 1.4.2 (Feb 19 2009 - 12:01:24)<br>
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
        2020284 bytes read<br>
        ## Booting kernel from Legacy Image at 80300000 ...<br>
           Image Name:   Angstrom/2.6.31/beagleboard<br>
           Image Type:   ARM Linux Kernel Image (uncompressed)<br>
           Data Size:    2020220 Bytes =  1.9 MB<br>
           Load Address: 80008000<br>
           Entry Point:  80008000<br>
           Verifying Checksum ... OK<br>
           Loading Kernel Image ... OK<br>
        OK<br>
        <br>
        Starting kernel ...<br>
        <br>
        Uncompressing
Linux..............................................................................................<br>
        ................................... done, booting the kernel.<br>
        Linux version 2.6.31-omap1 (<a class="moz-txt-link-abbreviated" href="mailto:Bob@domain.hid">Bob@domain.hid</a>) (gcc version 4.3.3
        (GCC) ) #1 Sun Jul 25 16:58:55 PDT 2010<br>
        CPU: ARMv7 Processor [411fc083] revision 3 (ARMv7), cr=10c53c7f<br>
        CPU: VIPT nonaliasing data cache, VIPT nonaliasing instruction
        cache<br>
        Machine: OMAP3 Beagle Board<br>
        Memory policy: ECC disabled, Data cache writeback<br>
        OMAP3430 ES3.0<br>
        SRAM: Mapped pa 0x40200000 to va 0xe3000000 size: 0x100000<br>
        Built 1 zonelists in Zone order, mobility grouping on.  Total
        pages: 65024<br>
        Kernel command line: console=ttyS2,115200n8
        ip=192.168.1.81:192.168.1.80:192.168.1.1:255.255.255.0:beagleboard:et<br>
        h0:off root=/dev/nfs rw
        nfsroot=192.168.1.80:/home/Bob/NFSROOT,nolock,rsize=1024,wsize=1024
        rootwait<br>
        PID hash table entries: 1024 (order: 10, 4096 bytes)<br>
        Dentry cache hash table entries: 32768 (order: 5, 131072 bytes)<br>
        Inode-cache hash table entries: 16384 (order: 4, 65536 bytes)<br>
        Memory: 128MB 128MB = 256MB total<br>
        Memory: 255488KB available (3548K code, 412K data, 136K init, 0K
        highmem)<br>
        NR_IRQS:402<br>
        Clocking rate (Crystal/Core/MPU): 26.0/332/500 MHz<br>
        Reprogramming SDRC clock to 332000000 Hz<br>
        GPMC revision 5.0<br>
        IRQ: Found an INTC at 0xd8200000 (revision 4.0) with 96
        interrupts<br>
        Total of 96 interrupts on 1 active controller<br>
        OMAP34xx GPIO hardware version 2.5<br>
        OMAP clockevent source: GPTIMER1 at 13000000 Hz<br>
        I-pipe 1.16-01: pipeline enabled.<br>
        Console: colour dummy device 80x30<br>
        Calibrating delay loop... 498.07 BogoMIPS (lpj=2490368)<br>
        Mount-cache hash table entries: 512<br>
        CPU: Testing write buffer coherency: ok<br>
        regulator: core version 0.5<br>
        NET: Registered protocol family 16<br>
        Found NAND on CS0<br>
        Registering NAND on CS0<br>
        OMAP DMA hardware revision 4.0<br>
        bio: create slab &lt;bio-0&gt; at 0<br>
        i2c_omap i2c_omap.1: bus 1 rev3.12 at 2600 kHz<br>
        twl4030: PIH (irq 7) chaining IRQs 368..375<br>
        twl4030: power (irq 373) chaining IRQs 376..383<br>
        twl4030: gpio (irq 368) chaining IRQs 384..401<br>
        regulator: VMMC1: 1850 &lt;--&gt; 3150 mV normal standby<br>
        regulator: VDAC: 1800 mV normal standby<br>
        regulator: VUSB1V5: 1500 mV normal standby<br>
        regulator: VUSB1V8: 1800 mV normal standby<br>
        regulator: VUSB3V1: 3100 mV normal standby<br>
        regulator: VPLL2: 1800 mV normal standby<br>
        regulator: VSIM: 1800 &lt;--&gt; 3000 mV normal standby<br>
        i2c_omap i2c_omap.3: bus 3 rev3.12 at 100 kHz<br>
        SCSI subsystem initialized<br>
        twl4030_usb twl4030_usb: Initialized TWL4030 USB module<br>
        usbcore: registered new interface driver usbfs<br>
        usbcore: registered new interface driver hub<br>
        usbcore: registered new device driver usb<br>
        musb_hdrc: version 6.0, musb-dma, otg (peripheral+host), debug=0<br>
        musb_hdrc: USB OTG mode controller at d80ab000 using DMA, IRQ 92<br>
        NET: Registered protocol family 2<br>
        IP route cache hash table entries: 2048 (order: 1, 8192 bytes)<br>
        TCP established hash table entries: 8192 (order: 4, 65536 bytes)<br>
        TCP bind hash table entries: 8192 (order: 3, 32768 bytes)<br>
        TCP: Hash tables configured (established 8192 bind 8192)<br>
        TCP reno registered<br>
        NET: Registered protocol family 1<br>
        I-pipe: Domain Xenomai registered.<br>
        Xenomai: hal/arm started.<br>
        Xenomai: scheduling class idle registered.<br>
        Xenomai: scheduling class rt registered.<br>
        Xenomai: real-time nucleus v2.5.3 (Hordes Of Locusts) loaded.<br>
        Xenomai: starting native API services.<br>
        Xenomai: starting POSIX services.<br>
        Xenomai: starting RTDM services.<br>
        VFS: Disk quotas dquot_6.5.2<br>
        Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)<br>
        JFFS2 version 2.2. (NAND) ï¿½Â© 2001-2006 Red Hat, Inc.<br>
        msgmni has been set to 499<br>
        alg: No test for stdrng (krng)<br>
        Block layer SCSI generic (bsg) driver version 0.4 loaded (major
        253)<br>
        io scheduler noop registered<br>
        io scheduler anticipatory registered (default)<br>
        io scheduler deadline registered<br>
        io scheduler cfq registered<br>
        Serial: 8250/16550 driver, 4 ports, IRQ sharing enabled<br>
        serial8250.0: ttyS0 at MMIO 0x4806a000 (irq = 72) is a ST16654<br>
        serial8250.1: ttyS1 at MMIO 0x4806c000 (irq = 73) is a ST16654<br>
        serial8250.2: ttyS2 at MMIO 0x49020000 (irq = 74) is a ST16654<br>
        console [ttyS2] enabled<br>
        brd: module loaded<br>
        loop: module loaded<br>
        i2c /dev entries driver<br>
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
        usb usb1: New USB device found, idVendor=1d6b, idProduct=0002<br>
        usb usb1: New USB device strings: Mfr=3, Product=2,
        SerialNumber=1<br>
        usb usb1: Product: OMAP-EHCI Host Controller<br>
        usb usb1: Manufacturer: Linux 2.6.31-omap1 ehci_hcd<br>
        usb usb1: SerialNumber: ehci-omap.0<br>
        usb usb1: configuration #1 chosen from 1 choice<br>
        hub 1-0:1.0: USB hub found<br>
        hub 1-0:1.0: 3 ports detected<br>
        g_ether gadget: using random self ethernet address<br>
        g_ether gadget: using random host ethernet address<br>
        usb0: MAC 36:3c:3a:f5:b5:ed<br>
        usb0: HOST MAC ce:32:fc:bb:54:f2<br>
        g_ether gadget: Ethernet Gadget, version: Memorial Day 2008<br>
        g_ether gadget: g_ether ready<br>
        musb_hdrc musb_hdrc: MUSB HDRC host driver<br>
        musb_hdrc musb_hdrc: new USB bus registered, assigned bus number
        2<br>
        usb usb2: New USB device found, idVendor=1d6b, idProduct=0002<br>
        usb usb2: New USB device strings: Mfr=3, Product=2,
        SerialNumber=1<br>
        usb usb2: Product: MUSB HDRC host driver<br>
        usb usb2: Manufacturer: Linux 2.6.31-omap1 musb-hcd<br>
        usb usb2: SerialNumber: musb_hdrc<br>
        usb usb2: configuration #1 chosen from 1 choice<br>
        hub 2-0:1.0: USB hub found<br>
        hub 2-0:1.0: 1 port detected<br>
        mmci-omap-hs mmci-omap-hs.0: Failed to get debounce clock<br>
        TCP cubic registered<br>
        NET: Registered protocol family 17<br>
        NET: Registered protocol family 15<br>
        RPC: Registered udp transport module.<br>
        RPC: Registered tcp transport module.<br>
        Power Management for TI OMAP3.<br>
        VFP support v0.3: implementor 41 architecture 3 part 30 variant
        c rev 1<br>
        regulator_init_complete: incomplete constraints, leaving VDVI on<br>
        regulator_init_complete: incomplete constraints, leaving VDAC on<br>
        drivers/rtc/hctosys.c: unable to open rtc device (rtc0)<br>
        usb 1-2: new high speed USB device using ehci-omap and address 2<br>
        mmc0: new high speed SD card at address dd7b<br>
        mmcblk0: mmc0:dd7b SD02G 1.87 GiB <br>
         mmcblk0: p1 p2<br>
        usb 1-2: New USB device found, idVendor=0b95, idProduct=7720<br>
        usb 1-2: New USB device strings: Mfr=1, Product=2,
        SerialNumber=3<br>
        usb 1-2: Product: AX88772 <br>
        usb 1-2: Manufacturer: ASIX Elec. Corp.<br>
        usb 1-2: SerialNumber: 000001<br>
        usb 1-2: configuration #1 chosen from 1 choice<br>
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
        Freeing init memory: 136K<br>
        INIT: version 2.86 booting<br>
        Please wait: booting...<br>
        Starting udev<br>
        EXT2-fs warning (device mmcblk0p2): ext2_fill_super: mounting
        ext3 filesystem as ext2<br>
        Remounting root file system...<br>
        Caching udev devnodes<br>
        Populating dev cache<br>
        root: mount: mounting rootfs on / failed: No such file or
        directory<br>
        NOT configuring network interfaces: / is an NFS mount<br>
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
AAAAB3NzaC1yc2EAAAADAQABAAAAgwCyuGR5NlHYDfmcD6+zGcZ6PKDReZKrofcLvBt3gMLNTnH55vAvOf+xvuWsPQCjBjEs/6EqSV1z/<br>
        CvhafTDQcEHvyPf6NRLAdeYF8IT8JIwZQZXUOVazcY0uL3xsfBeGKOdt9XKTc4JOD/xrZhFixKETXKC1ZY0CLA7h+su1N6NufHH
        root@domain.hid<br>
        ard<br>
        Fingerprint: md5 87:48:4b:38:af:ed:85:7f:0f:c3:49:17:96:1a:14:6d<br>
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
        root@domain.hid:~# df <br>
        Filesystem           1K-blocks      Used Available Use% Mounted
        on<br>
        /dev/root             15868228   8777056   6930152  56% /<br>
        none                    127896       132    127764   0% /dev<br>
        /dev/mmcblk0p1          197676      2190    195487   1%
        /media/mmcblk0p1<br>
        /dev/mmcblk0p2         1731460     35396   1608112   2%
        /media/mmcblk0p2<br>
        tmpfs                   127896        16    127880   0%
        /var/volatile<br>
        tmpfs                   127896         0    127896   0% /dev/shm<br>
        tmpfs                   127896         0    127896   0%
        /media/ram<br>
        root@domain.hid:~# cat /proc/interrupts<br>
                   CPU0<br>
          7:          2        INTC  TWL4030-PIH<br>
         11:          0        INTC  prcm<br>
         12:       3238        INTC  DMA<br>
         37:       1833        INTC  gp timer<br>
         56:        273        INTC  i2c_omap<br>
         61:          0        INTC  i2c_omap<br>
         72:          1        INTC  serial idle<br>
         73:          1        INTC  serial idle<br>
         74:        188        INTC  serial idle, serial<br>
         77:      13354        INTC  ehci_hcd:usb1<br>
         83:       6343        INTC  mmc0<br>
         92:          1        INTC  musb_hdrc<br>
         93:          0        INTC  musb_hdrc<br>
        378:          2     twl4030  twl4030_usb<br>
        384:          0     twl4030  mmc0<br>
        Err:          0<br>
        root@domain.hid:~# umount /dev/mmcblk0p1<br>
        root@domain.hid:~# umount /dev/mmcblk0p2<br>
        root@domain.hid:~# <br>
        root@domain.hid:~# # removing SD card <br>
        root@domain.hid:~# <br>
        root@domain.hid:~# mmc0: card dd7b removed<br>
        <br>
        root@domain.hid:~# cat /proc/interrupts<br>
                   CPU0<br>
          7:          3        INTC  TWL4030-PIH<br>
         11:          0        INTC  prcm<br>
         12:       3245        INTC  DMA<br>
         37:       2575        INTC  gp timer<br>
         56:        294        INTC  i2c_omap<br>
         61:          0        INTC  i2c_omap<br>
         72:          1        INTC  serial idle<br>
         73:          1        INTC  serial idle<br>
         74:        321        INTC  serial idle, serial<br>
         77:      14305        INTC  ehci_hcd:usb1<br>
         83:       6599        INTC  mmc0<br>
         92:          1        INTC  musb_hdrc<br>
         93:          0        INTC  musb_hdrc<br>
        378:          2     twl4030  twl4030_usb<br>
        384:          1     twl4030  mmc0<br>
        Err:          0<br>
        root@domain.hid:~# df<br>
        Filesystem           1K-blocks      Used Available Use% Mounted
        on<br>
        /dev/root             15868228   8777056   6930152  56% /<br>
        none                    127896       120    127776   0% /dev<br>
        tmpfs                   127896        16    127880   0%
        /var/volatile<br>
        tmpfs                   127896         0    127896   0% /dev/shm<br>
        tmpfs                   127896         0    127896   0%
        /media/ram<br>
        root@domain.hid:~# <br>
        root@domain.hid:~# # inserting SD card<br>
        root@domain.hid:~# <br>
        root@domain.hid:~# mmc0: new high speed SD card at address dd7b<br>
        mmcblk0: mmc0:dd7b SD02G 1.87 GiB <br>
         mmcblk0: p1 p2<br>
        EXT2-fs warning (device mmcblk0p2): ext2_fill_super: mounting
        ext3 filesystem as ext2<br>
        <br>
        root@domain.hid:~# df<br>
        Filesystem           1K-blocks      Used Available Use% Mounted
        on<br>
        /dev/root             15868228   8777056   6930152  56% /<br>
        none                    127896       132    127764   0% /dev<br>
        tmpfs                   127896        16    127880   0%
        /var/volatile<br>
        tmpfs                   127896         0    127896   0% /dev/shm<br>
        tmpfs                   127896         0    127896   0%
        /media/ram<br>
        /dev/mmcblk0p2         1731460     35396   1608112   2%
        /media/mmcblk0p2<br>
        /dev/mmcblk0p1          197676      2190    195487   1%
        /media/mmcblk0p1<br>
        root@domain.hid:~# cat /proc/interrupts<br>
                   CPU0<br>
          7:          4        INTC  TWL4030-PIH<br>
         11:          0        INTC  prcm<br>
         12:       6482        INTC  DMA<br>
         37:       3246        INTC  gp timer<br>
         56:        317        INTC  i2c_omap<br>
         61:          0        INTC  i2c_omap<br>
         72:          1        INTC  serial idle<br>
         73:          1        INTC  serial idle<br>
         74:        463        INTC  serial idle, serial<br>
         77:      15483        INTC  ehci_hcd:usb1<br>
         83:      12938        INTC  mmc0<br>
         92:          1        INTC  musb_hdrc<br>
         93:          0        INTC  musb_hdrc<br>
        378:          2     twl4030  twl4030_usb<br>
        384:          2     twl4030  mmc0<br>
        Err:          0<br>
      </tt></small><br>
    Note that twl_4030_usb interrupts are being passed too.<br>
    Thanks Gilles. Great job!<br>
    Regards,<br>
    Bob feretich<br>
    <br>
    On 7/25/2010 2:24 AM, Gilles Chanteperdrix wrote:
    <blockquote cite="mid:4C4C02BC.4010306@domain.hid" type="cite">
      <pre wrap="">Bob Feretich wrote:
</pre>
      <blockquote type="cite">
        <pre wrap="">  Test 1 results:
With the Adeos patch installed, but Adeos disabled, the system ran 
normally. IRQ 384s were presented and serviced.  (The SD card removal 
amd insertion was handled correctly.)
</pre>
      </blockquote>
      <pre wrap="">
Ok. Could you try the following patch? It fixes the "always growing PIH 
interrupt count" number here, and now I have some twl4030_usb 
interrupts. However, I could not test the SD card insertion/removal, 
because I am working on the board remotely.

diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
index 8d608a1..0037e31 100644
--- a/drivers/i2c/busses/i2c-omap.c
+++ b/drivers/i2c/busses/i2c-omap.c
@@ -478,10 +478,6 @@ static int omap_i2c_xfer_msg(struct i2c_adapter *adap,
 	if (msg-&gt;len == 0)
 		return -EINVAL;
 
-#ifdef CONFIG_IPIPE
-	disable_irq(dev-&gt;irq);
-#endif /* CONFIG_IPIPE */
-
 	omap_i2c_write_reg(dev, OMAP_I2C_SA_REG, msg-&gt;addr);
 
 	/* REVISIT: Could the STB bit of I2C_CON be used with probing? */
@@ -525,9 +521,6 @@ static int omap_i2c_xfer_msg(struct i2c_adapter *adap,
 
 			/* Let the user know if i2c is in a bad state */
 			if (time_after(jiffies, delay)) {
-#ifdef CONFIG_IPIPE
-				enable_irq(dev-&gt;irq);
-#endif /* CONFIG_IPIPE */
 				dev_err(dev-&gt;dev, "controller timed out "
 				"waiting for start condition to finish\n");
 				return -ETIMEDOUT;
@@ -539,9 +532,6 @@ static int omap_i2c_xfer_msg(struct i2c_adapter *adap,
 		w &amp;= ~OMAP_I2C_CON_STT;
 		omap_i2c_write_reg(dev, OMAP_I2C_CON_REG, w);
 	}
-#ifdef CONFIG_IPIPE
-	enable_irq(dev-&gt;irq);
-#endif /* CONFIG_IPIPE */
 
 	/*
 	 * REVISIT: We should abort the transfer on signals, but the bus goes
diff --git a/drivers/mfd/twl4030-irq.c b/drivers/mfd/twl4030-irq.c
index 9df9a5a..fb4b9f2 100644
--- a/drivers/mfd/twl4030-irq.c
+++ b/drivers/mfd/twl4030-irq.c
@@ -332,7 +332,7 @@ static int twl4030_irq_thread(void *data)
 					note_interrupt(module_irq, d,
 							IRQ_NONE);
 				else
-					d-&gt;handle_irq(module_irq, d);
+					ipipe_handle_irq_cond(module_irq);
 			}
 		}
 		local_irq_enable();

</pre>
    </blockquote>
  </body>
</html>

--------------070306090603050605080609--

