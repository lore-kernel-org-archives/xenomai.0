Message-ID: <472B0EED.40209@domain.hid>
Date: Fri, 02 Nov 2007 12:50:05 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <fd6a47a90711020421u6c5a6dadqff4864eec6aa188@domain.hid>
In-Reply-To: <fd6a47a90711020421u6c5a6dadqff4864eec6aa188@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: Philippe Gerum <philippe.gerum@domain.hid>
Subject: Re: [Xenomai-core] Registering MSI interrupt with Xenomai fails
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
To: Jeroen Van den Keybus <jeroen.vandenkeybus@domain.hid>
Cc: xenomai-core <xenomai@xenomai.org>

Jeroen Van den Keybus wrote:
> We have a driver that operates on a PCIe card. The card has IRQ17. If we
> use it like that (IO-APIC-fasteoi), interrupt registration using
> rtdm_irq_request works correctly. (We also use rtdm_irq_enable
> afterwards, but it seems that the request already enables the interrupt.)
>  

Yes, it does.

> However, if we redefine our interrupt as MSI using pci_enable_msi(),
> rtdm_irq_request freezes the machine. (After pci_enable_msi, the new
> interrupt vector is 218 and /proc/interrupts correctly reports
> PCI-MSI-edge.)
>  
> We have another MSI-enabled card in the system (network card controlled
> by Linux) and this one works correctly. So I suspect that the Ipipe is
> clear and the bug must reside in Xenomai.
>  
> I've been adding printk instrumentation throughout the Ipipe, Xenomai
> and RTDM, but the problem is that possibly the contents of the kernel
> log do not make it to the terminal upon the freeze (no oops, no panic).
> Is there any way of efficiently debugging this ?
>

First, you may want to try commenting out the call to
xnintr_irq_enable() from rtdm_irq_request() - and your own call if any -
to check whether the system remains functional without enabling the IRQ
line. If so, then this may be an acknowledge issue.

-- 
Philippe.

