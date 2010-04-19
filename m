From: Jan Kiszka <jan.kiszka@domain.hid>
Date: Mon, 19 Apr 2010 12:28:59 +0200
Message-Id: <29980fb30145a50799e96a0549e08b2580babfde.1271672940.git.jan.kiszka@domain.hid>
In-Reply-To: <cover.1271672940.git.jan.kiszka@domain.hid>
References: <cover.1271672940.git.jan.kiszka@domain.hid>
In-Reply-To: <cover.1271672940.git.jan.kiszka@domain.hid>
References: <cover.1271672940.git.jan.kiszka@domain.hid>
Subject: [Xenomai-core] [PATCH v4 19/25] RTIPC: Drop unused wrapper around
	close_lock_count
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

CC: Philippe Gerum <rpm@xenomai.org>
Signed-off-by: Jan Kiszka <jan.kiszka@domain.hid>
---
 ksrc/drivers/ipc/internal.h |    5 -----
 1 files changed, 0 insertions(+), 5 deletions(-)

diff --git a/ksrc/drivers/ipc/internal.h b/ksrc/drivers/ipc/internal.h
index 296a988..ed8c103 100644
--- a/ksrc/drivers/ipc/internal.h
+++ b/ksrc/drivers/ipc/internal.h
@@ -127,9 +127,4 @@ extern struct xnptree rtipc_ptree;
 #define rtipc_enter_atomic(lockctx)	xnlock_get_irqsave(&nklock, (lockctx))
 #define rtipc_leave_atomic(lockctx)	xnlock_put_irqrestore(&nklock, (lockctx))
 
-static inline int rtipc_socket_locked(struct rtdm_dev_context *context)
-{
-	return atomic_read(&context->close_lock_count);
-}
-
 #endif /* !_RTIPC_INTERNAL_H */
-- 
1.6.0.2


