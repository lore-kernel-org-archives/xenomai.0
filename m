From: "Chen, Hongzhan" <hongzhan.chen@intel.com>
Subject: RE: gdb test failure issue on xenomai 3.2
Date: Fri, 5 Mar 2021 01:15:25 +0000
Message-ID: <CY4PR11MB1703AFA86C561954ECFE93BAF2969@CY4PR11MB1703.namprd11.prod.outlook.com>
References: <MWHPR11MB17100A5F27118C92A44F94C4F2999@MWHPR11MB1710.namprd11.prod.outlook.com>
In-Reply-To: <MWHPR11MB17100A5F27118C92A44F94C4F2999@MWHPR11MB1710.namprd11.prod.outlook.com>
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
To: Philippe Gerum <rpm@xenomai.org>, "xenomai@xenomai.org" <xenomai@xenomai.org>

Hi Philippe,

I think I already found the root cause and almost fix it but still need tim=
e to validate it.

Temporary patch like following:

diff --git a/kernel/cobalt/dovetail/sched.c b/kernel/cobalt/dovetail/sched.=
c
index de7c43b70..846b571b6 100644
--- a/kernel/cobalt/dovetail/sched.c
+++ b/kernel/cobalt/dovetail/sched.c
@@ -56,9 +56,22 @@ int pipeline_leave_inband(void)

 int pipeline_leave_oob_prepare(void)
 {
-       dovetail_leave_oob();
+       int suspmask =3D XNRELAX;
+       struct xnthread *curr =3D xnthread_current();

-       return XNRELAX;
+       dovetail_leave_oob();
+       /*
+        * If current is being debugged, record that it should migrate
+        * back in case it resumes in userspace. If it resumes in
+        * kernel space, i.e.  over a restarting syscall, the
+        * associated hardening will both clear XNCONTHI and disable
+        * the user return notifier again.
+        */
+       if (xnthread_test_state(curr, XNSSTEP)) {
+               xnthread_set_info(curr, XNCONTHI);
+               suspmask |=3D XNDBGSTOP;
+       }
+       return suspmask;
 }

 void pipeline_leave_oob_finish(void)
intel@intel-Z97X-UD5H:~/iotg/dovetail/xenomaioverdovetail/cobalt-dovetail/u=
pstream/xenomai-rpm$ git diff kernel/cobalt/dovetail/kevents.c
diff --git a/kernel/cobalt/dovetail/kevents.c b/kernel/cobalt/dovetail/keve=
nts.c
index 966a63ce0..9bceffaac 100644
--- a/kernel/cobalt/dovetail/kevents.c
+++ b/kernel/cobalt/dovetail/kevents.c
        if (xnthread_test_info(thread, XNCONTHI)) {
                xnlock_get_irqsave(&nklock, s);
                xnthread_clear_info(thread, XNCONTHI);
@@ -492,6 +494,8 @@ static void handle_ptrace_cont(void)
                        unregister_debugged_thread(curr);

                xnthread_set_localinfo(curr, XNHICCUP);
+
+               dovetail_request_ucall(current);
        }

After validation is done , I would submit clean patch to review.

Regards

Hongzhan Chen

-----Original Message-----
From: Chen, Hongzhan=20
Sent: Tuesday, March 2, 2021 7:21 PM
To: Philippe Gerum <rpm@xenomai.org>; xenomai@xenomai.org
Subject: gdb test failure issue on xenomai 3.2

Hi Philippe,

The gdb test fails on xenomai 3.2 because low priority smokey process still=
 has chance to scheduled to=20
execute it's user space's task. According to my debug , it seems it is rela=
ted to handle_ptrace_resume of=20
dovetail/kevents.c because in failed case it would try to resume hi-thread =
like stack [1] and then
 hi-thread call xnthread_harden like stack [2].
But on IPIPE-xenomai image it would resume smokey thread at first and then =
xnthread_harden would
be called in smokey thread in the following.
The problem is that I do know why in failed case it would xnthread_resume h=
i-thread at first like log[3] but with=20
IPIPE-xenomai image it always xnthread_resume smokey non-rt thread like in =
log [4] so that I still do not=20
know how to fix it. I still need more time to debug it out.  Please comment=
.

In addition , I found that there is comments in handle_ptstep_event of kern=
el/evl/thread.c. It said that=20
"the ptracer might have switched focus"  but  in gdb test case breakpoint e=
xactly switch to hi-thread=20
from smokey process . Does that means we need to do some special handle for=
 it ?
But for me evl is quite so different from xenomai on handling INBAND_TASK_P=
TSTEP  in handle_inband_event.

[1]:
0xffffffff811c4020 xnthread_resume(): kernel/xenomai/thread.c, line 1039=09
0xffffffff811b51e0 handle_ptrace_resume(): ...ernel/xenomai/pipeline/kevent=
s.c, line 474=09
0xffffffff81078bec inband_ptstep_notify(): ./include/linux/dovetail.h, line=
 121=09
