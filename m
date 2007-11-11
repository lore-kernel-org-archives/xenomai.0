Message-ID: <47374EF7.4070608@domain.hid>
Date: Sun, 11 Nov 2007 19:50:31 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig8C5D5A9C1C589BAACD4CC977"
Sender: jan.kiszka@domain.hid
Subject: [Adeos-main] [PATCH] x86_64: cleanup IRQ on/off tracing
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
--------------enig8C5D5A9C1C589BAACD4CC977
Content-Type: multipart/mixed;
 boundary="------------010908040905010701060505"

This is a multi-part message in MIME format.
--------------010908040905010701060505
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Tracing of IRQ on/off paths on x86_64 currently suffers from heavy
over-instrumentation. This patch aligns x86_64 in this regard with i386
(and hopefully the other tracer-supporting archs too). It also gets rid
of related *_thunk indirections (I wonder if we cannot kill more of
them...).

Jan

--------------010908040905010701060505
Content-Type: text/x-patch;
 name="cleanup-irqoff-instrumentation.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline;
 filename="cleanup-irqoff-instrumentation.patch"

---
 arch/x86_64/kernel/entry.S    |   26 ++++++++++++++++++--------
 arch/x86_64/kernel/ipipe.c    |   16 ----------------
 arch/x86_64/lib/thunk.S       |    5 -----
 include/asm-x86_64/irqflags.h |   15 ++++-----------
 4 files changed, 22 insertions(+), 40 deletions(-)

Index: linux-2.6.23.1-xeno_64/arch/x86_64/kernel/entry.S
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-2.6.23.1-xeno_64.orig/arch/x86_64/kernel/entry.S
+++ linux-2.6.23.1-xeno_64/arch/x86_64/kernel/entry.S
@@ -542,16 +542,28 @@ END(stub_rt_sigreturn)
 	 */
 	TRACE_IRQS_OFF
 #ifdef CONFIG_IPIPE_TRACE_IRQSOFF
-        leaq RIP-8(%rdi), %rbp
-        pushq %rdi
-        movq ORIG_RAX(%rdi), %rdi
+	leaq RIP-8(%rdi), %rbp	# make interrupted address show up in trace
+	pushq %rdi
+	movq ORIG_RAX(%rdi), %rdi	# IRQ number
+	notq %rdi			# ...is inverted, fix up
+	call ipipe_trace_begin
+	popq %rdi
+	popq %rbp
+	pushq %rbp
+
+	call \func
+
+	popq %rbp
+	pushq %rbp
+	movq 8-ARGOFFSET+ORIG_RAX(%rbp), %rdi
+	leaq 8-ARGOFFSET+RIP-8(%rbp), %rbp
 	notq %rdi
-        call ipipe_trace_begin_thunk
-        popq %rdi
+	call ipipe_trace_end
 	popq %rbp
 	pushq %rbp
-#endif
+#else
 	call \func
+#endif
 	.endm
=20
 #ifdef CONFIG_IPIPE
@@ -602,7 +614,6 @@ ENTRY(common_interrupt)
 	jnz ret_from_intr
 	decl %gs:pda_irqcount
 	leaveq
-	IPIPE_TRACE_IRQS_ON
 	CFI_DEF_CFA_REGISTER	rsp
 	CFI_ADJUST_CFA_OFFSET	-8
 	testl $3,CS-ARGOFFSET(%rsp)
@@ -734,7 +745,6 @@ END(common_interrupt)
 	jnz ret_from_intr
 	decl %gs:pda_irqcount
 	leaveq
-	IPIPE_TRACE_IRQS_ON
 	CFI_DEF_CFA_REGISTER	rsp
 	CFI_ADJUST_CFA_OFFSET	-8
 	testl $3,CS-ARGOFFSET(%rsp)
Index: linux-2.6.23.1-xeno_64/arch/x86_64/kernel/ipipe.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-2.6.23.1-xeno_64.orig/arch/x86_64/kernel/ipipe.c
+++ linux-2.6.23.1-xeno_64/arch/x86_64/kernel/ipipe.c
@@ -760,10 +760,6 @@ finalize:
=20
 finalize_nosync:
