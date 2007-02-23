Subject: Re: [Xenomai-core] latency hangs on AT91RM9200
From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <45DEF122.2060406@domain.hid>
References: <45DECFAF.60304@domain.hid> <45DEE913.9080809@domain.hid>
	<45DEF122.2060406@domain.hid>
Content-Type: text/plain
Date: Fri, 23 Feb 2007 14:57:38 +0100
Message-Id: <1172239058.26738.18.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: Philippe Gerum <philippe.gerum@domain.hid>
Reply-To: rpm@xenomai.org
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

On Fri, 2007-02-23 at 14:50 +0100, Steven Scholz wrote:
> Gilles,
> 
> >> I am running 2.6.19 + adeos-ipipe-2.6.19-arm-1.6-02.patch + xenomai-svn-2007-02-22
> >> on an AT91RM9200 (160MHz/80MHz).
> >>
> >> When starting "latency -p 200" it runs for a while printing
> >>
> >> RTT|  00:05:37  (periodic user-mode task, 200 us period, priority 99)
> >> RTH|-----lat min|-----lat avg|-----lat max|-overrun|----lat best|---lat worst
> >> RTD|      11.200|     139.200|     236.800|       1|      10.800|     280.800
> >>
> >> but then hangs. The timer LED stops blinking. No "soft lockup detected" appears.
> > 
> > The only explanation I have is that the period is too small. I do not
> > observe the same behaviour with latency -p 1000. Note that setting the
> > period to a value comparable to the latency is not considered a normal
> > use of Xenomai. 
> 
> Sure but I would still not expect the system to hang!
> As I said missing a deadline is bad but ok.
> But hanging the whole system is not quite ok.
> 
> >> Using a BDI200 it looks like that in kernel/sched.c:schedule() he is returning
> >> in the lines
> >>
> >> #ifdef CONFIG_IPIPE
> >>         if (unlikely(!ipipe_root_domain_p))
> >>                 return;
> >> #endif /* CONFIG_IPIPE */
> >>
> >> When stepping trough I only see him getting into schedule() but leaving
> >> it in the above lines and in include/linux/proc_fs.h:proc_net_fops_create() ...
> > 
> > Ok. Thanks for pointing this out. That is interesting, but not very
> > informative. It would be interesting if you could get the full
> > backtrace. What would be also interesting would be to set a break point
> > on the timer interrupt handler and to follow what happens from timer
> > interrupt to timer interrupt.
> 
> I tried! Attached the patch I used. Since teh scheduler hangs I can't use normal printk(), right?
> 
> *ipipe_current_domain != ipipe_root_domain !
> *ipipe_current_domain = c01fc2c0
> *ipipe_root_domain    = c01af2c0
> 
> But I don't get the output of __backtrace()!

Before calling your backtrace helper, try adding:

	ipipe_set_printk_sync(ipipe_current_domain);

> 
> my_printk() works with __backtrace(). The dump of a soft lockup works.
> 
> 
> Steven
> 
> _______________________________________________
> Xenomai-core mailing list
> Xenomai-core@domain.hid
> https://mail.gna.org/listinfo/xenomai-core
-- 
Philippe.



