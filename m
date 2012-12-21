From: Wolfgang Mauerer <wolfgang.mauerer@siemens.com>
Date: Fri, 21 Dec 2012 14:26:08 +0100
Message-Id: <1356096375-29859-4-git-send-email-wolfgang.mauerer@siemens.com>
In-Reply-To: <1356096375-29859-1-git-send-email-wolfgang.mauerer@siemens.com>
References: <1356096375-29859-1-git-send-email-wolfgang.mauerer@siemens.com>
Subject: [Xenomai] [PATCH 03/10] ipipe: Harden ftrace function and
	function-graph tracer
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org
Cc: jan.kiszka@siemens.com, wolfgang.mauerer@siemens.com

From: Jan Kiszka <jan.kiszka@siemens.com>

Again no tracing of local_irq_disable/enable_hw for the sake of reduced
overhead.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
Signed-off-by: Wolfgang Mauerer <wolfgang.mauerer@siemens.com>
---
 kernel/trace/trace_functions.c       |    8 ++++----
 kernel/trace/trace_functions_graph.c |    8 ++++----
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/kernel/trace/trace_functions.c b/kernel/trace/trace_functions.c
index c7b0c6a..bdf3c8f 100644
--- a/kernel/trace/trace_functions.c
+++ b/kernel/trace/trace_functions.c
@@ -91,7 +91,7 @@ function_trace_call(unsigned long ip, unsigned long parent_ip)
 	 * Need to use raw, since this must be called before the
 	 * recursive protection is performed.
 	 */
-	local_irq_save(flags);
+	flags = hard_local_irq_save();
 	cpu = raw_smp_processor_id();
 	data = tr->data[cpu];
 	disabled = atomic_inc_return(&data->disabled);
@@ -102,7 +102,7 @@ function_trace_call(unsigned long ip, unsigned long parent_ip)
 	}
 
 	atomic_dec(&data->disabled);
-	local_irq_restore(flags);
+	hard_local_irq_restore(flags);
 }
 
 static void
@@ -122,7 +122,7 @@ function_stack_trace_call(unsigned long ip, unsigned long parent_ip)
 	 * Need to use raw, since this must be called before the
 	 * recursive protection is performed.
 	 */
-	local_irq_save(flags);
+	flags = hard_local_irq_save();
 	cpu = raw_smp_processor_id();
 	data = tr->data[cpu];
 	disabled = atomic_inc_return(&data->disabled);
@@ -142,7 +142,7 @@ function_stack_trace_call(unsigned long ip, unsigned long parent_ip)
 	}
 
 	atomic_dec(&data->disabled);
-	local_irq_restore(flags);
+	hard_local_irq_restore(flags);
 }
 
 
diff --git a/kernel/trace/trace_functions_graph.c b/kernel/trace/trace_functions_graph.c
index a7d2a4c..c8e214b 100644
--- a/kernel/trace/trace_functions_graph.c
+++ b/kernel/trace/trace_functions_graph.c
@@ -251,7 +251,7 @@ int trace_graph_entry(struct ftrace_graph_ent *trace)
 	      ftrace_graph_ignore_irqs())
 		return 0;
 
-	local_irq_save(flags);
+	flags = hard_local_irq_save_notrace();
 	cpu = raw_smp_processor_id();
 	data = tr->data[cpu];
 	disabled = atomic_inc_return(&data->disabled);
@@ -263,7 +263,7 @@ int trace_graph_entry(struct ftrace_graph_ent *trace)
 	}
 
 	atomic_dec(&data->disabled);
-	local_irq_restore(flags);
+	hard_local_irq_restore_notrace(flags);
 
 	return ret;
 }
@@ -336,7 +336,7 @@ void trace_graph_return(struct ftrace_graph_ret *trace)
 	int cpu;
 	int pc;
 
-	local_irq_save(flags);
+	flags = hard_local_irq_save_notrace();
 	cpu = raw_smp_processor_id();
 	data = tr->data[cpu];
 	disabled = atomic_inc_return(&data->disabled);
@@ -345,7 +345,7 @@ void trace_graph_return(struct ftrace_graph_ret *trace)
 		__trace_graph_return(tr, trace, flags, pc);
 	}
 	atomic_dec(&data->disabled);
-	local_irq_restore(flags);
+	hard_local_irq_restore_notrace(flags);
 }
 
 void set_graph_array(struct trace_array *tr)
-- 
1.7.1


