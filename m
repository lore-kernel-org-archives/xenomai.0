Message-ID: <4C06329B.6010106@domain.hid>
Date: Wed, 02 Jun 2010 12:29:47 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <20100601135005.GA5483@domain.hid>	
	<1275402757.27918.151.camel@domain.hid>	
	<20100601155403.GA8240@domain.hid>
	<4C053C51.4090903@domain.hid>	 <4C061823.70005@domain.hid>	
	<1275470136.18250.16.camel@domain.hid>	
	<4C062246.40107@domain.hid>	
	<1275470925.18250.18.camel@domain.hid>	
	<4C06265C.3030108@domain.hid>
	<1275473174.18250.36.camel@domain.hid>
In-Reply-To: <1275473174.18250.36.camel@domain.hid>
Content-Type: text/plain; charset=UTF-8
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
To: Philippe Gerum <rpm@xenomai.org>
Cc: Jan Kiszka <jan.kiszka@domain.hid>, "xenomai@xenomai.org" <xenomai@xenomai.org>

Philippe Gerum wrote:
> On Wed, 2010-06-02 at 11:37 +0200, Gilles Chanteperdrix wrote:
>> Philippe Gerum wrote:
>>> On Wed, 2010-06-02 at 11:20 +0200, Jan Kiszka wrote:
>>>> Philippe Gerum wrote:
>>>>> On Wed, 2010-06-02 at 10:36 +0200, Gilles Chanteperdrix wrote:
>>>>>> Jan Kiszka wrote:
>>>>>>> Tschaeche IT-Services wrote:
>>>>>>>> On Tue, Jun 01, 2010 at 04:32:37PM +0200, Philippe Gerum wrote:
>>>>>>>>> Not in the absence of syscall. We thought about this once already, when
>>>>>>>>> considering how a watchdog preempting a runaway task in primary mode
>>>>>>>>> could force a secondary mode switch: there is no sane and easy solution
>>>>>>>>> to this unfortunately.
>>>>>>>> This is exactly Sigmatek's problem: Our customers develop code
>>>>>>>> within our debugging/development environment. We want to catch
>>>>>>>> this situation (the developer implements a while(1)) with a
>>>>>>>> watchdog throwing SIGTRAP so that our debugger gets active
>>>>>>>> and can locate the problem according to the stack frame...
>>>>>>> CONFIG_XENO_OPT_WATCHDOG is probably what you are looking for. It tries
>>>>>>> to catch "well-behaving" broken threads via SIGDEBUG and kills the
>>>>>>> hopelessly broken rest - system alive again.
>>>>>>>
>>>>>>> You can then debug the former and need to do code review on the latter.
>>>>>>> Or you could also try to add some loop-breaking Xenomai syscalls (or
>>>>>>> even more clever checks) to library services the code under suspect
>>>>>>> usually invokes.
>>>>>> I am afraid "well-behaving" means emitting syscalls. We have a radical
>>>>>> way to cause a SIGSEGV to be sent to a thread having run amok: set its
>>>>>> PC to an invalid address (after having printed the real PC). gdb will
>>>>>> not be able to print where the program stopped, but should be able to
>>>>>> print the backtrace.
>>>>>>
>>>>> Actually, we could extend this logic and forge a stack frame to return
>>>>> to the preempted application code via some userland trampoline code,
>>>>> doing the switch:
>>>>>
>>>>> [watchdog trigger]
>>>>> 	forge_return_frame(on =regs->sp, to =regs->pc);
>>>>> 	regs->pc = __oops_I_did_it_again;
>>>>>
>>>>> __oops_I_did_it_again:
>>>>> 	__xn_migrate(LINUX_DOMAIN);
>>>>> 	ret (via forged frame)
>>>> Yep, that's what came to my mind as well. But the __oops_I_did_it_again
>>>> part has to reside in user space, no?
>>> Clearly, yes. Either we map this explictly, or we just make sure to
>>> compile it in each app, and pass its address at skin binding time. Our
>>> text is mmlocked anyway.
>>>
>>>>> The thing is, that this brings in some arch-dep code to forge a stack
>>>>> frame (like the kernel uses for signals), that should rather live in the
>>>>> pipeline core.
>>>> Actually, we are then close to enabling signal delivery outside syscalls...
>>>>
>>> Yes, looks like.
>> When thinking about this real signals things, I was thinking about
>> putting the forging code into Xenomai (the code is the same for all
>> kernel versions, so there is no reason to put it into the I-pipe, and we
>> may have to emit a special syscall to restore the context when handling
>> the signal is done). What we need the I-pipe for, however, is to trigger
>> some event on the way back to user-space.
>>
> 
> A reason to have this code in the pipeline core is because we would
> duplicate the setup_rt_frame code already available from the vanilla
> kernel. It's a bit like xnarch_switch_to: we used to open code most of
> it in our arch-dep code, mostly duplicating the vanilla switch code, but
> having switch_mm() ironed enough - on arm and powerpc at least - to be
> callable from the Xenomai domain as well proved to be a serious relief.
> 
> Granted, the signal code is unlikely to change a lot, given the strong
> ABI requirements this has wrt the glibc, but I'm always reluctant to
> introduce duplicates at both ends of the system; I would rather factor
> out that code and make it available to both domains, if that makes
> sense.

I even had written some piece of code for x86 (completely untested).

#include <asm/ptrace.h>

