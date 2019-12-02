Subject: Re: [PATCH v2 3/3] cobalt/sched: guard against missed rescheduling
 upon CPU migration
References: <20191128100228.25727-1-rpm@xenomai.org>
 <20191128100228.25727-3-rpm@xenomai.org>
 <e110a0f9-ff69-2565-6aaf-7c8eca029030@siemens.com>
 <ef7e0b6f-6dcc-6190-c547-fa9169deaa7e@xenomai.org>
 <ec1aef0a-88d5-6722-0336-23be9d0b65c2@siemens.com>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <a3d9d0c5-d8a0-37b6-6ddf-8a390a1169f4@xenomai.org>
Date: Mon, 2 Dec 2019 16:18:37 +0100
MIME-Version: 1.0
In-Reply-To: <ec1aef0a-88d5-6722-0336-23be9d0b65c2@siemens.com>
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
To: Jan Kiszka <jan.kiszka@siemens.com>, xenomai@xenomai.org

On 12/2/19 7:42 AM, Jan Kiszka wrote:
> On 29.11.19 19:37, Philippe Gerum wrote:
>> On 11/29/19 7:04 PM, Jan Kiszka wrote:
>>> On 28.11.19 11:02, Philippe Gerum via Xenomai wrote:
>>>> From: Philippe Gerum <rpm@xenomai.org>
>>>>
>>>>      static inline int rtdm_task_set_period(rtdm_task_t *task,
>>>> @@ -1062,9 +1066,14 @@ static inline int rtdm_task_set_period(rtdm_task_t *task,
>>>>      static inline int rtdm_task_unblock(rtdm_task_t *task)
>>>>    {
>>>> -    int res = xnthread_unblock(task);
>>>> +    spl_t s;
>>>> +    int res;
>>>>    +    splhigh(s);
>>>> +    res = xnthread_unblock(task);
>>>>        xnsched_run();
>>>> +    splexit(s);
>>>> +
>>>>        return res;
>>>>    }
>>>
>>> Both become non-trivial this way and should be un-inlined. I will do that on top.
>>>
>>
>> Fair enough. I did not consider moving this out-of-line since those helpers are
>> infrequently used (or at least
>> should be).
>>
>>>>             (XNINIRQ|XNINSW|XNRESCHED)) != XNRESCHED)
>>>> @@ -328,18 +311,13 @@ static inline int __xnsched_run(struct xnsched *sched)
>>>>    static inline int xnsched_run(void)
>>>>    {
>>>>        struct xnsched *sched = xnsched_current();
>>>> +    struct xnthread *curr = READ_ONCE(sched->curr);
>>>
>>> But now we no longer need that READ_ONCE: I see only one use case below.>>> index 74dc7a961..f7e662a38 100644
>>>> --- a/kernel/cobalt/sched.c
>>>> +++ b/kernel/cobalt/sched.c
>>>> @@ -376,10 +376,11 @@ struct xnsched *xnsched_finish_unlocked_switch(struct
>>>> xnsched *sched)
>>>>    void xnsched_lock(void)
>>>>    {
>>>>        struct xnsched *sched = xnsched_current();
>>>> -    struct xnthread *curr = sched->curr;
>>>> +    struct xnthread *curr = READ_ONCE(sched->curr);
>>>
>>> And here we READ_ONCE for the consistency of the XENO_WARN?
>>>
>>
>> This is paired with writing to sched->curr in ___xnsched_run(). In theory, we
>> might have multiple subsequent stores to sched->curr from a remote CPU in the
>> time span of a single read from the local CPU. If we allow the compiler to go
>> wild with load tearing here, this might cause the reader to observe a pointer
>> value which might actually be a merge between the multiple stores.
>>
>> Since these are inline helpers, we could indeed use a barrier for preventing
>> load fusing with subsequent code within the same scope, but I don't think this
>> would be of any help with load tearing.
>>
>>>> +    /*
>>>> +     * sched->curr is shared locklessly with xnsched_run(), be
>>>> +     * careful about load/store tearing.
>>>> +     */
>>>> +    WRITE_ONCE(sched->curr, next);
>>>
>>> But xnsched_run touches the value only once. Do we rather want a barrier here?
>>>
>>
>> This is the converse issue. WRITE_ONCE() is there to prevent the compiler from
>> writing to sched->curr piecemeal (store tearing) with multiple accesses, while
>> other folks read that value (like xnsched_lock(), xnsched_run()). In theory, we
>> might have an issue with store tearing since sched->curr can be considered a
>> shared memory accessed locklessly, and we don't know how braindamage the
>> compiler might be, e.g. in case it feels too much pressure on the register file
>> when generating code. Typically, having a 64bit pointer store split into a
>> couple of 32bit writes would look funny at first, funky in the end. Granted,
>> the access to sched->curr is always aligned, no immediate value is stored
>> there, but well, WRITE_ONCE() is for peace of mind with other cases.
> 
> OK, can we add these reasonings as comments to the code?
> 

Sure, patch follows.

-- 
Philippe.

