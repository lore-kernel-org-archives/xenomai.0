From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [PATCH] cobalt/autotune: Rework autotune_ioctl_nrt/rt for more robust
 request handling
Message-ID: <81b7d4ea-6abe-31c1-8242-52e9fd7bb280@siemens.com>
Date: Fri, 13 Sep 2019 20:35:07 +0200
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

Do not trigger any activity before a correct request has been
identified, do not copy data from user space as well. Account for races
between parallel IOCTL calls on the same device when changing or using
the tuner reference.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 kernel/drivers/autotune/autotune.c | 66 ++++++++++++++++++++++++++------------
 1 file changed, 45 insertions(+), 21 deletions(-)

diff --git a/kernel/drivers/autotune/autotune.c b/kernel/drivers/autotune/autotune.c
index e0420aa0e1..469e628691 100644
--- a/kernel/drivers/autotune/autotune.c
+++ b/kernel/drivers/autotune/autotune.c
@@ -17,6 +17,7 @@
  * along with this program; if not, write to the Free Software
  * Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.
  */
+#include <linux/atomic.h>
 #include <linux/init.h>
 #include <linux/slab.h>
 #include <linux/kernel.h>
@@ -79,6 +80,7 @@ struct gravity_tuner {
 	int quiet;
 	struct tuning_score scores[AUTOTUNE_STEPS];
 	int nscores;
+	atomic_t refcount;
 };
 
 struct irq_gravity_tuner {
@@ -103,12 +105,14 @@ struct uthread_gravity_tuner {
 struct autotune_context {
 	struct gravity_tuner *tuner;
 	struct autotune_setup setup;
+	rtdm_lock_t tuner_lock;
 };
 
 static inline void init_tuner(struct gravity_tuner *tuner)
 {
 	rtdm_event_init(&tuner->done, 0);
 	tuner->status = 0;
+	atomic_set(&tuner->refcount, 0);
 }
 
 static inline void destroy_tuner(struct gravity_tuner *tuner)
@@ -643,28 +647,14 @@ static int autotune_ioctl_nrt(struct rtdm_fd *fd, unsigned int request, void *ar
 {
 	struct autotune_context *context;
 	struct autotune_setup setup;
-	struct gravity_tuner *tuner;
+	struct gravity_tuner *tuner, *old_tuner;
+	rtdm_lockctx_t lock_ctx;
 	int ret;
 
-	if (request == AUTOTUNE_RTIOC_RESET) {
+	switch (request) {
+	case AUTOTUNE_RTIOC_RESET:
 		xnclock_reset_gravity(&nkclock);
 		return 0;
-	}
-
-	ret = rtdm_copy_from_user(fd, &setup, arg, sizeof(setup));
-	if (ret)
-		return ret;
-
-	context = rtdm_fd_to_private(fd);
-
-	/* Clear previous tuner. */
-	tuner = context->tuner;
-	if (tuner) {
-		tuner->destroy_tuner(tuner);
-		context->tuner = NULL;
-	}
-
-	switch (request) {
 	case AUTOTUNE_RTIOC_IRQ:
 		tuner = &irq_tuner.tuner;
 		break;
@@ -678,13 +668,33 @@ static int autotune_ioctl_nrt(struct rtdm_fd *fd, unsigned int request, void *ar
 		return -EINVAL;
 	}
 
+	ret = rtdm_copy_from_user(fd, &setup, arg, sizeof(setup));
+	if (ret)
+		return ret;
+
 	ret = tuner->init_tuner(tuner);
 	if (ret)
 		return ret;
 
+	context = rtdm_fd_to_private(fd);
+
+	rtdm_lock_get_irqsave(&context->tuner_lock, lock_ctx);
+
+	old_tuner = context->tuner;
+	if (old_tuner && atomic_read(&old_tuner->refcount) > 0) {
+		rtdm_lock_put_irqrestore(&context->tuner_lock, lock_ctx);
+		tuner->destroy_tuner(tuner);
+		return -EBUSY;
+	}
+
 	context->tuner = tuner;
 	context->setup = setup;
 
+	rtdm_lock_put_irqrestore(&context->tuner_lock, lock_ctx);
+
+	if (old_tuner)
+		old_tuner->destroy_tuner(old_tuner);
+
 	if (setup.quiet <= 1)
 		printk(XENO_INFO "autotune(%s) started\n", tuner->name);
 
@@ -695,12 +705,21 @@ static int autotune_ioctl_rt(struct rtdm_fd *fd, unsigned int request, void *arg
 {
 	struct autotune_context *context;
 	struct gravity_tuner *tuner;
+	rtdm_lockctx_t lock_ctx;
 	__u64 timestamp;
 	__u32 gravity;
 	int ret;
 
 	context = rtdm_fd_to_private(fd);
+
+	rtdm_lock_get_irqsave(&context->tuner_lock, lock_ctx);
+
 	tuner = context->tuner;
+	if (tuner)
+		atomic_inc(&tuner->refcount);
+
+	rtdm_lock_put_irqrestore(&context->tuner_lock, lock_ctx);
+
 	if (tuner == NULL)
 		return -ENOSYS;
 
@@ -716,18 +735,22 @@ static int autotune_ioctl_rt(struct rtdm_fd *fd, unsigned int request, void *arg
 					     sizeof(gravity));
 		break;
 	case AUTOTUNE_RTIOC_PULSE:
-		if (tuner != &uthread_tuner.tuner)
-			return -EINVAL;
+		if (tuner != &uthread_tuner.tuner) {
+			ret = -EINVAL;
+			break;
+		}
 		ret = rtdm_safe_copy_from_user(fd, &timestamp, arg,
 					       sizeof(timestamp));
 		if (ret)
-			return ret;
+			break;
 		ret = add_uthread_sample(tuner, timestamp);
 		break;
 	default:
 		ret = -ENOSYS;
 	}
 
+	atomic_dec(&tuner->refcount);
+
 	return ret;
 }
 
@@ -737,6 +760,7 @@ static int autotune_open(struct rtdm_fd *fd, int oflags)
 
 	context = rtdm_fd_to_private(fd);
 	context->tuner = NULL;
+	rtdm_lock_init(&context->tuner_lock);
 
 	return 0;
 }
-- 
2.16.4

