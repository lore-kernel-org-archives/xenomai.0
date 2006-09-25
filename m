Message-ID: <451786B3.4020506@domain.hid>
Date: Mon, 25 Sep 2006 09:35:15 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig37C25C43B04218E19E796DB3"
Sender: jan.kiszka@domain.hid
Subject: [Adeos-main] [PATCH+HACK] optimise root stalling
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: </public/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: adeos-main@gna.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig37C25C43B04218E19E796DB3
Content-Type: multipart/mixed; boundary="------------080404070906080304010802"

This is a multi-part message in MIME format.
--------------080404070906080304010802
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

The first one is a real patch, introducing an optimisation of the
stall/unstall-root path of I-pipe. It removes any caring for the
pipeline head case of the root doamin from ipipe_root_stall (something
that was lacking for test_and_stall_root anyway), and it pushes under UP
the IRQ disabling into the less likely __ipipe_sync_pipeline path in
ipipe_unstall_root.

Those two changes together gave me about 5% better Linux performance
under RT-load on a low-end Pentium.

A further idea of mine was to inline light-weight parts of the
__ipipe_*_root API on UP (no SMP at hand to judge on it as well). That's
what the second patch, err, hack is for. It gives another 5% Linux
speedup on x86, but it unfortunately contains some tricky dependency
issues. Of course, it also slightly increases the code size again.

Looking at other linux/ipipe.h duplications, e.g. in linux/preempt.h, it
might be worth considering to derive a basic header that has no further
dependencies and can be included anywhere. Based on such header the
proposed optimisation could be built up more cleanly.

Jan

--------------080404070906080304010802
Content-Type: text/x-patch;
 name="optimise-root-stalling.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline;
 filename="optimise-root-stalling.patch"

---
 kernel/ipipe/core.c |   20 +++++++++++---------
 1 file changed, 11 insertions(+), 9 deletions(-)

Index: linux-2.6.17.13/kernel/ipipe/core.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-2.6.17.13.orig/kernel/ipipe/core.c
+++ linux-2.6.17.13/kernel/ipipe/core.c
@@ -134,16 +134,8 @@ void __ipipe_stall_root(void)
 	unsigned long flags;
=20
 	ipipe_get_cpu(flags); /* Care for migration. */
-
 	set_bit(IPIPE_STALL_FLAG, &ipipe_root_domain->cpudata[cpuid].status);
-
-#ifdef CONFIG_SMP
-	if (!__ipipe_pipeline_head_p(ipipe_root_domain))
-		ipipe_put_cpu(flags);
-#else /* CONFIG_SMP */
-	if (__ipipe_pipeline_head_p(ipipe_root_domain))
-		local_irq_disable_hw();
-#endif /* CONFIG_SMP */
+	ipipe_put_cpu(flags);
 }
=20
 void __ipipe_cleanup_domain(struct ipipe_domain *ipd)
@@ -166,6 +158,7 @@ void __ipipe_unstall_root(void)
 {
 	ipipe_declare_cpuid;
=20
+#ifdef CONFIG_SMP
 	local_irq_disable_hw();
=20
 	ipipe_load_cpuid();
@@ -176,6 +169,15 @@ void __ipipe_unstall_root(void)
 		__ipipe_sync_pipeline(IPIPE_IRQMASK_ANY);
=20
 	local_irq_enable_hw();
+#else	/* !CONFIG_SMP */
+	__clear_bit(IPIPE_STALL_FLAG, &ipipe_root_domain->cpudata[cpuid].status=
);
+
+	if (unlikely(ipipe_root_domain->cpudata[cpuid].irq_pending_hi !=3D 0)) =
{
+		local_irq_disable_hw();
+		__ipipe_sync_pipeline(IPIPE_IRQMASK_ANY);
+		local_irq_enable_hw();
+	}
+#endif	/* CONFIG_SMP */
 }
=20
 unsigned long __ipipe_test_root(void)

--------------080404070906080304010802
Content-Type: text/x-patch;
 name="optimise-root-fastpath-v2.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline;
 filename="optimise-root-fastpath-v2.patch"

---
 arch/i386/kernel/entry.S  |    2 -
 include/asm-i386/system.h |   51 +++++++++++++++++++++++++++++++++++++++=
++++---
 include/linux/ipipe.h     |   34 +++++++++++++++++++++++-------
 kernel/ipipe/core.c       |   26 +++++++++++++----------
 4 files changed, 90 insertions(+), 23 deletions(-)

