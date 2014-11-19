MIME-Version: 1.0
In-Reply-To: <CANKLDmu4j6KZS+UeQq9GtW1rB9_9m6MX3upWK2vWtNpuO0bKBw@mail.gmail.com>
References: <CANKLDmv=sSdgO9R6cVj6VoT1MpvswS3h=W8sKpaykFaeiv0-aQ@mail.gmail.com>
 <20141119090249.GA24219@sisyphus.hd.free.fr>
 <CANKLDmuqm9F3OvPvX=6zj87rxNLqgK++19O1LAOJQj54-u4TwA@mail.gmail.com>
 <20141119094137.GA25848@sisyphus.hd.free.fr>
 <CANKLDmu2YU30PBhN2So_5rziitxPf9qjs0H-Y6cJTFq+jAt_ng@mail.gmail.com>
 <20141119095428.GB25848@sisyphus.hd.free.fr>
 <CANKLDmu4j6KZS+UeQq9GtW1rB9_9m6MX3upWK2vWtNpuO0bKBw@mail.gmail.com>
Date: Wed, 19 Nov 2014 13:56:20 +0100
Message-ID: <CANKLDmvyZEPe8Z5Us1fMJ05=ZGOtqJnDHg_-2n_cwo5hD_8bzw@mail.gmail.com>
From: Henri Roosen <henriroosen@gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Xenomai] problems with ipipe-3.10 on i.MX6
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: "Xenomai@xenomai.org" <xenomai@xenomai.org>

On Wed, Nov 19, 2014 at 11:56 AM, Henri Roosen <henriroosen@gmail.com>
wrote:

