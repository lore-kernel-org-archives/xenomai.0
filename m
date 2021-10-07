From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [PATCH] cobalt/posix/thread: Properly discard xnthread on
 registration error
Message-ID: <a9a6f864-4c7c-48b2-773f-92a53e172e0d@siemens.com>
Date: Thu, 7 Oct 2021 15:56:13 +0200
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

This left timers and possibly other resources registers while freeing
the object. The resulting crash was easily triggerable by creating
threads until the registry was full.

Reported-by: Henning Schild <henning.schild@siemens.com>
Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 kernel/cobalt/posix/thread.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/cobalt/posix/thread.c b/kernel/cobalt/posix/thread.c
index cdeb66d4f3..94a6e394e1 100644
--- a/kernel/cobalt/posix/thread.c
+++ b/kernel/cobalt/posix/thread.c
@@ -399,6 +399,7 @@ static int pthread_create(struct cobalt_thread **thread_p,
 	if (ret) {
 		xnsynch_destroy(&thread->monitor_synch);
 		xnsynch_destroy(&thread->sigwait);
+		__xnthread_discard(&thread->threadbase);
 		xnfree(thread);
 		return ret;
 	}
-- 
2.31.1

