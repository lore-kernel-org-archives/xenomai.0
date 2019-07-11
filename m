From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [PATCH v2 4/6] ipipe: Let ipipe_enable_irq return an error code
Date: Thu, 11 Jul 2019 21:56:15 +0200
Message-Id: <9ab38b7eb54ba7c27d4191da667f39737e25c9e9.1562874977.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1562874977.git.jan.kiszka@siemens.com>
References: <cover.1562874977.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1562874977.git.jan.kiszka@siemens.com>
References: <cover.1562874977.git.jan.kiszka@siemens.com>
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Philippe Gerum <rpm@xenomai.org>
Cc: xenomai@xenomai.org

From: Jan Kiszka <jan.kiszka@siemens.com>

It's time to let ipipe_enable_irq return a proper error as it will gain
another function that may fail. Drop the WARN_ON_ONCE in favor of that.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 include/linux/ipipe.h |  2 +-
 kernel/irq/chip.c     | 12 +++++++-----
 2 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/include/linux/ipipe.h b/include/linux/ipipe.h
index b8a80eeade4f..f7c07a207093 100644
--- a/include/linux/ipipe.h
+++ b/include/linux/ipipe.h
@@ -475,7 +475,7 @@ static inline struct ipipe_threadinfo *ipipe_current_threadinfo(void)
 
 #define ipipe_task_threadinfo(p) (&task_thread_info(p)->ipipe_data)
 
-void ipipe_enable_irq(unsigned int irq);
+int ipipe_enable_irq(unsigned int irq);
 
 static inline void ipipe_disable_irq(unsigned int irq)
 {
diff --git a/kernel/irq/chip.c b/kernel/irq/chip.c
index 6c279e065879..65d345b727be 100644
--- a/kernel/irq/chip.c
+++ b/kernel/irq/chip.c
@@ -1082,7 +1082,7 @@ __fixup_irq_handler(struct irq_desc *desc, irq_flow_handler_t handle, int is_cha
 	return handle;
 }
 
-void ipipe_enable_irq(unsigned int irq)
+int ipipe_enable_irq(unsigned int irq)
 {
 	struct irq_desc *desc;
 	struct irq_chip *chip;
@@ -1090,7 +1090,7 @@ void ipipe_enable_irq(unsigned int irq)
 
 	desc = irq_to_desc(irq);
 	if (desc == NULL)
-		return;
+		return -EINVAL;
 
 	chip = irq_desc_get_chip(desc);
 
@@ -1105,16 +1105,18 @@ void ipipe_enable_irq(unsigned int irq)
 		}
 		raw_spin_unlock_irqrestore(&desc->lock, flags);
 
-		return;
+		return 0;
 	}
 
-	if (WARN_ON_ONCE(chip->irq_enable == NULL && chip->irq_unmask == NULL))
-		return;
+	if (chip->irq_enable == NULL && chip->irq_unmask == NULL)
+		return -ENOSYS;
 
 	if (chip->irq_enable)
 		chip->irq_enable(&desc->irq_data);
 	else
 		chip->irq_unmask(&desc->irq_data);
+
+	return 0;
 }
 EXPORT_SYMBOL_GPL(ipipe_enable_irq);
 
-- 
2.16.4


