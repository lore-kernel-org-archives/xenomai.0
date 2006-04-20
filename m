Subject: Re: [Xenomai-help] Will Linux kernel lose timer ticks when
	RT	thread is	running
From: adam li <yi.li@domain.hid>
In-Reply-To: <44478290.3040805@domain.hid>
References: <4546494d0604191120r75d3d5bbs40e37292121f01ed@domain.hid>
	<44474183.8080303@domain.hid>  <4447441C.3070400@domain.hid>
	<1145531108.16603.79.camel@domain.hid> <44478290.3040805@domain.hid>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Thu, 20 Apr 2006 21:43:33 +0800
Message-Id: <1145540615.22770.49.camel@domain.hid>
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

On Thu, 2006-04-20 at 14:46 +0200, Philippe Gerum wrote:
> Li Yi wrote:
> > Thanks for the clarification.
> >  
> > I added a sleep(1) before read the "/proc/interrupts", and the timer
> > interrupts for Linux kernel really got "Replayed". The system time
> > catches up with the wall clock.
> > 
> > But still some question:
> > 
> > On Thu, 2006-04-20 at 10:19 +0200, Philippe Gerum wrote:
> > 
> > 
> >>>In the particular case of multi-ms processing, I would likely suggest to
> >>>move it to a thread running in secondary mode without interrupt
> >>>shielding, so that Linux asynchronous activities such as interrupt
> >>>handling would still be possible, at the expense of a lesser execution
> >>>time predictability of such processing though.
> >>>
> >>>
> > 
> > 
> > In my test, I am using rt_timer_spin() to simulate the real-time
> > workload. And "/proc/xenomai/stat" shows "MSW" as "1/1", and in one test
> > loop, there is no change for "MSW". So I concluded my test case is
> > running in secondary mode. And my "Interrupt shield support"
> > configuration is _not_ select. But it looks the Linux kernel does _not_
> > handle timer interrupt while the real-time task is running. Did I miss
> > anything? 
> >
> 
> rt_timer_spin() is a busy-waiting service, and your measurement task 
> never relinquishes the CPU while processing. I would bet that you set up 
> a very high (maximum?) SCHED_FIFO priority to the Xenomai task, which 
> did not allow the IRQ thread to run.
> 
> i.e. On the Blackfin architecture, Adeos scales the IRQ thread priority 
> from SCHED_FIFO(50) to SCHED_FIFO(50 + (IVG13-IVG7)), which would have a 
> lesser priority than anything above SCHED_FIFO(56).
> 

Yes. I set the the priority to be 99 - the highest. I tried to lower the
priority of the thread to 40, and the Linux kernel handles timer
ticks.  

Thanks for the answer.

