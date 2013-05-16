Message-ID: <51949168.2040203@xenomai.org>
Date: Thu, 16 May 2013 09:57:28 +0200
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <5182B42F.9090907@bollue.de> <518BCB32.6060007@xenomai.org>
	<518BCF7F.3000407@xenomai.org> <5193CD8C.1090508@bollue.de>
	<51940246.3020105@xenomai.org>
In-Reply-To: <51940246.3020105@xenomai.org>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] native/heap: "removing non-linked element"
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: Xenomai <xenomai@xenomai.org>

On 05/15/2013 11:46 PM, Gilles Chanteperdrix wrote:
> On 05/15/2013 08:01 PM, Kai Bollue wrote:
> 
>> On 09.05.2013 18:31, Gilles Chanteperdrix wrote:
>>> On 05/09/2013 06:13 PM, Gilles Chanteperdrix wrote:
>>>
>>>> On 05/02/2013 08:45 PM, Kai Bollue wrote:
>>>>
>>>>> Hello,
>>>>>
>>>>> we experience a crash upon unbinding of a previously deleted (and
>>>>> cleaned up) shared heap.
>>>>> Scheme:
>>>>> - Process A calls rt_heap_create() (with H_SHARED flag), waits for some
>>>>> time and then terminates.
>>>>> - Process B calls rt_heap_bind() on that heap, uses it and calls
>>>>> rt_heap_unbind() (or terminates) after process A has terminated.
>>>>>
>>>>> Then the system crashes after the output of "Xenomai: removing
>>>>> non-linked element, holder=ffffc900125e4940, qslot=ffff880427aa90f8 at
>>>>> kernel/xenomai/skins/native/heap.c:374".
>>>>>
>>>>> The crash does not always happen, but can quite reliably be reproduced
>>>>> by starting process A in a loop from bash (while [ TRUE ]; do ...) and
>>>>> keeping process B running.
>>>>>
>>>>> Two aspects seem to be crucial:
>>>>> - Calling rt_heap_delete() in process A is not sufficient to reproduce
>>>>> the problem, the process has to terminate (the cleaning up seems to be
>>>>> relevant).
>>>>> - We could only reproduce the crash as long as process B accessed the
>>>>> heap after process A had terminated (e.g. using memcpy).
>>>>>
>>>>> As a workaround, it could be tried to avoid access to a deleted heap,
>>>>> but it is not always possible to detect the termination of process A on
>>>>> time in such a constellation.
>>>>>
>>>>> The system:
>>>>> - AMD AM3 FX-8350
>>>>> - Debian 6.0
>>>>> - Kernel 3.5.7
>>>>> - Xenomai 2.6.2.1
>>>>>
>>>>> We also tested this on an older system (Xenomai 2.6.0, Kernel 2.6.37):
>>>>> Here, both processes hung indefinitely and could not be killed, but the
>>>>> system did not crash.
>>>>>
>>>>> Any hints are appreciated.
>>>>>
>>>>> Attachments:
>>>>> - Console output
>>>>> - Code of process A
>>>>> - Code of process B
>>>>
>>>> Hi Kai,
>>>>
>>>> thank you very much for your test case, it allowed to reproduce the
>>>> issue and try and understand what happens.
>>>>
>>>>  From what I understand, processA creates the shared heap which is added
>>>> to the list of the objects it holds (xeno_get_rholder()), when processA
>>>> dies, the heap is removed from the list, but not destroyed because it is
>>>> also bound to processB.
>>>>
>>>> Then processB unbinds the heap, which triggers an auto-destruction,
>>>> which tries to remove the heap from processA list again. If processA
>>>> control block has not been re-used, this works, because the list is
>>>> still there, if processA has be re-launched, the control block has been
>>>> reinitialized, as well as the list, so removing the element from the
>>>> list fails.
>>
>> Hi Gilles,
>>
>> thank you very much for your analysis and suggestions.
>>
>>>> I see several possible corrections:
>>>> - get rt_heap_delete to return an error when the heap is currently bound
>>>> to another process (EBUSY for instance), while still unmapping it from
>>>> the current process. This will cause __xeno_flush_rq to move the heap to
>>>> the "global" ressource holder, where it can safely be deleted later
>>
>> I am not sure if this is the best solution as the the heap object itself 
>> can actually be deleted, only the underlying xnheap remains.
>>
>>>> - put any rt_heap with the H_MAPPABLE flag directly on the global
>>>> ressource holder, as it is a global object anyway, this means that when
>>>> a process which created a mappable heap dies, the heap survives, but
>>>> this is maybe what should be expected from shareable heaps.
>>
>> This is probably better, but:
>>
>>>
>>> - or remove the rt_heap from the list directly in rt_heap_delete, it
>>> does not seem to make sense to keep it in the list after it has been
>>> deleted: it will be automatically deleted when the last process bound to
>>> it unbinds it anyway.
>>>
>>
>> This is IMHO the most consistent solution. With the following change, we 
>> cannot reproduce the crash anymore:
>>
>> diff --git a/ksrc/skins/native/heap.c b/ksrc/skins/native/heap.c
>> index 4a39d07..be4aee9 100644
>> --- a/ksrc/skins/native/heap.c
>> +++ b/ksrc/skins/native/heap.c
>> @@ -371,8 +371,6 @@ static void __heap_post_release(struct xnheap *h)
>>
>>          xnlock_get_irqsave(&nklock, s);
>>
>> -       removeq(heap->rqueue, &heap->rlink);
>> -
>>          if (heap->handle)
>>                  xnregistry_remove(heap->handle);
>>
>> @@ -442,6 +440,8 @@ int rt_heap_delete_inner(RT_HEAP *heap, void __user 
>> *mapaddr)
>>
>>          xeno_mark_deleted(heap);
>>
>> +       removeq(heap->rqueue, &heap->rlink);
>> +
>>          /* Get out of the nklocked section before releasing the heap
>>             memory, since we are about to invoke Linux kernel
> 
>>             services. */
> 
> Yes, this is the fix I pushed:
> http://git.xenomai.org/?p=xenomai-2.6.git;a=commitdiff;h=ee28ad6936964ebf4198dcfd77dec4b8c5e8623c;hp=a2a6d456b23b9960f46964505668619b90b69400
> 

RT_QUEUE implementation follows the same pattern. You may want to push a
fix for this one too.

-- 
Philippe.

