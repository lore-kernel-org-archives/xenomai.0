Subject: Re: [PATCH Dovetail 13/13] cobalt/syscall: pipeline: abstract syscall
 entry points
References: <20210102093353.3195090-1-rpm@xenomai.org>
 <20210102093353.3195090-14-rpm@xenomai.org>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <bacb5da0-9bca-c9c7-70b4-3490626426a4@siemens.com>
Date: Thu, 7 Jan 2021 15:08:22 +0100
MIME-Version: 1.0
In-Reply-To: <20210102093353.3195090-14-rpm@xenomai.org>
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
To: Philippe Gerum <rpm@xenomai.org>, xenomai@xenomai.org

On 02.01.21 10:33, Philippe Gerum wrote:
> From: Philippe Gerum <rpm@xenomai.org>
> 
> The I-pipe and Dovetail differ only marginally with respect to syscall
> handling. Abstract only the few details we need to cope with both
> interfaces.
> 
> No functional change is introduced.
> 
> Signed-off-by: Philippe Gerum <rpm@xenomai.org>
> ---
>  .../cobalt/kernel/ipipe/pipeline/kevents.h    |  3 ++
>  .../cobalt/kernel/ipipe/pipeline/pipeline.h   |  2 ++
>  include/cobalt/kernel/sched.h                 |  2 --
>  kernel/cobalt/ipipe/Makefile                  |  2 +-
>  kernel/cobalt/ipipe/syscall.c                 | 29 +++++++++++++++++++
>  kernel/cobalt/posix/process.h                 |  3 --
>  kernel/cobalt/posix/syscall.c                 | 28 ++++--------------
>  kernel/cobalt/posix/syscall.h                 |  7 +++++
>  8 files changed, 47 insertions(+), 29 deletions(-)
>  create mode 100644 kernel/cobalt/ipipe/syscall.c
> 
> diff --git a/include/cobalt/kernel/ipipe/pipeline/kevents.h b/include/cobalt/kernel/ipipe/pipeline/kevents.h
> index 30425a96b..2f186a57e 100644
> --- a/include/cobalt/kernel/ipipe/pipeline/kevents.h
> +++ b/include/cobalt/kernel/ipipe/pipeline/kevents.h
> @@ -7,6 +7,9 @@
>  #ifndef _COBALT_KERNEL_IPIPE_KEVENTS_H
>  #define _COBALT_KERNEL_IPIPE_KEVENTS_H
>  
> +#define KEVENT_PROPAGATE   0
> +#define KEVENT_STOP        1
> +
>  struct cobalt_process;
>  struct cobalt_thread;
>  
> diff --git a/include/cobalt/kernel/ipipe/pipeline/pipeline.h b/include/cobalt/kernel/ipipe/pipeline/pipeline.h
> index 0ffc9b00b..fb0465fb2 100644
> --- a/include/cobalt/kernel/ipipe/pipeline/pipeline.h
> +++ b/include/cobalt/kernel/ipipe/pipeline/pipeline.h
> @@ -11,6 +11,8 @@
>  
>  #include <pipeline/machine.h>
>  
> +#define xnsched_realtime_domain  cobalt_pipeline.domain
> +

Why not use the chance and call also this xnsched_primary_domain?

Jan

