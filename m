Message-ID: <4EE9FD4A.1090202@domain.hid>
Date: Thu, 15 Dec 2011 14:59:38 +0100
From: Anders Blomdell <anders.blomdell@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------020906070902060004050708"
Subject: [Xenomai-help] Big differences in analogy interrupt handling time
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Xenomai-help@domain.hid

This is a multi-part message in MIME format.
--------------020906070902060004050708
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

I'm trying to tweak out good performance with Analogy and a NI-6221 
card, and after getting weird results with the attached program (long 
and very varying interrupt latencies). The machine I'm running on is a 
'Intel(R) Core(TM)2 CPU 6420 @ 2.13GHz', no frequency scaling, no X, low 
load,  only one CPU enabled to minimize influence from other Linux 
tasks. As can be seen from the frozen traces (formatted and time shifted 
to be examined with 'pr -mtT -w 200 A B'), the time spent in the 
interrupt handling varies between 263 and 329 us and there is variation 
even in repeated code paths [which are bogus in themselves, why 
busy-wait 10 us in an interrupt routine?], so cache poisoning should not 
be the issue.

Anybody that has any insights to share?

Regards

Anders Blomdell

-- 
Anders Blomdell                  Email: anders.blomdell@domain.hid
Department of Automatic Control
Lund University                  Phone:    +46 46 222 4625
P.O. Box 118                     Fax:      +46 46 138118
SE-221 00 Lund, Sweden


--------------020906070902060004050708
Content-Type: text/x-csrc;
 name="read_test_async.c"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="read_test_async.c"

/**
 * @file
 * Analogy for Linux, input command test program
 *
 * @note Copyright (C) 1997-2000 David A. Schleef <ds@domain.hid>
 * @note Copyright (C) 2008 Alexis Berlemont <alexis.berlemont@domain.hid>
 *
 * Xenomai is free software; you can redistribute it and/or modify it
 * under the terms of the GNU General Public License as published by
 * the Free Software Foundation; either version 2 of the License, or
 * (at your option) any later version.
 *
 * Xenomai is distributed in the hope that it will be useful, but
 * WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
 * General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with Xenomai; if not, write to the Free Software Foundation,
 * Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.
 */

#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <sys/mman.h>
#include <errno.h>
#include <getopt.h>
#include <string.h>

#include <native/task.h>
#include <native/timer.h>
#include <native/mutex.h>

#include <nucleus/trace.h>

#include <analogy/analogy.h>

#define NB_SCAN 100000

static RT_TASK rt_task_desc;

int main(int argc, char *argv[])
{
  int err;
  unsigned short buf[10000];
  RTIME dt[NB_SCAN], t1, t2;
  int i;
  a4l_desc_t dsc = { .sbdata = NULL };
  unsigned int chans[] = { 
// Maximum 16 channels in a scanlist!
#define P(i) PACK(i, 0, AREF_GROUND)
    P(0), P(1), P(2), P(3), P(4), P(5), P(6), P(7),
#undef P
#define P(i) PACK(i, 1, AREF_GROUND)
    P(0), P(1), P(2), P(3), P(4), P(5), P(6), P(7),
#undef P
#define P(i) PACK(i, 2, AREF_GROUND)
//    P(0), P(1), P(2), P(3), P(4),
  };
  a4l_cmd_t cmd = {
    .idx_subd = 0,
    .flags = TRIG_WAKE_EOS,
    .start_src = TRIG_NOW,
    .start_arg = 0,
    .scan_begin_src = TRIG_TIMER,
    .scan_begin_arg = 350000,	/* in ns */
    .convert_src = TRIG_TIMER,
    .convert_arg = 4000,	/* in ns */
    .scan_end_src = TRIG_COUNT,
    .scan_end_arg =  sizeof(chans)/sizeof(chans[0]),
    .stop_src = TRIG_COUNT,
    .stop_arg = NB_SCAN,
//    .stop_arg = 1,
    .nb_chan = sizeof(chans)/sizeof(chans[0]),
    .chan_descs = chans,
  };
  RT_MUTEX mutex;
  int N = 0;

  err = mlockall(MCL_CURRENT | MCL_FUTURE);
  if (err < 0) {
    fprintf(stderr, "mlockall failed (%d)\n", errno);
    err = errno;
    goto out_main;
  }
  err = rt_task_shadow(&rt_task_desc, NULL, 90, 0);
  if (err < 0) {
    fprintf(stderr, "rt_task_shadow failed (%d)\n", err);
    goto out_main;
  }
  err = rt_mutex_create(&mutex, NULL);
  if (err < 0) {
    fprintf(stderr, "rt_mutex_create failed (%d)\n",  err);
    goto out_main;
  }
  err = a4l_open(&dsc, "analogy0");
  if (err < 0) {
    fprintf(stderr, "a4l_open failed (%d)\n",  err);
    goto out_mutex;
  }
  a4l_snd_cancel(&dsc, cmd.idx_subd);
  i = 0;
  err = a4l_snd_command(&dsc, &cmd);
  if (err < 0) {
    fprintf(stderr, "a4l_snd_command failed (%d)\n", err);
    goto out_close;
  }
  err = rt_mutex_acquire(&mutex, 0);
  if (err < 0) {
    fprintf(stderr, "rt_mutex_acquire failed (%d)\n", err);
    goto out_close;
  }
  rt_mutex_release(&mutex);
  t1 = rt_timer_read();
  for (i = 0 ; i < NB_SCAN ; i++) {
    xntrace_special('A',i);
    err = a4l_async_read(&dsc, buf, sizeof(chans)/sizeof(chans[0])*2, 
			 A4L_INFINITE);
    xntrace_special('B',i);
    if (err < 0) {
      fprintf(stderr, "a4l_read failed (%d)\n", err);
      goto out_report;
    }
    t2 = rt_timer_read();
    xntrace_special('C',i);
    dt[i] = t2 - t1;
    t1 = t2;
    N++;
    if (i > 200 && 
	dt[i] < cmd.scan_begin_arg - (cmd.scan_begin_arg >> 1) &&
	dt[i-1] > cmd.scan_begin_arg - (cmd.scan_begin_arg >> 1) &&
	dt[i-2] > cmd.scan_begin_arg - (cmd.scan_begin_arg >> 1) &&
	dt[i-3] > cmd.scan_begin_arg - (cmd.scan_begin_arg >> 1)) {
      xntrace_user_freeze(31414, 1);
      printf("N=%d\n", N);
      goto out_report;      
    }
  }
out_report:
  for (i = 0 ; i < sizeof(chans)/sizeof(chans[0]) ; i++) {
    printf("0x%4x ", buf[i]);
  }
  printf("\n");
  for (i = 1 ; i < N ; i++) {
    if (dt[i] < cmd.scan_begin_arg - (cmd.scan_begin_arg >> 1)  ||
	cmd.scan_begin_arg +  (cmd.scan_begin_arg >> 1) < dt[i]) {
      printf("%d (%Ld, %Ld)\n", i, dt[i-1], dt[i]);
    }
  }
  printf("\n");
  
out_close:
  a4l_close(&dsc);
out_mutex:
  rt_mutex_delete(&mutex);

out_main:
  return err;
}

--------------020906070902060004050708
Content-Type: text/plain;
 name="A"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="A"

:|   #end     0xffffff56     0    0.540N common_interrupt+0x40 (__ipipe_trace+0x4c7)
:    #func                   0    0.397N _raw_spin_lock_irqsave+0x5 (hrtimer_get_next_event+0x21)
:    #func                   1    0.409N arch_local_irq_save+0x4 (_raw_spin_lock_irqsave+0x11)
:    #func                   1    0.386N arch_local_irq_disable+0x3 (arch_local_irq_save+0x2e)
:    #func                   2    0.386N ipipe_check_context+0x9 (arch_local_irq_disable+0x12)
:    #func                   2    0.393N native_save_fl+0x3 (ipipe_check_context+0x15)
:|   #begin   0x80000001     2    0.424  ipipe_check_context+0x2d (arch_local_irq_disable+0x12)
:|   #func                   3    0.420N native_save_fl+0x3 (__ipipe_check_percpu_access+0xa)
:|   #func                   3    0.420N native_save_fl+0x3 (__ipipe_check_percpu_access+0xa)
:|   #end     0x80000001     4    0.435N ipipe_check_context+0xd9 (arch_local_irq_disable+0x12)
:    #func                   4    0.412N do_raw_spin_lock+0x3 (_raw_spin_lock_irqsave+0x1a)
:    #func                   5    0.401N __ipipe_spin_unlock_debug+0x3 (hrtimer_get_next_event+0x8f)
:    #func                   5    0.409N _raw_spin_unlock_irqrestore+0x3 (hrtimer_get_next_event+0x98)
:    #func                   5    0.390N arch_local_irq_restore+0x3 (_raw_spin_unlock_irqrestore+0x13)
:    #func                   6    0.386N __ipipe_restore_root+0x4 (arch_local_irq_restore+0x16)
:    #func                   6    0.393N ipipe_check_context+0x9 (__ipipe_restore_root+0x15)
:    #func                   7    0.393N native_save_fl+0x3 (ipipe_check_context+0x15)
:|   #begin   0x80000001     7    0.424  ipipe_check_context+0x2d (__ipipe_restore_root+0x15)
:|   #func                   7    0.427N native_save_fl+0x3 (__ipipe_check_percpu_access+0xa)
:|   #func                   8    0.416N native_save_fl+0x3 (__ipipe_check_percpu_access+0xa)
:|   #end     0x80000001     8    0.559N ipipe_check_context+0xd9 (__ipipe_restore_root+0x15)
:    #func                   9    0.409N select_nohz_load_balancer+0x7 (tick_nohz_stop_sched_tick+0x272)
:    #func                   9    0.416N cpumask_set_cpu+0x3 (select_nohz_load_balancer+0x5f)
:    #func                  10    0.390N atomic_cmpxchg+0x4 (select_nohz_load_balancer+0x95)
:    #func                  10    0.442N atomic_cmpxchg+0x4 (select_nohz_load_balancer+0xb4)
:    #func                  10    0.397N rcu_enter_nohz+0x4 (tick_nohz_stop_sched_tick+0x293)
:    #func                  11    0.412N arch_local_irq_save+0x4 (rcu_enter_nohz+0x13)
:    #func                  11    0.386N ipipe_check_context+0x9 (arch_local_irq_save+0x33)
:    #func                  12    0.405N native_save_fl+0x3 (ipipe_check_context+0x15)
:|   #begin   0x80000001    12    0.424  ipipe_check_context+0x2d (arch_local_irq_save+0x33)
:|   #func                  12    0.416N native_save_fl+0x3 (__ipipe_check_percpu_access+0xa)
:|   #func                  13    0.416N native_save_fl+0x3 (__ipipe_check_percpu_access+0xa)
:|   #end     0x80000001    13    0.446N ipipe_check_context+0xd9 (arch_local_irq_save+0x33)
:    #func                  14    0.393N arch_local_irq_restore+0x3 (rcu_enter_nohz+0x55)
:    #func                  14    0.390N __ipipe_restore_root+0x4 (arch_local_irq_restore+0x16)
:    #func                  14    0.386N ipipe_check_context+0x9 (__ipipe_restore_root+0x15)
:    #func                  15    0.393N native_save_fl+0x3 (ipipe_check_context+0x15)
:|   #begin   0x80000001    15    0.424  ipipe_check_context+0x2d (__ipipe_restore_root+0x15)
:|   #func                  16    0.416N native_save_fl+0x3 (__ipipe_check_percpu_access+0xa)
:|   #func                  16    0.416N native_save_fl+0x3 (__ipipe_check_percpu_access+0xa)
:|   #end     0x80000001    17    0.581N ipipe_check_context+0xd9 (__ipipe_restore_root+0x15)

:|   #begin   0xffffff56    17    0.427  common_interrupt+0x2f (ipipe_check_context+0xdd)
:|   #func                  18    0.401N __ipipe_handle_irq+0x9 (common_interrupt+0x36)
:|   #func                  18    0.390N native_save_fl+0x3 (__ipipe_handle_irq+0x41)
:|   #func                  18    0.431N native_save_fl+0x3 (__ipipe_check_percpu_access+0xa)
:|   #func                  19    0.397N irq_to_desc+0x3 (__ipipe_handle_irq+0xec)
:|   #func                  19    0.390N __ipipe_ack_fasteoi_irq+0x3 (__ipipe_handle_irq+0xf2)
:|   #func                  20    0.393N ack_apic_level+0x7 (__ipipe_ack_fasteoi_irq+0x16)
:|   #func                  20    0.386N apic_read+0x3 (ack_apic_level+0x24)
:|   #func                  20    0.416N native_apic_mem_read+0x3 (apic_read+0x14)
:|   #func                  21    0.405N __io_apic_modify_irq+0x9 (ack_apic_level+0xc3)
:|   #func                  21    0.386N io_apic_read+0x4 (__io_apic_modify_irq+0x25)
:|   #func                  22+   1.478N io_apic_base+0x3 (io_apic_read+0x10)
:|   #func                  23    0.412N io_apic_base+0x3 (__io_apic_modify_irq+0x36)
:|   #func                  23    0.386N io_apic_sync+0x3 (__io_apic_modify_irq+0x52)
:|   #func                  24+   1.215N io_apic_base+0x3 (io_apic_sync+0xf)
:|   #func                  25    0.386N apic_write+0x3 (ack_apic_level+0xdc)
:|   #func                  25    0.405N native_apic_mem_write+0x3 (apic_write+0x14)
:|   #func                  26    0.386N __ipipe_dispatch_wired+0x6 (__ipipe_handle_irq+0xff)
:|   #func                  26    0.424N native_save_fl+0x3 (__ipipe_check_percpu_access+0xa)
:|   #func                  27    0.390N __ipipe_dispatch_wired_nocheck+0x9 (__ipipe_dispatch_wired+0x62)
:|   #func                  27    0.412N native_save_fl+0x3 (__ipipe_check_percpu_access+0xa)
:|   #func                  27    0.412N native_save_fl+0x3 (__ipipe_check_percpu_access+0xa)
:|   #func                  28    0.427N native_save_fl+0x3 (__ipipe_check_percpu_access+0xa)
:|  #*func                  28    0.442N xnintr_shirq_handler+0x9 [xeno_nucleus] (__ipipe_dispatch_wired_nocheck+0xe1)
:|  #*func                  29    0.480N __xnlock_get.constprop.2+0x9 [xeno_nucleus] (xnintr_shirq_handler+0x5f [xeno_nucleus])

:|  #*func                  29    0.401N a4l_handle_irq+0x3 [xeno_analogy] (xnintr_shirq_handler+0x70 [xeno_nucleus])
:|  #*func                  30    0.405N a4l_ni_E_interrupt+0x9 [analogy_ni_mio] (a4l_handle_irq+0x13 [xeno_analogy])
:|  #*func                  30    0.397N ipipe_test_and_stall_pipeline_head+0x4 [analogy_ni_mio] (a4l_ni_E_interrupt+0x29 [analogy_ni_mio])
:|  #*func                  30    0.405N native_irqs_disabled+0x3 [analogy_ni_mio] (ipipe_test_and_stall_pipeline_head+0xe [analogy_ni_mio])
:|  #*func                  31    0.427N native_save_fl+0x3 (__ipipe_check_percpu_access+0xa)
:|  #*func                  31+   1.407N m_series_stc_readw+0x6 [analogy_ni_pcimio] (a4l_ni_E_interrupt+0x50 [analogy_ni_mio])
:|  #*func                  33+   1.384N m_series_stc_readw+0x6 [analogy_ni_pcimio] (a4l_ni_E_interrupt+0x64 [analogy_ni_mio])
:|  #*func                  34    0.439N native_save_fl+0x3 (__ipipe_check_percpu_access+0xa)
:|  #*func                  34    0.397N a4l_mite_get_status+0x6 [analogy_ni_mite] (a4l_ni_E_interrupt+0x1c9 [analogy_ni_mio])
:|  #*func                  35    0.397N ipipe_test_and_stall_pipeline_head+0x4 [analogy_ni_mite] (a4l_mite_get_status+0x14 [analogy_ni_mite])
:|  #*func                  35    0.405N native_irqs_disabled+0x3 [analogy_ni_mite] (ipipe_test_and_stall_pipeline_head+0xe [analogy_ni_mite])
:|  #*func                  36+   1.208N native_save_fl+0x3 (__ipipe_check_percpu_access+0xa)
:|  #*func                  37    0.397N ipipe_restore_pipeline_head+0x5 [analogy_ni_mite] (a4l_mite_get_status+0x6e [analogy_ni_mite])
:|  #*func                  37    0.405N native_irqs_disabled+0x3 [analogy_ni_mite] (ipipe_restore_pipeline_head+0x11 [analogy_ni_mite])
:|  #*func                  38    0.461N native_save_fl+0x3 (__ipipe_check_percpu_access+0xa)
:|  #*func                  38    0.461N m_series_stc_writew+0x7 [analogy_ni_pcimio] (a4l_ni_E_interrupt+0x2b2 [analogy_ni_mio])
:|  #*func                  39    0.397N a4l_get_subd+0x9 [xeno_analogy] (a4l_ni_E_interrupt+0x357 [analogy_ni_mio])
:|  #*func                  39    0.397N prefetch+0x3 [xeno_analogy] (a4l_get_subd+0x2f [xeno_analogy])
:|  #*func                  39    0.397N prefetch+0x3 [xeno_analogy] (a4l_get_subd+0x2f [xeno_analogy])
:|  #*func                  40    0.401N prefetch+0x3 [xeno_analogy] (a4l_get_subd+0x2f [xeno_analogy])
:|  #*func                  40    0.401N prefetch+0x3 [xeno_analogy] (a4l_get_subd+0x2f [xeno_analogy])
:|  #*func                  41    0.401N prefetch+0x3 [xeno_analogy] (a4l_get_subd+0x2f [xeno_analogy])
:|  #*func                  41    0.397N prefetch+0x3 [xeno_analogy] (a4l_get_subd+0x2f [xeno_analogy])
:|  #*func                  41    0.397N prefetch+0x3 [xeno_analogy] (a4l_get_subd+0x2f [xeno_analogy])
:|  #*func                  42    0.401N prefetch+0x3 [xeno_analogy] (a4l_get_subd+0x2f [xeno_analogy])
:|  #*func                  42    0.397N prefetch+0x3 [xeno_analogy] (a4l_get_subd+0x2f [xeno_analogy])
:|  #*func                  43    0.401N prefetch+0x3 [xeno_analogy] (a4l_get_subd+0x2f [xeno_analogy])
:|  #*func                  43    0.397N prefetch+0x3 [xeno_analogy] (a4l_get_subd+0x2f [xeno_analogy])
:|  #*func                  43    0.397N prefetch+0x3 [xeno_analogy] (a4l_get_subd+0x2f [xeno_analogy])
:|  #*func                  44    0.401N prefetch+0x3 [xeno_analogy] (a4l_get_subd+0x2f [xeno_analogy])
:|  #*func                  44    0.397N prefetch+0x3 [xeno_analogy] (a4l_get_subd+0x2f [xeno_analogy])
:|  #*func                  45    0.412N prefetch+0x3 [xeno_analogy] (a4l_get_subd+0x2f [xeno_analogy])

:|  #*func                  45    0.397N ni_sync_ai_dma+0x6 [analogy_ni_mio] (a4l_ni_E_interrupt+0x401 [analogy_ni_mio])
:|  #*func                  45    0.397N ipipe_test_and_stall_pipeline_head+0x4 [analogy_ni_mio] (ni_sync_ai_dma+0x15 [analogy_ni_mio])
:|  #*func                  46    0.401N native_irqs_disabled+0x3 [analogy_ni_mio] (ipipe_test_and_stall_pipeline_head+0xe [analogy_ni_mio])
:|  #*func                  46    0.431N native_save_fl+0x3 (__ipipe_check_percpu_access+0xa)
:|  #*func                  47    0.401N a4l_mite_sync_input_dma+0x7 [analogy_ni_mite] (ni_sync_ai_dma+0x4d [analogy_ni_mio])
:|  #*func                  47    0.397N a4l_mite_bytes_written_to_memory_lb+0x5 [analogy_ni_mite] (a4l_mite_sync_input_dma+0x15 [analogy_ni_mite])
:|  #*func                  47+   1.178N mite_device_bytes_transferred+0x3 [analogy_ni_mite] (a4l_mite_bytes_written_to_memory_lb+0x11 [analogy_ni_mite])
:|  #*func                  49+   1.178N a4l_mite_bytes_in_transit+0x3 [analogy_ni_mite] (a4l_mite_bytes_written_to_memory_lb+0x1a [analogy_ni_mite])
:|  #*func                  50    0.397N a4l_mite_bytes_written_to_memory_ub+0x5 [analogy_ni_mite] (a4l_mite_sync_input_dma+0x1e [analogy_ni_mite])
:|  #*func                  50+   1.159N a4l_mite_bytes_in_transit+0x3 [analogy_ni_mite] (a4l_mite_bytes_written_to_memory_ub+0x11 [analogy_ni_mite])
:|  #*func                  51+   1.181N mite_device_bytes_transferred+0x3 [analogy_ni_mite] (a4l_mite_bytes_written_to_memory_ub+0x1a [analogy_ni_mite])
:|  #*func                  53    0.401N a4l_buf_prepare_absput+0x5 [xeno_analogy] (a4l_mite_sync_input_dma+0x27 [analogy_ni_mite])
:|  #*func                  53    0.401N a4l_buf_commit_absput+0x5 [xeno_analogy] (a4l_mite_sync_input_dma+0x47 [analogy_ni_mite])
:|  #*func                  53    0.442N __abs_put+0x6 [xeno_analogy] (a4l_buf_commit_absput+0x2f [xeno_analogy])
:|  #*func                  54    0.397N ipipe_restore_pipeline_head+0x5 [analogy_ni_mio] (ni_sync_ai_dma+0x5d [analogy_ni_mio])
:|  #*func                  54    0.405N native_irqs_disabled+0x3 [analogy_ni_mio] (ipipe_restore_pipeline_head+0x11 [analogy_ni_mio])
:|  #*func                  55    0.439N native_save_fl+0x3 (__ipipe_check_percpu_access+0xa)
:|  #*func                  55    0.397N a4l_udelay+0x3 [analogy_ni_mio] (a4l_ni_E_interrupt+0x40b [analogy_ni_mio])
:|  #*func                  55    0.431N rtdm_task_busy_sleep+0x7 [xeno_rtdm] (a4l_udelay+0x14 [analogy_ni_mio])
:|  #*func                  56    0.401N xnarch_ns_to_tsc+0x9 [xeno_nucleus] (rtdm_task_busy_sleep+0x21 [xeno_rtdm])
:|  #*func                  56    0.634N __rthal_x86_nodiv_ullimd+0x8 [xeno_nucleus] (xnarch_ns_to_tsc+0x3f [xeno_nucleus])

