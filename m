Subject: Re: [PATCH 5/5] cobalt/sched: weak: add early parameter checking
 handler
References: <20181129135417.29797-1-rpm@xenomai.org>
 <20181129135417.29797-5-rpm@xenomai.org>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <785410d8-656b-6e4f-31e7-d4a828bcdca7@siemens.com>
Date: Thu, 24 Jan 2019 19:49:28 +0100
MIME-Version: 1.0
In-Reply-To: <20181129135417.29797-5-rpm@xenomai.org>
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

On 29.11.18 14:54, Philippe Gerum via Xenomai wrote:
> This is actually a plain conversion of the former sched_declare()
> handler to the recently introduced sched_chkparam(), which only checks
> the weak scheduling parameters.
> 
> By doing so, we ensure that those checks are done early and
> unconditionally in xnsched_set_policy().
> 
> Signed-off-by: Philippe Gerum <rpm@xenomai.org>
> ---
>   kernel/cobalt/sched-weak.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/kernel/cobalt/sched-weak.c b/kernel/cobalt/sched-weak.c
> index bd3872f10..dd6a78e63 100644
> --- a/kernel/cobalt/sched-weak.c
> +++ b/kernel/cobalt/sched-weak.c
> @@ -76,8 +76,8 @@ static void xnsched_weak_protectprio(struct xnthread *thread, int prio)
>   	thread->cprio = prio;
>   }
>   
> -static int xnsched_weak_declare(struct xnthread *thread,
> -				const union xnsched_policy_param *p)
> +static int xnsched_weak_chkparam(struct xnthread *thread,
> +				 const union xnsched_policy_param *p)
>   {
>   	if (p->weak.prio < XNSCHED_WEAK_MIN_PRIO ||
>   	    p->weak.prio > XNSCHED_WEAK_MAX_PRIO)
> @@ -208,7 +208,7 @@ struct xnsched_class xnsched_class_weak = {
>   	.sched_rotate		=	NULL,
>   	.sched_forget		=	NULL,
>   	.sched_kick		=	NULL,
> -	.sched_declare		=	xnsched_weak_declare,
> +	.sched_chkparam		=	xnsched_weak_chkparam,
>   	.sched_setparam		=	xnsched_weak_setparam,
>   	.sched_trackprio	=	xnsched_weak_trackprio,
>   	.sched_protectprio	=	xnsched_weak_protectprio,
> 

I received a request internally to have these 5 in stable as well - just 
backported (only mechanical conflicts had to be resolved).

Jan

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

