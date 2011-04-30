Message-ID: <4DBC8EEF.40109@domain.hid>
Date: Sun, 01 May 2011 00:36:31 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <4DB8149A.7080600@domain.hid>	<4DB83CBE.5040007@domain.hid>	<4DB94BA0.1020503@domain.hid>	<4DB94C9C.7080904@domain.hid>	<4DB991E6.90403@domain.hid>	<4DB99E47.7000904@domain.hid>	<BANLkTik_MeMvpq2x7N0WmML97uW5=HxsLw@domain.hid>	<4DB9B978.2010200@domain.hid>	<BANLkTinSWAT+33YFAD-z0kz6pesSQBe7qw@domain.hid>	<4DB9C0D3.4030003@domain.hid>	<4DBA9C26.2040903@domain.hid>	<4DBAA1DE.4000108@domain.hid>	<4DBBDCA9.1040609@domain.hid>	<BANLkTintQjX=O0DBYbyW2=jhyNQuyeZ=pQ@mail.gmail.com>	<4DBC6D98.2070306@domain.hid>
	<BANLkTi=Q07ByVtHNobQBR1uNkHwRAsoo5g@domain.hid>
In-Reply-To: <BANLkTi=Q07ByVtHNobQBR1uNkHwRAsoo5g@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Adeos-main] Ipipe hangs on ARM MINI2440 after switching
	clocksource
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/options/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: </public/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: Alexey Galakhov <agalakhov@domain.hid>
Cc: adeos-main@gna.org

Alexey Galakhov wrote:
> 2011/5/1 Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
> 
>> Ok. Could you try only keeping the part with ipipe_handle_chained_irq,
>> leaving the handle_edge_irqs?
>>
> 
> Sure. I'll do it tomorrow.
> 
> There is another one issue: the board hangs after about 2-3 minutes running.
> I found that it is caused by a semi-permanent (order of 2^64 iterations)
> loop in (untouched) kernel timer code, most likely due to weird return value
> of __ipipe_tsc_get. I haven't found the source of this problem yet. I tried
> a small fix:
> 
> --- time.c.org    2011-04-26 20:52:00.000000000 +0600
> +++ time.c    2011-05-01 02:03:33.000000000 +0600
> @@ -124,7 +124,7 @@
> 
>  static inline unsigned long timer_freerunning_getvalue(void)
>  {
> -    return __raw_readl(S3C2410_TCNTO(3));
> +    return (unsigned long)__raw_readw(S3C2410_TCNTO(3));
>  }
> 
>  static inline unsigned long timer_freerunning_getticksoffset(unsigned long
> tval)
> @@ -390,6 +390,6 @@
> 
>  unsigned long __ipipe_mach_get_dec(void)
>  {
> -    return __raw_readl(S3C2410_TCNTO(4));
> +    return (unsigned long)__raw_readw(S3C2410_TCNTO(4));
>  }
>  #endif /* CONFIG_IPIPE */
> 
> but it didn't work. (In fact, TCNTOs of S4C2440 are 16-bit, not 32-bit, and
> the datasheet does not guarantee that higher bits are read as zeroes; in
> fact they are, but I tried explicit conversion anyway just in case. No
> effect.).

There is a bug in ipipe_tsc_update for decrementers. The all-in-one patch I 
would like you to try is:

diff --git a/arch/arm/kernel/ipipe_tsc.c b/arch/arm/kernel/ipipe_tsc.c
index a9de4f9..c5c2de0 100644
--- a/arch/arm/kernel/ipipe_tsc.c
+++ b/arch/arm/kernel/ipipe_tsc.c
@@ -104,8 +104,8 @@ void __ipipe_tsc_update(void)
 		int offset = ipipe_tsc_value->last_cnt - cnt;
 		if (offset < 0)
 			offset += 0x10000;
-		ipipe_tsc_value->last_tsc += offset + 1;
-		ipipe_tsc_value->last_cnt = cnt - 1;
+		ipipe_tsc_value->last_tsc += offset;
+		ipipe_tsc_value->last_cnt = cnt;
 		return;
 	}
 	ipipe_tsc_value->last_tsc = __ipipe_tsc_get() - 1;
diff --git a/arch/arm/kernel/ipipe_tsc_asm.S b/arch/arm/kernel/ipipe_tsc_asm.S
index ca88882..d3c833f 100644
--- a/arch/arm/kernel/ipipe_tsc_asm.S
+++ b/arch/arm/kernel/ipipe_tsc_asm.S
@@ -143,7 +143,7 @@ __ipipe_decrementer_16:
 	ldr	ip, [r0]
 	ldr	r2, .LCdec16_last_cnt
 	subs 	ip, r2, ip
-	addcs	ip, ip, #0x10000
+	addcc	ip, ip, #0x10000
 	myldrd	r2, r3, r3, .LCdec16_last_tsc
 	cmp	r1, r2
 	bne	1b
@@ -155,7 +155,7 @@ __ipipe_decrementer_16:
 	ldr	ip, [r0]
 	ldr	r2, .LCdec16_last_cnt
 	subs 	ip, r2, ip
-	addcs	ip, ip, #0x10000
+	addcc	ip, ip, #0x10000
 	myldrd	r2, r3, r3, .LCdec16_last_tsc
 	cmp	r1, r3
 	bne	1b
diff --git a/arch/arm/plat-samsung/irq-uart.c b/arch/arm/plat-samsung/irq-uart.c
index 4f8c102..1da5aff 100644
--- a/arch/arm/plat-samsung/irq-uart.c
+++ b/arch/arm/plat-samsung/irq-uart.c
@@ -88,13 +88,13 @@ static void s3c_irq_demux_uart(unsigned int irq, struct irq_desc *desc)
 	int base = uirq->base_irq;
 
 	if (pend & (1 << 0))
-		generic_handle_irq(base);
+		ipipe_handle_chained_irq(base);
 	if (pend & (1 << 1))
-		generic_handle_irq(base + 1);
+		ipipe_handle_chained_irq(base + 1);
 	if (pend & (1 << 2))
-		generic_handle_irq(base + 2);
+		ipipe_handle_chained_irq(base + 2);
 	if (pend & (1 << 3))
-		generic_handle_irq(base + 3);
+		ipipe_handle_chained_irq(base + 3);
 }
 
 static struct irq_chip s3c_irq_uart = {
diff --git a/arch/arm/plat-samsung/time.c b/arch/arm/plat-samsung/time.c
index 3e9cef2..baf61f6 100644
--- a/arch/arm/plat-samsung/time.c
+++ b/arch/arm/plat-samsung/time.c
@@ -154,7 +154,7 @@ static inline unsigned long getticksoffset_tscupdate(void)
 	last_free_running_tcnt = tval;
 	__ipipe_tsc_update();
 	return ticks;
-	}
+}
 #else
 static unsigned long s3c2410_gettimeoffset (void)
 {


-- 
                                                                Gilles.

