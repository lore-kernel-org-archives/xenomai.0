Message-ID: <470F7F2E.3020206@domain.hid>
Date: Fri, 12 Oct 2007 16:05:34 +0200
From: "CHABAL David" <david.chabal@domain.hid>
MIME-Version: 1.0
References: <4705ED3B.4070600@domain.hid>	
	<2ff1a98a0710050130j7e0db84dq838aab0417c8bd3f@domain.hid>	
	<4705FE04.7000909@domain.hid> <1191576011.20623.114.camel@domain.hid>	
	<470611FA.30103@domain.hid> <1191592977.20623.142.camel@domain.hid>	
	<470A26BC.506@domain.hid> <1192015852.22917.197.camel@domain.hid>
In-Reply-To: <1192015852.22917.197.camel@domain.hid>
Content-Type: multipart/mixed; boundary="------------040307020807060107030204"
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
--------------040307020807060107030204
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable

Philippe Gerum a =E9crit :
>=20
> I suspect the tracer to induce massive cache misses on your setup, whic=
h
> limits the interpretation we can have of this log. Could you apply the
> following patch, and post back the frozen log for the very same test?
> TIA,
>=20
> --- 2.6.20-ipipe-1.8-08/kernel/ipipe/core.c~	2007-09-16 16:54:34.000000=
000 +0200
> +++ 2.6.20-ipipe-1.8-08/kernel/ipipe/core.c	2007-10-10 13:05:28.0000000=
00 +0200
> @@ -283,7 +283,7 @@
>  	unsigned long flags;
>  	int s;
> =20
> -	local_irq_save_hw(flags);
> +	local_irq_save_hw_notrace(flags);
>  	__raw_spin_lock(lock);
>  	ipipe_load_cpuid();
>  	ipd =3D per_cpu(ipipe_percpu_domain, cpuid);
> @@ -302,7 +302,7 @@
>  	ipd =3D per_cpu(ipipe_percpu_domain, cpuid);
>  	if (!raw_demangle_irq_bits(&x))
>  		__clear_bit(IPIPE_STALL_FLAG, &ipd->cpudata[cpuid].status);
> -	local_irq_restore_hw(x);
> +	local_irq_restore_hw_notrace(x);
>  }
> =20
>  /*
>=20
The freeze file enclosed is generated with this patch and the i8259.c pat=
ch.

---|------------|------------|------------|--------|---------------------=
----
RTS|       5.570|       9.400|      85.356|       0|    00:08:55/00:08:55

Should I try without the I-pipe debugger ?

Thank you for your help,
David

PS: I don't know if it's relevant but sometimes I get "eth0: Too much=20
work in interrupt, status 8401." in my logs.


--------------040307020807060107030204
Content-Type: text/plain;
 name="freeze.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="freeze.txt"

I-pipe frozen back-tracing service on 2.6.20/ipipe-1.8-08
------------------------------------------------------------

******** WARNING ********
The following debugging options will increase the observed latencies:
 o CONFIG_XENO_OPT_DEBUG

Freeze: 976382813724 cycles, Trace Points: 128 (+10)
Calibrated minimum trace-point overhead: 0.248 us

 +----- Hard IRQs ('|': locked)
 |+---- <unused>
 ||+--- Xenomai
 |||+-- IShield
 ||||+- Linux ('*': domain stalled, '+': current, '#': current+stalled)
 |||||                        +---------- Delay flag ('+': > 1 us, '!': > 10 us)
 |||||                        |        +- NMI noise ('N')
 |||||                        |        |
      Type    User Val.   Time    Delay  Function (Parent)
:    +func                -132    0.274  ipipe_check_context+0xc (boomerang_start_xmit+0x123)
:    #func                -132    0.303  ipipe_check_context+0xc (boomerang_start_xmit+0x163)
:    #func                -132    0.299  issue_and_wait+0xe (boomerang_start_xmit+0x170)
:    #func                -132    0.348  iowrite16+0x8 (issue_and_wait+0x2a)
:    #func                -131+   3.124  ioread16+0x8 (issue_and_wait+0x45)
:    #func                -128+   7.336  ioread32+0x8 (boomerang_start_xmit+0x188)
:    #func                -121    0.355  iowrite16+0x8 (boomerang_start_xmit+0x1c9)
:    #func                -120    0.336  __ipipe_restore_root+0x8 (boomerang_start_xmit+0x1d0)
:    #func                -120    0.316  __ipipe_unstall_root+0x8 (__ipipe_restore_root+0x1b)
:|   #begin   0x80000000  -120    0.322  __ipipe_unstall_root+0x4b (__ipipe_restore_root+0x1b)
:|   +end     0x80000000  -119    0.330  __ipipe_unstall_root+0x3a (__ipipe_restore_root+0x1b)
:    +func                -119    0.310  ipipe_check_context+0xc (boomerang_start_xmit+0x1da)
:    +func                -119    0.267  ipipe_check_context+0xc (__qdisc_run+0x134)
:    +func                -119    0.314  ipipe_check_context+0xc (__qdisc_run+0x7a)
:    +func                -118    0.311  pfifo_fast_dequeue+0x9 (__qdisc_run+0x99)
:    +func                -118    0.265  ipipe_check_context+0xc (dev_queue_xmit+0x93)
:    +func                -118    0.271  local_bh_enable+0xb (dev_queue_xmit+0xa1)
:    +func                -117    0.321  ipipe_check_context+0xc (local_bh_enable+0x49)
:    +func                -117    0.304  update_send_head+0xa (__tcp_push_pending_frames+0x122)
:    +func                -117    0.431  tcp_init_tso_segs+0x16 (__tcp_push_pending_frames+0x154)
:    +func                -116    0.599  tcp_set_skb_tso_segs+0x16 (tcp_init_tso_segs+0x46)
:    +func                -116    0.606  tcp_cwnd_validate+0x8 (__tcp_push_pending_frames+0x2d3)
:    +func                -115    0.685  tcp_check_space+0x9 (tcp_rcv_established+0x410)
:    +func                -114    0.310  cond_resched_softirq+0x8 (release_sock+0x69)
:    +func                -114    0.286  tcp_v4_do_rcv+0x14 (release_sock+0x64)
:    +func                -114    0.505  tcp_rcv_established+0x14 (tcp_v4_do_rcv+0xb3)
:    +func                -113    0.938  tcp_ack+0x11 (tcp_rcv_established+0x3e1)
:    +func                -112    0.262  __kfree_skb+0x11 (tcp_ack+0x46a)
:    +func                -112    0.259  kfree_skbmem+0x9 (__kfree_skb+0x47)
:    +func                -112    0.737  skb_release_data+0xa (kfree_skbmem+0x10)
:    +func                -111    0.260  __kfree_skb+0x11 (tcp_ack+0x46a)
:    +func                -111    0.250  kfree_skbmem+0x9 (__kfree_skb+0x47)
:    +func                -111    0.442  skb_release_data+0xa (kfree_skbmem+0x10)
:    +func                -110    0.282  tcp_ack_saw_tstamp+0x9 (tcp_ack+0x672)
:    +func                -110    0.480  tcp_rtt_estimator+0xa (tcp_ack_saw_tstamp+0x1c)
:    +func                -109    0.270  sk_reset_timer+0x9 (tcp_ack+0xd92)
:    +func                -109    0.307  mod_timer+0x8 (sk_reset_timer+0x14)
:    +func                -109    0.277  __mod_timer+0xe (mod_timer+0x19)
:    +func                -109    0.260  lock_timer_base+0x16 (__mod_timer+0x27)
:    +func                -108    0.285  ipipe_check_context+0xc (lock_timer_base+0x2b)
:    #func                -108    0.386  ipipe_check_context+0xc (lock_timer_base+0x4b)
:    #func                -108    0.331  internal_add_timer+0x12 (__mod_timer+0x88)
:    #func                -107    0.284  __ipipe_restore_root+0x8 (__mod_timer+0xb4)
:    #func                -107    0.327  __ipipe_unstall_root+0x8 (__ipipe_restore_root+0x1b)
:|   #begin   0x80000000  -107    0.327  __ipipe_unstall_root+0x4b (__ipipe_restore_root+0x1b)
:|   +end     0x80000000  -106    0.363  __ipipe_unstall_root+0x3a (__ipipe_restore_root+0x1b)
:    +func                -106    0.368  ipipe_check_context+0xc (__mod_timer+0xa2)
:    +func                -106    0.465  bictcp_acked+0x9 (tcp_ack+0x6ac)
:    +func                -105    0.296  tcp_cong_avoid+0x11 (tcp_ack+0xd48)
:    +func                -105    0.517  bictcp_cong_avoid+0xe (tcp_cong_avoid+0x2b)
:    +func                -104    0.300  __kfree_skb+0x11 (tcp_rcv_established+0x3e8)
:    +func                -104    0.259  kfree_skbmem+0x9 (__kfree_skb+0x47)
:    +func                -104    0.349  skb_release_data+0xa (kfree_skbmem+0x10)
:    +func                -103    0.262  kfree+0xb (skb_release_data+0x5d)
:    +func                -103    0.487  ipipe_check_context+0xc (kfree+0x1b)
:    #func                -103    0.352  __ipipe_restore_root+0x8 (kfree+0x73)
:    #func                -102    0.316  __ipipe_unstall_root+0x8 (__ipipe_restore_root+0x1b)
:|   #begin   0x80000000  -102    0.322  __ipipe_unstall_root+0x4b (__ipipe_restore_root+0x1b)
:|   +end     0x80000000  -102    0.400  __ipipe_unstall_root+0x3a (__ipipe_restore_root+0x1b)
:    +func                -101    0.273  kmem_cache_free+0xe (kfree_skbmem+0x3d)
:    +func                -101    0.275  ipipe_check_context+0xc (kmem_cache_free+0x40)
:    #func                -101    0.286  __ipipe_restore_root+0x8 (kmem_cache_free+0x84)
:    #func                -100    0.306  __ipipe_unstall_root+0x8 (__ipipe_restore_root+0x1b)
:|   #begin   0x80000000  -100    0.382  __ipipe_unstall_root+0x4b (__ipipe_restore_root+0x1b)
:|   +end     0x80000000  -100    0.374  __ipipe_unstall_root+0x3a (__ipipe_restore_root+0x1b)
:    +func                 -99    0.404  tcp_current_mss+0x14 (tcp_rcv_established+0x3fb)
:    +func                 -99    0.307  __tcp_push_pending_frames+0xe (tcp_rcv_established+0x409)
:    +func                 -99    0.442  tcp_init_tso_segs+0x16 (__tcp_push_pending_frames+0x154)
:    +func                 -98    0.285  tcp_transmit_skb+0xe (__tcp_push_pending_frames+0x10f)
:    +func                 -98    0.769  skb_clone+0xe (tcp_transmit_skb+0x6d)
:    +func                 -97    0.486  __tcp_select_window+0xe (tcp_transmit_skb+0x19b)
:    +func                 -97    0.497  tcp_v4_send_check+0x14 (tcp_transmit_skb+0x45a)
:    +func                 -96    0.297  ip_queue_xmit+0xe (tcp_transmit_skb+0x3b0)
:    +func                 -96    0.586  __sk_dst_check+0x11 (ip_queue_xmit+0x29e)
:    +func                 -95    0.490  ip_output+0xe (ip_queue_xmit+0x1ac)
:    +func                 -95    0.355  dev_queue_xmit+0xe (ip_output+0x10b)
:    +func                 -94    0.269  local_bh_disable+0x8 (dev_queue_xmit+0x43)
:    +func                 -94    0.271  ipipe_check_context+0xc (dev_queue_xmit+0x5d)
:    +func                 -94    0.579  pfifo_fast_enqueue+0xa (dev_queue_xmit+0x71)
:|   +begin   0xffffff16   -93    0.327  ipipe_ipi3+0x2e (dev_queue_xmit+0x83)
:|   +func                 -93    0.356  __ipipe_handle_irq+0x14 (ipipe_ipi3+0x33)
:|   +func                 -93    0.312  __ipipe_ack_apic+0x8 (__ipipe_handle_irq+0xaf)
:|   +func                 -92    0.333  __ipipe_dispatch_wired+0x16 (__ipipe_handle_irq+0x68)
:| #  func                 -92    0.319  xnintr_clock_handler+0x8 (__ipipe_dispatch_wired+0x9f)
:| #  func                 -92    0.374  xnintr_irq_handler+0xe (xnintr_clock_handler+0x17)
:| #  func                 -91    0.314  xnpod_announce_tick+0x8 (xnintr_irq_handler+0x3b)
:| #  func                 -91    0.484  xntimer_do_tick_aperiodic+0xe (xnpod_announce_tick+0xf)
:| #  func                 -91    0.301  xnthread_periodic_handler+0x8 (xntimer_do_tick_aperiodic+0x217)
:| #  func                 -90    0.314  xnpod_resume_thread+0xe (xnthread_periodic_handler+0x2c)
:| #  [ 3945] samplin 99   -90+   1.008  xnpod_resume_thread+0x56 (xnthread_periodic_handler+0x2c)
:| #  func                 -89    0.330  xnpod_schedule+0xe (xnintr_irq_handler+0x135)
:| #  [ 3596] konsole -1   -89+   1.073  xnpod_schedule+0x90 (xnintr_irq_handler+0x135)
:| #  func                 -87    0.621  __switch_to+0xe (xnpod_schedule+0x493)
:| #  [ 3945] samplin 99   -87    0.743  xnpod_schedule+0x56b (xnpod_suspend_thread+0x18b)
:| #  func                 -86    0.346  __ipipe_restore_pipeline_head+0x12 (xnpod_wait_thread_period+0x12b)
:| +  end     0x80000000   -86+   1.346  __ipipe_restore_pipeline_head+0x5c (xnpod_wait_thread_period+0x12b)
:| +  begin   0xfffffffa   -84    0.407  common_interrupt+0x29 (__ipipe_restore_pipeline_head+0x60)
:| +  func                 -84    0.415  __ipipe_handle_irq+0x14 (common_interrupt+0x2e)
:| +  func                 -84    0.306  __ipipe_ack_irq+0x8 (__ipipe_handle_irq+0x151)
:| +  func                 -83    0.295  __ipipe_ack_level_irq+0x12 (__ipipe_ack_irq+0x19)
:| +  func                 -83    0.278  mask_and_ack_8259A+0x14 (__ipipe_ack_level_irq+0x22)
:| +  func                 -83!  31.046  __ipipe_spin_lock_irqsave+0x8 (mask_and_ack_8259A+0x29)
:| #  func                 -52    0.400  __ipipe_spin_unlock_irqrestore+0x8 (mask_and_ack_8259A+0x73)
:| +  func                 -51    0.355  __ipipe_walk_pipeline+0xe (__ipipe_handle_irq+0x81)
:| +  end     0xfffffffa   -51!  10.159  common_interrupt+0x38 (__ipipe_restore_pipeline_head+0x60)
:| +  begin   0xfffffff0   -41    0.355  common_interrupt+0x29 (__ipipe_restore_pipeline_head+0x60)
:| +  func                 -40    0.642  __ipipe_handle_irq+0x14 (common_interrupt+0x2e)
:| +  func                 -40    0.394  __ipipe_ack_irq+0x8 (__ipipe_handle_irq+0x151)
:| +  func                 -39    0.255  __ipipe_ack_level_irq+0x12 (__ipipe_ack_irq+0x19)
:| +  func                 -39    0.247  mask_and_ack_8259A+0x14 (__ipipe_ack_level_irq+0x22)
:| +  func                 -39!  28.454  __ipipe_spin_lock_irqsave+0x8 (mask_and_ack_8259A+0x29)
:| #  func                 -10    0.351  __ipipe_spin_unlock_irqrestore+0x8 (mask_and_ack_8259A+0x73)
:| +  func                 -10    0.292  __ipipe_walk_pipeline+0xe (__ipipe_handle_irq+0x81)
:| +  end     0xfffffff0   -10    0.743  common_interrupt+0x38 (__ipipe_restore_pipeline_head+0x60)
:| +  begin   0x80000001    -9    0.381  __ipipe_dispatch_event+0x180 (__ipipe_syscall_root+0x44)
:| +  end     0x80000001    -9+   3.306  __ipipe_dispatch_event+0x154 (__ipipe_syscall_root+0x44)
:  +  func                  -5    0.325  __ipipe_syscall_root+0xa (system_call+0x29)
:  +  func                  -5    0.326  __ipipe_dispatch_event+0xe (__ipipe_syscall_root+0x44)
:| +  begin   0x80000001    -5    0.383  __ipipe_dispatch_event+0x1a0 (__ipipe_syscall_root+0x44)
:| +  end     0x80000001    -4    0.321  __ipipe_dispatch_event+0x18f (__ipipe_syscall_root+0x44)
:  +  func                  -4+   1.012  hisyscall_event+0x14 (__ipipe_dispatch_event+0xb5)
:  +  func                  -3+   1.019  xnshadow_sys_trace+0x16 (hisyscall_event+0x189)
:  +  func                  -2    0.404  ipipe_trace_frozen_reset+0x9 (xnshadow_sys_trace+0xd7)
:  +  func                  -2    0.259  __ipipe_global_path_lock+0x8 (ipipe_trace_frozen_reset+0x13)
:  +  func                  -1+   1.135  __ipipe_spin_lock_irqsave+0x8 (__ipipe_global_path_lock+0x12)
:| #  func                   0    0.289  __ipipe_spin_unlock_irqcomplete+0x9 (__ipipe_global_path_unlock+0x63)
:| +  end     0x80000001     0    0.366  __ipipe_spin_unlock_irqcomplete+0x2e (__ipipe_global_path_unlock+0x63)
<  +  freeze  0x00014d6c     0    0.571  xnshadow_sys_trace+0xa0 (hisyscall_event+0x189)
 | +  begin   0x80000001     0    0.316  __ipipe_dispatch_event+0x180 (__ipipe_syscall_root+0x44)
 | +  end     0x80000001     0    0.826  __ipipe_dispatch_event+0x154 (__ipipe_syscall_root+0x44)
   +  func                   1    0.286  __ipipe_syscall_root+0xa (system_call+0x29)
   +  func                   2    0.297  __ipipe_dispatch_event+0xe (__ipipe_syscall_root+0x44)
 | +  begin   0x80000001     2    0.306  __ipipe_dispatch_event+0x1a0 (__ipipe_syscall_root+0x44)
 | +  end     0x80000001     2    0.318  __ipipe_dispatch_event+0x18f (__ipipe_syscall_root+0x44)
   +  func                   2    0.392  hisyscall_event+0x14 (__ipipe_dispatch_event+0xb5)
   +  func                   3    0.296  __rt_task_wait_period+0x11 (hisyscall_event+0x189)
   +  func                   3    0.326  rt_task_wait_period+0x8 (__rt_task_wait_period+0x21)
   +  func                   3    0.000  xnpod_wait_thread_period+0xe (rt_task_wait_period+0x38)

--------------040307020807060107030204--

