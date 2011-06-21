Message-ID: <4E0053F1.2020206@domain.hid>
Date: Tue, 21 Jun 2011 01:18:57 -0700
From: David Wiebe <dwiebe2@domain.hid>
MIME-Version: 1.0
References: <4DF9CA75.1040903@domain.hid>	<4DF9DCE3.70703@domain.hid>		<BANLkTinki=NqJ1f1vyGNBMHLZuwiCtrmMw@domain.hid>		<4DFBA463.3090902@domain.hid>	<4DFBAEB9.8060106@domain.hid>		<4DFBB08B.5020005@domain.hid>	<4DFCC18F.3060207@domain.hid>		<BANLkTin00xA-LMikumq1C4_nFyFbCdgi+Q@mail.gmail.com>		<4DFF610F.5070602@domain.hid>	<4DFF664C.5030504@domain.hid>	<1308586589.2119.10.camel@domain.hid>	<4DFF84C0.6010008@domain.hid>
	<4DFFBBDB.4030703@domain.hid> <4DFFCFBC.6080703@domain.hid>
	<4E004038.2010704@domain.hid>
In-Reply-To: <4E004038.2010704@domain.hid>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
Subject: Re: [Xenomai-help] Xenomai beagleboard xm ethernet not working
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

On 11-06-20 11:54 PM, Gilles Chanteperdrix wrote:
> On 06/21/2011 12:54 AM, David Wiebe wrote:
>> Hello,
>>
>> I haven't been able to get the ethernet to work with linux 2.6.35.9
>> patched with Xenomai. I've been in menuconfig turning on anything and
>> everything related to networking and usb and still nothing.
> If you disable CONFIG_XENOMAI and CONFIG_IPIPE in the kernel
> configuration, does ethernet work?
>
Hi Gilles,

I've got the usb ethernet interface up. I can ping it from my pc. The 
beagleboard hangs. I'm investigating. I've used the usb ethernet adaptor 
successfully many times with the bbc4 so I doubt its the problem.

Here's the serial output dump

*** Warning - bad CRC, using default environment

In:    serial
Out:   serial
Err:   serial
Beagle Rev C4
timed out in wait_for_pin: I2C_STAT=0
No EEPROM on expansion board
Die ID #5484000400000000040373050d00801d
Hit any key to stop autoboot:  0
reading boot.scr

** Unable to read "boot.scr" from mmc 0:1 **
reading uImage

2272764 bytes read
Booting from mmc ...
## Booting kernel from Legacy Image at 82000000 ...
    Image Name:   Linux-2.6.35.9-ipipe
    Image Type:   ARM Linux Kernel Image (uncompressed)
    Data Size:    2272700 Bytes = 2.2 MiB
    Load Address: 80008000
    Entry Point:  80008000
    Verifying Checksum ... OK
    Loading Kernel Image ... OK
OK

Starting kernel ...

