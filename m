References: <E1ZG585-0002oE-L7@sd-51317.xenomai.org>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <55A8FF7B.5010605@xenomai.org>
Date: Fri, 17 Jul 2015 15:13:31 +0200
MIME-Version: 1.0
In-Reply-To: <E1ZG585-0002oE-L7@sd-51317.xenomai.org>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] [Xenomai-git] Jan Kiszka : cobalt/kernel: Fix locking
 for xnthread info manipulations
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org, xenomai-git@xenomai.org

On 07/17/2015 02:52 PM, git repository hosting wrote:
> 
> diff --git a/kernel/cobalt/synch.c b/kernel/cobalt/synch.c
> index 7142fd2..ae4ceef 100644
> --- a/kernel/cobalt/synch.c
> +++ b/kernel/cobalt/synch.c
> @@ -443,7 +443,9 @@ redo:
>  	if (likely(h == XN_NO_HANDLE)) {
>  		xnsynch_set_owner(synch, curr);
>  		xnthread_get_resource(curr);
> +		xnlock_get_irqsave(&nklock, s);
>  		xnthread_clear_info(curr, XNRMID | XNTIMEO | XNBREAK);
> +		xnlock_put_irqrestore(&nklock, s);
>  		return 0;
>  	}
>  

Instead of serializing in the fast path only for clearing those bits, we
could convert the remaining call sites to use xnsynch_acquire's return
value instead. At any rate, those info bits are meant to be tested
immediately upon return from the blocking call. I did most of the
conversions already, except __cobalt_mutex_acquire_unchecked(). Fixing
this one should allow us to drop the requirement for clearing the bits
in the info word, and the need for serializing in the same move.

> diff --git a/kernel/cobalt/thread.c b/kernel/cobalt/thread.c
> index 4cec6e7..7c8cb3a 100644
> --- a/kernel/cobalt/thread.c
> +++ b/kernel/cobalt/thread.c
> @@ -1989,6 +1989,7 @@ void xnthread_relax(int notify, int reason)
>  	struct task_struct *p = current;
>  	int cpu __maybe_unused;
>  	siginfo_t si;
> +	spl_t s;
>  
>  	primary_mode_only();
>  
> @@ -2045,7 +2046,9 @@ void xnthread_relax(int notify, int reason)
>  			si.si_int = reason | sigdebug_marker;
>  			send_sig_info(SIGDEBUG, &si, p);
>  		}
> +		xnlock_get_irqsave(&nklock, s);
>  		xnsynch_detect_claimed_relax(thread);
> +		xnlock_put_irqrestore(&nklock, s);
>  	}

Sigh, this was a bad one, scanning two queues with preemption enabled:
scary. I would suggest to move the serialization to
xnsynch_detect_claimed_relax() directly, since that code can be
optimized out when !XENO_DEBUG(MUTEX_RELAXED).

-- 
Philippe.

