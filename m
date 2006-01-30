Message-ID: <43DE27E5.3010206@domain.hid>
Date: Mon, 30 Jan 2006 15:51:17 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] [BUG] racy xnshadow_harden under CONFIG_PREEMPT
References: <43D21144.8040005@domain.hid>	<b647ffbd0601220010x3cc023an@domain.hid>	<fd6a47a90601220819n3f4cd382t@domain.hid>	<E1F16LA-0001ku-C4@domain.hid>
	<43D52BA3.6020005@domain.hid>
In-Reply-To: <43D52BA3.6020005@domain.hid>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: xenomai@xenomai.org

Jan Kiszka wrote:
> Gilles Chanteperdrix wrote:
> 
>>Jeroen Van den Keybus wrote:
>> > Hello,
>> > 
>> > 
>> > I'm currently not at a level to participate in your discussion. Although I'm
>> > willing to supply you with stresstests, I would nevertheless like to learn
>> > more from task migration as this debugging session proceeds. In order to do
>> > so, please confirm the following statements or indicate where I went wrong.
>> > I hope others may learn from this as well.
>> > 
>> > xn_shadow_harden(): This is called whenever a Xenomai thread performs a
>> > Linux (root domain) system call (notified by Adeos ?). 
>>
>>xnshadow_harden() is called whenever a thread running in secondary
>>mode (that is, running as a regular Linux thread, handled by Linux
>>scheduler) is switching to primary mode (where it will run as a Xenomai
>>thread, handled by Xenomai scheduler). Migrations occur for some system
>>calls. More precisely, Xenomai skin system calls tables associates a few
>>flags with each system call, and some of these flags cause migration of
>>the caller when it issues the system call.
>>
>>Each Xenomai user-space thread has two contexts, a regular Linux
>>thread context, and a Xenomai thread called "shadow" thread. Both
>>contexts share the same stack and program counter, so that at any time,
>>at least one of the two contexts is seen as suspended by the scheduler
>>which handles it.
>>
>>Before xnshadow_harden is called, the Linux thread is running, and its
>>shadow is seen in suspended state with XNRELAX bit by Xenomai
>>scheduler. After xnshadow_harden, the Linux context is seen suspended
>>with INTERRUPTIBLE state by Linux scheduler, and its shadow is seen as
>>running by Xenomai scheduler.
>>
>>The migrating thread
>> > (nRT) is marked INTERRUPTIBLE and run by the Linux kernel
>> > wake_up_interruptible_sync() call. Is this thread actually run or does it
>> > merely put the thread in some Linux to-do list (I assumed the first case) ?
>>
>>Here, I am not sure, but it seems that when calling
>>wake_up_interruptible_sync the woken up task is put in the current CPU
>>runqueue, and this task (i.e. the gatekeeper), will not run until the
>>current thread (i.e. the thread running xnshadow_harden) marks itself as
>>suspended and calls schedule(). Maybe, marking the running thread as
> 
> 
> Depends on CONFIG_PREEMPT. If set, we get a preempt_schedule already
> here - and a switch if the prio of the woken up task is higher.
> 
> BTW, an easy way to enforce the current trouble is to remove the "_sync"
> from wake_up_interruptible. As I understand it this _sync is just an
> optimisation hint for Linux to avoid needless scheduler runs.
> 

You could not guarantee the following execution sequence doing so either, i.e.

1- current wakes up the gatekeeper
2- current goes sleeping to exit the Linux runqueue in schedule()
3- the gatekeeper resumes the shadow-side of the old current

The point is all about making 100% sure that current is going to be unlinked from 
the Linux runqueue before the gatekeeper processes the resumption request, 
whatever event the kernel is processing asynchronously in the meantime. This is 
the reason why, as you already noticed, preempt_schedule_irq() nicely breaks our 
toy by stealing the CPU from the hardening thread whilst keeping it linked to the 
runqueue: upon return from such preemption, the gatekeeper might have run already, 
  hence the newly hardened thread ends up being seen as runnable by both the Linux 
