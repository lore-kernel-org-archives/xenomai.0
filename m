Message-ID: <43D0DEDB.8090407@domain.hid>
Date: Fri, 20 Jan 2006 14:00:11 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigE5250FBF12E43E310574964E"
Sender: jan.kiszka@domain.hid
Subject: [Xenomai-core] panic trace to understand migration bug
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai-core <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigE5250FBF12E43E310574964E
Content-Type: multipart/mixed; boundary="------------010208020400060401070006"

This is a multi-part message in MIME format.
--------------010208020400060401070006
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi all,

here is an extension to the latency tracer. It allows to use it in panic
situations where it provides a back-trace with some additional
information. I also attached a Xenomai patch to use this feature on
xnpod_fatal.

I'm currently trying to understand the crash Jeroen reported. For this
purpose I added a few special traces to shadow.c, see third patch. What
I currently get with CONFIG_XENO_OPT_DEBUG switched on is attached as wel=
l.

If anyone can tell something about what's happening here, please share
your wisdom! I'm yet lacking a concrete idea. Currently I'm wondering
why a Linux thread (main, pid 843/0x34b) gets scheduled in by the Linux
scheduler although TASK_INTERRUPTIBLE is set (and while it's Xeno mate
is correctly blocking on a RT-sem).

Jan

--------------010208020400060401070006
Content-Type: text/plain;
 name="ipipe_trace_panic.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline;
 filename="ipipe_trace_panic.patch"

--- linux-2.6.15.1/include/linux/ipipe_trace.h.orig	2006-01-19 10:16:43.0=
00000000 +0100
+++ linux-2.6.15.1/include/linux/ipipe_trace.h	2006-01-19 13:13:07.000000=
000 +0100
@@ -31,4 +31,7 @@ void ipipe_trace_special(unsigned char s
 int ipipe_trace_max_reset(void);
 int ipipe_trace_frozen_reset(void);
=20
+void ipipe_trace_panic_freeze(void);
+void ipipe_trace_panic_dump(void);
+
 #endif	/* !__LINUX_IPIPE_H */
--- linux-2.6.15.1/kernel/ipipe/tracer.c.orig	2006-01-19 10:26:31.0000000=
00 +0100
+++ linux-2.6.15.1/kernel/ipipe/tracer.c	2006-01-20 11:31:58.000000000 +0=
100
@@ -107,10 +107,17 @@ static int verbose_trace =3D 0;
=20
 static DECLARE_MUTEX(out_mutex);
 static struct ipipe_trace_path *print_path;
+static struct ipipe_trace_path *panic_path;
 static int print_pre_trace;
 static int print_post_trace;
=20
=20
+static long __ipipe_signed_tsc2us(long long tsc);
+static void
+__ipipe_trace_point_type(char *buf, struct ipipe_trace_point *point);
+static void __ipipe_print_symname(struct seq_file *m, unsigned long eip)=
;
+
+
 static notrace int __ipipe_get_free_trace_path(int old, int cpu_id)
 {
 	int new_active =3D old;
@@ -498,6 +505,61 @@ int ipipe_trace_frozen_reset(void)
 }
 EXPORT_SYMBOL(ipipe_trace_frozen_reset);
=20
+void ipipe_trace_panic_freeze(void)
+{
+	unsigned long flags;
+	int cpu_id;
+
+	ipipe_trace_enable =3D 0;
+	local_irq_save_hw_notrace(flags);
+
+	cpu_id =3D raw_smp_processor_id();
+
+	panic_path =3D &trace_paths[cpu_id][active_path[cpu_id]];
+
+	local_irq_restore_hw(flags);
+}
+EXPORT_SYMBOL(ipipe_trace_panic_freeze);
+
+void ipipe_trace_panic_dump(void)
+{
+	int cnt =3D back_trace;
+	int start, pos;
+
+	printk("I-pipe tracer log (%d points):\n", cnt);
+
+	start =3D pos =3D WRAP_POINT_NO(panic_path->trace_pos-1);
+
+	while (cnt-- > 0) {
+		struct ipipe_trace_point *point =3D &panic_path->point[pos];
+		long time;
+		char buf[16];
+
+		if (!point->eip)
+			printk("-<invalid>-\n");
+		else {
+			__ipipe_trace_point_type(buf, point);
+			printk(buf);
+
+			if (point->type !=3D IPIPE_TRACE_FN)
+				printk("0x%08lx ", point->v);
+			else
+				printk("           ");
+
+			time =3D __ipipe_signed_tsc2us(point->timestamp -
+				panic_path->point[start].timestamp);
+			printk(" %5ld ", time);
+
+			__ipipe_print_symname(NULL, point->eip);
+			printk(" (");
+			__ipipe_print_symname(NULL, point->parent_eip);
+			printk(")\n");
+		}
+		pos =3D WRAP_POINT_NO(pos - 1);
+	}
+}
+EXPORT_SYMBOL(ipipe_trace_panic_dump);
+
=20
 /* --- /proc output --- */
=20
@@ -510,6 +572,46 @@ static notrace int __ipipe_in_critical_t
 	          print_post_trace)));
 }
