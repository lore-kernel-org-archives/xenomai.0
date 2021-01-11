From: hongzha1 <hongzhan.chen@intel.com>
Subject: [PATCH 04/10] dovetail/sched: implement pipeline_init_shadow_tcb and
 pipeline_init_root_tcb
Date: Mon, 11 Jan 2021 01:43:12 -0500
Message-Id: <20210111064318.6154-4-hongzhan.chen@intel.com>
In-Reply-To: <20210111064318.6154-1-hongzhan.chen@intel.com>
References: <20210111064318.6154-1-hongzhan.chen@intel.com>
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Xenomai@xenomai.org

Signed-off-by: hongzha1 <hongzhan.chen@intel.com>
---
 kernel/cobalt/dovetail/sched.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/cobalt/dovetail/sched.c b/kernel/cobalt/dovetail/sched.c
index 71f763d39..82e29136c 100644
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
2.17.1


