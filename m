Date: Fri, 14 Nov 2014 11:20:57 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20141114102057.GD4656@sisyphus.hd.free.fr>
References: <54631EB1.1050900@sigmatek.at>
 <20141112164411.GB17476@sisyphus.hd.free.fr>
 <5464DCAA.6060004@sigmatek.at>
 <20141113163300.GM4656@sisyphus.hd.free.fr>
 <5465D11B.1060808@sigmatek.at>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5465D11B.1060808@sigmatek.at>
Subject: Re: [Xenomai] rtdm_nrtsig_pend FAQ
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Johann Obermayr <johann.obermayr@sigmatek.at>
Cc: "Xenomai@xenomai.org" <Xenomai@xenomai.org>

On Fri, Nov 14, 2014 at 10:53:31AM +0100, Johann Obermayr wrote:
> Am 13.11.2014 um 17:33 schrieb Gilles Chanteperdrix:
> >On Thu, Nov 13, 2014 at 05:30:34PM +0100, Johann Obermayr wrote:
> >>Am 12.11.2014 um 17:44 schrieb Gilles Chanteperdrix:
> >>>On Wed, Nov 12, 2014 at 09:47:45AM +0100, Johann Obermayr wrote:
> >>>>Hello,
> >>>>
> >>>>we use rtdm_nrtsig_pend follow.
> >>>>
> >>>>static rtdm_nrtsig_t wait_domain_nrt;
> >>>>static DECLARE_WAIT_QUEUE_HEAD(wait_domain_wq);
> >>>>
> >>>>void period_update()
> >>>>{
> >>>>         wait_domain_pend_count++;
> >>>>         rtdm_nrtsig_pend(&wait_domain_nrt);
> >>>>}
> >>>>
> >>>>static void wait_domain_nrt_handler(rtdm_nrtsig_t nrt_sig, void *arg)
> >>>>{
> >>>>     wait_domain_call_count++;
> >>>>     //wakeup wait_domain
> >>>>     wait_domain_wakeup = 1;
> >>>>     wake_up_interruptible(&wait_domain_wq);
> >>>>}
> >>>>
> >>>>
> >>>>period_update is called every millisecond.
> >>>>this is on imx6 hardware with kernel 3.0.x and xenomai 2.6.2.1.
> >>>>From what Thierry said, I suspect the patch for this kernel has a
> >>>missing call to irq_exit. So, I would ask you to do the same as
> >>>Thierry, please enable the I-pipe tracer, set a sufficient number of
> >>>back trace points such as 10000, and trigger a trace when you detect
> >>>that you have "lost" a notification (wait_dommain_pend_count > wait_domain_call_count + 1)
> >>>
> >>>Then send the trace to the mailing list.
> >>>
> >>Hi,
> >>
> >>witch function i must use to make a i-pipe trace ?
> >>here i am in a xenomai irq handle
> >>
> >>void period_update()
> >>{
> >>     ......
> >>     else if (wait_domain_pend_count > 100000 &&
> >>wait_domain_pend_count != wait_domain_call_count) {
> >>             // dotrace
> >>
> >>      }
> >>}
> >ipipe_trace_freeze. Requires a numeric argument, which has no
> >particular meaning, it just gets printed in the trace.
> >
> >The I-pipe tracer is documented here:
> >http://xenomai.org/2014/06/using-the-i-pipe-tracer/
> >
> Hello,
> 
> here is the trace

Your trace show several things: 
- period_update in your program does not correspond to the sources
you showed:

