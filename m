References: <1614690327-3500-1-git-send-email-chensong@tj.kylinos.cn>
From: Philippe Gerum <rpm@xenomai.org>
Subject: Re: [PATCH] y2038: introduce new time representations at the boundary
In-reply-to: <1614690327-3500-1-git-send-email-chensong@tj.kylinos.cn>
Date: Tue, 02 Mar 2021 14:44:50 +0100
Message-ID: <87y2f56565.fsf@xenomai.org>
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
To: chensong <chensong@tj.kylinos.cn>
Cc: florian.bezdeka@siemens.com, xenomai@xenomai.org, jan.kiszka@siemens.com


chensong <chensong@tj.kylinos.cn> writes:

> Since timespec and timeval will be removed because of
> y2038 problem, we need to introduce new time representations at
> the kernel-user boundary and we also need to keep aligned with
> upstream at the same time.
>
> Therefore, we introduce:
> 1)__kernel_old_timeval
> 2)__kernel_old_timespec
> from upstream, their tv_sec are defined as long and as a result their width
> is able to adapt different arch automatically.
>
> Signed-off-by: chensong <chensong@tj.kylinos.cn>
> ---
>  include/cobalt/uapi/kernel/types.h | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
>
> diff --git a/include/cobalt/uapi/kernel/types.h b/include/cobalt/uapi/kernel/types.h
> index 2c931c2..8931d82 100644
> --- a/include/cobalt/uapi/kernel/types.h
> +++ b/include/cobalt/uapi/kernel/types.h
> @@ -20,6 +20,7 @@
>  
>  #include <linux/types.h>
>  #include <cobalt/uapi/kernel/limits.h>
> +#include <asm-generic/xenomai/wrappers.h>
>  
>  typedef __u64 xnticks_t;
>  
> @@ -78,6 +79,20 @@ struct __user_old_timeval {
>  	long  tv_usec;
>  };
>  
> +#if LINUX_VERSION_CODE < KERNEL_VERSION(4,17,0)
> +struct __kernel_old_timeval {
> +	__kernel_long_t tv_sec;
> +	__kernel_long_t tv_usec;
> +};
> +#endif
> +
> +#if LINUX_VERSION_CODE < KERNEL_VERSION(5,5,0)
> +struct __kernel_old_timespec {
> +	__kernel_old_time_t	tv_sec;		/* seconds */
> +	long			tv_nsec;	/* nanoseconds */
> +};
> +#endif
> +
>  /* Lifted from include/uapi/linux/timex.h. */
>  struct __user_old_timex {
>  	unsigned int modes;	/* mode selector */


This won't work, the uapi is meant to be parsed by userland too,
independently of the target kernel version. Therefore, testing
LINUX_VERSION_CODE does not make sense there. Hence the reason for
defining __user_old_timespec, which does not conflict with any
pre-existing type in either kernel or userland namespaces.

What you might do instead is defining __kernel_old_timespec to mirror
the same kernel type only if __KERNEL__ is not set, but I would not
recommend checking for __KERNEL__ in this context anyway, since that
defeats the purpose of having separate uapi files.

-- 
Philippe.

