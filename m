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
 <871r9igj9p.fsf@xenomai.org>
 <955096e4-be49-7630-b6c9-465529cf79f8@siemens.com>
 <87y2bqf3lj.fsf@xenomai.org>
 <e38c772c-b925-53fb-92ac-f264969a35c8@siemens.com>
From: Philippe Gerum <rpm@xenomai.org>
Subject: Re: "rtdm/nrtsig: move inband work description off the stack"
In-reply-to: <e38c772c-b925-53fb-92ac-f264969a35c8@siemens.com>
Date: Fri, 04 Jun 2021 14:53:20 +0200
Message-ID: <87r1hhg5a7.fsf@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: "Chen, Hongzhan" <hongzhan.chen@intel.com>, "xenomai@xenomai.org" <xenomai@xenomai.org>


Jan Kiszka <jan.kiszka@siemens.com> writes:

> On 04.06.21 10:15, Philippe Gerum wrote:
>>=20
>> Jan Kiszka <jan.kiszka@siemens.com> writes:
>>=20
>>> On 04.06.21 09:51, Philippe Gerum wrote:
>>>>
>>>> Chen, Hongzhan <hongzhan.chen@intel.com> writes:
>>>>
>>>>>> Jan Kiszka <jan.kiszka@siemens.com> writes:
>>>>>>
>>>>>>> On 26.05.21 15:52, Philippe Gerum wrote:
>>>>>>>>
>>>>>>>> Jan Kiszka <jan.kiszka@siemens.com> writes:
>>>>>>>>
>>>>>>>>> On 25.05.21 15:20, Philippe Gerum wrote:
>>>>>>>>>>
>>>>>>>>>> Jan Kiszka <jan.kiszka@siemens.com> writes:
>>>>>>>>>>
>>>>>>>>>>> On 25.05.21 14:37, Philippe Gerum wrote:
>>>>>>>>>>>>
>>>>>>>>>>>> Jan Kiszka <jan.kiszka@siemens.com> writes:
>>>>>>>>>>>>
>>>>>>>>>>>>> On 25.05.21 12:01, Philippe Gerum wrote:
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> Jan Kiszka <jan.kiszka@siemens.com> writes:
>>>>>>>>>>>>>>
>>>>>>>>>>>>>>> On 25.05.21 10:46, Philippe Gerum wrote:
>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>> Jan Kiszka <jan.kiszka@siemens.com> writes:
>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>> Hi Philippe,
>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>> [1] makes rtdm_schedule_nrt_work a rather heavyweight ser=
vice, compared
>>>>>>>>>>>>>>>>> to what it was (and even over I-pipe). xnmalloc is nothin=
g you would
>>>>>>>>>>>>>>>>> expect from a "send a signal" service, specifically from
>>>>>>>>>>>>>>>>> rtdm_nrtsig_pend which does not even make use of the send=
ing extra payload.
>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>> Can we do better? Also for xnthread_signal (fd and udd us=
ecases are not
>>>>>>>>>>>>>>>>> time-sensitive anyway).
>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>> Nope, I cannot see any significantly better option which w=
ould still
>>>>>>>>>>>>>>>> allow a common implementation we can map on top of Dovetai=
l / I-pipe.
>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>> E.g. pre-allocate the work object for data-free signals and=
 use that -
