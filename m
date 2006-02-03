Message-ID: <43E3E4DE.3060308@domain.hid>
Date: Fri, 03 Feb 2006 18:18:54 -0500
From: "J.D. Yamokoski" <yamokosk@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [Adeos-main] Problems booting - USB related?
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: </public/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: adeos-main@gna.org

Greetings all,

This problem originally started out after applying an RTAI patch. After 
doing some testing, I have ruled out RTAI for the moment and now down to 
ADEOS. Here are the details,

I have a vanilla kernel version 2.6.12 which I patched with 
adeos-linux-2.6.12-i386-r13.patch. The make and install went off without 
a hitch. But when I boot the machine, it hangs while appearently trying 
to load USB stuff. Here are some of the last lines it prints:


Loading uhci-hcd.ko
USB Universal Host Controller Interface driver v2.2

... seems to be finding usb devices and then on the third or fourth 
device ...

ACPI: PCI Interrupt 0000:00:1d.3[D] -> GSI 23 (level, low) -> IRQ 23
uhci_hcd 0000:00:1d.3: UHCI Host Controller
usb 1-1: new low speed USB device using uhci_hcd and address 2


Just to rule out other possibilities, I compiled a copy of the vanilla 
kernel without applying the adeos patch - no problems booting this version.

I can't remove USB support from the kernel as the machine I am on only 
has USB ports (no PS/2 plugs for mice or keyboard..). I also tried a 
google search to see if there was problems with USB and adeos.. but I 
found nothing.

Any comments or suggestions would be greatly appreciated!

J.D. Yamokoski

