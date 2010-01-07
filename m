From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <449944.37907.qm@domain.hid>
References: <449944.37907.qm@domain.hid>
Content-Type: text/plain; charset="UTF-8"
Date: Thu, 07 Jan 2010 15:25:05 +0100
Message-ID: <1262874305.2220.107.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [Adeos-main] __ipipe_grab_irq
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: </public/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: A C <adrien_chiron@domain.hid>
Cc: adeos <adeos-main@gna.org>

On Thu, 2010-01-07 at 13:48 +0000, A C wrote:
> Hello,
> in the function __ipipe_grab_irq for the NIOS2, there is the following
> block :
> 
> if (likely(irq == __ipipe_hrtimer_irq)) {
>         __raw_get_cpu_var(__ipipe_tick_regs).estatus = regs->estatus;
>         __raw_get_cpu_var(__ipipe_tick_regs).ea = regs->ea;
>         if (!__ipipe_root_domain_p) {
>             __raw_get_cpu_var(__ipipe_tick_regs).estatus &=
> ~NIOS2_STATUS_PIE_MSK); 
>               }
>     }

This should read:

diff --git a/arch/nios2/kernel/ipipe.c b/arch/nios2/kernel/ipipe.c
index e88d788..2ec178c 100644
--- a/arch/nios2/kernel/ipipe.c
+++ b/arch/nios2/kernel/ipipe.c
@@ -290,7 +290,7 @@ int __ipipe_grab_irq(int irq, struct pt_regs *regs)
 {
 	if (likely(irq == __ipipe_hrtimer_irq)) {
 		__raw_get_cpu_var(__ipipe_tick_regs).estatus = regs->estatus;
-		__raw_get_cpu_var(__ipipe_tick_regs).ea = regs->ea;
+		__raw_get_cpu_var(__ipipe_tick_regs).ra = regs->ra;
 		if (!__ipipe_root_domain_p) {
 			__raw_get_cpu_var(__ipipe_tick_regs).estatus
 				&= ~NIOS2_STATUS_PIE_MSK;

> 
> We do not understand why there is an unusual case for an interruption
> from the timer. We understand each lines but not the global nature.
> Any help ?
> 

The linux kernel does basic sampling-based profiling and assesses the
current load average by looking at which code the timer tick did
preempt. Since we have a deferred interrupt model, and possibly many
non-linux tick interrupts passed to the upper domain(s), we have to
somehow forge a timer tick frame specifically for linux, which we then
pass to the regular tick handler (to any regular IRQ handler in fact,
since only the tick handler uses this info), for keeping those
computations accurate.

> Cheers
> Adrien Chiron & Vincent Vanbesien
> 
> 
> 
> _______________________________________________
> Adeos-main mailing list
> Adeos-main@domain.hid
> https://mail.gna.org/listinfo/adeos-main


-- 
Philippe.



