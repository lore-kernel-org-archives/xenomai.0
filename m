Message-ID: <481048A0.7040101@domain.hid>
Date: Thu, 24 Apr 2008 10:45:20 +0200
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <48100D81.9090109@domain.hid>
In-Reply-To: <48100D81.9090109@domain.hid>
Content-Type: multipart/mixed; boundary="------------080209050500030608010308"
Sender: Philippe Gerum <philippe.gerum@domain.hid>
Subject: Re: [Xenomai-core] Cannot end interrupt from user space:
 add	rt_intr_end call ?
Reply-To: rpm@xenomai.org
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Tomas Kalibera <kalibera@domain.hid>
Cc: xenomai-core <xenomai@xenomai.org>

This is a multi-part message in MIME format.
--------------080209050500030608010308
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Tomas Kalibera wrote:
> Hi,
> 
> I think that when I handle interrupts from user space, I cannot 
> correctly use I_NOAUTOENA. The thing is that this flag in fact means "do 
> not call automatically xnarch_end_irq". The xnarch_end_irq call usually 
> maps to unmasking the interrupt, but not always - depending on interrupt 
> type (sometimes in eoi, sometimes is nop).
> 
> I was thinking that it would be nice if I could call something like 
> "xnarch_end_irq" (i.e. rt_intr_end) from user space, so that I could 
> correctly use I_NOAUTOENA to control the flow of interrupts.
>

What would this buy you? xnarch_irq_end() would still handle the unmasking logic
depending on the interrupt type, because it knows how the interrupt was
acknowledged in the first place -- in contrast, the application does not and
should not.

xnarch_end_irq() basically calls the ->unmask() method of the interrupt chip
descriptor, which is the same as calling rt_intr_enable(). Before you do that,
you may want to try the attached patch, which makes sure that
rt_intr_enable/disable are eagerly routed to unmask/mask on x86 for post-2.6.18
kernels. That patch is expected to solve the "rt_intr_disable() not masking
IO-APIC interrupt" issue we discussed earlier.

> Cheers,
> Tomas
> 
> 
> 
> _______________________________________________
> Xenomai-core mailing list
> Xenomai-core@domain.hid
> https://mail.gna.org/listinfo/xenomai-core
> 


-- 
Philippe.

--------------080209050500030608010308
Content-Type: text/x-diff;
 name="unconditionally-apply-irq-enable-disable-requests-to-pic.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename*0="unconditionally-apply-irq-enable-disable-requests-to-pic.pat";
 filename*1="ch"

Index: include/asm-x86/wrappers_32.h
===================================================================
--- include/asm-x86/wrappers_32.h	(revision 3708)
+++ include/asm-x86/wrappers_32.h	(working copy)
@@ -163,8 +163,8 @@
 
 #define rthal_irq_chip_end(irq)	rthal_irq_chip_enable(irq)
 #else /* >= 2.6.19 */
-#define rthal_irq_chip_enable(irq)   ({ rthal_irq_descp(irq)->chip->enable(irq); 0; })
-#define rthal_irq_chip_disable(irq)  ({ rthal_irq_descp(irq)->chip->disable(irq); 0; })
+#define rthal_irq_chip_enable(irq)   ({ rthal_irq_descp(irq)->chip->unmask(irq); 0; })
+#define rthal_irq_chip_disable(irq)  ({ rthal_irq_descp(irq)->chip->mask(irq); 0; })
 #define rthal_irq_chip_end(irq)      ({ rthal_irq_descp(irq)->ipipe_end(irq, rthal_irq_descp(irq)); 0; })
 typedef irq_handler_t rthal_irq_host_handler_t;
 
Index: include/asm-x86/wrappers_64.h
===================================================================
--- include/asm-x86/wrappers_64.h	(revision 3708)
+++ include/asm-x86/wrappers_64.h	(working copy)
@@ -31,8 +31,8 @@
 #define rthal_irq_descp(irq)		(irq_desc + irq)
 #define rthal_irq_desc_status(irq)	(rthal_irq_descp(irq)->status)
 
-#define rthal_irq_chip_enable(irq)   ({ rthal_irq_descp(irq)->chip->enable(irq); 0; })
-#define rthal_irq_chip_disable(irq)  ({ rthal_irq_descp(irq)->chip->disable(irq); 0; })
+#define rthal_irq_chip_enable(irq)   ({ rthal_irq_descp(irq)->chip->unmask(irq); 0; })
+#define rthal_irq_chip_disable(irq)  ({ rthal_irq_descp(irq)->chip->mask(irq); 0; })
 #define rthal_irq_chip_end(irq)      ({ rthal_irq_descp(irq)->ipipe_end(irq, rthal_irq_descp(irq)); 0; })
 
 typedef irq_handler_t rthal_irq_host_handler_t;

--------------080209050500030608010308--

