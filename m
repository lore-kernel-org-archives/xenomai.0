Message-ID: <4772756F.1020404@domain.hid>
Date: Wed, 26 Dec 2007 16:38:23 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig2E360BFB6AFCFF781F871A0C"
Sender: jan.kiszka@domain.hid
Subject: [Adeos-main] [PATCH 4/4] x86_64: Cleanup root IRQ trampolines,
	align with i386
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
--------------enig2E360BFB6AFCFF781F871A0C
Content-Type: multipart/mixed;
 boundary="------------020308040300050108040300"

This is a multi-part message in MIME format.
--------------020308040300050108040300
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

This patch reduces the xirq_handler trampoline to the required minimum
and refactors call_root_virq_handler in the same manner. At this chance,
it reorders the execution of irq_exit in the virq path in the same way
as i386 does. I bet the current order was bogus, given that it first ran
the Linux IRQ epilogue and _then_ called irq_exit...

Jan

--------------020308040300050108040300
Content-Type: text/x-patch;
 name="cleanup-root-irq-trampolines-x86_64.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline;
 filename="cleanup-root-irq-trampolines-x86_64.patch"

---
 arch/x86_64/kernel/entry.S |   23 ------------------
 include/asm-x86_64/ipipe.h |   55 ++++++++++++++++++++++++++++++--------=
-------
 2 files changed, 38 insertions(+), 40 deletions(-)

Index: linux-2.6.23.12-xeno_64/arch/x86_64/kernel/entry.S
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-2.6.23.12-xeno_64.orig/arch/x86_64/kernel/entry.S
+++ linux-2.6.23.12-xeno_64/arch/x86_64/kernel/entry.S
@@ -580,28 +580,8 @@ END(stub_rt_sigreturn)
 #endif
 	.endm
=20
-#ifdef CONFIG_IPIPE
-
-	/* %rdi=3Dvirq number, %rsi=3Dcookie, %rdx=3Dhandler */
-ENTRY(__ipipe_root_virq_thunk)
-	movq %rsp, %rax
-	pushq $0
-	pushq %rax
-	pushfq
-	pushq $__KERNEL_CS
-	pushq $1f
-	pushq $-1
-	XCPT_FRAME
-	SAVE_ARGS
-	call *%rdx
-	jmp exit_intr
-	CFI_ENDPROC
-1:
-	cli
-        ret
-END(__ipipe_root_virq_thunk)
-=09
 ENTRY(common_interrupt)
+#ifdef CONFIG_IPIPE
 	XCPT_FRAME
 	interrupt __ipipe_handle_irq
 	testl %eax, %eax
@@ -615,7 +595,6 @@ ENTRY(common_interrupt)
 	swapgs
 	jmp restore_args
 #else /* !CONFIG_IPIPE */
-ENTRY(common_interrupt)
 	XCPT_FRAME
 	interrupt do_IRQ
 #endif /* !CONFIG_IPIPE */=09
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
-asmlinkage void __ipipe_root_virq_thunk(unsigned irq,
-					void *cookie,
-					void (*handler)(unsigned irq, void *cookie));
 static inline unsigned long __ipipe_ffnz(unsigned long ul)
 {
       __asm__("bsrq %1, %0":"=3Dr"(ul)
@@ -155,15 +152,7 @@ __ipipe_call_root_xirq_handler(unsigned=20
 		"pushq %[kernel_cs]\n\t"
 		"pushq $xirq_end\n\t"
 		"pushq %%rax			# dummy value\n\t"
-		"movq  %%rdi,8*8(%%rsp)		# are these required?\n\t"
-		"movq  %%rsi,7*8(%%rsp)\n\t"
-		"movq  %%rdx,6*8(%%rsp)\n\t"
-		"movq  %%rcx,5*8(%%rsp)\n\t"
-		"movq  %%rax,4*8(%%rsp)\n\t"
-		"movq  %%r8,3*8(%%rsp)\n\t"
-		"movq  %%r9,2*8(%%rsp)\n\t"
-		"movq  %%r10,1*8(%%rsp)\n\t"
-		"movq  %%r11,(%%rsp)\n\t"
+ 		"subq  $9*8,%%rsp		# rest can remain unsaved\n\t"
=20
 		"movq  %[regs],%%rdi		# always pass tick regs\n\t"
 		"call  *%[handler]\n\t"
@@ -177,6 +166,38 @@ __ipipe_call_root_xirq_handler(unsigned=20
 		 : "rdx", "rdi");
 }
=20
+void irq_enter(void);
+void irq_exit(void);
+
+static inline void
+__ipipe_call_root_virq_handler(unsigned irq,
+			       void (*handler)(unsigned irq, void *cookie),
+			       void *cookie)
+{
+	irq_enter();
+	__asm__ __volatile__ (
+		"movq %%rsp, %%rdx\n\t"
+		"pushq $0\n\t"
+		"pushq %%rdx\n\t"
+		"pushfq\n\t"
+		"pushq %[kernel_cs]\n\t"
+		"pushq $virq_end\n\t"
+		"pushq %%rax			# dummy value\n\t"
+		"subq  $9*8,%%rsp		# rest can remain unsaved\n\t"
+
+		"call *%[handler]\n\t"
+		: /* no output */
+		: "D" (irq), "S" (cookie), [handler] "rm" (handler),
+		  [kernel_cs] "i" (__KERNEL_CS)
+		: "rdx");
+	irq_exit();
+	__asm__ __volatile__ (
+		"jmp exit_intr			# Linux IRQ epilogue\n\t"
+		"virq_end: cli\n\t"
+		: /* no output */
+		: /* no input */);
+}
+
 /*
  * When running handlers, enable hw interrupts for all domains but the
  * one heading the pipeline, so that IRQs can never be significantly
@@ -189,12 +210,10 @@ __ipipe_call_root_xirq_handler(unsigned=20
 			if (likely(!ipipe_virtual_irq_p(irq)))		\
 				__ipipe_call_root_xirq_handler(		\
 					irq, (ipd)->irqs[irq].handler);	\
-			else {						\
-				irq_enter();				\
-				__ipipe_root_virq_thunk(		\
-					irq, (ipd)->irqs[irq].cookie, (ipd)->irqs[irq].handler); \
-				irq_exit();				\
-			}						\
+			else						\
+				__ipipe_call_root_virq_handler(		\
+					irq, (ipd)->irqs[irq].handler,	\
+					(ipd)->irqs[irq].cookie);	\
 		} else {						\
 			__clear_bit(IPIPE_SYNC_FLAG, &ipipe_cpudom_var(ipd, status)); \
 			ipd->irqs[irq].handler(irq, ipd->irqs[irq].cookie); \

--------------020308040300050108040300--

--------------enig2E360BFB6AFCFF781F871A0C
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.4-svn0 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iD8DBQFHcnVvniDOoMHTA+kRAgHPAJ0SgRaS2HPYhChm+Hy7+KgH5+wPqwCdFpZg
9/+pOYFxLqE4eDQ9OrHHNuQ=
=fGAF
-----END PGP SIGNATURE-----

--------------enig2E360BFB6AFCFF781F871A0C--

