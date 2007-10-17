From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <47160AD3.4090109@domain.hid>
References: <4705ED3B.4070600@domain.hid>
	<2ff1a98a0710050130j7e0db84dq838aab0417c8bd3f@domain.hid>
	<4705FE04.7000909@domain.hid> <1191576011.20623.114.camel@domain.hid>
	<470611FA.30103@domain.hid> <1191592977.20623.142.camel@domain.hid>
	<470A26BC.506@domain.hid> <1192015852.22917.197.camel@domain.hid>
	<470F7F2E.3020206@domain.hid>  <470F82FF.9020701@domain.hid>
	<1192203284.6499.135.camel@domain.hid>  <470F978B.1000005@domain.hid>
	<1192207431.6499.161.camel@domain.hid>  <4715C70F.4040501@domain.hid>
	<1192610471.5973.4.camel@domain.hid>  <4715CE15.10202@domain.hid>
	<1192612658.5973.11.camel@domain.hid>  <47160AD3.4090109@domain.hid>
Content-Type: text/plain
Date: Wed, 17 Oct 2007 15:46:03 +0200
Message-Id: <1192628763.5973.16.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: Philippe Gerum <philippe.gerum@domain.hid>
Subject: Re: [Xenomai-help] awful latencies (~110us)
Reply-To: rpm@xenomai.org
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: CHABAL David <david.chabal@domain.hid>
Cc: xenomai@xenomai.org

On Wed, 2007-10-17 at 15:14 +0200, CHABAL David wrote:
> :| + *func                 -84    0.389  mask_and_ack_8259A+0x14 
> (__ipipe_ack_level_irq+0x22)
> :| + *func                 -84    0.397  __ipipe_spin_lock_irqsave+0x9 
> (mask_and_ack_8259A+0x29)
> :| # *(0x11)  0x0000000e   -83!  17.062  mask_and_ack_8259A+0xbc 
> (__ipipe_ack_level_irq+0x22)
> :| # *(0x22)  0x0000000e   -66!  23.096  mask_and_ack_8259A+0xca 
> (__ipipe_ack_level_irq+0x22)
> :| # *(0x33)  0x0000000e   -43    0.415  mask_and_ack_8259A+0xf3 
> (__ipipe_ack_level_irq+0x22)
> :| # *func                 -43    0.418 
> __ipipe_spin_unlock_irqrestore+0x9 (mask_and_ack_8259A+0x67)
> :| + *func                 -42    0.397  __ipipe_walk_pipeline+0xa 

Grmmff... I think the PIC on this box has some deep troubles; please try
this patch, in replacement of the previous ipipe_trace_special
instrumentation:

--- 2.6.20-ipipe-1.8-08/arch/i386/kernel/i8259.c~	2007-10-12
18:19:31.000000000 +0200
+++ 2.6.20-ipipe-1.8-08/arch/i386/kernel/i8259.c	2007-10-17
15:42:35.000000000 +0200
@@ -128,7 +128,7 @@
  * This has to be protected by the irq controller spinlock
  * before being called.
  */
-static inline int i8259A_irq_real(unsigned int irq)
+int i8259A_irq_real(unsigned int irq)
 {
 	int value;
 	int irqmask = 1<<irq;
@@ -174,6 +174,8 @@
 	 */
 	if (cached_irq_mask & irqmask)
 		goto spurious_8259A_irq;
+
+	ipipe_trace_special(0x77, irq);
 #ifdef CONFIG_IPIPE
 	if (irq == 0) {
 		outb(0x60,PIC_MASTER_CMD);	/* 'Specific EOI to master */
@@ -185,18 +187,14 @@
 
 handle_real_irq:
 	if (irq & 8) {
-		ipipe_trace_special(0x10, irq);
-		inb(PIC_SLAVE_IMR);	/* DUMMY - (do we need this?) */
-		ipipe_trace_special(0x11, irq);
 		outb(cached_slave_mask, PIC_SLAVE_IMR);
 		outb(0x60+(irq&7),PIC_SLAVE_CMD);/* 'Specific EOI' to slave */
 		outb(0x60+PIC_CASCADE_IR,PIC_MASTER_CMD); /* 'Specific EOI' to
master-IRQ2 */
-		ipipe_trace_special(0x12, irq);
 	} else {
-		inb(PIC_MASTER_IMR);	/* DUMMY - (do we need this?) */
 		outb(cached_master_mask, PIC_MASTER_IMR);
 		outb(0x60+irq,PIC_MASTER_CMD);	/* 'Specific EOI to master */
 	}
+	ipipe_trace_special(0x99, irq);
 	spin_unlock_irqrestore(&i8259A_lock, flags);
 	return;

-- 
Philippe.



