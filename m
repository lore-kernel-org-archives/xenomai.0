From: Paul <paul_c@domain.hid>
Date: Tue, 29 May 2007 12:40:31 +0100
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_vEBXGa/VbxWc2uv"
Message-Id: <200705291240.31970.paul_c@domain.hid>
Subject: [Adeos-main] printk docbook patch
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: </public/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: adeos-main <adeos-main@gna.org>

--Boundary-00=_vEBXGa/VbxWc2uv
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


Whilst generating some documentation with the mandocs target, I hit an error:

Error(/tmp/linux-2.6.20//kernel/printk.c:504): cannot understand 
prototype: 'ipipe_spinlock_t __ipipe_printk_lock = 
IPIPE_SPIN_LOCK_UNLOCKED; '
make[1]: *** [Documentation/DocBook/kernel-api.xml] Error 1
make: *** [mandocs] Error 2


It would appear that the __ipipe_* stuff between the printk function body and 
it's corresponding documentation upsets docbook. The attached patch proposes 
one fix for this problem (looks like it affects all arches).


Regards, Paul.



--Boundary-00=_vEBXGa/VbxWc2uv
Content-Type: text/x-diff;
  charset="us-ascii";
  name="printk-noarch.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="printk-noarch.patch"

---
 kernel/printk.c |   40 ++++++++++++++++++++--------------------
 1 files changed, 20 insertions(+), 20 deletions(-)

diff --git a/kernel/printk.c b/kernel/printk.c
index 6b49827..a50b8ea 100644
--- a/kernel/printk.c
+++ b/kernel/printk.c
@@ -479,26 +479,6 @@ static int have_callable_console(void)
 	return 0;
 }
 
-/**
- * printk - print a kernel message
- * @fmt: format string
- *
- * This is printk.  It can be called from any context.  We want it to work.
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
@@ -534,6 +514,26 @@ void __ipipe_flush_printk (unsigned virq, void *cookie)
 	spin_unlock_irqrestore(&__ipipe_printk_lock, flags);
 }
 
+/**
+ * printk - print a kernel message
+ * @fmt: format string
+ *
+ * This is printk.  It can be called from any context.  We want it to work.
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
 	int r, fbytes, oldcount;
-- 
1.4.4.4


--Boundary-00=_vEBXGa/VbxWc2uv--

