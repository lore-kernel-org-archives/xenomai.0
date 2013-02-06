Message-ID: <5112A392.3050302@xenomai.org>
Date: Wed, 06 Feb 2013 19:40:18 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <51128CE4.4020303@siemens.com> <51128E3E.808@xenomai.org>
	<511293EB.1080502@siemens.com> <5112945F.8080102@xenomai.org>
	<51129599.3080709@siemens.com> <51129693.1040400@xenomai.org>
	<5112974A.8050008@siemens.com> <5112982B.1020901@xenomai.org>
	<5112A06A.7030809@siemens.com> <5112A175.5010002@xenomai.org>
	<5112A269.40609@siemens.com>
In-Reply-To: <5112A269.40609@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] ipipe/x86: do not restore during context switch
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: Xenomai <xenomai@xenomai.org>

On 02/06/2013 07:35 PM, Jan Kiszka wrote:

> On 2013-02-06 19:31, Gilles Chanteperdrix wrote:
>> On 02/06/2013 07:26 PM, Jan Kiszka wrote:
>>
>>> On 2013-02-06 18:51, Gilles Chanteperdrix wrote:
>>>> On 02/06/2013 06:47 PM, Jan Kiszka wrote:
>>>>
>>>>> On 2013-02-06 18:44, Gilles Chanteperdrix wrote:
>>>>>> On 02/06/2013 06:40 PM, Jan Kiszka wrote:
>>>>>>
>>>>>>> On 2013-02-06 18:35, Gilles Chanteperdrix wrote:
>>>>>>>> On 02/06/2013 06:33 PM, Jan Kiszka wrote:
>>>>>>>>
>>>>>>>>> On 2013-02-06 18:09, Gilles Chanteperdrix wrote:
>>>>>>>>>> On 02/06/2013 06:03 PM, Jan Kiszka wrote:
>>>>>>>>>>
>>>>>>>>>>> Gilles,
>>>>>>>>>>>
>>>>>>>>>>> do you remember if this core-3.4 change was a performance optimization
>>>>>>>>>>> or a necessary fix? Also, I'm not yet understanding why we need all the
>>>>>>>>>>> #ifdefs except for the first one which forces fpu.preload to 0.
>>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>> It is a performance optimization, without it, we systematically hit the
>>>>>>>>>> maximum latency when the timer would tick during a context switch which
>>>>>>>>>> restores the FPU. Note that if you change that, you will probably break
>>>>>>>>>> -forge.
>>>>>>>>>
>>>>>>>>> According to the Intel folks who introduced eagerfpu, xsave, or at least
>>>>>>>>> xsaveopt (which I didn't implemented yet) is now faster than serializing
>>>>>>>>> clts/stts. On the other hand, the worst case is a full SSE + AVX restore
>>>>>>>>> while the target RT task is not depending on the FPU.
>>>>>>>>
>>>>>>>>
>>>>>>>> Without xsave, we never restore fpu if the RT task never used it. This
>>>>>>>> changes with xsave?
>>>>>>>
>>>>>>> This would change with eagerfpu which depends on xsave. The kernel
>>>>>>> sticks with lazy switching in the absence of xsaveopt.
>>>>>>
>>>>>>
>>>>>> I am not sure you understand what I mean, so, I am going to reformulate.
>>>>>> Without xsave, Linux uses lazy fpu restore, and Xenomai uses eager fpu
>>>>>> restore. But Xenomai eager fpu restore is a nop if the RT task never
>>>>>> used FPU since its inception (and all the parents from which it is
>>>>>> cloned never used FPU either). Does Linux eager switching mean the same
>>>>>> thing?
>>>>>
>>>>> eagerfpu means: always call xsaveopt/xrstor, it will optimize the case
>>>>> that the FPU was unused by the source/destination. And no fiddling with
>>>>> TS anymore, at no time.
>>>>
>>>>
>>>> I still do not understand this sentence then: "the worst case is a full
>>>> SSE + AVX restore while the target RT task is not depending on the FPU."
>>>> If the RT task does not depend on the FPU, why would xsaveopt/xrstor
>>>> restore SSE and AVX context?
>>>
>>> Switching between two tasks that both use the full state space defines
>>> the maximum latency of the FPU save/restore step. We cannot interrupt
>>> xsave or xrstor instructions, but we couldn't interrupt fxsave either.
>>>
>>> What we can do, though, is to ensure that we have at least an preemption
>>> point between both. Do we have such thing so far, a chance to handle a
>>> Xenomai IRQ between some FPU save for Linux task A and a FPU restore for
>>> the following task B? If not, the discussion is mood and we are just
>>> shifting probabilities of the very same worst case.
>>
>>
>> We can implement unlocked context switch support on x86 as we do on
>> other platforms. I tried that on atom actually and it did not really
>> improve latencies. You do not answer my question though, why would
>> xsave/xrstor do anything if the RT thread has not used FPU (and all its
>> parents have not used fpu) ?
> 
> We first of all would have to wait for the unrelated switch between
> those two Linux tasks before we could handle the IRQ and switch to the
> FPU-free RT task. __switch_to is atomic, also for Linux->Linux, no?


Only the *IP and *SP switch need to be atomic, the whole __switch_to can
be split in several atomic sections, this is what I tested on atom. But
as I said, it did not lead to any latency improvement.

-- 
                                                                Gilles.

