Subject: Re: [PATCH] MABC RTNet driver to work with GEM hardware
References: <30dd-5d948d00-9-21e4bb80@177051046>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <aa908927-991c-9bc1-6bb7-44ce52a23b6a@siemens.com>
Date: Wed, 2 Oct 2019 14:23:00 +0200
MIME-Version: 1.0
In-Reply-To: <30dd-5d948d00-9-21e4bb80@177051046>
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
To: =?UTF-8?Q?Fran=c3=a7ois_Legal?= <devel@thom.fr.eu.org>, xenomai@xenomai.org

On 02.10.19 13:41, François Legal via Xenomai wrote:
>  From 9703097ac23dfdea91bc688267e0d46ea20ceacc Mon Sep 17 00:00:00 2001
> From: dev <dev@DevCoreProcessing.assystem>
> Date: Wed, 2 Oct 2019 11:58:01 +0200
> Subject: [PATCH] Make MACB driver compliant with GEM hardware (as mainline
>   linux driver does). Main fix is about interrupt flag that is never cleared
>   (write 1 to clear)
> 

Almost: Subject should be brief, move the extended "why" into the commit message 
body. And then we need a signed-off, confirming [1].

> ---
>   kernel/drivers/net/drivers/Kconfig  | 11 +++++++++--
>   kernel/drivers/net/drivers/Makefile |  1 +
>   kernel/drivers/net/drivers/macb.c   | 27 +++++++++++++++++++++++----
>   3 files changed, 33 insertions(+), 6 deletions(-)
> 
> diff --git a/kernel/drivers/net/drivers/Kconfig b/kernel/drivers/net/drivers/Kconfig
> index 65f0855..89ac237 100644
> --- a/kernel/drivers/net/drivers/Kconfig
> +++ b/kernel/drivers/net/drivers/Kconfig
> @@ -77,7 +77,7 @@ config XENO_DRIVERS_NET_DRV_R8169
>       tristate "Realtek 8169 (Gigabit)"
>   
>   
> -if PPC
> +if ARCH = ppc

Why that?

>   
>   comment "Embedded MPC Drivers"
>       depends on XENO_DRIVERS_NET
> @@ -116,7 +116,7 @@ config XENO_DRIVERS_NET_DRV_SMC91111
>       depends on XENO_DRIVERS_NET
>       tristate "SMSC LAN91C111"
>   
> -if ARM
> +if ARCH = arm

Same here.

>   
>   config XENO_DRIVERS_NET_DRV_AT91_ETHER
>       depends on XENO_DRIVERS_NET && SOC_AT91RM9200
> @@ -131,6 +131,13 @@ config XENO_DRIVERS_NET_DRV_MACB
>       Driver for internal MAC-controller on AT91SAM926x microcontrollers.
>       Porting by Cristiano Mantovani and Stefano Banzi (Marposs SpA).
>   
> +config XENO_DRIVERS_NET_DRV_GEM
> +    depends on XENO_DRIVERS_NET
> +    tristate "GEM devices"
> +    ---help---
> +    Driver for internal MAC-controller on Zynq 7000 SoCs.
> +    Porting by Cristiano Mantovani and Stefano Banzi (Marposs SpA).
> +
>   endif
>   
>   source "drivers/xenomai/net/drivers/experimental/Kconfig"
> diff --git a/kernel/drivers/net/drivers/Makefile b/kernel/drivers/net/drivers/Makefile
> index d95c5a8..9da1a56 100644
> --- a/kernel/drivers/net/drivers/Makefile
> +++ b/kernel/drivers/net/drivers/Makefile
> @@ -57,6 +57,7 @@ obj-$(CONFIG_XENO_DRIVERS_NET_DRV_SMC91111) += rt_smc91111.o
>   rt_smc91111-y := smc91111.o
>   
>   obj-$(CONFIG_XENO_DRIVERS_NET_DRV_MACB) += rt_macb.o
> +obj-$(CONFIG_XENO_DRIVERS_NET_DRV_GEM) += rt_macb.o
>   
>   rt_macb-y := macb.o
>   
> diff --git a/kernel/drivers/net/drivers/macb.c b/kernel/drivers/net/drivers/macb.c
> index fc5b667..e97a7d1 100644
> --- a/kernel/drivers/net/drivers/macb.c
> +++ b/kernel/drivers/net/drivers/macb.c
> @@ -679,7 +679,14 @@ static int gem_rx(struct macb *bp, int budget, nanosecs_abs_t *time_stamp)
>   	unsigned int		entry;
>   	struct rtskb		*skb;
>   	struct macb_dma_desc	*desc;
> -	int			count = 0;
> +	int			count = 0, status;
> +
> +

Likely one newline too much (unless that strictly aligns with upstream).

> +	status = macb_readl(bp, RSR);
> +	macb_writel(bp, RSR, status);
> +
> +	if (bp->caps & MACB_CAPS_ISR_CLEAR_ON_WRITE)
> +		macb_writel(bp, ISR, MACB_BIT(RCOMP));
>   
>   	while (count < budget) {
>   		u32 addr, ctrl;
> @@ -725,6 +732,7 @@ static int gem_rx(struct macb *bp, int budget, nanosecs_abs_t *time_stamp)
>   				 bp->rx_buffer_size, DMA_FROM_DEVICE);
>   
>   		skb->protocol = rt_eth_type_trans(skb, bp->dev);
> +		rtskb_checksum_none_assert(skb);

This was just removed (0ff501aa33f51f118b8339096f10bbea184141a4).

>   
>   		bp->stats.rx_packets++;
>   		bp->stats.rx_bytes += skb->len;
> @@ -791,6 +799,7 @@ static int macb_rx_frame(struct macb *bp, unsigned int first_frag,
>   	offset = 0;
>   	len += NET_IP_ALIGN;
>   	skb->time_stamp = *time_stamp;
> +	rtskb_checksum_none_assert(skb);
>   	rtskb_put(skb, len);
>   
>   	for (frag = first_frag; ; frag++) {
> @@ -877,7 +886,7 @@ static int macb_interrupt(rtdm_irq_t *irq_handle)
>   	struct rtnet_device *dev = dev_id;
>   	struct macb *bp = rtnetdev_priv(dev);
>   	unsigned received = 0;
> -	u32 status;
> +	u32 status, ctrl;
>   
>   	status = macb_readl(bp, ISR);
>   
> @@ -895,9 +904,10 @@ static int macb_interrupt(rtdm_irq_t *irq_handle)
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
> @@ -917,6 +927,15 @@ static int macb_interrupt(rtdm_irq_t *irq_handle)
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
> @@ -1320,6 +1339,7 @@ static void macb_configure_caps(struct macb *bp)
>   		if (GEM_BFEXT(IRQCOR, gem_readl(bp, DCFG1)) == 0)
>   			bp->caps |= MACB_CAPS_ISR_CLEAR_ON_WRITE;
>   	}
> +	rtdev_dbg(bp->dev, "Capabilities : %X\n", bp->caps);

Is that a left-over debug output?

>   }
>   
>   static void macb_init_hw(struct macb *bp)
> @@ -1578,7 +1598,6 @@ static int __init macb_probe(struct platform_device *pdev)
>   	rtdev_alloc_name(dev, "rteth%d");
>   	rt_rtdev_connect(dev, &RTDEV_manager);
>   	dev->vers = RTDEV_VERS_2_0;
> -	dev->sysbind = &pdev->dev;
>   
>   	/* TODO: Actually, we have some interesting features... */
>   	dev->features |= 0;
> 

Thanks,
Jan

[1] https://developercertificate.org/

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

