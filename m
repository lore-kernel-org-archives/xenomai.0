Message-ID: <50EC908A.1090906@uqconnect.edu.au>
Date: Tue, 8 Jan 2013 22:32:58 +0100
From: David Butterworth <david.butterworth@uqconnect.edu.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [Xenomai] Peak CAN Device IDs and using Peak PCAN-PC/104-Express
Reply-To: david.butterworth@uqconnect.edu.au
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Xenomai <xenomai@xenomai.org>

Hi all,

Firstly, the current RT-Socket-CAN driver looks like it has 2 Device IDs 
for Peak PCI:
0x0001
0x0003

Why was 0x0002 for PCI ExpressCard removed?

Comparing this to Peak's driver, which has Device IDs:
#define PEAK_PCI_VENDOR_ID   0x001C  // the PCI device and vendor IDs
#define PEAK_PCI_DEVICE_ID   0x0001  // ID for PCI / PCIe Slot cards
#define PEAK_PCIE_CARD_ID    0x0002  // ID for PCIExpress Card
#define PEAK_PCIE_DEVICE_ID  0x0003  // ID for new PCIe Slot cards
#define PEAK_CPCI_ID         0x0004  // ID for new cPCI
#define PEAK_MINIPCI_ID      0x0005  // ID for miniPCI
#define PEAK_PC104PLUS_ID    0x0006  // ID for new PC-104 Plus
#define PEAK_PC104E_ID       0x0007  // ID for PC-104 Express
#define PEAK_MINIPCIE_ID     0x0008  // ID for miniPCIe Slot cards

We already have the PC/104-Plus card working with ID 0x0001.
** So what is the "new" ID 0x0006?

** We bought a PC/104-Express card.  Has anyone tested this?  Can we 
just add the ID 0x0007?

Thanks,
David.


