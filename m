From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <1273133336-9802-1-git-send-email-wolfgang.mauerer@domain.hid>
References: <1273133336-9802-1-git-send-email-wolfgang.mauerer@domain.hid>
Content-Type: text/plain; charset="UTF-8"
Date: Thu, 06 May 2010 15:04:51 +0200
Message-ID: <1273151091.2440.143.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] [PATCH] Fix x86_64 builds with CC_STACKPROTECTOR
	enabled
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Wolfgang Mauerer <wolfgang.mauerer@domain.hid>
Cc: jan.kiszka@domain.hid, xenomai@xenomai.org

On Thu, 2010-05-06 at 10:08 +0200, Wolfgang Mauerer wrote:
> From: Wolfgang Mauerer (none) <wolfgang@domain.hid>
> 
> The per_cpu__ prefix for per-cpu-variables in the Linux kernel
> is gone since dd17c8f72993f. This patch adapts the x86_64
> task switching code to cope with kernels before and after this
> commit.
> 
> Signed-off-by: Wolfgang Mauerer <wolfgang.mauerer@domain.hid>
> Acked-by: Jan Kiszka <jan.kiszka@domain.hid>
> ---
>  include/asm-x86/switch_64.h |    4 ++++
>  1 files changed, 4 insertions(+), 0 deletions(-)
> 
> diff --git a/include/asm-x86/switch_64.h b/include/asm-x86/switch_64.h
> index a716ad6..c2df7d8 100644
> --- a/include/asm-x86/switch_64.h
> +++ b/include/asm-x86/switch_64.h
> @@ -37,6 +37,10 @@ struct xnarch_x8664_initstack {
>  };
>  
>  #ifdef CONFIG_CC_STACKPROTECTOR
> +#include <asm/percpu.h>
> +#ifndef per_cpu_var
> +#define per_cpu_var(x)	x
> +#endif

Please move those soon-to-be-generic bits to asm-generic/wrappers.h,
into a section that would be unconditionally parsed with 2.6.34 or
later.

TIA,

>  /*
>   * We have an added complexity with -fstack-protector, due to the
>   * hybrid scheduling between user- and kernel-based Xenomai threads,


-- 
Philippe.



