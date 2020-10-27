Subject: Re: [PATCH 1/4][wip/dovetail] cobalt/sched: call
 irq_pipeline_send_remote to send TIMER_OOB_IPI
References: <20201020071457.22856-1-hongzhan.chen@intel.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <6b948e9c-b160-65c4-b53a-3b16a6606c78@siemens.com>
Date: Tue, 27 Oct 2020 17:47:11 +0100
MIME-Version: 1.0
In-Reply-To: <20201020071457.22856-1-hongzhan.chen@intel.com>
Content-Type: text/plain; charset=utf-8
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
To: hongzha1 <hongzhan.chen@intel.com>, xenomai@xenomai.org

On 20.10.20 09:14, hongzha1 wrote:
> call call irq_pipeline_send_remote to send TIMER_OOB_IPI instead
> of ipipe_send_ipi
> 
> Signed-off-by: hongzha1 <hongzhan.chen@intel.com>
> 
> diff --git a/kernel/cobalt/sched.c b/kernel/cobalt/sched.c
> index 82a51ce93..0a40d58d7 100644
> --- a/kernel/cobalt/sched.c
> +++ b/kernel/cobalt/sched.c
> @@ -945,6 +945,8 @@ static inline int test_resched(struct xnsched *sched)
>  		smp_mb();
>  #warning TODO
>  		//ipipe_send_ipi(IPIPE_RESCHEDULE_IPI, sched->resched);
> +		irq_pipeline_send_remote(TIMER_OOB_IPI,
> +				&sched->resched);

Same here: When done, remove the todo.

>  		cpumask_clear(&sched->resched);
>  	}
>  #endif
> 

Jan

-- 
Siemens AG, T RDA IOT
Corporate Competence Center Embedded Linux

