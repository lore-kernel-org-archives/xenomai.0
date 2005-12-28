Message-ID: <43B26587.9090809@domain.hid>
Date: Wed, 28 Dec 2005 11:14:31 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] [PATCH] I-pipe hosted tracing service
References: <43B1381B.6060001@domain.hid>
In-Reply-To: <43B1381B.6060001@domain.hid>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
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


Hi Jan,

Jan Kiszka wrote:
> Hi all,
> 
> as a late Christmas gift I would like to roll out a probably quite
> useful instrumentation tool:
> 
> This is the PREEMPT_RT-inspired I-pipe tracing service!
> 
> The core ipipe_trace.patch-v4 should apply cleanly against 2.6.14
> kernels with ipipe-1.0-12, the instrumentation patches were developed
> against Xenomai SVN trunk. Currently, this is x86 only, but adding
> further archs should be quite easy.
> 
> I can provide two instrumentation "experiments" so far:
> 
> ipipe_trace.instr tries to make use of existing statistics capturing
> points in the i-ipipe patch, but fails to grab the worst case due to
> spurious path end reports inside the i-pipe core. Anyway, the tracer can
> at least look a bit before and after a trace (see below) so that you may
> add the missing delays on a piece of paper on your own (still not
> optimal, I know).
> 
> maxlat_proc.patch is actually more than a pure instrumentation based on
> the NMI watchdog. First it exports the trigger threshold value of the
> watchdog to a /proc variable which you can now tune during runtime. And
> then it replaces the rather hard die_nmi() report of deadline misses by
> an ipipe_trace_freeze() call. After such a hit you can safely look at
> the reported trace, retune the NMI, and even start a new round.
> 
> 

