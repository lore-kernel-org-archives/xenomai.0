From: Philippe Gerum <rpm@xenomai.org>
Subject: [PATCH] x86/process: ipipe: prevent false positive in testing for
 preemptible section
Date: Thu, 25 Oct 2018 15:20:21 +0200
Message-Id: <20181025132021.5278-1-rpm@xenomai.org>
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Henning Schild <henning.schild@siemens.com>
Cc: xenomai@xenomai.org, Jan Kiszka <jan.kiszka@siemens.com>, Philippe Gerum <rpm@xenomai.org>

We may call switch_to_bitmap() from the head stage when a co-kernel
switches to a new thread context, in which case IRQs are hard
disabled, although the root stage might be unstalled.

Make sure the preemption debug code in refresh_tss_limit() is aware of
this.
---
 arch/x86/include/asm/desc.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/desc.h b/arch/x86/include/asm/desc.h
index 0e3758c0c954..7a4cb4333df3 100644
--- a/arch/x86/include/asm/desc.h
+++ b/arch/x86/include/asm/desc.h
@@ -309,7 +309,7 @@ static inline void force_reload_TR(void)
  */
 static inline void refresh_tss_limit(void)
 {
-	DEBUG_LOCKS_WARN_ON(preemptible());
+	DEBUG_LOCKS_WARN_ON(!hard_irqs_disabled() && preemptible());
 
 	if (unlikely(this_cpu_read(__tss_limit_invalid)))
 		force_reload_TR();
-- 
2.17.2


