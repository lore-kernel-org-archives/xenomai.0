Message-ID: <fd6a47a90711020421u6c5a6dadqff4864eec6aa188@domain.hid>
Date: Fri, 2 Nov 2007 12:21:18 +0100
From: "Jeroen Van den Keybus" <jeroen.vandenkeybus@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/alternative; 
	boundary="----=_Part_4823_17596577.1194002478283"
Subject: [Xenomai-core] Registering MSI interrupt with Xenomai fails
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai-core <xenomai@xenomai.org>

------=_Part_4823_17596577.1194002478283
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

We have a driver that operates on a PCIe card. The card has IRQ17. If we use
it like that (IO-APIC-fasteoi), interrupt registration using
rtdm_irq_request works correctly. (We also use rtdm_irq_enable afterwards,
but it seems that the request already enables the interrupt.)

However, if we redefine our interrupt as MSI using pci_enable_msi(),
rtdm_irq_request freezes the machine. (After pci_enable_msi, the new
interrupt vector is 218 and /proc/interrupts correctly reports
PCI-MSI-edge.)

We have another MSI-enabled card in the system (network card controlled by
Linux) and this one works correctly. So I suspect that the Ipipe is clear
and the bug must reside in Xenomai.

I've been adding printk instrumentation throughout the Ipipe, Xenomai and
RTDM, but the problem is that possibly the contents of the kernel log do not
make it to the terminal upon the freeze (no oops, no panic). Is there any
way of efficiently debugging this ?

Linux 2.6.23
Adeos 1.10-11
Xenomai SVN Rev. 3146

Thanks,


Jeroen.

------=_Part_4823_17596577.1194002478283
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

<div>We have a driver that operates on a PCIe card. The card has IRQ17. If we use it like that (IO-APIC-fasteoi), interrupt registration using rtdm_irq_request works correctly. (We also use rtdm_irq_enable afterwards, but it seems that the request already enables the interrupt.)
</div>
<div>&nbsp;</div>
<div>However, if we redefine our interrupt as MSI using pci_enable_msi(), rtdm_irq_request freezes the machine. (After pci_enable_msi, the new interrupt vector is 218 and /proc/interrupts correctly reports PCI-MSI-edge.)
</div>
<div>&nbsp;</div>
<div>We have another MSI-enabled card in the system (network card controlled by Linux) and this one works correctly. So I suspect that the Ipipe is clear and the bug must reside in Xenomai.</div>
<div>&nbsp;</div>
<div>I&#39;ve been&nbsp;adding&nbsp;printk instrumentation throughout the Ipipe, Xenomai and RTDM, but the problem is that possibly the contents of the kernel log do not make it to the terminal upon the freeze (no oops, no panic). Is there any way of efficiently debugging this ?
</div>
<div>&nbsp;</div>
<div>Linux 2.6.23</div>
<div>Adeos 1.10-11</div>
<div>Xenomai SVN Rev. 3146</div>
<div>&nbsp;</div>
<div>Thanks,</div>
<div>&nbsp;</div>
<div>&nbsp;</div>
<div>Jeroen.</div>
<div>&nbsp;</div>

------=_Part_4823_17596577.1194002478283--

