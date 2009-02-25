MIME-Version: 1.0
Date: Wed, 25 Feb 2009 11:05:06 +0000
From: =?UTF-8?Q?Gwenha=C3=ABl?= <gwen@domain.hid>
Message-ID: <d7143fa7afb9637a602a432e52eb35b4@domain.hid>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: [Adeos-main] [PATCH] ipipe i.MXL freeze's boot
Reply-To: adeos-main@gna.org
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: </public/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: adeos-main@gna.org


With i.MXL processor, kernel patched with=0D
adeos-2.6.27-ipipe-1.12-00.patch wait indefinitly for timer=0D
calibration.=0D
Tick event never appear. This patch modify acktimer() in=0D
arch/arm/mach-imx/time.c.=0D
=0D
I need to know if this modification is good (without adding=0D
new errors).=0D
=0D
Thank you very much=0D
=0D
Gwenhael=0D
=0D
Signed-off-by: gwenhael.goavec-merou@domain.hid
=0D
=0D
---- diff -ru a/arch/arm/mach-imx/irq.c b/arch/arm/mach-imx/irq.c=0D
--- a/arch/arm/mach-imx/irq.c    2009-02-17 11:32:52.000000000 +0100=0D
+++ b/arch/arm/mach-imx/irq.c       2009-02-23 14:12:43.000000000 +0100=0D
@@ -35,7 +35,7 @@=0D
 #include <asm/io.h>=0D
 =0D
 #include <asm/mach/irq.h>=0D
-#include <asm/arch/imx-regs.h>=0D
+#include <mach/imx-regs.h>=0D
 =0D
 =0D
 /* Used for IMX INTERRUPT priority: Still Experimental */ =0D
diff -ru a/arch/arm/mach-imx/time.c b/arch/arm/mach-imx/time.c=0D
--- a/arch/arm/mach-imx/time.c  2009-02-24 15:26:42.000000000 +0100=0D
+++ b/arch/arm/mach-imx/time.c      2009-02-24 15:24:45.000000000 +0100=0D
@@ -294,7 +294,12 @@=0D
 #ifdef CONFIG_IPIPE=0D
 void __ipipe_mach_acktimer(void)=0D
 {  =0D
+  uint32_t tstat;=0D
+  tstat =3D IMX_TSTAT(TIMER_BASE);=0D
   IMX_TSTAT(TIMER_BASE) =3D 0;=0D
+  if (likely(tstat & TSTAT_COMP)) {=0D
+    ipipe_mach_update_tsc(void);=0D
+  }=0D
 }=0D
 =0D
 static void ipipe_mach_update_tsc(void)

