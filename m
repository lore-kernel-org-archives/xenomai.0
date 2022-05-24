Message-ID: <dd14086f-41b8-d66a-07a2-804ffd3bf831@siemens.com>
Date: Tue, 24 May 2022 09:24:30 +0200
MIME-Version: 1.0
Subject: Re: [PATCH] cobalt: ipipe: intr: Fix return value check of
 ipipe_set_irq_affinity
Content-Language: en-US
References: <d00-62584d80-1a5-12ac4c80@96928095>
 <20220520142913.2081560-1-guntgrau@bbl.ma.philips.com>
 <20220520142913.2081560-2-guntgrau@bbl.ma.philips.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <20220520142913.2081560-2-guntgrau@bbl.ma.philips.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gunter Grau <gunter.grau@philips.com>, xenomai@xenomai.org
Cc: Gunter Grau <guntgrau@bbl.ma.philips.com>

On 20.05.22 16:29, Gunter Grau via Xenomai wrote:
> From: Julian Haller <julian.haller@philips.com>
> 
> ipipe_set_irq_affinity directly returns the value of the regular
> irq_set_affinity method. As described in irq.h in the linux kernel,
> the following return values indicate a success:
> 
> /*
>  * Return value for chip->irq_set_affinity()
>  *
>  * IRQ_SET_MASK_OK      - OK, core updates irq_common_data.affinity
>  * IRQ_SET_MASK_NOCPY   - OK, chip did update irq_common_data.affinity
>  * IRQ_SET_MASK_OK_DONE - Same as IRQ_SET_MASK_OK for core. Special code to
>  *                        support stacked irqchips, which indicates skipping
>  *                        all descendent irqchips.
>  */
> enum {
>         IRQ_SET_MASK_OK = 0,
>         IRQ_SET_MASK_OK_NOCOPY,
>         IRQ_SET_MASK_OK_DONE,
> };
> 
> As one example, the GIC in i.MX6 devices returns IRQ_SET_MASK_OK_DONE
> on success. Fix the xintr_attach function by treating all positive
> return values as success.
> 
> Signed-off-by: Gunter Grau <gunter.grau@philips.com>
> ---
>  kernel/cobalt/ipipe/intr.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/cobalt/ipipe/intr.c b/kernel/cobalt/ipipe/intr.c
> index 378c7f07d..cb15597f7 100644
> --- a/kernel/cobalt/ipipe/intr.c
> +++ b/kernel/cobalt/ipipe/intr.c
> @@ -869,7 +869,7 @@ int xnintr_attach(struct xnintr *intr, void *cookie, const cpumask_t *cpumask)
>  			return -EINVAL;
>  	}
>  	ret = ipipe_set_irq_affinity(intr->irq, *effective_mask);
> -	if (ret)
> +	if (ret < 0)
>  		return ret;
>  #endif /* CONFIG_SMP */
>  

Thanks, applied to the 3.2 stable tree. Other versions are not affected.

Jan

-- 
Siemens AG, Technology
Competence Center Embedded Linux

