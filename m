Message-ID: <44E0AB77.3080705@domain.hid>
Date: Mon, 14 Aug 2006 18:57:27 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigD4569C58A5AC7E485943E3DD"
Sender: jan.kiszka@domain.hid
Subject: [Xenomai-core] [PATCH] fix 2.4 build of mksound workaround
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Philippe Gerum <rpm@xenomai.org>, xenomai-core <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigD4569C58A5AC7E485943E3DD
Content-Type: multipart/mixed; boundary="------------090207020704090507010005"

This is a multi-part message in MIME format.
--------------090207020704090507010005
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Hi Philippe,

various issues with the new mksound workaround for x86-2.4 kernels
popped up here during test builds (wrong dependency on
CONFIG_XENO_HW_NMI_DEBUG_LATENCY, missing dep on CONFIG_VT, missing
linux/vt_kern.h). The attached patch aims at fixing them. Compile-tested
over 2.4.33.

Additionally, you may remove the EXPORT_SYMBOL(kd_mksound) from the
latest ipipe patch. A) it's broken in case of !CONFIG_VT, B) it should
not be required given that kd_mksound is only needed by the hal, and
that's built-in anyway. Or do you have non-Xenomai users in mind here?

Jan

--------------090207020704090507010005
Content-Type: text/plain;
 name="fix-mksound-workaround.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline;
 filename="fix-mksound-workaround.patch"

Index: ksrc/arch/i386/hal.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- ksrc/arch/i386/hal.c	(revision 1435)
+++ ksrc/arch/i386/hal.c	(working copy)
@@ -62,6 +62,16 @@
 #include <asm/xenomai/hal.h>
 #include <stdarg.h>
=20
+#if LINUX_VERSION_CODE < KERNEL_VERSION(2,6,0) && !defined(CONFIG_X86_TS=
C) && defined(CONFIG_VT)
+#include <linux/vt_kern.h>
+
+static void (*old_mksound)(unsigned int hz, unsigned int ticks);
+
+static void dummy_mksound (unsigned int hz, unsigned int ticks)
+{
+}
+#endif /* Linux < 2.6 && !CONFIG_X86_TSC && CONFIG_VT */
+
 extern struct desc_struct idt_table[];
=20
 static struct {
@@ -206,12 +216,6 @@ void die_nmi(struct pt_regs *regs, const
     do_exit(SIGSEGV);
 }
=20
-static void (*old_mksound)(unsigned int hz, unsigned int ticks);
-
-static void dummy_mksound (unsigned int hz, unsigned int ticks)
-{
-}
-
 #else /* Linux >=3D 2.6 */
 #include <asm/nmi.h>
 #endif /* Linux < 2.6 */
@@ -601,13 +605,13 @@ int rthal_arch_init(void)
         rthal_smi_restore();
         return -ENODEV;
     }
-#elif LINUX_VERSION_CODE < KERNEL_VERSION(2,6,0) && !defined(CONFIG_X86_=
TSC)
+#elif LINUX_VERSION_CODE < KERNEL_VERSION(2,6,0) && !defined(CONFIG_X86_=
TSC) && defined(CONFIG_VT)
     /* Prevent the speaker code from bugging our TSC emulation, also
        based on PIT channel 2. kd_mksound is exported by the Adeos
        patch. */
     old_mksound =3D kd_mksound;
     kd_mksound =3D &dummy_mksound;
-#endif /* !CONFIG_X86_LOCAL_APIC && Linux < 2.6 && !CONFIG_X86_TSC */
+#endif /* !CONFIG_X86_LOCAL_APIC && Linux < 2.6 && !CONFIG_X86_TSC && CO=
NFIG_VT */
=20
     if (rthal_cpufreq_arg =3D=3D 0)
 #ifdef CONFIG_X86_TSC
@@ -631,10 +635,10 @@ int rthal_arch_init(void)
=20
 void rthal_arch_cleanup(void)
 {
-#if LINUX_VERSION_CODE < KERNEL_VERSION(2,6,0) && !defined(CONFIG_X86_TS=
C)
+#if LINUX_VERSION_CODE < KERNEL_VERSION(2,6,0) && !defined(CONFIG_X86_TS=
C) && defined(CONFIG_VT)
     /* Restore previous PC speaker code. */
     kd_mksound =3D old_mksound;
-#endif /* Linux < 2.6 && !CONFIG_X86_TSC */
+#endif /* Linux < 2.6 && !CONFIG_X86_TSC && CONFIG_VT */
     printk(KERN_INFO "Xenomai: hal/x86 stopped.\n");
 }
=20

--------------090207020704090507010005--

--------------enigD4569C58A5AC7E485943E3DD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFE4Kt3niDOoMHTA+kRAnk4AJ4+3q0SAhHHwvDHl49UMKhXq+6i5gCghR12
ISaJIANMJWKdkdqgZEHTDHQ=
=x4c9
-----END PGP SIGNATURE-----

--------------enigD4569C58A5AC7E485943E3DD--

