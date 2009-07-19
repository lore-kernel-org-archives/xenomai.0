Message-ID: <4A62D2C0.7080903@domain.hid>
Date: Sun, 19 Jul 2009 10:01:04 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <4A62D1C1.9050807@domain.hid>
In-Reply-To: <4A62D1C1.9050807@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig22E062621FF20D0C3E80B971"
Sender: jan.kiszka@domain.hid
Subject: [Xenomai-core] [PATCH 3/3] x86: Merge syscall_{32|64}.h into
	syscall.h
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Philippe Gerum <rpm@xenomai.org>
Cc: xenomai-core <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig22E062621FF20D0C3E80B971
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Signed-off-by: Jan Kiszka <jan.kiszka@domain.hid>
---

 include/asm-x86/Makefile.am  |    2=20
 include/asm-x86/syscall.h    |  318 ++++++++++++++++++++++++++++++++++++=
++++++
 include/asm-x86/syscall_32.h |  226 ------------------------------
 include/asm-x86/syscall_64.h |  177 -----------------------
 4 files changed, 316 insertions(+), 407 deletions(-)
 delete mode 100644 include/asm-x86/syscall_32.h
 delete mode 100644 include/asm-x86/syscall_64.h

diff --git a/include/asm-x86/Makefile.am b/include/asm-x86/Makefile.am
index 43d6e51..ee0db80 100644
--- a/include/asm-x86/Makefile.am
+++ b/include/asm-x86/Makefile.am
@@ -17,8 +17,6 @@ includesub_HEADERS =3D	\
 	switch_32.h	\
 	switch_64.h	\
 	switch.h	\
-	syscall_32.h	\
-	syscall_64.h	\
 	syscall.h	\
 	system_32.h	\
 	system_64.h	\
diff --git a/include/asm-x86/syscall.h b/include/asm-x86/syscall.h
index 9b3c1f2..fd11211 100644
--- a/include/asm-x86/syscall.h
+++ b/include/asm-x86/syscall.h
@@ -1,5 +1,319 @@
+/*
+ * Copyright (C) 2001,2002,2003,2007 Philippe Gerum <rpm@xenomai.org>.
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
+#ifndef _XENO_ASM_X86_SYSCALL_H
+#define _XENO_ASM_X86_SYSCALL_H
+
+#include <asm-generic/xenomai/syscall.h>
+
+#define __xn_mux_code(shifted_id,op) ((op << 24)|shifted_id|(__xn_sys_mu=
x & 0x7fff))
+#define __xn_mux_shifted_id(id) ((id << 16) & 0xff0000)
+
+#ifdef __KERNEL__
+
+#include <linux/errno.h>
+#include <asm/uaccess.h>
+#include <asm/ptrace.h>
+#include <asm/xenomai/wrappers.h>
+
+/* Register mapping for accessing syscall args. */
+
+#define __xn_reg_mux(regs)    ((regs)->x86reg_origax)
+#define __xn_reg_rval(regs)   ((regs)->x86reg_ax)
 #ifdef __i386__
