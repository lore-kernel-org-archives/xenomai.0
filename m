Message-ID: <4C46D49F.6030102@domain.hid>
Date: Wed, 21 Jul 2010 13:06:07 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <AANLkTilWSsSuCKRxQg0NIkeeR28eqpdJfaVm_CiemnqF@mail.gmail.com>
In-Reply-To: <AANLkTilWSsSuCKRxQg0NIkeeR28eqpdJfaVm_CiemnqF@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Unexpected preemption of highest priority thread
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Stephen Bryant <sbxenomai@domain.hid>
Cc: xenomai@xenomai.org

Stephen Bryant wrote:
> Hi,
> 
> I have some code (simplified example below) which uses
> 'pthread_wait_np(&Overrun)' within a while loop, using a period of
> 1,000,000ns (1ms) which has been set using 'pthread_make_periodic_np()'.
> This wakes the thread up less than 2,000ns late in general, sometimes
> 20,000ns late, and at most less than 45,000ns late.

Since you do not tell us, I guess you are running on x86. Depending on
the x86 you are running, 45 us may be high.


 To ensure that I perform
> the tasks within the thread from a consistent 'millisecond tick' I set an
> expected time value 45,000ns later than the earliest wake time each period,
> and then use a busy loop until the current time equals this expected time.
> This busy loop takes < 600ns per cycle, and so the latency from my expected
> time should be a maximum of 600ns.

This reasoning is flawed: you may be preempted by interrupts any time.
Including just about at the time where you were going to exit the busy
loop. Unless you spin irqs off, and only reenable irqs when the job the
thread is supposed to be doing is done. And if you have an SMI issue,
even turning off the interrupts will not help.


 The latencies I am actually seeing are as
> high as 13,000ns, and these occur during this busy loop (I have timed it),
> implying that this loop is being preempted.
> 
> while(1)
> {
>    pthread_wait_np(&Overrun);
> 
>    WakeTime = GetTime();
>    while(WakeTime < ExpectedTime)
>    { WakeTime = GetTime(); } // Preempted here
> 
>    DoWork();
> 
>    ExpectedTime += Period;
> }
> 
> This is a Xenomai POSIX thread with a priority of 99, and is the only thread
> within my program with a priority of 99 or higher. There are no context
> switches occuring within this thread (confirmed using pthread_set_mode_np(0,
> PTHREAD_WARNSW)).
> 
> I have had a brief experimentation with kernel settings, for example
> applying the SMI workaround, but this produces no difference to the
> preemption that I measure.

The question is: is the SMI workaround working for your chipset? If that
is the case, you should get messages in the kernel logs.

-- 
					    Gilles.

