Message-ID: <ff1d78710711050046o29f8520bu8356bbb4b479cd46@domain.hid>
Date: Mon, 5 Nov 2007 09:46:45 +0100
From: "Steven Kauffmann" <steven.kauffmann@domain.hid>
In-Reply-To: <ff1d78710711050043h7ebe3bc1l88c180d36c800d3@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/alternative; 
	boundary="----=_Part_9542_21536993.1194252405163"
References: <200710311542.l9VFgax19256@domain.hid>
	<ff1d78710711050043h7ebe3bc1l88c180d36c800d3@domain.hid>
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
To: Wolfgang Grandegger <wg@domain.hid>, xenomai@xenomai.org

------=_Part_9542_21536993.1194252405163
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Oct 31, 2007 4:42 PM, Wolfgang Grandegger <wg@domain.hid> wrote:

>
>
> >
> > Hi
> >
> > I'm writing a RTDM driver that works with a PCI FPGA card. This card
> > generates an interrupt when its calculation is done. To deal with
> interrupts
> > I have to know the interrupt line number. I found this in Linux device
> > drivers:
> >
> > result = pci_read_config_byte(dev, PCI_INTERRUPT_LINE, &my_irq);
>
> You should use "dev->irq". There is no need to read that PCI
> configuration register (have a look to the PCI drivers in drivers/net").
>

Ok, dev->irq gives number 22 and interrupt is working.


> >
> > The result is 10, but the result of lspci -v is:
> >
> > 01:01.0 Bridge: Teradyne Inc Unknown device fa56
> >         Subsystem: Unknown device 0004:0299
> >         Flags: medium devsel, IRQ 22
> >         Memory at fc000000 (32-bit, non-prefetchable) [size=32M]
> >
> > So the interrupt line number is now 22. If I use this interrupt line
> number
> > in the function rtdm_irq_request, than the interrupt handler is working.
>
> > When I use the interrupt line number received from the read_config_byte
> > function nothing happens.
> > In linux device drivers they write that the value of PCI_INTERRUPT_LINE
> is
> > guaranteed to be the right one, but why is it not working?
> >
> > The intention of the driver is that an user space application writes
> some
> > data to the PCI card, the card does something with it. The user space
> > application have to wait until an interrupt occures, than it reads the
> > result from the PCI card. How can the driver informs the user space
> > application that an interrupt occurred?
>
> Even if it is not needed by the PCI card, the IRQ vector is normally
> written to the card. What does the following command for your card
> show:
>
>  $ od -t x4 /proc/bus/pci/01/08.0


The last number should be 01.0 instead of 08.0 I think or am I wrong?
lspci give this result:

 lspci
01:01.0 Bridge: Teradyne Inc Unknown device fa56
01:08.0 Ethernet controller: Intel Corporation 82562EZ 10/100 Ethernet
Controller (rev 02)

  od -t x4 /proc/bus/pci/01/01.0
0000000 fa561316 02000102 06800000 00000000
0000020 fc000000 00000000 00000000 00000000
0000040 00000000 00000000 00000000 02990004
0000060 00000000 00000000 00000000 0000010a
0000100 00000000 00000000 00000000 00000000
*
0000400

Is there not something like a signal I can set in the interrupt routine of
the driver. The user space application have to wait its execution until the
signal is set?

Steven

------=_Part_9542_21536993.1194252405163
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Oct 31, 2007 4:42 PM, Wolfgang Grandegger &lt;<a href="mailto:wg@domain.hid" target="_blank">wg@domain.hid</a>&gt; wrote:<br><div class="gmail_quote"><div class="gmail_quote"><div class="Ih2E3d"><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">

<div><br><br>&gt;<br>&gt; Hi<br>&gt;<br>&gt; I&#39;m writing a RTDM driver that works with a PCI FPGA card. This card<br>&gt; generates an interrupt when its calculation is done. To deal with<br>interrupts<br>
&gt; I have to know the interrupt line number. I found this in Linux device<br>&gt; drivers:<br>&gt;<br>&gt; result = pci_read_config_byte(dev, PCI_INTERRUPT_LINE, &amp;my_irq);<br><br></div>You should use &quot;dev-&gt;irq&quot;. There is no need to read that PCI
<br>configuration register (have a look to the PCI drivers in drivers/net&quot;).<br><div></div></blockquote></div><div><br>Ok, dev-&gt;irq gives number 22 and interrupt is working.<br><br></div><div class="Ih2E3d"><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">

<div><br>&gt;<br>&gt; The result is 10, but the result of lspci -v is:<br>&gt;<br>&gt; 01:01.0 Bridge: Teradyne Inc Unknown device fa56<br>&gt; &nbsp; &nbsp; &nbsp; &nbsp; Subsystem: Unknown device 0004:0299<br>&gt; &nbsp; &nbsp; &nbsp; &nbsp; Flags: medium devsel, IRQ 22
<br>&gt; &nbsp; &nbsp; &nbsp; &nbsp; Memory at fc000000 (32-bit, non-prefetchable) [size=32M]<br>&gt;<br>&gt; So the interrupt line number is now 22. If I use this interrupt line<br>number<br>&gt; in the function rtdm_irq_request, than the interrupt handler is working.
<br>&gt; When I use the interrupt line number received from the read_config_byte<br>&gt; function nothing happens.<br>&gt; In linux device drivers they write that the value of PCI_INTERRUPT_LINE is<br>&gt; guaranteed to be the right one, but why is it not working?
<br>&gt;<br>&gt; The intention of the driver is that an user space application writes some<br>&gt; data to the PCI card, the card does something with it. The user space<br>&gt; application have to wait until an interrupt occures, than it reads the
<br>&gt; result from the PCI card. How can the driver informs the user space<br>&gt; application that an interrupt occurred?<br><br></div>Even if it is not needed by the PCI card, the IRQ vector is normally<br>written to the card. What does the following command for your card
<br>show:<br><br> &nbsp;$ od -t x4 /proc/bus/pci/01/08.0</blockquote></div><div><br>The last number should be 01.0 instead of 08.0 I think or am I wrong?<br>lspci give this result:<br><br>&nbsp;lspci<div class="Ih2E3d"><br>01:01.0
 Bridge: Teradyne Inc Unknown device fa56
<br></div>01:08.0 Ethernet controller: Intel Corporation 82562EZ 10/100 Ethernet Controller (rev 02)<br><br>&nbsp; od -t x4 /proc/bus/pci/01/01.0<br>0000000 fa561316 02000102 06800000 00000000<br>0000020 fc000000 00000000 00000000 00000000
<br>0000040 00000000 00000000 00000000 02990004<br>0000060 00000000 00000000 00000000 0000010a<br>0000100 00000000 00000000 00000000 00000000<br>*<br>0000400<br><br></div><div>Is there not something like a signal I can set in the interrupt routine of the driver. The user space application have to wait its execution until the signal is set?
<br><br>Steven<br></div></div>
</div><br>

------=_Part_9542_21536993.1194252405163--

