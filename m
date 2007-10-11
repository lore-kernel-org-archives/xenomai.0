Message-ID: <470E2051.6070200@domain.hid>
Date: Thu, 11 Oct 2007 15:08:33 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------070901090403040707000007"
Subject: [Adeos-main] [PATCH 4/4] tracer: add dynamic trigger for freezes
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
--------------070901090403040707000007
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit

Tiny new tracer feature for debugging sessions: If you do something like

	echo rthal_timer_request > /proc/ipipe/tracer/trigger

the trace will automagically freeze a trace (if it is running, of
course) once it enters the given function via mcount instrumentation.
Note that the symbol has to be resolvable when arming the trigger. One
can also do

	cat /proc/ipipe/tracer/trigger

to dump the currently active trigger.

With this service in place, you can quickly gain insight in code paths
that you would like to dissect, maybe in order to find a bug...

Jan

-- 
Siemens AG, Corporate Technology, CT SE 2
Corporate Competence Center Embedded Linux

--------------070901090403040707000007
Content-Type: text/x-patch;
 name="trigger-freeze-on-symbol.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="trigger-freeze-on-symbol.patch"

---
 kernel/ipipe/tracer.c |   71 ++++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 69 insertions(+), 2 deletions(-)

Index: linux-2.6.22.9/kernel/ipipe/tracer.c
===================================================================
--- linux-2.6.22.9.orig/kernel/ipipe/tracer.c
+++ linux-2.6.22.9/kernel/ipipe/tracer.c
@@ -2,7 +2,7 @@
  * kernel/ipipe/tracer.c
  *
  * Copyright (C) 2005 Luotao Fu.
- *               2005, 2006 Jan Kiszka.
+ *               2005-2007 Jan Kiszka.
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License as published by
@@ -130,6 +130,9 @@ static int back_trace = IPIPE_DEFAULT_BA
 static int verbose_trace = 1;
 static unsigned long trace_overhead;
 
+static unsigned long trigger_begin;
+static unsigned long trigger_end;
+
 static DEFINE_MUTEX(out_mutex);
 static struct ipipe_trace_path *print_path;
 #ifdef CONFIG_IPIPE_TRACE_PANIC
@@ -347,7 +350,9 @@ __ipipe_trace(enum ipipe_trace_type type
 		tp->post_trace = post_trace + 1;
 
 	/* freeze only if the slot is free and we are not already freezing */
-	if (unlikely(type == IPIPE_TRACE_FREEZE) &&
+	if ((unlikely(type == IPIPE_TRACE_FREEZE) ||
+	     (unlikely(eip >= trigger_begin && eip <= trigger_end) &&
+	     type == IPIPE_TRACE_FUNC)) &&
 	    (trace_paths[cpu_id][frozen_path[cpu_id]].begin < 0) &&
 	    !(tp->flags & IPIPE_TFLG_FREEZING)) {
 		tp->post_trace = post_trace + 1;
@@ -1193,6 +1198,61 @@ static int __ipipe_wr_proc_val(struct fi
 	return count;
 }
 
+static int __ipipe_rd_trigger(char *page, char **start, off_t off, int count,
+			      int *eof, void *data)
+{
+	int len;
+
+	if (!trigger_begin)
+		return 0;
+
+	len = sprint_symbol(page, trigger_begin);
+	page[len++] = '\n';
+
+	len -= off;
+	if (len <= off + count)
+		*eof = 1;
+	*start = page + off;
+	if (len > count)
+		len = count;
+	if (len < 0)
+		len = 0;
+
+	return len;
+}
+
+static int __ipipe_wr_trigger(struct file *file, const char __user *buffer,
+			      unsigned long count, void *data)
+{
+	char buf[KSYM_SYMBOL_LEN];
+	unsigned long begin, end;
+
+	if (count > sizeof(buf) - 1)
+		count = sizeof(buf) - 1;
+	if (copy_from_user(buf, buffer, count) < 0)
+		return -EFAULT;
+	buf[count] = 0;
+	if (buf[count-1] == '\n')
+		buf[count-1] = 0;
+
+	begin = kallsyms_lookup_name(buf);
+	if (!begin || !kallsyms_lookup_size_offset(begin, &end, NULL))
+		return -ENOENT;
+	end += begin - 1;
+
+	mutex_lock(&out_mutex);
+	/* invalidate the current range before setting a new one */
+	trigger_end = 0;
+	wmb();
+	/* set new range */
+	trigger_begin = begin;
+	wmb();
+	trigger_end = end;
+	mutex_unlock(&out_mutex);
+
+	return count;
+}
+
 extern struct proc_dir_entry *ipipe_proc_root;
 
 static void __init
@@ -1262,6 +1322,13 @@ void __init __ipipe_init_tracer(void)
 	if (entry)
 		entry->proc_fops = &__ipipe_frozen_prtrace_fops;
 
+	entry = create_proc_entry("trigger", 0644, trace_dir);
+	if (entry) {
+		entry->read_proc = __ipipe_rd_trigger;
+		entry->write_proc = __ipipe_wr_trigger;
+		entry->owner = THIS_MODULE;
+	}
+
 	__ipipe_create_trace_proc_val(trace_dir, "pre_trace_points",
 	                              &pre_trace);
 	__ipipe_create_trace_proc_val(trace_dir, "post_trace_points",



--------------070901090403040707000007--

