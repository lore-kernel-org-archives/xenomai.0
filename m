Message-ID: <4E082417.2010503@domain.hid>
Date: Mon, 27 Jun 2011 08:32:55 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <4E0264CE.9060508@domain.hid> <4E02ED7E.7040204@domain.hid>
	<4E0301C4.8080605@domain.hid> <4E0302B3.3090201@domain.hid>
	<4E0323A7.2040107@domain.hid> <4E03253C.6090208@domain.hid>
	<4E04EC53.3010305@domain.hid>
In-Reply-To: <4E04EC53.3010305@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig5DEF66402F00A1C37830D2AB"
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
--------------enig5DEF66402F00A1C37830D2AB
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 2011-06-24 21:58, Gilles Chanteperdrix wrote:
> On 06/23/2011 01:36 PM, Jan Kiszka wrote:
>> On 2011-06-23 13:29, Gilles Chanteperdrix wrote:
>>> On 06/23/2011 11:09 AM, Jan Kiszka wrote:
>>>> On 2011-06-23 11:05, Gilles Chanteperdrix wrote:
>>>>> On 06/23/2011 09:38 AM, Jan Kiszka wrote:
>>>>>>> +#ifdef CONFIG_XENO_FASTSYNCH
>>>>>>> +	if (xeno_get_current() !=3D XN_NO_HANDLE &&
>>>>>>> +	    !(xeno_get_current_mode() & XNRELAX) && buf_pool_get()) {
>>>>>>> +		struct print_buffer *old;
>>>>>>> +
>>>>>>> +		old =3D buf_pool_get();
>>>>>>> +		while (old !=3D buffer) {
>>>>>>> +			buffer =3D old;
>>>>>>> +			old =3D buf_pool_cmpxchg(buffer, buffer->pool_next);
>>>>>>
>>>>>> Though unlikely, it's still possible: The buffer obtained in the l=
ast
>>>>>> round may have been dequeued meanwhile and then freed (in case a t=
hird
>>>>>> buffer was released to the pool, filling it up to pool_capacity).
>>>>>
>>>>> I do not get it: it seems to me that if the current head (that is
>>>>> buf_pool_get()) is freed, then the cmpxchg will fail, so we will lo=
op
>>>>> and try again.
>>>>
>>>> Problematic is the dereferencing of the stale buffer pointer obtaine=
d
>>>> during the last cmpxchg or via buf_pool_get. This happens before the=
 new
>>>> cmpxchg.
>>>
>>> Ok. Got it, that would be a problem only if the stale pointer pointed=
 to
>>> an unmapped area, but ok, better avoid freeing the buffers. I guess i=
t
>>> would not be a problem as applications tend to have a fixed number of=

>>> threads anyway.
>>
>> That is a risky assumption, proven wrong e.g. by one of our
>> applications. Threads may always be created or destroyed depending on
>> the mode of an application, specifically if it is a larger one.
>=20
> Here is another attempt, based on a bitmap.
>=20
> diff --git a/src/rtdk/rt_print.c b/src/rtdk/rt_print.c
> index 93b711a..fb4820f 100644
> --- a/src/rtdk/rt_print.c
> +++ b/src/rtdk/rt_print.c
> @@ -28,7 +28,9 @@
>  #include <syslog.h>
> =20
>  #include <rtdk.h>
> +#include <nucleus/types.h>	/* For BITS_PER_LONG */
>  #include <asm/xenomai/system.h>
> +#include <asm/xenomai/atomic.h>	/* For atomic_cmpxchg */
>  #include <asm-generic/stack.h>
> =20
>  #define RT_PRINT_BUFFER_ENV		"RT_PRINT_BUFFER"
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
> @@ -75,6 +80,12 @@ static pthread_mutex_t buffer_lock;
>  static pthread_cond_t printer_wakeup;
>  static pthread_key_t buffer_key;
>  static pthread_t printer_thread;
> +#ifdef CONFIG_XENO_FASTSYNCH
> +static xnarch_atomic_t *pool_bitmap;
> +static unsigned pool_bitmap_len;
> +static unsigned pool_buf_size;
> +static unsigned long pool_start, pool_len;
> +#endif /* CONFIG_XENO_FASTSYNCH */
> =20
>  static void cleanup_buffer(struct print_buffer *buffer);
>  static void print_buffers(void);
> @@ -243,10 +254,36 @@ static void set_buffer_name(struct print_buffer *=
buffer, const char *name)
>  	}
>  }
> =20
> +void rt_print_init_inner(struct print_buffer *buffer, size_t size)
> +{
> +	buffer->size =3D size;
> +
> +	memset(buffer->ring, 0, size);
> +
> +	buffer->read_pos  =3D 0;
> +	buffer->write_pos =3D 0;
> +
> +	buffer->prev =3D NULL;
> +
> +	pthread_mutex_lock(&buffer_lock);
> +
> +	buffer->next =3D first_buffer;
> +	if (first_buffer)
> +		first_buffer->prev =3D buffer;
> +	first_buffer =3D buffer;
> +
> +	buffers++;
> +	pthread_cond_signal(&printer_wakeup);
> +
> +	pthread_mutex_unlock(&buffer_lock);
> +}
> +
>  int rt_print_init(size_t buffer_size, const char *buffer_name)
>  {
>  	struct print_buffer *buffer =3D pthread_getspecific(buffer_key);
>  	size_t size =3D buffer_size;
> +	unsigned long old_bitmap;
> +	unsigned j;
> =20
>  	if (!size)
>  		size =3D default_buffer_size;
> @@ -260,39 +297,56 @@ int rt_print_init(size_t buffer_size, const char =
*buffer_name)
>  			return 0;
>  		}
>  		cleanup_buffer(buffer);
> +		buffer =3D NULL;
>  	}
> =20
> -	buffer =3D malloc(sizeof(*buffer));
> -	if (!buffer)
> -		return ENOMEM;
> +#ifdef CONFIG_XENO_FASTSYNCH
> +	/* Find a free buffer in the pool */
> +	do {
> +		unsigned long bitmap;
> +		unsigned i;
> =20
> -	buffer->ring =3D malloc(size);
> -	if (!buffer->ring) {
> -		free(buffer);
> -		return ENOMEM;
> -	}
> -	memset(buffer->ring, 0, size);
> +		for (i =3D 0; i < pool_bitmap_len; i++) {
> +			old_bitmap =3D xnarch_atomic_get(&pool_bitmap[i]);
> +			if (old_bitmap)
> +				goto acquire;
> +		}
> =20
> -	buffer->read_pos  =3D 0;
> -	buffer->write_pos =3D 0;
> +		goto not_found;
> =20
> -	buffer->size =3D size;
> +	  acquire:
> +		do {
> +			bitmap =3D old_bitmap;
> +			j =3D __builtin_ffsl(bitmap) - 1;
> +			old_bitmap =3D xnarch_atomic_cmpxchg(&pool_bitmap[i],
> +							   bitmap,
> +							   bitmap & ~(1UL << j));
> +		} while (old_bitmap !=3D bitmap && old_bitmap);
> +		j +=3D i * BITS_PER_LONG;
> +	} while (!old_bitmap);
> =20
> -	set_buffer_name(buffer, buffer_name);
> +	buffer =3D (struct print_buffer *)(pool_start + j * pool_buf_size);
> =20
> -	buffer->prev =3D NULL;
> +  not_found:
> +#endif /* CONFIG_XENO_FASTSYNCH */
> =20
> -	pthread_mutex_lock(&buffer_lock);
> +	if (!buffer) {
> +		assert_nrt();
> =20
> -	buffer->next =3D first_buffer;
> -	if (first_buffer)
> -		first_buffer->prev =3D buffer;
> -	first_buffer =3D buffer;
> +		buffer =3D malloc(sizeof(*buffer));
> +		if (!buffer)
> +			return ENOMEM;
> =20
> -	buffers++;
> -	pthread_cond_signal(&printer_wakeup);
> +		buffer->ring =3D malloc(size);
> +		if (!buffer->ring) {
> +			free(buffer);
> +			return ENOMEM;
> +		}
> =20
> -	pthread_mutex_unlock(&buffer_lock);
> +		rt_print_init_inner(buffer, size);
> +	}
> +
> +	set_buffer_name(buffer, buffer_name);
> =20
>  	pthread_setspecific(buffer_key, buffer);
> =20
> @@ -346,12 +400,44 @@ static void cleanup_buffer(struct print_buffer *b=
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
> =20
> +	pthread_mutex_unlock(&buffer_lock);
> +
> +#ifdef CONFIG_XENO_FASTSYNCH
> +	/* Return the buffer to the pool */
> +	{
> +		unsigned long old_bitmap, bitmap;
> +		unsigned i, j;
> +
> +		if ((unsigned long)buffer - pool_start >=3D pool_len)
> +			goto dofree;
> +
> +		j =3D ((unsigned long)buffer - pool_start) / pool_buf_size;
> +		i =3D j / BITS_PER_LONG;
> +		j =3D j % BITS_PER_LONG;
> +
> +		old_bitmap =3D xnarch_atomic_get(&pool_bitmap[i]);
> +		do {
> +			bitmap =3D old_bitmap;
> +			old_bitmap =3D xnarch_atomic_cmpxchg(&pool_bitmap[i],
> +							   bitmap,
> +							   bitmap | (1UL << j));
> +		} while (old_bitmap !=3D bitmap);
> +
> +		return;
> +	}
> +  dofree:
> +#endif /* CONFIG_XENO_FASTSYNCH */
> +
> +	pthread_mutex_lock(&buffer_lock);
> +
>  	prev =3D buffer->prev;
>  	next =3D buffer->next;
> =20
> @@ -523,6 +609,64 @@ void __rt_print_init(void)
>  	print_period.tv_sec  =3D period / 1000;
>  	print_period.tv_nsec =3D (period % 1000) * 1000000;
> =20
> +#ifdef CONFIG_XENO_FASTSYNCH
> +	/* Fill the buffer pool */
> +	{
> +		unsigned buffers_count, i;
> +
> +		buffers_count =3D RT_PRINT_DEFAULT_BUFFERS_COUNT;
> +
> +		value_str =3D getenv(RT_PRINT_BUFFERS_COUNT_ENV);
> +		if (value_str) {
> +			errno =3D 0;
> +			buffers_count =3D strtoul(value_str, NULL, 0);
> +			if (errno) {
> +				fprintf(stderr, "Invalid %s\n",
> +					RT_PRINT_BUFFERS_COUNT_ENV);
> +				exit(1);
> +			}
> +		}
> +
> +		pool_bitmap_len =3D (buffers_count + BITS_PER_LONG - 1)
> +			/ BITS_PER_LONG;
> +		if (!pool_bitmap_len)
> +			goto done;
> +
> +		pool_bitmap =3D malloc(pool_bitmap_len * sizeof(*pool_bitmap));
> +		if (!pool_bitmap) {
> +			fprintf(stderr, "Error allocating rt_printf "
> +				"buffers\n");
> +			exit(1);
> +		}
> +
> +		pool_buf_size =3D sizeof(struct print_buffer) + default_buffer_size;=

> +		pool_len =3D buffers_count * pool_buf_size;
> +		pool_start =3D (unsigned long)malloc(pool_len);
> +		if (!pool_start) {
> +			fprintf(stderr, "Error allocating rt_printf "
> +				"buffers\n");
> +			exit(1);
> +		}
> +
> +		for (i =3D 0; i < buffers_count / BITS_PER_LONG; i++)
> +			xnarch_atomic_set(&pool_bitmap[i], ~0UL);
> +		if (buffers_count % BITS_PER_LONG)
> +			xnarch_atomic_set(&pool_bitmap[i],
> +					  (1UL << (buffers_count % BITS_PER_LONG))					  - 1);
> +
> +		for (i =3D 0; i < buffers_count; i++) {
> +			struct print_buffer *buffer =3D
> +				(struct print_buffer *)
> +				(pool_start + i * pool_buf_size);
> +
> +			buffer->ring =3D (char *)(buffer + 1);
> +
> +			rt_print_init_inner(buffer, default_buffer_size);
> +		}
> +	}
> +  done:
> +#endif /* CONFIG_XENO_FASTSYNCH */
> +
>  	pthread_mutex_init(&buffer_lock, NULL);
>  	pthread_key_create(&buffer_key, (void (*)(void*))cleanup_buffer);
> =20
>=20

Looks good to me.

[ As you know ensure that buffers taken from the pool are always
returned to it, thus the objects remain valid, you could theoretically
also use a linked list again. ]

Jan


--------------enig5DEF66402F00A1C37830D2AB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.15 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org/

iEYEARECAAYFAk4IJBcACgkQitSsb3rl5xTMTwCdEN9cTHk5f8vN13jTIQBGguOW
FREAnjcma4gF279MVbufVOM+eGPBb4Rl
=ng+O
-----END PGP SIGNATURE-----

--------------enig5DEF66402F00A1C37830D2AB--

