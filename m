Message-ID: <4776D48E.7050002@domain.hid>
Date: Sun, 30 Dec 2007 00:13:18 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig6B5621321177A2B25F20C07F"
Sender: jan.kiszka@domain.hid
Subject: [Adeos-main] [PATCH 4/5] remove legacy code
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
--------------enig6B5621321177A2B25F20C07F
Content-Type: multipart/mixed;
 boundary="------------000402070407010604060107"

This is a multi-part message in MIME format.
--------------000402070407010604060107
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

This patch gets rid of code that is no longer needed or valid:

 - x86_64 APIC frequency is now delivered via ipipe_request_tickdev
 - __ipipe_tick_irq is maintained via ipipe_update_tick_evtdev also on
   x86_64
 - global_clock_event is no longer needed by ipipe_32.c
 - ipipe_tune_timer was dead code in x86_64 (there was no prototype in
   whatever header), and this arch does not really have a legacy code
   base to maintain, so kill this function

Jan

--------------000402070407010604060107
Content-Type: text/x-patch;
 name="remove-legacy.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline;
 filename="remove-legacy.patch"

---
 arch/x86/kernel/apic_64.c       |    6 ------
 arch/x86/kernel/ipipe_32.c      |    2 --
 arch/x86/kernel/ipipe_64.c      |   10 +---------
 include/asm-x86/ipipe_64.h      |   21 +++++++++++----------
 include/asm-x86/ipipe_base_64.h |    4 ----
 5 files changed, 12 insertions(+), 31 deletions(-)

Index: linux-2.6.24-rc6-xeno/arch/x86/kernel/apic_64.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-2.6.24-rc6-xeno.orig/arch/x86/kernel/apic_64.c
+++ linux-2.6.24-rc6-xeno/arch/x86/kernel/apic_64.c
@@ -939,9 +939,6 @@ static void __init calibrate_APIC_clock(
=20
 	printk(KERN_INFO "Detected %d.%03d MHz APIC timer.\n",
 		result / 1000 / 1000, result / 1000 % 1000);
-#ifdef CONFIG_IPIPE
-	__ipipe_apic_timer_freq =3D result;
-#endif
=20
 	/* Calculate the scaled math multiplication factor */
 	lapic_clockevent.mult =3D div_sc(result, NSEC_PER_SEC, 32);
@@ -970,9 +967,6 @@ void __init setup_boot_APIC_clock (void)
 	}
=20
 	printk(KERN_INFO "Using local APIC timer interrupts.\n");
-#ifdef CONFIG_IPIPE
-	__ipipe_tick_irq =3D ipipe_apic_vector_irq(LOCAL_TIMER_VECTOR);
-#endif
 	calibrate_APIC_clock();
=20
 	/*
Index: linux-2.6.24-rc6-xeno/arch/x86/kernel/ipipe_64.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-2.6.24-rc6-xeno.orig/arch/x86/kernel/ipipe_64.c
+++ linux-2.6.24-rc6-xeno/arch/x86/kernel/ipipe_64.c
@@ -46,8 +46,7 @@
=20
 asmlinkage void preempt_schedule_irq(void);
=20
-int __ipipe_tick_irq;
-unsigned long __ipipe_apic_timer_freq;
+int __ipipe_tick_irq =3D TIMER_IRQ;
=20
 DEFINE_PER_CPU(struct pt_regs, __ipipe_tick_regs);
=20
@@ -102,12 +101,6 @@ int ipipe_get_sysinfo(struct ipipe_sysin
 	return 0;
 }
=20
-int ipipe_tune_timer(unsigned long ns, int flags)
-{
-	printk(KERN_WARNING "I-pipe: %s is deprecated - no action taken\n", __F=
UNCTION__);
-	return -ENOSYS;
-}
-
 asmlinkage unsigned int do_IRQ(struct pt_regs *regs);
 asmlinkage void smp_apic_timer_interrupt(struct pt_regs *regs);
 asmlinkage void smp_spurious_interrupt(struct pt_regs *regs);
@@ -792,7 +785,6 @@ EXPORT_SYMBOL(ipipe_critical_enter);
 EXPORT_SYMBOL(ipipe_critical_exit);
 EXPORT_SYMBOL(ipipe_trigger_irq);
 EXPORT_SYMBOL(ipipe_get_sysinfo);
-EXPORT_SYMBOL(ipipe_tune_timer);
=20
 EXPORT_SYMBOL_GPL(irq_desc);
 struct task_struct *__switch_to(struct task_struct *prev_p,
Index: linux-2.6.24-rc6-xeno/include/asm-x86/ipipe_64.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-2.6.24-rc6-xeno.orig/include/asm-x86/ipipe_64.h
+++ linux-2.6.24-rc6-xeno/include/asm-x86/ipipe_64.h
@@ -79,13 +79,6 @@ extern unsigned cpu_khz;
 #define ipipe_tsc2ns(t)	(((t) * 1000UL) / (ipipe_cpu_freq() / 1000000UL)=
)
 #define ipipe_tsc2us(t)	((t) / (ipipe_cpu_freq() / 1000000UL))
=20
-/*
- * The following interface will be deprecated once generic clockevents
- * are supported by this architecture, at which point
- * ipipe_request_tickdev() should be used instead.
- */
-extern unsigned long __ipipe_apic_timer_freq;
-
 /* Private interface -- Internal use only */
