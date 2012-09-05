MIME-Version: 1.0
In-Reply-To: <50470D2D.8020004@xenomai.org>
References: <CANKLDmsO-1E7+d9X6-t532RJ=CWY4P4x30nCNCwgHffJjAFkDA@mail.gmail.com>
	<50460BCE.8010505@xenomai.org>
	<CANKLDmtmnbAb7PM4URTjxYtaH5WnvGjVcEPOpSNr2A6gPwLLaA@mail.gmail.com>
	<50464969.2000902@xenomai.org> <5046549C.7030008@xenomai.org>
	<CANKLDmufv25Bngqb3CapS6ybHG9DH76DUq1q6dinzJ5ai7TowA@mail.gmail.com>
	<5046FF0A.9000208@xenomai.org>
	<CANKLDmverDgL3c2BEtXAwkGhq7KLRopGnM3q9Z_TQiAAeMponw@mail.gmail.com>
	<50470D2D.8020004@xenomai.org>
Date: Wed, 5 Sep 2012 11:29:26 +0200
Message-ID: <CANKLDmudbBw5gyWVe_nPSLkQTopaH0ajs3FXgJottn84Cm6anQ@mail.gmail.com>
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

On Wed, Sep 5, 2012 at 10:28 AM, Gilles Chanteperdrix
<gilles.chanteperdrix@xenomai.org> wrote:
> On 09/05/2012 09:42 AM, Henri Roosen wrote:
>> On Wed, Sep 5, 2012 at 9:28 AM, Gilles Chanteperdrix
>> <gilles.chanteperdrix@xenomai.org> wrote:
>>> On 09/05/2012 09:26 AM, Henri Roosen wrote:
>>>
>>>> On Tue, Sep 4, 2012 at 9:21 PM, Gilles Chanteperdrix
>>>> <gilles.chanteperdrix@xenomai.org> wrote:
>>>>> On 09/04/2012 08:33 PM, Gilles Chanteperdrix wrote:
>>>>>
>>>>>> On 09/04/2012 04:28 PM, Henri Roosen wrote:
>>>>>>
>>>>>>> On Tue, Sep 4, 2012 at 4:10 PM, Gilles Chanteperdrix
>>>>>>> <gilles.chanteperdrix@xenomai.org> wrote:
>>>>>>>> On 09/04/2012 03:42 PM, Henri Roosen wrote:
>>>>>>>>> Hi,
>>>>>>>>>
>>>>>>>>> I'm using the bleeding edge of Xenomai (0590cb45adce468f619) and =
Ipipe
>>>>>>>>> (d21e8cdbdcf21ade) on a x86 multicore system and kernel 3.4.6.
>>>>>>>>> I reserved one cpu (kernel param isolcpus=3D1).
>>>>>>>>>
>>>>>>>>> Our application triggers the following NULL pointer dereference w=
hen I
>>>>>>>>> set the affinity of some tasks to cpu 0 and other tasks to cpu 1.
>>>>>>>>> The application does not trigger this when all tasks have the same
>>>>>>>>> affinity (set via /proc/xenomai/affinity).
>>>>>>>>>
>>>>>>>>> I was able to reproduce this also under QEMU and will do some
>>>>>>>>> debugging, but maybe someone knows what is wrong already by seein=
g the
>>>>>>>>> stacktrace below:
>>>>>>>>
>>>>>>>> Could you try to reduce the bug to a simple testcase which we woul=
d try
>>>>>>>> and run to reproduce?
>>>>>>>>
>>>>>>>>> [  108.013023] BUG: unable to handle kernel NULL pointer derefere=
nce
>>>>>>>> at 00000294
>>>>>>>>> [  108.013550] IP: [<c0126a91>] __lock_task_sighand+0x53/0xc3
>>>>>>>>
>>>>>>>> Or send us a disassembly of the function __lock_task_sighand?
>>>>>>
>>>>>>
>>>>>> Looks like someone is calling send_sig_info with an invalid pointer.
>>>>>> There is something seriously wrong.
>>>>>>
>>>>>> On the other hand, now that I think about it, you need at least the
>>>>>> following patch:
>>>>>>
>>>>>> diff --git a/ksrc/nucleus/intr.c b/ksrc/nucleus/intr.c
>>>>>> index c75fcac..0f37bb2 100644
>>>>>> --- a/ksrc/nucleus/intr.c
>>>>>> +++ b/ksrc/nucleus/intr.c
>>>>>> @@ -93,8 +93,18 @@ void xnintr_host_tick(struct xnsched *sched) /* I=
nterrupts off. */
>>>>>>
>>>>>>  void xnintr_clock_handler(void)
>>>>>>  {
>>>>>> -     struct xnsched *sched =3D xnpod_current_sched();
>>>>>>       xnstat_exectime_t *prev;
>>>>>> +     struct xnsched *sched;
>>>>>> +     unsigned cpu;
>>>>>> +
>>>>>> +     cpu =3D xnarch_current_cpu();
>>>>>> +
>>>>>> +     if (!cpumask_test_cpu(cpu, &xnarch_supported_cpus)) {
>>>>>> +             xnarch_relay_tick();
>>>>>> +             return;
>>>>>> +     }
>>>>>> +
>>>>>> +     sched =3D xnpod_sched_slot(cpu);
>>>>>>
>>>>>>       prev =3D xnstat_exectime_switch(sched,
>>>>>>               &nkclock.stat[xnsched_cpu(sched)].account);
>>>>>
>>>>>
>>>>> It should work (I did not test it), with the following patch on the
>>>>> I-pipe:
>>>>>
>>>>> diff --git a/kernel/ipipe/timer.c b/kernel/ipipe/timer.c
>>>>> index d51fa62..301cdc0 100644
>>>>> --- a/kernel/ipipe/timer.c
>>>>> +++ b/kernel/ipipe/timer.c
>>>>> @@ -176,11 +176,17 @@ int ipipe_select_timers(const struct cpumask *m=
ask)
>>>>>                 hrclock_freq =3D __ipipe_hrclock_freq;
>>>>>
>>>>>         spin_lock_irqsave(&lock, flags);
>>>>> -       for_each_cpu(cpu, mask) {
>>>>> +       for_each_cpu(cpu, cpu_online_mask) {
>>>>>                 list_for_each_entry(t, &timers, link) {
>>>>>                         if (!cpumask_test_cpu(cpu, t->cpumask))
>>>>>                                 continue;
>>>>>
>>>>> +                       if (!cpumask_test_cpu(cpu, mask)
>>>>> +                           && t->irq =3D=3D per_cpu(ipipe_percpu.hrt=
imer_irq, 0)) {
>>>>> +                               per_cpu(ipipe_percpu.hrtimer_irq, cpu=
) =3D t->irq;
>>>>> +                               goto found;
>>>>> +                       }
>>>>> +
>>>>>                         evtdev =3D t->host_timer;
>>>>>  #ifdef CONFIG_GENERIC_CLOCKEVENTS
>>>>>                         if (!evtdev
>>>>> @@ -188,10 +194,16 @@ int ipipe_select_timers(const struct cpumask *m=
ask)
>>>>>  #endif /* CONFIG_GENERIC_CLOCKEVENTS */
>>>>>                                 goto found;
>>>>>                 }
>>>>> +               if (!cpumask_test_cpu(cpu, mask))
>>>>> +                       continue;
>>>>> +
>>>>>                 printk("I-pipe: could not find timer for cpu #%d\n", =
cpu);
>>>>>                 goto err_remove_all;
>>>>>
>>>>>           found:
>>>>> +               if (!cpumask_test_cpu(cpu, mask))
>>>>> +                       continue;
>>>>> +
>>>>>                 if (__ipipe_hrtimer_freq =3D=3D 0)
>>>>>                         __ipipe_hrtimer_freq =3D t->freq;
>>>>>                 per_cpu(ipipe_percpu.hrtimer_irq, cpu) =3D t->irq;
>>>>>
>>>> Thanks for looking into this Gilles!
>>>> I tried your second patch only and unfortunately I was still able to
>>>> reproduce the same kernel NULL pointer dereference.
>>>
>>>
>>> Sorry, I meant the first xenomai patch needs the second I-pipe patch to
>>> work.
>>
>> I applied both patches now, but still able to reproduce the same problem.
>
> Ok, to debug this, you can add:
> BUG_ON((unsigned long)xnthread_user_task(thread) < 0xc0000000);
> in xnshadow_send_sig. Add:
> BUG_ON((unsigned long)p < 0xc0000000)
> in lostage_handler, in the LO_SIGTHR_REQ case.
>
> Enable the I-pipe tracer, panic back traces, then set the number of
> points to a reasonably high value before running your test.

Please find attached the trace ipipe_trace.txt

Note that in order to compile the ipipe-tracer for x86 I had to remove
the call to hard_irqs_disabled_flags. I changed that to 0.. hope that
doesn't affect the trace log.

>
> --
>                                             Gilles.
-------------- next part --------------
[   60.026336] I-pipe: Detected stalled head domain, probably caused by a b=
ug.
[   60.026339]         A critical section may have been left unterminated.
[   60.026774] Pid: 244, comm: cyclic:213:244 Tainted: G           O 3.4.6+=
 #70
[   60.026774] Call Trace:
[   60.026774]  [<c0161420>] ipipe_root_only+0x7f/0x8b
[   60.026774]  [<c0161f7a>] ipipe_unstall_root+0x12/0x2d
[   60.026774]  [<c0102695>] conditional_sti+0xe/0x10
[   60.026774]  [<c01029e6>] do_invalid_op+0x59/0x80
[   60.026774]  [<c018836b>] ? xnshadow_send_sig+0x19/0x3e
[   60.026774]  [<c01614f0>] ? __ipipe_notify_trap+0x9/0x82
[   60.026774]  [<c0113d3f>] ? __ipipe_handle_exception+0x9/0x1f4
[   60.026774]  [<c01645c5>] ? ipipe_trace_function+0x19/0x1c
[   60.026774]  [<c0113922>] ? __ipipe_get_current_domain+0xe/0x43
[   60.026774]  [<c0113f11>] __ipipe_handle_exception+0x1db/0x1f4
[   60.026774]  [<c041e5a7>] error_code+0x5f/0x6c
[   60.026774]  [<c016007b>] ? __rcu_process_callbacks+0x2b7/0x355
[   60.026774]  [<c018836b>] ? xnshadow_send_sig+0x19/0x3e
[   60.026774]  [<c018841b>] xnshadow_renice+0x2d/0x30
[   60.026774]  [<c0182d7f>] xnsynch_renice_thread+0x32/0x48
[   60.026774]  [<c0182e0b>] xnsynch_clear_boost+0x76/0x79
[   60.026774]  [<c01831a6>] xnsynch_release_thread+0xe1/0x12b
[   60.026774]  [<c018322e>] xnsynch_release_all_ownerships+0x3e/0x55
[   60.026774]  [<c01811bc>] xnpod_delete_thread+0x18e/0x254
[   60.026774]  [<c0187d69>] taskexit_event+0xce/0x14e
[   60.026774]  [<c0164885>] ipipe_kevent_hook+0x1c/0x1f
[   60.026774]  [<c01614c7>] __ipipe_notify_kevent+0x4e/0x6e
[   60.026774]  [<c01225c0>] do_exit+0x207/0x6a1
[   60.026774]  [<c01645c5>] ? ipipe_trace_function+0x19/0x1c
[   60.026774]  [<c0122b18>] sys_exit+0x18/0x18
[   60.026774]  [<c041dd6a>] syscall_call+0x7/0xb
[   60.026774] I-pipe tracer log (100 points):
[   60.026774]     *#func                    0 ipipe_trace_panic_freeze+0x4=
 (ipipe_root_only+0x53)
[   60.026774]     *#func                    0 ipipe_prepare_panic+0x4 (ipi=
pe_root_only+0x4e)
[   60.026774]     *#func                    0 ipipe_root_only+0x5 (ipipe_u=
nstall_root+0x12)
[   60.026774]     *#func                    0 ipipe_unstall_root+0x3 (cond=
itional_sti+0xe)
[   60.026774]     *#func                   -1 __rcu_read_unlock+0x4 (__ato=
mic_notifier_call_chain+0x31)
[   60.026774]     *#func                   -9 hw_breakpoint_exceptions_not=
ify+0x9 (notifier_call_chain+0x30)
[   60.026774]     *#func                   -9 notifier_call_chain+0x9 (__a=
tomic_notifier_call_chain+0x2a)
[   60.026774]     *#func                   -9 __rcu_read_lock+0x3 (__atomi=
c_notifier_call_chain+0x19)
[   60.026774]     *#func                   -9 __atomic_notifier_call_chain=
+0x6 (atomic_notifier_call_chain+0x11)
[   60.026774]     *#func                  -10 atomic_notifier_call_chain+0=
x3 (notify_die+0x2d)
[   60.026774]     *#func                  -10 do_invalid_op+0x8 (__ipipe_h=
andle_exception+0x1db)
[   60.026774]     *#func                  -10 __ipipe_notify_trap+0x9 (__i=
pipe_handle_exception+0x89)
[   60.026774]     *+func                  -11 __ipipe_handle_exception+0x9=
 (error_code+0x5f)
