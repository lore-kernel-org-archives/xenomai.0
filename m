MIME-Version: 1.0
Date: Thu, 4 Jun 2009 13:08:21 +0200
Message-ID: <325d766d0906040408w7d9712a0gb8927529796a3913@domain.hid>
From: martin mangard <dothemango@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-core] [PATCH] Support for Atmel AT91SAM9G20 processor
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai@xenomai.org

Hello

I made a patch in order to support the Atmel AT91SAM9G20 processor,
which has to be applied after the "adeos-ipipe-2.6.27-arm-*" patch.
Due to the similarities between the AT91SAM9260 and the AT91SAM9G20
processor, only a few changes were necessary. I booted the system on a
"AT91SAM9G20-EK" development
board and executed "latencytest" and "clocktest". Are there plans to
officially support this processor in the future?

Martin

Thu Jun  4 12:19:58 UTC 2009
running: ./run -- -p 200 -t0 # latency
*
*
* Type ^C to stop this application.
*
*
== Sampling period: 200 us
== Test mode: periodic user-mode task
== All results in microseconds
warming up...
RTT|  00:00:01  (periodic user-mode task, 200 us period, priority 99)
RTH|-----lat min|-----lat avg|-----lat max|-overrun|----lat best|---lat worst
RTD|      37.790|      47.480|      71.705|       0|      37.790|      71.705
RTD|      10.658|      47.480|      74.612|       0|      10.658|      74.612
RTD|      21.317|      47.480|      71.705|       0|      10.658|      74.612
RTD|      21.317|      47.480|      71.705|       0|      10.658|      74.612
RTD|      20.348|      47.480|      71.705|       0|      10.658|      74.612
RTD|      20.348|      47.480|      71.705|       0|      10.658|      74.612
.
.

root@domain.hid# ./clocktest
== Tested clock: 0 (CLOCK_REALTIME)
CPU      ToD offset [us] ToD drift [us/s]      warps max delta [us]
--- -------------------- ---------------- ---------- --------------
  0  -1244111499212379.2           -0.040          0            0.0

--------------------


diff -urp a/arch/arm/mach-at91/at91_ipipe_time.c
b/arch/arm/mach-at91/at91_ipipe_time.c
--- a/arch/arm/mach-at91/at91_ipipe_time.c      2009-06-03
15:23:30.000000000 +0200
+++ b/arch/arm/mach-at91/at91_ipipe_time.c      2009-06-03
15:24:59.000000000 +0200
@@ -34,7 +34,7 @@
 #define AT91_ID_TC0 AT91RM9200_ID_TC0
 #define AT91_ID_TC1 AT91RM9200_ID_TC1
 #define AT91_ID_TC2 AT91RM9200_ID_TC2
-#elif defined(CONFIG_ARCH_AT91SAM9260)
+#elif defined(CONFIG_ARCH_AT91SAM9260) || defined(CONFIG_ARCH_AT91SAM9G20)
 #define AT91_ID_TC0 AT91SAM9260_ID_TC0
 #define AT91_ID_TC1 AT91SAM9260_ID_TC1
 #define AT91_ID_TC2 AT91SAM9260_ID_TC2
@@ -339,7 +339,7 @@ void __init at91_timer_init(void)
        at91_sys_write(AT91_ST_IDR, AT91_ST_PITS | AT91_ST_WDOVF |
AT91_ST_RTTINC | AT91_ST_ALMS);
        (void) at91_sys_read(AT91_ST_SR);       /* Clear any pending
interrupts */
 #elif defined(CONFIG_ARCH_AT91SAM9260) || defined(CONFIG_ARCH_AT91SAM9261) \
-       || defined(CONFIG_ARCH_AT91SAM9263) || defined(CONFIG_ARCH_AT91SAM9RL)
+       || defined(CONFIG_ARCH_AT91SAM9263) ||
defined(CONFIG_ARCH_AT91SAM9RL) || defined(CONFIG_ARCH_AT91SAM9G20)
        at91_sys_write(AT91_PIT_MR, 0);

        /* Clear any pending interrupts */
