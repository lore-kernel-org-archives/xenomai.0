MIME-Version: 1.0
In-Reply-To: <504735A6.5040800@xenomai.org>
References: <CANKLDmsO-1E7+d9X6-t532RJ=CWY4P4x30nCNCwgHffJjAFkDA@mail.gmail.com>
	<50460BCE.8010505@xenomai.org>
	<CANKLDmtmnbAb7PM4URTjxYtaH5WnvGjVcEPOpSNr2A6gPwLLaA@mail.gmail.com>
	<50464969.2000902@xenomai.org> <5046549C.7030008@xenomai.org>
	<CANKLDmufv25Bngqb3CapS6ybHG9DH76DUq1q6dinzJ5ai7TowA@mail.gmail.com>
	<5046FF0A.9000208@xenomai.org>
	<CANKLDmverDgL3c2BEtXAwkGhq7KLRopGnM3q9Z_TQiAAeMponw@mail.gmail.com>
	<50470D2D.8020004@xenomai.org>
	<CANKLDmudbBw5gyWVe_nPSLkQTopaH0ajs3FXgJottn84Cm6anQ@mail.gmail.com>
	<5047318D.8060106@xenomai.org> <504735A6.5040800@xenomai.org>
Date: Wed, 5 Sep 2012 14:10:26 +0200
Message-ID: <CANKLDmtbOPWG_bc3=pcbSpgbEvSj=5ZsiXm3CWgBCwBx=yQ8Pw@mail.gmail.com>
From: Henri Roosen <henriroosen@gmail.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai] kernel NULL pointer dereference
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: Xenomai <xenomai@xenomai.org>

On Wed, Sep 5, 2012 at 1:21 PM, Gilles Chanteperdrix
<gilles.chanteperdrix@xenomai.org> wrote:
> On 09/05/2012 01:03 PM, Gilles Chanteperdrix wrote:
>
>> On 09/05/2012 11:29 AM, Henri Roosen wrote:
>>
>>> On Wed, Sep 5, 2012 at 10:28 AM, Gilles Chanteperdrix
>>> <gilles.chanteperdrix@xenomai.org> wrote:
>>>> On 09/05/2012 09:42 AM, Henri Roosen wrote:
>>>>> On Wed, Sep 5, 2012 at 9:28 AM, Gilles Chanteperdrix
>>>>> <gilles.chanteperdrix@xenomai.org> wrote:
>>>>>> On 09/05/2012 09:26 AM, Henri Roosen wrote:
>>>>>>
>>>>>>> On Tue, Sep 4, 2012 at 9:21 PM, Gilles Chanteperdrix
>>>>>>> <gilles.chanteperdrix@xenomai.org> wrote:
>>>>>>>> On 09/04/2012 08:33 PM, Gilles Chanteperdrix wrote:
>>>>>>>>
>>>>>>>>> On 09/04/2012 04:28 PM, Henri Roosen wrote:
>>>>>>>>>
>>>>>>>>>> On Tue, Sep 4, 2012 at 4:10 PM, Gilles Chanteperdrix
>>>>>>>>>> <gilles.chanteperdrix@xenomai.org> wrote:
>>>>>>>>>>> On 09/04/2012 03:42 PM, Henri Roosen wrote:
>>>>>>>>>>>> Hi,
>>>>>>>>>>>>
>>>>>>>>>>>> I'm using the bleeding edge of Xenomai (0590cb45adce468f619) a=
nd Ipipe
>>>>>>>>>>>> (d21e8cdbdcf21ade) on a x86 multicore system and kernel 3.4.6.
>>>>>>>>>>>> I reserved one cpu (kernel param isolcpus=3D1).
>>>>>>>>>>>>
>>>>>>>>>>>> Our application triggers the following NULL pointer dereferenc=
e when I
>>>>>>>>>>>> set the affinity of some tasks to cpu 0 and other tasks to cpu=
 1.
>>>>>>>>>>>> The application does not trigger this when all tasks have the =
same
>>>>>>>>>>>> affinity (set via /proc/xenomai/affinity).
>>>>>>>>>>>>
>>>>>>>>>>>> I was able to reproduce this also under QEMU and will do some
>>>>>>>>>>>> debugging, but maybe someone knows what is wrong already by se=
eing the
>>>>>>>>>>>> stacktrace below:
>>>>>>>>>>>
>>>>>>>>>>> Could you try to reduce the bug to a simple testcase which we w=
ould try
>>>>>>>>>>> and run to reproduce?
>>>>>>>>>>>
>>>>>>>>>>>> [  108.013023] BUG: unable to handle kernel NULL pointer deref=
erence
>>>>>>>>>>> at 00000294
>>>>>>>>>>>> [  108.013550] IP: [<c0126a91>] __lock_task_sighand+0x53/0xc3
>>>>>>>>>>>
>>>>>>>>>>> Or send us a disassembly of the function __lock_task_sighand?
>>>>>>>>>
>>>>>>>>>
>>>>>>>>> Looks like someone is calling send_sig_info with an invalid point=
er.
>>>>>>>>> There is something seriously wrong.
>>>>>>>>>
>>>>>>>>> On the other hand, now that I think about it, you need at least t=
he
>>>>>>>>> following patch:
>>>>>>>>>
>>>>>>>>> diff --git a/ksrc/nucleus/intr.c b/ksrc/nucleus/intr.c
>>>>>>>>> index c75fcac..0f37bb2 100644
>>>>>>>>> --- a/ksrc/nucleus/intr.c
>>>>>>>>> +++ b/ksrc/nucleus/intr.c
>>>>>>>>> @@ -93,8 +93,18 @@ void xnintr_host_tick(struct xnsched *sched) /=
* Interrupts off. */
>>>>>>>>>
>>>>>>>>>  void xnintr_clock_handler(void)
>>>>>>>>>  {
>>>>>>>>> -     struct xnsched *sched =3D xnpod_current_sched();
>>>>>>>>>       xnstat_exectime_t *prev;
>>>>>>>>> +     struct xnsched *sched;
>>>>>>>>> +     unsigned cpu;
>>>>>>>>> +
>>>>>>>>> +     cpu =3D xnarch_current_cpu();
>>>>>>>>> +
>>>>>>>>> +     if (!cpumask_test_cpu(cpu, &xnarch_supported_cpus)) {
>>>>>>>>> +             xnarch_relay_tick();
>>>>>>>>> +             return;
>>>>>>>>> +     }
>>>>>>>>> +
>>>>>>>>> +     sched =3D xnpod_sched_slot(cpu);
>>>>>>>>>
>>>>>>>>>       prev =3D xnstat_exectime_switch(sched,
>>>>>>>>>               &nkclock.stat[xnsched_cpu(sched)].account);
>>>>>>>>
>>>>>>>>
>>>>>>>> It should work (I did not test it), with the following patch on the
>>>>>>>> I-pipe:
>>>>>>>>
>>>>>>>> diff --git a/kernel/ipipe/timer.c b/kernel/ipipe/timer.c
>>>>>>>> index d51fa62..301cdc0 100644
>>>>>>>> --- a/kernel/ipipe/timer.c
>>>>>>>> +++ b/kernel/ipipe/timer.c
>>>>>>>> @@ -176,11 +176,17 @@ int ipipe_select_timers(const struct cpumask=
 *mask)
>>>>>>>>                 hrclock_freq =3D __ipipe_hrclock_freq;
>>>>>>>>
>>>>>>>>         spin_lock_irqsave(&lock, flags);
>>>>>>>> -       for_each_cpu(cpu, mask) {
>>>>>>>> +       for_each_cpu(cpu, cpu_online_mask) {
>>>>>>>>                 list_for_each_entry(t, &timers, link) {
>>>>>>>>                         if (!cpumask_test_cpu(cpu, t->cpumask))
>>>>>>>>                                 continue;
>>>>>>>>
>>>>>>>> +                       if (!cpumask_test_cpu(cpu, mask)
>>>>>>>> +                           && t->irq =3D=3D per_cpu(ipipe_percpu.=
hrtimer_irq, 0)) {
>>>>>>>> +                               per_cpu(ipipe_percpu.hrtimer_irq, =
cpu) =3D t->irq;
>>>>>>>> +                               goto found;
>>>>>>>> +                       }
>>>>>>>> +
>>>>>>>>                         evtdev =3D t->host_timer;
>>>>>>>>  #ifdef CONFIG_GENERIC_CLOCKEVENTS
>>>>>>>>                         if (!evtdev
>>>>>>>> @@ -188,10 +194,16 @@ int ipipe_select_timers(const struct cpumask=
 *mask)
>>>>>>>>  #endif /* CONFIG_GENERIC_CLOCKEVENTS */
>>>>>>>>                                 goto found;
>>>>>>>>                 }
>>>>>>>> +               if (!cpumask_test_cpu(cpu, mask))
>>>>>>>> +                       continue;
>>>>>>>> +
>>>>>>>>                 printk("I-pipe: could not find timer for cpu #%d\n=
", cpu);
>>>>>>>>                 goto err_remove_all;
>>>>>>>>
>>>>>>>>           found:
>>>>>>>> +               if (!cpumask_test_cpu(cpu, mask))
>>>>>>>> +                       continue;
>>>>>>>> +
>>>>>>>>                 if (__ipipe_hrtimer_freq =3D=3D 0)
>>>>>>>>                         __ipipe_hrtimer_freq =3D t->freq;
>>>>>>>>                 per_cpu(ipipe_percpu.hrtimer_irq, cpu) =3D t->irq;
>>>>>>>>
>>>>>>> Thanks for looking into this Gilles!
>>>>>>> I tried your second patch only and unfortunately I was still able to
>>>>>>> reproduce the same kernel NULL pointer dereference.
>>>>>>
>>>>>>
>>>>>> Sorry, I meant the first xenomai patch needs the second I-pipe patch=
 to
>>>>>> work.
>>>>>
>>>>> I applied both patches now, but still able to reproduce the same prob=
lem.
>>>>
>>>> Ok, to debug this, you can add:
>>>> BUG_ON((unsigned long)xnthread_user_task(thread) < 0xc0000000);
>>>> in xnshadow_send_sig. Add:
>>>> BUG_ON((unsigned long)p < 0xc0000000)
>>>> in lostage_handler, in the LO_SIGTHR_REQ case.
>>>>
>>>> Enable the I-pipe tracer, panic back traces, then set the number of
>>>> points to a reasonably high value before running your test.
>>>
>>> Please find attached the trace ipipe_trace.txt
>>>
>>> Note that in order to compile the ipipe-tracer for x86 I had to remove
>>> the call to hard_irqs_disabled_flags. I changed that to 0.. hope that
>>> doesn't affect the trace log.
>>
>>
>> It does affect the trace, we do not see whether the irqs are off, but it
>> is not very important for the issue you have. You can replace with
>> arch_irqs_disable_flags, I have a fix for this in my tree, not pushed
>> yet, but should be in the I-pipe repository soon.
>>
>> Anyway, what seems to happen is that your application calls exit, while
>> some thread was waiting for a a PI mutex, the nucleus tries to send a
>> signal to the mutex holder. However, something gets wrong, and the mutex
>> holder task pointer is invalid.
>>
>> What is strange, also, is how a task can be waiting for a mutex and
>> calling exit at the same time. Could you try to increase the number of
>> trace points to say 1000 points?
>
>
> Answering myself. The thread killed is the one holding the mutex. The
> signal is sent to this precise thread, so this may fail because the
> thread is in the process of being destroyed, and its user_task pointer
> is no longer valid.

Please find attached ipipe_trace_2.txt that has the number of
tracepoints to 1000. Note that this log also doesn't trace whether
irqs are off (arch_irqs_disable_flags is not in the current ipipe tree
yet either).

I will find out why the application is doing a sys_exit. However I'm
not sure how this is related to the thread affinity; when not setting
the affinity, the problem is not reproducable.
>
> --
>                                                                 Gilles.
-------------- next part --------------
[   35.951371] [sched_delayed] sched: RT throttling activated
[   40.191027] I-pipe: Detected stalled head domain, probably caused by a b=
ug.
[   40.191030]         A critical section may have been left unterminated.
[   40.191621] Pid: 246, comm: cyclic:214:246 Tainted: G           O 3.4.6+=
 #72
[   40.191621] Call Trace:
[   40.191621]  [<c0161420>] ipipe_root_only+0x7f/0x8b
[   40.191621]  [<c0161f7a>] ipipe_unstall_root+0x12/0x2d
[   40.191621]  [<c0102695>] conditional_sti+0xe/0x10
[   40.191621]  [<c01029e6>] do_invalid_op+0x59/0x80
[   40.191621]  [<c0188347>] ? xnshadow_send_sig+0x19/0x3e
[   40.191621]  [<c01614f0>] ? __ipipe_notify_trap+0x9/0x82
[   40.191621]  [<c0113d3f>] ? __ipipe_handle_exception+0x9/0x1f4
[   40.191621]  [<c01645a2>] ? ipipe_trace_function+0x19/0x1c
[   40.191621]  [<c0113922>] ? __ipipe_get_current_domain+0xe/0x43
[   40.191621]  [<c0113f11>] __ipipe_handle_exception+0x1db/0x1f4
[   40.191621]  [<c041e577>] error_code+0x5f/0x6c
[   40.191621]  [<c016007b>] ? __rcu_process_callbacks+0x2b7/0x355
[   40.191621]  [<c0188347>] ? xnshadow_send_sig+0x19/0x3e
[   40.191621]  [<c01883f7>] xnshadow_renice+0x2d/0x30
[   40.191621]  [<c0182d5b>] xnsynch_renice_thread+0x32/0x48
[   40.191621]  [<c0182de7>] xnsynch_clear_boost+0x76/0x79
[   40.191621]  [<c0183182>] xnsynch_release_thread+0xe1/0x12b
[   40.191621]  [<c018320a>] xnsynch_release_all_ownerships+0x3e/0x55
[   40.191621]  [<c0181198>] xnpod_delete_thread+0x18e/0x254
[   40.191621]  [<c0187d45>] taskexit_event+0xce/0x14e
[   40.191621]  [<c0164861>] ipipe_kevent_hook+0x1c/0x1f
[   40.191621]  [<c01614c7>] __ipipe_notify_kevent+0x4e/0x6e
[   40.191621]  [<c01225c0>] do_exit+0x207/0x6a1
[   40.191621]  [<c01645a2>] ? ipipe_trace_function+0x19/0x1c
[   40.191621]  [<c0122b18>] sys_exit+0x18/0x18
[   40.191621]  [<c041dd3a>] syscall_call+0x7/0xb
[   40.191621] I-pipe tracer log (1000 points):
[   40.191621]     *#func                    0 ipipe_trace_panic_freeze+0x4=
 (ipipe_root_only+0x53)
[   40.191621]     *#func                    0 ipipe_prepare_panic+0x4 (ipi=
pe_root_only+0x4e)
[   40.191621]     *#func                    0 ipipe_root_only+0x5 (ipipe_u=
nstall_root+0x12)
[   40.191621]     *#func                    0 ipipe_unstall_root+0x3 (cond=
itional_sti+0xe)
[   40.191621]     *#func                    0 __rcu_read_unlock+0x4 (__ato=
mic_notifier_call_chain+0x31)
[   40.191621]     *#func                   -6 hw_breakpoint_exceptions_not=
ify+0x9 (notifier_call_chain+0x30)
[   40.191621]     *#func                   -7 notifier_call_chain+0x9 (__a=
tomic_notifier_call_chain+0x2a)
[   40.191621]     *#func                   -7 __rcu_read_lock+0x3 (__atomi=
c_notifier_call_chain+0x19)
[   40.191621]     *#func                   -7 __atomic_notifier_call_chain=
+0x6 (atomic_notifier_call_chain+0x11)
[   40.191621]     *#func                   -7 atomic_notifier_call_chain+0=
x3 (notify_die+0x2d)
[   40.191621]     *#func                   -7 do_invalid_op+0x8 (__ipipe_h=
andle_exception+0x1db)
[   40.191621]     *#func                   -8 __ipipe_notify_trap+0x9 (__i=
pipe_handle_exception+0x89)
[   40.191621]     *+func                   -8 __ipipe_handle_exception+0x9=
 (error_code+0x5f)
