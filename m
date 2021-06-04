From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [PATCH 07/12] cobalt/kevents: dovetail: unregister thread resuming
 from ptrace stop
Date: Fri,  4 Jun 2021 12:05:17 +0200
Message-Id: <3c478d4b367fa8a02f20815876f30bde8faf3a29.1622801122.git.jan.kiszka@siemens.com>
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

Signed-off-by: Philippe Gerum <rpm@xenomai.org>
[Jan: style fix]
Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 kernel/cobalt/dovetail/kevents.c | 21 +++++++++++++--------
 1 file changed, 13 insertions(+), 8 deletions(-)

diff --git a/kernel/cobalt/dovetail/kevents.c b/kernel/cobalt/dovetail/kevents.c
index df5408ccc..164ab9461 100644
--- a/kernel/cobalt/dovetail/kevents.c
+++ b/kernel/cobalt/dovetail/kevents.c
@@ -481,14 +481,19 @@ int handle_ptrace_resume(struct task_struct *tracee)
 
 static void handle_ptrace_cont(void)
 {
-	/*
-	 * This is the place where the ptrace-related work which used
-	 * to happen in handle_schedule_event() should go. We are
-	 * called when current is resuming execution after a ptrace
-	 * stopped state, which is what look for in
-	 * handle_schedule_event().
-	 */
-	TODO();
+	struct xnthread *curr = xnthread_current();
+	spl_t s;
+
+	xnlock_get_irqsave(&nklock, s);
+
+	if (xnthread_test_state(curr, XNSSTEP)) {
+		if (!xnthread_test_info(curr, XNCONTHI))
+			unregister_debugged_thread(curr);
+
+		xnthread_set_localinfo(curr, XNHICCUP);
+	}
+
+	xnlock_put_irqrestore(&nklock, s);
 }
 
 void handle_inband_event(enum inband_event_type event, void *data)
-- 
2.26.2


