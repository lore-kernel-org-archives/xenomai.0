Message-ID: <f8f856500712200558t1ba75d98l11237f8c7cc76f01@domain.hid>
Date: Thu, 20 Dec 2007 14:58:56 +0100
From: fabien <fabien.fb@domain.hid>
In-Reply-To: <200712200206.59253.berlemont.hauw@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <f8f856500712180507q16d5c21bp56b45ec23ae5d36@domain.hid>
	<200712190119.11578.berlemont.hauw@domain.hid>
	<f8f856500712190529q34efcf75r4d80c22bb987cc8@domain.hid>
	<200712200206.59253.berlemont.hauw@domain.hid>
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
To: Alexis Berlemont <berlemont.hauw@domain.hid>
Cc: xenomai@xenomai.org

Hi,

2007/12/20, Alexis Berlemont <berlemont.hauw@domain.hid>:
> Hi,
>
> >
> > I've check in the adeos_ipipe patch that open_pic.c, ppc4xx_pic.c and
> > ipiq.c are patched.
> > My processor is an mpc8xx and it's seem that the pic driver is
> > arch/ppc/syslib/ppc8xx_pic.c
> > according to :
> > irq_desc[i].chip = &ppc8xx_pic;  (in arch/ppc/syslib/m8xx_setup.c)
> > Is this normal that the arch/ppc/syslib/ppc8xx_pic.c is not patch by
> > adeos ipipe ?
>
> The patch you are using (adeos-ipipe-2.6.23-ppc-1.6-00.patch) seems to be a
> backport of the patch adeos-ipipe-2.6.23-powerpc-DENX-2.0-03.patch. The
> latter patch fully relies on the new generic IRQ layer.
>
> Maybe, your architecture has slipped away during the backport or maybe there
> is a real reason I do not guess / understand.
>
> > What changes do i need to make in this file ?
> >
>
> Once more just an idea:
>
> It seems like the interrupt controller of the ppc8xx can handle only level /
> edge interrupts; then we can consider adding the following code:
>
>
>         for (i = SIU_IRQ_OFFSET ; i < SIU_IRQ_OFFSET + NR_SIU_INTS ; i++)
> +#ifdef CONFIG_IPIPE
> +       {
> +#endif /* !CONFIG_IPIPE */
>                 irq_desc[i].chip = &ppc8xx_pic;
> +#ifdef CONFIG_IPIPE
> +               irq_desc[i].ipipe_ack = &__ipipe_ack_level_irq;
> +               irq_desc[i].ipipe_end = &__ipipe_end_level_irq;
> +       }
> +#endif /* !CONFIG_IPIPE */
>
> Furthermore, the file ppc8xx_pic.c should be modified in the same way as
> open_pic.c:
>
> static void m8xx_mask_irq(unsigned int irq_nr)
> {
>         int     bit, word;
> +       unsigned long flags;
>
>         bit = irq_nr & 0x1f;
>         word = irq_nr >> 5;
>
> +       local_irq_save_hw_cond(flags);
> +
>         ppc_cached_irq_mask[word] &= ~(1 << (31-bit));
>         out_be32(&((immap_t *)IMAP_ADDR)->im_siu_conf.sc_simask,
> ppc_cached_irq_mask[word]);
> +
> +       local_irq_restore_hw_cond(flags);
> }
>
> static void m8xx_unmask_irq(unsigned int irq_nr)
> {
>         int     bit, word;
> +       unsigned long flags;
>
>         bit = irq_nr & 0x1f;
>         word = irq_nr >> 5;
>
> +       local_irq_save_hw_cond(flags);
> +
>         ppc_cached_irq_mask[word] |= (1 << (31-bit));
>         out_be32(&((immap_t *)IMAP_ADDR)->im_siu_conf.sc_simask,
> ppc_cached_irq_mask[word]);
> +
> +       local_irq_restore_hw_cond(flags);
> }
>
> static void m8xx_end_irq(unsigned int irq_nr)
> {
>         if (!(irq_desc[irq_nr].status & (IRQ_DISABLED|IRQ_INPROGRESS))
>                         && irq_desc[irq_nr].action) {
>                 int bit, word;
> +               unsigned long flags;
>
>                 bit = irq_nr & 0x1f;
>                 word = irq_nr >> 5;
>
> +               local_irq_save_hw_cond(flags);
> +
>
>                 ppc_cached_irq_mask[word] |= (1 << (31-bit));
>                 out_be32(&((immap_t *)IMAP_ADDR)->im_siu_conf.sc_simask,
> ppc_cached_irq_mask[word]);
> +
> +               local_irq_restore_hw_cond(flags);
>         }
> }
>
>
> static void m8xx_mask_and_ack(unsigned int irq_nr)
> {
>         int     bit, word;
> +       unsigned long flags;
>
>         bit = irq_nr & 0x1f;
>         word = irq_nr >> 5;
> +               local_irq_save_hw_cond(flags);
> +
>         ppc_cached_irq_mask[word] &= ~(1 << (31-bit));
>         out_be32(&((immap_t *)IMAP_ADDR)->im_siu_conf.sc_simask,
> ppc_cached_irq_mask[word]);
>         out_be32(&((immap_t *)IMAP_ADDR)->im_siu_conf.sc_sipend, 1 <<
> (31-bit));
> +
> +       local_irq_restore_hw_cond(flags);
> }
>
> struct hw_interrupt_type ppc8xx_pic = {
>         .typename = " 8xx SIU  ",
>         .enable = m8xx_unmask_irq,
>         .disable = m8xx_mask_irq,
>         .ack = m8xx_mask_and_ack,
>         .end = m8xx_end_irq,
> +#ifdef CONFIG_IPIPE
> +       .mask_ack       = m8xx_mask_and_ack,
> +       .mask           = m8xx_mask_irq,
> +       .unmask         = m8xx_unmask_irq,
> +#endif /* CONFIG_IPIPE */
> };
>
> Alexis.
>

