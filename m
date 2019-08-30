Subject: Re: [PATCH 2/2] cobalt/sched: tp: check partition id obtained from
 user
References: <20190830160514.29592-1-rpm@xenomai.org>
 <20190830160514.29592-2-rpm@xenomai.org>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <711d3140-c2a8-61a1-6bb0-d9139a82a181@siemens.com>
Date: Fri, 30 Aug 2019 19:01:13 +0200
MIME-Version: 1.0
In-Reply-To: <20190830160514.29592-2-rpm@xenomai.org>
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

On 30.08.19 18:05, Philippe Gerum wrote:
> Signed-off-by: Philippe Gerum <rpm@xenomai.org>
> ---
>   kernel/cobalt/sched-tp.c | 4 ++++
>   1 file changed, 4 insertions(+)
> 
> diff --git a/kernel/cobalt/sched-tp.c b/kernel/cobalt/sched-tp.c
> index d3e2586b0..ccff37428 100644
> --- a/kernel/cobalt/sched-tp.c
> +++ b/kernel/cobalt/sched-tp.c
> @@ -168,6 +168,10 @@ static int xnsched_tp_chkparam(struct xnthread *thread,
>   {
>   	struct xnsched_tp *tp = &thread->sched->tp;
>   
> +	if (p->tp.ptid < 0 ||
> +		p->tp.ptid >= CONFIG_XENO_OPT_SCHED_TP_NRPART)
> +		return -EINVAL;
> +
>   	if (tp->gps == NULL ||
>   	    p->tp.prio < XNSCHED_TP_MIN_PRIO ||
>   	    p->tp.prio > XNSCHED_TP_MAX_PRIO)
> 

Thanks, applied to next, queued for stable.

Jan

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

