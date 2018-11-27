Subject: Re: [PATCH] cobalt/kernel: Simplify mayday processing
References: <3e868e4f-7bd5-2874-d72b-fc2449ef4b65@siemens.com>
 <111becaa-9e0f-f8ad-4802-62f51379fc07@xenomai.org>
 <efcd107e-d48d-6dac-96e0-890203c072ba@siemens.com>
 <5c1fae9d-3098-1f5b-bc51-fa7f9a798f1e@xenomai.org>
 <967ff4fb-2272-88be-f46c-4b7c40e64956@siemens.com>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <bef5cc29-6379-8cd8-4a1e-4cc8a10761a4@xenomai.org>
Date: Tue, 27 Nov 2018 19:54:42 +0100
MIME-Version: 1.0
In-Reply-To: <967ff4fb-2272-88be-f46c-4b7c40e64956@siemens.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Jan Kiszka <jan.kiszka@siemens.com>, Xenomai <xenomai@xenomai.org>, Steven Seeger <steven.seeger@nasa.gov>, Dmitriy Cherkasov <dmitriy@oss-tech.org>

On 11/27/18 6:44 PM, Jan Kiszka wrote:
> On 08.11.18 14:24, Philippe Gerum wrote:
>> On 11/8/18 2:14 PM, Jan Kiszka wrote:
>>> On 08.11.18 14:05, Philippe Gerum wrote:
>>>> On 11/5/18 1:20 PM, Jan Kiszka wrote:
>>>>> The mayday mechanism exists in order to kick a xenomai userspace task
>>>>> into secondary mode while it is running userspace code. For that,
>>>>> we ask
>>>>> I-pipe to call us back when the task was interrupted and is about to
>>>>> return to userspace.
>>>>>
>>>>> So far we defer the relaxation from that callback via a VDSO-like
>>>>> mechanism that triggers a special syscall to the return path of that
>>>>> very same syscall. However, that is not desirable because it is a
>>>>> complex, arch-specific mechanism that can easily break and,
>>>>> specifically, that destroys the backtrace of ptraced tasks.
>>>>>
>>>>> Fortunately, we can fulfill the needs of mayday also by relaxing
>>>>> the task directly from the mayday callback. Tested successfully on
>>>>> x86-64 and ARM.
>>>>
>>>> ARM-wise, this change requires ipipe-core-4.14.71-arm-3 or later to
>>>> work
>>>> properly. This method would cause an interrupt state breakage with any
>>>> older ARM patch.
>>>
>>> That would be a change compared to my past ARM experiments (4.x, if not
>>> 3.x based). Can you point me to the problem in more details?
>>>
>>
>> Calling    __ipipe_notify_trap(IPIPE_TRAP_MAYDAY, regs) may result in
>> re-enabling IRQs unexpectedly for the caller, due to the callee
>> relaxing. AFAIR, a core debug level assertion should trip when that
>> happens.
>>
> 
> Coming back to that topic: Just tested ARM on 4.4 with all debug
> switches of core and ipipe enabled but nothing triggered. So, either the
> issue is more subtle, or it not really an issue.

xnthread_relax() forces hard irqs on:

__ipipe_exit_irq -> back from irq_handler (entry-armv.S), so you end up
running the interrupt return path with irqs on both for svc or usr
modes, including the regular preemption management stuff which assumes
the opposite.

WARN_ON_ONCE(!hard_irqs_disabled()) should trigger from
__ipipe_check_root_interruptible() if added there.

> 
> I suppose I need more background here to understand the risk you see. If
> there is a problem, I'd either like to backport a solution from 4.14 or
> detect what the kernel supports and scale down mayday depending on that,
> at least on ARM.
> 
> BTW, this is the call path we are talking about:
> 
> #0  handle_mayday_event (regs=<optimized out>) at
> ../kernel/xenomai/posix/process.c:1028
> #1  0xc02c3c70 in __ipipe_notify_trap (exception=9, regs=0xece07fb0) at
> ../kernel/ipipe/core.c:1065
> #2  0xc02c52a8 in __ipipe_call_mayday (regs=0xece07fb0) at
> ../kernel/ipipe/core.c:1610
> #3  0xc021e448 in __ipipe_exit_irq (regs=<optimized out>) at
> ../arch/arm/kernel/ipipe.c:357
> #4  0xc020a57c in __ipipe_exit_irq (regs=<optimized out>) at
> ../arch/arm/kernel/ipipe.c:396
> #5  __ipipe_grab_irq (irq=<optimized out>, regs=<optimized out>) at
> ../arch/arm/kernel/ipipe.c:395
> #6  0xc020ac0c in ipipe_handle_multi_irq (regs=<optimized out>,
> irq=<optimized out>) at ../arch/arm/include/asm/ipipe.h:232
> #7  ipipe_handle_domain_irq (regs=<optimized out>, hwirq=<optimized
> out>, domain=<optimized out>) at ../arch/arm/include/asm/ipipe.h:249
> #8  gic_handle_irq (regs=0xece07fb0) at ../drivers/irqchip/irq-gic.c:367
> 
> I wonder what the difference is to a normal Xenomai reschedules at the
> end of an interrupt.
> 

The rescheduling bits for xnthread_relax() are very specific, so that we
can transfer control of the current context to another scheduler logic
in a safe way. Looking at the way XNRELAX is dealt with by
xnthread_suspend() may help.

-- 
Philippe.

