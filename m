References: <20210729144025.56162-1-florian.bezdeka@siemens.com>
From: Philippe Gerum <rpm@xenomai.org>
Subject: Re: [PATCH 2/2] cobalt/posix/mutex: Harmonize
 pthread_mutex_timedlock() and sem_timedwait()
In-reply-to: <20210729144025.56162-1-florian.bezdeka@siemens.com>
Date: Thu, 29 Jul 2021 16:47:52 +0200
Message-ID: <87mtq55g87.fsf@xenomai.org>
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
> CCed Philippe because he was already involved some (long) time ago.
>

I do agree wholeheartedly with the fundamental whitespace cleanup!

> Regards,
> Florian
>
>  testsuite/smokey/posix-mutex/posix-mutex.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/testsuite/smokey/posix-mutex/posix-mutex.c b/testsuite/smokey/posix-mutex/posix-mutex.c
> index 0f4dbe739..4aad24964 100644
> --- a/testsuite/smokey/posix-mutex/posix-mutex.c
> +++ b/testsuite/smokey/posix-mutex/posix-mutex.c
> @@ -1007,7 +1007,7 @@ static void *mutex_timed_locker_inv_timeout(void *arg)
>  	struct locker_context *p = arg;
>  	int ret;
>  
> -	if (__F(ret, pthread_mutex_timedlock(p->mutex, (void*) 0xdeadbeef)) &&
> +	if (__F(ret, pthread_mutex_timedlock(p->mutex, (void *) 0xdeadbeef)) &&
>  	    __Tassert(ret == -EFAULT))
>  		return (void *)1;
>  
> @@ -1032,7 +1032,7 @@ static int check_timedlock_abstime_validation(void)
>  	 * The second parameter of phtread_mutex_timedlock() is flagged as
>  	 * __nonnull so we take an invalid address instead of NULL.
>  	 */
> -	if (!__T(ret, pthread_mutex_timedlock(&mutex, (void*) 0xdeadbeef)))
> +	if (!__T(ret, pthread_mutex_timedlock(&mutex, (void *) 0xdeadbeef)))
>  		return ret;
>  
>  	/*

-- 
Philippe.

