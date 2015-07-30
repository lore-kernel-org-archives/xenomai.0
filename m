Message-ID: <BLU436-SMTP153D5AD06FBFF11FA47585FF08B0@phx.gbl>
Date: Wed, 29 Jul 2015 20:37:27 -0700
From: Mathieu <mathieu_rondonneau@hotmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [Xenomai]  Raspberry Pi 2 patch - BCM2709
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org, mobin.seven@live.com

Mobin,
The timer part of your patch in bcm2709.c is under a #ifdef SYSTEM_TIMER 
and SYSTEM_TIMER is not defined (commented out at line 74) so it is 
useless and if you define it, you will see it will likely not compile 
because the structure name you used are not the same as the one in the 
parameters of register function (there are mix and match of bcm2709 and 
bcm2708).
Anyway this is not the problem because the ARM timer is used instead.

Others,
I get similar issue (described by Mobin) where it does not boot when 
CONFIG_IPIPE is enabled (I have added the earlyprintk output console 
below for information).
Like stated in the doc 
(http://xenomai.org/2014/09/porting-xenomai-dual-kernel-to-a-new-arm-soc/), 
pointed by Gilles, it does look like a GIC init issue.

My next step is to connect a JTAG to see where the cpu is locked and 
start from there. Sometimes, it encounters a bad pointers like it seems 
to do in this crash below.

In the mean time, I was wondering is anybody else succeed to get this 
working or has any pointers on anything obvious missing.

My patch is similar to the one mobin has. it is pretty much a copy/past 
from the old xenomai patch you can find from the mailing list + a 
tentative of porting to rpi2.

Thanks,
--
Mathieu

Uncompressing Linux... done, booting the kernel.
[    0.000000] Booting Linux on physical CPU 0xf00
[    0.000000] Initializing cgroup subsys cpuset
[    0.000000] Initializing cgroup subsys cpu
[    0.000000] Initializing cgroup subsys cpuacct
[    0.000000] Linux version 3.18.16-v7+ (mathieu@mathieu-X58A-UD3R) 
(gcc version 4.8.3 20140303 (prerelease) (crosstool-NG 
linaro-1.13.1+bzr2650 - Linaro GCC 2014.03) ) #23 SMP PREE5
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
[    0.000000] free_area_init_node: node 0, pgdat 80683f40, node_mem_map 
ba093000
[    0.000000]   Normal zone: 1888 pages used for memmap
[    0.000000]   Normal zone: 0 pages reserved
[    0.000000]   Normal zone: 241664 pages, LIFO batch:31
[    0.000000] [bcm2709_smp_init_cpus] enter (8820->f3003010)
[    0.000000] [bcm2709_smp_init_cpus] ncores=4
[    0.000000] PERCPU: Embedded 12 pages/cpu @ba058000 s18176 r8192 
d22784 u49152
[    0.000000] pcpu-alloc: s18176 r8192 d22784 u49152 alloc=12*4096
[    0.000000] pcpu-alloc: [0] 0 [0] 1 [0] 2 [0] 3
[    0.000000] Built 1 zonelists in Zone order, mobility grouping on. 
Total pages: 239776
[    0.000000] Kernel command line: dma.dmachans=0x7f35 
bcm2708_fb.fbwidth=656 bcm2708_fb.fbheight=416 bcm2709.boardrev=0xa21041 
bcm2709.serial=0x5c7e0cd1 smsc95xx.macaddr=B8:27:EB:7t
[    0.000000] PID hash table entries: 4096 (order: 2, 16384 bytes)
[    0.000000] Dentry cache hash table entries: 131072 (order: 7, 524288 
bytes)
[    0.000000] Inode-cache hash table entries: 65536 (order: 6, 262144 
bytes)
[    0.000000] Memory: 942520K/966656K available (4617K kernel code, 
315K rwdata, 1448K rodata, 260K init, 650K bss, 24136K reserved)
[    0.000000] Virtual kernel memory layout:
[    0.000000]     vector  : 0xffff0000 - 0xffff1000   (   4 kB)
[    0.000000]     fixmap  : 0xffc00000 - 0xffe00000   (2048 kB)
[    0.000000]     vmalloc : 0xbb800000 - 0xff000000   (1080 MB)
[    0.000000]     lowmem  : 0x80000000 - 0xbb000000   ( 944 MB)
[    0.000000]     modules : 0x7f000000 - 0x80000000   (  16 MB)
[    0.000000]       .text : 0x80008000 - 0x805f464c   (6066 kB)
[    0.000000]       .init : 0x805f5000 - 0x80636000   ( 260 kB)
[    0.000000]       .data : 0x80636000 - 0x80684e60   ( 316 kB)
[    0.000000]        .bss : 0x80684e60 - 0x8072774c   ( 651 kB)
[    0.000000] SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=4, Nodes=1
[    0.000000] Preemptible hierarchical RCU implementation.
[    0.000000] NR_IRQS:608
[    0.000000] Architected cp15 timer(s) running at 19.20MHz (virt).
[    0.000000] I-pipe, 19.200 MHz clocksource, wrap in 960767920505705 ms
[    0.000010] sched_clock: 56 bits at 19MHz, resolution 52ns, wraps 
every 3579139424256ns
[    0.008261] Switching to timer-based delay loop, resolution 52ns
[    0.015012] Interrupt pipeline (release #3)
[    0.020240] Unable to handle kernel paging request at virtual address 
55755134
[    0.027701] Unable to handle kernel paging request at virtual address 
55555575
[    0.035148] Unable to handle kernel paging request at virtual address 
55555575

