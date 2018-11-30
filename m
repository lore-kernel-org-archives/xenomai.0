Subject: Re: [PATCH 1/5] cobalt/sched: add per-policy handler for early
 parameter checking
References: <20181129135417.29797-1-rpm@xenomai.org>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <498ccd55-3a28-8e45-0cd3-9d3e03870402@siemens.com>
Date: Fri, 30 Nov 2018 14:57:13 +0100
MIME-Version: 1.0
In-Reply-To: <20181129135417.29797-1-rpm@xenomai.org>
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

On 29.11.18 14:54, Philippe Gerum wrote:
> We need policy-specific scheduling parameters to be checked early and
> unconditionally before applying them in xnsched_setparam(), even if
> the current scheduling policy does not change for the target thread
> (i.e. sched_declare() is not called).
> 
> Signed-off-by: Philippe Gerum <rpm@xenomai.org>
> ---
>   include/cobalt/kernel/sched.h | 12 ++++++++++++
>   kernel/cobalt/sched.c         |  4 ++++
>   2 files changed, 16 insertions(+)
> 
> diff --git a/include/cobalt/kernel/sched.h b/include/cobalt/kernel/sched.h
> index d2b3d0c63..3b0825d67 100644
> --- a/include/cobalt/kernel/sched.h
> +++ b/include/cobalt/kernel/sched.h
> @@ -138,6 +138,8 @@ struct xnsched_class {
>   			     const union xnsched_policy_param *p);
>   	void (*sched_migrate)(struct xnthread *thread,
>   			      struct xnsched *sched);
> +	int (*sched_chkparam)(struct xnthread *thread,
> +			      const union xnsched_policy_param *p);
>   	/**
>   	 * Set base scheduling parameters. This routine is indirectly
>   	 * called upon a change of base scheduling settings through
> @@ -513,6 +515,16 @@ static inline void xnsched_tick(struct xnsched *sched)
>   		sched_class->sched_tick(sched);
>   }
>   
> +static inline int xnsched_chkparam(struct xnsched_class *sched_class,
> +				   struct xnthread *thread,
> +				   const union xnsched_policy_param *p)
> +{
> +	if (sched_class->sched_chkparam)
> +		return sched_class->sched_chkparam(thread, p);
> +
> +	return 0;
> +}
> +
>   static inline int xnsched_declare(struct xnsched_class *sched_class,
>   				  struct xnthread *thread,
>   				  const union xnsched_policy_param *p)
> diff --git a/kernel/cobalt/sched.c b/kernel/cobalt/sched.c
> index a3c963bfe..f7d16fa37 100644
> --- a/kernel/cobalt/sched.c
> +++ b/kernel/cobalt/sched.c
> @@ -434,6 +434,10 @@ int xnsched_set_policy(struct xnthread *thread,
>   	bool effective;
>   	int ret;
>   
> +	ret = xnsched_chkparam(sched_class, thread, p);
> +	if (ret)
> +		return ret;
> +
>   	/*
>   	 * Declaring a thread to a new scheduling class may fail, so
>   	 * we do that early, while the thread is still a member of the
> 

Thanks, works as expected - all 5 applied to next.

Jan

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

