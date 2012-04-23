Message-ID: <4F9555EB.4040705@domain.hid>
Date: Mon, 23 Apr 2012 15:15:23 +0200
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <CAOiXNkD+-yANz15W_cnD9QLjyGH7LUT-Pf8LEJHqx4Kh24pL+g@domain.hid>
	<4F954ABE.20508@domain.hid>
	<CAOiXNkDKRpQKjtvC-H1YsJtHkNWYcWTUEKPqfYv0HQ_=SRHGCw@domain.hid>
	<4F955058.6080004@domain.hid>
	<CAOiXNkAGMH+CEQkp3rS0tSZbKQbu9BKrs8SDaFiyY-YFvAdcPA@mail.gmail.com>
In-Reply-To: <CAOiXNkAGMH+CEQkp3rS0tSZbKQbu9BKrs8SDaFiyY-YFvAdcPA@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
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

On 04/23/2012 02:57 PM, Andrey Nechypurenko wrote:
>>>>> retval = rtdm_task_init(&pwm_task[i], // there is currently only one
>>>>> element in this array
>>>>>                        "pwm-task",
>>>>>                        pwm_task_proc,
>>>>>                        0,
>>>>>                        RTDM_TASK_HIGHEST_PRIORITY,
>>>>>                        20000000); // 20ms period
>>>>
>>>> Do not use a thread, use a timer.
>>>
>>> So you mean instead of starting periodic task with rtdm_task_init() it
>>> is better use timer functions to trigger pin toggling piece of code?
>>> Could you please elaborate on it a little? I thought that
>>> rtdm_task_sleep() and rtdm_task_wait_period() are using timers
>>> internally to wake up the thread at the right moment. Is not they?
>>
>> Yes, but once the timer is woken up, a context switch is needed to wake
>> up the thread, this adds time.
>
> I see... Nevertheless, I am surprised that context switch is so expensive.

Keep in mind that in a dual kernel system, the RTOS part is competing 
with the linux kernel on core resources such as CPU caches. So each time 
your code sleeps for the next period, it leaves a 20 ms time window to 
linux to run and happily trash all I/D caches, which is a lot.

Now, if you have to schedule a thread, you have to traverse the Xenomai 
scheduling core to do the switch, in addition to the timer interrupt 
handling, which translates into significantly more code and data being 
accessed.

You can check this effect using the latency test: the faster the 
sampling period, the shorter the latencies, and conversely.

>
>> The other alternative I describe in my last mail, that is, using a
>> dedicated hardware timer with its own irq handler, is a bit more of a
>> workaround, but still not uncommon in the RTOS world.
>
> Well, if nothing else would help, I'll try this way :-) .
>
> Thank you!
> Andrey.
>
> _______________________________________________
> Xenomai-help mailing list
> Xenomai-help@domain.hid
> https://mail.gna.org/listinfo/xenomai-help
>


-- 
Philippe.

