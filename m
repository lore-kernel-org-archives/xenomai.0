From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <20091106081033.GA5306@domain.hid>
References: <20091103133407.GA9836@domain.hid>
	<1257259464.2210.32.camel@domain.hid>
	<20091104055659.GA5280@domain.hid>
	<1257328464.2210.66.camel@domain.hid>
	<20091104111536.GA14614@domain.hid>
	<1257334005.2210.86.camel@domain.hid>
	<20091104140832.GA32220@domain.hid>
	<20091104181907.GA24561@domain.hid>
	<1257372981.2210.160.camel@domain.hid>
	<20091106081033.GA5306@domain.hid>
Content-Type: text/plain; charset="UTF-8"
Date: Fri, 06 Nov 2009 09:26:58 +0100
Message-ID: <1257496018.2210.243.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] [Xenomai core] Freeze on MPC8572 and P2020 with
	SMP
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Richard Cochran <richardcochran@domain.hid>
Cc: xenomai@xenomai.org

On Fri, 2009-11-06 at 09:10 +0100, Richard Cochran wrote:
> On Wed, Nov 04, 2009 at 11:16:21PM +0100, Philippe Gerum wrote:
> > Core 0 waits for core 1 to acknowledge the critical IPI, but that
> > lazybones prefers to sleep. Likely because it did not receive the IPI in
> > question, actually (it should raise a bit in  __ipipe_cpu_sync_map, see
> > __ipipe_do_critical_sync). You may want to find the reason why the IPI
> > sent in ipipe_critical_enter() does not propagate to the other core.
> 
> In file arch/powerpc/kernel/smp.c line 160, it appears that the IPIPE
> ifdef code is not reached when msg==3, which is the important value,
> AFAIKT.
> 
> I have neither CONFIG_DEBUGGER nor CONFIG_KEXEC defined.
> 
> 
> int smp_request_message_ipi(int virq, int msg)
> {
> 	int err;
> 
> 	if (msg < 0 || msg > PPC_MSG_DEBUGGER_BREAK) {
> 		return -EINVAL;
> 	}
> #if !defined(CONFIG_DEBUGGER) && !defined(CONFIG_KEXEC)
> 	if (msg == PPC_MSG_DEBUGGER_BREAK) {
> 		return 1;
> 	}
> #endif
> #ifdef CONFIG_IPIPE
> 	if (msg == PPC_MSG_DEBUGGER_BREAK)
> 		/* Piggyback the debugger IPI for the I-pipe. */
> 		__ipipe_register_ipi(virq);
> #endif
> 
> 	err = request_irq(virq, smp_ipi_action[msg], IRQF_DISABLED|IRQF_PERCPU,
> 			  smp_ipi_name[msg], 0);
> 	WARN(err < 0, "unable to request_irq %d for %s (rc %d)\n",
> 		virq, smp_ipi_name[msg], err);
> 
> 	return err;
> }

Ouch. I just can't believe this went unnoticed for that long... Well, no
wonder why then, the critical IPI never gets registered, so never
detected by the pipeline core in __ipipe_grab_irq. Thanks for the heads
up.

This may make things work a little better:

diff --git a/arch/powerpc/kernel/smp.c b/arch/powerpc/kernel/smp.c
index 8968b24..a4fe229 100644
--- a/arch/powerpc/kernel/smp.c
+++ b/arch/powerpc/kernel/smp.c
@@ -164,16 +164,16 @@ int smp_request_message_ipi(int virq, int msg)
 	if (msg < 0 || msg > PPC_MSG_DEBUGGER_BREAK) {
 		return -EINVAL;
 	}
-#if !defined(CONFIG_DEBUGGER) && !defined(CONFIG_KEXEC)
-	if (msg == PPC_MSG_DEBUGGER_BREAK) {
-		return 1;
-	}
-#endif
 #ifdef CONFIG_IPIPE
 	if (msg == PPC_MSG_DEBUGGER_BREAK)
 		/* Piggyback the debugger IPI for the I-pipe. */
 		__ipipe_register_ipi(virq);
 #endif
+#if !defined(CONFIG_DEBUGGER) && !defined(CONFIG_KEXEC)
+	if (msg == PPC_MSG_DEBUGGER_BREAK) {
+		return 1;
+	}
+#endif
 
 	err = request_irq(virq, smp_ipi_action[msg], IRQF_DISABLED|IRQF_PERCPU,
 			  smp_ipi_name[msg], 0);

-- 
Philippe.



