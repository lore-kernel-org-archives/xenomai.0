Subject: Re: [Xenomai-help] Will Linux kernel lose timer ticks when RT
	thread is	running
From: Li Yi <yi.li@domain.hid>
In-Reply-To: <4447441C.3070400@domain.hid>
References: <4546494d0604191120r75d3d5bbs40e37292121f01ed@domain.hid>
	<44474183.8080303@domain.hid>  <4447441C.3070400@domain.hid>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Thu, 20 Apr 2006 19:05:08 +0800
Message-Id: <1145531108.16603.79.camel@domain.hid>
Mime-Version: 1.0
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Philippe Gerum <rpm@xenomai.org>
Cc: xenomai@xenomai.org

Thanks for the clarification.
 
I added a sleep(1) before read the "/proc/interrupts", and the timer
interrupts for Linux kernel really got "Replayed". The system time
catches up with the wall clock.

But still some question:

On Thu, 2006-04-20 at 10:19 +0200, Philippe Gerum wrote:

> > 
> > In the particular case of multi-ms processing, I would likely suggest to
> > move it to a thread running in secondary mode without interrupt
> > shielding, so that Linux asynchronous activities such as interrupt
> > handling would still be possible, at the expense of a lesser execution
> > time predictability of such processing though.
> > 
> >

In my test, I am using rt_timer_spin() to simulate the real-time
workload. And "/proc/xenomai/stat" shows "MSW" as "1/1", and in one test
loop, there is no change for "MSW". So I concluded my test case is
running in secondary mode. And my "Interrupt shield support"
configuration is _not_ select. But it looks the Linux kernel does _not_
handle timer interrupt while the real-time task is running. Did I miss
anything? 


> > 
> > You may want to make your measurement thread sleep() for a while before
> > looking at the final tick counter; this would make sure that the IRQ
> > threads have been given enough time to catch up and process all pending
> > ticks they have in their log. Btw, did you activate CONFIG_PREEMPT?
> > 
> 
> Er, sorry. There's no CONFIG_PREEMPT on Blackfin yet.


Thanks,

-Li Yi (Adam)

