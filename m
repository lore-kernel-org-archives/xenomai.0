Message-ID: <471621C8.9070006@domain.hid>
Date: Wed, 17 Oct 2007 16:52:56 +0200
From: "CHABAL David" <david.chabal@domain.hid>
MIME-Version: 1.0
References: <4705ED3B.4070600@domain.hid>	
	<2ff1a98a0710050130j7e0db84dq838aab0417c8bd3f@domain.hid>	
	<4705FE04.7000909@domain.hid> <1191576011.20623.114.camel@domain.hid>	
	<470611FA.30103@domain.hid> <1191592977.20623.142.camel@domain.hid>	
	<470A26BC.506@domain.hid> <1192015852.22917.197.camel@domain.hid>	
	<470F7F2E.3020206@domain.hid> <470F82FF.9020701@domain.hid>	
	<1192203284.6499.135.camel@domain.hid> <470F978B.1000005@domain.hid>	
	<1192207431.6499.161.camel@domain.hid> <4715C70F.4040501@domain.hid>	
	<1192610471.5973.4.camel@domain.hid> <4715CE15.10202@domain.hid>	
	<1192612658.5973.11.camel@domain.hid> <47160AD3.4090109@domain.hid>
	<1192628763.5973.16.camel@domain.hid>
In-Reply-To: <1192628763.5973.16.camel@domain.hid>
Content-Type: multipart/mixed; boundary="------------000707030104060200010307"
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
--------------000707030104060200010307
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable

>=20
> Grmmff... I think the PIC on this box has some deep troubles; please tr=
y
> this patch, in replacement of the previous ipipe_trace_special
> instrumentation:
>=20


RTD|       8.348|      10.387|      43.647|       0|       6.098|=20
80.440
---|------------|------------|------------|--------|---------------------=
----
RTS|       6.098|      10.020|      80.440|       0|    00:17:20/00:17:20
[root@domain.hid bin]#


IRQ handling takes 17=B5s in the worst case.

It takes a long time to write 3 poor bytes...

May be is it a SMI problem ??? (Globally disable SMI is on)

David

--------------000707030104060200010307
Content-Type: text/plain;
 name="freeze.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="freeze.txt"

I-pipe frozen back-tracing service on 2.6.20/ipipe-1.10-08
------------------------------------------------------------
CPU: 0, Freeze: 1199670455059 cycles, Trace Points: 128 (+10)
Calibrated minimum trace-point overhead: 0.258 us

 +----- Hard IRQs ('|': locked)
 |+---- <unused>
 ||+--- Xenomai
 |||+-- IShield
 ||||+- Linux ('*': domain stalled, '+': current, '#': current+stalled)
 |||||                        +---------- Delay flag ('+': > 1 us, '!': > 10 us)
 |||||                        |        +- NMI noise ('N')
 |||||                        |        |
      Type    User Val.   Time    Delay  Function (Parent)
