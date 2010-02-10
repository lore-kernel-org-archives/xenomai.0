Message-ID: <4B72ED6B.5010805@domain.hid>
Date: Wed, 10 Feb 2010 18:31:23 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <4B72DB97.1020203@domain.hid>
In-Reply-To: <4B72DB97.1020203@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] xnselect_destroy fails to wake up waiters
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

Jan Kiszka wrote:
> Hi Gilles,
> 
> I tend to think that xnselect_destroy should signal an event on the
> dying fd instead of just clearing the binding. The task blocking on
> select currently does not get a hint that the fd is dead and will block
> on select until some other event arrives. That's unfortunately not
> standard conforming.

Could you test the following patch? The fd will be in the "pending" set
until the fd is reused, but that should be harmless as long as the fd is
not in the "expected" set.

diff --git a/ksrc/nucleus/select.c b/ksrc/nucleus/select.c
index fd56bfb..17c5e0b 100644
--- a/ksrc/nucleus/select.c
+++ b/ksrc/nucleus/select.c
@@ -131,7 +131,8 @@ int xnselect_bind(struct xnselect *select_block,
 		__FD_SET(index, &selector->fds[type].pending);
 		if (xnselect_wakeup(selector))
 			xnpod_schedule();
-	}
+	} else
+		__FD_CLR(index, &selector->fds[type].pending);
 
 	return 0;
 }
@@ -178,6 +179,7 @@ EXPORT_SYMBOL_GPL(__xnselect_signal);
 void xnselect_destroy(struct xnselect *select_block)
 {
 	xnholder_t *holder;
+	int resched;
 	spl_t s;
 
 	xnlock_get_irqsave(&nklock, s);
@@ -190,11 +192,18 @@ void xnselect_destroy(struct xnselect *select_block)
 
 		__FD_CLR(binding->bit_index,
 			 &selector->fds[binding->type].expected);
-		__FD_CLR(binding->bit_index,
-			 &selector->fds[binding->type].pending);
+		if (!__FD_ISSET(binding->bit_index,
+				&selector->fds[binding->type].pending)) {
+			__FD_SET(binding->bit_index,
+				 &selector->fds[binding->type].pending);
+			if (xnselect_wakeup(selector))
+				resched = 1;
+		}
 		removeq(&selector->bindings, &binding->slink);
 		xnlock_put_irqrestore(&nklock, s);
 
+		if (resched)
+			xnpod_schedule();
 		xnfree(binding);
 		
 		xnlock_get_irqsave(&nklock, s);

-- 
					    Gilles.

