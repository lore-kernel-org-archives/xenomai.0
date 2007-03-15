From: Stelian Pop <stelian.pop@domain.hid>
Content-Type: text/plain; charset=ISO-8859-15
Date: Thu, 15 Mar 2007 14:53:54 +0100
Message-Id: <1173966835.16299.49.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Xenomai-core] [PATCH - ARM] ldrex/strex syntax errors with recent
	compilers
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai@xenomai.org

Hi,

Trying to build a xenomai-enabled kernel using a recent compiler (tried
with gcc version 4.1.1 (CodeSourcery ARM Sourcery G++ 2006q3-26), but
all gcc > 4.1 might be affected) results in the following:

  CC      kernel/xenomai/nucleus/shadow.o
/tmp/cc0XooxH.s: Assembler messages:
/tmp/cc0XooxH.s:1464: Error: instruction does not accept this addressing =
mode -- `ldrex r1,r2'
/tmp/cc0XooxH.s:1466: Error: instruction does not accept this addressing =
mode -- `strex r3,r1,r2'

Older gcc (like gcc version 4.0.0 (DENX ELDK 4.1 4.0.0)) have no problem =
with this.

It appears that the patch below fixes the compile error. I also verified=20
that gcc-4.0.0 generates identical code using both forms.

Index: include/asm-arm/atomic.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- include/asm-arm/atomic.h	(r=E9vision 2299)
+++ include/asm-arm/atomic.h	(copie de travail)
@@ -40,9 +40,9 @@
     unsigned long tmp, tmp2;
=20
     __asm__ __volatile__("@ atomic_set_mask\n"
-"1: ldrex   %0, %2\n"
+"1: ldrex   %0, [%2]\n"
 "   orr     %0, %0, %3\n"
-"   strex   %1, %0, %2\n"
+"   strex   %1, %0, [%2]\n"
 "   teq     %1, #0\n"
 "   bne     1b"
     : "=3D&r" (tmp), "=3D&r" (tmp2)
@@ -170,9 +170,9 @@
     unsigned long tmp, tmp2;
=20
     __asm__ __volatile__("@ atomic_set_mask\n"
-"1: ldrex   %0, %2\n"
+"1: ldrex   %0, [%2]\n"
 "   orr     %0, %0, %3\n"
-"   strex   %1, %0, %2\n"
+"   strex   %1, %0, [%2]\n"
 "   teq     %1, #0\n"
 "   bne     1b"
     : "=3D&r" (tmp), "=3D&r" (tmp2)
@@ -185,9 +185,9 @@
     unsigned long tmp, tmp2;
=20
     __asm__ __volatile__("@ atomic_clear_mask\n"
-"1: ldrex   %0, %2\n"
+"1: ldrex   %0, [%2]\n"
 "   bic     %0, %0, %3\n"
-"   strex   %1, %0, %2\n"
+"   strex   %1, %0, [%2]\n"
 "   teq     %1, #0\n"
 "   bne     1b"
     : "=3D&r" (tmp), "=3D&r" (tmp2)

--=20
Stelian Pop <stelian.pop@domain.hid>


