From: Florian Bezdeka <florian.bezdeka@siemens.com>
Subject: [PATCH] ipipe: x86: Suppress unexpected trap warning for racing APIC
 vectors
Date: Fri, 25 Feb 2022 09:41:43 +0100
Message-Id: <20220225084143.3277493-1-florian.bezdeka@siemens.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
MIME-Version: 1.0
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

It might happen that the APIC vector in flight has already been shut
down by the device driver. In such a race it's still an unexpected
trap, but nothing we should warn about. Checking the vector error
state upfront avoids confusion.

This is what do_IRQ() would do as well, in a slightly simplified way.
Both code paths are synchronized now, including the printk rate
limiting.

Re-setting the vector to the VECTOR_UNUSED state helps to detect
spurious interrupts in case the vector is re-triggered several times.

Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
---
 arch/x86/kernel/ipipe.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/ipipe.c b/arch/x86/kernel/ipipe.c
index 81e0889a8298..63c6dc683ed3 100644
--- a/arch/x86/kernel/ipipe.c
+++ b/arch/x86/kernel/ipipe.c
@@ -471,7 +471,14 @@ static inline int __ipipe_irq_from_vector(int vector, int *irq)
 #ifdef CONFIG_X86_LOCAL_APIC
 	__ack_APIC_irq();
 #endif
-	pr_err("unexpected IRQ trap at vector %#x\n", vector);
+
+	if (desc == VECTOR_UNUSED) {
+		pr_emerg_ratelimited("%s: %d.%d Unexpected IRQ trap\n",
+				     __func__, smp_processor_id(), vector);
+	} else {
+		__this_cpu_write(vector_irq[vector], VECTOR_UNUSED);
+	}
+
 	return -1;
 }
 
-- 
2.30.2


