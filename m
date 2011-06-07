Message-ID: <4DEE2D4D.1020307@domain.hid>
Date: Tue, 07 Jun 2011 15:53:17 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Subject: [Adeos-main] [PULL] ipipe-2.6.38-noarch
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

The following changes since commit a91de1c71c21a4f8d7fffb5d675af6664261f7e5:

  ipipe: Re-read domain data pointer after interrupt handler execution (2011-06-04 16:16:28 +0200)

are available in the git repository at:
  git://git.kiszka.org/ipipe queues/2.6.38-noarch

[edited summary]
Jan Kiszka (2):
      ipipe: Optimize ipipe_percpu_domain_data::status accesses
      Merge remote branch 'stable-2.6.38/master' into queues/2.6.38-noarch

---

ipipe: Optimize ipipe_percpu_domain_data::status accesses

The per-CPU domain status must only be accessed over the current CPU
(except for setup purposes). So there is no point in using costly atomic
operations to manipulate them. Drop the remaining ones from generic
code.

Signed-off-by: Jan Kiszka <jan.kiszka@domain.hid>
---
 include/linux/ipipe.h |    4 ++--
 kernel/ipipe/core.c   |    7 ++++---
 2 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/include/linux/ipipe.h b/include/linux/ipipe.h
index 7c205c0..aff6c3c 100644
--- a/include/linux/ipipe.h
+++ b/include/linux/ipipe.h
@@ -321,11 +321,11 @@ static inline void __local_irq_restore_nosync(unsigned long x)
 	struct ipipe_percpu_domain_data *p = ipipe_root_cpudom_ptr();
 
 	if (raw_irqs_disabled_flags(x)) {
-		set_bit(IPIPE_STALL_FLAG, &p->status);
+		__set_bit(IPIPE_STALL_FLAG, &p->status);
 		trace_hardirqs_off();
 	} else {
 		trace_hardirqs_on();
-		clear_bit(IPIPE_STALL_FLAG, &p->status);
+		__clear_bit(IPIPE_STALL_FLAG, &p->status);
 	}
 }
 
diff --git a/kernel/ipipe/core.c b/kernel/ipipe/core.c
index f3603df..43faed2 100644
--- a/kernel/ipipe/core.c
+++ b/kernel/ipipe/core.c
@@ -442,7 +442,8 @@ void __ipipe_restore_pipeline_head(unsigned long x) /* hw interrupt off */
 	if (x) {
 #ifdef CONFIG_DEBUG_KERNEL
 		static int warned;
-		if (!warned && test_and_set_bit(IPIPE_STALL_FLAG, &p->status)) {
+		if (!warned &&
+		    __test_and_set_bit(IPIPE_STALL_FLAG, &p->status)) {
 			/*
 			 * Already stalled albeit ipipe_restore_pipeline_head()
 			 * should have detected it? Send a warning once.
@@ -455,7 +456,7 @@ void __ipipe_restore_pipeline_head(unsigned long x) /* hw interrupt off */
 			local_irq_disable_hw();	
 		}
 #else /* !CONFIG_DEBUG_KERNEL */
-		set_bit(IPIPE_STALL_FLAG, &p->status);
+		__set_bit(IPIPE_STALL_FLAG, &p->status);
 #endif /* CONFIG_DEBUG_KERNEL */
 	}
 	else {
@@ -1211,7 +1212,7 @@ void __ipipe_preempt_schedule_irq(void)
 	if (unlikely(__ipipe_ipending_p(p))) {
 		add_preempt_count(PREEMPT_ACTIVE);
 		trace_hardirqs_on();
-		clear_bit(IPIPE_STALL_FLAG, &p->status);
+		__clear_bit(IPIPE_STALL_FLAG, &p->status);
 		__ipipe_sync_pipeline();
 		sub_preempt_count(PREEMPT_ACTIVE);
 	}
-- 
1.7.1

