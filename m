Subject: Re: [PATCH 06/13] cobalt/clock: drop timer calibration
References: <20210131144540.243363-1-rpm@xenomai.org>
 <20210131144540.243363-6-rpm@xenomai.org>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <dc0e32e6-b7f8-85c9-7c15-7bd9b10e6c6a@siemens.com>
Date: Mon, 1 Feb 2021 19:14:17 +0100
MIME-Version: 1.0
In-Reply-To: <20210131144540.243363-6-rpm@xenomai.org>
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
To: Philippe Gerum <rpm@xenomai.org>, xenomai@xenomai.org

On 31.01.21 15:45, Philippe Gerum wrote:
> From: Philippe Gerum <rpm@xenomai.org>
> 
> The calibrated timer setup time is currently accounted for in the
> timer gravity triplet (.user, also used as default .irq latency),
> exclusively. This forces in a dynamically calculated parameter with no
> way to override it. Meanwhile, this value would be already included in
> every gravity value which autotune may determine, so this setting is
> pretty much redundant.
> 
> Drop nktimerlat and the requirement for the machine section to provide
> a timer calibration handler, we don't need these.
> 

Do you recall the history of this features? Was it first, and then
autotune came along, silently obsoleting it?

Jan

> Signed-off-by: Philippe Gerum <rpm@xenomai.org>
> ---
>  include/cobalt/kernel/clock.h                  | 2 --
>  include/cobalt/kernel/ipipe/pipeline/machine.h | 6 ------
>  kernel/cobalt/clock.c                          | 7 -------
>  3 files changed, 15 deletions(-)
> 
> diff --git a/include/cobalt/kernel/clock.h b/include/cobalt/kernel/clock.h
> index 59835951c..bbf34c53c 100644
> --- a/include/cobalt/kernel/clock.h
> +++ b/include/cobalt/kernel/clock.h
> @@ -104,8 +104,6 @@ struct xnclock_ratelimit_state {
>  
>  extern struct xnclock nkclock;
>  
> -extern unsigned long nktimerlat;
> -
>  int xnclock_register(struct xnclock *clock,
>  		     const cpumask_t *affinity);
>  
> diff --git a/include/cobalt/kernel/ipipe/pipeline/machine.h b/include/cobalt/kernel/ipipe/pipeline/machine.h
> index 32d5cd2a2..a5a5197e9 100644
> --- a/include/cobalt/kernel/ipipe/pipeline/machine.h
> +++ b/include/cobalt/kernel/ipipe/pipeline/machine.h
> @@ -24,7 +24,6 @@ struct cobalt_machine {
>  	int (*late_init)(void);
>  	void (*cleanup)(void);
>  	void (*prefault)(struct vm_area_struct *vma);
> -	unsigned long (*calibrate)(void);
>  	const char *const *fault_labels;
>  };
>  
> @@ -46,11 +45,6 @@ struct cobalt_pipeline {
>  #endif
>  };
>  
> -static inline unsigned long xnarch_timer_calibrate(void)
> -{
> -	return cobalt_machine.calibrate();
> -}
> -
>  int pipeline_init(void);
>  
>  int pipeline_late_init(void);
> diff --git a/kernel/cobalt/clock.c b/kernel/cobalt/clock.c
> index 7d1e00ea1..bf24e1693 100644
> --- a/kernel/cobalt/clock.c
> +++ b/kernel/cobalt/clock.c
> @@ -32,7 +32,6 @@
>   *
>   * @{
>   */
> -unsigned long nktimerlat;
>  
>  #ifdef XNARCH_HAVE_NODIV_LLIMD
>  
> @@ -456,8 +455,6 @@ void print_core_clock_status(struct xnclock *clock,
>  	xnvfile_printf(it, "%8s: timer=%s, clock=%s\n",
>  		       "devices", pipeline_timer_name(), pipeline_clock_name());
>  	xnvfile_printf(it, "%8s: %s\n", "watchdog", wd_status);
> -	xnvfile_printf(it, "%8s: %Lu\n", "setup",
> -		       xnclock_ticks_to_ns(&nkclock, nktimerlat));
>  }
>  
>  static int clock_show(struct xnvfile_regular_iterator *it, void *data)
> @@ -784,11 +781,8 @@ static void reset_core_clock_gravity(struct xnclock *clock)
>  	struct xnclock_gravity gravity;
>  
>  	xnarch_get_latencies(&gravity);
> -	gravity.user += nktimerlat;
>  	if (gravity.kernel == 0)
>  		gravity.kernel = gravity.user;
> -	if (gravity.irq == 0)
> -		gravity.irq = nktimerlat;
>  	set_core_clock_gravity(clock, &gravity);
>  }
>  
> @@ -817,7 +811,6 @@ int __init xnclock_init()
>  	xnarch_init_u32frac(&bln_frac, 1, 1000000000);
>  #endif
>  	pipeline_init_clock();
> -	nktimerlat = xnarch_timer_calibrate();
>  	xnclock_reset_gravity(&nkclock);
>  	xnclock_register(&nkclock, &xnsched_realtime_cpus);
>  
> 

-- 
Siemens AG, T RDA IOT
Corporate Competence Center Embedded Linux