#define __FIX_EFLAGS	(X86_EFLAGS_AC | X86_EFLAGS_OF | \
			 X86_EFLAGS_DF | X86_EFLAGS_TF | X86_EFLAGS_SF | \
			 X86_EFLAGS_ZF | X86_EFLAGS_AF | X86_EFLAGS_PF | \
			 X86_EFLAGS_CF)

#ifdef CONFIG_X86_32
# define FIX_EFLAGS	(__FIX_EFLAGS | X86_EFLAGS_RF)
#else
# define FIX_EFLAGS	__FIX_EFLAGS
#endif

#if LINUX_VERSION_CODE < KERNEL_VERSION(2, 6, 11)
#define hal_fpu_init_p(task)   ((task)->used_math)
#define hal_set_fpu_init(task) ((task)->used_math = 1)
#else
#define hal_fpu_init_p(task)   tsk_used_math(task)
#define hal_set_fpu_init(task) set_stopped_child_used_math(task)
#endif

void __user *hal_push(struct pt_regs *regs, void *chunk, size_t size)
{
	unsigned long sp = regs->sp;

	sp -= size;
	if (__xn_copy_to_user((void __user *)sp, chunk, size))
		return ERR_PTR(-EFAULT);
	
	regs->sp = sp;

	return (void __user *)sp;
}

#ifdef CONFIG_X86_32
struct sigtest_sigframe {
	u32 pretcoder;
	void *arg1;
	void *arg2;
	void __user *math;
	struct pt_regs regs;
};

static unsigned long align_sigframe(unsigned long sp)
{
	return ((sp + 4) & -16ul) - 4;
}

void hal_save_fpu(x86_fpustate *fpup)
{
	if (cpu_has_fxsr)
		__asm__ __volatile__("fxsave %0; fnclex":"=m"(*fpup));
	else
		__asm__ __volatile__("fnsave %0; fwait":"=m"(*fpup));
}

void hal_restore_fpu(x86_fpustate *fpup)
{
	clts();

	if (cpu_has_fxsr)
		__asm__ __volatile__("fxrstor %0": /* no output */ :"m"(*fpup));
	else
		__asm__ __volatile__("frstor %0": /* no output */ :"m"(*fpup));
}

void hal_init_fpu(void)
{
	__asm__ __volatile__("clts; fninit");

	if (cpu_has_xmm) {
		unsigned long __mxcsr = 0x1f80UL & 0xffbfUL;
		__asm__ __volatile__("ldmxcsr %0"::"m"(__mxcsr));
	}
}

int hal_trigger_cb(struct pt_regs *regs, void *fpup,
		   void __user *cb, void __user *ret, void *arg1, void *arg2)
{
	struct sigtest_sigframe __user *frame;
	unsigned long sp = regs->sp;
	unsigned long flags;

	local_irq_save_hw(flags);
	if (wrap_test_fpu_used(current) || hal_fpu_init_p(current)) {
		if (wrap_test_fpu_used(current)) {
			hal_save_fpu(fpup);
			wrap_clear_fpu_used(current);
		}
		if (__xn_copy_to_user((void __user *)sp, fpup, sizeof(*fpup))) {
			local_irq_restore_hw(flags);
			return -EFAULT;
		}
		k_frame->math = (void __user *)sp;
	} else
		k_frame->math = NULL;
	local_irq_restore_hw(flags);

	sp = align_sigframe(sp - sizeof(*frame));

	frame = (struct sigtest_sigframe __user *)sp;

	k_frame->pretcoder = ret;
	k_frame->arg1 = arg1;
	k_frame->arg2 = arg2;

	if (__xn_copy_to_user(frame, k_frame, 
			      offsetof(struct sigtest_sigframe, regs)))
		return -EFAULT;

	if (__xn_copy_to_user(&frame->regs, regs, sizeof(*regs)))
		return -EFAULT;
	
	regs->sp = sp;
	regs->ip = (unsigned long)cb;
	regs->ax = (unsigned long)arg1;
	regs->dx = (unsigned long)arg2;
	regs->cx = 0;
	
	regs->ds = __USER_DS;
	regs->es = __USER_DS;
	regs->ss = __USER_DS;
	regs->cs = __USER_CS;

	return 0;
}

int hal_restore_regs(struct pt_regs *regs, void *fpup)
{
	struct sigtest_sigframe __user *frame;
	unsigned long orig_flags;
	unsigned long flags;
	void __user *math;

	frame = (struct sigtest_sigframe __user *)(regs->sp - 8);

	orig_flags = regs->flags;

	if (__xn_copy_from_user(&math, &frame->math, sizeof(math)))
		return -EFAULT;
	if (__xn_copy_from_user(regs, &frame->regs, sizeof(*regs)))
		return -EFAULT;

	set_user_gs(regs, regs->gs);
	regs->cs |= 3;
	regs->ss |= 3;
	regs->flags = (orig_flags & ~FIX_EFLAGS) | (regs->flags & FIX_EFLAGS);

	local_irq_save_hw(flags);
	if (math) {
		if (__xn_copy_from_user(fpup, math, sizeof(*fpup))) {
			local_irq_restore_hw(flags);
			return -EFAULT;
		}
		hal_restore_fpu(fpup);
	} else if (hal_fpu_init_p(current)) {
		/* sighandler used fpu, restore the init state. */
		hal_init_fpu();
		wrap_set_fpu_used(current);
	}
	local_irq_restore_hw(flags);
}
#else /* CONFIG_X86_64 */
#endif /* CONFIG_X86_64 */


> 


-- 
					    Gilles.

