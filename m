Subject: Re: [PATCH 2/2] cobalt/trace: dovetail: drop unnecessary helpers
References: <20211130073140.14252-1-hongzhan.chen@intel.com>
 <20211130073140.14252-2-hongzhan.chen@intel.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <77fb1a9a-c2fe-9654-8e7d-511d10fc3614@siemens.com>
Date: Tue, 30 Nov 2021 09:20:13 +0100
MIME-Version: 1.0
In-Reply-To: <20211130073140.14252-2-hongzhan.chen@intel.com>
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
To: Hongzhan Chen <hongzhan.chen@intel.com>, xenomai@xenomai.org

On 30.11.21 08:31, Hongzhan Chen via Xenomai wrote:
> For dovetail-based, handle_oob_trap_entry would try to demote oob
> stage and leave in-band to do panic thing when fault happen.
> 
> Signed-off-by: Hongzhan Chen <hongzhan.chen@intel.com>
> 
> diff --git a/include/cobalt/kernel/dovetail/pipeline/trace.h b/include/cobalt/kernel/dovetail/pipeline/trace.h
> index 7147ab183..306dd549a 100644
> --- a/include/cobalt/kernel/dovetail/pipeline/trace.h
> +++ b/include/cobalt/kernel/dovetail/pipeline/trace.h
> @@ -91,18 +91,6 @@ static inline int xntrace_tick(unsigned long delay_ticks) /* ns */
>  	return 0;
>  }
>  
> -static inline int xntrace_panic_freeze(void)
> -{
> -	TODO();
> -	return 0;
> -}
> -
> -static inline int xntrace_panic_dump(void)
> -{
> -	TODO();
> -	return 0;
> -}
> -
>  static inline bool xntrace_enabled(void)
>  {
>  	return IS_ENABLED(CONFIG_DOVETAIL_TRACE);
> diff --git a/kernel/cobalt/dovetail/kevents.c b/kernel/cobalt/dovetail/kevents.c
> index 648929756..4da4f51b7 100644
> --- a/kernel/cobalt/dovetail/kevents.c
> +++ b/kernel/cobalt/dovetail/kevents.c
> @@ -64,14 +64,12 @@ void handle_oob_trap_entry(unsigned int trapnr, struct pt_regs *regs)
>  	 */
>  #if defined(CONFIG_XENO_OPT_DEBUG_COBALT) || defined(CONFIG_XENO_OPT_DEBUG_USER)
>  	if (!user_mode(regs)) {
> -		xntrace_panic_freeze();
>  		printk(XENO_WARNING
>  		       "switching %s to secondary mode after exception #%u in "
>  		       "kernel-space at 0x%lx (pid %d)\n", thread->name,
>  		       trapnr,
>  		       xnarch_fault_pc(regs),
>  		       xnthread_host_pid(thread));
> -		xntrace_panic_dump();
>  	} else if (xnarch_fault_notify(trapnr)) /* Don't report debug traps */
>  		printk(XENO_WARNING
>  		       "switching %s to secondary mode after exception #%u from "
> 

thanks, both applied.

Jan

-- 
Siemens AG, T RDA IOT
Corporate Competence Center Embedded Linux

