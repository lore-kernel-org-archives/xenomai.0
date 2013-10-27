Message-ID: <526D49C4.9020102@xenomai.org>
Date: Sun, 27 Oct 2013 18:13:40 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <526B99CD.3080303@xenomai.org>,
 <OF415A91C1.3CB4977D-ON85257C0F.0078CAEF-85257C0F.0078CB7B@moog.com>
 <OF4C4FACAC.0349F48E-ON85257C11.005CE00C-85257C11.005CE031@moog.com>
In-Reply-To: <OF4C4FACAC.0349F48E-ON85257C11.005CE00C-85257C11.005CE031@moog.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] rt_heap_alloc priority inversion
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: George Broz <GBroz@moog.com>
Cc: Xenomai@xenomai.org

On 10/27/2013 05:54 PM, George Broz wrote:
> -----Philippe Gerum <rpm@xenomai.org> wrote: -----
>>
>> On 10/25/2013 11:59 PM, George Broz wrote:
>>> Hello All,
>>>
>>> I'm running Linux 2.6.37.6 w/Xenomai 2.6.1, native API
>>> on x86 (Atom, SMP, 32-bit).
>>>
>>> I have two tasks, both running in Xenomai user-space.
>>> One is priority=99 and blocks on rt_intr_wait(),
>>> running every 250 us with 125us margin. This task does
>>> not make direct calls to rt_heap_alloc/free().
>>>
>>> The other task is priority=50, wakes 1msec, sleeps 1msec.
>>> This task routinely makes rt_heap_alloc/free calls.
>>>
>>> When the priority=50 task makes rt_heap_alloc() calls
>>> for "size" greater than 5 MB, the priority=99 task
>>> appears to be held off from executing for several ms.
>>>
>>> Plenty of memory is available (vmalloc=320M as linux
>>> boot arg).
>>
>> The size that matters in how much memory you assigned to the heap in
>>
>> rt_heap_create().
> 
> Yes, sorry. Passing 256 MB (as 268,435,456) to rt_heap_create().
> 
>>
>>  TM_NONBLOCK is used when calling
>>> rt_heap_alloc(). Both "0" and H_PRIO have been tried
>>> for "mode" when creating the area with rt_heap_create().
>>>
>>> Is this expected behavior?
>>>
>>> How can large memory allocations be built without a
>>> "realloc" equivalent offered in the memory heap
>>> services?
>>>
>>>
>>
>> There is no reallocation in the rt heap services, ever. If H_SINGLE
>> was 
>> passed to rt_heap_create(), there is not even any "allocation", the 
>> address of the heap memory is returned in that case, as it is viewed
>> as 
>> a single buffer.
>>
>> Assuming you don't pass H_SINGLE when creating the heap, 
> 
> 
> We're not passing H_SINGLE when creating the heap. The only mode flag 
> passed to _create() is H_PRIO or H_FIFO ("0") - have tried both, 
> and resulting behavior is the same.
> 
> 
>> the only reason 
>> to get delays in non-blocking allocation mode would be that a minor
>> VM 
>> fault unexpectedly happens when the 5MB block is being pulled from
>> the 
>> heap, when writing our meta-data to that memory area. That would mean
>>
>> that your calling thread switches to secondary mode for handling the
>>
>> fault, and gets delayed for this reason.
>>
>> You should first try checking this assumption, by enabling T_WARNSW
>> for 
>> your thread. If this is confirmed, then there could be something
>> wrong 
>> in the i-pipe layer for your kernel release.
> 
> We always run with T_WARNSW turned on for the Xenomai tasks that
> should never switch to secondary. A backtrace is generated if 
> a secondary transition occurs. We have used this mechanism 
> extensively in our development. When we attempt to allocate 
> 5 MB, neither the calling task (prio=50), nor the high priority
> task (prio=99) that gets held off logs a secondary mode 
> transition.
> 
> 
> Going a step further, we can run in "simulation" mode where the
> hardware interrupt source (on which rt_intr_wait() is waiting) 
> is replaced with rt_task_set_periodic()/rt_task_wait_period()
> and the same behavior results.
> 
> Any ideas?

I would suggest again trying the latest version, and it does not mean
updating the kernel.
Another idea would be to run the test without CONFIG_SMP, or booting
with nr_cpus=1 if you are using hyper threading.


-- 
                                                                Gilles.

