From: Fabian Godehardt <fg@domain.hid>
Date: Wed, 28 Apr 2010 05:59:31 +0100
Message-Id: <1272430771-11707-1-git-send-email-fg@domain.hid>
In-Reply-To: <4BD71157.9060804@domain.hid>
References: <4BD71157.9060804@domain.hid>
Subject: [Xenomai-core] [PATCH] adeos-ipipe-2.6.30-arm-1.15-01: Fix hang on
	'Calibrating delay loop...' on S3C24xx
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: gilles.chanteperdrix@xenomai.org
Cc: xenomai@xenomai.org

This patch should fix the hang during 'Calibrating delay loop...' on S3C24xx
based kernels. Problem is that some machines do not have an externel TCLK
signal so the timer doesn't start to run.

Tested with a S3C2440 cpu.

Signed-off-by: Fabian Godehardt <fg@domain.hid>
---
 arch/arm/plat-s3c/time.c |    5 -----
 1 files changed, 0 insertions(+), 5 deletions(-)

diff --git a/arch/arm/plat-s3c/time.c b/arch/arm/plat-s3c/time.c
index 8e6e479..976fe03 100644
--- a/arch/arm/plat-s3c/time.c
+++ b/arch/arm/plat-s3c/time.c
@@ -254,11 +254,6 @@ static void s3c2410_timer_setup (void)
 		clk_set_parent(tin, tdiv);
 
 		tcnt = clk_get_rate(tin) / HZ;
-
-		tcfg1 = __raw_readl(S3C2410_TCFG1);
-		tcfg1 &= ~(S3C2410_TCFG1_MUX4_MASK | S3C2410_TCFG1_MUX3_MASK);
-		tcfg1 |= (S3C2410_TCFG1_MUX4_TCLK1 | S3C2410_TCFG1_MUX3_TCLK1);
-		__raw_writel(tcfg1, S3C2410_TCFG1);
 	}
 
 	tcon = __raw_readl(S3C2410_TCON);
-- 
1.6.6.1


