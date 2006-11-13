From: Sebastian Smolorz <ssm@domain.hid>
Date: Mon, 13 Nov 2006 15:16:36 +0100
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_E5HWFeWGl4MTve+"
Message-Id: <E1Gjcbu-0006ZA-4a@domain.hid>
Subject: [Xenomai-core] [PATCH] Don't call __ipipe_mach_set_dec in
	rthal_timer_release directly
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai@xenomai.org

--Boundary-00=_E5HWFeWGl4MTve+
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi,

here's a proposal for a minor change in the I-pipe implementation for ARM. 
Since it is required for my S3C24xx patch not to call __ipipe_mach_set_dec 
directly when the timer is released by the Xenomai domain I suggest the 
following changes. The patch comprises the necessary modifications for PXA, 
SA1100 and Integrator, too.

Comments or objections?

--
Sebastian

--Boundary-00=_E5HWFeWGl4MTve+
Content-Type: text/x-diff; charset="us-ascii";
	name="ipipe-2.6.15-arm-1.5-02_release_timer.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="ipipe-2.6.15-arm-1.5-02_release_timer.patch"

diff -upr linux-2.6.15-ipipe.orig/arch/arm/mach-integrator/core.c linux-2.6.15-ipipe.work/arch/arm/mach-integrator/core.c
--- linux-2.6.15-ipipe.orig/arch/arm/mach-integrator/core.c	2006-11-08 16:44:02.000000000 +0100
+++ linux-2.6.15-ipipe.work/arch/arm/mach-integrator/core.c	2006-11-13 12:07:21.000000000 +0100
@@ -330,6 +330,12 @@ void __ipipe_mach_set_dec(unsigned long 
 }
 EXPORT_SYMBOL(__ipipe_mach_set_dec);
 
+void __ipipe_mach_release_timer(void)
+{
+	__ipipe_mach_set_dec(__ipipe_mach_ticks_per_jiffy);
+}
+EXPORT_SYMBOL(__ipipe_mach_release_timer);
+
 unsigned long __ipipe_mach_get_dec(void)
 {
 	return readl(TIMER1_VA_BASE + TIMER_VALUE);
diff -upr linux-2.6.15-ipipe.orig/arch/arm/mach-pxa/time.c linux-2.6.15-ipipe.work/arch/arm/mach-pxa/time.c
--- linux-2.6.15-ipipe.orig/arch/arm/mach-pxa/time.c	2006-11-08 16:44:02.000000000 +0100
+++ linux-2.6.15-ipipe.work/arch/arm/mach-pxa/time.c	2006-11-13 12:11:11.000000000 +0100
@@ -324,6 +324,12 @@ void __ipipe_mach_set_dec(unsigned long 
 }
 EXPORT_SYMBOL(__ipipe_mach_set_dec);
 
+void __ipipe_mach_release_timer(void)
+{
+	__ipipe_mach_set_dec(__ipipe_mach_ticks_per_jiffy);
+}
+EXPORT_SYMBOL(__ipipe_mach_release_timer);
+
 unsigned long __ipipe_mach_get_dec(void)
 {
 	return OSMR0 - OSCR;
diff -upr linux-2.6.15-ipipe.orig/arch/arm/mach-sa1100/time.c linux-2.6.15-ipipe.work/arch/arm/mach-sa1100/time.c
--- linux-2.6.15-ipipe.orig/arch/arm/mach-sa1100/time.c	2006-11-08 16:44:02.000000000 +0100
+++ linux-2.6.15-ipipe.work/arch/arm/mach-sa1100/time.c	2006-11-13 12:07:26.000000000 +0100
@@ -314,6 +314,12 @@ void __ipipe_mach_set_dec(unsigned long 
 }
 EXPORT_SYMBOL(__ipipe_mach_set_dec);
 
+void __ipipe_mach_release_timer(void)
+{
+	__ipipe_mach_set_dec(__ipipe_mach_ticks_per_jiffy);
+}
+EXPORT_SYMBOL(__ipipe_mach_release_timer);
+
 unsigned long __ipipe_mach_get_dec(void)
 {
 	return OSMR0 - OSCR;
diff -upr linux-2.6.15-ipipe.orig/include/asm-arm/ipipe.h linux-2.6.15-ipipe.work/include/asm-arm/ipipe.h
--- linux-2.6.15-ipipe.orig/include/asm-arm/ipipe.h	2006-11-13 11:39:03.000000000 +0100
+++ linux-2.6.15-ipipe.work/include/asm-arm/ipipe.h	2006-11-13 12:34:55.000000000 +0100
@@ -117,6 +117,7 @@ extern unsigned int __ipipe_mach_ticks_p
 extern void __ipipe_mach_acktimer(void);
 extern unsigned long long __ipipe_mach_get_tsc(void);
 extern void __ipipe_mach_set_dec(unsigned long);
+extern void __ipipe_mach_release_timer(void);
 extern unsigned long __ipipe_mach_get_dec(void);
 extern void __ipipe_mach_demux_irq(unsigned irq, struct pt_regs *regs);
 

--Boundary-00=_E5HWFeWGl4MTve+
Content-Type: text/x-diff; charset="us-ascii"; name="xeno_release_timer.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="xeno_release_timer.patch"

Index: ksrc/arch/arm/hal.c
===================================================================
--- ksrc/arch/arm/hal.c	(Revision 1834)
+++ ksrc/arch/arm/hal.c	(Arbeitskopie)
@@ -94,7 +94,7 @@
     if (rthal_periodic_p)
         rthal_reset_timer();
     else
-        __ipipe_mach_set_dec(__ipipe_mach_ticks_per_jiffy);
+        __ipipe_mach_release_timer();
 
     rthal_irq_release(RTHAL_TIMER_IRQ);
 

--Boundary-00=_E5HWFeWGl4MTve+--

