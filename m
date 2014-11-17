From: "Lennart Sorensen" <lsorense@csclub.uwaterloo.ca>
Date: Mon, 17 Nov 2014 17:10:01 -0500
Message-ID: <20141117221001.GX24110@csclub.uwaterloo.ca>
References: <20141001142416.GA4435@csclub.uwaterloo.ca>
 <20141107182600.GS24110@csclub.uwaterloo.ca>
 <545D12D2.2020104@xenomai.org>
 <20141117191237.GS24110@csclub.uwaterloo.ca>
 <20141117201435.GH31920@sisyphus.hd.free.fr>
 <20141117202425.GU24110@csclub.uwaterloo.ca>
 <20141117202754.GI31920@sisyphus.hd.free.fr>
 <20141117214734.GW24110@csclub.uwaterloo.ca>
 <20141117215458.GM31920@sisyphus.hd.free.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20141117215458.GM31920@sisyphus.hd.free.fr>
Subject: Re: [Xenomai] I-pipe error when requesting irq that is on omap gpio
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

On Mon, Nov 17, 2014 at 10:54:58PM +0100, Gilles Chanteperdrix wrote:
> On Mon, Nov 17, 2014 at 04:47:34PM -0500, Lennart Sorensen wrote:
> > On Mon, Nov 17, 2014 at 09:27:54PM +0100, Gilles Chanteperdrix wrote:
> > > On Mon, Nov 17, 2014 at 03:24:25PM -0500, Lennart Sorensen wrote:
> > > > On Mon, Nov 17, 2014 at 09:14:35PM +0100, Gilles Chanteperdrix wrote:
> > > > > Well, have you tried triggering an I-pipe tracer trace to see what
> > > > > happens in the interval?
> > > > 
> > > > I have never used the tracer. I suppose I should learn how.
> > > 
> > > It is not very complicated. I have already been told on this list
> > > that it was not well documented. I do not think so, but I let you
> > > judge of that.
> > > 
> > > http://xenomai.org/2014/06/using-the-i-pipe-tracer/
> > 
> > So here is what I got triggering a couple of times on the IRQ.  Not
> > entirely sure how to make sense of it, although there is one huge number.
> > 
> > back_trace_points:100
> > enable:1
> > frozen:I-pipe frozen back-tracing service on 3.12-1-am5726/ipipe release #2
> > frozen:------------------------------------------------------------
> > frozen:CPU: 0, Freeze: 2415647132 cycles, Trace Points: 100 (+10)
> > frozen:Calibrated minimum trace-point overhead: 0.428 us
> > frozen: +----- Hard IRQs ('|': locked)
> > frozen: |+-- Xenomai
> > frozen: ||+- Linux ('*': domain stalled, '+': current, '#': current+stalled)
> > frozen: |||			  +---------- Delay flag ('+': > 1 us, '!': > 10 us)
> > frozen: |||			  |	   +- NMI noise ('N')
> > frozen: |||			  |	   |
> > frozen:	  Type	  User Val.   Time    Delay  Function (Parent)
> > frozen::    #func                -662	  0.857  arch_cpu_idle_enter+0x10 (cpu_startup_entry+0xb8)
> > frozen::    #func                -661	  1.000  ledtrig_cpu+0x10 (arch_cpu_idle_enter+0x1c)
> > frozen::    #func                -660	  1.000  led_trigger_event+0x10 (ledtrig_cpu+0x58)
> > frozen::    #func                -659+   1.285  _raw_read_lock+0x10 (led_trigger_event+0x30)
> > frozen::    #func                -658	  0.857  tick_check_broadcast_expired+0x10 (cpu_startup_entry+0x40)
> > frozen::    #func                -657	  1.000  rcu_idle_enter+0x10 (cpu_startup_entry+0x58)
> > frozen::    #func                -656	  0.857  ipipe_test_and_stall_root+0x10 (rcu_idle_enter+0x18)
> > frozen::    #func                -655	  0.857  ipipe_root_only+0x14 (ipipe_test_and_stall_root+0x18)
> > frozen::|   #begin   0x80000001  -654+   1.428  ipipe_root_only+0xb8 (ipipe_test_and_stall_root+0x18)
> > frozen::|   #end     0x80000001  -653	  1.000  ipipe_root_only+0xa4 (ipipe_test_and_stall_root+0x18)
> > frozen::|   #begin   0x80000001  -652	  1.000  ipipe_test_and_stall_root+0x84 (rcu_idle_enter+0x18)
> > frozen::|   #end     0x80000001  -651	  1.000  ipipe_test_and_stall_root+0x70 (rcu_idle_enter+0x18)
> > frozen::    #func                -650	  1.000  rcu_eqs_enter_common.isra.47+0x14 (rcu_idle_enter+0x84)
> > frozen::    #func                -649	  1.000  arch_cpu_idle+0x10 (cpu_startup_entry+0x5c)
> > frozen::|   #begin   0x80000000  -648	  1.000  arch_cpu_idle+0xa4 (cpu_startup_entry+0x5c)
> > frozen::|   +func                -647! 555.142 omap_default_idle+0x10 (arch_cpu_idle+0x90)      <-- What ever is
> > that?  That looks huge.
> 
> As the name suggests, it means that the CPU remains idle for 500us.
> You know, when the cpu load is not 100%, this is what the cpu is
> doing the rest of the time, executing the wfi instruction to wait
> for the next interrupt.
> 
> > frozen::|   +end     0x80000000   -92+   1.142 omap_default_idle+0x40 (arch_cpu_idle+0x90)
>   (...)
> > frozen::|  +*func                  -6	  0.857  gic_handle_irq+0x10 (__irq_svc+0x58)
> > frozen::|  +*func                  -6	  1.000  irq_find_mapping+0x14 (gic_handle_irq+0x30)
> > frozen::|  +*func                  -5	  0.857  __ipipe_grab_irq+0x10 (gic_handle_irq+0x38)
> > frozen::|  +*begin   0x00000043    -4	  1.000  __ipipe_grab_irq+0x50 (gic_handle_irq+0x38)
> > frozen::|  +*func                  -3	  0.857  __ipipe_dispatch_irq+0x14 (__ipipe_grab_irq+0x74)
> > frozen::|  +*func                  -2	  1.000  irq_to_desc+0x10 (__ipipe_dispatch_irq+0xd4)
> > frozen::|  +*func                  -1+   1.285  irq_to_desc+0x10 (__ipipe_dispatch_irq+0xe4)
> > frozen:<|  +*func                   0	  1.142  gpio_irq_handler+0x14 (__ipipe_dispatch_irq+0x70)
> > frozen: |  +*func                   1	  1.571  irq_to_desc+0x10 (gpio_irq_handler+0x38)
> > frozen: |  +*func                   2	  1.000  irq_find_mapping+0x14 (gpio_irq_handler+0x190)
> > frozen: |  +*begin   0x0000018e     3	  0.857  gpio_irq_handler+0x198 (__ipipe_dispatch_irq+0x70)
> > frozen: |  +*func                   4	  0.857  __ipipe_dispatch_irq+0x14 (gpio_irq_handler+0x1a4)
> > frozen: |  +*func                   5	  1.000  irq_to_desc+0x10 (__ipipe_dispatch_irq+0xd4)
> > frozen: |  +*func                   6	  1.142  irq_to_desc+0x10 (__ipipe_dispatch_irq+0xe4)
> > frozen: |  +*func                   7	  1.142  __ipipe_ack_level_irq+0x10 (__ipipe_dispatch_irq+0x70)
> > frozen: |  +*func                   8	  0.857  gpio_mask_ack_irq+0x10 (__ipipe_ack_level_irq+0x30)
> > frozen: |  +*func                   9	  3.428  __ipipe_spin_lock_irqsave+0x10 (gpio_mask_ack_irq+0x30)
> > frozen: |  #*func                  13	  0.000
> > __ipipe_spin_unlock_irqrestore+0x10 (gpio_mask_ack_irq+0x210)
> 
> 
> So, the end of the trace is executing gpio_mask_ack_irq. Trace is
> to short. It stops just when things were beginning to become
> interesting. Please increase the number of trace points.

