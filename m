Message-ID: <4F312091.5080001@domain.hid>
Date: Tue, 07 Feb 2012 14:01:05 +0100
From: Gregory CLEMENT <gregory.clement@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------020006090406070104000400"
Subject: [Xenomai-core] [RFC] Port to AT91SAM9G45
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai@xenomai.org
Cc: Thomas Petazzoni <thomas.petazzoni@domain.hid>, Maxime Ripard <maxime.ripard@domain.hid>, Nicolas Ferre <nicolas.ferre@domain.hid>

This is a multi-part message in MIME format.
--------------020006090406070104000400
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Hello,

I've done the port for AT91SAM9G45 on a AT91SAM9M10G45-EK board. The
following patch have to be applied on top of the
adeos-ipipe-2.6.38.8-arm-1.18-04.patch patch.

I also ran latency test under heavy stress using:
- hackbench to stress the scheduler
- netcat to stress the Ethernet interface and generate a lot of interrupts
- ls and dd( reading a /dev/mtdblock and writing on a tmpfs) for global stress

I join the results I had after running each latency test during 10 hours.

If the results I get seem the correct could you apply this patch in
Xenomai?

Should I also submit this patch to adeos project?

Regards
-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
+33 602 196 044

--------------020006090406070104000400
Content-Type: text/x-diff;
 name="0001-Adeos-Xenomai-port-for-AT91SAM9M10G45-EK.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="0001-Adeos-Xenomai-port-for-AT91SAM9M10G45-EK.patch"

>From 39a2100b7bc34755d22409ea1f0d23a94bd99ed8 Mon Sep 17 00:00:00 2001
From: Gregory CLEMENT <gregory.clement@domain.hid>
Date: Sat, 29 Oct 2011 19:16:57 +0200
Subject: [PATCH 1/1] Adeos / Xenomai port for AT91SAM9M10G45-EK


Signed-off-by: Gregory CLEMENT <gregory.clement@domain.hid>
---
 arch/arm/mach-at91/Makefile                |    1 +
 arch/arm/mach-at91/at91_ipipe_time.c       |   23 +++++++++----
 arch/arm/mach-at91/at91sam9g45.c           |   50 +++++++++++++++++++++++++++-
 arch/arm/mach-at91/include/mach/hardware.h |    2 +
 4 files changed, 68 insertions(+), 8 deletions(-)

diff --git a/arch/arm/mach-at91/Makefile b/arch/arm/mach-at91/Makefile
index 5e11f9f..99c487d 100644
--- a/arch/arm/mach-at91/Makefile
+++ b/arch/arm/mach-at91/Makefile
@@ -105,4 +105,5 @@ obj-$(CONFIG_ARCH_AT91SAM9263)	+= at91_ipipe_time.o
 obj-$(CONFIG_ARCH_AT91SAM9RL)	+= at91_ipipe_time.o
 obj-$(CONFIG_ARCH_AT91SAM9G20)  += at91_ipipe_time.o
 obj-$(CONFIG_ARCH_AT91X40)	+= at91_ipipe_time.o
+obj-$(CONFIG_ARCH_AT91SAM9G45)	+= at91_ipipe_time.o
 endif
diff --git a/arch/arm/mach-at91/at91_ipipe_time.c b/arch/arm/mach-at91/at91_ipipe_time.c
index b0aa6a4..2e97a28 100644
--- a/arch/arm/mach-at91/at91_ipipe_time.c
+++ b/arch/arm/mach-at91/at91_ipipe_time.c
@@ -6,6 +6,9 @@
  * Adaptation to AT91SAM926x:
  * Copyright (C) 2007 Gregory CLEMENT, Adeneo
  *
+ * Adaptation to AT91SAM9G45:
+ * Copyright (C) 2011 Gregory CLEMENT, Free Electrons
+ *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License version 2 as
  * published by the Free Software Foundation.
@@ -55,6 +58,10 @@
 #define AT91_ID_TC0 AT91X40_ID_TC0
 #define AT91_ID_TC1 AT91X40_ID_TC1
 #define AT91_ID_TC2 AT91X40_ID_TC2
