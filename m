Message-ID: <4C3508E1.7090100@domain.hid>
Date: Thu, 08 Jul 2010 01:08:17 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <AANLkTik-cpk4RfJGxj422mOvU1xQFdQCfB8gno7uzD7N@mail.gmail.com>
	<4C34438D.9020905@domain.hid>
	<AANLkTiklX49KAfAlZND9FhVaTJZpdADFpuUIO-lkm6f6@domain.hid>
	<4C34EF76.2040602@domain.hid>
	<AANLkTik9RCKn90TnCj3JWBQF_XWaHbH0vSgp2vOu8HfH@mail.gmail.com>
In-Reply-To: <AANLkTik9RCKn90TnCj3JWBQF_XWaHbH0vSgp2vOu8HfH@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] native: A 32k stack is not always a 'reasonable'
 size
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Peter Soetens <peter@domain.hid>
Cc: xenomai-help <xenomai@xenomai.org>

Peter Soetens wrote:
> On Wed, Jul 7, 2010 at 11:19 PM, Gilles Chanteperdrix
> <gilles.chanteperdrix@xenomai.org> wrote:
>> Peter Soetens wrote:
>>> On Wed, Jul 7, 2010 at 11:06 AM, Gilles Chanteperdrix
>>> <gilles.chanteperdrix@xenomai.org> wrote:
>>>> Peter Soetens wrote:
>>>>> At least, not for Orocos applications. We've had hard to debug
>>>>> application segfaults that used just a 'little' bit more than 32k. We
>>>>> had to raise the stack size to 128k to get reliably through our
>>>>> application startup. I stem from the old 'mlockall ate my RAM'
>>>>> generation where we typically reduced stack sizes in order to have
>>>>> some crumbles left for the heap. But 32k wasn't really what we were
>>>>> aiming for.
>>>>>
>>>>> Maybe we should explicitly document the 32k limit and its limitations
>>>>> for certain applications...?
>>>> Again, things have been fixed in 2.5.3 with regard to stack sizes, could
>>>> you check that you have the same behaviour?
>>> I think we had, but I'm uncertain right now.
>>>
>>>> As for 32KiB, it is only a default stack size, it is only reasonable in
>>>> the sense that 2MiB is unreasonable on a low-end system. 32KiB was
>>>> picked because it allows printf to work. Now, whatever stack size we
>>>> choose, there will be applications which need more, this does not really
>>>> make the default unreasonable.
>>> I knew you would say that. It deserves an entry in the faq or some
>>> trouble shooting document though.
>> It is documented. For instance, rt_task_create says:
>> stksize         The size of the stack (in bytes) for the new task. If
>>                zero is passed, a reasonable pre-defined size will be substituted.
>>
>> What else can we say? Documenting that this size is 32 KiB would be
>> wrong, because we do not want applications to rely on a particular
>> value, in case we want to change it. And the fact that if your stack is
>> too small, you will get problems is kind of obvious. For anyone having
>> played with stack sizes with Linux or any proprietary RTOS, at least.
> 
> And what with new RTOS/Xenomai users ?
> 
> You have to take the user perspective here. The problem with stack
> overflows is that they occur when the development of a program has
> progressed a while and applications reached a certain level of
> complexity (otherwise the overflow wouldn't have happend in the first
> place). So it suddenly starts to segfault (from time to time). What he
> does is this: he fires up the debugger to get a backtrace, sees
> trouble and wrongly assumes that gdb can't really handle these Xenomai
> threads and tries to eliminate causes of the crashes.. 

Last time I tried, debugging a stack overflow with gdb was possible. You
can print the stack pointer and compare the value with the contents of
/proc/pid/maps.

The user comes
> quickly to the conclusion that 'putting it all together' causes the
> crash (the single unit tests pass) and is looking for a software
> integration problem. In reality, it's the stack.
> 
> If you've been through all this and then came to the correct
> conclusion the same day, you've been burnt before, or are the
> exception.
> 
> In my view, 32k is a premature optimization. At least, it shows the
> side effects of one.

I guess you run Xenomai on one of these big irons, do you? Because if
you ran on a low-end machine, you would have understand why we can not
keep the 2MB default limit. 32 KiB looks already like a pretty large
limit, so, maybe there is a problem in your application?

The I-pipe patch for ARM detects stack overflows, I guess we can modify
the kernel on all architectures to do the same thing on all architectures.

-- 
					    Gilles.

