Subject: Re: [PATCH 1/2] cobalt: Add _CC_COBALT_DEBUG_SYNC_BP feature
References: <8271e30f-9fcf-b366-8154-922f988bf366@siemens.com>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <4e3d6cce-4a42-b9a2-d3b4-ee5398fab0d4@xenomai.org>
Date: Sun, 6 Oct 2019 19:53:17 +0200
MIME-Version: 1.0
In-Reply-To: <8271e30f-9fcf-b366-8154-922f988bf366@siemens.com>
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
To: Jan Kiszka <jan.kiszka@siemens.com>, Xenomai <xenomai@xenomai.org>

On 10/4/19 3:47 PM, Jan Kiszka via Xenomai wrote:
> From: Jan Kiszka <jan.kiszka@siemens.com>
> 
> This signals if the core supports synchronous stop and resume on
> breakpoints. It depends on I-pipe support that is not available for all
> architectures and I-pipe kernel version.
> 
> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
> ---
>  include/cobalt/uapi/corectl.h | 1 +
>  kernel/cobalt/posix/corectl.c | 3 +++
>  2 files changed, 4 insertions(+)
> 
> diff --git a/include/cobalt/uapi/corectl.h b/include/cobalt/uapi/corectl.h
> index 98d989d635..8927c4fb07 100644
> --- a/include/cobalt/uapi/corectl.h
> +++ b/include/cobalt/uapi/corectl.h
> @@ -33,6 +33,7 @@
>  #   define _CC_COBALT_DEBUG_LEGACY		128
>  #   define _CC_COBALT_DEBUG_TRACE_RELAX		256
>  #   define _CC_COBALT_DEBUG_NET			512
> +#   define _CC_COBALT_DEBUG_SYNC_BP		1024
>  
>  #define _CC_COBALT_GET_POLICIES		4
>  #   define _CC_COBALT_SCHED_FIFO	1
> diff --git a/kernel/cobalt/posix/corectl.c b/kernel/cobalt/posix/corectl.c
> index f7129ca64b..1b0d912008 100644
> --- a/kernel/cobalt/posix/corectl.c
> +++ b/kernel/cobalt/posix/corectl.c
> @@ -79,6 +79,9 @@ static int do_conf_option(int option, void __user *u_buf, size_t u_bufsz)
>  			val |= _CC_COBALT_DEBUG_TRACE_RELAX;
>  		if (IS_ENABLED(CONFIG_XENO_DRIVERS_RTNET_CHECKED))
>  			val |= _CC_COBALT_DEBUG_NET;
> +#ifdef IPIPE_KEVT_USERINTRET
> +		val |= _CC_COBALT_DEBUG_SYNC_BP;
> +#endif
>  		break;
>  	case _CC_COBALT_GET_WATCHDOG:
>  #ifdef CONFIG_XENO_OPT_WATCHDOG
> 

Ack.

-- 
Philippe.