+#elif defined(CONFIG_ARCH_AT91SAM9G45)
+#define AT91_ID_TC0 AT91SAM9G45_ID_TCB
+#define AT91_ID_TC1 AT91SAM9G45_ID_TCB
+#define AT91_ID_TC2 AT91SAM9G45_ID_TCB
 #else
 #error "AT91 processor unsupported by Adeos"
 #endif
@@ -146,12 +153,14 @@ at91_tc_set_mode(enum clock_event_mode mode, struct clock_event_device *dev)
 	if (mode == CLOCK_EVT_MODE_PERIODIC) {
 		unsigned long v;
 
-#ifndef CONFIG_ARCH_AT91SAM9263
-		clk_enable(clk_get(NULL, "tc"
-				   __stringify(CONFIG_IPIPE_AT91_TC) "_clk"));
-#else /* AT91SAM9263 */
+#ifdef CONFIG_ARCH_AT91SAM9263
 		clk_enable(clk_get(NULL, "tcb_clk"));
-#endif /* AT91SAM9263 */
+#elif CONFIG_ARCH_AT91SAM9G45
+		clk_enable(clk_get(NULL, "tcb0_clk"));
+#else /* AT91SAM9263 and AT91SAM9G45*/
+		clk_enable(clk_get(NULL, "tc"
+						   __stringify(CONFIG_IPIPE_AT91_TC) "_clk"));
+#endif 
 
 		/* No Sync. */
 		at91_tc_write(AT91_TC_BCR, 0);
@@ -246,7 +255,7 @@ void __init at91_timer_init(void)
 	(void) at91_sys_read(AT91_ST_SR);	/* Clear any pending interrupts */
 #elif defined(CONFIG_ARCH_AT91SAM9260) || defined(CONFIG_ARCH_AT91SAM9261) \
 	|| defined(CONFIG_ARCH_AT91SAM9263) || defined(CONFIG_ARCH_AT91SAM9RL) \
-	|| defined(CONFIG_ARCH_AT91SAM9G20)
+	|| defined(CONFIG_ARCH_AT91SAM9G20) || defined(CONFIG_ARCH_AT91SAM9G45)
 	at91_sys_write(AT91_PIT_MR, 0);
 
 	/* Clear any pending interrupts */
@@ -303,7 +312,7 @@ void __init at91_timer_init(void)
 struct sys_timer at91rm9200_timer = {
 #elif defined(CONFIG_ARCH_AT91SAM9260) || defined(CONFIG_ARCH_AT91SAM9261) \
 	|| defined(CONFIG_ARCH_AT91SAM9263) || defined(CONFIG_ARCH_AT91SAM9RL) \
-	|| defined(CONFIG_ARCH_AT91SAM9G20)
+	|| defined(CONFIG_ARCH_AT91SAM9G20) || defined(CONFIG_ARCH_AT91SAM9G45)
 struct sys_timer at91sam926x_timer = {
 #elif defined(CONFIG_ARCH_AT91X40)
 struct sys_timer at91x40_timer = {
diff --git a/arch/arm/mach-at91/at91sam9g45.c b/arch/arm/mach-at91/at91sam9g45.c
index c67b47f..d0ef1af 100644
--- a/arch/arm/mach-at91/at91sam9g45.c
+++ b/arch/arm/mach-at91/at91sam9g45.c
@@ -31,7 +31,16 @@ static struct map_desc at91sam9g45_io_desc[] __initdata = {
 		.pfn		= __phys_to_pfn(AT91_BASE_SYS),
 		.length		= SZ_16K,
 		.type		= MT_DEVICE,
-	}, {
+	},
+#ifdef CONFIG_IPIPE
+	{
+		.virtual	= AT91_VA_BASE_TCB0,
+		.pfn		= __phys_to_pfn(AT91_BASE_TCB0),
+		.length		= SZ_16K,
+		.type		= MT_DEVICE,
+	},
+#endif /* CONFIG_IPIPE */
+	{
 		.virtual	= AT91_IO_VIRT_BASE - AT91SAM9G45_SRAM_SIZE,
 		.pfn		= __phys_to_pfn(AT91SAM9G45_SRAM_BASE),
 		.length		= AT91SAM9G45_SRAM_SIZE,
@@ -332,6 +341,7 @@ void __init at91sam9g45_initialize(unsigned long main_clock)
 /*
  * The default interrupt priority levels (0 = lowest, 7 = highest).
  */
+#ifndef CONFIG_IPIPE
 static unsigned int at91sam9g45_default_irq_priority[NR_AIC_IRQS] __initdata = {
 	7,	/* Advanced Interrupt Controller (FIQ) */
 	7,	/* System Peripherals */
@@ -366,6 +376,44 @@ static unsigned int at91sam9g45_default_irq_priority[NR_AIC_IRQS] __initdata = {
 	0,
 	0,	/* Advanced Interrupt Controller (IRQ0) */
 };
+#else
+static unsigned int at91sam9g45_default_irq_priority[NR_AIC_IRQS] __initdata = {
+/* Give the highest priority to TC, since they are used as timer interrupt by
+   I-pipe. */
+	7,	/* Advanced Interrupt Controller (FIQ) */
+	6,	/* System Peripherals */
+	0,	/* Parallel IO Controller A */
+	0,	/* Parallel IO Controller B */
+	0,	/* Parallel IO Controller C */
+	0,	/* Parallel IO Controller D and E */
+	0,
+	5,	/* USART 0 */
+	5,	/* USART 1 */
+	5,	/* USART 2 */
+	5,	/* USART 3 */
+	0,	/* Multimedia Card Interface 0 */
+	6,	/* Two-Wire Interface 0 */
+	6,	/* Two-Wire Interface 1 */
+	5,	/* Serial Peripheral Interface 0 */
+	5,	/* Serial Peripheral Interface 1 */
+	4,	/* Serial Synchronous Controller 0 */
+	4,	/* Serial Synchronous Controller 1 */
+	7,	/* Timer Counter 0, 1, 2, 3, 4 and 5 */
+	0,	/* Pulse Width Modulation Controller */
+	0,	/* Touch Screen Controller */
+	0,	/* DMA Controller */
+	2,	/* USB Host High Speed port */
+	3,	/* LDC Controller */
+	5,	/* AC97 Controller */
+	2,	/* Ethernet */
+	0,	/* Image Sensor Interface */
+	2,	/* USB Device High speed port */
+	0,
+	0,	/* Multimedia Card Interface 1 */
+	0,
+	0,	/* Advanced Interrupt Controller (IRQ0) */
+};
+#endif
 
 void __init at91sam9g45_init_interrupts(unsigned int priority[NR_AIC_IRQS])
 {
diff --git a/arch/arm/mach-at91/include/mach/hardware.h b/arch/arm/mach-at91/include/mach/hardware.h
index 6aa41bd..5a1faa4 100644
--- a/arch/arm/mach-at91/include/mach/hardware.h
+++ b/arch/arm/mach-at91/include/mach/hardware.h
@@ -76,6 +76,8 @@
 #define AT91_BASE_TCB0 AT91SAM9263_BASE_TCB0
 #elif defined(CONFIG_ARCH_AT91SAM9RL)
 #define AT91_BASE_TCB0 AT91SAM9RL_BASE_TCB0
+#elif defined(CONFIG_ARCH_AT91SAM9G45)
+#define AT91_BASE_TCB0 AT91SAM9G45_BASE_TCB0
 #elif defined(CONFIG_ARCH_AT91X40)
 #define AT91_BASE_TCB0 (AT91_BASE_SYS + AT91_TC)
 #else
-- 
1.7.5.4


--------------020006090406070104000400
Content-Type: text/plain;
 name="latency_G45_2_6_38_t0P99.histo"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="latency_G45_2_6_38_t0P99.histo"

#latency -h -H10000 -P99 -T36000 -q
#Linux buildroot 2.6.38.8-ipipe+ #14 Sat Jan 28 11:16:02 CET 2012 armv5tejl GNU/Linux
#Hardware	: Atmel AT91SAM9M10G45-EK
#Sat Jan 28 12:04:19 UTC 2012
== Sampling period: 1000 us
== Test mode: periodic user-mode task
== All results in microseconds
warming up...
---|--param|----range-|--samples
HSD|    min|   6 -  7 |        3
HSD|    min|   7 -  8 |       27
HSD|    min|   8 -  9 |       26
HSD|    min|   9 - 10 |       54
HSD|    min|  10 - 11 |       62
HSD|    min|  11 - 12 |      469
HSD|    min|  12 - 13 |     9983
HSD|    min|  13 - 14 |     3061
HSD|    min|  14 - 15 |      535
HSD|    min|  15 - 16 |      474
HSD|    min|  16 - 17 |    14335
HSD|    min|  17 - 18 |     2864
HSD|    min|  18 - 19 |       83
HSD|    min|  19 - 20 |      102
HSD|    min|  20 - 21 |      149
HSD|    min|  21 - 22 |      236
HSD|    min|  22 - 23 |      593
HSD|    min|  23 - 24 |     1369
HSD|    min|  24 - 25 |     1579
HSD|    min|  25 - 26 |       18
---|--param|----range-|--samples
HSD|    avg|   6 -  7 |        3
HSD|    avg|   7 -  8 |       27
HSD|    avg|   8 -  9 |       26
HSD|    avg|   9 - 10 |       54
HSD|    avg|  10 - 11 |       64
HSD|    avg|  11 - 12 |      511
HSD|    avg|  12 - 13 |    26617
HSD|    avg|  13 - 14 |   122411
HSD|    avg|  14 - 15 |   167680
HSD|    avg|  15 - 16 |    90841
HSD|    avg|  16 - 17 |   130975
HSD|    avg|  17 - 18 |   871894
HSD|    avg|  18 - 19 |  1567835
HSD|    avg|  19 - 20 |  1012704
HSD|    avg|  20 - 21 |   462635
HSD|    avg|  21 - 22 |   330985
HSD|    avg|  22 - 23 |   260165
HSD|    avg|  23 - 24 |   207662
HSD|    avg|  24 - 25 |   803199
HSD|    avg|  25 - 26 |  1041358
HSD|    avg|  26 - 27 |  1496782
HSD|    avg|  27 - 28 |  1648069
HSD|    avg|  28 - 29 |  1528806
HSD|    avg|  29 - 30 |  1344712
HSD|    avg|  30 - 31 |  1228529
HSD|    avg|  31 - 32 |  1192578
HSD|    avg|  32 - 33 |  1233130
HSD|    avg|  33 - 34 |  1391391
HSD|    avg|  34 - 35 |  1695087
HSD|    avg|  35 - 36 |  1848138
HSD|    avg|  36 - 37 |  1585976
HSD|    avg|  37 - 38 |  1140751
HSD|    avg|  38 - 39 |   810908
HSD|    avg|  39 - 40 |   628806
HSD|    avg|  40 - 41 |   545506
HSD|    avg|  41 - 42 |   503237
HSD|    avg|  42 - 43 |   468760
HSD|    avg|  43 - 44 |   443660
HSD|    avg|  44 - 45 |   431859
HSD|    avg|  45 - 46 |   427111
HSD|    avg|  46 - 47 |   420952
HSD|    avg|  47 - 48 |   412731
HSD|    avg|  48 - 49 |   826800
HSD|    avg|  49 - 50 |   395329
HSD|    avg|  50 - 51 |   352988
HSD|    avg|  51 - 52 |   317180
HSD|    avg|  52 - 53 |   321910
HSD|    avg|  53 - 54 |   393739
HSD|    avg|  54 - 55 |   469109
HSD|    avg|  55 - 56 |   463052
HSD|    avg|  56 - 57 |   394260
HSD|    avg|  57 - 58 |   386105
HSD|    avg|  58 - 59 |   451223
HSD|    avg|  59 - 60 |   537194
HSD|    avg|  60 - 61 |   535551
HSD|    avg|  61 - 62 |   285997
HSD|    avg|  62 - 63 |    73908
HSD|    avg|  63 - 64 |     9989
HSD|    avg|  64 - 65 |      964
HSD|    avg|  65 - 66 |      279
HSD|    avg|  66 - 67 |      143
HSD|    avg|  67 - 68 |      175
HSD|    avg|  68 - 69 |      254
HSD|    avg|  69 - 70 |      439
HSD|    avg|  70 - 71 |     1058
HSD|    avg|  71 - 72 |     2388
HSD|    avg|  72 - 73 |    12946
HSD|    avg|  73 - 74 |    12284
HSD|    avg|  74 - 75 |    16676
HSD|    avg|  75 - 76 |    20187
HSD|    avg|  76 - 77 |    23038
HSD|    avg|  77 - 78 |    24877
HSD|    avg|  78 - 79 |    25970
HSD|    avg|  79 - 80 |    25903
HSD|    avg|  80 - 81 |    24656
HSD|    avg|  81 - 82 |    21763
HSD|    avg|  82 - 83 |    19175
HSD|    avg|  83 - 84 |    15099
HSD|    avg|  84 - 85 |    11054
HSD|    avg|  85 - 86 |     7001
HSD|    avg|  86 - 87 |     4133
HSD|    avg|  87 - 88 |     2609
HSD|    avg|  88 - 89 |     1642
HSD|    avg|  89 - 90 |     1176
HSD|    avg|  90 - 91 |      956
HSD|    avg|  91 - 92 |      859
HSD|    avg|  92 - 93 |      845
HSD|    avg|  93 - 94 |      835
HSD|    avg|  94 - 95 |      815
HSD|    avg|  95 - 96 |      790
HSD|    avg|  96 - 97 |     1244
HSD|    avg|  97 - 98 |      436
HSD|    avg|  98 - 99 |      344
HSD|    avg|  99 -100 |      228
HSD|    avg| 100 -101 |      145
HSD|    avg| 101 -102 |       73
HSD|    avg| 102 -103 |       28
HSD|    avg| 103 -104 |       21
HSD|    avg| 104 -105 |        7
HSD|    avg| 105 -106 |        1
HSD|    avg| 106 -107 |        2
HSD|    avg| 108 -109 |        2
HSD|    avg| 110 -111 |        2
HSD|    avg| 112 -113 |        6
HSD|    avg| 114 -115 |        2
HSD|    avg| 115 -116 |        2
HSD|    avg| 118 -119 |        1
---|--param|----range-|--samples
HSD|    max|  60 - 61 |       10
HSD|    max|  61 - 62 |       74
HSD|    max|  62 - 63 |      313
HSD|    max|  63 - 64 |      139
HSD|    max|  64 - 65 |       15
HSD|    max|  65 - 66 |        2
HSD|    max|  67 - 68 |        5
HSD|    max|  68 - 69 |        5
HSD|    max|  69 - 70 |        3
HSD|    max|  70 - 71 |        7
HSD|    max|  71 - 72 |       11
HSD|    max|  72 - 73 |       70
HSD|    max|  73 - 74 |       86
HSD|    max|  74 - 75 |      138
HSD|    max|  75 - 76 |      192
HSD|    max|  76 - 77 |      291
HSD|    max|  77 - 78 |      464
HSD|    max|  78 - 79 |      705
HSD|    max|  79 - 80 |     1152
HSD|    max|  80 - 81 |     1721
HSD|    max|  81 - 82 |     2541
HSD|    max|  82 - 83 |     3501
HSD|    max|  83 - 84 |     4220
HSD|    max|  84 - 85 |     4379
HSD|    max|  85 - 86 |     3639
HSD|    max|  86 - 87 |     2495
HSD|    max|  87 - 88 |     1833
HSD|    max|  88 - 89 |     1154
HSD|    max|  89 - 90 |      812
HSD|    max|  90 - 91 |      675
HSD|    max|  91 - 92 |      601
HSD|    max|  92 - 93 |      595
HSD|    max|  93 - 94 |      623
HSD|    max|  94 - 95 |      623
HSD|    max|  95 - 96 |      645
HSD|    max|  96 - 97 |     1050
HSD|    max|  97 - 98 |      399
HSD|    max|  98 - 99 |      330
HSD|    max|  99 -100 |      221
HSD|    max| 100 -101 |      139
HSD|    max| 101 -102 |       70
HSD|    max| 102 -103 |       28
HSD|    max| 103 -104 |       21
HSD|    max| 104 -105 |        7
HSD|    max| 105 -106 |        1
HSD|    max| 106 -107 |        2
HSD|    max| 108 -109 |        2
HSD|    max| 110 -111 |        2
HSD|    max| 112 -113 |        6
HSD|    max| 114 -115 |        2
HSD|    max| 115 -116 |        2
HSD|    max| 118 -119 |        1
HSH|--param|--samples-|--average--|---stddev--
HSS|    min|     36022|     15.356|      3.328
HSS|    avg|  36022992|     35.033|     12.226
HSS|    max|     36022|     84.741|      5.864
---|-----------|-----------|-----------|--------|------|-------------------------
RTS|      6.720|     34.560|    118.080|       0|     0|    10:00:01/10:00:00

--------------020006090406070104000400
Content-Type: text/plain;
 name="latency_G45_2_6_38_t1P99.histo"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="latency_G45_2_6_38_t1P99.histo"

#latency -h -H10000 -t1 -P99 -T36000 -q
#Linux buildroot 2.6.38.8-ipipe+ #14 Sat Jan 28 11:16:02 CET 2012 armv5tejl GNU/Linux
#Hardware	: Atmel AT91SAM9M10G45-EK
#Sat Jan 28 22:22:07 UTC 2012
== Sampling period: 1000 us
== Test mode: in-kernel periodic task
== All results in microseconds
warming up...
---|--param|----range-|--samples
HSD|    min|   1 -  2 |        9
HSD|    min|   2 -  3 |      122
HSD|    min|   3 -  4 |      554
HSD|    min|   4 -  5 |      781
HSD|    min|   5 -  6 |    22946
HSD|    min|   6 -  7 |     7565
HSD|    min|   7 -  8 |      116
HSD|    min|   8 -  9 |      158
HSD|    min|   9 - 10 |     1014
HSD|    min|  10 - 11 |     1823
HSD|    min|  11 - 12 |      871
HSD|    min|  12 - 13 |       40
---|--param|----range-|--samples
HSD|    avg|   1 -  2 |        9
HSD|    avg|   2 -  3 |      138
HSD|    avg|   3 -  4 |      788
HSD|    avg|   4 -  5 |     6285
HSD|    avg|   5 -  6 |    75361
HSD|    avg|   6 -  7 |   775370
HSD|    avg|   7 -  8 |  2033507
HSD|    avg|   8 -  9 |  1381455
HSD|    avg|   9 - 10 |   521105
HSD|    avg|  10 - 11 |   408089
HSD|    avg|  11 - 12 |   665579
HSD|    avg|  12 - 13 |  1219318
HSD|    avg|  13 - 14 |  1833313
HSD|    avg|  14 - 15 |  2076036
HSD|    avg|  15 - 16 |  1888881
HSD|    avg|  16 - 17 |  1699859
HSD|    avg|  17 - 18 |  1872624
HSD|    avg|  18 - 19 |  2387416
HSD|    avg|  19 - 20 |  2625741
HSD|    avg|  20 - 21 |  2206943
HSD|    avg|  21 - 22 |  1556005
HSD|    avg|  22 - 23 |  1126595
HSD|    avg|  23 - 24 |   909726
HSD|    avg|  24 - 25 |   780931
HSD|    avg|  25 - 26 |   714237
HSD|    avg|  26 - 27 |   674654
HSD|    avg|  27 - 28 |   642520
HSD|    avg|  28 - 29 |   593225
HSD|    avg|  29 - 30 |   530720
HSD|    avg|  30 - 31 |   527904
HSD|    avg|  31 - 32 |   633116
HSD|    avg|  32 - 33 |   697423
HSD|    avg|  33 - 34 |   582188
HSD|    avg|  34 - 35 |   526800
HSD|    avg|  35 - 36 |   673251
HSD|    avg|  36 - 37 |   650858
HSD|    avg|  37 - 38 |   367050
HSD|    avg|  38 - 39 |   110753
HSD|    avg|  39 - 40 |    17012
HSD|    avg|  40 - 41 |     2761
HSD|    avg|  41 - 42 |     1112
HSD|    avg|  42 - 43 |     1202
HSD|    avg|  43 - 44 |     1170
HSD|    avg|  44 - 45 |      631
HSD|    avg|  45 - 46 |      220
HSD|    avg|  46 - 47 |       38
HSD|    avg|  47 - 48 |        1
---|--param|----range-|--samples
HSD|    max|  36 - 37 |       19
HSD|    max|  37 - 38 |     2429
HSD|    max|  38 - 39 |    18502
HSD|    max|  39 - 40 |    11208
HSD|    max|  40 - 41 |     1928
HSD|    max|  41 - 42 |      382
HSD|    max|  42 - 43 |      298
HSD|    max|  43 - 44 |      534
HSD|    max|  44 - 45 |      459
HSD|    max|  45 - 46 |      201
HSD|    max|  46 - 47 |       38
HSD|    max|  47 - 48 |        1
HSH|--param|--samples-|--average--|---stddev--
HSS|    min|     35999|      5.685|      1.598
HSS|    avg|  35999920|     18.913|      7.918
HSS|    max|     35999|     38.613|      1.273
---|-----------|-----------|-----------|--------|------|-------------------------
RTS|      1.087|     19.414|     47.028|       0|     0|    10:00:00/10:00:00

--------------020006090406070104000400
Content-Type: text/plain;
 name="latency_G45_2_6_38_t2P99.histo"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="latency_G45_2_6_38_t2P99.histo"

#latency -h -H10000 -t2 -P99 -T36000 -q
#Linux buildroot 2.6.38.8-ipipe+ #14 Sat Jan 28 11:16:02 CET 2012 armv5tejl GNU/Linux
#Hardware	: Atmel AT91SAM9M10G45-EK
#Sun Jan 29 11:38:03 UTC 2012
== Sampling period: 1000 us
== Test mode: in-kernel timer handler
== All results in microseconds
warming up...
---|--param|----range-|--samples
HSD|    min|   0 -  1 |    30232
HSD|    min|   1 -  2 |     1519
HSD|    min|   2 -  3 |     3788
HSD|    min|   3 -  4 |      460
---|--param|----range-|--samples
HSD|    avg|   0 -  1 |  1171259
HSD|    avg|   1 -  2 |  2503719
HSD|    avg|   2 -  3 |  1848074
HSD|    avg|   3 -  4 |  1712780
HSD|    avg|   4 -  5 |  3866542
HSD|    avg|   5 -  6 |  5557702
HSD|    avg|   6 -  7 |  5797546
HSD|    avg|   7 -  8 |  4829265
HSD|    avg|   8 -  9 |  2703813
HSD|    avg|   9 - 10 |  1468521
HSD|    avg|  10 - 11 |  1106197
HSD|    avg|  11 - 12 |  1148150
HSD|    avg|  12 - 13 |  1112179
HSD|    avg|  13 - 14 |   792870
HSD|    avg|  14 - 15 |   319700
HSD|    avg|  15 - 16 |    56221
HSD|    avg|  16 - 17 |     4490
HSD|    avg|  17 - 18 |      693
HSD|    avg|  18 - 19 |       91
HSD|    avg|  19 - 20 |       16
HSD|    avg|  20 - 21 |        1
HSD|    avg|  21 - 22 |        1
---|--param|----range-|--samples
HSD|    max|  12 - 13 |        3
HSD|    max|  13 - 14 |      331
HSD|    max|  14 - 15 |     9451
HSD|    max|  15 - 16 |    21368
HSD|    max|  16 - 17 |     4053
HSD|    max|  17 - 18 |      686
HSD|    max|  18 - 19 |       90
HSD|    max|  19 - 20 |       15
HSD|    max|  20 - 21 |        1
HSD|    max|  21 - 22 |        1
HSH|--param|--samples-|--average--|---stddev--
HSS|    min|     35999|      0.291|      0.702
HSS|    avg|  35999830|      5.855|      3.117
HSS|    max|     35999|     14.879|      0.711
---|-----------|-----------|-----------|--------|------|-------------------------
RTS|     -3.835|      6.343|     21.106|       0|     0|    10:00:01/10:00:00

--------------020006090406070104000400--

