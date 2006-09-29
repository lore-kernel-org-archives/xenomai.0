Message-ID: <451D38BA.1070105@domain.hid>
Date: Fri, 29 Sep 2006 17:16:10 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <451D338A.1050407@domain.hid>
In-Reply-To: <451D338A.1050407@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig913198829A40339BCD67B75A"
Sender: jan.kiszka@domain.hid
Subject: [Xenomai-core] Re: [Adeos-main] [RFC][PATCH 2/2] detect domain
	violations
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: adeos-main <adeos-main@gna.org>
Cc: xenomai-core <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig913198829A40339BCD67B75A
Content-Type: multipart/mixed; boundary="------------020900050208050108040503"

This is a multi-part message in MIME format.
--------------020900050208050108040503
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Jan Kiszka wrote:
> ...
> This patch is an RFC as the following issues need to be resolved:
>=20
>  o The might be parts of I-pipe remaining that make use of
>    preemp_disable even over non-root contexts. Philippe indicated the
>    PPC PIC code would be one example.

Mmpf, first test, then post. Looks like there are more subtle scenarios
hidden:

> <3>[  121.256585] I-pipe: Detected illicit call from domain 'Xenomai'
> <4>[  121.256616]         into a service reserved for domain 'Linux' an=
d below.
> <4>[  121.256695] I-pipe tracer log (30 points):
> <4>[  121.256729] func                    0 ipipe_trace_panic_freeze+0x=
8 (ipipe_check_context+0x36)
> <4>[  121.256863] func                   -1 ipipe_check_context+0x9 (__=
switch_to+0x34)
> <4>[  121.256951] func                   -2 __switch_to+0xe (xnpod_sche=
dule+0x69b)
> <4>[  121.257039] [   79] gatekee -1    -16 xnpod_schedule+0x84 (xnintr=
_irq_handler+0xa1)
> <4>[  121.257129] func                  -19 xnpod_schedule+0xe (xnintr_=
irq_handler+0xa1)
> <4>[  121.257213] [  868] Odometr 19    -26 xnpod_resume_thread+0x48 (x=
nthread_timeout_handler+0x21)
> <4>[  121.257448] func                  -28 xnpod_resume_thread+0xe (xn=
thread_timeout_handler+0x21)
> <4>[  121.257607] func                  -30 xnthread_timeout_handler+0x=
8 (xntimer_do_tick_aperiodic+0x7b)
> <4>[  121.257779] func                  -33 xntimer_do_tick_aperiodic+0=
xe (xnpod_announce_tick+0x17)
> <4>[  121.257948] func                  -34 xnpod_announce_tick+0xa (xn=
intr_irq_handler+0x2a)

Namely, __switch_to->__unlazy_fpu->save_init_fpu->preempt_disable.
Philippe, looks like killing the ipipe_preempt_guard is not trivial...

Anyway, attached version 2 of this patch enables both stack dump and
ipipe-backtrace.

Jan

--------------020900050208050108040503
Content-Type: text/plain;
 name="ipipe-dbg-dom-violation-v2.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline;
 filename="ipipe-dbg-dom-violation-v2.patch"

---
 arch/i386/kernel/ipipe-root.c |    9 ++++++---
 include/linux/ipipe.h         |    6 ++++++
 include/linux/kernel.h        |   16 ++++++++++++++--
 include/linux/preempt.h       |   11 ++++++++++-
 kernel/ipipe/Kconfig.debug    |    9 +++++++++
 kernel/ipipe/generic.c        |   31 +++++++++++++++++++++++++++++++
 6 files changed, 76 insertions(+), 6 deletions(-)

