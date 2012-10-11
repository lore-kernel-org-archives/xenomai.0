Message-ID: <5076A19C.6070008@siemens.com>
Date: Thu, 11 Oct 2012 12:38:20 +0200
From: Jan Kiszka <jan.kiszka@siemens.com>
MIME-Version: 1.0
References: <1349936561-18062-1-git-send-email-gilles.chanteperdrix@xenomai.org>
	<50768019.6020807@xenomai.org> <507680F6.701@xenomai.org>
	<5076815C.8090003@xenomai.org> <507682E0.8070504@xenomai.org>
In-Reply-To: <507682E0.8070504@xenomai.org>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] [PATCH] rtdm: get spinlocks to lock the scheduler
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Philippe Gerum <rpm@xenomai.org>
Cc: xenomai@xenomai.org

On 2012-10-11 10:27, Philippe Gerum wrote:
> On 10/11/2012 10:20 AM, Philippe Gerum wrote:
>> On 10/11/2012 10:19 AM, Gilles Chanteperdrix wrote:
>>> On 10/11/2012 10:15 AM, Philippe Gerum wrote:
>>>> On 10/11/2012 08:22 AM, Gilles Chanteperdrix wrote:
>>>>> In a context where callbacks are called with spinlocks held, it is not
>>>>> possible for drivers callbacks to wake up threads without holding any
>>>>> spinlock. So, we need a mechanism to lock the scheduler when a spinlock
>>>>> is grabbed. As xnpod_lock_sched/xnpod_unlock_sched may be a bit heavy
>>>>> weight for this case, we implement new nucleus services xnpod_spin_locked
>>>>> and xnpod_spin_unlocked.
>>>>
>>>> The naming is error-prone, this could be interpreted as a test. Besides,
>>>> we don't have to explicitly refer to spinlocks, this service is
>>>> basically a preemption disabling feature. xnpod_disable/enable_preempt
>>>> would reflect this.
>>>>
>>>>
>>>>> ---
>>>>>  include/nucleus/pod.h      |   20 ++++++++++++++++++--
>>>>>  include/nucleus/sched.h    |    2 ++
>>>>>  include/rtdm/rtdm_driver.h |   22 +++++++++++++++++-----
>>>>>  3 files changed, 37 insertions(+), 7 deletions(-)
>>>>>
>>>>> diff --git a/include/nucleus/pod.h b/include/nucleus/pod.h
>>>>> index 06361ff..32e6b01 100644
>>>>> --- a/include/nucleus/pod.h
>>>>> +++ b/include/nucleus/pod.h
>>>>> @@ -277,11 +277,11 @@ static inline void xnpod_schedule(void)
>>>>>  	 * unlocked context switch.
>>>>>  	 */
>>>>>  #if XENO_DEBUG(NUCLEUS)
>>>>> -	if (testbits(sched->status | sched->lflags, XNKCOUT|XNINIRQ|XNSWLOCK))
>>>>> +	if (testbits(sched->status | sched->lflags, XNKCOUT|XNINIRQ|XNSWLOCK|XNHELDSPIN))
>>>>
>>>> XNHELD exists and has a significantly different meaning, so let's pick
>>>> something else than XNHELDSPIN which would refer to preemption.
>>>> Actually, we have too many of these XN*LOCK*.
>>>>
>>>> - XNLOCK refers to the common naming for the scheduler locking services
>>>> exposed by traditional RTOS, so this is probably better to keep it that
>>>> way. It can't be shared with internal preemption control flag.
>>>>
>>>> - XNSWLOCK seems to be shareable with the new preemption control flag,
>>>> with no disable count tracking though. Typically, XNSWLOCK &&
>>>> disable_count == 0 would mean that preemption is disabled for the
>>>> ongoing unlocked context switch.
>>>>
>>>>
>>>>>   * Rescheduling: never.
>>>>>   */
>>>>> -#define rtdm_lock_put(lock)	rthal_spin_unlock(lock)
>>>>> +#define rtdm_lock_put(lock)					\
>>>>> +	do {							\
>>>>> +		rthal_spin_unlock(lock);			\
>>>>> +		xnpod_spin_unlocked();				\
>>>>
>>>> This is a general property of xnlocks, this is not RTDM-specific. At any
>>>> rate, rescheduling when holding anything else than the nucleus lock is a
>>>> bug, so we can just manipulate the preemption counter from the xnlock
>>>> helpers directly. Any reference to nklock is constant, so gcc can detect
>>>> and optimize out the proper branch in these macros.
>>>
>>> The thing is:
>>> - RTDM does not use xnlocks
>>
>> then fix the RTDM code, it has to use the platform locks. The HAL layer
>> in its current form is about to vanish in 3.x.
>>
> 
> Crap, RTDM does not want recursive locks. So we have to duplicate the
> code insertion into both RTDM like you did, and the xnlock interface.

Err, sorry for the other posting, sequential mail processing...

Jan

-- 
Siemens AG, Corporate Technology, CT RTC ITP SDP-DE
Corporate Competence Center Embedded Linux

