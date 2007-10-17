Message-ID: <47160AD3.4090109@domain.hid>
Date: Wed, 17 Oct 2007 15:14:59 +0200
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
	<1192612658.5973.11.camel@domain.hid>
In-Reply-To: <1192612658.5973.11.camel@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
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

> 
> This one should fix the pending issues:
> http://download.gna.org/adeos/patches/v2.6/i386/adeos-ipipe-2.6.20-i386-1.10-09.patch
> 
>> David


The latest patch works fine, here the new results with :
- vanillia 2.6.20 patched with Xenomai 2.3.3
- added debug info according your last post


---|------------|------------|------------|--------|-------------------------
RTS|       5.975|      10.136|      98.264|       0|    00:09:40/00:09:40


(the header shows rev.08 but this is really 1.10-09).


I-pipe frozen back-tracing service on 2.6.20/ipipe-1.10-08
------------------------------------------------------------
CPU: 0, Freeze: 1765415011903 cycles, Trace Points: 128 (+10)
Calibrated minimum trace-point overhead: 0.258 us

  +----- Hard IRQs ('|': locked)
  |+---- <unused>
  ||+--- Xenomai
  |||+-- IShield
  ||||+- Linux ('*': domain stalled, '+': current, '#': current+stalled)
  |||||                        +---------- Delay flag ('+': > 1 us, '!': 
 > 10 us)
  |||||                        |        +- NMI noise ('N')
  |||||                        |        |
       Type    User Val.   Time    Delay  Function (Parent)
