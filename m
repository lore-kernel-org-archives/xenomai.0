From: Jan Kiszka <jan.kiszka@domain.hid>
Date: Mon, 19 Apr 2010 12:28:52 +0200
Message-Id: <dd66084b421a998bbc402a5fd0482cd30a2daf33.1271672940.git.jan.kiszka@domain.hid>
In-Reply-To: <cover.1271672940.git.jan.kiszka@domain.hid>
References: <cover.1271672940.git.jan.kiszka@domain.hid>
In-Reply-To: <cover.1271672940.git.jan.kiszka@domain.hid>
References: <cover.1271672940.git.jan.kiszka@domain.hid>
Subject: [Xenomai-core] [PATCH v4 12/25] RTDM: Add rtdm_context_put()
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

As suggested by Philippe: This is an alias of rtdm_context_unlock(), but
it is more intuitive to match it with rtdm_context_get() calls.

CC: Philippe Gerum <rpm@xenomai.org>
Signed-off-by: Jan Kiszka <jan.kiszka@domain.hid>
---
 include/rtdm/rtdm_driver.h  |    5 +++++
 ksrc/skins/rtdm/API.CHANGES |    1 +
 ksrc/skins/rtdm/core.c      |   29 +++++++++++++++++++++++++----
 3 files changed, 31 insertions(+), 4 deletions(-)

diff --git a/include/rtdm/rtdm_driver.h b/include/rtdm/rtdm_driver.h
index 3fc9071..07b73a3 100644
--- a/include/rtdm/rtdm_driver.h
+++ b/include/rtdm/rtdm_driver.h
@@ -568,6 +568,11 @@ static inline void rtdm_context_unlock(struct rtdm_dev_context *context)
 	atomic_dec(&context->close_lock_count);
 }
 
+static inline void rtdm_context_put(struct rtdm_dev_context *context)
+{
+	rtdm_context_unlock(context);
+}
+
 /* --- clock services --- */
 struct xntbase;
 extern struct xntbase *rtdm_tbase;
diff --git a/ksrc/skins/rtdm/API.CHANGES b/ksrc/skins/rtdm/API.CHANGES
index 64a4b38..73c1850 100644
--- a/ksrc/skins/rtdm/API.CHANGES
+++ b/ksrc/skins/rtdm/API.CHANGES
@@ -9,6 +9,7 @@ Scheduled modifications (unsorted):
 
 Revision 8:
  o Added rtdm_rt_capable.
+ o Added rtdm_context_put as logic match to rtdm_context_get
 
 Revision 7:
  o Added callbacks and services to enable select support.
diff --git a/ksrc/skins/rtdm/core.c b/ksrc/skins/rtdm/core.c
index ba4dc63..e04b3f6 100644
--- a/ksrc/skins/rtdm/core.c
+++ b/ksrc/skins/rtdm/core.c
@@ -50,14 +50,14 @@ EXPORT_SYMBOL(rtdm_tbase);
 DEFINE_XNLOCK(rt_fildes_lock);
 
 /**
- * @brief Resolve file descriptor to device context
+ * @brief Retrieve and lock a device context
  *
  * @param[in] fd File descriptor
  *
  * @return Pointer to associated device context, or NULL on error
  *
- * @note The device context has to be unlocked using rtdm_context_unlock()
- * when it is no longer referenced.
+ * @note The device context has to be unlocked using rtdm_context_put() when
+ * it is no longer referenced.
  *
  * Environments:
  *
@@ -612,7 +612,7 @@ void rtdm_context_lock(struct rtdm_dev_context *context);
  *
  * @param[in] context Device context
  *
- * @note Every successful call to rtdm_context_get() must be matched by a
+ * @note Every call to rtdm_context_locked() must be matched by a
  * rtdm_context_unlock() invocation.
  *
  * Environments:
@@ -629,6 +629,27 @@ void rtdm_context_lock(struct rtdm_dev_context *context);
 void rtdm_context_unlock(struct rtdm_dev_context *context);
 
 /**
+ * @brief Release a device context obtained via rtdm_context_get()
+ *
+ * @param[in] context Device context
+ *
+ * @note Every successful call to rtdm_context_get() must be matched by a
+ * rtdm_context_put() invocation.
+ *
+ * Environments:
+ *
+ * This service can be called from:
+ *
+ * - Kernel module initialization/cleanup code
+ * - Interrupt service routine
+ * - Kernel-based task
+ * - User-space task (RT, non-RT)
+ *
+ * Rescheduling: never.
+ */
+void rtdm_context_put(struct rtdm_dev_context *context);
+
+/**
  * @brief Open a device
  *
  * Refer to rt_dev_open() for parameters and return values
-- 
1.6.0.2


