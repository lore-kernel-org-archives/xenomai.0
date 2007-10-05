Message-ID: <47062F89.2010303@domain.hid>
Date: Fri, 05 Oct 2007 14:35:21 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <4705ED3B.4070600@domain.hid>		<2ff1a98a0710050130j7e0db84dq838aab0417c8bd3f@domain.hid>		<4705FE04.7000909@domain.hid>
	<1191576011.20623.114.camel@domain.hid> <470611FA.30103@domain.hid>
In-Reply-To: <470611FA.30103@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
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
To: CHABAL David <david.chabal@domain.hid>
Cc: xenomai@xenomai.org

CHABAL David wrote:
> Philippe Gerum a =E9crit :
>> On Fri, 2007-10-05 at 11:04 +0200, CHABAL David wrote:
>>> Gilles Chanteperdrix a =E9crit :
>>>> On 10/5/07, CHABAL David <david.chabal@domain.hid> wrote:
>>>>> Hello all,
>>>>>
>>>>> My box is a Pentium III 733 Mhz/256Mo with Linux 2.6.20 and Xenomai
>>> 2.3.3.
>>>>> When I run the latency test included in the testsuite, I get some
>>>>> horrible results like:
>>>>>
>>
>> You first need to upgrade your Adeos patch in order to avoid a deadly
>> tracer issue in earlier versions:
>> http://download.gna.org/adeos/patches/v2.6/i386/older/adeos-ipipe-2.6.=
20-i386-1.8-08.patch
>>
>>
>> Then, please switch on CONFIG_IPIPE_TRACE, CONFIG_IPIPE_TRACE_MCOUNT,
>> CONFIG_IPIPE_TRACE_IRQSOFF, and eventually run the following on the
>> target kernel:
>>
>> # echo 1 > /proc/ipipe/trace/enable
>> # /usr/xenomai/bin/latency -f
>> ... wait for a high latency ...
>> # echo 128 > /proc/ipipe/trace/back_trace_points
>> # cat /proc/ipipe/trace/frozen

echo 1 > /proc/ipipe/trace/verbose is also useful (think I'm going to
write a patch to make this default on...).

