Message-ID: <4F965F56.6050608@domain.hid>
Date: Tue, 24 Apr 2012 10:07:50 +0200
From: Michael Trimarchi <michael@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: [Adeos-main] [PATCH 2/3] Fix compilation error in imx timer
	initialization
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/options/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: </public/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: Adeos <adeos-main@gna.org>
Cc: b.morelli@domain.hid

Fix compilation error in the imx timer initialization

Signed-off-by: Michael Trimarchi <michael@domain.hid>
Signed-off-by: Bruno Morelli <b.morelli@domain.hid>
---
 arch/arm/mach-imx/clock-imx25.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-imx/clock-imx25.c b/arch/arm/mach-imx/clock-imx25.c
index a65838f..bcd1279 100644
--- a/arch/arm/mach-imx/clock-imx25.c
+++ b/arch/arm/mach-imx/clock-imx25.c
@@ -328,7 +328,8 @@ int __init mx25_clocks_init(void)
 	__raw_writel(__raw_readl(CRM_BASE+0x64) | (1 << 7) | (1 << 0),
 			CRM_BASE + 0x64);
 
-	mxc_timer_init(&gpt_clk, MX25_IO_ADDRESS(MX25_GPT1_BASE_ADDR), 54);
+	mxc_timer_init(&gpt_clk, MX25_IO_ADDRESS(MX25_GPT1_BASE_ADDR),
+			MX25_GPT1_BASE_ADDR, 54);
 
 	return 0;
 }
-- 
1.7.5.4


