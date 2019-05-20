From: Jan Leupold <leupold@rsi-elektrotechnik.de>
Subject: SAMA5D2 Xplained kernel panic
Message-ID: <cca1a283-5dae-8c91-568d-3abf641fbfdc@rsi-elektrotechnik.de>
Date: Mon, 20 May 2019 12:27:03 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Language: de-DE
Content-Transfer-Encoding: 8bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Hi all,

I am trying to boot Linux on a SAMA5D2 Xplained board with
* Kernel ipipe-arm branch stable/4.14.96-arm
  (HEAD plus my modifications)
* Xenomai-3 on tag v3.0.8
* following instructions on
https://gitlab.denx.de/Xenomai/xenomai/wikis/Porting_Xenomai_To_A_New_Arm_Soc

On most kernel boots I get a kernel panic. Can anyone point me in the right
direction where to look for my bugs? I added code for
* the hardware timer (tcb_clksrc.c)
* the high resolution counter (tcb_clksrc.c)
* GPIOs as interrupt sources (pinctrl-at91-pio4.c)
* checked interrupt controller (irq-atmel-aic5.c)
* added "select IPIPE_ARM_KUSER_TSC" for SOC_SAMA5D2

I have no idea if there is only one problem (causing all the other
warnings), or if these are separate problems, that can be handeled
independently.

Regards,
Jan

Uncompressing Linux... done, booting the kernel.
Booting Linux on physical CPU 0x0
Linux version 4.14.96+ (jan@yoda) (gcc version 8.3.0 (GCC)) #46 Mon May 20
11:51:40 CEST 2019
CPU: ARMv7 Processor [410fc051] revision 1 (ARMv7), cr=10c53c7d
CPU: PIPT / VIPT nonaliasing data cache, VIPT aliasing instruction cache
OF: fdt: Machine model: Atmel SAMA5D2 Xplained
bootconsole [earlycon0] enabled
Memory policy: Data cache writeback
CPU: All CPU(s) started in SVC mode.
Built 1 zonelists, mobility grouping on.  Total pages: 130048
Kernel command line: console=ttyS0,115200 earlyprintk ip=dhcp root=/dev/nfs
nfsroot=172.16.1.4:/srv/sama5d2_xplained_rootfs ro ubi.fm_autoconvert=1
PID hash table entries: 2048 (order: 1, 8192 bytes)
Dentry cache hash table entries: 65536 (order: 6, 262144 bytes)
Inode-cache hash table entries: 32768 (order: 5, 131072 bytes)
Memory: 507468K/524288K available (7168K kernel code, 536K rwdata, 1736K
rodata, 1024K init, 288K bss, 16820K reserved, 0K cma-reserved)
Virtual kernel memory layout:
    vector  : 0xffff0000 - 0xffff1000   (   4 kB)
    fixmap  : 0xffc00000 - 0xfff00000   (3072 kB)
    vmalloc : 0xe0800000 - 0xff800000   ( 496 MB)
    lowmem  : 0xc0000000 - 0xe0000000   ( 512 MB)
    modules : 0xbf000000 - 0xc0000000   (  16 MB)
      .text : 0xc0008000 - 0xc0800000   (8160 kB)
      .init : 0xc0b00000 - 0xc0c00000   (1024 kB)
      .data : 0xc0c00000 - 0xc0c863c8   ( 537 kB)
       .bss : 0xc0c8b750 - 0xc0cd39d4   ( 289 kB)
