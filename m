From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <470611FA.30103@domain.hid>
References: <4705ED3B.4070600@domain.hid>
	<2ff1a98a0710050130j7e0db84dq838aab0417c8bd3f@domain.hid>
	<4705FE04.7000909@domain.hid> <1191576011.20623.114.camel@domain.hid>
	<470611FA.30103@domain.hid>
Content-Type: text/plain
Date: Fri, 05 Oct 2007 16:02:57 +0200
Message-Id: <1191592977.20623.142.camel@domain.hid>
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

On Fri, 2007-10-05 at 12:29 +0200, CHABAL David wrote:

> : func     -114   ipipe_check_context (boomerang_start_xmit)
> : func     -114   issue_and_wait (boomerang_start_xmit)
> : func     -114   iowrite16 (issue_and_wait)
> : func     -113!  ioread16 (issue_and_wait)
> :|begin     -84   common_interrupt (ioread16)

The Vortex driver does some brute force polling on the slow path, when
the adapter does not acknowledge the last command sent fast enough. It
seems your CPU is burning a lot of horsepower idling on this loop.

> :|func      -83   __ipipe_handle_irq (common_interrupt)
> :|func      -83   __ipipe_ack_irq (__ipipe_handle_irq)
> :|func      -82   __ipipe_ack_level_irq (__ipipe_ack_irq)
> :|func      -82   mask_and_ack_8259A (__ipipe_ack_level_irq)
> :|func      -82+  __ipipe_spin_lock_irqsave (mask_and_ack_8259A)
> :|func      -78   __ipipe_spin_unlock_irqrestore (mask_and_ack_8259A)
> :|func      -78   __ipipe_dispatch_wired (__ipipe_handle_irq)
> :|func      -77   xnintr_clock_handler (__ipipe_dispatch_wired)
> :|func      -77   xnintr_irq_handler (xnintr_clock_handler)
> :|func      -77   xnpod_announce_tick (xnintr_irq_handler)
> :|func      -76   xntimer_do_tick_aperiodic (xnpod_announce_tick)
> :|func      -76   xnthread_periodic_handler
> (xntimer_do_tick_aperiodic)
> :|func      -76   xnpod_resume_thread (xnthread_periodic_handler)
> :|[ 3937]   -75+  xnpod_resume_thread (xnthread_periodic_handler)
> :|func      -72   xnpod_schedule (xnintr_irq_handler)
> :|[ 3497]   -72+  xnpod_schedule (xnintr_irq_handler)
> :|func      -71   __switch_to (xnpod_schedule)
> :|[ 3937]   -70   xnpod_schedule (xnpod_suspend_thread)
> :|func      -70   __ipipe_restore_pipeline_head
> (xnpod_wait_thread_period)
> :|end       -69+  __ipipe_restore_pipeline_head
> (xnpod_wait_thread_period)
> :|begin     -63   common_interrupt (__ipipe_restore_pipeline_head)
> :|func      -62   __ipipe_handle_irq (common_interrupt)
> :|func      -62   __ipipe_ack_irq (__ipipe_handle_irq)
> :|func      -62   __ipipe_ack_level_irq (__ipipe_ack_irq)
> :|func      -61   mask_and_ack_8259A (__ipipe_ack_level_irq)
> :|func      -61!  __ipipe_spin_lock_irqsave (mask_and_ack_8259A)
> :|func      -40   __ipipe_spin_unlock_irqrestore (mask_and_ack_8259A)

20 us spent acknowledging the interrupt is damned slow. Any "spurious
8259A interrupt" message haunting your kernel log so far?

The sampling task is properly rescheduled after ~15us since the timer
interrupt receipt, problem is that other interrupts are preempting the
awaken task again and again before it has a chance to run. I wonder if
something fishy is not going on with the fast timer acknowledge, or the
network card. Could you:

- send us the output of /proc/interrupts
- try the patch below which should prevent any acknowledge nesting
errors at PIC level, 

--- arch/i386/kernel/i8259.c~	2007-09-16 16:54:34.000000000 +0200
+++ arch/i386/kernel/i8259.c	2007-10-05 15:47:41.000000000 +0200
@@ -176,11 +176,9 @@
 		goto spurious_8259A_irq;
 #ifdef CONFIG_IPIPE
 	if (irq == 0) {
-	    /* Fast timer ack -- don't mask (unless supposedly
-	      spurious) */
-	    outb(0x20,PIC_MASTER_CMD);
-	    spin_unlock_irqrestore(&i8259A_lock, flags);
-	    return;
+		outb(0x60,PIC_MASTER_CMD);	/* 'Specific EOI to master */
+		spin_unlock_irqrestore(&i8259A_lock, flags);
+		return;
 	}
 #endif /* CONFIG_IPIPE */
 	cached_irq_mask |= irqmask;

-- 
Philippe.



