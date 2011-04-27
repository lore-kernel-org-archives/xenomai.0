Message-ID: <4DB8149A.7080600@domain.hid>
Date: Wed, 27 Apr 2011 19:05:30 +0600
From: Alexey Galakhov <agalakhov@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: [Adeos-main] Ipipe hangs on ARM MINI2440 after switching clocksource
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/options/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: </public/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: adeos-main@gna.org

Hi,

I'm trying to run Xenomai on MINI2440 board. I use vanilla 2.6.35.9
kernel patched with adeos-ipipe-2.6.35.9-arm-1.18-01.patch . In kernel
configuration Xenomai is disabled, the only option (except debug) I
turned on is CONFIG_IPIPE. It hangs.

I suspect it is somehow related to TIMER3 which is used along with
TIMER4 on Samsung ARMs. Any suggestions?

My dmesg (with debugging on):

[    0.000000] Linux version 2.6.35.9-mini2440-rt
(agalakhov@domain.hid) (gcc version 4.6.0 (GCC) ) #9 PREEMPT Wed
Apr 27 18:33:31 YEKST 2011
[    0.000000] CPU: ARM920T [41129200] revision 0 (ARMv4T), cr=c0007177
[    0.000000] CPU: VIVT data cache, VIVT instruction cache
[    0.000000] Machine: MINI2440
[    0.000000] Memory policy: ECC disabled, Data cache writeback
[    0.000000] On node 0 totalpages: 16384
[    0.000000] free_area_init_node: node 0, pgdat c066ded4, node_mem_map
c06ee000
[    0.000000]   Normal zone: 128 pages used for memmap
[    0.000000]   Normal zone: 0 pages reserved
[    0.000000]   Normal zone: 16256 pages, LIFO batch:3
[    0.000000] CPU S3C2440A (id 0x32440001)
[    0.000000] S3C24XX Clocks, Copyright 2004 Simtec Electronics
[    0.000000] S3C244X: core 405.000 MHz, memory 101.250 MHz, peripheral
50.625 MHz
[    0.000000] CLOCK: Slow mode (1.500 MHz), fast, MPLL on, UPLL on
[    0.000000] Built 1 zonelists in Zone order, mobility grouping on. 
Total pages: 16256
[    0.000000] Kernel command line: mini2440=1tb console=ttySAC0,115200
noinitrd rootwait rootfstype=ext2 root=/dev/mmcblk0p1 ro loglevel=8
[    0.000000] PID hash table entries: 256 (order: -2, 1024 bytes)
[    0.000000] Dentry cache hash table entries: 8192 (order: 3, 32768 bytes)
[    0.000000] Inode-cache hash table entries: 4096 (order: 2, 16384 bytes)
[    0.000000] Memory: 64MB = 64MB total
[    0.000000] Memory: 57880k/57880k available, 7656k reserved, 0K highmem
[    0.000000] Virtual kernel memory layout:
[    0.000000]     vector  : 0xffff0000 - 0xffff1000   (   4 kB)
[    0.000000]     fixmap  : 0xfff00000 - 0xfffe0000   ( 896 kB)
[    0.000000]     DMA     : 0xffc00000 - 0xffe00000   (   2 MB)
[    0.000000]     vmalloc : 0xc4800000 - 0xe0000000   ( 440 MB)
[    0.000000]     lowmem  : 0xc0000000 - 0xc4000000   (  64 MB)
[    0.000000]     modules : 0xbf000000 - 0xc0000000   (  16 MB)
[    0.000000]       .init : 0xc0008000 - 0xc0027000   ( 124 kB)
[    0.000000]       .text : 0xc0027000 - 0xc0486000   (4476 kB)
[    0.000000]       .data : 0xc04ca000 - 0xc06709c0   (1691 kB)
[    0.000000] SLUB: Genslabs=11, HWalign=32, Order=0-3, MinObjects=0,
CPUs=1, Nodes=1
[    0.000000] Hierarchical RCU implementation.
[    0.000000]  RCU-based detection of stalled CPUs is disabled.
[    0.000000]  Verbose stalled-CPUs detection is disabled.
[    0.000000] NR_IRQS:85
[    0.000000] irq: clearing pending status 02000000
[    0.000000] irq: clearing subpending status 00000007
[    0.000000] irq: clearing subpending status 00000002
[    0.000000] I-pipe, 8.437 MHz clocksource
[    0.000000] timer tcon=00500000, tcnt a4ca, tcfg 00000200,00000000,
usec 00001e57
[    0.000000] I-pipe 1.18-01: pipeline enabled.
[    0.000000] Console: colour dummy device 80x30
[    0.000000] console [ttySAC0] enabled
[    0.015000] Calibrating delay loop... 201.52 BogoMIPS (lpj=503808)
[    0.115000] pid_max: default: 32768 minimum: 301
[    0.115000] Mount-cache hash table entries: 512
[    0.120000] CPU: Testing write buffer coherency: ok
[    0.125000] devtmpfs: initialized
[    0.140000] gpiochip_add: gpios 288..303 (GPIOK) failed to register
[    0.140000] gpiochip_add: gpios 320..334 (GPIOL) failed to register
[    0.145000] gpiochip_add: gpios 352..353 (GPIOM) failed to register
[    0.160000] NET: Registered protocol family 16
[    0.220000] MINI2440: Option string mini2440=1tb
[    0.220000] MINI2440: LCD 0:240x320 [1:800x480] 2:1024x768
[    0.295000] S3C2440: Initialising architecture
[    0.295000] S3C2440: IRQ Support
[    0.300000] S3C24XX DMA Driver, Copyright 2003-2006 Simtec Electronics
[    0.305000] DMA channel 0 at c4808000, irq 33
[    0.310000] DMA channel 1 at c4808040, irq 34
[    0.315000] DMA channel 2 at c4808080, irq 35
[    0.320000] DMA channel 3 at c48080c0, irq 36
[    0.320000] S3C244X: Clock Support, DVS off
[    0.340000] s3c-adc s3c24xx-adc: attached adc driver
[    0.660000] bio: create slab <bio-0> at 0
[    0.685000] SCSI subsystem initialized
[    0.695000] usbcore: registered new interface driver usbfs
[    0.700000] usbcore: registered new interface driver hub
[    0.705000] usbcore: registered new device driver usb
[    0.715000] s3c-i2c s3c2440-i2c: slave address 0x10
[    0.715000] s3c-i2c s3c2440-i2c: bus frequency set to 98 KHz
[    0.730000] s3c-i2c s3c2440-i2c: i2c-0: S3C I2C adapter
[    0.755000] Advanced Linux Sound Architecture Driver Version 1.0.23.
[    0.765000] Switching to clocksource ipipe_tsc
(no further response, heartbeat LED doesn't blink)

Regards,
Alex


