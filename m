References: <664a5757-3d5a-af0d-96a0-485bc71d58f8@siemens.com>
 <73a53c88-66cd-0c01-5fe7-0303a30ccd2b@xenomai.org>
 <963cf145-9056-2b41-e5ef-0394ccf5c202@siemens.com>
 <d195f384-bc18-d3c6-d880-8ada841423c1@xenomai.org>
 <4056a282-cc9e-6f20-fe64-0bd30003416e@siemens.com>
 <8b44beec-a788-3d4a-b07b-100c4467294b@xenomai.org>
 <d3a3e753-b446-f9c0-3bd5-2dc2185990c4@siemens.com>
 <a9ef1c06-c9c2-46ca-1e3a-07de9cf12a9f@xenomai.org>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <49f1424e-96ac-c4ef-081e-8cb6d31d1706@siemens.com>
Date: Wed, 2 Aug 2017 18:06:22 +0200
MIME-Version: 1.0
In-Reply-To: <a9ef1c06-c9c2-46ca-1e3a-07de9cf12a9f@xenomai.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Avoid stopping all timers during debug sessions
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Philippe Gerum <rpm@xenomai.org>, Xenomai <xenomai@xenomai.org>

On 2017-08-02 17:57, Philippe Gerum wrote:
> On 08/02/2017 05:43 PM, Jan Kiszka wrote:
>> On 2017-08-02 15:05, Philippe Gerum wrote:
>>> On 08/02/2017 02:54 PM, Jan Kiszka wrote:
>>>> On 2017-08-02 14:47, Philippe Gerum wrote:
>>>>> On 08/02/2017 01:03 PM, Jan Kiszka wrote:
>>>>>> On 2017-08-02 10:12, Philippe Gerum wrote:
>>>>>>> On 07/27/2017 08:03 PM, Jan Kiszka wrote:
>>>>>>>> Hi,
>>>>>>>>
>>>>>>>> currently, when gdb interrupts a Xenomai application, all timers stop
>>>>>>>> firing (except for those marked with XNTIMER_NOBLCK - core timers). This
>>>>>>>> means, you can't debug one RT application without affecting others on
>>>>>>>> the same systems. I'm not wondering how to resolve this. Options:
>>>>>>>>
>>>>>>>>  - convert timer stopping to a per-process feature - implies the need to
>>>>>>>>    establish some timer-process relationship concept, and it might be
>>>>>>>>    tricky for drivers and other central timer creators
>>>>>>>>
>>>>>>>>  - let the application deal with timer overflows during debug:
>>>>>>>>     - make timer stop optional (in case of single applications that
>>>>>>>>       can't handle this yet)
>>>>>>>>     - do not stop timers at all
>>>>>>>>
>>>>>>>> Any opinions?
>>>>>>>>
>>>>>>>
>>>>>>> That stuff is a relic from the Dark Ages, which not only sits in a hot
>>>>>>> path, but also crashes an ARM board here when ptracing. At the very
>>>>>>> least, the implementation is overkill and needs fixing.
>>>>>>>
>>>>>>> I'm working on a much simpler and less intrusive approach, I'll follow
>>>>>>> up today on this.
>>>>>>
>>>>>> OK, looking forward.
>>>>>
>>>>> To answer your original question, I would either let the application
>>>>> deal with overruns, or provide an implementation that only cares for
>>>>> hiding overruns that may have occurred due to ptracing, instead of
>>>>> trying to somehow freeze time.
>>>>>
>>>>> So I pushed an implementation doing exactly that, fixing the breakage
>>>>> issue in the same move. There is no such thing as blocked timers
>>>>> anymore, we just pretend that no overrun took place when asked via
>>>>> xntimer_get_overrun() after a ptraced state has existed, until an
>>>>> originally relaxed caller eventually leaves the kernel in primary mode,
>>>>> at which point normal accounting is restarted.
>>>>>
>>>>> That should exactly cover the case we are interested in, i.e. a once
>>>>> ptraced - therefore relaxed - thread, returning from any service which
>>>>> may collect the overrun count, and has to do so from primary mode (e.g.
>>>>> sigwait(), timerfd.read(), rtdm_task_wait_period()).
>>>>>
>>>>> The code is in wip/sstep for now.
>>>>>
>>>>
>>>> Will have a look.
>>>>
>>
>> The approach looks good, but please split up refactorings from the
>> functional change - reviewing and also cherry-picking the patch is hard
>> now (I will need to keep some structuring for the rtdebug patches below).
>>
> 
> Except for a single comment being reworded, the rest is a drop-in
> replacement for the previous approach, there is no refactoring. I can
> remove the former implementation, then add the new one in a separate
> patch if that helps.

The removal of register_debugged_thread is refactoring (I will have to
reintroduce it).

Some of the changes to print_core_clock_status seem to be cleanups as
well, though triggered by the removal of nklock. They don't affect me,
just seemed cleaner to me to break them up.

Jan

-- 
Siemens AG, Corporate Technology, CT RDA ITP SES-DE
Corporate Competence Center Embedded Linux

