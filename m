From: =?iso-8859-1?Q?Terje_Fr=F8ysa?= <Terje.Froysa@sintef.no>
Date: Tue, 11 Nov 2014 13:31:33 +0000
Message-ID: <314E5ECDAA86314791309FA670550F89C676CD2D@SINTEFEXMBX05.sintef.no>
Content-Language: en-US
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: [Xenomai] xeno_16550A driver install problems.
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "Xenomai@xenomai.org" <Xenomai@xenomai.org>

Dear forum,

I have struggled for 4 days and I am out of ideas/suggestions on how to mak=
e this xeno_16550A driver work.

I have successfully installed the Xenomai 2.6.4 and the Debian 3.8.13.
Self-developed RTDM driver is working satisfactory.
But installing the xeno_16550A driver (kernel install) is giving me a heada=
che.

First a fight to find the correct syntax for the uEnv.txt kernel parameters=
 (example show setting of only one parameter):
cmdline=3Dxeno_16550A.mem=3D0x48022001,0x48024000,0x481a6000,0x481a8000,0x4=
81aa000 \
        xeno_16550A.irq=3D73,74,44,45,46 \
        xeno_16550A.baud_base=3D115200,115200,115200,115200,115200 \
        xeno_16550A.tx_fifo=3D64,64,64,64,64 \
        xeno_16550A.start_index=3D1
The kernel parameters is correctly stored in the /sys/module/xeno_16550A/pa=
rameters.
The Debian boots as long as the irq=3D0,0,0,0,0

BUT, at the moment I specify correct irq numbers, the boot-process crashes =
(see boot-log below).

I have disabled the CONFIG_SERIAL_OMAP without result.
I have disabled the serial8250 driver that occupies the ttySx UARTS, but th=
e kernel still crashes as soon as the irq is set <> 0.


Please advise.
Best regards
Terje Froysa

Boot log:

U-Boot SPL 2014.04-00014-g47880f5 (Apr 22 2014 - 13:23:54)
reading args
spl_load_image_fat_os: error reading image args, err - -1
reading u-boot.img
reading u-boot.img


U-Boot 2014.04-00014-g47880f5 (Apr 22 2014 - 13:23:54)

I2C:   ready
DRAM:  512 MiB
NAND:  0 MiB
MMC:   OMAP SD/MMC: 0, OMAP SD/MMC: 1
*** Warning - readenv() failed, using default environment

Net:   <ethaddr> not set. Validating first E-fuse MAC
cpsw, usb_ether
Hit any key to stop autoboot:  0
gpio: pin 53 (gpio 53) value is 1
mmc0 is current device
gpio: pin 54 (gpio 54) value is 1
SD/MMC found on device 0
reading uEnv.txt
760 bytes read in 6 ms (123 KiB/s)
gpio: pin 55 (gpio 55) value is 1
Loaded environment from uEnv.txt
Importing environment from mmc ...
Checking if uenvcmd is set ...
gpio: pin 56 (gpio 56) value is 1
Running uenvcmd ...
2428 bytes read in 105 ms (22.5 KiB/s)
5874704 bytes read in 405 ms (13.8 MiB/s)
2866282 bytes read in 274 ms (10 MiB/s)
26098 bytes read in 115 ms (220.7 KiB/s)
Kernel image @ 0x82000000 [ 0x000000 - 0x59a410 ]
## Flattened Device Tree blob at 88000000
   Booting using the fdt blob at 0x88000000
   Loading Ramdisk to 9f36d000, end 9f628c6a ... OK
   Using Device Tree in place at 88000000, end 880095f1

Starting kernel ...

Uncompressing Linux... done, booting the kernel.
[    0.000000] Booting Linux on physical CPU 0x0
[    0.000000] Initializing cgroup subsys cpu
[    0.000000] Linux version 3.8.13-bone67 (debian@beaglebone) (gcc version=
 4.6.3 (Debian 4.6.3-14) ) #2 SMP Tue Oct 28 15:34:54 UTC 2014