>>
>> Sending us back the output of the last command would help.
>>
> Gilles and Philippe, thank you for your help.
>=20
> The results below come from a patched kernel with adeos 1.8.08:
>=20
>=20
> RTT|  00:07:22  (periodic user-mode task, 100 us period, priority 99)
> RTH|-----lat min|-----lat avg|-----lat max|-overrun|----lat best|---lat
> worst
> RTD|       4.722|      12.411|      93.529|       0|       3.129| 122.2=
69
> RTD|       4.347|      13.690|      93.802|       0|       3.129| 122.2=
69
> ---|------------|------------|------------|--------|-------------------=
------
>=20
> RTS|       3.129|      10.194|     122.269|       0|    00:07:24/00:07:=
24
>=20
>=20
>=20
> David
>=20
>=20
> -----------------------------------------------------------------------=
-
>=20
> I-pipe frozen back-tracing service on 2.6.20/ipipe-1.8-08
> ------------------------------------------------------------
>=20
> ******** WARNING ********
> The following debugging options will increase the observed latencies:
>  o CONFIG_XENO_OPT_DEBUG
>=20
> Freeze: 620918235066 cycles, Trace Points: 128 (+10)
> Calibrated minimum trace-point overhead: 0.248 us
>=20
>  +--------------- Hard IRQs ('|': locked)
>  |             +- Delay flag ('+': > 1 us, '!': > 10 us)
>  |             |
>   Type     Time   Function (Parent)
> : func     -145   iowrite16 (issue_and_wait)
> : func     -144+  ioread16 (issue_and_wait)
> : func     -137+  ioread32 (boomerang_start_xmit)
> : func     -136   iowrite16 (boomerang_start_xmit)
> : func     -136   __ipipe_restore_root (boomerang_start_xmit)
> : func     -135   __ipipe_unstall_root (__ipipe_restore_root)
> :|begin    -135   __ipipe_unstall_root (__ipipe_restore_root)
> :|end      -135   __ipipe_unstall_root (__ipipe_restore_root)
> : func     -134   ipipe_check_context (boomerang_start_xmit)
> : func     -134   ipipe_check_context (__qdisc_run)
> : func     -133   ipipe_check_context (__qdisc_run)
> : func     -133   pfifo_fast_dequeue (__qdisc_run)
> : func     -133   ipipe_check_context (dev_queue_xmit)
> : func     -132   local_bh_enable (dev_queue_xmit)
> : func     -132   ipipe_check_context (local_bh_enable)
> : func     -132   update_send_head (__tcp_push_pending_frames)
> : func     -131   tcp_init_tso_segs (__tcp_push_pending_frames)
> : func     -131   tcp_set_skb_tso_segs (tcp_init_tso_segs)
> : func     -131   tcp_transmit_skb (__tcp_push_pending_frames)
> : func     -130   skb_clone (tcp_transmit_skb)
> : func     -129   __tcp_select_window (tcp_transmit_skb)
> : func     -129   tcp_v4_send_check (tcp_transmit_skb)
> : func     -128   ip_queue_xmit (tcp_transmit_skb)
> : func     -128   __sk_dst_check (ip_queue_xmit)
> : func     -127   ip_output (ip_queue_xmit)
> : func     -127   dev_queue_xmit (ip_output)
> : func     -127   local_bh_disable (dev_queue_xmit)
> : func     -126   ipipe_check_context (dev_queue_xmit)
> : func     -126   pfifo_fast_enqueue (dev_queue_xmit)
> : func     -126   __qdisc_run (dev_queue_xmit)
> : func     -125   pfifo_fast_dequeue (__qdisc_run)
> : func     -125   ipipe_check_context (__qdisc_run)
> : func     -125   ipipe_check_context (__qdisc_run)
> : func     -124   dev_hard_start_xmit (__qdisc_run)
> : func     -124   ipipe_check_context (dev_hard_start_xmit)
> : func     -124   skb_clone (dev_hard_start_xmit)
> : func     -123   kmem_cache_alloc (skb_clone)
> : func     -123   ipipe_check_context (kmem_cache_alloc)
> : func     -123   __ipipe_restore_root (kmem_cache_alloc)
> : func     -123   __ipipe_unstall_root (__ipipe_restore_root)
> :|begin    -122   __ipipe_unstall_root (__ipipe_restore_root)
> :|end      -122   __ipipe_unstall_root (__ipipe_restore_root)
> : func     -121   packet_rcv_spkt (dev_hard_start_xmit)
> : func     -121   strlcpy (packet_rcv_spkt)
> : func     -121   sock_queue_rcv_skb (packet_rcv_spkt)
> : func     -120   local_bh_disable (sock_queue_rcv_skb)
> : func     -120   sk_run_filter (sock_queue_rcv_skb)
> : func     -119   local_bh_enable (sock_queue_rcv_skb)
> : func     -119   ipipe_check_context (local_bh_enable)
> : func     -119   kfree_skb (packet_rcv_spkt)
> : func     -119   __kfree_skb (kfree_skb)
> : func     -118   kfree_skbmem (__kfree_skb)
> : func     -118   skb_release_data (kfree_skbmem)
> : func     -117   kmem_cache_free (kfree_skbmem)
> : func     -117   ipipe_check_context (kmem_cache_free)
> : func     -117   __ipipe_restore_root (kmem_cache_free)
> : func     -117   __ipipe_unstall_root (__ipipe_restore_root)
> :|begin    -116   __ipipe_unstall_root (__ipipe_restore_root)
> :|end      -116   __ipipe_unstall_root (__ipipe_restore_root)
> : func     -115   ipipe_check_context (dev_hard_start_xmit)
> : func     -115   boomerang_start_xmit (dev_hard_start_xmit)
> : func     -115   ipipe_check_context (boomerang_start_xmit)
> : func     -114   ipipe_check_context (boomerang_start_xmit)
> : func     -114   issue_and_wait (boomerang_start_xmit)
> : func     -114   iowrite16 (issue_and_wait)
> : func     -113!  ioread16 (issue_and_wait)
> :|begin     -84   common_interrupt (ioread16)

Here we already see 30 us (!) between the last function entry and the
IRQ acceptance. That point to some hardware impact on latency, e.g. slow
buses or large DMA bursts.

> :|func      -83   __ipipe_handle_irq (common_interrupt)
> :|func      -83   __ipipe_ack_irq (__ipipe_handle_irq)
> :|func      -82   __ipipe_ack_level_irq (__ipipe_ack_irq)
> :|func      -82   mask_and_ack_8259A (__ipipe_ack_level_irq)

If you have a reasonable motherboard, try to turn on Local APIC and
IO-APIC. That will avoid a bit overhead due to PIC fiddling.

> :|func      -82+  __ipipe_spin_lock_irqsave (mask_and_ack_8259A)
> :|func      -78   __ipipe_spin_unlock_irqrestore (mask_and_ack_8259A)
> :|func      -78   __ipipe_dispatch_wired (__ipipe_handle_irq)
> :|func      -77   xnintr_clock_handler (__ipipe_dispatch_wired)
> :|func      -77   xnintr_irq_handler (xnintr_clock_handler)
> :|func      -77   xnpod_announce_tick (xnintr_irq_handler)
> :|func      -76   xntimer_do_tick_aperiodic (xnpod_announce_tick)
> :|func      -76   xnthread_periodic_handler (xntimer_do_tick_aperiodic)
> :|func      -76   xnpod_resume_thread (xnthread_periodic_handler)
> :|[ 3937]   -75+  xnpod_resume_thread (xnthread_periodic_handler)

This is likely the wakeup call to your measurement thread (verbose mode
would tell us more).

