References: <E1fxEEU-0004LE-Ln@xenomai.org>
 <7bf36155-eb1a-30a3-42ce-5256342dc74f@siemens.com>
 <35f40a90-1ef5-323b-b1ef-7d282388347d@xenomai.org>
 <b426ee0a-57a0-1d12-cbde-a591c87eb918@xenomai.org>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <ccb5939c-0b40-b663-3f3e-055d9070b487@siemens.com>
Date: Wed, 5 Sep 2018 09:57:54 +0200
MIME-Version: 1.0
In-Reply-To: <b426ee0a-57a0-1d12-cbde-a591c87eb918@xenomai.org>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Xenomai] [PATCH] cobalt/kernel: always use explicit
 preprocessor conditionals
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Philippe Gerum <rpm@xenomai.org>, xenomai@xenomai.org

On 2018-09-05 09:48, Philippe Gerum wrote:
> On 09/05/2018 09:44 AM, Philippe Gerum wrote:
>> On 09/04/2018 07:48 PM, Jan Kiszka wrote:
>>> On 2018-09-04 15:31, Philippe Gerum wrote:
>>>> Testing debug switches using '#if XENO_DEBUG(<feat>)' may confuse the
>>>> build system's dependency tracker, breaking the build, or even
>>>> producing a non-bootable kernel in extreme cases. Typically, turning
>>>> on/off the lock debugging code - usually in absence of any other
>>>> change - may cause the following error to pop up at the link stage:
>>>>
>>>> ---
>>>> MODPOST vmlinux.o
>>>> kernel/xenomai/lock.o: In function `____xnlock_get':
>>>> linux/include/xenomai/cobalt/kernel/lock.h:184: undefined reference to
>>>> `xnlock_dbg_prepare_acquire'
>>>> linux/include/xenomai/cobalt/kernel/lock.h:189: undefined reference to
>>>> `xnlock_dbg_acquired'
>>>> kernel/xenomai/lock.o: In function `____xnlock_put':
>>>> linux/include/xenomai/cobalt/kernel/lock.h:196: undefined reference to
>>>> `xnlock_dbg_release'
>>>> ---
>>>>
>>>> Replace all occurrences of the confusing conditionals with the
>>>> equivalent expression explicitly testing the debug symbol.
>>>>
>>>> Signed-off-by: Philippe Gerum <rpm@xenomai.org>
>>>> ---
>>>>    include/cobalt/kernel/assert.h         |  2 +-
>>>>    include/cobalt/kernel/lock.h           |  6 +++---
>>>>    include/cobalt/kernel/sched-sporadic.h |  2 +-
>>>>    include/cobalt/kernel/synch.h          |  2 +-
>>>>    include/cobalt/kernel/tree.h           |  2 +-
>>>>    kernel/cobalt/bufd.c                   | 10 +++++-----
>>>>    kernel/cobalt/debug.c                  |  2 +-
>>>>    kernel/cobalt/intr.c                   |  2 +-
>>>>    kernel/cobalt/posix/process.c          |  2 +-
>>>>    kernel/cobalt/procfs.c                 |  2 +-
>>>>    kernel/cobalt/sched-sporadic.c         |  4 ++--
>>>>    kernel/cobalt/synch.c                  |  2 +-
>>>>    12 files changed, 19 insertions(+), 19 deletions(-)
>>>>
>>>> diff --git a/include/cobalt/kernel/assert.h
>>>> b/include/cobalt/kernel/assert.h
>>>> index 2d2d65396..86d0a480f 100644
>>>> --- a/include/cobalt/kernel/assert.h
>>>> +++ b/include/cobalt/kernel/assert.h
>>>> @@ -63,7 +63,7 @@
>>>>    #define realtime_cpu_only()    XENO_BUG_ON(CONTEXT,
>>>> !xnsched_supported_cpu(ipipe_processor_id()))
>>>>    #define thread_only()        XENO_BUG_ON(CONTEXT,
>>>> xnsched_interrupt_p())
>>>>    #define irqoff_only()        XENO_BUG_ON(CONTEXT,
>>>> hard_irqs_disabled() == 0)
>>>> -#if XENO_DEBUG(LOCKING)
>>>> +#ifdef CONFIG_XENO_OPT_DEBUG_LOCKING
>>>>    #define atomic_only()        XENO_BUG_ON(CONTEXT,
>>>> (xnlock_is_owner(&nklock) && hard_irqs_disabled()) == 0)
>>>>    #define preemptible_only()    XENO_BUG_ON(CONTEXT,
>>>> xnlock_is_owner(&nklock) || hard_irqs_disabled())
>>>>    #else
>>>> diff --git a/include/cobalt/kernel/lock.h b/include/cobalt/kernel/lock.h
>>>> index 36f81688a..99c7848e8 100644
>>>> --- a/include/cobalt/kernel/lock.h
>>>> +++ b/include/cobalt/kernel/lock.h
>>>> @@ -63,7 +63,7 @@ typedef unsigned long spl_t;
>>>>     */
>>>>    #define spltest()   ipipe_test_head()
>>>>    -#if XENO_DEBUG(LOCKING)
>>>> +#ifdef CONFIG_XENO_OPT_DEBUG_LOCKING
>>>>      struct xnlock {
>>>>        unsigned owner;
>>>> @@ -152,7 +152,7 @@ static inline int xnlock_dbg_release(struct xnlock
>>>> *lock)
>>>>      #endif /* !XENO_DEBUG(LOCKING) */
>>>>    -#if defined(CONFIG_SMP) || XENO_DEBUG(LOCKING)
>>>> +#if defined(CONFIG_SMP) || defined(CONFIG_XENO_OPT_DEBUG_LOCKING)
>>>>      #define xnlock_get(lock)        __xnlock_get(lock
>>>> XNLOCK_DBG_CONTEXT)
>>>>    #define xnlock_put(lock)        __xnlock_put(lock  XNLOCK_DBG_CONTEXT)
>>>> @@ -209,7 +209,7 @@ int ___xnlock_get(struct xnlock *lock /*, */
>>>> XNLOCK_DBG_CONTEXT_ARGS);
>>>>    void ___xnlock_put(struct xnlock *lock /*, */ XNLOCK_DBG_CONTEXT_ARGS);
>>>>    #endif /* out of line xnlock */
>>>>    -#if XENO_DEBUG(LOCKING)
>>>> +#ifdef CONFIG_XENO_OPT_DEBUG_LOCKING
>>>>    /* Disable UP-over-SMP kernel optimization in debug mode. */
>>>>    #define __locking_active__  1
>>>>    #else
>>>> diff --git a/include/cobalt/kernel/sched-sporadic.h
>>>> b/include/cobalt/kernel/sched-sporadic.h
>>>> index 0eade47b0..50ca406c4 100644
>>>> --- a/include/cobalt/kernel/sched-sporadic.h
>>>> +++ b/include/cobalt/kernel/sched-sporadic.h
>>>> @@ -56,7 +56,7 @@ struct xnsched_sporadic_data {
>>>>    };
>>>>      struct xnsched_sporadic {
>>>> -#if XENO_DEBUG(COBALT)
>>>> +#ifdef CONFIG_XENO_OPT_DEBUG_COBALT
>>>>        unsigned long drop_retries;
>>>>    #endif
>>>>    };
>>>> diff --git a/include/cobalt/kernel/synch.h
>>>> b/include/cobalt/kernel/synch.h
>>>> index f5ac217ed..08056055a 100644
>>>> --- a/include/cobalt/kernel/synch.h
>>>> +++ b/include/cobalt/kernel/synch.h
>>>> @@ -101,7 +101,7 @@ static inline struct xnthread
>>>> *xnsynch_owner(struct xnsynch *synch)
>>>>    #define xnsynch_owner_check(synch, thread) \
>>>>        xnsynch_fast_owner_check((synch)->fastlock, thread->handle)
>>>>    -#if XENO_DEBUG(MUTEX_RELAXED)
>>>> +#ifdef CONFIG_XENO_OPT_DEBUG_MUTEX_RELAXED
>>>>      void xnsynch_detect_relaxed_owner(struct xnsynch *synch,
>>>>                      struct xnthread *sleeper);
>>>> diff --git a/include/cobalt/kernel/tree.h b/include/cobalt/kernel/tree.h
>>>> index 9c751cc02..c52ee3220 100644
>>>> --- a/include/cobalt/kernel/tree.h
>>>> +++ b/include/cobalt/kernel/tree.h
>>>> @@ -83,7 +83,7 @@ struct xnid *xnid_fetch(struct rb_root *t, xnkey_t key)
>>>>      static inline int xnid_remove(struct rb_root *t, struct xnid *xnid)
>>>>    {
>>>> -#if XENO_DEBUG(COBALT)
>>>> +#ifdef CONFIG_XENO_OPT_DEBUG_COBALT
>>>>        if (xnid_fetch(t, xnid->key) != xnid)
>>>>            return -ENOENT;
>>>>    #endif
>>>> diff --git a/kernel/cobalt/bufd.c b/kernel/cobalt/bufd.c
>>>> index 9b41b6ad6..3b79505d5 100644
>>>> --- a/kernel/cobalt/bufd.c
>>>> +++ b/kernel/cobalt/bufd.c
>>>> @@ -493,7 +493,7 @@ ssize_t xnbufd_unmap_uread(struct xnbufd *bufd)
>>>>    {
>>>>        preemptible_only();
>>>>    -#if XENO_DEBUG(COBALT)
>>>> +#ifdef CONFIG_XENO_OPT_DEBUG_COBALT
>>>>        bufd->b_ptr = (caddr_t)-1;
>>>>    #endif
>>>>        return bufd->b_off;
>>>> @@ -551,7 +551,7 @@ ssize_t xnbufd_unmap_uwrite(struct xnbufd *bufd)
>>>>        if (bufd->b_len > sizeof(bufd->b_buf))
>>>>            xnfree(bufd->b_carry);
>>>>    done:
>>>> -#if XENO_DEBUG(COBALT)
>>>> +#ifdef CONFIG_XENO_OPT_DEBUG_COBALT
>>>>        bufd->b_ptr = (caddr_t)-1;
>>>>    #endif
>>>>        return ret ?: (ssize_t)len;
>>>> @@ -592,7 +592,7 @@ EXPORT_SYMBOL_GPL(xnbufd_unmap_uwrite);
>>>>     */
>>>>    void xnbufd_invalidate(struct xnbufd *bufd)
>>>>    {
>>>> -#if XENO_DEBUG(COBALT)
>>>> +#ifdef CONFIG_XENO_OPT_DEBUG_COBALT
>>>>        bufd->b_ptr = (caddr_t)-1;
>>>>    #endif
>>>>        if (bufd->b_carry) {
>>>> @@ -620,7 +620,7 @@ EXPORT_SYMBOL_GPL(xnbufd_invalidate);
>>>>     */
>>>>    ssize_t xnbufd_unmap_kread(struct xnbufd *bufd)
>>>>    {
>>>> -#if XENO_DEBUG(COBALT)
>>>> +#ifdef CONFIG_XENO_OPT_DEBUG_COBALT
>>>>        bufd->b_ptr = (caddr_t)-1;
>>>>    #endif
>>>>        return bufd->b_off;
>>>> @@ -643,7 +643,7 @@ EXPORT_SYMBOL_GPL(xnbufd_unmap_kread);
>>>>     */
>>>>    ssize_t xnbufd_unmap_kwrite(struct xnbufd *bufd)
>>>>    {
>>>> -#if XENO_DEBUG(COBALT)
>>>> +#ifdef CONFIG_XENO_OPT_DEBUG_COBALT
>>>>        bufd->b_ptr = (caddr_t)-1;
>>>>    #endif
>>>>        return bufd->b_off;
>>>> diff --git a/kernel/cobalt/debug.c b/kernel/cobalt/debug.c
>>>> index 74022c516..af9a95ab6 100644
>>>> --- a/kernel/cobalt/debug.c
>>>> +++ b/kernel/cobalt/debug.c
>>>> @@ -549,7 +549,7 @@ static inline void init_thread_relax_trace(struct
>>>> xnthread *thread)
>>>>      #endif /* !XENO_OPT_DEBUG_TRACE_RELAX */
>>>>    -#if XENO_DEBUG(LOCKING)
>>>> +#ifdef CONFIG_XENO_OPT_DEBUG_LOCKING
>>>>      void xnlock_dbg_prepare_acquire(unsigned long long *start)
>>>>    {
>>>> diff --git a/kernel/cobalt/intr.c b/kernel/cobalt/intr.c
>>>> index fb27a3295..69faa23ba 100644
>>>> --- a/kernel/cobalt/intr.c
>>>> +++ b/kernel/cobalt/intr.c
>>>> @@ -531,7 +531,7 @@ static inline void xnintr_irq_detach(struct xnintr
>>>> *intr)
>>>>    #else /* !CONFIG_XENO_OPT_SHIRQ */
>>>>      struct xnintr_vector {
>>>> -#if defined(CONFIG_SMP) || XENO_DEBUG(LOCKING)
>>>> +#if defined(CONFIG_SMP) || defined(CONFIG_XENO_OPT_DEBUG_LOCKING)
>>>>        DECLARE_XNLOCK(lock);
>>>>    #endif /* CONFIG_SMP || XENO_DEBUG(LOCKING) */
>>>>    } ____cacheline_aligned_in_smp;
>>>> diff --git a/kernel/cobalt/posix/process.c
>>>> b/kernel/cobalt/posix/process.c
>>>> index dbcb81ef8..50f752f13 100644
>>>> --- a/kernel/cobalt/posix/process.c
>>>> +++ b/kernel/cobalt/posix/process.c
>>>> @@ -751,7 +751,7 @@ static inline int handle_exception(struct
>>>> ipipe_trap_data *d)
>>>>         * running in primary mode, move it to the Linux domain,
>>>>         * leaving the kernel process the exception.
>>>>         */
>>>> -#if XENO_DEBUG(COBALT) || XENO_DEBUG(USER)
>>>> +#if defined(CONFIG_XENO_OPT_DEBUG_COBALT) ||
>>>> defined(CONFIG_XENO_OPT_DEBUG_USER)
>>>>        if (!user_mode(d->regs)) {
>>>>            xntrace_panic_freeze();
>>>>            printk(XENO_WARNING
>>>> diff --git a/kernel/cobalt/procfs.c b/kernel/cobalt/procfs.c
>>>> index ade13cf1c..d1f01f038 100644
>>>> --- a/kernel/cobalt/procfs.c
>>>> +++ b/kernel/cobalt/procfs.c
>>>> @@ -27,7 +27,7 @@
>>>>    #include <xenomai/version.h>
>>>>    #include "debug.h"
>>>>    -#if XENO_DEBUG(LOCKING)
>>>> +#ifdef CONFIG_XENO_OPT_DEBUG_LOCKING
>>>>      static int lock_vfile_show(struct xnvfile_regular_iterator *it,
>>>> void *data)
>>>>    {
>>>> diff --git a/kernel/cobalt/sched-sporadic.c
>>>> b/kernel/cobalt/sched-sporadic.c
>>>> index d2a1f76d0..9cbfa5be3 100644
>>>> --- a/kernel/cobalt/sched-sporadic.c
>>>> +++ b/kernel/cobalt/sched-sporadic.c
>>>> @@ -24,7 +24,7 @@
>>>>      static void sporadic_post_recharge(struct xnthread *thread,
>>>> xnticks_t budget);
>>>>    -#if XENO_DEBUG(COBALT)
>>>> +#ifdef CONFIG_XENO_OPT_DEBUG_COBALT
>>>>      static inline void sporadic_note_late_drop(struct xnsched *sched)
>>>>    {
>>>> @@ -236,7 +236,7 @@ static void xnsched_sporadic_init(struct xnsched
>>>> *sched)
>>>>         * share the same priority scale, with the addition of budget
>>>>         * management for the sporadic ones.
>>>>         */
>>>> -#if XENO_DEBUG(COBALT)
>>>> +#ifdef CONFIG_XENO_OPT_DEBUG_COBALT
>>>>        sched->pss.drop_retries = 0;
>>>>    #endif
>>>>    }
>>>> diff --git a/kernel/cobalt/synch.c b/kernel/cobalt/synch.c
>>>> index 7773a08e5..32df635a8 100644
>>>> --- a/kernel/cobalt/synch.c
>>>> +++ b/kernel/cobalt/synch.c
>>>> @@ -902,7 +902,7 @@ void xnsynch_release_all_ownerships(struct
>>>> xnthread *thread)
>>>>    }
>>>>    EXPORT_SYMBOL_GPL(xnsynch_release_all_ownerships);
>>>>    -#if XENO_DEBUG(MUTEX_RELAXED)
>>>> +#ifdef CONFIG_XENO_OPT_DEBUG_MUTEX_RELAXED
>>>>      /*
>>>>     * Detect when a thread is about to sleep on a synchronization
>>>>
>>>
>>> Confused: This is not for next, is it?
>>>
>>> E.g. that hunk above does not apply there anymore, for about a year...
>>>
>>
>> This is preferably aimed at the upcoming master at the moment. This does
>> not change any internal or external API, fixing an annoying limitation
>> of the watchdog.
> 
> The quite annoying issue is about generating bad kernels in this case,
> same reasoning with the watchdog issue.
> 

As it's based on a seriously old code base, I can't really review this 
patch. Please rebase everything first.

Upcoming master will simply be current next + X as soon as we agree on 
the workflow I proposed. If that does not work via fast-forward merge, 
we may need a hard reset once. I'll look into that later today.

Jan

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

