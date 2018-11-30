From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [PATCH 1/2][noarch-4.14] ipipe: Introduce infrastructure for
 userspace return notifier
Message-ID: <0a31a0d9-3161-fd05-91a2-1d39266415ea@siemens.com>
Date: Fri, 30 Nov 2018 21:07:15 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Xenomai <xenomai@xenomai.org>, Philippe Gerum <rpm@xenomai.org>

A little bit inspired by the kernel's user return notifier, this
introduces an I-pipe hook before the kernel jumps back to a userspace
context from the root domain. The hook is design to allow a switch back
to the head domain, thus will not run through signal/preemption checks
when returning from the callback over head. It is guaranteed to fire on
return from interrupts and exceptions but may also fire on certain
syscall-return paths.

The first use case for the hook is resumption of ptraced tasks over
head if they were stopped in that domain.

This provides just the generic infrastructure, the invocation of
__ipipe_notify_user_intreturn as well as the definition of
TIP_USERINTRET are architecture-specific.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 include/linux/ipipe.h        | 11 +++++++++++
 include/linux/ipipe_base.h   |  4 ++++
 include/linux/ipipe_domain.h |  1 +
 kernel/ipipe/core.c          |  7 +++++++
 4 files changed, 23 insertions(+)

diff --git a/include/linux/ipipe.h b/include/linux/ipipe.h
index 692f59c20827..f30af6f7f905 100644
--- a/include/linux/ipipe.h
+++ b/include/linux/ipipe.h
@@ -409,6 +409,15 @@ int ipipe_test_ti_thread_flag(struct thread_info *ti, int flag)
 			ipipe_set_ti_thread_flag(ti, TIP_MAYDAY);	\
 	} while (0)
 
+#define ipipe_enable_user_intret_notifier()				\
+	ipipe_set_thread_flag(TIP_USERINTRET)
+
+#define ipipe_disable_user_intret_notifier()				\
+	ipipe_clear_thread_flag(TIP_USERINTRET)
+
+#define ipipe_user_intret_notifier_enabled(ti)				\
+	ipipe_test_ti_thread_flag(ti, TIP_USERINTRET)
+
 #ifdef CONFIG_IPIPE_TRACE
 void __ipipe_tracer_hrclock_initialized(void);
 #else /* !CONFIG_IPIPE_TRACE */
@@ -473,6 +482,8 @@ bool ipipe_enter_cpuidle(struct cpuidle_device *dev,
 	return true;
 }
 
+#define ipipe_user_intret_notifier_enabled(ti)	0
+
 #endif	/* !CONFIG_IPIPE */
 
 #endif	/* !__LINUX_IPIPE_H */
diff --git a/include/linux/ipipe_base.h b/include/linux/ipipe_base.h
index cbc3568bd0a7..d8429171a550 100644
--- a/include/linux/ipipe_base.h
+++ b/include/linux/ipipe_base.h
@@ -175,6 +175,8 @@ void __ipipe_call_mayday(struct pt_regs *regs);
 
 void __ipipe_notify_vm_preemption(void);
 
+int __ipipe_notify_user_intreturn(void);
+
 #define __ipipe_serial_debug(__fmt, __args...)	raw_printk(__fmt, ##__args)
 
 #else /* !CONFIG_IPIPE */
@@ -226,6 +228,8 @@ static inline void __ipipe_exit_vm(void) { }
 
 static inline void __ipipe_notify_vm_preemption(void) { }
 
+#define __ipipe_notify_user_intreturn()	0
+
 #define __ipipe_serial_debug(__fmt, __args...)	do { } while (0)
 
 #endif	/* !CONFIG_IPIPE */
diff --git a/include/linux/ipipe_domain.h b/include/linux/ipipe_domain.h
index bbc26e9592d5..f2ce31528389 100644
--- a/include/linux/ipipe_domain.h
+++ b/include/linux/ipipe_domain.h
@@ -92,6 +92,7 @@ struct ipipe_vm_notifier;
 #define IPIPE_KEVT_CLEANUP	5
 #define IPIPE_KEVT_HOSTRT	6
 #define IPIPE_KEVT_CLOCKFREQ	7
+#define IPIPE_KEVT_USERINTRET	8
 
 typedef void (*ipipe_irq_ackfn_t)(struct irq_desc *desc);
 
diff --git a/kernel/ipipe/core.c b/kernel/ipipe/core.c
index 7ac520817a83..4d61c0e57ba1 100644
--- a/kernel/ipipe/core.c
+++ b/kernel/ipipe/core.c
@@ -1164,6 +1164,13 @@ int __ipipe_notify_trap(int exception, struct pt_regs *regs)
 	return ret;
 }
 
+int __ipipe_notify_user_intreturn(void)
+{
+	__ipipe_notify_kevent(IPIPE_KEVT_USERINTRET, current);
+
+	return !ipipe_root_p;
+}
+
 int __weak ipipe_kevent_hook(int kevent, void *data)
 {
 	return 0;
-- 
2.16.4

