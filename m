From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [PATCH 11/25] cobalt/sched: dovetail: add task control block
 initializers
Date: Thu, 20 May 2021 23:44:21 +0200
Message-Id: <b6f6669359f91901a369519cb63f5ad18a4ff690.1621547075.git.jan.kiszka@siemens.com>
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

Signed-off-by: Hongzhan Chen <hongzhan.chen@intel.com>
Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 kernel/cobalt/dovetail/sched.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/cobalt/dovetail/sched.c b/kernel/cobalt/dovetail/sched.c
index 71f763d399..82e29136ca 100644
--- a/kernel/cobalt/dovetail/sched.c
+++ b/kernel/cobalt/dovetail/sched.c
@@ -36,7 +36,7 @@ void pipeline_init_shadow_tcb(struct xnthread *thread)
 	/*
 	 * Initialize the alternate scheduling control block.
 	 */
-	TODO();
+	dovetail_init_altsched(&xnthread_archtcb(thread)->altsched);
 
 	trace_cobalt_shadow_map(thread);
 }
@@ -46,7 +46,7 @@ void pipeline_init_root_tcb(struct xnthread *thread)
 	/*
 	 * Initialize the alternate scheduling control block.
 	 */
-	TODO();
+	dovetail_init_altsched(&xnthread_archtcb(thread)->altsched);
 }
 
 int pipeline_leave_inband(void)
-- 
2.26.2