[   40.191621]     *+func                  -11 xnshadow_send_sig+0x4 (xnsha=
dow_renice+0x2d)
[   40.191621]     *+func                  -12 xnshadow_renice+0x3 (xnsynch=
_renice_thread+0x32)
[   40.191621]     *+func                  -12 xnsched_track_policy+0x5 (xn=
synch_renice_thread+0x10)
[   40.191621]     *+func                  -12 xnsynch_renice_thread+0x4 (x=
nsynch_clear_boost+0x76)
[   40.191621]     *+func                  -12 xnsynch_clear_boost+0x4 (xns=
ynch_release_thread+0xe1)
[   40.191621]     *+[  229] Watchdo 96    -12 xnpod_resume_thread+0x40 (xn=
synch_release_thread+0xd1)
[   40.191621]     *+func                  -13 xnpod_resume_thread+0x9 (xns=
ynch_release_thread+0xd1)
[   40.191621]     *+func                  -13 xnsynch_release_thread+0x9 (=
xnsynch_release_all_ownerships+0x3e)
[   40.191621]     *+func                  -13 xnsynch_release_all_ownershi=
ps+0x9 (xnpod_delete_thread+0x18e)
[   40.191621]     *+func                  -14 xntimer_destroy+0x5 (xnpod_d=
elete_thread+0x15e)
[   40.191621]     *+func                  -14 xntimer_destroy+0x5 (xnpod_d=
elete_thread+0x153)
[   40.191621]     *+func                  -14 xnpod_delete_thread+0x6 (tas=
kexit_event+0xce)
[   40.191621]      +begin   0x80000000    -14 ipipe_test_and_stall_pipelin=
e_head+0x15 (__xnlock_get_irqsave+0xc)
[   40.191621]      +func                  -15 __task_get_magic+0x3 (taskex=
it_event+0x5b)
[   40.191621]      +func                  -15 taskexit_event+0x9 (ipipe_ke=
vent_hook+0x1c)
[   40.191621]      +func                  -15 ipipe_kevent_hook+0x4 (__ipi=
pe_notify_kevent+0x4e)
[   40.191621]      +end     0x80000001    -15 hard_local_irq_restore+0x15 =
(__ipipe_notify_kevent+0x43)
[   40.191621]      +begin   0x80000001    -15 hard_local_irq_save+0x16 (__=
ipipe_notify_kevent+0x20)
[   40.191621]      +end     0x80000001    -15 hard_local_irq_restore+0x15 =
(ipipe_root_only+0x40)
[   40.191621]      +begin   0x80000001    -15 hard_local_irq_save+0x16 (ip=
ipe_root_only+0xf)
[   40.191621]      +func                  -15 ipipe_root_only+0x5 (__ipipe=
_notify_kevent+0x1b)
[   40.191621]      +func                  -16 __ipipe_notify_kevent+0x9 (d=
o_exit+0x207)
[   40.191621]      +end     0x80000001    -16 hard_local_irq_restore+0x15 =
(ipipe_root_only+0x40)
[   40.191621]      +begin   0x80000001    -16 hard_local_irq_save+0x16 (ip=
ipe_root_only+0xf)
[   40.191621]      +func                  -16 ipipe_root_only+0x5 (mmput+0=
x10)
[   40.191621]      +func                  -16 mmput+0x4 (exit_mm+0xe5)
[   40.191621]      +func                  -16 sub_preempt_count+0x4 (_raw_=
spin_unlock+0x15)
[   40.191621]      +func                  -16 _raw_spin_unlock+0x3 (exit_m=
m+0xde)
[   40.191621]      +func                  -17 up_read+0x3 (exit_mm+0xc3)
[   40.191621]      +end     0x80000001    -17 hard_local_irq_restore+0x15 =
(ipipe_root_only+0x40)
[   40.191621]      +begin   0x80000001    -17 hard_local_irq_save+0x16 (ip=
ipe_root_only+0xf)
[   40.191621]      +func                  -17 ipipe_root_only+0x5 (add_pre=
empt_count+0x10)
[   40.191621]      +func                  -17 add_preempt_count+0x4 (_raw_=
spin_lock+0x15)
[   40.191621]      +func                  -17 _raw_spin_lock+0x4 (exit_mm+=
0xb1)
[   40.191621]      +end     0x80000001    -17 hard_local_irq_restore+0x15 =
(ipipe_root_only+0x40)
[   40.191621]      +begin   0x80000001    -17 hard_local_irq_save+0x16 (ip=
ipe_root_only+0xf)
[   40.191621]      +func                  -18 ipipe_root_only+0x5 (down_re=
ad+0x10)
[   40.191621]      +func                  -18 down_read+0x4 (exit_mm+0x37)
[   40.191621]      +func                  -18 sync_mm_rss+0x5 (exit_mm+0x2=
c)
[   40.191621]      +func                  -18 drop_futex_key_refs+0x3 (fut=
ex_wake+0xd0)
[   40.191621]      +func                  -18 sub_preempt_count+0x4 (_raw_=
spin_unlock+0x15)
[   40.191621]      +func                  -18 _raw_spin_unlock+0x3 (futex_=
wake+0xc8)
[   40.191621]      +end     0x80000001    -18 hard_local_irq_restore+0x15 =
(ipipe_root_only+0x40)
[   40.191621]      +begin   0x80000001    -19 hard_local_irq_save+0x16 (ip=
ipe_root_only+0xf)
[   40.191621]      +func                  -19 ipipe_root_only+0x5 (add_pre=
empt_count+0x10)
[   40.191621]      +func                  -19 add_preempt_count+0x4 (_raw_=
spin_lock+0x15)
[   40.191621]      +func                  -19 _raw_spin_lock+0x4 (futex_wa=
ke+0x58)
[   40.191621]      +func                  -19 hash_futex+0x4 (futex_wake+0=
x51)
[   40.191621]      +func                  -19 put_page+0x3 (get_futex_key+=
0x17e)
[   40.191621]      +func                  -19 __wake_up_bit+0x7 (unlock_pa=
ge+0x45)
[   40.191621]      +func                  -20 unlock_page+0x4 (get_futex_k=
ey+0x177)
[   40.191621]      +func                  -20 get_futex_key_refs+0x3 (get_=
futex_key+0x170)
[   40.191621]      +end     0x80000001    -20 hard_local_irq_restore+0x15 =
(ipipe_root_only+0x40)
[   40.191621]      +begin   0x80000001    -20 hard_local_irq_save+0x16 (ip=
ipe_root_only+0xf)
[   40.191621]      +func                  -20 ipipe_root_only+0x5 (get_fut=
ex_key+0x108)
[   40.191621]      +end     0x80000000    -20 hard_local_irq_enable+0x14 (=
ipipe_unstall_root+0x2b)
[   40.191621]      #func                  -20 ipipe_root_only+0x5 (ipipe_u=
nstall_root+0x12)
[   40.191621]      #begin   0x80000000    -21 hard_local_irq_disable+0x15 =
(ipipe_unstall_root+0xd)
[   40.191621]      #func                  -21 ipipe_unstall_root+0x3 (get_=
user_pages_fast+0xb7)
[   40.191621]      #func                  -21 gup_pte_range+0x9 (gup_pud_r=
ange+0x4a)
[   40.191621]      #func                  -21 gup_pud_range+0x9 (get_user_=
pages_fast+0x9e)
[   40.191621]      +func                  -22 get_user_pages_fast+0x9 (get=
_futex_key+0x94)
[   40.191621]      +func                  -22 get_futex_key+0x9 (futex_wak=
e+0x3f)
[   40.191621]      +func                  -22 futex_wake+0x9 (do_futex+0xc=
e)
[   40.191621]      +func                  -22 do_futex+0xc (sys_futex+0xee)
[   40.191621]      +func                  -23 sys_futex+0x9 (mm_release+0x=
b4)
[   40.191621]      +end     0x80000001    -23 hard_local_irq_restore+0x15 =
(ipipe_root_only+0x40)
[   40.191621]      +begin   0x80000001    -23 hard_local_irq_save+0x16 (ip=
ipe_root_only+0xf)
[   40.191621]      +func                  -23 ipipe_root_only+0x5 (mm_rele=
ase+0x97)
[   40.191621]      +end     0x80000001    -24 hard_local_irq_restore+0x15 =
(ipipe_root_only+0x40)
[   40.191621]      +begin   0x80000001    -24 hard_local_irq_save+0x16 (ip=
ipe_root_only+0xf)
[   40.191621]      +func                  -24 ipipe_root_only+0x5 (exit_ro=
bust_list+0x5e)
[   40.191621]      +end     0x80000001    -24 hard_local_irq_restore+0x15 =
(ipipe_root_only+0x40)
[   40.191621]      +begin   0x80000001    -24 hard_local_irq_save+0x16 (ip=
ipe_root_only+0xf)
[   40.191621]      +func                  -24 ipipe_root_only+0x5 (exit_ro=
bust_list+0x43)
[   40.191621]      +end     0x80000001    -24 hard_local_irq_restore+0x15 =
(ipipe_root_only+0x40)
[   40.191621]      +begin   0x80000001    -24 hard_local_irq_save+0x16 (ip=
ipe_root_only+0xf)
[   40.191621]      +func                  -24 ipipe_root_only+0x5 (exit_ro=
bust_list+0x2c)
[   40.191621]      +func                  -25 exit_robust_list+0x9 (mm_rel=
ease+0x1d)
[   40.191621]      +func                  -25 mm_release+0x6 (exit_mm+0x1d)
[   40.191621]      +func                  -25 exit_mm+0x9 (do_exit+0x1c1)
[   40.191621]      +func                  -25 sync_mm_rss+0x5 (do_exit+0x1=
3d)
[   40.191621]      +func                  -26 exit_irq_thread+0x5 (do_exit=
+0xfc)
[   40.191621]      +func                  -26 sub_preempt_count+0x4 (_raw_=
spin_unlock_irq+0x1a)
[   40.191621]      +end     0x80000000    -26 hard_local_irq_enable+0x14 (=
ipipe_unstall_root+0x2b)
[   40.191621]      #func                  -26 ipipe_root_only+0x5 (ipipe_u=
nstall_root+0x12)
[   40.191621]      #begin   0x80000000    -26 hard_local_irq_disable+0x15 =
(ipipe_unstall_root+0xd)
[   40.191621]      #func                  -27 ipipe_unstall_root+0x3 (_raw=
_spin_unlock_irq+0x10)
[   40.191621]      #func                  -27 _raw_spin_unlock_irq+0x3 (ex=
it_signals+0x83)
[   40.191621]      #end     0x80000001    -27 hard_local_irq_restore+0x15 =
(ipipe_root_only+0x40)
[   40.191621]      #begin   0x80000001    -27 hard_local_irq_save+0x16 (ip=
ipe_root_only+0xf)
[   40.191621]      #func                  -27 ipipe_root_only+0x5 (add_pre=
empt_count+0x10)
[   40.191621]      #func                  -27 add_preempt_count+0x4 (_raw_=
spin_lock_irq+0x28)
[   40.191621]      +func                  -27 _raw_spin_lock_irq+0x4 (exit=
_signals+0xb8)
[   40.191621]      +func                  -28 exit_signals+0x8 (do_exit+0x=
d9)
[   40.191621]      +func                  -28 do_exit+0x9 (complete_and_ex=
it+0x0)
[   40.191621]      +func                  -28 sys_exit+0x3 (syscall_call+0=
x7)
[   40.191621]      +end     0x80000001    -28 __ipipe_syscall_root+0x90 (s=
ystem_call+0x2d)
[   40.191621]      +begin   0x80000001    -29 hard_local_irq_save+0x16 (__=
ipipe_syscall_root+0x35)
[   40.191621]      +end     0x80000001    -29 hard_local_irq_restore+0x15 =
(__ipipe_notify_syscall+0xc5)
[   40.191621]      +begin   0x80000001    -29 hard_local_irq_save+0x16 (__=
ipipe_notify_syscall+0x6a)
[   40.191621]      +func                  -29 losyscall_event+0x9 (ipipe_s=
yscall_hook+0x88)
[   40.191621]      +end     0x80000001    -29 ipipe_syscall_hook+0x75 (__i=
pipe_notify_syscall+0x63)
[   40.191621]      +begin   0x80000001    -29 ipipe_syscall_hook+0x2b (__i=
pipe_notify_syscall+0x63)
[   40.191621]      +func                  -29 ipipe_syscall_hook+0x9 (__ip=
ipe_notify_syscall+0x63)
[   40.191621]      +end     0x80000001    -29 hard_local_irq_restore+0x15 =
(__ipipe_notify_syscall+0x58)
[   40.191621]      +begin   0x80000001    -30 hard_local_irq_save+0x16 (__=
ipipe_notify_syscall+0x6a)
[   40.191621]      +func                  -30 sub_preempt_count+0x4 (__ipi=
pe_reenter_root+0x39)
[   40.191621]      +func                  -30 sub_preempt_count+0x4 (_raw_=
spin_unlock_irq+0x1a)
[   40.191621]      +end     0x80000000    -30 hard_local_irq_enable+0x14 (=
ipipe_unstall_root+0x2b)
[   40.191621]      #func                  -30 ipipe_root_only+0x5 (ipipe_u=
nstall_root+0x12)
[   40.191621]      #begin   0x80000000    -30 hard_local_irq_disable+0x15 =
(ipipe_unstall_root+0xd)
[   40.191621]      #func                  -30 ipipe_unstall_root+0x3 (_raw=
_spin_unlock_irq+0x10)
[   40.191621]      #func                  -31 _raw_spin_unlock_irq+0x3 (fi=
nish_task_switch+0x4c)
[   40.191621]      #func                  -31 finish_task_switch+0x9 (__ip=
ipe_reenter_root+0x28)
[   40.191621]      #end     0x80000001    -31 debug_smp_processor_id+0x82 =
(__ipipe_reenter_root+0x13)
[   40.191621]      #begin   0x80000001    -31 debug_smp_processor_id+0x36 =
(__ipipe_reenter_root+0x13)
[   40.191621]      #func                  -31 __ipipe_reenter_root+0x4 (xn=
shadow_relax+0xc5)
[   40.191621]      #end     0x80000000    -31 hard_local_irq_enable+0x14 (=
ipipe_unstall_head+0x2e)
[   40.191621]     *#func                  -31 ipipe_unstall_head+0x4 (xnsh=
adow_relax+0xb4)
[   40.191621]      #begin   0x80000000    -31 xnpod_suspend_thread+0x1b5 (=
xnshadow_relax+0xaf)
[   40.191621]      #end     0xffffff0f    -32 ipipe_reschedule_interrupt+0=
x41 (hard_local_irq_enable+0x16)
[   40.191621]      #func                  -32 __ipipe_do_sync_pipeline+0x4=
 (__ipipe_dispatch_irq+0x170)
