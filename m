Message-ID: <53FCEE2D.20903@xenomai.org>
Date: Tue, 26 Aug 2014 22:29:33 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <c5ed31c30d6a4dcb92fb91e183b38db0@CVEX13.valentin-carl.de>
In-Reply-To: <c5ed31c30d6a4dcb92fb91e183b38db0@CVEX13.valentin-carl.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] SPI tx underflow interrupt not available
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "Reitinger, Peter" <preitinger@carl-valentin.de>, "xenomai@xenomai.org" <xenomai@xenomai.org>

On 08/26/2014 04:24 PM, Reitinger, Peter wrote:
> Dear Xenomai people,
> 
> 
> I am currently trying to write an SPI slave rtdm driver with fifo and dma support. I would like to receive an interrupt if there is an underflow in the tx fifo.
> 
> Therefore I try to request the related hardware interrupt (which is irq 125 at my emtrion board which has EDMA and 2 McSPI interfaces where I am trying McSPI1).

Are you sure the irq number is 125? If 125 is a "physical" irq number,
it is almost probably not the number you should pass to
rtdm_irq_request. Have you tried requesting it as a Linux interrupt?

>
> Unfortunately it seems that interrupt 125 is reserved by another linux
driver because a list of /proc/irq/125 shows:
>
> root@dimm-am335x:/proc# ls /proc/irq/125
> 53100000.sham  spurious

Have you tried grepping "sham" in the kernel sources?

-- 
                                                                Gilles.

