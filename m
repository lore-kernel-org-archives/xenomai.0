Message-ID: <470E2013.9050800@domain.hid>
Date: Thu, 11 Oct 2007 15:07:31 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------060106050308040904030900"
Subject: [Adeos-main] [PATCH 3/4] tracer: improve output
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: </public/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: adeos-main@gna.org
Cc: Philippe Gerum <rpm@xenomai.org>

This is a multi-part message in MIME format.
--------------060106050308040904030900
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit

Parts of the debug-enabled warning became outdated, and the rest is not
really required anymore IMO - let's remove this altogether. Moreover,
the patch adds the CPU number to the trace header.

Jan

-- 
Siemens AG, Corporate Technology, CT SE 2
Corporate Competence Center Embedded Linux

--------------060106050308040904030900
Content-Type: text/x-patch;
 name="improve-tracer-output.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="improve-tracer-output.patch"

---
 kernel/ipipe/tracer.c |   53 ++++++++++++++++----------------------------------
 1 file changed, 17 insertions(+), 36 deletions(-)

Index: linux-2.6.22.9/kernel/ipipe/tracer.c
===================================================================
--- linux-2.6.22.9.orig/kernel/ipipe/tracer.c
+++ linux-2.6.22.9/kernel/ipipe/tracer.c
@@ -831,27 +831,6 @@ static void __ipipe_print_symname(struct
 	}
 }
 
-#if defined(CONFIG_XENO_OPT_DEBUG) || defined(CONFIG_DEBUG_PREEMPT)
-static void __ipipe_print_dbgwarning(struct seq_file *m)
-{
-	seq_puts(m, "\n******** WARNING ********\n"
-		"The following debugging options will increase the observed "
-		"latencies:\n"
-#ifdef CONFIG_XENO_OPT_DEBUG
-		" o CONFIG_XENO_OPT_DEBUG\n"
-#endif /* CONFIG_XENO_OPT_DEBUG */
-#ifdef CONFIG_XENO_OPT_DEBUG_QUEUES
-		" o CONFIG_XENO_OPT_DEBUG_QUEUES (very costly)\n"
-#endif /* CONFIG_XENO_OPT_DEBUG */
-#ifdef CONFIG_DEBUG_PREEMPT
-		" o CONFIG_DEBUG_PREEMPT\n"
-#endif /* CONFIG_DEBUG_PREEMPT */
-		"\n");
-}
-#else /* !WARN_ON_DEBUGGING_LATENCIES */
-# define __ipipe_print_dbgwarning(m)
-#endif /* WARN_ON_DEBUGGING_LATENCIES */
-
 static void __ipipe_print_headline(struct seq_file *m)
 {
 	seq_printf(m, "Calibrated minimum trace-point overhead: %lu.%03lu "
@@ -907,7 +886,7 @@ static void *__ipipe_max_prtrace_start(s
 	if (!n) {
 		struct ipipe_trace_path *path;
 		unsigned long length_usecs;
-		int points, i;
+		int points, cpu;
 		unsigned long flags;
 
 		/* protect against max_path/frozen_path updates while we
@@ -917,11 +896,13 @@ static void *__ipipe_max_prtrace_start(s
 
 		/* find the longest of all per-cpu paths */
 		print_path = NULL;
-		for_each_online_cpu(i) {
-			path = &trace_paths[i][max_path[i]];
+		for_each_online_cpu(cpu) {
+			path = &trace_paths[cpu][max_path[cpu]];
 			if ((print_path == NULL) ||
-			    (path->length > print_path->length))
+			    (path->length > print_path->length)) {
 				print_path = path;
+				break;
+			}
 		}
 		print_path->dump_lock = 1;
 
@@ -948,10 +929,9 @@ static void *__ipipe_max_prtrace_start(s
 		seq_printf(m, "I-pipe worst-case tracing service on %s/ipipe-%s\n"
 			"------------------------------------------------------------\n",
 			UTS_RELEASE, IPIPE_ARCH_STRING);
-		__ipipe_print_dbgwarning(m);
-		seq_printf(m, "Begin: %lld cycles, Trace Points: %d (-%d/+%d), "
-			"Length: %lu us\n",
-			print_path->point[print_path->begin].timestamp,
+		seq_printf(m, "CPU: %d, Begin: %lld cycles, Trace Points: "
+			"%d (-%d/+%d), Length: %lu us\n",
+			cpu, print_path->point[print_path->begin].timestamp,
 			points, print_pre_trace, print_post_trace, length_usecs);
 		__ipipe_print_headline(m);
 	}
@@ -1068,7 +1048,7 @@ static void *__ipipe_frozen_prtrace_star
 
 	if (!n) {
 		struct ipipe_trace_path *path;
-		int i;
+		int cpu;
 		unsigned long flags;
 
 		/* protect against max_path/frozen_path updates while we
@@ -1078,10 +1058,12 @@ static void *__ipipe_frozen_prtrace_star
 
 		/* find the first of all per-cpu frozen paths */
 		print_path = NULL;
-		for_each_online_cpu(i) {
-			path = &trace_paths[i][frozen_path[i]];
-			if (path->end >= 0)
+		for_each_online_cpu(cpu) {
+			path = &trace_paths[cpu][frozen_path[cpu]];
+			if (path->end >= 0) {
 				print_path = path;
+				break;
+			}
 		}
 		if (print_path)
 			print_path->dump_lock = 1;
@@ -1105,9 +1087,8 @@ static void *__ipipe_frozen_prtrace_star
 			"------------------------------------------------------"
 			"------\n",
 			UTS_RELEASE, IPIPE_ARCH_STRING);
-		__ipipe_print_dbgwarning(m);
-		seq_printf(m, "Freeze: %lld cycles, Trace Points: %d (+%d)\n",
-			print_path->point[print_path->begin].timestamp,
+		seq_printf(m, "CPU: %d, Freeze: %lld cycles, Trace Points: %d (+%d)\n",
+			cpu, print_path->point[print_path->begin].timestamp,
 			print_pre_trace+1, print_post_trace);
 		__ipipe_print_headline(m);
 	}


--------------060106050308040904030900--

