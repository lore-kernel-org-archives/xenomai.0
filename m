Subject: Re: [PATCH] cobalt/posix/process: pipeline: abstract kernel event
 handlers
References: <20201217180246.48589-1-rpm@xenomai.org>
 <8a3259f5-507d-0c8f-ae06-7ad5613e6f88@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <a1f5a95b-aed6-5bd8-c002-72d2646e4d2f@siemens.com>
Date: Thu, 7 Jan 2021 19:27:54 +0100
MIME-Version: 1.0
In-Reply-To: <8a3259f5-507d-0c8f-ae06-7ad5613e6f88@siemens.com>
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
To: Philippe Gerum <rpm@xenomai.org>, xenomai@xenomai.org

On 07.01.21 18:56, Jan Kiszka via Xenomai wrote:
> On 17.12.20 19:02, Philippe Gerum wrote:
>> From: Philippe Gerum <rpm@xenomai.org>
>>
>> Although there are significant commonalities between the I-pipe and
>> Dovetail when it comes to dealing with synchronous kernel events,
>> there is no strict 1:1 mapping between the two kernel interfaces.
>>
>> As an initial step, move all the code handling the kernel events to
>> the I-pipe section. We may exploit commonalities between the I-pipe
>> and Dovetail in this area as we gradually merge support for the
>> latter.
>>
>> No functional change is introduced.
>>
>> Signed-off-by: Philippe Gerum <rpm@xenomai.org>
>> ---
>>  .../cobalt/kernel/ipipe/pipeline/kevents.h    |  31 +
>>  kernel/cobalt/ipipe/Makefile                  |   4 +-
>>  kernel/cobalt/ipipe/kevents.c                 | 860 ++++++++++++++++++
>>  kernel/cobalt/posix/process.c                 | 846 +----------------
>>  kernel/cobalt/posix/process.h                 |   4 +
>>  kernel/cobalt/posix/signal.c                  |   5 +
>>  kernel/cobalt/posix/signal.h                  |   2 +
>>  kernel/cobalt/thread.c                        |   4 +-
>>  kernel/cobalt/trace/cobalt-core.h             |  12 +-
>>  9 files changed, 930 insertions(+), 838 deletions(-)
>>  create mode 100644 include/cobalt/kernel/ipipe/pipeline/kevents.h
>>  create mode 100644 kernel/cobalt/ipipe/kevents.c
>>
>> diff --git a/include/cobalt/kernel/ipipe/pipeline/kevents.h b/include/cobalt/kernel/ipipe/pipeline/kevents.h
>> new file mode 100644
>> index 000000000..30425a96b
>> --- /dev/null
>> +++ b/include/cobalt/kernel/ipipe/pipeline/kevents.h
>> @@ -0,0 +1,31 @@
>> +/*
>> + * SPDX-License-Identifier: GPL-2.0
>> + *
>> + * Copyright (C) 2019 Philippe Gerum  <rpm@xenomai.org>
>> + */
>> +
>> +#ifndef _COBALT_KERNEL_IPIPE_KEVENTS_H
>> +#define _COBALT_KERNEL_IPIPE_KEVENTS_H
>> +
>> +struct cobalt_process;
>> +struct cobalt_thread;
>> +
>> +static inline
>> +int pipeline_attach_process(struct cobalt_process *process)
>> +{
>> +	return 0;
>> +}
>> +
>> +static inline
>> +void pipeline_detach_process(struct cobalt_process *process)
>> +{ }
>> +
>> +int pipeline_prepare_current(void);
>> +
>> +void pipeline_attach_current(struct xnthread *thread);
>> +
>> +int pipeline_trap_kevents(void);
>> +
>> +void pipeline_enable_kevents(void);
>> +
>> +#endif /* !_COBALT_KERNEL_IPIPE_KEVENTS_H */
>> diff --git a/kernel/cobalt/ipipe/Makefile b/kernel/cobalt/ipipe/Makefile
>> index 6021008fb..5170bb32b 100644
>> --- a/kernel/cobalt/ipipe/Makefile
>> +++ b/kernel/cobalt/ipipe/Makefile
>> @@ -1,3 +1,5 @@
>> +ccflags-y += -Ikernel
>> +
>>  obj-y +=	pipeline.o
>>  
>> -pipeline-y :=	init.o intr.o
>> +pipeline-y :=	init.o intr.o kevents.o
>> diff --git a/kernel/cobalt/ipipe/kevents.c b/kernel/cobalt/ipipe/kevents.c
>> new file mode 100644
>> index 000000000..ba584677c
>> --- /dev/null
>> +++ b/kernel/cobalt/ipipe/kevents.c
>> @@ -0,0 +1,860 @@
>> +/*
>> + * SPDX-License-Identifier: GPL-2.0
>> + *
>> + * Copyright (C) 2001-2014 Philippe Gerum <rpm@xenomai.org>.
>> + * Copyright (C) 2001-2014 The Xenomai project <http://www.xenomai.org>
>> + * Copyright (C) 2006 Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
>> + *
>> + * SMP support Copyright (C) 2004 The HYADES project <http://www.hyades-itea.org>
>> + * RTAI/fusion Copyright (C) 2004 The RTAI project <http://www.rtai.org>
>> + */
>> +
>> +#include <linux/ipipe.h>
>> +#include <linux/ipipe_tickdev.h>
>> +#include <linux/ptrace.h>
>> +#include <pipeline/kevents.h>
>> +#include <cobalt/kernel/sched.h>
>> +#include <cobalt/kernel/thread.h>
>> +#include <cobalt/kernel/vdso.h>
>> +#include <rtdm/driver.h>
>> +#include <trace/events/cobalt-core.h>
>> +#include "../posix/process.h"
>> +#include "../posix/thread.h"
>> +#include "../posix/memory.h"
>> +
>> +static void detach_current(void);
>> +
>> +static inline struct cobalt_process *
>> +process_from_thread(struct xnthread *thread)
>> +{
>> +	return container_of(thread, struct cobalt_thread, threadbase)->process;
>> +}
>> +
>> +#ifdef IPIPE_KEVT_PTRESUME
>> +
>> +static void stop_debugged_process(struct xnthread *thread)
>> +{
>> +	struct cobalt_process *process = process_from_thread(thread);
>> +	struct cobalt_thread *cth;
>> +
>> +	if (process->debugged_threads > 0)
>> +		return;
>> +
>> +	list_for_each_entry(cth, &process->thread_list, next) {
>> +		if (&cth->threadbase == thread)
>> +			continue;
>> +
>> +		xnthread_suspend(&cth->threadbase, XNDBGSTOP, XN_INFINITE,
>> +				 XN_RELATIVE, NULL);
>> +	}
>> +}
>> +
>> +static void resume_debugged_process(struct cobalt_process *process)
>> +{
>> +	struct cobalt_thread *cth;
>> +
>> +	xnsched_lock();
>> +
>> +	list_for_each_entry(cth, &process->thread_list, next)
>> +		if (xnthread_test_state(&cth->threadbase, XNDBGSTOP))
>> +			xnthread_resume(&cth->threadbase, XNDBGSTOP);
>> +
>> +	xnsched_unlock();
>> +}
>> +
>> +#else /* !IPIPE_KEVT_PTRESUME */
>> +
>> +static inline void stop_debugged_process(struct xnthread *thread)
>> +{
>> +}
>> +
>> +static inline void resume_debugged_process(struct cobalt_process *process)
>> +{
>> +}
>> +
>> +#endif /* !IPIPE_KEVT_PTRESUME */
>> +
>> +/* called with nklock held */
>> +static void register_debugged_thread(struct xnthread *thread)
>> +{
>> +	struct cobalt_process *process = process_from_thread(thread);
>> +
>> +	xnthread_set_state(thread, XNSSTEP);
>> +
>> +	stop_debugged_process(thread);
>> +	process->debugged_threads++;
>> +
>> +	if (xnthread_test_state(thread, XNRELAX))
>> +		xnthread_suspend(thread, XNDBGSTOP, XN_INFINITE, XN_RELATIVE,
>> +				 NULL);
>> +}
>> +
>> +/* called with nklock held */
>> +static void unregister_debugged_thread(struct xnthread *thread)
>> +{
>> +	struct cobalt_process *process = process_from_thread(thread);
>> +
>> +	process->debugged_threads--;
>> +	xnthread_clear_state(thread, XNSSTEP);
>> +
>> +	if (process->debugged_threads == 0)
>> +		resume_debugged_process(process);
>> +}
>> +
>> +static inline int handle_exception(struct ipipe_trap_data *d)
>> +{
>> +	struct xnthread *thread;
>> +	struct xnsched *sched;
>> +
>> +	sched = xnsched_current();
>> +	thread = sched->curr;
>> +
>> +	trace_cobalt_thread_fault(xnarch_fault_pc(d),
>> +				  xnarch_fault_trap(d));
>> +
>> +	if (xnthread_test_state(thread, XNROOT))
>> +		return 0;
>> +
>> +#ifdef IPIPE_KEVT_USERINTRET
>> +	if (xnarch_fault_bp_p(d) && user_mode(d->regs)) {
>> +		spl_t s;
>> +
>> +		XENO_WARN_ON(CORE, xnthread_test_state(thread, XNRELAX));
>> +		xnlock_get_irqsave(&nklock, s);
>> +		xnthread_set_info(thread, XNCONTHI);
>> +		ipipe_enable_user_intret_notifier();
>> +		stop_debugged_process(thread);
>> +		xnlock_put_irqrestore(&nklock, s);
>> +		xnsched_run();
>> +	}
>> +#endif
>> +
>> +	if (xnarch_fault_fpu_p(d)) {
>> +#ifdef CONFIG_XENO_ARCH_FPU
>> +		spl_t s;
>> +
>> +		/* FPU exception received in primary mode. */
>> +		splhigh(s);
>> +		if (xnarch_handle_fpu_fault(sched->fpuholder, thread, d)) {
>> +			sched->fpuholder = thread;
>> +			splexit(s);
>> +			return 1;
>> +		}
>> +		splexit(s);
>> +#endif /* CONFIG_XENO_ARCH_FPU */
>> +#if LINUX_VERSION_CODE >= KERNEL_VERSION(4, 16, 0)

Inverted logic? Build is broken for 4.14 and older.

Jan

>> +		printk("invalid use of FPU in Xenomai context at %pS\n",
>> +		       (void *)xnarch_fault_pc(d));
>> +#else
>> +		print_symbol("invalid use of FPU in Xenomai context at %s\n",
>> +			     xnarch_fault_pc(d));
>> +#endif
-- 
Siemens AG, T RDA IOT
Corporate Competence Center Embedded Linux

