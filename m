Message-ID: <47947496.70005@domain.hid>
Date: Mon, 21 Jan 2008 11:31:50 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------040700050407030808050005"
Subject: [Adeos-main] [PATCH] improve ipipe_check_context instrumentation
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
--------------040700050407030808050005
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit

Working on kgdb for I-pipe, I noticed that we miss add/sub_preempt_count
with our ipipe_check_context tests. Here is an improved instrumentation
(which also removes some over-instrumentations).

Jan

-- 
Siemens AG, Corporate Technology, CT SE 2
Corporate Competence Center Embedded Linux

--------------040700050407030808050005
Content-Type: text/x-patch;
 name="refactor-preempt-context-check.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="refactor-preempt-context-check.patch"

---
 include/linux/preempt.h |   21 ++++++++++++---------
 kernel/sched.c          |    4 ++--
 2 files changed, 14 insertions(+), 11 deletions(-)

Index: linux-2.6.24-rc8-xeno_64/include/linux/preempt.h
===================================================================
--- linux-2.6.24-rc8-xeno_64.orig/include/linux/preempt.h
+++ linux-2.6.24-rc8-xeno_64/include/linux/preempt.h
@@ -15,8 +15,14 @@
   extern void fastcall add_preempt_count(int val);
   extern void fastcall sub_preempt_count(int val);
 #else
-# define add_preempt_count(val)	do { preempt_count() += (val); } while (0)
-# define sub_preempt_count(val)	do { preempt_count() -= (val); } while (0)
+# define add_preempt_count(val)	do { \
+	ipipe_check_context(ipipe_root_domain); \
+	preempt_count() += (val); \
+  } while (0)
+# define sub_preempt_count(val)	do { \
+	ipipe_check_context(ipipe_root_domain); \
+	preempt_count() -= (val); \
+  } while (0)
 #endif
 
 #define inc_preempt_count() add_preempt_count(1)
@@ -30,21 +36,18 @@ asmlinkage void preempt_schedule(void);
 
 #define preempt_disable() \
 do { \
-	ipipe_check_context(ipipe_root_domain); \
 	inc_preempt_count(); \
 	barrier(); \
 } while (0)
 
 #define preempt_enable_no_resched() \
 do { \
-	ipipe_check_context(ipipe_root_domain); \
 	barrier(); \
 	dec_preempt_count(); \
 } while (0)
 
 #define preempt_check_resched() \
 do { \
-	ipipe_check_context(ipipe_root_domain); \
 	if (unlikely(test_thread_flag(TIF_NEED_RESCHED))) \
 		preempt_schedule(); \
 } while (0)
@@ -58,10 +61,10 @@ do { \
 
 #else
 
-#define preempt_disable()		ipipe_check_context(ipipe_root_domain)
-#define preempt_enable_no_resched()	ipipe_check_context(ipipe_root_domain)
-#define preempt_enable()		ipipe_check_context(ipipe_root_domain)
-#define preempt_check_resched()		ipipe_check_context(ipipe_root_domain)
+#define preempt_disable()		do { } while (0)
+#define preempt_enable_no_resched()	do { } while (0)
+#define preempt_enable()		do { } while (0)
+#define preempt_check_resched()		do { } while (0)
 
 #endif
 
Index: linux-2.6.24-rc8-xeno_64/kernel/sched.c
===================================================================
--- linux-2.6.24-rc8-xeno_64.orig/kernel/sched.c
+++ linux-2.6.24-rc8-xeno_64/kernel/sched.c
@@ -3510,6 +3510,7 @@ void scheduler_tick(void)
 
 void fastcall add_preempt_count(int val)
 {
+	ipipe_check_context(ipipe_root_domain);
 	/*
 	 * Underflow?
 	 */
@@ -3526,6 +3527,7 @@ EXPORT_SYMBOL(add_preempt_count);
 
 void fastcall sub_preempt_count(int val)
 {
+	ipipe_check_context(ipipe_root_domain);
 	/*
 	 * Underflow?
 	 */
@@ -3630,8 +3632,6 @@ asmlinkage void __sched schedule(void)
 	struct rq *rq;
 	int cpu;
 
-	ipipe_check_context(ipipe_root_domain);
-
 need_resched:
 	preempt_disable();
 	cpu = smp_processor_id();

--------------040700050407030808050005--

