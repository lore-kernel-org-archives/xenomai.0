Subject: Re: [RFC]why xnlock_put and xnlock_clear_irqon release xnlock
 directly?
References: <20200709152509.33099-1-alex_luca@163.com>
 <aa59adfc-533c-539f-f145-12e41147e53e@xenomai.org>
From: caver Lio <alex_luca@163.com>
Message-ID: <1a60c80e-2175-6de3-4b78-82ab23dad199@163.com>
Date: Tue, 14 Jul 2020 07:58:57 +0800
MIME-Version: 1.0
In-Reply-To: <aa59adfc-533c-539f-f145-12e41147e53e@xenomai.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Philippe Gerum <rpm@xenomai.org>
Cc: xenomai@xenomai.org

On 7/10/20 5:05 PM, Philippe Gerum wrote:
> On 7/9/20 5:25 PM, alex_luca--- via Xenomai wrote:
>> From: Alex_luca@163.com
>>
>> hello,list
>> I have some doubts on *struct nklock* operations. 
>>
>> Both *xnlock_get* and *xnlock_get_irqsave* is allowed to be called
>> nested;they will check that if the nklock has been acquired. If so
>> they won't actually do the "get", but return a value of 2.
>>
>> But the *xnlock_put*, which corresponding to *xnlock_get* never
>> checks and will actually release the lock. This is diffrent from
>> *xnlock_put_irqrestore*.
>>
>> What puzzles me is the following:
>> {
>>     ......
>>     xnlock_get_irqsave(nklock, s)
>>     ......
>>         xnlock_get(nklock)
>>         ......
>>         xnlock_put(nklock)
>>         ......
>>     xnlock_put_irqrestore(nklock, s)
>> }
>>
>> First, *xnlock_get_irqsave* get the nklock, and *xnlock_get* will skip;
>> Then *xnlock_put* is called, and it released the nklock; after a
>> while *xnlock_put_irqrestore* is called on the same cpu, it also seems
>> to release the nklock.
>>
>> Will this above happen in xenomai?  But I have never seen this happen.
>> Or *xnlock_get* was guaranteed never been called nesting?
>>
> 
> This is right, there is such asymmetry between the irq-aware form and the
> plain one, which I believe was not intended but never caused any trouble yet
> because the problematic nesting does not happen in the current implementation.
> Kind of sleeping monster if you will. xnlock_get() is commonly used in IRQ
> handlers in order to save the redundant interrupt state fixup, so it would be
> the outer lock in this case, not the inner one.
> 
> On a general note, if you plan to remove the ugly big lock from the Xenomai
> code base, I would suggest the following approach:
> 
> - rewrite the core synchronization (xnsynch) so that testing for a condition
> and sleeping on the related synchronization object (if that condition is
> unmet) does not have to be covered by the nklock in a single atomic section.
> 
> - remove all other occurrences of code which would reschedule (xnsched_run())
> with the nklock held. This nesting has to go for the Xenomai core to be
> SMP-scalable.
> 
> Then you would need to pick a workable locking pattern. One involves
> introducing per-CPU runqueue locks covering the updates to the scheduler data,
> and per-thread locks protecting updates to the thread state. The locking order
> would be thread -> runqueue, with the runqueue lock held across context
> switches and released in the scheduling tail by the incoming thread.
> 
> This approach was followed in order to convert Cobalt into a SMP-scalable core
> which you can refer to as a working example if that helps:
> https://git.evlproject.org/linux-evl.git/tree/kernel/evl/sched/core.c?h=evl/master
> 

Thank you for your kind answers and suggestions, I will continue to explore.

Thanks


