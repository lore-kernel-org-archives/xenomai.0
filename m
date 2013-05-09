Message-ID: <518BCF7F.3000407@xenomai.org>
Date: Thu, 09 May 2013 18:31:59 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <5182B42F.9090907@bollue.de> <518BCB32.6060007@xenomai.org>
In-Reply-To: <518BCB32.6060007@xenomai.org>
Content-Type: text/plain; charset=UTF-8
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
To: Kai Bollue <mlist1@bollue.de>
Cc: Xenomai <xenomai@xenomai.org>

On 05/09/2013 06:13 PM, Gilles Chanteperdrix wrote:

> On 05/02/2013 08:45 PM, Kai Bollue wrote:
> 
>> Hello,
>>
>> we experience a crash upon unbinding of a previously deleted (and 
>> cleaned up) shared heap.
>> Scheme:
>> - Process A calls rt_heap_create() (with H_SHARED flag), waits for some 
>> time and then terminates.
>> - Process B calls rt_heap_bind() on that heap, uses it and calls 
>> rt_heap_unbind() (or terminates) after process A has terminated.
>>
>> Then the system crashes after the output of "Xenomai: removing 
>> non-linked element, holder=ffffc900125e4940, qslot=ffff880427aa90f8 at 
>> kernel/xenomai/skins/native/heap.c:374".
>>
>> The crash does not always happen, but can quite reliably be reproduced 
>> by starting process A in a loop from bash (while [ TRUE ]; do ...) and 
>> keeping process B running.
>>
>> Two aspects seem to be crucial:
>> - Calling rt_heap_delete() in process A is not sufficient to reproduce 
>> the problem, the process has to terminate (the cleaning up seems to be 
>> relevant).
>> - We could only reproduce the crash as long as process B accessed the 
>> heap after process A had terminated (e.g. using memcpy).
>>
>> As a workaround, it could be tried to avoid access to a deleted heap, 
>> but it is not always possible to detect the termination of process A on 
>> time in such a constellation.
>>
>> The system:
>> - AMD AM3 FX-8350
>> - Debian 6.0
>> - Kernel 3.5.7
>> - Xenomai 2.6.2.1
>>
>> We also tested this on an older system (Xenomai 2.6.0, Kernel 2.6.37): 
>> Here, both processes hung indefinitely and could not be killed, but the 
>> system did not crash.
>>
>> Any hints are appreciated.
>>
>> Attachments:
>> - Console output
>> - Code of process A
>> - Code of process B
> 
> 
> Hi Kai,
> 
> thank you very much for your test case, it allowed to reproduce the
> issue and try and understand what happens.
> 
> From what I understand, processA creates the shared heap which is added
> to the list of the objects it holds (xeno_get_rholder()), when processA
> dies, the heap is removed from the list, but not destroyed because it is
> also bound to processB.
> 
> Then processB unbinds the heap, which triggers an auto-destruction,
> which tries to remove the heap from processA list again. If processA
> control block has not been re-used, this works, because the list is
> still there, if processA has be re-launched, the control block has been
> reinitialized, as well as the list, so removing the element from the
> list fails.
> 
> I see several possible corrections:
> - get rt_heap_delete to return an error when the heap is currently bound
> to another process (EBUSY for instance), while still unmapping it from
> the current process. This will cause __xeno_flush_rq to move the heap to
> the "global" ressource holder, where it can safely be deleted later
> - put any rt_heap with the H_MAPPABLE flag directly on the global
> ressource holder, as it is a global object anyway, this means that when
> a process which created a mappable heap dies, the heap survives, but
> this is maybe what should be expected from shareable heaps.


- or remove the rt_heap from the list directly in rt_heap_delete, it
does not seem to make sense to keep it in the list after it has been
deleted: it will be automatically deleted when the last process bound to
it unbinds it anyway.

-- 
                                                                Gilles.

