From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <46AF7CB0.1040205@domain.hid>
References: <46AF79F7.7080908@domain.hid>  <46AF7CB0.1040205@domain.hid>
Content-Type: text/plain
Date: Tue, 31 Jul 2007 20:29:39 +0200
Message-Id: <1185906579.6611.257.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: Philippe Gerum <philippe.gerum@domain.hid>
Subject: Re: [Xenomai-core] [PATCH] Revert broken edge_shirq optimisation
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

On Tue, 2007-07-31 at 20:17 +0200, Jan Kiszka wrote:
> Jan Kiszka wrote:
> > Oh my dear. The ground may open and swallow me. This crappy piece of
> > optimisation in xnintr_edge_shirq_handler() I introduced both to 2.4 and
> > (sadly) the 2.3.x stable series cannot work. It must stay as it used to:
> > 
> > --- ksrc/nucleus/intr.c	(revision 2871)
> > +++ ksrc/nucleus/intr.c	(working copy)
> > @@ -296,15 +296,15 @@ static void xnintr_edge_shirq_handler(un
> >  		s |= ret;
> > 
> >  		if (code == XN_ISR_HANDLED) {
> > -			if (!(end = (intr->next)))
> > -				end = shirq->handlers;
> > +			end = NULL;
> >  			xnstat_counter_inc(
> >  				&intr->stat[xnsched_cpu(sched)].hits);
> >  			xnstat_runtime_lazy_switch(sched,
> >  				&intr->stat[xnsched_cpu(sched)].account,
> >  				start);
> >  			start = xnstat_runtime_now();
> > -		}
> > +		} else if (code == XN_ISR_NONE && end == NULL)
> > +			end = intr;
> > 
> >  		if (counter++ > MAX_EDGEIRQ_COUNTER)
> >  			break;
> > (that's for 2.3.x)
> 
> For 2.4, one may consider to assume now that "code != XN_ISR_HANDLE =>
> code == XN_ISR_NONE":
> 

Merged, thanks.

> --- ksrc/nucleus/intr.c	(revision 2871)
> +++ ksrc/nucleus/intr.c	(working copy)
> @@ -251,15 +251,15 @@ static void xnintr_edge_shirq_handler(un
>  		s |= ret;
> 
>  		if (code == XN_ISR_HANDLED) {
> -			if (!(end = (intr->next)))
> -				end = shirq->handlers;
> +			end = NULL;
>  			xnstat_counter_inc(
>  				&intr->stat[xnsched_cpu(sched)].hits);
>  			xnstat_exectime_lazy_switch(sched,
>  				&intr->stat[xnsched_cpu(sched)].account,
>  				start);
>  			start = xnstat_exectime_now();
> -		}
> +		} else if (end == NULL)
> +			end = intr;
> 
>  		if (counter++ > MAX_EDGEIRQ_COUNTER)
>  			break;
> 
> Jan
> 
-- 
Philippe.



