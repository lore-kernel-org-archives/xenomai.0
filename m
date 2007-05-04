From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <13626574.1178266851510.JavaMail.ngmail@domain.hid>
References: <463AE7D3.6030401@domain.hid>
	<24394502.1178264721982.JavaMail.ngmail@domain.hid>
	<13626574.1178266851510.JavaMail.ngmail@domain.hid>
Content-Type: text/plain
Date: Fri, 04 May 2007 14:20:22 +0200
Message-Id: <1178281223.29093.83.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: Philippe Gerum <philippe.gerum@domain.hid>
Subject: Re: [Xenomai-help] Xenomai and MSI enabled crashes kernel
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
To: "M. Koehrer" <mathias_koehrer@domain.hid>
Cc: xenomai@xenomai.org, jan.kiszka@domain.hid

On Fri, 2007-05-04 at 10:20 +0200, M. Koehrer wrote:
> Hi Jan,
> 
> o.k., now I understand Philippes patch.
> However, at one point, I am not quite sure if this is correct:
> Within __ipipe_handle_irq()
> the patch adds
> #ifdef CONFIG_X86_LOCAL_APIC
>                {
>                        unsigned vector = irq + FIRST_EXTERNAL_VECTOR;
>                        if (vector >= FIRST_SYSTEM_VECTOR)
>                                irq = ipipe_apic_vector_irq(vector);
>                }
> #endif
> I do not understand the if (vector >= ..) statement.
> When I am at this point, the irq value is always the vector and never an irq.

No, the trampoline code in entry.S passes us an irq actually. But there
is indeed a vector:irq mapping issue with IRQ numbers greater than 206,
which still badly conflict with system IRQs (MSI causes high numbered
IRQs to be allocated). I'm working on a patch. More later.

> Thus, I think I should call ipipe_apic_vector_irq in any case.
> I will do a test on that.
> 
> Regards
> 
> Mathias
> 
> 
> 
> ----- Original Nachricht ----
> Von:     Jan Kiszka <jan.kiszka@domain.hid>
> An:      "M. Koehrer" <mathias_koehrer@domain.hid>
> Datum:   04.05.2007 09:59
> Betreff: Re: [Xenomai-help] Xenomai and MSI enabled crashes kernel
> 
> > M. Koehrer wrote:
> > > Hi everybody,
> > > 
> > > I have been gone one step back to analyze the issue from the situation is
> > originally occurred.
> > > This was the situation that I had a 2.6.20.4 kernel and Xenomai 2.3.1
> > (included Adeos patch).
> > > When I  enable MSI in the kernel configuration I get the kernel message:
> > > "spurious APIC interrupt on CPU#0, should never happen."
> > > when trying to enable (ifconfig) the e1000 driver for an onboard PCIe
> > network adapter.
> > > 
> > > I have now used the very same kernel without Xenomai patch, but using the
> > same kernel config
> > > (MSI enabled). This returns the IRQ 223 for the Ethernet adapter.
> > > With 2.6.21 it returns IRQ 219, there seems to be a difference between
> > 2.6.20 and 2.6.21.
> > > Well, as I am working with 2.6.20.4, I looked deeper in that.
> > > 
> > > One interesting thing I found was in arch/i386/kernel/ipipe.c at function
> > __ipipe_enable_pipeline
> > > I do not understand the meaning of that code.
> > > At the beginning of that function, there are a couple of calls to
> > ipipe_virtualize_irq().
> > > These MAP the APIC system vectors.
> > > However, the second call that maps 
> > > SPURIOUS_APIC_VECTOR - FIRST_EXTERNAL_VECTOR (with is infact 223) is
> > mapped to
> > > smp_spurious_interrupt (which leads to the result I see).
> > > However, I am not sure if it is correct to use the VECTOR values here as
> > ipipe_virtualize_irq
> > > uses "irq" as second parameter and not  a vector. This looks like a vector
> > vs. irq mismatch.
> > 
> > Isn't this the issue Philippe's last patch against ipipe and xenomai fixes?
> > 
> > > 
> > > Within the create_irq() function, the e1000 creates irq 223 on vector
> > 201.
> > > 
> > > When I monitor the calls to set_intr_gate() I see that the vector 32 will
> > end up at the address
> > > of irq_entries_start, vector 32 will end up at irq_entries_start + 8 etc.
> > > In entry.S this will end up in writing ~(vector) unto the stack and
> > calling common_interrupt.
> > > This finally calls __ipipe_handle_irq.
> > > The means that __ipipe_handle_irq will not be called with the IRQ number
> > but with the vector!!
> > > It could be that this is the same for the "old" IRQ vectors (<32). 
> > > However for the MSI IRQs this seems to be not correct.
> > > I think that this could be the root cause for the problems I see.
> > 
> > Again, please verify that you are not debugging the issue that Philippe
> > may have already fixed, ie. re-evaluate your (very systematic!) findings
> > after applying the ipipe fix.
> > 
> > Jan
> > 
> > 
> 
-- 
Philippe.



