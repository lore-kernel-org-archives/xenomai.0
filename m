Message-ID: <4739E19D.3000004@domain.hid>
Date: Tue, 13 Nov 2007 18:40:45 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <472F6C17.2070100@domain.hid>	<472F6DAD.20308@domain.hid>	<472F990A.2030209@domain.hid>	<473006D8.4080808@domain.hid>	<47302D55.9050808@domain.hid>	<47339C53.5010700@domain.hid>	<4734677E.6010904@domain.hid>	<47348EE0.5020007@domain.hid>	<473493CB.4080701@domain.hid>	<4734995B.20900@domain.hid>
	<4737510F.7010309@domain.hid> <47397C4B.1070901@domain.hid>
In-Reply-To: <47397C4B.1070901@domain.hid>
Content-Type: multipart/mixed; boundary="------------040602010607050405030407"
Subject: Re: [Xenomai-core] [Adeos-main] [PATCH] i386: switch to root domain
 on unhandled non-root faults
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: rpm@xenomai.org
Cc: adeos-main@gna.org, Xenomai-core@domain.hid

This is a multi-part message in MIME format.
--------------040602010607050405030407
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Philippe Gerum wrote:
> Jan Kiszka wrote:
>> Philippe Gerum wrote:
>>> Jan Kiszka wrote:
>>>> Philippe Gerum wrote:
>>>>> Jan Kiszka wrote:
>>>>>
>>>>>> Well, this is practically your original version. I still don't see why
>>>>>> we want debug code in production setups (WARN_ON, e.g., doesn't work
>>>>>> this way either),
>>>>> Do you actually leave CONFIG_IPIPE_DEBUG on in production setups?
>>>> Not /me, but your patch drags in the the full warning message even
>>>> without CONFIG_IPIPE_DEBUG - if I virtually apply the patch correctly.
>>>>
>>> Are you 100% sure of this?
>> Yep, I am. The rationale here is to keep the Linux fault path free of
>> tests, unless we need them urgently also for non-debug setups. We don't,
>> we just loose the context information in case the test is actually true.
>> The oops will come anyway.
>>
> 
> Ok, the intent of the patch may still be unclear to you because two
> changes have been merged in a single place, covering two distinct
> issues, both occurring when some Xenomai context raises an exception
> without any possibility for the nucleus to downgrade to the root domain.
> 
> Issue #1 - sloppy copy_from/to_user from skins. Fixable faults may be
> charged to userland, but since a current problem within skins prevents
> from sending any sensible information back to the caller through normal
> return codes (i.e. -EFAULT), the warning is welcome to point the finger
> at the problematic syscall, only when IPIPE_DEBUG is enabled. This is
> aimed at skin writers, to help them identifying issues reported by
> users, when they are caused by unchecked copy_to/from_user calls: in
> such a case, the first step would be to ask the user to check for its
> syscall arguments, if he happens to use an unfixed Xenomai release. What
> one has to update to get this help feature is only the I-pipe, not the
> entire Xenomai release: this is what makes a significant difference for
> deployed systems. You call this user space debug, I don't: we are only
> giving user-space some support to work around our current in-kernel
> sloppiness, at least temporarily. Because we have a legacy to deal with,
> and out-of-tree code elsewhere, anything unexpensive which may save
> everyone debug time is welcome.

OK, if you insist on this, let's go for a clearer version, see attachment.

> 
> Issue #2 - Unfixable exception from kernel space, typically from a
> real-time ISR. Since this issue is _not_ recoverable through the
> exception table mechanism, it has to be a severe kernel issue, and as
> such, we do want a big fat warning for it, regardless of the
> debug/non-debug state. This has exactly the same semantics than the
> standard BUG() assertion. But, in such a case, you don't want to rely on
> the Linux fault handling mechanism to eventually generate an oops later,
> because the underlying context is fundamentally unsafe Linux-wise, and
> the exception path may well not make it up to that point. What we want

THAT is an argument I buy.

> is an early warning, asap, so that at the very least, we may get a hint
> about what was going on before a possible lockup. Said differently, it's
> co-kernel world, and we have basically no guarantee that all the code
> which is going to be executed on behalf of the regular Linux exception
> handler will survive long enough to reach the oops handler. E.g.
> notifier call chain invoked, hardware interrupts enabled anew in the
> fault handler, scanning of the VMA list, and I'm only illustrating the
> page fault handling case here, albeit practically all kind of exception
> handlers may be involved. We may even want to add %eip to the initial
> warning output, in case dump_stack() fails miserably -- usually,
> experience shows that at least the first printk() works, fortunately. In
> future updates, we may want to rely on raw UART output when the platform
> provides for it (currently, all blackfin, mpc52xx and some? ARM do, IIRC).
> 
>> See, I didn't introduce
>> CONFIG_IPIPE_DEBUG for user space debugging, it has always been a kernel
>> debug switch. So I would prefer to keep its semantics straight here as
> well.
> 
> Really, If you look at the facts and what has been written so far,
> this patch has never been meant as a user-space debugging feature. The
> fact that warnings might be issued upon user-space errors is merely an
> help to better identify current kernel issues in skins, before the lack
> of check for copy_to/from_user return values may generalize havoc, and
> possibly trigger even more faults. This is issue #1 as described.
> 
>>>>> This feature is mainly aimed at API writers, not users. Additionally,
>>>> If you want to support API writer: Let us tag __xn_copy* with
>>>> __must_check - _that_ would be the right tool for pointing out remaining
>>>> issues, not some runtime warning that a) only triggers if the user
>>> What do you make of existing setups which will not upgrade to 2.4 in any
>>> foreseeable future?
>> 99% of the very same setups won't upgrade to new kernel patches either,
>> so the effect is likely negligible.
>>
> 
> I don't know where you got this figure from, but as far as I can tell,
> since I'm also regularly helping people to deploy Xenomai in production
> systems, they will upgrade their kernel more frequently than their
> Xenomai baseline, e.g. to grab the latest kernel fixes from the stable
> Linux branch, which is especially true regarding 2.6.20. At this chance,
> they will much more likely upgrade their I-pipe patch rather than the
> entire Xenomai release.

