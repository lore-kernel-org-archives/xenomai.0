References: <558579E2.9070507@web.de>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <559B9B77.3020409@xenomai.org>
Date: Tue, 7 Jul 2015 11:27:19 +0200
MIME-Version: 1.0
In-Reply-To: <558579E2.9070507@web.de>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Mayday issues again
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Jan Kiszka <jan.kiszka@web.de>
Cc: Xenomai <xenomai@xenomai.org>


Hi Jan,

On 06/20/2015 04:34 PM, Jan Kiszka wrote:
> Hi Philippe,
> 
> the mayday mechanism is causing troubles to me again.
> 
> First of all, there is a bug /wrt restarting the mayday syscall. We
> current don't restart on pending signals, thus destroy the register of
> the interrupted thread that contains the syscall return code. See my
> for-forge branch for a fix proposal.
> 
> But actually I would like to get rid of the syscall trampoline
> completely if somehow possible, at least for certain archs. The reason
> is that it ruins debuggability. If a RT thread is stopped by gdb with
> the help of the mayday mechanism, it ends up waiting for resumption on
> the mayday page. Even worse, backtracing is broken, at least on x86.
> 
> That brings me to the key question: why do we need the syscall
> trampoline? We set TIP_MAYDAY in the target task, the task causes
> IPIPE_TRAP_MAYDAY to be reported via the trap hook, the hook sets the
> trampoline code, the trampoline triggers the syscall, and only on
> syscall return, we finally migrate the task to Linux. What prevents
> doing the migration already in the trap hook, ie. in
> handle_mayday_event? The pattern seems similar to the migration we
> trigger on userspace faults. And it seems to works, at least for x86,
> and doesn't have the unwanted side effects.
> 
> The background of this work is improving gdb support, in particular
> deterministic stopping and resuming of multi-threaded RT processes. I'm
> still in the design & prototype phase, RFC patches will follow later.
> 

Ok, I had to think about it and do some testing, now I see a general
flaw in this direct relax approach, and some arch-specific readblock too:

- we want the target thread to relax from a safe and sane location. What
about the IRQ context which signals the mayday event preempting, e.g.
xnthread_relax() prologue, or any kernel code supposed to run in primary
mode only? We would have xnthread_relax() stacking over that context,
this wouldn't be pretty. Redirecting the target thread by fixing up the
interrupt frame gives such guarantee, by making sure that it will relax
on a regular user->kernel syscall transition asap, which is inherently safe.

- the direct relax over the mayday trap handler can't work by design on
blackfin, due to the requirement of delaying the rescheduling procedure
until the outer interrupt context is about to unwind. So if a mayday
event is generated in a nested interrupt context, xnthread_relax() will
fail to suspend the current thread immediately, delaying the operation
(kernel/cobalt/arch/blackfin/thread.c, xnarch_escalate()) which is
definitely not acceptable for relaxing. Granted, we might have a
"generic" mayday implementation living side-by-side with arch-specific
ones like blackfin's, but that would not solve the major issue above anyway.

I tested the patch on ARM. Enabling IPIPE_DEBUG_INTERNAL there reveals a
bug with the mayday handler now turning hw IRQs on, as a result of
relaxing over the low level IRQ trampoline, which makes some I-pipe call
in the irq_handler boilerplate code unhappy. The very same issue is
looming on x86, with an unprotected call to __ipipe_root_p from
__ipipe_handle_irq(). Disabling IRQs before leaving the mayday handler
is required at the very least.

Your patch assumes that when it comes to relaxing a thread, trap/fault
and IRQ contexts are equivalent, so we might relax over the latter as
well: actually they are not. Since traps and faults are synchronous
events which do not happen from kernel space for a Xenomai thread (or
something is really wrong anyway), relaxing is always safe from such
context: we must have taken the event from userland, so we can't have
preempted any kernel code. Obviously, IRQ contexts don't give such
guarantee.

If there is a backtracing issue with gdb due to the mayday indirection,
I would rather try fixing the call chain information appropriately.

-- 
Philippe.