[   40.191621]      #func                  -32 __switch_to+0x9 (__xnpod_sch=
edule+0x407)
[   40.191621]      #begin   0x80000000    -32 __schedule+0x32d (schedule+0=
x5b)
[   40.191621]      #end     0x80000001    -32 hard_local_irq_restore+0x15 =
(__ipipe_notify_kevent+0x65)
[   40.191621]      #begin   0x80000001    -32 hard_local_irq_save+0x16 (__=
ipipe_notify_kevent+0x55)
[   40.191621]      #func                  -33 schedule_event+0x5 (ipipe_ke=
vent_hook+0x1c)
[   40.191621]      #func                  -33 ipipe_kevent_hook+0x4 (__ipi=
pe_notify_kevent+0x4e)
[   40.191621]      #end     0x80000001    -33 hard_local_irq_restore+0x15 =
(__ipipe_notify_kevent+0x43)
[   40.191621]      #begin   0x80000001    -33 hard_local_irq_save+0x16 (__=
ipipe_notify_kevent+0x20)
[   40.191621]      #end     0x80000001    -33 hard_local_irq_restore+0x15 =
(ipipe_root_only+0x40)
[   40.191621]      #begin   0x80000001    -33 hard_local_irq_save+0x16 (ip=
ipe_root_only+0xf)
[   40.191621]      #func                  -33 ipipe_root_only+0x5 (__ipipe=
_notify_kevent+0x1b)
[   40.191621]      #func                  -33 __ipipe_notify_kevent+0x9 (_=
_schedule+0x31b)
[   40.191621]      #func                  -34 pick_next_task_rt+0x6 (__sch=
edule+0x25f)
[   40.191621]      #func                  -34 pick_next_task_stop+0x3 (__s=
chedule+0x25f)
[   40.191621]      #func                  -34 sub_preempt_count+0x4 (_raw_=
spin_unlock+0x15)
[   40.191621]      #func                  -34 _raw_spin_unlock+0x3 (update=
_curr_rt+0x1eb)
[   40.191621]      #end     0x80000001    -34 hard_local_irq_restore+0x15 =
(ipipe_root_only+0x40)
[   40.191621]      #begin   0x80000001    -34 hard_local_irq_save+0x16 (ip=
ipe_root_only+0xf)
[   40.191621]      #func                  -34 ipipe_root_only+0x5 (add_pre=
empt_count+0x10)
[   40.191621]      #func                  -34 add_preempt_count+0x4 (_raw_=
spin_lock+0x15)
[   40.191621]      #func                  -34 _raw_spin_lock+0x4 (update_c=
urr_rt+0x113)
[   40.191621]      #func                  -35 sched_avg_update+0x9 (update=
_curr_rt+0xcc)
[   40.191621]      #func                  -35 update_curr_rt+0x9 (put_prev=
_task_rt+0x13)
[   40.191621]      #func                  -35 put_prev_task_rt+0x5 (__sche=
dule+0x235)
[   40.191621]      #func                  -35 pull_rt_task+0x9 (pre_schedu=
le_rt+0x1c)
[   40.191621]      #func                  -35 pre_schedule_rt+0x3 (__sched=
ule+0x1fc)
[   40.191621]      #func                  -35 update_rt_migration+0x5 (__d=
equeue_rt_entity+0x13c)
[   40.191621]      #func                  -35 cpupri_set+0x6 (__dequeue_rt=
_entity+0x11f)
[   40.191621]      #func                  -35 __dequeue_rt_entity+0x9 (deq=
ueue_task_rt+0x39)
[   40.191621]      #func                  -36 sub_preempt_count+0x4 (_raw_=
spin_unlock+0x15)
[   40.191621]      #func                  -36 _raw_spin_unlock+0x3 (update=
_curr_rt+0x1eb)
[   40.191621]      #end     0x80000001    -36 hard_local_irq_restore+0x15 =
(ipipe_root_only+0x40)
[   40.191621]      #begin   0x80000001    -36 hard_local_irq_save+0x16 (ip=
ipe_root_only+0xf)
[   40.191621]      #func                  -36 ipipe_root_only+0x5 (add_pre=
empt_count+0x10)
[   40.191621]      #func                  -36 add_preempt_count+0x4 (_raw_=
spin_lock+0x15)
[   40.191621]      #func                  -36 _raw_spin_lock+0x4 (update_c=
urr_rt+0x113)
[   40.191621]      #func                  -36 sched_avg_update+0x9 (update=
_curr_rt+0xcc)
[   40.191621]      #func                  -36 update_curr_rt+0x9 (dequeue_=
task_rt+0x1f)
[   40.191621]      #func                  -37 dequeue_task_rt+0x9 (dequeue=
_task+0x27)
[   40.191621]      #end     0x80000001    -37 debug_smp_processor_id+0x82 =
(__cycles_2_ns+0x17)
[   40.191621]      #begin   0x80000001    -37 debug_smp_processor_id+0x36 =
(__cycles_2_ns+0x17)
[   40.191621]      #end     0x80000001    -37 debug_smp_processor_id+0x82 =
(sched_clock_cpu+0x95)
[   40.191621]      #begin   0x80000001    -37 debug_smp_processor_id+0x36 =
(sched_clock_cpu+0x95)
[   40.191621]      #func                  -37 update_rq_clock+0x5 (dequeue=
_task+0x1a)
[   40.191621]      #func                  -37 dequeue_task+0x9 (deactivate=
_task+0x24)
[   40.191621]      #func                  -37 deactivate_task+0x4 (__sched=
ule+0x12d)
[   40.191621]      #end     0x80000001    -37 hard_local_irq_restore+0x15 =
(ipipe_root_only+0x40)
[   40.191621]      #begin   0x80000001    -38 hard_local_irq_save+0x16 (ip=
ipe_root_only+0xf)
[   40.191621]      #func                  -38 ipipe_root_only+0x5 (add_pre=
empt_count+0x10)
[   40.191621]      #func                  -38 add_preempt_count+0x4 (_raw_=
spin_lock_irq+0x28)
[   40.191621]      +func                  -38 _raw_spin_lock_irq+0x4 (__sc=
hedule+0xc5)
[   40.191621]      +end     0x80000001    -38 hard_local_irq_restore+0x15 =
(ipipe_root_only+0x40)
[   40.191621]      +begin   0x80000001    -38 hard_local_irq_save+0x16 (ip=
ipe_root_only+0xf)
[   40.191621]      +func                  -38 ipipe_root_only+0x5 (__sched=
ule+0x79)
[   40.191621]      +end     0x80000000    -38 hard_local_irq_enable+0x14 (=
ipipe_unstall_root+0x2b)
[   40.191621]      #func                  -39 ipipe_root_only+0x5 (ipipe_u=
nstall_root+0x12)
[   40.191621]      #begin   0x80000000    -39 hard_local_irq_disable+0x15 =
(ipipe_unstall_root+0xd)
[   40.191621]      #func                  -39 ipipe_unstall_root+0x3 (ipip=
e_restore_root+0x2e)
[   40.191621]      #end     0x80000001    -39 hard_local_irq_restore+0x15 =
(ipipe_root_only+0x40)
[   40.191621]      #begin   0x80000001    -39 hard_local_irq_save+0x16 (ip=
ipe_root_only+0xf)
[   40.191621]      #func                  -39 ipipe_root_only+0x5 (ipipe_r=
estore_root+0x10)
[   40.191621]      #func                  -39 ipipe_restore_root+0x4 (arch=
_local_irq_restore+0x11)
[   40.191621]      +func                  -39 rcu_note_context_switch+0x9 =
(__schedule+0x3d)
[   40.191621]      +end     0x80000001    -40 debug_smp_processor_id+0x82 =
(__schedule+0x28)
[   40.191621]      +begin   0x80000001    -40 debug_smp_processor_id+0x36 =
(__schedule+0x28)
[   40.191621]      +end     0x80000001    -40 hard_local_irq_restore+0x15 =
(ipipe_root_only+0x40)
[   40.191621]      +begin   0x80000001    -40 hard_local_irq_save+0x16 (ip=
ipe_root_only+0xf)
[   40.191621]      +func                  -40 ipipe_root_only+0x5 (add_pre=
empt_count+0x10)
[   40.191621]      +func                  -40 add_preempt_count+0x4 (__sch=
edule+0x23)
[   40.191621]      +func                  -40 __schedule+0x9 (schedule+0x5=
b)
[   40.191621]      +func                  -40 schedule+0x3 (gatekeeper_thr=
ead+0xbf)
[   40.191621]      +func                  -41 sub_preempt_count+0x4 (_raw_=
spin_unlock_irqrestore+0x28)
[   40.191621]      +end     0x80000000    -41 hard_local_irq_enable+0x14 (=
ipipe_unstall_root+0x2b)
[   40.191621]      #func                  -41 ipipe_root_only+0x5 (ipipe_u=
nstall_root+0x12)
[   40.191621]      #begin   0x80000000    -41 hard_local_irq_disable+0x15 =
(ipipe_unstall_root+0xd)
[   40.191621]      #func                  -41 ipipe_unstall_root+0x3 (ipip=
e_restore_root+0x2e)
[   40.191621]      #end     0x80000001    -41 hard_local_irq_restore+0x15 =
(ipipe_root_only+0x40)
[   40.191621]      #begin   0x80000001    -41 hard_local_irq_save+0x16 (ip=
ipe_root_only+0xf)
[   40.191621]      #func                  -41 ipipe_root_only+0x5 (ipipe_r=
estore_root+0x10)
[   40.191621]      #func                  -41 ipipe_restore_root+0x4 (_raw=
_spin_unlock_irqrestore+0x1e)
[   40.191621]      #func                  -42 _raw_spin_unlock_irqrestore+=
0x3 (up+0x37)
[   40.191621]      #func                  -42 __ipipe_spin_unlock_debug+0x=
3 (up+0x2e)
[   40.191621]      #end     0x80000001    -42 hard_local_irq_restore+0x15 =
(ipipe_root_only+0x40)
[   40.191621]      #begin   0x80000001    -42 hard_local_irq_save+0x16 (ip=
ipe_root_only+0xf)
[   40.191621]      #func                  -42 ipipe_root_only+0x5 (add_pre=
empt_count+0x10)
[   40.191621]      #func                  -42 add_preempt_count+0x4 (_raw_=
spin_lock_irqsave+0x49)
[   40.191621]      +func                  -42 _raw_spin_lock_irqsave+0x5 (=
up+0x11)
[   40.191621]      +func                  -42 up+0x5 (gatekeeper_thread+0x=
ba)
[   40.191621]      +end     0x80000001    -43 ipipe_raise_irq+0x3d (__xnpo=
d_schedule+0x26)
[   40.191621]      #begin   0x80000000    -43 hard_local_irq_disable+0x15 =
(__ipipe_do_sync_stage+0x111)
[   40.191621]      #func                  -43 sub_preempt_count+0x4 (irq_e=
xit+0xa8)
[   40.191621]      #end     0x80000001    -43 hard_local_irq_restore+0x15 =
(ipipe_root_only+0x40)
[   40.191621]      #begin   0x80000001    -43 hard_local_irq_save+0x16 (ip=
ipe_root_only+0xf)
[   40.191621]      #func                  -43 ipipe_root_only+0x5 (ipipe_r=
estore_root+0x10)
[   40.191621]      #func                  -43 ipipe_restore_root+0x4 (arch=
_local_irq_restore+0x11)
[   40.191621]      #end     0x80000001    -43 debug_smp_processor_id+0x82 =
(rcu_irq_exit+0x48)
[   40.191621]      #begin   0x80000001    -44 debug_smp_processor_id+0x36 =
(rcu_irq_exit+0x48)
[   40.191621]      #func                  -44 rcu_irq_exit+0x9 (irq_exit+0=
x9e)
[   40.191621]      #func                  -44 idle_cpu+0x3 (irq_exit+0x72)
[   40.191621]      #end     0x80000001    -44 debug_smp_processor_id+0x82 =
(irq_exit+0x6d)
[   40.191621]      #begin   0x80000001    -44 debug_smp_processor_id+0x36 =
(irq_exit+0x6d)
[   40.191621]      #func                  -44 sub_preempt_count+0x4 (irq_e=
xit+0x12)
[   40.191621]      #func                  -44 irq_exit+0x3 (__ipipe_do_syn=
c_stage+0x10c)
[   40.191621]      #func                  -44 sub_preempt_count+0x4 (_raw_=
spin_unlock_irqrestore+0x28)
[   40.191621]      #end     0x80000001    -45 hard_local_irq_restore+0x15 =
(ipipe_root_only+0x40)
[   40.191621]      #begin   0x80000001    -45 hard_local_irq_save+0x16 (ip=
ipe_root_only+0xf)
[   40.191621]      #func                  -45 ipipe_root_only+0x5 (ipipe_r=
estore_root+0x10)
[   40.191621]      #func                  -45 ipipe_restore_root+0x4 (_raw=
_spin_unlock_irqrestore+0x1e)
[   40.191621]      #func                  -45 _raw_spin_unlock_irqrestore+=
0x3 (try_to_wake_up+0x189)
[   40.191621]      #func                  -45 __ipipe_spin_unlock_debug+0x=
3 (try_to_wake_up+0x17e)
[   40.191621]      #func                  -45 sub_preempt_count+0x4 (_raw_=
spin_unlock+0x15)
[   40.191621]      #func                  -45 _raw_spin_unlock+0x3 (try_to=
_wake_up+0x16b)
[   40.191621]      #func                  -45 task_woken_rt+0x4 (ttwu_do_w=
akeup+0x6d)
[   40.191621]      #func                  -46 check_preempt_curr_rt+0x9 (c=
heck_preempt_curr+0x31)
[   40.191621]      #func                  -46 check_preempt_curr+0x9 (ttwu=
_do_wakeup+0x57)
[   40.191621]      #func                  -46 ttwu_do_wakeup+0x9 (ttwu_do_=
activate+0x39)
[   40.191621]      #func                  -46 update_rt_migration+0x5 (enq=
ueue_task_rt+0x11f)
[   40.191621]      #func                  -46 enqueue_task_rt+0x9 (enqueue=
_task+0x27)
[   40.191621]      #end     0x80000001    -46 debug_smp_processor_id+0x82 =
(__cycles_2_ns+0x17)
[   40.191621]      #begin   0x80000001    -47 debug_smp_processor_id+0x36 =
(__cycles_2_ns+0x17)
[   40.191621]      #end     0x80000001    -47 debug_smp_processor_id+0x82 =
(sched_clock_cpu+0x95)
[   40.191621]      #begin   0x80000001    -47 debug_smp_processor_id+0x36 =
(sched_clock_cpu+0x95)
[   40.191621]      #func                  -47 update_rq_clock+0x5 (enqueue=
_task+0x1a)
[   40.191621]      #func                  -47 enqueue_task+0x9 (activate_t=
ask+0x24)
[   40.191621]      #func                  -47 activate_task+0x4 (ttwu_acti=
vate+0x13)
[   40.191621]      #func                  -47 ttwu_activate+0x5 (ttwu_do_a=
ctivate+0x2e)
[   40.191621]      #func                  -47 ttwu_do_activate+0x6 (try_to=
_wake_up+0x164)
[   40.191621]      #end     0x80000001    -48 hard_local_irq_restore+0x15 =
(ipipe_root_only+0x40)
[   40.191621]      #begin   0x80000001    -48 hard_local_irq_save+0x16 (ip=
ipe_root_only+0xf)
[   40.191621]      #func                  -48 ipipe_root_only+0x5 (add_pre=
empt_count+0x10)
[   40.191621]      #func                  -48 add_preempt_count+0x4 (_raw_=
spin_lock+0x15)
[   40.191621]      #func                  -48 _raw_spin_lock+0x4 (try_to_w=
ake_up+0x159)
[   40.191621]      #end     0x80000001    -48 debug_smp_processor_id+0x82 =
(try_to_wake_up+0xf3)
[   40.191621]      #begin   0x80000001    -48 debug_smp_processor_id+0x36 =
(try_to_wake_up+0xf3)
[   40.191621]      #func                  -48 select_task_rq_rt+0x6 (selec=
t_task_rq+0x17)
[   40.191621]      #end     0x80000001    -49 hard_local_irq_restore+0x15 =
(ipipe_root_only+0x40)
[   40.191621]      #begin   0x80000001    -49 hard_local_irq_save+0x16 (ip=
ipe_root_only+0xf)
[   40.191621]      #func                  -49 ipipe_root_only+0x5 (add_pre=
empt_count+0x10)
[   40.191621]      #func                  -49 add_preempt_count+0x4 (_raw_=
spin_lock_irqsave+0x49)
[   40.191621]      #func                  -49 _raw_spin_lock_irqsave+0x5 (=
try_to_wake_up+0x23)
[   40.191621]      #func                  -49 try_to_wake_up+0x9 (wake_up_=
process+0x14)
[   40.191621]      #func                  -49 wake_up_process+0x3 (lostage=
_handler+0xae)
[   40.191621]      #end     0x80000001    -49 debug_smp_processor_id+0x82 =
(lostage_handler+0x16)
[   40.191621]      #begin   0x80000001    -50 debug_smp_processor_id+0x36 =
(lostage_handler+0x16)
[   40.191621]      #func                  -50 lostage_handler+0xc (rthal_a=
pc_handler+0x6a)
[   40.191621]      #func                  -50 rthal_apc_handler+0x6 (__ipi=
pe_do_sync_stage+0x107)
[   40.191621]      #end     0x80000001    -50 hard_local_irq_restore+0x15 =
(ipipe_root_only+0x40)
[   40.191621]      #begin   0x80000001    -50 hard_local_irq_save+0x16 (ip=
ipe_root_only+0xf)
[   40.191621]      #func                  -50 ipipe_root_only+0x5 (add_pre=
empt_count+0x10)
[   40.191621]      #func                  -50 add_preempt_count+0x4 (irq_e=
nter+0x4f)
[   40.191621]      #end     0x80000001    -51 hard_local_irq_restore+0x15 =
(ipipe_root_only+0x40)
[   40.191621]      #begin   0x80000001    -51 hard_local_irq_save+0x16 (ip=
ipe_root_only+0xf)
[   40.191621]      #func                  -51 ipipe_root_only+0x5 (ipipe_r=
estore_root+0x10)
[   40.191621]      #func                  -51 ipipe_restore_root+0x4 (arch=
_local_irq_restore+0x11)
[   40.191621]      #end     0x80000001    -51 debug_smp_processor_id+0x82 =
(rcu_irq_enter+0x48)
[   40.191621]      #begin   0x80000001    -51 debug_smp_processor_id+0x36 =
(rcu_irq_enter+0x48)
[   40.191621]      #func                  -51 rcu_irq_enter+0x9 (irq_enter=
+0x15)
[   40.191621]      #end     0x80000001    -51 debug_smp_processor_id+0x82 =
(irq_enter+0xe)
[   40.191621]      #begin   0x80000001    -52 debug_smp_processor_id+0x36 =
(irq_enter+0xe)
[   40.191621]      #func                  -52 irq_enter+0x4 (__ipipe_do_sy=
nc_stage+0xf4)
[   40.191621]      #end     0x80000000    -52 hard_local_irq_enable+0x14 (=
__ipipe_do_sync_stage+0xc0)
[   40.191621]      +func                  -52 __ipipe_do_sync_stage+0x9 (_=
_ipipe_do_sync_pipeline+0x64)
[   40.191621]      +func                  -52 __ipipe_do_sync_pipeline+0x4=
 (__ipipe_dispatch_irq+0x170)
[   40.191621]     # func                  -52 taskSwitchXenomai+0x5 [sigma=
tek_lrt] (xnpod_fire_callouts+0x4b)
[   40.191621]     # func                  -52 xnpod_fire_callouts+0x9 (__x=
npod_schedule+0x503)
[   40.191621]     # [   19] gatekee -1    -53 __xnpod_schedule+0x47e (xnpo=
d_schedule+0x32)
[   40.191621]     # func                  -53 __switch_to+0x9 (__xnpod_sch=
edule+0x407)
[   40.191621]     # func                  -53 xnsched_pick_next+0x6 (__xnp=
od_schedule+0xae)
[   40.191621]     # [  244] Loader: 29    -53 __xnpod_schedule+0x5f (xnpod=
_schedule+0x32)
[   40.191621]     # func                  -54 __xnpod_schedule+0x9 (xnpod_=
schedule+0x32)
[   40.191621]     # func                  -54 xnpod_suspend_thread+0x9 (xn=
synch_sleep_on+0xb9)
[   40.191621]     # func                  -54 xnsynch_sleep_on+0x9 (rtdm_e=
vent_timedwait+0x87)
[   40.191621]     + begin   0x80000000    -54 ipipe_test_and_stall_pipelin=
e_head+0x15 (__xnlock_get_irqsave+0xc)
[   40.191621]     + func                  -54 rtdm_event_timedwait+0x9 (rt=
dm_event_wait+0x13)
[   40.191621]     + func                  -54 rtdm_event_wait+0x3 (lrtdrv_=
timing_wait+0xcf [sigmatek_lrt])
[   40.191621]     + end     0x80000001    -54 lrtdrv_timing_wait+0x78 [sig=
matek_lrt] (lrt_ioctl_work+0x3ad [sigmatek_lrt])
[   40.191621]     + begin   0x80000001    -54 lrtdrv_timing_wait+0x2c [sig=
matek_lrt] (lrt_ioctl_work+0x3ad [sigmatek_lrt])
[   40.191621]     + func                  -54 lrtdrv_timing_wait+0x9 [sigm=
atek_lrt] (lrt_ioctl_work+0x3ad [sigmatek_lrt])
[   40.191621]     + func                  -55 lrt_ioctl_work+0x9 [sigmatek=
_lrt] (lrt_ioctl+0x10 [sigmatek_lrt])
[   40.191621]     + func                  -55 lrt_ioctl+0x3 [sigmatek_lrt]=
 (__rt_dev_ioctl+0x40)
