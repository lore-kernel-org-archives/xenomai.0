References: <20180914151018.1226-1-henning.schild@siemens.com>
 <20180914151018.1226-5-henning.schild@siemens.com>
 <5a4e3043-b177-2d8b-fea4-e9365aafc8f2@siemens.com>
 <f488f920-9bee-0259-6375-10207c78b590@siemens.com>
 <20180917211848.60906825@md1pvb1c.ad001.siemens.net>
 <20180918181630.6cc34ab7@md1pvb1c.ad001.siemens.net>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <ea026f00-35f8-a012-cea3-fb0429c27054@siemens.com>
Date: Thu, 27 Sep 2018 09:08:31 +0200
MIME-Version: 1.0
In-Reply-To: <20180918181630.6cc34ab7@md1pvb1c.ad001.siemens.net>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Xenomai] [PATCHv2 4/4] cobalt/x86: add ipipe-4.14 eager fpu
 support
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Henning Schild <henning.schild@siemens.com>
Cc: xenomai@xenomai.org

On 18.09.18 18:16, Henning Schild wrote:
> Am Mon, 17 Sep 2018 21:18:48 +0200
> schrieb "[ext] Henning Schild" <henning.schild@siemens.com>:
> 
>> Am Mon, 17 Sep 2018 20:23:16 +0200
>> schrieb Jan Kiszka <jan.kiszka@siemens.com>:
>>
>>> On 17.09.18 20:17, Jan Kiszka wrote:
>>>> On 14.09.18 17:10, Henning Schild wrote:
>>>>> 4.14 is always eager, unfortunately we will need a few ifdefs
>>>>> inside the eager fpu support as well.
>>>>>
>>>>> Signed-off-by: Henning Schild <henning.schild@siemens.com>
>>>>> ---
>>>>>    .../arch/x86/include/asm/xenomai/wrappers.h   |  4 ++++
>>>>>    kernel/cobalt/arch/x86/thread.c               | 21
>>>>> ++++++++++++++++++- 2 files changed, 24 insertions(+), 1
>>>>> deletion(-)
>>>>>
>>>>> diff --git
>>>>> a/kernel/cobalt/arch/x86/include/asm/xenomai/wrappers.h
>>>>> b/kernel/cobalt/arch/x86/include/asm/xenomai/wrappers.h index
>>>>> a47730106..a4cc368a5 100644 ---
>>>>> a/kernel/cobalt/arch/x86/include/asm/xenomai/wrappers.h +++
>>>>> b/kernel/cobalt/arch/x86/include/asm/xenomai/wrappers.h @@ -32,6
>>>>> +32,10 @@ LINUX_VERSION_CODE < KERNEL_VERSION(4,5,0)
>>>>>    #define IPIPE_X86_FPU_EAGER
>>>>>    #endif
>>>>> +#if LINUX_VERSION_CODE >= KERNEL_VERSION(4,14,0)
>>>>> +#define IPIPE_X86_FPU_EAGER
>>>>> +#endif
>>>>> +
>>>>>    #if LINUX_VERSION_CODE < KERNEL_VERSION(4,2,0)
>>>>>    #include <asm/i387.h>
>>>>> diff --git a/kernel/cobalt/arch/x86/thread.c
>>>>> b/kernel/cobalt/arch/x86/thread.c index 18cf636e5..2668ce274
>>>>> 100644 --- a/kernel/cobalt/arch/x86/thread.c
>>>>> +++ b/kernel/cobalt/arch/x86/thread.c
>>>>> @@ -42,6 +42,7 @@ static struct kmem_cache *xstate_cache;
>>>>>    #define cpu_has_xsave boot_cpu_has(X86_FEATURE_XSAVE)
>>>>>    #endif
>>>>> +#ifndef IPIPE_X86_FPU_EAGER
>>>>>    #if LINUX_VERSION_CODE < KERNEL_VERSION(4,2,0)
>>>>>    #include <asm/i387.h>
>>>>>    #include <asm/fpu-internal.h>
>>>>> @@ -72,6 +73,9 @@ static inline void x86_fpregs_activate(struct
>>>>> task_struct *t) #define x86_xstate_alignment
>>>>> __alignof__(union fpregs_state) #endif
>>>>> +#else /* IPIPE_X86_FPU_EAGER */
>>>>> +#define x86_xstate_alignment        __alignof__(union
>>>>> fpregs_state) +#endif /* ! IPIPE_X86_FPU_EAGER */
>>>>>    #if LINUX_VERSION_CODE < KERNEL_VERSION(4,8,0)
>>>>>    /*
>>>>> @@ -465,9 +469,15 @@ void xnarch_leave_root(struct xnthread
>>>>> *root) // save fpregs from in-kernel use
>>>>>        copy_fpregs_to_fpstate(rootcb->kfpu);
>>>>>        kernel_fpu_enable();
>>>>> +#if LINUX_VERSION_CODE >= KERNEL_VERSION(4,14,0)
>>>>> +    // restore current's fpregs
>>>>> +    __cpu_invalidate_fpregs_state();
>>>>> +    switch_fpu_finish(&current->thread.fpu, smp_processor_id());
>>>>> +#else
>>>>>        // mark current thread as not owning the FPU anymore
>>>>>        if (&current->thread.fpu.fpstate_active)
>>>>>            fpregs_deactivate(&current->thread.fpu);
>>>>> +#endif
>>>>>    }
>>>>>    void xnarch_switch_fpu(struct xnthread *from, struct xnthread
>>>>> *to) @@ -528,7 +538,11 @@ void xnarch_init_shadow_tcb(struct
>>>>> xnthread *thread) #else /* IPIPE_X86_FPU_EAGER */
>>>>>        /* XNFPU is always set */
>>>>>        xnthread_set_state(thread, XNFPU);
>>>>> +#if LINUX_VERSION_CODE < KERNEL_VERSION(4,14,0)
>>>>>        fpu__activate_fpstate_read(&p->thread.fpu);
>>>>> +#else
>>>>> +    fpu__initialize(&p->thread.fpu);
>>>>> +#endif
>>>>>    #endif /* ! IPIPE_X86_FPU_EAGER */
>>>>>    }
>>>>> @@ -537,7 +551,12 @@ int mach_x86_thread_init(void)
>>>>>        xstate_cache = kmem_cache_create("cobalt_x86_xstate",
>>>>>                         fpu_kernel_xstate_size,
>>>>>                         x86_xstate_alignment,
>>>>> -                     SLAB_NOTRACK, NULL);
>>>>> +#if LINUX_VERSION_CODE < KERNEL_VERSION(4,14,0)
>>>>> +                     SLAB_NOTRACK,
>>>>> +#else
>>>>> +                     0,
>>>>> +#endif
>>>>> +                     NULL);
>>>>>        if (xstate_cache == NULL)
>>>>>            return -ENOMEM;
>>>>>     
>>>>
>>>> Thanks, taken the whole series to next so that we can move
>>>> forward. I've just changed "//" (C++) style comments to
>>>> "old-style" C. Kernel style. Please avoid them in the future.
>>>>      
>>
>> Sorry missed the // part of the review.
>>
>>> Forgot: Did you happen to try the series with stable-3.0.x as well?
>>> I consider them relevant for that branch as well, so that users can
>>> update the kernel. But I plan to leave them in next until we have
>>> ipipe kernels available and tested them a bit broader.
>>
>> Did not do that yet. I guess the ifdefs should all resolve to
>> lazy-fpu, making the series a no-op for lazy kernels. Will test
>> against 4.9 and 4.4 and confirm that my guess is right.
> 
> Might have gotten the question wrong in the first place. I did test
> xenomai (next) against ipipe 4.(4|9).y. After that i backported
> (cherry-picked) the changes right onto stable-3.0.x and tested against
> a lazy 4.4 and a 4.14. So i think all combinations should be tested.
> 

Applied all four to stable - looks good.

Jan

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

