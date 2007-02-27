From: Jeff Weber <jweber@domain.hid>
Date: Tue, 27 Feb 2007 12:14:01 -0600
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200702271214.01911.jweber@domain.hid>
Subject: [Xenomai-help] task not being scheduled
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Xenomai Help <xenomai@xenomai.org>

I have system where a 100Hz periodic task is occasionally over running it's
periodic task wakeup by 10s of msec.  To debug the problem, I froze an ipipe
verbose trace upon an -ETIMEDOUT error return from rt_task_wait_period().
A filtered output of the trace appears below.  This trace includes every
occurence of the task, which is pid 7380.

:|  # [ 7380] -<?>-   35 -25252+   5.587  xnpod_resume_thread+0x59 [xeno_nucleus ] (xnthread_periodic_handler+0x31 [xeno_nucleus])
:|  # [ 7380] -<?>-   35 -24820+   4.214  xnpod_schedule+0x6c0 [xeno_nucleus] (x npod_suspend_thread+0x118 [xeno_nucleus])
:|  # [ 7380] -<?>-   35 -24734+   1.501  xnpod_schedule+0x97 [xeno_nucleus] (xn intr_irq_handler+0x9a [xeno_nucleus])
:|  # [ 7380] -<?>-   35 -24589+   1.218  xnpod_schedule+0x6c0 [xeno_nucleus] (x nintr_irq_handler+0x9a [xeno_nucleus])
:   + func               -24587    0.493  __rt_task_wait_period+0x11 [xeno_native] (hisyscall_event+0x162 [xeno_nucleus])
:   + func               -24586    0.485  rt_task_wait_period+0xb [xeno_native] (__rt_task_wait_period+0x3f [xeno_native])
:   + func               -24586    0.464  xnpod_wait_thread_period+0xe [xeno_nucleus] (rt_task_wait_period+0x4b [xeno_native])
:|  + begin   0x80000001 -24586    0.718  xnpod_wait_thread_period+0x1ed [xeno_nucleus] (rt_task_wait_period+0x4b [xeno_native])
:|  # func               -24585    0.621  xnpod_suspend_thread+0xe [xeno_nucleus] (xnpod_wait_thread_period+0x91 [xeno_nucleus])
:|  # func               -24584    0.558  xnpod_schedule+0xe [xeno_nucleus] (xnpod_suspend_thread+0x118 [xeno_nucleus])
:|  # [ 7380] -<?>-   35 -24584    0.847  xnpod_schedule+0x97 [xeno_nucleus] (xn pod_suspend_thread+0x118 [xeno_nucleus])
:|  # [    0] -<?>-   -1 -10630    0.916  xnpod_schedule+0x6c0 [xeno_nucleus] (xnintr_irq_handler+0x9a [xeno_nucleus])
:|  # [    0] -<?>-   -1 -4632    0.886  xnpod_schedule+0x6c0 [xeno_nucleus] (xnintr_irq_handler+0x9a [xeno_nucleus])
:|  # [ 7380] -<?>-   35  -609+   1.747  xnpod_resume_thread+0x59 [xeno_nucleus] (xnthread_periodic_handler+0x31 [xeno_nucleus])
:|  # [ 7380] -<?>-   35  -186+   4.288  xnpod_schedule+0x6c0 [xeno_nucleus] (xn pod_suspend_thread+0x118 [xeno_nucleus])
:|  # [ 7380] -<?>-   35  -143+   1.554  xnpod_schedule+0x97 [xeno_nucleus] (xni ntr_irq_handler+0x9a [xeno_nucleus])
:|  # [ 7380] -<?>-   35    -6+   1.211  xnpod_schedule+0x6c0 [xeno_nucleus] (xn intr_irq_handler+0x9a [xeno_nucleus])
<   + freeze  0x00000007     0    0.929  xnshadow_sys_trace+0x8b [xeno_nucleus] (hisyscall_event+0x162 [xeno_nucleus])


At time -24587 usec, the task calls rt_task_wait_period(), presumable to
sleep for approx 10msec.  So, I would expect to see the task resumed at
approx clock -14587.  However, the task is not resumed until clock -609,
and not run until time -186.  So, the task wasn't sheduled for over 14msec.
During this time, the ROOT task, presumably pid=0 priority=-1,  ran  61
times.  I included a 2 samples of this in the above trace.
Thus a worse priority task ran many times, when my better priority
task was not being scheduled.

I am new to interpreting ipipe traces, and may be overlooking some of the details.
I would appreciate help understanding this problem, and how to fix it.

config:
arch = x86
Linux 2.6.17.14
Xenomai-2.2.4
ipipe 1.5-00


TIA,
	Jeff

