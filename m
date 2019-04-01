Subject: Re: [PATCH 3/5] libcobalt: improve condvar autoinit support
References: <20190307132159.31206-1-norbert.lange@andritz.com>
 <20190307132159.31206-3-norbert.lange@andritz.com>
From: Jan Kiszka <jan.kiszka@web.de>
Message-ID: <02ea75ce-9d1c-bb7f-a350-8d60e17af8b0@web.de>
Date: Mon, 1 Apr 2019 19:27:08 +0200
MIME-Version: 1.0
In-Reply-To: <20190307132159.31206-3-norbert.lange@andritz.com>
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
> contrary to some comments, condvars are automatically
> initialised on signal/wait.
> Correct the destroy method to not report an
> error on such condvars.
>
> Check whether the condition variable has the
> static initializer is now more strict.
>

Some checkpatch warning are reported here as well. Not explicitly listing =
them.

> Signed-off-by: Norbert Lange <norbert.lange@andritz.com>
> ---
>   lib/cobalt/cond.c | 93 ++++++++++++++++++++++++++---------------------
>   1 file changed, 51 insertions(+), 42 deletions(-)
>
> diff --git a/lib/cobalt/cond.c b/lib/cobalt/cond.c
> index 00a201855..92eb230ff 100644
> --- a/lib/cobalt/cond.c
> +++ b/lib/cobalt/cond.c
> @@ -142,6 +142,42 @@ COBALT_IMPL(int, pthread_cond_init, (pthread_cond_t=
 *cond,
>   	return 0;
>   }
>
> +static int __attribute__((cold)) _cobalt_cond_autoinit_type(const pthre=
ad_cond_t *cond)
> +{
> +	static const pthread_cond_t cond_initializers[] =3D {
> +		PTHREAD_COND_INITIALIZER
> +	};
> +	static const int cond_types[] =3D
> +	{
> +		0
> +	};
> +
> +	unsigned i =3D sizeof(cond_types) / sizeof(cond_types[0]);
> +	while (i-- > 0)
> +	{
> +		if (memcmp(cond, &cond_initializers[i], sizeof(cond_initializers[0]))=
 =3D=3D 0)
> +			return cond_types[i];
> +	}

While follows the same style as for mutexes, it's a bit overkill here, giv=
en
that we only have one type.

> +	return -1;
> +}
> +
> +static int __attribute__((cold)) _cobalt_cond_doautoinit(union cobalt_c=
ond_union *ucond)
> +{
> +	int type;
> +	type =3D _cobalt_cond_autoinit_type(&ucond->native_cond);
> +	if (type < 0)
> +		return EINVAL;
> +
> +	return __COBALT(pthread_cond_init(&ucond->native_cond, NULL));
> +}
> +
> +static inline int _cobalt_cond_autoinit(union cobalt_cond_union *ucond)
> +{
> +	if (unlikely(ucond->shadow_cond.magic !=3D COBALT_COND_MAGIC))
> +		return _cobalt_cond_doautoinit(ucond);
> +	return 0;
> +}
> +
>   /**
>    * @fn int pthread_cond_destroy(pthread_cond_t *cond)
>    * @brief Destroy a condition variable
> @@ -170,6 +206,9 @@ COBALT_IMPL(int, pthread_cond_destroy, (pthread_cond=
_t *cond))
>   {
>   	struct cobalt_cond_shadow *_cond =3D &((union cobalt_cond_union *)con=
d)->shadow_cond;
>
> +	if (unlikely(_cond->magic !=3D COBALT_COND_MAGIC))
> +		return (_cobalt_cond_autoinit_type(cond) < 0) ? EINVAL : 0;
> +
>   	return -XENOMAI_SYSCALL1( sc_cobalt_cond_destroy, _cond);
>   }
>
> @@ -193,12 +232,6 @@ static void __pthread_cond_cleanup(void *data)
>   	c->mutex->lockcnt =3D c->count;
>   }
>
> -static int __attribute__((cold)) cobalt_cond_autoinit(pthread_cond_t *c=
ond)
> -{
> -	return __COBALT(pthread_cond_init(cond, NULL));
> -}
> -
> -
>   /**
>    * Wait on a condition variable.
>    *
> @@ -262,10 +295,10 @@ COBALT_IMPL(int, pthread_cond_wait, (pthread_cond_=
t *cond, pthread_mutex_t *mute
>   	if (_mx->magic !=3D COBALT_MUTEX_MAGIC)
>   		return EINVAL;
>
> -	if (_cnd->magic !=3D COBALT_COND_MAGIC)
> -		goto autoinit;
> +	err =3D _cobalt_cond_autoinit((union cobalt_cond_union *)cond);
> +	if (err)
> +		return err;
>
> -  cont:
>   	if (_mx->attr.type =3D=3D PTHREAD_MUTEX_ERRORCHECK) {
>   		xnhandle_t cur =3D cobalt_get_current();
>
> @@ -297,12 +330,6 @@ COBALT_IMPL(int, pthread_cond_wait, (pthread_cond_t=
 *cond, pthread_mutex_t *mute
>   	pthread_testcancel();
>
>   	return -err ?: -c.err;
> -
> -  autoinit:
> -	err =3D cobalt_cond_autoinit(cond);
> -	if (err)
> -		return err;
> -	goto cont;
>   }
>
>   /**
> @@ -357,10 +384,10 @@ COBALT_IMPL(int, pthread_cond_timedwait, (pthread_=
cond_t *cond,
>   	if (_mx->magic !=3D COBALT_MUTEX_MAGIC)
>   		return EINVAL;
>
> -	if (_cnd->magic !=3D COBALT_COND_MAGIC)
> -		goto autoinit;
> +	err =3D _cobalt_cond_autoinit((union cobalt_cond_union *)cond);
> +	if (err)
> +		return err;
>
> -  cont:
>   	if (_mx->attr.type =3D=3D PTHREAD_MUTEX_ERRORCHECK) {
>   		xnhandle_t cur =3D cobalt_get_current();
>
> @@ -391,12 +418,6 @@ COBALT_IMPL(int, pthread_cond_timedwait, (pthread_c=
ond_t *cond,
>   	pthread_testcancel();
>
>   	return -err ?: -c.err;
> -
> -  autoinit:
> -	err =3D cobalt_cond_autoinit(cond);
> -	if (err)
> -		return err;
> -	goto cont;
>   }
>
>   /**
> @@ -431,10 +452,10 @@ COBALT_IMPL(int, pthread_cond_signal, (pthread_con=
d_t *cond))
>   	__u32 flags;
>   	int err;
>
> -	if (_cnd->magic !=3D COBALT_COND_MAGIC)
> -		goto autoinit;
> +	err =3D _cobalt_cond_autoinit((union cobalt_cond_union *)cond);
> +	if (err)
> +		return err;
>
> -  cont:
>   	mutex_state =3D get_mutex_state(_cnd);
>   	if (mutex_state =3D=3D NULL)
>   		return 0;	/* Fast path, no waiter. */
> @@ -455,12 +476,6 @@ COBALT_IMPL(int, pthread_cond_signal, (pthread_cond=
_t *cond))
>   		cond_state->pending_signals =3D pending_signals + 1;
>
>   	return 0;
> -
> -  autoinit:
> -	err =3D cobalt_cond_autoinit(cond);
> -	if (err)
> -		return err;
> -	goto cont;
>   }
>
>   /**
> @@ -491,10 +506,10 @@ COBALT_IMPL(int, pthread_cond_broadcast, (pthread_=
cond_t *cond))
>   	__u32 flags;
>   	int err;
>
> -	if (_cnd->magic !=3D COBALT_COND_MAGIC)
> -		goto autoinit;
> +	err =3D _cobalt_cond_autoinit((union cobalt_cond_union *)cond);
> +	if (err)
> +		return err;
>
> -  cont:
>   	mutex_state =3D get_mutex_state(_cnd);
>   	if (mutex_state =3D=3D NULL)
>   		return 0;
> @@ -513,12 +528,6 @@ COBALT_IMPL(int, pthread_cond_broadcast, (pthread_c=
ond_t *cond))
>   	cond_state->pending_signals =3D ~0U;
>
>   	return 0;
> -
> -  autoinit:
> -	err =3D cobalt_cond_autoinit(cond);
> -	if (err)
> -		return err;
> -	goto cont;
>   }
>
>   /**
>

Jan

