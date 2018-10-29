Date: Mon, 29 Oct 2018 10:33:09 +0100
From: Henning Schild <henning.schild@siemens.com>
Subject: Re: [ipipe 4.14][PATCH] x86: ipipe: Fix trap hooking for userspace
 routes
Message-ID: <20181029103309.6f0be40b@md1pvb1c.ad001.siemens.net>
In-Reply-To: <ce687274-047c-79d3-be0d-704a9834d19e@siemens.com>
References: <144decef-a102-1cee-a9b1-8be5ed0d1258@siemens.com>
 <20181026145035.3c031bb5@md1pvb1c.ad001.siemens.net>
 <ce687274-047c-79d3-be0d-704a9834d19e@siemens.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: Xenomai <xenomai@xenomai.org>, Philippe Gerum <rpm@xenomai.org>

Am Fri, 26 Oct 2018 14:32:36 +0100
schrieb Jan Kiszka <jan.kiszka@siemens.com>:

> On 26.10.18 13:50, Henning Schild wrote:
> > Hey,
> > 
> > looks like this one is for the #PF from the sigdebug smokey test.
> > With this patch applied i do not see the crash anymore, but the
> > test gets stuck.
> > Did it work for you, or did i get the context wrong?  
> 
> Yes, this solved the issue for me, and I was able to finish the test.
> But that might be related to configuration variations (I think I sent
> my configuration earlier to the list).

I was still using a modified copy of the test, looks like it works just
fine. I guess we can release if we are ok with not supporting x86_32
for now ... or for the future.

Henning

