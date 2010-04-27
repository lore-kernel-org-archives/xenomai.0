From: Fabian Godehardt <fg@domain.hid>
Date: Tue, 27 Apr 2010 14:37:32 +0100
Message-Id: <1272375452-7626-1-git-send-email-fg@domain.hid>
Subject: [Xenomai-core] [PATCH] adeos-ipipe-2.6.30-arm-1.15-01.patch: Fix
	hang on 'Calibrating delay loop...' on S3C24xx
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai@xenomai.org

This patch should fix the hang during 'Calibrating delay loop...' on S3C24xx
based kernels. Problem is that some machines do not have an externel TCLK
signal so the timer doesn't start running.

This patch may also be of interest for the 2.6.28 and 2.6.29 patches.

Tested with a S3C2440 cpu.

Signed-off-by: Fabian Godehardt <fg@domain.hid>
---
 .../patches/adeos-ipipe-2.6.30-arm-1.15-01.patch   |   17 +++--------------
 1 files changed, 3 insertions(+), 14 deletions(-)

diff --git a/ksrc/arch/arm/patches/adeos-ipipe-2.6.30-arm-1.15-01.patch b/ksrc/arch/arm/patches/adeos-ipipe-2.6.30-arm-1.15-01.patch
index 5760e2e..2358cfb 100644
--- a/ksrc/arch/arm/patches/adeos-ipipe-2.6.30-arm-1.15-01.patch
+++ b/ksrc/arch/arm/patches/adeos-ipipe-2.6.30-arm-1.15-01.patch
@@ -6925,18 +6925,7 @@ index 3b27b29..8e6e479 100644
  		__raw_writel(tcfg1, S3C2410_TCFG1);
  	} else {
  		unsigned long pclk;
-@@ -204,12 +254,25 @@ static void s3c2410_timer_setup (void)
- 		clk_set_parent(tin, tdiv);
- 
- 		tcnt = clk_get_rate(tin) / HZ;
-+
-+		tcfg1 = __raw_readl(S3C2410_TCFG1);
-+		tcfg1 &= ~(S3C2410_TCFG1_MUX4_MASK | S3C2410_TCFG1_MUX3_MASK);
-+		tcfg1 |= (S3C2410_TCFG1_MUX4_TCLK1 | S3C2410_TCFG1_MUX3_TCLK1);
-+		__raw_writel(tcfg1, S3C2410_TCFG1);
- 	}
- 
- 	tcon = __raw_readl(S3C2410_TCON);
+@@ -210,6 +260,14 @@ static void s3c2410_timer_setup (void)
  	tcfg0 = __raw_readl(S3C2410_TCFG0);
  	tcfg1 = __raw_readl(S3C2410_TCFG1);
  
@@ -6951,7 +6940,7 @@ index 3b27b29..8e6e479 100644
  	/* timers reload after counting zero, so reduce the count by 1 */
  
  	tcnt--;
-@@ -226,23 +289,37 @@ static void s3c2410_timer_setup (void)
+@@ -226,23 +284,37 @@ static void s3c2410_timer_setup (void)
  	__raw_writel(tcfg1, S3C2410_TCFG1);
  	__raw_writel(tcfg0, S3C2410_TCFG0);
  
@@ -7000,7 +6989,7 @@ index 3b27b29..8e6e479 100644
  }
  
  static void __init s3c2410_timer_resources(void)
-@@ -283,3 +360,58 @@ struct sys_timer s3c24xx_timer = {
+@@ -283,3 +355,58 @@ struct sys_timer s3c24xx_timer = {
  	.offset		= s3c2410_gettimeoffset,
  	.resume		= s3c2410_timer_setup
  };
-- 
1.6.6.1


