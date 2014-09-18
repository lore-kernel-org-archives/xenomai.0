Message-ID: <541B311B.1060501@siemens.com>
Date: Thu, 18 Sep 2014 21:23:07 +0200
From: Jan Kiszka <jan.kiszka@siemens.com>
MIME-Version: 1.0
References: <CAPRPZsBD_5ufxFAhPCFqRf9YZSm1FhqfcmL+MTbhJ=1Sb7ED_g@mail.gmail.com>	<5357C92F.2060206@xenomai.org>	<CAPRPZsAvxx9XVB5MYi65m1FPaz2p7Rgh7+M4U357exJBbo0kHQ@mail.gmail.com>	<535828F6.6050308@xenomai.org>	<CAPRPZsA4ZQEm1a+2TV6s2wvD2_M53RrL4zLz0sJgLKEF8ALo1w@mail.gmail.com>	<53583DF7.3080700@xenomai.org>	<CAPRPZsB8a=gN=U14qn_tpfksg3T8yW+M8pZGhOkT-jPDuU8L0w@mail.gmail.com>	<CAPRPZsAyTQN936=phnT+NzvT7w_UxnY1ppQDucCjh39neOYn6g@mail.gmail.com>	<CAPRPZsB4+68QpNZ7sBCa6-wssNizkrBpG7vB_6q-cJXvCzkihg@mail.gmail.com>
 <CAPRPZsCji_p56+CC+a6ueywq39piA=70RaTPP3Xtz62NL_nhcQ@mail.gmail.com>
 <540F6B15.2070201@xenomai.org> <54112EFA.4080901@web.de>
 <541130D0.50409@web.de> <541AC62F.2050003@xenomai.org>
 <541AC933.9090600@siemens.com> <541ACD66.50902@xenomai.org>
 <541ACE05.1050305@siemens.com> <541AD8A2.30500@xenomai.org>
 <541ADD8A.7020804@siemens.com> <541AE1CD.7090008@xenomai.org>
 <541B04E6.5010808@siemens.com> <541B0815.5010906@xenomai.org>
 <541B26FE.6000507@xenomai.org>
In-Reply-To: <541B26FE.6000507@xenomai.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Reading /proc/xenomai/stat causes high latencies
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>, Jeroen Van den Keybus <jeroen.vandenkeybus@gmail.com>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

