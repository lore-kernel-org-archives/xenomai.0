From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [PATCH 05/25] cobalt/kevents: dovetail: enable back tracing
Date: Thu, 20 May 2021 23:44:15 +0200
Message-Id: <ba85cd0f3662e5378734a4cb2f23660d31c2492c.1621547075.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1621547075.git.jan.kiszka@siemens.com>
References: <cover.1621547075.git.jan.kiszka@siemens.com>
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

enable back tracing for handle_oob_trap_entry

Signed-off-by: Hongzhan Chen <hongzhan.chen@intel.com>
Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 kernel/cobalt/dovetail/kevents.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/kernel/cobalt/dovetail/kevents.c b/kernel/cobalt/dovetail/kevents.c
index 64f6f421c1..a402d55690 100644
--- a/kernel/cobalt/dovetail/kevents.c
+++ b/kernel/cobalt/dovetail/kevents.c
@@ -97,10 +97,8 @@ void handle_oob_trap_entry(unsigned int trapnr, struct pt_regs *regs)
 
 	/*
 	 * Enable back tracing.
-	 *
-	 * trace_cobalt_thread_fault(xnarch_fault_pc(regs), trapnr);
 	 */
-	TODO();
+	trace_cobalt_thread_fault(xnarch_fault_pc(regs), trapnr);
 
 	if (xnthread_test_state(thread, XNROOT))
 		return;
-- 
2.26.2


