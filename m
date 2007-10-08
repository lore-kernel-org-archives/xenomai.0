Message-ID: <470A26BC.506@domain.hid>
Date: Mon, 08 Oct 2007 14:46:52 +0200
From: "CHABAL David" <david.chabal@domain.hid>
MIME-Version: 1.0
References: <4705ED3B.4070600@domain.hid>	
	<2ff1a98a0710050130j7e0db84dq838aab0417c8bd3f@domain.hid>	
	<4705FE04.7000909@domain.hid> <1191576011.20623.114.camel@domain.hid>	
	<470611FA.30103@domain.hid> <1191592977.20623.142.camel@domain.hid>
In-Reply-To: <1191592977.20623.142.camel@domain.hid>
Content-Type: multipart/mixed; boundary="------------060007060800030501000303"
Subject: Re: [Xenomai-help] awful latencies (~110us)
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: rpm@xenomai.org
Cc: xenomai@xenomai.org

This is a multi-part message in MIME format.
--------------060007060800030501000303
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable

Philippe Gerum a =E9crit :
 > On Fri, 2007-10-05 at 12:29 +0200, CHABAL David wrote:
 >
 >> : func     -114   ipipe_check_context (boomerang_start_xmit)
 >> : func     -114   issue_and_wait (boomerang_start_xmit)
 >> : func     -114   iowrite16 (issue_and_wait)
 >> : func     -113!  ioread16 (issue_and_wait)
 >> :|begin     -84   common_interrupt (ioread16)
 >
 > The Vortex driver does some brute force polling on the slow path, when
 > the adapter does not acknowledge the last command sent fast enough. It
 > seems your CPU is burning a lot of horsepower idling on this loop.
 >

