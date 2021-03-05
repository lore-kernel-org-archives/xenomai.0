References: <20210220055311.23826-1-hongzhan.chen@intel.com>
From: Philippe Gerum <rpm@xenomai.org>
Subject: Re: [PATCH 1/5] cobalt/rtdm: add new interface to init task on
 specified cpu
In-reply-to: <20210220055311.23826-1-hongzhan.chen@intel.com>
Date: Fri, 05 Mar 2021 12:45:32 +0100
Message-ID: <875z25ygbn.fsf@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: hongzha1 <hongzhan.chen@intel.com>
Cc: xenomai@xenomai.org


hongzha1 via Xenomai <xenomai@xenomai.org> writes:

> Initialise and start a real-time task on specified cpu
>
> Signed-off-by: hongzha1 <hongzhan.chen@intel.com>
>
> diff --git a/include/cobalt/kernel/rtdm/driver.h b/include/cobalt/kernel/rtdm/driver.h
> index 733c49df8..6cdace324 100644
> --- a/include/cobalt/kernel/rtdm/driver.h
> +++ b/include/cobalt/kernel/rtdm/driver.h
> @@ -1024,6 +1024,9 @@ typedef void (*rtdm_task_proc_t)(void *arg);
>  int rtdm_task_init(rtdm_task_t *task, const char *name,
>  		   rtdm_task_proc_t task_proc, void *arg,
>  		   int priority, nanosecs_rel_t period);
> +int rtdm_task_init_on_cpu(rtdm_task_t *task, int cpu, const char *name,
> +		rtdm_task_proc_t task_proc, void *arg,
> +		int priority, nanosecs_rel_t period);
>  int __rtdm_task_sleep(xnticks_t timeout, xntmode_t mode);
>  void rtdm_task_busy_sleep(nanosecs_rel_t delay);
>  
> diff --git a/kernel/cobalt/rtdm/drvlib.c b/kernel/cobalt/rtdm/drvlib.c
> index b914fa312..7452850b7 100644
> --- a/kernel/cobalt/rtdm/drvlib.c
> +++ b/kernel/cobalt/rtdm/drvlib.c
> @@ -157,6 +157,79 @@ int rtdm_task_init(rtdm_task_t *task, const char *name,
>  
>  EXPORT_SYMBOL_GPL(rtdm_task_init);
>  
> +/**
> + * @brief Initialise and start a real-time task on specified cpu
> + *
> + * After initialising a task, the task handle remains valid and can be
> + * passed to RTDM services until either rtdm_task_destroy() or
> + * rtdm_task_join() was invoked.
> + *
> + * @param[in,out] task Task handle
> + * @param[in] cpu that task want to run on
> + * @param[in] name Optional task name
> + * @param[in] task_proc Procedure to be executed by the task
> + * @param[in] arg Custom argument passed to @c task_proc() on entry
> + * @param[in] priority Priority of the task, see also
> + * @ref rtdmtaskprio "Task Priority Range"
> + * @param[in] period Period in nanoseconds of a cyclic task, 0 for non-cyclic
> + * mode. Waiting for the first and subsequent periodic events is
> + * done using rtdm_task_wait_period().
> + *
> + * @return 0 on success, otherwise negative error code
> + *
> + * @coretags{secondary-only, might-switch}
> + */
> +int rtdm_task_init_on_cpu(rtdm_task_t *task, int cpu, const char *name,
> +		rtdm_task_proc_t task_proc, void *arg,
> +		int priority, nanosecs_rel_t period)
> +{
> +	union xnsched_policy_param param;
> +	struct xnthread_start_attr sattr;
> +	struct xnthread_init_attr iattr;
> +	int err;
> +
> +	if (!realtime_core_enabled())
> +		return -ENOSYS;
> +
> +	iattr.name = name;
> +	iattr.flags = 0;
> +	iattr.personality = &xenomai_personality;
> +	iattr.affinity = *cpumask_of(cpu);

We should probably check cpu for validity first, I don't think
cpumask_of() does it (e.g. cpu_online(cpu) would ensure both validity
and online presence).

> +	param.rt.prio = priority;
> +
> +	err = xnthread_init(task, &iattr, &xnsched_class_rt, &param);
> +	if (err)
> +		return err;
> +
> +	/* We need an anonymous registry entry to obtain a handle for fast
> +	 * mutex locking.
> +	 */
> +	err = xnthread_register(task, "");
> +	if (err)
> +		goto cleanup_out;
> +
> +	if (period > 0) {
> +		err = xnthread_set_periodic(task, XN_INFINITE,
> +					    XN_RELATIVE, period);
> +		if (err)
> +			goto cleanup_out;
> +	}
> +
> +	sattr.mode = 0;
> +	sattr.entry = task_proc;
> +	sattr.cookie = arg;
> +	err = xnthread_start(task, &sattr);
> +	if (err)
> +		goto cleanup_out;
> +
> +	return 0;
> +
> +cleanup_out:
> +	xnthread_cancel(task);
> +	return err;
> +}
> +EXPORT_SYMBOL_GPL(rtdm_task_init_on_cpu);
> +
>  #ifdef DOXYGEN_CPP /* Only used for doxygen doc generation */
>  /**
>   * @brief Destroy a real-time task

Looks good. We may want to implement rtdm_task_init_cpu() as an inline
variant calling rtdm_task_init_on_cpu() with the current CPU number, to
prevent code duplication.

-- 
Philippe.

