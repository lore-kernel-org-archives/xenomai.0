Subject: Re: [Xenomai-core] Re: [patch] memory barriers in intr.c ::
	xnintr_lock/unlock()
From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <45774C35.3070101@domain.hid>
References: <b647ffbd0611111559y8e66c37m12deb64828a85d08@domain.hid>
	<45774C35.3070101@domain.hid>
Content-Type: text/plain
Date: Fri, 08 Dec 2006 18:54:01 +0100
Message-Id: <1165600441.9091.32.camel@domain.hid>
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
Cc: xenomai@xenomai.org

On Thu, 2006-12-07 at 00:03 +0100, Jan Kiszka wrote:
> Dmitry Adamushko wrote:
> > Hello,
> > 
> > following the recent discussion with Jan, here is a patch that aims at
> > allowing xnintr_lock/unlock actually do what they were supposed to do in
> > the first instance.
> > 
> 
> [...]
> 
> > 
> > --- xenomai/ksrc/nucleus/intr-old.c	2006-11-12 00:17:56.000000000 +0100
> > +++ xenomai/ksrc/nucleus/intr.c	2006-11-12 00:22:15.000000000 +0100
> > @@ -135,12 +135,14 @@ static inline void xnintr_shirq_lock(xni
> >  {
> >  #ifdef CONFIG_SMP
> >  	xnarch_atomic_inc(&shirq->active);
> > +	xnarch_memory_barrier();
> >  #endif
> >  }
> >  
> >  static inline void xnintr_shirq_unlock(xnintr_shirq_t *shirq)
> >  {
> >  #ifdef CONFIG_SMP
> > +	xnarch_memory_barrier();
> >  	xnarch_atomic_dec(&shirq->active);
> >  #endif
> >  }
> 
> As Dmitry and I are still a bit undecided about who to evolve such RCU
> locks best but still face this SMP bug in the current code, we are
> suggesting now to merge the patch above as-is for 2.3 - before things
> get lost for the release.

Ack. It's in my patch queue. Given the changes, the risk for regression
is zero and the situation could only improve with those, so this is
going to be applied last.

> 
> Jan
> 
> _______________________________________________
> Xenomai-core mailing list
> Xenomai-core@domain.hid
> https://mail.gna.org/listinfo/xenomai-core
-- 
Philippe.



