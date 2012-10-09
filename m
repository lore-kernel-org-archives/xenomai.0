Message-ID: <50749C71.2020100@xenomai.org>
Date: Tue, 09 Oct 2012 23:51:45 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <505EB99F.7050705@wanadoo.fr>	<505EBD61.1050009@wanadoo.fr>	<505F0D40.9030105@xenomai.org>	<50741C5B.4060206@wanadoo.fr>
	<5074986C.8000509@xenomai.org> <50749A03.9090607@xenomai.org>
In-Reply-To: <50749A03.9090607@xenomai.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Target frozen with rtcan_virt
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Thierry Bultel <thierry.bultel@wanadoo.fr>
Cc: xenomai@xenomai.org

On 10/09/2012 11:41 PM, Gilles Chanteperdrix wrote:

> Another possible fix would be to lock xenomai scheduler when taking an
> rtdm_spin_lock, as it is almost always wrong to call xnpod_schedule in
> such a situation. It works for other RT-CAN drivers, because they call
> rtdm_sem_up from interrupt context where the scheduler is locked by the
> XNINIRQ bit.
> 


IOW, something like:

diff --git a/include/rtdm/rtdm_driver.h b/include/rtdm/rtdm_driver.h
index 68135e4..7b18c34 100644
--- a/include/rtdm/rtdm_driver.h
+++ b/include/rtdm/rtdm_driver.h
@@ -730,6 +730,7 @@ typedef unsigned long rtdm_lockctx_t;
 	do {							\
 		XENO_BUGON(RTDM, !rthal_local_irq_disabled());	\
 		rthal_spin_lock(lock);				\
+		xnpod_lock_sched();				\
 	} while (0)
 #endif
 
@@ -749,7 +750,11 @@ typedef unsigned long rtdm_lockctx_t;
  *
  * Rescheduling: never.
  */
-#define rtdm_lock_put(lock)	rthal_spin_unlock(lock)
+#define rtdm_lock_put(lock)					\
+	do {							\
+		rthal_spin_unlock(lock);			\
+		xnpod_unlock_sched();				\
+	} while (0)
 
 /**
  * Acquire lock and disable preemption
@@ -768,8 +773,11 @@ typedef unsigned long rtdm_lockctx_t;
  *
  * Rescheduling: never.
  */
-#define rtdm_lock_get_irqsave(lock, context)	\
-	rthal_spin_lock_irqsave(lock, context)
+#define rtdm_lock_get_irqsave(lock, context)				\
+	do {								\
+		rthal_spin_lock_irqsave(lock, context);			\
+		xnpod_lock_sched();					\
+	} while (0)
 
 /**
  * Release lock and restore preemption state
@@ -788,8 +796,12 @@ typedef unsigned long rtdm_lockctx_t;
  *
  * Rescheduling: possible.
  */
-#define rtdm_lock_put_irqrestore(lock, context)	\
-	rthal_spin_unlock_irqrestore(lock, context)
+#define rtdm_lock_put_irqrestore(lock, context)			\
+	do {							\
+		rthal_spin_unlock(lock);			\
+		xnpod_unlock_sched();				\
+		rthal_local_irq_restore(context);		\
+	} while (0)
 
 /**
  * Disable preemption locally



-- 
                                                                Gilles.