Index: linux-2.6.17.13/include/linux/ipipe.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-2.6.17.13.orig/include/linux/ipipe.h
+++ linux-2.6.17.13/include/linux/ipipe.h
@@ -694,6 +694,12 @@ int fastcall ipipe_set_ptd(int key,
=20
 void fastcall *ipipe_get_ptd(int key);
=20
+#ifdef CONFIG_IPIPE_DEBUG_CONTEXT
+void fastcall ipipe_check_context(struct ipipe_domain *border_ipd);
+#else /* !CONFIG_IPIPE_DEBUG_CONTEXT */
+#define ipipe_check_context(border_ipd) do { } while (0)
+#endif /* CONFIG_IPIPE_DEBUG_CONTEXT */
+
 #define local_irq_enable_hw_cond()		local_irq_enable_hw()
 #define local_irq_disable_hw_cond()		local_irq_disable_hw()
 #define local_irq_save_hw_cond(flags)	local_irq_save_hw(flags)
Index: linux-2.6.17.13/kernel/ipipe/Kconfig.debug
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-2.6.17.13.orig/kernel/ipipe/Kconfig.debug
+++ linux-2.6.17.13/kernel/ipipe/Kconfig.debug
@@ -2,6 +2,15 @@ config IPIPE_DEBUG
 	bool "I-pipe debugging"
 	depends on IPIPE
=20
+config IPIPE_DEBUG_CONTEXT
+	bool "Check for illicit cross-domain calls"
+	depends on IPIPE_DEBUG
+	---help---
+	  Enable this feature to arm checkpoints in the kernel that
+	  verify the correct invocation context. On entry of critical
+	  Linux services a warning is issued if the caller is not
+	  running over the root domain.
+
 config IPIPE_TRACE
 	bool "Latency tracing"
 	depends on IPIPE_DEBUG
Index: linux-2.6.17.13/kernel/ipipe/generic.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-2.6.17.13.orig/kernel/ipipe/generic.c
+++ linux-2.6.17.13/kernel/ipipe/generic.c
@@ -29,6 +29,9 @@
 #ifdef CONFIG_PROC_FS
 #include <linux/proc_fs.h>
 #endif	/* CONFIG_PROC_FS */
+#ifdef CONFIG_IPIPE_TRACE_MCOUNT
+#include <linux/ipipe_trace.h>
+#endif /* CONFIG_IPIPE_TRACE_MCOUNT */
=20
 MODULE_DESCRIPTION("I-pipe");
 MODULE_LICENSE("GPL");
@@ -410,6 +413,34 @@ void fastcall *ipipe_get_ptd (int key)
 	return current->ptd[key];
 }
=20
+#ifdef CONFIG_IPIPE_DEBUG_CONTEXT
+void fastcall ipipe_check_context(struct ipipe_domain *border_ipd)
+{
+	static int check_hit;
+
+	if (likely(ipipe_current_domain->priority <=3D border_ipd->priority) ||=

+	    check_hit)
+		return;
+
+	check_hit =3D 1;
+
+#ifdef CONFIG_IPIPE_TRACE_MCOUNT
+	ipipe_trace_panic_freeze();
+#endif /* CONFIG_IPIPE_TRACE_MCOUNT */
+	ipipe_set_printk_sync(ipipe_current_domain);
+	printk(KERN_ERR "I-pipe: Detected illicit call from domain '%s'\n"
+	       KERN_ERR "        into a service reserved for domain '%s' and "
+			"below.\n",
+	       ipipe_current_domain->name, border_ipd->name);
+	show_stack(NULL, NULL);
+#ifdef CONFIG_IPIPE_TRACE_MCOUNT
+	ipipe_trace_panic_dump();
+#endif /* CONFIG_IPIPE_TRACE_MCOUNT */
+}
+
+EXPORT_SYMBOL(ipipe_check_context);
+#endif /* CONFIG_IPIPE_DEBUG_CONTEXT */
+
 EXPORT_SYMBOL(ipipe_register_domain);
 EXPORT_SYMBOL(ipipe_unregister_domain);
 EXPORT_SYMBOL(ipipe_free_virq);
Index: linux-2.6.17.13/include/linux/kernel.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-2.6.17.13.orig/include/linux/kernel.h
+++ linux-2.6.17.13/include/linux/kernel.h
@@ -60,11 +60,23 @@ struct user;
  * be biten later when the calling function happens to sleep when it is =
