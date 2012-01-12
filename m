Message-ID: <4F0F1E23.5060400@domain.hid>
Date: Thu, 12 Jan 2012 18:53:39 +0100
From: Manfred <manfred@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-help] Omap3630, rtserial, xeno_16550A: crash on insmod
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai@xenomai.org.

Dear Xenomai-Developers/Users,

I am trying to get xenomai running on an omap3630 device (gumstix overo).
xenomai 2.6.0/kernel: linux-omap3-2.6.38 / i-pipe patch 2.6.38.8-arm-1.18.04

I would like to use the UART devices in a RT-application,
  and I was following the following guidelines:
http://www.xenomai.org/index.php/16550A

I had to do some changes to Kconfig in arch/arm/mach-omap2:Kconfig,
so that the omap_serial driver would not be compiled-in and so that
  I could actually disable the driver with setserial
(and correspondingly had to make some changes here and there because the
  devices are now called /dev/ttySx and not /dev/ttyOx, as in the 
omap_serial driver...)

dmesg then reports:
serial8250.0: ttyS0 at MMIO 0x4806a000 (irq = 72) is a ST16654
serial8250.1: ttyS1 at MMIO 0x4806c000 (irq = 73) is a ST16654
serial8250.2: ttyS2 at MMIO 0x49020000 (irq = 74) is a ST16654
serial8250.3: ttyS3 at MMIO 0x49042000 (irq = 80) is a ST16654

Anyway, finally I was able to the following:
 >setserial /dev/ttyS0 uart none
 >modprobe xeno_16550A mem=0x4806a000 irq=72 baud_base=3000000

(parameters same as here:
http://www.mail-archive.com/xenomai@xenomai.org
)

And then I immediately get the following Error:

--------------------
Unhandled fault: external abort on non-linefetch (0x1028) at 0xfa06a002
Internal error: : 1028 [#1]
last sysfs file:
/sys/devices/platform/mmci-omap-hs.0/mmc_host/mmc0/mmc0:aaaa/...
.../block/mmcblk0/size
Modules linked in:
xeno_16550A(+) ipv6 libertas_sdio libertas option ads7846 cfg80211 usb_wwan
  lib80211 usbserial firmware_class
CPU: 0    Not tainted  (2.6.38 #1)
PC is at init_module+0x170/0x284 [xeno_16550A]
LR is at init_module+0x11c/0x284 [xeno_16550A]
pc : [<bf0f0170>]    lr : [<bf0f011c>]    psr: 60000013
sp : dda0ff28  ip : 4806a000  fp : bf0ece4c
r10: bf0eced0  r9 : bf0ece6c  r8 : bf0ece90
r7 : defeb380  r6 : 00000000  r5 : 00000000  r4 : defeb38c
r3 : 00000000  r2 : fa06a000  r1 : 00000001  r0 : fa06a000
Flags: nZCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment user
Control: 10c5387d  Table: 9e558019  DAC: 00000015
Process insmod (pid: 4467, stack limit = 0xdda0e2f0)
Stack: (0xdda0ff28 to 0xdda10000)
<snip>
[<bf0f0170>] (init_module+0x170/0x284 [xeno_16550A]) from
[<c003a494>] (do_one_initcall+0xc8/0x19c)
[<c003a494>] (do_one_initcall+0xc8/0x19c) from
[<c0096f98>] (sys_init_module+0x94/0x1b4)
[<c0096f98>] (sys_init_module+0x94/0x1b4) from
[<c0040400>] (ret_fast_syscall+0x0/0x30)
Code: 1a000002 e5d23002 f57ff05f ea000003 (e5d23002)
  ---[ end trace 260381790a98f885 ]---
  overo Internal error: : 1028 [#1]
  overo last sysfs file: /sys/devices/platform/mmci-omap-hs.0/mmc_host/mmc0/
  mmc0:aaaa/block/mmcblk0/size
  overo Process insmod (pid: 4467, stack limit = 0xdda0e2f0)
Segmentation fault
----------------------

Has anyone seen something similar?
Is this possibly a bug in the xeno16550A driver module,
or perhaps a bug in the omap3 kernel?

How can I debug this? (is there a way to run gdb on insmod?)

Any help with this issue is highly appreciated.

Regards
Manfred

