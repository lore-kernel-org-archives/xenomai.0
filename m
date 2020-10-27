Subject: Re: [PATCH 01/11] cobalt/kernel: adapt adjtime syscall with upstream
 kernel
References: <cover.1603710297.git.jan.kiszka@siemens.com>
 <844c57389ef1795bac7ef2e00fbf6370b5ac42a7.1603710297.git.jan.kiszka@siemens.com>
From: chensong <chensong@tj.kylinos.cn>
Message-ID: <5F9774FC.1000505@tj.kylinos.cn>+3791F346D2657039
Date: Tue, 27 Oct 2020 09:16:44 +0800
MIME-Version: 1.0
In-Reply-To: <844c57389ef1795bac7ef2e00fbf6370b5ac42a7.1603710297.git.jan.kiszka@siemens.com>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Jan Kiszka <jan.kiszka@siemens.com>, xenomai@xenomai.org
Cc: Mingliang Hu <mingliang.hu@intel.com>



On 2020年10月26日 19:04, Jan Kiszka via Xenomai wrote:
> From: Fino Meng <fino.meng@linux.intel.com>
>
> compat_timex related definitions moved from compat code into normal timekeeping code.
> see 4d5f007e in upstream Linux kernel.
>
> Signed-off-by: Fino Meng <fino.meng@linux.intel.com>
> Signed-off-by: Mingliang Hu <mingliang.hu@intel.com>
> [Jan: account for older kernel versions]
> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
> ---
>   include/cobalt/kernel/compat.h                       | 4 ++--
>   kernel/cobalt/include/asm-generic/xenomai/wrappers.h | 4 ++++
>   kernel/cobalt/posix/compat.c                         | 4 ++--
>   kernel/cobalt/posix/syscall32.c                      | 2 +-
>   kernel/cobalt/posix/syscall32.h                      | 2 +-
>   5 files changed, 10 insertions(+), 6 deletions(-)
>
> diff --git a/include/cobalt/kernel/compat.h b/include/cobalt/kernel/compat.h
> index 05754cba89..c9cb84f721 100644
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
> diff --git a/kernel/cobalt/include/asm-generic/xenomai/wrappers.h b/kernel/cobalt/include/asm-generic/xenomai/wrappers.h
> index 23993dcc15..de5a992850 100644
> --- a/kernel/cobalt/include/asm-generic/xenomai/wrappers.h
> +++ b/kernel/cobalt/include/asm-generic/xenomai/wrappers.h
> @@ -156,4 +156,8 @@ devm_hwmon_device_register_with_groups(struct device *dev, const char *name,
>   #error "Xenomai/cobalt requires Linux kernel 3.10 or above"
>   #endif /* < 3.10 */
>
> +#if LINUX_VERSION_CODE < KERNEL_VERSION(5,1,0)
> +#define old_timex32		compat_timex
> +#endif
> +
>   #endif /* _COBALT_ASM_GENERIC_WRAPPERS_H */
> diff --git a/kernel/cobalt/posix/compat.c b/kernel/cobalt/posix/compat.c
> index 17968bff1d..a31ec04578 100644
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
> index faa7ef53a6..c2fd6a1e05 100644
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
> index 34904f96bd..eb3e4bd300 100644
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

After 5.4 is ready, i will try to verify it on arm, meanwhile, i also 
need to have a look how musl works for xenomai.

chensong



