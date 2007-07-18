From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <18077.6356.94172.274545@domain.hid>
References: <18077.6356.94172.274545@domain.hid>
Content-Type: text/plain
Date: Wed, 18 Jul 2007 09:50:03 +0200
Message-Id: <1184745003.6562.39.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: Philippe Gerum <philippe.gerum@domain.hid>
Subject: Re: [Xenomai-core] [patch] fix
	ximulator	xnarch_program_next_timer_shot.
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
Cc: xenomai@xenomai.org

On Tue, 2007-07-17 at 21:30 +0200, Gilles Chanteperdrix wrote:
> Hi,
> 
> when xnarch_program_next_timer_shot is passed a null delay and there is
> no other timed event pending, the mvm terminates with the message:
> "nothing to schedule".
> 

Actually, this is a purely event-driven engine, so if we manage to raise
this condition, this basically means that there is nothing to do next
for the engine, and no mean to get busy afterwise, since only handling
some event may schedule another event in the engine's queue.
Chicken-and-egg issue.

> The attached patch fixes this, though I am not sure it is the best way
> to fix it.

Looks good.  The only thing that still bothers me is that, at some
point, it seems that we are triggering an immediate shot. Even if this
situation is clearly possible in the real environment, I find it a bit
suspicious in the simulated one. Maybe this is related to the timer
adjustement code that may raise such situation (which would explain it
then)?

> 
> plain text document attachment (xeno-sim-program-null-delay.diff)
> Index: include/asm-sim/bits/timer.h
> ===================================================================
> --- include/asm-sim/bits/timer.h	(revision 2765)
> +++ include/asm-sim/bits/timer.h	(working copy)
> @@ -22,7 +22,7 @@
>  static inline void xnarch_program_timer_shot (unsigned long delay)
>  {
>      /* 1 tsc unit of the virtual CPU == 1 ns. */
> -    mvm_program_timer(delay);
> +    mvm_program_timer(delay ?: 1);
>  }
>  
>  static inline int xnarch_send_timer_ipi (xnarch_cpumask_t mask)
> _______________________________________________
> Xenomai-core mailing list
> Xenomai-core@domain.hid
> https://mail.gna.org/listinfo/xenomai-core
-- 
Philippe.



