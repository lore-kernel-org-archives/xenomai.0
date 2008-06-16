Message-ID: <485627D1.7060702@domain.hid>
Date: Mon, 16 Jun 2008 10:44:01 +0200
From: Sebastian Smolorz <smolorz@domain.hid>
MIME-Version: 1.0
References: <4850DC9D.4010607@domain.hid>	<2ff1a98a0806120208n48d15ed6m4e67b582dced1ba3@domain.hid>
	<48510808.9020304@domain.hid> <485174A7.7040505@domain.hid>
	<485227E2.3030603@domain.hid> <48523BE4.8070403@domain.hid>
	<48523E11.40702@domain.hid> <4854CF37.20001@domain.hid>
In-Reply-To: <4854CF37.20001@domain.hid>
Content-Type: multipart/mixed; boundary="------------070705040000050905020903"
Subject: Re: [Xenomai-help] High latencies on Core2Duo
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: philippe.gerum@domain.hid
Cc: xenomai@xenomai.org

This is a multi-part message in MIME format.
--------------070705040000050905020903
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Philippe Gerum wrote:
> Could you try booting with idle=poll just to make sure that we don't get trapped
> into long wakeup latency from some idling instruction? We explicitly avoid mwait
> unless forced to use it by a bootparam, but maybe something goes wrong with the
> default idle code as well.

Attached is a new trace, I've booted with idle=poll. The latency spots 
are still there. Maybe Gilles is right and the SMI disabling code needs 
an adaption to new chipsets.

-- 
Sebastian

--------------070705040000050905020903
Content-Type: text/plain;
 name="ipipe_trace_5"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="ipipe_trace_5"

I-pipe frozen back-tracing service on 2.6.25/ipipe-2.0-08
------------------------------------------------------------
CPU: 0, Freeze: 1047976024131 cycles, Trace Points: 100 (+10)
Calibrated minimum trace-point overhead: 0.125 us

 +----- Hard IRQs ('|': locked)
 |+---- <unused>
 ||+--- <unused>
 |||+-- Xenomai
 ||||+- Linux ('*': domain stalled, '+': current, '#': current+stalled)
 |||||                        +---------- Delay flag ('+': > 1 us, '!': > 10 us)
 |||||                        |        +- NMI noise ('N')
 |||||                        |        |
      Type    User Val.   Time    Delay  Function (Parent)
