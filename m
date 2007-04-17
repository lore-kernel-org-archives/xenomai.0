From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="Cj5BZXUA+r"
Content-Transfer-Encoding: 7bit
Message-ID: <17957.16218.913465.449254@domain.hid>
Date: Tue, 17 Apr 2007 23:42:50 +0200
In-Reply-To: <461CD163.1020500@domain.hid>
References: <305035a40704100947n5d426f9ahf8608957a2264f2f@domain.hid>
	<461BC626.3070403@domain.hid>
	<305035a40704110201i1ea65f11j162eecc46858f5ca@domain.hid>
	<461CA604.4050809@domain.hid>
	<305035a40704110221u348611ebs8fb73b7ddb0f8bd3@domain.hid>
	<461CD163.1020500@domain.hid>
Subject: Re: [Adeos-main] AT91SAM9261 adeos support for 2.6.19 kernel
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: </public/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: adeos-main <adeos-main@gna.org>


--Cj5BZXUA+r
Content-Type: text/plain; charset=us-ascii
Content-Description: message body and .signature
Content-Transfer-Encoding: 7bit

Gilles Chanteperdrix wrote:
 > Gregory CLEMENT wrote:
 > > Maybe we can try to make a diff between
 > > at91 patched kernel +adeos patch  and at91 patched kernel + our patch ?
 > > But with this solution we have to made some modification on adeos
 > > patch for applying it on at91 patched kernel.
 > > 
 > > Last solution is to attach the file modified.
 > 
 > diff between adeos patched kernel + at91 patch and your patched tree.
 > But nevermind, I will do the diff myself.

Ok. Attached the diff I wanted. A few comments are inlined.


> diff -b -x '.git*' -x '*.orig' -x '*.rej' -x '*~' -Naurdp ipipe-2.6-at91/arch/arm/mach-at91rm9200/Kconfig ipipe-at91-sam/arch/arm/mach-at91rm9200/Kconfig
> --- ipipe-2.6-at91/arch/arm/mach-at91rm9200/Kconfig	2007-04-17 23:04:17.000000000 +0200
> +++ ipipe-at91-sam/arch/arm/mach-at91rm9200/Kconfig	2007-04-17 23:12:41.000000000 +0200
> @@ -84,24 +84,6 @@ config MACH_KAFA
>  	help
>  	  Select this if you are using Sperry-Sun's KAFA board.
>  
> -config IPIPE_AT91_TC
> -	depends on IPIPE
> -	int "AT91 TC used as time base"
> -	default 0
> -	help
> -	When Adeos interrupt pipeline is enabled, TC0 is used by default
> -	as time base, but you can use TC1 or TC2 by setting this variable to 1
> -	or 2. This should only be needed to avoid conflicts with other drivers.
> -
> -config IPIPE_AT91_MCK
> -	depends on IPIPE
> -	int "AT91 Master clock Frequency"
> -	default 46080000
> -	help
> -	When Adeos interrupt pipeline is enabled, AT91 timer is based on
> -	the AT91 master clock, whose frequency need hence to be known at
> -	compilation time.
> -
>  endif
>  
>  # ----------------------------------------------------------
> @@ -136,6 +118,34 @@ endif
>  
>  # ----------------------------------------------------------
>  
> +if ARCH_AT91SAM9261 || ARCH_AT91RM9200

What is the purpose of this if ? I mean, if the user selected IPIPE and
AT91, he probably wants to see the following settings, if some
combination is not supported, please add an explicit notice instead of
silently hiding the options.


> +
> +comment "Ipipe dependent"
> +
> +config IPIPE_AT91_TC
> +	depends on IPIPE
> +	int "AT91 TC used as time base"
> +	default 0
> +	help
> +	When Adeos interrupt pipeline is enabled, TC0 is used by default
> +	as time base, but you can use TC1 or TC2 by setting this variable to 1
> +	or 2. This should only be needed to avoid conflicts with other drivers.
> +
> +config IPIPE_AT91_MCK
> +	depends on IPIPE
> +	int "AT91 Master clock Frequency"
> +	default 59904000 if MACH_AT91RM9200EK
> +	default 99328000 if MACH_AT91SAM9261EK
> +	default 53000000

Good point. I just need to add a line for CSB637