Index: linux-2.6.17.13/include/linux/ipipe.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-2.6.17.13.orig/include/linux/ipipe.h
+++ linux-2.6.17.13/include/linux/ipipe.h
@@ -356,18 +356,12 @@ void __ipipe_remove_domain_proc(struct i
=20
 void __ipipe_flush_printk(unsigned irq, void *cookie);
=20
-void __ipipe_stall_root(void);
-
-void __ipipe_unstall_root(void);
-
-unsigned long __ipipe_test_root(void);
-
-unsigned long __ipipe_test_and_stall_root(void);
-
 void fastcall __ipipe_walk_pipeline(struct list_head *pos, int cpuid);
=20
 void fastcall __ipipe_restore_root(unsigned long x);
=20
+void __ipipe_unstall_root(void);
+
 int fastcall __ipipe_schedule_irq(unsigned irq, struct list_head *head);=

=20
 int fastcall __ipipe_dispatch_event(unsigned event, void *data);
@@ -403,6 +397,30 @@ cpumask_t __ipipe_set_irq_affinity(unsig
 int fastcall __ipipe_send_ipi(unsigned ipi,
 			      cpumask_t cpumask);
=20
+void __ipipe_stall_root(void);
+
+unsigned long __ipipe_test_root(void);
+
+unsigned long __ipipe_test_and_stall_root(void);
+
+#else /* !CONFIG_SMP */
+
+static inline void __ipipe_stall_root(void)
+{
+	set_bit(IPIPE_STALL_FLAG, &ipipe_root_domain->cpudata[0].status);
+}
+
+static inline unsigned long __ipipe_test_root(void)
+{
+	return test_bit(IPIPE_STALL_FLAG, &ipipe_root_domain->cpudata[0].status=
);
+}
+
+static inline unsigned long __ipipe_test_and_stall_root(void)
+{
+	return test_and_set_bit(IPIPE_STALL_FLAG,
+				&ipipe_root_domain->cpudata[0].status);
+}
+
 #endif /* CONFIG_SMP */
=20
 /* Called with hw interrupts off. */
Index: linux-2.6.17.13/include/asm-i386/system.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-2.6.17.13.orig/include/asm-i386/system.h
+++ linux-2.6.17.13/include/asm-i386/system.h
@@ -462,6 +462,9 @@ static inline unsigned long long __cmpxc
=20
 #include <linux/linkage.h>
=20
+void fastcall __ipipe_restore_root(unsigned long flags);
+
+#ifdef CONFIG_SMP
 void __ipipe_stall_root(void);
=20
 void __ipipe_unstall_root(void);
@@ -470,16 +473,58 @@ unsigned long __ipipe_test_root(void);
=20
 unsigned long __ipipe_test_and_stall_root(void);
=20
-void fastcall __ipipe_restore_root(unsigned long flags);
+#elif !defined(__LINUX_IPIPE_H)
+
+#define HACK_IPIPE_STALL_FLAG	0	/* Stalls a pipeline stage -- guaranteed=
 at bit #0 */
+
+struct __HACK_ipipe_domain {
+
+	void *fill1, *fill2;
+
+	struct {
+		unsigned long status;
+	} cpudata[1];
+};
+
+extern struct ipipe_domain ipipe_root;
+
+#define HACK_ipipe_root_domain ((struct __HACK_ipipe_domain *)&ipipe_roo=
t)
+
+static inline void __HACK_ipipe_stall_root(void)
+{
+	set_bit(HACK_IPIPE_STALL_FLAG, &HACK_ipipe_root_domain->cpudata[0].stat=
us);
+}
+
+static inline unsigned long __HACK_ipipe_test_root(void)
+{
+	return test_bit(HACK_IPIPE_STALL_FLAG, &HACK_ipipe_root_domain->cpudata=
[0].status);
+}
+
+static inline unsigned long __HACK_ipipe_test_and_stall_root(void)
+{
+	return test_and_set_bit(HACK_IPIPE_STALL_FLAG,
+				&HACK_ipipe_root_domain->cpudata[0].status);
+}
+
+#define local_save_flags(x)	((x) =3D (!__HACK_ipipe_test_root()) << 9)
+#define local_irq_save(x)	((x) =3D (!__HACK_ipipe_test_and_stall_root())=
 << 9)
+#define local_irq_disable()	__HACK_ipipe_stall_root()
+
+#define irqs_disabled()		__HACK_ipipe_test_root()
+
+#else
=20
 #define local_save_flags(x)	((x) =3D (!__ipipe_test_root()) << 9)
 #define local_irq_save(x)	((x) =3D (!__ipipe_test_and_stall_root()) << 9=
)
-#define local_irq_restore(x)	__ipipe_restore_root(!(x & 0x200))
 #define local_irq_disable()	__ipipe_stall_root()
