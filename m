Date: Fri, 2 Oct 2015 12:01:42 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20151002100142.GN31137@hermes.click-hack.org>
References: <CAJqUr7zP85A6V7n9O=++iC4tJK8LCG5JC8xtO9Xd+u3sQW4G1A@mail.gmail.com>
 <5604517A.2000602@mperpetuo.com>
 <20150925150248.GE1332@hermes.click-hack.org>
 <560580E6.6070208@mperpetuo.com>
 <20150925180137.GF1332@hermes.click-hack.org>
 <20150926112419.GH1332@hermes.click-hack.org>
 <CAPuu0=hEDw3g4pkJfWsAy-LkgwL=SrGyb1xPuU7a3-5LKYuHZg@mail.gmail.com>
 <20150929141439.GS15616@csclub.uwaterloo.ca>
 <20150929204945.GD18188@hermes.click-hack.org>
 <560DC717.9050902@mperpetuo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <560DC717.9050902@mperpetuo.com>
Subject: Re: [Xenomai] xenomai/ipipe arm64 port
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Dmitriy Cherkasov <dmitriy@mperpetuo.com>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

On Thu, Oct 01, 2015 at 04:51:51PM -0700, Dmitriy Cherkasov wrote:
> The following changes since commit 17095784c6d3d44dc7f1512ffab9bb957e298466:
> 
>    cobalt/arm64: leave mm tracking to the pipeline (2015-09-17 15:08:34 
> +0200)
> 
> are available in the git repository at:
> 
>    http://gitlab.mperpetuo.com/it/xenomai-3.git arm64-fp

Ok, I retrieved your code, some comments inlined:

> /*
> static void enable_fpsimd(void) {
> 	__asm__ __volatile__("mrs x1, cpacr_el1\n\
> 			orr x1, x1, #(0x3 << 20)\n\
> 			msr cpacr_el1, x1\n\
> 			isb" : : : "x1", "memory", "cc");
> }

> static void disable_fpsimd(void) {
> 	__asm__ __volatile__("mrs x1, cpacr_el1\n\
> 				and x1, x1, #~(0x3 << 20)\n\
> 				msr cpacr_el1, x1\n\
> 				isb" : : : "x1", "memory", "cc");
> }

Coding style: braces at the beginning of line, and you probably want to
make these functions inline.

> int xnarch_fault_fpu_p(struct ipipe_trap_data *d)
> {
> 	/* check if this is an FPU access trap to be handled by Xenomai */
> 	if(d->exception == IPIPE_TRAP_FPU_ACC){
> 		return 1;
> 	}
> 	/* FPU already enabled, propagate fault to kernel */
> 	return 0;
> }

return d->exception == IPIPE_TAP_FPU_ACC ?


> static inline struct fpsimd_state *get_fpu_owner(struct xnarchtcb *tcb) {
> 	return &(tcb->core.tsp->fpsimd_state);
> }

coding style, brace again

> void xnarch_leave_root(struct xnthread *root)
> {
> 	struct xnarchtcb *rootcb = xnthread_archtcb(root);
> 	rootcb->fpup = get_fpu_owner(rootcb);
> 	disable_fpsimd();
> }

This is not the place to disable fpu. The context switch is the place.


> void xnarch_save_fpu(struct xnthread *thread)
> {
> 	struct xnarchtcb *tcb = &(thread->tcb);
> 	if (xnarch_fpu_ptr(tcb))
> 		fpsimd_save_state(tcb->fpup);
> }

