Date: Tue, 29 Nov 2011 14:09:05 +0100 (CET)
From: "Jan Kiszka" <Jan.Kiszka@domain.hid>
Message-ID: <1042929394.26817.1322572145480.JavaMail.fmail@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [Adeos-main] Fasteoi unmasking issue
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/options/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: </public/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: Wolfgang Mauerer <wolfgang.mauerer@domain.hid>, adeos-main <adeos-main@gna.org>
Cc: "Kiszka, Jan" <jan.kiszka@domain.hid>, Philippe Gerum <rpm@xenomai.org>, "Hillier, Gernot" <gernot.hillier@domain.hid>

[ Sorry in advance, only have webmail access ATM. ]

> The problem seems to be caused by unmasking the IRQ in
> handle_fasteoi_irq(), and with a hack along the lines of
>
> --- a/kernel/irq/chip.c
> +++ b/kernel/irq/chip.c
> @@ -586,7 +586,8 @@ handle_fasteoi_irq(unsigned int irq, struct irq_desc
> *desc)
> raw_spin_lock(&desc->lock);
> desc->status &= ~IRQ_INPROGRESS;
> #ifdef CONFIG_IPIPE
> - desc->irq_data.chip->irq_unmask(&desc->irq_data);
> + if (irq != WHICHEVER_IRQ_CAUSES_THE_STORM)
> + desc->irq_data.chip->irq_unmask(&desc->irq_data);
> out:
> #else
> out:
>
> the issue is solved.
>
> So the question is: Why is it okay to unconditionally unmask
> all interrupts in the fasteoi handler? All cards that re-send
> interrupts at high frequencies unless they are properly handled
> by their device driver should cause the same problem.
> I take the early unmasking is an optimisation, or are there any
> further reasons for the unconditional unmasking in
> handle_fasteoi_irq()?
>

It think the proper fix is to check for IRQD_IRQ_MASKED and only unmask the line if it isn't masked from Linux' perspective. That should be a long pending i-pipe bug, surfaced by the IRQ thread mask flow that (not only) KVM's device assignment code depends on. Can you give this a try as well?

Thanks for digging out the reason!

Cheers from Schiphol,
Jan

___________________________________________________________
SMS schreiben mit WEB.DE FreeMail - einfach, schnell und
kostenguenstig. Jetzt gleich testen! http://f.web.de/?mc=021192

