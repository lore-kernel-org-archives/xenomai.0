Date: Mon, 28 Mar 2005 12:50:29 +0300 (EEST)
From: "Rus V. Brushkoff" <rus@domain.hid>
In-Reply-To: <Pine.LNX.4.53.0503281139180.20969@domain.hid>
Message-ID: <Pine.LNX.4.53.0503281247290.21548@domain.hid>
References: <Pine.LNX.4.53.0503281139180.20969@domain.hid>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Subject: [Adeos-main] Adeos-2.6.11 glitch [correction]
Sender: adeos-main-admin@domain.hid
Errors-To: adeos-main-admin@domain.hid
List-Help: <mailto:adeos-main-request@domain.hid>
List-Post: <mailto:adeos-main@gna.org>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: <https://mail.gna.org/public/adeos-main/>
To: adeos-main@gna.org

On Mon, 28 Mar 2005, Rus V. Brushkoff wrote:

: After booting the system do not receive any ICH interrupt (no working
:mouse/usb/sound/eth0 ) :
:
:Normal system  /proc/interrupts :

Small correction - this is normal system with "pci=routeirq" option

:
:           CPU0
:  0:     352045    IO-APIC-edge  timer
:  1:       2029    IO-APIC-edge  i8042
:  7:          2    IO-APIC-edge  parport0
:  9:          0   IO-APIC-level  acpi
: 15:         12    IO-APIC-edge  ide1
: 16:          0   IO-APIC-level  uhci_hcd, uhci_hcd
: 17:          4   IO-APIC-level  ohci1394, Intel ICH5
: 18:      11753   IO-APIC-level  libata, uhci_hcd
: 19:       1405   IO-APIC-level  uhci_hcd
: 20:       1471   IO-APIC-level  eth0
: 23:          2   IO-APIC-level  ehci_hcd
:NMI:          0
:LOC:     351738
:ERR:          0
:MIS:          0
:

This is normal system without any boot option :

           CPU0
  0:     706871    IO-APIC-edge  timer
  1:       3976    IO-APIC-edge  i8042
  7:          2    IO-APIC-edge  parport0
  9:          0   IO-APIC-level  acpi
 15:         12    IO-APIC-edge  ide1
169:      18440   IO-APIC-level  libata, uhci_hcd
177:       4890   IO-APIC-level  eth0
185:          4   IO-APIC-level  ohci1394, Intel ICH5
193:          2   IO-APIC-level  ehci_hcd
201:          0   IO-APIC-level  uhci_hcd, uhci_hcd
209:       2093   IO-APIC-level  uhci_hcd
NMI:          0
LOC:     706616
ERR:          0
MIS:          0

:Adeos-2.6.11 system :
:
:           CPU0
:  0:     376196    IO-APIC-edge  timer
:  1:       2361    IO-APIC-edge  i8042
:  7:          2    IO-APIC-edge  parport0
:  9:          0   IO-APIC-level  acpi
: 15:         12    IO-APIC-edge  ide1
:169:      11062   IO-APIC-level  libata, uhci_hcd
:177:          0   IO-APIC-level  eth0
:185:          0   IO-APIC-level  ohci1394, Intel ICH5
:193:          0   IO-APIC-level  ehci_hcd
:201:          0   IO-APIC-level  uhci_hcd, uhci_hcd
:209:          0   IO-APIC-level  uhci_hcd
:NMI:          0
:LOC:     375889
:ERR:          0
:MIS:          0
:
: System is Intel D865PERL P4 based system. If I pass "pci=routeirq" kernel
:parameter - ICH begin to work again.
:

		Rus

