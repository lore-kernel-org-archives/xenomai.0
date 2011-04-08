Date: Fri, 8 Apr 2011 08:24:22 +0200
From: Richard Cochran <richardcochran@domain.hid>
Message-ID: <20110408062422.GA9887@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [Xenomai-core] [PATCH] ipipe arm: fix big endian tsc emulation code
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Adeos <adeos-main@gna.org>
Cc: Xenomai core <Xenomai-core@domain.hid>

This commit replaces the CONFIG_CPU_ENDIAN_BE8 macro with the
more general CONFIG_CPU_BIG_ENDIAN one. Also we fix a typo.

Signed-off-by: Richard Cochran <richard.cochran@domain.hid>
---
 arch/arm/kernel/ipipe_tsc_asm.S |   10 +++++-----
 1 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/arm/kernel/ipipe_tsc_asm.S b/arch/arm/kernel/ipipe_tsc_asm.S
index 7dfec60..ca88882 100644
--- a/arch/arm/kernel/ipipe_tsc_asm.S
+++ b/arch/arm/kernel/ipipe_tsc_asm.S
@@ -43,7 +43,7 @@ __ipipe_freerunning_32:
 	ldr	r0, .LCfr32_cntr_addr
 /* User-space entry-point: r0 is the hardware counter virtual address */
 	myldrd	r2, r3, r1, .LCfr32_last_tsc
-#ifndef CONFIG_CPU_ENDIAN_BE8
+#ifndef CONFIG_CPU_BIG_ENDIAN
 /* Little endian */
 	ldr	r0, [r0]
 	cmp	r2, r0
@@ -69,7 +69,7 @@ __ipipe_freerunning_countdown:
 	ldr	r0, .LCfrcd32_cntr_addr
 /* User-space entry-point: r0 is the hardware counter virtual address */
 	myldrd	r2, r3, r1, .LCfrcd32_last_tsc
-#ifndef CONFIG_CPU_ENDIAN_BE8
+#ifndef CONFIG_CPU_BIG_ENDIAN
 /* Little endian */
 	ldr	r0, [r0]
 	mvn	r0, r0
@@ -98,7 +98,7 @@ __ipipe_freerunning_16:
 /* User-space entry-point: r0 is the hardware counter virtual address */
 1:	myldrd	r2, r3, r1, .LCfr16_last_tsc
 	ldr	ip, [r0]
-#ifndef CONFIG_CPU_ENDIAN_BE8
+#ifndef CONFIG_CPU_BIG_ENDIAN
 /* Little endian */
 	ldr	r1, .LCfr16_last_tsc
 	cmp	r1, r2
@@ -137,7 +137,7 @@ __ipipe_freerunning_16:
 __ipipe_decrementer_16:
 	ldr	r0, .LCdec16_cntr_addr
 /* User-space entry-point: r0 is the hardware counter virtual address */
-#ifndef CONFIG_CPU_ENDIAN_BE8
+#ifndef CONFIG_CPU_BIG_ENDIAN
 /* Little endian */
 1:	ldr	r1, .LCdec16_last_tsc
 	ldr	ip, [r0]
@@ -153,7 +153,7 @@ __ipipe_decrementer_16:
 /* Little endian */
 1:	ldr	r1, .LCdec16_last_tsc + 4
 	ldr	ip, [r0]
-	ldr	r2, .Ldec16_Clast_cnt
+	ldr	r2, .LCdec16_last_cnt
 	subs 	ip, r2, ip
 	addcs	ip, ip, #0x10000
 	myldrd	r2, r3, r3, .LCdec16_last_tsc
-- 
1.7.0.4


