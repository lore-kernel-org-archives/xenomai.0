From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <4BC1FAC9.5040904@domain.hid>
References: <4B9A0C25.5010602@domain.hid>  <4BC1FAC9.5040904@domain.hid>
Content-Type: text/plain; charset="UTF-8"
Date: Sun, 11 Apr 2010 19:38:51 +0200
Message-ID: <1271007531.2365.1.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [Adeos-main] [pull request] x86: Fix up regs unconditionally on
	exceptions
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: </public/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: adeos-main <adeos-main@gna.org>

On Sun, 2010-04-11 at 18:37 +0200, Jan Kiszka wrote:
> Jan Kiszka wrote:
> > The following changes since commit 14023bef1806dd640030d3eaf73c26736345bc30:
> >   Philippe Gerum (1):
> >         ipipe-2.6.32.7-x86-2.6-01
> > 
> > are available in the git repository at:
> > 
> >   git://git.kiszka.org/ipipe-2.6 queues/2.6.32-x86
> > 
> > Found while making KVM work over I-pipe/Xenomai. Its hardware
> > activation code triggered a planned #GP in IRQ context.
> > 
> > 
> > Jan Kiszka (1):
> >       x86: Fix up regs unconditionally on exceptions
> > 
> >  arch/x86/kernel/ipipe.c |   24 +++++++++++++-----------
> >  1 files changed, 13 insertions(+), 11 deletions(-)
> > 
> > ------
> > 
> > x86: Fix up regs unconditionally on exceptions
> > 
> > Some Linux exception handlers - at least do_general_protection -
> > evaluate regs->flags, and that on both x86-32 and -64. So we should fix
> > up the flags according to the pipeline state unconditionally.
> 
> Forgotten or intentionally skipped for 2.6-02?

Intentionally left aside for now. This is a touchy code, and I want to
make sure to properly assess the implications of such change before
merging.

> 
> Hmm, I see that even the fixed-up comment in __ipipe_handle_exception is
> not correct anymore. I can push an updated version if you're fine with
> picking this up.
> 
> Jan
> 
> > 
> > Signed-off-by: Jan Kiszka <jan.kiszka@domain.hid>
> > ---
> >  arch/x86/kernel/ipipe.c |   24 +++++++++++++-----------
> >  1 files changed, 13 insertions(+), 11 deletions(-)
> > 
> > diff --git a/arch/x86/kernel/ipipe.c b/arch/x86/kernel/ipipe.c
> > index 36cd591..dfb76ad 100644
> > --- a/arch/x86/kernel/ipipe.c
> > +++ b/arch/x86/kernel/ipipe.c
> > @@ -495,8 +495,6 @@ out:
> >  	local_irq_restore_hw(flags);
> >  }
> >  
> > -#ifdef CONFIG_X86_32
> > -
> >  static inline void __fixup_if(int s, struct pt_regs *regs)
> >  {
> >  	/*
> > @@ -510,6 +508,8 @@ static inline void __fixup_if(int s, struct pt_regs *regs)
> >  		regs->flags |= X86_EFLAGS_IF;
> >  }
> >  
> > +#ifdef CONFIG_X86_32
> > +
> >  /*
> >   * Check the stall bit of the root domain to make sure the existing
> >   * preemption opportunity upon in-kernel resumption could be
> > @@ -571,10 +571,6 @@ asmlinkage void __ipipe_unstall_iret_root(struct pt_regs regs)
> >  
> >  #else /* !CONFIG_X86_32 */
> >  
> > -static inline void __fixup_if(int s, struct pt_regs *regs)
> > -{
> > -}
> > -
> >  #ifdef CONFIG_PREEMPT
> >  
> >  asmlinkage void preempt_schedule_irq(void);
> > @@ -746,11 +742,11 @@ int __ipipe_handle_exception(struct pt_regs *regs, long error_code, int vector)
> >  
> >  	if (likely(ipipe_root_domain_p)) {
> >  		/*
> > -		 * 32-bit: In case we faulted in the iret path, regs.flags do
> > -		 * not match the root domain state as the low-level return
> > -		 * code will evaluate it. Fix this up, either by the root
> > -		 * state sampled on entry or, if we migrated to root, with the
> > -		 * current state.
> > +		 * In case we faulted in the iret path, regs.flags do not
> > +		 * match the root domain state. The fault handler or the
> > +		 * low-level return code may evaluate it. Fix this up, either
> > +		 * by the root state sampled on entry or, if we migrated to
> > +		 * root, with the current state.
> >  		 */
> >  		__fixup_if(root_entry ? raw_irqs_disabled_flags(flags) :
> >  					raw_irqs_disabled(), regs);
> > @@ -876,7 +872,13 @@ int __ipipe_syscall_root(struct pt_regs *regs)
> >  
> >  	local_irq_save_hw(flags);
> >  	p = ipipe_root_cpudom_ptr();
> > +#ifdef CONFIG_X86_32
> > +	/*
> > +	 * Fix-up only required on 32-bit as only here the IRET return code
> > +	 * will evaluate the flags.
> > +	 */
> >  	__fixup_if(test_bit(IPIPE_STALL_FLAG, &p->status), regs);
> > +#endif
> >  	/*
> >  	 * If allowed, sync pending VIRQs before _TIF_NEED_RESCHED is
> >  	 * tested.
> 
> 


-- 
Philippe.