@@ -399,7 +399,7 @@ void __init at91_timer_init(void)
 #ifdef CONFIG_ARCH_AT91RM9200
 struct sys_timer at91rm9200_timer = {
 #elif defined(CONFIG_ARCH_AT91SAM9260) || defined(CONFIG_ARCH_AT91SAM9261) \
-       || defined(CONFIG_ARCH_AT91SAM9263) || defined(CONFIG_ARCH_AT91SAM9RL)
+       || defined(CONFIG_ARCH_AT91SAM9263) ||
defined(CONFIG_ARCH_AT91SAM9RL)|| defined(CONFIG_ARCH_AT91SAM9RL) ||
defined(CONFIG_ARCH_AT91SAM9G20)
 struct sys_timer at91sam926x_timer = {
 #elif defined(CONFIG_ARCH_AT91X40)
 struct sys_timer at91x40_timer = {
diff -urp a/arch/arm/mach-at91/include/mach/cpu.h
b/arch/arm/mach-at91/include/mach/cpu.h
--- a/arch/arm/mach-at91/include/mach/cpu.h     2009-06-03
15:23:30.000000000 +0200
+++ b/arch/arm/mach-at91/include/mach/cpu.h     2009-06-03
15:24:59.000000000 +0200
@@ -69,7 +69,7 @@ static inline unsigned long at91cap9_rev

 #ifdef CONFIG_ARCH_AT91SAM9260
 #define cpu_is_at91sam9xe()    (at91_arch_identify() == ARCH_FAMILY_AT91SAM9XE)
-#define cpu_is_at91sam9260()   ((at91_cpu_identify() ==
ARCH_ID_AT91SAM9260) || cpu_is_at91sam9xe())
+#define cpu_is_at91sam9260()   ((at91_cpu_identify() ==
ARCH_ID_AT91SAM9260) || cpu_is_at91sam9xe() ||
(at91_cpu_identify()==ARCH_ID_AT91SAM9G20)))
 #else
 #define cpu_is_at91sam9xe()    (0)
 #define cpu_is_at91sam9260()   (0)
diff -urp a/arch/arm/mach-at91/include/mach/hardware.h
b/arch/arm/mach-at91/include/mach/hardware.h
--- a/arch/arm/mach-at91/include/mach/hardware.h        2009-06-03
15:23:30.000000000 +0200
+++ b/arch/arm/mach-at91/include/mach/hardware.h        2009-06-03
15:24:59.000000000 +0200
@@ -64,7 +64,7 @@
 #ifdef CONFIG_IPIPE
 #if defined(CONFIG_ARCH_AT91RM9200)
 #define AT91_BASE_TCB0 AT91RM9200_BASE_TCB0
-#elif defined(CONFIG_ARCH_AT91SAM9260)
+#elif defined(CONFIG_ARCH_AT91SAM9260) || defined(CONFIG_ARCH_AT91SAM9G20)
 #define AT91_BASE_TCB0 AT91SAM9260_BASE_TCB0
 #elif defined(CONFIG_ARCH_AT91SAM9261)
 #define AT91_BASE_TCB0 AT91SAM9261_BASE_TCB0
diff -urp a/arch/arm/mach-at91/include/mach/irqs.h
b/arch/arm/mach-at91/include/mach/irqs.h
--- a/arch/arm/mach-at91/include/mach/irqs.h    2009-06-03
15:23:30.000000000 +0200
+++ b/arch/arm/mach-at91/include/mach/irqs.h    2009-06-03
15:24:59.000000000 +0200
@@ -52,7 +52,7 @@ extern unsigned __ipipe_at91_gpio_banks;
 #define __ipipe_mach_irq_mux_p(irq)                                    \
        ((unsigned) (irq - AT91RM9200_ID_PIOA) < __ipipe_at91_gpio_banks)

-#elif defined(CONFIG_ARCH_AT91SAM9260)
+#elif defined(CONFIG_ARCH_AT91SAM9260) || defined(CONFIG_ARCH_AT91SAM9G20)
 #define __ipipe_mach_irq_mux_p(irq)                                    \
        ((unsigned) (irq - AT91SAM9260_ID_PIOA) < __ipipe_at91_gpio_banks)

diff -urp a/arch/arm/mach-at91/Makefile b/arch/arm/mach-at91/Makefile
--- a/arch/arm/mach-at91/Makefile       2009-06-03 15:23:30.000000000 +0200
+++ b/arch/arm/mach-at91/Makefile       2009-06-03 15:24:59.000000000 +0200
@@ -82,6 +82,7 @@ ifeq ($(CONFIG_IPIPE),y)
 obj-y := $(filter-out at91rm9200_time.o at91sam926x_time.o
at91x40_time.o, $(obj-y))
 obj-$(CONFIG_ARCH_AT91RM9200)   += at91_ipipe_time.o
 obj-$(CONFIG_ARCH_AT91SAM9260)  += at91_ipipe_time.o
+obj-$(CONFIG_ARCH_AT91SAM9G20)  += at91_ipipe_time.o
 obj-$(CONFIG_ARCH_AT91SAM9261)  += at91_ipipe_time.o
 obj-$(CONFIG_ARCH_AT91SAM9263) += at91_ipipe_time.o
 obj-$(CONFIG_ARCH_AT91SAM9RL)  += at91_ipipe_time.o

