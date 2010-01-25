Message-ID: <4B5DE3E7.6090803@domain.hid>
Date: Mon, 25 Jan 2010 19:33:11 +0100
From: Wolfgang Mauerer <wolfgang.mauerer@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------050706040309050609060207"
Subject: Re: [Xenomai-core] Fwd: Re: [RFC][PATCH] x86: Fix root domain state
 restoring on exception return
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: "Kiszka, Jan" <jan.kiszka@domain.hid>
Cc: adeos-main@gna.org, "xenomai@xenomai.org" <xenomai@xenomai.org>

This is a multi-part message in MIME format.
--------------050706040309050609060207
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Jan Kiszka wrote:
> Wolfgang Mauerer wrote:
>> Kiszka, Jan wrote:
>> 
>>> If we enter __ipipe_handle_exception over a non-root domain and leave it
>>> due to migration in the event handler over root, we must not restore the
>>> root domain state so far saved on entry. This caused subtle pipeline
>>> state corruptions. Actually, we only need to save the state if we enter
>>> over the root domain and have to align its state to the hardware
>>> interrupt mask.
>>>
>>> Moreover, the x86-32 regs.eflags fix-up must happen based on the current
>>> root domain state to avoid more spurious corruptions.
>> 
>> unfortunately, this won't boot on x86-32: During CPU bug checking
>> in check_hlt, the kernel will really go into the halt state and
>> never recover. By modifying __ipipe_handle_exception to use
>> raw_irqs_disabled_flags as argument to __fixup_if instead of
>> raw_irqs_disabled, everything is back to normal again. However,
> 
> That would reintroduce the bug we saw on 64 bit to 32 bit (in a slight
> variation). So we need to understand what goes wrong here. Can you
> generate an ipipe panic trace?

the problem is that when Linux does the hlt check
in check_hlt, it relies on interrupts to occur after the hlt
instructions have been issued - otherwise, the computer will really
halt. This happens during early boot before ftrace is enabled, which
makes tracing a bit hard... Besides, since we are stuck after the first
hlt, its also hard to find a good point where to start the trace ;-)

One missing part of the problem seems to be to figure out when
to _really_ use __fixup_if, I did some more testing on the
effects wrt. the bug handled in Jan's recent patch.

1.) With

if (restore_flags)
        __fixup_regs(raw_irqs_disabled_flags(regs) ,regs);

being used in __ipipe_handle_exception, the kernel boots properly
(so it seems to do as well if __fixup_regs is called
unconditionally)

2.) With __fixup_regs(raw_irq_disable(), regs), the boot process
stops in check_hlt() in the Linux kernel.

There seems to be a disagreement about the state of the hardware
interrupt flag right before the kernel executes the tests in
check_halt(). With the following code in __ipipe_handle_exception

        if (restore_flags) {
                rawflags = __raw_local_save_flags();

                printk("before fixup: rawflags: %lx, flags: %lx, "
                       "regs->flags: %lx\n", rawflags, flags,
                       regs->flags);

                __fixup_if(raw_irqs_disabled_flags(flags), regs);

                printk("after fixup: rawflags: %lx, flags: %lx, "
                       "regs->flags: %lx\n", rawflags, flags,
                       regs->flags);
        }

we can distinguish between case 1 and 2 (X86_FLAGS_IF=0x200) right
before check_hlt():

case 1 (raw_irqs_disable_flags):
[    0.339060] before fixup: rawflags: 0, flags: 200, regs->flags: 246
[    0.340001] after fixup: rawflags: 0, flags: 200, regs->flags: 246

case 2 (raw_irqs_disable):
[    0.345352] before fixup: rawflags: 0, flags: 200, regs->flags: 246
[    0.346582] after fixup: rawflags: 0, flags: 200, regs->flags: 46

Consider __ipipe_unstall_iret_root. When regs->flags | X86_FLAGS_IF
- is 0, the pipeline is stalled, but regs.flags =| X86_EFLAGS_IF
  => Ipipe recives interrupts, but does not pass them on to the Linux
     domain.
- is X86_FLAGS_IF, then the pipeline is unstalled and interrupts are
  implicitely enabled by iret. Everything works as expected even if
  rawflags and regs.flags have disagreed upon entry to
  __ipipe_handle_exception

This explains why everything works fine in case 1 (despite
rawflags and regs->flags disagree), but fails in case 2.

However, since the IRQ state obtained from the raw hardware settings
via pushf in raw_irqs_disabled() disagrees with what Ipipe believes
to be the hardware state in regs->flags, it would seem that the
consistency between both is destroyed somewhere in the early boot
process, and inadvertently  "fixed" by __fixup_regs.

Does that make sense? Or does anyone else have another idea what might
be going on? For the sake of completeness, I've also attached the
patch used for testing as it is right now.

Thanks, Wolfgang

--------------050706040309050609060207
Content-Type: text/x-patch;
 name="ipipe.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="ipipe.diff"

commit 86e5bcfd0a39960e68475a5a6108088176d98aae
Author: Wolfgang Mauerer <wolfgang.mauerer@domain.hid>
Date:   Sun Jan 24 23:13:30 2010 +0100

    x86: Fix root domain state restoring on exception return

