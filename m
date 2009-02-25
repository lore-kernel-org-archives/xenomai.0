MIME-Version: 1.0
Date: Wed, 25 Feb 2009 15:09:20 +0000
From: =?UTF-8?Q?Gwenha=C3=ABl?= <gwen@domain.hid>
In-Reply-To: <49A54246.60404@domain.hid>
References: <d7143fa7afb9637a602a432e52eb35b4@domain.hid>
	<49A54246.60404@domain.hid>
Message-ID: <1aedae1f462bc98ca512e1e6f0f18a43@domain.hid>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Adeos-main] [PATCH] ipipe i.MXL freeze's boot
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


On Wed, 25 Feb 2009 14:06:14 +0100, Gilles Chanteperdrix=0D
<gilles.chanteperdrix@xenomai.org> wrote:=0D
> Gwenha=C3=ABl wrote:=0D
>> With i.MXL processor, kernel patched with=0D
>> adeos-2.6.27-ipipe-1.12-00.patch wait indefinitly for timer=0D
>> calibration.=0D
>> Tick event never appear. This patch modify acktimer() in=0D
>> arch/arm/mach-imx/time.c.=0D
>> =0D
>> I need to know if this modification is good (without adding=0D
>> new errors).=0D
> =0D
> ipipe_mach_update_tsc should be called from imx_timer_interrupt, so,=0D
> there is no need to call it from acktimer (and in fact, avoiding the=0D
> call to update_tsc in acktimer reduces the timer interrupt latency). So=
,=0D
> maybe what is needed and is missing is simply to read=0D
> IMX_TSTAT(TIMER_BASE) ?=0D
=0D
I've made modifications on patch thanks to your assumption. =0D
The new patch work fine.=0D
=0D
Thank you very much=0D
=0D
Gwenhael=0D
=0D
Signed-off-by: gwenhael.goavec-merou@domain.hid
=0D
=0D
diff -ru a/arch/arm/mach-imx/irq.c b/arch/arm/mach-imx/irq.c=0D
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
--- a/arch/arm/mach-imx/time.c	2009-02-25 15:10:01.000000000 +0100=0D
+++ b/arch/arm/mach-imx/time.c	2009-02-25 15:10:49.000000000 +0100=0D
@@ -89,25 +89,23 @@=0D
 imx_timer_interrupt(int irq, void *dev_id)=0D
 {=0D
 	struct clock_event_device *evt =3D &clockevent_imx;=0D
-#ifndef CONFIG_IPIPE=0D
 	uint32_t tstat;=0D
 	irqreturn_t ret =3D IRQ_NONE;=0D
 =0D
 	/* clear the interrupt */=0D
 	tstat =3D IMX_TSTAT(TIMER_BASE);=0D
+#ifndef CONFIG_IPIPE=0D
 	IMX_TSTAT(TIMER_BASE) =3D 0;=0D
+#endif=0D
 	if (tstat & TSTAT_COMP) {=0D
+#ifdef CONFIG_IPIPE=0D
 		ipipe_mach_update_tsc();=0D
+#endif=0D
 		evt->event_handler(evt);=0D
 		ret =3D IRQ_HANDLED;=0D
 	}=0D
 =0D
 	return ret;=0D
-#else /* CONFIG_IPIPE */=0D
-	ipipe_mach_update_tsc();=0D
-	evt->event_handler(evt);=0D
-	return  IRQ_HANDLED;=0D
-#endif /* CONFIG_IPIPE */=0D
 }=0D
 =0D
 static struct irqaction imx_timer_irq =3D {=0D
=0D


