MIME-Version: 1.0
References: <CAPgPmP0HyjmFZ0tVGi=JACZfZe8NM1SyveOO71fC0mKRiig1_g@mail.gmail.com>
 <f8c84c6f-0ff4-c0b8-3382-c72fb34b71c0@xenomai.org>
In-Reply-To: <f8c84c6f-0ff4-c0b8-3382-c72fb34b71c0@xenomai.org>
From: Nitin Kulkarni <nitin.kulkarni@mindmusiclabs.com>
Date: Tue, 6 Aug 2019 16:01:04 +0200
Message-ID: <CAPgPmP1dmTCHTxe_xywBf8M06jZ69CH=_H0RmFkZ9es5LQgLpQ@mail.gmail.com>
Subject: Re: Hard lock up on Raspberry pi 3 when RTDM interrupt from SPI
 peripheral or from DMA is invoked
Content-Type: text/plain; charset="UTF-8"
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Philippe Gerum <rpm@xenomai.org>
Cc: xenomai@xenomai.org

HI Philippe,

I know that I have to take into consideration the dma_engine framework and
adapt the dma backend driver.
Two years back I had written to you about SPI transfers in primary domain
with dma support and we successfully did it for x86 based Upcore
with the help of your valuable inputs given here in this email
https://www.mail-archive.com/xenomai@xenomai.org/msg12223.html
I am trying to implement something similar with I2S this time.

Meanwhile, just to verify if any interrupt from a peripheral in primary
domain is working,
I tried to use the spi rtdm driver for RPI from Xenomai because it uses
rtdm interrupts from the bcm2835 SPI peripheral and it does not use DMA.
Built the rtdm driver with the kernel and tested using the "spitest"
program which is one of the Xenomai utils.
The result is same hard lockup.

So I want to confirm if anyone has successfully used the spi rtdm driver
from xenomai with an RPI 3 (bcm2836 or bcm2837) soc ?
We tried to use it sometime back and faced similar problems, so we just
went ahead with a driver which used polling method instead of using
interrupts for SPI transfers.
My suspicion is with the rtdm interrupts from any of these peripheral
devices (except the gpio chip) for bcm2836 and bcm2837.
In fact, I tried to handle an I2S interrupt in primary domain and even that
one resulted in hard lockup.
Your help is much appreciated.

Thanks
Nitin



On Mon, 5 Aug 2019 at 21:11, Philippe Gerum <rpm@xenomai.org> wrote:

> On 8/5/19 5:51 PM, Nitin Kulkarni via Xenomai wrote:
> > Hello,
> > I am trying to request DMA interrupts in real-time domain. When I request
> > the irq with rtdm_irq_request(), the irq is successfully registered but
> at
> > the first interrupt the system goes into a hard locked state.
> > I tried the RTDM SPI driver for RPI (spi-bcm2835.c) provided in the
> Xenomai
> > upstream,
> > even that makes the system lock up. I have enabled IPIPE_DEBUG and tried
> to
> > see if I get any useful trace but no luck.
> >
> > GPIO interupts working:
> > I thought to check if the GPIO interrupts also have same issue but
> > fortunately the GPIO interrupts work fine.
> > I suspect (Correct me if I am wrong) it has got to do with the nested irq
> > controllers in bcm2836 and bcm2837 which makes it different from bcm2835.
> > The GPIO irqs are not routed through these interrupt controllers I think
> > and thus the i-pipe patch works fine for bcm2836 as well.
> >
> > It would be great if someone can throw some light onto this problem. Has
> > anyone tried to use real-time SPI or DMA on a RPI 3 ? Or if someone can
> > show some direction in how to fix the irq chips driver it would be very
> > helpful.
> >
>
> There are several reasons this cannot work, this is not an irqchip
> issue. Basically, the DMA chip is controlled by the bcm2835-dma.c
> driver, which abides by the generic dmaengine kernel framework. For this
> to work, you would have at least to reserve the DMA channels involved in
> SPI xfers, configure them, and manage the transactions the way the
> bcm2835-dma driver and the framework do for regular operations,
> including proper acknowledge of the DMA events for real-time requests
> directly from primary mode, or propagation of DMA completion/error
> events to regular issuers running in secondary mode. It should also
> include a way to start transfers from primary mode (aka issue_pending
> request in the dmaengine API).
>
> The other - better way - would be to teach dmaengine about the existence
> of a co-kernel context, so that it can handle requests from Cobalt
> threads running in primary mode, along with requests issued from regular
> kernel context.
>
> Because this cannot be done in a generic way with the I-pipe, Xenomai's
> SPI framework does not provide DMA support for any controller (PIO only).
>
> --
> Philippe.
>
