References: <20210729144707.58398-1-florian.bezdeka@siemens.com>
From: Philippe Gerum <rpm@xenomai.org>
Subject: Re: [PATCH] cobalt/posix/mutex: Harmonize pthread_mutex_timedlock()
 and sem_timedwait()
In-reply-to: <20210729144707.58398-1-florian.bezdeka@siemens.com>
Date: Thu, 29 Jul 2021 17:06:01 +0200
Message-ID: <87k0l95fdy.fsf@xenomai.org>
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
To: Florian Bezdeka <florian.bezdeka@siemens.com>
Cc: xenomai@xenomai.org, jan.kiszka@siemens.com, chensong_2000@189.cn


Florian Bezdeka <florian.bezdeka@siemens.com> writes:

> According to the POSIX spec the value of the timeout parameter needs
> not to be validated if the mutex/semaphore could be taken immediately.
>
> While the implementation of the semaphore timedwait (sem_timedwait())
> allowed an invalid timeout pthread_mutex_timedlock() was failing with
> -EFAULT in case the mutex could be taken immediately.
>
> Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
> ---
>
> This was detected while preparing y2038 stuff. Not sure if that should
> go into 3.2. Comments welcome...
>

upsides: save a few cycles in the non-contended case by not copying in
the timeout from userland uselessly + might help passing some picky
POSIX compliance tests.

downside: adds an extra atomic op in the contended case.

> CCed Philippe because he was already involved some (long) time ago.
>

The patch looks good.

> Regards,
> Florian
>
>
>  kernel/cobalt/posix/mutex.c                |  5 ++
>  testsuite/smokey/posix-mutex/posix-mutex.c | 60 ++++++++++++++++++++++
>  2 files changed, 65 insertions(+)
>
> diff --git a/kernel/cobalt/posix/mutex.c b/kernel/cobalt/posix/mutex.c
> index 70fe7960a..01478978e 100644
> --- a/kernel/cobalt/posix/mutex.c
> +++ b/kernel/cobalt/posix/mutex.c
> @@ -167,6 +167,11 @@ redo:
>  	xnthread_commit_ceiling(curr);
>  
>  	if (xnsynch_owner_check(&mutex->synchbase, curr)) {
> +		/* Check if we can take the mutex immediately */
> +		ret = xnsynch_try_acquire(&mutex->synchbase);
> +		if (ret != -EBUSY)
> +			goto out;
> +
>  		if (fetch_timeout) {
>  			xnlock_put_irqrestore(&nklock, s);
>  			ret = fetch_timeout(&ts, u_ts);
> diff --git a/testsuite/smokey/posix-mutex/posix-mutex.c b/testsuite/smokey/posix-mutex/posix-mutex.c
> index e5793c42c..4aad24964 100644
> --- a/testsuite/smokey/posix-mutex/posix-mutex.c
> +++ b/testsuite/smokey/posix-mutex/posix-mutex.c
> @@ -1002,6 +1002,65 @@ static int protect_handover(void)
>  	return 0;
>  }
>  
> +static void *mutex_timed_locker_inv_timeout(void *arg)
> +{
> +	struct locker_context *p = arg;
> +	int ret;
> +
> +	if (__F(ret, pthread_mutex_timedlock(p->mutex, (void *) 0xdeadbeef)) &&
> +	    __Tassert(ret == -EFAULT))
> +		return (void *)1;
> +
> +	return NULL;
> +}
> +
> +static int check_timedlock_abstime_validation(void)
> +{
> +	struct locker_context args;
> +	pthread_mutex_t mutex;
> +	pthread_t tid;
> +	void *status;
> +	int ret;
> +
> +	if (!__T(ret, pthread_mutex_init(&mutex, NULL)))
> +		return ret;
> +
> +	/*
> +	 * We don't own the mutex yet, so no need to validate the timeout as
> +	 * the mutex can be locked immediately.
> +	 *
> +	 * The second parameter of phtread_mutex_timedlock() is flagged as
> +	 * __nonnull so we take an invalid address instead of NULL.
> +	 */
> +	if (!__T(ret, pthread_mutex_timedlock(&mutex, (void *) 0xdeadbeef)))
> +		return ret;
> +
> +	/*
> +	 * Create a second thread which will have to wait and therefore will
> +	 * validate the (invalid) timeout
> +	 */
> +	args.mutex = &mutex;
> +	ret = create_thread(&tid, SCHED_FIFO, THREAD_PRIO_LOW,
> +			    mutex_timed_locker_inv_timeout, &args);
> +
> +	if (ret)
> +		return ret;
> +
> +	if (!__T(ret, pthread_join(tid, &status)))
> +		return ret;
> +
> +	if (!__T(ret, pthread_mutex_unlock(&mutex)))
> +		return ret;
> +
> +	if (!__T(ret, pthread_mutex_destroy(&mutex)))
> +		return ret;
> +
> +	if (!__Fassert(status == NULL))
> +		return -EINVAL;
> +
> +	return 0;
> +}
> +
>  /* Detect obviously wrong execution times. */
>  static int check_time_limit(const struct timespec *start,
>  			    xnticks_t limit_ns)
> @@ -1065,6 +1124,7 @@ static int run_posix_mutex(struct smokey_test *t, int argc, char *const argv[])
>  	do_test(protect_dynamic, MAX_100_MS);
>  	do_test(protect_trylock, MAX_100_MS);
>  	do_test(protect_handover, MAX_100_MS);
> +	do_test(check_timedlock_abstime_validation, MAX_100_MS);
>  
>  	return 0;
>  }


-- 
Philippe.