> +	help
> +	When Adeos interrupt pipeline is enabled, AT91 timer is based on
> +	the AT91 master clock, whose frequency need hence to be known at
> +	compilation time.
> +
> +endif
> (...)
> diff -b -x '.git*' -x '*.orig' -x '*.rej' -x '*~' -Naurdp ipipe-2.6-at91/include/asm-arm/arch-at91rm9200/hardware.h ipipe-at91-sam/include/asm-arm/arch-at91rm9200/hardware.h
> --- ipipe-2.6-at91/include/asm-arm/arch-at91rm9200/hardware.h	2007-04-17 23:08:38.000000000 +0200
> +++ ipipe-at91-sam/include/asm-arm/arch-at91rm9200/hardware.h	2007-04-17 23:12:41.000000000 +0200
> @@ -42,9 +42,27 @@
>   * Virtual to Physical Address mapping for IO devices.
>   */
>  #define AT91_VA_BASE_SYS	AT91_IO_P2V(AT91_BASE_SYS)
> -#define AT91_VA_BASE_EMAC	AT91_IO_P2V(AT91RM9200_BASE_EMAC)
> +
> +#if defined(CONFIG_ARCH_AT91RM9200)
> +	#define AT91_VA_BASE_EMAC	AT91_IO_P2V(AT91RM9200_BASE_EMAC)
> +#elif defined(CONFIG_ARCH_AT91SAM9260)
> +	#define AT91_VA_BASE_EMAC	AT91_IO_P2V(AT91SAM9260_BASE_EMAC)
> +#elif defined(CONFIG_ARCH_AT91SAM9261)
> +	#define AT91_VA_BASE_EMAC	AT91_IO_P2V(AT91SAM9261_BASE_EMAC)
> +#else
> +#error "Unsupported AT91 processor"
> +#endif

What is this ?


> +
>  #ifdef CONFIG_IPIPE
> -#define AT91_VA_BASE_TCB0       AT91_IO_P2V(AT91RM9200_BASE_TCB0)
> +#if defined(CONFIG_ARCH_AT91RM9200)
> +	#define AT91_VA_BASE_TCB0       AT91_IO_P2V(AT91RM9200_BASE_TCB0)
> +#elif defined(CONFIG_ARCH_AT91SAM9260)
> +	#define AT91_VA_BASE_TCB0       AT91_IO_P2V(AT91SAM9260_BASE_TCB0)
> +#elif defined(CONFIG_ARCH_AT91SAM9261)
> +	#define AT91_VA_BASE_TCB0       AT91_IO_P2V(AT91SAM9261_BASE_TCB0)
> +#else
> +#error "Unsupported AT91 processor"
> +#endif
>  #endif /* CONFIG_IPIPE */

To reduce the ifdef hell, can not we define a unique AT91_BASE_TCB0 ?


>  
>   /* Internal SRAM is mapped below the IO devices */
> diff -b -x '.git*' -x '*.orig' -x '*.rej' -x '*~' -Naurdp ipipe-2.6-at91/include/asm-arm/arch-at91rm9200/irqs.h ipipe-at91-sam/include/asm-arm/arch-at91rm9200/irqs.h
> --- ipipe-2.6-at91/include/asm-arm/arch-at91rm9200/irqs.h	2007-04-17 23:04:18.000000000 +0200
> +++ ipipe-at91-sam/include/asm-arm/arch-at91rm9200/irqs.h	2007-04-17 23:12:41.000000000 +0200
> @@ -44,8 +44,19 @@
>  #if defined(CONFIG_IPIPE) && !defined(__ASSEMBLY__)
>  extern unsigned __ipipe_at91_gpio_banks;
>  
> -#define __ipipe_mach_irq_mux_p(irq) \
> +#if defined(CONFIG_ARCH_AT91RM9200)
> +	#define __ipipe_mach_irq_mux_p(irq) \
>  	((unsigned) (irq - AT91RM9200_ID_PIOA) < __ipipe_at91_gpio_banks)
> +#elif defined(CONFIG_ARCH_AT91SAM9260)
> +	#define __ipipe_mach_irq_mux_p(irq) \
> +		((unsigned) (irq - AT91SAM9260_ID_PIOA) < __ipipe_at91_gpio_banks)
> +#elif defined(CONFIG_ARCH_AT91SAM9261)
> +	#define __ipipe_mach_irq_mux_p(irq) \
> +		((unsigned) (irq - AT91SAM9261_ID_PIOA) < __ipipe_at91_gpio_banks)
> +#else
> +#error "Unsupported AT91 processor"
> +#endif

