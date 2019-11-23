Subject: Re: [PATCH 6/7] cobalt/sched: drop useless rmb in lock check
References: <20191122171949.18021-1-rpm@xenomai.org>
 <20191122171949.18021-7-rpm@xenomai.org>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <95329dfe-c04a-ec25-af96-da12559b9ab6@siemens.com>
Date: Sat, 23 Nov 2019 09:02:14 +0100
MIME-Version: 1.0
In-Reply-To: <20191122171949.18021-7-rpm@xenomai.org>
Content-Type: text/plain; charset=utf-8; format=flowed
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
To: Philippe Gerum <rpm@xenomai.org>, xenomai@xenomai.org

On 22.11.19 18:19, Philippe Gerum via Xenomai wrote:
> From: Philippe Gerum <rpm@xenomai.org>
> 
> Signed-off-by: Philippe Gerum <rpm@xenomai.org>
> ---
>   include/cobalt/kernel/sched.h | 15 ++++++---------
>   1 file changed, 6 insertions(+), 9 deletions(-)
> 
> diff --git a/include/cobalt/kernel/sched.h b/include/cobalt/kernel/sched.h
> index 3b0825d67..c66e29d4c 100644
> --- a/include/cobalt/kernel/sched.h
> +++ b/include/cobalt/kernel/sched.h
> @@ -298,6 +298,9 @@ void __xnsched_run_handler(void);
>   static inline int __xnsched_run(struct xnsched *sched)
>   {
>   	/*
> +	 * Reschedule if XNSCHED is pending, but never over an IRQ
> +	 * handler or in the middle of unlocked context switch.
> +	 *
>   	 * NOTE: Since ___xnsched_run() won't run immediately if an
>   	 * escalation to primary domain is needed, we won't use
>   	 * critical scheduler information before we actually run in
> @@ -328,15 +331,9 @@ static inline int __xnsched_run(struct xnsched *sched)
>   static inline int xnsched_run(void)
>   {
>   	struct xnsched *sched = xnsched_current();
> -	/*
> -	 * No rescheduling is possible, either if:
> -	 *
> -	 * - the current thread holds the scheduler lock
> -	 * - an ISR context is active
> -	 * - we are caught in the middle of an unlocked context switch.
> -	 */
> -	smp_rmb();

I think we still want at least READ_ONCE semantic here for the sched 
readout. If we can be migrated in the middle of this function, the check 
for sched->curr_lock_count must happen against the same sched we trigger 
the xnsched_run for later on.

Jan

> -	if (unlikely(sched->curr->lock_count > 0))
> +	struct xnthread *curr = sched->curr;
> +
> +	if (unlikely(curr->lock_count > 0))
>   		return 0;
>   
>   	return __xnsched_run(sched);
> 

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

