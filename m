Message-ID: <4630F27D.3090109@domain.hid>
Date: Thu, 26 Apr 2007 20:42:05 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig896349E900058DE2094DC63E"
Sender: jan.kiszka@domain.hid
Subject: [Adeos-main] [PATCH 6/7] Optimise root domain stalling (i386/x86_64)
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
--------------enig896349E900058DE2094DC63E
Content-Type: multipart/mixed;
 boundary="------------030802020906000301080205"

This is a multi-part message in MIME format.
--------------030802020906000301080205
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

[This patch is a remake of
https://mail.gna.org/public/adeos-main/2006-09/msg00013.html]

For the !SMP case, we can inline a few stalling services for the root
domain. This required reordering ipipe_domain slightly so that
cpudata[0].status is also the first field. This assumes that there was
not specific optimisation involved in the previous layout, correct me if
I'm wrong.

Earlier measurements showed a slight performance increase of Linux over
I-pipe, specifically on low-end (no functions calls, just simple bit
fiddling for the stall that any arch should be able to handle with one
or two ops).

Jan

--------------030802020906000301080205
Content-Type: text/plain;
 name="optimise-root-stall-v3.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline;
 filename="optimise-root-stall-v3.patch"

---
 include/linux/ipipe.h      |   12 ++----------
 include/linux/ipipe_base.h |   39 +++++++++++++++++++++++++++++++++++++-=
-
 kernel/ipipe/core.c        |   40 ++++++++++++++++++++++----------------=
--
 3 files changed, 61 insertions(+), 30 deletions(-)

Index: linux-2.6.20/include/linux/ipipe.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-2.6.20.orig/include/linux/ipipe.h
+++ linux-2.6.20/include/linux/ipipe.h
@@ -53,13 +53,6 @@
 #define IPIPE_SPRINTK_FLAG	0	/* Synchronous printk() allowed */
 #define IPIPE_AHEAD_FLAG	1	/* Domain always heads the pipeline */
=20
-/* Per-cpu pipeline status */
-#define IPIPE_STALL_FLAG	0	/* Stalls a pipeline stage -- guaranteed at b=
it #0 */
-#define IPIPE_SYNC_FLAG		1	/* The interrupt syncer is running for the do=
main */
-#define IPIPE_NOSTACK_FLAG	2	/* Domain currently runs on a foreign stack=
 */
-
-#define IPIPE_SYNC_MASK		(1 << IPIPE_SYNC_FLAG)
-
 /* Interrupt control bits */
 #define IPIPE_HANDLE_FLAG	0
 #define IPIPE_PASS_FLAG		1
@@ -142,10 +135,8 @@ typedef int (*ipipe_event_handler_t)(uns
 				     void *data);
 struct ipipe_domain {
=20
-	struct list_head p_link;	/* Link in pipeline */
-
 	struct ipcpudata {
-		unsigned long status;
+		unsigned long status;	/* Must be first in ipipe_domain */
 		unsigned long irq_pending_hi;
 		unsigned long irq_pending_lo[IPIPE_IRQ_IWORDS];
 		struct ipirqcnt {
@@ -162,6 +153,7 @@ struct ipipe_domain {
 		void *cookie;
 	} ____cacheline_aligned irqs[IPIPE_NR_IRQS];
=20
+	struct list_head p_link;	/* Link in pipeline */
 	ipipe_event_handler_t evhand[IPIPE_NR_EVENTS]; /* Event handlers. */
 	unsigned long long evself;	/* Self-monitored event bits. */
 	unsigned long flags;
Index: linux-2.6.20/include/linux/ipipe_base.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-2.6.20.orig/include/linux/ipipe_base.h
+++ linux-2.6.20/include/linux/ipipe_base.h
@@ -25,19 +25,54 @@
=20
 #ifdef CONFIG_IPIPE
=20
+/* Per-cpu pipeline status */
+#define IPIPE_STALL_FLAG	0	/* Stalls a pipeline stage -- guaranteed at b=
it #0 */
+#define IPIPE_SYNC_FLAG		1	/* The interrupt syncer is running for the do=
main */
+#define IPIPE_NOSTACK_FLAG	2	/* Domain currently runs on a foreign stack=
 */
+
+#define IPIPE_SYNC_MASK		(1 << IPIPE_SYNC_FLAG)
+
+
 extern struct ipipe_domain ipipe_root;
=20
 #define ipipe_root_domain (&ipipe_root)
=20
=20
-void __ipipe_stall_root(void);
+#ifdef CONFIG_SMP
=20
-void __ipipe_unstall_root(void);
+void __ipipe_stall_root(void);
=20
 unsigned long __ipipe_test_root(void);
=20
 unsigned long __ipipe_test_and_stall_root(void);
=20
+#else /* !CONFIG_SMP */
+
+/*
+ * Note: This cast relies on cpudata[0].status being the first element i=
n the
+ *       root domain structure (for UP only).
+ */
+#define __ipipe_root_status	(unsigned long *)&ipipe_root
+
+static inline void __ipipe_stall_root(void)
+{
+	set_bit(IPIPE_STALL_FLAG, __ipipe_root_status);
+}
+
+static inline unsigned long __ipipe_test_root(void)
+{
+	return test_bit(IPIPE_STALL_FLAG, __ipipe_root_status);
+}
+
+static inline unsigned long __ipipe_test_and_stall_root(void)
+{
+	return test_and_set_bit(IPIPE_STALL_FLAG, __ipipe_root_status);
+}
+
+#endif /* !CONFIG_SMP */
+
+void __ipipe_unstall_root(void);
+
 void __ipipe_restore_root(unsigned long x);
=20
 #endif	/* CONFIG_IPIPE */
Index: linux-2.6.20/kernel/ipipe/core.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-2.6.20.orig/kernel/ipipe/core.c
+++ linux-2.6.20/kernel/ipipe/core.c
@@ -147,6 +147,7 @@ void __ipipe_cleanup_domain(struct ipipe
 #endif	/* CONFIG_SMP */
 }
=20
+#ifdef CONFIG_SMP
 void __ipipe_stall_root(void)
 {
 	ipipe_declare_cpuid;
@@ -157,22 +158,6 @@ void __ipipe_stall_root(void)
 	ipipe_put_cpu(flags);
 }
=20
-void __ipipe_unstall_root(void)
-{
-	ipipe_declare_cpuid;
-
-	local_irq_disable_hw();
-
-	ipipe_load_cpuid();
-
-	__clear_bit(IPIPE_STALL_FLAG, &ipipe_root_domain->cpudata[cpuid].status=
);
-
-	if (unlikely(ipipe_root_domain->cpudata[cpuid].irq_pending_hi !=3D 0))
-		__ipipe_sync_pipeline(IPIPE_IRQMASK_ANY);
-
-	local_irq_enable_hw();
-}
-
 unsigned long __ipipe_test_root(void)
 {
 	unsigned long flags, x;
@@ -197,6 +182,23 @@ unsigned long __ipipe_test_and_stall_roo
=20
 	return x;
 }
+#endif /* CONFIG_SMP */
+
+void __ipipe_unstall_root(void)
+{
+        ipipe_declare_cpuid;
+
+        local_irq_disable_hw();
+
+        ipipe_load_cpuid();
+
+        __clear_bit(IPIPE_STALL_FLAG, &ipipe_root_domain->cpudata[cpuid]=
=2Estatus);
+
+        if (unlikely(ipipe_root_domain->cpudata[cpuid].irq_pending_hi !=3D=
 0))
+                __ipipe_sync_pipeline(IPIPE_IRQMASK_ANY);
+
+        local_irq_enable_hw();
+}
=20
 void __ipipe_restore_root(unsigned long x)
 {
@@ -1395,10 +1397,12 @@ EXPORT_SYMBOL(ipipe_test_and_unstall_pip
 EXPORT_SYMBOL(ipipe_unstall_pipeline_head);
 EXPORT_SYMBOL(__ipipe_restore_pipeline_head);
 EXPORT_SYMBOL(__ipipe_unstall_root);
-EXPORT_SYMBOL(__ipipe_stall_root);
 EXPORT_SYMBOL(__ipipe_restore_root);
-EXPORT_SYMBOL(__ipipe_test_and_stall_root);
+#ifdef CONFIG_SMP
+EXPORT_SYMBOL(__ipipe_stall_root);
 EXPORT_SYMBOL(__ipipe_test_root);
+EXPORT_SYMBOL(__ipipe_test_and_stall_root);
+#endif /* CONFIG_SMP */
 EXPORT_SYMBOL(__ipipe_pipeline);
 EXPORT_SYMBOL(ipipe_register_domain);
 EXPORT_SYMBOL(ipipe_unregister_domain);

--------------030802020906000301080205
Content-Type: text/plain;
 name="optimise-root-stall-i386.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline;
 filename="optimise-root-stall-i386.patch"

---
 include/asm-i386/irqflags.h |   20 ++++++++++++++++++--
 1 file changed, 18 insertions(+), 2 deletions(-)

Index: linux-2.6.20/include/asm-i386/irqflags.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-2.6.20.orig/include/asm-i386/irqflags.h
+++ linux-2.6.20/include/asm-i386/irqflags.h
@@ -24,6 +24,7 @@ static inline unsigned long __raw_local_
=20
 #ifdef CONFIG_IPIPE
 	flags =3D (!__ipipe_test_root()) << 9;
+	barrier();
 #else
 	__asm__ __volatile__(
 		"pushfl ; popl %0"
@@ -38,6 +39,7 @@ static inline unsigned long __raw_local_
 static inline void raw_local_irq_restore(unsigned long flags)
 {
 #ifdef CONFIG_IPIPE
+	barrier();
 	__ipipe_restore_root(!(flags & 0x200));
 #else
 	__asm__ __volatile__(
@@ -53,6 +55,7 @@ static inline void raw_local_irq_disable
 {
 #ifdef CONFIG_IPIPE
 	__ipipe_stall_root();
+	barrier();
 #else
 	__asm__ __volatile__("cli" : : : "memory");
 #endif
@@ -61,6 +64,7 @@ static inline void raw_local_irq_disable
 static inline void raw_local_irq_enable(void)
 {
 #ifdef CONFIG_IPIPE
+	barrier();
 	__ipipe_unstall_root();
 #else
 	__asm__ __volatile__("sti" : : : "memory");
@@ -96,17 +100,29 @@ static inline void halt(void)
  */
 static inline unsigned long __raw_local_irq_save(void)
 {
+#ifdef CONFIG_IPIPE
+	unsigned long flags =3D (!__ipipe_test_and_stall_root()) << 9;
+
+	barrier();
+#else
 	unsigned long flags =3D __raw_local_save_flags();
=20
 	raw_local_irq_disable();
-
+#endif
 	return flags;
 }
=20
 #else
=20
 #ifdef CONFIG_IPIPE
-#define DISABLE_INTERRUPTS(clobbers)		call __ipipe_stall_root	;  sti
+#ifdef CONFIG_SMP
+#define DISABLE_INTERRUPTS(clobbers)		call __ipipe_stall_root; sti
+#else /* !CONFIG_SMP */
+/*
+ * Disable IRQs =3D=3D set IPIPE_STALL_FLAG in ipipe_root.cpudata[0].sta=
tus
+ */
+#define DISABLE_INTERRUPTS(clobbers)		btsl $0,ipipe_root; sti
+#endif /* !CONFIG_SMP */
 #define ENABLE_INTERRUPTS(clobbers)		call __ipipe_unstall_root
 #define ENABLE_INTERRUPTS_HW_COND		sti
 #define DISABLE_INTERRUPTS_HW(clobbers)    	cli

--------------030802020906000301080205
Content-Type: text/plain;
 name="optimise-root-stall-x86_64.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline;
 filename="optimise-root-stall-x86_64.patch"

---
 include/asm-x86_64/irqflags.h |   11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

Index: linux-2.6.20-x64/include/asm-x86_64/irqflags.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-2.6.20-x64.orig/include/asm-x86_64/irqflags.h
+++ linux-2.6.20-x64/include/asm-x86_64/irqflags.h
@@ -24,6 +24,7 @@ static inline unsigned long __raw_local_
=20
 #ifdef CONFIG_IPIPE
 	flags =3D (!__ipipe_test_root()) << 9;
+	barrier();
 #else
 	__asm__ __volatile__(
 		"# __raw_save_flags\n\t"
@@ -43,6 +44,7 @@ static inline unsigned long __raw_local_
 static inline void raw_local_irq_restore(unsigned long flags)
 {
 #ifdef CONFIG_IPIPE
+	barrier();
 	__ipipe_restore_root(!(flags & 0x200));
 #else
 	__asm__ __volatile__(
@@ -85,6 +87,7 @@ static inline void raw_local_irq_disable
 {
 #ifdef CONFIG_IPIPE
 	__ipipe_stall_root();
+	barrier();
 #else
 	__asm__ __volatile__("cli" : : : "memory");
 #endif
@@ -93,6 +96,7 @@ static inline void raw_local_irq_disable
 static inline void raw_local_irq_enable(void)
 {
 #ifdef CONFIG_IPIPE
+	barrier();
 	__ipipe_unstall_root();
 #else
 	__asm__ __volatile__("sti" : : : "memory");
@@ -112,10 +116,15 @@ static inline int raw_irqs_disabled_flag
=20
 static inline unsigned long __raw_local_irq_save(void)
 {
+#ifdef CONFIG_IPIPE
+	unsigned long flags =3D (!__ipipe_test_and_stall_root()) << 9;
+
+	barrier();
+#else
 	unsigned long flags =3D __raw_local_save_flags();
=20
 	raw_local_irq_disable();
-
+#endif
 	return flags;
 }
=20

--------------030802020906000301080205--

--------------enig896349E900058DE2094DC63E
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFGMPJ9niDOoMHTA+kRAs9uAJ9afjuuvCsuj7z/FSobhYaztD9F5ACeMoXk
TZ13oxO/Aadj41xe7Hso0DI=
=1Uic
-----END PGP SIGNATURE-----

--------------enig896349E900058DE2094DC63E--

