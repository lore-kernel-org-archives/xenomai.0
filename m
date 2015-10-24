Message-ID: <BLU436-SMTP160BB080178058B582DE116F0250@phx.gbl>
From: Mathieu Rondonneau <mathieu_rondonneau@hotmail.com>
Date: Fri, 23 Oct 2015 21:21:27 -0700
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Support for Raspberry PI 2 B
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: lsorense@csclub.uwaterloo.ca, Wolfram.Wadepohl@ek-automation.com
Cc: xenomai@xenomai.org


On Thu, 22 Oct 2015 11:46:41 -0400 From: Lennart Sorensen
 >
 >On Thu, Oct 22, 2015 at 10:52:13AM +0200, Wolfram Wadepohl wrote:
 >> Hi,
 >> is ther supprot for the Raspberry PI2 Model B?
 >
 >I seem to recall someone mentioning working on it on the list a while
 >back, but I can't remember for sure.
 >Might want to search the mailing list archives.
 >There were some discussions about Pi 2 in June:
 >http://www.xenomai.org/pipermail/xenomai/2015-June/034366.html
 >I think at the time there was nothing working yet.


Hi Wolfram,

This is a background task for me (spare time).

With a modified patch, it boots up to when the power request is made to 
the video core (see console below).
It seems the mailbox handler is not registered properly into the ipipe 
patch.
even if it was, I think a better approach would be to create a 
dispatcher in the irq_ack callback of the armctrl_chip structure (since 
I got the interrupt from the videocore triggered there).
I don't think the videocore will play well with real-time here.

which lead to an intermediate milestone: only use a subset of the 
videocore for now (the part that get the other part of the chip going) 
and get xenomai going on RPI2.

On the console output below, only ipipe is enabled and videocore is 
still there.

Len is right, there is nothing working at that point except when you 
don't use the videocore then it gets further (with ipipe patch enabled) 
but can not load the root device (right before the prompt) and the mmc 
driver timeout.
My feelings tells me that since no request to the videocore went through 
(specially the power request), the videocore has not powered some part 
of the chips.

I am working on this when time permits.
The first one would be to get the power request handled properly.

Hope that makes sense.

Regards,
-Mathieu