-#include "syscall_32.h"
+#define __xn_reg_arg1(regs)   ((regs)->x86reg_bx)
+#define __xn_reg_arg2(regs)   ((regs)->x86reg_cx)
+#define __xn_reg_arg3(regs)   ((regs)->x86reg_dx)
+#define __xn_reg_arg4(regs)   ((regs)->x86reg_si)
+#define __xn_reg_arg5(regs)   ((regs)->x86reg_di)
+#else /* x86_64 */
+#define __xn_reg_arg1(regs)   ((regs)->x86reg_di)
+#define __xn_reg_arg2(regs)   ((regs)->x86reg_si)
+#define __xn_reg_arg3(regs)   ((regs)->x86reg_dx)
+#define __xn_reg_arg4(regs)   ((regs)->r10) /* entry.S convention here. =
*/
+#define __xn_reg_arg5(regs)   ((regs)->r8)
+#endif /* x86_64 */
+
+#define __xn_reg_mux_p(regs)  ((__xn_reg_mux(regs) & 0x7fff) =3D=3D __xn=
_sys_mux)
+#define __xn_mux_id(regs)     ((__xn_reg_mux(regs) >> 16) & 0xff)
+#define __xn_mux_op(regs)     ((__xn_reg_mux(regs) >> 24) & 0xff)
+
+/* Purposedly used inlines and not macros for the following routines
+   so that we don't risk spurious side-effects on the value arg. */
+
+static inline void __xn_success_return(struct pt_regs *regs, int v)
+{
+	__xn_reg_rval(regs) =3D v;
+}
+
+static inline void __xn_error_return(struct pt_regs *regs, int v)
+{
+	__xn_reg_rval(regs) =3D v;
+}
+
+static inline void __xn_status_return(struct pt_regs *regs, int v)
+{
+	__xn_reg_rval(regs) =3D v;
+}
+
+static inline int __xn_interrupted_p(struct pt_regs *regs)
+{
+	return __xn_reg_rval(regs) =3D=3D -EINTR;
+}
+
+#else /* !__KERNEL__ */
+
+/*
+ * Some of the following macros have been adapted from glibc's syscall
+ * mechanism implementation. They define an inline syscall mechanism use=
d
+ * by Xenomai's real-time interfaces to invoke the skin module services
+ * in kernel space.
+ */
+
+#ifdef __i386__
+
+#ifdef CONFIG_XENO_X86_SEP
+/* This form relies on the kernel's vsyscall support in order to use
+   the SEP instructions which must be supported by the hardware. We
+   also depend on the NPTL providing us a pointer to the vsyscall DSO
+   entry point, to which we branch to instead of issuing a trap. */
+#define DOSYSCALL  "call *%%gs:0x10\n\t"
+#else /* CONFIG_XENO_X86_SEP */
+#define DOSYSCALL  "int $0x80\n\t"
+#endif /* CONFIG_XENO_X86_SEP */
+
+/* The one that cannot fail. */
+#define DOSYSCALLSAFE  "int $0x80\n\t"
+
+asm (".L__X'%ebx =3D 1\n\t"
+     ".L__X'%ecx =3D 2\n\t"
+     ".L__X'%edx =3D 2\n\t"
+     ".L__X'%eax =3D 3\n\t"
+     ".L__X'%esi =3D 3\n\t"
+     ".L__X'%edi =3D 3\n\t"
+     ".L__X'%ebp =3D 3\n\t"
+     ".L__X'%esp =3D 3\n\t"
+     ".macro bpushl name reg\n\t"
+     ".if 1 - \\name\n\t"
+     ".if 2 - \\name\n\t"
+     "pushl %ebx\n\t"
+     ".else\n\t"
+     "xchgl \\reg, %ebx\n\t"
+     ".endif\n\t"
+     ".endif\n\t"
+     ".endm\n\t"
+     ".macro bpopl name reg\n\t"
+     ".if 1 - \\name\n\t"
+     ".if 2 - \\name\n\t"
+     "popl %ebx\n\t"
+     ".else\n\t"
+     "xchgl \\reg, %ebx\n\t"
+     ".endif\n\t"
+     ".endif\n\t"
+     ".endm\n\t"
+     ".macro bmovl name reg\n\t"
+     ".if 1 - \\name\n\t"
+     ".if 2 - \\name\n\t"
+     "movl \\reg, %ebx\n\t"
+     ".endif\n\t"
+     ".endif\n\t"
+     ".endm\n\t");
+
+#define XENOMAI_SYS_MUX(nr, op, args...)			\
+({								\
+	unsigned __resultvar;					\
+	asm volatile (						\
+		LOADARGS_##nr					\
+		"movl %1, %%eax\n\t"				\
+		DOSYSCALL					\
+		RESTOREARGS_##nr				\
+		: "=3Da" (__resultvar)				\
+		: "i" (__xn_mux_code(0, op)) ASMFMT_##nr(args)	\
+		: "memory", "cc");				\
+	(int) __resultvar;					\
+})
+
+#define XENOMAI_SYS_MUX_SAFE(nr, op, args...)			\
+({								\
+	unsigned __resultvar;					\
+	asm volatile (						\
+		LOADARGS_##nr					\
+		"movl %1, %%eax\n\t"				\
+		DOSYSCALLSAFE					\
+		RESTOREARGS_##nr				\
+		: "=3Da" (__resultvar)				\
+		: "i" (__xn_mux_code(0, op)) ASMFMT_##nr(args)	\
+		: "memory", "cc");				\
+	(int) __resultvar;					\
+})
+
+#define XENOMAI_SKIN_MUX(nr, shifted_id, op, args...)		\
+({								\
+	int __muxcode =3D __xn_mux_code(shifted_id, op);		\
+	unsigned __resultvar;					\
+	asm volatile (						\
+		LOADARGS_##nr					\
+		"movl %1, %%eax\n\t"				\
+		DOSYSCALL					\
+		RESTOREARGS_##nr				\
+		: "=3Da" (__resultvar)				\
+		: "m" (__muxcode) ASMFMT_##nr(args)		\
+		: "memory", "cc");				\
+	(int) __resultvar;					\
+})
+
+#define LOADARGS_0
+#define LOADARGS_1 \
+	"bpushl .L__X'%k2, %k2\n\t" \
+	"bmovl .L__X'%k2, %k2\n\t"
+#define LOADARGS_2	LOADARGS_1
+#define LOADARGS_3	LOADARGS_1
+#define LOADARGS_4	LOADARGS_1
+#define LOADARGS_5	LOADARGS_1
+
+#define RESTOREARGS_0
+#define RESTOREARGS_1 \
+	"bpopl .L__X'%k2, %k2\n\t"
+#define RESTOREARGS_2	RESTOREARGS_1
+#define RESTOREARGS_3	RESTOREARGS_1
+#define RESTOREARGS_4	RESTOREARGS_1
+#define RESTOREARGS_5	RESTOREARGS_1
+
+#define ASMFMT_0()
+#define ASMFMT_1(arg1) \
+	, "acdSD" (arg1)
+#define ASMFMT_2(arg1, arg2) \
+	, "adSD" (arg1), "c" (arg2)
+#define ASMFMT_3(arg1, arg2, arg3) \
+	, "aSD" (arg1), "c" (arg2), "d" (arg3)
+#define ASMFMT_4(arg1, arg2, arg3, arg4) \
+	, "aD" (arg1), "c" (arg2), "d" (arg3), "S" (arg4)
+#define ASMFMT_5(arg1, arg2, arg3, arg4, arg5) \
+	, "a" (arg1), "c" (arg2), "d" (arg3), "S" (arg4), "D" (arg5)
+
+#define XENOMAI_SYSBIND(a1,a2,a3,a4) \
+	XENOMAI_SYS_MUX_SAFE(4,__xn_sys_bind,a1,a2,a3,a4)
+
+#else /* x86_64 */
+
+#if __GNUC__ < 4 || (__GNUC__ =3D=3D 4 && __GNUC_MINOR__ < 3)
+#define LOAD_ARGS_0()	asm volatile ("" ::: "memory");
 #else
