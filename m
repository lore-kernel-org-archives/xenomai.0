Message-ID: <447ED64F.7090902@domain.hid>
Date: Thu, 01 Jun 2006 11:58:07 +0000
From: "s.a." <sancelot@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-core] io apic and shared irq questions
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai@xenomai.org

Hi,

Regarding an embedded realtime system, I have got a communication board
on pci bus .

I would like it's interrupt not being shared (with usb) , because the
component receives an it every 100us and is realtime determinist.
I looked at how was routed IRQ's with the io apic , although it is able
to use 24 irq's, linux always share my PCI boards IRQ with another
component and do not use all the 24 irq's range capability of ioapic.

Do you think it is possible to program the ioapic in order to have a
better irq mapping and avoid this problem and use all the range of
availbale vectors ?

Best Regards
Steph







