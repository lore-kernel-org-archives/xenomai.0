Message-ID: <4443BF6E.907@domain.hid>
Date: Mon, 17 Apr 2006 18:16:46 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigD30A99F816C2CED59CAE133D"
Sender: jan.kiszka@domain.hid
Subject: [Adeos-main] [PATCH] clean up latest ipipe-tracing changes
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: </public/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: adeos-main@gna.org
Cc: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigD30A99F816C2CED59CAE133D
Content-Type: multipart/mixed; boundary="------------000506080401000109010304"

This is a multi-part message in MIME format.
--------------000506080401000109010304
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Hi,

here is a suggestion to do a tiny cleanup of Gilles' cpuid-fix for the
tracer. Sorry that I didn't comment on this earlier. Nothing critical
though.

I think it's better to drag the include/linux/compiler.h changes into
the main patch instead of starting to use
__attribute__((no_instrument_function)) all over the place just to avoid
notrace (especially as I expect that Ingo's tracer will get merged
anyway in the future). Moreover, local_irq_restore_hw_notrace & frieds
are available even for !CONFIG_IPIPE_TRACE, so no need to differentiate
here. Finally, I do not see a need for marking a static inline function
non-traced.

The patch does not seem to produce different binary code (I checked
kernel/ipipe/tracer.o) - as expected.

Jan

--------------000506080401000109010304
Content-Type: text/x-patch;
 name="tracer-cleanup.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline;
 filename="tracer-cleanup.patch"

Index: linux-2.6.16-ipipe/arch/i386/kernel/ipipe-root.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-2.6.16-ipipe.orig/arch/i386/kernel/ipipe-root.c	2006-04-17 15:2=
1:58.000000000 +0200
+++ linux-2.6.16-ipipe/arch/i386/kernel/ipipe-root.c	2006-04-17 17:08:19.=
000000000 +0200
@@ -85,25 +85,13 @@ static void __ipipe_null_handler(unsigne
=20
 #ifdef CONFIG_SMP
=20
-static __attribute__((no_instrument_function)) int __ipipe_boot_cpuid(vo=
id)
+static notrace int __ipipe_boot_cpuid(void)
 {
 	return 0;
 }
=20
 u8 __ipipe_apicid_2_cpu[IPIPE_NR_CPUS];
=20
-#ifndef CONFIG_IPIPE_TRACE
-static int __ipipe_hard_cpuid(void)
-{
-	unsigned long flags;
-	int cpu;
-
-	local_irq_save_hw(flags);
-	cpu =3D __ipipe_apicid_2_cpu[GET_APIC_ID(apic_read(APIC_ID))];
-	local_irq_restore_hw(flags);
-	return cpu;
-}
-#else /* CONFIG_IPIPE_TRACE */
 static notrace int __ipipe_hard_cpuid(void)
 {
 	unsigned long flags;
@@ -114,7 +102,6 @@ static notrace int __ipipe_hard_cpuid(vo
 	local_irq_restore_hw_notrace(flags);
 	return cpu;
 }
-#endif /* CONFIG_IPIPE_TRACE */
=20
 int (*__ipipe_logical_cpuid)(void) =3D &__ipipe_boot_cpuid;
=20
Index: linux-2.6.16-ipipe/include/asm-i386/ipipe.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-2.6.16-ipipe.orig/include/asm-i386/ipipe.h	2006-04-17 15:21:58.=
000000000 +0200
+++ linux-2.6.16-ipipe/include/asm-i386/ipipe.h	2006-04-17 17:08:18.00000=
0000 +0200
@@ -97,7 +97,7 @@
 #define IPIPE_CRITICAL_VECTOR  0xf9	/* Used by ipipe_critical_enter/exit=
() */
 #define IPIPE_CRITICAL_IPI     (IPIPE_CRITICAL_VECTOR - FIRST_EXTERNAL_V=
ECTOR)
=20
-static inline __attribute__((no_instrument_function)) int ipipe_processo=
r_id(void)
+static inline int ipipe_processor_id(void)
 {
 	extern int (*__ipipe_logical_cpuid)(void);
 	return __ipipe_logical_cpuid();

--------------000506080401000109010304--

--------------enigD30A99F816C2CED59CAE133D
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFEQ79uniDOoMHTA+kRAl0XAJ9bBByntdiOp3GRqws4sktAdU9GFwCfY2Dt
hX9LSBEXnap9ZEkzW9AlaZ4=
=nSop
-----END PGP SIGNATURE-----

--------------enigD30A99F816C2CED59CAE133D--

