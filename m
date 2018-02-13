From: Lowell Gilbert <kludge@be-well.ilk.org>
References: <44eflvcaft.fsf@lowell-desk.lan>
 <31210f5e-1137-54e8-9e22-7562de250614@xenomai.org>
 <115c0698-ad5f-2dae-4ed4-1e027839eae1@xenomai.org>
 <44d11e1akp.fsf@be-well.ilk.org> <44o9kumikv.fsf@lowell-desk.lan>
Date: Tue, 13 Feb 2018 12:04:22 -0500
In-Reply-To: <44o9kumikv.fsf@lowell-desk.lan> (Lowell Gilbert's message of
 "Mon, 12 Feb 2018 08:41:04 -0500")
Message-ID: <44sha4lt2h.fsf@lowell-desk.lan>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Xenomai] rtdm_timer_start latency?
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Lowell Gilbert <kludge@be-well.ilk.org> writes:

> Lowell Gilbert <kludge@be-well.ilk.org> writes:
>
>> Philippe Gerum <rpm@xenomai.org> writes:
>>
>>> On 02/09/2018 11:02 AM, Philippe Gerum wrote:
>>>> On 02/09/2018 12:45 AM, Lowell Gilbert wrote:
>>>>> Am I correct in assuming that when calling rtdm_timer_start(), I should
>>>>> not be getting multi-second latencies before the first call to the timer
>>>>> routine? Just checking before I dig in too far.
>>>>>
>>>> 
>>>> Of course not. I suspect an absolute expiry time is given with a
>>>> relative mode spec.
>>>> 
>>>
>>> More generally, an absolute expiry time which is not based on the right
>>> clock specified by the mode argument.
>>>
>>> i.e.
>>>
>>> expiry = rtdm_clock_monotonic(), mode = RTDM_TIMERMODE_REALTIME => BAD
>>> expiry = rtdm_clock_realtime(), mode = RTDM_TIMERMODE_ABSOLUTE => BAD
>>> expiry = rtdm_clock_realtime() or _monotonic(), mode =
>>> RTDM_TIMERMODE_RELATIVE => BAD
>>
>> Okay, that makes sense.
>>
>> I was using 0 for expiry, because I really just wanted the periodic
>> wakeup. I don't remember why I didn't create a periodic task instead of
>> using a timer.
>>
>> What clock do I want to use to get the timer started? Once it starts, it
>> runs fine; but it often takes two or three seconds before the first call
>> into the handler.
>>
>> To put it another way, I'm trying to figure out what am I doing wrong in:
>> 		ret = rtdm_timer_start(&pstate.collect.timer, 1,
>> 				       pstate.collect.period,
>> 				       RTDM_TIMERMODE_RELATIVE);
>
> I could just rewrite the code to use a periodic task, but I'd prefer to
> understand what is actually wrong with my current code first, to be sure
> that refactoring will really solve my problem.
>
> Or I could have the timer run constantly, but that is just hacking
> around the problem, not really solving it.

I have a feature request that would require me to run the data collection
constantly (or at least whenever there's a consumer ready to receive it),
so that will ameliorate the problems for me. However, I'd prefer to
understand what's happening, because as far as I understand at the moment,
what I am doing *should* work.

Also, as a matter of design, is there any reason to prefer a periodic task
over a timer or vice versa? It can potentially cycle at fairly high rates
(a period as low as 10 microseconds), although expected use cases will not.

Be well.

