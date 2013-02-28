Message-ID: <512F3CBA.6030308@siemens.com>
Date: Thu, 28 Feb 2013 12:17:14 +0100
From: Jan Kiszka <jan.kiszka@siemens.com>
MIME-Version: 1.0
References: <CAD1EtohJTQi9jj07_NrC=anxQiqQS1=TrHecAK21uW0wBoOnYQ@mail.gmail.com>
	<512E67D4.70804@xenomai.org>
	<CAD1EtogDAPC7Q1-sq1fh1J71hQRYMoAs=HNEzZOYosxP8NeWbg@mail.gmail.com>
	<512E696A.2010106@xenomai.org> <512E69D3.6090601@xenomai.org>
	<CAD1Etoj6q+xOoK5Zgy1rpB73_9e236mpfOjCQk6+eDMa=c2Fmw@mail.gmail.com>
	<CAD1EtoiHUSqP-aXWenyHNkm8xA4dJHW_0kqiVtMJ36ssAMYPww@mail.gmail.com>
	<512E75C8.4050403@xenomai.org>
	<CAD1EtogPsUtE7L0WaYE8euo5JYZ-AGx1d1-RA50zgSiY0GUsVQ@mail.gmail.com>
	<CAD1Etoj=9FDB=Zs+qSprpDp9WUkDs6zy6HMy2ctHtekZXOv4Hg@mail.gmail.com>
In-Reply-To: <CAD1Etoj=9FDB=Zs+qSprpDp9WUkDs6zy6HMy2ctHtekZXOv4Hg@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Failing to recognize/use PEAK PCAN-miniPCIe card
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "Daniel M. Drucker, Ph.D." <dmd@interactive-motion.com>
Cc: xenomai@xenomai.org

On 2013-02-28 00:02, Daniel M. Drucker, Ph.D. wrote:
> The latest Linux driver (7.8) from PEAK (
> http://www.peak-system.com/fileadmin/media/linux/files/peak-linux-driver-7.8.tar.gz)
> has the following in its peak_pci_tbl:
> 
> #define PEAK_PCI_DEVICE_ID   0x0001  // ID for PCI / PCIe Slot cards
> #define PEAK_PCIE_CARD_ID    0x0002  // ID for PCIExpress Card
> #define PEAK_PCIE_DEVICE_ID  0x0003  // ID for new PCIe Slot cards
> #define PEAK_CPCI_ID         0x0004  // ID for new cPCI
> #define PEAK_MINIPCI_ID      0x0005  // ID for miniPCI
> #define PEAK_PC104PLUS_ID    0x0006  // ID for new PC-104 Plus
> #define PEAK_PC104E_ID       0x0007  // ID for PC-104 Express
> #define PEAK_MINIPCIE_ID     0x0008  // ID for miniPCIe Slot cards
> 
> 
> Is there any reason why these all shouldn't also be in Xenomai's version?

If those cards are compatible with the ones we already support, you can
go ahead and send a patch to add the IDs to Xenomai's driver. But I
would first cross-check with the kernel commits that added support for
them, if more was changed.

Jan

-- 
Siemens AG, Corporate Technology, CT RTC ITP SDP-DE
Corporate Competence Center Embedded Linux

