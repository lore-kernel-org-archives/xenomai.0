From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [PATCH] lib/cobalt: arm64: Rework syscall wrappers
Message-ID: <454865ce-e7f0-77b7-b9ca-5fab99ac0926@siemens.com>
Date: Mon, 9 Aug 2021 13:54:31 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Xenomai <xenomai@xenomai.org>, Philippe Gerum <rpm@xenomai.org>

From: Jan Kiszka <jan.kiszka@siemens.com>

Converting them into inline functions helps to avoid clobbering of w8.
Without this, the compiler may squeeze function calls between the setup
of __scno in w8 and the actually submission of the syscall. Seen with
the smokey y2038 testcase.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---

Close to an out-of-line version, possibly even better.

I'm not sure, though, if that pattern buys us anything on 32-bit arm. 
Problem there remains the usage conflict of r7 which static inline may 
not resolve.

 .../arch/arm64/include/asm/xenomai/syscall.h  | 115 ++++++++++--------
 1 file changed, 61 insertions(+), 54 deletions(-)

diff --git a/lib/cobalt/arch/arm64/include/asm/xenomai/syscall.h b/lib/cobalt/arch/arm64/include/asm/xenomai/syscall.h
index d2dfda6846..d896977125 100644
--- a/lib/cobalt/arch/arm64/include/asm/xenomai/syscall.h
+++ b/lib/cobalt/arch/arm64/include/asm/xenomai/syscall.h
@@ -1,5 +1,6 @@
 /*
  * Copyright (C) 2015 Philippe Gerum <rpm@xenomai.org>.
+ * Copyright (C) Siemens AG, 2021
  *
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
@@ -22,76 +23,82 @@
 #include <errno.h>
 #include <cobalt/uapi/syscall.h>
 
-#define __emit_asmdecl0							\
-	register unsigned int __scno  __asm__ ("w8");			\
-	register unsigned long __res  __asm__ ("x0")
-#define __emit_asmdecl1							\
-	__emit_asmdecl0; register unsigned long __x0  __asm__ ("x0")
-#define __emit_asmdecl2							\
-	__emit_asmdecl1; register unsigned long __x1  __asm__ ("x1")
-#define __emit_asmdecl3							\
-	__emit_asmdecl2; register unsigned long __x2  __asm__ ("x2")
-#define __emit_asmdecl4							\
-	__emit_asmdecl3; register unsigned long __x3  __asm__ ("x3")
-#define __emit_asmdecl5							\
-	__emit_asmdecl4; register unsigned long __x4  __asm__ ("x4")
-
-#define __load_asminput0(__op)						\
-	__scno = (unsigned int)__xn_syscode(__op)
-#define __load_asminput1(__op, __a1)					\
-	__load_asminput0(__op);						\
-	__x0 = (unsigned long)(__a1)
-#define __load_asminput2(__op, __a1, __a2)				\
-	__load_asminput1(__op, __a1);					\
-	__x1 = (unsigned long)(__a2)
-#define __load_asminput3(__op, __a1, __a2, __a3)			\
-	__load_asminput2(__op, __a1, __a2);				\
-	__x2 = (unsigned long)(__a3)
-#define __load_asminput4(__op, __a1, __a2, __a3, __a4)			\
-	__load_asminput3(__op, __a1, __a2, __a3);			\
-	__x3 = (unsigned long)(__a4)
-#define __load_asminput5(__op, __a1, __a2, __a3, __a4, __a5)		\
-	__load_asminput4(__op, __a1, __a2, __a3, __a4);			\
-	__x4 = (unsigned long)(__a5)
+#define __xn_syscall_args0
+#define __xn_syscall_args1 , unsigned long __a1
+#define __xn_syscall_args2 __xn_syscall_args1, unsigned long __a2
+#define __xn_syscall_args3 __xn_syscall_args2, unsigned long __a3
+#define __xn_syscall_args4 __xn_syscall_args3, unsigned long __a4
+#define __xn_syscall_args5 __xn_syscall_args4, unsigned long __a5
 
 #define __emit_syscall0(__args...)					\
+	register unsigned int __scno __asm__("w8") = __xn_syscode(__op); \
+	register unsigned long __res __asm__("x0");			\
 	__asm__ __volatile__ (						\
 		"svc 0;\n\t"						\
 		: "=r" (__res)						\
 		: "r" (__scno), ##__args				\
 		: "cc", "memory");					\
-	__res
-#define __emit_syscall1(__a1, __args...)				\
+	return __res
+#define __emit_syscall1(__args...)					\
+	register unsigned long __x0 __asm__("x0") = __a1;		\
 	__emit_syscall0("r" (__x0),  ##__args)
-#define __emit_syscall2(__a1, __a2, __args...)				\
-	__emit_syscall1(__a1, "r" (__x1), ##__args)
-#define __emit_syscall3(__a1, __a2, __a3, __args...)			\
-	__emit_syscall2(__a1, __a2, "r" (__x2), ##__args)
-#define __emit_syscall4(__a1, __a2, __a3, __a4, __args...)		\
-	__emit_syscall3(__a1, __a2, __a3, "r" (__x3), ##__args)
-#define __emit_syscall5(__a1, __a2, __a3, __a4, __a5, __args...)	\
-	__emit_syscall4(__a1, __a2, __a3, __a4, "r" (__x4), ##__args)
+#define __emit_syscall2(__args...)					\
+	register unsigned long __x1 __asm__("x1") = __a2;		\
+	__emit_syscall1("r" (__x1), ##__args)
+#define __emit_syscall3(__args...)					\
+	register unsigned long __x2 __asm__("x2") = __a3;		\
+	__emit_syscall2("r" (__x2), ##__args)
+#define __emit_syscall4(__args...)					\
+	register unsigned long __x3 __asm__("x3") = __a4;		\
+	__emit_syscall3("r" (__x3), ##__args)
+#define __emit_syscall5(__args...)	\
+	register unsigned long __x4 __asm__("x4") = __a5;		\
+	__emit_syscall4("r" (__x4), ##__args)
+
+#define DEFINE_XENOMAI_SYSCALL(__argnr)					\
+static inline long __attribute__((always_inline))			\
+__xenomai_do_syscall##__argnr(unsigned int __op				\
+			      __xn_syscall_args##__argnr)		\
+{									\
+	__emit_syscall##__argnr();					\
+}
 
-#define XENOMAI_DO_SYSCALL(__argnr, __op, __args...)		\
-	({							\
-		__emit_asmdecl##__argnr;			\
-		__load_asminput##__argnr(__op, ##__args);	\
-		__emit_syscall##__argnr(__args);		\
-	})
+DEFINE_XENOMAI_SYSCALL(0)
+DEFINE_XENOMAI_SYSCALL(1)
+DEFINE_XENOMAI_SYSCALL(2)
+DEFINE_XENOMAI_SYSCALL(3)
+DEFINE_XENOMAI_SYSCALL(4)
+DEFINE_XENOMAI_SYSCALL(5)
 
 #define XENOMAI_SYSCALL0(__op)					\
-	XENOMAI_DO_SYSCALL(0, __op)
+	__xenomai_do_syscall0(__op)
 #define XENOMAI_SYSCALL1(__op, __a1)				\
-	XENOMAI_DO_SYSCALL(1, __op, __a1)
+	__xenomai_do_syscall1(__op,				\
+			      (unsigned long)__a1)
 #define XENOMAI_SYSCALL2(__op, __a1, __a2)			\
-	XENOMAI_DO_SYSCALL(2, __op, __a1, __a2)
+	__xenomai_do_syscall2(__op,				\
+			      (unsigned long)__a1,		\
+			      (unsigned long)__a2)
 #define XENOMAI_SYSCALL3(__op, __a1, __a2, __a3)		\
-	XENOMAI_DO_SYSCALL(3, __op, __a1, __a2, __a3)
+	__xenomai_do_syscall3(__op,				\
+			      (unsigned long)__a1,		\
+			      (unsigned long)__a2,		\
+			      (unsigned long)__a3)
 #define XENOMAI_SYSCALL4(__op, __a1, __a2, __a3, __a4)		\
-	XENOMAI_DO_SYSCALL(4, __op, __a1, __a2, __a3, __a4)
+	__xenomai_do_syscall4(__op,				\
+			      (unsigned long)__a1,		\
+			      (unsigned long)__a2,		\
+			      (unsigned long)__a3,		\
+			      (unsigned long)__a4)
 #define XENOMAI_SYSCALL5(__op, __a1, __a2, __a3, __a4, __a5)	\
-	XENOMAI_DO_SYSCALL(5, __op, __a1, __a2, __a3, __a4, __a5)
+	__xenomai_do_syscall5(__op,				\
+			      (unsigned long)__a1,		\
+			      (unsigned long)__a2,		\
+			      (unsigned long)__a3,		\
+			      (unsigned long)__a4,		\
+			      (unsigned long)__a5)
 #define XENOMAI_SYSBIND(__breq)					\
-	XENOMAI_DO_SYSCALL(1, sc_cobalt_bind, __breq)
+	__xenomai_do_syscall1(sc_cobalt_bind,			\
+			      (unsigned long)__breq)
 
 #endif /* !_LIB_COBALT_ARM64_SYSCALL_H */
-- 
2.31.1

