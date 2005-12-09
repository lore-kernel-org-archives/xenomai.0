Message-ID: <4399C027.5030501@domain.hid>
Date: Fri, 09 Dec 2005 19:34:31 +0200
From: Heikki Lindholm <holindho@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------010402060300030301050707"
Subject: [Xenomai-core] [PATCH] Clean-up powerpc SMP timer support
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

This is a multi-part message in MIME format.
--------------010402060300030301050707
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Follow-up for the previously posted powerpc SMP timer support code.

It's better to let each processor set its own disarm_decr. Additionally, 
cuts down unused code from UP build. Tested on a G5 SMP & UP.

-- Heikki Lindholm

--------------010402060300030301050707
Content-Type: text/plain; x-mac-type="0"; x-mac-creator="0";
	name="xenomai-powerpc-smp-timers-051209.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline; filename="xenomai-powerpc-smp-timers-051209.patch"

diff -Nru xenomai.orig/ksrc/arch/powerpc/hal.c xenomai/ksrc/arch/powerpc/hal.c
--- xenomai.orig/ksrc/arch/powerpc/hal.c	2005-12-07 19:22:11.000000000 +0200
+++ xenomai/ksrc/arch/powerpc/hal.c	2005-12-09 16:19:11.110664000 +0200
@@ -131,6 +131,7 @@
 }
 
 static void rthal_critical_sync(void) {
+#ifdef CONFIG_SMP
 	rthal_declare_cpuid;
 	
 	rthal_load_cpuid();
@@ -139,20 +140,24 @@
 			/* timer_request */
 			if (rthal_periodic_p[cpuid]) 
 				rthal_set_local_cpu_timer();
-			
+			else
+				disarm_decr[cpuid] = 1;
 			break;
 		case 2:
 			/* timer_release */
 			if (rthal_periodic_p[cpuid])
 				rthal_set_local_cpu_timer();
 			else
+				disarm_decr[cpuid] = 0;
 				set_dec(tb_ticks_per_jiffy);
 			
 			break;
 		case 3:
 			/* cancel action */
+			disarm_decr[cpuid] = 0;
 			break;
 	}
+#endif /* CONFIG_SMP */
 }
 
 static void rthal_smp_relay_tick(unsigned irq, void *cookie)
@@ -183,7 +188,6 @@
 	else {
 		/* Oneshot setup. */
 		for_each_present_cpu(i) {
-			disarm_decr[i] = 1;
 			rthal_periodic_p[i] = 0;
 		}
 #ifdef CONFIG_40x
@@ -191,10 +195,10 @@
 #endif /* CONFIG_40x */
 		rthal_timer_program_shot(tb_ticks_per_jiffy);
 	}
+	rthal_load_cpuid();
+
 	if (err) 
 		goto out;
-	
-	rthal_load_cpuid();
 
 	rthal_irq_release(RTHAL_TIMER_IRQ);
 	if ((err = rthal_irq_request(RTHAL_TIMER_IRQ,
@@ -225,14 +229,14 @@
 	
 	if (rthal_periodic_p[cpuid])
 		rthal_set_local_cpu_timer();
+	else
+		disarm_decr[cpuid] = 1;
 	
 out:
 	if (err) {
 		rthal_sync_op = 3;
 		__ipipe_decr_ticks = tb_ticks_per_jiffy;
-		for_each_present_cpu(i) {
-			disarm_decr[i] = 0;
-		}
+		disarm_decr[cpuid] = 0;
 	}
 	rthal_critical_exit(flags);
 	
@@ -253,10 +257,6 @@
 	if (rthal_periodic_p[cpuid])
 		rthal_set_cpu_timers_unsafe(0);
 	else {
-		int i;
-		for_each_present_cpu(i) {
-			disarm_decr[i] = 0;
-		}
 #ifdef CONFIG_40x
 		mtspr(SPRN_TCR,mfspr(SPRN_TCR)|TCR_ARE); /* Auto-reload on. */
 		mtspr(SPRN_PIT,tb_ticks_per_jiffy);
@@ -273,6 +273,8 @@
 
 	if (rthal_periodic_p[cpuid])
 		rthal_set_local_cpu_timer();
+	else
+		disarm_decr[cpuid] = 0;
     
 	rthal_critical_exit(flags);
 }

--------------010402060300030301050707--

