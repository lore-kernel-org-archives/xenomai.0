Message-ID: <446340F0.7010107@domain.hid>
Date: Thu, 11 May 2006 15:49:36 +0200
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] Xenomai on Freescale i.MX21 (ARM926J)
References: <FDBBB5CC70676540B3EF7CFE83FD94E0210DF1@domain.hid>
In-Reply-To: <FDBBB5CC70676540B3EF7CFE83FD94E0210DF1@domain.hid>
Content-Type: multipart/mixed; boundary="------------090707040709090901050404"
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: ROSSIER Daniel <Daniel.Rossier@domain.hid>
Cc: xenomai@xenomai.org

This is a multi-part message in MIME format.
--------------090707040709090901050404
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit


Hi,

I recently worked on the integration of the i.MX21 support into the 
Adeos codebase. The basic idea is to reduce the amount of 
platform-specific code in your original patch, so that changes happening 
in the generic Adeos core will be immediately available to the Freescale 
platform too. Since the core i.MX21 support is not mainline yet AFAICS, 
we will have to deal with three patches instead of one, all to be 
applied against 2.6.14 vanilla, in this order:

- The patch called patch-linux-2.6.14.imx21_1.0.0 you posted to this 
list, providing the i.MX21 core bits for the Linux kernel.
- the vanilla Adeos patch for 2.6.14 over ARM [1]
- the attached patch completing the i.MX21 support for Adeos.

What remains:
- the "idle=poll" bootparam, for using a busy loop in the idle task, 
instead of the default idle method.
- some cleanups in a few areas of the 3rd patch, which still emits 
various warnings (gcc 3.4.1). Some of them may not be that innocuous, so 
they deserves to be fixed, I think.

When time allows, I'd like you try rebuilding a complete kernel using 
the patch list above, and let me know if your i.MX21 board still runs 
with it. From that point, we should be able to refine the Adeos support 
for this platform, enough to bundle it with Xeno.

[1] 
http://download.gna.org/adeos/patches/v2.6/arm/adeos-ipipe-2.6.14-arm-1.3-02.patch


-- 

Philippe.

--------------090707040709090901050404
Content-Type: text/x-patch;
 name="ipipe-2.6.14-arm-imx21.patch"
Content-Disposition: inline;
 filename="ipipe-2.6.14-arm-imx21.patch"
Content-Transfer-Encoding: quoted-printable

--- /home/sgerber/arm-iMx/csb535/linux/linux-2.6.14_imx21/arch/arm/mach-i=
mx21/time.c	2006-04-11 10:29:12.000000000 +0200
+++ /home/sgerber/arm-iMx/xenomai/linux/linux-2.6.14_imx21_ipipe/arch/arm=
/mach-imx21/time.c	2006-04-24 15:43:06.000000000 +0200
@@ -10,7 +10,16 @@
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License version 2 as
  * published by the Free Software Foundation.
+ *
+ * April 2006 :
+ * Adapted to ARM9 i.MX21/CSB535FS board with Xenomai by S.Gerber, G.Bou=
tillier and D.Rossier
+ * University of Applied Sciences Western Switzerland
+ * Reconfigurable & Embedded Digital Systems, REDS Institute
+ *
+ * * 24.04.06 : modification of value __ipipe_mach_ticks_per_jiff
+ *              the value dependent of timer clock frequency and HZ cons=
tant
  */
+
 #include <linux/config.h>
 #include <linux/kernel.h>
 #include <linux/sched.h>
@@ -24,56 +33,165 @@
 #include <asm/irq.h>
 #include <asm/mach/time.h>
=20
+#include <asm/arch/csb535.h>
+
+static unsigned long timer_reload;
+static unsigned long timer_interval;
+static unsigned long timer_lxlost;
+static int tscok;
+
+#ifdef CONFIG_IPIPE
+int __ipipe_mach_timerint =3D INT_GPT1;
+static unsigned long long __ipipe_mach_tsc;
+static DEFINE_SPINLOCK(timer_lock);
+int __ipipe_mach_timerstolen =3D 0;
+EXPORT_SYMBOL(__ipipe_mach_timerstolen);
+/*
+ * timer_frequency =3D 17'616'076,8 Hz
+ * ticks/jiffy =3D timer_freq / Hz
+ */
+unsigned int __ipipe_mach_ticks_per_jiffy =3D CLKPERCLK1 / HZ;
+EXPORT_SYMBOL(__ipipe_mach_ticks_per_jiffy);
+#endif /* CONFIG_IPIPE */
+
 /*
- * Returns number of us since last clock interrupt.  Note that interrupt=
s
- * will have been disabled by do_gettimeoffset()
+ * Called with IRQ disabled from do_gettimeofday().
  */
