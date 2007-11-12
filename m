Message-ID: <4738DC4E.4050202@domain.hid>
Date: Tue, 13 Nov 2007 00:05:50 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig4E7DE9F7AC1440786E667CBC"
Sender: jan.kiszka@domain.hid
Subject: [Xenomai-core] [PATCH] x86_64: Provide intermediate timer frequency
	API
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: adeos-main@gna.org
Cc: Xenomai-core@domain.hid

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig4E7DE9F7AC1440786E667CBC
Content-Type: multipart/mixed;
 boundary="------------000106000809090207060600"

This is a multi-part message in MIME format.
--------------000106000809090207060600
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

This patch introduces the intermediate IPIPE_APIC_TIMER_FREQ API, that
can be used by I-pipe users to obtain the accurate APIC timer frequency
as Linux calibrated it. This API is scheduled to be removed with
x86-ipipe for kernel 2.6.24. ipipe_request_tickdev is meant to be used th=
en.

Note that a similar patch can be cooked up for 2.6.20-i386 if desired.

Jan

--------------000106000809090207060600
Content-Type: text/x-patch;
 name="provide-IPIPE_APIC_TIMER_FREQ.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline;
 filename="provide-IPIPE_APIC_TIMER_FREQ.patch"

---
 arch/x86_64/kernel/apic.c  |    3 +++
 arch/x86_64/kernel/ipipe.c |    1 +
 include/asm-x86_64/ipipe.h |    4 ++++
 3 files changed, 8 insertions(+)

Index: linux-2.6.23.1-xeno_64/arch/x86_64/kernel/apic.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-2.6.23.1-xeno_64.orig/arch/x86_64/kernel/apic.c
+++ linux-2.6.23.1-xeno_64/arch/x86_64/kernel/apic.c
@@ -872,6 +872,9 @@ static int __init calibrate_APIC_clock(v
=20
 	printk(KERN_INFO "Detected %d.%03d MHz APIC timer.\n",
 		result / 1000 / 1000, result / 1000 % 1000);
+#ifdef CONFIG_IPIPE
+	__ipipe_apic_timer_freq =3D result;
+#endif
=20
 	return result * APIC_DIVISOR / HZ;
 }
Index: linux-2.6.23.1-xeno_64/arch/x86_64/kernel/ipipe.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-2.6.23.1-xeno_64.orig/arch/x86_64/kernel/ipipe.c
+++ linux-2.6.23.1-xeno_64/arch/x86_64/kernel/ipipe.c
@@ -47,6 +47,7 @@
 asmlinkage void preempt_schedule_irq(void);
=20
 int __ipipe_tick_irq;		/* =3D0: 8254 */
+unsigned long __ipipe_apic_timer_freq;
=20
 DEFINE_PER_CPU(struct pt_regs, __ipipe_tick_regs);
=20
Index: linux-2.6.23.1-xeno_64/include/asm-x86_64/ipipe.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-2.6.23.1-xeno_64.orig/include/asm-x86_64/ipipe.h
+++ linux-2.6.23.1-xeno_64/include/asm-x86_64/ipipe.h
@@ -84,6 +84,10 @@ extern unsigned cpu_khz;
 #define ipipe_tsc2ns(t)	(((t) * 1000UL) / (ipipe_cpu_freq() / 1000000UL)=
)
 #define ipipe_tsc2us(t)	((t) / (ipipe_cpu_freq() / 1000000UL))
=20
+/* Intermediat interface, will be removed in 2.6.24 in favour of ipipe_r=
equest_tickdev */
+extern unsigned long __ipipe_apic_timer_freq;
+#define IPIPE_APIC_TIMER_FREQ		__ipipe_apic_timer_freq
+
 /* Private interface -- Internal use only */
=20
 #define __ipipe_check_platform()	do { } while(0)

--------------000106000809090207060600--

--------------enig4E7DE9F7AC1440786E667CBC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFHONxOniDOoMHTA+kRAkudAJ0eH897Vo5lrlqD87UlIBXluuCF0gCcCbCB
YQwv2VF4s9lS6rCbQd04NkY=
=2hPP
-----END PGP SIGNATURE-----

--------------enig4E7DE9F7AC1440786E667CBC--

