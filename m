Message-ID: <48D61DDE.4060605@domain.hid>
Date: Sun, 21 Sep 2008 12:11:42 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig34BA5FC9D931267DEC2CDCBA"
Sender: jan.kiszka@domain.hid
Subject: [Adeos-main] [PATCH] Detect leaking stalls of topmost domain - v2
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: </public/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: adeos-main <adeos-main@gna.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig34BA5FC9D931267DEC2CDCBA
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Here comes an improved version of my debugging helper for leaking
top-most domain stalls. This version is now also NMI-safe, no longer
causing false positives from this context.

The instrumentation can detect infamous bug pattern like this:

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

Also, this patch can help with these patterns:

	stall_topmost_domain();
	...
	blocking_or_rescheduling_in_lowprio_domain();
	...
	unstall_topmost_domain();

One example of this was just fixed in Xenomai's cleanup code.

To catch such issues earlier, I therefore propose the following
extension of ipipe_check_context. It is based on the assumption that the
topmost domain should never be stalled when lower domains execute that
check. This specifically takes care of not breaking Xenomai's IRQ shield
(a mid-prio domain that intentionally blocks Linux IRQs).


---
 include/linux/hardirq.h      |   19 +++++++++++++++++--
 include/linux/ipipe.h        |   20 ++++++++++++++++++++
 include/linux/ipipe_percpu.h |    1 +
 kernel/ipipe/core.c          |   21 ++++++++++++++++-----
 4 files changed, 54 insertions(+), 7 deletions(-)

Index: b/kernel/ipipe/core.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- a/kernel/ipipe/core.c
+++ b/kernel/ipipe/core.c
@@ -1561,13 +1561,16 @@ void __init ipipe_init_proc(void)
 #ifdef CONFIG_IPIPE_DEBUG_CONTEXT
=20
 DEFINE_PER_CPU(int, ipipe_percpu_context_check) =3D { 1 };
+DEFINE_PER_CPU(int, ipipe_saved_context_check_state);
=20
 void ipipe_check_context(struct ipipe_domain *border_ipd)
 {
 	/* Note: We don't make the per_cpu access atomic. We assume that code
 	   which temporarily disables the check does this in atomic context
 	   only. */
-	if (likely(ipipe_current_domain->priority <=3D border_ipd->priority) ||=

+	if (likely(ipipe_current_domain->priority <=3D border_ipd->priority &&
+		   !test_bit(IPIPE_STALL_FLAG,
+			     &ipipe_head_cpudom_var(status))) ||
 	    !per_cpu(ipipe_percpu_context_check, ipipe_processor_id()))
 		return;
=20
@@ -1575,10 +1578,18 @@ void ipipe_check_context(struct ipipe_do
=20
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
Index: b/include/linux/hardirq.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- a/include/linux/hardirq.h
+++ b/include/linux/hardirq.h
@@ -161,7 +161,22 @@ extern void irq_enter(void);
  */
 extern void irq_exit(void);
=20
-#define nmi_enter()		do { if (ipipe_root_domain_p) { lockdep_off(); __ir=
q_enter(); } } while (0)
-#define nmi_exit()		do { if (ipipe_root_domain_p) { __irq_exit(); lockde=
p_on(); } } while (0)
+#define nmi_enter() 					\
+	do {						\
+		ipipe_nmi_enter();			\
+		if (ipipe_root_domain_p) {		\
+			lockdep_off();			\
+			__irq_enter();			\
+		}					\
+	} while (0)
+
+#define nmi_exit()					\
+	do {						\
+		if (ipipe_root_domain_p) {		\
+			__irq_exit();			\
+			lockdep_on();			\
+		}					\
+		ipipe_nmi_exit();			\
+	} while (0)
=20
 #endif /* LINUX_HARDIRQ_H */
Index: b/include/linux/ipipe.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- a/include/linux/ipipe.h
+++ b/include/linux/ipipe.h
@@ -566,6 +566,22 @@ static inline void ipipe_context_check_o
 		per_cpu(ipipe_percpu_context_check, cpu) =3D 0;
 }
=20
+static inline void ipipe_nmi_enter(void)
+{
+	int cpu =3D ipipe_processor_id();
+
+	per_cpu(ipipe_saved_context_check_state, cpu) =3D
+		ipipe_disable_context_check(cpu);
+}
+
+static inline void ipipe_nmi_exit(void)
+{
+	int cpu =3D ipipe_processor_id();
+
+	ipipe_restore_context_check
+		(cpu, per_cpu(ipipe_saved_context_check_state, cpu));
+}
+
 #else	/* !CONFIG_IPIPE_DEBUG_CONTEXT */
=20
 static inline int ipipe_disable_context_check(int cpu)
@@ -577,6 +593,10 @@ static inline void ipipe_restore_context
=20
 static inline void ipipe_context_check_off(void) { }
=20
+static inline void ipipe_nmi_enter(void) { }
+
+static inline void ipipe_nmi_exit(void) { }
+
 #endif	/* !CONFIG_IPIPE_DEBUG_CONTEXT */
=20
 #endif	/* !__LINUX_IPIPE_H */
Index: b/include/linux/ipipe_percpu.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- a/include/linux/ipipe_percpu.h
+++ b/include/linux/ipipe_percpu.h
@@ -58,6 +58,7 @@ DECLARE_PER_CPU(struct ipipe_domain *, i
=20
 #ifdef CONFIG_IPIPE_DEBUG_CONTEXT
 DECLARE_PER_CPU(int, ipipe_percpu_context_check);
+DECLARE_PER_CPU(int, ipipe_saved_context_check_state);
 #endif
=20
 #define ipipe_percpu(var, cpu)		per_cpu(var, cpu)


--------------enig34BA5FC9D931267DEC2CDCBA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iEYEARECAAYFAkjWHeEACgkQniDOoMHTA+kn8ACeKthzmWh+/BlZS2tgmkrm+5jy
rHQAnjdHBkjQutY3Fixkej0fCc3TtIO5
=4p3L
-----END PGP SIGNATURE-----

--------------enig34BA5FC9D931267DEC2CDCBA--

