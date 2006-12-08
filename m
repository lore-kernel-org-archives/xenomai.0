Message-ID: <45795320.5060806@domain.hid>
Date: Fri, 08 Dec 2006 12:57:20 +0100
From: Wolfgang Grandegger <wg@domain.hid>
MIME-Version: 1.0
Subject: Re: [Adeos-main] [PATCH] ppc mvme5500
References: <1165537720.4578b1b879da9@domain.hid>
In-Reply-To: <1165537720.4578b1b879da9@domain.hid>
Content-Type: multipart/mixed; boundary="------------090603000904070302090006"
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: </public/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: barbalace@domain.hid
Cc: adeos-main@gna.org

This is a multi-part message in MIME format.
--------------090603000904070302090006
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

barbalace@domain.hid wrote:
> I'm working on linux 2.6.14 + ipipe + xenomai2.2.0 (refer to thread
> https://mail.gna.org/public/xenomai-help/2006-05/msg00082.html, maybe the same
> case-study).
> 
> I'm using ipipe patch:
>   adeos-ipipe-2.6.14-ppc-1.3-05.patch
> 
> this and next patch I tried, doesn't work and some write on the flash, if you
> doesn't protect it again write (with on-board jumpers).
> 
> I make this simple patch (that I past at the end of the mail).
> To use it I recommend to:
> 1. extract a Vanilla linux kernel
> 2. patch it with the Motorola patch (BSP)
> 3. patch it with the ipipe patch (adeos-ipipe-2.6.14-ppc-1.3-05.patch)
> 4. apply this patch
> 
> I test it only with write protect enable on the MVME5500 board; flash and eeprom
> were not writeable, ensure this with a cat on /proc/cpuinfo.