-static unsigned long imx21_gettimeoffset(void)
+static inline unsigned long imx_getticksoffset(void)
 {
-	unsigned long ticks;
=20
+	if (!tscok)
+		return 0;
+=09
+	//Return the value of Timer 1
+	return IMX21_TCN(GPT1);
+=09
+}
+
+/*
+ * Reprogram the timer
+ */
+static inline void  set_dec(unsigned long reload)
+{
+
+	//Configure timer in a now state
+	IMX21_TCTL(GPT1) =3D 0 ;
+	//Load the compare value (next IRQ)
+	IMX21_TCMP(GPT1) =3D reload;
+	//Restart the timer (in free run mode (FRR))
+	IMX21_TCTL(GPT1) =3D TCTL_CLK_PCLK1 | TCTL_IRQ_COMP | TCTL_TEN | TCTL_F=
RR | TCTL_OM |TCTL_CC ;
+
+	timer_reload =3D reload;
+
+}
+
+#ifdef CONFIG_IPIPE
+void inline __ipipe_mach_acktimer(void)
+{
+=09
 	/*
-	 * Get the current number of ticks.  Note that there is a race
-	 * condition between us reading the timer and checking for
-	 * an interrupt.  We get around this by ensuring that the
-	 * counter has not reloaded between our two reads.
-	 */
+	 * TODO : Could be optimize=20
+	*/
+	if ( IMX21_TSTAT(GPT1) )
+	    IMX21_TSTAT(GPT1) =3D TSTAT_COMP;
+=09
+}
+EXPORT_SYMBOL(__ipipe_mach_acktimer);
+
+unsigned long long __ipipe_mach_get_tsc(void)
+{
+=09
+	unsigned long long result;
+	unsigned long flags;
+
+	spin_lock_irqsave_hw(&timer_lock, flags);
+	result =3D __ipipe_mach_tsc + imx_getticksoffset();
+	spin_unlock_irqrestore_hw(&timer_lock, flags);
+	return result;
+
+}
+EXPORT_SYMBOL(__ipipe_mach_get_tsc);
+
+void __ipipe_mach_set_dec(unsigned long reload)
+{
+	unsigned long ticks;
+	unsigned long flags;
+
+	spin_lock_irqsave_hw(&timer_lock, flags);
+	ticks =3D imx_getticksoffset();
+	__ipipe_mach_tsc +=3D ticks;
+	set_dec(reload);
+	timer_lxlost +=3D ticks;
+	spin_unlock_irqrestore_hw(&timer_lock, flags);
+
+}
+EXPORT_SYMBOL(__ipipe_mach_set_dec);
+
+unsigned long __ipipe_mach_get_dec(void)
+{
+	unsigned ticks;
+=09
 	ticks =3D IMX21_TCN(GPT1);
=20
-	/*
-	 * Interrupt pending?  If so, we've reloaded once already.
-	 */
-	if (IMX21_TSTAT(GPT1) & TSTAT_COMP)
-		ticks +=3D LATCH;
+	if (ticks < timer_reload) {
+		return timer_reload - ticks;
+	}
+	else {
+		return 0xffffffff + timer_reload - ticks;
+	}
+}
+EXPORT_SYMBOL(__ipipe_mach_get_dec);
+#endif /* CONFIG_IPIPE */
+
+unsigned long imx21_gettimeoffset(void)
+{
=20
 	/*
-	 * Convert the ticks to usecs
+	 * Convert ticks to usecs
 	 */
-	return (1000000 / CLK32) * ticks;
+	return ((10000 * (timer_lxlost + imx_getticksoffset())) / __ipipe_mach_=
ticks_per_jiffy);
+	=09
 }
