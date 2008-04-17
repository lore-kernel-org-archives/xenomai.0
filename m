Message-ID: <2ff1a98a0804170307v53ec52a6p553d2f93cd72e643@domain.hid>
Date: Thu, 17 Apr 2008 12:07:05 +0200
From: "Gilles Chanteperdrix" <gilles.chanteperdrix@xenomai.org>
In-Reply-To: <a7575bba0804170215k2999fadcn8de7a4e0bf87c64e@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <a7575bba0804150405iec3cc82ia823f010f034a671@domain.hid>
	<a7575bba0804170215k2999fadcn8de7a4e0bf87c64e@domain.hid>
Subject: Re: [Xenomai-core] About Xenomai questions
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Josh Zhao <joshsystem@domain.hid>
Cc: xenomai@xenomai.org

On Thu, Apr 17, 2008 at 11:15 AM, Josh Zhao <joshsystem@domain.hid> wrote:
>
>
> Hi ,
>   After reading Xenomai code, I have some questions:

This is the wrong list to ask them. This answer is the last I will
make to you on this list for Xenomai questions.

>   1.    usespace--> rt_task_create  -->pthread_create-->__native_task_create
>       So why xenomai use pthread  to invoke __native_task_create ?

pthread_create creates a Linux thread, __native_task_create creates
the Xenomai thread (sometimes called shadow thread) associated with
Linux thread. The association happens in xnshadow_map.

>
>    2.   usespace-->rt_task_start(RT_TASK *task, void (*entry) (void
> *cookie), void *cookie)-->
>    kernel space --> __rt_task_start(struct task_struct *curr, struct pt_regs
> *regs)-->
> rt_task_start(task,
>                   (void (*)(void *))__xn_reg_arg2(regs),
>                  (void *)__xn_reg_arg3(regs));
>
>
>      I can't understand that the entry paramter is address of function in
> user space ,why it can be passed into kernel space by syscall?

Well... why not ? It is not used in kernel-space, but passed again to
user-space by xnshadow_wait_barrier.

>
> 3.   the xnthread_t struct and  pod  sechedule algorithm looks very complex,
> is there any papers taking about it?

Every member of the xnthread_t structure is commented in
include/nucleus/thread.h. The pod schedule algorithm is not that
complicated: the scheduler priority queue is maintained by other
functions (essentially xnpod_suspend and xnpod_resume), xnpod_schedule
extracts the higher priority thread that is ready for the longest time
and compares it with the current thread. If they are different, it
switches to this new thread. That's all. I find xnpod_suspend for
instance much more complicated.

-- 
 Gilles

