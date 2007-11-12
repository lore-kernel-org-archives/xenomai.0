Message-ID: <4738DB0B.2090807@domain.hid>
Date: Tue, 13 Nov 2007 00:00:27 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig157E5314C3A8D2E095D439E8"
Sender: jan.kiszka@domain.hid
Subject: [Xenomai-core] [PATCH 3/5] Report used timer and clock devices
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Xenomai-core@domain.hid

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig157E5314C3A8D2E095D439E8
Content-Type: multipart/mixed;
 boundary="------------060806030603030802070403"

This is a multi-part message in MIME format.
--------------060806030603030802070403
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Given the current multitude of timer/clock combinations on i386, but
also considering that we may provide HPET clocks on x86 in the future or
may face other archs with multiple options, this patch reports the
configured timer and clock devices via /proc/xenomai/timer. Example:

# cat /proc/xenomai/timer
status=3Don:setup=3D0:clock=3D4413929837202:timerdev=3Dlapic:clockdev=3Dt=
sc

Jan

--------------060806030603030802070403
Content-Type: text/x-patch;
 name="report-timer-device.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline;
 filename="report-timer-device.patch"

---
 include/asm-generic/hal.h    |    7 +++++++
 include/asm-generic/system.h |    2 ++
 include/asm-x86/hal_32.h     |   10 ++++++++++
 include/asm-x86/hal_64.h     |    2 ++
 ksrc/nucleus/module.c        |    5 +++--
 5 files changed, 24 insertions(+), 2 deletions(-)

Index: xenomai/include/asm-generic/hal.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- xenomai.orig/include/asm-generic/hal.h
+++ xenomai/include/asm-generic/hal.h
@@ -49,6 +49,13 @@
 #define RTHAL_CPU_FREQ		(rthal_tunables.cpu_freq)
 #define RTHAL_NR_APCS		BITS_PER_LONG
=20
+#ifndef RTHAL_TIMER_DEVICE
+#define RTHAL_TIMER_DEVICE	"<unnamed>"
+#endif
+#ifndef RTHAL_CLOCK_DEVICE
+#define RTHAL_CLOCK_DEVICE	"<unnamed>"
+#endif
+
 #define RTHAL_EVENT_PROPAGATE   0
 #define RTHAL_EVENT_STOP        1
=20
Index: xenomai/include/asm-generic/system.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- xenomai.orig/include/asm-generic/system.h
+++ xenomai/include/asm-generic/system.h
@@ -125,6 +125,8 @@ typedef struct { atomic_t owner; } xnloc
=20
 #define XNARCH_NR_IRQS               RTHAL_NR_IRQS
 #define XNARCH_TIMER_IRQ	     RTHAL_TIMER_IRQ
+#define XNARCH_TIMER_DEVICE          RTHAL_TIMER_DEVICE
+#define XNARCH_CLOCK_DEVICE          RTHAL_CLOCK_DEVICE
=20
 #define XNARCH_ROOT_STACKSZ   0	/* Only a placeholder -- no stack */
=20
Index: xenomai/include/asm-x86/hal_32.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- xenomai.orig/include/asm-x86/hal_32.h
+++ xenomai/include/asm-x86/hal_32.h
@@ -38,6 +38,16 @@
 #define _XENO_ASM_X86_HAL_32_H
=20
 #define RTHAL_ARCH_NAME			"i386"
+#ifdef CONFIG_X86_LOCAL_APIC
+# define RTHAL_TIMER_DEVICE		"lapic"
+#else
+# define RTHAL_TIMER_DEVICE		"pit"
+#endif
+#ifdef CONFIG_X86_TSC
+# define RTHAL_CLOCK_DEVICE		"tsc"
+#else
+# define RTHAL_CLOCK_DEVICE		"pit"
+#endif
=20
 #include <asm/xenomai/wrappers.h>
=20
Index: xenomai/include/asm-x86/hal_64.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- xenomai.orig/include/asm-x86/hal_64.h
+++ xenomai/include/asm-x86/hal_64.h
@@ -24,6 +24,8 @@
 #define _XENO_ASM_X86_HAL_64_H
=20
 #define RTHAL_ARCH_NAME			"x86_64"
+#define RTHAL_TIMER_DEVICE		"lapic"
+#define RTHAL_CLOCK_DEVICE		"tsc"
=20
 #include <asm/xenomai/wrappers.h>
 #include <asm-generic/xenomai/hal.h>    /* Read the generic bits. */
Index: xenomai/ksrc/nucleus/module.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- xenomai.orig/ksrc/nucleus/module.c
+++ xenomai/ksrc/nucleus/module.c
@@ -793,9 +793,10 @@ static int timer_read_proc(char *page,
 		tm_status =3D "off";
=20
 	len =3D sprintf(page,
-		      "status=3D%s%s:setup=3D%Lu:clock=3D%Lu\n",
+		      "status=3D%s%s:setup=3D%Lu:clock=3D%Lu:timerdev=3D%s:clockdev=3D=
%s\n",
 		      tm_status, wd_status, xnarch_tsc_to_ns(nktimerlat),
-		      xntbase_get_rawclock(&nktbase));
+		      xntbase_get_rawclock(&nktbase),
+		      XNARCH_TIMER_DEVICE, XNARCH_CLOCK_DEVICE);
=20
 	len -=3D off;
 	if (len <=3D off + count)

--------------060806030603030802070403--

--------------enig157E5314C3A8D2E095D439E8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFHONsLniDOoMHTA+kRAtemAJ99yz1bdsBL4B7VE2hgyxp7uaVE+gCeMS0b
wNjHRxoe7mZcqildGNRwFJU=
=X3oW
-----END PGP SIGNATURE-----

--------------enig157E5314C3A8D2E095D439E8--

