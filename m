From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [PATCH v2] cobalt/arch/arm: arith: Avoid r7 usage in helpers
Message-ID: <31ce2f99-afe3-577c-2cfc-329bf3730e7b@siemens.com>
Date: Mon, 9 Aug 2021 17:18:17 +0200
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

Since gcc-9, direct usage of r7 is in conflict with compiler
allocations. Skip it.

This pushes mach_arm_nodiv_llimd beyond r10. r11 is reserved as frame
pointer, but r12 should be fine between function calls and long branches
like in this case.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---

Changes in v2:
 - use r12 instead of r11

 .../arch/arm/include/asm/xenomai/uapi/arith.h      | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/kernel/cobalt/arch/arm/include/asm/xenomai/uapi/arith.h b/kernel/cobalt/arch/arm/include/asm/xenomai/uapi/arith.h
index cf897b44fa..cb7fb4aa15 100644
--- a/kernel/cobalt/arch/arm/include/asm/xenomai/uapi/arith.h
+++ b/kernel/cobalt/arch/arm/include/asm/xenomai/uapi/arith.h
@@ -79,9 +79,9 @@ mach_arm_nodiv_ullimd(const unsigned long long op,
 	register unsigned frach __asm__ ("r3");
 	register unsigned integ __asm__("r4") = rhs_integ;
 	register unsigned opl __asm__ ("r6");
-	register unsigned oph __asm__ ("r7");
-	register unsigned tl __asm__("r8");
-	register unsigned th __asm__("r9");
+	register unsigned oph __asm__ ("r8");
+	register unsigned tl __asm__("r9");
+	register unsigned th __asm__("r10");
 
 	xnarch_u64tou32(op, oph, opl);
 	xnarch_u64tou32(frac, frach, fracl);
@@ -109,10 +109,10 @@ mach_arm_nodiv_llimd(const long long op,
 	register unsigned frach __asm__ ("r3");
 	register unsigned integ __asm__("r4") = rhs_integ;
 	register unsigned opl __asm__ ("r6");
-	register unsigned oph __asm__ ("r7");
-	register unsigned tl __asm__("r8");
-	register unsigned th __asm__("r9");
-	register unsigned s __asm__("r10");
+	register unsigned oph __asm__ ("r8");
+	register unsigned tl __asm__("r9");
+	register unsigned th __asm__("r10");
+	register unsigned s __asm__("r12");
 
 	xnarch_u64tou32(op, oph, opl);
 	xnarch_u64tou32(frac, frach, fracl);
-- 
2.31.1

