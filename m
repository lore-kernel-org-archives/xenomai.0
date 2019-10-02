Subject: Re: [PATCH] MABC RTNet driver to work with GEM hardware
References: <b7f-5d94aa00-4f-344a2840@235460769>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <7291e497-1306-d01f-fb14-6c3fc26cca03@siemens.com>
Date: Wed, 2 Oct 2019 16:59:59 +0200
MIME-Version: 1.0
In-Reply-To: <b7f-5d94aa00-4f-344a2840@235460769>
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

On 02.10.19 15:44, François Legal via Xenomai wrote:
> From: François LEGAL <devel@thom.fr.eu.org>
> 
> Make MACB driver compliant with GEM hardware (as mainline linux
> driver does). Main fix is about interrupt flag that is never
> cleared (write 1 to clear)
> 
> Signed-off-by: François LEGAL <devel@thom.fr.eu.org>
> 
> Subject: [PATCH] Make MACB driver compliant with GEM hardware

Hmm, two subject lines - which one should I use? Would be better get the first 
one right already ;).

> 
> ---
>   kernel/drivers/net/drivers/Kconfig  |  7 +++++++
>   kernel/drivers/net/drivers/Makefile |  1 +
>   kernel/drivers/net/drivers/macb.c   | 23 ++++++++++++++++++++---
>   3 files changed, 28 insertions(+), 3 deletions(-)
> 
> diff --git a/kernel/drivers/net/drivers/Kconfig b/kernel/drivers/net/drivers/Kconfig
> index 65f0855..39c976f 100644
> --- a/kernel/drivers/net/drivers/Kconfig
> +++ b/kernel/drivers/net/drivers/Kconfig
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

Only saw this now: What's the idea behind adding XENO_DRIVERS_NET_DRV_GEM when 
there is XENO_DRIVERS_NET_DRV_MACB already? If a selects both, the build will fail.

>   
>   rt_macb-y := macb.o
>   
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

Jan

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

