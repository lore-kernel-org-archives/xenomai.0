Message-ID: <4533541B.6060108@domain.hid>
Date: Mon, 16 Oct 2006 11:42:51 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------050800030206070409060005"
Sender: jan.kiszka@domain.hid
Subject: [Xenomai-core] [PATCH] avoid installing inappropriate IRQ dispatcher
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai-core <xenomai@xenomai.org>

This is a multi-part message in MIME format.
--------------050800030206070409060005
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit

In the (corner) case that someone requests to install a shared edge IRQ
while the related support is not enabled (!CONFIG_XENO_OPT_SHIRQ_EDGE),
BUT the opposite type (CONFIG_XENO_OPT_SHIRQ_LEVEL), Xenomai so far
incorrectly installs the level-type handler. For the other way around,
the non-shared dispatch handler is installed, which is also not correct.

This patch fixes the issue by returning an error on registration,
clearly indicating the system misconfiguration to the caller.

Jan

--------------050800030206070409060005
Content-Type: text/plain;
 name="pick-shared-irq-handler.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="pick-shared-irq-handler.patch"

---
 ChangeLog           |    5 +++++
 ksrc/nucleus/intr.c |   15 ++++++++++-----
 2 files changed, 15 insertions(+), 5 deletions(-)

Index: ksrc/nucleus/intr.c
===================================================================
--- ksrc/nucleus/intr.c.orig
+++ ksrc/nucleus/intr.c
@@ -340,14 +340,19 @@ static inline int xnintr_irq_attach(xnin
 		void (*handler) (unsigned, void *) = &xnintr_irq_handler;
 
 		if (intr->flags & XN_ISR_SHARED) {
-#if defined(CONFIG_XENO_OPT_SHIRQ_LEVEL)
-			handler = &xnintr_shirq_handler;
-#endif /* CONFIG_XENO_OPT_SHIRQ_LEVEL */
-
-#if defined(CONFIG_XENO_OPT_SHIRQ_EDGE)
 			if (intr->flags & XN_ISR_EDGE)
+#if defined(CONFIG_XENO_OPT_SHIRQ_EDGE)
 				handler = &xnintr_edge_shirq_handler;
+#else /* !CONFIG_XENO_OPT_SHIRQ_EDGE */
+				return -ENOSYS;
 #endif /* CONFIG_XENO_OPT_SHIRQ_EDGE */
+			else
+#if defined(CONFIG_XENO_OPT_SHIRQ_LEVEL)
+				handler = &xnintr_shirq_handler;
+#else /* !CONFIG_XENO_OPT_SHIRQ_LEVEL */
+				return -ENOSYS;
+#endif /* CONFIG_XENO_OPT_SHIRQ_LEVEL */
+
 		}
 		shirq->unhandled = 0;
 
Index: ChangeLog
===================================================================
--- ChangeLog.orig
+++ ChangeLog
@@ -1,3 +1,8 @@
+2006-10-16  Jan Kiszka  <jan.kiszka@domain.hid>
+
+	* ksrc/nucleus/intr.x (xnintr_irq_attach): Return error on
+	mismatching shared-IRQ support.
+
 2006-10-15  Philippe Gerum  <rpm@xenomai.org>
 
 	* ksrc/arch/powerpc/patches: Upgrade to 2.6.14-ppc-1.5-00.

--------------050800030206070409060005--

