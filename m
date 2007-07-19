From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <469F1138.3050705@domain.hid>
References: <469F1138.3050705@domain.hid>
Content-Type: text/plain
Date: Thu, 19 Jul 2007 11:05:21 +0200
Message-Id: <1184835921.28303.16.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: Philippe Gerum <philippe.gerum@domain.hid>
Subject: Re: [Xenomai-core] [PATCH] fix regression around one-shot host tick
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

On Thu, 2007-07-19 at 09:22 +0200, Jan Kiszka wrote:
> Philippe,
> 
> this bug was introduced with recent clock_event modifications:
> 
> --- ksrc/nucleus/timer.c	(Revision 2766)
> +++ ksrc/nucleus/timer.c	(Arbeitskopie)
> @@ -245,7 +245,7 @@ void xntimer_tick_aperiodic(void)
>  			   translates into precious microsecs on low-end hw. */
>  			__setbits(sched->status, XNHTICK);
>  			if (!testbits(timer->status, XNTIMER_PERIODIC))
> -				goto out;
> +				continue;
>  		}
>  
>  		do {
> @@ -254,7 +254,6 @@ void xntimer_tick_aperiodic(void)
>  		xntimer_enqueue_aperiodic(timer);
>  	}
>  
> -out:
>  	__clrbits(sched->status, XNINTCK);
>  
>  	xntimer_next_local_shot(sched);
> 
> 
> It doesn't look like typo, so what was your original intention?

The host timer is no more a purely periodic beast. Since it may be
aperiodic, we ought to get away from the interval update loop, otherwise
we'd remain stuck into it in the aperiodic case.

> The current code at least fails to handle outstanding timers that are enqueued right behind a one-shot host-tick timer.
> 

True, I've been slightly, mmm, radical here. Will merge.

> Jan
> 
-- 
Philippe.



