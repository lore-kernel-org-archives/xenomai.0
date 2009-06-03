Message-ID: <4A267C51.4010304@domain.hid>
Date: Wed, 03 Jun 2009 09:36:17 -0400
From: Jeff Angielski <jeff@domain.hid>
MIME-Version: 1.0
References: <4A2452CB.2030909@domain.hid> <4A2580C5.4000806@domain.hid>
	<4A258624.4020508@domain.hid>
In-Reply-To: <4A258624.4020508@domain.hid>
Content-Type: text/plain; charset=UTF-8; format=flowed
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
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

Gilles Chanteperdrix wrote:
>>
>> As time marches on, the CONFIG_PREEMPT is getting closer to hard 
>> realtime, especially with the interrupt threading, but I don't think 
>> that time is now.
> 
> threaded interrupts are no silver bullet, they are essentially replacing
> interrupt latencies with kernel-space scheduling latencies; on x86, this
> may not make that much of a difference, but on low-end platform it does.
> 
> See also:
> https://mail.gna.org/public/xenomai-help/2008-05/msg00043.html
> https://mail.gna.org/public/xenomai-help/2009-06/msg00005.html

I meant to write PREEMPT_RT is getting closer to hard realtime.  Sorry 
for the confusion.

As for the interrupt threads, the advantage is not in the latency, it is 
in the ability to control the scheduling of the handlers.  In theory, 
you can schedule your handler the have the highest priority handler.

I totally agree on the different real life performance on the low end 
platforms vs the x86 desktops.

In the end, I think this is a good discussion to have [and keep up to 
date] since it bring out the fundamental design choices of doing 
realtime using Linux.

-- 
Jeff Angielski
The PTR Group
www.theptrgroup.com

