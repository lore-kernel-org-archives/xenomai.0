Subject: Re: [PATCH 5/5] smokey: add tests for mutex/condvar autoinit
References: <20190307132159.31206-1-norbert.lange@andritz.com>
 <20190307132159.31206-5-norbert.lange@andritz.com>
From: Jan Kiszka <jan.kiszka@web.de>
Message-ID: <2d658a4f-758a-6d62-dc9e-25893c8afc6d@web.de>
Date: Mon, 1 Apr 2019 19:32:47 +0200
MIME-Version: 1.0
In-Reply-To: <20190307132159.31206-5-norbert.lange@andritz.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Norbert Lange <nolange79@gmail.com>, xenomai@xenomai.org

On 07.03.19 14:21, Norbert Lange via Xenomai wrote:
> add a few testcases whete dstroy is called as first function,

...where destroy...

> and test failure if the state is a non-standard initializater.
>

checkpatch run on this one as well, please.

> Signed-off-by: Norbert Lange <norbert.lange@andritz.com>
> ---
>   testsuite/smokey/posix-cond/posix-cond.c   | 14 ++++
>   testsuite/smokey/posix-mutex/posix-mutex.c | 93 ++++++++++++++++------
>   2 files changed, 84 insertions(+), 23 deletions(-)
>
> diff --git a/testsuite/smokey/posix-cond/posix-cond.c b/testsuite/smokey=
/posix-cond/posix-cond.c
> index 153c64599..ad915c724 100644
> --- a/testsuite/smokey/posix-cond/posix-cond.c
> +++ b/testsuite/smokey/posix-cond/posix-cond.c
> @@ -198,6 +198,19 @@ static void *cond_signaler(void *cookie)
>   	return NULL;
>   }
>
> +static void autoinit_simple_conddestroy(void)
> +{
> +	pthread_cond_t cond =3D PTHREAD_COND_INITIALIZER;
> +	pthread_cond_t cond2 =3D PTHREAD_COND_INITIALIZER;
> +	unsigned invalmagic =3D ~0x86860505; // ~COBALT_COND_MAGIC
> +
> +	memcpy((char *)&cond2 + sizeof(cond2) - sizeof(invalmagic), &invalmagi=
c, sizeof(invalmagic));
> +
> +	smokey_trace("%s", __func__);
> +	check("cond_destroy", cond_destroy(&cond), 0);
> +	check("cond_destroy invalid", cond_destroy(&cond2), -EINVAL);
> +}
> +
>   static void autoinit_simple_condwait(void)
>   {
>   	pthread_cond_t cond =3D PTHREAD_COND_INITIALIZER;
> @@ -731,6 +744,7 @@ int run_posix_cond(struct smokey_test *t, int argc, =
char *const argv[])
>   	sparam.sched_priority =3D 2;
>   	pthread_setschedparam(pthread_self(), SCHED_FIFO, &sparam);
>
> +	autoinit_simple_conddestroy();
>   	autoinit_simple_condwait();
>   	simple_condwait();
>   	relative_condwait();
> diff --git a/testsuite/smokey/posix-mutex/posix-mutex.c b/testsuite/smok=
ey/posix-mutex/posix-mutex.c
> index 182f8c0e5..a42c52033 100644
> --- a/testsuite/smokey/posix-mutex/posix-mutex.c
> +++ b/testsuite/smokey/posix-mutex/posix-mutex.c
> @@ -68,13 +68,13 @@ struct locker_context {
>   static void sleep_ms(unsigned int ms)	/* < 1000 */
>   {
>   	struct timespec ts;
> -
> +
>   	ts.tv_sec =3D 0;
>   	ts.tv_nsec =3D ms * 1000000;
>   	clock_nanosleep(CLOCK_MONOTONIC, 0, &ts, NULL);
>   }
>
> -static int get_effective_prio(void)
> +static int get_effective_prio(void)
>   {
>   	struct cobalt_threadstat stat;
>   	int ret;
> @@ -111,13 +111,13 @@ static int do_init_mutexattr(pthread_mutexattr_t *=
mattr, int type, int protocol)
>
>   	if (!__T(ret, pthread_mutexattr_init(mattr)))
>   		return ret;
> -
> +
>   	if (!__T(ret, pthread_mutexattr_settype(mattr, type)))
>   		return ret;
> -
> +
>   	if (!__T(ret, pthread_mutexattr_setprotocol(mattr, protocol)))
>   		return ret;
> -
> +
>   	if (!__T(ret, pthread_mutexattr_setpshared(mattr, PTHREAD_PROCESS_PRI=
VATE)))
>   		return ret;
>
> @@ -132,13 +132,13 @@ static int do_init_mutex(pthread_mutex_t *mutex, i=
nt type, int protocol)
>   	ret =3D do_init_mutexattr(&mattr, type, protocol);
>   	if (ret)
>   		return ret;
> -
> +
>   	if (!__T(ret, pthread_mutex_init(mutex, &mattr)))
>   		return ret;
>
>   	if (!__T(ret, pthread_mutexattr_destroy(&mattr)))
>   		return ret;
> -
> +
>   	return 0;
>   }
>
> @@ -150,7 +150,7 @@ static int do_init_mutex_ceiling(pthread_mutex_t *mu=
tex, int type, int prio)
>   	ret =3D do_init_mutexattr(&mattr, type, PTHREAD_PRIO_PROTECT);
>   	if (ret)
>   		return ret;
> -
> +
>   	if (!__T(ret, pthread_mutexattr_setprioceiling(&mattr, prio)))
>   		return ret;
>
> @@ -159,7 +159,7 @@ static int do_init_mutex_ceiling(pthread_mutex_t *mu=
tex, int type, int prio)
>
>   	if (!__T(ret, pthread_mutexattr_destroy(&mattr)))
>   		return ret;
> -
> +
>   	return 0;
>   }
>
> @@ -174,7 +174,7 @@ static void *mutex_timed_locker(void *arg)
>
>   	if (p->barrier)
>   		smokey_barrier_release(p->barrier);
> -
> +
>   	if (__F(ret, pthread_mutex_timedlock(p->mutex, &ts)) &&
>   	    __Tassert(ret =3D=3D -ETIMEDOUT))
>   		return (void *)1;
> @@ -197,7 +197,7 @@ static int do_timed_contend(pthread_mutex_t *mutex, =
int prio)
>   			    mutex_timed_locker, &args);
>   	if (ret)
>   		return ret;
> -
> +
>   	if (!__T(ret, pthread_join(tid, &status)))
>   		return ret;
>
> @@ -296,6 +296,28 @@ static int do_contend(pthread_mutex_t *mutex, int t=
ype)
>   	return 0;
>   }
>
> +static int do_destroy(pthread_mutex_t *mutex, pthread_mutex_t *invalmut=
ex, int type)
> +{
> +	int ret;
> +	if (!__T(ret, pthread_mutex_destroy(mutex)))
> +		return ret;
> +	if (!__F(ret, pthread_mutex_destroy(invalmutex)) &&
> +		__Tassert(ret =3D=3D -EINVAL))
> +		return -1;
> +	return 0;
> +}
> +
> +static int static_init_normal_destroy(void)
> +{
> +	pthread_mutex_t mutex =3D PTHREAD_MUTEX_INITIALIZER;
> +	pthread_mutex_t invalmutex =3D PTHREAD_MUTEX_INITIALIZER;
> +
> +	unsigned invalmagic =3D ~0x86860303; // ~COBALT_MUTEX_MAGIC
> +
> +	memcpy((char *)&invalmutex + sizeof(invalmutex) - sizeof(invalmagic), =
&invalmagic, sizeof(invalmagic));
> +	return do_destroy(&mutex, &invalmutex, PTHREAD_MUTEX_NORMAL);
> +}
> +
>   static int static_init_normal_contend(void)
>   {
>   	pthread_mutex_t mutex =3D PTHREAD_MUTEX_INITIALIZER;
> @@ -311,7 +333,7 @@ static int __dynamic_init_contend(int type)
>   	ret =3D do_init_mutex(&mutex, type, PTHREAD_PRIO_NONE);
>   	if (ret)
>   		return ret;
> -
> +
>   	return do_contend(&mutex, type);
>   }
>
> @@ -320,6 +342,17 @@ static int dynamic_init_normal_contend(void)
>   	return __dynamic_init_contend(PTHREAD_MUTEX_NORMAL);
>   }
>
> +static int static_init_recursive_destroy(void)
> +{
> +	pthread_mutex_t mutex =3D PTHREAD_RECURSIVE_MUTEX_INITIALIZER_NP;
> +	pthread_mutex_t invalmutex =3D PTHREAD_RECURSIVE_MUTEX_INITIALIZER_NP;
> +
> +	unsigned invalmagic =3D ~0x86860303; // ~COBALT_MUTEX_MAGIC
> +
> +	memcpy((char *)&invalmutex + sizeof(invalmutex) - sizeof(invalmagic), =
&invalmagic, sizeof(invalmagic));
> +	return do_destroy(&mutex, &invalmutex, PTHREAD_MUTEX_RECURSIVE);
> +}
> +
>   static int static_init_recursive_contend(void)
>   {
>   	pthread_mutex_t mutex =3D PTHREAD_RECURSIVE_MUTEX_INITIALIZER_NP;
> @@ -332,6 +365,17 @@ static int dynamic_init_recursive_contend(void)
>   	return __dynamic_init_contend(PTHREAD_MUTEX_RECURSIVE);
>   }
>
> +static int static_init_errorcheck_destroy(void)
> +{
> +	pthread_mutex_t mutex =3D PTHREAD_ERRORCHECK_MUTEX_INITIALIZER_NP;
> +	pthread_mutex_t invalmutex =3D PTHREAD_ERRORCHECK_MUTEX_INITIALIZER_NP=
;
> +
> +	unsigned invalmagic =3D ~0x86860303; // ~COBALT_MUTEX_MAGIC
> +
> +	memcpy((char *)&invalmutex + sizeof(invalmutex) - sizeof(invalmagic), =
&invalmagic, sizeof(invalmagic));
> +	return do_destroy(&mutex, &invalmutex, PTHREAD_MUTEX_ERRORCHECK);
> +}
> +
>   static int static_init_errorcheck_contend(void)
>   {
>   	pthread_mutex_t mutex =3D PTHREAD_ERRORCHECK_MUTEX_INITIALIZER_NP;
> @@ -381,7 +425,7 @@ static int weak_mode_switch(void)
>   		return -EINVAL;
>
>   	/* Enter SCHED_WEAK scheduling. */
> -
> +
>   	if (!__T(ret, pthread_setschedparam(pthread_self(),
>   					    SCHED_OTHER, &param)))
>   		return ret;
> @@ -405,7 +449,7 @@ static int weak_mode_switch(void)
>   		return ret;
>
>   	/* Dropped it, we should have relaxed in the same move. */
> -
> +
>   	mode =3D cobalt_thread_mode();
>   	if (!__Tassert((mode & (XNWEAK|XNRELAX)) =3D=3D (XNWEAK|XNRELAX)))
>   		return -EINVAL;
> @@ -460,7 +504,7 @@ static int do_pi_contend(int prio)
>   	 */
>   	if (!__Tassert(get_effective_prio() =3D=3D prio))
>   		return -EINVAL;
> -
> +
>   	if (!__T(ret, pthread_join(tid, &status)))
>   		return ret;
>
> @@ -489,7 +533,7 @@ static void *mutex_locker_steal(void *arg)
>   	int ret;
>
>   	smokey_barrier_release(p->barrier);
> -
> +
>   	if (!__T(ret, pthread_mutex_lock(p->mutex)))
>   		return (void *)(long)ret;
>
> @@ -623,7 +667,7 @@ static int protect_raise(void)
>   	/* We should have been given a MEDIUM -> HIGH boost. */
>   	if (!__Tassert(get_effective_prio() =3D=3D THREAD_PRIO_HIGH))
>   		return -EINVAL;
> -
> +
>   	if (!__T(ret, pthread_mutex_unlock(&mutex)))
>   		return ret;
>
> @@ -654,7 +698,7 @@ static int protect_lower(void)
>   	/* No boost should be applied. */
>   	if (!__Tassert(get_effective_prio() =3D=3D THREAD_PRIO_MEDIUM))
>   		return -EINVAL;
> -
> +
>   	if (!__T(ret, pthread_mutex_unlock(&mutex)))
>   		return ret;
>
> @@ -700,7 +744,7 @@ static int protect_weak(void)
>   	/* We should have been sent to SCHED_FIFO, THREAD_PRIO_HIGH. */
>   	if (!__Tassert(get_effective_prio() =3D=3D THREAD_PRIO_HIGH))
>   		return -EINVAL;
> -
> +
>   	if (!__T(ret, pthread_mutex_unlock(&mutex)))
>   		return ret;
>
> @@ -754,7 +798,7 @@ static int protect_nesting_protect(void)
>
>   	if (!__Tassert(get_effective_prio() =3D=3D THREAD_PRIO_HIGH))
>   		return -EINVAL;
> -
> +
>   	if (!__T(ret, pthread_mutex_unlock(&mutex_high)))
>   		return ret;
>
> @@ -786,7 +830,7 @@ static int protect_nesting_pi(void)
>   	/* PP ceiling: MEDIUM -> HIGH */
>   	if (!__Tassert(get_effective_prio() =3D=3D THREAD_PRIO_HIGH))
>   		return -EINVAL;
> -
> +
>   	/* PI boost expected: HIGH -> VERY_HIGH, then back to HIGH */
>   	ret =3D do_pi_contend(THREAD_PRIO_VERY_HIGH);
>   	if (ret)
> @@ -794,7 +838,7 @@ static int protect_nesting_pi(void)
>
>   	if (!__Tassert(get_effective_prio() =3D=3D THREAD_PRIO_HIGH))
>   		return -EINVAL;
> -
> +
>   	if (!__T(ret, pthread_mutex_unlock(&mutex_pp)))
>   		return ret;
>
> @@ -833,7 +877,7 @@ static int protect_dynamic(void)
>   	/* We should have been given a HIGH -> VERY_HIGH boost. */
>   	if (!__Tassert(get_effective_prio() =3D=3D THREAD_PRIO_VERY_HIGH))
>   		return -EINVAL;
> -
> +
>   	if (!__T(ret, pthread_mutex_unlock(&mutex)))
>   		return ret;
>
> @@ -991,10 +1035,13 @@ static int run_posix_mutex(struct smokey_test *t,=
 int argc, char *const argv[])
>   					    SCHED_FIFO, &param)))
>   		return ret;
>
> +	do_test(static_init_normal_destroy, MAX_100_MS);
>   	do_test(static_init_normal_contend, MAX_100_MS);
>   	do_test(dynamic_init_normal_contend, MAX_100_MS);
> +	do_test(static_init_recursive_destroy, MAX_100_MS);
>   	do_test(static_init_recursive_contend, MAX_100_MS);
>   	do_test(dynamic_init_recursive_contend, MAX_100_MS);
> +	do_test(static_init_errorcheck_destroy, MAX_100_MS);
>   	do_test(static_init_errorcheck_contend, MAX_100_MS);
>   	do_test(dynamic_init_errorcheck_contend, MAX_100_MS);
>   	do_test(timed_contend, MAX_100_MS);
>

I'm generally fine with sneaking some style fixes into a function change. =
This
one is on the edge, actually more beyond it, as there are quite a few, com=
pared
to functional changes. When respinning this series, please split that up.

Jan

