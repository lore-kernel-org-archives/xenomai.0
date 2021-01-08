Subject: Re: [PATCH Dovetail 01/13] cobalt/thread: pipeline: abstract
 threadinfo accessor
References: <20210102093353.3195090-1-rpm@xenomai.org>
 <20210102093353.3195090-2-rpm@xenomai.org>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <b4a996ff-c5d9-a08b-639f-191ac1ef8b35@siemens.com>
Date: Fri, 8 Jan 2021 10:02:40 +0100
MIME-Version: 1.0
In-Reply-To: <20210102093353.3195090-2-rpm@xenomai.org>
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
> The I-pipe and Dovetail access the per-thread information block
> differently. Abstract this kernel interface.
> 
> No functional change is introduced.
> 
> Signed-off-by: Philippe Gerum <rpm@xenomai.org>
> ---
>  include/cobalt/kernel/ipipe/pipeline/thread.h | 26 +++++++++++++++++++
>  include/cobalt/kernel/thread.h                |  5 ++--
>  kernel/cobalt/ipipe/kevents.c                 |  6 ++---
>  kernel/cobalt/posix/process.c                 |  4 +--
>  kernel/cobalt/posix/process.h                 |  5 ++--
>  kernel/cobalt/thread.c                        |  4 +--
>  6 files changed, 39 insertions(+), 11 deletions(-)
>  create mode 100644 include/cobalt/kernel/ipipe/pipeline/thread.h
> 
> diff --git a/include/cobalt/kernel/ipipe/pipeline/thread.h b/include/cobalt/kernel/ipipe/pipeline/thread.h
> new file mode 100644
> index 000000000..a62e622c4
> --- /dev/null
> +++ b/include/cobalt/kernel/ipipe/pipeline/thread.h
> @@ -0,0 +1,26 @@
> +/*
> + * SPDX-License-Identifier: GPL-2.0
> + *
> + * Copyright (C) 2019 Philippe Gerum  <rpm@xenomai.org>
> + */
> +
> +#ifndef _COBALT_KERNEL_IPIPE_THREAD_H
> +#define _COBALT_KERNEL_IPIPE_THREAD_H
> +
> +#include <linux/ipipe.h>

We also need linux/sched.h for older kernels (<= 4.14). Fixing up on merge.

Jan

