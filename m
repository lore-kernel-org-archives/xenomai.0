Message-ID: <BLU436-SMTP2341E4F3C6743571E209C51F0600@phx.gbl>
Date: Tue, 25 Aug 2015 20:13:56 -0700
From: Mathieu Rondonneau <mathieu_rondonneau@hotmail.com>
MIME-Version: 1.0
References: <BLU437-SMTP62CAA597299A3591E31BB9F0760@phx.gbl>
 <20150804134759.GA22015@hermes.click-hack.org>
 <BLU437-SMTP30F50D247E17894FAB1735F0720@phx.gbl>
 <BLU436-SMTP11876665B97EA0A9B12E707F0600@phx.gbl>
In-Reply-To: <BLU436-SMTP11876665B97EA0A9B12E707F0600@phx.gbl>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Raspberry Pi 2 - ipipe patch - BCM2709
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Miguel Rubio-Roy <mrubioroy@gmail.com>, xenomai@xenomai.org

On 15-08-25 08:07 PM, Mathieu Rondonneau wrote:
> Some progress using the ARM timer since I made some progress lately.
>
> it is stuck waiting for the response (mailbox) from the videocore
> regarding power settings request (always ON).
>
> I have to find out if the interrupt has triggered or not (maybe masked
> by ipipe?).
>
> Looks like there is still some work to do on the interrupt binding level.
>
> on the bright side, if I comment out the power settings (that triggers
> the read to the mailbox) then it gets really close to the prompt!
>
> -Mathieu
>
> Uncompressing Linux... done, booting the kernel.
> [    0.000000] Booting Linux on physical CPU 0xf00
> [    0.000000] Initializing cgroup subsys cpuset
> [    0.000000] Initializing cgroup subsys cpu
> [    0.000000] Initializing cgroup subsys cpuacct
> [    0.000000] Linux version 3.18.16-v7+ (mathieu@mathieu-X58A-UD3R)
> (gcc version 4.9.3 20150113 (prerelease) (Linaro GCC 4.9-2015.01-3) )
> #125 SMP PREEMPT Mon Aug 24 20:03:52 PDT 2015
> [    0.000000] CPU: ARMv7 Processor [410fc075] revision 5 (ARMv7),
> cr=10c5387d
> [    0.000000] CPU: PIPT / VIPT nonaliasing data cache, VIPT aliasing
> instruction cache
> [    0.000000] Machine model: Raspberry Pi 2 Model B
> [    0.000000] bootconsole [earlycon0] enabled
> [    0.000000] debug: ignoring loglevel setting.
> [    0.000000] cma: Reserved 8 MiB at 0x3a800000
> [    0.000000] Memory policy: Data cache writealloc
> [    0.000000] On node 0 totalpages: 241664
> [    0.000000] free_area_init_node: node 0, pgdat 804da300, node_mem_map
> ba093000
> [    0.000000]   Normal zone: 1888 pages used for memmap
> [    0.000000]   Normal zone: 0 pages reserved
> [    0.000000]   Normal zone: 241664 pages, LIFO batch:31
> [    0.000000] [bcm2709_smp_init_cpus] enter (87c0->f3003010)
> [    0.000000] [bcm2709_smp_init_cpus] ncores=4
> [    0.000000] PERCPU: Embedded 12 pages/cpu @ba059000 s17664 r8192
> d23296 u49152
> [    0.000000] pcpu-alloc: s17664 r8192 d23296 u49152 alloc=12*4096
> [    0.000000] pcpu-alloc: [0] 0 [0] 1 [0] 2 [0] 3
> [    0.000000] Built 1 zonelists in Zone order, mobility grouping on.
> Total pages: 239776
> [    0.000000] Kernel command line: dma.dmachans=0x7f35
> bcm2708_fb.fbwidth=656 bcm2708_fb.fbheight=416 bcm2709.boardrev=0xa21041
> bcm2709.serial=0x5c7e0cd1 smsc95xx.macaddr=B8:27:EB:7E:0C:D1
> bcm2708_fb.fbswap=1 bt
> [    0.000000] PID hash table entries: 4096 (order: 2, 16384 bytes)
> [    0.000000] Dentry cache hash table entries: 131072 (order: 7, 524288
> bytes)
> [    0.000000] Inode-cache hash table entries: 65536 (order: 6, 262144
> bytes)
> [    0.000000] Memory: 944268K/966656K available (3361K kernel code,
> 267K rwdata, 1096K rodata, 212K init, 608K bss, 22388K reserved)
> [    0.000000] Virtual kernel memory layout:
> [    0.000000]     vector  : 0xffff0000 - 0xffff1000   (   4 kB)
> [    0.000000]     fixmap  : 0xffc00000 - 0xffe00000   (2048 kB)
> [    0.000000]     vmalloc : 0xbb800000 - 0xff000000   (1080 MB)
> [    0.000000]     lowmem  : 0x80000000 - 0xbb000000   ( 944 MB)
> [    0.000000]     modules : 0x7f000000 - 0x80000000   (  16 MB)
> [    0.000000]       .text : 0x80008000 - 0x804628bc   (4459 kB)
> [    0.000000]       .init : 0x80463000 - 0x80498000   ( 212 kB)
> [    0.000000]       .data : 0x80498000 - 0x804daf48   ( 268 kB)
> [    0.000000]        .bss : 0x804daf48 - 0x805732f4   ( 609 kB)
> [    0.000000] SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=4, Nodes=1
> [    0.000000] Preemptible hierarchical RCU implementation.
> [    0.000000] NR_IRQS:608
> [    0.000000] Architected cp15 timer(s) running at 19.20MHz (virt).
> [    0.000000] I-pipe, 19.200 MHz clocksource, wrap in 960767920505705 ms
> [    0.000000] sched_clock: 56 bits at 19MHz, resolution 52ns, wraps
> every 3579139424256ns
> [    0.000430] Switching to timer-based delay loop, resolution 52ns
> [    0.000783] Interrupt pipeline (release #3)
> [    0.001021] Console: colour dummy device 80x30
> [    0.001263] Calibrating delay loop (skipped), value calculated using
> timer frequency.. 38.40 BogoMIPS (lpj=192000)
> [    0.001817] pid_max: default: 32768 minimum: 301
> [    0.002076] Mount-cache hash table entries: 2048 (order: 1, 8192 bytes)
> [    0.002432] Mountpoint-cache hash table entries: 2048 (order: 1, 8192
> bytes)
> [    0.002868] Initializing cgroup subsys memory
> [    0.003105] Initializing cgroup subsys devices
> [    0.003346] Initializing cgroup subsys freezer
> [    0.003587] Initializing cgroup subsys blkio
> [    0.003820] CPU: Testing write buffer coherency: ok
> [    0.004113] CPU0: update cpu_capacity 1024
> [    0.004336] CPU0: thread -1, cpu 0, socket 15, mpidr 80000f00
> [    0.004646] [bcm2709_smp_prepare_cpus] enter
> [    0.004881] Setting up static identity map for 0x336060 - 0x336094
> [    0.059345] [bcm2709_boot_secondary] cpu:1 started (0) 17
> [    0.059371] CPU1: Booted secondary processor
> [    0.059371] [bcm2709_secondary_init] enter cpu:1
> [    0.059374] CPU1: update cpu_capacity 1024
> [    0.059375] CPU1: thread -1, cpu 1, socket 15, mpidr 80000f01
> [    0.079345] [bcm2709_boot_secondary] cpu:2 started (0) 18
> [    0.079367] CPU2: Booted secondary processor
> [    0.079367] [bcm2709_secondary_init] enter cpu:2
> [    0.079369] CPU2: update cpu_capacity 1024
> [    0.079369] CPU2: thread -1, cpu 2, socket 15, mpidr 80000f02
> [    0.099347] [bcm2709_boot_secondary] cpu:3 started (0) 18
> [    0.099360] CPU3: Booted secondary processor
> [    0.099360] [bcm2709_secondary_init] enter cpu:3
> [    0.099361] CPU3: update cpu_capacity 1024
> [    0.099362] CPU3: thread -1, cpu 3, socket 15, mpidr 80000f03
> [    0.100643] Brought up 4 CPUs
> [    0.100804] SMP: Total of 4 processors activated (153.60 BogoMIPS).
> [    0.101138] CPU: All CPU(s) started in SVC mode.
> [    0.101436] devtmpfs: initialized
> [    0.102819] VFP support v0.3: implementor 41 architecture 2 part 30
> variant 7 rev 5
> [    0.103285] pinctrl core: initialized pinctrl subsystem
> [    0.103976] DMA: preallocated 4096 KiB pool for atomic coherent
> allocations
> [    0.104401] bcm2709.uart_clock = 3000000
> [    0.104747] hw-breakpoint: found 5 (+1 reserved) breakpoint and 4
> watchpoint registers.
> [    0.105174] hw-breakpoint: maximum watchpoint size is 8 bytes.
> [    0.105488] mailbox: Broadcom VideoCore Mailbox driver
> [    0.105768] bcm2708_vcio: mailbox at f300b880
> [    0.106018] bcm_power: Broadcom power driver
> [    0.106248] bcm_power_open() -> 0
> [    0.106427] bcm_power_request(0, 8)
>
>