:|   +func                -308    0.180  __ipipe_walk_pipeline+0xe (__ipipe_handle_irq+0x12b)
:|   #end     0xffffff16  -308    0.175  ipipe_ipi3+0x3d (<4009134f>)
:    #func                -308    0.160  __ipipe_unstall_iret_root+0x9 (restore_nocheck_notrace+0x0)
:|   #begin   0x80000000  -308    0.155  __ipipe_unstall_iret_root+0x1e (restore_nocheck_notrace+0x0)
:|   +end     0x8000000d  -308!  42.394  __ipipe_unstall_iret_root+0x6f (restore_nocheck_notrace+0x0)
:|   +func                -265    0.335  __ipipe_handle_exception+0xe (error_code+0x77)
:|   #func                -265    0.165  do_page_fault+0xe (__ipipe_handle_exception+0x16b)
:|   #end     0x80000000  -265    0.160  do_page_fault+0x3d (__ipipe_handle_exception+0x16b)
:    #func                -265    0.140  __ipipe_unstall_root+0x8 (do_page_fault+0x14f)
:|   #begin   0x80000000  -265    0.210  __ipipe_unstall_root+0x1a (do_page_fault+0x14f)
:|   +end     0x80000000  -264    0.185  __ipipe_unstall_root+0x54 (do_page_fault+0x14f)
:    +func                -264    0.190  down_read_trylock+0x9 (do_page_fault+0x175)
:    +func                -264    0.215  find_vma+0xa (do_page_fault+0x1a4)
:    +func                -264    0.125  handle_mm_fault+0xe (do_page_fault+0x220)
:    +func                -264    0.155  ipipe_check_context+0x9 (handle_mm_fault+0x2d)
:    +func                -264    0.175  ipipe_check_context+0x9 (handle_mm_fault+0x56)
:    +func                -263    0.185  page_address+0xe (handle_mm_fault+0xd4)
:    +func                -263    0.120  anon_vma_prepare+0xe (handle_mm_fault+0x16f)
:    +func                -263    0.175  ipipe_check_context+0x9 (anon_vma_prepare+0x1d)
:    +func                -263    0.110  __alloc_pages+0xe (handle_mm_fault+0x188)
:    +func                -263    0.165  ipipe_check_context+0x9 (__alloc_pages+0x32)
:    +func                -263    0.150  get_page_from_freelist+0xe (__alloc_pages+0x70)
:    +func                -262    0.170  zone_watermark_ok+0xe (get_page_from_freelist+0x6e)
:    +func                -262    0.115  ipipe_check_context+0x9 (get_page_from_freelist+0xdb)
:    +func                -262    0.230  ipipe_check_context+0x9 (get_page_from_freelist+0x10c)
:    #func                -262    0.150  __ipipe_restore_root+0x8 (get_page_from_freelist+0x26a)
:    #func                -262    0.145  __ipipe_unstall_root+0x8 (__ipipe_restore_root+0x27)
:|   #begin   0x80000000  -262    0.160  __ipipe_unstall_root+0x1a (__ipipe_restore_root+0x27)
:|   +end     0x80000000  -261    0.135  __ipipe_unstall_root+0x54 (__ipipe_restore_root+0x27)
:    +func                -261    0.190  ipipe_check_context+0x9 (get_page_from_freelist+0x274)
:    +func                -261    0.115  kmap_atomic+0x8 (get_page_from_freelist+0x30d)
:    +func                -261    0.105  kmap_atomic_prot+0xb (kmap_atomic+0x13)
:    +func                -261+   1.698  ipipe_check_context+0x9 (kmap_atomic_prot+0x1b)
:    +func                -259    0.270  kunmap_atomic+0x9 (get_page_from_freelist+0x32c)
:    +func                -259    0.190  ipipe_check_context+0x9 (kunmap_atomic+0x4f)
:    +func                -259    0.150  page_address+0xe (handle_mm_fault+0x1e0)
:    +func                -259    0.110  _spin_lock+0x9 (handle_mm_fault+0x1ed)
:    +func                -259    0.170  ipipe_check_context+0x9 (_spin_lock+0x15)
:    +func                -258    0.135  lru_cache_add_active+0x9 (handle_mm_fault+0x1ff)
:    +func                -258    0.165  ipipe_check_context+0x9 (lru_cache_add_active+0x15)
:    +func                -258    0.150  ipipe_check_context+0x9 (lru_cache_add_active+0x64)
:    +func                -258    0.125  page_add_new_anon_rmap+0x9 (handle_mm_fault+0x20c)
:    +func                -258    0.120  __page_set_anon_rmap+0x9 (page_add_new_anon_rmap+0x2e)
:    +func                -258    0.120  __inc_zone_page_state+0x8 (__page_set_anon_rmap+0x32)
:    +func                -258    0.140  __inc_zone_state+0xe (__inc_zone_page_state+0x1d)
:    +func                -257    0.120  _spin_unlock+0x8 (handle_mm_fault+0x504)
:    +func                -257    0.155  ipipe_check_context+0x9 (_spin_unlock+0x14)
:    +func                -257    0.165  up_read+0x8 (do_page_fault+0x277)
:|   +begin   0x80000000  -257    0.160  __ipipe_handle_exception+0x17d (error_code+0x77)
:|   +func                -257    0.130  __ipipe_restore_root+0x8 (__ipipe_handle_exception+0x194)
:|   +func                -257    0.140  __ipipe_unstall_root+0x8 (__ipipe_restore_root+0x27)
:|   +end     0x80000000  -257    0.235  __ipipe_unstall_root+0x54 (__ipipe_restore_root+0x27)
:    #func                -256    0.150  __ipipe_unstall_iret_root+0x9 (restore_nocheck_notrace+0x0)
:|   #begin   0x80000000  -256    0.175  __ipipe_unstall_iret_root+0x1e (restore_nocheck_notrace+0x0)
:|   +end     0x8000000d  -256! 239.702  __ipipe_unstall_iret_root+0x6f (restore_nocheck_notrace+0x0)
:|   +begin   0xffffff16   -16    0.210  ipipe_ipi3+0x2e (<0808dfe0>)
:|   +func                 -16    0.155  __ipipe_handle_irq+0xe (ipipe_ipi3+0x33)
:|   +func                 -16    0.160  __ipipe_ack_apic+0x8 (__ipipe_handle_irq+0x76)
:|   +func                 -16    0.165  __ipipe_dispatch_wired+0xe (__ipipe_handle_irq+0x7f)
:|  # func                 -16    0.205  xnintr_clock_handler+0xe (__ipipe_dispatch_wired+0xe0)
:|  # func                 -15    0.185  xntimer_tick_aperiodic+0xe (xnintr_clock_handler+0x65)
:|  # func                 -15    0.150  xnthread_periodic_handler+0x8 (xntimer_tick_aperiodic+0x96)
:|  # func                 -15    0.165  xnpod_resume_thread+0xe (xnthread_periodic_handler+0x28)
:|  # [ 5552] samplin 99   -15    0.370  xnpod_resume_thread+0x99 (xnthread_periodic_handler+0x28)
:|  # func                 -14    0.280  xntimer_next_local_shot+0xe (xntimer_tick_aperiodic+0x1af)
:|  # func                 -14    0.551  xnpod_schedule+0xe (xnintr_clock_handler+0x108)
:|  # [ 7750] -<?>-   -1   -14    0.410  xnpod_schedule+0xe2 (xnintr_clock_handler+0x108)
:|  # func                 -13    0.466  xnarch_switch_to+0xe (xnpod_schedule+0x492)
:|  # func                 -13    0.586  __switch_to+0xe (xnarch_switch_to+0x270)
:|  # [ 5552] samplin 99   -12    0.425  xnpod_schedule+0x4cd (xnpod_suspend_thread+0x18a)
:|  # func                 -12    0.195  xntimer_get_overruns+0xe (xnpod_wait_thread_period+0xe5)
:|  # func                 -12    0.145  __ipipe_restore_pipeline_head+0x9 (xnpod_wait_thread_period+0x145)
:|  + end     0x80000000   -11    0.601  __ipipe_restore_pipeline_head+0x94 (xnpod_wait_thread_period+0x145)
:|  + begin   0xfffffff6   -11    0.160  common_interrupt+0x29 (__ipipe_restore_pipeline_head+0x96)
:|  + func                 -11    0.466  __ipipe_handle_irq+0xe (common_interrupt+0x2e)
:|  + func                 -10    0.290  __ipipe_set_irq_pending+0xe (__ipipe_handle_irq+0xc4)
:|  + func                 -10    0.616  __ipipe_ack_irq+0x8 (__ipipe_handle_irq+0xd9)
:|  + func                  -9    0.350  __ipipe_ack_fasteoi_irq+0x8 (__ipipe_ack_irq+0x19)
:|  + func                  -9    0.611  ack_ioapic_quirk_irq+0x9 (__ipipe_ack_fasteoi_irq+0xe)
:|  + func                  -8    0.210  __mask_IO_APIC_irq+0x8 (ack_ioapic_quirk_irq+0x80)
:|  + func                  -8    0.275  __modify_IO_APIC_irq+0xe (__mask_IO_APIC_irq+0x14)
:|  + func                  -8+   2.129  io_apic_base+0x8 (__modify_IO_APIC_irq+0x30)
:|  + func                  -6    0.330  io_apic_base+0x8 (__modify_IO_APIC_irq+0x3c)
:|  + func                  -5    0.180  __ipipe_walk_pipeline+0xe (__ipipe_handle_irq+0x12b)
:|  + end     0xfffffff6    -5    0.586  common_interrupt+0x38 (__ipipe_restore_pipeline_head+0x96)
:|  + begin   0x80000001    -5    0.150  __ipipe_dispatch_event+0x109 (__ipipe_syscall_root+0x8d)
:|  + end     0x80000001    -4+   1.192  __ipipe_dispatch_event+0x1db (__ipipe_syscall_root+0x8d)
:   + func                  -3    0.165  __ipipe_syscall_root+0xa (system_call+0x29)
:   + func                  -3    0.135  __ipipe_dispatch_event+0xe (__ipipe_syscall_root+0x8d)
:|  + begin   0x80000001    -3    0.160  __ipipe_dispatch_event+0x2c (__ipipe_syscall_root+0x8d)
:|  + end     0x80000001    -3    0.160  __ipipe_dispatch_event+0xd6 (__ipipe_syscall_root+0x8d)
:   + func                  -3    0.541  hisyscall_event+0xe (__ipipe_dispatch_event+0xe6)
:   + func                  -2    0.526  xnshadow_sys_trace+0xb (hisyscall_event+0x13b)
:   + func                  -2    0.225  ipipe_trace_frozen_reset+0xa (xnshadow_sys_trace+0x62)
:   + func                  -1    0.265  __ipipe_global_path_lock+0xb (ipipe_trace_frozen_reset+0xf)
:   + func                  -1    0.135  __ipipe_spin_lock_irqsave+0xa (__ipipe_global_path_lock+0x15)
:|  + begin   0x80000001    -1+   1.122  __ipipe_spin_lock_irqsave+0x21 (__ipipe_global_path_lock+0x15)
:|  # func                   0    0.175  __ipipe_spin_unlock_irqcomplete+0xa (__ipipe_global_path_unlock+0x61)
:|  + end     0x80000001     0    0.155  __ipipe_spin_unlock_irqcomplete+0x49 (__ipipe_global_path_unlock+0x61)
<   + freeze  0x00033fa7     0    0.175  xnshadow_sys_trace+0x6b (hisyscall_event+0x13b)
 |  + begin   0x80000001     0    0.170  __ipipe_dispatch_event+0x109 (__ipipe_syscall_root+0x8d)
 |  + end     0x80000001     0    0.511  __ipipe_dispatch_event+0x1db (__ipipe_syscall_root+0x8d)
    + func                   0    0.130  __ipipe_syscall_root+0xa (system_call+0x29)
    + func                   0    0.120  __ipipe_dispatch_event+0xe (__ipipe_syscall_root+0x8d)
 |  + begin   0x80000001     1    0.130  __ipipe_dispatch_event+0x2c (__ipipe_syscall_root+0x8d)
 |  + end     0x80000001     1    0.150  __ipipe_dispatch_event+0xd6 (__ipipe_syscall_root+0x8d)
    + func                   1    0.180  hisyscall_event+0xe (__ipipe_dispatch_event+0xe6)
    + func                   1    0.135  __rt_task_wait_period+0xd (hisyscall_event+0x13b)
    + func                   1    0.135  rt_task_wait_period+0x8 (__rt_task_wait_period+0x34)
    + func                   1    0.000N xnpod_wait_thread_period+0xe (rt_task_wait_period+0x42)

--------------070705040000050905020903--