> +
> +struct xnthread;
> +
> +#define cobalt_threadinfo ipipe_threadinfo
> +
> +static inline struct cobalt_threadinfo *pipeline_current(void)
> +{
> +	return ipipe_current_threadinfo();
> +}
> +
> +static inline struct xnthread *pipeline_thread_from_task(struct task_struct *p)
> +{
> +	return ipipe_task_threadinfo(p)->thread;
> +}
> +
> +#endif /* !_COBALT_KERNEL_IPIPE_THREAD_H */
> diff --git a/include/cobalt/kernel/thread.h b/include/cobalt/kernel/thread.h
> index 21a8603b4..2d57b8398 100644
> --- a/include/cobalt/kernel/thread.h
> +++ b/include/cobalt/kernel/thread.h
> @@ -22,6 +22,7 @@
>  #include <linux/wait.h>
>  #include <linux/sched.h>
>  #include <linux/sched/rt.h>
> +#include <pipeline/thread.h>
>  #include <cobalt/kernel/list.h>
>  #include <cobalt/kernel/stat.h>
>  #include <cobalt/kernel/timer.h>
> @@ -372,7 +373,7 @@ void __xnthread_discard(struct xnthread *thread);
>   */
>  static inline struct xnthread *xnthread_current(void)
>  {
> -	return ipipe_current_threadinfo()->thread;
> +	return pipeline_current()->thread;
>  }
>  
>  /**
> @@ -388,7 +389,7 @@ static inline struct xnthread *xnthread_current(void)
>   */
>  static inline struct xnthread *xnthread_from_task(struct task_struct *p)
>  {
> -	return ipipe_task_threadinfo(p)->thread;
> +	return pipeline_thread_from_task(p);
>  }
>  
>  /**
> diff --git a/kernel/cobalt/ipipe/kevents.c b/kernel/cobalt/ipipe/kevents.c
> index ba584677c..e0d4a1288 100644
> --- a/kernel/cobalt/ipipe/kevents.c
> +++ b/kernel/cobalt/ipipe/kevents.c
> @@ -831,16 +831,16 @@ static inline int get_mayday_prot(void)
>  
>  void pipeline_attach_current(struct xnthread *thread)
>  {
> -	struct ipipe_threadinfo *p;
> +	struct cobalt_threadinfo *p;
>  
> -	p = ipipe_current_threadinfo();
> +	p = pipeline_current();
>  	p->thread = thread;
>  	p->process = cobalt_search_process(current->mm);
>  }
>  
>  static void detach_current(void)
>  {
> -	struct ipipe_threadinfo *p = ipipe_current_threadinfo();
> +	struct cobalt_threadinfo *p = pipeline_current();
>  	p->thread = NULL;
>  	p->process = NULL;
>  }
> diff --git a/kernel/cobalt/posix/process.c b/kernel/cobalt/posix/process.c
> index 9bc6082d0..accd989ca 100644
> --- a/kernel/cobalt/posix/process.c
> +++ b/kernel/cobalt/posix/process.c
> @@ -463,7 +463,7 @@ EXPORT_SYMBOL_GPL(cobalt_unregister_personality);
>  struct xnthread_personality *
>  cobalt_push_personality(int xid)
>  {
> -	struct ipipe_threadinfo *p = ipipe_current_threadinfo();
> +	struct cobalt_threadinfo *p = pipeline_current();
>  	struct xnthread_personality *prev, *next;
>  	struct xnthread *thread = p->thread;
>  
> @@ -504,7 +504,7 @@ EXPORT_SYMBOL_GPL(cobalt_push_personality);
>   */
>  void cobalt_pop_personality(struct xnthread_personality *prev)
>  {
> -	struct ipipe_threadinfo *p = ipipe_current_threadinfo();
> +	struct cobalt_threadinfo *p = pipeline_current();
>  	struct xnthread *thread = p->thread;
>  
>  	secondary_mode_only();
> diff --git a/kernel/cobalt/posix/process.h b/kernel/cobalt/posix/process.h
> index 3a38ae639..a2f4ec591 100644
> --- a/kernel/cobalt/posix/process.h
> +++ b/kernel/cobalt/posix/process.h
> @@ -20,6 +20,7 @@
>  
>  #include <linux/list.h>
>  #include <linux/bitmap.h>
> +#include <pipeline/thread.h>
>  #include <cobalt/kernel/ppd.h>
>  
>  #define KEVENT_PROPAGATE   0
> @@ -94,13 +95,13 @@ extern struct cobalt_resources cobalt_global_resources;
>  
>  static inline struct cobalt_process *cobalt_current_process(void)
>  {
> -	return ipipe_current_threadinfo()->process;
> +	return pipeline_current()->process;
>  }
>  
>  static inline struct cobalt_process *
>  cobalt_set_process(struct cobalt_process *process)
>  {
> -	struct ipipe_threadinfo *p = ipipe_current_threadinfo();
> +	struct cobalt_threadinfo *p = pipeline_current();
>  	struct cobalt_process *old;
>  
>  	old = p->process;
> diff --git a/kernel/cobalt/thread.c b/kernel/cobalt/thread.c
> index a882bcc45..b871e6069 100644
> --- a/kernel/cobalt/thread.c
> +++ b/kernel/cobalt/thread.c
> @@ -2452,9 +2452,9 @@ static inline void wakeup_parent(struct completion *done)
>  
>  static inline void init_kthread_info(struct xnthread *thread)
>  {
> -	struct ipipe_threadinfo *p;
> +	struct cobalt_threadinfo *p;
>  
> -	p = ipipe_current_threadinfo();
> +	p = pipeline_current();
>  	p->thread = thread;
>  	p->process = NULL;
>  }
> 

-- 
Siemens AG, T RDA IOT
Corporate Competence Center Embedded Linux

