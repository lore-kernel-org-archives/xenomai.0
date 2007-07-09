Message-ID: <4691E1D7.5030204@domain.hid>
Date: Mon, 09 Jul 2007 09:20:55 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig8C0A1AB449E948905FC3A0A9"
Sender: jan.kiszka@domain.hid
Subject: [Adeos-main] [PATCHES] Cleanups for 1.9-00
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: </public/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: Philippe Gerum <rpm@xenomai.org>
Cc: adeos-main <adeos-main@gna.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig8C0A1AB449E948905FC3A0A9
Content-Type: multipart/mixed;
 boundary="------------080201080106080809030307"

This is a multi-part message in MIME format.
--------------080201080106080809030307
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Philippe,

here are a few rebased cleanups from my patch stack you may want to
consider in parts or in all for the final 2.6.22 patch:

ipipe-janitorial.patch
refactor-ipipe_walk_pipeline.patch
cleanup-processor_id-i386.patch

More patches will be updated once I can alse rebase the lttng stuff
against 2.6.22.

Jan

--------------080201080106080809030307
Content-Type: text/x-patch;
 name="ipipe-janitorial.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline;
 filename="ipipe-janitorial.patch"

---
 arch/i386/kernel/io_apic.c        |    1 +
 arch/i386/mach-generic/bigsmp.c   |    1 -
 arch/i386/mach-generic/default.c  |    1 -
 arch/i386/mach-generic/es7000.c   |    1 -
 arch/i386/mach-generic/summit.c   |    1 -
 arch/i386/mach-visws/visws_apic.c |    1 +
 include/linux/smp.h               |    2 --
 7 files changed, 2 insertions(+), 6 deletions(-)

Index: linux-2.6.22-ipipe/arch/i386/kernel/io_apic.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-2.6.22-ipipe.orig/arch/i386/kernel/io_apic.c
+++ linux-2.6.22-ipipe/arch/i386/kernel/io_apic.c
@@ -2044,6 +2044,7 @@ static struct irq_chip ioapic_chip __rea
 	.retrigger	=3D ioapic_retrigger_irq,
 };
=20
+
 static inline void init_IO_APIC_traps(void)
 {
 	int irq;
Index: linux-2.6.22-ipipe/arch/i386/mach-generic/bigsmp.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-2.6.22-ipipe.orig/arch/i386/mach-generic/bigsmp.c
+++ linux-2.6.22-ipipe/arch/i386/mach-generic/bigsmp.c
@@ -14,7 +14,6 @@
 #include <linux/smp.h>
 #include <linux/init.h>
 #include <linux/dmi.h>
-#include <linux/ipipe.h>
 #include <asm/mach-bigsmp/mach_apic.h>
 #include <asm/mach-bigsmp/mach_apicdef.h>
 #include <asm/mach-bigsmp/mach_ipi.h>
Index: linux-2.6.22-ipipe/arch/i386/mach-generic/default.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-2.6.22-ipipe.orig/arch/i386/mach-generic/default.c
+++ linux-2.6.22-ipipe/arch/i386/mach-generic/default.c
@@ -13,7 +13,6 @@
 #include <linux/string.h>
 #include <linux/smp.h>
 #include <linux/init.h>
-#include <linux/ipipe.h>
 #include <asm/mach-default/mach_apic.h>
 #include <asm/mach-default/mach_ipi.h>
 #include <asm/mach-default/mach_mpparse.h>
Index: linux-2.6.22-ipipe/arch/i386/mach-generic/es7000.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-2.6.22-ipipe.orig/arch/i386/mach-generic/es7000.c
+++ linux-2.6.22-ipipe/arch/i386/mach-generic/es7000.c
@@ -13,7 +13,6 @@
 #include <linux/string.h>
 #include <linux/smp.h>
 #include <linux/init.h>
-#include <linux/ipipe.h>
 #include <asm/mach-es7000/mach_apicdef.h>
 #include <asm/mach-es7000/mach_apic.h>
 #include <asm/mach-es7000/mach_ipi.h>
Index: linux-2.6.22-ipipe/arch/i386/mach-generic/summit.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-2.6.22-ipipe.orig/arch/i386/mach-generic/summit.c
+++ linux-2.6.22-ipipe/arch/i386/mach-generic/summit.c
@@ -13,7 +13,6 @@
 #include <linux/string.h>
 #include <linux/smp.h>
 #include <linux/init.h>
-#include <linux/ipipe.h>
 #include <asm/mach-summit/mach_apic.h>
 #include <asm/mach-summit/mach_apicdef.h>
 #include <asm/mach-summit/mach_ipi.h>
Index: linux-2.6.22-ipipe/arch/i386/mach-visws/visws_apic.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-2.6.22-ipipe.orig/arch/i386/mach-visws/visws_apic.c
+++ linux-2.6.22-ipipe/arch/i386/mach-visws/visws_apic.c
@@ -131,6 +131,7 @@ static struct irq_chip cobalt_irq_type =3D
 	.end =3D		end_cobalt_irq,
 };
=20
+
 /*
  * This is the PIIX4-based 8259 that is wired up indirectly to Cobalt
  * -- not the manner expected by the code in i8259.c.
Index: linux-2.6.22-ipipe/include/linux/smp.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-2.6.22-ipipe.orig/include/linux/smp.h
+++ linux-2.6.22-ipipe/include/linux/smp.h
@@ -107,8 +107,6 @@ static inline int smp_call_function_sing
=20
 #endif /* !SMP */