On 2014-09-18 20:39, Gilles Chanteperdrix wrote:
> On 09/18/2014 06:28 PM, Gilles Chanteperdrix wrote:
>> On 09/18/2014 06:14 PM, Jan Kiszka wrote:
>>> On 2014-09-18 15:44, Gilles Chanteperdrix wrote:
>>>> On 09/18/2014 03:26 PM, Jan Kiszka wrote:
>>>>> On 2014-09-18 15:05, Gilles Chanteperdrix wrote:
>>>>>> On 09/18/2014 02:20 PM, Jan Kiszka wrote:
>>>>>>> On 2014-09-18 14:17, Gilles Chanteperdrix wrote:
>>>>>>>> On 09/18/2014 01:59 PM, Jan Kiszka wrote:
>>>>>>>>> On 2014-09-18 13:46, Gilles Chanteperdrix wrote:
>>>>>>>>>> On 09/11/2014 07:19 AM, Jan Kiszka wrote:
>>>>>>>>>>> On 2014-09-11 07:11, Jan Kiszka wrote:
>>>>>>>>>>>> On 2014-09-09 23:03, Gilles Chanteperdrix wrote:
>>>>>>>>>>>>> On 04/25/2014 12:44 PM, Jeroen Van den Keybus wrote:
>>>>>>>>>>>>>> For testing, I've removed the locks from the vfile system.
>>>>>>>>>>>>>> Then the high latencies reliably disappear.
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> To test, I made two xeno_nucleus modules: one with the
>>>>>>>>>>>>>> xnlock_get/put_ in place and one with dummies. Subsequently,
>>>>>>>>>>>>>> I use a program that simply opens and reads the stat file
>>>>>>>>>>>>>> 1,000 times.
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> With locks:
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> RTT|  00:00:01  (periodic user-mode task, 100 us period,
>>>>>>>>>>>>>> priority 99) RTH|----lat min|----lat avg|----lat
>>>>>>>>>>>>>> max|-overrun|---msw|---lat best|--lat worst RTD|     -2.575|
>>>>>>>>>>>>>> -2.309|      9.286|       0|     0|     -2.575|      9.286
>>>>>>>>>>>>>> RTD|     -2.364|     -2.276|      1.600|       0|     0|
>>>>>>>>>>>>>> -2.575|      9.286 RTD|     -2.482|     -2.274|      2.165|
>>>>>>>>>>>>>> 0|     0|     -2.575|      9.286 RTD|     -2.368|    135.261|
>>>>>>>>>>>>>> 1478.154|   13008|     0|     -2.575|   1478.154 RTD|
>>>>>>>>>>>>>> -2.368|     -2.272|      2.602|   13008|     0|     -2.575|
>>>>>>>>>>>>>> 1478.154 RTD|     -2.499|     -2.272|      6.933|   13008|
>>>>>>>>>>>>>> 0|     -2.575|   1478.154
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> Without locks:
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> RTT|  00:00:01  (periodic user-mode task, 100 us period,
>>>>>>>>>>>>>> priority 99) RTH|----lat min|----lat avg|----lat
>>>>>>>>>>>>>> max|-overrun|---msw|---lat best|--lat worst RTD|     -2.503|
>>>>>>>>>>>>>> -2.270|      3.310|       0|     0|     -2.503|      3.310
>>>>>>>>>>>>>> RTD|     -2.418|     -2.284|     -1.646|       0|     0|
>>>>>>>>>>>>>> -2.503|      3.310 RTD|     -2.496|     -2.275|      4.630|
>>>>>>>>>>>>>> 0|     0|     -2.503|      4.630 RTD|     -2.374|     -2.285|
>>>>>>>>>>>>>> -1.458|       0|     0|     -2.503|      4.630 RTD|
>>>>>>>>>>>>>> -2.452|     -2.273|      3.559|       0|     0|     -2.503|
>>>>>>>>>>>>>> 4.630 RTD|     -2.370|     -2.285|     -1.518|       0|
>>>>>>>>>>>>>> 0|     -2.503|      4.630 RTD|     -2.458|     -2.274|
>>>>>>>>>>>>>> 4.203|       0|     0|     -2.503|      4.630
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> I'll now have a closer look into the vfile system but if the
>>>>>>>>>>>>>> locks are malfunctioning, I'm clueless.
>>>>>>>>>>>>>
>>>>>>>>>>>>> Answering with a "little" delay, could you try the following
>>>>>>>>>>>>> patch?
>>>>>>>>>>>>>
>>>>>>>>>>>>> diff --git a/include/asm-generic/bits/pod.h
>>>>>>>>>>>>> b/include/asm-generic/bits/pod.h index a6be0dc..cfb0c71 100644
>>>>>>>>>>>>> --- a/include/asm-generic/bits/pod.h +++
>>>>>>>>>>>>> b/include/asm-generic/bits/pod.h @@ -248,6 +248,7 @@ void
>>>>>>>>>>>>> __xnlock_spin(xnlock_t *lock /*, */ XNLOCK_DBG_CONTEXT_ARGS)
>>>>>>>>>>>>> cpu_relax(); xnlock_dbg_spinning(lock, cpu, &spin_limit /*, */
>>>>>>>>>>>>> XNLOCK_DBG_PASS_CONTEXT); +			xnarch_memory_barrier(); }
>>>>>>>>>>>>> while(atomic_read(&lock->owner) != ~0); }
>>>>>>>>>>>>> EXPORT_SYMBOL_GPL(__xnlock_spin); diff --git
>>>>>>>>>>>>> a/include/asm-generic/system.h b/include/asm-generic/system.h
>>>>>>>>>>>>> index 25bd83f..7a8c4d0 100644 ---
>>>>>>>>>>>>> a/include/asm-generic/system.h +++
>>>>>>>>>>>>> b/include/asm-generic/system.h @@ -378,6 +378,8 @@ static
>>>>>>>>>>>>> inline void xnlock_put(xnlock_t *lock)
>>>>>>>>>>>>> xnarch_memory_barrier();
>>>>>>>>>>>>>
>>>>>>>>>>>>> atomic_set(&lock->owner, ~0); + +	xnarch_memory_barrier();
>>>>>>>>>>>>
>>>>>>>>>>>> That's pretty heavy-weighted now (it was already due to the first
>>>>>>>>>>>> memory barrier). Maybe it's better to look at some ticket lock
>>>>>>>>>>>> mechanism like Linux uses for fairness. At least on x86 (and
>>>>>>>>>>>> other strictly ordered archs), those require no memory barriers
>>>>>>>>>>>> on release.
>>>>>>>>>>
>>>>>>>>>>> In fact, memory barriers aren't needed on strictly ordered archs
>>>>>>>>>>> already today, independent of the spinlock granting algorithm. So
>>>>>>>>>>> there are two optimization possibilities:
>>>>>>>>>>
>>>>>>>>>>> - ticket-based granting - arch-specific (thus optimized) core
>>>>>>>>>>
>>>>>>>>>> Ok, no answer, so I will try to be more clear.
>>>>>>>>>>
>>>>>>>>>> I do not pretend to understand how memory barriers work at a low
>>>>>>>>>> level, this is a shame, I know, and am sorry for that. My "high level"
>>>>>>>>>> view, is that memory barriers on SMP systems act as synchronization
>>>>>>>>>> points, meaning that when a CPU issues a barrier, it will "see" the
>>>>>>>>>> state of the other CPUs at the time of their last barrier. This means
>>>>>>>>>> that for a CPU to see a store that occured on another CPU, there must
>>>>>>>>>> have been two barriers: a barrier after the store on one cpu, and a
>>>>>>>>>> barrier after that before the read on the other cpu. This view of
>>>>>>>>>> things seems to be corroborated by the fact that the patch works, and
>>>>>>>>>> by the following sentence in Documentation/memory-barriers.txt:
>>>>>>>>>>
>>>>>>>>>>  (*) There is no guarantee that a CPU will see the correct order of
>>>>>>>>>> effects from a second CPU's accesses, even _if_ the second CPU uses a
>>>>>>>>>> memory barrier, unless the first CPU _also_ uses a matching memory
>>>>>>>>>> barrier (see the subsection on "SMP Barrier Pairing").
>>>>>>>>>
>>>>>>>>> [quick answer]
>>>>>>>>>
>>>>>>>>> ...or the architecture refrains from reordering write requests, like x86
>>>>>>>>> does. What may happen, though, is that the compiler reorders the writes.
>>>>>>>>> Therefore you need at least a (must cheaper) compiler barrier on those
>>>>>>>>> archs. See also linux/Documentation/memory-barriers.txt on this and more.
>>>>>>>>
>>>>>>>> quick answer: I do not believe an SMP architecture can enforce stores
>>>>>>>> ordering accross multiple cpus, with cpus local caches and such. And the
>>>>>>>> fact that the patch I sent fixed the issue on x86 tend to prove me right.
>>>>>>>
>>>>>>> It's not wrong, it's just (costly, on larger machines) overkill as the
>>>>>>> other cores either see the lock release and all prior changes committed
>>>>>>> or the lock taken (and the prior changes do not matter then). They will
>>>>>>> never see later changes committed before the lock being visible as free.
>>>>>>
>>>>>> I agree. But this is true on all architectures, not just on strictly
>>>>>> ordered ones, this is just due to how barriers work on SMP systems, as I
>>>>>> explained.
>>>>>>
>>>>>>> That's architecturally guaranteed, and that's why you have no memory
>>>>>>> barriers in x86 spinlock release operations.
>>>>>>
>>>>>> I disagree, as explained in the paragraph just below the one you quote,
>>>>>> I believe this is an optimization, which is almost valid on any
>>>>>> architecture. Almost valid, because if the cpu which has done the unlock
>>>>>> does another lock without any time for a barrier in between to
>>>>>> synchronize cpus, we have a problem, because the other cpus will never
>>>>>> see the spinlock as free. With ticket spinlocks, you just add a store on
>>>>>> the cpu which spins, and you have to add a barrier after that, if you
>>>>>> want the barrier before the read on the cpu which will acquire the lock
>>>>>> to see that the spinlock is contended. So I do not see how this requires
>>>>>> less barriers.
>>>>>
>>>>> Ticket locks prevent unfair starvation without the closing barrier as
>>>>> they grant the next ticket to the next waiter, not the current holder.
>>>>> See the Linux implementation.
>>>>
>>>> Whether to put the closing barrier after the last store is orthogonal,
>>>> to whether implementing ticket locks or not. This is all a question of
>>>> tradeoffs.
>>>>
>>>> Without the barrier after the last store, you increase the spinning time
>>>> due to time taken for the store to be visible on other cpus, but you
>>>> optimize the overhead of unlocking.
>>>>
>>>> With ticket spinlocks you avoid the starvation situation, at the expense
>>>> of increasing the overhread of spinlock operations.
>>>>
>>>> I do not know which is worse. I suspect all this does not make much of a
>>>> difference, and what dominates is the duration of spinlock sections anyway.
>>>
>>> I think the way classic Linux spinlock did this on x86 provide the answer.
>>
>> The situation is completely different: linux spinlocks are well split,
>> xenomai basically has one only spinlock, so chances are that it will be
>> more contended, so the heavy unlock path (the one which implements the
>> ticket stuff) will be triggered more often. Also, xenomai spinlock (we
>> can loose the s anyway) being more contended, the "pending store
>> barrier" optimization has in fact chances of being detrimental. And
>> finally, due to the way spinlocks are split, Linux has scalability
>> issues that Xenomai can not even begin to imagine tackling.
> 
> Finally, in the eternal worst case vs average case fight, the worst case
> worth optimizing is the contended case in our case, and I believe adding
> the barrier after atomic_set in xnlock_put is what optimizes this worst
> case best, because, again, it reduces the time between the unlock and
> its visibility on the spinning cpu. That is at least something Linux
> does not have to care about, because the worst case is not what it is
> optimized for.

Maybe. Unsure right now, if we see prolonged spinning time due to this
on x86. I suspect not as spinning is not only increasing latencies but
also burning CPU power uselessly, and that would be noticed and disliked
under Linux.

Jan

-- 
Siemens AG, Corporate Technology, CT RTC ITP SES-DE
Corporate Competence Center Embedded Linux

