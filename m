Sender: chensong_2000@189.cn
From: "chensong_2000@189.cn" <chensong_2000@189.cn>
Subject: Re: [florian/y2038][PATCH v3 0/3] y2038:mutex_timedlock for timespec64
References: <1622721916-1824-1-git-send-email-chensong_2000@189.cn>
 <049086bd-62ee-70f0-6bb0-9f2906ff19f6@siemens.com>
 <7106d860-c9c5-2eea-2332-fb90fc1e0a0d@189.cn>
 <d69873c9-2a1f-4b32-e415-175b332b7083@189.cn>
 <b0da37ec-ddbe-3e65-f8fd-c4b8edbc08cf@siemens.com>
 <00fbbce846894e3baa48956fe5c3a0fa@manrolandgoss.com>
Message-ID: <85462809-3d63-0d18-98e5-45bdce8b929e@189.cn>
Date: Fri, 11 Jun 2021 10:17:12 +0800
MIME-Version: 1.0
In-Reply-To: <00fbbce846894e3baa48956fe5c3a0fa@manrolandgoss.com>
Content-Type: text/plain; charset="utf-8"; format="flowed"
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
To: xenomai@xenomai.org

hi Dietmar,

在 2021/6/10 下午3:03, Dietmar Schindler via Xenomai 写道:
>> From: Xenomai <xenomai-bounces@xenomai.org> On Behalf Of Florian Bezdeka via Xenomai
>> Sent: Tuesday, June 8, 2021 1:04 PM
>> To: chensong_2000@189.cn; xenomai@xenomai.org
>> Subject: Re: [florian/y2038][PATCH v3 0/3] y2038:mutex_timedlock for timespec64
>>
>> On 08.06.21 09:51, chensong_2000--- via Xenomai wrote:
>>>
>>>
>>> 在 2021/6/8 下午3:37, chensong_2000--- via Xenomai 写道:
>>>>
>>>>
>>>> 在 2021/6/8 下午2:39, Florian Bezdeka 写道:
>>>>> Hi Song,
>>>>>
>>>>> On 03.06.21 14:05, Song Chen wrote:
>>>>>> This patch serial is aimed to introduce a new syscall mutex_timedlock64
>>>>>> which is specific for 64-bit time_t.
>>>>>>
>>>>>> ---
>>>>>> v2:
>>>>>> 1, new revision regarding review comments
>>>>>>
>>>>>> v3:
>>>>>> 1, return -errno
>>>>>> 2, throw a warning if timeout is NULL
>>>>>
>>>>> Will you take care of the POSIX violation as well, or should I try to
>>>>> find a timeslot and do it?
>>>>
>>>> I will take care of it.
>>>>
>>>> POSIX violation, do you mean:
>>>>
>>>> +    /* Timeout is never read by the kernel, so NULL should be OK */
>>>> +    ret = XENOMAI_SYSCALL2(sr_nc, &lock, NULL);
>>>> +    if (!smokey_assert(!ret))
>>>> +        smokey_warning("POSIX mutex_timedlock64 violation detected");
>>>> +
>>>>
>>>> what else should i do to take care of it, sorry if i missed some
>>>> information in the past emails.
>>>>
>>>> /Song
>>>
>>> to find out the reason it returns 0 even if timeout is NULL?
>>
>> I already had a short discussion with Philippe about that topic some
>> time ago. See [1].
>>
>> It's more or less the same as for the sem_timedwait syscall. As long as
>> the supplied timeout is not used / read by the kernel it should be
>> treated as "optional argument". Reason: The POSIX spec, which says:
>>
>>
>> Under no circumstance shall the function fail with a timeout if the
>> mutex can be locked immediately. The validity of the abs_timeout
>> parameter need not be checked if the mutex can be locked immediately.
>>
>>
>> To fix this violation (we return an error if no timeout is given
>> independent from the fact if was used or not) a refactoring might be
>> needed. Philippe already posted his idea in [1] how to do that.
>>
>> [1] https://xenomai.org/pipermail/xenomai/2021-March/044668.html
> 
> Please excuse my jumping in the discussion - perhaps I'm missing something, but IMHO "need not be checked" does not mean "must not be checked", but rather implies "may be checked", so a mere validity check is not a violation of POSIX. You, Florian, in [1] just said about the validating: "Yes it does, and probably should not for consistency with other calls" - that's a different, also fair reason for avoiding the check.

you are so welcomed to join the discussion and your opinion is valued 
and helpful.

we have three cases about validating timeout:
1) sem_timedwait
it merely validates timeout, not returns error back to user space even 
it fails, same with what you said.

2) mutex_timedlock
it acts differently with sem_timedwait, if timeout is null, returns 
-EFAULT before trying to acquire

3) mq_timedsend/mq_timedreceive
if it manages to send msg to the queue, it even doesn't validate timeout 
at all.

however, in vanilla kernel, it validates timeout at the beginning and 
return EFAULT if it fails, as a result, mq_timedsend/mq_timedreceive has 
different semantics, returns different values and leads to different 
behaviors in user space.

I would suggest we should follow vanilla kernel, what do you think?

what's more, i didn't find implementation of sem_timedwait and 
mutex_timedlock, are they in glibc? then we should follow glibc.


> 
> --
> Best regards,
> Dietmar
> ________________________________
> manroland Goss web systems GmbH | Managing Director: Franz Kriechbaum
> Registered Office: Augsburg | Trade Register: AG Augsburg | HRB-No.: 32609 | VAT: DE815764857
> 
> Confidentiality note:
> This message and any attached documents may contain confidential or proprietary information of manroland|Goss. These materials are intended only for the use of the intended recipient. If you are not the intended recipient of this transmission, you are hereby notified that any distribution, disclosure, printing, copying, storage, modification or the taking of any action in reliance upon this transmission is strictly prohibited. Delivery of this message to any person other than the intended recipient shall not compromise or waive such confidentiality, privilege or exemption from disclosure as to this communication. If you have received this communication in error, please immediately notify the sender and delete the message from your system. All liability for viruses is excluded to the fullest extent permitted by law.
> ________________________________
> 