[   40.191621]     + end     0x80000001    -55 rtdm_in_rt_context+0x67 (__r=
t_dev_ioctl+0x30)
[   40.191621]     + begin   0x80000001    -55 rtdm_in_rt_context+0x1d (__r=
t_dev_ioctl+0x30)
[   40.191621]     + end     0x80000000    -55 hard_local_irq_enable+0x14 (=
__ipipe_restore_head+0x66)
[   40.191621]     # func                  -55 __ipipe_restore_head+0x4 (ip=
ipe_restore_pipeline_head+0x4d)
[   40.191621]     + begin   0x80000000    -55 ipipe_test_and_stall_pipelin=
e_head+0x15 (__xnlock_get_irqsave+0xc)
[   40.191621]     + func                  -55 rtdm_context_get+0x5 (__rt_d=
ev_ioctl+0x1e)
[   40.191621]     + func                  -55 __rt_dev_ioctl+0x9 (sys_rtdm=
_ioctl+0x1d)
[   40.191621]     + func                  -56 sys_rtdm_ioctl+0x3 (hisyscal=
l_event+0x124)
[   40.191621]     + func                  -56 hisyscall_event+0x9 (ipipe_s=
yscall_hook+0x88)
[   40.191621]     + end     0x80000001    -56 ipipe_syscall_hook+0x75 (__i=
pipe_notify_syscall+0x63)
[   40.191621]     + begin   0x80000001    -56 ipipe_syscall_hook+0x2b (__i=
pipe_notify_syscall+0x63)
[   40.191621]     + func                  -56 ipipe_syscall_hook+0x9 (__ip=
ipe_notify_syscall+0x63)
[   40.191621]     + end     0x80000001    -56 hard_local_irq_restore+0x15 =
(__ipipe_notify_syscall+0x58)
[   40.191621]     + begin   0x80000001    -56 hard_local_irq_save+0x16 (__=
ipipe_notify_syscall+0x16)
[   40.191621]     + func                  -56 __ipipe_notify_syscall+0x9 (=
__ipipe_syscall_root+0x2e)
[   40.191621]     + func                  -56 __ipipe_syscall_root+0x6 (sy=
stem_call+0x2d)
[   40.191621]     + begin   0x80000001    -57 hard_local_irq_save+0x16 (__=
ipipe_syscall_root+0x35)
[   40.191621]     + end     0x80000001    -57 hard_local_irq_restore+0x15 =
(__ipipe_notify_syscall+0xc5)
[   40.191621]     + begin   0x80000001    -57 hard_local_irq_save+0x16 (__=
ipipe_notify_syscall+0x6a)
[   40.191621]     + func                  -58 __copy_to_user_ll+0x6 (rtdm_=
safe_copy_to_user+0x2b [platform_edge])
[   40.191621]     + func                  -58 xnarch_tsc_to_ns+0x5 (xnarch=
_get_cpu_time+0xf)
[   40.191621]     + func                  -58 xnarch_get_cpu_time+0x3 (pla=
tform_get_xenomai_time+0x17 [platform_edge])
[   40.191621]     + func                  -58 platform_get_xenomai_time+0x=
5 [platform_edge] (plc_platform_ioctl_rt+0x46a [platform_edge])
[   40.191621]     + func                  -58 plc_platform_ioctl_rt+0x9 [p=
latform_edge] (__rt_dev_ioctl+0x40)
[   40.191621]     + end     0x80000001    -58 rtdm_in_rt_context+0x67 (__r=
t_dev_ioctl+0x30)
[   40.191621]     + begin   0x80000001    -58 rtdm_in_rt_context+0x1d (__r=
t_dev_ioctl+0x30)
[   40.191621]     + end     0x80000000    -58 hard_local_irq_enable+0x14 (=
__ipipe_restore_head+0x66)
[   40.191621]     # func                  -58 __ipipe_restore_head+0x4 (ip=
ipe_restore_pipeline_head+0x4d)
[   40.191621]     + begin   0x80000000    -59 ipipe_test_and_stall_pipelin=
e_head+0x15 (__xnlock_get_irqsave+0xc)
[   40.191621]     + func                  -59 rtdm_context_get+0x5 (__rt_d=
ev_ioctl+0x1e)
[   40.191621]     + func                  -59 __rt_dev_ioctl+0x9 (sys_rtdm=
_ioctl+0x1d)
[   40.191621]     + func                  -59 sys_rtdm_ioctl+0x3 (hisyscal=
l_event+0x124)
[   40.191621]     + func                  -59 hisyscall_event+0x9 (ipipe_s=
yscall_hook+0x88)
[   40.191621]     + end     0x80000001    -59 ipipe_syscall_hook+0x75 (__i=
pipe_notify_syscall+0x63)
[   40.191621]     + begin   0x80000001    -59 ipipe_syscall_hook+0x2b (__i=
pipe_notify_syscall+0x63)
[   40.191621]     + func                  -59 ipipe_syscall_hook+0x9 (__ip=
ipe_notify_syscall+0x63)
[   40.191621]     + end     0x80000001    -59 hard_local_irq_restore+0x15 =
(__ipipe_notify_syscall+0x58)
[   40.191621]     + begin   0x80000001    -60 hard_local_irq_save+0x16 (__=
ipipe_notify_syscall+0x16)
[   40.191621]     + func                  -60 __ipipe_notify_syscall+0x9 (=
__ipipe_syscall_root+0x2e)
[   40.191621]     + func                  -60 __ipipe_syscall_root+0x6 (sy=
stem_call+0x2d)
[   40.191621]     + begin   0x80000001    -60 hard_local_irq_save+0x16 (__=
ipipe_syscall_root+0x35)
[   40.191621]     + end     0x80000001    -60 hard_local_irq_restore+0x15 =
(__ipipe_notify_syscall+0xc5)
[   40.191621]     + begin   0x80000001    -60 hard_local_irq_save+0x16 (__=
ipipe_notify_syscall+0x6a)
[   40.191621]     + func                  -61 __copy_to_user_ll+0x6 (rtdm_=
safe_copy_to_user+0x2b [sigmatek_lrt])
[   40.191621]     + end     0x80000000    -61 hard_local_irq_enable+0x14 (=
__ipipe_restore_head+0x66)
[   40.191621]     # func                  -61 __ipipe_restore_head+0x4 (ip=
ipe_restore_pipeline_head+0x4d)
[   40.191621]     # func                  -61 taskSwitchXenomai+0x5 [sigma=
tek_lrt] (xnpod_fire_callouts+0x4b)
[   40.191621]     # func                  -61 xnpod_fire_callouts+0x9 (__x=
npod_schedule+0x503)
[   40.191621]     # [  244] Loader: 29    -61 __xnpod_schedule+0x47e (xnpo=
d_schedule+0x32)
[   40.191621]     # func                  -62 __switch_to+0x9 (__xnpod_sch=
edule+0x407)
[   40.191621]     # func                  -62 xnsched_pick_next+0x6 (__xnp=
od_schedule+0xae)
[   40.191621]     # [  248] realtim 95    -62 __xnpod_schedule+0x5f (xnpod=
_schedule+0x32)
[   40.191621]     # func                  -62 __xnpod_schedule+0x9 (xnpod_=
schedule+0x32)
[   40.191621]     # func                  -63 xnpod_suspend_thread+0x9 (xn=
synch_sleep_on+0xb9)
[   40.191621]     # func                  -63 xnsynch_sleep_on+0x9 (rtdm_e=
vent_timedwait+0x87)
[   40.191621]     + begin   0x80000000    -63 ipipe_test_and_stall_pipelin=
e_head+0x15 (__xnlock_get_irqsave+0xc)
[   40.191621]     + func                  -63 rtdm_event_timedwait+0x9 (rt=
dm_event_wait+0x13)
[   40.191621]     + func                  -63 rtdm_event_wait+0x3 (lrtdrv_=
timing_wait+0xcf [sigmatek_lrt])
[   40.191621]     + end     0x80000001    -63 lrtdrv_timing_wait+0x78 [sig=
matek_lrt] (lrt_ioctl_work+0x43d [sigmatek_lrt])
[   40.191621]     + begin   0x80000001    -63 lrtdrv_timing_wait+0x2c [sig=
matek_lrt] (lrt_ioctl_work+0x43d [sigmatek_lrt])
[   40.191621]     + func                  -63 lrtdrv_timing_wait+0x9 [sigm=
atek_lrt] (lrt_ioctl_work+0x43d [sigmatek_lrt])
[   40.191621]     + func                  -64 rt_task_self+0x3 (setup_watc=
hdog+0x44 [sigmatek_lrt])
[   40.191621]     + func                  -64 setup_watchdog+0x6 [sigmatek=
_lrt] (lrtdrv_timing_watchdog+0x48 [sigmatek_lrt])
[   40.191621]     + func                  -64 lrtdrv_timing_watchdog+0x6 [=
sigmatek_lrt] (lrt_ioctl_work+0x425 [sigmatek_lrt])
[   40.191621]     + func                  -64 __copy_from_user_ll_nozero+0=
x6 (rtdm_safe_copy_from_user+0x2d [sigmatek_lrt])
[   40.191621]     + func                  -64 lrt_ioctl_work+0x9 [sigmatek=
_lrt] (lrt_ioctl+0x10 [sigmatek_lrt])
[   40.191621]     + func                  -64 lrt_ioctl+0x3 [sigmatek_lrt]=
 (__rt_dev_ioctl+0x40)
