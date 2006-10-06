Message-ID: <47746.127.0.0.1.1160160976.squirrel@domain.hid>
Date: Fri, 6 Oct 2006 18:56:16 -0000 (UTC)
From: "Wael BACHTA" <wael@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain;charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Subject: [Xenomai-core] kernel panic
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

I use an Intel Pentium 4 processor which can be used as 2 virtual
processors when setting the SMP option during the kernel compiling (I can
see 2 processors with "cat /proc/cpuinfo").

I patched the kernel with adeos in order to install xenomai. I discovered
that :
- when completely disabling the ACPI and setting the SMP, my system boots
but I have only one processor when I look into /proc/cpuinfo
- Everything goes well when I don't disable completely the ACPI.

I also use a PCI framegrabber. its driver is a real time one developed
under xenomai. I noticed that this driver works fine only if the PCI_MSI
is set. Otherwise, I don't have any interrupts.

I must use my real time driver and the 2 virtual processors.
But, when I enable the ACPI, the SMP and the PCI_MSI, I have a kernel
panic. My PC boots when I disable the ACPI but I loose 1 processor.

I don't see what's wrong.

Thanks for your help,

Wael.

-------------------------------------
Wael BACHTA
Strasbourg I University
LSIIT Laboratory, AVR group
Bd S. Brant
BP 10413, 67412 ILLKIRCH cedex, FRANCE
Tel : +33 (0)3 90 24 44 78
Fax : +33 (0)3 90 24 44 80
http://eavr.u-strasbg.fr