> void xnarch_switch_fpu(struct xnthread *from, struct xnthread *to)
> {
> 	struct fpsimd_state *const from_fpup = from ? from->tcb.fpup : NULL;
> 	struct fpsimd_state *const to_fpup = to->tcb.fpup;

> 	/*
> 	 * This only gets called if XNFPU flag is set, or if migrating to Linux.
> 	 * In both cases, this means turn on FPU and switch.
> 	 */
> 	enable_fpsimd();

> 	if (xnthread_test_state(to, XNROOT) == 0) {
> 		if (from_fpup == to_fpup)
> 			return;

> 		if (from_fpup)
> 			fpsimd_save_state(from_fpup);

> 		fpsimd_load_state(to_fpup);
> 	}
> 	else {
> 		/* Going to Linux. */
> 		if (from_fpup)
> 			fpsimd_save_state(from_fpup);

> 		fpsimd_load_state(to_fpup);
> 	}

When returning to root, you can also skip reloading the fpu if
from_fpu == to_fpu. If they are equal, the real-time threads have
not touched the fpu context, thus it is still valid and what needs
to be done is to simply reenable the fpu.


> int xnarch_handle_fpu_fault(struct xnthread *from, 
> 			struct xnthread *to, struct ipipe_trap_data *d)
> {
> 	spl_t s;

> 	if (xnthread_test_state(to, XNFPU))
> 		/* FPU is already enabled, probably an exception */
> 	   return 0;

You want to BUG() here, since the fpu exception is unequivocally
related to access to disabled fpu, if this happens, it means there
is a bug somewhere.


> 	xnlock_get_irqsave(&nklock, s);
> 	xnthread_set_state(to, XNFPU);
> 	xnlock_put_irqrestore(&nklock, s);

> 	xnarch_switch_fpu(from, to);

> 	return 1;

> }

> void xnarch_init_shadow_tcb(struct xnthread *thread)
> {
> 	spl_t s;
> 	struct xnarchtcb *tcb = xnthread_archtcb(thread);

> 	tcb->fpup = &(tcb->core.host_task->thread.fpsimd_state);

> 	xnlock_get_irqsave(&nklock, s);
> 	xnthread_clear_state(thread, XNFPU);
> 	xnlock_put_irqrestore(&nklock, s);

> }
> #endif /* CONFIG_XENO_ARCH_FPU */

I am not sure you need taking the nklock here, the thread is in its
initialization process, it is not known by the scheduler yet, so
nothing should be able to change its state concurrently.

> void xnarch_switch_to(struct xnthread *out, struct xnthread *in)
> {
> 	struct xnarchtcb *out_tcb = &out->tcb, *in_tcb = &in->tcb;
> 	struct mm_struct *prev_mm, *next_mm;
> 	struct task_struct *next;

> 	next = in_tcb->core.host_task;
> 	prev_mm = out_tcb->core.active_mm;

> 	next_mm = in_tcb->core.mm;
> 	if (next_mm == NULL) {
> 		in_tcb->core.active_mm = prev_mm;
> 		enter_lazy_tlb(prev_mm, next);
> 	} else {
> 		ipipe_switch_mm_head(prev_mm, next_mm, next);
> 		/*
> 		 * We might be switching back to the root thread,
> 		 * which we preempted earlier, shortly after "current"
> 		 * dropped its mm context in the do_exit() path
> 		 * (next->mm == NULL). In that particular case, the
> 		 * kernel expects a lazy TLB state for leaving the mm.
> 		 */
> 		if (next->mm == NULL)
> 			enter_lazy_tlb(prev_mm, next);
> 	}

> 	xnarch_tls_thread_switch(in_tcb->core.tip->task);
> 	xnarch_contextidr_thread_switch(in_tcb->core.tip->task);

> 	/* check if we need to switch FPU on return to Linux */
> 	if (xnthread_test_state(in, XNROOT) == 1)
> 		xnarch_switch_fpu(out, in);

No, doing this here is wrong. xnarch_switch_fpu is called by the
cobalt core at the right moment.

*
> 	/*
> 	 * Complete any pending TLB or cache maintenance on this CPU in case
> 	 * the thread migrates to a different CPU.
> 	 */
> 	dsb(ish);

> 	cpu_switch_to(out_tcb->core.tip->task, in_tcb->core.tip->task);
> }

You want to disable the fpu before calling cpu_switch_to. If
switching to a thread with XNFPU, xnarch_switch_fpu will be called,
which enables the fpu, and if switching to a thread without XNFPU,
we want the FPU to be disabled so that the task will take a fault
upon its first use of fpu.

-- 
					    Gilles.
https://click-hack.org