=20
-#include <linux/ipipe_base.h>
-
 /*
  * smp_processor_id(): get the current CPU ID.
  *

--------------080201080106080809030307
Content-Type: text/x-patch;
 name="refactor-ipipe_walk_pipeline.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline;
 filename="refactor-ipipe_walk_pipeline.patch"

---
 include/linux/ipipe.h |    2 +-
 kernel/ipipe/core.c   |   14 +++++++++-----
 2 files changed, 10 insertions(+), 6 deletions(-)

Index: linux-2.6.22-ipipe/include/linux/ipipe.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-2.6.22-ipipe.orig/include/linux/ipipe.h
+++ linux-2.6.22-ipipe/include/linux/ipipe.h
@@ -261,7 +261,7 @@ void __ipipe_remove_domain_proc(struct i
=20
 void __ipipe_flush_printk(unsigned irq, void *cookie);
=20
-void fastcall __ipipe_walk_pipeline(struct list_head *pos, int cpuid);
+void __ipipe_walk_pipeline(struct list_head *pos);
=20
 int fastcall __ipipe_schedule_irq(unsigned irq, struct list_head *head);=

=20
Index: linux-2.6.22-ipipe/kernel/ipipe/core.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-2.6.22-ipipe.orig/kernel/ipipe/core.c
+++ linux-2.6.22-ipipe/kernel/ipipe/core.c
@@ -380,7 +380,7 @@ void fastcall ipipe_unstall_pipeline_fro
 	else
 		pos =3D __ipipe_pipeline.next;
=20
-	__ipipe_walk_pipeline(pos, cpuid);
+	__ipipe_walk_pipeline(pos);
=20
 	if (__ipipe_pipeline_head_p(ipd))
 		local_irq_enable_hw();
@@ -424,7 +424,7 @@ void ipipe_unstall_pipeline_head(void)
 		if (likely(head =3D=3D per_cpu(ipipe_percpu_domain, cpuid)))
 			__ipipe_sync_pipeline(IPIPE_IRQMASK_ANY);
 		else
-			__ipipe_walk_pipeline(&head->p_link, cpuid);
+			__ipipe_walk_pipeline(&head->p_link);
         }
=20
 	local_irq_enable_hw();
@@ -460,7 +460,7 @@ void fastcall __ipipe_restore_pipeline_h
 			if (likely(head =3D=3D per_cpu(ipipe_percpu_domain, cpuid)))
 				__ipipe_sync_pipeline(IPIPE_IRQMASK_ANY);
 			else
-				__ipipe_walk_pipeline(&head->p_link, cpuid);
+				__ipipe_walk_pipeline(&head->p_link);
 		}
 		local_irq_enable_hw();
 	}
@@ -522,9 +522,13 @@ void fastcall __ipipe_spin_unlock_irqres
 /* __ipipe_walk_pipeline(): Plays interrupts pending in the log. Must
    be called with local hw interrupts disabled. */
=20
-void fastcall __ipipe_walk_pipeline(struct list_head *pos, int cpuid)
+void __ipipe_walk_pipeline(struct list_head *pos)
 {
-	struct ipipe_domain *this_domain =3D per_cpu(ipipe_percpu_domain, cpuid=
);
+	struct ipipe_domain *this_domain;
+	ipipe_declare_cpuid;
+
+	ipipe_load_cpuid();
+	this_domain =3D per_cpu(ipipe_percpu_domain, cpuid);
=20
 	while (pos !=3D &__ipipe_pipeline) {
 		struct ipipe_domain *next_domain =3D

--------------080201080106080809030307
Content-Type: text/x-patch;
 name="cleanup-processor_id-i386.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline;
 filename="cleanup-processor_id-i386.patch"

---
 arch/i386/kernel/ipipe.c   |    2 +-
 arch/i386/kernel/process.c |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

Index: linux-2.6.22-ipipe/arch/i386/kernel/ipipe.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-2.6.22-ipipe.orig/arch/i386/kernel/ipipe.c
+++ linux-2.6.22-ipipe/arch/i386/kernel/ipipe.c
@@ -814,7 +814,7 @@ finalize:
 	 * current domain in the pipeline.
 	 */
=20
-	__ipipe_walk_pipeline(head, cpuid);
+	__ipipe_walk_pipeline(head);
=20
 	ipipe_load_cpuid();
=20
Index: linux-2.6.22-ipipe/arch/i386/kernel/process.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-2.6.22-ipipe.orig/arch/i386/kernel/process.c
+++ linux-2.6.22-ipipe/arch/i386/kernel/process.c
@@ -644,7 +644,7 @@ struct task_struct fastcall * __switch_t
 {
 	struct thread_struct *prev =3D &prev_p->thread,
 				 *next =3D &next_p->thread;
-	int cpu =3D raw_smp_processor_id();
+	int cpu =3D smp_processor_id();
 	struct tss_struct *tss =3D &per_cpu(init_tss, cpu);
=20
 	/* never put a printk in __switch_to... printk() calls wake_up*() indir=
ectly */

--------------080201080106080809030307--

--------------enig8C0A1AB449E948905FC3A0A9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iD8DBQFGkeHXniDOoMHTA+kRAjMtAJ0QVK3Z8Dk7/jBxaZ7xpOt52kS5CgCaAzZh
zyyg/K+jqsfHcNtyurXzLzE=
=dRoA
-----END PGP SIGNATURE-----

--------------enig8C0A1AB449E948905FC3A0A9--