>
>
> On Wed, Nov 19, 2014 at 10:54 AM, Gilles Chanteperdrix <
> gilles.chanteperdrix@xenomai.org> wrote:
>
>> On Wed, Nov 19, 2014 at 10:52:04AM +0100, Henri Roosen wrote:
>> > On Wed, Nov 19, 2014 at 10:41 AM, Gilles Chanteperdrix <
>> > gilles.chanteperdrix@xenomai.org> wrote:
>> >
>> > > On Wed, Nov 19, 2014 at 10:37:53AM +0100, Henri Roosen wrote:
>> > > > On Wed, Nov 19, 2014 at 10:02 AM, Gilles Chanteperdrix <
>> > > > gilles.chanteperdrix@xenomai.org> wrote:
>> > > >
>> > > > > On Wed, Nov 19, 2014 at 09:45:26AM +0100, Henri Roosen wrote:
>> > > > > > Hi,
>> > > > > >
>> > > > > > We are currently transitioning our i.MX6 systems from kernel
>> > > > > > ipipe-3.0-imx6q with Xenomai 2.6.2.1 to kernel ipipe-3.10 with
>> > > Xenomai
>> > > > > > 2.6.4.
>> > > > > >
>> > > > > > The application uses interrupts from external hardware, fed
>> into the
>> > > > > system
>> > > > > > by a GPIO pin interrupt.
>> > > > > >
>> > > > > > The system behaves very in-stable with the 3.10 version. I
>> observe
>> > > kernel
>> > > > > > crashes, kernel null pointer dereferences, timer stalls and
>> lock-ups
>> > > at
>> > > > > > various different places. The 3.0 version runs fine.
>> > > > > >
>> > > > > > Are there any known issues like this with the ipipe-3.10 on an
>> i.MX6?
>> > > > > > Any suggestions how to tackle this problem?
>> > > > >
>> > > > > Basically, as I explained yesterday, SOCs in the mainline I-pipe
>> > > > > patch for which I have no hardware are only build-tested. The
>> I-pipe
>> > > > > patch for 3.0 is better maintained, because I have feedback from
>> its
>> > > > > users.
>> > > > >
>> > > > > Nevertheless, if you report patiently the errors you have
>> reporting
>> > > > > one after we have solved the other, I will help you solve them
>> all.
>> > > > > However, I would recommend using the 3.14 kernel, chances are that
>> > > > > it is not more stable, but when upgrading, there is no reason not
>> to
>> > > > > upgrade to the latest.
>> > > > >
>> > > >
>> > > > Thanks Gilles for helping out! The reason we chose the ipipe-3.10
>> kernel
>> > > is
>> > > > because we want to merge with the Freescale L3.10.x-1.1.0 release
>> later.
>> > > > But I've tried the ipipe-3.14 release and also this version
>> unfortunately
>> > > > gives the same results.
>> > > >
>> > > > The first thing that occurs is the following ipipe dump when we are
>> > > calling
>> > > > ioremap_nocache to map some device memory into the kernel. It is in
>> the
>> > > > non-rt ioctl of an rtdm driver:
>> > > >
>> > > > I-pipe: Detected stalled head domain, probably caused by a bug.
>> > > >         A critical section may have been left unterminated.
>> > > > CPU: 0 PID: 457 Comm: LRT:457 Tainted: G        W  O
>> > > > 3.10.32-ipipe-00218-gcf143c6-dirty #96
>> > > > [<c00127d8>] (unwind_backtrace+0x0/0xf8) from [<c001108c>]
>> > > > (show_stack+0x10/0x14)
>> > > > [<c001108c>] (show_stack+0x10/0x14) from [<c0044648>]
>> > > > (add_preempt_count+0x10/0xd8)
>> > > > [<c0044648>] (add_preempt_count+0x10/0xd8) from [<c00d8f68>]
>> > > > (kmem_cache_alloc+0x24/0x11c)
>> > > > [<c00d8f68>] (kmem_cache_alloc+0x24/0x11c) from [<c00cf15c>]
>> > > > (__get_vm_area_node.isra.29+0xa0/0x114)
>> > > > [<c00cf15c>] (__get_vm_area_node.isra.29+0xa0/0x114) from
>> [<c00cfd60>]
>> > > > (get_vm_area_caller+0x40/0x48)
>> > > > [<c00cfd60>] (get_vm_area_caller+0x40/0x48) from [<c0018914>]
>> > > > (__arm_ioremap_pfn_caller+0x218/0x234)
>> > > > [<c0018914>] (__arm_ioremap_pfn_caller+0x218/0x234) from
>> [<c001899c>]
>> > > > (__arm_ioremap_caller+0x54/0x5c)
>> > > > [<c001899c>] (__arm_ioremap_caller+0x54/0x5c) from [<c00184f0>]
>> > > > (__arm_ioremap+0x18/0x1c)
>> > > > [<c00184f0>] (__arm_ioremap+0x18/0x1c) from [<bf003988>]
>> > > > (lrtdrv_irqhandler_ioctl+0x1a0/0xc40 [sigmatek_lrt])
>> > > > [<bf003988>] (lrtdrv_irqhandler_ioctl+0x1a0/0xc40 [sigmatek_lrt])
>> from
>> > > > [<bf001348>] (lrt_non_rt_ioctl_work+0x27c/0x3cc [sigmatek_lrt])
>> > > > [<bf001348>] (lrt_non_rt_ioctl_work+0x27c/0x3cc [sigmatek_lrt]) from
>> > > > [<c00a1b5c>] (__rt_dev_ioctl+0x64/0x210)
>> > > > [<c00a1b5c>] (__rt_dev_ioctl+0x64/0x210) from [<c008840c>]
>> > > > (losyscall_event+0xc0/0x230)
>> > > > [<c008840c>] (losyscall_event+0xc0/0x230) from [<c006e008>]
>> > > > (ipipe_syscall_hook+0x3c/0x40)
>> > > > [<c006e008>] (ipipe_syscall_hook+0x3c/0x40) from [<c006c7a4>]
>> > > > (__ipipe_notify_syscall+0x74/0xf4)
>> > > > [<c006c7a4>] (__ipipe_notify_syscall+0x74/0xf4) from [<c0015d78>]
>> > > > (__ipipe_syscall_root+0x70/0xe8)
>> > > > [<c0015d78>] (__ipipe_syscall_root+0x70/0xe8) from [<c000e660>]
>> > > > (local_restart+0xc/0x58)
>> > > >
>> > > > I'm not sure how to find out what is wrong here. From code-review it
>> > > seems
>> > > > sane.
>> > >
>> > > You are sure you are not calling ioremap with irqs off ?
>> > > Are you sure the current domain is Linux when calling ioremap ?
>> > >
>> >
>> > The current domain should be Linux because in the trace we see the
>> > losyscall_event and the ioctl_nrt handler which is
>> lrt_non_rt_ioctl_work.
>> > How could I verify irq's are off?
>>
>> Well, do you use rtdm_lock_get_irqsave or spin_lock_irqsave before
>> calling ioremap ?
>>
>
> Ok thanks, found an  rtdm_lock_get_irqsave in the path before calling
> ioremap. Reworking the driver code now and get back to you with results.
>

