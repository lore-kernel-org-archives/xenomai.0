Message-ID: <45DEE913.9080809@domain.hid>
Date: Fri, 23 Feb 2007 14:16:03 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] latency hangs on AT91RM9200
References: <45DECFAF.60304@domain.hid>
In-Reply-To: <45DECFAF.60304@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Steven Scholz <steven.scholz@domain.hid>
Cc: Xenomai-core@domain.hid

Steven Scholz wrote:
> Hi,
> 
> i pick up this issue again.
> 
> I am running 2.6.19 + adeos-ipipe-2.6.19-arm-1.6-02.patch + xenomai-svn-2007-02-22
> on an AT91RM9200 (160MHz/80MHz).
> 
> When starting "latency -p 200" it runs for a while printing
> 
> RTT|  00:05:37  (periodic user-mode task, 200 us period, priority 99)
> RTH|-----lat min|-----lat avg|-----lat max|-overrun|----lat best|---lat worst
> RTD|      11.200|     139.200|     236.800|       1|      10.800|     280.800
> RTD|      11.200|     146.400|     253.200|       1|      10.800|     280.800
> RTD|      11.200|     144.400|     240.400|       1|      10.800|     280.800
> 
> but then hangs. The timer LED stops blinking. No "soft lockup detected" appears.

The only explanation I have is that the period is too small. I do not
observe the same behaviour with latency -p 1000. Note that setting the
period to a value comparable to the latency is not considered a normal
use of Xenomai. When setting the period to 100 us on x86, the latency is
less than 50 us (and most of the time a lot less than that), so the
period is at least twice the latency. If you observe a latency of 300
us, you should select a period of at least 600 us to run the test in the
same conditions.

> 
> Using a BDI200 it looks like that in kernel/sched.c:schedule() he is returning
> in the lines
> 
> #ifdef CONFIG_IPIPE
>         if (unlikely(!ipipe_root_domain_p))
>                 return;
> #endif /* CONFIG_IPIPE */
> 
> When stepping trough I only see him getting into schedule() but leaving
> it in the above lines and in include/linux/proc_fs.h:proc_net_fops_create() ...

Ok. Thanks for pointing this out. That is interesting, but not very
informative. It would be interesting if you could get the full
backtrace. What would be also interesting would be to set a break point
on the timer interrupt handler and to follow what happens from timer
interrupt to timer interrupt.

I do not think to remember that there are cases where calling schedule
from a real-time context is done by Xenomai, so maybe you can call panic
in schedule instead of returning. I will try and trig a tracer freeze
and dump the tracer at this point in order to have a better idea of what
 happens.

-- 
                                                 Gilles Chanteperdrix

