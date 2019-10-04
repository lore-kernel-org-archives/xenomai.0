Subject: Re: [PATCH] MABC RTNet driver to work with GEM hardware
References: <b7f-5d95b480-63-344a2840@235496508>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <b9426b71-af60-eeac-dba3-3d5b5baedbe1@siemens.com>
Date: Fri, 4 Oct 2019 15:40:12 +0200
MIME-Version: 1.0
In-Reply-To: <b7f-5d95b480-63-344a2840@235496508>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: =?UTF-8?Q?Fran=c3=a7ois_Legal?= <devel@thom.fr.eu.org>, Xenomai <xenomai@xenomai.org>

On 03.10.19 10:43, François Legal via Xenomai wrote:
> From: François LEGAL <devel@thom.fr.eu.org>
> Subject: [PATCH] Make MACB driver compliant with GEM hardware
> 
> Make MACB driver compliant with GEM hardware (as mainline linux
> driver does). Main fix is about interrupt flag that is never
> cleared (write 1 to clear)
> 
> Signed-off-by: François LEGAL <devel@thom.fr.eu.org>
> 
> ---
>   kernel/drivers/net/drivers/Kconfig |  6 +++---
>   kernel/drivers/net/drivers/macb.c  | 23 ++++++++++++++++++++---
>   2 files changed, 23 insertions(+), 6 deletions(-)
> 
> diff --git a/kernel/drivers/net/drivers/Kconfig b/kernel/drivers/net/drivers/Kconfig
> index 65f0855..1aa1b3c 100644
> --- a/kernel/drivers/net/drivers/Kconfig
> +++ b/kernel/drivers/net/drivers/Kconfig
> @@ -124,9 +124,9 @@ config XENO_DRIVERS_NET_DRV_AT91_ETHER
>       tristate "AT91RM9200 Board Ethernet Driver"
>   
>   config XENO_DRIVERS_NET_DRV_MACB
> -    depends on XENO_DRIVERS_NET && ARCH_AT91
> -    select AT91_PROGRAMMABLE_CLOCKS
> -    tristate "MACB AT91SAM926x devices"
> +    depends on XENO_DRIVERS_NET
> +    select AT91_PROGRAMMABLE_CLOCKS if ARCH_AT91
> +    tristate "Cadence MACB/GEM devices"
>       ---help---
>       Driver for internal MAC-controller on AT91SAM926x microcontrollers.
>       Porting by Cristiano Mantovani and Stefano Banzi (Marposs SpA).
> diff --git a/kernel/drivers/net/drivers/macb.c b/kernel/drivers/net/drivers/macb.c
> index fc5b667..ccda6ae 100644
> --- a/kernel/drivers/net/drivers/macb.c
> +++ b/kernel/drivers/net/drivers/macb.c
> @@ -679,7 +679,13 @@ static int gem_rx(struct macb *bp, int budget, nanosecs_abs_t *time_stamp)
>   	unsigned int		entry;
>   	struct rtskb		*skb;
>   	struct macb_dma_desc	*desc;
> -	int			count = 0;
> +	int			count = 0, status;
> +
> +	status = macb_readl(bp, RSR);
> +	macb_writel(bp, RSR, status);
> +
> +	if (bp->caps & MACB_CAPS_ISR_CLEAR_ON_WRITE)
> +		macb_writel(bp, ISR, MACB_BIT(RCOMP));
>   
>   	while (count < budget) {
>   		u32 addr, ctrl;
> @@ -877,7 +883,7 @@ static int macb_interrupt(rtdm_irq_t *irq_handle)
>   	struct rtnet_device *dev = dev_id;
>   	struct macb *bp = rtnetdev_priv(dev);
>   	unsigned received = 0;
> -	u32 status;
> +	u32 status, ctrl;
>   
>   	status = macb_readl(bp, ISR);
>   
> @@ -895,9 +901,10 @@ static int macb_interrupt(rtdm_irq_t *irq_handle)
>   
>   		rtdev_vdbg(bp->dev, "isr = 0x%08lx\n", (unsigned long)status);
>   
> -		if (status & MACB_RX_INT_FLAGS)
> +		if (status & MACB_BIT(RCOMP)) {
>   			received += bp->macbgem_ops.mog_rx(bp, 100 - received,
>   							&time_stamp);
> +		}
>   
>   		if (unlikely(status & (MACB_TX_ERR_FLAGS))) {
>   			macb_writel(bp, IDR, MACB_TX_INT_FLAGS);
> @@ -917,6 +924,15 @@ static int macb_interrupt(rtdm_irq_t *irq_handle)
>   		 * add that if/when we get our hands on a full-blown MII PHY.
>   		 */
>   
> +		if (status & MACB_BIT(RXUBR)) {
> +			ctrl = macb_readl(bp, NCR);
> +			macb_writel(bp, NCR, ctrl & ~MACB_BIT(RE));
> +			macb_writel(bp, NCR, ctrl | MACB_BIT(RE));
> +
> +			if (bp->caps & MACB_CAPS_ISR_CLEAR_ON_WRITE)
> +				macb_writel(bp, ISR, MACB_BIT(RXUBR));
> +		}
> +
>   		if (status & MACB_BIT(ISR_ROVR)) {
>   			/* We missed at least one packet */
>   			if (macb_is_gem(bp))
> @@ -1320,6 +1336,7 @@ static void macb_configure_caps(struct macb *bp)
>   		if (GEM_BFEXT(IRQCOR, gem_readl(bp, DCFG1)) == 0)
>   			bp->caps |= MACB_CAPS_ISR_CLEAR_ON_WRITE;
>   	}
> +	rtdev_vdbg(bp->dev, "Capabilities : %X\n", bp->caps);
>   }
>   
>   static void macb_init_hw(struct macb *bp)
> 

Thanks, applied to next.

Jan

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

