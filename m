From: "Lennart Sorensen" <lsorense@csclub.uwaterloo.ca>
Date: Mon, 17 Nov 2014 16:47:34 -0500
Message-ID: <20141117214734.GW24110@csclub.uwaterloo.ca>
References: <20141001142416.GA4435@csclub.uwaterloo.ca>
 <20141107182600.GS24110@csclub.uwaterloo.ca>
 <545D12D2.2020104@xenomai.org>
 <20141117191237.GS24110@csclub.uwaterloo.ca>
 <20141117201435.GH31920@sisyphus.hd.free.fr>
 <20141117202425.GU24110@csclub.uwaterloo.ca>
 <20141117202754.GI31920@sisyphus.hd.free.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20141117202754.GI31920@sisyphus.hd.free.fr>
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

On Mon, Nov 17, 2014 at 09:27:54PM +0100, Gilles Chanteperdrix wrote:
> On Mon, Nov 17, 2014 at 03:24:25PM -0500, Lennart Sorensen wrote:
> > On Mon, Nov 17, 2014 at 09:14:35PM +0100, Gilles Chanteperdrix wrote:
> > > Well, have you tried triggering an I-pipe tracer trace to see what
> > > happens in the interval?
> > 
> > I have never used the tracer. I suppose I should learn how.
> 
> It is not very complicated. I have already been told on this list
> that it was not well documented. I do not think so, but I let you
> judge of that.
> 
> http://xenomai.org/2014/06/using-the-i-pipe-tracer/

So here is what I got triggering a couple of times on the IRQ.  Not
entirely sure how to make sense of it, although there is one huge number.

