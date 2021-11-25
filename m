Subject: Re: [PATCH 1/2] cobalt/trace: dovetail: improve xntrace_user_stop to
 replace TODO
References: <20211124014058.12195-1-hongzhan.chen@intel.com>
 <20211124014058.12195-2-hongzhan.chen@intel.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <72ea04cc-7b15-9dc1-f657-32e434819e18@siemens.com>
Date: Thu, 25 Nov 2021 11:03:31 +0100
MIME-Version: 1.0
In-Reply-To: <20211124014058.12195-2-hongzhan.chen@intel.com>
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

On 24.11.21 02:40, Hongzhan Chen via Xenomai wrote:
> xntrace_user_stop is widely similar to xntrace_user_freeze, call
> trace_cobalt_trigger to improve it.
> 
> Signed-off-by: Hongzhan Chen <hongzhan.chen@intel.com>
> ---
>  include/cobalt/kernel/dovetail/pipeline/trace.h | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/include/cobalt/kernel/dovetail/pipeline/trace.h b/include/cobalt/kernel/dovetail/pipeline/trace.h
> index 513d9b48b..68b5fdb23 100644
> --- a/include/cobalt/kernel/dovetail/pipeline/trace.h
> +++ b/include/cobalt/kernel/dovetail/pipeline/trace.h
> @@ -51,7 +51,8 @@ static inline int xntrace_user_start(void)
>  
>  static inline int xntrace_user_stop(unsigned long v)
>  {
> -	TODO();
> +	trace_cobalt_trace_longval(0, v);
> +	trace_cobalt_trigger("user-stop");
>  	return 0;
>  }
>  
> 

Let's also make xntrace_user_start visible -
trace_cobalt_trigger("user-start") - and let it return 0 so that
user_stop is not "unbalanced".

Rest looks good.

Jan

-- 
Siemens AG, T RDA IOT
Corporate Competence Center Embedded Linux

