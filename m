From: Philippe Gerum <rpm@xenomai.org>
Date: Tue, 25 Sep 2018 12:38:03 +0200
Message-Id: <20180925103809.4932-27-rpm@xenomai.org>
In-Reply-To: <20180925103809.4932-1-rpm@xenomai.org>
References: <20180925103809.4932-1-rpm@xenomai.org>
Subject: [Xenomai] [PATCH 26/32] x86/mm: ipipe: fix lockdep tracing upon PF
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

---
 arch/x86/mm/fault.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/x86/mm/fault.c b/arch/x86/mm/fault.c
index 878aeb980d34..3d83d78f966b 100644
--- a/arch/x86/mm/fault.c
+++ b/arch/x86/mm/fault.c
@@ -1249,8 +1249,10 @@ __do_page_fault(struct pt_regs *regs, unsigned long error_code,
 	u32 pkey;
 
 #ifdef CONFIG_IPIPE
-	if (ipipe_root_domain != ipipe_head_domain)
-		hard_cond_local_irq_enable();
+	if (ipipe_root_domain != ipipe_head_domain) {
+		trace_hardirqs_on();
+		hard_local_irq_enable();
+	}
 #endif
 	tsk = current;
 	mm = tsk->mm;
-- 
2.14.4


