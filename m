MIME-Version: 1.0
References: <20200424114130.5881-1-laurentiu.duca@gmail.com>
 <37f5120d-7a5a-5eaa-630c-005dc77bdc90@siemens.com>
 <CAPm8-H7MEuEPsGdWWpb4taqBpfdOmWHPLqyM7BJHXCk4MzgQTA@mail.gmail.com>
In-Reply-To: <CAPm8-H7MEuEPsGdWWpb4taqBpfdOmWHPLqyM7BJHXCk4MzgQTA@mail.gmail.com>
From: Laurentiu-Cristian Duca <laurentiu.duca@gmail.com>
Date: Fri, 24 Apr 2020 20:39:41 +0300
Message-ID: <CAPm8-H5MU4FozQwE_noqFYYu_RZL_11rmuHyny-5qRDdsps90g@mail.gmail.com>
Subject: Fwd: [PATCH] Avoid a possible too early interrupt from the omap mcSPI
 controller
Content-Type: text/plain; charset="UTF-8"
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai <xenomai@xenomai.org>

---------- Forwarded message ---------
From: Laurentiu-Cristian Duca <laurentiu.duca@gmail.com>
Date: Fri, Apr 24, 2020, 20:38
Subject: Re: [PATCH] Avoid a possible too early interrupt from the omap
mcSPI controller
To: Jan Kiszka <jan.kiszka@siemens.com>


In Xenomai the issue did not happen in my tests. It happened in the
preempt_rt port of the Xenomai omap4 mcSPI real time driver.

On Fri, Apr 24, 2020, 20:24 Jan Kiszka <jan.kiszka@siemens.com> wrote:

> On 24.04.20 13:41, Laurentiu-Cristian Duca via Xenomai wrote:
> > In order to avoid a possible too early interrupt
> > from the omap mcSPI controller,
> > disable interrupts before writing the number of bytes from the SPI
> message
> > that fill up the omap mcSPI controller queue,
> > and enable interrupts after that.
> >
> > Signed-off-by: Laurentiu-Cristian Duca <laurentiu.duca@gmail.com>
> > ---
> >   kernel/drivers/spi/spi-omap2-mcspi-rt.c | 28 ++++++++++++++++++++++++-
> >   1 file changed, 27 insertions(+), 1 deletion(-)
> >
> > diff --git a/kernel/drivers/spi/spi-omap2-mcspi-rt.c
> b/kernel/drivers/spi/spi-omap2-mcspi-rt.c
> > index a7a005b22..03678b991 100644
> > --- a/kernel/drivers/spi/spi-omap2-mcspi-rt.c
> > +++ b/kernel/drivers/spi/spi-omap2-mcspi-rt.c
> > @@ -149,6 +149,7 @@ struct spi_master_omap2_mcspi {
> >       int rx_len;
> >       int fifo_depth;
> >       rtdm_event_t transfer_done;
> > +     rtdm_lock_t lock;
> >       unsigned int pin_dir:1;
> >       struct omap2_mcspi_cs cs[OMAP2_MCSPI_CS_N];
> >       /* logging */
> > @@ -421,6 +422,26 @@ static void mcspi_wr_fifo(struct
> spi_master_omap2_mcspi *spim, int cs_id)
> >       }
> >   }
> >
> > +static void mcspi_wr_fifo_bh(struct spi_master_omap2_mcspi *spim, int
> cs_id)
> > +{
> > +     u8 byte;
> > +     int i;
> > +     rtdm_lockctx_t c;
> > +
> > +     rtdm_lock_get_irqsave(&spim->lock, c);
> > +
> > +     for (i = 0; i < spim->fifo_depth; i++) {
> > +             if (spim->tx_len <= 0)
> > +                     byte = 0;
> > +             else
> > +                     byte = spim->tx_buf ? *spim->tx_buf++ : 0;
> > +             mcspi_wr_cs_reg(spim, cs_id, OMAP2_MCSPI_TX0, byte);
> > +             spim->tx_len--;
> > +     }
> > +
> > +     rtdm_lock_put_irqrestore(&spim->lock, c);
> > +}
> > +
> >   static int omap2_mcspi_interrupt(rtdm_irq_t *irqh)
> >   {
> >       struct spi_master_omap2_mcspi *spim;
> > @@ -428,6 +449,8 @@ static int omap2_mcspi_interrupt(rtdm_irq_t *irqh)
> >       int i, cs_id = 0;
> >
> >       spim = rtdm_irq_get_arg(irqh, struct spi_master_omap2_mcspi);
> > +     rtdm_lock_get(&spim->lock);
> > +
> >       for (i = 0; i < OMAP2_MCSPI_CS_N; i++)
> >               if (spim->cs[i].chosen) {
> >                       cs_id = i;
> > @@ -459,6 +482,8 @@ static int omap2_mcspi_interrupt(rtdm_irq_t *irqh)
> >               rtdm_event_signal(&spim->transfer_done);
> >       }
> >
> > +     rtdm_lock_put(&spim->lock);
> > +
> >       return RTDM_IRQ_HANDLED;
> >   }
> >
> > @@ -572,7 +597,7 @@ static int do_transfer_irq_bh(struct
> rtdm_spi_remote_slave *slave)
> >       mcspi_wr_reg(spim, OMAP2_MCSPI_IRQENABLE, l);
> >
> >       /* TX_EMPTY will be raised only after data is transfered */
> > -     mcspi_wr_fifo(spim, slave->chip_select);
> > +     mcspi_wr_fifo_bh(spim, slave->chip_select);
> >
> >       /* wait for transfer completion */
> >       ret = rtdm_event_wait(&spim->transfer_done);
> > @@ -905,6 +930,7 @@ static int omap2_mcspi_probe(struct platform_device
> *pdev)
> >
> >       spim = container_of(master, struct spi_master_omap2_mcspi, master);
> >       rtdm_event_init(&spim->transfer_done, 0);
> > +     rtdm_lock_init(&spim->lock);
> >
> >       spim->pin_dir = pin_dir;
> >       r = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> >
>
> Thanks, applied.
>
> Did you see the issue in reality or did you identify it as "can
> potentially happen"?
>
> Jan
>
> --
> Siemens AG, Corporate Technology, CT RDA IOT SES-DE
> Corporate Competence Center Embedded Linux
>