back_trace_points:100
enable:1
frozen:I-pipe frozen back-tracing service on 3.12-1-am5726/ipipe release #2
frozen:------------------------------------------------------------
frozen:CPU: 0, Freeze: 2415647132 cycles, Trace Points: 100 (+10)
frozen:Calibrated minimum trace-point overhead: 0.428 us
frozen: +----- Hard IRQs ('|': locked)
frozen: |+-- Xenomai
frozen: ||+- Linux ('*': domain stalled, '+': current, '#': current+stalled)
frozen: |||			  +---------- Delay flag ('+': > 1 us, '!': > 10 us)
frozen: |||			  |	   +- NMI noise ('N')
frozen: |||			  |	   |
frozen:	  Type	  User Val.   Time    Delay  Function (Parent)
frozen::    #func                -662	  0.857  arch_cpu_idle_enter+0x10 (cpu_startup_entry+0xb8)
frozen::    #func                -661	  1.000  ledtrig_cpu+0x10 (arch_cpu_idle_enter+0x1c)
frozen::    #func                -660	  1.000  led_trigger_event+0x10 (ledtrig_cpu+0x58)
frozen::    #func                -659+   1.285  _raw_read_lock+0x10 (led_trigger_event+0x30)
frozen::    #func                -658	  0.857  tick_check_broadcast_expired+0x10 (cpu_startup_entry+0x40)
frozen::    #func                -657	  1.000  rcu_idle_enter+0x10 (cpu_startup_entry+0x58)
frozen::    #func                -656	  0.857  ipipe_test_and_stall_root+0x10 (rcu_idle_enter+0x18)
frozen::    #func                -655	  0.857  ipipe_root_only+0x14 (ipipe_test_and_stall_root+0x18)
frozen::|   #begin   0x80000001  -654+   1.428  ipipe_root_only+0xb8 (ipipe_test_and_stall_root+0x18)
frozen::|   #end     0x80000001  -653	  1.000  ipipe_root_only+0xa4 (ipipe_test_and_stall_root+0x18)
frozen::|   #begin   0x80000001  -652	  1.000  ipipe_test_and_stall_root+0x84 (rcu_idle_enter+0x18)
frozen::|   #end     0x80000001  -651	  1.000  ipipe_test_and_stall_root+0x70 (rcu_idle_enter+0x18)
frozen::    #func                -650	  1.000  rcu_eqs_enter_common.isra.47+0x14 (rcu_idle_enter+0x84)
frozen::    #func                -649	  1.000  arch_cpu_idle+0x10 (cpu_startup_entry+0x5c)
frozen::|   #begin   0x80000000  -648	  1.000  arch_cpu_idle+0xa4 (cpu_startup_entry+0x5c)
frozen::|   +func                -647! 555.142  omap_default_idle+0x10 (arch_cpu_idle+0x90)      <-- What ever is that?  That looks huge.
frozen::|   +end     0x80000000   -92+   1.142  omap_default_idle+0x40 (arch_cpu_idle+0x90)
frozen::|   +begin   0x90000000   -90	  1.000  __irq_svc+0x44 (omap_default_idle+0x44)
frozen::|   +func                 -89	  1.000  gic_handle_irq+0x10 (__irq_svc+0x58)
frozen::|   +func                 -88	  1.000  irq_find_mapping+0x14 (gic_handle_irq+0x30)
frozen::|   +func                 -87	  1.000  __ipipe_grab_irq+0x10 (gic_handle_irq+0x38)
frozen::|   +begin   0x0000001b   -86	  1.000  __ipipe_grab_irq+0x50 (gic_handle_irq+0x38)
frozen::|   +func                 -85	  1.000  __ipipe_dispatch_irq+0x14 (__ipipe_grab_irq+0x74)
frozen::|   +func                 -84	  1.000  irq_to_desc+0x10 (__ipipe_dispatch_irq+0xd4)
frozen::|   +func                 -83	  1.000  irq_to_desc+0x10 (__ipipe_dispatch_irq+0xe4)
frozen::|   +func                 -82+   1.142  __ipipe_ack_hrtimer_irq+0x10 (__ipipe_dispatch_irq+0x70)
frozen::|   +func                 -81	  0.857  __ipipe_ack_fasteoi_irq+0x10 (__ipipe_ack_hrtimer_irq+0x60)
frozen::|   +func                 -80	  0.857  gic_hold_irq+0x10 (__ipipe_ack_fasteoi_irq+0x24)
frozen::|   +func                 -80+   2.428  __ipipe_spin_lock_irqsave+0x10 (gic_hold_irq+0x34)
frozen::|   #func                 -77+   1.285  __ipipe_spin_unlock_irqrestore+0x10 (gic_hold_irq+0x98)
frozen::|   +func                 -76	  1.000  arch_itimer_ack_virt+0x10 (__ipipe_ack_hrtimer_irq+0x70)
frozen::|   +func                 -75	  0.857  __ipipe_end_fasteoi_irq+0x10 (__ipipe_ack_hrtimer_irq+0x88)
frozen::|   +func                 -74	  1.000  gic_release_irq+0x10 (__ipipe_end_fasteoi_irq+0x2c)
frozen::|   +func                 -73+   1.142  __ipipe_spin_lock_irqsave+0x10 (gic_release_irq+0x34)
frozen::|   #func                 -72+   2.000  __ipipe_spin_unlock_irqrestore+0x10 (gic_release_irq+0x74)
frozen::|  # func                 -70+   1.285  xnintr_clock_handler+0x14 [xeno_nucleus] (__ipipe_dispatch_irq+0x270)
frozen::|  # func                 -69+   3.571  __xnlock_spin+0x14 [xeno_nucleus] (xnintr_clock_handler+0x420 [xeno_nucleus])
frozen::|  # func                 -65	  1.000  xntimer_tick_aperiodic+0x14 [xeno_nucleus] (xnintr_clock_handler+0x1e0 [xeno_nucleus])
frozen::|  # func                 -64	  0.857  xntimer_next_local_shot+0x10 [xeno_nucleus] (xntimer_tick_aperiodic+0x288 [xeno_nucleus])
frozen::|  # event   tick@-50     -63	  0.857  xntimer_next_local_shot+0xb4 [xeno_nucleus] (xntimer_tick_aperiodic+0x288 [xeno_nucleus])
frozen::|  # func                 -62	  1.000  ipipe_timer_set+0x10 (xntimer_next_local_shot+0xbc [xeno_nucleus])
frozen::|  # func                 -61+   1.428  arch_timer_set_next_event_virt+0x10 (ipipe_timer_set+0x7c)
frozen::|  # func                 -60	  1.000  xnintr_host_tick+0x10 [xeno_nucleus] (xnintr_clock_handler+0x368 [xeno_nucleus])
frozen::|  # func                 -59+   1.571  __ipipe_set_irq_pending+0x10 (xnintr_host_tick+0x54 [xeno_nucleus])
frozen::|   +func                 -57+   1.428  __ipipe_do_sync_pipeline+0x14 (__ipipe_dispatch_irq+0x33c)
frozen::|   +func                 -56+   1.142  __ipipe_do_sync_stage+0x14 (__ipipe_do_sync_pipeline+0x140)
frozen::|   #end     0x80000000   -55	  1.000  __ipipe_do_sync_stage+0x294 (__ipipe_do_sync_pipeline+0x140)
frozen::    #func                 -54	  0.857  __ipipe_do_IRQ+0x10 (__ipipe_do_sync_stage+0x1e8)
frozen::    #func                 -53	  1.000  handle_IRQ+0x10 (__ipipe_do_IRQ+0x40)
frozen::    #func                 -52	  0.857  irq_enter+0x10 (handle_IRQ+0x54)
frozen::    #func                 -51	  0.857  rcu_irq_enter+0x10 (irq_enter+0x28)
frozen::    #func                 -50	  0.857  ipipe_test_and_stall_root+0x10 (rcu_irq_enter+0x18)
frozen::    #func                 -49	  1.000  ipipe_root_only+0x14 (ipipe_test_and_stall_root+0x18)
frozen::|   #begin   0x80000001   -48+   1.285  ipipe_root_only+0xb8 (ipipe_test_and_stall_root+0x18)
frozen::|   #end     0x80000001   -47+   1.142  ipipe_root_only+0xa4 (ipipe_test_and_stall_root+0x18)
frozen::|   #begin   0x90000000   -46	  0.857  __irq_svc+0x44 (ipipe_root_only+0xa8)
frozen::|   #func                 -45	  1.000  gic_handle_irq+0x10 (__irq_svc+0x58)
frozen::|   #func                 -44	  0.857  irq_find_mapping+0x14 (gic_handle_irq+0x30)
frozen::|   #func                 -43+   1.142  __ipipe_grab_irq+0x10 (gic_handle_irq+0x38)
frozen::|   #begin   0x0000001b   -42	  0.857  __ipipe_grab_irq+0x50 (gic_handle_irq+0x38)
frozen::|   #func                 -41	  1.000  __ipipe_dispatch_irq+0x14 (__ipipe_grab_irq+0x74)
frozen::|   #func                 -40	  1.000  irq_to_desc+0x10 (__ipipe_dispatch_irq+0xd4)
frozen::|   #func                 -39	  1.000  irq_to_desc+0x10 (__ipipe_dispatch_irq+0xe4)
frozen::|   #func                 -38	  0.857  __ipipe_ack_hrtimer_irq+0x10 (__ipipe_dispatch_irq+0x70)
frozen::|   #func                 -37	  1.000  __ipipe_ack_fasteoi_irq+0x10 (__ipipe_ack_hrtimer_irq+0x60)
frozen::|   #func                 -36	  0.857  gic_hold_irq+0x10 (__ipipe_ack_fasteoi_irq+0x24)
frozen::|   #func                 -35+   1.142  __ipipe_spin_lock_irqsave+0x10 (gic_hold_irq+0x34)
frozen::|   #func                 -34+   1.142  __ipipe_spin_unlock_irqrestore+0x10 (gic_hold_irq+0x98)
frozen::|   #func                 -33	  0.857  arch_itimer_ack_virt+0x10 (__ipipe_ack_hrtimer_irq+0x70)
frozen::|   #func                 -32	  1.000  __ipipe_end_fasteoi_irq+0x10 (__ipipe_ack_hrtimer_irq+0x88)
frozen::|   #func                 -31	  0.714  gic_release_irq+0x10 (__ipipe_end_fasteoi_irq+0x2c)
frozen::|   #func                 -31+   1.285  __ipipe_spin_lock_irqsave+0x10 (gic_release_irq+0x34)
frozen::|   #func                 -29+   1.857  __ipipe_spin_unlock_irqrestore+0x10 (gic_release_irq+0x74)
frozen::|  #*func                 -27+   1.142  xnintr_clock_handler+0x14 [xeno_nucleus] (__ipipe_dispatch_irq+0x270)
frozen::|  #*func                 -26	  0.857  xntimer_tick_aperiodic+0x14 [xeno_nucleus] (xnintr_clock_handler+0x1e0 [xeno_nucleus])
frozen::|  #*func                 -25	  0.857  xnthread_timeout_handler+0x10 [xeno_nucleus] (xntimer_tick_aperiodic+0x13c [xeno_nucleus])
frozen::|  #*func                 -25	  1.000  xnpod_resume_thread+0x14 [xeno_nucleus] (xnthread_timeout_handler+0x34 [xeno_nucleus])
frozen::|  #*[ 5197] MAC Poll 0   -24+   1.285  xnpod_resume_thread+0x124 [xeno_nucleus] (xnthread_timeout_handler+0x34 [xeno_nucleus])
frozen::|  #*func                 -22	  0.857  xntimer_next_local_shot+0x10 [xeno_nucleus] (xntimer_tick_aperiodic+0x288 [xeno_nucleus])
frozen::|  #*event   tick@11992   -21	  0.857  xntimer_next_local_shot+0xb4 [xeno_nucleus] (xntimer_tick_aperiodic+0x288 [xeno_nucleus])
frozen::|  #*func                 -21	  1.000  ipipe_timer_set+0x10 (xntimer_next_local_shot+0xbc [xeno_nucleus])
frozen::|  #*func                 -20+   1.142  arch_timer_set_next_event_virt+0x10 (ipipe_timer_set+0x7c)
frozen::|  #*func                 -18+   1.428  __xnpod_schedule+0x14 [xeno_nucleus] (xnintr_clock_handler+0x408 [xeno_nucleus])
frozen::|  #*[    0] -<?>-   -1   -17	  1.000  __xnpod_schedule+0x194 [xeno_nucleus] (xnintr_clock_handler+0x408 [xeno_nucleus])
frozen::|  #*func                 -16	  1.000  xnsched_pick_next+0x10 [xeno_nucleus] (__xnpod_schedule+0x328 [xeno_nucleus])
frozen::|  #*func                 -15	  0.857  omap4_mute_pic+0x10 (__xnpod_schedule+0x714 [xeno_nucleus])
frozen::|  #*func                 -14+   1.142  gic_mute+0x10 (omap4_mute_pic+0x1c)
frozen::|  #*func                 -13+   2.000  _get_gpio_irqbank_mask+0x10 (omap4_mute_pic+0x58)
frozen::|  #*[ 5197] MAC Poll 0   -11+   1.428  __xnpod_schedule+0x604 [xeno_nucleus] (xnpod_suspend_thread+0x494 [xeno_nucleus])
frozen::|  #*func                 -10+   1.142  __ipipe_restore_head+0x10 (xnpod_suspend_thread+0x1c4 [xeno_nucleus])
frozen::|  +*end     0x80000000    -8	  1.000  __ipipe_restore_head+0xd8 (xnpod_suspend_thread+0x1c4 [xeno_nucleus])
frozen::|  +*begin   0x90000000    -7	  1.000  __irq_svc+0x44 (__ipipe_restore_head+0xdc)
frozen::|  +*func                  -6	  0.857  gic_handle_irq+0x10 (__irq_svc+0x58)
frozen::|  +*func                  -6	  1.000  irq_find_mapping+0x14 (gic_handle_irq+0x30)
frozen::|  +*func                  -5	  0.857  __ipipe_grab_irq+0x10 (gic_handle_irq+0x38)
frozen::|  +*begin   0x00000043    -4	  1.000  __ipipe_grab_irq+0x50 (gic_handle_irq+0x38)
frozen::|  +*func                  -3	  0.857  __ipipe_dispatch_irq+0x14 (__ipipe_grab_irq+0x74)
frozen::|  +*func                  -2	  1.000  irq_to_desc+0x10 (__ipipe_dispatch_irq+0xd4)
frozen::|  +*func                  -1+   1.285  irq_to_desc+0x10 (__ipipe_dispatch_irq+0xe4)
frozen:<|  +*func                   0	  1.142  gpio_irq_handler+0x14 (__ipipe_dispatch_irq+0x70)
frozen: |  +*func                   1	  1.571  irq_to_desc+0x10 (gpio_irq_handler+0x38)
frozen: |  +*func                   2	  1.000  irq_find_mapping+0x14 (gpio_irq_handler+0x190)
frozen: |  +*begin   0x0000018e     3	  0.857  gpio_irq_handler+0x198 (__ipipe_dispatch_irq+0x70)
frozen: |  +*func                   4	  0.857  __ipipe_dispatch_irq+0x14 (gpio_irq_handler+0x1a4)
frozen: |  +*func                   5	  1.000  irq_to_desc+0x10 (__ipipe_dispatch_irq+0xd4)
frozen: |  +*func                   6	  1.142  irq_to_desc+0x10 (__ipipe_dispatch_irq+0xe4)
frozen: |  +*func                   7	  1.142  __ipipe_ack_level_irq+0x10 (__ipipe_dispatch_irq+0x70)
frozen: |  +*func                   8	  0.857  gpio_mask_ack_irq+0x10 (__ipipe_ack_level_irq+0x30)
frozen: |  +*func                   9	  3.428  __ipipe_spin_lock_irqsave+0x10 (gpio_mask_ack_irq+0x30)
frozen: |  #*func                  13	  0.000  __ipipe_spin_unlock_irqrestore+0x10 (gpio_mask_ack_irq+0x210)
max:I-pipe worst-case tracing service on 3.12-1-am5726/ipipe release #2
max:-------------------------------------------------------------
max:CPU: 0, Begin: 1137045851 cycles, Trace Points: 3 (-10/+1), Length: 617 us
max:Calibrated minimum trace-point overhead: 0.428 us
max: +----- Hard IRQs ('|': locked)
max: |+-- Xenomai
max: ||+- Linux ('*': domain stalled, '+': current, '#': current+stalled)
max: |||			  +---------- Delay flag ('+': > 1 us, '!': > 10 us)
max: |||			  |	   +- NMI noise ('N')
max: |||			  |	   |
max:	  Type	  User Val.   Time    Delay  Function (Parent)
max:     #func                 -10	  1.000  tick_check_broadcast_expired+0x10 (cpu_startup_entry+0x40)
max:     #func                  -9	  0.857  rcu_idle_enter+0x10 (cpu_startup_entry+0x58)
max:     #func                  -8	  0.857  ipipe_test_and_stall_root+0x10 (rcu_idle_enter+0x18)
max:     #func                  -7	  1.000  ipipe_root_only+0x14 (ipipe_test_and_stall_root+0x18)
max: |   #begin   0x80000001    -6	  1.285  ipipe_root_only+0xb8 (ipipe_test_and_stall_root+0x18)
max: |   #end     0x80000001    -5	  1.000  ipipe_root_only+0xa4 (ipipe_test_and_stall_root+0x18)
max: |   #begin   0x80000001    -4	  1.142  ipipe_test_and_stall_root+0x84 (rcu_idle_enter+0x18)
max: |   #end     0x80000001    -3	  1.000  ipipe_test_and_stall_root+0x70 (rcu_idle_enter+0x18)
max:     #func                  -2	  1.000  rcu_eqs_enter_common.isra.47+0x14 (rcu_idle_enter+0x84)
max:     #func                  -1	  1.000  arch_cpu_idle+0x10 (cpu_startup_entry+0x5c)
max:>|   #begin   0x80000000     0	  1.000  arch_cpu_idle+0xa4 (cpu_startup_entry+0x5c)
max::|   +func                   1! 616.428  omap_default_idle+0x10 (arch_cpu_idle+0x90)
max:<|   +end     0x80000000   617	  1.142  omap_default_idle+0x40 (arch_cpu_idle+0x90)
max: |   +begin   0x90000000   618	  0.000  __irq_svc+0x44 (omap_default_idle+0x44)
post_trace_points:10
pre_trace_points:10
trigger:gpio_irq_handler+0x0/0x298
verbose:1

-- 
Len Sorensen

