Message-ID: <c73373920803070354l6f01a645qab488b53abd6e90b@domain.hid>
Date: Fri, 7 Mar 2008 12:54:34 +0100
From: "Salvatore De Astis" <dev.rinux@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/alternative; 
	boundary="----=_Part_13356_5119227.1204890874819"
Subject: [Xenomai-help] IRQ problem
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

------=_Part_13356_5119227.1204890874819
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi,
I've two PCI Exar Octal Uart XR17D158. To set up the boards I change the
MAX_DEVICES  from 8  to 16 in 16550A.c.
At strartup I this messages:

ACPI: PCI interrupt for device 0000:02:07.0 disabled
ACPI: PCI interrupt for device 0000:02:05.0 disabled
ACPI: PCI Interrupt 0000:02:05.0[A] -> Link [LNKB] -> GSI 9 (level, low) ->
IRQ 9
0000:02:05.0: ttyS4 at MMIO 0xdfcff000 (irq = 9) is a 16550A
0000:02:05.0: ttyS5 at MMIO 0xdfcff200 (irq = 9) is a 16550A
0000:02:05.0: ttyS6 at MMIO 0xdfcff400 (irq = 9) is a 16550A
0000:02:05.0: ttyS7 at MMIO 0xdfcff600 (irq = 9) is a 16550A
0000:02:05.0: ttyS8 at MMIO 0xdfcff800 (irq = 9) is a 16550A
0000:02:05.0: ttyS9 at MMIO 0xdfcffa00 (irq = 9) is a 16550A
0000:02:05.0: ttyS10 at MMIO 0xdfcffc00 (irq = 9) is a 16550A
0000:02:05.0: ttyS11 at MMIO 0xdfcffe00 (irq = 9) is a 16550A
ACPI: PCI Interrupt 0000:02:07.0[A] -> Link [LNKD] -> GSI 11 (level, low) ->
IRQ 11
0000:02:07.0: ttyS12 at MMIO 0xdfcfe000 (irq = 11) is a 16550A
0000:02:07.0: ttyS13 at MMIO 0xdfcfe200 (irq = 11) is a 16550A
0000:02:07.0: ttyS14 at MMIO 0xdfcfe400 (irq = 11) is a 16550A
0000:02:07.0: ttyS15 at MMIO 0xdfcfe600 (irq = 11) is a 16550A
0000:02:07.0: ttyS16 at MMIO 0xdfcfe800 (irq = 11) is a 16550A
0000:02:07.0: ttyS17 at MMIO 0xdfcfea00 (irq = 11) is a 16550A
0000:02:07.0: ttyS18 at MMIO 0xdfcfec00 (irq = 11) is a 16550A
0000:02:07.0: ttyS19 at MMIO 0xdfcfee00 (irq = 11) is a 16550A

So I load xeno_16650A in this way:
modprobe xeno_16550A
mem=0xdfcff000,0xdfcff200,0xdfcff400,0xdfcff600,0xdfcff800,0xdfcffa00,0xdfcffc00,0xdfcffe00,0xdfcfe000,0xdfcfe200,0xdfcfe400,0xdfcfe600,0xdfcfe800,0xdfcfea00,0xdfcfec00,0xdfcfee00
irq=9,9,9,9,9,9,9,9,11,11,11,11,11,11,11,11

On the first bord I can read and write data. On the second I start to write
but as I try to move the usb mouse I have this:

Xenomai: xnintr_edge_shirq_handler: IRQ11 not handled. Disabling IRQ line.

What's the problem?
Thanks

Salvatore De Astis

------=_Part_13356_5119227.1204890874819
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi,<br>I&#39;ve two PCI Exar Octal Uart XR17D158. To set up the boards I change the MAX_DEVICES&nbsp; from 8&nbsp; to 16 in 16550A.c.<br>At strartup I this messages:<br><br>ACPI: PCI interrupt for device 0000:02:07.0 disabled<br>ACPI: PCI interrupt for device 0000:02:05.0 disabled<br>
ACPI: PCI Interrupt 0000:02:05.0[A] -&gt; Link [LNKB] -&gt; GSI 9 (level, low) -&gt; IRQ 9<br>0000:02:05.0: ttyS4 at MMIO 0xdfcff000 (irq = 9) is a 16550A<br>0000:02:05.0: ttyS5 at MMIO 0xdfcff200 (irq = 9) is a 16550A<br>
0000:02:05.0: ttyS6 at MMIO 0xdfcff400 (irq = 9) is a 16550A<br>0000:02:05.0: ttyS7 at MMIO 0xdfcff600 (irq = 9) is a 16550A<br>0000:02:05.0: ttyS8 at MMIO 0xdfcff800 (irq = 9) is a 16550A<br>0000:02:05.0: ttyS9 at MMIO 0xdfcffa00 (irq = 9) is a 16550A<br>
0000:02:05.0: ttyS10 at MMIO 0xdfcffc00 (irq = 9) is a 16550A<br>0000:02:05.0: ttyS11 at MMIO 0xdfcffe00 (irq = 9) is a 16550A<br>ACPI: PCI Interrupt 0000:02:07.0[A] -&gt; Link [LNKD] -&gt; GSI 11 (level, low) -&gt; IRQ 11<br>
0000:02:07.0: ttyS12 at MMIO 0xdfcfe000 (irq = 11) is a 16550A<br>0000:02:07.0: ttyS13 at MMIO 0xdfcfe200 (irq = 11) is a 16550A<br>0000:02:07.0: ttyS14 at MMIO 0xdfcfe400 (irq = 11) is a 16550A<br>0000:02:07.0: ttyS15 at MMIO 0xdfcfe600 (irq = 11) is a 16550A<br>
0000:02:07.0: ttyS16 at MMIO 0xdfcfe800 (irq = 11) is a 16550A<br>0000:02:07.0: ttyS17 at MMIO 0xdfcfea00 (irq = 11) is a 16550A<br>0000:02:07.0: ttyS18 at MMIO 0xdfcfec00 (irq = 11) is a 16550A<br>0000:02:07.0: ttyS19 at MMIO 0xdfcfee00 (irq = 11) is a 16550A<br>
<br>So I load xeno_16650A in this way:<br>modprobe xeno_16550A mem=0xdfcff000,0xdfcff200,0xdfcff400,0xdfcff600,0xdfcff800,0xdfcffa00,0xdfcffc00,0xdfcffe00,0xdfcfe000,0xdfcfe200,0xdfcfe400,0xdfcfe600,0xdfcfe800,0xdfcfea00,0xdfcfec00,0xdfcfee00 irq=9,9,9,9,9,9,9,9,11,11,11,11,11,11,11,11<br>
<br>On the first bord I can read and write data. On the second I start to write but as I try to move the usb mouse I have this:<br><br>Xenomai: xnintr_edge_shirq_handler: IRQ11 not handled. Disabling IRQ line.<br><br>What&#39;s the problem?<br>
Thanks<br><br>Salvatore De Astis<br>

------=_Part_13356_5119227.1204890874819--

