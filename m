Message-ID: <437F6273.1050601@domain.hid>
Date: Sat, 19 Nov 2005 18:35:47 +0100
From: Wolfgang Grandegger <wg@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] v2.1 status
References: <437CB8BA.8040902@domain.hid>
In-Reply-To: <437CB8BA.8040902@domain.hid>
Content-Type: multipart/mixed; boundary="------------010306030607060207010000"
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Philippe Gerum <rpm@xenomai.org>
Cc: xenomai@xenomai.org

This is a multi-part message in MIME format.
--------------010306030607060207010000
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Philippe Gerum wrote:
> 
> Here is an update regarding the way things progress on the v2.1 branch:
> 
> o The build system has been deeply revamped, so that we now fully leave 
> the burden of building Xenomai's kernel support to Linux. To this end, 
> the code tree has been reorganized in two major sections, the first one 
> contains the kernel-related sources (ksrc/), the other is hosting the 
> user-space support (src/). Since the user-space portion does not need to 
> know about the kernel sources anymore, several issues have been solved 
> in the same move. All in all, things are way simpler than before, which 
> seems to indicate that we are heading to the right direction. The 
> documentation for the installation process needs to be updated though.

I like it a lot.

> o Also as a matter of build system (and a bit more), v2.1 has been 
> backported to Linux 2.4, starting with the ppc32 support. We rely on 
> Denx's 2_4-devel tree as our 2.4 kernel of reference for this port [1]. 
> A second backport to 2.4/x86 will happen when this combo is I-pipe 
> ready. We are ahead of schedule regarding this backport, since it was 
> initially planned for Q12006, but since we are going to add more 
> supported architectures in the next months, it's better to have a stable 
> build system for that.

Just tested Xenomai with adeos-ipipe-2.4.25-ppc-denx-0.9-02.patch on a 
recent DENX kernel tree. MPC 8xx support was missing. I have attached
the patch to fix it. Furthermore I have not found the "Machine" options 
(here from 2.6):

  #
  # Machine
  #
  # CONFIG_XENO_HW_FPU is not set
  CONFIG_XENO_HW_PERIODIC_TIMER=y
  CONFIG_XENO_HW_TIMER_LATENCY=1
  CONFIG_XENO_HW_SCHED_LATENCY=1
 

The latency figures on my TQM860L board with Xenomai 2.1 and Liunx 2.4 
are close to the one I measured with Xenomail 2.0 with Linux 2.6:

LATENCY with load on TQM860L:

Linux   |-----lat min|-----lat avg|-----latmax|-overrun|---test-time
2.6.13  |       60480|      120960|     224320|       0|    00:09:46
2.4.25  |       64080|       95120|     225040|       0|    00:10:00


> o PowerPC-wise (again), we should be close to ready for 2.6.15, since 
> Heikki merged both the 32 and 64-bit trees in a single one.
> 
> All other tasks planned are undergoing. For my part, I'm going to fiddle 
> now with ADI's Blackfin for which we already have the required Adeos 
> support, and create the Xenomai port for it. Since this one is uClinux 
> based, we should be able to check that the new build system is ok to 
> host any kind of port sanely.
> 
> [1] http://www.denx.de/en/Software/CVS/

Thanks.

Have a nice weekend.

Wolfgang.



--------------010306030607060207010000
Content-Type: text/x-patch; name="adeos-ipipe-2.4.25-ppc-denx-0.9-02-8xx.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
	filename="adeos-ipipe-2.4.25-ppc-denx-0.9-02-8xx.patch"

+ diff -u linuxppc_2_4_devel-2005-11-19_1437-ipipe/arch/ppc/kernel/head_8xx.S.IPIPE2 linuxppc_2_4_devel-2005-11-19_1437-ipipe/arch/ppc/kernel/head_8xx.S
--- linuxppc_2_4_devel-2005-11-19_1437-ipipe/arch/ppc/kernel/head_8xx.S.IPIPE2	2005-02-13 21:04:14.000000000 +0100
+++ linuxppc_2_4_devel-2005-11-19_1437-ipipe/arch/ppc/kernel/head_8xx.S	2005-11-19 14:51:27.000000000 +0100
@@ -231,7 +231,11 @@
 	bl	transfer_to_handler
 	.globl	do_IRQ_intercept
 do_IRQ_intercept:
-	.long	do_IRQ;
+#ifdef CONFIG_IPIPE
+	.long   __ipipe_grab_irq
+#else /* !CONFIG_IPIPE */
+	.long	do_IRQ
+#endif /* CONFIG_IPIPE */
 	.long	ret_from_intercept
 
 /* Alignment exception */
@@ -268,7 +272,11 @@
 	bl	transfer_to_handler
 	.globl	timer_interrupt_intercept
 timer_interrupt_intercept:
-	.long	timer_interrupt
+#ifdef CONFIG_IPIPE
+	.long   __ipipe_grab_timer
+#else /* !CONFIG_IPIPE */
+	.long   timer_interrupt
+#endif /* CONFIG_IPIPE */
 	.long	ret_from_intercept
 
 	STD_EXCEPTION(0xa00, Trap_0a, UnknownException)

--------------010306030607060207010000--

