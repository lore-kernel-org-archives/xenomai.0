Message-ID: <48B54F9C.9090405@domain.hid>
Date: Wed, 27 Aug 2008 14:59:08 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Subject: [Adeos-main] [PATCH] Detect leaking stalls of topmost domain
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: </public/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: adeos-main <adeos-main@gna.org>

I just managed to create this infamous bug pattern once again:

function()
{
	stall_topmost_domain();
	...
	if (condition)
		return;
	...
	unstall_topmost_domain();
}

The result is often a locked-up system, specifically the root domain no
longer receives IRQs. Unless you find the bug quickly by code
inspection, debugging/instrumenting can take quite some time.

To catch such issues earlier, I therefore propose the following
extension of ipipe_check_context. It is based on the assumption that the
topmost domain should never be stalled when lower domains execute that
check. This specifically takes care of not breaking Xenomai's IRQ shield
(a mid-prio domain that intentionally blocks Linux IRQs).

This is how this patch sees my bug:

I-pipe: Detected stalled topmost domain, probably caused by a bug.
        A critical section may have been left unterminated.
Pid: 4483, comm: cyclictest Tainted: G        W 2.6.26.2-xeno_64 #55

Call Trace:
 [<ffffffff8026b61b>] ipipe_check_context+0x11e/0x128
 [<ffffffff80474849>] down_write+0x1d/0x2e
 [<ffffffff802c9686>] ipipe_disable_ondemand_mappings+0x41/0x3b3
 [<ffffffff8021ed3c>] ? mcount+0x4c/0x72
 [<ffffffff80283b93>] xnshadow_map+0x65/0x2a6
 [<ffffffff8021ed3c>] ? mcount+0x4c/0x72
 [<ffffffff802b5bc5>] __pthread_setschedparam+0xd3/0x3b9
 [<ffffffff80283840>] losyscall_event+0x11f/0x1ee
 [<ffffffff80283721>] ? losyscall_event+0x0/0x1ee
 [<ffffffff8026c6ad>] __ipipe_dispatch_event+0x127/0x255
 [<ffffffff8021e922>] __ipipe_syscall_root+0xa2/0x194
 [<ffffffff8047555a>] __ipipe_syscall_root_thunk+0x35/0x6a
 [<ffffffff8020c034>] ? system_call_after_swapgs+0x54/0x94

I-pipe tracer log (100 points):
 |  *+func                    0 ipipe_trace_panic_freeze+0xe (ipipe_check_context+0xab)
 |  *+func                    0 find_next_bit+0x9 (__next_cpu+0x1e)
 |  *+func                    0 __next_cpu+0x9 (ipipe_check_context+0x9f)
 |  *+func                   -1 find_first_bit+0x9 (__first_cpu+0x13)
 |  *+func                   -1 __first_cpu+0x9 (ipipe_check_context+0x79)
 |  *+func                   -1 ipipe_check_context+0xc (down_write+0x1d)
 |  *+func                   -1 down_write+0xe (ipipe_disable_ondemand_mappings+0x41)
 |  *+func                   -2 _spin_lock+0x9 (get_task_mm+0x1d)
 |  *+func                   -2 get_task_mm+0xe (ipipe_disable_ondemand_mappings+0x1e)
 |  *+func                   -3 ipipe_disable_ondemand_mappings+0x16 (xnshadow_map+0x65)
 |  *+func                   -3 xnshadow_map+0x12 (__pthread_setschedparam+0xd3)
 |  *+func                   -4 xnsynch_init+0x9 (xnregistry_enter+0xf8)
 |   +begin   0x80000000     -5 xnregistry_enter+0x5b (pthread_create+0x321)
     +func                   -5 strchr+0x9 (xnregistry_enter+0x40)
     +func                   -6 xnregistry_enter+0x16 (pthread_create+0x321)
 |   +end     0x80000000     -6 __ipipe_restore_pipeline_head+0xea (pthread_create+0x309)
 |  *+func                   -6 __ipipe_restore_pipeline_head+0xe (pthread_create+0x309)
 |  *+func                   -7 ppd_lookup_inner+0xe (xnshadow_ppd_get+0x5d)
 |  *+func                   -8 xnshadow_ppd_get+0xd (pthread_create+0x28c)
 |   +begin   0x80000000     -8 pthread_create+0x227 (__pthread_setschedparam+0xb6)

(xnregistry_enter is left with nklock still held. Fix committed.)

Jan

---
 kernel/ipipe/core.c |   20 +++++++++++++++-----
 1 file changed, 15 insertions(+), 5 deletions(-)

Index: b/kernel/ipipe/core.c
===================================================================
--- a/kernel/ipipe/core.c
+++ b/kernel/ipipe/core.c
@@ -1567,7 +1567,9 @@ void ipipe_check_context(struct ipipe_do
 	/* Note: We don't make the per_cpu access atomic. We assume that code
 	   which temporarily disables the check does this in atomic context
 	   only. */
-	if (likely(ipipe_current_domain->priority <= border_ipd->priority) ||
+	if (likely(ipipe_current_domain->priority <= border_ipd->priority &&
+		   !test_bit(IPIPE_STALL_FLAG,
+			     &ipipe_head_cpudom_var(status))) ||
 	    !per_cpu(ipipe_percpu_context_check, ipipe_processor_id()))
 		return;
 
@@ -1575,10 +1577,18 @@ void ipipe_check_context(struct ipipe_do
 
 	ipipe_trace_panic_freeze();
 	ipipe_set_printk_sync(ipipe_current_domain);
-	printk(KERN_ERR "I-pipe: Detected illicit call from domain '%s'\n"
-	       KERN_ERR "        into a service reserved for domain '%s' and "
-			"below.\n",
-	       ipipe_current_domain->name, border_ipd->name);
+
+	if (ipipe_current_domain->priority > border_ipd->priority)
+		printk(KERN_ERR "I-pipe: Detected illicit call from domain "
+				"'%s'\n"
+		       KERN_ERR "        into a service reserved for domain "
+				"'%s' and below.\n",
+		       ipipe_current_domain->name, border_ipd->name);
+	else
+		printk(KERN_ERR "I-pipe: Detected stalled topmost domain, "
+				"probably caused by a bug.\n"
+				"        A critical section may have been "
+				"left unterminated.\n");
 	dump_stack();
 	ipipe_trace_panic_dump();
 }

