MIME-Version: 1.0
From: Nitin Kulkarni <nitin.kulkarni@mindmusiclabs.com>
Date: Mon, 5 Aug 2019 17:51:01 +0200
Message-ID: <CAPgPmP0HyjmFZ0tVGi=JACZfZe8NM1SyveOO71fC0mKRiig1_g@mail.gmail.com>
Subject: Hard lock up on Raspberry pi 3 when RTDM interrupt from SPI
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
To: xenomai@xenomai.org

Hello,
I am trying to request DMA interrupts in real-time domain. When I request
the irq with rtdm_irq_request(), the irq is successfully registered but at
the first interrupt the system goes into a hard locked state.
I tried the RTDM SPI driver for RPI (spi-bcm2835.c) provided in the Xenomai
upstream,
even that makes the system lock up. I have enabled IPIPE_DEBUG and tried to
see if I get any useful trace but no luck.

GPIO interupts working:
I thought to check if the GPIO interrupts also have same issue but
fortunately the GPIO interrupts work fine.
I suspect (Correct me if I am wrong) it has got to do with the nested irq
controllers in bcm2836 and bcm2837 which makes it different from bcm2835.
The GPIO irqs are not routed through these interrupt controllers I think
and thus the i-pipe patch works fine for bcm2836 as well.

It would be great if someone can throw some light onto this problem. Has
anyone tried to use real-time SPI or DMA on a RPI 3 ? Or if someone can
show some direction in how to fix the irq chips driver it would be very
helpful.

Thanks,
Nitin
