Message-ID: <3535aae80708270627l4064dd1fif3e6aa10314d38f@domain.hid>
Date: Mon, 27 Aug 2007 15:27:25 +0200
From: "andy motten" <andy.motten@domain.hid>
In-Reply-To: <3535aae80708140826o107e0fa3wee8db991ec1e14bd@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_43681_16250756.1188221245748"
References: <3535aae80708090211m198a1b87o9ae164fd94362838@domain.hid>
	<46BC1494.2010303@domain.hid>
	<Pine.LNX.4.64.0708100951160.23969@domain.hid>
	<3535aae80708100805l526475ebt5e4ff54c92f7daab@domain.hid>
	<46BC8074.3090104@domain.hid>
	<Pine.LNX.4.64.0708130903220.14311@domain.hid>
	<18112.1512.506911.608273@domain.hid>
	<3535aae80708130810s603edb7fo9f7be56342ddf921@domain.hid>
	<46C08E61.9060204@domain.hid>
	<3535aae80708140826o107e0fa3wee8db991ec1e14bd@domain.hid>
Subject: Re: [Xenomai-help] hard lock-up
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: xenomai@xenomai.org

------=_Part_43681_16250756.1188221245748
Content-Type: multipart/alternative; 
	boundary="----=_Part_43682_26937847.1188221245748"

------=_Part_43682_26937847.1188221245748
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

>
>
> I will run continuously several tests on the pc (including "latency -f")
> for the rest of this week. Since I am not in the office during this period
> (so not in the neighborhood of this problematic pc).
> And I hope (I hope not in vain) that the latency tracer will give us a
> hint for the reason of the hard lock ups (if a hard lock up happens during
> this period).
>
> andy
>


Hello,

Since  we are having a hard time finding the hard lock-ups. We have taken a
closer look at the failed tests of orocos (maybe the source of the problem
is the same). These failures occur during the make check execution.

    The following tests FAILED:
        2 - task-test (OTHER-FAULT)
        3 - event-test (OTHER-FAULT)
        4 - taskcontext-test (OTHER-FAULT)

When we perform a single test, e.g task-test, we get the the following
messages: Killed
The OROCOS messages are then:

0.000 [ Info   ][Logger] Successfully extracted environment variable
ORO_LOGLEVEL
0.001 [ Info   ][Logger]  OROCOS version '1.2.1' compiled with GCC
4.1.2.Orocos Logging Activated at level : [ Debug  ] ( 6 )
0.001 [ Info   ][Logger] Reference System Time is : 880886725351 ticks (
315.369 seconds ).
0.002 [ Info   ][Logger] Logging is relative to this time.
0.002 [ Info   ][Logger] Xenomai Periodic Timer runs in preemptive
'one-shot' mode.
0.003 [ Debug  ][Logger] Xenomai Timer and Main Task Created
0.003 [ Debug  ][Logger] MainThread started.
0.003 [ Debug  ][Logger] Starting StartStopManager.
0.004 [ Info   ][Toolkit] Loading Tool RealTime.
0.005 [ Debug  ][Toolkit] Registered Type 'int' to the Orocos Type System.
0.005 [ Debug  ][Toolkit] Registered Type 'uint' to the Orocos Type System.
0.006 [ Debug  ][Toolkit] Registered Type 'double' to the Orocos Type
System.
0.006 [ Debug  ][Toolkit] Registered Type 'bool' to the Orocos Type System.
0.006 [ Debug  ][Toolkit] Registered Type 'PropertyBag' to the Orocos Type
System.
0.007 [ Debug  ][Toolkit] Registered Type 'float' to the Orocos Type System.
0.007 [ Debug  ][Toolkit] Registered Type 'char' to the Orocos Type System.
0.008 [ Debug  ][Toolkit] Registered Type 'array' to the Orocos Type System.
0.008 [ Debug  ][Toolkit] Registered Type 'string' to the Orocos Type
System.
0.010 [ Debug  ][./task-test::main()] ORO_main starting...
0.010 [ Info   ][./task-test::main()] LogLevel unaltered by test-runner.
0.011 [ Info   ][./task-test::main()] Creating PeriodicThread for scheduler:
0
0.012 [ Info   ][TimerThreadInstance] PeriodicThread created with scheduler
type '0', priority 15 and period 0.01.
0.013 [ Debug  ][Logger] Periodic Thread TimerThreadInstance started.
0.014 [ Info   ][PThread] PeriodicThread created with scheduler type '0',
priority 99 and period 0.1.
0.014 [ Debug  ][Logger] Periodic Thread PThread started.
0.115 [ Debug  ][Logger] Periodic Thread PThread stopping... done.
0.115 [ Debug  ][Logger] Periodic Thread PThread started.
1.216 [ Debug  ][Logger] Periodic Thread PThread stopping... done.
1.216 [ Debug  ][~PeriodicThread] Terminating PThread

