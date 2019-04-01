Subject: Re: [PATCH 1/5] libcobalt: improve mutex autoinit support
References: <20190307132159.31206-1-norbert.lange@andritz.com>
From: Jan Kiszka <jan.kiszka@web.de>
Message-ID: <38d89b22-4ef1-a891-a931-c7f37d98ab76@web.de>
Date: Mon, 1 Apr 2019 19:19:15 +0200
MIME-Version: 1.0
In-Reply-To: <20190307132159.31206-1-norbert.lange@andritz.com>
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

Hi Norbert,

thanks for the patches, and sorry for the late reply.

On 07.03.19 14:21, Norbert Lange via Xenomai wrote:
> contrary to some comments, mutexes are automatically
> initialised on lock/unlock.
> Correct the destroy method to not report an
> error on such mutexes.
>
> {get,set}prioceiling requires mutexes that were explicitely
> initialised, so no change needed there
>
> Signed-off-by: Norbert Lange <norbert.lange@andritz.com>
> ---
>   lib/cobalt/mutex.c | 190 +++++++++++++++++++++++----------------------
>   1 file changed, 98 insertions(+), 92 deletions(-)
>
> diff --git a/lib/cobalt/mutex.c b/lib/cobalt/mutex.c
> index ed32bba32..be9f6ed80 100644
> --- a/lib/cobalt/mutex.c
> +++ b/lib/cobalt/mutex.c
> @@ -164,70 +164,51 @@ COBALT_IMPL(int, pthread_mutex_init, (pthread_mute=
x_t *mutex,
>   }
>
>   /**
> - * Destroy a mutex.
> - *
> - * This service destroys the mutex @a mx, if it is unlocked and not ref=
erenced
> - * by any condition variable. The mutex becomes invalid for all mutex s=
ervices
> - * (they all return the EINVAL error) except pthread_mutex_init().
> - *
> - * @param mutex the mutex to be destroyed.
> - *
> - * @return 0 on success,
> - * @return an error number if:
> - * - EINVAL, the mutex @a mx is invalid;
> - * - EPERM, the mutex is not process-shared and does not belong to the =
current
> - *   process;
> - * - EBUSY, the mutex is locked, or used by a condition variable.
> + * Test if a mutex structure contains an valid autoinitializer.

...a valid...

>    *
> - * @see
> - * <a href=3D"http://www.opengroup.org/onlinepubs/000095399/functions/p=
thread_mutex_destroy.html">
> - * Specification.</a>
> - *
> - * @apitags{thread-unrestricted}
> + * @return the mutex type on success,
> + * @return -1 if not in supported autoinitializer state
>    */
> -COBALT_IMPL(int, pthread_mutex_destroy, (pthread_mutex_t *mutex))
> +static int __attribute__((cold)) _cobalt_mutex_autoinit_type(const pthr=
ead_mutex_t *mutex)

Overlong line.

And why the leading underscore in "_cobalt_..."?

>   {
> -	struct cobalt_mutex_shadow *_mutex =3D
> -		&((union cobalt_mutex_union *)mutex)->shadow_mutex;
> -	int err;
> -
> -	if (_mutex->magic !=3D COBALT_MUTEX_MAGIC)
> -		return EINVAL;
> -
> -	err =3D XENOMAI_SYSCALL1(sc_cobalt_mutex_destroy, _mutex);
> -
> -	return -err;
> -}
> -
> -static int __attribute__((cold)) cobalt_mutex_autoinit(pthread_mutex_t =
*mutex)
> -{
> -	static pthread_mutex_t uninit_normal_mutex =3D
> -		PTHREAD_MUTEX_INITIALIZER;
> +	static const pthread_mutex_t mutex_initializers[] =3D {
> +#if HAVE_DECL_PTHREAD_ERRORCHECK_MUTEX_INITIALIZER_NP
> +		PTHREAD_ERRORCHECK_MUTEX_INITIALIZER_NP,
> +#endif
>   #if HAVE_DECL_PTHREAD_RECURSIVE_MUTEX_INITIALIZER_NP
> -	static pthread_mutex_t uninit_recursive_mutex =3D
> -		PTHREAD_RECURSIVE_MUTEX_INITIALIZER_NP;
> +		PTHREAD_RECURSIVE_MUTEX_INITIALIZER_NP,
>   #endif
> +		PTHREAD_MUTEX_INITIALIZER
> +	};
> +	static const int mutex_types[] =3D
> +	{

Coding style: "... =3D {"

>   #if HAVE_DECL_PTHREAD_ERRORCHECK_MUTEX_INITIALIZER_NP
> -	static pthread_mutex_t uninit_errorcheck_mutex =3D
> -		PTHREAD_ERRORCHECK_MUTEX_INITIALIZER_NP;
> +		PTHREAD_MUTEX_ERRORCHECK_NP,
>   #endif
> -	struct cobalt_mutex_shadow *_mutex =3D
> -		&((union cobalt_mutex_union *)mutex)->shadow_mutex;
> +#if HAVE_DECL_PTHREAD_RECURSIVE_MUTEX_INITIALIZER_NP
> +		PTHREAD_MUTEX_RECURSIVE_NP,
> +#endif
> +		PTHREAD_MUTEX_DEFAULT
> +	};
> +
> +	unsigned i =3D sizeof(mutex_types) / sizeof(mutex_types[0]);

Blank line after this variable definition - and probably not before it.

> +	while (i-- > 0)

How about "for (i =3D 0; i < ARRAY_SIZE(mutex_types); i++)"?

> +	{

Style: only put the brace on a new line when starting a function.

> +		if (memcmp(mutex, &mutex_initializers[i], sizeof(mutex_initializers[0=
])) =3D=3D 0)

Overlong line.

> +			return mutex_types[i];
> +	}
> +	return -1;
> +}
> +
> +static int __attribute__((cold)) _cobalt_mutex_doautoinit(union cobalt_=
mutex_union *umutex)

Overlong line, and that leading "_".

> +{
> +	struct cobalt_mutex_shadow *_mutex =3D &umutex->shadow_mutex;
>   	int err __attribute__((unused));
>   	pthread_mutexattr_t mattr;
>   	int ret =3D 0, type;
>
> -	if (memcmp(mutex, &uninit_normal_mutex, sizeof(*mutex)) =3D=3D 0)
> -		type =3D PTHREAD_MUTEX_DEFAULT;
> -#if HAVE_DECL_PTHREAD_RECURSIVE_MUTEX_INITIALIZER_NP
> -	else if (memcmp(mutex, &uninit_recursive_mutex, sizeof(*mutex)) =3D=3D=
 0)
> -		type =3D PTHREAD_MUTEX_RECURSIVE_NP;
> -#endif
> -#if HAVE_DECL_PTHREAD_ERRORCHECK_MUTEX_INITIALIZER_NP
> -	else if (memcmp(mutex, &uninit_errorcheck_mutex, sizeof(*mutex)) =3D=
=3D 0)
> -		type =3D PTHREAD_MUTEX_ERRORCHECK_NP;
> -#endif
> -	else
> +	type =3D _cobalt_mutex_autoinit_type(&umutex->native_mutex);
> +	if (type < 0)
>   		return EINVAL;
>
>   	pthread_mutexattr_init(&mattr);
> @@ -238,7 +219,7 @@ static int __attribute__((cold)) cobalt_mutex_autoin=
it(pthread_mutex_t *mutex)
>   		goto out;
>   	}
>   	if (_mutex->magic !=3D COBALT_MUTEX_MAGIC)
> -		ret =3D __COBALT(pthread_mutex_init(mutex, &mattr));
> +		ret =3D __COBALT(pthread_mutex_init(&umutex->native_mutex, &mattr));

Overlong line - the kernel's checkpatch.pl can be helpful.

>   	err =3D __COBALT(pthread_mutex_unlock(cobalt_autoinit_mutex));
>   	if (err) {
>   		if (ret =3D=3D 0)
> @@ -251,6 +232,49 @@ static int __attribute__((cold)) cobalt_mutex_autoi=
nit(pthread_mutex_t *mutex)
>   	return ret;
>   }
>
> +static inline int _cobalt_mutex_autoinit(union cobalt_mutex_union *umut=
ex)

Leading "_" and overlong line

> +{
> +	if (unlikely(umutex->shadow_mutex.magic !=3D COBALT_MUTEX_MAGIC))
> +		return _cobalt_mutex_doautoinit(umutex);
> +	return 0;
> +}
> +
> +/**
> + * Destroy a mutex.
> + *
> + * This service destroys the mutex @a mx, if it is unlocked and not ref=
erenced
> + * by any condition variable. The mutex becomes invalid for all mutex s=
ervices
> + * (they all return the EINVAL error) except pthread_mutex_init().
> + *
> + * @param mutex the mutex to be destroyed.
> + *
> + * @return 0 on success,
> + * @return an error number if:
> + * - EINVAL, the mutex @a mx is invalid;
> + * - EPERM, the mutex is not process-shared and does not belong to the =
current
> + *   process;
> + * - EBUSY, the mutex is locked, or used by a condition variable.
> + *
> + * @see
> + * <a href=3D"http://www.opengroup.org/onlinepubs/000095399/functions/p=
thread_mutex_destroy.html">
> + * Specification.</a>
> + *
> + * @apitags{thread-unrestricted}
> + */
> +COBALT_IMPL(int, pthread_mutex_destroy, (pthread_mutex_t *mutex))
> +{
> +	struct cobalt_mutex_shadow *_mutex =3D
> +		&((union cobalt_mutex_union *)mutex)->shadow_mutex;
> +	int err;
> +
> +	if (unlikely(_mutex->magic !=3D COBALT_MUTEX_MAGIC))
> +		return (_cobalt_mutex_autoinit_type(mutex) < 0) ? EINVAL : 0;
> +
> +	err =3D XENOMAI_SYSCALL1(sc_cobalt_mutex_destroy, _mutex);
> +
> +	return -err;
> +}
> +
>   /**
>    * Lock a mutex.
>    *
> @@ -296,15 +320,15 @@ COBALT_IMPL(int, pthread_mutex_lock, (pthread_mute=
x_t *mutex))
>   	if (cur =3D=3D XN_NO_HANDLE)
>   		return EPERM;
>
> -	if (_mutex->magic !=3D COBALT_MUTEX_MAGIC)
> -		goto autoinit;
> +	ret =3D _cobalt_mutex_autoinit((union cobalt_mutex_union *)mutex);
> +	if (ret)
> +		return ret;
>
>   	/*
>   	 * We track resource ownership for auto-relax of non real-time
>   	 * shadows and some debug features, so we must always obtain
>   	 * them via a syscall.
>   	 */
> -start:
>   	status =3D cobalt_get_current_mode();
>   	if ((status & (XNRELAX|XNWEAK|XNDEBUG)) =3D=3D 0) {
>   		if (_mutex->attr.protocol =3D=3D PTHREAD_PRIO_PROTECT)
> @@ -349,7 +373,7 @@ slow_path:
>   		_mutex->lockcnt =3D 1;
>
>   	return -ret;
> -protect:
> +protect:
>   	u_window =3D cobalt_get_current_window();
>   	/*
>   	 * Can't nest lazy ceiling requests, have to take the slow
> @@ -360,11 +384,6 @@ protect:
>   	u_window->pp_pending =3D _mutex->handle;
>   	lazy_protect =3D 1;
>   	goto fast_path;
> -autoinit:
> -	ret =3D cobalt_mutex_autoinit(mutex);
> -	if (ret)
> -		return ret;
> -	goto start;
>   }
>
>   /**
> @@ -411,11 +430,11 @@ COBALT_IMPL(int, pthread_mutex_timedlock, (pthread=
_mutex_t *mutex,
>   	if (cur =3D=3D XN_NO_HANDLE)
>   		return EPERM;
>
> -	if (_mutex->magic !=3D COBALT_MUTEX_MAGIC)
> -		goto autoinit;
> +	ret =3D _cobalt_mutex_autoinit((union cobalt_mutex_union *)mutex);
> +	if (ret)
> +		return ret;
>
>   	/* See __cobalt_pthread_mutex_lock() */
> -start:
>   	status =3D cobalt_get_current_mode();
>   	if ((status & (XNRELAX|XNWEAK|XNDEBUG)) =3D=3D 0) {
>   		if (_mutex->attr.protocol =3D=3D PTHREAD_PRIO_PROTECT)
> @@ -436,7 +455,7 @@ slow_path:
>   	if (ret =3D=3D -EBUSY) {
>   		if (lazy_protect)
>   			u_window->pp_pending =3D XN_NO_HANDLE;
> -
> +
>   		switch(_mutex->attr.type) {
>   		case PTHREAD_MUTEX_NORMAL:
>   			break;
> @@ -460,7 +479,7 @@ slow_path:
>   	if (ret =3D=3D 0)
>   		_mutex->lockcnt =3D 1;
>   	return -ret;
> -protect:
> +protect:
>   	u_window =3D cobalt_get_current_window();
>   	/*
>   	 * Can't nest lazy ceiling requests, have to take the slow
> @@ -471,11 +490,6 @@ protect:
>   	u_window->pp_pending =3D _mutex->handle;
>   	lazy_protect =3D 1;
>   	goto fast_path;
> -autoinit:
> -	ret =3D cobalt_mutex_autoinit(mutex);
> -	if (ret)
> -		return ret;
> -	goto start;
>   }
>
>   /**
> @@ -515,9 +529,10 @@ COBALT_IMPL(int, pthread_mutex_trylock, (pthread_mu=
tex_t *mutex))
>   	if (cur =3D=3D XN_NO_HANDLE)
>   		return EPERM;
>
> -	if (_mutex->magic !=3D COBALT_MUTEX_MAGIC)
> -		goto autoinit;
> -start:
> +	ret =3D _cobalt_mutex_autoinit((union cobalt_mutex_union *)mutex);
> +	if (ret)
> +		return ret;
> +
>   	status =3D cobalt_get_current_mode();
>   	if ((status & (XNRELAX|XNWEAK|XNDEBUG)) =3D=3D 0) {
>   		if (_mutex->attr.protocol =3D=3D PTHREAD_PRIO_PROTECT)
> @@ -558,12 +573,7 @@ slow_path:
>   		_mutex->lockcnt =3D 1;
>
>   	return -ret;
> -autoinit:
> -	ret =3D cobalt_mutex_autoinit(mutex);
> -	if (ret)
> -		return ret;
> -	goto start;
> -protect:
> +protect:
>   	u_window =3D cobalt_get_current_window();
>   	/*
>   	 * Can't nest lazy ceiling requests, have to take the slow
> @@ -611,9 +621,10 @@ COBALT_IMPL(int, pthread_mutex_unlock, (pthread_mut=
ex_t *mutex))
>   	xnhandle_t cur;
>   	int err;
>
> -	if (_mutex->magic !=3D COBALT_MUTEX_MAGIC)
> -		goto autoinit;
> -start:
> +	err =3D _cobalt_mutex_autoinit((union cobalt_mutex_union *)mutex);
> +	if (err)
> +		return err;
> +
>   	cur =3D cobalt_get_current();
>   	if (cur =3D=3D XN_NO_HANDLE)
>   		return EPERM;
> @@ -645,11 +656,6 @@ do_syscall:
>
>   	return -err;
>
> -autoinit:
> -	err =3D cobalt_mutex_autoinit(mutex);
> -	if (err)
> -		return err;
> -	goto start;
>   unprotect:
>   	u_window =3D cobalt_get_current_window();
>   	u_window->pp_pending =3D XN_NO_HANDLE;
> @@ -707,7 +713,7 @@ COBALT_IMPL(int, pthread_mutex_setprioceiling,
>   	if (_mutex->magic !=3D COBALT_MUTEX_MAGIC ||
>   	    _mutex->attr.protocol !=3D PTHREAD_PRIO_PROTECT)
>   		return EINVAL;
> -
> +
>   	if (prioceiling < __cobalt_std_fifo_minpri ||
>   	    prioceiling > __cobalt_std_fifo_maxpri)
>   		return EINVAL;
> @@ -757,7 +763,7 @@ COBALT_IMPL(int, pthread_mutex_getprioceiling,
>   	if (_mutex->magic !=3D COBALT_MUTEX_MAGIC ||
>   	    _mutex->attr.protocol !=3D PTHREAD_PRIO_PROTECT)
>   		return EINVAL;
> -
> +
>   	state =3D mutex_get_state(_mutex);
>   	*prioceiling =3D state->ceiling;
>
>

Jan

