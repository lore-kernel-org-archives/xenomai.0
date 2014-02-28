Message-ID: <53107295.1020400@xenomai.org>
Date: Fri, 28 Feb 2014 12:27:17 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <52ED3BA0.4040105@xenomai.org> <52ED8F8B.70806@xenomai.org>
 <52F15242.8080801@xenomai.org> <52FE14E1.8040303@siemens.com>
 <52FE18CE.4020702@xenomai.org> <52FE1B85.3070402@siemens.com>
 <52FE2364.6060608@xenomai.org> <52FE3BCD.3000608@siemens.com>
 <52FE443D.9060806@xenomai.org> <52FE4D84.90006@siemens.com>
In-Reply-To: <52FE4D84.90006@siemens.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] RTDM rework
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Jan Kiszka <jan.kiszka@siemens.com>, Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: Xenomai <xenomai@xenomai.org>

On 02/14/2014 06:08 PM, Jan Kiszka wrote:
> On 2014-02-14 17:28, Philippe Gerum wrote:
>> On 02/14/2014 04:52 PM, Jan Kiszka wrote:
>>> On 2014-02-14 15:08, Gilles Chanteperdrix wrote:
>>>> On 02/14/2014 02:35 PM, Jan Kiszka wrote:
>>>>>>> I started to read through your patches. The general direction remains
>>>>>>> valid and beneficial, but I have a few formal issues with some API
>>>>>>> changes. In a nutshell: We really need to avoid layering
>>>>>>> violations by
>>>>>>> expressing public RTDM interfaces via Xenomai data structures
>>>>>>> directly.
>>>>>>>
>>>>>>> Sometimes it's just a cosmetic thing like wrapping the opaque struct
>>>>>>> xnfd into something like rtdm_fd. But rtdm_operations cannot
>>>>>>> simply be
>>>>>>> replaced with xnfd_ops. We loose RTDM documentation this way (yes,
>>>>>>> fixable), but we also now logically depend on the internals of
>>>>>>> Xenomai
>>>>>>> Cobalt in the abstract RTDM driver API. rtdm_operations is not
>>>>>>> opaque to
>>>>>>> driver developers!
>>>>>>
>>>>>> #define rtdm_dev_context xnfd
>>>>>> #define rtdm_operations xnfd_ops
>>>>>> should do the trick. Note that I told you about this change in
>>>>>> advance,
>>>>>> and proposed to cascade the callbacks.
>>>>>
>>>>> Not for rtdm_operations as its content is part of the RTDM API. It is
>>>>> _not_ an opaque type, in contrast to xnfd.
>>>>
>>>> With #define rtdm_operations xnfd_ops
>>>>
>>>> The user can do:
>>>>
>>>> struct rtdm_operations foo = { /* ... */ };
>>>>
>>>> Without knowing that he is in fact defining an xnfd_ops structure.
>>>>
>>>> I am sorry, but I do not see the problem, if we keep rtdm_operations
>>>> documented. But if you prefer we can, as I said, cascade the callbacks.
>>>> Or even arrange to define rtdm_operations with members with the same
>>>> signature as xnfd_ops, and fill an xnfd_ops structure with the
>>>> rtdm_operations members.
>>>
>>> I'd like to avoid that a change to xnfd_ops for whatever internal reason
>>> breaks the RTDM API subtly. Keep in mind that we will also have to map
>>> it on native Linux in a not-too-far future. Probably it is even a good
>>> idea to try this mapping right now, at least conceptually, to avoid
>>> having to change too much at that point again.
>>>
>>
>> Talking about conceptual issues, we may have a problem with supporting
>> RTDM_EXECUTE_ATOMICALLY() over native. I don't expect to see this sorted
>> shortly, but this should be part of the API discussion at some point.
>
> I think there are two types of RTDM_EXECUTE_ATOMICALLY users:
>
> 1. Testcases and other Xenomai-internal users that could also use
>     platform specific mechanisms, ie. do not depend on a portable
>     solution.
>
> 2. Drivers that require this semantic:
>
>     RTDM_EXECUTE_ATOMICALLY(
>         register_with_something();
>         sleep();
>         unregister_again();
>     )
>
>     vs.
>
>     RTDM_EXECUTE_ATOMICALLY(
>         for_each_registered_thing()
>             rtdm_task_unblock()
>     )
>
> The need for RTDM_EXECUTE_ATOMICALLY in the second case arises from the
> fact that we cannot wake up a specific task waiting on a shared sync
> object in advance, i.e. before it is already blocked on that object,
> without destroying that object for everyone. If we find an alternative
> unlocked pattern for this scenario, we can drop the nasty macro, I think.
>

The semantics in this case looks similar to wait_event_* and friends, 
maybe with an implicit condition on being asleep/awake, although this 
construct is likely to be used along with an explicit condition to test 
before going to sleep.

What about introducing rtdm_waitqueue_t and the related helpers? Over a 
native kernel, we could just map them over the regular kernel/wait 
interface, and getting the same constructs working over Cobalt does not 
look like a big issue.

The bonus would be to get rid of the "single lock" semantics which 
taints RTDM_EXECUTE_ATOMICALLY in the same move, so that we don't kill 
scalability over single image kernels.

-- 
Philippe.

