Subject: Re: [Xenomai-core] No hardware interrupts with xenomai on ppc405
From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <4507FBD7.5010008@domain.hid>
References: <4503EB88.2040309@domain.hid>
	<200609111904.16512.matthias.fuchs@domain.hid>
	<4505A75B.8000601@domain.hid>
	<200609120932.20196.matthias.fuchs@domain.hid>
	<45068DFE.3090408@domain.hid> <1158141962.5066.17.camel@domain.hid>
	<4507DEB6.3070808@domain.hid>  <1158147361.5066.25.camel@domain.hid>
	<1158147598.5066.30.camel@domain.hid>  <4507FBD7.5010008@domain.hid>
Content-Type: text/plain
Date: Wed, 13 Sep 2006 14:50:17 +0200
Message-Id: <1158151817.5066.39.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
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
To: Wolfgang Grandegger <wg@domain.hid>
Cc: Jan Kiszka <jan.kiszka@domain.hid>, xenomai@xenomai.org

On Wed, 2006-09-13 at 14:38 +0200, Wolfgang Grandegger wrote:
> Philippe Gerum wrote:
> > On Wed, 2006-09-13 at 13:36 +0200, Philippe Gerum wrote:
> >> On Wed, 2006-09-13 at 12:34 +0200, Wolfgang Grandegger wrote:
> >>> Philippe Gerum wrote:
> >>>> On Tue, 2006-09-12 at 12:37 +0200, Wolfgang Grandegger wrote:
> >>>>> Matthias Fuchs wrote:
> >>>>>> On Monday 11 September 2006 20:13, Wolfgang Grandegger wrote:
> >>>>>>> In 2.6 the interrupts are disabled by default. Then the attached patch 
> >>>>>>> for Xenomai should help.
> >>>>>>>
> >>>>>>> Wolfgang.
> >>>>>>>
> >>>>>> Your patch also works fine. Now what's the recommended solution? I noticed 
> >>>>>> that Philippe already checked in an Adeos fix.
> >>>>> As mentioned, in Linux 2.6 (generic IRQ layer), IRQs are disabled by 
> >>>>> default in kernel/irq/handle.c:
> >>>>>
> >>>>>    irq_desc_t irq_desc[NR_IRQS] __cacheline_aligned = {
> >>>>>          [0 ... NR_IRQS-1] = {
> >>>>>                  .status = IRQ_DISABLED,
> >>>>>                  .handler = &no_irq_type,
> >>>>>                  .lock = SPIN_LOCK_UNLOCKED
> >>>>>          }
> >>>>>    };
> >>>>>
> >>>>> Till now, I haven't found IPIPE/Xenomai related code removing the 
> >>>>> IRQ_DISABLED bit. But I wonder why it's working for x86. Maybe I have 
> >>>>> missed something.
> >>>>>
> >>>>> In Linux 2.4, the "status" field is initialized to 0 (in 
> >>>>> arch/ppc/kernel/irq.c) not making trouble:
> >>>>>
> >>>>>    irq_desc_t irq_desc[NR_IRQS] __cacheline_aligned =
> >>>>>          { [0 ... NR_IRQS-1] = { 0, NULL, NULL, 0, SPIN_LOCK_UNLOCKED}};
> >>>>>
> >>>>> At least my CAN PCI card on a MPC5200 works fine.
> >>>>>
> >>>>> Philippe, do we really need these ugly PIC patches?
> >>>> Not anymore, since we decided to stop supporting a tortuous use case
> >>>> where some IRQ channel could be shared between a Xenomai ISR and a Linux
> >>>> handler for handling mixed RT/non-RT devices (which was something of a
> >>>> bugous design anyway). Doing so, the patch was about preventing
> >>>> IRQ_INPROGRESS to block IRQ reenabling requests issued from a Xenomai
> >>>> ISR (i.e. in case a RT interrupt preempts the regular Linux handler for
> >>>> the same IRQ channel).
> >>>>
> >>>> The problem I see now, is that removing the work-arounds from the
> >>>> various PIC code would void the ability to use recent Adeos patches with
> >>>> older Xenomai releases. I'm not opposed to that, provided we backport
> >>>> your fix to 2.1.x and above, but this is an issue we should keep in
> >>>> mind. Perhaps the next Adeos patches should even make un-fixed Xenomai
> >>>> releases choke at compilation time.
> >>> We could also set the relevant status field bits to 0 somewhere in the 
> >>> IPIPE-patch when the IRQ is requested or overtaken. I think this is a 
> >>> general issue (not only on PowerPC).
> >> This would not clear the issue for IRQ_INPROGRESS, which is raised upon
> >> IRQ handling.
> > 
> > I mean this would not fix all the use cases, but this would be
> > sufficient to solve the non-tortuous ones, I agree. So yes, IRQ_DISABLED
> > could just be cleared in ipipe_virtualize_irq_from(), and that should be
> > enough.
> 
> Ok, should I fix that and remove all PowerPC PIC patches already for the 
> Adeos iPipe PPC patch for 2.6.18rc6 I'm currently working on?
> 

