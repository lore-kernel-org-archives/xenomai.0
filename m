MIME-Version: 1.0
Date: Wed, 3 Jun 2015 15:00:33 +0200
Message-ID: <CAHH_qdD+0RnjOZejUuYp9Z7-7sSDfEE+c=sZGds3i_u=8zpKvg@mail.gmail.com>
From: Gautier HAOUY <gautier.haouy@gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: [Xenomai] [Xenomai 2.6] iMX6 + linux 3.16.7 + ipipe arm-7 +
 inconsistent lock state on kdevtmpfs
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Hello everyone,

I'm requesting once again your help as I'm getting an "INFO message on
inconsistent lock state" while booting linux 3.16.7 with ipipe arm-7 on an
iMX6 platform. I would like to understand how I could dive in and determine
if this is going to be an issue or just informational.

I kindly ask for assistance as I did not find anything on the internet on
how to proceed with such case.

Thank you in advance for you answers,
Best regards,
Gautier.

--- BOOT messages below ---

[    0.000000] Booting Linux on physical CPU 0x0
[    0.000000] Linux version 3.16.7-ipipe (gcc version 4.8.4 (Buildroot
2015.02-00739-gacb59a8) ) #2 SMP Tue Jun 2 1
8:38:50 CEST 2015
[    0.000000] CPU: ARMv7 Processor [412fc09a] revision 10 (ARMv7),
cr=10c5387d
[    0.000000] CPU: PIPT / VIPT nonaliasing data cache, VIPT aliasing
instruction cache
[    0.000000] Machine model: Armadeus APF6 i.MX6 Dual Lite Module on
APF6Dev Board
[    0.000000] Memory policy: Data cache writeback
[    0.000000] On node 0 totalpages: 131072
[    0.000000] free_area_init_node: node 0, pgdat 807bc780, node_mem_map
9fbfa000
[    0.000000]   Normal zone: 1024 pages used for memmap
[    0.000000]   Normal zone: 0 pages reserved
[    0.000000]   Normal zone: 131072 pages, LIFO batch:31
[    0.000000] CPU: All CPU(s) started in SVC mode.
[    0.000000] PERCPU: Embedded 10 pages/cpu @9fbc8000 s19712 r8192 d13056
u40960
[    0.000000] pcpu-alloc: s19712 r8192 d13056 u40960 alloc=10*4096
[    0.000000] pcpu-alloc: [0] 0 [0] 1
[    0.000000] Built 1 zonelists in Zone order, mobility grouping on.
Total pages: 130048
[    0.000000] Kernel command line: console=ttymxc3,115200
root=/dev/mmcblk1p2 ro rootfstype=ext4 rootwait
[    0.000000] PID hash table entries: 2048 (order: 1, 8192 bytes)
[    0.000000] Dentry cache hash table entries: 65536 (order: 6, 262144
bytes)
[    0.000000] Inode-cache hash table entries: 32768 (order: 5, 131072
bytes)
[    0.000000] Memory: 502848K/524288K available (5631K kernel code, 236K
rwdata, 1692K rodata, 331K init, 8799K bss, 21440K reserved)
[    0.000000] Virtual kernel memory layout:
    vector  : 0xffff0000 - 0xffff1000   (   4 kB)
    fixmap  : 0xffc00000 - 0xffe00000   (2048 kB)
    vmalloc : 0xa0800000 - 0xff000000   (1512 MB)
    lowmem  : 0x80000000 - 0xa0000000   ( 512 MB)
    modules : 0x7f000000 - 0x80000000   (  16 MB)
      .text : 0x80008000 - 0x8072efa4   (7324 kB)
      .init : 0x8072f000 - 0x80781d00   ( 332 kB)
      .data : 0x80782000 - 0x807bd100   ( 237 kB)
       .bss : 0x807bd108 - 0x81054dc8   (8800 kB)
