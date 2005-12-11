Message-ID: <439C789E.8010608@domain.hid>
Date: Sun, 11 Dec 2005 20:06:06 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] [bug] vfree/kfree under hard IRQ locks
References: <439C18EC.1070500@domain.hid> <439C3A32.8020405@domain.hid>
	<439C63A4.3080309@domain.hid> <439C6BF7.5070404@domain.hid>
	<439C700B.7050501@domain.hid>
In-Reply-To: <439C700B.7050501@domain.hid>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: xenomai-core <xenomai@xenomai.org>

Jan Kiszka wrote:
> Philippe Gerum wrote:
> 
>>Jan Kiszka wrote:
>>
>>
>>>Philippe Gerum wrote:
>>>
>>>
>>>>Jan Kiszka wrote:
>>>>
>>>>
>>>>
>>>>>Hi,
>>>>>
>>>>>I happened to stumble over this comment[1]. It made me curious,
>>>>>especially as it is not totally correct (the loop is executed in
>>>>>IRQ-off
>>>>>context, thus it *is* timecritical).
>>>>>
>>>>
>>>>Critical should be understood here in the sense that IRQs are off while
>>>>the loop workload is high, which is fortunately not the case. Hence the
>>>>comment.
>>>
>>>
>>>
>>>Sure, there is not much to do inside the loop. But it does not scale
>>>very well in case a significant number of elements are registered - and
>>>they are scattered over a larger memory area so that cache missed
>>>strike us.
>>>
>>
>>Compared to what it costs to actually call Linux to release the system
>>memory which is an operation the syscall will do anyway, those cache
>>misses account for basically nothing.
> 
> 
> I don't have the function caller's cost in mind here (which is likely
> either starting up or on the way to termination anyway), I just worry
> about the rest of the system which may want to continue it's operation
> undisturbed.
> 

Again, it's a matter of tradeoff: do we want to add more locking 
complexity, which means more code and likely more data fetches in the 
hot path, in order to be able to avoid a series of uninterruptible cache 
misses when scanning a short heap descriptor queue? The queue we are 
talking about links all the currently active heaps, which means 1 
element for the system heap, plus 1 element for each of the user-defined 
heaps.

> 
>>>It's a bit theoretical, but I also think we can easily resolve it by
>>>using Linux locks as soon as we can sanely sleep inside
>>>xnheap_init/destroy_shared and xnheap_ioctl.
>>>
>>>
>>>
>>>>>While thinking about the possibility to convert the hard IRQ lock
>>>>>protection of kheapq into some Linux mutex or whatever, I analysed the
>>>>>contexts the users of this queue (__validate_heap_addr/xnheap_ioctl,
>>>>>xnheap_init_shared, xnheap_destroy_shared) execute in. Basically, it is
>>>>>Linux/secondary mode, but there are unfortunate exceptions:
>>>>>
>>>>>rt_heap_delete(): take nklock[2], then call xnheap_destroy_shared()[3].
>>>>>The latter will call __unreserve_and_free_heap()[4] which calls Linux
>>>>>functions like vfree()[5] or kfree()[6] -- I would say: not good! At
>>>>>least on SMP we could easily get trapped by non-deterministic
>>>>>waiting on
>>>>>Linux spinlocks inside those functions.
>>>>>
>>>>>The same applies to rt_queue_delete()[7].
>>>>>
>>>>
>>>>Good spot. Better not calling the heap deletion routines under nklock
>>>>protection in the first place. The committed fix does just that for both
>>>>rt_heap_delete and rt_queue_delete.
>>>
>>>
>>>
>>>Ok, we no longer have IRQs locked over vfree/kfree, but task scheduling
>>>is still suffering from potential delays. Wouldn't it be better to defer
>>>such operations to an asynchronous Linux call?
>>>
>>
>>Do we really want heap creation/deletion to be short time bounded
>>operations at the expense of added complexity?
>>
> 
> 
> Again, the side effects on other real-time programs are my concern.
> There are quite a lot of scenarios where only parts of the real-time
> programs are started or stopped while others keep on working as usual.
> The caller's cost is more or less irrelevant in that case.
>

What does an asynchronous Linux call for freeing the memory would buy us 
for the rest of the real-time system, compared to the now fixed 
situation where no real-time lock is being held? I don't see your point 
about the potentially induced task scheduling delays in the current case.

> Jan


-- 

Philippe.

