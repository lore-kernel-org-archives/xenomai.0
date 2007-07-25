From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <13759439.1185346487868.JavaMail.ngmail@domain.hid>
References: <30117851.1185278735407.JavaMail.ngmail@domain.hid>
	<1185202908.5998.271.camel@domain.hid>
	<16123805.1184916759093.JavaMail.ngmail@domain.hid>
	<1184890451.28303.356.camel@domain.hid>
	<1184852543.28303.67.camel@domain.hid>
	<24703926.1184851660664.JavaMail.ngmail@domain.hid>
	<32098568.1184853156077.JavaMail.ngmail@domain.hid>
	<25782679.1184932464850.JavaMail.ngmail@domain.hid>
	<1184933771.5998.3.camel@domain.hid>
	<13759439.1185346487868.JavaMail.ngmail@domain.hid>
Content-Type: text/plain
Date: Wed, 25 Jul 2007 09:06:03 +0200
Message-Id: <1185347163.5998.357.camel@domain.hid>
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
To: "M. Koehrer" <mathias_koehrer@domain.hid>
Cc: jan.kiszka@domain.hid, xenomai@xenomai.org

On Wed, 2007-07-25 at 08:54 +0200, M. Koehrer wrote:
> Hi Philippe,
> 
> as I have mentioned yesterday, I have applied your (first) patch to Xenomai (I did not apply 
> the other additional patches).

The third one would be needed to run the same code against the trunk,
due to some difference in CPU affinity management between v2.3.x and
-devel, but I had no problem running the lockup test for six hours
without it over v2.3.x.

>  And yes, my application was running fine without freeze in an
> overnight test. Not only the tiny test application but also the complex real time application that
> was the root cause for everything.
> That is really a great improvement. Will this fix end up shortly in a maintenance version of Xenomai?
> I would appreciate that as this is a severe bug that should have a fix published as soon as possible.
> 

Yes, it is already merged into the maintenance and -devel branch, and
v2.3.3 will be released shortly, since this is indeed a deadly bug.

> Thanks a lot for the excellent support!
> 

No problem. The lockup test you sent did make a huge difference and
actually allowed me to focus on solving the issue immediately, instead
of trying to find a way to reproduce it first. Thanks for this.

> Regards
> 
> Mathias
> 
> > Hi Philippe,
> > 
> > I have attached this patch to my application. So far it looks really good.
> > However, I leave my test running to be sure that it works.
> > 
> > Regards
> > 
> > Mathias 
> > 
> > 
> > > On Fri, 2007-07-20 at 14:16 +0200, Philippe Gerum wrote: 
> > > > On Fri, 2007-07-20 at 13:54 +0200, M. Koehrer wrote:
> > > > > Hi Philippe,
> > > > > I left my test running for a couple of hours - no freeze so far... 
> > > > > 
> > > > > However, I have to do some other stuff on this machine, I have to
> > stop
> > > the test now...
> > > > > 
> > > > 
> > > > Ok, thanks for the feedback. I will send an extended patch later today,
> > > > so that you could test it on a longer period when you see fit.
> > > 
> > > It took me a bit longer than expected, but here is a patch which
> > > addresses all the pending issues with RPI, hopefully (applies against
> > > 2.3.1 stock).
> > > 
> > > The good thing about Jan grumbling at me, is that this usually makes me
> > > look at the big picture anew. And the RPI picture was not that nice,
> > > that's a fact.
> > > 
> > > Beside the locking sequence issue, the ex-aequo #1 problem was that CPU
> > > migration of Linux tasks causing a RPI boost had some very nasty
> > > side-effects on RPI management, and would create all sort of funky
> > > situations I'm too shameful to talk about, except under the generic term
> > > of "horrendous mess".
> > > 
> > > Now, regarding the deadlock issue, suppressing the RPI-specific locking
> > > entirely would have been the best solution, but unfortunately, the
> > > migration scheme makes this out of reach, at least without resorting to
> > > some hairy and likely unreliable implementation. Therefore, the solution
> > > I came with consists of making the RPI lock a per-cpu thing, so that
> > > most RPI routines are actually grabbing a _local_ lock wrt the current
> > > CPU, those routines being allowed hold the nklock as they wish. When
> > > some per-CPU RPI lock is accessed from a remote CPU, it is guaranteed
> > > that _no nklock_ may be held nested. Actually, the remote case only
> > > occurs once, in rpi_clear_remote(), and all its callers are guaranteed
> > > to be nklock-free (a debug assertion even enforces that).
> > > 
> > > For the migration issue, the RPI transitions have been ironed out to
> > > make sure we deal properly with all the subtleties of the Linux load
> > > balancer.
> > > 
> > > Mathias, please let me know if the attached patch improves the situation
> > > on your side.
> > > 
> 
> 
> 
-- 
Philippe.



