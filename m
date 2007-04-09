Message-ID: <461AB78E.10408@domain.hid>
Date: Tue, 10 Apr 2007 00:00:46 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig541B804CE5D463E78D81956C"
Sender: jan.kiszka@domain.hid
Subject: [Xenomai-core] [RFC][PATCH 2/2] Uninline tsc/ns conversions
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
--------------enig541B804CE5D463E78D81956C
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Another pending patch from my repos (don't think I already posted this,
did I?). This one uninlines xnarch_tsc_to_ns() and xnarch_ns_to_tsc().
Both functions are fairly heavy right now, and uninlining can save
a few kilobyte code. Some stats on my Pentium M box:

[Before]
   text    data     bss     dec     hex filename
  15714     844      28   16586    40ca drivers/xenomai/can/xeno_can.ko
   6625     824       4    7453    1d1d drivers/xenomai/testing/xeno_time=
rbench.ko
  12736     984     260   13980    369c drivers/xenomai/serial/xeno_16550=
A.ko
  10304     664    1196   12164    2f84 kernel/xenomai/skins/rtai/xeno_rt=
ai.ko
  19809     936     564   21309    533d kernel/xenomai/skins/rtdm/xeno_rt=
dm.ko
  27172    1376    1184   29732    7424 kernel/xenomai/skins/vrtx/xeno_vr=
tx.ko
  58869    1312   42624  102805   19195 kernel/xenomai/skins/posix/xeno_p=
osix.ko
  27791    1144     136   29071    718f kernel/xenomai/skins/psos+/xeno_p=
sos.ko
  47891    1696     160   49747    c253 kernel/xenomai/skins/native/xeno_=
native.ko
  24465    1136     132   25733    6485 kernel/xenomai/skins/vxworks/xeno=
_vxworks.ko
  73963    1536   50140  125639   1eac7 kernel/xenomai/nucleus/xeno_nucle=
us.ko
                         ------
                         434219

[After]
   text    data     bss     dec     hex filename
  15518     844      28   16390    4006 drivers/xenomai/can/xeno_can.ko
   5445     824       4    6273    1881 drivers/xenomai/testing/xeno_time=
rbench.ko
  12552     984     260   13796    35e4 drivers/xenomai/serial/xeno_16550=
A.ko
   9696     664    1196   11556    2d24 kernel/xenomai/skins/rtai/xeno_rt=
ai.ko
  19561     936     564   21061    5245 kernel/xenomai/skins/rtdm/xeno_rt=
dm.ko
  26604    1376    1184   29164    71ec kernel/xenomai/skins/vrtx/xeno_vr=
tx.ko
  54741    1312   42624   98677   18175 kernel/xenomai/skins/posix/xeno_p=
osix.ko
  27191    1144     136   28471    6f37 kernel/xenomai/skins/psos+/xeno_p=
sos.ko
  46615    1696     160   48471    bd57 kernel/xenomai/skins/native/xeno_=
native.ko
  24277    1136     132   25545    63c9 kernel/xenomai/skins/vxworks/xeno=
_vxworks.ko
  71663    1536   50140  123339   1e1cb kernel/xenomai/nucleus/xeno_nucle=
us.ko
                         ------
                         422743

Means a win of 11k. Does anyone expect noticeable latency regressions?

We may reconsider this uninlining for xnarch_tsc_to_ns() when we switch
to scaled math for that function. But my feeling is that even then the
function size will still demand a dedicated function.

Jan


---
 include/asm-arm/bits/timer.h      |    2 +
 include/asm-blackfin/bits/timer.h |    2 +
 include/asm-generic/bits/timer.h  |   41 +++++++++++++++++++++++++++++++=
+++++++
 include/asm-generic/system.h      |   11 +---------
 include/asm-i386/bits/timer.h     |    2 +
 include/asm-ia64/bits/timer.h     |    2 +
 include/asm-powerpc/bits/timer.h  |    2 +
 include/asm-sim/bits/timer.h      |    2 +
 include/asm-x86_64/bits/timer.h   |    2 +
 9 files changed, 57 insertions(+), 9 deletions(-)

