From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <Pine.LNX.4.64.0904291204500.15719@domain.hid>
References: <b131c9f0904230220j3f0a7d7ej9172ee4fb48aa69c@domain.hid>
	<1240479431.6990.30.camel@domain.hid>
	<1240482629.7599.45.camel@domain.hid>
	<1240487288.6990.71.camel@domain.hid>
	<Pine.LNX.4.64.0904271229410.719@domain.hid>
	<49F640A0.4010904@domain.hid> <49F64500.50901@domain.hid>
	<Pine.LNX.4.64.0904271720580.6463@domain.hid>
	<49F69187.9030402@domain.hid>
	<Pine.LNX.4.64.0904291204500.15719@domain.hid>
Content-Type: text/plain
Date: Tue, 19 May 2009 12:08:03 +0200
Message-Id: <1242727683.17138.72.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Lockups on a new Celeron-430 system detected and
 resolved.
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Martin Shepherd <mcs@domain.hid>
Cc: xenomai-help <xenomai@xenomai.org>

On Wed, 2009-04-29 at 12:48 -0700, Martin Shepherd wrote:
> On Tue, 28 Apr 2009, Gilles Chanteperdrix wrote:
> > On my side, disabling NO_HZ is enough to make the issue disappear.
> 
> I finally just got around to trying this, but unfortunately, disabling
> NO_HZ and re-enabling HPET_TIMER and x86_PM_TIMER caused the lockups
> to return on my new Celeron-based system. I also tried just disabling
> NO_HZ and X86_PM_TIMER, while leaving just HPET_TIMER enabled, but
> this also resulted in lock-ups. So on my system, the only way to
> prevent the lockups, continues to be to turn off both X86_PM_TIMER and
> HPET_TIMER. Just in case they are useful, I have placed the offending
> kernel configuration file and corresponding contents of dmesg after a
> reboot, for the case of NO_HZ disabled and both timers enabled, at:
> 
>   http://www.astro.caltech.edu/~mcs/xenomai/config-2.6.29.1-xenomai-2.5-rc1
>   http://www.astro.caltech.edu/~mcs/dmesg
> 

Could you try the following patch against 2.6.29.1-x86-2.3-01? TIA,

diff --git a/arch/x86/kernel/ipipe.c b/arch/x86/kernel/ipipe.c
index 44378f8..7879469 100644
--- a/arch/x86/kernel/ipipe.c
+++ b/arch/x86/kernel/ipipe.c
@@ -512,14 +512,14 @@ asmlinkage void __ipipe_unstall_iret_root(struct pt_regs regs)
 			trace_hardirqs_on();
 			__clear_bit(IPIPE_STALL_FLAG, &p->status);
 		}
-
 		/*
-		 * Only sync virtual IRQs here, so that we don't
-		 * recurse indefinitely in case of an external
-		 * interrupt flood.
+		 * We could have received and logged interrupts while
+		 * stalled in the syscall path: play the log now to
+		 * release any pending event. The SYNC_BIT prevents
+		 * infinite recursion in case of flooding.
 		 */
-		if ((p->irqpend_himask & IPIPE_IRQMASK_VIRT) != 0)
-			__ipipe_sync_pipeline(IPIPE_IRQMASK_VIRT);
+		if (p->irqpend_himask != 0)
+			__ipipe_sync_pipeline(IPIPE_IRQMASK_ANY);
 	}
 #ifdef CONFIG_IPIPE_TRACE_IRQSOFF
 	ipipe_trace_end(0x8000000D);


> Martin
> 
> _______________________________________________
> Xenomai-help mailing list
> Xenomai-help@domain.hid
> https://mail.gna.org/listinfo/xenomai-help
-- 
Philippe.