:    +func                -127    0.340  skb_release_data+0xa (kfree_skbmem+0x10)
:    +func                -127    0.271  kmem_cache_free+0xe (kfree_skbmem+0x3d)
:    +func                -126    0.315  ipipe_check_context+0xc (kmem_cache_free+0x40)
:    #func                -126    0.334  __ipipe_restore_root+0x8 (kmem_cache_free+0x84)
:    #func                -126    0.300  __ipipe_unstall_root+0x8 (__ipipe_restore_root+0x27)
:|   #begin   0x80000000  -126    0.377  __ipipe_unstall_root+0x4d (__ipipe_restore_root+0x27)
:|   +end     0x80000000  -125    0.420  __ipipe_unstall_root+0x3f (__ipipe_restore_root+0x27)
:    +func                -125    0.307  ipipe_check_context+0xc (dev_hard_start_xmit+0x10d)
:    +func                -124    0.345  boomerang_start_xmit+0xe (dev_hard_start_xmit+0x1cb)
:    +func                -124    0.285  ipipe_check_context+0xc (boomerang_start_xmit+0x123)
:    #func                -124    0.353  ipipe_check_context+0xc (boomerang_start_xmit+0x163)
:    #func                -123    0.275  issue_and_wait+0xe (boomerang_start_xmit+0x170)
:    #func                -123    0.403  iowrite16+0x8 (issue_and_wait+0x2a)
:    #func                -123+   5.960  ioread16+0x8 (issue_and_wait+0x45)
:    #func                -117+   7.038  ioread32+0x8 (boomerang_start_xmit+0x188)
:    #func                -110    0.459  iowrite16+0x8 (boomerang_start_xmit+0x1c9)
:    #func                -109    0.352  __ipipe_restore_root+0x8 (boomerang_start_xmit+0x1d0)
:    #func                -109    0.385  __ipipe_unstall_root+0x8 (__ipipe_restore_root+0x27)
:|   #begin   0x80000000  -109    0.341  __ipipe_unstall_root+0x4d (__ipipe_restore_root+0x27)
:|   +end     0x80000000  -108    0.353  __ipipe_unstall_root+0x3f (__ipipe_restore_root+0x27)
:    +func                -108    0.346  ipipe_check_context+0xc (boomerang_start_xmit+0x1da)
:    +func                -108    0.274  ipipe_check_context+0xc (__qdisc_run+0x134)
:    +func                -107    0.285  ipipe_check_context+0xc (__qdisc_run+0x7a)
:    +func                -107    0.300  pfifo_fast_dequeue+0x9 (__qdisc_run+0x99)
:    +func                -107    0.271  ipipe_check_context+0xc (dev_queue_xmit+0x93)
:    +func                -106    0.281  local_bh_enable+0xb (dev_queue_xmit+0xa1)
:    +func                -106    0.338  ipipe_check_context+0xc (local_bh_enable+0x52)
:    +func                -106    0.390  update_send_head+0xa (__tcp_push_pending_frames+0x122)
:    +func                -105    0.381  tcp_cwnd_validate+0x8 (__tcp_push_pending_frames+0x2d3)
:    +func                -105    0.554  tcp_check_space+0x9 (tcp_rcv_established+0x410)
:    +func                -104    0.378  ipipe_check_context+0xc (tcp_v4_rcv+0x58a)
:    +func                -104    0.379  ipipe_check_context+0xc (ip_local_deliver+0xe7)
:    +func                -104    0.334  ipipe_check_context+0xc (netif_receive_skb+0x172)
:    +func                -103    0.331  ipipe_check_context+0xc (process_backlog+0x4a)
:    #func                -103    0.371  __ipipe_unstall_root+0x8 (process_backlog+0x84)
:|   #begin   0x80000000  -103    0.322  __ipipe_unstall_root+0x4d (process_backlog+0x84)
:|   +end     0x80000000  -102    0.371  __ipipe_unstall_root+0x3f (process_backlog+0x84)
:    +func                -102    0.341  netif_receive_skb+0xe (process_backlog+0x8e)
:    +func                -102    0.418  ipipe_check_context+0xc (netif_receive_skb+0x7f)
:    +func                -101    0.295  packet_rcv_spkt+0x14 (netif_receive_skb+0x14a)
:    +func                -101    0.269  skb_clone+0xe (packet_rcv_spkt+0xcc)
:    +func                -101    0.269  kmem_cache_alloc+0x14 (skb_clone+0x3c)
:    +func                -100    0.307  ipipe_check_context+0xc (kmem_cache_alloc+0x27)
:    #func                -100    0.355  __ipipe_restore_root+0x8 (kmem_cache_alloc+0x68)
:    #func                -100    0.375  __ipipe_unstall_root+0x8 (__ipipe_restore_root+0x27)
:|   #begin   0x80000000   -99    0.448  __ipipe_unstall_root+0x4d (__ipipe_restore_root+0x27)
:|   +end     0x80000000   -99    0.509  __ipipe_unstall_root+0x3f (__ipipe_restore_root+0x27)
:    +func                 -98    0.356  kfree_skb+0x8 (packet_rcv_spkt+0xd5)
:    +func                 -98    0.396  strlcpy+0x14 (packet_rcv_spkt+0x8e)
:    +func                 -98    0.265  sock_queue_rcv_skb+0x14 (packet_rcv_spkt+0xa0)
:    +func                 -97    0.285  local_bh_disable+0x8 (sock_queue_rcv_skb+0x45)
:    +func                 -97    0.540  sk_run_filter+0x14 (sock_queue_rcv_skb+0x5c)
:    +func                 -97    0.281  local_bh_enable+0xb (sock_queue_rcv_skb+0xd5)
:    +func                 -96    0.289  ipipe_check_context+0xc (local_bh_enable+0x52)
:    +func                 -96    0.295  kfree_skb+0x8 (packet_rcv_spkt+0xab)
:    +func                 -96    0.269  __kfree_skb+0x11 (kfree_skb+0x1e)
:    +func                 -95    0.336  kfree_skbmem+0x9 (__kfree_skb+0x47)
:    +func                 -95    0.362  skb_release_data+0xa (kfree_skbmem+0x10)
:    +func                 -95    0.327  kmem_cache_free+0xe (kfree_skbmem+0x3d)
:    +func                 -94    0.278  ipipe_check_context+0xc (kmem_cache_free+0x40)
:    #func                 -94    0.334  __ipipe_restore_root+0x8 (kmem_cache_free+0x84)
:    #func                 -94    0.371  __ipipe_unstall_root+0x8 (__ipipe_restore_root+0x27)
:|   #begin   0x80000000   -93    0.344  __ipipe_unstall_root+0x4d (__ipipe_restore_root+0x27)
:|   +end     0x80000000   -93    0.445  __ipipe_unstall_root+0x3f (__ipipe_restore_root+0x27)
:    +func                 -93    0.493  ip_rcv+0x14 (netif_receive_skb+0x166)
:    +func                 -92    0.306  ip_route_input+0x11 (ip_rcv+0x338)
:    +func                 -92    0.321  rt_hash_code+0x9 (ip_route_input+0x3d)
:    +func                 -91    0.403  ipipe_check_context+0xc (ip_route_input+0x49)
:    +func                 -91    0.385  ipipe_check_context+0xc (ip_route_input+0xd2)
:    +func                 -91    0.311  ip_local_deliver+0xe (ip_rcv+0x226)
:    +func                 -90    0.374  ipipe_check_context+0xc (ip_local_deliver+0x6d)
:    +func                 -90    0.614  tcp_v4_rcv+0xe (ip_local_deliver+0xa8)
:|   +begin   0xffffff16   -89    0.375  ipipe_ipi3+0x2e (tcp_v4_rcv+0xfa)
:|   +func                 -89    0.368  __ipipe_handle_irq+0x14 (ipipe_ipi3+0x33)
:|   +func                 -89    0.337  __ipipe_ack_apic+0x8 (__ipipe_handle_irq+0x8f)
:|   +func                 -88    0.382  __ipipe_dispatch_wired+0x16 (__ipipe_handle_irq+0x4f)
:| #  func                 -88    0.370  xnintr_clock_handler+0x8 (__ipipe_dispatch_wired+0xaa)
:| #  func                 -88    0.353  xnintr_irq_handler+0xe (xnintr_clock_handler+0x17)
:| #  func                 -87    0.353  xnpod_announce_tick+0x8 (xnintr_irq_handler+0x3b)
:| #  func                 -87    0.500  xntimer_do_tick_aperiodic+0xe (xnpod_announce_tick+0xf)
:| #  func                 -86    0.301  xnthread_periodic_handler+0x8 (xntimer_do_tick_aperiodic+0x217)
:| #  func                 -86    0.322  xnpod_resume_thread+0xe (xnthread_periodic_handler+0x2c)
:| #  [ 3875] samplin 99   -86+   1.013  xnpod_resume_thread+0x5d (xnthread_periodic_handler+0x2c)
:| #  func                 -85    0.404  xnpod_schedule+0xe (xnintr_irq_handler+0x135)
:| #  [ 3463] konsole -1   -84+   1.075  xnpod_schedule+0x97 (xnintr_irq_handler+0x135)
:| #  func                 -83    0.647  __switch_to+0xe (xnpod_schedule+0x498)
:| #  [ 3875] samplin 99   -83    0.629  xnpod_schedule+0x570 (xnpod_suspend_thread+0x19b)
:| #  func                 -82    0.327  __ipipe_restore_pipeline_head+0x12 (xnpod_wait_thread_period+0x138)
:| +  end     0x80000000   -82!  26.569  __ipipe_restore_pipeline_head+0x7e (xnpod_wait_thread_period+0x138)
:| +  begin   0xfffffff1   -55    0.371  common_interrupt+0x29 (__ipipe_restore_pipeline_head+0x82)
:| +  func                 -55    0.886  __ipipe_handle_irq+0x14 (common_interrupt+0x2e)
:| +  func                 -54    0.540  __ipipe_set_irq_pending+0x16 (__ipipe_handle_irq+0x124)
:| +  func                 -53    0.457  __ipipe_ack_irq+0x8 (__ipipe_handle_irq+0x13d)
:| +  func                 -53    0.323  __ipipe_ack_level_irq+0x12 (__ipipe_ack_irq+0x19)
:| +  func                 -52    0.303  mask_and_ack_8259A+0x14 (__ipipe_ack_level_irq+0x22)
:| +  func                 -52    0.308  __ipipe_spin_lock_irqsave+0x9 (mask_and_ack_8259A+0x29)
:| #  (0x77)  0x0000000e   -52!  16.894  mask_and_ack_8259A+0x3f (__ipipe_ack_level_irq+0x22)
:| #  (0x99)  0x0000000e   -35    0.310  mask_and_ack_8259A+0x7b (__ipipe_ack_level_irq+0x22)
:| #  func                 -35    0.386  __ipipe_spin_unlock_irqrestore+0x9 (mask_and_ack_8259A+0x87)
:| +  func                 -34    0.370  __ipipe_walk_pipeline+0xa (__ipipe_handle_irq+0x62)
:| +  end     0xfffffff1   -34+   6.810  common_interrupt+0x38 (__ipipe_restore_pipeline_head+0x82)
:| +  begin   0xfffffffa   -27    0.379  common_interrupt+0x29 (__ipipe_restore_pipeline_head+0x82)
:| +  func                 -27    0.364  __ipipe_handle_irq+0x14 (common_interrupt+0x2e)
:| +  func                 -26    0.307  __ipipe_set_irq_pending+0x16 (__ipipe_handle_irq+0x124)
:| +  func                 -26    0.285  __ipipe_ack_irq+0x8 (__ipipe_handle_irq+0x13d)
:| +  func                 -26    0.278  __ipipe_ack_level_irq+0x12 (__ipipe_ack_irq+0x19)
:| +  func                 -25    0.284  mask_and_ack_8259A+0x14 (__ipipe_ack_level_irq+0x22)
:| +  func                 -25    0.290  __ipipe_spin_lock_irqsave+0x9 (mask_and_ack_8259A+0x29)
:| #  (0x77)  0x00000005   -25!  12.952  mask_and_ack_8259A+0x3f (__ipipe_ack_level_irq+0x22)
:| #  (0x99)  0x00000005   -12    0.288  mask_and_ack_8259A+0x7b (__ipipe_ack_level_irq+0x22)
:| #  func                 -12    0.355  __ipipe_spin_unlock_irqrestore+0x9 (mask_and_ack_8259A+0x87)
:| +  func                 -11    0.327  __ipipe_walk_pipeline+0xa (__ipipe_handle_irq+0x62)
:| +  end     0xfffffffa   -11    0.760  common_interrupt+0x38 (__ipipe_restore_pipeline_head+0x82)
:| +  begin   0x80000001   -10    0.463  __ipipe_dispatch_event+0x1b1 (__ipipe_syscall_root+0x44)
:| +  end     0x80000001   -10+   3.172  __ipipe_dispatch_event+0x17e (__ipipe_syscall_root+0x44)
:  +  func                  -7    0.314  __ipipe_syscall_root+0xa (system_call+0x29)
:  +  func                  -6    0.326  __ipipe_dispatch_event+0xe (__ipipe_syscall_root+0x44)
:| +  begin   0x80000001    -6    0.407  __ipipe_dispatch_event+0x1d0 (__ipipe_syscall_root+0x44)
:| +  end     0x80000001    -6    0.356  __ipipe_dispatch_event+0x1c0 (__ipipe_syscall_root+0x44)
:  +  func                  -5+   1.032  hisyscall_event+0x14 (__ipipe_dispatch_event+0xc0)
:  +  func                  -4+   1.234  xnshadow_sys_trace+0x16 (hisyscall_event+0x189)
:  +  func                  -3    0.442  ipipe_trace_frozen_reset+0x9 (xnshadow_sys_trace+0xd7)
:  +  func                  -2    0.271  __ipipe_global_path_lock+0x8 (ipipe_trace_frozen_reset+0x13)
:  +  func                  -2    0.303  __ipipe_spin_lock_irqsave+0x9 (__ipipe_global_path_lock+0x12)
:| +  begin   0x80000001    -2+   1.545  __ipipe_spin_lock_irqsave+0x4b (__ipipe_global_path_lock+0x12)
:| #  func                   0    0.413  __ipipe_spin_unlock_irqcomplete+0x9 (__ipipe_global_path_unlock+0x63)
:| +  end     0x80000001     0    0.422  __ipipe_spin_unlock_irqcomplete+0x38 (__ipipe_global_path_unlock+0x63)
<  +  freeze  0x00013a38     0    0.454  xnshadow_sys_trace+0xa0 (hisyscall_event+0x189)
 | +  begin   0x80000001     0    0.363  __ipipe_dispatch_event+0x1b1 (__ipipe_syscall_root+0x44)
 | +  end     0x80000001     0    0.886  __ipipe_dispatch_event+0x17e (__ipipe_syscall_root+0x44)
   +  func                   1    0.292  __ipipe_syscall_root+0xa (system_call+0x29)
   +  func                   1    0.293  __ipipe_dispatch_event+0xe (__ipipe_syscall_root+0x44)
 | +  begin   0x80000001     2    0.322  __ipipe_dispatch_event+0x1d0 (__ipipe_syscall_root+0x44)
 | +  end     0x80000001     2    0.329  __ipipe_dispatch_event+0x1c0 (__ipipe_syscall_root+0x44)
   +  func                   2    0.412  hisyscall_event+0x14 (__ipipe_dispatch_event+0xc0)
   +  func                   3    0.315  __rt_task_wait_period+0x11 (hisyscall_event+0x189)
   +  func                   3    0.364  rt_task_wait_period+0x8 (__rt_task_wait_period+0x21)
   +  func                   4    0.000  xnpod_wait_thread_period+0xe (rt_task_wait_period+0x38)

--------------000707030104060200010307--