NR_IRQS: 16, nr_irqs: 16, preallocated irqs: 16
L2C: I-pipe: revision >= L310-r3p2 detected, forcing WA.
L2C: I-pipe: write-allocate enabled, induces high latencies.
L2C-310 dynamic clock gating enabled, standby mode enabled
L2C-310 cache controller enabled, 8 ways, 128 kB
L2C-310: CACHE_ID 0x410000c9, AUX_CTRL 0x06020000
clocksource: pit: mask: 0x7ffffff max_cycles: 0x7ffffff, max_idle_ns:
11513617062 ns
Interrupt pipeline (release #6)
sched_clock: 32 bits at 100 Hz, resolution 10000000ns, wraps every
21474836475000000ns
console [rawcon-1] enabled
Console: colour dummy device 80x30
Calibrating delay loop... 329.31 BogoMIPS (lpj=1646592)
pid_max: default: 32768 minimum: 301
Mount-cache hash table entries: 1024 (order: 0, 4096 bytes)
Mountpoint-cache hash table entries: 1024 (order: 0, 4096 bytes)
CPU: Testing write buffer coherency: ok
Setting up static identity map for 0x20100000 - 0x20100060
devtmpfs: initialized
random: get_random_u32 called from bucket_table_alloc+0x8c/0x1b0 with
crng_init=0
VFP support v0.3: implementor 41 architecture 2 part 30 variant 5 rev 1
clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns:
19112604462750000 ns
futex hash table entries: 256 (order: -1, 3072 bytes)
pinctrl core: initialized pinctrl subsystem
NET: Registered protocol family 16
DMA: preallocated 256 KiB pool for atomic coherent allocations
AT91: PM: standby: standby, suspend: ulp0
No ATAGs?
clocksource: tcb_clksrc: mask: 0xffffffff max_cycles: 0xffffffff,
max_idle_ns: 184217874325 ns
I-pipe, 10.375 MHz clocksource, wrap in 413972 ms
clocksource: ipipe_tsc: mask: 0xffffffffffffffff max_cycles: 0x2648e118c,
max_idle_ns: 440795202452 ns
at_xdmac f0010000.dma-controller: 16 channels, mapped at 0xe0a09000
at_xdmac f0004000.dma-controller: 16 channels, mapped at 0xe0a0b000
AT91: Detected SoC family: sama5d2
AT91: Detected SoC: sama5d27, revision 2
SCSI subsystem initialized
usbcore: registered new interface driver usbfs
usbcore: registered new interface driver hub
usbcore: registered new device driver usb
at91_i2c f8028000.i2c: could not find pctldev for node
/ahb/apb/pinctrl@fc038000/i2c0_default, deferring probe
at91_i2c fc028000.i2c: could not find pctldev for node
/ahb/apb/pinctrl@fc038000/i2c1_default, deferring probe
Linux video capture interface: v2.00
pps_core: LinuxPPS API ver. 1 registered
pps_core: Software ver. 5.3.6 - Copyright 2005-2007 Rodolfo Giometti
<giometti@linux.it>
PTP clock support registered
Advanced Linux Sound Architecture Driver Initialized.
clocksource: Switched to clocksource ipipe_tsc
NET: Registered protocol family 2
TCP established hash table entries: 4096 (order: 2, 16384 bytes)
TCP bind hash table entries: 4096 (order: 2, 16384 bytes)
TCP: Hash tables configured (established 4096 bind 4096)
UDP hash table entries: 256 (order: 0, 4096 bytes)
UDP-Lite hash table entries: 256 (order: 0, 4096 bytes)
NET: Registered protocol family 1
RPC: Registered named UNIX socket transport module.
RPC: Registered udp transport module.
RPC: Registered tcp transport module.
RPC: Registered tcp NFSv4.1 backchannel transport module.
[Xenomai] scheduling class idle registered.
[Xenomai] scheduling class rt registered.
I-pipe: head domain Xenomai registered.
[Xenomai] Cobalt v3.0.8 [LTRACE]
workingset: timestamp_bits=30 max_order=17 bucket_order=0
io scheduler noop registered (default)
io scheduler mq-deadline registered
io scheduler kyber registered
pinctrl-at91-pio4 fc038000.pinctrl: atmel pinctrl initialized
console [ttyS0] enabled
console [ttyS0] enabled
bootconsole [earlycon0] disabled
bootconsole [earlycon0] disabled
fc008000.serial: ttyS1 at MMIO 0xfc008000 (irq = 42, base_baud = 5187500)
is a ATMEL_SERIAL
brd: module loaded
loop: module loaded
at91_i2c fc018600.i2c: can't get DMA channel, continue without DMA support
at91_i2c fc018600.i2c: Using FIFO (16 data)
at91_i2c fc018600.i2c: AT91 i2c bus driver (hw version: 0x704).
atmel_spi f8000000.spi: Using dma0chan0 (tx) and dma0chan1 (rx) for DMA
transfers
atmel_spi f8000000.spi: Using FIFO (16 data)
m25p80 spi0.0: at25df321a (4096 Kbytes)
atmel_spi f8000000.spi: Atmel SPI Controller version 0x311 at 0xf8000000
(irq 28)
libphy: Fixed MDIO Bus: probed
CAN device driver interface
m_can f8054000.can: m_can device registered (irq=40, version=31)
m_can fc050000.can: m_can device registered (irq=51, version=31)
libphy: MACB_mii_bus: probed
Micrel KSZ8081 or KSZ8091 f8008000.ethernet-ffffffff:01: attached PHY
driver [Micrel KSZ8081 or KSZ8091]
(mii_bus:phy_addr=f8008000.ethernet-ffffffff:01, irq=126)
macb f8008000.ethernet eth0: Cadence GEM rev 0x00020203 at 0xf8008000 irq
29 (fc:c2:3d:0d:69:70)
ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
ehci-atmel: EHCI Atmel driver
atmel-ehci 500000.ehci: EHCI Host Controller
atmel-ehci 500000.ehci: new USB bus registered, assigned bus number 1
atmel-ehci 500000.ehci: irq 19, io mem 0x00500000
atmel-ehci 500000.ehci: USB 2.0 started, EHCI 1.00
usb usb1: New USB device found, idVendor=1d6b, idProduct=0002
usb usb1: New USB device strings: Mfr=3, Product=2, SerialNumber=1
usb usb1: Product: EHCI Host Controller
usb usb1: Manufacturer: Linux 4.14.96+ ehci_hcd
usb usb1: SerialNumber: 500000.ehci
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 3 ports detected
ohci_hcd: USB 1.1 'Open' Host Controller (OHCI) Driver
ohci-atmel: OHCI Atmel driver
at91_ohci 400000.ohci: USB Host Controller
at91_ohci 400000.ohci: new USB bus registered, assigned bus number 2
at91_ohci 400000.ohci: irq 19, io mem 0x00400000
usb usb2: New USB device found, idVendor=1d6b, idProduct=0001
usb usb2: New USB device strings: Mfr=3, Product=2, SerialNumber=1
usb usb2: Product: USB Host Controller
usb usb2: Manufacturer: Linux 4.14.96+ ohci_hcd
usb usb2: SerialNumber: at91
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 3 ports detected
usbcore: registered new interface driver cdc_acm
cdc_acm: USB Abstract Control Model driver for USB modems and ISDN adapters
usbcore: registered new interface driver usb-storage
usbcore: registered new interface driver usbserial
usbcore: registered new interface driver usbserial_generic
usbserial: USB Serial support registered for generic
usbcore: registered new interface driver ftdi_sio
usbserial: USB Serial support registered for FTDI USB Serial Device
usbcore: registered new interface driver pl2303
random: fast init done
usbserial: USB Serial support registered for pl2303
atmel_usba_udc 300000.gadget: MMIO registers at 0xfc02c000 mapped at e0eb7000
atmel_usba_udc 300000.gadget: FIFO at 0x00300000 mapped at e1300000
g_serial gadget: Gadget Serial v2.4
g_serial gadget: g_serial ready
rtc rtc0: invalid alarm value: 1900-1-1 0:0:0
at91_rtc f80480b0.rtc: registered as rtc0
at91_rtc f80480b0.rtc: AT91 Real Time Clock driver.
i2c /dev entries driver
IR NEC protocol handler initialized
IR RC5(x/sz) protocol handler initialized
IR RC6 protocol handler initialized
IR JVC protocol handler initialized
IR Sony protocol handler initialized
IR SANYO protocol handler initialized
IR Sharp protocol handler initialized
IR MCE Keyboard/mouse protocol handler initialized
IR XMP protocol handler initialized
AT91: Starting after wakeup
sama5d4_wdt f8048040.watchdog: initialized (timeout = 16 sec, nowayout = 0)
sdhci: Secure Digital Host Controller Interface driver
sdhci: Copyright(c) Pierre Ossman
sdhci-pltfm: SDHCI platform and OF driver helper
sdhci-at91 a0000000.sdio-host: update clk mul to 39 as gck rate is 480000000 Hz
mmc0: SDHCI controller on a0000000.sdio-host [a0000000.sdio-host] using ADMA
sdhci-at91 b0000000.sdio-host: update clk mul to 39 as gck rate is 480000000 Hz
mmc1: SDHCI controller on b0000000.sdio-host [b0000000.sdio-host] using ADMA
atmel_aes f002c000.aes: version: 0x500
mmc0: error -110 whilst initialising MMC card
atmel_aes f002c000.aes: Atmel AES - Using dma0chan2, dma0chan3 for DMA
transfers
atmel_sha f0028000.sha: version: 0x510
atmel_sha f0028000.sha: using dma0chan4 for DMA transfers
atmel_sha f0028000.sha: Atmel SHA1/SHA256/SHA224/SHA384/SHA512
atmel_tdes fc044000.tdes: version: 0x703
atmel_tdes fc044000.tdes: using dma0chan5, dma0chan6 for DMA transfers
atmel_tdes fc044000.tdes: Atmel DES/TDES
usbcore: registered new interface driver usbhid
usbhid: USB HID core driver
g_serial gadget: high-speed config #2: CDC ACM config
atmel-pdmic f8018000.pdmic: atmel-pdmic-hifi <-> f8018000.pdmic mapping ok
NET: Registered protocol family 10
Segment Routing with IPv6
sit: IPv6, IPv4 and MPLS over IPv4 tunneling driver
NET: Registered protocol family 17
can: controller area network core (rev 20170425 abi 9)
NET: Registered protocol family 29
can: raw protocol (rev 20170425)
can: broadcast manager protocol (rev 20170425 t)
can: netlink gateway (rev 20170425) max_hops=1
at91_i2c f8028000.i2c: can't get DMA channel, continue without DMA support
at91_i2c f8028000.i2c: Using FIFO (16 data)
DCDC_REG1: supplied by regulator-dummy
DCDC_REG2: supplied by regulator-dummy
DCDC_REG3: supplied by regulator-dummy
LDO_REG1: supplied by regulator-dummy
LDO_REG2: supplied by regulator-dummy
LDO_REG3: supplied by regulator-dummy
VDD_LED: Bringing 600000uV into 3300000-3300000uV
LDO_REG4: supplied by regulator-dummy
VDD_SDHC_1V8: Bringing 600000uV into 1800000-1800000uV
act8945a-charger act8945a-charger: no charger of node
act8945a-charger: probe of act8945a-charger failed with error -22
at91_i2c f8028000.i2c: AT91 i2c bus driver (hw version: 0x704).
at91_i2c fc028000.i2c: can't get DMA channel, continue without DMA support
at91_i2c fc028000.i2c: Using FIFO (16 data)
at24 2-0054: 256 byte 24c02 EEPROM, writable, 16 bytes/write
at91_i2c fc028000.i2c: AT91 i2c bus driver (hw version: 0x704).
input: gpio_keys as /devices/platform/gpio_keys/input/input0
at91_rtc f80480b0.rtc: setting system clock to 2012-01-01 04:01:31 UTC
(1325390491)
IPv6: ADDRCONF(NETDEV_UP): eth0: link is not ready
------------[ cut here ]------------
WARNING: CPU: 0 PID: 0 at kernel/ipipe/core.c:624
__ipipe_set_irq_pending+0xf8/0x110
Modules linked in:
CPU: 0 PID: 0 Comm: swapper Not tainted 4.14.96+ #46
Hardware name: Atmel SAMA5
I-pipe domain: Linux
[<c010f900>] (unwind_backtrace) from [<c010c7d0>] (show_stack+0x20/0x24)
[<c010c7d0>] (show_stack) from [<c07cea90>] (dump_stack+0x24/0x28)
[<c07cea90>] (dump_stack) from [<c011ba30>] (__warn+0xec/0x110)
[<c011ba30>] (__warn) from [<c011bb24>] (warn_slowpath_null+0x30/0x38)
[<c011bb24>] (warn_slowpath_null) from [<c018452c>]
(__ipipe_set_irq_pending+0xf8/0x110)
[<c018452c>] (__ipipe_set_irq_pending) from [<c0185e7c>]
(__ipipe_dispatch_irq+0xac/0x218)
[<c0185e7c>] (__ipipe_dispatch_irq) from [<c03d894c>]
(atmel_gpio_irq_handler+0x100/0x18c)
[<c03d894c>] (atmel_gpio_irq_handler) from [<c0185f30>]
(__ipipe_dispatch_irq+0x160/0x218)
[<c0185f30>] (__ipipe_dispatch_irq) from [<c010128c>]
(__ipipe_grab_irq+0x44/0xac)
[<c010128c>] (__ipipe_grab_irq) from [<c01017e8>] (aic5_handle+0xa0/0xe4)
Exception stack(0xc0c01eb8 to 0xc0c01f00)
1ea0:                                                       c0c00000 dfffcd80
1ec0: c0185b60 60000013 ffffffff c0c01f14 c0c01f3c c0c01ee0 c010d7a4 c0101754
1ee0: 000016b1 0000000b 00000000 20000093 ffffe000 c0c030a8 c0c8119a c08f9d04
[<c01017e8>] (aic5_handle) from [<c010d7a4>] (__irq_svc+0x84/0x90)
Exception stack(0xc0c01ee0 to 0xc0c01f28)
1ee0: 000016b1 0000000b 00000000 20000093 ffffe000 c0c030a8 c0c8119a c08f9d04
1f00: 00000001 c0b5fa28 dfffcd80 c0c01f3c c0c14b38 c0c01f30 00000000 c0185b60
1f20: 60000013 ffffffff
[<c010d7a4>] (__irq_svc) from [<c0185b60>] (ipipe_unstall_root+0x5c/0x78)
[<c0185b60>] (ipipe_unstall_root) from [<c01092ec>] (arch_cpu_idle+0x30/0xac)
[<c01092ec>] (arch_cpu_idle) from [<c07e79a0>] (default_idle_call+0x44/0x50)
[<c07e79a0>] (default_idle_call) from [<c0147b3c>] (do_idle+0xa0/0x150)
[<c0147b3c>] (do_idle) from [<c0147e7c>] (cpu_startup_entry+0x1c/0x20)
[<c0147e7c>] (cpu_startup_entry) from [<c07e1d9c>] (rest_init+0x98/0x9c)
[<c07e1d9c>] (rest_init) from [<c0b00de0>] (start_kernel+0x39c/0x3a8)
[<c0b00de0>] (start_kernel) from [<20008078>] (0x20008078)
---[ end trace 1afd63ee35aae4ab ]---
random: crng init done
irq 126: nobody cared (try booting with the "irqpoll" option)
CPU: 0 PID: 0 Comm: swapper Tainted: G        W       4.14.96+ #46
Hardware name: Atmel SAMA5
I-pipe domain: Linux
[<c010f900>] (unwind_backtrace) from [<c010c7d0>] (show_stack+0x20/0x24)
[<c010c7d0>] (show_stack) from [<c07cea90>] (dump_stack+0x24/0x28)
[<c07cea90>] (dump_stack) from [<c015488c>] (__report_bad_irq+0x48/0xc8)
[<c015488c>] (__report_bad_irq) from [<c0154684>] (note_interrupt+0x11c/0x2a4)
[<c0154684>] (note_interrupt) from [<c0152084>]
(handle_irq_event_percpu+0x68/0x74)
[<c0152084>] (handle_irq_event_percpu) from [<c01520c8>]
(handle_irq_event+0x38/0x4c)
[<c01520c8>] (handle_irq_event) from [<c0156014>] (handle_level_irq+0x78/0xb8)
[<c0156014>] (handle_level_irq) from [<c0151114>]
(generic_handle_irq+0x34/0x44)
[<c0151114>] (generic_handle_irq) from [<c01516e8>]
(__handle_domain_irq+0x64/0xb8)
[<c01516e8>] (__handle_domain_irq) from [<c01091f0>] (handle_IRQ+0x28/0x2c)
[<c01091f0>] (handle_IRQ) from [<c010fe8c>] (__ipipe_do_IRQ+0x1c/0x24)
[<c010fe8c>] (__ipipe_do_IRQ) from [<c01855ac>]
(__ipipe_do_sync_stage+0x258/0x2c0)
[<c01855ac>] (__ipipe_do_sync_stage) from [<c0185b78>]
(ipipe_unstall_root+0x74/0x78)
[<c0185b78>] (ipipe_unstall_root) from [<c03dcfbc>] (gpio_to_desc+0xd4/0xd8)
[<c03dcfbc>] (gpio_to_desc) from [<c03d8934>]
(atmel_gpio_irq_handler+0xe8/0x18c)
[<c03d8934>] (atmel_gpio_irq_handler) from [<c0185f30>]
(__ipipe_dispatch_irq+0x160/0x218)
[<c0185f30>] (__ipipe_dispatch_irq) from [<c010128c>]
(__ipipe_grab_irq+0x44/0xac)
[<c010128c>] (__ipipe_grab_irq) from [<c01017e8>] (aic5_handle+0xa0/0xe4)
Exception stack(0xc0c01eb8 to 0xc0c01f00)
1ea0:                                                       c0c00000 dfffcd80
1ec0: c0185b60 60000013 ffffffff c0c01f14 c0c01f3c c0c01ee0 c010d7a4 c0101754
1ee0: 000016b1 0000000b 00000000 20000093 ffffe000 c0c030a8 c0c8119a c08f9d04
[<c01017e8>] (aic5_handle) from [<c010d7a4>] (__irq_svc+0x84/0x90)
Exception stack(0xc0c01ee0 to 0xc0c01f28)
1ee0: 000016b1 0000000b 00000000 20000093 ffffe000 c0c030a8 c0c8119a c08f9d04
1f00: 00000001 c0b5fa28 dfffcd80 c0c01f3c c0c14b38 c0c01f30 00000000 c0185b60
1f20: 60000013 ffffffff
[<c010d7a4>] (__irq_svc) from [<c0185b60>] (ipipe_unstall_root+0x5c/0x78)
[<c0185b60>] (ipipe_unstall_root) from [<c01092ec>] (arch_cpu_idle+0x30/0xac)
[<c01092ec>] (arch_cpu_idle) from [<c07e79a0>] (default_idle_call+0x44/0x50)
[<c07e79a0>] (default_idle_call) from [<c0147b3c>] (do_idle+0xa0/0x150)
[<c0147b3c>] (do_idle) from [<c0147e7c>] (cpu_startup_entry+0x1c/0x20)
[<c0147e7c>] (cpu_startup_entry) from [<c07e1d9c>] (rest_init+0x98/0x9c)
[<c07e1d9c>] (rest_init) from [<c0b00de0>] (start_kernel+0x39c/0x3a8)
[<c0b00de0>] (start_kernel) from [<20008078>] (0x20008078)
handlers:
[<c01520dc>] irq_default_primary_handler threaded [<c04fd378>] phy_interrupt
Disabling IRQ #126
------------[ cut here ]------------
kernel BUG at arch/arm/kernel/ipipe.c:247!
Internal error: Oops - BUG: 0 [#1] ARM
Modules linked in:
CPU: 0 PID: 0 Comm: swapper Tainted: G        W       4.14.96+ #46
Hardware name: Atmel SAMA5
I-pipe domain: Linux
task: c0c05ff8 task.stack: c0c00000
PC is at __ipipe_bugon_irqs_enabled+0x20/0x24
LR is at __ipipe_fast_svc_irq_exit+0x4/0x3c
pc : [<c010ffe8>]    lr : [<c010d7b4>]    psr: 40000113
sp : c0c01ed0  ip : c010ffdc  fp : c0c01edc
r10: dfffcd80  r9 : c0c00000  r8 : 00000001
r7 : c0c01f14  r6 : ffffffff  r5 : 60000013  r4 : c0185b60
r3 : 40000113  r2 : c0c9ad40  r1 : 00000005  r0 : 00000001
Flags: nZcv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment none
Control: 10c53c7d  Table: 20004059  DAC: 00000051
Process swapper (pid: 0, stack limit = 0xc0c00218)
Stack: (0xc0c01ed0 to 0xc0c02000)
1ec0:                                     c0c01f3c c0c01ee0 c010d7b4 c010ffd4
1ee0: 000016b1 0000000b 00000000 20000093 ffffe000 c0c030a8 c0c8119a c08f9d04
1f00: 00000001 c0b5fa28 dfffcd80 c0c01f3c c0c14b38 c0c01f30 00000000 c0185b60
1f20: 60000013 ffffffff 00000051 00000000 c0c01f4c c0c01f40 c01092ec c0185b10
1f40: c0c01f5c c0c01f50 c07e79a0 c01092c8 c0c01f84 c0c01f60 c0147b3c c07e7968
1f60: c0c0b1a4 c0c8b780 c0c03040 ffffffff c0c8b780 c0b5fa28 c0c01f94 c0c01f88
1f80: c0147e7c c0147aa8 c0c01fac c0c01f98 c07e1d9c c0147e6c c0c8b7cc c0c8b780
1fa0: c0c01ff4 c0c01fb0 c0b00de0 c07e1d10 ffffffff ffffffff 00000000 c0b0063c
1fc0: 00000000 c0b5fa28 00000000 c0c8b914 c0c03058 c0b5fa24 c0c0736c 20004059
1fe0: 410fc051 00000000 00000000 c0c01ff8 20008078 c0b00a50 00000000 00000000
[<c010ffe8>] (__ipipe_bugon_irqs_enabled) from [<c010d7b4>]
(__ipipe_fast_svc_irq_exit+0x4/0x3c)
[<c010d7b4>] (__ipipe_fast_svc_irq_exit) from [<c0185b60>]
(ipipe_unstall_root+0x5c/0x78)
[<c0185b60>] (ipipe_unstall_root) from [<c01092ec>] (arch_cpu_idle+0x30/0xac)
[<c01092ec>] (arch_cpu_idle) from [<c07e79a0>] (default_idle_call+0x44/0x50)
[<c07e79a0>] (default_idle_call) from [<c0147b3c>] (do_idle+0xa0/0x150)
[<c0147b3c>] (do_idle) from [<c0147e7c>] (cpu_startup_entry+0x1c/0x20)
[<c0147e7c>] (cpu_startup_entry) from [<c07e1d9c>] (rest_init+0x98/0x9c)
[<c07e1d9c>] (rest_init) from [<c0b00de0>] (start_kernel+0x39c/0x3a8)
[<c0b00de0>] (start_kernel) from [<20008078>] (0x20008078)
Code: ebfffade e10f3000 e3130080 189da800 (e7f001f2)
I-pipe tracer log (100 points):
   +func                    0 ipipe_trace_panic_freeze+0x10 (oops_enter+0x1c)
   +func                   -2 oops_enter+0x10 (die+0x28)
   +func                   -4 die+0x14 (arm_notify_die+0x5c)
   +func                   -5 arm_notify_die+0x10 (do_undefinstr+0x1a0)
 | +end     0x80000000     -8 ipipe_unstall_root+0x58 (<00000000>)
 | #func                   -8 ipipe_root_only+0x10 (ipipe_unstall_root+0x24)
 | #func                   -9 ipipe_unstall_root+0x10 (do_undefinstr+0x1f8)
 | +func                  -13 ipipe_root_only+0x10
(ipipe_test_and_stall_root+0x18)
 | +func                  -14 ipipe_test_and_stall_root+0x10
(do_undefinstr+0x98)
 | +func                  -15 do_undefinstr+0x14 (__und_svc_finish+0x0)
 | +func                  -19 __ipipe_notify_trap+0x14 (__und_svc+0x80)
 | +begin   0x90000000    -20 __und_svc+0x70
(__ipipe_check_root_interruptible+0x0)
   +func                  -23 __ipipe_bugon_irqs_enabled+0x10
(__ipipe_fast_svc_irq_exit+0x4)
   +func                  -24 ipipe_test_root+0x10
(__ipipe_check_root_interruptible+0x40)
   +func                  -24 __ipipe_check_root_interruptible+0x10
(__irq_svc+0x88)
   +end     0x0000002f    -26 __ipipe_grab_irq+0x4c (<00000000>)
   +func                  -28 __ipipe_do_sync_pipeline+0x10
(__ipipe_dispatch_irq+0x190)
 | +end     0x90000000    -30 __ipipe_fast_svc_irq_exit+0x28 (irq_gc_eoi+0x5c)
 | +func                  -32 __ipipe_bugon_irqs_enabled+0x10
(__ipipe_fast_svc_irq_exit+0x4)
 | +func                  -33 ipipe_test_root+0x10
(__ipipe_check_root_interruptible+0x40)
 | +func                  -34 __ipipe_check_root_interruptible+0x10
(__irq_svc+0x88)
 | +end     0x00000020    -35 __ipipe_grab_irq+0x4c (<00000000>)
 | #begin   0x80000000    -38 __ipipe_do_sync_stage+0x2b8 (<00000000>)
   #func                  -40 idle_cpu+0x10 (irq_exit+0xbc)
   #func                  -42 ipipe_test_root+0x10 (__local_bh_enable+0x1c)
   #func                  -43 __local_bh_enable+0x10 (__do_softirq+0x210)
   +func                  -45 ipipe_root_only+0x10 (ipipe_stall_root+0x18)
   +func                  -45 ipipe_stall_root+0x10 (__do_softirq+0x198)
 | +end     0x80000000    -46 ipipe_unstall_root+0x58 (<00000000>)
 | #func                  -47 ipipe_root_only+0x10 (ipipe_unstall_root+0x24)
 | #begin   0x80000000    -48 ipipe_unstall_root+0x6c (<00000000>)
   #func                  -49 ipipe_unstall_root+0x10 (rcu_bh_qs+0x4c)
   +func                  -50 ipipe_root_only+0x10
(ipipe_test_and_stall_root+0x18)
   +func                  -51 ipipe_test_and_stall_root+0x10 (rcu_bh_qs+0x18)
   +func                  -51 rcu_bh_qs+0x10 (__do_softirq+0x194)
 | +end     0x80000000    -54 ipipe_unstall_root+0x58 (<00000000>)
 | #func                  -55 ipipe_root_only+0x10 (ipipe_unstall_root+0x24)
 | #begin   0x80000000    -55 ipipe_unstall_root+0x6c (<00000000>)
   #func                  -56 ipipe_unstall_root+0x10 (run_timer_softirq+0x160)
   #func                  -57 collect_expired_timers+0x10
(run_timer_softirq+0x10c)
   #func                  -60 __next_timer_interrupt+0x10
(collect_expired_timers+0x3c)
   #func                  -61 collect_expired_timers+0x10
(run_timer_softirq+0x10c)
   #func                  -62 ipipe_root_only+0x10
(ipipe_test_and_stall_root+0x18)
   #func                  -63 ipipe_test_and_stall_root+0x10
(try_to_wake_up+0x24)
   #func                  -63 try_to_wake_up+0x10 (wake_up_process+0x20)
   #func                  -64 wake_up_process+0x10 (insert_work+0x88)
   #func                  -65 get_pwq+0x10 (insert_work+0x58)
   #func                  -66 insert_work+0x14 (__queue_work+0x130)
   #func                  -68 get_work_pool+0x10 (__queue_work+0x8c)
   #func                  -70 ipipe_test_root+0x10 (__queue_work+0x2c)
   #func                  -70 __queue_work+0x14 (delayed_work_timer_fn+0x24)
   #func                  -71 delayed_work_timer_fn+0x10 (call_timer_fn+0x50)
   #func                  -72 call_timer_fn+0x14 (expire_timers+0x8c)
   #func                  -73 expire_timers+0x10 (run_timer_softirq+0x134)
   #func                  -77 __next_timer_interrupt+0x10
(collect_expired_timers+0x3c)
   #func                  -78 collect_expired_timers+0x10
(run_timer_softirq+0x10c)
   +func                  -79 ipipe_root_only+0x10 (ipipe_stall_root+0x18)
   +func                  -80 ipipe_stall_root+0x10 (run_timer_softirq+0xdc)
 | +end     0x80000000    -81 ipipe_unstall_root+0x58 (<00000000>)
 | #func                  -82 ipipe_root_only+0x10 (ipipe_unstall_root+0x24)
 | #begin   0x80000000    -83 ipipe_unstall_root+0x6c (<00000000>)
   #func                  -84 ipipe_unstall_root+0x10 (run_timer_softirq+0xc4)
   #func                  -85 collect_expired_timers+0x10
(run_timer_softirq+0x70)
   #func                  -87 __next_timer_interrupt+0x10
(collect_expired_timers+0x3c)
   #func                  -88 collect_expired_timers+0x10
(run_timer_softirq+0x70)
   +func                  -89 ipipe_root_only+0x10 (ipipe_stall_root+0x18)
   +func                  -90 ipipe_stall_root+0x10 (expire_timers+0xa8)
 | +end     0x80000000    -91 ipipe_unstall_root+0x58 (<00000000>)
 | #func                  -91 ipipe_root_only+0x10 (ipipe_unstall_root+0x24)
 | #begin   0x80000000    -92 ipipe_unstall_root+0x6c (<00000000>)
   #func                  -93 ipipe_unstall_root+0x10 (mod_timer+0x160)
   #func                  -94 trigger_dyntick_cpu+0x10 (mod_timer+0x144)
   #func                  -95 enqueue_timer+0x10 (__internal_add_timer+0x38)
   #func                  -95 calc_wheel_index+0x10 (__internal_add_timer+0x28)
   #func                  -96 __internal_add_timer+0x10 (mod_timer+0x138)
   #func                  -97 detach_if_pending+0x10 (mod_timer+0xa0)
   +func                  -98 ipipe_root_only+0x10
(ipipe_test_and_stall_root+0x18)
   +func                  -99 ipipe_test_and_stall_root+0x10
(lock_timer_base+0x44)
   +func                 -100 lock_timer_base+0x10 (mod_timer+0x16c)
   +func                 -101 mod_timer+0x14 (poll_spurious_irqs+0x74)
   +func                 -102 irq_to_desc+0x10 (poll_spurious_irqs+0xac)
   +func                 -103 irq_to_desc+0x10 (poll_spurious_irqs+0xac)
   +func                 -104 irq_to_desc+0x10 (poll_spurious_irqs+0xac)
   +func                 -106 irq_to_desc+0x10 (poll_spurious_irqs+0xac)
   +func                 -107 irq_to_desc+0x10 (poll_spurious_irqs+0xac)
   +func                 -108 irq_to_desc+0x10 (poll_spurious_irqs+0xac)
   +func                 -109 irq_to_desc+0x10 (poll_spurious_irqs+0xac)
   +func                 -111 irq_to_desc+0x10 (poll_spurious_irqs+0xac)
   +func                 -112 irq_to_desc+0x10 (poll_spurious_irqs+0xac)
   +func                 -113 irq_to_desc+0x10 (poll_spurious_irqs+0xac)
   +func                 -114 irq_to_desc+0x10 (poll_spurious_irqs+0xac)
   +func                 -115 irq_to_desc+0x10 (poll_spurious_irqs+0xac)
   +func                 -116 irq_to_desc+0x10 (poll_spurious_irqs+0xac)
   +func                 -117 irq_to_desc+0x10 (poll_spurious_irqs+0xac)
   +func                 -119 irq_to_desc+0x10 (poll_spurious_irqs+0xac)
   +func                 -120 irq_to_desc+0x10 (poll_spurious_irqs+0xac)
   +func                 -121 irq_to_desc+0x10 (poll_spurious_irqs+0xac)
   +func                 -122 irq_to_desc+0x10 (poll_spurious_irqs+0xac)
   +func                 -123 irq_to_desc+0x10 (poll_spurious_irqs+0xac)
   +func                 -124 irq_to_desc+0x10 (poll_spurious_irqs+0xac)
---[ end trace 1afd63ee35aae4ac ]---
Kernel panic - not syncing: Attempted to kill the idle task!
---[ end Kernel panic - not syncing: Attempted to kill the idle task!


Mit freundlichen Grüßen

*Jan Leupold*
Entwicklung
Development
-- 
---------------------------------------------------------------------------
R-S-I Logo <https://www.rsi-elektrotechnik.de/>

R-S-I Elektrotechnik GmbH & Co. KG
Woelkestraße 11
D-85301 Schweitenkirchen
www.rsi-elektrotechnik.de <https://www.rsi-elektrotechnik.de/>

Tel: +49 8444 9204-32
Fax: +49 8444 9204-50
leupold@rsi-elektrotechnik.de <mailto:leupold@rsi-elektrotechnik.de>
---------------------------------------------------------------------------

Amtsgericht Ingolstadt - GmbH: HRB 191328 - KG: HRA 170363
Geschäftsführer: Dr.-Ing. Michael Sorg, Dipl.-Ing. Franz Sorg
USt-IdNr.: DE 128592548



