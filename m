Message-ID: <48ABDD32.6050400@domain.hid>
Date: Wed, 20 Aug 2008 11:00:34 +0200
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <48AAF7DB.1080603@domain.hid> <48AB1B29.4040001@domain.hid>
	<48AB1EE6.8070003@domain.hid> <48AB241D.9000308@domain.hid>
	<48AB2560.5060804@domain.hid> <48AB2948.1060209@domain.hid>
	<48AB2E7A.4050606@domain.hid>
In-Reply-To: <48AB2E7A.4050606@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] [BUG] Lock stealing is borken
Reply-To: rpm@xenomai.org
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: Jan Kiszka <jan.kiszka@domain.hid>, xenomai-core <xenomai@xenomai.org>

Jan Kiszka wrote:
> Philippe Gerum wrote:
>> Jan Kiszka wrote:
>>> Philippe Gerum wrote:
>>>> Jan Kiszka wrote:
>>>>> Philippe Gerum wrote:
>>>>>> Jan Kiszka wrote:
>>>>>>> Hi,
>>>>>>>
>>>>>>> bad news, everyone :(. According to the result of some lengthy debug
>>>>>>> session with a customer and several ad-hoc lttng instrumentations, we
>>>>>>> have a fatal bug in the nucleus' implementation of the lock stealing
>>>>>>> algorithm. Consider this scenario:
>>>>>>>
>>>>>>> 1. Thread A acquires Mutex X successfully, ie. it leaves the (in this
>>>>>>>    case) rt_mutex_acquire service, and its XNWAKEN flag is therefore
>>>>>>>    cleared.
>>>>>>>
>>>>>>> 2. Thread A blocks on some further Mutex Y (in our case it was a
>>>>>>>    semaphore, but that doesn't matter).
>>>>>>>
>>>>>>> 3. Thread B signals the availability of Mutex Y to Thread A, thus it
>>>>>>>    also set XNWAKEN in Thread A. But Thread A is not yet scheduled on
>>>>>>>    its CPU.
>>>>>>>
>>>>>>> 4. Thread C tries to acquire Mutex X, finds it assigned to Thread A, but
>>>>>>>    also notices that the XNWAKEN flag of Thread A is set. Thus it steals
>>>>>>>    the mutex although Thread A already entered the critical section -
>>>>>>>    and hell breaks loose...
>>>>>>>
>>>>>> See commit #3795, and change log entry from 2008-05-15. Unless I misunderstood
>>>>>> your description, this bug was fixed in 2.4.4.
>>>>> Oh, fatally missed that fix.
>>>>>
>>>>> Anyway, the patch looks a bit unclean to me. Either you are lacking
>>>>> wwake = NULL in xnpod_suspend_thread, or the whole information encoded
>>>>> in XNWAKEN can already be covered by wwake directly.
>>>>>
>>>> Clearing wwake has to be done when returning from xnsynch_sleep_on, only when
>>>> the code knows that ownership is eventually granted to the caller; making such a
>>>> decision in xnpod_suspend_thread() would be wrong.
>>> What about
>>>
>>> http://www.rts.uni-hannover.de/xenomai/lxr/source/ksrc/nucleus/pod.c#1411
>>>
>>> then?
>>>
>> That portion of code applies _before_ the thread enters suspended state. We
>> bother for the other side, i.e. when it resumes from actual suspension, until it
>> has been decided whether it should be allowed to keep running, or redo the wait
>> due to the resource being stolen away.
> 
> Then clearing XNWAKEN here is useless - it comes for free, but it has no
> practical effect.

pri(A) < pri(B, C, D)

thread A: xnsynch_sleep_on(X)
thread B: xnsynch_wakeup_one_sleeper(X), A owns X, not running
thread C: xnpod_suspend_thread(A), A is forcibly suspended
thread D: xnsynch_sleep_on(X)

next, without clearance:
thread D: steals X, does not block

next, with clearance:
thread D: blocks

This does have a practical effect: a thread that is suspended has its state
fully frozen, which includes preserving all acquired ownerships.

Clearing the wwake field after xnsynch_sleep_on has returned from
xnpod_suspend_thread is no compensation for that initial clearance in
xnpod_suspend_thread, because the relevant code would be run by different threads.

 For code clarity reasons, this should be remove IMHO.
> 
>>>> The awake bit has been kept mainly because the nucleus commonly uses bitmasks to
>>>> get fast access to thread status & information. It's not mandatory to have this
>>>> one in, it's just conforming to the rest of the implementation.
>>> I see, but redundancy come with some ugliness as well. And we add more
>>> code to hot paths.
>>>
>> The hot path barely involves facing a stolen resource situation. Most of the
>> time, the XNWAKEN test will be false, or this would mean that the application
>> exhibits a high priority thread that routinely and frequently competes with a
>> low priority one for gaining access to such resource. I would rather fix the
>> latter code first.
> 
> Besides that the lock-stealing path (with two instead of only one
> conditional jumps) is relevant for the WCET in some cases (but that is
> nitpicking), I was more referring to setting the bit + setting wwake in
> the wakeup paths.
>

Your next patch clears wwake upon return from xnpod_suspend_thread in
xnsynch_sleep_on, which basically voids this micro-optimization.

>> Regarding the perceived ugliness, I guess this is a matter of taste here. I like
>> the idea of always testing a given information the same way, like:
>>
>> if (test_bits(thread, foobar))
>>
>> and avoid things like:
>>
>> if (test_bits(thread, foo) || thread->field == bar)
> 
> The latter is what we see now with XNWAKEN

Not quite, what you see is test_bit(thread, foo) && thread->field == bar. In
that case, the second term that complements the information is not on the hot path.

 (while plain "thread->field
> == bar" would be possible in this case). We don't gain anything here by
> using a bit (no combined tests with other bits e.g.).
> 

Ok, I won't nak patches that help readability, but at the same time, it would be
much better to avoid being caught with our pants around our ankles due to
micro-optimizing some working code the wrong way. So please, let's reconsider
this issue with a fresh mind: is there an implementation that would satisfy both
correctness and conciseness?

> Jan
> 
> ---
>  include/nucleus/thread.h |    1 -
>  ksrc/nucleus/pod.c       |    2 +-
>  ksrc/nucleus/synch.c     |    5 +----
>  3 files changed, 2 insertions(+), 6 deletions(-)
> 
> Index: b/include/nucleus/thread.h
> ===================================================================
> --- a/include/nucleus/thread.h
> +++ b/include/nucleus/thread.h
> @@ -112,7 +112,6 @@
>  #define XNRMID    0x00000002 /**< Pending on a removed resource */
>  #define XNBREAK   0x00000004 /**< Forcibly awaken from a wait state */
>  #define XNKICKED  0x00000008 /**< Kicked upon Linux signal (shadow only) */
> -#define XNWAKEN   0x00000010 /**< Thread waken up upon resource availability */
>  #define XNROBBED  0x00000020 /**< Robbed from resource ownership */
>  #define XNATOMIC  0x00000040 /**< In atomic switch from secondary to primary mode */
>  #define XNAFFSET  0x00000080 /**< CPU affinity changed from primary mode */
> Index: b/ksrc/nucleus/pod.c
> ===================================================================
> --- a/ksrc/nucleus/pod.c
> +++ b/ksrc/nucleus/pod.c
> @@ -1406,7 +1406,7 @@ void xnpod_suspend_thread(xnthread_t *th
>  		}
>  #endif /* CONFIG_XENO_OPT_PERVASIVE */
>  
> -		xnthread_clear_info(thread, XNRMID | XNTIMEO | XNBREAK | XNWAKEN | XNROBBED);
> +		xnthread_clear_info(thread, XNRMID | XNTIMEO | XNBREAK | XNROBBED);
>  	}
>  
>  	/* Don't start the timer for a thread indefinitely delayed by
> Index: b/ksrc/nucleus/synch.c
> ===================================================================
> --- a/ksrc/nucleus/synch.c
> +++ b/ksrc/nucleus/synch.c
> @@ -199,7 +199,7 @@ redo:
>  	}
>  
>  	if (thread->cprio > owner->cprio) {
> -		if (xnthread_test_info(owner, XNWAKEN) && owner->wwake == synch) {
> +		if (owner->wwake == synch) {
>  			/* Ownership is still pending, steal the resource. */
>  			synch->owner = thread;
>  			xnthread_clear_info(thread, XNRMID | XNTIMEO | XNBREAK);
> @@ -243,7 +243,6 @@ redo:
>        unlock_and_exit:
>  
>  	thread->wwake = NULL;
> -	xnthread_clear_info(thread, XNWAKEN);
>  
>  	xnlock_put_irqrestore(&nklock, s);
>  }
> @@ -389,7 +388,6 @@ xnthread_t *xnsynch_wakeup_one_sleeper(x
>  		thread->wchan = NULL;
>  		thread->wwake = synch;
>  		synch->owner = thread;
> -		xnthread_set_info(thread, XNWAKEN);
>  		trace_mark(xn_nucleus_synch_wakeup_one,
>  			   "thread %p thread_name %s synch %p",
>  			   thread, xnthread_name(thread), synch);
> @@ -503,7 +501,6 @@ xnpholder_t *xnsynch_wakeup_this_sleeper
>  	thread->wchan = NULL;
>  	thread->wwake = synch;
>  	synch->owner = thread;
> -	xnthread_set_info(thread, XNWAKEN);
>  	trace_mark(xn_nucleus_synch_wakeup_all,
>  		   "thread %p thread_name %s synch %p",
>  		   thread, xnthread_name(thread), synch);
> 


-- 
Philippe.