>  #define PIPELINE_NR_IRQS  IPIPE_NR_IRQS
>  
>  typedef unsigned long spl_t;
> diff --git a/include/cobalt/kernel/sched.h b/include/cobalt/kernel/sched.h
> index 5d278838f..ad815b595 100644
> --- a/include/cobalt/kernel/sched.h
> +++ b/include/cobalt/kernel/sched.h
> @@ -233,8 +233,6 @@ static inline void xnsched_set_self_resched(struct xnsched *sched)
>  	sched->status |= XNRESCHED;
>  }
>  
> -#define xnsched_realtime_domain  cobalt_pipeline.domain
> -
>  /* Set resched flag for the given scheduler. */
>  #ifdef CONFIG_SMP
>  
> diff --git a/kernel/cobalt/ipipe/Makefile b/kernel/cobalt/ipipe/Makefile
> index 0490f8800..3c0ad2098 100644
> --- a/kernel/cobalt/ipipe/Makefile
> +++ b/kernel/cobalt/ipipe/Makefile
> @@ -2,4 +2,4 @@ ccflags-y += -Ikernel
>  
>  obj-y +=	pipeline.o
>  
> -pipeline-y :=	init.o intr.o kevents.o apc.o tick.o
> +pipeline-y :=	init.o intr.o kevents.o apc.o tick.o syscall.o
> diff --git a/kernel/cobalt/ipipe/syscall.c b/kernel/cobalt/ipipe/syscall.c
> new file mode 100644
> index 000000000..18aa996bd
> --- /dev/null
> +++ b/kernel/cobalt/ipipe/syscall.c
> @@ -0,0 +1,29 @@
> +/*
> + * SPDX-License-Identifier: GPL-2.0
> + *
> + * Copyright (C) 2005 Philippe Gerum <rpm@xenomai.org>
> + * Copyright (C) 2005 Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
> + */
> +
> +#include <pipeline/pipeline.h>
> +#include <pipeline/kevents.h>
> +#include <cobalt/kernel/assert.h>
> +#include <xenomai/posix/syscall.h>
> +
> +int ipipe_syscall_hook(struct ipipe_domain *ipd, struct pt_regs *regs)
> +{
> +	if (unlikely(is_secondary_domain()))
> +		return handle_root_syscall(regs);
> +
> +	return handle_head_syscall(ipd != &xnsched_realtime_domain, regs);
> +}
> +
> +int ipipe_fastcall_hook(struct pt_regs *regs)
> +{
> +	int ret;
> +
> +	ret = handle_head_syscall(false, regs);
> +	XENO_BUG_ON(COBALT, ret == KEVENT_PROPAGATE);
> +
> +	return ret;
> +}
> diff --git a/kernel/cobalt/posix/process.h b/kernel/cobalt/posix/process.h
> index a2f4ec591..22142ee03 100644
> --- a/kernel/cobalt/posix/process.h
> +++ b/kernel/cobalt/posix/process.h
> @@ -23,9 +23,6 @@
>  #include <pipeline/thread.h>
>  #include <cobalt/kernel/ppd.h>
>  
> -#define KEVENT_PROPAGATE   0
> -#define KEVENT_STOP        1
> -
>  #define NR_PERSONALITIES  4
>  #if BITS_PER_LONG < NR_PERSONALITIES
>  #error "NR_PERSONALITIES overflows internal bitmap"
> diff --git a/kernel/cobalt/posix/syscall.c b/kernel/cobalt/posix/syscall.c
> index 4d2331ddc..3b3eaee8e 100644
> --- a/kernel/cobalt/posix/syscall.c
> +++ b/kernel/cobalt/posix/syscall.c
> @@ -18,7 +18,6 @@
>   */
>  #include <linux/types.h>
>  #include <linux/err.h>
> -#include <linux/ipipe.h>
>  #include <linux/sched.h>
>  #include <linux/kconfig.h>
>  #include <linux/unistd.h>
> @@ -26,6 +25,7 @@
>  #include <cobalt/kernel/tree.h>
>  #include <cobalt/kernel/vdso.h>
>  #include <cobalt/kernel/init.h>
> +#include <pipeline/kevents.h>
>  #include <asm/syscall.h>
>  #include "internal.h"
>  #include "thread.h"
> @@ -475,7 +475,7 @@ static inline int allowed_syscall(struct cobalt_process *process,
>  	return cap_raised(current_cap(), CAP_SYS_NICE);
>  }
>  
> -static int handle_head_syscall(struct ipipe_domain *ipd, struct pt_regs *regs)
> +int handle_head_syscall(bool caller_is_relaxed, struct pt_regs *regs)
>  {
>  	struct cobalt_process *process;
>  	int switched, sigs, sysflags;
> @@ -553,7 +553,7 @@ restart:
>  		/*
>  		 * The syscall must run from the Linux domain.
>  		 */
> -		if (ipd == &xnsched_realtime_domain) {
> +		if (!caller_is_relaxed) {
>  			/*
>  			 * Request originates from the Xenomai domain:
>  			 * relax the caller then invoke the syscall
> @@ -578,7 +578,7 @@ restart:
>  		 * hand it over to our secondary-mode dispatcher.
>  		 * Otherwise, invoke the syscall handler immediately.
>  		 */
> -		if (ipd != &xnsched_realtime_domain)
> +		if (caller_is_relaxed)
>  			return KEVENT_PROPAGATE;
>  	}
>  
> @@ -667,7 +667,7 @@ bad_syscall:
>  	return KEVENT_STOP;
>  }
>  
> -static int handle_root_syscall(struct ipipe_domain *ipd, struct pt_regs *regs)
> +int handle_root_syscall(struct pt_regs *regs)
>  {
>  	int sysflags, switched, sigs;
>  	struct xnthread *thread;
> @@ -777,24 +777,6 @@ ret_handled:
>  	return KEVENT_STOP;
>  }
>  
> -int ipipe_syscall_hook(struct ipipe_domain *ipd, struct pt_regs *regs)
> -{
> -	if (unlikely(is_secondary_domain()))
> -		return handle_root_syscall(ipd, regs);
> -
> -	return handle_head_syscall(ipd, regs);
> -}
> -
> -int ipipe_fastcall_hook(struct pt_regs *regs)
> -{
> -	int ret;
> -
> -	ret = handle_head_syscall(&xnsched_realtime_domain, regs);
> -	XENO_BUG_ON(COBALT, ret == KEVENT_PROPAGATE);
> -
> -	return ret;
> -}
> -
>  long cobalt_restart_syscall_placeholder(struct restart_block *param)
>  {
>  	return -EINVAL;
> diff --git a/kernel/cobalt/posix/syscall.h b/kernel/cobalt/posix/syscall.h
> index 690cb2263..3a4c98d7a 100644
> --- a/kernel/cobalt/posix/syscall.h
> +++ b/kernel/cobalt/posix/syscall.h
> @@ -20,6 +20,8 @@
>  
>  #include <cobalt/uapi/syscall.h>
>  
> +struct pt_regs;
> +
>  /* Regular (native) syscall handler implementation. */
>  #define COBALT_SYSCALL(__name, __mode, __args)	\
>  	long CoBaLt_ ## __name __args
> @@ -30,4 +32,9 @@
>  
>  #include <asm/xenomai/syscall32.h>
>  
> +int handle_head_syscall(bool caller_is_relaxed,
> +			struct pt_regs *regs);
> +
> +int handle_root_syscall(struct pt_regs *regs);
> +
>  #endif /* !_COBALT_POSIX_SYSCALL_H */
> 


-- 
Siemens AG, T RDA IOT
Corporate Competence Center Embedded Linux

