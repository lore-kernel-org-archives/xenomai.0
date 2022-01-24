Message-ID: <fb9acdbd-3a9b-ca15-c255-d85f0595078c@siemens.com>
Date: Mon, 24 Jan 2022 18:41:54 +0100
MIME-Version: 1.0
Subject: Re: [PATCH] cobalt: Fix pid issues when running in child pid namespace
Content-Language: en-US
References: <20220119133154.4122157-1-qiang1.zhang@intel.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <20220119133154.4122157-1-qiang1.zhang@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Zqiang <qiang1.zhang@intel.com>, xenomai@xenomai.org, MONTET Julien <julien.montet@reseau.eseo.fr>

On 19.01.22 14:31, Zqiang wrote:
> The Xenomai does not yet support the concept of namespaces,
> and the same task has different pids in its own pid namespace
> and parent pid namespace. however, when the task running in a
> child pid namespace, we only recorded the relationship between
> thread and child pid. so can't use other pid to find thread.
> 
> To fix it, when the thread is created, record all pid in
> different namespaces.
> 
> Updates: https://gitlab.com/Xenomai/xenomai-hacker-space/-/issues/19
> 

Can you help refreshing my memory on that and also explain why it takes 
a different approach than in [1]? That was reported to not work 
completely either, yes, but the RCU limitation is now gone with 
everything switched to Dovetail.

Adding also Julien again who thankfully help with testing back then.

Thanks,
Jan

[1] https://xenomai.org/pipermail/xenomai/2021-August/046090.html

