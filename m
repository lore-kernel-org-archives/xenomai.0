Message-ID: <4A4B4BD9.2020506@domain.hid>
Date: Wed, 01 Jul 2009 13:43:21 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <4A4B34D3.3090004@domain.hid>
In-Reply-To: <4A4B34D3.3090004@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] How to get the next periodic task awakening
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: nocia.one@domain.hid
Cc: xenomai@xenomai.org

Nocia wrote:
> Hi all,
> 
> I'm a beginer in the Xenomai world.
> 
> 
> I'm working on the Xenomai kernel in order to minimize the power
> consumption, for my university final project
> (/http/://xenomaiote.googlecode.com).
> 
> To do that I'm trying to implement OTE (one time extension).

Ok, I have found this
http://www.google.com/url?sa=t&source=web&ct=res&cd=8&url=http%3A%2F%2Fwww.embeddedcomputingconference.ch%2Fdownload_sec%2F1B-Evequoz.pdf&ei=-UhLSsLDGJaRjAfwm4Fl&rct=j&q=%22one+time+extension%22+operating+system&usg=AFQjCNGPkM9-VpD8jFNIa38xmu4hruEdkw

Is this what you are talking about?


> (...)
> To get the next timer that will wake up :
> 
> xntimerq_head(&sched->timerqueue)
> 
> 
> To get the date of the next wake up :
> 
> xntimerh_date(&timer->aplink)
> 
> 
> Then I compare this date with the date of the next ingoing task (except
> the root task) with xnarch_get_cpu_tsc()

xntimerq_head is the next timer which is going to fire, this is not
necessarily attached to a task, and even if it was, there is no
guarantee that nothing else will happen between now and this next event.
Another task may be woken up by an interrupt, or even by the current
task, tasks are not necessarily time-triggered.

xntimerh_date(&timer->aplink) only works for aperiodic timers.

I think you are looking in the wrong direction. What you really need is
to implement a new scheduler class (EDF with OTE or something like
that), and implement things in this abstraction, not by patching
xnpod_schedule.

Also note that the default scheduler classes (FIFO and RR) do their job
without knowing what the WCET of a task is, and from what I saw,
skimming the document mentioned above, you need this information, so,
you absolutely need a new scheduler class.


-- 
					    Gilles.

