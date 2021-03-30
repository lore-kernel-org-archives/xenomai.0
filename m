Subject: Re: [PATCH 4/8] lib: y2038: convert to internal timespec type
References: <20210327095417.2289913-1-rpm@xenomai.org>
 <20210327095417.2289913-5-rpm@xenomai.org>
From: Florian Bezdeka <florian.bezdeka@siemens.com>
Message-ID: <556e88f0-6b20-ab48-1d22-d0dcf8a2d8f0@siemens.com>
Date: Tue, 30 Mar 2021 23:20:11 +0200
In-Reply-To: <20210327095417.2289913-5-rpm@xenomai.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Philippe Gerum <rpm@xenomai.org>, chensong@tj.kylinos.cn
Cc: Jan Kiszka <jan.kiszka@siemens.com>, xenomai@xenomai.org

Hi Philippe,

which "internal timespec type" are you talking about? You're using
struct timespec here, which is not y2038 safe on 32 bit platforms.

I wonder about the effect of splitting the assignments into separate
tv_sec and tv_nsec assignements. I know this pattern from getting aware
of different paddings between kernel and user space in case we handle a
compat application, but this is all library stuff and compat
applications should use the compat syscalls which hopefully care about
different paddings...

On 27.03.21 10:54, Philippe Gerum via Xenomai wrote:
> From: Philippe Gerum <rpm@xenomai.org>
> 
> Signed-off-by: Philippe Gerum <rpm@xenomai.org>
> ---
>  lib/alchemy/task.c          | 9 ++++++---
>  lib/copperplate/threadobj.c | 9 ++++++---
>  lib/psos/task.c             | 9 ++++++---
>  lib/vxworks/kernLib.c       | 6 ++++--
>  lib/vxworks/taskLib.c       | 6 ++++--
>  5 files changed, 26 insertions(+), 13 deletions(-)
> 
> diff --git a/lib/alchemy/task.c b/lib/alchemy/task.c
> index 949a996d0..9afa2af57 100644
> --- a/lib/alchemy/task.c
> +++ b/lib/alchemy/task.c
> @@ -1410,11 +1410,14 @@ int rt_task_slice(RT_TASK *task, RTIME quantum)
>  
>  	param_ex.sched_priority = threadobj_get_priority(&tcb->thobj);
>  	if (quantum) {
> +		struct timespec ts;
>  		policy = SCHED_RR;
> -		clockobj_ticks_to_timespec(&alchemy_clock, quantum,
> -					   &param_ex.sched_rr_quantum);
> -	} else
> +		clockobj_ticks_to_timespec(&alchemy_clock, quantum, &ts);
> +		param_ex.sched_rr_quantum.tv_sec = ts.tv_sec;
> +		param_ex.sched_rr_quantum.tv_nsec = ts.tv_nsec;
> +	} else {
>  		policy = param_ex.sched_priority ? SCHED_FIFO : SCHED_OTHER;
> +	}
>  
>  	ret = threadobj_set_schedparam(&tcb->thobj, policy, &param_ex);
>  	switch (ret) {
> diff --git a/lib/copperplate/threadobj.c b/lib/copperplate/threadobj.c
> index a3101baa1..f4588a17a 100644
> --- a/lib/copperplate/threadobj.c
> +++ b/lib/copperplate/threadobj.c
> @@ -1741,7 +1741,8 @@ int threadobj_set_schedparam(struct threadobj *thobj, int policy,
>  		ret = enable_rr_corespec(thobj, param_ex);
>  		if (ret)
>  			return __bt(ret);
> -		thobj->tslice = param_ex->sched_rr_quantum;
> +		thobj->tslice.tv_sec = param_ex->sched_rr_quantum.tv_sec;
> +		thobj->tslice.tv_nsec = param_ex->sched_rr_quantum.tv_nsec;
>  	} else if (thobj->policy == SCHED_RR) /* Switching off round-robin. */
>  		disable_rr_corespec(thobj);
>  
> @@ -1761,8 +1762,10 @@ int threadobj_set_schedprio(struct threadobj *thobj, int priority)
>  	param_ex.sched_priority = priority;
>  	policy = thobj->policy;
>  
> -	if (policy == SCHED_RR)
> -		param_ex.sched_rr_quantum = thobj->tslice;
> +	if (policy == SCHED_RR) {
> +		param_ex.sched_rr_quantum.tv_sec = thobj->tslice.tv_sec;
> +		param_ex.sched_rr_quantum.tv_nsec = thobj->tslice.tv_nsec;
> +	}
>  
>  	return threadobj_set_schedparam(thobj, policy, &param_ex);
>  }
> diff --git a/lib/psos/task.c b/lib/psos/task.c
> index 46e49ea88..f678be61d 100644
> --- a/lib/psos/task.c
> +++ b/lib/psos/task.c
> @@ -192,7 +192,8 @@ static void *task_trampoline(void *arg)
>  
>  	if (task->mode & T_TSLICE) {
>  		param_ex.sched_priority = threadobj_get_priority(&task->thobj);
> -		param_ex.sched_rr_quantum = psos_rrperiod;
> +		param_ex.sched_rr_quantum.tv_sec = psos_rrperiod.tv_sec;
> +		param_ex.sched_rr_quantum.tv_nsec = psos_rrperiod.tv_nsec;
>  		threadobj_set_schedparam(&task->thobj, SCHED_RR, &param_ex);
>  	}
>  
> @@ -630,9 +631,11 @@ u_long t_mode(u_long mask, u_long newmask, u_long *oldmode_r)
>  
>  	if (task->mode & T_TSLICE) {
>  		policy = SCHED_RR;
> -		param_ex.sched_rr_quantum = psos_rrperiod;
> -	} else
> +		param_ex.sched_rr_quantum.tv_sec = psos_rrperiod.tv_sec;
> +		param_ex.sched_rr_quantum.tv_nsec = psos_rrperiod.tv_nsec;
> +	} else {
>  		policy = param_ex.sched_priority ? SCHED_FIFO : SCHED_OTHER;
> +	}
>  
>  	/* Working on self, so -EIDRM can't happen. */
>  	threadobj_set_schedparam(&task->thobj, policy, &param_ex);
> diff --git a/lib/vxworks/kernLib.c b/lib/vxworks/kernLib.c
> index 4f3bd8201..d67502730 100644
> --- a/lib/vxworks/kernLib.c
> +++ b/lib/vxworks/kernLib.c
> @@ -30,9 +30,11 @@ static int switch_slicing(struct threadobj *thobj, struct timespec *quantum)
>  
>  	if (quantum) {
>  		policy = SCHED_RR;
> -		param_ex.sched_rr_quantum = *quantum;
> -	} else
> +		param_ex.sched_rr_quantum.tv_sec = quantum->tv_sec;
> +		param_ex.sched_rr_quantum.tv_nsec = quantum->tv_nsec;
> +	} else {
>  		policy = param_ex.sched_priority ? SCHED_FIFO : SCHED_OTHER;
> +	}
>  
>  	return threadobj_set_schedparam(thobj, policy, &param_ex);