> INSTALLATION
> ------------
> 1. apply ipipe_trace.patch-v4 against your xeno-prepared RT-kernel
> 2. switch on CONFIG_IPIPE_TRACE (I-pipe suboption)
> 3. apply some or all instrumentation patches
> 4. recompile the kernel
> 
> 
> API
> ---
> The tracer provides 4 instrumentation functions:
> 
> void ipipe_trace_begin(unsigned long value);
>     Mark the beginning of a critical trace path. All following
>     ipipe_trace_begin() calls are noted but ignored until
>     ipipe_trace_end() is invoked. An optional value can be provided, it
>     will be stored with this trace point.
> 
> void ipipe_trace_end(unsigned long value);
>     Mark the end of a critical trace path and stores it for dumping in
>     case this is the longest path captured so far. All following
>     ipipe_trace_end() calls are noted but have no further effect until a
>     ipipe_trace_begin() is invoked again. An optional value can be
>     provided, it will be stored with this trace point.
> 
> void ipipe_trace_freeze(unsigned long value);
>     Freezes a back-trace on invocation. This has higher priority then
>     any ipipe_trace_begin/end marks. Only the first freeze will get
>     stored, all following calls of ipipe_trace_freeze() are noted but
>     ignored until the current frozen path is reset (see below). An
>     optional value can be provided, it will be stored with this trace
>     point.
> 
> void ipipe_trace_special(unsigned char special_id, unsigned long value);
>     Marks a user-defined trace point by adding the provided information
>     to the trace but does not cause any further effects.
> 
> 
> USAGE
> -----
> All tracing related controls and information can be found under
> /proc/ipipe/trace/. Here is an overview:
> 
> max - the longest trace path between all ipipe_trace_begin() and
>     ipipe_trace_end() points. Read from it for dumping the content,
>     write any data to it for resetting.
> 
> frozen - the first frozen back-trace triggered by a ipipe_trace_freeze()
>     call. Read from it for dumping the content, write any data to it for
>     resetting.
> 
> enable - the global switch to turn all tracing on or off. Default: 1
>     (on).
> 
> pre_trace_points - number of additional trace points to be reported
>     before the longest trace path. Default: 10
> 
> post_trace_points - number of additional trace points to be captured and
>     reported both for the longest trace path and the frozen path.
>     Default: 10.
> 
> back_trace_points - number of trace points backwards to be reported for
>     the frozen trace path (including the freeze event itself). Default:
>     30.
> 
> verbose - report more details via "max" or "frozen". Just give it a try.
>     Default: 0 (off).
> 
> 
> Ok, so far for the documentation. I can only recommend to do your own
> experiments, it can reveal interesting insights into your real-time
> system! There is indication for hard-IRQ-off phases during a trace and
> for the rare case the NMI recurses while in a critical tracing phase
> (mostly, NMI just shows up by its name, i.e. via the related functions).
> And if you are lucky, you may even see which (Linux) driver was
> touching the wire when some hardware-related latency bomb goes off :).
> 
> Also quite useful but not yet ready for release is an export of the
> ipipe_trace_xxx calls to userspace. Invoking a freeze right after the
> testsuite's latency tool exceeded some threshold is on my to-do list
> (just a hack ATM). This may be easily done via that RTDM benchmark
> device. Here is a tentative trace excerpt of such an instrumentation:
> 
>   Type    Time   Function (Parent)
> : fn      -112   __ipipe_stall_root (work_resched)
> : fn      -112!  __ipipe_unstall_iret_root (restore_raw)
> [here we likely left for userspace until the IRQ arrived]
> :|fn       -32   __ipipe_handle_irq (common_interrupt)
> :|fn       -31   __ipipe_ack_system_irq (__ipipe_handle_irq)
> :|fn       -31   ipipe_suspend_domain (__ipipe_handle_irq)
> :|fn       -31   __ipipe_sync_stage (ipipe_suspend_domain)
> :|fn       -30   rthal_irq_trampoline (__ipipe_sync_stage)
> :|fn       -30   xnintr_clock_handler (rthal_irq_trampoline)
> :|fn       -30   xnintr_irq_handler (xnintr_clock_handler)
> :|fn       -29+  xnpod_announce_tick (xnintr_irq_handler)
> :|fn       -27+  xntimer_do_tick_aperiodic (xnpod_announce_tick)
> :|fn       -26   xnthread_periodic_handler (xntimer_do_tick_aperiodic)
> :|fn       -26+  xnpod_resume_thread (xnthread_periodic_handler)
> :|fn       -24+  xnpod_schedule (xnintr_irq_handler)
> :|fn       -21+  __switch_to (xnpod_schedule)
> :|fn       -18+  ipipe_unstall_pipeline_from (xnpod_wait_thread_period)
> :|fn       -16   __ipipe_handle_irq (common_interrupt)
> :|fn       -16   __ipipe_ack_common_irq (__ipipe_handle_irq)
> :|fn       -15+  mask_and_ack_8259A (__ipipe_ack_common_irq)
> [back in userspace inside the periodic RT task, it now calls
> rt_timer_tsc2ns()]
> : fn        -7   __ipipe_syscall_root (system_call)
> : fn        -7   __ipipe_dispatch_event (__ipipe_syscall_root)
> : fn        -7   hisyscall_event (__ipipe_dispatch_event)
> : fn        -6   __rt_timer_tsc2ns (hisyscall_event)
> : fn        -6   __copy_from_user_ll (__rt_timer_tsc2ns)
> : fn        -5   rt_timer_tsc2ns (__rt_timer_tsc2ns)
> : fn        -5+  __copy_to_user_ll (__rt_timer_tsc2ns)
> [now we issue an IOCTL to "rtbenchmark0" for freezing the trace]
> : fn        -4   __ipipe_syscall_root (system_call)
> : fn        -4   __ipipe_dispatch_event (__ipipe_syscall_root)
> : fn        -4   hisyscall_event (__ipipe_dispatch_event)
> : fn        -3   sys_rtdm_ioctl (hisyscall_event)
> : fn        -3   _rtdm_ioctl (sys_rtdm_ioctl)
> : fn        -2+  rtdm_context_get (_rtdm_ioctl)
> :|fn        -1   ipipe_unstall_pipeline_from (rtdm_context_get)
> : fn         0   rt_tmbench_ioctl_rt (_rtdm_ioctl)
> : fn         0   tracer_ioctl (rt_tmbench_ioctl_rt)
> < freeze     0   tracer_ioctl (rt_tmbench_ioctl_rt)
>   fn         1   __ipipe_syscall_root (system_call)
>   fn         1   __ipipe_dispatch_event (__ipipe_syscall_root)
> [the last two lines are "post-trace", i.e. additionally captured after
> the freeze]
> 
> Legend:
> "|" - hard IRQs off
> "+" - more than 1 us delay in this function
> "!" - more than 10 us delay in this function
> ">" - path begin (only in worst-case trace paths)
> ":" - traced path
> "<" - path end
> 
> Another interesting use case for the tracer can be kernel debugging
> scenarios, even when the timing information is not that relevant. Just
> add a ipipe_trace_freeze() at that line where you would like to see the
> calling history (backward and forward!).
> 
> The advantage of the tracer is that it adds reasonable overhead to all
> functions, and this quite evenly. Even the critical capturing work
> itself comes with no significant additional complexitiy (as long as you
> keep "pre_trace_points" small, e.g. < 100 or so). Although I cannot
> recommend this frankly, I think the tracer should not cause harm to
> production systems with a bit power left.
> 
> 
> Significant credits for this patch goes to Luotao Fu who provided the
> helpful foundation for all that weird features I felt like having to add
> later!
>

