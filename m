From: Philippe  Gerum <rpm@xenomai.org>
Subject: [PATCH v2 1/7] cobalt/process: skip trap handling for the root thread
Date: Sun, 24 Nov 2019 16:46:02 +0100
Message-Id: <20191124154608.9353-1-rpm@xenomai.org>
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

Bottom line: the root thread is special, in that it must always be in
a runnable state, never bear any blocking bit.

Running the trap handler when sched->curr points at the root thread
means that we got a synchronous exception while running regular root
context code on the head stage, which is not related to any action we
might want to perform in the handler for Cobalt threads. Return early
in such a case.

Signed-off-by: Philippe Gerum <rpm@xenomai.org>
---
 kernel/cobalt/posix/process.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/kernel/cobalt/posix/process.c b/kernel/cobalt/posix/process.c
index f96abfa66..b90e53507 100644
--- a/kernel/cobalt/posix/process.c
+++ b/kernel/cobalt/posix/process.c
@@ -803,6 +803,11 @@ static inline int handle_exception(struct ipipe_trap_data *d)
 	sched = xnsched_current();
 	thread = sched->curr;
 
+	trace_cobalt_thread_fault(d);
+
+	if (xnthread_test_state(thread, XNROOT))
+		return 0;
+
 #ifdef IPIPE_KEVT_USERINTRET
 	if (xnarch_fault_bp_p(d) && user_mode(d->regs)) {
 		spl_t s;
@@ -817,11 +822,6 @@ static inline int handle_exception(struct ipipe_trap_data *d)
 	}
 #endif
 
-	if (xnthread_test_state(thread, XNROOT))
-		return 0;
-
-	trace_cobalt_thread_fault(d);
-
 	if (xnarch_fault_fpu_p(d)) {
 #ifdef CONFIG_XENO_ARCH_FPU
 		spl_t s;
-- 
2.21.0


