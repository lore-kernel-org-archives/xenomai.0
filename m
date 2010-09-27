From: Mike Frysinger <vapier@domain.hid>
Date: Mon, 27 Sep 2010 18:09:03 -0400
Message-Id: <1285625343-3796-1-git-send-email-vapier@domain.hid>
Subject: [Xenomai-core] [PATCH] blackfin: clean up syscall assembly
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai@xenomai.org
Cc: uclinux-dist-devel@domain.hid

The Blackfin assembly for making syscalls is inefficient, so rewrite it
to use the asm constraints that gcc provides to load values into specific
registers.  The generated assembly now looks much nicer, and the header
no longer duplicates the same syscall assembly multiple times.

Signed-off-by: Mike Frysinger <vapier@domain.hid>
---
note: ive looked at the generated assembly outside of xenomai with this
	preprocessor logic, but ive never actually compiled/used xenomai
	before, so someone might want to smoke test it more than i have ...

 include/asm-blackfin/syscall.h |  129 +++++-----------------------------------
 1 files changed, 16 insertions(+), 113 deletions(-)

diff --git a/include/asm-blackfin/syscall.h b/include/asm-blackfin/syscall.h
index 9420dc8..8f8a7a2 100644
--- a/include/asm-blackfin/syscall.h
+++ b/include/asm-blackfin/syscall.h
@@ -90,125 +90,28 @@ static inline int __xn_interrupted_p(struct pt_regs *regs)
  * services in kernel space.
  */
 
-#define __emit_syscall0(muxcode, sigp)					\
+#define __emit_syscall0(muxcode, sigp, ...)				\
 ({									\
 	long __res;							\
 	__asm__ __volatile__ (						\
-		"r5=%2;\n\t"						\
-		"p0=%1;\n\t"						\
 		"excpt 0;\n\t"						\
-		"%0=r0;\n\t"						\
-		: "=da" (__res)						\
-		: "d" (muxcode),					\
-		  "a" ((long)(sigp))					\
-		: "CC","R5","P0","memory");				\
-	__res;								\
-})
-
-#define __emit_syscall1(muxcode, sigp, a1)				\
-({									\
-	long __res;							\
-	__asm__ __volatile__ (						\
-		"r5=%3;\n\t"						\
-		"r0=%2;\n\t"						\
-		"p0=%1;\n\t"						\
-		"excpt 0;\n\t"						\
-		"%0=r0;\n\t"						\
-		: "=da" (__res)						\
-		: "d" (muxcode),					\
-		  "a" ((long)(a1)),					\
-		  "a" ((long)(sigp))					\
-		: "CC","R0","R5","P0","memory");			\
-	__res;								\
-})
-
-#define __emit_syscall2(muxcode, sigp, a1, a2)				\
-({									\
-	long __res;							\
-	__asm__ __volatile__ (						\
-		"r5=%4;\n\t"						\
-		"r1=%3;\n\t"						\
-		"r0=%2;\n\t"						\
-		"p0=%1;\n\t"						\
-		"excpt 0;\n\t"						\
-		"%0=r0;\n\t"						\
-		: "=da" (__res)						\
-		: "d" (muxcode),					\
-		  "a" ((long)(a1)),					\
-		  "a" ((long)(a2)),					\
-		  "a" ((long)(sigp))					\
-		: "CC","R0","R1","R5","P0","memory");			\
-	__res;								\
-})
-
-#define __emit_syscall3(muxcode, sigp, a1, a2, a3)			\
-({									\
-	long __res;							\
-	__asm__ __volatile__ (						\
-		"r5=%5;\n\t"						\
-		"r2=%4;\n\t"						\
-		"r1=%3;\n\t"						\
-		"r0=%2;\n\t"						\
-		"p0=%1;\n\t"						\
-		"excpt 0;\n\t"						\
-		"%0=r0;\n\t"						\
-		: "=da" (__res)						\
-		: "d"   (muxcode),					\
-		  "a"   ((long)(a1)),					\
-		  "a"   ((long)(a2)),					\
-		  "a"   ((long)(a3)),					\
-		  "a"   ((long)(sigp))					\
-		: "CC","R0","R1","R2","R5","P0","memory");		\
-	__res;								\
-})
-
-#define __emit_syscall4(muxcode, sigp, a1, a2, a3, a4)			\
-({									\
-	long __res;							\
-	__asm__ __volatile__ (						\
-		"r5=%6;\n\t"						\
-		"r3=%5;\n\t"						\
-		"r2=%4;\n\t"						\
-		"r1=%3;\n\t"						\
-		"r0=%2;\n\t"						\
-		"p0=%1;\n\t"						\
-		"excpt 0;\n\t"						\
-		"%0=r0;\n\t"						\
-		: "=da" (__res)						\
-		: "d"  (muxcode),					\
-		  "a"  ((long)(a1)),					\
-		  "a"  ((long)(a2)),					\
-		  "a"  ((long)(a3)),					\
-		  "a"  ((long)(a4)),					\
-		  "a"  ((long)(sigp))					\
-		: "CC","R0","R1","R2","R3","R5","P0","memory");		\
-	__res;								\
-})
-
-#define __emit_syscall5(muxcode, sigp, a1, a2, a3, a4, a5)		\
-({									\
-	long __res;							\
-	__asm__ __volatile__ (						\
-		"r5=%7;\n\t"						\
-		"r4=%6;\n\t"						\
-		"r3=%5;\n\t"						\
-		"r2=%4;\n\t"						\
-		"r1=%3;\n\t"						\
-		"r0=%2;\n\t"						\
-		"p0=%1;\n\t"						\
-		"excpt 0;\n\t"						\
-		"%0=r0;\n\t"						\
-		: "=da" (__res)						\
-		: "d"  (muxcode),					\
-		  "rm"  ((long)(a1)),					\
-		  "rm"  ((long)(a2)),					\
-		  "rm"  ((long)(a3)),					\
-		  "rm"  ((long)(a4)),					\
-		  "rm"  ((long)(a5)),					\
-		  "rm"  ((long)(sigp))					\
-		: "CC","R0","R1","R2","R3","R4","R5","P0","memory");	\
+		: "=q0" (__res)						\
+		: "qA"  (muxcode),					\
+		  "q5"  ((long)(sigp)),					\
+		  ##__VA_ARGS__						\
+		: "CC", "memory");					\
 	__res;								\
 })
+#define __emit_syscall1(muxcode, sigp, a1, ...)				\
+	__emit_syscall0(muxcode, sigp, "q0"(a1), ##__VA_ARGS__)
+#define __emit_syscall2(muxcode, sigp, a1, a2, ...)			\
+	__emit_syscall1(muxcode, sigp, a1, "q1"(a2), ##__VA_ARGS__)
+#define __emit_syscall3(muxcode, sigp, a1, a2, a3, ...)			\
+	__emit_syscall2(muxcode, sigp, a1, a2, "q2"(a3), ##__VA_ARGS__)
+#define __emit_syscall4(muxcode, sigp, a1, a2, a3, a4, ...)		\
+	__emit_syscall3(muxcode, sigp, a1, a2, a3, "q3"(a4), ##__VA_ARGS__)
+#define __emit_syscall5(muxcode, sigp, a1, a2, a3, a4, a5, ...)		\
+	__emit_syscall4(muxcode, sigp, a1, a2, a3, a4, "q4"(a5), ##__VA_ARGS__)
 
 #define XENOMAI_DO_SYSCALL_INNER(nr, shifted_id, op, args...)		\
     __emit_syscall##nr(__xn_mux_code(shifted_id,op), ##args)
-- 
1.7.2.3


