Message-ID: <43C37926.5060007@domain.hid>
Date: Tue, 10 Jan 2006 10:06:46 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] latency kernel part crashes on ppc64
References: <43C12304.4040802@domain.hid>	<43C12CEC.8070403@domain.hid>	<43C14453.3040907@domain.hid>	<1136754149.17443.21.camel@domain.hid>	<43C18CE1.5040509@domain.hid>	<43C1CFC2.8040104@domain.hid>	<43C21BA7.4050806@domain.hid>	<43C220FE.4010100@domain.hid>
	<17346.57955.432284.905332@domain.hid>
In-Reply-To: <17346.57955.432284.905332@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: Jan Kiszka <jan.kiszka@domain.hid>, xenomai@xenomai.org

Gilles Chanteperdrix wrote:
> Philippe Gerum wrote:
>  > Likely not this time (keep it cold anyway, who knows); I strongly suspect a bug in 
>  > xnarch_switch_to() for all archs but x86
> 
> Now that you are talking about it, I may be the one who owes a beer to
> everyone by first having put a bug in ia64 context-switch code... If I
> am not wrong, the bug should be observed on ia64 too. Unfortunately, I
> am unable to compile my ia64 kernel right now, so I wrote a patch for
> power PC, and would be glad if some power PC owner could try it.
> 

Nope, same lockup with hybrid scheduling.

> It should work on PPC 64 too...
> 
> 
> 
> ------------------------------------------------------------------------
> 
> Index: include/asm-powerpc/system.h
> ===================================================================
> --- include/asm-powerpc/system.h	(revision 410)
> +++ include/asm-powerpc/system.h	(working copy)
> @@ -182,13 +182,19 @@
>  {
>      struct task_struct *prev = out_tcb->active_task;
>      struct task_struct *next = in_tcb->user_task;
> +    static unsigned long last_ksp;
> +    static xnarchtcb_t *last_tcb;
>  
> +    last_tcb = out_tcb;
>      in_tcb->active_task = next ?: prev;
>  
>      if (next && next != prev) /* Switch to new user-space thread? */
>  	{
>  	struct mm_struct *mm = next->active_mm;
>  
> +        if (prev != out_tcb->user_task)
> +            last_ksp = prev->thread.ksp;
> +
>  	/* Switch the mm context.*/
>  
>  #ifdef CONFIG_PPC64
> @@ -245,6 +251,22 @@
>      else
>          /* Kernel-to-kernel context switch. */
>          rthal_switch_context(out_tcb->kspp,in_tcb->kspp);
> +
> +    /* If we are not the epilogue of a regular linux schedule(),... */
> +    if (likely(test_bit(xnarch_current_cpu(),&rthal_cpu_realtime)) &&
> +        /* we are a user-space thread,... */
> +        out_tcb->user_task &&
> +        /* the last context switch used linux switch routine,... */
> +        last_tcb->active_task != out_tcb->user_task &&
> +        /* but the last xenomai context was a kernel thread,... */
> +        last_tcb->user_task != last_tcb->active_task)
> +        {
> +        /* then linux context switch routine saved kernel thread stack pointer
> +           in last user-space context. We hence put the stack pointers in the
> +           right place. */
> +        last_tcb->ksp = last_tcb->active_task->thread.ksp;
> +        last_tcb->active_task->thread.ksp = last_ksp;
> +        }
>  }
>  
>  static inline void xnarch_finalize_and_switch (xnarchtcb_t *dead_tcb,


-- 

Philippe.

