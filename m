Message-ID: <1165595720.45799448b0adc@domain.hid>
Date: Fri,  8 Dec 2006 17:35:20 +0100
From: barbalace@domain.hid
Subject: Re: [Adeos-main] [PATCH] ppc mvme5500
References: <1165537720.4578b1b879da9@domain.hid>
	<45795320.5060806@domain.hid>
In-Reply-To: <45795320.5060806@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: </public/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: Wolfgang Grandegger <wg@domain.hid>
Cc: adeos-main@gna.org

;-) Yes, the problem are the Linux spin_* functions, sincerly I don't und=
erstand
why there are this spin_* functions (maybe for another architecture, diff=
erent
from ppc???).
'in_le32' and 'out_le32' are substantially atomic, are declared in
include/asm-ppc/io.h:

extern inline unsigned in_le32(const volatile unsigned __iomem *addr)
{
	unsigned ret;

	__asm__ __volatile__("lwbrx %0,0,%1;\n"
			     "twi 0,%0,0;\n"
			     "isync" : "=3Dr" (ret) :
			     "r" (addr), "m" (*addr));
	return ret;
}
extern inline void out_le32(volatile unsigned __iomem *addr, int val)
{
	__asm__ __volatile__("stwbrx %1,0,%2; eieio" : "=3Dm" (*addr) :
			     "r" (val), "r" (addr));
}

The load istruction is lwbrx and the store istruction is stwbrx: one istr=
uction
=3D atomic (do you agree?). isync and eieio are synchronization istructio=
n, if
executed in a second time doesn't change the behaviour.

I test this patch with and without the IPIPE enabled.
>From my point of view I think is better to remove the spin_* in the ppc a=
rch to
avoid the spinlock overhead. For a portability issue is better to use a p=
ragma
#ifdef structure.

Antonio


Quoting Wolfgang Grandegger <wg@domain.hid>:

> barbalace@domain.hid wrote:
> > I'm working on linux 2.6.14 + ipipe + xenomai2.2.0 (refer to thread
> > https://mail.gna.org/public/xenomai-help/2006-05/msg00082.html, maybe=
 the
> same
> > case-study).
> >
> > I'm using ipipe patch:
> >   adeos-ipipe-2.6.14-ppc-1.3-05.patch
> >
> > this and next patch I tried, doesn't work and some write on the flash=
, if
> you
> > doesn't protect it again write (with on-board jumpers).
> >
> > I make this simple patch (that I past at the end of the mail).
> > To use it I recommend to:
> > 1. extract a Vanilla linux kernel
> > 2. patch it with the Motorola patch (BSP)
> > 3. patch it with the ipipe patch (adeos-ipipe-2.6.14-ppc-1.3-05.patch=
)
> > 4. apply this patch
> >
> > I test it only with write protect enable on the MVME5500 board; flash=
 and
