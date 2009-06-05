Message-ID: <4A296D32.2080003@domain.hid>
Date: Fri, 05 Jun 2009 21:08:34 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <4A294F59020000F80002DC0E@msw.eppendorf.de>	<200906051932.16827.karl.tyss@domain.hid>
	<4A295F43.9090904@domain.hid>
In-Reply-To: <4A295F43.9090904@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] IRQ-Latency when in idle State on ARM
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Xenomai help <xenomai@xenomai.org>, Karl Tyss <tyss.k@domain.hid>

Gilles Chanteperdrix wrote:
> Karl Tyss wrote:
>> Right before the cpu is put to sleep by cp15 the I-cache is being disabled in 
>> the idle task. I took this part out. So I leave the I-cache enabled when the 
>> cpu goes into the idle mode. I suppose that there is a reason for disabling 
>> the cache. I will ask my wise ARM book on monday. If this issue doesn't belong 
>> here (xenomai list) just say a word :)
> 
> Yes, you probably can not do that. You will find the answer in the
> documentation for the arm926EJS core, since this file only concerns this
> core.
> 
> On the other hand, as Bosko suggested, if you use the nohlt kernel
> option, you will avoid the idle function altogether, and the I-cache
> will not be disabled then re-enabled.

Note that the effect you observe is due to the very special nature of
your setup: since you run no significant user-space load, the irq
handling function may remain in the cache, but on a realistically loaded
system, the irq handling function will not be able to remain in the
cache, so, the disabling of the I-cache in the idle function will not
change anything with regard to the worst case latency.

Also note that using a GPIO to assess the timer interrupt latency is a
bad idea: if you want to assess the timer interrupt you should register
a timer, because the path in the kernel is different for the timer
interrupt than for other interrupts and especially for multiplexed GPIO
interrupts. But doing all this by yourself and risking to have problem
that we already solved is not a good idea; what you should really do is
use the latency test provided by Xenomai. It is relatively simple,
covers all the cases, and is validated on many platforms.

-- 
					    Gilles.

