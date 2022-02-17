From: Gunter Grau <gunter.grau@philips.com>
Subject: [PATCH] ipipe: Fix ipipe level irq end
Date: Thu, 17 Feb 2022 15:12:35 +0100
Message-Id: <20220217141235.868386-1-gunter.grau@philips.com>
In-Reply-To: <0b1ec490-5d7b-3ca7-7b2a-952db122d50d@siemens.com>
References: <0b1ec490-5d7b-3ca7-7b2a-952db122d50d@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

The following commit in the vanilla kernel introduced
a check for the cached interrupt mask flag in mask_irq():

bf22ff45bed6 ("genirq: Avoid unnecessary low level irq function calls")

This means if the flag is not serviced correctly
the real bit in the hardware interrupt controller may not be
cleared or set.
The __ipipe_end_level_irq() function does not follow this rule.
It unmasks the bit in the hardware without setting the cached flags
accordingly. So after the first level interrupt is finished the
mask cache has a wrong state. If now the next interrupt fires,
the mask_irq() function will not really mask the interrupt in
the hardware which causes a interrupt storm after reenabeling
the hard irqs.
The fix now also updates the shadow flag correctly.

Signed-off-by: Gunter Grau <gunter.grau@philips.com>
---
 kernel/irq/chip.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/irq/chip.c b/kernel/irq/chip.c
index 7c03e2931189..ff9a8b3f33db 100644
--- a/kernel/irq/chip.c
+++ b/kernel/irq/chip.c
@@ -988,6 +988,7 @@ void __ipipe_ack_level_irq(struct irq_desc *desc)
 void __ipipe_end_level_irq(struct irq_desc *desc)
 {
        desc->irq_data.chip->irq_unmask(&desc->irq_data);
+       irq_state_clr_masked(desc);
 }

 void __ipipe_ack_fasteoi_irq(struct irq_desc *desc)
--
2.25.1


________________________________
The information contained in this message may be confidential and legally p=
rotected under applicable law. The message is intended solely for the addre=
ssee(s). If you are not the intended recipient, you are hereby notified tha=
t any use, forwarding, dissemination, or reproduction of this message is st=
rictly prohibited and may be unlawful. If you are not the intended recipien=
t, please contact the sender by return e-mail and destroy all copies of the=
 original message.

