From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <1278071401-13880-3-git-send-email-wolfgang.mauerer@domain.hid>
References: <1278071401-13880-1-git-send-email-wolfgang.mauerer@domain.hid>
	<1278071401-13880-3-git-send-email-wolfgang.mauerer@domain.hid>
Content-Type: text/plain; charset="UTF-8"
Date: Wed, 25 Aug 2010 10:52:29 +0200
Message-ID: <1282726349.1709.21.camel@domain.hid>
Mime-Version: 1.0
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

On Fri, 2010-07-02 at 13:50 +0200, Wolfgang Mauerer wrote:
> x86 specific mechanism to make NTP-corrected time information
> available to non-Linux domains.
> 
> Signed-off-by: Wolfgang Mauerer <wolfgang.mauerer@domain.hid>
> Signed-off-by: Jan Kiszka <jan.kiszka@domain.hid>
> ---
>  arch/x86/Kconfig              |    1 +
>  arch/x86/include/asm/tsc.h    |    1 +
>  arch/x86/kernel/tsc.c         |    4 ++--
>  arch/x86/kernel/vsyscall_64.c |    6 ++++++
>  4 files changed, 10 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> index 89b72a9..4ab6f49 100644
> --- a/arch/x86/Kconfig
> +++ b/arch/x86/Kconfig
> @@ -50,6 +50,7 @@ config X86
>  	select HAVE_KERNEL_BZIP2
>  	select HAVE_KERNEL_LZMA
>  	select HAVE_ARCH_KMEMCHECK
> +	select IPIPE_HOSTRT if IPIPE && GENERIC_CLOCKEVENTS

The selection logic is rather to define HAVE_IPIPE_HOSTRT
unconditionally for x86, so that the noarch section could provide the
required bits. CONFIG_IPIPE_HOSTRT as a mean to deselect the feature for
the architecture seems overkill. As explained earlier, if we have it for
the arch, then we want it in.

GENERIC_CLOCKEVENTS is def_bool y in Kconfig for x86, so we don't really
need to depend on it.

>  
>  config OUTPUT_FORMAT
>  	string
> diff --git a/arch/x86/include/asm/tsc.h b/arch/x86/include/asm/tsc.h
> index c042729..aed7d66 100644
> --- a/arch/x86/include/asm/tsc.h
> +++ b/arch/x86/include/asm/tsc.h
> @@ -14,6 +14,7 @@
>   */
>  typedef unsigned long long cycles_t;
>  
> +extern struct clocksource clocksource_tsc;
>  extern unsigned int cpu_khz;
>  extern unsigned int tsc_khz;
>  
> diff --git a/arch/x86/kernel/tsc.c b/arch/x86/kernel/tsc.c
> index 597683a..5e298a2 100644
> --- a/arch/x86/kernel/tsc.c
> +++ b/arch/x86/kernel/tsc.c
> @@ -699,7 +699,7 @@ core_initcall(cpufreq_tsc);
>  
>  /* clocksource code */
>  
> -static struct clocksource clocksource_tsc;
> +struct clocksource clocksource_tsc;
>  
>  /*
>   * We compare the TSC to the cycle_last value in the clocksource
> @@ -745,7 +745,7 @@ static void resume_tsc(void)
>  	clocksource_tsc.cycle_last = 0;
>  }
>  
> -static struct clocksource clocksource_tsc = {
> +struct clocksource clocksource_tsc = {
>  	.name                   = "tsc",
>  	.rating                 = 300,
>  	.read                   = read_tsc,
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
>  }

It would be nice to move the test on clock to ipipe_update_hostrt() in
order to hide all nitty-gritty details from mainline. Making the code
unconditionally compiled in removes the need to #ifdefery.

>  
>  /* RED-PEN may want to readd seq locking, but then the variable should be

-- 
Philippe.



