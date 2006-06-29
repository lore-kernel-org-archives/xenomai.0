Subject: Re: [Xenomai-core] Prio-inversion on cleanup?
From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <44A3ACA8.6070201@domain.hid>
References: <44A1608B.3090605@domain.hid> <44A295ED.2080306@domain.hid>
	<44A39C3C.1080508@domain.hid> <1151576082.5291.41.camel@domain.hid>
	<44A3ACA8.6070201@domain.hid>
Content-Type: text/plain
Date: Thu, 29 Jun 2006 12:48:09 +0200
Message-Id: <1151578090.5291.49.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Reply-To: rpm@xenomai.org
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

On Thu, 2006-06-29 at 12:34 +0200, Jan Kiszka wrote:
> Philippe Gerum wrote:
> > On Thu, 2006-06-29 at 11:24 +0200, Jan Kiszka wrote:
> >> Jan Kiszka wrote:
> >>> ...
> >>> The pthread is blocked on the irqbench device ioctl. On hitting ^C,
> >>> close() is invoked from the main thread for that device. The pthread is
> >>> woken up and obviously relaxed on some linux syscall (after being
> >>> interrupted twice by the periodic timer event of a "latency -p 300 -P
> >>> 50" instance). This passes the control over to the main thread while
> >>> keeping the pthread prio of 99. And this prio seems to survive for the
> >>> following 11 ms (full trace available on request).
> >>>
> >>> Any ideas what's going on?
> >>>
> >> Ok, I think I finally understood the issue. It seems to lie deep in the
> >> POSIX user-space lib, specifically its use of standard pthread services.
> >> Let me first clarify my scenario:
> >>
> >> A high-prio pthread of known and (theoretically) bounded workload shall
> >> be started and stopped while a low-prio thread is already running. The
> >> low-prio thread shall only be impacted by the real workload of the
> >> high-prio one, not by its creation/destruction - at least not
> >> significantly. To achieve this with the POSIX skin (actually this
> >> applies to preempt-rt in theory as well), I have to create the thread
> >> under SCHED_OTHER, raise its priority right before entering the
> >> workload, and lower it again before leaving the thread.
> >>
> >> But, unfortunately, __wrap_pthread_setschedparam() depends on some
> >> real_pthread functions to be called. One of them is
> >> __real_pthread_setschedparam, and this one issues a linux syscall for
> >> obvious reasons. When lowering the thread to SCHED_OTHER, this syscall
> >> is still issued under the original priority. And here we get bitten by
> >> the prio-inheritance feature of the nucleus which, in my case, lets
> >> significant parts of standard Linux execute under high priority,
> >> delaying my other real-time threads.
> >>
> >> Now I wonder how to resolve this, how to make pthread_setschedparam (a
> >> rather central RT-service) really real-time safe? I would say we need
> >> something like a lazy schedparam propagation to Linux which only takes
> >> place when the thread enters secondary mode intentionally or no other RT
> >> thread is ready. But I do not have a design for this at hand. Nasty.
> >>
> >> [My preferred way for every setup != CONFIG_PREEMPT_RT + CONFIG_XENOMAI
> >> would still be to switch this prio-inheritance off for the root thread.
> >> But this was nack'ed by Philippe several times before... ;)]
> >>
> > 
> > I nacked the proposal to _always_ switch it off. Some applications
> > deeply need this.
> 
> I think to remember asking for a CONFIG switch here. Some applications
> actually benefit while others (I even think most) do not need it or even
> easily screw themselves up during init/cleanup. You know, my old
> concerns. :)
> 

A dynamic switch is better there. You may want this behaviour to be
settable on a thread-by-thread basis.

> > 
> >> Side note: the native skin does not seem to suffer from this effect as
> >> it only tracks the current prio at Xenomai level.
> >>
> > 
> > Switching off priority adjustment for the root thread before moving a
> > SCHED_FIFO shadow to SCHED_OTHER would prevent this side-effect. We'd
> > need to add a per-thread status bit to check whether we should run
> > xnpod_renice_root() or not for any given thread, and switch it on/off
> > from __wrap_pthread_setschedparam.
> > 
> 
> This doesn't sound bad and would probably help low-prio threads also in
> some other scenarios.
> 

I'm currently implementing that at nucleus level.

> Nevertheless, a syscall-less pthread_setschedparam would still be a good
> idea as well, this time having the caller in mind who wishes to change
> its priority without entering Linux.

Reading the comment Gilles put there, it's likely not possible to have a
syscall-less implementation on top of the NPTL. We need to give a chance
to the NPTL to track the priority update, otherwise,
pthread_getschedparam() is going to break.

> 
> Jan
> 
-- 
Philippe.



