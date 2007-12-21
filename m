Message-ID: <476BB5EC.2060705@domain.hid>
Date: Fri, 21 Dec 2007 13:47:40 +0100
From: Wolfgang Grandegger <wg@domain.hid>
MIME-Version: 1.0
References: <f8f856500712180507q16d5c21bp56b45ec23ae5d36@domain.hid>	
	<476A1B97.6060602@domain.hid>
	<f8f856500712200624y173b053el9b3523127e27d5b6@domain.hid>
In-Reply-To: <f8f856500712200624y173b053el9b3523127e27d5b6@domain.hid>
Content-Type: multipart/mixed; boundary="------------000003050504000202090308"
Subject: Re: [Xenomai-help] Kernel hangs in initramfs with ipipe activated
 (arch=ppc)
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: fabien <fabien.fb@domain.hid>
Cc: xenomai@xenomai.org

This is a multi-part message in MIME format.
--------------000003050504000202090308
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

fabien wrote:
> 2007/12/20, Wolfgang Grandegger <wg@domain.hid>:
>> Hello,
>>
>> fabien wrote:
>>> hello,
>>>
>>> I'm new to this list and Xenomai. I've ported a Linux 2.6 kernel on a
>>> custom board based on MPC855T (PQ1). I'm able to boot my kernel
>>> 2.6.23-6 (DENX) compiled with eldk 4.1 (uClibC) and run userspace
>>> applications on flash filesystem without problems (Busybox). The
>>> booloader is ppcboot 1.1.5. My uart is on SMC1.
>> The old arch/ppc tree is deprecated and the removal is scheduled for
>> middle of the next year. Any chance to move to "arch/powerpc"?
> 
> I know the arch is deprecated, but i began to work with this arch and
> now i've no more time to move to powerpc arch. Futhermore my
> bootloader is old (ppcboot 1.1.5) and there is no OF support in it :(.
> I just want to do some latency tests with the psos api of Xenomai.
> 
>>> The prepare kernel script patchs correcly the kernel with
>>> adeos-ipipe-2.6.23-ppc-1.6-00.patch. I'm based on arch=ppc :
>>> scripts/prepare-kernel.sh
>>> --linux=/opt/eldk/ppc_8xx/usr/src/linux-2.6-denx/
>>> --adeos=ksrc/arch/powerpc/patches/adeos-ipipe-2.6.23-ppc-1.6-00.patch
>>> --arch=ppc
>>>
>>> When i try to boot with Xenomai support my kernel hangs.
>> Support for MPC8xx boards in Linux 2.6 is still poor and rather
>> experimental and you are likely the first one trying Xenomai with it. We
>> still do not have a MPC8xx platform for testing under 2.6.
> 
> Oh, so I think it won't be easy ... I'm not really an expert with
> realtime, virtualisation ... and
> my internship will finished in one month ... Aie
> So I wish get a little bit support here

Does the attached patch help?

Wolfgang.

--------------000003050504000202090308
Content-Type: text/x-patch;
 name="ipipe-ppc-cpm-irq-fix.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="ipipe-ppc-cpm-irq-fix.patch"

+ diff -u linux-2.6-denx/arch/ppc/8xx_io/commproc.c.IPIPE linux-2.6-denx/arch/ppc/8xx_io/commproc.c
--- linux-2.6-denx/arch/ppc/8xx_io/commproc.c.IPIPE	2007-12-10 19:31:24.000000000 +0100
+++ linux-2.6-denx/arch/ppc/8xx_io/commproc.c	2007-12-20 21:38:29.000000000 +0100
@@ -119,6 +119,11 @@
 	.disable	= cpm_mask_irq,
 	.ack		= cpm_ack,
 	.end		= cpm_eoi,
+#ifdef CONFIG_IPIPE
+	.mask_ack	= cpm_ack,
+	.mask		= cpm_mask_irq,
+	.unmask		= cpm_unmask_irq,
+#endif
 };
 
 void
@@ -201,8 +206,13 @@
         /* install the CPM interrupt controller routines for the CPM
          * interrupt vectors
          */
-        for ( i = CPM_IRQ_OFFSET ; i < CPM_IRQ_OFFSET + NR_CPM_INTS ; i++ )
+        for ( i = CPM_IRQ_OFFSET ; i < CPM_IRQ_OFFSET + NR_CPM_INTS ; i++ ) {
                 irq_desc[i].chip = &cpm_pic;
+#ifdef CONFIG_IPIPE
+		irq_desc[i].ipipe_ack = &__ipipe_ack_level_irq;
+		irq_desc[i].ipipe_end = &__ipipe_end_level_irq;
+#endif
+	}
 
 	/* Set our interrupt handler with the core CPU.	*/
 	if (setup_irq(CPM_INTERRUPT, &cpm_interrupt_irqaction))

--------------000003050504000202090308--

