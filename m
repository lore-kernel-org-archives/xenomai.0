From: Philippe  Gerum <rpm@xenomai.org>
Subject: [PATCH 4/7] cobalt/process: remove superfluous check for non-relaxed
 state
Date: Fri, 22 Nov 2019 18:19:46 +0100
Message-Id: <20191122171949.18021-5-rpm@xenomai.org>
In-Reply-To: <20191122171949.18021-1-rpm@xenomai.org>
References: <20191122171949.18021-1-rpm@xenomai.org>
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

If sched->curr is not the root thread, it has to refer to a Cobalt
thread currently running in primary mode, by design. Convert this
check to an assertion.

Signed-off-by: Philippe Gerum <rpm@xenomai.org>
---
 kernel/cobalt/posix/process.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/kernel/cobalt/posix/process.c b/kernel/cobalt/posix/process.c
index 1e003108e..90949e519 100644
--- a/kernel/cobalt/posix/process.c
+++ b/kernel/cobalt/posix/process.c
@@ -812,11 +812,10 @@ static inline int handle_exception(struct ipipe_trap_data *d)
 	if (xnarch_fault_bp_p(d) && user_mode(d->regs)) {
 		spl_t s;
 
+		XENO_WARN_ON(CORE, xnthread_test_state(thread, XNRELAX));
 		xnlock_get_irqsave(&nklock, s);
-		if (!xnthread_test_state(thread, XNRELAX)) {
-			xnthread_set_info(thread, XNCONTHI);
-			ipipe_enable_user_intret_notifier();
-		}
+		xnthread_set_info(thread, XNCONTHI);
+		ipipe_enable_user_intret_notifier();
 		stop_debugged_process(thread);
 		xnlock_put_irqrestore(&nklock, s);
 		xnsched_run();
-- 
2.21.0