> Signed-off-by: Zqiang <qiang1.zhang@intel.com>
> ---
>   kernel/cobalt/posix/thread.c | 107 ++++++++++++++++++++++++++++-------
>   kernel/cobalt/posix/thread.h |   7 +++
>   kernel/cobalt/posix/timer.c  |  15 ++++-
>   kernel/cobalt/posix/timer.h  |   2 +
>   4 files changed, 108 insertions(+), 23 deletions(-)
> 
> diff --git a/kernel/cobalt/posix/thread.c b/kernel/cobalt/posix/thread.c
> index 94a6e394e..c09c3d907 100644
> --- a/kernel/cobalt/posix/thread.c
> +++ b/kernel/cobalt/posix/thread.c
> @@ -55,39 +55,79 @@ static struct local_thread_hash *local_index[PTHREAD_HSLOTS];
>   
>   static struct global_thread_hash *global_index[PTHREAD_HSLOTS];
>   
> +static inline int thread_pid_init(struct cobalt_thread *thread)
> +{
> +	struct task_struct *tsk = current;
> +	struct pid *pid;
> +	int index;
> +	int ret = 0;
> +
> +	pid = get_task_pid(tsk, PIDTYPE_PID);
> +	thread->level = pid->level;
> +	thread->pid = xnmalloc((thread->level + 1) * sizeof(pid_t));
> +	if (thread->pid == NULL) {
> +		put_pid(pid);
> +		ret = -EINVAL;
> +		goto err;
> +	}
> +	thread->ns = xnmalloc((thread->level + 1) * sizeof(struct pid_namespcae *));
> +	if (thread->ns == NULL) {
> +		xnfree(thread->pid);
> +		put_pid(pid);
> +		ret = -EINVAL;
> +		goto err;
> +	}
> +	for (index = 0; index <= thread->level; index++) {
> +		thread->pid[index] = pid->numbers[index].nr;
> +		thread->ns[index] = pid->numbers[index].ns;
> +	}
> +	put_pid(pid);
> +err:
> +	return ret;
> +}
> +
>   static inline struct local_thread_hash *
>   thread_hash(const struct cobalt_local_hkey *hkey,
> -	    struct cobalt_thread *thread, pid_t pid)
> +	    struct cobalt_thread *thread)
>   {
>   	struct global_thread_hash **ghead, *gslot;
>   	struct local_thread_hash **lhead, *lslot;
>   	u32 hash;
>   	void *p;
>   	spl_t s;
> +	int index;
> +	pid_t pid;
>   
> -	p = xnmalloc(sizeof(*lslot) + sizeof(*gslot));
> +	p = xnmalloc(sizeof(*lslot) + (thread->level + 1) * sizeof(*gslot));
>   	if (p == NULL)
>   		return NULL;
>   
>   	lslot = p;
>   	lslot->hkey = *hkey;
>   	lslot->thread = thread;
> -	lslot->pid = pid;
> +	lslot->pid = thread->pid[thread->level];
>   	hash = jhash2((u32 *)&lslot->hkey,
>   		      sizeof(lslot->hkey) / sizeof(u32), 0);
>   	lhead = &local_index[hash & (PTHREAD_HSLOTS - 1)];
>   
>   	gslot = p + sizeof(*lslot);
> -	gslot->pid = pid;
> -	gslot->thread = thread;
> -	hash = jhash2((u32 *)&pid, sizeof(pid) / sizeof(u32), 0);
> -	ghead = &global_index[hash & (PTHREAD_HSLOTS - 1)];
> +	for (index = 0; index <= thread->level; index++) {
> +		pid = thread->pid[index];
> +		gslot->pid = pid;
> +		gslot->thread = thread;
> +		hash = jhash2((u32 *)&pid, sizeof(pid) / sizeof(u32), 0);
> +		ghead = &global_index[hash & (PTHREAD_HSLOTS - 1)];
> +
> +		xnlock_get_irqsave(&nklock, s);
> +		gslot->next = *ghead;
> +		*ghead = gslot;
> +		xnlock_put_irqrestore(&nklock, s);
> +		gslot++;
> +	}
>   
>   	xnlock_get_irqsave(&nklock, s);
>   	lslot->next = *lhead;
>   	*lhead = lslot;
> -	gslot->next = *ghead;
> -	*ghead = gslot;
>   	xnlock_put_irqrestore(&nklock, s);
>   
>   	return lslot;
> @@ -100,6 +140,8 @@ static inline void thread_unhash(const struct cobalt_local_hkey *hkey)
>   	pid_t pid;
>   	u32 hash;
>   	spl_t s;
> +	struct cobalt_thread *thread;
> +	int index;
>   
>   	hash = jhash2((u32 *) hkey, sizeof(*hkey) / sizeof(u32), 0);
>   	ltail = &local_index[hash & (PTHREAD_HSLOTS - 1)];
> @@ -120,24 +162,31 @@ static inline void thread_unhash(const struct cobalt_local_hkey *hkey)
>   	}
>   
>   	*ltail = lslot->next;
> -	pid = lslot->pid;
> -	hash = jhash2((u32 *)&pid, sizeof(pid) / sizeof(u32), 0);
> -	gtail = &global_index[hash & (PTHREAD_HSLOTS - 1)];
> -	gslot = *gtail;
> -	while (gslot && gslot->pid != pid) {
> -		gtail = &gslot->next;
> +
> +	thread = lslot->thread;
> +	for (index = 0; index <= thread->level; index++) {
> +		pid = thread->pid[index];
> +		hash = jhash2((u32 *)&pid, sizeof(pid) / sizeof(u32), 0);
> +		gtail = &global_index[hash & (PTHREAD_HSLOTS - 1)];
>   		gslot = *gtail;
> +		while (gslot && gslot->pid != pid) {
> +			gtail = &gslot->next;
> +			gslot = *gtail;
> +		}
> +
> +		/* gslot must be found here. */
> +		XENO_BUG_ON(COBALT, !(gslot && gtail));
> +		*gtail = gslot->next;
>   	}
> -	/* gslot must be found here. */
> -	XENO_BUG_ON(COBALT, !(gslot && gtail));
> -	*gtail = gslot->next;
>   
>   	xnlock_put_irqrestore(&nklock, s);
>   
>   	xnfree(lslot);
> +	xnfree(thread->pid);
> +	xnfree(thread->ns);
>   }
>   
> -static struct cobalt_thread *
> +struct cobalt_thread *
>   thread_lookup(const struct cobalt_local_hkey *hkey)
>   {
>   	struct local_thread_hash *lslot;
> @@ -160,16 +209,20 @@ thread_lookup(const struct cobalt_local_hkey *hkey)
>   
>   	return thread;
>   }
> +EXPORT_SYMBOL_GPL(thread_lookup);
>   
>   struct cobalt_thread *cobalt_thread_find(pid_t pid) /* nklocked, IRQs off */
>   {
>   	struct global_thread_hash *gslot;
>   	u32 hash;
> +	struct cobalt_thread *cur_thread = cobalt_current_thread();
> +	int level = cur_thread->level;
>   
>   	hash = jhash2((u32 *)&pid, sizeof(pid) / sizeof(u32), 0);
>   
>   	gslot = global_index[hash & (PTHREAD_HSLOTS - 1)];
> -	while (gslot && gslot->pid != pid)
> +	while ((gslot && gslot->pid != pid) ||
> +		(gslot->thread->ns[level] != cur_thread->ns[level]))
>   		gslot = gslot->next;
>   
>   	return gslot ? gslot->thread : NULL;
> @@ -625,7 +678,12 @@ int __cobalt_thread_create(unsigned long pth, int policy,
>   		return ret;
>   	}
>   
> -	if (!thread_hash(&hkey, thread, task_pid_vnr(p))) {
> +	if (thread_pid_init(thread) != 0) {
> +		ret = -EINVAL;
> +		goto fail;
> +	}
> +
> +	if (!thread_hash(&hkey, thread)) {
>   		ret = -EAGAIN;
>   		goto fail;
>   	}
> @@ -683,7 +741,12 @@ cobalt_thread_shadow(struct cobalt_local_hkey *hkey,
>   		return ERR_PTR(ret);
>   	}
>   
> -	if (!thread_hash(hkey, thread, task_pid_vnr(current))) {
> +	if (thread_pid_init(thread) != 0) {
> +		ret = -EINVAL;
> +		goto fail;
> +	}
> +
> +	if (!thread_hash(hkey, thread)) {
>   		ret = -EAGAIN;
>   		goto fail;
>   	}
> diff --git a/kernel/cobalt/posix/thread.h b/kernel/cobalt/posix/thread.h
> index 0959ff6d7..ab3cf6f5a 100644
> --- a/kernel/cobalt/posix/thread.h
> +++ b/kernel/cobalt/posix/thread.h
> @@ -104,6 +104,10 @@ struct cobalt_thread {
>   	struct list_head monitor_link;
>   
>   	struct cobalt_local_hkey hkey;
> +
> +	struct pid_namespace **ns;
> +	pid_t *pid;
> +	int level;
>   };
>   
>   struct cobalt_sigwait_context {
> @@ -150,6 +154,9 @@ struct cobalt_thread *cobalt_thread_find_local(pid_t pid);
>   
>   struct cobalt_thread *cobalt_thread_lookup(unsigned long pth);
>   
> +struct cobalt_thread *
> +thread_lookup(const struct cobalt_local_hkey *hkey);
> +
>   COBALT_SYSCALL_DECL(thread_create,
>   		    (unsigned long pth, int policy,
>   		     struct sched_param_ex __user *u_param,
> diff --git a/kernel/cobalt/posix/timer.c b/kernel/cobalt/posix/timer.c
> index a58ea99a3..34bbf0ef3 100644
> --- a/kernel/cobalt/posix/timer.c
> +++ b/kernel/cobalt/posix/timer.c
> @@ -25,6 +25,17 @@
>   #include "clock.h"
>   #include "signal.h"
>   
> +int cobalt_signal_send_hkey(struct cobalt_local_hkey *hkey, struct cobalt_sigpending *sigp)
> +{
> +	struct cobalt_thread *thread;
> +
> +	thread = thread_lookup(hkey);
> +	if (thread)
> +		return cobalt_signal_send(thread, sigp, 0);
> +
> +	return -ESRCH;
> +}
> +
>   void cobalt_timer_handler(struct xntimer *xntimer)
>   {
>   	struct cobalt_timer *timer;
> @@ -37,7 +48,7 @@ void cobalt_timer_handler(struct xntimer *xntimer)
>   	 */
>   	timer = container_of(xntimer, struct cobalt_timer, timerbase);
>   	if (timer->sigp.si.si_signo &&
> -	    cobalt_signal_send_pid(timer->target, &timer->sigp) == -ESRCH)
> +	    cobalt_signal_send_hkey(&timer->hkey, &timer->sigp) == -ESRCH)
>   		xntimer_stop(&timer->timerbase);
>   }
>   EXPORT_SYMBOL_GPL(cobalt_timer_handler);
> @@ -183,6 +194,8 @@ static inline int timer_create(clockid_t clockid,
>   		goto fail;
>   	}
>   
> +	timer->hkey.u_pth = target->hkey.u_pth;
> +	timer->hkey.mm = target->hkey.mm;
>   	timer->target = xnthread_host_pid(&target->threadbase);
>   	cc->timers[timer_id] = timer;
>   
> diff --git a/kernel/cobalt/posix/timer.h b/kernel/cobalt/posix/timer.h
> index 3b580d470..3d3c526f3 100644
> --- a/kernel/cobalt/posix/timer.h
> +++ b/kernel/cobalt/posix/timer.h
> @@ -24,6 +24,7 @@
>   #include <cobalt/kernel/timer.h>
>   #include <xenomai/posix/signal.h>
>   #include <xenomai/posix/syscall.h>
> +#include <xenomai/posix/thread.h>
>   
>   struct cobalt_timer {
>   	struct xntimer timerbase;
> @@ -31,6 +32,7 @@ struct cobalt_timer {
>   	int overruns;
>   	clockid_t clockid;
>   	pid_t target;
> +	struct cobalt_local_hkey hkey;
>   	struct cobalt_sigpending sigp;
>   	struct cobalt_extref extref;
>   };

-- 
Siemens AG, Technology
Competence Center Embedded Linux

