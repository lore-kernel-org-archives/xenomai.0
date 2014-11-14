Date: Fri, 14 Nov 2014 14:45:36 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20141114134536.GO4656@sisyphus.hd.free.fr>
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


Ok, we leave root here:

:    #func                -864    0.500  esdhc_readl_le+0x10 (esdhc_set_clock+0x178)
:    #func                -863    0.500  esdhc_writel_le+0x10 (esdhc_set_clock+0x1b8)
:    #func                -863    0.500  l2x0_cache_sync+0x10 (esdhc_writel_le+0x188)
:    #func                -862    0.500  __ipipe_spin_lock_irqsave+0x10 (l2x0_cache_sync+0x24)
:|   #func                -862!  74.000  __ipipe_spin_unlock_irqrestore+0x10 (l2x0_cache_sync+0x3c)
:|   #func                -788    0.750  __ipipe_grab_irq+0x10 (__irq_svc+0x40)

The timer used (imx timer and not cortex a9 local timer) seem
consistent with the fact that this is an uniprocessor.

period_update does not seem to be triggered by an external IRQ, but
by the timer. A periodic task using rt_task_wait_period in fact.

We can see that the root domain is stalled, so a function is in a
loop, probably in the SD card driver, doing some polling, with local
irqs off. With a masking section of about 74us. Eeek.

In later versions of the I-pipe patch, I have added code to entry.S,
to trace the function which __irq_svc interrupted, if you want, I
can backport these changes. This should be easy.

The complete sequence corresponding to the execution of
period_update can be seen here:

:   +*func                -748    0.750  ipipe_trigger_irq+0x10 (period_update+0x224 [sigmatek_lrt])
:|  +*func                -748    0.500  __ipipe_handle_irq+0x14 (ipipe_trigger_irq+0x64)
:|  +*func                -747    1.000  __ipipe_set_irq_pending+0x10 (__ipipe_handle_irq+0x138)
:   +*func                -746    0.500  rt_task_wait_period+0x10 (timer+0x3c [sigmatek_lrt])
:   +*func                -746    0.750  xnpod_wait_thread_period+0x14 (rt_task_wait_period+0x48)
:|  #*func                -745    0.750  xnpod_suspend_thread+0x14 (xnpod_wait_thread_period+0x94)
:|  #*func                -744    0.500  __xnpod_schedule+0x14 (xnpod_suspend_thread+0x220)
:|  #*[   -1] -<?>-   99  -744    0.250  __xnpod_schedule+0x50 (xnpod_suspend_thread+0x220)
:|  #*func                -743+   1.250  xnsched_pick_next+0x10 (__xnpod_schedule+0xa0)
:|  #*func                -742    1.000  ipipe_unstall_pipeline_head+0x10 (__xnpod_schedule+0x270)
:   +*func                -741    0.500  xnsched_finish_unlocked_switch+0x10 (__xnpod_schedule+0x38c)
:|  #*[ 1065] WD-Trigg 1  -741+   1.500  __xnpod_schedule+0x3b0 (xnpod_suspend_thread+0x220)
:|  #*func                -739    0.500  xnpod_fire_callouts+0x10 (__xnpod_schedule+0x5fc)
:|  #*func                -739    0.500  taskSwitchXenomai+0x14 [sigmatek_lrt] (xnpod_fire_callouts+0x54)
:|  #*func                -738+   1.250  measureIdleTime+0x10 [sigmatek_lrt] (taskSwitchXenomai+0x6c [sigmatek_lrt])
:|  #*func                -737+   4.500  __ipipe_restore_pipeline_head+0x10 (rtdm_event_timedwait+0x15c)
:   +*func                -732    0.750  __ipipe_syscall_root+0x10 (vector_swi+0x44)
:   +*func                -732    0.500  __ipipe_dispatch_event+0x14 (__ipipe_syscall_root+0xdc)
:|  +*func                -731    1.000  lrtdrv_exception_handler+0x14 [sigmatek_lrt] (__ipipe_dispatch_event+0x40)
:   +*func                -730+   1.250  hisyscall_event+0x14 (__ipipe_dispatch_event+0x110)
:   +*func                -729    0.500  sys_rtdm_ioctl+0x10 (hisyscall_event+0x178)
:   +*func                -728    0.500  __rt_dev_ioctl+0x18 (sys_rtdm_ioctl+0x30)
:   +*func                -728    0.500  rtdm_context_get+0x10 (__rt_dev_ioctl+0x38)
:|  #*func                -727    0.750  __ipipe_restore_pipeline_head+0x10 (rtdm_context_get+0xd8)
:   +*func                -727    0.250  lrt_ioctl+0x10 [sigmatek_lrt] (__rt_dev_ioctl+0x6c)
:   +*func                -726    1.000  lrt_ioctl_work+0x14 [sigmatek_lrt] (lrt_ioctl+0x18 [sigmatek_lrt])
:   +*func                -725    0.500  lrtdrv_timing_wait+0x10 [sigmatek_lrt] (lrt_ioctl_work+0x45c [sigmatek_lrt])
:   +*func                -725    0.500  rtdm_event_wait+0x14 (lrtdrv_timing_wait+0x8c [sigmatek_lrt])
:   +*func                -724    0.500  rtdm_event_timedwait+0x14 (rtdm_event_wait+0x2c)
:|  #*func                -724    0.500  xnsynch_sleep_on+0x14 (rtdm_event_timedwait+0xc4)
:|  #*func                -723    0.500  xnpod_suspend_thread+0x14 (xnsynch_sleep_on+0xd4)
:|  #*func                -723    0.500  __xnpod_schedule+0x14 (xnpod_suspend_thread+0x220)
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

And here we finally return to root, which continues its polling,
with local irqs off for 674us!. No wonder why  the virq can not be
executed, Linux irqs are disabled. There is no I-pipe bug involved.

-- 
					    Gilles.

