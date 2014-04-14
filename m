MIME-Version: 1.0
Date: Mon, 14 Apr 2014 11:14:24 +0200
Message-ID: <CAPRPZsAmXEyH4wcMeGcWPB3B-3=04DoS=K2k-QbQ+DidPcptAg@mail.gmail.com>
From: Jeroen Van den Keybus <jeroen.vandenkeybus@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Subject: [Xenomai] Slow execution of RT task
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "xenomai@xenomai.org" <xenomai@xenomai.org>

Hi,


I am using Xenomai 2.6.3 with the I-pipe for kernel 3.10.18. I'm using
a Core-i7 4770 CPU with a C226 chipset.

I noticed some odd behaviour of Xenomai compared to a 3.8.13 kernel
running on a Core2 duo machine.

I've written a small test program (see below) which takes timestamps
using rt_timer_read(). All times are in ns.

On the Core i7 / 3.10.18 I see:

1397464068633533451:     1322     1570 T=    2892 (0)
1397464069633533451:     1349     1564 T=    2913 (0)

whereas on the Core2 duo / 3.8.13 I read:

1397464644515093593:    -1773      263 T=   -1510 (0)
1397464645515093593:    -1976      255 T=   -1721 (0)

Especially the second number is problematic. It indicates that
rt_timer_read() would require 1.6 us to execute on the Core i7
compared to 0.3 us on the Core2.


Other observations:

(1) Linux scheduling problems. I note that e.g. loading xeno_native
takes forever, until e.g. another shell is opened. It seems that
processes can be stuck for a very long time and they get 'unstuck' by
scheduling something. The dmesg log in this case:

[   53.688174] I-pipe: head domain Xenomai registered.
[   80.892830] Xenomai: hal/x86_64 started.
[   80.893143] Xenomai: scheduling class idle registered.
[   80.893151] Xenomai: scheduling class rt registered.
[   80.908943] Xenomai: real-time nucleus v2.6.3 (Lies and Truths) loaded.
[   80.908953] Xenomai: debug mode enabled.
[   80.956392] Xenomai: SMI-enabled chipset found, but SMI workaround disabled
[   80.956392]          (see xeno_hal.smi parameter). You may encounter
[   80.956392]          high interrupt latencies!
[   83.919002] Xenomai: starting native API services.
[   83.922860] [sched_delayed] sched: RT throttling activated

Also, I noticed that e.g. building a kernel with make -j12 finishes in
2m15s on a Ubuntu 3.13 kernel, whereas it finishes between 4m18 and
9m15 on the patched 3.10.18 one. In that case, a lot of time is spent
in-kernel.

sysbench CPU tests on the other hand show nearly equal results:
20.5056s (3.13) and 20.505 (3.10.18-ipipe).


(2) Kernel warnings:

[  143.797961] WARNING: at kernel/rcutree.c:480 rcu_irq_exit+0xb9/0xd0()
[  143.797967] Modules linked in: xeno_native xeno_nucleus i915
coretemp mperf ghash_clmulni_intel aesni_intel aes_x86_64 lrw gf128mul
glue_helper ablk_helper cryptd drm_kms_helper drm lpc_ich mfd_core
ehci_pci ehci_hcd video backlight processor xhci_hcd e1000e igb
usbcore firewire_ohci firewire_core i2c_algo_bit hwmon crc_itu_t ptp
pps_core usb_common thermal fan
[  143.798151] CPU: 1 PID: 0 Comm: swapper/1 Tainted: G        W
3.10.18-ipipe #17
[  143.798156] Hardware name: Supermicro X10SAE/X10SAE, BIOS 1.1a 01/03/2014
[  143.798163]  0000000000000009 ffff8802124ffcf0 ffffffff814a6885
ffff8802124ffd28
[  143.798184]  ffffffff8103da61 ffff88021580d7a0 0000000000000000
00000000000514b0
[  143.798206]  0000000000104240 ffffffff81a6b3b0 ffff8802124ffd38
ffffffff8103db3a
[  143.798228] Call Trace:
[  143.798240]  [<ffffffff814a6885>] dump_stack+0x19/0x1b
[  143.798252]  [<ffffffff8103da61>] warn_slowpath_common+0x61/0x80
[  143.798266]  [<ffffffff8103db3a>] warn_slowpath_null+0x1a/0x20
[  143.798278]  [<ffffffff810c2389>] rcu_irq_exit+0xb9/0xd0
[  143.798290]  [<ffffffff81006490>] ?
arch_jump_label_transform_static+0x80/0x80
[  143.798302]  [<ffffffff810468c2>] irq_exit+0x82/0xc0
[  143.798314]  [<ffffffff810064b0>] smp_irq_work_interrupt+0x20/0x30
[  143.798326]  [<ffffffff81021ce9>] __ipipe_do_IRQ+0x79/0x90
[  143.798340]  [<ffffffff810ca4c9>] ? ipipe_trace_end+0x19/0x20
[  143.798351]  [<ffffffff81006490>] ?
arch_jump_label_transform_static+0x80/0x80
[  143.798364]  [<ffffffff81021cef>] ? __ipipe_do_IRQ+0x7f/0x90
[  143.798378]  [<ffffffff810c7258>] __ipipe_do_sync_stage+0x1c8/0x200
[  143.798391]  [<ffffffff810c72f2>] ipipe_unstall_root+0x62/0x90
[  143.798404]  [<ffffffff813a6860>] cpuidle_enter_state+0x50/0xc0
[  143.798417]  [<ffffffff813a6995>] cpuidle_idle_call+0xc5/0x200
[  143.798431]  [<ffffffff8100ad4e>] arch_cpu_idle+0xe/0x30
[  143.798443]  [<ffffffff810850de>] cpu_startup_entry+0xce/0x2a0
[  143.798455]  [<ffffffff8108d218>] ? clockevents_config_and_register+0x28/0x30
[  143.798469]  [<ffffffff8149d477>] start_secondary+0x24b/0x24d
[  143.798483] ---[ end trace 679efcb785cef87b ]---


