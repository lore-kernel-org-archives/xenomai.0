From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <4AC248FD.7050707@domain.hid>
References: <4AC248FD.7050707@domain.hid>
Content-Type: text/plain
Date: Thu, 01 Oct 2009 12:04:21 +0200
Message-Id: <1254391461.2703.176.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] RFC: primary mode signals design.
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: Xenomai core <Xenomai-core@domain.hid>

On Tue, 2009-09-29 at 19:50 +0200, Gilles Chanteperdrix wrote:
> Hi,
> 
> During my flights and connections, I had a thought about this primary
> mode signals issue.
> 
> Since the needs in term of primary mode signals greatly depends on what
> the skins want to do with it (native wants hooks, posix wants posix
> conformant signals), I think as much work as possible should be done in
> the nucleus and skins implementation, not in the I-pipe (as usual). So,
> I propose to:
> 1- add an I-pipe SIGNAL_PENDING event
> 2- add a bit somewhere in the task_struct or thread_info stuctures
> indicating that signals are pending
> 3- add a service to mark the bit, like:
> int ipipe_mark_signal_pending(struct task_struct *task);
> 4- in entry.S, when going back to user-space, test and clear the bit is
> set, and if it was set, trigger the event
> 5- implement services allowing to run a callback with some cookie when
> returning to user-space, we may also need to be able to push on stack
> some arguments that should be passed to the callback, (we need this
> service internally anyway to push the pt_regs structure on stack, so
> that the calling context can be restored after execution of the
> callback, and we need a little help from user-space for this
> restoration, probably in bind.h).

What bothers me is that we would duplicate what the kernel does in
do_signal() for most architectures, and go through many hops from the
actual signal notification to the execution of the handler. What about
delaying the logic a bit: pass userland a signal-pending information on
its way back from a syscall, to be detected by the XENOMAI_SYSCALL code
instead. If that notification flag is raised, the required information
to run the user-space handler would have been made available by the
nucleus as well, so that XENOMAI_SYSCALL would just have to act as a
trampoline to that handler.

e.g. 

struct xnsigdata sigdata;
 
#define XENOMAI_SYSCALL()
({
	mov reg, sysnr
	mov reg, sysarg
	mov reg, sigdata
	syscall-op
	mov __retval, reg
	if (sigdata.present)
		sigdata.handler(sigdata.siginfo);
	__retval;
})

Granted, we should take care of keeping code inlining under control, to
prevent binary code bloat.

Xenomai currently uses only 5 argument registers to syscalls, so we
could dedicate the 6th one to hold the sigdata reference. On the
nucleus-side, return paths from the high/lo syscall stages handlers
would have to include the signal propagation code, and copy the required
data to the sigdata area when a (nucleus-originated) signal is pending.

Whether the nucleus or the skin library should hold the handlers
addresses is debatable as well; actually, I see no point in making the
kernel aware of this, if it takes no part in building a signal stack
frame.

I did not analyze how well this approach maps to the POSIX/siginfo
requirements though, in terms of context information to be made
available to the user handler.

> 
> 6- The nucleus would then propose to register per-skin callbacks,
> subscribe to the SIGNAL_PENDING event, and dispatch a pending signal to
> all the skins which are currently expecting it. The skins would do the
> callbacks housekeeping at their level.
> 
> The critical point is clearly point 5, and it is still a bit fuzzy. At
> least, I think I know how I would do it on ARM, but I do not know how to
> package the services in such a way that it would tolerate differences
> between platform.

Agreed, the rest is almost trivial (famous last words). 

>  It is unclear, for instance whether some or all
> platforms may need an additional syscall to restore the original context
> due to the need of running in privileged mode to restore some registers
> value.

Yes, some do require this, e.g. via sys_sigreturn and sys_rt_sigreturn.
Another upside of running the handler from the syscall wrapper is tht
would not need any syscall for unwinding the signal stack frame.

>  Ok, now that I think about it, an additional syscall would be the
> most portable way, but also a bit slow.
> 
> What do you think?
> 
-- 
Philippe.