[   40.191621]     + end     0x80000001    -64 rtdm_in_rt_context+0x67 (__r=
t_dev_ioctl+0x30)
[   40.191621]     + begin   0x80000001    -65 rtdm_in_rt_context+0x1d (__r=
t_dev_ioctl+0x30)
[   40.191621]     + end     0x80000000    -65 hard_local_irq_enable+0x14 (=
__ipipe_restore_head+0x66)
[   40.191621]     # func                  -65 __ipipe_restore_head+0x4 (ip=
ipe_restore_pipeline_head+0x4d)
[   40.191621]     + begin   0x80000000    -65 ipipe_test_and_stall_pipelin=
e_head+0x15 (__xnlock_get_irqsave+0xc)
[   40.191621]     + func                  -65 rtdm_context_get+0x5 (__rt_d=
ev_ioctl+0x1e)
[   40.191621]     + func                  -65 __rt_dev_ioctl+0x9 (sys_rtdm=
_ioctl+0x1d)
[   40.191621]     + func                  -65 sys_rtdm_ioctl+0x3 (hisyscal=
l_event+0x124)
[   40.191621]     + func                  -65 hisyscall_event+0x9 (ipipe_s=
yscall_hook+0x88)
[   40.191621]     + end     0x80000001    -65 ipipe_syscall_hook+0x75 (__i=
pipe_notify_syscall+0x63)
[   40.191621]     + begin   0x80000001    -66 ipipe_syscall_hook+0x2b (__i=
pipe_notify_syscall+0x63)
[   40.191621]     + func                  -66 ipipe_syscall_hook+0x9 (__ip=
ipe_notify_syscall+0x63)
[   40.191621]     + end     0x80000001    -66 hard_local_irq_restore+0x15 =
(__ipipe_notify_syscall+0x58)
[   40.191621]     + begin   0x80000001    -66 hard_local_irq_save+0x16 (__=
ipipe_notify_syscall+0x16)
[   40.191621]     + func                  -66 __ipipe_notify_syscall+0x9 (=
__ipipe_syscall_root+0x2e)
[   40.191621]     + func                  -66 __ipipe_syscall_root+0x6 (sy=
stem_call+0x2d)
[   40.191621]     + begin   0x80000001    -67 hard_local_irq_save+0x16 (__=
ipipe_syscall_root+0x35)
[   40.191621]     + end     0x80000001    -67 hard_local_irq_restore+0x15 =
(__ipipe_notify_syscall+0xc5)
[   40.191621]     + begin   0x80000001    -67 hard_local_irq_save+0x16 (__=
ipipe_notify_syscall+0x6a)
[   40.191621]     + end     0x80000000    -68 hard_local_irq_enable+0x14 (=
__ipipe_restore_head+0x66)
[   40.191621]     # func                  -68 __ipipe_restore_head+0x4 (xn=
lock_put_irqrestore+0x61)
[   40.191621]     + begin   0x80000000    -68 __xnlock_get_irqsave+0x19 (r=
t_queue_receive_inner+0x29)
[   40.191621]     + func                  -68 rt_queue_receive_inner+0x9 (=
__rt_queue_read+0x6b)
[   40.191621]     + func                  -68 __copy_from_user_ll_nozero+0=
x6 (__xn_safe_copy_from_user+0x28)
[   40.191621]     + func                  -68 xnregistry_fetch+0x3 (__rt_q=
ueue_read+0x30)
[   40.191621]     + func                  -68 __copy_from_user_ll_nozero+0=
x6 (__xn_safe_copy_from_user+0x28)
[   40.191621]     + func                  -69 __rt_queue_read+0x9 (hisysca=
ll_event+0x124)
[   40.191621]     + func                  -69 hisyscall_event+0x9 (ipipe_s=
yscall_hook+0x88)
[   40.191621]     + end     0x80000001    -69 ipipe_syscall_hook+0x75 (__i=
pipe_notify_syscall+0x63)
[   40.191621]     + begin   0x80000001    -69 ipipe_syscall_hook+0x2b (__i=
pipe_notify_syscall+0x63)
[   40.191621]     + func                  -69 ipipe_syscall_hook+0x9 (__ip=
ipe_notify_syscall+0x63)
[   40.191621]     + end     0x80000001    -69 hard_local_irq_restore+0x15 =
(__ipipe_notify_syscall+0x58)
[   40.191621]     + begin   0x80000001    -69 hard_local_irq_save+0x16 (__=
ipipe_notify_syscall+0x16)
[   40.191621]     + func                  -69 __ipipe_notify_syscall+0x9 (=
__ipipe_syscall_root+0x2e)
[   40.191621]     + func                  -70 __ipipe_syscall_root+0x6 (sy=
stem_call+0x2d)
[   40.191621]     + begin   0x80000001    -71 hard_local_irq_save+0x16 (__=
ipipe_syscall_root+0x35)
[   40.191621]     + end     0x80000001    -72 hard_local_irq_restore+0x15 =
(__ipipe_notify_syscall+0xc5)
[   40.191621]     + begin   0x80000001    -72 hard_local_irq_save+0x16 (__=
ipipe_notify_syscall+0x6a)
[   40.191621]     + func                  -72 __copy_to_user_ll+0x6 (rtdm_=
safe_copy_to_user+0x2b [platform_edge])
[   40.191621]     + func                  -72 xnarch_tsc_to_ns+0x5 (xnarch=
_get_cpu_time+0xf)
[   40.191621]     + func                  -72 xnarch_get_cpu_time+0x3 (pla=
tform_get_xenomai_time+0x17 [platform_edge])
[   40.191621]     + func                  -72 platform_get_xenomai_time+0x=
5 [platform_edge] (plc_platform_ioctl_rt+0x46a [platform_edge])
[   40.191621]     + func                  -72 plc_platform_ioctl_rt+0x9 [p=
latform_edge] (__rt_dev_ioctl+0x40)
[   40.191621]     + end     0x80000001    -72 rtdm_in_rt_context+0x67 (__r=
t_dev_ioctl+0x30)
[   40.191621]     + begin   0x80000001    -73 rtdm_in_rt_context+0x1d (__r=
t_dev_ioctl+0x30)
[   40.191621]     + end     0x80000000    -73 hard_local_irq_enable+0x14 (=
__ipipe_restore_head+0x66)
[   40.191621]     # func                  -73 __ipipe_restore_head+0x4 (ip=
ipe_restore_pipeline_head+0x4d)
[   40.191621]     + begin   0x80000000    -73 ipipe_test_and_stall_pipelin=
e_head+0x15 (__xnlock_get_irqsave+0xc)
[   40.191621]     + func                  -73 rtdm_context_get+0x5 (__rt_d=
ev_ioctl+0x1e)
[   40.191621]     + func                  -73 __rt_dev_ioctl+0x9 (sys_rtdm=
_ioctl+0x1d)
[   40.191621]     + func                  -73 sys_rtdm_ioctl+0x3 (hisyscal=
l_event+0x124)
[   40.191621]     + func                  -73 hisyscall_event+0x9 (ipipe_s=
yscall_hook+0x88)
[   40.191621]     + end     0x80000001    -74 ipipe_syscall_hook+0x75 (__i=
pipe_notify_syscall+0x63)
[   40.191621]     + begin   0x80000001    -74 ipipe_syscall_hook+0x2b (__i=
pipe_notify_syscall+0x63)
[   40.191621]     + func                  -74 ipipe_syscall_hook+0x9 (__ip=
ipe_notify_syscall+0x63)
[   40.191621]     + end     0x80000001    -74 hard_local_irq_restore+0x15 =
(__ipipe_notify_syscall+0x58)
[   40.191621]     + begin   0x80000001    -74 hard_local_irq_save+0x16 (__=
ipipe_notify_syscall+0x16)
[   40.191621]     + func                  -74 __ipipe_notify_syscall+0x9 (=
__ipipe_syscall_root+0x2e)
[   40.191621]     + func                  -74 __ipipe_syscall_root+0x6 (sy=
stem_call+0x2d)
[   40.191621]     + begin   0x80000001    -75 hard_local_irq_save+0x16 (__=
ipipe_syscall_root+0x35)
[   40.191621]     + end     0x80000001    -75 hard_local_irq_restore+0x15 =
(__ipipe_notify_syscall+0xc5)
[   40.191621]     + begin   0x80000001    -75 hard_local_irq_save+0x16 (__=
ipipe_notify_syscall+0x6a)
[   40.191621]     + func                  -76 __copy_to_user_ll+0x6 (rtdm_=
safe_copy_to_user+0x2b [sigmatek_lrt])
[   40.191621]     + end     0x80000000    -77 hard_local_irq_enable+0x14 (=
__ipipe_restore_head+0x66)
[   40.191621]     # func                  -77 __ipipe_restore_head+0x4 (ip=
ipe_restore_pipeline_head+0x4d)
[   40.191621]     # func                  -77 taskSwitchXenomai+0x5 [sigma=
tek_lrt] (xnpod_fire_callouts+0x4b)
[   40.191621]     # func                  -77 xnpod_fire_callouts+0x9 (__x=
npod_schedule+0x503)
[   40.191621]     # [  248] realtim 95    -79 __xnpod_schedule+0x47e (xnpo=
d_schedule+0x32)
[   40.191621]     # func                  -80 __switch_to+0x9 (__xnpod_sch=
edule+0x407)
[   40.191621]     # func                  -80 xnsched_pick_next+0x6 (__xnp=
od_schedule+0xae)
[   40.191621]     # [  246] cyclic: 96    -81 __xnpod_schedule+0x5f (xnpod=
_schedule+0x32)
[   40.191621]     # func                  -81 __xnpod_schedule+0x9 (xnpod_=
schedule+0x32)
[   40.191621]     # func                  -81 xnpod_schedule_handler+0x3 (=
__ipipe_dispatch_irq+0x13e)
[   40.191621]     + func                  -87 __ipipe_ack_apic+0x3 (__ipip=
e_dispatch_irq+0x94)
[   40.191621]     + func                  -88 __ipipe_dispatch_irq+0x9 (__=
ipipe_handle_irq+0x7e)
[   40.191621]     + func                  -88 __ipipe_handle_irq+0x6 (ipip=
e_reschedule_interrupt+0x37)
[   40.191621]     + begin   0xffffff0f    -88 ipipe_reschedule_interrupt+0=
x30 (hard_local_irq_enable+0x16)
[   40.191621]     + end     0x80000000    -91 hard_local_irq_enable+0x14 (=
__ipipe_restore_head+0x66)
[   40.191621]     # func                  -91 __ipipe_restore_head+0x4 (ip=
ipe_restore_pipeline_head+0x4d)
[   40.191621]     # func                  -92 xnpod_suspend_thread+0x9 (xn=
shadow_relax+0xaf)
[   40.191621]     # func                 -118 __xnlock_spin+0x4 (xnshadow_=
relax+0x81)
[   40.191621]     # func                 -119 __ipipe_set_irq_pending+0x6 =
(schedule_linux_call+0x81)
[   40.191621]     # func                 -119 schedule_linux_call+0x9 (xns=
hadow_relax+0x59)
[   40.191621]     + begin   0x80000000   -119 xnshadow_relax+0x3d (hisysca=
ll_event+0x243)
[   40.191621]     + func                 -119 xnshadow_relax+0xc (hisyscal=
l_event+0x243)
[   40.191621]     + func                 -119 hisyscall_event+0x9 (ipipe_s=
yscall_hook+0x88)
[   40.191621]     + end     0x80000001   -119 ipipe_syscall_hook+0x75 (__i=
pipe_notify_syscall+0x63)
[   40.191621]     + begin   0x80000001   -120 ipipe_syscall_hook+0x2b (__i=
pipe_notify_syscall+0x63)
[   40.191621]     + func                 -120 ipipe_syscall_hook+0x9 (__ip=
ipe_notify_syscall+0x63)
[   40.191621]     + end     0x80000001   -120 hard_local_irq_restore+0x15 =
(__ipipe_notify_syscall+0x58)
[   40.191621]     + begin   0x80000001   -120 hard_local_irq_save+0x16 (__=
ipipe_notify_syscall+0x16)
[   40.191621]     + func                 -120 __ipipe_notify_syscall+0x9 (=
__ipipe_syscall_root+0x2e)
[   40.191621]     + func                 -120 __ipipe_syscall_root+0x6 (sy=
stem_call+0x2d)
[   40.191621]     + begin   0x80000001   -137 hard_local_irq_save+0x16 (__=
ipipe_syscall_root+0x35)
[   40.191621]     + end     0x80000001   -137 hard_local_irq_restore+0x15 =
(__ipipe_notify_syscall+0xc5)
[   40.191621]     + begin   0x80000001   -137 hard_local_irq_save+0x16 (__=
ipipe_notify_syscall+0x6a)
[   40.191621]     + func                 -137 __copy_to_user_ll+0x6 (rtdm_=
safe_copy_to_user+0x2b [platform_edge])
[   40.191621]     + func                 -137 xnarch_tsc_to_ns+0x5 (xnarch=
_get_cpu_time+0xf)
[   40.191621]     + func                 -137 xnarch_get_cpu_time+0x3 (pla=
tform_get_xenomai_time+0x17 [platform_edge])
[   40.191621]     + func                 -137 platform_get_xenomai_time+0x=
5 [platform_edge] (plc_platform_ioctl_rt+0x46a [platform_edge])
[   40.191621]     + func                 -137 plc_platform_ioctl_rt+0x9 [p=
latform_edge] (__rt_dev_ioctl+0x40)
[   40.191621]     + end     0x80000001   -137 rtdm_in_rt_context+0x67 (__r=
t_dev_ioctl+0x30)
[   40.191621]     + begin   0x80000001   -138 rtdm_in_rt_context+0x1d (__r=
t_dev_ioctl+0x30)
[   40.191621]     + end     0x80000000   -138 hard_local_irq_enable+0x14 (=
__ipipe_restore_head+0x66)
[   40.191621]     # func                 -138 __ipipe_restore_head+0x4 (ip=
ipe_restore_pipeline_head+0x4d)
[   40.191621]     + begin   0x80000000   -138 ipipe_test_and_stall_pipelin=
e_head+0x15 (__xnlock_get_irqsave+0xc)
[   40.191621]     + func                 -138 rtdm_context_get+0x5 (__rt_d=
ev_ioctl+0x1e)
[   40.191621]     + func                 -138 __rt_dev_ioctl+0x9 (sys_rtdm=
_ioctl+0x1d)
[   40.191621]     + func                 -138 sys_rtdm_ioctl+0x3 (hisyscal=
l_event+0x124)
[   40.191621]     + func                 -138 hisyscall_event+0x9 (ipipe_s=
yscall_hook+0x88)
[   40.191621]     + end     0x80000001   -138 ipipe_syscall_hook+0x75 (__i=
pipe_notify_syscall+0x63)
[   40.191621]     + begin   0x80000001   -139 ipipe_syscall_hook+0x2b (__i=
pipe_notify_syscall+0x63)
[   40.191621]     + func                 -139 ipipe_syscall_hook+0x9 (__ip=
ipe_notify_syscall+0x63)
[   40.191621]     + end     0x80000001   -139 hard_local_irq_restore+0x15 =
(__ipipe_notify_syscall+0x58)
[   40.191621]     + begin   0x80000001   -139 hard_local_irq_save+0x16 (__=
ipipe_notify_syscall+0x16)
[   40.191621]     + func                 -139 __ipipe_notify_syscall+0x9 (=
__ipipe_syscall_root+0x2e)
[   40.191621]     + func                 -139 __ipipe_syscall_root+0x6 (sy=
stem_call+0x2d)
[   40.191621]     + begin   0x80000001   -141 hard_local_irq_save+0x16 (__=
ipipe_syscall_root+0x35)
[   40.191621]     + end     0x80000001   -141 hard_local_irq_restore+0x15 =
(__ipipe_notify_syscall+0xc5)
[   40.191621]     + begin   0x80000001   -141 hard_local_irq_save+0x16 (__=
ipipe_notify_syscall+0x6a)
[   40.191621]     + func                 -141 __copy_to_user_ll+0x6 (rtdm_=
safe_copy_to_user+0x2b [platform_edge])
[   40.191621]     + func                 -142 xnarch_tsc_to_ns+0x5 (xnarch=
_get_cpu_time+0xf)
[   40.191621]     + func                 -142 xnarch_get_cpu_time+0x3 (pla=
tform_get_xenomai_time+0x17 [platform_edge])
[   40.191621]     + func                 -142 platform_get_xenomai_time+0x=
5 [platform_edge] (plc_platform_ioctl_rt+0x46a [platform_edge])
[   40.191621]     + func                 -142 plc_platform_ioctl_rt+0x9 [p=
latform_edge] (__rt_dev_ioctl+0x40)
[   40.191621]     + end     0x80000001   -142 rtdm_in_rt_context+0x67 (__r=
t_dev_ioctl+0x30)
[   40.191621]     + begin   0x80000001   -142 rtdm_in_rt_context+0x1d (__r=
t_dev_ioctl+0x30)
[   40.191621]     + end     0x80000000   -142 hard_local_irq_enable+0x14 (=
__ipipe_restore_head+0x66)
[   40.191621]     # func                 -142 __ipipe_restore_head+0x4 (ip=
ipe_restore_pipeline_head+0x4d)
[   40.191621]     + begin   0x80000000   -142 ipipe_test_and_stall_pipelin=
e_head+0x15 (__xnlock_get_irqsave+0xc)
[   40.191621]     + func                 -143 rtdm_context_get+0x5 (__rt_d=
ev_ioctl+0x1e)
[   40.191621]     + func                 -143 __rt_dev_ioctl+0x9 (sys_rtdm=
_ioctl+0x1d)
[   40.191621]     + func                 -143 sys_rtdm_ioctl+0x3 (hisyscal=
l_event+0x124)
[   40.191621]     + func                 -143 hisyscall_event+0x9 (ipipe_s=
yscall_hook+0x88)
[   40.191621]     + end     0x80000001   -143 ipipe_syscall_hook+0x75 (__i=
pipe_notify_syscall+0x63)
[   40.191621]     + begin   0x80000001   -143 ipipe_syscall_hook+0x2b (__i=
pipe_notify_syscall+0x63)
[   40.191621]     + func                 -143 ipipe_syscall_hook+0x9 (__ip=
ipe_notify_syscall+0x63)
[   40.191621]     + end     0x80000001   -143 hard_local_irq_restore+0x15 =
(__ipipe_notify_syscall+0x58)
[   40.191621]     + begin   0x80000001   -144 hard_local_irq_save+0x16 (__=
ipipe_notify_syscall+0x16)
[   40.191621]     + func                 -144 __ipipe_notify_syscall+0x9 (=
__ipipe_syscall_root+0x2e)
[   40.191621]     + func                 -144 __ipipe_syscall_root+0x6 (sy=
stem_call+0x2d)
[   40.191621]     + begin   0x80000001   -149 hard_local_irq_save+0x16 (__=
ipipe_syscall_root+0x35)
[   40.191621]     + end     0x80000001   -149 hard_local_irq_restore+0x15 =
(__ipipe_notify_syscall+0xc5)
[   40.191621]     + begin   0x80000001   -149 hard_local_irq_save+0x16 (__=
ipipe_notify_syscall+0x6a)
[   40.191621]     + func                 -149 __copy_to_user_ll+0x6 (rtdm_=
safe_copy_to_user+0x2b [platform_edge])
[   40.191621]     + func                 -150 xnarch_tsc_to_ns+0x5 (xnarch=
_get_cpu_time+0xf)
[   40.191621]     + func                 -150 xnarch_get_cpu_time+0x3 (pla=
tform_get_xenomai_time+0x17 [platform_edge])
[   40.191621]     + func                 -150 platform_get_xenomai_time+0x=
5 [platform_edge] (plc_platform_ioctl_rt+0x46a [platform_edge])
[   40.191621]     + func                 -150 plc_platform_ioctl_rt+0x9 [p=
latform_edge] (__rt_dev_ioctl+0x40)
[   40.191621]     + end     0x80000001   -150 rtdm_in_rt_context+0x67 (__r=
t_dev_ioctl+0x30)
[   40.191621]     + begin   0x80000001   -150 rtdm_in_rt_context+0x1d (__r=
t_dev_ioctl+0x30)
[   40.191621]     + end     0x80000000   -150 hard_local_irq_enable+0x14 (=
__ipipe_restore_head+0x66)
[   40.191621]     # func                 -150 __ipipe_restore_head+0x4 (ip=
ipe_restore_pipeline_head+0x4d)
[   40.191621]     + begin   0x80000000   -151 ipipe_test_and_stall_pipelin=
e_head+0x15 (__xnlock_get_irqsave+0xc)
[   40.191621]     + func                 -151 rtdm_context_get+0x5 (__rt_d=
ev_ioctl+0x1e)
[   40.191621]     + func                 -151 __rt_dev_ioctl+0x9 (sys_rtdm=
_ioctl+0x1d)
[   40.191621]     + func                 -151 sys_rtdm_ioctl+0x3 (hisyscal=
l_event+0x124)
[   40.191621]     + func                 -151 hisyscall_event+0x9 (ipipe_s=
yscall_hook+0x88)
[   40.191621]     + end     0x80000001   -151 ipipe_syscall_hook+0x75 (__i=
pipe_notify_syscall+0x63)
[   40.191621]     + begin   0x80000001   -152 ipipe_syscall_hook+0x2b (__i=
pipe_notify_syscall+0x63)
[   40.191621]     + func                 -152 ipipe_syscall_hook+0x9 (__ip=
ipe_notify_syscall+0x63)
[   40.191621]     + end     0x80000001   -152 hard_local_irq_restore+0x15 =
(__ipipe_notify_syscall+0x58)
[   40.191621]     + begin   0x80000001   -152 hard_local_irq_save+0x16 (__=
ipipe_notify_syscall+0x16)
[   40.191621]     + func                 -152 __ipipe_notify_syscall+0x9 (=
__ipipe_syscall_root+0x2e)
[   40.191621]     + func                 -152 __ipipe_syscall_root+0x6 (sy=
stem_call+0x2d)
[   40.191621]     + begin   0x80000001   -184 hard_local_irq_save+0x16 (__=
ipipe_syscall_root+0x35)
[   40.191621]     + end     0x80000001   -184 hard_local_irq_restore+0x15 =
(__ipipe_notify_syscall+0xc5)
[   40.191621]     + begin   0x80000001   -184 hard_local_irq_save+0x16 (__=
ipipe_notify_syscall+0x6a)
[   40.191621]     + func                 -184 xnsynch_acquire+0x9 (rt_mute=
x_acquire_inner+0x8a)
[   40.191621]     + func                 -185 rt_mutex_acquire_inner+0x9 (=
__rt_mutex_acquire+0x5a)
[   40.191621]     + func                 -185 xnregistry_fetch+0x3 (__rt_m=
utex_acquire+0x41)
[   40.191621]     + func                 -185 __copy_from_user_ll_nozero+0=
x6 (__xn_safe_copy_from_user+0x28)
[   40.191621]     + func                 -185 __copy_from_user_ll_nozero+0=
x6 (__xn_safe_copy_from_user+0x28)
[   40.191621]     + func                 -185 __rt_mutex_acquire+0x8 (losy=
scall_event+0xa7)
[   40.191621]     + end     0x80000000   -185 hard_local_irq_enable+0x14 (=
__ipipe_restore_head+0x66)
[   40.191621]     # func                 -185 __ipipe_restore_head+0x4 (ip=
ipe_restore_pipeline_head+0x1f)
[   40.191621]     # func                 -186 xnpod_switch_fpu+0x3 (xnshad=
ow_harden+0x137)
[   40.191621]     # func                 -186 __ipipe_switch_tail+0x4 (__s=
chedule+0x4e8)
[   40.191621]     # func                 -186 __switch_to+0x9 (__schedule+=
0x4de)
[   40.191621]     # func                 -186 xnsched_pick_next+0x6 (__xnp=
od_schedule+0xae)
[   40.191621]     # [   19] gatekee -1   -187 __xnpod_schedule+0x5f (xnpod=
_schedule+0x32)
[   40.191621]     # func                 -187 __xnpod_schedule+0x9 (xnpod_=
schedule+0x32)
[   40.191621]     # func                 -187 xnpod_schedule_handler+0x3 (=
__ipipe_dispatch_irq+0x13e)
[   40.191621]      +func                 -187 __ipipe_dispatch_irq+0x9 (__=
ipipe_handle_irq+0x7e)
[   40.191621]      +func                 -187 __ipipe_handle_irq+0x6 (ipip=
e_raise_irq+0x2b)
[   40.191621]      +begin   0x80000001   -187 hard_local_irq_save+0x16 (ip=
ipe_raise_irq+0x14)
[   40.191621]      +func                 -188 ipipe_raise_irq+0x8 (__xnpod=
_schedule+0x26)
[   40.191621]      +end     0x80000001   -188 ipipe_get_current_domain+0x6=
7 (__xnpod_schedule+0x15)
[   40.191621]      +begin   0x80000001   -188 ipipe_get_current_domain+0x1=
d (__xnpod_schedule+0x15)
[   40.191621]      +func                 -188 __xnpod_schedule+0x9 (xnpod_=
schedule+0x32)
[   40.191621]      +end     0x80000000   -188 hard_local_irq_enable+0x14 (=
__ipipe_restore_head+0x66)
[   40.191621]     *+func                 -188 __ipipe_restore_head+0x4 (ip=
ipe_restore_pipeline_head+0x1f)
[   40.191621]     *+[  246] cyclic: 96   -188 xnpod_resume_thread+0x40 (ga=
tekeeper_thread+0x105)
[   40.191621]     *+func                 -189 xnpod_resume_thread+0x9 (gat=
ekeeper_thread+0x105)
[   40.191621]      +begin   0x80000000   -189 ipipe_test_and_stall_pipelin=
e_head+0x15 (__xnlock_get_irqsave+0xc)
[   40.191621]      +func                 -189 kthread_should_stop+0x3 (gat=
ekeeper_thread+0xc4)
[   40.191621]      +func                 -189 sub_preempt_count+0x4 (__sch=
edule+0x544)
[   40.191621]      +end     0x80000001   -189 debug_smp_processor_id+0x82 =
(__schedule+0x514)
[   40.191621]      +begin   0x80000001   -189 debug_smp_processor_id+0x36 =
(__schedule+0x514)
[   40.191621]      +func                 -190 sub_preempt_count+0x4 (_raw_=
spin_unlock_irq+0x1a)
[   40.191621]      +end     0x80000000   -190 hard_local_irq_enable+0x14 (=
ipipe_unstall_root+0x2b)
[   40.191621]      #func                 -190 ipipe_root_only+0x5 (ipipe_u=
nstall_root+0x12)
[   40.191621]      #begin   0x80000000   -190 hard_local_irq_disable+0x15 =
(ipipe_unstall_root+0xd)
[   40.191621]      #func                 -190 ipipe_unstall_root+0x3 (_raw=
_spin_unlock_irq+0x10)
[   40.191621]      #func                 -190 _raw_spin_unlock_irq+0x3 (fi=
nish_task_switch+0x4c)
[   40.191621]      #func                 -190 finish_task_switch+0x9 (__sc=
hedule+0x50f)
[   40.191621]      #end     0x80000001   -190 debug_smp_processor_id+0x82 =
(__schedule+0x4f8)
[   40.191621]      #begin   0x80000001   -191 debug_smp_processor_id+0x36 =
(__schedule+0x4f8)
[   40.191621]      #end     0x80000000   -191 hard_local_irq_enable+0x14 (=
__ipipe_switch_tail+0x34)
[   40.191621]      #func                 -191 __ipipe_switch_tail+0x4 (__s=
chedule+0x4e8)
[   40.191621]      #func                 -191 __switch_to+0x9 (__schedule+=
0x4de)
[   40.191621]      #begin   0x80000000   -191 __schedule+0x32d (schedule+0=
x5b)
[   40.191621]      #end     0x80000001   -191 hard_local_irq_restore+0x15 =
(__ipipe_notify_kevent+0x65)
[   40.191621]      #begin   0x80000001   -191 hard_local_irq_save+0x16 (__=
ipipe_notify_kevent+0x55)
[   40.191621]      #func                 -192 schedule_event+0x5 (ipipe_ke=
vent_hook+0x1c)
[   40.191621]      #func                 -192 ipipe_kevent_hook+0x4 (__ipi=
pe_notify_kevent+0x4e)
[   40.191621]      #end     0x80000001   -192 hard_local_irq_restore+0x15 =
(__ipipe_notify_kevent+0x43)
[   40.191621]      #begin   0x80000001   -192 hard_local_irq_save+0x16 (__=
ipipe_notify_kevent+0x20)
[   40.191621]      #end     0x80000001   -192 hard_local_irq_restore+0x15 =
(ipipe_root_only+0x40)
[   40.191621]      #begin   0x80000001   -192 hard_local_irq_save+0x16 (ip=
ipe_root_only+0xf)
[   40.191621]      #func                 -192 ipipe_root_only+0x5 (__ipipe=
_notify_kevent+0x1b)
[   40.191621]      #func                 -192 __ipipe_notify_kevent+0x9 (_=
_schedule+0x31b)
[   40.191621]      #func                 -192 pick_next_task_rt+0x6 (__sch=
edule+0x25f)
[   40.191621]      #func                 -192 pick_next_task_stop+0x3 (__s=
chedule+0x25f)
[   40.191621]      #func                 -193 sub_preempt_count+0x4 (_raw_=
spin_unlock+0x15)
[   40.191621]      #func                 -193 _raw_spin_unlock+0x3 (update=
_curr_rt+0x1eb)
[   40.191621]      #end     0x80000001   -193 hard_local_irq_restore+0x15 =
(ipipe_root_only+0x40)
[   40.191621]      #begin   0x80000001   -193 hard_local_irq_save+0x16 (ip=
ipe_root_only+0xf)
[   40.191621]      #func                 -193 ipipe_root_only+0x5 (add_pre=
empt_count+0x10)
[   40.191621]      #func                 -193 add_preempt_count+0x4 (_raw_=
spin_lock+0x15)
[   40.191621]      #func                 -193 _raw_spin_lock+0x4 (update_c=
urr_rt+0x113)
[   40.191621]      #func                 -193 sched_avg_update+0x9 (update=
_curr_rt+0xcc)
[   40.191621]      #func                 -193 update_curr_rt+0x9 (put_prev=
_task_rt+0x13)
[   40.191621]      #func                 -194 put_prev_task_rt+0x5 (__sche=
dule+0x235)
[   40.191621]      #func                 -194 pre_schedule_rt+0x3 (__sched=
ule+0x1fc)
[   40.191621]      #func                 -194 update_rt_migration+0x5 (__d=
equeue_rt_entity+0x13c)
[   40.191621]      #func                 -194 __dequeue_rt_entity+0x9 (deq=
ueue_task_rt+0x39)
[   40.191621]      #func                 -194 sub_preempt_count+0x4 (_raw_=
spin_unlock+0x15)
[   40.191621]      #func                 -194 _raw_spin_unlock+0x3 (update=
_curr_rt+0x1eb)
[   40.191621]      #end     0x80000001   -194 hard_local_irq_restore+0x15 =
(ipipe_root_only+0x40)
[   40.191621]      #begin   0x80000001   -194 hard_local_irq_save+0x16 (ip=
ipe_root_only+0xf)
[   40.191621]      #func                 -194 ipipe_root_only+0x5 (add_pre=
empt_count+0x10)
[   40.191621]      #func                 -194 add_preempt_count+0x4 (_raw_=
spin_lock+0x15)
[   40.191621]      #func                 -195 _raw_spin_lock+0x4 (update_c=
urr_rt+0x113)
[   40.191621]      #func                 -195 sched_avg_update+0x9 (update=
_curr_rt+0xcc)
[   40.191621]      #func                 -195 update_curr_rt+0x9 (dequeue_=
task_rt+0x1f)
[   40.191621]      #func                 -195 dequeue_task_rt+0x9 (dequeue=
_task+0x27)
[   40.191621]      #func                 -195 update_rq_clock+0x5 (dequeue=
_task+0x1a)
[   40.191621]      #func                 -195 dequeue_task+0x9 (deactivate=
_task+0x24)
[   40.191621]      #func                 -195 deactivate_task+0x4 (__sched=
ule+0x12d)
[   40.191621]      #end     0x80000001   -195 hard_local_irq_restore+0x15 =
(ipipe_root_only+0x40)
[   40.191621]      #begin   0x80000001   -195 hard_local_irq_save+0x16 (ip=
ipe_root_only+0xf)
[   40.191621]      #func                 -196 ipipe_root_only+0x5 (add_pre=
empt_count+0x10)
[   40.191621]      #func                 -196 add_preempt_count+0x4 (_raw_=
spin_lock_irq+0x28)
[   40.191621]      +func                 -196 _raw_spin_lock_irq+0x4 (__sc=
hedule+0xc5)
[   40.191621]      +end     0x80000001   -196 hard_local_irq_restore+0x15 =
(ipipe_root_only+0x40)
[   40.191621]      +begin   0x80000001   -196 hard_local_irq_save+0x16 (ip=
ipe_root_only+0xf)
[   40.191621]      +func                 -196 ipipe_root_only+0x5 (__sched=
ule+0x79)
[   40.191621]      +func                 -196 sub_preempt_count+0x4 (__sch=
edule+0x5a)
[   40.191621]      +end     0x80000000   -196 hard_local_irq_enable+0x14 (=
ipipe_unstall_root+0x2b)
[   40.191621]      #func                 -196 ipipe_root_only+0x5 (ipipe_u=
nstall_root+0x12)
[   40.191621]      #begin   0x80000000   -197 hard_local_irq_disable+0x15 =
(ipipe_unstall_root+0xd)
[   40.191621]      #func                 -197 ipipe_unstall_root+0x3 (ipip=
e_restore_root+0x2e)
[   40.191621]      #end     0x80000001   -197 hard_local_irq_restore+0x15 =
(ipipe_root_only+0x40)
[   40.191621]      #begin   0x80000001   -197 hard_local_irq_save+0x16 (ip=
ipe_root_only+0xf)
[   40.191621]      #func                 -197 ipipe_root_only+0x5 (ipipe_r=
estore_root+0x10)
[   40.191621]      #func                 -197 ipipe_restore_root+0x4 (arch=
_local_irq_restore+0x11)
[   40.191621]      +func                 -197 rcu_note_context_switch+0x9 =
(__schedule+0x3d)
[   40.191621]      +end     0x80000001   -197 debug_smp_processor_id+0x82 =
(__schedule+0x28)
[   40.191621]      +begin   0x80000001   -198 debug_smp_processor_id+0x36 =
(__schedule+0x28)
[   40.191621]      +end     0x80000001   -198 hard_local_irq_restore+0x15 =
(ipipe_root_only+0x40)
[   40.191621]      +begin   0x80000001   -198 hard_local_irq_save+0x16 (ip=
ipe_root_only+0xf)
[   40.191621]      +func                 -198 ipipe_root_only+0x5 (add_pre=
empt_count+0x10)
[   40.191621]      +func                 -198 add_preempt_count+0x4 (__sch=
edule+0x23)
[   40.191621]      +func                 -198 __schedule+0x9 (schedule+0x5=
b)
[   40.191621]      +func                 -198 schedule+0x3 (xnshadow_harde=
n+0xeb)
[   40.191621]      +func                 -198 sub_preempt_count+0x4 (_raw_=
spin_unlock_irqrestore+0x28)
[   40.191621]      +end     0x80000000   -198 hard_local_irq_enable+0x14 (=
ipipe_unstall_root+0x2b)
[   40.191621]      #func                 -199 ipipe_root_only+0x5 (ipipe_u=
nstall_root+0x12)
[   40.191621]      #begin   0x80000000   -199 hard_local_irq_disable+0x15 =
(ipipe_unstall_root+0xd)
[   40.191621]      #func                 -199 ipipe_unstall_root+0x3 (ipip=
e_restore_root+0x2e)
[   40.191621]      #end     0x80000001   -199 hard_local_irq_restore+0x15 =
(ipipe_root_only+0x40)
[   40.191621]      #begin   0x80000001   -199 hard_local_irq_save+0x16 (ip=
ipe_root_only+0xf)
[   40.191621]      #func                 -199 ipipe_root_only+0x5 (ipipe_r=
estore_root+0x10)
[   40.191621]      #func                 -199 ipipe_restore_root+0x4 (_raw=
_spin_unlock_irqrestore+0x1e)
[   40.191621]      #func                 -199 _raw_spin_unlock_irqrestore+=
0x3 (try_to_wake_up+0x189)
[   40.191621]      #func                 -199 __ipipe_spin_unlock_debug+0x=
3 (try_to_wake_up+0x17e)
[   40.191621]      #func                 -199 sub_preempt_count+0x4 (_raw_=
spin_unlock+0x15)
[   40.191621]      #func                 -200 _raw_spin_unlock+0x3 (try_to=
_wake_up+0x16b)
[   40.191621]      #func                 -200 task_woken_rt+0x4 (ttwu_do_w=
akeup+0x6d)
[   40.191621]      #end     0x80000001   -200 debug_smp_processor_id+0x82 =
(resched_task+0x51)
[   40.191621]      #begin   0x80000001   -200 debug_smp_processor_id+0x36 =
(resched_task+0x51)
[   40.191621]      #func                 -200 resched_task+0x5 (check_pree=
mpt_curr_rt+0xe2)
[   40.191621]      #func                 -200 check_preempt_curr_rt+0x9 (c=
heck_preempt_curr+0x31)
[   40.191621]      #func                 -200 check_preempt_curr+0x9 (ttwu=
_do_wakeup+0x57)
[   40.191621]      #func                 -200 ttwu_do_wakeup+0x9 (ttwu_do_=
activate+0x39)
[   40.191621]      #func                 -200 update_rt_migration+0x5 (enq=
ueue_task_rt+0x11f)
[   40.191621]      #func                 -201 cpupri_set+0x6 (enqueue_task=
_rt+0xff)
[   40.191621]      #func                 -201 enqueue_task_rt+0x9 (enqueue=
_task+0x27)
[   40.191621]      #end     0x80000001   -201 debug_smp_processor_id+0x82 =
(__cycles_2_ns+0x17)
[   40.191621]      #begin   0x80000001   -201 debug_smp_processor_id+0x36 =
(__cycles_2_ns+0x17)
[   40.191621]      #end     0x80000001   -201 debug_smp_processor_id+0x82 =
(sched_clock_cpu+0x95)
[   40.191621]      #begin   0x80000001   -201 debug_smp_processor_id+0x36 =
(sched_clock_cpu+0x95)
[   40.191621]      #func                 -201 update_rq_clock+0x5 (enqueue=
_task+0x1a)
[   40.191621]      #func                 -201 enqueue_task+0x9 (activate_t=
ask+0x24)
[   40.191621]      #func                 -202 activate_task+0x4 (ttwu_acti=
vate+0x13)
[   40.191621]      #func                 -202 ttwu_activate+0x5 (ttwu_do_a=
ctivate+0x2e)
[   40.191621]      #func                 -202 ttwu_do_activate+0x6 (try_to=
_wake_up+0x164)
[   40.191621]      #end     0x80000001   -202 hard_local_irq_restore+0x15 =
(ipipe_root_only+0x40)
[   40.191621]      #begin   0x80000001   -202 hard_local_irq_save+0x16 (ip=
ipe_root_only+0xf)
[   40.191621]      #func                 -202 ipipe_root_only+0x5 (add_pre=
empt_count+0x10)
[   40.191621]      #func                 -202 add_preempt_count+0x4 (_raw_=
spin_lock+0x15)
[   40.191621]      #func                 -202 _raw_spin_lock+0x4 (try_to_w=
ake_up+0x159)
[   40.191621]      #end     0x80000001   -202 debug_smp_processor_id+0x82 =
(try_to_wake_up+0xf3)
[   40.191621]      #begin   0x80000001   -202 debug_smp_processor_id+0x36 =
(try_to_wake_up+0xf3)
[   40.191621]      #func                 -203 select_task_rq_rt+0x6 (selec=
t_task_rq+0x17)
[   40.191621]      #end     0x80000001   -203 hard_local_irq_restore+0x15 =
(ipipe_root_only+0x40)
[   40.191621]      #begin   0x80000001   -203 hard_local_irq_save+0x16 (ip=
ipe_root_only+0xf)
[   40.191621]      #func                 -203 ipipe_root_only+0x5 (add_pre=
empt_count+0x10)
[   40.191621]      #func                 -203 add_preempt_count+0x4 (_raw_=
spin_lock_irqsave+0x49)
[   40.191621]      +func                 -203 _raw_spin_lock_irqsave+0x5 (=
try_to_wake_up+0x23)
[   40.191621]      +func                 -203 try_to_wake_up+0x9 (wake_up_=
process+0x14)
[   40.191621]      +func                 -203 wake_up_process+0x3 (xnshado=
w_harden+0xe6)
[   40.191621]      +end     0x80000001   -204 hard_local_irq_restore+0x15 =
(ipipe_root_only+0x40)
[   40.191621]      +begin   0x80000001   -204 hard_local_irq_save+0x16 (ip=
ipe_root_only+0xf)
[   40.191621]      +func                 -204 ipipe_root_only+0x5 (add_pre=
empt_count+0x10)
[   40.191621]      +func                 -204 add_preempt_count+0x4 (xnsha=
dow_harden+0x7e)
[   40.191621]      +func                 -204 sub_preempt_count+0x4 (_raw_=
spin_unlock_irqrestore+0x28)
[   40.191621]      +end     0x80000000   -204 hard_local_irq_enable+0x14 (=
ipipe_unstall_root+0x2b)
[   40.191621]      #func                 -204 ipipe_root_only+0x5 (ipipe_u=
nstall_root+0x12)
[   40.191621]      #begin   0x80000000   -204 hard_local_irq_disable+0x15 =
(ipipe_unstall_root+0xd)
[   40.191621]      #func                 -205 ipipe_unstall_root+0x3 (ipip=
e_restore_root+0x2e)
[   40.191621]      #end     0x80000001   -205 hard_local_irq_restore+0x15 =
(ipipe_root_only+0x40)
[   40.191621]      #begin   0x80000001   -205 hard_local_irq_save+0x16 (ip=
ipe_root_only+0xf)
[   40.191621]      #func                 -205 ipipe_root_only+0x5 (ipipe_r=
estore_root+0x10)
[   40.191621]      #func                 -205 ipipe_restore_root+0x4 (_raw=
_spin_unlock_irqrestore+0x1e)
[   40.191621]      #func                 -205 _raw_spin_unlock_irqrestore+=
0x3 (down_interruptible+0x3c)
[   40.191621]      #func                 -205 __ipipe_spin_unlock_debug+0x=
3 (down_interruptible+0x33)
[   40.191621]      #end     0x80000001   -205 hard_local_irq_restore+0x15 =
(ipipe_root_only+0x40)
[   40.191621]      #begin   0x80000001   -205 hard_local_irq_save+0x16 (ip=
ipe_root_only+0xf)
[   40.191621]      #func                 -205 ipipe_root_only+0x5 (add_pre=
empt_count+0x10)
[   40.191621]      #func                 -206 add_preempt_count+0x4 (_raw_=
spin_lock_irqsave+0x49)
[   40.191621]      +func                 -206 _raw_spin_lock_irqsave+0x5 (=
down_interruptible+0x12)
[   40.191621]      +func                 -206 down_interruptible+0x6 (xnsh=
adow_harden+0x57)
[   40.191621]      +func                 -206 xnshadow_harden+0x9 (losysca=
ll_event+0x7d)
[   40.191621]      +func                 -206 losyscall_event+0x9 (ipipe_s=
yscall_hook+0x88)
[   40.191621]      +end     0x80000001   -206 ipipe_syscall_hook+0x75 (__i=
pipe_notify_syscall+0x63)
[   40.191621]      +begin   0x80000001   -206 ipipe_syscall_hook+0x2b (__i=
pipe_notify_syscall+0x63)
[   40.191621]      +func                 -206 ipipe_syscall_hook+0x9 (__ip=
ipe_notify_syscall+0x63)
[   40.191621]      +end     0x80000001   -206 hard_local_irq_restore+0x15 =
(__ipipe_notify_syscall+0x58)
[   40.191621]     + begin   0x80000001   -207 hard_local_irq_save+0x16 (__=
ipipe_notify_syscall+0x6a)
[   40.191621]     + func                 -207 hisyscall_event+0x9 (ipipe_s=
yscall_hook+0x88)
[   40.191621]     + end     0x80000001   -207 ipipe_syscall_hook+0x75 (__i=
pipe_notify_syscall+0x63)
[   40.191621]     + begin   0x80000001   -207 ipipe_syscall_hook+0x2b (__i=
pipe_notify_syscall+0x63)
[   40.191621]     + func                 -207 ipipe_syscall_hook+0x9 (__ip=
ipe_notify_syscall+0x63)
[   40.191621]     + end     0x80000001   -207 hard_local_irq_restore+0x15 =
(__ipipe_notify_syscall+0x58)
[   40.191621]      +begin   0x80000001   -207 hard_local_irq_save+0x16 (__=
ipipe_notify_syscall+0x16)
[   40.191621]      +func                 -208 __ipipe_notify_syscall+0x9 (=
__ipipe_syscall_root+0x2e)
[   40.191621]      +func                 -208 __ipipe_syscall_root+0x6 (sy=
stem_call+0x2d)
[   40.191621]      +func                 -208 sub_preempt_count+0x4 (vfsmo=
unt_lock_local_unlock+0x27)
[   40.191621]      +end     0x80000001   -208 debug_smp_processor_id+0x82 =
(vfsmount_lock_local_unlock+0x13)
[   40.191621]      +begin   0x80000001   -208 debug_smp_processor_id+0x36 =
(vfsmount_lock_local_unlock+0x13)
[   40.191621]      +func                 -209 vfsmount_lock_local_unlock+0=
x4 (mntput_no_expire+0x26)
[   40.191621]      +end     0x80000001   -209 debug_smp_processor_id+0x82 =
(vfsmount_lock_local_lock+0x18)
[   40.191621]      +begin   0x80000001   -209 debug_smp_processor_id+0x36 =
(vfsmount_lock_local_lock+0x18)
[   40.191621]      +end     0x80000001   -209 hard_local_irq_restore+0x15 =
(ipipe_root_only+0x40)
[   40.191621]      +begin   0x80000001   -209 hard_local_irq_save+0x16 (ip=
ipe_root_only+0xf)
[   40.191621]      +func                 -209 ipipe_root_only+0x5 (add_pre=
empt_count+0x10)
[   40.191621]      +func                 -209 add_preempt_count+0x4 (vfsmo=
unt_lock_local_lock+0x13)
[   40.191621]      +func                 -209 vfsmount_lock_local_lock+0x4=
 (mntput_no_expire+0x15)
