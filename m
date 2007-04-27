Message-ID: <463248EE.5000606@domain.hid>
Date: Fri, 27 Apr 2007 21:03:10 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig17C00B43818CC9E83BA2FD27"
Sender: jan.kiszka@domain.hid
Subject: [Adeos-main] [PATCH 8/7] Optimise cpuid passing (i386)
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: </public/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: adeos-main <adeos-main@gna.org>
Cc: Philippe Gerum <rpm@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig17C00B43818CC9E83BA2FD27
Content-Type: multipart/mixed;
 boundary="------------000209090802040500000008"

This is a multi-part message in MIME format.
--------------000209090802040500000008
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Looking at a disassembled kernel (Mathias' MSI issue...), I got some
idea how to optimise the I-pipe-internal cpuid passing, and I applied it
on further functions.

With the help of the preprocessor, we now eliminate any cpuid parameters
on UP completely, save a few bytes around __ipipe_walk_pipeline. And on
SMP, we don't have to reload it in internal functions that are called by
others who already did so. I think this is faster than consulting the
hardware (via the __ipipe_logical_cpuid indirection).

Only prototyped on i386, just build-tested, so it should be no problem
to apply...

Jan

--------------000209090802040500000008
Content-Type: text/plain;
 name="optimise-cpuid.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline;
 filename="optimise-cpuid.patch"

---
 include/linux/ipipe.h |   21 ++++++++++++++++-----
 kernel/ipipe/core.c   |   29 ++++++++++++++---------------
 2 files changed, 30 insertions(+), 20 deletions(-)

Index: linux-2.6.20/include/linux/ipipe.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-2.6.20.orig/include/linux/ipipe.h
+++ linux-2.6.20/include/linux/ipipe.h
@@ -95,6 +95,7 @@
=20
 #define IPIPE_NR_CPUS		NR_CPUS
 #define ipipe_declare_cpuid	int cpuid
+#define ipipe_define_up_cpuid	do { } while (0)
 #define ipipe_load_cpuid()	do { \
 					cpuid =3D ipipe_processor_id();	\
 				} while(0)
@@ -111,6 +112,7 @@
=20
 #define IPIPE_NR_CPUS		1
 #define ipipe_declare_cpuid	const int cpuid =3D 0
+#define ipipe_define_up_cpuid	ipipe_declare_cpuid
 #define ipipe_load_cpuid()	do { } while(0)
 #define ipipe_lock_cpu(flags)	local_irq_save_hw(flags)
 #define ipipe_unlock_cpu(flags)	local_irq_restore_hw(flags)
@@ -304,15 +306,24 @@ void __ipipe_remove_domain_proc(struct i
=20
 void __ipipe_flush_printk(unsigned irq, void *cookie);
=20
-void fastcall __ipipe_walk_pipeline(struct list_head *pos, int cpuid);
-
 int fastcall __ipipe_schedule_irq(unsigned irq, struct list_head *head);=

=20
 int fastcall __ipipe_dispatch_event(unsigned event, void *data);
=20
-int fastcall __ipipe_dispatch_wired(struct ipipe_domain *head, unsigned =
irq);
+#ifndef CONFIG_SMP
+/* Eliminate cpuid parameter */
+#define __ipipe_dispatch_wired(head, irq, cpuid) \
+	__ipipe_dispatch_wired(head, irq)
+#define __ipipe_sync_stage(syncmask, cpuid)	__ipipe_sync_stage(syncmask)=

+#define __ipipe_walk_pipeline(pos, cpuid)	__ipipe_walk_pipeline(pos)
+#endif /* !CONFIG_SMP */
+
+int __ipipe_dispatch_wired(struct ipipe_domain *head, unsigned irq,
+			   int cpuid);
+
+void __ipipe_sync_stage(unsigned long syncmask, int cpuid);
=20
-void fastcall __ipipe_sync_stage(unsigned long syncmask);
+void __ipipe_walk_pipeline(struct list_head *pos, int cpuid);
=20
 void __ipipe_pin_range_globally(unsigned long start, unsigned long end);=

=20
@@ -322,7 +333,7 @@ int __ipipe_pin_range_mapping(struct mm_
 			      unsigned long start, unsigned long end);
=20
 #ifndef __ipipe_sync_pipeline
-#define __ipipe_sync_pipeline(syncmask) __ipipe_sync_stage(syncmask)
+#define __ipipe_sync_pipeline(syncmask, cpuid) __ipipe_sync_stage(syncma=
sk, cpuid)
 #endif
=20
 #ifndef __ipipe_run_irqtail
