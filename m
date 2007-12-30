From: Paul <paul_c@domain.hid>
Date: Sun, 30 Dec 2007 20:29:59 +0000
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_H//dHxdxrs3uobp"
Message-Id: <200712302029.59827.paul_c@domain.hid>
Subject: [Adeos-main] [PATCH] printk documentation
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: </public/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: adeos-main <adeos-main@gna.org>

--Boundary-00=_H//dHxdxrs3uobp
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


Hi Philippe

Running some full kernel package builds with 2.6.23 & Xenomai v2.4.x, and once 
again hit a problem I reported in May[1] - This issue as crept back in 
causing the kernel documentation targets to fail.

 Patch attached to resolve the problem.


Regards, Paul.



[1] https://mail.gna.org/public/adeos-main/2007-05/msg00034.html



--Boundary-00=_H//dHxdxrs3uobp
Content-Type: text/x-diff;
  charset="us-ascii";
  name="ipipe_printk.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="ipipe_printk.patch"

---
 kernel/printk.c |   40 ++++++++++++++++++++--------------------
 1 files changed, 20 insertions(+), 20 deletions(-)

diff --git a/kernel/printk.c b/kernel/printk.c
index 6b49827..a50b8ea 100644
--- a/kernel/printk.c
+++ b/kernel/printk.c
@@ -479,29 +479,6 @@ static int have_callable_console(void)
 	return 0;
 }
 
-/**
- * printk - print a kernel message
- * @fmt: format string
- *
- * This is printk().  It can be called from any context.  We want it to work.
- * Be aware of the fact that if oops_in_progress is not set, we might try to
- * wake klogd up which could deadlock on runqueue lock if printk() is called
- * from scheduler code.
- *
- * We try to grab the console_sem.  If we succeed, it's easy - we log the output and
- * call the console drivers.  If we fail to get the semaphore we place the output
- * into the log buffer and return.  The current holder of the console_sem will
- * notice the new output in release_console_sem() and will send it to the
- * consoles before releasing the semaphore.
- *
- * One effect of this deferred printing is that code which calls printk() and
- * then changes console_loglevel may break. This is because console_loglevel
- * is inspected when the actual printing occurs.
- *
- * See also:
- * printf(3)
- */
-
 #ifdef CONFIG_IPIPE
 
 static ipipe_spinlock_t __ipipe_printk_lock = IPIPE_SPIN_LOCK_UNLOCKED;
@@ -534,6 +514,29 @@ void __ipipe_flush_printk (unsigned virq, void *cookie)
 	spin_unlock_irqrestore(&__ipipe_printk_lock, flags);
 }
 
+/**
+ * printk - print a kernel message
+ * @fmt: format string
+ *
+ * This is printk().  It can be called from any context.  We want it to work.
+ * Be aware of the fact that if oops_in_progress is not set, we might try to
+ * wake klogd up which could deadlock on runqueue lock if printk() is called
+ * from scheduler code.
+ *
+ * We try to grab the console_sem.  If we succeed, it's easy - we log the output and
+ * call the console drivers.  If we fail to get the semaphore we place the output
+ * into the log buffer and return.  The current holder of the console_sem will
+ * notice the new output in release_console_sem() and will send it to the
+ * consoles before releasing the semaphore.
+ *
+ * One effect of this deferred printing is that code which calls printk() and
+ * then changes console_loglevel may break. This is because console_loglevel
+ * is inspected when the actual printing occurs.
+ *
+ * See also:
+ * printf(3)
+ */
+
 asmlinkage int printk(const char *fmt, ...)
 {
 	int r, fbytes, oldcount, cs = -1;
-- 
1.4.4.4


--Boundary-00=_H//dHxdxrs3uobp--

