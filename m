From: Philippe  Gerum <rpm@xenomai.org>
Subject: [PATCH 4/4] genirq: irq_pipeline: fix inverted check in debug
 assertion
Date: Sat, 31 Jul 2021 11:49:34 +0200
Message-Id: <20210731094934.1799307-5-rpm@xenomai.org>
In-Reply-To: <20210731094934.1799307-1-rpm@xenomai.org>
References: <20210731094934.1799307-1-rpm@xenomai.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

From: Philippe Gerum <rpm@xenomai.org>

Signed-off-by: Philippe Gerum <rpm@xenomai.org>
---
 kernel/irq/pipeline.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/kernel/irq/pipeline.c b/kernel/irq/pipeline.c
index 090fcc8bbb6a449..585bd3b6fae5ef4 100644
--- a/kernel/irq/pipeline.c
+++ b/kernel/irq/pipeline.c
@@ -1076,15 +1076,15 @@ int generic_pipeline_irq(unsigned int irq, struct pt_regs *regs)
 			pr_err("IRQ pipeline: interrupts enabled on entry (IRQ%u)\n",
 			       irq);
 		}
+
 		/*
 		 * Running with the oob stage stalled implies hardirqs
 		 * off.  For this reason, if the oob stage is stalled
-		 * on pipeline entry but we still receive an interrupt
-		 * from the hardware, something is badly broken in our
-		 * interrupt state. Try fixing up, but without great
-		 * hopes.
+		 * when we receive an interrupt from the hardware,
+		 * something is badly broken in our interrupt
+		 * state. Try fixing up, but without great hopes.
 		 */
-		if (on_pipeline_entry() && test_oob_stall()) {
+		if (!on_pipeline_entry() && test_oob_stall()) {
 			pr_err("IRQ pipeline: out-of-band stage stalled on IRQ entry\n");
 			unstall_oob();
 		}
-- 
2.31.1


