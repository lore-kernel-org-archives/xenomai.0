MIME-Version: 1.0
Date: Wed, 25 May 2016 11:55:25 +0300
Message-ID: <CAJ2oMh+KSW=wGadQ079T+e7M1E3=UG5GY=J8ih61Ez6UHENzWQ@mail.gmail.com>
From: Ran Shalit <ranshalit@gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: [Xenomai] Oops "undefined instruction: 0 [#1] PREEMPT SMP ARM"
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

I hope someone can have a hint on the following.
I use xenomai 2.6.3 patched with kernel 3.8.0 on zynq.
I wrote rtdm driver which coomunicated with fpga: the driver listens
to irq line, and print something on each time it recieve an interrupt.
If I do the rtdm_request_irq already at module init, I see that
interrupt are given and there is no issue.
But on trying to do the rtdm_irq_request from userspace application on
ioctl, then I recive oops. Another thing I see is that even when the
rtdm_request_irq is done on driver init (not in ioctl), and in ioctl I
just do simple printk then it will also get the oops :
it is as if the irq interrups in rtdm driver interfere somehow with
the ioctl call from userspace). I tried to debug this, but I have no
clue so far.

This is the Oops I get:

zynq>
zynq>
zynq> cd /usr/xenomai/bin/
zynq> ./rtdm
Internal error: Oops - undefined instruction: 0 [#1] PREEMPT SMP ARM
Modules linked in: xeno_rtdmtest
CPU: 0    Not tainted  (3.8.0-xilinx #17)
PC is at 0xc0e8fae8
LR is at xnintr_irq_handler+0x118/0x3e0
pc : [<c0e8fae8>]    lr : [<c0078648>]    psr: a0000193
sp : ee1d3da8  ip : c05d8d20  fp : c06572c0
r10: 0000005b  r9 : 00000000  r8 : c0658980
r7 : ffff0f00  r6 : c0667bc8  r5 : ed8dfcd0  r4 : f8b2dbb5
r3 : c0e8fae4  r2 : f890869b  r1 : 00000000  r0 : ed8dfcd0
Flags: NzCv  IRQs off  FIQs on  Mode SVC_32  ISA ARM  Segment kernel
Control: 18c5387d  Table: 2e39c04a  DAC: 00000015
Process dma0chan5-copy0 (pid: 695, stack limit = 0xee1d2238)
Stack: (0xee1d3da8 to 0xee1d4000)
3da0:                   ee1d2000 ee1d2000 00000000 c0e98d28 f8b2db3e 00000002
3dc0: 00000000 c0668248 c05db554 0000005b c06462c0 c05db060 c0e98d20 00000000
3de0: 00001198 00000000 00000eef c006a514 c0e98d20 ee1d3e28 ee1d3e28 c05e6498
3e00: ee1d3e5c ee1cc000 00003282 c0008444 f8f00100 c00085ec c042c3c4 60000013
3e20: ffffffff c000e1c0 ee2d37c0 00001b20 000000ce 000000ce 00000000 000000c0
3e40: 00001b20 ee2d37c0 ee1cc000 00003282 00000000 00000eef 00003b90 ee1d3e70
3e60: c0257798 c042c3c4 60000013 ffffffff 00000000 00004000 00003b90 ee1d2030
3e80: ee1d3f64 ed821c40 00000000 00003b90 00000080 00000000 00002070 00002800
3ea0: ee1d3f64 c0257798 000000c0 00000000 40000113 ffffffff 2e1cc000 c00439d4
3ec0: 2e1c8c30 ee213b80 ee1d2018 c05f1fd0 00000008 ee1d3ec8 00200140 00002801
3ee0: 00000004 ee1d3eb8 00000004 ee1d3ec4 ee1d3ec0 ee1d3eb8 00000000 00000001
3f00: ee10ee08 ee2112a8 00000001 00001b20 00000c30 00000000 00000001 ee1d3f20
3f20: 9f379f37 ee1d3f24 ee1d3f24 00002802 00002802 00000000 ee1d3f38 ee1d3f38
3f40: ee1d3f64 ee059e98 00000000 ed821c40 c0256bb8 00000000 00000000 00000000
3f60: 00000000 c003bb30 ee153924 00000000 00030003 ed821c40 00000000 00000000
3f80: ee1d3f80 ee1d3f80 00000000 00000000 ee1d3f90 ee1d3f90 ee1d3fac ee059e98
3fa0: c003ba90 00000000 00000000 c000e700 00000000 00000000 00000000 00000000
3fc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
3fe0: 00000000 00000000 00000000 00000000 00000013 00000000 7c7f471f 8fcbb3e7
[<c0078648>] (xnintr_irq_handler+0x118/0x3e0) from [<c006a514>]
(__ipipe_dispatch_irq+0x184/0x264)
[<c006a514>] (__ipipe_dispatch_irq+0x184/0x264) from [<c0008444>]
(__ipipe_grab_irq+0x5c/0x6c)
[<c0008444>] (__ipipe_grab_irq+0x5c/0x6c) from [<c00085ec>]
(gic_handle_irq+0x3c/0x60)
Exception stack(0xee1d3e18 to 0xee1d3e60)
3e00:                                                       c042c3c4 60000013
3e20: ffffffff c000e1c0 ee2d37c0 00001b20 000000ce 000000ce 00000000 000000c0
3e40: 00001b20 ee2d37c0 ee1cc000 00003282 00000000 00000eef 00003b90 ee1d3e70
[<c00085ec>] (gic_handle_irq+0x3c/0x60) from [<c000e1c0>] (__irq_svc+0x40/0x6c)
Exception stack(0xee1d3e28 to 0xee1d3e70)
3e20:                   ee2d37c0 00001b20 000000ce 000000ce 00000000 000000c0
3e40: 00001b20 ee2d37c0 ee1cc000 00003282 00000000 00000eef 00003b90 ee1d3e70
3e60: c0257798 c042c3c4 60000013 ffffffff
[<c000e1c0>] (__irq_svc+0x40/0x6c) from [<c042c3c4>] (dmatest_verify+0x44/0x110)
[<c042c3c4>] (dmatest_verify+0x44/0x110) from [<c0257798>]
(dmatest_func+0xbe0/0xdd4)
[<c0257798>] (dmatest_func+0xbe0/0xdd4) from [<c003bb30>] (kthread+0xa0/0xac)
[<c003bb30>] (kthread+0xa0/0xac) from [<c000e700>] (ret_from_fork+0x18/0x38)
Code: 00000000 c0e8fadc c0e8fadc 00020002 (c0e8fae8)
================================


I thought that maybe I did not configure xenomai correctly so I've
tried to several configurations with xenomai:

 ./configure CFLAGS="-march=armv4t" LDFLAGS="-march=armv4t"
--build=i686-pc-linux-gnu --host=arm-xilinx-linux-gnueabi
 ./configure CFLAGS="-march=armv7-a -mfpu=neon"
LDFLAGS="-march=armv7-a -mfpu=neon"   --build=i686-pc-linux-gnu
--host=arm-xilinx-linux-gnueabi

1. armv7-a/armv4t
2. neon / or  without neon

But it seems that the same result in all configurations.

rtdm.c driver is attached here:
https://drive.google.com/file/d/0B22GsWueReZTMjZYWlltZFRXU2M/view?usp=sharing

Thank you for any suggestion,
Ran

