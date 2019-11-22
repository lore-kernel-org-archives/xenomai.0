Subject: Re: [PATCH 3/7] cobalt/posix: fix missed rescheduling opportunities
References: <20191122171949.18021-1-rpm@xenomai.org>
 <20191122171949.18021-4-rpm@xenomai.org>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <1c860027-1d24-3aa9-4a6b-cdd7ed3142e6@siemens.com>
Date: Fri, 22 Nov 2019 18:42:52 +0100
MIME-Version: 1.0
In-Reply-To: <20191122171949.18021-4-rpm@xenomai.org>
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
> stop_debugged_thread() may suspend threads running on a remote CPU, we
> have to kick the rescheduling procedure for these changes to take
> effect asap. Make sure xnsched_run() is kicked from the call sites
> once they are done updating the scheduler state.
> 
> Signed-off-by: Philippe Gerum <rpm@xenomai.org>
> ---
>   kernel/cobalt/posix/process.c | 9 ++++-----
>   1 file changed, 4 insertions(+), 5 deletions(-)
> 
> diff --git a/kernel/cobalt/posix/process.c b/kernel/cobalt/posix/process.c
> index b90e53507..1e003108e 100644
> --- a/kernel/cobalt/posix/process.c
> +++ b/kernel/cobalt/posix/process.c
> @@ -819,6 +819,7 @@ static inline int handle_exception(struct ipipe_trap_data *d)
>   		}
>   		stop_debugged_process(thread);
>   		xnlock_put_irqrestore(&nklock, s);
> +		xnsched_run();

How does this help with threads on remote CPUs? xnsched_run deals with 
xnsched_current only, no?

Jan

>   	}
>   #endif
>   
> @@ -1295,10 +1296,8 @@ static int handle_sigwake_event(struct task_struct *p)
>   			cobalt_register_debugged_thread(thread);
>   	}
>   
> -	if (xnthread_test_state(thread, XNRELAX)) {
> -		xnlock_put_irqrestore(&nklock, s);
> -		return KEVENT_PROPAGATE;
> -	}
> +	if (xnthread_test_state(thread, XNRELAX))
> +		goto out;
>   
>   	/*
>   	 * If kicking a shadow thread in primary mode, make sure Linux
> @@ -1320,7 +1319,7 @@ static int handle_sigwake_event(struct task_struct *p)
>   		xnthread_resume(thread, XNDBGSTOP);
>   
>   	__xnthread_kick(thread);
> -
> +out:
>   	xnsched_run();
>   
>   	xnlock_put_irqrestore(&nklock, s);
> 


-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

