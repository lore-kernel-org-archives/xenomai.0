References: <87h7lqzzzw.fsf@xenomai.org>
 <20210308170206.313181-1-florian.bezdeka@siemens.com>
 <20210308170206.313181-2-florian.bezdeka@siemens.com>
From: Philippe Gerum <rpm@xenomai.org>
Subject: Re: [RFC PATCH v2 1/4] y2038: Fixing the sem_timedwait syscall for
 32 bit systems
In-reply-to: <20210308170206.313181-2-florian.bezdeka@siemens.com>
Date: Tue, 09 Mar 2021 10:46:49 +0100
Message-ID: <87wnugirqu.fsf@xenomai.org>
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
To: Florian Bezdeka <florian.bezdeka@siemens.com>
Cc: xenomai@xenomai.org, jan.kiszka@siemens.com, chensong@kylinos.cn


Florian Bezdeka <florian.bezdeka@siemens.com> writes:

> On systems using 32 bit for time_t the sem_timedwait syscall was broken
> because the function used for copying the timeout value from userspace
> to kernel (=sem_fetch_timeout()) was always copying
> sizeof(struct timespec64).
>
> A 32 bit application (or more specific an application with 4 byte
> time_t) would only provide sizeof(struct old_timespec32).
>
> Notable changes:
>   - The copy operation from userspace to kernel is now already done in
>     the syscall handler. So it is always done. Previously it was copied
>     over and validated before the first use (when used at all).
>     So we have some additional instructions now that may be
>     unnecessary, but that simplifies the code.
>
>   - Validation: Switched to timespec64_valid() instead of our own
>     check.
>
> Fixes: 8043eccd232d ("cobalt/kernel: y2038: convert struct timespec to timespec64")
> Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
> ---
>  kernel/cobalt/posix/sem.c       | 40 +++++++++++++++------------------
>  kernel/cobalt/posix/sem.h       |  6 ++---
>  kernel/cobalt/posix/syscall32.c | 10 +++++++--
>  kernel/cobalt/posix/syscall32.h |  2 +-
>  4 files changed, 29 insertions(+), 29 deletions(-)
>
> diff --git a/kernel/cobalt/posix/sem.c b/kernel/cobalt/posix/sem.c
> index 467a9b7dd..827a4751a 100644
> --- a/kernel/cobalt/posix/sem.c
> +++ b/kernel/cobalt/posix/sem.c
> @@ -267,20 +267,11 @@ out:
>  	return ret;
>  }
>  
> -static inline int sem_fetch_timeout(struct timespec64 *ts,
> -				    const void __user *u_ts)
> -{
> -	return u_ts == NULL ? -EFAULT :
> -		cobalt_copy_from_user(ts, u_ts, sizeof(*ts));
> -}
> -
>  int __cobalt_sem_timedwait(struct cobalt_sem_shadow __user *u_sem,
> -			   const void __user *u_ts,
> -			   int (*fetch_timeout)(struct timespec64 *ts,
> -						const void __user *u_ts))
> +			   const struct timespec64 *ts)
>  {
> -	struct timespec64 ts = { .tv_sec = 0, .tv_nsec = 0 };
> -	int pull_ts = 1, ret, info;
> +	int ret, info;
> +	bool validate_ts = true;
>  	struct cobalt_sem *sem;
>  	xnhandle_t handle;
>  	xntmode_t tmode;
> @@ -304,24 +295,23 @@ int __cobalt_sem_timedwait(struct cobalt_sem_shadow __user *u_sem,
>  		 * it's actually more complex, to keep some
>  		 * applications ported to Linux happy.
>  		 */
> -		if (pull_ts) {
> +		if (validate_ts) {
>  			atomic_inc(&sem->state->value);
> -			xnlock_put_irqrestore(&nklock, s);
> -			ret = fetch_timeout(&ts, u_ts);
> -			xnlock_get_irqsave(&nklock, s);
> -			if (ret)

As mentioned in a previous comment on this series, this type of patch is
subtly changing where the core currently stands with respect to a
peculiar POSIX compliance issue. Checking the content of a valid
timespec struct is currently postponed until the timeout is needed, but
the validity of the timespec pointer referring to that information is
checked as late as possible too.

If the code now pre-loads the timespec struct early on in the syscall
path, before the timed services are called, the pointer is explicitly
checked for validity before we can decide if that timeout information is
going to be used.

e.g.

struct timespec ts = { .tv_sec = 0, .tv_nsec = 1000000000 };
sem_init(&sem, 0, 0);
sem_post(&sem);
sem_timedwait(&sem, &ts); /* should not fail, and won't as expected. */

but,

sem_init(&sem, 0, 0);
sem_post(&sem);
sem_timedwait(&sem, (void *)0xdeadbeefUL); /* should not fail, but will. */

Since the standard does not mandates such behavior but seems to tag it
as an implementation-dependent option ("The validity of the abstime need
not be checked if..."), the change would still be acceptable POSIX-wise
I believe. However, I'm pretty sure that there are POSIX compliance test
suites around which would start reporting failures due to this
change.

-- 
Philippe.