I reworked the driver now and the 'stalled head domain' is not there
anymore.
However, the other symptoms did not disappear.

I currently observe 2 symptoms:
Either 1) a stall of the i.MX timer or 2) a kernel NULL pointer dereference.

The kernel trace of the NULL pointer dereference is as below:

Unable to handle kernel NULL pointer dereference at virtual address 00000000
pgd = ce230000, hw pgd = ce230000
[00000000] *pgd=1e30d831, *pte=00000000, *ppte=00000000
Internal error: Oops: 80000007 [#1] PREEMPT ARM
Modules linked in: platform_imx(O) sigmatek_lrt(O)
CPU: 0 PID: 454 Comm: LRT:454 Tainted: G        W  O
3.10.32-ipipe-00218-gcf143c6-dirty #100
task: ce00e780 ti: ce2d8000 task.ti: ce2d8000
PC is at 0x0
LR is at __ipipe_do_sync_stage+0x1cc/0x2c8
pc : [<00000000>]    lr : [<c0083a04>]    psr: 200f0093
sp : ce2d9d10  ip : 00000000  fp : ce2d9d44
r10: 00000002  r9 : 00000016  r8 : c0aca580
r7 : 00000000  r6 : c0accb40  r5 : 00400000  r4 : 00000096
r3 : 00000000  r2 : c0a96cc0  r1 : 00000000  r0 : 00000096
Flags: nzCv  IRQs off  FIQs on  Mode SVC_32  ISA ARM  Segment user
Control: 10c53c7d  Table: 1e230059  DAC: 00000015
Process LRT:454 (pid: 454, stack limit = 0xce2d8230)
Stack: (0xce2d9d10 to 0xce2da000)
9d00:                                     c09d8a20 ce2d8000 ce2d9d44
00000062
9d20: c09c6670 00000000 00000063 c09c8a20 00000001 00300180 ce2d9d6c
ce2d9d48
9d40: c008421c c0083844 c09c6670 00000062 ce2d9db0 d0804100 00000200
00300180
9d60: ce2d9d8c ce2d9d70 c0008498 c0083ff8 00000010 d080410c c09bc6dc
ce2d9db0
9d80: ce2d9dac ce2d9d90 c0008778 c000841c c0083c94 600f0013 ffffffff
ce2d9de4
9da0: ce2d9e04 ce2d9db0 c000ea78 c0008738 80000000 00000000 00000000
600f0093
9dc0: d09fe410 c09c6670 c0adb370 00000000 00000200 00000001 00300180
ce2d9e04
9de0: ce2d9df8 ce2d9df8 c0083c90 c0083c94 600f0013 ffffffff ce2d9e54
ce2d9e08
9e00: c00b2678 c0083bfc 0000001a 00000004 ce2d9e54 ce2d9e20 00000000
00000000
9e20: 00000000 ce00e780 000011a0 d09fe410 ce2d8000 00000001 00000002
ce2d9fb0
9e40: 00002340 c09c6670 ce2d9f04 ce2d9e58 c00be570 c00b24b0 00000000
00000000
9e60: ce2d9ed4 c0adc938 c0adc960 00000001 00000000 00000000 ffffff92
00000000
9e80: ce2d9ea4 ce2d9e90 c0083da4 c0086bac 00000001 ffffff92 ce2d9ecc
ce2d9ea8
9ea0: c00d2728 c0083cac c0aca580 ce2d9fb0 ce2d8000 d0a06200 00002000
c0adc048
9ec0: ce2d9f04 ce2d9ed0 c00cb74c c00d260c 00000045 c00d54d0 00989680
00000000
9ee0: c00be750 00000000 ce00e780 0000008e c0adb368 ce2d9fb0 ce2d9f3c
ce2d9f08
9f00: c00beaa8 c00be4d0 000002b0 d09fe410 00000000 c09c7810 600f0013
0000119c
9f20: c0aca580 c0aca580 00002340 c09c6670 ce2d9f4c ce2d9f40 c0087180
c00be7f8
9f40: ce2d9f8c ce2d9f50 c00834dc c0087140 00000000 00000001 ce2d9fb0
c0aca580
9f60: c0137e00 ce00e780 00000002 ce2d9fb0 0000008e c000f318 00000000
b6f32000
9f80: ce2d9fac ce2d9f90 c0018360 c0083430 002422e8 00000000 00030c00
0000008e
9fa0: 00000000 ce2d9fb0 c000f264 c00182ec 0000000a be83db28 00000000
00000000
9fc0: 002422e8 00000000 00030c00 0000008e 00000000 00000000 b6f32000
be83dbd4
9fe0: 00000002 be83db08 b69144a8 b69144b8 600f0010 0000000a 656b0073
73755f79
[<c0083a04>] (__ipipe_do_sync_stage+0x1cc/0x2c8) from [<c008421c>]
(__ipipe_dispatch_irq+0x230/0x2e0)
[<c008421c>] (__ipipe_dispatch_irq+0x230/0x2e0) from [<c0008498>]
(__ipipe_grab_irq+0x88/0xa4)
[<c0008498>] (__ipipe_grab_irq+0x88/0xa4) from [<c0008778>]
(gic_handle_irq+0x4c/0x64)
Exception stack(0xce2d9d90 to 0xce2d9dd8)
9d80:                                     c0083c94 600f0013 ffffffff
ce2d9de4
9da0: ce2d9e04 ce2d9db0 c000ea78 c0008738 80000000 00000000 00000000
600f0093
9dc0: d09fe410 c09c6670 c0adb370 00000000 00000200 00000001
[<c0008778>] (gic_handle_irq+0x4c/0x64) from [<c000ea78>]
(__irq_svc+0x58/0x84)
Exception stack(0xce2d9db0 to 0xce2d9df8)
9da0:                                     80000000 00000000 00000000
600f0093
9dc0: d09fe410 c09c6670 c0adb370 00000000 00000200 00000001 00300180
ce2d9e04
9de0: ce2d9df8 ce2d9df8 c0083c90 c0083c94 600f0013 ffffffff
[<c000ea78>] (__irq_svc+0x58/0x84) from [<c0083c94>]
(ipipe_unstall_head+0xa4/0xb0)
[<c0083c94>] (ipipe_unstall_head+0xa4/0xb0) from [<c00b2678>]
(xnpod_suspend_thread+0x1d4/0x31c)
[<c00b2678>] (xnpod_suspend_thread+0x1d4/0x31c) from [<c00be570>]
(xnshadow_relax+0xac/0x164)
[<c00be570>] (xnshadow_relax+0xac/0x164) from [<c00beaa8>]
(hisyscall_event+0x2bc/0x33c)
[<c00beaa8>] (hisyscall_event+0x2bc/0x33c) from [<c0087180>]
(ipipe_syscall_hook+0x4c/0x50)
[<c0087180>] (ipipe_syscall_hook+0x4c/0x50) from [<c00834dc>]
(__ipipe_notify_syscall+0xb8/0x190)
[<c00834dc>] (__ipipe_notify_syscall+0xb8/0x190) from [<c0018360>]
(__ipipe_syscall_root+0x80/0x120)
[<c0018360>] (__ipipe_syscall_root+0x80/0x120) from [<c000f264>]
(local_restart+0xc/0x58)
Code: bad PC value
---[ end trace 1b75b31a2719ed1e ]---

Thanks for your help!


>
>
>> Otherwise enable the I-pipe tracer, and cause a trace freeze instead
>> of the debug message.
>>
>> --
>>                                             Gilles.
>>
>
>
