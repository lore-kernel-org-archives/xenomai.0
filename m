Received: from mout.web.de (mout.web.de [212.227.17.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97829320F
	for <xenomai@lists.linux.dev>; Sat, 29 Mar 2025 22:25:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743287121; cv=none; b=pjQQfX6w5N4RHXsmQPxduDlczO9odvrhmlItks1gwp51yGWO5VFviE0X1+qpm7DlG+DpoHNlf2BAMhy8WIJv+Zzdl5BMUh1i7NsdHa7jMhx9bMdYwdjDLhxFTqVxCOjAlfKCCVsu7BAzzhoaR7bzFBV9YoifbqT4S50Gv8yBYVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743287121; c=relaxed/simple;
	bh=Z7qt4Se2lb2zLMMCo9hzPD579xIn1cUIYGJ8oM5BZ9w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EIOO3tlGwh2vgOsE2LnNqiTx/zEiwbZi45dVanEihdtHMDYtjP/46k/su/htQIhXovZvlLH0hQgfWlfPDsWnT3AnFKSJbtnkBYjforcoC5ew+DacSwS3nhKBh/RPfx7iyh8drZoC70xcWpCVrapZwibUymZyhxgOF3NZaDxdlk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=jan.kiszka@web.de header.b=wW3CNKti; arc=none smtp.client-ip=212.227.17.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=jan.kiszka@web.de header.b="wW3CNKti"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1743287109; x=1743891909; i=jan.kiszka@web.de;
	bh=pBzmhFBZcoiC8ydfCAW2CKIf9JiSqZ/4V+DzE/4AXnQ=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=wW3CNKti756eQu54qtnXauxkUsC2cXzTyPjxS4936kN8VU9HKIxxGzH1HsgxSJSF
	 7aFSkvnsf6fuPjFHX9NRSamQlutbuXsXP90Dpi7Nz487Wb0ncWwlRjmCJuJ6n6oiP
	 lsERksYwSbPR8Gw8FDO9u6llDM62i07JFdwngN4oOIB5sILAvcKaJ8YGecF+I7u5o
	 7O+esDpvo2S6EePrMAH/piTc8bzMvGGv+GGMge9FeZVkW/TC+Au/0qubcj1Vk+hpB
	 nokLi36RfnFKzfSzdz8EUiWkCdUh3sEhO+HzPvXMSPBm+bm0VZyZMZPHjku9ksiMG
	 5Ez6DiV/oIj5LeYQ+A==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.31] ([82.83.170.15]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1M1rP8-1twSkv1448-00DfMc; Sat, 29
 Mar 2025 23:25:09 +0100
Message-ID: <b2f68c9c-c677-4e31-9d4e-47a647f0a46d@web.de>
Date: Sat, 29 Mar 2025 23:25:08 +0100
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] lib/cobalt: Fix a deadlock when release_buffer() attempts
 to re-acquire buffer_lock
To: Ethan <aspirestro@163.com>, florian.bezdeka@siemens.com, rpm@xenomai.org
Cc: xenomai@lists.linux.dev
References: <20250329160646.527363-1-aspirestro@163.com>
From: Jan Kiszka <jan.kiszka@web.de>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@web.de; keydata=
 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
In-Reply-To: <20250329160646.527363-1-aspirestro@163.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:lCl6GW7xJ6hIDHCUHJsdcp/62msqczxieZZJSwBnvwOmVlK9e6L
 QoD0LIHJS3Ty9Al84N1H1VYEdTSoWev3TPEw/hDJ0dSkGDvxhtYiVRvxhzoXEqZJbFTqvQ0
 d+dlYTWRA46WGUy0Tpnalu9fOaynb46uGb0MFiIvpfMzb7WMOB/plSwlqupOUHgHxYdhKTZ
 PsUHtxwFX9H3cyr7VC26g==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:wsGVeqbYU7E=;Z0L2QcOhEg/wGxQeKrE+dpMf+UN
 4ESV4zPZe9rVzKZJ9r6KFShB03Q2mkTdGl1pQPGI2vw4VrD3aM1Q06dXlQcwBk+8bZn8OqHb1
 C7er1uBhWS9Ck8fsetlbC9Hm4MHBeJ/6xqU2YkUBYa/uaUzU0y2Axjw0QxfNwjNyut8FyTsiY
 kQiSnGeBBRJtoRuOWmzDarq9OUBs/wDlN6/jX2IDrTBisfkekdbvIE2WdeDZRk5bVwCwNe9JP
 iBMBxxcP1BV7/K1YNZdIa9AIkO91MSXDd6oaO1VZsKxd95Eg/cuv6uMqs2YR0bZJmvCoN2Ze8
 sR18ZUfAwzIyFowAZnxOwDda3uTVpexcW9XiO6gPkZa8S6emDnp9EX03ikTsvjziWSOpamlCT
 z+V+MbXtTL7xFMYjL34CLWSrpmPrpTKlJITDQMzT/aUnXonYZ56JrpKpbymU7mYjC+NGHbiaZ
 fdhjainj6UB6uq8zCp0J1HNI8g930KLOZtt1T3jBf5bErnphP+CwkNK60cgiydoeN8fPFFh95
 j9BexBQBN/3kNCJeumj+NCd0MV2LgsdqatIIlCU3mCCzmuP91XmyoEKbWTdSRXFKA8JXawf49
 04iIQpBNCubRQpSDTU5XwbKLdLR6FAQBohf9lNYqI1QBEdtqBWbDq9C260agg9fuM0pkQtkdW
 mlN7s6oeCj3TWtWsgD9eUzRwuKvibifRGljVzUT8yrk1zkKroNryPyozC3wXSjB3/4h56QGPq
 Q67pR0o9eL+Cj2o6O0aws9GF1LeCze2WBm4+1+DKNyApAJF73xvQhbvSwIyeZJPNtXpTJ1ZZu
 rRxW2MikvmLzS3lbNJJWUzDciqoZs1F6ipXM2CBgPOor7t/duyTBbYM+vOK/jN+PTlp5sK54s
 0v9kMv5AkN2a39Ub3BIlbuXeQJXDRljvJlxxHHM96h0+/Mz6izrdVmMQjn7y6iUx+d5B6hbdf
 NZ8rO76bjTealOb+k/2+vFmaeCPlrdkBKRFsFnt03ssx3eTlzRp2lwuPVL/idPpB4C+2tzsW2
 bBrfY2mVWmtjUUtUGp3xa2lBr595ELFcjGzsOilus3lG0jaj46Oxqew1kwxCjNrJsiM2wsVaz
 O8+aCp5fbYFTgXhvEiE1BYN6OOx+Epk4d4FMmverXWXSaBzZT3fKhKee3EaS49NLyHE9KbC6U
 Bn7lV9HRPphC6E1hNcUbiXp2AzjLgIhIjJOFSgKKjNe+f8GIEsgSzKDjJS4752WANJRtw8V2x
 Va+xBaqRXPQcgClQq6Z4p8PDs1sm7Pqry5bxTLV6XcnTDlLTJAKqX3J7cusj7BPhzS1g/Pkxw
 v410N5BpdGylDtA/Z4RwrbZoUaGaEG2qzQeU9AoZ3fPyxxzYGmgsHtMZKpZKbHaegrl0tdUHg
 Aa9KV4IiYUHFT2k1hIYZDlU+y9HV5tbYb9aub7TI/S21sVEuJKlehGjZaCMTYCoLYGzuYAcmy
 52OL2efz+CSId2zMEe8td3XT6tG0=

On 29.03.25 17:06, Ethan wrote:
> The release_buffer() function is the destructor function for the thread-=
specific
> data (TSD) associated with buffer_key. If the current thread is executin=
g
> rt_print_flush_buffers() and has already acquired buffer_lock, and is th=
en
> requested to exit via pthread_cancel(), the release_buffer() function wi=
ll be
> invoked. A deadlock can occur when release_buffer() attempts to re-acqui=
re
> buffer_lock.
>
> This patch changes the buffer_lock from PTHREAD_MUTEX_DEFAULT to
> PTHREAD_MUTEX_ERRORCHECK type, as it supports deadlock detection. If the=
 lock is
> successfully acquired, it will return 0. If the same thread attempts to =
re-lock
> a mutex that it has already locked, it will return EDEADLK. This approac=
h
> prevents the deadlock issue.
>
> The deadlock can be observed as gdb shown. The thread "slave" will block=
 when
> calling pthread_mutex_lock() in release_buffer() while attempting to re-=
acquire
> buffer_lock again. This also causes cobalt_print to remain waiting indef=
initely
> for buffer_lock.
>
> (gdb) info thread
>   Id   Target Id                                        Frame
> * 1    Thread 0x7ff7ff4010 (LWP 1654) "hello"           0x0000007ff7bb63=
98 in sched_yield () at ../sysdeps/unix/syscall-template.S:78
>   2    Thread 0x7ff7a7a1c0 (LWP 1657) "cobalt_printf"   __lll_lock_wait =
(futex=3Dfutex@entry=3D0x7ff7fcaed8 <buffer_lock>, private=3D0)
>     at lowlevellock.c:52
>   3    Thread 0x7ff72791c0 (LWP 1658) "master"          0x0000007ff7b6d3=
14 in __GI__IO_default_xsputn (n=3D<optimized out>, data=3D<optimized out>=
,
>     f=3D<optimized out>) at genops.c:393
>   4    Thread 0x7ff72581c0 (LWP 1659) "slave" (Exiting) __lll_lock_wait =
(futex=3Dfutex@entry=3D0x7ff7fcaed8 <buffer_lock>, private=3D0)
>     at lowlevellock.c:52
> (gdb) thread 4
> [Switching to thread 4 (Thread 0x7ff72581c0 (LWP 1659))]
> 52      lowlevellock.c: No such file or directory.
> (gdb) bt
> (gdb) p ((pthread_mutex_t*) &buffer_lock)->__data.__owner
> $4 =3D 1659
> (gdb) p ((pthread_mutex_t*) &buffer_lock)->__data.__lock
> $5 =3D 2
>
> Signed-off-by: Ethan <aspirestro@163.com>
> ---
>  lib/cobalt/printf.c | 13 +++++++++++--
>  1 file changed, 11 insertions(+), 2 deletions(-)
>
> diff --git a/lib/cobalt/printf.c b/lib/cobalt/printf.c
> index 0aa5940c6..87ed989f4 100644
> --- a/lib/cobalt/printf.c
> +++ b/lib/cobalt/printf.c
> @@ -82,6 +82,7 @@ static struct timespec syncdelay;
>  static pthread_mutex_t buffer_lock;
>  static pthread_cond_t printer_wakeup;
>  static pthread_key_t buffer_key;
> +static pthread_mutexattr_t attr;
>  static pthread_key_t cleanup_key;
>  static pthread_t printer_thread;
>  static atomic_long_t *pool_bitmap;
> @@ -498,6 +499,12 @@ static void release_buffer(struct print_buffer *buf=
fer)
>
>  	pthread_setspecific(buffer_key, NULL);
>
> +	/* The type of buffer_lock is PTHREAD_MUTEX_ERRORCHECK, which supports
> +	 * deadlock detection. If the lock is successfully acquired, it will r=
eturn
> +	 * 0; If the same thread attempts to re-lock a mutex that it has alrea=
dy
> +	 * locked, it will return EDEADLK. This approach prevents the deadlock
> +	 * issue.
> +	 */
>  	pthread_mutex_lock(&buffer_lock);
>
>  	print_buffers();
> @@ -666,7 +673,7 @@ void cobalt_print_init_atfork(void)
>  	}
>
>  	/* re-init to avoid finding it locked by some parent thread */
> -	pthread_mutex_init(&buffer_lock, NULL);
> +	pthread_mutex_init(&buffer_lock, &attr);
>
>  	while (*pbuffer) {
>  		if (*pbuffer =3D=3D my_buffer)
> @@ -723,7 +730,9 @@ void cobalt_print_init(void)
>  		rt_print_init_inner(buffer, __cobalt_print_bufsz);
>  	}
>  done:
> -	pthread_mutex_init(&buffer_lock, NULL);
> +	pthread_mutexattr_init(&attr);
> +	pthread_mutexattr_settype(&attr, PTHREAD_MUTEX_ERRORCHECK);

Good catch! But why not using PTHREAD_MUTEX_RECURSIVE, rather then
triggering an error that is not handled and therefore happens to let the
caller continue?

Jan

> +	pthread_mutex_init(&buffer_lock, &attr);
>  	pthread_key_create(&buffer_key, (void (*)(void*))release_buffer);
>  	pthread_key_create(&cleanup_key, do_cleanup);
>  	pthread_cond_init(&printer_wakeup, NULL);

