Subject: Re: [Xenomai-core] official TSC model on SMP
From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <1158702410.4972.131.camel@domain.hid>
References: <450D3764.80601@domain.hid> <1158513328.4979.45.camel@domain.hid>
	<17677.34698.949600.873431@domain.hid>
	<1158702410.4972.131.camel@domain.hid>
Content-Type: text/plain
Date: Wed, 20 Sep 2006 10:17:47 +0200
Message-Id: <1158740267.5544.31.camel@domain.hid>
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
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: Jan Kiszka <jan.kiszka@domain.hid>, xenomai-core <xenomai@xenomai.org>

On Tue, 2006-09-19 at 23:46 +0200, Philippe Gerum wrote:
> On Sun, 2006-09-17 at 19:36 +0200, Gilles Chanteperdrix wrote:
> > Philippe Gerum wrote:
> >  > On Sun, 2006-09-17 at 13:54 +0200, Jan Kiszka wrote:
> >  > > Hi,
> >  > > 
> >  > > reading through timer code of Xenomai I just wondered (again) what our
> >  > > official model of TSCs on multiprocessor boxes are:
> >  > > 
> >  > > 1) (practically) perfectly synchronised without offset
> >  > > 
> >  > > 2) synchronised but with (unknown?) offset
> >  > > 
> >  > > 3) unsynchronised
> >  > 
> >  > The current model is unsynchronized. If anything from the codebase is
> >  > found relying on the opposite, be it partially or fully, then it's
> >  > utterly broken in the SMP case, and I'm likely the one to blame.
> >  > IOW, we don't currently provide any guarantee to anyone that a timestamp
> >  > could be interpreted anywhere else than the CPU it was read from, and
> >  > leave all the related burden to the application developer (e.g. by mean
> >  > of managing CPU affinity constraints and the like).
> > 
> > I think xntimer_set_sched assumes some continuity, since it reenqueues
> > on a different CPU a timer whose date has been set up on one cpu. If we
> > wanted strict unsynchronized tsc, we would have to :
> > - compute the difference between the current date and the timer date
> > - enqueue the timer on a migration queue
> > - send an IPI to the distant CPU
> > - on the distant CPU, iterate over the migration queue, recompute the
> >   expiration dates and reenqueue the timers.
> > 
> 
> Looking at the code, xntimer_set_sched is used in the following
> contexts:
> 
> o setting a CPU affinity for timers just before they get started. They
> might be active already but in such a case, we could simply disarm them
> before migration since they are going to be started anew right after,
> which would solve the issue. AFAIC, this is the most common case.
> 
> o changing a CPU affinity for a possibly running (periodic internal)
> timer, without restarting it (i.e. xnpod_migrate_thread). This happens
> once.
> 
> So, basically, the issue is about allowing threads that run a periodic
> timer to migrate on the fly, without breaking their ongoing
> timeline, ... or not. (And all of the above only applies to the oneshot
> system timing, since the periodic jiffy counter is global by nature, and
> would never suffer any discontinuity).
> 

To elaborate a bit more on this, and considering that only stopped
timers are migrated, we would indeed need a timer migration queue on the
remote CPU, but we might assume that the date field of the linked timers
would convey the original date, and not the TSC converted one or delay
from such, and we could safely assume that such timers would not be
indexed by any data structures that usually hold the outstanding timers.
Simply reusing the sched IPI for kicking the remote CPU to fire up the
migrated timers would even be an option.

-- 
Philippe.