> eeprom
> > were not writeable, ensure this with a cat on /proc/cpuinfo.
>
> Ah, oh, this is another prime example of PIC code requiring a patch,
> also on PowerPC :-(. The problem are the Linux spin_* functions in
> include/asm-ppc/mv64x60.h:
>
> /* Define I/O routines for accessing registers on the 64x60 bridge. */
> extern inline void
> mv64x60_write(struct mv64x60_handle *bh, u32 offset, u32 val) {
> 	ulong	flags;
>
> 	spin_lock_irqsave(&mv64x60_lock, flags);
> 	out_le32(bh->v_base + offset, val);
> 	spin_unlock_irqrestore(&mv64x60_lock, flags);
> }
>
> extern inline u32
> mv64x60_read(struct mv64x60_handle *bh, u32 offset) {
> 	ulong	flags;
> 	u32     reg;
>
> 	spin_lock_irqsave(&mv64x60_lock, flags);
> 	reg =3D in_le32(bh->v_base + offset);
> 	spin_unlock_irqrestore(&mv64x60_lock, flags);
> 	return reg;
> }
>
> Why not just iron them with the "spin_*_hw" variants, or remove them
> completely? That's what your patch does as well. I think the out_le32
> and in_le32 functions already access the registers atomically. To be
> save, use "spin_*_hw". Does the attached patch work with and without
> IPIPE enabled?
>
> Thanks for reporting.
>
> Wolfgang.
>
> >
> > regards,
> >   Antonio Barbalace
> >
> >
> > diff -u -r
> linux-2.6.14-ecc.11012006-rfx01-ipipe/arch/ppc/syslib/gt64260_pic.c
> > linux-2.6.14-ecc.11012006-rfx01-ipipe.rfx01/arch/ppc/syslib/gt64260_p=
ic.c
> > ---
> >
> linux-2.6.14-ecc.11012006-rfx01-ipipe/arch/ppc/syslib/gt64260_pic.c	200=
5-10-28
> > 02:02:08.000000000 +0200
> > +++
> >
>
linux-2.6.14-ecc.11012006-rfx01-ipipe.rfx01/arch/ppc/syslib/gt64260_pic.c=
	2006-12-06
> > 13:50:42.000000000 +0100
> > @@ -32,6 +32,11 @@
> >   *    input.
> >   */
> >
> > +/*
> > + * Modified by: A. Barbalace <barbalac@domain.hid> CNR Consorzio R=
FX
> Padova
> > + *
> > +*/
> > +
> >  #include <linux/stddef.h>
> >  #include <linux/init.h>
> >  #include <linux/interrupt.h>
> > @@ -52,8 +57,19 @@
> >
> >  /* =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D forward declaration
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D */
> >
> > +static inline void gt64260pic_write(struct mv64x60_handle *bh, u32 o=
ffset,
> u32
> > val)
> > +{
> > +	out_le32(bh->v_base + offset, val);
> > +}
> > +
> > +static inline u32 gt64260pic_read(struct mv64x60_handle *bh, u32 off=
set)
> > +{
> > +	return in_le32(bh->v_base + offset);
> > +}
> > +
> >  static void gt64260_unmask_irq(unsigned int);
> >  static void gt64260_mask_irq(unsigned int);
> > +/* static void gt64260_end_irq(unsigned int); */
> >
> >  /* =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D local declarations
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D */
> >
> > @@ -63,6 +79,7 @@
> >  	.disable  =3D gt64260_mask_irq,
> >  	.ack      =3D gt64260_mask_irq,
> >  	.end      =3D gt64260_unmask_irq,
> > +	/* .end      =3D gt64260_end_irq */
> >  };
> >
> >  u32 gt64260_irq_base =3D 0;	/* GT64260 handles the next 96 IRQs from=
 here */
