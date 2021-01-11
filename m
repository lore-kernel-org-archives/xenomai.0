References: <20210111064318.6154-1-hongzhan.chen@intel.com>
 <20210111064318.6154-3-hongzhan.chen@intel.com>
From: Philippe Gerum <rpm@xenomai.org>
Subject: Re: [PATCH 03/10] dovetail/clock: implement pipeline_get_host_time
In-reply-to: <20210111064318.6154-3-hongzhan.chen@intel.com>
Date: Mon, 11 Jan 2021 18:26:57 +0100
Message-ID: <874kjnjsf2.fsf@xenomai.org>
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
>  include/cobalt/kernel/dovetail/pipeline/clock.h | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/include/cobalt/kernel/dovetail/pipeline/clock.h b/include/cobalt/kernel/dovetail/pipeline/clock.h
> index 5176b1506..28d89b44b 100644
> --- a/include/cobalt/kernel/dovetail/pipeline/clock.h
> +++ b/include/cobalt/kernel/dovetail/pipeline/clock.h
> @@ -7,6 +7,7 @@
>  
>  #include <cobalt/uapi/kernel/types.h>
>  #include <cobalt/kernel/assert.h>
> +#include <linux/ktime.h>
>  
>  struct timespec64;
>  
> @@ -50,7 +51,7 @@ static inline const char *pipeline_clock_name(void)
>  static inline int pipeline_get_host_time(struct timespec64 *tp)
>  {
>  	/* Convert ktime_get_real_fast_ns() to timespec. */
> -	TODO();
> +	*tp = ktime_to_timespec64(ktime_get_real_fast_ns());
>  
>  	return 0;
>  }

Yummie. Ack, picking up this patch. Thanks.

-- 
Philippe.

