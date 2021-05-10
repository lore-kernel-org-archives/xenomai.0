Subject: Re: [PATCH wip/dovetail 1/1] cobalt: Remove duplicate
 timespec/itimerspec copy helpers
References: <20210507151830.1260775-1-florian.bezdeka@siemens.com>
 <20210507151830.1260775-2-florian.bezdeka@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <cb1fed37-68a5-d08d-a323-b49778012665@siemens.com>
Date: Mon, 10 May 2021 09:02:31 +0200
MIME-Version: 1.0
In-Reply-To: <20210507151830.1260775-2-florian.bezdeka@siemens.com>
Content-Type: text/plain; charset=utf-8
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
To: Florian Bezdeka <florian.bezdeka@siemens.com>, xenomai@xenomai.org

On 07.05.21 17:18, Florian Bezdeka wrote:
> The variant of such helpers which are using a temporary element on the
> stack work in both worlds, so on systems with 4 and 8 byte time_t.
> To keep the code as simple as possible we can remove the
> __BITS_PER_LONG == 64 implementation.
> 
> Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
> ---
>  .../include/asm-generic/xenomai/syscall.h     | 31 -------------------
>  1 file changed, 31 deletions(-)
> 
> diff --git a/kernel/cobalt/include/asm-generic/xenomai/syscall.h b/kernel/cobalt/include/asm-generic/xenomai/syscall.h
> index 194583c18..117bb3ff8 100644
> --- a/kernel/cobalt/include/asm-generic/xenomai/syscall.h
> +++ b/kernel/cobalt/include/asm-generic/xenomai/syscall.h
> @@ -75,41 +75,12 @@ static inline int cobalt_strncpy_from_user(char *dst, const char __user *src,
>  	return __xn_strncpy_from_user(dst, src, count);
>  }
>  
> -#if __BITS_PER_LONG == 64
>  
>  /*
>   * NOTE: those copy helpers won't work in compat mode: use
>   * sys32_get_*(), sys32_put_*() instead.
>   */
>  
> -static inline int cobalt_get_u_timespec(struct timespec64 *dst,
> -			const struct __user_old_timespec __user *src)
> -{
> -	return cobalt_copy_from_user(dst, src, sizeof(*dst));
> -}
> -
> -static inline int cobalt_put_u_timespec(
> -	struct __user_old_timespec __user *dst,
> -	const struct timespec64 *src)
> -{
> -	return cobalt_copy_to_user(dst, src, sizeof(*dst));
> -}
> -
> -static inline int cobalt_get_u_itimerspec(struct itimerspec64 *dst,
> -			const struct __user_old_itimerspec __user *src)
> -{
> -	return cobalt_copy_from_user(dst, src, sizeof(*dst));
> -}
> -
> -static inline int cobalt_put_u_itimerspec(
> -	struct __user_old_itimerspec __user *dst,
> -	const struct itimerspec64 *src)
> -{
> -	return cobalt_copy_to_user(dst, src, sizeof(*dst));
> -}
> -
> -#else /* __BITS_PER_LONG == 32 */
> -
>  static inline int cobalt_get_u_timespec(struct timespec64 *dst,
>  			const struct __user_old_timespec __user *src)
>  {
> @@ -175,8 +146,6 @@ static inline int cobalt_put_u_itimerspec(
>  	return cobalt_copy_to_user(dst, &u_its, sizeof(*dst));
>  }
>  
> -#endif
> -
>  /* 32bit syscall emulation */
>  #define __COBALT_COMPAT_BIT	0x1
>  /* 32bit syscall emulation - extended form */
> 

Thanks, applied to next.

Jan

-- 
Siemens AG, T RDA IOT
Corporate Competence Center Embedded Linux

