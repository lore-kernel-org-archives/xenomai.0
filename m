Message-ID: <4C3B07A2.4020606@domain.hid>
Date: Mon, 12 Jul 2010 14:16:34 +0200
From: Theo Veenker <T.J.G.Veenker@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-help] PCI id missing from arch/x86/smi.c
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Xenomai help <xenomai@xenomai.org>

Hi,

About a year ago when installing Xenomai on a new box it appeared this
particular system required an addition to the PDI IDs table in arch/x86/smi.c.
See this thread: https://mail.gna.org/public/xenomai-help/2009-08/msg00031.html
Gilles said he would make the change to smi.c. That was with 2.4.8.

Now I'm trying 2.5.3 but again the same PCI ID is missing. Is there a
particular reason not to include this ID? On this system the SMI detection
stuff doesn't work without it.

It requires adding this line to rthal_smi_pci_tbl[]:
{PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_ICH10_1)},

Regards,
Theo

