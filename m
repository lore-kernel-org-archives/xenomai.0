Message-ID: <4C2DEC39.4070501@domain.hid>
Date: Fri, 02 Jul 2010 15:40:09 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <1278071401-13880-1-git-send-email-wolfgang.mauerer@domain.hid>
	<1278071401-13880-3-git-send-email-wolfgang.mauerer@domain.hid>
In-Reply-To: <1278071401-13880-3-git-send-email-wolfgang.mauerer@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Adeos-main] [PATCH 2/2] ipipe: CLOCK_HOST_REALTIME:
 x86-specific part
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: </public/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: Wolfgang Mauerer <wolfgang.mauerer@domain.hid>
Cc: Jan Kiszka <jan.kiszka@domain.hid>, adeos-main@gna.org

Wolfgang Mauerer wrote:
> diff --git a/arch/x86/kernel/vsyscall_64.c b/arch/x86/kernel/vsyscall_64.c
> index 8cb4974..f1b90f7 100644
> --- a/arch/x86/kernel/vsyscall_64.c
> +++ b/arch/x86/kernel/vsyscall_64.c
> @@ -32,6 +32,7 @@
>  #include <linux/cpu.h>
>  #include <linux/smp.h>
>  #include <linux/notifier.h>
> +#include <linux/ipipe_tickdev.h>
>  
>  #include <asm/vsyscall.h>
>  #include <asm/pgtable.h>
> @@ -89,6 +90,11 @@ void update_vsyscall(struct timespec *wall_time, struct clocksource *clock)
>  	vsyscall_gtod_data.wall_to_monotonic = wall_to_monotonic;
>  	vsyscall_gtod_data.wall_time_coarse = __current_kernel_time();
>  	write_sequnlock_irqrestore(&vsyscall_gtod_data.lock, flags);
> +
> +#ifdef CONFIG_IPIPE_HOSTRT
> +	if (clock == &clocksource_tsc)
> +		update_ipipe_hostrt(wall_time, clock);
> +#endif

The idea was to use ipipe_dispatch_event here, and implement the event
handler in Xenomai. I wonder, however, if we should not do this at the
call sites ov update_vsyscall, or wrap update_vsyscall, so that we can
modify only architecture-independent code.

-- 
					    Gilles.

