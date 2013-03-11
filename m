Message-ID: <513DE023.9010506@mitrol.it>
Date: Mon, 11 Mar 2013 14:46:11 +0100
From: Paolo Minazzi <Paolo.Minazzi@mitrol.it>
MIME-Version: 1.0
References: <51372B12.2030400@mitrol.it>	<51373149.4050700@xenomai.org>	<5137370B.2050402@mitrol.it>	<51373841.70704@xenomai.org>	<51385910.80203@mitrol.it>	<51388A3A.2090004@xenomai.org>
	<51388DD2.2020805@mitrol.it>	<51388EB2.6000206@xenomai.org>
	<5139DEA2.9050103@mitrol.it> <513A464E.90800@xenomai.org>
	<513D9A17.7020204@mitrol.it> <513DD703.9070000@xenomai.org>
In-Reply-To: <513DD703.9070000@xenomai.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Sporadic problem : rt_task_sleep
	locked	after	debugging
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

Il 11/03/2013 14.07, Gilles Chanteperdrix ha scritto:
> On 03/11/2013 09:47 AM, Paolo Minazzi wrote:
>
>> Il 08/03/2013 21.13, Gilles Chanteperdrix ha scritto:
>>> On 03/08/2013 01:50 PM, Paolo Minazzi wrote:
>>>
>>>> This fault does not freeze the arm, I can countinue to work.
>>>>
>>>> Ideas ?
>>> Please try the following patch:
>>>
>>> diff --git a/ksrc/nucleus/shadow.c b/ksrc/nucleus/shadow.c
>>> index c91a6f3..ed3864b 100644
>>> --- a/ksrc/nucleus/shadow.c
>>> +++ b/ksrc/nucleus/shadow.c
>>> @@ -1430,8 +1430,10 @@ void xnshadow_unmap(xnthread_t *thread)
>>>    	rpi_pop(thread);
>>>
>>>    	sys_ppd = xnsys_ppd_get(0);
>>> -	xnheap_free(&sys_ppd->sem_heap, thread->u_mode);
>>> -	thread->u_mode = NULL;
>>> +	if (thread->u_mode) {
>>> +		xnheap_free(&sys_ppd->sem_heap, thread->u_mode);
>>> +		thread->u_mode = NULL;
>>> +	}
>>>
>>>    	xnarch_atomic_dec(&sys_ppd->refcnt);
>>>
>>> @@ -2379,7 +2381,7 @@ int do_hisyscall_event(unsigned event, rthal_pipeline_stage_t *stage,
>>>          ret_handled:
>>>
>>>    	/* Update the userland-visible state. */
>>> -	if (thread)
>>> +	if (thread&&   thread->u_mode)
>>>    		*thread->u_mode = thread->state;
>>>
>>>    	trace_mark(xn_nucleus, syscall_histage_exit,
>>> @@ -2549,7 +2551,7 @@ int do_losyscall_event(unsigned event, rthal_pipeline_stage_t *stage,
>>>          ret_handled:
>>>
>>>    	/* Update the userland-visible state. */
>>> -	if (thread)
>>> +	if (thread&&   thread->u_mode)
>>>    		*thread->u_mode = thread->state;
>>>
>>>    	trace_mark(xn_nucleus, syscall_lostage_exit,
>>>
>> Hi Gilles,
>> I can see the same problem under 2.6.2.1.
>> I was debugging, after a while I could not stop anymore the code using
>> breakpoints because all tasks are stopped at rt_task_sleep.
>> After this, If I close the application and restart it, the rt_task sleep
>> are blocked. I have to restart my arm processor.
>> Any ideas ?
>
> Debugging xenomai thread causes the timers to be stopped, and they are
> supposed to be restarted when the thread blocked on the breakpoint,
> maybe this is what goes wrong: the timers are not restarted.
>
> Another possibility is the hardware timer being programmed for a too
> short delay.
>
> Please no private mails.
>
>> Paolo
>>
>>
>
>

Time ago I have already tried to change a parameter 
ksrc/nucleus/timer.c:402 (the following is the comment ...)
                                 /*
                                  * Make the blocked timer elapse again
                                  * at a reasonably close date in the
                                  * future, waiting for the timebase to
                                  * be unlocked at some point. Timers
                                  * are blocked when single-stepping
                                  * into an application using a
                                  * debugger, so it is fine to wait for
                                  * 250 ms for the user to continue
                                  * program execution.
                                  */
                                 interval = xnarch_ns_to_tsc(250000000ULL);
                                 goto requeue;

I have tried bigger and smaller value than 250ms without luck.
If you have got some ideas I can make tests as you want.
Regards,
Paolo


