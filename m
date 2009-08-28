Resent-To: Xenomai help <xenomai@xenomai.org>
Resent-Message-Id: <4A978513.5010207@domain.hid>
Message-ID: <4A97812B.7070802@domain.hid>
Date: Fri, 28 Aug 2009 09:03:07 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <2f7260f50908260246jed2b885q9c67375b19343920@domain.hid>	<4A9566C9.7000805@domain.hid>	<2f7260f50908270146h4e80b012q22d00219e62233be@domain.hid>
	<4A96F641.30303@domain.hid>
In-Reply-To: <4A96F641.30303@domain.hid>
Content-Type: multipart/mixed; boundary="------------040309020406010807080706"
Subject: Re: [Xenomai-help] Problem with PXA320 and xenomai 2.4.9
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: =?UTF-8?B?SW1hbm9sIE1hcnTDrW5leg==?= <imanolmc@domain.hid>
Cc: xenomai@xenomai.org

This is a multi-part message in MIME format.
--------------040309020406010807080706
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Gilles Chanteperdrix wrote:
> Imanol Mart=C3=ADnez wrote:
>>> Please check that when starting from the configuration where you have=

>>> the bug, if you disable Xenomai (CONFIG_XENOMAI) and the interrupt
>>> pipeline (CONFIG_IPIPE), the system works.
>> This way it works, but when applying the patch it still does not work,=
 I
>> get the same error...
>=20
> Ok. And with this one?

If it does not work, try that one.

--=20
					    Gilles.

--------------040309020406010807080706
Content-Type: text/x-diff;
 name="ipipe-pxa-gpio.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="ipipe-pxa-gpio.diff"

diff --git a/arch/arm/plat-pxa/gpio.c b/arch/arm/plat-pxa/gpio.c
index 9bb16fe..6a30b57 100644
--- a/arch/arm/plat-pxa/gpio.c
+++ b/arch/arm/plat-pxa/gpio.c
@@ -253,7 +253,8 @@ void __ipipe_mach_demux_irq(unsigned irq, struct pt_regs *regs)
 			while (n < BITS_PER_LONG) {
 				loop = 1;
 
-				__ipipe_handle_irq(gpio_base + n, regs);
+				__ipipe_handle_irq(
+					gpio_to_irq(gpio_base + n), regs);
 				n = find_next_bit(&gedr, BITS_PER_LONG, n + 1);
 			}
 		}
@@ -319,7 +320,11 @@ void __init pxa_init_gpio(int mux_irq, int start, int end, set_wake_t fn)
 
 	for (irq  = gpio_to_irq(start); irq <= gpio_to_irq(end); irq++) {
 		set_irq_chip(irq, &pxa_muxed_gpio_chip);
+#ifndef CONFIG_IPIPE
 		set_irq_handler(irq, handle_edge_irq);
+#else /* CONFIG_IPIPE */
+		set_irq_handler(irq, handle_level_irq);
+#endif /* CONFIG_IPIPE */
 		set_irq_flags(irq, IRQF_VALID | IRQF_PROBE);
 	}
 

--------------040309020406010807080706--


