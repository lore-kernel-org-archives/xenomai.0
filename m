Message-ID: <48AB2948.1060209@domain.hid>
Date: Tue, 19 Aug 2008 22:12:56 +0200
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <48AAF7DB.1080603@domain.hid> <48AB1B29.4040001@domain.hid>
	<48AB1EE6.8070003@domain.hid> <48AB241D.9000308@domain.hid>
	<48AB2560.5060804@domain.hid>
In-Reply-To: <48AB2560.5060804@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] [BUG] Lock stealing is borken
Reply-To: rpm@xenomai.org
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
Cc: Jan Kiszka <jan.kiszka@domain.hid>, xenomai-core <xenomai@xenomai.org>

Jan Kiszka wrote:
> Philippe Gerum wrote:
>> Jan Kiszka wrote:
>>> Philippe Gerum wrote:
>>>> Jan Kiszka wrote:
>>>>> Hi,
>>>>>
>>>>> bad news, everyone :(. According to the result of some lengthy debug
>>>>> session with a customer and several ad-hoc lttng instrumentations, we
>>>>> have a fatal bug in the nucleus' implementation of the lock stealing
>>>>> algorithm. Consider this scenario:
>>>>>
>>>>> 1. Thread A acquires Mutex X successfully, ie. it leaves the (in this
>>>>>    case) rt_mutex_acquire service, and its XNWAKEN flag is therefore
>>>>>    cleared.
>>>>>
>>>>> 2. Thread A blocks on some further Mutex Y (in our case it was a
>>>>>    semaphore, but that doesn't matter).
>>>>>
>>>>> 3. Thread B signals the availability of Mutex Y to Thread A, thus it
>>>>>    also set XNWAKEN in Thread A. But Thread A is not yet scheduled on
>>>>>    its CPU.
>>>>>
>>>>> 4. Thread C tries to acquire Mutex X, finds it assigned to Thread A, but
>>>>>    also notices that the XNWAKEN flag of Thread A is set. Thus it steals
>>>>>    the mutex although Thread A already entered the critical section -
>>>>>    and hell breaks loose...
>>>>>
>>>> See commit #3795, and change log entry from 2008-05-15. Unless I misunderstood
>>>> your description, this bug was fixed in 2.4.4.
>>> Oh, fatally missed that fix.
>>>
>>> Anyway, the patch looks a bit unclean to me. Either you are lacking
>>> wwake = NULL in xnpod_suspend_thread, or the whole information encoded
>>> in XNWAKEN can already be covered by wwake directly.
>>>
>> Clearing wwake has to be done when returning from xnsynch_sleep_on, only when
>> the code knows that ownership is eventually granted to the caller; making such a
>> decision in xnpod_suspend_thread() would be wrong.
> 
> What about
> 
> http://www.rts.uni-hannover.de/xenomai/lxr/source/ksrc/nucleus/pod.c#1411
> 
> then?
>

That portion of code applies _before_ the thread enters suspended state. We
bother for the other side, i.e. when it resumes from actual suspension, until it
has been decided whether it should be allowed to keep running, or redo the wait
due to the resource being stolen away.

>> The awake bit has been kept mainly because the nucleus commonly uses bitmasks to
>> get fast access to thread status & information. It's not mandatory to have this
>> one in, it's just conforming to the rest of the implementation.
> 
> I see, but redundancy come with some ugliness as well. And we add more
> code to hot paths.
> 

The hot path barely involves facing a stolen resource situation. Most of the
time, the XNWAKEN test will be false, or this would mean that the application
exhibits a high priority thread that routinely and frequently competes with a
low priority one for gaining access to such resource. I would rather fix the
latter code first.

Regarding the perceived ugliness, I guess this is a matter of taste here. I like
the idea of always testing a given information the same way, like:

if (test_bits(thread, foobar))

and avoid things like:

if (test_bits(thread, foo) || thread->field == bar)

> Jan
> 


-- 
Philippe.

