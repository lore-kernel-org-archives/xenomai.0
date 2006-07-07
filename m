Subject: Re: [Xenomai-core] [RFC, PATCH] per-thread exec-time stats
From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <44AE2372.6020006@domain.hid>
References: <44ACF5FA.2050205@domain.hid> <1152196379.4978.74.camel@domain.hid>
	<44AD27AF.8050804@domain.hid> <1152200271.4978.85.camel@domain.hid>
	<44AD3048.5050602@domain.hid>  <44AD3C00.9050909@domain.hid>
	<1152259455.5017.14.camel@domain.hid>  <44AE16B3.80901@domain.hid>
	<1152262158.5017.22.camel@domain.hid>  <44AE2372.6020006@domain.hid>
Content-Type: text/plain
Date: Fri, 07 Jul 2006 13:28:44 +0200
Message-Id: <1152271725.5050.6.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
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
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: xenomai-core <xenomai@xenomai.org>

On Fri, 2006-07-07 at 11:03 +0200, Jan Kiszka wrote:
> >> Far too complex in my eyes for this simple purpose (what's the pid of
> >> kernel-only threads?) -
> > 
> > It's symbolic name. It's not a matter of simplicity, your patch for that
> > purpose is rather complex already.
> 
> Haven't measured, but the amount of code added for collecting the data
> and printing just another column should be marginal as yet. Introducing
> a new infrastructure for more /proc subdirs with probably multiple
> entries would certainly cost more.
> 

This has no cost on the real-time side of things. In contrast, scanning
the threadq within /proc handlers like /stats and /sched are doing now,
does have some noticeable cost. By having separate per-thread entries,
we provide the necessary infrastructure for exporting more raw
statistical data to user-space tools, in a format which would be
script-friendly.

> > 
> >>  and we need to solve the latency problem of
> >> /sched and /stat anyway.
> > 
> > That's separate issues. Solving the scalability issue
> > of /proc/xenomai/stats and friends does not improve their usability in
> > the context of user-space tools monitoring thread activity. E.g. how are
> > we going to extend the reporting about such activity if need be, adding
> > yet another column to /stats and /sched?
> 
> As long as there are no stand-alone tools relying on the layout, just
> only our own ones - fairly simple. But before speculating more, I will
> have a look now how simple such tool/script may actually be.
> 
> Jan
> 
-- 
Philippe.



