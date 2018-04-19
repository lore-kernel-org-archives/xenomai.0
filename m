From: Philippe Gerum <rpm@xenomai.org>
References: <7be9b9c7-7393-eca0-6a86-bcf3d0302271@siemens.com>
 <667bd118-b8eb-4fbf-cb24-4f4f30114370@siemens.com>
 <3c4fc185-19af-4285-07a2-148b2a039fec@xenomai.org>
 <43104375-41a6-7327-b053-7074adc3115d@siemens.com>
 <f85588dd-aa36-0b2b-1346-3ace7ad32867@xenomai.org>
Message-ID: <5ecd8b53-f1e8-6cea-a5aa-ed93f8b3b604@xenomai.org>
Date: Thu, 19 Apr 2018 11:18:51 +0200
MIME-Version: 1.0
In-Reply-To: <f85588dd-aa36-0b2b-1346-3ace7ad32867@xenomai.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] [PATCH] copperplate: Drop PI from registry locks
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Jan Kiszka <jan.kiszka@siemens.com>, Xenomai <xenomai@xenomai.org>

On 04/19/2018 11:17 AM, Philippe Gerum wrote:
> On 04/17/2018 09:30 AM, Jan Kiszka wrote:
>> On 2018-04-17 09:22, Philippe Gerum wrote:
>>> On 04/13/2018 07:51 PM, Jan Kiszka wrote:
>>>> None of the callers that run into the locks have RT requirements.
>>>>
>>>> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
>>>> ---
>>>>
>>>> As noted before, I think we should even be fine with STD locks, but that
>>>> may require more changes.
>>>>
>>>>  lib/copperplate/registry.c | 2 --
>>>>  1 file changed, 2 deletions(-)
>>>>
>>>> diff --git a/lib/copperplate/registry.c b/lib/copperplate/registry.c
>>>> index daefa6c97..1bf0ebfea 100644
>>>> --- a/lib/copperplate/registry.c
>>>> +++ b/lib/copperplate/registry.c
>>>> @@ -175,7 +175,6 @@ int registry_init_file(struct fsobj *fsobj,
>>>>  
>>>>  	pthread_mutexattr_init(&mattr);
>>>>  	pthread_mutexattr_settype(&mattr, mutex_type_attribute);
>>>> -	pthread_mutexattr_setprotocol(&mattr, PTHREAD_PRIO_INHERIT);
>>>>  	pthread_mutexattr_setpshared(&mattr, PTHREAD_PROCESS_PRIVATE);
>>>>  	ret = __bt(-__RT(pthread_mutex_init(&fsobj->lock, &mattr)));
>>>>  	pthread_mutexattr_destroy(&mattr);
>>>> @@ -758,7 +757,6 @@ int __registry_pkg_init(const char *arg0, char *mountpt, int flags)
>>>>  
>>>>  	pthread_mutexattr_init(&mattr);
>>>>  	pthread_mutexattr_settype(&mattr, mutex_type_attribute);
>>>> -	pthread_mutexattr_setprotocol(&mattr, PTHREAD_PRIO_INHERIT);
>>>>  	pthread_mutexattr_setpshared(&mattr, PTHREAD_PROCESS_PRIVATE);
>>>>  	ret = __bt(-__RT(pthread_mutex_init(&p->lock, &mattr)));
>>>>  	pthread_mutexattr_destroy(&mattr);
>>>>
>>>
>>> This one raises an interesting issue: since commit #8e606e681,
>>> registry_{add, destroy}_file() use plain malloc(), therefore are subject
>>> to mode switches, dropping the real-time guarantee from object
>>> creation/deletion routines such as rt_*_{create, delete}() calls from
>>> the Alchemy API.
>>>
>>> Previously to such change, some of these routines did not provide such
>>> guarantee anyway, e.g. rt_task_create(), but others did like
>>> rt_mutex_create(), rt_cond_create().
>>>
>>> I'm now questioning those specific changes in registry_{add,
>>> destroy}_file(), because they might break applications assuming that rt
>>> mode is not lost when calling them, which is still true if the registry
>>> is disabled, leading to a fairly confusing inconsistency.
>>>
>>> Merging your patch would enforce this change in behavior even more,
>>> carving in stone that all object creation and deletion routines which
>>> interface with the registry won't be rt-capable anymore.
>>
>> Sure, we need to sort out the rt_*_create topic prior to being able to
>> decide about this one.
>>
>>>
>>> Would that be generally acceptable?
>>
>> I would not expect a lot use cases to be affected by that. The bare
>> minimum would be documenting this in the 2->3 migration guide.
>>
>> OTOH, given that this is the stable series, such a change (8e606e681)
>> may better wait for 3.1.
>>
> 
> This change should be reverted. The more I think of it, the more I see
> no reason to restrict object creation/deletion to secondary mode if the
> actual implementation does not require this.
> 

In fact, pv* calls there should simply move to xn* counterparts, fixing
the issue without any change in behavior.

-- 
Philippe.

