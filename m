Subject: Re: [PATCH] cobalt: Sort out virtual vs. real pids
References: <af9a744d-9617-ed83-6391-edd5fd9ff26d@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <c4980c02-5264-811b-f0e0-fb3d336599c2@siemens.com>
Date: Thu, 8 Jul 2021 17:34:44 +0200
MIME-Version: 1.0
In-Reply-To: <af9a744d-9617-ed83-6391-edd5fd9ff26d@siemens.com>
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
To: Xenomai <xenomai@xenomai.org>
Cc: Marco Barletta <barlettamarco8@gmail.com>, MONTET Julien <julien.montet@reseau.eseo.fr>

On 08.07.21 17:17, Jan Kiszka via Xenomai wrote:
> From: Jan Kiszka <jan.kiszka@siemens.com>
> 
> Make sure that we consider all pids taken from or sent to userspace via
> syscalls as virtual. That means converting them to global pids before
> processing them or converting them back to virtual pids in the caller's
> namespace before reporting them.
> 
> Not converted is the procfs interface as this one continues to provide
> only a global view on cobalt objects and associated pids.
> 
> A view syscall tracepoints that report the vpid as passed down from
> userspace get adjusted in their output so that it is clear that no
> global pid is shown.
> 
> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
> ---
> 
> WARNING: This is only compile-tested so far. I'll push that into CI to 
> make sure that we have no regressions, but I still don't have a setup 
> actually stressing the pid namespace thing. So any feedback on how it 
> behaves would be very welcome!
> 
>  include/cobalt/kernel/thread.h     |  2 ++
>  kernel/cobalt/debug.c              |  2 +-
>  kernel/cobalt/posix/event.c        |  2 +-
>  kernel/cobalt/posix/mqueue.c       |  2 +-
>  kernel/cobalt/posix/process.c      | 14 ++++++++++++++
>  kernel/cobalt/posix/process.h      |  2 ++
>  kernel/cobalt/posix/sched.c        | 10 ++++++----
>  kernel/cobalt/posix/sem.c          |  2 +-
>  kernel/cobalt/posix/signal.c       | 10 ++++++----
>  kernel/cobalt/posix/thread.c       | 10 ++++++----
>  kernel/cobalt/thread.c             | 10 ++++++++++
>  kernel/cobalt/trace/cobalt-posix.h |  4 ++--
>  12 files changed, 52 insertions(+), 18 deletions(-)
> 
> diff --git a/include/cobalt/kernel/thread.h b/include/cobalt/kernel/thread.h
> index b79cb84296..4c8a0b9f2a 100644
> --- a/include/cobalt/kernel/thread.h
> +++ b/include/cobalt/kernel/thread.h
> @@ -450,6 +450,8 @@ char *xnthread_format_status(unsigned long status,
>  
>  pid_t xnthread_host_pid(struct xnthread *thread);
>  
> +pid_t xnthread_host_vpid(struct xnthread *thread);
> +
>  int xnthread_set_clock(struct xnthread *thread,
>  		       struct xnclock *newclock);
>  
> diff --git a/kernel/cobalt/debug.c b/kernel/cobalt/debug.c
> index a6e2cc42d3..4dd938be51 100644
> --- a/kernel/cobalt/debug.c
> +++ b/kernel/cobalt/debug.c
> @@ -292,7 +292,7 @@ void xndebug_trace_relax(int nr, unsigned long *backtrace,
>  	 */
>  	spot.depth = depth;
>  	spot.proghash = thread->proghash;
> -	spot.pid = xnthread_host_pid(thread);
> +	spot.pid = xnthread_host_vpid(thread);

Hmm, on second thought, I'm getting unsure about this one: The slackspot
analysis tool will likely run in the same namespace as the analyzed
threads, but its view via /proc/xenomai/debug/relax is global. So we
should likely continue to provide the global pid here.

The only proper solution to that would be reworking the /proc interface
and virtualizing its view. But that might not be worth the effort until
someone comes around with a really good use case.

Jan

>  	spot.reason = reason;
>  	strcpy(spot.thread, thread->name);
>  	hash = jhash2((u32 *)&spot, sizeof(spot) / sizeof(u32), 0);
> diff --git a/kernel/cobalt/posix/event.c b/kernel/cobalt/posix/event.c
> index 3712154f53..5871106301 100644
> --- a/kernel/cobalt/posix/event.c
> +++ b/kernel/cobalt/posix/event.c
> @@ -352,7 +352,7 @@ COBALT_SYSCALL(event_inquire, current,
>  		xnsynch_for_each_sleeper(thread, &event->synch) {
>  			if (nrwait >= nrpids)
>  				break;
> -			t[nrwait++] = xnthread_host_pid(thread);
> +			t[nrwait++] = xnthread_host_vpid(thread);
>  		}
>  	}
>  
> diff --git a/kernel/cobalt/posix/mqueue.c b/kernel/cobalt/posix/mqueue.c
> index dd8acd55b0..fcde87a077 100644
> --- a/kernel/cobalt/posix/mqueue.c
> +++ b/kernel/cobalt/posix/mqueue.c
> @@ -720,7 +720,7 @@ mq_notify(struct cobalt_mqd *mqd, unsigned index, const struct sigevent *evp)
>  		 * receiver's namespaces. We pass the receiver's creds
>  		 * into the init namespace instead.
>  		 */
> -		mq->si.si_pid = task_pid_nr(current);
> +		mq->si.si_pid = task_pid_vnr(current);
>  		mq->si.si_uid = get_current_uuid();
>  	}
>  
> diff --git a/kernel/cobalt/posix/process.c b/kernel/cobalt/posix/process.c
> index 76514ec82f..ad7def2f27 100644
> --- a/kernel/cobalt/posix/process.c
> +++ b/kernel/cobalt/posix/process.c
> @@ -1004,6 +1004,20 @@ int cobalt_handle_cleanup_event(struct mm_struct *mm)
>  	return KEVENT_PROPAGATE;
>  }
>  
> +pid_t cobalt_vpid2pid_nr(pid_t vpid)
> +{
> +	struct pid *pid;
> +	pid_t nr = -1;
> +
> +	rcu_read_lock();
> +	pid = find_vpid(vpid);
> +	if (pid)
> +		nr = pid_nr(pid);
> +	rcu_read_unlock();
> +
> +	return nr;
> +}
> +
>  static int attach_process(struct cobalt_process *process)
>  {
>  	struct cobalt_ppd *p = &process->sys_ppd;
> diff --git a/kernel/cobalt/posix/process.h b/kernel/cobalt/posix/process.h
> index 29294a8f60..c9bccdb361 100644
> --- a/kernel/cobalt/posix/process.h
> +++ b/kernel/cobalt/posix/process.h
> @@ -180,4 +180,6 @@ int cobalt_handle_cleanup_event(struct mm_struct *mm);
>  
>  int cobalt_handle_user_return(struct task_struct *task);
>  
> +pid_t cobalt_vpid2pid_nr(pid_t vpid);
> +
>  #endif /* !_COBALT_POSIX_PROCESS_H */
> diff --git a/kernel/cobalt/posix/sched.c b/kernel/cobalt/posix/sched.c
> index 4fd9c2b46e..26259fbd3f 100644
> --- a/kernel/cobalt/posix/sched.c
> +++ b/kernel/cobalt/posix/sched.c
> @@ -736,7 +736,7 @@ COBALT_SYSCALL(sched_weightprio, current,
>  	return __cobalt_sched_weightprio(policy, &param_ex);
>  }
>  
> -int cobalt_sched_setscheduler_ex(pid_t pid,
> +int cobalt_sched_setscheduler_ex(pid_t vpid,
>  				 int policy,
>  				 const struct sched_param_ex *param_ex,
>  				 __u32 __user *u_winoff,
> @@ -747,9 +747,11 @@ int cobalt_sched_setscheduler_ex(pid_t pid,
>  	int ret, promoted = 0;
>  	spl_t s;
>  
> -	trace_cobalt_sched_setscheduler(pid, policy, param_ex);
> +	trace_cobalt_sched_setscheduler(vpid, policy, param_ex);
> +
> +	if (vpid) {
> +		pid_t pid = cobalt_vpid2pid_nr(vpid);
>  
> -	if (pid) {
>  		xnlock_get_irqsave(&nklock, s);
>  		thread = cobalt_thread_find(pid);
>  		xnlock_put_irqrestore(&nklock, s);
> @@ -757,7 +759,7 @@ int cobalt_sched_setscheduler_ex(pid_t pid,
>  		thread = cobalt_current_thread();
>  
>  	if (thread == NULL) {
> -		if (u_winoff == NULL || pid != task_pid_vnr(current))
> +		if (u_winoff == NULL || vpid != task_pid_vnr(current))
>  			return -ESRCH;
>  			
>  		thread = cobalt_thread_shadow(&hkey, u_winoff);
> diff --git a/kernel/cobalt/posix/sem.c b/kernel/cobalt/posix/sem.c
> index 72b20c78d2..030ce8ffed 100644
> --- a/kernel/cobalt/posix/sem.c
> +++ b/kernel/cobalt/posix/sem.c
> @@ -602,7 +602,7 @@ COBALT_SYSCALL(sem_inquire, current,
>  		xnsynch_for_each_sleeper(thread, &sem->synchbase) {
>  			if (nrwait >= nrpids)
>  				break;
> -			t[nrwait++] = xnthread_host_pid(thread);
> +			t[nrwait++] = xnthread_host_vpid(thread);
>  		}
>  	}
>  
> diff --git a/kernel/cobalt/posix/signal.c b/kernel/cobalt/posix/signal.c
> index 0b43b5fcfa..c2c9c092c4 100644
> --- a/kernel/cobalt/posix/signal.c
> +++ b/kernel/cobalt/posix/signal.c
> @@ -510,7 +510,7 @@ int __cobalt_kill(struct cobalt_thread *thread, int sig, int group) /* nklocked,
>  			sigp->si.si_signo = sig;
>  			sigp->si.si_errno = 0;
>  			sigp->si.si_code = SI_USER;
> -			sigp->si.si_pid = task_pid_nr(current);
> +			sigp->si.si_pid = task_pid_vnr(current);
>  			sigp->si.si_uid = get_current_uuid();
>  			if (cobalt_signal_send(thread, sigp, group) <= 0)
>  				cobalt_signal_free(sigp);
> @@ -525,8 +525,9 @@ int __cobalt_kill(struct cobalt_thread *thread, int sig, int group) /* nklocked,
>  	return ret;
>  }
>  
> -COBALT_SYSCALL(kill, conforming, (pid_t pid, int sig))
> +COBALT_SYSCALL(kill, conforming, (pid_t vpid, int sig))
>  {
> +	pid_t pid = cobalt_vpid2pid_nr(vpid);
>  	struct cobalt_thread *thread;
>  	int ret;
>  	spl_t s;
> @@ -544,8 +545,9 @@ COBALT_SYSCALL(kill, conforming, (pid_t pid, int sig))
>  	return ret;
>  }
>  
> -int __cobalt_sigqueue(pid_t pid, int sig, const union sigval *value)
> +int __cobalt_sigqueue(pid_t vpid, int sig, const union sigval *value)
>  {
> +	pid_t pid = cobalt_vpid2pid_nr(vpid);
>  	struct cobalt_sigpending *sigp;
>  	struct cobalt_thread *thread;
>  	int ret = 0;
> @@ -569,7 +571,7 @@ int __cobalt_sigqueue(pid_t pid, int sig, const union sigval *value)
>  			sigp->si.si_signo = sig;
>  			sigp->si.si_errno = 0;
>  			sigp->si.si_code = SI_QUEUE;
> -			sigp->si.si_pid = task_pid_nr(current);
> +			sigp->si.si_pid = task_pid_vnr(current);
>  			sigp->si.si_uid = get_current_uuid();
>  			sigp->si.si_value = *value;
>  			if (cobalt_signal_send(thread, sigp, 1) <= 0)
> diff --git a/kernel/cobalt/posix/thread.c b/kernel/cobalt/posix/thread.c
> index cdeb66d4f3..d7c55df8f1 100644
> --- a/kernel/cobalt/posix/thread.c
> +++ b/kernel/cobalt/posix/thread.c
> @@ -819,7 +819,7 @@ COBALT_SYSCALL(thread_getpid, current, (unsigned long pth))
>  	if (thread == NULL)
>  		pid = -ESRCH;
>  	else
> -		pid = xnthread_host_pid(&thread->threadbase);
> +		pid = xnthread_host_vpid(&thread->threadbase);
>  
>  	xnlock_put_irqrestore(&nklock, s);
>  
> @@ -827,7 +827,7 @@ COBALT_SYSCALL(thread_getpid, current, (unsigned long pth))
>  }
>  
>  COBALT_SYSCALL(thread_getstat, current,
> -	       (pid_t pid, struct cobalt_threadstat __user *u_stat))
> +	       (pid_t vpid, struct cobalt_threadstat __user *u_stat))
>  {
>  	struct cobalt_threadstat stat;
>  	struct cobalt_thread *p;
> @@ -835,14 +835,16 @@ COBALT_SYSCALL(thread_getstat, current,
>  	xnticks_t xtime;
>  	spl_t s;
>  
> -	trace_cobalt_pthread_stat(pid);
> +	trace_cobalt_pthread_stat(vpid);
>  
> -	if (pid == 0) {
> +	if (vpid == 0) {
>  		thread = xnthread_current();
>  		if (thread == NULL)
>  			return -EPERM;
>  		xnlock_get_irqsave(&nklock, s);
>  	} else {
> +		pid_t pid = cobalt_vpid2pid_nr(vpid);
> +
>  		xnlock_get_irqsave(&nklock, s);
>  		p = cobalt_thread_find(pid);
>  		if (p == NULL) {
> diff --git a/kernel/cobalt/thread.c b/kernel/cobalt/thread.c
> index 2c1ec6d3a4..9a97213fbe 100644
> --- a/kernel/cobalt/thread.c
> +++ b/kernel/cobalt/thread.c
> @@ -388,6 +388,16 @@ pid_t xnthread_host_pid(struct xnthread *thread)
>  	return task_pid_nr(xnthread_host_task(thread));
>  }
>  
> +pid_t xnthread_host_vpid(struct xnthread *thread)
> +{
> +	if (xnthread_test_state(thread, XNROOT))
> +		return 0;
> +	if (!xnthread_host_task(thread))
> +		return -1;
> +
> +	return task_pid_vnr(xnthread_host_task(thread));
> +}
> +
>  int xnthread_set_clock(struct xnthread *thread, struct xnclock *newclock)
>  {
>  	spl_t s;
> diff --git a/kernel/cobalt/trace/cobalt-posix.h b/kernel/cobalt/trace/cobalt-posix.h
> index 1d623069df..d66053da8d 100644
> --- a/kernel/cobalt/trace/cobalt-posix.h
> +++ b/kernel/cobalt/trace/cobalt-posix.h
> @@ -246,7 +246,7 @@ DECLARE_EVENT_CLASS(cobalt_posix_scheduler,
>  		memcpy(__get_dynamic_array(param_ex), param_ex, sizeof(*param_ex));
>  	),
>  
> -	TP_printk("pid=%d policy=%s param={ %s }",
> +	TP_printk("vpid=%d policy=%s param={ %s }",
>  		  __entry->pid,
>  		  cobalt_print_sched_policy(__entry->policy),
>  		  __parse_sched_params(__entry->policy,
> @@ -363,7 +363,7 @@ DECLARE_EVENT_CLASS(cobalt_posix_pid,
>  	TP_fast_assign(
>  		__entry->pid = pid;
>  	),
> -	TP_printk("pid=%d", __entry->pid)
> +	TP_printk("vpid=%d", __entry->pid)
>  );
>  
>  DEFINE_EVENT(cobalt_posix_pid, cobalt_pthread_stat,
> 

-- 
Siemens AG, T RDA IOT
Corporate Competence Center Embedded Linux

