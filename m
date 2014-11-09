From: "Stoidner, Christoph" <c.stoidner@arvero.de>
Date: Sun, 9 Nov 2014 10:07:54 +0000
Message-ID: <04e5e7e2fab241a5916e4e48f9d9b325@EX132MBOX1B.de2.local>
Content-Language: de-DE
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: [Xenomai] "inconsistent lock state" on boot-up
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "xenomai@xenomai.org" <xenomai@xenomai.org>

Hi at all,=0A=
=0A=
I am using linux 3.10.32 and ipipe-core-3.10.32-arm-4.patch on a Freescale =
i.MX28.=0A=
=0A=
When booting the kernel the message "inconsistent lock state" is given (see=
 below). Does anyone have an idea why this happens? With kernel 3.10.18 and=
 according ipipe it is the same. With linux 3.4.6 and ipipe 3.4.6-arm-4 the=
 message does not appear. =0A=
=0A=
I am very interested to understand if these message could lead to any probl=
ems, since I have I unpredictable crashes of my xenomai-based application p=
rogram (e.g. with "segmentation fault" or "scheduling while atomic" message=
s).=0A=
=0A=
Here is the kernel output of 3.10.32 and ipipe-core-3.10.32-arm-4.patch:=0A=
=0A=
[    0.000000] Booting Linux on physical CPU 0x0=0A=
[    0.000000] Linux version 3.10.32-ipipe (stch@Kubuntu-Default) (gcc vers=
ion 4.6.2 (arvero ARM tools 2013-08-05) ) #3 PREEMPT Thu Nov 6 14:54:08 CET=
 2014=0A=
