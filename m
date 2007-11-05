Message-ID: <472EE426.1080603@domain.hid>
Date: Mon, 05 Nov 2007 10:36:38 +0100
From: Wolfgang Grandegger <wg@domain.hid>
MIME-Version: 1.0
References: <200710311542.l9VFgax19256@domain.hid>	
	<ff1d78710711050043h7ebe3bc1l88c180d36c800d3@domain.hid>
	<ff1d78710711050046o29f8520bu8356bbb4b479cd46@domain.hid>
In-Reply-To: <ff1d78710711050046o29f8520bu8356bbb4b479cd46@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
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
To: Steven Kauffmann <steven.kauffmann@domain.hid>
Cc: xenomai@xenomai.org

Steven Kauffmann wrote:
> On Oct 31, 2007 4:42 PM, Wolfgang Grandegger <wg@domain.hid
> <mailto:wg@domain.hid>> wrote:
> 
> 
> 
>     >
>     > Hi
>     >
>     > I'm writing a RTDM driver that works with a PCI FPGA card. This card
>     > generates an interrupt when its calculation is done. To deal with
>     interrupts
>     > I have to know the interrupt line number. I found this in Linux device
>     > drivers:
>     >
>     > result = pci_read_config_byte(dev, PCI_INTERRUPT_LINE, &my_irq);
> 
>     You should use "dev->irq". There is no need to read that PCI
>     configuration register (have a look to the PCI drivers in drivers/net").
> 
> 
> Ok, dev->irq gives number 22 and interrupt is working.
> 
> 
>     >
>     > The result is 10, but the result of lspci -v is:
>     >
>     > 01:01.0 Bridge: Teradyne Inc Unknown device fa56
>     >         Subsystem: Unknown device 0004:0299
>     >         Flags: medium devsel, IRQ 22
>     >         Memory at fc000000 (32-bit, non-prefetchable) [size=32M]
>     >
>     > So the interrupt line number is now 22. If I use this interrupt line
>     number
>     > in the function rtdm_irq_request, than the interrupt handler is
>     working.
>     > When I use the interrupt line number received from the
>     read_config_byte
>     > function nothing happens.
>     > In linux device drivers they write that the value of
>     PCI_INTERRUPT_LINE is
>     > guaranteed to be the right one, but why is it not working?
>     >
>     > The intention of the driver is that an user space application
>     writes some
>     > data to the PCI card, the card does something with it. The user space
>     > application have to wait until an interrupt occures, than it reads
>     the
>     > result from the PCI card. How can the driver informs the user space
>     > application that an interrupt occurred?
> 
>     Even if it is not needed by the PCI card, the IRQ vector is normally
>     written to the card. What does the following command for your card
>     show:
> 
>      $ od -t x4 /proc/bus/pci/01/08.0
> 
> 
> The last number should be 01.0 instead of 08.0 I think or am I wrong?

You are right, of course.

> lspci give this result:
> 
>  lspci
> 
> 01:01.0 Bridge: Teradyne Inc Unknown device fa56
> 01:08.0 Ethernet controller: Intel Corporation 82562EZ 10/100 Ethernet
> Controller (rev 02)
> 
>   od -t x4 /proc/bus/pci/01/01.0
> 0000000 fa561316 02000102 06800000 00000000
> 0000020 fc000000 00000000 00000000 00000000
> 0000040 00000000 00000000 00000000 02990004
> 0000060 00000000 00000000 00000000 0000010a
                                           ^^

The interrupt line written to the device is 10 and therefore wrong.
Don't know why, but you do not need it anyhow.

> 0000100 00000000 00000000 00000000 00000000
> *
> 0000400
> 
> Is there not something like a signal I can set in the interrupt routine
> of the driver. The user space application have to wait its execution
> until the signal is set?

I'm not sure if I understand your question. You can send an asynchronous
signal from the driver to a user space application. It's documented in
the Linux devic drivers book, IIRC.

Wolfgang.

