MIME-Version: 1.0
Sender: bodgesoc@gmail.com
In-Reply-To: <52EECA63.6070609@xenomai.org>
References: <CAN1+YZVvgPNNHFub5QAkw6SeSUPuf1dv_94kYGqhbjMpNt70Sg@mail.gmail.com>
 <52D9984F.9080203@xenomai.org>
 <CAN1+YZWnLC=MLxWqYd9xH1URimWnOdEhU4mwZ0S3QFdpghUaGQ@mail.gmail.com>
 <52DAE756.3070606@xenomai.org>
 <CAN1+YZWmjvsu7My92EBktFhWYhheRJvdYrEq=r3+Ravp_Wzoyw@mail.gmail.com>
 <52DBC5FE.6060806@xenomai.org> <52DBD649.2000908@xenomai.org>
 <CAN1+YZWCMh4mR0ccw2v7FeuLKpYDUoPoB-FGHZmutj623DW7hw@mail.gmail.com>
 <52EB6BBC.8040600@xenomai.org>
 <CAN1+YZUhzb1zRE=dhjX+_1_b2cD2vEWatP6-je7b9NdNPosFvA@mail.gmail.com>
 <52EBE4B7.6060800@xenomai.org>
 <CAN1+YZXKAen4YAxKfG9TZTL8B5qXqA-u7O41-ZJqbHqCdbcyow@mail.gmail.com>
 <52EC054C.9070707@xenomai.org>
 <CAN1+YZX=cnRDcadrUHMzLaNBjNPnNbVuBnBHfEK-mTFYmx+3fA@mail.gmail.com>
 <52EC1079.2040300@xenomai.org>
 <CAN1+YZVq7cwFnUX=bkJs8MbAkpio3azSvev2fmZwqQpgjTnvfg@mail.gmail.com>
 <52ECF912.10308@xenomai.org> <52ECFB5F.4070907@xenomai.org>
 <CAN1+YZUOYLPwB45um_FpkQejr5prR936KnmzKkHEnHJzcae7rQ@mail.gmail.com>
 <52EEBFD7.8070901@xenomai.org> <52EECA63.6070609@xenomai.org>
From: Andy Pugh <andy@bodgesoc.org>
Date: Mon, 3 Feb 2014 00:25:01 +0000
Message-ID: <CAN1+YZXQVX0awpJbGeGP-2eXEZcethOj_G+7SPRLhwqCmNPBuQ@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Subject: Re: [Xenomai] Fwd: Kernel Compilation Problems
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai <xenomai@xenomai.org>

>>>>> Could you try and apply the following patch?


Not necessarily due to the patch, but first reboot was:



[    0.000000] Initializing cgroup subsys cpu

[    0.000000] Linux version 3.0.35-Xenomai-g7cce9fa-dirty
(andypugh@udoo) (gcc version 4.6.3 (Ubuntu/Linaro 4.6.3-1ubuntu5) )
#17 SMP PREEMPT Sun Feb 2 23:51:15 UTC 2014

[    0.000000] CPU: ARMv7 Processor [412fc09a] revision 10 (ARMv7), cr=10c53c7d

[    0.000000] CPU: VIPT nonaliasing data cache, VIPT aliasing instruction cache

[    0.000000] Machine: SECO i.Mx6 UDOO Board

[    0.000000] Kernel ver: v. 112

[    0.000000] Memory policy: ECC disabled, Data cache writealloc

[    0.000000] CPU identified as i.MX6Q, silicon rev 1.2

[    0.000000] PERCPU: Embedded 10 pages/cpu @8c008000 s16704 r8192
d16064 u40960

[    0.000000] Built 1 zonelists in Zone order, mobility grouping on.
Total pages: 227328

[    0.000000] Kernel command line: console=ttymxc1,115200
root=/dev/mmcblk0p1 rootwait rw fbmem=24M
video=mxcfb0:dev=hdmi,1920x1080M@60,bpp=32 isolcpus=3
xeno_hal.supported_cpus=8

[    0.000000] PID hash table entries: 4096 (order: 2, 16384 bytes)

[    0.000000] Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)

[    0.000000] Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)

[    0.000000] Memory: 640MB 256MB = 896MB total

[    0.000000] Memory: 895084k/895084k available, 153492k reserved, 0K highmem

[    0.000000] Virtual kernel memory layout:

[    0.000000]     vector  : 0xffff0000 - 0xffff1000   (   4 kB)

[    0.000000]     fixmap  : 0xfff00000 - 0xfffe0000   ( 896 kB)

[    0.000000]     DMA     : 0xf4600000 - 0xffe00000   ( 184 MB)

[    0.000000]     vmalloc : 0xc0800000 - 0xf2000000   ( 792 MB)

[    0.000000]     lowmem  : 0x80000000 - 0xc0000000   (1024 MB)

[    0.000000]     pkmap   : 0x7fe00000 - 0x80000000   (   2 MB)

