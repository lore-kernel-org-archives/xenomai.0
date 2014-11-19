MIME-Version: 1.0
In-Reply-To: <20141119094137.GA25848@sisyphus.hd.free.fr>
References: <CANKLDmv=sSdgO9R6cVj6VoT1MpvswS3h=W8sKpaykFaeiv0-aQ@mail.gmail.com>
 <20141119090249.GA24219@sisyphus.hd.free.fr>
 <CANKLDmuqm9F3OvPvX=6zj87rxNLqgK++19O1LAOJQj54-u4TwA@mail.gmail.com>
 <20141119094137.GA25848@sisyphus.hd.free.fr>
Date: Wed, 19 Nov 2014 10:52:04 +0100
Message-ID: <CANKLDmu2YU30PBhN2So_5rziitxPf9qjs0H-Y6cJTFq+jAt_ng@mail.gmail.com>
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

On Wed, Nov 19, 2014 at 10:41 AM, Gilles Chanteperdrix <
gilles.chanteperdrix@xenomai.org> wrote:

> On Wed, Nov 19, 2014 at 10:37:53AM +0100, Henri Roosen wrote:
> > On Wed, Nov 19, 2014 at 10:02 AM, Gilles Chanteperdrix <
> > gilles.chanteperdrix@xenomai.org> wrote:
> >
> > > On Wed, Nov 19, 2014 at 09:45:26AM +0100, Henri Roosen wrote:
> > > > Hi,
> > > >
> > > > We are currently transitioning our i.MX6 systems from kernel
> > > > ipipe-3.0-imx6q with Xenomai 2.6.2.1 to kernel ipipe-3.10 with
> Xenomai
> > > > 2.6.4.
> > > >
> > > > The application uses interrupts from external hardware, fed into the
> > > system
> > > > by a GPIO pin interrupt.
> > > >
> > > > The system behaves very in-stable with the 3.10 version. I observe
> kernel
> > > > crashes, kernel null pointer dereferences, timer stalls and lock-ups
> at
> > > > various different places. The 3.0 version runs fine.
> > > >
> > > > Are there any known issues like this with the ipipe-3.10 on an i.MX6?
> > > > Any suggestions how to tackle this problem?
> > >
> > > Basically, as I explained yesterday, SOCs in the mainline I-pipe
> > > patch for which I have no hardware are only build-tested. The I-pipe
> > > patch for 3.0 is better maintained, because I have feedback from its
> > > users.
> > >
> > > Nevertheless, if you report patiently the errors you have reporting
> > > one after we have solved the other, I will help you solve them all.
> > > However, I would recommend using the 3.14 kernel, chances are that
> > > it is not more stable, but when upgrading, there is no reason not to
> > > upgrade to the latest.
> > >
> >
> > Thanks Gilles for helping out! The reason we chose the ipipe-3.10 kernel
> is
> > because we want to merge with the Freescale L3.10.x-1.1.0 release later.
> > But I've tried the ipipe-3.14 release and also this version unfortunately
> > gives the same results.
> >
> > The first thing that occurs is the following ipipe dump when we are
> calling
> > ioremap_nocache to map some device memory into the kernel. It is in the
> > non-rt ioctl of an rtdm driver:
> >
> > I-pipe: Detected stalled head domain, probably caused by a bug.
> >         A critical section may have been left unterminated.
> > CPU: 0 PID: 457 Comm: LRT:457 Tainted: G        W  O
> > 3.10.32-ipipe-00218-gcf143c6-dirty #96
> > [<c00127d8>] (unwind_backtrace+0x0/0xf8) from [<c001108c>]
> > (show_stack+0x10/0x14)
> > [<c001108c>] (show_stack+0x10/0x14) from [<c0044648>]
> > (add_preempt_count+0x10/0xd8)
> > [<c0044648>] (add_preempt_count+0x10/0xd8) from [<c00d8f68>]
> > (kmem_cache_alloc+0x24/0x11c)
> > [<c00d8f68>] (kmem_cache_alloc+0x24/0x11c) from [<c00cf15c>]
> > (__get_vm_area_node.isra.29+0xa0/0x114)
> > [<c00cf15c>] (__get_vm_area_node.isra.29+0xa0/0x114) from [<c00cfd60>]
> > (get_vm_area_caller+0x40/0x48)
> > [<c00cfd60>] (get_vm_area_caller+0x40/0x48) from [<c0018914>]
> > (__arm_ioremap_pfn_caller+0x218/0x234)
> > [<c0018914>] (__arm_ioremap_pfn_caller+0x218/0x234) from [<c001899c>]
> > (__arm_ioremap_caller+0x54/0x5c)
> > [<c001899c>] (__arm_ioremap_caller+0x54/0x5c) from [<c00184f0>]
> > (__arm_ioremap+0x18/0x1c)
> > [<c00184f0>] (__arm_ioremap+0x18/0x1c) from [<bf003988>]
> > (lrtdrv_irqhandler_ioctl+0x1a0/0xc40 [sigmatek_lrt])
> > [<bf003988>] (lrtdrv_irqhandler_ioctl+0x1a0/0xc40 [sigmatek_lrt]) from
> > [<bf001348>] (lrt_non_rt_ioctl_work+0x27c/0x3cc [sigmatek_lrt])
> > [<bf001348>] (lrt_non_rt_ioctl_work+0x27c/0x3cc [sigmatek_lrt]) from
> > [<c00a1b5c>] (__rt_dev_ioctl+0x64/0x210)
> > [<c00a1b5c>] (__rt_dev_ioctl+0x64/0x210) from [<c008840c>]
> > (losyscall_event+0xc0/0x230)
> > [<c008840c>] (losyscall_event+0xc0/0x230) from [<c006e008>]
> > (ipipe_syscall_hook+0x3c/0x40)
> > [<c006e008>] (ipipe_syscall_hook+0x3c/0x40) from [<c006c7a4>]
> > (__ipipe_notify_syscall+0x74/0xf4)
> > [<c006c7a4>] (__ipipe_notify_syscall+0x74/0xf4) from [<c0015d78>]
> > (__ipipe_syscall_root+0x70/0xe8)
> > [<c0015d78>] (__ipipe_syscall_root+0x70/0xe8) from [<c000e660>]
> > (local_restart+0xc/0x58)
> >
> > I'm not sure how to find out what is wrong here. From code-review it
> seems
> > sane.
>
> You are sure you are not calling ioremap with irqs off ?
> Are you sure the current domain is Linux when calling ioremap ?
>

The current domain should be Linux because in the trace we see the
losyscall_event and the ioctl_nrt handler which is lrt_non_rt_ioctl_work.
How could I verify irq's are off?


> --
>                                             Gilles.
>
