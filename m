MIME-Version: 1.0
References: <CAAjAsizNnLcRo4iuosFNerdzb0jiWHHV9ZMrumgQq-Femr92LQ@mail.gmail.com>
 <405eb559-282b-795e-85e7-bf81992d1412@xenomai.org>
 <CAAjAsiw5kov2XD0yndwzQmBVWofNyPm8f6M90SbZHMWz1cmtig@mail.gmail.com>
 <a43c788c-b8bb-3f31-52d6-2a30eadc2b22@siemens.com>
In-Reply-To: <a43c788c-b8bb-3f31-52d6-2a30eadc2b22@siemens.com>
From: Matteo Facchinetti <matteo.facchinetti@sirius-es.it>
Date: Thu, 18 Jun 2020 23:10:56 +0200
Message-ID: <CAAjAsizPCUAMTh_mwykgavKiBz7KFcjkpgPNOHL_h+jJaxraXQ@mail.gmail.com>
Subject: Re: rtdm_munmap() kernel panic on 4.9.x
Content-Type: text/plain; charset="UTF-8"
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: Philippe Gerum <rpm@xenomai.org>, xenomai@xenomai.org

Il giorno mar 16 giu 2020 alle ore 12:52 Jan Kiszka <jan.kiszka@siemens.com>
ha scritto:

> On 16.06.20 11:59, Matteo Facchinetti via Xenomai wrote:
> > Il giorno ven 12 giu 2020 alle ore 21:55 Philippe Gerum <rpm@xenomai.org
> >
> > ha scritto:
> >
> >> On 6/12/20 11:52 AM, Matteo Facchinetti via Xenomai wrote:
> >>> Hi,
> >>>
> >>> I have a problem on a kernel module that provide a remapped memory to a
> >>> userspace process.
> >>> In detail I'm using a kernel 4.9 with ipipe-core-4.9.51-arm-4.patch on
> a
> >>> beaglebone like board and problem occurs when I close the program that
> >> use
> >>> this module.
> >>> In the module close() I call the rtdm_munmap() to free remapped memory
> >> but
> >>> a kernel panic occurs when program is killed or exited.
> >>>
> >>> [<c0933b0c>] (down_write_killable) from [<c0264000>]
> >> (vm_munmap+0x3c/0x6c)
> >>> [<c0264000>] (vm_munmap) from [<c020eb58>] (rtdm_munmap+0x18/0x1c)
> >>> [<c020eb58>] (rtdm_munmap) from [<bf067728>]
> >> (canopen_sync_close+0x60/0xdc
> >>> [canopen_sync])
> >>> [<bf067728>] (canopen_sync_close [canopen_sync]) from [<c020c320>]
> >>> (__rtdm_dev_close+0x3c/0x58)
> >>> [<c020c320>] (__rtdm_dev_close) from [<c020f4b4>] (__put_fd+0xa4/0x120)
> >>> [<c020f4b4>] (__put_fd) from [<c0210174>] (destroy_fd+0x44/0x54)
> >>> [<c0210174>] (destroy_fd) from [<c0209140>] (xntree_cleanup+0x44/0x4c)
> >>> [<c0209140>] (xntree_cleanup) from [<c0210e50>]
> >> (rtdm_fd_cleanup+0x24/0x2c)
> >>> [<c0210e50>] (rtdm_fd_cleanup) from [<c021a4cc>]
> >>> (cobalt_process_detach+0xac/0x13c)
> >>> [<c021a4cc>] (cobalt_process_detach) from [<c021a39c>]
> >>> (remove_process+0xa4/0x108)
> >>> [<c021a39c>] (remove_process) from [<c021b400>]
> >>> (ipipe_kevent_hook+0x3b0/0x4c8)
> >>> [<c021b400>] (ipipe_kevent_hook) from [<c01bb33c>]
> >>> (__ipipe_notify_kevent+0x3c/0x7c)
> >>> [<c01bb33c>] (__ipipe_notify_kevent) from [<c012b8c0>]
> (mmput+0x54/0x124)
> >>> [<c012b8c0>] (mmput) from [<c01317c8>] (do_exit+0x39c/0xa08)
> >>> [<c01317c8>] (do_exit) from [<c0131ee4>] (do_group_exit+0x64/0x10c)
> >>> [<c0131ee4>] (do_group_exit) from [<c013d080>] (get_signal+0x338/0x8cc)
> >>> [<c013d080>] (get_signal) from [<c010afd0>] (do_signal+0x84/0x414)
> >>> [<c010afd0>] (do_signal) from [<c010b524>] (do_work_pending+0x90/0xf8)
> >>> [<c010b524>] (do_work_pending) from [<c0107b80>]
> >>> (slow_work_pending+0xc/0x20)
> >>
> >> Calling rtdm_munmap() from a RTDM fd close() handler won't work
> reliably.
> >> rtdm_munmap() must be called in the context of an active thread in
> order to
> >> forcibly drop a mapping from its address space, undoing what a
> rtdm_mmap*
> >> helper did upon request from a thread belonging to the same address
> space
> >> via
> >> some ioctl() handler.
> >>
> >> This stack frame shows that the close() handler in your driver was
> actually
> >> called by the process cleanup code, as a result of dropping the last
> memory
> >> mapping still attached to the process.
> >>
> >> As part of this cleanup, Cobalt would then find a lingering fd for the
> >> exiting
> >> process into its file table, invoke the close handler to shut it down,
> then
> >> rtdm_munmap() would be called for the mapping created by the driver.
> >> Problem
> >> is that such mapping was already dismantled by the kernel prior to the
> >> initial
> >> cleanup call, leading to havoc. Incidentally, you would not have seen
> the
> >> issue would such fd had been closed by the application before exiting,
> >> which
> >> would have papered over the issue.
> >>
> >> OK, understood!
> > This is also the reason because I didn't see this problem in my driver
> test
> > case.
> >
> > This driver is a porting from Xenomai 2.6 and in this version
> rtdm_munmap()
> > in close() works properly.
> > For this reason, I wrongly thought of a problem.
> >
> >
> >
> >> The solution is simply to remove the rtdm_unmap() call from your close()
> >> handler in the driver. Every mapping created by some rtdm_mmap*() call
> is
> >> automatically dropped by the kernel when the process exits.
> >>
> >> I'm agree. Thanks.
> > I also add a newer ioctl to manually unmap this memory region in the case
> > that I want to close and reopen the driver in this program.
> > So application lifecycle when use this driver is:
> > open()
> > ioctl map()
> > ioctl unmap()
> > close()
>
> You can do unmap in close, that is not the problem (so the explicit
> ioctl is not needed - but also not harmfull). The problem is that, when
> a cleanup triggered the unmap already, you must not do it twice.
>
>
Exactly, the real problem is this.
I've debugged the lifecycle of close() in the rtdm driver...

In detail in the rtdm_munmap() function there's a calls to vm_munmap() for
unmap entire block memory
but vm_munmap() could be called only if current->mm is different than NULL
because depend from the user context.

When rtdm_close() is called by the kernel as result of a ctrl-C,
current->mm is NULL and vm_munmap crash in kernel panic.

So in my close driver function:

struct mm_struct    *mm = current->mm;
...
if (mm)
    rtdm_munmap(c->mmap_useraddr, sizeof(mmap_t));
...

However, I have a doubt...
What do you think about the possibility to add this condition inside the
rtdm_munmap() to protect the vm_munmap()?

Matteo


Jan
>
> --
> Siemens AG, Corporate Technology, CT RDA IOT SES-DE
> Corporate Competence Center Embedded Linux
>
