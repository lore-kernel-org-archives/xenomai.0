References: <20210111064318.6154-1-hongzhan.chen@intel.com>
 <20210111064318.6154-2-hongzhan.chen@intel.com>
From: Philippe Gerum <rpm@xenomai.org>
Subject: Re: [PATCH 02/10] dovetail/clock: implement
 pipeline_read_cycle_counter
In-reply-to: <20210111064318.6154-2-hongzhan.chen@intel.com>
Date: Mon, 11 Jan 2021 18:26:27 +0100
Message-ID: <877dojjsfw.fsf@xenomai.org>
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
>  include/cobalt/kernel/dovetail/pipeline/clock.h | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
>
> diff --git a/include/cobalt/kernel/dovetail/pipeline/clock.h b/include/cobalt/kernel/dovetail/pipeline/clock.h
> index 19e3d8986..5176b1506 100644
> --- a/include/cobalt/kernel/dovetail/pipeline/clock.h
> +++ b/include/cobalt/kernel/dovetail/pipeline/clock.h
> @@ -13,9 +13,7 @@ struct timespec64;
>  static inline u64 pipeline_read_cycle_counter(void)
>  {
>  	/* Read the raw cycle counter of the core clock. */
> -	TODO();
> -
> -	return 0;
> +	return  ktime_get_raw_fast_ns();
>  }
>  
>  static inline void pipeline_set_timer_shot(unsigned long cycles)

Ack, picking up this patch. Thanks.

NOTE: this can only work because Dovetail requires us to align on the
in-band kernel's idea of time, i.e. nanosecs. In that case, one Cobalt
"TSC" tick equals one nanosecond.

-- 
Philippe.