Uncompressing Linux... done, booting the kernel.
Linux version 2.6.35.9-ipipe (david@domain.hid) 
(gc1
CPU: ARMv7 Processor [411fc083] revision 3 (ARMv7), cr=10c53c7f
CPU: VIPT nonaliasing data cache, VIPT nonaliasing instruction ca
Memory policy: ECC disabled, Data cache writeback
OMAP3430/3530 ES3.1 (l2cache iva sgx neon isp )
SRAM: Mapped pa 0x40200000 to va 0xfe400000 size: 0x100000r, mobility 
groupi4
Kernel command line: console=ttyS2,115200n8 mpurate=720 vram=12M 
omapfb.modet
PID hash table entries: 1024 (order: 0, 4096 bytes)
Dentry cache hash table entries: 32768 (order: 5, 131072 bytes)
Inode-cache hash table entries: 16384 (order: 4, 65536 bytes)
Memory: 128MB 128MB = 256MB total
Memory: 255148k/255148k available, 6996k reserved, 0K highmem
Virtual kernel memory layout:
     vector  : 0xffff0000 - 0xffff1000   (   4 kB)
     fixmap  : 0xfff00000 - 0xfffe0000   ( 896 kB)
     DMA     : 0xffc00000 - 0xffe00000   (   2 MB)
     vmalloc : 0xd0800000 - 0xf8000000   ( 632 MB)
     lowmem  : 0xc0000000 - 0xd0000000   ( 256 MB)
     modules : 0xbf000000 - 0xc0000000   (  16 MB)
       .init : 0xc0008000 - 0xc0029000   ( 132 kB)
       .text : 0xc0029000 - 0xc0411000   (4000 kB)
       .data : 0xc042c000 - 0xc0466d80   ( 236 kB)
Hierarchical RCU implementation.
         Verbose stalled-CPUs detection is disabled.
NR_IRQS:402
Clocking rate (Crystal/Core/MPU): 26.0/332/500 MHz
omap_hwmod: l3_hwmod: cannot be enabled (3)
omap_hwmod: l4_core_hwmod: cannot be enabled (3)
omap_hwmod: l4_per_hwmod: cannot be enabled (3)
omap_hwmod: l4_wkup_hwmod: cannot be enabled (3)
Reprogramming SDRC clock to 332000000 Hz
GPMC revision 5.0
IRQ: Found an INTC at 0xfa200000 (revision 4.0) with 96 interrupts
Total of 96 interrupts on 1 active controller
OMAP GPIO hardware version 2.5
OMAP clockevent source: GPTIMER2 at 13000000 Hz
I-pipe, 13.000 MHz clocksource
I-pipe 1.18-01: pipeline enabled.
Console: colour dummy device 80x30
Calibrating delay loop... 498.07 BogoMIPS (lpj=2490368)
pid_max: default: 32768 minimum: 301
Mount-cache hash table entries: 512
CPU: Testing write buffer coherency: ok
regulator: core version 0.5
NET: Registered protocol family 16
Using McSPI for SPI
Found NAND on CS0
Registering NAND on CS0
Unable to get DVI reset GPIO
Switched to new clocking rate (Crystal/Core/MPU): 26.0/720/332 MHz
OMAP DMA hardware revision 4.0
bio: create slab <bio-0> at 0
SCSI subsystem initialized
usbcore: registered new interface driver usbfs
usbcore: registered new interface driver hub
usbcore: registered n2c_omap.1: bus 1 rev3.12 at 2600 kHz
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
Switching to clocksource ipipe_tsc
musb_hdrc: version 6.0, musb-dma, otg (peripheral+host), debug=0
musb_hdrc musb_hdrc: USB OTG mode controller at fa0ab000 using DMA, IRQ 92
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
NetWinder Floating Point Emulator V0.97 (double precision)
I-pipe: Domain Xenomai registered.
Xenomai: hal/arm started.
Xenomai: scheduling class idle registered.
Xenomai: scheduling class rt registered.
Xenomai: real-time nucleus v2.5.6 (Wormhole Wizards) loaded.
Xenomai: starting native API services.
Xenomai: starting POSIX services.
Xenomai: starting RTDM services.
VFS: Disk quotas dquot_6.5.2
Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)
JFFS2 version 2.2. (NAND) �© 2001-2006 Red Hat, Inc.
msgmni has been set to 498
alg: No test for stdrng (krng)
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
usbcore: registered new interface driver catc
catc: v2.8:CATC EL1210A NetMate USB Ethernet driver
usbcore: registered new interface driver kaweth
pegasus: v0.6.14 (2006/09/27), Pegasus/Pegasus II USB Ethernet driver
usbcore: registered new interface driver pegasus
rtl8150: v0.6.2 (2004/08/27):rtl8150 based usb-ethernet driver
usbcore: registered new interface driver rtl8150
usbcore: registered new interface driver asix
usbcore: registered new interface driver cdc_ether
usbcore: registered new interface driver cdc_eem
usbcore: registered new interface driver dm9601
usbcore: registered new interface driver smsc75xx
usbcore: registered new interface driver smsc95xx
usbcore: registered new interface driver gl620a
usbcore: registered new interface driver net1080
usbcore: registered new interface driver plusb
usbcore: registered new interface driver rndis_host
usbcore: registered new interface driver cdc_subset
usbcore: registered new interface driver zaurus
usbcore: registered new interface driver MOSCHIP usb-ethernet driver
usbmon: deb USB 2.0 'Enhanced' Host Controller (EHCI) Driver
ehci-omap ehci-omap.0: OMAP-EHCI Host Controller
ehci-omap ehci-omap.0: new USB bus registered, assigned bus number 1
ehci-omap ehci-omap.0: irq 77, io mem 0x48064800
ehci-omap ehci-omap.0: USB 2.0 started, EHCI 1.00
usb usb1: New USB device found, idVendor=1d6b, idProduct=0002
usb usb1: New USB device strings: Mfr=3, Product=2, SerialNumber=1
usb usb1: Product: OMAP-EHCI Host Controller
usb usb1: Manufacturer: Linux 2.6.35.9-ipipe ehci_hcd
usb usb1: SerialNumber: ehci-omap.0
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 3 ports detected
Initializing USB Mass Storage driver...
usbcore: registered new interface driver usb-storage
USB Mass Storage support registered.
i2c /dev entries driver
TCP cubic registered
NET: Registered protocol family 17
NET: Registered protocol family 15
Power Management for TI OMAP3.
VFP support v0.3: implementor 41 architecture 3 part 30 variant c rev 1
regulator_init_complete: incomplete constraints, leaving VDVI on
regulator_init_complete: incomplete constraints, leaving VDAC on
Waiting for root device /dev/mmcblk0p2...
usb 1-2: new high speed USB device using ehci-omap and address 2
mmc0: new high speed SDHC card at address fde5
mmcblk0: mmc0:fde5 SD04G 3.69 GiB
  mmcblk0: p1 p2
