Message-ID: <47AC3012.6050404@domain.hid>
Date: Fri, 08 Feb 2008 11:33:54 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------000405020405060108010607"
Subject: [Adeos-main] [PATCH] optional ipipe_safe_current
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: </public/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: Philippe Gerum <rpm@xenomai.org>
Cc: adeos-main <adeos-main@gna.org>

This is a multi-part message in MIME format.
--------------000405020405060108010607
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit

>From my cleanup queue:

There is no need to check for IPIPE_NOSTACK_FLAG on archs which always
provide safe access to current (like x86).

Jan

-- 
Siemens AG, Corporate Technology, CT SE 2
Corporate Competence Center Embedded Linux

--------------000405020405060108010607
Content-Type: text/x-patch;
 name="optional-ipipe_safe_current.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="optional-ipipe_safe_current.patch"

---
 include/asm-x86/ipipe.h |    5 +++--
 include/linux/ipipe.h   |    2 ++
 2 files changed, 5 insertions(+), 2 deletions(-)

Index: linux-2.6.24-xeno_64/include/asm-x86/ipipe.h
===================================================================
--- linux-2.6.24-xeno_64.orig/include/asm-x86/ipipe.h
+++ linux-2.6.24-xeno_64/include/asm-x86/ipipe.h
@@ -40,10 +40,11 @@ DECLARE_PER_CPU(struct pt_regs, __ipipe_
 #endif
 
 /*
- * The logical processor id is read from the PDA, so this is always
- * safe, regardless of the underlying stack.
+ * The logical processor id and the current Linux task are read from the PDA,
+ * so this is always safe, regardless of the underlying stack.
  */
 #define ipipe_processor_id()	raw_smp_processor_id()
+#define ipipe_safe_current()	current
 
 #define prepare_arch_switch(next)		\
 do {						\
Index: linux-2.6.24-xeno_64/include/linux/ipipe.h
===================================================================
--- linux-2.6.24-xeno_64.orig/include/linux/ipipe.h
+++ linux-2.6.24-xeno_64/include/linux/ipipe.h
@@ -443,6 +443,7 @@ static inline void ipipe_clear_foreign_s
 	__clear_bit(IPIPE_NOSTACK_FLAG, &ipipe_cpudom_var(ipd, status));
 }
 
+#ifndef ipipe_safe_current
 #define ipipe_safe_current()					\
 ({								\
 	struct task_struct *p;					\
@@ -450,6 +451,7 @@ static inline void ipipe_clear_foreign_s
 		     &ipipe_this_cpudom_var(status)) ? &init_task : current; \
 	p; \
 })
+#endif
 
 ipipe_event_handler_t ipipe_catch_event(struct ipipe_domain *ipd,
 					unsigned event,

--------------000405020405060108010607--