0xffffffff81078bec ptrace_resume(): kernel/ptrace.c, line 830=09
0xffffffff81079f32 ptrace_request(): kernel/ptrace.c, line 1194=09
0xffffffff8102eaab arch_ptrace(): arch/x86/kernel/ptrace.c, line 818=09
0xffffffff8107949b __do_sys_ptrace(): kernel/ptrace.c, line 1279=09
0xffffffff8107949b __se_sys_ptrace(): kernel/ptrace.c, line 1244=09
0xffffffff8107949b __x64_sys_ptrace(): kernel/ptrace.c, line 1244=09
0xffffffff81b93549 do_syscall_64(): arch/x86/entry/common.c, line 53=09
0xffffffff81c0007c entry_SYSCALL_64_after_hwframe(): arch/x86/entry/entry_6=
4.S, line 118=09

[2]:
0xffffffff811c6340 xnthread_harden(): kernel/xenomai/thread.c, line 1864=09
0xffffffff811b56fa handle_user_return(): ...ernel/xenomai/pipeline/kevents.=
c, line 339=09
0xffffffff811b56fa handle_inband_event(): ...ernel/xenomai/pipeline/kevents=
.c, line 514=09
0xffffffff8110791e do_retuser(): kernel/entry/common.c, line 238=09
0xffffffff8110791e exit_to_user_mode_prepare(): kernel/entry/common.c, line=
 262=09
0xffffffff81b97795 irqentry_exit_to_user_mode(): kernel/entry/common.c, lin=
e 356=09
0xffffffff81b941dc exc_int3(): arch/x86/kernel/traps.c, line 710=09
0xffffffff81c00aa1 asm_exc_int3(): .../arch/x86/include/asm/idtentry.h, lin=
e 592=09

[3]:
gdb-1153    [003] d..3 17451.761941: sched_wait_task: comm=3Dhi-thread pid=
=3D1160 prio=3D97
gdb-1153    [003] d..3 17451.761944: sched_wait_task: comm=3Dhi-thread pid=
=3D1160 prio=3D97
gdb-1153    [003] d..3 17451.761947: sched_wait_task: comm=3Dhi-thread pid=
=3D1160 prio=3D97
gdb-1153    [003] d..3 17451.761953: sched_wait_task: comm=3Dhi-thread pid=
=3D1160 prio=3D97
gdb-1153    [003] d..3 17451.761958: sched_wait_task: comm=3Dhi-thread pid=
=3D1160 prio=3D97
gdb-1153    [003] d..3 17451.761973: sched_wait_task: comm=3Dhi-thread pid=
=3D1160 prio=3D97
gdb-1153    [003] D..1 17451.761976: cobalt_thread_resume: name=3Dhi-thread=
 pid=3D1160 mask=3D0x400000
gdb-1153    [003] D..1 17451.761977: cobalt_trace_pid: pid=3D1160, prio=3D2
gdb-1153    [003] d..3 17451.761978: sched_waking: comm=3Dhi-thread pid=3D1=
160 prio=3D97 target_cpu=3D000

[4]
             gdb-839     [000] d..1  2420.981050: signal_deliver: sig=3D17 =
errno=3D0 code=3D4 sa_handler=3D55bb958074d0 sa_flags=3D14000000
             gdb-839     [000] ....  2420.981069: sched_process_wait: comm=
=3Dgdb pid=3D0 prio=3D120
             gdb-839     [000] d..2  2420.981075: sched_wait_task: comm=3Dh=
i-thread pid=3D846 prio=3D97
             gdb-839     [000] d..2  2420.981080: sched_wait_task: comm=3Dh=
i-thread pid=3D846 prio=3D97
             gdb-839     [000] d..2  2420.981082: sched_wait_task: comm=3Dh=
i-thread pid=3D846 prio=3D97
             gdb-839     [000] d..2  2420.981084: sched_wait_task: comm=3Dh=
i-thread pid=3D846 prio=3D97
             gdb-839     [000] ....  2420.981087: sched_process_wait: comm=
=3Dgdb pid=3D0 prio=3D120
             gdb-839     [000] d..2  2420.981147: sched_wait_task: comm=3Dh=
i-thread pid=3D846 prio=3D97
             gdb-839     [000] d..2  2420.981150: sched_wait_task: comm=3Dh=
i-thread pid=3D846 prio=3D97
             gdb-839     [000] d..1  2420.981303: cobalt_thread_resume: nam=
e=3Dsmokey pid=3D841 mask=3D0x400000
             gdb-839     [000] d..1  2420.981304: cobalt_thread_unblock: pi=
d=3D841 state=3D0x48848 info=3D0x0
             gdb-839     [000] d..1  2420.981305: cobalt_schedule_remote: s=
tatus=3D0x10000000
             gdb-839     [000] d..1  2420.981305: cobalt_schedule: status=
=3D0x10000000

Regards

Hongzhan Chen