Ah, oh, this is another prime example of PIC code requiring a patch, 
also on PowerPC :-(. The problem are the Linux spin_* functions in 
include/asm-ppc/mv64x60.h:

/* Define I/O routines for accessing registers on the 64x60 bridge. */
extern inline void
mv64x60_write(struct mv64x60_handle *bh, u32 offset, u32 val) {
	ulong	flags;

	spin_lock_irqsave(&mv64x60_lock, flags);
	out_le32(bh->v_base + offset, val);
	spin_unlock_irqrestore(&mv64x60_lock, flags);
}

extern inline u32
mv64x60_read(struct mv64x60_handle *bh, u32 offset) {
	ulong	flags;
	u32     reg;

	spin_lock_irqsave(&mv64x60_lock, flags);
	reg = in_le32(bh->v_base + offset);
	spin_unlock_irqrestore(&mv64x60_lock, flags);
	return reg;
}

Why not just iron them with the "spin_*_hw" variants, or remove them 
completely? That's what your patch does as well. I think the out_le32 
and in_le32 functions already access the registers atomically. To be 
save, use "spin_*_hw". Does the attached patch work with and without 
IPIPE enabled?

Thanks for reporting.

Wolfgang.

> 
> regards,
>   Antonio Barbalace
> 
> 
> diff -u -r linux-2.6.14-ecc.11012006-rfx01-ipipe/arch/ppc/syslib/gt64260_pic.c
> linux-2.6.14-ecc.11012006-rfx01-ipipe.rfx01/arch/ppc/syslib/gt64260_pic.c
> ---
> linux-2.6.14-ecc.11012006-rfx01-ipipe/arch/ppc/syslib/gt64260_pic.c	2005-10-28
> 02:02:08.000000000 +0200
> +++
> linux-2.6.14-ecc.11012006-rfx01-ipipe.rfx01/arch/ppc/syslib/gt64260_pic.c	2006-12-06
> 13:50:42.000000000 +0100
> @@ -32,6 +32,11 @@
>   *    input.
>   */
> 
> +/*
> + * Modified by: A. Barbalace <barbalac@domain.hid> CNR Consorzio RFX Padova
> + *
> +*/
> +
>  #include <linux/stddef.h>
>  #include <linux/init.h>
>  #include <linux/interrupt.h>
> @@ -52,8 +57,19 @@
> 
>  /* ========================== forward declaration ========================== */
> 
> +static inline void gt64260pic_write(struct mv64x60_handle *bh, u32 offset, u32
> val)
> +{
> +	out_le32(bh->v_base + offset, val);
> +}
> +
> +static inline u32 gt64260pic_read(struct mv64x60_handle *bh, u32 offset)
> +{
> +	return in_le32(bh->v_base + offset);
> +}
> +
>  static void gt64260_unmask_irq(unsigned int);
>  static void gt64260_mask_irq(unsigned int);
> +/* static void gt64260_end_irq(unsigned int); */
> 
>  /* ========================== local declarations =========================== */
> 
> @@ -63,6 +79,7 @@
>  	.disable  = gt64260_mask_irq,
>  	.ack      = gt64260_mask_irq,
>  	.end      = gt64260_unmask_irq,
> +	/* .end      = gt64260_end_irq */
>  };
> 
>  u32 gt64260_irq_base = 0;	/* GT64260 handles the next 96 IRQs from here */
> @@ -92,10 +109,10 @@
>  	ppc_cached_irq_mask[2] = 0;
> 
>  	/* disable all interrupts and clear current interrupts */
> -	mv64x60_write(&bh, MV64x60_GPP_INTR_MASK, ppc_cached_irq_mask[2]);
> -	mv64x60_write(&bh, MV64x60_GPP_INTR_CAUSE, 0);
> -	mv64x60_write(&bh, GT64260_IC_CPU_INTR_MASK_LO, ppc_cached_irq_mask[0]);
> -	mv64x60_write(&bh, GT64260_IC_CPU_INTR_MASK_HI, ppc_cached_irq_mask[1]);
> +	gt64260pic_write(&bh, MV64x60_GPP_INTR_MASK, ppc_cached_irq_mask[2]);
> +	gt64260pic_write(&bh, MV64x60_GPP_INTR_CAUSE, 0);
> +	gt64260pic_write(&bh, GT64260_IC_CPU_INTR_MASK_LO, ppc_cached_irq_mask[0]);
> +	gt64260pic_write(&bh, GT64260_IC_CPU_INTR_MASK_HI, ppc_cached_irq_mask[1]);
> 
>  	/* use the gt64260 for all (possible) interrupt sources */
>  	for (i = gt64260_irq_base; i < (gt64260_irq_base + 96); i++)
> @@ -126,18 +143,18 @@
>  	int irq;
>  	int irq_gpp;
> 
> -	irq = mv64x60_read(&bh, GT64260_IC_MAIN_CAUSE_LO);
> +	irq = gt64260pic_read(&bh, GT64260_IC_MAIN_CAUSE_LO);
>  	irq = __ilog2((irq & 0x3dfffffe) & ppc_cached_irq_mask[0]);
> 
>  	if (irq == -1) {
> -		irq = mv64x60_read(&bh, GT64260_IC_MAIN_CAUSE_HI);
> +		irq = gt64260pic_read(&bh, GT64260_IC_MAIN_CAUSE_HI);
>  		irq = __ilog2((irq & 0x0f000db7) & ppc_cached_irq_mask[1]);
> 
>  		if (irq == -1)
>  			irq = -2; /* bogus interrupt, should never happen */
>  		else {
>  			if (irq >= 24) {
> -				irq_gpp = mv64x60_read(&bh,
> +				irq_gpp = gt64260pic_read(&bh,
>  					MV64x60_GPP_INTR_CAUSE);
>  				irq_gpp = __ilog2(irq_gpp &
>  					ppc_cached_irq_mask[2]);
> @@ -146,7 +163,7 @@
>  					irq = -2;
>  				else {
>  					irq = irq_gpp + 64;
> -					mv64x60_write(&bh,
> +					gt64260pic_write(&bh,
>  						MV64x60_GPP_INTR_CAUSE,
>  						~(1 << (irq - 64)));
>  				}
> @@ -155,7 +172,7 @@
>  		}
>  	}
> 
> -	(void)mv64x60_read(&bh, MV64x60_GPP_INTR_CAUSE);
> +	(void)gt64260pic_read(&bh, MV64x60_GPP_INTR_CAUSE);
> 
>  	if (irq < 0)
>  		return (irq);
> @@ -183,19 +200,23 @@
> 
>  	if (irq > 31)
>  		if (irq > 63) /* unmask GPP irq */
> -			mv64x60_write(&bh, MV64x60_GPP_INTR_MASK,
> -				ppc_cached_irq_mask[2] |= (1 << (irq - 64)));
> +			gt64260pic_write(&bh, MV64x60_GPP_INTR_MASK, ppc_cached_irq_mask[2] |= (1 <<
> (irq - 64)));
>  		else /* mask high interrupt register */
> -			mv64x60_write(&bh, GT64260_IC_CPU_INTR_MASK_HI,
> -				ppc_cached_irq_mask[1] |= (1 << (irq - 32)));
> +			gt64260pic_write(&bh, GT64260_IC_CPU_INTR_MASK_HI, ppc_cached_irq_mask[1] |=
> (1 << (irq - 32)));
>  	else /* mask low interrupt register */
> -		mv64x60_write(&bh, GT64260_IC_CPU_INTR_MASK_LO,
> -			ppc_cached_irq_mask[0] |= (1 << irq));
> +		gt64260pic_write(&bh, GT64260_IC_CPU_INTR_MASK_LO, ppc_cached_irq_mask[0] |=
> (1 << irq));
> 
> -	(void)mv64x60_read(&bh, MV64x60_GPP_INTR_MASK);
> +	(void)gt64260pic_read(&bh, MV64x60_GPP_INTR_MASK);
>  	return;
>  }
> +/*static void
> +gt64260_end_irq(unsigned int irq)
> +{
> +	if (!ipipe_root_domain_p || (!irq_desc[irq].status & (IRQ_DISABLED |
> IRQ_INPROGRESS)))
> +		gt64260_unmask_irq(irq);
> 
> +	return;
> +}*/
>  /* gt64260_mask_irq()
>   *
>   *  This function disables the requested interrupt.
> @@ -216,16 +237,16 @@
> 
>  	if (irq > 31)
>  		if (irq > 63) /* mask GPP irq */
> -			mv64x60_write(&bh, MV64x60_GPP_INTR_MASK,
> +			gt64260pic_write(&bh, MV64x60_GPP_INTR_MASK,
>  				ppc_cached_irq_mask[2] &= ~(1 << (irq - 64)));
>  		else /* mask high interrupt register */
> -			mv64x60_write(&bh, GT64260_IC_CPU_INTR_MASK_HI,
> +			gt64260pic_write(&bh, GT64260_IC_CPU_INTR_MASK_HI,
>  				ppc_cached_irq_mask[1] &= ~(1 << (irq - 32)));
>  	else /* mask low interrupt register */
> -		mv64x60_write(&bh, GT64260_IC_CPU_INTR_MASK_LO,
> +		gt64260pic_write(&bh, GT64260_IC_CPU_INTR_MASK_LO,
>  			ppc_cached_irq_mask[0] &= ~(1 << irq));
> 
> -	(void)mv64x60_read(&bh, MV64x60_GPP_INTR_MASK);
> +	(void)gt64260pic_read(&bh, MV64x60_GPP_INTR_MASK);
>  	return;
>  }
> 
> @@ -234,19 +255,19 @@
>  {
>  	printk(KERN_ERR "gt64260_cpu_error_int_handler: %s 0x%08x\n",
>  		"Error on CPU interface - Cause regiser",
> -		mv64x60_read(&bh, MV64x60_CPU_ERR_CAUSE));
> +		gt64260pic_read(&bh, MV64x60_CPU_ERR_CAUSE));
>  	printk(KERN_ERR "\tCPU error register dump:\n");
>  	printk(KERN_ERR "\tAddress low  0x%08x\n",
> -	       mv64x60_read(&bh, MV64x60_CPU_ERR_ADDR_LO));
> +	       gt64260pic_read(&bh, MV64x60_CPU_ERR_ADDR_LO));
>  	printk(KERN_ERR "\tAddress high 0x%08x\n",
> -	       mv64x60_read(&bh, MV64x60_CPU_ERR_ADDR_HI));
> +	       gt64260pic_read(&bh, MV64x60_CPU_ERR_ADDR_HI));
>  	printk(KERN_ERR "\tData low     0x%08x\n",
> -	       mv64x60_read(&bh, MV64x60_CPU_ERR_DATA_LO));
> +	       gt64260pic_read(&bh, MV64x60_CPU_ERR_DATA_LO));
>  	printk(KERN_ERR "\tData high    0x%08x\n",
> -	       mv64x60_read(&bh, MV64x60_CPU_ERR_DATA_HI));
> +	       gt64260pic_read(&bh, MV64x60_CPU_ERR_DATA_HI));
>  	printk(KERN_ERR "\tParity       0x%08x\n",
> -	       mv64x60_read(&bh, MV64x60_CPU_ERR_PARITY));
> -	mv64x60_write(&bh, MV64x60_CPU_ERR_CAUSE, 0);
> +	       gt64260pic_read(&bh, MV64x60_CPU_ERR_PARITY));
> +	gt64260pic_write(&bh, MV64x60_CPU_ERR_CAUSE, 0);
>  	return IRQ_HANDLED;
>  }
> 
> @@ -257,36 +278,36 @@
>  	unsigned int pci_bus = (unsigned int)dev_id;
> 
>  	if (pci_bus == 0) {	/* Error on PCI 0 */
> -		val = mv64x60_read(&bh, MV64x60_PCI0_ERR_CAUSE);
> +		val = gt64260pic_read(&bh, MV64x60_PCI0_ERR_CAUSE);
>  		printk(KERN_ERR "%s: Error in PCI %d Interface\n",
>  			"gt64260_pci_error_int_handler", pci_bus);
>  		printk(KERN_ERR "\tPCI %d error register dump:\n", pci_bus);
>  		printk(KERN_ERR "\tCause register 0x%08x\n", val);
>  		printk(KERN_ERR "\tAddress Low    0x%08x\n",
> -		       mv64x60_read(&bh, MV64x60_PCI0_ERR_ADDR_LO));
> +		       gt64260pic_read(&bh, MV64x60_PCI0_ERR_ADDR_LO));
>  		printk(KERN_ERR "\tAddress High   0x%08x\n",
> -		       mv64x60_read(&bh, MV64x60_PCI0_ERR_ADDR_HI));
> +		       gt64260pic_read(&bh, MV64x60_PCI0_ERR_ADDR_HI));
>  		printk(KERN_ERR "\tAttribute      0x%08x\n",
> -		       mv64x60_read(&bh, MV64x60_PCI0_ERR_DATA_LO));
> +		       gt64260pic_read(&bh, MV64x60_PCI0_ERR_DATA_LO));
>  		printk(KERN_ERR "\tCommand        0x%08x\n",
> -		       mv64x60_read(&bh, MV64x60_PCI0_ERR_CMD));
> -		mv64x60_write(&bh, MV64x60_PCI0_ERR_CAUSE, ~val);
> +		       gt64260pic_read(&bh, MV64x60_PCI0_ERR_CMD));
> +		gt64260pic_write(&bh, MV64x60_PCI0_ERR_CAUSE, ~val);
>  	}
>  	if (pci_bus == 1) {	/* Error on PCI 1 */
> -		val = mv64x60_read(&bh, MV64x60_PCI1_ERR_CAUSE);
> +		val = gt64260pic_read(&bh, MV64x60_PCI1_ERR_CAUSE);
>  		printk(KERN_ERR "%s: Error in PCI %d Interface\n",
>  			"gt64260_pci_error_int_handler", pci_bus);
>  		printk(KERN_ERR "\tPCI %d error register dump:\n", pci_bus);
>  		printk(KERN_ERR "\tCause register 0x%08x\n", val);
>  		printk(KERN_ERR "\tAddress Low    0x%08x\n",
> -		       mv64x60_read(&bh, MV64x60_PCI1_ERR_ADDR_LO));
> +		       gt64260pic_read(&bh, MV64x60_PCI1_ERR_ADDR_LO));
>  		printk(KERN_ERR "\tAddress High   0x%08x\n",
> -		       mv64x60_read(&bh, MV64x60_PCI1_ERR_ADDR_HI));
> +		       gt64260pic_read(&bh, MV64x60_PCI1_ERR_ADDR_HI));
>  		printk(KERN_ERR "\tAttribute      0x%08x\n",
> -		       mv64x60_read(&bh, MV64x60_PCI1_ERR_DATA_LO));
> +		       gt64260pic_read(&bh, MV64x60_PCI1_ERR_DATA_LO));
>  		printk(KERN_ERR "\tCommand        0x%08x\n",
> -		       mv64x60_read(&bh, MV64x60_PCI1_ERR_CMD));
> -		mv64x60_write(&bh, MV64x60_PCI1_ERR_CAUSE, ~val);
> +		       gt64260pic_read(&bh, MV64x60_PCI1_ERR_CMD));
> +		gt64260pic_write(&bh, MV64x60_PCI1_ERR_CAUSE, ~val);
>  	}
>  	return IRQ_HANDLED;
>  }
> @@ -301,8 +322,8 @@
>  		gt64260_cpu_error_int_handler, SA_INTERRUPT, CPU_INTR_STR, 0)))
>  		printk(KERN_WARNING "Can't register cpu error handler: %d", rc);
> 
> -	mv64x60_write(&bh, MV64x60_CPU_ERR_MASK, 0);
> -	mv64x60_write(&bh, MV64x60_CPU_ERR_MASK, 0x000000fe);
> +	gt64260pic_write(&bh, MV64x60_CPU_ERR_MASK, 0);
> +	gt64260pic_write(&bh, MV64x60_CPU_ERR_MASK, 0x000000fe);
> 
>  	/* Register PCI 0 error interrupt handler */
>  	if ((rc = request_irq(MV64360_IRQ_PCI0, gt64260_pci_error_int_handler,
> @@ -310,8 +331,8 @@
>  		printk(KERN_WARNING "Can't register pci 0 error handler: %d",
>  			rc);
> 
> -	mv64x60_write(&bh, MV64x60_PCI0_ERR_MASK, 0);
> -	mv64x60_write(&bh, MV64x60_PCI0_ERR_MASK, 0x003c0c24);
> +	gt64260pic_write(&bh, MV64x60_PCI0_ERR_MASK, 0);
> +	gt64260pic_write(&bh, MV64x60_PCI0_ERR_MASK, 0x003c0c24);
> 
>  	/* Register PCI 1 error interrupt handler */
>  	if ((rc = request_irq(MV64360_IRQ_PCI1, gt64260_pci_error_int_handler,
> @@ -319,10 +340,11 @@
>  		printk(KERN_WARNING "Can't register pci 1 error handler: %d",
>  			rc);
> 
> -	mv64x60_write(&bh, MV64x60_PCI1_ERR_MASK, 0);
> -	mv64x60_write(&bh, MV64x60_PCI1_ERR_MASK, 0x003c0c24);
> +	gt64260pic_write(&bh, MV64x60_PCI1_ERR_MASK, 0);
> +	gt64260pic_write(&bh, MV64x60_PCI1_ERR_MASK, 0x003c0c24);
> 
>  	return 0;
>  }
> 
>  arch_initcall(gt64260_register_hdlrs);
> +
> diff -u -r linux-2.6.14-ecc.11012006-rfx01-ipipe/arch/ppc/syslib/i8259.c
> linux-2.6.14-ecc.11012006-rfx01-ipipe.rfx01/arch/ppc/syslib/i8259.c
> --- linux-2.6.14-ecc.11012006-rfx01-ipipe/arch/ppc/syslib/i8259.c	2005-10-28
> 02:02:08.000000000 +0200
> +++
> linux-2.6.14-ecc.11012006-rfx01-ipipe.rfx01/arch/ppc/syslib/i8259.c	2006-12-06
> 14:06:19.000000000 +0100
> @@ -157,7 +157,8 @@
>  	.flags = IORESOURCE_BUSY,
>  };
> 
> -static struct irqaction i8259_irqaction = {
> +//static struct irqaction i8259_irqaction = {		// IPIPE: remove static
> declaration like other IPIPE patch
> +struct irqaction i8259_irqaction = {
>  	.handler = no_action,
>  	.flags = SA_INTERRUPT,
>  	.mask = CPU_MASK_NONE,
> 
> 
> Antonio Barbalace
> CNR Consorzio RFX - Associazione EURATOM/ENEA sulla Fusione
> Corso Stati Uniti, 4
> 35127 Padova
> ITALY
> 
> _______________________________________________
> Adeos-main mailing list
> Adeos-main@domain.hid
> https://mail.gna.org/listinfo/adeos-main
> 
> 


--------------090603000904070302090006
Content-Type: text/x-patch;
 name="adeos-ipipe-2.6.x-mv64x60.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="adeos-ipipe-2.6.x-mv64x60.patch"

+ diff -u linux-2.6.19/include/asm-ppc/mv64x60.h.PIC linux-2.6.19/include/asm-ppc/mv64x60.h
--- linux-2.6.19/include/asm-ppc/mv64x60.h.PIC	2006-11-29 22:57:37.000000000 +0100
+++ linux-2.6.19/include/asm-ppc/mv64x60.h	2006-12-08 11:54:43.000000000 +0100
@@ -255,9 +255,9 @@
 mv64x60_write(struct mv64x60_handle *bh, u32 offset, u32 val) {
 	ulong	flags;
 
-	spin_lock_irqsave(&mv64x60_lock, flags);
+	spin_lock_irqsave_hw(&mv64x60_lock, flags);
 	out_le32(bh->v_base + offset, val);
-	spin_unlock_irqrestore(&mv64x60_lock, flags);
+	spin_unlock_irqrestore_hw(&mv64x60_lock, flags);
 }
 
 extern inline u32
@@ -265,9 +265,9 @@
 	ulong	flags;
 	u32     reg;
 
-	spin_lock_irqsave(&mv64x60_lock, flags);
+	spin_lock_irqsave_hw(&mv64x60_lock, flags);
 	reg = in_le32(bh->v_base + offset);
-	spin_unlock_irqrestore(&mv64x60_lock, flags);
+	spin_unlock_irqrestore_hw(&mv64x60_lock, flags);
 	return reg;
 }
 
@@ -277,11 +277,11 @@
 	u32	reg;
 	ulong	flags;
 
-	spin_lock_irqsave(&mv64x60_lock, flags);
+	spin_lock_irqsave_hw(&mv64x60_lock, flags);
 	reg = in_le32(bh->v_base + offs) & (~mask);
 	reg |= data & mask;
 	out_le32(bh->v_base + offs, reg);
-	spin_unlock_irqrestore(&mv64x60_lock, flags);
+	spin_unlock_irqrestore_hw(&mv64x60_lock, flags);
 }
 
 #define	mv64x60_set_bits(bh, offs, bits) mv64x60_modify(bh, offs, ~0, bits)

--------------090603000904070302090006--

