From: Jouko Haapaluoma <jouko.haapaluoma@wapice.com>
Subject: [PATCH 1/9] mach-at91: Add IPIPE_ARM_KUSER_TSC for SAMA5D3
Date: Fri, 12 Jun 2020 11:44:32 +0000
Message-ID: <HE1PR03MB31157E597F87E7B88756C79FE5810@HE1PR03MB3115.eurprd03.prod.outlook.com>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "xenomai@xenomai.org" <xenomai@xenomai.org>

From: Tuomo Jauhiainen <tuomo.jauhiainen@wapice.com>

Add ipipe build support for SAMA5D3 SoC

Signed-off-by: Jouko Haapaluoma <jouko.haapaluoma@wapice.com>
---
 arch/arm/mach-at91/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-at91/Kconfig b/arch/arm/mach-at91/Kconfig
index 903f23c..bd11a69 100644
--- a/arch/arm/mach-at91/Kconfig
+++ b/arch/arm/mach-at91/Kconfig
@@ -41,6 +41,7 @@ config SOC_SAMA5D3
 	select HAVE_AT91_SMD
 	select HAVE_AT91_USB_CLK
 	select PINCTRL_AT91
+	select IPIPE_ARM_KUSER_TSC if IPIPE
 	help
 	  Select this if you are using one of Microchip's SAMA5D3 family SoC.
 	  This support covers SAMA5D31, SAMA5D33, SAMA5D34, SAMA5D35, SAMA5D36.
--=20
2.2.2

