MIME-Version: 1.0
In-Reply-To: <CAEtr_LDsrbvTwb9fuyuHKASdT_Q5ofkDtOBbns7GvvTbvx7+AQ@mail.gmail.com>
References: <BLU436-SMTP153D5AD06FBFF11FA47585FF08B0@phx.gbl>
 <CAEtr_LDsrbvTwb9fuyuHKASdT_Q5ofkDtOBbns7GvvTbvx7+AQ@mail.gmail.com>
From: =?UTF-8?B?5byg56uL6ZGr?= <intelligentcodemail@gmail.com>
Date: Fri, 31 Jul 2015 10:09:15 +0800
Message-ID: <CAGFtc0YjVgOcF76nqmvtLn9O_ciQwhPwHn+jwFe9q-2Dta3azg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Xenomai] Raspberry Pi 2 patch - BCM2709
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Miguel Rubio-Roy <mrubioroy@gmail.com>
Cc: xenomai@xenomai.org

I also used the raspberry Pie 2, can share some experience?



2015-07-30 19:21 GMT+08:00 Miguel Rubio-Roy <mrubioroy@gmail.com>:

> On 30 July 2015 at 05:37, Mathieu <mathieu_rondonneau@hotmail.com> wrote:
>
> > In the mean time, I was wondering is anybody else succeed to get this
> > working or has any pointers on anything obvious missing.
> >
>
> I was stuck at the same point. I've been able to go a bit further (but not
> solve the original problem) by setting:
> CONFIG_DEBUG_PAGEALLOC=y
> CONFIG_DEBUG_MEMORY_INIT=y
>
> Then I see:
>
> Uncompressing Linux... done, booting the kernel.
> [    0.000000] Booting Linux on physical CPU 0xf00
> [    0.000000] Initializing cgroup subsys cpu
> [    0.000000] Initializing cgroup subsys cpuacct
> [    0.000000] Linux version 3.18.12-v7+ (mrubioroy@llrmrr) (gcc version
> 4.7.1 20120402 (prere5
> [    0.000000] CPU: ARMv7 Processor [410fc075] revision 5 (ARMv7),
> cr=10c5387d
> [    0.000000] CPU: PIPT / VIPT nonaliasing data cache, VIPT aliasing
> instruction cache
> [    0.000000] Machine: BCM2709
> [    0.000000] debug: ignoring loglevel setting.
> [    0.000000] bootconsole [earlycon0] enabled
> [    0.000000] cma: Reserved 8 MiB at 0x3a800000
> [    0.000000] Memory policy: Data cache writealloc
> [    0.000000] On node 0 totalpages: 241664
> [    0.000000] free_area_init_node: node 0, pgdat 8074f1c0, node_mem_map
> b9fa7000
> [    0.000000]   Normal zone: 2124 pages used for memmap
> [    0.000000]   Normal zone: 0 pages reserved
> [    0.000000]   Normal zone: 241664 pages, LIFO batch:31
> [    0.000000] mminit::memmap_init Initialising map node 0 zone 0 pfns 0 ->
> 241664
> [    0.000000] [bcm2709_smp_init_cpus] enter (8b00->f3003010)
> [    0.000000] [bcm2709_smp_init_cpus] ncores=4
> [    0.000000] PERCPU: Embedded 13 pages/cpu @b9f6e000 s22400 r8192 d22656
> u53248
> [    0.000000] pcpu-alloc: s22400 r8192 d22656 u53248 alloc=13*4096
> [    0.000000] pcpu-alloc: [0] 0 [0] 1 [0] 2 [0] 3
> [    0.000000] mminit::zonelist general 0:Normal = 0:Normal
> [    0.000000] Built 1 zonelists in Zone order, mobility grouping on.
> Total pages: 239540
> [    0.000000] Kernel command line: dma.dmachans=0x7f35
> bcm2708_fb.fbwidth=656 bcm2708_fb.fbhet
> [    0.000000] PID hash table entries: 4096 (order: 2, 16384 bytes)
> [    0.000000] Dentry cache hash table entries: 131072 (order: 7, 524288
> bytes)
> [    0.000000] Inode-cache hash table entries: 65536 (order: 6, 262144
> bytes)
> [    0.000000] Memory: 940468K/966656K available (5171K kernel code, 366K
> rwdata, 1524K rodata)
> [    0.000000] Virtual kernel memory layout:
> [    0.000000]     vector  : 0xffff0000 - 0xffff1000   (   4 kB)
> [    0.000000]     fixmap  : 0xffc00000 - 0xffe00000   (2048 kB)
> [    0.000000]     vmalloc : 0xbb800000 - 0xff000000   (1080 MB)
> [    0.000000]     lowmem  : 0x80000000 - 0xbb000000   ( 944 MB)
> [    0.000000]     modules : 0x7f000000 - 0x80000000   (  16 MB)
> [    0.000000]       .text : 0x80008000 - 0x80691e44   (6696 kB)
> [    0.000000]       .init : 0x80692000 - 0x806fa000   ( 416 kB)
> [    0.000000]       .data : 0x806fa000 - 0x80755bd4   ( 367 kB)
> [    0.000000]        .bss : 0x80755bd4 - 0x80842180   ( 946 kB)
> [    0.000000] SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=4, Nodes=1
> [    0.000000] Preemptible hierarchical RCU implementation.
> [    0.000000] NR_IRQS:608
> [    0.000000] Architected cp15 timer(s) running at 19.20MHz (virt).
> [    0.000000] I-pipe, 19.200 MHz clocksource, wrap in 960767920505705 ms
> [ 5875.515258] sched_clock: 56 bits at 19MHz, resolution 52ns, wraps every
> 3579139424256ns
> [ 5875.515258] Switching to timer-based delay loop, resolution 52ns
> [ 5875.515259] Interrupt pipeline (release #2)
> [    0.000003] Console: colour dummy device 80x30
> [ 5875.515261] Calibrating delay loop (skipped), value calculated using
> timer frequency.. 38.4)
> [ 5875.515259] pid_max: default: 32768 minimum: 301
> [ 5875.515258] Mount-cache hash table entries: 2048 (order: 1, 8192 bytes)
> [    0.000002] Mountpoint-cache hash table entries: 2048 (order: 1, 8192
> bytes)
> [ 5875.515259] Initializing cgroup subsys memory
> [ 5875.515259] Initializing cgroup subsys devices
> [ 5875.515258] Initializing cgroup subsys freezer
> [ 5875.515258] Initializing cgroup subsys net_cls
> [ 5875.515259] Initializing cgroup subsys blkio
> [ 5875.515258] CPU: Testing write buffer coherency: ok
> [ 5875.515259] ftrace: allocating 17387 entries in 51 pages
> [ 5875.515260] missing device node for CPU 0
> [ 5875.515258] missing device node for CPU 1
> [ 5875.515258] missing device node for CPU 2
> [ 5875.515260] missing device node for CPU 3
> [ 5875.515259] CPU0: thread -1, cpu 0, socket 15, mpidr 80000f00
> [ 5875.515262] [bcm2709_smp_prepare_cpus] enter
> [ 5875.515259] calling  trace_init_flags_sys_exit+0x0/0x28 @ 1
> [ 5875.515261] initcall trace_init_flags_sys_exit+0x0/0x28 returned 0 after
> 0 usecs
> [ 5875.515258] calling  trace_init_flags_sys_enter+0x0/0x28 @ 1
> [ 5875.515260] initcall trace_init_flags_sys_enter+0x0/0x28 returned 0
> after 0 usecs
> [ 5875.515259] calling  init_static_idmap+0x0/0x12c @ 1
> [ 5875.515261] Setting up static identity map for 0x4ab020 - 0x4ab054
> [ 5875.515259] initcall init_static_idmap+0x0/0x12c returned 0 after 0
> usecs
> [ 5875.515261] calling  spawn_ksoftirqd+0x0/0x30 @ 1
> _______________________________________________
> Xenomai mailing list
> Xenomai@xenomai.org
> http://xenomai.org/mailman/listinfo/xenomai
>
