From: "Lennart Sorensen" <lsorense@csclub.uwaterloo.ca>
Date: Wed, 13 May 2015 16:33:01 -0400
Message-ID: <20150513203301.GC6169@csclub.uwaterloo.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [Xenomai] 3.14 hangs with ipipe patch applied
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

I am trying to get 3.14.39 to boot with ipipe/xenomai.  The working
kernel boots fine, but once I apply the ipipe patch even without enabling
CONFIG_IPIPE, it stops at:

[    0.000000] Booting Linux on physical CPU 0x0
[    0.000000] Linux version 3.14-2-am5726 (debian-kernel@lists.debian.org) (gcc version 4.7.2 (Debian 4.7.2-5) ) #1 SMP Debian 3.14.39-0.1 (2015-04-28)
[    0.000000] CPU: ARMv7 Processor [412fc0f2] revision 2 (ARMv7), cr=10c5387d
[    0.000000] CPU: PIPT / VIPT nonaliasing data cache, PIPT instruction cache
[    0.000000] Machine model: RCM RX1400
[    0.000000] bootconsole [earlycon0] enabled
[    0.000000] Memory policy: Data cache writealloc
[    0.000000] DRA752 ES1.1
[    0.000000] PERCPU: Embedded 8 pages/cpu @dfac0000 s11584 r8192 d12992 u32768
[    0.000000] Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 129792
[    0.000000] Kernel command line: root=/dev/mmcblk0p7 ro console=ttyS2,57600n8 rootwait mem=512M fips=1 single earlyprintk bootver=2014.04RR16
[    0.000000] fips mode: enabled
[    0.000000] PID hash table entries: 2048 (order: 1, 8192 bytes)
[    0.000000] Dentry cache hash table entries: 65536 (order: 6, 262144 bytes)
[    0.000000] Inode-cache hash table entries: 32768 (order: 5, 131072 bytes)
[    0.000000] Memory: 510548K/523264K available (4604K kernel code, 531K rwdata, 1956K rodata, 451K init, 326K bss, 12716K reserved, 0K highmem)
[    0.000000] Virtual kernel memory layout:
[    0.000000]     vector  : 0xffff0000 - 0xffff1000   (   4 kB)
[    0.000000]     fixmap  : 0xfff00000 - 0xfffe0000   ( 896 kB)
[    0.000000]     vmalloc : 0xe0800000 - 0xff000000   ( 488 MB)
[    0.000000]     lowmem  : 0xc0000000 - 0xe0000000   ( 512 MB)
[    0.000000]     pkmap   : 0xbfe00000 - 0xc0000000   (   2 MB)
[    0.000000]     modules : 0xbf000000 - 0xbfe00000   (  14 MB)
[    0.000000]       .text : 0xc0008000 - 0xc06703b4   (6561 kB)
[    0.000000]       .init : 0xc0671000 - 0xc06e1d40   ( 452 kB)
[    0.000000]       .data : 0xc06e2000 - 0xc0766c48   ( 532 kB)
[    0.000000]        .bss : 0xc0766c48 - 0xc07b87a0   ( 327 kB)
[    0.000000] SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=2, Nodes=1
[    0.000000] Hierarchical RCU implementation.
[    0.000000] NR_IRQS:16 nr_irqs:16 16
[    0.000000] kmemleak: Kernel memory leak detector disabled
[    0.000000] ti_dt_clocks_register: failed to lookup clock node pruss1
[    0.000000] ti_dt_clocks_register: failed to lookup clock node pruss2
[    0.000000] OMAP clockevent source: timer1 at 32786 Hz
[    0.000000] sched_clock: 32 bits at 32kHz, resolution 30517ns, wraps every 65536000000000ns
[    0.017242] OMAP clocksource: 32k_counter at 32768 Hz
[    0.028015] Architected cp15 timer(s) running at 6.14MHz (phys).
[    0.040470] sched_clock: 56 bits at 6MHz, resolution 162ns, wraps every 2794592043008ns
[    0.057000] Switching to timer-based delay loop

Remove the ipipe patch, and it boots fine.

I was doing fine with 3.12, so I wonder what changed in the 3.14 tree
that could be causing this.  This being the ti-linux-3.14.y tree due to
the CPU in use.

Any suggestion for what part of the code to look at to explain what
could be happening right after the timer is enabled?

On the none ipipe patched kernel the next line is:

[    0.167509] Calibrating delay loop (skipped), value calculated using timer frequency.. 12.29 BogoMIPS (lpj=6147)

so seemingly I am not hitting that for some reason.

-- 
Len Sorensen

