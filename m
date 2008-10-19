Message-ID: <48FB693B.2080104@domain.hid>
Date: Sun, 19 Oct 2008 19:07:07 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig9E17E781F1F0BC2C5EED8E6C"
Sender: jan.kiszka@domain.hid
Subject: [Adeos-main] [PATCH] x86: Don't instrument vdso functions
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
--------------enig9E17E781F1F0BC2C5EED8E6C
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

The mcount instrumentation is currently leaking into vdso functions.
Patch below fixes this (bits taken from 2.6.27).

Jan

---
 arch/x86/vdso/vclock_gettime.c |   15 ++++++++-------
 arch/x86/vdso/vgetcpu.c        |    3 ++-
 2 files changed, 10 insertions(+), 8 deletions(-)

Index: b/arch/x86/vdso/vclock_gettime.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- a/arch/x86/vdso/vclock_gettime.c
+++ b/arch/x86/vdso/vclock_gettime.c
@@ -23,7 +23,7 @@
=20
 #define gtod vdso_vsyscall_gtod_data
=20
-static long vdso_fallback_gettime(long clock, struct timespec *ts)
+notrace static long vdso_fallback_gettime(long clock, struct timespec *t=
s)
 {
 	long ret;
 	asm("syscall" : "=3Da" (ret) :
@@ -31,7 +31,7 @@ static long vdso_fallback_gettime(long c
 	return ret;
 }
=20
-static inline long vgetns(void)
+notrace static inline long vgetns(void)
 {
 	long v;
 	cycles_t (*vread)(void);
@@ -40,7 +40,7 @@ static inline long vgetns(void)
 	return (v * gtod->clock.mult) >> gtod->clock.shift;
 }
=20
-static noinline int do_realtime(struct timespec *ts)
+notrace static noinline int do_realtime(struct timespec *ts)
 {
 	unsigned long seq, ns;
 	do {
@@ -54,7 +54,8 @@ static noinline int do_realtime(struct t
 }
=20
 /* Copy of the version in kernel/time.c which we cannot directly access =
*/
-static void vset_normalized_timespec(struct timespec *ts, long sec, long=
 nsec)
+notrace static void
+vset_normalized_timespec(struct timespec *ts, long sec, long nsec)
 {
 	while (nsec >=3D NSEC_PER_SEC) {
 		nsec -=3D NSEC_PER_SEC;
@@ -68,7 +69,7 @@ static void vset_normalized_timespec(str
 	ts->tv_nsec =3D nsec;
 }
=20
-static noinline int do_monotonic(struct timespec *ts)
+notrace static noinline int do_monotonic(struct timespec *ts)
 {
 	unsigned long seq, ns, secs;
 	do {
@@ -82,7 +83,7 @@ static noinline int do_monotonic(struct
 	return 0;
 }
=20
-int __vdso_clock_gettime(clockid_t clock, struct timespec *ts)
+notrace int __vdso_clock_gettime(clockid_t clock, struct timespec *ts)
 {
 	if (likely(gtod->sysctl_enabled && gtod->clock.vread))
 		switch (clock) {
@@ -96,7 +97,7 @@ int __vdso_clock_gettime(clockid_t clock
 int clock_gettime(clockid_t, struct timespec *)
 	__attribute__((weak, alias("__vdso_clock_gettime")));
=20
-int __vdso_gettimeofday(struct timeval *tv, struct timezone *tz)
+notrace int __vdso_gettimeofday(struct timeval *tv, struct timezone *tz)=

 {
 	long ret;
 	if (likely(gtod->sysctl_enabled && gtod->clock.vread)) {
Index: b/arch/x86/vdso/vgetcpu.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- a/arch/x86/vdso/vgetcpu.c
+++ b/arch/x86/vdso/vgetcpu.c
@@ -13,7 +13,8 @@
 #include <asm/vgtod.h>
 #include "vextern.h"
=20
-long __vdso_getcpu(unsigned *cpu, unsigned *node, struct getcpu_cache *u=
nused)
+notrace long
+__vdso_getcpu(unsigned *cpu, unsigned *node, struct getcpu_cache *unused=
)
 {
 	unsigned int p;
=20


--------------enig9E17E781F1F0BC2C5EED8E6C
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iEYEARECAAYFAkj7aUAACgkQniDOoMHTA+l6mQCePDFX2t9hhE9Xn6AtwjKYtBsJ
EQ8AnAywOekJ2po0pphS5aFuUjyWRNXc
=kUiS
-----END PGP SIGNATURE-----

--------------enig9E17E781F1F0BC2C5EED8E6C--

