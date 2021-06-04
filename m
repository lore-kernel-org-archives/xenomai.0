References: <2098c9e4-4fb1-ef49-2c2d-d2c6573499b5@siemens.com>
 <87lf83cj7k.fsf@xenomai.org>
 <14ad027b-f326-5ea8-9cce-cb4b82984a23@siemens.com>
 <87y2c3b092.fsf@xenomai.org>
 <3bf57e72-9992-0ab4-a956-d6f6197bfe24@siemens.com>
 <87sg2bat1l.fsf@xenomai.org>
 <c4aad772-ea81-11e5-afd3-ff269c6b2899@siemens.com>
 <87o8czar20.fsf@xenomai.org>
 <c734a2e8-8ef0-bc48-f05e-5f96596eeca4@siemens.com>
 <87a6ohzjoi.fsf@xenomai.org>
 <1ea00a75-379d-3d7f-cb33-406f8188d38e@siemens.com>
 <87h7ighi8m.fsf@xenomai.org>
 <BN9PR11MB522775EA51C691A702208894F23B9@BN9PR11MB5227.namprd11.prod.outlook.com>
From: Philippe Gerum <rpm@xenomai.org>
Subject: Re: "rtdm/nrtsig: move inband work description off the stack"
In-reply-to: <BN9PR11MB522775EA51C691A702208894F23B9@BN9PR11MB5227.namprd11.prod.outlook.com>
Date: Fri, 04 Jun 2021 09:51:14 +0200
Message-ID: <871r9igj9p.fsf@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "Chen, Hongzhan" <hongzhan.chen@intel.com>
Cc: Jan Kiszka <jan.kiszka@siemens.com>, "xenomai@xenomai.org" <xenomai@xenomai.org>


Chen, Hongzhan <hongzhan.chen@intel.com> writes:

