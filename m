MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="M41n2Qq6Uf"
Content-Transfer-Encoding: 7bit
Message-ID: <18489.30774.304777.148110@domain.hid>
Date: Sun, 25 May 2008 16:31:18 +0200
In-Reply-To: <d6c8ef150805231056n3a9ea030jada65bd5a7c2a2c0@domain.hid>
References: <d6c8ef150805231056n3a9ea030jada65bd5a7c2a2c0@domain.hid>
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Subject: Re: [Xenomai-help] Interrupt priorities and handling problems
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Bosko Radivojevic <bosko.radivojevic@domain.hid>
Cc: xenomai-help <xenomai@xenomai.org>


--M41n2Qq6Uf
Content-Type: text/plain; charset=us-ascii
Content-Description: message body and .signature
Content-Transfer-Encoding: 7bit

Bosko Radivojevic wrote:
 > Hi all!
 > 
 > Before I ask my questions, I'll remind about my environment:
 > AT91SAM9260 based board (ARM), Xenomai 2.4.3, Kernel 2.6.24, I-Pipe
 > 1.9-01. We have external interrupt source connected to PIO line (IRQ1
 > line) which should 'wake up' our code every 1ms. For the sake of
 > performances, we create interrupt handler in kernel space.
 > 
 > 1. Two interrupts instead of one
 > 
 > Somehow, ISR get called twice for every single interrupt, at the
 > falling edge. I've tried to set interrupt source type (setting some
 > registers directly on the microcontroller) but whatever I set, ISR
 > call happens at the falling edge. The second comes right after the
 > first one, but not together.
 > 
 > When I tried to handle interrupt from the userspace, rt_intr_wait() returns
 > 1, so it looks like "second" interrupt comes a little bit later. If I
 > generate more (n) interrupts during handling one, the next
 > rt_intr_wait() returns n*2+1. This +1 is the second interrupt that
 > came right after the handled one.
 > 
 > The quite weird thing is that sometimes (not so often, like every 1
 > hour) ISR is called just once. Where should I start digging?

Does the following patch help ?

-- 


					    Gilles.

--M41n2Qq6Uf
Content-Type: text/plain
Content-Disposition: inline;
	filename="xeno-arm-use-mask-unmask-instead-of-enable-disable.diff"
Content-Transfer-Encoding: 7bit

Index: include/asm-arm/wrappers.h
===================================================================
--- include/asm-arm/wrappers.h	(revision 3873)
+++ include/asm-arm/wrappers.h	(working copy)
@@ -64,8 +64,8 @@ typedef irqreturn_t (*rthal_irq_host_han
 extern void (*fp_init)(union fp_state *);
 #else /* >= 2.6.19 */
 #define rthal_irq_desc_lock(irq) (&rthal_irq_descp(irq)->lock)
-#define rthal_irq_chip_enable(irq)   ({ rthal_irq_descp(irq)->chip->enable(irq); 0; })
-#define rthal_irq_chip_disable(irq)  ({ rthal_irq_descp(irq)->chip->disable(irq); 0; })
+#define rthal_irq_chip_enable(irq)   ({ rthal_irq_descp(irq)->chip->unmask(irq); 0; })
+#define rthal_irq_chip_disable(irq)  ({ rthal_irq_descp(irq)->chip->mask(irq); 0; })
 #define rthal_irq_chip_end(irq)      ({ rthal_irq_descp(irq)->ipipe_end(irq, rthal_irq_descp(irq)); 0; })
 typedef irq_handler_t rthal_irq_host_handler_t;
 #define rthal_mark_irq_disabled(irq) do {              \

--M41n2Qq6Uf--