:|  #*func                  57    0.397N ni_sync_ai_dma+0x6 [analogy_ni_mio] (a4l_ni_E_interrupt+0x401 [analogy_ni_mio])
:|  #*func                  57    0.397N ipipe_test_and_stall_pipeline_head+0x4 [analogy_ni_mio] (ni_sync_ai_dma+0x15 [analogy_ni_mio])
:|  #*func                  58    0.401N native_irqs_disabled+0x3 [analogy_ni_mio] (ipipe_test_and_stall_pipeline_head+0xe [analogy_ni_mio])
:|  #*func                  58    0.431N native_save_fl+0x3 (__ipipe_check_percpu_access+0xa)
:|  #*func                  59    0.397N a4l_mite_sync_input_dma+0x7 [analogy_ni_mite] (ni_sync_ai_dma+0x4d [analogy_ni_mio])
:|  #*func                  59    0.397N a4l_mite_bytes_written_to_memory_lb+0x5 [analogy_ni_mite] (a4l_mite_sync_input_dma+0x15 [analogy_ni_mite])
:|  #*func                  59+   1.166N mite_device_bytes_transferred+0x3 [analogy_ni_mite] (a4l_mite_bytes_written_to_memory_lb+0x11 [analogy_ni_mite])
:|  #*func                  60+   1.178N a4l_mite_bytes_in_transit+0x3 [analogy_ni_mite] (a4l_mite_bytes_written_to_memory_lb+0x1a [analogy_ni_mite])
:|  #*func                  62    0.397N a4l_mite_bytes_written_to_memory_ub+0x5 [analogy_ni_mite] (a4l_mite_sync_input_dma+0x1e [analogy_ni_mite])
:|  #*func                  62+   1.189N a4l_mite_bytes_in_transit+0x3 [analogy_ni_mite] (a4l_mite_bytes_written_to_memory_ub+0x11 [analogy_ni_mite])
:|  #*func                  63+   1.174N mite_device_bytes_transferred+0x3 [analogy_ni_mite] (a4l_mite_bytes_written_to_memory_ub+0x1a [analogy_ni_mite])
:|  #*func                  64    0.405N a4l_buf_prepare_absput+0x5 [xeno_analogy] (a4l_mite_sync_input_dma+0x27 [analogy_ni_mite])
:|  #*func                  65    0.397N a4l_buf_commit_absput+0x5 [xeno_analogy] (a4l_mite_sync_input_dma+0x47 [analogy_ni_mite])
:|  #*func                  65    0.439N __abs_put+0x6 [xeno_analogy] (a4l_buf_commit_absput+0x2f [xeno_analogy])
:|  #*func                  66    0.397N ipipe_restore_pipeline_head+0x5 [analogy_ni_mio] (ni_sync_ai_dma+0x5d [analogy_ni_mio])
:|  #*func                  66    0.401N native_irqs_disabled+0x3 [analogy_ni_mio] (ipipe_restore_pipeline_head+0x11 [analogy_ni_mio])
:|  #*func                  66    0.457N native_save_fl+0x3 (__ipipe_check_percpu_access+0xa)
:|  #*func                  67    0.409N a4l_udelay+0x3 [analogy_ni_mio] (a4l_ni_E_interrupt+0x40b [analogy_ni_mio])
:|  #*func                  67    0.442N rtdm_task_busy_sleep+0x7 [xeno_rtdm] (a4l_udelay+0x14 [analogy_ni_mio])
:|  #*func                  68    0.397N xnarch_ns_to_tsc+0x9 [xeno_nucleus] (rtdm_task_busy_sleep+0x21 [xeno_rtdm])
:|  #*func                  68    0.630N __rthal_x86_nodiv_ullimd+0x8 [xeno_nucleus] (xnarch_ns_to_tsc+0x3f [xeno_nucleus])

:|  #*func                  69    0.397N ni_sync_ai_dma+0x6 [analogy_ni_mio] (a4l_ni_E_interrupt+0x401 [analogy_ni_mio])
:|  #*func                  69    0.397N ipipe_test_and_stall_pipeline_head+0x4 [analogy_ni_mio] (ni_sync_ai_dma+0x15 [analogy_ni_mio])
:|  #*func                  70    0.405N native_irqs_disabled+0x3 [analogy_ni_mio] (ipipe_test_and_stall_pipeline_head+0xe [analogy_ni_mio])
:|  #*func                  70    0.431N native_save_fl+0x3 (__ipipe_check_percpu_access+0xa)
:|  #*func                  70    0.397N a4l_mite_sync_input_dma+0x7 [analogy_ni_mite] (ni_sync_ai_dma+0x4d [analogy_ni_mio])
:|  #*func                  71    0.397N a4l_mite_bytes_written_to_memory_lb+0x5 [analogy_ni_mite] (a4l_mite_sync_input_dma+0x15 [analogy_ni_mite])
:|  #*func                  71+   1.174N mite_device_bytes_transferred+0x3 [analogy_ni_mite] (a4l_mite_bytes_written_to_memory_lb+0x11 [analogy_ni_mite])
:|  #*func                  72+   1.185N a4l_mite_bytes_in_transit+0x3 [analogy_ni_mite] (a4l_mite_bytes_written_to_memory_lb+0x1a [analogy_ni_mite])
:|  #*func                  74    0.397N a4l_mite_bytes_written_to_memory_ub+0x5 [analogy_ni_mite] (a4l_mite_sync_input_dma+0x1e [analogy_ni_mite])
:|  #*func                  74+   1.185N a4l_mite_bytes_in_transit+0x3 [analogy_ni_mite] (a4l_mite_bytes_written_to_memory_ub+0x11 [analogy_ni_mite])
:|  #*func                  75+   1.174N mite_device_bytes_transferred+0x3 [analogy_ni_mite] (a4l_mite_bytes_written_to_memory_ub+0x1a [analogy_ni_mite])
:|  #*func                  76    0.405N a4l_buf_prepare_absput+0x5 [xeno_analogy] (a4l_mite_sync_input_dma+0x27 [analogy_ni_mite])
:|  #*func                  77    0.397N a4l_buf_commit_absput+0x5 [xeno_analogy] (a4l_mite_sync_input_dma+0x47 [analogy_ni_mite])
:|  #*func                  77    0.405N __abs_put+0x6 [xeno_analogy] (a4l_buf_commit_absput+0x2f [xeno_analogy])
:|  #*func                  78    0.397N ipipe_restore_pipeline_head+0x5 [analogy_ni_mio] (ni_sync_ai_dma+0x5d [analogy_ni_mio])
:|  #*func                  78    0.405N native_irqs_disabled+0x3 [analogy_ni_mio] (ipipe_restore_pipeline_head+0x11 [analogy_ni_mio])
:|  #*func                  78    0.424N native_save_fl+0x3 (__ipipe_check_percpu_access+0xa)
:|  #*func                  79    0.397N a4l_udelay+0x3 [analogy_ni_mio] (a4l_ni_E_interrupt+0x40b [analogy_ni_mio])
:|  #*func                  79    0.431N rtdm_task_busy_sleep+0x7 [xeno_rtdm] (a4l_udelay+0x14 [analogy_ni_mio])
:|  #*func                  80    0.401N xnarch_ns_to_tsc+0x9 [xeno_nucleus] (rtdm_task_busy_sleep+0x21 [xeno_rtdm])
:|  #*func                  80    0.630N __rthal_x86_nodiv_ullimd+0x8 [xeno_nucleus] (xnarch_ns_to_tsc+0x3f [xeno_nucleus])

:|  #*func                  81    0.397N ni_sync_ai_dma+0x6 [analogy_ni_mio] (a4l_ni_E_interrupt+0x401 [analogy_ni_mio])
:|  #*func                  81    0.397N ipipe_test_and_stall_pipeline_head+0x4 [analogy_ni_mio] (ni_sync_ai_dma+0x15 [analogy_ni_mio])
:|  #*func                  81    0.401N native_irqs_disabled+0x3 [analogy_ni_mio] (ipipe_test_and_stall_pipeline_head+0xe [analogy_ni_mio])
:|  #*func                  82    0.431N native_save_fl+0x3 (__ipipe_check_percpu_access+0xa)
:|  #*func                  82    0.401N a4l_mite_sync_input_dma+0x7 [analogy_ni_mite] (ni_sync_ai_dma+0x4d [analogy_ni_mio])
:|  #*func                  83    0.393N a4l_mite_bytes_written_to_memory_lb+0x5 [analogy_ni_mite] (a4l_mite_sync_input_dma+0x15 [analogy_ni_mite])
:|  #*func                  83+   1.189N mite_device_bytes_transferred+0x3 [analogy_ni_mite] (a4l_mite_bytes_written_to_memory_lb+0x11 [analogy_ni_mite])
:|  #*func                  84+   1.170N a4l_mite_bytes_in_transit+0x3 [analogy_ni_mite] (a4l_mite_bytes_written_to_memory_lb+0x1a [analogy_ni_mite])
:|  #*func                  85    0.397N a4l_mite_bytes_written_to_memory_ub+0x5 [analogy_ni_mite] (a4l_mite_sync_input_dma+0x1e [analogy_ni_mite])
:|  #*func                  86+   1.170N a4l_mite_bytes_in_transit+0x3 [analogy_ni_mite] (a4l_mite_bytes_written_to_memory_ub+0x11 [analogy_ni_mite])
:|  #*func                  87+   1.166N mite_device_bytes_transferred+0x3 [analogy_ni_mite] (a4l_mite_bytes_written_to_memory_ub+0x1a [analogy_ni_mite])
:|  #*func                  88    0.405N a4l_buf_prepare_absput+0x5 [xeno_analogy] (a4l_mite_sync_input_dma+0x27 [analogy_ni_mite])
:|  #*func                  89    0.397N a4l_buf_commit_absput+0x5 [xeno_analogy] (a4l_mite_sync_input_dma+0x47 [analogy_ni_mite])
:|  #*func                  89    0.405N __abs_put+0x6 [xeno_analogy] (a4l_buf_commit_absput+0x2f [xeno_analogy])
:|  #*func                  89    0.397N ipipe_restore_pipeline_head+0x5 [analogy_ni_mio] (ni_sync_ai_dma+0x5d [analogy_ni_mio])
:|  #*func                  90    0.405N native_irqs_disabled+0x3 [analogy_ni_mio] (ipipe_restore_pipeline_head+0x11 [analogy_ni_mio])
:|  #*func                  90    0.424N native_save_fl+0x3 (__ipipe_check_percpu_access+0xa)
:|  #*func                  91    0.397N a4l_udelay+0x3 [analogy_ni_mio] (a4l_ni_E_interrupt+0x40b [analogy_ni_mio])
:|  #*func                  91    0.427N rtdm_task_busy_sleep+0x7 [xeno_rtdm] (a4l_udelay+0x14 [analogy_ni_mio])
:|  #*func                  91    0.401N xnarch_ns_to_tsc+0x9 [xeno_nucleus] (rtdm_task_busy_sleep+0x21 [xeno_rtdm])
:|  #*func                  92    0.630N __rthal_x86_nodiv_ullimd+0x8 [xeno_nucleus] (xnarch_ns_to_tsc+0x3f [xeno_nucleus])

:|  #*func                  92    0.397N ni_sync_ai_dma+0x6 [analogy_ni_mio] (a4l_ni_E_interrupt+0x401 [analogy_ni_mio])
:|  #*func                  93    0.397N ipipe_test_and_stall_pipeline_head+0x4 [analogy_ni_mio] (ni_sync_ai_dma+0x15 [analogy_ni_mio])
:|  #*func                  93    0.401N native_irqs_disabled+0x3 [analogy_ni_mio] (ipipe_test_and_stall_pipeline_head+0xe [analogy_ni_mio])
:|  #*func                  94    0.435N native_save_fl+0x3 (__ipipe_check_percpu_access+0xa)
:|  #*func                  94    0.397N a4l_mite_sync_input_dma+0x7 [analogy_ni_mite] (ni_sync_ai_dma+0x4d [analogy_ni_mio])
:|  #*func                  94    0.397N a4l_mite_bytes_written_to_memory_lb+0x5 [analogy_ni_mite] (a4l_mite_sync_input_dma+0x15 [analogy_ni_mite])
:|  #*func                  95+   1.196N mite_device_bytes_transferred+0x3 [analogy_ni_mite] (a4l_mite_bytes_written_to_memory_lb+0x11 [analogy_ni_mite])
:|  #*func                  96+   1.170N a4l_mite_bytes_in_transit+0x3 [analogy_ni_mite] (a4l_mite_bytes_written_to_memory_lb+0x1a [analogy_ni_mite])
:|  #*func                  97    0.397N a4l_mite_bytes_written_to_memory_ub+0x5 [analogy_ni_mite] (a4l_mite_sync_input_dma+0x1e [analogy_ni_mite])
:|  #*func                  98+   1.193N a4l_mite_bytes_in_transit+0x3 [analogy_ni_mite] (a4l_mite_bytes_written_to_memory_ub+0x11 [analogy_ni_mite])
:|  #*func                  99+   1.212N mite_device_bytes_transferred+0x3 [analogy_ni_mite] (a4l_mite_bytes_written_to_memory_ub+0x1a [analogy_ni_mite])
:|  #*func                 100    0.405N a4l_buf_prepare_absput+0x5 [xeno_analogy] (a4l_mite_sync_input_dma+0x27 [analogy_ni_mite])
:|  #*func                 100    0.397N a4l_buf_commit_absput+0x5 [xeno_analogy] (a4l_mite_sync_input_dma+0x47 [analogy_ni_mite])
:|  #*func                 101    0.405N __abs_put+0x6 [xeno_analogy] (a4l_buf_commit_absput+0x2f [xeno_analogy])
:|  #*func                 101    0.397N ipipe_restore_pipeline_head+0x5 [analogy_ni_mio] (ni_sync_ai_dma+0x5d [analogy_ni_mio])
:|  #*func                 102    0.495N native_irqs_disabled+0x3 [analogy_ni_mio] (ipipe_restore_pipeline_head+0x11 [analogy_ni_mio])
:|  #*func                 102    0.454N native_save_fl+0x3 (__ipipe_check_percpu_access+0xa)
:|  #*func                 103    0.405N a4l_udelay+0x3 [analogy_ni_mio] (a4l_ni_E_interrupt+0x40b [analogy_ni_mio])
:|  #*func                 103    0.435N rtdm_task_busy_sleep+0x7 [xeno_rtdm] (a4l_udelay+0x14 [analogy_ni_mio])
:|  #*func                 103    0.409N xnarch_ns_to_tsc+0x9 [xeno_nucleus] (rtdm_task_busy_sleep+0x21 [xeno_rtdm])
:|  #*func                 104    0.607N __rthal_x86_nodiv_ullimd+0x8 [xeno_nucleus] (xnarch_ns_to_tsc+0x3f [xeno_nucleus])

:|  #*func                 104    0.405N ni_sync_ai_dma+0x6 [analogy_ni_mio] (a4l_ni_E_interrupt+0x401 [analogy_ni_mio])
:|  #*func                 105    0.405N ipipe_test_and_stall_pipeline_head+0x4 [analogy_ni_mio] (ni_sync_ai_dma+0x15 [analogy_ni_mio])
:|  #*func                 105    0.409N native_irqs_disabled+0x3 [analogy_ni_mio] (ipipe_test_and_stall_pipeline_head+0xe [analogy_ni_mio])
:|  #*func                 106    0.439N native_save_fl+0x3 (__ipipe_check_percpu_access+0xa)
:|  #*func                 106    0.405N a4l_mite_sync_input_dma+0x7 [analogy_ni_mite] (ni_sync_ai_dma+0x4d [analogy_ni_mio])
:|  #*func                 107    0.405N a4l_mite_bytes_written_to_memory_lb+0x5 [analogy_ni_mite] (a4l_mite_sync_input_dma+0x15 [analogy_ni_mite])
:|  #*func                 107+   1.185N mite_device_bytes_transferred+0x3 [analogy_ni_mite] (a4l_mite_bytes_written_to_memory_lb+0x11 [analogy_ni_mite])
:|  #*func                 108+   1.178N a4l_mite_bytes_in_transit+0x3 [analogy_ni_mite] (a4l_mite_bytes_written_to_memory_lb+0x1a [analogy_ni_mite])
:|  #*func                 109    0.401N a4l_mite_bytes_written_to_memory_ub+0x5 [analogy_ni_mite] (a4l_mite_sync_input_dma+0x1e [analogy_ni_mite])
:|  #*func                 110+   1.181N a4l_mite_bytes_in_transit+0x3 [analogy_ni_mite] (a4l_mite_bytes_written_to_memory_ub+0x11 [analogy_ni_mite])
:|  #*func                 111+   1.174N mite_device_bytes_transferred+0x3 [analogy_ni_mite] (a4l_mite_bytes_written_to_memory_ub+0x1a [analogy_ni_mite])
:|  #*func                 112    0.409N a4l_buf_prepare_absput+0x5 [xeno_analogy] (a4l_mite_sync_input_dma+0x27 [analogy_ni_mite])
:|  #*func                 112    0.409N a4l_buf_commit_absput+0x5 [xeno_analogy] (a4l_mite_sync_input_dma+0x47 [analogy_ni_mite])
:|  #*func                 113    0.412N __abs_put+0x6 [xeno_analogy] (a4l_buf_commit_absput+0x2f [xeno_analogy])
:|  #*func                 113    0.401N ipipe_restore_pipeline_head+0x5 [analogy_ni_mio] (ni_sync_ai_dma+0x5d [analogy_ni_mio])
:|  #*func                 114    0.409N native_irqs_disabled+0x3 [analogy_ni_mio] (ipipe_restore_pipeline_head+0x11 [analogy_ni_mio])
:|  #*func                 114    0.431N native_save_fl+0x3 (__ipipe_check_percpu_access+0xa)
:|  #*func                 115    0.405N a4l_udelay+0x3 [analogy_ni_mio] (a4l_ni_E_interrupt+0x40b [analogy_ni_mio])
:|  #*func                 115    0.435N rtdm_task_busy_sleep+0x7 [xeno_rtdm] (a4l_udelay+0x14 [analogy_ni_mio])
:|  #*func                 115    0.409N xnarch_ns_to_tsc+0x9 [xeno_nucleus] (rtdm_task_busy_sleep+0x21 [xeno_rtdm])
:|  #*func                 116    0.607N __rthal_x86_nodiv_ullimd+0x8 [xeno_nucleus] (xnarch_ns_to_tsc+0x3f [xeno_nucleus])

:|  #*func                 116    0.405N ni_sync_ai_dma+0x6 [analogy_ni_mio] (a4l_ni_E_interrupt+0x401 [analogy_ni_mio])
:|  #*func                 117    0.401N ipipe_test_and_stall_pipeline_head+0x4 [analogy_ni_mio] (ni_sync_ai_dma+0x15 [analogy_ni_mio])
:|  #*func                 117    0.409N native_irqs_disabled+0x3 [analogy_ni_mio] (ipipe_test_and_stall_pipeline_head+0xe [analogy_ni_mio])
:|  #*func                 118    0.439N native_save_fl+0x3 (__ipipe_check_percpu_access+0xa)
:|  #*func                 118    0.405N a4l_mite_sync_input_dma+0x7 [analogy_ni_mite] (ni_sync_ai_dma+0x4d [analogy_ni_mio])
:|  #*func                 118    0.405N a4l_mite_bytes_written_to_memory_lb+0x5 [analogy_ni_mite] (a4l_mite_sync_input_dma+0x15 [analogy_ni_mite])
:|  #*func                 119+   1.181N mite_device_bytes_transferred+0x3 [analogy_ni_mite] (a4l_mite_bytes_written_to_memory_lb+0x11 [analogy_ni_mite])
:|  #*func                 120+   1.178N a4l_mite_bytes_in_transit+0x3 [analogy_ni_mite] (a4l_mite_bytes_written_to_memory_lb+0x1a [analogy_ni_mite])
:|  #*func                 121    0.401N a4l_mite_bytes_written_to_memory_ub+0x5 [analogy_ni_mite] (a4l_mite_sync_input_dma+0x1e [analogy_ni_mite])
:|  #*func                 122+   1.181N a4l_mite_bytes_in_transit+0x3 [analogy_ni_mite] (a4l_mite_bytes_written_to_memory_ub+0x11 [analogy_ni_mite])
:|  #*func                 123+   1.181N mite_device_bytes_transferred+0x3 [analogy_ni_mite] (a4l_mite_bytes_written_to_memory_ub+0x1a [analogy_ni_mite])
:|  #*func                 124    0.409N a4l_buf_prepare_absput+0x5 [xeno_analogy] (a4l_mite_sync_input_dma+0x27 [analogy_ni_mite])
:|  #*func                 124    0.409N a4l_buf_commit_absput+0x5 [xeno_analogy] (a4l_mite_sync_input_dma+0x47 [analogy_ni_mite])
:|  #*func                 125    0.412N __abs_put+0x6 [xeno_analogy] (a4l_buf_commit_absput+0x2f [xeno_analogy])
:|  #*func                 125    0.401N ipipe_restore_pipeline_head+0x5 [analogy_ni_mio] (ni_sync_ai_dma+0x5d [analogy_ni_mio])
:|  #*func                 126    0.409N native_irqs_disabled+0x3 [analogy_ni_mio] (ipipe_restore_pipeline_head+0x11 [analogy_ni_mio])
:|  #*func                 126    0.431N native_save_fl+0x3 (__ipipe_check_percpu_access+0xa)
:|  #*func                 126    0.405N a4l_udelay+0x3 [analogy_ni_mio] (a4l_ni_E_interrupt+0x40b [analogy_ni_mio])
:|  #*func                 127    0.435N rtdm_task_busy_sleep+0x7 [xeno_rtdm] (a4l_udelay+0x14 [analogy_ni_mio])
:|  #*func                 127    0.409N xnarch_ns_to_tsc+0x9 [xeno_nucleus] (rtdm_task_busy_sleep+0x21 [xeno_rtdm])
:|  #*func                 128    0.600N __rthal_x86_nodiv_ullimd+0x8 [xeno_nucleus] (xnarch_ns_to_tsc+0x3f [xeno_nucleus])