[   60.026774]     *+func                  -16 xnshadow_send_sig+0x4 (xnsha=
dow_renice+0x2d)
[   60.026774]     *+func                  -17 xnshadow_renice+0x3 (xnsynch=
_renice_thread+0x32)
[   60.026774]     *+func                  -17 xnsched_track_policy+0x5 (xn=
synch_renice_thread+0x10)
[   60.026774]     *+func                  -17 xnsynch_renice_thread+0x4 (x=
nsynch_clear_boost+0x76)
[   60.026774]     *+func                  -17 xnsynch_clear_boost+0x4 (xns=
ynch_release_thread+0xe1)
[   60.026774]     *+[  228] Watchdo 96    -17 xnpod_resume_thread+0x40 (xn=
synch_release_thread+0xd1)
[   60.026774]     *+func                  -18 xnpod_resume_thread+0x9 (xns=
ynch_release_thread+0xd1)
[   60.026774]     *+func                  -18 xnsynch_release_thread+0x9 (=
xnsynch_release_all_ownerships+0x3e)
[   60.026774]     *+func                  -18 xnsynch_release_all_ownershi=
ps+0x9 (xnpod_delete_thread+0x18e)
[   60.026774]     *+func                  -19 xntimer_destroy+0x5 (xnpod_d=
elete_thread+0x15e)
[   60.026774]     *+func                  -19 xntimer_destroy+0x5 (xnpod_d=
elete_thread+0x153)
[   60.026774]     *+func                  -19 xnpod_delete_thread+0x6 (tas=
kexit_event+0xce)
[   60.026774]      +begin   0x80000000    -20 ipipe_test_and_stall_pipelin=
e_head+0x15 (__xnlock_get_irqsave+0xc)
[   60.026774]      +func                  -20 __task_get_magic+0x3 (taskex=
it_event+0x5b)
[   60.026774]      +func                  -20 taskexit_event+0x9 (ipipe_ke=
vent_hook+0x1c)
[   60.026774]      +func                  -20 ipipe_kevent_hook+0x4 (__ipi=
pe_notify_kevent+0x4e)
[   60.026774]      +end     0x80000001    -20 hard_local_irq_restore+0x15 =
(__ipipe_notify_kevent+0x43)
[   60.026774]      +begin   0x80000001    -21 hard_local_irq_save+0x16 (__=
ipipe_notify_kevent+0x20)
[   60.026774]      +end     0x80000001    -21 hard_local_irq_restore+0x15 =
(ipipe_root_only+0x40)
[   60.026774]      +begin   0x80000001    -21 hard_local_irq_save+0x16 (ip=
ipe_root_only+0xf)
[   60.026774]      +func                  -21 ipipe_root_only+0x5 (__ipipe=
_notify_kevent+0x1b)
[   60.026774]      +func                  -21 __ipipe_notify_kevent+0x9 (d=
o_exit+0x207)
[   60.026774]      +end     0x80000001    -21 hard_local_irq_restore+0x15 =
(ipipe_root_only+0x40)
[   60.026774]      +begin   0x80000001    -21 hard_local_irq_save+0x16 (ip=
ipe_root_only+0xf)
[   60.026774]      +func                  -21 ipipe_root_only+0x5 (mmput+0=
x10)
[   60.026774]      +func                  -22 mmput+0x4 (exit_mm+0xe5)
[   60.026774]      +func                  -22 sub_preempt_count+0x4 (_raw_=
spin_unlock+0x15)
[   60.026774]      +func                  -22 _raw_spin_unlock+0x3 (exit_m=
m+0xde)
[   60.026774]      +func                  -22 up_read+0x3 (exit_mm+0xc3)
[   60.026774]      +end     0x80000001    -22 hard_local_irq_restore+0x15 =
(ipipe_root_only+0x40)
[   60.026774]      +begin   0x80000001    -22 hard_local_irq_save+0x16 (ip=
ipe_root_only+0xf)
[   60.026774]      +func                  -22 ipipe_root_only+0x5 (add_pre=
empt_count+0x10)
[   60.026774]      +func                  -23 add_preempt_count+0x4 (_raw_=
spin_lock+0x15)
[   60.026774]      +func                  -23 _raw_spin_lock+0x4 (exit_mm+=
0xb1)
[   60.026774]      +end     0x80000001    -23 hard_local_irq_restore+0x15 =
(ipipe_root_only+0x40)
[   60.026774]      +begin   0x80000001    -23 hard_local_irq_save+0x16 (ip=
ipe_root_only+0xf)
[   60.026774]      +func                  -23 ipipe_root_only+0x5 (down_re=
ad+0x10)
[   60.026774]      +func                  -23 down_read+0x4 (exit_mm+0x37)
[   60.026774]      +func                  -23 sync_mm_rss+0x5 (exit_mm+0x2=
c)
[   60.026774]      +func                  -24 drop_futex_key_refs+0x3 (fut=
ex_wake+0xd0)
[   60.026774]      +func                  -24 sub_preempt_count+0x4 (_raw_=
spin_unlock+0x15)
[   60.026774]      +func                  -24 _raw_spin_unlock+0x3 (futex_=
wake+0xc8)
[   60.026774]      +end     0x80000001    -24 hard_local_irq_restore+0x15 =
(ipipe_root_only+0x40)
[   60.026774]      +begin   0x80000001    -24 hard_local_irq_save+0x16 (ip=
ipe_root_only+0xf)
[   60.026774]      +func                  -25 ipipe_root_only+0x5 (add_pre=
empt_count+0x10)
[   60.026774]      +func                  -25 add_preempt_count+0x4 (_raw_=
spin_lock+0x15)
[   60.026774]      +func                  -25 _raw_spin_lock+0x4 (futex_wa=
ke+0x58)
[   60.026774]      +func                  -25 hash_futex+0x4 (futex_wake+0=
x51)
[   60.026774]      +func                  -25 put_page+0x3 (get_futex_key+=
0x17e)
[   60.026774]      +func                  -25 __wake_up_bit+0x7 (unlock_pa=
ge+0x45)
[   60.026774]      +func                  -26 unlock_page+0x4 (get_futex_k=
ey+0x177)
[   60.026774]      +func                  -26 get_futex_key_refs+0x3 (get_=
futex_key+0x170)
[   60.026774]      +end     0x80000001    -26 hard_local_irq_restore+0x15 =
(ipipe_root_only+0x40)
[   60.026774]      +begin   0x80000001    -26 hard_local_irq_save+0x16 (ip=
ipe_root_only+0xf)
[   60.026774]      +func                  -26 ipipe_root_only+0x5 (get_fut=
ex_key+0x108)
[   60.026774]      +end     0x80000000    -26 hard_local_irq_enable+0x14 (=
ipipe_unstall_root+0x2b)
[   60.026774]      #func                  -26 ipipe_root_only+0x5 (ipipe_u=
nstall_root+0x12)
[   60.026774]      #begin   0x80000000    -27 hard_local_irq_disable+0x15 =
(ipipe_unstall_root+0xd)
[   60.026774]      #func                  -27 ipipe_unstall_root+0x3 (get_=
user_pages_fast+0xb7)
[   60.026774]      #func                  -27 gup_pte_range+0x9 (gup_pud_r=
ange+0x4a)
[   60.026774]      #func                  -27 gup_pud_range+0x9 (get_user_=
pages_fast+0x9e)
[   60.026774]      +func                  -28 get_user_pages_fast+0x9 (get=
_futex_key+0x94)
[   60.026774]      +func                  -28 get_futex_key+0x9 (futex_wak=
e+0x3f)
[   60.026774]      +func                  -28 futex_wake+0x9 (do_futex+0xc=
e)
[   60.026774]      +func                  -28 do_futex+0xc (sys_futex+0xee)
[   60.026774]      +func                  -29 sys_futex+0x9 (mm_release+0x=
b4)
[   60.026774]      +end     0x80000001    -29 hard_local_irq_restore+0x15 =
(ipipe_root_only+0x40)
[   60.026774]      +begin   0x80000001    -29 hard_local_irq_save+0x16 (ip=
ipe_root_only+0xf)
[   60.026774]      +func                  -29 ipipe_root_only+0x5 (mm_rele=
ase+0x97)
[   60.026774]      +end     0x80000001    -30 hard_local_irq_restore+0x15 =
(ipipe_root_only+0x40)
[   60.026774]      +begin   0x80000001    -30 hard_local_irq_save+0x16 (ip=
ipe_root_only+0xf)
[   60.026774]      +func                  -30 ipipe_root_only+0x5 (exit_ro=
bust_list+0x5e)
[   60.026774]      +end     0x80000001    -30 hard_local_irq_restore+0x15 =
(ipipe_root_only+0x40)
[   60.026774]      +begin   0x80000001    -30 hard_local_irq_save+0x16 (ip=
ipe_root_only+0xf)
[   60.026774]      +func                  -30 ipipe_root_only+0x5 (exit_ro=
bust_list+0x43)
[   60.026774]      +end     0x80000001    -30 hard_local_irq_restore+0x15 =
(ipipe_root_only+0x40)
[   60.026774]      +begin   0x80000001    -30 hard_local_irq_save+0x16 (ip=
ipe_root_only+0xf)
[   60.026774]      +func                  -31 ipipe_root_only+0x5 (exit_ro=
bust_list+0x2c)
[   60.026774]      +func                  -31 exit_robust_list+0x9 (mm_rel=
ease+0x1d)
[   60.026774]      +func                  -31 mm_release+0x6 (exit_mm+0x1d)
[   60.026774]      +func                  -31 exit_mm+0x9 (do_exit+0x1c1)
[   60.026774]      +func                  -31 sync_mm_rss+0x5 (do_exit+0x1=
3d)
[   60.026774]      +func                  -32 exit_irq_thread+0x5 (do_exit=
+0xfc)
[   60.026774]      +func                  -32 sub_preempt_count+0x4 (_raw_=
spin_unlock_irq+0x1a)
[   60.026774]      +end     0x80000000    -32 hard_local_irq_enable+0x14 (=
ipipe_unstall_root+0x2b)
[   60.026774]      #func                  -33 ipipe_root_only+0x5 (ipipe_u=
nstall_root+0x12)
[   60.026774]      #begin   0x80000000    -33 hard_local_irq_disable+0x15 =
(ipipe_unstall_root+0xd)
[   60.026774] ------------[ cut here ]------------
[   60.026774] kernel BUG at kernel/xenomai/nucleus/shadow.c:2233!
[   60.026774] invalid opcode: 0000 [#1] PREEMPT SMP
[   60.026774] Modules linked in: platform_edge(O) sigmatek_lrt(O) usbhid
[   60.026774]
[   60.026774] Pid: 244, comm: cyclic:213:244 Tainted: G           O 3.4.6+=
 #70 Bochs Bochs
[   60.026774] EIP: 0060:[<c018836b>] EFLAGS: 00213213 CPU: 1
[   60.026774] EIP is at xnshadow_send_sig+0x19/0x3e
[   60.026774] EAX: f8d32040 EBX: 0000001c ECX: 00001e02 EDX: 00000000
[   60.026774] ESI: f8d2cd04 EDI: f8d2cd14 EBP: f6053eac ESP: f6053ea8
[   60.026774]  DS: 007b ES: 007b FS: 00d8 GS: 0000 SS: 0068
[   60.026774] CR0: 8005003b CR2: 00000000 CR3: 35c60000 CR4: 00000690
[   60.026774] DR0: 00000000 DR1: 00000000 DR2: 00000000 DR3: 00000000
[   60.026774] DR6: ffff0ff0 DR7: 00000400
[   60.026774] Process cyclic:213:244 (pid: 244, ti=3Df6052000 task=3Df6a1f=
1d0 task.ti=3Df6052000)
[   60.026774] I-pipe domain Linux
[   60.026774] Stack:
[   60.026774]  f8d32040 f6053eb8 c018841b 00000001 f6053ec4 c0182d7f f8d32=
040 f6053ed0
[   60.026774]  c0182e0b f8d29a40 f6053ef0 c01831a6 f8d32040 00000001 00000=
003 f8d2cd04
[   60.026774]  00000000 f8d32040 f6053f08 c018322e f8d32408 f8d32040 c0675=
880 00000003
[   60.026774] Call Trace:
[   60.026774]  [<c018841b>] xnshadow_renice+0x2d/0x30
[   60.026774]  [<c0182d7f>] xnsynch_renice_thread+0x32/0x48
[   60.026774]  [<c0182e0b>] xnsynch_clear_boost+0x76/0x79
[   60.026774]  [<c01831a6>] xnsynch_release_thread+0xe1/0x12b
[   60.026774]  [<c018322e>] xnsynch_release_all_ownerships+0x3e/0x55
[   60.026774]  [<c01811bc>] xnpod_delete_thread+0x18e/0x254
[   60.026774]  [<c0187d69>] taskexit_event+0xce/0x14e
[   60.026774]  [<c0164885>] ipipe_kevent_hook+0x1c/0x1f
[   60.026774]  [<c01614c7>] __ipipe_notify_kevent+0x4e/0x6e
[   60.026774]  [<c01225c0>] do_exit+0x207/0x6a1
[   60.026774]  [<c01645c5>] ? ipipe_trace_function+0x19/0x1c
[   60.026774]  [<c0122b18>] sys_exit+0x18/0x18
[   60.026774]  [<c041dd6a>] syscall_call+0x7/0xb
[   60.026774] Code: ff 83 e7 01 89 f8 e8 ed e9 ff ff 5e 5f 5b 5e 5f 5d c3 =
55 89 e5 53 e8 45 6a 29 00 89 d3 8b 90 5c 03 00 00 81 fa ff ff ff bf 77 04 =
<0f> 0b eb fe 83 7d 08 00 75 09 b8 02 00 00 00 31 c9 eb 08 c1 e1
[   60.026774] EIP: [<c018836b>] xnshadow_send_sig+0x19/0x3e SS:ESP 0068:f6=
053ea8
[   60.026774] ---[ end trace 72017e0ee9364459 ]---
[   60.026774] Fixing recursive fault but reboot is needed!
