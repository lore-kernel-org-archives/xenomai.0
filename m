MIME-Version: 1.0
In-Reply-To: <4F955058.6080004@domain.hid>
References: <CAOiXNkD+-yANz15W_cnD9QLjyGH7LUT-Pf8LEJHqx4Kh24pL+g@domain.hid>
	<4F954ABE.20508@domain.hid>
	<CAOiXNkDKRpQKjtvC-H1YsJtHkNWYcWTUEKPqfYv0HQ_=SRHGCw@domain.hid>
	<4F955058.6080004@domain.hid>
Date: Mon, 23 Apr 2012 14:57:44 +0200
Message-ID: <CAOiXNkAGMH+CEQkp3rS0tSZbKQbu9BKrs8SDaFiyY-YFvAdcPA@mail.gmail.com>
From: Andrey Nechypurenko <andreynech@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
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
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: Xenomai help <xenomai@xenomai.org>

>>>> retval =3D rtdm_task_init(&pwm_task[i], // there is currently only one
>>>> element in this array
>>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "pwm-task",
>>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pwm_task_proc,
>>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 0,
>>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 RTDM_TASK_HIGHEST_PRIORITY=
,
>>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 20000000); // 20ms period
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

I see... Nevertheless, I am surprised that context switch is so expensive.

> The other alternative I describe in my last mail, that is, using a
> dedicated hardware timer with its own irq handler, is a bit more of a
> workaround, but still not uncommon in the RTOS world.

Well, if nothing else would help, I'll try this way :-) .

Thank you!
Andrey.

