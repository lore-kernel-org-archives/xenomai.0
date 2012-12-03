Message-ID: <50BC646C.9050403@grandegger.com>
Date: Mon, 03 Dec 2012 09:35:56 +0100
From: Wolfgang Grandegger <wg@grandegger.com>
MIME-Version: 1.0
References: <CADy-PFjUiqnyaP5_1T934OLZQPU2NvNZnZj1uEG3MJvzKhgALQ@mail.gmail.com>
	<5069E424.9090500@grandegger.com>
	<CADy-PFjCScUGXgUebJj9a6arhZ6mRCnJPuwE3kHT=XcjkY0SpA@mail.gmail.com>
	<CADy-PFjg9NuOLte1CzoMFs3u+_cPUXE5xu7fzfDOug-qz0sQbg@mail.gmail.com>
	<50B4EF81.50307@grandegger.com>
	<CADy-PFjLCRbPc8MuYYsqEoEPXOuWNurzoG6nKaZFF_2+hQUoEw@mail.gmail.com>
	<50B6619A.10300@grandegger.com>
	<CADy-PFjz_CeJ7-RC8xfr5PLrMcKH6sFTJP56z4ULKL8sS_q-VA@mail.gmail.com>
	<CADy-PFitssGjMPVhWi5bCPHDMqvNPxvyZE68J0QjyLL4pwMd8A@mail.gmail.com>
In-Reply-To: <CADy-PFitssGjMPVhWi5bCPHDMqvNPxvyZE68J0QjyLL4pwMd8A@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] RTDM and PEAK PCIe
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Jonathan Bohren <jonathan.bohren@gmail.com>
Cc: "Xenomai@xenomai.org" <Xenomai@xenomai.org>

On 12/03/2012 06:28 AM, Jonathan Bohren wrote:
> Anything else I need to do for the QA process?

Ah, yes, I just realized that the mail did not go to the list. I
re-added it. Please resend the patch. You can add my
"Acked-by: Wolfgang Grandegger <wg@grandegger.com>".

Wolfgang.

> On Wed, Nov 28, 2012 at 2:53 PM, Jonathan Bohren
> <jonathan.bohren@gmail.com>wrote:
> 
>> On Wed, Nov 28, 2012 at 2:10 PM, Wolfgang Grandegger <wg@grandegger.com>
>> wrote:
>>> Thanks, just your Signed-off-by is missing.
>>
>> Ah, here you go:
>>
>>
>> From d97ee63e108c3f6eff26368af0df3ba1d1050692 Mon Sep 17 00:00:00 2001
>> From: Jonathan Bohren <jbo@jhu.edu>
>> Date: Tue, 27 Nov 2012 09:13:11 -0500
>> Subject: [PATCH] Adding device ID for PEAK PCIe card IPEH-003027
>> Signed-off-by: Jonathan Bohren <jbo@jhu.edu>
>> ---
>>  ksrc/drivers/can/sja1000/rtcan_peak_pci.c |    4 +++-
>>  1 file changed, 3 insertions(+), 1 deletion(-)
>>
>> diff --git a/ksrc/drivers/can/sja1000/rtcan_peak_pci.c
>> b/ksrc/drivers/can/sja1000/rtcan_peak_pci.c
>> index 53c8fef..b5ad226 100644
>> --- a/ksrc/drivers/can/sja1000/rtcan_peak_pci.c
>> +++ b/ksrc/drivers/can/sja1000/rtcan_peak_pci.c
>> @@ -71,13 +71,15 @@ struct rtcan_peak_pci
>>  #define PITA_MISC        0x1C        // miscellanoes register
>>
>>  #define PEAK_PCI_VENDOR_ID   0x001C  // the PCI device and vendor IDs
>> -#define PEAK_PCI_DEVICE_ID   0x0001
>> +#define PEAK_PCI_DEVICE_ID   0x0001  // Device ID for PCI and older PCIe
>> cards
>> +#define PEAK_PCIE_DEVICE_ID  0x0003  // Device ID for newer PCIe
>> cards (IPEH-003027)
>>
>>  #define PCI_CONFIG_PORT_SIZE 0x1000  // size of the config io-memory
>>  #define PCI_PORT_SIZE        0x0400  // size of a channel io-memory
>>
>>  static struct pci_device_id peak_pci_tbl[] = {
>>   {PEAK_PCI_VENDOR_ID, PEAK_PCI_DEVICE_ID, PCI_ANY_ID, PCI_ANY_ID, 0, 0,
>> 0},
>> + {PEAK_PCI_VENDOR_ID, PEAK_PCIE_DEVICE_ID, PCI_ANY_ID, PCI_ANY_ID, 0, 0,
>> 0},
>>   { }
>>  };
>>  MODULE_DEVICE_TABLE (pci, peak_pci_tbl);
>> --
>> 1.7.9.5
>>
> 
> 
> 


