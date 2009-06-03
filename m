Resent-To: Philippe Gerum <rpm@xenomai.org>
Resent-Message-Id: <4A2681F5.9090207@domain.hid>
From: Jan Kiszka <jan.kiszka@domain.hid>
Date: Wed, 03 Jun 2009 15:59:14 +0200
Message-ID: <20090603135913.22120.80931.stgit@domain.hid>
In-Reply-To: <20090603135912.22120.29245.stgit@domain.hid>
References: <20090603135912.22120.29245.stgit@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-core] [PATCH v2 4/4] RTDM: Avoid namespace pollution
	in	RTDM_EXECUTE_ATOMICALLY
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Philippe Gerum <rpm@xenomai.org>
Cc: xenomai@xenomai.org

Signed-off-by: Jan Kiszka <jan.kiszka@domain.hid>
---

 include/rtdm/rtdm_driver.h |   14 +++++++-------
 1 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/include/rtdm/rtdm_driver.h b/include/rtdm/rtdm_driver.h
index 5fc8b57..7f1f3f8 100644
--- a/include/rtdm/rtdm_driver.h
+++ b/include/rtdm/rtdm_driver.h
@@ -595,13 +595,13 @@ int rtdm_select_bind(int fd, rtdm_selector_t *selector,
 	<LEAVE_ATOMIC_SECTION>			\
 }
 #else /* This is how it really works */
-#define RTDM_EXECUTE_ATOMICALLY(code_block)	\
-{						\
-	spl_t s;				\
-						\
-	xnlock_get_irqsave(&nklock, s);		\
-	code_block;				\
-	xnlock_put_irqrestore(&nklock, s);	\
+#define RTDM_EXECUTE_ATOMICALLY(code_block)		\
+{							\
+	spl_t __rtdm_s;					\
+							\
+	xnlock_get_irqsave(&nklock, __rtdm_s);		\
+	code_block;					\
+	xnlock_put_irqrestore(&nklock, __rtdm_s);	\
 }
 #endif
 /** @} Global Lock across Scheduler Invocation */