not
  * supposed to.
  */
+
+/* FIXME: This is ugly... */
+extern struct ipipe_domain ipipe_root;
+#ifdef CONFIG_IPIPE_DEBUG_CONTEXT
+void fastcall ipipe_check_context(struct ipipe_domain *border_ipd);
+#else /* !CONFIG_IPIPE_DEBUG_CONTEXT */
+#define ipipe_check_context(border_ipd) do { } while (0)
+#endif /* CONFIG_IPIPE_DEBUG_CONTEXT */
+
 #ifdef CONFIG_PREEMPT_VOLUNTARY
 extern int cond_resched(void);
-# define might_resched() cond_resched()
+# define might_resched() do { \
+		ipipe_check_context(&ipipe_root); \
+		cond_resched(); \
+	} while (0)
 #else
-# define might_resched() do { } while (0)
+# define might_resched() ipipe_check_context(&ipipe_root)
 #endif
=20
 #ifdef CONFIG_DEBUG_SPINLOCK_SLEEP
Index: linux-2.6.17.13/include/linux/preempt.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-2.6.17.13.orig/include/linux/preempt.h
+++ linux-2.6.17.13/include/linux/preempt.h
@@ -23,6 +23,14 @@
=20
 #define preempt_count()	(current_thread_info()->preempt_count)
=20
+/* FIXME: This is ugly... */
+extern struct ipipe_domain ipipe_root;
+#ifdef CONFIG_IPIPE_DEBUG_CONTEXT
+void fastcall ipipe_check_context(struct ipipe_domain *border_ipd);
+#else /* !CONFIG_IPIPE_DEBUG_CONTEXT */
+#define ipipe_check_context(border_ipd) do { } while (0)
+#endif /* CONFIG_IPIPE_DEBUG_CONTEXT */
+
 #ifdef CONFIG_PREEMPT
=20
 asmlinkage void preempt_schedule(void);
@@ -38,6 +46,7 @@ extern struct ipipe_domain ipipe_root;
=20
 #define preempt_disable()						\
 do {									\
+	ipipe_check_context(&ipipe_root);				\
 	if (ipipe_preempt_guard()) {					\
 		inc_preempt_count();					\
 		barrier();						\
@@ -69,7 +78,7 @@ do {									\
=20
 #else
=20
-#define preempt_disable()		do { } while (0)
+#define preempt_disable()		ipipe_check_context(&ipipe_root)
 #define preempt_enable_no_resched()	do { } while (0)
 #define preempt_enable()		do { } while (0)
 #define preempt_check_resched()		do { } while (0)
Index: linux-2.6.17.13/arch/i386/kernel/ipipe-root.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-2.6.17.13.orig/arch/i386/kernel/ipipe-root.c
+++ linux-2.6.17.13/arch/i386/kernel/ipipe-root.c
@@ -70,9 +70,12 @@ static int __ipipe_ack_common_irq(unsign
=20
 	ipipe_load_cpuid();	/* hw interrupts are off. */
 	flags =3D ipipe_test_and_stall_pipeline();
-	preempt_disable();
-	desc->handler->ack(irq);
-	preempt_enable_no_resched();
+	if (ipipe_percpu_domain[cpuid] =3D=3D ipipe_root_domain) {
+		preempt_disable();
+		desc->handler->ack(irq);
+		preempt_enable_no_resched();
+	} else
+		desc->handler->ack(irq);
 	ipipe_restore_pipeline_nosync(ipipe_percpu_domain[cpuid], flags, cpuid)=
;
=20
 	return 1;

--------------020900050208050108040503--

--------------enig913198829A40339BCD67B75A
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFFHTi6niDOoMHTA+kRAnNeAJsHn/PMXW45xXh9GMNKAAU2D8YBxACcCDH2
2/GwRbllVZ4Y7Wh4K2X7LXQ=
=NbPh
-----END PGP SIGNATURE-----

--------------enig913198829A40339BCD67B75A--

