Subject: Re: [florian/y2038][PATCH v3 0/3] y2038:mutex_timedlock for timespec64
References: <1622721916-1824-1-git-send-email-chensong_2000@189.cn>
 <049086bd-62ee-70f0-6bb0-9f2906ff19f6@siemens.com>
 <7106d860-c9c5-2eea-2332-fb90fc1e0a0d@189.cn>
 <d69873c9-2a1f-4b32-e415-175b332b7083@189.cn>
From: Florian Bezdeka <florian.bezdeka@siemens.com>
Message-ID: <b0da37ec-ddbe-3e65-f8fd-c4b8edbc08cf@siemens.com>
Date: Tue, 8 Jun 2021 13:03:48 +0200
In-Reply-To: <d69873c9-2a1f-4b32-e415-175b332b7083@189.cn>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "chensong_2000@189.cn" <chensong_2000@189.cn>, xenomai@xenomai.org

On 08.06.21 09:51, chensong_2000--- via Xenomai wrote:
> 
> 
> 在 2021/6/8 下午3:37, chensong_2000--- via Xenomai 写道:
>>
>>
>> 在 2021/6/8 下午2:39, Florian Bezdeka 写道:
>>> Hi Song,
>>>
>>> On 03.06.21 14:05, Song Chen wrote:
>>>> This patch serial is aimed to introduce a new syscall mutex_timedlock64
>>>> which is specific for 64-bit time_t.
>>>>
>>>> ---
>>>> v2:
>>>> 1, new revision regarding review comments
>>>>
>>>> v3:
>>>> 1, return -errno
>>>> 2, throw a warning if timeout is NULL
>>>
>>> Will you take care of the POSIX violation as well, or should I try to
>>> find a timeslot and do it?
>>
>> I will take care of it.
>>
>> POSIX violation, do you mean:
>>
>> +    /* Timeout is never read by the kernel, so NULL should be OK */
>> +    ret = XENOMAI_SYSCALL2(sr_nc, &lock, NULL);
>> +    if (!smokey_assert(!ret))
>> +        smokey_warning("POSIX mutex_timedlock64 violation detected");
>> +
>>
>> what else should i do to take care of it, sorry if i missed some
>> information in the past emails.
>>
>> /Song
> 
> to find out the reason it returns 0 even if timeout is NULL?

I already had a short discussion with Philippe about that topic some
time ago. See [1].

It's more or less the same as for the sem_timedwait syscall. As long as
the supplied timeout is not used / read by the kernel it should be
treated as "optional argument". Reason: The POSIX spec, which says:


Under no circumstance shall the function fail with a timeout if the
mutex can be locked immediately. The validity of the abs_timeout
parameter need not be checked if the mutex can be locked immediately.


To fix this violation (we return an error if no timeout is given
independent from the fact if was used or not) a refactoring might be
needed. Philippe already posted his idea in [1] how to do that.

[1] https://xenomai.org/pipermail/xenomai/2021-March/044668.html

> 
>>
>>>
>>>>
>>>> Song Chen (3):
>>>>    y2038: cobalt/posix/mutex: Adding mutex_timedlock64
>>>>    y2038: lib/cobalt/mutex: dispatch mutex_timedlock
>>>>    y2038: testsuite/smokey/y2038: testcase for mutex_timedlock64
>>>>
>>>>   include/cobalt/uapi/syscall.h          |   1 +
>>>>   kernel/cobalt/posix/mutex.c            |  22 +++++-
>>>>   kernel/cobalt/posix/mutex.h            |   7 ++
>>>>   kernel/cobalt/posix/syscall32.c        |   7 ++
>>>>   kernel/cobalt/posix/syscall32.h        |   4 +
>>>>   lib/cobalt/mutex.c                     |   4 +
>>>>   testsuite/smokey/y2038/syscall-tests.c | 136
>>>> +++++++++++++++++++++++++++++++++
>>>>   7 files changed, 180 insertions(+), 1 deletion(-)
>>>>
>>>
>>>
>>
>>
> 


-- 
Siemens AG, T RDA IOT
Corporate Competence Center Embedded Linux

