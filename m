Message-ID: <4E02ED7E.7040204@domain.hid>
Date: Thu, 23 Jun 2011 09:38:38 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <4E0264CE.9060508@domain.hid>
In-Reply-To: <4E0264CE.9060508@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigFAD42FFD3F67C05DD61B36A9"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-core] RFC: use a pool of pre-allocated buffers in
	rt_printf
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: Xenomai core <Xenomai-core@domain.hid>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigFAD42FFD3F67C05DD61B36A9
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 2011-06-22 23:55, Gilles Chanteperdrix wrote:
>=20
> Hi,
>=20
> I would like to better integrate rtdk and the posix skin by forcibly=20
> wrapping the calls to malloc/free and also wrap printf to call=20
> rt_printf.
>=20
> However, currently, rt_printf can not really be used as a drop-in=20
> replacement of printf:
> - it is necessary to call rt_printf_auto_init, we can do it in the=20
> library init code;
> - the first rt_printf causes a memory allocation, so a potential switch=
=20
> to secondary mode, which is what using rt_printf was trying to avoid in=

> the first place.
>=20
> In order to solve this second issue, and to avoid forcibly creating a=20
> buffer for each thread, which would be wasteful, here is a patch, which=
,=20
> following an idea of Philippe, creates a pool of pre-allocated buffers.=
=20
> The pool is handled in a lockless fashion, using xnarch_atomic_cmpxchg =

> (so, will only work with CONFIG_XENO_FASTSYNCH).

Makes sense.

>=20
> diff --git a/src/rtdk/rt_print.c b/src/rtdk/rt_print.c
> index 93b711a..2ed2209 100644
> --- a/src/rtdk/rt_print.c
> +++ b/src/rtdk/rt_print.c
> @@ -30,6 +30,8 @@
>  #include <rtdk.h>
>  #include <asm/xenomai/system.h>
>  #include <asm-generic/stack.h>
> +#include <asm/xenomai/atomic.h>
> +#include <asm-generic/bits/current.h>
> =20
>  #define RT_PRINT_BUFFER_ENV		"RT_PRINT_BUFFER"
>  #define RT_PRINT_DEFAULT_BUFFER		16*1024
> @@ -37,6 +39,9 @@
>  #define RT_PRINT_PERIOD_ENV		"RT_PRINT_PERIOD"
>  #define RT_PRINT_DEFAULT_PERIOD		100 /* ms */
> =20
> +#define RT_PRINT_BUFFERS_COUNT_ENV      "RT_PRINT_BUFFERS_COUNT"
> +#define RT_PRINT_DEFAULT_BUFFERS_COUNT  4
> +
>  #define RT_PRINT_LINE_BREAK		256
> =20
>  #define RT_PRINT_SYSLOG_STREAM		NULL
> @@ -63,6 +68,9 @@ struct print_buffer {
>  	 * caching on SMP.
>  	 */
>  	off_t read_pos;
> +#ifdef CONFIG_XENO_FASTSYNCH
> +	struct print_buffer *pool_next;
> +#endif /* CONFIG_XENO_FASTSYNCH */
>  };
> =20
>  static struct print_buffer *first_buffer;
> @@ -75,6 +83,17 @@ static pthread_mutex_t buffer_lock;
>  static pthread_cond_t printer_wakeup;
>  static pthread_key_t buffer_key;
>  static pthread_t printer_thread;
> +#ifdef CONFIG_XENO_FASTSYNCH
> +static xnarch_atomic_t buffer_pool;
> +static unsigned pool_capacity;
> +static xnarch_atomic_t pool_count;
> +
> +#define buf_pool_set(buf) xnarch_atomic_set(&buffer_pool, (unsigned lo=
ng)buf)
> +#define buf_pool_get() (struct print_buffer *)xnarch_atomic_get(&buffe=
r_pool)
> +#define buf_pool_cmpxchg(oldval, newval) \
> +	((struct print_buffer *)xnarch_atomic_cmpxchg			\
> +	 (&buffer_pool, (unsigned long)oldval, (unsigned long)newval))

