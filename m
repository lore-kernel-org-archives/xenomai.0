Message-ID: <48B56685.4060500@domain.hid>
Date: Wed, 27 Aug 2008 16:36:53 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <48B5592B.1090005@domain.hid> <48B55F7C.5030901@domain.hid>
In-Reply-To: <48B55F7C.5030901@domain.hid>
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] [RFC][PATCH 2/3] Switch to handle-based fast
	mutex owners
Reply-To: gilles.chanteperdrix@xenomai.org
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: xenomai-core <xenomai@xenomai.org>

Jan Kiszka wrote:

> -#define test_claimed(owner) ((long) (owner) & 1)
> -#define clear_claimed(owner) ((xnthread_t *) ((long) (owner) & ~1))
> -#define set_claimed(owner, bit) \
> -        ((xnthread_t *) ((long) clear_claimed(owner) | !!(bit)))
> +#define __CLAIMED_BIT		XN_HANDLE_SPARE3
> +
> +#define test_claimed(owner)	xnhandle_test_spare(owner, __CLAIMED_BIT)
> +#define clear_claimed(owner)	xnhandle_mask_spare(owner)
> +#define set_claimed(owner, bit) ({ \
> +	xnhandle_t __tmp = xnhandle_mask_spare(owner); \
> +	if (bit) \
> +		xnhandle_set_spare(__tmp, __CLAIMED_BIT); \
> +	__tmp; \
> +})

I liked doing this with no conditional.

> +	xnarch_atomic_set(mutex->owner,
> +		 	  set_claimed(xnthread_handle(owner),
> +				      xnsynch_nsleepers(&mutex->synchbase)));

Ok. I think you have spotted a bug here. This should be mutex->sleepers
instead of xnsynch_nsleepers.

> +	/* Consistency check for owner handle - is the object a thread? */
> +	if (unlikely(xnthread_handle(owner) != clear_claimed(ownerh))) {
> +		err = -EINVAL;
> +		goto error;
>  	}

What is this ?


> Index: b/ksrc/skins/posix/thread.c
> ===================================================================
> --- a/ksrc/skins/posix/thread.c
> +++ b/ksrc/skins/posix/thread.c
> @@ -28,6 +28,7 @@
>   * 
>   *@{*/
>  
> +#include <nucleus/registry.h>
>  #include <posix/thread.h>
>  #include <posix/cancel.h>
>  #include <posix/timer.h>
> @@ -229,6 +230,13 @@ int pthread_create(pthread_t *tid,
>  	appendq(thread->container, &thread->link);
>  	xnlock_put_irqrestore(&nklock, s);
>  
> +#ifdef CONFIG_XENO_OPT_REGISTRY
> +	/* We need an anonymous registry entry to obtain a handle for fast
> +	   mutex locking. */
> +	xnregistry_enter("", &thread->threadbase,
> +			 &xnthread_handle(&thread->threadbase), NULL);
> +#endif /* CONFIG_XENO_OPT_REGISTRY */
> +

Since we need this for all threads (I want a thread from any skin to be
able to use the posix skin mutexes), why doing it in the skin ?

-- 
                                                 Gilles.

