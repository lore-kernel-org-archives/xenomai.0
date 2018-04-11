References: <1523235231-12106-1-git-send-email-greg@embeddedgreg.com>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <d259f2c1-1fd6-660b-1e8a-43d8c93c4b72@xenomai.org>
Date: Wed, 11 Apr 2018 16:32:31 +0200
MIME-Version: 1.0
In-Reply-To: <1523235231-12106-1-git-send-email-greg@embeddedgreg.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] [PATCH] Set irq-bcm2835 pipeline safe
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Greg Gallagher <greg@embeddedgreg.com>, xenomai@xenomai.org

On 04/09/2018 02:53 AM, Greg Gallagher wrote:
> ---
>  drivers/irqchip/irq-bcm2835.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/irqchip/irq-bcm2835.c b/drivers/irqchip/irq-bcm2835.c
> index bf8c9d4..8a1b729 100644
> --- a/drivers/irqchip/irq-bcm2835.c
> +++ b/drivers/irqchip/irq-bcm2835.c
> @@ -115,6 +115,7 @@ static struct irq_chip armctrl_chip = {
>  	.irq_hold = armctrl_mask_irq,
>  	.irq_release = armctrl_unmask_irq,
>  #endif
> +	.flags	     = IRQCHIP_PIPELINE_SAFE,
>  };
>  
>  static int armctrl_xlate(struct irq_domain *d, struct device_node *ctrlr,
> 

Merged, thanks.

-- 
Philippe.

