Message-ID: <4A0ABB32.8080706@domain.hid>
Date: Wed, 13 May 2009 14:21:06 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] gatekeeper/0
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: Xenomai help <xenomai@xenomai.org>

Somehow, the xenomai-help mailing list does not receive your mails. So,
I am resending your mail to the list.


Hi Gilles, Hi list,

nearly everything is working fine. I rebuild the kernel again without the
given options and it seems to work.
Even the latencies look quite much better. There is only one problem left
that bothers me.

Every time I load the rt_eepro100 for my real-time device I get the
message:

[   95.753152]   *** Receiver lock-up bug detected ***
[   95.753154]   Your device may not work reliably!

and sometimes the systems hangs (and can not be woken up) at this point.

I know that this is a hint for a irq problem but I don't know where this
should be.
My eth0 device (irq6) is not sharing this irq with an other deveice.

IRQs after boot:

         CPU0
  0:         40    XT-PIC-XT        timer
  1:         52    XT-PIC-XT        i8042
  2:          0    XT-PIC-XT        cascade
  3:          2    XT-PIC-XT
  4:        280    XT-PIC-XT        serial
  5:       6179    XT-PIC-XT        uhci_hcd:usb2, eth3,
i915@domain.hid
  6:         44    XT-PIC-XT        eth0
  7:       1293    XT-PIC-XT        ehci_hcd:usb1
  8:          2    XT-PIC-XT        rtc0
  9:         11    XT-PIC-XT        acpi
 10:          2    XT-PIC-XT
 11:          2    XT-PIC-XT
 12:        951    XT-PIC-XT        i8042
 14:       7734    XT-PIC-XT        ata_piix
 15:         40    XT-PIC-XT        uhci_hcd:usb3, ata_piix, eth1, eth2

   IRQs after I added the real-time device:

          CPU0
  0:         40    XT-PIC-XT        timer
  1:        131    XT-PIC-XT        i8042
  2:          0    XT-PIC-XT        cascade
  3:          2    XT-PIC-XT
  4:        280    XT-PIC-XT        serial
  5:      21773    XT-PIC-XT        uhci_hcd:usb2, i915@domain.hid,
eth3
  6:         71    XT-PIC-XT
  7:       2334    XT-PIC-XT        ehci_hcd:usb1
  8:          2    XT-PIC-XT        rtc0
  9:         17    XT-PIC-XT        acpi
 10:          2    XT-PIC-XT
 11:          2    XT-PIC-XT
 12:       3771    XT-PIC-XT        i8042
 14:      11960    XT-PIC-XT        ata_piix
 15:         66    XT-PIC-XT        uhci_hcd:usb3, ata_piix, eth1, eth2

cat /proc/xenomai/irq
IRQ         CPU0
  6:           1         rt_eepro100
230:           0         [IPI]
233:      170615         [timer]
234:           0         [critical sync]
258:           2         [virtual]

