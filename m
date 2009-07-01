From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <4A4BA334.8090701@domain.hid>
References: <4A48FB71.6070506@domain.hid> <4A49CD81.4060706@domain.hid>
	<4A49CFF0.7070202@domain.hid> <1246353623.7803.21.camel@domain.hid>
	<4A49D935.3060900@domain.hid> <1246353913.7803.24.camel@domain.hid>
	<4A49DA4E.2020604@domain.hid> <1246354047.7803.25.camel@domain.hid>
	<4A49DC0A.5000208@domain.hid> <4A4A391B.8000700@domain.hid>
	<4A4B4ED4.6020208@domain.hid> <4A4B558D.20307@domain.hid>
	<4A4B58E9.4050407@domain.hid> <4A4B5985.3070504@domain.hid>
	<4A4B8617.5000704@domain.hid> <4A4B8851.9070005@domain.hid>
	<4A4B8912.1060700@domain.hid>  <4A4BA334.8090701@domain.hid>
Content-Type: text/plain
Date: Wed, 01 Jul 2009 20:15:57 +0200
Message-Id: <1246472157.7803.62.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] x86: Endless minor faults
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: xenomai-core <xenomai@xenomai.org>

On Wed, 2009-07-01 at 19:56 +0200, Jan Kiszka wrote:
> Jan Kiszka wrote:
> > Jan Kiszka wrote:
> >> Gilles Chanteperdrix wrote:
> >>> Jan Kiszka wrote:
> >>>> Jan Kiszka wrote:
> >>>>> Gilles Chanteperdrix wrote:
> >>>>>> Jan Kiszka wrote:
> >>>>>>> Jan Kiszka wrote:
> >>>>>>>> It's still unclear what goes on precisely, we are still digging, but the
> >>>>>>>> test system that can produce this is highly contended.
> >>>>>>> Short update: Further instrumentation revealed that cr3 differs from
> >>>>>>> active_mm->pgd while we are looping over that fault, ie. the kernel
> >>>>>>> tries to fixup the wrong mm. And that means we have some open race
> >>>>>>> window between updating cr3 and active_mm somewhere (isn't switch_mm run
> >>>>>>> in a preemptible manner now?).
> >>>>>> Maybe the rsp is wrong and leads you to the wrong active_mm ?
> >>>>>>
> >>>>>>> As a first shot I disabled CONFIG_IPIPE_DELAYED_ATOMICSW, and we are now
> >>>>>>> checking if it makes a difference. Digging deeper into the code in the
> >>>>>>> meanwhile...
> >>>>>> As you have found out in the mean time, we do not use unlocked context
> >>>>>> switches on x86.
> >>>>>>
> >>>>> Yes.
> >>>>>
> >>>>> The last question I asked myself (but couldn't answer yet due to other
> >>>>> activity) was: Where are the local_irq_disable/enable_hw around
> >>>>> switch_mm for its Linux callers?
> >>>> Ha, that's the point: only activate_mm is protected, but we have more
> >>>> spots in 2.6.29 and maybe other kernels, too!
> >>> Ok, I do not see where switch_mm is called with IRQs off. What I found,
> >> We have two direct callers of switch_mm in sched.c and one in fs/aio.c.
> >> Both need protection (I pushed IRQ disabling into switch_mm), but that
> >> is not enough according to current tests. It seems to reduce to
> >> probability of corruption, though.
> >>
> >>> however, is that leave_mm sets the cr3 and just clears
> >>> active_mm->cpu_vm_mask. So, at this point, we have a discrepancy between
> >>> cr3 and active_mm. I do not know what could happen if Xenomai could
> >>> interrupt leave_mm between the cpu_clear and the write_cr3. From what I
> >>> understand, switch_mm called by Xenomai upon return to root would re-set
> >>> the bit, and re-set cr3, which would be set to the kernel cr3 right
> >>> after that, but this would result in the active_mm.cpu_vm_mask bit being
> >>> set instead of cleared as expected. So, maybe an irqs off section is
> >>> missing in leave_mm.
> >> leave_mm is already protected by its caller smp_invalidate_interrupt -
> >> but now I'm parsing context_switch /wrt to lazy tlb.
> >>
> > 
> > Hmm... lazy tlb: This means a new task is switched in and has active_mm
> > != mm. But do_page_fault reads task->mm... Just thoughts, no clear
> > picture yet.
> > 
> 
> Looking closer at the call sites of switch_mm, I think our the problem
> is mostly related to use_mm from fs/aio.c (customer is using aio
> heavily). But other callers need protection, too. We are going to test
> this patch tomorrow:
> 
> diff --git a/fs/aio.c b/fs/aio.c
> index 76da125..d90fca3 100644
> --- a/fs/aio.c
> +++ b/fs/aio.c
> @@ -618,13 +618,16 @@ static void use_mm(struct mm_struct *mm)
>  {
>  	struct mm_struct *active_mm;
>  	struct task_struct *tsk = current;
> +	unsigned long flags;
>  
>  	task_lock(tsk);
>  	active_mm = tsk->active_mm;
>  	atomic_inc(&mm->mm_count);
> +	local_irq_save_hw_cond(flags);
>  	tsk->mm = mm;
>  	tsk->active_mm = mm;
>  	switch_mm(active_mm, mm, tsk);
> +	local_irq_restore_hw_cond(flags);
>  	task_unlock(tsk);
>  
>  	mmdrop(active_mm);
> diff --git a/kernel/sched.c b/kernel/sched.c
> index aa8f86c..8c545a4 100644
> --- a/kernel/sched.c
> +++ b/kernel/sched.c
> @@ -2668,8 +2668,12 @@ context_switch(struct rq *rq, struct task_struct *prev,
>  		next->active_mm = oldmm;
>  		atomic_inc(&oldmm->mm_count);
>  		enter_lazy_tlb(oldmm, next);
> -	} else
> +	} else {
> +		unsigned long flags;
> +		local_irq_save_hw_cond(flags);
>  		switch_mm(oldmm, mm, next);
> +		local_irq_restore_hw_cond(flags);
> +	}
>  
>  	if (unlikely(!prev->mm)) {
>  		prev->active_mm = NULL;
> @@ -6406,8 +6410,12 @@ void idle_task_exit(void)
>  
>  	BUG_ON(cpu_online(smp_processor_id()));
>  
> -	if (mm != &init_mm)
> +	if (mm != &init_mm) {
> +		unsigned long flags;
> +		local_irq_save_hw_cond(flags);
>  		switch_mm(mm, &init_mm, current);
> +		local_irq_restore_hw_cond(flags);
> +	}
>  	mmdrop(mm);
>  }

Please fix the callee instead of ironing the call sites. This would
avoid further issues as upstream emits additional switch_mm calls over
time, and make ironing activate_mm useless.

>  
> 
> Jan
> 
-- 
Philippe.



