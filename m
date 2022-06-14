Message-ID: <b8fe0028-16d8-494f-0139-74524043c8c7@siemens.com>
Date: Tue, 14 Jun 2022 23:27:44 +0200
MIME-Version: 1.0
Subject: Re: [Cobalt Xenoami3.1 PATCH 1/2] process: update clockfreq when
 receive corresponding event.
Content-Language: en-US
References: <20220527062203.9498-1-hongzhan.chen@intel.com>
 <20220527062203.9498-2-hongzhan.chen@intel.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <20220527062203.9498-2-hongzhan.chen@intel.com>
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
To: Hongzhan Chen <hongzhan.chen@intel.com>, xenomai@xenomai.org

On 27.05.22 08:22, Hongzhan Chen via Xenomai wrote:
> 1. When there is clockfreq param passed down via command line, we
>    do not update clockfreq even if we receive event of updating clockfreq.
>    Or else, we update the clockfreq with notified value.
> 2. At the same time, we would like to update clockfreq param showing
>    in sys filesystem after apply updated clockfreq.
> 
> Signed-off-by: Hongzhan Chen <hongzhan.chen@intel.com>
> 
> diff --git a/include/cobalt/kernel/init.h b/include/cobalt/kernel/init.h
> index 41dd531a8..43144443b 100644
> --- a/include/cobalt/kernel/init.h
> +++ b/include/cobalt/kernel/init.h
> @@ -51,4 +51,6 @@ void cobalt_remove_state_chain(struct notifier_block *nb);
>  
>  void cobalt_call_state_chain(enum cobalt_run_states newstate);
>  
> +void cobalt_update_clockfreq_arg(unsigned long updatedclockfreq);

Just "freq" is sufficient as parameter name.

> +
>  #endif /* !_COBALT_KERNEL_INIT_H_ */
> diff --git a/kernel/cobalt/include/asm-generic/xenomai/machine.h b/kernel/cobalt/include/asm-generic/xenomai/machine.h
> index 25764f989..aaa3edc97 100644
> --- a/kernel/cobalt/include/asm-generic/xenomai/machine.h
> +++ b/kernel/cobalt/include/asm-generic/xenomai/machine.h
> @@ -61,6 +61,7 @@ struct cobalt_pipeline {
>  #ifdef CONFIG_SMP
>  	cpumask_t supported_cpus;
>  #endif
> +	unsigned int passed_clockfreq;

bool

But I would rather make this a private flag in cobalt/init.c, see below.

>  };
>  
>  extern struct cobalt_pipeline cobalt_pipeline;
> diff --git a/kernel/cobalt/init.c b/kernel/cobalt/init.c
> index dbe321c3b..a6cfc1e06 100644
> --- a/kernel/cobalt/init.c
> +++ b/kernel/cobalt/init.c
> @@ -53,6 +53,19 @@ module_param_named(timerfreq, timerfreq_arg, ulong, 0444);
>  static unsigned long clockfreq_arg;
>  module_param_named(clockfreq, clockfreq_arg, ulong, 0444);
>  
> +void cobalt_update_clockfreq_arg(unsigned long updatedclockfreq)
> +{
> +	spl_t s;
> +
> +	xnlock_get_irqsave(&nklock, s);
> +
> +	clockfreq_arg = updatedclockfreq;
> +
> +	xnlock_put_irqrestore(&nklock, s);

How is synchronization supposed to work here?

And when is clockfreq_arg supposed to be consumed after mach_setup? By
whom? /sys/module/xenomai/parameters/?

To make this function more useful, it could perform the "was passed"
check and also set clockfreq_arg and call xnclock_update_freq() if it
was not defined via the command line.

> +
> +}
> +EXPORT_SYMBOL_GPL(cobalt_update_clockfreq_arg);

Why exporting this internal helper? Xenomai is always built into the kernel.

> +
>  #ifdef CONFIG_SMP
>  static unsigned long supported_cpus_arg = -1;
>  module_param_named(supported_cpus, supported_cpus_arg, ulong, 0444);
> @@ -148,8 +161,11 @@ static int __init mach_setup(void)
>  	if (timerfreq_arg == 0)
>  		timerfreq_arg = sysinfo.sys_hrtimer_freq;
>  
> -	if (clockfreq_arg == 0)
> +	if (clockfreq_arg == 0) {
>  		clockfreq_arg = sysinfo.sys_hrclock_freq;
> +		cobalt_pipeline.passed_clockfreq = 0;

Global variables are already zero-initialized.

> +	} else
> +		cobalt_pipeline.passed_clockfreq = 1;

cobalt_pipeline.passed_clockfreq = clockfreq_arg != 0;

>  
>  	if (clockfreq_arg == 0) {
>  		printk(XENO_ERR "null clock frequency? Aborting.\n");
> diff --git a/kernel/cobalt/posix/process.c b/kernel/cobalt/posix/process.c
> index 6d1c1c427..41ea47b0d 100644
> --- a/kernel/cobalt/posix/process.c
> +++ b/kernel/cobalt/posix/process.c
> @@ -38,6 +38,7 @@
>  #include <linux/kallsyms.h>
>  #include <linux/ipipe.h>
>  #include <linux/ipipe_tickdev.h>
> +#include <cobalt/kernel/init.h>
>  #include <cobalt/kernel/sched.h>
>  #include <cobalt/kernel/heap.h>
>  #include <cobalt/kernel/synch.h>
> @@ -1382,7 +1383,13 @@ static inline int handle_clockfreq_event(unsigned int *p)
>  {
>  	unsigned int newfreq = *p;
>  
> -	xnclock_update_freq(newfreq);
> +	/* when there is no para in commandline
> +	 * passed down to set clockfreq

Comment does not tell anything that isn't in the code already.

> +	 */
> +	if (!cobalt_pipeline.passed_clockfreq) {
> +		xnclock_update_freq(newfreq);
> +		cobalt_update_clockfreq_arg(newfreq);
> +	}

See my remark above: If you push xnclock_update_freq into
cobalt_update_clockfreq, you can simplify to logic here, just call
cobalt_update_clockfreq unconditionally.

>  
>  	return KEVENT_PROPAGATE;
>  }

And now I understand that none of this is needed for 3.2, only the
I-pipe patch to send the kevent.

Jan

-- 
Siemens AG, Technology
Competence Center Embedded Linux

