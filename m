From: Andreas Glatz <andreasglatz@domain.hid>
Date: Fri, 12 Feb 2010 18:36:25 -0500
Message-ID: <1266017786-26290-3-git-send-email-andreasglatz@domain.hid>
In-Reply-To: <1266017786-26290-2-git-send-email-andreasglatz@domain.hid>
References: <1266017786-26290-1-git-send-email-andreasglatz@domain.hid>
	<1266017786-26290-2-git-send-email-andreasglatz@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Xenomai-help] [PATCH 2/3] nucleus: Introduced checking of an
	interrupt object before attaching or detaching it.
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai@xenomai.org

Added code to check if an interrupt object is attached/detached
right after calling xnintr_irq_attach()/xnintr_irq_detach() to
avoid re-attaching/detaching and interrupt object.

Now xnintr_destroy() returns the return value of xnintr_detach()
as described in the comment.

Signed-off-by: Andreas Glatz <andreasglatz@domain.hid>
---
 ksrc/nucleus/intr.c |   22 ++++++++++++++++++----
 1 files changed, 18 insertions(+), 4 deletions(-)

diff --git a/ksrc/nucleus/intr.c b/ksrc/nucleus/intr.c
index 50f7945..ace75d5 100644
--- a/ksrc/nucleus/intr.c
+++ b/ksrc/nucleus/intr.c
@@ -426,14 +426,29 @@ static inline xnintr_t *xnintr_shirq_next(xnintr_t *prev)
 
 static inline int xnintr_irq_attach(xnintr_t *intr)
 {
-	return xnarch_hook_irq(intr->irq, &xnintr_irq_handler,
+	int err;
+
+	if (__testbits(intr->flags, XN_ISR_ATTACHED))
+		return -EPERM;
+
+	err = xnarch_hook_irq(intr->irq, &xnintr_irq_handler,
 			       (rthal_irq_ackfn_t)intr->iack, intr);
+
+	if (!err)
+		__setbits(intr->flags, XN_ISR_ATTACHED);
+
+	return err;
 }
 
 static inline int xnintr_irq_detach(xnintr_t *intr)
 {
 	int irq = intr->irq, err;
 
+	if (!__testbits(intr->flags, XN_ISR_ATTACHED))
+		return -EPERM;
+
+	__clrbits(intr->flags, XN_ISR_ATTACHED);
+
 	xnlock_get(&xnirqs[irq].lock);
 	err = xnarch_release_irq(irq);
 	xnlock_put(&xnirqs[irq].lock);
@@ -659,7 +674,7 @@ EXPORT_SYMBOL_GPL(xnintr_init);
  * @param intr The descriptor address of the interrupt object to
  * destroy.
  *
- * @return 0 is returned on success. Otherwise, -EBUSY is returned if
+ * @return 0 is returned on success. Otherwise, -EINVAL is returned if
  * an error occurred while detaching the interrupt (see
  * xnintr_detach()).
  *
@@ -675,8 +690,7 @@ EXPORT_SYMBOL_GPL(xnintr_init);
 
 int xnintr_destroy(xnintr_t *intr)
 {
-	xnintr_detach(intr);
-	return 0;
+	return xnintr_detach(intr);
 }
 EXPORT_SYMBOL_GPL(xnintr_destroy);
 
-- 
1.5.6.5


