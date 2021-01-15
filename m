From: hongzha1 <hongzhan.chen@intel.com>
Subject: [PATCH 8/8] dovetail/kevents: enable back tracing
Date: Thu, 14 Jan 2021 20:19:12 -0500
Message-Id: <20210115011912.15456-2-hongzhan.chen@intel.com>
In-Reply-To: <20210115011912.15456-1-hongzhan.chen@intel.com>
References: <20210115011912.15456-1-hongzhan.chen@intel.com>
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

enable back tracing for handle_oob_trap_entry

Signed-off-by: hongzha1 <hongzhan.chen@intel.com>

diff --git a/kernel/cobalt/dovetail/kevents.c b/kernel/cobalt/dovetail/kevents.c
index 378017bea..51946e21c 100644
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
2.17.1


