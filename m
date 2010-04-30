From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <4BDADC13.2070500@domain.hid>
References: <4BDADC13.2070500@domain.hid>
Content-Type: text/plain; charset="UTF-8"
Date: Fri, 30 Apr 2010 22:13:22 +0200
Message-ID: <1272658402.24705.108.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] [RFC] Fix excessive host tick latencies
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: xenomai-core <xenomai@xenomai.org>

On Fri, 2010-04-30 at 15:33 +0200, Jan Kiszka wrote:
> Hi Philippe,
> 
> I'm not 100% sure if this plugs all remaining wholes in the deferred
> host tick processing, but at least the most easiest reproducible one is
> cured now for me (Linux latency peak after termination of 'latency').
> Please let me know if you see more potential issues, otherwise I would
> include this in my for-upstream queue.

That patch is correct, please queue it. Anything that breaks the
assumption described in the following comment from
xntimer_next_local_shot() is wrong wrt tick deferral: "The host tick
deferral is cleared whenever Xenomai is about to yield control to the
host kernel".

In short, when the code will match the comments and documentation, we
will be done with debugging.

> 
> Found while instrumenting the timer core to find RT timer latencies.
> Hope they become visible now...
> 
> Jan
> 
> -------
> 
> If a reschedule is pending, we won't allow the host timer to decide
> about the next hardware tick. But if that next reschedule will simply
> keep ROOT (which, e.g., happens during thread deletion), this deferral
> can impose significant unwanted timer latencies on Linux.
> 
> diff --git a/ksrc/nucleus/pod.c b/ksrc/nucleus/pod.c
> index 3ffd548..fb63f35 100644
> --- a/ksrc/nucleus/pod.c
> +++ b/ksrc/nucleus/pod.c
> @@ -2184,9 +2184,16 @@ void __xnpod_schedule(struct xnsched *sched)
>  	zombie = xnthread_test_state(curr, XNZOMBIE);
>  
>  	next = xnsched_pick_next(sched);
> -	if (next == curr && !xnthread_test_state(curr, XNRESTART))
> +	if (next == curr && !xnthread_test_state(curr, XNRESTART)) {
>  		/* Note: the root thread never restarts. */
> +		if (unlikely(xnthread_test_state(next, XNROOT))) {
> +			if (testbits(sched->status, XNHTICK))
> +				xnintr_host_tick(sched);
> +			if (testbits(sched->status, XNHDEFER))
> +				xntimer_next_local_shot(sched);
> +		}
>  		goto signal_unlock_and_exit;
> +	}
>  
>  	XENO_BUGON(NUCLEUS, need_resched == 0);
>  
> 


-- 
Philippe.



