MIME-Version: 1.0
In-Reply-To: <20170503112429.3c8092a4@md1em3qc>
References: <CADXNiGUww369efOQDe+BvgVyAi3FrakikgTfiPU8Ys7xDpOnnA@mail.gmail.com>
 <20170502112039.54c4ae04@md1em3qc> <20170502112329.1b4ef22a@md1em3qc>
 <CADXNiGX-djx=SXt3e_eojpGahVeSe47R9o3Dk6REYH5TFwqRhw@mail.gmail.com>
 <20170503112429.3c8092a4@md1em3qc>
From: Jackson Jones <jackson.jones@gmail.com>
Date: Wed, 3 May 2017 17:04:52 -0700
Message-ID: <CADXNiGVfb3vxOvNDfKRkuDKbWsHkYp-TSrop0A5uaQYDX3Bo-w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai] Cpusets and the cpu_affinity test
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Henning Schild <henning.schild@siemens.com>, xenomai@xenomai.org

Henning,
I was able to get the cpu_affinity test to run. I modified the source code
of the test so that it just starts the test on CPU0 and uses 1 -3 for the
xenomai tasks.

I did make one discovery which might be considered a bug. When I first ran
it, it was trying to schedule more core than it had. I had removed the
=E2=80=9Cxenomai.supported_cpus=E2=80=9D parameter. It turns out that that =
it is needed (at
least with this kernel).

The /proc/xenomai/affinity does contain 0000000f, but the
/sys/module/xenomai/parameters/supported_cpus contained a very large
integer. When I put the boot param back in, the value was set to 15 (as it
should be).

What clued me into this was when I added a trace to print out the value of
CPU_SETSIZE. With the parameter it is very large. Below is a patch I made
so we can run the cpu_affinity test (until the boot parameter issue is
sorted out). I don=E2=80=99t think the patch will be useful for anyone else=
:

----------------------------------------------------------------------

diff -Naur -d
xenomai-3.0.3-orig/testsuite/smokey/cpu-affinity/cpu-affinity.c
xenomai-3.0.3/testsuite/smokey/cpu-affinity/cpu-affinity.c
--- xenomai-3.0.3-orig/testsuite/smokey/cpu-affinity/cpu-affinity.c
2016-08-26 12:06:04.000000000 -0700
+++ xenomai-3.0.3/testsuite/smokey/cpu-affinity/cpu-affinity.c
2017-05-03 15:44:52.605696600 -0700
@@ -206,10 +206,12 @@
      * any online CPU), pretend that we have no kernel support for
      * running this test.
      */
+#if 0
     if (cpu < 0) {
         smokey_trace("no CPU restriction with xenomai.supported_cpus");
         return -ENOSYS;
     }
+#endif

     pthread_attr_init(&thattr);
     param.sched_priority =3D 0;
@@ -220,7 +222,9 @@

     context.kfd =3D -1;
     context.status =3D 0;
