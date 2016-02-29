Date: Mon, 29 Feb 2016 13:55:52 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20160229125552.GD13210@hermes.click-hack.org>
References: <2583412.27hkYeNOW2@alex-xw9400>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2583412.27hkYeNOW2@alex-xw9400>
Subject: Re: [Xenomai] Ipipe 4.1 on Allwinner A20 (Cubietruck) takes a very
 long start time
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Alexander Syring <xenomai@asyring.de>
Cc: xenomai@xenomai.org

On Mon, Feb 29, 2016 at 01:47:17PM +0100, Alexander Syring wrote:
> Hi
> I patched the 4.1.15 from git.xenomai.org to compile it on the Cubietruck.
> But it takes a long time to boot.
> 
> Here my dmesg:
> 
> root@Cubietruck:~# dmesg
> [    0.000000] Booting Linux on physical CPU 0x0
> [    0.000000] Initializing cgroup subsys cpuset
> [    0.000000] Initializing cgroup subsys cpu
> [    0.000000] Initializing cgroup subsys cpuacct
> [    0.000000] Linux version 4.1.15-00126-g85a10db-dirty (root@Cubietruck) 
> (gcc version 5.3.1 20160205 (Debian 5.3.1-8) ) #9 SMP PREEMPT Thu Feb 25 
> 21:33:38 CET 2016
> [    0.000000] CPU: ARMv7 Processor [410fc074] revision 4 (ARMv7), cr=10c5387d
> [    0.000000] CPU: PIPT / VIPT nonaliasing data cache, VIPT aliasing 
> instruction cache
> [    0.000000] Machine model: Cubietech Cubietruck
> [    0.000000] Memory policy: Data cache writealloc
> [    0.000000] On node 0 totalpages: 523520
> [    0.000000] free_area_init_node: node 0, pgdat c0946cc0, node_mem_map 
> ee5f8000
> [    0.000000]   Normal zone: 1710 pages used for memmap
> [    0.000000]   Normal zone: 0 pages reserved
> [    0.000000]   Normal zone: 194560 pages, LIFO batch:31
> [    0.000000]   HighMem zone: 328960 pages, LIFO batch:31
> [    0.000000] psci: probing for conduit method from DT.
> [    0.000000] psci: Using PSCI v0.1 Function IDs from DT
> [    0.000000] PERCPU: Embedded 14 pages/cpu @ee5bd000 s27532 r8192 d21620 
> u57344
> [    0.000000] pcpu-alloc: s27532 r8192 d21620 u57344 alloc=14*4096
> [    0.000000] pcpu-alloc: [0] 0 [0] 1 
> [    0.000000] Built 1 zonelists in Zone order, mobility grouping on.  Total 
> pages: 521810
> [    0.000000] Kernel command line: console=ttyS0,115200 [earlyprintk] 
> root=/dev/mmcblk0p1 rootwait panic=10
> [    0.000000] PID hash table entries: 4096 (order: 2, 16384 bytes)
> [    0.000000] Dentry cache hash table entries: 131072 (order: 7, 524288 
> bytes)
> [    0.000000] Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
> [    0.000000] Memory: 2064612K/2094080K available (7101K kernel code, 247K 
> rwdata, 1776K rodata, 344K init, 467K bss, 29468K reserved, 0K cma-reserved, 
> 1315840K highmem)
> [    0.000000] Virtual kernel memory layout:
>                    vector  : 0xffff0000 - 0xffff1000   (   4 kB)
>                    fixmap  : 0xffc00000 - 0xfff00000   (3072 kB)
>                    vmalloc : 0xf0000000 - 0xff000000   ( 240 MB)
>                    lowmem  : 0xc0000000 - 0xef800000   ( 760 MB)
>                    pkmap   : 0xbfe00000 - 0xc0000000   (   2 MB)
>                    modules : 0xbf000000 - 0xbfe00000   (  14 MB)
>                      .text : 0xc0008000 - 0xc08b36d0   (8878 kB)
>                      .init : 0xc08b4000 - 0xc090a000   ( 344 kB)
>                      .data : 0xc090a000 - 0xc0947df8   ( 248 kB)
>                       .bss : 0xc094a000 - 0xc09befdc   ( 468 kB)
> [    0.000000] SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=2, Nodes=1
> [    0.000000] Preemptible hierarchical RCU implementation.
> [    0.000000]  Additional per-CPU info printed with stalls.
> [    0.000000] NR_IRQS:16 nr_irqs:16 16
> [    0.000000] Architected cp15 timer(s) running at 24.00MHz (phys).
> [    0.000000] I-pipe, 24.000 MHz clocksource, wrap in 768614336404564 ms
> [    0.000000] clocksource ipipe_tsc: mask: 0xffffffffffffffff max_cycles: 
> 0x588fe9dc0, max_idle_ns: 440795202592 ns
> [    0.000000] clocksource arch_sys_counter: mask: 0xffffffffffffff 
> max_cycles: 0x588fe9dc0, max_idle_ns: 440795202592 ns
> [    0.000006] sched_clock: 56 bits at 24MHz, resolution 41ns, wraps every 
> 4398046511097ns
> [    0.000020] Switching to timer-based delay loop, resolution 41ns
> [    0.000381] clocksource timer: mask: 0xffffffff max_cycles: 0xffffffff, 
> max_idle_ns: 79635851949 ns
> [    0.000575] clocksource hstimer: mask: 0xffffffff max_cycles: 0xffffffff, 
> max_idle_ns: 12574081885 ns
> [    0.001104] Interrupt pipeline (release #1)
> [ 8762.335587] Console: colour dummy device 80x30
> [ 8762.335626] Calibrating delay loop (skipped), value calculated using timer 
> frequency.. 48.00 BogoMIPS (lpj=24000)
> [ 8762.335645] pid_max: default: 32768 minimum: 301
> 
> [...]
> 
> has anyone a clue why it takes more than two hours to bring up the interrupt 
> pipeline?

The problem is not the interrupt pipeline.

The Allwinner A20 is not among the processors supported by the
I-pipe patch, (see list here: 
http://xenomai.org/embedded-hardware/)

Thus, before using this processor, you need to follow the porting
guide:
http://xenomai.org/2014/09/porting-xenomai-dual-kernel-to-a-new-arm-soc/

Also you do not tell us what version of the I-pipe patch you are
using, I guess not the latest, so you should try the latest to be
sure you get the latest fixes, notably:

https://git.xenomai.org/ipipe.git/commit/?h=ipipe-4.1.y&id=0a037e7db92fb0f0c4a1d77c6bac38814649ee26

Regards.

-- 
					    Gilles.
https://click-hack.org

