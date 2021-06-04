From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [PATCH 01/12] cobalt/kevents: dovetail: provide thread info
 initializer
Date: Fri,  4 Jun 2021 12:05:11 +0200
Message-Id: <0b3b2833adce7f3ecceeeaf5543899e800831c7d.1622801122.git.jan.kiszka@siemens.com>
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

Dovetail invokes arch_inband_task_init() for each emerging thread in
the system, so that we may initialize our extended state with default
settings. Make sure to intercept this hook in order to start from a
fresh and clean state.

Signed-off-by: Philippe Gerum <rpm@xenomai.org>
Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 kernel/cobalt/dovetail/kevents.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/kernel/cobalt/dovetail/kevents.c b/kernel/cobalt/dovetail/kevents.c
index a402d5569..df5408ccc 100644
--- a/kernel/cobalt/dovetail/kevents.c
+++ b/kernel/cobalt/dovetail/kevents.c
@@ -86,6 +86,14 @@ static void unregister_debugged_thread(struct xnthread *thread)
 		resume_debugged_process(process);
 }
 
+void arch_inband_task_init(struct task_struct *tsk)
+{
+	struct cobalt_threadinfo *p = dovetail_task_state(tsk);
+
+	p->thread = NULL;
+	p->process = NULL;
+}
+
 void handle_oob_trap_entry(unsigned int trapnr, struct pt_regs *regs)
 {
 	struct xnthread *thread;
-- 
2.26.2