>>>>>>>>>>>>>>> or not send it when it is in use, thus pending.
>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> Ok, let's recap:
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> - rtdm_nrtsig_pend(): does not allocate anything, merely use=
s a
>>>>>>>>>>>>>>   user-provided memory block, containing a request header. C=
urrent
>>>>>>>>>>>>>>   callers should either already care for not resending a req=
uest
>>>>>>>>>>>>>>   uselessly because it is pending (e.g. [1]), or their inter=
nal logic
>>>>>>>>>>>>>>   should prevent that (e.g. [2]). This interface always conv=
ey user data
>>>>>>>>>>>>>>   by reference.
>>>>>>>>>>>>>
>>>>>>>>>>>>> Ah, I fantasized that rtdm_nrtsig_pend would call rtdm_schedu=
le_nrt_work
>>>>>>>>>>>>> to do the work, it's the other way around. False alarm here.
>>>>>>>>>>>>>
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> - rtdm_schedule_nrt_work(): does allocate a nrtsig_t struct =
in order to
>>>>>>>>>>>>>>   convey a request block we cannot squeeze into a work_struc=
t, since the
>>>>>>>>>>>>>>   latter is in itself an anchor type the user may embed into=
 its own
>>>>>>>>>>>>>>   private argument block. I'm unsure ensuring that
>>>>>>>>>>>>>>   rtdm_schedule_nrt_work() calls do not pile up would be wor=
th it, as
>>>>>>>>>>>>>>   this call is not supposed to be used frenetically on some =
hot path in
>>>>>>>>>>>>>>   the first place. But if we'd want to do that, then we woul=
d have to
>>>>>>>>>>>>>>   change the signature of rtdm_schedule_nrt_work(), so that =
we gain a
>>>>>>>>>>>>>>   persistent context data we could use for determining wheth=
er a nrt
>>>>>>>>>>>>>>   work request is in flight. We could not probe the work_str=
uct for that
>>>>>>>>>>>>>>   purpose, that would be racy.
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> Do you see any way to have a smarter rtdm_schedule_nrt_work(=
) without
>>>>>>>>>>>>>> changing its signature?
>>>>>>>>>>>>>
>>>>>>>>>>>>> There is no rule that prevents changing the signature if that=
 is needed.
>>>>>>>>>>>>> However, the kernel is fine without allocation as well, using=
 a very
>>>>>>>>>>>>> similar signature.
>>>>>>>>>>>>>
>>>>>>>>>>>>
>>>>>>>>>>>> schedule_work() and rtdm_schedule_nrt_work() have a major diff=
erence:
>>>>>>>>>>>> the latter has to pass on the request from the oob to the in-b=
and
>>>>>>>>>>>> context. This is what bugs us and creates the requirement for =
additional
>>>>>>>>>>>> mechanism and data.
>>>>>>>>>>>>
>>>>>>>>>>>>> I do not yet understand way we need that indirection via the =
rtdm_nrtsig
>>>>>>>>>>>>> on Dovetail. I thought we can trigger work directly from the =
oob domain
>>>>>>>>>>>>> there, can't we? How do you handle such a case in evl so far?
>>>>>>>>>>>>>
>>>>>>>>>>>>
>>>>>>>>>>>> Dovetail can trigger in-band work from oob via the generic irq=
_work()
>>>>>>>>>>>> service, we don't need the extra code involved in the I-pipe f=
or the
>>>>>>>>>>>> same purpose. The gist of the matter is about having the same
>>>>>>>>>>>> implementation for rtdm_schedule_nrt_work() which works in bot=
h Dovetail
>>>>>>>>>>>> and I-pipe contexts: the way we do that is by using rtdm_nrtsi=
g_pend()
>>>>>>>>>>>> which already abstracts the base mechanism for relaying oob ->=
 in-band
>>>>>>>>>>>> signals.
>>>>>>>>>>>>
>>>>>>>>>>>> On the other hand, EVL has the evl_call_inband[_from]() servic=
e, which
>>>>>>>>>>>> combines the irq_work and work_struct anchors we need into a s=
ingle
>>>>>>>>>>>> evl_work type, which in turn can be embedded into a user reque=
st
>>>>>>>>>>>> block. This is what rtdm_schedule_nrt_work() does not expose, =
so it has
>>>>>>>>>>>> to build one internally by combining a dynamic allocation and =
the
>>>>>>>>>>>> user-provided work_struct.
>>>>>>>>>>>>
>>>>>>>>>>>
>>>>>>>>>>> Then enhance the rtdm service to enable such a combination - an=
d be even
>>>>>>>>>>> more ready for the switch to Xenomai 4, I would say. We can eit=
her add a
>>>>>>>>>>> new service and deprecate the old one (while implementing it as=
 you
>>>>>>>>>>> suggest) or just break the interface to get the (presumably) fe=
w users
>>>>>>>>>>> quickly converted.
>>>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>> rtdm_schedule_nrt_work() was added by Gilles when merging the RT=
net code
>>>>>>>>>> into Xenomai 3 IIRC, with little documentation. Widespread usage=
 of this
