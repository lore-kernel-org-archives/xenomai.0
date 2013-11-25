Message-ID: <52935EB4.9030306@xenomai.org>
Date: Mon, 25 Nov 2013 15:29:08 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <6e5a902f9794c477b1ae.1385378337@devws164.be.alcatel-lucent.com>
In-Reply-To: <6e5a902f9794c477b1ae.1385378337@devws164.be.alcatel-lucent.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] [PATCH v2] Xenomai-forge: pSOS add priority
	denormalize
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Kim De Mey <kim.demey@gmail.com>, xenomai@xenomai.org

On 11/25/2013 12:18 PM, Kim De Mey wrote:
> Add the psos_task_denormalize_priority() and psos_task_get_priority()
> functions. Use psos_task_get_priority() to fill oldprio_r in t_setpri().

Merged, thanks.

>
> Signed-off-by: Kim De Mey <kim.demey@gmail.com>
>
> ---
>
> v2: Removed the psos_task_get_priority() call from task.h
>
> diff --git a/include/psos/psos.h b/include/psos/psos.h
> --- a/include/psos/psos.h
> +++ b/include/psos/psos.h
> @@ -366,6 +366,7 @@ u_long tm_wkwhen(u_long date,
>   		 u_long ticks);
>
>   int psos_task_normalize_priority(unsigned long psos_prio);
> +int psos_task_denormalize_priority(unsigned long core_prio);
>
>   extern unsigned int psos_long_names;
>
> diff --git a/lib/psos/task.c b/lib/psos/task.c
> --- a/lib/psos/task.c
> +++ b/lib/psos/task.c
> @@ -236,6 +236,21 @@ int psos_task_normalize_priority(unsigne
>   	return psos_prio;
>   }
>
> +/*
> + * Although default pSOS priorities are mapped 1:1 to SCHED_RT,
> + * we do still have to use a denormalize function because these
> + * calls are weak and application code may be override the call
> + * and implement the mapping differently.
> + */
> +
> +__attribute__ ((weak))
> +int psos_task_denormalize_priority(unsigned long core_prio)
> +{
> +	/* Map a SCHED_RT priority level to a pSOS one. */
> +	return core_prio;
> +}
> +
> +
>   static int check_task_priority(u_long psos_prio, int *core_prio)
>   {
>   	if (psos_prio < 1 || psos_prio > 255) /* In theory. */
> @@ -246,6 +261,12 @@ static int check_task_priority(u_long ps
>   	return SUCCESS;
>   }
>
> +static int psos_task_get_priority(struct psos_task *task)
> +{
> +	int prio = threadobj_get_priority(&task->thobj);
> +	return psos_task_denormalize_priority(prio);
> +}
> +
>   u_long t_create(const char *name, u_long prio,
>   		u_long sstack, u_long ustack, u_long flags, u_long *tid_r)
>   {
> @@ -416,7 +437,7 @@ u_long t_setpri(u_long tid, u_long newpr
>   	if (task == NULL)
>   		return ret;
>
> -	*oldprio_r = threadobj_get_priority(&task->thobj);
> +	*oldprio_r = psos_task_get_priority(task);
>
>   	if (newprio == 0) { /* Only inquires for the task priority. */
>   		put_psos_task(task);
>
> _______________________________________________
> Xenomai mailing list
> Xenomai@xenomai.org
> http://www.xenomai.org/mailman/listinfo/xenomai
>


-- 
Philippe.

