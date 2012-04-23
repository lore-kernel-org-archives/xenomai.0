Message-ID: <4F955230.8080806@domain.hid>
Date: Mon, 23 Apr 2012 14:59:28 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <CAOiXNkD+-yANz15W_cnD9QLjyGH7LUT-Pf8LEJHqx4Kh24pL+g@domain.hid>	<4F954ABE.20508@domain.hid>	<CAOiXNkDKRpQKjtvC-H1YsJtHkNWYcWTUEKPqfYv0HQ_=SRHGCw@domain.hid>
	<4F955058.6080004@domain.hid>
In-Reply-To: <4F955058.6080004@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Jitter while generating PWMs with GPIO from RTDM
 driver
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

On 04/23/2012 02:51 PM, Gilles Chanteperdrix wrote:
> On 04/23/2012 02:35 PM, Andrey Nechypurenko wrote:
>>>> retval = rtdm_task_init(&pwm_task[i], // there is currently only one
>>>> element in this array
>>>>                       "pwm-task",
>>>>                       pwm_task_proc,
>>>>                       0,
>>>>                       RTDM_TASK_HIGHEST_PRIORITY,
>>>>                       20000000); // 20ms period
>>>
>>> Do not use a thread, use a timer.
>>
>> So you mean instead of starting periodic task with rtdm_task_init() it
>> is better use timer functions to trigger pin toggling piece of code?
>> Could you please elaborate on it a little? I thought that
>> rtdm_task_sleep() and rtdm_task_wait_period() are using timers
>> internally to wake up the thread at the right moment. Is not they?
> 
> Yes, but once the timer is woken up, a context switch is needed to wake
> up the thread, this adds time.
> 
>>
>> Is not it a kind of work-around you suggesting? If there are some
>> problems which led to the imprecise timing of the sleep/wait functions
>> mentioned above, then, if technically possible, it would be better to
>> fix them instead of working around this behavior.
> 
> No, the time it takes to switch context between threads is unavoidable.
> So, if you want to avoid it, you have to use a timer (rtdm_timer_init),
> note that it is really common in RTOS interfaces to offer a timer API,
> this is not a workaround at all.
> 
> The other alternative I describe in my last mail, that is, using a
> dedicated hardware timer with its own irq handler, is a bit more of a
> workaround, but still not uncommon in the RTOS world.
> 

Another trick, which this time really is a workaround is to program the
timers to wake up a little bit early, and spin to wait for the exact
time wanted.

-- 
					    Gilles.

