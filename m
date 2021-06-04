From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [PATCH 11/12] rtdm/fd: move inband work description off the stack
Date: Fri,  4 Jun 2021 12:05:21 +0200
Message-Id: <01fe61c321703e48a8c5e4537fc5a3e7ae6138cc.1622801122.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1622801122.git.jan.kiszka@siemens.com>
References: <cover.1622801122.git.jan.kiszka@siemens.com>
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

Unlike the I-pipe, Dovetail does not copy the work descriptor but
merely hands over the request to the common irq_work() mechanism. We
must guarantee that such descriptor lives in a portion of memory which
won't go stale until the handler has run, which by design can only
happen once the calling out-of-band context unwinds.

Therefore, we have to move the in-band work descriptor used in
triggering fd closure off the stack to a global variable, which is
fine since the action of flushing the lingering fds is globally
scoped.

Signed-off-by: Philippe Gerum <rpm@xenomai.org>
Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 kernel/cobalt/rtdm/fd.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/kernel/cobalt/rtdm/fd.c b/kernel/cobalt/rtdm/fd.c
index 038247d54..151884a24 100644
--- a/kernel/cobalt/rtdm/fd.c
+++ b/kernel/cobalt/rtdm/fd.c
@@ -257,10 +257,6 @@ out:
 }
 EXPORT_SYMBOL_GPL(rtdm_fd_get);
 
-struct lostage_trigger_close {
-	struct pipeline_inband_work inband_work; /* Must be first. */
-};
-
 static int fd_cleanup_thread(void *data)
 {
 	struct rtdm_fd *fd;
@@ -293,9 +289,16 @@ static void lostage_trigger_close(struct pipeline_inband_work *inband_work)
 	up(&rtdm_fd_cleanup_sem);
 }
 
+static struct lostage_trigger_close {
+	struct pipeline_inband_work inband_work; /* Must be first. */
+} fd_closework =  {
+	.inband_work = PIPELINE_INBAND_WORK_INITIALIZER(fd_closework,
+						lostage_trigger_close),
+};
+
 static void __put_fd(struct rtdm_fd *fd, spl_t s)
 {
-	bool destroy;
+	bool destroy, trigger;
 
 	XENO_WARN_ON(COBALT, fd->refs <= 0);
 	destroy = --fd->refs == 0;
@@ -310,16 +313,13 @@ static void __put_fd(struct rtdm_fd *fd, spl_t s)
 	if (is_secondary_domain())
 		fd->ops->close(fd);
 	else {
-		struct lostage_trigger_close closework = {
-			.inband_work = PIPELINE_INBAND_WORK_INITIALIZER(closework,
-					lostage_trigger_close),
-		};
-
 		xnlock_get_irqsave(&fdtree_lock, s);
+		trigger = list_empty(&rtdm_fd_cleanup_queue);
 		list_add_tail(&fd->cleanup, &rtdm_fd_cleanup_queue);
 		xnlock_put_irqrestore(&fdtree_lock, s);
 
-		pipeline_post_inband_work(&closework);
+		if (trigger)
+			pipeline_post_inband_work(&fd_closework);
 	}
 }
 
-- 
2.26.2


