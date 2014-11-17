Message-ID: <546A477B.4020602@siemens.com>
Date: Mon, 17 Nov 2014 20:07:39 +0100
From: Jan Kiszka <jan.kiszka@siemens.com>
MIME-Version: 1.0
References: <20141110202326.GU17476@sisyphus.hd.free.fr>
 <54612002.6010102@web.de> <20141110203747.GV17476@sisyphus.hd.free.fr>
 <5461232E.5000006@web.de> <20141110205512.GW17476@sisyphus.hd.free.fr>
 <20141110215846.GX17476@sisyphus.hd.free.fr>
 <20141112172738.GD17476@sisyphus.hd.free.fr> <546A26C0.1050309@siemens.com>
 <20141117165924.GM26613@sisyphus.hd.free.fr> <546A2C50.3060204@siemens.com>
 <20141117173330.GR26613@sisyphus.hd.free.fr>
In-Reply-To: <20141117173330.GR26613@sisyphus.hd.free.fr>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] "inconsistent lock state" on boot-up
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

On 2014-11-17 18:33, Gilles Chanteperdrix wrote:
> On Mon, Nov 17, 2014 at 06:11:44PM +0100, Jan Kiszka wrote:
>> On 2014-11-17 17:59, Gilles Chanteperdrix wrote:
>>> On Mon, Nov 17, 2014 at 05:48:00PM +0100, Jan Kiszka wrote:
>>>> On 2014-11-12 18:27, Gilles Chanteperdrix wrote:
>>>>> We do not need trace_hardirqs_on and trace_hardirqs_off for the
>>>>> particular case of IRQs: they are already handled by
>>>>> __ipipe_do_sync_stage. 
>>>>
>>>> That was the key: Simply disabling the instrumentations in the
>>>> CONFIG_IPIPE removes all lock state inconsistencies, at least this far:
>>>>
>>>> diff --git a/arch/arm/kernel/entry-header.S b/arch/arm/kernel/entry-header.S
>>>> index d32f8bd..d8e0b2c 100644
>>>> --- a/arch/arm/kernel/entry-header.S
>>>> +++ b/arch/arm/kernel/entry-header.S
>>>> @@ -195,7 +195,7 @@
>>>>  #ifdef CONFIG_IPIPE_DEBUG_INTERNAL
>>>>  	bl	__ipipe_bugon_irqs_enabled
>>>>  #endif
>>>> -#ifdef CONFIG_TRACE_IRQFLAGS
>>>> +#if defined(CONFIG_TRACE_IRQFLAGS) && !defined(CONFIG_IPIPE)
>>>>  	@ The parent context IRQs must have been enabled to get here in
>>>>  	@ the first place, so there's no point checking the PSR I bit.
>>>>  	bl	trace_hardirqs_on
>>>> @@ -203,7 +203,7 @@
>>>>  	.else
>>>>  	@ IRQs off again before pulling preserved data off the stack
>>>>  	disable_irq_notrace
>>>> -#ifdef CONFIG_TRACE_IRQFLAGS
>>>> +#if defined(CONFIG_TRACE_IRQFLAGS) && !defined(CONFIG_IPIPE)
>>>>  	tst	\rpsr, #PSR_I_BIT
>>>>  	bleq	trace_hardirqs_on
>>>>  	tst	\rpsr, #PSR_I_BIT
>>>>
>>>> Will send a patch.
>>>
>>> Will this work for other paths in entry.S, such as exceptions or
>>> syscalls?
>>
>> Do they all come along that code? Then we need to differentiate, likely
>> via a separate macro parameter.
>>
>> Just noticed that there is also svc_enter, and that should be handled in
>> the same way. And it's likely also shared across the board.
> 
> There are 4 macros:
> svc_enter
> svc_exit
> when entering/exiting svc mode (whether from irq, data abort,
> prefetch abort), that means reentering the
> irq/exception path when already in kerne-mode
> 
> usr_enter
> usr_exit
> when entering/exiting usr mode (whether from irq, data abort,
> prefetch abort, or syscall), which is entered from user mode.
> 
> All these paths call trace_hardirqs_on/trace_hardirqs_off
> I have not checked the details on the how and when and if, but since
> you are the one working on this, I suggest you do.
> 
> If there is a need to call the real
> trace_hardirqs_on/trace_hardirqs_off in some cases, I would very
> much prefer replacing the bl trace_hard_irqs* with a bl
> __ipipe_trace_hardirqs* sorting out the details in C, in
> arch/arm/kernel/ipipe.c, than doing this in assembly files with
> complicated #if conditions, or retrieval of the current domain
> in assembly.
> 

OK, here is another proposal: filter out tracing in kernel IRQ exit path
(that is required as we may have interrupted Linux with virtual IRQs
off), but otherwise rely on domain filtering in the respective tracing
functions:

diff --git a/arch/arm/include/asm/assembler.h b/arch/arm/include/asm/assembler.h
index 102adcb..e285269 100644
--- a/arch/arm/include/asm/assembler.h
+++ b/arch/arm/include/asm/assembler.h
@@ -130,7 +130,7 @@
 #endif
 
 	.macro asm_trace_hardirqs_off
