Content-class: urn:content-classes:message
MIME-Version: 1.0
Date: Tue, 27 Nov 2007 13:44:53 -0500
Message-ID: <BF58A8AFB316514587D61EADBFBF4C410165FCFD@Alpha1>
From: "Kyle Howell" <khowell@domain.hid>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Subject: [Xenomai-help] Interrupts lost during sleep / unblock cycles
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai@xenomai.org

I have been debugging a stall problem for a couple of days, and I think
I've put together enough info to check with the pros. Everything below
was experienced on a P4 (Celeron) running 2.6.20 / Xenomai 2.3.4. I've
also reproduced it on 2.6.19.7 / 2.3.1. A quick test *did not* reproduce
this problem on a Core2 running x86_64 2.6.22.9 / 2.4RC3.=20

I've reduced the problem to a fairly simple example below:

The Overview:
- Running a single real-time process with one standard thread and one RT
task
- The RT task loops on a 1sec rt_task_sleep
- The standard thread loops on nanosleep(10msec) and rt_task_unblock of
the RT task.
- When an unrelated interrupt arrives at the wrong time, the entire
system will hang until the 1sec task_sleep expires.
- After resuming, everything runs normally until another interrupt lands
at the wrong moment.

Here's the source code to the simple program:
/////////////////// Start taskTest.c ////////////////////=20
#include <stdio.h>
#include <time.h>
#include <sys/time.h>
#include <sys/mman.h>
#include <native/types.h>
#include <native/task.h>
#include <native/timer.h>
#include <nucleus/trace.h>
=20
typedef unsigned long long UINT64;
RT_TASK rtTask;
char rtName[16] =3D "RtThread";
=20
#define MAX_DELAY (50000)
=20
void RtThread(void *arg);
=20
int main ( int argc, char *argv[])
{
  int result;
  struct timespec req;
  struct timeval tv;
  UINT64 oldTime, newTime, diffTime; // Times in microseconds
=20
  mlockall(MCL_CURRENT | MCL_FUTURE);
=20
  result =3D rt_task_create(&rtTask, rtName, 0, 10, 0);
  result =3D rt_task_start(&rtTask, RtThread, NULL);
=20
  req.tv_sec =3D 0;
  req.tv_nsec =3D 10000000; // 10 msec
=20
  gettimeofday(&tv, NULL);
  oldTime =3D ((UINT64)tv.tv_sec * 1000000) + tv.tv_usec;
=20
  while(1)
  {
    xntrace_special(1,1);
    rt_task_unblock(&rtTask);
=20
    /* Try to sleep for 10msec */
    nanosleep(&req, NULL);
    xntrace_special(2,2);
=20
    /* Check how much time has really passed */
    gettimeofday(&tv, NULL);
    newTime =3D ((UINT64)tv.tv_sec * 1000000) + tv.tv_usec;
    diffTime =3D newTime - oldTime;
    if(diffTime > MAX_DELAY)
    {
      printf("%llu - Diff time too large - %llu\n",newTime/1000000,
diffTime);
    }
=20
    // Do it again
    oldTime =3D newTime;
  }
=20
}
=20
void RtThread(void *arg)
{
  RTIME startTsc, endTsc;
  printf("RtThread alive!\n");
=20
  // Nothing but 1sec sleeps
  while(1)
  {
    startTsc =3D rt_timer_tsc();
    xntrace_special(4,4);
    rt_task_sleep(1000000000LL);
    xntrace_special(8,8);
    endTsc =3D rt_timer_tsc();
    // Capture this event
    if(rt_timer_tsc2ns(endTsc - startTsc) > 100000000)
      xntrace_user_freeze(endTsc - startTsc, 0);
  }
=20
  printf("RtThread quitting!\n");
}
/////////////////// End taskTest.c ////////////////////=20

This program produces output like the following:
# ./taskTest
RtThread alive!
1042677082 - Diff time too large - 1000308
1042677120 - Diff time too large - 1000631
1042677129 - Diff time too large - 1000406
1042677133 - Diff time too large - 1000395
etc...

Those are *one second* delays for the 10msec nanosleep to return.

