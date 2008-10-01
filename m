Message-ID: <48E37266.2040006@domain.hid>
Date: Wed, 01 Oct 2008 14:51:50 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Subject: [Adeos-main] [RFC][PATCH] Rework async printk conditions
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

Some ad-hoc instrumentation of Xenomai code running over the root domain
but with the head domain stalled (nklock held) triggered the new
topmost-stalled warning for me.

So I reworked the condition for doing async (ipipe-buffered) printk as
follows:
 no oops in progress AND
 domain did not request sync printk AND
 (domain != root OR
   (domain == root AND some higher domain stalled))

Makes sense?

Jan

---
 kernel/printk.c |   24 ++++++++++++++++++++----
 1 file changed, 20 insertions(+), 4 deletions(-)

Index: b/kernel/printk.c
===================================================================
--- a/kernel/printk.c
+++ b/kernel/printk.c
@@ -641,17 +641,33 @@ void __ipipe_flush_printk (unsigned virq
 
 asmlinkage int printk(const char *fmt, ...)
 {
-  	int r, fbytes, oldcount, cs = -1;
-    	unsigned long flags;
+	int r, fbytes, oldcount;
+	int sprintk = 1;
+	int cs = -1;
+	unsigned long flags;
 	va_list args;
 
 	va_start(args, fmt);
 
-	if (test_bit(IPIPE_SPRINTK_FLAG,&ipipe_current_domain->flags) ||
+	if (test_bit(IPIPE_SPRINTK_FLAG, &ipipe_current_domain->flags) ||
 	    oops_in_progress)
 		cs = ipipe_disable_context_check(ipipe_processor_id());
+	else if (ipipe_current_domain == ipipe_root_domain) {
+		struct ipipe_domain *dom;
 
-	if (ipipe_current_domain == ipipe_root_domain || cs != -1) {
+		local_irq_save_hw(flags);
+		list_for_each_entry(dom, &__ipipe_pipeline, p_link) {
+			if (dom == ipipe_root_domain)
+				break;
+			if (test_bit(IPIPE_STALL_FLAG,
+				     &ipipe_cpudom_var(dom, status)))
+				sprintk = 0;
+		}
+		local_irq_restore_hw(flags);
+	} else
+		sprintk = 0;
+
+	if (sprintk) {
 		r = vprintk(fmt, args);
 		if (cs != -1)
 			ipipe_restore_context_check(ipipe_processor_id(), cs);

