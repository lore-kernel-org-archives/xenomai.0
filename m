Message-ID: <4A258624.4020508@domain.hid>
Date: Tue, 02 Jun 2009 22:05:56 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <4A2452CB.2030909@domain.hid> <4A2580C5.4000806@domain.hid>
In-Reply-To: <4A2580C5.4000806@domain.hid>
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
> Adrien LECOINTRE wrote:
>> Hi,
>>
>> I've been testing for a while, Xenomai and Linux preempt RT latencies 
>> under different loads and I couldn't find any big differences. Latencies 
>> are almost the same.
>> So my question is, do you know any case where Xenomai is really better 
>> than a simple preempt RT?
>> Or which specification in a real time application should make me chose 
>> Xenomai instead of preempt RT?
> 
> I suspect your loads are not sufficiently exercising your system.
> 
> To answer your question, though, it all depends on your requirements, 
> whether you need hard or soft realtime.  In other words, is it ok to 
> miss your deadline every so often?  If so, CONFIG_PREEMPT would be fine 
> for you. If you can't miss any deadlines, use Xenomai.
> 
> Of course, just by choosing to use Xenomai, you don't get hard realtime. 
>   You still need to design your system and software correctly.
> 
> As time marches on, the CONFIG_PREEMPT is getting closer to hard 
> realtime, especially with the interrupt threading, but I don't think 
> that time is now.

threaded interrupts are no silver bullet, they are essentially replacing
interrupt latencies with kernel-space scheduling latencies; on x86, this
may not make that much of a difference, but on low-end platform it does.

See also:
https://mail.gna.org/public/xenomai-help/2008-05/msg00043.html
https://mail.gna.org/public/xenomai-help/2009-06/msg00005.html

-- 
					    Gilles.

