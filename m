MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <18353.17667.156910.185055@domain.hid>
Date: Tue, 12 Feb 2008 08:04:35 +0100
In-Reply-To: <47B050A4.4060409@domain.hid>
References: <20080123065221.GB6573@domain.hid>
	<2ff1a98a0801230204s15e4eefaifdd2c946c44549df@domain.hid>
	<2ff1a98a0801230515i77f8c22bk866c4cd592a3a9b8@domain.hid>
	<20080124094150.GA7503@domain.hid>
	<18351.24380.551907.397687@domain.hid>
	<47B050A4.4060409@domain.hid>
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Subject: Re: [Xenomai-core] [Xenomai-help] AT91SAM9260 latency
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: jagarcia@domain.hid, xenomai@xenomai.org

Jan Kiszka wrote:
 > Gilles Chanteperdrix wrote:
 > > I-pipe frozen back-tracing service on 2.6.20/ipipe-1.8-04
 > > ------------------------------------------------------------
 > > CPU: 0, Freeze: 450692973 cycles, Trace Points: 1000 (+10)
 > > Calibrated minimum trace-point overhead: 1.000 us
 > 
 > That is interesting. I tells us that we might subtract 1 us
 > _per_tracepoint_ from the given latencies due to the inherent tracer
 > overhead. We have about 50 entries in the critical path, so 50 us
 > compared to 220 us that were measured - roughly 170 us real latency.
 > 
 > What is the clock resolution btw? 500 ns?
 > 
 > So here is the interesting block, starting with the last larger IRQs-on
 > window.
 > 
 > > :   + func                -447+   2.500  xnshadow_relax+0x14 (hisyscall_event+0x210)
 > > :|  + begin   0x80000000  -445+   3.000  xnshadow_relax+0xd4 (hisyscall_event+0x210)
 > > :|  # func                -442+   5.000  schedule_linux_call+0x10 (xnshadow_relax+0x114)
 > > :|  # func                -437+   4.000  rthal_apc_schedule+0x10 (schedule_linux_call+0x1e8)
 > > :|  # func                -433+   5.000  __ipipe_schedule_irq+0x10 (rthal_apc_schedule+0xac)
 > > :|  # func                -428+   4.500  __ipipe_set_irq_pending+0x10 (__ipipe_schedule_irq+0xa4)
 > > :|  # func                -423+   3.500  rpi_push+0x14 (xnshadow_relax+0x11c)
 > > :|  # func                -420+   5.500  xnpod_suspend_thread+0x14 (xnshadow_relax+0x148)
 > > :|  # func                -414+   4.000  xnpod_schedule+0x14 (xnpod_suspend_thread+0x60c)
 > > :|  # [  752] -<?>-    0  -410+   7.000  xnpod_schedule+0xc8 (xnpod_suspend_thread+0x60c)
 > > :|  # func                -403!  56.000  xnheap_finalize_free_inner+0x10 (xnpod_schedule+0x82c)

Ok, we get a cache flush here

 > > :|  # [    0] -<?>-   -1  -347!  20.000  xnpod_schedule+0xb14 (xnintr_clock_handler+0xa0)
 > > :|   +func                -327+   3.000  __ipipe_walk_pipeline+0x10 (__ipipe_handle_irq+0x124)
 > > :|   +func                -324+   7.500  __ipipe_sync_stage+0x14 (__ipipe_walk_pipeline+0xa8)
 > > :|   #end     0x80000000  -317+   7.000  __ipipe_sync_stage+0x250 (__ipipe_walk_pipeline+0xa8)
 > 
 > OK, the clock starts ticking...
 > 
 > > :|   #func                -310+   2.500  __ipipe_grab_irq+0x10 (__irq_svc+0x28)
 > > :|   #begin   0xffffffff  -307+   7.000  __ipipe_grab_irq+0x20 (__irq_svc+0x28)
 > > :|   #(0x2a)  0x00000012  -300+   5.000  __ipipe_grab_irq+0x2c (__irq_svc+0x28)
 > > :|   #func                -295+   4.000  __ipipe_handle_irq+0x10 (__ipipe_grab_irq+0x104)
 > > :|   #func                -291+   2.500  __ipipe_ack_timerirq+0x10 (__ipipe_handle_irq+0x74)
 > > :|   #func                -289+   3.000  __ipipe_ack_level_irq+0x10 (__ipipe_ack_timerirq+0x30)
 > > :|   #func                -286+   2.000  at91_aic_mask_irq+0x10 (__ipipe_ack_level_irq+0x3c)
 > > :|   #func                -284+   2.000  at91_aic_mask_irq+0x10 (__ipipe_ack_level_irq+0x4c)
 > 
 > (Without looking at the arm code: Is this double invocation of
 > at91_aic_mask_irq correct and required?)
 > 
 > > :|   #func                -282+   4.000  __ipipe_mach_acktimer+0x10 (__ipipe_ack_timerirq+0x40)
 > > :|   #func                -278+   2.000  __ipipe_end_level_irq+0x10 (__ipipe_ack_timerirq+0x50)
 > > :|   #func                -276+   2.500  at91_aic_unmask_irq+0x10 (__ipipe_end_level_irq+0x28)
 > > :|   #func                -273+   3.500  __ipipe_dispatch_wired+0x14 (__ipipe_handle_irq+0x80)
 > > :|  #*func                -270+   3.500  xnintr_clock_handler+0x10 (__ipipe_dispatch_wired+0xe4)
 > > :|  #*func                -266+   9.500  xntimer_tick_aperiodic+0x14 (xnintr_clock_handler+0x34)
 > > :|  #*func                -257+   3.500  xnthread_periodic_handler+0x10 (xntimer_tick_aperiodic+0x354)
 > > :|  #*func                -253+   4.000  xnpod_resume_thread+0x14 (xnthread_periodic_handler+0x34)
 > > :|  #*[  753] -<?>-   99  -249!  15.000  xnpod_resume_thread+0x84 (xnthread_periodic_handler+0x34)
 > 
 > Hmm, comparably costly, this simple resume. Hope it's not the
 > instrumentation (ipipe_trace_pid?) itself.
 > 
 > > :|  #*func                -234+   6.500  xntimer_next_local_shot+0x10 (xntimer_tick_aperiodic+0x7c0)
 > > :|  #*func                -228+   4.000  __ipipe_mach_set_dec+0x10 (xntimer_next_local_shot+0xbc)
 > > :|  #*func                -224+   3.500  xnpod_schedule+0x14 (xnintr_clock_handler+0xa0)
 > > :|  #*[    0] -<?>-   -1  -220!  59.500  xnpod_schedule+0xc8 (xnintr_clock_handler+0xa0)
 > 
 > OK, this is the cache flushing thing, I guess. Expected.

And another here, whereas if I understand correctly, the mm did not
change. So, this is probably an unwanted effect of the cache flush
"optimization" in the arm patch.

I will now try to understand if this second cache flush is really normal.

-- 


					    Gilles Chanteperdrix.

