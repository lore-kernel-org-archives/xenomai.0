MIME-Version: 1.0
In-Reply-To: <20150923115819.GA28513@hermes.click-hack.org>
References: <5600F8DE.30705@xenomai.org>
 <CAFkYNwaW5+nnDmumwt_zFFn01oWY5CsS5Fbmj1wB0aPF7om-4w@mail.gmail.com>
 <20150922174455.GA13976@hermes.click-hack.org>
 <CAFkYNwa-XGD+JM-5w6EGepO8XG2Ki9Tt+ocqgcd_zNmPCngdyA@mail.gmail.com>
 <CAFkYNwazPQ1D98f5xEyAh0CgYfE1ddkxxK_paF4v7YN_hbkT5Q@mail.gmail.com>
 <20150923054319.GE13976@hermes.click-hack.org>
 <20150923055416.GF13976@hermes.click-hack.org>
 <CAFkYNwYJ8sm5LbKZZ1e-kKdSZr-L16NTVKOpKpmu2LoKnc9tOg@mail.gmail.com>
 <20150923065657.GH13976@hermes.click-hack.org>
 <CAFkYNwZ-m6JU4_JN7dQGMNj6id4HFkTXijd5mwU5Ujhn2o=9Ug@mail.gmail.com>
 <20150923115819.GA28513@hermes.click-hack.org>
Date: Thu, 24 Sep 2015 03:36:04 +1200
Message-ID: <CAFkYNwZjZ0wUkwd_h00+sfwagBkwfc0NFYm0OYCphH3WacKvLQ@mail.gmail.com>
From: vibnwis <vibnwis@gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Xenomai] Xenomai tests
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

On 23 September 2015 at 23:58, Gilles Chanteperdrix <
gilles.chanteperdrix@xenomai.org> wrote:

> On Wed, Sep 23, 2015 at 10:38:05PM +1200, vibnwis wrote:
> > On 23 September 2015 at 18:56, Gilles Chanteperdrix <
> > gilles.chanteperdrix@xenomai.org> wrote:
> >
> > > On Wed, Sep 23, 2015 at 06:33:57PM +1200, vibnwis wrote:
> > > > On 23 September 2015 at 17:54, Gilles Chanteperdrix <
> > > > gilles.chanteperdrix@xenomai.org> wrote:
> > > >
> > > > > On Wed, Sep 23, 2015 at 07:43:19AM +0200, Gilles Chanteperdrix
> wrote:
> > > > > > On Wed, Sep 23, 2015 at 01:21:55PM +1200, vibnwis wrote:
> > > > > > > On 23 September 2015 at 12:41, vibnwis <vibnwis@gmail.com>
> wrote:
> > > > > > >
> > > > > > > >
> > > > > > > >
> > > > > > > > On 23 September 2015 at 05:44, Gilles Chanteperdrix <
> > > > > > > > gilles.chanteperdrix@xenomai.org> wrote:
> > > > > > > >
> > > > > > > >> On Wed, Sep 23, 2015 at 12:32:11AM +1200, vibnwis wrote:
> > > > > > > >> > By regenerating ./configure using autoreconf -fi, I
> managed to
> > > > > compile
> > > > > > > >> > xenomai-3-3.0-rc7 natively on PandaBoard. All things are
> put
> > > in
> > > > > their
> > > > > > > >> own
> > > > > > > >> > place by make install. However, when running latency, it
> > > produces
> > > > > > > >> >
> > > > > > > >> > > latency
> > > > > > > >> > 0"000.000| BUG in low_init(): [main] mlockall: Cannot
> allocate
> > > > > memory
> > > > > > > >>
> > > > > > > >> You should either run the latency test as root, or have a
> look
> > > at
> > > > > > > >> this page:
> > > > > > > >>
> > > > > > > >>
> > > > >
> > >
> http://xenomai.org/2014/06/running-a-xenomai-application-as-a-regular-user/
> > > > > > > >
> > > > > > > >
> > > > > > > Referring to the link, I have the following outcomes.
> > > > > > > /dev/rtpipe <- not exist
> > > > > > >
> > > > > > > /sys/module/xenomai/parameters/allowed_group <- not exist as
> > > > > > well
> > > > >
> > > > > So, this is probably because you are not running a kernel with
> > > > > xenomai support.
> > > > >
> > > > Since there isn't any 3.18.20 patch, should I use 3.18.12. It is
> still
> > > > 3.8.x. Should be alright ? I will give it a go.
> > >
> > > Please see my answer to your previous mail. You can use the patch
> > > for 3.18.20 with xenomai 3.0-rc7. I will revert back to 3.18.12.
> > >
> >
> > Tried it, but failed. See below.
> >
> > ./scripts/prepare-kernel.sh --arch=arm --linux=../linux-3.18.20
> > --ipipe=./kernel/cobalt/arch/arm/patches/ipipe-core-3.18.12-arm-4.patch
>
> ipipe-core-3.18.12* is for the Linux 3.18.12 kernel. The I-pipe
> patch for Linux 3.18.20 is named ipipe-core-3.18.20something
> --
>                                             Gilles.
> https://click-hack.org
>

