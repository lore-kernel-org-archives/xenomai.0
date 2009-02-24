Message-ID: <49A40AC1.90108@domain.hid>
Date: Tue, 24 Feb 2009 15:57:05 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <49A3F793.3010204@domain.hid>
In-Reply-To: <49A3F793.3010204@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] [PATCH] Fix gatekeeper affinity
Reply-To: rpm@xenomai.org
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
Cc: xenomai-core <xenomai@xenomai.org>

Jan Kiszka wrote:
> As the xnsched structures get initialized later, during xnpod_init,
> xnsched_cpu always returned 0 in the gatekeeper_thread prologue. That
> caused binding of all gatekeepers to CPU 0.
>

Hey, nice. This is why v2.4.x used pointer arithmetics to determine the cpu # in
the first place.

> Signed-off-by: Jan Kiszka <jan.kiszka@domain.hid>
> ---
> 
>  ksrc/nucleus/shadow.c |    5 ++++-
>  1 files changed, 4 insertions(+), 1 deletions(-)
> 
> diff --git a/ksrc/nucleus/shadow.c b/ksrc/nucleus/shadow.c
> index 1dedd85..2243c0e 100644
> --- a/ksrc/nucleus/shadow.c
> +++ b/ksrc/nucleus/shadow.c
> @@ -823,11 +823,14 @@ static int gatekeeper_thread(void *data)
>  	struct task_struct *this_task = current;
>  	DECLARE_WAITQUEUE(wait, this_task);
>  	struct xnsched *sched = data;
> -	int cpu = xnsched_cpu(sched);
>  	struct xnthread *target;
>  	cpumask_t cpumask;
> +	int cpu;
>  	spl_t s;
>  
> +	/* sched not fully initialized, xnsched_cpu does not work yet */
> +	cpu = sched - nkpod_struct.sched;
> +
>  	this_task->flags |= PF_NOFREEZE;
>  	sigfillset(&this_task->blocked);
>  	cpumask = cpumask_of_cpu(cpu);
> 
> _______________________________________________
> Xenomai-core mailing list
> Xenomai-core@domain.hid
> https://mail.gna.org/listinfo/xenomai-core
> 


-- 
Philippe.