and Xeno schedulers. Rainy day indeed.

We could rely on giving "current" the highest SCHED_FIFO priority in 
xnshadow_harden() before waking up the gk, until the gk eventually promotes it to 
the Xenomai scheduling mode and downgrades this priority back to normal, but we 
would pay additional latencies induced by each aborted rescheduling attempt that 
may occur during the atomic path we want to enforce.

The other way is to make sure that no in-kernel preemption of the hardening task 
could occur after step 1) and until step 2) is performed, given that we cannot 
currently call schedule() with interrupts or preemption off. I'm on it.

> 
>>suspended is not needed, since the gatekeeper may have a high priority,
>>and calling schedule() is enough. In any case, the waken up thread does
>>not seem to be run immediately, so this rather look like the second
>>case.
>>
>>Since in xnshadow_harden, the running thread marks itself as suspended
>>before running wake_up_interruptible_sync, the gatekeeper will run when
>>schedule() get called, which in turn, depend on the CONFIG_PREEMPT*
>>configuration. In the non-preempt case, the current thread will be
>>suspended and the gatekeeper will run when schedule() is explicitely
>>called in xnshadow_harden(). In the preempt case, schedule gets called
>>when the outermost spinlock is unlocked in wake_up_interruptible_sync().
>>
>> > And how does it terminate: is only the system call migrated or is the thread
>> > allowed to continue run (at a priority level equal to the Xenomai
>> > priority level) until it hits something of the Xenomai API (or trivially:
>> > explicitly go to RT using the API) ? 
>>
>>I am not sure I follow you here. The usual case is that the thread will
>>remain in primary mode after the system call, but I think a system call
>>flag allow the other behaviour. So, if I understand the question
>>correctly, the answer is that it depends on the system call.
>>
>> > In that case, I expect the nRT thread to terminate with a schedule()
>> > call in the Xeno OS API code which deactivates the task so that it
>> > won't ever run in Linux context anymore. A top priority gatekeeper is
>> > in place as a software hook to catch Linux's attention right after
>> > that schedule(), which might otherwise schedule something else (and
>> > leave only interrupts for Xenomai to come back to life again).
>>
>>Here is the way I understand it. We have two threads, or rather two
>>"views" of the same thread, with each its state. Switching from
>>secondary to primary mode, i.e. xnshadow_harden and gatekeeper job,
>>means changing the two states at once. Since we can not do that, we need
>>an intermediate state. Since the intermediate state can not be the state
>>where the two threads are running (they share the same stack and
>>program counter), the intermediate state is a state where the two
>>threads are suspended, but another context needs running, it is the
>>gatekeeper.
>>
>> >  I have
>> > the impression that I cannot see this gatekeeper, nor the (n)RT
>> > threads using the ps command ?
>>
>>The gatekeeper and Xenomai user-space threads are regular Linux
>>contexts, you can seen them using the ps command.
>>
>> > 
>> > Is it correct to state that the current preemption issue is due to the
>> > gatekeeper being invoked too soon ? Could someone knowing more about the
>> > migration technology explain what exactly goes wrong ?
>>
>>Jan seems to have found such an issue here. I am not sure I understood
>>what he wrote. But if the issue is due to CONFIG_PREEMPT, it explains
>>why I could not observe the bug, I only have the "voluntary preempt"
>>option enabled.
>>
>>I will now try and activate CONFIG_PREEMPT, so as to try and understand
>>what Jan wrote, and tell you more later.
>>
> 
> 
> Hardly anyone understands me, it's so sad... ;(
> 
> Jan
> 
> 
> 
> ------------------------------------------------------------------------
> 
> _______________________________________________
> Xenomai-core mailing list
> Xenomai-core@domain.hid
> https://mail.gna.org/listinfo/xenomai-core


-- 

Philippe.

