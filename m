MIME-Version: 1.0
Date: Thu, 24 Mar 2016 14:51:31 +0800
Message-ID: <CALxt+8tVMDmQYHv-80rm4LBNGpnqvaNkSiJssGZjg4YOd9w9+Q@mail.gmail.com>
From: Grant Liu <grant7788@gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: [Xenomai] xenomai latency more than 100 microseconds on 3rd gen
	core i5
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Hello,

I have one X86 system using Ubuntu 12.04 with 3rd gen i5,
and I try to get one real time system with < 50 us (microsecond) time
period,
but with xenomai 3.0.1, the latency is around 10us, and sometimes more than
100us (once per 50 seconds or so.)

Would you please kindly help to check it... Thanks in advance.

BRs,
Grant

============= System configuration ===========
X86 system
Intel 3rd generation i5, 8G RAM, 64G SSD
Ubuntu 12.04, core version 3.18.20
Xenomai 3.0.1, ipipe-core-3.18.20-x86-3.patch

I followed the installation guide:
http://xenomai.org/installing-xenomai-3-x/#cobalt-core-x86
and while make menuconfig, I followed this link:
http://xenomai.org/2014/06/configuring-for-x86-based-dual-kernels/
disabled the following items:
CONFIG_APM
CONFIG_ACPI_PROCESSOR
CONFIG_CPU_FREQ
CONFIG_CPU_IDLE
CONFIG_CC_STACKPROTECTOR

I also tried to disable SMI while seems not success...
add 'xenomai.smi=disabled' to kernel command line,
but still see the result of 'rdmsr 0x34' changed while system running.

the other attempts:
disable / enable SMT (Hyperthreading( scheduler support
Change Preemption Model (tested all 3 options)
...

The following are trace result using ./latency -f, hope useful...
I-pipe worst-case tracing service on 3.18.20/ipipe release #3
-------------------------------------------------------------
CPU: 0, Begin: 1102363168656 cycles, Trace Points: 14 (-10/+6), Length: 26
us
Calibrated minimum trace-point overhead: 0.081 us

 +----- Hard IRQs ('|': locked)
 |+-- Xenomai
 ||+- Linux ('*': domain stalled, '+': current, '#': current+stalled)
 |||   +---------- Delay flag ('+': > 1 us, '!': > 10 us)
 |||   |    +- NMI noise ('N')
 |||   |    |
  Type   User Val.   Time    Delay  Function (Parent)
 |   #end     0x80000001  -792   0.136  check_preemption_disabled+0x8a
(debug_smp_processor_id+0x12)
     #func                -792   0.160  ipipe_restore_root+0x4
(rcu_idle_enter+0x92)
     #func                -792   0.149  ipipe_root_only+0xf
(ipipe_restore_root+0x10)
 |   #begin   0x80000001  -792   0.176  ipipe_root_only+0x2d
(ipipe_restore_root+0x10)
 |   #end     0x80000001  -792   0.158  ipipe_root_only+0x87
(ipipe_restore_root+0x10)
     #func                -792   3.093  arch_cpu_idle+0x3
(cpu_startup_entry+0x243)
     #func                -788   1.709  mwait_idle+0x4 (arch_cpu_idle+0xe)
     #func                -787   0.238  __ipipe_halt_root+0x5
(mwait_idle+0x5a)
 |   #begin   0x80000000  -787   1.063  __ipipe_halt_root+0x1e
(mwait_idle+0x5a)
 |   +end     0x8000000e  -785 785.951  __ipipe_halt_root+0x49
(mwait_idle+0x5a)
>|   +begin   0x000000ef     0+   9.664  apic_timer_interrupt+0x3a
(__ipipe_halt_root+0x60)
:|   +func                   9+   4.820  __ipipe_handle_irq+0x9
(apic_timer_interrupt+0x41)
:|   +func                  14   0.195  __ipipe_dispatch_irq+0x9
(__ipipe_handle_irq+0x7d)
:|   +func                  14+   1.135  __ipipe_ack_hrtimer_irq+0xf
(__ipipe_dispatch_irq+0xe0)
:|   +func                  15+   1.096  lapic_itimer_ack+0x3
(__ipipe_ack_hrtimer_irq+0x43)
:|   +func                  16+   1.345  dispatch_irq_head+0x9
(__ipipe_dispatch_irq+0xa6)
:|  # func                  18+   3.184  xnintr_core_clock_handler+0x9
(dispatch_irq_head+0x9b)
:|  # func                  21+   1.231  xnclock_tick+0x9
(xnintr_core_clock_handler+0x11a)
:|  # func                  22   0.553  xnclock_core_local_shot+0xf
(xnclock_tick+0x74)
:|  # func                  23+   1.860  xnintr_host_tick+0x4
(xnintr_core_clock_handler+0x1b8)
:|  # func                  25   0.388  __ipipe_set_irq_pending+0xf
(xnintr_host_tick+0x31)
:|   +func                  25   0.429  __ipipe_do_sync_pipeline+0x9
(dispatch_irq_head+0x134)
:|   +func                  25   0.200  __ipipe_do_sync_stage+0x9
(__ipipe_do_sync_pipeline+0xdd)
<|   #end     0x80000000    26   0.150  __ipipe_do_sync_stage+0xd7
(__ipipe_do_sync_pipeline+0xdd)
     #func                  26   0.291  __ipipe_do_IRQ+0xc
(__ipipe_do_sync_stage+0xf5)
     #func                  26   0.800  __ipipe_get_ioapic_irq_vector+0x3
(__ipipe_do_IRQ+0x24)
     #func                  27   0.519  smp_apic_timer_interrupt+0x4
(__ipipe_do_IRQ+0x49)
     #func                  27   0.864  irq_enter+0x3
(smp_apic_timer_interrupt+0x1b)
     #func                  28   1.194  rcu_irq_enter+0xf (irq_enter+0xd)
 |   #begin   0x80000001    29   0.000  check_preemption_disabled+0x7b
(debug_smp_processor_id+0x12)