=20
-/*
- * IRQ handler for the timer
- */
 static irqreturn_t
 imx21_timer_interrupt(int irq, void *dev_id, struct pt_regs *regs)
 {
 	write_seqlock(&xtime_lock);
=20
-	/* if any bits set, rupt has occurred, clear it by  writing a 1 */
-	if ( IMX21_TSTAT(GPT1) ) {
-	    IMX21_TSTAT(GPT1) =3D TSTAT_CAPT | TSTAT_COMP;
+	timer_lxlost =3D 0;
+
+#ifdef CONFIG_IPIPE
+	/*
+	 * If Linux is the only domain, ack the timer and reprogram it
+	 */
+	if (!__ipipe_mach_timerstolen) {
+		__ipipe_mach_tsc +=3D imx_getticksoffset();
+#else
+		if (IMX21_TSTAT(GPT1) ) {
+	    		IMX21_TSTAT(GPT1) =3D TSTAT_COMP;
+		}
+#endif
+		/*
+		 * Reprogram timer with "__ipipe_mach_ticks_per_jiffy";
+		 */
+		IMX21_TCTL(GPT1) =3D 0 ;
+		IMX21_TCMP(GPT1) =3D __ipipe_mach_ticks_per_jiffy;
+		IMX21_TCTL(GPT1) =3D TCTL_CLK_PCLK1 | TCTL_IRQ_COMP | TCTL_TEN | TCTL_=
FRR | TCTL_OM | TCTL_CC ;
+	=09
+#ifdef CONFIG_IPIPE
 	}
-=09
+#endif=09
+
 	timer_tick(regs);
 	write_sequnlock(&xtime_lock);
=20
 	return IRQ_HANDLED;
+
 }
=20
 static struct irqaction imx21_timer_irq =3D {
-	.name		=3D "i.MX21 Timer Tick",
-	.flags		=3D SA_INTERRUPT,
+	.name		=3D "i.Mx21 Timer Tick",
+	.flags		=3D SA_INTERRUPT | SA_TIMER,
 	.handler	=3D imx21_timer_interrupt
 };
=20
@@ -82,21 +200,35 @@
  */
 static void __init imx21_timer_init(void)
 {
+
 	/*
-	 * Initialise to a known state (all timers off, and timing reset)
+	 * Configure all timers in a now state
 	 */
 	IMX21_TCTL(GPT1) =3D 0;
+	IMX21_TCTL(GPT2) =3D 0;
+	IMX21_TCTL(GPT3) =3D 0;
+	/*
+	 * Configure the timer
+         */
 	IMX21_TPRER(GPT1) =3D 0;
-	IMX21_TCMP(GPT1) =3D LATCH - 1;
-	IMX21_TCTL(GPT1) =3D TCTL_CLK_32 | TCTL_IRQEN | TCTL_TEN;
=20
 	/*
 	 * Make irqs happen for the system timer
 	 */
 	setup_irq(INT_GPT1, &imx21_timer_irq);
+
+	/*
+         * Reprogram the timer and start it !
+	 */
+	set_dec(__ipipe_mach_ticks_per_jiffy);
+
+	tscok =3D 1;
+
 }
=20
 struct sys_timer imx21_timer =3D {
 	.init		=3D imx21_timer_init,
 	.offset		=3D imx21_gettimeoffset,
 };
+
+
--- /home/sgerber/arm-iMx/csb535/linux/linux-2.6.14_imx21/include/asm-arm=
/arch-imx21/csb535.h	2006-04-11 10:29:12.000000000 +0200
+++ /home/sgerber/arm-iMx/xenomai/linux/linux-2.6.14_imx21_ipipe/include/=
asm-arm/arch-imx21/csb535.h	2006-04-25 13:29:24.000000000 +0200
@@ -20,6 +20,16 @@
  * along with this program; if not, write to the Free Software
  * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307 =
 USA
  *
+ * April 2006 :
+ * Adapted to ARM9 i.MX21/CSB535FS board with Xenomai by S.Gerber, G.Bou=
tillier and D.Rossier
+ * University of Applied Sciences Western Switzerland
+ * Reconfigurable & Embedded Digital Systems, REDS Institute
+ *
+ * 24.04.06 : define the value : TICKS_PER_uSEC
+ *             adapted by S=E9bastien Gerber
+ * 25.04.06 : add a constant for the timer clock (CLKPERCLK1)
+ *             adapted by S=E9bastien Gerber
+ *=20
  */
=20
 #ifndef __ASM_ARCH_CSB535_H
@@ -34,7 +44,11 @@
=20
 #define IMX_FB_PHYS			(0x0C000000 - 0x40000)
=20
-#define CLK32 32768
+#define CLK32                            32768
+#define CLKPERCLK1                       16515072
+
+#define TICKS_PER_uSEC                    CLKPERCLK1 / 1000000
+
=20
 #define CSB535_ETH_VIRT IMX21_CS1_VIRT
 #define CSB535_ETH_PHYS IMX21_CS1_PHYS
--- /home/sgerber/arm-iMx/csb535/linux/linux-2.6.14_imx21/include/asm-arm=
/arch-imx21/imx-regs.h	2005-10-26 19:45:10.000000000 +0200
+++ /home/sgerber/arm-iMx/xenomai/linux/linux-2.6.14_imx21_ipipe/include/=
asm-arm/arch-imx21/imx-regs.h	2006-04-20 15:16:13.000000000 +0200
@@ -8,7 +8,13 @@
  * Copyright (C) 2005 TimeSys Corporation=20
  *
  * Modified by: Stephen Donecker (sdonecker@domain.hid)
- */
+ *
+ * April 2006 :
+ * Adapted to ARM9 i.MX21/CSB535FS board with Xenomai by S.Gerber, G.Bou=
tillier and D.Rossier
+ * University of Applied Sciences Western Switzerland
+ * Reconfigurable & Embedded Digital Systems, REDS Institute
+ *=20
+*/
=20
 /*
  * Memory mapped I/O for the M9328MX21ADS   =20
@@ -69,7 +75,7 @@
 #define MX2ADS_SDHC2_BASE             (0x14000 + IMX21_IO_BASE)
 #define MX2ADS_GPIO_BASE              (0x15000 + IMX21_IO_BASE)
 #define MX2ADS_AUDMUX_BASE            (0x16000 + IMX21_IO_BASE)
-#define MX2ADS_CSPI3_BASE		(IMX21_IO_BASE + 0x17000)
+#define MX2ADS_CSPI3_BASE	      (IMX21_IO_BASE + 0x17000)
 #define MX2ADS_LCDC_BASE              (0x21000 + IMX21_IO_BASE)
 #define MX2ADS_SLCDC_BASE             (0x22000 + IMX21_IO_BASE)
 #define MX2ADS_SAHARA_BASE            (0x23000 + IMX21_IO_BASE)
@@ -77,12 +83,28 @@
 #define MX2ADS_EMMA_BASE              (0x26000 + IMX21_IO_BASE)
 #define MX2ADS_CRM_BASE               (0x27000 + IMX21_IO_BASE)
 #define MX2ADS_FIRI_BASE              (0x28000 + IMX21_IO_BASE)
-#define MX2ADS_RNGA_BASE		(IMX21_IO_BASE + 0x29000)
-#define MX2ADS_RTIC_BASE		(IMX21_IO_BASE + 0x2A000)
+#define MX2ADS_RNGA_BASE	      (IMX21_IO_BASE + 0x29000)
+#define MX2ADS_RTIC_BASE	      (IMX21_IO_BASE + 0x2A000)
 #define MX2ADS_JAM_BASE               (0x3E000 + IMX21_IO_BASE)
 #define MX2ADS_MAX_BASE               (0x3F000 + IMX21_IO_BASE)
 #define MX2ADS_AITC_BASE              (0x40000 + IMX21_IO_BASE)
=20
+/*
+ * Interrupt controller
+ */
+#define AITC_NIVECSR		__REG(MX2ADS_AITC_BASE + 0x40)
+#define AITC_NIPRIORITY7	__REG(MX2ADS_AITC_BASE + 0x20)
+#define AITC_NIPRIORITY6	__REG(MX2ADS_AITC_BASE + 0x24)
+#define AITC_NIPRIORITY5	__REG(MX2ADS_AITC_BASE + 0x28)
+#define AITC_NIPRIORITY4	__REG(MX2ADS_AITC_BASE + 0x2C)
+#define AITC_NIPRIORITY3	__REG(MX2ADS_AITC_BASE + 0x30)
+#define AITC_NIPRIORITY2	__REG(MX2ADS_AITC_BASE + 0x34)
+#define AITC_NIPRIORITY1	__REG(MX2ADS_AITC_BASE + 0x38)
+#define AITC_NIPRIORITY0	__REG(MX2ADS_AITC_BASE + 0x3C)
+
+/*
+ * GPIOs
+ */
 #define GPIO_A	0
 #define GPIO_B	1
 #define GPIO_C	2
@@ -94,7 +116,6 @@
  *  GPIO Module and I/O Multiplexer
  *  x =3D 0..5 for reg_A, reg_B, reg_C, reg_D, reg_E, reg_F
  */
-
 #define DDIR(x)    __REG2(MX2ADS_GPIO_BASE + 0x00, ((x) & 7) << 8)
 #define OCR1(x)    __REG2(MX2ADS_GPIO_BASE + 0x04, ((x) & 7) << 8)
 #define OCR2(x)    __REG2(MX2ADS_GPIO_BASE + 0x08, ((x) & 7) << 8)
@@ -313,16 +334,16 @@
 #define CRM_PCDR1	__REG(MX2ADS_CRM_BASE + 0x1c)
 #define PCDR1_PERDIV4_POS	24
 #define PCDR1_PERDIV4_MASK	(0x3f << PCDR1_PERDIV4_POS)
-#define PCDR1_PERDIV4(x)	(((x) << PCDR1_PERDIV4_POS) & PCDR1_PERDIV4_MAS=
K)
+#define PCDR1_PERDIV4(x)	(((x) & 0x3f) << 24)
 #define PCDR1_PERDIV3_POS	16
 #define PCDR1_PERDIV3_MASK	(0x3f << PCDR1_PERDIV3_POS)
