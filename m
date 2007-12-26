Message-ID: <477277E8.1020105@domain.hid>
Date: Wed, 26 Dec 2007 16:48:56 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <477275C4.7030503@domain.hid>
In-Reply-To: <477275C4.7030503@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigA46699D0FBDF6F546FB6A123"
Sender: jan.kiszka@domain.hid
Subject: Re: [Adeos-main] [PATCH 2/3] i386: Rework root IRQ handler
	invocation
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
--------------enigA46699D0FBDF6F546FB6A123
Content-Type: multipart/mixed;
 boundary="------------050806000605000403090807"

This is a multi-part message in MIME format.
--------------050806000605000403090807
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Jan Kiszka wrote:
> i386 port of the earlier posted x86_64 patch.
>=20

The usual mistake...

--------------050806000605000403090807
Content-Type: text/x-patch;
 name="rework-call_root_xirq_handler-i386.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline;
 filename="rework-call_root_xirq_handler-i386.patch"

---
 arch/i386/kernel/ipipe.c |   22 ++++++++-------
 include/asm-i386/ipipe.h |   65 +++++++++++++++++++++++++++-------------=
-------
 2 files changed, 50 insertions(+), 37 deletions(-)

Index: linux-2.6.23.12-xeno/arch/i386/kernel/ipipe.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-2.6.23.12-xeno.orig/arch/i386/kernel/ipipe.c
+++ linux-2.6.23.12-xeno/arch/i386/kernel/ipipe.c
@@ -764,17 +764,19 @@ int __ipipe_handle_irq(struct pt_regs re
=20
 finalize:
=20
-	/* Given our deferred dispatching model for regular IRQs, we
-	 * only record CPU regs for the last timer interrupt, so that
-	 * the timer handler charges CPU times properly. It is assumed
-	 * that other interrupt handlers don't actually care for such
-	 * information. */
-
+	/*
+	 * Given our deferred dispatching model for regular IRQs, we only
+	 * record relevant registers for the last timer interrupt, so that the
+	 * timer handler charges CPU times properly. It is assumed that other
+	 * interrupt handlers don't actually care for such information.
+	 */
 	if (irq =3D=3D __ipipe_tick_irq) {
-		__raw_get_cpu_var(__ipipe_tick_regs).eflags =3D regs.eflags;
-		__raw_get_cpu_var(__ipipe_tick_regs).eip =3D regs.eip;
-		__raw_get_cpu_var(__ipipe_tick_regs).xcs =3D regs.xcs;
-		__raw_get_cpu_var(__ipipe_tick_regs).ebp =3D regs.ebp;
+		struct pt_regs *tick_regs =3D
+			&__raw_get_cpu_var(__ipipe_tick_regs);
+		tick_regs->eflags =3D regs.eflags;
+		tick_regs->xcs =3D regs.xcs;
+		tick_regs->eip =3D regs.eip;
+		tick_regs->ebp =3D regs.ebp;
 	}
=20
 	/*
Index: linux-2.6.23.12-xeno/include/asm-i386/ipipe.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-2.6.23.12-xeno.orig/include/asm-i386/ipipe.h
+++ linux-2.6.23.12-xeno/include/asm-i386/ipipe.h
@@ -123,27 +123,40 @@ extern int __ipipe_tick_irq;
=20
 DECLARE_PER_CPU(struct pt_regs, __ipipe_tick_regs);
=20
-#define __ipipe_call_root_xirq_handler(ipd,irq) \
-   __asm__ __volatile__ ("pushfl\n\t" \
-                         "pushl %%cs\n\t" \
-                         "pushl $1f\n\t" \
-	                 "pushl %%eax\n\t" \
-                         "pushl %%fs\n\t" \
-	                 "pushl %%es\n\t" \
-	                 "pushl %%ds\n\t" \
-	                 "pushl %%eax\n\t" \
-	                 "pushl %%ebp\n\t" \
-	                 "pushl %%edi\n\t" \
-	                 "pushl %%esi\n\t" \
-	                 "pushl %%edx\n\t" \
-	                 "pushl %%ecx\n\t" \
-	                 "pushl %%ebx\n\t" \
-                         "movl  %%esp,%%eax\n\t" \
-                         "call *%1\n\t" \
-	                 "jmp ret_from_intr\n\t" \
-	                 "1: cli\n" \
-			 : /* no output */ \
-			 : "a" (~irq), "m" ((ipd)->irqs[irq].handler))
+static inline void
+__ipipe_call_root_xirq_handler(unsigned irq,
+			       void (*handler)(unsigned irq, void *cookie))
+{
+	struct pt_regs *regs =3D &__raw_get_cpu_var(__ipipe_tick_regs);
+
+	regs->orig_eax =3D ~irq;
+
+	__asm__ __volatile__ (
+		"pushfl\n\t"
+		"pushl %%cs\n\t"
+		"pushl $xirq_end\n\t"
+		"pushl %%eax		# dummy value\n\t"
+		"pushl %%fs\n\t"
+		"pushl %%es\n\t"
+		"pushl %%ds\n\t"
+		"pushl %%eax\n\t"
+		"pushl %%ebp\n\t"
+		"pushl %%edi\n\t"
+		"pushl %%esi\n\t"
+		"pushl %%edx\n\t"
+		"pushl %%ecx\n\t"
+		"pushl %%ebx\n\t"
+
+		"movl  %[regs],%%eax	# always pass tick regs\n\t"
+		"call *%[handler]\n\t"
+
+		"jmp ret_from_intr	# Linux IRQ epilogue\n\t"
+
+		"xirq_end: cli\n\t"
+		 : /* no output */ \
+		 : [handler] "rm" (handler), [regs] "rm" (regs)
+		 : "eax");
+}
=20
 #define __ipipe_call_root_virq_handler(ipd,irq) \
    __asm__ __volatile__ ("pushfl\n\t" \
@@ -189,12 +202,10 @@ static inline unsigned long __ipipe_ffnz
 	do {								\
 		local_irq_enable_nohead(ipd);				\
 		if (ipd =3D=3D ipipe_root_domain) {				\
-			if (likely(!ipipe_virtual_irq_p(irq))) {	\
-				struct pt_regs *old_regs;		\
-				old_regs =3D set_irq_regs(&__raw_get_cpu_var(__ipipe_tick_regs)); \
-				__ipipe_call_root_xirq_handler(ipd,irq); \
-				set_irq_regs(old_regs);			\
-			} else {					\
+			if (likely(!ipipe_virtual_irq_p(irq)))		\
+				__ipipe_call_root_xirq_handler(		\
+					irq, (ipd)->irqs[irq].handler); \
+			else {						\
 				irq_enter();				\
 				__ipipe_call_root_virq_handler(ipd,irq); \
 				irq_exit();				\

--------------050806000605000403090807--

--------------enigA46699D0FBDF6F546FB6A123
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.4-svn0 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iD8DBQFHcnfoniDOoMHTA+kRAvTlAJwPgqGiY8Q6mUb6XlT7HrdZ7ghoNwCfXYO6
eBnnm+hd7BJBzwBfzimXhkM=
=1FPw
-----END PGP SIGNATURE-----

--------------enigA46699D0FBDF6F546FB6A123--

