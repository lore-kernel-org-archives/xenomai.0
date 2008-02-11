Message-ID: <47B081C8.60409@domain.hid>
Date: Mon, 11 Feb 2008 18:11:36 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <20080123065221.GB6573@domain.hid>	
	<2ff1a98a0801230204s15e4eefaifdd2c946c44549df@domain.hid>	
	<2ff1a98a0801230515i77f8c22bk866c4cd592a3a9b8@domain.hid>	
	<20080124094150.GA7503@domain.hid>	
	<18351.24380.551907.397687@domain.hid>	
	<47B050A4.4060409@domain.hid>
	<2ff1a98a0802110605l416bc82bpdd4a7f2e6e92a342@domain.hid>
In-Reply-To: <2ff1a98a0802110605l416bc82bpdd4a7f2e6e92a342@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
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
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: jagarcia@domain.hid, xenomai@xenomai.org

Gilles Chanteperdrix wrote:
> On Mon, Feb 11, 2008 at 2:41 PM, Jan Kiszka <jan.kiszka@domain.hid> wrote:
>> Gilles Chanteperdrix wrote:
>>  > Juan Antonio Garcia Redondo wrote:
>>  >  > On 23/01/08 14:15, Gilles Chanteperdrix wrote:
>>  >  > > On Jan 23, 2008 11:04 AM, Gilles Chanteperdrix
>>  >  > > <gilles.chanteperdrix@xenomai.org> wrote:
>>  >  > > > On Jan 23, 2008 7:52 AM, Juan Antonio Garcia Redondo
>>  >  > > >
>>  >  > > > <juan-antonio.garcia@domain.hid> wrote:
>>  >  > > > > I see everything OK except for the first samples of cyclictests. Any comments ?
>>  >  > > >
>>  >  > > > The load you apply does not load the cache, which is a source of
>>  >  > > > jitter. You should run the cache calibrator (I do not find the cache
>>  >  > > > calibrator URL, but it is somewhere in Xenomai distribution or wiki).
>>  >  > >
>>  >  > > It is in the TROUBLESHOOTING guide, question "How do I adequately stress test".
>>  >  > >
>>  >  > > --
>>  >  > >                                                Gilles Chanteperdrix
>>  >  >
>>  >  > Thanks Gilles, I've done more tests using the cache calibrator from
>>  >  > http://www.cwi.nl/~manegold/Calibrator. The latency numbers are very
>>  >  > similar althought I've found an strange behaviour related to telnet
>>  >  > sessions.
>>  >  >
>>  >  > Environment:
>>  >  >    o Tests running from console over atmel serial port.
>>  >  >    o A telnet session over on-chip ethernet.
>>  >  >         o System without load.
>>  >  >
>>  >  > ./latency -p 500 -t0
>>  >  > == All results in microseconds
>>  >  > warming up...
>>  >  > RTT|  00:00:01  (periodic user-mode task, 500 us period, priority 99)
>>  >  > RTH|-RTH----lat min|-----lat avg|-----lat max|-overrun|----lat best|---lat
>>  >  > worst
>>  >  > RTD|      49.613|      52.190|      62.822|       0|      49.613| 62.822
>>  >  > RTD|      42.203|      52.512|      66.365|       0|      42.203| 66.365
>>  >  >
>>  >  >
>>  >  > Now If hit a key on the telnet session :
>>  >  >
>>  >  > RTD|      36.726|      57.989|     109.536|       0|      31.572| 109.536  <-------- Here I've hit the key.
>>  >  > RTD|      36.404|      51.868|      69.587|       0|      31.572| 109.536
>>  >  > RTD|      35.760|      51.868|      73.775|       0|      31.572| 109.536
>>  >  >
>>  >  > Now, I launch an script which executes four instances of cache
>>  >  > calibrator.
>>  >  >
>>  >  > RTD|      45.103|      57.667|      75.708|       0|      32.538| 122.422
>>  >  > RTD|      45.425|      57.023|      76.030|       0|      32.538| 122.422
>>  >  > RTD|      46.069|      57.023|      75.708|       0|      32.538| 122.422
>>  >  >
>>  >  > Now, I can hit a key on the telnet session without effects over latency
>>  >  > numbers:
>>  >  >
>>  >  > RTD|      44.136|      57.989|      75.386|       0|      27.384| 128.221
>>  >  > RTD|      46.713|      57.345|      76.353|       0|      27.384| 128.221
>>  >  > RTD|      44.780|      57.345|      76.675|       0|      27.384| 128.221
>>  >  > RTD|      43.492|      56.701|      76.997|       0|      27.384| 128.221
>>  >  >
>>  >  > Now I stop the calibrator process and launch 'ping -f -s2048 192.168.2.82' from an external
>>  >  > machine.
>>  >  >
>>  >  > RTD|      40.270|      68.621|      90.850|       0|      27.384| 128.221
>>  >  > RTD|      36.082|      68.621|      88.273|       0|      27.384| 128.221
>>  >  > RTD|      40.592|      67.976|      91.494|       0|      27.384| 128.221
>>  >  > RTD|      41.237|      68.298|      89.239|       0|      27.384| 128.221
>>  >  >
>>  >  >
>>  >  > Now If hit a key on the telnet session :
>>  >  >
>>  >  > RTD|      42.203|      67.976|      88.273|       0|      27.384| 128.221
>>  >  > RTD|      32.216|      93.427|     128.543|       0|      27.384| 128.543 <---------- Here I've hit the key.
>>  >  > RTD|      42.203|      68.298|      87.628|       0|      27.384| 128.543
>>  >  >
>>  >  > And again the calibrator execution results on eliminate the strange
>>  >  > behaviour whith the telnet session.
>>  >  >
>>  >  > Any clues ?
>>  >
>>  > Here is an update, follow-up on xenomai-core. I was finally able to
>>  > reproduce this behaviour: I run latency in the background and hit the
>>  > "Enter" key on my serial console, and get high latency figures.
>>  >
>>  > I enabled the tracer, set xenomai latency to 300us and managed to get a
>>  > trace (220us latency). However, I do not understand what is going wrong
>>  > from reading the trace, so I post it here in case someone sees something.
>>  >
>>  > Ah, and I added an ipipe_trace_special in ipipe_grab_irq to log the
>>  > number of the received irq. 1 is serial interrupt 18 (0x12) is timer
>>  > interrupt.
>>  >
>>  > Inline, so that Jan can comment it.
>>
>>  Thanks, but TB is too "smart" - it cuts off everything that is marked as
>>  footer ("--"). :-/
>>
>>
>>  > I-pipe frozen back-tracing service on 2.6.20/ipipe-1.8-04
>>  > ------------------------------------------------------------
>>  > CPU: 0, Freeze: 450692973 cycles, Trace Points: 1000 (+10)
>>  > Calibrated minimum trace-point overhead: 1.000 us
>>
>>  That is interesting. I tells us that we might subtract 1 us
>>  _per_tracepoint_ from the given latencies due to the inherent tracer
>>  overhead. We have about 50 entries in the critical path, so 50 us
>>  compared to 220 us that were measured - roughly 170 us real latency.
>>
>>  What is the clock resolution btw? 500 ns?
> 
> It should be around 1us. A bit less. I think the frequency is 92 MHz /
> 64. Anyway, I checked once and the I-pipe rounding is really
> approximative, it is equivalent to rounding frequency to 2 MHz.
> 
>>  So here is the interesting block, starting with the last larger IRQs-on
>>  window.
>>
>>
>>  > :   + func                -447+   2.500  xnshadow_relax+0x14 (hisyscall_event+0x210)
>>  > :|  + begin   0x80000000  -445+   3.000  xnshadow_relax+0xd4 (hisyscall_event+0x210)
>>  > :|  # func                -442+   5.000  schedule_linux_call+0x10 (xnshadow_relax+0x114)
>>  > :|  # func                -437+   4.000  rthal_apc_schedule+0x10 (schedule_linux_call+0x1e8)
>>  > :|  # func                -433+   5.000  __ipipe_schedule_irq+0x10 (rthal_apc_schedule+0xac)
>>  > :|  # func                -428+   4.500  __ipipe_set_irq_pending+0x10 (__ipipe_schedule_irq+0xa4)
>>  > :|  # func                -423+   3.500  rpi_push+0x14 (xnshadow_relax+0x11c)
>>  > :|  # func                -420+   5.500  xnpod_suspend_thread+0x14 (xnshadow_relax+0x148)
>>  > :|  # func                -414+   4.000  xnpod_schedule+0x14 (xnpod_suspend_thread+0x60c)
>>  > :|  # [  752] -<?>-    0  -410+   7.000  xnpod_schedule+0xc8 (xnpod_suspend_thread+0x60c)
>>  > :|  # func                -403!  56.000  xnheap_finalize_free_inner+0x10 (xnpod_schedule+0x82c)
>>  > :|  # [    0] -<?>-   -1  -347!  20.000  xnpod_schedule+0xb14 (xnintr_clock_handler+0xa0)
>>  > :|   +func                -327+   3.000  __ipipe_walk_pipeline+0x10 (__ipipe_handle_irq+0x124)
>>  > :|   +func                -324+   7.500  __ipipe_sync_stage+0x14 (__ipipe_walk_pipeline+0xa8)
>>  > :|   #end     0x80000000  -317+   7.000  __ipipe_sync_stage+0x250 (__ipipe_walk_pipeline+0xa8)
>>
>>  OK, the clock starts ticking...
>>
>>
>>  > :|   #func                -310+   2.500  __ipipe_grab_irq+0x10 (__irq_svc+0x28)
>>  > :|   #begin   0xffffffff  -307+   7.000  __ipipe_grab_irq+0x20 (__irq_svc+0x28)
>>  > :|   #(0x2a)  0x00000012  -300+   5.000  __ipipe_grab_irq+0x2c (__irq_svc+0x28)
>>  > :|   #func                -295+   4.000  __ipipe_handle_irq+0x10 (__ipipe_grab_irq+0x104)
>>  > :|   #func                -291+   2.500  __ipipe_ack_timerirq+0x10 (__ipipe_handle_irq+0x74)
>>  > :|   #func                -289+   3.000  __ipipe_ack_level_irq+0x10 (__ipipe_ack_timerirq+0x30)
>>  > :|   #func                -286+   2.000  at91_aic_mask_irq+0x10 (__ipipe_ack_level_irq+0x3c)
>>  > :|   #func                -284+   2.000  at91_aic_mask_irq+0x10 (__ipipe_ack_level_irq+0x4c)
>>
>>  (Without looking at the arm code: Is this double invocation of
>>  at91_aic_mask_irq correct and required?)
> 
> No, and I do not see where it is coming from.
> 
>>
>>  > :|   #func                -282+   4.000  __ipipe_mach_acktimer+0x10 (__ipipe_ack_timerirq+0x40)
>>  > :|   #func                -278+   2.000  __ipipe_end_level_irq+0x10 (__ipipe_ack_timerirq+0x50)
>>  > :|   #func                -276+   2.500  at91_aic_unmask_irq+0x10 (__ipipe_end_level_irq+0x28)
>>  > :|   #func                -273+   3.500  __ipipe_dispatch_wired+0x14 (__ipipe_handle_irq+0x80)
>>  > :|  #*func                -270+   3.500  xnintr_clock_handler+0x10 (__ipipe_dispatch_wired+0xe4)
>>  > :|  #*func                -266+   9.500  xntimer_tick_aperiodic+0x14 (xnintr_clock_handler+0x34)
>>  > :|  #*func                -257+   3.500  xnthread_periodic_handler+0x10 (xntimer_tick_aperiodic+0x354)
>>  > :|  #*func                -253+   4.000  xnpod_resume_thread+0x14 (xnthread_periodic_handler+0x34)
>>  > :|  #*[  753] -<?>-   99  -249!  15.000  xnpod_resume_thread+0x84 (xnthread_periodic_handler+0x34)
>>
>>  Hmm, comparably costly, this simple resume. Hope it's not the
>>  instrumentation (ipipe_trace_pid?) itself.
>>
>>
>>  > :|  #*func                -234+   6.500  xntimer_next_local_shot+0x10 (xntimer_tick_aperiodic+0x7c0)
>>  > :|  #*func                -228+   4.000  __ipipe_mach_set_dec+0x10 (xntimer_next_local_shot+0xbc)
>>  > :|  #*func                -224+   3.500  xnpod_schedule+0x14 (xnintr_clock_handler+0xa0)
>>  > :|  #*[    0] -<?>-   -1  -220!  59.500  xnpod_schedule+0xc8 (xnintr_clock_handler+0xa0)
>>
>>  OK, this is the cache flushing thing, I guess. Expected.
> 
> Yes, I took care of disabling the (still recent) irqs unmasking in
> xnpod_schedule. So, we see the cache flushing with irqs disabled.
> 
>>
>>  > :|  #*[  753] -<?>-   99  -161!  17.500  xnpod_schedule+0xb14 (xnpod_suspend_thread+0x60c)
>>
>>  Again this peak. Strange.
>>
>>
>>  > :|  #*func                -143+   4.000  xntimer_get_overruns+0x14 (xnpod_wait_thread_period+0xe0)
>>  > :|  #*func                -139+   4.000  __ipipe_restore_pipeline_head+0x10 (xnpod_wait_thread_period+0x114)
>>  > :|  +*end     0x80000000  -135+   7.000  __ipipe_restore_pipeline_head+0x11c (xnpod_wait_thread_period+0x114)
>>
>>  So we woke up the thread and are on the way back to userland. But then
>>  the serial IRQ hits us...
>>
>>
>>  > :|  +*func                -128+   3.000  __ipipe_grab_irq+0x10 (__irq_svc+0x28)
>>  > :|  +*begin   0xffffffff  -125+   7.000  __ipipe_grab_irq+0x20 (__irq_svc+0x28)
>>  > :|  +*(0x2a)  0x00000001  -118+   4.000  __ipipe_grab_irq+0x2c (__irq_svc+0x28)
>>  > :|  +*func                -114+   5.000  __ipipe_handle_irq+0x10 (__ipipe_grab_irq+0x104)
>>  > :|  +*func                -109+   4.500  __ipipe_set_irq_pending+0x10 (__ipipe_handle_irq+0xdc)
>>  > :|  +*func                -105+   2.000  __ipipe_ack_irq+0x10 (__ipipe_handle_irq+0xfc)
>>  > :|  +*func                -103+   3.000  __ipipe_ack_level_irq+0x10 (__ipipe_ack_irq+0x28)
>>  > :|  +*func                -100+   2.500  at91_aic_mask_irq+0x10 (__ipipe_ack_level_irq+0x3c)
>>  > :|  +*func                 -97+   2.500  at91_aic_mask_irq+0x10 (__ipipe_ack_level_irq+0x4c)
>>  > :|  +*func                 -95+   3.000  __ipipe_walk_pipeline+0x10 (__ipipe_handle_irq+0x124)
>>
>>  Serial done, the above 30 us (minus tracer overhead) are unavoidable.
>>
>>
>>  > :|  +*end     0xffffffff   -92!  10.500  __ipipe_grab_irq+0x110 (__irq_svc+0x28)
>>  > :|  +*begin   0x80000001   -81+   4.000  __ipipe_dispatch_event+0x108 (__ipipe_syscall_root+0x84)
>>
>>  This is the syscall epilogue related to wait_thread_period.
> 
> Is it normal to see the hw irqs disabled here ?

