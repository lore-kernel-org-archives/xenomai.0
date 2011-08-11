MIME-Version: 1.0
Date: Thu, 11 Aug 2011 11:01:12 -0400
Message-ID: <CAJZRki9OROwYG4_mqPdkHPr1f6U7bh8y7qNqfse28aGwHRiujA@mail.gmail.com>
From: Phil Mitchell <p.mitch@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Subject: [Xenomai-help] Any problems using pci_enable_msi_block on x86
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai@xenomai.org

Hello,

I am writing an RTDM driver for a custom PCI Express card that will
be used on an x86 system. The driver will be using multiple MSI
interrupts.

I know that MSI is not officially supported but in practice works
with some caveats ( see posts below ).

http://www.mail-archive.com/xenomai@xenomai.org
http://www.mail-archive.com/xenomai@xenomai.org
http://thread.gmane.org/gmane.linux.real-time.xenomai.users/12135

My question is does anyone know of any problems using
pci_enable_msi_block to request multiple MSIs? I see a number of
people have used pci_enable_msi but have not seen any references
to the block enable on any of the mailing lists.

Thanks,
Phil

