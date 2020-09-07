From: Philippe  Gerum <rpm@xenomai.org>
Subject: [PATCH 2/6] ipipe: add fixup call to
 irq_set_[chip_]handler_[name_]locked() helpers
Date: Mon,  7 Sep 2020 15:09:34 +0200
Message-Id: <20200907130938.416831-2-rpm@xenomai.org>
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

The pipeline core must be given an opportunity to fixup the interrupt
descriptor right before a flow handler is assigned to it. To this end,
make sure the irq_set_[chip_]handler_[name_]locked() helpers also call
__fixup_irq_handler().

Signed-off-by: Philippe Gerum <rpm@xenomai.org>
---
 include/linux/irqdesc.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/irqdesc.h b/include/linux/irqdesc.h
index fb38c2163abf..3852c59798d6 100644
--- a/include/linux/irqdesc.h
+++ b/include/linux/irqdesc.h
@@ -208,7 +208,7 @@ static inline void irq_set_handler_locked(struct irq_data *data,
 {
 	struct irq_desc *desc = irq_data_to_desc(data);
 
-	desc->handle_irq = handler;
+	desc->handle_irq = __fixup_irq_handler(desc, handler, 0);
 }
 
 /**
@@ -229,7 +229,7 @@ irq_set_chip_handler_name_locked(struct irq_data *data, struct irq_chip *chip,
 {
 	struct irq_desc *desc = irq_data_to_desc(data);
 
-	desc->handle_irq = handler;
+	desc->handle_irq = __fixup_irq_handler(desc, handler, 0);
 	desc->name = name;
 	data->chip = chip;
 }
-- 
2.26.2


