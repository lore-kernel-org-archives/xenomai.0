From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [PATCH] cobalt/intr: dovetail: Don't do anything in
 xnintr_enable/disable
Message-ID: <3e14dd42-dd1f-fdf7-2f83-ba6b667c1cd8@siemens.com>
Date: Thu, 18 Mar 2021 18:30:10 +0100
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
To: Xenomai <xenomai@xenomai.org>, Philippe Gerum <rpm@xenomai.org>

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
index 068dfe306e..d1a1c14a91 100644
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
2.26.2