While not able to disable these items CONFIG_TRACE_IRQFLAGS CONFIG_LOCKDEP,
I tried my luck on the patched ipipe-ipipe-core-3.18.12-arm-4. Obviously,
it still suffers the problem.

[    0.000000] Booting Linux on physical CPU 0x0
[    0.000000] Initializing cgroup subsys cpuset
[    0.000000] Initializing cgroup subsys cpu
[    0.000000] Initializing cgroup subsys cpuacct
[    0.000000] Linux version 3.18.12-ipipe (qws@qws-MacBookPro) (gcc
version 4.5
[    0.000000] CPU: ARMv7 Processor [412fc09a] revision 10 (ARMv7),
cr=10c5387d
[    0.000000] CPU: PIPT / VIPT nonaliasing data cache, VIPT aliasing
instructie
[    0.000000] Machine model: TI OMAP4 PandaBoard-ES
[    0.000000] cma: Reserved 16 MiB at 0xbe800000
[    0.000000] Memory policy: Data cache writealloc
[    0.000000] On node 0 totalpages: 261888
[    0.000000] free_area_init_node: node 0, pgdat c0982c40, node_mem_map
eeff900
[    0.000000]   Normal zone: 1520 pages used for memmap
[    0.000000]   Normal zone: 0 pages reserved
[    0.000000]   Normal zone: 194560 pages, LIFO batch:31
[    0.000000]   HighMem zone: 526 pages used for memmap
[    0.000000]   HighMem zone: 67328 pages, LIFO batch:15
[    0.000000] OMAP4460 ES1.1
[    0.000000] L2C: platform modifies aux control register: 0x0e070000 ->
0x3e40
[    0.000000] L2C: DT/platform modifies aux control register: 0x0e070000
-> 0x0
[    0.000000] L2C-310 enabling early BRESP for Cortex-A9
[    0.000000] L2C-310 ID prefetch enabled, offset 1 lines
[    0.000000] OMAP L2C310: ROM does not support power control setting
[    0.000000] L2C-310 dynamic clock gating disabled, standby mode disabled
[    0.000000] L2C-310 cache controller enabled, 16 ways, 1024 kB
[    0.000000] L2C-310: CACHE_ID 0x410000c7, AUX_CTRL 0x7ec70000
[    0.000000] PERCPU: Embedded 14 pages/cpu @eef95000 s25344 r8192 d23808
u5734
[    0.000000] pcpu-alloc: s25344 r8192 d23808 u57344 alloc=14*4096
[    0.000000] pcpu-alloc: [0] 0 [0] 1
[    0.000000] Built 1 zonelists in Zone order, mobility grouping on.
Total pa8
[    0.000000] Kernel command line: console=ttyO2,115200n8
root=/dev/mmcblk0p1 c
[    0.000000] PID hash table entries: 4096 (order: 2, 16384 bytes)
[    0.000000] Dentry cache hash table entries: 131072 (order: 7, 524288
bytes)
[    0.000000] Inode-cache hash table entries: 65536 (order: 6, 262144
bytes)
[    0.000000] allocated 2095104 bytes of page_cgroup
[    0.000000] please try 'cgroup_disable=memory' option if you don't want
memos
[    0.000000] Memory: 1001420K/1047552K available (6180K kernel code, 692K
rwd)
[    0.000000] Virtual kernel memory layout:
[    0.000000]     vector  : 0xffff0000 - 0xffff1000   (   4 kB)
[    0.000000]     fixmap  : 0xffc00000 - 0xffe00000   (2048 kB)
[    0.000000]     vmalloc : 0xf0000000 - 0xff000000   ( 240 MB)
[    0.000000]     lowmem  : 0xc0000000 - 0xef800000   ( 760 MB)
[    0.000000]     pkmap   : 0xbfe00000 - 0xc0000000   (   2 MB)
[    0.000000]     modules : 0xbf000000 - 0xbfe00000   (  14 MB)
[    0.000000]       .text : 0xc0008000 - 0xc085e2d8   (8537 kB)
[    0.000000]       .init : 0xc085f000 - 0xc08dc000   ( 500 kB)
[    0.000000]       .data : 0xc08dc000 - 0xc09892d0   ( 693 kB)
[    0.000000]        .bss : 0xc09892d0 - 0xc11d4430   (8493 kB)
[    0.000000] Hierarchical RCU implementation.
[    0.000000] NR_IRQS:16 nr_irqs:16 16
[    0.000000] ti_dt_clocks_register: failed to lookup clock node
bandgap_fclk
[    0.000000] OMAP clockevent source: timer1 at 32768 Hz
[    0.000000] sched_clock: 32 bits at 32kHz, resolution 30517ns, wraps
every 6s
[    0.000030] OMAP clocksource: 32k_counter at 32768 Hz
[    0.000183] I-pipe, 349.988 MHz timer
[    0.000313] sched_clock: 64 bits at 349MHz, resolution 2ns, wraps every
3141s
[    0.000331] I-pipe, 349.988 MHz clocksource, wrap in 12271 ms
[    0.001699] Interrupt pipeline (release #4)
[    0.002692] Console: colour dummy device 80x30
[    0.002744] Lock dependency validator: Copyright (c) 2006 Red Hat, Inc.,
Ingr
[    0.002755] ... MAX_LOCKDEP_SUBCLASSES:  8
[    0.002764] ... MAX_LOCK_DEPTH:          48
[    0.002773] ... MAX_LOCKDEP_KEYS:        8191
[    0.002782] ... CLASSHASH_SIZE:          4096
[    0.002791] ... MAX_LOCKDEP_ENTRIES:     32768
[    0.002800] ... MAX_LOCKDEP_CHAINS:      65536
[    0.002808] ... CHAINHASH_SIZE:          32768
[    0.002817]  memory used by lock dependency info: 5167 kB
[    0.002826]  per task-struct memory footprint: 1152 bytes
[    0.002856] Calibrating delay loop... 1391.00 BogoMIPS (lpj=6955008)
[    0.080229] pid_max: default: 32768 minimum: 301
[    0.080690] Security Framework initialized
[    0.080896] Mount-cache hash table entries: 2048 (order: 1, 8192 bytes)
[    0.080917] Mountpoint-cache hash table entries: 2048 (order: 1, 8192
bytes)
[    0.083879] Initializing cgroup subsys memory
[    0.083950] Initializing cgroup subsys devices
[    0.084042] Initializing cgroup subsys freezer
[    0.084127] Initializing cgroup subsys blkio
[    0.084214] Initializing cgroup subsys perf_event
[    0.084300] CPU: Testing write buffer coherency: ok
[    0.085562] CPU0: thread -1, cpu 0, socket 0, mpidr 80000000
[    0.085653] Setting up static identity map for 0x805e3180 - 0x805e31f0
[    0.092103] CPU1: Booted secondary processor
[    0.092127] I-pipe, 349.988 MHz timer
[    0.180228] CPU1: thread -1, cpu 1, socket 0, mpidr 80000001
[    0.180765] Brought up 2 CPUs
[    0.180794] SMP: Total of 2 processors activated (2788.55 BogoMIPS).
[    0.180804] CPU: All CPU(s) started in SVC mode.
[    0.183974] devtmpfs: initialized
[    0.197472] VFP support v0.3: implementor 41 architecture 3 part 30
variant 4
[    0.203561] omap_hwmod: l3_main_3 using broken dt data from ocp
[    0.209291] omap_hwmod: l3_main_2 using broken dt data from ocp
[    0.426195] pinctrl core: initialized pinctrl subsystem
[    0.428946] regulator-dummy: no parameters
[    0.495204] NET: Registered protocol family 16
[    0.501218] DMA: preallocated 256 KiB pool for atomic coherent
allocations
[    0.516431] gpiochip_add: registered GPIOs 0 to 31 on device: gpio
[    0.517486] OMAP GPIO hardware version 0.1
[    0.518818] gpiochip_add: registered GPIOs 32 to 63 on device: gpio
[    0.521062] gpiochip_add: registered GPIOs 64 to 95 on device: gpio
[    0.523238] gpiochip_add: registered GPIOs 96 to 127 on device: gpio
[    0.525357] gpiochip_add: registered GPIOs 128 to 159 on device: gpio
[    0.527551] gpiochip_add: registered GPIOs 160 to 191 on device: gpio
[    0.529296] omap-gpmc 50000000.gpmc: GPMC revision 6.0
[    0.530389] irq: no irq domain found for /ocp/pinmux@4a100040 !
[    0.531046] irq: no irq domain found for /ocp/pinmux@4a100040 !
[    0.531697] irq: no irq domain found for /ocp/pinmux@4a100040 !
[    0.555409] platform 4b501000.aes: Cannot lookup hwmod 'aes'
[    0.556010] platform 480a5000.des: Cannot lookup hwmod 'des'
[    0.566634] No ATAGs?
[    0.566709] hw-breakpoint: found 5 (+1 reserved) breakpoint and 1
watchpoint.
[    0.566722] hw-breakpoint: maximum watchpoint size is 4 bytes.
[    0.569875] OMAP DMA hardware revision 0.0
[    0.623730]
[    0.623744] =================================
[    0.623753] [ INFO: inconsistent lock state ]
[    0.623764] 3.18.12-ipipe #1 Not tainted
[    0.623773] ---------------------------------
[    0.623783] inconsistent {IN-HARDIRQ-W} -> {HARDIRQ-ON-W} usage.
[    0.623795] kblockd/22 [HC0[0]:SC0[0]:HE1:SE1] takes:
[    0.623804]  (std_spinlock_raw(&rq->lock)){?.-...}, at: [<c05db640>]
__sched4
[    0.623844] {IN-HARDIRQ-W} state was registered at:
[    0.623852]   [<c05e0538>] _raw_spin_lock+0x28/0x38
[    0.623869]   [<c006797c>] scheduler_tick+0x38/0xd4
[    0.623886]   [<c00a0820>] update_process_times+0x54/0x60
[    0.623905]   [<c00ae070>] tick_periodic+0x30/0xec
[    0.623923]   [<c00ae2f0>] tick_handle_periodic+0x28/0x88
[    0.623938]   [<c0014f9c>] twd_handler+0x38/0x44
[    0.623955]   [<c0094250>] handle_percpu_devid_irq+0x78/0x178
[    0.623971]   [<c0090eb4>] generic_handle_irq+0x28/0x3c
[    0.623993]   [<c00911a4>] __handle_domain_irq+0x64/0xc4
[    0.624008]   [<c00d3880>] __ipipe_do_sync_stage+0x288/0x2d0
[    0.624025]   [<c0008634>] __ipipe_grab_irq+0x5c/0x70
[    0.624039]   [<c0008948>] gic_handle_irq+0x28/0x60
[    0.624053]   [<eefb3980>] 0xeefb3980
[    0.624065]   [<c05e1124>] __irq_svc+0x44/0x50
[    0.624081]   [<c00095a0>] calibrate_delay+0x3a4/0x5b8
[    0.624096]   [<c00095a0>] calibrate_delay+0x3a4/0x5b8
[    0.624109]   [<c085fbc4>] start_kernel+0x314/0x3d4
[    0.624124]   [<80008074>] 0x80008074
[    0.624137] irq event stamp: 14
[    0.624145] hardirqs last  enabled at (13): [<c05e07a8>]
_raw_spin_unlock_irc
[    0.624161] hardirqs last disabled at (14): [<c05e06c0>]
_raw_spin_lock_irq+4
[    0.624175] softirqs last  enabled at (0): [<c003ffbc>]
copy_process.part.554
[    0.624195] softirqs last disabled at (0): [<  (null)>]   (null)
[    0.624207]
[    0.624207] other info that might help us debug this:
[    0.624217]  Possible unsafe locking scenario:
[    0.624217]
[    0.624227]        CPU0
[    0.624235]        ----
[    0.624242]   lock(std_spinlock_raw(&rq->lock));
[    0.624256]   <Interrupt>
[    0.624263]     lock(std_spinlock_raw(&rq->lock));
[    0.624277]
[    0.624277]  *** DEADLOCK ***
[    0.624277]
[    0.624291] 1 lock held by kblockd/22:
[    0.624299]  #0:  (std_spinlock_raw(&rq->lock)){?.-...}, at:
[<c05db640>] __4
[    0.624331]
[    0.624331] stack backtrace:
[    0.624347] CPU: 1 PID: 22 Comm: kblockd Not tainted 3.18.12-ipipe #1
[    0.624388] [<c0015edc>] (unwind_backtrace) from [<c001260c>]
(show_stack+0x)
[    0.624410] [<c001260c>] (show_stack) from [<c05da8e8>]
(dump_stack+0x84/0x9)
[    0.624438] [<c05da8e8>] (dump_stack) from [<c0084480>]
(print_usage_bug+0x1)
[    0.624457] [<c0084480>] (print_usage_bug) from [<c0084764>]
(mark_lock+0x1e)
[    0.624476] [<c0084764>] (mark_lock) from [<c0084cd4>]
(mark_held_locks+0x70)
[    0.624495] [<c0084cd4>] (mark_held_locks) from [<c0084d78>]
(trace_hardirqs)
[    0.624514] [<c0084d78>] (trace_hardirqs_on_caller) from [<c05e1134>]
(__ipi)
[    0.624537] [<c05e1134>] (__ipipe_fast_svc_irq_exit) from [<c0058870>]
(wq_w)
[    0.624556] [<c0058870>] (wq_worker_sleeping) from [<c05dba8c>]
(__schedule+)
[    0.624575] [<c05dba8c>] (__schedule) from [<c0057cc0>]
(rescuer_thread+0x1b)
[    0.624596] [<c0057cc0>] (rescuer_thread) from [<c005c810>]
(kthread+0xc8/0x)
[    0.624614] [<c005c810>] (kthread) from [<c000eb00>]
(ret_from_fork+0x18/0x3)
[    0.648145] omap-dma-engine 4a056000.dma-controller: OMAP DMA engine
driver
[    0.648852] of_get_named_gpiod_flags: parsed 'gpio' property of node
'/hsusb)
[    0.720241] hsusb1_vbus: 3300 mV
[    0.720458] reg-fixed-voltage wl12xx_vmmc: could not find pctldev for
node /e
[    0.720484] platform wl12xx_vmmc: Driver reg-fixed-voltage requests
probe del
[    0.724086] SCSI subsystem initialized
[    0.724613] usbcore: registered new interface driver usbfs
[    0.724731] usbcore: registered new interface driver hub
[    0.724844] usbcore: registered new device driver usb
[    0.725167] of_get_named_gpiod_flags: parsed 'reset-gpios' property of
node )
[    0.725855] omap_i2c 48070000.i2c: could not find pctldev for node
/ocp/pinme
[    0.725881] platform 48070000.i2c: Driver omap_i2c requests probe
deferral
[    0.725935] omap_i2c 48072000.i2c: could not find pctldev for node
/ocp/pinme
[    0.725958] platform 48072000.i2c: Driver omap_i2c requests probe
deferral
[    0.726007] omap_i2c 48060000.i2c: could not find pctldev for node
/ocp/pinme
[    0.726029] platform 48060000.i2c: Driver omap_i2c requests probe
deferral
[    0.726077] omap_i2c 48350000.i2c: could not find pctldev for node
/ocp/pinme
[    0.726097] platform 48350000.i2c: Driver omap_i2c requests probe
deferral
[    0.727915] Switched to clocksource ipipe_tsc
[    0.822234] NET: Registered protocol family 2
[    0.823173] TCP established hash table entries: 8192 (order: 3, 32768
bytes)
[    0.823352] TCP bind hash table entries: 8192 (order: 6, 294912 bytes)
[    0.824242] TCP: Hash tables configured (established 8192 bind 8192)
[    0.824326] TCP: reno registered
[    0.824351] UDP hash table entries: 512 (order: 3, 40960 bytes)
[    0.824493] UDP-Lite hash table entries: 512 (order: 3, 40960 bytes)
[    0.825010] NET: Registered protocol family 1
[    0.825532] RPC: Registered named UNIX socket transport module.
[    0.825546] RPC: Registered udp transport module.
[    0.825557] RPC: Registered tcp transport module.
[    0.825567] RPC: Registered tcp NFSv4.1 backchannel transport module.
[    0.826669] hw perfevents: enabled with armv7_cortex_a9 PMU driver, 7
countee
[    0.829999] futex hash table entries: 512 (order: 3, 32768 bytes)
[    0.830169] audit: initializing netlink subsys (disabled)
[    0.830227] audit: type=2000 audit(0.820:1): initialized
[    0.831084] [Xenomai] scheduling class idle registered.
[    0.831097] [Xenomai] scheduling class rt registered.
[    0.831298] I-pipe: head domain Xenomai registered.
[    0.833495] [Xenomai] Cobalt v3.0-rc7 (Exact Zero)
[    0.834750] VFS: Disk quotas dquot_6.5.2
[    0.834871] Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)
[    0.836029] NFS: Registering the id_resolver key type
[    0.836075] Key type id_resolver registered
[    0.836087] Key type id_legacy registered
[    0.836184] jffs2: version 2.2. (NAND) (SUMMARY)
\xffffffc2\xffffffa9\xffff.
[    0.836534] msgmni has been set to 1461
[    0.838483] bounce: pool size: 64 pages
[    0.838509] io scheduler noop registered
[    0.838530] io scheduler deadline registered
[    0.838606] io scheduler cfq registered (default)
[    0.841863] pinctrl-single 4a100040.pinmux: 203 pins at pa fc100040 size
406
[    0.842192] pinctrl-single 4a31e040.pinmux: 28 pins at pa fc31e040 size
56
[    0.844191] pbias_mmc_omap4: 1800 <--> 3000 mV at 3000 mV
[    0.845187] abb_mpu: 1025 <--> 1389 mV
[    0.845689] abb_iva: 950 <--> 1376 mV
[    0.846750] Serial: 8250/16550 driver, 4 ports, IRQ sharing enabled
[    0.849967] omap_uart 4806a000.serial: no wakeirq for uart0
[    0.849990] of_get_named_gpiod_flags: can't parse 'rts-gpio' property of
nod'
[    0.850159] 4806a000.serial: ttyO0 at MMIO 0x4806a000 (irq = 104,
base_baud 0
[    0.850838] of_get_named_gpiod_flags: can't parse 'rts-gpio' property of
nod'
[    0.850990] 4806c000.serial: ttyO1 at MMIO 0x4806c000 (irq = 105,
base_baud 1
[    0.851632] of_get_named_gpiod_flags: can't parse 'rts-gpio' property of
nod'
[    0.851790] 48020000.serial: ttyO2 at MMIO 0x48020000 (irq = 106,
base_baud 2
[    2.267692] console [ttyO2] enabled
[    2.272047] of_get_named_gpiod_flags: can't parse 'rts-gpio' property of
nod'
[    2.282045] 4806e000.serial: ttyO3 at MMIO 0x4806e000 (irq = 102,
base_baud 3
[    2.306247] brd: module loaded
[    2.316318] loop: module loaded
[    2.321577] mtdoops: mtd device (mtddev=name/number) must be supplied
[    2.332955] usbcore: registered new interface driver asix
[    2.338742] usbcore: registered new interface driver ax88179_178a
[    2.345203] usbcore: registered new interface driver cdc_ether
[    2.351450] usbcore: registered new interface driver smsc95xx
[    2.357541] usbcore: registered new interface driver net1080
[    2.363581] usbcore: registered new interface driver cdc_subset
[    2.369887] usbcore: registered new interface driver zaurus
[    2.375856] usbcore: registered new interface driver cdc_ncm
[    2.382346] usbcore: registered new interface driver cdc_wdm
[    2.388431] usbcore: registered new interface driver usb-storage
[    2.394827] usbcore: registered new interface driver usbtest
[    2.401972] mousedev: PS/2 mouse device common for all mice
[    2.409529] i2c /dev entries driver
[    2.413224] Driver for 1-wire Dallas network protocol.
[    2.419284] of_get_named_gpiod_flags: parsed 'gpios' property of node
'/ocp/)
[    2.430691] omap_wdt: OMAP Watchdog Timer Rev 0x01: initial timeout 60
sec
[    2.439049] of_get_named_gpiod_flags: can't parse 'cd-gpios' property of
nod'
[    2.448619] of_get_named_gpiod_flags: can't parse 'wp-gpios' property of
nod'
[    2.458530] omap_hsmmc 4809c000.mmc: unable to get vmmc regulator -517
[    2.465431] platform 4809c000.mmc: Driver omap_hsmmc requests probe
deferral
[    2.472954] of_get_named_gpiod_flags: can't parse 'cd-gpios' property of
nod'
[    2.482519] of_get_named_gpiod_flags: can't parse 'wp-gpios' property of
nod'
[    2.492370] omap_hsmmc 480d5000.mmc: unable to get vmmc regulator -517
[    2.499296] platform 480d5000.mmc: Driver omap_hsmmc requests probe
deferral
[    2.507279] of_get_named_gpiod_flags: parsed 'gpios' property of node
'/leds)
[    2.517135] of_get_named_gpiod_flags: parsed 'gpios' property of node
'/leds)
[    2.526452] of_get_named_gpiod_flags: parsed 'gpios' property of node
'/leds)
[    2.536530] of_get_named_gpiod_flags: parsed 'gpios' property of node
'/leds)
[    2.546194] ledtrig-cpu: registered to indicate activity on CPUs
[    2.552840] usbcore: registered new interface driver usbhid
[    2.558682] usbhid: USB HID core driver
[    2.564809] oprofile: using arm/armv7-ca9
[    2.569350] TCP: cubic registered
[    2.572840] Initializing XFRM netlink socket
[    2.577347] NET: Registered protocol family 17
[    2.582076] NET: Registered protocol family 15
[    2.586834] Key type dns_resolver registered
[    2.591484] twl: not initialized
[    2.594859] twl6030_uv_to_vsel:OUT OF RANGE! non mapped vsel for 1375000
Vs 0
[    2.603244] twl6030_uv_to_vsel:OUT OF RANGE! non mapped vsel for 1375000
Vs 0
[    2.611650] twl6030_uv_to_vsel:OUT OF RANGE! non mapped vsel for 1375000
Vs 0
[    2.620034] twl6030_uv_to_vsel:OUT OF RANGE! non mapped vsel for 1375000
Vs 0
[    2.628433] twl6030_uv_to_vsel:OUT OF RANGE! non mapped vsel for 1375000
Vs 0
[    2.636791] twl6030_uv_to_vsel:OUT OF RANGE! non mapped vsel for 1375000
Vs 0
[    2.645176] twl6030_uv_to_vsel:OUT OF RANGE! non mapped vsel for 1410000
Vs 0
[    2.653572] omap2_set_init_voltage: unable to find boot up OPP for
vdd_mpu
[    2.660774] omap2_set_init_voltage: unable to set vdd_mpu
[    2.666424] omap2_set_init_voltage: unable to find boot up OPP for
vdd_core
[    2.673724] omap2_set_init_voltage: unable to set vdd_core
[    2.679487] omap2_set_init_voltage: unable to find boot up OPP for
vdd_iva
[    2.686665] omap2_set_init_voltage: unable to set vdd_iva
[    2.693601] Power Management for TI OMAP4+ devices.
[    2.698733] OMAP4 PM: u-boot >= v2012.07 is required for full PM support
[    2.705902] ThumbEE CPU extension supported.
[    2.710441] Registering SWP/SWPB emulation handler
[    2.715461] SmartReflex Class3 initialized
[    2.722189] of_get_named_gpiod_flags: parsed 'gpio' property of node
'/wl12x)
[    2.731955] vwl1271: 1800 mV
[    2.738244] Skipping twl internal clock init and using bootloader value
(unk)
[    2.747506] twl 0-0048: PIH (irq 39) nested IRQs
[    2.753340] twl_rtc 48070000.i2c:twl@48:rtc: Power up reset detected.
[    2.760937] twl_rtc 48070000.i2c:twl@48:rtc: Enabling TWL-RTC
[    2.770049] twl_rtc 48070000.i2c:twl@48:rtc: rtc core: registered
48070000.i0
[    2.779984] VAUX1_6030: 1000 <--> 3000 mV at 2800 mV
[    2.786424] VAUX2_6030: 1200 <--> 2800 mV at 1800 mV
[    2.792925] VAUX3_6030: 1000 <--> 3000 mV at 1200 mV
[    2.799412] VMMC: 1200 <--> 3000 mV at 3000 mV
[    2.805308] VPP: 1800 <--> 2500 mV at 1900 mV
[    2.811166] VUSIM: 1200 <--> 2900 mV at 1800 mV
[    2.816919] VDAC: 1800 mV
[    2.820511] VANA: 2100 mV
[    2.824459] VCXIO: 1800 mV
[    2.828180] VUSB: 3300 mV
[    2.832133] V1V8: 1800 mV
[    2.836054] V2V1: 2100 mV
[    2.841773] twl6040 0-004b: clk32k is not handled
[    2.848193] of_get_named_gpiod_flags: parsed 'ti,audpwron-gpio' property
of )
[    2.861369] omap_i2c 48070000.i2c: bus 0 rev0.11 at 400 kHz
[    2.868303] omap_i2c 48072000.i2c: bus 1 rev0.11 at 400 kHz
[    2.875701] omap_i2c 48060000.i2c: bus 2 rev0.11 at 100 kHz
[    2.882569] omap_i2c 48350000.i2c: bus 3 rev0.11 at 400 kHz
[    2.888745] of_get_named_gpiod_flags: can't parse 'cd-gpios' property of
nod'
[    2.898370] of_get_named_gpiod_flags: can't parse 'wp-gpios' property of
nod'
[    2.948397] of_get_named_gpiod_flags: can't parse 'cd-gpios' property of
nod'
[    2.958044] of_get_named_gpiod_flags: can't parse 'wp-gpios' property of
nod'
[    3.090248] twl_rtc 48070000.i2c:twl@48:rtc: setting system clock to
2000-01)
[    3.100222] sr_init: No PMIC hook to init smartreflex
[    3.105763] smartreflex smartreflex.0: omap_sr_probe: SmartReflex driver
inid
[    3.114274] smartreflex smartreflex.1: omap_sr_probe: SmartReflex driver
inid
[    3.122781] smartreflex smartreflex.2: omap_sr_probe: SmartReflex driver
inid
[    3.157412] VUSB: disabling
[    3.161004] VANA: disabling
[    3.164521] VDAC: disabling
[    3.170776] Waiting for root device /dev/mmcblk0p1...
[    3.205076] mmc0: host does not support reading read-only switch,
assuming we
[    3.215326] mmc0: new high speed SDHC card at address 0001
[    3.221791] mmcblk0: mmc0:0001 00000 3.73 GiB
[    3.228402]  mmcblk0: p1
[    3.236636] omap_hsmmc 480d5000.mmc: card claims to support voltages
below de
[    3.256445] mmc1: queuing unknown CIS tuple 0x91 (3 bytes)
[    3.264678] mmc1: new SDIO card at address 0001
[    3.281726] EXT4-fs (mmcblk0p1): INFO: recovery required on readonly
filesysm
[    3.289434] EXT4-fs (mmcblk0p1): write access will be enabled during
recovery
[    5.220723] EXT4-fs (mmcblk0p1): recovery complete
[    5.346414] EXT4-fs (mmcblk0p1): mounted filesystem with ordered data
mode. )
[    5.355010] VFS: Mounted root (ext4 filesystem) readonly on device 179:1.
[    5.363453] devtmpfs: mounted
[    5.367154] Freeing unused kernel memory: 500K (c085f000 - c08dc000)
[    5.804425] random: init urandom read with 25 bits of entropy available
[    6.038568] init: plymouth-upstart-bridge main process (64) terminated
with 1
[    6.047275] init: plymouth-upstart-bridge main process ended, respawning
[    6.109836] init: plymouth-upstart-bridge main process (74) terminated
with 1
[    6.118101] init: plymouth-upstart-bridge main process ended, respawning
[    6.151333] init: plymouth-upstart-bridge main process (77) terminated
with 1
[    6.164019] init: plymouth-upstart-bridge main process ended, respawning
[    6.212263] init: plymouth-upstart-bridge main process (79) terminated
with 1
[    6.220638] init: plymouth-upstart-bridge main process ended, respawning
[    6.271148] init: ureadahead main process (67) terminated with status 5
[    7.412464] systemd-udevd[191]: starting version 204
[    8.605289] OMAP DSS rev 4.0
[    8.661348] of_get_named_gpiod_flags: parsed 'gpios' property of node
'/enco)
[    8.661389] of_get_named_gpiod_flags: parsed 'gpios' property of node
'/enco)
[    8.661425] of_get_named_gpiod_flags: parsed 'gpios' property of node
'/enco)
[    8.683465] connector-dvi connector@0: failed to find video source
[    8.690053] platform connector@0: Driver connector-dvi requests probe
deferrl
[    8.691548] of_get_named_gpiod_flags: can't parse 'hpd-gpios' property
of no'
[    8.692526] connector-dvi connector@0: failed to find video source
[    8.699103] platform connector@0: Driver connector-dvi requests probe
deferrl
[    8.700439] of_get_named_gpiod_flags: parsed 'powerdown-gpios' property
of n)
[    8.823853] Console: switching to colour frame buffer device 240x67
[    8.929143] omapfb omapfb: using display 'dvi' mode 1920x1080
[    9.179119] EXT4-fs (mmcblk0p1): re-mounted. Opts: errors=remount-ro
[    9.785174] cfg80211: Calling CRDA to update world regulatory domain
[    9.822683] omap-abe-twl6040 sound: twl6040-legacy <-> 40132000.mcpdm
mappink
[   10.623772] random: nonblocking pool is initialized
[   11.308232] wlcore: loaded
[   11.528889] init: failsafe main process (404) killed by TERM signal
[   12.621987] init: avahi-cups-reload main process (513) terminated with
statu1
[   13.054446] NET: Registered protocol family 10
[   13.258077] init: plymouth-upstart-bridge main process ended, respawning
[   13.806691] init: lxdm main process (605) terminated with status 127
[   16.915965] init: plymouth-stop pre-start process (825) terminated with
stat1
