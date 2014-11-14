Date: Fri, 14 Nov 2014 14:05:18 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20141114130518.GN4656@sisyphus.hd.free.fr>
References: <54631EB1.1050900@sigmatek.at>
 <20141112164411.GB17476@sisyphus.hd.free.fr>
 <5464DCAA.6060004@sigmatek.at>
 <20141113163300.GM4656@sisyphus.hd.free.fr>
 <5465D11B.1060808@sigmatek.at>
 <20141114102057.GD4656@sisyphus.hd.free.fr>
 <5465F79A.4060107@sigmatek.at>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5465F79A.4060107@sigmatek.at>
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

On Fri, Nov 14, 2014 at 01:37:46PM +0100, Johann Obermayr wrote:
> >- period update is called more often than every millisecond:
> >
> >:   +*func                -759    0.500  period_update+0x10 [sigmatek_lrt] (timer+0xb0 [sigmatek_lrt])
> >
> >:   +*func                 -16    0.500  period_update+0x10 [sigmatek_lrt] (timer+0xb0 [sigmatek_lrt])
> ><   +*freeze  0x00023b12     0    0.750  period_update+0x1f4 [sigmatek_lrt] (timer+0xb0 [sigmatek_lrt])
> 
> which can not be, because it is triggerd by a FPGA hardware IRQ
> every millisecond.

So, bugs in FPGA never happen? As far as I know the P in
FPGA means "programmable". I do not see how the trace could be wrong
on this. You can read a counter in your FPGA every time
period_update is called, if you do not trust the processor clock.

> 
> >- you have a massive latency, which is causing your real-time job to
> >occupy the CPU all the time, and never let Linux run.
> It looks as if a mmcqd task (micro SD card) will stop calling software irq.

I am not sure there is a big latency here, the system maybe just
returns to user-space which does its job, and the time spent in
user-space gets accounted before the last function which was called
before the return to user-space. I need to read this part of the
trace again to see where the virq should have been triggered.

> 
> >:|  #*[ 1065] WD-Trigg 1  -722    0.500  __xnpod_schedule+0x50 (xnpod_suspend_thread+0x220)
> >:|  #*func                -722    0.750  xnsched_pick_next+0x10 (__xnpod_schedule+0xa0)
> >:|  #*func                -721    0.250  ipipe_unmute_pic+0x10 (__xnpod_schedule+0x1e4)
> >:|  #*func                -721    1.000  gic_unmute+0x10 (ipipe_unmute_pic+0x18)
> >:|  #*func                -720+   1.250  ipipe_unstall_pipeline_head+0x10 (__xnpod_schedule+0x270)
> >:   +*func                -719    0.500  xnsched_finish_unlocked_switch+0x10 (__xnpod_schedule+0x38c)
> >:|  #*[  700] mmcqd/0 -1  -718    0.750  __xnpod_schedule+0x3b0 (xnintr_clock_handler+0x118)
> >:|  #*func                -717    0.500  xnpod_fire_callouts+0x10 (__xnpod_schedule+0x5fc)
> >:|  #*func                -717    0.750  taskSwitchXenomai+0x14 [sigmatek_lrt] (xnpod_fire_callouts+0x54)
> >:|  #*func                -716    0.750  measureIdleTime+0x10 [sigmatek_lrt] (taskSwitchXenomai+0x6c [sigmatek_lrt])
> >:|  #*func                -715    1.000  xnarch_tsc_to_ns+0x10 (measureIdleTime+0xac [sigmatek_lrt])
> >:|   #func                -714    0.750  __ipipe_walk_pipeline+0x10 (__ipipe_dispatch_wired_nocheck+0xa4)
> >:|   #func                -714! 674.750  __ipipe_exit_irq+0x10 (__ipipe_grab_irq+0x60)
> >:|   #func                 -39    0.500  __ipipe_grab_irq+0x10 (__irq_svc+0x40)

> _______________________________________________
> Xenomai mailing list
> Xenomai@xenomai.org
> http://www.xenomai.org/mailman/listinfo/xenomai

-- 
					    Gilles.

