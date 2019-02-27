Subject: Re: [PATCH] cobalt: Improve cobalt_copy_from/to_user
From: Jan Kiszka <jan.kiszka@siemens.com>
References: <6313fbe6-b76c-b89d-6cbd-65066a7bfd94@siemens.com>
Message-ID: <767a38f5-97d1-30f0-264c-a9d7804b9d21@siemens.com>
Date: Wed, 27 Feb 2019 07:34:25 +0100
MIME-Version: 1.0
In-Reply-To: <6313fbe6-b76c-b89d-6cbd-65066a7bfd94@siemens.com>
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
To: Xenomai <xenomai@xenomai.org>

On 26.02.19 14:23, Jan Kiszka wrote:
> From: Jan Kiszka <jan.kiszka@siemens.com>
> 
> This aligns the definition of our user copy services with the kernel in
> two aspects:
>   - use unlikely to mark the fast path
>   - memset the remaining bits of the target region if the copy fails;
>     this avoids false-positive compiler warnings and reduces the risk to
>     evaluate undefined data in case the return value is not checked
> 
> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
> ---
>   kernel/cobalt/include/asm-generic/xenomai/syscall.h | 18 ++++++++++++++----
>   1 file changed, 14 insertions(+), 4 deletions(-)
> 
> diff --git a/kernel/cobalt/include/asm-generic/xenomai/syscall.h b/kernel/cobalt/include/asm-generic/xenomai/syscall.h
> index 7909fc310a..e14a9d1e3b 100644
> --- a/kernel/cobalt/include/asm-generic/xenomai/syscall.h
> +++ b/kernel/cobalt/include/asm-generic/xenomai/syscall.h
> @@ -46,15 +46,25 @@
>   static inline int cobalt_copy_from_user(void *dst, const void __user *src,
>   					size_t size)
>   {
> -	return (!access_rok(src, size) ||
> -		__xn_copy_from_user(dst, src, size)) ? -EFAULT : 0;
> +	size_t remaining = size;
> +
> +	if (likely(access_rok(src, size)))
> +		remaining = __xn_copy_from_user(dst, src, size);
> +
> +	if (unlikely(remaining > 0)) {
> +		memset(dst + (size - remaining), 0, remaining);
> +		return -EFAULT;
> +	}
> +	return 0;
>   }
>   
>   static inline int cobalt_copy_to_user(void __user *dst, const void *src,
>   				      size_t size)
>   {
> -	return (!access_wok(dst, size) ||
> -		__xn_copy_to_user(dst, src, size)) ? -EFAULT : 0;
> +	if (unlikely(!access_wok(dst, size) ||
> +	    __xn_copy_to_user(dst, src, size)))
> +		return -EFAULT;
> +	return 0;
>   }
>   
>   static inline int cobalt_strncpy_from_user(char *dst, const char __user *src,
> 

FWIW, I've just realized that we still use a lot of rtdm_copy_*_user without 
rtdm_read/rw_user_ok. Those should be migrated to rtdm_safe_copy_* eventually. 
I'm even considering to deprecate the split API, but one after the other.

Jan

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

