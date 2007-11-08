Message-ID: <47339C53.5010700@domain.hid>
Date: Fri, 09 Nov 2007 00:31:31 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <472F6C17.2070100@domain.hid>
	<472F6DAD.20308@domain.hid>	<472F990A.2030209@domain.hid>
	<473006D8.4080808@domain.hid> <47302D55.9050808@domain.hid>
In-Reply-To: <47302D55.9050808@domain.hid>
Content-Type: multipart/mixed; boundary="------------070402000608060603050206"
Sender: Philippe Gerum <philippe.gerum@domain.hid>
Subject: Re: [Xenomai-core] [Adeos-main] [PATCH] i386: switch to root domain
 on unhandled non-root faults
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
Cc: adeos-main@gna.org, Xenomai-core@domain.hid

This is a multi-part message in MIME format.
--------------070402000608060603050206
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Jan Kiszka wrote:
> Jan Kiszka wrote:
>> Philippe Gerum wrote:
>>> Jan Kiszka wrote:
>>>> Jan Kiszka wrote:
>>>>> This patch addresses the recently discovered issue that I-pipe actually
>>>>> need to deal with faults over non-root domain in which the current
>>>>> domain shows no interest in. Such faults could be triggered inside
>>>>> copy_*_user, thus can cleanly be handled by Linux - if we only allow for
>>>>> this. Currently, if debugging is on, we warn about a potential bug, and
>>>>> corrupt the pipeline states otherwise.
>>>>>
>>>>> The new approach is to unconditionally drop to root domain in such
>>>>> cases, but - for debugging purposes of non-fixable faults - keep track
>>>>> of the original domain and report it on oops.
>>>>>
>>>>> Similar patches are required for other archs. Maybe I can look into
>>>>> x86_64 later.
>>>>>
>>> Nak, this patch would not work as wanted. Again, what you need is to
>>> always fixup, and conditionally send a bug report to the kernel log if
>>> CONFIG_IPIPE_DEBUG is enabled, nothing more.
>>>
>>> This patch assumes that die() is always going to be fired for any
>>> in-kernel fault, so that all reports only need to go through this
>>> routine, which is wrong. Kernel fixups through exception tables may fix
>>> the fault early and silently, and this is particularly the case for
>>> copy_to_user helpers, which do include kernel fixup code.  By being
>>> silent when fixing up things in __ipipe_handle_exception() like your
>>> patch currently is, we would be left with no trace at all that some
>>> unhandled fault just happened, except by looking at /proc/xenomai/faults.
>> As you are still remain vague on the actual problematic scenarios, I
>> will try to go through them, and maybe you can add/correct what I miss:
>>
>>  - faults in user land => can be silently handled by Linux after
>>    dropping to root domain. This lowering is perfectly fine as the
>>    higher domains showed no interest in the fault, thus are currently
>>    running in domain-agnostic code paths anyway.
>>
>>  - faults on fixable kernel addresses => same as above. If the high
>>    domains fail to evaluate the fix-up result, it's not I-pipe's fault.
>>
>>  - minor faults on kernel addresses (more precisely: in the I-pipe core
>>    or some I-pipe user) => those would now went unnoticed and need
>>    further thoughts, granted.
>> +
>>  - major faults on kernel addresses => still generate major oopses and
>>    will thus be visible.
>>
>> Did I missed something? If not, I would now start addressing the
>> remaining problematic scenario directly instead of throwing all into the
>> same pot.
>>
>>> By sending the report immediately when fixing up in the latter routine,
>>> you also avoid the ugly ipipe_orig_domain stuff.
>> It's not nice, but it is at least as ugly as reporting a kernel BUG when
>> there is only a gracefully fixable bug in user code. I definitely do not
>> agree with your approach as well, and I'm convinced we need to find a
>> third way here.
> 
> OK, I think this should be acceptable for everyone. It's basically your
> approach, reworked to avoid false positives. Moreover, it
> unconditionally sets the root domain - should be faster.
> 

Fine with me now. I made the fault report systematically dumped when
CONFIG_IPIPE_DEBUG is enabled, to help us fixing the existing issues in
the skins (e.g. syscall arguments escaping the required sanity checks
for whatever reason).

-- 
Philippe.

--------------070402000608060603050206
Content-Type: text/x-patch;
 name="handle-fixable-non-root-faults-v3.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="handle-fixable-non-root-faults-v3.patch"

diff --git a/arch/i386/kernel/ipipe.c b/arch/i386/kernel/ipipe.c
index 9323951..8381ae5 100644
--- a/arch/i386/kernel/ipipe.c
+++ b/arch/i386/kernel/ipipe.c
@@ -616,6 +616,12 @@ static int __ipipe_xlate_signo[] = {
 };
 #endif /* CONFIG_KGDB */
 
+#ifdef CONFIG_IPIPE_DEBUG
+#define ipipe_may_dump_nonroot_fault(regs)	1
+#else
+#define ipipe_may_dump_nonroot_fault(regs)	(!search_exception_tables((regs)->eip))
+#endif
+
 fastcall int __ipipe_handle_exception(struct pt_regs *regs, long error_code, int vector)
 {
 	unsigned long flags;
@@ -643,30 +649,37 @@ fastcall int __ipipe_handle_exception(struct pt_regs *regs, long error_code, int
 	}
 #endif /* CONFIG_KGDB */
 
-	if (!ipipe_trap_notify(vector, regs)) {
-		if (!ipipe_root_domain_p) {
-			/* Fix up domain so that Linux can handle this. */
-#ifdef CONFIG_IPIPE_DEBUG
+	if (unlikely(ipipe_trap_notify(vector, regs))) {
+		local_irq_restore(flags);
+		return 1;
+	}
+
+	/*
+	 * Detect unhandled faults from kernel space over non-root domains.
+	 */
+	if (unlikely(!ipipe_root_domain_p && !(error_code & 4))) {
+		/*
+		 * Always warn about such faults when running in debug
+		 * mode, otherwise avoid reporting the fixable ones.
+		 */
+		if (ipipe_may_dump_nonroot_fault(regs)) {
 			struct ipipe_domain *ipd = ipipe_current_domain;
 			ipipe_current_domain = ipipe_root_domain;
 			ipipe_trace_panic_freeze();
 			printk(KERN_ERR "BUG: Unhandled exception over domain"
-					" %s - switching to ROOT\n",
-					ipd->name);
+			       " %s - switching to ROOT\n", ipd->name);
 			dump_stack();
-#else
-			ipipe_current_domain = ipipe_root_domain;
-#endif /* CONFIG_IPIPE_DEBUG */
 		}
-		__ipipe_std_extable[vector](regs, error_code);
-		local_irq_restore(flags);
-		__fixup_if(regs);
-		return 0;
 	}
 
+	/* Always switch to root so that Linux can handle it cleanly. */
+	ipipe_current_domain = ipipe_root_domain;
+
+	__ipipe_std_extable[vector](regs, error_code);
 	local_irq_restore(flags);
+	__fixup_if(regs);
 
-	return 1;
+	return 0;
 }
 
 fastcall int __ipipe_divert_exception(struct pt_regs *regs, int vector)

--------------070402000608060603050206--

