From: Philippe  Gerum <rpm@xenomai.org>
Subject: [PATCH 6/6] ipipe: rename __fixup_irq_handler() to
 __ipipe_setup_irq_desc()
Date: Mon,  7 Sep 2020 15:09:38 +0200
Message-Id: <20200907130938.416831-6-rpm@xenomai.org>
In-Reply-To: <20200907130938.416831-1-rpm@xenomai.org>
References: <20200907130938.416831-1-rpm@xenomai.org>
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

To clarify naming and purpose: this is a pipeline-specific routine,
which further prepares an interrupt descriptor for receiving events
for the most part, swapping the interrupt flow handler specifically
for chained IRQs (not the interrupt handler per se).

Signed-off-by: Philippe Gerum <rpm@xenomai.org>
---
 include/linux/irqdesc.h | 8 ++++----
 kernel/irq/chip.c       | 8 ++++----
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/include/linux/irqdesc.h b/include/linux/irqdesc.h
index 3852c59798d6..121ad0f9c5ea 100644
--- a/include/linux/irqdesc.h
+++ b/include/linux/irqdesc.h
@@ -185,8 +185,8 @@ static inline int irq_desc_has_action(struct irq_desc *desc)
 }
 
 irq_flow_handler_t
-__fixup_irq_handler(struct irq_desc *desc, irq_flow_handler_t handle,
-		    int is_chained);
+__ipipe_setup_irq_desc(struct irq_desc *desc, irq_flow_handler_t handle,
+		int is_chained);
 
 static inline int irq_has_action(unsigned int irq)
 {
@@ -208,7 +208,7 @@ static inline void irq_set_handler_locked(struct irq_data *data,
 {
 	struct irq_desc *desc = irq_data_to_desc(data);
 
-	desc->handle_irq = __fixup_irq_handler(desc, handler, 0);
+	desc->handle_irq = __ipipe_setup_irq_desc(desc, handler, 0);
 }
 
 /**
@@ -229,7 +229,7 @@ irq_set_chip_handler_name_locked(struct irq_data *data, struct irq_chip *chip,
 {
 	struct irq_desc *desc = irq_data_to_desc(data);
 
-	desc->handle_irq = __fixup_irq_handler(desc, handler, 0);
+	desc->handle_irq = __ipipe_setup_irq_desc(desc, handler, 0);
 	desc->name = name;
 	data->chip = chip;
 }
diff --git a/kernel/irq/chip.c b/kernel/irq/chip.c
index 7c03e2931189..8d56c2fb2f10 100644
--- a/kernel/irq/chip.c
+++ b/kernel/irq/chip.c
@@ -1034,7 +1034,7 @@ static void __ipipe_ack_bad_irq(struct irq_desc *desc)
 }
 
 irq_flow_handler_t
-__fixup_irq_handler(struct irq_desc *desc, irq_flow_handler_t handle, int is_chained)
+__ipipe_setup_irq_desc(struct irq_desc *desc, irq_flow_handler_t handle, int is_chained)
 {
 	if (unlikely(handle == NULL)) {
 		desc->ipipe_ack = __ipipe_ack_bad_irq;
@@ -1134,13 +1134,13 @@ EXPORT_SYMBOL_GPL(ipipe_enable_irq);
 #else /* !CONFIG_IPIPE */
 
 irq_flow_handler_t
-__fixup_irq_handler(struct irq_desc *desc, irq_flow_handler_t handle, int is_chained)
+__ipipe_setup_irq_desc(struct irq_desc *desc, irq_flow_handler_t handle, int is_chained)
 {
 	return handle;
 }
 
 #endif /* !CONFIG_IPIPE */
-EXPORT_SYMBOL_GPL(__fixup_irq_handler);
+EXPORT_SYMBOL_GPL(__ipipe_setup_irq_desc);
 
 static void
 __irq_do_set_handler(struct irq_desc *desc, irq_flow_handler_t handle,
@@ -1176,7 +1176,7 @@ __irq_do_set_handler(struct irq_desc *desc, irq_flow_handler_t handle,
 			return;
 	}
 
-	handle = __fixup_irq_handler(desc, handle, is_chained);
+	handle = __ipipe_setup_irq_desc(desc, handle, is_chained);
 
 	/* Uninstall? */
 	if (handle == handle_bad_irq) {
-- 
2.26.2


