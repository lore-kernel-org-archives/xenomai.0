From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <20110307092604.GA21619@domain.hid>
References: <20110302151603.GA14557@domain.hid>
	<4D6E61B6.906@domain.hid> <4D6E8A06.9060508@domain.hid>
	<20110303072147.GA4353@domain.hid>
	<1299137548.2072.3.camel@domain.hid> <4D6F88D6.4010105@domain.hid>
	<4D6F89C8.9060005@domain.hid> <1299156880.2072.6.camel@domain.hid>
	<4D702802.5080001@domain.hid> <1299225060.2107.20.camel@domain.hid>
	<20110307092604.GA21619@domain.hid>
Content-Type: text/plain; charset="UTF-8"
Date: Mon, 07 Mar 2011 17:37:17 +0100
Message-ID: <1299515837.2088.47.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Stuck MSI in normal Linux driver
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Richard Cochran <richardcochran@domain.hid>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>, Jan Kiszka <jan.kiszka@domain.hid>

On Mon, 2011-03-07 at 10:26 +0100, Richard Cochran wrote:
> On Fri, Mar 04, 2011 at 08:51:00AM +0100, Philippe Gerum wrote:
> > I'm not saying this would be impossible to enable MSIs there, I'm just
> > saying that so far: nobody cared. Terrae incognitae.
> 
> Philippe,
> 
> I read adeos-ipipe-2.6.36-powerpc-2.12-02.patch in order to
> re-acquaint myself with adeos. While I do not pretend to really
> understand it, I did notice an incongruity in the interrupt handling
> for my particular board.

Yes, that code is broken (untested actually).

> 
> The function, fsl_msi_cascade, in arch/powerpc/sysdev/fsl_msi.c:185
> has in the non-ipipe version two different actions
> 
> 	desc->chip->unmask(irq);
> 	desc->chip->eoi(irq);
> 
> depending on whether the controller is an ipic or mpic. The ipipe
> code unconditionally executes ipic/unmask.
> 
> I noticed that the function 
> 
> 	cpm_cascade() in arch/powerpc/platforms/8xx/m8xx_setup.c
> 
> does call eoi(), so I guessed that the eoi() in fsl_msi_cascade()
> might have been overlooked. Putting the eoi() into the ipipe version
> lets the machine handle the interrupts, and my test programs will even
> run with the PCIe card and driver.
> 
> However, I am really making a grab in the dark, and I see strange
> warnings like unexpected (in_irq() || irqs_disabled()) from
> kernel/softirq.c:143 and so on.

Possibly because the decoded cascade IRQ should be routed to the
I-pipe's low level handler, not through generic_handle_irq(). It
probably re-enters the linux domain context in the middle of nowhere.

> 
> Also, more interrupts appear for my card in /proc/interrupts than
> expected.
> 
> Is this any kind of hint, or am I just completely lost?
> 

No, your logic is right. The fsl_msi handler is utterly wrong there.
Please try the following patch (not even compiled, but should be mostly
ok -- famous last words). You should scrap all I-pipe changes on
arch/powerpc/sysdev/fsl_msi.c before applying it, it is based on the
vanilla 2.6.36 code.

A bit of context:

The pipeline installs all chained IRQ handlers as primary ack handlers
(fired from __ipipe_handle_irq()), so we run fsl_msi_handler() from the
lowest I-pipe core code, for all incoming msi (multiplex) IRQs. When the
pipeline is enabled, that routine is expected to mask[+eoi] the
multiplex IRQ, decode the cascaded one(s), tell the pipeline about that
IRQ, then unmask the multiplex IRQ.

Basically, IRQs routed through the mpic are fasteoi ones, so we should
run the chip's ->eoi() handler for the multiplexed IRQ in such a case,
to do mask+eoi (I-pipe specific behavior to lower the interrupt priority
early). ipic-routed IRQs are either level/edge ones, but we don't care
since there won't be any deferral in acknowledging the cascaded IRQ, so
hopefully, the interrupt source should not freak out badly. Of course,
it might decide to freak out in case there is a deferral in running the
cascaded IRQ handler, but so far, it has never been an issue.

Eventually, in both cases (mpic/ipic), we should unmask the IRQ once we
propagated the cascaded one to the I-pipe primary handler via
ipipe_handle_chained_irq().

diff --git a/arch/powerpc/sysdev/fsl_msi.c b/arch/powerpc/sysdev/fsl_msi.c
index 87991d3..af106ee 100644
--- a/arch/powerpc/sysdev/fsl_msi.c
+++ b/arch/powerpc/sysdev/fsl_msi.c
@@ -182,6 +182,63 @@ out_free:
 	return rc;
 }
 
+#ifdef CONFIG_IPIPE
+
+static void fsl_msi_cascade(unsigned int irq, struct irq_desc *desc)
+{
+	unsigned int cascade_irq;
+	struct fsl_msi *msi_data;
+	int msir_index = -1;
+	u32 msir_value = 0;
+	u32 intr_index;
+	u32 have_shift = 0;
+	struct fsl_msi_cascade_data *cascade_data;
+
+	cascade_data = (struct fsl_msi_cascade_data *)get_irq_data(irq);
+	msi_data = cascade_data->msi_data;
+
+	if ((msi_data->feature &  FSL_PIC_IP_MASK) == FSL_PIC_IP_IPIC) {
+		if (desc->chip->mask_ack)
+			desc->chip->mask_ack(irq);
+		else {
+			desc->chip->mask(irq);
+			desc->chip->ack(irq);
+		}
+	} else
+		desc->chip->eoi(irq);
+
+	msir_index = cascade_data->index;
+
+	if (msir_index >= NR_MSI_REG)
+		cascade_irq = NO_IRQ;
+
+	switch (msi_data->feature & FSL_PIC_IP_MASK) {
+	case FSL_PIC_IP_MPIC:
+		msir_value = fsl_msi_read(msi_data->msi_regs,
+			msir_index * 0x10);
+		break;
+	case FSL_PIC_IP_IPIC:
+		msir_value = fsl_msi_read(msi_data->msi_regs, msir_index * 0x4);
+		break;
+	}
+
+	while (msir_value) {
+		intr_index = ffs(msir_value) - 1;
+
+		cascade_irq = irq_linear_revmap(msi_data->irqhost,
+				msir_index * IRQS_PER_MSI_REG +
+					intr_index + have_shift);
+		if (cascade_irq != NO_IRQ)
+			ipipe_handle_chained_irq(cascade_irq);
+		have_shift += intr_index + 1;
+		msir_value = msir_value >> (intr_index + 1);
+	}
+
+	desc->chip->unmask(irq);
+}
+
+#else /* !CONFIG_IPIPE */
+
 static void fsl_msi_cascade(unsigned int irq, struct irq_desc *desc)
 {
 	unsigned int cascade_irq;
@@ -250,6 +307,8 @@ unlock:
 	raw_spin_unlock(&desc->lock);
 }
 
+#endif /* !CONFIG_IPIPE */
+
 static int fsl_of_msi_remove(struct platform_device *ofdev)
 {
 	struct fsl_msi *msi = ofdev->dev.platform_data;

> Thanks,
> 
> Richard
> 

-- 
Philippe, cursed with IRQs.



