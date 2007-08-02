MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="MuvIaO7L8V"
Content-Transfer-Encoding: 7bit
Message-ID: <18098.23646.615920.431030@domain.hid>
Date: Fri, 3 Aug 2007 00:36:14 +0200
In-Reply-To: <2862c2c80707312153w1765ceaeo9d81a55db2ce6dea@domain.hid>
References: <2862c2c80707130245j3f9b09b3i2b461c4e1521c53d@domain.hid>
	<2862c2c80707172257x5f41d8c4p5df5282be4ba98a2@domain.hid>
	<18077.48173.286511.400122@domain.hid>
	<2862c2c80707180036t6e64ccban83924d445d80f9c0@domain.hid>
	<2ff1a98a0707180135q24ab6515kf573215edf0aaafa@domain.hid>
	<2862c2c80707180255h7197a055i58b90228bc2c52df@domain.hid>
	<2ff1a98a0707180739y59f673c3tc7d8668877686212@domain.hid>
	<2862c2c80707182309r2d49f8b6xeb85601230a4be43@domain.hid>
	<18095.41752.74240.393339@domain.hid>
	<18095.43878.759358.210266@domain.hid>
	<2862c2c80707312153w1765ceaeo9d81a55db2ce6dea@domain.hid>
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Subject: Re: [Xenomai-help] Enable I-PIPE - kernel boot hangs in the
	AT91RM9200
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Yeoh Chun Yeow <yeohchunyeow@domain.hid>
Cc: "Xenomai-help@domain.hid" <xenomai@xenomai.org>


--MuvIaO7L8V
Content-Type: text/plain; charset=us-ascii
Content-Description: message body and .signature
Content-Transfer-Encoding: 7bit

Yeoh Chun Yeow wrote:
 > Dear Gilles,
 > 
 > Did you figure out what is wrong with the I-PIPE patch?
 > 
 > My kernel hangs at this stage, not even until the mounting of NFS:
 > udc: at91_udc version 3 May 2006
 > mice: PS/2 mouse device common for all mice
 > AT91 MMC: 4 wire bus mode not supported by this driver - using 1 wire
 > TCP cubic registered
 > NET: Registered protocol family 1
 > NET: Registered protocol family 17
 > 
 > I find out that the problem is not coming from "excessive" interrupts that I
 > faced last time.
 > 
 > Yes, when I-PIPE disabled, everything works fine.

Ok, I got it. The problem is that the I-pipe patch registers its own
clock object for the tc it uses. This is fine with the stock kernel
which does not registers clock objects for tcs. But it fails to work
with the AT91 patch, because the AT91 patch registers and disables the
TC clocks. So, the solution is to use the kernel clock objects if they
exist. This way, the I-pipe patch works with or without the AT91 patch.
Attached a patch which does that.

-- 


					    Gilles Chanteperdrix.

--MuvIaO7L8V
Content-Type: text/plain
Content-Disposition: inline;
	filename="ipipe-at91-use-kernel-tc-clock-if-available.diff"
Content-Transfer-Encoding: 7bit

diff --git a/arch/arm/mach-at91rm9200/at91rm9200_time.c b/arch/arm/mach-at91rm9200/at91rm9200_time.c
index 7b2d711..cda06f2 100644
--- a/arch/arm/mach-at91rm9200/at91rm9200_time.c
+++ b/arch/arm/mach-at91rm9200/at91rm9200_time.c
@@ -36,6 +36,8 @@ static unsigned long last_crtr;
 
 #ifdef CONFIG_IPIPE
 #include <linux/clk.h>
+#include <linux/stringify.h>
+#include <linux/err.h>
 #include <linux/console.h>
 #include <linux/module.h>
 #include <asm/arch/at91_tc.h>
@@ -371,10 +373,8 @@ static struct irqaction at91rm9200_timer_irq = {
 	.handler	= &at91rm9200_timer_interrupt
 };
 
-static char clk_name [] = "tc%";
-
-static struct clk tc = {
-	.name		= (const char *) clk_name,
+static struct clk *tc, local_tc = {
+	.name		= "tc" __stringify(CONFIG_IPIPE_AT91_TC) "_clk",
 	.users          = 0,
 	.type		= CLK_TYPE_PERIPHERAL,
 	.pmc_mask       = 1 << (KERNEL_TIMER_IRQ_NUM),
@@ -391,9 +391,12 @@ void __init at91rm9200_timer_init(void)
 	if (clk_get_rate(clk_get(NULL, "mck")) != CONFIG_IPIPE_AT91_MCK)
 		at91rm9200_timer_irq.handler = &at91rm9200_bad_freq;
 
-	snprintf(clk_name, sizeof(clk_name), "tc%d", CONFIG_IPIPE_AT91_TC);
-	clk_register(&tc);
-	clk_enable(&tc);
+	tc = clk_get(NULL, local_tc.name);
+	if (IS_ERR(tc)) {
+		tc = &local_tc;
+		clk_register(tc);
+	}
+	clk_enable(tc);
 	
 	/* No Sync. */
 	at91_tc_write(AT91_TC_BCR, 0);
diff --git a/drivers/net/arm/at91_ether.c b/drivers/net/arm/at91_ether.c
diff --git a/net/ipv4/ipconfig.c b/net/ipv4/ipconfig.c

--MuvIaO7L8V--