(I enabled Local Apic and IO apic according to Jan's post.)

I tried with a new NIC (RLT8139, PCI) instead of the on-board 3com, and=20
the latency test is not too bad, it reaches 57.074us.


 >> :|func      -83   __ipipe_handle_irq (common_interrupt)
 >> :|func      -83   __ipipe_ack_irq (__ipipe_handle_irq)
 >> :|func      -82   __ipipe_ack_level_irq (__ipipe_ack_irq)
 >> :|func      -82   mask_and_ack_8259A (__ipipe_ack_level_irq)
 >> :|func      -82+  __ipipe_spin_lock_irqsave (mask_and_ack_8259A)
 >> :|func      -78   __ipipe_spin_unlock_irqrestore (mask_and_ack_8259A)
 >> :|func      -78   __ipipe_dispatch_wired (__ipipe_handle_irq)
 >> :|func      -77   xnintr_clock_handler (__ipipe_dispatch_wired)
 >> :|func      -77   xnintr_irq_handler (xnintr_clock_handler)
 >> :|func      -77   xnpod_announce_tick (xnintr_irq_handler)
 >> :|func      -76   xntimer_do_tick_aperiodic (xnpod_announce_tick)
 >> :|func      -76   xnthread_periodic_handler
 >> (xntimer_do_tick_aperiodic)
 >> :|func      -76   xnpod_resume_thread (xnthread_periodic_handler)
 >> :|[ 3937]   -75+  xnpod_resume_thread (xnthread_periodic_handler)
 >> :|func      -72   xnpod_schedule (xnintr_irq_handler)
 >> :|[ 3497]   -72+  xnpod_schedule (xnintr_irq_handler)
 >> :|func      -71   __switch_to (xnpod_schedule)
 >> :|[ 3937]   -70   xnpod_schedule (xnpod_suspend_thread)
 >> :|func      -70   __ipipe_restore_pipeline_head
 >> (xnpod_wait_thread_period)
 >> :|end       -69+  __ipipe_restore_pipeline_head
 >> (xnpod_wait_thread_period)
 >> :|begin     -63   common_interrupt (__ipipe_restore_pipeline_head)
 >> :|func      -62   __ipipe_handle_irq (common_interrupt)
 >> :|func      -62   __ipipe_ack_irq (__ipipe_handle_irq)
 >> :|func      -62   __ipipe_ack_level_irq (__ipipe_ack_irq)
 >> :|func      -61   mask_and_ack_8259A (__ipipe_ack_level_irq)
 >> :|func      -61!  __ipipe_spin_lock_irqsave (mask_and_ack_8259A)
 >> :|func      -40   __ipipe_spin_unlock_irqrestore (mask_and_ack_8259A)
 >
 > 20 us spent acknowledging the interrupt is damned slow. Any "spurious
 > 8259A interrupt" message haunting your kernel log so far?
 >
No, I don't have it in my syslog.

 > The sampling task is properly rescheduled after ~15us since the timer
 > interrupt receipt, problem is that other interrupts are preempting the
 > awaken task again and again before it has a chance to run. I wonder if
 > something fishy is not going on with the fast timer acknowledge, or th=
e
 > network card. Could you:
 >
 > - send us the output of /proc/interrupts
 > - try the patch below which should prevent any acknowledge nesting
 > errors at PIC level,
 >

The files enclosed are generated with the 3com NIC, your patch and=20
local/IO APIC.

RTT|  00:15:25  (periodic user-mode task, 100 us period, priority 99)
RTH|-----lat min|-----lat avg|-----lat max|-overrun|----lat best|---lat=20
worst
RTD|       7.481|      10.336|      61.240|       0|       5.320|=20
87.833
RTD|       7.501|      10.159|      65.242|       0|       5.320|=20
87.833
---|------------|------------|------------|--------|---------------------=
----
RTS|       5.320|       9.203|      87.833|       0|    00:15:27/00:15:27



Regards,

David




--------------060007060800030501000303
Content-Type: text/plain;
 name="frozen"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="frozen"

I-pipe frozen back-tracing service on 2.6.20/ipipe-1.8-08
------------------------------------------------------------

******** WARNING ********
The following debugging options will increase the observed latencies:
 o CONFIG_XENO_OPT_DEBUG

Freeze: 4268773560534 cycles, Trace Points: 128 (+10)
Calibrated minimum trace-point overhead: 0.247 us

 +----- Hard IRQs ('|': locked)
 |+---- <unused>
 ||+--- Xenomai
 |||+-- IShield
 ||||+- Linux ('*': domain stalled, '+': current, '#': current+stalled)
 |||||                        +---------- Delay flag ('+': > 1 us, '!': > 10 us)
 |||||                        |        +- NMI noise ('N')
 |||||                        |        |
      Type    User Val.   Time    Delay  Function (Parent)
:    +func                -138    0.681  __tcp_select_window+0xe (tcp_transmit_skb+0x19b)
:    +func                -137    0.523  tcp_v4_send_check+0x14 (tcp_transmit_skb+0x45a)
:    +func                -137    0.301  ip_queue_xmit+0xe (tcp_transmit_skb+0x3b0)
:    +func                -137    0.698  __sk_dst_check+0x11 (ip_queue_xmit+0x29e)
:    +func                -136    0.539  ip_output+0xe (ip_queue_xmit+0x1ac)
:    +func                -135    0.325  dev_queue_xmit+0xe (ip_output+0x10b)
:    +func                -135    0.284  local_bh_disable+0x8 (dev_queue_xmit+0x43)
:    +func                -135    0.382  ipipe_check_context+0xc (dev_queue_xmit+0x5d)
:    +func                -134    0.374  pfifo_fast_enqueue+0xa (dev_queue_xmit+0x71)
:    +func                -134    0.293  __qdisc_run+0xe (dev_queue_xmit+0x1df)
:    +func                -134    0.346  pfifo_fast_dequeue+0x9 (__qdisc_run+0x99)
:    +func                -133    0.342  ipipe_check_context+0xc (__qdisc_run+0x10a)
:    +func                -133    0.263  ipipe_check_context+0xc (__qdisc_run+0x54)
:    +func                -133    0.265  dev_hard_start_xmit+0xe (__qdisc_run+0x64)
:    +func                -132    0.326  ipipe_check_context+0xc (dev_hard_start_xmit+0x4f)
:    +func                -132    0.382  skb_clone+0xe (dev_hard_start_xmit+0xa9)
:    +func                -132    0.267  kmem_cache_alloc+0x14 (skb_clone+0x3c)
:    +func                -131    0.290  ipipe_check_context+0xc (kmem_cache_alloc+0x27)
:    #func                -131    0.284  __ipipe_restore_root+0x8 (kmem_cache_alloc+0x68)
:    #func                -131    0.379  __ipipe_unstall_root+0x8 (__ipipe_restore_root+0x1b)
:|   #begin   0x80000000  -131    0.331  __ipipe_unstall_root+0x4b (__ipipe_restore_root+0x1b)
:|   +end     0x80000000  -130    0.612  __ipipe_unstall_root+0x3a (__ipipe_restore_root+0x1b)
:    +func                -130    0.295  packet_rcv_spkt+0x14 (dev_hard_start_xmit+0xfe)
:    +func                -129    0.468  strlcpy+0x14 (packet_rcv_spkt+0x8e)
:    +func                -129    0.265  sock_queue_rcv_skb+0x14 (packet_rcv_spkt+0xa0)
:    +func                -129    0.285  local_bh_disable+0x8 (sock_queue_rcv_skb+0x45)
:    +func                -128    0.595  sk_run_filter+0x14 (sock_queue_rcv_skb+0x5c)
:    +func                -128    0.370  local_bh_enable+0xb (sock_queue_rcv_skb+0xd5)
:    +func                -127    0.296  ipipe_check_context+0xc (local_bh_enable+0x49)
:    +func                -127    0.260  kfree_skb+0x8 (packet_rcv_spkt+0xab)
:    +func                -127    0.301  __kfree_skb+0x11 (kfree_skb+0x1e)
:    +func                -126    0.459  kfree_skbmem+0x9 (__kfree_skb+0x47)
:    +func                -126    0.330  skb_release_data+0xa (kfree_skbmem+0x10)
:    +func                -126    0.260  kmem_cache_free+0xe (kfree_skbmem+0x3d)
:    +func                -125    0.278  ipipe_check_context+0xc (kmem_cache_free+0x40)
:    #func                -125    0.356  __ipipe_restore_root+0x8 (kmem_cache_free+0x84)
:    #func                -125    0.308  __ipipe_unstall_root+0x8 (__ipipe_restore_root+0x1b)
:|   #begin   0x80000000  -124    0.310  __ipipe_unstall_root+0x4b (__ipipe_restore_root+0x1b)
:|   +end     0x80000000  -124    0.441  __ipipe_unstall_root+0x3a (__ipipe_restore_root+0x1b)
:    +func                -124    0.387  ipipe_check_context+0xc (dev_hard_start_xmit+0x10d)
:    +func                -123    0.348  boomerang_start_xmit+0xe (dev_hard_start_xmit+0x1cb)
:    +func                -123    0.301  ipipe_check_context+0xc (boomerang_start_xmit+0x123)
:    #func                -123    0.303  ipipe_check_context+0xc (boomerang_start_xmit+0x163)
:    #func                -122    0.349  issue_and_wait+0xe (boomerang_start_xmit+0x170)
:    #func                -122    0.349  iowrite16+0x8 (issue_and_wait+0x2a)
:    #func                -122!  12.419  ioread16+0x8 (issue_and_wait+0x45)
:    #func                -109+   1.352  ioread32+0x8 (boomerang_start_xmit+0x188)
:    #func                -108    0.418  iowrite16+0x8 (boomerang_start_xmit+0x1c9)
:    #func                -107    0.336  __ipipe_restore_root+0x8 (boomerang_start_xmit+0x1d0)
:    #func                -107    0.316  __ipipe_unstall_root+0x8 (__ipipe_restore_root+0x1b)
:|   #begin   0x80000000  -107    0.310  __ipipe_unstall_root+0x4b (__ipipe_restore_root+0x1b)
:|   +end     0x80000000  -106    0.464  __ipipe_unstall_root+0x3a (__ipipe_restore_root+0x1b)
:    +func                -106    0.439  ipipe_check_context+0xc (boomerang_start_xmit+0x1da)
:    +func                -106    0.267  ipipe_check_context+0xc (__qdisc_run+0x134)
:    +func                -105    0.296  ipipe_check_context+0xc (__qdisc_run+0x7a)
:    +func                -105    0.484  pfifo_fast_dequeue+0x9 (__qdisc_run+0x99)
:    +func                -105    0.265  ipipe_check_context+0xc (dev_queue_xmit+0x93)
:    +func                -104    0.275  local_bh_enable+0xb (dev_queue_xmit+0xa1)
:    +func                -104    0.357  ipipe_check_context+0xc (local_bh_enable+0x49)
:    +func                -104    0.408  update_send_head+0xa (tcp_push_one+0xca)
:    +func                -103    0.374  tcp_cwnd_validate+0x8 (tcp_push_one+0xd4)
:    +func                -103    0.310  __alloc_skb+0xe (tcp_sendmsg+0x36c)
:    +func                -103    0.267  kmem_cache_alloc+0x14 (__alloc_skb+0x30)
:    +func                -102    0.349  ipipe_check_context+0xc (kmem_cache_alloc+0x8a)
:    +func                -102    0.267  cond_resched+0x8 (kmem_cache_alloc+0x8f)
:    +func                -102    0.286  ipipe_check_context+0xc (kmem_cache_alloc+0x27)
:    #func                -101    0.284  __ipipe_restore_root+0x8 (kmem_cache_alloc+0x68)
:    #func                -101    0.372  __ipipe_unstall_root+0x8 (__ipipe_restore_root+0x1b)
:|   #begin   0x80000000  -101    0.310  __ipipe_unstall_root+0x4b (__ipipe_restore_root+0x1b)
:|   +end     0x80000000  -100    0.344  __ipipe_unstall_root+0x3a (__ipipe_restore_root+0x1b)
:    +func                -100    0.331  __kmalloc+0xe (__alloc_skb+0x4d)
:    +func                -100    0.363  ipipe_check_context+0xc (__kmalloc+0xb2)
:    +func                 -99    0.269  cond_resched+0x8 (__kmalloc+0xb7)
:    +func                 -99    0.280  ipipe_check_context+0xc (__kmalloc+0x4e)
:    #func                 -99    0.286  __ipipe_restore_root+0x8 (__kmalloc+0x8a)
:    #func                 -99    0.377  __ipipe_unstall_root+0x8 (__ipipe_restore_root+0x1b)
:|   #begin   0x80000000   -98    0.374  __ipipe_unstall_root+0x4b (__ipipe_restore_root+0x1b)
:|   +end     0x80000000   -98+   1.428  __ipipe_unstall_root+0x3a (__ipipe_restore_root+0x1b)
:|   +begin   0xffffff16   -96    0.349  ipipe_ipi3+0x2e (__alloc_skb+0xdd)
:|   +func                 -96    0.396  __ipipe_handle_irq+0x14 (ipipe_ipi3+0x33)
:|   +func                 -96    0.312  __ipipe_ack_apic+0x8 (__ipipe_handle_irq+0xaf)
:|   +func                 -95    0.454  __ipipe_dispatch_wired+0x16 (__ipipe_handle_irq+0x68)
:| #  func                 -95    0.329  xnintr_clock_handler+0x8 (__ipipe_dispatch_wired+0x9f)
:| #  func                 -95    0.400  xnintr_irq_handler+0xe (xnintr_clock_handler+0x17)
:| #  func                 -94    0.312  xnpod_announce_tick+0x8 (xnintr_irq_handler+0x3b)
:| #  func                 -94    0.497  xntimer_do_tick_aperiodic+0xe (xnpod_announce_tick+0xf)
:| #  func                 -93    0.301  xnthread_periodic_handler+0x8 (xntimer_do_tick_aperiodic+0x217)
:| #  func                 -93    0.375  xnpod_resume_thread+0xe (xnthread_periodic_handler+0x2c)
:| #  [ 4196] samplin 99   -93    0.933  xnpod_resume_thread+0x56 (xnthread_periodic_handler+0x2c)
:| #  func                 -92    0.327  xnpod_schedule+0xe (xnintr_irq_handler+0x135)
:| #  [ 3457] konsole -1   -91+   1.299  xnpod_schedule+0x90 (xnintr_irq_handler+0x135)
:| #  func                 -90    0.639  __switch_to+0xe (xnpod_schedule+0x493)
:| #  [ 4196] samplin 99   -89    0.642  xnpod_schedule+0x56b (xnpod_suspend_thread+0x18b)
:| #  func                 -89    0.353  __ipipe_restore_pipeline_head+0x12 (xnpod_wait_thread_period+0x12b)
:| +  end     0x80000000   -88+   1.363  __ipipe_restore_pipeline_head+0x5c (xnpod_wait_thread_period+0x12b)
:| +  begin   0xfffffffa   -87    0.530  common_interrupt+0x29 (__ipipe_restore_pipeline_head+0x60)
:| +  func                 -87    0.454  __ipipe_handle_irq+0x14 (common_interrupt+0x2e)
:| +  func                 -86    0.263  __ipipe_ack_irq+0x8 (__ipipe_handle_irq+0x151)
:| +  func                 -86    0.307  __ipipe_ack_level_irq+0x12 (__ipipe_ack_irq+0x19)
:| +  func                 -86    0.352  mask_and_ack_8259A+0x14 (__ipipe_ack_level_irq+0x22)
:| +  func                 -85!  30.267  __ipipe_spin_lock_irqsave+0x9 (mask_and_ack_8259A+0x29)
:| #  func                 -55    0.385  __ipipe_spin_unlock_irqrestore+0x9 (mask_and_ack_8259A+0x73)
:| +  func                 -54    0.349  __ipipe_walk_pipeline+0xe (__ipipe_handle_irq+0x81)
:| +  end     0xfffffffa   -54+   2.204  common_interrupt+0x38 (__ipipe_restore_pipeline_head+0x60)
:| +  begin   0xfffffff1   -52    0.331  common_interrupt+0x29 (__ipipe_restore_pipeline_head+0x60)
:| +  func                 -52    0.804  __ipipe_handle_irq+0x14 (common_interrupt+0x2e)
:| +  func                 -51    0.371  __ipipe_ack_irq+0x8 (__ipipe_handle_irq+0x151)
:| +  func                 -50    0.321  __ipipe_ack_level_irq+0x12 (__ipipe_ack_irq+0x19)
:| +  func                 -50    0.252  mask_and_ack_8259A+0x14 (__ipipe_ack_level_irq+0x22)
:| +  func                 -50!  38.784  __ipipe_spin_lock_irqsave+0x9 (mask_and_ack_8259A+0x29)
:| #  func                 -11    0.367  __ipipe_spin_unlock_irqrestore+0x9 (mask_and_ack_8259A+0x73)
:| +  func                 -11    0.346  __ipipe_walk_pipeline+0xe (__ipipe_handle_irq+0x81)
:| +  end     0xfffffff1   -10    0.715  common_interrupt+0x38 (__ipipe_restore_pipeline_head+0x60)
:| +  begin   0x80000001   -10    0.351  __ipipe_dispatch_event+0x180 (__ipipe_syscall_root+0x44)
:| +  end     0x80000001    -9+   3.002  __ipipe_dispatch_event+0x154 (__ipipe_syscall_root+0x44)
:  +  func                  -6    0.349  __ipipe_syscall_root+0xa (system_call+0x29)
:  +  func                  -6    0.297  __ipipe_dispatch_event+0xe (__ipipe_syscall_root+0x44)
:| +  begin   0x80000001    -6    0.383  __ipipe_dispatch_event+0x1a0 (__ipipe_syscall_root+0x44)
:| +  end     0x80000001    -5    0.292  __ipipe_dispatch_event+0x18f (__ipipe_syscall_root+0x44)
:  +  func                  -5+   1.207  hisyscall_event+0x14 (__ipipe_dispatch_event+0xb5)
:  +  func                  -4+   1.024  xnshadow_sys_trace+0x16 (hisyscall_event+0x189)
:  +  func                  -3    0.569  ipipe_trace_frozen_reset+0x9 (xnshadow_sys_trace+0xd7)
:  +  func                  -2    0.259  __ipipe_global_path_lock+0x8 (ipipe_trace_frozen_reset+0x13)
:  +  func                  -2    0.355  __ipipe_spin_lock_irqsave+0x9 (__ipipe_global_path_lock+0x12)
:| +  begin   0x80000001    -2+   1.393  __ipipe_spin_lock_irqsave+0x3d (__ipipe_global_path_lock+0x12)
:| #  func                   0    0.297  __ipipe_spin_unlock_irqcomplete+0x9 (__ipipe_global_path_unlock+0x63)
:| +  end     0x80000001     0    0.360  __ipipe_spin_unlock_irqcomplete+0x2e (__ipipe_global_path_unlock+0x63)
<  +  freeze  0x00015719     0    0.605  xnshadow_sys_trace+0xa0 (hisyscall_event+0x189)
 | +  begin   0x80000001     0    0.316  __ipipe_dispatch_event+0x180 (__ipipe_syscall_root+0x44)
 | +  end     0x80000001     0    0.989  __ipipe_dispatch_event+0x154 (__ipipe_syscall_root+0x44)
   +  func                   1    0.310  __ipipe_syscall_root+0xa (system_call+0x29)
   +  func                   2    0.571  __ipipe_dispatch_event+0xe (__ipipe_syscall_root+0x44)
 | +  begin   0xffffff16     2    0.289  ipipe_ipi3+0x2e (__ipipe_dispatch_event+0x15)
 | +  func                   3    0.312  __ipipe_handle_irq+0x14 (ipipe_ipi3+0x33)
 | +  func                   3    0.319  __ipipe_ack_apic+0x8 (__ipipe_handle_irq+0xaf)
 | +  func                   3    0.367  __ipipe_dispatch_wired+0x16 (__ipipe_handle_irq+0x68)
 | #  func                   4    0.289  xnintr_clock_handler+0x8 (__ipipe_dispatch_wired+0x9f)
 | #  func                   4    0.000  xnintr_irq_handler+0xe (xnintr_clock_handler+0x17)

--------------060007060800030501000303
Content-Type: text/plain;
 name="interrupts"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="interrupts"

           CPU0       
  0:    6338539    XT-PIC-XT        timer, rthal_broadcast_timer
  1:         16    XT-PIC-XT        i8042
  2:          0    XT-PIC-XT        cascade
  5:     788889    XT-PIC-XT        eth0
  8:          1    XT-PIC-XT        rtc
  9:          2    XT-PIC-XT        acpi
 11:          0    XT-PIC-XT        uhci_hcd:usb1
 12:        131    XT-PIC-XT        i8042
 14:      36800    XT-PIC-XT        ide0
 15:      55176    XT-PIC-XT        ide1
NMI:      10227 
LOC:    6338432 
ERR:          0
MIS:          0

--------------060007060800030501000303
Content-Type: text/plain;
 name="dmesg.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="dmesg.txt"

Linux version 2.6.20 (root@domain.hid) (gcc version 4.1.1 20060724 (prerelease) (4.1.1-3mdk)) #6 Mon Oct 8 12:35:41 CEST 2007
BIOS-provided physical RAM map:
sanitize start
sanitize end
copy_e820_map() start: 0000000000000000 size: 000000000009f800 end: 000000000009f800 type: 1
copy_e820_map() type is E820_RAM
copy_e820_map() start: 000000000009f800 size: 0000000000000800 end: 00000000000a0000 type: 2
copy_e820_map() start: 00000000000e5c00 size: 000000000001a400 end: 0000000000100000 type: 2
copy_e820_map() start: 0000000000100000 size: 000000000fdf0000 end: 000000000fef0000 type: 1
copy_e820_map() type is E820_RAM
copy_e820_map() start: 000000000fef0000 size: 000000000000fc00 end: 000000000feffc00 type: 3
copy_e820_map() start: 000000000feffc00 size: 0000000000000400 end: 000000000ff00000 type: 4
copy_e820_map() start: 000000000ff00000 size: 0000000000100000 end: 0000000010000000 type: 2
copy_e820_map() start: 00000000fff00000 size: 0000000000100000 end: 0000000100000000 type: 2
 BIOS-e820: 0000000000000000 - 000000000009f800 (usable)
 BIOS-e820: 000000000009f800 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000e5c00 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000000fef0000 (usable)
 BIOS-e820: 000000000fef0000 - 000000000feffc00 (ACPI data)
 BIOS-e820: 000000000feffc00 - 000000000ff00000 (ACPI NVS)
 BIOS-e820: 000000000ff00000 - 0000000010000000 (reserved)
 BIOS-e820: 00000000fff00000 - 0000000100000000 (reserved)
254MB LOWMEM available.
Entering add_active_range(0, 0, 65264) 0 entries of 256 used
Zone PFN ranges:
  DMA             0 ->     4096
  Normal       4096 ->    65264
early_node_map[1] active PFN ranges
    0:        0 ->    65264
On node 0 totalpages: 65264
  DMA zone: 32 pages used for memmap
  DMA zone: 0 pages reserved
  DMA zone: 4064 pages, LIFO batch:0
  Normal zone: 477 pages used for memmap
  Normal zone: 60691 pages, LIFO batch:15
DMI 2.2 present.
ACPI: RSDP (v000 PTLTD                                 ) @ 0x000f7380
ACPI: RSDT (v001 PTLTD    RSDT   0x06040000  LTP 0x00000000) @ 0x0fefcece
ACPI: FADT (v001 HP     HPBDD_IP 0x06040000 PTL  0x000f4240) @ 0x0feffb8c
ACPI: DSDT (v001  INTEL  Whitney 0x06040000 MSFT 0x0100000b) @ 0x00000000
ACPI: PM-Timer IO Port: 0x1008
Allocating PCI resources starting at 20000000 (gap: 10000000:eff00000)
Detected 731.008 MHz processor.
Built 1 zonelists.  Total pages: 64755
Kernel command line: auto BOOT_IMAGE=2.6.20 root=305 lapic resume=/dev/hda1 idle=poll
using polling idle threads.
Local APIC disabled by BIOS -- reenabling.
Found and enabled local APIC!
mapped APIC to ffffd000 (fee00000)
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Initializing CPU#0
PID hash table entries: 1024 (order: 10, 4096 bytes)
I-pipe 1.8-08: pipeline enabled.
Console: colour VGA+ 80x25
Dentry cache hash table entries: 32768 (order: 5, 131072 bytes)
Inode-cache hash table entries: 16384 (order: 4, 65536 bytes)
Memory: 253396k/261056k available (2006k kernel code, 7168k reserved, 2228k data, 204k init, 0k highmem)
virtual kernel memory layout:
    fixmap  : 0xfffb7000 - 0xfffff000   ( 288 kB)
    vmalloc : 0xd0800000 - 0xfffb5000   ( 759 MB)
    lowmem  : 0xc0000000 - 0xcfef0000   ( 254 MB)
      .init : 0xc0526000 - 0xc0559000   ( 204 kB)
      .data : 0xc02f5aaf - 0xc0522b2c   (2228 kB)
      .text : 0xc0100000 - 0xc02f5aaf   (2006 kB)
Checking if this processor honours the WP bit even in supervisor mode... Ok.
Calibrating delay using timer specific routine.. 1462.43 BogoMIPS (lpj=731218)
Mount-cache hash table entries: 512
CPU: After generic identify, caps: 0383fbff 00000000 00000000 00000000 00000000 00000000 00000000
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 256K
CPU: After all inits, caps: 0383fbff 00000000 00000000 00000040 00000000 00000000 00000000
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
Compat vDSO mapped to ffffe000.
CPU: Intel Pentium III (Coppermine) stepping 06
Checking 'hlt' instruction... OK.
ACPI: Core revision 20060707
ACPI: setting ELCR to 0200 (from 0e20)
NET: Registered protocol family 16
ACPI: bus type pci registered
PCI: PCI BIOS revision 2.10 entry at 0xfd9ae, last bus=1
PCI: Using configuration type 1
Setting up standard PCI resources
ACPI: Interpreter enabled
ACPI: Using PIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (0000:00)
PCI: Probing PCI hardware (bus 00)
Boot video device is 0000:00:02.0
PCI quirk: region 1000-107f claimed by ICH4 ACPI/GPIO/TCO
PCI quirk: region 1180-11bf claimed by ICH4 GPIO
PCI: Transparent bridge - 0000:00:1e.0
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 7 9 *10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 7 *9 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 *5 7 9 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 7 9 10 *11 12 14 15)
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.HUB_._PRT]
Linux Plug and Play Support v0.97 (c) Adam Belay
usbcore: registered new interface driver usbfs
usbcore: registered new interface driver hub
usbcore: registered new device driver usb
PCI: Using ACPI for IRQ routing
PCI: If a device doesn't work, try "pci=routeirq".  If it helps, post a report
pnp: the driver 'system' has been registered
PCI: Ignore bogus resource 6 [0:0] of 0000:00:02.0
PCI: Bridge: 0000:00:1e.0
  IO window: 2000-2fff
  MEM window: ec100000-ec1fffff
  PREFETCH window: 20000000-200fffff