[    0.000000] SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=2, Nodes=1
[    0.000000] Hierarchical RCU implementation.
[    0.000000]  RCU restricting CPUs from NR_CPUS=4 to nr_cpu_ids=2.
[    0.000000] RCU: Adjusting geometry for rcu_fanout_leaf=16, nr_cpu_ids=2
[    0.000000] NR_IRQS:16 nr_irqs:16 16
[    0.000000] L2C: DT/platform modifies aux control register: 0x32050000
-> 0x32850000
[    0.000000] L2C-310 erratum 769419 enabled
[    0.000000] L2C-310 enabling early BRESP for Cortex-A9
[    0.000000] L2C-310 full line of zeros enabled for Cortex-A9
[    0.000000] L2C-310 ID prefetch enabled, offset 1 lines
[    0.000000] L2C-310 dynamic clock gating enabled, standby mode enabled
[    0.000000] L2C-310 cache controller enabled, 16 ways, 512 kB
[    0.000000] L2C-310: CACHE_ID 0x410000c8, AUX_CTRL 0x76850001
[    0.000000] Switching to timer-based delay loop
[    0.000007] sched_clock: 32 bits at 66MHz, resolution 15ns, wraps every
65075262448ns
[    0.000051] I-pipe, 66.000 MHz clocksource, wrap in 65075 ms
[    0.000200] global-timer: unable to parse irq
[    0.000862] Interrupt pipeline (release #7)
[    0.001132] Console: colour dummy device 80x30
[    0.001162] Lock dependency validator: Copyright (c) 2006 Red Hat, Inc.,
Ingo Molnar
[    0.001171] ... MAX_LOCKDEP_SUBCLASSES:  8
[    0.001179] ... MAX_LOCK_DEPTH:          48
[    0.001186] ... MAX_LOCKDEP_KEYS:        8191
[    0.001194] ... CLASSHASH_SIZE:          4096
[    0.001201] ... MAX_LOCKDEP_ENTRIES:     32768
[    0.001209] ... MAX_LOCKDEP_CHAINS:      65536
[    0.001217] ... CHAINHASH_SIZE:          32768
[    0.001224]  memory used by lock dependency info: 5167 kB
[    0.001234]  per task-struct memory footprint: 1152 bytes
[    0.001260] Calibrating delay loop (skipped), value calculated using
timer frequency.. 132.00 BogoMIPS (lpj=660000)
[    0.001280] pid_max: default: 32768 minimum: 301
[    0.001675] Mount-cache hash table entries: 1024 (order: 0, 4096 bytes)
[    0.001694] Mountpoint-cache hash table entries: 1024 (order: 0, 4096
bytes)
[    0.003518] CPU: Testing write buffer coherency: ok
[    0.004272] CPU0: thread -1, cpu 0, socket 0, mpidr 80000000
[    0.004359] Setting up static identity map for 0x10585688 - 0x105856f8
[    0.007995] CPU1: failed to boot: -38
[    0.008177] Brought up 1 CPUs
[    0.008189] SMP: Total of 1 processors activated.
[    0.008199] CPU: All CPU(s) started in SVC mode.

[    0.010311] =================================
[    0.010319] [ INFO: inconsistent lock state ]
[    0.010330] 3.16.7-ipipe #2 Not tainted
[    0.010338] ---------------------------------
[    0.010347] inconsistent {SOFTIRQ-ON-W} -> {IN-SOFTIRQ-W} usage.
[    0.010358] kdevtmpfs/15 [HC0[0]:SC1[1]:HE0:SE0] takes:
[    0.010369]  (std_spinlock_raw(&p->pi_lock)){+.?...}, at: [<80050ae4>]
try_to_wake_up+0x30/0x314
[    0.010411] {SOFTIRQ-ON-W} state was registered at:
[    0.010420]   [<80063038>] trace_hardirqs_on_caller+0x134/0x1e4
[    0.010442]   [<800630fc>] trace_hardirqs_on+0x14/0x18
[    0.010457]   [<80013674>] __ipipe_fast_svc_irq_exit+0x4/0x18
[    0.010474]   [<80050e24>] default_wake_function+0x14/0x18
[    0.010489]   [<8005ddc0>] __wake_up_common+0x58/0x98
[    0.010504]   [<8005de1c>] __wake_up_locked+0x1c/0x24
[    0.010517]   [<8005e590>] complete+0x3c/0x4c
[    0.010530]   [<8037bac0>] devtmpfsd+0x94/0x318
[    0.010549]   [<80044918>] kthread+0xd0/0xec
[    0.010563]   [<8000ee80>] ret_from_fork+0x18/0x38
[    0.010584] irq event stamp: 171
[    0.010591] hardirqs last  enabled at (170): [<80584d4c>]
_raw_spin_unlock_irqrestore+0x40/0x48
[    0.010616] hardirqs last disabled at (171): [<80584bcc>]
_raw_spin_lock_irqsave+0x24/0x54
[    0.010632] softirqs last  enabled at (0): [<80025658>]
copy_process.part.60+0x3c0/0x1460
[    0.010653] softirqs last disabled at (161): [<8002bdc4>]
irq_exit+0xb8/0x10c
[    0.010674]
other info that might help us debug this:
[    0.010685]  Possible unsafe locking scenario:

[    0.010693]        CPU0
[    0.010701]        ----
[    0.010707]   lock(std_spinlock_raw(&p->pi_lock));
[    0.010723]   <Interrupt>
[    0.010729]     lock(std_spinlock_raw(&p->pi_lock));
[    0.010742]
 *** DEADLOCK ***

[    0.010755] 1 lock held by kdevtmpfs/15:
[    0.010762]  #0:  (&rsp->gp_wq){..-...}, at: [<8005e014>]
__wake_up+0x24/0x54
[    0.010796]
stack backtrace:
[    0.010811] CPU: 0 PID: 15 Comm: kdevtmpfs Not tainted 3.16.7-ipipe #2
[    0.010821] Backtrace:
[    0.010844] [<80012810>] (dump_backtrace) from [<80012af4>]
(show_stack+0x18/0x1c)
[    0.010854]  r6:807a0e18 r5:00000000 r4:00000000 r3:00000000
[    0.010887] [<80012adc>] (show_stack) from [<8057e090>]
(dump_stack+0x8c/0xa4)
[    0.010903] [<8057e004>] (dump_stack) from [<8057b418>]
(print_usage_bug+0x260/0x2d4)
[    0.010911]  r6:9f4b1380 r5:806a3c28 r4:808f1b10 r3:9f4bc000
[    0.010944] [<8057b1b8>] (print_usage_bug) from [<800629a0>]
(mark_lock+0x1e0/0x6b0)
[    0.010952]  r9:80061e2c r8:00000006 r7:9f4b1380 r6:00001054 r5:9f4b17e8
r4:00000004
[    0.010989] [<800627c0>] (mark_lock) from [<80063798>]
(__lock_acquire+0x348/0x1cdc)
[    0.010997]  r10:9f4bc010 r9:0000004b r8:807a0efc r7:80f6d7b4
r6:9f4b1380 r5:808ecb60
[    0.011026]  r4:9f47be68 r3:00000001
[    0.011048] [<80063450>] (__lock_acquire) from [<80065940>]
(lock_acquire+0x88/0xa4)
[    0.011057]  r10:00000000 r9:00000000 r8:00000000 r7:9f47be68
r6:00000080 r5:9f4bc000
[    0.011085]  r4:00000000
[    0.011103] [<800658b8>] (lock_acquire) from [<80584be8>]
(_raw_spin_lock_irqsave+0x40/0x54)
[    0.011111]  r10:8005e468 r9:00000000 r8:00000003 r7:00000000
r6:80050ae4 r5:00000001
[    0.011139]  r4:9f47be58
[    0.011160] [<80584ba8>] (_raw_spin_lock_irqsave) from [<80050ae4>]
(try_to_wake_up+0x30/0x314)
[    0.011167]  r6:80793b70 r5:9f47be58 r4:9f47ba80
[    0.011195] [<80050ab4>] (try_to_wake_up) from [<80050e24>]
(default_wake_function+0x14/0x18)
[    0.011202]  r10:8005e468 r9:00000003 r8:00000000 r7:00000000
r6:80793b70 r5:00000000
[    0.011231]  r4:9f49defc
[    0.011250] [<80050e10>] (default_wake_function) from [<8005e47c>]
(autoremove_wake_function+0x14/0x3c)
[    0.011265] [<8005e468>] (autoremove_wake_function) from [<8005ddc0>]
(__wake_up_common+0x58/0x98)
[    0.011273]  r4:80793b64 r3:00000000
[    0.011294] [<8005dd68>] (__wake_up_common) from [<8005e030>]
(__wake_up+0x40/0x54)
[    0.011303]  r10:80793a40 r9:00000009 r8:00000000 r7:00000003
r6:00000001 r5:00000000
[    0.011330]  r4:80793b50
[    0.011351] [<8005dff0>] (__wake_up) from [<8007596c>]
(rcu_gp_kthread_wake+0x54/0x58)
[    0.011360]  r8:9f4bc000 r7:40000007 r6:9fbc85c8 r5:00000001 r4:00000000
[    0.011395] [<80075918>] (rcu_gp_kthread_wake) from [<800778f0>]
(rcu_process_callbacks+0x308/0x5f4)
[    0.011413] [<800775e8>] (rcu_process_callbacks) from [<8002b918>]
(__do_softirq+0x118/0x2b0)
[    0.011422]  r10:00000100 r9:00000009 r8:9f4bc000 r7:40000007
r6:807840c8 r5:807840e4
[    0.011449]  r4:00000000
[    0.011467] [<8002b800>] (__do_softirq) from [<8002bdc4>]
(irq_exit+0xb8/0x10c)
[    0.011475]  r10:9fbc8a0c r9:9fbc8a1c r8:00000000 r7:00000057
r6:807801a0 r5:8078e254
[    0.011504]  r4:9f4bc020
[    0.011522] [<8002bd0c>] (irq_exit) from [<8000f740>]
(handle_IRQ+0x68/0xd8)
[    0.011530]  r5:8078e254 r4:8078a934
[    0.011559] [<8000f6d8>] (handle_IRQ) from [<8001abac>]
(__ipipe_do_IRQ+0x30/0x40)
[    0.011566]  r8:00000001 r7:80795630 r6:80fefa80 r5:9fbc8a0c r4:00000058
r3:8077fd50
[    0.011611] [<8001ab7c>] (__ipipe_do_IRQ) from [<80098214>]
(__ipipe_do_sync_stage+0x2dc/0x308)
[    0.011629] [<80097f38>] (__ipipe_do_sync_stage) from [<80098398>]
(ipipe_unstall_root+0x54/0x64)
[    0.011637]  r10:00000000 r9:00000000 r8:00000000 r7:8037ba2c
r6:00000000 r5:00000000
[    0.011666]  r4:807abd00
[    0.011690] [<80098344>] (ipipe_unstall_root) from [<80584d50>]
(_raw_spin_unlock_irqrestore+0x44/0x48)
[    0.011709] [<80584d0c>] (_raw_spin_unlock_irqrestore) from [<8005e59c>]
(complete+0x48/0x4c)
[    0.011717]  r5:807abcfc r4:807abd00
[    0.011741] [<8005e554>] (complete) from [<8037bac0>]
(devtmpfsd+0x94/0x318)
[    0.011749]  r6:9f475f2c r5:9f4bdeb6 r4:9f475f2c r3:9f001000
[    0.011778] [<8037ba2c>] (devtmpfsd) from [<80044918>]
(kthread+0xd0/0xec)
[    0.011787]  r10:00000000 r9:00000000 r8:00000000 r7:8037ba2c
r6:9f475f2c r5:9f442c00
[    0.011814]  r4:00000000
[    0.011831] [<80044848>] (kthread) from [<8000ee80>]
(ret_from_fork+0x18/0x38)
[    0.011838]  r7:00000000 r6:00000000 r5:80044848 r4:9f442c00
[    0.011886] devtmpfs: initialized
[    0.017943] VFP support v0.3: implementor 41 architecture 3 part 30
variant 9 rev 4
[    0.018614] pinctrl core: initialized pinctrl subsystem
[    0.019174] regulator-dummy: no parameters
[    0.030785] NET: Registered protocol family 16
[    0.031430] DMA: preallocated 256 KiB pool for atomic coherent
allocations
[    0.032615] CPU identified as i.MX6DL, silicon rev 1.1
[    0.044971] vdd1p1: 800 <--> 1375 mV at 1100 mV
[    0.045592] vdd3p0: 2800 <--> 3150 mV at 3000 mV
[    0.046207] vdd2p5: 2000 <--> 2750 mV at 2400 mV
[    0.046887] vddarm: 725 <--> 1450 mV at 1150 mV
[    0.047556] vddpu: 725 <--> 1450 mV at 1150 mV
[    0.048204] vddsoc: 725 <--> 1450 mV at 1175 mV
[    0.057759] hw-breakpoint: found 5 (+1 reserved) breakpoint and 1
watchpoint registers.
[    0.057773] hw-breakpoint: maximum watchpoint size is 4 bytes.
[    0.057805] I-pipe: disabling SMP code
[    0.059124] imx6dl-pinctrl 20e0000.iomuxc: initialized IMX pinctrl driver
[    0.074039] mxs-dma 110000.dma-apbh: initialized
[    0.074841] 3P3V: 3300 mV
[    0.075215] usb_h1_vbus: 5000 mV
[    0.075634] usb_otg_vbus: 5000 mV
[    0.076801] SCSI subsystem initialized
[    0.077253] usbcore: registered new interface driver usbfs
[    0.077367] usbcore: registered new interface driver hub
[    0.077576] usbcore: registered new device driver usb
[    0.078681] i2c i2c-0: IMX I2C adapter registered
[    0.078852] pps_core: LinuxPPS API ver. 1 registered
[    0.078864] pps_core: Software ver. 5.3.6 - Copyright 2005-2007 Rodolfo
Giometti <giometti@linux.it>
[    0.078911] PTP clock support registered
[    0.081031] Switched to clocksource ipipe_tsc
[    0.083335] cfg80211: Calling CRDA to update world regulatory domain
[    0.097777] NET: Registered protocol family 2
[    0.098661] TCP established hash table entries: 4096 (order: 2, 16384
bytes)
[    0.098764] TCP bind hash table entries: 4096 (order: 5, 147456 bytes)
[    0.099250] TCP: Hash tables configured (established 4096 bind 4096)
[    0.099311] TCP: reno registered
[    0.099334] UDP hash table entries: 256 (order: 2, 20480 bytes)
[    0.099418] UDP-Lite hash table entries: 256 (order: 2, 20480 bytes)
[    0.099871] NET: Registered protocol family 1
[    0.100356] RPC: Registered named UNIX socket transport module.
[    0.100370] RPC: Registered udp transport module.
[    0.100379] RPC: Registered tcp transport module.
[    0.100388] RPC: Registered tcp NFSv4.1 backchannel transport module.
[    0.101200] hw perfevents: enabled with ARMv7 Cortex-A9 PMU driver, 7
counters available
[    0.103198] futex hash table entries: 512 (order: 3, 32768 bytes)
[    0.103910] I-pipe: head domain Xenomai registered.
[    0.103934] Xenomai: hal/arm started.
[    0.104371] Xenomai: scheduling class idle registered.
[    0.104385] Xenomai: scheduling class rt registered.
[    0.111646] Xenomai: real-time nucleus v2.6.4 (Jumpin' Out) loaded.
[    0.111659] Xenomai: debug mode enabled.
[    0.112165] Xenomai: starting native API services.
[    0.112196] Xenomai: starting POSIX services.
[    0.112329] Xenomai: starting RTDM services.
[    0.121964] VFS: Disk quotas dquot_6.5.2
[    0.122260] Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)