On the serial console we get the following listing (complete listing in
appendix):

Xenomai: starting native API services.
I-pipe: Detected illicit call from domain 'Xenomai'
        into a service reserved for domain 'Linux' and below.
       f635be74 00000000 00000000 52544149 f635be98 c0104789 c02cfa4f
c02f5b80
       f6c4e2f0 f635beb0 c0137d69 c02c256c c02c1186 c02c01b8 f8c0b280
f635bebc
       c0132981 f60a1730 f635bed8 f8bd8570 c010ef8c 00000000 f60a0120
f8beefe0
Call Trace:
 [<c0103ffb>] show_trace_log_lvl+0x1f/0x35
 [<c01040bb>] show_stack_log_lvl+0xaa/0xcf
 [<c0104789>] show_stack+0x2f/0x36
 [<c0137d69>] ipipe_check_context+0x7a/0x81
 [<c0132981>] module_put+0x19/0x7d
 [<f8bd8570>] xnshadow_unmap+0xbc/0xff [xeno_nucleus]
 [<f8bfdc75>] __shadow_delete_hook+0x25/0x27 [xeno_native]
 [<f8bd1454>] xnpod_delete_thread+0x1b9/0x2aa [xeno_nucleus]
 [<f8bfc36b>] rt_task_delete+0x140/0x145 [xeno_native]
 [<f8bfe02a>] __rt_task_delete+0x58/0x69 [xeno_native]
 [<f8bd8165>] hisyscall_event+0x185/0x291 [xeno_nucleus]
 [<c0138940>] __ipipe_dispatch_event+0xc0/0x1da
 [<c010ed6b>] __ipipe_syscall_root+0x43/0x10a
 [<c0102e79>] system_call+0x29/0x41
 =======================
I-pipe tracer log (30 points):
 | # *func                    0 ipipe_trace_panic_freeze+0x9
(ipipe_check_context+0x3f)
 | # *func                    0 ipipe_check_context+0xc (module_put+0x19)
 | # *func                    0 module_put+0x9 (xnshadow_unmap+0xbc
[xeno_nucleus])
 | # *func                    0 xnshadow_unmap+0xe [xeno_nucleus]
(__shadow_delete_hook+0x25 [xeno_native])
 | # *func                   -1 __shadow_delete_hook+0x8 [xeno_native]
(xnpod_delete_thread+0x1b9 [xeno_nucleus])
 | # *func                   -1 xnsynch_release_all_ownerships+0xe
[xeno_nucleus] (xnpod_delete_thread+0x157 [xeno_nucleus])
 | # *func                   -1 xntimer_do_stop_aperiodic+0xe [xeno_nucleus]
(xnpod_delete_thread+0x2a1 [xeno_nucleus])
 | # *func                   -2 xnpod_delete_thread+0xe [xeno_nucleus]
(rt_task_delete+0x140 [xeno_native])
 | # *func                   -2 __ipipe_schedule_irq+0xe
(rthal_apc_schedule+0x83)
 | # *func                   -3 rthal_apc_schedule+0xa
(schedule_linux_call+0x98 [xeno_nucleus])
 | # *func                   -3 schedule_linux_call+0xe [xeno_nucleus]
(xnshadow_send_sig+0x20 [xeno_nucleus])
 | # *func                   -3 xnshadow_send_sig+0x9 [xeno_nucleus]
(rt_task_delete+0x138 [xeno_native])
 | # *func                   -3 __native_task_safewait+0xb [xeno_native]