:|  #*func                 128    0.405N ni_sync_ai_dma+0x6 [analogy_ni_mio] (a4l_ni_E_interrupt+0x401 [analogy_ni_mio])
:|  #*func                 129    0.405N ipipe_test_and_stall_pipeline_head+0x4 [analogy_ni_mio] (ni_sync_ai_dma+0x15 [analogy_ni_mio])
:|  #*func                 129    0.409N native_irqs_disabled+0x3 [analogy_ni_mio] (ipipe_test_and_stall_pipeline_head+0xe [analogy_ni_mio])
:|  #*func                 130    0.439N native_save_fl+0x3 (__ipipe_check_percpu_access+0xa)
:|  #*func                 130    0.405N a4l_mite_sync_input_dma+0x7 [analogy_ni_mite] (ni_sync_ai_dma+0x4d [analogy_ni_mio])
:|  #*func                 130    0.401N a4l_mite_bytes_written_to_memory_lb+0x5 [analogy_ni_mite] (a4l_mite_sync_input_dma+0x15 [analogy_ni_mite])
:|  #*func                 131+   1.166N mite_device_bytes_transferred+0x3 [analogy_ni_mite] (a4l_mite_bytes_written_to_memory_lb+0x11 [analogy_ni_mite])
:|  #*func                 132+   1.185N a4l_mite_bytes_in_transit+0x3 [analogy_ni_mite] (a4l_mite_bytes_written_to_memory_lb+0x1a [analogy_ni_mite])
:|  #*func                 133    0.401N a4l_mite_bytes_written_to_memory_ub+0x5 [analogy_ni_mite] (a4l_mite_sync_input_dma+0x1e [analogy_ni_mite])
:|  #*func                 134+   1.174N a4l_mite_bytes_in_transit+0x3 [analogy_ni_mite] (a4l_mite_bytes_written_to_memory_ub+0x11 [analogy_ni_mite])
:|  #*func                 135+   1.181N mite_device_bytes_transferred+0x3 [analogy_ni_mite] (a4l_mite_bytes_written_to_memory_ub+0x1a [analogy_ni_mite])
:|  #*func                 136    0.409N a4l_buf_prepare_absput+0x5 [xeno_analogy] (a4l_mite_sync_input_dma+0x27 [analogy_ni_mite])
:|  #*func                 136    0.409N a4l_buf_commit_absput+0x5 [xeno_analogy] (a4l_mite_sync_input_dma+0x47 [analogy_ni_mite])
:|  #*func                 137    0.412N __abs_put+0x6 [xeno_analogy] (a4l_buf_commit_absput+0x2f [xeno_analogy])
:|  #*func                 137    0.401N ipipe_restore_pipeline_head+0x5 [analogy_ni_mio] (ni_sync_ai_dma+0x5d [analogy_ni_mio])
:|  #*func                 137    0.409N native_irqs_disabled+0x3 [analogy_ni_mio] (ipipe_restore_pipeline_head+0x11 [analogy_ni_mio])
:|  #*func                 138    0.431N native_save_fl+0x3 (__ipipe_check_percpu_access+0xa)
:|  #*func                 138    0.405N a4l_udelay+0x3 [analogy_ni_mio] (a4l_ni_E_interrupt+0x40b [analogy_ni_mio])
:|  #*func                 139    0.435N rtdm_task_busy_sleep+0x7 [xeno_rtdm] (a4l_udelay+0x14 [analogy_ni_mio])
:|  #*func                 139    0.409N xnarch_ns_to_tsc+0x9 [xeno_nucleus] (rtdm_task_busy_sleep+0x21 [xeno_rtdm])
:|  #*func                 140    0.600N __rthal_x86_nodiv_ullimd+0x8 [xeno_nucleus] (xnarch_ns_to_tsc+0x3f [xeno_nucleus])

:|  #*func                 140    0.405N ni_sync_ai_dma+0x6 [analogy_ni_mio] (a4l_ni_E_interrupt+0x401 [analogy_ni_mio])
:|  #*func                 141    0.405N ipipe_test_and_stall_pipeline_head+0x4 [analogy_ni_mio] (ni_sync_ai_dma+0x15 [analogy_ni_mio])
:|  #*func                 141    0.409N native_irqs_disabled+0x3 [analogy_ni_mio] (ipipe_test_and_stall_pipeline_head+0xe [analogy_ni_mio])
:|  #*func                 141    0.439N native_save_fl+0x3 (__ipipe_check_percpu_access+0xa)
:|  #*func                 142    0.405N a4l_mite_sync_input_dma+0x7 [analogy_ni_mite] (ni_sync_ai_dma+0x4d [analogy_ni_mio])
:|  #*func                 142    0.401N a4l_mite_bytes_written_to_memory_lb+0x5 [analogy_ni_mite] (a4l_mite_sync_input_dma+0x15 [analogy_ni_mite])
:|  #*func                 143+   1.166N mite_device_bytes_transferred+0x3 [analogy_ni_mite] (a4l_mite_bytes_written_to_memory_lb+0x11 [analogy_ni_mite])
:|  #*func                 144+   1.185N a4l_mite_bytes_in_transit+0x3 [analogy_ni_mite] (a4l_mite_bytes_written_to_memory_lb+0x1a [analogy_ni_mite])
:|  #*func                 145    0.401N a4l_mite_bytes_written_to_memory_ub+0x5 [analogy_ni_mite] (a4l_mite_sync_input_dma+0x1e [analogy_ni_mite])
:|  #*func                 145+   1.181N a4l_mite_bytes_in_transit+0x3 [analogy_ni_mite] (a4l_mite_bytes_written_to_memory_ub+0x11 [analogy_ni_mite])
:|  #*func                 147+   1.181N mite_device_bytes_transferred+0x3 [analogy_ni_mite] (a4l_mite_bytes_written_to_memory_ub+0x1a [analogy_ni_mite])
:|  #*func                 148    0.409N a4l_buf_prepare_absput+0x5 [xeno_analogy] (a4l_mite_sync_input_dma+0x27 [analogy_ni_mite])
:|  #*func                 148    0.409N a4l_buf_commit_absput+0x5 [xeno_analogy] (a4l_mite_sync_input_dma+0x47 [analogy_ni_mite])
:|  #*func                 149    0.412N __abs_put+0x6 [xeno_analogy] (a4l_buf_commit_absput+0x2f [xeno_analogy])
:|  #*func                 149    0.401N ipipe_restore_pipeline_head+0x5 [analogy_ni_mio] (ni_sync_ai_dma+0x5d [analogy_ni_mio])
:|  #*func                 149    0.409N native_irqs_disabled+0x3 [analogy_ni_mio] (ipipe_restore_pipeline_head+0x11 [analogy_ni_mio])
:|  #*func                 150    0.431N native_save_fl+0x3 (__ipipe_check_percpu_access+0xa)
:|  #*func                 150    0.405N a4l_udelay+0x3 [analogy_ni_mio] (a4l_ni_E_interrupt+0x40b [analogy_ni_mio])
:|  #*func                 151    0.435N rtdm_task_busy_sleep+0x7 [xeno_rtdm] (a4l_udelay+0x14 [analogy_ni_mio])
:|  #*func                 151    0.409N xnarch_ns_to_tsc+0x9 [xeno_nucleus] (rtdm_task_busy_sleep+0x21 [xeno_rtdm])
:|  #*func                 151    0.600N __rthal_x86_nodiv_ullimd+0x8 [xeno_nucleus] (xnarch_ns_to_tsc+0x3f [xeno_nucleus])

:|  #*func                 152    0.405N ni_sync_ai_dma+0x6 [analogy_ni_mio] (a4l_ni_E_interrupt+0x401 [analogy_ni_mio])
:|  #*func                 152    0.405N ipipe_test_and_stall_pipeline_head+0x4 [analogy_ni_mio] (ni_sync_ai_dma+0x15 [analogy_ni_mio])
:|  #*func                 153    0.409N native_irqs_disabled+0x3 [analogy_ni_mio] (ipipe_test_and_stall_pipeline_head+0xe [analogy_ni_mio])
:|  #*func                 153    0.439N native_save_fl+0x3 (__ipipe_check_percpu_access+0xa)
:|  #*func                 154    0.405N a4l_mite_sync_input_dma+0x7 [analogy_ni_mite] (ni_sync_ai_dma+0x4d [analogy_ni_mio])
:|  #*func                 154    0.405N a4l_mite_bytes_written_to_memory_lb+0x5 [analogy_ni_mite] (a4l_mite_sync_input_dma+0x15 [analogy_ni_mite])
:|  #*func                 155+   1.178N mite_device_bytes_transferred+0x3 [analogy_ni_mite] (a4l_mite_bytes_written_to_memory_lb+0x11 [analogy_ni_mite])
:|  #*func                 156+   1.178N a4l_mite_bytes_in_transit+0x3 [analogy_ni_mite] (a4l_mite_bytes_written_to_memory_lb+0x1a [analogy_ni_mite])
:|  #*func                 157    0.401N a4l_mite_bytes_written_to_memory_ub+0x5 [analogy_ni_mite] (a4l_mite_sync_input_dma+0x1e [analogy_ni_mite])
:|  #*func                 157+   1.181N a4l_mite_bytes_in_transit+0x3 [analogy_ni_mite] (a4l_mite_bytes_written_to_memory_ub+0x11 [analogy_ni_mite])
:|  #*func                 158+   1.181N mite_device_bytes_transferred+0x3 [analogy_ni_mite] (a4l_mite_bytes_written_to_memory_ub+0x1a [analogy_ni_mite])
:|  #*func                 160    0.409N a4l_buf_prepare_absput+0x5 [xeno_analogy] (a4l_mite_sync_input_dma+0x27 [analogy_ni_mite])
:|  #*func                 160    0.409N a4l_buf_commit_absput+0x5 [xeno_analogy] (a4l_mite_sync_input_dma+0x47 [analogy_ni_mite])
:|  #*func                 160    0.412N __abs_put+0x6 [xeno_analogy] (a4l_buf_commit_absput+0x2f [xeno_analogy])
:|  #*func                 161    0.401N ipipe_restore_pipeline_head+0x5 [analogy_ni_mio] (ni_sync_ai_dma+0x5d [analogy_ni_mio])
:|  #*func                 161    0.409N native_irqs_disabled+0x3 [analogy_ni_mio] (ipipe_restore_pipeline_head+0x11 [analogy_ni_mio])
:|  #*func                 162    0.435N native_save_fl+0x3 (__ipipe_check_percpu_access+0xa)
:|  #*func                 162    0.412N a4l_udelay+0x3 [analogy_ni_mio] (a4l_ni_E_interrupt+0x40b [analogy_ni_mio])
:|  #*func                 163    0.439N rtdm_task_busy_sleep+0x7 [xeno_rtdm] (a4l_udelay+0x14 [analogy_ni_mio])
:|  #*func                 163    0.412N xnarch_ns_to_tsc+0x9 [xeno_nucleus] (rtdm_task_busy_sleep+0x21 [xeno_rtdm])
:|  #*func                 163    0.619N __rthal_x86_nodiv_ullimd+0x8 [xeno_nucleus] (xnarch_ns_to_tsc+0x3f [xeno_nucleus])
:|  #*func                 164    0.412N ni_event+0x4 [analogy_ni_mio] (a4l_ni_E_interrupt+0x42e [analogy_ni_mio])
:|  #*func                 164    0.409N a4l_buf_evt+0x7 [xeno_analogy] (ni_event+0x29 [analogy_ni_mio])
:|  #*func                 165    0.412N __count_to_get+0x3 [xeno_analogy] (a4l_buf_evt+0x3a [xeno_analogy])
:|  #*func                 165    0.420N a4l_signal_sync+0x4 [xeno_analogy] (a4l_buf_evt+0x96 [xeno_analogy])
:|  #*func                 166    0.405N rtdm_event_signal+0x6 [xeno_rtdm] (a4l_signal_sync+0x24 [xeno_analogy])
:|  #*func                 166    0.409N __xnlock_get_irqsave.constprop.6+0x9 [xeno_rtdm] (rtdm_event_signal+0x1c [xeno_rtdm])
:|  #*func                 167    0.431N native_irqs_disabled+0x3 [xeno_rtdm] (__xnlock_get_irqsave.constprop.6+0x17 [xeno_rtdm])
:|  #*func                 167    0.510N native_save_fl+0x3 (__ipipe_check_percpu_access+0xa)
:|  #*func                 167    0.409N xnsynch_flush+0x9 [xeno_nucleus] (rtdm_event_signal+0x30 [xeno_rtdm])
:|  #*func                 168    0.405N __xnlock_get_irqsave.constprop.1+0x9 [xeno_nucleus] (xnsynch_flush+0x21 [xeno_nucleus])
:|  #*func                 168    0.409N native_irqs_disabled+0x3 [xeno_nucleus] (__xnlock_get_irqsave.constprop.1+0x17 [xeno_nucleus])
:|  #*func                 169    0.439N native_save_fl+0x3 (__ipipe_check_percpu_access+0xa)
:|  #*func                 169    0.420N getpq+0x4 [xeno_nucleus] (xnsynch_flush+0x59 [xeno_nucleus])
:|  #*func                 170    0.405N xnpod_resume_thread+0x9 [xeno_nucleus] (xnsynch_flush+0x51 [xeno_nucleus])
:|  #*func                 170    0.401N __xnlock_get_irqsave.constprop.11+0x9 [xeno_nucleus] (xnpod_resume_thread+0x26 [xeno_nucleus])
:|  #*func                 170    0.405N ipipe_test_and_stall_pipeline_head+0x4 [xeno_nucleus] (__xnlock_get_irqsave.constprop.11+0x1b [xeno_nucleus])
:|  #*func                 171    0.405N native_irqs_disabled+0x3 [xeno_nucleus] (ipipe_test_and_stall_pipeline_head+0xe [xeno_nucleus])
:|  #*func                 171    0.409N native_save_fl+0x3 [xeno_nucleus] (native_irqs_disabled+0xd [xeno_nucleus])
:|  #*func                 172    0.435N native_save_fl+0x3 (__ipipe_check_percpu_access+0xa)
:|  #*[27056] -<?>-   90   172    0.427N xnpod_resume_thread+0x48 [xeno_nucleus] (xnsynch_flush+0x51 [xeno_nucleus])
:|  #*func                 172    0.420N xnsched_rt_enqueue+0x5 [xeno_nucleus] (xnpod_resume_thread+0x172 [xeno_nucleus])
:|  #*func                 173    0.405N xnlock_put_irqrestore.constprop.9+0x9 [xeno_nucleus] (xnpod_resume_thread+0x1c0 [xeno_nucleus])
:|  #*func                 173    0.405N ipipe_restore_pipeline_head+0x5 [xeno_nucleus] (xnlock_put_irqrestore.constprop.9+0x16a [xeno_nucleus])
:|  #*func                 174    0.401N native_irqs_disabled+0x3 [xeno_nucleus] (ipipe_restore_pipeline_head+0x11 [xeno_nucleus])
:|  #*func                 174    0.412N native_save_fl+0x3 [xeno_nucleus] (native_irqs_disabled+0xd [xeno_nucleus])
:|  #*func                 174    0.431N native_save_fl+0x3 (__ipipe_check_percpu_access+0xa)
:|  #*func                 175    0.405N getpq+0x4 [xeno_nucleus] (xnsynch_flush+0x59 [xeno_nucleus])
:|  #*func                 175    0.405N xnlock_put_irqrestore.constprop.0+0x9 [xeno_nucleus] (xnsynch_flush+0x7a [xeno_nucleus])
:|  #*func                 176    0.409N native_irqs_disabled+0x3 [xeno_nucleus] (xnlock_put_irqrestore.constprop.0+0x16e [xeno_nucleus])
:|  #*func                 176    0.427N native_save_fl+0x3 (__ipipe_check_percpu_access+0xa)
:|  #*func                 177    0.405N xnselect_signal+0x3 [xeno_rtdm] (rtdm_event_signal+0x3f [xeno_rtdm])
:|  #*func                 177    0.409N xnpod_schedule+0x3 [xeno_rtdm] (rtdm_event_signal+0x4c [xeno_rtdm])
:|  #*func                 177    0.446N xnlock_put_irqrestore.constprop.5+0x9 [xeno_rtdm] (rtdm_event_signal+0x53 [xeno_rtdm])
:|  #*func                 178    0.412N native_irqs_disabled+0x3 [xeno_rtdm] (xnlock_put_irqrestore.constprop.5+0x16e [xeno_rtdm])
:|  #*func                 178    0.461N native_save_fl+0x3 (__ipipe_check_percpu_access+0xa)
:|  #*func                 179+   1.467N m_series_stc_readw+0x6 [analogy_ni_pcimio] (a4l_ni_E_interrupt+0x43e [analogy_ni_mio])
:|  #*func                 180    0.420N a4l_ni_tio_handle_interrupt+0x9 [analogy_ni_tio] (a4l_ni_E_interrupt+0x540 [analogy_ni_mio])
:|  #*func                 181    0.401N a4l_get_subd+0x9 [xeno_analogy] (a4l_ni_tio_handle_interrupt+0x23 [analogy_ni_tio])
:|  #*func                 181    0.409N prefetch+0x3 [xeno_analogy] (a4l_get_subd+0x2f [xeno_analogy])
:|  #*func                 181    0.405N prefetch+0x3 [xeno_analogy] (a4l_get_subd+0x2f [xeno_analogy])
:|  #*func                 182    0.405N prefetch+0x3 [xeno_analogy] (a4l_get_subd+0x2f [xeno_analogy])
:|  #*func                 182    0.409N prefetch+0x3 [xeno_analogy] (a4l_get_subd+0x2f [xeno_analogy])
:|  #*func                 183    0.405N prefetch+0x3 [xeno_analogy] (a4l_get_subd+0x2f [xeno_analogy])
:|  #*func                 183    0.409N prefetch+0x3 [xeno_analogy] (a4l_get_subd+0x2f [xeno_analogy])
:|  #*func                 183    0.405N prefetch+0x3 [xeno_analogy] (a4l_get_subd+0x2f [xeno_analogy])
:|  #*func                 184    0.405N prefetch+0x3 [xeno_analogy] (a4l_get_subd+0x2f [xeno_analogy])
:|  #*func                 184    0.409N prefetch+0x3 [xeno_analogy] (a4l_get_subd+0x2f [xeno_analogy])
:|  #*func                 185    0.405N prefetch+0x3 [xeno_analogy] (a4l_get_subd+0x2f [xeno_analogy])
:|  #*func                 185    0.405N prefetch+0x3 [xeno_analogy] (a4l_get_subd+0x2f [xeno_analogy])
:|  #*func                 185    0.409N prefetch+0x3 [xeno_analogy] (a4l_get_subd+0x2f [xeno_analogy])
:|  #*func                 186    0.405N prefetch+0x3 [xeno_analogy] (a4l_get_subd+0x2f [xeno_analogy])
:|  #*func                 186    0.405N prefetch+0x3 [xeno_analogy] (a4l_get_subd+0x2f [xeno_analogy])
:|  #*func                 187    0.416N prefetch+0x3 [xeno_analogy] (a4l_get_subd+0x2f [xeno_analogy])

:|  #*func                 187    0.401N a4l_ni_tio_acknowledge_and_confirm+0x9 [analogy_ni_tio] (a4l_ni_tio_handle_interrupt+0x40 [analogy_ni_tio])
:|  #*func                 187    0.405N NITIO_Gxx_Status_Reg+0x3 [analogy_ni_tio] (a4l_ni_tio_acknowledge_and_confirm+0x1d [analogy_ni_tio])
:|  #*func                 188    0.405N read_register+0x3 [analogy_ni_tio] (a4l_ni_tio_acknowledge_and_confirm+0x26 [analogy_ni_tio])
:|  #*func                 188    0.405N ni_gpct_read_register+0x4 [analogy_ni_mio] (read_register+0x14 [analogy_ni_tio])
:|  #*func                 189    0.431N ni_gpct_to_stc_register+0x6 [analogy_ni_mio] (ni_gpct_read_register+0x80 [analogy_ni_mio])
:|  #*func                 189+   1.388N m_series_stc_readw+0x6 [analogy_ni_pcimio] (ni_gpct_read_register+0x8d [analogy_ni_mio])
:|  #*func                 191    0.409N read_register+0x3 [analogy_ni_tio] (a4l_ni_tio_acknowledge_and_confirm+0x65 [analogy_ni_tio])
:|  #*func                 191    0.405N ni_gpct_read_register+0x4 [analogy_ni_mio] (read_register+0x14 [analogy_ni_tio])
:|  #*func                 191    0.427N ni_gpct_to_stc_register+0x6 [analogy_ni_mio] (ni_gpct_read_register+0x80 [analogy_ni_mio])
:|  #*func                 192+   1.384N m_series_stc_readw+0x6 [analogy_ni_pcimio] (ni_gpct_read_register+0x8d [analogy_ni_mio])
:|  #*func                 193    0.424N NITIO_Gi_Mode_Reg+0x3 [analogy_ni_tio] (a4l_ni_tio_acknowledge_and_confirm+0x1db [analogy_ni_tio])
:|  #*func                 194    0.431N ni_tio_get_soft_copy+0x5 [analogy_ni_tio] (a4l_ni_tio_acknowledge_and_confirm+0x1e4 [analogy_ni_tio])
:|  #*func                 194    0.401N ipipe_test_and_stall_pipeline_head+0x4 [analogy_ni_tio] (ni_tio_get_soft_copy+0x1a [analogy_ni_tio])
:|  #*func                 194    0.412N native_irqs_disabled+0x3 [analogy_ni_tio] (ipipe_test_and_stall_pipeline_head+0xe [analogy_ni_tio])
:|  #*func                 195    0.450N native_save_fl+0x3 (__ipipe_check_percpu_access+0xa)
:|  #*func                 195    0.401N ipipe_restore_pipeline_head+0x5 [analogy_ni_tio] (ni_tio_get_soft_copy+0x48 [analogy_ni_tio])
:|  #*func                 196    0.409N native_irqs_disabled+0x3 [analogy_ni_tio] (ipipe_restore_pipeline_head+0x11 [analogy_ni_tio])
:|  #*func                 196    0.450N native_save_fl+0x3 (__ipipe_check_percpu_access+0xa)
:|  #*func                 197    0.405N read_register+0x3 [analogy_ni_tio] (a4l_ni_tio_handle_interrupt+0xc0 [analogy_ni_tio])
:|  #*func                 197+   1.365N ni_gpct_read_register+0x4 [analogy_ni_mio] (read_register+0x14 [analogy_ni_tio])
:|  #*func                 198    0.405N ipipe_test_and_stall_pipeline_head+0x4 [analogy_ni_tio] (a4l_ni_tio_handle_interrupt+0xea [analogy_ni_tio])
:|  #*func                 199    0.409N native_irqs_disabled+0x3 [analogy_ni_tio] (ipipe_test_and_stall_pipeline_head+0xe [analogy_ni_tio])
:|  #*func                 199    0.435N native_save_fl+0x3 (__ipipe_check_percpu_access+0xa)
:|  #*func                 200    0.401N ipipe_restore_pipeline_head+0x5 [analogy_ni_tio] (a4l_ni_tio_handle_interrupt+0x147 [analogy_ni_tio])
:|  #*func                 200    0.412N native_irqs_disabled+0x3 [analogy_ni_tio] (ipipe_restore_pipeline_head+0x11 [analogy_ni_tio])
:|  #*func                 200    0.435N native_save_fl+0x3 (__ipipe_check_percpu_access+0xa)
:|  #*func                 201    0.412N a4l_ni_tio_handle_interrupt+0x9 [analogy_ni_tio] (a4l_ni_E_interrupt+0x559 [analogy_ni_mio])
:|  #*func                 201    0.401N a4l_get_subd+0x9 [xeno_analogy] (a4l_ni_tio_handle_interrupt+0x23 [analogy_ni_tio])
:|  #*func                 202    0.405N prefetch+0x3 [xeno_analogy] (a4l_get_subd+0x2f [xeno_analogy])
:|  #*func                 202    0.405N prefetch+0x3 [xeno_analogy] (a4l_get_subd+0x2f [xeno_analogy])
:|  #*func                 202    0.405N prefetch+0x3 [xeno_analogy] (a4l_get_subd+0x2f [xeno_analogy])
:|  #*func                 203    0.405N prefetch+0x3 [xeno_analogy] (a4l_get_subd+0x2f [xeno_analogy])
:|  #*func                 203    0.409N prefetch+0x3 [xeno_analogy] (a4l_get_subd+0x2f [xeno_analogy])
:|  #*func                 204    0.405N prefetch+0x3 [xeno_analogy] (a4l_get_subd+0x2f [xeno_analogy])
:|  #*func                 204    0.405N prefetch+0x3 [xeno_analogy] (a4l_get_subd+0x2f [xeno_analogy])
:|  #*func                 204    0.405N prefetch+0x3 [xeno_analogy] (a4l_get_subd+0x2f [xeno_analogy])
:|  #*func                 205    0.405N prefetch+0x3 [xeno_analogy] (a4l_get_subd+0x2f [xeno_analogy])
:|  #*func                 205    0.405N prefetch+0x3 [xeno_analogy] (a4l_get_subd+0x2f [xeno_analogy])
:|  #*func                 206    0.405N prefetch+0x3 [xeno_analogy] (a4l_get_subd+0x2f [xeno_analogy])
:|  #*func                 206    0.405N prefetch+0x3 [xeno_analogy] (a4l_get_subd+0x2f [xeno_analogy])
:|  #*func                 206    0.409N prefetch+0x3 [xeno_analogy] (a4l_get_subd+0x2f [xeno_analogy])
:|  #*func                 207    0.405N prefetch+0x3 [xeno_analogy] (a4l_get_subd+0x2f [xeno_analogy])
:|  #*func                 207    0.412N prefetch+0x3 [xeno_analogy] (a4l_get_subd+0x2f [xeno_analogy])

