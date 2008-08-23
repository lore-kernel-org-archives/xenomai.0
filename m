Message-ID: <48AFCD61.8040203@domain.hid>
Date: Sat, 23 Aug 2008 10:42:09 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <48AEE3AB.6070001@domain.hid> <48AEE945.8000503@domain.hid>
In-Reply-To: <48AEE945.8000503@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig7EB7812E4B9B888946FD5323"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-core] [PATCH 2/2] Unify asm-x86/atomic.h
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: gilles.chanteperdrix@xenomai.org
Cc: Xenomai-core@domain.hid

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig7EB7812E4B9B888946FD5323
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Gilles Chanteperdrix wrote:
> Jan Kiszka wrote:
>> ...and also automatically fixes the missing LOCK prefix for
>> pthread_mutex_* services on x86_32 SMP.
>=20
> This looks to me as a half-way unification. Can we not totally get rid
> of atomic_32.h and atomic_64.h ? I mean since we are using unsigned lon=
g
> as atomic_t on both platforms, there should not be much difference
> (except maybe the inline asm).
>=20

I could merge all atomic_32/64.h hunks into atomic.h if that this
preferred, but I cannot help getting rid of the atomic_t vs. atomic64_t
differences, thus the sub-arch specific part cannot be reduced as far as
I see it ATM.

However, yesterday's version contained a regression /wrt 32 bit (missing
atomic_counter_t and xnarch_atomic_t type definitions), this one is
better:

---
 include/asm-x86/atomic.h    |   64 +++++++++++++++++++++++++++++++++++++=
+++++++
 include/asm-x86/atomic_32.h |   31 ---------------------
 include/asm-x86/atomic_64.h |   33 ----------------------
 3 files changed, 65 insertions(+), 63 deletions(-)

Index: b/include/asm-x86/atomic.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- a/include/asm-x86/atomic.h
+++ b/include/asm-x86/atomic.h
@@ -1,5 +1,69 @@
+/*
+ * Copyright (C) 2007 Philippe Gerum <rpm@xenomai.org>.
+ *
+ * Xenomai is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published
+ * by the Free Software Foundation; either version 2 of the License,
+ * or (at your option) any later version.
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
+#ifndef _XENO_ASM_X86_ATOMIC_H
+#define _XENO_ASM_X86_ATOMIC_H
+
+#include <asm/xenomai/features.h>
+
+typedef unsigned long atomic_flags_t;
+
+#ifdef __KERNEL__
+
+#include <linux/bitops.h>
+#include <asm/atomic.h>
+#include <asm/system.h>
+
+#define xnarch_atomic_set_mask(pflags,mask) \
+	atomic_set_mask((mask),(unsigned *)(pflags))
+#define xnarch_atomic_clear_mask(pflags,mask) \
+	atomic_clear_mask((mask),(unsigned *)(pflags))
+#define xnarch_atomic_xchg(ptr,x)              xchg(ptr,x)
+
+#define xnarch_memory_barrier()  smp_mb()
+
+#else /* !__KERNEL__ */
+
+#include <xeno_config.h>
+
+#ifdef CONFIG_SMP
+#define LOCK_PREFIX "lock ; "
+#else
+#define LOCK_PREFIX ""
+#endif
+
+typedef struct { unsigned long counter; } xnarch_atomic_t;
+
+#define xnarch_atomic_get(v)		((v)->counter)
+
+#define xnarch_atomic_set(v,i)		(((v)->counter) =3D (i))
+
+#define xnarch_write_memory_barrier()	xnarch_memory_barrier()
+
+#endif /* __KERNEL__ */
+
 #ifdef __i386__
 #include "atomic_32.h"
 #else
 #include "atomic_64.h"
 #endif
+
+#include <asm-generic/xenomai/atomic.h>
+
+#endif /* !_XENO_ASM_X86_ATOMIC_64_H */
Index: b/include/asm-x86/atomic_32.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- a/include/asm-x86/atomic_32.h
+++ b/include/asm-x86/atomic_32.h
@@ -19,48 +19,26 @@
=20
 #ifndef _XENO_ASM_X86_ATOMIC_32_H
 #define _XENO_ASM_X86_ATOMIC_32_H
-#define _XENO_ASM_X86_ATOMIC_H
=20
 #ifdef __KERNEL__
=20
-#include <linux/bitops.h>
-#include <asm/atomic.h>
-#include <asm/system.h>
-
 #define xnarch_atomic_set(pcounter,i)          atomic_set(pcounter,i)
 #define xnarch_atomic_get(pcounter)            atomic_read(pcounter)
 #define xnarch_atomic_inc(pcounter)            atomic_inc(pcounter)
 #define xnarch_atomic_dec(pcounter)            atomic_dec(pcounter)
 #define xnarch_atomic_inc_and_test(pcounter)   atomic_inc_and_test(pcoun=
ter)
 #define xnarch_atomic_dec_and_test(pcounter)   atomic_dec_and_test(pcoun=
ter)
-#define xnarch_atomic_set_mask(pflags,mask)    atomic_set_mask(mask,pfla=
gs)
-#define xnarch_atomic_clear_mask(pflags,mask)  atomic_clear_mask(mask,pf=
lags)
-#define xnarch_atomic_xchg(ptr,x)              xchg(ptr,x)
 #define xnarch_atomic_cmpxchg(pcounter,old,new) \
 	atomic_cmpxchg((pcounter),(old),(new))
