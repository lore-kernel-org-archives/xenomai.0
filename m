From: "Chen, Hongzhan" <hongzhan.chen@intel.com>
Subject: RE: gdb  test failure debug status update
Date: Thu, 29 Apr 2021 06:31:22 +0000
Message-ID: <DM5PR11MB1852E0C420E68BFB8CAFEE21F25F9@DM5PR11MB1852.namprd11.prod.outlook.com>
References: <DM5PR11MB18525F69E34389DE7A8EE49BF2409@DM5PR11MB1852.namprd11.prod.outlook.com>
 <87mtti3325.fsf@xenomai.org> <87k0om32jb.fsf@xenomai.org>
In-Reply-To: <87k0om32jb.fsf@xenomai.org>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Philippe Gerum <rpm@xenomai.org>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>


>
>-----Original Message-----
>From: Philippe Gerum <rpm@xenomai.org>=20
>Sent: Wednesday, April 28, 2021 10:30 PM
>To: Philippe Gerum <rpm@xenomai.org>
>Cc: Chen, Hongzhan <hongzhan.chen@intel.com>; xenomai@xenomai.org
>Subject: Re: gdb test failure debug status update
>
>
>Philippe Gerum via Xenomai <xenomai@xenomai.org> writes:
>
>> Chen, Hongzhan via Xenomai <xenomai@xenomai.org> writes:
>>
>>> According to my validation, gdb test fail on dovetail 5.10 branch but p=
ass on v5.9-evl4 tag with same for-upstream/dovetail
>>> xenomai code base.
>>>
>>> After further debug , the issue is more clear for me. Gdb test failure =
because low priority thread smokey  userspace  is still
>>> executed after "cobalt_shadow_relaxed: state=3D0x4488c0 info=3D0x200"  =
like log [1] on dovetail-5.10 branch.
>>> The weird thing is that its following first ftrace log  happen at 62235=
.848583 after cobalt_shadow_relaxed in log [1].
>>> It is almost 3ms happened after cobalt_shadow_relaxed. The low priority=
 smoke thread user space is executed during this
>>> 3ms period so that test fail.
>>>
>>> But in success case with v5.9-evl4 like in  log [2], the time interval =
between cobalt_shadow_relaxed and the following first ftrace log
>>> is only about 1us. It seems that low priority smokey userspace do not h=
ave chance to execute in this 1us because gdb test is successful.
>>>
>>> My question is why there is even no interrupt happened during that abou=
t 3ms period in failure case?  Tick seems in abnormal behavior.
>>> Please comment if you have any ideas to further debug it.
>>>
>>> PS: All my tests run on same up Xtream board.
>>
>> <snip>
>>
>> Let's put aside the tick issue for now, there may be a valid reason for
>> this delay with dynticks enabled.
>>
>> The issue at stake may be related to the way a return to kernel space is
>> forced on a @user task (Dovetail has an integrated service for
>> triggering this called dovetail_request_ucall()).
>>
>> The logic for doing so is as follows:
>>
>> 1. @user hits a breakpoint, which is an exception Dovetail-wise
>>
>> 2. @user gets XNDBGSTOP set into its flags because Cobalt notices it is
>> being debugged via a breakpoint trap, then relaxed as a result of taking
>> a exception in general, so that we may traverse the common trap handling=
 code
