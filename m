Message-ID: <214d1591-ea24-3020-2c51-7a2e58642136@siemens.com>
Date: Mon, 24 Jan 2022 17:15:01 +0100
MIME-Version: 1.0
Subject: Re: [PATCH 06/17] cobalt/thread: dovetail: keep hard irqs off on
 transition to in-band
Content-Language: en-US
References: <cover.1623434743.git.jan.kiszka@siemens.com>
 <98288382bd466130fedd65c653f70f90a7e5c4af.1623434743.git.jan.kiszka@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <98288382bd466130fedd65c653f70f90a7e5c4af.1623434743.git.jan.kiszka@siemens.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Philippe Gerum <rpm@xenomai.org>
Cc: xenomai@xenomai.org

On 11.06.21 20:05, Jan Kiszka via Xenomai wrote:
> From: Philippe Gerum <rpm@xenomai.org>
> 
> Dovetail provides a fast service to escalate the caller to out-of-band
> mode for executing a routine (run_oob_call()), which we use to enforce
> primary mode in ___xnsched_run() to schedule out the relaxing thread.
> 
> Due to the way run_oob_call() works, enabling hardirqs during this
> transition can trigger a subtle bug caused by the relaxing thread to
> be switched out, as a result of taking an interrupt during the irqs on
> section, before __xnsched_run() actually runs on behalf of
> xnthread_relax() -> xnthread_suspend().
> 
> This may lead to a breakage of the inband interrupt state, revealed by
> lockdep complaining about a HARDIRQ-IN-W -> HARDIRQ-ON-W situation,
> when finalize_task_switch() runs for reconciling both the in-band and
> Xenomai scheduler states.
> 
> Re-enabling hard irqs before switching out the relaxing thread was
> throught as a mean to reduce the scope of the interrupt-free section
> while relaxing a thread with the I-pipe, which unlike Dovetail
> requires us to open code an escalation service based on triggering a
> synthetic interrupt.
> 
> We differentiate the behavior between the I-pipe and Dovetail by
> abstracting the related bits as pipeline_leave_oob_unlock(), keeping
> the current implementation unchanged for the I-pipe.
> 
> Signed-off-by: Philippe Gerum <rpm@xenomai.org>
> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
> ---
>   .../cobalt/kernel/dovetail/pipeline/sched.h   | 12 +++++++
>   include/cobalt/kernel/ipipe/pipeline/sched.h  | 20 ++++++++++++
>   kernel/cobalt/thread.c                        | 32 +++++++------------
>   3 files changed, 43 insertions(+), 21 deletions(-)
> 
> diff --git a/include/cobalt/kernel/dovetail/pipeline/sched.h b/include/cobalt/kernel/dovetail/pipeline/sched.h
> index b5d6c1773..45512b983 100644
> --- a/include/cobalt/kernel/dovetail/pipeline/sched.h
> +++ b/include/cobalt/kernel/dovetail/pipeline/sched.h

...

> @@ -2081,7 +2071,6 @@ void xnthread_relax(int notify, int reason)
>   	 * We disable interrupts during the migration sequence, but
>   	 * xnthread_suspend() has an interrupts-on section built in.
>   	 */
> -	splmax();
>   	trace_cobalt_lostage_request("wakeup", p);
>   	pipeline_post_inband_work(&wakework);
>   	/*
> @@ -2089,6 +2078,7 @@ void xnthread_relax(int notify, int reason)
>   	 * manipulation with handle_sigwake_event. This lock will be
>   	 * dropped by xnthread_suspend().
>   	 */
> +	splmax();

This moves pipeline_post_inband_work() outside of the irqs-off section, 
no? I think this destabilizes our migration to in-band, allowing the 
injected wake-event to be consumed by Linux prior to the oob thread 
suspension. I have a test here that seems to trigger this reliably. 
Currently validating of moving splmax up again helps. Also

Can you recall why you changed it this way?

Jan

>   	xnlock_get(&nklock);
>   	xnthread_run_handler_stack(thread, relax_thread);
>   	suspension = pipeline_leave_oob_prepare();

-- 
Siemens AG, Technology
Competence Center Embedded Linux