=20
+static long __ipipe_signed_tsc2us(long long tsc)
+{
+        unsigned long long abs_tsc;
+        long us;
+
+	/* ipipe_tsc2us works on unsigned =3D> handle sign separately */
+        abs_tsc =3D (tsc >=3D 0) ? tsc : -tsc;
+        us =3D ipipe_tsc2us(abs_tsc);
+        if (tsc < 0)
+                return -us;
+        else
+                return us;
+}
+
+static void
+__ipipe_trace_point_type(char *buf, struct ipipe_trace_point *point)
+{
+	switch (point->type) {
+		case IPIPE_TRACE_FN:
+			strcpy(buf, "fn     ");
+			break;
+
+		case IPIPE_TRACE_BEGIN:
+			strcpy(buf, "begin  ");
+			break;
+
+		case IPIPE_TRACE_END:
+			strcpy(buf, "end    ");
+			break;
+
+		case IPIPE_TRACE_FREEZE:
+			strcpy(buf, "freeze ");
+			break;
+
+		default: /* IPIPE_TRACE_SPECIAL */
+			sprintf(buf, "(0x%02x) ",
+			        point->type - IPIPE_TRACE_SPECIAL);
+	}
+}
+
 static void
 __ipipe_print_pathmark(struct seq_file *m, struct ipipe_trace_point *poi=
nt)
 {
@@ -562,15 +664,26 @@ static void __ipipe_print_symname(struct
 	char *modname;
=20
 	sym_name =3D kallsyms_lookup(eip, &size, &offset, &modname, namebuf);
-	if (sym_name) {
-		if (verbose_trace) {
-			seq_printf(m, "%s+0x%lx", sym_name, offset);
-			if (modname)
-				seq_printf(m, " [%s]", modname);
+
+	/* printing to /proc? */
+	if (m) {
+		if (sym_name) {
+			if (verbose_trace) {
+				seq_printf(m, "%s+0x%lx", sym_name, offset);
+				if (modname)
+					seq_printf(m, " [%s]", modname);
+			} else
+				seq_puts(m, sym_name);
 		} else
-			seq_puts(m, sym_name);
-	} else
-		seq_printf(m, "<%08lx>", eip);
+			seq_printf(m, "<%08lx>", eip);
+	} else {
+		/* panic dump */
+		if (sym_name) {
+			printk("%s+0x%lx", sym_name, offset);
+			if (modname)
+				printk(" [%s]", modname);
+		}
+	}
 }
=20
 #if defined(CONFIG_XENO_OPT_DEBUG) || defined(CONFIG_DEBUG_PREEMPT)
@@ -690,52 +803,28 @@ static void __ipipe_prtrace_stop(struct=20
 static int __ipipe_prtrace_show(struct seq_file *m, void *p)
 {
 	long time;
-	long long delta;
-	unsigned long long abs_delta;
 	struct ipipe_trace_point *point =3D p;
+	char buf[16];
=20
 	if (!point->eip) {
 		seq_puts(m, "-<invalid>-\n");
 		return 0;
 	}
=20
-	/* ipipe_tsc2us works on unsigned =3D> handle sign separately */
-	delta =3D point->timestamp -
-		print_path->point[print_path->begin].timestamp;
-	abs_delta =3D (delta >=3D 0) ? delta : -delta;
-	time =3D ipipe_tsc2us(abs_delta);
-	if (delta < 0)
-		time =3D -time;
-
 	__ipipe_print_pathmark(m, point);
-	switch (point->type) {
-		case IPIPE_TRACE_FN:
-			seq_puts(m, "fn     ");
-			break;
-
-		case IPIPE_TRACE_BEGIN:
-			seq_puts(m, "begin  ");
-			break;
-
-		case IPIPE_TRACE_END:
-			seq_puts(m, "end    ");
-			break;
-
-		case IPIPE_TRACE_FREEZE:
-			seq_puts(m, "freeze ");
-			break;
-
-		default: /* IPIPE_TRACE_SPECIAL */
-			seq_printf(m, "(0x%02x) ",
-			           point->type - IPIPE_TRACE_SPECIAL);
-	}
+	__ipipe_trace_point_type(buf, point);
+	seq_puts(m, buf);
 	if (verbose_trace) {
 		if (point->type !=3D IPIPE_TRACE_FN)
 			seq_printf(m, "0x%08lx ", point->v);
 		else
 			seq_puts(m, "           ");
 	}
+
+	time =3D __ipipe_signed_tsc2us(point->timestamp -
+		print_path->point[print_path->begin].timestamp);
 	seq_printf(m, "%5ld", time);
+
 	__ipipe_print_delay(m, point);
 	__ipipe_print_symname(m, point->eip);
 	seq_puts(m, " (");

--------------010208020400060401070006
Content-Type: text/plain;
 name="xeno_panic_trace.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline;
 filename="xeno_panic_trace.patch"

Index: include/asm-generic/system.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- include/asm-generic/system.h	(revision 470)
+++ include/asm-generic/system.h	(working copy)
@@ -39,6 +39,13 @@
 #include <asm/xenomai/atomic.h>
 #include <xenomai/nucleus/shadow.h>
=20
+#ifdef CONFIG_IPIPE_TRACE
+#include <linux/ipipe_trace.h>
+#else /* !CONFIG_IPIPE_TRACE */
+#define ipipe_trace_panic_freeze()
+#define ipipe_trace_panic_dump()
+#endif /* CONFIG_IPIPE_TRACE */
+
 #define module_param_value(parm) (parm)
=20
 typedef unsigned long spl_t;
@@ -185,6 +192,7 @@
     rthal_emergency_console(); \
     xnarch_logerr("fatal: %s\n",emsg); \
     show_stack(NULL,NULL);			\
+    ipipe_trace_panic_dump();			\
     for (;;) cpu_relax();			\
 } while(0)
=20
Index: include/nucleus/types.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- include/nucleus/types.h	(revision 470)
+++ include/nucleus/types.h	(working copy)
@@ -106,8 +106,10 @@
=20
 #define xnpod_fatal(format,args...) \
 do { \
-   const char *panic =3D xnpod_fatal_helper(format,##args); \
-   xnarch_halt(panic); \
+    const char *panic; \
+    ipipe_trace_panic_freeze(); \
+    panic =3D xnpod_fatal_helper(format,##args); \
+    xnarch_halt(panic); \
 } while (0)
=20
 #if defined(__XENO_SIM__) || defined(__XENO_UVM__)
Index: ksrc/nucleus/shadow.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- ksrc/nucleus/shadow.c	(revision 470)
+++ ksrc/nucleus/shadow.c	(working copy)
@@ -1569,6 +1569,7 @@
 	    testbits(status,XNSTARTED) &&
 	    testbits(status,XNTHREAD_BLOCK_BITS))
 	    {
+	    ipipe_trace_panic_freeze();
 	    show_stack(xnthread_user_task(threadin),NULL);
             xnpod_fatal("blocked thread %s[%d] rescheduled?! (status=3D0=
x%lx, sig=3D%d, prev=3D%s[%d])",
 			threadin->name,

--------------010208020400060401070006
Content-Type: text/plain;
 name="shadow-instr.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline;
 filename="shadow-instr.patch"

Index: ksrc/nucleus/shadow.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- ksrc/nucleus/shadow.c	(revision 470)
+++ ksrc/nucleus/shadow.c	(working copy)
@@ -384,6 +384,7 @@
 	xnlock_get_irqsave(&nklock, s);
=20
 	thread =3D gk->thread;
+ipipe_trace_special(1, xnthread_archtcb(thread)->user_task->pid);
=20
 	/* In the very rare case where the requestor has been awaken
 	   by a signal before we have been able to process the
@@ -459,6 +460,7 @@
     gk->thread =3D thread;
     set_current_state(TASK_INTERRUPTIBLE);
     wake_up_interruptible_sync(&gk->waitq);
+ipipe_trace_special(2, current->pid);
=20
     if (rthal_current_domain =3D=3D rthal_root_domain) {
=20
@@ -575,6 +577,7 @@
 	set_current_state((current->state&~TASK_UNINTERRUPTIBLE)|TASK_INTERRUPT=
IBLE);
=20
     schedule_linux_call(LO_WAKEUP_REQ,current,0);
+ipipe_trace_special(3, current->pid);
=20
     splhigh(s);
     xnpod_renice_root(thread->cprio);
@@ -1520,6 +1523,10 @@
=20
     prev =3D current;
     threadin =3D xnshadow_thread(next);
+ipipe_trace_special(4, prev->pid);
+ipipe_trace_special(4, prev->state);
+ipipe_trace_special(5, next->pid);
+ipipe_trace_special(5, next->state);
=20
     rthal_load_cpuid();	/* Linux is running in a migration-safe
 			   portion of code. */

--------------010208020400060401070006
Content-Type: text/plain;
 name="migr-panic.trace"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline;
 filename="migr-panic.trace"

I-pipe: Domain Xenomai registered.
Xenomai: hal/x86 started.
Xenomai: real-time nucleus v2.1-rc2 (Champagne) loaded.
Xenomai: starting native API services.
c30ebe98 00000082 c110d070 c30ebe68 c482ad60 00000001 00000001 00200000
       c482ad60 00000002 ffffffff 00000004 ffffffff c482afb8 c482a3b4 c30=
ebe98
       c110d070 c30c9570 c486ade0 c4850033 00000000 c486c090 c482afa4 c48=
2ad60
Call Trace:
 [<c485590a>] xnpod_suspend_thread+0x7a7/0x7f7 [xeno_nucleus]
 [<c485a033>] xnsynch_sleep_on+0x7e3/0x815 [xeno_nucleus]
 [<c4a0a30f>] rt_sem_p+0xa6/0x10a [xeno_native]
 [<c4a03ed2>] __rt_sem_p+0x5f/0x69 [xeno_native]
 [<c485ee68>] hisyscall_event+0x1d1/0x2d9 [xeno_nucleus]
 [<c01301ed>] __ipipe_dispatch_event+0x5e/0xe5
 [<c010bbbf>] __ipipe_syscall_root+0x58/0xc2
 [<c0102ac0>] system_call+0x20/0x41
Xenomai: fatal: blocked thread main[843] rescheduled?! (status=3D0x300082=
, sig=3D0, prev=3Dgatekeeper/0[800])
 CPU  PID    PRI  TIMEOUT  STAT      NAME
>  0  0      30   0        00500080  ROOT
   0  844    30   0        00300180  task0
   0  843    1    0        00300082  main
Timer: oneshot [tickval=3D1 ns, elapsed=3D202377277237]

c3155f04 c48645b2 c30ec000 c30c9570 00300082 c02af500 00000286 c02af500
       c3155f58 c01301ed 00000022 c02af500 c110d070 c110d070 00000022 c04=
9bbec
       00000001 c02af500 c110d070 19339e6c 0000002f c3155f94 c02733bc 000=
035d5
Call Trace:
 [<c01031ae>] show_stack+0x7d/0x88
 [<c485f305>] schedule_event+0x1d4/0x288 [xeno_nucleus]
 [<c01301ed>] __ipipe_dispatch_event+0x5e/0xe5
 [<c02733bc>] schedule+0x3f2/0x5f0
 [<c485dea8>] gatekeeper_thread+0xa1/0x19b [xeno_nucleus]
 [<c01268be>] kthread+0x71/0x9f
 [<c0100dcd>] kernel_thread_helper+0x5/0xb
I-pipe tracer log (300 points):
fn                     0 ipipe_trace_panic_freeze+0x8 (schedule_event+0x1=
6d [xeno_nucleus])
(0x05) 0x00000001     -1 schedule_event+0x78 [xeno_nucleus] (__ipipe_disp=
atch_event+0x5e)
(0x05) 0x0000034b     -2 schedule_event+0x6b [xeno_nucleus] (__ipipe_disp=
atch_event+0x5e)
(0x04) 0x00000001     -3 schedule_event+0x5b [xeno_nucleus] (__ipipe_disp=
atch_event+0x5e)
(0x04) 0x00000320     -4 schedule_event+0x4e [xeno_nucleus] (__ipipe_disp=
atch_event+0x5e)
fn                    -5 schedule_event+0xd [xeno_nucleus] (__ipipe_dispa=
tch_event+0x5e)
fn                    -6 __ipipe_dispatch_event+0xe (schedule+0x3f2)
fn                    -9 dequeue_task+0xa (deactivate_task+0x1a)
fn                   -10 deactivate_task+0x9 (schedule+0x1fe)
fn                   -12 __ipipe_stall_root+0x8 (schedule+0x16e)
fn                   -13 sched_clock+0xd (schedule+0xf2)
fn                   -14 profile_hit+0x9 (schedule+0x62)
fn                   -16 schedule+0xe (gatekeeper_thread+0xa1 [xeno_nucle=
us])
fn                   -21 __switch_to+0xc (xnpod_schedule+0x9be [xeno_nucl=
eus])
fn                   -25 xnpod_schedule+0xe [xeno_nucleus] (xnpod_suspend=
_thread+0x7a7 [xeno_nucleus])
fn                   -33 xntimer_do_start_aperiodic+0xe [xeno_nucleus] (x=
ntimer_start+0x37 [xeno_nucleus])
fn                   -34 xntimer_start+0x9 [xeno_nucleus] (xnpod_suspend_=
thread+0x797 [xeno_nucleus])
fn                   -38 xnpod_suspend_thread+0xe [xeno_nucleus] (rt_task=
_sleep+0x54 [xeno_native])
fn                   -39 rt_task_sleep+0xa [xeno_native] (__rt_task_sleep=
+0x25 [xeno_native])
fn                   -40 __copy_from_user_ll+0xa (__rt_task_sleep+0x1a [x=
eno_native])
fn                   -41 __rt_task_sleep+0xa [xeno_native] (hisyscall_eve=
nt+0x1d1 [xeno_nucleus])
fn                   -44 hisyscall_event+0xe [xeno_nucleus] (__ipipe_disp=
atch_event+0x5e)
fn                   -46 __ipipe_dispatch_event+0xe (__ipipe_syscall_root=
+0x58)
fn                   -47 __ipipe_syscall_root+0x9 (system_call+0x20)
fn                   -58 ipipe_unstall_pipeline_from+0xc (rt_mutex_unlock=
+0xdf [xeno_native])
fn                   -60 xnsynch_wakeup_one_sleeper+0xe [xeno_nucleus] (r=
t_mutex_unlock+0x92 [xeno_native])
fn                   -62 rt_mutex_unlock+0xb [xeno_native] (__rt_mutex_un=
lock+0x43 [xeno_native])
fn                   -63 ipipe_unstall_pipeline_from+0xc (rt_registry_fet=
ch+0xa4 [xeno_native])
fn                   -65 rt_registry_fetch+0xa [xeno_native] (__rt_mutex_=
unlock+0x36 [xeno_native])
fn                   -66 __rt_mutex_unlock+0xa [xeno_native] (losyscall_e=
vent+0xb6 [xeno_nucleus])
fn                   -68 ipipe_unstall_pipeline_from+0xc (xnshadow_harden=
+0x156 [xeno_nucleus])
fn                   -70 xnpod_switch_fpu+0xa [xeno_nucleus] (xnshadow_ha=
rden+0x137 [xeno_nucleus])
fn                   -72 __switch_to+0xc (schedule+0x4de)
fn                   -80 xnpod_schedule+0xe [xeno_nucleus] (xnpod_schedul=
e_handler+0x17 [xeno_nucleus])
fn                   -81 xnpod_schedule_handler+0x8 [xeno_nucleus] (__ipi=
pe_sync_stage+0x113)
fn                   -83 __ipipe_sync_stage+0xe (ipipe_suspend_domain+0x4=
7)
fn                   -84 ipipe_suspend_domain+0xb (ipipe_unstall_pipeline=
_from+0x4e)
fn                   -86 ipipe_unstall_pipeline_from+0xc (gatekeeper_thre=
ad+0x18c [xeno_nucleus])
fn                   -90 __ipipe_handle_irq+0xe (ipipe_trigger_irq+0x51)
fn                   -91 memcpy+0xb (ipipe_trigger_irq+0x49)
fn                   -92 ipipe_trigger_irq+0xc (xnpod_schedule+0x29 [xeno=
_nucleus])
fn                   -93 xnpod_schedule+0xe [xeno_nucleus] (gatekeeper_th=
read+0x15e [xeno_nucleus])
fn                   -99 xnpod_schedule_runnable+0xe [xeno_nucleus] (gate=
keeper_thread+0x132 [xeno_nucleus])
fn                  -105 xnpod_resume_thread+0xe [xeno_nucleus] (gatekeep=
er_thread+0xf6 [xeno_nucleus])
(0x01) 0x0000034c   -106 gatekeeper_thread+0xde [xeno_nucleus] (kthread+0=
x71)
fn                  -107 kthread_should_stop+0x8 (gatekeeper_thread+0xa6 =
[xeno_nucleus])
fn                  -109 __ipipe_unstall_root+0x8 (schedule+0x516)
fn                  -112 __switch_to+0xc (schedule+0x4de)
(0x05) 0x00000000   -113 schedule_event+0x78 [xeno_nucleus] (__ipipe_disp=
atch_event+0x5e)
(0x05) 0x00000320   -114 schedule_event+0x6b [xeno_nucleus] (__ipipe_disp=
atch_event+0x5e)
(0x04) 0x00000001   -114 schedule_event+0x5b [xeno_nucleus] (__ipipe_disp=
atch_event+0x5e)
(0x04) 0x0000034c   -115 schedule_event+0x4e [xeno_nucleus] (__ipipe_disp=
atch_event+0x5e)
fn                  -116 schedule_event+0xd [xeno_nucleus] (__ipipe_dispa=
tch_event+0x5e)
fn                  -117 __ipipe_dispatch_event+0xe (schedule+0x3f2)
fn                  -119 dequeue_task+0xa (deactivate_task+0x1a)
fn                  -121 deactivate_task+0x9 (schedule+0x1fe)
fn                  -122 __ipipe_stall_root+0x8 (schedule+0x16e)
fn                  -123 sched_clock+0xd (schedule+0xf2)
fn                  -124 profile_hit+0x9 (schedule+0x62)
fn                  -125 schedule+0xe (xnshadow_harden+0xa6 [xeno_nucleus=
])
(0x02) 0x0000034c   -126 xnshadow_harden+0x8e [xeno_nucleus] (losyscall_e=
vent+0x91 [xeno_nucleus])
fn                  -128 __ipipe_unstall_root+0x8 (__ipipe_restore_root+0=
x2b)
fn                  -129 __ipipe_restore_root+0x8 (__wake_up_sync+0x6b)
fn                  -130 __ipipe_restore_root+0x8 (try_to_wake_up+0xb7)
fn                  -132 enqueue_task+0xa (activate_task+0x5d)
fn                  -133 sched_clock+0xd (activate_task+0x13)
fn                  -134 activate_task+0xb (try_to_wake_up+0x7d)
fn                  -136 __ipipe_test_and_stall_root+0x8 (try_to_wake_up+=
0x13)
fn                  -136 try_to_wake_up+0xb (default_wake_function+0x19)
fn                  -137 default_wake_function+0x8 (__wake_up_common+0x2a=
)
fn                  -139 __wake_up_common+0xb (__wake_up_sync+0x5e)
fn                  -141 __ipipe_test_and_stall_root+0x8 (__wake_up_sync+=
0x2a)
fn                  -142 __wake_up_sync+0xd (xnshadow_harden+0x7f [xeno_n=
ucleus])
fn                  -143 __ipipe_test_root+0x8 (__might_sleep+0x1e)
fn                  -144 __might_sleep+0x9 (xnshadow_harden+0x45 [xeno_nu=
cleus])
fn                  -145 xnshadow_harden+0xb [xeno_nucleus] (losyscall_ev=
ent+0x91 [xeno_nucleus])
fn                  -146 losyscall_event+0xd [xeno_nucleus] (__ipipe_disp=
atch_event+0x5e)
fn                  -149 ipipe_unstall_pipeline_from+0xc (xnpod_schedule+=
0xc1b [xeno_nucleus])
fn                  -152 xnpod_schedule+0xe [xeno_nucleus] (hisyscall_eve=
nt+0x3e [xeno_nucleus])
fn                  -153 hisyscall_event+0xe [xeno_nucleus] (__ipipe_disp=
atch_event+0x5e)
fn                  -155 __ipipe_dispatch_event+0xe (__ipipe_syscall_root=
+0x58)
fn                  -156 __ipipe_syscall_root+0x9 (system_call+0x20)
fn                  -163 __ipipe_unstall_iret_root+0x8 (restore_raw+0x0)
fn                  -164 __ipipe_stall_root+0x8 (syscall_exit+0x5)
fn                  -165 fput+0x8 (sys_write+0x5d)
fn                  -166 inotify_inode_queue_event+0xe (vfs_write+0xed)
fn                  -168 inotify_dentry_parent_queue_event+0xa (vfs_write=
+0xe2)
fn                  -170 dnotify_parent+0xa (vfs_write+0xc9)
fn                  -174 cond_resched+0x9 (generic_file_buffered_write+0x=
427)
fn                  -176 balance_dirty_pages_ratelimited+0x8 (generic_fil=
e_buffered_write+0x422)
fn                  -177 put_page+0x8 (generic_file_buffered_write+0x415)=

fn                  -179 mark_page_accessed+0x9 (generic_file_buffered_wr=
ite+0x40f)
fn                  -180 __wake_up_bit+0xb (unlock_page+0x2d)
fn                  -182 page_waitqueue+0x8 (unlock_page+0x23)
fn                  -183 unlock_page+0x9 (generic_file_buffered_write+0x4=
08)
fn                  -185 __mark_inode_dirty+0xd (generic_commit_write+0xb=
0)
fn                  -187 mark_buffer_dirty+0x8 (__block_commit_write+0x6f=
)
fn                  -189 __block_commit_write+0xd (generic_commit_write+0=
x39)
fn                  -189 generic_commit_write+0xc (generic_file_buffered_=
write+0x384)
fn                  -191 __copy_from_user_ll+0xa (generic_file_buffered_w=
rite+0x2bd)
fn                  -197 __block_prepare_write+0xe (block_prepare_write+0=
x20)
fn                  -198 block_prepare_write+0x9 (ext2_prepare_write+0x1b=
)
fn                  -199 ext2_prepare_write+0x8 (generic_file_buffered_wr=
ite+0x1e8)
fn                  -202 __ipipe_unstall_root+0x8 (find_lock_page+0xfc)
fn                  -203 radix_tree_lookup+0xb (find_lock_page+0x37)
fn                  -204 __ipipe_stall_root+0x8 (find_lock_page+0x16)
fn                  -205 find_lock_page+0xb (generic_file_buffered_write+=
0x120)
fn                  -208 generic_file_buffered_write+0xe (__generic_file_=
aio_write_nolock+0x3cf)
fn                  -210 timespec_trunc+0xb (current_fs_time+0x41)
fn                  -212 current_fs_time+0xd (inode_update_time+0x2e)
fn                  -214 inode_update_time+0xc (__generic_file_aio_write_=
nolock+0x37a)
fn                  -215 remove_suid+0xc (__generic_file_aio_write_nolock=
+0x367)
fn                  -221 __generic_file_aio_write_nolock+0xe (__generic_f=
ile_write_nolock+0x7d)
fn                  -222 __generic_file_write_nolock+0xc (generic_file_wr=
ite+0x4c)
fn                  -224 __ipipe_test_root+0x8 (__might_sleep+0x1e)
fn                  -224 __might_sleep+0x9 (generic_file_write+0x34)
fn                  -226 generic_file_write+0xe (vfs_write+0x8f)
fn                  -227 rw_verify_area+0xb (vfs_write+0x6f)
fn                  -229 vfs_write+0xc (sys_write+0x3f)
fn                  -232 fget_light+0xb (sys_write+0x1d)
fn                  -233 sys_write+0xd (syscall_call+0x7)
fn                  -235 losyscall_event+0xd [xeno_nucleus] (__ipipe_disp=
atch_event+0x5e)
fn                  -238 __ipipe_unstall_root+0x8 (ipipe_reenter_root+0x2=
6)
fn                  -239 ipipe_reenter_root+0xb (xnshadow_relax+0x1cb [xe=
no_nucleus])
fn                  -241 ipipe_unstall_pipeline_from+0xc (xnshadow_relax+=
0x13e [xeno_nucleus])
fn                  -246 __switch_to+0xc (xnpod_schedule+0x9be [xeno_nucl=
eus])
fn                  -249 ipipe_unstall_pipeline_from+0xc (schedule_event+=
0x265 [xeno_nucleus])
fn                  -254 xnpod_schedule_runnable+0xe [xeno_nucleus] (sche=
dule_event+0x23e [xeno_nucleus])
(0x05) 0x00000000   -256 schedule_event+0x78 [xeno_nucleus] (__ipipe_disp=
atch_event+0x5e)
(0x05) 0x0000034c   -257 schedule_event+0x6b [xeno_nucleus] (__ipipe_disp=
atch_event+0x5e)
(0x04) 0x00000001   -257 schedule_event+0x5b [xeno_nucleus] (__ipipe_disp=
atch_event+0x5e)
(0x04) 0x00000320   -258 schedule_event+0x4e [xeno_nucleus] (__ipipe_disp=
atch_event+0x5e)
fn                  -259 schedule_event+0xd [xeno_nucleus] (__ipipe_dispa=
tch_event+0x5e)
fn                  -261 __ipipe_dispatch_event+0xe (schedule+0x3f2)
fn                  -263 dequeue_task+0xa (deactivate_task+0x1a)
fn                  -264 deactivate_task+0x9 (schedule+0x1fe)
fn                  -266 __ipipe_stall_root+0x8 (schedule+0x16e)
fn                  -267 sched_clock+0xd (schedule+0xf2)
fn                  -269 profile_hit+0x9 (schedule+0x62)
fn                  -270 schedule+0xe (gatekeeper_thread+0xa1 [xeno_nucle=
us])
fn                  -275 __switch_to+0xc (xnpod_schedule+0x9be [xeno_nucl=
eus])
fn                  -278 xnpod_schedule+0xe [xeno_nucleus] (xnpod_suspend=
_thread+0x7a7 [xeno_nucleus])
fn                  -282 xnpod_suspend_thread+0xe [xeno_nucleus] (xnsynch=
_sleep_on+0x7e3 [xeno_nucleus])
fn                  -286 xnsynch_sleep_on+0xe [xeno_nucleus] (rt_sem_p+0x=
a6 [xeno_native])
fn                  -288 rt_sem_p+0xb [xeno_native] (__rt_sem_p+0x5f [xen=
o_native])
fn                  -290 __copy_from_user_ll+0xa (__rt_sem_p+0x53 [xeno_n=
ative])
fn                  -291 ipipe_unstall_pipeline_from+0xc (rt_registry_fet=
ch+0xa4 [xeno_native])
fn                  -292 rt_registry_fetch+0xa [xeno_native] (__rt_sem_p+=
0x39 [xeno_native])
fn                  -293 __rt_sem_p+0xd [xeno_native] (hisyscall_event+0x=
1d1 [xeno_nucleus])
fn                  -296 hisyscall_event+0xe [xeno_nucleus] (__ipipe_disp=
atch_event+0x5e)
fn                  -299 __ipipe_dispatch_event+0xe (__ipipe_syscall_root=
+0x58)
fn                  -300 __ipipe_syscall_root+0x9 (system_call+0x20)
fn                  -341 ipipe_unstall_pipeline_from+0xc (xnshadow_harden=
+0x156 [xeno_nucleus])
fn                  -343 xnpod_switch_fpu+0xa [xeno_nucleus] (xnshadow_ha=
rden+0x137 [xeno_nucleus])
(0x02) 0x0000034b   -344 xnshadow_harden+0x8e [xeno_nucleus] (xnshadow_ma=
p+0x139 [xeno_nucleus])
fn                  -347 __switch_to+0xc (schedule+0x4de)
fn                  -353 xnpod_schedule+0xe [xeno_nucleus] (xnpod_schedul=
e_handler+0x17 [xeno_nucleus])
fn                  -354 xnpod_schedule_handler+0x8 [xeno_nucleus] (__ipi=
pe_sync_stage+0x113)
fn                  -356 __ipipe_sync_stage+0xe (ipipe_suspend_domain+0x4=
7)
fn                  -357 ipipe_suspend_domain+0xb (ipipe_unstall_pipeline=
_from+0x4e)
fn                  -358 ipipe_unstall_pipeline_from+0xc (gatekeeper_thre=
ad+0x18c [xeno_nucleus])
fn                  -362 __ipipe_handle_irq+0xe (ipipe_trigger_irq+0x51)
fn                  -363 memcpy+0xb (ipipe_trigger_irq+0x49)
fn                  -364 ipipe_trigger_irq+0xc (xnpod_schedule+0x29 [xeno=
_nucleus])
fn                  -365 xnpod_schedule+0xe [xeno_nucleus] (gatekeeper_th=
read+0x15e [xeno_nucleus])
fn                  -369 xnpod_schedule_runnable+0xe [xeno_nucleus] (gate=
keeper_thread+0x132 [xeno_nucleus])
fn                  -375 xnpod_resume_thread+0xe [xeno_nucleus] (gatekeep=
er_thread+0xf6 [xeno_nucleus])
(0x01) 0x0000034b   -376 gatekeeper_thread+0xde [xeno_nucleus] (kthread+0=
x71)
fn                  -377 kthread_should_stop+0x8 (gatekeeper_thread+0xa6 =
[xeno_nucleus])
fn                  -379 __ipipe_unstall_root+0x8 (schedule+0x516)
fn                  -381 __switch_to+0xc (schedule+0x4de)
(0x05) 0x00000000   -382 schedule_event+0x78 [xeno_nucleus] (__ipipe_disp=
atch_event+0x5e)
(0x05) 0x00000320   -383 schedule_event+0x6b [xeno_nucleus] (__ipipe_disp=
atch_event+0x5e)
(0x04) 0x00000001   -384 schedule_event+0x5b [xeno_nucleus] (__ipipe_disp=
atch_event+0x5e)
(0x04) 0x0000034b   -385 schedule_event+0x4e [xeno_nucleus] (__ipipe_disp=
atch_event+0x5e)
fn                  -386 schedule_event+0xd [xeno_nucleus] (__ipipe_dispa=
tch_event+0x5e)
fn                  -388 __ipipe_dispatch_event+0xe (schedule+0x3f2)
fn                  -390 __ipipe_stall_root+0x8 (schedule+0x16e)
fn                  -392 sched_clock+0xd (schedule+0xf2)
fn                  -393 profile_hit+0x9 (schedule+0x62)
fn                  -394 schedule+0xe (preempt_schedule+0x4d)
fn                  -395 __ipipe_test_root+0x8 (preempt_schedule+0x2c)
fn                  -396 preempt_schedule+0xb (__wake_up_sync+0xa5)
fn                  -397 irq_exit+0x8 (__ipipe_sync_stage+0xfe)
fn                  -398 __ipipe_unstall_iret_root+0x8 (restore_raw+0x0)
fn                  -400 __ipipe_stall_root+0x8 (resume_kernel+0x5)
fn                  -402 preempt_schedule+0xb (try_to_wake_up+0xee)
fn                  -403 __ipipe_restore_root+0x8 (try_to_wake_up+0xb7)
fn                  -404 enqueue_task+0xa (activate_task+0x5d)
fn                  -405 sched_clock+0xd (activate_task+0x13)
fn                  -406 activate_task+0xb (try_to_wake_up+0x7d)
fn                  -407 __ipipe_test_and_stall_root+0x8 (try_to_wake_up+=
0x13)
fn                  -408 try_to_wake_up+0xb (wake_up_process+0x12)
fn                  -409 wake_up_process+0x8 (lostage_handler+0xd2 [xeno_=
nucleus])
fn                  -411 lostage_handler+0xa [xeno_nucleus] (rthal_apc_ha=
ndler+0x2c)
fn                  -412 rthal_apc_handler+0x8 (__ipipe_sync_stage+0xf1)
fn                  -414 __ipipe_sync_stage+0xe (__ipipe_unstall_root+0x2=
6)
fn                  -415 __ipipe_unstall_root+0x8 (__ipipe_restore_root+0=
x2b)
fn                  -416 __ipipe_restore_root+0x8 (__wake_up_sync+0x6b)
fn                  -418 __ipipe_restore_root+0x8 (try_to_wake_up+0xb7)
fn                  -419 enqueue_task+0xa (activate_task+0x5d)
fn                  -421 sched_clock+0xd (activate_task+0x13)
fn                  -422 activate_task+0xb (try_to_wake_up+0x7d)
fn                  -428 __switch_to+0xc (xnpod_schedule+0x9be [xeno_nucl=
eus])
fn                  -431 xnpod_schedule+0xe [xeno_nucleus] (xnpod_suspend=
_thread+0x7a7 [xeno_nucleus])
fn                  -436 xnpod_suspend_thread+0xe [xeno_nucleus] (xnshado=
w_relax+0x116 [xeno_nucleus])
fn                  -446 xnpod_schedule_runnable+0xe [xeno_nucleus] (xnsh=
adow_relax+0xde [xeno_nucleus])
(0x03) 0x0000034c   -447 xnshadow_relax+0x8f [xeno_nucleus] (hisyscall_ev=
ent+0x289 [xeno_nucleus])
fn                  -450 __ipipe_schedule_irq+0xa (rthal_apc_schedule+0x3=
4)
fn                  -451 rthal_apc_schedule+0x8 (schedule_linux_call+0x7e=
 [xeno_nucleus])
fn                  -453 ipipe_unstall_pipeline_from+0xc (schedule_linux_=
call+0x73 [xeno_nucleus])
fn                  -455 schedule_linux_call+0x9 [xeno_nucleus] (xnshadow=
_relax+0x80 [xeno_nucleus])
fn                  -456 xnshadow_relax+0xb [xeno_nucleus] (hisyscall_eve=
nt+0x289 [xeno_nucleus])
fn                  -457 hisyscall_event+0xe [xeno_nucleus] (__ipipe_disp=
atch_event+0x5e)
fn                  -458 __ipipe_dispatch_event+0xe (__ipipe_syscall_root=
+0x58)
fn                  -459 __ipipe_syscall_root+0x9 (system_call+0x20)
fn                  -463 __copy_to_user_ll+0xa (__rt_mutex_inquire+0x6f [=
xeno_native])
fn                  -465 ipipe_unstall_pipeline_from+0xc (rt_mutex_inquir=
e+0x79 [xeno_native])
fn                  -466 rt_mutex_inquire+0xb [xeno_native] (__rt_mutex_i=
nquire+0x5c [xeno_native])
fn                  -467 ipipe_unstall_pipeline_from+0xc (rt_registry_fet=
ch+0xa4 [xeno_native])
fn                  -468 rt_registry_fetch+0xa [xeno_native] (__rt_mutex_=
inquire+0x48 [xeno_native])
fn                  -470 __rt_mutex_inquire+0xe [xeno_native] (hisyscall_=
event+0x1d1 [xeno_nucleus])
fn                  -472 hisyscall_event+0xe [xeno_nucleus] (__ipipe_disp=
atch_event+0x5e)
fn                  -472 __ipipe_dispatch_event+0xe (__ipipe_syscall_root=
+0x58)
fn                  -473 __ipipe_syscall_root+0x9 (system_call+0x20)
fn                  -477 ipipe_unstall_pipeline_from+0xc (rt_mutex_lock+0=
x122 [xeno_native])
fn                  -479 rt_mutex_lock+0xc [xeno_native] (__rt_mutex_lock=
+0x63 [xeno_native])
fn                  -480 ipipe_unstall_pipeline_from+0xc (rt_registry_fet=
ch+0xa4 [xeno_native])
fn                  -482 rt_registry_fetch+0xa [xeno_native] (__rt_mutex_=
lock+0x49 [xeno_native])
fn                  -483 __copy_from_user_ll+0xa (__rt_mutex_lock+0x41 [x=
eno_native])
fn                  -484 __rt_mutex_lock+0xd [xeno_native] (hisyscall_eve=
nt+0x1d1 [xeno_nucleus])
fn                  -487 hisyscall_event+0xe [xeno_nucleus] (__ipipe_disp=
atch_event+0x5e)
fn                  -487 __ipipe_dispatch_event+0xe (__ipipe_syscall_root=
+0x58)
fn                  -488 __ipipe_syscall_root+0x9 (system_call+0x20)
fn                  -494 ipipe_unstall_pipeline_from+0xc (xnpod_suspend_t=
hread+0x7ef [xeno_nucleus])
fn                  -500 __switch_to+0xc (xnpod_schedule+0x9be [xeno_nucl=
eus])
fn                  -507 xnpod_schedule+0xe [xeno_nucleus] (xnintr_irq_ha=
ndler+0x74 [xeno_nucleus])
fn                  -514 xnpod_resume_thread+0xe [xeno_nucleus] (xnthread=
_timeout_handler+0x1d [xeno_nucleus])
fn                  -515 xnthread_timeout_handler+0x8 [xeno_nucleus] (xnt=
imer_do_tick_aperiodic+0x1f1 [xeno_nucleus])
fn                  -519 xntimer_do_tick_aperiodic+0xe [xeno_nucleus] (xn=
pod_announce_tick+0xd6 [xeno_nucleus])
fn                  -521 xnpod_announce_tick+0xb [xeno_nucleus] (xnintr_i=
rq_handler+0x28 [xeno_nucleus])
fn                  -522 xnintr_irq_handler+0xb [xeno_nucleus] (xnintr_cl=
ock_handler+0x18 [xeno_nucleus])
fn                  -523 xnintr_clock_handler+0x8 [xeno_nucleus] (__ipipe=
_sync_stage+0x113)
fn                  -525 __ipipe_sync_stage+0xe (ipipe_suspend_domain+0x4=
7)
fn                  -526 ipipe_suspend_domain+0xb (__ipipe_handle_irq+0x1=
5f)
fn                  -528 mask_and_ack_8259A+0xb (__ipipe_ack_common_irq+0=
x47)
fn                  -530 __ipipe_ack_common_irq+0x9 (__ipipe_handle_irq+0=
xc0)
fn                  -531 __ipipe_handle_irq+0xe (common_interrupt+0x18)
fn                  -534 __ipipe_test_and_stall_root+0x8 (try_to_wake_up+=
0x13)
fn                  -535 try_to_wake_up+0xb (default_wake_function+0x19)
fn                  -536 default_wake_function+0x8 (__wake_up_common+0x2a=
)
fn                  -537 __wake_up_common+0xb (__wake_up_sync+0x5e)
fn                  -537 __ipipe_test_and_stall_root+0x8 (__wake_up_sync+=
0x2a)
fn                  -538 __wake_up_sync+0xd (xnshadow_harden+0x7f [xeno_n=
ucleus])
fn                  -540 __ipipe_test_root+0x8 (__might_sleep+0x1e)
fn                  -540 __might_sleep+0x9 (xnshadow_harden+0x45 [xeno_nu=
cleus])
fn                  -542 xnshadow_harden+0xb [xeno_nucleus] (xnshadow_map=
+0x139 [xeno_nucleus])
fn                  -544 xnpod_schedule+0xe [xeno_nucleus] (xnpod_schedul=
e_handler+0x17 [xeno_nucleus])
fn                  -546 xnpod_schedule_handler+0x8 [xeno_nucleus] (__ipi=
pe_sync_stage+0x113)
fn                  -547 __ipipe_sync_stage+0xe (ipipe_suspend_domain+0x4=
7)
fn                  -548 ipipe_suspend_domain+0xb (__ipipe_handle_irq+0x1=
5f)
fn                  -551 __ipipe_handle_irq+0xe (ipipe_trigger_irq+0x51)
fn                  -553 memcpy+0xb (ipipe_trigger_irq+0x49)
fn                  -554 ipipe_trigger_irq+0xc (xnpod_schedule+0x29 [xeno=
_nucleus])
fn                  -555 xnpod_schedule+0xe [xeno_nucleus] (xnpod_start_t=
hread+0x1ea [xeno_nucleus])
fn                  -556 ipipe_unstall_pipeline_from+0xc (xnshadow_start+=
0x59 [xeno_nucleus])
fn                  -559 xnpod_resume_thread+0xe [xeno_nucleus] (xnshadow=
_start+0x2c [xeno_nucleus])
fn                  -560 xnshadow_start+0xa [xeno_nucleus] (xnpod_start_t=
hread+0x1e3 [xeno_nucleus])
fn                  -561 ipipe_unstall_pipeline_from+0xc (xnpod_start_thr=
ead+0x1db [xeno_nucleus])
fn                  -564 xnpod_start_thread+0xe [xeno_nucleus] (xnshadow_=
map+0x134 [xeno_nucleus])
fn                  -566 ipipe_unstall_pipeline_from+0xc (xnpod_suspend_t=
hread+0x7ef [xeno_nucleus])
fn                  -568 xnpod_suspend_thread+0xe [xeno_nucleus] (xnshado=
w_map+0xf2 [xeno_nucleus])
fn                  -571 __ipipe_unstall_root+0x8 (schedule+0x516)
fn                  -574 __switch_to+0xc (schedule+0x4de)
(0x05) 0x00000000   -576 schedule_event+0x78 [xeno_nucleus] (__ipipe_disp=
atch_event+0x5e)
(0x05) 0x0000034b   -577 schedule_event+0x6b [xeno_nucleus] (__ipipe_disp=
atch_event+0x5e)
(0x04) 0x00000001   -577 schedule_event+0x5b [xeno_nucleus] (__ipipe_disp=
atch_event+0x5e)
(0x04) 0x00000320   -578 schedule_event+0x4e [xeno_nucleus] (__ipipe_disp=
atch_event+0x5e)
fn                  -579 schedule_event+0xd [xeno_nucleus] (__ipipe_dispa=
tch_event+0x5e)
fn                  -580 __ipipe_dispatch_event+0xe (schedule+0x3f2)
fn                  -583 dequeue_task+0xa (deactivate_task+0x1a)
fn                  -584 deactivate_task+0x9 (schedule+0x1fe)
fn                  -586 __ipipe_stall_root+0x8 (schedule+0x16e)
fn                  -588 sched_clock+0xd (schedule+0xf2)
fn                  -589 profile_hit+0x9 (schedule+0x62)
fn                  -590 schedule+0xe (gatekeeper_thread+0xa1 [xeno_nucle=
us])
fn                  -596 __switch_to+0xc (xnpod_schedule+0x9be [xeno_nucl=
eus])
fn                  -601 xnpod_schedule+0xe [xeno_nucleus] (xnpod_suspend=
_thread+0x7a7 [xeno_nucleus])
fn                  -609 xntimer_do_start_aperiodic+0xe [xeno_nucleus] (x=
ntimer_start+0x37 [xeno_nucleus])
fn                  -611 xntimer_start+0x9 [xeno_nucleus] (xnpod_suspend_=
thread+0x797 [xeno_nucleus])
fn                  -614 xnpod_suspend_thread+0xe [xeno_nucleus] (rt_task=
_sleep+0x54 [xeno_native])
fn                  -615 rt_task_sleep+0xa [xeno_native] (__rt_task_sleep=
+0x25 [xeno_native])
fn                  -617 __copy_from_user_ll+0xa (__rt_task_sleep+0x1a [x=
eno_native])
fn                  -618 __rt_task_sleep+0xa [xeno_native] (hisyscall_eve=
nt+0x1d1 [xeno_nucleus])
fn                  -621 hisyscall_event+0xe [xeno_nucleus] (__ipipe_disp=
atch_event+0x5e)
fn                  -622 __ipipe_dispatch_event+0xe (__ipipe_syscall_root=
+0x58)
fn                  -623 __ipipe_syscall_root+0x9 (system_call+0x20)
fn                  -637 ipipe_unstall_pipeline_from+0xc (rt_mutex_unlock=
+0xdf [xeno_native])
fn                  -640 xnsynch_wakeup_one_sleeper+0xe [xeno_nucleus] (r=
t_mutex_unlock+0x92 [xeno_native])
fn                  -642 rt_mutex_unlock+0xb [xeno_native] (__rt_mutex_un=
lock+0x43 [xeno_native])

--------------010208020400060401070006--

--------------enigE5250FBF12E43E310574964E
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFD0N7bniDOoMHTA+kRAtT4AJ4+SryoMk26HxTdpf7DXzbECrQuyACfSXJ3
ZPmWPl9Gtb8GA1IeadNGgWg=
=xi0P
-----END PGP SIGNATURE-----

--------------enigE5250FBF12E43E310574964E--