(3) Seemingly normal latency test, both idle and under load
(aforementioned kernel build with make -j12):

RTT|  00:00:01  (periodic user-mode task, 100 us period, priority 99)
RTH|----lat min|----lat avg|----lat max|-overrun|---msw|---lat best|--lat worst
RTD|      0.256|      0.279|      2.846|       0|     0|      0.256|      2.846
RTD|      0.230|      0.295|      1.412|       0|     0|      0.230|      2.846
RTD|      0.254|      0.272|      1.764|       0|     0|      0.230|      2.846

RTT|  00:00:22  (periodic user-mode task, 100 us period, priority 99)
RTH|----lat min|----lat avg|----lat max|-overrun|---msw|---lat best|--lat worst
RTD|      1.023|      2.166|      9.690|       0|     0|      0.166|     15.136
RTD|      1.004|      2.159|     13.713|       0|     0|      0.166|     15.136
RTD|      0.489|      2.209|     10.871|       0|     0|      0.166|     15.136

I-pipe trace output for last result:

I-pipe worst-case tracing service on 3.10.18-ipipe/ipipe release #1
-------------------------------------------------------------
CPU: 0, Begin: 7581696203992 cycles, Trace Points: 22 (-10/+1), Length: 16 us
Calibrated minimum trace-point overhead: 0.060 us

 +----- Hard IRQs ('|': locked)
 |+-- Xenomai
 ||+- Linux ('*': domain stalled, '+': current, '#': current+stalled)
 |||                      +---------- Delay flag ('+': > 1 us, '!': > 10 us)
 |||                      |        +- NMI noise ('N')
 |||                      |        |
          Type    User Val.   Time    Delay  Function (Parent)
     +func                  -1    0.104  security_inode_permission+0x0
(__inode_permission+0x4a)
     +func                  -1    0.127  cap_inode_permission+0x0
(security_inode_permission+0x1c)
     +func                  -1    0.107  lookup_fast+0x0 (link_path_walk+0x1ab)
     +func                   0    0.145  __d_lookup_rcu+0x0 (lookup_fast+0x48)
     +func                   0    0.108  terminate_walk+0x0
(link_path_walk+0x2b8)
     +func                   0    0.115  lg_local_unlock+0x0
(terminate_walk+0x2d)
     +func                   0    0.115  put_filp+0x0 (path_openat+0xfa)
     +func                   0    0.109  security_file_free+0x0 (put_filp+0x1e)
     +func                   0    0.103
apparmor_file_free_security+0x0 (security_file_free+0x16)
     +func                   0    0.284  kzfree+0x0