@Song:
Following this code paths brings me to
sc_cobalt_thread_setschedparam_ex, which is not yet part of our y2038
roadmap.


>  }
> diff --git a/lib/vxworks/taskLib.c b/lib/vxworks/taskLib.c
> index a4af36c1f..c8723c6be 100644
> --- a/lib/vxworks/taskLib.c
> +++ b/lib/vxworks/taskLib.c
> @@ -265,8 +265,10 @@ static void *task_trampoline(void *arg)
>  
>  	/* Turn on time slicing if RR globally enabled. */
>  	if (wind_time_slice) {
> -		clockobj_ticks_to_timespec(&wind_clock, wind_time_slice,
> -					   &param_ex.sched_rr_quantum);
> +		struct timespec ts;
> +		clockobj_ticks_to_timespec(&wind_clock, wind_time_slice, &ts);
> +		param_ex.sched_rr_quantum.tv_sec = ts.tv_sec;
> +		param_ex.sched_rr_quantum.tv_nsec = ts.tv_nsec;
>  		threadobj_lock(&task->thobj);
>  		param_ex.sched_priority = threadobj_get_priority(&task->thobj);
>  		threadobj_set_schedparam(&task->thobj, SCHED_RR, &param_ex);
> 


-- 
Siemens AG, T RDA IOT
Corporate Competence Center Embedded Linux

