From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <4C06229F.3030403@domain.hid>
References: <20100601135005.GA5483@domain.hid>
	<1275402757.27918.151.camel@domain.hid>
	<20100601155403.GA8240@domain.hid>
	<4C053C51.4090903@domain.hid> <4C061823.70005@domain.hid>
	<1275470136.18250.16.camel@domain.hid>
	<4C06229F.3030403@domain.hid>
Content-Type: text/plain; charset="UTF-8"
Date: Wed, 02 Jun 2010 11:34:27 +0200
Message-ID: <1275471267.18250.22.camel@domain.hid>
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
Cc: Jan Kiszka <jan.kiszka@domain.hid>, xenomai@xenomai.org

On Wed, 2010-06-02 at 11:21 +0200, Gilles Chanteperdrix wrote:
> Philippe Gerum wrote:
> > On Wed, 2010-06-02 at 10:36 +0200, Gilles Chanteperdrix wrote:
> >> Jan Kiszka wrote:
> >>> Tschaeche IT-Services wrote:
> >>>> On Tue, Jun 01, 2010 at 04:32:37PM +0200, Philippe Gerum wrote:
> >>>>> Not in the absence of syscall. We thought about this once already, when
> >>>>> considering how a watchdog preempting a runaway task in primary mode
> >>>>> could force a secondary mode switch: there is no sane and easy solution
> >>>>> to this unfortunately.
> >>>> This is exactly Sigmatek's problem: Our customers develop code
> >>>> within our debugging/development environment. We want to catch
> >>>> this situation (the developer implements a while(1)) with a
> >>>> watchdog throwing SIGTRAP so that our debugger gets active
> >>>> and can locate the problem according to the stack frame...
> >>> CONFIG_XENO_OPT_WATCHDOG is probably what you are looking for. It tries
> >>> to catch "well-behaving" broken threads via SIGDEBUG and kills the
> >>> hopelessly broken rest - system alive again.
> >>>
> >>> You can then debug the former and need to do code review on the latter.
> >>> Or you could also try to add some loop-breaking Xenomai syscalls (or
> >>> even more clever checks) to library services the code under suspect
> >>> usually invokes.
> >> I am afraid "well-behaving" means emitting syscalls. We have a radical
> >> way to cause a SIGSEGV to be sent to a thread having run amok: set its
> >> PC to an invalid address (after having printed the real PC). gdb will
> >> not be able to print where the program stopped, but should be able to
> >> print the backtrace.
> >>
> > 
> > Actually, we could extend this logic and forge a stack frame to return
> > to the preempted application code via some userland trampoline code,
> > doing the switch:
> > 
> > [watchdog trigger]
> > 	forge_return_frame(on =regs->sp, to =regs->pc);
> > 	regs->pc = __oops_I_did_it_again;
> > 
> > __oops_I_did_it_again:
> > 	__xn_migrate(LINUX_DOMAIN);
> > 	ret (via forged frame)
> > 
> > The thing is, that this brings in some arch-dep code to forge a stack
> > frame (like the kernel uses for signals), that should rather live in the
> > pipeline core.
> 
> There seems to be a simple approach:
> when the thread runs amok, set the pc to invalid address, save the real
> pc somewhere
> when relaxing for handling the exception (xnpod_trap_fault), if the amok
> bit is set, restore the pc in the saved registers from the saved location.
> 

It's indeed simpler. The limit of this approach is to count on a correct
behaviour of the fault mechanism, since we would rely on it implicitly
to deal with the mode switch. By "correct", I mean: the instruction
fetch fault must be detectable and recoverable the same way, regardless
of the architecture.


-- 
Philippe.