:    #func                -139    0.422  __ipipe_restore_root+0x8 
(boomerang_start_xmit+0x1d0)
:    #func                -138    0.349  __ipipe_unstall_root+0x8 
(__ipipe_restore_root+0x27)
:|   #begin   0x80000000  -138    0.356  __ipipe_unstall_root+0x4d 
(__ipipe_restore_root+0x27)
:|   +end     0x80000000  -138    0.355  __ipipe_unstall_root+0x3f 
(__ipipe_restore_root+0x27)
:    +func                -137    0.430  ipipe_check_context+0xc 
(boomerang_start_xmit+0x1da)
:    +func                -137    0.281  ipipe_check_context+0xc 
(__qdisc_run+0x134)
:    +func                -137    0.308  ipipe_check_context+0xc 
(__qdisc_run+0x7a)
:    +func                -136    0.338  pfifo_fast_dequeue+0x9 
(__qdisc_run+0x99)
:    +func                -136    0.340  ipipe_check_context+0xc 
(dev_queue_xmit+0x93)
:    +func                -136    0.286  local_bh_enable+0xb 
(dev_queue_xmit+0xa1)
:    +func                -135    0.344  ipipe_check_context+0xc 
(local_bh_enable+0x52)
:    +func                -135    0.311  update_send_head+0xa 
(__tcp_push_pending_frames+0x122)
:    +func                -135    0.427  tcp_init_tso_segs+0x16 
(__tcp_push_pending_frames+0x154)
:    +func                -134    0.683  tcp_set_skb_tso_segs+0x16 
(tcp_init_tso_segs+0x46)
:    +func                -133    0.308  tcp_transmit_skb+0xe 
(__tcp_push_pending_frames+0x10f)
:    +func                -133    0.862  skb_clone+0xe 
(tcp_transmit_skb+0x6d)
:    +func                -132    0.468  __tcp_select_window+0xe 
(tcp_transmit_skb+0x19b)
:    +func                -132    0.416  tcp_v4_send_check+0x14 
(tcp_transmit_skb+0x45a)
:    +func                -131    0.297  ip_queue_xmit+0xe 
(tcp_transmit_skb+0x3b0)
:    +func                -131    0.564  __sk_dst_check+0x11 
(ip_queue_xmit+0x29e)
:    +func                -131    0.616  ip_output+0xe (ip_queue_xmit+0x1ac)
:    +func                -130    0.310  dev_queue_xmit+0xe 
(ip_output+0x10b)
:    +func                -130    0.296  local_bh_disable+0x8 
(dev_queue_xmit+0x43)
:    +func                -129    0.284  ipipe_check_context+0xc 
(dev_queue_xmit+0x5d)
:    +func                -129    0.422  pfifo_fast_enqueue+0xa 
(dev_queue_xmit+0x71)
:    +func                -129    0.282  __qdisc_run+0xe 
(dev_queue_xmit+0x1df)
:    +func                -128    0.352  pfifo_fast_dequeue+0x9 
(__qdisc_run+0x99)
:    +func                -128    0.274  ipipe_check_context+0xc 
(__qdisc_run+0x10a)
:    +func                -128    0.330  ipipe_check_context+0xc 
(__qdisc_run+0x54)
:    +func                -127    0.277  dev_hard_start_xmit+0xe 
(__qdisc_run+0x64)
:    +func                -127    0.310  ipipe_check_context+0xc 
(dev_hard_start_xmit+0x4f)
:    +func                -127    0.304  skb_clone+0xe 
(dev_hard_start_xmit+0xa9)
:    +func                -126    0.366  kmem_cache_alloc+0x14 
(skb_clone+0x3c)
:    +func                -126    0.290  ipipe_check_context+0xc 
(kmem_cache_alloc+0x27)
:    #func                -126    0.345  __ipipe_restore_root+0x8 
(kmem_cache_alloc+0x68)
:    #func                -125    0.363  __ipipe_unstall_root+0x8 
(__ipipe_restore_root+0x27)
:|   #begin   0x80000000  -125    0.471  __ipipe_unstall_root+0x4d 
(__ipipe_restore_root+0x27)
:|   +end     0x80000000  -125    0.586  __ipipe_unstall_root+0x3f 
(__ipipe_restore_root+0x27)
:    +func                -124    0.322  packet_rcv_spkt+0x14 
(dev_hard_start_xmit+0xfe)
:    +func                -124    0.396  strlcpy+0x14 (packet_rcv_spkt+0x8e)
:    +func                -123    0.284  sock_queue_rcv_skb+0x14 
(packet_rcv_spkt+0xa0)
:    +func                -123    0.284  local_bh_disable+0x8 
(sock_queue_rcv_skb+0x45)
:    +func                -123    0.575  sk_run_filter+0x14 
(sock_queue_rcv_skb+0x5c)
:    +func                -122    0.281  local_bh_enable+0xb 
(sock_queue_rcv_skb+0xd5)
:    +func                -122    0.413  ipipe_check_context+0xc 
(local_bh_enable+0x52)
:    +func                -122    0.415  kfree_skb+0x8 
(packet_rcv_spkt+0xab)
:    +func                -121    0.286  __kfree_skb+0x11 (kfree_skb+0x1e)
:    +func                -121    0.362  kfree_skbmem+0x9 (__kfree_skb+0x47)
:    +func                -120    0.594  skb_release_data+0xa 
(kfree_skbmem+0x10)
:    +func                -120    0.271  kmem_cache_free+0xe 
(kfree_skbmem+0x3d)
:    +func                -120    0.321  ipipe_check_context+0xc 
(kmem_cache_free+0x40)
:    #func                -119    0.334  __ipipe_restore_root+0x8 
(kmem_cache_free+0x84)
:    #func                -119    0.382  __ipipe_unstall_root+0x8 
(__ipipe_restore_root+0x27)
:|   #begin   0x80000000  -119    0.377  __ipipe_unstall_root+0x4d 
(__ipipe_restore_root+0x27)
:|   +end     0x80000000  -118    0.420  __ipipe_unstall_root+0x3f 
(__ipipe_restore_root+0x27)
:    +func                -118    0.307  ipipe_check_context+0xc 
(dev_hard_start_xmit+0x10d)
:    +func                -117    0.437  boomerang_start_xmit+0xe 
(dev_hard_start_xmit+0x1cb)
:    +func                -117    0.286  ipipe_check_context+0xc 
(boomerang_start_xmit+0x123)
:    #func                -117    0.353  ipipe_check_context+0xc 
(boomerang_start_xmit+0x163)
:    #func                -116    0.282  issue_and_wait+0xe 
(boomerang_start_xmit+0x170)
:    #func                -116    0.474  iowrite16+0x8 (issue_and_wait+0x2a)
:    #func                -116+   5.673  ioread16+0x8 (issue_and_wait+0x45)
:|   #begin   0xffffff16  -110    0.439  ipipe_ipi3+0x2e (ioread16+0x14)
:|   #func                -109    0.431  __ipipe_handle_irq+0x14 
(ipipe_ipi3+0x33)
:|   #func                -109    0.435  __ipipe_ack_apic+0x8 
(__ipipe_handle_irq+0x8f)
:|   #func                -109    0.390  __ipipe_dispatch_wired+0x16 
(__ipipe_handle_irq+0x4f)
:| # *func                -108    0.513  xnintr_clock_handler+0x8 
(__ipipe_dispatch_wired+0xaa)
:| # *func                -108    0.446  xnintr_irq_handler+0xe 
(xnintr_clock_handler+0x17)
:| # *func                -107    0.467  xnpod_announce_tick+0x8 
(xnintr_irq_handler+0x3b)
:| # *func                -107    0.520  xntimer_do_tick_aperiodic+0xe 
(xnpod_announce_tick+0xf)
:| # *func                -106    0.334  xnthread_periodic_handler+0x8 
(xntimer_do_tick_aperiodic+0x217)
:| # *func                -106    0.329  xnpod_resume_thread+0xe 
(xnthread_periodic_handler+0x2c)
:| # *[ 3912] samplin 99  -106+   1.099  xnpod_resume_thread+0x5d 
(xnthread_periodic_handler+0x2c)
:| # *func                -105    0.390  xnpod_schedule+0xe 
(xnintr_irq_handler+0x135)
:| # *[ 3487] konsole -1  -104+   1.191  xnpod_schedule+0x97 
(xnintr_irq_handler+0x135)
:| # *func                -103    0.576  __switch_to+0xe 
(xnpod_schedule+0x498)
:| # *[ 3912] samplin 99  -102    0.752  xnpod_schedule+0x570 
(xnpod_suspend_thread+0x19b)
:| # *func                -102    0.366 
__ipipe_restore_pipeline_head+0x12 (xnpod_wait_thread_period+0x138)
:| + *end     0x80000000  -101!  14.474 
__ipipe_restore_pipeline_head+0x7e (xnpod_wait_thread_period+0x138)
:| + *begin   0xfffffff1   -87    0.385  common_interrupt+0x29 
(__ipipe_restore_pipeline_head+0x82)
:| + *func                 -86    0.923  __ipipe_handle_irq+0x14 
(common_interrupt+0x2e)
:| + *func                 -85    0.561  __ipipe_set_irq_pending+0x16 
(__ipipe_handle_irq+0x124)
:| + *func                 -85    0.463  __ipipe_ack_irq+0x8 
(__ipipe_handle_irq+0x13d)
:| + *func                 -84    0.319  __ipipe_ack_level_irq+0x12 
(__ipipe_ack_irq+0x19)
:| + *func                 -84    0.389  mask_and_ack_8259A+0x14 
(__ipipe_ack_level_irq+0x22)
:| + *func                 -84    0.397  __ipipe_spin_lock_irqsave+0x9 
(mask_and_ack_8259A+0x29)
:| # *(0x11)  0x0000000e   -83!  17.062  mask_and_ack_8259A+0xbc 
(__ipipe_ack_level_irq+0x22)
:| # *(0x22)  0x0000000e   -66!  23.096  mask_and_ack_8259A+0xca 
(__ipipe_ack_level_irq+0x22)
:| # *(0x33)  0x0000000e   -43    0.415  mask_and_ack_8259A+0xf3 
(__ipipe_ack_level_irq+0x22)
:| # *func                 -43    0.418 
__ipipe_spin_unlock_irqrestore+0x9 (mask_and_ack_8259A+0x67)
:| + *func                 -42    0.397  __ipipe_walk_pipeline+0xa 
(__ipipe_handle_irq+0x62)
:| + *end     0xfffffff1   -42+   6.601  common_interrupt+0x38 
(__ipipe_restore_pipeline_head+0x82)
:| + *begin   0xfffffffa   -35    0.523  common_interrupt+0x29 
(__ipipe_restore_pipeline_head+0x82)
:| + *func                 -35    0.435  __ipipe_handle_irq+0x14 
(common_interrupt+0x2e)
:| + *func                 -34    0.342  __ipipe_set_irq_pending+0x16 
(__ipipe_handle_irq+0x124)
:| + *func                 -34    0.304  __ipipe_ack_irq+0x8 
(__ipipe_handle_irq+0x13d)
:| + *func                 -34    0.378  __ipipe_ack_level_irq+0x12 
(__ipipe_ack_irq+0x19)
:| + *func                 -33    0.301  mask_and_ack_8259A+0x14 
(__ipipe_ack_level_irq+0x22)
:| + *func                 -33!  15.117  __ipipe_spin_lock_irqsave+0x9 
(mask_and_ack_8259A+0x29)
:| # *func                 -18    0.430 
__ipipe_spin_unlock_irqrestore+0x9 (mask_and_ack_8259A+0x67)
:| + *func                 -18    0.475  __ipipe_walk_pipeline+0xa 
(__ipipe_handle_irq+0x62)
:| + *end     0xfffffffa   -17    0.796  common_interrupt+0x38 
(__ipipe_restore_pipeline_head+0x82)
:| + *begin   0x80000001   -16    0.478  __ipipe_dispatch_event+0x1b1 
(__ipipe_syscall_root+0x44)
:| + *end     0x80000001   -16+   2.710  __ipipe_dispatch_event+0x17e 
(__ipipe_syscall_root+0x44)
:| + *begin   0xffffff16   -13    0.433  ipipe_ipi3+0x2e (<b7f40dba>)
:| + *func                 -13    0.345  __ipipe_handle_irq+0x14 
(ipipe_ipi3+0x33)
:| + *func                 -12    0.360  __ipipe_ack_apic+0x8 
(__ipipe_handle_irq+0x8f)
:| + *func                 -12    0.345  __ipipe_dispatch_wired+0x16 
(__ipipe_handle_irq+0x4f)
:| # *func                 -12    0.370  xnintr_clock_handler+0x8 
(__ipipe_dispatch_wired+0xaa)
:| # *func                 -11    0.418  xnintr_irq_handler+0xe 
(xnintr_clock_handler+0x17)
:| # *func                 -11    0.306  xnpod_announce_tick+0x8 
(xnintr_irq_handler+0x3b)
:| # *func                 -10    0.415  xntimer_do_tick_aperiodic+0xe 
(xnpod_announce_tick+0xf)
:| # *func                 -10+   1.198  xnthread_periodic_handler+0x8 
(xntimer_do_tick_aperiodic+0x217)
:| + *func                  -9    0.382  __ipipe_walk_pipeline+0xa 
(__ipipe_handle_irq+0x62)
:| + *end     0xffffff16    -8+   1.598  ipipe_ipi3+0x3d (<b7f40dba>)
:  + *func                  -7    0.364  __ipipe_syscall_root+0xa 
(system_call+0x29)
:  + *func                  -7    0.409  __ipipe_dispatch_event+0xe 
(__ipipe_syscall_root+0x44)
:| + *begin   0x80000001    -6    0.424  __ipipe_dispatch_event+0x1d0 
(__ipipe_syscall_root+0x44)
:| + *end     0x80000001    -6    0.409  __ipipe_dispatch_event+0x1c0 
(__ipipe_syscall_root+0x44)
:  + *func                  -5+   1.158  hisyscall_event+0x14 
(__ipipe_dispatch_event+0xc0)
:  + *func                  -4+   1.166  xnshadow_sys_trace+0x16 
(hisyscall_event+0x189)
:  + *func                  -3    0.502  ipipe_trace_frozen_reset+0x9 
(xnshadow_sys_trace+0xd7)
:  + *func                  -2    0.307  __ipipe_global_path_lock+0x8 
(ipipe_trace_frozen_reset+0x13)
:  + *func                  -2    0.340  __ipipe_spin_lock_irqsave+0x9 
(__ipipe_global_path_lock+0x12)
:| + *begin   0x80000001    -2+   1.322  __ipipe_spin_lock_irqsave+0x4b 
(__ipipe_global_path_lock+0x12)
:| # *func                   0    0.516 
__ipipe_spin_unlock_irqcomplete+0x9 (__ipipe_global_path_unlock+0x63)
:| + *end     0x80000001     0    0.446 
__ipipe_spin_unlock_irqcomplete+0x38 (__ipipe_global_path_unlock+0x63)
<  + *freeze  0x00017fd8     0    0.513  xnshadow_sys_trace+0xa0 
(hisyscall_event+0x189)
  | + *begin   0x80000001     0    0.426  __ipipe_dispatch_event+0x1b1 
(__ipipe_syscall_root+0x44)
  | + *end     0x80000001     0    0.942  __ipipe_dispatch_event+0x17e 
(__ipipe_syscall_root+0x44)
    + *func                   1    0.311  __ipipe_syscall_root+0xa 
(system_call+0x29)
    + *func                   2    0.329  __ipipe_dispatch_event+0xe 
(__ipipe_syscall_root+0x44)
  | + *begin   0x80000001     2    0.422  __ipipe_dispatch_event+0x1d0 
(__ipipe_syscall_root+0x44)
  | + *end     0x80000001     2    0.351  __ipipe_dispatch_event+0x1c0 
(__ipipe_syscall_root+0x44)
    + *func                   3    0.433  hisyscall_event+0x14 
(__ipipe_dispatch_event+0xc0)
    + *func                   3    0.333  __rt_task_wait_period+0x11 
(hisyscall_event+0x189)
    + *func                   4    0.472  rt_task_wait_period+0x8 
(__rt_task_wait_period+0x21)
    + *func                   4    0.000  xnpod_wait_thread_period+0xe 
(rt_task_wait_period+0x38)