:|  #*func                 208    0.405N a4l_ni_tio_acknowledge_and_confirm+0x9 [analogy_ni_tio] (a4l_ni_tio_handle_interrupt+0x40 [analogy_ni_tio])
:|  #*func                 208    0.401N NITIO_Gxx_Status_Reg+0x3 [analogy_ni_tio] (a4l_ni_tio_acknowledge_and_confirm+0x1d [analogy_ni_tio])
:|  #*func                 209    0.405N read_register+0x3 [analogy_ni_tio] (a4l_ni_tio_acknowledge_and_confirm+0x26 [analogy_ni_tio])
:|  #*func                 209    0.409N ni_gpct_read_register+0x4 [analogy_ni_mio] (read_register+0x14 [analogy_ni_tio])
:|  #*func                 209    0.424N ni_gpct_to_stc_register+0x6 [analogy_ni_mio] (ni_gpct_read_register+0x80 [analogy_ni_mio])
:|  #*func                 210+   1.399N m_series_stc_readw+0x6 [analogy_ni_pcimio] (ni_gpct_read_register+0x8d [analogy_ni_mio])
:|  #*func                 211    0.405N read_register+0x3 [analogy_ni_tio] (a4l_ni_tio_acknowledge_and_confirm+0x65 [analogy_ni_tio])
:|  #*func                 212    0.405N ni_gpct_read_register+0x4 [analogy_ni_mio] (read_register+0x14 [analogy_ni_tio])
:|  #*func                 212    0.427N ni_gpct_to_stc_register+0x6 [analogy_ni_mio] (ni_gpct_read_register+0x80 [analogy_ni_mio])
:|  #*func                 212+   1.384N m_series_stc_readw+0x6 [analogy_ni_pcimio] (ni_gpct_read_register+0x8d [analogy_ni_mio])
:|  #*func                 214    0.405N NITIO_Gi_Mode_Reg+0x3 [analogy_ni_tio] (a4l_ni_tio_acknowledge_and_confirm+0x1db [analogy_ni_tio])
:|  #*func                 214    0.405N ni_tio_get_soft_copy+0x5 [analogy_ni_tio] (a4l_ni_tio_acknowledge_and_confirm+0x1e4 [analogy_ni_tio])
:|  #*func                 215    0.401N ipipe_test_and_stall_pipeline_head+0x4 [analogy_ni_tio] (ni_tio_get_soft_copy+0x1a [analogy_ni_tio])
:|  #*func                 215    0.409N native_irqs_disabled+0x3 [analogy_ni_tio] (ipipe_test_and_stall_pipeline_head+0xe [analogy_ni_tio])
:|  #*func                 215    0.435N native_save_fl+0x3 (__ipipe_check_percpu_access+0xa)
:|  #*func                 216    0.401N ipipe_restore_pipeline_head+0x5 [analogy_ni_tio] (ni_tio_get_soft_copy+0x48 [analogy_ni_tio])
:|  #*func                 216    0.412N native_irqs_disabled+0x3 [analogy_ni_tio] (ipipe_restore_pipeline_head+0x11 [analogy_ni_tio])
:|  #*func                 217    0.431N native_save_fl+0x3 (__ipipe_check_percpu_access+0xa)
:|  #*func                 217    0.405N read_register+0x3 [analogy_ni_tio] (a4l_ni_tio_handle_interrupt+0xc0 [analogy_ni_tio])
:|  #*func                 217+   1.369N ni_gpct_read_register+0x4 [analogy_ni_mio] (read_register+0x14 [analogy_ni_tio])
:|  #*func                 219    0.401N ipipe_test_and_stall_pipeline_head+0x4 [analogy_ni_tio] (a4l_ni_tio_handle_interrupt+0xea [analogy_ni_tio])
:|  #*func                 219    0.409N native_irqs_disabled+0x3 [analogy_ni_tio] (ipipe_test_and_stall_pipeline_head+0xe [analogy_ni_tio])
:|  #*func                 220    0.435N native_save_fl+0x3 (__ipipe_check_percpu_access+0xa)
:|  #*func                 220    0.405N ipipe_restore_pipeline_head+0x5 [analogy_ni_tio] (a4l_ni_tio_handle_interrupt+0x147 [analogy_ni_tio])
:|  #*func                 220    0.409N native_irqs_disabled+0x3 [analogy_ni_tio] (ipipe_restore_pipeline_head+0x11 [analogy_ni_tio])
:|  #*func                 221    0.435N native_save_fl+0x3 (__ipipe_check_percpu_access+0xa)
:|  #*func                 221    0.401N a4l_get_subd+0x9 [xeno_analogy] (a4l_ni_E_interrupt+0x565 [analogy_ni_mio])
:|  #*func                 222    0.405N prefetch+0x3 [xeno_analogy] (a4l_get_subd+0x2f [xeno_analogy])
:|  #*func                 222    0.405N prefetch+0x3 [xeno_analogy] (a4l_get_subd+0x2f [xeno_analogy])
:|  #*func                 223    0.405N prefetch+0x3 [xeno_analogy] (a4l_get_subd+0x2f [xeno_analogy])
:|  #*func                 223    0.405N prefetch+0x3 [xeno_analogy] (a4l_get_subd+0x2f [xeno_analogy])
:|  #*func                 223    0.409N prefetch+0x3 [xeno_analogy] (a4l_get_subd+0x2f [xeno_analogy])
:|  #*func                 224    0.405N prefetch+0x3 [xeno_analogy] (a4l_get_subd+0x2f [xeno_analogy])
:|  #*func                 224    0.405N prefetch+0x3 [xeno_analogy] (a4l_get_subd+0x2f [xeno_analogy])
:|  #*func                 225    0.405N prefetch+0x3 [xeno_analogy] (a4l_get_subd+0x2f [xeno_analogy])
:|  #*func                 225    0.405N prefetch+0x3 [xeno_analogy] (a4l_get_subd+0x2f [xeno_analogy])
:|  #*func                 225    0.405N prefetch+0x3 [xeno_analogy] (a4l_get_subd+0x2f [xeno_analogy])
:|  #*func                 226    0.405N prefetch+0x3 [xeno_analogy] (a4l_get_subd+0x2f [xeno_analogy])
:|  #*func                 226    0.405N prefetch+0x3 [xeno_analogy] (a4l_get_subd+0x2f [xeno_analogy])
:|  #*func                 227    0.409N prefetch+0x3 [xeno_analogy] (a4l_get_subd+0x2f [xeno_analogy])
:|  #*func                 227    0.405N prefetch+0x3 [xeno_analogy] (a4l_get_subd+0x2f [xeno_analogy])
:|  #*func                 227    0.412N prefetch+0x3 [xeno_analogy] (a4l_get_subd+0x2f [xeno_analogy])

:|  #*func                 228    0.405N ipipe_test_and_stall_pipeline_head+0x4 [analogy_ni_mio] (a4l_ni_E_interrupt+0x57e [analogy_ni_mio])
:|  #*func                 228    0.409N native_irqs_disabled+0x3 [analogy_ni_mio] (ipipe_test_and_stall_pipeline_head+0xe [analogy_ni_mio])
:|  #*func                 229    0.439N native_save_fl+0x3 (__ipipe_check_percpu_access+0xa)
:|  #*func                 229    0.401N ipipe_restore_pipeline_head+0x5 [analogy_ni_mio] (a4l_ni_E_interrupt+0x606 [analogy_ni_mio])
:|  #*func                 229    0.409N native_irqs_disabled+0x3 [analogy_ni_mio] (ipipe_restore_pipeline_head+0x11 [analogy_ni_mio])
:|  #*func                 230+   1.448N native_save_fl+0x3 (__ipipe_check_percpu_access+0xa)
:|  #*func                 231    0.424N a4l_buf_evt+0x7 [xeno_analogy] (a4l_ni_E_interrupt+0x67a [analogy_ni_mio])
:|  #*func                 232    0.401N ipipe_restore_pipeline_head+0x5 [analogy_ni_mio] (a4l_ni_E_interrupt+0x687 [analogy_ni_mio])
:|  #*func                 232    0.412N native_irqs_disabled+0x3 [analogy_ni_mio] (ipipe_restore_pipeline_head+0x11 [analogy_ni_mio])
:|  #*func                 233    0.514N native_save_fl+0x3 (__ipipe_check_percpu_access+0xa)
:|  #*func                 233    0.454N xnlock_put+0x9 [xeno_nucleus] (xnintr_shirq_handler+0xe0 [xeno_nucleus])
:|  #*func                 234    0.405N rthal_irq_end+0x5 (xnintr_shirq_handler+0x13d [xeno_nucleus])
:|  #*func                 234    0.405N irq_to_desc+0x3 (rthal_irq_end+0x1d)
:|  #*func                 234    0.405N irq_to_desc+0x3 (rthal_irq_end+0x28)
:|  #*func                 235    0.405N irq_to_desc+0x3 (rthal_irq_end+0x32)
:|  #*func                 235    0.427N __ipipe_end_fasteoi_irq+0x3 (rthal_irq_end+0x38)
:|  #*func                 236    0.405N unmask_ioapic_irq+0x3 (__ipipe_end_fasteoi_irq+0x16)
:|  #*func                 236    0.409N unmask_ioapic+0x7 (unmask_ioapic_irq+0x12)
:|  #*func                 236    0.405N __ipipe_spin_lock_irqsave+0x6 (unmask_ioapic+0x1a)
:|  #*func                 237    0.424N native_save_fl+0x3 (__ipipe_spin_lock_irqsave+0x12)
:|  #*func                 237    0.427N native_save_fl+0x3 (__ipipe_check_percpu_access+0xa)
:|  #*func                 238    0.442N native_save_fl+0x3 (__ipipe_check_percpu_access+0xa)
:|  #*func                 238    0.401N __io_apic_modify_irq+0x9 (unmask_ioapic+0x35)
:|  #*func                 239    0.405N io_apic_read+0x4 (__io_apic_modify_irq+0x25)
:|  #*func                 239+   1.497N io_apic_base+0x3 (io_apic_read+0x10)
:|  #*func                 240    0.446N io_apic_base+0x3 (__io_apic_modify_irq+0x36)
:|  #*func                 241    0.405N ipipe_irq_unlock+0x5 (unmask_ioapic+0x43)
:|  #*func                 241    0.431N native_save_fl+0x3 (__ipipe_check_percpu_access+0xa)
:|  #*func                 242    0.401N __ipipe_unlock_irq+0x9 (ipipe_irq_unlock+0x49)
:|  #*func                 242    0.439N native_irqs_disabled+0x3 (__ipipe_unlock_irq+0x18)
:|  #*func                 243    0.424N native_save_fl+0x3 (native_irqs_disabled+0xd)
:|  #*func                 243    0.457N test_and_clear_bit+0x3 (__ipipe_unlock_irq+0x4e)
:|  #*func                 243    0.559N __ipipe_spin_unlock_irqrestore+0x6 (unmask_ioapic+0x4f)
:|  #*func                 244    0.424N xnpod_schedule+0x3 [xeno_nucleus] (xnintr_shirq_handler+0x190 [xeno_nucleus])
:|  #*func                 244    0.409N __xnpod_schedule+0x9 [xeno_nucleus] (xnpod_schedule+0x37 [xeno_nucleus])
:|  #*func                 245    0.412N native_save_fl+0x3 [xeno_nucleus] (__xnpod_schedule+0x15 [xeno_nucleus])
:|  #*func                 245    0.446N native_save_fl+0x3 (__ipipe_check_percpu_access+0xa)
:|  #*func                 246    0.409N __xnlock_get_irqsave.constprop.11+0x9 [xeno_nucleus] (__xnpod_schedule+0xa2 [xeno_nucleus])
:|  #*func                 246    0.409N ipipe_test_and_stall_pipeline_head+0x4 [xeno_nucleus] (__xnlock_get_irqsave.constprop.11+0x1b [xeno_nucleus])
:|  #*func                 246    0.405N native_irqs_disabled+0x3 [xeno_nucleus] (ipipe_test_and_stall_pipeline_head+0xe [xeno_nucleus])
:|  #*func                 247    0.416N native_save_fl+0x3 [xeno_nucleus] (native_irqs_disabled+0xd [xeno_nucleus])
:|  #*func                 247    0.506N native_save_fl+0x3 (__ipipe_check_percpu_access+0xa)
:|  #*[    0] -<?>-   -1   248    0.409N __xnpod_schedule+0xca [xeno_nucleus] (xnpod_schedule+0x37 [xeno_nucleus])
:|  #*func                 248    0.420N __cpus_empty.constprop.10+0x3 [xeno_nucleus] (__xnpod_schedule+0xe0 [xeno_nucleus])
:|  #*func                 249    0.416N xnsched_pick_next+0x6 [xeno_nucleus] (__xnpod_schedule+0x129 [xeno_nucleus])
:|  #*func                 249    0.544N xnsched_rt_pick+0x4 [xeno_nucleus] (xnsched_pick_next+0x55 [xeno_nucleus])
:|  #*func                 250    0.446N native_save_fl+0x3 (__ipipe_check_percpu_access+0xa)
:|  #*func                 250    0.412N native_save_fl+0x3 [xeno_nucleus] (__xnpod_schedule+0x39b [xeno_nucleus])
:|  #*func                 250    0.401N native_irqs_disabled+0x3 [xeno_nucleus] (__xnpod_schedule+0x3c2 [xeno_nucleus])
:|  #*func                 251    0.656N native_save_fl+0x3 [xeno_nucleus] (native_irqs_disabled+0xd [xeno_nucleus])
:|  #*func                 252    0.649N __switch_to+0x9 (__xnpod_schedule+0x4e3 [xeno_nucleus])
:|  #*func                 252    0.450N native_save_fl+0x3 [xeno_nucleus] (__xnpod_schedule+0x519 [xeno_nucleus])
:|  #*func                 253    0.450N native_save_fl+0x3 (__ipipe_check_percpu_access+0xa)
:|  #*[27056] -<?>-   90   253    0.416N __xnpod_schedule+0x5b7 [xeno_nucleus] (xnpod_schedule+0x37 [xeno_nucleus])

:|  #*func                 253    0.412N __xnpod_switch_fpu+0x5 [xeno_nucleus] (__xnpod_schedule+0x680 [xeno_nucleus])
:|  #*func                 254    0.532N xnarch_save_fpu+0x3 [xeno_nucleus] (__xnpod_switch_fpu+0x41 [xeno_nucleus])
:|  #*func                 254    0.416N xnlock_put_irqrestore.constprop.9+0x9 [xeno_nucleus] (__xnpod_schedule+0x6ae [xeno_nucleus])
:|  #*func                 255    0.412N ipipe_restore_pipeline_head+0x5 [xeno_nucleus] (xnlock_put_irqrestore.constprop.9+0x16a [xeno_nucleus])
:|  #*func                 255    0.416N native_irqs_disabled+0x3 [xeno_nucleus] (ipipe_restore_pipeline_head+0x11 [xeno_nucleus])
:|  #*func                 256    0.416N native_save_fl+0x3 [xeno_nucleus] (native_irqs_disabled+0xd [xeno_nucleus])
:|  #*func                 256    0.472N native_save_fl+0x3 (__ipipe_check_percpu_access+0xa)
:|  #*func                 257    0.412N xnlock_put_irqrestore.constprop.9+0x9 [xeno_nucleus] (xnpod_suspend_thread+0x207 [xeno_nucleus])
:|  #*func                 257    0.409N ipipe_restore_pipeline_head+0x5 [xeno_nucleus] (xnlock_put_irqrestore.constprop.9+0x16a [xeno_nucleus])
:|  #*func                 257    0.409N native_irqs_disabled+0x3 [xeno_nucleus] (ipipe_restore_pipeline_head+0x11 [xeno_nucleus])
:|  #*func                 258    0.412N native_save_fl+0x3 [xeno_nucleus] (native_irqs_disabled+0xd [xeno_nucleus])
:|  #*func                 258    0.450N native_save_fl+0x3 (__ipipe_check_percpu_access+0xa)
:|  #*func                 259    0.405N xnlock_put_irqrestore.constprop.0+0x9 [xeno_nucleus] (xnsynch_sleep_on+0xb9 [xeno_nucleus])
:|  #*func                 259    0.409N native_irqs_disabled+0x3 [xeno_nucleus] (xnlock_put_irqrestore.constprop.0+0x16e [xeno_nucleus])
:|  #*func                 259    0.442N native_save_fl+0x3 (__ipipe_check_percpu_access+0xa)
:|  #*func                 260    0.405N xnselect_signal+0x3 [xeno_rtdm] (rtdm_event_timedwait+0x132 [xeno_rtdm])
:|  #*func                 260    0.450N xnlock_put_irqrestore.constprop.5+0x9 [xeno_rtdm] (rtdm_event_timedwait+0x153 [xeno_rtdm])
:|  #*func                 261    0.409N native_irqs_disabled+0x3 [xeno_rtdm] (xnlock_put_irqrestore.constprop.5+0x16e [xeno_rtdm])
:|  #*func                 261    0.431N native_save_fl+0x3 (__ipipe_check_percpu_access+0xa)
:|  #*func                 262    0.405N __ipipe_restore_pipeline_head+0x7 (xnlock_put_irqrestore.constprop.5+0x1ee [xeno_rtdm])
:|  #*func                 262    0.427N native_save_fl+0x3 (__ipipe_check_percpu_access+0xa)
:|  +*func                 262    0.401N native_irqs_disabled+0x3 (__ipipe_restore_pipeline_head+0x114)
:|  +*func                 263    0.393N native_save_fl+0x3 (native_irqs_disabled+0xd)
:|  +*end     0x80000000   263    0.465N __ipipe_restore_pipeline_head+0x122 (xnlock_put_irqrestore.constprop.5+0x1ee [xeno_rtdm])