(apparmor_file_free_security+0x1a)
>|   +begin   0x000000ef     0    0.110  apic_timer_interrupt+0x6d (__ipipe_trace+0x21e)
:|   +func                   0    0.161  __ipipe_handle_irq+0x0
(apic_timer_interrupt+0x7c)
:|   +func                   0    0.134  __ipipe_dispatch_irq+0x0
(__ipipe_handle_irq+0x8d)
:|   +func                   0    0.157  __ipipe_ack_hrtimer_irq+0x0
(__ipipe_dispatch_irq+0x357)
:|   +func                   0    0.228  lapic_itimer_ack+0x0
(__ipipe_ack_hrtimer_irq+0x4b)
:|  # func                   0    0.208  xnintr_clock_handler+0x0
[xeno_nucleus] (__ipipe_dispatch_irq+0x14c)
:|  # func                   1    0.141  xntimer_tick_aperiodic+0x0
[xeno_nucleus] (xnintr_clock_handler+0x142 [xeno_nucleus])
:|  # func                   1    0.122  xnthread_periodic_handler+0x0
[xeno_nucleus] (xntimer_tick_aperiodic+0xd5 [xeno_nucleus])
:|  # func                   1    0.145  xnpod_resume_thread+0x0
[xeno_nucleus] (xnthread_periodic_handler+0x35 [xeno_nucleus])
:|  # [ 5777] -<?>-   99     1    0.196  xnpod_resume_thread+0x104
[xeno_nucleus] (xnthread_periodic_handler+0x35 [xeno_nucleus])
:|  # func                   1    0.122  xntimer_next_local_shot+0x0
[xeno_nucleus] (xntimer_tick_aperiodic+0x1b0 [xeno_nucleus])
:|  # event   tick@99        1    0.118  xntimer_next_local_shot+0x63
[xeno_nucleus] (xntimer_tick_aperiodic+0x1b0 [xeno_nucleus])
:|  # func                   1    0.129  ipipe_timer_set+0x0
(xntimer_next_local_shot+0x6b [xeno_nucleus])
:|  # func                   1    0.245  lapic_next_deadline+0x0
(ipipe_timer_set+0x6a)
:|  # func                   2    0.180  __xnpod_schedule+0x0
[xeno_nucleus] (xnintr_clock_handler+0x305 [xeno_nucleus])
:|  # [ 8168] -<?>-   -1     2    0.125  __xnpod_schedule+0x168
[xeno_nucleus] (xnintr_clock_handler+0x305 [xeno_nucleus])
:|  # func                   2    0.127  xnsched_pick_next+0x0
[xeno_nucleus] (__xnpod_schedule+0x2e5 [xeno_nucleus])
:|  # func                   2    0.688
__ipipe_notify_vm_preemption+0x0 (__xnpod_schedule+0x875
[xeno_nucleus])
:|  # [ 5777] -<?>-   99     3    0.400  __xnpod_schedule+0x537
[xeno_nucleus] (xnpod_suspend_thread+0x472 [xeno_nucleus])
:|  # func                   3!  12.721  xntimer_get_overruns+0x0
[xeno_nucleus] (xnpod_wait_thread_period+0x158 [xeno_nucleus])
:|  # func                  16    0.145  __ipipe_restore_head+0x0
(xnpod_wait_thread_period+0x1ab [xeno_nucleus])
<|  + end     0x80000000    16    0.294  ipipe_trace_end+0x19
(__ipipe_restore_head+0x6c)
 |  + begin   0x80000001    16    0.000  __ipipe_notify_syscall+0x1ab
(__ipipe_syscall_root+0x3d)


(4) Processor C states.

Only C0 and C1 (not C1E) states were enabled in the BIOS. The i7ztool
indicates no other RT-unfriendly C states (C3, 6 or 7). I put
ACPI_PROCESSOR and INTEL_IDLE (against recommendation, I know) back in
after I found out that they were not upsetting things (same results)
and that these states can be entered in spite of these settings
anyway. Kernel commandline contains intel_idle.max_cstate=1 and
processor.max_cstate=1 to ensure that no other C states are entered.


(5) Curious initial max trace result.

When I checked the trace result (cat /proc/ipipe/trace/max) I got an
exceptionally long trace:

I-pipe worst-case tracing service on 3.10.18-ipipe/ipipe release #1
-------------------------------------------------------------
CPU: 0, Begin: 415090237212 cycles, Trace Points: 7 (-10/+1), Length: 2879152 us
Calibrated minimum trace-point overhead: 0.060 us

 +----- Hard IRQs ('|': locked)
 |+-- Xenomai
 ||+- Linux ('*': domain stalled, '+': current, '#': current+stalled)
 |||                      +---------- Delay flag ('+': > 1 us, '!': > 10 us)
 |||                      |        +- NMI noise ('N')
 |||                      |        |
          Type    User Val.   Time    Delay  Function (Parent)
 |  *+func                  -1    0.120  ipipe_send_ipi+0x0
(xntimer_start_aperiodic+0x211 [xeno_nucleus])
 |  *+func                  -1    0.182  flat_send_IPI_mask+0x0
(ipipe_send_ipi+0x56)
 |  *+func                  -1    0.120  xntimer_start_aperiodic+0x0
[xeno_nucleus] (xnpod_enable_timesource+0x329 [xeno_nucleus])
 |  *+func                  -1    0.129  xnarch_ns_to_tsc+0x0
[xeno_nucleus] (xntimer_start_aperiodic+0x179 [xeno_nucleus])
 |  *+func                   0    0.205  xnarch_ns_to_tsc+0x0
