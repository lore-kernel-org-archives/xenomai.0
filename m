MIME-Version: 1.0
References: <e8077dad-f6ae-329a-d7df-a6be28b43b76@arcor.de>
 <de83bb21-4a49-b100-3903-a9842fc84ae1@siemens.com>
In-Reply-To: <de83bb21-4a49-b100-3903-a9842fc84ae1@siemens.com>
From: Greg Gallagher <greg@embeddedgreg.com>
Date: Mon, 21 Mar 2022 08:47:07 -0400
Message-ID: <CALLqZ8QeWqnQO2BiTKLDr5q3eJjMvzg0pmYFNqyfNkKXJ0-UnQ@mail.gmail.com>
Subject: Re: [PATCH] ipipe: noarch: Fix handling of PCIe MSI interrupts for
 dwc PCIe controller
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
Cc: Scott Reed <scott.reed@arcor.de>, xenomai@xenomai.org

On Mon, Mar 21, 2022 at 8:43 AM Jan Kiszka <jan.kiszka@siemens.com> wrote:

> On 18.03.22 17:53, Scott Reed wrote:
> > Handling of PCIe MSI interrupts resulted in system
> > hanging or high latencies.
> >
> > Fix is to replaced missed call to generic_handle_irq with
> > ipipe_handle_irq().
> >
> > Signed-off-by: Scott Reed <scott.reed@arcor.de>
> > ---
> >  drivers/pci/controller/dwc/pcie-designware-host.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c
> b/drivers/pci/controller/dwc/pcie-designware-host.c
> > index c9fd4e4966ba..7b566da64438 100644
> > --- a/drivers/pci/controller/dwc/pcie-designware-host.c
> > +++ b/drivers/pci/controller/dwc/pcie-designware-host.c
> > @@ -100,7 +100,7 @@ irqreturn_t dw_handle_msi_irq(struct pcie_port *pp)
> >                       irq = irq_find_mapping(pp->irq_domain,
> >                                              (i * MAX_MSI_IRQS_PER_CTRL)
> +
> >                                              pos);
> > -                     generic_handle_irq(irq);
> > +                     ipipe_handle_demuxed_irq(irq);
> >                       pos++;
> >               }
> >       }
>
> Thanks, applied to noarch, ipipe/master and stable/4.19.x.
>
> Greg, you can pick up.
>
> Jan
>
> --
> Siemens AG, Technology
> Competence Center Embedded Linux


Testing on arm now, arm64 shortly

-Greg

>
>