Uncompressing Linux... done, booting the kernel.
[    0.000000] Booting Linux on physical CPU 0xf00
[    0.000000] Initializing cgroup subsys cpuset
[    0.000000] Initializing cgroup subsys cpu
[    0.000000] Initializing cgroup subsys cpuacct
[    0.000000] Linux version 3.18.16-v7+ (mathieu@mathieu-X58A-UD3R) 
(gcc version 4.9.3 20150113 (prerelease) (Linaro GCC 4.95
[    0.000000] CPU: ARMv7 Processor [410fc075] revision 5 (ARMv7), 
cr=10c5387d
[    0.000000] CPU: PIPT / VIPT nonaliasing data cache, VIPT aliasing 
instruction cache
[    0.000000] Machine model: Raspberry Pi 2 Model B
[    0.000000] bootconsole [earlycon0] enabled
[    0.000000] debug: ignoring loglevel setting.
[    0.000000] cma: Reserved 8 MiB at 0x3a800000
[    0.000000] Memory policy: Data cache writealloc
[    0.000000] On node 0 totalpages: 241664
[    0.000000] free_area_init_node: node 0, pgdat 8050f0c0, node_mem_map 
ba093000
[    0.000000]   Normal zone: 1888 pages used for memmap
[    0.000000]   Normal zone: 0 pages reserved
[    0.000000]   Normal zone: 241664 pages, LIFO batch:31
[    0.000000] [bcm2709_smp_init_cpus] enter (8820->f3003010)
[    0.000000] [bcm2709_smp_init_cpus] ncores=4
[    0.000000] PERCPU: Embedded 12 pages/cpu @ba059000 s17664 r8192 
d23296 u49152
[    0.000000] pcpu-alloc: s17664 r8192 d23296 u49152 alloc=12*4096
[    0.000000] pcpu-alloc: [0] 0 [0] 1 [0] 2 [0] 3
[    0.000000] Built 1 zonelists in Zone order, mobility grouping on. 
Total pages: 239776
[    0.000000] Kernel command line: dma.dmachans=0x7f35 
bcm2708_fb.fbwidth=1824 bcm2708_fb.fbheight=984 bcm2709.boardrev=0xa2t
[    0.000000] PID hash table entries: 4096 (order: 2, 16384 bytes)
[    0.000000] Dentry cache hash table entries: 131072 (order: 7, 524288 
bytes)
[    0.000000] Inode-cache hash table entries: 65536 (order: 6, 262144 
bytes)
[    0.000000] Memory: 944052K/966656K available (3515K kernel code, 
271K rwdata, 1132K rodata, 228K init, 616K bss, 22604K r)
[    0.000000] Virtual kernel memory layout:
[    0.000000]     vector  : 0xffff0000 - 0xffff1000   (   4 kB)
[    0.000000]     fixmap  : 0xffc00000 - 0xffe00000   (2048 kB)
[    0.000000]     vmalloc : 0xbb800000 - 0xff000000   (1080 MB)
[    0.000000]     lowmem  : 0x80000000 - 0xbb000000   ( 944 MB)
[    0.000000]     modules : 0x7f000000 - 0x80000000   (  16 MB)
[    0.000000]       .text : 0x80008000 - 0x80492034   (4649 kB)
[    0.000000]       .init : 0x80493000 - 0x804cc000   ( 228 kB)
[    0.000000]       .data : 0x804cc000 - 0x8050fd08   ( 272 kB)
[    0.000000]        .bss : 0x8050fd08 - 0x805a9f64   ( 617 kB)
[    0.000000] SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=4, Nodes=1
[    0.000000] Preemptible hierarchical RCU implementation.
[    0.000000] NR_IRQS:608
[    0.000000] Architected cp15 timer(s) running at 19.20MHz (virt).
[    0.000000] I-pipe, 19.200 MHz clocksource, wrap in 960767920505705 ms
[    0.000000] sched_clock: 56 bits at 19MHz, resolution 52ns, wraps 
every 3579139424256ns
[    0.000430] Switching to timer-based delay loop, resolution 52ns
[    0.000783] Interrupt pipeline (release #6)
[    0.001023] Console: colour dummy device 80x30
[    0.001264] Calibrating delay loop (skipped), value calculated using 
timer frequency.. 38.40 BogoMIPS (lpj=192000)
[    0.001818] pid_max: default: 32768 minimum: 301
[    0.002078] Mount-cache hash table entries: 2048 (order: 1, 8192 bytes)
[    0.002434] Mountpoint-cache hash table entries: 2048 (order: 1, 8192 
bytes)
[    0.002872] Initializing cgroup subsys memory
[    0.003110] Initializing cgroup subsys devices
[    0.003351] Initializing cgroup subsys freezer
[    0.003592] Initializing cgroup subsys blkio
[    0.003825] CPU: Testing write buffer coherency: ok
[    0.004120] CPU0: update cpu_capacity 1024
[    0.004342] CPU0: thread -1, cpu 0, socket 15, mpidr 80000f00
[    0.004651] [bcm2709_smp_prepare_cpus] enter
[    0.004887] Setting up static identity map for 0x3752a8 - 0x3752dc
[    0.059347] [bcm2709_boot_secondary] cpu:1 started (0) 18
[    0.059369] CPU1: Booted secondary processor
[    0.059369] [bcm2709_secondary_init] enter cpu:1
[    0.059373] CPU1: update cpu_capacity 1024
[    0.059373] CPU1: thread -1, cpu 1, socket 15, mpidr 80000f01
[    0.079347] [bcm2709_boot_secondary] cpu:2 started (0) 17
[    0.079369] CPU2: Booted secondary processor
[    0.079369] [bcm2709_secondary_init] enter cpu:2
[    0.079371] CPU2: update cpu_capacity 1024
[    0.079371] CPU2: thread -1, cpu 2, socket 15, mpidr 80000f02
[    0.099349] [bcm2709_boot_secondary] cpu:3 started (0) 18
[    0.099362] CPU3: Booted secondary processor
[    0.099362] [bcm2709_secondary_init] enter cpu:3
[    0.099363] CPU3: update cpu_capacity 1024
[    0.099364] CPU3: thread -1, cpu 3, socket 15, mpidr 80000f03
[    0.100644] Brought up 4 CPUs
[    0.100805] SMP: Total of 4 processors activated (153.60 BogoMIPS).
[    0.101140] CPU: All CPU(s) started in SVC mode.
[    0.101441] devtmpfs: initialized
[    0.102944] VFP support v0.3: implementor 41 architecture 2 part 30 
variant 7 rev 5
[    0.103415] pinctrl core: initialized pinctrl subsystem
[    0.104112] DMA: preallocated 4096 KiB pool for atomic coherent 
allocations
[    0.104540] bcm2709.uart_clock = 3000000
[    0.104900] hw-breakpoint: found 5 (+1 reserved) breakpoint and 4 
watchpoint registers.
[    0.105326] hw-breakpoint: maximum watchpoint size is 8 bytes.
[    0.105640] mailbox: Broadcom VideoCore Mailbox driver
[    0.105921] bcm2708_vcio: mailbox(65) at f300b880
[    0.106190] bcm_power: Broadcom power driver
[    0.106420] bcm_power_open() -> 0
[    0.106599] bcm_power_request(0, 8)

