From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <4C063041.40202@domain.hid>
References: <20100601135005.GA5483@domain.hid>
	<1275402757.27918.151.camel@domain.hid>
	<20100601155403.GA8240@domain.hid>
	<4C053C51.4090903@domain.hid> <4C061823.70005@domain.hid>
	<1275470136.18250.16.camel@domain.hid>
	<4C062246.40107@domain.hid>
	<1275470925.18250.18.camel@domain.hid>
	<4C06265C.3030108@domain.hid>
	<1275473174.18250.36.camel@domain.hid>
	<4C063041.40202@domain.hid>
Content-Type: text/plain; charset="UTF-8"
Date: Wed, 02 Jun 2010 12:42:35 +0200
Message-ID: <1275475355.18250.46.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Handling Linux Signals in primary domain context
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: Jan Kiszka <jan.kiszka@domain.hid>, "xenomai@xenomai.org" <xenomai@xenomai.org>

On Wed, 2010-06-02 at 12:19 +0200, Gilles Chanteperdrix wrote:
> Philippe Gerum wrote:
> > On Wed, 2010-06-02 at 11:37 +0200, Gilles Chanteperdrix wrote:
> >> Philippe Gerum wrote:
> >>> On Wed, 2010-06-02 at 11:20 +0200, Jan Kiszka wrote:
> >>>> Philippe Gerum wrote:
> >>>>> On Wed, 2010-06-02 at 10:36 +0200, Gilles Chanteperdrix wrote:
> >>>>>> Jan Kiszka wrote:
> >>>>>>> Tschaeche IT-Services wrote:
> >>>>>>>> On Tue, Jun 01, 2010 at 04:32:37PM +0200, Philippe Gerum wrote:
> >>>>>>>>> Not in the absence of syscall. We thought about this once already, when
> >>>>>>>>> considering how a watchdog preempting a runaway task in primary mode
> >>>>>>>>> could force a secondary mode switch: there is no sane and easy solution
> >>>>>>>>> to this unfortunately.
> >>>>>>>> This is exactly Sigmatek's problem: Our customers develop code
> >>>>>>>> within our debugging/development environment. We want to catch
> >>>>>>>> this situation (the developer implements a while(1)) with a
> >>>>>>>> watchdog throwing SIGTRAP so that our debugger gets active
> >>>>>>>> and can locate the problem according to the stack frame...
> >>>>>>> CONFIG_XENO_OPT_WATCHDOG is probably what you are looking for. It tries
> >>>>>>> to catch "well-behaving" broken threads via SIGDEBUG and kills the
> >>>>>>> hopelessly broken rest - system alive again.
> >>>>>>>
> >>>>>>> You can then debug the former and need to do code review on the latter.
> >>>>>>> Or you could also try to add some loop-breaking Xenomai syscalls (or
> >>>>>>> even more clever checks) to library services the code under suspect
> >>>>>>> usually invokes.
> >>>>>> I am afraid "well-behaving" means emitting syscalls. We have a radical
> >>>>>> way to cause a SIGSEGV to be sent to a thread having run amok: set its
> >>>>>> PC to an invalid address (after having printed the real PC). gdb will
> >>>>>> not be able to print where the program stopped, but should be able to
> >>>>>> print the backtrace.
> >>>>>>
> >>>>> Actually, we could extend this logic and forge a stack frame to return
> >>>>> to the preempted application code via some userland trampoline code,
> >>>>> doing the switch:
> >>>>>
> >>>>> [watchdog trigger]
> >>>>> 	forge_return_frame(on =regs->sp, to =regs->pc);
> >>>>> 	regs->pc = __oops_I_did_it_again;
> >>>>>
> >>>>> __oops_I_did_it_again:
> >>>>> 	__xn_migrate(LINUX_DOMAIN);
> >>>>> 	ret (via forged frame)
> >>>> Yep, that's what came to my mind as well. But the __oops_I_did_it_again
> >>>> part has to reside in user space, no?
> >>> Clearly, yes. Either we map this explictly, or we just make sure to
> >>> compile it in each app, and pass its address at skin binding time. Our
> >>> text is mmlocked anyway.
> >>>
> >>>>> The thing is, that this brings in some arch-dep code to forge a stack
> >>>>> frame (like the kernel uses for signals), that should rather live in the
> >>>>> pipeline core.
> >>>> Actually, we are then close to enabling signal delivery outside syscalls...
> >>>>
> >>> Yes, looks like.
> >> When thinking about this real signals things, I was thinking about
> >> putting the forging code into Xenomai (the code is the same for all
> >> kernel versions, so there is no reason to put it into the I-pipe, and we
> >> may have to emit a special syscall to restore the context when handling
> >> the signal is done). What we need the I-pipe for, however, is to trigger
> >> some event on the way back to user-space.
> >>
> > 
> > A reason to have this code in the pipeline core is because we would
> > duplicate the setup_rt_frame code already available from the vanilla
> > kernel. It's a bit like xnarch_switch_to: we used to open code most of
> > it in our arch-dep code, mostly duplicating the vanilla switch code, but
> > having switch_mm() ironed enough - on arm and powerpc at least - to be
> > callable from the Xenomai domain as well proved to be a serious relief.
> > 
> > Granted, the signal code is unlikely to change a lot, given the strong
> > ABI requirements this has wrt the glibc, but I'm always reluctant to
> > introduce duplicates at both ends of the system; I would rather factor
> > out that code and make it available to both domains, if that makes
> > sense.
> 
> I am not sure it really makes sense: the biggest part of the linux code
> is used to setup the special frame passed as the last void * pointer of
> signal handlers with the SA_SIGINFO option, allowing (among others)
> signal handlers to use setcontext() to implement co-routines, and I am
> not sure we really want that. 

It's not about wanting that, it is about having it for free despite we
would not use it.

> And if you do some major revamping of
> Linux stack frame build functions, you will have merge conflicts every
> time you upgrade the I-pipe patch.
> 

I don't think so, for the same reason than you suspect that the kernel
code does not change ever so often in that area.

> Besides, we still have the return through syscall issue: returning from
> the signal handler can not be a simple "return" instruction, since we
> have to save and restore most registers.
> 

Sure, but this is not related to the place where you would put the
forging code. You may have a Xenomai syscall invoking a pipeline
service, we do that all the time actually.

Anyway, this issue is not critical to me. If you can achieve that goal
in plain Xenomai space without ending up with a two pages long hairy
code for each arch, then I won't not be pigheaded.

-- 
Philippe.



