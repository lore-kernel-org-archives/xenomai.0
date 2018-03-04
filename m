References: <20180302132205.28807-1-henning.schild@siemens.com>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <6c33bb05-1d1e-7b6d-b628-de56ef28b8a7@xenomai.org>
Date: Sun, 4 Mar 2018 12:17:56 +0100
MIME-Version: 1.0
In-Reply-To: <20180302132205.28807-1-henning.schild@siemens.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Xenomai] [PATCH] cobalt/kernel: fix clock_adjtime() compile
	error
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Henning Schild <henning.schild@siemens.com>, "xenomai @ xenomai . org" <xenomai@xenomai.org>

On 03/02/2018 02:22 PM, Henning Schild wrote:
> Moving the definition out of the ifdef solves the following error:
> 
> include/xenomai/cobalt/kernel/clock.h:260:16: error:
>  ‘struct <anonymous>’ has no member named ‘adjust_time’
> include/xenomai/cobalt/kernel/clock.h:263:19: error:
>  ‘struct <anonymous>’ has no member named ‘adjust_time’
> 
> Signed-off-by: Henning Schild <henning.schild@siemens.com>
> ---
>  include/cobalt/kernel/clock.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/include/cobalt/kernel/clock.h b/include/cobalt/kernel/clock.h
> index bf03c5921..bbdec9357 100644
> --- a/include/cobalt/kernel/clock.h
> +++ b/include/cobalt/kernel/clock.h
> @@ -53,8 +53,6 @@ struct xnclock {
>  		xnticks_t (*read_monotonic)(struct xnclock *clock);
>  		int (*set_time)(struct xnclock *clock,
>  				const struct timespec *ts);
> -		int (*adjust_time)(struct xnclock *clock,
> -				   struct timex *tx);
>  		xnsticks_t (*ns_to_ticks)(struct xnclock *clock,
>  					  xnsticks_t ns);
>  		xnsticks_t (*ticks_to_ns)(struct xnclock *clock,
> @@ -66,6 +64,8 @@ struct xnclock {
>  		void (*program_remote_shot)(struct xnclock *clock,
>  					    struct xnsched *sched);
>  #endif
> +		int (*adjust_time)(struct xnclock *clock,
> +				   struct timex *tx);
>  		int (*set_gravity)(struct xnclock *clock,
>  				   const struct xnclock_gravity *p);
>  		void (*reset_gravity)(struct xnclock *clock);
> 

Merged, thanks.

-- 
Philippe.

