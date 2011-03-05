Resent-To: Xenomai help <xenomai@xenomai.org>
Resent-Message-Id: <4D725F8A.4090506@domain.hid>
Message-ID: <4D725BF5.70707@domain.hid>
Date: Sat, 05 Mar 2011 16:51:17 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <4D7252E1.9050000@domain.hid>
In-Reply-To: <4D7252E1.9050000@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Runtime error on PXA270 for branch
 'for-ipipe-2.6.35-arm' in 'ipipe-gch.git'
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Michael Bernhard <michael.bernhard@domain.hid>

Michael Bernhard wrote:
> Hello!
> 
> I'm trying to get running the ipipe patch on a 2.6.35 kernel. I've seen
> that Gilles was working on that port lately so I gave it a try.
> 
> The kernel is booting fine. However init does not continue and the
> NETDEV watchdog triggers:

Hi,

please use Xenomai mailing lists, not my private address.

Does the following path help?

diff --git a/arch/arm/plat-pxa/gpio.c b/arch/arm/plat-pxa/gpio.c
index 4769217..975dfe0 100644
--- a/arch/arm/plat-pxa/gpio.c
+++ b/arch/arm/plat-pxa/gpio.c
@@ -286,7 +286,7 @@ void __init pxa_init_gpio(int mux_irq, int start,
int end, set_wake_t fn)

        for (irq  = gpio_to_irq(start); irq <= gpio_to_irq(end); irq++) {
                set_irq_chip(irq, &pxa_muxed_gpio_chip);
-               set_irq_handler(irq, handle_level_irq);
+               set_irq_handler(irq, handle_edge_irq);
                set_irq_flags(irq, IRQF_VALID | IRQF_PROBE);
        }



-- 
                                                                Gilles.


