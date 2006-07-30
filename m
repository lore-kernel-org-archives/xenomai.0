From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17613.4212.23333.832165@domain.hid>
Date: Sun, 30 Jul 2006 22:03:00 +0200
Subject: Re: [Xenomai-help] Beginner's question / testsuite / latency
In-Reply-To: <44CD099F.9010507@domain.hid>
References: <442248c90607201417m24729b7cs23a8b82b719ff1cc@domain.hid>
	<200607221152.34298.bidsonux@domain.hid> <44C25DB0.50601@domain.hid>
	<200607282317.34990.bidsonux@domain.hid> <44CB6EB3.5070707@domain.hid>
	<1154282619.4970.25.camel@domain.hid> <44CD099F.9010507@domain.hid>
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: xenomai@xenomai.org

Jan Kiszka wrote:
 > Philippe Gerum wrote:
 > > On Sat, 2006-07-29 at 16:20 +0200, Jan Kiszka wrote:
 > >>>> :|func        6   xnintr_clock_handler (__ipipe_dispatch_wired)
 > >>>> :|func        6   xnintr_irq_handler (xnintr_clock_handler)
 > >>>> :|func        7   xnpod_announce_tick (xnintr_irq_handler)
 > >>>> :|func        8+  xntimer_do_tick_aperiodic (xnpod_announce_tick)
 > >>>> :|func        9   xnthread_periodic_handler (xntimer_do_tick_aperiodic)
 > >>>> :|func       10   xnpod_resume_thread (xnthread_periodic_handler)
 > >>>> :|[21559]    11+  xnpod_resume_thread (xnthread_periodic_handler)
 > >>>> :|func       13+  xnthread_periodic_handler (xntimer_do_tick_aperiodic)
 > >> ...
 > >>
 > >>>> :|func      363+  xnthread_periodic_handler (xntimer_do_tick_aperiodic)
 > >> That are a lot of overruns. Haven't counted, but it should be one
 > >> xnthread_periodic_handler per missed 100 us period (20000 / 100 = 200!).
 > >> [BTW, I think we should handle even this failure scenario without
 > >> looping.
 > > 
 > > We need to loop in the aperiodic handler in order to catch timers that
 > > could have elapsed while processing the current tick. However,
 > 
 > No, that was not what I meant. I know that we need the timer loop. But I
 > was thinking of something like this for the tick handler's error path:
 > 
 > if (unlikely((timer.date += timer.interval) < now))
 > 	timer.date = now + timer.interval -
 > 		(now - timer.date) % timer.interval;

Actually,

while (timer.date < now)
       timer.date += timer.interval

cost much less cycles in the normal/fast case than going through a
division... 


-- 


					    Gilles Chanteperdrix.

