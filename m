Message-ID: <4DBBDCA9.1040609@domain.hid>
Date: Sat, 30 Apr 2011 11:55:53 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <4DB8149A.7080600@domain.hid>	<4DB83CBE.5040007@domain.hid>	<4DB94BA0.1020503@domain.hid>	<4DB94C9C.7080904@domain.hid>	<4DB991E6.90403@domain.hid>	<4DB99E47.7000904@domain.hid>	<BANLkTik_MeMvpq2x7N0WmML97uW5=HxsLw@domain.hid>	<4DB9B978.2010200@domain.hid>	<BANLkTinSWAT+33YFAD-z0kz6pesSQBe7qw@domain.hid>	<4DB9C0D3.4030003@domain.hid>
	<4DBA9C26.2040903@domain.hid> <4DBAA1DE.4000108@domain.hid>
In-Reply-To: <4DBAA1DE.4000108@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Adeos-main] Ipipe hangs on ARM MINI2440 after
	switching	clocksource
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

Gilles Chanteperdrix wrote:
> Alexey Galakhov wrote:
>> On 04/29/2011 01:32 AM, Gilles Chanteperdrix wrote:
>>> Maybe you can try booting with MMC disabled, to see if the I-pipe is
>>> working? Not permanently, just to confirm that you are not chasing the
>>> wrong bug.
>> Thank you for the root image!
>>
>> Just did some simple checks.
>>
>> It works with the same kernel, just with MMC card removed (heartbeat
>> blinks, "Waiting for root").
>> It STOPS working (heartbeat stops blinking) immediately after inserting
>> either MMC or USB flash. So it is not exactly MMC related, any interrupt
>> source (both MMC and USB) results in lockup.
>>
>> The lockup is not immediate, it works for some short time (enough to
>> print kind of "new device found" to dmesg).
>>
>> It does not depend on drivers actually compiled in, it depends on
>> devices being initialized. It stops working as soon as some hardware
>> starts sending frequent interrupts.
>>
>> Now going to try your asm patch.
> 
> Ok. Two things to check:
> - if the irqs are handled by handle_edge, try using handle_level instead;
> - if the irqs are demuxed gpios, check that ipipe_handle_chained_irq is
> used instead of generic_handle_irq.
> 
> I will check on my side tonight.

Please try the following patch:

diff --git a/arch/arm/plat-s3c24xx/irq.c b/arch/arm/plat-s3c24xx/irq.c
index c48d99a..8a29d9d 100644
--- a/arch/arm/plat-s3c24xx/irq.c
+++ b/arch/arm/plat-s3c24xx/irq.c
@@ -627,7 +627,7 @@ void __init s3c24xx_init_irq(void)
 		default:
 			//irqdbf("registering irq %d (s3c irq)\n", irqno);
 			set_irq_chip(irqno, &s3c_irq_chip);
-			set_irq_handler(irqno, handle_edge_irq);
+			set_irq_handler(irqno, handle_level_irq);
 			set_irq_flags(irqno, IRQF_VALID);
 		}
 	}
@@ -647,14 +647,14 @@ void __init s3c24xx_init_irq(void)
 	for (irqno = IRQ_EINT0; irqno <= IRQ_EINT3; irqno++) {
 		irqdbf("registering irq %d (ext int)\n", irqno);
 		set_irq_chip(irqno, &s3c_irq_eint0t4);
-		set_irq_handler(irqno, handle_edge_irq);
+		set_irq_handler(irqno, handle_level_irq);
 		set_irq_flags(irqno, IRQF_VALID);
 	}
 
 	for (irqno = IRQ_EINT4; irqno <= IRQ_EINT23; irqno++) {
 		irqdbf("registering irq %d (extended s3c irq)\n", irqno);
 		set_irq_chip(irqno, &s3c_irqext_chip);
-		set_irq_handler(irqno, handle_edge_irq);
+		set_irq_handler(irqno, handle_level_irq);
 		set_irq_flags(irqno, IRQF_VALID);
 	}
 
@@ -686,7 +686,7 @@ void __init s3c24xx_init_irq(void)
 	for (irqno = IRQ_TC; irqno <= IRQ_ADC; irqno++) {
 		irqdbf("registering irq %d (s3c adc irq)\n", irqno);
 		set_irq_chip(irqno, &s3c_irq_adc);
-		set_irq_handler(irqno, handle_edge_irq);
+		set_irq_handler(irqno, handle_level_irq);
 		set_irq_flags(irqno, IRQF_VALID);
 	}
 
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


-- 
                                                                Gilles.

