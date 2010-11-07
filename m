Message-ID: <4CD683DF.3000306@domain.hid>
Date: Sun, 07 Nov 2010 11:47:59 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <AANLkTinQotwe=EwATsmdKnanN-ZwT8c+CobzBRDqptEj@domain.hid>
	<4CCB4573.30607@domain.hid>
In-Reply-To: <4CCB4573.30607@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] High resolution timers disabled on AT91SAM9G20
 board	after patching
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: at91_enthus <nwromania@domain.hid>
Cc: xenomai@xenomai.org

Gilles Chanteperdrix wrote:
> at91_enthus wrote:
>> Hi!
>>
>> I installed the latest xenomai patch on a AT91SAM9G20 board and
>> everything looked good at a first glance: no compilation problems, low
>> latencies.
>>
>> However, when I typed cat /proc/timer_list , the resolutions in  cpu0
>> and cpu1 items showed 100000 (ns).
>> (I compiled the Xenomai patched kernel with High Resolution Timers enabled.)
>>
>> I don't have this problem when I boot a real time kernel (RT_PREEMPT).
> 
> You mean another real-time kernel? If RT_PREEMPT uses the sys timer
> running at 32kHz, and it tells you that it has a 1ns resolution, then it
> is lying, because 32kHz, means a 30us resolution.
> 
> Xenomai uses one TC as a timer at whatever frequency your chip proposes
> over 1 MHz, this means a resolution below 1us, the downside is that this
> also means a very short wrap time. And since the TC is also used as a
> clock, this means that we must enter the timer interrupt handler before
> the counter wraps. And this is something that Linux without Xenomai
> running can not guarantee.

On the other hand, we can keep the timer ticking behind Linux' back.
Does the following patch fix the issue for you?

diff --git a/arch/arm/mach-at91/at91_ipipe_time.c
b/arch/arm/mach-at91/at91_ipipe_time.c
index b0327eb..6c6f0d7 100644
--- a/arch/arm/mach-at91/at91_ipipe_time.c
+++ b/arch/arm/mach-at91/at91_ipipe_time.c
@@ -76,9 +76,7 @@
 #define TCNXCNS(timer,v) ((v) << ((timer)<<1))
 #define AT91_TC_REG_MASK (0xffff)

-static unsigned long next_match;
-
-static unsigned max_delta_ticks, min_delta_ticks;
+static unsigned max_delta_ticks, min_delta_ticks, tick_pending;
 static struct clock_event_device clkevt;
 static int tc_timer_clock;

@@ -116,7 +114,11 @@ EXPORT_SYMBOL(__ipipe_mach_ticks_per_jiffy);
  */
 static irqreturn_t at91_timer_interrupt(int irq, void *dev_id)
 {
-	clkevt.event_handler(&clkevt);
+	if (__ipipe_mach_timerstolen || tick_pending) {
+		tick_pending = 0;
+		clkevt.event_handler(&clkevt);
+	}
+
 	return IRQ_HANDLED;
 }

@@ -130,12 +132,8 @@ void __ipipe_mach_acktimer(void)
 {
 	at91_tc_read(AT91_TC_SR);

-	if (unlikely(!__ipipe_mach_timerstolen)) {
-		__ipipe_tsc_update();
-		next_match = (next_match + __ipipe_mach_ticks_per_jiffy)
-			& AT91_TC_REG_MASK;
-		write_RC(next_match);
-	}
+	if (unlikely(!__ipipe_mach_timerstolen))
+		__ipipe_mach_set_dec(max_delta_ticks);
 }

 static void
@@ -147,7 +145,7 @@ at91_tc_set_mode(enum clock_event_mode mode, struct
clock_event_device *dev)
 	/* Disable all interrupts. */
 	at91_tc_write(AT91_TC_IDR, ~0ul);

-	if (mode == CLOCK_EVT_MODE_PERIODIC) {
+	if (mode == CLOCK_EVT_MODE_ONESHOT) {
 		unsigned long v;

 #ifndef CONFIG_ARCH_AT91SAM9263
@@ -169,9 +167,7 @@ at91_tc_set_mode(enum clock_event_mode mode, struct
clock_event_device *dev)
 		/* Use the clock selected by at91_timer_init as input clock. */
 		at91_tc_write(AT91_TC_CMR, tc_timer_clock);

-		/* Load the TC register C. */
-		next_match = __ipipe_mach_ticks_per_jiffy;
-		write_RC(next_match);
+		__ipipe_mach_set_dec(max_delta_ticks);

 		/* Enable CPCS interrupt. */
 		at91_tc_write(AT91_TC_IER, AT91_TC_CPCS);
@@ -181,6 +177,14 @@ at91_tc_set_mode(enum clock_event_mode mode, struct
clock_event_device *dev)
 	}
 }

+static int
+at91_tc_set_next_event(unsigned long delta, struct clock_event_device *dev)
+{
+	tick_pending = 1;
+	__ipipe_mach_set_dec(delta);
+	return 0;
+}
+
 /*
  * Reprogram the timer
  */
@@ -208,10 +212,11 @@ int __ipipe_check_tickdev(const char *devname)

 static struct clock_event_device clkevt = {
 	.name		= "at91_tc" __stringify(CONFIG_IPIPE_AT91_TC),
-	.features	= CLOCK_EVT_FEAT_PERIODIC,
+	.features	= CLOCK_EVT_FEAT_ONESHOT,
 	.shift		= 20,
 	.rating		= 250,
 	.set_mode	= at91_tc_set_mode,
+	.set_next_event = at91_tc_set_next_event,
 };

 static struct __ipipe_tscinfo tsc_info = {
@@ -230,7 +235,7 @@ static struct __ipipe_tscinfo tsc_info = {

 void __ipipe_mach_release_timer(void)
 {
-	__ipipe_mach_set_dec(__ipipe_mach_ticks_per_jiffy);
+	clkevt.set_next_event(__ipipe_mach_ticks_per_jiffy, &clkevt);
 }
 EXPORT_SYMBOL(__ipipe_mach_release_timer);

@@ -293,15 +298,16 @@ void __init at91_timer_init(void)
 	clkevt.max_delta_ns = wrap_ns;
 	clkevt.min_delta_ns = 2000;
 	clkevt.cpumask = cpumask_of(0);
-	clockevents_register_device(&clkevt);
-
-	tsc_info.freq = divided_freq;
-	__ipipe_tsc_register(&tsc_info);

 	__ipipe_mach_ticks_per_jiffy = (divided_freq + HZ/2) / HZ;
 	max_delta_ticks = (wrap_ns * clkevt.mult) >> clkevt.shift;
 	min_delta_ticks = ((unsigned long long) clkevt.min_delta_ns
 			   * clkevt.mult) >> clkevt.shift;
+
+	clockevents_register_device(&clkevt);
+
+	tsc_info.freq = divided_freq;
+	__ipipe_tsc_register(&tsc_info);
 }

 #ifdef CONFIG_ARCH_AT91RM9200


-- 
                                                                Gilles.

