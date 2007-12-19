Message-ID: <f8f856500712190529q34efcf75r4d80c22bb987cc8@domain.hid>
Date: Wed, 19 Dec 2007 14:29:23 +0100
From: fabien <fabien.fb@domain.hid>
In-Reply-To: <200712190119.11578.berlemont.hauw@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <f8f856500712180507q16d5c21bp56b45ec23ae5d36@domain.hid>
	<200712190119.11578.berlemont.hauw@domain.hid>
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

hello, first thanks for your answer Alexis
I tried to add as you said
+       ipd->irqs[irq].acknowledge = ipipe_root_domain->irqs[irq].acknowledge;
in kernel/ipipe/core.c and my kernel boot now properly.

I've check in the adeos_ipipe patch that open_pic.c, ppc4xx_pic.c and
ipiq.c are patched.
My processor is an mpc8xx and it's seem that the pic driver is
arch/ppc/syslib/ppc8xx_pic.c
according to :
irq_desc[i].chip = &ppc8xx_pic;  (in arch/ppc/syslib/m8xx_setup.c)
Is this normal that the arch/ppc/syslib/ppc8xx_pic.c is not patch by
adeos ipipe ?
What changes do i need to make in this file ?

Best regards

2007/12/19, Alexis Berlemont <berlemont.hauw@domain.hid>:
> Hi,
>
> >
> >
> > Oops: kernel access of bad area, sig: 11 [#1]
> > NIP: 00000000 LR: c0005854 CTR: 00000000
> > REGS: c0fefc10 TRAP: 0400   Not tainted  (2.6.23.6)
> > MSR: 40001032 <ME,IR,DR>  CR: 24004028  XER: 00000000
> > TASK = c0f99030[12] 'sh' THREAD: c0fee000
> > GPR00: 00000000 c0fefcc0 c0f99030 00000014 c01ce410 00100000 00000000
> > 00000000 GPR08: 00000000 c01cdec0 c01cec10 c01cebc0 c0fee1f0 cfefffff
> > 00ffe000 007fff14 GPR16: 00000000 00000001 c01b0000 c01d0000 c01f0000
> > 00000002 c00d09a4 c0f4600c GPR24: 0000003d c01d7b9c 000001b0 00000000
> > 00000140 c0200a44 00000014 c0200a40 NIP [00000000] 0x0
> > LR [c0005854] __ipipe_ack_irq+0x28/0x3c
> > Call Trace:
> > [c0fefcc0] [c0200a44] 0xc0200a44 (unreliable)
> > [c0fefcd0] [c0005ba0] __ipipe_handle_irq+0x124/0x140
> > [c0fefd00] [c0005dd4] __ipipe_grab_irq+0x3c/0xac
> > [c0fefd20] [c0003154] __ipipe_ret_from_except+0x0/0xc
> > [c0fefde0] [c00d9400] cpm_uart_start_tx+0x38/0xa8
> > [c0fefe00] [c00d4c40] __uart_start+0x64/0x74
> > [c0fefe10] [c00d5c84] uart_start+0x30/0x4c
> > [c0fefe30] [c00d5d9c] uart_write+0xf8/0x130
> > [c0fefe60] [c00d0bac] write_chan+0x208/0x3a4
> > [c0fefeb0] [c00cd530] tty_write+0x170/0x238
> > [c0fefef0] [c0056128] vfs_write+0xcc/0x108
> > [c0feff10] [c0056a94] sys_write+0x4c/0x90
> > [c0feff40] [c0002900] ret_from_syscall+0x0/0x38
>
> Just an idea which may lead to nowhere... :
>
> Considering this oops, we might guess the bug occured in __ipipe_ack_irq(), in
> this function we may have called NULL function pointer (NIP == NULL).
>
> After having a look at this function's content:
>
> int __ipipe_ack_irq(unsigned irq)
> {
>         irq_desc_t *desc = irq_desc + irq;
>         desc->ipipe_ack(irq, desc);
>         return 1;
> }
>
> it seems the field "ipipe_ack" of the irq descriptor was not properly filled
> at initialization time. Therefore a piece of code like the one below is
> missing in your IRQ setup function.
>
>         /* Init descriptors */
> -       for (i = offset; i < NumSources + offset; i++)
> +       for (i = offset; i < NumSources + offset; i++) {
>                 irq_desc[i].chip = &open_pic;
> +#ifdef CONFIG_IPIPE
> +               /* We want mask_ack/unmask for all. */
> +               irq_desc[i].ipipe_ack = &__ipipe_ack_level_irq;
> +               irq_desc[i].ipipe_end = &__ipipe_end_level_irq;
> +#endif
> +       }
>
> In order to test we are in the right way , you can make an ugly modification
> in the function ipipe_virtualize_irq() in kernel/ipipe/core.c:
>
>         ipd->irqs[irq].handler = handler;
>         ipd->irqs[irq].cookie = cookie;
> -       ipd->irqs[irq].acknowledge = acknowledge;
> +       ipd->irqs[irq].acknowledge = ipipe_root_domain->irqs[irq].acknowledge;
>         ipd->irqs[irq].control = modemask;
>
> Thanks to this change, you will not go through __ipipe_ack_irq().
>
> I hope I have not said too much rubbish...
>
> Alexis.
>
>
> _______________________________________________
> Xenomai-help mailing list
> Xenomai-help@domain.hid
> https://mail.gna.org/listinfo/xenomai-help
>

