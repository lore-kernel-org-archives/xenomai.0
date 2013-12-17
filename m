Message-ID: <52B006EC.7000000@xenomai.org>
Date: Tue, 17 Dec 2013 09:10:20 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <52AF4211.80203@siemens.com> <52AF4784.8030801@xenomai.org>
 <52AF7E5E.8070501@xenomai.org>
In-Reply-To: <52AF7E5E.8070501@xenomai.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] forge: Trying to understand new semaphore code
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>, Jan Kiszka <jan.kiszka@siemens.com>
Cc: Xenomai <xenomai@xenomai.org>

On 12/16/2013 11:27 PM, Gilles Chanteperdrix wrote:
>
> Hi,
>
> here comes the fix for the two issues. If we are allowed to rebase
> the next branch, I suggest to fold it with the original semaphore
> commit. Otherwise, I can push this commit on my branch.

Rebasing is always allowed on -next, I'll pick this up. Thanks.

>
> diff --git a/kernel/cobalt/posix/nsem.c b/kernel/cobalt/posix/nsem.c
> index 7e66ea8..72edacb 100644
> --- a/kernel/cobalt/posix/nsem.c
> +++ b/kernel/cobalt/posix/nsem.c
> @@ -119,9 +119,10 @@ nsem_open(struct __shadow_sem __user *ushadow, const char *name,
>   		if ((oflags & O_CREAT) == 0)
>   			return ERR_PTR(-ENOENT);
>
> -		rc = cobalt_sem_init_inner
> +		sem = cobalt_sem_init_inner
>   			(&name[1], &shadow, SEM_PSHARED, value);
> -		if (rc < 0) {
> +		if (IS_ERR(sem)) {
> +			rc = PTR_ERR(sem);
>   			if (rc == -EEXIST)
>   				goto retry_bind;
>   			return ERR_PTR(rc);
> @@ -132,8 +133,6 @@ nsem_open(struct __shadow_sem __user *ushadow, const char *name,
>   			return ERR_PTR(-EFAULT);
>   		}
>   		handle = shadow.handle;
> -		sem = xnregistry_fetch(handle);
> -		++sem->refs;
>   	}
>
>   	u = xnmalloc(sizeof(*u));
> @@ -154,9 +153,6 @@ nsem_open(struct __shadow_sem __user *ushadow, const char *name,
>   		--sem->refs;
>   		xnlock_put_irqrestore(&nklock, s);
>
> -		if (rc == -EWOULDBLOCK)
> -			cobalt_sem_destroy_inner(sem->handle);
> -
>   		xnfree(u);
>   		u = v;
>   	} else {
> diff --git a/kernel/cobalt/posix/sem.c b/kernel/cobalt/posix/sem.c
> index 2f632f6..93fb6d8 100644
> --- a/kernel/cobalt/posix/sem.c
> +++ b/kernel/cobalt/posix/sem.c
> @@ -32,6 +32,7 @@
>    *@{*/
>
>   #include <stddef.h>
> +#include <linux/err.h>
>   #include "internal.h"
>   #include "thread.h"
>   #include "clock.h"
> @@ -82,8 +83,9 @@ int cobalt_sem_destroy_inner(xnhandle_t handle)
>   	return ret;
>   }
>
> -int cobalt_sem_init_inner(const char *name, struct __shadow_sem *sm,
> -			int flags, unsigned int value)
> +struct cobalt_sem *
> +cobalt_sem_init_inner(const char *name, struct __shadow_sem *sm,
> +		int flags, unsigned int value)
>   {
>   	struct list_head *semq;
>   	struct cobalt_sem *sem, *osem;
> @@ -94,11 +96,11 @@ int cobalt_sem_init_inner(const char *name, struct __shadow_sem *sm,
>   	spl_t s;
>
>   	if ((flags & SEM_PULSE) != 0 && value > 0)
> -		return -EINVAL;
> +		return ERR_PTR(-EINVAL);
>
>   	sem = xnmalloc(sizeof(*sem));
>   	if (sem == NULL)
> -		return -ENOSPC;
> +		return ERR_PTR(-ENOSPC);
>
>   	snprintf(sem->name, sizeof(sem->name), "%s", name);
>
> @@ -159,7 +161,7 @@ int cobalt_sem_init_inner(const char *name, struct __shadow_sem *sm,
>   	datp->flags = flags;
>   	sem->flags = flags;
>   	sem->owningq = kq;
> -	sem->refs = 1;
> +	sem->refs = name[0] ? 2 : 1;
>   			
>   	sm->magic = name[0] ? COBALT_NAMED_SEM_MAGIC : COBALT_SEM_MAGIC;
>   	sm->handle = sem->handle;
> @@ -168,7 +170,7 @@ int cobalt_sem_init_inner(const char *name, struct __shadow_sem *sm,
>   		sm->datp_offset = -sm->datp_offset;
>   	xnlock_put_irqrestore(&nklock, s);
>
> -	return 0;
> +	return sem;
>
>     err_lock_put:
>   	xnlock_put_irqrestore(&nklock, s);
> @@ -176,7 +178,7 @@ int cobalt_sem_init_inner(const char *name, struct __shadow_sem *sm,
>     err_free_sem:
>   	xnfree(sem);
>
> -	return ret;
> +	return ERR_PTR(ret);
>   }
>
>   /**
> @@ -653,14 +655,15 @@ static int sem_getvalue(xnhandle_t handle, int *value)
>   int cobalt_sem_init(struct __shadow_sem __user *u_sem, int pshared, unsigned value)
>   {
>   	struct __shadow_sem sm;
> +	struct cobalt_sem *sem;
>   	int err;
>
>   	if (__xn_safe_copy_from_user(&sm, u_sem, sizeof(sm)))
>   		return -EFAULT;
>
> -	err = cobalt_sem_init_inner("", &sm, pshared ? SEM_PSHARED : 0, value);
> -	if (err < 0)
> -		return err;
> +	sem = cobalt_sem_init_inner("", &sm, pshared ? SEM_PSHARED : 0, value);
> +	if (IS_ERR(sem))
> +		return PTR_ERR(sem);
>
>   	return __xn_safe_copy_to_user(u_sem, &sm, sizeof(*u_sem));
>   }
> @@ -735,6 +738,7 @@ int cobalt_sem_init_np(struct __shadow_sem __user *u_sem,
>   		       int flags, unsigned value)
>   {
>   	struct __shadow_sem sm;
> +	struct cobalt_sem *sem;
>   	int err;
>
>   	if (__xn_safe_copy_from_user(&sm, u_sem, sizeof(sm)))
> @@ -744,9 +748,9 @@ int cobalt_sem_init_np(struct __shadow_sem __user *u_sem,
>   		      SEM_WARNDEL|SEM_RAWCLOCK|SEM_NOBUSYDEL))
>   		return -EINVAL;
>
> -	err = cobalt_sem_init_inner("", &sm, flags, value);
> -	if (err < 0)
> -		return err;
> +	sem = cobalt_sem_init_inner("", &sm, flags, value);
> +	if (IS_ERR(sem))
> +		return PTR_ERR(sem);
>
>   	return __xn_safe_copy_to_user(u_sem, &sm, sizeof(*u_sem));
>   }
> diff --git a/kernel/cobalt/posix/sem.h b/kernel/cobalt/posix/sem.h
> index 1548e66..7667976 100644
> --- a/kernel/cobalt/posix/sem.h
> +++ b/kernel/cobalt/posix/sem.h
> @@ -57,7 +57,8 @@ typedef struct
>   #define SEM_VALUE_MAX (INT_MAX)
>   #define SEM_FAILED    NULL
>
> -int cobalt_sem_init_inner(const char *name, struct __shadow_sem *sem,
> +struct cobalt_sem *
> +cobalt_sem_init_inner(const char *name, struct __shadow_sem *sem,
>   		int flags, unsigned value);
>
>   int cobalt_sem_destroy_inner(xnhandle_t handle);
>
>
>


-- 
Philippe.

