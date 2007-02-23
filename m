From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <45DEDED6.4070202@domain.hid>
References: <45DEDED6.4070202@domain.hid>
Content-Type: text/plain
Date: Fri, 23 Feb 2007 14:30:01 +0100
Message-Id: <1172237401.26738.13.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: Philippe Gerum <philippe.gerum@domain.hid>
Subject: [Xenomai-core] Re: [BUG] trunk: oops with Stephan's stress test
Reply-To: rpm@xenomai.org
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
Cc: xenomai-core <xenomai@xenomai.org>

On Fri, 2007-02-23 at 13:32 +0100, Jan Kiszka wrote:
> Hi Philippe,
> 
> this is what I get running Stephan slightly modified test with latest
> 2.6.20 / SVN trunk:
> 
> > [ 3317.323825] Xenomai: starting native API services.
> > [ 3318.125915]        c125ea70 00003082 007c8af8 00000003 cd6f4830 d0861f6c 00000000 d084f9ca
> > [ 3318.134339]        d08466ff 00300188 d086f630 d0861f50 00000001 00000001 d0861f50 cf66bab0
> > [ 3318.142913]        000000d8 d0860000 d0861f50 d08624a0 00000200 00000000 d084472e cf62f590
> > [ 3318.151478] Call Trace:
> > [ 3318.154144]  [<d084f9ca>] xntimer_tick_aperiodic+0x1aa/0x480 [xeno_nucleus]
> > [ 3318.161302]  [<d08466ff>] xnpod_announce_tick+0x5/0xb [xeno_nucleus]
> > [ 3318.167737]  [<d084472e>] xnintr_irq_handler+0xec/0x13d [xeno_nucleus]
> > [ 3318.174344]  [<c01331c4>] __ipipe_dispatch_wired+0x71/0x90
> > [ 3318.179889]  [<c01092ce>] __ipipe_handle_irq+0x6f/0x171
> > [ 3318.185156]  [<c0132ec0>] __ipipe_restore_pipeline_head+0x5e/0x5f
> > [ 3318.191291]  [<c0102ea1>] common_interrupt+0x21/0x40
> > [ 3318.196307]  [<d085007b>] xntimer_start_aperiodic+0x25/0x6c4 [xeno_nucleus]
> > [ 3318.203344]  [<c0132ec0>] __ipipe_restore_pipeline_head+0x5e/0x5f
> > [ 3318.209487]  [<c0133d30>] rthal_apc_schedule+0x57/0x5d
> > [ 3318.214667]  [<d085266d>] xnshadow_relax+0x87/0x17c [xeno_nucleus]
> > [ 3318.220923]  [<d082f21f>] __rt_task_wait_period+0x2b/0x49 [xeno_native]
> > [ 3318.227686]  [<d0852cd2>] hisyscall_event+0x1e0/0x230 [xeno_nucleus]
> > [ 3318.234120]  [<d0844676>] xnintr_irq_handler+0x34/0x13d [xeno_nucleus]
> > [ 3318.240729]  [<d0852af2>] hisyscall_event+0x0/0x230 [xeno_nucleus]
> > [ 3318.246986]  [<c01330b3>] __ipipe_dispatch_event+0x82/0x122
> > [ 3318.252609]  [<c01095e2>] __ipipe_syscall_root+0x6c/0xd2
> > [ 3318.257964]  [<c0102be9>] system_call+0x29/0x41
> > [ 3318.262544]  =======================

This backtrace looks weird. Any chance unwind info+frame pointer would
be missing?

> > [ 3318.266189] Xenomai: fatal: Hardened thread interrupt-creator-task[5868] running in Linux domain?! (status=0x300188, sig=0, prev=interrupt-task[5867])
> > [ 3318.266202]  CPU  PID    PRI      TIMEOUT  STAT      NAME
> > [ 3318.266211] >  0  0      257      0        00500080  ROOT
> > [ 3318.266220]    0  5866    10      0        00300380  maintask
> > [ 3318.266229]    0  5867   257      0        00300380  interrupt-task
> > [ 3318.266239]    0  5868    50      0        00300188  interrupt-creator-task

Linux task switch in, while the associated shadow is in a Xenomai ready
state, no wonder why this breaks. Now the question is: how can Linux
switch this task in at that point? Will investigate this later. A tracer
output would be great here if possible, indeed. TIA,

-- 
Philippe.



