Message-ID: <50102E8D.1040004@xenomai.org>
Date: Wed, 25 Jul 2012 19:36:13 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <CE2E43470FE5444A811B580382FE5EDF2113D8D95A@KEMPMAIL2.woodward.com>	<5009A292.4060508@grandegger.com>	<CE2E43470FE5444A811B580382FE5EDF2113EA8DE7@KEMPMAIL2.woodward.com>
	<501028DC.8000803@xenomai.org>
In-Reply-To: <501028DC.8000803@xenomai.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Xenomai installation on P1020RDB
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Lukasz Zemla <Lukasz.Zemla@woodward.com>
Cc: "Xenomai@xenomai.org" <Xenomai@xenomai.org>

On 07/25/2012 07:11 PM, Gilles Chanteperdrix wrote:

> On 07/25/2012 06:18 PM, Lukasz Zemla wrote:
> 
>> I tried to install Xenomai on 3.2.21 - it boots, but waits about 76 seconds after initialization of first eth0 controller: 
>>
>> 	[    0.905820] fsl-gianfar ethernet.1: eth0: TX BD ring size for Q[7]: 256
>> 	[   77.451135] fsl-gianfar ethernet.2: eth1: mac: 00:04:9f:02:2d:11
>>
>> There is no delay between eth1 and eth2. 
>>
>> The vanilla 3.2.21 does not have any delays - it initializes eth0, eth1, eth2 immediately.
>>
>> [...]
> 
> 
> It is very much likely a timer issue. At the time it happens, is xenomai
> started ?
> 


Also, it would be interesting to know a bit more about your kernel 
configuration, at least whether the following options are enabled:
CONFIG_HIGH_RES_TIMERS
CONFIG_NO_HZ
CONFIG_XENO_OPT_WATCHDOG

If the first two are on and the third is off, try the following patch:

diff --git a/arch/powerpc/kernel/time.c b/arch/powerpc/kernel/time.c
index 3ca10829..a752ca7 100644
--- a/arch/powerpc/kernel/time.c
+++ b/arch/powerpc/kernel/time.c
@@ -469,6 +469,14 @@ void arch_irq_work_raise(void)
 
 #endif /* CONFIG_IRQ_WORK */
 
+static inline void timer_ack(void)
+{
+	/* Ensure a positive value is written to the decrementer, or else
+	 * some CPUs will continue to take decrementer exceptions.
+	 */
+	set_dec(DECREMENTER_MAX);
+}
+
 /*
  * timer_interrupt - gets called when the decrementer overflows,
  * with interrupts disabled.
@@ -480,11 +488,8 @@ void timer_interrupt(struct pt_regs * regs)
 	struct clock_event_device *evt = &__get_cpu_var(decrementers);
 	u64 now;
 
-	/* Ensure a positive value is written to the decrementer, or else
-	 * some CPUs will continue to take decrementer exceptions.
-	 */
 	if (!clockevent_ipipe_stolen(evt))
-		set_dec(DECREMENTER_MAX);
+		timer_ack();
 
 	/* Some implementations of hotplug will get timer interrupts while
 	 * offline, just ignore these
@@ -836,6 +841,7 @@ static void register_decrementer_clockevent(int cpu)
 	dec->ipipe_timer = &per_cpu(itimers, cpu);
 	dec->ipipe_timer->irq = IPIPE_TIMER_VIRQ;
 	dec->ipipe_timer->set = itimer_set;
+	dec->ipipe_timer->ack = timer_ack;
 	dec->ipipe_timer->min_delay_ticks = 3;
 #endif /* CONFIG_IPIPE */
 


-- 
                                                                Gilles.

