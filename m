Date: Wed, 31 Oct 2007 16:42:36 +0100
Message-Id: <200710311542.l9VFgax19256@domain.hid>
From: "Wolfgang Grandegger" <wg@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Subject: Re: [Xenomai-help] RTDM interrupt questions
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Steven Kauffmann <steven.kauffmann@domain.hid>, xenomai@xenomai.org



> 
> Hi
> 
> I'm writing a RTDM driver that works with a PCI FPGA card. This card
> generates an interrupt when its calculation is done. To deal with
interrupts
> I have to know the interrupt line number. I found this in Linux device
> drivers:
> 
> result = pci_read_config_byte(dev, PCI_INTERRUPT_LINE, &my_irq);

You should use "dev->irq". There is no need to read that PCI
configuration register (have a look to the PCI drivers in drivers/net").

> 
> The result is 10, but the result of lspci -v is:
> 
> 01:01.0 Bridge: Teradyne Inc Unknown device fa56
>         Subsystem: Unknown device 0004:0299
>         Flags: medium devsel, IRQ 22
>         Memory at fc000000 (32-bit, non-prefetchable) [size=32M]
> 
> So the interrupt line number is now 22. If I use this interrupt line
number
> in the function rtdm_irq_request, than the interrupt handler is working.
> When I use the interrupt line number received from the read_config_byte
> function nothing happens.
> In linux device drivers they write that the value of PCI_INTERRUPT_LINE is
> guaranteed to be the right one, but why is it not working?
> 
> The intention of the driver is that an user space application writes some
> data to the PCI card, the card does something with it. The user space
> application have to wait until an interrupt occures, than it reads the
> result from the PCI card. How can the driver informs the user space
> application that an interrupt occurred?

Even if it is not needed by the PCI card, the IRQ vector is normally
written to the card. What does the following command for your card
show:

  $ od -t x4 /proc/bus/pci/01/08.0

Wolfgang.



