Message-ID: <45F6C586.2050808@domain.hid>
Date: Tue, 13 Mar 2007 16:38:46 +0100
From: Edouard TISSERANT <edouard.tisserant@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-help] Xenomai: xnintr_irq_handler: IRQ0 not handled.
	Disabling IRQ line.
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

Hi all.

I'm trying to implement support for the CAN PCMCIA Peak card with 
Xenomai in official Peak driver.

First, I would like to know if someone already got success in writing 
some Xenomai IRQ handler for some PCMCIA devices. Is that a nonsense ? I 
believe I'm missing something in the way PCMCIA socket controller 
handles interrupts, linux side.

I can observe on my laptop that PCMCIA socket controller IRQ and card 
IRQ do not conflict :

----------------------
cat /proc/interrupts
           CPU0
  0:     163304   IO-APIC-edge      timer, rthal_broadcast_timer
  1:        178   IO-APIC-edge      i8042
  8:          2   IO-APIC-edge      rtc
  9:         72   IO-APIC-fasteoi   acpi
 12:        124   IO-APIC-edge      i8042
 14:      13347   IO-APIC-edge      ide0
 17:      36411   IO-APIC-fasteoi   uhci_hcd:usb5, HDA Intel, eth0
 18:          1   IO-APIC-fasteoi   uhci_hcd:usb4, yenta
 19:          0   IO-APIC-fasteoi   ehci_hcd:usb1, uhci_hcd:usb2
 20:          0   IO-APIC-fasteoi   uhci_hcd:usb3
[...]

----------------------
cat /proc/pcan

*------------ PEAK-Systems CAN interfaces (www.peak-system.com) 
-------------
*--------------------------  Release_20070306_n  
----------------------------
*------------------- [mod] [isa] [pci] [dng] [pcc] [rt] 
---------------------
*--------------------- 2 interfaces @ major 000 found 
-----------------------
*n -type- ndev --base-- irq --btr- --read-- --write- --irqs-- -errors- 
status
40 pccard -NA- 00002100 003 0x001c 00000000 00000000 00000000 00000000 
0x0000
41 pccard -NA- 00002120 003 0x001c 00000000 00000000 00000000 00000000 
0x0000
----------------------

In other worlds, PCMCIA subsystem claims that device IRQ is #3.

When registering interrupt, I get this message :

Xenomai: xnintr_irq_handler: IRQ0 not handled. Disabling IRQ line.

Handler looses more than 90% of #3 IRQ's.

Any experience about PCMCIA/Xenomai would be welcome.

Regards

Edouard.


