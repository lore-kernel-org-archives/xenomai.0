Message-ID: <4B9527FD.3040806@domain.hid>
Date: Mon, 08 Mar 2010 17:38:21 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <mailman.4538.1268063562.8399.xenomai-git@xenomai.org>
In-Reply-To: <mailman.4538.1268063562.8399.xenomai-git@xenomai.org>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-core] [Xenomai-git] common: do not let u_mode exceptional
 cases leak out of current.[ch]
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai-core <xenomai@xenomai.org>

xenomai-git-request@domain.hid wrote:
> diff --git a/include/asm-generic/bits/current.h b/include/asm-generic/bits/current.h
> index f0e569c..b9ac680 100644
> --- a/include/asm-generic/bits/current.h
> +++ b/include/asm-generic/bits/current.h

...

> @@ -33,25 +33,16 @@ static inline xnhandle_t xeno_get_current(void)
>  {
>  	void *val = pthread_getspecific(xeno_current_key);
>  
> -	if (!val)
> -		return XN_NO_HANDLE;
> -
> -	return (xnhandle_t)val;
> +	return (xnhandle_t)val ?: xeno_slow_get_current();
>  }

So when used with normal Linux threads, this will always trigger the
syscall of xeno_slow_get_current()?

> diff --git a/src/rtdk/assert_context.c b/src/rtdk/assert_context.c
> index bad19f3..f67bcd8 100644
> --- a/src/rtdk/assert_context.c
> +++ b/src/rtdk/assert_context.c
> @@ -30,12 +30,9 @@ void assert_nrt(void)
>  	xnthread_info_t info;
>  	int err;
>  
> -	if (xeno_get_current() != XN_NO_HANDLE)
> -		return;
> +	if (unlikely(xeno_get_current() != XN_NO_HANDLE &&
> +		     !(xeno_get_current_mode() & XNRELAX))) {

Then please provide a different API for assert_nrt as this makes the
service too heavy for common use.

The current_mode slow path is no problem as it only triggers during cleanup.

Thanks,
Jan

-- 
Siemens AG, Corporate Technology, CT T DE IT 1
Corporate Competence Center Embedded Linux