Ditto with a common AT91_ID_PIOA here.


> +
>  
>  #endif /* CONFIG_IPIPE && !__ASSEMBLY__ */
>  
> diff -b -x '.git*' -x '*.orig' -x '*.rej' -x '*~' -Naurdp ipipe-2.6-at91/include/asm-arm/arch-at91rm9200/timex.h ipipe-at91-sam/include/asm-arm/arch-at91rm9200/timex.h
> --- ipipe-2.6-at91/include/asm-arm/arch-at91rm9200/timex.h	2007-04-17 23:09:42.000000000 +0200
> +++ ipipe-at91-sam/include/asm-arm/arch-at91rm9200/timex.h	2007-04-17 23:12:41.000000000 +0200
> @@ -23,10 +23,13 @@
>  
>  #include <asm/hardware.h>
>  
> -#ifndef CONFIG_IPIPE
>  #if defined(CONFIG_ARCH_AT91RM9200)
>  
> +#ifndef CONFIG_IPIPE
>  #define CLOCK_TICK_RATE		(AT91_SLOW_CLOCK)
> +#else /* !CONFIG_IPIPE */
> +#define CLOCK_TICK_RATE         (CONFIG_IPIPE_AT91_MCK / 32)
> +#endif /* !CONFIG_IPIPE */
>  
>  #elif defined(CONFIG_ARCH_AT91SAM9260) || defined(CONFIG_ARCH_AT91SAM9261)
>  
> @@ -35,8 +38,4 @@
>  
>  #endif
>  
> -#else /* !CONFIG_IPIPE */
> -#define CLOCK_TICK_RATE         (CONFIG_IPIPE_AT91_MCK / 32)
> -#endif /* !CONFIG_IPIPE */
> -
>  #endif

I think you got CLOCK_TICK_RATE wrong here. It should be
CONFIG_IPIPE_AT91_MCK / 32 as soon as I-pipe is enabled whatever ARCH is
selected. 

-- 


					    Gilles Chanteperdrix.

--Cj5BZXUA+r
Content-Type: text/plain
Content-Disposition: inline;
	filename="ipipe-at91-sam.diff"
Content-Transfer-Encoding: 7bit

diff -b -x '.git*' -x '*.orig' -x '*.rej' -x '*~' -Naurdp ipipe-2.6-at91/arch/arm/mach-at91rm9200/Kconfig ipipe-at91-sam/arch/arm/mach-at91rm9200/Kconfig
--- ipipe-2.6-at91/arch/arm/mach-at91rm9200/Kconfig	2007-04-17 23:04:17.000000000 +0200
+++ ipipe-at91-sam/arch/arm/mach-at91rm9200/Kconfig	2007-04-17 23:12:41.000000000 +0200
@@ -84,24 +84,6 @@ config MACH_KAFA
 	help
 	  Select this if you are using Sperry-Sun's KAFA board.
 
-config IPIPE_AT91_TC
-	depends on IPIPE
-	int "AT91 TC used as time base"
-	default 0
-	help
-	When Adeos interrupt pipeline is enabled, TC0 is used by default
-	as time base, but you can use TC1 or TC2 by setting this variable to 1
-	or 2. This should only be needed to avoid conflicts with other drivers.
-
-config IPIPE_AT91_MCK
-	depends on IPIPE
-	int "AT91 Master clock Frequency"
-	default 46080000
-	help
-	When Adeos interrupt pipeline is enabled, AT91 timer is based on
-	the AT91 master clock, whose frequency need hence to be known at
-	compilation time.
-
 endif
 
 # ----------------------------------------------------------
@@ -136,6 +118,34 @@ endif
 
 # ----------------------------------------------------------
 
