MIME-Version: 1.0
Date: Sat, 26 Jan 2013 15:14:32 +0530
Message-ID: <CADyNBOrp7hhKd-rbyfFoykVgQmSKho93RzJ2rRahZw6DsLFEgA@mail.gmail.com>
From: Amit Bhaira <a.hearthacker.b@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Subject: [Xenomai] (no subject)
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org, tanmoybag@gmail.com

We are writing a rtdm driver for pci das card, its getting an irq line
shared with a linux kernel device i.e uhci_hcd:usb3.
Can we disable the irq line in our driver? Or shall we disable the
particular usb driver?
Or would u suggest any other solution coz our driver is making the
system unresponsive?. Or is there any way to get an independent irq
line for my device.

