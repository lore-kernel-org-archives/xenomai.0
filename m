From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17581.41221.527736.416354@domain.hid>
Date: Fri, 7 Jul 2006 01:47:17 +0200
Subject: Re: [Xenomai-core] [RFC, PATCH] per-thread exec-time stats
In-Reply-To: <1152196379.4978.74.camel@domain.hid>
References: <44ACF5FA.2050205@domain.hid>
	<1152196379.4978.74.camel@domain.hid>
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: rpm@xenomai.org
Cc: Jan Kiszka <jan.kiszka@domain.hid>, xenomai-core <xenomai@xenomai.org>

Philippe Gerum wrote:
 > > +#ifdef CONFIG_XENO_OPT_STATS
 > > +static inline void xnpod_acc_exec_time(xnsched_t *sched,
 > > +                                       xnthread_t *threadout)
 > > +{
 > > +    xnticks_t now = xntimer_get_rawclock();
 > > +    threadout->stat.exec_time += now - sched->last_csw;
 > > +    sched->last_csw = now;
 > > +}
 > 
 > It would be better to only pass the thread pointer, then use the
 > thread->sched member. This would clearly explain the relationship
 > between both, and prevent any bugous attempt at mixing things.

Beware, when xnpod_schedule is called from within
xnpod_migrate_thread(), the sched pointer of the switched out thread is
the one of the destination cpu. So, passing the sched and threadout
pointers to xnpod_acc_exec_time is safer.


-- 


					    Gilles Chanteperdrix.

