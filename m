References: <20210111064318.6154-1-hongzhan.chen@intel.com>
 <20210111064318.6154-4-hongzhan.chen@intel.com>
From: Philippe Gerum <rpm@xenomai.org>
Subject: Re: [PATCH 04/10] dovetail/sched: implement
 pipeline_init_shadow_tcb and pipeline_init_root_tcb
In-reply-to: <20210111064318.6154-4-hongzhan.chen@intel.com>
Date: Mon, 11 Jan 2021 18:30:17 +0100
Message-ID: <871rerjs9i.fsf@xenomai.org>
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
>  kernel/cobalt/dovetail/sched.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/kernel/cobalt/dovetail/sched.c b/kernel/cobalt/dovetail/sched.c
> index 71f763d39..82e29136c 100644
> --- a/kernel/cobalt/dovetail/sched.c
> +++ b/kernel/cobalt/dovetail/sched.c
> @@ -36,7 +36,7 @@ void pipeline_init_shadow_tcb(struct xnthread *thread)
>  	/*
>  	 * Initialize the alternate scheduling control block.
>  	 */
> -	TODO();
> +	dovetail_init_altsched(&xnthread_archtcb(thread)->altsched);
>  
>  	trace_cobalt_shadow_map(thread);
>  }
> @@ -46,7 +46,7 @@ void pipeline_init_root_tcb(struct xnthread *thread)
>  	/*
>  	 * Initialize the alternate scheduling control block.
>  	 */
> -	TODO();
> +	dovetail_init_altsched(&xnthread_archtcb(thread)->altsched);
>  }
>  
>  int pipeline_leave_inband(void)

Looks good, picking up this one too.

Thanks.

-- 
Philippe.