[    0.000000]     modules : 0x7f000000 - 0x7fe00000   (  14 MB)

[    0.000000]       .init : 0x80008000 - 0x8003d000   ( 212 kB)

[    0.000000]       .text : 0x8003d000 - 0x80c01b18   (12051 kB)

[    0.000000]       .data : 0x80c02000 - 0x80c6f480   ( 438 kB)

[    0.000000]        .bss : 0x80c6f4a4 - 0x80cee2a0   ( 508 kB)

[    0.000000] SLUB: Genslabs=13, HWalign=32, Order=0-3, MinObjects=0,
CPUs=4, Nodes=1

[    0.000000] Preemptible hierarchical RCU implementation.

[    0.000000] NR_IRQS:624

[    0.000000] MXC GPIO hardware

[    0.000000] sched_clock: 32 bits at 3000kHz, resolution 333ns,
wraps every 1431655ms

[    0.000000] arm_max_freq=1GHz

[    0.000000] MXC_Early serial console at MMIO 0x21e8000 (options '115200')

[    0.000000] bootconsole [ttymxc1] enabled

[    0.000000] I-pipe 1.18-13: pipeline enabled.

[    0.000000] Console: colour dummy device 80x30

[    0.230711] Calibrating delay loop... 1581.05 BogoMIPS (lpj=7905280)

[    0.319069] pid_max: default: 32768 minimum: 301

[    0.324038] Mount-cache hash table entries: 512

[    0.329474] Initializing cgroup subsys cpuacct

[    0.333988] Initializing cgroup subsys devices

[    0.338451] Initializing cgroup subsys freezer

[    0.342948] Initializing cgroup subsys blkio

[    0.347298] CPU: Testing write buffer coherency: ok

[    0.352421] I-pipe, 396.000 MHz timer

[    0.356166] I-pipe, 396.000 MHz clocksource

[    0.360416] hw perfevents: enabled with ARMv7 Cortex-A9 PMU driver,
7 counters available

[    0.466819] CPU1: Booted secondary processor

[    0.596831] CPU2: Booted secondary processor

[    0.726868] CPU3: Booted secondary processor

[    0.816237] Brought up 4 CPUs

[    0.832073] SMP: Total of 4 processors activated (6324.22 BogoMIPS).

[    0.838961] devtmpfs: initialized

[    0.862022] print_constraints: dummy:

[    0.865994] NET: Registered protocol family 16

[    0.875471] print_constraints: vddpu: 725 <--> 1300 mV at 1150 mV fast normal

[    0.883099] print_constraints: vddcore: 725 <--> 1300 mV at 1150 mV
fast normal

[    0.890884] print_constraints: vddsoc: 725 <--> 1300 mV at 1200 mV
fast normal

[    0.898626] print_constraints: vdd2p5: 2000 <--> 2775 mV at 2400 mV
fast normal

[    0.906454] print_constraints: vdd1p1: 800 <--> 1400 mV at 1100 mV
fast normal

[    0.914128] print_constraints: vdd3p0: 2625 <--> 3400 mV at 3000 mV
fast normal

[    0.923481]

[    0.923488] > UDOO quad

[    0.927288] > rev C Called set_gpios_direction

[    0.931949] Test and set gpios directions and values by Gionji
feat. Ekirei test

[    0.967109] Resetting ethernet physical layer.

[    1.013860] hw-breakpoint: found 6 breakpoint and 1 watchpoint registers.

[    1.020702] hw-breakpoint: 1 breakpoint(s) reserved for watchpoint
single-step.

[    1.028069] hw-breakpoint: maximum watchpoint size is 4 bytes.

[    1.033947] L310 cache controller enabled

[    1.036215] Internal error: Oops - bad syscall: 80c1cae0 [#1] PREEMPT SMP

[    1.036237] U








And then the second was (oddly) different, but not more succesful:







[    0.000000] Initializing cgroup subsys cpu

[    0.000000] Linux version 3.0.35-Xenomai-g7cce9fa-dirty
(andypugh@udoo) (gcc version 4.6.3 (Ubuntu/Linaro 4.6.3-1ubuntu5) )
#17 SMP PREEMPT Sun Feb 2 23:51:15 UTC 2014

[    0.000000] CPU: ARMv7 Processor [412fc09a] revision 10 (ARMv7), cr=10c53c7d

[    0.000000] CPU: VIPT nonaliasing data cache, VIPT aliasing instruction cache

[    0.000000] Machine: SECO i.Mx6 UDOO Board

[    0.000000] Kernel ver: v. 112

[    0.000000] Memory policy: ECC disabled, Data cache writealloc

[    0.000000] CPU identified as i.MX6Q, silicon rev 1.2

[    0.000000] PERCPU: Embedded 10 pages/cpu @8c008000 s16704 r8192
d16064 u40960

[    0.000000] Built 1 zonelists in Zone order, mobility grouping on.
Total pages: 227328

[    0.000000] Kernel command line: console=ttymxc1,115200
root=/dev/mmcblk0p1 rootwait rw fbmem=24M
video=mxcfb0:dev=hdmi,1920x1080M@60,bpp=32 isolcpus=3
xeno_hal.supported_cpus=8

[    0.000000] PID hash table entries: 4096 (order: 2, 16384 bytes)

[    0.000000] Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)