[    0.000000] CPU: ARM926EJ-S [41069265] revision 5 (ARMv5TEJ), cr=3D00053=
177=0A=
[    0.000000] CPU: VIVT data cache, VIVT instruction cache=0A=
[    0.000000] Machine: Freescale MXS (Device Tree), model: Viessmann Vitoc=
om 100=0A=
[    0.000000] Memory policy: ECC disabled, Data cache writeback=0A=
[    0.000000] On node 0 totalpages: 32768=0A=
[    0.000000] free_area_init_node: node 0, pgdat c06fa4e8, node_mem_map c0=
ca5000=0A=
[    0.000000]   Normal zone: 256 pages used for memmap=0A=
[    0.000000]   Normal zone: 0 pages reserved=0A=
[    0.000000]   Normal zone: 32768 pages, LIFO batch:7=0A=
[    0.000000] pcpu-alloc: s0 r0 d32768 u32768 alloc=3D1*32768=0A=
[    0.000000] pcpu-alloc: [0] 0 =0A=
[    0.000000] Built 1 zonelists in Zone order, mobility grouping on.  Tota=
l pages: 32512=0A=
[    0.000000] Kernel command line: fec.macaddr=3D0x00,0xD0,0x93,0x2A,0xCC,=
0x40 ip=3D192.168.200.20:192.168.200.125:192.168.1.254:255.255.255.0::eth0:=
off root=3D/dev/nfs rw nfsroot=3D192.168.200.125:/srv/nfs/rtos-linux-rootfs=
,v3,tcp rw console=3DttyAMA0,115200=0A=
[    0.000000] PID hash table entries: 512 (order: -1, 2048 bytes)=0A=
[    0.000000] Dentry cache hash table entries: 16384 (order: 4, 65536 byte=
s)=0A=
[    0.000000] Inode-cache hash table entries: 8192 (order: 3, 32768 bytes)=
=0A=
[    0.000000] Memory: 128MB =3D 128MB total=0A=
[    0.000000] Memory: 116928k/116928k available, 14144k reserved, 0K highm=
em=0A=
[    0.000000] Virtual kernel memory layout:=0A=
[    0.000000]     vector  : 0xffff0000 - 0xffff1000   (   4 kB)=0A=
[    0.000000]     fixmap  : 0xfff00000 - 0xfffe0000   ( 896 kB)=0A=
[    0.000000]     vmalloc : 0xc8800000 - 0xff000000   ( 872 MB)=0A=
[    0.000000]     lowmem  : 0xc0000000 - 0xc8000000   ( 128 MB)=0A=
[    0.000000]     modules : 0xbf000000 - 0xc0000000   (  16 MB)=0A=
[    0.000000]       .text : 0xc0008000 - 0xc067dce4   (6616 kB)=0A=
[    0.000000]       .init : 0xc067e000 - 0xc06b4588   ( 218 kB)=0A=
[    0.000000]       .data : 0xc06b6000 - 0xc06fed30   ( 292 kB)=0A=
[    0.000000]        .bss : 0xc06fed30 - 0xc0c9ff80   (5765 kB)=0A=
[    0.000000] SLUB: HWalign=3D32, Order=3D0-3, MinObjects=3D0, CPUs=3D1, N=
odes=3D1=0A=
[    0.000000] Preemptible hierarchical RCU implementation.=0A=
[    0.000000] NR_IRQS:16 nr_irqs:16 16=0A=
[    0.000000] of_irq_init: children remain, but no parents=0A=
[    0.000000] I-pipe, 24.000 MHz clocksource=0A=
[    0.000000] sched_clock: 32 bits at 24MHz, resolution 41ns, wraps every =
178956ms=0A=
[    0.000000] I-pipe: ARM926EJ-S detected, disabling wfi instruction in id=
le loop=0A=
[    0.000000] Interrupt pipeline (release #4)=0A=
[    0.000000] Console: colour dummy device 80x30=0A=
[    0.000000] Lock dependency validator: Copyright (c) 2006 Red Hat, Inc.,=
 Ingo Molnar=0A=
[    0.000000] ... MAX_LOCKDEP_SUBCLASSES:  8=0A=
[    0.000000] ... MAX_LOCK_DEPTH:          48=0A=
[    0.000000] ... MAX_LOCKDEP_KEYS:        8191=0A=
[    0.000000] ... CLASSHASH_SIZE:          4096=0A=
[    0.000000] ... MAX_LOCKDEP_ENTRIES:     16384=0A=
[    0.000000] ... MAX_LOCKDEP_CHAINS:      32768=0A=
[    0.000000] ... CHAINHASH_SIZE:          16384=0A=
[    0.000000]  memory used by lock dependency info: 3695 kB=0A=
[    0.000000]  per task-struct memory footprint: 1152 bytes=0A=
[    0.002748] Calibrating delay loop... 226.09 BogoMIPS (lpj=3D1130496)=0A=
[    0.071047] pid_max: default: 32768 minimum: 301=0A=
[    0.071902] Mount-cache hash table entries: 512=0A=
[    0.079998] CPU: Testing write buffer coherency: ok=0A=
[    0.083826] Setting up static identity map for 0xc04acc20 - 0xc04acc78=
=0A=
[    0.091221] =0A=
[    0.091279] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A=
[    0.091308] [ INFO: inconsistent lock state ]=0A=
[    0.091344] 3.10.32-ipipe #3 Not tainted=0A=
[    0.091366] ---------------------------------=0A=
[    0.091392] inconsistent {IN-HARDIRQ-W} -> {HARDIRQ-ON-W} usage.=0A=
[    0.091427] kthreadd/9 [HC0[0]:SC0[0]:HE1:SE1] takes:=0A=
[    0.091452]  (std_spinlock_raw(&rq->lock)){?.....}, at: [<c0049608>] try=
_to_wake_up+0x80/0x12c=0A=
[    0.091572] {IN-HARDIRQ-W} state was registered at:=0A=
[    0.091599]   [<c005eb40>] __lock_acquire+0xac8/0x1aec=0A=
[    0.091657]   [<c006017c>] lock_acquire+0xc0/0x184=0A=
[    0.091702]   [<c04abf18>] _raw_spin_lock+0x40/0x50=0A=
[    0.091764]   [<c004a1a8>] scheduler_tick+0x20/0xdc=0A=
[    0.091815]   [<c002c4ec>] update_process_times+0x58/0x68=0A=
[    0.091867]   [<c0058e8c>] tick_handle_periodic+0x18/0x8c=0A=
[    0.091909]   [<c03ae6f4>] mxs_timer_interrupt+0x34/0x40=0A=
[    0.091960]   [<c006ccc8>] handle_irq_event_percpu+0x68/0x314=0A=
[    0.092013]   [<c006cfb0>] handle_irq_event+0x3c/0x5c=0A=
[    0.092056]   [<c006fb78>] handle_level_irq+0x6c/0xcc=0A=
[    0.092106]   [<c006c5b4>] generic_handle_irq+0x20/0x30=0A=
[    0.092148]   [<c000f9a0>] handle_IRQ+0x30/0x84=0A=
[    0.092203]   [<c0077c14>] __ipipe_do_sync_stage+0x2b0/0x2fc=0A=
[    0.092259]   [<c00085bc>] __ipipe_grab_irq+0x2c/0x70=0A=
[    0.092301]   [<c000e624>] __irq_svc+0x44/0x70=0A=
[    0.092342]   [<c06a8f54>] calibrate_delay+0x360/0x4e8=0A=
[    0.092401]   [<c067e95c>] start_kernel+0x25c/0x2f0=0A=
[    0.092457]   [<40008040>] 0x40008040=0A=
[    0.092498] irq event stamp: 6=0A=
[    0.092523] hardirqs last  enabled at (5): [<c0060d84>] debug_check_no_l=
ocks_freed+0xd8/0x170=0A=
[    0.092576] hardirqs last disabled at (6): [<c04ac000>] _raw_spin_lock_i=
rqsave+0x34/0x80=0A=
[    0.092636] softirqs last  enabled at (0): [<c001b454>] copy_process+0x2=
a4/0x107c=0A=
[    0.092701] softirqs last disabled at (0): [<  (null)>]   (null)=0A=
[    0.092733] =0A=
[    0.092733] other info that might help us debug this:=0A=
[    0.092761]  Possible unsafe locking scenario:=0A=
[    0.092761] =0A=
[    0.092786]        CPU0=0A=
[    0.092804]        ----=0A=
[    0.092821]   lock(std_spinlock_raw(&rq->lock));=0A=
[    0.092858]   <Interrupt>=0A=
[    0.092876]     lock(std_spinlock_raw(&rq->lock));=0A=
[    0.092913] =0A=
[    0.092913]  *** DEADLOCK ***=0A=
[    0.092913] =0A=
[    0.092950] 3 locks held by kthreadd/9:=0A=
[    0.092969]  #0:  (&x->wait){+.....}, at: [<c00489c0>] complete+0x1c/0x5=
c=0A=
[    0.093069]  #1:  (std_spinlock_raw(&p->pi_lock)){+.....}, at: [<c00495a=
8>] try_to_wake_up+0x20/0x12c=0A=
[    0.093165]  #2:  (std_spinlock_raw(&rq->lock)){?.....}, at: [<c0049608>=
] try_to_wake_up+0x80/0x12c=0A=
[    0.093260] =0A=
[    0.093260] stack backtrace:=0A=
[    0.093306] CPU: 0 PID: 9 Comm: kthreadd Not tainted 3.10.32-ipipe #3=0A=
[    0.093386] [<c0013ed8>] (unwind_backtrace+0x0/0xf0) from [<c0011c10>] (=
show_stack+0x10/0x14)=0A=
[    0.093457] [<c0011c10>] (show_stack+0x10/0x14) from [<c04a50a0>] (print=
_usage_bug.part.28+0x218/0x280)=0A=
[    0.093523] [<c04a50a0>] (print_usage_bug.part.28+0x218/0x280) from [<c0=
05df38>] (mark_lock+0x528/0x668)=0A=
[    0.093585] [<c005df38>] (mark_lock+0x528/0x668) from [<c0060a38>] (mark=
_held_locks+0x9c/0x120)=0A=
[    0.093646] [<c0060a38>] (mark_held_locks+0x9c/0x120) from [<c0060b70>] =
(trace_hardirqs_on_caller+0xb4/0x1e0)=0A=
[    0.093707] [<c0060b70>] (trace_hardirqs_on_caller+0xb4/0x1e0) from [<c0=
00e654>] (__ipipe_fast_svc_irq_exit+0x4/0x10)=0A=
[    0.093771] [<c000e654>] (__ipipe_fast_svc_irq_exit+0x4/0x10) from [<c00=
49028>] (update_rq_clock+0x48/0x58)=0A=
[    0.093832] [<c0049028>] (update_rq_clock+0x48/0x58) from [<c00490fc>] (=
enqueue_task+0x18/0x70)=0A=
[    0.093893] [<c00490fc>] (enqueue_task+0x18/0x70) from [<c0049618>] (try=
_to_wake_up+0x90/0x12c)=0A=
[    0.093952] [<c0049618>] (try_to_wake_up+0x90/0x12c) from [<c0046e3c>] (=
__wake_up_common+0x54/0x94)=0A=
[    0.094012] [<c0046e3c>] (__wake_up_common+0x54/0x94) from [<c00489ec>] =
(complete+0x48/0x5c)=0A=
[    0.094071] [<c00489ec>] (complete+0x48/0x5c) from [<c003ef78>] (kthread=
+0x7c/0xb0)=0A=
[    0.094132] [<c003ef78>] (kthread+0x7c/0xb0) from [<c000eb34>] (ret_from=
_fork+0x18/0x24)=0A=
[    0.097934] devtmpfs: initialized=0A=
[    0.102894] pinctrl core: initialized pinctrl subsystem=0A=
[    0.104625] regulator-dummy: no parameters=0A=
[    0.105613] NET: Registered protocol family 16=0A=
[    0.107080] DMA: preallocated 256 KiB pool for atomic coherent allocatio=
ns=0A=
[    0.122886] gpiochip_add: registered GPIOs 0 to 31 on device: gpio.0=0A=
[    0.125709] gpiochip_add: registered GPIOs 32 to 63 on device: gpio.1=0A=
[    0.128234] gpiochip_add: registered GPIOs 64 to 95 on device: gpio.2=0A=
[    0.130826] gpiochip_add: registered GPIOs 96 to 127 on device: gpio.3=
=0A=
[    0.133570] gpiochip_add: registered GPIOs 128 to 159 on device: gpio.4=
=0A=
[    0.150654] Serial: AMBA PL011 UART driver=0A=
[    0.151544] 80074000.serial: ttyAMA0 at MMIO 0x80074000 (irq =3D 225) is=
 a PL011 rev2=0A=
