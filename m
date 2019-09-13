From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [PATCH 02/11] rtdm: Introduce rtdm_available()
Date: Fri, 13 Sep 2019 15:18:51 +0200
Message-Id: <0021d5c1eaf39778760780a6230d65aca45c99e0.1568380740.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1568380740.git.jan.kiszka@siemens.com>
References: <cover.1568380740.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1568380740.git.jan.kiszka@siemens.com>
References: <cover.1568380740.git.jan.kiszka@siemens.com>
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

From: Jan Kiszka <jan.kiszka@siemens.com>

This avoids layering violations in RTDM drivers by calling
realtime_core_enabled() directly.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 include/cobalt/kernel/rtdm/driver.h |  5 +++++
 kernel/cobalt/rtdm/drvlib.c         | 15 +++++++++++++++
 2 files changed, 20 insertions(+)

diff --git a/include/cobalt/kernel/rtdm/driver.h b/include/cobalt/kernel/rtdm/driver.h
index 72f75388da..9e7a888249 100644
--- a/include/cobalt/kernel/rtdm/driver.h
+++ b/include/cobalt/kernel/rtdm/driver.h
@@ -1297,6 +1297,11 @@ static inline int rtdm_strncpy_from_user(struct rtdm_fd *fd,
 	return cobalt_strncpy_from_user(dst, src, count);
 }
 
+static inline bool rtdm_available(void)
+{
+	return realtime_core_enabled();
+}
+
 static inline int rtdm_rt_capable(struct rtdm_fd *fd)
 {
 	if (!XENO_ASSERT(COBALT, !xnsched_interrupt_p()))
diff --git a/kernel/cobalt/rtdm/drvlib.c b/kernel/cobalt/rtdm/drvlib.c
index 3bf23e7836..27d8c93c7d 100644
--- a/kernel/cobalt/rtdm/drvlib.c
+++ b/kernel/cobalt/rtdm/drvlib.c
@@ -2413,6 +2413,21 @@ int rtdm_in_rt_context(void);
  */
 int rtdm_rt_capable(struct rtdm_fd *fd);
 
+/**
+ * Test if the real-time core is available
+ *
+ * @return True if the real-time is available, false if it is disabled or in
+ * error state.
+ *
+ * @note Drivers should query the core state during initialization if they
+ * perform hardware setup operations or interact with RTDM services such as
+ * locks prior to calling an RTDM service that has a built-in state check of
+ * the real-time core (e.g. rtdm_dev_register() or rtdm_task_init()).
+ *
+ * @coretags{unrestricted}
+ */
+bool rtdm_available(void);
+
 #endif /* DOXYGEN_CPP */
 
 /** @} Utility Services */
-- 
2.16.4