Index: linux-2.6.20/kernel/ipipe/core.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-2.6.20.orig/kernel/ipipe/core.c
+++ linux-2.6.20/kernel/ipipe/core.c
@@ -198,7 +198,7 @@ void __ipipe_unstall_root(void)
         __clear_bit(IPIPE_STALL_FLAG, &ipipe_root_domain->cpudata[cpuid]=
=2Estatus);
=20
         if (unlikely(ipipe_root_domain->cpudata[cpuid].irq_pending_hi !=3D=
 0))
-                __ipipe_sync_pipeline(IPIPE_IRQMASK_ANY);
+                __ipipe_sync_pipeline(IPIPE_IRQMASK_ANY, cpuid);
=20
         local_irq_enable_hw();
 }
@@ -316,7 +316,7 @@ void ipipe_unstall_pipeline_head(void)
=20
 	if (unlikely(head->cpudata[cpuid].irq_pending_hi !=3D 0)) {
 		if (likely(head =3D=3D per_cpu(ipipe_percpu_domain, cpuid)))
-			__ipipe_sync_pipeline(IPIPE_IRQMASK_ANY);
+			__ipipe_sync_pipeline(IPIPE_IRQMASK_ANY, cpuid);
 		else
 			__ipipe_walk_pipeline(&head->p_link, cpuid);
         }
@@ -352,7 +352,7 @@ void fastcall __ipipe_restore_pipeline_h
 		__clear_bit(IPIPE_STALL_FLAG, &head->cpudata[cpuid].status);
 		if (unlikely(head->cpudata[cpuid].irq_pending_hi !=3D 0)) {
 			if (likely(head =3D=3D per_cpu(ipipe_percpu_domain, cpuid)))
-				__ipipe_sync_pipeline(IPIPE_IRQMASK_ANY);
+				__ipipe_sync_pipeline(IPIPE_IRQMASK_ANY, cpuid);
 			else
 				__ipipe_walk_pipeline(&head->p_link, cpuid);
 		}
@@ -363,8 +363,9 @@ void fastcall __ipipe_restore_pipeline_h
 /* __ipipe_walk_pipeline(): Plays interrupts pending in the log. Must
    be called with local hw interrupts disabled. */
