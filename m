Subject: Re: [Xenomai-core] [bug] broken PI-chain
From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <1156530834.4338.42.camel@domain.hid>
References: <44EF2BA6.9040601@domain.hid>  <1156530834.4338.42.camel@domain.hid>
Content-Type: text/plain
Date: Fri, 25 Aug 2006 22:11:22 +0200
Message-Id: <1156536683.4338.45.camel@domain.hid>
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

On Fri, 2006-08-25 at 20:33 +0200, Philippe Gerum wrote:
> On Fri, 2006-08-25 at 18:56 +0200, Jan Kiszka wrote:
> > Hi,
> > 
> > the following (academic?) scenario is not handled as expected by the
> > nucleus:
> > 
> >  Prio	^
> > 	|                  -- T2
> > 	|                 /
> > 	|  T0 <----- T1 <- M1
> > 	| (M0)  M0  (M1)
> > 	+------------------------
> > 
> > That means: Task T0 at, e.g., prio 1 holds mutex M0. T1, also at prio 1,
> > happens to interrupt T0 (round-robin?). T1 already holds M1 and now
> > tries to acquire M0. As both are at the same prio level, no boosting
> > takes place, all fine. Then T2 comes in play. It's at prio 2 and tries
> > to gain access to M1. T1 gets therefore boosted to prio 2 as well, but
> > T0 will stay at prio 1 under Xenomai.
> > 
> 
> Ok, confirmed. The way the PI chain is handled is very academically
> broken.
> 
> > I hacked this scenario in the attached demo. Set MAX to 2 to let it
> > work, leave it 3 and it breaks.
> 
> Ouch. It does indeed...
> 
> > 
> > The problem looks on first sight like this test [1]: the claiming
> > relation is only establish if there is a priority delta on entry, but
> > that breaks when the claiming thread's prio changes later. Can we simply
> > remove this test?
> 
> It seems that there is even more than this, and I'm wondering now if
> something fishy is not happening with the CLAIMED bit handling too, when
> an attempt is made to clear the priority boost.
> http://www.rts.uni-hannover.de/xenomai/lxr/source/ksrc/nucleus/synch.c?v=SVN-trunk#L265
> 

This one is a false alarm, due to outdated simulation libraries. But the
PIP chain issue still needs a fix.

> I've slightly adapted your test code so that my friend the simulator
> helps us, and a segfault is raised upon exit of task_func(), which goes
> south, likely trying to flush the pend queue of some synch object it
> should not still be waiting for.
> 
> FWIW, I've attached the code and the Makefile adapted to the simulator.
> 
> _______________________________________________
> Xenomai-core mailing list
> Xenomai-core@domain.hid
> https://mail.gna.org/listinfo/xenomai-core
-- 
Philippe.