>>>>>>>>>> call is unlikely, so I'd vote for simplifying the whole thing and
>>>>>>>>>> replace it entirely.
>>>>>>>>>>
>>>>>>>>>
>>>>>>>>> OK, then we have a plan for this piece.
>>>>>
>>>>> Do we  need to implement new API to replace rtdm_schedule_nrt_work() =
to avoid call xnmalloc=20
>>>>> or just keep it as it is in Xenomai 3.2 ?
>>>>>
>>>>>>>>>
>>>>>>>>>>>>> And the third case remains xnthread_signal, btw.
>>>>>>>>>>>>>
>>>>>>>>>>>>
>>>>>>>>>>>> xnthread_signal() is used to trigger SIGDEBUG/SIGSHADOW/SIGTER=
M signals
>>>>>>>>>>>> for a thread, a seldom event. Optimizing there would be overki=
ll, unless
>>>>>>>>>>>> the application behaves wrongly in the first place.
>>>>>>>>>>>
>>>>>>>>>>> Some caller are under nklock, thus it makes potentially lengthy=
 critical
>>>>>>>>>>> sections now a bit longer.
>>>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>> This is what needs to be fixed in the first place, we should not=
 trigger
>>>>>>>>>> a signal relay when holding the ugly big lock.
>>>>>
>>>>> Which functions we need to fix or do optimization to avoid calling xn=
thread_signal when holding
>>>>> big lock if possible? xnthread_suspend and xnthread_cancel?=20=20
>>>>>
>>>>>>>>>>
>>>>>>>>>
>>>>>>>>> Whatever is simpler.
>>>>>>>>>
>>>>>>>>> Another aspect: Using xnmalloc for anything that should better su=
cceed
>>>>>>>>> is possibly not good when we are OOM. That is actually no strict
>>>>>>>>> regression over I-pipe where we had a limited queue as well IIRC =
but a
>>>>>>>>> reason to avoid carrying that over - and possibly creating new er=
ror
>>>>>>>>> scenarios that are harder to debug.
>>>>>>>>>
>>>>>>>>
>>>>>>>> To mitigate the issue of generalized OOM, we could pull memory fro=
m a
>>>>>>>> local xnheap privately attached to xnthread_signal() along with any
>>>>>>>> caller requiring dynamic allocation, so that none of them could de=
plete
>>>>>>>> the sysheap.
>>>>>>>>
>>>>>>>> Getting rid of dynamic allocation entirely on the other hand would
>>>>>>>> require us to add one or more "signal slots" per possible cause of
>>>>>>>> in-band signal into struct xnthread (e.g. SIGSHADOW_ACTION_BACKTRA=
CE,
>>>>>>>> SIGDEBUG_MIGRATE_SIGNAL etc), passing the proper slot to
>>>>>>>> xnthread_signal(). SIGSHADOW(SIGWINCH) and SIGDEBUG(SIGXCPU) are
>>>>>>>> standard non-queueable signals, so we should only need a single sl=
ot per
>>>>>>>> signal cause.
>>>>>>>>
>>>>>>>
>>>>>>> Can a thread actually trigger multiple causes per SIGDEBUG, e.g.?
>>>>>>> Likely, we only need to carry the single cause via a field in xnthr=
ead
>>>>>>> from the trigger point to the in-band handler. The same is probably=
 the
