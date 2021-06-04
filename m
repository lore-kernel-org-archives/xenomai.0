From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [PATCH 08/12] cobalt/sched: dovetail: fix missed switching to OOB
 opportunities
Date: Fri,  4 Jun 2021 12:05:18 +0200
Message-Id: <5ca30341352bc10f520fbfc9a83216e481533269.1622801122.git.jan.kiszka@siemens.com>
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

From: Hongzhan Chen <hongzhan.chen@intel.com>

Ask for switching back to oob mode once ptrace core tell that
current is resuming from a stopped state, leaving space for
other runnable RT threads of the process to take over.

Signed-off-by: Hongzhan Chen <hongzhan.chen@intel.com>
[Philippe: added missing dovetail_request_ucall to pipeline_leave_oob_prepare]
Signed-off-by: Philippe Gerum <rpm@xenomai.org>
Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 kernel/cobalt/dovetail/kevents.c |  2 ++
 kernel/cobalt/dovetail/sched.c   | 17 +++++++++++++++--
 2 files changed, 17 insertions(+), 2 deletions(-)

diff --git a/kernel/cobalt/dovetail/kevents.c b/kernel/cobalt/dovetail/kevents.c
index 164ab9461..37ff6ca4b 100644
--- a/kernel/cobalt/dovetail/kevents.c
+++ b/kernel/cobalt/dovetail/kevents.c
@@ -491,6 +491,8 @@ static void handle_ptrace_cont(void)
 			unregister_debugged_thread(curr);
 
 		xnthread_set_localinfo(curr, XNHICCUP);
+
+		dovetail_request_ucall(current);
 	}
 
 	xnlock_put_irqrestore(&nklock, s);
diff --git a/kernel/cobalt/dovetail/sched.c b/kernel/cobalt/dovetail/sched.c
index de7c43b70..074bc006e 100644
--- a/kernel/cobalt/dovetail/sched.c
+++ b/kernel/cobalt/dovetail/sched.c
@@ -56,9 +56,22 @@ int pipeline_leave_inband(void)
 
 int pipeline_leave_oob_prepare(void)
 {
-	dovetail_leave_oob();
+	int suspmask = XNRELAX;
+	struct xnthread *curr = xnthread_current();
 
-	return XNRELAX;
+	dovetail_leave_oob();
+	/*
+	 * If current is being debugged, record that it should migrate
+	 * back in case it resumes in userspace. If it resumes in
+	 * kernel space, i.e.  over a restarting syscall, the
+	 * associated hardening will clear XNCONTHI.
+	 */
+	if (xnthread_test_state(curr, XNSSTEP)) {
+		xnthread_set_info(curr, XNCONTHI);
+		dovetail_request_ucall(current);
+		suspmask |= XNDBGSTOP;
+	}
+	return suspmask;
 }
 
 void pipeline_leave_oob_finish(void)
-- 
2.26.2