Here's a capture from the I-Pipe tracer (note the user trace-points):
:    +func               -999696    0.157  __ipipe_syscall_root+0xa
(system_call+0x29)
:    +func               -999696    0.169  __ipipe_dispatch_event+0xe
(__ipipe_syscall_root+0x44)
:|   +begin   0x80000001 -999695    0.172  __ipipe_dispatch_event+0x19a
(__ipipe_syscall_root+0x44)
:| +  end     0x80000001 -999695    0.195  __ipipe_dispatch_event+0x18a
(__ipipe_syscall_root+0x44)
:  +  func               -999695    0.154  hisyscall_event+0xe
(__ipipe_dispatch_event+0xb5)
:  +  func               -999695    0.139  xnshadow_sys_trace+0xb
(hisyscall_event+0x185)
:  +  (0x01)  0x00000001 -999695    0.172  xnshadow_sys_trace+0x69
(hisyscall_event+0x185)
:| +  begin   0x80000001 -999695    0.169  __ipipe_dispatch_event+0x17b
(__ipipe_syscall_root+0x44)
:|   +end     0x80000001 -999694    0.206  __ipipe_dispatch_event+0x14f
(__ipipe_syscall_root+0x44)
:|   +begin   0x80000001 -999694    0.161  __ipipe_syscall_root+0xeb
(system_call+0x29)
:|   +end     0x80000001 -999694    0.214  __ipipe_syscall_root+0xf7
(system_call+0x29)
:    #func               -999694    0.169  __ipipe_unstall_iret_root+0x9
(restore_nocheck_notrace+0x0)
:|   #begin   0x80000000 -999694    0.172
__ipipe_unstall_iret_root+0x7c (restore_nocheck_notrace+0x0)
:|   +end     0x8000000d -999693    0.713
__ipipe_unstall_iret_root+0x2c (restore_nocheck_notrace+0x0)
:    +func               -999693    0.154  __ipipe_syscall_root+0xa
(system_call+0x29)
:    +func               -999693    0.165  __ipipe_dispatch_event+0xe
(__ipipe_syscall_root+0x44)
:|   +begin   0x80000001 -999692    0.169  __ipipe_dispatch_event+0x19a
(__ipipe_syscall_root+0x44)
:| +  end     0x80000001 -999692    0.195  __ipipe_dispatch_event+0x18a
(__ipipe_syscall_root+0x44)
:  +  func               -999692    0.210  hisyscall_event+0xe
(__ipipe_dispatch_event+0xb5)
:  +  func               -999692    0.184  __rt_task_unblock+0xc
(hisyscall_event+0x185)
:  +  func               -999692    0.221
__copy_from_user_ll_nozero+0xa (__rt_task_unblock+0x3e)
:  +  func               -999691    0.184  xnregistry_fetch+0x9
(__rt_task_unblock+0x46)
:| +  begin   0x80000000 -999691    0.229  xnregistry_fetch+0x80
(__rt_task_unblock+0x46)
:| #  func               -999691    0.210
__ipipe_restore_pipeline_head+0xa (xnregistry_fetch+0x5f)
:| +  end     0x80000000 -999691    0.191
__ipipe_restore_pipeline_head+0x4c (xnregistry_fetch+0x5f)
:  +  func               -999691    0.176  rt_task_unblock+0xa
(__rt_task_unblock+0x54)
:| +  begin   0x80000000 -999690    0.214  rt_task_unblock+0x68
(__rt_task_unblock+0x54)
:| #  func               -999690    0.184  xnpod_unblock_thread+0xb
(rt_task_unblock+0x72)
:| #  func               -999690    0.195  xnpod_resume_thread+0xe
(xnpod_unblock_thread+0x84)
:| #  [  868] RtThrea 10 -999690    0.187  xnpod_resume_thread+0x56
(xnpod_unblock_thread+0x84)
:| #  func               -999690    0.293  xntimer_do_stop_aperiodic+0xe
(xnpod_resume_thread+0x237)
:| #  func               -999689    0.180  xnpod_schedule+0xe
(rt_task_unblock+0x77)
:| #  [  867] taskTes -1 -999689    0.447  xnpod_schedule+0x90
(rt_task_unblock+0x77)
:| #  func               -999689    0.687  __switch_to+0xe
(xnpod_schedule+0x46e)
:| #  [  868] RtThrea 10 -999688    0.635  xnpod_schedule+0x546
(xnpod_suspend_thread+0x189)
:| #  func               -999687    0.229
__ipipe_restore_pipeline_head+0xa (xnpod_suspend_thread+0xa6)
:| +  end     0x80000000 -999687    0.469
__ipipe_restore_pipeline_head+0x4c (xnpod_suspend_thread+0xa6)
:| +  begin   0x80000001 -999687    0.274  __ipipe_dispatch_event+0x17b
(__ipipe_syscall_root+0x44)
:| +  end     0x80000001 -999686    0.943  __ipipe_dispatch_event+0x14f
(__ipipe_syscall_root+0x44)
**************** This ethernet interrupt appears to trigger the problem
*****************
:| +  begin   0xffffffee -999686    0.191  common_interrupt+0x29
(__ipipe_dispatch_event+0x151)
:| +  func               -999685    0.435  __ipipe_handle_irq+0xe
(common_interrupt+0x2e)
:| +  func               -999685    0.398  __ipipe_ack_irq+0x8
(__ipipe_handle_irq+0x149)
:| +  func               -999685    0.251  __ipipe_ack_fasteoi_irq+0x8
(__ipipe_ack_irq+0x19)
:| +  func               -999684    0.221  __ipipe_walk_pipeline+0xe
(__ipipe_handle_irq+0x7b)
:| +  end     0xffffffee -999684+   1.476  common_interrupt+0x38
(__ipipe_dispatch_event+0x151)
:  +  func               -999683    0.191  __ipipe_syscall_root+0xa
(system_call+0x29)
:  +  func               -999682    0.191  __ipipe_dispatch_event+0xe
(__ipipe_syscall_root+0x44)
:| +  begin   0x80000001 -999682    0.206  __ipipe_dispatch_event+0x19a
(__ipipe_syscall_root+0x44)
:| +  end     0x80000001 -999682    0.214  __ipipe_dispatch_event+0x18a
(__ipipe_syscall_root+0x44)
:  +  func               -999682    0.221  hisyscall_event+0xe
(__ipipe_dispatch_event+0xb5)
:  +  func               -999682    0.195  xnshadow_sys_trace+0xb
(hisyscall_event+0x185)
:  +  (0x08)  0x00000008 -999681    0.202  xnshadow_sys_trace+0x69
(hisyscall_event+0x185)
:| +  begin   0x80000001 -999681    0.199  __ipipe_dispatch_event+0x17b
(__ipipe_syscall_root+0x44)
:| +  end     0x80000001 -999681    0.931  __ipipe_dispatch_event+0x14f
(__ipipe_syscall_root+0x44)
:  +  func               -999680    0.150  __ipipe_syscall_root+0xa
(system_call+0x29)
:  +  func               -999680    0.165  __ipipe_dispatch_event+0xe
(__ipipe_syscall_root+0x44)
:| +  begin   0x80000001 -999680    0.169  __ipipe_dispatch_event+0x19a
(__ipipe_syscall_root+0x44)
:| +  end     0x80000001 -999680    0.184  __ipipe_dispatch_event+0x18a
(__ipipe_syscall_root+0x44)
:  +  func               -999679    0.187  hisyscall_event+0xe
(__ipipe_dispatch_event+0xb5)
:  +  func               -999679    0.150  xnshadow_sys_trace+0xb
(hisyscall_event+0x185)
:  +  (0x04)  0x00000004 -999679    0.176  xnshadow_sys_trace+0x69
(hisyscall_event+0x185)
:| +  begin   0x80000001 -999679    0.195  __ipipe_dispatch_event+0x17b
(__ipipe_syscall_root+0x44)
:| +  end     0x80000001 -999679    0.736  __ipipe_dispatch_event+0x14f
(__ipipe_syscall_root+0x44)
:  +  func               -999678    0.150  __ipipe_syscall_root+0xa
(system_call+0x29)
:  +  func               -999678    0.165  __ipipe_dispatch_event+0xe
(__ipipe_syscall_root+0x44)
:| +  begin   0x80000001 -999678    0.172  __ipipe_dispatch_event+0x19a
(__ipipe_syscall_root+0x44)
:| +  end     0x80000001 -999677    0.184  __ipipe_dispatch_event+0x18a
(__ipipe_syscall_root+0x44)
:  +  func               -999677    0.244  hisyscall_event+0xe
(__ipipe_dispatch_event+0xb5)
:  +  func               -999677    0.184  __rt_task_sleep+0xb
(hisyscall_event+0x185)
:  +  func               -999677    0.330
__copy_from_user_ll_nozero+0xa (__rt_task_sleep+0x1a)
:  +  func               -999676    0.195  rt_task_sleep+0xe
(__rt_task_sleep+0x25)
:  +  func               -999676    0.191  xnpod_suspend_thread+0xe
(rt_task_sleep+0x73)
:| +  begin   0x80000000 -999676    0.244  xnpod_suspend_thread+0x13f
(rt_task_sleep+0x73)
:| #  func               -999676    0.480
xntimer_do_start_aperiodic+0xe (xnpod_suspend_thread+0x173)
:| #  func               -999675    0.202  xnpod_schedule+0xe
(xnpod_suspend_thread+0x189)
:| #  [  868] RtThrea 10 -999675    0.417  xnpod_schedule+0x90
(xnpod_suspend_thread+0x189)
:| #  func               -999675    0.567  __switch_to+0xe
(xnpod_schedule+0x46e)
************** Hey! Shouldn't that stalled interrupt have been serviced
here? **************
:| #  [  867] taskTes -1 -999674    0.608  xnpod_schedule+0x546
(rt_task_unblock+0x77)
:| #  func               -999674    0.225
__ipipe_restore_pipeline_head+0xa (rt_task_unblock+0x57)
:| +  end     0x80000000 -999673    0.353
__ipipe_restore_pipeline_head+0x4c (rt_task_unblock+0x57)
:| +  begin   0x80000001 -999673    0.281  __ipipe_dispatch_event+0x17b
(__ipipe_syscall_root+0x44)
:|   +end     0x80000001 -999673    0.353  __ipipe_dispatch_event+0x14f
(__ipipe_syscall_root+0x44)
:|   +begin   0x80000001 -999672    0.199  __ipipe_syscall_root+0xeb
(system_call+0x29)
:|   +end     0x80000001 -999672    0.274  __ipipe_syscall_root+0xf7
(system_call+0x29)
:    #func               -999672    0.210  __ipipe_unstall_iret_root+0x9
(restore_nocheck_notrace+0x0)
:|   #begin   0x80000000 -999672    0.210
__ipipe_unstall_iret_root+0x7c (restore_nocheck_notrace+0x0)
:|   +end     0x8000000d -999671    0.969
__ipipe_unstall_iret_root+0x2c (restore_nocheck_notrace+0x0)
:    +func               -999670    0.293  __ipipe_syscall_root+0xa
(sysenter_past_esp+0x46)
:    +func               -999670    0.184  sys_nanosleep+0xc
(sysenter_past_esp+0x6e)
:    +func               -999670    0.176  copy_from_user+0xb
(sys_nanosleep+0x1e)
:    +func               -999670    0.326  __copy_from_user_ll+0xa
(copy_from_user+0x35)
:    +func               -999670    0.172  hrtimer_nanosleep+0xe
(sys_nanosleep+0x5c)
:    +func               -999669    0.225  hrtimer_init+0xb
(hrtimer_nanosleep+0x22)
:    +func               -999669    0.202  do_nanosleep+0xd
(hrtimer_nanosleep+0x41)
:    +func               -999669    0.210  hrtimer_init_sleeper+0x8
(do_nanosleep+0x1d)
:    +func               -999669    0.184  hrtimer_start+0xe
(do_nanosleep+0x4d)
:    #func               -999669    0.232  ktime_get+0xd
(hrtimer_start+0xbc)
:    #func               -999668    0.172  ktime_get_ts+0xa
(ktime_get+0x17)
:    #func               -999668    0.172  getnstimeofday+0xe
(ktime_get_ts+0x19)
:    #func               -999668    0.229  read_tsc+0x8
(getnstimeofday+0x34)
:    #func               -999668    0.214  set_normalized_timespec+0x8
(ktime_get_ts+0x40)
:    #func               -999667    0.229  enqueue_hrtimer+0xb
(hrtimer_start+0x67)
:    #func               -999667    0.202  rb_insert_color+0xe
(enqueue_hrtimer+0x56)
:    #func               -999667    0.202  __ipipe_restore_root+0x8
(hrtimer_start+0x6f)
:    #func               -999667    0.232  __ipipe_unstall_root+0x8
(__ipipe_restore_root+0x1b)
:|   #begin   0x80000000 -999667    0.266  __ipipe_unstall_root+0x41
(__ipipe_restore_root+0x1b)
:|   +end     0x80000000 -999666    0.263  __ipipe_unstall_root+0x33
(__ipipe_restore_root+0x1b)
:    +func               -999666    0.199  __sched_text_start+0xe
(do_nanosleep+0x52)
:    +func               -999666    0.417  sched_clock+0xa
(__sched_text_start+0x85)
:    #func               -999665    0.206  deactivate_task+0x9
(__sched_text_start+0x35c)
:    #func               -999665    0.319  dequeue_task+0xa
(deactivate_task+0x1e)
:|   #begin   0x80000000 -999665    0.232  __sched_text_start+0x414
(do_nanosleep+0x52)
:|   #func               -999665    0.300  __switch_to+0xe
(__sched_text_start+0x2e7)
:|   #end     0x80000000 -999664    0.202  __sched_text_start+0x403
(cpu_idle+0x64)
:    #func               -999664    0.217  __ipipe_unstall_root+0x8
(__sched_text_start+0x37b)
:|   #begin   0x80000000 -999664    0.180  __ipipe_unstall_root+0x41
(__sched_text_start+0x37b)
:|   +end     0x80000000 -999664    0.278  __ipipe_unstall_root+0x33
(__sched_text_start+0x37b)
:    +func               -999664    0.214  ipipe_suspend_domain+0xe
(cpu_idle+0x44)
:|   +begin   0x80000001 -999663    0.236  ipipe_suspend_domain+0x9d
(cpu_idle+0x44)
:|   +end     0x80000001 -999663    0.214  ipipe_suspend_domain+0xac
(cpu_idle+0x44)
:    +func               -999663    0.169  mwait_idle+0x8
(cpu_idle+0x46)
:    +func               -999663    0.165  __ipipe_unstall_root+0x8
(mwait_idle+0xd)
:|   +begin   0x80000000 -999663    0.225  __ipipe_unstall_root+0x41
(mwait_idle+0xd)
:|   +end     0x80000000 -999662    0.184  __ipipe_unstall_root+0x33
(mwait_idle+0xd)
:    +func               -999662! 999575.071  mwait_idle_with_hints+0xb
(mwait_idle+0x16)
************ WHOOPS! No Linux timer irqs, no ethernet irqs, no nothing
***************
:|   +begin   0xffffff16   -87    0.195  ipipe_ipi3+0x2e
(mwait_idle_with_hints+0x3e)
:|   +func                 -87    0.360  __ipipe_handle_irq+0xe
(ipipe_ipi3+0x33)
:|   +func                 -86    0.229  __ipipe_ack_apic+0x8
(__ipipe_handle_irq+0xa6)
:|   +func                 -86    0.526  __ipipe_dispatch_wired+0xb
(__ipipe_handle_irq+0x62)
:| #  func                 -86    0.364  xnintr_clock_handler+0x8
(__ipipe_dispatch_wired+0x85)
:| #  func                 -85    0.326  xnintr_irq_handler+0xe
(xnintr_clock_handler+0x17)
:| #  func                 -85    0.172  xnpod_announce_tick+0x8
(xnintr_irq_handler+0x3b)
:| #  func                 -85    0.661  xntimer_do_tick_aperiodic+0xe
(xnpod_announce_tick+0xf)
:|   +func                 -84    0.244  __ipipe_walk_pipeline+0xe
(__ipipe_handle_irq+0x7b)
:|  + func                 -84    0.187  ipipe_suspend_domain+0xe
(__ipipe_walk_pipeline+0xa0)
:|  + func                 -84    0.248  __ipipe_sync_stage+0xe
(ipipe_suspend_domain+0x63)
:|  # end     0x80000000   -84    0.244  __ipipe_sync_stage+0x13c
(ipipe_suspend_domain+0x63)
:   # func                 -83    0.184  shield_handler+0x8
(__ipipe_sync_stage+0xbf)
:   # func                 -83    0.199  __ipipe_schedule_irq+0xe
(shield_handler+0x19)
:|  # begin   0x80000001   -83    0.409  __ipipe_schedule_irq+0xdf
(shield_handler+0x19)
:|  # end     0x80000001   -82    0.251  __ipipe_schedule_irq+0x10f
(shield_handler+0x19)
:|  # begin   0x80000000   -82    0.319  __ipipe_sync_stage+0x130
(ipipe_suspend_domain+0x63)
:|   +func                 -82    0.206  __ipipe_sync_stage+0xe
(ipipe_suspend_domain+0x63)
:|   #end     0x80000000   -82    0.240  __ipipe_sync_stage+0x13c
(ipipe_suspend_domain+0x63)
*********** Ahh.. Now we're gonna take care of that old interrupt
***********
:    #func                 -81    0.221  do_IRQ+0xd
(__ipipe_sync_stage+0x16f)
:    #func                 -81    0.296  handle_fasteoi_irq+0xb
(do_IRQ+0x47)
:    #func                 -81    0.210  handle_IRQ_event+0xe
(handle_fasteoi_irq+0x6d)
:    #func                 -81    0.169  __ipipe_unstall_root+0x8
(handle_IRQ_event+0x65)
:|   #begin   0x80000000   -81    0.176  __ipipe_unstall_root+0x41
(handle_IRQ_event+0x65)
:|   +end     0x80000000   -80    0.221  __ipipe_unstall_root+0x33
(handle_IRQ_event+0x65)
:    +func                 -80    0.338  usb_hcd_irq+0x9
(handle_IRQ_event+0x30)
:    +func                 -80+   1.074  uhci_irq+0xe (usb_hcd_irq+0x2a)
:    +func                 -79    0.326  rtl8139_interrupt+0xe
(handle_IRQ_event+0x30)
:    +func                 -78    0.950  ioread16+0x8
(rtl8139_interrupt+0x3d)
:    +func                 -77    0.172  iowrite16+0x8
(rtl8139_interrupt+0xe4)
:    +func                 -77    0.845  ioread16+0x8
(rtl8139_interrupt+0xeb)
:    +func                 -76    0.176  __netif_rx_schedule+0xa
(rtl8139_interrupt+0xf3)
:    #func                 -76    0.172  __ipipe_restore_root+0x8
(__netif_rx_schedule+0x6b)
:    #func                 -76    0.206  __ipipe_unstall_root+0x8
(__ipipe_restore_root+0x1b)
:|   #begin   0x80000000   -76    0.180  __ipipe_unstall_root+0x41
(__ipipe_restore_root+0x1b)
:|   +end     0x80000000   -76    0.278  __ipipe_unstall_root+0x33
(__ipipe_restore_root+0x1b)
:    #func                 -75    0.195  note_interrupt+0xe
(handle_fasteoi_irq+0xb3)
:    #func                 -75    0.943  ack_ioapic_quirk_irq+0xa
(handle_fasteoi_irq+0x91)
:|   #begin   0xffffffff   -74    0.236  common_interrupt+0x29
(handle_fasteoi_irq+0xa4)
:|   #func                 -74    0.248  __ipipe_handle_irq+0xe
(common_interrupt+0x2e)
:|   #func                 -74    0.225  __ipipe_ack_irq+0x8
(__ipipe_handle_irq+0x149)
:|   #func                 -74    0.169  __ipipe_ack_edge_irq+0x8
(__ipipe_ack_irq+0x19)
:|   #func                 -73    0.214  ack_ioapic_irq+0x8
(__ipipe_ack_edge_irq+0xe)
:|   #func                 -73    0.187  __ipipe_walk_pipeline+0xe
(__ipipe_handle_irq+0x7b)
:|  +*func                 -73    0.172  ipipe_suspend_domain+0xe
(__ipipe_walk_pipeline+0xa0)
:|  +*func                 -73    0.187  __ipipe_sync_stage+0xe
(ipipe_suspend_domain+0x63)
:|  #*end     0x80000000   -73    0.199  __ipipe_sync_stage+0x13c
(ipipe_suspend_domain+0x63)
:   #*func                 -72    0.154  shield_handler+0x8
(__ipipe_sync_stage+0xbf)
:   #*func                 -72    0.172  __ipipe_schedule_irq+0xe
(shield_handler+0x19)
:|  #*begin   0x80000001   -72    0.206  __ipipe_schedule_irq+0xdf
(shield_handler+0x19)
:|  #*end     0x80000001   -72    0.244  __ipipe_schedule_irq+0x10f
(shield_handler+0x19)
:|  #*begin   0x80000000   -72    0.353  __ipipe_sync_stage+0x130
(ipipe_suspend_domain+0x63)
:|   #end     0xffffffff   -71    0.462  common_interrupt+0x38
(handle_fasteoi_irq+0xa4)
:    #func                 -71    0.210  irq_exit+0x8 (do_IRQ+0x4c)
Etc...

So I seem to see what's causing the problem now, but surfing the code to
find the bug might take a while. Anyone out there already know what this
one is? Let me know if you need more info. Also, I'd be interested to
hear if anyone else can reproduce this on their system.

Thanks,
Kyle Howell

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D
This email and any files transmitted with it are
confidential and intended solely for the use of the
named recipient or recipients.  If you have received
this email in error please notify the sender
immediately. =20

