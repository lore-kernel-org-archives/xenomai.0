Message-ID: <4F965F04.3060403@domain.hid>
Date: Tue, 24 Apr 2012 10:06:28 +0200
From: Michael Trimarchi <michael@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: [Adeos-main] [PATCH 1/3] Fix hwtimer_uaccess in IMX architecture
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

Fix the code for IMX architectures in order to call the software
workaround to clear the off platform peripheral modules Supervisor
Protect clear the off platform peripheral modules Supervisor Protect
bit for the SDMA to access them.

Signed-off-by: Michael Trimarchi <michael@domain.hid>
Signed-off-by: Bruno Morelli <b.morelli@domain.hid>
---
 arch/arm/plat-mxc/devices.c |   14 +++++++-------
 1 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/arm/plat-mxc/devices.c b/arch/arm/plat-mxc/devices.c
index 253b711..a2c0e66 100644
--- a/arch/arm/plat-mxc/devices.c
+++ b/arch/arm/plat-mxc/devices.c
@@ -93,19 +93,19 @@ err:
 
 static int post_cpu_init(void)
 {
-#ifdef CONFIG_MACH_MX27
+#ifdef CONFIG_ARCH_MX27
 	if (cpu_is_mx27())
 		ipipe_mach_allow_hwtimer_uaccess(MX27_IO_P2V(MX27_AIPI_BASE_ADDR), 3);
 #endif /* CONFIG_MACH_MX27 */
-#ifdef CONFIG_MACH_MX25
+#ifdef CONFIG_ARCH_MX25
 	if (cpu_is_mx25())
-		ipipe_mach_allow_hwtimer_uaccess(MX25_AIPS1_BASE_ADDR_VIRT,
-						 MX25_AIPS2_BASE_ADDR_VIRT);
+		ipipe_mach_allow_hwtimer_uaccess(MX25_IO_P2V(MX25_AIPS1_BASE_ADDR),
+						 MX25_IO_P2V(MX25_AIPS2_BASE_ADDR));
 #endif /* CONFIG_MACH_MX25 */
-#ifdef CONFIG_MACH_MX31
+#ifdef CONFIG_ARCH_MX31
 	if (cpu_is_mx31())
-		ipipe_mach_allow_hwtimer_uaccess(AIPS1_BASE_ADDR_VIRT,
-						 AIPS2_BASE_ADDR_VIRT);
+		ipipe_mach_allow_hwtimer_uaccess(MX31_IO_P2V(MX31_AIPS1_BASE_ADDR_VIRT),
+						 MX31_IO_P2V(MX31_AIPS2_BASE_ADDR_VIRT));
 #endif /* CONFIG_MACH_MX31 */
 	return 0;
 }
-- 
1.7.5.4