:   +*func                 264    0.401N __handle_event+0x3 [xeno_analogy] (a4l_read_buffer+0x8e [xeno_analogy])
:   +*func                 264    0.412N __count_to_get+0x3 [xeno_analogy] (a4l_read_buffer+0x98 [xeno_analogy])
:   +*func                 265    0.409N __munge+0x9 [xeno_analogy] (a4l_read_buffer+0xee [xeno_analogy])
:   +*func                 265    0.412N ni_ai_munge16+0x9 [analogy_ni_mio] (__munge+0x3f [xeno_analogy])
:   +*func                 265    0.634N a4l_get_chan+0x9 [xeno_analogy] (ni_ai_munge16+0x27 [analogy_ni_mio])
:   +*func                 266    0.397N __consume+0x9 [xeno_analogy] (a4l_read_buffer+0x103 [xeno_analogy])
:   +*func                 266    0.390N rtdm_safe_copy_to_user+0x6 [xeno_analogy] (__consume+0x69 [xeno_analogy])
:   +*func                 267    0.484N __copy_to_user_ll+0x6 (rtdm_safe_copy_to_user+0x36 [xeno_analogy])
:   +*func                 267    0.401N native_save_fl+0x3 [xeno_rtdm] (__rt_dev_read+0x53 [xeno_rtdm])
:|  +*begin   0x80000001   268    0.427  __rt_dev_read+0x6a [xeno_rtdm] (sys_rtdm_read+0x23 [xeno_rtdm])
:|  +*func                 268    0.393N ipipe_test_pipeline_from.constprop.2+0x4 [xeno_rtdm] (__rt_dev_read+0x6f [xeno_rtdm])
:|  +*func                 268    0.416N native_save_fl+0x3 (__ipipe_check_percpu_access+0xa)
:|  +*end     0x80000001   269    0.409N __rt_dev_read+0x84 [xeno_rtdm] (sys_rtdm_read+0x23 [xeno_rtdm])
:   +*func                 269    0.476N rtdm_context_unlock+0x7 [xeno_rtdm] (__rt_dev_read+0xc7 [xeno_rtdm])
:   +*func                 270    0.393N native_save_fl+0x3 (__ipipe_dispatch_event+0x17c)
:|  +*begin   0x80000001   270    0.427  __ipipe_dispatch_event+0x18f (__ipipe_syscall_root+0x57)
:|  +*func                 271    0.420N native_save_fl+0x3 (__ipipe_check_percpu_access+0xa)
:|  +*func                 271    0.412N native_save_fl+0x3 (__ipipe_check_percpu_access+0xa)
:|  +*end     0x80000001   271    0.420N __ipipe_dispatch_event+0x348 (__ipipe_syscall_root+0x57)
:   +*func                 272    0.409N native_save_fl+0x3 (__ipipe_syscall_root+0x5e)
:|  +*begin   0x80000001   272    0.420  __ipipe_syscall_root+0x76 (system_call+0x2d)
:|  +*func                 273    0.397N native_save_fl+0x3 (__ipipe_syscall_root+0x9d)
:|  +*func                 273    0.840N native_save_fl+0x3 (__ipipe_check_percpu_access+0xa)
:   +*func                 274    0.412N __ipipe_syscall_root+0x9 (system_call+0x2d)
:   +*func                 274    0.409N __ipipe_dispatch_event+0x9 (__ipipe_syscall_root+0x57)
:   +*func                 275    0.393N native_save_fl+0x3 (__ipipe_dispatch_event+0x19)
:|  +*begin   0x80000001   275    0.397N __ipipe_dispatch_event+0x2c (__ipipe_syscall_root+0x57)
:|  +*func                 276    0.416N native_save_fl+0x3 (__ipipe_check_percpu_access+0xa)
:|  +*func                 276    0.412N native_save_fl+0x3 (__ipipe_check_percpu_access+0xa)
:|  +*func                 276    0.409N native_save_fl+0x3 (__ipipe_check_percpu_access+0xa)
:|  +*end     0x80000001   277    0.409N __ipipe_dispatch_event+0x15d (__ipipe_syscall_root+0x57)
:   +*func                 277    0.439N hisyscall_event+0x9 [xeno_nucleus] (__ipipe_dispatch_event+0x16d)
:   +*func                 278    0.390N xnshadow_sys_trace+0x6 [xeno_nucleus] (hisyscall_event+0x12f [xeno_nucleus])
:   +*(0x42)  0x000013e4   278    0.401N xnshadow_sys_trace+0x8c [xeno_nucleus] (hisyscall_event+0x12f [xeno_nucleus])

--------------020906070902060004050708
Content-Type: text/plain;
 name="B"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="B"

:|   #end     0xffffff56     0    0.540N common_interrupt+0x40 (__ipipe_trace+0x4c7)
:    #func                   0    0.393N ipipe_check_context+0x9 (__ipipe_restore_root+0x15)
:    #func                   1    0.397N native_save_fl+0x3 (ipipe_check_context+0x15)
:|   #begin   0x80000001     1    0.465  ipipe_check_context+0x2d (__ipipe_restore_root+0x15)
:|   #func                   2    0.450N native_save_fl+0x3 (__ipipe_check_percpu_access+0xa)
:|   #func                   2    0.420N native_save_fl+0x3 (__ipipe_check_percpu_access+0xa)
:|   #end     0x80000001     3    0.435N ipipe_check_context+0xd9 (__ipipe_restore_root+0x15)
:    #func                   3    0.397N __ipipe_unstall_root+0x4 (__ipipe_restore_root+0x33)
:    #func                   3    0.386N native_irqs_disabled+0x3 (__ipipe_unstall_root+0xe)
:    #func                   4    0.393N native_save_fl+0x3 (native_irqs_disabled+0xd)
:|   #begin   0x80000000     4    0.420  __ipipe_unstall_root+0x1d (__ipipe_restore_root+0x33)
:|   #func                   5    0.393N ipipe_check_context+0x9 (__ipipe_unstall_root+0x2c)
:|   #func                   5    0.420N native_save_fl+0x3 (ipipe_check_context+0x15)
:|   #func                   5    0.424N native_save_fl+0x3 (__ipipe_check_percpu_access+0xa)
:|   #func                   6    0.446N native_save_fl+0x3 (__ipipe_check_percpu_access+0xa)
:|   #func                   6    0.409N native_save_fl+0x3 (__ipipe_check_percpu_access+0xa)
:|   +func                   7    0.409N native_irqs_disabled+0x3 (__ipipe_unstall_root+0x70)
:|   +func                   7    0.409N native_save_fl+0x3 (native_irqs_disabled+0xd)
:|   +end     0x80000000     8    0.480N __ipipe_unstall_root+0x7e (__ipipe_restore_root+0x33)
:    +func                   8    0.409N ipipe_check_context+0x9 (cpu_idle+0x4c)
:    +func                   8    0.405N native_save_fl+0x3 (ipipe_check_context+0x15)
:|   +begin   0x80000001     9    0.435  ipipe_check_context+0x2d (cpu_idle+0x4c)
:|   +func                   9    0.442N native_save_fl+0x3 (__ipipe_check_percpu_access+0xa)
:|   +func                  10    0.431N native_save_fl+0x3 (__ipipe_check_percpu_access+0xa)
:|   +end     0x80000001    10    0.484N ipipe_check_context+0xd9 (cpu_idle+0x4c)
:    #func                  11    0.435N default_idle+0x3 (cpu_idle+0x65)
:    #func                  11    0.420N trace_power_start.constprop.10+0x7 (default_idle+0x2b)
:    #func                  12    0.416N trace_cpu_idle+0x6 (default_idle+0x3c)
:    #func                  12    0.401N need_resched+0x3 (default_idle+0x51)
:    #func                  12    0.386N __ipipe_halt_root+0x4 (default_idle+0x5a)
:    #func                  13    0.405N native_save_fl+0x3 (__ipipe_halt_root+0xe)
:|   #begin   0x80000000    13    0.424  __ipipe_halt_root+0x1e (default_idle+0x5a)
:|   #func                  14    0.416N native_save_fl+0x3 (__ipipe_check_percpu_access+0xa)
:|   +end     0x8000000e    14!  11.711N __ipipe_halt_root+0x83 (default_idle+0x5a)








:|   +begin   0xffffff56    26    0.581  common_interrupt+0x2f (__ipipe_halt_root+0x85)
:|   +func                  26    0.547N __ipipe_handle_irq+0x9 (common_interrupt+0x36)
:|   +func                  27    0.551N native_save_fl+0x3 (__ipipe_handle_irq+0x41)
:|   +func                  27    0.585N native_save_fl+0x3 (__ipipe_check_percpu_access+0xa)
:|   +func                  28    0.544N irq_to_desc+0x3 (__ipipe_handle_irq+0xec)
:|   +func                  28    0.536N __ipipe_ack_fasteoi_irq+0x3 (__ipipe_handle_irq+0xf2)
:|   +func                  29    0.544N ack_apic_level+0x7 (__ipipe_ack_fasteoi_irq+0x16)
:|   +func                  30    0.532N apic_read+0x3 (ack_apic_level+0x24)
:|   +func                  30    0.562N native_apic_mem_read+0x3 (apic_read+0x14)
:|   +func                  31    0.529N __io_apic_modify_irq+0x9 (ack_apic_level+0xc3)
:|   +func                  31    0.532N io_apic_read+0x4 (__io_apic_modify_irq+0x25)
:|   +func                  32+   1.624N io_apic_base+0x3 (io_apic_read+0x10)
:|   +func                  33    0.559N io_apic_base+0x3 (__io_apic_modify_irq+0x36)
:|   +func                  34    0.529N io_apic_sync+0x3 (__io_apic_modify_irq+0x52)
:|   +func                  34+   1.380N io_apic_base+0x3 (io_apic_sync+0xf)
:|   +func                  36    0.532N apic_write+0x3 (ack_apic_level+0xdc)
:|   +func                  36    0.551N native_apic_mem_write+0x3 (apic_write+0x14)
:|   +func                  37    0.532N __ipipe_dispatch_wired+0x6 (__ipipe_handle_irq+0xff)
:|   +func                  37    0.585N native_save_fl+0x3 (__ipipe_check_percpu_access+0xa)
:|   +func                  38    0.532N __ipipe_dispatch_wired_nocheck+0x9 (__ipipe_dispatch_wired+0x62)
:|   +func                  39    0.566N native_save_fl+0x3 (__ipipe_check_percpu_access+0xa)
:|   +func                  39    0.562N native_save_fl+0x3 (__ipipe_check_percpu_access+0xa)
:|   +func                  40    0.634N native_save_fl+0x3 (__ipipe_check_percpu_access+0xa)
:|  # func                  40    0.611N xnintr_shirq_handler+0x9 [xeno_nucleus] (__ipipe_dispatch_wired_nocheck+0xe1)
:|  # func                  41    0.645N __xnlock_get.constprop.2+0x9 [xeno_nucleus] (xnintr_shirq_handler+0x5f [xeno_nucleus])

:|  # func                  42    0.525N a4l_handle_irq+0x3 [xeno_analogy] (xnintr_shirq_handler+0x70 [xeno_nucleus])
:|  # func                  42    0.529N a4l_ni_E_interrupt+0x9 [analogy_ni_mio] (a4l_handle_irq+0x13 [xeno_analogy])
:|  # func                  43    0.514N ipipe_test_and_stall_pipeline_head+0x4 [analogy_ni_mio] (a4l_ni_E_interrupt+0x29 [analogy_ni_mio])
:|  # func                  43    0.536N native_irqs_disabled+0x3 [analogy_ni_mio] (ipipe_test_and_stall_pipeline_head+0xe [analogy_ni_mio])
:|  # func                  44    0.559N native_save_fl+0x3 (__ipipe_check_percpu_access+0xa)
:|  # func                  44+   1.545N m_series_stc_readw+0x6 [analogy_ni_pcimio] (a4l_ni_E_interrupt+0x50 [analogy_ni_mio])
:|  # func                  46+   1.542N m_series_stc_readw+0x6 [analogy_ni_pcimio] (a4l_ni_E_interrupt+0x64 [analogy_ni_mio])
:|  # func                  47    0.570N native_save_fl+0x3 (__ipipe_check_percpu_access+0xa)
:|  # func                  48    0.521N a4l_mite_get_status+0x6 [analogy_ni_mite] (a4l_ni_E_interrupt+0x1c9 [analogy_ni_mio])
:|  # func                  48    0.514N ipipe_test_and_stall_pipeline_head+0x4 [analogy_ni_mite] (a4l_mite_get_status+0x14 [analogy_ni_mite])
:|  # func                  49    0.525N native_irqs_disabled+0x3 [analogy_ni_mite] (ipipe_test_and_stall_pipeline_head+0xe [analogy_ni_mite])
:|  # func                  49+   1.369N native_save_fl+0x3 (__ipipe_check_percpu_access+0xa)
:|  # func                  51    0.514N ipipe_restore_pipeline_head+0x5 [analogy_ni_mite] (a4l_mite_get_status+0x6e [analogy_ni_mite])
:|  # func                  51    0.536N native_irqs_disabled+0x3 [analogy_ni_mite] (ipipe_restore_pipeline_head+0x11 [analogy_ni_mite])
:|  # func                  52    0.611N native_save_fl+0x3 (__ipipe_check_percpu_access+0xa)
:|  # func                  52    0.566N m_series_stc_writew+0x7 [analogy_ni_pcimio] (a4l_ni_E_interrupt+0x2b2 [analogy_ni_mio])
:|  # func                  53    0.514N a4l_get_subd+0x9 [xeno_analogy] (a4l_ni_E_interrupt+0x357 [analogy_ni_mio])
:|  # func                  54    0.521N prefetch+0x3 [xeno_analogy] (a4l_get_subd+0x2f [xeno_analogy])
:|  # func                  54    0.514N prefetch+0x3 [xeno_analogy] (a4l_get_subd+0x2f [xeno_analogy])
:|  # func                  55    0.521N prefetch+0x3 [xeno_analogy] (a4l_get_subd+0x2f [xeno_analogy])
:|  # func                  55    0.517N prefetch+0x3 [xeno_analogy] (a4l_get_subd+0x2f [xeno_analogy])
:|  # func                  56    0.514N prefetch+0x3 [xeno_analogy] (a4l_get_subd+0x2f [xeno_analogy])
:|  # func                  56    0.517N prefetch+0x3 [xeno_analogy] (a4l_get_subd+0x2f [xeno_analogy])
:|  # func                  57    0.514N prefetch+0x3 [xeno_analogy] (a4l_get_subd+0x2f [xeno_analogy])
:|  # func                  57    0.517N prefetch+0x3 [xeno_analogy] (a4l_get_subd+0x2f [xeno_analogy])
:|  # func                  58    0.514N prefetch+0x3 [xeno_analogy] (a4l_get_subd+0x2f [xeno_analogy])
:|  # func                  58    0.517N prefetch+0x3 [xeno_analogy] (a4l_get_subd+0x2f [xeno_analogy])
:|  # func                  59    0.514N prefetch+0x3 [xeno_analogy] (a4l_get_subd+0x2f [xeno_analogy])
:|  # func                  59    0.517N prefetch+0x3 [xeno_analogy] (a4l_get_subd+0x2f [xeno_analogy])
:|  # func                  60    0.514N prefetch+0x3 [xeno_analogy] (a4l_get_subd+0x2f [xeno_analogy])
:|  # func                  60    0.517N prefetch+0x3 [xeno_analogy] (a4l_get_subd+0x2f [xeno_analogy])
:|  # func                  61    0.529N prefetch+0x3 [xeno_analogy] (a4l_get_subd+0x2f [xeno_analogy])

:|  # func                  61    0.514N ni_sync_ai_dma+0x6 [analogy_ni_mio] (a4l_ni_E_interrupt+0x401 [analogy_ni_mio])
:|  # func                  62    0.514N ipipe_test_and_stall_pipeline_head+0x4 [analogy_ni_mio] (ni_sync_ai_dma+0x15 [analogy_ni_mio])
:|  # func                  62    0.517N native_irqs_disabled+0x3 [analogy_ni_mio] (ipipe_test_and_stall_pipeline_head+0xe [analogy_ni_mio])
:|  # func                  63    0.562N native_save_fl+0x3 (__ipipe_check_percpu_access+0xa)
:|  # func                  63    0.514N a4l_mite_sync_input_dma+0x7 [analogy_ni_mite] (ni_sync_ai_dma+0x4d [analogy_ni_mio])
:|  # func                  64    0.514N a4l_mite_bytes_written_to_memory_lb+0x5 [analogy_ni_mite] (a4l_mite_sync_input_dma+0x15 [analogy_ni_mite])
:|  # func                  64+   1.279N mite_device_bytes_transferred+0x3 [analogy_ni_mite] (a4l_mite_bytes_written_to_memory_lb+0x11 [analogy_ni_mite])
:|  # func                  66+   1.305N a4l_mite_bytes_in_transit+0x3 [analogy_ni_mite] (a4l_mite_bytes_written_to_memory_lb+0x1a [analogy_ni_mite])
:|  # func                  67    0.514N a4l_mite_bytes_written_to_memory_ub+0x5 [analogy_ni_mite] (a4l_mite_sync_input_dma+0x1e [analogy_ni_mite])
:|  # func                  68+   1.302N a4l_mite_bytes_in_transit+0x3 [analogy_ni_mite] (a4l_mite_bytes_written_to_memory_ub+0x11 [analogy_ni_mite])
:|  # func                  69+   1.298N mite_device_bytes_transferred+0x3 [analogy_ni_mite] (a4l_mite_bytes_written_to_memory_ub+0x1a [analogy_ni_mite])
:|  # func                  70    0.540N a4l_buf_prepare_absput+0x5 [xeno_analogy] (a4l_mite_sync_input_dma+0x27 [analogy_ni_mite])
:|  # func                  71    0.547N a4l_buf_commit_absput+0x5 [xeno_analogy] (a4l_mite_sync_input_dma+0x47 [analogy_ni_mite])
:|  # func                  71    0.577N __abs_put+0x6 [xeno_analogy] (a4l_buf_commit_absput+0x2f [xeno_analogy])
:|  # func                  72    0.514N ipipe_restore_pipeline_head+0x5 [analogy_ni_mio] (ni_sync_ai_dma+0x5d [analogy_ni_mio])
:|  # func                  72    0.536N native_irqs_disabled+0x3 [analogy_ni_mio] (ipipe_restore_pipeline_head+0x11 [analogy_ni_mio])
:|  # func                  73    0.547N native_save_fl+0x3 (__ipipe_check_percpu_access+0xa)
:|  # func                  73    0.514N a4l_udelay+0x3 [analogy_ni_mio] (a4l_ni_E_interrupt+0x40b [analogy_ni_mio])
:|  # func                  74    0.555N rtdm_task_busy_sleep+0x7 [xeno_rtdm] (a4l_udelay+0x14 [analogy_ni_mio])
:|  # func                  75    0.517N xnarch_ns_to_tsc+0x9 [xeno_nucleus] (rtdm_task_busy_sleep+0x21 [xeno_rtdm])
:|  # func                  75    0.592N __rthal_x86_nodiv_ullimd+0x8 [xeno_nucleus] (xnarch_ns_to_tsc+0x3f [xeno_nucleus])

:|  # func                  76    0.514N ni_sync_ai_dma+0x6 [analogy_ni_mio] (a4l_ni_E_interrupt+0x401 [analogy_ni_mio])
:|  # func                  76    0.514N ipipe_test_and_stall_pipeline_head+0x4 [analogy_ni_mio] (ni_sync_ai_dma+0x15 [analogy_ni_mio])
:|  # func                  77    0.521N native_irqs_disabled+0x3 [analogy_ni_mio] (ipipe_test_and_stall_pipeline_head+0xe [analogy_ni_mio])
:|  # func                  77    0.559N native_save_fl+0x3 (__ipipe_check_percpu_access+0xa)
:|  # func                  78    0.514N a4l_mite_sync_input_dma+0x7 [analogy_ni_mite] (ni_sync_ai_dma+0x4d [analogy_ni_mio])
:|  # func                  78    0.514N a4l_mite_bytes_written_to_memory_lb+0x5 [analogy_ni_mite] (a4l_mite_sync_input_dma+0x15 [analogy_ni_mite])
:|  # func                  79+   1.309N mite_device_bytes_transferred+0x3 [analogy_ni_mite] (a4l_mite_bytes_written_to_memory_lb+0x11 [analogy_ni_mite])
:|  # func                  80+   1.305N a4l_mite_bytes_in_transit+0x3 [analogy_ni_mite] (a4l_mite_bytes_written_to_memory_lb+0x1a [analogy_ni_mite])
:|  # func                  81    0.514N a4l_mite_bytes_written_to_memory_ub+0x5 [analogy_ni_mite] (a4l_mite_sync_input_dma+0x1e [analogy_ni_mite])
:|  # func                  82+   1.309N a4l_mite_bytes_in_transit+0x3 [analogy_ni_mite] (a4l_mite_bytes_written_to_memory_ub+0x11 [analogy_ni_mite])
:|  # func                  83+   1.298N mite_device_bytes_transferred+0x3 [analogy_ni_mite] (a4l_mite_bytes_written_to_memory_ub+0x1a [analogy_ni_mite])
:|  # func                  84    0.521N a4l_buf_prepare_absput+0x5 [xeno_analogy] (a4l_mite_sync_input_dma+0x27 [analogy_ni_mite])
:|  # func                  85    0.514N a4l_buf_commit_absput+0x5 [xeno_analogy] (a4l_mite_sync_input_dma+0x47 [analogy_ni_mite])
:|  # func                  86    0.525N __abs_put+0x6 [xeno_analogy] (a4l_buf_commit_absput+0x2f [xeno_analogy])
:|  # func                  86    0.514N ipipe_restore_pipeline_head+0x5 [analogy_ni_mio] (ni_sync_ai_dma+0x5d [analogy_ni_mio])
:|  # func                  87    0.521N native_irqs_disabled+0x3 [analogy_ni_mio] (ipipe_restore_pipeline_head+0x11 [analogy_ni_mio])
:|  # func                  87    0.547N native_save_fl+0x3 (__ipipe_check_percpu_access+0xa)
:|  # func                  88    0.514N a4l_udelay+0x3 [analogy_ni_mio] (a4l_ni_E_interrupt+0x40b [analogy_ni_mio])
:|  # func                  88    0.555N rtdm_task_busy_sleep+0x7 [xeno_rtdm] (a4l_udelay+0x14 [analogy_ni_mio])
:|  # func                  89    0.517N xnarch_ns_to_tsc+0x9 [xeno_nucleus] (rtdm_task_busy_sleep+0x21 [xeno_rtdm])
:|  # func                  89    0.600N __rthal_x86_nodiv_ullimd+0x8 [xeno_nucleus] (xnarch_ns_to_tsc+0x3f [xeno_nucleus])