> Jan
> 
> > 
> > Henning
> > 
> > Am Wed, 10 Oct 2018 13:05:28 +0200
> > schrieb Jan Kiszka <jan.kiszka@siemens.com>:
> >   
> >> Also hook into the trap path when the exception was taken over
> >> userspace code.
> >>
> >> Fixes: e6b81a0ce7fb (x86: ipipe: route traps to co-kernel)
> >> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
> >> ---
> >>
> >> Makes sense? I'm not feeling 100% safe yet /wrt paranoid and the
> >> userspace path. Should we handle this identically to the kernel
> >> path or not?
> >>
> >> Eventually this should be merged into the original patch, at least
> >> on next major rebase.
> >>
> >>   arch/x86/entry/entry_64.S | 80
> >> +++++++++++++++++++++++++++-------------------- 1 file changed, 46
> >> insertions(+), 34 deletions(-)
> >>
> >> diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
> >> index f6fe849d66ed..42e31d1fddc6 100644
> >> --- a/arch/x86/entry/entry_64.S
> >> +++ b/arch/x86/entry/entry_64.S
> >> @@ -904,6 +904,46 @@ ENTRY(switch_to_thread_stack)
> >>   	ret
> >>   END(switch_to_thread_stack)
> >>   
> >> +.macro ipipe_idtentry_prologue paranoid=0 trapnr=-1
> >> skip_label=-invalid- +#ifdef CONFIG_IPIPE
> >> +	movq	EFLAGS(%rsp), %r14		/*
> >> regs->flags */
> >> +	movq	%rsp, %rdi			/* pt_regs
> >> pointer */
> >> +	movl	$\trapnr, %esi			/* trap
> >> number */
> >> +	subq	$8, %rsp
> >> +	movq	%rsp, %rdx			/* &flags */
> >> +	call	__ipipe_trap_prologue
> >> +	popq	%r13
> >> +	mov	%rax, %r12			/* save
> >> propagation status */
> >> +	.if \paranoid == 0			/* paranoid may
> >> not skip handler */
> >> +	testl	%eax, %eax
> >> +	jg	\skip_label			/* skip
> >> regular handler if > 0 */
> >> +	.endif
> >> +#endif
> >> +.endm
> >> +
> >> +.macro ipipe_idtentry_epilogue paranoid=0 skip_label=-invalid-
> >> +#ifdef CONFIG_IPIPE
> >> +	testl	%r12d, %r12d
> >> +	jnz	1000f
> >> +	movq	%rsp, %rdi			/* pt_regs
> >> pointer */
> >> +	movq	%r13, %rsi			/* &flags
> >> from prologue */
> >> +	movq	%r14, %rdx			/* original
> >> regs->flags before fixup */
> >> +	call	__ipipe_trap_epilogue
> >> +1000:
> >> +	.if \paranoid == 0			/* paranoid
> >> implies normal epilogue */
> >> +	testl	%r12d, %r12d
> >> +	jz	1001f
> >> +\skip_label:
> >> +	UNWIND_HINT_REGS
> >> +	DISABLE_INTERRUPTS(CLBR_ANY)
> >> +	testl	%ebx, %ebx	/* %ebx: return to kernel
> >> mode */
> >> +	jnz	retint_kernel_early
> >> +	jmp	retint_user_early
> >> +	.endif
> >> +1001:
> >> +#endif
> >> +.endm
> >> +
> >>   .macro idtentry sym do_sym has_error_code:req paranoid=0
> >> shift_ist=-1 trapnr=-1 ENTRY(\sym)
> >>   	UNWIND_HINT_IRET_REGS offset=\has_error_code*8
> >> @@ -940,20 +980,7 @@ ENTRY(\sym)
> >>   	.endif
> >>   	.endif
> >>   
> >> -#ifdef CONFIG_IPIPE
> >> -	movq	EFLAGS(%rsp), %r14		/*
> >> regs->flags */
> >> -	movq	%rsp, %rdi			/* pt_regs
> >> pointer */
> >> -	movl	$\trapnr, %esi			/* trap
> >> number */
> >> -	subq	$8, %rsp
> >> -	movq	%rsp, %rdx			/* &flags */
> >> -	call	__ipipe_trap_prologue
> >> -	popq	%r13
> >> -	mov	%rax, %r12			/* save
> >> propagation status */
> >> -	.if \paranoid == 0			/* paranoid may
> >> not skip handler */
> >> -	testl	%eax, %eax
> >> -	jg	98f				/* skip
> >> regular handler if > 0 */
> >> -	.endif
> >> -#endif
> >> +	ipipe_idtentry_prologue paranoid=\paranoid trapnr=\trapnr
> >> skip_label=kernel_skip_\@
> >>   	movq	%rsp, %rdi			/* pt_regs
> >> pointer */
> >> @@ -970,26 +997,7 @@ ENTRY(\sym)
> >>   
> >>   	call	\do_sym
> >>   
> >> -#ifdef CONFIG_IPIPE
> >> -	testl	%r12d, %r12d
> >> -	jnz	97f
> >> -	movq	%rsp, %rdi			/* pt_regs
> >> pointer */
> >> -	movq	%r13, %rsi			/* &flags
> >> from prologue */
> >> -	movq	%r14, %rdx			/* original
> >> regs->flags before fixup */
> >> -	call	__ipipe_trap_epilogue
> >> -97:
> >> -	.if \paranoid == 0			/* paranoid
> >> implies normal epilogue */
> >> -	testl	%r12d, %r12d
> >> -	jz	99f
> >> -98:
> >> -	UNWIND_HINT_REGS
> >> -	DISABLE_INTERRUPTS(CLBR_ANY)
> >> -	testl	%ebx, %ebx	/* %ebx: return to kernel
> >> mode */
> >> -	jnz	retint_kernel_early
> >> -	jmp	retint_user_early
> >> -	.endif
> >> -99:
> >> -#endif
> >> +	ipipe_idtentry_epilogue paranoid=\paranoid
> >> skip_label=kernel_skip_\@
> >>   	.if \shift_ist != -1
> >>   	addq	$EXCEPTION_STKSZ, CPU_TSS_IST(\shift_ist)
> >> @@ -1011,6 +1019,8 @@ ENTRY(\sym)
> >>   .Lfrom_usermode_switch_stack_\@:
> >>   	call	error_entry
> >>   
> >> +	ipipe_idtentry_prologue paranoid=\paranoid trapnr=\trapnr
> >> skip_label=user_skip_\@ +
> >>   	movq	%rsp, %rdi			/* pt_regs
> >> pointer */
> >>   	.if \has_error_code
> >> @@ -1022,6 +1032,8 @@ ENTRY(\sym)
> >>   
> >>   	call	\do_sym
> >>   
> >> +	ipipe_idtentry_epilogue paranoid=\paranoid
> >> skip_label=user_skip_\@ +
> >>   	jmp	error_exit
> >>   	.endif
> >>   END(\sym)  
> >   
> 