Good to know.  Will increase it.

I increases it to 100 and get this:

I-pipe frozen back-tracing service on 3.12-1-am5726/ipipe release #2
------------------------------------------------------------
CPU: 0, Freeze: 2472048413 cycles, Trace Points: 100 (+100)
Calibrated minimum trace-point overhead: 0.428 us

 +----- Hard IRQs ('|': locked)
 |+-- Xenomai
 ||+- Linux ('*': domain stalled, '+': current, '#': current+stalled)
 |||			  +---------- Delay flag ('+': > 1 us, '!': > 10 us)
 |||			  |	   +- NMI noise ('N')
 |||			  |	   |
	  Type	  User Val.   Time    Delay  Function (Parent)
:    #func                -104	  0.857  internal_add_timer+0x10 (mod_timer+0x10c)
:    #func                -103	  1.000  __internal_add_timer+0x10 (internal_add_timer+0x20)
:    #func                -102	  0.857  __ipipe_spin_unlock_debug+0x10 (mod_timer+0x114)
:    #func                -102	  1.000  _raw_spin_unlock_irqrestore+0x10 (mod_timer+0x120)
:    #func                -101	  1.000  ipipe_unstall_root+0x10 (_raw_spin_unlock_irqrestore+0x38)
:|   #begin   0x80000000  -100	  1.000  ipipe_unstall_root+0x90 (_raw_spin_unlock_irqrestore+0x38)
:|   #func                 -99+   1.428  ipipe_root_only+0x14 (ipipe_unstall_root+0x24)
:|   +end     0x80000000   -97	  1.000  ipipe_unstall_root+0x7c (_raw_spin_unlock_irqrestore+0x38)
:    +func                 -96	  1.000  _raw_spin_lock_irq+0x10 (run_timer_softirq+0x1f4)
:    +func                 -95	  1.000  ipipe_stall_root+0x10 (_raw_spin_lock_irq+0x1c)
:    +func                 -94	  0.857  ipipe_root_only+0x14 (ipipe_stall_root+0x18)
:|   +begin   0x80000001   -93+   1.285  ipipe_root_only+0xb8 (ipipe_stall_root+0x18)
:|   +end     0x80000001   -92	  1.000  ipipe_root_only+0xa4 (ipipe_stall_root+0x18)
:|   +begin   0x80000001   -91+   1.142  ipipe_stall_root+0x7c (_raw_spin_lock_irq+0x1c)
:|   #end     0x80000001   -90+   1.142  ipipe_stall_root+0x6c (_raw_spin_lock_irq+0x1c)
:    #func                 -89	  1.000  ipipe_unstall_root+0x10 (run_timer_softirq+0x1d0)
:|   #begin   0x80000000   -88	  0.857  ipipe_unstall_root+0x90 (run_timer_softirq+0x1d0)
:|   #func                 -87+   1.428  ipipe_root_only+0x14 (ipipe_unstall_root+0x24)
:|   +end     0x80000000   -85+   1.142  ipipe_unstall_root+0x7c (run_timer_softirq+0x1d0)
:    +func                 -84	  0.857  rcu_bh_qs+0x10 (__do_softirq+0x134)
:    +func                 -83	  0.857  ipipe_stall_root+0x10 (__do_softirq+0x148)
:    +func                 -83	  1.000  ipipe_root_only+0x14 (ipipe_stall_root+0x18)
:|   +begin   0x80000001   -82+   1.285  ipipe_root_only+0xb8 (ipipe_stall_root+0x18)
:|   +end     0x80000001   -80	  1.000  ipipe_root_only+0xa4 (ipipe_stall_root+0x18)
:|   +begin   0x80000001   -79+   1.142  ipipe_stall_root+0x7c (__do_softirq+0x148)
:|   #end     0x80000001   -78	  1.000  ipipe_stall_root+0x6c (__do_softirq+0x148)
:    #func                 -77	  1.000  __local_bh_enable+0x10 (__do_softirq+0x1a8)
:    #func                 -76	  0.857  ipipe_test_root+0x10 (__local_bh_enable+0x40)
:|   #begin   0x80000001   -75+   1.142  ipipe_test_root+0x78 (__local_bh_enable+0x40)
:|   #end     0x80000001   -74	  1.000  ipipe_test_root+0x64 (__local_bh_enable+0x40)
:    #func                 -73	  0.857  ipipe_root_only+0x14 (__local_bh_enable+0x4c)
:|   #begin   0x80000001   -72+   1.285  ipipe_root_only+0xb8 (__local_bh_enable+0x4c)
:|   #end     0x80000001   -71	  1.000  ipipe_root_only+0xa4 (__local_bh_enable+0x4c)
:    #func                 -70	  1.000  rcu_irq_exit+0x10 (irq_exit+0x84)
:    #func                 -69	  0.857  ipipe_test_and_stall_root+0x10 (rcu_irq_exit+0x18)
:    #func                 -68	  1.000  ipipe_root_only+0x14 (ipipe_test_and_stall_root+0x18)
:|   #begin   0x80000001   -67+   1.285  ipipe_root_only+0xb8 (ipipe_test_and_stall_root+0x18)
:|   #end     0x80000001   -66	  1.000  ipipe_root_only+0xa4 (ipipe_test_and_stall_root+0x18)
:|   #begin   0x80000001   -65	  1.000  ipipe_test_and_stall_root+0x84 (rcu_irq_exit+0x18)
:|   #end     0x80000001   -64	  1.000  ipipe_test_and_stall_root+0x70 (rcu_irq_exit+0x18)
:    #func                 -63+   1.142  rcu_eqs_enter_common.isra.47+0x14 (rcu_irq_exit+0x84)
:|   #begin   0x80000000   -62+   1.285  __ipipe_do_sync_stage+0x288 (__ipipe_do_sync_pipeline+0x140)
:|   +end     0x0000001b   -60	  0.857  __ipipe_grab_irq+0x7c (gic_handle_irq+0x38)
:|   +func                 -60	  0.857  __ipipe_exit_irq+0x10 (__ipipe_grab_irq+0x84)
:|   +func                 -59+   1.142  __ipipe_check_root_interruptible+0x10 (__irq_svc+0x5c)
:|   +func                 -58+   1.142  ipipe_test_root+0x10 (__ipipe_check_root_interruptible+0x60)
:|   +func                 -56	  1.000  __ipipe_bugon_irqs_enabled+0x10 (__ipipe_fast_svc_irq_exit+0x4)
:|   +end     0x90000000   -55	  1.000  __ipipe_fast_svc_irq_exit+0x18 (omap_default_idle+0x44)
:    +func                 -54	  1.000  ipipe_unstall_root+0x10 (arch_cpu_idle+0x94)
:|   +begin   0x80000000   -53	  0.857  ipipe_unstall_root+0x90 (arch_cpu_idle+0x94)
:|   +func                 -53+   1.571  ipipe_root_only+0x14 (ipipe_unstall_root+0x24)
:|   +end     0x80000000   -51	  1.000  ipipe_unstall_root+0x7c (arch_cpu_idle+0x94)
:    +func                 -50	  0.857  ipipe_test_root+0x10 (cpu_startup_entry+0x60)
:|   +begin   0x80000001   -49+   1.142  ipipe_test_root+0x78 (cpu_startup_entry+0x60)
:|   +end     0x80000001   -48+   1.142  ipipe_test_root+0x64 (cpu_startup_entry+0x60)
:|   +begin   0x90000000   -47	  1.000  __irq_svc+0x44 (ipipe_test_root+0x68)
:|   +func                 -46	  0.857  gic_handle_irq+0x10 (__irq_svc+0x58)
:|   +func                 -45	  1.000  irq_find_mapping+0x14 (gic_handle_irq+0x30)
:|   +func                 -44	  1.000  __ipipe_grab_irq+0x10 (gic_handle_irq+0x38)
:|   +begin   0x0000001b   -43	  1.000  __ipipe_grab_irq+0x50 (gic_handle_irq+0x38)
:|   +func                 -42	  1.000  __ipipe_dispatch_irq+0x14 (__ipipe_grab_irq+0x74)
:|   +func                 -41	  1.000  irq_to_desc+0x10 (__ipipe_dispatch_irq+0xd4)
:|   +func                 -40	  1.000  irq_to_desc+0x10 (__ipipe_dispatch_irq+0xe4)
:|   +func                 -39	  1.000  __ipipe_ack_hrtimer_irq+0x10 (__ipipe_dispatch_irq+0x70)
:|   +func                 -38	  1.000  __ipipe_ack_fasteoi_irq+0x10 (__ipipe_ack_hrtimer_irq+0x60)
:|   +func                 -37	  0.857  gic_hold_irq+0x10 (__ipipe_ack_fasteoi_irq+0x24)
:|   +func                 -36+   1.142  __ipipe_spin_lock_irqsave+0x10 (gic_hold_irq+0x34)
:|   #func                 -35+   1.285  __ipipe_spin_unlock_irqrestore+0x10 (gic_hold_irq+0x98)
:|   +func                 -34	  1.000  arch_itimer_ack_virt+0x10 (__ipipe_ack_hrtimer_irq+0x70)
:|   +func                 -33	  0.857  __ipipe_end_fasteoi_irq+0x10 (__ipipe_ack_hrtimer_irq+0x88)
:|   +func                 -32	  1.000  gic_release_irq+0x10 (__ipipe_end_fasteoi_irq+0x2c)
:|   +func                 -31+   1.142  __ipipe_spin_lock_irqsave+0x10 (gic_release_irq+0x34)
:|   #func                 -30+   1.857  __ipipe_spin_unlock_irqrestore+0x10 (gic_release_irq+0x74)
:|  # func                 -28+   1.285  xnintr_clock_handler+0x14 [xeno_nucleus] (__ipipe_dispatch_irq+0x270)
:|  # func                 -27	  0.857  xntimer_tick_aperiodic+0x14 [xeno_nucleus] (xnintr_clock_handler+0x1e0 [xeno_nucleus])
:|  # func                 -26	  0.857  xnthread_timeout_handler+0x10 [xeno_nucleus] (xntimer_tick_aperiodic+0x13c [xeno_nucleus])
:|  # func                 -25+   1.142  xnpod_resume_thread+0x14 [xeno_nucleus] (xnthread_timeout_handler+0x34 [xeno_nucleus])
:|  # [ 5285] MAC Poll 0   -24+   1.285  xnpod_resume_thread+0x124 [xeno_nucleus] (xnthread_timeout_handler+0x34 [xeno_nucleus])
:|  # func                 -22	  0.857  xntimer_next_local_shot+0x10 [xeno_nucleus] (xntimer_tick_aperiodic+0x288 [xeno_nucleus])
:|  # event   tick@16049   -22	  0.857  xntimer_next_local_shot+0xb4 [xeno_nucleus] (xntimer_tick_aperiodic+0x288 [xeno_nucleus])
:|  # func                 -21+   1.142  ipipe_timer_set+0x10 (xntimer_next_local_shot+0xbc [xeno_nucleus])
:|  # func                 -20+   1.285  arch_timer_set_next_event_virt+0x10 (ipipe_timer_set+0x7c)
:|  # func                 -18+   1.285  __xnpod_schedule+0x14 [xeno_nucleus] (xnintr_clock_handler+0x408 [xeno_nucleus])
:|  # [    0] -<?>-   -1   -17	  1.000  __xnpod_schedule+0x194 [xeno_nucleus] (xnintr_clock_handler+0x408 [xeno_nucleus])
:|  # func                 -16	  1.000  xnsched_pick_next+0x10 [xeno_nucleus] (__xnpod_schedule+0x328 [xeno_nucleus])
:|  # func                 -15	  0.857  omap4_mute_pic+0x10 (__xnpod_schedule+0x714 [xeno_nucleus])
:|  # func                 -14+   1.285  gic_mute+0x10 (omap4_mute_pic+0x1c)
:|  # func                 -13+   1.857  _get_gpio_irqbank_mask+0x10 (omap4_mute_pic+0x58)
:|  # [ 5285] MAC Poll 0   -11+   1.571  __xnpod_schedule+0x604 [xeno_nucleus] (xnpod_suspend_thread+0x494 [xeno_nucleus])
:|  # func                  -9	  1.000  __ipipe_restore_head+0x10 (xnpod_suspend_thread+0x1c4 [xeno_nucleus])
:|  + end     0x80000000    -8	  1.000  __ipipe_restore_head+0xd8 (xnpod_suspend_thread+0x1c4 [xeno_nucleus])
:|  + begin   0x90000000    -7	  1.000  __irq_svc+0x44 (__ipipe_restore_head+0xdc)
:|  + func                  -6	  1.000  gic_handle_irq+0x10 (__irq_svc+0x58)
:|  + func                  -5	  0.857  irq_find_mapping+0x14 (gic_handle_irq+0x30)
:|  + func                  -5	  1.000  __ipipe_grab_irq+0x10 (gic_handle_irq+0x38)
:|  + begin   0x00000043    -4	  1.000  __ipipe_grab_irq+0x50 (gic_handle_irq+0x38)
:|  + func                  -3	  0.857  __ipipe_dispatch_irq+0x14 (__ipipe_grab_irq+0x74)
:|  + func                  -2	  1.000  irq_to_desc+0x10 (__ipipe_dispatch_irq+0xd4)
:|  + func                  -1+   1.142  irq_to_desc+0x10 (__ipipe_dispatch_irq+0xe4)
<|  + func                   0	  1.142  gpio_irq_handler+0x14 (__ipipe_dispatch_irq+0x70)
 |  + func                   1	  1.571  irq_to_desc+0x10 (gpio_irq_handler+0x38)
 |  + func                   2	  1.000  irq_find_mapping+0x14 (gpio_irq_handler+0x190)
 |  + begin   0x0000018e     3	  0.857  gpio_irq_handler+0x198 (__ipipe_dispatch_irq+0x70)
 |  + func                   4	  0.857  __ipipe_dispatch_irq+0x14 (gpio_irq_handler+0x1a4)
 |  + func                   5	  1.142  irq_to_desc+0x10 (__ipipe_dispatch_irq+0xd4)
 |  + func                   6	  1.142  irq_to_desc+0x10 (__ipipe_dispatch_irq+0xe4)
 |  + func                   7	  1.000  __ipipe_ack_level_irq+0x10 (__ipipe_dispatch_irq+0x70)
 |  + func                   8	  1.000  gpio_mask_ack_irq+0x10 (__ipipe_ack_level_irq+0x30)
 |  + func                   9	  3.571  __ipipe_spin_lock_irqsave+0x10 (gpio_mask_ack_irq+0x30)
 |  # func                  13	  1.714  __ipipe_spin_unlock_irqrestore+0x10 (gpio_mask_ack_irq+0x210)
 |  + func                  15	  1.142  __ipipe_set_irq_pending+0x10 (__ipipe_dispatch_irq+0x490)
 |  + end     0x0000018e    16	  1.428  gpio_irq_handler+0x1ac (__ipipe_dispatch_irq+0x70)
 |  + func                  17	  0.857  gic_eoi_irq+0x10 (gpio_irq_handler+0x168)
 |  + func                  18	  1.142  __ipipe_spin_lock_irqsave+0x10 (gic_eoi_irq+0x24)
 |  # func                  19	  1.714  __ipipe_spin_unlock_irqrestore+0x10 (gic_eoi_irq+0x48)
 |  + func                  21	  1.142  __ipipe_do_sync_stage+0x14 (__ipipe_dispatch_irq+0x3d4)
 |  # func                  22	  1.428  xnintr_irq_handler+0x14 [xeno_nucleus] (__ipipe_do_sync_stage+0x1e8)
 |  # func                  23	  1.000  rt_intr_handler+0x10 [xeno_native] (xnintr_irq_handler+0x11c [xeno_nucleus])
 |  # func                  24	  1.285  xnsynch_flush+0x14 [xeno_nucleus] (rt_intr_handler+0x3c [xeno_native])
 |  # func                  26	  1.428  xnpod_resume_thread+0x14 [xeno_nucleus] (xnsynch_flush+0x160 [xeno_nucleus])
 |  # [ 5284] 000000 257    27	  2.142  xnpod_resume_thread+0x124 [xeno_nucleus] (xnsynch_flush+0x160 [xeno_nucleus])
 |  # func                  29	  1.428  __xnpod_schedule+0x14 [xeno_nucleus] (xnintr_irq_handler+0x318 [xeno_nucleus])
 |  # [ 5285] MAC Poll 0    31	  0.857  __xnpod_schedule+0x194 [xeno_nucleus] (xnintr_irq_handler+0x318 [xeno_nucleus])
 |  # func                  32	  2.000  xnsched_pick_next+0x10 [xeno_nucleus] (__xnpod_schedule+0x328 [xeno_nucleus])
 |  # [ 5284] 000000 257    34	  3.142  __xnpod_schedule+0x604 [xeno_nucleus] (xnpod_suspend_thread+0x494 [xeno_nucleus])
 |  # func                  37	  1.142  __ipipe_restore_head+0x10 (__rt_intr_wait+0x210 [xeno_native])
 |  + end     0x80000000    38	  1.714  __ipipe_restore_head+0xd8 (__rt_intr_wait+0x210 [xeno_native])
 |  + begin   0x80000001    40	  1.428  __ipipe_notify_syscall+0x208 (pipeline_syscall+0x8)
 |  + end     0x80000001    41	  0.857  __ipipe_notify_syscall+0x250 (pipeline_syscall+0x8)
 |  + func                  42	  1.000  __ipipe_bugon_irqs_enabled+0x10 (__ipipe_ret_to_user_irqs_disabled+0x4)
 |  + end     0x90000000    43	  2.142  __ipipe_ret_to_user_irqs_disabled+0x18 (<b6f0ba30>)
 |  + begin   0x90000000    45	  1.000  vector_swi+0x3c (<b6f0cb12>)
    + func                  46	  0.857  __ipipe_notify_syscall+0x14 (pipeline_syscall+0x8)
 |  + begin   0x80000001    47	  1.428  __ipipe_notify_syscall+0x2d0 (pipeline_syscall+0x8)
 |  + end     0x80000001    48	  0.857  __ipipe_notify_syscall+0x1fc (pipeline_syscall+0x8)
    + func                  49	  0.857  ipipe_syscall_hook+0x10 (__ipipe_notify_syscall+0xc0)
 |  + begin   0x80000001    50	  1.000  ipipe_syscall_hook+0x9c (__ipipe_notify_syscall+0xc0)
 |  + end     0x80000001    51	  1.142  ipipe_syscall_hook+0x70 (__ipipe_notify_syscall+0xc0)
    + func                  52	  1.000  hisyscall_event+0x14 [xeno_nucleus] (ipipe_syscall_hook+0x90)
    + func                  53	  1.000  __rt_sem_v+0x14 [xeno_native] (hisyscall_event+0x1a0 [xeno_nucleus])
    + func                  54	  1.428  xnregistry_fetch+0x10 [xeno_nucleus] (__rt_sem_v+0x68 [xeno_native])
    + func                  56	  1.000  rt_sem_v+0x14 [xeno_native] (__rt_sem_v+0x74 [xeno_native])
 |  + begin   0x80000000    57	  1.857  rt_sem_v+0x20c [xeno_native] (__rt_sem_v+0x74 [xeno_native])
 |  # func                  58	  1.285  xnsynch_wakeup_one_sleeper+0x14 [xeno_nucleus] (rt_sem_v+0x218 [xeno_native])
 |  # func                  60	  1.428  xnpod_resume_thread+0x14 [xeno_nucleus] (xnsynch_wakeup_one_sleeper+0x158 [xeno_nucleus])
 |  # [ 5283] M88E6xx 90    61	  1.285  xnpod_resume_thread+0x124 [xeno_nucleus] (xnsynch_wakeup_one_sleeper+0x158 [xeno_nucleus])
 |  # func                  62	  1.428  __xnpod_schedule+0x14 [xeno_nucleus] (rt_sem_v+0x268 [xeno_native])
 |  # [ 5284] 000000 257    64	  0.857  __xnpod_schedule+0x194 [xeno_nucleus] (rt_sem_v+0x268 [xeno_native])
 |  # func                  65	  1.571  xnsched_pick_next+0x10 [xeno_nucleus] (__xnpod_schedule+0x328 [xeno_nucleus])
 |  # func                  66	  1.000  __ipipe_restore_head+0x10 (rt_sem_v+0x168 [xeno_native])
 |  + end     0x80000000    67	  1.142  __ipipe_restore_head+0xd8 (rt_sem_v+0x168 [xeno_native])
 |  + begin   0x80000001    68	  1.142  __ipipe_notify_syscall+0x208 (pipeline_syscall+0x8)
 |  + end     0x80000001    70	  0.857  __ipipe_notify_syscall+0x250 (pipeline_syscall+0x8)
 |  + func                  70	  0.857  __ipipe_bugon_irqs_enabled+0x10 (__ipipe_ret_to_user_irqs_disabled+0x4)
 |  + end     0x90000000    71	  2.000  __ipipe_ret_to_user_irqs_disabled+0x18 (<b6f0cb16>)
 |  + begin   0x90000000    73	  1.000  vector_swi+0x3c (<b6f0ba2c>)
    + func                  74	  0.857  __ipipe_notify_syscall+0x14 (pipeline_syscall+0x8)
 |  + begin   0x80000001    75	  1.285  __ipipe_notify_syscall+0x2d0 (pipeline_syscall+0x8)
 |  + end     0x80000001    76	  0.857  __ipipe_notify_syscall+0x1fc (pipeline_syscall+0x8)
    + func                  77	  1.000  ipipe_syscall_hook+0x10 (__ipipe_notify_syscall+0xc0)
 |  + begin   0x80000001    78	  1.000  ipipe_syscall_hook+0x9c (__ipipe_notify_syscall+0xc0)
 |  + end     0x80000001    79	  0.857  ipipe_syscall_hook+0x70 (__ipipe_notify_syscall+0xc0)
    + func                  80	  1.000  hisyscall_event+0x14 [xeno_nucleus] (ipipe_syscall_hook+0x90)
    + func                  81	  1.000  __rt_intr_wait+0x14 [xeno_native] (hisyscall_event+0x1a0 [xeno_nucleus])
 |  + begin   0x80000000    82	  1.142  __rt_intr_wait+0xc8 [xeno_native] (hisyscall_event+0x1a0 [xeno_nucleus])
 |  # func                  83	  1.000  xnregistry_fetch+0x10 [xeno_nucleus] (__rt_intr_wait+0x19c [xeno_native])
 |  # func                  84	  1.000  xnregistry_fetch+0x10 [xeno_nucleus] (__rt_intr_wait+0x1ac [xeno_native])
 |  # func                  85	  0.857  xnregistry_fetch+0x10 [xeno_nucleus] (__rt_intr_wait+0x2a8 [xeno_native])
 |  # func                  86	  1.285  xnsynch_sleep_on+0x14 [xeno_nucleus] (__rt_intr_wait+0x30c [xeno_native])
 |  # func                  87	  1.285  xnpod_suspend_thread+0x14 [xeno_nucleus] (xnsynch_sleep_on+0x170 [xeno_nucleus])
 |  # func                  89	  1.428  __xnpod_schedule+0x14 [xeno_nucleus] (xnpod_suspend_thread+0x494 [xeno_nucleus])
 |  # [ 5284] 000000 257    90	  1.000  __xnpod_schedule+0x194 [xeno_nucleus] (xnpod_suspend_thread+0x494 [xeno_nucleus])
 |  # func                  91	  1.857  xnsched_pick_next+0x10 [xeno_nucleus] (__xnpod_schedule+0x328 [xeno_nucleus])
 |  # [ 5283] M88E6xx 90    93	  3.285  __xnpod_schedule+0x604 [xeno_nucleus] (xnpod_suspend_thread+0x494 [xeno_nucleus])
 |  # func                  96	  1.285  __ipipe_restore_head+0x10 (rt_sem_p_inner+0x170 [xeno_native])
 |  + end     0x80000000    98	  2.142  __ipipe_restore_head+0xd8 (rt_sem_p_inner+0x170 [xeno_native])
 |  + begin   0x80000001   100	  1.142  __ipipe_notify_syscall+0x208 (pipeline_syscall+0x8)
 |  + end     0x80000001   101	  1.000  __ipipe_notify_syscall+0x250 (pipeline_syscall+0x8)
 |  + func                 102	  0.857  __ipipe_bugon_irqs_enabled+0x10 (__ipipe_ret_to_user_irqs_disabled+0x4)
 |  + end     0x90000000   103	 47.428  __ipipe_ret_to_user_irqs_disabled+0x18 (<b6f0ca5c>)
 |  + begin   0x90000000   150	  0.857  vector_swi+0x3c (<b6f0d7fe>)
    + func                 151	  1.000  __ipipe_notify_syscall+0x14 (pipeline_syscall+0x8)
 |  + begin   0x80000001   152	  1.285  __ipipe_notify_syscall+0x2d0 (pipeline_syscall+0x8)
 |  + end     0x80000001   153	  0.857  __ipipe_notify_syscall+0x1fc (pipeline_syscall+0x8)
    + func                 154	  1.000  ipipe_syscall_hook+0x10 (__ipipe_notify_syscall+0xc0)
 |  + begin   0x80000001   155	  1.000  ipipe_syscall_hook+0x9c (__ipipe_notify_syscall+0xc0)
 |  + end     0x80000001   156	  0.857  ipipe_syscall_hook+0x70 (__ipipe_notify_syscall+0xc0)
    + func                 157	  1.000  hisyscall_event+0x14 [xeno_nucleus] (ipipe_syscall_hook+0x90)
    + func                 158	  0.857  __rt_timer_inquire+0x14 [xeno_native] (hisyscall_event+0x1a0 [xeno_nucleus])
    + func                 159	  0.857  rt_timer_inquire+0x10 [xeno_native] (__rt_timer_inquire+0x24 [xeno_native])
    + func                 160	  1.285  xnarch_tsc_to_ns+0x10 [xeno_nucleus] (rt_timer_inquire+0x38 [xeno_native])
 |  + begin   0x80000001   161	  1.285  __ipipe_notify_syscall+0x208 (pipeline_syscall+0x8)
 |  + end     0x80000001   162	  0.857  __ipipe_notify_syscall+0x250 (pipeline_syscall+0x8)
 |  + func                 163	  0.857  __ipipe_bugon_irqs_enabled+0x10 (__ipipe_ret_to_user_irqs_disabled+0x4)
 |  + end     0x90000000   164	  3.428  __ipipe_ret_to_user_irqs_disabled+0x18 (<b6f0d802>)
 |  + begin   0x90000000   167	  1.000  vector_swi+0x3c (<b6f0cb12>)
    + func                 168	  1.000  __ipipe_notify_syscall+0x14 (pipeline_syscall+0x8)
 |  + begin   0x80000001   169	  1.285  __ipipe_notify_syscall+0x2d0 (pipeline_syscall+0x8)
 |  + end     0x80000001   171	  0.857  __ipipe_notify_syscall+0x1fc (pipeline_syscall+0x8)
    + func                 172	  0.000  ipipe_syscall_hook+0x10 (__ipipe_notify_syscall+0xc0)

Not sure anything there looks that big.  I wonder if the gpio bank is
just slow to generate the IRQ in the first place for some reason.

-- 
Len Sorensen

