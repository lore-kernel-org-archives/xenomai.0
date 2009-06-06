Message-ID: <4A2AA98D.4030407@domain.hid>
Date: Sat, 06 Jun 2009 19:38:21 +0200
From: Karl Tyss <karl.tyss@domain.hid>
MIME-Version: 1.0
References: <4A294F59020000F80002DC0E@msw.eppendorf.de>	<200906051932.16827.karl.tyss@domain.hid>	<4A295F43.9090904@domain.hid>
	<4A296D32.2080003@domain.hid>
In-Reply-To: <4A296D32.2080003@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
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
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

Hi Gilles,
> Note that the effect you observe is due to the very special nature of
> your setup: since you run no significant user-space load, the irq
> handling function may remain in the cache, but on a realistically loaded
> system, the irq handling function will not be able to remain in the
> cache, so, the disabling of the I-cache in the idle function will not
> change anything with regard to the worst case latency.
>   

you are absolutely right. Its also clear to me that the maximum 
latencies are more relevant but in my case I also have to know how the 
latencies are if the system has no load. This will be the most probable 
case in my system. This is a special case but I believe also a pretty 
common one so I have to be able to explain the behaviour in detail. 
Thanks to your help I am able to do this now :)

> Also note that using a GPIO to assess the timer interrupt latency is a
> bad idea: if you want to assess the timer interrupt you should register
> a timer, because the path in the kernel is different for the timer
> interrupt than for other interrupts and especially for multiplexed GPIO
> interrupts. But doing all this by yourself and risking to have problem
> that we already solved is not a good idea; what you should really do is
> use the latency test provided by Xenomai. It is relatively simple,
> covers all the cases, and is validated on many platforms.
>   
Acually I have already been using the latency test from xenomai to find 
the average and max latencies but the GPIO way seemed for me to be the 
best way to get a continous data set in order to plot the results. I am 
now able to record about half a million interrupts contineously in a 
relative short period of time. These results alone are not 
representative but in combination with the latency test.

So to come to an end... thank you for the quick help and if I find out 
something more I'll post it for the future generations :D

Regards,
Karl Tyss

