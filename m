Date: Tue, 5 May 2009 10:32:57 -0700 (PDT)
From: Martin Shepherd <mcs@domain.hid>
In-Reply-To: <4A00307E.1020405@domain.hid>
Message-ID: <Pine.LNX.4.64.0905050954390.1140@domain.hid>
References: <ff1d78710905040459u56772812kb95fb6083a2ee0c5@domain.hid> 
	<200905041409.01179.smolorz@domain.hid> 
	<ff1d78710905040630r754df1ffme2f56f51fada6302@domain.hid> 
	<200905041539.35371.smolorz@domain.hid> 
	<ff1d78710905050041sea4479eu219fa6791fae263d@domain.hid> 
	<49FFEF47.4070307@domain.hid>
	<ff1d78710905050504u3b685de3g54f0fefc046078a@domain.hid>
	<4A00307E.1020405@domain.hid>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Subject: Re: [Xenomai-help] Kernel lockup when shared IRQ is enabled
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org


On Tue, 5 May 2009, Steven Kauffmann wrote:
> I tried to get a unique IRQ for the CAN card, but it looks like it
> always shares it IRQ with another device (USB controller or VGA
> controller or ... ).

Note that there are often two flavors of USB driver loaded, one being
uhci_hcd and the other ehci_hcd. The uhci_hcd driver handles USB 1.1
devices, and on my systems it seems to use up one IRQ per USB
port. The ehci_hcd driver only seems to need one IRQ. So if you can
get away with just USB2.0 support, then you can probably free up a few
IRQs by not running the uhci_hcd driver, while leaving the EHCI driver
in place for USB2.0 devices.

> Yes, using the local APIC and IO-APIC change the irq numbers.

Indeed. With regards to this, beware that the IRQ number that the
"lspci -vv" command reports for a given PCI device, is generally wrong
until the PCI device is enabled via a call to pci_enable_device().
Before being enabled, lspci reports the value of the interrupt-line
configuration register of the PCI device, whereas after the device is
enabled, lspci reports the value that the PCI BIOS actually assigned
to the device. So be sure to use the IRQ that pertains after enabling
the device, to determine whether or not you have an IRQ conflict.

Martin

