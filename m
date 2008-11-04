From: Alexis Berlemont <berlemont.hauw@domain.hid>
Date: Tue, 4 Nov 2008 23:38:46 +0100
References: <9c789a000811031222oab34c08n32d94f83288154f3@domain.hid>
	<9c789a000811032341l94ad3can622a31d3088230dc@domain.hid>
	<9c789a000811040012n2f776c44m51e34f5139f6066b@domain.hid>
In-Reply-To: <9c789a000811040012n2f776c44m51e34f5139f6066b@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200811042338.47072.berlemont.hauw@domain.hid>
Subject: Re: [Xenomai-help] SegFault on Comedi-rtdm for Xenomai!!
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai-help <xenomai@xenomai.org>, Cristian Axenie <cristian.axenie@domain.hid>

Hi,

> >> Where did you get the modules ni_mite.ko ni_pcimio.ko ? Did you perform
> >> the
> >> porting or did you use the version I made (as POC) ? If you use mine,
> >> take great care: as I have no NI acquisition card, I was unable to
> >> validate the drivers (that is the reason why the driver is not in the
> >> trunk). I just ported them so as to find some flaws in the reworked
> >> Comedi kernel API.
> >>
> >> >I used the modules generated in the comedi-rtdm-dev directory in
> >>
> >> comedi_drivers/ni_drivers/ after configure, make and make install for my
> >> linux-2.6.24 kernel with Xenomai.I haven't ported them just use >them as
> >> they were. My porting job refers to a bigger application written with
> >> Comedi / RTAI specific functions and the posibility to use Comedi for
> >> Xenomai corresponding functions to ensure the port.

OK. You are not supposed to use the branch comedi-rtdm-dev. The comedi4rtdm 
code has been integrated in the trunk.

> > Could send more data on that point ? Did you get an OOPS in the kernel
> >
> > traces ?

> >> > no OOPS just segmentation fault and there is no error log or something
> >>
> >> in /var/log/lastlog .
> >
> > insmod comedi.ko
> >
> >> /mnt/usb1 # insmod ni_mite.ko
> >> Available NI device IDs: 0x2a70
> >> /mnt/usb1 # insmod ni_pci~1.ko
> >> /mnt/usb1 # lsmod
> >> Module                  Size  Used by    Not tainted
> >> ni_pcimio 33512 0 - Live 0xc9897000
> >> ni_mite 4548 1 ni_pcimio, Live 0xc9076000
> >> comedi 32656 1 ni_pcimio, Live 0xc9881000
>
>     /mnt/usb2/comedi~2 # ./cmd_read
>      Segmentation fault

Could you check whether you have the same problem with the trunk code ? The NI 
driver is not integrated into the trunk; it was not validated.
Instead of using the NI driver, you could use the fake driver 
(XENO_DRIVERS_COMEDI_FAKE).

Alexis.


