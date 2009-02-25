Message-ID: <49A59038.9030600@domain.hid>
Date: Wed, 25 Feb 2009 19:38:48 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <49A58E4F.6060907@domain.hid>
In-Reply-To: <49A58E4F.6060907@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] [PATCH] lttng: Trace syscall exits
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
Cc: xenomai-core <xenomai@xenomai.org>

Jan Kiszka wrote:
> Add proper marks for the end of Xenomai's syscall handling, just like
> LTTng provides for Linux syscall. That is helpful to keep the overview
> of current context and the time spent there. And it allows to track the
> return code.
> 
> Signed-off-by: Jan Kiszka <jan.kiszka@domain.hid>
> ---
> 
>  0 files changed, 0 insertions(+), 0 deletions(-)

What a marvelous patch: improvement without changes...

 ksrc/nucleus/shadow.c |   17 ++++++++++++-----
 1 files changed, 12 insertions(+), 5 deletions(-)

(stgit bug: don't call "stg mail" while in an untracked directory)

> 
> diff --git a/ksrc/nucleus/shadow.c b/ksrc/nucleus/shadow.c
> index e2f2968..b9303b2 100644
> --- a/ksrc/nucleus/shadow.c
> +++ b/ksrc/nucleus/shadow.c
> @@ -1924,7 +1924,7 @@ static inline int do_hisyscall_event(unsigned event, unsigned domid, void *data)
>  	muxid = __xn_mux_id(regs);
>  	muxop = __xn_mux_op(regs);
>  
> -	trace_mark(xn_nucleus, syscall_histage,
> +	trace_mark(xn_nucleus, syscall_histage_entry,
>  		   "thread %p thread_name %s muxid %d muxop %d",
>  		   thread, thread ? xnthread_name(thread) : NULL,
>  		   muxid, muxop);
> @@ -1932,14 +1932,14 @@ static inline int do_hisyscall_event(unsigned event, unsigned domid, void *data)
>  	if (muxid < 0 || muxid > XENOMAI_MUX_NR ||
>  	    muxop < 0 || muxop >= muxtable[muxid].props->nrcalls) {
>  		__xn_error_return(regs, -ENOSYS);
> -		return RTHAL_EVENT_STOP;
> +		goto ret_handled;
>  	}
>  
>  	sysflags = muxtable[muxid].props->systab[muxop].flags;
>  
>  	if ((sysflags & __xn_exec_shadow) != 0 && !thread) {
>  		__xn_error_return(regs, -EPERM);
> -		return RTHAL_EVENT_STOP;
> +		goto ret_handled;
>  	}
>  
>  	if ((sysflags & __xn_exec_conforming) != 0)
> @@ -2018,6 +2018,10 @@ static inline int do_hisyscall_event(unsigned event, unsigned domid, void *data)
>  	else if ((sysflags & __xn_exec_switchback) != 0 && switched)
>  		xnshadow_harden();	/* -EPERM will be trapped later if needed. */
>  
> +      ret_handled:
> +
> +	trace_mark(xn_nucleus, syscall_histage_exit,
> +		   "ret %ld", __xn_reg_rval(regs));
>  	return RTHAL_EVENT_STOP;
>  
>        linux_syscall:
> @@ -2115,7 +2119,7 @@ static inline int do_losyscall_event(unsigned event, unsigned domid, void *data)
>  	muxid = __xn_mux_id(regs);
>  	muxop = __xn_mux_op(regs);
>  
> -	trace_mark(xn_nucleus, syscall_lostage,
> +	trace_mark(xn_nucleus, syscall_lostage_entry,
>  		   "thread %p thread_name %s muxid %d muxop %d",
>  		   xnpod_active_p() ? xnpod_current_thread() : NULL,
>  		   xnpod_active_p() ? xnthread_name(xnpod_current_thread()) : NULL,
> @@ -2137,7 +2141,7 @@ static inline int do_losyscall_event(unsigned event, unsigned domid, void *data)
>  		   syscall. */
>  		if ((err = xnshadow_harden()) != 0) {
>  			__xn_error_return(regs, err);
> -			return RTHAL_EVENT_STOP;
> +			goto ret_handled;
>  		}
>  
>  		switched = 1;
> @@ -2165,6 +2169,9 @@ static inline int do_losyscall_event(unsigned event, unsigned domid, void *data)
>  	else if ((sysflags & __xn_exec_switchback) != 0 && switched)
>  		xnshadow_relax(0);
>  
> +      ret_handled:
> +	trace_mark(xn_nucleus, syscall_lostage_exit,
> +		   "ret %ld", __xn_reg_rval(regs));
>  	return RTHAL_EVENT_STOP;
>  }

-- 
Siemens AG, Corporate Technology, CT SE 2
Corporate Competence Center Embedded Linux

