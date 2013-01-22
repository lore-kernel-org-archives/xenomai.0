Message-ID: <50FEDAB6.9070003@xenomai.org>
Date: Tue, 22 Jan 2013 19:30:14 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <CAPpP=rM-0xrf5N9iKVq2S+7wRrD4LoHxMTUxnxYb6aYbNP9nEA@mail.gmail.com>	<50FE6259.40406@xenomai.org>	<CAPpP=rP0Br9Jv0Rp73=CW7Qd2Tw8c7xFguXYGSSuRi+jBvPDDw@mail.gmail.com>
	<50FE7945.2080002@xenomai.org>
In-Reply-To: <50FE7945.2080002@xenomai.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] [Posix skin] program test with pthread_set_mode_np
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Philippe Gerum <rpm@xenomai.org>
Cc: Xenomai <xenomai@xenomai.org>

On 01/22/2013 12:34 PM, Philippe Gerum wrote:

> On 01/22/2013 12:09 PM, alex alex wrote:
>> 2013/1/22 Philippe Gerum <rpm@xenomai.org>
>>
>>> On 01/22/2013 10:41 AM, alex alex wrote:
>>>
>>>> Hi,
>>>>
>>>> In the attached test program I test the scheduler lock operation with
>>>> pthread_set_mode_np and the PTHREAD_LOCK_SCHED bit mask.
>>>>
>>>> Description:
>>>> Two tasks are created.
>>>> t1 lock the scheduler then load the cpu, sleep then load the cpu again but
>>>> t2 task start when t1 sleep while the scheduler is locked. Why t1 is
>>>> preempted?
>>>>
>>>
>>> Think of what would happen would a blocked task be allowed to keep the
>>> scheduler lock.
>>>
>>>
>>>>
>> According to the documentation :
>> "PTHREAD_LOCK_SCHED when set, locks the scheduler, which prevents the
>> current thread from being switched out by the scheduler until the scheduler
>> is unlocked"
>> This is what t1 do, locking the scheduler then unlocked it.
>> t1 shouldn't be switched out until the scheduler be unlocked.
> 
> No. If t1 suspends willingly, then Xenomai drops the lock implicitly. 
> The scheduler lock is not just yet another lock, it protects the CPU as 
> a resource: this is a big massive traffic light preventing the RTOS to 
> do its basic job: i.e. task scheduling.
> 
> The documentation states that no other thread will __preempt__ the 
> __running__ thread holding the lock, not that a thread holding the lock 
> will keep it when it decides to drop the CPU resource, in which case 
> owning the lock is totally meaningless.
> 
> Functionally speaking, this situation is a gray area: there is no 
> recommended behavior simply because the situation (i.e. going to sleep 
> while holding the schedlock) is broken. So the RTOS has two options when 
> the application does this:
> 
> - assume this behavior is a bug, don't even try to neither detect nor 
> handle the situation, and let the user figure out why this is wrong (ask 
> vrtx32 or VxWorks users how fun it is).
> 
> - albeit locking the scheduler without having all the resources at hand 
> is generally a bad idea, assume the caller might really have a good 
> reason to call a blocking service, dropping the lock while this happens, 
> and reacquire it automatically when it wakes up.
> 
> #2 is current for Xenomai , because we tend to think people know what 
> they are doing with a real-time API.


At some point in time Xenomai used to panic when this happened. I seem
to remember the change was made in relation to the VxWorks emulator.


-- 
                                                                Gilles.