> :|func      -72   xnpod_schedule (xnintr_irq_handler)
> :|[ 3497]   -72+  xnpod_schedule (xnintr_irq_handler)
> :|func      -71   __switch_to (xnpod_schedule)
> :|[ 3937]   -70   xnpod_schedule (xnpod_suspend_thread)
> :|func      -70   __ipipe_restore_pipeline_head (xnpod_wait_thread_peri=
od)
> :|end       -69+  __ipipe_restore_pipeline_head (xnpod_wait_thread_peri=
od)
> :|begin     -63   common_interrupt (__ipipe_restore_pipeline_head)

Some disturbing IRQ between wakeup and measurement. Maybe some HD
activity, or an IRQ from the NIC, or you hit the keyboard, or...

> :|func      -62   __ipipe_handle_irq (common_interrupt)
> :|func      -62   __ipipe_ack_irq (__ipipe_handle_irq)
> :|func      -62   __ipipe_ack_level_irq (__ipipe_ack_irq)
> :|func      -61   mask_and_ack_8259A (__ipipe_ack_level_irq)
> :|func      -61!  __ipipe_spin_lock_irqsave (mask_and_ack_8259A)
> :|func      -40   __ipipe_spin_unlock_irqrestore (mask_and_ack_8259A)
> :|func      -40   __ipipe_walk_pipeline (__ipipe_handle_irq)
> :|end       -39+  common_interrupt (__ipipe_restore_pipeline_head)
> :|begin     -32   common_interrupt (__ipipe_restore_pipeline_head)

And another IRQ!

> :|func      -32   __ipipe_handle_irq (common_interrupt)
> :|func      -31   __ipipe_ack_irq (__ipipe_handle_irq)
> :|func      -31   __ipipe_ack_level_irq (__ipipe_ack_irq)
> :|func      -31   mask_and_ack_8259A (__ipipe_ack_level_irq)
> :|func      -30+  __ipipe_spin_lock_irqsave (mask_and_ack_8259A)
> :|func      -25   __ipipe_spin_unlock_irqrestore (mask_and_ack_8259A)
> :|func      -24   __ipipe_dispatch_wired (__ipipe_handle_irq)
> :|func      -24   xnintr_clock_handler (__ipipe_dispatch_wired)
> :|func      -23   xnintr_irq_handler (xnintr_clock_handler)
> :|func      -23   xnpod_announce_tick (xnintr_irq_handler)
> :|func      -23   xntimer_do_tick_aperiodic (xnpod_announce_tick)
> :|func      -22+  xnthread_periodic_handler (xntimer_do_tick_aperiodic)
> :|func      -13   rthal_irq_host_pend (xnintr_irq_handler)

Ah, it's the Linux host tick. That's normal, one has to consider this
for the worst case.

> :|func      -13   __ipipe_schedule_irq (rthal_irq_host_pend)
> :|func      -12   __ipipe_walk_pipeline (__ipipe_handle_irq)
> :|end       -12   common_interrupt (__ipipe_restore_pipeline_head)
> :|begin     -11   __ipipe_dispatch_event (__ipipe_syscall_root)
> :|end       -11+  __ipipe_dispatch_event (__ipipe_syscall_root)
> : func       -8   __ipipe_syscall_root (system_call)
> : func       -7   __ipipe_dispatch_event (__ipipe_syscall_root)
> :|begin      -7   __ipipe_dispatch_event (__ipipe_syscall_root)
> :|end        -6   __ipipe_dispatch_event (__ipipe_syscall_root)
> : func       -6+  hisyscall_event (__ipipe_dispatch_event)
> : func       -5+  xnshadow_sys_trace (hisyscall_event)

And here we finally found the time to run latency code and measure the
delay. All in all, a reasonable code path, maybe one can tune a bit here
and there, but the general pattern is expected.

> : func       -4   ipipe_trace_frozen_reset (xnshadow_sys_trace)
> : func       -3   __ipipe_global_path_lock (ipipe_trace_frozen_reset)
> : func       -3   __ipipe_spin_lock_irqsave (__ipipe_global_path_lock)
> :|begin      -2+  __ipipe_spin_lock_irqsave (__ipipe_global_path_lock)
> :|func        0   __ipipe_spin_unlock_irqcomplete (__ipipe_global_path_=
unlock)
> :|end         0   __ipipe_spin_unlock_irqcomplete (__ipipe_global_path_=
unlock)
> < freeze      0   xnshadow_sys_trace (hisyscall_event)
>  |begin       0   __ipipe_dispatch_event (__ipipe_syscall_root)
>  |end         0   __ipipe_dispatch_event (__ipipe_syscall_root)
>   func        1   __ipipe_syscall_root (system_call)
>   func        2   __ipipe_dispatch_event (__ipipe_syscall_root)
>  |begin       2   __ipipe_dispatch_event (__ipipe_syscall_root)
>  |end         2   __ipipe_dispatch_event (__ipipe_syscall_root)
>   func        3   hisyscall_event (__ipipe_dispatch_event)
>   func        3   __rt_task_wait_period (hisyscall_event)
>   func        3   rt_task_wait_period (__rt_task_wait_period)
>   func        4   xnpod_wait_thread_period (rt_task_wait_period)
>=20

Jan

--=20
Siemens AG, Corporate Technology, CT SE 2
Corporate Competence Center Embedded Linux

