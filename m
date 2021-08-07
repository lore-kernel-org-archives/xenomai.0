From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [PATCH] lib/cobalt: arm: Account for register allocation clash gcc 9+
Message-ID: <3cdc2c82-44ca-02a7-3585-e40547dcd588@siemens.com>
Date: Sat, 7 Aug 2021 17:52:26 +0200
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
To: Xenomai <xenomai@xenomai.org>

From: Jan Kiszka <jan.kiszka@siemens.com>

Modern gcc can claim r7 for own purposes, denying the syscall code to
assign it directly. Work around this by saving/restoring it around the
syscall.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 lib/cobalt/arch/arm/include/asm/xenomai/syscall.h | 13 ++++---------
 1 file changed, 4 insertions(+), 9 deletions(-)

diff --git a/lib/cobalt/arch/arm/include/asm/xenomai/syscall.h b/lib/cobalt/arch/arm/include/asm/xenomai/syscall.h
index 8f48eb16f2..0941e6c845 100644
--- a/lib/cobalt/arch/arm/include/asm/xenomai/syscall.h
+++ b/lib/cobalt/arch/arm/include/asm/xenomai/syscall.h
@@ -89,15 +89,11 @@
 #define __sys1(x)	__sys2(x)
 
 #ifdef __ARM_EABI__
-#define __SYS_REG , "r7"
-#define __SYS_REG_DECL register unsigned long __r7 __asm__ ("r7")
-#define __SYS_REG_SET __r7 = XENO_ARM_SYSCALL
-#define __SYS_REG_INPUT ,"r" (__r7)
-#define __SYS_CALLOP "swi\t0"
+#define __SYS_REG_DECL unsigned long __r7 = XENO_ARM_SYSCALL
+#define __SYS_REG_INPUT , [__r7] "r" (__r7)
+#define __SYS_CALLOP "push {r7}; mov %%r7,%[__r7]; swi\t0; pop {r7}"
 #else
-#define __SYS_REG
 #define __SYS_REG_DECL
-#define __SYS_REG_SET
 #define __SYS_REG_INPUT
 #define __NR_OABI_SYSCALL_BASE	0x900000
 #define __SYS_CALLOP "swi\t" __sys1(__NR_OABI_SYSCALL_BASE + XENO_ARM_SYSCALL) ""
@@ -109,9 +105,8 @@
 		__SYS_REG_DECL;						\
 		LOADARGS_##nr(__xn_syscode(op), args);			\
 		__asm__ __volatile__ ("" : /* */ : /* */ :		\
-				      CLOBBER_REGS_##nr __SYS_REG);	\
+				      CLOBBER_REGS_##nr);		\
 		LOADREGS_##nr;						\
-		__SYS_REG_SET;						\
 		__asm__ __volatile__ (					\
 			__SYS_CALLOP					\
 			: "=r" (__r0)					\
-- 
2.31.1