+if ARCH_AT91SAM9261 || ARCH_AT91RM9200
+
+comment "Ipipe dependent"
+
+config IPIPE_AT91_TC
+	depends on IPIPE
+	int "AT91 TC used as time base"
+	default 0
+	help
+	When Adeos interrupt pipeline is enabled, TC0 is used by default
+	as time base, but you can use TC1 or TC2 by setting this variable to 1
+	or 2. This should only be needed to avoid conflicts with other drivers.
+
+config IPIPE_AT91_MCK
+	depends on IPIPE
+	int "AT91 Master clock Frequency"
+	default 59904000 if MACH_AT91RM9200EK
+	default 99328000 if MACH_AT91SAM9261EK
+	default 53000000
+	help
+	When Adeos interrupt pipeline is enabled, AT91 timer is based on
+	the AT91 master clock, whose frequency need hence to be known at
+	compilation time.
+
+endif
+
+# ----------------------------------------------------------
+
 comment "AT91 Board Options"
 
 config MTD_AT91_DATAFLASH_CARD
diff -b -x '.git*' -x '*.orig' -x '*.rej' -x '*~' -Naurdp ipipe-2.6-at91/arch/arm/mach-at91rm9200/at91sam9261.c ipipe-at91-sam/arch/arm/mach-at91rm9200/at91sam9261.c
--- ipipe-2.6-at91/arch/arm/mach-at91rm9200/at91sam9261.c	2007-04-17 23:04:17.000000000 +0200
+++ ipipe-at91-sam/arch/arm/mach-at91rm9200/at91sam9261.c	2007-04-17 23:12:41.000000000 +0200
@@ -27,6 +27,13 @@ static struct map_desc at91sam9261_io_de
 		.length		= SZ_16K,
 		.type		= MT_DEVICE,
 	}, {
+#ifdef CONFIG_IPIPE
+		.virtual	= AT91_VA_BASE_TCB0,
+		.pfn		= __phys_to_pfn(AT91SAM9261_BASE_TCB0),
+		.length		= SZ_16K,
+		.type		= MT_DEVICE,
+        }, {
+#endif /* CONFIG_IPIPE */
 		.virtual	= AT91_IO_VIRT_BASE - AT91SAM9261_SRAM_SIZE,
 		.pfn		= __phys_to_pfn(AT91SAM9261_SRAM_BASE),
 		.length		= AT91SAM9261_SRAM_SIZE,
@@ -242,6 +249,7 @@ void __init at91sam9261_initialize(unsig
  * The default interrupt priority levels (0 = lowest, 7 = highest).
  */
 static unsigned int at91sam9261_default_irq_priority[NR_AIC_IRQS] __initdata = {
+#ifndef CONFIG_IPIPE
 	7,	/* Advanced Interrupt Controller */
 	7,	/* System Peripherals */
 	0,	/* Parallel IO Controller A */
@@ -274,6 +282,42 @@ static unsigned int at91sam9261_default_
 	0,	/* Advanced Interrupt Controller */
 	0,	/* Advanced Interrupt Controller */
 	0,	/* Advanced Interrupt Controller */
+#else /* CONFIG_IPIPE */
+/* Give the highest priority to TC, since they are used as timer interrupt by
+   I-pipe. */
+	7,	/* Advanced Interrupt Controller */
+	7,	/* System Peripherals */
+	0,	/* Parallel IO Controller A */
+	0,	/* Parallel IO Controller B */
+	0,	/* Parallel IO Controller C */
+	0,
+	6,	/* USART 0 */
+	6,	/* USART 1 */
+	6,	/* USART 2 */
+	0,	/* Multimedia Card Interface */
+	4,	/* USB Device Port */
+	0,	/* Two-Wire Interface */
+	6,	/* Serial Peripheral Interface 0 */
+	6,	/* Serial Peripheral Interface 1 */
+	5,	/* Serial Synchronous Controller 0 */
+	5,	/* Serial Synchronous Controller 1 */
+	5,	/* Serial Synchronous Controller 2 */
+	7,	/* Timer Counter 0 */
+	7,	/* Timer Counter 1 */
+	7,	/* Timer Counter 2 */
+	3,	/* USB Host port */
+	3,	/* LCD Controller */
+	0,
+	0,
+	0,
+	0,
+	0,
+	0,
+	0,
+	0,	/* Advanced Interrupt Controller */
+	0,	/* Advanced Interrupt Controller */
+	0,	/* Advanced Interrupt Controller */
+#endif /*CONFIG_IPIPE */
 };
 
 void __init at91sam9261_init_interrupts(unsigned int priority[NR_AIC_IRQS])
diff -b -x '.git*' -x '*.orig' -x '*.rej' -x '*~' -Naurdp ipipe-2.6-at91/arch/arm/mach-at91rm9200/at91sam926x_time.c ipipe-at91-sam/arch/arm/mach-at91rm9200/at91sam926x_time.c
--- ipipe-2.6-at91/arch/arm/mach-at91rm9200/at91sam926x_time.c	2007-04-17 23:04:17.000000000 +0200
+++ ipipe-at91-sam/arch/arm/mach-at91rm9200/at91sam926x_time.c	2007-04-17 23:12:41.000000000 +0200
@@ -22,10 +22,69 @@
 
 #include <asm/arch/at91_pit.h>
 
+static unsigned long last_crtr;
+
+#ifdef CONFIG_IPIPE
+#include <linux/clk.h>
+#include <linux/console.h>
+#include <linux/module.h>
+#include <asm/arch/at91sam9261.h>
+#include <asm/arch/at91_tc.h>
+#include "clock.h"
+
+#ifdef CONFIG_NO_IDLE_HZ
+#error "dynamic tick timer not yet supported with IPIPE"
+#endif /* CONFIG_NO_IDLE_HZ */
+
+#define TCNXCNS(timer,v) ((v) << ((timer)<<1))
+#define AT91_TC_REG_MASK (0xffff)
+
+#if (CONFIG_IPIPE_AT91_TC==0)
+#   define KERNEL_TIMER_IRQ_NUM AT91SAM9261_ID_TC0
+#elif (CONFIG_IPIPE_AT91_TC==1)
+#   define KERNEL_TIMER_IRQ_NUM AT91SAM9261_ID_TC1
+#elif (CONFIG_IPIPE_AT91_TC==2)
+#   define KERNEL_TIMER_IRQ_NUM AT91SAM9261_ID_TC2
+#else
+#error IPIPE_AT91_TC must be 0, 1 or 2.
+#endif
+
+static inline unsigned int at91_tc_read(unsigned int reg_offset)
+{
+	unsigned long addr =
+		(AT91_VA_BASE_TCB0 + 0x40 * CONFIG_IPIPE_AT91_TC);
+
+	return readl((void __iomem *)(addr + reg_offset));
+}
+
+static inline void at91_tc_write(unsigned int reg_offset, unsigned long value)
+{
+	unsigned long addr =
+		(AT91_VA_BASE_TCB0 + 0x40 * CONFIG_IPIPE_AT91_TC);
+
+	writel(value, (void __iomem *)(addr + reg_offset));
+}
+
+#define read_CV() at91_tc_read(AT91_TC_CV)
+#define read_RC() at91_tc_read(AT91_TC_RC)
+#define write_RC(value) at91_tc_write(AT91_TC_RC, value)
+
+int __ipipe_mach_timerint = KERNEL_TIMER_IRQ_NUM;
+EXPORT_SYMBOL(__ipipe_mach_timerint);
+
+int __ipipe_mach_timerstolen = 0;
+EXPORT_SYMBOL(__ipipe_mach_timerstolen);
+
+unsigned int __ipipe_mach_ticks_per_jiffy = LATCH;
+EXPORT_SYMBOL(__ipipe_mach_ticks_per_jiffy);
+
+static int at91_timer_initialized;
+#endif /* CONFIG_IPIPE */
 
 #define PIT_CPIV(x)	((x) & AT91_PIT_CPIV)
 #define PIT_PICNT(x)	(((x) & AT91_PIT_PICNT) >> 20)
 
+#ifndef CONFIG_IPIPE
 /*
  * Returns number of microseconds since last timer interrupt.  Note that interrupts
  * will have been disabled by do_gettimeofday()
@@ -112,3 +171,209 @@ struct sys_timer at91sam926x_timer = {
 	.resume		= at91sam926x_timer_reset,
 };
 
+#else /* CONFIG_IPIPE */
+
+/*
+ * Returns number of microseconds since last timer interrupt.  Note that interrupts
+ * will have been disabled by do_gettimeofday()
+ *  'LATCH' is hwclock ticks (see CLOCK_TICK_RATE in timex.h) per jiffy.
+*  'tick' is usecs per jiffy (linux/timex.h).
+ */
+static unsigned long at91sam926x_gettimeoffset(void)
+{
+	unsigned long elapsed;
+
+	elapsed = (read_CV() - last_crtr) & AT91_TC_REG_MASK;
+
+	return (unsigned long) (elapsed * (tick_nsec / 1000)) / LATCH;
+}
+
+void __ipipe_mach_acktimer(void)
+{
+	at91_tc_read(AT91_TC_SR);
+}
+
+/*
+ * IRQ handler for the timer.
+ */
+static irqreturn_t at91sam926x_timer_interrupt(int irq, void *dev_id)
+{
+	/*
+	 * - if Linux is running under ipipe, but it still has the control over
+	 *   the timer (no Xenomai for example), then reprogram the timer (ipipe
+	 *   has already acked it)
+	 * - if some other domain has taken over the timer, then do nothing
+	 *   (ipipe has acked it, and the other domain has reprogramed it)
+	 */
+
+	write_seqlock(&xtime_lock);
+
+	if (__ipipe_mach_timerstolen) {
+		timer_tick();
+		last_crtr = (last_crtr + LATCH) & AT91_TC_REG_MASK;
+	} else {
+		while (((read_CV() - last_crtr) & AT91_TC_REG_MASK) >= LATCH) {
+			timer_tick();
+			last_crtr = (last_crtr + LATCH) & AT91_TC_REG_MASK;
+		}
+		write_RC((last_crtr + LATCH) & AT91_TC_REG_MASK);
+	}
+
+	write_sequnlock(&xtime_lock);
+
+	return IRQ_HANDLED;
+}
+
+static irqreturn_t at91sam926x_bad_freq(int irq, void *dev_id)
+{
+	static int ticks = 0;
+
+	if (++ticks != HZ * 120) {
+		if (!console_drivers || try_acquire_console_sem())
+			return at91sam926x_timer_interrupt(irq, dev_id);
+	
+		release_console_sem();
+	}
+
+	panic("AT91 clock rate incorrectly set.\n"
+	      "Please recompile with IPIPE_AT91_MCK set to %lu Hz.",
+	      clk_get_rate(clk_get(NULL, "mck")));
+}
+
+notrace unsigned long long __ipipe_mach_get_tsc(void)
+{
+	if (likely(at91_timer_initialized)) {
+		static union {
+#ifdef __BIG_ENDIAN
+			struct {
+				unsigned long high;
+				unsigned short mid;
+				unsigned short low;
+			};
+#else /* __LITTLE_ENDIAN */
+			struct {
+				unsigned short low;
+				unsigned short mid;
+				unsigned long high;
+			};
+#endif /* __LITTLE_ENDIAN */
+			unsigned long long full;
+		} tsc[NR_CPUS], *local_tsc;
+		unsigned long long result;
+		unsigned short stamp;
+		unsigned long flags;
+
+		local_irq_save_hw(flags);
+		local_tsc = &tsc[ipipe_processor_id()];
+		stamp = read_CV();
+		if (unlikely(stamp < local_tsc->low)) {
+			if (unlikely(!++local_tsc->mid))
+				/* 32 bit counter wrapped, increment high word. */
+				local_tsc->high++;
+		}
+		local_tsc->low = stamp;
+		result = local_tsc->full;
+		local_irq_restore_hw(flags);
+
+		return result;
+	}
+	
+        return 0;
+}
+EXPORT_SYMBOL(__ipipe_mach_get_tsc);
+
+/*
+ * Reprogram the timer
+ */
+
+void __ipipe_mach_set_dec(unsigned long delay)
+{
+	unsigned long flags;
+
+	if (delay > 2) {
+		local_irq_save_hw(flags);
+		write_RC((read_CV() + delay) & AT91_TC_REG_MASK);
+		local_irq_restore_hw(flags);
+	} else
+		ipipe_trigger_irq(KERNEL_TIMER_IRQ_NUM);
+}
+EXPORT_SYMBOL(__ipipe_mach_set_dec);
+
+void __ipipe_mach_release_timer(void)
+{
+       __ipipe_mach_set_dec(__ipipe_mach_ticks_per_jiffy);
+}
+EXPORT_SYMBOL(__ipipe_mach_release_timer);
+
+unsigned long __ipipe_mach_get_dec(void)
+{
+	return (read_RC() - read_CV()) & AT91_TC_REG_MASK;
+}
+
+static struct irqaction at91sam926x_timer_irq = {
+	.name		= "at91_tick",
+	.flags		= IRQF_DISABLED | IRQF_TIMER,
+	.handler	= &at91sam926x_timer_interrupt
+};
+
+static char clk_name [] = "tc%";
+
+static struct clk tc = {
+	.name		= (const char *) clk_name,
+	.users          = 0,
+	.type		= CLK_TYPE_PERIPHERAL,
+	.pmc_mask       = 1 << (KERNEL_TIMER_IRQ_NUM),
+};
+
+void __init at91sam926x_timer_init(void)
+{
+	unsigned long v;
+	
+	if (clk_get_rate(clk_get(NULL, "mck")) != CONFIG_IPIPE_AT91_MCK)
+		at91sam926x_timer_irq.handler = &at91sam926x_bad_freq;
+
+	snprintf(clk_name, sizeof(clk_name), "tc%d", CONFIG_IPIPE_AT91_TC);
+	clk_register(&tc);
+	clk_enable(&tc);
+	
+	/* No Sync. */
+	at91_tc_write(AT91_TC_BCR, 0);
+
+	/* program NO signal on XCN */
+	v = readl((void __iomem *) (AT91_VA_BASE_TCB0 + AT91_TC_BMR));
+	v &= ~TCNXCNS(CONFIG_IPIPE_AT91_TC, 3);
+	v |= TCNXCNS(CONFIG_IPIPE_AT91_TC, 1); /* AT91_TC_TCNXCNS_NONE */
+	writel(v, (void __iomem *) (AT91_VA_BASE_TCB0 + AT91_TC_BMR));
+
+	/* Disable the channel */
+	at91_tc_write(AT91_TC_CCR, AT91_TC_CLKDIS);
+
+	/* Select TIMER_CLOCK3 (MCLK/32) as input frequency for TC. */
+	at91_tc_write(AT91_TC_CMR, AT91_TC_TIMER_CLOCK3);
+
+	/* Disable all interrupts. */
+	at91_tc_write(AT91_TC_IDR, ~0ul);
+
+	/* Load the TC register C. */
+	last_crtr = 0;
+	write_RC(LATCH);
+
+	/* Enable CPCS interrupt. */
+	at91_tc_write(AT91_TC_IER, AT91_TC_CPCS);
+
+	/* Set up the interrupt. */
+	setup_irq(KERNEL_TIMER_IRQ_NUM, &at91sam926x_timer_irq);
+
+	/* Enable the channel. */
+	at91_tc_write(AT91_TC_CCR, AT91_TC_CLKEN | AT91_TC_SWTRG);
+
+	at91_timer_initialized = 1;
+}
+
+struct sys_timer at91sam926x_timer = {
+	.init		= at91sam926x_timer_init,
+	.offset		= at91sam926x_gettimeoffset,
+	.suspend	= NULL,
+	.resume		= NULL,
+};
+#endif /* CONFIG_IPIPE */
diff -b -x '.git*' -x '*.orig' -x '*.rej' -x '*~' -Naurdp ipipe-2.6-at91/include/asm-arm/arch-at91rm9200/hardware.h ipipe-at91-sam/include/asm-arm/arch-at91rm9200/hardware.h
--- ipipe-2.6-at91/include/asm-arm/arch-at91rm9200/hardware.h	2007-04-17 23:08:38.000000000 +0200
+++ ipipe-at91-sam/include/asm-arm/arch-at91rm9200/hardware.h	2007-04-17 23:12:41.000000000 +0200
@@ -42,9 +42,27 @@
  * Virtual to Physical Address mapping for IO devices.
  */
 #define AT91_VA_BASE_SYS	AT91_IO_P2V(AT91_BASE_SYS)
-#define AT91_VA_BASE_EMAC	AT91_IO_P2V(AT91RM9200_BASE_EMAC)
+
+#if defined(CONFIG_ARCH_AT91RM9200)
+	#define AT91_VA_BASE_EMAC	AT91_IO_P2V(AT91RM9200_BASE_EMAC)
+#elif defined(CONFIG_ARCH_AT91SAM9260)
+	#define AT91_VA_BASE_EMAC	AT91_IO_P2V(AT91SAM9260_BASE_EMAC)
+#elif defined(CONFIG_ARCH_AT91SAM9261)
+	#define AT91_VA_BASE_EMAC	AT91_IO_P2V(AT91SAM9261_BASE_EMAC)
+#else
+#error "Unsupported AT91 processor"
+#endif
+
 #ifdef CONFIG_IPIPE
-#define AT91_VA_BASE_TCB0       AT91_IO_P2V(AT91RM9200_BASE_TCB0)
+#if defined(CONFIG_ARCH_AT91RM9200)
+	#define AT91_VA_BASE_TCB0       AT91_IO_P2V(AT91RM9200_BASE_TCB0)
+#elif defined(CONFIG_ARCH_AT91SAM9260)
+	#define AT91_VA_BASE_TCB0       AT91_IO_P2V(AT91SAM9260_BASE_TCB0)
+#elif defined(CONFIG_ARCH_AT91SAM9261)
+	#define AT91_VA_BASE_TCB0       AT91_IO_P2V(AT91SAM9261_BASE_TCB0)
+#else
+#error "Unsupported AT91 processor"
+#endif
 #endif /* CONFIG_IPIPE */
 
  /* Internal SRAM is mapped below the IO devices */
diff -b -x '.git*' -x '*.orig' -x '*.rej' -x '*~' -Naurdp ipipe-2.6-at91/include/asm-arm/arch-at91rm9200/irqs.h ipipe-at91-sam/include/asm-arm/arch-at91rm9200/irqs.h
--- ipipe-2.6-at91/include/asm-arm/arch-at91rm9200/irqs.h	2007-04-17 23:04:18.000000000 +0200
+++ ipipe-at91-sam/include/asm-arm/arch-at91rm9200/irqs.h	2007-04-17 23:12:41.000000000 +0200
@@ -44,8 +44,19 @@
 #if defined(CONFIG_IPIPE) && !defined(__ASSEMBLY__)
 extern unsigned __ipipe_at91_gpio_banks;
 
-#define __ipipe_mach_irq_mux_p(irq) \
+#if defined(CONFIG_ARCH_AT91RM9200)
+	#define __ipipe_mach_irq_mux_p(irq) \
 	((unsigned) (irq - AT91RM9200_ID_PIOA) < __ipipe_at91_gpio_banks)
+#elif defined(CONFIG_ARCH_AT91SAM9260)
+	#define __ipipe_mach_irq_mux_p(irq) \
+		((unsigned) (irq - AT91SAM9260_ID_PIOA) < __ipipe_at91_gpio_banks)
+#elif defined(CONFIG_ARCH_AT91SAM9261)
+	#define __ipipe_mach_irq_mux_p(irq) \
+		((unsigned) (irq - AT91SAM9261_ID_PIOA) < __ipipe_at91_gpio_banks)
+#else
+#error "Unsupported AT91 processor"
+#endif
+
 
 #endif /* CONFIG_IPIPE && !__ASSEMBLY__ */
 
diff -b -x '.git*' -x '*.orig' -x '*.rej' -x '*~' -Naurdp ipipe-2.6-at91/include/asm-arm/arch-at91rm9200/timex.h ipipe-at91-sam/include/asm-arm/arch-at91rm9200/timex.h
--- ipipe-2.6-at91/include/asm-arm/arch-at91rm9200/timex.h	2007-04-17 23:09:42.000000000 +0200
+++ ipipe-at91-sam/include/asm-arm/arch-at91rm9200/timex.h	2007-04-17 23:12:41.000000000 +0200
@@ -23,10 +23,13 @@
 
 #include <asm/hardware.h>
 
-#ifndef CONFIG_IPIPE
 #if defined(CONFIG_ARCH_AT91RM9200)
 
+#ifndef CONFIG_IPIPE
 #define CLOCK_TICK_RATE		(AT91_SLOW_CLOCK)
+#else /* !CONFIG_IPIPE */
+#define CLOCK_TICK_RATE         (CONFIG_IPIPE_AT91_MCK / 32)
+#endif /* !CONFIG_IPIPE */
 
 #elif defined(CONFIG_ARCH_AT91SAM9260) || defined(CONFIG_ARCH_AT91SAM9261)
 
@@ -35,8 +38,4 @@
 
 #endif
 
-#else /* !CONFIG_IPIPE */
-#define CLOCK_TICK_RATE         (CONFIG_IPIPE_AT91_MCK / 32)
-#endif /* !CONFIG_IPIPE */
-
 #endif

--Cj5BZXUA+r--

