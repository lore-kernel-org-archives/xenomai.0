Message-ID: <46EB879C.2050503@domain.hid>
Date: Sat, 15 Sep 2007 09:19:56 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigFAF3703CE1C930139EFF26B5"
Sender: jan.kiszka@domain.hid
Subject: [Adeos-main] [Resent][PATCH] noarch/i386: Remove useless patch hunks
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
--------------enigFAF3703CE1C930139EFF26B5
Content-Type: multipart/mixed;
 boundary="------------070607030203020203070808"

This is a multi-part message in MIME format.
--------------070607030203020203070808
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Still present in latest ipipe - it's really the time to remove them. :->

Jan

--------------070607030203020203070808
Content-Type: text/x-patch;
 name="ipipe-janitorial.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline;
 filename="ipipe-janitorial.patch"

---
 arch/i386/kernel/io_apic.c        |    1 +
 arch/i386/kernel/process.c        |    2 +-
 arch/i386/kernel/traps.c          |    2 +-
 arch/i386/mach-generic/bigsmp.c   |    1 -
 arch/i386/mach-generic/default.c  |    1 -
 arch/i386/mach-generic/es7000.c   |    1 -
 arch/i386/mach-generic/summit.c   |    1 -
 arch/i386/mach-visws/visws_apic.c |    1 +
 include/linux/smp.h               |    2 --
 9 files changed, 4 insertions(+), 8 deletions(-)

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
Index: linux-2.6.22-ipipe/arch/i386/kernel/traps.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-2.6.22-ipipe.orig/arch/i386/kernel/traps.c
+++ linux-2.6.22-ipipe/arch/i386/kernel/traps.c
@@ -759,7 +759,7 @@ static __kprobes void default_do_nmi(str
=20
 fastcall __kprobes void do_nmi(struct pt_regs * regs, long error_code)
 {
-  	int cpu, cs;
+	int cpu, cs;
=20
 	nmi_enter();
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

--------------070607030203020203070808--

--------------enigFAF3703CE1C930139EFF26B5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iD8DBQFG64ecniDOoMHTA+kRAuLzAJsEv2qX9h/oUzYRkcTCIjbLVhr6jwCeNmuo
vGI2s1pH2fpqDyRNJbEOJC0=
=MjJR
-----END PGP SIGNATURE-----

--------------enigFAF3703CE1C930139EFF26B5--

