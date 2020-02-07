From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [PATCH 3.0-only] cobalt/process: Fix incomplete backport of
 __handle_taskexit_event change
Message-ID: <2e2d6a9e-cf45-94c3-a9a7-3bc68dd844e5@siemens.com>
Date: Fri, 7 Feb 2020 16:12:51 +0100
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

Commit f7d83e55135c which tried to backport commit 393ece85166a from
master missed that there is no interrupt protection via
xnlock_get_irqsave in 3.0. But we need in order to protect xnsched_run
when running over the secondary domain as we always do here. In fact,
xnsched_run will complain via a warning about this.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 kernel/cobalt/posix/process.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/kernel/cobalt/posix/process.c b/kernel/cobalt/posix/process.c
index a65e947d51..52e544321e 100644
--- a/kernel/cobalt/posix/process.c
+++ b/kernel/cobalt/posix/process.c
@@ -1041,6 +1041,7 @@ static void __handle_taskexit_event(struct task_struct *p)
 {
 	struct cobalt_ppd *sys_ppd;
 	struct xnthread *thread;
+	spl_t s;
 
 	/*
 	 * We are called for both kernel and user shadows over the
@@ -1055,7 +1056,9 @@ static void __handle_taskexit_event(struct task_struct *p)
 	if (xnthread_test_state(thread, XNSSTEP))
 		unregister_debugged_thread(thread);
 
+	splhigh(s);
 	xnsched_run();
+	splexit(s);
 
 	xnthread_run_handler_stack(thread, exit_thread);
 
-- 
2.16.4


-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