Index: xenomai/include/asm-generic/system.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- xenomai.orig/include/asm-generic/system.h
+++ xenomai/include/asm-generic/system.h
@@ -180,15 +180,8 @@ typedef struct xnarch_heapcb {
 extern "C" {
 #endif
=20
-static inline long long xnarch_tsc_to_ns(long long ts)
-{
-    return xnarch_llimd(ts,1000000000,RTHAL_CPU_FREQ);
-}
-
-static inline long long xnarch_ns_to_tsc(long long ns)
-{
-    return xnarch_llimd(ns,RTHAL_CPU_FREQ,1000000000);
-}
+long long xnarch_tsc_to_ns(long long ts);
+long long xnarch_ns_to_tsc(long long ns);
=20
 static inline unsigned long long xnarch_get_cpu_time(void)
 {
Index: xenomai/include/asm-arm/bits/timer.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- xenomai.orig/include/asm-arm/bits/timer.h
+++ xenomai/include/asm-arm/bits/timer.h
@@ -27,6 +27,8 @@
 #error "Pure kernel header included from user-space!"
 #endif
=20
+#include <asm-generic/xenomai/bits/timer.h>
+
 static inline void xnarch_program_timer_shot(unsigned long delay)
 {
 	rthal_timer_program_shot(rthal_imuldiv
Index: xenomai/include/asm-blackfin/bits/timer.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- xenomai.orig/include/asm-blackfin/bits/timer.h
+++ xenomai/include/asm-blackfin/bits/timer.h
@@ -24,6 +24,8 @@
 #error "Pure kernel header included from user-space!"
 #endif
=20
+#include <asm-generic/xenomai/bits/timer.h>
+
 static inline void xnarch_program_timer_shot(unsigned long delay)
 {
 	/* The core timer runs at the core clock rate -- therefore no
Index: xenomai/include/asm-generic/bits/timer.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- /dev/null
+++ xenomai/include/asm-generic/bits/timer.h
@@ -0,0 +1,41 @@
+/*

+ * Copyright (C) 2001-2007 Philippe Gerum <rpm@xenomai.org>.

+ *

+ * Xenomai is free software; you can redistribute it and/or modify it

+ * under the terms of the GNU General Public License as published by

+ * the Free Software Foundation; either version 2 of the License, or

+ * (at your option) any later version.

+ *

+ * Xenomai is distributed in the hope that it will be useful, but

+ * WITHOUT ANY WARRANTY; without even the implied warranty of

+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU

+ * General Public License for more details.

+ *

+ * You should have received a copy of the GNU General Public License

+ * along with Xenomai; if not, write to the Free Software

+ * Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA

+ * 02111-1307, USA.

+ */

+

+#ifndef _XENO_ASM_GENERIC_BITS_TIMER_H

+#define _XENO_ASM_GENERIC_BITS_TIMER_H

+

+#ifndef __KERNEL__

+#error "Pure kernel header included from user-space!"

+#endif

+

+long long xnarch_tsc_to_ns(long long ts)

+{

+    return xnarch_llimd(ts,1000000000,RTHAL_CPU_FREQ);

+}

+

+EXPORT_SYMBOL(xnarch_tsc_to_ns);

+

+long long xnarch_ns_to_tsc(long long ns)

+{

+    return xnarch_llimd(ns,RTHAL_CPU_FREQ,1000000000);

+}

+

+EXPORT_SYMBOL(xnarch_ns_to_tsc);

+

+#endif /* !_XENO_ASM_GENERIC_BITS_TIMER_H */

Index: xenomai/include/asm-i386/bits/timer.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- xenomai.orig/include/asm-i386/bits/timer.h
+++ xenomai/include/asm-i386/bits/timer.h
@@ -24,6 +24,8 @@
 #error "Pure kernel header included from user-space!"
 #endif
=20
+#include <asm-generic/xenomai/bits/timer.h>
+
 static inline void xnarch_program_timer_shot(unsigned long delay)
 {
 	/* Even though some architectures may use a 64 bits delay here, we
Index: xenomai/include/asm-ia64/bits/timer.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- xenomai.orig/include/asm-ia64/bits/timer.h
+++ xenomai/include/asm-ia64/bits/timer.h
@@ -24,6 +24,8 @@
 #error "Pure kernel header included from user-space!"
 #endif
=20
+#include <asm-generic/xenomai/bits/timer.h>
+
 static inline void xnarch_program_timer_shot(unsigned long delay)
 {
 	rthal_timer_program_shot(delay);
Index: xenomai/include/asm-powerpc/bits/timer.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- xenomai.orig/include/asm-powerpc/bits/timer.h
+++ xenomai/include/asm-powerpc/bits/timer.h
@@ -27,6 +27,8 @@
 #error "Pure kernel header included from user-space!"
 #endif
=20
+#include <asm-generic/xenomai/bits/timer.h>
+
 static inline void xnarch_program_timer_shot(unsigned long delay)
 {
 	/* Even though some architectures may use a 64 bits delay here, we
Index: xenomai/include/asm-sim/bits/timer.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- xenomai.orig/include/asm-sim/bits/timer.h
+++ xenomai/include/asm-sim/bits/timer.h
@@ -19,6 +19,8 @@
 #ifndef _XENO_ASM_SIM_BITS_TIMER_H
 #define _XENO_ASM_SIM_BITS_TIMER_H
=20
+#include <asm-generic/xenomai/bits/timer.h>
+
 static inline void xnarch_program_timer_shot (unsigned long delay)
 {
     /* 1 tsc unit of the virtual CPU =3D=3D 1 ns. */
Index: xenomai/include/asm-x86_64/bits/timer.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- xenomai.orig/include/asm-x86_64/bits/timer.h
+++ xenomai/include/asm-x86_64/bits/timer.h
@@ -24,6 +24,8 @@
 #error "Pure kernel header included from user-space!"
 #endif
=20
+#include <asm-generic/xenomai/bits/timer.h>
+
 static inline void xnarch_program_timer_shot(unsigned long delay)
 {
 	rthal_timer_program_shot(rthal_imuldiv


--------------enig541B804CE5D463E78D81956C
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iD8DBQFGGreOniDOoMHTA+kRAteyAJ0UHfK1P9ub4/A/5LO+G+Wm4krAygCfTeMc
OSUSxkHhI6fBblk0xLOVtcU=
=cjqJ
-----END PGP SIGNATURE-----

--------------enig541B804CE5D463E78D81956C--

