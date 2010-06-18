Message-ID: <4C1B57D4.6090700@domain.hid>
Date: Fri, 18 Jun 2010 13:26:12 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Subject: [Adeos-main] irq masking in ipipe_restore_pipeline_head
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

Hi Philippe,

don't we need this in ipipe_restore_pipeline_head to play safe (includes
some UP optimization as well):

diff --git a/include/linux/ipipe.h b/include/linux/ipipe.h
index c458883..bf1f94d 100644
--- a/include/linux/ipipe.h
+++ b/include/linux/ipipe.h
@@ -518,9 +518,13 @@ void __ipipe_restore_pipeline_head(unsigned long x);
 
 static inline void ipipe_restore_pipeline_head(unsigned long x)
 {
-	local_irq_disable_hw();
+	unsigned long flags;
+
+	local_irq_save_hw_smp(flags);
 	if ((x ^ test_bit(IPIPE_STALL_FLAG, &ipipe_head_cpudom_var(status))) & 1)
 		__ipipe_restore_pipeline_head(x);
+	else
+		local_irq_restore_hw_smp(flags);
 }
 
 #define ipipe_unstall_pipeline() \
diff --git a/kernel/ipipe/core.c b/kernel/ipipe/core.c
index e2503bd..60a6433 100644
--- a/kernel/ipipe/core.c
+++ b/kernel/ipipe/core.c
@@ -422,6 +422,9 @@ void __ipipe_restore_pipeline_head(unsigned long x) /* hw interrupt off */
 	struct ipipe_percpu_domain_data *p = ipipe_head_cpudom_ptr();
 	struct ipipe_domain *head_domain;
 
+#ifndef CONFIG_SMP
+	local_irq_disable_hw();
+#endif
 	if (x) {
 #ifdef CONFIG_DEBUG_KERNEL
 		static int warned;


Untested, just thoughts ATM.

Jan

-- 
Siemens AG, Corporate Technology, CT T DE IT 1
Corporate Competence Center Embedded Linux

