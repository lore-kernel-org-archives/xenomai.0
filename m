References: <20210111064318.6154-1-hongzhan.chen@intel.com>
 <20210111064318.6154-9-hongzhan.chen@intel.com>
From: Philippe Gerum <rpm@xenomai.org>
Subject: Re: [PATCH 09/10] dovetail/clock: implement pipeline_timer_name to
 get name of real device
In-reply-to: <20210111064318.6154-9-hongzhan.chen@intel.com>
Date: Tue, 12 Jan 2021 17:52:42 +0100
Message-ID: <87turmksh1.fsf@xenomai.org>
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


hongzha1 via Xenomai <xenomai@xenomai.org> writes:

> Signed-off-by: hongzha1 <hongzhan.chen@intel.com>
> ---
>  include/cobalt/kernel/dovetail/pipeline/clock.h | 5 ++---
>  kernel/cobalt/dovetail/tick.c                   | 8 ++++++++
>  2 files changed, 10 insertions(+), 3 deletions(-)
>
> diff --git a/include/cobalt/kernel/dovetail/pipeline/clock.h b/include/cobalt/kernel/dovetail/pipeline/clock.h
> index ce9a5c867..771104ab4 100644
> --- a/include/cobalt/kernel/dovetail/pipeline/clock.h
> +++ b/include/cobalt/kernel/dovetail/pipeline/clock.h
> @@ -12,6 +12,7 @@
>  struct timespec64;
>  
>  extern inline void xnproxy_timer_set(unsigned long delta);
> +inline const char *xn_get_timer_name(void);
>
>  static inline u64 pipeline_read_cycle_counter(void)
>  {
> @@ -37,9 +38,7 @@ static inline const char *pipeline_timer_name(void)
>  	 * Return the name of the current clock event chip, which is
>  	 * the real device controlled by the proxy tick device.
>  	 */
> -	TODO();
> -
> -	return "?";
> +	return xn_get_timer_name();
>  }
>  
>  static inline const char *pipeline_clock_name(void)
> diff --git a/kernel/cobalt/dovetail/tick.c b/kernel/cobalt/dovetail/tick.c
> index 58662e94e..e40ec06cb 100644
> --- a/kernel/cobalt/dovetail/tick.c
> +++ b/kernel/cobalt/dovetail/tick.c
> @@ -16,6 +16,14 @@ extern struct xnintr nktimer;
>  
>  static DEFINE_PER_CPU(struct clock_proxy_device *, proxy_device);
>  
> +inline const char *xn_get_timer_name(void)
> +{
> +	struct clock_proxy_device *dev = __this_cpu_read(proxy_device);
> +	struct clock_event_device *real_dev = dev->real_device;
> +
> +	return real_dev->name;
> +}
> +

Please rename xn_get_timer_name() directly to pipeline_timer_name(),
which should be out of line, so that we don't have to expose the
proxy_device variable. This stuff is rarely called, and definitely not
on the hot path.

-- 
Philippe.

