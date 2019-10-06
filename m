Subject: Re: [PATCH] ipipe: Make ipipe_root_nr_syscalls independent of
 CONFIG_IPIPE
References: <c92a7502-d1c7-b07f-663b-950af084eebd@siemens.com>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <73a936cb-ba6f-a3a8-603f-334998f8ab6c@xenomai.org>
Date: Sun, 6 Oct 2019 18:21:36 +0200
MIME-Version: 1.0
In-Reply-To: <c92a7502-d1c7-b07f-663b-950af084eebd@siemens.com>
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
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: Xenomai <xenomai@xenomai.org>

On 9/25/19 4:45 PM, Jan Kiszka wrote:
> From: Jan Kiszka <jan.kiszka@siemens.com>
> 
> Needed on x86 at least when CONFIG_IPIPE is off.
> 
> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
> ---
>  include/linux/ipipe.h | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/include/linux/ipipe.h b/include/linux/ipipe.h
> index 45e8c87bff93..fe90cb55d462 100644
> --- a/include/linux/ipipe.h
> +++ b/include/linux/ipipe.h
> @@ -204,10 +204,6 @@ int __ipipe_notify_user_intreturn(void);
>  
>  #define __ipipe_serial_debug(__fmt, __args...)	raw_printk(__fmt, ##__args)
>  
> -#ifndef ipipe_root_nr_syscalls
> -#define ipipe_root_nr_syscalls(ti)	NR_syscalls
> -#endif
> -
>  struct ipipe_trap_data {
>  	int exception;
>  	struct pt_regs *regs;
> @@ -718,4 +714,8 @@ static inline void __ipipe_pin_mapping_globally(unsigned long start,
>  { }
>  #endif
>  
> +#ifndef ipipe_root_nr_syscalls
> +#define ipipe_root_nr_syscalls(ti)	NR_syscalls
> +#endif
> +
>  #endif	/* !__LINUX_IPIPE_H */
> 

Merged, thanks.

-- 
Philippe.

