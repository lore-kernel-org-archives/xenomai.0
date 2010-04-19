From: Jan Kiszka <jan.kiszka@domain.hid>
Date: Mon, 19 Apr 2010 12:28:51 +0200
Message-Id: <b52d6a13471e15f4b8ad51f0aa57d9a090950dcf.1271672940.git.jan.kiszka@domain.hid>
In-Reply-To: <cover.1271672940.git.jan.kiszka@domain.hid>
References: <cover.1271672940.git.jan.kiszka@domain.hid>
In-Reply-To: <cover.1271672940.git.jan.kiszka@domain.hid>
References: <cover.1271672940.git.jan.kiszka@domain.hid>
Subject: [Xenomai-core] [PATCH v4 11/25] RTDM: Instrument
	rtdm_context_lock/unlock to detect misuses
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai-core <xenomai@xenomai.org>

rtdm_context_lock must only be called on context structures that are
already locked, and rtdm_context_unlock must be kept in balance with
rtdm_context_get/rtdm_context_lock. Try to check for mistakes by
requiring non-null clock_lock_count on entry of both services.

Also fix a typo and clarify the use cases and restrictions of
rtdm_context_lock.

CC: Philippe Gerum <rpm@xenomai.org>
Signed-off-by: Jan Kiszka <jan.kiszka@domain.hid>
---
 include/rtdm/rtdm_driver.h |    4 ++++
 ksrc/skins/rtdm/core.c     |   10 +++++++---
 2 files changed, 11 insertions(+), 3 deletions(-)

diff --git a/include/rtdm/rtdm_driver.h b/include/rtdm/rtdm_driver.h
index d68f542..3fc9071 100644
--- a/include/rtdm/rtdm_driver.h
+++ b/include/rtdm/rtdm_driver.h
@@ -555,11 +555,15 @@ struct rtdm_dev_context *rtdm_context_get(int fd);
 #ifndef DOXYGEN_CPP /* Avoid static inline tags for RTDM in doxygen */
 static inline void rtdm_context_lock(struct rtdm_dev_context *context)
 {
+	XENO_ASSERT(RTDM, atomic_read(&context->close_lock_count) > 0,
+		    /* just warn if context was a dangling pointer */);
 	atomic_inc(&context->close_lock_count);
 }
 
 static inline void rtdm_context_unlock(struct rtdm_dev_context *context)
 {
+	XENO_ASSERT(RTDM, atomic_read(&context->close_lock_count) > 0,
+		    /* just warn if context was a dangling pointer */);
 	smp_mb__before_atomic_dec();
 	atomic_dec(&context->close_lock_count);
 }
diff --git a/ksrc/skins/rtdm/core.c b/ksrc/skins/rtdm/core.c
index 8cccf52..ba4dc63 100644
--- a/ksrc/skins/rtdm/core.c
+++ b/ksrc/skins/rtdm/core.c
@@ -87,7 +87,7 @@ struct rtdm_dev_context *rtdm_context_get(int fd)
 		return NULL;
 	}
 
-	rtdm_context_lock(context);
+	atomic_inc(&context->close_lock_count);
 
 	xnlock_put_irqrestore(&rt_fildes_lock, s);
 
@@ -328,7 +328,7 @@ again:
 	}
 
 	set_bit(RTDM_CLOSING, &context->context_flags);
-	rtdm_context_lock(context);
+	atomic_inc(&context->close_lock_count);
 
 	xnlock_put_irqrestore(&rt_fildes_lock, s);
 
@@ -588,7 +588,11 @@ EXPORT_SYMBOL(rtdm_select_bind);
  * @param[in] context Device context
  *
  * @note rtdm_context_get() automatically increments the lock counter. You
- * only need to call this function in special scenrios.
+ * only need to call this function in special scenarios, e.g. when keeping
+ * additional references to the context structure that have different
+ * lifetimes. Only use rtdm_context_lock() on contexts that are currently
+ * locked via an earlier rtdm_context_get()/rtdm_contex_lock() or while
+ * running a device operation handler.
  *
  * Environments:
  *
-- 
1.6.0.2