>> safely.
>>
>> 3. since XNDBGSTOP is a blocking bit Cobalt-wise, it should prevent
>> @user from being picked for scheduling by the real-time core, next time
>> a Cobalt considers rescheduling that is. However, since @user is
>> currently relaxed, it can still run under the supervision of the common
>> Linux scheduler. This is what the log[1] show.
>>
>> 4. the common/in-band kernel code stops @user due to the ptrace stop
>> condition caused by the breakpoint, waiting for a continuation event to
>> happen.
>>
>> Therefore, upon PTRACE_CONT (i.e. gdb continue), we need to force @user
>> to call back into kernel context (handle_ptrace_cont ->
>> dovetail_request_ucall), then ask for a switch to primary mode from
>> there, which should eventually happen when @user is about to leave the
>> kernel (on x86, this now happens from a generic kernel entry/exit code
>> in kernel/entry/*). As a result, handle_taskexit_event() runs, figures
>
>Not quite:
>s,handle_taskexit_event,handle_user_return,

There is trace_cobalt_shadow_unmap in handle_taskexit_event. I added=20
trace_cobalt_handle_user_return and trace_cobalt_handle_ptrace_cont
like patch [3] in log [4].

1. In the log [4], the first cobalt_handle_ptrace_cont is followed by  coba=
lt_handle_user_return=20
that clear info flag XNCONTHI for smokey-2499 because cobalt_handle_ptrace_=
cont  called dovetail_request_ucall .
the TIF_RETUSER bit was cleared for smokey-2499.
After then 61513.834832:  cobalt_thread_resume: name=3Dsmokey pid=3D2499 ma=
sk=3D0x400000
clear state flag XNDBGSTOP. After that, thread smokey-2499 run without thes=
e bit set till=20
"hi-thread-2504    [000] *.~3 61513.836143: cobalt_thread_suspend: pid=3D24=
99 mask=3D0x400000".

2. There is second cobalt_handle_ptrace_cont called for smokey-2499 but at =
that time dovetail_request_ucall
would not be called because XNSSTEP Is not set like "smokey-2499    [000] .=
..1 61513.835073: cobalt_handle_ptrace_cont: pid=3D2499 state=3D0x480c0 inf=
o=3D0x0"

3. hi-thread-2504 breakpoint at its first breakpoint_target so it trigger h=
i-thread-2504    [000] *.~3 61513.836142: cobalt_thread_fault: ip=3D0x55555=
540b580 type=3D0x3
   It call dovetail_request_ucall(current); for itself and also call xnthre=
ad_set_info(thread, XNCONTHI);  That is why we can see this bit set in=20
hi-thread-2504    [000] ...1 61513.836167: cobalt_shadow_relaxed: state=3D0=
x480c0 info=3D0x200

4. finally ,gdb call sys_tkill  in  gdb-2495    [000] ...1 61513.836529: sy=
s_tkill(pid: 9c3, sig: 13) and trigger that handle_oob_mayday is called so =
that xnthread_relax for=20
   smokey-2499 Is called in "smokey-2499    [000] *.~3 61513.836589: cobalt=
_shadow_gorelax: reason=3Dundefined."


It seems that there never call dovetail_request_ucall for process smokey-24=
99 in log[4] so that final xhthread_relax would have chance to return to us=
er?
The second handle_ptrace_cont happen too much earlier because XNSSTEP still=
 have not been set so that system never have change to call dovetail_reques=
t_ucall=20
for smokey-2499.=20
In this case , do we need to do hack in 3 , when handle_oob_trap_entry is c=
alled  for hi-thread-2504  we call  xnthread_set_info(thread, XNCONTHI);=20
 and dovetail_request_ucall for all threads that have same cobalt_process? =
Is this solution OK for fixing this case?


[3]:
index 07dcc7a63..cd76961f5 100644
--- a/kernel/cobalt/dovetail/kevents.c
+++ b/kernel/cobalt/dovetail/kevents.c
@@ -331,6 +331,8 @@ static int handle_user_return(struct task_struct *task)
        if (thread =3D=3D NULL)
                return KEVENT_PROPAGATE;

+       trace_cobalt_handle_user_return(thread);
+
        if (xnthread_test_info(thread, XNCONTHI)) {
                xnlock_get_irqsave(&nklock, s);
                xnthread_clear_info(thread, XNCONTHI);
@@ -468,6 +470,8 @@ int handle_ptrace_resume(struct task_struct *tracee)
        if (thread =3D=3D NULL)
                return KEVENT_PROPAGATE;

+       trace_cobalt_handle_ptrace_resume(thread);
+
        if (xnthread_test_state(thread, XNSSTEP)) {
                xnlock_get_irqsave(&nklock, s);

@@ -485,6 +489,8 @@ static void handle_ptrace_cont(void)
        struct xnthread *curr =3D xnthread_current();
        spl_t s;

+       trace_cobalt_handle_ptrace_cont(curr);
+
        xnlock_get_irqsave(&nklock, s);

        if (xnthread_test_state(curr, XNSSTEP)) {
@@ -604,6 +610,7 @@ void resume_oob_task(struct task_struct *p) /* inband, =
oob stage stalled */
        if (unlikely(xnthread_test_info(thread, XNCONTHI))) {
                xnthread_clear_info(thread, XNCONTHI);
                dovetail_clear_ucall();
+               trace_cobalt_resume_oob_task(thread);
        }

        /* Unregister as debugged thread in case we postponed this. */
diff --git a/kernel/cobalt/trace/cobalt-core.h b/kernel/cobalt/trace/cobalt=
-core.h
index 78f66a106..88a4067fd 100644
--- a/kernel/cobalt/trace/cobalt-core.h
+++ b/kernel/cobalt/trace/cobalt-core.h
@@ -459,6 +459,27 @@ DEFINE_EVENT(curr_thread_event, cobalt_thread_set_mode=
,
        TP_ARGS(thread)
 );

+DEFINE_EVENT(thread_event, cobalt_handle_ptrace_cont,
+       TP_PROTO(struct xnthread *thread),

[4]:
                 gdb-2495    [000] d..3 61513.834825: sched_switch: prev_co=
mm=3Dgdb prev_pid=3D2495 prev_prio=3D120 prev_state=3DR =3D=3D> next_comm=
=3Dsmokey next_pid=3D2499 next_prio=3D98
          smokey-2499    [000] ...1 61513.834827: cobalt_handle_ptrace_cont=
: pid=3D2499 state=3D0x4488c0 info=3D0x200
          smokey-2499    [000] d..1 61513.834828: cobalt_handle_user_return=
: pid=3D2499 state=3D0x4488c0 info=3D0x200
          smokey-2499    [000] d..1 61513.834828: cobalt_shadow_gohard: sta=
te=3D0x4488c0 info=3D0x0
          smokey-2499    [000] d..3 61513.834830: sched_stat_wait: comm=3Dg=
db pid=3D2495 delay=3D8017 [ns]
          smokey-2499    [000] d..3 61513.834831: sched_switch: prev_comm=
=3Dsmokey prev_pid=3D2499 prev_prio=3D98 prev_state=3DS =3D=3D> next_comm=
=3Dgdb next_pid=3D2495 next_prio=3D120
             gdb-2495    [000] *..3 61513.834831: cobalt_thread_resume: nam=
e=3Dsmokey pid=3D2499 mask=3D0x80
             gdb-2495    [000] *..3 61513.834832: cobalt_trace_pid: pid=3D2=
499, prio=3D1
             gdb-2495    [000] *..3 61513.834832: cobalt_thread_resume: nam=
e=3Dsmokey pid=3D2499 mask=3D0x400000
             gdb-2495    [000] *..3 61513.834832: cobalt_trace_pid: pid=3D2=
499, prio=3D1
             gdb-2495    [000] *.~3 61513.834833: cobalt_schedule: status=
=3D0x10000000
             gdb-2495    [000] *.~3 61513.834833: cobalt_trace_pid: pid=3D2=
495, prio=3D-1
             gdb-2495    [000] *.~3 61513.834833: cobalt_switch_context: pr=
ev_name=3DROOT/0 prev_pid=3D0 prev_prio=3D-1 prev_state=3D0x18008 =3D=3D> n=
ext_name=3Dsmokey next_pid=3D2499 next_prio=3D1
          smokey-2499    [000] d.~3 61513.834835: cobalt_shadow_hardened: s=
tate=3D0x48040 info=3D0x0
          smokey-2499    [000] d.~3 61513.834836: cobalt_head_sysentry: sys=
call=3Dsem_init
          smokey-2499    [000] d.~3 61513.834839: cobalt_psem_init: sem=3D0=
x4e(anon) flags=3D0x0() value=3D0
          smokey-2499    [000] d.~3 61513.834839: cobalt_head_sysexit: resu=
lt=3D0
          smokey-2499    [000] d.~3 61513.834848: cobalt_shadow_gorelax: re=
ason=3Dsyscall
          smokey-2499    [000] d.~3 61513.834848: cobalt_lostage_request: r=
equest=3Dwakeup pid=3D2499 comm=3Dsmokey
          smokey-2499    [000] *.~3 61513.834848: cobalt_thread_suspend: pi=
d=3D2499 mask=3D0x80 timeout=3D0 timeout_mode=3D0 wchan=3D0000000000000000
          smokey-2499    [000] *.~3 61513.834849: cobalt_schedule: status=
=3D0x10000000
          smokey-2499    [000] *.~3 61513.834849: cobalt_trace_pid: pid=3D2=
499, prio=3D1
          smokey-2499    [000] *.~3 61513.834849: cobalt_switch_context: pr=
ev_name=3Dsmokey prev_pid=3D2499 prev_prio=3D1 prev_state=3D0x480c0 =3D=3D>=
 next_name=3DROOT/0 next_pid=3D0 next_prio=3D-1
             gdb-2495    [000] *.~3 61513.834850: cobalt_trace_pid: pid=3D2=
495, prio=3D-1
             gdb-2495    [000] d.h3 61513.834851: irq_handler_entry: irq=3D=
120 name=3Din-band work
             gdb-2495    [000] d.h3 61513.834852: cobalt_lostage_wakeup: pi=
d=3D2499 comm=3Dsmokey
             gdb-2495    [000] d.h5 61513.834852: sched_waking: comm=3Dsmok=
ey pid=3D2499 prio=3D98 target_cpu=3D000
             gdb-2495    [000] dNh6 61513.834853: sched_wakeup: comm=3Dsmok=
ey pid=3D2499 prio=3D98 target_cpu=3D000
             gdb-2495    [000] dNh3 61513.834853: irq_handler_exit: irq=3D1=
20 ret=3Dhandled
             gdb-2495    [000] dN.3 61513.834854: sched_stat_runtime: comm=
=3Dgdb pid=3D2495 runtime=3D23565 [ns] vruntime=3D300514015543 [ns]
             gdb-2495    [000] d..3 61513.834855: sched_switch: prev_comm=
=3Dgdb prev_pid=3D2495 prev_prio=3D120 prev_state=3DR =3D=3D> next_comm=3Ds=
mokey next_pid=3D2499 next_prio=3D98
          smokey-2499    [000] ...1 61513.834856: cobalt_shadow_relaxed: st=
ate=3D0x480c0 info=3D0x0
          smokey-2499    [000] ...1 61513.834857: sys_sched_get_priority_mi=
n(policy: 1)
          smokey-2499    [000] ...1 61513.834857: sys_sched_get_priority_mi=
n -> 0x1
          smokey-2499    [000] ...1 61513.834859: sys_sched_get_priority_ma=
x(policy: 1)
          smokey-2499    [000] ...1 61513.834859: sys_sched_get_priority_ma=
x -> 0x63
          smokey-2499    [000] ..~1 61513.834862: cobalt_head_sysentry: sys=
call=3Dthread_getschedparam_ex
          smokey-2499    [000] ...1 61513.834862: cobalt_root_sysentry: sys=
call=3Dthread_getschedparam_ex
          smokey-2499    [000] ...1 61513.834863: cobalt_pthread_getschedpa=
ram: pth=3D000000008d36be1c policy=3Dfifo param=3D{ priority=3D1 }
          smokey-2499    [000] ...1 61513.834864: cobalt_root_sysexit: resu=
lt=3D0
          smokey-2499    [000] ...1 61513.834872: sys_mmap(addr: 0, len: 11=
000, prot: 0, flags: 20022, fd: ffffffff, off: 0)
          smokey-2499    [000] ...1 61513.834877: sys_mmap -> 0x7ffff67b900=
0
          smokey-2499    [000] ...1 61513.834878: sys_mprotect(start: 7ffff=
67ba000, len: 10000, prot: 3)
          smokey-2499    [000] ...1 61513.834906: sys_mprotect -> 0x0
          smokey-2499    [000] ...1 61513.834909: sys_clone(clone_flags: 3d=
0f00, newsp: 7ffff67c8fb0, parent_tidptr: 7ffff67c99d0, child_tidptr: 7ffff=
67c99d0, tls: 7ffff67c9700)
          smokey-2499    [000] ...1 61513.834923: task_newtask: pid=3D2504 =
comm=3Dsmokey clone_flags=3D3d0f00 oom_score_adj=3D0
          smokey-2499    [000] ...1 61513.834923: sched_process_fork: comm=
=3Dsmokey pid=3D2499 child_comm=3Dsmokey child_pid=3D2504
          smokey-2499    [000] d..3 61513.834925: sched_wakeup_new: comm=3D=
smokey pid=3D2504 prio=3D98 target_cpu=3D000
          smokey-2499    [000] d..3 61513.834928: signal_generate: sig=3D17=
 errno=3D0 code=3D4 comm=3Dgdb pid=3D2495 grp=3D1 res=3D0
          smokey-2499    [000] d..3 61513.834931: sched_switch: prev_comm=
=3Dsmokey prev_pid=3D2499 prev_prio=3D98 prev_state=3Dt =3D=3D> next_comm=
=3Dsmokey next_pid=3D2504 next_prio=3D98
       hi-thread-2504    [000] ...1 61513.834932: sys_clone -> 0x0
       hi-thread-2504    [000] d..3 61513.834934: signal_generate: sig=3D17=
 errno=3D0 code=3D4 comm=3Dgdb pid=3D2495 grp=3D1 res=3D2
       hi-thread-2504    [000] d..3 61513.834935: sched_stat_wait: comm=3Dg=
db pid=3D2495 delay=3D82002 [ns]
       hi-thread-2504    [000] d..3 61513.834936: sched_switch: prev_comm=
=3Dsmokey prev_pid=3D2504 prev_prio=3D98 prev_state=3Dt =3D=3D> next_comm=
=3Dgdb next_pid=3D2495 next_prio=3D120
             gdb-2495    [000] d..2 61513.834937: signal_deliver: sig=3D17 =
errno=3D0 code=3D4 sa_handler=3D5585fdc414d0 sa_flags=3D14000000
             gdb-2495    [000] ...1 61513.834940: sys_read(fd: f, buf: 7ffe=
8b2a71e7, count: 1)
             gdb-2495    [000] ...1 61513.834943: sys_read -> 0x1
             gdb-2495    [000] ...1 61513.834943: sys_read(fd: f, buf: 7ffe=
8b2a71e7, count: 1)
             gdb-2495    [000] ...1 61513.834944: sys_read -> 0xfffffffffff=
ffff5
             gdb-2495    [000] ...1 61513.834944: sys_write(fd: 10, buf: 55=
85fe0354b1, count: 1)
             gdb-2495    [000] ...1 61513.834946: sys_write -> 0x1
             gdb-2495    [000] ...1 61513.834947: sys_rt_sigreturn()
             gdb-2495    [000] ...1 61513.834953: sys_read(fd: 9, buf: 7ffe=
8b2a82e7, count: 1)
             gdb-2495    [000] ...1 61513.834953: sys_read -> 0xfffffffffff=
ffff5
             gdb-2495    [000] ...1 61513.834955: sys_poll(ufds: 5585fe8983=
50, nfds: 4, timeout_msecs: 0)
             gdb-2495    [000] ...1 61513.834956: sys_poll -> 0x1
             gdb-2495    [000] ...1 61513.834957: sys_read(fd: f, buf: 7ffe=
8b2a7f27, count: 1)
             gdb-2495    [000] ...1 61513.834958: sys_read -> 0x1
             gdb-2495    [000] ...1 61513.834959: sys_read(fd: f, buf: 7ffe=
8b2a7f27, count: 1)
             gdb-2495    [000] ...1 61513.834960: sys_read -> 0xfffffffffff=
ffff5
             gdb-2495    [000] ...1 61513.834961: sys_rt_sigprocmask(how: 0=
, nset: 5585fe2d4a60, oset: 7ffe8b2a7e60, sigsetsize: 8)
             gdb-2495    [000] ...1 61513.834961: sys_rt_sigprocmask -> 0x0
             gdb-2495    [000] ...1 61513.834962: sys_wait4(upid: ffffffff,=
 stat_addr: 7ffe8b2a7db4, options: 40000001, ru: 0)
             gdb-2495    [000] ...1 61513.834962: sched_process_wait: comm=
=3Dgdb pid=3D0 prio=3D120
             gdb-2495    [000] ...1 61513.834964: sys_wait4 -> 0x9c3
             gdb-2495    [000] ...1 61513.834965: sys_ptrace(request: 4201,=
 pid: 9c3, addr: 0, data: 7ffe8b2a7d08)
             gdb-2495    [000] d..3 61513.834966: sched_wait_task: comm=3Ds=
mokey pid=3D2499 prio=3D98
             gdb-2495    [000] ...1 61513.834967: sys_ptrace -> 0x0
             gdb-2495    [000] ...1 61513.834967: sys_wait4(upid: 9c8, stat=
_addr: 7ffe8b2a7cfc, options: 40000000, ru: 0)
             gdb-2495    [000] ...1 61513.834968: sched_process_wait: comm=
=3Dgdb pid=3D2504 prio=3D120
             gdb-2495    [000] ...1 61513.834969: sys_wait4 -> 0x9c8
             gdb-2495    [000] ...1 61513.834972: sys_ptrace(request: 1, pi=
d: 9c3, addr: 7ffff777f370, data: 7ffe8b2a7578)
             gdb-2495    [000] d..3 61513.834972: sched_wait_task: comm=3Ds=
mokey pid=3D2499 prio=3D98
             gdb-2495    [000] ...1 61513.834975: sys_ptrace -> 0x0
             gdb-2495    [000] ...1 61513.834976: sys_ptrace(request: 3, pi=
d: 9c8, addr: a8, data: 7ffe8b2a78d8)
             gdb-2495    [000] d..3 61513.834977: sched_wait_task: comm=3Ds=
mokey pid=3D2504 prio=3D98
             gdb-2495    [000] ...1 61513.834977: sys_ptrace -> 0x0
             gdb-2495    [000] ...1 61513.834979: sys_openat(dfd: ffffff9c,=
 filename: 7ffe8b2a6de0, flags: 80000, mode: 0)
             gdb-2495    [000] ...1 61513.834989: sys_openat -> 0x12
             gdb-2495    [000] ...1 61513.834990: sys_pread64(fd: 12, buf: =
7ffe8b2a7130, count: 900, pos: 7ffff67c9700)
             gdb-2495    [000] ...1 61513.834992: sys_pread64 -> 0x900
             gdb-2495    [000] ...1 61513.834993: sys_close(fd: 12)
             gdb-2495    [000] ...1 61513.834994: sys_close -> 0x0
             gdb-2495    [000] ...1 61513.835010: sys_ptrace(request: 1, pi=
d: 9c3, addr: 7ffff777f370, data: 7ffe8b2a7578)
             gdb-2495    [000] d..3 61513.835011: sched_wait_task: comm=3Ds=
mokey pid=3D2499 prio=3D98
             gdb-2495    [000] ...1 61513.835012: sys_ptrace -> 0x0
             gdb-2495    [000] ...1 61513.835013: sys_ptrace(request: 3, pi=
d: 9c3, addr: a8, data: 7ffe8b2a78d8)
             gdb-2495    [000] d..3 61513.835013: sched_wait_task: comm=3Ds=
mokey pid=3D2499 prio=3D98
             gdb-2495    [000] ...1 61513.835014: sys_ptrace -> 0x0
             gdb-2495    [000] ...1 61513.835015: sys_openat(dfd: ffffff9c,=
 filename: 7ffe8b2a6de0, flags: 80000, mode: 0)
             gdb-2495    [000] ...1 61513.835022: sys_openat -> 0x12
             gdb-2495    [000] ...1 61513.835022: sys_pread64(fd: 12, buf: =
7ffe8b2a7130, count: 900, pos: 7ffff758f740)
             gdb-2495    [000] ...1 61513.835025: sys_pread64 -> 0x900
             gdb-2495    [000] ...1 61513.835025: sys_close(fd: 12)
             gdb-2495    [000] ...1 61513.835026: sys_close -> 0x0
             gdb-2495    [000] ...1 61513.835031: sys_wait4(upid: ffffffff,=
 stat_addr: 7ffe8b2a7db4, options: 40000001, ru: 0)
             gdb-2495    [000] ...1 61513.835032: sched_process_wait: comm=
=3Dgdb pid=3D0 prio=3D120
             gdb-2495    [000] ...1 61513.835033: sys_wait4 -> 0x0
             gdb-2495    [000] ...1 61513.835036: sys_ptrace(request: c, pi=
d: 9c8, addr: 0, data: 7ffe8b2a6ef0)
             gdb-2495    [000] d..3 61513.835037: sched_wait_task: comm=3Ds=
mokey pid=3D2504 prio=3D98
             gdb-2495    [000] ...1 61513.835039: sys_ptrace -> 0x0
             gdb-2495    [000] ...1 61513.835043: sys_ptrace(request: 6, pi=
d: 9c8, addr: 388, data: 0)
             gdb-2495    [000] d..3 61513.835044: sched_wait_task: comm=3Ds=
mokey pid=3D2504 prio=3D98
             gdb-2495    [000] ...1 61513.835044: sys_ptrace -> 0x0
             gdb-2495    [000] ...1 61513.835045: sys_ptrace(request: 7, pi=
d: 9c8, addr: 1, data: 0)
             gdb-2495    [000] d..3 61513.835046: sched_wait_task: comm=3Ds=
mokey pid=3D2504 prio=3D98
             gdb-2495    [000] d..3 61513.835047: sched_waking: comm=3Dsmok=
ey pid=3D2504 prio=3D98 target_cpu=3D000
             gdb-2495    [000] dN.4 61513.835048: sched_wakeup: comm=3Dsmok=
ey pid=3D2504 prio=3D98 target_cpu=3D000
             gdb-2495    [000] .N.1 61513.835048: sys_ptrace -> 0x0
             gdb-2495    [000] dN.3 61513.835050: sched_stat_runtime: comm=
=3Dgdb pid=3D2495 runtime=3D112561 [ns] vruntime=3D300514128104 [ns]
             gdb-2495    [000] d..3 61513.835051: sched_switch: prev_comm=
=3Dgdb prev_pid=3D2495 prev_prio=3D120 prev_state=3DR =3D=3D> next_comm=3Ds=
mokey next_pid=3D2504 next_prio=3D98
       hi-thread-2504    [000] ...1 61513.835055: sys_set_robust_list(head:=
 7ffff67c99e0, len: 18)
       hi-thread-2504    [000] ...1 61513.835055: sys_set_robust_list -> 0x=
0
       hi-thread-2504    [000] ...1 61513.835056: sys_futex(uaddr: 7ffff67c=
9d18, op: 80, val: 2, utime: 0, uaddr2: 7ffff67c9700, val3: 7ffff67c9700)
       hi-thread-2504    [000] d..3 61513.835059: sched_stat_wait: comm=3Dg=
db pid=3D2495 delay=3D10883 [ns]
       hi-thread-2504    [000] d..3 61513.835060: sched_switch: prev_comm=
=3Dsmokey prev_pid=3D2504 prev_prio=3D98 prev_state=3DS =3D=3D> next_comm=
=3Dgdb next_pid=3D2495 next_prio=3D120
             gdb-2495    [000] ...1 61513.835063: sys_ptrace(request: c, pi=
d: 9c3, addr: 0, data: 7ffe8b2a6ef0)
             gdb-2495    [000] d..3 61513.835064: sched_wait_task: comm=3Ds=
mokey pid=3D2499 prio=3D98
             gdb-2495    [000] ...1 61513.835065: sys_ptrace -> 0x0
             gdb-2495    [000] ...1 61513.835068: sys_ptrace(request: 7, pi=
d: 9c3, addr: 1, data: 0)
             gdb-2495    [000] d..3 61513.835069: sched_wait_task: comm=3Ds=
mokey pid=3D2499 prio=3D98
             gdb-2495    [000] d..3 61513.835069: sched_waking: comm=3Dsmok=
ey pid=3D2499 prio=3D98 target_cpu=3D000
             gdb-2495    [000] dN.4 61513.835070: sched_wakeup: comm=3Dsmok=
ey pid=3D2499 prio=3D98 target_cpu=3D000
             gdb-2495    [000] .N.1 61513.835071: sys_ptrace -> 0x0
             gdb-2495    [000] dN.3 61513.835071: sched_stat_runtime: comm=
=3Dgdb pid=3D2495 runtime=3D12210 [ns] vruntime=3D300514140314 [ns]
             gdb-2495    [000] d..3 61513.835072: sched_switch: prev_comm=
=3Dgdb prev_pid=3D2495 prev_prio=3D120 prev_state=3DR =3D=3D> next_comm=3Ds=
mokey next_pid=3D2499 next_prio=3D98
          smokey-2499    [000] ...1 61513.835073: cobalt_handle_ptrace_cont=
: pid=3D2499 state=3D0x480c0 info=3D0x0
          smokey-2499    [000] ...1 61513.835074: sys_clone -> 0x9c8
          smokey-2499    [000] ...1 61513.835075: sys_sched_setaffinity(pid=
: 9c8, len: 80, user_mask_ptr: 55555563e7c0)
          smokey-2499    [000] ...1 61513.835077: sys_sched_setaffinity -> =
0x0
          smokey-2499    [000] ...1 61513.835077: sys_futex(uaddr: 7ffff67c=
9d18, op: 81, val: 1, utime: 7ffff67c99d0, uaddr2: 0, val3: 7ffff67c9700)
          smokey-2499    [000] d..3 61513.835078: sched_waking: comm=3Dsmok=
ey pid=3D2504 prio=3D98 target_cpu=3D000
          smokey-2499    [000] d..4 61513.835079: sched_wakeup: comm=3Dsmok=
ey pid=3D2504 prio=3D98 target_cpu=3D000
          smokey-2499    [000] ...1 61513.835080: sys_futex -> 0x1
          smokey-2499    [000] ...1 61513.835086: sys_futex(uaddr: 7fffffff=
e828, op: 189, val: 0, utime: 7fffffffe780, uaddr2: 0, val3: ffffffff)
          smokey-2499    [000] d..3 61513.835089: sched_switch: prev_comm=
=3Dsmokey prev_pid=3D2499 prev_prio=3D98 prev_state=3DS =3D=3D> next_comm=
=3Dsmokey next_pid=3D2504 next_prio=3D98
       hi-thread-2504    [000] ...1 61513.835090: sys_futex -> 0x0
       hi-thread-2504    [000] ...1 61513.835090: sys_futex(uaddr: 7ffff67c=
9d18, op: 81, val: 1, utime: 7ffff67c99d0, uaddr2: 7ffff67c9700, val3: 7fff=
f67c9700)
       hi-thread-2504    [000] ...1 61513.835091: sys_futex -> 0x0
       hi-thread-2504    [000] ...1 61513.835092: sys_sched_setscheduler(pi=
d: 9c8, policy: 1, param: 7ffff67c8e70)
       hi-thread-2504    [000] ...1 61513.835095: sys_sched_setscheduler ->=
 0x0
       hi-thread-2504    [000] ..~1 61513.835096: cobalt_head_sysentry: sys=
call=3Dthread_create
       hi-thread-2504    [000] ...1 61513.835097: cobalt_root_sysentry: sys=
call=3Dthread_create
       hi-thread-2504    [000] ...1 61513.835098: cobalt_pthread_create: pt=
h=3D00000000ba35a01d policy=3Dfifo param=3D{ priority=3D2 }
       hi-thread-2504    [000] ...1 61513.835099: cobalt_timer_migrate: tim=
er=3D000000004d21df54 cpu=3D0
       hi-thread-2504    [000] ...1 61513.835100: cobalt_timer_migrate: tim=
er=3D00000000c1301853 cpu=3D0
       hi-thread-2504    [000] ...1 61513.835101: cobalt_thread_set_current=
_prio: thread=3D00000000e9fda3c4 pid=3D-1 prio=3D2
       hi-thread-2504    [000] ...1 61513.835102: cobalt_thread_init: threa=
d=3D00000000e9fda3c4 name=3Dsmokey flags=3D0x48000 class=3Drt prio=3D2
       hi-thread-2504    [000] ...1 61513.835104: cobalt_shadow_map: thread=
=3D00000000e9fda3c4 pid=3D2504 prio=3D2
       hi-thread-2504    [000] D..1 61513.835104: cobalt_thread_suspend: pi=
d=3D2504 mask=3D0x80 timeout=3D0 timeout_mode=3D0 wchan=3D0000000000000000
       hi-thread-2504    [000] D..1 61513.835105: cobalt_thread_start: pid=
=3D2504 state=3D0x480d0 info=3D0x0
       hi-thread-2504    [000] D..1 61513.835105: cobalt_thread_resume: nam=
e=3Dsmokey pid=3D2504 mask=3D0x10
       hi-thread-2504    [000] D..1 61513.835106: cobalt_trace_pid: pid=3D2=
504, prio=3D2
       hi-thread-2504    [000] ...1 61513.835106: cobalt_trace_pid: pid=3D2=
504, prio=3D2
       hi-thread-2504    [000] ...1 61513.835107: cobalt_shadow_gohard: sta=
te=3D0x480c0 info=3D0x0
       hi-thread-2504    [000] d..3 61513.835108: sched_stat_wait: comm=3Dg=
db pid=3D2495 delay=3D37231 [ns]
       hi-thread-2504    [000] d..3 61513.835109: sched_switch: prev_comm=
=3Dsmokey prev_pid=3D2504 prev_prio=3D97 prev_state=3DS =3D=3D> next_comm=
=3Dgdb next_pid=3D2495 next_prio=3D120
             gdb-2495    [000] *..3 61513.835109: cobalt_thread_resume: nam=
e=3Dsmokey pid=3D2504 mask=3D0x80
             gdb-2495    [000] *..3 61513.835110: cobalt_trace_pid: pid=3D2=
504, prio=3D2
             gdb-2495    [000] *.~3 61513.835110: cobalt_schedule: status=
=3D0x10000000
             gdb-2495    [000] *.~3 61513.835110: cobalt_trace_pid: pid=3D2=
495, prio=3D-1
             gdb-2495    [000] *.~3 61513.835111: cobalt_switch_context: pr=
ev_name=3DROOT/0 prev_pid=3D0 prev_prio=3D-1 prev_state=3D0x18008 =3D=3D> n=
ext_name=3Dsmokey next_pid=3D2504 next_prio=3D2
       hi-thread-2504    [000] d.~3 61513.835112: cobalt_shadow_hardened: s=
tate=3D0x48040 info=3D0x0
       hi-thread-2504    [000] d.~3 61513.835112: cobalt_root_sysexit: resu=
lt=3D0
       hi-thread-2504    [000] d.~3 61513.835113: cobalt_head_sysentry: sys=
call=3Dget_current
       hi-thread-2504    [000] d.~3 61513.835113: cobalt_head_sysexit: resu=
lt=3D0
       hi-thread-2504    [000] d.~3 61513.835116: cobalt_shadow_gorelax: re=
ason=3Dsyscall
       hi-thread-2504    [000] d.~3 61513.835117: cobalt_lostage_request: r=
equest=3Dwakeup pid=3D2504 comm=3Dsmokey
       hi-thread-2504    [000] *.~3 61513.835117: cobalt_thread_suspend: pi=
d=3D2504 mask=3D0x80 timeout=3D0 timeout_mode=3D0 wchan=3D0000000000000000
       hi-thread-2504    [000] *.~3 61513.835117: cobalt_schedule: status=
=3D0x10000000
       hi-thread-2504    [000] *.~3 61513.835118: cobalt_trace_pid: pid=3D2=
504, prio=3D2
       hi-thread-2504    [000] *.~3 61513.835118: cobalt_switch_context: pr=
ev_name=3Dsmokey prev_pid=3D2504 prev_prio=3D2 prev_state=3D0x480c0 =3D=3D>=
 next_name=3DROOT/0 next_pid=3D0 next_prio=3D-1
             gdb-2495    [000] *.~3 61513.835119: cobalt_trace_pid: pid=3D2=
495, prio=3D-1
             gdb-2495    [000] d.h3 61513.835120: irq_handler_entry: irq=3D=
120 name=3Din-band work
             gdb-2495    [000] d.h3 61513.835120: cobalt_lostage_wakeup: pi=
d=3D2504 comm=3Dsmokey
             gdb-2495    [000] d.h5 61513.835120: sched_waking: comm=3Dsmok=
ey pid=3D2504 prio=3D97 target_cpu=3D000
             gdb-2495    [000] dNh6 61513.835121: sched_wakeup: comm=3Dsmok=
ey pid=3D2504 prio=3D97 target_cpu=3D000
             gdb-2495    [000] dNh3 61513.835122: irq_handler_exit: irq=3D1=
20 ret=3Dhandled
             gdb-2495    [000] dN.3 61513.835122: sched_stat_runtime: comm=
=3Dgdb pid=3D2495 runtime=3D13441 [ns] vruntime=3D300514153755 [ns]
             gdb-2495    [000] d..3 61513.835123: sched_switch: prev_comm=
=3Dgdb prev_pid=3D2495 prev_prio=3D120 prev_state=3DR =3D=3D> next_comm=3Ds=
mokey next_pid=3D2504 next_prio=3D97
       hi-thread-2504    [000] ...1 61513.835124: cobalt_shadow_relaxed: st=
ate=3D0x480c0 info=3D0x0
       hi-thread-2504    [000] ...1 61513.835125: sys_futex(uaddr: 7fffffff=
e828, op: 81, val: 1, utime: 0, uaddr2: 7ffff67c8e74, val3: 7fffffffe828)
       hi-thread-2504    [000] d..3 61513.835126: sched_waking: comm=3Dsmok=
ey pid=3D2499 prio=3D98 target_cpu=3D000
       hi-thread-2504    [000] d..4 61513.835126: sched_wakeup: comm=3Dsmok=
ey pid=3D2499 prio=3D98 target_cpu=3D000
       hi-thread-2504    [000] ...1 61513.835127: sys_futex -> 0x1
       hi-thread-2504    [000] ..~1 61513.835128: cobalt_head_sysentry: sys=
call=3Dmigrate
       hi-thread-2504    [000] ...1 61513.835128: cobalt_root_sysentry: sys=
call=3Dmigrate
       hi-thread-2504    [000] ...1 61513.835128: cobalt_shadow_gohard: sta=
te=3D0x480c0 info=3D0x0
       hi-thread-2504    [000] d..3 61513.835130: sched_switch: prev_comm=
=3Dsmokey prev_pid=3D2504 prev_prio=3D97 prev_state=3DS =3D=3D> next_comm=
=3Dsmokey next_pid=3D2499 next_prio=3D98
          smokey-2499    [000] *..3 61513.835130: cobalt_thread_resume: nam=
e=3Dsmokey pid=3D2504 mask=3D0x80
          smokey-2499    [000] *..3 61513.835130: cobalt_trace_pid: pid=3D2=
504, prio=3D2
          smokey-2499    [000] *.~3 61513.835131: cobalt_schedule: status=
=3D0x10000000
          smokey-2499    [000] *.~3 61513.835131: cobalt_trace_pid: pid=3D2=
499, prio=3D-1
          smokey-2499    [000] *.~3 61513.835131: cobalt_switch_context: pr=
ev_name=3DROOT/0 prev_pid=3D0 prev_prio=3D-1 prev_state=3D0x18008 =3D=3D> n=
ext_name=3Dsmokey next_pid=3D2504 next_prio=3D2
       hi-thread-2504    [000] d.~3 61513.835132: cobalt_shadow_hardened: s=
tate=3D0x48040 info=3D0x0
       hi-thread-2504    [000] d.~3 61513.835132: cobalt_root_sysexit: resu=
lt=3D1
       hi-thread-2504    [000] d.~3 61513.835133: cobalt_head_sysentry: sys=
call=3Dthread_setname
       hi-thread-2504    [000] d.~3 61513.835134: cobalt_pthread_setname: p=
th=3D00000000ba35a01d name=3Dhi-thread
       hi-thread-2504    [000] d.~3 61513.835135: cobalt_head_sysexit: resu=
lt=3D0
       hi-thread-2504    [000] d.~3 61513.835136: cobalt_head_sysentry: sys=
call=3Dclock_nanosleep
       hi-thread-2504    [000] d.~3 61513.835137: cobalt_clock_nanosleep: c=
lock_id=3D0 flags=3D0x0() rqt=3D(0.001000000)
       hi-thread-2504    [000] *.~3 61513.835138: cobalt_thread_suspend: pi=
d=3D2504 mask=3D0x4 timeout=3D1000001 timeout_mode=3D0 wchan=3D000000000000=
0000
       hi-thread-2504    [000] *.~3 61513.835138: cobalt_timer_start: timer=
=3D000000004d21df54(smokey) value=3D1000001 interval=3D0 mode=3Drel
       hi-thread-2504    [000] *.~3 61513.835138: cobalt_schedule: status=
=3D0x10000000
       hi-thread-2504    [000] *.~3 61513.835139: cobalt_trace_pid: pid=3D2=
504, prio=3D2
       hi-thread-2504    [000] *.~3 61513.835139: cobalt_switch_context: pr=
ev_name=3Dhi-thread prev_pid=3D2504 prev_prio=3D2 prev_state=3D0x48044 =3D=
=3D> next_name=3DROOT/0 next_pid=3D0 next_prio=3D-1
          smokey-2499    [000] *.~3 61513.835140: cobalt_trace_pid: pid=3D2=
499, prio=3D-1
          smokey-2499    [000] ...1 61513.835141: sys_futex -> 0x0
          smokey-2499    [000] ..~1 61513.835144: cobalt_head_sysentry: sys=
call=3Dmigrate
          smokey-2499    [000] ...1 61513.835144: cobalt_root_sysentry: sys=
call=3Dmigrate
          smokey-2499    [000] ...1 61513.835144: cobalt_shadow_gohard: sta=
te=3D0x480c0 info=3D0x0
          smokey-2499    [000] d..3 61513.835145: sched_stat_wait: comm=3Dg=
db pid=3D2495 delay=3D23982 [ns]
          smokey-2499    [000] d..3 61513.835146: sched_switch: prev_comm=
=3Dsmokey prev_pid=3D2499 prev_prio=3D98 prev_state=3DS =3D=3D> next_comm=
=3Dgdb next_pid=3D2495 next_prio=3D120
             gdb-2495    [000] *..3 61513.835147: cobalt_thread_resume: nam=
e=3Dsmokey pid=3D2499 mask=3D0x80
             gdb-2495    [000] *..3 61513.835147: cobalt_trace_pid: pid=3D2=
499, prio=3D1
             gdb-2495    [000] *.~3 61513.835147: cobalt_schedule: status=
=3D0x10000000
             gdb-2495    [000] *.~3 61513.835147: cobalt_trace_pid: pid=3D2=
495, prio=3D-1
             gdb-2495    [000] *.~3 61513.835148: cobalt_switch_context: pr=
ev_name=3DROOT/0 prev_pid=3D0 prev_prio=3D-1 prev_state=3D0x18008 =3D=3D> n=
ext_name=3Dsmokey next_pid=3D2499 next_prio=3D1
          smokey-2499    [000] d.~3 61513.835148: cobalt_shadow_hardened: s=
tate=3D0x48040 info=3D0x0
          smokey-2499    [000] d.~3 61513.835149: cobalt_root_sysexit: resu=
lt=3D1
          smokey-2499    [000] *.~3 61513.835219: irq_pipeline_entry: irq=
=3D4354
          smokey-2499    [000] *.~3 61513.835219: irq_handler_entry: irq=3D=
4354 name=3DOut-of-band LAPIC timer interrupt
          smokey-2499    [000] *.~3 61513.835220: cobalt_timer_expire: time=
r=3D00000000d13b8aa9
          smokey-2499    [000] *.~3 61513.835220: cobalt_tick_shot: next ti=
ck at 61513.836136 (delay: 915 us)
          smokey-2499    [000] *.~3 61513.835221: irq_handler_exit: irq=3D4=
354 ret=3Dhandled
          smokey-2499    [000] *.~3 61513.835221: irq_pipeline_exit: irq=3D=
4354
          smokey-2499    [000] *.~3 61513.836137: irq_pipeline_entry: irq=
=3D4354
          smokey-2499    [000] *.~3 61513.836137: irq_handler_entry: irq=3D=
4354 name=3DOut-of-band LAPIC timer interrupt
          smokey-2499    [000] *.~3 61513.836138: cobalt_timer_expire: time=
r=3D000000004d21df54
          smokey-2499    [000] *.~3 61513.836138: cobalt_thread_resume: nam=
e=3Dhi-thread pid=3D2504 mask=3D0x4
          smokey-2499    [000] *.~3 61513.836138: cobalt_trace_pid: pid=3D2=
504, prio=3D2
          smokey-2499    [000] *.~3 61513.836139: cobalt_timer_stop: timer=
=3D000000004d21df54
          smokey-2499    [000] *.~3 61513.836139: irq_handler_exit: irq=3D4=
354 ret=3Dhandled
          smokey-2499    [000] *.~3 61513.836139: irq_pipeline_exit: irq=3D=
4354
          smokey-2499    [000] *.~3 61513.836140: cobalt_schedule: status=
=3D0x10000000
          smokey-2499    [000] *.~3 61513.836140: cobalt_trace_pid: pid=3D2=
499, prio=3D1
          smokey-2499    [000] *.~3 61513.836140: cobalt_switch_context: pr=
ev_name=3Dsmokey prev_pid=3D2499 prev_prio=3D1 prev_state=3D0x48048 =3D=3D>=
 next_name=3Dhi-thread next_pid=3D2504 next_prio=3D2
       hi-thread-2504    [000] *.~3 61513.836141: cobalt_trace_pid: pid=3D2=
504, prio=3D2
       hi-thread-2504    [000] d.~3 61513.836141: cobalt_head_sysexit: resu=
lt=3D0
       hi-thread-2504    [000] *.~3 61513.836142: cobalt_thread_fault: ip=
=3D0x55555540b580 type=3D0x3
       hi-thread-2504    [000] *.~3 61513.836143: cobalt_thread_suspend: pi=
d=3D2499 mask=3D0x400000 timeout=3D0 timeout_mode=3D0 wchan=3D0000000000000=
000
       hi-thread-2504    [000] d.~3 61513.836143: cobalt_shadow_gorelax: re=
ason=3Dfault
       hi-thread-2504    [000] d.~3 61513.836143: cobalt_lostage_request: r=
equest=3Dwakeup pid=3D2504 comm=3Dhi-thread
       hi-thread-2504    [000] *.~3 61513.836144: cobalt_thread_suspend: pi=
d=3D2504 mask=3D0x80 timeout=3D0 timeout_mode=3D0 wchan=3D0000000000000000
       hi-thread-2504    [000] *.~3 61513.836144: cobalt_schedule: status=
=3D0x10000000
       hi-thread-2504    [000] *.~3 61513.836144: cobalt_trace_pid: pid=3D2=
504, prio=3D2
       hi-thread-2504    [000] *.~3 61513.836145: cobalt_switch_context: pr=
ev_name=3Dhi-thread prev_pid=3D2504 prev_prio=3D2 prev_state=3D0x480c0 =3D=
=3D> next_name=3DROOT/0 next_pid=3D0 next_prio=3D-1
             gdb-2495    [000] *.~3 61513.836146: cobalt_trace_pid: pid=3D2=
495, prio=3D-1
             gdb-2495    [000] d.h3 61513.836146: irq_handler_entry: irq=3D=
120 name=3Din-band work
             gdb-2495    [000] d.h3 61513.836147: cobalt_lostage_wakeup: pi=
d=3D2504 comm=3Dhi-thread
             gdb-2495    [000] d.h5 61513.836147: sched_waking: comm=3Dhi-t=
hread pid=3D2504 prio=3D97 target_cpu=3D000
             gdb-2495    [000] dNh6 61513.836147: sched_wakeup: comm=3Dhi-t=
hread pid=3D2504 prio=3D97 target_cpu=3D000
             gdb-2495    [000] dNh3 61513.836148: irq_handler_exit: irq=3D1=
20 ret=3Dhandled
             gdb-2495    [000] dNh3 61513.836148: irq_handler_entry: irq=3D=
124 name=3Dproxy tick
             gdb-2495    [000] dNh3 61513.836151: softirq_raise: vec=3D1 [a=
ction=3DTIMER]
             gdb-2495    [000] dNh3 61513.836152: softirq_raise: vec=3D9 [a=
ction=3DRCU]
             gdb-2495    [000] dNh4 61513.836152: sched_stat_runtime: comm=
=3Dgdb pid=3D2495 runtime=3D1007474 [ns] vruntime=3D300515161229 [ns]
             gdb-2495    [000] *Nh3 61513.836154: cobalt_timer_start: timer=
=3D00000000d13b8aa9([host-timer/0]) value=3D2395843 interval=3D0 mode=3Drel
             gdb-2495    [000] *Nh3 61513.836155: cobalt_tick_shot: next ti=
ck at 61513.838550 (delay: 2395 us)
             gdb-2495    [000] dNh3 61513.836155: irq_handler_exit: irq=3D1=
24 ret=3Dhandled
             gdb-2495    [000] .Ns3 61513.836156: softirq_entry: vec=3D1 [a=
ction=3DTIMER]
             gdb-2495    [000] .Ns3 61513.836157: softirq_exit: vec=3D1 [ac=
tion=3DTIMER]
             gdb-2495    [000] .Ns3 61513.836157: softirq_entry: vec=3D9 [a=
ction=3DRCU]
             gdb-2495    [000] dNs6 61513.836158: sched_waking: comm=3Drcu_=
sched pid=3D11 prio=3D120 target_cpu=3D000
             gdb-2495    [000] dNs7 61513.836159: sched_stat_runtime: comm=
=3Dgdb pid=3D2495 runtime=3D6881 [ns] vruntime=3D300515168110 [ns]
             gdb-2495    [000] dNs7 61513.836160: sched_stat_blocked: comm=
=3Drcu_sched pid=3D11 delay=3D4188739 [ns]
             gdb-2495    [000] dNs7 61513.836161: sched_wakeup: comm=3Drcu_=
sched pid=3D11 prio=3D120 target_cpu=3D000
             gdb-2495    [000] .Ns3 61513.836164: softirq_exit: vec=3D9 [ac=
tion=3DRCU]
             gdb-2495    [000] d..3 61513.836165: sched_switch: prev_comm=
=3Dgdb prev_pid=3D2495 prev_prio=3D120 prev_state=3DR =3D=3D> next_comm=3Dh=
i-thread next_pid=3D2504 next_prio=3D97
       hi-thread-2504    [000] ...1 61513.836167: cobalt_shadow_relaxed: st=
ate=3D0x480c0 info=3D0x200
       hi-thread-2504    [000] *..2 61513.836169: cobalt_thread_suspend: pi=
d=3D2499 mask=3D0x400000 timeout=3D0 timeout_mode=3D0 wchan=3D0000000000000=
000
       hi-thread-2504    [000] *..2 61513.836170: cobalt_thread_suspend: pi=
d=3D2504 mask=3D0x400000 timeout=3D0 timeout_mode=3D0 wchan=3D0000000000000=
000
       hi-thread-2504    [000] d..2 61513.836170: signal_generate: sig=3D5 =
errno=3D0 code=3D128 comm=3Dhi-thread pid=3D2504 grp=3D0 res=3D0
       hi-thread-2504    [000] d..3 61513.836173: signal_generate: sig=3D17=
 errno=3D0 code=3D4 comm=3Dgdb pid=3D2495 grp=3D1 res=3D0
       hi-thread-2504    [000] d..3 61513.836175: sched_stat_wait: comm=3Dr=
cu_sched pid=3D11 delay=3D14490 [ns]
       hi-thread-2504    [000] d..3 61513.836175: sched_switch: prev_comm=
=3Dhi-thread prev_pid=3D2504 prev_prio=3D97 prev_state=3Dt =3D=3D> next_com=
m=3Drcu_sched next_pid=3D11 next_prio=3D120
       rcu_sched-11      [000] d..3 61513.836179: sched_stat_runtime: comm=
=3Drcu_sched pid=3D11 runtime=3D4960 [ns] vruntime=3D300512173070 [ns]
       rcu_sched-11      [000] d..3 61513.836179: sched_stat_wait: comm=3Dg=
db pid=3D2495 delay=3D19450 [ns]
       rcu_sched-11      [000] d..3 61513.836180: sched_switch: prev_comm=
=3Drcu_sched prev_pid=3D11 prev_prio=3D120 prev_state=3DI =3D=3D> next_comm=
=3Dgdb next_pid=3D2495 next_prio=3D120
             gdb-2495    [000] ...1 61513.836187: sys_openat(dfd: ffffff9c,=
 filename: 7ffe8b2a7cb0, flags: 80000, mode: 0)
             gdb-2495    [000] ...1 61513.836197: sys_openat -> 0x12
             gdb-2495    [000] ...1 61513.836198: sys_newfstat(fd: 12, stat=
buf: 7ffe8b2a7ae0)
             gdb-2495    [000] ...1 61513.836199: sys_newfstat -> 0x0
             gdb-2495    [000] ...1 61513.836200: sys_read(fd: 12, buf: 558=
5fe9960e0, count: 400)
             gdb-2495    [000] ...1 61513.836214: sys_read -> 0x3f1
             gdb-2495    [000] ...1 61513.836217: sys_close(fd: 12)
             gdb-2495    [000] ...1 61513.836217: sys_close -> 0x0
             gdb-2495    [000] ...1 61513.836221: sys_rt_sigprocmask(how: 2=
, nset: 7ffe8b2a7e60, oset: 0, sigsetsize: 8)
             gdb-2495    [000] ...1 61513.836222: sys_rt_sigprocmask -> 0x0
             gdb-2495    [000] d..2 61513.836223: signal_deliver: sig=3D17 =
errno=3D0 code=3D4 sa_handler=3D5585fdc414d0 sa_flags=3D14000000
             gdb-2495    [000] ...1 61513.836225: sys_read(fd: f, buf: 7ffe=
8b2a7667, count: 1)
             gdb-2495    [000] ...1 61513.836226: sys_read -> 0xfffffffffff=
ffff5
             gdb-2495    [000] ...1 61513.836227: sys_write(fd: 10, buf: 55=
85fe0354b1, count: 1)
             gdb-2495    [000] ...1 61513.836229: sys_write -> 0x1
             gdb-2495    [000] ...1 61513.836229: sys_rt_sigreturn()
             gdb-2495    [000] ...1 61513.836233: sys_read(fd: 9, buf: 7ffe=
8b2a82e7, count: 1)
             gdb-2495    [000] ...1 61513.836234: sys_read -> 0xfffffffffff=
ffff5
             gdb-2495    [000] ...1 61513.836235: sys_write(fd: 1, buf: 558=
5fe7a5290, count: 27)
             gdb-2495    [000] d..4 61513.836236: sched_waking: comm=3Dsmok=
ey pid=3D2493 prio=3D120 target_cpu=3D000
             gdb-2495    [000] d..5 61513.836237: sched_stat_runtime: comm=
=3Dgdb pid=3D2495 runtime=3D58399 [ns] vruntime=3D300515226509 [ns]
             gdb-2495    [000] d..5 61513.836238: sched_stat_sleep: comm=3D=
smokey pid=3D2493 delay=3D1717179 [ns]
             gdb-2495    [000] dN.5 61513.836239: sched_wakeup: comm=3Dsmok=
ey pid=3D2493 prio=3D120 target_cpu=3D000
             gdb-2495    [000] .N.1 61513.836240: sys_write -> 0x27
             gdb-2495    [000] dN.3 61513.836241: sched_stat_wait: comm=3Ds=
mokey pid=3D2493 delay=3D0 [ns]
             gdb-2495    [000] d..3 61513.836241: sched_switch: prev_comm=
=3Dgdb prev_pid=3D2495 prev_prio=3D120 prev_state=3DR =3D=3D> next_comm=3Ds=
mokey next_pid=3D2493 next_prio=3D120
          smokey-2493    [000] ...1 61513.836244: sys_read -> 0x1
          smokey-2493    [000] ..~1 61513.836246: cobalt_head_sysentry: sys=
call=3Dread
          ...
          smokey-2493    [000] d..3 61513.836344: sched_stat_runtime: comm=
=3Dsmokey pid=3D2493 runtime=3D106636 [ns] vruntime=3D300512333145 [ns]
          smokey-2493    [000] d..3 61513.836344: sched_stat_wait: comm=3Dg=
db pid=3D2495 delay=3D106636 [ns]
          smokey-2493    [000] d..3 61513.836345: sched_switch: prev_comm=
=3Dsmokey prev_pid=3D2493 prev_prio=3D120 prev_state=3DS =3D=3D> next_comm=
=3Dgdb next_pid=3D2495 next_prio=3D120
             gdb-2495    [000] ...1 61513.836347: sys_poll(ufds: 5585fe8983=
50, nfds: 4, timeout_msecs: 0)
             gdb-2495    [000] ...1 61513.836348: sys_poll -> 0x1
             gdb-2495    [000] ...1 61513.836350: sys_read(fd: f, buf: 7ffe=
8b2a7f27, count: 1)
             gdb-2495    [000] ...1 61513.836351: sys_read -> 0x1
             gdb-2495    [000] ...1 61513.836352: sys_read(fd: f, buf: 7ffe=
8b2a7f27, count: 1)
             gdb-2495    [000] ...1 61513.836352: sys_read -> 0xfffffffffff=
ffff5
             gdb-2495    [000] ...1 61513.836353: sys_rt_sigprocmask(how: 0=
, nset: 5585fe2d4a60, oset: 7ffe8b2a7e60, sigsetsize: 8)
             gdb-2495    [000] ...1 61513.836354: sys_rt_sigprocmask -> 0x0
             gdb-2495    [000] ...1 61513.836355: sys_wait4(upid: ffffffff,=
 stat_addr: 7ffe8b2a7db4, options: 40000001, ru: 0)
             gdb-2495    [000] ...1 61513.836355: sched_process_wait: comm=
=3Dgdb pid=3D0 prio=3D120
             gdb-2495    [000] ...1 61513.836357: sys_wait4 -> 0x9c8
             gdb-2495    [000] ...1 61513.836360: sys_ptrace(request: c, pi=
d: 9c8, addr: 0, data: 7ffe8b2a6ef0)
             gdb-2495    [000] d..3 61513.836361: sched_wait_task: comm=3Dh=
i-thread pid=3D2504 prio=3D97
             gdb-2495    [000] ...1 61513.836363: sys_ptrace -> 0x0
             gdb-2495    [000] ...1 61513.836367: sys_ptrace(request: 4202,=
 pid: 9c8, addr: 0, data: 7ffe8b2a7cb0)
             gdb-2495    [000] d..3 61513.836368: sched_wait_task: comm=3Dh=
i-thread pid=3D2504 prio=3D97
             gdb-2495    [000] ...1 61513.836369: sys_ptrace -> 0x0
             gdb-2495    [000] ...1 61513.836370: sys_ptrace(request: c, pi=
d: 9c8, addr: 0, data: 7ffe8b2a6f10)
             gdb-2495    [000] d..3 61513.836370: sched_wait_task: comm=3Dh=
i-thread pid=3D2504 prio=3D97
             gdb-2495    [000] ...1 61513.836371: sys_ptrace -> 0x0
             gdb-2495    [000] ...1 61513.836372: sys_ptrace(request: d, pi=
d: 9c8, addr: 0, data: 7ffe8b2a6f10)
             gdb-2495    [000] d..3 61513.836373: sched_wait_task: comm=3Dh=
i-thread pid=3D2504 prio=3D97
             gdb-2495    [000] ...1 61513.836374: sys_ptrace -> 0x0
             gdb-2495    [000] ...1 61513.836376: sys_wait4(upid: ffffffff,=
 stat_addr: 7ffe8b2a7db4, options: 40000001, ru: 0)
             gdb-2495    [000] ...1 61513.836376: sched_process_wait: comm=
=3Dgdb pid=3D0 prio=3D120
             gdb-2495    [000] ...1 61513.836377: sys_wait4 -> 0x0
             gdb-2495    [000] ...1 61513.836379: sys_rt_sigprocmask(how: 2=
, nset: 7ffe8b2a7e60, oset: 0, sigsetsize: 8)
             gdb-2495    [000] ...1 61513.836379: sys_rt_sigprocmask -> 0x0
             gdb-2495    [000] ...1 61513.836382: sys_openat(dfd: ffffff9c,=
 filename: 7ffe8b2a7cd0, flags: 80000, mode: 0)
             gdb-2495    [000] ...1 61513.836399: sys_openat -> 0x12
             gdb-2495    [000] ...1 61513.836400: sys_newfstat(fd: 12, stat=
buf: 7ffe8b2a7b50)
             gdb-2495    [000] ...1 61513.836401: sys_newfstat -> 0x0
             gdb-2495    [000] ...1 61513.836402: sys_read(fd: 12, buf: 558=
5fe9960e0, count: 400)
             gdb-2495    [000] ...1 61513.836409: sys_read -> 0x140
             gdb-2495    [000] ...1 61513.836410: sys_read(fd: 12, buf: 558=
5fea6ccc0, count: 400)
             gdb-2495    [000] ...1 61513.836410: sys_read -> 0x0
             gdb-2495    [000] ...1 61513.836415: sys_close(fd: 12)
             gdb-2495    [000] ...1 61513.836416: sys_close -> 0x0
             gdb-2495    [000] ...1 61513.836419: sys_read(fd: f, buf: 7ffe=
8b2a7f17, count: 1)
             gdb-2495    [000] ...1 61513.836420: sys_read -> 0xfffffffffff=
ffff5
             gdb-2495    [000] ...1 61513.836421: sys_write(fd: 10, buf: 55=
85fe0354b1, count: 1)
             gdb-2495    [000] ...1 61513.836422: sys_write -> 0x1
             gdb-2495    [000] ...1 61513.836425: sys_ptrace(request: 1, pi=
d: 9c8, addr: 7ffff777f370, data: 7ffe8b2a7878)
             gdb-2495    [000] d..3 61513.836426: sched_wait_task: comm=3Dh=
i-thread pid=3D2504 prio=3D97
             gdb-2495    [000] ...1 61513.836428: sys_ptrace -> 0x0
             gdb-2495    [000] ...1 61513.836430: sys_ptrace(request: 3, pi=
d: 9c8, addr: a8, data: 7ffe8b2a7bd8)
             gdb-2495    [000] d..3 61513.836430: sched_wait_task: comm=3Dh=
i-thread pid=3D2504 prio=3D97
             gdb-2495    [000] ...1 61513.836431: sys_ptrace -> 0x0
             gdb-2495    [000] ...1 61513.836433: sys_openat(dfd: ffffff9c,=
 filename: 7ffe8b2a70e0, flags: 80000, mode: 0)
             gdb-2495    [000] ...1 61513.836446: sys_openat -> 0x12
             gdb-2495    [000] ...1 61513.836446: sys_pread64(fd: 12, buf: =
7ffe8b2a7430, count: 900, pos: 7ffff67c9700)
             gdb-2495    [000] ...1 61513.836449: sys_pread64 -> 0x900
             gdb-2495    [000] ...1 61513.836450: sys_close(fd: 12)
             gdb-2495    [000] ...1 61513.836450: sys_close -> 0x0
             gdb-2495    [000] ...1 61513.836479: sys_openat(dfd: ffffff9c,=
 filename: 7ffe8b2a7ad0, flags: 80000, mode: 0)
             gdb-2495    [000] ...1 61513.836488: sys_openat -> 0x12
             gdb-2495    [000] ...1 61513.836489: sys_newfstat(fd: 12, stat=
buf: 7ffe8b2a7950)
             gdb-2495    [000] ...1 61513.836490: sys_newfstat -> 0x0
             gdb-2495    [000] ...1 61513.836490: sys_read(fd: 12, buf: 558=
5fea6ccc0, count: 400)
             gdb-2495    [000] ...1 61513.836498: sys_read -> 0x14d
             gdb-2495    [000] ...1 61513.836499: sys_read(fd: 12, buf: 558=
5fe9960e0, count: 400)
             gdb-2495    [000] ...1 61513.836499: sys_read -> 0x0
             gdb-2495    [000] ...1 61513.836503: sys_close(fd: 12)
             gdb-2495    [000] ...1 61513.836504: sys_close -> 0x0
             gdb-2495    [000] ...1 61513.836507: sys_openat(dfd: ffffff9c,=
 filename: 7ffe8b2a7ad0, flags: 80000, mode: 0)
             gdb-2495    [000] ...1 61513.836514: sys_openat -> 0x12
             gdb-2495    [000] ...1 61513.836515: sys_newfstat(fd: 12, stat=
buf: 7ffe8b2a7950)
             gdb-2495    [000] ...1 61513.836515: sys_newfstat -> 0x0
             gdb-2495    [000] ...1 61513.836516: sys_read(fd: 12, buf: 558=
5fe9960e0, count: 400)
             gdb-2495    [000] ...1 61513.836521: sys_read -> 0x13b
             gdb-2495    [000] ...1 61513.836522: sys_read(fd: 12, buf: 558=
5fea6ccc0, count: 400)
             gdb-2495    [000] ...1 61513.836522: sys_read -> 0x0
             gdb-2495    [000] ...1 61513.836525: sys_close(fd: 12)
             gdb-2495    [000] ...1 61513.836525: sys_close -> 0x0
             gdb-2495    [000] ...1 61513.836529: sys_tkill(pid: 9c3, sig: =
13)
             gdb-2495    [000] *..3 61513.836532: cobalt_thread_resume: nam=
e=3Dsmokey pid=3D2499 mask=3D0x400000
             gdb-2495    [000] *..3 61513.836532: cobalt_trace_pid: pid=3D2=
499, prio=3D1
             gdb-2495    [000] *..3 61513.836533: cobalt_thread_unblock: pi=
d=3D2499 state=3D0x48848 info=3D0x0
             gdb-2495    [000] *.~3 61513.836586: cobalt_schedule: status=
=3D0x10000000
             gdb-2495    [000] *.~3 61513.836586: cobalt_trace_pid: pid=3D2=
495, prio=3D-1
             gdb-2495    [000] *.~3 61513.836587: cobalt_switch_context: pr=
ev_name=3DROOT/0 prev_pid=3D0 prev_prio=3D-1 prev_state=3D0x18008 =3D=3D> n=
ext_name=3Dsmokey next_pid=3D2499 next_prio=3D1
          smokey-2499    [000] *.~3 61513.836589: cobalt_trace_pid: pid=3D2=
499, prio=3D1
          smokey-2499    [000] *.~3 61513.836589: cobalt_shadow_gorelax: re=
ason=3Dundefined
          smokey-2499    [000] *.~3 61513.836589: cobalt_lostage_request: r=
equest=3Dwakeup pid=3D2499 comm=3Dsmokey
          smokey-2499    [000] *.~3 61513.836590: cobalt_thread_suspend: pi=
d=3D2499 mask=3D0x400080 timeout=3D0 timeout_mode=3D0 wchan=3D0000000000000=
000
          smokey-2499    [000] *.~3 61513.836590: cobalt_schedule: status=
=3D0x10000000
          smokey-2499    [000] *.~3 61513.836590: cobalt_trace_pid: pid=3D2=
499, prio=3D1
          smokey-2499    [000] *.~3 61513.836591: cobalt_switch_context: pr=
ev_name=3Dsmokey prev_pid=3D2499 prev_prio=3D1 prev_state=3D0x4488c0 =3D=3D=
> next_name=3DROOT/0 next_pid=3D0 next_prio=3D-1
             gdb-2495    [000] *.~3 61513.836592: cobalt_trace_pid: pid=3D2=
495, prio=3D-1
             gdb-2495    [000] d..5 61513.836592: sched_waking: comm=3Dsmok=
ey pid=3D2499 prio=3D98 target_cpu=3D000
             gdb-2495    [000] dN.6 61513.836594: sched_wakeup: comm=3Dsmok=
ey pid=3D2499 prio=3D98 target_cpu=3D000
             gdb-2495    [000] dN.3 61513.836594: signal_generate: sig=3D19=
 errno=3D0 code=3D-6 comm=3Dsmokey pid=3D2499 grp=3D0 res=3D0
             gdb-2495    [000] dNh3 61513.836595: irq_handler_entry: irq=3D=
120 name=3Din-band work
             gdb-2495    [000] dNh3 61513.836596: cobalt_lostage_wakeup: pi=
d=3D2499 comm=3Dsmokey
             gdb-2495    [000] *N~4 61513.838552: irq_pipeline_entry: irq=
=3D4354
             gdb-2495    [000] *N~4 61513.838553: irq_handler_entry: irq=3D=
4354 name=3DOut-of-band LAPIC timer interrupt
             gdb-2495    [000] *N~4 61513.838554: cobalt_timer_expire: time=
r=3D00000000d13b8aa9
             gdb-2495    [000] *N~4 61513.838555: irq_handler_exit: irq=3D4=
354 ret=3Dhandled
             gdb-2495    [000] *N~4 61513.838555: irq_pipeline_exit: irq=3D=
4354
             gdb-2495    [000] dNh8 61513.981277: sched_waking: comm=3Dsyst=
emd-journal pid=3D163 prio=3D120 target_cpu=3D000
             gdb-2495    [000] dNh9 61513.981278: sched_stat_runtime: comm=
=3Dgdb pid=3D2495 runtime=3D144934239 [ns] vruntime=3D300660160748 [ns]
             gdb-2495    [000] dNh9 61513.981280: sched_stat_sleep: comm=3D=
systemd-journal pid=3D163 delay=3D111416392895 [ns]
             gdb-2495    [000] dNh9 61513.981280: sched_wakeup: comm=3Dsyst=
emd-journal pid=3D163 prio=3D120 target_cpu=3D000
             gdb-2495    [000] dNh3 61513.981281: irq_handler_exit: irq=3D1=
20 ret=3Dhandled
             gdb-2495    [000] dNh3 61513.981282: irq_handler_entry: irq=3D=
124 name=3Dproxy tick
             gdb-2495    [000] dNh3 61513.981285: softirq_raise: vec=3D1 [a=
ction=3DTIMER]
             gdb-2495    [000] dNh3 61513.981285: softirq_raise: vec=3D9 [a=
ction=3DRCU]
             gdb-2495    [000] dNh4 61513.981286: sched_stat_runtime: comm=
=3Dgdb pid=3D2495 runtime=3D8375 [ns] vruntime=3D300660169123 [ns]
             gdb-2495    [000] dNh5 61513.981288: sched_waking: comm=3Dcoba=
lt_printf pid=3D2494 prio=3D120 target_cpu=3D000
             gdb-2495    [000] dNh6 61513.981289: sched_stat_runtime: comm=
=3Dgdb pid=3D2495 runtime=3D2987 [ns] vruntime=3D300660172110 [ns]
             gdb-2495    [000] dNh6 61513.981291: sched_stat_sleep: comm=3D=
cobalt_printf pid=3D2494 delay=3D238660319 [ns]
             gdb-2495    [000] dNh6 61513.981291: sched_wakeup: comm=3Dcoba=
lt_printf pid=3D2494 prio=3D120 target_cpu=3D000
             gdb-2495    [000] dNh5 61513.981292: sched_waking: comm=3Dcoba=
lt_printf pid=3D2503 prio=3D120 target_cpu=3D000
             gdb-2495    [000] dNh6 61513.981292: sched_stat_runtime: comm=
=3Dgdb pid=3D2495 runtime=3D3069 [ns] vruntime=3D300660175179 [ns]
             gdb-2495    [000] dNh6 61513.981294: sched_stat_sleep: comm=3D=
cobalt_printf pid=3D2503 delay=3D146611442 [ns]
             gdb-2495    [000] dNh6 61513.981294: sched_wakeup: comm=3Dcoba=
lt_printf pid=3D2503 prio=3D120 target_cpu=3D000
             gdb-2495    [000] *Nh3 61513.981295: cobalt_timer_start: timer=
=3D00000000d13b8aa9([host-timer/0]) value=3D588476 interval=3D0 mode=3Drel
             gdb-2495    [000] *Nh3 61513.981296: cobalt_tick_shot: next ti=
ck at 61513.981884 (delay: 588 us)
             gdb-2495    [000] dNh3 61513.981296: irq_handler_exit: irq=3D1=
24 ret=3Dhandled
             gdb-2495    [000] .Ns3 61513.981297: softirq_entry: vec=3D1 [a=
ction=3DTIMER]
             gdb-2495    [000] dNs5 61513.981298: sched_waking: comm=3Drcu_=
sched pid=3D11 prio=3D120 target_cpu=3D000
             gdb-2495    [000] dNs6 61513.981298: sched_stat_runtime: comm=
=3Dgdb pid=3D2495 runtime=3D6218 [ns] vruntime=3D300660181397 [ns]
             gdb-2495    [000] dNs6 61513.981299: sched_stat_blocked: comm=
=3Drcu_sched pid=3D11 delay=3D145119923 [ns]
             gdb-2495    [000] dNs6 61513.981299: sched_wakeup: comm=3Drcu_=
sched pid=3D11 prio=3D120 target_cpu=3D000
             gdb-2495    [000] dNs7 61513.981302: sched_waking: comm=3Dkwor=
ker/0:1 pid=3D1932 prio=3D120 target_cpu=3D000
             gdb-2495    [000] dNs8 61513.981302: sched_stat_runtime: comm=
=3Dgdb pid=3D2495 runtime=3D3884 [ns] vruntime=3D300660185281 [ns]
             gdb-2495    [000] dNs8 61513.981303: sched_stat_blocked: comm=
=3Dkworker/0:1 pid=3D1932 delay=3D206048652 [ns]
             gdb-2495    [000] dNs8 61513.981304: sched_wakeup: comm=3Dkwor=
ker/0:1 pid=3D1932 prio=3D120 target_cpu=3D000
             gdb-2495    [000] dNs5 61513.981309: softirq_raise: vec=3D2 [a=
ction=3DNET_TX]
             gdb-2495    [000] dNs5 61513.981309: softirq_raise: vec=3D2 [a=
ction=3DNET_TX]
             gdb-2495    [000] dNs5 61513.981310: softirq_raise: vec=3D2 [a=
ction=3DNET_TX]
             gdb-2495    [000] dNs5 61513.981310: softirq_raise: vec=3D2 [a=
ction=3DNET_TX]
             gdb-2495    [000] dNs5 61513.981310: softirq_raise: vec=3D2 [a=
ction=3DNET_TX]
             gdb-2495    [000] dNs5 61513.981311: softirq_raise: vec=3D2 [a=
ction=3DNET_TX]
             gdb-2495    [000] dNs5 61513.981311: softirq_raise: vec=3D2 [a=
ction=3DNET_TX]
             gdb-2495    [000] dNs5 61513.981312: softirq_raise: vec=3D2 [a=
ction=3DNET_TX]
             gdb-2495    [000] .Ns3 61513.981314: softirq_exit: vec=3D1 [ac=
tion=3DTIMER]
             gdb-2495    [000] .Ns3 61513.981314: softirq_entry: vec=3D9 [a=
ction=3DRCU]
             gdb-2495    [000] .Ns3 61513.981315: softirq_exit: vec=3D9 [ac=
tion=3DRCU]
             gdb-2495    [000] dNs5 61513.981316: sched_waking: comm=3Dksof=
tirqd/0 pid=3D10 prio=3D120 target_cpu=3D000
             gdb-2495    [000] dNs6 61513.981316: sched_stat_runtime: comm=
=3Dgdb pid=3D2495 runtime=3D13841 [ns] vruntime=3D300660199122 [ns]
             gdb-2495    [000] dNs6 61513.981317: sched_stat_sleep: comm=3D=
ksoftirqd/0 pid=3D10 delay=3D149349034 [ns]
             gdb-2495    [000] dNs6 61513.981317: sched_wakeup: comm=3Dksof=
tirqd/0 pid=3D10 prio=3D120 target_cpu=3D000
             gdb-2495    [000] .N.1 61513.981318: sys_tkill -> 0x0
             gdb-2495    [000] d..3 61513.981320: sched_switch: prev_comm=
=3Dgdb prev_pid=3D2495 prev_prio=3D120 prev_state=3DR =3D=3D> next_comm=3Ds=
mokey next_pid=3D2499 next_prio=3D98
          smokey-2499    [000] *.~3 61513.981888: irq_pipeline_entry: irq=
=3D4354
          smokey-2499    [000] *.~3 61513.981888: irq_handler_entry: irq=3D=
4354 name=3DOut-of-band LAPIC timer interrupt
          smokey-2499    [000] *.~3 61513.981889: cobalt_timer_expire: time=
r=3D00000000d13b8aa9
          smokey-2499    [000] *.~3 61513.981889: irq_handler_exit: irq=3D4=
354 ret=3Dhandled
          smokey-2499    [000] *.~3 61513.981890: irq_pipeline_exit: irq=3D=
4354
          smokey-2499    [000] d.h1 61514.106435: irq_handler_entry: irq=3D=
124 name=3Dproxy tick
          smokey-2499    [000] *.h1 61514.106441: cobalt_timer_start: timer=
=3D00000000d13b8aa9([host-timer/0]) value=3D2109534 interval=3D0 mode=3Drel
          smokey-2499    [000] *.h1 61514.106441: cobalt_tick_shot: next ti=
ck at 61514.108550 (delay: 2109 us)
          smokey-2499    [000] d.h1 61514.106442: irq_handler_exit: irq=3D1=
24 ret=3Dhandled
          smokey-2499    [000] ...1 61514.106442: cobalt_shadow_relaxed: st=
ate=3D0x4488c0 info=3D0x200
          smokey-2499    [000] *.~1 61514.108552: irq_pipeline_entry: irq=
=3D4354

Regards

Hongzhan Chen
  =20
>
>--=20
>Philippe.