[    0.000000] CPU: ARMv7 Processor [413fc082] revision 2 (ARMv7), cr=3D50c=
5387d
[    0.000000] CPU: PIPT / VIPT nonaliasing data cache, VIPT aliasing instr=
uction cache
[    0.000000] Machine: Generic AM33XX (Flattened Device Tree), model: TI A=
M335x BeagleBone
[    0.000000] Memory policy: ECC disabled, Data cache writeback
[    0.000000] AM335X ES2.1 (l2cache sgx neon )
[    0.000000] PERCPU: Embedded 11 pages/cpu @c0e29000 s23616 r8192 d13248 =
u45056
[    0.000000] Built 1 zonelists in Zone order, mobility grouping on.  Tota=
l pages: 129792
[    0.000000] Kernel command line: console=3Dtty0 console=3DttyO0,115200n8=
 capemgr.disable_partno=3DBB-BONELT-HDMI,BB-BONELT-HDMIN capemgr.enable_par=
tno=3DBB-SPIDEV1 root=3D/dev/mmcblk0p2 rootfstype=3Dext4 rootwait xeno_1655=
0A.mem=3D0x48022001,0x48024000,0x481a6000,0x481a8000,0x481aa000 xeno_16550A=
.irq=3D73,74,44,45,46 xeno_16550A.baud_base=3D115200,115200,115200,115200,1=
15200 xeno_16550A.tx_fifo=3D64,64,64,64,64 xeno_16550A.start_index=3D1
[    0.000000] PID hash table entries: 2048 (order: 1, 8192 bytes)
[    0.000000] Dentry cache hash table entries: 65536 (order: 6, 262144 byt=
es)
[    0.000000] Inode-cache hash table entries: 32768 (order: 5, 131072 byte=
s)
[    0.000000] __ex_table already sorted, skipping sort
[    0.000000] allocated 1048576 bytes of page_cgroup
[    0.000000] please try 'cgroup_disable=3Dmemory' option if you don't wan=
t memory cgroups
[    0.000000] Memory: 511MB =3D 511MB total
[    0.000000] Memory: 504464k/504464k available, 19824k reserved, 0K highm=
em
[    0.000000] Virtual kernel memory layout:
[    0.000000]     vector  : 0xffff0000 - 0xffff1000   (   4 kB)
[    0.000000]     fixmap  : 0xfff00000 - 0xfffe0000   ( 896 kB)
[    0.000000]     vmalloc : 0xe0800000 - 0xff000000   ( 488 MB)
[    0.000000]     lowmem  : 0xc0000000 - 0xe0000000   ( 512 MB)
[    0.000000]     pkmap   : 0xbfe00000 - 0xc0000000   (   2 MB)
[    0.000000]     modules : 0xbf800000 - 0xbfe00000   (   6 MB)
[    0.000000]       .text : 0xc0008000 - 0xc08687f4   (8578 kB)
[    0.000000]       .init : 0xc0869000 - 0xc08aec40   ( 280 kB)
[    0.000000]       .data : 0xc08b0000 - 0xc0938600   ( 546 kB)
[    0.000000]        .bss : 0xc0938600 - 0xc0a18a80   ( 898 kB)
[    0.000000] Hierarchical RCU implementation.
[    0.000000]  RCU restricting CPUs from NR_CPUS=3D4 to nr_cpu_ids=3D1.
[    0.000000] NR_IRQS:0 nr_irqs:0 0
[    0.000000] IRQ: Found an INTC at 0xfa200000 (revision 5.0) with 128 int=
errupts
[    0.000000] Total of 128 interrupts on 1 active controller
[    0.000000] OMAP clockevent source: GPTIMER1 at 24000000 Hz
[    0.000000] sched_clock: 32 bits at 24MHz, resolution 41ns, wraps every =
178956ms
[    0.000000] I-pipe, 24.000 MHz clocksource
[    0.000000] OMAP clocksource: GPTIMER2 at 24000000 Hz
[    0.000000] Interrupt pipeline (release #4)
[    0.000000] Console: colour dummy device 80x30
[    0.000000] console [tty0] enabled
[    0.001245] Calibrating delay loop... 993.47 BogoMIPS (lpj=3D969728)
[    0.029185] pid_max: default: 32768 minimum: 301
[    0.029341] Security Framework initialized
[    0.029410] Mount-cache hash table entries: 512
[    0.035691] Initializing cgroup subsys cpuacct
[    0.035740] Initializing cgroup subsys memory
[    0.035790] Initializing cgroup subsys blkio
[    0.035890] CPU: Testing write buffer coherency: ok
[    0.036295] CPU0: thread -1, cpu 0, socket -1, mpidr 0
[    0.036365] Setting up static identity map for 0x80537700 - 0x8053774c
[    0.037425] Brought up 1 CPUs
[    0.037453] SMP: Total of 1 processors activated (993.47 BogoMIPS).
[    0.038411] devtmpfs: initialized
[    0.047740] omap_hwmod: wd_timer2: _wait_target_disable failed
[    0.100030] pinctrl core: initialized pinctrl subsystem
[    0.100189] rstctl core: initialized rstctl subsystem
[    0.100495] regulator-dummy: no parameters
[    0.100809] NET: Registered protocol family 16
[    0.101582] DMA: preallocated 256 KiB pool for atomic coherent allocatio=
ns
[    0.107418] pinctrl-single 44e10800.pinmux: 142 pins at pa f9e10800 size=
 568
[    0.108025] platform 49000000.edma: alias fck already exists
[    0.108055] platform 49000000.edma: alias fck already exists
[    0.108077] platform 49000000.edma: alias fck already exists
[    0.108822] OMAP GPIO hardware version 0.1
[    0.111521] gpio-rctrl rstctl.4: loaded OK
[    0.114965] No ATAGs?
[    0.114988] hw-breakpoint: debug architecture 0x4 unsupported.
[    0.116336] cpsw.0: No hwaddr in dt. Using d0:39:72:44:f1:35 from efuse
[    0.116375] cpsw.1: No hwaddr in dt. Using d0:39:72:44:f1:37 from efuse
[    0.125804] bio: create slab <bio-0> at 0
[    0.132328] edma-dma-engine edma-dma-engine.0: TI EDMA DMA engine driver
[    0.132649] vmmcsd_fixed: 3300 mV
[    0.134308] SCSI subsystem initialized
[    0.134584] usbcore: registered new interface driver usbfs
[    0.134712] usbcore: registered new interface driver hub
[    0.134915] usbcore: registered new device driver usb
[    0.136167] omap_i2c 44e0b000.i2c: bus 0 rev0.11 at 400 kHz
[    0.137231] input: tps65217_pwr_but as /devices/ocp.3/44e0b000.i2c/i2c-0=
/0-0024/input/input0
[    0.138578] DCDC1: at 1500 mV
[    0.139466] vdd_mpu: 925 <--> 1325 mV at 1325 mV
[    0.140310] vdd_core: 925 <--> 1150 mV at 1125 mV
[    0.141203] LDO1: at 1800 mV
[    0.142034] LDO2: at 3300 mV
[    0.143633] LDO3: 1800 mV
[    0.144519] LDO4: at 3300 mV
[    0.145284] tps65217 0-0024: TPS65217 ID 0xe version 1.2
[    0.145762] omap_i2c 44e0b000.i2c: unable to select pin group
[    0.146273] omap_i2c 4819c000.i2c: bus 1 rev0.11 at 100 kHz
[    0.147771] omap_i2c 4819c000.i2c: unable to select pin group
[    0.147942] media: Linux media interface: v0.10
[    0.148025] Linux video capture interface: v2.00
[    0.148104] pps_core: LinuxPPS API ver. 1 registered
[    0.148121] pps_core: Software ver. 5.3.6 - Copyright 2005-2007 Rodolfo =
Giometti <giometti@linux.it>
[    0.148633] Advanced Linux Sound Architecture Driver Initialized.
[    0.149257] NetLabel: Initializing
[    0.149281] NetLabel:  domain hash size =3D 128
[    0.149293] NetLabel:  protocols =3D UNLABELED CIPSOv4
[    0.149372] NetLabel:  unlabeled traffic allowed by default
[    0.149738] Switching to clocksource ipipe_tsc
[    0.182826] NET: Registered protocol family 2
[    0.183568] TCP established hash table entries: 4096 (order: 3, 32768 by=
tes)
[    0.183665] TCP bind hash table entries: 4096 (order: 4, 81920 bytes)
[    0.183756] TCP: Hash tables configured (established 4096 bind 4096)
[    0.183833] TCP: reno registered
[    0.183854] UDP hash table entries: 256 (order: 1, 12288 bytes)
[    0.183887] UDP-Lite hash table entries: 256 (order: 1, 12288 bytes)
[    0.184139] NET: Registered protocol family 1
[    0.184563] RPC: Registered named UNIX socket transport module.
[    0.184591] RPC: Registered udp transport module.
[    0.184606] RPC: Registered tcp transport module.
[    0.184620] RPC: Registered tcp NFSv4.1 backchannel transport module.
[    0.184870] Trying to unpack rootfs image as initramfs...
[    0.383130] Freeing initrd memory: 2796K
[    0.383647] hw perfevents: enabled with ARMv7 Cortex-A8 PMU driver, 5 co=
unters available
[    0.383937] CPU PMU: attempt to register multiple PMU devices!
[    0.383969] arm-pmu: probe of arm-pmu failed with error -28
[    0.384385] omap2_mbox_probe: platform not supported
[    0.543108] I-pipe: head domain Xenomai registered.
[    0.543167] Xenomai: hal/arm started.
[    0.544239] Xenomai: scheduling class idle registered.
[    0.544288] Xenomai: scheduling class rt registered.
[    0.548687] Xenomai: real-time nucleus v2.6.4 (Jumpin' Out) loaded.
[    0.548709] Xenomai: debug mode enabled.
[    0.549114] Xenomai: starting native API services.
[    0.549136] Xenomai: starting POSIX services.
[    0.549279] Xenomai: starting RTDM services.
[    0.550165] VFS: Disk quotas dquot_6.5.2
[    0.550437] Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)
[    0.551243] NFS: Registering the id_resolver key type
[    0.551331] Key type id_resolver registered
[    0.551348] Key type id_legacy registered
[    0.551612] fuse init (API version 7.20)
[    0.552030] Btrfs loaded
[    0.552252] msgmni has been set to 990
[    0.553965] Block layer SCSI generic (bsg) driver version 0.4 loaded (ma=
jor 249)
[    0.554005] io scheduler noop registered
[    0.554020] io scheduler deadline registered
[    0.554062] io scheduler cfq registered (default)
[    0.555258] tps65217-bl tps65217-bl: no platform data provided
[    0.555301] tps65217-bl: probe of tps65217-bl failed with error -22
[    0.555836] Serial: 8250/16550 driver, 4 ports, IRQ sharing enabled
[    0.557255] omap_uart 44e09000.serial: did not get pins for uart0 error:=
 -19
[    0.557562] 44e09000.serial: ttyO0 at MMIO 0x44e09000 (irq =3D 72) is a =
OMAP UART0
[    1.390704] console [ttyO0] enabled
[    1.395070] [drm] Initialized drm 1.1.0 20060810
[    1.407517] brd: module loaded
[    1.414853] loop: module loaded
[    1.418264] at24 0-0050: 32768 byte 24c256 EEPROM, writable, 1 bytes/wri=
te
[    1.425515] at24 1-0054: 32768 byte 24c256 EEPROM, writable, 1 bytes/wri=
te
[    1.432757] at24 1-0055: 32768 byte 24c256 EEPROM, writable, 1 bytes/wri=
te
[    1.439996] at24 1-0056: 32768 byte 24c256 EEPROM, writable, 1 bytes/wri=
te
[    1.447224] at24 1-0057: 32768 byte 24c256 EEPROM, writable, 1 bytes/wri=
te
[    1.461156] bone-capemgr bone_capemgr.9: Baseboard: 'A335BNLT,00A5,5002B=
BBK3600'
[    1.468931] bone-capemgr bone_capemgr.9: compatible-baseboard=3Dti,beagl=
ebone-black
[    1.476804] bone-capemgr bone_capemgr.9: Skipping disabled cape with par=
t# BB-BONELT-HDMI
[    1.485414] bone-capemgr bone_capemgr.9: Skipping disabled cape with par=
t# BB-BONELT-HDMIN
[    1.524838] bone-capemgr bone_capemgr.9: slot #0: No cape found
[    1.561944] bone-capemgr bone_capemgr.9: slot #1: No cape found
[    1.599053] bone-capemgr bone_capemgr.9: slot #2: No cape found
[    1.636163] bone-capemgr bone_capemgr.9: slot #3: No cape found
[    1.642392] bone-capemgr bone_capemgr.9: slot #4: specific override
[    1.648975] bone-capemgr bone_capemgr.9: bone: Using override eeprom dat=
a at slot 4
[    1.656992] bone-capemgr bone_capemgr.9: slot #4: 'Bone-LT-eMMC-2G,00A0,=
Texas Instrument,BB-BONE-EMMC-2G'
[    1.667072] bone-capemgr bone_capemgr.9: slot #5: specific override
[    1.673651] bone-capemgr bone_capemgr.9: bone: Using override eeprom dat=
a at slot 5
[    1.681666] bone-capemgr bone_capemgr.9: slot #5: 'Bone-Black-HDMI,00A0,=
Texas Instrument,BB-BONELT-HDMI'
[    1.691651] bone-capemgr bone_capemgr.9: slot #6: specific override
[    1.698229] bone-capemgr bone_capemgr.9: bone: Using override eeprom dat=
a at slot 6
[    1.706259] bone-capemgr bone_capemgr.9: slot #6: 'Bone-Black-HDMIN,00A0=
,Texas Instrument,BB-BONELT-HDMIN'
[    1.716439] bone-capemgr bone_capemgr.9: enabled_partno part_number 'BB-=
SPIDEV1', version 'N/A', prio '0'
[    1.726454] bone-capemgr bone_capemgr.9: slot #7: generic override
[    1.732927] bone-capemgr bone_capemgr.9: bone: Using override eeprom dat=
a at slot 7
[    1.740954] bone-capemgr bone_capemgr.9: slot #7: 'Override Board Name,0=
0A0,Override Manuf,BB-SPIDEV1'
[    1.750859] bone-capemgr bone_capemgr.9: Skipping loading of disabled ca=
pe with part# BB-BONELT-HDMI
[    1.760426] bone-capemgr bone_capemgr.9: Skipping loading of disabled ca=
pe with part# BB-BONELT-HDMIN
[    1.770256] bone-capemgr bone_capemgr.9: loader: before slot-4 BB-BONE-E=
MMC-2G:00A0 (prio 1)
[    1.779113] bone-capemgr bone_capemgr.9: loader: check slot-4 BB-BONE-EM=
MC-2G:00A0 (prio 1)
[    1.787888] bone-capemgr bone_capemgr.9: initialized OK.
[    1.793470] bone-capemgr bone_capemgr.9: loader: before slot-7 BB-SPIDEV=
1:00A0 (prio 0)
[    1.801855] bone-capemgr bone_capemgr.9: loader: check slot-7 BB-SPIDEV1=
:00A0 (prio 0)
[    1.811576] OneNAND driver initializing
[    1.816521] usbcore: registered new interface driver cdc_ether
[    1.822707] usbcore: registered new interface driver rndis_host
[    1.828980] bone-capemgr bone_capemgr.9: loader: check slot-4 BB-BONE-EM=
MC-2G:00A0 (prio 1)
[    1.837745] bone-capemgr bone_capemgr.9: loader: after slot-7 BB-SPIDEV1=
:00A0 (prio 0)
[    1.846100] usbcore: registered new interface driver cdc_ncm
[    1.852059] bone-capemgr bone_capemgr.9: slot #7: Requesting part number=
/version based 'BB-SPIDEV1-00A0.dtbo
[    1.862872] usbcore: registered new interface driver cdc_acm
[    1.868818] cdc_acm: USB Abstract Control Model driver for USB modems an=
d ISDN adapters
[    1.877198] Initializing USB Mass Storage driver...
[    1.882324] bone-capemgr bone_capemgr.9: slot #7: Requesting firmware 'B=
B-SPIDEV1-00A0.dtbo' for board-name 'Override Board Name', version '00A0'
[    1.896017] usbcore: registered new interface driver usb-storage
[    1.902306] USB Mass Storage support registered.
[    1.907180] bone-capemgr bone_capemgr.9: slot #7: dtbo 'BB-SPIDEV1-00A0.=
dtbo' loaded; converting to live tree
[    1.917678] musb-hdrc: version 6.0, ?dma?, otg (peripheral+host)
[    1.924153] bone-capemgr bone_capemgr.9: slot #7: #2 overlays
[    1.930439] musb-hdrc musb-hdrc.0.auto: pdev->id =3D 0
[    1.935692] musb-hdrc musb-hdrc.0.auto: drivers/usb/musb/musb_dsps.c:480=
 dsps_musb_init: OK
[    1.952723] edma-dma-engine edma-dma-engine.0: allocated channel for 0:4=
5
[    1.960102] musb-hdrc musb-hdrc.0.auto: *** mode=3D3
[    1.965164] musb-hdrc musb-hdrc.0.auto: *** power=3D250
[    1.970530] edma-dma-engine edma-dma-engine.0: allocated channel for 0:4=
4
[    1.978250] musb-hdrc musb-hdrc.1.auto: pdev->id =3D 1
[    1.983492] musb-hdrc musb-hdrc.1.auto: drivers/usb/musb/musb_dsps.c:480=
 dsps_musb_init: OK
[    1.992868] musb-hdrc musb-hdrc.1.auto: *** mode=3D1
[    1.997930] musb-hdrc musb-hdrc.1.auto: *** power=3D250
[    2.003256] musb-hdrc musb-hdrc.1.auto: MUSB HDRC host driver
[    2.015872] edma-dma-engine edma-dma-engine.0: allocated channel for 0:4=
3
[    2.023420] musb-hdrc musb-hdrc.1.auto: new USB bus registered, assigned=
 bus number 1
[    2.031758] edma-dma-engine edma-dma-engine.0: allocated channel for 0:4=
2
[    2.039067] usb usb1: New USB device found, idVendor=3D1d6b, idProduct=
=3D0002
[    2.046187] usb usb1: New USB device strings: Mfr=3D3, Product=3D2, Seri=
alNumber=3D1
[    2.053754] usb usb1: Product: MUSB HDRC host driver
[    2.058955] usb usb1: Manufacturer: Linux 3.8.13-bone67 musb-hcd
[    2.065244] usb usb1: SerialNumber: musb-hdrc.1.auto
[    2.071383] bone-capemgr bone_capemgr.9: slot #7: Applied #2 overlays.
[    2.078290] bone-capemgr bone_capemgr.9: loader: done slot-7 BB-SPIDEV1:=
00A0 (prio 0)
[    2.086526] bone-capemgr bone_capemgr.9: loader: check slot-4 BB-BONE-EM=
MC-2G:00A0 (prio 1)
[    2.095918] hub 1-0:1.0: USB hub found
[    2.099989] hub 1-0:1.0: 1 port detected
[    2.105065] mousedev: PS/2 mouse device common for all mice
[    2.110940] bone-capemgr bone_capemgr.9: loader: after slot-4 BB-BONE-EM=
MC-2G:00A0 (prio 1)
[    2.121437] omap_rtc 44e3e000.rtc: rtc core: registered 44e3e000.rtc as =
rtc0
[    2.128946] bone-capemgr bone_capemgr.9: slot #4: Requesting firmware 'c=
ape-bone-2g-emmc1.dtbo' for board-name 'Bone-LT-eMMC-2G', version '00A0'
[    2.142548] 44e3e000.rtc: already running
[    2.146962] i2c /dev entries driver
[    2.151666] pps_ldisc: PPS line discipline registered
[    2.157032] bone-capemgr bone_capemgr.9: slot #4: dtbo 'cape-bone-2g-emm=
c1.dtbo' loaded; converting to live tree
[    2.167801] Driver for 1-wire Dallas network protocol.
[    2.174441] omap_wdt: OMAP Watchdog Timer Rev 0x01: initial timeout 60 s=
ec
[    2.181927] bone-capemgr bone_capemgr.9: slot #4: #2 overlays
[    2.188454] device-mapper: ioctl: 4.23.1-ioctl (2012-12-18) initialised:=
 dm-devel@redhat.com
[    2.197958] bone-capemgr bone_capemgr.9: slot #4: Applied #2 overlays.
[    2.204887] bone-capemgr bone_capemgr.9: loader: done slot-4 BB-BONE-EMM=
C-2G:00A0 (prio 1)
[    2.214366] omap_hsmmc mmc.5: of_parse_phandle_with_args of 'reset' fail=
ed
[    2.221587] omap_hsmmc mmc.5: Failed to get rstctl; not using any
[    2.228267] edma-dma-engine edma-dma-engine.0: allocated channel for 0:2=
5
[    2.235474] edma-dma-engine edma-dma-engine.0: allocated channel for 0:2=
4
[    2.242765] mmc.5 supply vmmc_aux not found, using dummy regulator
[    2.249657] omap_hsmmc mmc.5: pins are not configured from the driver
[    2.282910] gpio-rctrl rstctl.4: gpio_rctrl_request eMMC_RSTn
[    2.289077] omap_hsmmc mmc.11: Got rstctl (gpio:#0 name eMMC_RSTn) label=
:eMMC_RSTn
[    2.297058] gpio-rctrl rstctl.4: gpio_rctrl_deassert eMMC_RSTn
[    2.303398] edma-dma-engine edma-dma-engine.0: allocated channel for 0:3
[    2.310492] edma-dma-engine edma-dma-engine.0: allocated channel for 0:2
[    2.317939] mmc.11 supply vmmc_aux not found, using dummy regulator
[    2.324604] omap_hsmmc mmc.11: pins are not configured from the driver
[    2.359100] pinctrl-single 44e10800.pinmux: pin 44e10854 already request=
ed by 44e10800.pinmux; cannot claim for gpio-leds.8
[    2.370780] pinctrl-single 44e10800.pinmux: pin-21 (gpio-leds.8) status =
-22
[    2.378073] pinctrl-single 44e10800.pinmux: could not request pin 21 on =
device pinctrl-single
[    2.387020] leds-gpio gpio-leds.8: pins are not configured from the driv=
er
[    2.394993] ledtrig-cpu: registered to indicate activity on CPUs
[    2.401596] edma-dma-engine edma-dma-engine.0: allocated channel for 0:3=
6
[    2.408817] omap-sham 53100000.sham: hw accel on OMAP rev 4.3
[    2.416329] omap-aes 53500000.aes: OMAP AES hw accel rev: 3.2
[    2.422593] edma-dma-engine edma-dma-engine.0: allocated channel for 0:5
[    2.429760] edma-dma-engine edma-dma-engine.0: allocated channel for 0:6
[    2.439868] usbcore: registered new interface driver usbhid
[    2.445789] usbhid: USB HID core driver
[    2.449863] mmc0: host does not support reading read-only switch. assumi=
ng write-enable.
[    2.459284] ashmem: initialized
[    2.462780] mmc0: new high speed SDHC card at address 0007
[    2.468807] logger: created 256K log 'log_main'
[    2.474113] mmcblk0: mmc0:0007 SD4GB 3.70 GiB
[    2.479071] logger: created 256K log 'log_events'
[    2.484863] logger: created 256K log 'log_radio'
[    2.489866]  mmcblk0: p1 p2
[    2.493305] logger: created 256K log 'log_system'
[    2.499398] Unhandled fault: external abort on non-linefetch (0x1028) at=
 0xfa022003
[    2.507432] Internal error: : 1028 [#1] SMP THUMB2
[    2.512440] Modules linked in:
[    2.515634] CPU: 0    Not tainted  (3.8.13-bone67 #2)
[    2.520916] PC is at rt_16550_init+0x106/0x198
[    2.525557] LR is at rt_16550_init+0xeb/0x198
[    2.530109] pc : [<c0888616>]    lr : [<c08885fb>]    psr: 60000033
[    2.530109] sp : de871f18  ip : ffffffff  fp : c0a10410
[    2.542086] r10: c0a1034c  r9 : fa022001  r8 : 00000000
[    2.547537] r7 : c0a10370  r6 : dd948380  r5 : 00000001  r4 : 00000000
[    2.554348] r3 : 00000000  r2 : 00000001  r1 : fa022001  r0 : 00000001
[    2.561165] Flags: nZCv  IRQs on  FIQs on  Mode SVC_32  ISA Thumb  Segme=
nt kernel
[    2.568974] Control: 50c5387d  Table: 9d95c019  DAC: 00000015
[    2.574970] Process swapper/0 (pid: 1, stack limit =3D 0xde870240)
[    2.581243] Stack: (0xde871f18 to 0xde872000)
[    2.585788] 1f00:                                                       =
00000000 c08a7ef8
[    2.594334] 1f20: 00000000 c08939a4 de870000 c0938600 00000000 c0888511 =
00000115 c08a7efc
[    2.602873] 1f40: 00000000 c000873f 00000006 00000006 c08ef998 c08939a0 =
c08939a4 00000006
[    2.611418] 1f60: c0893984 c0938600 c08691c9 c08a7efc 00000000 c08696b3 =
00000006 00000006
[    2.619963] 1f80: c08691c9 c0e2dd00 00000000 c0529d69 00000000 00000000 =
00000000 00000000
[    2.628499] 1fa0: 00000000 c0529d6f 00000000 c000cb5b 00000000 00000000 =
00000000 00000000
[    2.637040] 1fc0: 00000000 00000000 00000000 00000000 00000000 00000000 =
00000000 00000000
[    2.645581] 1fe0: 00000000 00000000 00000000 00000000 00000013 00000000 =
2d0f018e 33384541
[    2.654145] [<c0888616>] (rt_16550_init+0x106/0x198) from [<c000873f>] (=
do_one_initcall+0x1f/0xf8)
[    2.663517] [<c000873f>] (do_one_initcall+0x1f/0xf8) from [<c08696b3>] (=
kernel_init_freeable+0xc7/0x15c)
[    2.673428] [<c08696b3>] (kernel_init_freeable+0xc7/0x15c) from [<c0529d=
6f>] (kernel_init+0x7/0x98)
[    2.682888] [<c0529d6f>] (kernel_init+0x7/0x98) from [<c000cb5b>] (ret_f=
rom_fork+0x13/0x38)
[    2.691622] Code: 782b f3bf 8f4f e00f (f899) 3002
[    2.696669] ---[ end trace 5c14e778816ca166 ]---
[    2.701698] usb usb1: usb wakeup-resume
[    2.705798] Kernel panic - not syncing: Attempted to kill init! exitcode=
=3D0x0000000b
[    2.705798]

Smail: Terje Fr=F8ysa, SINTEF ICT (Information and Communication Technology=
), N-7465 Trondheim, Norway.
Email: terje.froysa@sintef.no<blocked::mailto:terje.froysa@sintef.no> <mail=
to:terje.froysa@sintef.no<blocked::mailto:terje.froysa@sintef.no>>
Phone: +47 930 03603,
Company: Independent R&D, see <http://www.sintef.no/<blocked::http://www.si=
ntef.no/>

