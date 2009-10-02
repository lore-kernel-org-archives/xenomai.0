From: wolfgang.mauerer@domain.hid
Date: Fri,  2 Oct 2009 10:52:32 +0200
Message-Id: <1254473552-11922-1-git-send-email-wolfgang.mauerer@domain.hid>
Subject: [Xenomai-core] [PATCH] Fix handling of deleted message queue objects
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai@xenomai.org

From: Wolfgang Mauerer <wolfgang.mauerer@domain.hid>

When a Xenomai thread tries to access a deleted
message queue, it should obtain -ESRCH as error code
both from within the kernel and for userland applications.
However, userland sometimes receives wrong error codes
because failure of the handle lookup operation is not
correctly handled, which leads to subsequently different
errors.  This patch fixes the faulty patterns, and also
provides a documentation update.

Signed-off-by: Wolfgang Mauerer <wolfgang.mauerer@domain.hid>
Signed-off-by: Jan Kiszka <jan.kiszka@domain.hid>
Reported-by: Victor Metsch <victor.metsch@domain.hid>
---
 ksrc/skins/native/queue.c   |    2 ++
 ksrc/skins/native/syscall.c |    6 ++++++
 2 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/ksrc/skins/native/queue.c b/ksrc/skins/native/queue.c
index 9878562..c2b05ae 100644
--- a/ksrc/skins/native/queue.c
+++ b/ksrc/skins/native/queue.c
@@ -721,6 +721,8 @@ int rt_queue_send(RT_QUEUE *q, void *mbuf, size_t size, int mode)
  * defined for the queue at creation, or if no memory can be obtained
  * to convey the message data internally.
  *
+ * - -ESRCH is returned if a @a q represents a stale userland handle
+ *
  * Environments:
  *
  * This service can be called from:
diff --git a/ksrc/skins/native/syscall.c b/ksrc/skins/native/syscall.c
index 0860447..f6a4de5 100644
--- a/ksrc/skins/native/syscall.c
+++ b/ksrc/skins/native/syscall.c
@@ -2336,6 +2336,9 @@ static int __rt_queue_write(struct task_struct *curr, struct pt_regs *regs)
 
 	q = (RT_QUEUE *)xnregistry_fetch(ph.opaque);
 
+	if (!q)
+		return -ESRCH;
+
 	/* Buffer to write to the queue. */
 	buf = (void __user *)__xn_reg_arg2(regs);
 
@@ -2453,6 +2456,9 @@ static int __rt_queue_read(struct task_struct *curr, struct pt_regs *regs)
 
 	q = (RT_QUEUE *)xnregistry_fetch(ph.opaque);
 
+	if (!q)
+		return -ESRCH;
+
 	/* Address of message space to write to. */
 	buf = (void __user *)__xn_reg_arg2(regs);
 
-- 
1.6.4


