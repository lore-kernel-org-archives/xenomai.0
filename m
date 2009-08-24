Message-ID: <4A925F27.4070104@domain.hid>
Date: Mon, 24 Aug 2009 11:36:39 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <EB48F2CADC239E44A8598CC0B0571102E4A9BE@XVS-DCFR-21.europe.corp.altran.com>
	<4A8C23BE.8050904@domain.hid>
	<EB48F2CADC239E44A8598CC0B0571102E4A9C2@domain.hid>
	<4A8E628C.8010001@domain.hid>
	<EB48F2CADC239E44A8598CC0B0571102E4A9C4@domain.hid>
	<4A8F1E70.6090608@domain.hid>
	<EB48F2CADC239E44A8598CC0B0571102E4A9C6@domain.hid>
In-Reply-To: <EB48F2CADC239E44A8598CC0B0571102E4A9C6@domain.hid>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai-help] RE :  Native message queue and synchronisation
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: =?ISO-8859-1?Q?Berruer_S=E9bastien?= <sebastien.berruer@domain.hid>
Cc: xenomai@xenomai.org

Berruer S=E9bastien wrote:
> Hi,
>=20
> Sorry for the delay, I've issued a problem using the serial line.
>=20
> As I can see in the Oops trace, the problem is due to my compiler. I'll
> checked my compilation parameters or a newer version of my compiler.

No. The problem is due to the FPU handling. Coud you try and apply the
patch below to Xenomai sources?

Once you have done that, recompile the kernel and user-space, and be
sure, when you compile Xenomai user-space applications to compile them
not to use the FPU, by passing -msoft-float in the CFLAGS.

Please keep us informed.

> I can also see that there is a problem with the CPU_FREQ option. It's
> mentioned as a "latency killer" in the TROUBLESHOOTING document. I'll
> checked it too.

Yes, you should disable CPU_FREQ.

--=20
                                          Gilles

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
 #if LINUX_VERSION_CODE < KERNEL_VERSION(2, 6, 18) &&
defined(CONFIG_IWMMXT)
     bl      iwmmxt_task_switch
 #endif
@@ -137,13 +140,16 @@ ENTRY(rthal_thread_switch)
     ldmib   r4, {r4, r5}
     mar     acc0, r4, r5
 #endif
+#endif
     add            r4, r2, #TI_CPU_SAVE
+#if 0
 #if LINUX_VERSION_CODE >=3D KERNEL_VERSION(2, 6, 18) &&
defined(CONFIG_IWMMXT)
     mov            r5, r0
     mov     r0, r2
     bl     iwmmxt_task_switch
     mov            r0, r5
-#endif
+#endif
+#endif
     ldmia   r4, {r4 - sl, fp, sp, pc}       @ Load all regs saved
previously

 /*

