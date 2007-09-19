From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <46F0E315.10306@domain.hid>
References: <46F0E315.10306@domain.hid>
Content-Type: text/plain
Date: Wed, 19 Sep 2007 23:04:26 +0200
Message-Id: <1190235866.9745.21.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: Philippe Gerum <philippe.gerum@domain.hid>
Subject: Re: [Adeos-main] [PATCH] fix irq statistics
Reply-To: rpm@xenomai.org
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: </public/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: adeos-main@gna.org

On Wed, 2007-09-19 at 10:51 +0200, Jan Kiszka wrote:
> Hi,
> 
> IRQ hit counters are broken in latest I-pipe 1.10-x for the wired path. 
> This patch moves the counter maintenance out of __ipipe_set_irq_pending 
> and instead makes it explicit at the required spots.

I would rather add the missing accounting code as below. Marking an
interrupt as pending using the __ipipe_set_irq_pending() interface
should implicitely be paired with proper accounting.

--- a/kernel/ipipe/core.c
+++ b/kernel/ipipe/core.c
@@ -786,6 +786,7 @@ int fastcall __ipipe_dispatch_wired(struct ipipe_domain *head_domain, unsigned i
 	old = ipipe_current_domain;
 	ipipe_current_domain = head_domain; /* Switch to the head domain. */
 
+	ipipe_cpudom_var(head_domain, irqall)[irq]++;
 	__set_bit(IPIPE_STALL_FLAG, &ipipe_cpudom_var(head_domain, status));
 	head_domain->irqs[irq].handler(irq, head_domain->irqs[irq].cookie); /* Call the ISR. */
 	__ipipe_run_irqtail();

> 
> Note that this patch also unexports __ipipe_set_irq_pending because I 
> found no reason why it should be used outside the i-pipe core. Please 
> correct me if I'm wrong on this.
> 

That's correct. This export became useless as soon as
__ipipe_unlock_irq() and friends moved out of line, and started fiddling
directly with the interrupt bitmap internally.

> Jan
> 
-- 
Philippe.