[    0.898747] console [ttyAMA0] enabled=0A=
[    0.930718] bio: create slab <bio-0> at 0=0A=
[    0.943158] mxs-dma 80004000.dma-apbh: initialized=0A=
[    0.954720] mxs-dma 80024000.dma-apbx: initialized=0A=
[    0.960462] of_get_named_gpio_flags exited with status 124=0A=
[    0.966563] vddio-sd0: 3300 mV =0A=
[    0.970520] of_get_named_gpio_flags: can't parse gpios property=0A=
[    0.977004] 3P3V: 3300 mV =0A=
[    0.980476] of_get_named_gpio_flags exited with status 125=0A=
[    0.986546] fec-3v3: 3300 mV =0A=
[    0.990375] of_get_named_gpio_flags exited with status 122=0A=
[    0.996481] usb0_vbus: 5000 mV =0A=
[    1.001710] SCSI subsystem initialized=0A=
[    1.006680] usbcore: registered new interface driver usbfs=0A=
[    1.012713] usbcore: registered new interface driver hub=0A=
[    1.018681] usbcore: registered new device driver usb=0A=
[    1.025394] pps_core: LinuxPPS API ver. 1 registered=0A=
[    1.030404] pps_core: Software ver. 5.3.6 - Copyright 2005-2007 Rodolfo =
Giometti <giometti@linux.it>=0A=
[    1.039859] PTP clock support registered=0A=
[    1.045411] Advanced Linux Sound Architecture Driver Initialized.=0A=
[    1.054090] Switching to clocksource ipipe_tsc=0A=
[    1.221815] NET: Registered protocol family 2=0A=
[    1.228393] TCP established hash table entries: 1024 (order: 1, 8192 byt=
es)=0A=
[    1.236257] TCP bind hash table entries: 1024 (order: 3, 36864 bytes)=0A=
[    1.243306] TCP: Hash tables configured (established 1024 bind 1024)=0A=
[    1.250050] TCP: reno registered=0A=
[    1.253378] UDP hash table entries: 256 (order: 2, 20480 bytes)=0A=
[    1.259726] UDP-Lite hash table entries: 256 (order: 2, 20480 bytes)=0A=
[    1.267635] NET: Registered protocol family 1=0A=
[    1.273650] RPC: Registered named UNIX socket transport module.=0A=
[    1.279881] RPC: Registered udp transport module.=0A=
[    1.284637] RPC: Registered tcp transport module.=0A=
[    1.289495] RPC: Registered tcp NFSv4.1 backchannel transport module.=0A=
[    1.296613] NetWinder Floating Point Emulator V0.97 (double precision)=
=0A=
[    1.307586] I-pipe: head domain Xenomai registered.=0A=
[    1.312699] Xenomai: hal/arm started.=0A=
[    1.316959] Xenomai: scheduling class idle registered.=0A=
[    1.322159] Xenomai: scheduling class rt registered.=0A=
[    1.349552] Xenomai: real-time nucleus v2.6.3 (Lies and Truths) loaded.=
=0A=
[    1.356216] Xenomai: debug mode enabled.=0A=
[    1.361259] Xenomai: starting @CHIP-RTOS services.=0A=
[    1.366196] Xenomai: starting native API services.=0A=
[    1.371211] Xenomai: starting POSIX services.=0A=
[    1.376029] Xenomai: starting RTDM services.=0A=
[    1.436475] NFS: Registering the id_resolver key type=0A=
[    1.442015] Key type id_resolver registered=0A=
[    1.446266] Key type id_legacy registered=0A=
[    1.450607] jffs2: version 2.2. (NAND) =A9 2001-2006 Red Hat, Inc.=0A=
[    1.459635] msgmni has been set to 228=0A=
[    1.470890] Block layer SCSI generic (bsg) driver version 0.4 loaded (ma=
jor 249)=0A=
[    1.478351] io scheduler noop registered (default)=0A=
[    1.486256] of_dma_request_slave_channel: dma-names property missing or =
empty=0A=
[    1.493691] uart-pl011 80074000.serial: no DMA platform data=0A=
[    1.500737] 80072000.serial: ttyAPP4 at MMIO 0x80072000 (irq =3D 224) is=
 a 80072000.serial=0A=
