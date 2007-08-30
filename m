Message-ID: <46D6633A.5010906@domain.hid>
Date: Thu, 30 Aug 2007 08:27:06 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigEA18CED867274D9E8F7F1222"
Sender: jan.kiszka@domain.hid
Subject: [Xenomai-core] [PATCH] fix 2.4-kernel build warning
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai-core <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigEA18CED867274D9E8F7F1222
Content-Type: multipart/mixed;
 boundary="------------010307020309050508050303"

This is a multi-part message in MIME format.
--------------010307020309050508050303
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

I noticed some warning during a 2.4 build of trunk which may point out
unexpected side effects:

In file included from pod.c:45:
/usr/src/linux-2.4.35.1/include/asm/xenomai/bits/pod.h:32:1: warning: "xn=
arch_tsc_to_ns" redefined
In file included from /usr/src/linux-2.4.35.1/include/linux/modversions.h=
:275,
                 from /usr/src/linux-2.4.35.1/include/linux/module.h:22,
                 from /usr/src/linux-2.4.35.1/include/asm-generic/xenomai=
/system.h:30,
                 from /usr/src/linux-2.4.35.1/include/asm/xenomai/system.=
h:28,
                 from /usr/src/linux-2.4.35.1/include/xenomai/nucleus/typ=
es.h:39,
                 from /usr/src/linux-2.4.35.1/include/xenomai/nucleus/que=
ue.h:24,
                 from /usr/src/linux-2.4.35.1/include/xenomai/nucleus/tim=
ebase.h:29,
                 from /usr/src/linux-2.4.35.1/include/xenomai/nucleus/tim=
er.h:26,
                 from /usr/src/linux-2.4.35.1/include/xenomai/nucleus/thr=
ead.h:25,
                 from /usr/src/linux-2.4.35.1/include/xenomai/nucleus/pod=
=2Eh:34,
                 from pod.c:36:
/usr/src/linux-2.4.35.1/include/linux/modules/pod.ver:4:1: warning: this =
is the location of the previous definition

However, the attached patch fixes it.

Jan

--------------010307020309050508050303
Content-Type: text/plain;
 name="fix-2.4-redefine-warning.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline;
 filename="fix-2.4-redefine-warning.patch"

---
 include/asm-arm/bits/pod.h      |    2 +-
 include/asm-blackfin/bits/pod.h |    2 +-
 include/asm-generic/bits/pod.h  |   10 ++++------
 include/asm-i386/bits/pod.h     |    2 +-
 include/asm-x86_64/bits/pod.h   |    2 +-
 5 files changed, 8 insertions(+), 10 deletions(-)

Index: xenomai/include/asm-arm/bits/pod.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- xenomai.orig/include/asm-arm/bits/pod.h
+++ xenomai/include/asm-arm/bits/pod.h
@@ -30,7 +30,7 @@ long long xnarch_tsc_to_ns(long long ts)
 {
 	return xnarch_llmulshft(ts, xnarch_tsc_scale, xnarch_tsc_shift);
 }
-#define xnarch_tsc_to_ns	xnarch_tsc_to_ns
+#define XNARCH_TSC_TO_NS
=20
 #include <asm-generic/xenomai/bits/pod.h>
=20
Index: xenomai/include/asm-blackfin/bits/pod.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- xenomai.orig/include/asm-blackfin/bits/pod.h
+++ xenomai/include/asm-blackfin/bits/pod.h
@@ -27,7 +27,7 @@ long long xnarch_tsc_to_ns(long long ts)
 {
 	return xnarch_llmulshft(ts, xnarch_tsc_scale, xnarch_tsc_shift);
 }
-#define xnarch_tsc_to_ns	xnarch_tsc_to_ns
+#define XNARCH_TSC_TO_NS
=20
 #include <asm-generic/xenomai/bits/pod.h>
=20
Index: xenomai/include/asm-generic/bits/pod.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- xenomai.orig/include/asm-generic/bits/pod.h
+++ xenomai/include/asm-generic/bits/pod.h
@@ -273,23 +273,21 @@ unsigned long long xnarch_get_host_time(
=20
 EXPORT_SYMBOL(xnarch_get_host_time);
=20
-#ifndef xnarch_tsc_to_ns
+#ifndef XNARCH_TSC_TO_NS
 long long xnarch_tsc_to_ns(long long ts)
 {
     return xnarch_llimd(ts,1000000000,RTHAL_CPU_FREQ);
 }
-#define xnarch_tsc_to_ns	xnarch_tsc_to_ns
-#endif /* !xnarch_tsc_to_ns */
+#endif /* !XNARCH_TSC_TO_NS */
=20
 EXPORT_SYMBOL(xnarch_tsc_to_ns);
=20
-#ifndef xnarch_ns_to_tsc
+#ifndef XNARCH_NS_TO_TSC
 long long xnarch_ns_to_tsc(long long ns)
 {
     return xnarch_llimd(ns,RTHAL_CPU_FREQ,1000000000);
 }
-#define xnarch_ns_to_tsc	xnarch_ns_to_tsc
-#endif /* !xnarch_ns_to_tsc */
+#endif /* !XNARCH_NS_TO_TSC */
=20
 EXPORT_SYMBOL(xnarch_ns_to_tsc);
=20
Index: xenomai/include/asm-i386/bits/pod.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- xenomai.orig/include/asm-i386/bits/pod.h
+++ xenomai/include/asm-i386/bits/pod.h
@@ -29,7 +29,7 @@ long long xnarch_tsc_to_ns(long long ts)
 {
 	return xnarch_llmulshft(ts, xnarch_tsc_scale, xnarch_tsc_shift);
 }
-#define xnarch_tsc_to_ns	xnarch_tsc_to_ns
+#define XNARCH_TSC_TO_NS
=20
 #include <asm-generic/xenomai/bits/pod.h>
 #include <asm/xenomai/switch.h>
Index: xenomai/include/asm-x86_64/bits/pod.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- xenomai.orig/include/asm-x86_64/bits/pod.h
+++ xenomai/include/asm-x86_64/bits/pod.h
@@ -28,7 +28,7 @@ long long xnarch_tsc_to_ns(long long ts)
 {
 	return xnarch_llmulshft(ts, xnarch_tsc_scale, xnarch_tsc_shift);
 }
-#define xnarch_tsc_to_ns	xnarch_tsc_to_ns
+#define XNARCH_TSC_TO_NS
=20
 #include <asm-generic/xenomai/bits/pod.h>
 #include <asm/xenomai/switch.h>

--------------010307020309050508050303--

--------------enigEA18CED867274D9E8F7F1222
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFG1mM9niDOoMHTA+kRAmGbAJ9kAihwUgHi2rV2Cgm0rcFxZ9rAogCfZ6ph
9m3G8roYm8LtHX2eBiexL6w=
=1GrL
-----END PGP SIGNATURE-----

--------------enigEA18CED867274D9E8F7F1222--

