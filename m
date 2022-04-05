References: <20220405114052.7385-1-richard@nod.at>
From: Philippe Gerum <rpm@xenomai.org>
Subject: Re: [PATCH] xnthread_relax: Make sure wakework irq work has a stack
Date: Tue, 05 Apr 2022 18:59:33 +0200
In-reply-to: <20220405114052.7385-1-richard@nod.at>
Message-ID: <878rsj2zkr.fsf@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Richard Weinberger <richard@nod.at>
Cc: xenomai@xenomai.org


Richard Weinberger via Xenomai <xenomai@xenomai.org> writes:

> While testing some workload the following KASAN splat arose.
> irq_work_single+0x70/0x80 is the last line of irq_work_single():
> (void)atomic_cmpxchg(&work->node.a_flags, flags, flags & ~IRQ_WORK_BUSY);
>
> So, writing to &work->node.a_flags failed.
> atomic_read() and atomic_set() right before work->func(work) didn't
> trigger KASAN. This means the memory location behind &work vanished
> while the work function ran.
>
> After taking a brief look for irq work users in Xenomai, I found that
> xnthread_relax() posts irq work via pipeline_post_inband_work(&wakework);
> where wakework in on the stack.
> To my best knowledge it is not guaranteed that xnthread_relax() will
> stay around until the irq work has finished.
>

If the task calling xnthread_relax() stays on same CPU during the whole
process, I believe this is ok:

- irq_work() queues the request to the local CPU, i.e. where the thread
  calling xnthread_relax() currently runs. The later suspends from the
  Cobalt scheduler, waits for the irq_work handler to wake it up.

- irq_work() runs in (hard) interrupt context on the in-band stage, so
  it is free from preemption by any in-band task on the same CPU, which
  the caller of xnthread_relax() is now, after a successful oob ->
  in-band stage switch. Also, irq_work() uses a synthetic IRQ, and this
  type of interrupt cannot be threaded, so there is no surprise to
  expect from that dept.

> This can explain the KASAN splat. xnthread_relax() returned while
> the irq work was still busy.
>
> To fix the problem, add a new helper, pipeline_sync_inband_work(),
> which will synchronize against the posted irq work and ensures
> that the work is done when xnthread_relax() is about to return.
>
> On the other hand, on ipipe does suffer from this problem because
> ipipe has it's own irq work mechanism which takes a copy of the
> work struct before processing it asynchronously.
>
> BUG: KASAN: stack-out-of-bounds in irq_work_single+0x70/0x80
> Write of size 4 at addr ffff88802f067d48 by task cobalt_printf/1421

What bothers me is that cobalt_printf is not a Xenomai thread, this is a
plain POSIX thread. So we cannot be observing the tail code from a stage
switch to in-band for that thread. The only explanation I could come up
with is that a relaxed thread is migrated to a different CPU at wake up
from the one which triggered the irq_work() call, in which case we might
have enough concurrency to see these fireworks.

Normally, a Xenomai thread runs on a single CPU, but this rule might be
broken by an explicit user action though. Is there any Xenomai thread
with more than one CPU in its affinity set for this test?

PS: I agree that moving the request descriptor to the thread control
block is the safest option (the evl core dropped all stack-based request
descriptors, this is a no brainer, tends to enable cleanup work in the
code, and simplifies the overall logic). We are talking about a few
bytes, and this would save the irq_work init chores we currently have to
do at each relax call. Besides, a stack-based descriptor for the relax
path is always going to be sensitive to a CPU migration which might
cause havoc.

-- 
Philippe.

