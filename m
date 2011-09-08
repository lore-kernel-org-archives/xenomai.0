Message-ID: <4E6893B3.2070004@domain.hid>
Date: Thu, 08 Sep 2011 12:06:43 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <4E68226E.2000208@domain.hid>	<CAOiXNkARu4YOd+K9YMqXbvQhUYEh38fVyNQi-mthMYjQe7mCYA@mail.gmail.com>	<4E68873B.6080204@domain.hid>
	<CAOiXNkBjaSMRt1GO51hQUrU52PjQHZB9SfJXZzmAx72sYzyfMw@domain.hid>
In-Reply-To: <CAOiXNkBjaSMRt1GO51hQUrU52PjQHZB9SfJXZzmAx72sYzyfMw@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] PWM generation with GPIO
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Andrey Nechypurenko <andreynech@domain.hid>
Cc: Xenomai help <xenomai@xenomai.org>

On 09/08/2011 11:30 AM, Andrey Nechypurenko wrote:
>> If I understand correctly, the difference is that Bob proposes you to
>> dedicate a hardware timer to the PWM, whereas I propose you to use the
>> software timers, which ultimately, also depend on a dmtimer. I would not
>> expect big differences between the two approaches, neither in terms of
>> jitter, nor in terms of code.
> 
> I see. Thanks for the explanations.
> 
>> As suggested in the previous mail I sent you, compare the differences in
>> latencies with latency -t 2 between user-space task and kernel-space
>> timer. You will see that a timer handler has much less jitter.
> 
> It is clear for me that there is a difference. I am trying to
> understand what is the reason for the difference. I thought that as
> soon as Xenomai task is created (does not matter from user or kernel
> space) it is managed by Xenomai in the similar way and correspondingly
> the results should be also similar (which is obviously no the case).

xenomai provides user-space threads and kernel-space threads, which work
much like linux user-space and kernel-space threads.

> 
>> Switch to user-space, and context switch time explain the difference.
> 
> So is it the only reason for the differences or there are some other
> factors influencing the results?

It is the only reason.

With latency -t 2. As soon as the timer interrupt happens, the timer
handler, which runs in irq context, measures the jitter.

With latency -t 0. When the timer interrupt happens, we need to switch
to the kernel-space task associated with the user-space sampling task,
in the worst case, the currently running task was not in the same memory
space, so, a switch of the mmu context is needed. Then we need to return
to user-space, as a return to the "rt_task_wait_period" syscall at which
point the jitter is measured.

All this involves longer code paths and greater opportunities for cache
effects.

This difference between kernel-space and user-space explains why we
advise people to split their application between application and driver,
the really critical part using the RTDM skin, in kernel-space, much like
you would do with linux.

-- 
					    Gilles.

