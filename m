Subject: Re: [PATCH] cobalt/registry: replace calling __xnapc_schedule with
 irq_work_queue to schedule registry_proc_work
References: <20200925070329.10465-1-hongzhan.chen@intel.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <de5a0827-8796-8c4f-ac0e-a91ef754fb28@siemens.com>
Date: Mon, 28 Sep 2020 20:15:46 +0200
MIME-Version: 1.0
In-Reply-To: <20200925070329.10465-1-hongzhan.chen@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: hongzha1 <hongzhan.chen@intel.com>, Xenomai <xenomai@xenomai.org>

On 25.09.20 09:03, hongzha1 wrote:
> call irq_work_queue to schedule registry_proc_work instead of
> calling __xnapc_schedule
> 
> Signed-off-by: hongzha1 <hongzhan.chen@intel.com>
> 
> ---
> this patch is for wip/dovetail
> 
> diff --git a/kernel/cobalt/registry.c b/kernel/cobalt/registry.c
> index 813dae3fb..5570a4ca5 100644
> --- a/kernel/cobalt/registry.c
> +++ b/kernel/cobalt/registry.c
> @@ -21,8 +21,8 @@
>  #include <cobalt/kernel/heap.h>
>  #include <cobalt/kernel/registry.h>
>  #include <cobalt/kernel/thread.h>
> -#include <cobalt/kernel/apc.h>
>  #include <cobalt/kernel/assert.h>
> +#include <linux/irq_work.h>
>  
>  /**
>   * @ingroup cobalt_core
> @@ -338,6 +338,17 @@ static void registry_proc_schedule(void *cookie)
>  	schedule_work(&registry_proc_work);
>  }
>  
> +static void do_xnregistry_work(struct irq_work *work)
> +{
> +	/*
> +	 * schedule_work() will check for us if the work has already
> +	 * been scheduled, so just be lazy and submit blindly.
> +	 */
> +	schedule_work(&registry_proc_work);
> +
> +}
> +static DEFINE_IRQ_WORK(xnregistry_irq_work, do_xnregistry_work);
> +
>  static int registry_export_vfsnap(struct xnobject *object,
>  				  struct xnpnode *pnode)
>  {
> @@ -472,6 +483,7 @@ static inline void registry_export_pnode(struct xnobject *object,
>  	list_add_tail(&object->link, &proc_object_list);
>  #warning TODO: irq_work
>  	//__xnapc_schedule(proc_apc);
> +	 irq_work_queue(&xnregistry_irq_work);
>  }
>  
>  static inline void registry_unexport_pnode(struct xnobject *object)
> @@ -489,6 +501,7 @@ static inline void registry_unexport_pnode(struct xnobject *object)
>  		list_add_tail(&object->link, &proc_object_list);
>  #warning TODO: irq_work
>  		//__xnapc_schedule(proc_apc);
> +		irq_work_queue(&xnregistry_irq_work);
>  	} else {
>  		/*
>  		 * Unexporting before the lower stage has had a chance
> 

This looks straightforward. Merged.

Thanks,
Jan

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

