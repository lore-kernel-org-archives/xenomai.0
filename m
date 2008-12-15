Message-ID: <49466D35.9020705@domain.hid>
Date: Mon, 15 Dec 2008 14:44:05 +0000
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <20081215143435.15493.94798.stgit@domain.hid>
	<20081215143436.15493.6001.stgit@domain.hid>
In-Reply-To: <20081215143436.15493.6001.stgit@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] [PATCH 1/6] Handle priority changes of SCHED_RR
 tasks
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: xenomai@xenomai.org

Jan Kiszka wrote:
> If shadowed Linux tasks with SCHED_RR policy change their priority,
> do_setsched_event currenty ignores this. Extend the condition to catch
> this case as well.
> 
> Signed-off-by: Jan Kiszka <jan.kiszka@domain.hid>
> ---
> 
>  ksrc/nucleus/shadow.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/ksrc/nucleus/shadow.c b/ksrc/nucleus/shadow.c
> index bd3bb3d..9f81c32 100644
> --- a/ksrc/nucleus/shadow.c
> +++ b/ksrc/nucleus/shadow.c
> @@ -2312,7 +2312,7 @@ static inline void do_setsched_event(struct task_struct *p, int priority)
>  	union xnsched_policy_param param;
>  	struct xnsched *sched;
>  
> -	if (!thread || p->policy != SCHED_FIFO)
> +	if (!thread || (p->policy != SCHED_FIFO && p->policy != SCHED_RR))
>  		return;

After some thinking about it, I think this is the wrong way to go. When
the user-space requests SCHED_RR, only the shadow should use SCHED_RR,
the linux thread should keep using SCHED_FIFO. We do not want two
schedulers to do round-robin, this would result in unpredictable behaviour.

-- 
                                                 Gilles.