>>>>>>> case for SIGSHADOW_ACTION_BACKTRACE.
>>>>>>>
>>>>>>
>>>>>> Multiple events triggering SIGSHADOW_ACTION_HOME and
>>>>>> SIGSHADOW_ACTION_HARDEN _might_ pile up, although unlikely.
>>>>>
>>>>> Does that means that in struct xnthread there should be three slots of
>>>>> struct lostage_signal to handle each of SIGDEBUG/SIGSHADOW/SIGTERM
>>>>> like patch [1]?
>>>>>
>>>>>  If there is no pile up for each signal , we would just allocate fixe=
d position=20
>>>>> for three signals in the array and then handle corresponding  lostage=
_signal=20
>>>>>  by signo. Is it enough?
>>>>>
>>>>> [1]:
>>>>>
>>>>> +++ b/include/cobalt/kernel/thread.h
>>>>> @@ -51,6 +51,15 @@ struct xnsched_tpslot;
>>>>>  struct xnthread_personality;
>>>>>  struct completion;
>>>>>
>>>>> +#define XENO_MUM_SIGNALS 3 /*SIGDEBUG/SIGSHADOW/SIGTERM */
>>>>> +
>>>>> +struct lostage_signal {
>>>>> +       struct pipeline_inband_work inband_work; /* Must be first. */
>>>>> +       struct task_struct *task;
>>>>> +       int signo, sigval;
>>>>> +       struct lostage_signal *self; /* Revisit: I-pipe requirement */
>>>>> +};
>>>>> +
>>>>>  struct xnthread_init_attr {
>>>>>         struct xnthread_personality *personality;
>>>>>         cpumask_t affinity;
>>>>> @@ -205,6 +214,7 @@ struct xnthread {
>>>>>         const char *exe_path;   /* Executable path */
>>>>>         u32 proghash;           /* Hash value for exe_path */
>>>>>  #endif
>>>>> +       struct lostage_signal sigarray[XENO_MUM_SIGNALS];
>>>>>  };
>>>>>
>>>>
>>>> I would have as many entries than we have distinct reasons for notifyi=
ng
>>>> the application. i.e. include/cobalt/uapi/signal.h:
>>>>
>>>> #define SIGSHADOW_ACTION_HARDEN		1
>>>> #define SIGSHADOW_ACTION_BACKTRACE	2
>>>> #define SIGSHADOW_ACTION_HOME		3
>>>> #define SIGDEBUG_MIGRATE_SIGNAL		1
>>>> #define SIGDEBUG_MIGRATE_SYSCALL	2
>>>> #define SIGDEBUG_MIGRATE_FAULT		3
>>>> #define SIGDEBUG_MIGRATE_PRIOINV	4
>>>> #define SIGDEBUG_NOMLOCK		5
>>>> #define SIGDEBUG_WATCHDOG		6
>>>> #define SIGDEBUG_RESCNT_IMBALANCE	7
>>>> #define SIGDEBUG_LOCK_BREAK		8
>>>> #define SIGDEBUG_MUTEX_SLEEP		9
>>>
>>> For SIGDEBUG, I believe we only need the first reason, as I wrote in the
>>> other reply. We are interested in the *initial* reason for a thread to
>>> migrate. Once it is migrated, it will consume that and only generate a
>>> new reason after going back.
>>>
>>=20
>> We may have SIGDEBUG_WATCHDOG pending concurrently to any other causes,
>> this is triggered asynchronously by the oob timer. So at the very least,
>> you want this one to have its own slot.
>
> First come, first serve - we only need to know why we initially
> migrated.
> But, yes, that may imply locking against concurrent filling of
> the reason field.

Which means you want distinct slots, otherwise all this work to save a
couple of =C2=B5s on a weakly contended heap would make no sense I believe.

--=20
Philippe.

