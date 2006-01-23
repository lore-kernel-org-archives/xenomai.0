From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Subject: Re: [Xenomai-core] [BUG] racy xnshadow_harden under CONFIG_PREEMPT
In-Reply-To: <fd6a47a90601220819n3f4cd382t@domain.hid>
References: <43D21144.8040005@domain.hid>
	<b647ffbd0601220010x3cc023an@domain.hid>
	<fd6a47a90601220819n3f4cd382t@domain.hid>
Message-Id: <E1F16LA-0001ku-C4@domain.hid>
Date: Mon, 23 Jan 2006 19:22:56 +0100
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Jeroen Van den Keybus <jeroen.vandenkeybus@domain.hid>
Cc: Jan Kiszka <jan.kiszka@domain.hid>, xenomai@xenomai.org

Jeroen Van den Keybus wrote:
 > Hello,
 > 
 > 
 > I'm currently not at a level to participate in your discussion. Although I'm
 > willing to supply you with stresstests, I would nevertheless like to learn
 > more from task migration as this debugging session proceeds. In order to do
 > so, please confirm the following statements or indicate where I went wrong.
 > I hope others may learn from this as well.
 > 
 > xn_shadow_harden(): This is called whenever a Xenomai thread performs a
 > Linux (root domain) system call (notified by Adeos ?). 

xnshadow_harden() is called whenever a thread running in secondary
mode (that is, running as a regular Linux thread, handled by Linux
scheduler) is switching to primary mode (where it will run as a Xenomai
thread, handled by Xenomai scheduler). Migrations occur for some system
calls. More precisely, Xenomai skin system calls tables associates a few
flags with each system call, and some of these flags cause migration of
the caller when it issues the system call.

Each Xenomai user-space thread has two contexts, a regular Linux
thread context, and a Xenomai thread called "shadow" thread. Both
contexts share the same stack and program counter, so that at any time,
at least one of the two contexts is seen as suspended by the scheduler
which handles it.

Before xnshadow_harden is called, the Linux thread is running, and its
shadow is seen in suspended state with XNRELAX bit by Xenomai
scheduler. After xnshadow_harden, the Linux context is seen suspended
with INTERRUPTIBLE state by Linux scheduler, and its shadow is seen as
running by Xenomai scheduler.

The migrating thread
 > (nRT) is marked INTERRUPTIBLE and run by the Linux kernel
 > wake_up_interruptible_sync() call. Is this thread actually run or does it
 > merely put the thread in some Linux to-do list (I assumed the first case) ?

Here, I am not sure, but it seems that when calling
wake_up_interruptible_sync the woken up task is put in the current CPU
runqueue, and this task (i.e. the gatekeeper), will not run until the
current thread (i.e. the thread running xnshadow_harden) marks itself as
suspended and calls schedule(). Maybe, marking the running thread as
suspended is not needed, since the gatekeeper may have a high priority,
and calling schedule() is enough. In any case, the waken up thread does
not seem to be run immediately, so this rather look like the second
case.

Since in xnshadow_harden, the running thread marks itself as suspended
before running wake_up_interruptible_sync, the gatekeeper will run when
schedule() get called, which in turn, depend on the CONFIG_PREEMPT*
configuration. In the non-preempt case, the current thread will be
suspended and the gatekeeper will run when schedule() is explicitely
called in xnshadow_harden(). In the preempt case, schedule gets called
when the outermost spinlock is unlocked in wake_up_interruptible_sync().

 > And how does it terminate: is only the system call migrated or is the thread
 > allowed to continue run (at a priority level equal to the Xenomai
 > priority level) until it hits something of the Xenomai API (or trivially:
 > explicitly go to RT using the API) ? 

I am not sure I follow you here. The usual case is that the thread will
remain in primary mode after the system call, but I think a system call
flag allow the other behaviour. So, if I understand the question
correctly, the answer is that it depends on the system call.

 > In that case, I expect the nRT thread to terminate with a schedule()
 > call in the Xeno OS API code which deactivates the task so that it
 > won't ever run in Linux context anymore. A top priority gatekeeper is
 > in place as a software hook to catch Linux's attention right after
 > that schedule(), which might otherwise schedule something else (and
 > leave only interrupts for Xenomai to come back to life again).

Here is the way I understand it. We have two threads, or rather two
"views" of the same thread, with each its state. Switching from
secondary to primary mode, i.e. xnshadow_harden and gatekeeper job,
means changing the two states at once. Since we can not do that, we need
an intermediate state. Since the intermediate state can not be the state
where the two threads are running (they share the same stack and
program counter), the intermediate state is a state where the two
threads are suspended, but another context needs running, it is the
gatekeeper.

 >  I have
 > the impression that I cannot see this gatekeeper, nor the (n)RT
 > threads using the ps command ?

The gatekeeper and Xenomai user-space threads are regular Linux
contexts, you can seen them using the ps command.

 > 
 > Is it correct to state that the current preemption issue is due to the
 > gatekeeper being invoked too soon ? Could someone knowing more about the
 > migration technology explain what exactly goes wrong ?

Jan seems to have found such an issue here. I am not sure I understood
what he wrote. But if the issue is due to CONFIG_PREEMPT, it explains
why I could not observe the bug, I only have the "voluntary preempt"
option enabled.

I will now try and activate CONFIG_PREEMPT, so as to try and understand
what Jan wrote, and tell you more later.

-- 


					    Gilles Chanteperdrix.

