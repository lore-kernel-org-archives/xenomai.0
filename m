References: <20210312024223.22275-1-hongzhan.chen@intel.com>
From: Philippe Gerum <rpm@xenomai.org>
Subject: Re: [PATCH 1/2] cobalt/rtdm: introduce new interfaces to init task
In-reply-to: <20210312024223.22275-1-hongzhan.chen@intel.com>
Date: Sun, 14 Mar 2021 17:22:28 +0100
Message-ID: <87r1khg0xn.fsf@xenomai.org>
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

> Initialise and start a real-time task on specified cpu.
>
> Introduce rtdm_task_affinity as base called by other init
> task services to avoid code duplication.
>
> Signed-off-by: hongzha1 <hongzhan.chen@intel.com>
>
> diff --git a/include/cobalt/kernel/rtdm/driver.h b/include/cobalt/kernel/rtdm/driver.h
> index 733c49df8..5406e54a5 100644
> --- a/include/cobalt/kernel/rtdm/driver.h
> +++ b/include/cobalt/kernel/rtdm/driver.h
> @@ -1024,6 +1024,11 @@ typedef void (*rtdm_task_proc_t)(void *arg);
>  int rtdm_task_init(rtdm_task_t *task, const char *name,
>  		   rtdm_task_proc_t task_proc, void *arg,
>  		   int priority, nanosecs_rel_t period);
> +
> +int rtdm_task_init_on_cpu(rtdm_task_t *task, int cpu, const char *name,
> +		rtdm_task_proc_t task_proc, void *arg,
> +		int priority, nanosecs_rel_t period);
> +
>  int __rtdm_task_sleep(xnticks_t timeout, xntmode_t mode);
>  void rtdm_task_busy_sleep(nanosecs_rel_t delay);
>  
> diff --git a/kernel/cobalt/rtdm/drvlib.c b/kernel/cobalt/rtdm/drvlib.c
> index b914fa312..22ae79256 100644
> --- a/kernel/cobalt/rtdm/drvlib.c
> +++ b/kernel/cobalt/rtdm/drvlib.c
> @@ -86,13 +86,14 @@ nanosecs_abs_t rtdm_clock_read_monotonic(void);
>   */
>  
>  /**
> - * @brief Initialise and start a real-time task
> + * @brief Initialise and start a real-time task with cpu affinity
>   *
>   * After initialising a task, the task handle remains valid and can be
>   * passed to RTDM services until either rtdm_task_destroy() or
>   * rtdm_task_join() was invoked.
>   *
>   * @param[in,out] task Task handle
> + * @param[in] cpu affinity that task want to run with
>   * @param[in] name Optional task name
>   * @param[in] task_proc Procedure to be executed by the task
>   * @param[in] arg Custom argument passed to @c task_proc() on entry
> @@ -106,9 +107,10 @@ nanosecs_abs_t rtdm_clock_read_monotonic(void);
>   *
>   * @coretags{secondary-only, might-switch}
>   */
> -int rtdm_task_init(rtdm_task_t *task, const char *name,
> -		   rtdm_task_proc_t task_proc, void *arg,
> -		   int priority, nanosecs_rel_t period)
> +static inline int rtdm_task_affinity(rtdm_task_t *task,
> +		const struct cpumask *affinity, const char *name,
> +		rtdm_task_proc_t task_proc, void *arg,
> +		int priority, nanosecs_rel_t period)
>  {
>  	union xnsched_policy_param param;
>  	struct xnthread_start_attr sattr;
> @@ -121,7 +123,7 @@ int rtdm_task_init(rtdm_task_t *task, const char *name,
>  	iattr.name = name;
>  	iattr.flags = 0;
>  	iattr.personality = &xenomai_personality;
> -	iattr.affinity = CPU_MASK_ALL;
> +	iattr.affinity = affinity ? (*affinity) : CPU_MASK_ALL;
>  	param.rt.prio = priority;
>  
>  	err = xnthread_init(task, &iattr, &xnsched_class_rt, &param);
> @@ -155,8 +157,71 @@ int rtdm_task_init(rtdm_task_t *task, const char *name,
>  	return err;
>  }
>  
> +/**
> + * @brief Initialise and start a real-time task
> + *
> + * After initialising a task, the task handle remains valid and can be
> + * passed to RTDM services until either rtdm_task_destroy() or
> + * rtdm_task_join() was invoked.
> + *
> + * @param[in,out] task Task handle
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
> +int rtdm_task_init(rtdm_task_t *task, const char *name,
> +		   rtdm_task_proc_t task_proc, void *arg,
> +		   int priority, nanosecs_rel_t period)
> +{
> +	return rtdm_task_affinity(task, NULL,
> +			name, task_proc, arg, priority, period);
> +}
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
> +int rtdm_task_init_on_cpu(rtdm_task_t *task, int cpu,
> +		const char *name, rtdm_task_proc_t task_proc, void *arg,
> +		int priority, nanosecs_rel_t period)
> +{
> +	if (!cpu_online(cpu))
> +		return -EINVAL;
> +
> +	return rtdm_task_affinity(task, cpumask_of(cpu),
> +			name, task_proc, arg, priority, period);
> +
> +}
> +EXPORT_SYMBOL_GPL(rtdm_task_init_on_cpu);
> +
>  #ifdef DOXYGEN_CPP /* Only used for doxygen doc generation */
>  /**
>   * @brief Destroy a real-time task

Merged, thanks.

-- 
Philippe.

