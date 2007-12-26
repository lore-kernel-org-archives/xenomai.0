Message-ID: <47727564.5090704@domain.hid>
Date: Wed, 26 Dec 2007 16:38:12 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigCD34F0040E2388A2ED5C5FEF"
Sender: jan.kiszka@domain.hid
Subject: [Adeos-main] [PATCH 3/4] x86_64: Rework root IRQ handler invocation
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
--------------enigCD34F0040E2388A2ED5C5FEF
Content-Type: multipart/mixed;
 boundary="------------000801090808090009000005"

This is a multi-part message in MIME format.
--------------000801090808090009000005
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

The current approach to propagate root hardware interrupts from the
I-pipe layer fails to set the timer IRQ register context correctly and
comes with an extra function call indirection. This patch addresses
both, specifically repairing Linux profiling and processing time
accounting abilities.

To save the latter also when Xenomai is enabled, it takes an additional
Xenomai fix that will be posted to the related list.

Jan

--------------000801090808090009000005
Content-Type: text/x-patch;
 name="rework-call_root_xirq_handler-x86_64.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline;
 filename="rework-call_root_xirq_handler-x86_64.patch"

---
 arch/x86_64/kernel/entry.S |   22 -------------------
 arch/x86_64/kernel/ipipe.c |   20 ++++++++++++-----
 include/asm-x86_64/ipipe.h |   51 +++++++++++++++++++++++++++++++++++++-=
-------
 3 files changed, 57 insertions(+), 36 deletions(-)

Index: linux-2.6.23.12-xeno_64/arch/x86_64/kernel/entry.S
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-2.6.23.12-xeno_64.orig/arch/x86_64/kernel/entry.S
+++ linux-2.6.23.12-xeno_64/arch/x86_64/kernel/entry.S
@@ -582,26 +582,6 @@ END(stub_rt_sigreturn)
=20
 #ifdef CONFIG_IPIPE
=20
-	/* %rdi=3Dnegated _vector_ number, %rsi=3Dhandler */
-ENTRY(__ipipe_root_xirq_thunk)
-	movq %rsp, %rax
-	pushq $0
-	pushq %rax
-	pushfq
-	pushq $__KERNEL_CS
-	pushq $1f
-	pushq %rdi
-	XCPT_FRAME
-	SAVE_ARGS
-	leaq -ARGOFFSET(%rsp),%rdi      # regs for handler
-	call *%rsi
-	jmp exit_intr
-	CFI_ENDPROC
-1:
-	cli
-        ret
-END(__ipipe_root_xirq_thunk)
-=09
 	/* %rdi=3Dvirq number, %rsi=3Dcookie, %rdx=3Dhandler */
 ENTRY(__ipipe_root_virq_thunk)
 	movq %rsp, %rax
@@ -647,7 +627,7 @@ ret_from_intr:
 	leaveq
 	CFI_DEF_CFA_REGISTER	rsp
 	CFI_ADJUST_CFA_OFFSET	-8
-exit_intr:
+ENTRY(exit_intr)
 	GET_THREAD_INFO(%rcx)
 	testl $3,CS-ARGOFFSET(%rsp)
 	je retint_kernel
