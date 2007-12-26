Message-ID: <477275E0.7080001@domain.hid>
Date: Wed, 26 Dec 2007 16:40:16 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigEA9B7698D0C7C03730DB3A96"
Sender: jan.kiszka@domain.hid
Subject: [Adeos-main] [PATCH 3/3] i386: Cleanup root IRQ trampolines
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
--------------enigEA9B7698D0C7C03730DB3A96
Content-Type: multipart/mixed;
 boundary="------------020206040105030602080707"

This is a multi-part message in MIME format.
--------------020206040105030602080707
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Simplifies xirq trampoline and applies the xirq refactorings to
virq_handler too.

Merry Christmas and all the best for 2008 to everyone!

Jan

--------------020206040105030602080707
Content-Type: text/x-patch;
 name="cleanup-root-irq-trampolines-i386.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline;
 filename="cleanup-root-irq-trampolines-i386.patch"

---
 include/asm-i386/ipipe.h |   78 ++++++++++++++++++++++++----------------=
-------
 1 file changed, 40 insertions(+), 38 deletions(-)

Index: linux-2.6.23.12-xeno/include/asm-i386/ipipe.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-2.6.23.12-xeno.orig/include/asm-i386/ipipe.h
+++ linux-2.6.23.12-xeno/include/asm-i386/ipipe.h
@@ -141,11 +141,7 @@ __ipipe_call_root_xirq_handler(unsigned=20
 		"pushl %%ds\n\t"
 		"pushl %%eax\n\t"
 		"pushl %%ebp\n\t"
-		"pushl %%edi\n\t"
-		"pushl %%esi\n\t"
-		"pushl %%edx\n\t"
-		"pushl %%ecx\n\t"
-		"pushl %%ebx\n\t"
+		"subl  $5*4,%%esp	# rest can remain unsaved\n\t"
=20
 		"movl  %[regs],%%eax	# always pass tick regs\n\t"
 		"call *%[handler]\n\t"
@@ -158,33 +154,41 @@ __ipipe_call_root_xirq_handler(unsigned=20
 		 : "eax");
 }
=20
-#define __ipipe_call_root_virq_handler(ipd,irq) \
-   __asm__ __volatile__ ("pushfl\n\t" \
-                         "pushl %%cs\n\t" \
-                         "pushl $__virq_end\n\t" \
-	                 "pushl $-1\n\t" \
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
-			 "pushl %2\n\t" \
-                         "pushl %%eax\n\t" \
-                         "call *%1\n\t" \
-			 "addl $8,%%esp\n\t" \
-			 : /* no output */ \
-			 : "a" (irq), "m" ((ipd)->irqs[irq].handler), "r" ((ipd)->irqs[irq].c=
ookie))
-
-#define __ipipe_finalize_root_virq_handler() \
-   __asm__ __volatile__ ("jmp ret_from_intr\n\t" \
-	                 "__virq_end: cli\n" \
-			 : /* no output */ \
-			 : /* no input */)
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
+		"pushfl\n\t"
+		"pushl %%cs\n\t"
+		"pushl $virq_end\n\t"
+		"pushl %%eax		# dummy value\n\t"
+		"pushl %%fs\n\t"
+		"pushl %%es\n\t"
+		"pushl %%ds\n\t"
+		"pushl %%eax\n\t"
+		"pushl %%ebp\n\t"
+		"subl  $5*4,%%esp	# rest can remain unsaved\n\t"
+
+		"pushl %[cookie]\n\t"
+		"pushl %[irq]\n\t"
+		"call *%[handler]\n\t"
+		"addl $8,%%esp\n\t" \
+		 : /* no output */ \
+		 : [irq] "rm" (irq), [handler] "rm" (handler),
+		   [cookie] "rm" (cookie));
+	irq_exit();
+	__asm__ __volatile__ (
+		"jmp ret_from_intr	# Linux IRQ epilogue\n\t"
+		"virq_end: cli\n\t"
+		 : /* no output */
+		 : /* no input */);
+}
=20
 static inline unsigned long __ipipe_ffnz(unsigned long ul)
 {
@@ -205,12 +209,10 @@ static inline unsigned long __ipipe_ffnz
 			if (likely(!ipipe_virtual_irq_p(irq)))		\
 				__ipipe_call_root_xirq_handler(		\
 					irq, (ipd)->irqs[irq].handler); \
-			else {						\
-				irq_enter();				\
-				__ipipe_call_root_virq_handler(ipd,irq); \
-				irq_exit();				\
-				__ipipe_finalize_root_virq_handler();	\
-			}						\
+			else						\
+				__ipipe_call_root_virq_handler(		\
+					irq, (ipd)->irqs[irq].handler,	\
+					(ipd)->irqs[irq].cookie);	\
 		} else {						\
 			__clear_bit(IPIPE_SYNC_FLAG, &ipipe_cpudom_var(ipd, status)); \
 			ipd->irqs[irq].handler(irq, ipd->irqs[irq].cookie); \

--------------020206040105030602080707--

--------------enigEA9B7698D0C7C03730DB3A96
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.4-svn0 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iD8DBQFHcnXgniDOoMHTA+kRAjjGAJ90WoDOUJA1+w9FYIkSFbOSe/rMdwCeKdHv
9grXLxl7QavvE+sTuXqNjdI=
=ItX4
-----END PGP SIGNATURE-----

--------------enigEA9B7698D0C7C03730DB3A96--

