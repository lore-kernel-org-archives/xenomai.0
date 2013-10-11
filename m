Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Message-Id: <3426cfa7bb3a21b9b4cb.1381471566@devws164.be.alcatel-lucent.com>
Date: Fri, 11 Oct 2013 08:06:06 +0200
From: Kim De Mey <kim.demey@gmail.com>
Subject: [Xenomai] [PATCH] Xenomai-forge pSOS task: Allow event send to self
 (current task)
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Support 0 as value for the tid parameter in ev_send.
This then sends the event to the current task.

Signed-off-by: Kim De Mey <kim.demey@gmail.com>

---
Hello,

I believe this is existing functionality in Xenomai.
Would it be possible to add this in Xenomai-forge?

Kim

diff --git a/lib/psos/task.c b/lib/psos/task.c
--- a/lib/psos/task.c
+++ b/lib/psos/task.c
@@ -672,7 +672,7 @@ u_long ev_send(u_long tid, u_long events
 	struct service svc;
 	int ret = SUCCESS;
 
-	task = find_psos_task(tid, &ret);
+	task = find_psos_task_or_self(tid, &ret);
 	if (task == NULL)
 		return ret;
 

