MIME-Version: 1.0
Date: Sun, 23 Feb 2014 21:27:07 +0000
Message-ID: <CAEbDrgkifqMcqqEqh5hKA90YzFzcyDxLHFC79F8CWvZi5heyWQ@mail.gmail.com>
From: Gregory Dymarek <gregd72002@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Subject: [Xenomai] RaspberryPi kernel 3.8 issue
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Hi,


I compiled a fresh rpi-3.8 kernel using the following patches (from
xenomai-2.6.3):
- ipipe-core-3.8.13-raspberry-pre-2.patch
- ipipe-core-3.8.13-arm-3.patch
- ipipe-core-3.8.13-raspberry-post-2.patch

All compiled well, but when booting this kernel it reports an exception.
The entire boot log is here: http://pastebin.com/K7v44nPw

I am still not very faimiliar with the architecture so I am not really able
to sort it myself...
Any advise please?

[    1.915956] hub 1-0:1.0: 1 port detected
[    1.923672] ------------[ cut here ]------------
[    1.931807] WARNING: at kernel/irq/handle.c:146
handle_irq_event_percpu+0x190/0x1b4()
[    1.943148] irq 32 handler usb_hcd_irq+0x0/0x7c enabled interrupts
[    1.952840] Modules linked in:
[    1.959469] [<c00141ec>] (unwind_backtrace+0x0/0xec) from [<c00204fc>]
(warn_slowpath_common+0x4c/0x64)
[    1.972561] [<c00204fc>] (warn_slowpath_common+0x4c/0x64) from
[<c0020544>] (warn_slowpath_fmt+0x30/0x40)
[    1.985872] [<c0020544>] (warn_slowpath_fmt+0x30/0x40) from [<c0077838>]
(handle_irq_event_percpu+0x190/0x1b4)
[    1.999671] [<c0077838>] (handle_irq_event_percpu+0x190/0x1b4) from
[<c00778c0>] (handle_irq_event+0x64/0x94)
[    2.013394] [<c00778c0>] (handle_irq_event+0x64/0x94) from [<c007a6c4>]
(handle_level_irq+0x78/0x108)
[    2.026432] [<c007a6c4>] (handle_level_irq+0x78/0x108) from [<c0077010>]
(generic_handle_irq+0x1c/0x30)
[    2.039690] [<c0077010>] (generic_handle_irq+0x1c/0x30) from
[<c000eacc>] (handle_IRQ+0x30/0x84)
[    2.052361] [<c000eacc>] (handle_IRQ+0x30/0x84) from [<c008036c>]
(__ipipe_do_sync_stage+0x25c/0x278)
[    2.065548] [<c008036c>] (__ipipe_do_sync_stage+0x25c/0x278) from
[<c00083c4>] (__ipipe_grab_irq+0x2c/0x70)
[    2.079312] [<c00083c4>] (__ipipe_grab_irq+0x2c/0x70) from [<c0422d14>]
(__irq_svc+0x34/0xc0)
[    2.091773] Exception stack(0xcd82de00 to 0xcd82de48)
[    2.100766] de00: f2980008 00000000 00000000 00000000 00000000 00000000
cd99ec00 c05db7c4
[    2.112995] de20: cd9ed380 c05bbfc0 c0523a7c c05db8a4 00000030 cd82de48
c02f947c c02f8e44
[    2.125241] de40: 60000113 ffffffff
[    2.132818] [<c0422d14>] (__irq_svc+0x34/0xc0) from [<c02f8e44>]
(dwc_otg_driver_probe+0x114/0x7e0)
[    2.146103] [<c02f8e44>] (dwc_otg_driver_probe+0x114/0x7e0) from
[<c02aa504>] (really_probe+0x60/0x1e8)
[    2.159771] [<c02aa504>] (really_probe+0x60/0x1e8) from [<c02aa778>]
(__driver_attach+0x98/0x9c)
[    2.172812] [<c02aa778>] (__driver_attach+0x98/0x9c) from [<c02a8b70>]
(bus_for_each_dev+0x60/0x94)
[    2.186145] [<c02a8b70>] (bus_for_each_dev+0x60/0x94) from [<c02a9cb8>]
(bus_add_driver+0xac/0x244)
[    2.199589] [<c02a9cb8>] (bus_add_driver+0xac/0x244) from [<c02aae20>]
(driver_register+0x78/0x140)
[    2.213103] [<c02aae20>] (driver_register+0x78/0x140) from [<c05a0074>]
(dwc_otg_driver_init+0x20/0xe0)
[    2.226973] [<c05a0074>] (dwc_otg_driver_init+0x20/0xe0) from
[<c00086e0>] (do_one_initcall+0x114/0x180)
[    2.241020] [<c00086e0>] (do_one_initcall+0x114/0x180) from [<c058c86c>]
(kernel_init_freeable+0xf8/0x1b8)
[    2.255236] [<c058c86c>] (kernel_init_freeable+0xf8/0x1b8) from
[<c041c210>] (kernel_init+0x8/0x150)
[    2.268963] [<c041c210>] (kernel_init+0x8/0x150) from [<c000dc40>]
(ret_from_fork+0x18/0x38)
[    2.282034] ---[ end trace 6e968ac9df7b1cbe ]---
[    2.291589] dwc_otg: FIQ enabled