[   40.191621]      +func                 -209 mntput_no_expire+0x6 (mntput=
+0x27)
[   40.191621]      +func                 -210 mntput+0x3 (fput+0x18e)
[   40.191621]      +func                 -210 sub_preempt_count+0x4 (_raw_=
spin_unlock_irqrestore+0x28)
[   40.191621]      +end     0x80000000   -210 hard_local_irq_enable+0x14 (=
ipipe_unstall_root+0x2b)
[   40.191621]      #func                 -210 ipipe_root_only+0x5 (ipipe_u=
nstall_root+0x12)
[   40.191621]      #begin   0x80000000   -210 hard_local_irq_disable+0x15 =
(ipipe_unstall_root+0xd)
[   40.191621]      #func                 -210 ipipe_unstall_root+0x3 (ipip=
e_restore_root+0x2e)
[   40.191621]      #end     0x80000001   -210 hard_local_irq_restore+0x15 =
(ipipe_root_only+0x40)
[   40.191621]      #begin   0x80000001   -210 hard_local_irq_save+0x16 (ip=
ipe_root_only+0xf)
[   40.191621]      #func                 -211 ipipe_root_only+0x5 (ipipe_r=
estore_root+0x10)
[   40.191621]      #func                 -211 ipipe_restore_root+0x4 (_raw=
_spin_unlock_irqrestore+0x1e)
[   40.191621]      #func                 -211 _raw_spin_unlock_irqrestore+=
0x3 (slob_free+0x2ac)
[   40.191621]      #func                 -211 __ipipe_spin_unlock_debug+0x=
3 (slob_free+0x29f)
[   40.191621]      #func                 -211 set_slob+0x4 (slob_free+0x29=
7)
[   40.191621]      #func                 -211 set_slob+0x4 (slob_free+0x23=
c)
[   40.191621]      #end     0x80000001   -212 hard_local_irq_restore+0x15 =
(ipipe_root_only+0x40)
[   40.191621]      #begin   0x80000001   -212 hard_local_irq_save+0x16 (ip=
ipe_root_only+0xf)
[   40.191621]      #func                 -212 ipipe_root_only+0x5 (add_pre=
empt_count+0x10)
[   40.191621]      #func                 -212 add_preempt_count+0x4 (_raw_=
spin_lock_irqsave+0x49)
[   40.191621]      +func                 -212 _raw_spin_lock_irqsave+0x5 (=
slob_free+0x4a)
[   40.191621]      +func                 -213 slob_free+0x9 (__kmem_cache_=
free+0x18)
[   40.191621]      +func                 -213 __kmem_cache_free+0x4 (kmem_=
cache_free+0x31)
[   40.191621]      +func                 -213 kmem_cache_free+0x6 (__d_fre=
e+0x40)
[   40.191621]      +func                 -213 __d_free+0x4 (d_free+0x3b)
[   40.191621]      +func                 -213 d_free+0x4 (dentry_kill+0x12=
2)
[   40.191621]      +func                 -213 sub_preempt_count+0x4 (_raw_=
spin_unlock_irqrestore+0x28)
[   40.191621]      +end     0x80000000   -213 hard_local_irq_enable+0x14 (=
ipipe_unstall_root+0x2b)
[   40.191621]      #func                 -213 ipipe_root_only+0x5 (ipipe_u=
nstall_root+0x12)
[   40.191621]      #begin   0x80000000   -213 hard_local_irq_disable+0x15 =
(ipipe_unstall_root+0xd)
[   40.191621]      #func                 -214 ipipe_unstall_root+0x3 (ipip=
e_restore_root+0x2e)
[   40.191621]      #end     0x80000001   -214 hard_local_irq_restore+0x15 =
(ipipe_root_only+0x40)
[   40.191621]      #begin   0x80000001   -214 hard_local_irq_save+0x16 (ip=
ipe_root_only+0xf)
[   40.191621]      #func                 -214 ipipe_root_only+0x5 (ipipe_r=
estore_root+0x10)
[   40.191621]      #func                 -214 ipipe_restore_root+0x4 (_raw=
_spin_unlock_irqrestore+0x1e)
[   40.191621]      #func                 -214 _raw_spin_unlock_irqrestore+=
0x3 (slob_free+0x2ac)
[   40.191621]      #func                 -214 __ipipe_spin_unlock_debug+0x=
3 (slob_free+0x29f)
[   40.191621]      #func                 -214 set_slob+0x4 (slob_free+0x29=
7)
[   40.191621]      #func                 -214 set_slob+0x4 (slob_free+0x23=
c)
[   40.191621]      #end     0x80000001   -215 hard_local_irq_restore+0x15 =
(ipipe_root_only+0x40)
[   40.191621]      #begin   0x80000001   -215 hard_local_irq_save+0x16 (ip=
ipe_root_only+0xf)
[   40.191621]      #func                 -215 ipipe_root_only+0x5 (add_pre=
empt_count+0x10)
[   40.191621]      #func                 -215 add_preempt_count+0x4 (_raw_=
spin_lock_irqsave+0x49)
[   40.191621]      +func                 -215 _raw_spin_lock_irqsave+0x5 (=
slob_free+0x4a)
[   40.191621]      +func                 -215 slob_free+0x9 (__kmem_cache_=
free+0x18)
[   40.191621]      +func                 -215 __kmem_cache_free+0x4 (kmem_=
cache_free+0x31)
[   40.191621]      +func                 -216 kmem_cache_free+0x6 (sock_de=
stroy_inode+0x28)
[   40.191621]      +end     0x80000000   -216 hard_local_irq_enable+0x14 (=
ipipe_unstall_root+0x2b)
[   40.191621]      #func                 -216 ipipe_root_only+0x5 (ipipe_u=
nstall_root+0x12)
[   40.191621]      #begin   0x80000000   -216 hard_local_irq_disable+0x15 =
(ipipe_unstall_root+0xd)
[   40.191621]      #func                 -216 ipipe_unstall_root+0x3 (ipip=
e_restore_root+0x2e)
[   40.191621]      #end     0x80000001   -216 hard_local_irq_restore+0x15 =
(ipipe_root_only+0x40)
[   40.191621]      #begin   0x80000001   -216 hard_local_irq_save+0x16 (ip=
ipe_root_only+0xf)
[   40.191621]      #func                 -216 ipipe_root_only+0x5 (ipipe_r=
estore_root+0x10)
[   40.191621]      #func                 -216 ipipe_restore_root+0x4 (arch=
_local_irq_restore+0x11)
[   40.191621]      #end     0x80000001   -217 debug_smp_processor_id+0x82 =
(__call_rcu+0x8f)
[   40.191621]      #begin   0x80000001   -217 debug_smp_processor_id+0x36 =
(__call_rcu+0x8f)
[   40.191621]      +func                 -217 __call_rcu+0x9 (kfree_call_r=
cu+0x14)
[   40.191621]      +func                 -217 kfree_call_rcu+0x3 (sock_des=
troy_inode+0x1c)
[   40.191621]      +func                 -217 sock_destroy_inode+0x4 (dest=
roy_inode+0x35)
[   40.191621]      +func                 -217 sub_preempt_count+0x4 (_raw_=
spin_unlock+0x15)
[   40.191621]      +func                 -217 _raw_spin_unlock+0x3 (fsnoti=
fy_clear_marks_by_inode+0x72)
[   40.191621]      +end     0x80000001   -217 hard_local_irq_restore+0x15 =
(ipipe_root_only+0x40)
[   40.191621]      +begin   0x80000001   -218 hard_local_irq_save+0x16 (ip=
ipe_root_only+0xf)
[   40.191621]      +func                 -218 ipipe_root_only+0x5 (add_pre=
empt_count+0x10)
[   40.191621]      +func                 -218 add_preempt_count+0x4 (_raw_=
spin_lock+0x15)
[   40.191621]      +func                 -218 _raw_spin_lock+0x4 (fsnotify=
_clear_marks_by_inode+0x23)
[   40.191621]      +func                 -218 fsnotify_clear_marks_by_inod=
e+0x9 (__fsnotify_inode_delete+0xd)
[   40.191621]      +func                 -218 __fsnotify_inode_delete+0x3 =
(__destroy_inode+0x1f)
[   40.191621]      +func                 -218 inode_has_buffers+0x3 (__des=
troy_inode+0x10)
[   40.191621]      +func                 -218 __destroy_inode+0x4 (destroy=
_inode+0x24)
[   40.191621]      +func                 -218 destroy_inode+0x4 (evict+0x1=
29)
[   40.191621]      +func                 -218 sub_preempt_count+0x4 (_raw_=
spin_unlock+0x15)
[   40.191621]      +func                 -219 _raw_spin_unlock+0x3 (evict+=
0x122)
[   40.191621]      +func                 -219 __wake_up_bit+0x7 (wake_up_b=
it+0x61)
[   40.191621]      +func                 -219 wake_up_bit+0x6 (evict+0x111)
[   40.191621]      +end     0x80000001   -219 hard_local_irq_restore+0x15 =
(ipipe_root_only+0x40)
[   40.191621]      +begin   0x80000001   -219 hard_local_irq_save+0x16 (ip=
ipe_root_only+0xf)
[   40.191621]      +func                 -219 ipipe_root_only+0x5 (add_pre=
empt_count+0x10)
[   40.191621]      +func                 -219 add_preempt_count+0x4 (_raw_=
spin_lock+0x15)
[   40.191621]      +func                 -219 _raw_spin_lock+0x4 (evict+0x=
104)
[   40.191621]      +end     0x80000001   -220 hard_local_irq_restore+0x15 =
(ipipe_root_only+0x40)
[   40.191621]      +begin   0x80000001   -220 hard_local_irq_save+0x16 (ip=
ipe_root_only+0xf)
[   40.191621]      +func                 -220 ipipe_root_only+0x5 (end_wri=
teback+0x5c)
[   40.191621]      +func                 -220 sub_preempt_count+0x4 (_raw_=
spin_unlock_irq+0x1a)
[   40.191621]      +end     0x80000000   -220 hard_local_irq_enable+0x14 (=
ipipe_unstall_root+0x2b)
[   40.191621]      #func                 -220 ipipe_root_only+0x5 (ipipe_u=
nstall_root+0x12)
[   40.191621]      #begin   0x80000000   -220 hard_local_irq_disable+0x15 =
(ipipe_unstall_root+0xd)
[   40.191621]      #func                 -220 ipipe_unstall_root+0x3 (_raw=
_spin_unlock_irq+0x10)
[   40.191621]      #func                 -221 _raw_spin_unlock_irq+0x3 (en=
d_writeback+0x32)
[   40.191621]      #end     0x80000001   -221 hard_local_irq_restore+0x15 =
(ipipe_root_only+0x40)
[   40.191621]      #begin   0x80000001   -221 hard_local_irq_save+0x16 (ip=
ipe_root_only+0xf)
[   40.191621]      #func                 -221 ipipe_root_only+0x5 (add_pre=
empt_count+0x10)
[   40.191621]      #func                 -221 add_preempt_count+0x4 (_raw_=
spin_lock_irq+0x28)
[   40.191621]      +func                 -221 _raw_spin_lock_irq+0x4 (end_=
writeback+0x1e)
[   40.191621]      +end     0x80000001   -221 hard_local_irq_restore+0x15 =
(ipipe_root_only+0x40)
[   40.191621]      +begin   0x80000001   -221 hard_local_irq_save+0x16 (ip=
ipe_root_only+0xf)
[   40.191621]      +func                 -221 ipipe_root_only+0x5 (end_wri=
teback+0x11)
[   40.191621]      +func                 -222 end_writeback+0x5 (evict+0xa=
f)
[   40.191621]      +func                 -222 evict+0x6 (iput+0x155)
[   40.191621]      +func                 -222 sub_preempt_count+0x4 (_raw_=
spin_unlock+0x15)
[   40.191621]      +func                 -222 _raw_spin_unlock+0x3 (iput+0=
x14e)
[   40.191621]      +end     0x80000001   -222 hard_local_irq_restore+0x15 =
(ipipe_root_only+0x40)
[   40.191621]      +begin   0x80000001   -222 hard_local_irq_save+0x16 (ip=
ipe_root_only+0xf)
[   40.191621]      +func                 -222 ipipe_root_only+0x5 (add_pre=
empt_count+0x10)
[   40.191621]      +func                 -222 add_preempt_count+0x4 (_raw_=
spin_lock+0x15)
[   40.191621]      +func                 -223 _raw_spin_lock+0x4 (_atomic_=
dec_and_lock+0x29)
[   40.191621]      +func                 -223 iput+0x6 (dentry_kill+0x10f)
[   40.191621]      +func                 -223 sub_preempt_count+0x4 (_raw_=
spin_unlock+0x15)
[   40.191621]      +func                 -223 _raw_spin_unlock+0x3 (dentry=
_kill+0xce)
[   40.191621]      +func                 -223 sub_preempt_count+0x4 (_raw_=
spin_unlock+0x15)
[   40.191621]      +func                 -223 _raw_spin_unlock+0x3 (dentry=
_kill+0xc6)
[   40.191621]      +func                 -223 __d_drop+0x4 (dentry_kill+0x=
6e)
[   40.191621]      +func                 -223 dentry_lru_prune+0x5 (dentry=
_kill+0x67)
[   40.191621]      +end     0x80000001   -224 hard_local_irq_restore+0x15 =
(ipipe_root_only+0x40)
[   40.191621]      +begin   0x80000001   -224 hard_local_irq_save+0x16 (ip=
ipe_root_only+0xf)
[   40.191621]      +func                 -224 ipipe_root_only+0x5 (add_pre=
empt_count+0x10)
[   40.191621]      +func                 -224 add_preempt_count+0x4 (_raw_=
spin_trylock+0x15)
[   40.191621]      +func                 -224 _raw_spin_trylock+0x4 (dentr=
y_kill+0x1d)
[   40.191621]      +end     0x80000001   -224 hard_local_irq_restore+0x15 =
(ipipe_root_only+0x40)
[   40.191621]      +begin   0x80000001   -224 hard_local_irq_save+0x16 (ip=
ipe_root_only+0xf)
[   40.191621]      +func                 -224 ipipe_root_only+0x5 (add_pre=
empt_count+0x10)
[   40.191621]      +func                 -225 add_preempt_count+0x4 (_raw_=
spin_lock+0x15)
[   40.191621]      +func                 -225 _raw_spin_lock+0x4 (dput+0x2=
a)
[   40.191621]      +end     0x80000001   -225 hard_local_irq_restore+0x15 =
(ipipe_root_only+0x40)
[   40.191621]      +begin   0x80000001   -225 hard_local_irq_save+0x16 (ip=
ipe_root_only+0xf)
[   40.191621]      +func                 -225 ipipe_root_only+0x5 (dput+0x=
20)
[   40.191621]      +func                 -225 dput+0x6 (fput+0x186)
[   40.191621]      +end     0x80000000   -225 hard_local_irq_enable+0x14 (=
ipipe_unstall_root+0x2b)
[   40.191621]      #func                 -225 ipipe_root_only+0x5 (ipipe_u=
nstall_root+0x12)
[   40.191621]      #begin   0x80000000   -226 hard_local_irq_disable+0x15 =
(ipipe_unstall_root+0xd)
[   40.191621]      #func                 -226 ipipe_unstall_root+0x3 (ipip=
e_restore_root+0x2e)
[   40.191621]      #end     0x80000001   -226 hard_local_irq_restore+0x15 =
(ipipe_root_only+0x40)
[   40.191621]      #begin   0x80000001   -226 hard_local_irq_save+0x16 (ip=
ipe_root_only+0xf)
[   40.191621]      #func                 -226 ipipe_root_only+0x5 (ipipe_r=
estore_root+0x10)
[   40.191621]      #func                 -226 ipipe_restore_root+0x4 (arch=
_local_irq_restore+0x11)
[   40.191621]      #end     0x80000001   -226 debug_smp_processor_id+0x82 =
(__call_rcu+0x8f)
[   40.191621]      #begin   0x80000001   -226 debug_smp_processor_id+0x36 =
(__call_rcu+0x8f)
[   40.191621]      +func                 -226 __call_rcu+0x9 (call_rcu+0x1=
4)
[   40.191621]      +func                 -227 call_rcu+0x3 (file_free+0x27)
[   40.191621]      +func                 -227 sub_preempt_count+0x4 (__per=
cpu_counter_add+0x8c)
[   40.191621]      +end     0x80000001   -227 hard_local_irq_restore+0x15 =
(ipipe_root_only+0x40)
[   40.191621]      +begin   0x80000001   -227 hard_local_irq_save+0x16 (ip=
ipe_root_only+0xf)
[   40.191621]      +func                 -227 ipipe_root_only+0x5 (add_pre=
empt_count+0x10)
[   40.191621]      +func                 -227 add_preempt_count+0x4 (__per=
cpu_counter_add+0x1d)
[   40.191621]      +func                 -227 file_sb_list_del+0x4 (fput+0=
x128)
[   40.191621]      +func                 -227 put_pid+0x3 (fput+0x121)
[   40.191621]      +func                 -227 module_put+0x6 (fput+0x119)
[   40.191621]      +func                 -228 module_put+0x6 (sock_release=
+0x27)
[   40.191621]      +func                 -228 module_put+0x6 (__sk_free+0x=
d8)
[   40.191621]      +end     0x80000000   -228 hard_local_irq_enable+0x14 (=
ipipe_unstall_root+0x2b)
[   40.191621]      #func                 -228 ipipe_root_only+0x5 (ipipe_u=
nstall_root+0x12)
[   40.191621]      #begin   0x80000000   -228 hard_local_irq_disable+0x15 =
(ipipe_unstall_root+0xd)
[   40.191621]      #func                 -228 ipipe_unstall_root+0x3 (ipip=
e_restore_root+0x2e)
[   40.191621]      #end     0x80000001   -228 hard_local_irq_restore+0x15 =
(ipipe_root_only+0x40)
[   40.191621]      #begin   0x80000001   -229 hard_local_irq_save+0x16 (ip=
ipe_root_only+0xf)
[   40.191621]      #func                 -229 ipipe_root_only+0x5 (ipipe_r=
estore_root+0x10)
[   40.191621]      #func                 -229 ipipe_restore_root+0x4 (arch=
_local_irq_restore+0x11)
[   40.191621]      #end     0x80000001   -229 debug_smp_processor_id+0x82 =
(__call_rcu+0x8f)
[   40.191621]      #begin   0x80000001   -229 debug_smp_processor_id+0x36 =
(__call_rcu+0x8f)
[   40.191621]      +func                 -229 __call_rcu+0x9 (call_rcu+0x1=
4)
[   40.191621]      +func                 -229 call_rcu+0x3 (kmem_cache_fre=
e+0x26)
[   40.191621]      +func                 -229 kmem_cache_free+0x6 (__sk_fr=
ee+0xc8)
[   40.191621]      +func                 -229 put_pid+0x3 (__sk_free+0xae)
[   40.191621]      +func                 -230 dst_release+0x5 (inet_sock_d=
estruct+0x13e)
[   40.191621]      +func                 -230 kfree+0x6 (inet_sock_destruc=
t+0x133)
[   40.191621]      +func                 -230 inet_sock_destruct+0x5 (__sk=
_free+0x18)
[   40.191621]      +func                 -230 __sk_free+0x5 (sk_free+0x1f)
[   40.191621]      +func                 -230 sk_free+0x3 (tcp_close+0x2c3)
[   40.191621]      +func                 -230 sub_preempt_count+0x4 (_loca=
l_bh_enable_ip+0x88)
[   40.191621]      +func                 -230 sub_preempt_count+0x4 (_loca=
l_bh_enable_ip+0x5f)
[   40.191621]      +func                 -230 local_bh_enable+0x3 (tcp_clo=
se+0x2b2)
[   40.191621]      +func                 -231 sub_preempt_count+0x4 (_raw_=
spin_unlock+0x15)
[   40.191621]      +func                 -231 _raw_spin_unlock+0x3 (tcp_cl=
ose+0x2ad)
[   40.191621]      +func                 -231 sub_preempt_count+0x4 (__per=
cpu_counter_add+0x8c)
[   40.191621]      +end     0x80000001   -231 hard_local_irq_restore+0x15 =
(ipipe_root_only+0x40)
[   40.191621]      +begin   0x80000001   -231 hard_local_irq_save+0x16 (ip=
ipe_root_only+0xf)
[   40.191621]      +func                 -231 ipipe_root_only+0x5 (add_pre=
empt_count+0x10)
[   40.191621]      +func                 -231 add_preempt_count+0x4 (__per=
cpu_counter_add+0x1d)
[   40.191621]      +func                 -231 sk_stream_kill_queues+0x5 (i=
net_csk_destroy_sock+0x7d)
[   40.191621]      +func                 -231 sub_preempt_count+0x4 (__per=
cpu_counter_add+0x8c)
[   40.191621]      +end     0x80000001   -232 hard_local_irq_restore+0x15 =
(ipipe_root_only+0x40)
[   40.191621]      +begin   0x80000001   -232 hard_local_irq_save+0x16 (ip=
ipe_root_only+0xf)
[   40.191621]      +func                 -232 ipipe_root_only+0x5 (add_pre=
empt_count+0x10)
[   40.191621]      +func                 -232 add_preempt_count+0x4 (__per=
cpu_counter_add+0x1d)
[   40.191621]      +func                 -232 sub_preempt_count+0x4 (_loca=
l_bh_enable_ip+0x88)
[   40.191621]      +func                 -232 sub_preempt_count+0x4 (_loca=
l_bh_enable_ip+0x5f)
[   40.191621]      +func                 -232 local_bh_enable+0x3 (inet_pu=
t_port+0x7f)
[   40.191621]      +func                 -232 sub_preempt_count+0x4 (_raw_=
spin_unlock+0x15)
[   40.191621]      +func                 -232 _raw_spin_unlock+0x3 (inet_p=
ut_port+0x7a)
[   40.191621]      +func                 -233 sub_preempt_count+0x4 (_raw_=
spin_unlock_irqrestore+0x28)
[   40.191621]      +end     0x80000000   -233 hard_local_irq_enable+0x14 (=
ipipe_unstall_root+0x2b)
[   40.191621]      #func                 -233 ipipe_root_only+0x5 (ipipe_u=
nstall_root+0x12)
[   40.191621]      #begin   0x80000000   -233 hard_local_irq_disable+0x15 =
(ipipe_unstall_root+0xd)
[   40.191621]      #func                 -233 ipipe_unstall_root+0x3 (ipip=
e_restore_root+0x2e)
[   40.191621]      #end     0x80000001   -233 hard_local_irq_restore+0x15 =
(ipipe_root_only+0x40)
[   40.191621]      #begin   0x80000001   -233 hard_local_irq_save+0x16 (ip=
ipe_root_only+0xf)
[   40.191621]      #func                 -233 ipipe_root_only+0x5 (ipipe_r=
estore_root+0x10)
[   40.191621]      #func                 -233 ipipe_restore_root+0x4 (_raw=
_spin_unlock_irqrestore+0x1e)
[   40.191621]      #func                 -234 _raw_spin_unlock_irqrestore+=
0x3 (slob_free+0x2ac)
[   40.191621]      #func                 -234 __ipipe_spin_unlock_debug+0x=
3 (slob_free+0x29f)
[   40.191621]      #func                 -234 set_slob+0x4 (slob_free+0x29=
7)
[   40.191621]      #func                 -234 set_slob+0x4 (slob_free+0x23=
c)
[   40.191621]      #end     0x80000001   -235 hard_local_irq_restore+0x15 =
(ipipe_root_only+0x40)
[   40.191621]      #begin   0x80000001   -235 hard_local_irq_save+0x16 (ip=
ipe_root_only+0xf)
[   40.191621]      #func                 -235 ipipe_root_only+0x5 (add_pre=
empt_count+0x10)
[   40.191621]      #func                 -235 add_preempt_count+0x4 (_raw_=
spin_lock_irqsave+0x49)
[   40.191621]      +func                 -235 _raw_spin_lock_irqsave+0x5 (=
slob_free+0x4a)
[   40.191621]      +func                 -235 slob_free+0x9 (__kmem_cache_=
free+0x18)
[   40.191621]      +func                 -236 __kmem_cache_free+0x4 (kmem_=
cache_free+0x31)
[   40.191621]      +func                 -236 kmem_cache_free+0x6 (inet_bi=
nd_bucket_destroy+0x27)
[   40.191621]      +func                 -236 inet_bind_bucket_destroy+0x4=
 (inet_put_port+0x73)
