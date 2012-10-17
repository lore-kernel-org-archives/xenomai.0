Message-ID: <507F2930.9020709@gmail.com>
Date: Wed, 17 Oct 2012 22:54:56 +0100
From: Stefan Videv <videvstefan@gmail.com>
MIME-Version: 1.0
References: <mailman.1.1350468001.6812.xenomai@xenomai.org>
In-Reply-To: <mailman.1.1350468001.6812.xenomai@xenomai.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [Xenomai] ARM kernel issue
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Hi everybody,

I have the following kernel problem when trying to boot on arm with 
kernel v.3.2.21:

U-Boot SPL 2012.10-rc2-dirty (Oct 17 2012 - 00:25:42)
OMAP SD/MMC: 0
reading u-boot.img
reading u-boot.img


U-Boot 2012.10-rc2-dirty (Oct 17 2012 - 00:25:42)

I2C:   ready
DRAM:  256 MiB
WARNING: Caches not enabled
MMC:   OMAP SD/MMC: 0, OMAP SD/MMC: 1
Using default environment

Net:   cpsw
Hit any key to stop autoboot:  0
SD/MMC found on device 0
reading uEnv.txt

649 bytes read
Loaded environment from uEnv.txt
Importing environment from mmc ...
reading zImage

2664144 bytes read
Booting from mmc ...

Starting kernel ...

Uncompressing Linux... done, booting the kernel.
[    0.000000] Initializing cgroup subsys cpuset
[    0.000000] Initializing cgroup subsys cpu
[    0.000000] Linux version 3.2.31-psp24 (stefan@stefan-VirtualBox) 
(gcc version 4.6.3 (Ubuntu/Linaro 4.6.3-1ubuntu5) ) #1 Wed Oct 17 
17:09:40 BST 2012
[    0.000000] CPU: ARMv7 Processor [413fc082] revision 2 (ARMv7), 
cr=10c53c7d
[    0.000000] CPU: PIPT / VIPT nonaliasing data cache, VIPT aliasing 
instruction cache
[    0.000000] Machine: am335xevm
[    0.000000] bootconsole [earlycon0] enabled
[    0.000000] Memory policy: ECC disabled, Data cache writeback
[    0.000000] On node 0 totalpages: 65536
[    0.000000] free_area_init_node: node 0, pgdat c07336a8, node_mem_map 
c079d000
[    0.000000]   Normal zone: 512 pages used for memmap
[    0.000000]   Normal zone: 0 pages reserved
[    0.000000]   Normal zone: 65024 pages, LIFO batch:15
[    0.000000] AM335X ES1.0 (sgx neon )
[    0.000000] pcpu-alloc: s0 r0 d32768 u32768 alloc=1*32768
[    0.000000] pcpu-alloc: [0] 0
[    0.000000] Built 1 zonelists in Zone order, mobility grouping on.  
Total pages: 65024
[    0.000000] Kernel command line: console=ttyO0,115200n8 
root=/dev/mmcblk0p2 ro rootfstype=ext4 rootwait fixrtc debug earlyprintk
[    0.000000] PID hash table entries: 1024 (order: 0, 4096 bytes)
[    0.000000] Dentry cache hash table entries: 32768 (order: 5, 131072 
bytes)
[    0.000000] Inode-cache hash table entries: 16384 (order: 4, 65536 bytes)
[    0.000000] allocated 1048576 bytes of page_cgroup
[    0.000000] please try 'cgroup_disable=memory' option if you don't 
want memory cgroups
[    0.000000] Memory: 256MB = 256MB total
[    0.000000] Memory: 251036k/251036k available, 11108k reserved, 0K 
highmem
[    0.000000] Virtual kernel memory layout:
[    0.000000]     vector  : 0xffff0000 - 0xffff1000   (   4 kB)
[    0.000000]     fixmap  : 0xfff00000 - 0xfffe0000   ( 896 kB)
[    0.000000]     vmalloc : 0xd0800000 - 0xff000000   ( 744 MB)
[    0.000000]     lowmem  : 0xc0000000 - 0xd0000000   ( 256 MB)
[    0.000000]     modules : 0xbf000000 - 0xc0000000   (  16 MB)
[    0.000000]       .text : 0xc0008000 - 0xc06ab000   (6796 kB)
[    0.000000]       .init : 0xc06ab000 - 0xc06e9000   ( 248 kB)
[    0.000000]       .data : 0xc06ea000 - 0xc0734720   ( 298 kB)
[    0.000000]        .bss : 0xc0734744 - 0xc079cd5c   ( 418 kB)
[    0.000000] NR_IRQS:410 nr_irqs:410 410
[    0.000000] IRQ: Found an INTC at 0xfa200000 (revision 5.0) with 128 
interrupts
[    0.000000] Total of 128 interrupts on 1 active controller
[    0.000000] OMAP clockevent source: GPTIMER2 at 24000000 Hz
[    0.000000] OMAP clocksource: GPTIMER1 at 32768 Hz
[    0.000000] I-pipe, 0.032 MHz clocksource
[    0.000000] sched_clock: 32 bits at 32kHz, resolution 30517ns, wraps 
every 131071999ms
[    0.000000] Interrupt pipeline (release #1)
[    0.000000] ------------[ cut here ]------------

It looks very similar to:
http://www.xenomai.org/pipermail/xenomai/2012-July/000476.html

I've read the whole conversation, but due to my lack of understanding of 
the Xenomai codebase, here I am asking for a (preferably) quick 
step-by-step explanation of what the fix for this is. Also, the email 
back and forth kind of left me confused if all the steps in there are 
necessary or is it just some. Also, I am only sure that the kernel I am 
trying to run exhibits the same initial hang, and I don't have the 
knowledge (or equipment) to be able to debug through JTAG.

The particular Xenomai patch that I am using can be found under:

https://github.com/RobertCNelson/linux-dev/commit/f6ffc6e46dee99ca875318b2c7a8d1a548519a3b

Thanks for your time and help!

-- Stefan

