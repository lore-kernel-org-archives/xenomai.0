From: Sebastian Smolorz <ssm@domain.hid>
Date: Thu, 19 Jul 2007 16:10:00 +0200
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_4C3nG/XII5Hbg7I"
Message-Id: <E1IBWhZ-0000YX-PC@mailer.emlix.com>
Subject: [Adeos-main] [PATCH] [arm] Set the TSC type due to configured
	architecture
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: </public/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: adeos-main@gna.org

--Boundary-00=_4C3nG/XII5Hbg7I
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi Gilles,

I plan to implement the new userspace TSC feature for decrementing timers but 
stumbled across CONFIG_XENO_ARM_HW_DIRECT_TSC set to 1 independent from the 
configured ARM architecture. See the attached patches for Adeos and Xenomai 
for a possible solution.

-- 
Sebastian

--Boundary-00=_4C3nG/XII5Hbg7I
Content-Type: text/x-diff;
  charset="us-ascii";
  name="xeno.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="xeno.patch"

Index: include/asm-arm/features.h
===================================================================
--- include/asm-arm/features.h	(Revision 2768)
+++ include/asm-arm/features.h	(Arbeitskopie)
@@ -34,7 +34,7 @@
 #define CONFIG_XENO_ARM_EABI    1
 #endif
 
-#define CONFIG_XENO_ARM_HW_DIRECT_TSC 1
+#define CONFIG_XENO_ARM_HW_DIRECT_TSC	CONFIG_IPIPE_ARM_TSC_TYPE
 
 #else /* !__KERNEL__ */
 #define __LINUX_ARM_ARCH__  CONFIG_XENO_ARM_ARCH

--Boundary-00=_4C3nG/XII5Hbg7I
Content-Type: text/x-diff;
  charset="us-ascii";
  name="ipipe.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="ipipe.patch"

diff --git a/kernel/ipipe/Kconfig b/kernel/ipipe/Kconfig
index 1f46f07..d9580c7 100644
--- a/kernel/ipipe/Kconfig
+++ b/kernel/ipipe/Kconfig
@@ -4,3 +4,9 @@ config IPIPE
 	---help---
 	  Activate this option if you want the interrupt pipeline to be
 	  compiled in.
+
+config IPIPE_ARM_TSC_TYPE
+	int
+	depends on IPIPE && ARM
+	default 1 if ARCH_PXA || ARCH_SA1100 || ARCH_IXP4XX || ARCH_AT91
+	default 0

--Boundary-00=_4C3nG/XII5Hbg7I--

