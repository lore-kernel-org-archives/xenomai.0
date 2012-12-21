From: Wolfgang Mauerer <wolfgang.mauerer@siemens.com>
Date: Fri, 21 Dec 2012 14:26:12 +0100
Message-Id: <1356096375-29859-8-git-send-email-wolfgang.mauerer@siemens.com>
In-Reply-To: <1356096375-29859-1-git-send-email-wolfgang.mauerer@siemens.com>
References: <1356096375-29859-1-git-send-email-wolfgang.mauerer@siemens.com>
Subject: [Xenomai] [PATCH 07/10] ipipe: Add mechanism to allow preemption
	calls from non-root context
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org
Cc: jan.kiszka@siemens.com, wolfgang.mauerer@siemens.com

The ipipe_safe_preempt_xyz() functions provide the same
semantics as the preempt_xyz() counterparts, but can
be safely called from non-root context.

Signed-off-by: Wolfgang Mauerer <wolfgang.mauerer@siemens.com>
---
 include/linux/ipipe_foreign_stack.h |    9 ++++++
 kernel/ipipe/core.c                 |   51 +++++++++++++++++++++++++++++++++++
 2 files changed, 60 insertions(+), 0 deletions(-)

diff --git a/include/linux/ipipe_foreign_stack.h b/include/linux/ipipe_foreign_stack.h
index 4d5132a..0925798 100644
--- a/include/linux/ipipe_foreign_stack.h
+++ b/include/linux/ipipe_foreign_stack.h
@@ -51,6 +51,15 @@ static inline int ipipe_test_foreign_stack(void)
 	})
 #endif
 
+#define ipipe_safe_preempt_count() (ipipe_safe_current_thread_info()->preempt_count)
+
+void ipipe_safe_preempt_enable(void);
+void ipipe_safe_preempt_enable_notrace(void);
+void ipipe_safe_preempt_disable(void);
+void ipipe_safe_preempt_disable_notrace(void);
+void ipipe_safe_preempt_enable_no_resched(void);
+void ipipe_safe_preempt_enable_no_resched_notrace(void);
+
 #else /* !CONFIG_IPIPE */
 
 #define ipipe_safe_current()			current
diff --git a/kernel/ipipe/core.c b/kernel/ipipe/core.c
index 126953b..b68c772 100644
--- a/kernel/ipipe/core.c
+++ b/kernel/ipipe/core.c
@@ -1702,3 +1702,54 @@ out:
 	ipipe_restore_head(flags);
 }
 EXPORT_SYMBOL_GPL(__ipipe_post_work_root);
+
+// TODO: Provide debugging versions when CONFIG_PREEMPT_DEBUG
+// is enabled. Essentially, preempt_{en,dis}able need to be augmented
+// with tracing information
+#ifdef CONFIG_PREEMPT
+void ipipe_safe_preempt_disable(void)
+{
+	ipipe_safe_preempt_count() += 1;
+	barrier();
+}
+
+void ipipe_safe_preempt_disable_notrace(void)
+{
+	ipipe_safe_preempt_count() += 1;
+	barrier();
+}
+
+inline void ipipe_safe_preempt_enable_no_resched(void)
+{
+	barrier();
+	ipipe_safe_preempt_count() -= 1;
+}
+
+asmlinkage void preempt_schedule(void);
+inline void ipipe_safe_preempt_check_resched(void)
+{
+	if (ipipe_root_p && unlikely(test_thread_flag(TIF_NEED_RESCHED)))
+		preempt_schedule();
+}
+
+void ipipe_safe_preempt_enable(void)
+{
+	ipipe_safe_preempt_enable_no_resched();
+	barrier();
+	ipipe_safe_preempt_check_resched();
+}
+
+void ipipe_safe_preempt_enable_notrace(void)
+{
+	ipipe_safe_preempt_enable_no_resched();
+	barrier();
+	ipipe_safe_preempt_check_resched();
+}
+
+void ipipe_safe_preempt_enable_no_resched_notrace(void)
+{
+	barrier();
+	ipipe_safe_preempt_count() -= 1;
+}
+
+#endif
-- 
1.7.1


