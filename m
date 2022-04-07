Message-ID: <b806bd3e-594b-e4cf-2cc6-34f3c938b5f3@siemens.com>
Date: Thu, 7 Apr 2022 11:49:59 +0200
MIME-Version: 1.0
Subject: Re: [PATCH 2/5] cobalt/events: add single-waiter delivery mode
Content-Language: en-US
References: <20220406155648.1592472-1-rpm@xenomai.org>
 <20220406155648.1592472-2-rpm@xenomai.org>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <20220406155648.1592472-2-rpm@xenomai.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Philippe Gerum <rpm@xenomai.org>, xenomai@xenomai.org

On 06.04.22 17:56, Philippe Gerum via Xenomai wrote:
> From: Philippe Gerum <rpm@xenomai.org>
> 
> Allow for sending a set of event bits to the heading waiter only,
> instead of broadcasting them to all waiters.
> 
> This change affects the ABI, since we add a set of operation flags to
> the cobalt_event_sync service, to pass the new COBALT_EVENT_BCAST
> flag. It also affects the internal API as follows:
> 
> - the new cobalt_event_broadcast() call behaves like
>   cobalt_event_post() formerly did, which is broadcasting the event to
>   all waiters atomically.
> 
> - the new cobalt_event_signal() call implements the single-waiter
>   delivery mode we introduce.
> 
> - the former cobalt_event_post() is now a wrapper to
>   cobalt_event_broadcast(), marked with a deprecation flag.

Strictly spoken, deprecation will come with patch 4 only.

Can we have some test cases for the new features as well? Who will use them?

Jan

