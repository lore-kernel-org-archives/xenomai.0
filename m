From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <307507.12667.qm@domain.hid>
References: <307507.12667.qm@domain.hid>
Content-Type: text/plain; charset="UTF-8"
Date: Mon, 09 Aug 2010 12:34:29 +0200
Message-ID: <1281350069.1706.139.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Having trouble with a BeagleBoard GPIO interrupt
 pin
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: bob.feretich@domain.hid
Cc: xenomai@xenomai.org

On Mon, 2010-08-09 at 02:54 -0700, Bob Feretich wrote:
> I am converting my second driver to RTDM. This one receives a
> negativing going edge triggered interrupt on GPIO133 of the OMAP3
> chip.
> 
> I have...
> ret = rtdm_irq_request(&adis_data_rdy_irq_handle, irq, 
>                    adis_data_rdy_irq_handler, 
>                    RTDM_IRQTYPE_EDGE, 
>                    "asuspidvr", ctx);
> then...
> ret = rtdm_irq_enable(&adis_data_rdy_irq_handle);
> 
> but the interrupt handler is never invoked.
> 
> cat /proc/xenomai/irq shows:
> IRQ         CPU0
>  37:       15815         [timer]
>  39:           0         asuspidvr
>  48:           0         asuspidvr
>  91:           0         asuspidvr
> 293:           0         asuspidvr
> 418:           0         [virtual]
> 
> IRQ 293 in the interrupt that should be happening.
> 
> I can see the pulses on the input pin and the non-rt version of the
> driver sees the interrupts, so that excludes hardware issues and
> u-boot pin configuration issues.
> 
> Any suggestions?
> Regards,
> Bob Feretich
> 
> 
> __

For some reason, that IRQ line may not be properly enabled by the core
code. Could you introduce this patch? If a valid routine is reported in
the kernel log message, you could locate it by address, from a kernel
image objdump.

diff --git a/ksrc/arch/arm/hal.c b/ksrc/arch/arm/hal.c
index 2c0dcfe..5f7800b 100644
--- a/ksrc/arch/arm/hal.c
+++ b/ksrc/arch/arm/hal.c
@@ -206,8 +206,13 @@ int rthal_irq_host_release(unsigned irq, void *dev_id)
 
 int rthal_irq_enable(unsigned irq)
 {
-    if (irq >= IPIPE_NR_XIRQS || rthal_irq_descp(irq) == NULL)
+    if (irq >= IPIPE_NR_XIRQS || rthal_irq_descp(irq) == NULL) {
+        printk(KERN_WARNING "%s: failed to enable IRQ%d\n",
+	       __FUNCTION__, irq);
         return -EINVAL;
+    }
+    printk(KERN_WARNING "%s: enabling IRQ%d (%p)\n",
+	   __FUNCTION__, irq, rthal_irq_descp(irq)->chip->unmask);
 
     /* We don't care of disable nesting level: real-time IRQ channels
        are not meant to be shared with the regular kernel. */

> _____________________________________________
> Xenomai-help mailing list
> Xenomai-help@domain.hid
> https://mail.gna.org/listinfo/xenomai-help

-- 
Philippe.