-    context.nrt_cpu =3D cpu;
+    // RJJ We set the starting core to 0 since we can't pass an incomplete
mask
+    //context.nrt_cpu =3D cpu;
+    context.nrt_cpu =3D 0;
     /*
      * Start a regular pthread for running the tests, to bypass
      * sanity checks Cobalt does on CPU affinity. We actually want

----------------------------------------------------------------------


To answer your question, no we don=E2=80=99t need to take any of the proces=
sors
offline, people above me just wanted that test to run.

I turned on earlyprink and this is the output I get when I set the
supported_cpu=3D0x7:

----------------------------------------------------------------------

=3D> setenv videoargs 'if hdmidet; then setenv bootargs ${bootargs}
video=3Dmxcfb0:dev=3Dhdmi,1024x768M@60,if=3DRGB24; else setenv bootargs
${bootargs} video=3Dmxcfb0:dev=3Dldb,bpp=3D32; fi; setenv bootargs
earlyprintk=3Dserial,ttymxc0,115200,keep xenomai.supported_cpus=3D0x7
${bootargs} vmalloc=3D400M fbmem=3D32M fbcon=3D32M gpumem=3D32M
galcore.contiguousSize=3D201326592 galcore.contiguousBase=3D0x00000000
video=3Dmxcfb1:off video=3Dmxcfb2:off video=3Dmxcfb3:off;'
=3D> saveenv
Saving Environment to MMC...
Writing to MMC(0)... done
=3D> boot
switch to partitions #0, OK
mmc0 is current device
reading boot.scr
** Unable to read file boot.scr **
reading uImage
5666200 bytes read in 282 ms (19.2 MiB/s)
Booting from mmc ...
reading imx6q-var-som-lvds1.dtb
42595 bytes read in 22 ms (1.8 MiB/s)
## Booting kernel from Legacy Image at 12000000 ...
   Image Name:   Linux-4.1.15
   Image Type:   ARM Linux Kernel Image (uncompressed)
   Data Size:    5666136 Bytes =3D 5.4 MiB
   Load Address: 10008000
   Entry Point:  10008000
   Verifying Checksum ... OK
## Flattened Device Tree blob at 18000000
   Booting using the fdt blob at 0x18000000
   Loading Kernel Image ... OK
   Using Device Tree in place at 18000000, end 1800d662
switch to ldo_bypass mode!

Starting kernel ...

console [ttymxc0] enabled
bootconsole [earlycon0] disabled
21e8000.serial: ttymxc1 at MMIO 0x21e8000 (irq =3D 303, base_baud =3D 50000=
00)
is a IMX
21ec000.serial: ttymxc2 at MMIO 0x21ec000 (irq =3D 304, base_baud =3D 50000=
00)
is a IMX
imx sema4 driver is registered.
[drm] Initialized drm 1.1.0 20060810
[drm] Initialized vivante 1.0.0 20120216 on minor 0
brd: module loaded
loop: module loaded
ahci-imx 2200000.sata: fsl,transmit-level-mV not specified, using 00000024
ahci-imx 2200000.sata: fsl,transmit-boost-mdB not specified, using 00000480
ahci-imx 2200000.sata: fsl,transmit-atten-16ths not specified, using
00002000
ahci-imx 2200000.sata: fsl,receive-eq-mdB not specified, using 05000000
ahci-imx 2200000.sata: SSS flag set, parallel bus scan disabled
ahci-imx 2200000.sata: AHCI 0001.0300 32 slots 1 ports 3 Gbps 0x1 impl
platform mode
ahci-imx 2200000.sata: flags: ncq sntf stag pm led clo only pmp pio slum
part ccc apst
scsi host0: ahci-imx
ata1: SATA max UDMA/133 mmio [mem 0x02200000-0x02203fff] port 0x100 irq 314
nand: device found, Manufacturer ID: 0x2c, Chip ID: 0xdc
nand: Micron MT29F4G08ABADAWP
nand: 512 MiB, SLC, erase size: 128 KiB, page size: 2048, OOB size: 64
gpmi-nand 112000.gpmi-nand: enable the asynchronous EDO mode 5
Scanning device for bad blocks
ata1: SATA link down (SStatus 0 SControl 300)
ahci-imx 2200000.sata: no device found, disabling link.
ahci-imx 2200000.sata: pass ahci_imx..hotplug=3D1 to enable hotplug
random: nonblocking pool is initialized
4 ofpart partitions found on MTD device gpmi-nand
Creating 4 MTD partitions on "gpmi-nand":
0x000000000000-0x000000200000 : "spl"
0x000000200000-0x000000400000 : "bootloader"
0x000000400000-0x000000c00000 : "kernel"
0x000000c00000-0x000040000000 : "rootfs"
mtd: partition "rootfs" extends beyond the end of device "gpmi-nand" --
size truncated to 0x1f400000
gpmi-nand 112000.gpmi-nand: driver registered.
spi_imx 2008000.ecspi: probed
spi_imx 2010000.ecspi: probed
CAN device driver interface
2090000.flexcan supply xceiver not found, using dummy regulator
flexcan 2090000.flexcan: device registered (reg_base=3De7190000, irq=3D34)
2188000.ethernet supply phy not found, using dummy regulator
pps pps0: new PPS source ptp0
libphy: fec_enet_mii_bus: probed
fec 2188000.ethernet eth0: registered PHC device 0
ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
ehci-pci: EHCI PCI platform driver
ehci-mxc: Freescale On-Chip EHCI Host driver
usbcore: registered new interface driver usb-storage
usbcore: registered new interface driver usbserial
usbcore: registered new interface driver usbserial_generic
usbserial: USB Serial support registered for generic
usbcore: registered new interface driver usb_ehset_test
2184800.usbmisc supply vbus-wakeup not found, using dummy regulator
ci_hdrc ci_hdrc.0: EHCI Host Controller
ci_hdrc ci_hdrc.0: new USB bus registered, assigned bus number 1
ci_hdrc ci_hdrc.0: USB 2.0 started, EHCI 1.00
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 1 port detected
ci_hdrc ci_hdrc.1: EHCI Host Controller
ci_hdrc ci_hdrc.1: new USB bus registered, assigned bus number 2
ci_hdrc ci_hdrc.1: USB 2.0 started, EHCI 1.00
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 1 port detected
mousedev: PS/2 mouse device common for all mice
edt_ft5x06 2-0038: touchscreen probe failed
edt_ft5x06: probe of 2-0038 failed with error -5
rtc-ds1307 2-0068: rtc core: registered ds1307 as rtc0
rtc-ds1307 2-0068: 56 bytes nvram
snvs_rtc 20cc000.snvs:snvs-rtc-lp: rtc core: registered 20cc000.snvs:snvs-r
as rtc1
i2c /dev entries driver
imx2-wdt 20bc000.wdog: timeout 60 sec (nowayout=3D0)
sdhci: Secure Digital Host Controller Interface driver
sdhci: Copyright(c) Pierre Ossman
sdhci-pltfm: SDHCI platform and OF driver helper
/soc/aips-bus@02100000/usdhc@02190000: voltage-ranges unspecified
sdhci-esdhc-imx 2190000.usdhc: could not get ultra high speed state, work
on normal mode
sdhci-esdhc-imx 2190000.usdhc: No vmmc regulator found
sdhci-esdhc-imx 2190000.usdhc: No vqmmc regulator found
mmc0: SDHCI controller on 2190000.usdhc [2190000.usdhc] using ADMA
/soc/aips-bus@02100000/usdhc@02194000: voltage-ranges unspecified
sdhci-esdhc-imx 2194000.usdhc: Got CD GPIO
sdhci-esdhc-imx 2194000.usdhc: Got WP GPIO
sdhci-esdhc-imx 2194000.usdhc: No vmmc regulator found
sdhci-esdhc-imx 2194000.usdhc: No vqmmc regulator found
mmc1: SDHCI controller on 2194000.usdhc [2194000.usdhc] using ADMA
mmc0: MAN_BKOPS_EN bit is not set
/soc/aips-bus@02100000/usdhc@02198000: voltage-ranges unspecified
sdhci-esdhc-imx 2198000.usdhc: No vqmmc regulator found
mmc0: new DDR MMC card at address 0001
mmcblk0: mmc0:0001 8GND3R 7.28 GiB
mmcblk0boot0: mmc0:0001 8GND3R partition 1 4.00 MiB
mmcblk0boot1: mmc0:0001 8GND3R partition 2 4.00 MiB
mmcblk0rpmb: mmc0:0001 8GND3R partition 3 512 KiB
 mmcblk0: p1
mmc1: new high speed SDXC card at address aaaa
mmcblk1: mmc1:aaaa SL64G 59.4 GiB
 mmcblk1: p1 p2
usb 2-1: new high-speed USB device number 2 using ci_hdrc
mmc2: SDHCI controller on 2198000.usdhc [2198000.usdhc] using ADMA
mxc_vpu 2040000.vpu_fsl: VPU initialized
mxc_vdoa 21e4000.vdoa: i.MX Video Data Order Adapter(VDOA) driver probed
sdhci-esdhc-imx 2198000.usdhc: card claims to support voltages below
defined range
mxc_hdmi_cec soc:hdmi_cec@00120000: HDMI CEC initialized
mmc2: queuing unknown CIS tuple 0x91 (3 bytes)
caam 2100000.caam: Entropy delay =3D 3200
mmc2: new high speed SDIO card at address 0001
caam 2100000.caam: Instantiated RNG4 SH0
hub 2-1:1.0: USB hub found
hub 2-1:1.0: 4 ports detected
caam 2100000.caam: Instantiated RNG4 SH1
caam 2100000.caam: device ID =3D 0x0a16010000000000 (Era -524)
caam 2100000.caam: job rings =3D 2, qi =3D 0
caam algorithms registered in /proc/crypto
caam_jr 2101000.jr0: registering rng-caam
usbcore: registered new interface driver usbhid
usbhid: USB HID core driver
RT-Socket-CAN 0.90.2 - (C) 2006 RT-Socket-CAN Development Team
Error: Driver 'flexcan' is already registered, aborting...
Analogy: MITE: Available NI device IDs:
fsl-asrc 2034000.asrc: driver registered
imx-tlv320aic3x sound: tlv320aic3x-hifi <-> 202c000.ssi mapping ok
imx-audio-hdmi sound-hdmi: hdmi-hifi <-> soc:hdmi_audio@00120000 mapping ok
NET: Registered protocol family 26
Netfilter messages via NETLINK v0.30.
nfnl_acct: registering with nfnetlink.
nf_conntrack version 0.5.0 (16384 buckets, 65536 max)
ctnetlink v0.93: registering with nfnetlink.
nf_tables: (c) 2007-2009 Patrick McHardy <kaber@trash.net>
NET: Registered protocol family 10
sit: IPv6 over IPv4 tunneling driver
NET: Registered protocol family 17
can: controller area network core (rev 20120528 abi 9)
NET: Registered protocol family 29
can: raw protocol (rev 20120528)
can: broadcast manager protocol (rev 20120528 t)
can: netlink gateway (rev 20130117) max_hops=3D1
8021q: 802.1Q VLAN Support v1.8
Key type dns_resolver registered
usb 2-1.1: new high-speed USB device number 3 using ci_hdrc
hub 2-1.1:1.0: USB hub found
hub 2-1.1:1.0: 7 ports detected
imx6q-pcie 1ffc000.pcie: phy link never came up
imx6q-pcie 1ffc000.pcie: failed to initialize host
imx6q-pcie: probe of 1ffc000.pcie failed with error -22
rtc-ds1307 2-0068: setting system clock to 2017-05-03 23:40:01 UTC
(1493854801)
SW4: disabling
wlan-en-regulator: disabling
ALSA device list:
  #0: tlv320aic3x-audio
  #1: imx-hdmi-soc
EXT4-fs (mmcblk1p2): couldn't mount as ext3 due to feature incompatibilitie=
s
EXT4-fs (mmcblk1p2): couldn't mount as ext2 due to feature incompatibilitie=
s
EXT4-fs (mmcblk1p2): mounted filesystem with ordered data mode. Opts: (null=
)
VFS: Mounted root (ext4 filesystem) on device 179:34.
usb 2-1.1.6: new low-speed USB device number 4 using ci_hdrc
devtmpfs: mounted
Freeing unused kernel memory: 492K (80953000 - 809ce000)
input: Dell Dell USB Optical Mouse as
/devices/soc0/soc/2100000.aips-bus/2184200.usb/ci_hdrc.1/usb2/2-1/2-1.1/2-1=
.1.6/2-1.1.6:1.0/0003:413C:3012.0001/input/input1
hid-generic 0003:413C:3012.0001: input: USB HID v1.11 Mouse [Dell Dell USB
Optical Mouse] on usb-ci_hdrc.1-1.1.6/input0
usb 2-1.1.1: new full-speed USB device number 5 using ci_hdrc
systemd[1]: Failed to insert module 'kdbus': Function not implemented
input: eGalax Inc. eGalaxTouch EXC3000-1478-46.00.00 as
/devices/soc0/soc/2100000.aips-bus/2184200.usb/ci_hdrc.1/usb2/2-1/2-1.1/2-1=
.1.1/2-1.1.1:1.0/0003:0EEF:C000.0002/input/input2
hid-multitouch 0003:0EEF:C000.0002: input: USB HID v2.10 Pointer [eGalax
Inc. eGalaxTouch EXC3000-1478-46.00.00] on usb-ci_hdrc.1-1.1.1/input0

Welcome to Debian GNU/Linux 8 (jessie)!

usb 2-1.1.5: new low-speed USB device number 6 using ci_hdrc
input: Dell Dell USB Keyboard as
/devices/soc0/soc/2100000.aips-bus/2184200.usb/ci_hdrc.1/usb2/2-1/2-1.1/2-1=
.1.5/2-1.1.5:1.0/0003:413C:2003.0003/input/input4
proc-sys-fs-binfmt_misc.automount: Cannot add dependency job, ignoring:
Unit proc-sys-fs-binfmt_misc.automount is masked.
gpsd.socket: Cannot add dependency job, ignoring: Unit gpsd.socket is
masked.
binfmt-support.service: Cannot add dependency job, ignoring: Unit
binfmt-support.servichid-generic 0003:413C:2003.0003: input: USB HID v1.10
Keyboard [Dell Dell USB Keyboard] on usb-ci_hdrc.1-1.1.5/input0
e is masked.
gpsd.service: Cannot add dependency job, ignoring: Unit gpsd.service is
masked.
[  OK  ] Listening on Journal Socket (/dev/log).
[  OK  ] Listening on /dev/initctl Compatibility Named Pipe.
[  OK  ] Created slice System Slice.
[  OK  ] Created slice system-serial\x2dgetty.slice.
[  OK  ] Listening on udev Kernel Socket.
[  OK  ] Listening on Syslog Socket.
[  OK  ] Reached target Remote File Systems (Pre).
[  OK  ] Reached target Remote File Systems.
[  OK  ] Reached target Swap.
[  OK  ] Listening on Journal Socket.
         Starting Load Kernel Modules...
         Starting Nameserver information manager...
         Mounting POSIX Message Queue File System...
         Starting Journal Service...
[  OK  ] Created slice system-getty.slice.
         Mounting Debug File System...
         Starting LSB: Prepare console...
[  OK  ] Listening on udev Control Socket.
         Starting Create list of required st... nodes for the current
kernel...
[  OK  ] Created slice User and Session Slice.
[  OK  ] Reached target Slices.
[  OK  ] Started Forward Password Requests to Wall Directory Watch.
[  OK  ] Reached target Encrypted Volumes.
[  OK  ] Started Load Kernel Modules.
         Mounting FUSE Control File System...
         Starting Apply Kernel Variables...
[  OK  ] Started Create list of required sta...ce nodes for the current
kernel.
         Starting Create Static Device Nodes in /dev...
[  OK  ] Started Apply Kernel Variables.
[  OK  ] Mounted POSIX Message Queue File System.
[  OK  ] Mounted FUSE Control File System.
[  OK  ] Mounted Debug File System.
[  OK  ] Started Create Static Device Nodes in /dev.
         Starting udev Kernel Device Manager...
[  OK  ] Started Nameserver information manager.
[  OK  ] Started Journal Service.
[  OK  ] Started LSB: Prepare console.
         Starting LSB: Set console font and keymap...
[  OK  ] Started udev Kernel Device Manager.
         Starting LSB: Set preliminary keymap...
[  OK  ] Started LSB: Set preliminary keymap.
         Starting Remount Root and Kernel File Systems...
[  OK  ] Started Remount Root and Kernel File Systems.
         Starting Load/Save Random Seed...
[  OK  ] Reached target Local File Systems (Pre).
[  OK  ] Reached target Local File Systems.
         Starting Tell Plymouth To Write Out Runtime Data...
         Starting Raise network interfaces...
         Starting udev Coldplug all Devices...
         Starting Flush Journal to Persistent Storage...
[  OK  ] Started LSB: Set console font and keymap.
[  OK  ] Started Load/Save Random Seed.
[  OK  ] Started Tell Plymouth To Write Out Runtime Data.
systemd-journald[190]: Received request to flush runtime journal from PID 1
[  OK  ] Started Flush Journal to Persistent Storage.
         Starting Create Volatile Files and Directories...
[  OK  ] Started Create Volatile Files and Directories.
         Starting Update UTMP about System Boot/Shutdown...
[  OK  ] Reached target System Time Synchronized.
[  OK  ] Started Update UTMP about System Boot/Shutdown.
INFO: rcu_sched detected stalls on CPUs/tasks:
        3: (0 ticks this GP) idle=3Dcc8/0/0 softirq=3D13/13 fqs=3D0
        (detected by 1, t=3D2102 jiffies, g=3D-296, c=3D-297, q=3D23)
Task dump for CPU 3:
swapper/3       R running      0     0      1 0x00000000
[<80690be8>] (__schedule) from [<8007f1d4>] (rcu_idle_enter+0xa0/0xa8)
[<8007f1d4>] (rcu_idle_enter) from [<8006a714>]
(cpu_startup_entry+0x138/0x1d4)
[<8006a714>] (cpu_startup_entry) from [<1000976c>] (0x1000976c)
rcu_sched kthread starved for 2106 jiffies!
INFO: rcu_sched detected stalls on CPUs/tasks:
        3: (0 ticks this GP) idle=3D410/0/0 softirq=3D13/13 fqs=3D1
        (detected by 2, t=3D8407 jiffies, g=3D-296, c=3D-297, q=3D23)
Task dump for CPU 3:
swapper/3       R running      0     0      1 0x00000000
[<80690be8>] (__schedule) from [<8007f1d4>] (rcu_idle_enter+0xa0/0xa8)
[<8007f1d4>] (rcu_idle_enter) from [<8006a714>]
(cpu_startup_entry+0x138/0x1d4)
[<8006a714>] (cpu_startup_entry) from [<1000976c>] (0x1000976c)
rcu_sched kthread starved for 6305 jiffies!
INFO: rcu_sched detected stalls on CPUs/tasks:
        3: (0 ticks this GP) idle=3D414/0/0 softirq=3D13/13 fqs=3D0
        (detected by 2, t=3D2102 jiffies, g=3D-295, c=3D-296, q=3D22)
Task dump for CPU 3:
swapper/3       R running      0     0      1 0x00000000
[<80690be8>] (__schedule) from [<8007f1d4>] (rcu_idle_enter+0xa0/0xa8)
[<8007f1d4>] (rcu_idle_enter) from [<8006a714>]
(cpu_startup_entry+0x138/0x1d4)
[<8006a714>] (cpu_startup_entry) from [<1000976c>] (0x1000976c)
rcu_sched kthread starved for 2106 jiffies!

----------------------------------------------------------------------

As an experiment I set the parameter to 0xe (1110) (which would exclude
core0 to see if the same problem happened on that core. I got no output
after the =E2=80=9CStarting kernel ...=E2=80=9D. I tried 0xb (1011) and got=
 the same
result. Putting in 0xd (1101) yielded a little output:

Starting kernel ...

console [ttymxc0] enabled
bootconsole [earlycon0] disabled
21e8000.serial: ttymxc1 at MMIO 0x21e8000 (irq =3D 303, base_baud =3D 50000=
00)
is a IMX
21ec000.serial: ttymxc2 at MMIO 0x21ec000 (irq =3D 304, base_baud =3D 50000=
00)
is a IMX
imx sema4 driver is registered.
[drm] Initialized drm 1.1.0 20060810
[drm] Initialized vivante 1.0.0 20120216 on minor 0
brd: module loaded
loop: module loaded
ahci-imx 2200000.sata: fsl,transmit-level-mV not specified, using 00000024
ahci-imx 2200000.sata: fsl,transmit-boost-mdB not specified, using 00000480
ahci-imx 2200000.sata: fsl,transmit-atten-16ths not specified, using
00002000
ahci-imx 2200000.sata: fsl,receive-eq-mdB not specified, using 05000000

I repeated 0x7 to be sure, but I got the same result as above, it gave the
most output. Trying 9 (1001) and 1 (0001), yielded no kernel output.

Let me know if there is anything else you want me to try or any other
information you need, I am happy to help.

Thanks,

Jackson

Jackson Jones
Senior Project Software Engineer

Stellartech Research Corporation
560 Cottonwood Dr.
Milpitas, CA 95035

work: 408-331-3159
cell: 408-835-5334
Email: jjones@stellartec.com
Home Email: jackson.jones@gmail.com