:|  # func                  90    0.547N ni_sync_ai_dma+0x6 [analogy_ni_mio] (a4l_ni_E_interrupt+0x401 [analogy_ni_mio])
:|  # func                  90    0.514N ipipe_test_and_stall_pipeline_head+0x4 [analogy_ni_mio] (ni_sync_ai_dma+0x15 [analogy_ni_mio])
:|  # func                  91    0.521N native_irqs_disabled+0x3 [analogy_ni_mio] (ipipe_test_and_stall_pipeline_head+0xe [analogy_ni_mio])
:|  # func                  91    0.559N native_save_fl+0x3 (__ipipe_check_percpu_access+0xa)
:|  # func                  92    0.514N a4l_mite_sync_input_dma+0x7 [analogy_ni_mite] (ni_sync_ai_dma+0x4d [analogy_ni_mio])
:|  # func                  92    0.514N a4l_mite_bytes_written_to_memory_lb+0x5 [analogy_ni_mite] (a4l_mite_sync_input_dma+0x15 [analogy_ni_mite])
:|  # func                  93+   1.294N mite_device_bytes_transferred+0x3 [analogy_ni_mite] (a4l_mite_bytes_written_to_memory_lb+0x11 [analogy_ni_mite])
:|  # func                  94+   1.298N a4l_mite_bytes_in_transit+0x3 [analogy_ni_mite] (a4l_mite_bytes_written_to_memory_lb+0x1a [analogy_ni_mite])
:|  # func                  96    0.514N a4l_mite_bytes_written_to_memory_ub+0x5 [analogy_ni_mite] (a4l_mite_sync_input_dma+0x1e [analogy_ni_mite])
:|  # func                  96+   1.279N a4l_mite_bytes_in_transit+0x3 [analogy_ni_mite] (a4l_mite_bytes_written_to_memory_ub+0x11 [analogy_ni_mite])
:|  # func                  97+   1.298N mite_device_bytes_transferred+0x3 [analogy_ni_mite] (a4l_mite_bytes_written_to_memory_ub+0x1a [analogy_ni_mite])
:|  # func                  99    0.521N a4l_buf_prepare_absput+0x5 [xeno_analogy] (a4l_mite_sync_input_dma+0x27 [analogy_ni_mite])
:|  # func                  99    0.514N a4l_buf_commit_absput+0x5 [xeno_analogy] (a4l_mite_sync_input_dma+0x47 [analogy_ni_mite])
:|  # func                 100    0.525N __abs_put+0x6 [xeno_analogy] (a4l_buf_commit_absput+0x2f [xeno_analogy])
:|  # func                 100    0.514N ipipe_restore_pipeline_head+0x5 [analogy_ni_mio] (ni_sync_ai_dma+0x5d [analogy_ni_mio])
:|  # func                 101    0.521N native_irqs_disabled+0x3 [analogy_ni_mio] (ipipe_restore_pipeline_head+0x11 [analogy_ni_mio])
:|  # func                 101    0.547N native_save_fl+0x3 (__ipipe_check_percpu_access+0xa)
:|  # func                 102    0.517N a4l_udelay+0x3 [analogy_ni_mio] (a4l_ni_E_interrupt+0x40b [analogy_ni_mio])
:|  # func                 102    0.555N rtdm_task_busy_sleep+0x7 [xeno_rtdm] (a4l_udelay+0x14 [analogy_ni_mio])
:|  # func                 103    0.517N xnarch_ns_to_tsc+0x9 [xeno_nucleus] (rtdm_task_busy_sleep+0x21 [xeno_rtdm])
:|  # func                 103    0.585N __rthal_x86_nodiv_ullimd+0x8 [xeno_nucleus] (xnarch_ns_to_tsc+0x3f [xeno_nucleus])

:|  # func                 104    0.514N ni_sync_ai_dma+0x6 [analogy_ni_mio] (a4l_ni_E_interrupt+0x401 [analogy_ni_mio])
:|  # func                 105    0.514N ipipe_test_and_stall_pipeline_head+0x4 [analogy_ni_mio] (ni_sync_ai_dma+0x15 [analogy_ni_mio])
:|  # func                 105    0.521N native_irqs_disabled+0x3 [analogy_ni_mio] (ipipe_test_and_stall_pipeline_head+0xe [analogy_ni_mio])
:|  # func                 106    0.559N native_save_fl+0x3 (__ipipe_check_percpu_access+0xa)
:|  # func                 106    0.517N a4l_mite_sync_input_dma+0x7 [analogy_ni_mite] (ni_sync_ai_dma+0x4d [analogy_ni_mio])
:|  # func                 107    0.510N a4l_mite_bytes_written_to_memory_lb+0x5 [analogy_ni_mite] (a4l_mite_sync_input_dma+0x15 [analogy_ni_mite])
:|  # func                 107+   1.305N mite_device_bytes_transferred+0x3 [analogy_ni_mite] (a4l_mite_bytes_written_to_memory_lb+0x11 [analogy_ni_mite])
:|  # func                 108+   1.302N a4l_mite_bytes_in_transit+0x3 [analogy_ni_mite] (a4l_mite_bytes_written_to_memory_lb+0x1a [analogy_ni_mite])
:|  # func                 110    0.514N a4l_mite_bytes_written_to_memory_ub+0x5 [analogy_ni_mite] (a4l_mite_sync_input_dma+0x1e [analogy_ni_mite])
:|  # func                 110+   1.313N a4l_mite_bytes_in_transit+0x3 [analogy_ni_mite] (a4l_mite_bytes_written_to_memory_ub+0x11 [analogy_ni_mite])
:|  # func                 112+   1.294N mite_device_bytes_transferred+0x3 [analogy_ni_mite] (a4l_mite_bytes_written_to_memory_ub+0x1a [analogy_ni_mite])
:|  # func                 113    0.521N a4l_buf_prepare_absput+0x5 [xeno_analogy] (a4l_mite_sync_input_dma+0x27 [analogy_ni_mite])
:|  # func                 113    0.517N a4l_buf_commit_absput+0x5 [xeno_analogy] (a4l_mite_sync_input_dma+0x47 [analogy_ni_mite])
:|  # func                 114    0.525N __abs_put+0x6 [xeno_analogy] (a4l_buf_commit_absput+0x2f [xeno_analogy])
:|  # func                 114    0.514N ipipe_restore_pipeline_head+0x5 [analogy_ni_mio] (ni_sync_ai_dma+0x5d [analogy_ni_mio])
:|  # func                 115    0.517N native_irqs_disabled+0x3 [analogy_ni_mio] (ipipe_restore_pipeline_head+0x11 [analogy_ni_mio])
:|  # func                 115    0.551N native_save_fl+0x3 (__ipipe_check_percpu_access+0xa)
:|  # func                 116    0.514N a4l_udelay+0x3 [analogy_ni_mio] (a4l_ni_E_interrupt+0x40b [analogy_ni_mio])
:|  # func                 117    0.555N rtdm_task_busy_sleep+0x7 [xeno_rtdm] (a4l_udelay+0x14 [analogy_ni_mio])
:|  # func                 117    0.517N xnarch_ns_to_tsc+0x9 [xeno_nucleus] (rtdm_task_busy_sleep+0x21 [xeno_rtdm])
:|  # func                 118    0.585N __rthal_x86_nodiv_ullimd+0x8 [xeno_nucleus] (xnarch_ns_to_tsc+0x3f [xeno_nucleus])

:|  # func                 118    0.514N ni_sync_ai_dma+0x6 [analogy_ni_mio] (a4l_ni_E_interrupt+0x401 [analogy_ni_mio])
:|  # func                 119    0.514N ipipe_test_and_stall_pipeline_head+0x4 [analogy_ni_mio] (ni_sync_ai_dma+0x15 [analogy_ni_mio])
:|  # func                 119    0.521N native_irqs_disabled+0x3 [analogy_ni_mio] (ipipe_test_and_stall_pipeline_head+0xe [analogy_ni_mio])
:|  # func                 120    0.559N native_save_fl+0x3 (__ipipe_check_percpu_access+0xa)
:|  # func                 120    0.517N a4l_mite_sync_input_dma+0x7 [analogy_ni_mite] (ni_sync_ai_dma+0x4d [analogy_ni_mio])
:|  # func                 121    0.514N a4l_mite_bytes_written_to_memory_lb+0x5 [analogy_ni_mite] (a4l_mite_sync_input_dma+0x15 [analogy_ni_mite])
:|  # func                 121+   1.309N mite_device_bytes_transferred+0x3 [analogy_ni_mite] (a4l_mite_bytes_written_to_memory_lb+0x11 [analogy_ni_mite])
:|  # func                 123+   1.302N a4l_mite_bytes_in_transit+0x3 [analogy_ni_mite] (a4l_mite_bytes_written_to_memory_lb+0x1a [analogy_ni_mite])
:|  # func                 124    0.514N a4l_mite_bytes_written_to_memory_ub+0x5 [analogy_ni_mite] (a4l_mite_sync_input_dma+0x1e [analogy_ni_mite])
:|  # func                 124+   1.313N a4l_mite_bytes_in_transit+0x3 [analogy_ni_mite] (a4l_mite_bytes_written_to_memory_ub+0x11 [analogy_ni_mite])
:|  # func                 126+   1.294N mite_device_bytes_transferred+0x3 [analogy_ni_mite] (a4l_mite_bytes_written_to_memory_ub+0x1a [analogy_ni_mite])
:|  # func                 127    0.521N a4l_buf_prepare_absput+0x5 [xeno_analogy] (a4l_mite_sync_input_dma+0x27 [analogy_ni_mite])
:|  # func                 128    0.517N a4l_buf_commit_absput+0x5 [xeno_analogy] (a4l_mite_sync_input_dma+0x47 [analogy_ni_mite])
:|  # func                 128    0.525N __abs_put+0x6 [xeno_analogy] (a4l_buf_commit_absput+0x2f [xeno_analogy])
:|  # func                 129    0.514N ipipe_restore_pipeline_head+0x5 [analogy_ni_mio] (ni_sync_ai_dma+0x5d [analogy_ni_mio])
:|  # func                 129    0.517N native_irqs_disabled+0x3 [analogy_ni_mio] (ipipe_restore_pipeline_head+0x11 [analogy_ni_mio])
:|  # func                 130    0.551N native_save_fl+0x3 (__ipipe_check_percpu_access+0xa)
:|  # func                 130    0.514N a4l_udelay+0x3 [analogy_ni_mio] (a4l_ni_E_interrupt+0x40b [analogy_ni_mio])
:|  # func                 131    0.555N rtdm_task_busy_sleep+0x7 [xeno_rtdm] (a4l_udelay+0x14 [analogy_ni_mio])
:|  # func                 131    0.517N xnarch_ns_to_tsc+0x9 [xeno_nucleus] (rtdm_task_busy_sleep+0x21 [xeno_rtdm])
:|  # func                 132    0.585N __rthal_x86_nodiv_ullimd+0x8 [xeno_nucleus] (xnarch_ns_to_tsc+0x3f [xeno_nucleus])

:|  # func                 132    0.514N ni_sync_ai_dma+0x6 [analogy_ni_mio] (a4l_ni_E_interrupt+0x401 [analogy_ni_mio])
:|  # func                 133    0.514N ipipe_test_and_stall_pipeline_head+0x4 [analogy_ni_mio] (ni_sync_ai_dma+0x15 [analogy_ni_mio])
:|  # func                 133    0.521N native_irqs_disabled+0x3 [analogy_ni_mio] (ipipe_test_and_stall_pipeline_head+0xe [analogy_ni_mio])
:|  # func                 134    0.559N native_save_fl+0x3 (__ipipe_check_percpu_access+0xa)
:|  # func                 134    0.517N a4l_mite_sync_input_dma+0x7 [analogy_ni_mite] (ni_sync_ai_dma+0x4d [analogy_ni_mio])
:|  # func                 135    0.517N a4l_mite_bytes_written_to_memory_lb+0x5 [analogy_ni_mite] (a4l_mite_sync_input_dma+0x15 [analogy_ni_mite])
:|  # func                 136+   1.290N mite_device_bytes_transferred+0x3 [analogy_ni_mite] (a4l_mite_bytes_written_to_memory_lb+0x11 [analogy_ni_mite])
:|  # func                 137+   1.302N a4l_mite_bytes_in_transit+0x3 [analogy_ni_mite] (a4l_mite_bytes_written_to_memory_lb+0x1a [analogy_ni_mite])
:|  # func                 138    0.514N a4l_mite_bytes_written_to_memory_ub+0x5 [analogy_ni_mite] (a4l_mite_sync_input_dma+0x1e [analogy_ni_mite])
:|  # func                 139+   1.290N a4l_mite_bytes_in_transit+0x3 [analogy_ni_mite] (a4l_mite_bytes_written_to_memory_ub+0x11 [analogy_ni_mite])
:|  # func                 140+   1.287N mite_device_bytes_transferred+0x3 [analogy_ni_mite] (a4l_mite_bytes_written_to_memory_ub+0x1a [analogy_ni_mite])
:|  # func                 141    0.521N a4l_buf_prepare_absput+0x5 [xeno_analogy] (a4l_mite_sync_input_dma+0x27 [analogy_ni_mite])
:|  # func                 142    0.517N a4l_buf_commit_absput+0x5 [xeno_analogy] (a4l_mite_sync_input_dma+0x47 [analogy_ni_mite])
:|  # func                 142    0.525N __abs_put+0x6 [xeno_analogy] (a4l_buf_commit_absput+0x2f [xeno_analogy])
:|  # func                 143    0.514N ipipe_restore_pipeline_head+0x5 [analogy_ni_mio] (ni_sync_ai_dma+0x5d [analogy_ni_mio])
:|  # func                 143    0.517N native_irqs_disabled+0x3 [analogy_ni_mio] (ipipe_restore_pipeline_head+0x11 [analogy_ni_mio])
:|  # func                 144    0.551N native_save_fl+0x3 (__ipipe_check_percpu_access+0xa)
:|  # func                 144    0.514N a4l_udelay+0x3 [analogy_ni_mio] (a4l_ni_E_interrupt+0x40b [analogy_ni_mio])
:|  # func                 145    0.555N rtdm_task_busy_sleep+0x7 [xeno_rtdm] (a4l_udelay+0x14 [analogy_ni_mio])
:|  # func                 145    0.517N xnarch_ns_to_tsc+0x9 [xeno_nucleus] (rtdm_task_busy_sleep+0x21 [xeno_rtdm])
:|  # func                 146    0.585N __rthal_x86_nodiv_ullimd+0x8 [xeno_nucleus] (xnarch_ns_to_tsc+0x3f [xeno_nucleus])

:|  # func                 147    0.514N ni_sync_ai_dma+0x6 [analogy_ni_mio] (a4l_ni_E_interrupt+0x401 [analogy_ni_mio])
:|  # func                 147    0.514N ipipe_test_and_stall_pipeline_head+0x4 [analogy_ni_mio] (ni_sync_ai_dma+0x15 [analogy_ni_mio])
:|  # func                 148    0.521N native_irqs_disabled+0x3 [analogy_ni_mio] (ipipe_test_and_stall_pipeline_head+0xe [analogy_ni_mio])
:|  # func                 148    0.559N native_save_fl+0x3 (__ipipe_check_percpu_access+0xa)
:|  # func                 149    0.517N a4l_mite_sync_input_dma+0x7 [analogy_ni_mite] (ni_sync_ai_dma+0x4d [analogy_ni_mio])
:|  # func                 149    0.641N a4l_mite_bytes_written_to_memory_lb+0x5 [analogy_ni_mite] (a4l_mite_sync_input_dma+0x15 [analogy_ni_mite])
:|  # func                 150+   1.335N mite_device_bytes_transferred+0x3 [analogy_ni_mite] (a4l_mite_bytes_written_to_memory_lb+0x11 [analogy_ni_mite])
:|  # func                 151+   1.335N a4l_mite_bytes_in_transit+0x3 [analogy_ni_mite] (a4l_mite_bytes_written_to_memory_lb+0x1a [analogy_ni_mite])
:|  # func                 152    0.521N a4l_mite_bytes_written_to_memory_ub+0x5 [analogy_ni_mite] (a4l_mite_sync_input_dma+0x1e [analogy_ni_mite])
:|  # func                 153+   1.302N a4l_mite_bytes_in_transit+0x3 [analogy_ni_mite] (a4l_mite_bytes_written_to_memory_ub+0x11 [analogy_ni_mite])
:|  # func                 154+   1.320N mite_device_bytes_transferred+0x3 [analogy_ni_mite] (a4l_mite_bytes_written_to_memory_ub+0x1a [analogy_ni_mite])
:|  # func                 156    0.532N a4l_buf_prepare_absput+0x5 [xeno_analogy] (a4l_mite_sync_input_dma+0x27 [analogy_ni_mite])
:|  # func                 156    0.525N a4l_buf_commit_absput+0x5 [xeno_analogy] (a4l_mite_sync_input_dma+0x47 [analogy_ni_mite])
:|  # func                 157    0.551N __abs_put+0x6 [xeno_analogy] (a4l_buf_commit_absput+0x2f [xeno_analogy])
:|  # func                 157    0.521N ipipe_restore_pipeline_head+0x5 [analogy_ni_mio] (ni_sync_ai_dma+0x5d [analogy_ni_mio])
:|  # func                 158    0.532N native_irqs_disabled+0x3 [analogy_ni_mio] (ipipe_restore_pipeline_head+0x11 [analogy_ni_mio])
:|  # func                 158    0.577N native_save_fl+0x3 (__ipipe_check_percpu_access+0xa)
:|  # func                 159    0.521N a4l_udelay+0x3 [analogy_ni_mio] (a4l_ni_E_interrupt+0x40b [analogy_ni_mio])
:|  # func                 159    0.566N rtdm_task_busy_sleep+0x7 [xeno_rtdm] (a4l_udelay+0x14 [analogy_ni_mio])
:|  # func                 160    0.529N xnarch_ns_to_tsc+0x9 [xeno_nucleus] (rtdm_task_busy_sleep+0x21 [xeno_rtdm])
:|  # func                 160    0.611N __rthal_x86_nodiv_ullimd+0x8 [xeno_nucleus] (xnarch_ns_to_tsc+0x3f [xeno_nucleus])

:|  # func                 161    0.547N ni_sync_ai_dma+0x6 [analogy_ni_mio] (a4l_ni_E_interrupt+0x401 [analogy_ni_mio])
:|  # func                 162    0.514N ipipe_test_and_stall_pipeline_head+0x4 [analogy_ni_mio] (ni_sync_ai_dma+0x15 [analogy_ni_mio])
:|  # func                 162    0.517N native_irqs_disabled+0x3 [analogy_ni_mio] (ipipe_test_and_stall_pipeline_head+0xe [analogy_ni_mio])
:|  # func                 163    0.562N native_save_fl+0x3 (__ipipe_check_percpu_access+0xa)
:|  # func                 163    0.517N a4l_mite_sync_input_dma+0x7 [analogy_ni_mite] (ni_sync_ai_dma+0x4d [analogy_ni_mio])
:|  # func                 164    0.514N a4l_mite_bytes_written_to_memory_lb+0x5 [analogy_ni_mite] (a4l_mite_sync_input_dma+0x15 [analogy_ni_mite])
:|  # func                 164+   1.298N mite_device_bytes_transferred+0x3 [analogy_ni_mite] (a4l_mite_bytes_written_to_memory_lb+0x11 [analogy_ni_mite])
:|  # func                 166+   1.302N a4l_mite_bytes_in_transit+0x3 [analogy_ni_mite] (a4l_mite_bytes_written_to_memory_lb+0x1a [analogy_ni_mite])
:|  # func                 167    0.514N a4l_mite_bytes_written_to_memory_ub+0x5 [analogy_ni_mite] (a4l_mite_sync_input_dma+0x1e [analogy_ni_mite])
:|  # func                 167+   1.313N a4l_mite_bytes_in_transit+0x3 [analogy_ni_mite] (a4l_mite_bytes_written_to_memory_ub+0x11 [analogy_ni_mite])
:|  # func                 169+   1.294N mite_device_bytes_transferred+0x3 [analogy_ni_mite] (a4l_mite_bytes_written_to_memory_ub+0x1a [analogy_ni_mite])
:|  # func                 170    0.521N a4l_buf_prepare_absput+0x5 [xeno_analogy] (a4l_mite_sync_input_dma+0x27 [analogy_ni_mite])
:|  # func                 171    0.517N a4l_buf_commit_absput+0x5 [xeno_analogy] (a4l_mite_sync_input_dma+0x47 [analogy_ni_mite])
:|  # func                 171    0.525N __abs_put+0x6 [xeno_analogy] (a4l_buf_commit_absput+0x2f [xeno_analogy])
:|  # func                 172    0.514N ipipe_restore_pipeline_head+0x5 [analogy_ni_mio] (ni_sync_ai_dma+0x5d [analogy_ni_mio])
:|  # func                 172    0.517N native_irqs_disabled+0x3 [analogy_ni_mio] (ipipe_restore_pipeline_head+0x11 [analogy_ni_mio])
:|  # func                 173    0.551N native_save_fl+0x3 (__ipipe_check_percpu_access+0xa)
:|  # func                 173    0.514N a4l_udelay+0x3 [analogy_ni_mio] (a4l_ni_E_interrupt+0x40b [analogy_ni_mio])
:|  # func                 174    0.555N rtdm_task_busy_sleep+0x7 [xeno_rtdm] (a4l_udelay+0x14 [analogy_ni_mio])
:|  # func                 174    0.517N xnarch_ns_to_tsc+0x9 [xeno_nucleus] (rtdm_task_busy_sleep+0x21 [xeno_rtdm])
:|  # func                 175    0.604N __rthal_x86_nodiv_ullimd+0x8 [xeno_nucleus] (xnarch_ns_to_tsc+0x3f [xeno_nucleus])

:|  # func                 175    0.547N ni_sync_ai_dma+0x6 [analogy_ni_mio] (a4l_ni_E_interrupt+0x401 [analogy_ni_mio])
:|  # func                 176    0.514N ipipe_test_and_stall_pipeline_head+0x4 [analogy_ni_mio] (ni_sync_ai_dma+0x15 [analogy_ni_mio])
:|  # func                 176    0.521N native_irqs_disabled+0x3 [analogy_ni_mio] (ipipe_test_and_stall_pipeline_head+0xe [analogy_ni_mio])
:|  # func                 177    0.559N native_save_fl+0x3 (__ipipe_check_percpu_access+0xa)
:|  # func                 177    0.517N a4l_mite_sync_input_dma+0x7 [analogy_ni_mite] (ni_sync_ai_dma+0x4d [analogy_ni_mio])
:|  # func                 178    0.510N a4l_mite_bytes_written_to_memory_lb+0x5 [analogy_ni_mite] (a4l_mite_sync_input_dma+0x15 [analogy_ni_mite])
:|  # func                 178+   1.290N mite_device_bytes_transferred+0x3 [analogy_ni_mite] (a4l_mite_bytes_written_to_memory_lb+0x11 [analogy_ni_mite])
:|  # func                 180+   1.302N a4l_mite_bytes_in_transit+0x3 [analogy_ni_mite] (a4l_mite_bytes_written_to_memory_lb+0x1a [analogy_ni_mite])
:|  # func                 181    0.514N a4l_mite_bytes_written_to_memory_ub+0x5 [analogy_ni_mite] (a4l_mite_sync_input_dma+0x1e [analogy_ni_mite])
:|  # func                 182+   1.283N a4l_mite_bytes_in_transit+0x3 [analogy_ni_mite] (a4l_mite_bytes_written_to_memory_ub+0x11 [analogy_ni_mite])
:|  # func                 183+   1.298N mite_device_bytes_transferred+0x3 [analogy_ni_mite] (a4l_mite_bytes_written_to_memory_ub+0x1a [analogy_ni_mite])
:|  # func                 184    0.521N a4l_buf_prepare_absput+0x5 [xeno_analogy] (a4l_mite_sync_input_dma+0x27 [analogy_ni_mite])
:|  # func                 185    0.517N a4l_buf_commit_absput+0x5 [xeno_analogy] (a4l_mite_sync_input_dma+0x47 [analogy_ni_mite])
:|  # func                 185    0.525N __abs_put+0x6 [xeno_analogy] (a4l_buf_commit_absput+0x2f [xeno_analogy])
:|  # func                 186    0.514N ipipe_restore_pipeline_head+0x5 [analogy_ni_mio] (ni_sync_ai_dma+0x5d [analogy_ni_mio])
:|  # func                 186    0.517N native_irqs_disabled+0x3 [analogy_ni_mio] (ipipe_restore_pipeline_head+0x11 [analogy_ni_mio])
:|  # func                 187    0.551N native_save_fl+0x3 (__ipipe_check_percpu_access+0xa)
:|  # func                 187    0.514N a4l_udelay+0x3 [analogy_ni_mio] (a4l_ni_E_interrupt+0x40b [analogy_ni_mio])
:|  # func                 188    0.555N rtdm_task_busy_sleep+0x7 [xeno_rtdm] (a4l_udelay+0x14 [analogy_ni_mio])
:|  # func                 188    0.517N xnarch_ns_to_tsc+0x9 [xeno_nucleus] (rtdm_task_busy_sleep+0x21 [xeno_rtdm])
:|  # func                 189    0.604N __rthal_x86_nodiv_ullimd+0x8 [xeno_nucleus] (xnarch_ns_to_tsc+0x3f [xeno_nucleus])

