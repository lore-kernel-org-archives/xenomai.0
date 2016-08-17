From: "Lennart Sorensen" <lsorense@csclub.uwaterloo.ca>
Date: Wed, 17 Aug 2016 13:08:05 -0400
Message-ID: <20160817170805.GB7162@csclub.uwaterloo.ca>
References: <57B41CA5.5040103@allwinnertech.com>
 <57B42AB6.9090306@allwinnertech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <57B42AB6.9090306@allwinnertech.com>
Subject: Re: [Xenomai] [help] porting I-pipe patch on linux-3.4
 ARM(cortex-a7) soc
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xielinfei <xielinfei@allwinnertech.com>
Cc: xenomai@xenomai.org

On Wed, Aug 17, 2016 at 05:13:26PM +0800, xielinfei wrote:
> 
> Add kernel message
> 
> ----------------------------------------------------------------------------------------------------
> Starting kernel ...
> 
> [sun8i_fixup]: From boot, get meminfo:
> Start: 0x40000000
> Size: 64MB
> ion_carveout reserve: 30m@0 30m@0
> ion_reserve_common: ion reserve: [0x42200000, 0x44000000]!
> [ 0.000000] Booting Linux on physical CPU 0
> [ 0.000000] Linux version 3.4.39 (chris@a) (gcc version 4.6.3 20120201
> (prerelease) (crosstool-NG linaro-1.13.1-2012.02-20120222 - Linaro GCC
> 2012.02) ) #256 Wed Aug 17 17:08:14 CST 2016
> [ 0.000000] bootconsole [earlycon0] enabled
> [ 0.000000] Memory policy: ECC disabled, Data cache writeback
> [ 0.000000] On node 0 totalpages: 16384
> [ 0.000000] free_area_init_node: node 0, pgdat c0660ca0, node_mem_map
> c072b000
> [ 0.000000] Normal zone: 128 pages used for memmap
> [ 0.000000] Normal zone: 0 pages reserved
> [ 0.000000] Normal zone: 16256 pages, LIFO batch:3
> [ 0.000000] script_init enter!
> [ 0.000000] script_init exit!
> [ 0.000000] pcpu-alloc: s0 r0 d32768 u32768 alloc=1*32768
> [ 0.000000] pcpu-alloc: [0] 0
> [ 0.000000] Built 1 zonelists in Zone order, mobility grouping on. Total
> pages: 16256
> [ 0.000000] Kernel command line: console=ttyS0,115200 console=tty0
> earlyprintk root=/dev/mtdblock2 init=/init loglevel=8
> partitions=boot@mmcblk0p2:rootfs@mmcblk0p5:env@mmcblk0p6:bootlogo@mmcblk0p7:UDISK@mmcblk0p1
> fb_base=0x43000000
> [ 0.000000] PID hash table entries: 256 (order: -2, 1024 bytes)
> [ 0.000000] Dentry cache hash table entries: 8192 (order: 3, 32768 bytes)
> [ 0.000000] Inode-cache hash table entries: 4096 (order: 2, 16384 bytes)
> [ 0.000000] Memory: 64MB = 64MB total
> [ 0.000000] Memory: 26816k/26816k available, 38720k reserved, 0K highmem
> [ 0.000000] Virtual kernel memory layout:
> [ 0.000000] vector : 0xffff0000 - 0xffff1000 ( 4 kB)
> [ 0.000000] fixmap : 0xfff00000 - 0xfffe0000 ( 896 kB)
> [ 0.000000] vmalloc : 0xc4800000 - 0xff000000 ( 936 MB)
> [ 0.000000] lowmem : 0xc0000000 - 0xc4000000 ( 64 MB)
> [ 0.000000] pkmap : 0xbfe00000 - 0xc0000000 ( 2 MB)
> [ 0.000000] modules : 0xbf000000 - 0xbfe00000 ( 14 MB)
> [ 0.000000] .text : 0xc0008000 - 0xc05ae000 (5784 kB)
> [ 0.000000] .init : 0xc05ae000 - 0xc05d2000 ( 144 kB)
> [ 0.000000] .data : 0xc05d2000 - 0xc06636c0 ( 582 kB)
> [ 0.000000] .bss : 0xc06636e4 - 0xc072a6c0 ( 796 kB)
> [ 0.000000] NR_IRQS:544
> [ 0.000000] 532 ahb1 set parent pll_periph0d2
> [ 0.000000] I-pipe, 24.000 MHz clocksource
> [ 0.000000] Architected local timer running at 24.00MHz.
> [ 0.000000] Switching to timer-based delay loop
> [ 0.000000] sched_clock: 32 bits at 24MHz, resolution 41ns, wraps every
> 178956ms
> [ 0.000000] Interrupt pipeline (release #4)
> [ 0.000000] Console: colour dummy device 80x30
> [ 0.000000] console [tty0] enabled, bootconsole disabled
> ---------------------------------------------------------------------------------------------------------------------
> then system halt.

Does that same kernel without ipipe/xenomai patches boot on the system?

Why 2.6.2 rather than 2.6.4 (or is it 2.6.5 now)?

Why not a newer kernel?  At least 3.14 is supported by 2.6.4, and I
think maybe 3.10 is as well.

-- 
len Sorensen