-#define local_irq_enable()	__ipipe_unstall_root()
=20
 #define irqs_disabled()		__ipipe_test_root()
=20
+#endif
+
+#define local_irq_restore(x)	__ipipe_restore_root(!(x & 0x200))
+#define local_irq_enable()	__ipipe_unstall_root()
+
 #define halt()	__asm__ __volatile__("hlt": : :"memory")
=20
 #ifdef CONFIG_IPIPE_TRACE_IRQSOFF
Index: linux-2.6.17.13/arch/i386/kernel/entry.S
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-2.6.17.13.orig/arch/i386/kernel/entry.S
+++ linux-2.6.17.13/arch/i386/kernel/entry.S
@@ -77,7 +77,7 @@ NT_MASK		=3D 0x00004000
 VM_MASK		=3D 0x00020000
=20
 #ifdef CONFIG_IPIPE
-#define CLI                     call __ipipe_stall_root	;  sti
+#define CLI                     btsl $0,ipipe_root+0x8
 #define STI                     call __ipipe_unstall_root
 #define STI_COND_HW             sti
 #define EMULATE_ROOT_IRET(bypass) \
Index: linux-2.6.17.13/kernel/ipipe/core.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-2.6.17.13.orig/kernel/ipipe/core.c
+++ linux-2.6.17.13/kernel/ipipe/core.c
@@ -128,16 +128,6 @@ void __ipipe_init_stage(struct ipipe_dom
 #endif	/* CONFIG_SMP */
 }
=20
-void __ipipe_stall_root(void)
-{
-	ipipe_declare_cpuid;
-	unsigned long flags;
-
-	ipipe_get_cpu(flags); /* Care for migration. */
-	set_bit(IPIPE_STALL_FLAG, &ipipe_root_domain->cpudata[cpuid].status);
-	ipipe_put_cpu(flags);
-}
-
 void __ipipe_cleanup_domain(struct ipipe_domain *ipd)
 {
 	ipipe_unstall_pipeline_from(ipd);
@@ -180,6 +170,17 @@ void __ipipe_unstall_root(void)
 #endif	/* CONFIG_SMP */
 }
=20
+#ifdef CONFIG_SMP
+void __ipipe_stall_root(void)
+{
+	ipipe_declare_cpuid;
+	unsigned long flags;
+
+	ipipe_get_cpu(flags); /* Care for migration. */
+	set_bit(IPIPE_STALL_FLAG, &ipipe_root_domain->cpudata[cpuid].status);
+	ipipe_put_cpu(flags);
+}
+
 unsigned long __ipipe_test_root(void)
 {
 	unsigned long flags, x;
@@ -204,6 +205,7 @@ unsigned long __ipipe_test_and_stall_roo
=20
 	return x;
 }
+#endif	/* CONFIG_SMP */
=20
 void fastcall __ipipe_restore_root(unsigned long x)
 {
@@ -1047,10 +1049,12 @@ EXPORT_SYMBOL(ipipe_test_and_unstall_pip
 EXPORT_SYMBOL(ipipe_unstall_pipeline_head);
 EXPORT_SYMBOL(__ipipe_restore_pipeline_head);
 EXPORT_SYMBOL(__ipipe_unstall_root);
-EXPORT_SYMBOL(__ipipe_stall_root);
 EXPORT_SYMBOL(__ipipe_restore_root);
+#ifdef CONFIG_CMP
+EXPORT_SYMBOL(__ipipe_stall_root);
 EXPORT_SYMBOL(__ipipe_test_and_stall_root);
 EXPORT_SYMBOL(__ipipe_test_root);
+#endif /* CONFIG_SMP */
 EXPORT_SYMBOL(__ipipe_dispatch_event);
 EXPORT_SYMBOL(__ipipe_dispatch_wired);
 EXPORT_SYMBOL(__ipipe_sync_stage);

--------------080404070906080304010802--

--------------enig37C25C43B04218E19E796DB3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iD8DBQFFF4azniDOoMHTA+kRAn7ZAJwNwxNSXYq2QuuzzbsBtja5n95gJwCfaImZ
V802ZHRRTwQ8oFO8vyzOEO8=
=Uk0t
-----END PGP SIGNATURE-----

--------------enig37C25C43B04218E19E796DB3--

