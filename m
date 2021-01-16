References: <20210115011639.15390-1-hongzhan.chen@intel.com>
 <20210115011639.15390-3-hongzhan.chen@intel.com>
From: Philippe Gerum <rpm@xenomai.org>
Subject: Re: [PATCH 3/8] dovetail/clock: implement pipeline_set_timer_shot
 to trigger tick shot
In-reply-to: <20210115011639.15390-3-hongzhan.chen@intel.com>
Date: Sat, 16 Jan 2021 12:56:08 +0100
Message-ID: <87zh19rt7r.fsf@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: hongzha1 <hongzhan.chen@intel.com>
Cc: xenomai@xenomai.org


The shortlog should mention the subsystem and the pipeline variant to
allow for a quick comprehension of the scope; that would be
"cobalt/tick: dovetail: ..." in this case.

hongzha1 via Xenomai <xenomai@xenomai.org> writes:

> Signed-off-by: hongzha1 <hongzhan.chen@intel.com>
>
> diff --git a/include/cobalt/kernel/dovetail/pipeline/clock.h b/include/cobalt/kernel/dovetail/pipeline/clock.h
> index 28d89b44b..db982d969 100644
> --- a/include/cobalt/kernel/dovetail/pipeline/clock.h
> +++ b/include/cobalt/kernel/dovetail/pipeline/clock.h
> @@ -17,17 +17,7 @@ static inline u64 pipeline_read_cycle_counter(void)
>  	return  ktime_get_raw_fast_ns();
>  }
>  
> -static inline void pipeline_set_timer_shot(unsigned long cycles)
> -{
> -	/*
> -	 * N/A. Revisit: xnclock_core_local_shot() should go to the
> -	 * I-pipe section, we do things differently on Dovetail via
> -	 * the proxy tick device. As a consequence,
> -	 * pipeline_set_timer_shot() should not be part of the
> -	 * pipeline interface.
> -	 */
> -	TODO();
> -}
> +inline void pipeline_set_timer_shot(unsigned long cycles);
>  
>  static inline const char *pipeline_timer_name(void)
>  {
> diff --git a/kernel/cobalt/dovetail/tick.c b/kernel/cobalt/dovetail/tick.c
> index 6a196496c..55039f96e 100644
> --- a/kernel/cobalt/dovetail/tick.c
> +++ b/kernel/cobalt/dovetail/tick.c
> @@ -16,6 +16,43 @@ extern struct xnintr nktimer;
>  
>  static DEFINE_PER_CPU(struct clock_proxy_device *, proxy_device);
>  
> +inline void pipeline_set_timer_shot(unsigned long cycles)
> +{
> +	/*
> +	 * N/A. Revisit: xnclock_core_local_shot() should go to the
> +	 * I-pipe section, we do things differently on Dovetail via
> +	 * the proxy tick device. As a consequence,
> +	 * pipeline_set_timer_shot() should not be part of the
> +	 * pipeline interface.
> +	 */
> +	struct clock_proxy_device *dev = __this_cpu_read(proxy_device);
> +	struct clock_event_device *real_dev = dev->real_device;
> +	int ret;
> +	u64 sumcyc;
> +	ktime_t t;
> +
> +	if (real_dev->features & CLOCK_EVT_FEAT_KTIME) {
> +		t = ktime_add(cycles, xnclock_core_read_raw());
> +		real_dev->set_next_ktime(t, real_dev);
> +	} else {
> +		if (cycles <= 0)
> +			cycles = real_dev->min_delta_ns;
> +		else {
> +			cycles = min_t(int64_t, cycles,
> +					real_dev->max_delta_ns);
> +			cycles = max_t(int64_t, cycles,
> +					real_dev->min_delta_ns);
> +		}
> +		sumcyc = ((u64)cycles * real_dev->mult) >> real_dev->shift;
> +
> +		ret = real_dev->set_next_event(sumcyc, real_dev);
> +		if (ret) {
> +			ret = real_dev->set_next_event(real_dev->min_delta_ticks,
> +							real_dev);
> +		}
> +	}
> +}
> +
>  static int proxy_set_next_ktime(ktime_t expires,
>  				struct clock_event_device *proxy_dev)
>  {

This patch does not apply cleanly, raising a conflict in
dovetail/pipeline/clock.h. Besides, as discussed recently, the comment
mentioning the need to revisit the code may not be accurate anymore. You
may want to drop it as part of the fix up.

-- 
Philippe.

