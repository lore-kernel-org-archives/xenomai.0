Message-ID: <70be73c4-2b97-7a92-014d-5655a489a0b2@siemens.com>
Date: Mon, 4 Apr 2022 13:21:45 +0200
MIME-Version: 1.0
Subject: Re: [PATCH] Alchemy: Fix rt_task_unblock() for RT_MUTEX
Content-Language: en-US
References: <20220330201614.31083-1-richard@nod.at>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <20220330201614.31083-1-richard@nod.at>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Richard Weinberger <richard@nod.at>, xenomai@xenomai.org

On 30.03.22 22:16, Richard Weinberger via Xenomai wrote:
> Starting with Xenomai 3, RT_MUTEX is based on libcobalt's pthread mutex
> implementation.
> POSIX requires that pthread_mutex_lock() shall not return EINTR,
> this requirement breaks rt_task_unblock() if a RT_TASK blocks on
> a RT_MUTEX.
> 
> To restore the functionality provide a new function, pthread_mutex_lock_eintr_np().
> It can get interrupted and will return EINTR to the caller.
> 
> Signed-off-by: Richard Weinberger <richard@nod.at>
> ---
>  include/cobalt/pthread.h |  2 ++
>  lib/alchemy/mutex.c      |  2 +-
>  lib/cobalt/mutex.c       | 14 ++++++++++++--
>  3 files changed, 15 insertions(+), 3 deletions(-)
> 
> diff --git a/include/cobalt/pthread.h b/include/cobalt/pthread.h
> index 3e9bd47053bc..2994c2467219 100644
> --- a/include/cobalt/pthread.h
> +++ b/include/cobalt/pthread.h
> @@ -62,6 +62,8 @@ COBALT_DECL(int, pthread_mutex_destroy(pthread_mutex_t *mutex));
>  
>  COBALT_DECL(int, pthread_mutex_lock(pthread_mutex_t *mutex));
>  
> +COBALT_DECL(int, pthread_mutex_lock_eintr_np(pthread_mutex_t *mutex));
> +
>  COBALT_DECL(int, pthread_mutex_timedlock(pthread_mutex_t *mutex,
>  					 const struct timespec *to));
>  
> diff --git a/lib/alchemy/mutex.c b/lib/alchemy/mutex.c
> index f8933858647a..bb97395142aa 100644
> --- a/lib/alchemy/mutex.c
> +++ b/lib/alchemy/mutex.c
> @@ -327,7 +327,7 @@ int rt_mutex_acquire_timed(RT_MUTEX *mutex,
>  
>  	/* Slow path. */
>  	if (abs_timeout == NULL) {
> -		ret = -__RT(pthread_mutex_lock(&mcb->lock));
> +		ret = -__RT(pthread_mutex_lock_eintr_np(&mcb->lock));

This won't build for mercury, will it?

Jan

>  		goto done;
>  	}
>  
> diff --git a/lib/cobalt/mutex.c b/lib/cobalt/mutex.c
> index 73e45a1c4396..2ef02a175c13 100644
> --- a/lib/cobalt/mutex.c
> +++ b/lib/cobalt/mutex.c
> @@ -314,7 +314,7 @@ COBALT_IMPL(int, pthread_mutex_destroy, (pthread_mutex_t *mutex))
>   *
>   * @apitags{xthread-only, switch-primary}
>   */
> -COBALT_IMPL(int, pthread_mutex_lock, (pthread_mutex_t *mutex))
> +static int __pthread_mutex_lock(pthread_mutex_t *mutex, bool want_eintr)
>  {
>  	struct cobalt_mutex_shadow *_mutex =
>  		&((union cobalt_mutex_union *)mutex)->shadow_mutex;
> @@ -373,7 +373,7 @@ slow_path:
>  
>  	do
>  		ret = XENOMAI_SYSCALL1(sc_cobalt_mutex_lock, _mutex);
> -	while (ret == -EINTR);
> +	while (ret == -EINTR && !want_eintr);
>  
>  	if (ret == 0)
>  		_mutex->lockcnt = 1;
> @@ -392,6 +392,16 @@ protect:
>  	goto fast_path;
>  }
>  
> +COBALT_IMPL(int, pthread_mutex_lock, (pthread_mutex_t *mutex))
> +{
> +	return __pthread_mutex_lock(mutex, false);
> +}
> +
> +COBALT_IMPL(int, pthread_mutex_lock_eintr_np, (pthread_mutex_t *mutex))
> +{
> +	return __pthread_mutex_lock(mutex, true);
> +}
> +
>  /**
>   * Attempt, during a bounded time, to lock a mutex.
>   *

-- 
Siemens AG, Technology
Competence Center Embedded Linux

