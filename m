Subject: Re: [PATCH v2 2/2] cobalt/trace: dovetail: remove TODO and return
 -ENOSYS for unportable features
References: <20211129010357.20263-1-hongzhan.chen@intel.com>
 <20211129010357.20263-2-hongzhan.chen@intel.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <b5228039-7729-0921-ea49-ab00a1b12dc8@siemens.com>
Date: Mon, 29 Nov 2021 08:58:17 +0100
MIME-Version: 1.0
In-Reply-To: <20211129010357.20263-2-hongzhan.chen@intel.com>
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
To: Hongzhan Chen <hongzhan.chen@intel.com>, xenomai@xenomai.org

On 29.11.21 02:03, Hongzhan Chen via Xenomai wrote:
> Some of the features are unportable because ftrace does not
> provide equivalent functionality to the ipipe tracer (namely double
> buffering so that you can continue to record in flight-recorder mode
> while a previous recording remains available).
> 
> We remove TODOs to pass allyesconfig make.
> 
> Signed-off-by: Hongzhan Chen <hongzhan.chen@intel.com>
> ---
>  include/cobalt/kernel/dovetail/pipeline/trace.h | 15 +++++----------
>  1 file changed, 5 insertions(+), 10 deletions(-)
> 
> diff --git a/include/cobalt/kernel/dovetail/pipeline/trace.h b/include/cobalt/kernel/dovetail/pipeline/trace.h
> index 479191e0e..c7df3be79 100644
> --- a/include/cobalt/kernel/dovetail/pipeline/trace.h
> +++ b/include/cobalt/kernel/dovetail/pipeline/trace.h
> @@ -27,20 +27,17 @@
>  
>  static inline int xntrace_max_begin(unsigned long v)
>  {
> -	TODO();
> -	return 0;
> +	return -ENOSYS;
>  }
>  
>  static inline int xntrace_max_end(unsigned long v)
>  {
> -	TODO();
> -	return 0;
> +	return -ENOSYS;
>  }
>  
>  static inline int xntrace_max_reset(void)
>  {
> -	TODO();
> -	return 0;
> +	return -ENOSYS;
>  }
>  
>  static inline int xntrace_user_start(void)
> @@ -96,14 +93,12 @@ static inline int xntrace_tick(unsigned long delay_ticks) /* ns */
>  
>  static inline int xntrace_panic_freeze(void)
>  {
> -	TODO();
> -	return 0;
> +	return -ENOSYS;
>  }
>  
>  static inline int xntrace_panic_dump(void)
>  {
> -	TODO();
> -	return 0;
> +	return -ENOSYS;
>  }
>  

Looking at these two panic "abstractions": They are only called by
dovetail-specific handle_oob_trap_entry. There, we should rather use
kernel native tracing functions to stop and dump a trace.

And for I-pipe, we can fold the two abstractions into handle_exception()
there as well.

Jan

-- 
Siemens AG, T RDA IOT
Corporate Competence Center Embedded Linux

