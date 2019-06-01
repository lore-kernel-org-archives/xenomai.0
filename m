From: Philippe Gerum <rpm@xenomai.org>
Subject: [PATCH 7/8] cobalt/thread: fix error status (-EINTR) of
 xnthread_killall()
Date: Sat,  1 Jun 2019 17:15:01 +0200
Message-Id: <20190601151502.27216-8-rpm@xenomai.org>
In-Reply-To: <20190601151502.27216-1-rpm@xenomai.org>
References: <20190601151502.27216-1-rpm@xenomai.org>
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
Cc: Jan Kiszka <jan.kiszka@siemens.com>, Philippe Gerum <rpm@xenomai.org>

Signed-off-by: Philippe Gerum <rpm@xenomai.org>
---
 kernel/cobalt/thread.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/kernel/cobalt/thread.c b/kernel/cobalt/thread.c
index 6caf9ef37..2f1988061 100644
--- a/kernel/cobalt/thread.c
+++ b/kernel/cobalt/thread.c
@@ -2588,7 +2588,7 @@ int xnthread_killall(int grace, int mask)
 	xnlock_get_irqsave(&nklock, s);
 
 	nrthreads = cobalt_nrthreads;
-	
+
 	xnsched_for_each_thread(t) {
 		if (xnthread_test_state(t, XNROOT) ||
 		    xnthread_test_state(t, mask) != mask ||
@@ -2632,10 +2632,10 @@ int xnthread_killall(int grace, int mask)
 		printk(XENO_INFO "joined %d threads\n",
 		       count + nrkilled - cobalt_nrthreads);
 
-	return ret < 0 ? EINTR : 0;
+	return ret < 0 ? -EINTR : 0;
 }
 EXPORT_SYMBOL_GPL(xnthread_killall);
-		     
+
 /* Xenomai's generic personality. */
 struct xnthread_personality xenomai_personality = {
 	.name = "core",
-- 
2.20.1