(rt_task_delete+0xd1 [xeno_native])
 | + *begin   0x80000000     -3 rt_task_delete+0xc8 [xeno_native]
(__rt_task_delete+0x58 [xeno_native])
   + *func                   -4 rt_task_delete+0xe [xeno_native]
(__rt_task_delete+0x58 [xeno_native])
 | + *end     0x80000000     -4 __ipipe_restore_pipelineno_nucleus])
 | # *func                   -4 __ipipe_restore_pipeline_head+0xd
(xnregistry_fetch+0x5f [xeno_nucleus])
 | + *begin   0x80000000     -4 xnregistry_fetch+0x83 [xeno_nucleus]
(__rt_task_delete+0x4a [xeno_native])
   + *func                   -4 xnregistry_fetch+0x9 [xeno_nucleus]
(__rt_task_delete+0x4a [xeno_native])
   + *func                   -5 __copy_from_user_ll_nozero+0xa
(__rt_task_delete+0             -5 __rt_task_delete+0xc [xeno_native]
(hisyscall_event+0x185 [xeno_nucleus])
   + *func                   -5 hisyscall_event+0xe [xeno_nucleus]
(__ipipe_dispatch_event+0xc0)
 | + *end     0x80000001     -5 __ipipe_dispatch_event+0x1a2
(__ipipe_syscall_root+0x43)
 | + *begin   0x80000001     -5 __ipipe_dispatch_event+0x1b2
(__ipipe_syscall_root+0x43)
   + *func                   -6 __ipipe_dispatch_event+0xe
(__ipipe_syscall_root+0x43)
   + *func                   -6 __ipipe_syscall_root+0xa (system_call+0x29)
 | + *end     0x80000001    -18 __ipipe_dispatch_event+0x169
(__ipipe_syscall_root+0x43)
 | + *begin   0x80000001    -18 __ipipe_dispatch_event+0x193
(__ipipe_syscall_root+0x43)
 | + *end     0x80000000    -18 __ipipe_restore_pipeline_head+0x6d
(rt_sem_p+0x61 [xeno_native])
 | # *func                  -18 __ipipe_restore_pipeline_head+0xd
(rt_sem_p+0x61 [xeno_native])
BUG: unable to handle kernel NULL pointer dereference at virtual address
00000004
 printing eip:
f8bfc99c
*pde = 00000000
Oops: 0002 [#1]
PREEMPT
Modules linked in: xeno_native xeno_nucleus nfs lockd nfs_acl sunrpc ipv6 lp
parport usbkbd usbmouse usbhid e100 mii evdev psmouse ehci_hcd uhci_hcd
usbcore pcspkr
CPU:    0
EIP:    0060:[<f8bfc99c>]    Not tainted VLI
EFLAGS: 00010046   (2.6.20.14-ipipe-1.8-05 #1)
EIP is at rt_task_create+0x192/0x24b [xeno_native]
eax: f60a1724   ebx: f60a1d20   ecx: 00000001   edx: 00000000
esi: 00000000   edi: f60a1d24   ebp: f1aa7ee4   esp: f1aa7eb4
ds: 007b   es: 007b   ss: 0068
Process TimerThreadInst (pid: 2732, ti=f1aa6000 task=f7ce61b0
task.ti=f1aa6000)
Stack: 00300000 00000000 00000600 f60a1d20 00000000 f60a1d30 f1aa7f08
00000000
       00000000 00300000 fffffff4 f60a1d20 f1aa7f50 f8bff1e3 0000000f
00300000
       f1aa7fb8 08098654 0000000f bf9effd0 c01e2a96 656d6954 72685472
49646165
Call Trace:
 [<c0103ffb>] show_trace_log_lvl+0x1f/0x35
 [<c01040bb>] show_stack_log_lvl+0xaa/0xcf
 [<c01042aa>] show_registers+0x1ca/0x392
 [<c0104588>] die+0x116/0x246
 [<c011143a>] do_page_fault+0x287/0x61d
 [<c010ee95>] __ipipe_handle_exception+0x63/0x136
 [<c028f83d>] error_code+0x79/0x88
 [<f8bff1e3>] __rt_task_create+0xd5/0x16c [xeno_native]
 [<f8bd7f22>] losyscall_event+0xaf/0x16d [xeno_nucleus]
 [<c0138940>] __ipipe_dispatch_event+0xc0/0x1da
 [<c010ed6b>] __ipipe_syscall_root+0x43/0x10a
 [<c0102e79>] system_call+0x29/0x41
 =======================
Code: 00 00 00 a1 04 f6 2f c0 2d 80 99 00 00 0f ba 28 00 19 d2 89 d6 83 e6
01 c7 03 01 01 55 55 a1 50 ae c0 f8 89 47 04 8b 10 89 53 04 <89> 7a 04 89 38
83 05 54 ae c0 f8 01 8b 0d 04 f6 2f c0 81 e9 80
EIP: [<f8bfc99c>] rt_task_create+0x192/0x24b [xeno_native] SS:ESP
0068:f1aa7eb4
 ?

We have pinpointed the release of Xenomai from where on this problem
started, this is R2433. From this release on, orocos make check fails.
Before this release, orocos make check succeeds.
We use linux kernel 2.6.20.9 with ipipe 1.8-00 and Xenomai 2.3.x. These are
the changes according to the log files:

------------------------------------------------------------------------
r2433 | rpm | 2007-05-11 10:45:43 +0200 (Fri, 11 May 2007) | 1 line

Defer thread memory release
------------------------------------------------------------------------


2007-05-11  Philippe Gerum  <rpm@xenomai.org>

    * include/nucleus/heap.h (xnfreesafe): Use xnpod_current_p() when
    checking for deferral.

    * include/nucleus/pod.h (xnpod_current_p): Give exec mode
    awareness to this predicate, checking for primary/secondary mode
    of shadows.

2007-05-11  Gilles Chanteperdrix  <gilles.chanteperdrix@xenomai.org>

    * ksrc/skins: Always defer thread memory release in deletion hook
    by calling xnheap_schedule_free() instead of xnfreesafe().


Orocos uses the native skin, so my guess is that these changes shouldn't
impact the working of orocos.
Did orocos use something that it shouldn't had or does orocos use something
else that has changed between r2429 and r2433?

thanks in advance, andy

------=_Part_43682_26937847.1188221245748
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

<div><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;"><div><span class="q"></span><br><div>I will run continuously several tests on the pc (including &quot;latency -f&quot;) for the rest of this week. Since I am not in the office during this period&nbsp; (so not in the neighborhood of this problematic pc).
<br>And I hope (I hope not in vain) that the latency tracer will give us a hint for the reason of the hard lock ups (if a hard lock up happens during this period). <br></div><br></div><span class="sg">andy<br>
</span></blockquote></div><br><br>Hello, <br><br>Since&nbsp; we are having a hard time finding the hard lock-ups. We have taken a closer look at the failed tests of orocos (maybe the source of the problem is the same). These failures occur during the make check execution. 
<br>&nbsp;&nbsp; &nbsp;<br>&nbsp;&nbsp; &nbsp;The following tests FAILED:<br>&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;2 - task-test (OTHER-FAULT)<br>&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;3 - event-test (OTHER-FAULT)<br>&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;4 - taskcontext-test (OTHER-FAULT)<br><br>When we perform a single test, e.g task-test, we get the the following messages: Killed
<br>The OROCOS messages are then:<br><br>0.000 [ Info&nbsp;&nbsp; ][Logger] Successfully extracted environment variable ORO_LOGLEVEL<br>0.001 [ Info&nbsp;&nbsp; ][Logger]&nbsp; OROCOS version &#39;1.2.1&#39; compiled with GCC 4.1.2.Orocos Logging Activated at level : [ Debug&nbsp; ] ( 6 ) 
<br>0.001 [ Info&nbsp;&nbsp; ][Logger] Reference System Time is : 880886725351 ticks ( 315.369 seconds ).<br>0.002 [ Info&nbsp;&nbsp; ][Logger] Logging is relative to this time.<br>0.002 [ Info&nbsp;&nbsp; ][Logger] Xenomai Periodic Timer runs in preemptive &#39;one-shot&#39; mode.
<br>0.003 [ Debug&nbsp; ][Logger] Xenomai Timer and Main Task Created<br>0.003 [ Debug&nbsp; ][Logger] MainThread started.<br>0.003 [ Debug&nbsp; ][Logger] Starting StartStopManager.<br>0.004 [ Info&nbsp;&nbsp; ][Toolkit] Loading Tool RealTime.<br>
0.005 [ Debug&nbsp; ][Toolkit] Registered Type &#39;int&#39; to the Orocos Type System.<br>0.005 [ Debug&nbsp; ][Toolkit] Registered Type &#39;uint&#39; to the Orocos Type System.<br>0.006 [ Debug&nbsp; ][Toolkit] Registered Type &#39;double&#39; to the Orocos Type System.
<br>0.006 [ Debug&nbsp; ][Toolkit] Registered Type &#39;bool&#39; to the Orocos Type System.<br>0.006 [ Debug&nbsp; ][Toolkit] Registered Type &#39;PropertyBag&#39; to the Orocos Type System.<br>0.007 [ Debug&nbsp; ][Toolkit] Registered Type &#39;float&#39; to the Orocos Type System.
<br>0.007 [ Debug&nbsp; ][Toolkit] Registered Type &#39;char&#39; to the Orocos Type System.<br>0.008 [ Debug&nbsp; ][Toolkit] Registered Type &#39;array&#39; to the Orocos Type System.<br>0.008 [ Debug&nbsp; ][Toolkit] Registered Type &#39;string&#39; to the Orocos Type System.
<br>0.010 [ Debug&nbsp; ][./task-test::main()] ORO_main starting...<br>0.010 [ Info&nbsp;&nbsp; ][./task-test::main()] LogLevel unaltered by test-runner.<br>0.011 [ Info&nbsp;&nbsp; ][./task-test::main()] Creating PeriodicThread for scheduler: 0<br>
0.012 [ Info&nbsp;&nbsp; ][TimerThreadInstance] PeriodicThread created with scheduler type &#39;0&#39;, priority 15 and period 0.01.<br>0.013 [ Debug&nbsp; ][Logger] Periodic Thread TimerThreadInstance started.<br>0.014 [ Info&nbsp;&nbsp; ][PThread] PeriodicThread created with scheduler type &#39;0&#39;, priority 99 and period 
0.1.<br>0.014 [ Debug&nbsp; ][Logger] Periodic Thread PThread started.<br>0.115 [ Debug&nbsp; ][Logger] Periodic Thread PThread stopping... done.<br>0.115 [ Debug&nbsp; ][Logger] Periodic Thread PThread started.<br>1.216 [ Debug&nbsp; ][Logger] Periodic Thread PThread stopping... done.
<br>1.216 [ Debug&nbsp; ][~PeriodicThread] Terminating PThread<br><br>On the serial console we get the following listing (complete listing in appendix):<br><br>Xenomai: starting native API services.<br>I-pipe: Detected illicit call from domain &#39;Xenomai&#39;
<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; into a service reserved for domain &#39;Linux&#39; and below.<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; f635be74 00000000 00000000 52544149 f635be98 c0104789 c02cfa4f c02f5b80 <br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; f6c4e2f0 f635beb0 c0137d69 c02c256c c02c1186 c02c01b8 f8c0b280 f635bebc 
<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; c0132981 f60a1730 f635bed8 f8bd8570 c010ef8c 00000000 f60a0120 f8beefe0 <br>Call Trace:<br>&nbsp;[&lt;c0103ffb&gt;] show_trace_log_lvl+0x1f/0x35<br>&nbsp;[&lt;c01040bb&gt;] show_stack_log_lvl+0xaa/0xcf<br>&nbsp;[&lt;c0104789&gt;] show_stack+0x2f/0x36
<br>&nbsp;[&lt;c0137d69&gt;] ipipe_check_context+0x7a/0x81<br>&nbsp;[&lt;c0132981&gt;] module_put+0x19/0x7d<br>&nbsp;[&lt;f8bd8570&gt;] xnshadow_unmap+0xbc/0xff [xeno_nucleus]<br>&nbsp;[&lt;f8bfdc75&gt;] __shadow_delete_hook+0x25/0x27 [xeno_native]
<br>&nbsp;[&lt;f8bd1454&gt;] xnpod_delete_thread+0x1b9/0x2aa [xeno_nucleus]<br>&nbsp;[&lt;f8bfc36b&gt;] rt_task_delete+0x140/0x145 [xeno_native]<br>&nbsp;[&lt;f8bfe02a&gt;] __rt_task_delete+0x58/0x69 [xeno_native]<br>&nbsp;[&lt;f8bd8165&gt;] hisyscall_event+0x185/0x291 [xeno_nucleus]
<br>&nbsp;[&lt;c0138940&gt;] __ipipe_dispatch_event+0xc0/0x1da<br>&nbsp;[&lt;c010ed6b&gt;] __ipipe_syscall_root+0x43/0x10a<br>&nbsp;[&lt;c0102e79&gt;] system_call+0x29/0x41<br>&nbsp;=======================<br>I-pipe tracer log (30 points):<br>
&nbsp;| # *func&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0 ipipe_trace_panic_freeze+0x9 (ipipe_check_context+0x3f)<br>&nbsp;| # *func&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0 ipipe_check_context+0xc (module_put+0x19)<br>&nbsp;| # *func&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0 module_put+0x9 (xnshadow_unmap+0xbc [xeno_nucleus])
<br>&nbsp;| # *func&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0 xnshadow_unmap+0xe [xeno_nucleus] (__shadow_delete_hook+0x25 [xeno_native])<br>&nbsp;| # *func&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -1 __shadow_delete_hook+0x8 [xeno_native] (xnpod_delete_thread+0x1b9 [xeno_nucleus])
<br>&nbsp;| # *func&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -1 xnsynch_release_all_ownerships+0xe [xeno_nucleus] (xnpod_delete_thread+0x157 [xeno_nucleus])<br>&nbsp;| # *func&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -1 xntimer_do_stop_aperiodic+0xe [xeno_nucleus] (xnpod_delete_thread+0x2a1 [xeno_nucleus])
<br>&nbsp;| # *func&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -2 xnpod_delete_thread+0xe [xeno_nucleus] (rt_task_delete+0x140 [xeno_native])<br>&nbsp;| # *func&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -2 __ipipe_schedule_irq+0xe (rthal_apc_schedule+0x83)<br>&nbsp;| # *func&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -3 rthal_apc_schedule+0xa (schedule_linux_call+0x98 [xeno_nucleus])
<br>&nbsp;| # *func&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -3 schedule_linux_call+0xe [xeno_nucleus] (xnshadow_send_sig+0x20 [xeno_nucleus])<br>&nbsp;| # *func&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -3 xnshadow_send_sig+0x9 [xeno_nucleus] (rt_task_delete+0x138 [xeno_native])
<br>&nbsp;| # *func&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -3 __native_task_safewait+0xb [xeno_native] (rt_task_delete+0xd1 [xeno_native])<br>&nbsp;| + *begin&nbsp;&nbsp; 0x80000000&nbsp;&nbsp;&nbsp;&nbsp; -3 rt_task_delete+0xc8 [xeno_native] (__rt_task_delete+0x58 [xeno_native])<br>
&nbsp;&nbsp; + *func&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -4 rt_task_delete+0xe [xeno_native] (__rt_task_delete+0x58 [xeno_native])<br>&nbsp;| + *end&nbsp;&nbsp;&nbsp;&nbsp; 0x80000000&nbsp;&nbsp;&nbsp;&nbsp; -4 __ipipe_restore_pipelineno_nucleus])<br>&nbsp;| # *func&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -4 __ipipe_restore_pipeline_head+0xd (xnregistry_fetch+0x5f [xeno_nucleus])
<br>&nbsp;| + *begin&nbsp;&nbsp; 0x80000000&nbsp;&nbsp;&nbsp;&nbsp; -4 xnregistry_fetch+0x83 [xeno_nucleus] (__rt_task_delete+0x4a [xeno_native])<br>&nbsp;&nbsp; + *func&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -4 xnregistry_fetch+0x9 [xeno_nucleus] (__rt_task_delete+0x4a [xeno_native])<br>
&nbsp;&nbsp; + *func&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -5 __copy_from_user_ll_nozero+0xa (__rt_task_delete+0&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -5 __rt_task_delete+0xc [xeno_native] (hisyscall_event+0x185 [xeno_nucleus])<br>&nbsp;&nbsp; + *func&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -5 hisyscall_event+0xe [xeno_nucleus] (__ipipe_dispatch_event+0xc0)
<br>&nbsp;| + *end&nbsp;&nbsp;&nbsp;&nbsp; 0x80000001&nbsp;&nbsp;&nbsp;&nbsp; -5 __ipipe_dispatch_event+0x1a2 (__ipipe_syscall_root+0x43)<br>&nbsp;| + *begin&nbsp;&nbsp; 0x80000001&nbsp;&nbsp;&nbsp;&nbsp; -5 __ipipe_dispatch_event+0x1b2 (__ipipe_syscall_root+0x43)<br>&nbsp;&nbsp; + *func&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -6 __ipipe_dispatch_event+0xe (__ipipe_syscall_root+0x43)
<br>&nbsp;&nbsp; + *func&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -6 __ipipe_syscall_root+0xa (system_call+0x29)<br>&nbsp;| + *end&nbsp;&nbsp;&nbsp;&nbsp; 0x80000001&nbsp;&nbsp;&nbsp; -18 __ipipe_dispatch_event+0x169 (__ipipe_syscall_root+0x43)<br>&nbsp;| + *begin&nbsp;&nbsp; 0x80000001&nbsp;&nbsp;&nbsp; -18 __ipipe_dispatch_event+0x193 (__ipipe_syscall_root+0x43)
<br>&nbsp;| + *end&nbsp;&nbsp;&nbsp;&nbsp; 0x80000000&nbsp;&nbsp;&nbsp; -18 __ipipe_restore_pipeline_head+0x6d (rt_sem_p+0x61 [xeno_native])<br>&nbsp;| # *func&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -18 __ipipe_restore_pipeline_head+0xd (rt_sem_p+0x61 [xeno_native])<br>BUG: unable to handle kernel NULL pointer dereference at virtual address 00000004
<br>&nbsp;printing eip:<br>f8bfc99c<br>*pde = 00000000<br>Oops: 0002 [#1]<br>PREEMPT <br>Modules linked in: xeno_native xeno_nucleus nfs lockd nfs_acl sunrpc ipv6 lp parport usbkbd usbmouse usbhid e100 mii evdev psmouse ehci_hcd uhci_hcd usbcore pcspkr
<br>CPU:&nbsp;&nbsp;&nbsp; 0<br>EIP:&nbsp;&nbsp;&nbsp; 0060:[&lt;f8bfc99c&gt;]&nbsp;&nbsp;&nbsp; Not tainted VLI<br>EFLAGS: 00010046&nbsp;&nbsp; (2.6.20.14-ipipe-1.8-05 #1)<br>EIP is at rt_task_create+0x192/0x24b [xeno_native]<br>eax: f60a1724&nbsp;&nbsp; ebx: f60a1d20&nbsp;&nbsp; ecx: 00000001&nbsp;&nbsp; edx: 00000000
<br>esi: 00000000&nbsp;&nbsp; edi: f60a1d24&nbsp;&nbsp; ebp: f1aa7ee4&nbsp;&nbsp; esp: f1aa7eb4<br>ds: 007b&nbsp;&nbsp; es: 007b&nbsp;&nbsp; ss: 0068<br>Process TimerThreadInst (pid: 2732, ti=f1aa6000 task=f7ce61b0 task.ti=f1aa6000)<br>Stack: 00300000 00000000 00000600 f60a1d20 00000000 f60a1d30 f1aa7f08 00000000 
<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 00000000 00300000 fffffff4 f60a1d20 f1aa7f50 f8bff1e3 0000000f 00300000 <br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; f1aa7fb8 08098654 0000000f bf9effd0 c01e2a96 656d6954 72685472 49646165 <br>Call Trace:<br>&nbsp;[&lt;c0103ffb&gt;] show_trace_log_lvl+0x1f/0x35
<br>&nbsp;[&lt;c01040bb&gt;] show_stack_log_lvl+0xaa/0xcf<br>&nbsp;[&lt;c01042aa&gt;] show_registers+0x1ca/0x392<br>&nbsp;[&lt;c0104588&gt;] die+0x116/0x246<br>&nbsp;[&lt;c011143a&gt;] do_page_fault+0x287/0x61d<br>&nbsp;[&lt;c010ee95&gt;] __ipipe_handle_exception+0x63/0x136
<br>&nbsp;[&lt;c028f83d&gt;] error_code+0x79/0x88<br>&nbsp;[&lt;f8bff1e3&gt;] __rt_task_create+0xd5/0x16c [xeno_native]<br>&nbsp;[&lt;f8bd7f22&gt;] losyscall_event+0xaf/0x16d [xeno_nucleus]<br>&nbsp;[&lt;c0138940&gt;] __ipipe_dispatch_event+0xc0/0x1da
<br>&nbsp;[&lt;c010ed6b&gt;] __ipipe_syscall_root+0x43/0x10a<br>&nbsp;[&lt;c0102e79&gt;] system_call+0x29/0x41<br>&nbsp;=======================<br>Code: 00 00 00 a1 04 f6 2f c0 2d 80 99 00 00 0f ba 28 00 19 d2 89 d6 83 e6 01 c7 03 01 01 55 55 a1 50 ae c0 f8 89 47 04 8b 10 89 53 04 &lt;89&gt; 7a 04 89 38 83 05 54 ae c0 f8 01 8b 0d 04 f6 2f c0 81 e9 80 
<br>EIP: [&lt;f8bfc99c&gt;] rt_task_create+0x192/0x24b [xeno_native] SS:ESP 0068:f1aa7eb4<br>&nbsp;?<br><br>We have pinpointed the release of Xenomai from where on this problem started, this is R2433. From this release on, orocos make check fails. Before this release, orocos make check succeeds.
<br>We use linux kernel <a href="http://2.6.20.9">2.6.20.9</a> with ipipe 1.8-00 and Xenomai 2.3.x. These are the changes according to the log files:<br><br>------------------------------------------------------------------------
<br>r2433 | rpm | 2007-05-11 10:45:43 +0200 (Fri, 11 May 2007) | 1 line<br><br>Defer thread memory release<br>------------------------------------------------------------------------<br><br><br>2007-05-11&nbsp; Philippe Gerum&nbsp; &lt;
<a href="mailto:rpm@xenomai.org">rpm@xenomai.org</a>&gt;<br><br>&nbsp;&nbsp; &nbsp;* include/nucleus/heap.h (xnfreesafe): Use xnpod_current_p() when<br>&nbsp;&nbsp; &nbsp;checking for deferral.<br><br>&nbsp;&nbsp; &nbsp;* include/nucleus/pod.h (xnpod_current_p): Give exec mode
<br>&nbsp;&nbsp; &nbsp;awareness to this predicate, checking for primary/secondary mode<br>&nbsp;&nbsp; &nbsp;of shadows.<br><br>2007-05-11&nbsp; Gilles Chanteperdrix&nbsp; &lt;<a href="mailto:gilles.chanteperdrix@xenomai.org">gilles.chanteperdrix@xenomai.org</a>
&gt;<br><br>&nbsp;&nbsp; &nbsp;* ksrc/skins: Always defer thread memory release in deletion hook<br>&nbsp;&nbsp; &nbsp;by calling xnheap_schedule_free() instead of xnfreesafe().<br><br><br>Orocos uses the native skin, so my guess is that these changes shouldn&#39;t impact the working of orocos. 
<br>Did orocos use something that it shouldn&#39;t had or does orocos use something else that has changed between r2429 and r2433?<br><br>thanks in advance, andy<br>&nbsp;<br><br>&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp; <br>

------=_Part_43682_26937847.1188221245748--

------=_Part_43681_16250756.1188221245748
Content-Type: application/zip; name=linux-2.6.20.14-ipipe-1.8-05.zip
Content-Transfer-Encoding: base64
X-Attachment-Id: f_f5uzxezt
Content-Disposition: attachment; filename="linux-2.6.20.14-ipipe-1.8-05.zip"

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
------=_Part_43681_16250756.1188221245748--

