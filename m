MIME-Version: 1.0
In-Reply-To: <CAGTNcBt+DrdbxnewSxFi3gJjnHKrgE_rB8OJaRvMQWe8uX8ORg@mail.gmail.com>
References: <CAGTNcBt+DrdbxnewSxFi3gJjnHKrgE_rB8OJaRvMQWe8uX8ORg@mail.gmail.com>
Date: Fri, 8 Jun 2012 21:42:28 -0400
Message-ID: <CAGTNcBsrjvd_bWx1YN=aeXgiC1B3o+Y_bsW732y=B0xnaqPkVw@mail.gmail.com>
From: Josh Bowman <jbowman@facts-inc.com>
Content-Type: text/plain; charset=ISO-8859-1
Subject: Re: [Xenomai] I-pipe 2.6.38.8-x86-2.11-02 reports illicit call from
 domain Xenomai (on x86 32-bit)
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Hi,

Sorry about the horrible formatting on that. Hoping this is
easier to read:

I'm trying to update our systems to use a new kernel and
Xenomai 2.6.0, with ipipe 2.6.38.8-x86-2.11-02. (Previously,
I've tested 2.5.6 with ipipe 2.6.37-x86-2.9.00; there was no
ipipe log with that version.)

Everything seems to be running fine, but I get an error
message and a call trace in the kernel logs. The message
is "I-pipe: Detected illicit call from domain 'Xenomai'".
This happens pretty much as soon as our first Xenomai
tasks start running, and it doesn't appear to be hurting
anything.

The tasks mentioned in the tracer log are both low-priority
native-skin tasks that use Xenomai services to communicate
with our realtime tasks, but also use Linux services.  The
configClient task uses rt_mutex and condition variables to
receive requests from another Xenomai task in the same
process. Its job is to talk on a tcp socket with a java
server. It expects to go into secondary mode when doing that,
 and is careful not to hold the rt_mutex when blocking. (But
I mention that, because I'm not sure if the ipipe message
could be caused by a mistake of that sort in userspace.)

configClient sometimes also sends rt_queue messages to the
loggingTask, which is also mentioned in the tracer log. (It
looks like the loggingTask had recently received a message
from somewhere, but I don't understand the trace well enough
to say for certain whether that message came from the
configClient.) When loggingTask receives a message, it will
write() it to disk; again, it expects to go to secondary
mode for that.

We're building Xenomai for 32-bit x86, with --enable-x86-sep
and CFLAGS="-fno-omit-frame-pointer".

The trace follows.

Thank you,

-Josh


