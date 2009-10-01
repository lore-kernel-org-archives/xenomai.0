From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <4AC49EEB.1090403@domain.hid>
References: <4AC248FD.7050707@domain.hid>
	<1254391461.2703.176.camel@domain.hid>  <4AC4819F.4060809@domain.hid>
	<1254393031.2703.181.camel@domain.hid>  <4AC49EEB.1090403@domain.hid>
Content-Type: text/plain
Date: Thu, 01 Oct 2009 15:06:32 +0200
Message-Id: <1254402392.2703.273.camel@domain.hid>
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

On Thu, 2009-10-01 at 14:22 +0200, Gilles Chanteperdrix wrote:
> Philippe Gerum wrote:
> > On Thu, 2009-10-01 at 12:17 +0200, Gilles Chanteperdrix wrote:
> >> Philippe Gerum wrote:
> >>> On Tue, 2009-09-29 at 19:50 +0200, Gilles Chanteperdrix wrote:
> >>>> Hi,
> >>>>
> >>>> During my flights and connections, I had a thought about this primary
> >>>> mode signals issue.
> >>>>
> >>>> Since the needs in term of primary mode signals greatly depends on what
> >>>> the skins want to do with it (native wants hooks, posix wants posix
> >>>> conformant signals), I think as much work as possible should be done in
> >>>> the nucleus and skins implementation, not in the I-pipe (as usual). So,
> >>>> I propose to:
> >>>> 1- add an I-pipe SIGNAL_PENDING event
> >>>> 2- add a bit somewhere in the task_struct or thread_info stuctures
> >>>> indicating that signals are pending
> >>>> 3- add a service to mark the bit, like:
> >>>> int ipipe_mark_signal_pending(struct task_struct *task);
> >>>> 4- in entry.S, when going back to user-space, test and clear the bit is
> >>>> set, and if it was set, trigger the event
> >>>> 5- implement services allowing to run a callback with some cookie when
> >>>> returning to user-space, we may also need to be able to push on stack
> >>>> some arguments that should be passed to the callback, (we need this
> >>>> service internally anyway to push the pt_regs structure on stack, so
> >>>> that the calling context can be restored after execution of the
> >>>> callback, and we need a little help from user-space for this
> >>>> restoration, probably in bind.h).
> >>> What bothers me is that we would duplicate what the kernel does in
> >>> do_signal() for most architectures, and go through many hops from the
> >> Maybe we can re-use the linux kernel code? Maybe we can even make that
> >> code platform independent and put it in the nucleus, using the xnregs*
> >> macros, and maybe adding some more to alter the pt_regs structure to
> >> cause the return to user-space to pass by the callback, and to be able
> >> to push some data on the stack, imposing the need of a syscall to
> >> restore context.
> >>
> > 
> > Quite frankly, I doubt of it. That part of the Linux code is often
> > hairy, touchy, platform and context dependent, so AFAICS, maintaining
> > this sort of merge over time with different kernel releases over
> > multiple archs would end up in a living nightmare.
> 
> The thing which is goddam platform dependent is the way pt_regs are
> mapped to a structure passed as third argument to the posix signals with
> the SA_SIGINFO flag. But in our case, this is something we will have to
> cope with in the POSIX skin. Or completely forget about (I agree signals
> are needed for the proper operation of posix timers, but this feature is
> not really useful in a real-time application).
> 
> Other than that, what we are talking about is just altering pt_regs::pc
> and xnregs_arg1(pt_regs), then push some data on the stack (so
> xncopy_to_user and altering pt_regs::sp). And adding a core skin syscall
> for the way back.
> 

I really do not see this as easy. x86 wants some fixup of the hw debug
regs when watchpoints are pending, powerpc has 32/64 bit deps when
unwinding the sigstack, not to speak of the very different ways
blackfin, nios2 and others set up the sigstack. All this code is
currently traversed by native kernel locking constructs, so I guess we
would have to paste&copy most of the related bits.

> Besides, the problem with your approach is that we can not pass data
> between kernel and user. And this is required for the posix skin, at
> least. And if we want a generic way to pass arguments to the user-space
> callback (I mean, even in the case of the native skin switch hook, you
> have to pass the ids of the switched tasks).
> 

No issue in having the sigdata block being a union of possible per-skin
structs. This is low core code, we can make it evolve as requirements
arise without impacting outer interfaces.

-- 
Philippe.