-#include "syscall_64.h"
+#define LOAD_ARGS_0()
 #endif
+#define LOAD_REGS_0
+#define ASM_ARGS_0
+
+#define LOAD_ARGS_1(a1)					\
+	long int __arg1 =3D (long) (a1);			\
+	LOAD_ARGS_0()
+#define LOAD_REGS_1					\
+	register long int _a1 asm ("rdi") =3D __arg1;	\
+	LOAD_REGS_0
+#define ASM_ARGS_1	ASM_ARGS_0, "+r" (_a1)
+
+#define LOAD_ARGS_2(a1, a2)				\
+	long int __arg2 =3D (long) (a2);			\
+	LOAD_ARGS_1(a1)
+#define LOAD_REGS_2					\
+	register long int _a2 asm ("rsi") =3D __arg2;	\
+	LOAD_REGS_1
+#define ASM_ARGS_2	ASM_ARGS_1, "+r" (_a2)
+
+#define LOAD_ARGS_3(a1, a2, a3)				\
+	long int __arg3 =3D (long) (a3);			\
+	LOAD_ARGS_2 (a1, a2)
+#define LOAD_REGS_3					\
+	register long int _a3 asm ("rdx") =3D __arg3;	\
+	LOAD_REGS_2
+#define ASM_ARGS_3	ASM_ARGS_2, "+r" (_a3)
+
+#define LOAD_ARGS_4(a1, a2, a3, a4)			\
+	long int __arg4 =3D (long) (a4);			\
+	LOAD_ARGS_3 (a1, a2, a3)
+#define LOAD_REGS_4					\
+	register long int _a4 asm ("r10") =3D __arg4;	\
+	LOAD_REGS_3
+#define ASM_ARGS_4	ASM_ARGS_3, "+r" (_a4)
+
+#define LOAD_ARGS_5(a1, a2, a3, a4, a5)			\
+	long int __arg5 =3D (long) (a5);			\
+	LOAD_ARGS_4 (a1, a2, a3, a4)
+#define LOAD_REGS_5					\
+	register long int _a5 asm ("r8") =3D __arg5;	\
+	LOAD_REGS_4
+#define ASM_ARGS_5	ASM_ARGS_4, "+r" (_a5)
+
+#define DO_SYSCALL(name, nr, args...)			\
+({							\
+	unsigned long __resultvar;			\
+	LOAD_ARGS_##nr(args)				\
+	LOAD_REGS_##nr					\
+	asm volatile (					\
+		"syscall\n\t"				\
+		: "=3Da" (__resultvar) ASM_ARGS_##nr	\
+		: "0" (name)				\
+		: "memory", "cc", "r11", "cx");		\
+	(long) __resultvar;				\
+})
+
+#define XENOMAI_SYS_MUX(nr, op, args...) \
+	DO_SYSCALL(__xn_mux_code(0,op), nr, args)
+
+#define XENOMAI_SKIN_MUX(nr, shifted_id, op, args...) \
+	DO_SYSCALL(__xn_mux_code(shifted_id,op), nr, args)
+
+#define XENOMAI_SYSBIND(a1,a2,a3,a4) \
+	XENOMAI_SYS_MUX(4,__xn_sys_bind,a1,a2,a3,a4)
+
+#endif /* x86_64 */
+
+#define XENOMAI_SYSCALL0(op)			XENOMAI_SYS_MUX(0,op)
+#define XENOMAI_SYSCALL1(op,a1)			XENOMAI_SYS_MUX(1,op,a1)
+#define XENOMAI_SYSCALL2(op,a1,a2)		XENOMAI_SYS_MUX(2,op,a1,a2)
+#define XENOMAI_SYSCALL3(op,a1,a2,a3)		XENOMAI_SYS_MUX(3,op,a1,a2,a3)
+#define XENOMAI_SYSCALL4(op,a1,a2,a3,a4)	XENOMAI_SYS_MUX(4,op,a1,a2,a3,a=
4)
+#define XENOMAI_SYSCALL5(op,a1,a2,a3,a4,a5)	XENOMAI_SYS_MUX(5,op,a1,a2,a=
3,a4,a5)
+
+#define XENOMAI_SKINCALL0(id,op)		XENOMAI_SKIN_MUX(0,id,op)
+#define XENOMAI_SKINCALL1(id,op,a1)		XENOMAI_SKIN_MUX(1,id,op,a1)
+#define XENOMAI_SKINCALL2(id,op,a1,a2)		XENOMAI_SKIN_MUX(2,id,op,a1,a2)
+#define XENOMAI_SKINCALL3(id,op,a1,a2,a3)	XENOMAI_SKIN_MUX(3,id,op,a1,a2=
,a3)
+#define XENOMAI_SKINCALL4(id,op,a1,a2,a3,a4)	XENOMAI_SKIN_MUX(4,id,op,a1=
,a2,a3,a4)
+#define XENOMAI_SKINCALL5(id,op,a1,a2,a3,a4,a5)	XENOMAI_SKIN_MUX(5,id,op=
,a1,a2,a3,a4,a5)
+
+static inline unsigned long long __xn_rdtsc(void)
+{
+#ifdef __i386__
+	unsigned long long t;
+
+	asm volatile ("rdtsc" : "=3DA" (t));
+	return t;
+
+#else /* x86_64 */
+	unsigned int __a,__d;
+
+	asm volatile ("rdtsc" : "=3Da" (__a), "=3Dd" (__d));
+	return ((unsigned long)__a) | (((unsigned long)__d) << 32);
+#endif /* x86_64 */
+}
+
+#endif /* !__KERNEL__ */
+
+#endif /* !_XENO_ASM_X86_SYSCALL_H */
diff --git a/include/asm-x86/syscall_32.h b/include/asm-x86/syscall_32.h
deleted file mode 100644
index a91805e..0000000
--- a/include/asm-x86/syscall_32.h
+++ /dev/null
@@ -1,226 +0,0 @@
-/*
- * Copyright (C) 2001,2002,2003 Philippe Gerum <rpm@xenomai.org>.
- *
- * Xenomai is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published
- * by the Free Software Foundation; either version 2 of the License,
- * or (at your option) any later version.
- *
- * Xenomai is distributed in the hope that it will be useful, but
- * WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
- * General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with Xenomai; if not, write to the Free Software
- * Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA
- * 02111-1307, USA.
- */
-
-#ifndef _XENO_ASM_X86_SYSCALL_32_H
-#define _XENO_ASM_X86_SYSCALL_32_H
-#define _XENO_ASM_X86_SYSCALL_H
-
-#include <asm-generic/xenomai/syscall.h>
-
-#define __xn_mux_code(shifted_id,op) ((op << 24)|shifted_id|(__xn_sys_mu=
x & 0x7fff))
-#define __xn_mux_shifted_id(id) ((id << 16) & 0xff0000)
-
-#ifdef __KERNEL__
-
-#include <linux/errno.h>
-#include <asm/uaccess.h>
-#include <asm/ptrace.h>
-#include <asm/xenomai/wrappers.h>
-
-/* Register mapping for accessing syscall args. */
-
-#define __xn_reg_mux(regs)    ((regs)->x86reg_origax)
-#define __xn_reg_rval(regs)   ((regs)->x86reg_ax)
-#define __xn_reg_arg1(regs)   ((regs)->x86reg_bx)
-#define __xn_reg_arg2(regs)   ((regs)->x86reg_cx)
-#define __xn_reg_arg3(regs)   ((regs)->x86reg_dx)
-#define __xn_reg_arg4(regs)   ((regs)->x86reg_si)
-#define __xn_reg_arg5(regs)   ((regs)->x86reg_di)
-
-#define __xn_reg_mux_p(regs)  ((__xn_reg_mux(regs) & 0x7fff) =3D=3D __xn=
_sys_mux)
-#define __xn_mux_id(regs)     ((__xn_reg_mux(regs) >> 16) & 0xff)
-#define __xn_mux_op(regs)     ((__xn_reg_mux(regs) >> 24) & 0xff)
-
-/* Purposedly used inlines and not macros for the following routines
-   so that we don't risk spurious side-effects on the value arg. */
-
-static inline void __xn_success_return(struct pt_regs *regs, int v)
-{
-	__xn_reg_rval(regs) =3D v;
-}
-
-static inline void __xn_error_return(struct pt_regs *regs, int v)
-{
-	__xn_reg_rval(regs) =3D v;
-}
-
-static inline void __xn_status_return(struct pt_regs *regs, int v)
-{
-	__xn_reg_rval(regs) =3D v;
-}
-
-static inline int __xn_interrupted_p(struct pt_regs *regs)
-{
-	return __xn_reg_rval(regs) =3D=3D -EINTR;
-}
-
-#else /* !__KERNEL__ */
-
-/*
- * Some of the following macros have been adapted from glibc's syscall
- * mechanism implementation:
- * Copyright (C) 1992,1993,1995-2000,2002,2003 Free Software Foundation,=
 Inc.
- * Contributed by Ulrich Drepper, <drepper@domain.hid>, August 1995.
- *
- * The following code defines an inline syscall mechanism used by
- * Xenomai's real-time interfaces to invoke the skin module services
- * in kernel space.
- */
-
-#ifdef CONFIG_XENO_X86_SEP
-/* This form relies on the kernel's vsyscall support in order to use
-   the SEP instructions which must be supported by the hardware. We
-   also depend on the NPTL providing us a pointer to the vsyscall DSO
-   entry point, to which we branch to instead of issuing a trap. */
-#define DOSYSCALL  "call *%%gs:0x10\n\t"
-#else /* CONFIG_XENO_X86_SEP */
-#define DOSYSCALL  "int $0x80\n\t"
-#endif /* CONFIG_XENO_X86_SEP */
-
-/* The one that cannot fail. */
-#define DOSYSCALLSAFE  "int $0x80\n\t"
-
-asm (".L__X'%ebx =3D 1\n\t"
-     ".L__X'%ecx =3D 2\n\t"
-     ".L__X'%edx =3D 2\n\t"
-     ".L__X'%eax =3D 3\n\t"
-     ".L__X'%esi =3D 3\n\t"
-     ".L__X'%edi =3D 3\n\t"
-     ".L__X'%ebp =3D 3\n\t"
-     ".L__X'%esp =3D 3\n\t"
-     ".macro bpushl name reg\n\t"
-     ".if 1 - \\name\n\t"
-     ".if 2 - \\name\n\t"
-     "pushl %ebx\n\t"
-     ".else\n\t"
-     "xchgl \\reg, %ebx\n\t"
-     ".endif\n\t"
-     ".endif\n\t"
-     ".endm\n\t"
-     ".macro bpopl name reg\n\t"
-     ".if 1 - \\name\n\t"
-     ".if 2 - \\name\n\t"
-     "popl %ebx\n\t"
-     ".else\n\t"
-     "xchgl \\reg, %ebx\n\t"
-     ".endif\n\t"
-     ".endif\n\t"
-     ".endm\n\t"
-     ".macro bmovl name reg\n\t"
-     ".if 1 - \\name\n\t"
-     ".if 2 - \\name\n\t"
-     "movl \\reg, %ebx\n\t"
-     ".endif\n\t"
-     ".endif\n\t"
-     ".endm\n\t");
-
-#define XENOMAI_SYS_MUX(nr, op, args...) \
-  ({								      \
-    unsigned resultvar;						      \
-    asm volatile (						      \
-    LOADARGS_##nr						      \
-    "movl %1, %%eax\n\t"					      \
-    DOSYSCALL							      \
-    RESTOREARGS_##nr						      \
-    : "=3Da" (resultvar)						      \
-    : "i" (__xn_mux_code(0,op)) ASMFMT_##nr(args) : "memory", "cc");  \
-    (int) resultvar; })
-
-#define XENOMAI_SYS_MUX_SAFE(nr, op, args...) \
-  ({								      \
-    unsigned resultvar;						      \
-    asm volatile (						      \
-    LOADARGS_##nr						      \
-    "movl %1, %%eax\n\t"					      \
-    DOSYSCALLSAFE						      \
-    RESTOREARGS_##nr						      \
-    : "=3Da" (resultvar)						      \
-    : "i" (__xn_mux_code(0,op)) ASMFMT_##nr(args) : "memory", "cc");  \
-    (int) resultvar; })
-
-#define XENOMAI_SKIN_MUX(nr, shifted_id, op, args...) \
-  ({								      \
-    int muxcode =3D __xn_mux_code(shifted_id,op);			      \
-    unsigned resultvar;						      \
-    asm volatile (						      \
-    LOADARGS_##nr						      \
-    "movl %1, %%eax\n\t"					      \
-    DOSYSCALL							      \
-    RESTOREARGS_##nr						      \
-    : "=3Da" (resultvar)						      \
-    : "m" (muxcode) ASMFMT_##nr(args) : "memory", "cc");	      \
-    (int) resultvar; })
-
-#define LOADARGS_0
-#define LOADARGS_1 \
-    "bpushl .L__X'%k2, %k2\n\t" \
-    "bmovl .L__X'%k2, %k2\n\t"
-#define LOADARGS_2	LOADARGS_1
-#define LOADARGS_3	LOADARGS_1
-#define LOADARGS_4	LOADARGS_1
-#define LOADARGS_5	LOADARGS_1
-
-#define RESTOREARGS_0
-#define RESTOREARGS_1 \
-    "bpopl .L__X'%k2, %k2\n\t"
-#define RESTOREARGS_2	RESTOREARGS_1
-#define RESTOREARGS_3	RESTOREARGS_1
-#define RESTOREARGS_4	RESTOREARGS_1
-#define RESTOREARGS_5	RESTOREARGS_1
-
-#define ASMFMT_0()
-#define ASMFMT_1(arg1) \
-	, "acdSD" (arg1)
-#define ASMFMT_2(arg1, arg2) \
-	, "adSD" (arg1), "c" (arg2)
-#define ASMFMT_3(arg1, arg2, arg3) \
-	, "aSD" (arg1), "c" (arg2), "d" (arg3)
-#define ASMFMT_4(arg1, arg2, arg3, arg4) \
-	, "aD" (arg1), "c" (arg2), "d" (arg3), "S" (arg4)
-#define ASMFMT_5(arg1, arg2, arg3, arg4, arg5) \
-	, "a" (arg1), "c" (arg2), "d" (arg3), "S" (arg4), "D" (arg5)
-
-#define XENOMAI_SYSCALL0(op)                XENOMAI_SYS_MUX(0,op)
-#define XENOMAI_SYSCALL1(op,a1)             XENOMAI_SYS_MUX(1,op,a1)
-#define XENOMAI_SYSCALL2(op,a1,a2)          XENOMAI_SYS_MUX(2,op,a1,a2)
-#define XENOMAI_SYSCALL3(op,a1,a2,a3)       XENOMAI_SYS_MUX(3,op,a1,a2,a=
3)
-#define XENOMAI_SYSCALL4(op,a1,a2,a3,a4)    XENOMAI_SYS_MUX(4,op,a1,a2,a=
3,a4)
-#define XENOMAI_SYSCALL5(op,a1,a2,a3,a4,a5) XENOMAI_SYS_MUX(5,op,a1,a2,a=
3,a4,a5)
-#define XENOMAI_SYSBIND(a1,a2,a3,a4)        XENOMAI_SYS_MUX_SAFE(4,__xn_=
sys_bind,a1,a2,a3,a4)
-
-#define XENOMAI_SKINCALL0(id,op)                XENOMAI_SKIN_MUX(0,id,op=
)
-#define XENOMAI_SKINCALL1(id,op,a1)             XENOMAI_SKIN_MUX(1,id,op=
,a1)
-#define XENOMAI_SKINCALL2(id,op,a1,a2)          XENOMAI_SKIN_MUX(2,id,op=
,a1,a2)
-#define XENOMAI_SKINCALL3(id,op,a1,a2,a3)       XENOMAI_SKIN_MUX(3,id,op=
,a1,a2,a3)
-#define XENOMAI_SKINCALL4(id,op,a1,a2,a3,a4)    XENOMAI_SKIN_MUX(4,id,op=
,a1,a2,a3,a4)
-#define XENOMAI_SKINCALL5(id,op,a1,a2,a3,a4,a5) XENOMAI_SKIN_MUX(5,id,op=
,a1,a2,a3,a4,a5)
-
-#ifdef XNARCH_HAVE_NONPRIV_TSC
-static inline unsigned long long __xn_rdtsc (void)
-
-{
-    unsigned long long t;
-    __asm__ __volatile__( "rdtsc" : "=3DA" (t));
-    return t;
-}
-#endif  /* XNARCH_HAVE_NONPRIV_TSC */
-
-#endif /* __KERNEL__ */
-
-#endif /* !_XENO_ASM_X86_SYSCALL_32_H */
diff --git a/include/asm-x86/syscall_64.h b/include/asm-x86/syscall_64.h
deleted file mode 100644
index 6918ac4..0000000
--- a/include/asm-x86/syscall_64.h
+++ /dev/null
@@ -1,177 +0,0 @@
-/*
- * Copyright (C) 2007 Philippe Gerum <rpm@xenomai.org>.
- *
- * Xenomai is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published
- * by the Free Software Foundation; either version 2 of the License,
- * or (at your option) any later version.
- *
- * Xenomai is distributed in the hope that it will be useful, but
- * WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
- * General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with Xenomai; if not, write to the Free Software
- * Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA
- * 02111-1307, USA.
- */
-
-#ifndef _XENO_ASM_X86_SYSCALL_64_H
-#define _XENO_ASM_X86_SYSCALL_64_H
-#define _XENO_ASM_X86_SYSCALL_H
-
-#include <asm-generic/xenomai/syscall.h>
-
-#define __xn_mux_code(shifted_id,op) ((op << 24)|shifted_id|(__xn_sys_mu=
x & 0x7fff))
-#define __xn_mux_shifted_id(id) ((id << 16) & 0xff0000)
-
-#ifdef __KERNEL__
-
-#include <linux/errno.h>
-#include <asm/uaccess.h>
-#include <asm/ptrace.h>
-#include <asm/xenomai/wrappers.h>
-
-/* Register mapping for accessing syscall args. */
-
-#define __xn_reg_mux(regs)    ((regs)->x86reg_origax)
-#define __xn_reg_rval(regs)   ((regs)->x86reg_ax)
-#define __xn_reg_arg1(regs)   ((regs)->x86reg_di)
-#define __xn_reg_arg2(regs)   ((regs)->x86reg_si)
-#define __xn_reg_arg3(regs)   ((regs)->x86reg_dx)
-#define __xn_reg_arg4(regs)   ((regs)->r10) /* entry.S convention here. =
*/
-#define __xn_reg_arg5(regs)   ((regs)->r8)
-
-#define __xn_reg_mux_p(regs)  ((__xn_reg_mux(regs) & 0x7fff) =3D=3D __xn=
_sys_mux)
-#define __xn_mux_id(regs)     ((__xn_reg_mux(regs) >> 16) & 0xff)
-#define __xn_mux_op(regs)     ((__xn_reg_mux(regs) >> 24) & 0xff)
-
-/* Purposedly used inlines and not macros for the following routines
-   so that we don't risk spurious side-effects on the value arg. */
-
-static inline void __xn_success_return(struct pt_regs *regs, int v)
-{
-	__xn_reg_rval(regs) =3D v;
-}
-
-static inline void __xn_error_return(struct pt_regs *regs, int v)
-{
-	__xn_reg_rval(regs) =3D v;
-}
-
-static inline void __xn_status_return(struct pt_regs *regs, int v)
-{
-	__xn_reg_rval(regs) =3D v;
-}
-
-static inline int __xn_interrupted_p(struct pt_regs *regs)
-{
-	return __xn_reg_rval(regs) =3D=3D -EINTR;
-}
-
-#else /* !__KERNEL__ */
-
-/*
- * Some of the following macros have been adapted from glibc's syscall
- * mechanism implementation: sysdeps/unix/sysv/linux/x86_64/sysdep.h.
-*  Copyright (C) 2001,02,03,04 Free Software Foundation, Inc.
- *
- * The following code defines an inline syscall mechanism used by
- * Xenomai's real-time interfaces to invoke the skin module services
- * in kernel space.
- */
-
-#if __GNUC__ < 4 || (__GNUC__ =3D=3D 4 && __GNUC_MINOR__ < 3)
-#define LOAD_ARGS_0()	asm volatile ("" ::: "memory");
-#else
-#define LOAD_ARGS_0()
-#endif
-#define LOAD_REGS_0
-#define ASM_ARGS_0
-
-#define LOAD_ARGS_1(a1)				\
-	long int __arg1 =3D (long) (a1);			\
-	LOAD_ARGS_0 ()
-#define LOAD_REGS_1					\
-	register long int _a1 asm ("rdi") =3D __arg1;	\
-	LOAD_REGS_0
-#define ASM_ARGS_1	ASM_ARGS_0, "r" (_a1)
-
-#define LOAD_ARGS_2(a1, a2)				\
-  long int __arg2 =3D (long) (a2);			\
-  LOAD_ARGS_1 (a1)
-#define LOAD_REGS_2					\
-  register long int _a2 asm ("rsi") =3D __arg2;		\
-  LOAD_REGS_1
-#define ASM_ARGS_2	ASM_ARGS_1, "r" (_a2)
-
-#define LOAD_ARGS_3(a1, a2, a3)			\
-  long int __arg3 =3D (long) (a3);			\
-  LOAD_ARGS_2 (a1, a2)
-#define LOAD_REGS_3					\
-  register long int _a3 asm ("rdx") =3D __arg3;		\
-  LOAD_REGS_2
-#define ASM_ARGS_3	ASM_ARGS_2, "r" (_a3)
-
-#define LOAD_ARGS_4(a1, a2, a3, a4)			\
-  long int __arg4 =3D (long) (a4);			\
-  LOAD_ARGS_3 (a1, a2, a3)
-#define LOAD_REGS_4					\
-  register long int _a4 asm ("r10") =3D __arg4;		\
-  LOAD_REGS_3
-#define ASM_ARGS_4	ASM_ARGS_3, "r" (_a4)
-
-#define LOAD_ARGS_5(a1, a2, a3, a4, a5)		\
-  long int __arg5 =3D (long) (a5);			\
-  LOAD_ARGS_4 (a1, a2, a3, a4)
-#define LOAD_REGS_5					\
-  register long int _a5 asm ("r8") =3D __arg5;		\
-  LOAD_REGS_4
-#define ASM_ARGS_5	ASM_ARGS_4, "r" (_a5)
-
-#define DO_SYSCALL(name, nr, args...)					\
-	({								\
-	  unsigned long __resultvar;					\
-	  LOAD_ARGS_##nr (args)						\
-	  LOAD_REGS_##nr						\
-	  asm volatile("syscall\n\t"					\
-		       : "=3Da" (__resultvar)				\
-		       : "0" (name) ASM_ARGS_##nr			\
-		       : "memory", "cc", "r11", "cx");			\
-	  (long)__resultvar;						\
-	})
-
-#define XENOMAI_SYS_MUX(nr, op, args...) \
-	DO_SYSCALL(__xn_mux_code(0,op), nr, args)
-
-#define XENOMAI_SKIN_MUX(nr, shifted_id, op, args...) \
-	DO_SYSCALL(__xn_mux_code(shifted_id,op), nr, args)
-
-#define XENOMAI_SYSCALL0(op)                XENOMAI_SYS_MUX(0,op)
-#define XENOMAI_SYSCALL1(op,a1)             XENOMAI_SYS_MUX(1,op,a1)
-#define XENOMAI_SYSCALL2(op,a1,a2)          XENOMAI_SYS_MUX(2,op,a1,a2)
-#define XENOMAI_SYSCALL3(op,a1,a2,a3)       XENOMAI_SYS_MUX(3,op,a1,a2,a=
3)
-#define XENOMAI_SYSCALL4(op,a1,a2,a3,a4)    XENOMAI_SYS_MUX(4,op,a1,a2,a=
3,a4)
-#define XENOMAI_SYSCALL5(op,a1,a2,a3,a4,a5) XENOMAI_SYS_MUX(5,op,a1,a2,a=
3,a4,a5)
-#define XENOMAI_SYSBIND(a1,a2,a3,a4)        XENOMAI_SYS_MUX(4,__xn_sys_b=
ind,a1,a2,a3,a4)
-
-#define XENOMAI_SKINCALL0(id,op)                XENOMAI_SKIN_MUX(0,id,op=
)
-#define XENOMAI_SKINCALL1(id,op,a1)             XENOMAI_SKIN_MUX(1,id,op=
,a1)
-#define XENOMAI_SKINCALL2(id,op,a1,a2)          XENOMAI_SKIN_MUX(2,id,op=
,a1,a2)
-#define XENOMAI_SKINCALL3(id,op,a1,a2,a3)       XENOMAI_SKIN_MUX(3,id,op=
,a1,a2,a3)
-#define XENOMAI_SKINCALL4(id,op,a1,a2,a3,a4)    XENOMAI_SKIN_MUX(4,id,op=
,a1,a2,a3,a4)
-#define XENOMAI_SKINCALL5(id,op,a1,a2,a3,a4,a5) XENOMAI_SKIN_MUX(5,id,op=
,a1,a2,a3,a4,a5)
-
-static inline unsigned long long __xn_rdtsc(void)
-{
-	unsigned long long t;
-	unsigned int __a,__d;
-	asm volatile("rdtsc" : "=3Da" (__a), "=3Dd" (__d));
-	t =3D ((unsigned long)__a) | (((unsigned long)__d)<<32);
-	return t;
-}
-
-#endif /* __KERNEL__ */
-
-#endif /* !_XENO_ASM_X86_SYSCALL_64_H */


--------------enig22E062621FF20D0C3E80B971
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iEYEARECAAYFAkpi0sAACgkQniDOoMHTA+kndwCfalKKrLJ5jh9bPbmOCHzvpcZP
BW8Anjb7fEQvJic2GSpYBcdJTOKmXAyu
=7g3A
-----END PGP SIGNATURE-----

--------------enig22E062621FF20D0C3E80B971--

