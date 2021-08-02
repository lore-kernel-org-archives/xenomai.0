Subject: Re: Large gpio interrupt latency
References: <87czseyzzm.fsf@xenomai.org> <10a7-60fa6980-b1-35a6e6c0@10117939>
 <87v9515uc5.fsf@xenomai.org>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <09505192-a4ae-6339-e0f3-c339d92948e4@siemens.com>
Date: Mon, 2 Aug 2021 14:24:08 +0200
MIME-Version: 1.0
In-Reply-To: <87v9515uc5.fsf@xenomai.org>
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
To: Philippe Gerum <rpm@xenomai.org>, =?UTF-8?Q?Fran=c3=a7ois_Legal?= <devel@thom.fr.eu.org>
Cc: Julien Blanc <julien.blanc@sprinte.eu>, "xenomai@xenomai.org" <xenomai@xenomai.org>

On 23.07.21 10:04, Philippe Gerum wrote:
> 
> François Legal <devel@thom.fr.eu.org> writes:
> 
>> Le Mardi, Juin 22, 2021 12:07 CEST, Philippe Gerum <rpm@xenomai.org> a écrit: 
>>  
>>>
>>> Jan Kiszka <jan.kiszka@siemens.com> writes:
>>>
>>>> On 22.06.21 11:31, Philippe Gerum wrote:
>>>>>
>>>>> Jan Kiszka <jan.kiszka@siemens.com> writes:
>>>>>
>>>>>> On 22.06.21 10:37, Philippe Gerum wrote:
>>>>>>>
>>>>>>> Jan Kiszka <jan.kiszka@siemens.com> writes:
>>>>>>>
>>>>>>>> On 22.06.21 09:49, Julien Blanc via Xenomai wrote:
>>>>>>>>> Le mardi 22 juin 2021 à 09:38 +0200, Philippe Gerum via Xenomai a
>>>>>>>>> écrit :
>>>>>>>>>>
>>>>>>>>>> With this in mind, assuming that we have previously sanitized the
>>>>>>>>>> clock
>>>>>>>>>> identifier, doing this:
>>>>>>>>>>
>>>>>>>>>> #define get_timestamp(__clock) \
>>>>>>>>>> ({ (__clock) == CLOCK_MONOTONIC ? rtdm_clock_read_monotonic() :
>>>>>>>>>> rtdm_clock_read(); })
>>>>>>>>>>
>>>>>>>>>> may end up being faster than:
>>>>>>>>>>
>>>>>>>>>> xnticks_t (*__get_timestamp)(clockid_t clock);
>>>>>>>>>> #define get_timestamp(__clock)	__get_timestamp(__clock)
>>>>>>>>>
>>>>>>>>> Is really a runtime switch necessary ? Since relying on the realtime
>>>>>>>>> clock is inherently broken, my understanding is that it should be kept
>>>>>>>>> as compatibility purpose only.
>>>>>>>>
>>>>>>>> Again: The real-time clock is not a broken clock per se. It is the basis
>>>>>>>> of many services (POSIX...) and - if managed properly - it is as sound
>>>>>>>> clock to build upon. If you need absolute timestamps to calculate
>>>>>>>> absolute timeouts (like users of the existing code do), this is the
>>>>>>>> clock to go, also in future versions.
>>>>>>>
>>>>>>> Definitely correct, for timeout specs.
>>>>>>>
>>>>>>>> Also if you want to use
>>>>>>>> PTP-sync'ed clocks across systems (TSN...), it is THE way to go. At that
>>>>>>>> point, monotonic timestamps will lose relevance in practice.
>>>>>>>>
>>>>>>>
>>>>>>> We are not there yet. So, let's all agree than we need both clock bases,
>>>>>>> and a flexible way to select the current one.
>>>>>>>
>>>>>>
>>>>>> What's still missing with Dovetail and a Linux-operated PTP sync for the
>>>>>> main clocksource? Hardending of software-based sync paths? Where it's
>>>>>> hw-based, that should already be fine (latest Intel SOCs).
>>>>>>
>>>>>
>>>>> Again, we have two use cases: absolute timeouts based on a common epoch
>>>>> which may change, and delays. We do know PTP with hw-based support is an
>>>>> efficient way to maintain consistency among users of the former,
>>>>> nevertheless we still need to express/measure strict delays in other
>>>>> cases. So, we do need both clocks.
>>>>>
>>>>
>>>> If you need cross-system event stamping, the unsync'ed monotonic clock
>>>> is the wrong choice as well.
>>>>
>>>
>>> As usual, it's a trade-off, a risk assessment between observing
>>> non-coherent SMP readings and warp jumps. This is a call an application
>>> should be allowed to make, I see no reason to impose a solution
>>> arbitrarily without knowing what the app actually wants to do.
>>>
>>>> Again: What is missing to use PTP-sync'ed clock-realtime under Dovetail
>>>> today?
>>>>
>>>
>>> Nothing when it comes to reading timestamps, via the NMI-safe
>>> ktime_get_real_fast_ns() service (updates will be non-preemptible while
>>> holding the seqlock).
>>>
>>
>> Hi there,
>>
>> to move this topic forward, I propose to create a patch to replace the call to rtdm_clock_read_monotonic by rtdm_clock_read in gpio_core.c,
>> plus another one that would introduce the possibility to switch between those 2 different clocks.
>>
> 
> There is no timed wait calls in this driver which might benefit from a
> general "clock switch" feature, is it?  So what about either of these
> options instead:
> 
> - adding GPIO_RTIOC_TS_REAL only for the purpose of retrieving
>   timestamps. That would leave the existing client code unaffected, and
>   _might_ be backported to the stable tree since this is a mere
>   extension of the ABI.
> 
> - renaming the current ioctl request to GPIO_RTIOC_GET_TS_MONO, and
>   provide GPIO_RTIOC_GET_TS[_REAL] based on rtdm_clock_read() in the
>   same move. That would force the existing client code to revisit their
>   implementation wrt retrieving a timestamp, providing the desired
>   alternative between mono/real too. That sort of change would have to
>   wait for 3.2 though.
> 

How is the status here? This topic should really be address before the
3.2 release.

Thanks,
Jan

-- 
Siemens AG, T RDA IOT
Corporate Competence Center Embedded Linux

