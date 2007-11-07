From: Leopold Palomo-Avellaneda <lepalom@domain.hid>
Date: Wed, 7 Nov 2007 18:59:32 +0100
References: <200711061807.26236.lepalom@domain.hid>
	<200711071500.23914.lepalom@domain.hid> <4731CAE5.5080401@domain.hid>
In-Reply-To: <4731CAE5.5080401@domain.hid>
MIME-Version: 1.0
Message-Id: <200711071859.33094.lepalom@domain.hid>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Disposition: inline
Subject: [Xenomai-help] IRQ issues in xenomai and rtnet
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: xenomai@xenomai.org, mathias_koehrer@domain.hid

Hi,

following the Jan Kiszka propose I move this thread to the xenomai list. 
Making some kind of resume I have this situation:

- Mobo Gigabyte M61P-S3 with bios updated (nVidia nForce 430 chipset, amd64)
- two old network intel e100 cards PCI
- one jr3 sensor capture PCI
- running a debian etch amd64 port with several kernels 2.6.22, rtai, xenomai, 
debian. The box _must_ boot with noapic in the grub because not hangs trying 
with the hd controller :-(

- running a debian etch amd64 port with several kernels 2.6.23, xenomai, 
debian. The box boot with apic :-)


the kernel config is based on a standard debian config and the xenomai part is 
based on the faq. The only issue that I have realised some minutes ago have 
been that Shared interrupts is disable (but Jan Kiszka have pointed that it 
does not produce hangs.

I have selected in the bios that each pci slot htat has a ethernet has a 
specific irq, but when I load a rtnet driver, it assigns another irq. Making 
more test, now with 2.6.23 the irq assigned in bios more or less i maintained 
but still _again_ when load the rtnet driver, the box hangs ...

I must put a irq specific for each card if not the kernel doesn't boot or I 
put irq auto and irqpoll in the kenel options. With this configuration I can 
configure the cards:


palomo@domain.hid$ sudo ./sbin/rtroute
Host Routing Table
Hash    Destination     HW Address              Device
3F      10.0.1.255      FF:FF:FF:FF:FF:FF       rteth1
3F      10.0.0.255      FF:FF:FF:FF:FF:FF       rteth0

and the system doesn't hang ...


So, any ideas about it?

Best regards,

and very thanks for all your effort,

Leo

A Dimecres 07 Novembre 2007, Jan Kiszka va escriure:

> Leopold Palomo-Avellaneda wrote:
> > A Dimecres 07 Novembre 2007, Karl Reichert va escriure:
> > [...]
> >
> >>> the _same_ card was working with rtnet (not xenomai but rtai) in a
> >>> configuration that I had in another box.
> >>
> >> That's what I mean, the card is not the problem. The problem is the
> >> current setup, so as a result it is not working. But of course not the
> >> card is the one to blame. ...
> >
> > are you working for intel? ;-)
> >
> > no, I'm joking.
> >
> > Sadly, I have tested the same configuration with a rtai kernel and I got
> > the same hang :-( Also, the network card got the same irq in rtai ...
>
> IRQ issues are generally I-pipe issues. And RTAI uses (almost) the same
> I-pipe patch as Xenomai, thus shares the same bugs until they are fixed
> upstream. Generally.
>
> There are currently a few fixes floating around on Adeos-main, and we
> (Xenomai) have some new report probably regarding MSI. As I think I have
> seen something about MSI in your config as well, could you try to
> disable CONFIG_PCI_MSI to check if at least the hangs disappears (given,
> of course, IRQs line will then not be in conflict again)? Also can you
> try (unless you already do so) with the latest I-pipe patch for, say,
> 2.6.23.x?
>
> Another hint regard IRQ conflict avoidance: If RTnet (or RT hardware in
> general) shares some line with a Linux device you may not depend upon
> (Firewire? USB?), just unload the related Linux drivers. Of course, this
> doesn't fly if it is your main IDE/SATA device...
>
> Note that this IRQ stuff is most likely not RTnet business, so it would
> be good to move the thread over to Xenomai.
>
> Jan



