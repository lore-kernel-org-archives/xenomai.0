Subject: Re: [Xenomai-core] Problem with periodic timer on PPC40x solved
From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <200609252315.38689.niklaus.giger@domain.hid>
References: <200609232013.27649.niklaus.giger@domain.hid>
	<200609252229.56854.niklaus.giger@domain.hid>
	<1159217987.4981.10.camel@domain.hid>
	<200609252315.38689.niklaus.giger@domain.hid>
Content-Type: text/plain
Date: Tue, 26 Sep 2006 16:21:18 +0200
Message-Id: <1159280478.5084.117.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
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
To: niklaus.giger@domain.hid
Cc: xenomai@xenomai.org

> On Mon, 2006-09-25 at 22:29 +0200, Niklaus Giger wrote:
> > > Am Montag, 25. September 2006 17:57 schrieb Philippe Gerum:
> > > > On Sun, 2006-09-24 at 23:07 +0200, Wolfgang Grandegger wrote:
> > > > > Niklaus Giger wrote:
> <..>
> > > Is the output of lines like "Xenomai: Switching display-3238 to secondary
> > > mode after exception #1025 from user-space at 0x100033c4 (pid 3240)"
> > > harmless or the result of a activated CONFIG_XENO_OPT_DEBUG<..> option?

A known hw issue seems to exist with the 405GP (revD), which causes the
ESR to be incorrectly set upon FPU emulation trap, which would in turn
cause the spurious exception to be relayed to the nucleus by Adeos. The
patch below is _not_ the final fix, but rather a way to check if this
message is indeed related to the FPU emulation on your board. Does it
silence the exception without breaking the box?

--- arch/ppc/kernel/traps.c~	2006-09-25 17:10:48.000000000 +0200
+++ arch/ppc/kernel/traps.c	2006-09-26 16:14:30.000000000 +0200
@@ -638,9 +638,6 @@
 	unsigned int reason = get_reason(regs);
 	extern int do_mathemu(struct pt_regs *regs);
 
-	if (ipipe_trap_notify(IPIPE_TRAP_PCE,regs))
-	    	return;
-
 #ifdef CONFIG_MATH_EMULATION
 	/* (reason & REASON_ILLEGAL) would be the obvious thing here,
 	 * but there seems to be a hardware bug on the 405GP (RevD)
@@ -655,6 +652,9 @@
 	}
 #endif /* CONFIG_MATH_EMULATION */
 
+	if (ipipe_trap_notify(IPIPE_TRAP_PCE,regs))
+	    	return;
+
 	if (reason & REASON_FP) {
 		/* IEEE FP exception */
 		int code = 0;
-- 
Philippe.



