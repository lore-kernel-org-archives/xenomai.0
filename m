Subject: Re: [PATCH Dovetail 10/13] cobalt/wrappers: pipeline: abstract
 pipeline-related bits
References: <20210102093353.3195090-1-rpm@xenomai.org>
 <20210102093353.3195090-11-rpm@xenomai.org>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <4ca7bca6-7e81-365f-edc5-f4d1fa301ccf@siemens.com>
Date: Mon, 11 Jan 2021 13:59:10 +0100
MIME-Version: 1.0
In-Reply-To: <20210102093353.3195090-11-rpm@xenomai.org>
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
> No functional change is introduced.
> 
> Signed-off-by: Philippe Gerum <rpm@xenomai.org>
> ---
>  .../cobalt/kernel/ipipe/pipeline/wrappers.h   | 25 +++++++++++++++++++
>  .../cobalt/include/linux/xenomai/wrappers.h   | 23 ++++-------------
>  kernel/cobalt/posix/process.c                 |  2 +-
>  3 files changed, 31 insertions(+), 19 deletions(-)
>  create mode 100644 include/cobalt/kernel/ipipe/pipeline/wrappers.h
> 
> diff --git a/include/cobalt/kernel/ipipe/pipeline/wrappers.h b/include/cobalt/kernel/ipipe/pipeline/wrappers.h
> new file mode 100644
> index 000000000..ac940fb32
> --- /dev/null
> +++ b/include/cobalt/kernel/ipipe/pipeline/wrappers.h
> @@ -0,0 +1,25 @@
> +/*
> + * SPDX-License-Identifier: GPL-2.0
> + */
> +#ifndef _COBALT_KERNEL_IPIPE_WRAPPERS_H
> +#define _COBALT_KERNEL_IPIPE_WRAPPERS_H
> +
> +#include <linux/ipipe.h>
> +
> +#if LINUX_VERSION_CODE < KERNEL_VERSION(4,11,0)
> +#define cobalt_set_task_state(tsk, state_value)	\
> +	set_task_state(tsk, state_value)
> +#else
> +/*
> + * The co-kernel can still set the current task state safely if it
> + * runs on the head stage.
> + */
> +#define cobalt_set_task_state(tsk, state_value)	\
> +		smp_store_mb((tsk)->state, (state_value))
> +#endif
> +
> +#ifndef ipipe_root_nr_syscalls
> +#define ipipe_root_nr_syscalls(ti)	NR_syscalls
> +#endif
> +
> +#endif /* !_COBALT_KERNEL_IPIPE_WRAPPERS_H */
> diff --git a/kernel/cobalt/include/linux/xenomai/wrappers.h b/kernel/cobalt/include/linux/xenomai/wrappers.h
> index 847d68088..3e825e366 100644
> --- a/kernel/cobalt/include/linux/xenomai/wrappers.h
> +++ b/kernel/cobalt/include/linux/xenomai/wrappers.h
> @@ -21,12 +21,13 @@
>  
>  #include <linux/version.h>
>  
> +#if LINUX_VERSION_CODE < KERNEL_VERSION(4, 20, 0)

#include <linux/signal.h>

Builds failed over 4.4. Fixed up in next.

Jan

> +typedef siginfo_t kernel_siginfo_t;
> +#endif
> +
>  #if LINUX_VERSION_CODE < KERNEL_VERSION(4,11,0)
>  #include <linux/sched.h>
>  #include <linux/sched/rt.h>
> -
> -#define cobalt_set_task_state(tsk, state_value)	\
> -	set_task_state(tsk, state_value)
>  #else
>  #include <linux/sched.h>
>  #include <linux/sched/signal.h>
> @@ -35,22 +36,8 @@
>  #include <linux/sched/debug.h>
>  #include <linux/sched/task_stack.h>
>  #include <uapi/linux/sched/types.h>
> -/*
> - * The co-kernel can still do this sanely for a thread which is
> - * currently active on the head stage.
> - */
> -#define cobalt_set_task_state(tsk, state_value)	\
> -		smp_store_mb((tsk)->state, (state_value))
>  #endif
>  
> -#include <linux/ipipe.h>
> -
> -#ifndef ipipe_root_nr_syscalls
> -#define ipipe_root_nr_syscalls(ti)	NR_syscalls
> -#endif
> -
> -#if LINUX_VERSION_CODE < KERNEL_VERSION(4, 20, 0)
> -typedef siginfo_t kernel_siginfo_t;
> -#endif
> +#include <pipeline/wrappers.h>
>  
>  #endif /* !_COBALT_LINUX_WRAPPERS_H */
> diff --git a/kernel/cobalt/posix/process.c b/kernel/cobalt/posix/process.c
> index accd989ca..fcae7df06 100644
> --- a/kernel/cobalt/posix/process.c
> +++ b/kernel/cobalt/posix/process.c
> @@ -640,7 +640,7 @@ int cobalt_map_user(struct xnthread *thread, __u32 __user *u_winoff)
>  	 * it.
>  	 */
>  	xnthread_run_handler(thread, map_thread);
> -	pipeline_enable_kevents(current);
> +	pipeline_enable_kevents();
>  
>  	attr.mode = 0;
>  	attr.entry = NULL;
> 


-- 
Siemens AG, T RDA IOT
Corporate Competence Center Embedded Linux

