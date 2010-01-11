Message-ID: <4B4ADB17.4070905@domain.hid>
Date: Mon, 11 Jan 2010 09:02:31 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <1262955043-5304-1-git-send-email-gilles.chanteperdrix@xenomai.org>
In-Reply-To: <1262955043-5304-1-git-send-email-gilles.chanteperdrix@xenomai.org>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig50A40116EFF04EAE9E340D7B"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-core] [PATCH 1/1] rtdk: various fixes.
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig50A40116EFF04EAE9E340D7B
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Gilles Chanteperdrix wrote:
> When exiting a process, rtdk buffers are not flushed. Fix that by
> introducing a destructor for the library which flushes the buffers.
>=20
> When forking, if the main thread has an rt_printf buffer, it is reused =
by
> the child, which is a good thing, however, it is not emptied, so could =
cause
> the same message to be printed twice. Fix that by emptying the main thr=
ead
> buffer upon fork.
>=20
> When spawning the rt_print thread, it uses a stack size of
> PTHREAD_STACK_MIN, which may be too small for printf to work reliably o=
n
> some architectures, set the stack size to the
> empirically-known-to-be-working size of... 32Kb.
> ---
>  src/rtdk/init.c     |    5 +++++
>  src/rtdk/internal.h |    1 +
>  src/rtdk/rt_print.c |   21 ++++++++++++++++++++-
>  3 files changed, 26 insertions(+), 1 deletions(-)
>=20
> diff --git a/src/rtdk/init.c b/src/rtdk/init.c
> index 2084c73..b864175 100644
> --- a/src/rtdk/init.c
> +++ b/src/rtdk/init.c
> @@ -22,3 +22,8 @@ static __attribute__ ((constructor)) void __init_rtdk=
(void)
>  {
>  	__rt_print_init();
>  }
> +
> +static __attribute__ ((destructor)) void __exit_rtdk(void)
> +{
> +	__rt_print_exit();
> +}
> diff --git a/src/rtdk/internal.h b/src/rtdk/internal.h
> index bd15b2d..345d4fa 100644
> --- a/src/rtdk/internal.h
> +++ b/src/rtdk/internal.h
> @@ -23,6 +23,7 @@
>  #include <sys/time.h>
> =20
>  void __rt_print_init(void);
> +void __rt_print_exit(void);
> =20
>  void __real_free(void *ptr);
>  void *__real_malloc(size_t size);
> diff --git a/src/rtdk/rt_print.c b/src/rtdk/rt_print.c
> index c6b5c55..dae7d7b 100644
> --- a/src/rtdk/rt_print.c
> +++ b/src/rtdk/rt_print.c
> @@ -455,7 +455,7 @@ static void spawn_printer_thread(void)
>  	pthread_attr_t thattr;
> =20
>  	pthread_attr_init(&thattr);
> -	pthread_attr_setstacksize(&thattr, PTHREAD_STACK_MIN);
> +	pthread_attr_setstacksize(&thattr, 32768);

Mmh... maybe rather $something +PTHREAD_STACK_MIN?

>  	pthread_create(&printer_thread, &thattr, printer_loop, NULL);
>  }
> =20
> @@ -464,6 +464,15 @@ static void forked_child_init(void)
>  	struct print_buffer *my_buffer =3D pthread_getspecific(buffer_key);
>  	struct print_buffer **pbuffer =3D &first_buffer;
> =20
> +	if (my_buffer) {
> +		/* Any content of my_buffer should be printed by our parent,
> +		   not us. */
> +		memset(my_buffer->ring, 0, my_buffer->size);
> +
> +		my_buffer->read_pos  =3D 0;
> +		my_buffer->write_pos =3D 0;
> +	}
> +

Ack.

>  	/* re-init to avoid finding it locked by some parent thread */
>  	pthread_mutex_init(&buffer_lock, NULL);
> =20
> @@ -518,3 +527,13 @@ void __rt_print_init(void)
>  	spawn_printer_thread();
>  	pthread_atfork(NULL, NULL, forked_child_init);
>  }
> +
> +void __rt_print_exit(void)
> +{
> +	if (buffers) {
> +		/* Flush the buffers. Do not call print_buffers here
> +		 * since we do not know if our stack is big enough. */
> +		nanosleep(&print_period, NULL);
> +		nanosleep(&print_period, NULL);
> +	}
> +}

IIRC, that's what cleanup_buffer is supposed to do, triggered by the
pthread key destruction. Can you explain why it failed in your scenario.

Jan


--------------enig50A40116EFF04EAE9E340D7B
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iEYEARECAAYFAktK2xwACgkQitSsb3rl5xSvLgCguv9ADBRyQKI8uDE5cm5BbwS4
Tp4AoIc+48lSUufjnxRGmpHigoXIs/gt
=aB8w
-----END PGP SIGNATURE-----

--------------enig50A40116EFF04EAE9E340D7B--