=20
-#ifdef CONFIG_IPIPE_TRACE_IRQSOFF
-	ipipe_trace_end(irq);
-#endif /* CONFIG_IPIPE_TRACE_IRQSOFF */
-
 	if (!ipipe_root_domain_p ||
 	    test_bit(IPIPE_STALL_FLAG, &ipipe_root_cpudom_var(status)))
 		return 0;
@@ -771,18 +767,6 @@ finalize_nosync:
 	return 1;
 }
=20
-#ifdef CONFIG_IPIPE_TRACE_IRQSOFF
-void notrace __ipipe_trace_irqs_off(void)
-{
-	ipipe_trace_begin(0x80000000);
-}
-
-void notrace __ipipe_trace_irqs_on(void)
-{
-	ipipe_trace_end(0x80000000);
-}
-#endif /* CONFIG_IPIPE_TRACE_IRQSOFF */
-
 EXPORT_SYMBOL(__ipipe_tick_irq);
 EXPORT_SYMBOL(ipipe_critical_enter);
 EXPORT_SYMBOL(ipipe_critical_exit);
Index: linux-2.6.23.1-xeno_64/arch/x86_64/lib/thunk.S
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-2.6.23.1-xeno_64.orig/arch/x86_64/lib/thunk.S
+++ linux-2.6.23.1-xeno_64/arch/x86_64/lib/thunk.S
@@ -56,11 +56,6 @@
 	thunk_retrax __ipipe_preempt_schedule_irq_thunk,__ipipe_preempt_schedul=
e_irq
 #endif=09
 	thunk_retrax __ipipe_syscall_root_thunk,__ipipe_syscall_root
-#ifdef CONFIG_IPIPE_TRACE_IRQSOFF
-	thunk __ipipe_trace_irqs_on_thunk,__ipipe_trace_irqs_on
-	thunk __ipipe_trace_irqs_off_thunk,__ipipe_trace_irqs_off
-	thunk ipipe_trace_begin_thunk,ipipe_trace_begin
-#endif=09
 #endif
 =09
 	/* SAVE_ARGS below is used only for the .cfi directives it contains. */=

Index: linux-2.6.23.1-xeno_64/include/asm-x86_64/irqflags.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-2.6.23.1-xeno_64.orig/include/asm-x86_64/irqflags.h
+++ linux-2.6.23.1-xeno_64/include/asm-x86_64/irqflags.h
@@ -241,19 +241,12 @@ static inline void local_irq_enable_hw_n
 #endif /* CONFIG_IPIPE_TRACE_IRQSOFF */
=20
 #else /* __ASSEMBLY__: */
-#ifdef CONFIG_IPIPE_TRACE_IRQSOFF
-#define IPIPE_TRACE_IRQS_ON	call __ipipe_trace_irqs_on_thunk
-#define IPIPE_TRACE_IRQS_OFF	call __ipipe_trace_irqs_off_thunk
-#else /* !CONFIG_IPIPE_TRACE_IRQSOFF */
-#define IPIPE_TRACE_IRQS_ON
-#define IPIPE_TRACE_IRQS_OFF
-#endif /* !CONFIG_IPIPE_TRACE_IRQSOFF */
 # ifdef CONFIG_TRACE_IRQFLAGS
-#  define TRACE_IRQS_ON	IPIPE_TRACE_IRQS_ON; call trace_hardirqs_on_thun=
k
-#  define TRACE_IRQS_OFF	IPIPE_TRACE_IRQS_OFF; call trace_hardirqs_off_t=
hunk
+#  define TRACE_IRQS_ON		call trace_hardirqs_on_thunk
+#  define TRACE_IRQS_OFF	call trace_hardirqs_off_thunk
 # else
-#  define TRACE_IRQS_ON	IPIPE_TRACE_IRQS_ON
-#  define TRACE_IRQS_OFF	IPIPE_TRACE_IRQS_OFF
+#  define TRACE_IRQS_ON
+#  define TRACE_IRQS_OFF
 # endif
 #endif
=20

--------------010908040905010701060505--

--------------enig8C5D5A9C1C589BAACD4CC977
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iD8DBQFHN076niDOoMHTA+kRAjUVAJ9x4awn+Tjb95FgpLmCuzuVeybPdACfW9QN
Ltd24xnaApUjQpfzAcnj/J0=
=Rm2X
-----END PGP SIGNATURE-----

--------------enig8C5D5A9C1C589BAACD4CC977--

