MIME-Version: 1.0
From: Andreas Glatz <andi.glatz@gmail.com>
Date: Fri, 14 Jul 2017 16:26:06 +0100
Message-ID: <CAKJ14Ne7zRhT2LvzxdF3QuLYPAejcFhK=jWjOXzYji5CtmgPjA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: [Xenomai] Pagefault during RTnet tx on i.MX6
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Hi

HW/SW:
- phyflex i.MX6 dual core SOM
- Linux version 3.0.43-tpcom_run2-PD13.2.4
- Xenomai/Ipipe: 2.6.4/1.18-3
- RTnet: 0.9.13
- custom RTnet driver

Problem:
Recently, we came across a case where the rx/tx through RTnet works
for several hours and then stops with the following errors:
[ 5198.831630] Xenomai: suspending kernel thread 7f022808
('rtnet-stack') at 0x7f01d36c after exception #0x0
[ 5263.234100] INFO: rcu_preempt_state detected stalls on CPUs/tasks:
{ 1} (detected by 0, t=6002 jiffies)
[ 5443.554099] INFO: rcu_preempt_state detected stalls on CPUs/tasks:
{ 1} (detected by 0, t=24034 jiffies)

Further investigation produced the ipipe trace shown at the bottom of
this Email.

The page-fault seems to occur in kfree_rtskb() at assembly line 608 (I think?)

/***
 *  kfree_rtskb
 *  @skb    rtskb
 */
