From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [PATCH][4.14] arm/ipipe: Fix IPIPE_TRAP_UNDEFINSTR reporting
Message-ID: <6be2fdec-0246-1169-67ad-882abb73cc5e@siemens.com>
Date: Fri, 30 Nov 2018 21:09:11 +0100
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
To: Philippe Gerum <rpm@xenomai.org>, Xenomai <xenomai@xenomai.org>

Something moved the value of this constant but didn't update the
hard-coded instances. Fix this and avoid future problems by using the
proper symbolic value.

That just requires harding asm/ipipe_base.h for assembly use.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 arch/arm/include/asm/ipipe_base.h | 6 ++++++
 arch/arm/kernel/entry-armv.S      | 5 +++--
 2 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/arch/arm/include/asm/ipipe_base.h b/arch/arm/include/asm/ipipe_base.h
index 34de7a0402aa..3cf11a0242a2 100644
--- a/arch/arm/include/asm/ipipe_base.h
+++ b/arch/arm/include/asm/ipipe_base.h
@@ -23,10 +23,14 @@
 #ifndef __ASM_ARM_IPIPE_BASE_H
 #define __ASM_ARM_IPIPE_BASE_H
 
+#ifndef __ASSEMBLY__
 #include <asm-generic/ipipe.h>
+#endif
 
 #ifdef CONFIG_IPIPE
 
+#ifndef __ASSEMBLY__
+
 #ifdef CONFIG_SMP
 
 extern unsigned __ipipe_first_ipi;
@@ -72,6 +76,8 @@ unsigned __ipipe_processor_id(void);
 #define ipipe_processor_id()  (0)
 #endif /* !CONFIG_IPIPE */
 
+#endif /* !__ASSEMBLY__ */
+
 #define IPIPE_TRAP_MAYDAY        0	/* Internal recovery trap */
 
 /* ARM traps */
diff --git a/arch/arm/kernel/entry-armv.S b/arch/arm/kernel/entry-armv.S
index 3569b3174372..311308e15485 100644
--- a/arch/arm/kernel/entry-armv.S
+++ b/arch/arm/kernel/entry-armv.S
@@ -35,6 +35,7 @@
 #include "entry-header.S"
 #include <asm/entry-macro-multi.S>
 #include <asm/probes.h>
+#include <asm/ipipe_base.h>
 
 /*
  * Interrupt handling.
@@ -291,7 +292,7 @@ __und_svc:
 #endif
 
 #ifdef CONFIG_IPIPE
-	mov	r0, #7				@ r0 = IPIPE_TRAP_UNDEFINSTR
+	mov	r0, #IPIPE_TRAP_UNDEFINSTR
 	mov	r1, sp				@ r1 = &regs
 	bl	__ipipe_notify_trap		@ branch to trap handler
 	cmp	r0, #0
@@ -519,7 +520,7 @@ __und_usr:
 	usr_entry uaccess=0
 
 #ifdef CONFIG_IPIPE
-	mov	r0, #7				@ r0 = IPIPE_TRAP_UNDEFINSTR
+	mov	r0, #IPIPE_TRAP_UNDEFINSTR
 	mov	r1, sp				@ r1 = &regs
 	bl	__ipipe_notify_trap		@ branch to trap handler
 	cmp	r0, #0
-- 
2.16.4

