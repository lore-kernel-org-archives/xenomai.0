From: "Lennart Sorensen" <lsorense@csclub.uwaterloo.ca>
Date: Mon, 25 May 2015 14:03:16 -0400
Message-ID: <20150525180316.GA4970@csclub.uwaterloo.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [Xenomai] [PATCH v2] Fix arm GIC irq mask calculations
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Len Sorensen <lsorense@csclub.uwaterloo.ca>
Cc: xenomai@xenomai.org

3.14 has made changes to how irqs are handled and ipipe is using the
wrong value to calculate the mask.  Change to the correct value by always
using the access function to get the irq.

This fixes booting with 3.14.39 on the TI AM572x.

Signed-off-by: Len Sorensen <lsorense@csclub.uwaterloo.ca>
---
 drivers/irqchip/irq-gic.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/irqchip/irq-gic.c b/drivers/irqchip/irq-gic.c
index 7a68905..c4ff114 100644
--- a/drivers/irqchip/irq-gic.c
+++ b/drivers/irqchip/irq-gic.c
@@ -155,7 +155,7 @@ static inline unsigned int gic_irq(struct irq_data *d)
  */
 static void gic_mask_irq(struct irq_data *d)
 {
-	u32 mask = 1 << (d->irq % 32);
+	u32 mask = 1 << (gic_irq(d) % 32);
 	unsigned long flags;
 
 	raw_spin_lock_irqsave_cond(&irq_controller_lock, flags);
@@ -168,7 +168,7 @@ static void gic_mask_irq(struct irq_data *d)
 
 static void gic_unmask_irq(struct irq_data *d)
 {
-	u32 mask = 1 << (d->irq % 32);
+	u32 mask = 1 << (gic_irq(d) % 32);
 	unsigned long flags;
 
 	raw_spin_lock_irqsave_cond(&irq_controller_lock, flags);
@@ -195,7 +195,7 @@ static void gic_eoi_irq(struct irq_data *d)
 
 static void gic_hold_irq(struct irq_data *d)
 {
-	u32 mask = 1 << (d->irq % 32);
+	u32 mask = 1 << (gic_irq(d) % 32);
 	unsigned long flags;
 
 	raw_spin_lock_irqsave_cond(&irq_controller_lock, flags);
@@ -211,7 +211,7 @@ static void gic_hold_irq(struct irq_data *d)
 
 static void gic_release_irq(struct irq_data *d)
 {
-	u32 mask = 1 << (d->irq % 32);
+	u32 mask = 1 << (gic_irq(d) % 32);
 	unsigned long flags;
 
 	raw_spin_lock_irqsave_cond(&irq_controller_lock, flags);
-- 
1.7.10.4