Thanks Alexis for the help
Ok i've done these modifications in mpc8xx_setup.c and ppc8xx_pic.c.
But it's seems the problem occurs when the kernels needs to ack an IT
on the CPM :

Freeing unused kernel memory: 88k init
Launch a shell /bin/sh


irq = 20, @desc= C020C410, @desc->ipipe_ack= 0
Chip name =  CPM
Oops: kernel access of bad area, sig: 11 [#1]
NIP: 00000000 LR: c0005890 CTR: 00000000
REGS: c0221c00 TRAP: 0400   Not tainted  (2.6.23.6)
MSR: 40001032 <ME,IR,DR>  CR: 24004024  XER: 00000000
TASK = c0feec00[13] 'sh' THREAD: c0220000
GPR00: c000587c c0221cb0 c0feec00 00000014 c020c410 00000001 00000000 ff0028e0
GPR08: fdfff830 c020cbc0 00000001 c0210000 00000001 0281af08 00ffe000 007fff14
GPR16: 00000000 00000001 c01f0000 c0210000 c0230000 00000002 c0109390 c0f4500c
GPR24: 0000003d c02167cc 00000014 00000000 c020c410 c020bec0 00000014 c0240b40
NIP [00000000] 0x0
LR [c0005890] __ipipe_ack_irq+0x64/0x7c
Call Trace:
[c0221cb0] [c000587c] __ipipe_ack_irq+0x50/0x7c (unreliable)
[c0221cd0] [c0005be0] __ipipe_handle_irq+0x124/0x140
[c0221d00] [c0005e14] __ipipe_grab_irq+0x3c/0xac
[c0221d20] [c0003154] __ipipe_ret_from_except+0x0/0xc
[c0221de0] [c0111dec] cpm_uart_start_tx+0x38/0xa8
[c0221e00] [c010d62c] __uart_start+0x64/0x74
[c0221e10] [c010e670] uart_start+0x30/0x4c
...

So in commproc.c in cpm_interrupt_init(void) I add the same :
        for ( i = CPM_IRQ_OFFSET ; i < CPM_IRQ_OFFSET + NR_CPM_INTS ; i++ ) {
                irq_desc[i].chip = &cpm_pic;
+		#ifdef CONFIG_IPIPE
+	               irq_desc[i].ipipe_ack = &__ipipe_ack_level_irq;
+        	       irq_desc[i].ipipe_end = &__ipipe_end_level_irq;
+		#endif
         }

Now the kernel is hanging (see the log below) in an inline fonction in chip.c :
static inline void mask_ack_irq(struct irq_desc *desc, int irq)
called by void fastcall __ipipe_ack_level_irq(unsigned irq, struct
irq_desc *desc) in the same file.

Freeing unused kernel memory: 88k init
Launch a shell /bin/sh

irq = 20, @desc= C020C410, @desc->ipipe_ack= C00374C0
Chip name =  CPM
Dans chip.c : mack_ack_irq : desc->chip->mask = 0
Dans chip.c : mack_ack_irq : desc->chip->ack = C012B8CC
Oops: kernel access of bad area, sig: 11 [#1]
NIP: 00000000 LR: c0037558 CTR: 00000000
REGS: c0221bf0 TRAP: 0400   Not tainted  (2.6.23.6)
MSR: 40001032 <ME,IR,DR>  CR: 24004024  XER: 00000000
TASK = c0feec00[13] 'sh' THREAD: c0220000
GPR00: c0037544 c0221ca0 c0feec00 00000014 00000001 00000001 00000000 ff0028c0
GPR08: fdfff828 00000000 00000001 c0210000 00000001 0281af08 00ffe000 007fff14
GPR16: 00000000 00000001 c01f0000 c0210000 c0230000 00000002 c0109390 c0f4500c
GPR24: 0000003d c02167cc 00000014 c00374c0 c020c410 c020bec0 00000014 c020c410
NIP [00000000] 0x0
LR [c0037558] __ipipe_ack_level_irq+0x98/0xc0
Call Trace:
[c0221ca0] [c0037544] __ipipe_ack_level_irq+0x84/0xc0 (unreliable)
[c0221cb0] [c0005890] __ipipe_ack_irq+0x64/0x7c
[c0221cd0] [c0005be0] __ipipe_handle_irq+0x124/0x140
...
desc->chip->mask  is a null pointer, so i tried to add in commproc.c
in cpm_pic struct the following :
struct hw_interrupt_type cpm_pic = {
	.typename	= " CPM      ",
	.enable		= cpm_unmask_irq,
	.disable	= cpm_mask_irq,
	.ack		= cpm_ack,
	.end		= cpm_eoi,

+       #ifdef CONFIG_IPIPE
+	.mask           = cpm_mask_irq,
+	.unmask         = cpm_unmask_irq,
+	#endif  CONFIG_IPIPE
}

Freeing unused kernel memory: 88k init
Launch a shell /bin/sh


irq = 20, @desc= C020C410, @desc->ipipe_ack= C00374C0
Chip name =  CPM
Dans chip.c : mack_ack_irq : desc->chip->mask = C012BED0
Dans chip.c : mack_ack_irq : desc->chip->ack = C012B8CC
BusyBox v1.8.1 (2007-12-10 13:06
(no more logs)

If i remove (in order to test) desc->chip->mask(irq) and just leave
desc->chip->ack (irq) it's ok i get my shell in busybox. So it's seems
behind the mask an ack, there is no unmask done...
indeed if i add desc->chip->unmask(irq); after in mask_ack_irq(...) i
get the shell.

Any ideas ?
Best regards
Fab