> > @@ -92,10 +109,10 @@
> >  	ppc_cached_irq_mask[2] =3D 0;
> >
> >  	/* disable all interrupts and clear current interrupts */
> > -	mv64x60_write(&bh, MV64x60_GPP_INTR_MASK, ppc_cached_irq_mask[2]);
> > -	mv64x60_write(&bh, MV64x60_GPP_INTR_CAUSE, 0);
> > -	mv64x60_write(&bh, GT64260_IC_CPU_INTR_MASK_LO, ppc_cached_irq_mask=
[0]);
> > -	mv64x60_write(&bh, GT64260_IC_CPU_INTR_MASK_HI, ppc_cached_irq_mask=
[1]);
> > +	gt64260pic_write(&bh, MV64x60_GPP_INTR_MASK, ppc_cached_irq_mask[2]=
);
> > +	gt64260pic_write(&bh, MV64x60_GPP_INTR_CAUSE, 0);
> > +	gt64260pic_write(&bh, GT64260_IC_CPU_INTR_MASK_LO,
> ppc_cached_irq_mask[0]);
> > +	gt64260pic_write(&bh, GT64260_IC_CPU_INTR_MASK_HI,
> ppc_cached_irq_mask[1]);
> >
> >  	/* use the gt64260 for all (possible) interrupt sources */
> >  	for (i =3D gt64260_irq_base; i < (gt64260_irq_base + 96); i++)
> > @@ -126,18 +143,18 @@
> >  	int irq;
> >  	int irq_gpp;
> >
> > -	irq =3D mv64x60_read(&bh, GT64260_IC_MAIN_CAUSE_LO);
> > +	irq =3D gt64260pic_read(&bh, GT64260_IC_MAIN_CAUSE_LO);
> >  	irq =3D __ilog2((irq & 0x3dfffffe) & ppc_cached_irq_mask[0]);
> >
> >  	if (irq =3D=3D -1) {
> > -		irq =3D mv64x60_read(&bh, GT64260_IC_MAIN_CAUSE_HI);
> > +		irq =3D gt64260pic_read(&bh, GT64260_IC_MAIN_CAUSE_HI);
> >  		irq =3D __ilog2((irq & 0x0f000db7) & ppc_cached_irq_mask[1]);
> >
> >  		if (irq =3D=3D -1)
> >  			irq =3D -2; /* bogus interrupt, should never happen */
> >  		else {
> >  			if (irq >=3D 24) {
> > -				irq_gpp =3D mv64x60_read(&bh,
> > +				irq_gpp =3D gt64260pic_read(&bh,
> >  					MV64x60_GPP_INTR_CAUSE);
> >  				irq_gpp =3D __ilog2(irq_gpp &
> >  					ppc_cached_irq_mask[2]);
> > @@ -146,7 +163,7 @@
> >  					irq =3D -2;
> >  				else {
> >  					irq =3D irq_gpp + 64;
> > -					mv64x60_write(&bh,
> > +					gt64260pic_write(&bh,
> >  						MV64x60_GPP_INTR_CAUSE,
> >  						~(1 << (irq - 64)));
> >  				}
> > @@ -155,7 +172,7 @@
> >  		}
> >  	}
> >
> > -	(void)mv64x60_read(&bh, MV64x60_GPP_INTR_CAUSE);
> > +	(void)gt64260pic_read(&bh, MV64x60_GPP_INTR_CAUSE);
> >
> >  	if (irq < 0)
> >  		return (irq);
> > @@ -183,19 +200,23 @@
> >
> >  	if (irq > 31)
> >  		if (irq > 63) /* unmask GPP irq */
> > -			mv64x60_write(&bh, MV64x60_GPP_INTR_MASK,
> > -				ppc_cached_irq_mask[2] |=3D (1 << (irq - 64)));
> > +			gt64260pic_write(&bh, MV64x60_GPP_INTR_MASK, ppc_cached_irq_mask[=
2] |=3D
> (1 <<
> > (irq - 64)));
> >  		else /* mask high interrupt register */
> > -			mv64x60_write(&bh, GT64260_IC_CPU_INTR_MASK_HI,
> > -				ppc_cached_irq_mask[1] |=3D (1 << (irq - 32)));
> > +			gt64260pic_write(&bh, GT64260_IC_CPU_INTR_MASK_HI,
> ppc_cached_irq_mask[1] |=3D
> > (1 << (irq - 32)));
> >  	else /* mask low interrupt register */
> > -		mv64x60_write(&bh, GT64260_IC_CPU_INTR_MASK_LO,
> > -			ppc_cached_irq_mask[0] |=3D (1 << irq));
> > +		gt64260pic_write(&bh, GT64260_IC_CPU_INTR_MASK_LO,
> ppc_cached_irq_mask[0] |=3D
> > (1 << irq));
> >
> > -	(void)mv64x60_read(&bh, MV64x60_GPP_INTR_MASK);
> > +	(void)gt64260pic_read(&bh, MV64x60_GPP_INTR_MASK);
> >  	return;
> >  }
> > +/*static void
> > +gt64260_end_irq(unsigned int irq)
> > +{
> > +	if (!ipipe_root_domain_p || (!irq_desc[irq].status & (IRQ_DISABLED =
|
> > IRQ_INPROGRESS)))
> > +		gt64260_unmask_irq(irq);
> >
> > +	return;
> > +}*/
> >  /* gt64260_mask_irq()
> >   *
> >   *  This function disables the requested interrupt.
> > @@ -216,16 +237,16 @@
> >
> >  	if (irq > 31)
> >  		if (irq > 63) /* mask GPP irq */
> > -			mv64x60_write(&bh, MV64x60_GPP_INTR_MASK,
> > +			gt64260pic_write(&bh, MV64x60_GPP_INTR_MASK,
> >  				ppc_cached_irq_mask[2] &=3D ~(1 << (irq - 64)));
> >  		else /* mask high interrupt register */
> > -			mv64x60_write(&bh, GT64260_IC_CPU_INTR_MASK_HI,
> > +			gt64260pic_write(&bh, GT64260_IC_CPU_INTR_MASK_HI,
> >  				ppc_cached_irq_mask[1] &=3D ~(1 << (irq - 32)));
> >  	else /* mask low interrupt register */
> > -		mv64x60_write(&bh, GT64260_IC_CPU_INTR_MASK_LO,
> > +		gt64260pic_write(&bh, GT64260_IC_CPU_INTR_MASK_LO,
> >  			ppc_cached_irq_mask[0] &=3D ~(1 << irq));
> >
> > -	(void)mv64x60_read(&bh, MV64x60_GPP_INTR_MASK);
> > +	(void)gt64260pic_read(&bh, MV64x60_GPP_INTR_MASK);
> >  	return;
> >  }
> >
> > @@ -234,19 +255,19 @@
> >  {
> >  	printk(KERN_ERR "gt64260_cpu_error_int_handler: %s 0x%08x\n",
> >  		"Error on CPU interface - Cause regiser",
> > -		mv64x60_read(&bh, MV64x60_CPU_ERR_CAUSE));
> > +		gt64260pic_read(&bh, MV64x60_CPU_ERR_CAUSE));
> >  	printk(KERN_ERR "\tCPU error register dump:\n");
> >  	printk(KERN_ERR "\tAddress low  0x%08x\n",
> > -	       mv64x60_read(&bh, MV64x60_CPU_ERR_ADDR_LO));
> > +	       gt64260pic_read(&bh, MV64x60_CPU_ERR_ADDR_LO));
> >  	printk(KERN_ERR "\tAddress high 0x%08x\n",
> > -	       mv64x60_read(&bh, MV64x60_CPU_ERR_ADDR_HI));
> > +	       gt64260pic_read(&bh, MV64x60_CPU_ERR_ADDR_HI));
> >  	printk(KERN_ERR "\tData low     0x%08x\n",
> > -	       mv64x60_read(&bh, MV64x60_CPU_ERR_DATA_LO));
> > +	       gt64260pic_read(&bh, MV64x60_CPU_ERR_DATA_LO));
> >  	printk(KERN_ERR "\tData high    0x%08x\n",
> > -	       mv64x60_read(&bh, MV64x60_CPU_ERR_DATA_HI));
> > +	       gt64260pic_read(&bh, MV64x60_CPU_ERR_DATA_HI));
> >  	printk(KERN_ERR "\tParity       0x%08x\n",
> > -	       mv64x60_read(&bh, MV64x60_CPU_ERR_PARITY));
> > -	mv64x60_write(&bh, MV64x60_CPU_ERR_CAUSE, 0);
> > +	       gt64260pic_read(&bh, MV64x60_CPU_ERR_PARITY));
> > +	gt64260pic_write(&bh, MV64x60_CPU_ERR_CAUSE, 0);
> >  	return IRQ_HANDLED;
> >  }
> >
> > @@ -257,36 +278,36 @@
> >  	unsigned int pci_bus =3D (unsigned int)dev_id;
> >
> >  	if (pci_bus =3D=3D 0) {	/* Error on PCI 0 */
> > -		val =3D mv64x60_read(&bh, MV64x60_PCI0_ERR_CAUSE);
> > +		val =3D gt64260pic_read(&bh, MV64x60_PCI0_ERR_CAUSE);
> >  		printk(KERN_ERR "%s: Error in PCI %d Interface\n",
> >  			"gt64260_pci_error_int_handler", pci_bus);
> >  		printk(KERN_ERR "\tPCI %d error register dump:\n", pci_bus);
> >  		printk(KERN_ERR "\tCause register 0x%08x\n", val);
> >  		printk(KERN_ERR "\tAddress Low    0x%08x\n",
> > -		       mv64x60_read(&bh, MV64x60_PCI0_ERR_ADDR_LO));
> > +		       gt64260pic_read(&bh, MV64x60_PCI0_ERR_ADDR_LO));
> >  		printk(KERN_ERR "\tAddress High   0x%08x\n",
> > -		       mv64x60_read(&bh, MV64x60_PCI0_ERR_ADDR_HI));
> > +		       gt64260pic_read(&bh, MV64x60_PCI0_ERR_ADDR_HI));
> >  		printk(KERN_ERR "\tAttribute      0x%08x\n",
> > -		       mv64x60_read(&bh, MV64x60_PCI0_ERR_DATA_LO));
> > +		       gt64260pic_read(&bh, MV64x60_PCI0_ERR_DATA_LO));
> >  		printk(KERN_ERR "\tCommand        0x%08x\n",
> > -		       mv64x60_read(&bh, MV64x60_PCI0_ERR_CMD));
> > -		mv64x60_write(&bh, MV64x60_PCI0_ERR_CAUSE, ~val);
> > +		       gt64260pic_read(&bh, MV64x60_PCI0_ERR_CMD));
> > +		gt64260pic_write(&bh, MV64x60_PCI0_ERR_CAUSE, ~val);
> >  	}
> >  	if (pci_bus =3D=3D 1) {	/* Error on PCI 1 */
> > -		val =3D mv64x60_read(&bh, MV64x60_PCI1_ERR_CAUSE);
> > +		val =3D gt64260pic_read(&bh, MV64x60_PCI1_ERR_CAUSE);
> >  		printk(KERN_ERR "%s: Error in PCI %d Interface\n",
> >  			"gt64260_pci_error_int_handler", pci_bus);
> >  		printk(KERN_ERR "\tPCI %d error register dump:\n", pci_bus);
> >  		printk(KERN_ERR "\tCause register 0x%08x\n", val);
> >  		printk(KERN_ERR "\tAddress Low    0x%08x\n",
> > -		       mv64x60_read(&bh, MV64x60_PCI1_ERR_ADDR_LO));
> > +		       gt64260pic_read(&bh, MV64x60_PCI1_ERR_ADDR_LO));
> >  		printk(KERN_ERR "\tAddress High   0x%08x\n",
> > -		       mv64x60_read(&bh, MV64x60_PCI1_ERR_ADDR_HI));
> > +		       gt64260pic_read(&bh, MV64x60_PCI1_ERR_ADDR_HI));
> >  		printk(KERN_ERR "\tAttribute      0x%08x\n",
> > -		       mv64x60_read(&bh, MV64x60_PCI1_ERR_DATA_LO));
> > +		       gt64260pic_read(&bh, MV64x60_PCI1_ERR_DATA_LO));
> >  		printk(KERN_ERR "\tCommand        0x%08x\n",
> > -		       mv64x60_read(&bh, MV64x60_PCI1_ERR_CMD));
> > -		mv64x60_write(&bh, MV64x60_PCI1_ERR_CAUSE, ~val);
> > +		       gt64260pic_read(&bh, MV64x60_PCI1_ERR_CMD));
> > +		gt64260pic_write(&bh, MV64x60_PCI1_ERR_CAUSE, ~val);
> >  	}
> >  	return IRQ_HANDLED;
> >  }
> > @@ -301,8 +322,8 @@
> >  		gt64260_cpu_error_int_handler, SA_INTERRUPT, CPU_INTR_STR, 0)))
> >  		printk(KERN_WARNING "Can't register cpu error handler: %d", rc);
> >
> > -	mv64x60_write(&bh, MV64x60_CPU_ERR_MASK, 0);
> > -	mv64x60_write(&bh, MV64x60_CPU_ERR_MASK, 0x000000fe);
> > +	gt64260pic_write(&bh, MV64x60_CPU_ERR_MASK, 0);
> > +	gt64260pic_write(&bh, MV64x60_CPU_ERR_MASK, 0x000000fe);
> >
> >  	/* Register PCI 0 error interrupt handler */
> >  	if ((rc =3D request_irq(MV64360_IRQ_PCI0, gt64260_pci_error_int_han=
dler,
> > @@ -310,8 +331,8 @@
> >  		printk(KERN_WARNING "Can't register pci 0 error handler: %d",
> >  			rc);
> >
> > -	mv64x60_write(&bh, MV64x60_PCI0_ERR_MASK, 0);
> > -	mv64x60_write(&bh, MV64x60_PCI0_ERR_MASK, 0x003c0c24);
> > +	gt64260pic_write(&bh, MV64x60_PCI0_ERR_MASK, 0);
> > +	gt64260pic_write(&bh, MV64x60_PCI0_ERR_MASK, 0x003c0c24);
> >
> >  	/* Register PCI 1 error interrupt handler */
> >  	if ((rc =3D request_irq(MV64360_IRQ_PCI1, gt64260_pci_error_int_han=
dler,
> > @@ -319,10 +340,11 @@
> >  		printk(KERN_WARNING "Can't register pci 1 error handler: %d",
> >  			rc);
> >
> > -	mv64x60_write(&bh, MV64x60_PCI1_ERR_MASK, 0);
> > -	mv64x60_write(&bh, MV64x60_PCI1_ERR_MASK, 0x003c0c24);
> > +	gt64260pic_write(&bh, MV64x60_PCI1_ERR_MASK, 0);
> > +	gt64260pic_write(&bh, MV64x60_PCI1_ERR_MASK, 0x003c0c24);
> >
> >  	return 0;
> >  }
> >
> >  arch_initcall(gt64260_register_hdlrs);
> > +
> > diff -u -r linux-2.6.14-ecc.11012006-rfx01-ipipe/arch/ppc/syslib/i825=
9.c
> > linux-2.6.14-ecc.11012006-rfx01-ipipe.rfx01/arch/ppc/syslib/i8259.c
> > ---
> linux-2.6.14-ecc.11012006-rfx01-ipipe/arch/ppc/syslib/i8259.c	2005-10-2=
8
> > 02:02:08.000000000 +0200
> > +++
> >
> linux-2.6.14-ecc.11012006-rfx01-ipipe.rfx01/arch/ppc/syslib/i8259.c	200=
6-12-06
> > 14:06:19.000000000 +0100
> > @@ -157,7 +157,8 @@
> >  	.flags =3D IORESOURCE_BUSY,
> >  };
> >
> > -static struct irqaction i8259_irqaction =3D {
> > +//static struct irqaction i8259_irqaction =3D {		// IPIPE: remove st=
atic
> > declaration like other IPIPE patch
> > +struct irqaction i8259_irqaction =3D {
> >  	.handler =3D no_action,
> >  	.flags =3D SA_INTERRUPT,
> >  	.mask =3D CPU_MASK_NONE,
> >
> >
> > Antonio Barbalace
> > CNR Consorzio RFX - Associazione EURATOM/ENEA sulla Fusione
> > Corso Stati Uniti, 4
> > 35127 Padova
> > ITALY
> >
> > _______________________________________________
> > Adeos-main mailing list
> > Adeos-main@domain.hid
> > https://mail.gna.org/listinfo/adeos-main
> >
> >
>
>




