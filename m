References: <20210111064318.6154-1-hongzhan.chen@intel.com>
 <20210111064318.6154-5-hongzhan.chen@intel.com>
From: Philippe Gerum <rpm@xenomai.org>
Subject: Re: [PATCH 05/10] dovetail/init: implement Xenomai stage enabling
 and disabling
In-reply-to: <20210111064318.6154-5-hongzhan.chen@intel.com>
Date: Mon, 11 Jan 2021 18:31:16 +0100
Message-ID: <87y2gzidnf.fsf@xenomai.org>
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
>  kernel/cobalt/dovetail/init.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/kernel/cobalt/dovetail/init.c b/kernel/cobalt/dovetail/init.c
> index 983186abe..bc891b4c1 100644
> --- a/kernel/cobalt/dovetail/init.c
> +++ b/kernel/cobalt/dovetail/init.c
> @@ -20,7 +20,7 @@ int __init pipeline_init(void)
>  	}
>  
>  	/* Enable the Xenomai out-of-band stage */
> -	TODO();
> +	enable_oob_stage("Xenomai");
>  
>  	ret = xnclock_init();
>  	if (ret)
> @@ -46,7 +46,7 @@ int __init pipeline_late_init(void)
>  __init void pipeline_cleanup(void)
>  {
>  	/* Disable the Xenomai stage */
> -	TODO();
> +	disable_oob_stage();
>  
>  	xnclock_cleanup();
>  }

Works for me, queuing for upstream merge via my tree.

Thanks,

-- 
Philippe.