-#define PCDR1_PERDIV3(x) 	(((x) << PCDR1_PERDIV3_POS) & PCDR1_PERDIV3_MA=
SK)
+#define PCDR1_PERDIV3(x) 	(((x) & 0x3f) << 16)
 #define PCDR1_PERDIV2_POS	8
 #define PCDR1_PERDIV2_MASK	(0x3f << PCDR1_PERDIV2_POS)
-#define PCDR1_PERDIV2(x) 	(((x) << PCDR1_PERDIV2_POS) & PCDR1_PERDIV2_MA=
SK)
+#define PCDR1_PERDIV2(x) 	(((x) & 0x3f) << 8)
 #define PCDR1_PERDIV1_POS	0
 #define PCDR1_PERDIV1_MASK	(0x3f << PCDR1_PERDIV1_POS)
-#define PCDR1_PERDIV1(x) 	(((x) << PCDR1_PERDIV1_POS) & PCDR1_PERDIV1_MA=
SK)
+#define PCDR1_PERDIV1(x) 	(((x) & 0x3f) << 0)
=20
 #define CRM_PCCR0	__REG(MX2ADS_CRM_BASE + 0x20)=20
 #define PCCR0_HCLK_CSI_EN 	(1<<31)
@@ -555,14 +576,20 @@
 #define TCTL_CAP_RIS       (1<<6)
 #define TCTL_CAP_FAL       (2<<6)
 #define TCTL_CAP_RIS_FAL   (3<<6)
-#define TCTL_OM            (1<<5)
-#define TCTL_IRQEN         (1<<4)
 #define TCTL_CLK_PCLK1     (1<<1)
 #define TCTL_CLK_PCLK1_16  (2<<1)
 #define TCTL_CLK_TIN       (3<<1)
 #define TCTL_CLK_32        (4<<1)
 #define TCTL_TEN           (1<<0)
=20
+/*
+ * Update with Xenomai patch for iMx21 plateform
+ */
+#define TCTL_OM		   (1<<9)
+#define TCTL_CC            (1<<10)
+#define TCTL_IRQ_COMP	   (1<<4)
+#define TCTL_IRQ_CAPT	   (1<<5)
+
 #define IMX21_TPRER(x)       __REG( 0x04 + MX2ADS_GPT1_BASE + WHICH_TIME=
R(x))
 #define IMX21_TCMP(x)        __REG( 0x08 + MX2ADS_GPT1_BASE + WHICH_TIME=
R(x))
 #define IMX21_TCR(x)         __REG( 0x0C + MX2ADS_GPT1_BASE + WHICH_TIME=
R(x))

--------------090707040709090901050404--