:|  # func                 190    0.547N ni_sync_ai_dma+0x6 [analogy_ni_mio] (a4l_ni_E_interrupt+0x401 [analogy_ni_mio])
:|  # func                 190    0.656N ipipe_test_and_stall_pipeline_head+0x4 [analogy_ni_mio] (ni_sync_ai_dma+0x15 [analogy_ni_mio])
:|  # func                 191    0.521N native_irqs_disabled+0x3 [analogy_ni_mio] (ipipe_test_and_stall_pipeline_head+0xe [analogy_ni_mio])
:|  # func                 191    0.574N native_save_fl+0x3 (__ipipe_check_percpu_access+0xa)
:|  # func                 192    0.514N a4l_mite_sync_input_dma+0x7 [analogy_ni_mite] (ni_sync_ai_dma+0x4d [analogy_ni_mio])
:|  # func                 192    0.517N a4l_mite_bytes_written_to_memory_lb+0x5 [analogy_ni_mite] (a4l_mite_sync_input_dma+0x15 [analogy_ni_mite])
:|  # func                 193+   1.305N mite_device_bytes_transferred+0x3 [analogy_ni_mite] (a4l_mite_bytes_written_to_memory_lb+0x11 [analogy_ni_mite])
:|  # func                 194+   1.324N a4l_mite_bytes_in_transit+0x3 [analogy_ni_mite] (a4l_mite_bytes_written_to_memory_lb+0x1a [analogy_ni_mite])
:|  # func                 195    0.514N a4l_mite_bytes_written_to_memory_ub+0x5 [analogy_ni_mite] (a4l_mite_sync_input_dma+0x1e [analogy_ni_mite])
:|  # func                 196+   1.309N a4l_mite_bytes_in_transit+0x3 [analogy_ni_mite] (a4l_mite_bytes_written_to_memory_ub+0x11 [analogy_ni_mite])
:|  # func                 197+   1.294N mite_device_bytes_transferred+0x3 [analogy_ni_mite] (a4l_mite_bytes_written_to_memory_ub+0x1a [analogy_ni_mite])
:|  # func                 199    0.521N a4l_buf_prepare_absput+0x5 [xeno_analogy] (a4l_mite_sync_input_dma+0x27 [analogy_ni_mite])
:|  # func                 199    0.517N a4l_buf_commit_absput+0x5 [xeno_analogy] (a4l_mite_sync_input_dma+0x47 [analogy_ni_mite])
:|  # func                 200    0.525N __abs_put+0x6 [xeno_analogy] (a4l_buf_commit_absput+0x2f [xeno_analogy])
:|  # func                 200    0.514N ipipe_restore_pipeline_head+0x5 [analogy_ni_mio] (ni_sync_ai_dma+0x5d [analogy_ni_mio])
:|  # func                 201    0.521N native_irqs_disabled+0x3 [analogy_ni_mio] (ipipe_restore_pipeline_head+0x11 [analogy_ni_mio])
:|  # func                 201    0.566N native_save_fl+0x3 (__ipipe_check_percpu_access+0xa)
:|  # func                 202    0.514N a4l_udelay+0x3 [analogy_ni_mio] (a4l_ni_E_interrupt+0x40b [analogy_ni_mio])
:|  # func                 202    0.555N rtdm_task_busy_sleep+0x7 [xeno_rtdm] (a4l_udelay+0x14 [analogy_ni_mio])
:|  # func                 203    0.517N xnarch_ns_to_tsc+0x9 [xeno_nucleus] (rtdm_task_busy_sleep+0x21 [xeno_rtdm])
:|  # func                 203    0.600N __rthal_x86_nodiv_ullimd+0x8 [xeno_nucleus] (xnarch_ns_to_tsc+0x3f [xeno_nucleus])
:|  # func                 204    0.517N ni_event+0x4 [analogy_ni_mio] (a4l_ni_E_interrupt+0x42e [analogy_ni_mio])
:|  # func                 204    0.517N a4l_buf_evt+0x7 [xeno_analogy] (ni_event+0x29 [analogy_ni_mio])
:|  # func                 205    0.521N __count_to_get+0x3 [xeno_analogy] (a4l_buf_evt+0x3a [xeno_analogy])
:|  # func                 206    0.529N a4l_signal_sync+0x4 [xeno_analogy] (a4l_buf_evt+0x96 [xeno_analogy])
:|  # func                 206    0.514N rtdm_event_signal+0x6 [xeno_rtdm] (a4l_signal_sync+0x24 [xeno_analogy])
:|  # func                 207    0.510N __xnlock_get_irqsave.constprop.6+0x9 [xeno_rtdm] (rtdm_event_signal+0x1c [xeno_rtdm])
:|  # func                 207    0.521N native_irqs_disabled+0x3 [xeno_rtdm] (__xnlock_get_irqsave.constprop.6+0x17 [xeno_rtdm])
:|  # func                 208    0.649N native_save_fl+0x3 (__ipipe_check_percpu_access+0xa)
:|  # func                 208    0.514N xnsynch_flush+0x9 [xeno_nucleus] (rtdm_event_signal+0x30 [xeno_rtdm])
:|  # func                 209    0.514N __xnlock_get_irqsave.constprop.1+0x9 [xeno_nucleus] (xnsynch_flush+0x21 [xeno_nucleus])
:|  # func                 209    0.521N native_irqs_disabled+0x3 [xeno_nucleus] (__xnlock_get_irqsave.constprop.1+0x17 [xeno_nucleus])
:|  # func                 210    0.555N native_save_fl+0x3 (__ipipe_check_percpu_access+0xa)
:|  # func                 210    0.536N getpq+0x4 [xeno_nucleus] (xnsynch_flush+0x59 [xeno_nucleus])
:|  # func                 211    0.514N xnpod_resume_thread+0x9 [xeno_nucleus] (xnsynch_flush+0x51 [xeno_nucleus])
:|  # func                 211    0.514N __xnlock_get_irqsave.constprop.11+0x9 [xeno_nucleus] (xnpod_resume_thread+0x26 [xeno_nucleus])
:|  # func                 212    0.514N ipipe_test_and_stall_pipeline_head+0x4 [xeno_nucleus] (__xnlock_get_irqsave.constprop.11+0x1b [xeno_nucleus])
:|  # func                 212    0.514N native_irqs_disabled+0x3 [xeno_nucleus] (ipipe_test_and_stall_pipeline_head+0xe [xeno_nucleus])
:|  # func                 213    0.540N native_save_fl+0x3 [xeno_nucleus] (native_irqs_disabled+0xd [xeno_nucleus])
:|  # func                 213    0.562N native_save_fl+0x3 (__ipipe_check_percpu_access+0xa)
:|  # [27056] -<?>-   90   214    0.532N xnpod_resume_thread+0x48 [xeno_nucleus] (xnsynch_flush+0x51 [xeno_nucleus])
:|  # func                 215    0.551N xnsched_rt_enqueue+0x5 [xeno_nucleus] (xnpod_resume_thread+0x172 [xeno_nucleus])
:|  # func                 215    0.532N xnlock_put_irqrestore.constprop.9+0x9 [xeno_nucleus] (xnpod_resume_thread+0x1c0 [xeno_nucleus])
:|  # func                 216    0.551N ipipe_restore_pipeline_head+0x5 [xeno_nucleus] (xnlock_put_irqrestore.constprop.9+0x16a [xeno_nucleus])
:|  # func                 216    0.514N native_irqs_disabled+0x3 [xeno_nucleus] (ipipe_restore_pipeline_head+0x11 [xeno_nucleus])
:|  # func                 217    0.536N native_save_fl+0x3 [xeno_nucleus] (native_irqs_disabled+0xd [xeno_nucleus])
:|  # func                 217    0.566N native_save_fl+0x3 (__ipipe_check_percpu_access+0xa)
:|  # func                 218    0.517N getpq+0x4 [xeno_nucleus] (xnsynch_flush+0x59 [xeno_nucleus])
:|  # func                 218    0.514N xnlock_put_irqrestore.constprop.0+0x9 [xeno_nucleus] (xnsynch_flush+0x7a [xeno_nucleus])
:|  # func                 219    0.521N native_irqs_disabled+0x3 [xeno_nucleus] (xnlock_put_irqrestore.constprop.0+0x16e [xeno_nucleus])
:|  # func                 219    0.566N native_save_fl+0x3 (__ipipe_check_percpu_access+0xa)
:|  # func                 220    0.540N xnselect_signal+0x3 [xeno_rtdm] (rtdm_event_signal+0x3f [xeno_rtdm])
:|  # func                 220    0.540N xnpod_schedule+0x3 [xeno_rtdm] (rtdm_event_signal+0x4c [xeno_rtdm])
:|  # func                 221    0.570N xnlock_put_irqrestore.constprop.5+0x9 [xeno_rtdm] (rtdm_event_signal+0x53 [xeno_rtdm])
:|  # func                 222    0.536N native_irqs_disabled+0x3 [xeno_rtdm] (xnlock_put_irqrestore.constprop.5+0x16e [xeno_rtdm])
:|  # func                 222    0.589N native_save_fl+0x3 (__ipipe_check_percpu_access+0xa)
:|  # func                 223+   1.534N m_series_stc_readw+0x6 [analogy_ni_pcimio] (a4l_ni_E_interrupt+0x43e [analogy_ni_mio])
:|  # func                 224    0.529N a4l_ni_tio_handle_interrupt+0x9 [analogy_ni_tio] (a4l_ni_E_interrupt+0x540 [analogy_ni_mio])
:|  # func                 225    0.525N a4l_get_subd+0x9 [xeno_analogy] (a4l_ni_tio_handle_interrupt+0x23 [analogy_ni_tio])
:|  # func                 225    0.536N prefetch+0x3 [xeno_analogy] (a4l_get_subd+0x2f [xeno_analogy])
:|  # func                 226    0.514N prefetch+0x3 [xeno_analogy] (a4l_get_subd+0x2f [xeno_analogy])
:|  # func                 226    0.517N prefetch+0x3 [xeno_analogy] (a4l_get_subd+0x2f [xeno_analogy])
:|  # func                 227    0.514N prefetch+0x3 [xeno_analogy] (a4l_get_subd+0x2f [xeno_analogy])
:|  # func                 227    0.517N prefetch+0x3 [xeno_analogy] (a4l_get_subd+0x2f [xeno_analogy])
:|  # func                 228    0.514N prefetch+0x3 [xeno_analogy] (a4l_get_subd+0x2f [xeno_analogy])
:|  # func                 228    0.517N prefetch+0x3 [xeno_analogy] (a4l_get_subd+0x2f [xeno_analogy])
:|  # func                 229    0.514N prefetch+0x3 [xeno_analogy] (a4l_get_subd+0x2f [xeno_analogy])
:|  # func                 229    0.517N prefetch+0x3 [xeno_analogy] (a4l_get_subd+0x2f [xeno_analogy])
:|  # func                 230    0.514N prefetch+0x3 [xeno_analogy] (a4l_get_subd+0x2f [xeno_analogy])
:|  # func                 230    0.517N prefetch+0x3 [xeno_analogy] (a4l_get_subd+0x2f [xeno_analogy])
:|  # func                 231    0.514N prefetch+0x3 [xeno_analogy] (a4l_get_subd+0x2f [xeno_analogy])
:|  # func                 232    0.517N prefetch+0x3 [xeno_analogy] (a4l_get_subd+0x2f [xeno_analogy])
:|  # func                 232    0.514N prefetch+0x3 [xeno_analogy] (a4l_get_subd+0x2f [xeno_analogy])
:|  # func                 233    0.529N prefetch+0x3 [xeno_analogy] (a4l_get_subd+0x2f [xeno_analogy])

:|  # func                 233    0.514N a4l_ni_tio_acknowledge_and_confirm+0x9 [analogy_ni_tio] (a4l_ni_tio_handle_interrupt+0x40 [analogy_ni_tio])
:|  # func                 234    0.529N NITIO_Gxx_Status_Reg+0x3 [analogy_ni_tio] (a4l_ni_tio_acknowledge_and_confirm+0x1d [analogy_ni_tio])
:|  # func                 234    0.544N read_register+0x3 [analogy_ni_tio] (a4l_ni_tio_acknowledge_and_confirm+0x26 [analogy_ni_tio])
:|  # func                 235    0.529N ni_gpct_read_register+0x4 [analogy_ni_mio] (read_register+0x14 [analogy_ni_tio])
:|  # func                 235    0.544N ni_gpct_to_stc_register+0x6 [analogy_ni_mio] (ni_gpct_read_register+0x80 [analogy_ni_mio])
:|  # func                 236+   1.538N m_series_stc_readw+0x6 [analogy_ni_pcimio] (ni_gpct_read_register+0x8d [analogy_ni_mio])
:|  # func                 237    0.517N read_register+0x3 [analogy_ni_tio] (a4l_ni_tio_acknowledge_and_confirm+0x65 [analogy_ni_tio])
:|  # func                 238    0.525N ni_gpct_read_register+0x4 [analogy_ni_mio] (read_register+0x14 [analogy_ni_tio])
:|  # func                 238    0.547N ni_gpct_to_stc_register+0x6 [analogy_ni_mio] (ni_gpct_read_register+0x80 [analogy_ni_mio])
:|  # func                 239+   1.527N m_series_stc_readw+0x6 [analogy_ni_pcimio] (ni_gpct_read_register+0x8d [analogy_ni_mio])
:|  # func                 240    0.532N NITIO_Gi_Mode_Reg+0x3 [analogy_ni_tio] (a4l_ni_tio_acknowledge_and_confirm+0x1db [analogy_ni_tio])
:|  # func                 241    0.536N ni_tio_get_soft_copy+0x5 [analogy_ni_tio] (a4l_ni_tio_acknowledge_and_confirm+0x1e4 [analogy_ni_tio])
:|  # func                 241    0.551N ipipe_test_and_stall_pipeline_head+0x4 [analogy_ni_tio] (ni_tio_get_soft_copy+0x1a [analogy_ni_tio])
:|  # func                 242    0.517N native_irqs_disabled+0x3 [analogy_ni_tio] (ipipe_test_and_stall_pipeline_head+0xe [analogy_ni_tio])
:|  # func                 243    0.581N native_save_fl+0x3 (__ipipe_check_percpu_access+0xa)
:|  # func                 243    0.547N ipipe_restore_pipeline_head+0x5 [analogy_ni_tio] (ni_tio_get_soft_copy+0x48 [analogy_ni_tio])
:|  # func                 244    0.540N native_irqs_disabled+0x3 [analogy_ni_tio] (ipipe_restore_pipeline_head+0x11 [analogy_ni_tio])
:|  # func                 244    0.559N native_save_fl+0x3 (__ipipe_check_percpu_access+0xa)
:|  # func                 245    0.517N read_register+0x3 [analogy_ni_tio] (a4l_ni_tio_handle_interrupt+0xc0 [analogy_ni_tio])
:|  # func                 245+   1.485N ni_gpct_read_register+0x4 [analogy_ni_mio] (read_register+0x14 [analogy_ni_tio])
:|  # func                 247    0.514N ipipe_test_and_stall_pipeline_head+0x4 [analogy_ni_tio] (a4l_ni_tio_handle_interrupt+0xea [analogy_ni_tio])
:|  # func                 247    0.521N native_irqs_disabled+0x3 [analogy_ni_tio] (ipipe_test_and_stall_pipeline_head+0xe [analogy_ni_tio])
:|  # func                 248    0.551N native_save_fl+0x3 (__ipipe_check_percpu_access+0xa)
:|  # func                 248    0.514N ipipe_restore_pipeline_head+0x5 [analogy_ni_tio] (a4l_ni_tio_handle_interrupt+0x147 [analogy_ni_tio])
:|  # func                 249    0.521N native_irqs_disabled+0x3 [analogy_ni_tio] (ipipe_restore_pipeline_head+0x11 [analogy_ni_tio])
:|  # func                 249    0.574N native_save_fl+0x3 (__ipipe_check_percpu_access+0xa)
:|  # func                 250    0.555N a4l_ni_tio_handle_interrupt+0x9 [analogy_ni_tio] (a4l_ni_E_interrupt+0x559 [analogy_ni_mio])
:|  # func                 251    0.510N a4l_get_subd+0x9 [xeno_analogy] (a4l_ni_tio_handle_interrupt+0x23 [analogy_ni_tio])
:|  # func                 251    0.517N prefetch+0x3 [xeno_analogy] (a4l_get_subd+0x2f [xeno_analogy])
:|  # func                 252    0.514N prefetch+0x3 [xeno_analogy] (a4l_get_subd+0x2f [xeno_analogy])
:|  # func                 252    0.517N prefetch+0x3 [xeno_analogy] (a4l_get_subd+0x2f [xeno_analogy])
:|  # func                 253    0.514N prefetch+0x3 [xeno_analogy] (a4l_get_subd+0x2f [xeno_analogy])
:|  # func                 253    0.517N prefetch+0x3 [xeno_analogy] (a4l_get_subd+0x2f [xeno_analogy])
:|  # func                 254    0.514N prefetch+0x3 [xeno_analogy] (a4l_get_subd+0x2f [xeno_analogy])
:|  # func                 254    0.517N prefetch+0x3 [xeno_analogy] (a4l_get_subd+0x2f [xeno_analogy])
:|  # func                 255    0.514N prefetch+0x3 [xeno_analogy] (a4l_get_subd+0x2f [xeno_analogy])
:|  # func                 255    0.517N prefetch+0x3 [xeno_analogy] (a4l_get_subd+0x2f [xeno_analogy])
:|  # func                 256    0.514N prefetch+0x3 [xeno_analogy] (a4l_get_subd+0x2f [xeno_analogy])
:|  # func                 256    0.645N prefetch+0x3 [xeno_analogy] (a4l_get_subd+0x2f [xeno_analogy])
:|  # func                 257    0.540N prefetch+0x3 [xeno_analogy] (a4l_get_subd+0x2f [xeno_analogy])
:|  # func                 257    0.540N prefetch+0x3 [xeno_analogy] (a4l_get_subd+0x2f [xeno_analogy])
:|  # func                 258    0.544N prefetch+0x3 [xeno_analogy] (a4l_get_subd+0x2f [xeno_analogy])
:|  # func                 258    0.551N prefetch+0x3 [xeno_analogy] (a4l_get_subd+0x2f [xeno_analogy])

