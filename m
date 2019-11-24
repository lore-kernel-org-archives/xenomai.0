From: Philippe  Gerum <rpm@xenomai.org>
Subject: [PATCH v2 3/7] cobalt/posix: fix missed rescheduling opportunities
Date: Sun, 24 Nov 2019 16:46:04 +0100
Message-Id: <20191124154608.9353-3-rpm@xenomai.org>
In-Reply-To: <20191124154608.9353-1-rpm@xenomai.org>
References: <20191124154608.9353-1-rpm@xenomai.org>
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

stop_debugged_thread() may suspend threads running on a remote CPU, we
have to kick the rescheduling procedure for these changes to take
effect asap. Make sure xnsched_run() is kicked from the call sites
once they are done updating the scheduler state.

Signed-off-by: Philippe Gerum <rpm@xenomai.org>
---
 kernel/cobalt/posix/process.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/kernel/cobalt/posix/process.c b/kernel/cobalt/posix/process.c
index b90e53507..1e003108e 100644
--- a/kernel/cobalt/posix/process.c
+++ b/kernel/cobalt/posix/process.c
@@ -819,6 +819,7 @@ static inline int handle_exception(struct ipipe_trap_data *d)
 		}
 		stop_debugged_process(thread);
 		xnlock_put_irqrestore(&nklock, s);
+		xnsched_run();
 	}
 #endif
 
@@ -1295,10 +1296,8 @@ static int handle_sigwake_event(struct task_struct *p)
 			cobalt_register_debugged_thread(thread);
 	}
 
-	if (xnthread_test_state(thread, XNRELAX)) {
-		xnlock_put_irqrestore(&nklock, s);
-		return KEVENT_PROPAGATE;
-	}
+	if (xnthread_test_state(thread, XNRELAX))
+		goto out;
 
 	/*
 	 * If kicking a shadow thread in primary mode, make sure Linux
@@ -1320,7 +1319,7 @@ static int handle_sigwake_event(struct task_struct *p)
 		xnthread_resume(thread, XNDBGSTOP);
 
 	__xnthread_kick(thread);
-
+out:
 	xnsched_run();
 
 	xnlock_put_irqrestore(&nklock, s);
-- 
2.21.0