[    1.510672] mxs-auart 80072000.serial: Found APPUART 3.1.0=0A=
[    1.548255] of_get_named_gpio_flags exited with status 17=0A=
[    1.668496] libphy: fec_enet_mii_bus: probed=0A=
[    1.675807] usbcore: registered new interface driver asix=0A=
[    1.681869] usbcore: registered new interface driver ax88179_178a=0A=
[    1.688302] usbcore: registered new interface driver cdc_ether=0A=
[    1.694882] usbcore: registered new interface driver smsc95xx=0A=
[    1.701232] usbcore: registered new interface driver net1080=0A=
[    1.707224] usbcore: registered new interface driver cdc_subset=0A=
[    1.713634] usbcore: registered new interface driver zaurus=0A=
[    1.720035] usbcore: registered new interface driver cdc_ncm=0A=
[    1.725754] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver=
=0A=
[    1.732963] usbcore: registered new interface driver usb-storage=0A=
[    1.742273] ci_hdrc ci_hdrc.0: doesn't support gadget=0A=
[    1.747423] ci_hdrc ci_hdrc.0: EHCI Host Controller=0A=
[    1.752764] ci_hdrc ci_hdrc.0: new USB bus registered, assigned bus numb=
er 1=0A=
[    1.778903] ci_hdrc ci_hdrc.0: USB 2.0 started, EHCI 1.00=0A=
[    1.787744] hub 1-0:1.0: USB hub found=0A=
[    1.791825] hub 1-0:1.0: 1 port detected=0A=
[    1.798368] mousedev: PS/2 mouse device common for all mice=0A=
[    1.809289] stmp3xxx-rtc 80056000.rtc: rtc core: registered 80056000.rtc=
 as rtc0=0A=
