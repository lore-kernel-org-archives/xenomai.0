MIME-Version: 1.0
In-Reply-To: <20160525141353.GP13609@hermes.click-hack.org>
References: <CAJ2oMh+KSW=wGadQ079T+e7M1E3=UG5GY=J8ih61Ez6UHENzWQ@mail.gmail.com>
 <20160525092316.GF13609@hermes.click-hack.org>
 <CAJ2oMhLJdUfizqQ_8m=7LQ3D4SaH06FtLV_oL55MokT=C5PDAg@mail.gmail.com>
 <20160525141353.GP13609@hermes.click-hack.org>
Date: Wed, 25 May 2016 18:08:57 +0300
Message-ID: <CAJ2oMh+r4MtOH+C4N64a8nNp7zDPnkskhbx9PkTZpNcyoMttbw@mail.gmail.com>
From: Ran Shalit <ranshalit@gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Xenomai] Oops "undefined instruction: 0 [#1] PREEMPT SMP ARM"
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

On Wed, May 25, 2016 at 5:13 PM, Gilles Chanteperdrix
<gilles.chanteperdrix@xenomai.org> wrote:
> On Wed, May 25, 2016 at 05:10:21PM +0300, Ran Shalit wrote:
>> On Wed, May 25, 2016 at 12:23 PM, Gilles Chanteperdrix
>> <gilles.chanteperdrix@xenomai.org> wrote:
>> > On Wed, May 25, 2016 at 11:55:25AM +0300, Ran Shalit wrote:
>> >> Hello,
>> >>
>> >> I hope someone can have a hint on the following.
>> >> I use xenomai 2.6.3 patched with kernel 3.8.0 on zynq.
>> >
>> > There is no reason to start working on a new project with Xenomai
>> > 2.6.3. For this reason, switch to Xenomai 2.6.4, or even better
>> > Xenomai 3.0.2
>> >
>> >>  ./configure CFLAGS="-march=armv4t" LDFLAGS="-march=armv4t"
>> >> --build=i686-pc-linux-gnu --host=arm-xilinx-linux-gnueabi
>> >
>> > The zynq is an armv7; not an armv4. You have no reason whatsoever to
>> > use such compilation flags.
>> >
>> > --
>> I suspect that it is related to something illegal maybe that I'm doing
>> in driver, but I still don't understand what it is.
>> Even if I just load the the driver and then write
>> cat /proc/xenomai/stat then I recieve this oops.
>>
>> The driver does ioremap and the rtdm_request_irq both in module
>> initialization, maybe it is not correct with rtdm?
>
> It is pointless to even look at your issue as long as you use an
> outdated version.
>

Right,
I've moved to 2.6.4, but this issue still occurs with my rtdm driver:

zynq> .
Unable to handle kernel NULL pointer dereference at virtual address 00000000
pgd = c0004000, hw pgd = ed8c8000

[00000000] *pgd=00000000
Internal error: Oops: 80000007 [#1] PREEMPT SMP ARM
Modules linked in: xeno_rtdmtest
CPU: 0    Not tainted  (3.8.13-xilinx-02318-g1271e35-dirty #1)
PC is at 0x0
LR is at xnintr_irq_handler+0x118/0x3e4
pc : [<00000000>]    lr : [<c00788f8>]    psr: a0000193
sp : ed837de0  ip : c05dbd20  fp : c0659cc0
r10: 0000005b  r9 : 00000000  r8 : c065b380
r7 : ffff0f00  r6 : c066a5c8  r5 : ed83be40  r4 : 7dd91813
r3 : 00000002  r2 : 7dd57302  r1 : 00000000  r0 : ed83be40
Flags: NzCv  IRQs off  FIQs on  Mode SVC_32  ISA ARM  Segment kernel
Control: 18c5387d  Table: 2d8c804a  DAC: 00000015
Process dma0chan5-copy0 (pid: 695, stack limit = 0xed836238)
Stack: (0xed837de0 to 0xed838000)
7de0: 00000000 00000000 00000000 00000000 7dd917e0 00000002 00000000 c066ac48
7e00: 00000000 0000005b c0648cc0 c05de060 c0e9ad20 00000000 00001198 00002278
7e20: ed837f64 c006a78c c0e9ad20 ed837e60 ed837e60 c05e8498 ed837e94 ee29cb74
7e40: 000038f8 c0008444 f8f00100 c00085ec c02588a0 80000113 ffffffff c000e1c0
7e60: c05f8db0 00003c98 ed813ec0 000016e1 ee1826c0 ee1c8000 00000428 00000080
7e80: ee29cb74 000038f8 00002278 ed837f64 0000003f ed837ea8 c02587b4 c02588a0
7ea0: 80000113 ffffffff 00000000 00000000 60000113 ffffffff 2e1c8000 c0043c2c
7ec0: 2e1ec480 ee211480 ed836018 c05f3f50 00000008 ed837ec8 00200140 00002279
7ee0: 00000004 ed837eb8 00000004 ed837ec4 ed837ec0 ed837eb8 00000000 00000001
7f00: ed8a1e08 ee1709e8 00000001 000003a0 00000428 00000000 00000001 ed837f20
7f20: 89a089a0 ed837f24 ed837f24 699be65f 00002279 00000000 ed837f38 ed837f38
7f40: ed837f64 ee059e98 00000000 ee1826c0 c0258498 00000000 00000000 00000000
7f60: 00000000 c003bc74 ed836000 00000000 00000000 ee1826c0 00000000 00000000
7f80: ed837f80 ed837f80 00000000 00000000 ed837f90 ed837f90 60000113 ee059e98
7fa0: c003bbd4 00000000 00000000 c000e700 00000000 00000000 00000000 00000000
7fc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
7fe0: 00000000 00000000 00000000 00000000 00000013 00000000 00000000 00900202
[<c00788f8>] (xnintr_irq_handler+0x118/0x3e4) from [<c006a78c>]
(__ipipe_dispatch_irq+0x184/0x264)
[<c006a78c>] (__ipipe_dispatch_irq+0x184/0x264) from [<c0008444>]
(__ipipe_grab_irq+0x5c/0x6c)
[<c0008444>] (__ipipe_grab_irq+0x5c/0x6c) from [<c00085ec>]
(gic_handle_irq+0x3c/0x60)
Exception stack(0xed837e50 to 0xed837e98)
7e40:                                     c02588a0 80000113 ffffffff c000e1c0
7e60: c05f8db0 00003c98 ed813ec0 000016e1 ee1826c0 ee1c8000 00000428 00000080
7e80: ee29cb74 000038f8 00002278 ed837f64 0000003f ed837ea8
[<c00085ec>] (gic_handle_irq+0x3c/0x60) from [<c000e1c0>] (__irq_svc+0x40/0x6c)
Exception stack(0xed837e60 to 0xed837ea8)
7e60: c05f8db0 00003c98 ed813ec0 000016e1 ee1826c0 ee1c8000 00000428 00000080
7e80: ee29cb74 000038f8 00002278 ed837f64 0000003f ed837ea8 c02587b4 c02588a0
7ea0: 80000113 ffffffff
[<c000e1c0>] (__irq_svc+0x40/0x6c) from [<c02588a0>] (dmatest_func+0x408/0xdd4)
[<c02588a0>] (dmatest_func+0x408/0xdd4) from [<c003bc74>] (kthread+0xa0/0xac)
[<c003bc74>] (kthread+0xa0/0xac) from [<c000e700>] (ret_from_fork+0x18/0x38)
Code: bad PC value
---[ end trace 283f81edc9d7c6ca ]---


Regards,
Ran

