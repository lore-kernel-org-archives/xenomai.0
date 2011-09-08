Message-ID: <4E68873B.6080204@domain.hid>
Date: Thu, 08 Sep 2011 11:13:31 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <4E68226E.2000208@domain.hid>
	<CAOiXNkARu4YOd+K9YMqXbvQhUYEh38fVyNQi-mthMYjQe7mCYA@mail.gmail.com>
In-Reply-To: <CAOiXNkARu4YOd+K9YMqXbvQhUYEh38fVyNQi-mthMYjQe7mCYA@mail.gmail.com>
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
Cc: Xenomai help <xenomai@xenomai.org>, Bob Feretich <bob.feretich@domain.hid>

On 09/08/2011 10:21 AM, Andrey Nechypurenko wrote:
>> So I wrote
>> a RTDM driver to use the three that were pinned out,  and used real time
>> limit and overflow interrupts to to wiggle a GPIO for the fourth PWM output.
> 
> It seams to me that you are using different implementation approach
> then suggested by Gilles in this thread: "I was talking
> about a Xenomai driver, using the RTDM skin using for instance two
> timers, a periodic timer which handler would set the gpio to 1 and
> launch the second timer, a one shot time which handler would set the
> gpio to 0."

If I understand correctly, the difference is that Bob proposes you to
dedicate a hardware timer to the PWM, whereas I propose you to use the
software timers, which ultimately, also depend on a dmtimer. I would not
expect big differences between the two approaches, neither in terms of
jitter, nor in terms of code.

> 
> Could you please say a few words about the reasons why you chose this
> particular way?
> 
>> The Linux version of this driver made the 4th servomotor growl. There is no
>> growl using the RTDM version. I asked a lab technician to probe the four
>> servo PWM signals and tell me which was software GPIO generated. He could
>> not tell.
> 
> timing. So there might be fundamental difference between periodic task
> launched in user-space with rt_task_start/rt_task_set_periodic and
> similar periodic task running as RTDM driver which I do not
> understand. If this assumption is true, I would really appreciate any
> pointers to the documentation which explains what are the differences
> and why RTDM driver can deliver better rt performance then Xenomai
> thread from user-space.

As suggested in the previous mail I sent you, compare the differences in
latencies with latency -t 2 between user-space task and kernel-space
timer. You will see that a timer handler has much less jitter. Switch to
user-space, and context switch time explain the difference.

-- 
					    Gilles.

