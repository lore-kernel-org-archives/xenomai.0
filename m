From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <46AF79F7.7080908@domain.hid>
References: <46AF79F7.7080908@domain.hid>
Content-Type: text/plain
Date: Tue, 31 Jul 2007 20:29:26 +0200
Message-Id: <1185906566.6611.255.camel@domain.hid>
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

On Tue, 2007-07-31 at 20:05 +0200, Jan Kiszka wrote:
> Oh my dear. The ground may open and swallow me. This crappy piece of
> optimisation in xnintr_edge_shirq_handler() I introduced both to 2.4 and
> (sadly) the 2.3.x stable series cannot work. It must stay as it used to:
> 
> --- ksrc/nucleus/intr.c	(revision 2871)
> +++ ksrc/nucleus/intr.c	(working copy)
> @@ -296,15 +296,15 @@ static void xnintr_edge_shirq_handler(un
>  		s |= ret;
> 
>  		if (code == XN_ISR_HANDLED) {
> -			if (!(end = (intr->next)))
> -				end = shirq->handlers;
> +			end = NULL;
>  			xnstat_counter_inc(
>  				&intr->stat[xnsched_cpu(sched)].hits);
>  			xnstat_runtime_lazy_switch(sched,
>  				&intr->stat[xnsched_cpu(sched)].account,
>  				start);
>  			start = xnstat_runtime_now();
> -		}
> +		} else if (code == XN_ISR_NONE && end == NULL)
> +			end = intr;
> 
>  		if (counter++ > MAX_EDGEIRQ_COUNTER)
>  			break;
> (that's for 2.3.x)
> 
> Once "end" is moved forward to the next handler in the chain, the loop
> termination condition "intr==end" will trigger on the immediately
> following round, even if there are still events pending. Utterly broken.
> 
> Philippe, please quickly apply -- and don't tell anyone who did this.
> 

No problem. Nobody will know, outside of the Internet, that is.

> Jan
> 
-- 
Philippe.



