Message-ID: <45BF8A92.8010900@domain.hid>
Date: Tue, 30 Jan 2007 19:12:34 +0100
From: Steven Scholz <steven.scholz@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] I-pipe patch for linux 2.6.19 on ARM.
References: <45BF08D8.5050208@domain.hid>
In-Reply-To: <45BF08D8.5050208@domain.hid>
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai-core <xenomai@xenomai.org>

Gilles,

> here comes the I-pipe patch for linux 2.6.19 on ARM. In addition to the
> upgrade to linux 2.6.19, the AT91 port is improved:

Thanks very much.

> I have not tested the other ports, so, please test the patch on the ARM
> you use if you can.

Did you actually try this patch against a vanilla 2.6.19 + 2.6.19-at91.patch.gz?

a) it does not apply cleanly. failing in
   arch/arm/mach-at91rm9200/at91rm9200.c	and
   include/asm-arm/arch-at91rm9200/hardware.h

b) asm/arch/at91rm9200_tc.h is called asm/arch/at91_tc.h now
--- linux-2.6.19.orig/arch/arm/mach-at91rm9200/at91rm9200_time.c
+++ linux-2.6.19/arch/arm/mach-at91rm9200/at91rm9200_time.c
@@ -38,7 +38,7 @@ static unsigned long last_crtr;
 #include <linux/clk.h>
 #include <linux/console.h>
 #include <linux/module.h>
-#include <asm/arch/at91rm9200_tc.h>
+#include <asm/arch/at91_tc.h>
 #include "clock.h"

 #ifdef CONFIG_NO_IDLE_HZ


c) Kernel with adoes-ipipe compiles (after fixing the above), but xenomai
does not compile and bails out with

arch/arm/xenomai/hal.c: In function `rthal_irq_host_request':
arch/arm/xenomai/hal.c:115: warning: passing arg 2 of `request_irq' from
incompatible pointer type
arch/arm/xenomai/hal.c: In function `rthal_irq_enable':
arch/arm/xenomai/hal.c:144: error: structure has no member named `disable_depth'
arch/arm/xenomai/hal.c: In function `rthal_irq_disable':
arch/arm/xenomai/hal.c:156: error: structure has no member named `disable_depth'

--
Steven


