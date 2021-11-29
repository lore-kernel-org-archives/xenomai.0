Subject: Re: [PATCH v2 1/2] cobalt/trace: dovetail: improve xntrace_user_stop
 and xntrace_user_start
References: <20211129010357.20263-1-hongzhan.chen@intel.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <55a16ac3-a5a3-b8dd-b37a-3b0367199835@siemens.com>
Date: Mon, 29 Nov 2021 08:55:58 +0100
MIME-Version: 1.0
In-Reply-To: <20211129010357.20263-1-hongzhan.chen@intel.com>
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
> xntrace_user_stop is widely similar to xntrace_user_freeze, call
> trace_cobalt_trigger to improve it and also make xntrace_user_start visible
> to balance them.
> 
> Signed-off-by: Hongzhan Chen <hongzhan.chen@intel.com>
> ---
>  include/cobalt/kernel/dovetail/pipeline/trace.h | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/include/cobalt/kernel/dovetail/pipeline/trace.h b/include/cobalt/kernel/dovetail/pipeline/trace.h
> index 513d9b48b..479191e0e 100644
> --- a/include/cobalt/kernel/dovetail/pipeline/trace.h
> +++ b/include/cobalt/kernel/dovetail/pipeline/trace.h
> @@ -45,13 +45,14 @@ static inline int xntrace_max_reset(void)
>  
>  static inline int xntrace_user_start(void)
>  {
> -	TODO();
> +	trace_cobalt_trigger("user-start");
>  	return 0;
>  }
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

Thanks, applied.

Jan

-- 
Siemens AG, T RDA IOT
Corporate Competence Center Embedded Linux