=20
-void fastcall __ipipe_walk_pipeline(struct list_head *pos, int cpuid)
+void __ipipe_walk_pipeline(struct list_head *pos, int cpuid)
 {
+	ipipe_define_up_cpuid;
 	struct ipipe_domain *this_domain =3D per_cpu(ipipe_percpu_domain, cpuid=
);
=20
 	while (pos !=3D &__ipipe_pipeline) {
@@ -378,7 +379,7 @@ void fastcall __ipipe_walk_pipeline(stru
 		if (next_domain->cpudata[cpuid].irq_pending_hi !=3D 0) {
=20
 			if (next_domain =3D=3D this_domain)
-				__ipipe_sync_pipeline(IPIPE_IRQMASK_ANY);
+				__ipipe_sync_pipeline(IPIPE_IRQMASK_ANY, cpuid);
 			else {
 				__ipipe_switch_to(this_domain, next_domain,
 						  cpuid);
@@ -389,7 +390,7 @@ void fastcall __ipipe_walk_pipeline(stru
 				    irq_pending_hi !=3D 0
 				    && !test_bit(IPIPE_STALL_FLAG,
 						 &this_domain->cpudata[cpuid].status))
-					__ipipe_sync_pipeline(IPIPE_IRQMASK_ANY);
+					__ipipe_sync_pipeline(IPIPE_IRQMASK_ANY, cpuid);
 			}
=20
 			break;
@@ -438,7 +439,7 @@ void ipipe_suspend_domain(void)
 		per_cpu(ipipe_percpu_domain, cpuid) =3D next_domain;
=20
 sync_stage:
-		__ipipe_sync_pipeline(IPIPE_IRQMASK_ANY);
+		__ipipe_sync_pipeline(IPIPE_IRQMASK_ANY, cpuid);
=20
 		ipipe_load_cpuid();	/* Processor might have changed. */
=20
@@ -663,7 +664,7 @@ int fastcall __ipipe_dispatch_event (uns
 		    next_domain->cpudata[cpuid].irq_pending_hi !=3D 0 &&
 		    !test_bit(IPIPE_STALL_FLAG,&next_domain->cpudata[cpuid].status)) {=

 			per_cpu(ipipe_percpu_domain, cpuid) =3D next_domain;
-			__ipipe_sync_pipeline(IPIPE_IRQMASK_ANY);
+			__ipipe_sync_pipeline(IPIPE_IRQMASK_ANY, cpuid);
 			ipipe_load_cpuid();
 			if (per_cpu(ipipe_percpu_domain, cpuid) !=3D next_domain)
 				this_domain =3D per_cpu(ipipe_percpu_domain, cpuid);
@@ -706,13 +707,12 @@ int fastcall __ipipe_dispatch_event (uns
  * Called with hw interrupts off.
  */
=20
-int fastcall __ipipe_dispatch_wired(struct ipipe_domain *head, unsigned =
irq)
+int __ipipe_dispatch_wired(struct ipipe_domain *head, unsigned irq, int =
cpuid)
 {
 	struct ipcpudata *cpudata;
 	struct ipipe_domain *old;
-	ipipe_declare_cpuid;
+	ipipe_define_up_cpuid;
=20
-	ipipe_load_cpuid();
 	cpudata =3D &head->cpudata[cpuid];
 	cpudata->irq_counters[irq].total_hits++;
=20
@@ -762,16 +762,15 @@ int fastcall __ipipe_dispatch_wired(stru
  *
  * This routine must be called with hw interrupts off.
  */
-void fastcall __ipipe_sync_stage(unsigned long syncmask)
+void __ipipe_sync_stage(unsigned long syncmask, int cpuid)
 {
 	unsigned long mask, submask;
 	struct ipcpudata *cpudata;
 	struct ipipe_domain *ipd;
-	ipipe_declare_cpuid;
 	int level, rank;
 	unsigned irq;
+	ipipe_define_up_cpuid;
=20
-	ipipe_load_cpuid();
 	ipd =3D per_cpu(ipipe_percpu_domain, cpuid);
 	cpudata =3D &ipd->cpudata[cpuid];
=20
@@ -931,7 +930,7 @@ int ipipe_register_domain(struct ipipe_d
 		if (ipipe_root_domain->cpudata[cpuid].irq_pending_hi !=3D 0 &&
 		    !test_bit(IPIPE_STALL_FLAG,
 			      &ipipe_root_domain->cpudata[cpuid].status))
-			__ipipe_sync_pipeline(IPIPE_IRQMASK_ANY);
+			__ipipe_sync_pipeline(IPIPE_IRQMASK_ANY, cpuid);
=20
 		ipipe_unlock_cpu(flags);
 	}


--------------000209090802040500000008
Content-Type: text/plain;
 name="optimise-cpuid-i386.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline;
 filename="optimise-cpuid-i386.patch"

---
 arch/i386/kernel/ipipe.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

Index: linux-2.6.20/arch/i386/kernel/ipipe.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-2.6.20.orig/arch/i386/kernel/ipipe.c
+++ linux-2.6.20/arch/i386/kernel/ipipe.c
@@ -574,7 +574,7 @@ asmlinkage void __ipipe_unstall_iret_roo
=20
 		if ((ipipe_root_domain->cpudata[cpuid].
 		     irq_pending_hi & IPIPE_IRQMASK_VIRT) !=3D 0)
-			__ipipe_sync_pipeline(IPIPE_IRQMASK_VIRT);
+			__ipipe_sync_pipeline(IPIPE_IRQMASK_VIRT, cpuid);
 	}
 #ifdef CONFIG_IPIPE_TRACE_IRQSOFF
 	ipipe_trace_end(0x8000000D);
@@ -612,7 +612,7 @@ asmlinkage int __ipipe_syscall_root(stru
 			 * is tested. */
 			ipipe_lock_cpu(flags);
 			if ((ipipe_root_domain->cpudata[cpuid].irq_pending_hi & IPIPE_IRQMASK=
_VIRT) !=3D 0)
-				__ipipe_sync_pipeline(IPIPE_IRQMASK_VIRT);
+				__ipipe_sync_pipeline(IPIPE_IRQMASK_VIRT, cpuid);
 			ipipe_unlock_cpu(flags);
 			return -1;
 		}
@@ -785,7 +785,7 @@ int __ipipe_handle_irq(struct pt_regs re
 	if (likely(test_bit(IPIPE_WIRED_FLAG, &next_domain->irqs[irq].control))=
) {
 		if (!m_ack && next_domain->irqs[irq].acknowledge !=3D NULL)
 			next_domain->irqs[irq].acknowledge(irq);
-		if (likely(__ipipe_dispatch_wired(next_domain, irq))) {
+		if (likely(__ipipe_dispatch_wired(next_domain, irq, cpuid))) {
 			ipipe_load_cpuid();
 			goto finalize;
 		} else


--------------000209090802040500000008--

--------------enig17C00B43818CC9E83BA2FD27
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFGMkjvniDOoMHTA+kRAmR8AJ4zfba4CptmxNP9rXbKxaonzzFfGACfXF9F
lBe1nQf/B3aiLLEfZeWyUkk=
=wPHP
-----END PGP SIGNATURE-----

--------------enig17C00B43818CC9E83BA2FD27--

