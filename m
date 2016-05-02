From: "Lennart Sorensen" <lsorense@csclub.uwaterloo.ca>
Date: Mon, 2 May 2016 15:05:57 -0400
Message-ID: <20160502190557.GK2055@csclub.uwaterloo.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [Xenomai] [PATCH] arm/ipipe: irq-crossbar: Fix NULL pointer
	dereference
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

arm/ipipe: irq-crossbar: Fix NULL pointer dereference

The TI irq-crossbar driver needs to declare the irq_hold and irq_release
functions, otherwise IPIPE will dereference a NULL pointer.

Tested on AM5728.

Signed-off-by: Len Sorensen <lsorense@csclub.uwaterloo.ca>

diff --git a/drivers/irqchip/irq-crossbar.c b/drivers/irqchip/irq-crossbar.c
index c12bb93..8bb1af7 100644
--- a/drivers/irqchip/irq-crossbar.c
+++ b/drivers/irqchip/irq-crossbar.c
@@ -15,6 +15,7 @@
 #include <linux/of_address.h>
 #include <linux/of_irq.h>
 #include <linux/slab.h>
+#include <linux/ipipe.h>
 
 #include "irqchip.h"
 
@@ -74,6 +75,10 @@ static struct irq_chip crossbar_chip = {
 #ifdef CONFIG_SMP
 	.irq_set_affinity	= irq_chip_set_affinity_parent,
 #endif
+#ifdef CONFIG_IPIPE
+	.irq_hold		= irq_chip_hold_parent,
+	.irq_release		= irq_chip_release_parent,
+#endif
 };
 
 static int allocate_gic_irq(struct irq_domain *domain, unsigned virq,

-- 
Len Sorensen