PCI: Setting latency timer of device 0000:00:1e.0 to 64
NET: Registered protocol family 2
IP route cache hash table entries: 2048 (order: 1, 8192 bytes)
TCP established hash table entries: 8192 (order: 3, 32768 bytes)
TCP bind hash table entries: 4096 (order: 2, 16384 bytes)
TCP: Hash tables configured (established 8192 bind 4096)
TCP reno registered
checking if image is initramfs... it is
Freeing initrd memory: 120k freed
audit: initializing netlink socket (disabled)
audit(1191839887.687:1): initialized
audit: cannot initialize inotify handle
I-pipe: Domain Xenomai registered.
Xenomai: hal/x86 started.
I-pipe: Domain IShield registered.
Xenomai: real-time nucleus v2.3.3 (Summer Song) loaded.
Xenomai: SMI-enabled chipset found, enabling SMI workaround.
Xenomai: starting native API services.
Xenomai: starting RTDM services.
Total HugeTLB memory allocated, 0
fuse init (API version 7.8)
io scheduler noop registered
io scheduler anticipatory registered (default)
io scheduler deadline registered
io scheduler cfq registered
input: Power Button (FF) as /class/input/input0
ACPI: Power Button (FF) [PWRF]
input: Power Button (CM) as /class/input/input1
ACPI: Power Button (CM) [PWRB]
isapnp: Scanning for PnP cards...
isapnp: No Plug & Play device found
Real Time Clock Driver v1.12ac
Linux agpgart interface v0.101 (c) Dave Jones
Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing enabled
serial8250: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
serial8250: ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
pnp: the driver 'serial' has been registered
RAMDISK driver initialized: 16 RAM disks of 32000K size 1024 blocksize
ACPI: PCI Interrupt Link [LNKC] enabled at IRQ 5
PCI: setting IRQ 5 as level-triggered
ACPI: PCI Interrupt 0000:01:04.0[A] -> Link [LNKC] -> GSI 5 (level, low) -> IRQ 5
3c59x: Donald Becker and others. www.scyld.com/network/vortex.html
0000:01:04.0: 3Com PCI 3c905C Tornado at d0806400.
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
ICH: IDE controller at PCI slot 0000:00:1f.1
ICH: chipset revision 2
ICH: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0x1800-0x1807, BIOS settings: hda:pio, hdb:DMA
    ide1: BM-DMA at 0x1808-0x180f, BIOS settings: hdc:DMA, hdd:pio