Index: linux-2.6.23.12-xeno_64/arch/x86_64/kernel/ipipe.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-2.6.23.12-xeno_64.orig/arch/x86_64/kernel/ipipe.c
+++ linux-2.6.23.12-xeno_64/arch/x86_64/kernel/ipipe.c
@@ -750,13 +750,21 @@ int __ipipe_handle_irq(struct pt_regs *r
=20
 finalize:
=20
+	/*
+	 * Given our deferred dispatching model for regular IRQs, we only
+	 * record relevant registers for the last timer interrupt, so that the
+	 * timer handler charges CPU times properly. It is assumed that other
+	 * interrupt handlers don't actually care for such information.
+	 */
 	if (irq =3D=3D __ipipe_tick_irq) {
-		__raw_get_cpu_var(__ipipe_tick_regs).rip =3D regs->rip;
-		__raw_get_cpu_var(__ipipe_tick_regs).cs =3D regs->cs;
-		__raw_get_cpu_var(__ipipe_tick_regs).eflags =3D regs->eflags;
-		__raw_get_cpu_var(__ipipe_tick_regs).rbp =3D regs->rbp;
-		__raw_get_cpu_var(__ipipe_tick_regs).rsp =3D regs->rsp;
-		__raw_get_cpu_var(__ipipe_tick_regs).ss =3D regs->ss;
+		struct pt_regs *tick_regs =3D
+			&__raw_get_cpu_var(__ipipe_tick_regs);
+		tick_regs->ss =3D regs->ss;
+		tick_regs->rsp =3D regs->rsp;
+		tick_regs->eflags =3D regs->eflags;
+		tick_regs->cs =3D regs->cs;
+		tick_regs->rip =3D regs->rip;
+		tick_regs->rbp =3D regs->rbp;
 	}
=20
 	/*
Index: linux-2.6.23.12-xeno_64/include/asm-x86_64/ipipe.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-2.6.23.12-xeno_64.orig/include/asm-x86_64/ipipe.h
+++ linux-2.6.23.12-xeno_64/include/asm-x86_64/ipipe.h
@@ -123,9 +123,6 @@ DECLARE_PER_CPU(struct pt_regs, __ipipe_
=20
 unsigned __ipipe_get_irq_vector(int irq);
=20
-asmlinkage void __ipipe_root_xirq_thunk(unsigned irq,
-					void (*handler)(unsigned irq, void *cookie));
-
 asmlinkage void __ipipe_root_virq_thunk(unsigned irq,
 					void *cookie,
 					void (*handler)(unsigned irq, void *cookie));
@@ -142,6 +139,44 @@ void __ipipe_ack_edge_irq(unsigned irq,=20
=20
 void __ipipe_end_edge_irq(unsigned irq, struct irq_desc *desc);
=20
+static inline void
+__ipipe_call_root_xirq_handler(unsigned irq,
+			       void (*handler)(unsigned irq, void *cookie))
+{
+	struct pt_regs *regs =3D &__raw_get_cpu_var(__ipipe_tick_regs);
+
+	regs->orig_rax =3D ~__ipipe_get_irq_vector(irq);
+
+	__asm__ __volatile__ (
+		"movq %%rsp, %%rdx\n\t"
+		"pushq $0\n\t"
+		"pushq %%rdx\n\t"
+		"pushfq\n\t"
+		"pushq %[kernel_cs]\n\t"
+		"pushq $xirq_end\n\t"
+		"pushq %%rax			# dummy value\n\t"
+		"movq  %%rdi,8*8(%%rsp)		# are these required?\n\t"
+		"movq  %%rsi,7*8(%%rsp)\n\t"
+		"movq  %%rdx,6*8(%%rsp)\n\t"
+		"movq  %%rcx,5*8(%%rsp)\n\t"
+		"movq  %%rax,4*8(%%rsp)\n\t"
+		"movq  %%r8,3*8(%%rsp)\n\t"
+		"movq  %%r9,2*8(%%rsp)\n\t"
+		"movq  %%r10,1*8(%%rsp)\n\t"
+		"movq  %%r11,(%%rsp)\n\t"
+
+		"movq  %[regs],%%rdi		# always pass tick regs\n\t"
+		"call  *%[handler]\n\t"
+
+		"jmp   exit_intr		# Linux IRQ epilogue\n\t"
+
+		"xirq_end: cli\n\t"
+		 : /* no output */
+		 : [kernel_cs] "i" (__KERNEL_CS), [regs] "rm" (regs),
+		   [handler] "rm" (handler)
+		 : "rdx", "rdi");
+}
+
 /*
  * When running handlers, enable hw interrupts for all domains but the
  * one heading the pipeline, so that IRQs can never be significantly
@@ -151,12 +186,10 @@ void __ipipe_end_edge_irq(unsigned irq,=20
 	do {								\
 		local_irq_enable_nohead(ipd);				\
 		if (ipd =3D=3D ipipe_root_domain) {				\
-			if (likely(!ipipe_virtual_irq_p(irq))) {	\
-				struct pt_regs *old_regs;		\
-				old_regs =3D set_irq_regs(&__raw_get_cpu_var(__ipipe_tick_regs)); \
-				__ipipe_root_xirq_thunk(~__ipipe_get_irq_vector(irq), (ipd)->irqs[ir=
q].handler); \
-				set_irq_regs(old_regs);			\
-			} else {					\
+			if (likely(!ipipe_virtual_irq_p(irq)))		\
+				__ipipe_call_root_xirq_handler(		\
+					irq, (ipd)->irqs[irq].handler);	\
+			else {						\
 				irq_enter();				\
 				__ipipe_root_virq_thunk(		\
 					irq, (ipd)->irqs[irq].cookie, (ipd)->irqs[irq].handler); \

--------------000801090808090009000005--

--------------enigCD34F0040E2388A2ED5C5FEF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.4-svn0 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iD8DBQFHcnVlniDOoMHTA+kRApt3AJ4ph/Mo8+OkHKfk+KsztijqrMaa1wCeL8Y4
zFnmTw1BEPrA+HOBKVEKDVM=
=BKsw
-----END PGP SIGNATURE-----

--------------enigCD34F0040E2388A2ED5C5FEF--