Yummie, looks really good, and definitely worth merging, so that it gets 
broader testing, and further enhancements/fixes are made simpler. I have 
very few comments on the code below, they mainly boil down to "keep the 
arch-dep stuff out of the generic support, please".

Ok, we have two significant improvements pending for the Adeos/i-pipe 
1.1 series here, namely Dmitry's shared irq support and your tracer. I'm 
going to merge the former on top of the latter, so that we might get 
some data about the cost/improvement brought by the IRQ path shortening 
(I'm curious to evaluate the impact of this actually). IOW, the tracer 
is first on the merge queue now, and I will merge Dmitry's work right 
after that.

> Have fun,
> Jan
> 
> 

<snip>

> --- linux-2.6.14.3/kernel/ipipe/core.c.orig	2005-12-17 14:08:23.000000000 +0100
> +++ linux-2.6.14.3/kernel/ipipe/core.c	2005-12-27 13:05:00.000000000 +0100
> @@ -415,7 +415,7 @@
>  
>  #include <linux/proc_fs.h>
>  
> -static struct proc_dir_entry *ipipe_proc_root;
> +struct proc_dir_entry *ipipe_proc_root;
>  
>  static int __ipipe_version_info_proc(char *page,
>  				     char **start,
> @@ -653,10 +653,17 @@
>  #endif /* CONFIG_IPIPE_STATS */
>  }
>  
> +#ifdef CONFIG_IPIPE_TRACE
> +extern void __ipipe_init_trace_proc(void);
> +#else /* !CONFIG_IPIPE_TRACE */
> +# define __ipipe_init_trace_proc()
> +#endif /* CONFIG_IPIPE_TRACE */
> +

Better move this to linux/ipipe.h.

>  void ipipe_init_proc(void)
>  {
>  	ipipe_proc_root = create_proc_entry("ipipe",S_IFDIR, 0);
>  	create_proc_read_entry("version",0444,ipipe_proc_root,&__ipipe_version_info_proc,NULL);
> +	__ipipe_init_trace_proc();
>  	__ipipe_add_domain_proc(ipipe_root_domain);
>  }
>  
> --- linux-2.6.14.3/kernel/ipipe/tracer.c.orig	1970-01-01 01:00:00.000000000 +0100
> +++ linux-2.6.14.3/kernel/ipipe/tracer.c	2005-12-27 13:05:00.000000000 +0100
> @@ -0,0 +1,847 @@
> +/* -*- linux-c -*-
> + * kernel/ipipe/tracer.c
> + *
> + * Copyright (C) 2005 Luotao Fu.
> + *               2005 Jan Kiszka.
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation, Inc., 675 Mass Ave, Cambridge MA 02139,
> + * USA; either version 2 of the License, or (at your option) any later
> + * version.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
> + * GNU General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public License
> + * along with this program; if not, write to the Free Software
> + * Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.
> + */
> +
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/version.h>
> +#include <linux/kallsyms.h>
> +#include <linux/seq_file.h>
> +#include <linux/proc_fs.h>
> +#include <linux/ctype.h>
> +#include <linux/ipipe_trace.h>
> +#include <asm/uaccess.h>
> +
> +#ifndef CONFIG_ARM

Eeek... Any chance to have such arch-dependent stuff out of the generic 
core? I'd better see this in asm/ipipe.h.

> +# define __CALLER_ADDR0 ((unsigned long)__builtin_return_address(0))
> +# define __CALLER_ADDR1 ((unsigned long)__builtin_return_address(1))
> +#else
> +# error Implement ipipe_arm_return_addr!
> +  unsigned long ipipe_arm_return_addr(int level);
> +# define __CALLER_ADDR0 ipipe_arm_return_addr(0)
> +# define __CALLER_ADDR1 ipipe_arm_return_addr(1)
> +#endif
> +
> +
> +#define IPIPE_TRACE_PATHS           4
> +#define IPIPE_DEFAULT_ACTIVE        0
> +#define IPIPE_DEFAULT_MAX           1
> +#define IPIPE_DEFAULT_FROZEN        2
> +
> +#define IPIPE_TRACE_POINTS          16*1024
> +#define WRAP_POINT_NO(point)        ((point) & (IPIPE_TRACE_POINTS-1))
> +
> +#define IPIPE_DEFAULT_PRE_TRACE     10
> +#define IPIPE_DEFAULT_POST_TRACE    10
> +#define IPIPE_DEFAULT_BACK_TRACE    30
> +
> +#define IPIPE_DELAY_NOTE            1000  /* in nanoseconds */
> +#define IPIPE_DELAY_WARN            10000 /* in nanoseconds */
> +
> +#define IPIPE_TFLG_NMI_LOCK         0x0001
> +#define IPIPE_TFLG_NMI_HIT          0x0002
> +#define IPIPE_TFLG_HWIRQ_OFF        0x0004
> +#define IPIPE_TFLG_FREEZING         0x0008
> +
> +
> +struct ipipe_trace_point{
> +	short type;
> +	short flags;
> +	unsigned long eip;
> +	unsigned long parent_eip;
> +	unsigned long v;
> +	unsigned long long timestamp;
> +};
> +
> +struct ipipe_trace_path{
> +	volatile int flags;
> +	int dump_lock; /* separated from flags due to cross-cpu access */
> +	int trace_pos;
> +	int begin, end;
> +	int post_trace;
> +	unsigned long long length;
> +	struct ipipe_trace_point point[IPIPE_TRACE_POINTS];
> +} ____cacheline_aligned_in_smp;
> +
> +enum ipipe_trace_type
> +{
> +	IPIPE_TRACE_FN = 0,
> +	IPIPE_TRACE_BEGIN,
> +	IPIPE_TRACE_END,
> +	IPIPE_TRACE_FREEZE,
> +	IPIPE_TRACE_SPECIAL,
> +};
> +
> +
> +int ipipe_trace_enable = 1;
> +
> +static struct ipipe_trace_path trace_paths[NR_CPUS][IPIPE_TRACE_PATHS] =
> +	{ [0 ... NR_CPUS-1] =
> +		{ [ IPIPE_DEFAULT_ACTIVE ] = {.begin = -1, .end = -1 },
> +		  [ IPIPE_DEFAULT_FROZEN ] = {.begin = -1, .end = -1 } } };
> +static int active_path[NR_CPUS] =
> +	{ [0 ... NR_CPUS-1] = IPIPE_DEFAULT_ACTIVE };
> +static int max_path[NR_CPUS] =
> +	{ [0 ... NR_CPUS-1] = IPIPE_DEFAULT_MAX };
> +static int frozen_path[NR_CPUS] =
> +	{ [0 ... NR_CPUS-1] = IPIPE_DEFAULT_FROZEN };
> +static ipipe_spinlock_t global_path_lock = IPIPE_SPIN_LOCK_UNLOCKED;
> +static int pre_trace = IPIPE_DEFAULT_PRE_TRACE;
> +static int post_trace = IPIPE_DEFAULT_POST_TRACE;
> +static int back_trace = IPIPE_DEFAULT_BACK_TRACE;
> +static int verbose_trace = 0;
> +
> +static DECLARE_MUTEX(out_mutex);
> +static struct ipipe_trace_path *print_path;
> +static int print_pre_trace;
> +static int print_post_trace;
> +
> +
> +static notrace int __ipipe_get_free_trace_path(int old, int cpu_id)
> +{
> +	int new_active = old;
> +	struct ipipe_trace_path *tp;
> +
> +	do {
> +		if (++new_active == IPIPE_TRACE_PATHS)
> +			new_active = 0;
> +		tp = &trace_paths[cpu_id][new_active];
> +	} while ((new_active == max_path[cpu_id]) ||
> +	         (new_active == frozen_path[cpu_id]) ||
> +	         tp->dump_lock);
> +
> +	return new_active;
> +}
> +
> +static notrace void
> +__ipipe_migrate_pre_trace(struct ipipe_trace_path *new_tp,
> +                          struct ipipe_trace_path *old_tp, int old_pos)
> +{
> +	int i;
> +
> +	new_tp->trace_pos = pre_trace+1;
> +	for (i = new_tp->trace_pos; i > 0; i--)
> +		memcpy(&new_tp->point[WRAP_POINT_NO(new_tp->trace_pos-i)],
> +		       &old_tp->point[WRAP_POINT_NO(old_pos-i)],
> +		       sizeof(struct ipipe_trace_point));
> +}
> +
> +static inline struct ipipe_trace_path *
> +__ipipe_trace_end(int cpu_id, struct ipipe_trace_path *tp, int pos)
> +{
> +	struct ipipe_trace_path *old_tp = tp;
> +	long active = active_path[cpu_id];
> +	unsigned long long length;
> +
> +	/* do we have a new worst case? */
> +	length = tp->point[tp->end].timestamp -
> +	         tp->point[tp->begin].timestamp;
> +	if (length > (trace_paths[cpu_id][max_path[cpu_id]]).length) {
> +		/* we need protection here against other cpus trying
> +		   to start a proc dump */
> +		spin_lock_hw(&global_path_lock);
> +
> +		/* active path holds new worst case */
> +		tp->length = length;
> +		max_path[cpu_id] = active;
> +
> +		/* find next unused trace path */
> +		active = __ipipe_get_free_trace_path(active, cpu_id);
> +
> +		spin_unlock_hw(&global_path_lock);
> +
> +		tp = &trace_paths[cpu_id][active];
> +
> +		/* migrate last entries for pre-tracing */
> +		__ipipe_migrate_pre_trace(tp, old_tp, pos);
> +	}
> +
> +	return tp;
> +}
> +
> +static inline struct ipipe_trace_path *
> +__ipipe_trace_freeze(int cpu_id, struct ipipe_trace_path *tp, int pos)
> +{
> +	struct ipipe_trace_path *old_tp = tp;
> +	long active = active_path[cpu_id];
> +	int i;
> +
> +	/* frozen paths have no core (begin=end) */
> +	tp->begin = tp->end;
> +
> +	/* we need protection here against other cpus trying
> +	 * to set their frozen path or to start a proc dump */
> +	spin_lock_hw(&global_path_lock);
> +
> +	frozen_path[cpu_id] = active;
> +
> +	/* find next unused trace path */
> +	active = __ipipe_get_free_trace_path(active, cpu_id);
> +
> +	/* check if this is the first frozen path */
> +	for_each_online_cpu(i) {
> +		if ((i != cpu_id) &&
> +		    (trace_paths[i][frozen_path[i]].end >= 0))
> +			tp->end = -1;
> +	}
> +
> +	spin_unlock_hw(&global_path_lock);
> +
> +	tp = &trace_paths[cpu_id][active];
> +
> +	/* migrate last entries for pre-tracing */
> +	__ipipe_migrate_pre_trace(tp, old_tp, pos);
> +
> +	return tp;
> +}
> +
> +void notrace
> +__ipipe_trace(enum ipipe_trace_type type, unsigned long eip,
> +              unsigned long parent_eip, unsigned long v)
> +{
> +	struct ipipe_trace_path *tp, *old_tp;
> +	int pos, next_pos, begin;
> +	struct ipipe_trace_point *point;
> +	unsigned long flags;
> +	int cpu_id;
> +
> +	local_irq_save_hw(flags);
> +
> +	cpu_id = raw_smp_processor_id();
> +	tp = old_tp = &trace_paths[cpu_id][active_path[cpu_id]];
> +
> +	/* check for NMI recursion */
> +	if (tp->flags & IPIPE_TFLG_NMI_LOCK) {
> +		tp->flags |= IPIPE_TFLG_NMI_HIT;
> +		return; /* no need for restoring flags inside IRQ */
> +	}
> +
> +	/* clear NMI warning and set lock (atomically per cpu) */
> +	tp->flags = (tp->flags & ~IPIPE_TFLG_NMI_HIT) | IPIPE_TFLG_NMI_LOCK;
> +
> +	/* get the point buffer */
> +	pos = tp->trace_pos;
> +	point = &tp->point[pos];
> +
> +	/* store all trace point data */
> +	point->type = type;
> +	point->flags = local_test_iflag_hw(flags) ? 0 : IPIPE_TFLG_HWIRQ_OFF;
> +	point->eip = eip;
> +	point->parent_eip = parent_eip;
> +	point->v = v;
> +	ipipe_read_tsc(point->timestamp);
> +
> +	/* forward to next point buffer */
> +	next_pos = WRAP_POINT_NO(pos+1);
> +	tp->trace_pos = next_pos;
> +
> +	/* only mark beginning if we haven't started yet */
> +	begin = tp->begin;
> +	if ((type == IPIPE_TRACE_BEGIN) && (begin < 0))
> +		tp->begin = pos;
> +
> +	/* skip END and FREEZE request during post-trace */
> +	if (!tp->post_trace) {
> +		/* end of critical path, start post-trace */
> +		if ((type == IPIPE_TRACE_END) && (begin >= 0))
> +			tp->post_trace = post_trace + 1;
> +
> +		/* freeze only if the slot is free */
> +		if ((type == IPIPE_TRACE_FREEZE) &&
> +		    (trace_paths[cpu_id][frozen_path[cpu_id]].begin < 0)) {
> +			tp->post_trace = post_trace + 1;
> +			tp->flags |= IPIPE_TFLG_FREEZING;
> +		}
> +	}
> +
> +	/* enforce end of trace in case of overflow */
> +	if (WRAP_POINT_NO(next_pos + 1) == begin)
> +		tp->post_trace = 1;
> +
> +	/* stop tracing this path if we are in post-trace and
> +	 *  a) that phase is over now or
> +	 *  b) a new TRACE_BEGIN came in but we are not freezing this path */
> +	if ((tp->post_trace > 0) && ((--tp->post_trace == 0) ||
> +	    ((type == IPIPE_TRACE_BEGIN) &&
> +	    !(tp->flags & IPIPE_TFLG_FREEZING)))) {
> +		/* store the path's end (i.e. excluding post-trace) */
> +		tp->end = WRAP_POINT_NO(pos - post_trace + tp->post_trace);
> +
> +		if (tp->flags & IPIPE_TFLG_FREEZING)
> +			tp = __ipipe_trace_freeze(cpu_id, tp, pos);
> +		else
> +			tp = __ipipe_trace_end(cpu_id, tp, pos);
> +
> +		/* reset the active path, maybe already start a new one */
> +		tp->begin = (type == IPIPE_TRACE_BEGIN) ?
> +			tp->trace_pos-1 : -1;
> +		tp->end = -1;
> +		tp->post_trace = 0;
> +
> +		/* update active_path not earlier to avoid races with NMIs */
> +		active_path[cpu_id] = tp - trace_paths[cpu_id];
> +	}
> +
> +	/* we still have old_tp and point,
> +	 * let's reset NMI lock and check for noise */
> +	old_tp->flags &= ~IPIPE_TFLG_NMI_LOCK;
> +	if (old_tp->flags & IPIPE_TFLG_NMI_HIT) {
> +		/* well, this late tagging may not immediately be visible for
> +		 * other cpus already dumping this path - a minor issue */
> +		point->flags |= IPIPE_TFLG_NMI_HIT;
> +	}
> +
> +	local_irq_restore_hw(flags);
> +}
> +
> +void notrace mcount(void);
> +EXPORT_SYMBOL(mcount);
> +
> +void notrace ipipe_trace_begin(unsigned long v)
> +{
> +	if (!ipipe_trace_enable)
> +		return;
> +	__ipipe_trace(IPIPE_TRACE_BEGIN, __CALLER_ADDR0, __CALLER_ADDR1, v);
> +}
> +EXPORT_SYMBOL(ipipe_trace_begin);
> +
> +void notrace ipipe_trace_end(unsigned long v)
> +{
> +	if (!ipipe_trace_enable)
> +		return;
> +	__ipipe_trace(IPIPE_TRACE_END, __CALLER_ADDR0, __CALLER_ADDR1, v);
> +}
> +EXPORT_SYMBOL(ipipe_trace_end);
> +
> +void notrace ipipe_trace_freeze(unsigned long v)
> +{
> +	if (!ipipe_trace_enable)
> +		return;
> +	__ipipe_trace(IPIPE_TRACE_FREEZE, __CALLER_ADDR0, __CALLER_ADDR1, v);
> +}
> +EXPORT_SYMBOL(ipipe_trace_freeze);
> +
> +void notrace ipipe_trace_special(unsigned char id, unsigned long v)
> +{
> +	if (!ipipe_trace_enable)
> +		return;
> +	__ipipe_trace(IPIPE_TRACE_SPECIAL + id, __CALLER_ADDR0,
> +	              __CALLER_ADDR1, v);
> +}
> +EXPORT_SYMBOL(ipipe_trace_special);
> +
> +
> +/* --- /proc output --- */
> +
> +static inline unsigned long ipipe_tsc2us(unsigned long long delta)
> +{
> +#ifdef CONFIG_X86
> +	do_div(delta, cpu_khz/1000+1);
> +#elif defined(CONFIG_PPC)
> +	delta = mulhwu(tb_to_us, delta);
> +#elif defined(CONFIG_ARM)
> +	delta = mach_cycles_to_usecs(delta);
> +#else
> +	#error Implement ipipe_tsc2us.
> +#endif

Ditto. Actually, recent ipipe patches implement ipipe_tsc2ns already.

>

-- 

Philippe.

