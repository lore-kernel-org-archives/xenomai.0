References: <E1daPZD-0000KU-Bk@xenomai.org>
 <279c3ea8-3396-161c-254a-aca7e2f6a445@xenomai.org>
 <0818e9c1-a4ad-cf28-a35f-efb06a809184@siemens.com>
 <80934b09-9d9a-038a-e426-2eae7b27bb5f@siemens.com>
 <6eb0651a-53be-ac44-c3a6-80aaba1ce6d9@xenomai.org>
 <a9587340-a63b-d8b2-a1a5-abd7acd6ea1a@siemens.com>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <c7dd7f1f-5c87-21a1-7a24-198d256c4780@xenomai.org>
Date: Thu, 27 Jul 2017 19:11:18 +0200
MIME-Version: 1.0
In-Reply-To: <a9587340-a63b-d8b2-a1a5-abd7acd6ea1a@siemens.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] [Xenomai-git] Jan Kiszka : cobalt: Fix conditional
 build of lock_vfile registration
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Jan Kiszka <jan.kiszka@siemens.com>, xenomai@xenomai.org

On 07/27/2017 06:32 PM, Jan Kiszka wrote:
> On 2017-07-27 18:21, Philippe Gerum wrote:
>> On 07/27/2017 05:30 PM, Jan Kiszka wrote:
>>> On 2017-07-27 13:15, Jan Kiszka wrote:
>>>> On 2017-07-26 18:59, Philippe Gerum wrote:
>>>>> On 07/26/2017 06:53 PM, git repository hosting wrote:
>>>>>> Module: xenomai-jki
>>>>>> Branch: for-forge
>>>>>> Commit: 634a95c9c023dda40607e5e5c1dd43761f59e541
>>>>>> URL:    http://git.xenomai.org/?p=xenomai-jki.git;a=commit;h=634a95c9c023dda40607e5e5c1dd43761f59e541
>>>>>>
>>>>>> Author: Jan Kiszka <jan.kiszka@siemens.com>
>>>>>> Date:   Wed Jul 26 18:50:43 2017 +0200
>>>>>>
>>>>>> cobalt: Fix conditional build of lock_vfile registration
>>>>>>
>>>>>> There is and there was never a CONFIG_XENO_DEBUG_LOCKING.
>>>>>> Fixes de66d324a93d.
>>>>>>
>>>>>> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
>>>>>>
>>>>>> ---
>>>>>>
>>>>>>  kernel/cobalt/procfs.c |    4 ++--
>>>>>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>>>>>
>>>>>> diff --git a/kernel/cobalt/procfs.c b/kernel/cobalt/procfs.c
>>>>>> index 9d193af..85aea0c 100644
>>>>>> --- a/kernel/cobalt/procfs.c
>>>>>> +++ b/kernel/cobalt/procfs.c
>>>>>> @@ -216,7 +216,7 @@ static struct xnvfile_regular apc_vfile = {
>>>>>>  void xnprocfs_cleanup_tree(void)
>>>>>>  {
>>>>>>  #ifdef CONFIG_XENO_OPT_DEBUG
>>>>>> -#ifdef CONFIG_XENO_DEBUG_LOCKING
>>>>>
>>>>> This would reintroduce another bug [1]. Better check for the proper
>>>>> symbol instead, i.e. CONFIG_XENO_OPT_DEBUG_LOCKING.
>>>>
>>>> That won't solve the issue either. There is something more seriously
>>>> broken in the dependencies. Analyzing....
>>>>
>>>
>>> The problem is that #if IS_ENABLED() does not update the dependencies of
>>> that file so that kbuild does not recompile what is actually affected by
>>> config changes. A clean rebuild will work.
>>>
>>> Solution is to replace *all* #if IS_ENABLED() by proper #ifdef.
>>>
>>
>> Yes, this was the purpose of the initial fix, which used the wrong
>> symbol though. Because the deps was broken, we ended up with some files
>> not being rebuilt when switching between debug modes, leaving
>> xnlock_stats undefined in some cases. We only need to fix the symbol,
>> i.e. #ifdef CONFIG_XENO_DEBUG_LOCKING, and all other occurrences of
>> similar constructs.
> 
> Done, see for-forge.
> 

Pulled into -next, thanks.

-- 
Philippe.

