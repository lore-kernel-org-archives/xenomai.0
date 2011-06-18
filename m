Message-ID: <4DFCBEFB.7020407@domain.hid>
Date: Sat, 18 Jun 2011 17:06:35 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <E1QXw2L-0000ts-JP@xenomai.org>
In-Reply-To: <E1QXw2L-0000ts-JP@xenomai.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] [Xenomai-git] Jan Kiszka : nucleus: Fix
 xnpod_schedule shadow return path for HW_UNLOCKED_SWITCH
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Xenomai core <Xenomai-core@domain.hid>

On 06/18/2011 03:58 PM, GIT version control wrote:
> Module: xenomai-jki
> Branch: for-upstream
> Commit: 97de95fdb166d731081f08e157674742f24a243b
> URL:    http://git.xenomai.org/?p=xenomai-jki.git;a=commit;h=97de95fdb166d731081f08e157674742f24a243b
> 
> Author: Jan Kiszka <jan.kiszka@domain.hid>
> Date:   Sat Jun 18 15:24:22 2011 +0200
> 
> nucleus: Fix xnpod_schedule shadow return path for HW_UNLOCKED_SWITCH
> 
> Since f6af9b831c, the xnpod_schedule of an interrupt handler may also
> perform a domain migration. For that case, we must disable interrupts
> again before returning to a migrated shadow context as the interrupt
> handler tail depends on that. This only affects HW_UNLOCKED_SWITCH
> archs.
> 
> Signed-off-by: Jan Kiszka <jan.kiszka@domain.hid>
> 
> ---
> 
>  ksrc/nucleus/pod.c |   12 +++++++-----
>  1 files changed, 7 insertions(+), 5 deletions(-)
> 
> diff --git a/ksrc/nucleus/pod.c b/ksrc/nucleus/pod.c
> index ec24cb3..f2fa7c8 100644
> --- a/ksrc/nucleus/pod.c
> +++ b/ksrc/nucleus/pod.c
> @@ -1473,8 +1473,7 @@ void xnpod_suspend_thread(xnthread_t *thread, xnflags_t mask,
>  		 * would enter the critical section in xnpod_schedule
>  		 * while the current Adeos domain is Linux, which
>  		 * would defeat the purpose of having called
> -		 * xnarch_escalate(). xnpod_schedule() is expected to
> -		 * return with interrupts on.
> +		 * xnarch_escalate().
>  		 */
>  		if (mask & XNRELAX) {
>  			xnlock_clear_irqon(&nklock);
> @@ -2345,9 +2344,12 @@ reschedule:
>  			xnshadow_exit();
>  		}
>  
> -		/* We are returning to xnshadow_relax via
> -		   xnpod_suspend_thread, do nothing,
> -		   xnpod_suspend_thread will re-enable interrupts. */
> +#ifdef CONFIG_XENO_HW_UNLOCKED_SWITCH
> +		/* Callers, specifically the reschedule of an IRQ handler that
> +		   hit before we called xnpod_schedule xnpod_suspend_thread,
> +		   expect us to return with interrupts disabled. */
> +		splmax();
> +#endif

What about using splexit(s) here instead?

-- 
                                                                Gilles.

