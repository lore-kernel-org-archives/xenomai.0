Message-ID: <46EB8F11.2010009@domain.hid>
Date: Sat, 15 Sep 2007 09:51:45 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigC96A92922AC13BB321F8DA7F"
Sender: jan.kiszka@domain.hid
Subject: [Adeos-main] [Resent][RFC-PATCH] Instrument smp_processor_id /wrt
	illicit usage
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: </public/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: Philippe Gerum <rpm@xenomai.org>
Cc: adeos-main <adeos-main@gna.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigC96A92922AC13BB321F8DA7F
Content-Type: multipart/mixed;
 boundary="------------040606020104040905000004"

This is a multi-part message in MIME format.
--------------040606020104040905000004
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

This is still in my local queue, don't recall anymore when we last
discussed it and if there was some issue remaining.

Anyway, here is a rebased set to detect calls of smp_processor_id() from
illicit contexts (non-root) on archs that bother about this. Only i386
is cared about so far, x86_64 and PowerPC should be treated similarly,
other (future) SMP-arch would arm the check automatically. Yet another
safety bag for porting I-pipe.

Jan

--------------040606020104040905000004
Content-Type: text/x-patch;
 name="instrument-smp_processor_id.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline;
 filename="instrument-smp_processor_id.patch"

---
 lib/smp_processor_id.c |   20 ++++++++++++++++++--
 1 file changed, 18 insertions(+), 2 deletions(-)

Index: linux-2.6.22-ipipe/lib/smp_processor_id.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-2.6.22-ipipe.orig/lib/smp_processor_id.c
+++ linux-2.6.22-ipipe/lib/smp_processor_id.c
@@ -10,11 +10,27 @@
 unsigned int debug_smp_processor_id(void)
 {
 	unsigned long preempt_count =3D preempt_count();
-	int this_cpu =3D raw_smp_processor_id();
+	int this_cpu =3D ipipe_processor_id();
 	cpumask_t this_mask;
=20
-	if (!ipipe_root_domain_p)
+#ifdef CONFIG_IPIPE
+	if (!ipipe_root_domain_p) {
+#ifndef IPIPE_STACK_INVARIANT_CPUID
+		if (test_bit(IPIPE_NOSTACK_FLAG, &ipipe_current_domain->
+						 cpudata[this_cpu].status)) {
+			ipipe_trace_panic_freeze();
+			printk(KERN_ERR "BUG: using smp_processor_id() over "
+			       "non-Linux stack. I-pipe domain: %s\n",
+			       ipipe_current_domain->name);
+			print_symbol("caller is %s\n",
+				     (long)__builtin_return_address(0));
+			dump_stack();
+			ipipe_trace_panic_dump();
+		}
+#endif /* !IPIPE_STACK_INVARIANT_CPUID */
 		goto out;
+	}
+#endif /* CONFIG_IPIPE */
=20
 	if (likely(preempt_count))
 		goto out;

--------------040606020104040905000004
Content-Type: text/x-patch;
 name="instrument-smp_processor_id-i386.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline;
 filename="instrument-smp_processor_id-i386.patch"

---
 include/asm-i386/ipipe.h |    1 +
 1 file changed, 1 insertion(+)

Index: linux-2.6.22-ipipe/include/asm-i386/ipipe.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-2.6.22-ipipe.orig/include/asm-i386/ipipe.h
+++ linux-2.6.22-ipipe/include/asm-i386/ipipe.h
@@ -38,6 +38,7 @@
 #include <asm/ptrace.h>
=20
 #define ipipe_processor_id()   raw_smp_processor_id()
+#define IPIPE_STACK_INVARIANT_CPUID
=20
 #define prepare_arch_switch(next)		\
 do {						\

--------------040606020104040905000004--

--------------enigC96A92922AC13BB321F8DA7F
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iD8DBQFG648RniDOoMHTA+kRAus/AJ4o83ThK/FfuOjm8MjJtoNy38T+WwCeM6VB
C47WAC7wtYTGY4pf+paMAug=
=84yI
-----END PGP SIGNATURE-----

--------------enigC96A92922AC13BB321F8DA7F--