[   40.191621]      +end     0x80000001   -236 hard_local_irq_restore+0x15 =
(ipipe_root_only+0x40)
[   40.191621]      +begin   0x80000001   -236 hard_local_irq_save+0x16 (ip=
ipe_root_only+0xf)
[   40.191621]      +func                 -236 ipipe_root_only+0x5 (add_pre=
empt_count+0x10)
[   40.191621]      +func                 -236 add_preempt_count+0x4 (_raw_=
spin_lock+0x15)
[   40.191621]      +func                 -237 _raw_spin_lock+0x4 (inet_put=
_port+0x40)
[   40.191621]      +end     0x80000001   -237 hard_local_irq_restore+0x15 =
(ipipe_root_only+0x40)
[   40.191621]      +begin   0x80000001   -237 hard_local_irq_save+0x16 (ip=
ipe_root_only+0xf)
[   40.191621]      +func                 -237 ipipe_root_only+0x5 (add_pre=
empt_count+0x10)
[   40.191621]      +func                 -237 add_preempt_count+0x4 (local=
_bh_disable+0x12)
[   40.191621]      +func                 -237 local_bh_disable+0x3 (inet_p=
ut_port+0x12)
[   40.191621]      +func                 -237 inet_put_port+0x6 (tcp_v4_de=
stroy_sock+0x129)
[   40.191621]      +func                 -237 module_put+0x6 (tcp_cleanup_=
congestion_control+0x2a)
[   40.191621]      +func                 -237 tcp_cleanup_congestion_contr=
ol+0x4 (tcp_v4_destroy_sock+0x22)
[   40.191621]      +func                 -238 sk_stop_timer+0x4 (inet_csk_=
clear_xmit_timers+0x45)
[   40.191621]      +func                 -238 sk_stop_timer+0x4 (inet_csk_=
clear_xmit_timers+0x38)
[   40.191621]      +func                 -238 sk_stop_timer+0x4 (inet_csk_=
clear_xmit_timers+0x2b)
[   40.191621]      +func                 -238 inet_csk_clear_xmit_timers+0=
x4 (tcp_v4_destroy_sock+0x12)
[   40.191621]      +func                 -238 tcp_v4_destroy_sock+0x6 (ine=
t_csk_destroy_sock+0x76)
[   40.191621]      +func                 -238 inet_csk_destroy_sock+0x4 (t=
cp_close+0x2a6)
[   40.191621]      +func                 -238 sub_preempt_count+0x4 (__per=
cpu_counter_add+0x8c)
[   40.191621]      +end     0x80000001   -238 hard_local_irq_restore+0x15 =
(ipipe_root_only+0x40)
[   40.191621]      +begin   0x80000001   -239 hard_local_irq_save+0x16 (ip=
ipe_root_only+0xf)
[   40.191621]      +func                 -239 ipipe_root_only+0x5 (add_pre=
empt_count+0x10)
[   40.191621]      +func                 -239 add_preempt_count+0x4 (__per=
cpu_counter_add+0x1d)
[   40.191621]      +end     0x80000001   -239 hard_local_irq_restore+0x15 =
(ipipe_root_only+0x40)
[   40.191621]      +begin   0x80000001   -239 hard_local_irq_save+0x16 (ip=
ipe_root_only+0xf)
[   40.191621]      +func                 -239 ipipe_root_only+0x5 (add_pre=
empt_count+0x10)
[   40.191621]      +func                 -239 add_preempt_count+0x4 (_raw_=
spin_lock+0x15)
[   40.191621]      +func                 -239 _raw_spin_lock+0x4 (tcp_clos=
e+0x18b)
[   40.191621]      +end     0x80000001   -239 hard_local_irq_restore+0x15 =
(ipipe_root_only+0x40)
[   40.191621]      +begin   0x80000001   -240 hard_local_irq_save+0x16 (ip=
ipe_root_only+0xf)
[   40.191621]      +func                 -240 ipipe_root_only+0x5 (add_pre=
empt_count+0x10)
[   40.191621]      +func                 -240 add_preempt_count+0x4 (local=
_bh_disable+0x12)
[   40.191621]      +func                 -240 local_bh_disable+0x3 (tcp_cl=
ose+0x184)
[   40.191621]      +func                 -240 sub_preempt_count+0x4 (_loca=
l_bh_enable_ip+0x88)
[   40.191621]      +func                 -240 sub_preempt_count+0x4 (_loca=
l_bh_enable_ip+0x5f)
[   40.191621] ------------[ cut here ]------------
[   40.191621] kernel BUG at kernel/xenomai/nucleus/shadow.c:2233!
[   40.191621] invalid opcode: 0000 [#1] PREEMPT SMP
[   40.191621] Modules linked in: platform_edge(O) sigmatek_lrt(O) usbhid
[   40.191621]
[   40.191621] Pid: 246, comm: cyclic:214:246 Tainted: G           O 3.4.6+=
 #72 Bochs Bochs
[   40.191621] EIP: 0060:[<c0188347>] EFLAGS: 00213213 CPU: 1
[   40.191621] EIP is at xnshadow_send_sig+0x19/0x3e
[   40.191621] EAX: f9338040 EBX: 0000001c ECX: 00001e02 EDX: 00000000
[   40.191621] ESI: f9332d04 EDI: f9332d14 EBP: f581deac ESP: f581dea8
[   40.191621]  DS: 007b ES: 007b FS: 00d8 GS: 0000 SS: 0068
[   40.191621] CR0: 8005003b CR2: 00000000 CR3: 3635d000 CR4: 00000690
[   40.191621] DR0: 00000000 DR1: 00000000 DR2: 00000000 DR3: 00000000
[   40.191621] DR6: ffff0ff0 DR7: 00000400
[   40.191621] Process cyclic:214:246 (pid: 246, ti=3Df581c000 task=3Df53e0=
2d0 task.ti=3Df581c000)
[   40.191621] I-pipe domain Linux
[   40.191621] Stack:
[   40.191621]  f9338040 f581deb8 c01883f7 00000001 f581dec4 c0182d5b f9338=
040 f581ded0
[   40.191621]  c0182de7 f932fa40 f581def0 c0183182 f9338040 00000001 00000=
003 f9332d04
[   40.191621]  00000000 f9338040 f581df08 c018320a f9338408 f9338040 c06ed=
880 00000003
[   40.191621] Call Trace:
[   40.191621]  [<c01883f7>] xnshadow_renice+0x2d/0x30
[   40.191621]  [<c0182d5b>] xnsynch_renice_thread+0x32/0x48
[   40.191621]  [<c0182de7>] xnsynch_clear_boost+0x76/0x79
[   40.191621]  [<c0183182>] xnsynch_release_thread+0xe1/0x12b
[   40.191621]  [<c018320a>] xnsynch_release_all_ownerships+0x3e/0x55
[   40.191621]  [<c0181198>] xnpod_delete_thread+0x18e/0x254
[   40.191621]  [<c0187d45>] taskexit_event+0xce/0x14e
[   40.191621]  [<c0164861>] ipipe_kevent_hook+0x1c/0x1f
[   40.191621]  [<c01614c7>] __ipipe_notify_kevent+0x4e/0x6e
[   40.191621]  [<c01225c0>] do_exit+0x207/0x6a1
[   40.191621]  [<c01645a2>] ? ipipe_trace_function+0x19/0x1c
[   40.191621]  [<c0122b18>] sys_exit+0x18/0x18
[   40.191621]  [<c041dd3a>] syscall_call+0x7/0xb
[   40.191621] Code: ff 83 e7 01 89 f8 e8 ed e9 ff ff 5e 5f 5b 5e 5f 5d c3 =
55 89 e5 53 e8 29 6a 29 00 89 d3 8b 90 5c 03 00 00 81 fa ff ff ff bf 77 04 =
<0f> 0b eb fe 83 7d 08 00 75 09 b8 02 00 00 00 31 c9 eb 08 c1 e1
[   40.191621] EIP: [<c0188347>] xnshadow_send_sig+0x19/0x3e SS:ESP 0068:f5=
81dea8
[   40.191621] ---[ end trace 8f9c98ef4c873e8e ]---
[   40.191621] Fixing recursive fault but reboot is needed!
