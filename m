Date: Mon, 1 Mar 2021 17:41:21 +0300
From: Vladimir Petrigo <vladimir.petrigo@gmail.com>
Subject: ATSAMA5D4 Xplained freeze with Xenomai kernel
Message-ID: <YDz9EZBErETAB9mZ@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org


Hello,

I met an issue with running Linux Kernel 4.19.144 with Xenomai 3.1 on
ATSAMA5D4 Xplained board.

Preliminary:
- non-patched Linux kernel 4.19.144 works just fine
- I-pipe patched kernel can successfully boot
- when I insert an ethernet cable into the on-board ethernet port, the
  kernel freezes and the reset is the only solution to get out of that
  state. Without the ethernet cable inserted the kernel will work
  indefinitely long trying to reach the network and obtain an IP address.
  So I assume something may be wrong with Micrel KSZ8081 driver under
  Xenomai

Here is the boot log:

[    0.000000 ] Booting Linux on physical CPU 0x0
[    0.000000 ] Linux version 4.19.144 (vpetrigo@localhost.localdomain) (gcc version 7.3.1 20180425 [linaro-7.3-2018.05 revision d29120a424ecfbc167ef90065c0eeb7f91977701] (Linaro GCC 7.3-2018.05)) #6 Sun Feb 28 07:27:15 MSK 2021
[    0.000000 ] CPU: ARMv7 Processor [410fc051] revision 1 (ARMv7), cr=10c53c7d
[    0.000000 ] CPU: PIPT / VIPT nonaliasing data cache, VIPT aliasing instruction cache
[    0.000000 ] OF: fdt: Machine model: Atmel SAMA5D4 Xplained
[    0.000000 ] Memory policy: Data cache writeback
[    0.000000 ] CPU: All CPU(s) started in SVC mode.
[    0.000000 ] random: get_random_bytes called from start_kernel+0x94/0x488 with crng_init=0
[    0.000000 ] Built 1 zonelists, mobility grouping on.  Total pages: 130048
[    0.000000 ] Kernel command line: console=ttyS0,115200 root=/dev/nfs ip=dhcp nfsroot=10.24.1.163:/home/user/nfsroot_xenomai,nfsvers=3 rw
[    0.000000 ] Dentry cache hash table entries: 65536 (order: 6, 262144 bytes)
[    0.000000 ] Inode-cache hash table entries: 32768 (order: 5, 131072 bytes)
[    0.000000 ] Memory: 498560K/524288K available (7168K kernel code, 1957K rwdata, 2404K rodata, 1024K init, 7808K bss, 25728K reserved, 0K cma-reserved)
[    0.000000 ] Virtual kernel memory layout:
[    0.000000 ]     vector  : 0xffff0000 - 0xffff1000   (   4 kB )
[    0.000000 ]     fixmap  : 0xffc00000 - 0xfff00000   (3072 kB)
[    0.000000 ]     vmalloc : 0xe0800000 - 0xff800000   ( 496 MB )
[    0.000000 ]     lowmem  : 0xc0000000 - 0xe0000000   ( 512 MB )
[    0.000000 ]     modules : 0xbf000000 - 0xc0000000   (  16 MB )
[    0.000000 ]       .text : 0x(ptrval) - 0x(ptrval)   (8160 kB)
[    0.000000 ]       .init : 0x(ptrval) - 0x(ptrval)   (1024 kB)
[    0.000000 ]       .data : 0x(ptrval) - 0x(ptrval)   (1958 kB)
[    0.000000 ]        .bss : 0x(ptrval) - 0x(ptrval)   (7809 kB)
[    0.000000 ] NR_IRQS: 16, nr_irqs: 16, preallocated irqs: 16
[    0.000000 ] L2C: I-pipe: revision >= L310-r3p2 detected, forcing WA.
[    0.000000 ] L2C: I-pipe: write-allocate enabled, induces high latencies.
[    0.000000 ] L2C-310 ID prefetch enabled, offset 2 lines
[    0.000000 ] L2C-310 dynamic clock gating enabled, standby mode enabled
[    0.000000 ] L2C-310 cache controller enabled, 8 ways, 128 kB
[    0.000000 ] L2C-310: CACHE_ID 0x410000c9, AUX_CTRL 0x36020000
[    0.000000 ] clocksource: timer@fc024000: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 152900835740 ns
[    0.000025 ] sched_clock: 32 bits at 12MHz, resolution 80ns, wraps every 171798691800ns
[    0.000098 ] I-pipe, 12.500 MHz clocksource, wrap in 343597 ms
[    0.000171 ] clocksource: ipipe_tsc: mask: 0xffffffffffffffff max_cycles: 0x2e2049cda, max_idle_ns: 440795202628 ns
[    0.000627 ] Interrupt pipeline (release #10)
[    0.002773 ] console [rawcon-1] enabled
[    0.003252 ] Console: colour dummy device 80x30
[    0.003373 ] Lock dependency validator: Copyright (c) 2006 Red Hat, Inc., Ingo Molnar
[    0.003433 ] ... MAX_LOCKDEP_SUBCLASSES:  8
[    0.003489 ] ... MAX_LOCK_DEPTH:          48
[    0.003544 ] ... MAX_LOCKDEP_KEYS:        8191
[    0.003599 ] ... CLASSHASH_SIZE:          4096
[    0.003654 ] ... MAX_LOCKDEP_ENTRIES:     32768
[    0.003708 ] ... MAX_LOCKDEP_CHAINS:      65536
[    0.003762 ] ... CHAINHASH_SIZE:          32768
[    0.003818 ]  memory used by lock dependency info: 4911 kB
[    0.003873 ]  per task-struct memory footprint: 2304 bytes
[    0.003928 ] ------------------------
[    0.003981 ] | Locking API testsuite:
[    0.004036 ] ----------------------------------------------------------------------------
[    0.004092 ]                                  | spin |wlock |rlock |mutex | wsem | rsem |
[    0.004146 ]   --------------------------------------------------------------------------
[    0.004227 ]                      A-A deadlock:  ok  |  ok  |  ok  |  ok  |  ok  |  ok  |  ok  |
[    0.030501 ]                  A-B-B-A deadlock:  ok  |  ok  |  ok  |  ok  |  ok  |  ok  |  ok  |
[    0.056917 ]              A-B-B-C-C-A deadlock:  ok  |  ok  |  ok  |  ok  |  ok  |  ok  |  ok  |
[    0.084175 ]              A-B-C-A-B-C deadlock:  ok  |  ok  |  ok  |  ok  |  ok  |  ok  |  ok  |
[    0.111455 ]          A-B-B-C-C-D-D-A deadlock:  ok  |  ok  |  ok  |  ok  |  ok  |  ok  |  ok  |
[    0.139317 ]          A-B-C-D-B-D-D-A deadlock:  ok  |  ok  |  ok  |  ok  |  ok  |  ok  |  ok  |
[    0.167367 ]          A-B-C-D-B-C-D-A deadlock:  ok  |  ok  |  ok  |  ok  |  ok  |  ok  |  ok  |
[    0.195545 ]                     double unlock:  ok  |  ok  |  ok  |  ok  |  ok  |  ok  |  ok  |
[    0.221539 ]                   initialize held:  ok  |  ok  |  ok  |  ok  |  ok  |  ok  |  ok  |
[    0.247217 ]   --------------------------------------------------------------------------
[    0.247280 ]               recursive read-lock:             |  ok  |             |  ok  |
[    0.254871 ]            recursive read-lock #2:             |  ok  |             |  ok  |
[    0.262417 ]             mixed read-write-lock:             |  ok  |             |  ok  |
[    0.269870 ]             mixed write-read-lock:             |  ok  |             |  ok  |
[    0.277482 ]   mixed read-lock/lock-write ABBA:             |FAILED|             |  ok  |
[    0.285245 ]    mixed read-lock/lock-read ABBA:             |  ok  |             |  ok  |
[    0.292993 ]  mixed write-lock/lock-write ABBA:             |  ok  |             |  ok  |
[    0.300789 ]   --------------------------------------------------------------------------
[    0.300909 ]      hard-irqs-on + irq-safe-A/12:  ok  |  ok  |  ok  |
[    0.312104 ]      soft-irqs-on + irq-safe-A/12:  ok  |  ok  |  ok  |
[    0.323324 ]      hard-irqs-on + irq-safe-A/21:  ok  |  ok  |  ok  |
[    0.334565 ]      soft-irqs-on + irq-safe-A/21:  ok  |  ok  |  ok  |
[    0.345788 ]        sirq-safe-A => hirqs-on/12:  ok  |  ok  |  ok  |
[    0.357017 ]        sirq-safe-A => hirqs-on/21:  ok  |  ok  |  ok  |
[    0.368254 ]          hard-safe-A + irqs-on/12:  ok  |  ok  |  ok  |
[    0.379449 ]          soft-safe-A + irqs-on/12:  ok  |  ok  |  ok  |
[    0.390842 ]          hard-safe-A + irqs-on/21:  ok  |  ok  |  ok  |
[    0.402048 ]          soft-safe-A + irqs-on/21:  ok  |  ok  |  ok  |
[    0.413277 ]     hard-safe-A + unsafe-B #1/123:  ok  |  ok  |  ok  |
[    0.424797 ]     soft-safe-A + unsafe-B #1/123:  ok  |  ok  |  ok  |
[    0.436310 ]     hard-safe-A + unsafe-B #1/132:  ok  |  ok  |  ok  |
[    0.447804 ]     soft-safe-A + unsafe-B #1/132:  ok  |  ok  |  ok  |
[    0.459297 ]     hard-safe-A + unsafe-B #1/213:  ok  |  ok  |  ok  |
[    0.470949 ]     soft-safe-A + unsafe-B #1/213:  ok  |  ok  |  ok  |
[    0.482470 ]     hard-safe-A + unsafe-B #1/231:  ok  |  ok  |  ok  |
[    0.493936 ]     soft-safe-A + unsafe-B #1/231:  ok  |  ok  |  ok  |
[    0.505431 ]     hard-safe-A + unsafe-B #1/312:  ok  |  ok  |  ok  |
[    0.516720 ]     soft-safe-A + unsafe-B #1/312:  ok  |  ok  |  ok  |
[    0.528051 ]     hard-safe-A + unsafe-B #1/321:  ok  |  ok  |  ok  |
[    0.539497 ]     soft-safe-A + unsafe-B #1/321:  ok  |  ok  |  ok  |
[    0.551125 ]     hard-safe-A + unsafe-B #2/123:  ok  |  ok  |  ok  |
[    0.562559 ]     soft-safe-A + unsafe-B #2/123:  ok  |  ok  |  ok  |
[    0.574098 ]     hard-safe-A + unsafe-B #2/132:  ok  |  ok  |  ok  |
[    0.585509 ]     soft-safe-A + unsafe-B #2/132:  ok  |  ok  |  ok  |
[    0.597028 ]     hard-safe-A + unsafe-B #2/213:  ok  |  ok  |  ok  |
[    0.608483 ]     soft-safe-A + unsafe-B #2/213:  ok  |  ok  |  ok  |
[    0.620143 ]     hard-safe-A + unsafe-B #2/231:  ok  |  ok  |  ok  |
[    0.631548 ]     soft-safe-A + unsafe-B #2/231:  ok  |  ok  |  ok  |
[    0.643026 ]     hard-safe-A + unsafe-B #2/312:  ok  |  ok  |  ok  |
[    0.654479 ]     soft-safe-A + unsafe-B #2/312:  ok  |  ok  |  ok  |
[    0.666010 ]     hard-safe-A + unsafe-B #2/321:  ok  |  ok  |  ok  |
[    0.677443 ]     soft-safe-A + unsafe-B #2/321:  ok  |  ok  |  ok  |
[    0.688935 ]       hard-irq lock-inversion/123:  ok  |  ok  |  ok  |
[    0.700545 ]       soft-irq lock-inversion/123:  ok  |  ok  |  ok  |
[    0.712073 ]       hard-irq lock-inversion/132:  ok  |  ok  |  ok  |
[    0.723503 ]       soft-irq lock-inversion/132:  ok  |  ok  |  ok  |
[    0.735070 ]       hard-irq lock-inversion/213:  ok  |  ok  |  ok  |
[    0.746557 ]       soft-irq lock-inversion/213:  ok  |  ok  |  ok  |
[    0.758105 ]       hard-irq lock-inversion/231:  ok  |  ok  |  ok  |
[    0.769555 ]       soft-irq lock-inversion/231:  ok  |  ok  |  ok  |
[    0.781215 ]       hard-irq lock-inversion/312:  ok  |  ok  |  ok  |
[    0.792655 ]       soft-irq lock-inversion/312:  ok  |  ok  |  ok  |
[    0.804238 ]       hard-irq lock-inversion/321:  ok  |  ok  |  ok  |
[    0.815691 ]       soft-irq lock-inversion/321:  ok  |  ok  |  ok  |
[    0.827212 ]       hard-irq read-recursion/123:  ok  |
[    0.831217 ]       soft-irq read-recursion/123:  ok  |
[    0.835119 ]       hard-irq read-recursion/132:  ok  |
[    0.838973 ]       soft-irq read-recursion/132:  ok  |
[    0.843002 ]       hard-irq read-recursion/213:  ok  |
[    0.846878 ]       soft-irq read-recursion/213:  ok  |
[    0.850910 ]       hard-irq read-recursion/231:  ok  |
[    0.854788 ]       soft-irq read-recursion/231:  ok  |
[    0.858666 ]       hard-irq read-recursion/312:  ok  |
[    0.862667 ]       soft-irq read-recursion/312:  ok  |
[    0.866570 ]       hard-irq read-recursion/321:  ok  |
[    0.870572 ]       soft-irq read-recursion/321:  ok  |
[    0.874467 ]   --------------------------------------------------------------------------
[    0.874526 ]   | Wound/wait tests |
[    0.874581 ]   ---------------------
[    0.874636 ]                   ww api failures:  ok  |  ok  |  ok  |
[    0.886288 ]                ww contexts mixing:  ok  |  ok  |
[    0.893957 ]              finishing ww context:  ok  |  ok  |  ok  |  ok  |
[    0.908956 ]                locking mismatches:  ok  |  ok  |  ok  |
[    0.920501 ]                  EDEADLK handling:  ok  |  ok  |  ok  |  ok  |  ok  |  ok  |  ok  |  ok  |  ok  |  ok  |
[    0.959308 ]            spinlock nest unlocked:  ok  |
[    0.963226 ]   -----------------------------------------------------
[    0.963284 ]                                  |block | try  |context|
[    0.963340 ]   -----------------------------------------------------
[    0.963397 ]                           context:  ok  |  ok  |  ok  |
[    0.975060 ]                               try:  ok  |  ok  |  ok  |
[    0.986408 ]                             block:  ok  |  ok  |  ok  |
[    0.997801 ]                          spinlock:  ok  |  ok  |  ok  |
[    1.009546 ] -------------------------------------------------------
[    1.009607 ] Good, all 261 testcases passed! |
[    1.009661 ] ---------------------------------
[    1.009833 ] Calibrating delay loop... 395.67 BogoMIPS (lpj=1978368)
[    1.060146 ] pid_max: default: 32768 minimum: 301
[    1.061258 ] Mount-cache hash table entries: 1024 (order: 0, 4096 bytes)
[    1.061351 ] Mountpoint-cache hash table entries: 1024 (order: 0, 4096 bytes)
[    1.067206 ] CPU: Testing write buffer coherency: ok
[    1.073824 ] Setting up static identity map for 0x20100000 - 0x20100060
[    1.082477 ] devtmpfs: initialized
[    1.179711 ] VFP support v0.3: implementor 41 architecture 2 part 30 variant 5 rev 1
[    1.181846 ] clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 19112604462750000 ns
[    1.182029 ] futex hash table entries: 256 (order: 1, 13312 bytes)
[    1.183030 ] pinctrl core: initialized pinctrl subsystem
[    1.206526 ] NET: Registered protocol family 16
[    1.209115 ] DMA: preallocated 256 KiB pool for atomic coherent allocations
[    1.333722 ] AT91: PM: standby: standby, suspend: ulp0
[    1.333809 ] No ATAGs?
[    1.396433 ] gpio-at91 fc06a000.gpio: at address (ptrval)
[    1.404459 ] gpio-at91 fc06b000.gpio: at address (ptrval)
[    1.412867 ] gpio-at91 fc06c000.gpio: at address (ptrval)
[    1.420940 ] gpio-at91 fc068000.gpio: at address (ptrval)
[    1.428819 ] gpio-at91 fc06d000.gpio: at address (ptrval)
[    1.439623 ] pinctrl-at91 ahb:apb:pinctrl@fc06a000: initialized AT91 pinctrl driver
[    1.704025 ] at_xdmac f0004000.dma-controller: 16 channels, mapped at 0x(ptrval)
[    1.718712 ] at_xdmac f0014000.dma-controller: 16 channels, mapped at 0x(ptrval)
[    1.721621 ] AT91: Detected SoC family: sama5d4
[    1.721704 ] AT91: Detected SoC: sama5d44, revision 0
[    1.726407 ] VDD MCI1: supplied by VCC 3V3
[    1.732481 ] SCSI subsystem initialized
[    1.735296 ] usbcore: registered new interface driver usbfs
[    1.736049 ] usbcore: registered new interface driver hub
[    1.736561 ] usbcore: registered new device driver usb
[    1.741715 ] at91_i2c f8014000.i2c: using dma0chan0 (tx) and dma0chan1 (rx) for DMA transfers
[    1.744267 ] at91_i2c f8014000.i2c: AT91 i2c bus driver (hw version: 0x502).
[    1.746533 ] videodev: Linux video capture interface: v2.00
[    1.746981 ] pps_core: LinuxPPS API ver. 1 registered
[    1.747048 ] pps_core: Software ver. 5.3.6 - Copyright 2005-2007 Rodolfo Giometti <giometti@linux.it>
[    1.747288 ] PTP clock support registered
[    1.750240 ] Advanced Linux Sound Architecture Driver Initialized.
[    1.840365 ] clocksource: Switched to clocksource ipipe_tsc
[    2.574436 ] NET: Registered protocol family 2
[    2.578276 ] tcp_listen_portaddr_hash hash table entries: 256 (order: 1, 12288 bytes)
[    2.578494 ] TCP established hash table entries: 4096 (order: 2, 16384 bytes)
[    2.578700 ] TCP bind hash table entries: 4096 (order: 5, 180224 bytes)
[    2.580220 ] TCP: Hash tables configured (established 4096 bind 4096)
[    2.581477 ] UDP hash table entries: 256 (order: 2, 24576 bytes)
[    2.581815 ] UDP-Lite hash table entries: 256 (order: 2, 24576 bytes)
[    2.583098 ] NET: Registered protocol family 1
[    2.591094 ] RPC: Registered named UNIX socket transport module.
[    2.591298 ] RPC: Registered udp transport module.
[    2.591371 ] RPC: Registered tcp transport module.
[    2.591439 ] RPC: Registered tcp NFSv4.1 backchannel transport module.
[    2.602326 ] [Xenomai] scheduling class idle registered.
[    2.602406 ] [Xenomai] scheduling class rt registered.
[    2.603891 ] I-pipe: head domain Xenomai registered.
[    2.638900 ] [Xenomai] Cobalt v3.1 [DEBUG]
[    2.638984 ] Initialise system trusted keyrings
[    2.641641 ] workingset: timestamp_bits=30 max_order=17 bucket_order=0
[    2.687431 ] Key type asymmetric registered
[    2.687813 ] Asymmetric key parser 'x509' registered
[    2.688226 ] io scheduler noop registered (default)
[    2.688308 ] io scheduler mq-deadline registered
[    2.688376 ] io scheduler kyber registered
[    2.731441 ] f8004000.serial: ttyS5 at MMIO 0xf8004000 (irq = 23, base_baud = 6250000) is a ATMEL_SERIAL
[    2.739919 ] fc00c000.serial: ttyS0 at MMIO 0xfc00c000 (irq = 29, base_baud = 6250000) is a ATMEL_SERIAL
[    3.756264 ] random: fast init done
[    4.064725 ] console [ttyS0] enabled
[    4.073147 ] fc010000.serial: ttyS1 at MMIO 0xfc010000 (irq = 30, base_baud = 6250000) is a ATMEL_SERIAL
[    4.143473 ] brd: module loaded
[    4.256253 ] loop: module loaded
[    4.273495 ] atmel_spi f8010000.spi: Using dma0chan2 (tx) and dma0chan3 (rx) for DMA transfers
[    4.309313 ] m25p80 spi0.0: unrecognized JEDEC id bytes: 00, 00, 00
[    4.316754 ] atmel_spi f8010000.spi: Atmel SPI Controller version 0x221 at 0xf8010000 (irq 24)
[    4.328335 ] atmel_spi fc018000.spi: Using dma0chan4 (tx) and dma0chan5 (rx) for DMA transfers
[    4.343044 ] atmel_spi fc018000.spi: Atmel SPI Controller version 0x221 at 0xfc018000 (irq 31)
[    4.356675 ] libphy: Fixed MDIO Bus: probed
[    4.369182 ] libphy: MACB_mii_bus: probed
[    4.399395 ] ------------[ cut here  ]------------
[    4.404217 ] WARNING: CPU: 0 PID: 1 at kernel/irq/chip.c:55 irq_set_chip+0xbc/0xcc
[    4.411649 ] irqchip GPIO is not pipeline-safe!
[    4.411660 ] Modules linked in:
[    4.419088 ] CPU: 0 PID: 1 Comm: swapper Not tainted 4.19.144 #6
[    4.424953 ] Hardware name: Atmel SAMA5
[    4.428667 ] I-pipe domain: Linux
[    4.431893 ] [<c010f200>] (unwind_backtrace) from [<c010c5a4>] (show_stack+0x10/0x14)
[    4.439597 ] [<c010c5a4>] (show_stack) from [<c011b3cc>] (__warn+0xf4/0x10c)
[    4.446515 ] [<c011b3cc>] (__warn) from [<c011b42c>] (warn_slowpath_fmt+0x48/0x6c)
[    4.453949 ] [<c011b42c>] (warn_slowpath_fmt) from [<c0169a60>] (irq_set_chip+0xbc/0xcc)
[    4.461908 ] [<c0169a60>] (irq_set_chip) from [<c016aae0>] (irq_set_chip_and_handler_name+0x14/0x2c)
[    4.470910 ] [<c016aae0>] (irq_set_chip_and_handler_name) from [<c0433700>] (gpiochip_irq_map+0x8c/0x130)
[    4.480340 ] [<c0433700>] (gpiochip_irq_map) from [<c016ceb4>] (irq_domain_associate+0x74/0x1ec)
[    4.488996 ] [<c016ceb4>] (irq_domain_associate) from [<c016d6fc>] (irq_create_mapping+0x64/0xc8)
[    4.497731 ] [<c016d6fc>] (irq_create_mapping) from [<c016d8e4>] (irq_create_fwspec_mapping+0x184/0x2c4)
[    4.507070 ] [<c016d8e4>] (irq_create_fwspec_mapping) from [<c016da80>] (irq_create_of_mapping+0x5c/0x78)
[    4.516497 ] [<c016da80>] (irq_create_of_mapping) from [<c0630ca4>] (of_irq_get+0x6c/0xb8)
[    4.524622 ] [<c0630ca4>] (of_irq_get) from [<c06313f8>] (of_mdiobus_register_phy+0x84/0x17c)
[    4.533011 ] [<c06313f8>] (of_mdiobus_register_phy) from [<c06319b8>] (of_mdiobus_register+0xf4/0x304)
[    4.542182 ] [<c06319b8>] (of_mdiobus_register) from [<c0564478>] (macb_probe+0x72c/0xad0)
[    4.550315 ] [<c0564478>] (macb_probe) from [<c04e17e4>] (platform_drv_probe+0x48/0x98)
[    4.558192 ] [<c04e17e4>] (platform_drv_probe) from [<c04df934>] (really_probe+0x1d8/0x2c0)
[    4.566406 ] [<c04df934>] (really_probe) from [<c04dfb80>] (driver_probe_device+0x60/0x160)
[    4.574622 ] [<c04dfb80>] (driver_probe_device) from [<c04dfd68>] (__driver_attach+0xe8/0xec)
[    4.583010 ] [<c04dfd68>] (__driver_attach) from [<c04ddbe4>] (bus_for_each_dev+0x74/0xb4)
[    4.591141 ] [<c04ddbe4>] (bus_for_each_dev) from [<c04ded6c>] (bus_add_driver+0x18c/0x210)
[    4.599358 ] [<c04ded6c>] (bus_add_driver) from [<c04e0948>] (driver_register+0x7c/0x114)
[    4.607405 ] [<c04e0948>] (driver_register) from [<c0102e94>] (do_one_initcall+0x88/0x22c)
[    4.615538 ] [<c0102e94>] (do_one_initcall) from [<c0b010ac>] (kernel_init_freeable+0x26c/0x304)
[    4.624188 ] [<c0b010ac>] (kernel_init_freeable) from [<c07b87ac>] (kernel_init+0x8/0x108)
[    4.632321 ] [<c07b87ac>] (kernel_init) from [<c01010e8>] (ret_from_fork+0x18/0x24)
[    4.639832 ] Exception stack(0xdf48dfb0 to 0xdf48dff8)
[    4.644852 ] dfa0:                                     00000000 00000000 00000000 00000000
[    4.652978 ] dfc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
[    4.661096 ] dfe0: 00000000 00000000 00000000 00000000 00000013 00000000
[    4.667652 ] irq event stamp: 145160
[    4.671121 ] hardirqs last  enabled at (145159): [<c07c01cc>] _raw_spin_unlock_irqrestore+0x30/0x58
[    4.680024 ] hardirqs last disabled at (145160): [<c07c0018>] _raw_spin_lock_irqsave+0x1c/0x98
[    4.688491 ] softirqs last  enabled at (145050): [<c01026ac>] __do_softirq+0x2a4/0x420
[    4.696267 ] softirqs last disabled at (145041): [<c011fb80>] irq_exit+0x1a4/0x1a8
[    4.703786 ] ---[ end trace 56205b4a18caa7d4  ]---
[    4.819300 ] Micrel KSZ8081 or KSZ8091 f8020000.ethernet-ffffffff:01: attached PHY driver [Micrel KSZ8081 or KSZ8091] (mii_bus:phy_addr=f8020000.ethernet-ffffffff:01, irq=46)
[    4.834944 ] macb f8020000.ethernet eth0: Cadence GEM rev 0x00020120 at 0xf8020000 irq 27 (fc:c2:3d:0c:65:90)
[    4.846097 ] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
[    4.852778 ] ehci-atmel: EHCI Atmel driver
[    4.861644 ] atmel-ehci 600000.ehci: EHCI Host Controller
[    4.867577 ] atmel-ehci 600000.ehci: new USB bus registered, assigned bus number 1
[    4.876463 ] atmel-ehci 600000.ehci: irq 18, io mem 0x00600000
[    4.910590 ] atmel-ehci 600000.ehci: USB 2.0 started, EHCI 1.00
[    4.919898 ] usb usb1: New USB device found, idVendor=1d6b, idProduct=0002, bcdDevice= 4.19
[    4.928522 ] usb usb1: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    4.935857 ] usb usb1: Product: EHCI Host Controller
[    4.940847 ] usb usb1: Manufacturer: Linux 4.19.144 ehci_hcd
[    4.946377 ] usb usb1: SerialNumber: 600000.ehci
[    4.960887 ] hub 1-0:1.0: USB hub found
[    4.967182 ] hub 1-0:1.0: 3 ports detected
[    4.982082 ] ohci_hcd: USB 1.1 'Open' Host Controller (OHCI) Driver
[    4.988376 ] ohci-atmel: OHCI Atmel driver
[    4.995613 ] at91_ohci 500000.ohci: USB Host Controller
[    5.001142 ] at91_ohci 500000.ohci: new USB bus registered, assigned bus number 2
[    5.009408 ] at91_ohci 500000.ohci: irq 18, io mem 0x00500000
[    5.091134 ] usb usb2: New USB device found, idVendor=1d6b, idProduct=0001, bcdDevice= 4.19
[    5.099363 ] usb usb2: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    5.106711 ] usb usb2: Product: USB Host Controller
[    5.111612 ] usb usb2: Manufacturer: Linux 4.19.144 ohci_hcd
[    5.117146 ] usb usb2: SerialNumber: at91
[    5.127252 ] hub 2-0:1.0: USB hub found
[    5.133470 ] hub 2-0:1.0: 3 ports detected
[    5.150121 ] usbcore: registered new interface driver cdc_acm
[    5.156024 ] cdc_acm: USB Abstract Control Model driver for USB modems and ISDN adapters
[    5.164776 ] usbcore: registered new interface driver usb-storage
[    5.171788 ] usbcore: registered new interface driver usbserial_generic
[    5.179229 ] usbserial: USB Serial support registered for generic
[    5.185995 ] usbcore: registered new interface driver ftdi_sio
[    5.192157 ] usbserial: USB Serial support registered for FTDI USB Serial Device
[    5.199977 ] usbcore: registered new interface driver pl2303
[    5.205993 ] usbserial: USB Serial support registered for pl2303
[    5.215163 ] atmel_usba_udc 400000.gadget: MMIO registers at [mem 0xfc02c000-0xfc02ffff] mapped at (ptrval)
[    5.225147 ] atmel_usba_udc 400000.gadget: FIFO at [mem 0x00400000-0x004fffff] mapped at (ptrval)
[    5.265577 ] g_serial gadget: Gadget Serial v2.4
[    5.270268 ] g_serial gadget: g_serial ready
[    5.285798 ] at91_rtc fc0686b0.rtc: registered as rtc0
[    5.292183 ] at91_rtc fc0686b0.rtc: AT91 Real Time Clock driver.
[    5.298694 ] i2c /dev entries driver
[    5.316626 ] at91-reset fc068600.rstc: Starting after user reset
[    5.345811 ] sama5d4_wdt fc068640.watchdog: initialized (timeout = 16 sec, nowayout = 0)
[    5.357226 ] sdhci: Secure Digital Host Controller Interface driver
[    5.363573 ] sdhci: Copyright(c) Pierre Ossman
[    5.370573 ] atmel_mci fc000000.mmc: version: 0x600
[    5.375899 ] atmel_mci fc000000.mmc: using dma0chan6 for DMA transfers
[    5.384347 ] atmel_mci fc000000.mmc: Linked as a consumer to regulator.2
[    5.392309 ] atmel_mci fc000000.mmc: Linked as a consumer to regulator.1
[    5.428632 ] atmel_mci fc000000.mmc: Atmel MCI controller at 0xfc000000 irq 28, 1 slots
[    5.437757 ] sdhci-pltfm: SDHCI platform and OF driver helper
[    5.454821 ] atmel_aes fc044000.aes: version: 0x201
[    5.484410 ] atmel_aes fc044000.aes: Atmel AES - Using dma1chan0, dma1chan1 for DMA transfers
[    5.495328 ] atmel_sha fc050000.sha: version: 0x420
[    5.500916 ] atmel_sha fc050000.sha: using dma1chan2 for DMA transfers
[    5.516378 ] atmel_sha fc050000.sha: Atmel SHA1/SHA256/SHA224/SHA384/SHA512
[    5.525735 ] atmel_tdes fc04c000.tdes: version: 0x702
[    5.532028 ] atmel_tdes fc04c000.tdes: using dma1chan3, dma1chan4 for DMA transfers
[    5.559571 ] atmel_tdes fc04c000.tdes: Atmel DES/TDES
[    5.566514 ] usbcore: registered new interface driver usbhid
[    5.572227 ] usbhid: USB HID core driver
[    5.596339 ] nand: device found, Manufacturer ID: 0x2c, Chip ID: 0xdc
[    5.602958 ] nand: Micron MT29F4G08ABAEAWP
[    5.606941 ] nand: 512 MiB, SLC, erase size: 256 KiB, page size: 4096, OOB size: 224
[    5.622318 ] Bad block table not found for chip 0
[    5.629946 ] Bad block table not found for chip 0
[    5.634709 ] Scanning device for bad blocks
[    6.108560 ] Bad block table written to 0x00001ffc0000, version 0x01
[    6.117397 ] Bad block table written to 0x00001ff80000, version 0x01
[    6.124797 ] 6 fixed-partitions partitions found on MTD device atmel_nand
[    6.131671 ] Creating 6 MTD partitions on "atmel_nand":
[    6.136838 ] 0x000000000000-0x000000040000 : "at91bootstrap"
[    6.160213 ] 0x000000040000-0x0000000c0000 : "bootloader"
[    6.180001 ] 0x0000000c0000-0x000000180000 : "bootloader env"
[    6.199980 ] 0x000000180000-0x000000200000 : "device tree"
[    6.219709 ] 0x000000200000-0x000000800000 : "kernel"
[    6.239856 ] 0x000000800000-0x000020000000 : "rootfs"
[    6.336391 ] iio iio:device0: Resolution used: 10 bits
[    6.341881 ] iio iio:device0: ADC Touch screen is disabled.
[    6.396804 ] NET: Registered protocol family 10
[    6.418370 ] Segment Routing with IPv6
[    6.422610 ] sit: IPv6, IPv4 and MPLS over IPv4 tunneling driver
[    6.434188 ] NET: Registered protocol family 17
[    6.452130 ] Loading compiled-in X.509 certificates
[    6.565366 ] input: gpio_keys as /devices/platform/gpio_keys/input/input0
[    6.581088 ] at91_rtc fc0686b0.rtc: setting system clock to 2012-01-02 07:59:53 UTC (1325491193)
[    6.600987 ] IPv6: ADDRCONF(NETDEV_UP): eth0: link is not ready
[   16.620548 ] Waiting up to 110 more seconds for network.

One of Bootlin's courses has ATSAMA5D3 Xplained board with mentions that
4.19.144 kernel with I-pipe patch should work fine. So I am wondering why
it may get stuck on ATSAMA5D4 Xplained since SAMA5D3 and SAMA5D4 is the
same family.

Any suggestions on how to narrow the root case of that freeze will be
greatly appreciated.

Best regards,
Vladimir Petrigo