This does not correlate with my experience, not regarding major Xenomai
updates, but step-ups within the stable series. If upgrading the kernel
anyway, obtaining the last Xenomai bug fixes is what I recommend and
also observe (sometimes Xenomai updates are even mandatory due to
required HAL updates). In any case, no one prevents us from fixing the
skin issues also in the stable series.

> 
> If you take into account that 2.6.20/x86 now includes this
> feature, people maintaining 2.3.x setups will actually benefit from
> it when it comes to identify issue #1. The same way, other non-x86 archs
> may use very recent kernels with v2.3.x, like powerpc which may run the
> latest 2.6.23. Basically, only x86 needs to upgrade to 2.4 for running
> kernels beyond 2.6.20. This is why an equivalent feature is also needed
> for all other archs when it makes sense.
> 
> I will amend my latest patch to address your concern about the initial
> test though, by saving the cycles your patch spends unconditionally
> resetting the domain to the root one on the fast path. This will put

The unconditional setting indeed only made sense as long as there was no
test at all on the non-debug case.

> our respective implementations roughly on par with respect to this
> particular issue.
> 

OK, attached is an attempt to follow your arguments, while also keeping
topics separate which have different backgrounds (ie. clarify the
messages). As we go for reporting user faults now, lets include those
(unlikely and really buggy) cases over user mode as well.

Jan

-- 
Siemens AG, Corporate Technology, CT SE 2
Corporate Competence Center Embedded Linux

--------------040602010607050405030407
Content-Type: text/x-patch;
 name="rework-fault-warnings.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="rework-fault-warnings.patch"

---
 arch/i386/kernel/ipipe.c |   44 ++++++++++++++++++++++++--------------------
 1 file changed, 24 insertions(+), 20 deletions(-)

Index: linux-2.6.23.1-xeno/arch/i386/kernel/ipipe.c
===================================================================
--- linux-2.6.23.1-xeno.orig/arch/i386/kernel/ipipe.c
+++ linux-2.6.23.1-xeno/arch/i386/kernel/ipipe.c
@@ -616,12 +616,6 @@ static int __ipipe_xlate_signo[] = {
 };
 #endif /* CONFIG_KGDB */
 
-#ifdef CONFIG_IPIPE_DEBUG
-#define ipipe_may_dump_nonroot_fault(regs)	1
-#else
-#define ipipe_may_dump_nonroot_fault(regs)	(!search_exception_tables((regs)->eip))
-#endif
-
 fastcall int __ipipe_handle_exception(struct pt_regs *regs, long error_code, int vector)
 {
 	unsigned long flags;
@@ -655,25 +649,35 @@ fastcall int __ipipe_handle_exception(st
 	}
 
 	/*
-	 * Detect unhandled faults from kernel space over non-root domains.
+	 * Detect faults over non-root domains.
 	 */
-	if (unlikely(!ipipe_root_domain_p && !(error_code & 4))) {
-		/*
-		 * Always warn about such faults when running in debug
-		 * mode, otherwise avoid reporting the fixable ones.
-		 */
-		if (ipipe_may_dump_nonroot_fault(regs)) {
-			struct ipipe_domain *ipd = ipipe_current_domain;
-			ipipe_current_domain = ipipe_root_domain;
+	if (unlikely(!ipipe_root_domain_p)) {
+		struct ipipe_domain *ipd = ipipe_current_domain;
+
+		/* Switch to root so that Linux can handle it cleanly. */
+		ipipe_current_domain = ipipe_root_domain;
+
+		/* Always warn about user land and unfixable faults. */
+		if ((error_code & 4) && !search_exception_tables(regs->eip)) {
 			ipipe_trace_panic_freeze();
-			printk(KERN_ERR "DOMAIN FAULT: Unhandled exception over domain"
-			       " %s - switching to ROOT\n", ipd->name);
+			printk(KERN_ERR "BUG: Unhandled exception over domain"
+			       " %s at 0x%lx - switching to ROOT\n",
+			       ipd->name, regs->eip);
 			dump_stack();
 		}
-	}
+#ifdef CONFIG_IPIPE_DEBUG
+		/* Also report fixable ones when debugging is enabled. */
+		else {
+			ipipe_trace_panic_freeze();
+			printk(KERN_WARNING "WARNING: Fixable exception over "
+			       "domain %s at 0x%lx - switching to ROOT\n",
+			       ipd->name, regs->eip);
+			dump_stack();
+		}
+#endif /* CONFIG_IPIPE_DEBUG */
 
-	/* Always switch to root so that Linux can handle it cleanly. */
-	ipipe_current_domain = ipipe_root_domain;
+		ipipe_current_domain = ipipe_root_domain;
+	}
 
 	__ipipe_std_extable[vector](regs, error_code);
 	local_irq_restore(flags);

--------------040602010607050405030407--