:|  # func                 259    0.525N a4l_ni_tio_acknowledge_and_confirm+0x9 [analogy_ni_tio] (a4l_ni_tio_handle_interrupt+0x40 [analogy_ni_tio])
:|  # func                 260    0.536N NITIO_Gxx_Status_Reg+0x3 [analogy_ni_tio] (a4l_ni_tio_acknowledge_and_confirm+0x1d [analogy_ni_tio])
:|  # func                 260    0.562N read_register+0x3 [analogy_ni_tio] (a4l_ni_tio_acknowledge_and_confirm+0x26 [analogy_ni_tio])
:|  # func                 261    0.544N ni_gpct_read_register+0x4 [analogy_ni_mio] (read_register+0x14 [analogy_ni_tio])
:|  # func                 261    0.555N ni_gpct_to_stc_register+0x6 [analogy_ni_mio] (ni_gpct_read_register+0x80 [analogy_ni_mio])
:|  # func                 262+   1.515N m_series_stc_readw+0x6 [analogy_ni_pcimio] (ni_gpct_read_register+0x8d [analogy_ni_mio])
:|  # func                 263    0.525N read_register+0x3 [analogy_ni_tio] (a4l_ni_tio_acknowledge_and_confirm+0x65 [analogy_ni_tio])
:|  # func                 264    0.544N ni_gpct_read_register+0x4 [analogy_ni_mio] (read_register+0x14 [analogy_ni_tio])
:|  # func                 264    0.562N ni_gpct_to_stc_register+0x6 [analogy_ni_mio] (ni_gpct_read_register+0x80 [analogy_ni_mio])
:|  # func                 265+   1.527N m_series_stc_readw+0x6 [analogy_ni_pcimio] (ni_gpct_read_register+0x8d [analogy_ni_mio])
:|  # func                 266    0.540N NITIO_Gi_Mode_Reg+0x3 [analogy_ni_tio] (a4l_ni_tio_acknowledge_and_confirm+0x1db [analogy_ni_tio])
:|  # func                 267    0.547N ni_tio_get_soft_copy+0x5 [analogy_ni_tio] (a4l_ni_tio_acknowledge_and_confirm+0x1e4 [analogy_ni_tio])
:|  # func                 268    0.514N ipipe_test_and_stall_pipeline_head+0x4 [analogy_ni_tio] (ni_tio_get_soft_copy+0x1a [analogy_ni_tio])
:|  # func                 268    0.521N native_irqs_disabled+0x3 [analogy_ni_tio] (ipipe_test_and_stall_pipeline_head+0xe [analogy_ni_tio])
:|  # func                 269    0.551N native_save_fl+0x3 (__ipipe_check_percpu_access+0xa)
:|  # func                 269    0.514N ipipe_restore_pipeline_head+0x5 [analogy_ni_tio] (ni_tio_get_soft_copy+0x48 [analogy_ni_tio])
:|  # func                 270    0.536N native_irqs_disabled+0x3 [analogy_ni_tio] (ipipe_restore_pipeline_head+0x11 [analogy_ni_tio])
:|  # func                 270    0.555N native_save_fl+0x3 (__ipipe_check_percpu_access+0xa)
:|  # func                 271    0.517N read_register+0x3 [analogy_ni_tio] (a4l_ni_tio_handle_interrupt+0xc0 [analogy_ni_tio])
:|  # func                 271+   1.500N ni_gpct_read_register+0x4 [analogy_ni_mio] (read_register+0x14 [analogy_ni_tio])
:|  # func                 273    0.514N ipipe_test_and_stall_pipeline_head+0x4 [analogy_ni_tio] (a4l_ni_tio_handle_interrupt+0xea [analogy_ni_tio])
:|  # func                 273    0.521N native_irqs_disabled+0x3 [analogy_ni_tio] (ipipe_test_and_stall_pipeline_head+0xe [analogy_ni_tio])
:|  # func                 274    0.551N native_save_fl+0x3 (__ipipe_check_percpu_access+0xa)
:|  # func                 274    0.514N ipipe_restore_pipeline_head+0x5 [analogy_ni_tio] (a4l_ni_tio_handle_interrupt+0x147 [analogy_ni_tio])
:|  # func                 275    0.521N native_irqs_disabled+0x3 [analogy_ni_tio] (ipipe_restore_pipeline_head+0x11 [analogy_ni_tio])
:|  # func                 275    0.570N native_save_fl+0x3 (__ipipe_check_percpu_access+0xa)
:|  # func                 276    0.514N a4l_get_subd+0x9 [xeno_analogy] (a4l_ni_E_interrupt+0x565 [analogy_ni_mio])
:|  # func                 276    0.514N prefetch+0x3 [xeno_analogy] (a4l_get_subd+0x2f [xeno_analogy])
:|  # func                 277    0.517N prefetch+0x3 [xeno_analogy] (a4l_get_subd+0x2f [xeno_analogy])
:|  # func                 277    0.514N prefetch+0x3 [xeno_analogy] (a4l_get_subd+0x2f [xeno_analogy])
:|  # func                 278    0.607N prefetch+0x3 [xeno_analogy] (a4l_get_subd+0x2f [xeno_analogy])
:|  # func                 279    0.517N prefetch+0x3 [xeno_analogy] (a4l_get_subd+0x2f [xeno_analogy])
:|  # func                 279    0.517N prefetch+0x3 [xeno_analogy] (a4l_get_subd+0x2f [xeno_analogy])
:|  # func                 280    0.517N prefetch+0x3 [xeno_analogy] (a4l_get_subd+0x2f [xeno_analogy])
:|  # func                 280    0.517N prefetch+0x3 [xeno_analogy] (a4l_get_subd+0x2f [xeno_analogy])
:|  # func                 281    0.517N prefetch+0x3 [xeno_analogy] (a4l_get_subd+0x2f [xeno_analogy])
:|  # func                 281    0.517N prefetch+0x3 [xeno_analogy] (a4l_get_subd+0x2f [xeno_analogy])
:|  # func                 282    0.517N prefetch+0x3 [xeno_analogy] (a4l_get_subd+0x2f [xeno_analogy])
:|  # func                 282    0.517N prefetch+0x3 [xeno_analogy] (a4l_get_subd+0x2f [xeno_analogy])
:|  # func                 283    0.517N prefetch+0x3 [xeno_analogy] (a4l_get_subd+0x2f [xeno_analogy])
:|  # func                 283    0.517N prefetch+0x3 [xeno_analogy] (a4l_get_subd+0x2f [xeno_analogy])
:|  # func                 284    0.547N prefetch+0x3 [xeno_analogy] (a4l_get_subd+0x2f [xeno_analogy])

:|  # func                 284    0.514N ipipe_test_and_stall_pipeline_head+0x4 [analogy_ni_mio] (a4l_ni_E_interrupt+0x57e [analogy_ni_mio])
:|  # func                 285    0.521N native_irqs_disabled+0x3 [analogy_ni_mio] (ipipe_test_and_stall_pipeline_head+0xe [analogy_ni_mio])
:|  # func                 285    0.562N native_save_fl+0x3 (__ipipe_check_percpu_access+0xa)
:|  # func                 286    0.514N ipipe_restore_pipeline_head+0x5 [analogy_ni_mio] (a4l_ni_E_interrupt+0x606 [analogy_ni_mio])
:|  # func                 286    0.521N native_irqs_disabled+0x3 [analogy_ni_mio] (ipipe_restore_pipeline_head+0x11 [analogy_ni_mio])
:|  # func                 287+   1.553N native_save_fl+0x3 (__ipipe_check_percpu_access+0xa)
:|  # func                 288    0.536N a4l_buf_evt+0x7 [xeno_analogy] (a4l_ni_E_interrupt+0x67a [analogy_ni_mio])
:|  # func                 289    0.514N ipipe_restore_pipeline_head+0x5 [analogy_ni_mio] (a4l_ni_E_interrupt+0x687 [analogy_ni_mio])
:|  # func                 290    0.521N native_irqs_disabled+0x3 [analogy_ni_mio] (ipipe_restore_pipeline_head+0x11 [analogy_ni_mio])
:|  # func                 290    0.660N native_save_fl+0x3 (__ipipe_check_percpu_access+0xa)
:|  # func                 291    0.592N xnlock_put+0x9 [xeno_nucleus] (xnintr_shirq_handler+0xe0 [xeno_nucleus])
:|  # func                 291    0.517N rthal_irq_end+0x5 (xnintr_shirq_handler+0x13d [xeno_nucleus])
:|  # func                 292    0.517N irq_to_desc+0x3 (rthal_irq_end+0x1d)
:|  # func                 292    0.517N irq_to_desc+0x3 (rthal_irq_end+0x28)
:|  # func                 293    0.514N irq_to_desc+0x3 (rthal_irq_end+0x32)
:|  # func                 293    0.540N __ipipe_end_fasteoi_irq+0x3 (rthal_irq_end+0x38)
:|  # func                 294    0.517N unmask_ioapic_irq+0x3 (__ipipe_end_fasteoi_irq+0x16)
:|  # func                 294    0.517N unmask_ioapic+0x7 (unmask_ioapic_irq+0x12)
:|  # func                 295    0.514N __ipipe_spin_lock_irqsave+0x6 (unmask_ioapic+0x1a)
:|  # func                 295    0.544N native_save_fl+0x3 (__ipipe_spin_lock_irqsave+0x12)
:|  # func                 296    0.547N native_save_fl+0x3 (__ipipe_check_percpu_access+0xa)
:|  # func                 297    0.562N native_save_fl+0x3 (__ipipe_check_percpu_access+0xa)
:|  # func                 297    0.510N __io_apic_modify_irq+0x9 (unmask_ioapic+0x35)
:|  # func                 298    0.529N io_apic_read+0x4 (__io_apic_modify_irq+0x25)
:|  # func                 298+   1.613N io_apic_base+0x3 (io_apic_read+0x10)
:|  # func                 300    0.555N io_apic_base+0x3 (__io_apic_modify_irq+0x36)
:|  # func                 300    0.517N ipipe_irq_unlock+0x5 (unmask_ioapic+0x43)
:|  # func                 301    0.547N native_save_fl+0x3 (__ipipe_check_percpu_access+0xa)
:|  # func                 301    0.514N __ipipe_unlock_irq+0x9 (ipipe_irq_unlock+0x49)
:|  # func                 302    0.514N native_irqs_disabled+0x3 (__ipipe_unlock_irq+0x18)
:|  # func                 302    0.521N native_save_fl+0x3 (native_irqs_disabled+0xd)
:|  # func                 303    0.525N test_and_clear_bit+0x3 (__ipipe_unlock_irq+0x4e)
:|  # func                 303    0.652N __ipipe_spin_unlock_irqrestore+0x6 (unmask_ioapic+0x4f)
:|  # func                 304    0.525N xnpod_schedule+0x3 [xeno_nucleus] (xnintr_shirq_handler+0x190 [xeno_nucleus])
:|  # func                 305    0.514N __xnpod_schedule+0x9 [xeno_nucleus] (xnpod_schedule+0x37 [xeno_nucleus])
:|  # func                 305    0.544N native_save_fl+0x3 [xeno_nucleus] (__xnpod_schedule+0x15 [xeno_nucleus])
:|  # func                 306    0.562N native_save_fl+0x3 (__ipipe_check_percpu_access+0xa)
:|  # func                 306    0.514N __xnlock_get_irqsave.constprop.11+0x9 [xeno_nucleus] (__xnpod_schedule+0xa2 [xeno_nucleus])
:|  # func                 307    0.510N ipipe_test_and_stall_pipeline_head+0x4 [xeno_nucleus] (__xnlock_get_irqsave.constprop.11+0x1b [xeno_nucleus])
:|  # func                 307    0.514N native_irqs_disabled+0x3 [xeno_nucleus] (ipipe_test_and_stall_pipeline_head+0xe [xeno_nucleus])
:|  # func                 308    0.521N native_save_fl+0x3 [xeno_nucleus] (native_irqs_disabled+0xd [xeno_nucleus])
:|  # func                 308    0.641N native_save_fl+0x3 (__ipipe_check_percpu_access+0xa)
:|  # [    0] -<?>-   -1   309    0.510N __xnpod_schedule+0xca [xeno_nucleus] (xnpod_schedule+0x37 [xeno_nucleus])
:|  # func                 309    0.529N __cpus_empty.constprop.10+0x3 [xeno_nucleus] (__xnpod_schedule+0xe0 [xeno_nucleus])
:|  # func                 310    0.521N xnsched_pick_next+0x6 [xeno_nucleus] (__xnpod_schedule+0x129 [xeno_nucleus])
:|  # func                 311    0.694N xnsched_rt_pick+0x4 [xeno_nucleus] (xnsched_pick_next+0x55 [xeno_nucleus])
:|  # func                 311    0.570N native_save_fl+0x3 (__ipipe_check_percpu_access+0xa)
:|  # func                 312    0.521N native_save_fl+0x3 [xeno_nucleus] (__xnpod_schedule+0x39b [xeno_nucleus])
:|  # func                 312    0.510N native_irqs_disabled+0x3 [xeno_nucleus] (__xnpod_schedule+0x3c2 [xeno_nucleus])
:|  # func                 313    0.851N native_save_fl+0x3 [xeno_nucleus] (native_irqs_disabled+0xd [xeno_nucleus])
:|  # func                 314    0.840N __switch_to+0x9 (__xnpod_schedule+0x4e3 [xeno_nucleus])
:|  # func                 315    0.581N native_save_fl+0x3 [xeno_nucleus] (__xnpod_schedule+0x519 [xeno_nucleus])
:|  # func                 315    0.577N native_save_fl+0x3 (__ipipe_check_percpu_access+0xa)
:|  # [27056] -<?>-   90   316    0.529N __xnpod_schedule+0x5b7 [xeno_nucleus] (xnpod_schedule+0x37 [xeno_nucleus])

:|  # func                 316    0.529N __xnpod_switch_fpu+0x5 [xeno_nucleus] (__xnpod_schedule+0x680 [xeno_nucleus])
:|  # func                 317    0.690N xnarch_save_fpu+0x3 [xeno_nucleus] (__xnpod_switch_fpu+0x41 [xeno_nucleus])
:|  # func                 317    0.532N xnlock_put_irqrestore.constprop.9+0x9 [xeno_nucleus] (__xnpod_schedule+0x6ae [xeno_nucleus])
:|  # func                 318    0.529N ipipe_restore_pipeline_head+0x5 [xeno_nucleus] (xnlock_put_irqrestore.constprop.9+0x16a [xeno_nucleus])
:|  # func                 318    0.529N native_irqs_disabled+0x3 [xeno_nucleus] (ipipe_restore_pipeline_head+0x11 [xeno_nucleus])
:|  # func                 319    0.555N native_save_fl+0x3 [xeno_nucleus] (native_irqs_disabled+0xd [xeno_nucleus])
:|  # func                 320    0.604N native_save_fl+0x3 (__ipipe_check_percpu_access+0xa)
:|  # func                 320    0.525N xnlock_put_irqrestore.constprop.9+0x9 [xeno_nucleus] (xnpod_suspend_thread+0x207 [xeno_nucleus])
:|  # func                 321    0.517N ipipe_restore_pipeline_head+0x5 [xeno_nucleus] (xnlock_put_irqrestore.constprop.9+0x16a [xeno_nucleus])
:|  # func                 321    0.517N native_irqs_disabled+0x3 [xeno_nucleus] (ipipe_restore_pipeline_head+0x11 [xeno_nucleus])
:|  # func                 322    0.544N native_save_fl+0x3 [xeno_nucleus] (native_irqs_disabled+0xd [xeno_nucleus])
:|  # func                 322    0.585N native_save_fl+0x3 (__ipipe_check_percpu_access+0xa)
:|  # func                 323    0.525N xnlock_put_irqrestore.constprop.0+0x9 [xeno_nucleus] (xnsynch_sleep_on+0xb9 [xeno_nucleus])
:|  # func                 323    0.521N native_irqs_disabled+0x3 [xeno_nucleus] (xnlock_put_irqrestore.constprop.0+0x16e [xeno_nucleus])
:|  # func                 324    0.566N native_save_fl+0x3 (__ipipe_check_percpu_access+0xa)
:|  # func                 324    0.532N xnselect_signal+0x3 [xeno_rtdm] (rtdm_event_timedwait+0x132 [xeno_rtdm])
:|  # func                 325    0.574N xnlock_put_irqrestore.constprop.5+0x9 [xeno_rtdm] (rtdm_event_timedwait+0x153 [xeno_rtdm])
:|  # func                 326    0.521N native_irqs_disabled+0x3 [xeno_rtdm] (xnlock_put_irqrestore.constprop.5+0x16e [xeno_rtdm])
:|  # func                 326    0.562N native_save_fl+0x3 (__ipipe_check_percpu_access+0xa)
:|  # func                 327    0.517N __ipipe_restore_pipeline_head+0x7 (xnlock_put_irqrestore.constprop.5+0x1ee [xeno_rtdm])
:|  # func                 327    0.544N native_save_fl+0x3 (__ipipe_check_percpu_access+0xa)
:|  + func                 328    0.544N native_irqs_disabled+0x3 (__ipipe_restore_pipeline_head+0x114)
:|  + func                 328    0.525N native_save_fl+0x3 (native_irqs_disabled+0xd)
:|  + end     0x80000000   329    0.787N __ipipe_restore_pipeline_head+0x122 (xnlock_put_irqrestore.constprop.5+0x1ee [xeno_rtdm])

:|  + begin   0xffffff09   330    0.592  ipipe_ipi3+0x30 (__ipipe_restore_pipeline_head+0x124)
:|  + func                 330    0.547N __ipipe_handle_irq+0x9 (ipipe_ipi3+0x37)
:|  + func                 331    0.536N native_save_fl+0x3 (__ipipe_handle_irq+0x41)
:|  + func                 331    0.585N native_save_fl+0x3 (__ipipe_check_percpu_access+0xa)
:|  + func                 332    0.562N irq_to_desc+0x3 (__ipipe_handle_irq+0xec)
:|  + func                 332    0.547N __ipipe_ack_apic+0x3 (__ipipe_handle_irq+0xf2)
:|  + func                 333    0.544N native_apic_mem_write+0x3 (__ipipe_ack_apic+0x1b)
:|  + func                 334    0.532N __ipipe_dispatch_wired+0x6 (__ipipe_handle_irq+0xff)
:|  + func                 334    0.585N native_save_fl+0x3 (__ipipe_check_percpu_access+0xa)
:|  + func                 335    0.562N __ipipe_dispatch_wired_nocheck+0x9 (__ipipe_dispatch_wired+0x62)
:|  + func                 335    0.562N native_save_fl+0x3 (__ipipe_check_percpu_access+0xa)
:|  + func                 336    0.562N native_save_fl+0x3 (__ipipe_check_percpu_access+0xa)
:|  + func                 336    0.600N native_save_fl+0x3 (__ipipe_check_percpu_access+0xa)
:|  # func                 337    0.660N xnintr_clock_handler+0x5 [xeno_nucleus] (__ipipe_dispatch_wired_nocheck+0xe1)
:|  # func                 338    0.634N __xnlock_get.constprop.2+0x9 [xeno_nucleus] (xnintr_clock_handler+0x8c [xeno_nucleus])
:|  # func                 338    0.604N xntimer_tick_aperiodic+0x9 [xeno_nucleus] (xnintr_clock_handler+0x91 [xeno_nucleus])
:|  # func                 339    0.555N xntimer_dequeue_aperiodic+0x4 [xeno_nucleus] (xntimer_tick_aperiodic+0x75 [xeno_nucleus])
:|  # func                 339    0.577N xntimer_next_local_shot+0x9 [xeno_nucleus] (xntimer_tick_aperiodic+0x160 [xeno_nucleus])
:|  # event   tick@domain.hid   340    0.570N xntimer_next_local_shot+0xac [xeno_nucleus] (xntimer_tick_aperiodic+0x160 [xeno_nucleus])
:|  # func                 341    0.544N native_apic_mem_read+0x3 (xntimer_next_local_shot+0x108 [xeno_nucleus])
:|  # func                 341    0.551N native_apic_mem_write+0x3 (xntimer_next_local_shot+0x11b [xeno_nucleus])
:|  # func                 342    0.679N xnlock_put+0x9 [xeno_nucleus] (xnintr_clock_handler+0x9b [xeno_nucleus])
:|  # func                 342    0.544N xnpod_schedule+0x3 [xeno_nucleus] (xnintr_clock_handler+0xeb [xeno_nucleus])
:|  # func                 343    0.555N native_save_fl+0x3 (__ipipe_check_percpu_access+0xa)
:|  + func                 343    0.574N native_save_fl+0x3 (__ipipe_check_percpu_access+0xa)
:|  + func                 344    0.604N native_save_fl+0x3 (__ipipe_check_percpu_access+0xa)
:|  + func                 345    0.577N native_save_fl+0x3 (__ipipe_check_percpu_access+0xa)
:|  + func                 345    0.559N native_save_fl+0x3 (__ipipe_check_percpu_access+0xa)
:|  + end     0xffffff09   346    0.791N ipipe_ipi3+0x41 (__ipipe_restore_pipeline_head+0x124)

:   + func                 347    0.559N __handle_event+0x3 [xeno_analogy] (a4l_read_buffer+0x8e [xeno_analogy])
:   + func                 347    0.566N __count_to_get+0x3 [xeno_analogy] (a4l_read_buffer+0x98 [xeno_analogy])
:   + func                 348    0.544N __munge+0x9 [xeno_analogy] (a4l_read_buffer+0xee [xeno_analogy])
:   + func                 348    0.532N ni_ai_munge16+0x9 [analogy_ni_mio] (__munge+0x3f [xeno_analogy])
:   + func                 349    0.833N a4l_get_chan+0x9 [xeno_analogy] (ni_ai_munge16+0x27 [analogy_ni_mio])
:   + func                 350    0.551N __consume+0x9 [xeno_analogy] (a4l_read_buffer+0x103 [xeno_analogy])
:   + func                 350    0.536N rtdm_safe_copy_to_user+0x6 [xeno_analogy] (__consume+0x69 [xeno_analogy])
:   + func                 351    0.664N __copy_to_user_ll+0x6 (rtdm_safe_copy_to_user+0x36 [xeno_analogy])
:   + func                 351    0.540N native_save_fl+0x3 [xeno_rtdm] (__rt_dev_read+0x53 [xeno_rtdm])
:|  + begin   0x80000001   352    0.577  __rt_dev_read+0x6a [xeno_rtdm] (sys_rtdm_read+0x23 [xeno_rtdm])
:|  + func                 352    0.540N ipipe_test_pipeline_from.constprop.2+0x4 [xeno_rtdm] (__rt_dev_read+0x6f [xeno_rtdm])
:|  + func                 353    0.570N native_save_fl+0x3 (__ipipe_check_percpu_access+0xa)
:|  + end     0x80000001   354    0.559N __rt_dev_read+0x84 [xeno_rtdm] (sys_rtdm_read+0x23 [xeno_rtdm])
:   + func                 354    0.649N rtdm_context_unlock+0x7 [xeno_rtdm] (__rt_dev_read+0xc7 [xeno_rtdm])
:   + func                 355    0.540N native_save_fl+0x3 (__ipipe_dispatch_event+0x17c)
:|  + begin   0x80000001   355    0.585  __ipipe_dispatch_event+0x18f (__ipipe_syscall_root+0x57)
:|  + func                 356    0.577N native_save_fl+0x3 (__ipipe_check_percpu_access+0xa)
:|  + func                 356    0.566N native_save_fl+0x3 (__ipipe_check_percpu_access+0xa)
:|  + end     0x80000001   357    0.574N __ipipe_dispatch_event+0x348 (__ipipe_syscall_root+0x57)
:   + func                 358    0.551N native_save_fl+0x3 (__ipipe_syscall_root+0x5e)
:|  + begin   0x80000001   358    0.577  __ipipe_syscall_root+0x76 (system_call+0x2d)
:|  + func                 359    0.544N native_save_fl+0x3 (__ipipe_syscall_root+0x9d)
:|  + func                 359+   1.144N native_save_fl+0x3 (__ipipe_check_percpu_access+0xa)
:   + func                 360    0.555N __ipipe_syscall_root+0x9 (system_call+0x2d)
:   + func                 361    0.562N __ipipe_dispatch_event+0x9 (__ipipe_syscall_root+0x57)
:   + func                 362    0.540N native_save_fl+0x3 (__ipipe_dispatch_event+0x19)
:|  + begin   0x80000001   362    0.544N __ipipe_dispatch_event+0x2c (__ipipe_syscall_root+0x57)
:|  + func                 363    0.585N native_save_fl+0x3 (__ipipe_check_percpu_access+0xa)
:|  + func                 363    0.570N native_save_fl+0x3 (__ipipe_check_percpu_access+0xa)
:|  + func                 364    0.607N native_save_fl+0x3 (__ipipe_check_percpu_access+0xa)
:|  + end     0x80000001   364    0.577N __ipipe_dispatch_event+0x15d (__ipipe_syscall_root+0x57)
:   + func                 365    0.611N hisyscall_event+0x9 [xeno_nucleus] (__ipipe_dispatch_event+0x16d)
:   + func                 366    0.562N xnshadow_sys_trace+0x6 [xeno_nucleus] (hisyscall_event+0x12f [xeno_nucleus])
:   + (0x42)  0x000013e6   366    0.555N xnshadow_sys_trace+0x8c [xeno_nucleus] (hisyscall_event+0x12f [xeno_nucleus])

--------------020906070902060004050708--

