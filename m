Message-ID: <4A982D08.4050802@domain.hid>
Date: Fri, 28 Aug 2009 21:16:24 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <7a15153d0908281050l56343b26g45a8f66b87c839e9@domain.hid>	<4A981B54.4020908@domain.hid>
	<4A981C1E.8000904@domain.hid>
	<7a15153d0908281209i5b133c53l4fa816993df7d0eb@domain.hid>
In-Reply-To: <7a15153d0908281209i5b133c53l4fa816993df7d0eb@domain.hid>
Content-Type: multipart/mixed; boundary="------------080403040703090401000200"
Subject: Re: [Xenomai-core] [PXA + Xenomai] Latency program
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Felipe Castro <felipecpc1@domain.hid>
Cc: xenomai@xenomai.org

This is a multi-part message in MIME format.
--------------080403040703090401000200
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Felipe Castro wrote:
> Well , i found the topic, but I'm using kernel 2.6.27 with xenomai 2.4.8 and
> the code to be patched is a little bit different. I dont't know how to do ,
> can you help me ?

The code has not changed, but I think my patch was mangled, please try
the attached one.


-- 
					    Gilles.

--------------080403040703090401000200
Content-Type: text/x-diff;
 name="pxa-disable-fpu.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="pxa-disable-fpu.diff"

diff --git a/ksrc/arch/arm/switch.S b/ksrc/arch/arm/switch.S
index a7c3dba..384f2cd 100644
--- a/ksrc/arch/arm/switch.S
+++ b/ksrc/arch/arm/switch.S
@@ -102,10 +102,12 @@ ENTRY(rthal_thread_switch)
     strex   r5, r4, [ip]                    @ Clear exclusive monitor
 #endif
 #endif
+#if 0	
 #if defined(CONFIG_CPU_XSCALE) && !defined(CONFIG_IWMMXT)
     mra     r4, r5, acc0
     stmia   ip, {r4, r5}
 #endif
+#endif
 #if defined(CONFIG_HAS_TLS_REG)
     mcr     p15, 0, r3, c13, c0, 3          @ set TLS register
 #elif !defined(CONFIG_TLS_REG_EMUL)
@@ -129,6 +131,7 @@ ENTRY(rthal_thread_switch)
 #endif
     VFPFMXR FPEXC, r4
 #endif
+#if 0
 #if LINUX_VERSION_CODE < KERNEL_VERSION(2, 6, 18) &&  defined(CONFIG_IWMMXT)
     bl      iwmmxt_task_switch
 #endif
@@ -137,13 +140,16 @@ ENTRY(rthal_thread_switch)
     ldmib   r4, {r4, r5}
     mar     acc0, r4, r5
 #endif
+#endif
     add	    r4, r2, #TI_CPU_SAVE
+#if 0	
 #if LINUX_VERSION_CODE >= KERNEL_VERSION(2, 6, 18) && defined(CONFIG_IWMMXT)
     mov	    r5, r0
     mov     r0, r2
     bl	    iwmmxt_task_switch
     mov	    r0, r5
-#endif	
+#endif
+#endif
     ldmia   r4, {r4 - sl, fp, sp, pc}       @ Load all regs saved previously
 
 /*

--------------080403040703090401000200--

