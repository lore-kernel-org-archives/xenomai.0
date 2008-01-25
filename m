Message-ID: <479A122D.7080509@domain.hid>
Date: Fri, 25 Jan 2008 17:45:33 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <BF58A8AFB316514587D61EADBFBF4C4101746780@domain.hid>
	<4799F056.8030005@domain.hid>
In-Reply-To: <4799F056.8030005@domain.hid>
Content-Type: multipart/mixed; boundary="------------020700070004070306020706"
Subject: Re: [Xenomai-help] x86_64 user/system process accounting
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Philippe Gerum <rpm@xenomai.org>
Cc: xenomai-help <xenomai@xenomai.org>, adeos-main <adeos-main@gna.org>

This is a multi-part message in MIME format.
--------------020700070004070306020706
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Jan Kiszka wrote:
> Kyle Howell wrote:
>>> Jan Kiszka wrote:
>>>>>>>>> Kyle Howell wrote:
>>>>>>>>> I'm running Xenomai 2.4.1 against Linux 2.6.23.12 on an
>>>>>>>>> x86_64 (Core2)
>>>>>>>>> system. I'm finding that all of my CPU cycles are being 
>>>>>>>>> accounted as kernel time rather than user time. The correct 
>>>>>>>>> processes are still billed, but the system is always 0% user. 
>>> And here comes a fix:
>>>
>>> In rthal_timer_set_oneshot() we assume that the hijacked APIC 
>>> timer will also be used to for emulating host ticks, thus 
>>> __ipipe_tick_irq is set accordingly. But this is not true for 
>>> x86-64 over non-clockevent kernels (2.6.23...), so we have to 
>>> fixup __ipipe_tick_irq with the correct number (first patch).
>> cat /proc/stat
>> cpu  9562 0 418 166028 12 0 2 0
>> cpu0 1208 0 118 20706 0 0 0 0 
>>
>> Ahh... That feels much better. Thanks a lot, Jan. I think that would
>> have taken me a long, long time to find on my own. BTW, I hope that you
>> didn't stay up until 5 in the morning on my account.
> 
> Not till 5... :->
> 
> Unfortunately I just had to learn from my colleague that the problem is
> not fully solved (for good-old 2.6.23).
> 
> So I'm banging my head against it again, and I think I understood that
> SMP can still account the load to the wrong context any CPU except the
> one that receives its ticks via RTHAL_BCAST_TICK_IRQ. Back to the
> drawing board to design a better workaround...
> 
> Jan - who's happy that 2.6.24 cleans up with the timer mess
> 

Here is a reworked patch set for this issue. It takes into account that,
on SMP, Linux receives tick IRQs both via the PIT as well as the APIC
(forwarded from the PIT). Due to this two sources, I-pipe now has to be
adopted as well. And it has to be adopted in a way, that the locally
forwarded timer IRQ is not used by I-pipe to update the registers. That
property required an extra development cycle here...

Granted, this approach is ugly. It hacks a bit of Xenomai timer usage
patterns into I-pipe, but it is currently the only solution I see. And
it is a temporary workaround for only this kernel series. Philippe, how
bad is your feeling? Anyone any better idea?

Jan

-- 
Siemens AG, Corporate Technology, CT SE 2
Corporate Competence Center Embedded Linux

--------------020700070004070306020706
Content-Type: text/x-patch;
 name="improve-tick-irq-detection-on-smp.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="improve-tick-irq-detection-on-smp.patch"

---
 arch/x86_64/kernel/ipipe.c |    4 ++++
 1 file changed, 4 insertions(+)

Index: linux-2.6.23.12-xeno_64/arch/x86_64/kernel/ipipe.c
===================================================================
--- linux-2.6.23.12-xeno_64.orig/arch/x86_64/kernel/ipipe.c
+++ linux-2.6.23.12-xeno_64/arch/x86_64/kernel/ipipe.c
@@ -750,7 +750,11 @@ int __ipipe_handle_irq(struct pt_regs *r
 
 finalize:
 
+#ifdef CONFIG_SMP
+	if (irq == __ipipe_tick_irq || regs->orig_rax == ~LOCAL_TIMER_VECTOR) {
+#else
 	if (irq == __ipipe_tick_irq) {
+#endif
 		__raw_get_cpu_var(__ipipe_tick_regs).rip = regs->rip;
 		__raw_get_cpu_var(__ipipe_tick_regs).cs = regs->cs;
 		__raw_get_cpu_var(__ipipe_tick_regs).eflags = regs->eflags;

--------------020700070004070306020706
Content-Type: text/x-patch;
 name="fixup-ipipe_tick_irq-for-legacy-x86-v2.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="fixup-ipipe_tick_irq-for-legacy-x86-v2.patch"

---
 ksrc/arch/x86/hal-common.c |   15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

Index: xenomai/ksrc/arch/x86/hal-common.c
===================================================================
--- xenomai.orig/ksrc/arch/x86/hal-common.c
+++ xenomai/ksrc/arch/x86/hal-common.c
@@ -96,14 +96,14 @@ static void rthal_timer_set_periodic(voi
 
 #if LINUX_VERSION_CODE < KERNEL_VERSION(2,6,0)
 #include <asm/smpboot.h>
-static inline void send_IPI_all(int vector)
+static inline void send_IPI_allbutself(int vector)
 {
 	unsigned long flags;
 
 	rthal_local_irq_save_hw(flags);
 	apic_wait_icr_idle();
 	apic_write_around(APIC_ICR,
-			  APIC_DM_FIXED | APIC_DEST_ALLINC | INT_DEST_ADDR_MODE
+			  APIC_DM_FIXED | APIC_DEST_ALLBUT | INT_DEST_ADDR_MODE
 			  | vector);
 	rthal_local_irq_restore_hw(flags);
 }
@@ -114,10 +114,9 @@ static inline void send_IPI_all(int vect
 DECLARE_LINUX_IRQ_HANDLER(rthal_broadcast_to_local_timers, irq, dev_id)
 {
 #ifdef CONFIG_SMP
-	send_IPI_all(LOCAL_TIMER_VECTOR);
-#else
-	rthal_trigger_irq(RTHAL_HOST_TICK_IRQ);
+	send_IPI_allbutself(LOCAL_TIMER_VECTOR);
 #endif
+	rthal_trigger_irq(RTHAL_HOST_TICK_IRQ);
 	return IRQ_HANDLED;
 }
 
@@ -236,6 +235,12 @@ int rthal_timer_request(void (*tick_hand
 			       "rthal_broadcast_timer",
 			       &rthal_broadcast_to_local_timers);
 
+	/*
+	 * rthal_timer_set_oneshot assumes the host tick flows via
+	 * RTHAL_TIMER_IRQ, but that's not the case for legacy x86_64.
+	 */
+	__ipipe_tick_irq = RTHAL_BCAST_TICK_IRQ;
+
 	rthal_nmi_init(&rthal_latency_above_max);
 out:
 	return 0;

--------------020700070004070306020706--