> 
> Signed-off-by: Philippe Gerum <rpm@xenomai.org>
> ---
>  include/cobalt/sys/cobalt.h | 12 +++++++++++-
>  include/cobalt/uapi/event.h | 10 +++++-----
>  kernel/cobalt/posix/event.c | 37 +++++++++++++++----------------------
>  kernel/cobalt/posix/event.h |  3 ++-
>  lib/cobalt/internal.c       | 20 ++++++++++++--------
>  5 files changed, 45 insertions(+), 37 deletions(-)
> 
> diff --git a/include/cobalt/sys/cobalt.h b/include/cobalt/sys/cobalt.h
> index 46096e8801..1035a29d52 100644
> --- a/include/cobalt/sys/cobalt.h
> +++ b/include/cobalt/sys/cobalt.h
> @@ -106,9 +106,19 @@ int cobalt_event_init(cobalt_event_t *event,
>  		      unsigned int value,
>  		      int flags);
>  
> -int cobalt_event_post(cobalt_event_t *event,
> +int cobalt_event_signal(cobalt_event_t *event,
>  		      unsigned int bits);
>  
> +int cobalt_event_broadcast(cobalt_event_t *event,
> +			unsigned int bits);
> +
> +/* Backward compatibility with 3.2.x and earlier. */
> +static inline int cobalt_event_post(cobalt_event_t *event,
> +				unsigned int bits)
> +{
> +	return cobalt_event_broadcast(event, bits);
> +}
> +
>  int cobalt_event_wait(cobalt_event_t *event,
>  		      unsigned int bits,
>  		      unsigned int *bits_r,
> diff --git a/include/cobalt/uapi/event.h b/include/cobalt/uapi/event.h
> index 14ddbcf567..52b71d4e3b 100644
> --- a/include/cobalt/uapi/event.h
> +++ b/include/cobalt/uapi/event.h
> @@ -22,9 +22,6 @@
>  
>  struct cobalt_event_state {
>  	__u32 value;
> -	__u32 flags;
> -#define COBALT_EVENT_PENDED  0x1
> -	__u32 nwaiters;
>  };
>  
>  struct cobalt_event;
> @@ -36,8 +33,11 @@ struct cobalt_event;
>  #define COBALT_EVENT_AUTOCLEAR  0x4
>  
>  /* Wait mode. */
> -#define COBALT_EVENT_ALL  0x0
> -#define COBALT_EVENT_ANY  0x1
> +#define COBALT_EVENT_ALL    0x0
> +#define COBALT_EVENT_ANY    0x1
> +
> +/* Sync mode. */
> +#define COBALT_EVENT_BCAST  0x1
>  
>  struct cobalt_event_shadow {
>  	__u32 state_offset;
> diff --git a/kernel/cobalt/posix/event.c b/kernel/cobalt/posix/event.c
> index 0a1236ad73..4433e733fd 100644
> --- a/kernel/cobalt/posix/event.c
> +++ b/kernel/cobalt/posix/event.c
> @@ -85,8 +85,6 @@ COBALT_SYSCALL(event_init, current,
>  	synflags = (flags & COBALT_EVENT_PRIO) ? XNSYNCH_PRIO : XNSYNCH_FIFO;
>  	xnsynch_init(&event->synch, synflags, NULL);
>  	state->value = value;
> -	state->flags = 0;
> -	state->nwaiters = 0;
>  	stateoff = cobalt_umm_offset(umm, state);
>  	XENO_BUG_ON(COBALT, stateoff != (__u32)stateoff);
>  
> @@ -152,37 +150,31 @@ int __cobalt_event_wait(struct cobalt_event_shadow __user *u_event,
>  		goto out;
>  	}
>  
> -	state->flags |= COBALT_EVENT_PENDED;
>  	rbits = state->value & bits;
>  	testval = mode & COBALT_EVENT_ANY ? rbits : bits;
>  	if (rbits && rbits == testval) {
>  		if (event->flags & COBALT_EVENT_AUTOCLEAR)
>  			state->value &= ~rbits;
> -		goto done;
> +		goto out;
>  	}
>  
>  	if (timeout == XN_NONBLOCK) {
>  		ret = -EWOULDBLOCK;
> -		goto done;
> +		goto out;
>  	}
>  
>  	ewc.value = bits;
>  	ewc.mode = mode;
>  	xnthread_prepare_wait(&ewc.wc);
> -	state->nwaiters++;
>  	info = xnsynch_sleep_on(&event->synch, timeout, tmode);
>  	if (info & XNRMID) {
>  		ret = -EIDRM;
>  		goto out;
>  	}
> -	if (info & (XNBREAK|XNTIMEO)) {
> -		state->nwaiters--;
> +	if (info & (XNBREAK|XNTIMEO))
>  		ret = (info & XNBREAK) ? -EINTR : -ETIMEDOUT;
> -	} else
> +	else
>  		rbits = ewc.value;
> -done:
> -	if (!xnsynch_pended_p(&event->synch))
> -		state->flags &= ~COBALT_EVENT_PENDED;
>  out:
>  	xnlock_put_irqrestore(&nklock, s);
>  
> @@ -240,9 +232,10 @@ COBALT_SYSCALL(event_wait64, primary,
>  }
>  
>  COBALT_SYSCALL(event_sync, current,
> -	       (struct cobalt_event_shadow __user *u_event))
> +	(struct cobalt_event_shadow __user *u_event,
> +		unsigned int bits, int flags))
>  {
> -	unsigned int bits, waitval, testval, consumed = 0;
> +	unsigned int waitval, testval, consumed = 0;
>  	struct xnthread_wait_context *wc;
>  	struct cobalt_event_state *state;
>  	struct event_wait_context *ewc;
> @@ -262,24 +255,24 @@ COBALT_SYSCALL(event_sync, current,
>  		goto out;
>  	}
>  
> -	/*
> -	 * Userland has already updated the bitmask, our job is to
> -	 * wake up any thread which could be satisfied by its current
> -	 * value.
> -	 */
>  	state = event->state;
> -	bits = state->value;
> +	state->value |= bits;
>  
> +	/*
> +	 * Wake up one or more threads satisfied by state->value,
> +	 * depending on the flags.
> +	 */
>  	xnsynch_for_each_sleeper_safe(p, tmp, &event->synch) {
>  		wc = xnthread_get_wait_context(p);
>  		ewc = container_of(wc, struct event_wait_context, wc);
> -		waitval = ewc->value & bits;
> +		waitval = ewc->value & state->value;
>  		testval = ewc->mode & COBALT_EVENT_ANY ? waitval : ewc->value;
>  		if (waitval && waitval == testval) {
> -			state->nwaiters--;
>  			ewc->value = waitval;
>  			consumed |= waitval;
>  			xnsynch_wakeup_this_sleeper(&event->synch, p);
> +			if (!(flags & COBALT_EVENT_BCAST))
> +				break;
>  		}
>  	}
>  
> diff --git a/kernel/cobalt/posix/event.h b/kernel/cobalt/posix/event.h
> index 919774c9af..85b8031b22 100644
> --- a/kernel/cobalt/posix/event.h
> +++ b/kernel/cobalt/posix/event.h
> @@ -66,7 +66,8 @@ COBALT_SYSCALL_DECL(event_wait64,
>  		     const struct __kernel_timespec __user *u_ts));
>  
>  COBALT_SYSCALL_DECL(event_sync,
> -		    (struct cobalt_event_shadow __user *u_evtsh));
> +		(struct cobalt_event_shadow __user *u_evtsh,
> +		unsigned int bits, int flags));
>  
>  COBALT_SYSCALL_DECL(event_destroy,
>  		    (struct cobalt_event_shadow __user *u_evtsh));
> diff --git a/lib/cobalt/internal.c b/lib/cobalt/internal.c
> index bf1e940b71..b142b3b551 100644
> --- a/lib/cobalt/internal.c
> +++ b/lib/cobalt/internal.c
> @@ -460,19 +460,23 @@ int cobalt_event_destroy(cobalt_event_t *event)
>  	return XENOMAI_SYSCALL1(sc_cobalt_event_destroy, event);
>  }
>  
> -int cobalt_event_post(cobalt_event_t *event, unsigned int bits)
> +static int do_sync_events(cobalt_event_t *event,
> +			unsigned int bits, int flags)
>  {
> -	struct cobalt_event_state *state = get_event_state(event);
> -
>  	if (bits == 0)
>  		return 0;
>  
> -	__sync_or_and_fetch(&state->value, bits); /* full barrier. */
> +	return XENOMAI_SYSCALL3(sc_cobalt_event_sync, event, bits, flags);
> +}
>  
> -	if ((state->flags & COBALT_EVENT_PENDED) == 0)
> -		return 0;
> +int cobalt_event_signal(cobalt_event_t *event, unsigned int bits)
> +{
> +	return do_sync_events(event, bits, 0);
> +}
>  
> -	return XENOMAI_SYSCALL1(sc_cobalt_event_sync, event);
> +int cobalt_event_broadcast(cobalt_event_t *event, unsigned int bits)
> +{
> +	return do_sync_events(event, bits, COBALT_EVENT_BCAST);
>  }
>  
>  int cobalt_event_wait(cobalt_event_t *event,
> @@ -516,7 +520,7 @@ int cobalt_sem_inquire(sem_t *sem, struct cobalt_sem_info *info,
>  		       pid_t *waitlist, size_t waitsz)
>  {
>  	struct cobalt_sem_shadow *_sem = &((union cobalt_sem_union *)sem)->shadow_sem;
> -	
> +
>  	return XENOMAI_SYSCALL4(sc_cobalt_sem_inquire, _sem,
>  				info, waitlist, waitsz);
>  }

-- 
Siemens AG, Technology
Competence Center Embedded Linux

