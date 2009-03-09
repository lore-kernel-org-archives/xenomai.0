Message-ID: <49B54B88.8030008@domain.hid>
Date: Mon, 09 Mar 2009 18:02:00 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <49B3A126.6000602@domain.hid> <49B53AC3.10707@domain.hid>
	<49B54780.6040504@domain.hid>
In-Reply-To: <49B54780.6040504@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] Watchdog / immediate Linux signal delivery
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
Cc: xenomai-core <xenomai@xenomai.org>

Jan Kiszka wrote:
> Philippe Gerum wrote:
>> Jan Kiszka wrote:
>>> the watchdog strikes. The second one brought me to another issue: Raise
>>> SIGKILL for the current thread and make sure that it can be processed by
>>> Linux (e.g. via xnpod_suspend_thread(<cpu-hog>). Unfortunately, there is
>>> no way to force a shadow thread into secondary mode to handle pending
>>> Linux signals unless that thread issues a syscall once in a while. And
>>> that raises the question if we shouldn't improve this as well while we
>>> are on it.
>>>
>>> Granted, non-broken Xenomai user space threads always issue frequent
>>> syscalls, otherwise the system would starve (and the watchdog would come
>>> around). On the other hand, delaying signals till syscall prologues is
>>> different from plain Linux behaviour...
>>>
>>> Comments, ideas?
>>>
>> We probably need a two-stage approach: first record the thread was bumped out 
>> and suspend it from the watchdog handler to give Linux a chance to run again, 
>> then finish the work, killing it for good, next time the root thread is 
>> scheduled in on the same CPU.
> 
> That confuses me again: The watchdog issue is solved now, no? We are
> only left with the scenario of breaking out of a user space loop of some
> Xenomai thread via a Linux signal (which implies SMP - otherwise there
> is no chance to raise the signal...).
> 
> Meanwhile I played with some light-weight approach to relax a thread
> that received a signal (according to do_sigwake_event). Worked, but only
> once due to a limitation (if not bug) of I-pipe x86: in __ipipe_run_isr,
> it does not handle the case that a non-root handler may alter the
> current domain, causing corruptions to the IPIPE_SYNC_FLAG states of the
> involved domains. Will try to fix this and post my signaling proposal so
> that this work is not lost.

If we go that way, I would vote for a SIGSEGV instead of the SIGKILL.
This would allow to install a handler to dump the backtrace, or even gdb
to be stopped at the point of the infinite loop, and a SIGSEGV handler
is not expected to recover (well, except in cases of implementation of
COW in user-space, but that does not fit well with real-time threads).

-- 
                                                 Gilles.

