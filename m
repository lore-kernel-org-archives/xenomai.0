Message-ID: <4E981906.6020400@domain.hid>
Date: Fri, 14 Oct 2011 13:12:06 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Subject: [Adeos-main] [PULL] 2.6.38-noarch: Re-add root preemption notifier
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/options/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: </public/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: Philippe Gerum <rpm@xenomai.org>
Cc: adeos-main <adeos-main@gna.org>

The following changes since commit 641d8e87531c6367a6357335378194ea06a23701:

  ipipe: Prevent unwritable pages after mprotect (2011-07-21 09:51:56 +0200)

are available in the git repository at:
  git://git.kiszka.org/ipipe queues/2.6.38-noarch

Jan Kiszka (1):
      ipipe: Re-add root preemption notifier

 include/linux/ipipe.h      |   35 +++++++++++++++++++++++++++++++++++
 include/linux/ipipe_base.h |    2 +-
 kernel/ipipe/core.c        |    6 ++++++
 3 files changed, 42 insertions(+), 1 deletions(-)

---

ipipe: Re-add root preemption notifier

Restore the original root preemption notifiers, once added for 2.6.35
but then lost again on 2.6.36 merge. Unfortunately, the feature flag was
not lost. So it became meaningless and we have to rename it to
__IPIPE_FEATURE_ROOTPREEMPT_NOTIFIER.

Signed-off-by: Jan Kiszka <jan.kiszka@domain.hid>
---
 include/linux/ipipe.h      |   35 +++++++++++++++++++++++++++++++++++
 include/linux/ipipe_base.h |    2 +-
 kernel/ipipe/core.c        |    6 ++++++
 3 files changed, 42 insertions(+), 1 deletions(-)

diff --git a/include/linux/ipipe.h b/include/linux/ipipe.h
index aff6c3c..fb0789e 100644
--- a/include/linux/ipipe.h
+++ b/include/linux/ipipe.h
@@ -195,6 +195,11 @@ extern struct list_head __ipipe_pipeline;
 
 extern int __ipipe_event_monitors[];
 
+typedef void (*ipipe_root_preempt_handler_t)(void *cookie);
+
+DECLARE_PER_CPU(ipipe_root_preempt_handler_t, __ipipe_root_preempt_handler);
+DECLARE_PER_CPU(void *, __ipipe_root_preempt_cookie);
+
 /* Private interface */
 
 void ipipe_init_early(void);
@@ -689,6 +694,32 @@ static inline void ipipe_nmi_exit(void)
 
 #define ipipe_clear_flags(p)		do { (p)->ipipe_flags = 0; } while (0)
 
+static inline void
+ipipe_register_root_preempt_handler(ipipe_root_preempt_handler_t handler,
+				    void *cookie)
+{
+	int cpu = ipipe_processor_id();
+
+	per_cpu(__ipipe_root_preempt_cookie, cpu) = cookie;
+	barrier();
+	per_cpu(__ipipe_root_preempt_handler, cpu) = handler;
+}
+
+static inline void ipipe_unregister_root_preempt_handler(void)
+{
+	per_cpu(__ipipe_root_preempt_handler, ipipe_processor_id()) = NULL;
+}
+
+static inline void ipipe_root_preempt_notify(void)
+{
+	ipipe_root_preempt_handler_t handler;
+	int cpu = ipipe_processor_id();
+
+	handler = per_cpu(__ipipe_root_preempt_handler, cpu);
+	if (unlikely(handler))
+		handler(per_cpu(__ipipe_root_preempt_cookie, cpu));
+}
+
 #else	/* !CONFIG_IPIPE */
 
 #define ipipe_init_early()		do { } while(0)
@@ -702,6 +733,10 @@ static inline void ipipe_nmi_exit(void)
 #define ipipe_trap_notify(t,r)		0
 #define ipipe_init_proc()		do { } while(0)
 
+#define ipipe_register_root_preempt_handler(h, c)	do { } while (0)
+#define ipipe_unregister_root_preempt_handler()		do { } while (0)
+#define ipipe_root_preempt_notify()			do { } while (0)
+
 static inline void __ipipe_pin_range_globally(unsigned long start,
 					      unsigned long end)
 {
diff --git a/include/linux/ipipe_base.h b/include/linux/ipipe_base.h
index 3f43ba5..f725a66 100644
--- a/include/linux/ipipe_base.h
+++ b/include/linux/ipipe_base.h
@@ -108,8 +108,8 @@ static inline void ipipe_check_context(struct ipipe_domain *border_ipd) { }
 #define __IPIPE_FEATURE_HOSTRT			1
 #endif
 #define __IPIPE_FEATURE_PREPARE_PANIC		1
-#define __IPIPE_FEATURE_ROOT_PREEMPT_NOTIFIER	1
 #define __IPIPE_FEATURE_CONTROL_IRQ		1
+#define __IPIPE_FEATURE_ROOTPREEMPT_NOTIFIER	1
 
 #else /* !CONFIG_IPIPE */
 
diff --git a/kernel/ipipe/core.c b/kernel/ipipe/core.c
index 43faed2..51a8be6 100644
--- a/kernel/ipipe/core.c
+++ b/kernel/ipipe/core.c
@@ -114,6 +114,12 @@ unsigned __ipipe_printk_virq;
 
 int __ipipe_event_monitors[IPIPE_NR_EVENTS];
 
+DEFINE_PER_CPU(ipipe_root_preempt_handler_t, __ipipe_root_preempt_handler);
+EXPORT_PER_CPU_SYMBOL_GPL(__ipipe_root_preempt_handler);
+
+DEFINE_PER_CPU(void *, __ipipe_root_preempt_cookie);
+EXPORT_PER_CPU_SYMBOL_GPL(__ipipe_root_preempt_cookie);
+
 #ifdef CONFIG_GENERIC_CLOCKEVENTS
 
 DECLARE_PER_CPU(struct tick_device, tick_cpu_device);
-- 
1.7.3.4

