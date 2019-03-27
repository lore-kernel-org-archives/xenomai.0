From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [PATCH 5/8] ipipe: Fix panic output of tracer
Date: Wed, 27 Mar 2019 14:18:04 +0100
Message-Id: <1ca86f6a8c99f2e692c45be7e46caf03ae5df61d.1553692686.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1553692686.git.jan.kiszka@siemens.com>
References: <cover.1553692686.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1553692686.git.jan.kiszka@siemens.com>
References: <cover.1553692686.git.jan.kiszka@siemens.com>
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org, Philippe Gerum <rpm@xenomai.org>

From: Jan Kiszka <jan.kiszka@siemens.com>

Since 4.9, we need to declare continued lines via KERN_CONT.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 kernel/ipipe/tracer.c | 30 +++++++++++++++---------------
 1 file changed, 15 insertions(+), 15 deletions(-)

diff --git a/kernel/ipipe/tracer.c b/kernel/ipipe/tracer.c
index 2db8cbbddf05..8d58ab143469 100644
--- a/kernel/ipipe/tracer.c
+++ b/kernel/ipipe/tracer.c
@@ -680,7 +680,7 @@ void ipipe_trace_panic_dump(void)
 
 	ipipe_context_check_off();
 
-	printk("I-pipe tracer log (%d points):\n", cnt);
+	printk(KERN_CONT "I-pipe tracer log (%d points):\n", cnt);
 
 	start = pos = WRAP_POINT_NO(panic_path->trace_pos-1);
 
@@ -690,11 +690,11 @@ void ipipe_trace_panic_dump(void)
 		char info[16];
 		int i;
 
-		printk(" %c",
+		printk(KERN_CONT " %c",
 		       (point->flags & IPIPE_TFLG_HWIRQ_OFF) ? '|' : ' ');
 
 		for (i = IPIPE_TFLG_DOMSTATE_BITS; i >= 0; i--)
-			printk("%c",
+			printk(KERN_CONT "%c",
 			       (IPIPE_TFLG_CURRENT_DOMAIN(point) == i) ?
 				(IPIPE_TFLG_DOMAIN_STALLED(point, i) ?
 					'#' : '+') :
@@ -702,40 +702,40 @@ void ipipe_trace_panic_dump(void)
 					'*' : ' '));
 
 		if (!point->eip)
-			printk("-<invalid>-\n");
+			printk(KERN_CONT "-<invalid>-\n");
 		else {
 			__ipipe_trace_point_type(buf, point);
-			printk("%s", buf);
+			printk(KERN_CONT "%s", buf);
 
 			switch (point->type & IPIPE_TYPE_MASK) {
 				case IPIPE_TRACE_FUNC:
-					printk("           ");
+					printk(KERN_CONT "           ");
 					break;
 
 				case IPIPE_TRACE_PID:
 					__ipipe_get_task_info(info,
 							      point, 1);
-					printk("%s", info);
+					printk(KERN_CONT "%s", info);
 					break;
 
 				case IPIPE_TRACE_EVENT:
 					__ipipe_get_event_date(info,
 							       panic_path, point);
-					printk("%s", info);
+					printk(KERN_CONT "%s", info);
 					break;
 
 				default:
-					printk("0x%08lx ", point->v);
+					printk(KERN_CONT "0x%08lx ", point->v);
 			}
 
 			time = __ipipe_signed_tsc2us(point->timestamp -
 				panic_path->point[start].timestamp);
-			printk(" %5ld ", time);
+			printk(KERN_CONT " %5ld ", time);
 
 			__ipipe_print_symname(NULL, point->eip);
-			printk(" (");
+			printk(KERN_CONT " (");
 			__ipipe_print_symname(NULL, point->parent_eip);
-			printk(")\n");
+			printk(KERN_CONT ")\n");
 		}
 		pos = WRAP_POINT_NO(pos - 1);
 	}
@@ -878,11 +878,11 @@ static void __ipipe_print_symname(struct seq_file *m, unsigned long eip)
 	if (!m) {
 		/* panic dump */
 		if (sym_name) {
-			printk("%s+0x%lx", sym_name, offset);
+			printk(KERN_CONT "%s+0x%lx", sym_name, offset);
 			if (modname)
-				printk(" [%s]", modname);
+				printk(KERN_CONT " [%s]", modname);
 		} else
-			printk("<%08lx>", eip);
+			printk(KERN_CONT "<%08lx>", eip);
 	} else
 #endif /* CONFIG_IPIPE_TRACE_PANIC */
 	{
-- 
2.16.4


