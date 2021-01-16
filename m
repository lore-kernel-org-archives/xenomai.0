References: <20210115011639.15390-1-hongzhan.chen@intel.com>
 <20210115011639.15390-9-hongzhan.chen@intel.com>
From: Philippe Gerum <rpm@xenomai.org>
Subject: Re: [PATCH 8/8] dovetail/kevents: enable back tracing
In-reply-to: <20210115011639.15390-9-hongzhan.chen@intel.com>
Date: Sat, 16 Jan 2021 16:17:42 +0100
Message-ID: <877docsyg9.fsf@xenomai.org>
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

> enable back tracing for handle_oob_trap_entry
>
> Signed-off-by: hongzha1 <hongzhan.chen@intel.com>
>
> diff --git a/kernel/cobalt/dovetail/kevents.c b/kernel/cobalt/dovetail/kevents.c
> index 378017bea..51946e21c 100644
> --- a/kernel/cobalt/dovetail/kevents.c
> +++ b/kernel/cobalt/dovetail/kevents.c
> @@ -97,10 +97,8 @@ void handle_oob_trap_entry(unsigned int trapnr, struct pt_regs *regs)
>  
>  	/*
>  	 * Enable back tracing.
> -	 *
> -	 * trace_cobalt_thread_fault(xnarch_fault_pc(regs), trapnr);
>  	 */
> -	TODO();
> +	trace_cobalt_thread_fault(xnarch_fault_pc(regs), trapnr);
>  
>  	if (xnthread_test_state(thread, XNROOT))
>  		return;

Merged, thanks.

-- 
Philippe.