diff --git a/arch/x86/kernel/ipipe.c b/arch/x86/kernel/ipipe.c
index 4442d96..b8a6ec7 100644
--- a/arch/x86/kernel/ipipe.c
+++ b/arch/x86/kernel/ipipe.c
@@ -702,19 +702,22 @@ static int __ipipe_xlate_signo[] = {
 
 int __ipipe_handle_exception(struct pt_regs *regs, long error_code, int vector)
 {
-	unsigned long flags;
+	bool restore_flags = false;
+	unsigned long flags = 0;
+	unsigned long regflags;
+	unsigned long rawflags;
 
 	/* Pick up the root domain state of the interrupted context. */
 	local_save_flags(flags);
 
-	if (ipipe_root_domain_p) {
+	if (ipipe_root_domain_p && irqs_disabled_hw()) {
 		/*
 		 * Replicate hw interrupt state into the virtual mask before
 		 * calling the I-pipe event handler over the root domain. Also
 		 * required later when calling the Linux exception handler.
 		 */
-		if (irqs_disabled_hw())
-			local_irq_disable();
+		local_irq_save(flags);
+		restore_flags = true;
 	}
 #ifdef CONFIG_KGDB
 	/* catch exception KGDB is interested in over non-root domains */
@@ -725,16 +728,32 @@ int __ipipe_handle_exception(struct pt_regs *regs, long error_code, int vector)
 #endif /* CONFIG_KGDB */
 
 	if (unlikely(ipipe_trap_notify(vector, regs))) {
-		local_irq_restore_nosync(flags);
+		if (restore_flags)
+			local_irq_restore_nosync(flags);
 		return 1;
 	}
 
-	/*
-	 * 32-bit: In case we migrated to root domain inside the event
-	 * handler, restore the original IF from exception entry as the
-	 * low-level return code will evaluate it.
-	 */
-	__fixup_if(raw_irqs_disabled_flags(flags), regs);
+	/* NOTE: We don't need a fixup when we entered via non-root domain,
+	 * and also not when we entered over a root domain with interrupts
+	 * enabled. */
+	if (restore_flags) {
+		regflags = regs->flags;
+		rawflags = __raw_local_save_flags();
+
+		printk("before fixup: rawflags: %lx, flags: %lx, "
+		       "regs->flags: %lx\n", rawflags, flags, regs->flags);
+
+		__fixup_if(raw_irqs_disabled_flags(flags), regs);
+
+		printk("after fixup: rawflags: %lx, flags: %lx, "
+		       "regs->flags: %lx\n", rawflags, flags, regs->flags);
+
+//		if (regs->flags != regflags) {
+//			dump_stack();
+//			ipipe_trace_panic_dump();
+//			panic("__fixup_if did something for real!\n");
+//		}  
+	}
 
 	if (unlikely(!ipipe_root_domain_p)) {
 		/* Detect unhandled faults over non-root domains. */
@@ -770,21 +789,26 @@ int __ipipe_handle_exception(struct pt_regs *regs, long error_code, int vector)
 	 * Relevant for 64-bit: Restore root domain state as the low-level
 	 * return code will not align it to regs.flags.
 	 */
-	local_irq_restore_nosync(flags);
+	if (restore_flags)
+		local_irq_restore_nosync(flags);
 
 	return 0;
 }
 
 int __ipipe_divert_exception(struct pt_regs *regs, int vector)
 {
-	unsigned long flags;
-
-	/* Same root state handling as in __ipipe_handle_exception. */
-	local_save_flags(flags);
+	bool restore_flags = false;
+	unsigned long flags = 0;
 
 	if (ipipe_root_domain_p) {
-		if (irqs_disabled_hw())
-			local_irq_disable();
+		if (irqs_disabled_hw()) {
+			/*
+			 * Same root state handling as in
+			 * __ipipe_handle_exception.
+			 */
+			local_irq_save(flags);
+			restore_flags = true;
+		}
 	}
 #ifdef CONFIG_KGDB
 	/* catch int1 and int3 over non-root domains */
@@ -804,16 +828,20 @@ int __ipipe_divert_exception(struct pt_regs *regs, int vector)
 #endif /* CONFIG_KGDB */
 
 	if (unlikely(ipipe_trap_notify(vector, regs))) {
-		local_irq_restore_nosync(flags);
+		if (restore_flags)
+			local_irq_restore_nosync(flags);
 		return 1;
 	}
 
+	if (likely(ipipe_root_domain_p)) {
+		/* see __ipipe_handle_exception */
+		__fixup_if(raw_irqs_disabled(), regs);
+	}
+
 	/*
-	 * 32-bit: Due to possible migration inside the event handler, we have
-	 * to restore IF so that low-level return code sets the root domain
-	 * state correctly.
+	 * No need to restore root state in the 64-bit case, the Linux handler
+	 * and the return code will take care of it.
 	 */
-	__fixup_if(raw_irqs_disabled_flags(flags), regs);
 
 	return 0;
 }

--------------050706040309050609060207--

