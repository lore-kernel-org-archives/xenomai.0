From: Alexis Berlemont <berlemont.hauw@domain.hid>
Date: Thu, 20 Dec 2007 02:06:59 +0100
References: <f8f856500712180507q16d5c21bp56b45ec23ae5d36@domain.hid>
	<200712190119.11578.berlemont.hauw@domain.hid>
	<f8f856500712190529q34efcf75r4d80c22bb987cc8@domain.hid>
In-Reply-To: <f8f856500712190529q34efcf75r4d80c22bb987cc8@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200712200206.59253.berlemont.hauw@domain.hid>
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
To: xenomai@xenomai.org

Hi,

>
> I've check in the adeos_ipipe patch that open_pic.c, ppc4xx_pic.c and
> ipiq.c are patched.
> My processor is an mpc8xx and it's seem that the pic driver is
> arch/ppc/syslib/ppc8xx_pic.c
> according to :
> irq_desc[i].chip = &ppc8xx_pic;  (in arch/ppc/syslib/m8xx_setup.c)
> Is this normal that the arch/ppc/syslib/ppc8xx_pic.c is not patch by
> adeos ipipe ?

The patch you are using (adeos-ipipe-2.6.23-ppc-1.6-00.patch) seems to be a 
backport of the patch adeos-ipipe-2.6.23-powerpc-DENX-2.0-03.patch. The 
latter patch fully relies on the new generic IRQ layer.

Maybe, your architecture has slipped away during the backport or maybe there 
is a real reason I do not guess / understand.

> What changes do i need to make in this file ?
>

Once more just an idea: 

It seems like the interrupt controller of the ppc8xx can handle only level / 
edge interrupts; then we can consider adding the following code: 


        for (i = SIU_IRQ_OFFSET ; i < SIU_IRQ_OFFSET + NR_SIU_INTS ; i++)
+#ifdef CONFIG_IPIPE
+       {
+#endif /* !CONFIG_IPIPE */
                irq_desc[i].chip = &ppc8xx_pic;
+#ifdef CONFIG_IPIPE
+               irq_desc[i].ipipe_ack = &__ipipe_ack_level_irq;
+               irq_desc[i].ipipe_end = &__ipipe_end_level_irq;
+       }
+#endif /* !CONFIG_IPIPE */

Furthermore, the file ppc8xx_pic.c should be modified in the same way as 
open_pic.c: 

static void m8xx_mask_irq(unsigned int irq_nr)
{
        int     bit, word;
+       unsigned long flags;

        bit = irq_nr & 0x1f;
        word = irq_nr >> 5;

+       local_irq_save_hw_cond(flags);
+
        ppc_cached_irq_mask[word] &= ~(1 << (31-bit));
        out_be32(&((immap_t *)IMAP_ADDR)->im_siu_conf.sc_simask, 
ppc_cached_irq_mask[word]);
+
+       local_irq_restore_hw_cond(flags);
}

static void m8xx_unmask_irq(unsigned int irq_nr)
{
        int     bit, word;
+       unsigned long flags;

        bit = irq_nr & 0x1f;
        word = irq_nr >> 5;

+       local_irq_save_hw_cond(flags);
+
        ppc_cached_irq_mask[word] |= (1 << (31-bit));
        out_be32(&((immap_t *)IMAP_ADDR)->im_siu_conf.sc_simask, 
ppc_cached_irq_mask[word]);
+
+       local_irq_restore_hw_cond(flags);
}

static void m8xx_end_irq(unsigned int irq_nr)
{
        if (!(irq_desc[irq_nr].status & (IRQ_DISABLED|IRQ_INPROGRESS))
                        && irq_desc[irq_nr].action) {
                int bit, word;
+               unsigned long flags;

                bit = irq_nr & 0x1f;
                word = irq_nr >> 5;

+               local_irq_save_hw_cond(flags);
+

                ppc_cached_irq_mask[word] |= (1 << (31-bit));
                out_be32(&((immap_t *)IMAP_ADDR)->im_siu_conf.sc_simask, 
ppc_cached_irq_mask[word]);
+
+               local_irq_restore_hw_cond(flags);
        }
}


static void m8xx_mask_and_ack(unsigned int irq_nr)
{
        int     bit, word;
+       unsigned long flags;

        bit = irq_nr & 0x1f;
        word = irq_nr >> 5;
+               local_irq_save_hw_cond(flags);
+
        ppc_cached_irq_mask[word] &= ~(1 << (31-bit));
        out_be32(&((immap_t *)IMAP_ADDR)->im_siu_conf.sc_simask, 
ppc_cached_irq_mask[word]);
        out_be32(&((immap_t *)IMAP_ADDR)->im_siu_conf.sc_sipend, 1 << 
(31-bit));
+
+       local_irq_restore_hw_cond(flags);
}

struct hw_interrupt_type ppc8xx_pic = {
        .typename = " 8xx SIU  ",
        .enable = m8xx_unmask_irq,
        .disable = m8xx_mask_irq,
        .ack = m8xx_mask_and_ack,
        .end = m8xx_end_irq,
+#ifdef CONFIG_IPIPE
+       .mask_ack       = m8xx_mask_and_ack,
+       .mask           = m8xx_mask_irq,
+       .unmask         = m8xx_unmask_irq,
+#endif /* CONFIG_IPIPE */
};

Alexis.