static inlines should work as well and document input/output types a bit
better.

> +#endif /* CONFIG_XENO_FASTSYNCH */
> =20
>  static void cleanup_buffer(struct print_buffer *buffer);
>  static void print_buffers(void);
> @@ -243,43 +262,28 @@ static void set_buffer_name(struct print_buffer *=
buffer, const char *name)
>  	}
>  }
> =20
> -int rt_print_init(size_t buffer_size, const char *buffer_name)
> +static struct print_buffer *rt_print_init_inner(size_t size)
>  {
> -	struct print_buffer *buffer =3D pthread_getspecific(buffer_key);
> -	size_t size =3D buffer_size;
> -
> -	if (!size)
> -		size =3D default_buffer_size;
> -	else if (size < RT_PRINT_LINE_BREAK)
> -		return EINVAL;
> +	struct print_buffer *buffer;
> =20
> -	if (buffer) {
> -		/* Only set name if buffer size is unchanged or default */
> -		if (size =3D=3D buffer->size || !buffer_size) {
> -			set_buffer_name(buffer, buffer_name);
> -			return 0;
> -		}
> -		cleanup_buffer(buffer);
> -	}
> +	assert_nrt();
> =20
>  	buffer =3D malloc(sizeof(*buffer));
>  	if (!buffer)
> -		return ENOMEM;
> +		return NULL;
> =20
>  	buffer->ring =3D malloc(size);
>  	if (!buffer->ring) {
>  		free(buffer);
> -		return ENOMEM;
> +		return NULL;
>  	}
> +	buffer->size =3D size;
> +
>  	memset(buffer->ring, 0, size);
> =20
>  	buffer->read_pos  =3D 0;
>  	buffer->write_pos =3D 0;
> =20
> -	buffer->size =3D size;
> -
> -	set_buffer_name(buffer, buffer_name);
> -
>  	buffer->prev =3D NULL;
> =20
>  	pthread_mutex_lock(&buffer_lock);
> @@ -294,6 +298,52 @@ int rt_print_init(size_t buffer_size, const char *=
buffer_name)
> =20
>  	pthread_mutex_unlock(&buffer_lock);
> =20
> +	return buffer;
> +}
> +
> +int rt_print_init(size_t buffer_size, const char *buffer_name)
> +{
> +	struct print_buffer *buffer =3D pthread_getspecific(buffer_key);
> +	size_t size =3D buffer_size;
> +
> +	if (!size)
> +		size =3D default_buffer_size;
> +	else if (size < RT_PRINT_LINE_BREAK)
> +		return EINVAL;
> +
> +	if (buffer) {
> +		/* Only set name if buffer size is unchanged or default */
> +		if (size =3D=3D buffer->size || !buffer_size) {
> +			set_buffer_name(buffer, buffer_name);
> +			return 0;
> +		}
> +		cleanup_buffer(buffer);
> +		buffer =3D NULL;
> +	}
> +
> +#ifdef CONFIG_XENO_FASTSYNCH
> +	if (xeno_get_current() !=3D XN_NO_HANDLE &&
> +	    !(xeno_get_current_mode() & XNRELAX) && buf_pool_get()) {
> +		struct print_buffer *old;
> +
> +		old =3D buf_pool_get();
> +		while (old !=3D buffer) {
> +			buffer =3D old;
> +			old =3D buf_pool_cmpxchg(buffer, buffer->pool_next);

Though unlikely, it's still possible: The buffer obtained in the last
round may have been dequeued meanwhile and then freed (in case a third
buffer was released to the pool, filling it up to pool_capacity).

A simple solution would be not freeing buffer even of the pool became
large than its initial capacity. Algorithms to solve that race are more
complicated. E.g.: Exchange with a dummy element, then read next and
update the head. Other readers need to spin while finding the dummy.

> +		}
> +		if (buffer)
> +			xnarch_atomic_dec(&pool_count);
> +	}
> +#endif /* CONFIG_XENO_FASTSYNCH */
> +
> +	if (!buffer)
> +		buffer =3D rt_print_init_inner(size);
> +
> +	if (!buffer)
> +		return ENOMEM;
> +
> +	set_buffer_name(buffer, buffer_name);
> +
>  	pthread_setspecific(buffer_key, buffer);
> =20
>  	return 0;
> @@ -346,12 +396,36 @@ static void cleanup_buffer(struct print_buffer *b=
uffer)
>  {
>  	struct print_buffer *prev, *next;
> =20
> +	assert_nrt();
> +
>  	pthread_setspecific(buffer_key, NULL);
> =20
>  	pthread_mutex_lock(&buffer_lock);
> =20
>  	print_buffers();

You also need to unhook the buffer from the active list before returning
it to the pool.

> =20
> +	pthread_mutex_unlock(&buffer_lock);
> +
> +#ifdef CONFIG_XENO_FASTSYNCH
> +	{
> +		struct print_buffer *old;
> +
> +		old =3D buf_pool_get();
> +		buffer->pool_next =3D buffer;
> +		while (old !=3D buffer->next
> +		       && xnarch_atomic_get(&pool_count) < pool_capacity) {
> +			buffer->next =3D old;
> +			old =3D buf_pool_cmpxchg(buffer->pool_next, buffer);

This looks strange:

	buffer->pool_next =3D buffer;
	...
	buf_pool_cmpxchg(buffer->pool_next, buffer);

Don't you want

	buffer->pool_next =3D old;
	buf_pool_cmpxchg(old, buffer);

?

> +		}
> +		if (old =3D=3D buffer->pool_next) {
> +			xnarch_atomic_inc(&pool_count);
> +			return;
> +		}
> +	}
> +#endif /* CONFIG_XENO_FASTSYNCH */
> +
> +	pthread_mutex_lock(&buffer_lock);
> +
>  	prev =3D buffer->prev;
>  	next =3D buffer->next;
> =20
> @@ -523,6 +597,39 @@ void __rt_print_init(void)
>  	print_period.tv_sec  =3D period / 1000;
>  	print_period.tv_nsec =3D (period % 1000) * 1000000;
> =20
> +#ifdef CONFIG_XENO_FASTSYNCH
> +	{
> +		unsigned i;
> +
> +		pool_capacity =3D RT_PRINT_DEFAULT_BUFFERS_COUNT;
> +
> +		value_str =3D getenv(RT_PRINT_BUFFERS_COUNT_ENV);
> +		if (value_str) {
> +			errno =3D 0;
> +			pool_capacity =3D strtoul(value_str, NULL, 0);
> +			if (errno) {
> +				fprintf(stderr, "Invalid %s\n",
> +					RT_PRINT_BUFFERS_COUNT_ENV);
> +				exit(1);
> +			}
> +		}
> +		for (i =3D 0; i < pool_capacity; i++) {
> +			struct print_buffer *buffer;
> +
> +			buffer =3D rt_print_init_inner(default_buffer_size);
> +			if (!buffer) {
> +				fprintf(stderr, "Error allocating rt_printf "
> +					"buffer\n");
> +				exit(1);
> +			}
> +
> +			buffer->pool_next =3D buf_pool_get();
> +			buf_pool_set(buffer);
> +		}
> +		xnarch_atomic_set(&pool_count, pool_capacity);
> +	}
> +#endif /* CONFIG_XENO_FASTSYNCH */
> +
>  	pthread_mutex_init(&buffer_lock, NULL);
>  	pthread_key_create(&buffer_key, (void (*)(void*))cleanup_buffer);
> =20
>=20
>=20

Jan


--------------enigFAD42FFD3F67C05DD61B36A9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.15 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org/

iEYEARECAAYFAk4C7X4ACgkQitSsb3rl5xS4PQCfcKOX9haNRkvbHH4TwN2OpVQp
/BMAniC2WQfF37GXBbSuvJOv2l1GlVmJ
=8EFp
-----END PGP SIGNATURE-----

--------------enigFAD42FFD3F67C05DD61B36A9--