This is the way I fixed it for Adeos over ppc, so that I can apply the
same logic to all other supported archs:

--- kernel/ipipe/core.c	20 Jun 2006 17:15:23 -0000	1.28
+++ kernel/ipipe/core.c	13 Sep 2006 12:47:05 -0000
@@ -565,20 +565,22 @@
 	ipd->irqs[irq].acknowledge = acknowledge;
 	ipd->irqs[irq].control = modemask;
 
-	if (irq < NR_IRQS &&
-	    handler != NULL &&
-	    !ipipe_virtual_irq_p(irq) && (modemask & IPIPE_ENABLE_MASK) != 0) {
-		if (ipd != ipipe_current_domain) {
-			/* IRQ enable/disable state is domain-sensitive, so we may
-			   not change it for another domain. What is allowed
-			   however is forcing some domain to handle an interrupt
-			   source, by passing the proper 'ipd' descriptor which
-			   thus may be different from ipipe_current_domain. */
-			err = -EPERM;
-			goto unlock_and_exit;
-		}
+	if (irq < NR_IRQS && handler != NULL && !ipipe_virtual_irq_p(irq)) {
+		__ipipe_enable_irqdesc(irq);
 
-		__ipipe_enable_irq(irq);
+		if ((modemask & IPIPE_ENABLE_MASK) != 0) {
+			if (ipd != ipipe_current_domain) {
+				/* IRQ enable/disable state is domain-sensitive, so we may
+				   not change it for another domain. What is allowed
+				   however is forcing some domain to handle an interrupt
+				   source, by passing the proper 'ipd' descriptor which
+				   thus may be different from ipipe_current_domain. */
+				err = -EPERM;
+				goto unlock_and_exit;
+			}
+			
+			__ipipe_enable_irq(irq);
+		}
 	}
 
 	err = 0;
Index: include/asm-ppc/ipipe.h
===================================================================
RCS file: /var/cvs/adeos/ipipe/v2.6/common/include/asm-ppc/ipipe.h,v
retrieving revision 1.28
diff -u -r1.28 ipipe.h
--- include/asm-ppc/ipipe.h	10 Sep 2006 15:10:03 -0000	1.28
+++ include/asm-ppc/ipipe.h	13 Sep 2006 12:47:05 -0000
@@ -146,7 +146,9 @@
 
 #define __ipipe_check_platform()	do { } while(0)
 
-#define __ipipe_enable_irq(irq)		enable_irq(irq)
+#define __ipipe_enable_irqdesc(irq)	do { irq_desc[irq].status &= ~IRQ_DISABLED; } while(0)
+
+#define __ipipe_enable_irq(irq)	enable_irq(irq)
 
 #define __ipipe_disable_irq(irq)	disable_irq(irq)
 
> Wolfgang.
-- 
Philippe.



