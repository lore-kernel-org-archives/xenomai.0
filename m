Message-ID: <fd6a47a90602151034q8ed6920r@domain.hid>
Date: Wed, 15 Feb 2006 19:34:21 +0100
From: Jeroen Van den Keybus <jeroen.vandenkeybus@domain.hid>
Subject: Re: [Xenomai-core] Handling PCI MSI interrupts
In-Reply-To: <fd6a47a90602151002q3f38748ep@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/alternative; 
	boundary="----=_Part_20411_25695936.1140028461964"
References: <fd6a47a90602140744lc1d4365q@domain.hid>
	<fd6a47a90602141007g7830d31fu@domain.hid>
	<43F21ED7.3030501@domain.hid> <43F220D7.6040705@domain.hid>
	<fd6a47a90602141052u1e136db8y@domain.hid>
	<fd6a47a90602141133v6aeae6e1n@domain.hid>
	<fd6a47a90602141341j21ce1b77l@domain.hid>
	<43F2521E.7040200@domain.hid>
	<fd6a47a90602150300y5e435a22i@domain.hid>
	<fd6a47a90602151002q3f38748ep@domain.hid>
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Philippe Gerum <rpm@xenomai.org>
Cc: xenomai-core <xenomai@xenomai.org>

------=_Part_20411_25695936.1140028461964
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Ok. I=B4ve found it. The MSI interrupt type uses its end() handler to
acknowledge the interrupt using ack_APIC_irq() (drivers/pci/msi.c). Xenomai
uses the ack() handler to expedite the acknowledgement of an IRQ. In case o=
f
MSI, ack() is a NOP.

The main problem is that Xenomai redefines ack_APIC_irq() calls (they becom=
e
NOPs, as defined in apic.h). Maybe the ISRs used so far never issued
ack_APIC_irq() themselves, and used always the IO-APIC (which contains the
correct __ack_APIC_irq() call) ?

I feel a bit awkward about changing msi.c .

Any opinions about how to change Xenomai / Linux ?



Jeroen.

------=_Part_20411_25695936.1140028461964
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Ok. I=B4ve found it. The MSI interrupt type uses its end() handler to
acknowledge the interrupt using ack_APIC_irq() (drivers/pci/msi.c).
Xenomai uses the ack() handler to expedite the acknowledgement of an
IRQ. In case of MSI, ack() is a NOP.<br>
<br>
The main problem is that Xenomai redefines ack_APIC_irq() calls (they
become NOPs, as defined in apic.h). Maybe the ISRs used so far never
issued ack_APIC_irq() themselves, and used always the IO-APIC (which
contains the correct __ack_APIC_irq() call) ?<br>
<br>
I feel a bit awkward about changing msi.c .<br>
<br>
Any opinions about how to change Xenomai / Linux ?<br>
<br>
<br>
<br>
Jeroen.<br>
<br>

------=_Part_20411_25695936.1140028461964--

