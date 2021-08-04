From: Philippe  Gerum <rpm@xenomai.org>
Subject: [PATCH 3/4] dovetail: detect context switch from the pipeline entry
Date: Wed,  4 Aug 2021 19:47:10 +0200
Message-Id: <20210804174711.4021807-3-rpm@xenomai.org>
In-Reply-To: <20210804174711.4021807-1-rpm@xenomai.org>
References: <20210804174711.4021807-1-rpm@xenomai.org>
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

We may not do out-of-band context switch from a pipeline entry. The
companion core has to wait until irq_exit_pipeline() notifies it about
leaving the pipeline, at which point rescheduling is legit.

Add a debug assertion (CONFIG_DEBUG_DOVETAIL) to catch invalid calls.

Signed-off-by: Philippe Gerum <rpm@xenomai.org>
---
 kernel/sched/core.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 40a82d0eb32114a..b22319e459e6a85 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -8602,6 +8602,8 @@ bool dovetail_context_switch(struct dovetail_altsched_context *out,
 	struct mm_struct *prev_mm, *next_mm;
 	bool inband_tail = false;
 
+	WARN_ON_ONCE(dovetail_debug() && on_pipeline_entry());
+
 	if (leave_inband) {
 		struct task_struct *tsk = current;
 		/*
-- 
2.31.1