>>Jan Kiszka <jan.kiszka@siemens.com> writes:
>>
>>> On 26.05.21 15:52, Philippe Gerum wrote:
>>>> 
>>>> Jan Kiszka <jan.kiszka@siemens.com> writes:
>>>> 
>>>>> On 25.05.21 15:20, Philippe Gerum wrote:
>>>>>>
>>>>>> Jan Kiszka <jan.kiszka@siemens.com> writes:
>>>>>>
>>>>>>> On 25.05.21 14:37, Philippe Gerum wrote:
>>>>>>>>
>>>>>>>> Jan Kiszka <jan.kiszka@siemens.com> writes:
>>>>>>>>
>>>>>>>>> On 25.05.21 12:01, Philippe Gerum wrote:
>>>>>>>>>>
>>>>>>>>>> Jan Kiszka <jan.kiszka@siemens.com> writes:
>>>>>>>>>>
>>>>>>>>>>> On 25.05.21 10:46, Philippe Gerum wrote:
>>>>>>>>>>>>
>>>>>>>>>>>> Jan Kiszka <jan.kiszka@siemens.com> writes:
>>>>>>>>>>>>
>>>>>>>>>>>>> Hi Philippe,
>>>>>>>>>>>>>
>>>>>>>>>>>>> [1] makes rtdm_schedule_nrt_work a rather heavyweight service, compared
>>>>>>>>>>>>> to what it was (and even over I-pipe). xnmalloc is nothing you would
>>>>>>>>>>>>> expect from a "send a signal" service, specifically from
>>>>>>>>>>>>> rtdm_nrtsig_pend which does not even make use of the sending extra payload.
>>>>>>>>>>>>>
>>>>>>>>>>>>> Can we do better? Also for xnthread_signal (fd and udd usecases are not
>>>>>>>>>>>>> time-sensitive anyway).
>>>>>>>>>>>>>
>>>>>>>>>>>>
>>>>>>>>>>>> Nope, I cannot see any significantly better option which would still
>>>>>>>>>>>> allow a common implementation we can map on top of Dovetail / I-pipe.
>>>>>>>>>>>>
>>>>>>>>>>>
>>>>>>>>>>> E.g. pre-allocate the work object for data-free signals and use that -
>>>>>>>>>>> or not send it when it is in use, thus pending.
>>>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>> Ok, let's recap:
>>>>>>>>>>
>>>>>>>>>> - rtdm_nrtsig_pend(): does not allocate anything, merely uses a
>>>>>>>>>>   user-provided memory block, containing a request header. Current
>>>>>>>>>>   callers should either already care for not resending a request
>>>>>>>>>>   uselessly because it is pending (e.g. [1]), or their internal logic
>>>>>>>>>>   should prevent that (e.g. [2]). This interface always convey user data
>>>>>>>>>>   by reference.
>>>>>>>>>
>>>>>>>>> Ah, I fantasized that rtdm_nrtsig_pend would call rtdm_schedule_nrt_work
>>>>>>>>> to do the work, it's the other way around. False alarm here.
>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>> - rtdm_schedule_nrt_work(): does allocate a nrtsig_t struct in order to
>>>>>>>>>>   convey a request block we cannot squeeze into a work_struct, since the
>>>>>>>>>>   latter is in itself an anchor type the user may embed into its own
>>>>>>>>>>   private argument block. I'm unsure ensuring that
>>>>>>>>>>   rtdm_schedule_nrt_work() calls do not pile up would be worth it, as
>>>>>>>>>>   this call is not supposed to be used frenetically on some hot path in
>>>>>>>>>>   the first place. But if we'd want to do that, then we would have to
>>>>>>>>>>   change the signature of rtdm_schedule_nrt_work(), so that we gain a
>>>>>>>>>>   persistent context data we could use for determining whether a nrt
>>>>>>>>>>   work request is in flight. We could not probe the work_struct for that
>>>>>>>>>>   purpose, that would be racy.
>>>>>>>>>>
>>>>>>>>>> Do you see any way to have a smarter rtdm_schedule_nrt_work() without
>>>>>>>>>> changing its signature?
>>>>>>>>>
>>>>>>>>> There is no rule that prevents changing the signature if that is needed.
>>>>>>>>> However, the kernel is fine without allocation as well, using a very
>>>>>>>>> similar signature.
>>>>>>>>>
>>>>>>>>
>>>>>>>> schedule_work() and rtdm_schedule_nrt_work() have a major difference:
>>>>>>>> the latter has to pass on the request from the oob to the in-band
>>>>>>>> context. This is what bugs us and creates the requirement for additional
>>>>>>>> mechanism and data.
>>>>>>>>
>>>>>>>>> I do not yet understand way we need that indirection via the rtdm_nrtsig
>>>>>>>>> on Dovetail. I thought we can trigger work directly from the oob domain
>>>>>>>>> there, can't we? How do you handle such a case in evl so far?
>>>>>>>>>
>>>>>>>>
>>>>>>>> Dovetail can trigger in-band work from oob via the generic irq_work()
>>>>>>>> service, we don't need the extra code involved in the I-pipe for the
>>>>>>>> same purpose. The gist of the matter is about having the same
>>>>>>>> implementation for rtdm_schedule_nrt_work() which works in both Dovetail
>>>>>>>> and I-pipe contexts: the way we do that is by using rtdm_nrtsig_pend()
>>>>>>>> which already abstracts the base mechanism for relaying oob -> in-band
>>>>>>>> signals.
>>>>>>>>
>>>>>>>> On the other hand, EVL has the evl_call_inband[_from]() service, which
>>>>>>>> combines the irq_work and work_struct anchors we need into a single
>>>>>>>> evl_work type, which in turn can be embedded into a user request
>>>>>>>> block. This is what rtdm_schedule_nrt_work() does not expose, so it has
>>>>>>>> to build one internally by combining a dynamic allocation and the
>>>>>>>> user-provided work_struct.
>>>>>>>>
>>>>>>>
>>>>>>> Then enhance the rtdm service to enable such a combination - and be even
>>>>>>> more ready for the switch to Xenomai 4, I would say. We can either add a
>>>>>>> new service and deprecate the old one (while implementing it as you
>>>>>>> suggest) or just break the interface to get the (presumably) few users
>>>>>>> quickly converted.
>>>>>>>
>>>>>>
>>>>>> rtdm_schedule_nrt_work() was added by Gilles when merging the RTnet code
>>>>>> into Xenomai 3 IIRC, with little documentation. Widespread usage of this
>>>>>> call is unlikely, so I'd vote for simplifying the whole thing and
>>>>>> replace it entirely.
>>>>>>
>>>>>
>>>>> OK, then we have a plan for this piece.
>
> Do we  need to implement new API to replace rtdm_schedule_nrt_work() to avoid call xnmalloc 
> or just keep it as it is in Xenomai 3.2 ?
>
>>>>>
>>>>>>>>> And the third case remains xnthread_signal, btw.
>>>>>>>>>
>>>>>>>>
>>>>>>>> xnthread_signal() is used to trigger SIGDEBUG/SIGSHADOW/SIGTERM signals
>>>>>>>> for a thread, a seldom event. Optimizing there would be overkill, unless
>>>>>>>> the application behaves wrongly in the first place.
>>>>>>>
>>>>>>> Some caller are under nklock, thus it makes potentially lengthy critical
>>>>>>> sections now a bit longer.
>>>>>>>
>>>>>>
>>>>>> This is what needs to be fixed in the first place, we should not trigger
>>>>>> a signal relay when holding the ugly big lock.
>
> Which functions we need to fix or do optimization to avoid calling xnthread_signal when holding
> big lock if possible? xnthread_suspend and xnthread_cancel?  
>
>>>>>>
>>>>>
>>>>> Whatever is simpler.
>>>>>
>>>>> Another aspect: Using xnmalloc for anything that should better succeed
>>>>> is possibly not good when we are OOM. That is actually no strict
>>>>> regression over I-pipe where we had a limited queue as well IIRC but a
>>>>> reason to avoid carrying that over - and possibly creating new error
>>>>> scenarios that are harder to debug.
>>>>>
>>>> 
>>>> To mitigate the issue of generalized OOM, we could pull memory from a
>>>> local xnheap privately attached to xnthread_signal() along with any
>>>> caller requiring dynamic allocation, so that none of them could deplete
>>>> the sysheap.
>>>> 
>>>> Getting rid of dynamic allocation entirely on the other hand would
>>>> require us to add one or more "signal slots" per possible cause of
>>>> in-band signal into struct xnthread (e.g. SIGSHADOW_ACTION_BACKTRACE,
>>>> SIGDEBUG_MIGRATE_SIGNAL etc), passing the proper slot to
>>>> xnthread_signal(). SIGSHADOW(SIGWINCH) and SIGDEBUG(SIGXCPU) are
>>>> standard non-queueable signals, so we should only need a single slot per
>>>> signal cause.
>>>> 
>>>
>>> Can a thread actually trigger multiple causes per SIGDEBUG, e.g.?
>>> Likely, we only need to carry the single cause via a field in xnthread
>>> from the trigger point to the in-band handler. The same is probably the
>>> case for SIGSHADOW_ACTION_BACKTRACE.
>>>
>>
>>Multiple events triggering SIGSHADOW_ACTION_HOME and
>>SIGSHADOW_ACTION_HARDEN _might_ pile up, although unlikely.
>
> Does that means that in struct xnthread there should be three slots of
> struct lostage_signal to handle each of SIGDEBUG/SIGSHADOW/SIGTERM
> like patch [1]?
>
>  If there is no pile up for each signal , we would just allocate fixed position 
> for three signals in the array and then handle corresponding  lostage_signal 
>  by signo. Is it enough?
>
> [1]:
>
> +++ b/include/cobalt/kernel/thread.h
> @@ -51,6 +51,15 @@ struct xnsched_tpslot;
>  struct xnthread_personality;
>  struct completion;
>
> +#define XENO_MUM_SIGNALS 3 /*SIGDEBUG/SIGSHADOW/SIGTERM */
> +
> +struct lostage_signal {
> +       struct pipeline_inband_work inband_work; /* Must be first. */
> +       struct task_struct *task;
> +       int signo, sigval;
> +       struct lostage_signal *self; /* Revisit: I-pipe requirement */
> +};
> +
>  struct xnthread_init_attr {
>         struct xnthread_personality *personality;
>         cpumask_t affinity;
> @@ -205,6 +214,7 @@ struct xnthread {
>         const char *exe_path;   /* Executable path */
>         u32 proghash;           /* Hash value for exe_path */
>  #endif
> +       struct lostage_signal sigarray[XENO_MUM_SIGNALS];
>  };
>

I would have as many entries than we have distinct reasons for notifying
the application. i.e. include/cobalt/uapi/signal.h:

#define SIGSHADOW_ACTION_HARDEN		1
#define SIGSHADOW_ACTION_BACKTRACE	2
#define SIGSHADOW_ACTION_HOME		3
#define SIGDEBUG_MIGRATE_SIGNAL		1
#define SIGDEBUG_MIGRATE_SYSCALL	2
#define SIGDEBUG_MIGRATE_FAULT		3
#define SIGDEBUG_MIGRATE_PRIOINV	4
#define SIGDEBUG_NOMLOCK		5
#define SIGDEBUG_WATCHDOG		6
#define SIGDEBUG_RESCNT_IMBALANCE	7
#define SIGDEBUG_LOCK_BREAK		8
#define SIGDEBUG_MUTEX_SLEEP		9

plus, a dedicated entry for sending SIGTERM.

The reason is that we may have some combinations in which events may be
set pending concurrently for a given task
e.g. SIGSHADOW_ACTION_BACKTRACE _and_ any of SIGDEBUG_MIGRATE_*.

The irq_work interface Dovetail uses allows us to have multiple pending
events, as long as they are represented by distinct work structs (hence
the requirement to have a dedicated inband_work struct per event
type). Likewise, the I-pipe allows multiple events to be set pending by
logging each event into an internal buffer for later delivery to the
notified task.

Now the question is: what about a particular event being notified
multiple times in a series by the core before userland had a chance to
receive the first notification? Could we, or would it matter if we only
receive a single notification for a series of identical events?  e.g.
SIGDEBUG_MIGRATE_SYSCALL x 2, leading to the second one to be ignored as
already pending.

This case should never happen for any cause which is paired with a
transition from oob -> in-band context like SIGDEBUG_MIGRATE_*, by
design. Some causes even filter out multiple triggers explicitly, such
as SIGDEBUG_MUTEX_SLEEP. Other actions are idempotent
(e.g. SIGSHADOW_ACTION_HARDEN, _HOME).

-- 
Philippe.