=20
 #define __ipipe_check_platform()	do { } while(0)
@@ -125,6 +118,15 @@ static inline unsigned long __ipipe_ffnz
       return ul;
 }
=20
+#define ipipe_update_tick_evtdev(evtdev)				\
+	do {								\
+		if (strcmp((evtdev)->name, "lapic") =3D=3D 0)		\
+			__ipipe_tick_irq =3D				\
+				ipipe_apic_vector_irq(LOCAL_TIMER_VECTOR); \
+		else							\
+			__ipipe_tick_irq =3D TIMER_IRQ;			\
+	} while (0)
+
 struct irq_desc;
=20
 void __ipipe_ack_edge_irq(unsigned irq, struct irq_desc *desc);
@@ -236,10 +238,9 @@ int __ipipe_check_tickdev(const char *de
=20
 #else /* !CONFIG_IPIPE */
=20
-#define task_hijacked(p)	0
+#define ipipe_update_tick_evtdev(evtdev)	do { } while (0)
+#define task_hijacked(p)			0
=20
 #endif /* CONFIG_IPIPE */
=20
-#define ipipe_update_tick_evtdev(evtdev)	do { } while (0)
-
 #endif	/* !__X86_IPIPE_64_H */
Index: linux-2.6.24-rc6-xeno/include/asm-x86/ipipe_base_64.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-2.6.24-rc6-xeno.orig/include/asm-x86/ipipe_base_64.h
+++ linux-2.6.24-rc6-xeno/include/asm-x86/ipipe_base_64.h
@@ -182,8 +182,4 @@ static inline unsigned long __ipipe_test
=20
 #endif /* !__ASSEMBLY__ */
=20
-/* Arch-dependent features */
-
-#define __IPIPE_FEATURE_APIC_TIMER_FREQ  1
-
 #endif	/* !__X86_IPIPE_BASE_64_H */
Index: linux-2.6.24-rc6-xeno/arch/x86/kernel/ipipe_32.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-2.6.24-rc6-xeno.orig/arch/x86/kernel/ipipe_32.c
+++ linux-2.6.24-rc6-xeno/arch/x86/kernel/ipipe_32.c
@@ -48,8 +48,6 @@
 #include <mach_ipi.h>
 #endif	/* CONFIG_X86_LOCAL_APIC */
=20
-extern struct clock_event_device *global_clock_event;
-
 int __ipipe_tick_irq =3D TIMER_IRQ;
=20
 DEFINE_PER_CPU(struct pt_regs, __ipipe_tick_regs);

--------------000402070407010604060107--

--------------enig6B5621321177A2B25F20C07F
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.4-svn0 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iD8DBQFHdtSOniDOoMHTA+kRAvspAJ4oephXG3c1xsiuNHwciE9CWT6VQQCfWW/2
gmvcLcjMTvncy7mMpBjc/jw=
=i40R
-----END PGP SIGNATURE-----

--------------enig6B5621321177A2B25F20C07F--

