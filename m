Message-ID: <ff1d78710710310723i4d9c31fcjed65091be91c34eb@domain.hid>
Date: Wed, 31 Oct 2007 15:23:08 +0100
From: "Steven Kauffmann" <steven.kauffmann@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/alternative; 
	boundary="----=_Part_2414_27149629.1193840588827"
Subject: [Xenomai-help] RTDM interrupt questions
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai@xenomai.org

------=_Part_2414_27149629.1193840588827
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi

I'm writing a RTDM driver that works with a PCI FPGA card. This card
generates an interrupt when its calculation is done. To deal with interrupts
I have to know the interrupt line number. I found this in Linux device
drivers:

result = pci_read_config_byte(dev, PCI_INTERRUPT_LINE, &my_irq);

The result is 10, but the result of lspci -v is:

01:01.0 Bridge: Teradyne Inc Unknown device fa56
        Subsystem: Unknown device 0004:0299
        Flags: medium devsel, IRQ 22
        Memory at fc000000 (32-bit, non-prefetchable) [size=32M]

So the interrupt line number is now 22. If I use this interrupt line number
in the function rtdm_irq_request, than the interrupt handler is working.
When I use the interrupt line number received from the read_config_byte
function nothing happens.
In linux device drivers they write that the value of PCI_INTERRUPT_LINE is
guaranteed to be the right one, but why is it not working?

The intention of the driver is that an user space application writes some
data to the PCI card, the card does something with it. The user space
application have to wait until an interrupt occures, than it reads the
result from the PCI card. How can the driver informs the user space
application that an interrupt occurred?

thanks in advance

Steven

------=_Part_2414_27149629.1193840588827
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi<br><br>I&#39;m writing a RTDM driver that works with a PCI FPGA card. This card generates an interrupt when its calculation is done. To deal with interrupts I have to know the interrupt line number. I found this in Linux device drivers: 
<br><br>result = pci_read_config_byte(dev, PCI_INTERRUPT_LINE, &amp;my_irq);<br>
<br>The result is 10, but the result of lspci -v is:<br><br>01:01.0 Bridge: Teradyne Inc Unknown device fa56<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Subsystem: Unknown device 0004:0299<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Flags: medium devsel, IRQ 22<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Memory at fc000000 (32-bit, non-prefetchable) [size=32M]
<br><br>So the interrupt line number is now 22. If I use this interrupt line number in the function rtdm_irq_request, than the interrupt handler is working. When I use the interrupt line number received from the read_config_byte function nothing happens.
<br>In linux device drivers they write that the value of PCI_INTERRUPT_LINE is guaranteed to be the right one, but why is it not working?<br><br>The intention of the driver is that an user space application writes some data to the PCI card, the card does something with it. The user space application have to wait until an interrupt occures, than it reads the result from the PCI card. How can the driver informs the user space application that an interrupt occurred?
<br><br>thanks in advance<br><br>Steven<br><br><br>

------=_Part_2414_27149629.1193840588827--

