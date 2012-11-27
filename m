MIME-Version: 1.0
In-Reply-To: <50B4EF81.50307@grandegger.com>
References: <CADy-PFjUiqnyaP5_1T934OLZQPU2NvNZnZj1uEG3MJvzKhgALQ@mail.gmail.com>
	<5069E424.9090500@grandegger.com>
	<CADy-PFjCScUGXgUebJj9a6arhZ6mRCnJPuwE3kHT=XcjkY0SpA@mail.gmail.com>
	<CADy-PFjg9NuOLte1CzoMFs3u+_cPUXE5xu7fzfDOug-qz0sQbg@mail.gmail.com>
	<50B4EF81.50307@grandegger.com>
From: Jonathan Bohren <jonathan.bohren@gmail.com>
Date: Tue, 27 Nov 2012 12:08:50 -0500
Message-ID: <CADy-PFjLCRbPc8MuYYsqEoEPXOuWNurzoG6nKaZFF_2+hQUoEw@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Subject: Re: [Xenomai] RTDM and PEAK PCIe
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Wolfgang Grandegger <wg@grandegger.com>
Cc: Simon Leonard <simon.v.leonard@gmail.com>, xenomai@xenomai.org

On Tue, Nov 27, 2012 at 11:51 AM, Wolfgang Grandegger <wg@grandegger.com> wrote:
> On 11/27/2012 03:33 PM, Jonathan Bohren wrote:
>> Wolfgang,
>>
>> I got the PEAK PCAN-003027 card working yesterday, but it required
>> adding the device ID (0x0003 in addition to 0x0001) to the module
>> device table `peak_pci_tbl` here:
>> http://git.xenomai.org/?p=xenomai-2.6.git;a=blob;f=ksrc/drivers/can/sja1000/rtcan_peak_pci.c;h=53c8fef71d6d9e71dce6001941cb5922f6c977d6;hb=HEAD#l79
>>
>> I've committed my changes to a fork on github under the branch name
>> "feature_peak_pcie" here:
>> https://github.com/jbohren-forks/xenomai/compare/feature_peak_pcie
>>
>> Is this the appropriate channel to make a pull request, or should I do
>> that somewhere else?
>
> Just post the patch here on this mailing list.
>
> Wolfgang.
>


Here you go:


>From d97ee63e108c3f6eff26368af0df3ba1d1050692 Mon Sep 17 00:00:00 2001
From: Jonathan Bohren <jbo@jhu.edu>
Date: Tue, 27 Nov 2012 09:13:11 -0500
Subject: [PATCH] Adding device ID for PEAK PCIe card IPEH-003027

---
 ksrc/drivers/can/sja1000/rtcan_peak_pci.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/ksrc/drivers/can/sja1000/rtcan_peak_pci.c
b/ksrc/drivers/can/sja1000/rtcan_peak_pci.c
index 53c8fef..b5ad226 100644
--- a/ksrc/drivers/can/sja1000/rtcan_peak_pci.c
+++ b/ksrc/drivers/can/sja1000/rtcan_peak_pci.c
@@ -71,13 +71,15 @@ struct rtcan_peak_pci
 #define PITA_MISC        0x1C        // miscellanoes register

 #define PEAK_PCI_VENDOR_ID   0x001C  // the PCI device and vendor IDs
-#define PEAK_PCI_DEVICE_ID   0x0001
+#define PEAK_PCI_DEVICE_ID   0x0001  // Device ID for PCI and older PCIe cards
+#define PEAK_PCIE_DEVICE_ID  0x0003  // Device ID for newer PCIe
cards (IPEH-003027)

 #define PCI_CONFIG_PORT_SIZE 0x1000  // size of the config io-memory
 #define PCI_PORT_SIZE        0x0400  // size of a channel io-memory

 static struct pci_device_id peak_pci_tbl[] = {
  {PEAK_PCI_VENDOR_ID, PEAK_PCI_DEVICE_ID, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0},
+ {PEAK_PCI_VENDOR_ID, PEAK_PCIE_DEVICE_ID, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0},
  { }
 };
 MODULE_DEVICE_TABLE (pci, peak_pci_tbl);
--
1.7.9.5