Probing IDE interface ide0...
hda: Maxtor 31024H1, ATA DISK drive
hdb: ST310211A, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Probing IDE interface ide1...
hdc: CD-540E, ATAPI CD/DVD-ROM drive
ide1 at 0x170-0x177,0x376 on irq 15
hda: max request size: 128KiB
hda: 19746720 sectors (10110 MB) w/2048KiB Cache, CHS=19590/16/63, UDMA(66)
hda: cache flushes not supported
 hda: hda1 hda2 < hda5 >
hdb: max request size: 128KiB
hdb: 19541088 sectors (10005 MB) w/512KiB Cache, CHS=19386/16/63, UDMA(66)
hdb: cache flushes not supported
 hdb: hdb1 hdb2 < hdb5 hdb6 hdb7 >
hdc: ATAPI 40X CD-ROM drive, 128kB Cache, UDMA(33)
Uniform CD-ROM driver Revision: 3.20
USB Universal Host Controller Interface driver v3.0
PCI: Enabling device 0000:00:1f.2 (0000 -> 0001)
ACPI: PCI Interrupt Link [LNKD] enabled at IRQ 11
PCI: setting IRQ 11 as level-triggered
ACPI: PCI Interrupt 0000:00:1f.2[D] -> Link [LNKD] -> GSI 11 (level, low) -> IRQ 11
PCI: Setting latency timer of device 0000:00:1f.2 to 64
uhci_hcd 0000:00:1f.2: UHCI Host Controller
uhci_hcd 0000:00:1f.2: new USB bus registered, assigned bus number 1
uhci_hcd 0000:00:1f.2: irq 11, io base 0x00001820
usb usb1: configuration #1 chosen from 1 choice
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 2 ports detected
usbcore: registered new interface driver usbhid
drivers/usb/input/hid-core.c: v2.6:USB HID core driver
pnp: the driver 'i8042 kbd' has been registered
pnp: the driver 'i8042 aux' has been registered
pnp: the driver 'i8042 kbd' has been unregistered
pnp: the driver 'i8042 aux' has been unregistered
PNP: No PS/2 controller found. Probing ports directly.
serio: i8042 KBD port at 0x60,0x64 irq 1
serio: i8042 AUX port at 0x60,0x64 irq 12
mice: PS/2 mouse device common for all mice
pnp: the driver 'irqbench' has been registered
TCP cubic registered
NET: Registered protocol family 1
NET: Registered protocol family 17
Testing NMI watchdog ... OK.
Using IPI Shortcut mode
Time: tsc clocksource has been installed.
ACPI: (supports S0 S1 S4 S5)
BIOS EDD facility v0.16 2004-Jun-25, 2 devices found
Freeing unused kernel memory: 204k freed
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
input: ImPS/2 Logitech Wheel Mouse as /class/input/input2
input: AT Translated Set 2 keyboard as /class/input/input3
agpgart: Detected an Intel i815 Chipset.
agpgart: AGP aperture is 64M @ 0xf0000000
EXT3 FS on hda5, internal journal
Adding 273064k swap on /dev/hda1.  Priority:-1 extents:1 across:273064k
kjournald starting.  Commit interval 5 seconds
EXT3 FS on hdb1, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on hdb5, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
eth0:  setting half-duplex.
eth0:  setting full-duplex.

--------------060007060800030501000303--

