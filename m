From: Philippe  Gerum <rpm@xenomai.org>
Subject: [PATCH 5/5] cobalt/intr: dovetail: Don't do anything in
 xnintr_enable/disable
Date: Sat, 27 Mar 2021 11:35:24 +0100
Message-Id: <20210327103524.2305814-6-rpm@xenomai.org>
In-Reply-To: <20210327103524.2305814-1-rpm@xenomai.org>
References: <20210327103524.2305814-1-rpm@xenomai.org>
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

From: Jan Kiszka <jan.kiszka@siemens.com>

As we are using regular request/free_irq under dovetail, there is no
extra task to be done in the interrupt enable/disable services. In fact,
calling enable_irq will rather trigger "Unbalanced enable for IRQ ..."
errors.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 kernel/cobalt/dovetail/intr.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/kernel/cobalt/dovetail/intr.c b/kernel/cobalt/dovetail/intr.c
index 068dfe306..d1a1c14a9 100644
--- a/kernel/cobalt/dovetail/intr.c
+++ b/kernel/cobalt/dovetail/intr.c
@@ -109,15 +109,11 @@ EXPORT_SYMBOL_GPL(xnintr_detach);
 
 void xnintr_enable(struct xnintr *intr)
 {
-	secondary_mode_only();
-	enable_irq(intr->irq);
 }
 EXPORT_SYMBOL_GPL(xnintr_enable);
 
 void xnintr_disable(struct xnintr *intr)
 {
-	secondary_mode_only();
-	disable_irq(intr->irq);
 }
 EXPORT_SYMBOL_GPL(xnintr_disable);
 
-- 
2.29.2


