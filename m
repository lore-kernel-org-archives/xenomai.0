Subject: Re: [Xenomai-core] [RFC, PATCH] per-thread exec-time stats
From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <44AD27AF.8050804@domain.hid>
References: <44ACF5FA.2050205@domain.hid> <1152196379.4978.74.camel@domain.hid>
	<44AD27AF.8050804@domain.hid>
Content-Type: text/plain
Date: Thu, 06 Jul 2006 17:37:51 +0200
Message-Id: <1152200271.4978.85.camel@domain.hid>
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

On Thu, 2006-07-06 at 17:09 +0200, Jan Kiszka wrote:
> > We could do that from the current loop below, given that the
> > accumulation routine is changed to use thread->sched implicitely.
> 
> The idea is avoid adding even further load to the nklock-protected loop.
> And we only update the current thread, not each and every.
> 

Yes, but why? I mean, accumulated time so far remains significant even
for non-running threads.

> > 
> >>  	/* Take a snapshot and release the nucleus lock immediately after,
> >>  	   so that dumping /proc/xenomai/stat with lots of entries won't
> >>  	   cause massive jittery. */
> >> @@ -359,6 +374,7 @@ static int stat_seq_open(struct inode *i
> >>  		iter->stat_info[n].ssw = thread->stat.ssw;
> >>  		iter->stat_info[n].csw = thread->stat.csw;
> >>  		iter->stat_info[n].pf = thread->stat.pf;
> >> +		iter->stat_info[n].exec_time = thread->stat.exec_time;
> >>  	}
> >>  
> >>  	xnlock_put_irqrestore(&nklock, s);
> >>
> >>
> >>
> >> _______________________________________________
> >> Xenomai-core mailing list
> >> Xenomai-core@domain.hid
> >> https://mail.gna.org/listinfo/xenomai-core
> 
> 
-- 
Philippe.



