Message-ID: <53B981B8.5070901@xenomai.org>
Date: Sun, 06 Jul 2014 19:04:56 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <1404640109.73994.YahooMailNeo@web171603.mail.ir2.yahoo.com>
In-Reply-To: <1404640109.73994.YahooMailNeo@web171603.mail.ir2.yahoo.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] issue with cobalt/timer: avoid periodic timer drift
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Matthias Schneider <ma30002000@yahoo.de>, "xenomai@xenomai.org" <xenomai@xenomai.org>

On 07/06/2014 11:48 AM, Matthias Schneider wrote:
> Hi all,
> 
> commit 
> 
> 2014-06-02 c20fceb147e337e2379b29ecd81b943318c7fbc7 
> (patch) cobalt/timer: avoid periodic timer drift
> 
> seems to cause an endless kernel loop in one of my
> freertos demos. The issue does not occur when 
> reverting this commit.
> 
> Investigating the issue, can see the following:
> 
> #0  0xc00ba45c in mach_arm_nodiv_llimd (rhs_integ=<optimized out>, frac=<optimized out>, op=<optimized out>)
>     at arch/arm/xenomai/include/asm/xenomai/uapi/arith.h:120
> #1  xnclock_core_ns_to_ticks (ns=0) at kernel/xenomai/clock.c:52
> #2  0xc00baf34 in xnclock_ns_to_ticks (clock=<optimized out>, ns=<optimized out>)
>     at include/xenomai/cobalt/kernel/clock.h:204
> #3  xntimer_update_date (timer=0xde706518) at include/xenomai/cobalt/kernel/timer.h:268
> #4  xnclock_tick (clock=0xc06b1138 <nkclock>) at kernel/xenomai/clock.c:644
> #5  0xc00bcbcc in xnintr_core_clock_handler () at kernel/xenomai/intr.c:121
> #6  0xc0095a98 in dispatch_irq_head (irq=<optimized out>) at kernel/ipipe/core.c:1179
> 
> This seems to be the endless loop:
> 642                     do {
> 643      timer->periodic_ticks += interval_ticks;
> 644      xntimer_update_date(timer);
> 645                     } while (xntimerh_date(&timer->aplink) < now + clock->gravity);


I do not really understand how interval_ticks can be 0, but please try 
the following patch:

diff --git a/kernel/cobalt/clock.c b/kernel/cobalt/clock.c
index a578f89..1107f7a 100644
--- a/kernel/cobalt/clock.c
+++ b/kernel/cobalt/clock.c
@@ -619,10 +619,9 @@ void xnclock_tick(struct xnclock *clock)
 			 * wait for 250 ms for the user to continue
 			 * program execution.
 			 */
-			if (timer->interval_ns > 250000000)
-				goto advance;
-			interval_ticks = 250000000 /
-				(unsigned)timer->interval_ns;
+			xntimerh_date(&timer->aplink) +=
+				xnclock_ns_to_ticks(xntimer_clock(timer),
+						250000000);
 			goto requeue;
 		}
 	fire:
@@ -638,11 +637,11 @@ void xnclock_tick(struct xnclock *clock)
 			continue;
 	advance:
 		interval_ticks = 1;
-	requeue:
 		do {
 			timer->periodic_ticks += interval_ticks;
 			xntimer_update_date(timer);
 		} while (xntimerh_date(&timer->aplink) < now + clock->gravity);
+	requeue:
 #ifdef CONFIG_SMP
 		/*
 		 * Make sure to pick the right percpu queue, in case



-- 
                                                                Gilles.