[   30.582794] I-pipe: Domain Xenomai registered.
[   30.582814] Xenomai: hal/i386 started.
[   30.582873] Xenomai: scheduling class idle registered.
[   30.582876] Xenomai: scheduling class rt registered.
[   30.617841] Xenomai: real-time nucleus v2.6.0 (Movin' On) loaded.
[   30.617846] Xenomai: debug mode enabled.
[   30.693068] Xenomai: starting native API services.
[   45.619810] I-pipe: Detected illicit call from domain 'Xenomai'
[   45.619815] <3>        into a service reserved for domain 'Linux' and below.
[   45.619827] Pid: 885, comm: configClient.88 Not tainted 2.6.38.8+1.1.0ubu6 #1
[   45.619833] Call Trace:
[   45.619853]  [<c01a3cfd>] ? ipipe_check_context+0x1ad/0x1f0
[   45.619863]  [<c0199d97>] ? kgdb_cpu_enter+0xa7/0x560
[   45.619870]  [<c019a44f>] ? kgdb_handle_exception+0xef/0x150
[   45.619877]  [<c01a7fda>] ? ipipe_trace_function+0x2a/0x30
[   45.619886]  [<c011a59d>] ? __ipipe_handle_exception+0x7d/0x670
[   45.619897]  [<c05a7cef>] ? error_code+0x5f/0x70
[   45.619902] I-pipe tracer log (100 points):
[   45.619906]  |  + func                    0
ipipe_trace_panic_freeze+0x4 (ipipe_check_context+0x155)
[   45.619930]  |  + func                    0 ipipe_check_context+0xf
(kgdb_cpu_enter+0xa7)
[   45.619950]  |  + func                   -1
kgdb_disable_hw_debug+0x9 (kgdb_cpu_enter+0x5f)
[   45.619973]  |  + func                   -2 kgdb_cpu_enter+0x9
(kgdb_handle_exception+0xef)
[   45.619993]  |  + func                   -3
kgdb_handle_exception+0x8 (__ipipe_handle_exception+0x7d)
[   45.620021]  |  + func                   -4
__ipipe_handle_exception+0x9 (error_code+0x5f)
[   45.620041]  |  + begin   0x80000001    -39
__ipipe_syscall_root+0xd3 (sysenter_past_esp+0x55)
[   45.620045]  |  + end     0x80000001    -39
__ipipe_dispatch_event+0x2a3 (__ipipe_syscall_root+0x53)
[   45.620045]  |  + begin   0x80000001    -39
__ipipe_dispatch_event+0x213 (__ipipe_syscall_root+0x53)
[   45.620045]  |  + end     0x80000000    -39
__ipipe_restore_pipeline_head+0x83
(xnlock_put_irqrestore.constprop.12+0xf5 [xeno_native])
[   45.620045]  |  # func                  -39
__ipipe_restore_pipeline_head+0xf
(xnlock_put_irqrestore.constprop.12+0xf5 [xeno_native])
[   45.620045]  |  # func                  -40
xnlock_put_irqrestore.constprop.12+0xf [xeno_native]
(__rt_queue_send+0x142 [xeno_native])
[   45.620045]  |  # [  885] configCl 4    -40 __xnpod_schedule+0x5aa
[xeno_nucleus] (rt_queue_send+0x2bc [xeno_native])
[   45.620045]  |  # func                  -41 xnsched_pick_next+0xf
[xeno_nucleus] (__xnpod_schedule+0x273 [xeno_nucleus])
[   45.620045]  |  # [  877] loggingT 8    -41 __xnpod_schedule+0x12e
[xeno_nucleus] (xnpod_suspend_thread+0x53b [xeno_nucleus])
[   45.620045]  |  # func                  -41 __xnpod_schedule+0x9
[xeno_nucleus] (xnpod_suspend_thread+0x53b [xeno_nucleus])
[   45.620045]  |  # func                  -42 xnarch_ns_to_tsc+0xf
[xeno_nucleus] (xntimer_start_aperiodic+0x8f [xeno_nucleus])
[   45.620045]  |  # func                  -43
xntimer_start_aperiodic+0x9 [xeno_nucleus] (xnpod_suspend_thread+0x300
[xeno_nucleus])
[   45.620045]  |  # func                  -44 xntimer_migrate+0x9
[xeno_nucleus] (xnpod_suspend_thread+0x2dc [xeno_nucleus])
[   45.620045]  |  # func                  -45
xnpod_suspend_thread+0x9 [xeno_nucleus] (xnsynch_sleep_on+0x13b
[xeno_nucleus])
[   45.620045]  |  # func                  -46 xnsynch_sleep_on+0x9
[xeno_nucleus] (rt_queue_receive_inner+0x3ef [xeno_native])
[   45.620045]  |  # func                  -46
rt_queue_receive_inner+0x9 [xeno_native] (__rt_queue_receive+0x141
[xeno_native])
[   45.620045]  |  # func                  -47 xnregistry_fetch+0x3
[xeno_nucleus] (__rt_queue_receive+0x11d [xeno_native])
[   45.620045]  |  + begin   0x80000000    -47
__rt_queue_receive+0x1a3 [xeno_native] (hisyscall_event+0x1f0
[xeno_nucleus])
[   45.620045]     + func                  -47
__copy_from_user_ll_nozero+0xf (__xn_safe_copy_from_user+0x31
[xeno_native])
[   45.620045]     + func                  -47
__xn_safe_copy_from_user+0xf [xeno_native] (__rt_queue_receive+0x58
[xeno_native])
[   45.620045]     + func                  -47
__copy_from_user_ll_nozero+0xf (__rt_queue_receive+0x40 [xeno_native])
[   45.620045]     + func                  -48 __rt_queue_receive+0x9
[xeno_native] (hisyscall_event+0x1f0 [xeno_nucleus])
[   45.620045]     + func                  -48 hisyscall_event+0xf
[xeno_nucleus] (__ipipe_dispatch_event+0xef)
[   45.620045]  |  + end     0x80000001    -48
__ipipe_dispatch_event+0x222 (__ipipe_syscall_root+0x53)
[   45.620045]  |  + begin   0x80000001    -48
__ipipe_dispatch_event+0x2cb (__ipipe_syscall_root+0x53)
[   45.620045]     + func                  -48
__ipipe_dispatch_event+0x9 (__ipipe_syscall_root+0x53)
[   45.620045]     + func                  -49
__ipipe_syscall_root+0xf (sysenter_past_esp+0x55)
[   45.620045]  |  + begin   0x80000001    -50
__ipipe_syscall_root+0xd3 (sysenter_past_esp+0x55)
[   45.620045]  |  + end     0x80000001    -50
__ipipe_dispatch_event+0x2a3 (__ipipe_syscall_root+0x53)
[   45.620045]  |  + begin   0x80000001    -50
__ipipe_dispatch_event+0x213 (__ipipe_syscall_root+0x53)
[   45.620045]  |  + end     0x80000000    -50
__ipipe_restore_pipeline_head+0x83
(xnlock_put_irqrestore.constprop.12+0xf5 [xeno_native])
[   45.620045]  |  # func                  -51
__ipipe_restore_pipeline_head+0xf
(xnlock_put_irqrestore.constprop.12+0xf5 [xeno_native])
[   45.620045]  |  # func                  -51
xnlock_put_irqrestore.constprop.12+0xf [xeno_native]
(__rt_queue_free+0x12a [xeno_native])
[   45.620045]  |  # func                  -52 __queue_check_msg+0x3
[xeno_native] (xnheap_test_and_free+0x335 [xeno_nucleus])
[   45.620045]  |  # func                  -54
xnheap_test_and_free+0x9 [xeno_nucleus] (rt_queue_free+0x1f8
[xeno_native])
[   45.620045]  |  # func                  -55 rt_queue_free+0x9
[xeno_native] (__rt_queue_free+0x11e [xeno_native])
[   45.620045]  |  # func                  -55 xnregistry_fetch+0x3
[xeno_nucleus] (__rt_queue_free+0xff [xeno_native])
[   45.620045]  |  + begin   0x80000000    -55 __rt_queue_free+0x143
[xeno_native] (hisyscall_event+0x1f0 [xeno_nucleus])
[   45.620045]     + func                  -56
__copy_from_user_ll_nozero+0xf (__rt_queue_free+0x3b [xeno_native])
[   45.620045]     + func                  -56 __rt_queue_free+0x9
[xeno_native] (hisyscall_event+0x1f0 [xeno_nucleus])
[   45.620045]     + func                  -56 hisyscall_event+0xf
[xeno_nucleus] (__ipipe_dispatch_event+0xef)
[   45.620045]  |  + end     0x80000001    -57
__ipipe_dispatch_event+0x222 (__ipipe_syscall_root+0x53)
[   45.620045]  |  + begin   0x80000001    -57
__ipipe_dispatch_event+0x2cb (__ipipe_syscall_root+0x53)
[   45.620045]     + func                  -57
__ipipe_dispatch_event+0x9 (__ipipe_syscall_root+0x53)
[   45.620045]     + func                  -57
__ipipe_syscall_root+0xf (sysenter_past_esp+0x55)
[   45.620045]  |  + begin   0x80000001    -94
__ipipe_syscall_root+0xd3 (sysenter_past_esp+0x55)
[   45.620045]  |  + end     0x80000001    -94
__ipipe_dispatch_event+0x2a3 (__ipipe_syscall_root+0x53)
[   45.620045]  |  + begin   0x80000001    -95
__ipipe_dispatch_event+0x213 (__ipipe_syscall_root+0x53)
[   45.620045]     + func                  -95 __copy_to_user_ll+0xf
(__rt_timer_read+0x4d [xeno_native])
[   45.620045]     + func                  -95 xnarch_tsc_to_ns+0xc
[xeno_nucleus] (xnarch_get_cpu_time+0xf [xeno_nucleus])
[   45.620045]     + func                  -95 xnarch_get_cpu_time+0x3
[xeno_nucleus] (__rt_timer_read+0x1a [xeno_native])
[   45.620045]     + func                  -95 __rt_timer_read+0x8
[xeno_native] (hisyscall_event+0x1f0 [xeno_nucleus])
[   45.620045]     + func                  -96 hisyscall_event+0xf
[xeno_nucleus] (__ipipe_dispatch_event+0xef)
[   45.620045]  |  + end     0x80000001    -96
__ipipe_dispatch_event+0x222 (__ipipe_syscall_root+0x53)
[   45.620045]  |  + begin   0x80000001    -96
__ipipe_dispatch_event+0x2cb (__ipipe_syscall_root+0x53)
[   45.620045]     + func                  -96
__ipipe_dispatch_event+0x9 (__ipipe_syscall_root+0x53)
[   45.620045]     + func                  -96
__ipipe_syscall_root+0xf (sysenter_past_esp+0x55)
[   45.620045]  |  + begin   0x80000001   -102
__ipipe_syscall_root+0xd3 (sysenter_past_esp+0x55)
[   45.620045]  |  + end     0x80000001   -102
__ipipe_dispatch_event+0x2a3 (__ipipe_syscall_root+0x53)
[   45.620045]  |  + begin   0x80000001   -102
__ipipe_dispatch_event+0x213 (__ipipe_syscall_root+0x53)
[   45.620045]  |  + end     0x80000000   -104
__ipipe_restore_pipeline_head+0x83
(xnlock_put_irqrestore.constprop.12+0xf5 [xeno_native])
[   45.620045]  |  # func                 -104
__ipipe_restore_pipeline_head+0xf
(xnlock_put_irqrestore.constprop.12+0xf5 [xeno_native])
[   45.620045]  |  # func                 -104
xnlock_put_irqrestore.constprop.12+0xf [xeno_native]
(__rt_queue_receive+0x162 [xeno_native])
[   45.620045]  |  # [  877] loggingT 8   -107 __xnpod_schedule+0x5aa
[xeno_nucleus] (xnpod_suspend_thread+0x53b [xeno_nucleus])
[   45.620045]  |  # func                 -109 xnsched_pick_next+0xf
[xeno_nucleus] (__xnpod_schedule+0x273 [xeno_nucleus])
[   45.620045]  |  # [  885] configCl 4   -109 __xnpod_schedule+0x12e
[xeno_nucleus] (rt_queue_send+0x2bc [xeno_native])
[   45.620045]  |  # func                 -109 __xnpod_schedule+0x9
[xeno_nucleus] (rt_queue_send+0x2bc [xeno_native])
[   45.620045]  |  # func                 -110
xntimer_stop_aperiodic+0x5 [xeno_nucleus] (xnpod_resume_thread+0x46f
[xeno_nucleus])
[   45.620045]  |  # [  877] loggingT 8   -111
xnpod_resume_thread+0xe2 [xeno_nucleus]
(xnsynch_wakeup_one_sleeper+0xfc [xeno_nucleus])
[   45.620045]  |  # func                 -111 xnpod_resume_thread+0x9
[xeno_nucleus] (xnsynch_wakeup_one_sleeper+0xfc [xeno_nucleus])
[   45.620045]  |  # func                 -113
xnsynch_wakeup_one_sleeper+0x9 [xeno_nucleus] (rt_queue_send+0x268
[xeno_native])
[   45.620045]  |  # func                 -114 xnheap_check_block+0x9
[xeno_nucleus] (rt_queue_send+0x226 [xeno_native])
[   45.620045]  |  # func                 -115 rt_queue_send+0x9
[xeno_native] (__rt_queue_send+0x138 [xeno_native])
[   45.620045]  |  # func                 -115 xnregistry_fetch+0x3
[xeno_nucleus] (__rt_queue_send+0x113 [xeno_native])
[   45.620045]  |  + begin   0x80000000   -116 __rt_queue_send+0x15b
[xeno_native] (hisyscall_event+0x1f0 [xeno_nucleus])
[   45.620045]     + func                 -116
__copy_from_user_ll_nozero+0xf (__rt_queue_send+0x40 [xeno_native])
[   45.620045]     + func                 -117 __rt_queue_send+0x9
[xeno_native] (hisyscall_event+0x1f0 [xeno_nucleus])
[   45.620045]     + func                 -117 hisyscall_event+0xf
[xeno_nucleus] (__ipipe_dispatch_event+0xef)
[   45.620045]  |  + end     0x80000001   -117
__ipipe_dispatch_event+0x222 (__ipipe_syscall_root+0x53)
[   45.620045]  |  + begin   0x80000001   -117
__ipipe_dispatch_event+0x2cb (__ipipe_syscall_root+0x53)
[   45.620045]     + func                 -118
__ipipe_dispatch_event+0x9 (__ipipe_syscall_root+0x53)
[   45.620045]     + func                 -118
__ipipe_syscall_root+0xf (sysenter_past_esp+0x55)
[   45.620045]  |  + begin   0x80000001   -139
__ipipe_syscall_root+0xd3 (sysenter_past_esp+0x55)
[   45.620045]  |  + end     0x80000001   -139
__ipipe_dispatch_event+0x2a3 (__ipipe_syscall_root+0x53)
[   45.620045]  |  + begin   0x80000001   -139
__ipipe_dispatch_event+0x213 (__ipipe_syscall_root+0x53)
[   45.620045]     + func                 -139 __copy_to_user_ll+0xf
(__rt_task_inquire+0x96 [xeno_native])
[   45.620045]  |  + end     0x80000000   -140
__ipipe_restore_pipeline_head+0x83 (rt_task_inquire+0x12c
[xeno_native])
[   45.620045]  |  # func                 -140
__ipipe_restore_pipeline_head+0xf (rt_task_inquire+0x12c
[xeno_native])
[   45.620045]  |  # func                 -140 xnarch_tsc_to_ns+0xc
[xeno_nucleus] (rt_task_inquire+0x2b9 [xeno_native])
[   45.620045]  |  # func                 -141 strcpy+0xc
(rt_task_inquire+0x266 [xeno_native])
[   45.620045]  |  + begin   0x80000000   -141 rt_task_inquire+0x23b
[xeno_native] (__rt_task_inquire+0x68 [xeno_native])
[   45.620045]     + func                 -142 rt_task_inquire+0x9
[xeno_native] (__rt_task_inquire+0x68 [xeno_native])
[   45.620045]     + func                 -142 __rt_task_lookup+0x4
[xeno_native] (__rt_task_inquire+0x39 [xeno_native])
[   45.620045]     + func                 -143
__copy_from_user_ll_nozero+0xf (__xn_safe_copy_from_user+0x31
[xeno_native])

