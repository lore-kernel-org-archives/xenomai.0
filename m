From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <470A26BC.506@domain.hid>
References: <4705ED3B.4070600@domain.hid>
	<2ff1a98a0710050130j7e0db84dq838aab0417c8bd3f@domain.hid>
	<4705FE04.7000909@domain.hid> <1191576011.20623.114.camel@domain.hid>
	<470611FA.30103@domain.hid> <1191592977.20623.142.camel@domain.hid>
	<470A26BC.506@domain.hid>
Content-Type: text/plain
Date: Wed, 10 Oct 2007 13:30:52 +0200
Message-Id: <1192015852.22917.197.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: Philippe Gerum <philippe.gerum@domain.hid>
Subject: Re: [Xenomai-help] awful latencies (~110us)
Reply-To: rpm@xenomai.org
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

On Mon, 2007-10-08 at 14:46 +0200, CHABAL David wrote:

> :|   #begin   0x80000000   -98    0.374  __ipipe_unstall_root+0x4b
> (__ipipe_restore_root+0x1b)
> :|   +end     0x80000000   -98+   1.428  __ipipe_unstall_root+0x3a
> (__ipipe_restore_root+0x1b)
> :|   +begin   0xffffff16   -96    0.349  ipipe_ipi3+0x2e (__alloc_skb
> +0xdd)

That's your timer interrupt when the LAPIC is enabled.

> :|   +func                 -96    0.396  __ipipe_handle_irq+0x14
> (ipipe_ipi3+0x33)
> :|   +func                 -96    0.312  __ipipe_ack_apic+0x8
> (__ipipe_handle_irq+0xaf)
> :|   +func                 -95    0.454  __ipipe_dispatch_wired+0x16
> (__ipipe_handle_irq+0x68)
> :| #  func                 -95    0.329  xnintr_clock_handler+0x8
> (__ipipe_dispatch_wired+0x9f)
> :| #  func                 -95    0.400  xnintr_irq_handler+0xe
> (xnintr_clock_handler+0x17)
> :| #  func                 -94    0.312  xnpod_announce_tick+0x8
> (xnintr_irq_handler+0x3b)
> :| #  func                 -94    0.497  xntimer_do_tick_aperiodic+0xe
> (xnpod_announce_tick+0xf)
> :| #  func                 -93    0.301  xnthread_periodic_handler+0x8
> (xntimer_do_tick_aperiodic+0x217)
> :| #  func                 -93    0.375  xnpod_resume_thread+0xe
> (xnthread_periodic_handler+0x2c)
> :| #  [ 4196] samplin 99   -93    0.933  xnpod_resume_thread+0x56
> (xnthread_periodic_handler+0x2c)
> :| #  func                 -92    0.327  xnpod_schedule+0xe
> (xnintr_irq_handler+0x135)
> :| #  [ 3457] konsole -1   -91+   1.299  xnpod_schedule+0x90
> (xnintr_irq_handler+0x135)
> :| #  func                 -90    0.639  __switch_to+0xe
> (xnpod_schedule+0x493)
> :| #  [ 4196] samplin 99   -89    0.642  xnpod_schedule+0x56b
> (xnpod_suspend_thread+0x18b)
> :| #  func                 -89    0.353  __ipipe_restore_pipeline_head
> +0x12 (xnpod_wait_thread_period+0x12b)
> :| +  end     0x80000000   -88+   1.363  __ipipe_restore_pipeline_head
> +0x5c (xnpod_wait_thread_period+0x12b)
> :| +  begin   0xfffffffa   -87    0.530  common_interrupt+0x29
> (__ipipe_restore_pipeline_head+0x60)

Then a NIC interrupt is caught before the just awaken task gets back to
user-space.

> :| +  func                 -87    0.454  __ipipe_handle_irq+0x14
> (common_interrupt+0x2e)
> :| +  func                 -86    0.263  __ipipe_ack_irq+0x8
> (__ipipe_handle_irq+0x151)
> :| +  func                 -86    0.307  __ipipe_ack_level_irq+0x12
> (__ipipe_ack_irq+0x19)
> :| +  func                 -86    0.352  mask_and_ack_8259A+0x14
> (__ipipe_ack_level_irq+0x22)
> :| +  func                 -85!  30.267  __ipipe_spin_lock_irqsave+0x9
> (mask_and_ack_8259A+0x29)

I suspect the tracer to induce massive cache misses on your setup, which
limits the interpretation we can have of this log. Could you apply the
following patch, and post back the frozen log for the very same test?
TIA,

--- 2.6.20-ipipe-1.8-08/kernel/ipipe/core.c~	2007-09-16 16:54:34.000000000 +0200
+++ 2.6.20-ipipe-1.8-08/kernel/ipipe/core.c	2007-10-10 13:05:28.000000000 +0200
@@ -283,7 +283,7 @@
 	unsigned long flags;
 	int s;
 
-	local_irq_save_hw(flags);
+	local_irq_save_hw_notrace(flags);
 	__raw_spin_lock(lock);
 	ipipe_load_cpuid();
 	ipd = per_cpu(ipipe_percpu_domain, cpuid);
@@ -302,7 +302,7 @@
 	ipd = per_cpu(ipipe_percpu_domain, cpuid);
 	if (!raw_demangle_irq_bits(&x))
 		__clear_bit(IPIPE_STALL_FLAG, &ipd->cpudata[cpuid].status);
-	local_irq_restore_hw(x);
+	local_irq_restore_hw_notrace(x);
 }
 
 /*

> :| #  func                 -55    0.385
> __ipipe_spin_unlock_irqrestore+0x9 (mask_and_ack_8259A+0x73)
> :| +  func                 -54    0.349  __ipipe_walk_pipeline+0xe
> (__ipipe_handle_irq+0x81)
> :| +  end     0xfffffffa   -54+   2.204  common_interrupt+0x38
> (__ipipe_restore_pipeline_head+0x60)

Another NIC interrupt, still not running the task...

> :| +  begin   0xfffffff1   -52    0.331  common_interrupt+0x29
> (__ipipe_restore_pipeline_head+0x60)
> :| +  func                 -52    0.804  __ipipe_handle_irq+0x14
> (common_interrupt+0x2e)
> :| +  func                 -51    0.371  __ipipe_ack_irq+0x8
> (__ipipe_handle_irq+0x151)
> :| +  func                 -50    0.321  __ipipe_ack_level_irq+0x12
> (__ipipe_ack_irq+0x19)
> :| +  func                 -50    0.252  mask_and_ack_8259A+0x14
> (__ipipe_ack_level_irq+0x22)
> :| +  func                 -50!  38.784  __ipipe_spin_lock_irqsave+0x9
> (mask_and_ack_8259A+0x29)
> :| #  func                 -11    0.367
> __ipipe_spin_unlock_irqrestore+0x9 (mask_and_ack_8259A+0x73)
> :| +  func                 -11    0.346  __ipipe_walk_pipeline+0xe
> (__ipipe_handle_irq+0x81)
> :| +  end     0xfffffff1   -10    0.715  common_interrupt+0x38
> (__ipipe_restore_pipeline_head+0x60)

Then an IDE interrupt.

> :| +  begin   0x80000001   -10    0.351  __ipipe_dispatch_event+0x180
> (__ipipe_syscall_root+0x44)
> :| +  end     0x80000001    -9+   3.002  __ipipe_dispatch_event+0x154
> (__ipipe_syscall_root+0x44)

Your task is back, way too late obviously. Still, the additional
interrupts do not cause the massive jitter, even if they increase the
worst-case. The next frozen log may tell us more.

-- 
Philippe.



