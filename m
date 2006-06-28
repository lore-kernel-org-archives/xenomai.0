Subject: Re: [Xenomai-core] [PATCH 2/6] Improve fault report
From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <20060626172118.347530000@domain.hid>
References: <20060626172116.019532000@domain.hid> <20060626172118.347530000@domain.hid>
Content-Type: text/plain
Date: Wed, 28 Jun 2006 09:42:39 +0200
Message-Id: <1151480559.5154.2.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
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
To: jan.kiszka@domain.hid
Cc: xenomai@xenomai.org

On Mon, 2006-06-26 at 19:21 +0200, jan.kiszka@domain.hid wrote:
> plain text document attachment (enhance-kernel-fault-report.patch)
> Introduce xnarch_fault_um() to test if a fault happened in user-mode and applies the new feature to report core and driver crashes more verbosely. 

> 	if (xnpod_shadow_p()) {
>  #ifdef CONFIG_XENO_OPT_DEBUG
> -		if (xnarch_fault_notify(fltinfo))	/* Don't report debug traps */
> +		if (!xnarch_fault_um(fltinfo)) {
> +			xnarch_trace_panic_freeze();

KGDB breakpoint issue?

> +			xnprintf
> +			    ("Switching %s to secondary mode after exception #%u in "
> +			     "kernel-space at 0x%lx (pid %d)\n", thread->name,
> +			     xnarch_fault_trap(fltinfo),
> +			     xnarch_fault_pc(fltinfo),
> +			     xnthread_user_pid(thread));
> +			xnarch_trace_panic_dump();
> +		} else if (xnarch_fault_notify(fltinfo)) /* Don't report debug traps */

-- 
Philippe.