-#if defined(CONFIG_TRACE_IRQFLAGS) && !defined(CONFIG_IPIPE)
+#if defined(CONFIG_TRACE_IRQFLAGS)
 	stmdb   sp!, {r0-r3, ip, lr}
 	bl	trace_hardirqs_off
 	ldmia	sp!, {r0-r3, ip, lr}
@@ -138,7 +138,7 @@
 	.endm
 
 	.macro asm_trace_hardirqs_on_cond, cond
-#if defined(CONFIG_TRACE_IRQFLAGS) && !defined(CONFIG_IPIPE)
+#if defined(CONFIG_TRACE_IRQFLAGS)
 	/*
 	 * actually the registers should be pushed and pop'd conditionally, but
 	 * after bl the flags are certainly clobbered
diff --git a/arch/arm/kernel/entry-header.S b/arch/arm/kernel/entry-header.S
index d32f8bd..cf2772a 100644
--- a/arch/arm/kernel/entry-header.S
+++ b/arch/arm/kernel/entry-header.S
@@ -195,7 +195,7 @@
 #ifdef CONFIG_IPIPE_DEBUG_INTERNAL
 	bl	__ipipe_bugon_irqs_enabled
 #endif
-#ifdef CONFIG_TRACE_IRQFLAGS
+#if defined(CONFIG_TRACE_IRQFLAGS) && !defined(CONFIG_IPIPE)
 	@ The parent context IRQs must have been enabled to get here in
 	@ the first place, so there's no point checking the PSR I bit.
 	bl	trace_hardirqs_on
@@ -285,7 +285,7 @@
 #ifdef CONFIG_IPIPE_DEBUG_INTERNAL
 	bl	__ipipe_bugon_irqs_enabled
 #endif
-#ifdef CONFIG_TRACE_IRQFLAGS
+#if defined(CONFIG_TRACE_IRQFLAGS) && !defined(CONFIG_IPIPE)
 	@ The parent context IRQs must have been enabled to get here in
 	@ the first place, so there's no point checking the PSR I bit.
 	bl	trace_hardirqs_on
diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index e24bb30..2e9043b 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -2559,6 +2559,9 @@ static void __trace_hardirqs_on_caller(unsigned long ip)
 
 void trace_hardirqs_on_caller(unsigned long ip)
 {
+	if (!ipipe_root_p)
+		return;
+
 	time_hardirqs_on(CALLER_ADDR0, ip);
 
 	if (unlikely(!debug_locks || current->lockdep_recursion))
@@ -2690,8 +2693,12 @@ void trace_softirqs_on(unsigned long ip)
  */
 void trace_softirqs_off(unsigned long ip)
 {
-	struct task_struct *curr = current;
+	struct task_struct *curr;
+
+	if (!ipipe_root_p)
+		return;
 
+	curr = current;
 	if (unlikely(!debug_locks || current->lockdep_recursion))
 		return;
 
diff --git a/kernel/trace/trace_irqsoff.c b/kernel/trace/trace_irqsoff.c
index 2aefbee..c3ec43f 100644
--- a/kernel/trace/trace_irqsoff.c
+++ b/kernel/trace/trace_irqsoff.c
@@ -486,28 +486,28 @@ inline void print_irqtrace_events(struct task_struct *curr)
  */
 void trace_hardirqs_on(void)
 {
-	if (!preempt_trace() && irq_trace())
+	if (ipipe_root_p && !preempt_trace() && irq_trace())
 		stop_critical_timing(CALLER_ADDR0, CALLER_ADDR1);
 }
 EXPORT_SYMBOL(trace_hardirqs_on);
 
 void trace_hardirqs_off(void)
 {
-	if (!preempt_trace() && irq_trace())
+	if (ipipe_root_p && !preempt_trace() && irq_trace())
 		start_critical_timing(CALLER_ADDR0, CALLER_ADDR1);
 }
 EXPORT_SYMBOL(trace_hardirqs_off);
 
 void trace_hardirqs_on_caller(unsigned long caller_addr)
 {
-	if (!preempt_trace() && irq_trace())
+	if (ipipe_root_p && !preempt_trace() && irq_trace())
 		stop_critical_timing(CALLER_ADDR0, caller_addr);
 }
 EXPORT_SYMBOL(trace_hardirqs_on_caller);
 
 void trace_hardirqs_off_caller(unsigned long caller_addr)
 {
-	if (!preempt_trace() && irq_trace())
+	if (ipipe_root_p && !preempt_trace() && irq_trace())
 		start_critical_timing(CALLER_ADDR0, caller_addr);
 }
 EXPORT_SYMBOL(trace_hardirqs_off_caller);


This works for ARM so far, need to revalidate x86, but it should work based on the concept. Comments?

Jan

-- 
Siemens AG, Corporate Technology, CT RTC ITP SES-DE
Corporate Competence Center Embedded Linux

