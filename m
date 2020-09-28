Subject: Re: [PATCH] cobalt/select: replace APC with irq_work
References: <20200924065448.14471-1-hongzhan.chen@intel.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <146482da-10d2-f2cf-f87b-9e1dfa780e11@siemens.com>
Date: Mon, 28 Sep 2020 20:12:43 +0200
MIME-Version: 1.0
In-Reply-To: <20200924065448.14471-1-hongzhan.chen@intel.com>
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

On 24.09.20 08:54, hongzha1 wrote:
> schedule irq_work which is to schedule work to execute heavy
> xnselector_destroy_loop instead of calling __xnapc_schedule.
> 
> Signed-off-by: hongzha1 <hongzhan.chen@intel.com>
> 
> ---
> this patch is for wip/dovetail. This is new version. It would
> schedule irq_work which is to schedule work to execute heavy
> xnselector_destroy_loop but not execute it in irq_work directly
> instead of calling __xnapc_schedule. 

What is the benefit of this indirection to a workqueue? irq_work - as
hardened by dovetail for triggering from oob / xenomai context - still
run the work in in-band / Linux context, just in an interrupt. IIRC,
that is the same with the previous APC mechanism, so a 1:1 match.

> 
> diff --git a/kernel/cobalt/select.c b/kernel/cobalt/select.c
> index c3a3d34b7..69eed626e 100644
> --- a/kernel/cobalt/select.c
> +++ b/kernel/cobalt/select.c
> @@ -23,7 +23,75 @@
>  #include <cobalt/kernel/sched.h>
>  #include <cobalt/kernel/synch.h>
>  #include <cobalt/kernel/select.h>
> -#include <cobalt/kernel/apc.h>
> +#include <linux/irq_work.h>
> +
> +static bool cobalt_select_isinit;
> +static LIST_HEAD(xnselect_work_queue);
> +
> +typedef void (*cobalt_select_destroy_t) (void *cookie);
> +
> +struct cobalt_select_work {
> +	cobalt_select_destroy_t handler;
> +	void *arg;
> +	struct work_struct destroy_task;
> +};
> +
> +typedef struct cobalt_select_work cobalt_select_work_t;
> +
> +static cobalt_select_work_t xndeletion_work;
> +
> +static void do_xnselect_work(struct irq_work *work)
> +{
> +	struct work_struct *xnselect_work;
> +	spl_t s;
> +
> +	xnlock_get_irqsave(&nklock, s);
> +	while (!list_empty(&xnselect_work_queue)) {
> +		xnselect_work = list_first_entry(&xnselect_work_queue,
> +						struct work_struct, entry);
> +		list_del_init(&xnselect_work->entry);
> +		xnlock_put_irqrestore(&nklock, s);
> +		
> +		schedule_work(xnselect_work);
> +
> +		xnlock_get_irqsave(&nklock, s);
> +
> +	}
> +	xnlock_put_irqrestore(&nklock, s);
> +
> +}
> +
> +static DEFINE_IRQ_WORK(xnselect_irq_work, do_xnselect_work);
> +
> +typedef void (*cobalt_select_destroy_t)(void *cookie);
> +
> +void xnselect_schedule_work(struct work_struct *destroy_work)
> +{
> +	spl_t s;
> +
> +	xnlock_get_irqsave(&nklock, s);
> +	list_add_tail(&xnselect_work_queue, &destroy_work->entry);
> +	xnlock_put_irqrestore(&nklock, s);
> +
> +	irq_work_queue(&xnselect_irq_work);
> +}
> +
> +static void cobalt_select_execute(struct work_struct *work)
> +{
> +	cobalt_select_work_t *xnselect =
> +		container_of(work, cobalt_select_work_t, destroy_task);
> +	xnselect->handler(xnselect->arg);
> +}
> +
> +int cobalt_select_init(cobalt_select_work_t *xnselect,
> +		cobalt_select_destroy_t handler, void *arg)
> +{
> +	xnselect->handler = handler;
> +	xnselect->arg = arg;
> +	INIT_WORK(&xnselect->destroy_task, cobalt_select_execute);
> +	return 0;
> +}
> +
>  
>  /**
>   * @ingroup cobalt_core
> @@ -49,7 +117,6 @@
>   */
>  
>  static LIST_HEAD(selector_list);
> -static int deletion_apc;
>  
>  /**
>   * Initialize a @a struct @a xnselect structure.
> @@ -399,9 +466,10 @@ void xnselector_destroy(struct xnselector *selector)
>  
>  	xnlock_get_irqsave(&nklock, s);
>  	list_add_tail(&selector->destroy_link, &selector_list);
> -#warning TODO: irq_work
> -	//__xnapc_schedule(deletion_apc);
>  	xnlock_put_irqrestore(&nklock, s);
> +	if (cobalt_select_isinit == true)
> +		xnselect_schedule_work(&xndeletion_work.destroy_task);
> +
>  }
>  EXPORT_SYMBOL_GPL(xnselector_destroy);
>  
> @@ -444,18 +512,20 @@ out:
>  
>  int xnselect_mount(void)
>  {
> -#warning TODO: use irq_work
> -	/*deletion_apc = xnapc_alloc("selector_list_destroy",
> -				   xnselector_destroy_loop, NULL);
> -	if (deletion_apc < 0)
> -		return deletion_apc;*/
> +	int ret;
>  
> -	return 0;
> +	cobalt_select_isinit = false;
> +
> +	ret = cobalt_select_init(&xndeletion_work, xnselector_destroy_loop, NULL);
> +	if (!ret)
> +		cobalt_select_isinit = true;
> +	return ret;
>  }
>  
>  int xnselect_umount(void)
>  {
> -	//xnapc_free(deletion_apc);
> +	cobalt_select_isinit = false;
> +	cancel_work_sync(&xndeletion_work.destroy_task);
>  	return 0;
>  }
>  
> 

OK, so this replaced v2 sent to the list?

Please stay on the list with the patches, maybe just mark them
additionally with "[dovetail]" or so.

Jan

PS: Sorry, I'm late with replying.

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

