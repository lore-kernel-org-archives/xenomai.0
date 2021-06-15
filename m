Subject: Re: [[next]PATCH v2] cobalt/thread: move inband work descriptions off
 the stack
References: <20210610021438.8004-1-hongzhan.chen@intel.com>
 <69a56c2c-dbed-e665-e5cb-26be63f67595@siemens.com>
 <BN9PR11MB522777296CD7B9F7082EEAE7F2309@BN9PR11MB5227.namprd11.prod.outlook.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <79150e26-91bf-2cfd-7801-c8c75ea35096@siemens.com>
Date: Tue, 15 Jun 2021 08:42:52 +0200
MIME-Version: 1.0
In-Reply-To: <BN9PR11MB522777296CD7B9F7082EEAE7F2309@BN9PR11MB5227.namprd11.prod.outlook.com>
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
To: "Chen, Hongzhan" <hongzhan.chen@intel.com>, "xenomai@xenomai.org" <xenomai@xenomai.org>

On 15.06.21 04:21, Chen, Hongzhan wrote:
> 
> 
>> -----Original Message-----
>> From: Jan Kiszka <jan.kiszka@siemens.com> 
>> Sent: Thursday, June 10, 2021 11:42 PM
>> To: Chen, Hongzhan <hongzhan.chen@intel.com>; xenomai@xenomai.org
>> Subject: Re: [[next]PATCH v2] cobalt/thread: move inband work descriptions off the stack
>>
>> On 10.06.21 04:14, Hongzhan Chen via Xenomai wrote:
>>> Unlike the I-pipe, Dovetail does not copy the work descriptor but
>>> merely hands over the request to the common irq_work() mechanism. We
>>> must guarantee that such descriptor lives in a portion of memory which
>>> won't go stale until the handler has run, which by design can only
>>> happen once the calling out-of-band context unwinds.
>>>
>>> Therefore, we have to add one or more "signal slots" per possible
>>> cause of in-band signal into this thread's control block.
>>>
>>> For SIGDEBUG, except SIGDEBUG_WATCHDOG all other SIGDEBUG_* cause
>>> including SIGDEBUG_MIGRATE_SIGNAL, SIGDEBUG_MIGRATE_SYSCALL,
>>> SIGDEBUG_MIGRATE_FAULT, SIGDEBUG_MIGRATE_PRIOINV, SIGDEBUG_NOMLOCK,
>>> SIGDEBUG_RESCNT_IMBALANCE, SIGDEBUG_LOCK_BREAK, SIGDEBUG_MUTEX_SLEEP
>>> are synchronous and mutually exclusive due to the oob->in-band transition.
>>> But SIGDEBUG_WATCHDOG is triggered asynchronously by the oob timer.
>>>
>>> All SIGSHADOW_* events need their own slot: SIGSHADOW_ACTION_HARDEN and
>>> SIGSHADOW_ACTION_HOME can be raised by remote threads asynchronously to
>>> the target thread. SIGSHADOW_ACTION_BACKTRACE comes in addition to
>>> SIGDEBUG_MIGRATE_*. For the latter reason, SIGSHADOW_ACTION_BACKTRACE
>>> cannot pile up though.
>>>
>>> Including SIGTERM, we have totally 6 slots.
>>>
>>> Signed-off-by: Hongzhan Chen <hongzhan.chen@intel.com>
>>>
>>> diff --git a/include/cobalt/kernel/thread.h b/include/cobalt/kernel/thread.h
>>> index c92037bfe..0c5eacda7 100644
>>> --- a/include/cobalt/kernel/thread.h
>>> +++ b/include/cobalt/kernel/thread.h
>>> @@ -23,6 +23,7 @@
>>>  #include <linux/sched.h>
>>>  #include <linux/sched/rt.h>
>>>  #include <pipeline/thread.h>
>>> +#include <pipeline/inband_work.h>
>>>  #include <cobalt/kernel/list.h>
>>>  #include <cobalt/kernel/stat.h>
>>>  #include <cobalt/kernel/timer.h>
>>> @@ -42,6 +43,14 @@
>>>  #define XNTHREAD_BLOCK_BITS   (XNSUSP|XNPEND|XNDELAY|XNDORMANT|XNRELAX|XNHELD|XNDBGSTOP)
>>>  #define XNTHREAD_MODE_BITS    (XNRRB|XNWARN|XNTRAPLB)
>>>  
>>> +#define XNTHREAD_SIGNALS_NUM           6
>>
>> Better put at the end.
>>
>>> +#define XNTHREAD_SIGDEBUG_NONWATCHDOG  0
>>> +#define XNTHREAD_SIGDEBUG_WATCHDOD     1
>>> +#define XNTHREAD_SIGSHADOW_HARDEN      2
>>> +#define XNTHREAD_SIGSHADOW_BACKTRACE   3
>>> +#define XNTHREAD_SIGSHADOW_HOME        4
>>> +#define XNTHREAD_SIGTERM               5
>>
>> How about
>>
>> XNSIGSLOT_...
>> XNSIGSLOT_NUM	6
>>
>> ?
>>
>>> +
>>>  struct xnthread;
>>>  struct xnsched;
>>>  struct xnselector;
>>> @@ -50,6 +59,13 @@ struct xnsched_tpslot;
>>>  struct xnthread_personality;
>>>  struct completion;
>>>  
>>> +struct lostage_signal {
>>> +	struct pipeline_inband_work inband_work; /* Must be first. */
>>> +	struct task_struct *task;
>>> +	int signo, sigval;
>>> +	struct lostage_signal *self; /* Revisit: I-pipe requirement */
>>> +};
>>> +
>>>  struct xnthread_init_attr {
>>>  	struct xnthread_personality *personality;
>>>  	cpumask_t affinity;
>>> @@ -199,6 +215,29 @@ struct xnthread {
>>>  	const char *exe_path;	/* Executable path */
>>>  	u32 proghash;		/* Hash value for exe_path */
>>>  #endif
>>> +	/*
>>> +	 * Each slot handle different cause of signal
>>> +	 * slot 0:
>>> +	 *	SIGDEBUG_MIGRATE_SIGNAL
>>> +	 *	SIGDEBUG_MIGRATE_SYSCALL
>>> +	 *	SIGDEBUG_MIGRATE_FAULT
>>> +	 *	SIGDEBUG_MIGRATE_PRIOINV
>>> +	 *	SIGDEBUG_NOMLOCK
>>> +	 *	SIGDEBUG_RESCNT_IMBALANCE
>>> +	 *	SIGDEBUG_LOCK_BREAK
>>> +	 *	SIGDEBUG_MUTEX_SLEEP
>>> +	 * slot 1:
>>> +	 *	SIGDEBUG_WATCHDOG
>>> +	 * slot 2:
>>> +	 *	SIGSHADOW_ACTION_HARDEN
>>> +	 * slot 3:
>>> +	 *	SIGSHADOW_ACTION_BACKTRACE
>>> +	 * slot 4:
>>> +	 *	SIGSHADOW_ACTION_HOME
>>> +	 * slot 5:
>>> +	 *	SIGTERM
>>> +	 */
>>> +	struct lostage_signal sigarray[XNTHREAD_SIGNALS_NUM];
>>>  };
>>>  
>>>  static inline int xnthread_get_state(const struct xnthread *thread)
>>> diff --git a/kernel/cobalt/thread.c b/kernel/cobalt/thread.c
>>> index d3a827eaa..d180aa85c 100644
>>> --- a/kernel/cobalt/thread.c
>>> +++ b/kernel/cobalt/thread.c
>>> @@ -2083,12 +2083,6 @@ void xnthread_relax(int notify, int reason)
>>>  }
>>>  EXPORT_SYMBOL_GPL(xnthread_relax);
>>>  
>>> -struct lostage_signal {
>>> -	struct pipeline_inband_work inband_work; /* Must be first. */
>>> -	struct task_struct *task;
>>> -	int signo, sigval;
>>> -};
>>> -
>>>  static inline void do_kthread_signal(struct task_struct *p,
>>>  				     struct xnthread *thread,
>>>  				     struct lostage_signal *rq)
>>> @@ -2112,7 +2106,7 @@ static void lostage_task_signal(struct pipeline_inband_work *inband_work)
>>>  	thread = xnthread_from_task(p);
>>>  	if (thread && !xnthread_test_state(thread, XNUSER)) {
>>>  		do_kthread_signal(p, thread, rq);
>>> -		return;
>>> +		goto out;
>>>  	}
>>>  
>>>  	signo = rq->signo;
>>> @@ -2127,6 +2121,8 @@ static void lostage_task_signal(struct pipeline_inband_work *inband_work)
>>>  		send_sig_info(signo, &si, p);
>>>  	} else
>>>  		send_sig(signo, p, 1);
>>> +out:
>>> +	memset(rq->self, 0, sizeof(*rq));
>>
>> "rq->self->self = NULL" would suffice, I suppose - but it reads even
>> more weirdly.
>>
>> I missed that on 96d70658a589: We should document what the exact I-pipe
>> requirement is here. And that is that the lostage handler will be called
>> with a pointer to a copy of that work item under I-pipe, not the
>> original one. That is only referenced by self. Had to think about that
>> again myself.
>>
>>>  }
>>>  
>>>  static int force_wakeup(struct xnthread *thread) /* nklock locked, irqs off */
>>> @@ -2288,19 +2284,77 @@ void xnthread_demote(struct xnthread *thread)
>>>  }
>>>  EXPORT_SYMBOL_GPL(xnthread_demote);
>>>  
>>> +static int get_slot_index_from_sig(int sig, int arg)
>>> +{
>>> +	int action;
>>> +
>>> +	switch (sig) {
>>> +	case SIGDEBUG:
>>> +		switch (arg) {
>>> +		case SIGDEBUG_WATCHDOG:
>>> +			return XNTHREAD_SIGDEBUG_WATCHDOD;
>>> +		case SIGDEBUG_MIGRATE_SIGNAL:
>>> +		case SIGDEBUG_MIGRATE_SYSCALL:
>>> +		case SIGDEBUG_MIGRATE_FAULT:
>>> +		case SIGDEBUG_MIGRATE_PRIOINV:
>>> +		case SIGDEBUG_NOMLOCK:
>>> +		case SIGDEBUG_RESCNT_IMBALANCE:
>>> +		case SIGDEBUG_LOCK_BREAK:
>>> +		case SIGDEBUG_MUTEX_SLEEP:
>>> +			return XNTHREAD_SIGDEBUG_NONWATCHDOG;
>>> +		}
>>> +		break;
>>> +	case SIGSHADOW:
>>> +		action = sigshadow_action(arg);
>>> +		switch (action) {
>>> +		case SIGSHADOW_ACTION_HARDEN:
>>> +			return XNTHREAD_SIGSHADOW_HARDEN;
>>> +		case SIGSHADOW_ACTION_BACKTRACE:
>>> +			return XNTHREAD_SIGSHADOW_BACKTRACE;
>>> +		case SIGSHADOW_ACTION_HOME:
>>> +			return XNTHREAD_SIGSHADOW_HOME;
>>> +		}
>>> +		break;
>>> +	case SIGTERM:
>>> +		return XNTHREAD_SIGTERM;
>>> +	}
>>> +
>>> +	return -1;
>>> +}
>>> +
>>>  void xnthread_signal(struct xnthread *thread, int sig, int arg)
>>>  {
>>> -	struct lostage_signal sigwork = {
>>> -		.inband_work = PIPELINE_INBAND_WORK_INITIALIZER(sigwork,
>>> -					lostage_task_signal),
>>> -		.task = xnthread_host_task(thread),
>>> -		.signo = sig,
>>> -		.sigval = sig == SIGDEBUG ? arg | sigdebug_marker : arg,
>>> -	};
>>> +	struct lostage_signal *sigwork;
>>> +	int slot;
>>> +
>>> +	slot = get_slot_index_from_sig(sig, arg);
>>> +
>>> +	if (WARN_ON(slot < 0))
>>> +		return;
>>> +
>>> +	sigwork = &thread->sigarray[slot];
>>> +
>>> +	/* To avoid invalidating the already submitted event
>>> +	 * if previous submitted has not been handled as we expected
>>> +	 * because setting sigwork->self zero is final step
>>> +	 * in handling sig.
>>> +	 */
>>> +	if (WARN_ON((sigwork->self != NULL) &&
>>
>> So, we are still assuming that multiple signals for the same slot should
>> be a bug? I'm not sure it is. I'm also not sure that sender and lostage
>> handler will always be on the same CPU. Look at
>> __xnthread_set_schedparam. It's "xnthread_signal(thread, SIGSHADOW,
>> SIGSHADOW_ACTION_HOME)" in xnthread_suspend() can run on any CPU,
>> targeting any thread on some other CPU, and that possibly multiple times.
>>
>> I'm afraid we need nklock around enqueue and dequeue so that we neither
>> lose a signal nor warn needlessly.
> 
> I thought there might be multiple signals pile up here but actually this warn never
> happen according to my test with smokey sigdebug test item after applying the patch.
> 
>>
>>> +				(sigwork->self == sigwork))) {
>>
>> What case is this part of the test excluding?
> 
> Because we have not initted them after xnthread is allocated, some data might not be empty I guess at the first time of using
> according to my test . That was why I said I found duplicate signal case  in previous thread when I did not add it but actually it was not
> multiple signals case causing return.
> If signal can be queued , it is quite different than what we had discussed.  Actually I do not know in which case multiple signals
> would pile up here after splitting into slots. At least , I cannot reproduce multiple singles pile up issue with sigdebug test item.
> If we consider queue to avoid losing signals for multiple signal in same slot , how can we decide the size of queue for each slot?
> Sorry for late response, I was taking AL.
> 

No problem. Please have a look what is meanwhile in master, review it,
stress it, and if you see issues that we missed, please speak up. It's
not queuing, it's first-come-first-serve.

Jan

-- 
Siemens AG, T RDA IOT
Corporate Competence Center Embedded Linux