They were likely only disabled at the instrumentation point, but were
enabled shortly afterwards - just to be disabled again.

> 
>>
>>  > :|  +*end     0x80000001   -77!  39.500  __ipipe_dispatch_event+0x1cc (__ipipe_syscall_root+0x84)
>>  > :   +*func                 -38+   2.500  __ipipe_syscall_root+0x10 (vector_swi+0x68)
>>
>>  After doing some latency calculation in user land, we are back to freeze
>>  the trace now.
>>
>>
>>  > :   +*func                 -35+   2.000  __ipipe_dispatch_event+0x14 (__ipipe_syscall_root+0x84)
>>  > :|  +*begin   0x80000001   -33+   4.000  __ipipe_dispatch_event+0x40 (__ipipe_syscall_root+0x84)
>>  > :|  +*end     0x80000001   -29+   2.000  __ipipe_dispatch_event+0xc8 (__ipipe_syscall_root+0x84)
>>  > :   +*func                 -27+   6.500  hisyscall_event+0x14 (__ipipe_dispatch_event+0xe0)
>>  > :   +*func                 -21+   2.500  xnshadow_sys_trace+0x10 (hisyscall_event+0x150)
>>  > :   +*func                 -18+   2.000  ipipe_trace_frozen_reset+0x10 (xnshadow_sys_trace+0x98)
>>  > :   +*func                 -16+   2.000  __ipipe_global_path_lock+0x10 (ipipe_trace_frozen_reset+0x14)
>>  > :   +*func                 -14+   2.000  __ipipe_spin_lock_irqsave+0x10 (__ipipe_global_path_lock+0x18)
>>  > :|  +*begin   0x80000001   -12+   8.000  __ipipe_spin_lock_irqsave+0x34 (__ipipe_global_path_lock+0x18)
>>  > :|  #*func                  -4+   2.500  __ipipe_spin_unlock_irqcomplete+0x10 (__ipipe_global_path_unlock+0x6c)
>>  > :|  +*end     0x80000001    -2+   2.000  __ipipe_spin_unlock_irqcomplete+0x4c (__ipipe_global_path_unlock+0x6c)
>>  > <   +*freeze  0x00035ea1     0    2.500  xnshadow_sys_trace+0xa4 (hisyscall_event+0x150)
>>
>>  So, all in all, nothing fishy, at least here. Any IRQ (actually even
>>  multiple!) can hit us between wakeup and latency calculation, and this
>>  happened here due to sending some characters over the serial console.
>>  Plus we see the cache flushing overhead when switching processes, also
>>  normal.
> 
> The problem is that the nucleus latency is calibrated to 300 us (which
> is very high), and that we get a 220us latency, which means that it
> took 500us going from the timer interrupt to the xntrace syscall.

There is a shadow relax procedure running before the timer IRQ fires,
and that takes another context switch. So the latency sum is:

 - unrelated context switch
 - timer IRQ
 - switch to woken up RT process
 - serial IRQ

Almost the theoretical worst case.

Jan

-- 
Siemens AG, Corporate Technology, CT SE 2
Corporate Competence Center Embedded Linux

