Message-ID: <4463BB6F.8050008@domain.hid>
Date: Fri, 12 May 2006 00:32:15 +0200
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <446364DB.50908@domain.hid>
In-Reply-To: <446364DB.50908@domain.hid>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-core] Re: Stalled xenomai domain with head-optimisation
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

Jan Kiszka wrote:
> Hi Philippe,
> 
> I had a bit "fun" today trying to get some of our robotic hardware
> running with latest Xenomai / Ipipe, also in order to test recent RTDM
> fixes. It turned out that the head-optimised variant easily creates that
> infamous stalled Xenomai domain, e.g. like this one:
> 

Eeek... Ok, two things come to my mind for debugging this issue. The first one is
to make sure the assumption in ipipe_restore_pipeline_head() is a good one, so could
you try please testing the patch below, and see if the situation improves (it cannot
worsen anyway):

--- include/linux/ipipe.h~	2006-05-08 12:17:06.000000000 +0200
+++ include/linux/ipipe.h	2006-05-12 00:17:00.000000000 +0200
@@ -563,7 +563,9 @@
  static inline void ipipe_restore_pipeline_head(unsigned long x)
  {
  	struct ipipe_domain *head = __ipipe_pipeline_head();
+#if 0
  	if (x != test_bit(IPIPE_STALL_FLAG, &head->cpudata[ipipe_processor_id()].status))
+#endif
  		__ipipe_restore_pipeline_head(head,x);
  }


Second, if the first try is unsuccessful, could you try disabling the wired
interrupt support the way below, keeping the rest of the invariant pipeline
head optimizations active?

--- kernel/ipipe/core.c~	2006-05-07 18:05:28.000000000 +0200
+++ kernel/ipipe/core.c	2006-05-11 18:34:57.000000000 +0200
@@ -482,8 +482,10 @@
  	if (ipd->irqs[irq].control & IPIPE_SYSTEM_MASK)
  		return -EPERM;

+#if 0
  	if (!test_bit(IPIPE_AHEAD_FLAG, &ipd->flags))
  		/* Silently unwire interrupts for non-heading domains. */
+#endif
  		modemask &= ~IPIPE_WIRED_MASK;

  	spin_lock_irqsave_hw(&__ipipe_pipelock, flags);

-- 

Philippe.

