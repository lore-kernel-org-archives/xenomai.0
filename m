MIME-Version: 1.0
References: <20200224063136.11493-1-greg@embeddedgreg.com>
 <2a5c2dd9-dffc-498b-6960-403981960ae4@siemens.com>
 <CALLqZ8ScyEYwzemZTqYo-J0EHoyrtk2iNmrS8Gtdnw-x5TUTZA@mail.gmail.com>
In-Reply-To: <CALLqZ8ScyEYwzemZTqYo-J0EHoyrtk2iNmrS8Gtdnw-x5TUTZA@mail.gmail.com>
From: Greg Gallagher <greg@embeddedgreg.com>
Date: Tue, 25 Feb 2020 01:10:29 -0500
Message-ID: <CALLqZ8SXjtVRdpDpWhZsQAg8MyCdSuVTio_XYmBrhQi8NiNAuQ@mail.gmail.com>
Subject: Re: [PATCH] Fix up the gpio-omap driver so the current version can be
 used with the ipipe.
Content-Type: text/plain; charset="UTF-8"
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: "Xenomai@xenomai.org" <xenomai@xenomai.org>

Hi,

On Mon, Feb 24, 2020 at 10:27 AM Greg Gallagher <greg@embeddedgreg.com> wrote:
>
> Hi,
>
> On Mon, Feb 24, 2020 at 3:17 AM Jan Kiszka <jan.kiszka@siemens.com> wrote:
> >
> > Thanks for fixing this! Some comments, though:
> >
> > The subject should clarify what this is targeting ("arm/ipipe: ...").
> >
> > Then this lacks a commit log, describing why we need that change,
> > possibly also what it roughly does.
> >
> No problem, I thought my message was a little short when I sent it
> out, I'll fix up in V2
>
> > On 24.02.20 07:31, Greg Gallagher via Xenomai wrote:
> > > Signed-off-by: Greg Gallagher <greg@embeddedgreg.com>
> > > ---
> > >   drivers/gpio/gpio-omap.c | 112 +++++++++++++++++++++++++++++----------
> > >   1 file changed, 83 insertions(+), 29 deletions(-)
> > >
> > > diff --git a/drivers/gpio/gpio-omap.c b/drivers/gpio/gpio-omap.c
> > > index 39d25f599831..25355fa7b76b 100644
> > > --- a/drivers/gpio/gpio-omap.c
> > > +++ b/drivers/gpio/gpio-omap.c
> > > @@ -29,6 +29,7 @@
> > >   #include <linux/ipipe.h>
> > >   #include <linux/platform_data/gpio-omap.h>
> > >
> > > +
> >
> > Does this whitespace change get us closer to mainline, or should it
> > rather be removed?
> No, I probably had a print here and was changed when I removed it.  I'll fix up
> >
> > >   #define OFF_MODE    1
> > >   #define OMAP4_GPIO_DEBOUNCINGTIME_MASK 0xFF
> > >
> > > @@ -61,10 +62,11 @@ struct gpio_bank {
> > >       u32 toggle_mask;
> > >   #ifdef CONFIG_IPIPE
> > >       ipipe_spinlock_t lock;
> > > +     ipipe_spinlock_t wa_lock;
> > >   #else
> > >       raw_spinlock_t lock;
> > > -#endif
> > >       raw_spinlock_t wa_lock;
> > > +#endif
> > >       struct gpio_chip chip;
> > >       struct clk *dbck;
> > >       u32 mod_usage;
> > > @@ -575,18 +577,9 @@ static int omap_gpio_irq_type(struct irq_data *d, unsigned type)
> > >               goto error;
> > >       }
> > >       raw_spin_unlock_irqrestore(&bank->lock, flags);
> > > -
> > > -     if (type & (IRQ_TYPE_LEVEL_LOW | IRQ_TYPE_LEVEL_HIGH))
> > > -             irq_set_handler_locked(d, handle_level_irq);
> > > -     else if (type & (IRQ_TYPE_EDGE_FALLING | IRQ_TYPE_EDGE_RISING))
> > > -             /*
> > > -              * Edge IRQs are already cleared/acked in irq_handler and
> > > -              * not need to be masked, as result handle_edge_irq()
> > > -              * logic is excessed here and may cause lose of interrupts.
> > > -              * So just use handle_simple_irq.
> > > -              */
> > > -             irq_set_handler_locked(d, handle_simple_irq);
> > > -
> > > +
> > > +     irq_set_handler_locked(d, handle_level_irq);
> > > +
> > >       return 0;
> > >
> > >   error:
> > > @@ -745,12 +738,15 @@ static void omap_gpio_free(struct gpio_chip *chip, unsigned offset)
> > >   static void __omap_gpio_irq_handler(struct gpio_bank *bank)
> > >   {
> > >       void __iomem *isr_reg = NULL;
> > > +     void __iomem *enabled_reg = NULL;
> > >       u32 enabled, isr, level_mask;
> > >       unsigned int bit;
> > >       unsigned long wa_lock_flags;
> > >       unsigned long lock_flags;
> > >
> > >       isr_reg = bank->base + bank->regs->irqstatus;
> > > +     enabled_reg = bank->base + bank->regs->irqenable;
> > > +
> > >       if (WARN_ON(!isr_reg))
> > >               return;
> > >
> > > @@ -759,7 +755,6 @@ static void __omap_gpio_irq_handler(struct gpio_bank *bank)
> > >
> > >               enabled = omap_get_gpio_irqbank_mask(bank);
> > >               isr = readl_relaxed(isr_reg) & enabled;
> > > -
> >
> > Same questions on whitespace change here.
> Same as above, I'll fix up
> >
> > >               if (bank->level_mask)
> > >                       level_mask = bank->level_mask & enabled;
> > >               else
> > > @@ -809,7 +804,10 @@ static void __omap_gpio_irq_handler(struct gpio_bank *bank)
> > >   static void omap_gpio_irq_handler(struct irq_desc *d)
> > >   {
> > >       struct gpio_bank *bank = irq_desc_get_handler_data(d);
> > > +
> > > +     d->irq_data.chip->irq_ack(&d->irq_data);
> > >       __omap_gpio_irq_handler(bank);
> > > +     d->irq_data.chip->irq_unmask(&d->irq_data);
> > >   }
> > >
> > >   #else
> > > @@ -896,39 +894,31 @@ static void omap_gpio_ack_irq(struct irq_data *d)
> > >       omap_clear_gpio_irqstatus(bank, offset);
> > >   }
> > >
> > > -static void omap_gpio_mask_irq(struct irq_data *d)
> > > +static void __omap_gpio_mask_irq(struct irq_data *d)
> > >   {
> > >       struct gpio_bank *bank = omap_irq_data_get_bank(d);
> > >       unsigned offset = d->hwirq;
> > > -     unsigned long flags;
> > >
> > > -     raw_spin_lock_irqsave(&bank->lock, flags);
> > > -     omap_set_gpio_triggering(bank, offset, IRQ_TYPE_NONE);
> > >       omap_set_gpio_irqenable(bank, offset, 0);
> > > -     raw_spin_unlock_irqrestore(&bank->lock, flags);
> > > +     omap_set_gpio_triggering(bank, offset, IRQ_TYPE_NONE);
> > >   }
> > >
> > > -static void omap_gpio_mask_ack_irq(struct irq_data *d)
> > > +static void __omap_gpio_mask_ack_irq(struct irq_data *d)
> > >   {
> > >       struct gpio_bank *bank = omap_irq_data_get_bank(d);
> > >       unsigned offset = d->hwirq;
> > > -     unsigned long flags;
> > > -
> > > -     raw_spin_lock_irqsave(&bank->lock, flags);
> > > +
> > >       omap_set_gpio_irqenable(bank, offset, 0);
> > >       omap_set_gpio_triggering(bank, offset, IRQ_TYPE_NONE);
> > > -     omap_clear_gpio_irqstatus(bank, offset);
> > > -     raw_spin_unlock_irqrestore(&bank->lock, flags);
> > > +
> > >   }
> > >
> > > -static void omap_gpio_unmask_irq(struct irq_data *d)
> > > +static void __omap_gpio_unmask_irq(struct irq_data *d)
> > >   {
> > >       struct gpio_bank *bank = omap_irq_data_get_bank(d);
> > >       unsigned offset = d->hwirq;
> > >       u32 trigger = irqd_get_trigger_type(d);
> > > -     unsigned long flags;
> > >
> > > -     raw_spin_lock_irqsave(&bank->lock, flags);
> > >       omap_set_gpio_irqenable(bank, offset, 1);
> > >
> > >       /*
> > > @@ -943,9 +933,69 @@ static void omap_gpio_unmask_irq(struct irq_data *d)
> > >       if (trigger)
> > >               omap_set_gpio_triggering(bank, offset, trigger);
> > >
> > > +}
> > > +
> > > +static void omap_gpio_mask_irq(struct irq_data *d)
> > > +{
> > > +     struct gpio_bank *bank = omap_irq_data_get_bank(d);
> > > +     unsigned long flags;
> > > +
> > > +     raw_spin_lock_irqsave(&bank->lock, flags);
> > > +     ipipe_lock_irq(d->irq);
> > > +     __omap_gpio_mask_irq(d);
> > > +     raw_spin_unlock_irqrestore(&bank->lock, flags);
> > > +}
> > > +
> > > +static void omap_gpio_mask_ack_irq(struct irq_data *d)
> > > +{
> > > +     struct gpio_bank *bank = omap_irq_data_get_bank(d);
> > > +     unsigned long flags;
> > > +
> > > +     raw_spin_lock_irqsave(&bank->lock, flags);
> > > +     __omap_gpio_mask_ack_irq(d);
> > > +     ipipe_lock_irq(d->irq);
> > >       raw_spin_unlock_irqrestore(&bank->lock, flags);
> > >   }
> > >
> > > +static void omap_gpio_unmask_irq(struct irq_data *d)
> > > +{
> > > +     struct gpio_bank *bank = omap_irq_data_get_bank(d);
> > > +     unsigned long flags;
> > > +     void __iomem *enabled_reg = NULL;
> > > +
> > > +     raw_spin_lock_irqsave(&bank->lock, flags);
> > > +     __omap_gpio_unmask_irq(d);
> > > +     ipipe_unlock_irq(d->irq);
> > > +     raw_spin_unlock_irqrestore(&bank->lock, flags);
> > > +     enabled_reg = bank->base + bank->regs->irqenable;
> > > +}
> > > +
> > > +
> > > +
> > > +#ifdef CONFIG_IPIPE
> > > +
> > > +static void omap_gpio_irq_hold(struct irq_data *d)
> > > +{
> > > +     struct gpio_bank *bank = omap_irq_data_get_bank(d);
> > > +     unsigned long flags;
> > > +
> > > +     raw_spin_lock_irqsave(&bank->lock, flags);
> > > +     __omap_gpio_mask_ack_irq(d);
> > > +     raw_spin_unlock_irqrestore(&bank->lock, flags);
> > > +}
> > > +
> > > +static void omap_gpio_irq_release(struct irq_data *d)
> > > +{
> > > +     struct gpio_bank *bank = omap_irq_data_get_bank(d);
> > > +     unsigned long flags;
> > > +
> > > +     raw_spin_lock_irqsave(&bank->lock, flags);
> > > +     __omap_gpio_unmask_irq(d);
> > > +     raw_spin_unlock_irqrestore(&bank->lock, flags);
> > > +}
> > > +
> > > +#endif
> > > +
> > >   /*---------------------------------------------------------------------*/
> > >
> > >   static int omap_mpuio_suspend_noirq(struct device *dev)
> > > @@ -1240,7 +1290,7 @@ static int omap_gpio_chip_init(struct gpio_bank *bank, struct irq_chip *irqc)
> > >
> > >       irq = &bank->chip.irq;
> > >       irq->chip = irqc;
> > > -     irq->handler = handle_bad_irq;
> > > +     irq->handler = handle_level_irq;
> >
> > Is this intentional?
> Yes, this is what was causing the warn to be printed in the earlier
> versions of the ipipe, we need to use the level flow handler.  Looking
> at it now I think I need to do a ifdef on CONFIG_IPIPE,
> there's another spot in here that I should change to that as well.
> I'll fix up tonight in V2.
>
> >
> > >       irq->default_type = IRQ_TYPE_NONE;
> > >       irq->num_parents = 1;
> > >       irq->parents = &bank->irq;
> > > @@ -1303,6 +1353,10 @@ static int omap_gpio_probe(struct platform_device *pdev)
> > >       irqc->irq_mask = omap_gpio_mask_irq,
> > >       irqc->irq_mask_ack = omap_gpio_mask_ack_irq,
> > >       irqc->irq_unmask = omap_gpio_unmask_irq,
> > > +#ifdef CONFIG_IPIPE
> > > +     irqc->irq_hold = omap_gpio_irq_hold,
> > > +     irqc->irq_release = omap_gpio_irq_release,
> > > +#endif
> > >       irqc->irq_set_type = omap_gpio_irq_type,
> > >       irqc->irq_set_wake = omap_gpio_wake_enable,
> > >       irqc->irq_bus_lock = omap_gpio_irq_bus_lock,
> > >
> >
> > Jan
> >
> > --
> > Siemens AG, Corporate Technology, CT RDA IOT SES-DE
> > Corporate Competence Center Embedded Linux

If anyone is looking to try this patch out, it's located here:

git://lab@xenomai.org:2322/ipipe-greg.git
branch:  omap_gpio_irq_fix

I'll send this patch out over again, since I've updated my ipipe tree.