[    1.817578] i2c /dev entries driver=0A=
[    1.823272] stmp3xxx_rtc_wdt stmp3xxx_rtc_wdt: initialized watchdog with=
 heartbeat 19s=0A=
[    1.833634] of_get_named_gpio_flags exited with status 76=0A=
[    1.878880] mxs-mmc 80012000.ssp: initialized=0A=
[    1.887802] usbcore: registered new interface driver usbhid=0A=
[    1.893631] usbhid: USB HID core driver=0A=
[    1.902393] mxs-lradc 80050000.lradc: Touchscreen not enabled.=0A=
[    1.925086] TCP: cubic registered=0A=
[    1.928491] NET: Registered protocol family 17=0A=
[    1.934010] Key type dns_resolver registered=0A=
[    1.941379] registered taskstats version 1=0A=
[    1.951463] stmp3xxx-rtc 80056000.rtc: setting system clock to 1970-01-0=
1 00:21:15 UTC (1275)=0A=
[    1.973991] mmc0: BKOPS_EN bit is not set=0A=
[    1.991482] mmc0: new high speed MMC card at address 0001=0A=
[    1.998963] fec 800f0000.ethernet eth0: Freescale FEC PHY driver [SMSC L=
AN8710/LAN8720] (mii_bus:phy_addr=3D800f0000.etherne:00, irq=3D-1)=0A=
[    2.011564] mmcblk0: mmc0:0001 SEM02G 1.82 GiB =0A=
[    2.016804] mmcblk0boot0: mmc0:0001 SEM02G partition 1 1.00 MiB=0A=
[    2.024103] mmcblk0boot1: mmc0:0001 SEM02G partition 2 1.00 MiB=0A=
[    2.035524]  mmcblk0: p1 p2 p3 p4 < p5 p6 p7 >=0A=
[    2.053456]  mmcblk0boot1: unknown partition table=0A=
[    2.062682]  mmcblk0boot0: unknown partition table=0A=
[    3.989508] libphy: 800f0000.etherne:00 - Link is Up - 100/Full=0A=
[    4.019719] IP-Config: Gateway not on directly connected network=0A=
[    4.025792] ALSA device list:=0A=
[    4.028962]   No soundcards found.=0A=
[    4.066526] VFS: Mounted root (nfs filesystem) on device 0:11.=0A=
[    4.074463] devtmpfs: mounted=0A=
[    4.078876] Freeing unused kernel memory: 216K (c067e000 - c06b4000)=0A=
=0A=
=0A=
Thanks in advance,=0A=
Christoph=

