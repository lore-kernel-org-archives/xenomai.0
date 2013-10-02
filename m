Message-ID: <524BDFD7.5010104@xenomai.org>
Date: Wed, 02 Oct 2013 10:56:55 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <8ceffc54095e43d88f6dfa0edd0bb852@DBXPR03MB093.eurprd03.prod.outlook.com>
	<52496200.2010808@xenomai.org>
	<295e5f6a1e6849079d9fb3e53dcc1827@DBXPR03MB093.eurprd03.prod.outlook.com>
	<524B1F6C.7080705@xenomai.org>
	<0181d61119d749ecaf4bfea3b3c827f3@DBXPR03MB093.eurprd03.prod.outlook.com>
In-Reply-To: <0181d61119d749ecaf4bfea3b3c827f3@DBXPR03MB093.eurprd03.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] No GPIO IRQ on imx28(apf28), kernel 3.8.13
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Antoine MOREL <A.MOREL@polysoude.com>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

On 10/02/2013 08:08 AM, Antoine MOREL wrote:
> I try the same software (file main.c) with and without adeos.
> It works without adeos, and it doesn't work with adeos!
> Did I forget anything to do with adeos?
> The same software can run well with and without adeos?

Please try the following patch:

diff --git a/drivers/gpio/gpio-mxs.c b/drivers/gpio/gpio-mxs.c
index fa2a63c..a8c6fe2 100644
--- a/drivers/gpio/gpio-mxs.c
+++ b/drivers/gpio/gpio-mxs.c
@@ -137,7 +137,7 @@ static void mxs_gpio_irq_handler(u32 irq, struct irq_desc *desc)
 
 	while (irq_stat != 0) {
 		int irqoffset = fls(irq_stat) - 1;
-		generic_handle_irq(irq_find_mapping(port->domain, irqoffset));
+		ipipe_handle_demuxed_irq(irq_find_mapping(port->domain, irqoffset));
 		irq_stat &= ~(1 << irqoffset);
 	}
 }



-- 
                                                                Gilles.

