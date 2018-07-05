References: <7a8a3b90-af4b-b3d6-e933-485334bfdb3d@sferapro.com>
From: Federico Sbalchiero <f.sbalchiero@sferapro.com>
Message-ID: <adc80cdd-e7b9-42c5-4b83-471dc1edd2c8@sferapro.com>
Date: Thu, 5 Jul 2018 11:52:52 +0200
MIME-Version: 1.0
In-Reply-To: <7a8a3b90-af4b-b3d6-e933-485334bfdb3d@sferapro.com>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
Content-Language: it
Subject: [Xenomai] Fwd: Re:  i.MX6q memory write causes high latency
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org


Thank You for the quick response.
Yes, I'm able to modify and rebuild the kernel. I'll test it this
evening (out of office today).
I can add one more information: passing l2x0_write_allocate=1 as kernel
argument doesn't change latency.

Federico

Il 04/07/2018 21:01, Greg Gallagher ha scritto:
> Sorry going off list for a second, are you able to rebuild your kernel
> with a small fix in it?  I saw something odd in the cache driver.  Try
> adding a break to the case statement at line 837 in file
> /arch/arm/mm/cache-l2x0.c.
>
> -Greg
>
> On Wed, Jul 4, 2018 at 1:06 PM, Federico Sbalchiero
> <f.sbalchiero@sferapro.com> wrote:
>> Hi,
>> first I want to say thanks to everyone involved in Xenomai for their job.
>>
>> I'm testing Xenomai 3.0.7 and ipipe-arm/4.14 on Freescale/NXP i.MX6q
>> sabresd board using Yocto. System boots fine and is stable, but latency
>> under load (xeno-test) is higher than in my reference system (Xenomai
>> 2.6.5 on Freescale kernel 3.10.17 + ipipe 3.10.18).
>> This is after disabling power management, frequency scaling, CMA,
>> graphics, tracing, debug.
>>
>> I have found that a simple non-realtime user space process writing a
>> buffer in memory (memwrite) is able to trigger such high latencies.
>> Latency worsen a lot running a copy of the process on each core.
>> There is a correlation between buffer size and cache size suggesting
>> an L2 cache issue, like the L2 write allocate discussed in the mailing
>> list, but I can confirm L2 WA is disabled (see log).
>>
>> I'm looking for comments or suggestions.
>>
>> Thanks,
>> Federico
>>
>>
>> "memwrite" test case:
>> #include <stdlib.h>
>> #include <stdio.h>
>> #include <string.h>
>> unsigned char *buffer;
>> int main(int argc, char **argv)
>> {
>>      int i;
>>      int count = 0;
>>      int n;
>>      int size = 10 * 1024 * 1024;
>>      volatile unsigned *pt;
>>      printf("load system by writing in memory\n");
>>      buffer = malloc(size);
>>      if (buffer == NULL) {
>>          printf("buffer allocation failed\n");
>>          exit(1);
>>      }
>>      n = size / sizeof(unsigned);
>>      while (1) {
>>          // write some data to memory buffer
>>          pt = (unsigned *) buffer;
>>          for (i = 0; i < n; i++)
>>              *pt++ = i;
>>          count++;
>>      }
>>      return 0;
>> }
>>
>> xeno-test on Xenomai 3.0.7 and ipipe-arm/4.14:
>> RTT|  00:00:01  (periodic user-mode task, 1000 us period, priority 99)
>> RTH|----lat min|----lat avg|----lat max|-overrun|---msw|---lat best|--lat
>> worst
>> RTD|     18.000|     26.504|     42.667|       0|     0| 18.000|     42.667
>> RTD|     19.000|     25.198|     41.000|       0|     0| 18.000|     42.667
>> RTD|     18.999|     25.494|     40.999|       0|     0| 18.000|     42.667
>> RTD|     18.666|     25.060|     38.999|       0|     0| 18.000|     42.667
>> RTD|     18.999|     24.464|     38.332|       0|     0| 18.000|     42.667
>> RTD|     18.332|     24.546|     41.999|       0|     0| 18.000|     42.667
>> RTD|     13.332|     22.445|     45.665|       0|     0| 13.332|     45.665
>> RTD|     13.331|     21.164|     43.665|       0|     0| 13.331|     45.665
>> RTD|     13.331|     21.930|     43.665|       0|     0| 13.331|     45.665
>> RTD|     13.331|     22.254|     48.664|       0|     0| 13.331|     48.664
>> RTD|     13.331|     22.037|     46.664|       0|     0| 13.331|     48.664
>> RTD|     13.330|     21.053|     42.664|       0|     0| 13.330|     48.664
>> RTD|     13.330|     20.610|     37.330|       0|     0| 13.330|     48.664
>> RTD|     13.330|     20.520|     34.997|       0|     0| 13.330|     48.664
>> RTD|     13.330|     20.398|     39.330|       0|     0| 13.330|     48.664
>> RTD|     13.663|     21.249|     37.996|       0|     0| 13.330|     48.664
>> RTD|     13.329|     20.983|     35.663|       0|     0| 13.329|     48.664
>> RTD|     12.996|     20.039|     34.329|       0|     0| 12.996|     48.664
>> RTD|     13.329|     20.580|     42.662|       0|     0| 12.996|     48.664
>> RTD|     12.995|     20.518|     39.329|       0|     0| 12.995|     48.664
>> RTD|     13.328|     20.168|     35.662|       0|     0| 12.995|     48.664
>>
>> xeno-test on Xenomai 2.6.5 and Freescale Linux 3.10.17 + ipipe 3.10.18:
>> RTT|  00:00:01  (periodic user-mode task, 1000 us period, priority 99)
>> RTH|----lat min|----lat avg|----lat max|-overrun|---msw|---lat best|--lat
>> worst
>> RTD|      4.957|     17.575|     28.088|       0|     0| 4.957|     28.088
>> RTD|      4.904|     17.560|     26.828|       0|     0| 4.904|     28.088
>> RTD|      4.479|     13.472|     29.767|       0|     0| 4.479|     29.767
>> RTD|      4.522|     12.724|     23.275|       0|     0| 4.479|     29.767
>> RTD|      4.512|     12.904|     25.641|       0|     0| 4.479|     29.767
>> RTD|      4.542|     12.818|     27.878|       0|     0| 4.479|     29.767
>> RTD|      4.520|     13.068|     27.926|       0|     0| 4.479|     29.767
>> RTD|      4.409|     12.770|     26.689|       0|     0| 4.409|     29.767
>> RTD|      4.568|     12.265|     27.065|       0|     0| 4.409|     29.767
>> RTD|      4.492|     12.017|     25.898|       0|     0| 4.409|     29.767
>> RTD|      4.469|     12.303|     24.540|       0|     0| 4.409|     29.767
>> RTD|      4.489|     12.030|     27.924|       0|     0| 4.409|     29.767
>> RTD|      4.590|     11.851|     23.651|       0|     0| 4.409|     29.767
>> RTD|      4.479|     13.371|     24.838|       0|     0| 4.409|     29.767
>> RTD|      4.396|     13.204|     28.797|       0|     0| 4.396|     29.767
>> RTD|      4.411|     12.454|     26.002|       0|     0| 4.396|     29.767
>> RTD|      4.560|     12.234|     27.146|       0|     0| 4.396|     29.767
>> RTD|      4.593|     12.441|     24.686|       0|     0| 4.396|     29.767
>> RTD|      4.520|     12.510|     24.275|       0|     0| 4.396|     29.767
>> RTD|      4.568|     11.797|     24.982|       0|     0| 4.396|     29.767
>> RTD|      4.482|     12.631|     24.972|       0|     0| 4.396|     29.767
>>
>> latency (no xeno-test!) with four memwrite instances on Xenomai 3.0.7 and
>> ipipe-arm/4.14:
>> RTT|  00:00:01  (periodic user-mode task, 1000 us period, priority 99)
>> RTH|----lat min|----lat avg|----lat max|-overrun|---msw|---lat best|--lat
>> worst
>> RTD|     41.999|     60.200|    101.333|       0|     0| 41.999|    101.333
>> RTD|     42.666|     60.471|    103.666|       0|     0| 41.999|    103.666
>> RTD|     36.999|     60.568|     96.999|       0|     0| 36.999|    103.666
>> RTD|     38.998|     60.535|     95.332|       0|     0| 36.999|    103.666
>> RTD|     35.332|     60.359|    105.998|       0|     0| 35.332|    105.998
>> RTD|     41.998|     60.762|    116.665|       0|     0| 35.332|    116.665
>> RTD|     40.664|     60.419|     96.331|       0|     0| 35.332|    116.665
>> RTD|     41.331|     60.678|     91.331|       0|     0| 35.332|    116.665
>> RTD|     38.997|     60.923|     94.664|       0|     0| 35.332|    116.665
>> RTD|     42.664|     60.505|     95.664|       0|     0| 35.332|    116.665
>> RTD|     40.330|     60.175|     95.664|       0|     0| 35.332|    116.665
>> RTD|     40.663|     60.368|     96.663|       0|     0| 35.332|    116.665
>> RTD|     42.330|     60.286|     95.330|       0|     0| 35.332|    116.665
>> RTD|     36.996|     60.304|    100.663|       0|     0| 35.332|    116.665
>> RTD|     41.996|     61.100|    103.663|       0|     0| 35.332|    116.665
>> RTD|     40.996|     60.792|    102.996|       0|     0| 35.332|    116.665
>> RTD|     38.662|     60.205|    104.329|       0|     0| 35.332|    116.665
>> RTD|     39.995|     60.645|     98.995|       0|     0| 35.332|    116.665
>> RTD|     37.328|     60.300|     99.662|       0|     0| 35.332|    116.665
>> RTD|     40.995|     60.206|     98.328|       0|     0| 35.332|    116.665
>> RTD|     36.994|     60.444|     95.661|       0|     0| 35.332|    116.665
>>
>> Linux 4.14 menuconfig:
>>    CPU Power Management\CPU Frequency scaling -> NO
>>    CPU Power Management\CPU Idle PM support -> NO
>>    Power management options\Suspend to RAM and standby -> no
>>    Power management options\Device power management core functionality -> no
>>    Device Drivers\Graphics support\DRM Support for Freescale i.MX -> no
>>    Device Drivers\Graphics support\ETNAVIV (DRM support for Vivante GPU IP
>> cores) -> no
>>    Kernel Features\Timer frequency -> 200 Hz
>>    Kernel Features\Allow for memory compaction -> no
>>    Kernel Features\Contiguous Memory Allocator -> no
>>    Kernel hacking\Tracers -> no
>>    Kernel hacking\Lock Debugging (spinlocks, mutexes, etc...) -> all no
>>    Kernel hacking\Stack backtrace support -> no
>>    Bus support\PCI support-> no
>>
>> Boot log:
>> [    0.000000] Booting Linux on physical CPU 0x0
>> [    0.000000] Linux version 4.14.36-fslc+gc664b053e5ce (oe-user@oe-host)
>> (gcc version 7.3.0 (GCC)) #1 SMP Tue Jun 26 08:49:22 UTC 2018
>> [    0.000000] CPU: ARMv7 Processor [412fc09a] revision 10 (ARMv7),
>> cr=10c5387d
>> [    0.000000] CPU: PIPT / VIPT nonaliasing data cache, VIPT aliasing
>> instruction cache
>> [    0.000000] OF: fdt: Machine model: Freescale i.MX6 Quad SABRE Smart
>> Device Board
>> [    0.000000] Memory policy: Data cache writealloc
>> [    0.000000] On node 0 totalpages: 262144
>> [    0.000000] free_area_init_node: node 0, pgdat c0d62900, node_mem_map
>> ef7f8000
>> [    0.000000]   Normal zone: 1536 pages used for memmap
>> [    0.000000]   Normal zone: 0 pages reserved
>> [    0.000000]   Normal zone: 196608 pages, LIFO batch:31
>> [    0.000000]   HighMem zone: 65536 pages, LIFO batch:15
>> [    0.000000] percpu: Embedded 19 pages/cpu @ef78a000 s46924 r8192 d22708
>> u77824
>> [    0.000000] pcpu-alloc: s46924 r8192 d22708 u77824 alloc=19*4096
>> [    0.000000] pcpu-alloc: [0] 0 [0] 1 [0] 2 [0] 3
>> [    0.000000] Built 1 zonelists, mobility grouping on.  Total pages: 260608
>> [    0.000000] Kernel command line: console=ttymxc0,115200
>> root=PARTUUID=1bfc1072-02 rootwait rw[    0.000000] PID hash table entries:
>> 4096 (order: 2, 16384 bytes)
>> [    0.000000] Dentry cache hash table entries: 131072 (order: 7, 524288
>> bytes)
>> [    0.000000] Inode-cache hash table entries: 65536 (order: 6, 262144
>> bytes)
>> [    0.000000] Memory: 1025492K/1048576K available (8192K kernel code, 397K
>> rwdata, 2220K rodata, 1024K init, 885K bss, 23084K reserved, 0K
>> cma-reserved, 262144K highmem)
>> [    0.000000] Virtual kernel memory layout:
>> [    0.000000]     vector  : 0xffff0000 - 0xffff1000   (   4 kB)
>> [    0.000000]     fixmap  : 0xffc00000 - 0xfff00000   (3072 kB)
>> [    0.000000]     vmalloc : 0xf0800000 - 0xff800000   ( 240 MB)
>> [    0.000000]     lowmem  : 0xc0000000 - 0xf0000000   ( 768 MB)
>> [    0.000000]     pkmap   : 0xbfe00000 - 0xc0000000   (   2 MB)
>> [    0.000000]     modules : 0xbf000000 - 0xbfe00000   (  14 MB)
>> [    0.000000]       .text : 0xc0008000 - 0xc0900000   (9184 kB)
>> [    0.000000]       .init : 0xc0c00000 - 0xc0d00000   (1024 kB)
>> [    0.000000]       .data : 0xc0d00000 - 0xc0d63700   ( 398 kB)
>> [    0.000000]        .bss : 0xc0d65000 - 0xc0e4255c   ( 886 kB)
>> [    0.000000] SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=4, Nodes=1
>> [    0.000000] Hierarchical RCU implementation.
>> [    0.000000] NR_IRQS: 16, nr_irqs: 16, preallocated irqs: 16
>> [    0.000000] L2C: I-pipe: l2x0_write_allocate= not specified, defaults to
>> 0 (disabled).
>> [    0.000000] L2C: DT/platform modifies aux control register: 0x32470000 ->
>> 0x32c70000
>> [    0.000000] L2C-310 errata 752271 769419 enabled
>> [    0.000000] L2C-310 enabling early BRESP for Cortex-A9
>> [    0.000000] L2C-310 full line of zeros enabled for Cortex-A9
>> [    0.000000] L2C-310 ID prefetch enabled, offset 16 lines
>> [    0.000000] L2C-310 dynamic clock gating enabled, standby mode enabled
>> [    0.000000] L2C-310 cache controller enabled, 16 ways, 1024 kB
>> [    0.000000] L2C-310: CACHE_ID 0x410000c7, AUX_CTRL 0x76c70001
>> [    0.000000] I-pipe, 396.000 MHz timer
>> [    0.000000] Switching to timer-based delay loop, resolution 333ns
>> [    0.000007] sched_clock: 32 bits at 3000kHz, resolution 333ns, wraps
>> every 715827882841ns
>> [    0.000027] clocksource: mxc_timer1: mask: 0xffffffff max_cycles:
>> 0xffffffff, max_idle_ns: 637086815595 ns
>> [    0.000042] I-pipe, 3.000 MHz clocksource, wrap in 1431655 ms
>> [    0.000059] clocksource: ipipe_tsc: mask: 0xffffffffffffffff max_cycles:
>> 0x1623fa770, max_idle_ns: 881590404476 ns
>> [    0.001630] Interrupt pipeline (release #1)
>> [    0.001784] Console: colour dummy device 80x30
>> [    0.001816] Calibrating delay loop (skipped), value calculated using
>> timer frequency.. 6.00 BogoMIPS (lpj=15000)
>> [    0.001833] pid_max: default: 32768 minimum: 301
>> [    0.001978] Mount-cache hash table entries: 2048 (order: 1, 8192 bytes)
>> [    0.002002] Mountpoint-cache hash table entries: 2048 (order: 1, 8192
>> bytes)
>> [    0.002545] CPU: Testing write buffer coherency: ok
>> [    0.002902] CPU0: thread -1, cpu 0, socket 0, mpidr 80000000
>> [    0.003310] Setting up static identity map for 0x10100000 - 0x10100078
>> [    0.003453] Hierarchical SRCU implementation.
>> [    0.004120] smp: Bringing up secondary CPUs ...
>> [    0.004748] I-pipe, 396.000 MHz timer
>> [    0.004770] CPU1: thread -1, cpu 1, socket 0, mpidr 80000001
>> [    0.005491] I-pipe, 396.000 MHz timer
>> [    0.005512] CPU2: thread -1, cpu 2, socket 0, mpidr 80000002
>> [    0.006237] I-pipe, 396.000 MHz timer
>> [    0.006257] CPU3: thread -1, cpu 3, socket 0, mpidr 80000003
>> [    0.006373] smp: Brought up 1 node, 4 CPUs
>> [    0.006405] SMP: Total of 4 processors activated (24.00 BogoMIPS).
>> [    0.006415] CPU: All CPU(s) started in SVC mode.
>> [    0.007527] devtmpfs: initialized
>> [    0.016773] random: get_random_u32 called from
>> bucket_table_alloc+0x100/0x230 with crng_init=0
>> [    0.016890] VFP support v0.3: implementor 41 architecture 3 part 30
>> variant 9 rev 4
>> [    0.017029] clocksource: jiffies: mask: 0xffffffff max_cycles:
>> 0xffffffff, max_idle_ns: 9556302231375000 ns
>> [    0.017054] futex hash table entries: 1024 (order: 4, 65536 bytes)
>> [    0.017282] pinctrl core: initialized pinctrl subsystem
>> [    0.018032] NET: Registered protocol family 16
>> [    0.019872] DMA: preallocated 256 KiB pool for atomic coherent
>> allocations
>> [    0.020697] CPU identified as i.MX6Q, silicon rev 1.1
>> [    0.026849] vdd1p1: supplied by regulator-dummy
>> [    0.027291] vdd3p0: supplied by regulator-dummy
>> [    0.027687] vdd2p5: supplied by regulator-dummy
>> [    0.037718] hw-breakpoint: found 5 (+1 reserved) breakpoint and 1
>> watchpoint registers.
>> [    0.037731] hw-breakpoint: maximum watchpoint size is 4 bytes.
>> [    0.039110] imx6q-pinctrl 20e0000.iomuxc: initialized IMX pinctrl driver
>> [    0.060477] mxs-dma 110000.dma-apbh: initialized
>> [    0.063177] SCSI subsystem initialized
>> [    0.063409] libata version 3.00 loaded.
>> [    0.063601] usbcore: registered new interface driver usbfs
>> [    0.063658] usbcore: registered new interface driver hub
>> [    0.063755] usbcore: registered new device driver usb
>> [    0.064922] i2c i2c-0: IMX I2C adapter registered
>> [    0.064941] i2c i2c-0: can't use DMA, using PIO instead.
>> [    0.065483] i2c i2c-1: IMX I2C adapter registered
>> [    0.065501] i2c i2c-1: can't use DMA, using PIO instead.
>> [    0.065939] i2c i2c-2: IMX I2C adapter registered
>> [    0.065955] i2c i2c-2: can't use DMA, using PIO instead.
>> [    0.066077] media: Linux media interface: v0.10
>> [    0.066129] Linux video capture interface: v2.00
>> [    0.066188] pps_core: LinuxPPS API ver. 1 registered
>> [    0.066197] pps_core: Software ver. 5.3.6 - Copyright 2005-2007 Rodolfo
>> Giometti <giometti@linux.it>
>> [    0.066219] PTP clock support registered
>> [    0.066476] Advanced Linux Sound Architecture Driver Initialized.
>> [    0.067494] Bluetooth: Core ver 2.22
>> [    0.067538] NET: Registered protocol family 31
>> [    0.067548] Bluetooth: HCI device and connection manager initialized
>> [    0.067565] Bluetooth: HCI socket layer initialized
>> [    0.067579] Bluetooth: L2CAP socket layer initialized
>> [    0.067615] Bluetooth: SCO socket layer initialized
>> [    0.068490] clocksource: Switched to clocksource ipipe_tsc
>> [    0.068592] VFS: Disk quotas dquot_6.6.0
>> [    0.068662] VFS: Dquot-cache hash table entries: 1024 (order 0, 4096
>> bytes)
>> [    0.076791] NET: Registered protocol family 2
>> [    0.077372] TCP established hash table entries: 8192 (order: 3, 32768
>> bytes)
>> [    0.077461] TCP bind hash table entries: 8192 (order: 4, 65536 bytes)
>> [    0.077605] TCP: Hash tables configured (established 8192 bind 8192)
>> [    0.077815] UDP hash table entries: 512 (order: 2, 16384 bytes)
>> [    0.077862] UDP-Lite hash table entries: 512 (order: 2, 16384 bytes)
>> [    0.078054] NET: Registered protocol family 1
>> [    0.078552] RPC: Registered named UNIX socket transport module.
>> [    0.078564] RPC: Registered udp transport module.
>> [    0.078574] RPC: Registered tcp transport module.
>> [    0.078583] RPC: Registered tcp NFSv4.1 backchannel transport module.
>> [    0.079359] hw perfevents: no interrupt-affinity property for /soc/pmu,
>> guessing.
>> [    0.079613] hw perfevents: enabled with armv7_cortex_a9 PMU driver, 7
>> counters available
>> [    0.080925] [Xenomai] scheduling class idle registered.
>> [    0.080936] [Xenomai] scheduling class rt registered.
>> [    0.081181] I-pipe: head domain Xenomai registered.
>> [    0.083885] [Xenomai] Cobalt v3.0.7 (Lingering Dawn)
>> [    0.083987] workingset: timestamp_bits=30 max_order=18 bucket_order=0
>> [    0.088810] NFS: Registering the id_resolver key type
>> [    0.088850] Key type id_resolver registered
>> [    0.088860] Key type id_legacy registered
>> [    0.088905] jffs2: version 2.2. (NAND) © 2001-2006 Red Hat, Inc.
>> [    0.089328] fuse init (API version 7.26)
>> [    0.094536] bounce: pool size: 64 pages
>> [    0.094558] io scheduler noop registered
>> [    0.094568] io scheduler deadline registered
>> [    0.094785] io scheduler cfq registered (default)
>> [    0.094798] io scheduler mq-deadline registered
>> [    0.094807] io scheduler kyber registered
>> [    0.097088] pwm-backlight backlight-lvds: backlight-lvds supply power not
>> found, using dummy regulator
>> [    0.098906] imx-sdma 20ec000.sdma: Direct firmware load for
>> imx/sdma/sdma-imx6q.bin failed with error -2
>> [    0.098924] imx-sdma 20ec000.sdma: external firmware not found, using ROM
>> firmware
>> ...
>>
>>
>>
>>
>> _______________________________________________
>> Xenomai mailing list
>> Xenomai@xenomai.org
>> https://xenomai.org/mailman/listinfo/xenomai
>


