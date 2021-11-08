From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [dovetail][PATCH] x86: irq_pipeline: Fix condition for !IRQ_PIPELINE
 case
Message-ID: <de62d40c-3304-a40e-dee1-465b1cc85a9d@siemens.com>
Date: Mon, 8 Nov 2021 09:50:15 +0100
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
To: Philippe Gerum <rpm@xenomai.org>
Cc: Xenomai <xenomai@xenomai.org>

From: Jan Kiszka <jan.kiszka@siemens.com>

This code is already under CONFIG_SMP: The comment got it right, not yet
the implementation. Only affects the pipeline-off case.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 arch/x86/kernel/apic/vector.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/apic/vector.c b/arch/x86/kernel/apic/vector.c
index 2df8681904f6..829409a1e6dd 100644
--- a/arch/x86/kernel/apic/vector.c
+++ b/arch/x86/kernel/apic/vector.c
@@ -814,7 +814,7 @@ static struct irq_desc *__setup_vector_irq(int vector)
 	int isairq = vector - ISA_IRQ_VECTOR(0);
 
 	/* Copy the cleanup vector if irqs are pipelined. */
-	if (IS_ENABLED(CONFIG_SMP) &&
+	if (IS_ENABLED(CONFIG_IRQ_PIPELINE) &&
 		vector == IRQ_MOVE_CLEANUP_VECTOR)
 		return irq_to_desc(IRQ_MOVE_CLEANUP_VECTOR); /* 1:1 mapping */
 	/* Check whether the irq is in the legacy space */
-- 
2.31.1

