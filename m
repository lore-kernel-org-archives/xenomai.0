From: "Lennart Sorensen" <lsorense@csclub.uwaterloo.ca>
Date: Mon, 2 May 2016 12:54:16 -0400
Message-ID: <20160502165416.GD2055@csclub.uwaterloo.ca>
References: <20160502152530.GC2055@csclub.uwaterloo.ca>
 <57278183.6090800@siemens.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <57278183.6090800@siemens.com>
Subject: Re: [Xenomai] ipipe enabled 4.1 kernel crash
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: xenomai@xenomai.org

On Mon, May 02, 2016 at 06:34:11PM +0200, Jan Kiszka wrote:
> On 2016-05-02 17:25, Lennart Sorensen wrote:
> > I am trying to move to the 4.1 kernel and when I enable IPIPE in the
> > config, I get a crash at boot, while with IPIPE disabled in the config
> > I do not get the crash.  Any suggestions on where to look?
> > 
> > Using 4.1.22 kernel + ipipe-core-4.1.18-arm-4 patch on AM572x CPU (Dual
> > A15) with LPAE enabled.
> > 
> > ## Booting kernel from Legacy Image at 80007fc0 ...
> >    Image Name:   kernel-4.1.0-2-am5726
> >    Image Type:   ARM Linux Kernel Image (uncompressed)
> >    Data Size:    2819104 Bytes = 2.7 MiB
> >    Load Address: 80008000
> >    Entry Point:  80008000
> >    Verifying Checksum ... OK
> > ## Flattened Device Tree blob at 86000000
> >    Booting using the fdt blob at 0x86000000
> >    XIP Kernel Image ... OK
> >    Using Device Tree in place at 86000000, end 86019e3a
> > 
> > Starting kernel ...
> > 
> > [    0.000000] Booting Linux on physical CPU 0x0
> > [    0.000000] Linux version 4.1.0-2-am5726 (debian-kernel@lists.debian.org) (gcc version 4.9.2 ( 4.9.2-10) ) #1 SMP Debian 4.1.22-1 (2016-04-25)
> > [    0.000000] CPU: ARMv7 Processor [412fc0f2] revision 2 (ARMv7), cr=30c5387d
> > [    0.000000] CPU: PIPT / VIPT nonaliasing data cache, PIPT instruction cache
> > [    0.000000] Machine model: RCM RX1400
> > [    0.000000] Forcing write-allocate cache policy for SMP
> > [    0.000000] Memory policy: Data cache writealloc
> > [    0.000000] OMAP4: Map 0x00000000bfd00000 to fe600000 for dram barrier
> > [    0.000000] DRA752 ES1.1
> > [    0.000000] PERCPU: Embedded 15 pages/cpu @eef82000 s31680 r8192 d21568 u61440
> > [    0.000000] Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 259856
> > [    0.000000] Kernel command line: root=/dev/mmcblk0p7 ro console=ttyS2,57600n8 rootwait fips=1 single bootver=2014.04RR26
> > [    0.000000] PID hash table entries: 4096 (order: 2, 16384 bytes)
> > [    0.000000] Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
> > [    0.000000] Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
> > [    0.000000] Memory: 1027268K/1045504K available (5326K kernel code, 426K rwdata, 2044K rodata, 508K init, 333K bss, 18236K reserved, 0K cma-reserved, 267264K highmem)
> > [    0.000000] Virtual kernel memory layout:
> > [    0.000000]     vector  : 0xffff0000 - 0xffff1000   (   4 kB)
> > [    0.000000]     fixmap  : 0xffc00000 - 0xfff00000   (3072 kB)
> > [    0.000000]     vmalloc : 0xf0000000 - 0xff000000   ( 240 MB)
> > [    0.000000]     lowmem  : 0xc0000000 - 0xef800000   ( 760 MB)
> > [    0.000000]     pkmap   : 0xbfe00000 - 0xc0000000   (   2 MB)
> > [    0.000000]     modules : 0xbf000000 - 0xbfe00000   (  14 MB)
> > [    0.000000]       .text : 0xc0008000 - 0xc073ae74   (7372 kB)
> > [    0.000000]       .init : 0xc073b000 - 0xc07ba000   ( 508 kB)
> > [    0.000000]       .data : 0xc07ba000 - 0xc0824908   ( 427 kB)
> > [    0.000000]        .bss : 0xc0827000 - 0xc087a6ac   ( 334 kB)
> > [    0.000000] SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=2, Nodes=1
> > [    0.000000] Hierarchical RCU implementation.
> > [    0.000000] kmemleak: Kernel memory leak detector disabled
> > [    0.000000] NR_IRQS:16 nr_irqs:16 16
> > [    0.000000] OMAP clockevent source: timer1 at 32768 Hz
> > [    0.000000] clocksource 32k_counter: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 58327039986419 ns
> > [    0.000030] sched_clock: 32 bits at 32kHz, resolution 30517ns, wraps every 65535999984741ns
> > [    0.000030] OMAP clocksource: 32k_counter at 32768 Hz
> > [    0.000366] Architected cp15 timer(s) running at 6.14MHz (phys).
> > [    0.000366] I-pipe, 6.147 MHz clocksource, wrap in 3000934451555157 ms
> > [    0.000396] clocksource ipipe_tsc: mask: 0xffffffffffffffff max_cycles: 0x16af5adb9, max_idle_ns: 440795202250 ns
> > [    0.000396] clocksource arch_sys_counter: mask: 0xffffffffffffff max_cycles: 0x16af5adb9, max_idle_ns: 440795202250 ns
> > [    0.000432] sched_clock: 56 bits at 6MHz, resolution 162ns, wraps every 4398046511023ns
> > [    0.000442] Switching to timer-based delay loop, resolution 162ns
> > [    0.001523] Interrupt pipeline (release #4)
> > [    0.102164] Calibrating delay loop (skipped), value calculated using timer frequency.. 12.29 BogoMIPS (lpj=6147)
> > [    0.102179] pid_max: default: 32768 minimum: 301
> > [    0.102268] Security Framework initialized
> > [    0.102325] Mount-cache hash table entries: 2048 (order: 1, 8192 bytes)
> > [    0.102336] Mountpoint-cache hash table entries: 2048 (order: 1, 8192 bytes)
> > [    0.102912] Initializing cgroup subsys net_cls
> > [    0.102951] CPU: Testing write buffer coherency: ok
> > [    0.103237] /cpus/cpu@0 missing clock-frequency property
> > [    0.103289] /cpus/cpu@1 missing clock-frequency property
> > [    0.103301] CPU0: thread -1, cpu 0, socket 0, mpidr 80000000
> > [    0.103352] Setting up static identity map for 0x80008380 - 0x800083d8
> > [    0.106241] CPU1: thread -1, cpu 1, socket 0, mpidr 80000001
> > [    0.106318] Brought up 2 CPUs
> > [    0.106332] SMP: Total of 2 processors activated (24.58 BogoMIPS).
> > [    0.106339] CPU: All CPU(s) started in HYP mode.
> > [    0.106346] CPU: Virtualization extensions available.
> > [    0.106785] devtmpfs: initialized
> > [    0.134693] VFP support v0.3: implementor 41 architecture 4 part 30 variant f rev 0
> > [    0.135668] omap_hwmod: l3_main_2 using broken dt data from ocp
> > [    0.358605] clocksource jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 1911260446275000 ns
> > [    0.359002] pinctrl core: initialized pinctrl subsystem
> > [    0.359918] NET: Registered protocol family 16
> > [    0.360103] DMA: preallocated 256 KiB pool for atomic coherent allocations
> > [    0.369806] OMAP GPIO hardware version 0.1
> > [    0.376640] irq: no irq domain found for /ocp/l4@4a000000/scm@2000/pinmux@1400 !
> > [    0.394067] hw-breakpoint: found 5 (+1 reserved) breakpoint and 4 watchpoint registers.
> > [    0.394078] hw-breakpoint: maximum watchpoint size is 8 bytes.
> > [    0.394477] omap4_sram_init:Unable to allocate sram needed to handle errata I688
> > [    0.394487] omap4_sram_init:Unable to get sram pool needed to handle errata I688
> > [    0.395080] OMAP DMA hardware revision 0.0
> > [    0.410462] edma 43300000.edma: memcpy is disabled
> > [    0.416563] edma 43300000.edma: TI EDMA DMA engine driver
> > [    0.420053] omap-dma-engine 4a056000.dma-controller: OMAP DMA engine driver
> > [    0.423362] SCSI subsystem initialized
> > [    0.423714] usbcore: registered new interface driver usbfs
> > [    0.423790] usbcore: registered new interface driver hub
> > [    0.423858] usbcore: registered new device driver usb
> > [    0.424386] omap_i2c 48070000.i2c: could not find pctldev for node /ocp/l4@4a000000/scm@2000/pinmux@1400/pinmux_i2c1_pins, deferring probe
> > [    0.424425] omap_i2c 48072000.i2c: could not find pctldev for node /ocp/l4@4a000000/scm@2000/pinmux@1400/pinmux_i2c2_pins, deferring probe
> > [    0.424481] omap_i2c 48060000.i2c: could not find pctldev for node /ocp/l4@4a000000/scm@2000/pinmux@1400/pinmux_i2c3_pins, deferring probe
> > [    0.424514] omap_i2c 4807a000.i2c: could not find pctldev for node /ocp/l4@4a000000/scm@2000/pinmux@1400/pinmux_i2c4_pins, deferring probe
> > [    0.424660] pps_core: LinuxPPS API ver. 1 registered
> > [    0.424668] pps_core: Software ver. 5.3.6 - Copyright 2005-2007 Rodolfo Giometti <giometti@linux.it>
> > [    0.424707] PTP clock support registered
> > [    0.426326] Switched to clocksource ipipe_tsc
> > [    0.446221] NET: Registered protocol family 2
> > [    0.446882] TCP established hash table entries: 8192 (order: 3, 32768 bytes)
> > [    0.446948] TCP bind hash table entries: 8192 (order: 4, 65536 bytes)
> > [    0.447074] TCP: Hash tables configured (established 8192 bind 8192)
> > [    0.447137] UDP hash table entries: 512 (order: 2, 16384 bytes)
> > [    0.447168] UDP-Lite hash table entries: 512 (order: 2, 16384 bytes)
> > [    0.447380] NET: Registered protocol family 1
> > [    0.448026] kvm [1]: interrupt-controller@48214000 IRQ21
> > [    0.448246] kvm [1]: timer IRQ19
> > [    0.448267] kvm [1]: Hyp mode initialized successfully
> > [    0.449107] CPU PMU: Failed to parse /pmu/interrupt-affinity[0]
> > [    0.449144] hw perfevents: enabled with armv7_cortex_a15 PMU driver, 7 counters available
> > [    0.451056] futex hash table entries: 512 (order: 3, 32768 bytes)
> > [    0.451149] audit: initializing netlink subsys (disabled)
> > [    0.451212] audit: type=2000 audit(0.445:1): initialized
> > [    0.462778] VFS: Disk quotas dquot_6.6.0
> > [    0.463000] VFS: Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)
> > [    0.464458] squashfs: version 4.0 (2009/01/31) Phillip Lougher
> > [    0.468634] alg: No test for stdrng (krng)
> > [    0.473670] bounce: pool size: 64 pages
> > [    0.473894] Block layer SCSI generic (bsg) driver version 0.4 loaded (major 250)
> > [    0.473910] io scheduler noop registered
> > [    0.473923] io scheduler deadline registered (default)
> > [    0.473960] io scheduler cfq registered
> > [    0.476622] pinctrl-single 4a003400.pinmux: 281 pins at pa fc003400 size 1124
> > [    0.647326] Serial: 8250/16550 driver, 16 ports, IRQ sharing disabled
> > [    0.652404] 4806a000.serial: ttyS0 at MMIO 0x4806a000 (irq = 301, base_baud = 3000000) is a 8250
> > [    0.653358] console [ttyS2] disabled
> > [    0.653390] 48020000.serial: ttyS2 at MMIO 0x48020000 (irq = 302, base_baud = 3000000) is a 8250
> > [    2.111714] console [ttyS2] enabled
> > [    2.119646] 48420000.serial: ttyS6 at MMIO 0x48420000 (irq = 303, base_baud = 3000000) is a 8250
> > [    2.138162] 48422000.serial: ttyS7 at MMIO 0x48422000 (irq = 304, base_baud = 3000000) is a 8250
> > [    2.156993] omap_rng 48090000.rng: OMAP Random Number Generator ver. 20
> > [    2.172394] libphy: Fixed MDIO Bus: probed
> > [    2.214348] davinci_mdio 48485000.mdio: davinci mdio revision 1.6
> > [    2.226599] davinci_mdio 48485000.mdio: no live phy, scanning all
> > [    2.239825] davinci_mdio: probe of 48485000.mdio failed with error -5
> > [    2.253437] cpsw 48484000.ethernet: Detected MACID = 94:b8:c5:ef:a5:ff
> > [    2.267754] usbcore: registered new interface driver cdc_wdm
> > [    2.279219] usbcore: registered new interface driver usb-storage
> > [    2.291853] i2c /dev entries driver
> > [    2.299590] device-mapper: uevent: version 1.0.3
> > [    2.309229] device-mapper: ioctl: 4.31.0-ioctl (2015-3-12) initialised: dm-devel@redhat.com
> > [    2.326759] omap_hsmmc 4809c000.mmc: Got CD GPIO
> > [    2.336093] omap_hsmmc 4809c000.mmc: dtb requests mmcblk1
> > [    2.347127] omap_hsmmc 4809c000.mmc: no pinctrl state for sdr104 mode
> > [    2.360086] omap_hsmmc 4809c000.mmc: no pinctrl state for ddr50 mode
> > [    2.372873] omap_hsmmc 4809c000.mmc: no pinctrl state for sdr50 mode
> > [    2.385657] omap_hsmmc 4809c000.mmc: no pinctrl state for sdr25 mode
> > [    2.398432] omap_hsmmc 4809c000.mmc: no pinctrl state for sdr12 mode
> > [    2.417774] omap_hsmmc 480b4000.mmc: dtb requests mmcblk0
> > [    2.428771] omap_hsmmc 480b4000.mmc: no pinctrl state for sdr25 mode
> > [    2.441542] omap_hsmmc 480b4000.mmc: no pinctrl state for sdr12 mode
> > [    2.454306] omap_hsmmc 480b4000.mmc: no pinctrl state for ddr_1_8v mode
> > [    2.467602] omap_hsmmc 480b4000.mmc: no pinctrl state for hs200_1_8v mode
> > [    2.481422] reg-fixed-voltage fixedregulator-evm_3v3_sw: Failed to resolve vin-supply for evm_3v3_sw
> > [    2.504772] ledtrig-cpu: registered to indicate activity on CPUs
> > [    2.517248] omap-sham 4b101000.sham: hw accel on OMAP rev 4.3
> > [    2.528979] Unable to handle kernel NULL pointer dereference at virtual address 00000000
> > [    2.545215] pgd = c0003000
> > [    2.550636] [00000000] *pgd=80000080004003, *pmd=00000000
> > [    2.561487] Internal error: Oops: 80000206 [#1] SMP ARM
> > [    2.571968] Modules linked in:
> > [    2.578098] CPU: 0 PID: 0 Comm: swapper/0 Not tainted 4.1.0-2-am5726 #1 Debian 4.1.22-1
> > [    2.594159] Hardware name: Generic DRA74X (Flattened Device Tree)
> > [    2.606384] task: c07bfbf8 ti: c07ba000 task.ti: c07ba000
> > [    2.617211] PC is at 0x0
> > [    2.622288] LR is at __ipipe_ack_fasteoi_irq+0x1c/0x20
> 
> Check which handler from which object is called here that isn't
> apparently initialized for this case. Maybe this particular irqchip
> isn't (fully) enabled for I-pipe yet.

That's what I am trying to do.  Pretty sure I determined the irq_hold
function pointer is NULL on whatever it is.  So far my attempt to printk
in __ipipe_ack_fasteoi_irq+0x1c/0x20 seemed unsuccessful.  I wasn't
really expecting it to work there.  Going to try a pr_alert instead...

[    2.485100] irq chip has NULL irq_hold function pointer
[    2.495581] irq chip (name=CBAR)
[    2.502054] Unable to handle kernel NULL pointer dereference at virtual address 00000000

OK, seems to be this one:
drivers/irqchip/irq-crossbar.c: .name                   = "CBAR",

Makes sense, since that is certainly part of this CPU.

Same hardware is running 3.14 OK, but clearly something is missing in 4.1.

Comparing the irq-crossbar.c between 3.14 and 4.1, it looks like in 4.1
it is defined as an irq_chip, while in 3.14 it was not, unless I am
misreading the code.  Hmm.

-- 
Len Sorensen

