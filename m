From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <450A6566.1070200@domain.hid>
References: <58168.129.217.4.64.1158067468.squirrel@domain.hid>
	<1158091876.5020.8.camel@domain.hid>
	<b647ffbd0609121358v5b5bff80o6e4e08c859eb110a@domain.hid>
	<450727D1.6060203@domain.hid> <4507C49A.5070909@domain.hid>
	<b647ffbd0609140055t328fec1fi3b5d86da178d790e@domain.hid>
	<1158223595.5040.16.camel@domain.hid>
	<b647ffbd0609141512t47b1835em49c9873985aa5fb3@domain.hid>
	<1158308512.5009.35.camel@domain.hid>  <450A6566.1070200@domain.hid>
Content-Type: text/plain
Date: Fri, 15 Sep 2006 11:09:26 +0200
Message-Id: <1158311366.5009.51.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-core] Re: [Xenomai-help] Bad EIP kernel-Oops
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

On Fri, 2006-09-15 at 10:33 +0200, Jan Kiszka wrote:
> Philippe Gerum wrote:
> > diff -uNrp 2.6.17-ipipe-1.3-10/kernel/ipipe/core.c 2.6.17-ipipe/kernel/ipipe/core.c
> > --- 2.6.17-ipipe-1.3-10/kernel/ipipe/core.c	2006-09-15 10:13:15.000000000 +0200
> > +++ 2.6.17-ipipe/kernel/ipipe/core.c	2006-09-14 20:09:22.000000000 +0200
> > ...
> > @@ -638,6 +642,7 @@ int ipipe_control_irq(unsigned irq, unsi
> >  int fastcall __ipipe_dispatch_event (unsigned event, void *data)
> >  {
> >  	struct ipipe_domain *start_domain, *this_domain, *next_domain;
> > +	ipipe_event_handler_t evhand;
> >  	struct list_head *pos, *npos;
> >  	unsigned long flags;
> >  	ipipe_declare_cpuid;
> > @@ -649,8 +654,6 @@ int fastcall __ipipe_dispatch_event (uns
> >  
> >  	list_for_each_safe(pos,npos,&__ipipe_pipeline) {
> >  
> > -		next_domain = list_entry(pos,struct ipipe_domain,p_link);
> > -
> >  		/*
> >  		 * Note: Domain migration may occur while running
> >  		 * event or interrupt handlers, in which case the
> > @@ -659,11 +662,22 @@ int fastcall __ipipe_dispatch_event (uns
> >  		 * care for that, always tracking the current domain
> >  		 * descriptor upon return from those handlers.
> >  		 */
> > -		if (next_domain->evhand[event] != NULL)	{
> > +		next_domain = list_entry(pos,struct ipipe_domain,p_link);
> > +
> > +		/*
> > +		 * Keep a cached copy of the handler's address since
> > +		 * ipipe_catch_event() may clear it under our feet.
> > +		 */
> > +
> > +		evhand = next_domain->evhand[event];
> > +
> > +		if (evhand != NULL) {
> >  			ipipe_percpu_domain[cpuid] = next_domain;
> > +			next_domain->cpudata[cpuid].evsync |= (1LL << event);
> 
> Isn't there still a race window between grabbing evhand and setting this
> bit here? If yes, can this be solved by moving set/clear flag out of the
> condition?
> 

ipipe_catch_event() that changes the handler's address must hold the
critical lock to do so, and since we are running with masked IRQs in the
code above, we prevent the lock from being be obtained (i.e. through the
critical IPI) for the current CPU, so this is ok.

> If this is not the solution, I wonder if we should really care that
> much. Unregistering an event handler remains a rarely used scenario
> which actually never happens with the nucleus built in. Shouldn't we
> better put some grace period after it and live with the fact that on a
> *very busy* system it *may* cause troubles once in a while? Reminds me
> of the fact that procfs handler unregistration with private data
> attached is also racy by design...
> 

I agree, this is a corner case which is extremely unlikely to happen in
production systems, since we would likely never unplug the nucleus in
the first place. Still, I think that if we can fix this issue with
minimum overhead, it should be done. So far, the cost involved is
changing a 64bit value twice in the event dispatcher, and once in the
domain switch code. I'd prefer to limit this to 32bit values, but
unfortunately can't yet, until some of the x86-specific exceptions are
grouped under a single event code, so that we don't need more than 32
event bits to flag them.

> Jan
> 
-- 
Philippe.



