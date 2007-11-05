Message-ID: <472F6DAD.20308@domain.hid>
Date: Mon, 05 Nov 2007 20:23:25 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <472F6C17.2070100@domain.hid>
In-Reply-To: <472F6C17.2070100@domain.hid>
Content-Type: multipart/mixed; boundary="------------090307060101040205040706"
Subject: Re: [Xenomai-core] [Adeos-main] [PATCH] i386: switch to root domain
 on unhandled non-root faults
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: adeos-main@gna.org
Cc: Xenomai-core@domain.hid

This is a multi-part message in MIME format.
--------------090307060101040205040706
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Jan Kiszka wrote:
> This patch addresses the recently discovered issue that I-pipe actually
> need to deal with faults over non-root domain in which the current
> domain shows no interest in. Such faults could be triggered inside
> copy_*_user, thus can cleanly be handled by Linux - if we only allow for
> this. Currently, if debugging is on, we warn about a potential bug, and
> corrupt the pipeline states otherwise.
> 
> The new approach is to unconditionally drop to root domain in such
> cases, but - for debugging purposes of non-fixable faults - keep track
> of the original domain and report it on oops.
> 
> Similar patches are required for other archs. Maybe I can look into
> x86_64 later.
> 
> Jan

[Damn it... now with attachment.]

-- 
Siemens AG, Corporate Technology, CT SE 2
Corporate Competence Center Embedded Linux

--------------090307060101040205040706
Content-Type: text/x-patch;
 name="handle-fixable-non-root-faults.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="handle-fixable-non-root-faults.patch"

---
 arch/i386/kernel/ipipe.c     |   27 +++++++++++++++------------
 arch/i386/kernel/traps.c     |    3 ++-
 include/linux/ipipe.h        |    1 +
 include/linux/ipipe_percpu.h |    1 +
 kernel/ipipe/core.c          |    1 +
 5 files changed, 20 insertions(+), 13 deletions(-)

Index: linux-2.6.23.1-xeno/arch/i386/kernel/ipipe.c
===================================================================
--- linux-2.6.23.1-xeno.orig/arch/i386/kernel/ipipe.c
+++ linux-2.6.23.1-xeno/arch/i386/kernel/ipipe.c
@@ -634,7 +634,7 @@ fastcall int __ipipe_handle_exception(st
 	}
 
 #ifdef CONFIG_KGDB
-	/* catch exception KGDB is interested in over non-root domains */
+	/* catch exceptions KGDB is interested in over non-root domains */
 	if (!ipipe_root_domain_p &&
 	    __ipipe_xlate_signo[vector] >= 0 &&
 	    !kgdb_handle_exception(vector, __ipipe_xlate_signo[vector], error_code, regs)) {
@@ -643,18 +643,21 @@ fastcall int __ipipe_handle_exception(st
 	}
 #endif /* CONFIG_KGDB */
 
-	if (!ipipe_trap_notify(vector, regs)) {
-#ifdef CONFIG_IPIPE_DEBUG
-		if (!ipipe_root_domain_p) {
-			/* Fix up domain so that Linux can handle this. */
+	if (likely(!ipipe_trap_notify(vector, regs))) {
+		if (unlikely(!ipipe_root_domain_p)) {
+			struct ipipe_domain *prev_orig = ipipe_orig_domain;
+
+			/* Drop to root domain so that Linux can handle the
+			 * fault, but save the original domain for reporting
+			 * purposes of oopses over non-root contexts. */
+			ipipe_orig_domain = ipipe_current_domain;
 			ipipe_current_domain = ipipe_root_domain;
-			ipipe_trace_panic_freeze();
-			printk(KERN_ERR "BUG: Unhandled exception over domain"
-					" %s - switching to ROOT\n",
-					ipipe_current_domain->name);
-		}
-#endif /* CONFIG_IPIPE_DEBUG */
-		__ipipe_std_extable[vector](regs, error_code);
+
+			__ipipe_std_extable[vector](regs, error_code);
+
+			ipipe_orig_domain = prev_orig;
+		} else
+			__ipipe_std_extable[vector](regs, error_code);
 		local_irq_restore(flags);
 		__fixup_if(regs);
 		return 0;
Index: linux-2.6.23.1-xeno/arch/i386/kernel/traps.c
===================================================================
--- linux-2.6.23.1-xeno.orig/arch/i386/kernel/traps.c
+++ linux-2.6.23.1-xeno/arch/i386/kernel/traps.c
@@ -321,7 +321,8 @@ void show_registers(struct pt_regs *regs
 		TASK_COMM_LEN, current->comm, current->pid,
 		current_thread_info(), current, task_thread_info(current));
 #ifdef CONFIG_IPIPE
-	printk(KERN_EMERG "\nI-pipe domain %s", ipipe_current_domain->name);
+	printk(KERN_EMERG "\nI-pipe domain %s", ipipe_orig_domain ?
+	       ipipe_orig_domain->name : ipipe_current_domain->name);
 #endif /* CONFIG_IPIPE */
 	/*
 	 * When in-kernel, we also print out the stack and code at the
Index: linux-2.6.23.1-xeno/include/linux/ipipe.h
===================================================================
--- linux-2.6.23.1-xeno.orig/include/linux/ipipe.h
+++ linux-2.6.23.1-xeno/include/linux/ipipe.h
@@ -83,6 +83,7 @@
 #define IPIPE_NR_CPUS		NR_CPUS
 
 #define ipipe_current_domain	ipipe_cpu_var(ipipe_percpu_domain)
+#define ipipe_orig_domain	ipipe_cpu_var(ipipe_percpu_orig_domain)
 
 #define ipipe_virtual_irq_p(irq)	((irq) >= IPIPE_VIRQ_BASE && \
 					 (irq) < IPIPE_NR_IRQS)
Index: linux-2.6.23.1-xeno/include/linux/ipipe_percpu.h
===================================================================
--- linux-2.6.23.1-xeno.orig/include/linux/ipipe_percpu.h
+++ linux-2.6.23.1-xeno/include/linux/ipipe_percpu.h
@@ -52,6 +52,7 @@ DECLARE_PER_CPU(struct ipipe_percpu_doma
 DECLARE_PER_CPU(struct ipipe_percpu_domain_data, ipipe_percpu_darray[CONFIG_IPIPE_DOMAINS]);
 
 DECLARE_PER_CPU(struct ipipe_domain *, ipipe_percpu_domain);
+DECLARE_PER_CPU(struct ipipe_domain *, ipipe_percpu_orig_domain);
 
 #ifdef CONFIG_IPIPE_DEBUG_CONTEXT
 DECLARE_PER_CPU(int, ipipe_percpu_context_check);
Index: linux-2.6.23.1-xeno/kernel/ipipe/core.c
===================================================================
--- linux-2.6.23.1-xeno.orig/kernel/ipipe/core.c
+++ linux-2.6.23.1-xeno/kernel/ipipe/core.c
@@ -78,6 +78,7 @@ DEFINE_PER_CPU(struct ipipe_percpu_domai
 { [0] = { .status = IPIPE_STALL_MASK } }; /* Root domain stalled on each CPU at startup. */
 
 DEFINE_PER_CPU(struct ipipe_domain *, ipipe_percpu_domain) = { &ipipe_root };
+DEFINE_PER_CPU(struct ipipe_domain *, ipipe_percpu_orig_domain) = { NULL };
 
 static IPIPE_DEFINE_SPINLOCK(__ipipe_pipelock);
 

--------------090307060101040205040706--

