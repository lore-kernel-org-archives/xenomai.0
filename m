From: Wolfgang Mauerer <wolfgang.mauerer@siemens.com>
Date: Fri, 21 Dec 2012 14:26:13 +0100
Message-Id: <1356096375-29859-9-git-send-email-wolfgang.mauerer@siemens.com>
In-Reply-To: <1356096375-29859-1-git-send-email-wolfgang.mauerer@siemens.com>
References: <1356096375-29859-1-git-send-email-wolfgang.mauerer@siemens.com>
Subject: [Xenomai] [PATCH 08/10] ipipe: Introduce preemption call
	replacement mechanism
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

Including <linux/ipipe_switch_preempt.h> replaces all
calls to preemption functions with calls to alternatives
that are safe in non-root context.

Signed-off-by: Wolfgang Mauerer <wolfgang.mauerer@siemens.com>
---
 include/linux/ipipe_switch_preempt.h |   31 +++++++++++++++++++++++++++++++
 1 files changed, 31 insertions(+), 0 deletions(-)
 create mode 100644 include/linux/ipipe_switch_preempt.h

diff --git a/include/linux/ipipe_switch_preempt.h b/include/linux/ipipe_switch_preempt.h
new file mode 100644
index 0000000..f53919f
--- /dev/null
+++ b/include/linux/ipipe_switch_preempt.h
@@ -0,0 +1,31 @@
+#ifndef IPIPE_SWITCH_PREEMPT
+#define IPIPE_SWITCH_PREEMPT
+
+/* #include'ing this file switches the Linux preemption calls
+   to the more costly functions that may be called from non-root
+   context. */
+
+#if defined(CONFIG_IPIPE) && defined(CONFIG_PREEMPT)
+#undef preempt_count
+#define preempt_count()	ipipe_safe_preempt_count()
+
+#undef preempt_disable
+#define preempt_disable()	ipipe_safe_preempt_disable()
+
+#undef preempt_disable_notrace
+#define preempt_disable_notrace() 	ipipe_safe_preempt_disable_notrace()
+
+#undef preempt_enable
+#define preempt_enable()	ipipe_safe_preempt_enable()
+
+#undef preempt_enable_notrace
+#define preempt_enable_notrace()	ipipe_safe_preempt_enable_notrace()
+
+#undef preempt_enable_no_resched_notrace
+#define preempt_enable_no_resched_notrace()	ipipe_safe_preempt_enable_no_resched_notrace()
+
+#undef preempt_enable_no_resched
+#define preempt_enable_no_resched()	ipipe_safe_preempt_enable_no_resched()
+#endif /* CONFIG_IPIPE && CONFIG_PREEMPT */
+
+#endif
-- 
1.7.1


