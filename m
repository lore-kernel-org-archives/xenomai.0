Message-ID: <5475CD50.6010602@siemens.com>
Date: Wed, 26 Nov 2014 13:53:36 +0100
From: Jan Kiszka <jan.kiszka@siemens.com>
MIME-Version: 1.0
References: <5474DB89.2070401@siemens.com> <5474E8A5.4060507@xenomai.org>
In-Reply-To: <5474E8A5.4060507@xenomai.org>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] __cobalt_thread_create: cleanup after failing
	cobalt_map_user
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Philippe Gerum <rpm@xenomai.org>, Xenomai <xenomai@xenomai.org>

On 2014-11-25 21:37, Philippe Gerum wrote:
> On 11/25/2014 08:42 PM, Jan Kiszka wrote:
>> Hi,
>>
>> I ran into an oops (bt below) when (for yet unknown reasons)
>> cobalt_map_user fails. The reason is that we then call xnthread_cancel,
>> but on a thread that has no user space task assigned yet.
>>
> 
> Ack, it's terminally broken.
> 
>> Which functions rolls only pthread_create back?
>>
> 
> None, we need one which specifically applies to a dormant, unmapped thread. The existing code assumes a mapped thread.
> 
>> The issue should apply to cobalt_thread_shadow as well.
>>
> 
> Correct. In theory, this patch should fix it. In practice, it's untested code in all its glory:

Looks good, test passed here.

> 
> diff --git a/include/cobalt/kernel/thread.h b/include/cobalt/kernel/thread.h
> index 72168f4..535489b 100644
> --- a/include/cobalt/kernel/thread.h
> +++ b/include/cobalt/kernel/thread.h
> @@ -332,6 +332,8 @@ void __xnthread_test_cancel(struct xnthread *curr);
>  
>  void __xnthread_cleanup(struct xnthread *curr);
>  
> +void __xnthread_discard(struct xnthread *thread);
> +
>  /**
>   * @fn struct xnthread *xnthread_current(void)
>   * @brief Retrieve the current Cobalt core TCB.
> diff --git a/kernel/cobalt/posix/thread.c b/kernel/cobalt/posix/thread.c
> index 3ab20f6..7c78405 100644
> --- a/kernel/cobalt/posix/thread.c
> +++ b/kernel/cobalt/posix/thread.c
> @@ -345,10 +345,10 @@ unlock_and_exit:
>  	return 0;
>  }
>  
> -static inline int pthread_create(struct cobalt_thread **thread_p,
> -				 int policy,
> -				 const struct sched_param_ex *param_ex,
> -				 struct task_struct *task)
> +static int pthread_create(struct cobalt_thread **thread_p,
> +			  int policy,
> +			  const struct sched_param_ex *param_ex,
> +			  struct task_struct *task)
>  {
>  	struct xnsched_class *sched_class;
>  	union xnsched_policy_param param;
> @@ -416,6 +416,20 @@ static inline int pthread_create(struct cobalt_thread **thread_p,
>  	return 0;
>  }
>  
> +static void pthread_discard(struct cobalt_thread *thread)
> +{
> +	spl_t s;
> +
> +	xnsynch_destroy(&thread->monitor_synch);
> +	xnsynch_destroy(&thread->sigwait);
> +
> +	xnlock_get_irqsave(&nklock, s);
> +	list_del(&thread->link);
> +	xnlock_put_irqrestore(&nklock, s);
> +	__xnthread_discard(&thread->threadbase);
> +	xnfree(thread);
> +}
> +
>  static inline int pthread_setmode_np(int clrmask, int setmask, int *mode_r)
>  {
>  	const int valid_flags = XNLOCK|XNWARN|XNTRAPLB;
> @@ -566,8 +580,10 @@ int __cobalt_thread_create(unsigned long pth, int policy,
>  		return ret;
>  
>  	ret = cobalt_map_user(&thread->threadbase, u_winoff);
> -	if (ret)
> -		goto fail;
> +	if (ret) {
> +		pthread_discard(thread);
> +		return ret;
> +	}
>  
>  	if (!thread_hash(&hkey, thread, task_pid_vnr(p))) {
>  		ret = -EAGAIN;
> @@ -617,11 +633,13 @@ cobalt_thread_shadow(struct task_struct *p,
>  	trace_cobalt_pthread_create(hkey->u_pth, SCHED_NORMAL, &param_ex);
>  	ret = pthread_create(&thread, SCHED_NORMAL, &param_ex, p);
>  	if (ret)
> -		return ERR_PTR(-ret);
> +		return ERR_PTR(ret);
>  
>  	ret = cobalt_map_user(&thread->threadbase, u_winoff);
> -	if (ret)
> -		goto fail;
> +	if (ret) {
> +		pthread_discard(thread);
> +		return ERR_PTR(ret);
> +	}

After removing this jump source of the fail label, you could fold the
latter into its last user.

Jan

>  
>  	if (!thread_hash(hkey, thread, task_pid_vnr(p))) {
>  		ret = -EAGAIN;
> diff --git a/kernel/cobalt/thread.c b/kernel/cobalt/thread.c
> index f5444d3..e7726dd 100644
> --- a/kernel/cobalt/thread.c
> +++ b/kernel/cobalt/thread.c
> @@ -492,6 +492,25 @@ void __xnthread_cleanup(struct xnthread *curr)
>  	wake_up(&nkjoinq);
>  }
>  
> +/*
> + * Unwinds xnthread_init() ops for an unmapped thread.  Since the
> + * latter must be dormant, it can't be part of any runqueue.
> + */
> +void __xnthread_discard(struct xnthread *thread)
> +{
> +	spl_t s;
> +
> +	xntimer_destroy(&thread->rtimer);
> +	xntimer_destroy(&thread->ptimer);
> +
> +	xnlock_get_irqsave(&nklock, s);
> +	list_del(&thread->glink);
> +	nknrthreads--;
> +	xnvfile_touch_tag(&nkthreadlist_tag);
> +	xnthread_deregister(thread);
> +	xnlock_put_irqrestore(&nklock, s);
> +}
> +
>  /**
>   * @fn void xnthread_init(struct xnthread *thread,const struct xnthread_init_attr *attr,struct xnsched_class *sched_class,const union xnsched_policy_param *sched_param)
>   * @brief Initialize a new thread.
> 

-- 
Siemens AG, Corporate Technology, CT RTC ITP SES-DE
Corporate Competence Center Embedded Linux

