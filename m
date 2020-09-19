Subject: Re: [PATCH 2/4] cobalt/kernel: adapt adjtime syscall with upstream
 kernel
References: <20200918063216.8509-1-fino.meng@linux.intel.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <9e3e61df-c446-6953-1c1e-5cea528c8b14@siemens.com>
Date: Sat, 19 Sep 2020 14:05:35 +0200
MIME-Version: 1.0
In-Reply-To: <20200918063216.8509-1-fino.meng@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Fino Meng <fino.meng@linux.intel.com>, xenomai@xenomai.org, fino.meng@intel.com

On 18.09.20 08:32, Fino Meng wrote:
> compat_timex related definitions moved from compat code into normal timekeeping code.
> see 4d5f007e in upstream Linux kernel.
> 
> Signed-off-by: Fino Meng <fino.meng@linux.intel.com>
> Signed-off-by: Mingliang Hu <mingliang.hu@intel.com>
> ---
>   include/cobalt/kernel/compat.h  | 4 ++--
>   kernel/cobalt/posix/compat.c    | 4 ++--
>   kernel/cobalt/posix/syscall32.c | 2 +-
>   kernel/cobalt/posix/syscall32.h | 2 +-
>   4 files changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/include/cobalt/kernel/compat.h b/include/cobalt/kernel/compat.h
> index 05754cba8..c9cb84f72 100644
> --- a/include/cobalt/kernel/compat.h
> +++ b/include/cobalt/kernel/compat.h
> @@ -105,9 +105,9 @@ int sys32_put_timeval(struct compat_timeval __user *ctv,
>   		      const struct timeval *tv);
>   
>   int sys32_get_timex(struct timex *tx,
> -		    const struct compat_timex __user *ctx);
> +		    const struct old_timex32 __user *ctx);
>   
> -int sys32_put_timex(struct compat_timex __user *ctx,
> +int sys32_put_timex(struct old_timex32 __user *ctx,
>   		    const struct timex *tx);
>   
>   ssize_t sys32_get_fdset(fd_set *fds, const compat_fd_set __user *cfds,
> diff --git a/kernel/cobalt/posix/compat.c b/kernel/cobalt/posix/compat.c
> index 17968bff1..a31ec0457 100644
> --- a/kernel/cobalt/posix/compat.c
> +++ b/kernel/cobalt/posix/compat.c
> @@ -81,7 +81,7 @@ int sys32_put_timeval(struct compat_timeval __user *ctv,
>   EXPORT_SYMBOL_GPL(sys32_put_timeval);
>   
>   int sys32_get_timex(struct timex *tx,
> -		    const struct compat_timex __user *ctx)
> +		    const struct old_timex32 __user *ctx)
>   {
>   	memset(tx, 0, sizeof(*tx));
>   
> @@ -112,7 +112,7 @@ int sys32_get_timex(struct timex *tx,
>   }
>   EXPORT_SYMBOL_GPL(sys32_get_timex);
>   
> -int sys32_put_timex(struct compat_timex __user *ctx,
> +int sys32_put_timex(struct old_timex32 __user *ctx,
>   		    const struct timex *tx)
>   {
>   	if (!access_wok(ctx, sizeof(*ctx)) ||
> diff --git a/kernel/cobalt/posix/syscall32.c b/kernel/cobalt/posix/syscall32.c
> index faa7ef53a..c2fd6a1e0 100644
> --- a/kernel/cobalt/posix/syscall32.c
> +++ b/kernel/cobalt/posix/syscall32.c
> @@ -172,7 +172,7 @@ COBALT_SYSCALL32emu(clock_settime, current,
>   }
>   
>   COBALT_SYSCALL32emu(clock_adjtime, current,
> -		    (clockid_t clock_id, struct compat_timex __user *u_tx))
> +		    (clockid_t clock_id, struct old_timex32 __user *u_tx))
>   {
>   	struct timex tx;
>   	int ret;
> diff --git a/kernel/cobalt/posix/syscall32.h b/kernel/cobalt/posix/syscall32.h
> index 34904f96b..eb3e4bd30 100644
> --- a/kernel/cobalt/posix/syscall32.h
> +++ b/kernel/cobalt/posix/syscall32.h
> @@ -65,7 +65,7 @@ COBALT_SYSCALL32emu_DECL(clock_settime,
>   
>   COBALT_SYSCALL32emu_DECL(clock_adjtime,
>   			 (clockid_t clock_id,
> -			  struct compat_timex __user *u_tx));
> +			  struct old_timex32 __user *u_tx));
>   
>   COBALT_SYSCALL32emu_DECL(clock_nanosleep,
>   			 (clockid_t clock_id, int flags,
> 

That also breaks older kernels.

If you use our CI settings, you can easily catch such issues.

Jan

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