:   +*func                -759    0.500  period_update+0x10 [sigmatek_lrt] (timer+0xb0 [sigmatek_lrt])
:   +*func                -759    1.000  lrtdrv_monitoring_start_timed+0x10 [sigmatek_lrt] (period_update+0x34 [sigmatek_lrt])
:   +*func                -758    0.750  rtdm_event_signal+0x10 (period_update+0x180 [sigmatek_lrt])
:|  #*func                -757    0.500  xnsynch_flush+0x10 (rtdm_event_signal+0x50)
:|  #*func                -756    0.500  __ipipe_restore_pipeline_head+0x10 (rtdm_event_signal+0xa8)
:   +*func                -756    0.500  __rtdm_synch_flush+0x10 (period_update+0x18c [sigmatek_lrt])
:|  #*func                -755    0.500  xnsynch_flush+0x10 (__rtdm_synch_flush+0x54)
:|  #*func                -755    0.750  __ipipe_restore_pipeline_head+0x10 (__rtdm_synch_flush+0xc8)
:   +*func                -754    0.500  rtdm_event_signal+0x10 (period_update+0x180 [sigmatek_lrt])
:|  #*func                -754    0.500  xnsynch_flush+0x10 (rtdm_event_signal+0x50)
:|  #*func                -753    0.500  __ipipe_restore_pipeline_head+0x10 (rtdm_event_signal+0xa8)
:   +*func                -753    0.250  __rtdm_synch_flush+0x10 (period_update+0x18c [sigmatek_lrt])
:|  #*func                -752    1.000  xnsynch_flush+0x10 (__rtdm_synch_flush+0x54)
:|  #*func                -751    0.250  xnpod_resume_thread+0x10 (xnsynch_flush+0xa4)
:|  #*[ 1065] WD-Trigg 1  -751    0.750  xnpod_resume_thread+0x54 (xnsynch_flush+0xa4)
:|  #*func                -750    0.500  __xnpod_schedule+0x14 (__rtdm_synch_flush+0x84)
:|  #*[   -1] -<?>-   99  -750    0.250  __xnpod_schedule+0x50 (__rtdm_synch_flush+0x84)
:|  #*func                -750    0.750  xnsched_pick_next+0x10 (__xnpod_schedule+0xa0)
:|  #*func                -749    0.500  __ipipe_restore_pipeline_head+0x10 (__rtdm_synch_flush+0xc8)
:   +*func                -748    0.750  ipipe_trigger_irq+0x10 (period_update+0x224 [sigmatek_lrt])
:|  +*func                -748    0.500  __ipipe_handle_irq+0x14 (ipipe_trigger_irq+0x64)


Before calling nrt_pend, period_update calls rtdm_event_signal,
which could reschedule and cause the nrt_pend to be delayed (but
that does not happen in that case).

- period update is called more often than every millisecond:

:   +*func                -759    0.500  period_update+0x10 [sigmatek_lrt] (timer+0xb0 [sigmatek_lrt])

:   +*func                 -16    0.500  period_update+0x10 [sigmatek_lrt] (timer+0xb0 [sigmatek_lrt])
<   +*freeze  0x00023b12     0    0.750  period_update+0x1f4 [sigmatek_lrt] (timer+0xb0 [sigmatek_lrt])

- you have a massive latency, which is causing your real-time job to
occupy the CPU all the time, and never let Linux run.

:|  #*[ 1065] WD-Trigg 1  -722    0.500  __xnpod_schedule+0x50 (xnpod_suspend_thread+0x220)
:|  #*func                -722    0.750  xnsched_pick_next+0x10 (__xnpod_schedule+0xa0)
:|  #*func                -721    0.250  ipipe_unmute_pic+0x10 (__xnpod_schedule+0x1e4)
:|  #*func                -721    1.000  gic_unmute+0x10 (ipipe_unmute_pic+0x18)
:|  #*func                -720+   1.250  ipipe_unstall_pipeline_head+0x10 (__xnpod_schedule+0x270)
:   +*func                -719    0.500  xnsched_finish_unlocked_switch+0x10 (__xnpod_schedule+0x38c)
:|  #*[  700] mmcqd/0 -1  -718    0.750  __xnpod_schedule+0x3b0 (xnintr_clock_handler+0x118)
:|  #*func                -717    0.500  xnpod_fire_callouts+0x10 (__xnpod_schedule+0x5fc)
:|  #*func                -717    0.750  taskSwitchXenomai+0x14 [sigmatek_lrt] (xnpod_fire_callouts+0x54)
:|  #*func                -716    0.750  measureIdleTime+0x10 [sigmatek_lrt] (taskSwitchXenomai+0x6c [sigmatek_lrt])
:|  #*func                -715    1.000  xnarch_tsc_to_ns+0x10 (measureIdleTime+0xac [sigmatek_lrt])
:|   #func                -714    0.750  __ipipe_walk_pipeline+0x10 (__ipipe_dispatch_wired_nocheck+0xa4)
:|   #func                -714! 674.750  __ipipe_exit_irq+0x10 (__ipipe_grab_irq+0x60)
:|   #func                 -39    0.500  __ipipe_grab_irq+0x10 (__irq_svc+0x40)

I believe this latency issue is due to the L2 cache write-allocate
bit that was fixed in the latest I-pipe patch. Please upgrade the
I-pipe patch, check/fix the issues above, and post another trace if
you still have the issue.

-- 
					    Gilles.

