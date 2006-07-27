MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17608.44152.382271.773012@domain.hid>
Date: Thu, 27 Jul 2006 14:07:20 +0200
Subject: RE: [Xenomai-help] Xenomai task (beginner)
In-Reply-To: <1299EF3181B10F479D85C3280132852422DABF@THEZE.intra.cea.fr>
References: <17607.23166.422964.660390@domain.hid>
	<1299EF3181B10F479D85C3280132852422DABF@THEZE.intra.cea.fr>
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: GUARDIOLA-FALCO Sebastien 204282 <Sebastien.GUARDIOLA-FALCO@domain.hid>
Cc: xenomai@xenomai.org

GUARDIOLA-FALCO Sebastien 204282 wrote:
 > Gilles Chanteperdrix wrote :
 > >The worst case latency of your polling program is given by the longest
 > >time during which Linux will preempt your polling task. If this polling
 > >program is the only program running, then the longest preemption will be
 > >given by the execution time of the longest interruption handler, likely
 > >the timer interrupt.
 > 
 > Ok so if I understand, during a polling cycle interrupted by
 > preemption of the timer interrupt, we are in the worst case
 > latency. 

Only if there are no other activities with higher priority. And in
this case you observe that the computer is blocked during the polling.

 > Could you explain a little what is this timer interrupt
 > please? As far as I know, this soft irq is how the kernel stops doing
 > whatever it's currently doing to check if it needs to be doing
 > something else. I'm using Linux 2.4 with the preemptible kernel
 > option. Do you have an idea of the frequency of the timer interrupt
 > or how to know it? My results shows weird things like a quite long
 > latency (a value between 100 and 200 microseconds) EVERY 60 seconds! 
 > May be it's this timer we are talking about?

The timer interrupt frequency is 100 Hz on 2.4 and either 100 Hz, 250 Hz
or 1000 Hz on 2.6, it is configurable at compilation time.

 > 
 > 
 > >You will get similar behaviour with Xenomai, with the additional
 > >constraint that Linux will not be running at all as long as your
 > >program runs. If we assume that Xenomai timer interrupt handler is
 > >shorter than Linux interrupt handler, then you will get a shorter
 > >worst case latency with Xenomai.
 > 
 > By "if we assume", you may say that it depends on kernel version. On this point, do you know the differences of my linux 2.4 alone, versus Xenomai patched to 2.6?

No, I meant that it is not directly a measure that matters in typical
use cases, because Xenomai anticipates, the hardware timer ticks a
little bit before the next software timer release point in order to
account for the interrupt duration. The measure that matters in typical
use cases is the scheduling latency. This said, Xenomai timer interrupt
should have much less work to do than Linux timer interrupt, so should
be shorter.

 > 
 > >Note however that either with Xenomai or with Linux using the SCHED_FIFO
 > >policy, you can not be running your polling program all the time,
 > >because everything else that is not running with the SCHED_FIFO policy
 > >will be blocked.
 > 
 > I disabled this policy since today, precisely trying to run other processes in order to load cpu usage. But it's obvious that even with a normal policy, my prompt is completely blocked! Same result on serial port console and with a telnet...

If you do not use SCHED_FIFO policy, then your worst case latency will
be much higher than if you were using interruptions, because Linux will
forcibly suspend your task from time to time in order to let other tasks
run during tens of milliseconds.

-- 


					    Gilles Chanteperdrix.

