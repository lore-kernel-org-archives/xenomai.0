Resent-To: Philippe Gerum <rpm@xenomai.org>
Resent-Message-Id: <4A2681F5.5060203@domain.hid>
From: Jan Kiszka <jan.kiszka@domain.hid>
Date: Wed, 03 Jun 2009 15:59:13 +0200
Message-ID: <20090603135913.22120.23020.stgit@domain.hid>
In-Reply-To: <20090603135912.22120.29245.stgit@domain.hid>
References: <20090603135912.22120.29245.stgit@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-core] [PATCH v2 2/4] hal: Add rthal_local_irq_disabled
	wrapper
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

Add a more handy wrapper to test for the (virtual) IRQ mask of the
real-time domain and convert RTDM users to it.

Signed-off-by: Jan Kiszka <jan.kiszka@domain.hid>
---

 include/asm-generic/hal.h |    1 +
 ksrc/skins/rtdm/core.c    |   15 ++++++++++-----
 2 files changed, 11 insertions(+), 5 deletions(-)

diff --git a/include/asm-generic/hal.h b/include/asm-generic/hal.h
index e4fdea9..244ca02 100644
--- a/include/asm-generic/hal.h
+++ b/include/asm-generic/hal.h
@@ -116,6 +116,7 @@ typedef spinlock_t rthal_spinlock_t;
 #endif /* !CONFIG_XENO_OPT_PIPELINE_HEAD */
 #define rthal_local_irq_flags(x)	((x) = ipipe_test_pipeline_from(&rthal_domain) & 1)
 #define rthal_local_irq_test()		ipipe_test_pipeline_from(&rthal_domain)
+#define rthal_local_irq_disabled()	ipipe_test_pipeline_from(&rthal_domain)
 #define rthal_stage_irq_enable(dom)	ipipe_unstall_pipeline_from(dom)
 #define rthal_local_irq_save_hw(x)	local_irq_save_hw(x)
 #define rthal_local_irq_restore_hw(x)	local_irq_restore_hw(x)
diff --git a/ksrc/skins/rtdm/core.c b/ksrc/skins/rtdm/core.c
index 853b8af..5843842 100644
--- a/ksrc/skins/rtdm/core.c
+++ b/ksrc/skins/rtdm/core.c
@@ -222,7 +222,8 @@ int __rt_dev_open(rtdm_user_info_t *user_info, const char *path, int oflag)
 		ret = device->open_rt(context, user_info, oflag);
 	}
 
-	XENO_ASSERT(RTDM, !rthal_local_irq_test(), rthal_local_irq_enable(););
+	XENO_ASSERT(RTDM, !rthal_local_irq_disabled(),
+		    rthal_local_irq_enable(););
 
 	if (unlikely(ret < 0))
 		goto cleanup_out;
@@ -274,7 +275,8 @@ int __rt_dev_socket(rtdm_user_info_t *user_info, int protocol_family,
 		ret = device->socket_rt(context, user_info, protocol);
 	}
 
-	XENO_ASSERT(RTDM, !rthal_local_irq_test(), rthal_local_irq_enable(););
+	XENO_ASSERT(RTDM, !rthal_local_irq_disabled(),
+		    rthal_local_irq_enable(););
 
 	if (unlikely(ret < 0))
 		goto cleanup_out;
@@ -336,7 +338,8 @@ again:
 		ret = context->ops->close_rt(context, user_info);
 	}
 
-	XENO_ASSERT(RTDM, !rthal_local_irq_test(), rthal_local_irq_enable(););
+	XENO_ASSERT(RTDM, !rthal_local_irq_disabled(),
+		    rthal_local_irq_enable(););
 
 	if (unlikely(ret == -EAGAIN) && nrt_mode) {
 		rtdm_context_unlock(context);
@@ -422,7 +425,8 @@ do {									\
 	else								\
 		ret = ops->operation##_nrt(context, user_info, args);	\
 									\
-	XENO_ASSERT(RTDM, !rthal_local_irq_test(), rthal_local_irq_enable();)
+	XENO_ASSERT(RTDM, !rthal_local_irq_disabled(),			\
+		    rthal_local_irq_enable();)
 
 #define MAJOR_FUNCTION_WRAPPER_BH()					\
 	rtdm_context_unlock(context);					\
@@ -564,7 +568,8 @@ int rtdm_select_bind(int fd, rtdm_selector_t *selector,
 
 	ret = ops->select_bind(context, selector, type, fd_index);
 
-	XENO_ASSERT(RTDM, !rthal_local_irq_test(), rthal_local_irq_enable(););
+	XENO_ASSERT(RTDM, !rthal_local_irq_disabled(),
+		    rthal_local_irq_enable(););
 
 	rtdm_context_unlock(context);
 


