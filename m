From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <46A736CB.1080502@domain.hid>
References: <16123805.1184916759093.JavaMail.ngmail@domain.hid>
	<1184890451.28303.356.camel@domain.hid>
	<1184852543.28303.67.camel@domain.hid>
	<24703926.1184851660664.JavaMail.ngmail@domain.hid>
	<32098568.1184853156077.JavaMail.ngmail@domain.hid>
	<25782679.1184932464850.JavaMail.ngmail@domain.hid>
	<1184933771.5998.3.camel@domain.hid> <1185202908.5998.271.camel@domain.hid>
	<46A736CB.1080502@domain.hid>
Content-Type: text/plain
Date: Wed, 25 Jul 2007 16:58:30 +0200
Message-Id: <1185375510.5998.379.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: Philippe Gerum <philippe.gerum@domain.hid>
Subject: Re: [Xenomai-core] RPI is good for you
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
Cc: "M. Koehrer" <mathias_koehrer@domain.hid>, xenomai@xenomai.org

On Wed, 2007-07-25 at 13:40 +0200, Jan Kiszka wrote:
> Philippe Gerum schrieb:
> > On Fri, 2007-07-20 at 14:16 +0200, Philippe Gerum wrote: 
> > 
> > Now, regarding the deadlock issue, suppressing the RPI-specific locking
> > entirely would have been the best solution, but unfortunately, the
> > migration scheme makes this out of reach, at least without resorting to
> > some hairy and likely unreliable implementation. Therefore, the solution
> > I came with consists of making the RPI lock a per-cpu thing, so that
> > most RPI routines are actually grabbing a _local_ lock wrt the current
> > CPU, those routines being allowed hold the nklock as they wish. When
> > some per-CPU RPI lock is accessed from a remote CPU, it is guaranteed
> > that _no nklock_ may be held nested. Actually, the remote case only
> > occurs once, in rpi_clear_remote(), and all its callers are guaranteed
> > to be nklock-free (a debug assertion even enforces that).
> 
> Yeah, it is actually safe against deadlocks now. Still, I wonder why we 
> can't design xnshadow_rpi_check like this:
> 
> 	...
> 	int need_renice = 0;
> 
> 	xnlock_get_irqsave(&rpislot->lock, s);
> 
> 	if (sched_emptypq_p(&rpislot->threadq) &&
> 	    xnpod_root_priority() != XNCORE_IDLE_PRIO)
> 		need_renice = 1;
> 
> 	xnlock_put_irqrestore(&rpislot->lock, s);
> 
> 	if (need_renice)
> 		xnpod_renice_root(XNCORE_IDLE_PRIO);
> 
> 
> If we can avoid nesting (even if it's safe), we should do so. Or does 
> this pattern here introduce new, ugly race possibility?

Yeah, this would work, because what we need actually is that
xnshadow_rpi_check() runs with local interrupts off, which is the case
since it is called on behalf of an IPI with hardware interrupts
disabled. Otherwise, we would open a short window for this kind of
scenario:

xnshadow_rpi_check
	empty-p(RPI list)?
		<IRQ> switch to some primary mode thread
			primary mode thread relaxes
				push other thread to RPI list
	(spuriously) downgrade root thread priority

This said, we have no interest ATM to let hw interrupts flow when
handling this IPI, so we could indeed flatten the locking sequence as
you described, provided we also put some big fat warning into that piece
of code too.

-- 
Philippe.



