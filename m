From: SMITH Peter T <peter.t.smith@alstom.com>
Date: Wed, 6 May 2015 13:50:36 +0000
Message-ID: <92BAB684D31DCD4A8F623A7EE7FD8C06013ED08A@041-DB3MPN1-092.041d.mgd.msft.net>
Content-Language: en-US
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: [Xenomai] Xenomai on Zynq (linux-denx xilinx-zynq-v3.14.17)
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "xenomai@xenomai.org" <xenomai@xenomai.org>

Hi everyone,

I have successfully built a kernel for Zynq 7020 (on the Xilinx ZC702 board=
) following the instructions on the Xenomai web site.

I have used the linux-denx git (branch xilinx-zynq-v3.14.17) and the xenoma=
i-2.6 git (branch master). The kernel boots and I am able to log on to the =
target, so all seems well. I have also made sure that CONFIG_CPU_FREQ and C=
ONFIG_CPU_IDLE are not enabled.

I do however, see a strange error message related to [ INFO: inconsistent l=
ock state ] in my dmesg output.

My first question is, is this anything to worry about? Is it an indication =
that my build is incorrect.

[    0.000000] Inode-cache hash table entries: 65536 (order: 6, 262144 byte=
s)
[    0.000000] Memory: 888400K/1048576K available (5682K kernel code, 320K =
rwdata, 1980K rodata, 300K init, 5639K bss, 160176K reserved, 270336K highm=
em)
[    0.000000] Virtual kernel memory layout:
[    0.000000]     vector  : 0xffff0000 - 0xffff1000   (   4 kB)
[    0.000000]     fixmap  : 0xfff00000 - 0xfffe0000   ( 896 kB)
[    0.000000]     vmalloc : 0xf0000000 - 0xff000000   ( 240 MB)
[    0.000000]     lowmem  : 0xc0000000 - 0xef800000   ( 760 MB)
[    0.000000]     pkmap   : 0xbfe00000 - 0xc0000000   (   2 MB)
[    0.000000]     modules : 0xbf000000 - 0xbfe00000   (  14 MB)
[    0.000000]       .text : 0xc0008000 - 0xc0783bc4   (7663 kB)
[    0.000000]       .init : 0xc0784000 - 0xc07cf140   ( 301 kB)
[    0.000000]       .data : 0xc07d0000 - 0xc0820270   ( 321 kB)
[    0.000000]        .bss : 0xc082027c - 0xc0da1fb4   (5640 kB)
[    0.000000] Preemptible hierarchical RCU implementation.
[    0.000000] RCU lockdep checking is enabled.
[    0.000000] Dump stacks of tasks blocking RCU-preempt GP.
[    0.000000] RCU restricting CPUs from NR_CPUS=3D4 to nr_cpu_ids=3D2.
[    0.000000] RCU: Adjusting geometry for rcu_fanout_leaf=3D16, nr_cpu_ids=
=3D2
[    0.000000] NR_IRQS:16 nr_irqs:16 16
[    0.000000] slcr mapped to f0004000
[    0.000000] zynq_clock_init: clkc starts at f0004100
[    0.000000] Zynq clock init
[    0.000017] sched_clock: 64 bits at 333MHz, resolution 3ns, wraps every =
3298534883328ns
[    0.008331] timer #0 at f0006000, irq=3D43
[    0.012290] I-pipe, 333.333 MHz timer
[    0.015901] I-pipe, 333.333 MHz clocksource, wrap in 12884 ms
[    0.022155] Interrupt pipeline (release #4)
[    0.027694] Console: colour dummy device 80x30
[    0.032040] Lock dependency validator: Copyright (c) 2006 Red Hat, Inc.,=
 Ingo Molnar
[    0.039831] ... MAX_LOCKDEP_SUBCLASSES:  8
[    0.043898] ... MAX_LOCK_DEPTH:          48
[    0.048157] ... MAX_LOCKDEP_KEYS:        8191
[    0.052497] ... CLASSHASH_SIZE:          4096
[    0.056923] ... MAX_LOCKDEP_ENTRIES:     16384
[    0.061355] ... MAX_LOCKDEP_CHAINS:      32768
[    0.065827] ... CHAINHASH_SIZE:          16384
[    0.070338]  memory used by lock dependency info: 3695 kB
[    0.075718]  per task-struct memory footprint: 1152 bytes
[    0.081247] Calibrating delay loop... 1325.46 BogoMIPS (lpj=3D6627328)
[    0.168601] pid_max: default: 32768 minimum: 301
[    0.174088] Mount-cache hash table entries: 2048 (order: 1, 8192 bytes)
[    0.180637] Mountpoint-cache hash table entries: 2048 (order: 1, 8192 by=
tes)
[    0.199907] CPU: Testing write buffer coherency: ok
[    0.206327] CPU0: thread -1, cpu 0, socket 0, mpidr 80000000
[    0.211910] Setting up static identity map for 0x5658f8 - 0x565950
[    0.218356] L310 cache controller enabled
[    0.222257] l2x0: 8 ways, CACHE_ID 0x410000c8, AUX_CTRL 0x72f60000, Cach=
e size: 512 kB
[    0.308262] CPU1: Booted secondary processor
[    0.308304] I-pipe, 333.333 MHz timer
[    0.395906] CPU1: thread -1, cpu 1, socket 0, mpidr 80000001
[    0.397018] Brought up 2 CPUs
[    0.413588] SMP: Total of 2 processors activated.
[    0.418311] CPU: All CPU(s) started in SVC mode.
[    0.423746]
[    0.425142] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
[    0.429527] [ INFO: inconsistent lock state ]
[    0.433917] 3.14.17-xilinx-03783-g1bcd414-dirty #2 Not tainted
[    0.439761] ---------------------------------
[    0.444149] inconsistent {IN-HARDIRQ-W} -> {HARDIRQ-ON-R} usage.
[    0.450172] swapper/0/0 [HC0[0]:SC0[0]:HE1:SE1] takes:
[    0.455327]  (timekeeper_seq){-?.-..}, at: [<c0080048>] __tick_nohz_idle=
_enter+0x28/0x42c
[    0.463498] {IN-HARDIRQ-W} state was registered at:
[    0.468399]   [<c00792e0>] update_wall_time+0x7c0/0x848
[    0.473645]   [<c007e028>] tick_periodic+0xa0/0xec
[    0.478460]   [<c007e244>] tick_handle_periodic+0x20/0x94
[    0.483878]   [<c0015120>] twd_handler+0x40/0x4c
[    0.488522]   [<c006e0e4>] handle_percpu_devid_irq+0x84/0x104
[    0.494284]   [<c006b4a4>] generic_handle_irq+0x20/0x30
[    0.499530]   [<c000f3f0>] handle_IRQ+0x94/0xd4
[    0.504088]   [<c0094794>] __ipipe_do_sync_stage+0x240/0x2ac
[    0.509764]   [<c00084bc>] __ipipe_grab_irq+0x70/0x88
[    0.514838]   [<c0008674>] gic_handle_irq+0x3c/0x60
[    0.519740]   [<c0012944>] __irq_svc+0x44/0x70
[    0.524212]   [<c0094938>] ipipe_unstall_root+0x48/0x58
[    0.529458]   [<c07849cc>] start_kernel+0x23c/0x384
[    0.534360]   [<00008074>] 0x8074
[    0.537716] irq event stamp: 7902
[    0.541070] hardirqs last  enabled at (7901): [<c0564e28>] _raw_spin_unl=
ock_irqrestore+0x38/0x70
[    0.549842] hardirqs last disabled at (7902): [<c008048c>] tick_nohz_idl=
e_enter+0x40/0x8c
[    0.558012] softirqs last  enabled at (7890): [<c0028a40>] irq_enter+0x4=
c/0x78
[    0.565236] softirqs last disabled at (7889): [<c0028a2c>] irq_enter+0x3=
8/0x78
[    0.572459]
[    0.572459] other info that might help us debug this:
[    0.579081]  Possible unsafe locking scenario:
[    0.579081]
[    0.585100]        CPU0
[    0.587595]        ----
[    0.590088]   lock(timekeeper_seq);
[    0.593615]   <Interrupt>
[    0.596280]     lock(timekeeper_seq);
[    0.599979]
[    0.599979]  *** DEADLOCK ***
[    0.599979]
[    0.606087] 1 lock held by swapper/0/0:
[    0.609955]  #0:  (timekeeper_seq){-?.-..}, at: [<c0080048>] __tick_nohz=
_idle_enter+0x28/0x42c
[    0.618555]
[    0.618555] stack backtrace:
[    0.623034] CPU: 0 PID: 0 Comm: swapper/0 Not tainted 3.14.17-xilinx-037=
83-g1bcd414-dirty #2
[    0.631477] [<c0015c04>] (unwind_backtrace) from [<c0011e84>] (show_stac=
k+0x10/0x14)
[    0.639211] [<c0011e84>] (show_stack) from [<c055f2b8>] (dump_stack+0x8c=
/0xd0)
[    0.646433] [<c055f2b8>] (dump_stack) from [<c055d5d8>] (print_usage_bug=
+0x25c/0x2d0)
[    0.654262] [<c055d5d8>] (print_usage_bug) from [<c0060b9c>] (mark_lock+=
0x3d0/0x6b8)
[    0.661998] [<c0060b9c>] (mark_lock) from [<c0060f6c>] (mark_held_locks+=
0xe8/0x128)
[    0.669652] [<c0060f6c>] (mark_held_locks) from [<c0061100>] (trace_hard=
irqs_on_caller+0x154/0x1cc)
[    0.678681] [<c0061100>] (trace_hardirqs_on_caller) from [<c0012974>] (_=
_ipipe_fast_svc_irq_exit+0x4/0x14)
[    0.688314] [<c0012974>] (__ipipe_fast_svc_irq_exit) from [<c00635b0>] (=
lock_acquire+0xa8/0xac)
[    0.696997] [<c00635b0>] (lock_acquire) from [<e6f91180>] (0xe6f91180)
[    0.704688] devtmpfs: initialized
[    0.713089] VFP support v0.3: implementor 41 architecture 3 part 30 vari=
ant 9 rev 4
[    0.722834] regulator-dummy: no parameters
[    0.734246] NET: Registered protocol family 16
[    0.741076] DMA: preallocated 256 KiB pool for atomic coherent allocatio=
ns
[    0.763387] syscon f8000000.slcr: regmap [mem 0xf8000000-0xf8000fff] reg=
istered
[    0.776109] hw-breakpoint: found 5 (+1 reserved) breakpoint and 1 watchp=
oint registers.
[    0.784035] hw-breakpoint: maximum watchpoint size is 4 bytes.
[    0.790172] zynq-ocm f800c000.ocmc: ZYNQ OCM pool: 256 KiB @ 0xf0080000
[    0.844089] bio: create slab <bio-0> at 0
[    0.849965] VCCPINT: 1000 mV
[    0.854061] vgaarb: loaded
[    0.858985] SCSI subsystem initialized
[    0.864352] usbcore: registered new interface driver usbfs
[    0.871016] usbcore: registered new interface driver hub
[    0.876625] usbcore: registered new device driver usb
[    0.882676] media: Linux media interface: v0.10
[    0.887400] Linux video capture interface: v2.00
[    0.892397] pps_core: LinuxPPS API ver. 1 registered
[    0.897233] pps_core: Software ver. 5.3.6 - Copyright 2005-2007 Rodolfo =
Giometti <giometti@linux.it>
[    0.906630] PTP clock support registered
[    0.911135] EDAC MC: Ver: 3.0.0
[    0.916265] Advanced Linux Sound Architecture Driver Initialized.
[    0.928611] DMA-API: preallocated 4096 debug entries
[    0.933445] DMA-API: debugging enabled by kernel config
[    0.938802] Switched to clocksource ipipe_tsc
[    0.982151] NET: Registered protocol family 2
[    0.987901] TCP established hash table entries: 8192 (order: 3, 32768 by=
tes)
[    0.995026] TCP bind hash table entries: 8192 (order: 6, 294912 bytes)
[    1.002357] TCP: Hash tables configured (established 8192 bind 8192)
[    1.008905] TCP: reno registered
[    1.012039] UDP hash table entries: 512 (order: 3, 40960 bytes)
[    1.018091] UDP-Lite hash table entries: 512 (order: 3, 40960 bytes)
[    1.025018] NET: Registered protocol family 1
[    1.029993] RPC: Registered named UNIX socket transport module.
[    1.035778] RPC: Registered udp transport module.
[    1.040562] RPC: Registered tcp transport module.
[    1.045239] RPC: Registered tcp NFSv4.1 backchannel transport module.
[    1.051718] PCI: CLS 0 bytes, default 64
[    1.056057] Trying to unpack rootfs image as initramfs...
[    1.661133] Freeing initrd memory: 5696K (dfa6f000 - dffff000)
[    1.667074] hw perfevents: enabled with ARMv7 Cortex-A9 PMU driver, 7 co=
unters available
[    1.679054] futex hash table entries: 512 (order: 3, 32768 bytes)
[    1.686795] I-pipe: head domain Xenomai registered.
[    1.691625] Xenomai: hal/arm started.
[    1.695602] Xenomai: scheduling class idle registered.
[    1.700609] Xenomai: scheduling class rt registered.
[    1.722307] Xenomai: real-time nucleus v2.6.4 (Jumpin' Out) loaded.
[    1.728438] Xenomai: debug mode enabled.
[    1.732938] Xenomai: starting native API services.
[    1.737607] Xenomai: starting POSIX services.
[    1.742171] Xenomai: starting RTDM services.
[    1.746955] bounce pool size: 64 pages
[    1.752599] jffs2: version 2.2. (NAND) (SUMMARY)  =C2=A9 2001-2006 Red H=
at, Inc.
[    1.759959] msgmni has been set to 1474
[    1.775577] io scheduler noop registered
[    1.779421] io scheduler deadline registered
[    1.783757] io scheduler cfq registered (default)
[    1.799972] dma-pl330 f8003000.dmac: Loaded driver for PL330 DMAC-236420=
8
[    1.806620] dma-pl330 f8003000.dmac:         DBUFF-128x8bytes Num_Chans-=
8 Num_Peri-4 Num_Events-16
[    1.817100] e0001000.serial: ttyPS0 at MMIO 0xe0001000 (irq =3D 82, base=
_baud =3D 3124999) is a xuartps
[    1.826245] console [ttyPS0] enabled
[    1.833335] bootconsole [earlycon0] disabled
[    1.843243] xdevcfg f8007000.devcfg: ioremap 0xf8007000 to f006c000
[    1.851316] [drm] Initialized drm 1.1.0 20060810
[    1.879782] brd: module loaded
[    1.894863] loop: module loaded
[    1.910408] m25p80 spi0.0: n25q128a11 (16384 Kbytes)
[    1.915362] 5 ofpart partitions found on MTD device spi0.0
[    1.920818] Creating 5 MTD partitions on "spi0.0":
[    1.925547] 0x000000000000-0x000000100000 : "qspi-fsbl-uboot"
[    1.934554] 0x000000100000-0x000000600000 : "qspi-linux"
[    1.942648] 0x000000600000-0x000000620000 : "qspi-device-tree"
[    1.951319] 0x000000620000-0x000000c00000 : "qspi-rootfs"
[    1.959555] 0x000000c00000-0x000001000000 : "qspi-bitstream"
[    1.974089] e1000e: Intel(R) PRO/1000 Network Driver - 2.3.2-k
[    1.979889] e1000e: Copyright(c) 1999 - 2013 Intel Corporation.
[    1.989220] libphy: XEMACPS mii bus: probed
[    1.999691] xemacps e000b000.ethernet: pdev->id -1, baseaddr 0xe000b000,=
 irq 54
[    2.008657] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
[    2.015672] ehci-pci: EHCI PCI platform driver
[    2.020660] ULPI transceiver vendor/product ID 0x0424/0x0007
[    2.026236] Found SMSC USB3320 ULPI transceiver.
[    2.031060] ULPI integrity check: passed.
[    2.035537] zynq-ehci zynq-ehci.0: Xilinx Zynq USB EHCI Host Controller
[    2.042256] zynq-ehci zynq-ehci.0: new USB bus registered, assigned bus =
number 1
[    2.078879] zynq-ehci zynq-ehci.0: irq 53, io mem 0x00000000
[    2.098850] zynq-ehci zynq-ehci.0: USB 2.0 started, EHCI 1.00
[    2.106654] hub 1-0:1.0: USB hub found
[    2.110412] hub 1-0:1.0: 1 port detected
[    2.115630] usbcore: registered new interface driver usb-storage
[    2.123346] mousedev: PS/2 mouse device common for all mice
[    2.130026] i2c /dev entries driver
[    2.140834] cdns-i2c e0004000.i2c: 400 kHz mmio e0004000 irq 57
[    2.154035] i2c i2c-0: Added multiplexed i2c bus 1
[    2.159802] i2c i2c-0: Added multiplexed i2c bus 2
[    2.172812] at24 3-0054: 1024 byte 24c08 EEPROM, writable, 1 bytes/write
[    2.179541] i2c i2c-0: Added multiplexed i2c bus 3
[    2.191164] i2c i2c-0: Added multiplexed i2c bus 4
[    2.202803] rtc-pcf8563 5-0051: chip found, driver version 0.4.3
[    2.210261] rtc-pcf8563 5-0051: rtc core: registered rtc-pcf8563 as rtc0
[    2.216921] i2c i2c-0: Added multiplexed i2c bus 5
[    2.222719] i2c i2c-0: Added multiplexed i2c bus 6
[    2.228393] i2c i2c-0: Added multiplexed i2c bus 7
[    2.251783] i2c i2c-0: Added multiplexed i2c bus 8
[    2.256506] pca954x 0-0074: registered 8 multiplexed busses for I2C swit=
ch pca9548
[    2.305455] ucd9200 8-0034: Device ID UCD9248-80|5.8.0.11400|091112
[    2.347627] ucd9200 8-0034: 4 rails configured
[    2.488841] ucd9200 8-0035: Device ID UCD9248-80|5.8.0.11400|091112
[    2.531054] ucd9200 8-0035: 4 rails configured
[    2.674292] ucd9200 8-0036: Device ID UCD9248-80|5.8.0.11400|091112
[    2.716408] ucd9200 8-0036: 2 rails configured
[    2.759806] cdns-wdt f8005000.watchdog: Xilinx Watchdog Timer at f007600=
0 with timeout 10s
[    2.768757] zynq-edac f8006000.memory-controller: ecc not enabled
[    2.775423] sdhci: Secure Digital Host Controller Interface driver
[    2.781571] sdhci: Copyright(c) Pierre Ossman
[    2.785866] sdhci-pltfm: SDHCI platform and OF driver helper
[    2.791802] mmc0: no vqmmc regulator found
[    2.795819] mmc0: no vmmc regulator found
[    2.838841] mmc0: SDHCI controller on e0100000.sdhci [e0100000.sdhci] us=
ing ADMA
[    2.847845] usbcore: registered new interface driver usbhid
[    2.853381] usbhid: USB HID core driver
[    2.871424] si570 1-005d: registered, current frequency 148500000 Hz
[    2.881573] TCP: cubic registered
[    2.884816] NET: Registered protocol family 17
[    2.889563] Registering SWP/SWPB emulation handler
[    2.895891] regulator-dummy: disabling
[    2.900436] rtc-pcf8563 5-0051: setting system clock to 2029-09-02 20:51=
:27 UTC (1883076687)
[    2.919374] mmc0: new SDHC card at address e624
[    2.923438] ALSA device list:
[    2.923443]   No soundcards found.
[    2.930895] Freeing unused kernel memory: 300K (c0784000 - c07cf000)
[    2.931347] mmcblk0: mmc0:e624 SD08G 7.40 GiB
[    2.941897]  mmcblk0: p1 p2
[    4.300798] random: dd urandom read with 28 bits of entropy available
[    9.669696] xemacps e000b000.ethernet: Set clk to 24999999 Hz
[    9.675370] xemacps e000b000.ethernet: link up (100/FULL)
[   35.939764] EXT4-fs (mmcblk0p2): recovery complete
[   35.947140] EXT4-fs (mmcblk0p2): mounted filesystem with ordered data mo=
de. Opts: (null)
[   65.121748] random: nonblocking pool is initialized

My second (and last) question is related to performance. Below is the outpu=
t of the latency test on an unloaded target. Is it normal to see negative l=
atencies or is this an indication that something is wrong?

root@zynq:/mnt# latency -p 100 -T 10
=3D=3D Sampling period: 100 us
=3D=3D Test mode: periodic user-mode task
=3D=3D All results in microseconds
warming up...
RTT|  00:00:01  (periodic user-mode task, 100 us period, priority 99)
RTH|----lat min|----lat avg|----lat max|-overrun|---msw|---lat best|--lat w=
orst
RTD|     -3.415|     -3.151|      1.935|       0|     0|     -3.415|      1=
.935
RTD|     -3.940|     -3.673|      2.181|       0|     0|     -3.940|      2=
.181
RTD|     -3.991|     -3.694|      1.161|       0|     0|     -3.991|      2=
.181
RTD|     -3.934|     -3.691|      1.590|       0|     0|     -3.991|      2=
.181
RTD|     -3.934|     -3.688|      2.115|       0|     0|     -3.991|      2=
.181
RTD|     -3.922|     -3.673|      1.746|       0|     0|     -3.991|      2=
.181
RTD|     -3.952|     -3.685|      0.486|       0|     0|     -3.991|      2=
.181
RTD|     -4.009|     -3.694|      1.908|       0|     0|     -4.009|      2=
.181
RTD|     -3.979|     -3.688|      0.846|       0|     0|     -4.009|      2=
.181
---|-----------|-----------|-----------|--------|------|-------------------=
------
RTS|     -4.009|     -3.625|      2.181|       0|     0|    00:00:10/00:00:=
10

Many thanks
Peter Smith




________________________________
CONFIDENTIALITY : This e-mail and any attachments are confidential and may =
be privileged. If you are not a named recipient, please notify the sender i=
mmediately and do not disclose the contents to another person, use it for a=
ny purpose or store or copy the information in any medium.
