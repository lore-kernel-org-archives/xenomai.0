From: "Lennart Sorensen" <lsorense@csclub.uwaterloo.ca>
Date: Mon, 2 May 2016 11:25:30 -0400
Message-ID: <20160502152530.GC2055@csclub.uwaterloo.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [Xenomai] ipipe enabled 4.1 kernel crash
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

I am trying to move to the 4.1 kernel and when I enable IPIPE in the
config, I get a crash at boot, while with IPIPE disabled in the config
I do not get the crash.  Any suggestions on where to look?

Using 4.1.22 kernel + ipipe-core-4.1.18-arm-4 patch on AM572x CPU (Dual
A15) with LPAE enabled.

## Booting kernel from Legacy Image at 80007fc0 ...
   Image Name:   kernel-4.1.0-2-am5726
   Image Type:   ARM Linux Kernel Image (uncompressed)
   Data Size:    2819104 Bytes = 2.7 MiB
   Load Address: 80008000
   Entry Point:  80008000
   Verifying Checksum ... OK
## Flattened Device Tree blob at 86000000
   Booting using the fdt blob at 0x86000000
   XIP Kernel Image ... OK
   Using Device Tree in place at 86000000, end 86019e3a

Starting kernel ...

[    0.000000] Booting Linux on physical CPU 0x0
[    0.000000] Linux version 4.1.0-2-am5726 (debian-kernel@lists.debian.org) (gcc version 4.9.2 ( 4.9.2-10) ) #1 SMP Debian 4.1.22-1 (2016-04-25)
[    0.000000] CPU: ARMv7 Processor [412fc0f2] revision 2 (ARMv7), cr=30c5387d
[    0.000000] CPU: PIPT / VIPT nonaliasing data cache, PIPT instruction cache
[    0.000000] Machine model: RCM RX1400
[    0.000000] Forcing write-allocate cache policy for SMP
[    0.000000] Memory policy: Data cache writealloc
[    0.000000] OMAP4: Map 0x00000000bfd00000 to fe600000 for dram barrier
[    0.000000] DRA752 ES1.1
[    0.000000] PERCPU: Embedded 15 pages/cpu @eef82000 s31680 r8192 d21568 u61440
[    0.000000] Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 259856
[    0.000000] Kernel command line: root=/dev/mmcblk0p7 ro console=ttyS2,57600n8 rootwait fips=1 single bootver=2014.04RR26
[    0.000000] PID hash table entries: 4096 (order: 2, 16384 bytes)
[    0.000000] Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
[    0.000000] Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
[    0.000000] Memory: 1027268K/1045504K available (5326K kernel code, 426K rwdata, 2044K rodata, 508K init, 333K bss, 18236K reserved, 0K cma-reserved, 267264K highmem)
[    0.000000] Virtual kernel memory layout:
[    0.000000]     vector  : 0xffff0000 - 0xffff1000   (   4 kB)
[    0.000000]     fixmap  : 0xffc00000 - 0xfff00000   (3072 kB)
[    0.000000]     vmalloc : 0xf0000000 - 0xff000000   ( 240 MB)
[    0.000000]     lowmem  : 0xc0000000 - 0xef800000   ( 760 MB)
[    0.000000]     pkmap   : 0xbfe00000 - 0xc0000000   (   2 MB)
[    0.000000]     modules : 0xbf000000 - 0xbfe00000   (  14 MB)
[    0.000000]       .text : 0xc0008000 - 0xc073ae74   (7372 kB)
[    0.000000]       .init : 0xc073b000 - 0xc07ba000   ( 508 kB)
[    0.000000]       .data : 0xc07ba000 - 0xc0824908   ( 427 kB)
[    0.000000]        .bss : 0xc0827000 - 0xc087a6ac   ( 334 kB)
[    0.000000] SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=2, Nodes=1
[    0.000000] Hierarchical RCU implementation.
[    0.000000] kmemleak: Kernel memory leak detector disabled
[    0.000000] NR_IRQS:16 nr_irqs:16 16
[    0.000000] OMAP clockevent source: timer1 at 32768 Hz
[    0.000000] clocksource 32k_counter: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 58327039986419 ns
[    0.000030] sched_clock: 32 bits at 32kHz, resolution 30517ns, wraps every 65535999984741ns
[    0.000030] OMAP clocksource: 32k_counter at 32768 Hz
[    0.000366] Architected cp15 timer(s) running at 6.14MHz (phys).
[    0.000366] I-pipe, 6.147 MHz clocksource, wrap in 3000934451555157 ms
[    0.000396] clocksource ipipe_tsc: mask: 0xffffffffffffffff max_cycles: 0x16af5adb9, max_idle_ns: 440795202250 ns
[    0.000396] clocksource arch_sys_counter: mask: 0xffffffffffffff max_cycles: 0x16af5adb9, max_idle_ns: 440795202250 ns
[    0.000432] sched_clock: 56 bits at 6MHz, resolution 162ns, wraps every 4398046511023ns
[    0.000442] Switching to timer-based delay loop, resolution 162ns
[    0.001523] Interrupt pipeline (release #4)
[    0.102164] Calibrating delay loop (skipped), value calculated using timer frequency.. 12.29 BogoMIPS (lpj=6147)
[    0.102179] pid_max: default: 32768 minimum: 301
[    0.102268] Security Framework initialized
[    0.102325] Mount-cache hash table entries: 2048 (order: 1, 8192 bytes)
[    0.102336] Mountpoint-cache hash table entries: 2048 (order: 1, 8192 bytes)
[    0.102912] Initializing cgroup subsys net_cls
[    0.102951] CPU: Testing write buffer coherency: ok
[    0.103237] /cpus/cpu@0 missing clock-frequency property
[    0.103289] /cpus/cpu@1 missing clock-frequency property
[    0.103301] CPU0: thread -1, cpu 0, socket 0, mpidr 80000000
[    0.103352] Setting up static identity map for 0x80008380 - 0x800083d8
[    0.106241] CPU1: thread -1, cpu 1, socket 0, mpidr 80000001
[    0.106318] Brought up 2 CPUs
[    0.106332] SMP: Total of 2 processors activated (24.58 BogoMIPS).
[    0.106339] CPU: All CPU(s) started in HYP mode.
[    0.106346] CPU: Virtualization extensions available.
[    0.106785] devtmpfs: initialized
[    0.134693] VFP support v0.3: implementor 41 architecture 4 part 30 variant f rev 0
[    0.135668] omap_hwmod: l3_main_2 using broken dt data from ocp
[    0.358605] clocksource jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 1911260446275000 ns
[    0.359002] pinctrl core: initialized pinctrl subsystem
[    0.359918] NET: Registered protocol family 16
[    0.360103] DMA: preallocated 256 KiB pool for atomic coherent allocations
[    0.369806] OMAP GPIO hardware version 0.1
[    0.376640] irq: no irq domain found for /ocp/l4@4a000000/scm@2000/pinmux@1400 !
[    0.394067] hw-breakpoint: found 5 (+1 reserved) breakpoint and 4 watchpoint registers.
[    0.394078] hw-breakpoint: maximum watchpoint size is 8 bytes.
[    0.394477] omap4_sram_init:Unable to allocate sram needed to handle errata I688
[    0.394487] omap4_sram_init:Unable to get sram pool needed to handle errata I688
[    0.395080] OMAP DMA hardware revision 0.0
[    0.410462] edma 43300000.edma: memcpy is disabled
[    0.416563] edma 43300000.edma: TI EDMA DMA engine driver
[    0.420053] omap-dma-engine 4a056000.dma-controller: OMAP DMA engine driver
[    0.423362] SCSI subsystem initialized
[    0.423714] usbcore: registered new interface driver usbfs
[    0.423790] usbcore: registered new interface driver hub
[    0.423858] usbcore: registered new device driver usb
[    0.424386] omap_i2c 48070000.i2c: could not find pctldev for node /ocp/l4@4a000000/scm@2000/pinmux@1400/pinmux_i2c1_pins, deferring probe
[    0.424425] omap_i2c 48072000.i2c: could not find pctldev for node /ocp/l4@4a000000/scm@2000/pinmux@1400/pinmux_i2c2_pins, deferring probe
[    0.424481] omap_i2c 48060000.i2c: could not find pctldev for node /ocp/l4@4a000000/scm@2000/pinmux@1400/pinmux_i2c3_pins, deferring probe
[    0.424514] omap_i2c 4807a000.i2c: could not find pctldev for node /ocp/l4@4a000000/scm@2000/pinmux@1400/pinmux_i2c4_pins, deferring probe
[    0.424660] pps_core: LinuxPPS API ver. 1 registered
[    0.424668] pps_core: Software ver. 5.3.6 - Copyright 2005-2007 Rodolfo Giometti <giometti@linux.it>
[    0.424707] PTP clock support registered
[    0.426326] Switched to clocksource ipipe_tsc
[    0.446221] NET: Registered protocol family 2
[    0.446882] TCP established hash table entries: 8192 (order: 3, 32768 bytes)
[    0.446948] TCP bind hash table entries: 8192 (order: 4, 65536 bytes)
[    0.447074] TCP: Hash tables configured (established 8192 bind 8192)
[    0.447137] UDP hash table entries: 512 (order: 2, 16384 bytes)
[    0.447168] UDP-Lite hash table entries: 512 (order: 2, 16384 bytes)
[    0.447380] NET: Registered protocol family 1
[    0.448026] kvm [1]: interrupt-controller@48214000 IRQ21
[    0.448246] kvm [1]: timer IRQ19
[    0.448267] kvm [1]: Hyp mode initialized successfully
[    0.449107] CPU PMU: Failed to parse /pmu/interrupt-affinity[0]
[    0.449144] hw perfevents: enabled with armv7_cortex_a15 PMU driver, 7 counters available
[    0.451056] futex hash table entries: 512 (order: 3, 32768 bytes)
[    0.451149] audit: initializing netlink subsys (disabled)
[    0.451212] audit: type=2000 audit(0.445:1): initialized
[    0.462778] VFS: Disk quotas dquot_6.6.0
[    0.463000] VFS: Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)
[    0.464458] squashfs: version 4.0 (2009/01/31) Phillip Lougher
[    0.468634] alg: No test for stdrng (krng)
[    0.473670] bounce: pool size: 64 pages
[    0.473894] Block layer SCSI generic (bsg) driver version 0.4 loaded (major 250)
[    0.473910] io scheduler noop registered
[    0.473923] io scheduler deadline registered (default)
[    0.473960] io scheduler cfq registered
[    0.476622] pinctrl-single 4a003400.pinmux: 281 pins at pa fc003400 size 1124
[    0.647326] Serial: 8250/16550 driver, 16 ports, IRQ sharing disabled
[    0.652404] 4806a000.serial: ttyS0 at MMIO 0x4806a000 (irq = 301, base_baud = 3000000) is a 8250
[    0.653358] console [ttyS2] disabled
[    0.653390] 48020000.serial: ttyS2 at MMIO 0x48020000 (irq = 302, base_baud = 3000000) is a 8250
[    2.111714] console [ttyS2] enabled
[    2.119646] 48420000.serial: ttyS6 at MMIO 0x48420000 (irq = 303, base_baud = 3000000) is a 8250
[    2.138162] 48422000.serial: ttyS7 at MMIO 0x48422000 (irq = 304, base_baud = 3000000) is a 8250
[    2.156993] omap_rng 48090000.rng: OMAP Random Number Generator ver. 20
[    2.172394] libphy: Fixed MDIO Bus: probed
[    2.214348] davinci_mdio 48485000.mdio: davinci mdio revision 1.6
[    2.226599] davinci_mdio 48485000.mdio: no live phy, scanning all
[    2.239825] davinci_mdio: probe of 48485000.mdio failed with error -5
[    2.253437] cpsw 48484000.ethernet: Detected MACID = 94:b8:c5:ef:a5:ff
[    2.267754] usbcore: registered new interface driver cdc_wdm
[    2.279219] usbcore: registered new interface driver usb-storage
[    2.291853] i2c /dev entries driver
[    2.299590] device-mapper: uevent: version 1.0.3
[    2.309229] device-mapper: ioctl: 4.31.0-ioctl (2015-3-12) initialised: dm-devel@redhat.com
[    2.326759] omap_hsmmc 4809c000.mmc: Got CD GPIO
[    2.336093] omap_hsmmc 4809c000.mmc: dtb requests mmcblk1
[    2.347127] omap_hsmmc 4809c000.mmc: no pinctrl state for sdr104 mode
[    2.360086] omap_hsmmc 4809c000.mmc: no pinctrl state for ddr50 mode
[    2.372873] omap_hsmmc 4809c000.mmc: no pinctrl state for sdr50 mode
[    2.385657] omap_hsmmc 4809c000.mmc: no pinctrl state for sdr25 mode
[    2.398432] omap_hsmmc 4809c000.mmc: no pinctrl state for sdr12 mode
[    2.417774] omap_hsmmc 480b4000.mmc: dtb requests mmcblk0
[    2.428771] omap_hsmmc 480b4000.mmc: no pinctrl state for sdr25 mode
[    2.441542] omap_hsmmc 480b4000.mmc: no pinctrl state for sdr12 mode
[    2.454306] omap_hsmmc 480b4000.mmc: no pinctrl state for ddr_1_8v mode
[    2.467602] omap_hsmmc 480b4000.mmc: no pinctrl state for hs200_1_8v mode
[    2.481422] reg-fixed-voltage fixedregulator-evm_3v3_sw: Failed to resolve vin-supply for evm_3v3_sw
[    2.504772] ledtrig-cpu: registered to indicate activity on CPUs
[    2.517248] omap-sham 4b101000.sham: hw accel on OMAP rev 4.3
[    2.528979] Unable to handle kernel NULL pointer dereference at virtual address 00000000
[    2.545215] pgd = c0003000
[    2.550636] [00000000] *pgd=80000080004003, *pmd=00000000
[    2.561487] Internal error: Oops: 80000206 [#1] SMP ARM
[    2.571968] Modules linked in:
[    2.578098] CPU: 0 PID: 0 Comm: swapper/0 Not tainted 4.1.0-2-am5726 #1 Debian 4.1.22-1
[    2.594159] Hardware name: Generic DRA74X (Flattened Device Tree)
[    2.606384] task: c07bfbf8 ti: c07ba000 task.ti: c07ba000
[    2.617211] PC is at 0x0
[    2.622288] LR is at __ipipe_ack_fasteoi_irq+0x1c/0x20
[    2.632595] pc : [<00000000>]    lr : [<c00975f0>]    psr: a0000193
[    2.632595] sp : c07bbe88  ip : c07bbe98  fp : c07bbe94
[    2.655635] r10: 00000021  r9 : c08182c0  r8 : 00000020
[    2.666113] r7 : 00000000  r6 : c07bbf00  r5 : 00000000  r4 : c07d3b9c
[    2.679209] r3 : 00000000  r2 : c084f1c0  r1 : eeaab180  r0 : eeaab180
[    2.692306] Flags: NzCv  IRQs off  FIQs on  Mode SVC_32  ISA ARM  Segment kernel
[    2.707149] Control: 30c5387d  Table: 80003000  DAC: fffffffd
[    2.718675] Process swapper/0 (pid: 0, stack limit = 0xc07ba218)
[    2.730724] Stack: (0xc07bbe88 to 0xc07bc000)
[    2.739462] be80:                   c07bbec4 c07bbe98 c00dde78 c00975e0 c00dd8cc c07bbf00
[    2.755874] bea0: c07bcbc4 c07bbf00 fa212000 c0540d34 c08182c0 c079f6e8 c07bbedc c07bbec8
[    2.772287] bec0: c0009578 c00dddfc 000000c0 fa21200c c07bbefc c07bbee0 c00098a0 c0009510
[    2.788699] bee0: c00dd8cc 60000113 ffffffff c07bbf34 c07bbf54 c07bbf00 c0538840 c0009878
[    2.805110] bf00: eef83878 00000000 2e7d0000 00000000 c07ba000 c07bc620 c0827000 c07bc5d4
[    2.821523] bf20: c0540d34 c08182c0 c079f6e8 c07bbf54 c07bbf58 c07bbf48 c0028410 c00dd8cc
[    2.837934] bf40: 60000113 ffffffff c07bbf64 c07bbf58 c0028410 c00dd880 c07bbf8c c07bbf68
[    2.854346] bf60: c008a6fc c002837c c08175de c08272c0 c07bca38 c07b23c4 c0534f94 00000000
[    2.870757] bf80: c07bbf9c c07bbf90 c0530e98 c008a4e8 c07bbff4 c07bbfa0 c073bd54 c0530e24
[    2.887170] bfa0: ffffffff ffffffff c073b6f0 00000000 ffffffff 00000000 00000000 c07bc540
[    2.903582] bfc0: 00000000 c079f6e8 00000000 c0827314 c07bc5a8 c079f6e4 c07c28c0 80007000
[    2.919994] bfe0: 412fc0f2 00000000 00000000 c07bbff8 80008090 c073b970 00000000 00000000
[    2.936402] Backtrace: 
[    2.941320] [<c00975d4>] (__ipipe_ack_fasteoi_irq) from [<c00dde78>] (__ipipe_dispatch_irq+0x88/0x23c)
[    2.960003] [<c00dddf0>] (__ipipe_dispatch_irq) from [<c0009578>] (__ipipe_grab_irq+0x74/0x8c)
[    2.977284]  r10:c079f6e8 r9:c08182c0 r8:c0540d34 r7:fa212000 r6:c07bbf00 r5:c07bcbc4
[    2.993049]  r4:c07bbf00 r3:c00dd8cc
[    3.000238] [<c0009504>] (__ipipe_grab_irq) from [<c00098a0>] (gic_handle_irq+0x34/0x64)
[    3.016475] Exception stack(0xc07bbee0 to 0xc07bbf28)
[    3.026607] bee0: c00dd8cc 60000113 ffffffff c07bbf34 c07bbf54 c07bbf00 c0538840 c0009878
[    3.043018] bf00: eef83878 00000000 2e7d0000 00000000 c07ba000 c07bc620 c0827000 c07bc5d4
[    3.059428] bf20: c0540d34 c08182c0
[    3.066419]  r4:fa21200c r3:000000c0
[    3.073614] [<c000986c>] (gic_handle_irq) from [<c0538840>] (__irq_svc+0x40/0x4c)
[    3.088629] Exception stack(0xc07bbf00 to 0xc07bbf48)
[    3.098762] bf00: eef83878 00000000 2e7d0000 00000000 c07ba000 c07bc620 c0827000 c07bc5d4
[    3.115173] bf20: c0540d34 c08182c0 c079f6e8 c07bbf54 c07bbf58 c07bbf48 c0028410 c00dd8cc
[    3.131582] bf40: 60000113 ffffffff
[    3.138573]  r7:c07bbf34 r6:ffffffff r5:60000113 r4:c00dd8cc
[    3.149971] [<c00dd874>] (ipipe_unstall_root) from [<c0028410>] (arch_cpu_idle+0xa0/0xac)
[    3.166386] [<c0028370>] (arch_cpu_idle) from [<c008a6fc>] (cpu_startup_entry+0x220/0x2bc)
[    3.182974] [<c008a4dc>] (cpu_startup_entry) from [<c0530e98>] (rest_init+0x80/0x84)
[    3.198511]  r7:00000000
[    3.203599] [<c0530e18>] (rest_init) from [<c073bd54>] (start_kernel+0x3f0/0x3fc)
[    3.218617] [<c073b964>] (start_kernel) from [<80008090>] (0x80008090)
[    3.231711]  r10:00000000 r9:412fc0f2 r8:80007000 r7:c07c28c0 r6:c079f6e4 r5:c07bc5a8
[    3.247472]  r4:c0827314
[    3.252555] Code: bad PC value
[    3.258684] ---[ end trace 9986ec0f8b714eed ]---
[    3.267944] Kernel panic - not syncing: Attempted to kill the idle task!
[    3.281391] CPU1: stopping
[    3.286818] CPU: 1 PID: 0 Comm: swapper/1 Tainted: G      D         4.1.0-2-am5726 #1 Debian 4.1.22-1
[    3.305321] Hardware name: Generic DRA74X (Flattened Device Tree)
[    3.317543] Backtrace: 
[    3.322456] [<c002b67c>] (dump_backtrace) from [<c002b8a0>] (show_stack+0x18/0x1c)
[    3.337644]  r6:ee8ee000 r5:00000000 r4:c07f5b4c r3:00000000
[    3.349042] [<c002b888>] (show_stack) from [<c0533c68>] (dump_stack+0xa4/0xc0)
[    3.363539] [<c0533bc4>] (dump_stack) from [<c002d954>] (handle_IPI+0x2a8/0x2c4)
[    3.378378]  r7:00000005 r6:c08272c0 r5:c07bca38 r4:c0827360
[    3.389774] [<c002d6ac>] (handle_IPI) from [<c002d9ac>] (__ipipe_do_IPI+0x3c/0x44)
[    3.404962]  r10:c084f1c0 r9:eef92888 r8:eef92880 r7:eef92880 r6:00000001 r5:00000000
[    3.420724]  r4:c085f300
[    3.425812] [<c002d970>] (__ipipe_do_IPI) from [<c00dd740>] (__ipipe_do_sync_stage+0x280/0x2c4)
[    3.443274] [<c00dd4c0>] (__ipipe_do_sync_stage) from [<c00de004>] (__ipipe_dispatch_irq+0x214/0x23c)
[    3.461775]  r10:00000406 r9:c07b5bb8 r8:00000405 r7:00000001 r6:c08272c0 r5:c07bca38
[    3.477534]  r4:c07d3b9c
[    3.482620] [<c00dddf0>] (__ipipe_dispatch_irq) from [<c0009494>] (__ipipe_grab_ipi+0x34/0x90)
[    3.499901]  r10:00000000 r9:c08182c0 r8:c0540d34 r7:fa212000 r6:ee8eff50 r5:c07bcbc4
[    3.515661]  r4:ee8eff50 r3:0000040c
[    3.522847] [<c0009460>] (__ipipe_grab_ipi) from [<c00098cc>] (gic_handle_irq+0x60/0x64)
[    3.539081] Exception stack(0xee8eff30 to 0xee8eff78)
[    3.549212] ff20:                                     c00dd8cc 60000113 ffffffff ee8eff84
[    3.565623] ff40: ee8effa4 ee8eff50 c0538840 c0009878 eef92878 00000000 2e7df000 00000000
[    3.582034] ff60: ee8ee000 c07bc620 30c0387d c07bc5d4 c0540d34 c08182c0
[    3.595302]  r4:fa21200c r3:c0028410
[    3.602493] [<c000986c>] (gic_handle_irq) from [<c0538840>] (__irq_svc+0x40/0x4c)
[    3.617506] Exception stack(0xee8eff50 to 0xee8eff98)
[    3.627638] ff40:                                     eef92878 00000000 2e7df000 00000000
[    3.644049] ff60: ee8ee000 c07bc620 30c0387d c07bc5d4 c0540d34 c08182c0 00000000 ee8effa4
[    3.660459] ff80: ee8effa8 ee8eff98 c0028410 c00dd8cc 60000113 ffffffff
[    3.673727]  r7:ee8eff84 r6:ffffffff r5:60000113 r4:c00dd8cc
[    3.685124] [<c00dd874>] (ipipe_unstall_root) from [<c0028410>] (arch_cpu_idle+0xa0/0xac)
[    3.701538] [<c0028370>] (arch_cpu_idle) from [<c008a6fc>] (cpu_startup_entry+0x220/0x2bc)
[    3.718126] [<c008a4dc>] (cpu_startup_entry) from [<c002d3a8>] (secondary_start_kernel+0x138/0x154)
[    3.736279]  r7:c0827380
[    3.741363] [<c002d270>] (secondary_start_kernel) from [<8000996c>] (0x8000996c)
[    3.756201]  r5:00000000 r4:ae88ec80
[    3.763391] ---[ end Kernel panic - not syncing: Attempted to kill the idle task!

-- 
Len Sorensen

