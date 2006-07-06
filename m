Subject: Re: [Xenomai-core] [RFC, PATCH] per-thread exec-time stats
From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <44ACF5FA.2050205@domain.hid>
References: <44ACF5FA.2050205@domain.hid>
Content-Type: text/plain
Date: Thu, 06 Jul 2006 17:04:03 +0200
Message-Id: <1152198244.4978.79.camel@domain.hid>
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
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: xenomai-core <xenomai@xenomai.org>

On Thu, 2006-07-06 at 13:37 +0200, Jan Kiszka wrote:
> c_time);
> +		seq_printf(seq, "%3u  %-6d %-10lu %-10lu %-4lu  %.8lx  %12llu"
> +			   "  %s\n",
>  			   p->cpu, p->pid, p->ssw, p->csw, p->pf, p->status,
> -			   p->name);
> +			   xnarch_ulldiv(exec_time, 1000, NULL), p->name);

xntimer_get_rawclock() returns TSC or jiffies, depending on the current
aperiodic/periodic mode; what we need is something like
xnarch_ulldiv(xnpod_ticks2ns(exec_time), ...)

-- 
Philippe.