[    0.000000] Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)

[    0.000000] Memory: 640MB 256MB = 896MB total

[    0.000000] Memory: 895084k/895084k available, 153492k reserved, 0K highmem

[    0.000000] Virtual kernel memory layout:

[    0.000000]     vector  : 0xffff0000 - 0xffff1000   (   4 kB)

[    0.000000]     fixmap  : 0xfff00000 - 0xfffe0000   ( 896 kB)

[    0.000000]     DMA     : 0xf4600000 - 0xffe00000   ( 184 MB)

[    0.000000]     vmalloc : 0xc0800000 - 0xf2000000   ( 792 MB)

[    0.000000]     lowmem  : 0x80000000 - 0xc0000000   (1024 MB)

[    0.000000]     pkmap   : 0x7fe00000 - 0x80000000   (   2 MB)

[    0.000000]     modules : 0x7f000000 - 0x7fe00000   (  14 MB)

[    0.000000]       .init : 0x80008000 - 0x8003d000   ( 212 kB)

[    0.000000]       .text : 0x8003d000 - 0x80c01b18   (12051 kB)

[    0.000000]       .data : 0x80c02000 - 0x80c6f480   ( 438 kB)

[    0.000000]        .bss : 0x80c6f4a4 - 0x80cee2a0   ( 508 kB)

[    0.000000] SLUB: Genslabs=13, HWalign=32, Order=0-3, MinObjects=0,
CPUs=4, Nodes=1

[    0.000000] Preemptible hierarchical RCU implementation.

[    0.000000] NR_IRQS:624

[    0.000000] MXC GPIO hardware

[    0.000000] sched_clock: 32 bits at 3000kHz, resolution 333ns,
wraps every 1431655ms

[    0.000000] arm_max_freq=1GHz

[    0.000000] MXC_Early serial console at MMIO 0x21e8000 (options '115200')

[    0.000000] bootconsole [ttymxc1] enabled

[    0.000000] I-pipe 1.18-13: pipeline enabled.

[    0.000000] Console: colour dummy device 80x30

[    0.230714] Calibrating delay loop... 1581.05 BogoMIPS (lpj=7905280)

[    0.319071] pid_max: default: 32768 minimum: 301

[    0.324038] Mount-cache hash table entries: 512

[    0.329470] Initializing cgroup subsys cpuacct

[    0.333987] Initializing cgroup subsys devices

[    0.338448] Initializing cgroup subsys freezer

[    0.342946] Initializing cgroup subsys blkio

[    0.347294] CPU: Testing write buffer coherency: ok

[    0.352416] I-pipe, 396.000 MHz timer

[    0.356163] I-pipe, 396.000 MHz clocksource

[    0.360412] hw perfevents: enabled with ARMv7 Cortex-A9 PMU driver,
7 counters available

[    0.466810] CPU1: Booted secondary processor

[    0.596827] CPU2: Booted secondary processor

[    0.726861] CPU3: Booted secondary processor

[    0.816232] Brought up 4 CPUs

[    0.832067] SMP: Total of 4 processors activated (6324.22 BogoMIPS).

[    0.838976] devtmpfs: initialized

[    0.862135] print_constraints: dummy:

[    0.866106] NET: Registered protocol family 16

[    0.875593] print_constraints: vddpu: 725 <--> 1300 mV at 1150 mV fast normal

[    0.883222] print_constraints: vddcore: 725 <--> 1300 mV at 1150 mV
fast normal

[    0.891005] print_constraints: vddsoc: 725 <--> 1300 mV at 1200 mV
fast normal

[    0.898753] print_constraints: vdd2p5: 2000 <--> 2775 mV at 2400 mV
fast normal

[    0.906629] print_constraints: vdd1p1: 800 <--> 1400 mV at 1100 mV
fast normal

[    0.914306] print_constraints: vdd3p0: 2625 <--> 3400 mV at 3000 mV
fast normal

[    0.923666]

[    0.923673] > UDOO quad

[    0.927473] > rev C Called set_gpios_direction

[    0.932136] Test and set gpios directions and values by Gionji
feat. Ekirei test

[    0.967019] Resetting ethernet physical layer.

[    1.013832] hw-breakpoint: found 6 breakpoint and 1 watchpoint registers.

[    1.020676] hw-breakpoint: 1 breakpoint(s) reserved for watchpoint
single-step.

[    1.028043] hw-breakpoint: maximum watchpoint size is 4 bytes.

[    1.033923] L310 cache controller enabled

[    1.036208] Unable to handle kernel NULL pointer dereference at
virtual address 00000000

[



Now, where did I leave that bootable kernel?

-- 
atp