[xeno_nucleus] (xntimer_start_aperiodic+0x190 [xeno_nucleus])
 |  *+func                   0    0.157  __ipipe_restore_head+0x0
(xnpod_enable_timesource+0x378 [xeno_nucleus])
 |   +end     0x80000000     0    0.134  ipipe_trace_end+0x19
(__ipipe_restore_head+0x6c)
     +func                   0    0.110  rthal_timer_request+0x0
(xnpod_enable_timesource+0x227 [xeno_nucleus])
     +func                   0    0.201  ipipe_timer_start+0x0
(rthal_timer_request+0x19)
     +func                   0    0.112  ipipe_critical_enter+0x0
(ipipe_timer_start+0x44)
>|   +begin   0x80000001     0    0.172  ipipe_critical_enter+0x229 (ipipe_timer_start+0x44)
:|   +func                   0    0.117  ipipe_send_ipi+0x0
(ipipe_critical_enter+0x1da)
:|   +func                   0! 2879138.805  flat_send_IPI_mask+0x0
(ipipe_send_ipi+0x56)
:|   +func               2879139          0.432  ipipe_send_ipi+0x0
(ipipe_critical_enter+0x1da)
:|   +func               2879139!  12.396  flat_send_IPI_mask+0x0
(ipipe_send_ipi+0x56)
:|   +func               2879151          0.950
ipipe_critical_exit+0x0 (ipipe_timer_start+0x9a)
<|   +end     0x80000001 2879152          0.325  ipipe_trace_end+0x19
(ipipe_critical_exit+0x8a)
 |   +begin   0x000000fd 2879153          0.000
reschedule_interrupt+0x6d (ipipe_critical_exit+0x76)


I'm considering going back toi 3.8.13 for the Core i7 machine to try
and isolate the problem. Still, I would need the 3.10 due to an
unacceptable wbinvd in the 3,8's i915 driver. So I would rather ask
here for some advice, hints or any other ideas before attempting to
reconfigure a 3.8 kernel for this machine only for the sake of
debugging (it's somewhat of a pain to determine the proper driver set


Thanks for any light,


J.


The test program:

#include <errno.h>
#include <signal.h>
#include <stdio.h>
#include <string.h>
#include <sys/resource.h>
#include <sys/time.h>
#include <sys/types.h>
#include <unistd.h>
#include <sys/mman.h>
#include <native/task.h>
#include <native/timer.h>

RT_TASK my_task;

static int run = 1;

void my_task_proc(void *arg)
{
    int ns_counter = 0, check_counter = 0;
    RTIME ts[12];
    int ts_report = 0;
    int i;
    unsigned long total_overruns = 0L;
    RTIME period = *(RTIME *)arg;
    RTIME t;

    t = rt_timer_read() + period;
//  rt_task_set_periodic(NULL, TM_NOW, period); // ns

    while (run) {
        unsigned long overruns;
//      if (rt_task_wait_period(&overruns)) {
//          total_overruns += overruns;
//      }

        rt_task_sleep_until(t);
        ts[0] = t;
        t += period;
        ns_counter += period;

        if (ns_counter > 50000000) {
            check_counter++;
            ns_counter -= 50000000;
            if (check_counter > 19) {
                check_counter -= 20;
                ts_report = 1;
            }
        }
        ts[1] = rt_timer_read();
        ts[2] = rt_timer_read();

        if (ts_report) {
            rt_printf("%12llu: ", ts[0]);
            for (i = 1; i < 3; i++) {
                rt_printf("%8lld ", ts[i] - ts[i - 1]);
            }
            rt_printf("T=%8llu (%lu)\n", ts[2] - ts[0], total_overruns);
            ts_report = 0;
        }
    }
}

void signal_handler(int sig)
{
    run = 0;
}

int main(int argc, char *argv[])
{
    int ret;
    RTIME period;

    /* Perform auto-init of rt_print buffers if the task doesn't do so */
    rt_print_auto_init(1);

    signal(SIGTERM, signal_handler);
    signal(SIGINT, signal_handler);

    mlockall(MCL_CURRENT | MCL_FUTURE);

    ret = rt_task_create(&my_task, "my_task", 0, 10, T_FPU | T_JOINABLE);
    if (ret < 0) {
        fprintf(stderr, "Failed to create task: %s\n", strerror(-ret));
        return -1;
    }

    if (argc == 2)
        period = atol(argv[1]);
    else
        period = 100000000ULL;

    ret = rt_task_start(&my_task, &my_task_proc, &period);
    if (ret < 0) {
        fprintf(stderr, "Failed to start task: %s\n", strerror(-ret));
        return -1;
    }

    rt_task_join(&my_task);

    rt_task_delete(&my_task);

    return 0;
}

