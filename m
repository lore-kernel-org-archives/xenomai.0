References: <20210309044520.28816-1-hongzhan.chen@intel.com>
From: Philippe Gerum <rpm@xenomai.org>
Subject: Re: [PATCH] cobalt/sched: dovetail: fix missed switching to OOB
 opportunities
In-reply-to: <20210309044520.28816-1-hongzhan.chen@intel.com>
Date: Wed, 10 Mar 2021 17:51:37 +0100
Message-ID: <874khjhrza.fsf@xenomai.org>
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

> Ask for switching back to oob mode once ptrace core tell that
> current is resuming from a stopped state, leaving space for
> other runnable RT threads of the process to take over.
>
> Signed-off-by: hongzha1 <hongzhan.chen@intel.com>
>
> diff --git a/kernel/cobalt/dovetail/kevents.c b/kernel/cobalt/dovetail/kevents.c
> index 966a63ce0..a640c4d9e 100644
> --- a/kernel/cobalt/dovetail/kevents.c
> +++ b/kernel/cobalt/dovetail/kevents.c
> @@ -492,6 +492,8 @@ static void handle_ptrace_cont(void)
>  			unregister_debugged_thread(curr);
>  
>  		xnthread_set_localinfo(curr, XNHICCUP);
> +
> +		dovetail_request_ucall(current);
>  	}
>  
>  	xnlock_put_irqrestore(&nklock, s);
> diff --git a/kernel/cobalt/dovetail/sched.c b/kernel/cobalt/dovetail/sched.c
> index de7c43b70..2bdddfeef 100644
> --- a/kernel/cobalt/dovetail/sched.c
> +++ b/kernel/cobalt/dovetail/sched.c
> @@ -56,9 +56,21 @@ int pipeline_leave_inband(void)
>  
>  int pipeline_leave_oob_prepare(void)
>  {
> -	dovetail_leave_oob();
> +	int suspmask = XNRELAX;
> +	struct xnthread *curr = xnthread_current();
>  
> -	return XNRELAX;
> +	dovetail_leave_oob();
> +	/*
> +	 * If current is being debugged, record that it should migrate
> +	 * back in case it resumes in userspace. If it resumes in
> +	 * kernel space, i.e.  over a restarting syscall, the
> +	 * associated hardening will clear XNCONTHI.
> +	 */
> +	if (xnthread_test_state(curr, XNSSTEP)) {
> +		xnthread_set_info(curr, XNCONTHI);
> +		suspmask |= XNDBGSTOP;
> +	}
> +	return suspmask;
>  }
>  
>  void pipeline_leave_oob_finish(void)

Merged, thanks.

-- 
Philippe.

