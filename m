Sender: chensong_2000@189.cn
From: Song Chen <chensong_2000@189.cn>
Subject: [PATCH 1/2] y2038: cobalt/posix/mutex: try acquire mutex before
 checking timeout
Date: Wed, 30 Jun 2021 14:32:11 +0800
Message-Id: <1625034731-29827-1-git-send-email-chensong_2000@189.cn>
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: florian.bezdeka@siemens.com, xenomai@xenomai.org

If a preocess is calling mutex_timedlock to acquire resource with
an invalid timeout, mutex_timedlock returns -EFAULT even resource
is available, it doesn't make any sense.

Therefore, this patch tries to acquire mutex before validating timeout,
as a result, the process can lock the mutex immediately if it's
available.

Signed-off-by: Song Chen <chensong_2000@189.cn>
---
 kernel/cobalt/posix/mutex.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/kernel/cobalt/posix/mutex.c b/kernel/cobalt/posix/mutex.c
index 1bd4703..6270520 100644
--- a/kernel/cobalt/posix/mutex.c
+++ b/kernel/cobalt/posix/mutex.c
@@ -167,6 +167,11 @@ redo:
 
 	xnthread_commit_ceiling(curr);
 
+	/*check if resourse is already available*/
+	ret = xnsynch_try_acquire(&mutex->synchbase);
+	if (ret != -EBUSY)
+		goto out;
+
 	if (xnsynch_owner_check(&mutex->synchbase, curr)) {
 		if (fetch_timeout) {
 			xnlock_put_irqrestore(&nklock, s);
-- 
2.7.4