void kfree_rtskb(struct rtskb *skb)
{
     36c:   e1a0c00d    mov ip, sp

[...]

        rtdm_lock_get_irqsave(&rtcap_lock, context);

        if (skb->cap_flags & RTSKB_CAP_SHARED) {
     608:   e5941090    ldr r1, [r4, #144]  ; 0x90
     60c:   e51b2050    ldr r2, [fp, #-80]  ; 0x50
     610:   e2110001    ands    r0, r1, #1
     614:   e51b304c    ldr r3, [fp, #-76]  ; 0x4c
     618:   1affff65    bne 3b4 <kfree_rtskb+0x48>

[...]

We have to find out why the rtnet-stack suddenly receives a page fault
and prevent suspending it. Do you have any pointers how to debug this
issue further?

Before the rtskb is freed the content of the skb is transferred to the
hardware using DMA.

In the cases where the page fault occurred the rtcap.ko module was
loaded. Currently, we're trying to see if leaving this module unloaded
would make any difference....

Thanks a lot,

Andreas


root@phyFLEX-i:/proc cat /proc/ipipe/trace/frozen
I-pipe frozen back-tracing service on 3.0.43-tpcom_run2-PD13.2.4/ipipe-1.18-13
------------------------------------------------------------
CPU: 1, Freeze: 1404260498350 cycles, Trace Points: 100 (+10)
Calibrated minimum trace-point overhead: 0.415 us

+----- Hard IRQs ('|': locked)
|+---- <unused>
||+--- <unused>
|||+-- Xenomai
||||+- Linux ('*': domain stalled, '+': current, '#': current+stalled)
|||||                        +---------- Delay flag ('+': > 1 us, '!': > 10 us)
|||||                        |        +- NMI noise ('N')
|||||                        |        |
      Type    User Val.   Time    Delay  Function (Parent)
:|  #*func                -116+   1.282  gpio_unmask_irq+0x10
(__ipipe_end_level_irq+0x2c)
:|  #*func                -115+   1.136  __xnpod_schedule+0x14
(xnintr_irq_handler+0x294)
:|  #*[ 1489] tT5VM   -1  -113    0.763  __xnpod_schedule+0x140
(xnintr_irq_handler+0x294)
:|  #*func                -113+   1.196  xnsched_pick_next+0x10
(__xnpod_schedule+0x1ac)
:|  #*func                -111    0.780  ipipe_mute_pic+0x10
(__xnpod_schedule+0x6a8)
:|  #*func                -111+   1.861  gic_mute+0x10 (ipipe_mute_pic+0x18)
:|  #*func                -109    0.982
__ipipe_restore_pipeline_head+0x10 (__xnpod_schedule+0x720)
:|  +*end     0x80000000  -108+   2.397
__ipipe_restore_pipeline_head+0xe0 (__xnpod_schedule+0x720)
:   +*func                -105+   1.050
xnsched_finish_unlocked_switch+0x10 (__xnpod_schedule+0x4d8)
:|  +*begin   0x80000000  -104+   1.473
xnsched_finish_unlocked_switch+0x118 (__xnpod_schedule+0x4d8)
:|  #*[    0] -<?>-   98  -103+   4.040  __xnpod_schedule+0x510
(xnpod_suspend_thread+0x484)
:|  #*func                 -99    0.816
__ipipe_restore_pipeline_head+0x10 (rtdm_event_timedwait+0x15c)
:|  +*end     0x80000000   -98+   1.785
__ipipe_restore_pipeline_head+0xe0 (rtdm_event_timedwait+0x15c)
:   +*func                 -96+   1.163  rt_stack_deliver+0x14 [rtnet]
(rt_stack_mgr_task+0x68 [rtnet])
:|  +*begin   0x80000000   -95+   1.591  rt_stack_deliver+0x540
[rtnet] (rt_stack_mgr_task+0x68 [rtnet])
:|  #*func                 -94+   1.261  ___xnpod_lock_sched+0x10
(rt_stack_deliver+0xb4 [rtnet])
:|  #*func                 -92+   1.443  rtcap_rx_hook+0x14 [rtcap]
(rt_stack_deliver+0xcc [rtnet])
:|  #*func                 -91    0.934  ___xnpod_lock_sched+0x10
(rtcap_rx_hook+0xb8 [rtcap])
:|  #*func                 -90    0.904  ___xnpod_unlock_sched+0x10
(rtcap_rx_hook+0x108 [rtcap])
:|  #*func                 -89    0.909  ipipe_trigger_irq+0x10
(rtcap_rx_hook+0x188 [rtcap])
:|  #*func                 -88+   1.236  __ipipe_handle_irq+0x14
(ipipe_trigger_irq+0x54)
:|  #*func                 -87+   1.350  __ipipe_set_irq_pending+0x10
(__ipipe_handle_irq+0x1b4)
:|  #*func                 -85+   1.083  ___xnpod_unlock_sched+0x10
(rt_stack_deliver+0xf8 [rtnet])
:|  #*func                 -84+   1.375
__ipipe_restore_pipeline_head+0x10 (rt_stack_deliver+0x55c [rtnet])
:|  +*end     0x80000000   -83    0.861
__ipipe_restore_pipeline_head+0xe0 (rt_stack_deliver+0x55c [rtnet])
:|  +*begin   0x80000000   -82+   1.090  rt_stack_deliver+0x550
[rtnet] (rt_stack_mgr_task+0x68 [rtnet])
:|  #*func                 -81+   2.191  ___xnpod_lock_sched+0x10
(rt_stack_deliver+0x1bc [rtnet])
:|  #*func                 -79    0.959  ___xnpod_unlock_sched+0x10
(rt_stack_deliver+0x3a4 [rtnet])
:|  #*func                 -78    0.801
__ipipe_restore_pipeline_head+0x10 (rt_stack_deliver+0x620 [rtnet])
:|  +*end     0x80000000   -77+   1.073
__ipipe_restore_pipeline_head+0xe0 (rt_stack_deliver+0x620 [rtnet])
:   +*func                 -76+   1.105  rt_ip_rcv+0x10 [rtipv4]
(rt_stack_deliver+0x3f4 [rtnet])
:   +*func                 -75+   1.065  rt_ip_route_forward+0x14
[rtipv4] (rt_ip_rcv+0xe8 [rtipv4])
:   +*func                 -74+   1.387  rtskb_acquire+0x14 [rtnet]
(rt_ip_route_forward+0x5c [rtipv4])
:|  +*begin   0x80000000   -72+   1.080  rtskb_acquire+0x200 [rtnet]
(rt_ip_route_forward+0x5c [rtipv4])
:|  #*func                 -71+   1.068  ___xnpod_lock_sched+0x10
(rtskb_acquire+0xb4 [rtnet])
:|  #*func                 -70    0.891  ___xnpod_unlock_sched+0x10
(rtskb_acquire+0x100 [rtnet])
:|  #*func                 -69+   1.037  ___xnpod_lock_sched+0x10
(rtskb_acquire+0x14c [rtnet])
:|  #*func                 -68    0.891  ___xnpod_unlock_sched+0x10
(rtskb_acquire+0x1a0 [rtnet])
:|  #*func                 -67    0.760
__ipipe_restore_pipeline_head+0x10 (rtskb_acquire+0x20c [rtnet])
:|  +*end     0x80000000   -67+   1.156
__ipipe_restore_pipeline_head+0xe0 (rtskb_acquire+0x20c [rtnet])
:   +*func                 -66+   1.246  rt_ip_route_output+0x14
[rtipv4] (rt_ip_route_forward+0x70 [rtipv4])
:|  +*begin   0x80000000   -64+   1.090  rt_ip_route_output+0x3fc
[rtipv4] (rt_ip_route_forward+0x70 [rtipv4])
:|  #*func                 -63+   1.939  ___xnpod_lock_sched+0x10
(rt_ip_route_output+0xd8 [rtipv4])
:|  #*func                 -61    0.896  ___xnpod_unlock_sched+0x10
(rt_ip_route_output+0x390 [rtipv4])
:|  #*func                 -60    0.785
__ipipe_restore_pipeline_head+0x10 (rt_ip_route_output+0x3d8 [rtipv4])
:|  +*end     0x80000000   -60    0.977
__ipipe_restore_pipeline_head+0xe0 (rt_ip_route_output+0x3d8 [rtipv4])
:   +*func                 -59+   2.133  rt_eth_header+0x10 [rtnet]
(rt_ip_route_forward+0xb8 [rtipv4])
:   +*func                 -57+   1.125  rtdev_xmit+0x10 [rtnet]
(rt_ip_route_forward+0xc8 [rtipv4])
:   +*func                 -55+   1.075  rtdev_locked_xmit+0x10
[rtnet] (rtdev_xmit+0x24 [rtnet])
:   +*func                 -54+   1.035  rtdm_mutex_lock+0x14
(rtdev_locked_xmit+0x28 [rtnet])
:   +*func                 -53+   1.085  rtdm_mutex_timedlock+0x14
(rtdm_mutex_lock+0x2c)
:|  +*begin   0x80000000   -52+   1.357  rtdm_mutex_timedlock+0x1dc
(rtdm_mutex_lock+0x2c)
:|  #*func                 -51    0.869
__ipipe_restore_pipeline_head+0x10 (rtdm_mutex_timedlock+0x1c4)
:|  +*end     0x80000000   -50    0.937
__ipipe_restore_pipeline_head+0xe0 (rtdm_mutex_timedlock+0x1c4)
:   +*func                 -49+   1.272  rtcap_xmit_hook+0x14 [rtcap]
(rtdev_locked_xmit+0x38 [rtnet])
:|  +*begin   0x80000000   -48    0.979  rtcap_xmit_hook+0x2e4 [rtcap]
(rtdev_locked_xmit+0x38 [rtnet])
:|  #*func                 -47    0.732  ___xnpod_lock_sched+0x10
(rtcap_xmit_hook+0xd0 [rtcap])
:|  #*func                 -46    0.899  ___xnpod_unlock_sched+0x10
(rtcap_xmit_hook+0x118 [rtcap])
:|  #*func                 -45    0.798
__ipipe_restore_pipeline_head+0x10 (rtcap_xmit_hook+0x2f0 [rtcap])
:|  +*end     0x80000000   -44+   1.418
__ipipe_restore_pipeline_head+0xe0 (rtcap_xmit_hook+0x2f0 [rtcap])
:   +*func                 -43+   1.697  ks_start_xmit+0x14
[ksz8462_h] (rtcap_xmit_hook+0x320 [rtcap])
:|  +*begin   0x80000000   -41+   1.110  ks_start_xmit+0x348
[ksz8462_h] (rtcap_xmit_hook+0x320 [rtcap])
:|  #*func                 -40+   1.637  ___xnpod_lock_sched+0x10
(ks_start_xmit+0xe4 [ksz8462_h])
:|  #*func                 -38    0.931  ks_tx_fifo_space+0x10
[ksz8462_h] (ks_start_xmit+0xfc [ksz8462_h])
:|  #*func                 -38    0.642  l2x0_cache_sync+0x10
(ks_tx_fifo_space+0x30 [ksz8462_h])
:|  #*func                 -37    0.954
__ipipe_spin_lock_irqsave+0x10 (l2x0_cache_sync+0x24)
:|  #*func                 -36+   1.370
__ipipe_spin_unlock_irqrestore+0x10 (l2x0_cache_sync+0x3c)
:|  #*func                 -35    0.745  ks_wrreg8+0x10 [ksz8462_h]
(ks_start_xmit+0x160 [ksz8462_h])
:|  #*func                 -34    0.639  l2x0_cache_sync+0x10
(ks_wrreg8+0x50 [ksz8462_h])
:|  #*func                 -33    0.879
__ipipe_spin_lock_irqsave+0x10 (l2x0_cache_sync+0x24)
:|  #*func                 -32    0.770
__ipipe_spin_unlock_irqrestore+0x10 (l2x0_cache_sync+0x3c)
:|  #*func                 -32    0.639  l2x0_cache_sync+0x10
(ks_wrreg8+0x6c [ksz8462_h])
:|  #*func                 -31    0.919
__ipipe_spin_lock_irqsave+0x10 (l2x0_cache_sync+0x24)
:|  #*func                 -30+   5.181
__ipipe_spin_unlock_irqrestore+0x10 (l2x0_cache_sync+0x3c)
:|  #*func                 -25    0.801  ks_wrreg8+0x10 [ksz8462_h]
(ks_start_xmit+0x194 [ksz8462_h])
:|  #*func                 -24    0.639  l2x0_cache_sync+0x10
(ks_wrreg8+0x50 [ksz8462_h])
:|  #*func                 -23    0.874
__ipipe_spin_lock_irqsave+0x10 (l2x0_cache_sync+0x24)
:|  #*func                 -22    0.760
__ipipe_spin_unlock_irqrestore+0x10 (l2x0_cache_sync+0x3c)
:|  #*func                 -22    0.639  l2x0_cache_sync+0x10
(ks_wrreg8+0x6c [ksz8462_h])
:|  #*func                 -21    0.884
__ipipe_spin_lock_irqsave+0x10 (l2x0_cache_sync+0x24)
:|  #*func                 -20    0.763
__ipipe_spin_unlock_irqrestore+0x10 (l2x0_cache_sync+0x3c)
:|  #*func                 -19    0.874  ks_wrreg16+0x10 [ksz8462_h]
(ks_start_xmit+0x1a8 [ksz8462_h])
:|  #*func                 -19    0.639  l2x0_cache_sync+0x10
(ks_wrreg16+0x44 [ksz8462_h])
:|  #*func                 -18    0.874
__ipipe_spin_lock_irqsave+0x10 (l2x0_cache_sync+0x24)
:|  #*func                 -17    0.745
__ipipe_spin_unlock_irqrestore+0x10 (l2x0_cache_sync+0x3c)
:|  #*func                 -16    0.654  l2x0_cache_sync+0x10
(ks_wrreg16+0x60 [ksz8462_h])
:|  #*func                 -16    0.874
__ipipe_spin_lock_irqsave+0x10 (l2x0_cache_sync+0x24)
:|  #*func                 -15    0.775
__ipipe_spin_unlock_irqrestore+0x10 (l2x0_cache_sync+0x3c)
:|  #*func                 -14    0.639  l2x0_cache_sync+0x10
(ks_start_xmit+0x1bc [ksz8462_h])
:|  #*func                 -13    0.874
__ipipe_spin_lock_irqsave+0x10 (l2x0_cache_sync+0x24)
:|  #*func                 -12+   1.541
__ipipe_spin_unlock_irqrestore+0x10 (l2x0_cache_sync+0x3c)
:|  #*func                 -11+   1.130  kfree_rtskb+0x14 [rtnet]
(ks_start_xmit+0x1f0 [ksz8462_h])
:|  #*func                 -10+   1.471  ___xnpod_lock_sched+0x10
(kfree_rtskb+0x29c [rtnet])
:|  #*begin   0x90000000    -8+   1.435  __dabt_svc+0x44
(kfree_rtskb+0x60 [rtnet])
:|  #*func                  -7+   1.821  do_DataAbort+0x14 (__dabt_svc+0x88)
:|  #*func                  -5+   1.949  do_page_fault+0x14 (do_DataAbort+0x48)
:|  #*func                  -3+   1.201  __ipipe_dispatch_event+0x14
(do_page_fault+0xd4)
:|  #*func                  -2+   1.463  exception_event+0x10
(__ipipe_dispatch_event+0x110)
:|  #*func                   0    0.969  xnarch_trap_fault+0x14
(exception_event+0x5c)
<|  #*func                   0    2.473  xnpod_trap_fault+0x14
(xnarch_trap_fault+0x28)
|  #*func                   2    1.554  printk+0x18 (xnpod_trap_fault+0x288)
|  #*func                   4   14.052  __ipipe_spin_lock_irqsave+0x10
(printk+0x24c)
|  #*func                  18    1.078
__ipipe_spin_unlock_irqrestore+0x10 (printk+0x298)
|  #*func                  19    0.793  ipipe_trigger_irq+0x10 (printk+0x2ac)
|  #*func                  19    1.292  __ipipe_handle_irq+0x14
(ipipe_trigger_irq+0x54)
|  #*func                  21    1.438  __ipipe_set_irq_pending+0x10
(__ipipe_handle_irq+0x1b4)
|  #*func                  22    1.413  xnpod_suspend_thread+0x14
(xnpod_trap_fault+0x2a4)
|  #*func                  24    1.115  __xnpod_schedule+0x14
(xnpod_suspend_thread+0x484)
|  #*[    0] -<?>-   98    25    0.884  __xnpod_schedule+0x140
(xnpod_suspend_thread+0x484)
|  #*func                  26    0.000  xnsched_pick_next+0x10
(__xnpod_schedule+0x1ac)

