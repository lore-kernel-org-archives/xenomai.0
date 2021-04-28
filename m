From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [RFC][PATCH] dovetail: intr: Clear affinity_hint before freeing the
 IRQ
Message-ID: <784326e6-10d5-08b3-6dd6-ad830d3931c2@siemens.com>
Date: Wed, 28 Apr 2021 15:51:01 +0200
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
To: Xenomai <xenomai@xenomai.org>

From: Jan Kiszka <jan.kiszka@siemens.com>

We are setting it on xnintr_attach(), and Linux seems to dislike when it
is non-NULL on free_irq().

__free_irq():
...
        /* make sure affinity_hint is cleaned up */
        if (WARN_ON_ONCE(desc->affinity_hint))
                desc->affinity_hint = NULL;

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---

Only seen this now, with a plain rtdm_irq_request/free pattern, and I'm 
still wondering why this was missed so far - therefore RFC.

 kernel/cobalt/dovetail/intr.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/cobalt/dovetail/intr.c b/kernel/cobalt/dovetail/intr.c
index d1a1c14a91..60d5bf882c 100644
--- a/kernel/cobalt/dovetail/intr.c
+++ b/kernel/cobalt/dovetail/intr.c
@@ -103,6 +103,7 @@ EXPORT_SYMBOL_GPL(xnintr_attach);
 void xnintr_detach(struct xnintr *intr)
 {
 	secondary_mode_only();
+	irq_set_affinity_hint(intr->irq, NULL);
 	free_irq(intr->irq, intr);
 }
 EXPORT_SYMBOL_GPL(xnintr_detach);
-- 
2.26.2