=20
-#define xnarch_memory_barrier()  smp_mb()
-
 typedef atomic_t atomic_counter_t;
 typedef atomic_t xnarch_atomic_t;
=20
 #else /* !__KERNEL__ */
=20
-#ifdef CONFIG_SMP
-#define LOCK_PREFIX "lock ; "
-#else
-#define LOCK_PREFIX ""
-#endif
-
-typedef struct { int counter; } xnarch_atomic_t;
-
 struct __xeno_xchg_dummy { unsigned long a[100]; };
 #define __xeno_xg(x) ((struct __xeno_xchg_dummy *)(x))
=20
-#define xnarch_atomic_get(v)		((v)->counter)
-
-#define xnarch_atomic_set(v,i)		(((v)->counter) =3D (i))
-
 static inline unsigned long xnarch_atomic_xchg (volatile void *ptr,
 						unsigned long x)
 {
@@ -84,17 +62,10 @@ xnarch_atomic_cmpxchg(xnarch_atomic_t *v
 	return prev;
 }
=20
-#define xnarch_memory_barrier()  __asm__ __volatile__("": : :"memory")
-
+#define xnarch_memory_barrier()		__asm__ __volatile__("": : :"memory")
 #define xnarch_read_memory_barrier() \
 	__asm__ __volatile__ (LOCK_PREFIX "addl $0,0(%%esp)": : :"memory")
-#define xnarch_write_memory_barrier()	xnarch_memory_barrier()
=20
 #endif /* !__KERNEL__ */
=20
-typedef unsigned long atomic_flags_t;
-
-#include <asm/xenomai/features.h>
-#include <asm-generic/xenomai/atomic.h>
-
 #endif /* !_XENO_ASM_X86_ATOMIC_32_H */
Index: b/include/asm-x86/atomic_64.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- a/include/asm-x86/atomic_64.h
+++ b/include/asm-x86/atomic_64.h
@@ -19,55 +19,25 @@
=20
 #ifndef _XENO_ASM_X86_ATOMIC_64_H
 #define _XENO_ASM_X86_ATOMIC_64_H
-#define _XENO_ASM_X86_ATOMIC_H
-
-#include <asm/xenomai/features.h>
-
-typedef unsigned long atomic_flags_t;
=20
 #ifdef __KERNEL__
=20
-#include <linux/bitops.h>
-#include <asm/atomic.h>
-#include <asm/system.h>
-
 #define xnarch_atomic_set(pcounter,i)          atomic64_set(pcounter,i)
 #define xnarch_atomic_get(pcounter)            atomic64_read(pcounter)
 #define xnarch_atomic_inc(pcounter)            atomic64_inc(pcounter)
 #define xnarch_atomic_dec(pcounter)            atomic64_dec(pcounter)
 #define xnarch_atomic_inc_and_test(pcounter)  atomic64_inc_and_test(pcou=
nter)
 #define xnarch_atomic_dec_and_test(pcounter)  atomic64_dec_and_test(pcou=
nter)
-#define xnarch_atomic_set_mask(pflags,mask) \
-	atomic_set_mask((mask),(unsigned *)(pflags))
-#define xnarch_atomic_clear_mask(pflags,mask) \
-	atomic_clear_mask((mask),(unsigned *)(pflags))
-#define xnarch_atomic_xchg(ptr,x)              xchg(ptr,x)
 #define xnarch_atomic_cmpxchg(pcounter,old,new) \
 	atomic64_cmpxchg((pcounter),(old),(new))
=20
-#define xnarch_memory_barrier()  smp_mb()
-
 typedef atomic64_t atomic_counter_t;
 typedef atomic64_t xnarch_atomic_t;
=20
-#include <asm-generic/xenomai/atomic.h>
-
 #else /* !__KERNEL__ */
=20
-#ifdef CONFIG_SMP
-#define LOCK_PREFIX "lock ; "
-#else
-#define LOCK_PREFIX ""
-#endif
-
-typedef struct { unsigned long counter; } xnarch_atomic_t;
-
 #define __xeno_xg(x) ((volatile long *)(x))
=20
-#define xnarch_atomic_get(v)		((v)->counter)
-
-#define xnarch_atomic_set(v,i)		(((v)->counter) =3D (i))
-
 static inline unsigned long xnarch_atomic_xchg (volatile void *ptr,
 						unsigned long x)
 {
@@ -93,10 +63,7 @@ xnarch_atomic_cmpxchg(xnarch_atomic_t *v
=20
 #define xnarch_memory_barrier()		asm volatile("mfence":::"memory")
 #define xnarch_read_memory_barrier()	asm volatile("lfence":::"memory")
-#define xnarch_write_memory_barrier()	xnarch_memory_barrier()
=20
 #endif /* __KERNEL__ */
=20
-#include <asm-generic/xenomai/atomic.h>
-
 #endif /* !_XENO_ASM_X86_ATOMIC_64_H */


--------------enig7EB7812E4B9B888946FD5323
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iEYEARECAAYFAkivzWEACgkQniDOoMHTA+l1yQCfRHQGdwFcOkKggdIUrtf3kY8e
UUoAniNwRPLHbxmnV91ayl7Dy3r8MeIG
=BxXD
-----END PGP SIGNATURE-----

--------------enig7EB7812E4B9B888946FD5323--

