Message-ID: <4A26890D.3040304@domain.hid>
Date: Wed, 03 Jun 2009 16:30:37 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <4A2452CB.2030909@domain.hid> <4A2580C5.4000806@domain.hid>
	<4A258624.4020508@domain.hid> <4A267C51.4010304@domain.hid>
In-Reply-To: <4A267C51.4010304@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] How to chose between xenomai and preempt RT
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Jeff Angielski <jeff@domain.hid>
Cc: xenomai@xenomai.org

Jeff Angielski wrote:
> Gilles Chanteperdrix wrote:
>>> As time marches on, the CONFIG_PREEMPT is getting closer to hard 
>>> realtime, especially with the interrupt threading, but I don't think 
>>> that time is now.
>> threaded interrupts are no silver bullet, they are essentially replacing
>> interrupt latencies with kernel-space scheduling latencies; on x86, this
>> may not make that much of a difference, but on low-end platform it does.
>>
>> See also:
>> https://mail.gna.org/public/xenomai-help/2008-05/msg00043.html
>> https://mail.gna.org/public/xenomai-help/2009-06/msg00005.html
> 
> I meant to write PREEMPT_RT is getting closer to hard realtime.  Sorry 
> for the confusion.
> 
> As for the interrupt threads, the advantage is not in the latency, it is 
> in the ability to control the scheduling of the handlers.  In theory, 
> you can schedule your handler the have the highest priority handler.

The real advantage or the threaded interrupts is that the part of the
kernel-space code that need to protect from a particular interrupt
remains preemptible by other interrupts. The interrupt handler
themselves were already preemptible, if they did not use the
IRQF_DISABLED flag.

Note that the same effect could be obtained by disabling only the
particular interrupt at PIC level, but this would have mean a lot more
of code changes than what threaded interrupts need. But probably a lot
less run-time overhead.

-- 
					    Gilles.

