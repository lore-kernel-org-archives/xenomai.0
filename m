Subject: Re: [PATCH v4 5/5] y2038: testsuite/smokey/y2038: Adding test cases
 for mutex_timedlock64()
References: <20210731070826.67908-1-florian.bezdeka@siemens.com>
 <20210731070826.67908-6-florian.bezdeka@siemens.com>
 <59ed96cc-f7e9-8559-d633-572720873341@siemens.com>
 <a0aeaf94-bdb8-9b32-5035-e457a2a1c6e9@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <8bc1813d-dc24-c519-2f00-9d65634a070b@siemens.com>
Date: Mon, 2 Aug 2021 12:27:11 +0200
MIME-Version: 1.0
In-Reply-To: <a0aeaf94-bdb8-9b32-5035-e457a2a1c6e9@siemens.com>
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
To: Florian Bezdeka <florian.bezdeka@siemens.com>, xenomai@xenomai.org

On 02.08.21 12:06, Florian Bezdeka wrote:
> On 02.08.21 11:45, Jan Kiszka wrote:
>> On 31.07.21 09:08, Florian Bezdeka wrote:
>>> This patch was based on the patch sent out by Song and reworked.
>>> Especially
>>>   - switched from CLOCK_MONOTONIC to CLOCK_REALTIME
>>>     According to POSIX this service is based on CLOCK_REALTIME
>>>
>>>   - Fixed some mutex leaks / missing pthread_mutex_destroy()
>>>
>>>   - Removed some magic numbers used for making sure the syscall does
>>>     not return too early
>>>
>>>   - Fixed several mutex deadlocks. Once mutex_timedlock() was
>>>     successful following calls will deadlock (as long as no special
>>>     DEADLOCK mutex is being used)
>>>
>>> Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
>>> ---
>>>  testsuite/smokey/y2038/syscall-tests.c | 187 +++++++++++++++++++++++++
>>>  1 file changed, 187 insertions(+)
>>>
>>> diff --git a/testsuite/smokey/y2038/syscall-tests.c b/testsuite/smokey/y2038/syscall-tests.c
>>> index 08506d086..2e8add864 100644
>>> --- a/testsuite/smokey/y2038/syscall-tests.c
>>> +++ b/testsuite/smokey/y2038/syscall-tests.c
>>> @@ -115,6 +115,45 @@ static inline bool ts_less(const struct xn_timespec64 *a,
>>>  	return false;
>>>  }
>>>  
>>> +/**
>>> + * Simple helper data structure for holding a thread context
>>> + */
>>> +struct thread_context {
>>> +	int sc_nr;
>>> +	pthread_mutex_t *mutex;
>>> +	struct xn_timespec64 *ts;
>>> +	bool timedwait_timecheck;
>>> +};
>>> +
>>> +/**
>>> + * Start the supplied function inside a separate thread, wait for completion
>>> + * and check the thread return value.
>>> + *
>>> + * @param thread The thread entry point
>>> + * @param arg The thread arguments
>>> + * @param exp_result The expected return value
>>> + *
>>> + * @return 0 if the thread reported @exp_result as return value, the thread's
>>> + * return value otherwise
>>> + */
>>> +static int run_thread(void *(*thread)(void *), void *arg, int exp_result)
>>> +{
>>> +	pthread_t tid;
>>> +	void *status;
>>> +	long res;
>>> +	int ret;
>>> +
>>> +	if (!__T(ret, pthread_create(&tid, NULL, thread, arg)))
>>> +		return ret;
>>> +
>>> +	if (!__T(ret, pthread_join(tid, &status)))
>>> +		return ret;
>>> +
>>> +	res = *((long *) status);
>>> +
>>> +	return (res == exp_result) ? 0 : ret;
>>> +}
>>> +
>>>  static int test_sc_cobalt_sem_timedwait64(void)
>>>  {
>>>  	int ret;
>>> @@ -404,6 +443,150 @@ static int test_sc_cobalt_clock_adjtime64(void)
>>>  	return 0;
>>>  }
>>>  
>>> +static void *timedlock64_thread(void *arg)
>>> +{
>>> +	struct thread_context *ctx = (struct thread_context *) arg;
>>> +	struct xn_timespec64 t1, t2;
>>> +	struct timespec ts_nat;
>>> +	int ret;
>>> +
>>> +	if (ctx->timedwait_timecheck) {
>>> +		if (!__T(ret, clock_gettime(CLOCK_REALTIME, &ts_nat)))
>>> +			return (void *)(long)ret;
>>> +
>>> +		t1.tv_sec = ts_nat.tv_sec;
>>> +		t1.tv_nsec = ts_nat.tv_nsec;
>>> +		ts_add_ns(&t1, ctx->ts->tv_nsec);
>>> +		ts_add_ns(&t1, ctx->ts->tv_sec * NSEC_PER_SEC);
>>> +	}
>>> +
>>> +	ret = XENOMAI_SYSCALL2(ctx->sc_nr, ctx->mutex, (void *) ctx->ts);
>>> +	if (ret)
>>> +		return (void *)(long)ret;
>>> +
>>> +	if (ctx->timedwait_timecheck) {
>>> +		if (!__T(ret, clock_gettime(CLOCK_REALTIME, &ts_nat)))
>>> +			return (void *)(long)ret;
>>> +
>>> +		t2.tv_sec = ts_nat.tv_sec;
>>> +		t2.tv_nsec = ts_nat.tv_nsec;
>>> +
>>> +		if (ts_less(&t2, &t1))
>>> +			smokey_warning("mutex_timedlock64 returned to early!\n"
>>> +				       "Expected wakeup at: %lld sec %lld nsec\n"
>>> +				       "Back at           : %lld sec %lld nsec\n",
>>> +				       t1.tv_sec, t1.tv_nsec, t2.tv_sec,
>>> +				       t2.tv_nsec);
>>> +	}
>>> +
>>> +	return (void *)(long)pthread_mutex_unlock(ctx->mutex);
>>> +}
>>> +
>>> +static int test_sc_cobalt_mutex_timedlock64(void)
>>> +{
>>> +	int ret;
>>> +	pthread_mutex_t mutex;
>>> +	int sc_nr = sc_cobalt_mutex_timedlock64;
>>> +	struct xn_timespec64 ts64;
>>> +	struct thread_context ctx = {0};
>>> +
>>> +	ret = pthread_mutex_init(&mutex, NULL);
>>> +
>>> +	/* Make sure we don't crash because of NULL pointers */
>>> +	ret = XENOMAI_SYSCALL2(sc_nr, NULL, NULL);
>>> +	if (ret == -ENOSYS) {
>>> +		smokey_note("mutex_timedlock64: skipped. (no kernel support)");
>>> +		return 0; // Not implemented, nothing to test, success
>>> +	}
>>> +	if (!smokey_assert(ret == -EINVAL))
>>> +		return ret ? ret : -EINVAL;
>>> +
>>> +	/*
>>> +	 * mutex can be taken immediately, no need to validate
>>> +	 * NULL should be allowed
>>> +	 */
>>> +	ret = XENOMAI_SYSCALL2(sc_nr, &mutex, NULL);
>>> +	if (!smokey_assert(!ret))
>>> +		return ret;
>>> +
>>> +	if (!__T(ret, pthread_mutex_unlock(&mutex)))
>>> +		return ret;
>>> +
>>> +	/*
>>> +	 * mutex can be taken immediately, no need to validate
>>> +	 * an invalid address should be allowed
>>> +	 */
>>> +	ret = XENOMAI_SYSCALL2(sc_nr, &mutex, 0xdeadbeef);
>>> +	if (!smokey_assert(!ret))
>>> +		return ret;
>>> +
>>> +	/*
>>> +	 * mutex still locked, second thread has to fail with -EINVAL when
>>> +	 * submitting NULL as timeout
>>> +	 */
>>> +	ctx.sc_nr = sc_nr;
>>> +	ctx.mutex = &mutex;
>>> +	ctx.ts = NULL;
>>> +	if (!__T(ret, run_thread(timedlock64_thread, &ctx, -EINVAL)))
>>> +		return ret;
>>> +
>>> +	/*
>>> +	 * mutex still locked, second thread has to fail with -EFAULT when
>>> +	 * submitting an invalid address as timeout
>>> +	 */
>>> +	ctx.ts = (void *) 0xdeadbeef;
>>> +	if (!__T(ret, run_thread(timedlock64_thread, &ctx, -EFAULT)))
>>> +		return ret;
>>> +
>>> +	/*
>>> +	 * mutex still locked, second thread has to fail with -EFAULT when
>>> +	 * submitting an invalid timeout (while the address is valid)
>>> +	 */
>>> +	ts64.tv_sec = -1;
>>> +	ctx.ts = &ts64;
>>> +	if (!__T(ret, run_thread(timedlock64_thread, &ctx, -EFAULT)))
>>> +		return ret;
>>> +
>>> +	/*
>>> +	 * mutex still locked, second thread has to fail with -ETIMEOUT when
>>> +	 * submitting a valid timeout
>>> +	 */
>>> +	ts64.tv_sec = 0;
>>> +	ts64.tv_nsec = 500;
>>> +	if (!__T(ret, run_thread(timedlock64_thread, &ctx, -ETIMEDOUT)))
>>> +		return ret;
>>> +
>>> +	if (!__T(ret, pthread_mutex_unlock(&mutex)))
>>> +		return ret;
>>> +
>>> +	/* mutex available, second thread should be able to lock and unlock */
>>> +	ts64.tv_sec = 0;
>>> +	ts64.tv_nsec = 500;
>>> +	if (!__T(ret, run_thread(timedlock64_thread, &ctx, 0)))
>>> +		return ret;
>>> +
>>> +	/*
>>> +	 * Locking the mutex here so the second thread has to deliver -ETIMEOUT.
>>> +	 * Timechecks will now be enabled to make sure we don't give up to early
>>> +	 */
>>> +	if (!__T(ret, pthread_mutex_lock(&mutex)))
>>> +		return ret;
>>> +
>>> +	ts64.tv_sec = 0;
>>> +	ts64.tv_nsec = 500;
>>> +	ctx.timedwait_timecheck = true;
>>> +	if (!__T(ret, run_thread(timedlock64_thread, &ctx, -ETIMEDOUT)))
>>> +		return ret;
>>> +
>>> +	if (!__T(ret, pthread_mutex_unlock(&mutex)))
>>> +		return ret;
>>> +
>>> +	if (!__T(ret, pthread_mutex_destroy(&mutex)))
>>> +		return ret;
>>> +
>>> +	return 0;
>>> +}
>>> +
>>>  static int run_y2038(struct smokey_test *t, int argc, char *const argv[])
>>>  {
>>>  	int ret;
>>> @@ -432,5 +615,9 @@ static int run_y2038(struct smokey_test *t, int argc, char *const argv[])
>>>  	if (ret)
>>>  		return ret;
>>>  
>>> +	ret = test_sc_cobalt_mutex_timedlock64();
>>> +	if (ret)
>>> +		return ret;
>>> +
>>>  	return 0;
>>>  }
>>>
>>
>> We have build errors, possibly due to this change. See e.g.
>>
>> https://source.denx.de/Xenomai/xenomai-images/-/jobs/302794
> 
> That's strange. Local build as well as the CI build done by the gitlab
> hackerspace project for the florian/y2038 is succesfull, but next is
> failing...
> 
> florian/y2038:
> https://gitlab.com/Xenomai/xenomai-hacker-space/-/pipelines/345882439
> 

I'm trying to convert ctx->timedwait_timecheck into a local var, maybe
that helps the compiler.

Jan

-- 
Siemens AG, T RDA IOT
Corporate Competence Center Embedded Linux