EXT3-fs: barriers not enabled
kjournald starting.  Commit interval 5 seconds
EXT3-fs (mmcblk0p2): warning: maximal mount count reached, running 
e2fsck isd
EXT3-fs (mmcblk0p2): using internal journal
EXT3-fs (mmcblk0p2): mounted filesystem with writeback data mode
VFS: Mounted root (ext3 filesystem) on device 179:2.
Freeing init memory: 132K
usb 1-2: New USB device found, idVendor=0b95, idProduct=7720
usb 1-2: New USB device strings: Mfr=1, Product=2, SerialNumber=3
usb 1-2: Product: AX88772
usb 1-2: Manufacturer: ASIX Elec. Corp.
usb 1-2: SerialNumber: 000001
INIT: version 2.86 booting
Please wait: booting...
Starting udev
Illegal instruction
asix 1-2:1.0: eth0: register 'asix' at usb-ehci-omap.0-2, ASIX AX88772 
USB 2a
Remounting root file system...
Caching udev devnodes
Populating dev cache
ALSA: Restoring mixer settings...
Configuring network interfaces... /usr/sbin/alsactl: load_state:1610: No 
sou.
eth0: link up, 100Mbps, full-duplex, lpa 0x41E1
udhcpc (v1.13.2) started
run-parts: /etc/udhcpc.d/00avahi-autoipd exited with code 1
Sending discover...
Sending select for 192.168.0.101...
Lease of 192.168.0.101 obtained, lease time 10800
run-parts: /etc/udhcpc.d/00avahi-autoipd exited with code 1
adding dns 192.168.0.1
ifconfig: SIOCGIFFLAGS: No such device
done.
Starting portmap daemon: portmap.
portmap: fork: No such deviceeth0: link up, 100Mbps, full-duplex, lpa 0x41E1
net.ipv4.conf.default.rp_filter = 1
net.ipv4.conf.all.rp_filter = 1
hwclock: can't open '/dev/misc/rtc': No such file or directory


