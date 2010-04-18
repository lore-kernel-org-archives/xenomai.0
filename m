From: Jan Kiszka <Jan Kiszka jan.kiszka@domain.hid>
Date: Sun, 18 Apr 2010 15:12:43 +0200
Message-Id: <07312436719f07689d0cd0f83c72ce7a520b9348.1271596367.git.Jan
	Kiszka jan.kiszka@domain.hid>
In-Reply-To: <cover.1271596366.git.Jan Kiszka jan.kiszka@domain.hid>
References: <cover.1271596366.git.Jan Kiszka jan.kiszka@domain.hid>
In-Reply-To: <cover.1271596366.git.Jan Kiszka jan.kiszka@domain.hid>
References: <cover.1271596366.git.Jan Kiszka jan.kiszka@domain.hid>
Sender: jan.kiszka@domain.hid
Subject: [Xenomai-core] [PATCH v3 19/24] RTIPC: Drop unused wrapper around
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
Cc: Jan Kiszka <jan.kiszka@domain.hid>, xenomai-core <xenomai@xenomai.org>

From: Jan Kiszka <jan.kiszka@domain.hid>

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


